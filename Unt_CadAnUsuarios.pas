unit Unt_CadAnUsuarios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxContainer, cxEdit, ImgList, ActnList, cxScrollBox, StdCtrls, cxTextEdit,
  cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls, cxPC, Unt_ImagePanel, Unit_DM,
  Unt_Util, Unt_CadUsuarios, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxLocalization, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBClient;

type
  TF_CadAnUsuarios = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    vwl_baseColumn4: TcxGridDBColumn;
    cds_setores: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure vwl_baseColumn3GetDisplayText(Sender: TcxCustomGridTableItem;
      ARecord: TcxCustomGridRecord; var AText: string);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DblClica(Sender: TObject); override;
  end;

var
  F_CadAnUsuarios: TF_CadAnUsuarios;

implementation

{$R *.dfm}

{ TF_CadAnUsuarios }

procedure TF_CadAnUsuarios.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadUsuarios.Inicia(Self.Handle);
//    end;
//  vwl_baseColumn3.OnGetDisplayText:= nil;
end;

procedure TF_CadAnUsuarios.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
//        RecriaIcons;
      end;
end;

procedure TF_CadAnUsuarios.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadUsuarios.Inicia(Self.Handle);
end;

procedure TF_CadAnUsuarios.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadUsuarios.Inicia(Self.Handle, False);
end;

procedure TF_CadAnUsuarios.FormCreate(Sender: TObject);
begin
  cds_setores.Data:= DM.cds_setor.Data;
  SetInformacoes(DM.cds_usuarios, 'USU_Nome', 'USU_Cod', 'Data', cs_Usuario);
//  RecriaIcons;
  inherited;
end;

procedure TF_CadAnUsuarios.vwl_baseColumn3GetDisplayText(
  Sender: TcxCustomGridTableItem; ARecord: TcxCustomGridRecord;
  var AText: string);
begin
  inherited;
  cds_setores.Filtered:= False;
  cds_setores.Filter:= 'SET_Cod =' +AText;
  cds_setores.Filtered:= True;
  if not cds_setores.IsEmpty then
    AText:= cds_setores.FieldByName('SET_Nome').AsString
  else
    AText:= 'Setor não identificado';
end;

end.
