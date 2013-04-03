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
  cxHint, Unt_CadAnProtocolos, Unt_CadAnArquivo, Unt_CadAnAgendaCompromisso, Unt_Util,
  DB, DBClient, DateUtils, dxAlertWindow, ComObj, jpeg;

type
  TF_ProtocoloIni = class(TF_BaseIni)
    Agendadecompromissos3: TMenuItem;
    tm_Compromissos: TTimer;
    procedure act_CadDocumentosExecute(Sender: TObject);
    procedure ac_CadUsuariosExecute(Sender: TObject);
    procedure ac_CadSetoresExecute(Sender: TObject);
    procedure act_CadClientesExecute(Sender: TObject);
    procedure act_CadEmpresaExecute(Sender: TObject);
    procedure act_EmiProtocolosExecute(Sender: TObject);
    procedure act_ArquivoClienteExecute(Sender: TObject);
    procedure act_AgendaCompCadExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tm_CompromissosTimer(Sender: TObject);
    procedure alerta_baseButtonClick(Sender: TObject;
      AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
  private
    { Private declarations }
    procedure AtualizaResgistros(var Msg: TMessage); message WM_SALVO;
    function Intervalo(AHora, AMinuto: Word): Integer;
    procedure CriaAtertaCompromisso(ADados: OleVariant);
    procedure SetRegistroArquivo(AStream: TMemoryStream; AExtens, ANomeArquivo: string);
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

procedure TF_ProtocoloIni.alerta_baseButtonClick(Sender: TObject;
  AAlertWindow: TdxAlertWindow; AButtonIndex: Integer);
begin
  inherited;
  case AButtonIndex of
    0:
      begin
        if DM.cds_AgendaCompromisso.Locate('AGC_Cod', AAlertWindow.Tag, []) then
          begin
            DM.cds_AgendaCompromisso.Edit;
            DM.cds_AgendaCompromisso.FieldByName('AGC_Status').AsBoolean:= True;
            DM.cds_AgendaCompromisso.Post;

            if not DM.cds_AgendaCompromisso.FieldByName('AGC_ArqExec').AsBoolean then
              begin
                DM.cds_acoesAgComp.Filtered:= False;
                DM.cds_acoesAgComp.Filter:= 'AAC_AGC_Cod = '+IntToStr(AAlertWindow.Tag);
                DM.cds_acoesAgComp.Filtered:= True;

                if not DM.cds_acoesAgComp.IsEmpty then
                  begin
                    DM.cds_acoesAgComp.First;
                    while not DM.cds_acoesAgComp.Eof do
                      begin
                        case DM.cds_acoesAgComp.FieldByName('AAC_Tipo').AsInteger of
                          cs_AAC_Tipo_ExecArq:
                            begin
                              if DM.cds_arquivo.Locate('ARQ_Cod', DM.cds_acoesAgComp.FieldByName('AAC_ARQ_Cod').AsInteger, []) then
                                ExecFileArq(DM.cds_arquivo.FieldByName('ARQ_Path').AsString, Self.Handle);
                            end;
                          cs_AAC_Tipo_FuncPre:
                            begin
                              case DM.cds_acoesAgComp.FieldByName('AAC_ARQ_Cod').AsInteger of
                                cs_CapturaTela:
                                  begin
                                    //teste
                                    CapituraTela.SaveToFile(ExtractFileDir(Application.ExeName)+'/'+FormatDateTime('yyyymmddhhnnsszzz', Now)+'.screeen');
                                  end;
                              end;
                            end;
                        end;

                        DM.cds_acoesAgComp.Next;
                      end;
                  end;
              end;

            SendMessage(Handle, WM_SALVO, 0, 0);
            AAlertWindow.Close;
            DM.cds_acoesAgComp.Filtered:= False;
          end;
      end;
  end;
end;

procedure TF_ProtocoloIni.AtualizaResgistros(var Msg: TMessage);
var
  book: string;
begin
  tm_Compromissos.Enabled:= False;
  if cds_Compromissos.Active then
    cds_Compromissos.Filtered:= False;
  cds_Compromissos.Data:= DM.cds_AgendaCompromisso.Data;

  cds_Compromissos.IndexFieldNames:= 'AGC_Hora; AGC_Minuto';
  if Not cds_Compromissos.IsEmpty then
    begin
      cds_Compromissos.First;
      cds_Compromissos.Filtered:= False;
      cds_Compromissos.Filter:= 'AGC_Data = '+FormatDateTime('yyyy-mm-dd',Date) +' and AGC_Hora >=' +FormatDateTime('hh', Now)+ ' and AGC_Minuto > '+ FormatDateTime('nn', Now) + ' and AGC_Alerta = 0';
      cds_Compromissos.Filtered:= True;
      cds_Compromissos.First;
      tm_Compromissos.Enabled:= (not cds_Compromissos.IsEmpty);
    end;
end;

procedure TF_ProtocoloIni.CriaAtertaCompromisso(ADados: OleVariant);
begin
  with alerta_base do
    begin
      with TClientDataSet.Create(Self) do
        begin
          try
            Data:= ADados;
            First;
            while Not eof do
              begin
                with Show(FieldByName('ACaption').AsString, FieldByName('ADescricao').AsString, FieldByName('AIndexImagem').AsInteger) do
                  begin
                    Tag:= FieldByName('ATag').AsInteger;
                  end;
                Next;
              end;
          finally
            Free;
          end;
        end;
    end;
end;

procedure TF_ProtocoloIni.FormShow(Sender: TObject);
begin
  inherited;
  SendMessage(Handle, WM_SALVO, 0, 0);
end;

function TF_ProtocoloIni.Intervalo(AHora, AMinuto: Word): Integer;
var
  DataInicial: TDateTime;
begin
  Result:= -1;
  try
    DataInicial:= EncodeDateTime(YearOf(Now), MonthOf(Now), DayOf(Now), AHora, AMinuto + 1, 0, 0);
    if (DataInicial >= now) then
      Result:= MinutesBetween(DataInicial, Now);
  except
    Result:= -1;
  end;
end;

procedure TF_ProtocoloIni.SetRegistroArquivo(AStream: TMemoryStream; AExtens, ANomeArquivo: string);
var
  dirBase, CodCliente, dirArq: string;
  dataAux: TClientDataSet;
begin
  //Teste
  CodCliente:= '1';

  dirBase:= Trim(ExtractFileDir(Application.ExeName)+'\CLIENTES\'+Trim(CodCliente));
  if not DirectoryExists(dirBase) then
  begin
    ForceDirectories(dirBase);
  end;

  if not DirectoryExists(dirBase+'\'+Trim(UpperCase(AExtens))) then
    ForceDirectories(dirBase+'\'+Trim(UpperCase(AExtens)));

  if DirectoryExists(dirBase+'\'+Trim(UpperCase(AExtens))) then
    begin
      if not DM.cds_pasta.Locate('PST_Nome;PST_CLI_Cod', VarArrayOf([Trim(UpperCase(AExtens)), CodCliente]) , []) then
        begin
          DM.cds_pasta.Insert;
          DM.cds_pasta.FieldByName('PST_CLI_Cod').AsInteger:= StrToInt(CodCliente);
          DM.cds_pasta.FieldByName('PST_Nome').AsString:= AExtens;
          DM.cds_pasta.FieldByName('PST_Path').AsString:= dirBase+'\'+DM.cds_pasta.FieldByName('PST_Nome').AsString;
          DM.cds_pasta.Post;
        end;
    end;

  dirArq:= dirBase+'\'+Trim(UpperCase(AExtens))+'\';
  if DirectoryExists(dirArq) then
    begin
      dataAux:= TClientDataSet.Create(Self);
      dataAux.Data:= DM.cds_arquivo.Data;
      with TJPEGImage.Create do
        begin
          try
            LoadFromStream(AStream);
            SaveToFile(dirBase+'\'+Trim(UpperCase(AExtens))+'\'+ANomeArquivo+AExtens);
          finally
            Free;
          end;
        end;
      if FileExists(dirBase+'\'+Trim(UpperCase(AExtens))+'\'+ANomeArquivo+AExtens) then
        begin
          DM.cds_arquivo.Insert;
          DM.cds_arquivo.FieldByName('ARQ_PST_Cod').AsInteger:= DM.cds_pasta.FieldByName('PST_Cod').AsInteger;
          DM.cds_arquivo.FieldByName('ARQ_Nome').AsString:= ANomeArquivo+'.'+AExtens;
          dataAux.Free;
          DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString:= NovoGuid+'.'+AExtens;
          DM.cds_arquivo.FieldByName('ARQ_Path').AsString:= dirBase+'\'+Trim(UpperCase(AExtens))+'\'+DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString;
          DM.cds_arquivo.FieldByName('Data').AsDateTime:= Now;
          DM.cds_arquivo.Post;
          RenameFile(dirBase+'\'+Trim(UpperCase(AExtens))+'\'+DM.cds_arquivo.FieldByName('ARQ_Nome').AsString, DM.cds_arquivo.FieldByName('ARQ_Path').AsString)
        end;
    end;
end;

procedure TF_ProtocoloIni.tm_CompromissosTimer(Sender: TObject);
var
  IntervaloTmp: Integer;
  voz : OleVariant;
  ClientAux, ClientAux2: TClientDataSet;
  Stream: TMemoryStream;
  jpeg: TJPEGImage;
begin
  inherited;
  tm_Compromissos.Enabled:= (not cds_Compromissos.IsEmpty);
  IntervaloTmp:= Intervalo(cds_Compromissos.FieldByName('AGC_Hora').AsInteger, cds_Compromissos.FieldByName('AGC_Minuto').AsInteger);
  if IntervaloTmp = 0 then
    begin
      ClientAux:= TClientDataSet.Create(Self);
      try
        ClientAux.FieldDefs:= cds_Compromissos.FieldDefs;
        ClientAux.CreateDataSet;
        ClientAux.CloneCursor(cds_Compromissos, False);
        ClientAux.Filtered:= False;
        ClientAux.Filter:= 'AGC_Hora = '+ClientAux.FieldByName('AGC_Hora').AsString+ ' and AGC_Minuto = '+ ClientAux.FieldByName('AGC_Minuto').AsString;
        ClientAux.Filtered:= True;
        ClientAux2:= TClientDataSet.Create(Self);
        with ClientAux2 do
          begin
            try
              with ClientAux2.FieldDefs do
                begin
                  Add('ADescricao', ftMemo);
                  Add('ACaption', ftString, 100);
                  Add('ATag', ftInteger);
                  Add('AIndexImagem', ftInteger);
                  Add('AArqExecuta', ftBoolean);
                end;
              ClientAux2.CreateDataSet;
              ClientAux.First;
              while not ClientAux.Eof do
                begin
                  if DM.cds_AgendaCompromisso.Locate('AGC_Cod', ClientAux.FieldByName('AGC_Cod').AsInteger, []) then
                    begin
                      DM.cds_AgendaCompromisso.Edit;
                      DM.cds_AgendaCompromisso.FieldByName('AGC_Alerta').AsBoolean:= True;
                      DM.cds_AgendaCompromisso.Post;
                      ClientAux2.AppendRecord([ClientAux.FieldByName('AGC_Observacao').AsString,
                                    ClientAux.FieldByName('AGC_Hora').AsString+':'+ClientAux.FieldByName('AGC_Minuto').AsString +' - '+ClientAux.FieldByName('AGC_Descricao').AsString,
                                    ClientAux.FieldByName('AGC_Cod').AsInteger,
                                    0,
                                    ClientAux.FieldByName('AGC_ArqExec').AsBoolean]);
                      voz:= CreateOleObject('SAPI.SpVoice');
                      try
                        voz.Speak(ClientAux.FieldByName('AGC_Descricao').AsString);
                      except
                        //
                      end;

                      if ClientAux.FieldByName('AGC_ArqExec').AsBoolean then
                        begin
                          if DM.cds_AgendaCompromisso.Locate('AGC_Cod', ClientAux.FieldByName('AGC_Cod').AsInteger, []) then
                            begin
                              DM.cds_acoesAgComp.Filtered:= False;
                              DM.cds_acoesAgComp.Filter:= 'AAC_AGC_Cod = '+IntToStr(ClientAux.FieldByName('AGC_Cod').AsInteger);
                              DM.cds_acoesAgComp.Filtered:= True;

                              if not DM.cds_acoesAgComp.IsEmpty then
                                begin
                                  DM.cds_acoesAgComp.First;
                                  while not DM.cds_acoesAgComp.Eof do
                                    begin
                                      case DM.cds_acoesAgComp.FieldByName('AAC_Tipo').AsInteger of
                                        cs_AAC_Tipo_ExecArq:
                                          begin
                                            if DM.cds_arquivo.Locate('ARQ_Cod', DM.cds_acoesAgComp.FieldByName('AAC_ARQ_Cod').AsInteger, []) then
                                              ExecFileArq(DM.cds_arquivo.FieldByName('ARQ_Path').AsString, Self.Handle);                                      
                                          end;                                
                                        cs_AAC_Tipo_FuncPre:
                                          begin
                                            case DM.cds_acoesAgComp.FieldByName('AAC_ARQ_Cod').AsInteger of
                                              cs_CapturaTela:
                                                begin
                                                  //teste
                                                  Stream:= TMemoryStream.Create;
                                                  try
                                                    jpeg:= CapituraTela;
                                                    jpeg.SaveToStream(Stream);
                                                    try
                                                      SetRegistroArquivo(Stream, 'SCREEN', 'USUARIOTESTE');
                                                    finally
                                                      jpeg.Free;
                                                    end;
                                                  finally
                                                    Stream.Free;
                                                  end;
                                                end;  
                                            end;
                                          end;
                                      end;                                    

                                      DM.cds_acoesAgComp.Next;
                                    end;                                
                                end;
                              DM.cds_acoesAgComp.Filtered:= False;
                            end;
                         end;
                    end;
                  ClientAux.Next;
                end;
              CriaAtertaCompromisso(ClientAux2.Data);
            finally
              ClientAux2.Free;
            end;
          end;
      finally
        ClientAux.Free;
      end;        
      SendMessage(Handle, WM_SALVO, 0, 0);
    end;
end;

end.
