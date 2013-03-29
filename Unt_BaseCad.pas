unit Unt_BaseCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ActnList, Unit_DM, Unt_Util, db,
  dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxButtons, cxPC, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TF_BaseCad = class(TForm)
    act_cadastros: TActionList;
    act_Salvar: TAction;
    act_Cancelar: TAction;
    pgctrl_base: TcxPageControl;
    ts_base: TcxTabSheet;
    pnl_Base: TPanel;
    btn_Salvar: TcxButton;
    btn_Cancelar: TcxButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
  private
    FAnStatus: TDataSetState;
    procedure SetAnStatus(const Value: TDataSetState);
    { Private declarations }
  public
    { Public declarations }
    class procedure Inicia(AHandle: THandle; const AAtivo: Boolean = true);
  protected
    OutHandle: THandle;
    function ValidaCadastro: Boolean; virtual;abstract;
    procedure SetStatus; virtual;abstract;
  published
    property AnStatus: TDataSetState read FAnStatus write SetAnStatus;
  end;

var
  F_BaseCad: TF_BaseCad;

implementation

{$R *.dfm}

procedure TF_BaseCad.act_CancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TF_BaseCad.act_SalvarExecute(Sender: TObject);
begin
  case AnStatus of
    dsInactive: ;
    dsBrowse: ;
    dsEdit:   SendMessage(OutHandle, WM_SALVO, 0, DWORD(cs_AnEdit));
    dsInsert: SendMessage(OutHandle, WM_SALVO, 0, DWORD(cs_AnInsert));
    dsSetKey: ;
    dsCalcFields: ;
    dsFilter: ;
    dsNewValue: ;
    dsOldValue: ;
    dsCurValue: ;
    dsBlockRead: ;
    dsInternalCalc: ;
    dsOpening: ;
  end;
  Close;
end;

procedure TF_BaseCad.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
    Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    End;
end;

class procedure TF_BaseCad.Inicia(AHandle: THandle; const AAtivo: Boolean);
var
  i: Integer;
begin
  with Self.Create(application) do
    begin
      try
        OutHandle:= AHandle;
        if not AAtivo then
          begin
            for I := 0 to ComponentCount - 1 do
              if Components[i].InheritsFrom(TControl) then
                TControl(Components[i]).Enabled:= False;
          end;
        showmodal;
      finally
        Free;
      end;
    end;
end;

procedure TF_BaseCad.SetAnStatus(const Value: TDataSetState);
begin
  FAnStatus := Value;
end;

end.
