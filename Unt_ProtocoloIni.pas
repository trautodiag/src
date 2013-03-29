unit Unt_ProtocoloIni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseIni, Unit_DM, ToolWin, ActnMan, ActnCtrls, ActnMenus,
  ActnList, Menus, Unt_CadAnDocumentos, dxSkinsCore, dxSkinOffice2010Blue,
  dxSkinscxPCPainter, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsForm, StdCtrls, cxButtons, ExtCtrls, cxPC, cxPCGoDialog,
  Unt_CadAnUsuarios, Unt_CadAnSetores, Unt_CadAnClientes, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxGDIPlusClasses, ImgList, Unt_CadAnEmpresas, dxScreenTip, dxCustomHint,
  cxHint, Unt_CadAnProtocolos, Unt_CadAnArquivo, Unt_CadAnAgendaCompromisso;

type
  TF_ProtocoloIni = class(TF_BaseIni)
    Agendadecompromissos3: TMenuItem;
    procedure act_CadDocumentosExecute(Sender: TObject);
    procedure ac_CadUsuariosExecute(Sender: TObject);
    procedure ac_CadSetoresExecute(Sender: TObject);
    procedure act_CadClientesExecute(Sender: TObject);
    procedure act_CadEmpresaExecute(Sender: TObject);
    procedure act_EmiProtocolosExecute(Sender: TObject);
    procedure act_ArquivoClienteExecute(Sender: TObject);
    procedure act_AgendaCompCadExecute(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_ProtocoloIni: TF_ProtocoloIni;

implementation

{$R *.dfm}

procedure TF_ProtocoloIni.act_AgendaCompCadExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnAgendaCompromisso.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.act_ArquivoClienteExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnArquivo.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.act_CadClientesExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnClientes.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.act_CadDocumentosExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnDocumentos.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.act_CadEmpresaExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnEmpresas.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.act_EmiProtocolosExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnProtocolos.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.ac_CadSetoresExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnSetores.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_ProtocoloIni.ac_CadUsuariosExecute(Sender: TObject);
begin
  inherited;
  with TF_CadAnUsuarios.Create(Self) do
    begin
      try
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
