unit Unt_CadAgendaCompromisso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, db, Unit_DM, Mask, DBCtrls,
  cxContainer, cxEdit, cxMemo, cxDBEdit, cxSpinEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, cxCheckBox, Unt_Util, Unt_CadAnArquivo, DBClient;

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
    btn_VincularArq: TcxButton;
    act_VincularArq: TAction;
    procedure FormShow(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure dbedt_AGC_HoraKeyPress(Sender: TObject; var Key: Char);
    procedure act_VincularArqExecute(Sender: TObject);
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

procedure TF_CadAgendaCompromisso.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_AgendaCompromisso.Cancel;
  inherited;
end;

procedure TF_CadAgendaCompromisso.act_SalvarExecute(Sender: TObject);
var
  OutHandleIni: THandle;
begin
  if ValidaCadastro then
    begin
      DM.cds_AgendaCompromissoAGC_Alerta.asBoolean:= False;
      DM.cds_AgendaCompromissoData.AsDateTime:= Now;
      DM.cds_AgendaCompromisso.Post;
      OutHandleIni:= FindWindow('TF_ProtocoloIni',nil);
      SendMessage(OutHandleIni, WM_SALVO, 0, 0);
      OutHandleIni:= FindWindow('TF_Sobre',nil);
      SendMessage(OutHandleIni, WM_SALVO, 0, 0);
      inherited;
    end;
end;

procedure TF_CadAgendaCompromisso.act_VincularArqExecute(Sender: TObject);
begin
  inherited;
  with TClientDataSet.Create(nil) do
    begin
      try
        Data:= TF_CadAnArquivo.IniciaPesquisaArquivo;
        DM.cds_AgendaCompromisso.FieldByName('AGC_ARQ_Cod').AsInteger:= FieldByName('Codigo').AsInteger;
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
    cbb_AGC_Data.Date:= Date;
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

end.
