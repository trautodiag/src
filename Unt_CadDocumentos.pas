unit Unt_CadDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, ActnList, StdCtrls, Buttons, ExtCtrls, Unit_DM, Mask,
  DBCtrls, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, cxPC, db;

type
  TF_CadDocumentos = class(TF_BaseCad)
    lbl_codigo: TLabel;
    dbedt_DOC_Cod: TDBEdit;
    lbl_documento: TLabel;
    dbedt_DOC_Nome: TDBEdit;
    lbl_cod: TLabel;
    lbl_Descricao: TLabel;
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
  F_CadDocumentos: TF_CadDocumentos;

implementation

{$R *.dfm}

{ TF_CadDocumentos }

procedure TF_CadDocumentos.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_documentos.Cancel;
  inherited;
end;

procedure TF_CadDocumentos.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_documentosData.AsDateTime:= Now;
      DM.cds_documentos.Post;
      inherited;
    end;
end;

procedure TF_CadDocumentos.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;
  if (AnStatus = dsEdit) or (AnStatus = dsInsert) then
    dbedt_DOC_Nome.SetFocus;
end;

procedure TF_CadDocumentos.SetStatus;
begin
  AnStatus:= DM.cds_documentos.State;
end;

function TF_CadDocumentos.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_DOC_Nome.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_DOC_Nome.SetFocus;
      Exit;
    end;
end;

end.
