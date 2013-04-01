unit Unt_BaseAnCad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, ComCtrls, StdCtrls, Buttons, ExtCtrls, DBClient, Unt_Util,
  ImgList, db, StrUtils, dxSkinsCore, dxSkinOffice2010Blue,
  dxSkinscxPCPainter, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, Menus, cxContainer, cxEdit, cxGroupBox, cxRadioGroup,
  cxButtons, cxPC, cxTextEdit, cxScrollBox, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxDBData, cxLocalization, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Silver, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxGridStrs;

type
  TOrganiza = (orgCod, orgData, orgNome);

  TF_BaseAnCad = class(TForm)
    pgctrl_base: TcxPageControl;
    ts_base: TcxTabSheet;
    pnl_Base: TPanel;
    pnl_Consulta: TPanel;
    grp_consulta: TGroupBox;
    grp_qtdRegistros: TGroupBox;
    lbl_qtd: TLabel;
    pnl_grid: TPanel;
    act_cadastros: TActionList;
    act_Novo: TAction;
    act_Editar: TAction;
    act_Excluir: TAction;
    il_base: TImageList;
    btn_Novo: TcxButton;
    btn_Editar: TcxButton;
    btn_Excluir: TcxButton;
    rg_base: TcxRadioGroup;
    btn_filtrar: TcxButton;
    edt_Consulta: TcxTextEdit;
    vwl_base: TcxGridDBTableView;
    tbl_base: TcxGridLevel;
    grid_base: TcxGrid;
    cds_dados: TClientDataSet;
    ds_dados: TDataSource;
    stylo_base: TcxStyleRepository;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_filtrarClick(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    //procedure cxRadioGroup1Click(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
    procedure cxTextEdit1Enter(Sender: TObject);
    procedure cxTextEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure vwl_baseCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure vwl_baseCellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    FTabelaAtualizar: TClientDataSet;
    FFieldTab: string;
    FIndexImg: Integer;
    FFieldChave: string;
    FFieldData: string;
    { Private declarations }
    //procedure LimpaIcons;
    procedure SetTabelaAtualizar(const Value: TClientDataSet);
    procedure SetValor(const Value: string);
    procedure SetIndexImg(const Value: Integer);
    procedure SetFieldChave(const Value: string);
    procedure SetFieldData(const Value: string);
    procedure Filtro;
    //function GetSelecionado: Integer;
    procedure SetTabelaDataSource(const Value: TDataSource);
  public
    //procedure RecriaIcons(const ALll: Boolean = True);
    //procedure CriaIcons(ATabela: TClientDataSet; AField, AFieldChave, AFieldData: string; AIndex: integer; const ALll: Boolean = True);
    property TabelaAtualizar: TClientDataSet read FTabelaAtualizar write SetTabelaAtualizar;
    property FieldTab: string read FFieldTab write SetValor;
    property FieldChave: string read FFieldChave write SetFieldChave;
    property FieldData: string read FFieldData write SetFieldData;
    //property IndexImg: Integer read FIndexImg write SetIndexImg;
    //property RegistroSelecionado: Integer read GetSelecionado;
    class function IniciaPesquisa(const APesquisa: Boolean = true): OleVariant;
    { Public declarations }
  protected
    FPesquisa: Boolean;
    FTabelaDataSource: TDataSource;
    procedure AtualizaResgistros(var Msg: TMessage); message WM_SALVO;
    procedure SetInformacoes(ATabelaAtualizar: TClientDataSet; AFieldTab, AFieldChave, AFieldData: string; const AIndexImg:Integer = -1);virtual;
    procedure DblClica(Sender: TObject); virtual;
    //procedure OrganizaIcons(const ATipo: TOrganiza = orgCod);
  end;

var
  F_BaseAnCad: TF_BaseAnCad;

implementation

{$R *.dfm}

procedure TF_BaseAnCad.DblClica(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsInteger, []) then
    begin
      if FPesquisa then
        begin
          Close;
          Abort;
        end;
    end;
end;

procedure TF_BaseAnCad.act_EditarExecute(Sender: TObject);
begin
 TabelaAtualizar.Edit;
end;

procedure TF_BaseAnCad.act_ExcluirExecute(Sender: TObject);
begin
  cds_dados.Data:= TabelaAtualizar.Data;
end;

procedure TF_BaseAnCad.act_NovoExecute(Sender: TObject);
begin
  TabelaAtualizar.Append;
end;

procedure TF_BaseAnCad.AtualizaResgistros(var Msg: TMessage);
var
  AnStatus: PChar;
  All: Boolean;
begin
  AnStatus:= PChar(Msg.LParam);
  case Integer(AnStatus) of
    cs_AnEdit:   All:= True;
    cs_AnInsert: All:= False;
  end;
  cds_dados.Data:= TabelaAtualizar.Data;
  //RecriaIcons(All);
end;

procedure TF_BaseAnCad.btn_filtrarClick(Sender: TObject);
begin
  Filtro;
end;

//procedure TF_BaseAnCad.CriaIcons(ATabela: TClientDataSet; AField, AFieldChave, AFieldData: string; AIndex: integer; const ALll: Boolean = True);
//var
//  i: Integer;
//  icon: TImagePanel;
//begin
//  if ALll then
//    begin
//      ATabela.First;
//      LimpaIcons;
//      while not ATabela.Eof do
//        begin
//          icon:= TImagePanel.Create(self);
//          with icon do
//            begin
//              Parent:= scrlbx_base;
//              il_base.GetBitmap(AIndex, icon.ImagePanel.Picture.Bitmap);
//              ValorImagem:= ATabela.FieldByName(AField).AsString;
//              Data:= ATabela.FieldByName(AFieldData).AsDateTime;
//              ShowHint:= True;
//              Hint:= ValorImagem;
//              icon.ImagePanel.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//              icon.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//              icon.ImagePanel.OnDblClick:= DblClica;
//            end;
//          ATabela.Next;
//        end;
//    end
//  else
//    begin
//      icon:= TImagePanel.Create(self);
//      with icon do
//        begin
//          Parent:= scrlbx_base;
//          il_base.GetBitmap(AIndex, icon.ImagePanel.Picture.Bitmap);
//          ValorImagem:= ATabela.FieldByName(AField).AsString;
//          Data:= ATabela.FieldByName(AFieldData).AsDateTime;
//          ShowHint:= True;
//          Hint:= ValorImagem;
//          icon.ImagePanel.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//          icon.Tag:= ATabela.FieldByName(AFieldChave).AsInteger;
//          icon.ImagePanel.OnDblClick:= DblClica;
//        end;
//    end;
//    OrganizaIcons;
//end;

procedure TF_BaseAnCad.cxButton1Click(Sender: TObject);
begin
  Filtro;
end;

//procedure TF_BaseAnCad.cxRadioGroup1Click(Sender: TObject);
//begin
//  case rg_base.Properties.Items.Items[rg_base.ItemIndex].Index of
//    0: OrganizaIcons(orgCod);
//    1: OrganizaIcons(orgNome);
//    2: OrganizaIcons(orgData);
//  end;
//end;

procedure TF_BaseAnCad.cxTextEdit1Enter(Sender: TObject);
begin
  edt_Consulta.Clear;
end;

procedure TF_BaseAnCad.cxTextEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    btn_filtrar.Click;
end;

procedure TF_BaseAnCad.Filtro;
var
  i, RegIni: Integer;
  fim: Boolean;
  campo, filtro: string;
begin
  RegIni:= cds_dados.RecordCount;
  fim:= False;
  for I := 0 to cds_dados.FieldCount - 1 do
    begin
      if not fim then
        begin
          try
            campo:= cds_dados.Fields.Fields[i].FieldName;
            case cds_dados.Fields.Fields[i].DataType of
              ftInteger, ftAutoInc:
                begin
                  filtro:= campo  + ' = ' + Trim(edt_Consulta.text);
                end;
              ftString:
                begin
                  filtro:= campo  + ' like ' + QuotedStr(Chr(37)+Trim(edt_Consulta.text) +Chr(37));
                end;
              ftDateTime:
                begin
                  if StrToDateDef(Trim(edt_Consulta.Text), Now + 1) <> (Now + 1) then
                    filtro:= campo  + ' = ' + Trim(edt_Consulta.text);
                end;
              else
              filtro:= campo  + ' like ' + QuotedStr(Chr(37)+Trim(edt_Consulta.text) +Chr(37));
            end;

            filtro:= ansiUpperCase(filtro);

            cds_dados.Filtered:= False;
            cds_dados.Filter:= filtro;
            cds_dados.Filtered:= True;

            lbl_qtd.Caption:= IntToStr(cds_dados.RecordCount);
            fim:= (cds_dados.RecordCount > 0);
          except
            //erro de conversao do tipo 
            fim:= False;
            lbl_qtd.Caption:= 'NaN';
          end;
        end;
    end;
//  if (TabelaAtualizar.RecordCount <> RegIni) then
//    RecriaIcons;
end;

procedure TF_BaseAnCad.FormCreate(Sender: TObject);
begin
  cxSetResourceString(@scxGridGroupByBoxCaption, 'Arraste as colunas para agrupa-las');
  FPesquisa:= False;
  SetInformacoes(TabelaAtualizar, FieldTab, FieldChave, FieldData);
  //OrganizaIcons;
  //rg_base.ItemIndex:= 0;
end;

procedure TF_BaseAnCad.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FTabelaDataSource);
end;

procedure TF_BaseAnCad.FormKeyPress(Sender: TObject; var Key: Char);
begin
  If key = #13 then
    Begin
      Key:= #0;
      Perform(Wm_NextDlgCtl,0,0);
    End;
end;

procedure TF_BaseAnCad.FormResize(Sender: TObject);
begin
  //OrganizaIcons;
  //rg_base.ItemIndex:= 0;
end;

procedure TF_BaseAnCad.FormShow(Sender: TObject);
begin
  lbl_qtd.Caption:= IntToStr(cds_dados.RecordCount);
end;

//function TF_BaseAnCad.GetSelecionado: Integer;
//var
//  i: Integer;
//begin
//  Result:= -1;
//  i:= scrlbx_base.ControlCount - 1;
//  while (i >= 0) do
//    begin
//      if scrlbx_base.Controls[i].ClassType = TImagePanel then
//        if TImagePanel(scrlbx_base.Controls[i]).Selecionado then
//          Result:= TImagePanel(scrlbx_base.Controls[i]).SelecionadoIndex;
//      Dec(i);
//    end;
//end;

class function TF_BaseAnCad.IniciaPesquisa(const APesquisa: Boolean): OleVariant;
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
              AppendRecord([cds_dados.FieldByName(FieldChave).AsInteger, cds_dados.FieldByName(FieldTab).AsString]);
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

//procedure TF_BaseAnCad.LimpaIcons;
//begin
//  while scrlbx_base.ControlCount > 0 do
//    begin
//      if scrlbx_base.Controls[scrlbx_base.ControlCount - 1].ClassType = TImagePanel then
//        scrlbx_base.Controls[scrlbx_base.ControlCount - 1].Free;
//    end;
//end;

//procedure TF_BaseAnCad.OrganizaIcons(const ATipo: TOrganiza);
//var
//  linhas, colunas: Integer;
//  i: Integer;
//  lista: TClientDataSet;
//  control: TWinControl;
//begin
//  linhas:= 0;
//  colunas:= 0;
//  try
//    case ATipo of
//      orgCod:
//        begin
//          lista:= TClientDataSet.Create(Self);
//          try
//            with lista do
//              begin
//                with FieldDefs do
//                  begin
//                    Add('Tag', ftInteger);
//                    Add('Handle', ftInteger);
//                  end;
//                CreateDataSet;
//              end;
//
//            for I := 0 to scrlbx_base.ControlCount - 1 do
//              if scrlbx_base.Controls[i].ClassType = TImagePanel then
//                begin
//                  lista.AppendRecord([TImagePanel(scrlbx_base.Controls[i]).ImagePanel.Tag,
//                                      TImagePanel(scrlbx_base.Controls[i]).Handle]);
//                end;
//
//            lista.IndexFieldNames:= 'Tag';
//            lista.First;
//            while not lista.Eof do
//              begin
//                control:= FindControl(lista.FieldByName('Handle').AsInteger);
//                if control <> nil then
//                  begin
//                    if (TImagePanel(control).Width * (colunas + 1)) > (Self.Width) then
//                      begin
//                        inc(linhas);
//                        colunas:= 0;
//                      end;
//                    TImagePanel(control).Left:=
//                    (TImagePanel(control).Width * colunas) + (4 * colunas);
//                    inc(colunas);
//                    TImagePanel(control).Top:=
//                    (linhas * TImagePanel(control).Height) + (4 * linhas);
//                  end;
//                lista.Next;
//              end;
//          finally
//            lista.Free;
//          end;
//        end;
//      orgData:
//        begin
//          lista:= TClientDataSet.Create(Self);
//          try
//            with lista do
//              begin
//                with FieldDefs do
//                  begin
//                    Add('Data', ftDateTime);
//                    Add('Handle', ftInteger);
//                  end;
//                CreateDataSet;
//              end;
//
//            for I := 0 to scrlbx_base.ControlCount - 1 do
//              if scrlbx_base.Controls[i].ClassType = TImagePanel then
//                begin
//                  lista.AppendRecord([TImagePanel(scrlbx_base.Controls[i]).Data,
//                                      TImagePanel(scrlbx_base.Controls[i]).Handle]);
//                end;
//
//            lista.IndexFieldNames:= 'Data';
//            lista.First;
//            while not lista.Eof do
//              begin
//                control:= FindControl(lista.FieldByName('Handle').AsInteger);
//                if control <> nil then
//                  begin
//                    if (TImagePanel(control).Width * (colunas + 1)) > (Self.Width) then
//                      begin
//                        inc(linhas);
//                        colunas:= 0;
//                      end;
//                    TImagePanel(control).Left:=
//                    (TImagePanel(control).Width * colunas) + (4 * colunas);
//                    inc(colunas);
//                    TImagePanel(control).Top:=
//                    (linhas * TImagePanel(control).Height) + (4 * linhas);
//                  end;
//                lista.Next;
//              end;
//          finally
//            lista.Free;
//          end;
//        end;
//      orgNome:
//        begin
//          lista:= TClientDataSet.Create(Self);
//          try
//            with lista do
//              begin
//                with FieldDefs do
//                  begin
//                    Add('Nome', ftString, 80);
//                    Add('Handle', ftInteger);
//                  end;
//                CreateDataSet;
//              end;
//
//            for I := 0 to scrlbx_base.ControlCount - 1 do
//              if scrlbx_base.Controls[i].ClassType = TImagePanel then
//                begin
//                  lista.AppendRecord([TImagePanel(scrlbx_base.Controls[i]).ValorImagem,
//                                      TImagePanel(scrlbx_base.Controls[i]).Handle]);
//                end;
//
//            lista.IndexFieldNames:= 'Nome';
//            lista.First;
//            while not lista.Eof do
//              begin
//                control:= FindControl(lista.FieldByName('Handle').AsInteger);
//                if control <> nil then
//                  begin
//                    if (TImagePanel(control).Width * (colunas + 1)) > (Self.Width) then
//                      begin
//                        inc(linhas);
//                        colunas:= 0;
//                      end;
//                    TImagePanel(control).Left:=
//                    (TImagePanel(control).Width * colunas) + (4 * colunas);
//                    inc(colunas);
//                    TImagePanel(control).Top:=
//                    (linhas * TImagePanel(control).Height) + (4 * linhas);
//                  end;
//                lista.Next;
//              end;
//          finally
//            lista.Free;
//          end;
//        end;
//    end;
//    lbl_qtd.Caption:= IntToStr(TabelaAtualizar.RecordCount);
//  except
//    on e: Exception do
//      MessageDlg(e.Message, mtError, [mbOK], 0);
//  end;
//end;

//procedure TF_BaseAnCad.RecriaIcons(const ALll: Boolean = True);
//begin
//  CriaIcons(TabelaAtualizar, FieldTab, FieldChave, FieldData, IndexImg, ALll);
//end;

procedure TF_BaseAnCad.SetFieldChave(const Value: string);
begin
  FFieldChave := Value;
end;

procedure TF_BaseAnCad.SetFieldData(const Value: string);
begin
  FFieldData := Value;
end;

procedure TF_BaseAnCad.SetIndexImg(const Value: Integer);
begin
  FIndexImg := Value;
end;

procedure TF_BaseAnCad.SetInformacoes(ATabelaAtualizar: TClientDataSet;
  AFieldTab, AFieldChave, AFieldData: string; const AIndexImg:Integer = -1);
begin
  FTabelaDataSource:= TDataSource.Create(Self);
  TabelaAtualizar:= ATabelaAtualizar;
  cds_dados.Data:= ATabelaAtualizar.Data;
  FieldTab:=        AFieldTab;
  FieldChave:=      AFieldChave;
  FieldData:=       AFieldData;
  //IndexImg:=        AIndexImg;
end;

procedure TF_BaseAnCad.SetTabelaAtualizar(const Value: TClientDataSet);
begin
  FTabelaAtualizar := Value;
end;

procedure TF_BaseAnCad.SetTabelaDataSource(const Value: TDataSource);
begin
  FTabelaDataSource := Value;
end;

procedure TF_BaseAnCad.SetValor(const Value: string);
begin
  FFieldTab := Value;
end;

procedure TF_BaseAnCad.vwl_baseCellClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsInteger, []);
end;

procedure TF_BaseAnCad.vwl_baseCellDblClick(Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
begin
  DblClica(self);
end;

end.
