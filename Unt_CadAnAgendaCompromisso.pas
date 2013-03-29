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
  cxPC, Unit_DM, Unt_CadAgendaCompromisso;

type
  TF_CadAnAgendaCompromisso = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    vwl_baseColumn4: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
  private
    { Private declarations }
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

end.
