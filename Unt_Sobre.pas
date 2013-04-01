unit Unt_Sobre;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxPC, StdCtrls, jpeg,
  ExtCtrls, Unt_Util, cxContainer, cxEdit, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxImageComboBox, DateUtils, Math, CategoryButtons, VarUtils,
  ImgList, Menus, ActnList, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxButtons, SHELLAPI,
  Unit_DM, Mask, DBCtrls, DB, DBClient, Unt_CadAnClientes, Unt_CadAnArquivo,
  cxProgressBar, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, cxGridStrs, Unt_CadAgendaCompromisso;

type
  TTipoImagem = (img_JPG, img_BMP, img_GIF, img_PNG, img_WMF, img_EMF, img_ICO, img_DES);
  
  TF_Sobre = class(TForm)
    pgctrl_sobre: TcxPageControl;
    ts_sobre: TcxTabSheet;
    tab_Calendario: TcxTabSheet;
    pnl_top: TPanel;
    lbl_ano: TLabel;
    pnl_bse: TPanel;
    cbb_ano: TcxComboBox;
    lbl_mes: TLabel;
    cbbimg_mes: TcxImageComboBox;
    il_calendario: TImageList;
    act_menu: TActionList;
    act_ExibirCompromissos: TAction;
    act_NovoCompromisso: TAction;
    act_ExcluirCompromisso: TAction;
    pm_agenda: TPopupMenu;
    Novocompromissoparaodia1: TMenuItem;
    Exibircompromissosdodia1: TMenuItem;
    Excluircompromissosdodia1: TMenuItem;
    tab_compromissosDia: TcxTabSheet;
    pnl_down: TPanel;
    btn_OK: TcxButton;
    pnl_compromissos: TPanel;
    pnl_topcompromissos: TPanel;
    pnl_sobre: TPanel;
    img_sobre: TImage;
    lbl_Titulo: TLabel;
    lbl_sobre: TLabel;
    ts_CaixaCliente: TcxTabSheet;
    pnl_CaixaCliente: TPanel;
    pnl_caixaTopCliente: TPanel;
    cds_cliente: TClientDataSet;
    lbl_cliente: TLabel;
    btn_psq: TcxButton;
    edt_NomeCliente: TEdit;
    dbedt_PRO_CLI_Cod: TEdit;
    il_status: TImageList;
    img_caixacliente: TImage;
    img_status: TImage;
    pro_arquivo: TcxProgressBar;
    cds_dados: TClientDataSet;
    ds_dados: TDataSource;
    pnl_grid: TPanel;
    grid_base: TcxGrid;
    vwl_base: TcxGridDBTableView;
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    vwl_baseColumn4: TcxGridDBColumn;
    tbl_base: TcxGridLevel;
    vwl_baseColumn5: TcxGridDBColumn;
    tbl_associacao: TcxGridLevel;
    vwl_associacao: TcxGridDBTableView;
    vwl_associacaoColumn1: TcxGridDBColumn;
    cds_associacao: TClientDataSet;
    ds_associacao: TDataSource;
    cds_Arquivo: TClientDataSet;
    ds_Arquivo: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnl_bseMouseEnter(Sender: TObject);
    procedure pnl_bseMouseLeave(Sender: TObject);
    procedure cbbimg_mesMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure cbbimg_mesPropertiesEditValueChanged(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure act_ExibirCompromissosExecute(Sender: TObject);
    procedure dbedt_PRO_CLI_CodExit(Sender: TObject);
    procedure dbedt_PRO_CLI_CodKeyPress(Sender: TObject; var Key: Char);
    procedure btn_psqClick(Sender: TObject);
    procedure ts_CaixaClienteShow(Sender: TObject);
    procedure pnl_CaixaClienteDblClick(Sender: TObject);
    procedure tab_compromissosDiaShow(Sender: TObject);
    procedure vwl_baseCustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure act_NovoCompromissoExecute(Sender: TObject);
    procedure act_ExcluirCompromissoExecute(Sender: TObject);
    procedure vwl_associacaoColumn1GetDisplayText(
      Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
      var AText: string);
  private
    FAltura: Integer;
    FHotDia: Integer;
    originalPanelWindowProc : TWndMethod;
    FHotData: TDate;
    { Private declarations }
    procedure AtualizaResgistros(var Msg: TMessage); message WM_SALVO;
    function GetTipoDaImagem(p_Stream: TMemoryStream):TTipoImagem;
    procedure Esconde(var Msg: TMessage); message WM_UP;
    procedure Mostra(var Msg: TMessage); message WM_NOTUP;
    procedure SetAltura(const Value: Integer);
    procedure SetHotDia(const Value: Integer);
    procedure SetHotData(const Value: TDate);
    property Altura: Integer read FAltura write SetAltura;
    property HotDia: Integer read FHotDia write SetHotDia;
    property HotData: TDate read FHotData write SetHotData;
    function CriaCalendario(AAno, AMes: Word): TCategoryButtons;
    procedure AMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
    procedure AMouseLeave(Sender: TObject);
    procedure AClick(Sender: TObject);
    procedure AHotButton(Sender: TObject; const Button: TButtonItem);
    procedure PanelWindowProc (var Msg : TMessage) ;
    procedure PanelImageDrop (var Msg : TWMDROPFILES) ;
    procedure CopiaArquivo(Source, Destination: string);
  public
    { Public declarations }
  end;

var
  F_Sobre: TF_Sobre;

implementation

{$R *.dfm}

procedure TF_Sobre.cbbimg_mesMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Self.AlphaBlendValue:= 255;
end;

procedure TF_Sobre.cbbimg_mesPropertiesEditValueChanged(Sender: TObject);
begin
  if cbbimg_mes.EditValue <> null then
    begin
      if FindComponent('Calendario') <> nil then
        TButtonCategory(FindComponent('Calendario')).Free;
      CriaCalendario(StrToInt(cbb_ano.Text), Integer(cbbimg_mes.EditValue));
    end;
end;

procedure TF_Sobre.CopiaArquivo(Source, Destination: string);
var
  FromF, ToF: file of byte;
  Buffer: array[0..4096] of char;
  NumRead: integer;
  FileLength: longint;
begin
  AssignFile(FromF, Source);
  reset(FromF);
  AssignFile(ToF, Destination);
  rewrite(ToF);
  FileLength := FileSize(FromF);
  with pro_arquivo do
  begin
    Properties.Min := 0;
    Properties.Max := FileLength;
    while FileLength > 0 do
    begin
      BlockRead(FromF, Buffer[0], SizeOf(Buffer), NumRead);
      FileLength := FileLength - NumRead;
      BlockWrite(ToF, Buffer[0], NumRead);
      Position := Position + NumRead;
      Application.ProcessMessages;
    end;
    CloseFile(FromF);
    CloseFile(ToF);
    Position := 0;
    Application.ProcessMessages;
    Update;
  end; 
end;

function TF_Sobre.CriaCalendario(AAno, AMes: Word): TCategoryButtons;
var
  ASemana:  TButtonCategory;
  i, j, k, ADias: Integer;
  AInicia: Boolean;
begin
  k:= 1;
  Result:= TCategoryButtons.Create(Self);
  ADias:= 1;
  AInicia:= False;
  with Result do
    begin
      Images:= il_calendario;
      PopupMenu:= pm_agenda;
      Parent:= pnl_bse;
      Name:= 'Calendario';
      OnMouseMove:= AMouseMove;
      OnMouseLeave:= AMouseLeave;
      OnHotButton:= AHotButton;
      OnClick:= AClick;
      BorderStyle:= bsNone;
      ShowHint:= True;
      Width:= 295;
      Height:= 317;
      Left:= (pnl_bse.Width - Result.Width) div 2;
      ButtonOptions:= ButtonOptions + [boBoldCaptions] - [boVerticalCategoryCaptions];
      ButtonWidth:= 40;
      ButtonFlow:= cbfVertical;
      for j := 0 to 6 do
        begin
          ASemana:= Categories.Add;
          with ASemana.Items do
            begin
              for i:= 0 to 6 do
                begin
                  if AInicia then
                    inc(ADias);
                  with Add do
                    begin
                      if j = 0 then
                        Caption:= UpperCase(Copy(LongDayNames[i + 1], 1, 1))
                      else
                        if (i = DayOfTheWeek(EncodeDateTime(AAno,
                                                             AMes,
                                                             1,
                                                             0,
                                                             0,
                                                             0,
                                                             0))) and
                           (ADias = 1) then
                          begin
                            if (not AInicia) then
                              begin
                                AInicia:= not AInicia;
                                Caption:= IntToStr(ADias);
                              end;
                          end
                        else if (AInicia and (ADias <= DaysInMonth(EncodeDateTime(AAno,
                                                                                AMes,
                                                                                1,
                                                                                0,
                                                                                0,
                                                                                0,
                                                                                0)))) then
                          Caption:= IntToStr(ADias)
                        else if (i = 0) and (j > 1) then
                          begin
                            if (not AInicia) then
                              begin
                                AInicia:= not AInicia;
                                Caption:= IntToStr(ADias);
                              end;
                          end;
                      if (DayOfTheMonth(now) = ADias) and (DayOfTheMonth(now) <> 1) then
                        begin
                          ImageIndex:= 0;
                          Hint:= 'Hoje';
                        end
                      else if (Trim(Caption) = '1') then
                        begin
                          ImageIndex:= 0;
                          Hint:= 'Hoje';
                        end
                    end;
                end;
            end;
          if (j > 0) and AInicia then
            begin
              ASemana.Caption:= IntToStr(k)+'a semana';
              Inc(k);
            end;
        end;
    end;

end;

procedure TF_Sobre.dbedt_PRO_CLI_CodExit(Sender: TObject);
begin
  if Trim(dbedt_PRO_CLI_Cod.Text) <> '' then
    begin
      if cds_Cliente.Locate('CLI_Cod', Trim(dbedt_PRO_CLI_Cod.Text), []) then
        edt_NomeCliente.Text:= cds_Cliente.FieldByName('CLI_Nome').AsString
      else
        begin
          dbedt_PRO_CLI_Cod.Clear;
          edt_NomeCliente.Clear;
        end;
    end
  else
    edt_NomeCliente.Clear;
end;

procedure TF_Sobre.dbedt_PRO_CLI_CodKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_Sobre.Esconde(var Msg: TMessage);
begin
  AnimateWindow(Self.Handle, 250, AW_HIDE or AW_VER_NEGATIVE or AW_SLIDE);
  Self.Height:= 0;
end;

procedure TF_Sobre.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action:= caFree;
  Self:= nil;
end;

procedure TF_Sobre.FormCreate(Sender: TObject);
begin
  cxSetResourceString(@scxGridGroupByBoxCaption, 'Arraste as colunas para agrupa-las');
  FAltura:= Self.Height;
  originalPanelWindowProc := pnl_CaixaCliente.WindowProc;
  pnl_CaixaCliente.WindowProc := PanelWindowProc;
 
  DragAcceptFiles(pnl_CaixaCliente.Handle,true) ;
  cds_cliente.Data:= DM.cds_clientes.Data;
end;

procedure TF_Sobre.FormShow(Sender: TObject);
var
  i: Integer;
begin
  ShowWindow(Application.Handle, SW_HIDE);
  with cbb_ano.Properties.Items do
    begin
      for I := 1900 to 2100 do
        begin
          Add(IntToStr(i));
        end;
    end;
  cbb_ano.Text:= IntToStr(YearOf(now));
  cbbimg_mes.EditValue:= MonthOf(Now);
  tab_Calendario.Show;
end;

function TF_Sobre.GetTipoDaImagem(p_Stream: TMemoryStream): TTipoImagem;
var
  wl_ss: TStringStream;
  wl_temp:string;
Begin
  try
    p_Stream.Position := 0;
    wl_ss:= TStringStream.Create('');
    wl_ss.CopyFrom(p_Stream, 5);
    wl_temp:=Uppercase(wl_ss.DataString);
    if (Ord(wl_ss.DataString[1]) = 255) and
       (Ord(wl_ss.DataString[2]) = 216) then
      Result:= img_JPG
    else if Pos('BM', wl_temp) > 0 then
      Result:= img_BMP
    else if Pos('GIF', wl_temp) > 0 then
      Result:= img_GIF
    else if Pos('PNG', wl_temp) > 0 then
      Result:= img_PNG
    else if (Ord(wl_ss.DataString[1]) = 215) and
            (Ord(wl_ss.DataString[2]) = 205)  and
            (Ord(wl_ss.DataString[3]) = 198) then
     Result:= img_WMF
    else if Pos('X',wl_temp) > 0 then
      Result:= img_EMF
    else if (Ord(wl_ss.DataString[1]) = 0) and
            (Ord(wl_ss.DataString[2]) = 0) then
      Result:= img_ICO
    else if (Ord(wl_ss.DataString[1]) = 0) and
            (Ord(wl_ss.DataString[2]) = 1) then
      Result:= img_ICO
    else
      Result:= img_DES;
  except on e: Exception do
    MessageDlg(e.Message, mtError, [mbOK], 0);
  end;

end;

procedure TF_Sobre.Mostra(var Msg: TMessage);
begin
  Self.Height:= Altura;
  AnimateWindow(Self.Handle, 250, AW_VER_POSITIVE or AW_SLIDE);
end;

procedure TF_Sobre.PanelImageDrop(var Msg: TWMDROPFILES);
  procedure CopyFile(FromFileName, ToFileName: string);
  var
    shellinfo: TSHFileOpStructA;
    Files:String;
  begin
    Files:=FromFileName+#0+#0;
    with shellinfo do
    begin
      Wnd:=Self.handle;
      wFunc:=FO_COPY;
      pFrom:=PChar(Files);
      pTo:=PChar(ToFileName);
      fFlags:=FOF_NOCONFIRMATION or FOF_SILENT;
    end;
    SHFileOperation(shellinfo);
  end;
var
  numFiles : longInt;
  buffer : array[0..MAX_PATH] of char;
  i: Integer;
  dirBase, dirArq: string;
  dataAux: TClientDataSet;
begin
  numFiles := DragQueryFile(Msg.Drop, $FFFFFFFF, nil, 0) ;
  VerificaPastas(DM.cds_pasta.Data);
  begin
    DragQueryFile(Msg.Drop, 0, @buffer, sizeof(buffer)) ;
    try
      for I := 0 to numFiles - 1 do
        begin
          pro_arquivo.Visible:= True;
          il_status.GetIcon(0, img_status.Picture.Icon);
          DragQueryFile(Msg.Drop, i, @buffer, sizeof(buffer));
          if Trim(edt_NomeCliente.Text) <> '' then
            begin
              dirBase:= Trim(ExtractFileDir(Application.ExeName)+'\CLIENTES\'+Trim(dbedt_PRO_CLI_Cod.Text));
              if not DirectoryExists(dirBase) then
              begin
                ForceDirectories(dirBase);
              end;

              if not DirectoryExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))) then
                ForceDirectories(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1))));

              if DirectoryExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))) then
                begin
                  if not DM.cds_pasta.Locate('PST_Nome;PST_CLI_Cod', VarArrayOf([Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1))), Trim(dbedt_PRO_CLI_Cod.Text)]) , []) then
                    begin
                      DM.cds_pasta.Insert;
                      DM.cds_pasta.FieldByName('PST_CLI_Cod').AsInteger:= StrToInt(dbedt_PRO_CLI_Cod.Text);
                      DM.cds_pasta.FieldByName('PST_Nome').AsString:= Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)));
                      DM.cds_pasta.FieldByName('PST_Path').AsString:= dirBase+'\'+DM.cds_pasta.FieldByName('PST_Nome').AsString;
                      DM.cds_pasta.Post;
                    end;
                end;

              dirArq:= dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))+'\';
              if DirectoryExists(dirArq) then
                begin
                  dataAux:= TClientDataSet.Create(Self);
                  dataAux.Data:= DM.cds_arquivo.Data;
                  il_status.GetIcon(0, img_status.Picture.Icon);
                  CopiaArquivo(buffer, dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))+'\'+ExtractFileName(buffer));
                  //CopyFile(buffer, dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1))));
                  if FileExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))+'\'+ExtractFileName(buffer)) then
                    begin
                      DM.cds_arquivo.Insert;
                      DM.cds_arquivo.FieldByName('ARQ_PST_Cod').AsInteger:= DM.cds_pasta.FieldByName('PST_Cod').AsInteger;
                      if dataAux.Locate('ARQ_Nome', DM.cds_arquivo.FieldByName('ARQ_Nome').AsString, []) then
                        DM.cds_arquivo.FieldByName('ARQ_Nome').AsString:= FormatDateTime('aaaammddhhnnsszzz', now)+'_'+ExtractFileName(buffer)
                      else
                        DM.cds_arquivo.FieldByName('ARQ_Nome').AsString:= ExtractFileName(buffer);
                      dataAux.Free;
                      DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString:= NovoGuid+ExtractFileExt(buffer);
                      DM.cds_arquivo.FieldByName('ARQ_Path').AsString:= dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))+'\'+DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString;
                      DM.cds_arquivo.FieldByName('Data').AsDateTime:= Now;
                      DM.cds_arquivo.Post;
                      RenameFile(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(buffer), 2, length(buffer) - 1)))+'\'+DM.cds_arquivo.FieldByName('ARQ_Nome').AsString, DM.cds_arquivo.FieldByName('ARQ_Path').AsString)
                    end;
                end;
            end
          else
            begin
              MessageDlg('Selecione um paciente', mtInformation, [mbOK], 0);
              il_status.GetIcon(1, img_status.Picture.Icon);
              dbedt_PRO_CLI_Cod.SetFocus;
              Exit;
            end;
          pro_arquivo.Visible:= False;
        end;
    except
      on E: Exception do MessageDlg(E.Message, mtError, [mbOK], 0);
    end;
  end;
  il_status.GetIcon(2, img_status.Picture.Icon);
end;

procedure TF_Sobre.PanelWindowProc(var Msg: TMessage);
begin
  if Msg.Msg = WM_DROPFILES then
    PanelImageDrop(TWMDROPFILES(Msg))
  else
    originalPanelWindowProc(Msg) ;
end;

procedure TF_Sobre.AClick(Sender: TObject);
begin
  if act_ExibirCompromissos.Enabled then
    act_ExibirCompromissosExecute(Self);
end;

procedure TF_Sobre.act_ExcluirCompromissoExecute(Sender: TObject);
begin
  if MessageDlg('Deseja excluir todos os compromisso do dia?', mtInformation, mbYesNo, 0) = mrYes then
    begin
      DM.cds_AgendaCompromisso.Filtered:= False;
      DM.cds_AgendaCompromisso.Filter:= 'AGC_Data = '+FormatDateTime('yyyy-mm-dd',HotData);
      DM.cds_AgendaCompromisso.Filtered:= True;
      if not DM.cds_AgendaCompromisso.IsEmpty then
        begin
          while DM.cds_AgendaCompromisso.RecordCount > 0 do
            begin
              DM.cds_AgendaCompromisso.Delete;
            end;
        end;
      DM.cds_AgendaCompromisso.Filtered:= False;
    end;
end;

procedure TF_Sobre.act_ExibirCompromissosExecute(Sender: TObject);
begin
  pnl_topcompromissos.Caption:= 'Compromossos do dia '+ IntToStr(HotDia)+ ' de '+ cbbimg_mes.EditText +' de '+ cbb_ano.Text;
  tab_compromissosDia.Show;
end;

procedure TF_Sobre.act_NovoCompromissoExecute(Sender: TObject);
begin
  if HotData >= Date  then
    TF_CadAgendaCompromisso.IniciaCad(Self.Handle, True, HotData)
  else
    MessageDlg('Não é possivél inserir um compromisso por essa funcionalidade com data inferior a data atual.', mtInformation, [mbOK], 0)
end;

procedure TF_Sobre.AHotButton(Sender: TObject; const Button: TButtonItem);
begin
  if Button <> nil then
    begin
      HotDia:= StrToIntDef(Button.Caption, 0);
      act_ExibirCompromissos.Enabled:= HotDia <> 0;
      act_NovoCompromisso.Enabled:= HotDia <> 0;
      if HotDia <> 0 then       
        HotData:= EncodeDate(StrToInt(cbb_ano.Text), Integer(cbbimg_mes.EditValue), HotDia);
    end;
end;

procedure TF_Sobre.AMouseLeave(Sender: TObject);
begin
    Self.AlphaBlendValue:= 150;
end;

procedure TF_Sobre.AMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  Self.AlphaBlendValue:= 255;
end;

procedure TF_Sobre.AtualizaResgistros(var Msg: TMessage);
begin
  cds_dados.Data:= DM.cds_AgendaCompromisso.Data;
  cds_dados.Filtered:= False;
  cds_dados.Filter:= 'AGC_Data = '+FormatDateTime('yyyy-mm-dd',HotData);
  cds_dados.Filtered:= True;

  cds_associacao.Data:= DM.cds_acoesAgComp.Data;
  cds_associacao.IndexFieldNames:= 'AAC_AGC_Cod';
  cds_Arquivo.Data:= DM.cds_arquivo.Data;
end;

procedure TF_Sobre.btn_OKClick(Sender: TObject);
begin
  tab_Calendario.Show;
end;

procedure TF_Sobre.btn_psqClick(Sender: TObject);
begin
  with TClientDataSet.Create(nil) do
    begin
      try
        Data:= TF_CadAnClientes.IniciaPesquisa;
        dbedt_PRO_CLI_Cod.Text:= FieldByName('Codigo').AsString;
        edt_NomeCliente.Text:=  FieldByName('Valor').AsString;
      finally
        Free;
      end;
    end;
end;

procedure TF_Sobre.pnl_bseMouseEnter(Sender: TObject);
begin
  Self.AlphaBlendValue:= 255;
end;

procedure TF_Sobre.pnl_bseMouseLeave(Sender: TObject);
begin
  Self.AlphaBlendValue:= 150;
end;

procedure TF_Sobre.pnl_CaixaClienteDblClick(Sender: TObject);
var
  dirBase: string;
begin
  if Trim(edt_NomeCliente.Text) <> '' then
    begin
      TF_CadAnArquivo.Inicia(Trim(dbedt_PRO_CLI_Cod.Text));
//      dirBase:= Trim(ExtractFileDir(Application.ExeName)+'\Clientes\'+Trim(dbedt_PRO_CLI_Cod.Text))+'\';
//      if DirectoryExists(dirBase) then
//        ShellExecute(Application.HANDLE, 'open', PChar(dirBase),nil,nil,SW_SHOWNORMAL)
//      else
//        MessageDlg('Cliente não tem arquivos', mtInformation, [mbOK], 0);
    end
  else
    MessageDlg('Selecione um paciente', mtInformation, [mbOK], 0);
end;

procedure TF_Sobre.SetAltura(const Value: Integer);
begin
  FAltura := Value;
end;

procedure TF_Sobre.SetHotData(const Value: TDate);
begin
  FHotData := Value;
end;

procedure TF_Sobre.SetHotDia(const Value: Integer);
begin
  FHotDia := Value;
end;

procedure TF_Sobre.tab_compromissosDiaShow(Sender: TObject);
begin
  cds_dados.Data:= DM.cds_AgendaCompromisso.Data;
  cds_dados.Filtered:= False;
  cds_dados.Filter:= 'AGC_Data = '+FormatDateTime('yyyy-mm-dd',HotData);
  cds_dados.Filtered:= True;

  cds_associacao.Data:= DM.cds_acoesAgComp.Data;
  cds_associacao.IndexFieldNames:= 'AAC_AGC_Cod';
  cds_Arquivo.Data:= DM.cds_arquivo.Data;
end;

procedure TF_Sobre.ts_CaixaClienteShow(Sender: TObject);
begin
  dbedt_PRO_CLI_Cod.SetFocus;
  il_status.GetIcon(2, img_status.Picture.Icon);
end;

procedure TF_Sobre.vwl_associacaoColumn1GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  if trim(AText) <> '' then
    begin
      cds_Arquivo.Filtered:= False;
      cds_Arquivo.Filter:= 'ARQ_Cod =' +AText;
      cds_Arquivo.Filtered:= True;
      if not cds_Arquivo.IsEmpty then
        AText:= cds_Arquivo.FieldByName('ARQ_Nome').AsString
      else
        AText:= 'Arquivo/Ação não identificado';
    end
  else
    AText:= 'Arquivo/Ação não identificado';
end;

procedure TF_Sobre.vwl_baseCustomDrawCell(Sender: TcxCustomGridTableView;
  ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
  var ADone: Boolean);
begin
  if AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] = True then
    ACanvas.Font.Color:= clGreen
  else if (not (AViewInfo.GridRecord.Values[vwl_baseColumn5.Index] = True)) and
    (EncodeDateTime(YearOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                    MonthOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                    DayOf(AViewInfo.GridRecord.Values[vwl_baseColumn2.Index]),
                    AViewInfo.GridRecord.Values[vwl_baseColumn3.Index],
                    AViewInfo.GridRecord.Values[vwl_baseColumn4.Index],
                    0,
                    0) < Now) then
    ACanvas.Font.Color:= clRed
  else
    ACanvas.Font.Color:= clBlack;
end;

end.
