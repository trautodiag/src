unit Unt_CadAnDocumentos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, ActnList, ComCtrls, StdCtrls, Buttons, ExtCtrls, Unt_Util,
  Unit_DM, ImgList, Unt_ImagePanel, Unt_CadDocumentos, dxSkinsCore,
  dxSkinOffice2010Blue, dxSkinscxPCPainter, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, Menus, cxContainer, cxEdit, cxTextEdit,
  cxGroupBox, cxRadioGroup, cxButtons, cxPC, cxScrollBox, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, DB, cxDBData, cxLocalization,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, DBClient;

type
  TF_CadAnDocumentos = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    procedure FormCreate(Sender: TObject);
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
  private
    { Private declarations }
  public
    procedure DblClica(Sender: TObject); override;
    { Public declarations }
  end;

var
  F_CadAnDocumentos: TF_CadAnDocumentos;

implementation

{$R *.dfm}

{ TF_CadAnDocumentos }

procedure TF_CadAnDocumentos.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadDocumentos.Inicia(Self.Handle);
//    end;
end;

procedure TF_CadAnDocumentos.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
      end;
end;

procedure TF_CadAnDocumentos.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadDocumentos.Inicia(Self.Handle);
end;

procedure TF_CadAnDocumentos.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadDocumentos.Inicia(Self.Handle, False);
end;

procedure TF_CadAnDocumentos.FormCreate(Sender: TObject);
begin
  SetInformacoes(DM.cds_documentos, 'DOC_Nome', 'DOC_Cod', 'Data', cs_Documento);
  //RecriaIcons;
  inherited;
end;

end.
