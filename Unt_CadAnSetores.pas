unit Unt_CadAnSetores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxContainer, cxEdit, ImgList, ActnList, cxScrollBox, StdCtrls, cxTextEdit,
  cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls, cxPC, Unt_CadSetores, Unit_DM, Unt_Util,
  Unt_ImagePanel, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, DB,
  cxDBData, cxLocalization, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient;

type
  TF_CadAnSetores = class(TF_BaseAnCad)
    vwl_baseColumn1: TcxGridDBColumn;
    vwl_baseColumn2: TcxGridDBColumn;
    vwl_baseColumn3: TcxGridDBColumn;
    procedure act_NovoExecute(Sender: TObject);
    procedure act_EditarExecute(Sender: TObject);
    procedure act_ExcluirExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure DblClica(Sender: TObject); override;
  end;

var
  F_CadAnSetores: TF_CadAnSetores;

implementation

{$R *.dfm}

procedure TF_CadAnSetores.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadSetores.Inicia(Self.Handle);
//    end;
end;

procedure TF_CadAnSetores.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
//        RecriaIcons;
      end;
end;

procedure TF_CadAnSetores.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadSetores.Inicia(Self.Handle);
end;

procedure TF_CadAnSetores.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadSetores.Inicia(Self.Handle, False);
end;

procedure TF_CadAnSetores.FormCreate(Sender: TObject);
begin
  SetInformacoes(DM.cds_setor, 'SET_Nome', 'SET_Cod', 'Data', cs_Setor);
//  RecriaIcons;
  inherited;
end;

end.
