unit Unt_CadAnEmpresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  Menus, cxContainer, cxEdit, ImgList, ActnList, cxScrollBox, StdCtrls,
  cxTextEdit, cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls, cxPC, Unt_ImagePanel,
  Unt_Util, Unit_DM, Unt_CadEmpresas, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, DB, cxDBData, cxLocalization, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, DBClient;

type
  TF_CadAnEmpresas = class(TF_BaseAnCad)
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
    { Public declarations }
    procedure DblClica(Sender: TObject); override;
  end;

var
  F_CadAnEmpresas: TF_CadAnEmpresas;

implementation

{$R *.dfm}

procedure TF_CadAnEmpresas.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadEmpresas.Inicia(Self.Handle);
//    end;
end;

procedure TF_CadAnEmpresas.act_ExcluirExecute(Sender: TObject);
begin
   if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
//        RecriaIcons;
      end; 
end;

procedure TF_CadAnEmpresas.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadEmpresas.Inicia(Self.Handle);
end;

procedure TF_CadAnEmpresas.DblClica(Sender: TObject);
begin
  inherited;
  TF_CadEmpresas.Inicia(Self.Handle, False);
end;

procedure TF_CadAnEmpresas.FormCreate(Sender: TObject);
begin
  SetInformacoes(DM.cds_empresa, 'EMP_Nome', 'EMP_Cod', 'Data', cs_Empresa);
//  RecriaIcons;
  inherited;
end;

end.
