unit Unt_CadAgendaCompromisso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, db, Unit_DM, Mask, DBCtrls,
  cxContainer, cxEdit, cxMemo, cxDBEdit, cxSpinEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCheckBox, Unt_Util, Unt_CadAnArquivo, DBClient,
  dxSkinOffice2007Blue, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid;

type
  TF_CadAgendaCompromisso = class(TF_BaseCad)
    lbl_cod: TLabel;
    dbedt_AGC_Cod: TDBEdit;
    lbl_Descricao: TLabel;
    dbedt_AGC_Descricao: TDBEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    lbl_vencimento: TLabel;
    cbb_AGC_Data: TcxDBDateEdit;
    lbl_numero: TLabel;
    dbspndt_AGC_Hora: TcxDBSpinEdit;
    lbl_Minuto: TLabel;
    dbspndt_AGC_Minuto: TcxDBSpinEdit;
    lbl_Obs: TLabel;
    dbm_AGC_Observacao: TcxDBMemo;
    act_VincularArq: TAction;
    btn_VincularArq: TcxButton;
    pnl_ArquivosVinculados: TPanel;
    pnl_inserir: TPanel;
    act_ExcluirArquivo: TAction;
    btn_novovinculo: TcxButton;
    btn_ExcluirArqAcao: TcxButton;
    grid_base: TcxGrid;
    vwl_base: TcxGridDBTableView;
    tbl_base: TcxGridLevel;
    vwl_baseColumn1: TcxGridDBColumn;
    cds_ArqAcao: TClientDataSet;
    ds_ArqAcao: TDataSource;
    act_abriVinculo: TAction;
    ds_Arquivo: TDataSource;
    cds_Arquivo: TClientDataSet;
    cxDBCheckBox2: TcxDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure dbedt_AGC_HoraKeyPress(Sender: TObject; var Key: Char);
    procedure act_VincularArqExecute(Sender: TObject);
    procedure act_ExcluirArquivoExecute(Sender: TObject);
    procedure act_abriVinculoExecute(Sender: TObject);
    procedure vwl_baseColumn1GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure FormResize(Sender: TObject);
    procedure ds_ArqAcaoStateChange(Sender: TObject);
  private
    { Private declarations }
    FSobre: Boolean;
    function ValidaCadastro: Boolean;
    procedure SetStatus;
  public
    class procedure IniciaCad(AHandle: THandle; const AAtivo: Boolean = true; const AData: TDate = 0);
    { Public declarations }
  end;

var
  F_CadAgendaCompromisso: TF_CadAgendaCompromisso;

implementation

{$R *.dfm}

procedure TF_CadAgendaCompromisso.act_abriVinculoExecute(Sender: TObject);
begin
  inherited;
  pnl_ArquivosVinculados.Visible:= TAction(Sender).Checked;
  if not pnl_ArquivosVinculados.Visible then
    Self.Height:= Self.Height - pnl_ArquivosVinculados.Height
  else
    begin
      Self.Height:= Self.Height + pnl_ArquivosVinculados.Height;
      pnl_Base.Align:= alBottom;
    end;

  Self.Top:= (Screen.Height - Self.Height) div 2;
end;

procedure TF_CadAgendaCompromisso.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_AgendaCompromisso.Cancel;
  inherited;
end;

procedure TF_CadAgendaCompromisso.act_ExcluirArquivoExecute(Sender: TObject);
begin
  inherited;
  cds_ArqAcao.Delete;
end;

procedure TF_CadAgendaCompromisso.act_SalvarExecute(Sender: TObject);
var
  OutHandleIni: THandle;
begin
  if ValidaCadastro then
    begin
      DM.cds_AgendaCompromissoAGC_Alerta.asBoolean:= False;
      DM.cds_AgendaCompromissoAGC_Status.asBoolean:= False;
      DM.cds_AgendaCompromissoData.AsDateTime:= Now;
      DM.cds_AgendaCompromisso.Post;

      if (not cds_ArqAcao.IsEmpty) or (cds_ArqAcao.ChangeCount > 0) then
        begin
          cds_ArqAcao.First;
          while not cds_ArqAcao.Eof do
            begin
              if Not DM.cds_acoesAgComp.Locate('AAC_AGC_Cod;AAC_ARQ_Cod', VarArrayOf([cds_ArqAcao.FieldByName('AAC_AGC_Cod').AsInteger, cds_ArqAcao.FieldByName('AAC_ARQ_Cod').AsInteger]), []) then
                begin
                  DM.cds_acoesAgComp.Insert;
                  DM.cds_acoesAgComp.FieldByName('AAC_AGC_Cod').AsInteger:= cds_ArqAcao.FieldByName('AAC_AGC_Cod').AsInteger;
                  DM.cds_acoesAgComp.FieldByName('AAC_ARQ_Cod').AsInteger:= cds_ArqAcao.FieldByName('AAC_ARQ_Cod').AsInteger;
                  DM.cds_acoesAgComp.Post;
                end;
              cds_ArqAcao.Next;
            end;
        end;
      SendMessage(OutHandle, WM_SALVOV, 0, 0);
      OutHandleIni:= FindWindow('TF_ProtocoloIni',nil);
      SendMessage(OutHandleIni, WM_SALVO, 0, 0);
      OutHandleIni:= FindWindow('TF_Sobre',nil);
      SendMessage(OutHandleIni, WM_SALVO, 0, 0);
      inherited;
    end;
end;

procedure TF_CadAgendaCompromisso.act_VincularArqExecute(Sender: TObject);
var
  filtro: string;
begin
  inherited;
  with TClientDataSet.Create(nil) do
    begin
      try
        Data:= TF_CadAnArquivo.IniciaPesquisaArquivo;
        //DM.cds_AgendaCompromisso.FieldByName('AGC_ARQ_Cod').AsInteger:= FieldByName('Codigo').AsInteger;
        if FieldByName('Codigo').AsInteger <> 0 then
          begin
            filtro:= cds_ArqAcao.Filter;
            cds_ArqAcao.Filtered:= False;
            cds_ArqAcao.Insert;
            //cds_ArqAcao.FieldByName('AAC_Cod').AsInteger:= cds_ArqAcao.RecordCount; //Para nao erro
            cds_ArqAcao.FieldByName('AAC_AGC_Cod').AsInteger:= StrToInt(dbedt_AGC_Cod.Text);
            cds_ArqAcao.FieldByName('AAC_ARQ_Cod').AsInteger:= FieldByName('Codigo').AsInteger;
            cds_ArqAcao.Post;
            cds_ArqAcao.Filter:= filtro;
            cds_ArqAcao.Filtered:= True;
          end;
      finally
        Free;
      end;
    end;
end;

procedure TF_CadAgendaCompromisso.dbedt_AGC_HoraKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_CadAgendaCompromisso.ds_ArqAcaoStateChange(Sender: TObject);
begin
  inherited;
  act_ExcluirArquivo.Enabled:= (cds_ArqAcao.RecordCount > 0) and (DM.cds_AgendaCompromisso.State in dsEditModes);  
end;

procedure TF_CadAgendaCompromisso.FormResize(Sender: TObject);
begin
  inherited;
  pnl_ArquivosVinculados.Align:= alNone;
  pnl_Base.Align:= alBottom;
  pnl_ArquivosVinculados.Align:= alBottom;
end;

procedure TF_CadAgendaCompromisso.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    begin
      dbedt_AGC_Descricao.SetFocus;
      act_VincularArq.Enabled:= True;
    end;
  if (AnStatus = dsInsert) and (not FSobre) then
    begin
      cbb_AGC_Data.Date:= Date;
      DM.cds_AgendaCompromissoAGC_ArqExec.asBoolean:= False;
    end;

  cds_Arquivo.Data:= DM.cds_arquivo.Data;
  cds_ArqAcao.Data:= DM.cds_acoesAgComp.Data;
  cds_ArqAcao.Filtered:= False;
  cds_ArqAcao.Filter:= 'AAC_AGC_Cod = '+Trim(dbedt_AGC_Cod.Text);
  cds_ArqAcao.Filtered:= True;

  if cds_ArqAcao.IsEmpty then
    Self.Height:= Self.Height - pnl_ArquivosVinculados.Height
  else
    pnl_ArquivosVinculados.Visible:= True;
end;

class procedure TF_CadAgendaCompromisso.IniciaCad(AHandle: THandle;
  const AAtivo: Boolean; const AData: TDate);
var
  i: Integer;
begin
  with Self.Create(application) do
    begin
      FSobre:= True;
      try
        OutHandle:= AHandle;
        if not AAtivo then
          begin
            for I := 0 to ComponentCount - 1 do
              if Components[i].InheritsFrom(TControl) then
                TControl(Components[i]).Enabled:= False;
          end;
        DM.cds_AgendaCompromisso.Insert;
        DM.cds_AgendaCompromissoAGC_Data.AsDateTime:= AData;
        cbb_AGC_Data.Enabled:= False;
        showmodal;
      finally
        Free;
      end;
    end;
end;

procedure TF_CadAgendaCompromisso.SetStatus;
begin
  AnStatus:= DM.cds_AgendaCompromisso.State;
end;

function TF_CadAgendaCompromisso.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_AGC_Descricao.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_AGC_Descricao.SetFocus;
      Exit;
    end;

  if (cbb_AGC_Data.Date < Date) or (cbb_AGC_Data.EditValue = null) then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      cbb_AGC_Data.SetFocus;
      Exit;
    end;
end;

procedure TF_CadAgendaCompromisso.vwl_baseColumn1GetDisplayText(
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

end.
