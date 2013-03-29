unit Unt_UpDown;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter, cxPC, ExtCtrls, ImgList,
  dxGDIPlusClasses, Unt_Util;

type
  TF_UpDown = class(TForm)
    il_base: TImageList;
    pgcntrl_base: TcxPageControl;
    tab_base: TcxTabSheet;
    img_base: TImage;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure img_baseClick(Sender: TObject);
    procedure img_baseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img_baseMouseLeave(Sender: TObject);
  private
    FOutHandle: THandle;
    FClick: Boolean;
    procedure SetOutHandle(const Value: THandle);
    procedure SetClick(const Value: Boolean);
    { Private declarations }
  public
    { Public declarations }
  published
    property OutHandle: THandle read FOutHandle write SetOutHandle;
    property Click: Boolean read FClick write SetClick default False;
  end;

var
  F_UpDown: TF_UpDown;

implementation

{$R *.dfm}

procedure TF_UpDown.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  Self:= nil;
end;

procedure TF_UpDown.FormCreate(Sender: TObject);
begin
  FClick:= False;
end;

procedure TF_UpDown.FormShow(Sender: TObject);
begin
  il_base.GetIcon(1, img_base.Picture.Icon);
  ShowWindow(Application.Handle, SW_HIDE);
  img_base.Hint:= 'Esconder ferramentas';
end;

procedure TF_UpDown.img_baseClick(Sender: TObject);
begin
  Click:= not Click;
  if Click then
    begin
      SendMessage(OutHandle, WM_UP, 0, 0);
      il_base.GetIcon(0, img_base.Picture.Icon);
      img_base.Hint:= 'Mostrar ferramentas';
    end
  else
    begin
      SendMessage(OutHandle, WM_NOTUP, 0, 0);
      il_base.GetIcon(1, img_base.Picture.Icon);
      img_base.Hint:= 'Esconder ferramentas';
    end;
end;

procedure TF_UpDown.img_baseMouseLeave(Sender: TObject);
begin
  //Self.AlphaBlendValue:= 150;
end;

procedure TF_UpDown.img_baseMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  //Self.AlphaBlendValue:= 255;
end;

procedure TF_UpDown.SetClick(const Value: Boolean);
begin
  FClick := Value;
end;

procedure TF_UpDown.SetOutHandle(const Value: THandle);
begin
  FOutHandle := Value;
end;

end.
