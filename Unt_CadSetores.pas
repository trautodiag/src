unit Unt_CadSetores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, Mask, DBCtrls, Unit_DM, db;

type
  TF_CadSetores = class(TF_BaseCad)
    lbl_cod: TLabel;
    lbl_Descricao: TLabel;
    dbedt_SET_Cod: TDBEdit;
    dbedt_SET_Nome: TDBEdit;
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function ValidaCadastro: Boolean;
    procedure SetStatus;    
  public
    { Public declarations }
  end;

var
  F_CadSetores: TF_CadSetores;

implementation

{$R *.dfm}

procedure TF_CadSetores.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_setor.Cancel;
  inherited;
end;

procedure TF_CadSetores.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_setorData.AsDateTime:= Now;
      DM.cds_setor.Post;
      inherited;
    end;
end;

procedure TF_CadSetores.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    dbedt_SET_Nome.SetFocus;
end;

procedure TF_CadSetores.SetStatus;
begin
  AnStatus:= DM.cds_setor.State;
end;

function TF_CadSetores.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_SET_Nome.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_SET_Nome.SetFocus;
      Exit;
    end;
end;

end.
