unit Unt_FuncoesPredefinidas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2007Blue, dxSkinscxPCPainter, Menus, StdCtrls,
  cxButtons, ExtCtrls, cxPC, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxImageComboBox;

type
  TF_FuncoesPredefinidas = class(TForm)
    cxPageControl1: TcxPageControl;
    tab_funcoes: TcxTabSheet;
    pnl_base: TPanel;
    btn_Canc: TcxButton;
    btn_Ok: TcxButton;
    lbl_fincao: TLabel;
    img_funcoes: TcxImageComboBox;
    procedure btn_CancClick(Sender: TObject);
    procedure btn_OkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    class function Inicia: Integer;
  end;

var
  F_FuncoesPredefinidas: TF_FuncoesPredefinidas;

implementation

{$R *.dfm}

{ TF_FuncoesPredefinidas }

procedure TF_FuncoesPredefinidas.btn_CancClick(Sender: TObject);
begin
  Close;
end;

procedure TF_FuncoesPredefinidas.btn_OkClick(Sender: TObject);
begin
  Close;
end;

class function TF_FuncoesPredefinidas.Inicia: Integer;
begin
  with Self.Create(Application) do
    begin
      try
        ShowModal;
      finally
        if img_funcoes.EditValue = null then
          Result:= 0
        else
          Result:= Integer(img_funcoes.EditValue);
        Free;
      end;
    end;
end;

end.
