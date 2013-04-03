unit Unt_CadProtocolos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseCad, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  Menus, ActnList, StdCtrls, cxButtons, ExtCtrls, cxPC, Unit_DM, db, Mask,
  DBCtrls, cxContainer, cxEdit, cxScrollBox, cxCurrencyEdit, cxDBEdit, DBClient,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Unt_CadAnClientes, Unt_CadAnDocumentos,
  ImgList, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, dxSkinBlack,
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
  TF_CadProtocolos = class(TF_BaseCad)
    pnl_ProtBase: TPanel;
    lbl_cod: TLabel;
    dbedt_PRO_Cod: TDBEdit;
    lbl_cliente: TLabel;
    btn_psq: TcxButton;
    edt_NomeCliente: TEdit;
    Panel1: TPanel;
    btn_Novo: TcxButton;
    btn_Editar: TcxButton;
    btn_Excluir: TcxButton;
    act_NovoDocumento: TAction;
    act_ExcluirDocumento: TAction;
    act_EditarDocumento: TAction;
    pnl_documentosProt: TPanel;
    lbl_codDocumento: TLabel;
    dbedt_ITE_DOC_Cod: TDBEdit;
    edt_Documento: TEdit;
    Label1: TLabel;
    dbedt_ITE_DOC_Comp: TDBEdit;
    lbl_vencimento: TLabel;
    dbdt_vencimento: TcxDBDateEdit;
    lbl_valor: TLabel;
    edtCur_Valor: TcxDBCurrencyEdit;
    lbl_observacao: TLabel;
    dbedt_Observacao: TDBEdit;
    act_SalvarDocumento: TAction;
    btn_SalvarDocumento: TcxButton;
    dbedt_PRO_CLI_Cod: TDBEdit;
    il_base: TImageList;
    cds_Clientes: TClientDataSet;
    cds_Documentos: TClientDataSet;
    btn_selDoc: TcxButton;
    btn_CancelarDocumento: TcxButton;
    act_CancelarDocumento: TAction;
    grid_base: TcxGrid;
    vwl_base: TcxGridDBTableView;
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    tbl_base: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure act_SalvarExecute(Sender: TObject);
    procedure act_CancelarExecute(Sender: TObject);
    procedure act_NovoDocumentoExecute(Sender: TObject);
    procedure btn_psqClick(Sender: TObject);
    procedure act_SalvarDocumentoExecute(Sender: TObject);
    procedure dbedt_PRO_CLI_CodExit(Sender: TObject);
    procedure dbedt_PRO_CLI_CodKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure act_ExcluirDocumentoExecute(Sender: TObject);
    procedure act_EditarDocumentoExecute(Sender: TObject);
    procedure dbedt_ITE_DOC_CodExit(Sender: TObject);
    procedure btn_selDocClick(Sender: TObject);
    procedure dbedt_ITE_DOC_CodKeyPress(Sender: TObject; var Key: Char);
    procedure act_CancelarDocumentoExecute(Sender: TObject);
    procedure vwl_baseCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure vwl_baseColumn2GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
    //function GetSelecionado: Integer;
    procedure DblClica(Sender: TObject);
    function ValidaCadastro: Boolean;
    function ValidaDocumento: Boolean;
    procedure SetStatus;
    //procedure LimpaIcons;
    //procedure OrganizaIcons;
    //procedure CriaIcons(ATabela: TClientDataSet; AField, AFieldChave, AFieldData: string; AIndex: integer);
  public
    { Public declarations }
  end;

var
  F_CadProtocolos: TF_CadProtocolos;

implementation

{$R *.dfm}

procedure TF_CadProtocolos.act_CancelarDocumentoExecute(Sender: TObject);
begin
  inherited;
  DM.cds_itensProtocolo.Cancel;
end;

procedure TF_CadProtocolos.act_CancelarExecute(Sender: TObject);
begin
  DM.cds_protocolos.Cancel;
  inherited;
end;

procedure TF_CadProtocolos.act_EditarDocumentoExecute(Sender: TObject);
begin
  inherited;
//  if DM.cds_itensProtocolo.Locate('ITE_Cod', GetSelecionado, []) then
    begin
      DM.cds_itensProtocolo.Edit;
      dbedt_ITE_DOC_Cod.SetFocus;
    end;
end;

procedure TF_CadProtocolos.act_ExcluirDocumentoExecute(Sender: TObject);
begin
  inherited;
  //if DM.cds_itensProtocolo.Locate('ITE_Cod', GetSelecionado, []) then
    if MessageDlg('Deseja excluir o registro selecionado ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        DM.cds_itensProtocolo.Delete;
        //CriaIcons(DM.cds_itensProtocolo, 'ITE_DOC_Cod', 'ITE_Cod', 'Data', 0);
        //OrganizaIcons;
      end;
end;

procedure TF_CadProtocolos.act_NovoDocumentoExecute(Sender: TObject);
begin
  inherited;
  DM.cds_itensProtocolo.Insert;
  with TClientDataSet.Create(nil) do
    begin
      try
        Data:= TF_CadAnDocumentos.IniciaPesquisa;
        if not (DM.cds_itensProtocolo.State in dsEditModes) then
          DM.cds_itensProtocolo.Insert;
        dbedt_ITE_DOC_Cod.Text:= FieldByName('Codigo').AsString;
        edt_Documento.Text:=  FieldByName('Valor').AsString;
      finally
        Free;
      end;
    end;
  act_SalvarDocumento.Enabled:= Trim(dbedt_ITE_DOC_Cod.Text) <> '';
  act_CancelarDocumento.Enabled:= act_SalvarDocumento.Enabled;
  if Trim(edt_Documento.Text) <> '' then
    dbedt_ITE_DOC_Comp.SetFocus;
end;

procedure TF_CadProtocolos.act_SalvarDocumentoExecute(Sender: TObject);
begin
  if ValidaDocumento then
    begin
      inherited;
      DM.cds_itensProtocoloData.asDateTime:= now;
      DM.cds_itensProtocoloITE_PRO_Cod.AsInteger:= DM.cds_protocolosPRO_Cod.AsInteger;
      DM.cds_itensProtocolo.Post;
      if not DM.cds_itensProtocolo.IsEmpty then
        begin
          act_ExcluirDocumento.Enabled:= True;
          act_EditarDocumento.Enabled:= True;
        end;
//      CriaIcons(DM.cds_itensProtocolo, 'ITE_DOC_Cod', 'ITE_Cod', 'Data', 0);
//      OrganizaIcons;
    end;
end;

procedure TF_CadProtocolos.act_SalvarExecute(Sender: TObject);
begin
  if ValidaCadastro then
    begin
      DM.cds_protocolosData.AsDateTime:= Now;
      DM.cds_protocolos.Post;
      inherited;
    end;
end;

procedure TF_CadProtocolos.btn_psqClick(Sender: TObject);
begin
  inherited;
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
  act_NovoDocumento.Enabled:= Trim(dbedt_PRO_CLI_Cod.Text) <> '';
  act_SalvarDocumento.Enabled:= act_NovoDocumento.Enabled;
  act_CancelarDocumento.Enabled:= act_SalvarDocumento.Enabled;
  if act_NovoDocumento.Enabled then
    act_NovoDocumentoExecute(Self);
end;

procedure TF_CadProtocolos.btn_selDocClick(Sender: TObject);
begin
  with TClientDataSet.Create(nil) do
    begin
      try
        Data:= TF_CadAnDocumentos.IniciaPesquisa;
        dbedt_ITE_DOC_Cod.Text:= FieldByName('Codigo').AsString;
        edt_Documento.Text:=  FieldByName('Valor').AsString;
      finally
        Free;
      end;
    end;
  act_SalvarDocumento.Enabled:= Trim(dbedt_ITE_DOC_Cod.Text) <> '';
  act_CancelarDocumento.Enabled:= act_SalvarDocumento.Enabled;
  if Trim(dbedt_ITE_DOC_Cod.Text) <> '' then
    dbedt_ITE_DOC_Comp.SetFocus;

end;

//procedure TF_CadProtocolos.CriaIcons(ATabela: TClientDataSet; AField,
//  AFieldChave, AFieldData: string; AIndex: integer);
//var
//  i: Integer;
//  icon: TImagePanel;
//begin
//  ATabela.First;
//  LimpaIcons;
//  while not ATabela.Eof do
//    begin
//      icon:= TImagePanel.Create(self);
//      with icon do
//        begin
//          Parent:= scroll_documentos;
//          il_base.GetBitmap(AIndex, icon.ImagePanel.Picture.Bitmap);
//          if cds_Documentos.Locate('DOC_Cod', ATabela.FieldByName(AField).AsInteger, []) then
//            ValorImagem:= cds_Documentos.FieldByName('DOC_Nome').AsString;
//          Data:= ATabela.FieldByName(AFieldData).AsDateTime;
//          ShowHint:= True;
//          Hint:= ValorImagem;
//          icon.ImagePanel.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//          icon.ImagePanel.OnMouseDown:= nil;
//          icon.ImagePanel.OnMouseMove:= nil;
//          icon.ImagePanel.OnMouseUp:= nil;
//          icon.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//          icon.Selecionado:= True;
//          icon.ImagePanel.OnDblClick:= DblClica;
//        end;
//      ATabela.Next;
//    end;
//  icon.ImagePanel.OnDblClick(Self);
//end;

procedure TF_CadProtocolos.dbedt_ITE_DOC_CodExit(Sender: TObject);
begin
  if Trim(dbedt_ITE_DOC_Cod.Text) <> '' then
    begin
      if cds_Documentos.Locate('DOC_Cod', Trim(dbedt_ITE_DOC_Cod.Text), []) then
        begin
          edt_Documento.Text:= cds_Documentos.FieldByName('DOC_Nome').AsString;
        end
      else
        begin
          dbedt_ITE_DOC_Cod.Clear;
          edt_Documento.Clear;
          if AnStatus = dsInsert then          
            btn_selDoc.Click;
        end;

    end
  else
    edt_NomeCliente.Clear;

  act_NovoDocumento.Enabled:= (Trim(dbedt_PRO_CLI_Cod.Text) <> '') and (AnStatus in dsEditModes);
  act_SalvarDocumento.Enabled:= act_NovoDocumento.Enabled;
  act_CancelarDocumento.Enabled:= act_SalvarDocumento.Enabled;
  if (act_NovoDocumento.Enabled) and (AnStatus = dsInsert) then
    act_NovoDocumentoExecute(Self);
end;

procedure TF_CadProtocolos.dbedt_ITE_DOC_CodKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_CadProtocolos.dbedt_PRO_CLI_CodExit(Sender: TObject);
begin
  inherited;
  if Trim(dbedt_PRO_CLI_Cod.Text) <> '' then
    begin
      if cds_Clientes.Locate('CLI_Cod', Trim(dbedt_PRO_CLI_Cod.Text), []) then
        edt_NomeCliente.Text:= cds_Clientes.FieldByName('CLI_Nome').AsString
      else
        begin
          dbedt_PRO_CLI_Cod.Clear;
          edt_NomeCliente.Clear;
          if AnStatus = dsInsert then          
            btn_psq.Click;
        end;
    end
  else
    edt_NomeCliente.Clear;

  act_NovoDocumento.Enabled:= (Trim(dbedt_PRO_CLI_Cod.Text) <> '') and (AnStatus in dsEditModes);
  act_SalvarDocumento.Enabled:= act_NovoDocumento.Enabled;
  act_CancelarDocumento.Enabled:= act_SalvarDocumento.Enabled;
  if (act_NovoDocumento.Enabled) and (AnStatus = dsInsert) then
    act_NovoDocumentoExecute(Self);
end;

procedure TF_CadProtocolos.dbedt_PRO_CLI_CodKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in['0'..'9',Chr(8)]) then Key:= #0;
end;

procedure TF_CadProtocolos.DblClica(Sender: TObject);
begin
//  if DM.cds_itensProtocolo.Locate('ITE_Cod', GetSelecionado, []) then
    begin
      if cds_Documentos.Locate('DOC_Cod', DM.cds_itensProtocolo.FieldByName('ITE_DOC_Cod').AsInteger, []) then
        edt_Documento.Text:= cds_Documentos.FieldByName('DOC_Nome').AsString;
    end;
end;

procedure TF_CadProtocolos.FormCreate(Sender: TObject);
begin
  inherited;
  cds_Clientes.Data:= DM.cds_clientes.Data;
  cds_Documentos.Data:= DM.cds_documentos.Data;
  DM.cds_itensProtocolo.Insert;
end;

procedure TF_CadProtocolos.FormShow(Sender: TObject);
begin
  inherited;
  SetStatus;

  if not DM.cds_itensProtocolo.IsEmpty then
    begin
      DM.cds_itensProtocolo.First;
    end;

  if Trim(dbedt_ITE_DOC_Cod.Text) <> '' then
    dbedt_ITE_DOC_Cod.OnExit(Self);

  if Trim(dbedt_PRO_CLI_Cod.Text) <> '' then
    dbedt_PRO_CLI_Cod.OnExit(Self);

  if (AnStatus in dsEditModes) then
    begin
      dbedt_PRO_CLI_Cod.SetFocus;
    end;
    
//  if not DM.cds_itensProtocolo.IsEmpty then
//    begin
//      CriaIcons(DM.cds_itensProtocolo, 'ITE_DOC_Cod', 'ITE_Cod', 'Data', 0);
//      OrganizaIcons;
//    end;

  if (AnStatus = dsEdit) and (not DM.cds_itensProtocolo.IsEmpty) then
    begin
      act_EditarDocumento.Enabled:= True;
      act_ExcluirDocumento.Enabled:= True;
    end;

  DM.cds_itensProtocolo.Filtered:= False;
  DM.cds_itensProtocolo.Filter:= 'ITE_PRO_Cod = '+Trim(dbedt_PRO_Cod.Text); 
  DM.cds_itensProtocolo.Filtered:= True;
end;

//function TF_CadProtocolos.GetSelecionado: Integer;
//var
//  i: Integer;
//begin
//  Result:= -1;
//  i:= scroll_documentos.ControlCount - 1;
//  while (i >= 0) do
//    begin
//      if scroll_documentos.Controls[i].ClassType = TImagePanel then
//        if TImagePanel(scroll_documentos.Controls[i]).Selecionado then
//          Result:= TImagePanel(scroll_documentos.Controls[i]).Tag;
//      Dec(i);
//    end;
//end;

//procedure TF_CadProtocolos.LimpaIcons;
//begin
//  while scroll_documentos.ControlCount > 0 do
//    begin
//      if scroll_documentos.Controls[scroll_documentos.ControlCount - 1].ClassType = TImagePanel then
//        scroll_documentos.Controls[scroll_documentos.ControlCount - 1].Free;
//    end;
//end;

//procedure TF_CadProtocolos.OrganizaIcons;
//var
//  linhas, colunas: Integer;
//  i: Integer;
//  lista: TClientDataSet;
//  control: TWinControl;
//begin
//  linhas:= 0;
//  colunas:= 0;
//
//  lista:= TClientDataSet.Create(Self);
//  try
//    with lista do
//      begin
//        with FieldDefs do
//          begin
//            Add('Tag', ftInteger);
//            Add('Handle', ftInteger);
//          end;
//        CreateDataSet;
//      end;
//
//    for I := 0 to scroll_documentos.ControlCount - 1 do
//      if scroll_documentos.Controls[i].ClassType = TImagePanel then
//        begin
//          lista.AppendRecord([TImagePanel(scroll_documentos.Controls[i]).ImagePanel.Tag,
//                              TImagePanel(scroll_documentos.Controls[i]).Handle]);
//        end;
//
//    lista.IndexFieldNames:= 'Tag';
//    lista.First;
//    while not lista.Eof do
//      begin
//        control:= FindControl(lista.FieldByName('Handle').AsInteger);
//        if control <> nil then
//          begin
//            if (TImagePanel(control).Width * (colunas + 1)) > (Self.Width) then
//              begin
//                inc(linhas);
//                colunas:= 0;
//              end;
//            TImagePanel(control).Left:=
//            (TImagePanel(control).Width * colunas) + (4 * colunas);
//            inc(colunas);
//            TImagePanel(control).Top:=
//            (linhas * TImagePanel(control).Height) + (4 * linhas);
//          end;
//        lista.Next;
//      end;
//  finally
//    lista.Free;
//  end;
//end;

procedure TF_CadProtocolos.SetStatus;
begin
  AnStatus:= DM.cds_protocolos.State;
end;

function TF_CadProtocolos.ValidaCadastro: Boolean;
begin
  Result:= True;

  if Trim(dbedt_PRO_CLI_Cod.Text) = '' then
    begin
      Result:= False;
      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
      dbedt_PRO_CLI_Cod.SetFocus;
      Exit;
    end;
//
//  if cbb_Setores.EditValue <= 0 then
//    begin
//      Result:= False;
//      MessageDlg(Format('%s', ['Campo obrigatorio']), mtError, [mbOK], 0);
//      cbb_Setores.SetFocus;
//      Exit;
//    end;
end;

function TF_CadProtocolos.ValidaDocumento: Boolean;
begin
  Result:= True;
end;

procedure TF_CadProtocolos.vwl_baseCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  inherited;
  dbedt_ITE_DOC_CodExit(Self)
end;

procedure TF_CadProtocolos.vwl_baseColumn2GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_Documentos.Filtered:= False;
      cds_Documentos.Filter:= 'DOC_Cod =' +AText;
      cds_Documentos.Filtered:= True;
      if not cds_Documentos.IsEmpty then
        AText:= cds_Documentos.FieldByName('DOC_Nome').AsString
      else
        AText:= 'Documento não identificado';
    end
  else
    AText:= 'Documento não identificado';
end;

end.
