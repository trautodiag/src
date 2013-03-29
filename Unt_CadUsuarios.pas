unit Unt_CadUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, Unit_DM, Mask, DBCtrls, db,
  cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit,
  cxDBLookupEdit, cxDBLookupComboBox, DBClient, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TF_CadUsuarios = class(TF_BaseCad)
    dbedt_USU_Cod: TDBEdit;
    dbedt_USU_Nome: TDBEdit;
    lbl_cod: TLabel;
    lbl_Descricao: TLabel;
    lbl_setor: TLabel;
    cbb_Setores: TcxDBLookupComboBox;
    cds_setores: TClientDataSet;
    ds_setores: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
  private
    { Private declarations }
    function ValidaCadastro: Boolean;
    procedure SetStatus;    
  public
    { Public declarations }
  end;

var
  F_CadUsuarios: TF_CadUsuarios;

implementation

{$R *.dfm}

{ TF_CadUsuarios }

procedure TF_CadUsuarios.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_usuarios.Cancel;
  inherited;
end;

procedure TF_CadUsuarios.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_usuariosData.AsDateTime:= Now;
      DM.cds_usuarios.Post;
      inherited;
    end;
end;

procedure TF_CadUsuarios.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    dbedt_USU_Nome.SetFocus;

  cds_setores.Data:= DM.cds_setor.Data;    
end;

procedure TF_CadUsuarios.SetStatus;
begin
  AnStatus:= DM.cds_usuarios.State;
end;

function TF_CadUsuarios.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_USU_Nome.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_USU_Nome.SetFocus;
      Exit;
    end;

  if cbb_Setores.EditValue <= 0 then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      cbb_Setores.SetFocus;
      Exit;
    end;
end;

end.
