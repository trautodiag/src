unit Unt_CadAnAgendaCompromisso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, DBClient, ImgList, ActnList, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, StdCtrls, cxTextEdit, cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls,
  cxPC, Unit_DM, Unt_CadAgendaCompromisso, DateUtils, VarUtils,
  dxSkinOffice2007Blue, Unt_Util;

type
  TF_CadAnAgendaCompromisso = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    vwl_baseColumn4: TcxGridDBColumn;
    stylo_verde: TcxStyle;
    stylo_vermelho: TcxStyle;
    vwl_baseColumn5: TcxGridDBColumn;
    tbl_associacao: TcxGridLevel;
    vwl_associacao: TcxGridDBTableView;
    cds_associacao: TClientDataSet;
    ds_associacao: TDataSource;
    vwl_associacaoColumn1: TcxGridDBColumn;
    cds_Arquivo: TClientDataSet;
    ds_Arquivo: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure vwl_baseCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure FormShow(Sender: TObject);
    procedure vwl_associacaoColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    { Private declarations }
    procedure AtualizaResgistrosAss(var Msg: TMessage); message WM_SALVOV;
  public
    { Public declarations }
    procedure DblClica(Sender: TObject); override;
  end;

var
  F_CadAnAgendaCompromisso: TF_CadAnAgendaCompromisso;

implementation

{$R *.dfm}

procedure TF_CadAnAgendaCompromisso.act_EditarExecute(Sender: TObject);
begin
  inherited;
  TF_CadAgendaCompromisso.Inicia(Self.Handle); 
end;

procedure TF_CadAnAgendaCompromisso.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
      end;
end;

procedure TF_CadAnAgendaCompromisso.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadAgendaCompromisso.Inicia(Self.Handle);
end;

procedure TF_CadAnAgendaCompromisso.AtualizaResgistrosAss(var Msg: TMessage);
begin
  cds_associacao.Data:= DM.cds_acoesAgComp.Data;
  cds_associacao.IndexFieldNames:= 'AAC_AGC_Cod';
  cds_Arquivo.Data:= DM.cds_arquivo.Data;
end;

procedure TF_CadAnAgendaCompromisso.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadAgendaCompromisso.Inicia(Self.Handle, False);
end;

procedure TF_CadAnAgendaCompromisso.FormCreate(Sender: TObject);
begin
  SetInformacoes(DM.cds_AgendaCompromisso, 'AGC_Descricao', 'AGC_Cod', 'Data');
  inherited;
end;

procedure TF_CadAnAgendaCompromisso.FormShow(Sender: TObject);
begin
  inherited;
  cds_associacao.Data:= DM.cds_acoesAgComp.Data;
  cds_associacao.IndexFieldNames:= 'AAC_AGC_Cod';
  cds_Arquivo.Data:= DM.cds_arquivo.Data;
end;

procedure TF_CadAnAgendaCompromisso.vwl_associacaoColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_Arquivo.Filtered:= False;
      cds_Arquivo.Filter:= 'ARQ_Cod =' +AText;
      cds_Arquivo.Filtered:= True;
      if not cds_Arquivo.IsEmpty then
        AText:= cds_Arquivo.FieldByName('ARQ_Nome').AsString
      else
        AText:= 'Arquivo/Ação não identificado';
    end
  else
    AText:= 'Arquivo/Ação não identificado';
end;

procedure TF_CadAnAgendaCompromisso.vwl_baseCustomDrawCell(
  Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  if not cds_dados.IsEmpty then
    begin
      if (AViewInfo.GridRecord.Values[vwl_baseColumn2.Index] <> null) and
         (AViewInfo.GridRecord.Values[vwl_baseColumn3.Index] <> null) and
         (AViewInfo.GridRecord.Values[vwl_baseColumn4.Index] <> null) and
         (AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] <> null)  then
        begin
          if AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] = True then
            ACanvas.Font.Color:= clGreen
          else if ((not (AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] = True)) and
            (EncodeDateTime(YearOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                            MonthOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                            DayOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                            AViewInfo.GridRecord.Values[vwl_baseColumn3.Index],
                            AViewInfo.GridRecord.Values[vwl_baseColumn4.Index],
                            0,
                            0) < Now)) or (AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] = null) then
            ACanvas.Font.Color:= clRed
          else
            ACanvas.Font.Color:= clBlack;
        end;
    end;
end;

end.
