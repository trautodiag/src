unit Unt_CadAnProtocolos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  Menus, cxContainer, cxEdit, ImgList, ActnList, cxScrollBox, StdCtrls,
  cxTextEdit, cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls, cxPC, Unt_CadProtocolos,
  Unit_DM, Unt_Util, DB, DBClient, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxDBData, cxLocalization, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TF_CadAnProtocolos = class(TF_BaseAnCad)
    cds_Clientes: TClientDataSet;
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    vwl_baseColumn4: TcxGridDBColumn;
    vwl_baseColumn5: TcxGridDBColumn;
    cds_empresa: TClientDataSet;
    cds_usuario: TClientDataSet;
    cds_ItensProt: TClientDataSet;
    ds_ItensProt: TDataSource;
    tbl_itens: TcxGridLevel;
    vwl_itens: TcxGridDBTableView;
    vwl_itensColumn1: TcxGridDBColumn;
    vwl_itensColumn2: TcxGridDBColumn;
    vwl_itensColumn3: TcxGridDBColumn;
    vwl_itensColumn4: TcxGridDBColumn;
    vwl_itensColumn5: TcxGridDBColumn;
    vwl_itensColumn6: TcxGridDBColumn;
    cds_documentos: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    procedure vwl_baseColumn2GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure vwl_baseColumn3GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure vwl_baseColumn4GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
    procedure vwl_itensColumn2GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DblClica(Sender: TObject); override;
  end;

var
  F_CadAnProtocolos: TF_CadAnProtocolos;

implementation

{$R *.dfm}

procedure TF_CadAnProtocolos.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadProtocolos.Inicia(Self.Handle);
      cds_ItensProt.Data:= DM.cds_itensProtocolo.Data;
//    end;
end;

procedure TF_CadAnProtocolos.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        //Excluir itens
        DM.cds_itensProtocolo.Filtered:= False;
        DM.cds_itensProtocolo.Filter:= 'ITE_PRO_Cod = '+TabelaAtualizar.FieldByName(FieldChave).AsString;
        DM.cds_itensProtocolo.Filtered:= True;
        DM.cds_itensProtocolo.First;
        while not DM.cds_itensProtocolo.eof do
          begin
            DM.cds_itensProtocolo.Delete;
          end;
        DM.cds_itensProtocolo.Filtered:= False;
        TabelaAtualizar.Delete;
        inherited;
        cds_ItensProt.Data:= DM.cds_itensProtocolo.Data;
//        RecriaIcons;
      end;
end;

procedure TF_CadAnProtocolos.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadProtocolos.Inicia(Self.Handle);
  cds_ItensProt.Data:= DM.cds_itensProtocolo.Data;
end;

procedure TF_CadAnProtocolos.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadProtocolos.Inicia(Self.Handle, False);
end;

procedure TF_CadAnProtocolos.FormCreate(Sender: TObject);
begin
  cds_Clientes.Data:= DM.cds_clientes.Data;
  cds_empresa.Data:= DM.cds_empresa.Data;
  cds_usuario.Data:= DM.cds_usuarios.Data;
  cds_ItensProt.Data:= DM.cds_itensProtocolo.Data;
  cds_documentos.Data:= DM.cds_documentos.Data;
  SetInformacoes(DM.cds_protocolos, 'PRO_Cod', 'PRO_Cod', 'Data', cs_Protocolo);
//  RecriaIcons;
  inherited;
end;

procedure TF_CadAnProtocolos.vwl_baseColumn2GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_empresa.Filtered:= False;
      cds_empresa.Filter:= 'EMP_Cod =' +AText;
      cds_empresa.Filtered:= True;
      if not cds_empresa.IsEmpty then
        AText:= cds_empresa.FieldByName('EMP_Nome').AsString
      else
        AText:= 'Empresa não identificada';
    end
  else
    AText:= 'Empresa não identificada';
end;

procedure TF_CadAnProtocolos.vwl_baseColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_Clientes.Filtered:= False;
      cds_Clientes.Filter:= 'CLI_Cod =' +AText;
      cds_Clientes.Filtered:= True;
      if not cds_Clientes.IsEmpty then
        AText:= cds_Clientes.FieldByName('CLI_Nome').AsString
      else
        AText:= 'Cliente não identificado';
    end
  else
    AText:= 'Cliente não identificado';
end;

procedure TF_CadAnProtocolos.vwl_baseColumn4GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_usuario.Filtered:= False;
      cds_usuario.Filter:= 'USU_Cod =' +AText;
      cds_usuario.Filtered:= True;
      if not cds_usuario.IsEmpty then
        AText:= cds_usuario.FieldByName('USU_Nome').AsString
      else
        AText:= 'Usuario não identificado';
    end
  else
    AText:= 'Usuario não identificado';
end;

procedure TF_CadAnProtocolos.vwl_itensColumn2GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  if trim(AText) <> '' then
    begin
      cds_documentos.Filtered:= False;
      cds_documentos.Filter:= 'DOC_Cod =' +AText;
      cds_documentos.Filtered:= True;
      if not cds_documentos.IsEmpty then
        AText:= cds_documentos.FieldByName('DOC_Nome').AsString
      else
        AText:= 'Documento não identificado';
    end
  else
    AText:= 'Documento não identificado';
end;

end.
