unit Unt_CadClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, Unit_DM, Mask, DBCtrls,
  cxContainer, cxEdit, cxCheckBox, cxDBEdit, db;

type
  TF_CadClientes = class(TF_BaseCad)
    lbl_cod: TLabel;
    lbl_Descricao: TLabel;
    dbedt_CLI_Cod: TDBEdit;
    dbedt_CLI_Nome: TDBEdit;
    Label1: TLabel;
    dbedt_CLI_FoneFax: TDBEdit;
    lbl_logradouro: TLabel;
    dbedt_Logradouro: TDBEdit;
    lbl_numero: TLabel;
    dbedt_numero: TDBEdit;
    dbedt_cidade: TDBEdit;
    lbl_cidade: TLabel;
    lbl_UF: TLabel;
    dbcbb_UF: TDBComboBox;
    lbl_CEP: TLabel;
    dbedt_CEP: TDBEdit;
    lbl_atencao: TLabel;
    dbedt_atencao: TDBEdit;
    cxDBCheckBox1: TcxDBCheckBox;
    procedure FormShow(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure dbedt_numeroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function ValidaCadastro: Boolean;
    procedure SetStatus;      
  public
    { Public declarations }
  end;

var
  F_CadClientes: TF_CadClientes;

implementation

{$R *.dfm}

procedure TF_CadClientes.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_clientes.Cancel;
  inherited;
end;

procedure TF_CadClientes.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_clientesData.AsDateTime:= Now;
      DM.cds_clientes.Post;
      inherited;
    end;
end;

procedure TF_CadClientes.dbedt_numeroKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_CadClientes.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    dbedt_CLI_Nome.SetFocus;
end;

procedure TF_CadClientes.SetStatus;
begin
  AnStatus:= DM.cds_clientes.State;
end;

function TF_CadClientes.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_CLI_Nome.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_CLI_Nome.SetFocus;
      Exit;
    end;
end;

end.
