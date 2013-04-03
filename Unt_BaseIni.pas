unit Unt_BaseIni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ActnMan, ActnCtrls, ActnMenus, Menus, ActnList, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, dxSkinsForm, cxPC,
  StdCtrls, cxButtons, ExtCtrls, dxGDIPlusClasses, ImgList, ShellApi, Unt_Util,
  Unt_Sobre, Unt_UpDown, dxScreenTip, dxCustomHint, cxHint, MidasLib, Registry,
  dxAlertWindow, DB, DBClient;

type
  TTypWinBits = (Bit32, Bit64);

  TF_BaseIni = class(TForm)
    act_Cadastros: TActionList;
    act_CadEmpresa: TAction;
    act_CadClientes: TAction;
    act_CadDocumentos: TAction;
    act_Sair: TAction;
    act_EmiProtocolos: TAction;
    act_RelClientes: TAction;
    act_RelProtocolos: TAction;
    act_RelDocumentos: TAction;
    pgctrl_base: TcxPageControl;
    ts_base: TcxTabSheet;
    skin_base: TdxSkinController;
    pnl_menu: TPanel;
    btn_cadastro: TcxButton;
    pm_cadastros: TPopupMenu;
    mni_act_CadEmpresa: TMenuItem;
    mni_act_CadClientes: TMenuItem;
    mni_act_CadDocumentos: TMenuItem;
    mniN2: TMenuItem;
    mni_act_Sair: TMenuItem;
    pm_rotinas: TPopupMenu;
    mni_act_EmiProtocolos: TMenuItem;
    pm_relatorios: TPopupMenu;
    mni_act_RelClientes: TMenuItem;
    mni_act_RelProtocolos: TMenuItem;
    mni_act_RelDocumentos: TMenuItem;
    pm_ferramentas: TPopupMenu;
    btn_rotinas: TcxButton;
    btn_relatorios: TcxButton;
    btn_ferramentas: TcxButton;
    ac_CadUsuarios: TAction;
    acCadUsuarios1: TMenuItem;
    ac_CadSetores: TAction;
    Cadastrodesetores1: TMenuItem;
    img_base: TImage;
    pm_try: TPopupMenu;
    mni_Cadastros: TMenuItem;
    Cadastrodaempresa1: TMenuItem;
    Cadastrodeusuarios1: TMenuItem;
    Cadastrodesetores2: TMenuItem;
    Cadastrodedocumentos1: TMenuItem;
    Cadastrodeclientes1: TMenuItem;
    Fecharaplicao1: TMenuItem;
    N2: TMenuItem;
    tm_sobre: TTimer;
    hint_base: TcxHintStyleController;
    act_Sobre: TAction;
    act_AgendaCompromisso: TAction;
    Agendadecompromissos2: TMenuItem;
    N3: TMenuItem;
    Sobreaaplicao1: TMenuItem;
    ac_IniciarWindows: TAction;
    N1: TMenuItem;
    Ferramentas1: TMenuItem;
    Agendadecompromissos1: TMenuItem;
    N4: TMenuItem;
    Iniciaraplicaocomowindows1: TMenuItem;
    ac_CaixaCliente: TAction;
    Caixadocliente1: TMenuItem;
    Caixadocliente2: TMenuItem;
    act_ArquivoCliente: TAction;
    Arquivodocliente1: TMenuItem;
    act_AgendaCompCad: TAction;
    alerta_base: TdxAlertWindowManager;
    imgLst_base: TImageList;
    cds_Compromissos: TClientDataSet;
    ilLst_BotoesMess: TImageList;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure act_SairExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_moverMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img_baseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_cadastroMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure btn_cadastroMouseLeave(Sender: TObject);
    procedure tm_sobreTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure act_SobreExecute(Sender: TObject);
    procedure act_AgendaCompromissoExecute(Sender: TObject);
    procedure ac_IniciarWindowsExecute(Sender: TObject);
    procedure ac_CaixaClienteExecute(Sender: TObject);
  private
    { Private declarations }
    //procedure WMSysCommand(var Msg: TWMSysCommand); Message WM_SysCommand;
    procedure WMTrayIcon(var Msg: TMessage); Message WM_TRAYICON;
    procedure DestroyIcone;
    procedure CriaIcone;
    function WinBits: TTypWinBits;
    function CreateConnection: TRegistry;
    procedure RunAdd(aDesc, aName: string);
  public
    { Public declarations }
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  end;

var
  F_BaseIni: TF_BaseIni;

implementation

{$R *.dfm}

procedure TF_BaseIni.RunAdd(aDesc, aName: string);
var
  Reg: TRegistry;
  sRegKey: String;
begin
  sRegKey := 'Software\Microsoft\Windows\CurrentVersion\Run';
  Reg := CreateConnection;
  with Reg do
    begin
      try
        RootKey := HKEY_LOCAL_MACHINE;
        if not KeyExists(sRegKey) then
          OpenKey(sRegKey, True)
        else
          OpenKey(sRegKey, False);
        WriteString(aDesc, aName);
      finally
        CloseKey;
        Free;
      end;
    end;
end;

function TF_BaseIni.CreateConnection: TRegistry;
begin
  Result := TRegistry.Create;
  try
    case WinBits of
      Bit32: Result := TRegistry.Create;
      Bit64: Result := TRegistry.Create(KEY_WRITE OR KEY_WOW64_64KEY);
    end;
  except
    on E: exception do
      Result := nil;
  end;
end;

function TF_BaseIni.WinBits: TTypWinBits;
type
  TIsWow64Process = function(Handle:THandle; var IsWow64 : BOOL) : BOOL; stdcall;
var
  hKernel32 : Integer;
  IsWow64Process : TIsWow64Process;
  IsWow64 : BOOL;
begin
  Result := Bit32;
  hKernel32 := LoadLibrary('kernel32.dll');
  if (hKernel32 = 0) then RaiseLastOSError;
  @IsWow64Process := GetProcAddress(hkernel32, 'IsWow64Process');
  if Assigned(IsWow64Process) then
    begin
      IsWow64 := False;
      if (IsWow64Process(GetCurrentProcess, IsWow64)) then
        Result := Bit64
      else
        RaiseLastOSError;
    end;
  FreeLibrary(hKernel32);
end;

procedure TF_BaseIni.act_AgendaCompromissoExecute(Sender: TObject);
begin
  if F_Sobre <> nil then
    F_Sobre.tab_Calendario.Show;
end;

procedure TF_BaseIni.act_SairExecute(Sender: TObject);
begin
  Close;
end;

procedure TF_BaseIni.act_SobreExecute(Sender: TObject);
begin
  if F_Sobre <> nil then
    F_Sobre.ts_sobre.Show;
end;

procedure TF_BaseIni.ac_CaixaClienteExecute(Sender: TObject);
begin
  if F_Sobre <> nil then
    F_Sobre.ts_CaixaCliente.Show;
end;

procedure TF_BaseIni.ac_IniciarWindowsExecute(Sender: TObject);
var
  S: string;
begin
  try
    S:=ExtractFileDir(Application.ExeName)+'\'+ExtractFileName(Application.ExeName);
    RunAdd('Protocollo', S);
  except
    MessageDlg('Não foi possivel alterar o registro do windows', mtInformation, [mbOK], 0);
  end;
end;

procedure TF_BaseIni.btn_cadastroMouseLeave(Sender: TObject);
begin
  Self.AlphaBlendValue:= 200;
end;

procedure TF_BaseIni.btn_cadastroMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Self.AlphaBlendValue:= 255;
end;

procedure TF_BaseIni.btn_moverMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TF_BaseIni.CreateParams(var Params: TCreateParams);
begin
  SetWindowLong( Application.Handle, Gwl_ExStyle, Ws_Ex_ToolWindow );
  BorderStyle := bsNone;
  inherited CreateParams(Params);
  Params.Style := (Params.Style or WS_POPUP) and not WS_CAPTION;
end;

procedure TF_BaseIni.CriaIcone;
var
  NotifyIconData: TNotifyIconData;
begin
  with NotifyIconData do
    begin
      cbSize:= SizeOf(TNotifyIconData);
      Wnd:= Self.Handle;
      uID:= 0;
      uCallbackMessage:= WM_TRAYICON;
      uFlags:= NIF_ICON or NIF_TIP or NIF_MESSAGE;
      hIcon:= Application.Icon.Handle;
      szTip:= 'Protocollo';
    end;
  Shell_NotifyIcon(NIM_ADD, @NotifyIconData);
  Application.ShowMainForm:= False;
end;

procedure TF_BaseIni.DestroyIcone;
var
  NotifyIconData: TNotifyIconData;
begin
  with NotifyIconData do
    begin
      cbSize:= SizeOf(TNotifyIconData);
      Wnd:= Self.Handle;
      uID:= 0;
      uFlags:= 0;
    end;
  Shell_NotifyIcon(NIM_DELETE, @NotifyIconData);
end;

procedure TF_BaseIni.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DestroyIcone;
end;

procedure TF_BaseIni.FormCreate(Sender: TObject);
begin
  F_Sobre:= TF_Sobre.Create(Self);
  with F_Sobre do
    begin
      Left:= Self.Left;
      Top:= Self.Top + Self.Height + 2;
    end;

  F_UpDown:= TF_UpDown.Create(Self);
  with F_UpDown do
    begin
      F_UpDown.OutHandle:= F_Sobre.Handle;
      Left:= (Self.BoundsRect.Right) - (F_UpDown.Width);
      Top:= F_Sobre.Top + F_Sobre.Height;
    end;
end;

procedure TF_BaseIni.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
    Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    End;
end;

procedure TF_BaseIni.FormShow(Sender: TObject);
var
  Reg: TRegistry;
  S: string;
begin
  CriaIcone;
  Left:= Screen.Width - Width;
  Top:= 0;
  tm_sobre.Enabled:= True;
  ShowWindow(Application.Handle, SW_HIDE);

  Reg := TRegistry.Create;
  try
    S:=ExtractFileDir(Application.ExeName)+'\'+ExtractFileName(Application.ExeName);
    Reg.rootkey:=HKEY_LOCAL_MACHINE;
    Reg.Openkey('SOFTWARE\MICROSOFT\WINDOWS\CURRENTVERSION\RUN',false);
    ac_IniciarWindows.Checked:= Reg.ReadString('Protocollo') = S;
    Reg.closekey;
  finally
    Reg.Free;
  end;

end;

procedure TF_BaseIni.img_baseMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TF_BaseIni.tm_sobreTimer(Sender: TObject);
begin
  with F_Sobre do
    begin
      Left:= Self.Left;
      Top:= Self.Top + Self.Height + 2;
      if not Showing then
        Show;
    end;

  with F_UpDown do
    begin
      F_UpDown.OutHandle:= F_Sobre.Handle;
      Left:= (Self.BoundsRect.Right) - (F_UpDown.Width);
      if F_Sobre.Height = 0 then
        Top:= Self.Top + Self.Height
      else
        Top:= F_Sobre.Top + F_Sobre.Height;              
      if not Showing then
        Show;
    end;
end;

//procedure TF_BaseIni.WMSysCommand(var Msg: TWMSysCommand);
//begin
//  case (Msg.CmdType) of
//    SC_MINIMIZE:
//      begin
//        Self.Visible:= False;
//        CriaIcone;
//      end;
//    SC_MAXIMIZE:
//      begin
//        Self.Visible:= True;
//      end
//    else
//      Inherited;
//  end; 
//end;

procedure TF_BaseIni.WMTrayIcon(var Msg: TMessage);
var
  Pt: TPoint;
begin
  if (Msg.LParam = WM_RBUTTONDOWN) then
    begin
      GetCursorPos(Pt);
      pm_try.Popup(Pt.X, Pt.Y);
      pm_try.AutoPopup:= False;
    end
//  else
//  if (Msg.LParam = WM_LBUTTONDBLCLK) then
//    begin
//      Self.Visible:= True;
//      DestroyIcone;
//    end;
end;

end.
