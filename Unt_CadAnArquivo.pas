unit Unt_CadAnArquivo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  Menus, cxContainer, cxEdit, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, DBClient, ImgList, ActnList, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, StdCtrls, cxTextEdit, cxGroupBox, cxRadioGroup,
  cxButtons, ExtCtrls, cxPC, Unit_DM, SHELLAPI, cxButtonEdit, cxCheckBox, Unt_Util,
  cxImage, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, Unt_VisualizadorImagem, Unt_VisualizadorProcessos;

type
  TF_CadAnArquivo = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    tbl_pasta: TcxGridLevel;
    vwl_pasta: TcxGridDBTableView;
    tbl_arquivo: TcxGridLevel;
    vwl_arquivo: TcxGridDBTableView;
    cds_pasta: TClientDataSet;
    ds_pasta: TDataSource;
    cds_arquivo: TClientDataSet;
    ds_arquivo: TDataSource;
    vwl_pastaColumn1: TcxGridDBColumn;
    vwl_arquivoColumn1: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    vwl_arquivoColumn2: TcxGridDBColumn;
    act_ExcluirArquivo: TAction;
    btn_ExcluirArquivo: TcxButton;
    cxStyle2: TcxStyle;
    vwl_arquivoColumn3: TcxGridDBColumn;
    vwl_pastaColumn2: TcxGridDBColumn;
    act_ExecutarSelecaoArquivo: TAction;
    btn_ExecutarSelecaoArquivo: TcxButton;
    btn_UploadArquivo: TcxButton;
    act_UploadArquivos: TAction;
    dlgOpen_Upload: TOpenDialog;
    btn_DownloadArquivo: TcxButton;
    act_DownloadArquivo: TAction;
    dlgSave_Download: TSaveDialog;
    btn_PropriedadeArquivo: TcxButton;
    act_PropriedadeArquivo: TAction;
    il_associacao: TImageList;
    vwl_arquivoColumn4: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure vwl_arquivoDblClick(Sender: TObject);
    procedure act_ExcluirArquivoExecute(Sender: TObject);
    procedure vwl_pastaTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure vwl_arquivoTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
      Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
      var AText: string);
    procedure vwl_pastaColumn2PropertiesChange(Sender: TObject);
    procedure vwl_arquivoColumn3PropertiesChange(Sender: TObject);
    procedure act_ExecutarSelecaoArquivoExecute(Sender: TObject);
    procedure act_UploadArquivosExecute(Sender: TObject);
    procedure act_DownloadArquivoExecute(Sender: TObject);
    procedure act_PropriedadeArquivoExecute(Sender: TObject);
  private
    procedure IconFileGrid(AArquivo: string; AImageList: TImageList; AField: TGraphicField);
    procedure DataArquivo;
    procedure DataPasta;
    procedure StatusTela;
    { Private declarations }
  public
    { Public declarations }
    class procedure Inicia(const ACliente: string);
    class function IniciaPesquisaArquivo(const APesquisa: Boolean = true): OleVariant;
  end;

var
  F_CadAnArquivo: TF_CadAnArquivo;

implementation

{$R *.dfm}

procedure TF_CadAnArquivo.act_DownloadArquivoExecute(Sender: TObject);
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
  NovoArquivo: string;
  dataAux: TClientDataSet;
  book: string;
begin
  inherited;
  if ValidaSelecao(cds_arquivo.data, cds_arquivo.FieldByName('ARQ_Sel')) then
    begin
      if MessageDlg('Confirma download de arquivos para o arquivo do cliente '+ cds_dados.FieldByName('CLI_Nome').AsString, mtWarning, mbYesNo, 0) = mrYes then
        begin
          book:= cds_arquivo.Bookmark;
          cds_arquivo.DisableControls;
          try
            cds_arquivo.First;
            while not cds_arquivo.Eof do
              begin
                if cds_arquivo.FieldByName('ARQ_Sel').AsBoolean then
                  begin
                    dlgSave_Download.FileName:= cds_arquivo.FieldByName('ARQ_Nome').AsString;
                    if dlgSave_Download.Execute then
                      begin
                        CopyFile(PAnsiChar(cds_arquivo.FieldByName('ARQ_Path').AsString), PAnsiChar(dlgSave_Download.FileName));
                        cds_arquivo.Edit;
                        cds_arquivo.FieldByName('ARQ_Sel').AsBoolean:= False;
                        cds_arquivo.Post;
                      end;
                    cds_arquivo.Next;
                  end
                else
                  cds_arquivo.Next;
              end;
          finally
            cds_arquivo.Bookmark:= book;
            cds_arquivo.EnableControls;
          end;
        end;
    end
  else
    MessageDlg('Não há arquivos selecionados para download', mtInformation, [mbOK], 0);    
end;

procedure TF_CadAnArquivo.act_ExcluirArquivoExecute(Sender: TObject);
var
  excluido: Boolean;
begin
  inherited;
  excluido:= False;
  if ValidaSelecao(cds_arquivo.data, cds_arquivo.FieldByName('ARQ_Sel')) then
    begin
      if MessageDlg('Deseja excluir os arquivos selecionados ?', mtWarning, mbYesNo, 0) = mrYes then
        begin
          cds_arquivo.DisableControls;
          try
            cds_arquivo.First;
            while not cds_arquivo.Eof do
              begin
                if cds_arquivo.FieldByName('ARQ_Sel').AsBoolean then
                  begin
                    DeleteFile(cds_arquivo.FieldByName('ARQ_Path').AsString);
                    if not FileExists(cds_arquivo.FieldByName('ARQ_Path').AsString) then
                      begin
                        if DM.cds_arquivo.Locate('ARQ_Cod', cds_arquivo.FieldByName('ARQ_Cod').AsInteger, []) then
                          begin
                            DM.cds_arquivo.Delete;
                            excluido:= True;
                          end;
                      end;
                    cds_arquivo.Next;
                  end
                else
                  cds_arquivo.Next;
              end;
            if excluido then
              begin
                VerificaArquivos(cds_arquivo.Data);
                VerificaPastas(cds_pasta.Data);
                DataArquivo;
                DataPasta;                
                grid_base.Update;
                vwl_pasta.DataController.UpdateData;
                vwl_arquivo.DataController.UpdateData;
              end;
          finally
            cds_arquivo.EnableControls;
          end;
        end;
    end
  else
    MessageDlg('Não há arquivos selecionados para exclusão', mtInformation, [mbOK], 0);
end;

procedure TF_CadAnArquivo.act_ExecutarSelecaoArquivoExecute(Sender: TObject);
var
  book: string;
  Imagens, ProcessUnit, ProcessoList, Modulos, ModulosAux: TClientDataSet;
begin
  inherited;
  if ValidaSelecao(cds_arquivo.data, cds_arquivo.FieldByName('ARQ_Sel')) then
    begin
      if MessageDlg('Deseja executar os arquivos selecionados ?', mtWarning, mbYesNo, 0) = mrYes then
        begin
          Imagens:= TClientDataSet.Create(Self);
          Imagens.FieldDefs.Add('Imagem', ftGraphic);
          Imagens.CreateDataSet;
          ProcessoList:= TClientDataSet.Create(Self);
          CriaEstruturaArquivo(ProcessoList);
          book:= cds_arquivo.Bookmark;
          cds_arquivo.DisableControls;
          try
            cds_arquivo.First;
            while not cds_arquivo.Eof do
              begin
                if cds_arquivo.FieldByName('ARQ_Sel').AsBoolean then
                  begin
                    if ExtractFileExt(cds_arquivo.FieldByName('ARQ_Path').AsString) = '.'+cs_SCREEN then
                      begin
                        Imagens.Insert;
                        TGraphicField(Imagens.FieldByName('Imagem')).LoadFromFile(cds_arquivo.FieldByName('ARQ_Path').AsString);
                        Imagens.Post;
                      end
                    else if ExtractFileExt(cds_arquivo.FieldByName('ARQ_Path').AsString) = '.'+cs_PROCESS then
                      begin
                        ProcessUnit:= TClientDataSet.Create(Self);
                        try
                          ProcessUnit.LoadFromFile(cds_arquivo.FieldByName('ARQ_Path').AsString);
                          if ProcessUnit.RecordCount > 0 then
                            begin
                              ProcessUnit.First;
                              while not ProcessUnit.Eof do
                                begin
                                  Modulos:= TClientDataSet.Create(Self);
                                  try
                                    CriaEstruturaModulos(Modulos);
                                    ModulosAux:= TClientDataSet.Create(Application);
                                    with ModulosAux do
                                      begin
                                        try
                                          DataSetField:= TDataSetField(ProcessUnit.FieldByName('Modulos'));
                                          First;
                                          Next;
                                          while not eof do
                                            begin
                                              Modulos.AppendRecord([Integer(DataSetField.FieldValues[0]),
                                                                       string(DataSetField.FieldValues[1]),
                                                                       string(DataSetField.FieldValues[2])]);
                                              Next;
                                            end;

                                          ProcessoList.AppendRecord([ProcessUnit.FieldByName('ACodigo').AsInteger,
                                                                     ProcessUnit.FieldByName('Codigo').AsInteger,
                                                                     ProcessUnit.FieldByName('Nome').AsString,
                                                                     ProcessUnit.FieldByName('Dominio').AsString,
                                                                     ProcessUnit.FieldByName('Usuario').AsString,
                                                                     ProcessUnit.FieldByName('Path').AsString,
                                                                     ProcessUnit.FieldByName('Data').AsDateTime,
                                                                     ModulosAux.DataSetField]);
                                        finally
                                          Free;
                                        end;
                                      end;
                                  finally
                                    Modulos.Free;
                                  end;
                                  ProcessUnit.Next;
                                end;
                            end;
                        finally
                          ProcessUnit.Free;
                        end;
                      end     
                    else
                      ExecFileArq(cds_arquivo.FieldByName('ARQ_Path').AsString, Self.Handle);
                    cds_arquivo.Next;
                  end
                else
                  cds_arquivo.Next;
              end;
            if Imagens.RecordCount > 0 then
              TF_VisualizadorImagem.Inicia(Imagens.Data);
            if ProcessoList.RecordCount > 0 then
              TF_VisualizadorProcessos.Inicia(ProcessoList.Data);
          finally
            cds_arquivo.Bookmark:= book;
            cds_arquivo.EnableControls;
            Imagens.Free;
            ProcessoList.Free;
          end;
        end;
    end
  else
    MessageDlg('Não há arquivos selecionados para execução', mtInformation, [mbOK], 0);
end;

procedure TF_CadAnArquivo.act_PropriedadeArquivoExecute(Sender: TObject);
var
  list: TStringList;
begin
  inherited;
  list:= TStringList.Create;
  try
    PropriedadeArquivo(cds_arquivo.FieldByName('ARQ_Path').AsString, list);
    MessageDlg(list.Text, mtInformation, [mbOK], 0);
  finally
    list.Free;
  end;
end;

procedure TF_CadAnArquivo.act_UploadArquivosExecute(Sender: TObject);
var
  dirBase, dirArq, copya: string;
  dataAux: TClientDataSet;
begin
  inherited;
  if MessageDlg('Confirma upload de arquivos para o arquivo do cliente '+ cds_dados.FieldByName('CLI_Nome').AsString, mtWarning, mbYesNo, 0) = mrYes then
    begin
      if dlgOpen_Upload.Execute then
        begin
          dirBase:= Trim(ExtractFileDir(Application.ExeName)+'\CLIENTES\'+cds_dados.FieldByName('CLI_Cod').AsString);
          if not DirectoryExists(dirBase) then
          begin
            ForceDirectories(dirBase);
          end;

          if not DirectoryExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))) then
            ForceDirectories(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1))));

          if DirectoryExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))) then
            begin
              if not DM.cds_pasta.Locate('PST_Nome;PST_CLI_Cod', VarArrayOf([Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1))), cds_dados.FieldByName('CLI_Cod').AsInteger]) , []) then
                begin
                  DM.cds_pasta.Insert;
                  DM.cds_pasta.FieldByName('PST_CLI_Cod').AsInteger:= cds_dados.FieldByName('CLI_Cod').AsInteger;
                  DM.cds_pasta.FieldByName('PST_Nome').AsString:= Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)));
                  DM.cds_pasta.FieldByName('PST_Path').AsString:= dirBase+'\'+DM.cds_pasta.FieldByName('PST_Nome').AsString;
                  DM.cds_pasta.Post;
                end;
            end;

          dirArq:= dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))+'\';
          if DirectoryExists(dirArq) then
            begin
              dataAux:= TClientDataSet.Create(Self);
              dataAux.Data:= DM.cds_arquivo.Data;
              copya:= dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)));
              CopyFile(PAnsiChar(dlgOpen_Upload.FileName), PAnsiChar(copya), Self.Handle);
              if FileExists(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))+'\'+ExtractFileName(dlgOpen_Upload.FileName)) then
                begin
                  DM.cds_arquivo.Insert;
                  DM.cds_arquivo.FieldByName('ARQ_PST_Cod').AsInteger:= DM.cds_pasta.FieldByName('PST_Cod').AsInteger;
                  if dataAux.Locate('ARQ_Nome', DM.cds_arquivo.FieldByName('ARQ_Nome').AsString, []) then
                    DM.cds_arquivo.FieldByName('ARQ_Nome').AsString:= FormatDateTime('aaaammddhhnnsszzz', now)+'_'+ExtractFileName(dlgOpen_Upload.FileName)
                  else
                    DM.cds_arquivo.FieldByName('ARQ_Nome').AsString:= ExtractFileName(dlgOpen_Upload.FileName);
                  dataAux.Free;
                  DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString:= NovoGuid+ExtractFileExt(dlgOpen_Upload.FileName);
                  DM.cds_arquivo.FieldByName('ARQ_Path').AsString:= dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))+'\'+DM.cds_arquivo.FieldByName('ARQ_NomeGuid').AsString;
                  DM.cds_arquivo.FieldByName('Data').AsDateTime:= Now;
                  DM.cds_arquivo.Post;
                  RenameFile(dirBase+'\'+Trim(UpperCase(copy(ExtractFileExt(dlgOpen_Upload.FileName), 2, length(dlgOpen_Upload.FileName) - 1)))+'\'+DM.cds_arquivo.FieldByName('ARQ_Nome').AsString, DM.cds_arquivo.FieldByName('ARQ_Path').AsString)
                end;
            end;
        end;
      DataArquivo;
      DataPasta;
      grid_base.Update;
      vwl_pasta.DataController.UpdateData;
      vwl_arquivo.DataController.UpdateData;
    end;
end;

procedure TF_CadAnArquivo.DataArquivo;
begin
  cds_arquivo.Close;
  cds_arquivo.FieldDefs.Clear;
  cds_arquivo.DisableControls;

  try
    with cds_arquivo do
      begin
        with FieldDefs do
          begin
            Add('ARQ_Sel', ftBoolean);
            Add('ARQ_Icon', ftGraphic);
            Add('ARQ_Cod', ftInteger);
            Add('ARQ_PST_Cod', ftInteger);
            Add('ARQ_Nome', ftString, 100);
            Add('ARQ_Path', ftString, 150);
            Add('ARQ_Obs', ftMemo);
            Add('ARQ_USU_Cod', ftInteger);
            Add('Data', ftDateTime);
            Add('ARQ_NomeGuid', ftString, 100);
          end;
        CreateDataSet;
      end;

    with TClientDataSet.Create(Self) do
      begin
        try
          Data:= DM.cds_arquivo.Data;
          First;
          while not Eof do
            begin
              cds_arquivo.Insert;
              cds_arquivo.FieldByName('ARQ_Sel').AsBoolean:= False;
              cds_arquivo.FieldByName('ARQ_Cod').AsInteger:= FieldByName('ARQ_Cod').AsInteger;
              cds_arquivo.FieldByName('ARQ_PST_Cod').AsInteger:= FieldByName('ARQ_PST_Cod').AsInteger;
              cds_arquivo.FieldByName('ARQ_Nome').AsString:= FieldByName('ARQ_Nome').AsString;
              cds_arquivo.FieldByName('ARQ_Path').AsString:= FieldByName('ARQ_Path').AsString;
              cds_arquivo.FieldByName('ARQ_Obs').AsString:= FieldByName('ARQ_Obs').AsString;
              cds_arquivo.FieldByName('ARQ_USU_Cod').AsInteger:= FieldByName('ARQ_USU_Cod').AsInteger;
              cds_arquivo.FieldByName('Data').AsDateTime:= FieldByName('Data').AsDateTime;
              cds_arquivo.FieldByName('ARQ_NomeGuid').AsString:= FieldByName('ARQ_NomeGuid').AsString;
              IconFileGrid(cds_arquivo.FieldByName('ARQ_Path').AsString, il_associacao, TGraphicField(cds_arquivo.FieldByName('ARQ_Icon')));
              cds_arquivo.Post;
              Next;
            end;
        finally
          Free;
        end;
      end;
    cds_arquivo.IndexFieldNames:= 'ARQ_PST_Cod';
  finally
    cds_arquivo.EnableControls;
  end;
end;

procedure TF_CadAnArquivo.DataPasta;
begin
  cds_pasta.Close;
  cds_pasta.FieldDefs.Clear;
  cds_pasta.DisableControls;
  try
    with cds_pasta do
      begin
        with FieldDefs do
          begin
            Add('PST_Sel', ftBoolean);
            Add('PST_Cod', ftInteger);
            Add('PST_CLI_Cod', ftInteger);
            Add('PST_Nome', ftString, 100);
            Add('PST_Obs', ftMemo);
            Add('PST_Path', ftString, 150);
          end;
        CreateDataSet;
      end;

    with TClientDataSet.Create(Self) do
      begin
        try
          Data:= DM.cds_pasta.Data;;
          First;
          while not Eof do
            begin
              cds_pasta.AppendRecord([
              False,
              FieldByName('PST_Cod').AsInteger,
              FieldByName('PST_CLI_Cod').AsInteger,
              FieldByName('PST_Nome').AsString + ' - ' +TamanhoDaPastaT(FieldByName('PST_Path').AsString),
              FieldByName('PST_Obs').AsString,
              FieldByName('PST_Path').AsString]);
              Next;
            end;
        finally
          Free;
        end;
      end;
    cds_pasta.IndexFieldNames:= 'PST_CLI_Cod';
  finally
    cds_pasta.EnableControls;
  end;
end;

procedure TF_CadAnArquivo.StatusTela;
begin
  act_UploadArquivos.Enabled:= not cds_dados.IsEmpty;
  act_ExcluirArquivo.Enabled:= not cds_arquivo.IsEmpty;
  act_ExecutarSelecaoArquivo.Enabled:= not cds_arquivo.IsEmpty;
  act_PropriedadeArquivo.Enabled:= not cds_arquivo.IsEmpty;
end;

procedure TF_CadAnArquivo.FormCreate(Sender: TObject);
begin
  VerificaArquivos(DM.cds_arquivo.Data);
  VerificaPastas(DM.cds_pasta.Data);
  DataArquivo;
  DataPasta;
  SetInformacoes(DM.cds_clientes, 'CLI_Nome', 'CLI_Cod', 'Data');
  StatusTela;
  inherited;
end;

procedure TF_CadAnArquivo.IconFileGrid(AArquivo: string; AImageList: TImageList;
  AField: TGraphicField);
var
  IconIndex : word;
  Buffer: array[0..2048] of char;
  IconHandle: HIcon;
  Icone: TIcon;
  Stream: TMemoryStream;
  image: TImage;
begin
  image:= TImage.Create(Self);
  Stream:= TMemoryStream.Create;
  try
    StrCopy(@Buffer, PAnsiChar(AArquivo));
    IconIndex := 0;
    IconHandle := ExtractAssociatedIcon(HInstance, Buffer, IconIndex);
    if IconHandle <> 0 then
      begin
        Icone:= TIcon.Create;
        try
          Icone.Handle:= IconHandle;
          AImageList.Clear;
          AImageList.AddIcon(Icone);
          AImageList.GetIcon(0, image.Picture.Icon);
          image.Picture.Icon.SaveToStream(Stream);
        finally
          Icone.Free;
        end;
      end;
    Stream.Position:= 0;
    (AField as TGraphicField).LoadFromStream(Stream);
  finally
    Stream.Free;
    image.Free;
  end;

end;

class procedure TF_CadAnArquivo.Inicia(const ACliente: string);
begin
  with Self.Create(Application) do
    begin
      try
        cds_dados.Filtered:= False;
        cds_dados.Filter:= 'CLI_Cod = '+ACliente;
        cds_dados.Filtered:= True;
        grid_base.Update;
        vwl_pasta.DataController.UpdateData;
        vwl_arquivo.DataController.UpdateData;
        pnl_Consulta.Hide;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

class function TF_CadAnArquivo.IniciaPesquisaArquivo(
  const APesquisa: Boolean): OleVariant;
begin
  with Self.Create(Application) do
    begin
      try
        with TClientDataSet.Create(nil) do
          begin
            try
              with FieldDefs do
                begin
                  Add('Codigo', ftInteger);
                  Add('Valor', ftString, 100);
                end;
              CreateDataSet;
              FPesquisa:= APesquisa;
              ShowModal;
              AppendRecord([cds_arquivo.FieldByName('ARQ_Cod').AsInteger, cds_arquivo.FieldByName('ARQ_Path').AsString]);
              Result:= Data;
            finally
              Free;
            end;
          end;
      finally
        Free;
      end;
    end;
end;

procedure TF_CadAnArquivo.vwl_arquivoColumn3PropertiesChange(Sender: TObject);
begin
  inherited;
//  if cds_arquivo.FieldByName('ARQ_Sel').AsBoolean then
//    begin
//      act_ExcluirArquivo.Enabled:= True;
//      act_ExcluirArquivo.Caption:= 'Excluir arquivo selecionado';
//    end
//  else
//    begin
//      act_ExcluirArquivo.Enabled:= False;
//      act_ExcluirArquivo.Caption:= 'Excluir';
//    end;
end;

procedure TF_CadAnArquivo.vwl_arquivoDblClick(Sender: TObject);
var
  Imagens, ProcessUnit: TClientDataSet;
begin
  inherited;
  if FPesquisa then
    begin
      Close;
      Abort;
    end
  else
    begin
      Imagens:= TClientDataSet.Create(Self);
      Imagens.FieldDefs.Add('Imagem', ftGraphic);
      Imagens.CreateDataSet;
      try
        if ExtractFileExt(cds_arquivo.FieldByName('ARQ_Path').AsString) = '.'+cs_SCREEN then
          begin
            Imagens.Insert;
            TGraphicField(Imagens.FieldByName('Imagem')).LoadFromFile(cds_arquivo.FieldByName('ARQ_Path').AsString);
            Imagens.Post;
            TF_VisualizadorImagem.Inicia(Imagens.Data);
          end
        else if ExtractFileExt(cds_arquivo.FieldByName('ARQ_Path').AsString) = '.'+cs_PROCESS then
          begin
            ProcessUnit:= TClientDataSet.Create(Self);
            try
              ProcessUnit.LoadFromFile(cds_arquivo.FieldByName('ARQ_Path').AsString);
              if ProcessUnit.RecordCount > 0 then
                TF_VisualizadorProcessos.Inicia(ProcessUnit.Data);
            finally
              ProcessUnit.Free;
            end;
          end
        else
          ExecFileArq(cds_arquivo.FieldByName('ARQ_Path').AsString, Self.Handle);
      finally
        Imagens.Free;
      end;
    end;
end;

procedure TF_CadAnArquivo.vwl_arquivoTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText:= 'Quantidade de arquivos: '+AText;
end;

procedure TF_CadAnArquivo.vwl_pastaColumn2PropertiesChange(Sender: TObject);
begin
  inherited;
  if cds_pasta.FieldByName('PST_Sel').AsBoolean then
    begin
      act_ExcluirArquivo.Enabled:= True;
      act_ExcluirArquivo.Caption:= 'Excluir pasta selecioanda';
    end
  else
    begin
      act_ExcluirArquivo.Enabled:= False;
      act_ExcluirArquivo.Caption:= 'Excluir';
    end;
end;

procedure TF_CadAnArquivo.vwl_pastaTcxGridDBDataControllerTcxDataSummaryFooterSummaryItems0GetText(
  Sender: TcxDataSummaryItem; const AValue: Variant; AIsFooter: Boolean;
  var AText: string);
begin
  inherited;
  AText:= 'Quantidade de pastas: '+AText; 
end;

end.
