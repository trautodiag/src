unit Unt_CadEmpresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  Menus, ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, Unit_DM, db,
  cxContainer, cxEdit, cxImage, cxDBEdit, DBCtrls, Mask;

type
  TF_CadEmpresas = class(TF_BaseCad)
    lbl_cod: TLabel;
    dbedt_EMP_Cod: TDBEdit;
    lbl_Descricao: TLabel;
    dbedt_EMP_Nome: TDBEdit;
    Label1: TLabel;
    dbedt_EMP_FoneFax: TDBEdit;
    lbl_logradouro: TLabel;
    dbedt_EMP_Logradouro: TDBEdit;
    lbl_numero: TLabel;
    dbedt_EMP_Numero: TDBEdit;
    lbl_cidade: TLabel;
    dbedt_EMP_Cidade: TDBEdit;
    lbl_UF: TLabel;
    dbcbb_EMP_UF: TDBComboBox;
    lbl_CEP: TLabel;
    dbedt_EMP_CEP: TDBEdit;
    lbl_atencao: TLabel;
    dbedt_atencao: TDBEdit;
    lbl_Url: TLabel;
    dbedt_EMP_Url: TDBEdit;
    lbl_Logo: TLabel;
    img_EMP_Logo: TcxDBImage;
    procedure FormShow(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure dbedt_EMP_NumeroKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    function ValidaCadastro: Boolean;
    procedure SetStatus;      
  public
    { Public declarations }
  end;

var
  F_CadEmpresas: TF_CadEmpresas;

implementation

{$R *.dfm}

procedure TF_CadEmpresas.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_empresa.Cancel;
  inherited;
end;

procedure TF_CadEmpresas.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_empresaData.AsDateTime:= Now;
      DM.cds_empresa.Post;
      inherited;
    end;
end;

procedure TF_CadEmpresas.dbedt_EMP_NumeroKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_CadEmpresas.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    dbedt_EMP_Nome.SetFocus;
end;

procedure TF_CadEmpresas.SetStatus;
begin
  AnStatus:= DM.cds_empresa.State;
end;

function TF_CadEmpresas.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_EMP_Nome.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_EMP_Nome.SetFocus;
      Exit;
    end;
end;

end.
