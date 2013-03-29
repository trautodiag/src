unit Unt_CadAnClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Unt_BaseAnCad, dxSkinsCore, dxSkinOffice2010Blue, dxSkinscxPCPainter,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, Menus,
  cxContainer, cxEdit, ImgList, ActnList, cxScrollBox, StdCtrls, cxTextEdit,
  cxGroupBox, cxRadioGroup, cxButtons, ExtCtrls, cxPC, Unt_CadClientes, Unt_ImagePanel,
  Unt_Util, Unit_DM, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  DB, cxDBData, cxLocalization, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, DBClient;

type
  TF_CadAnClientes = class(TF_BaseAnCad)
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
  F_CadAnClientes: TF_CadAnClientes;

implementation

{$R *.dfm}

procedure TF_CadAnClientes.act_EditarExecute(Sender: TObject);
begin
//  if TabelaAtualizar.Locate(FieldChave, RegistroSelecionado, []) then
//    begin
      inherited;
      TF_CadClientes.Inicia(Self.Handle);
//    end;
end;

procedure TF_CadAnClientes.act_ExcluirExecute(Sender: TObject);
begin
  if TabelaAtualizar.Locate(FieldChave, cds_dados.FieldByName(FieldChave).AsString, []) then
    if MessageDlg('Deseja excluir o registro ['+TabelaAtualizar.FieldByName(FieldChave).AsString+'] ?', mtWarning, mbYesNo, 0) = mrYes then
      begin
        TabelaAtualizar.Delete;
        inherited;
        //RecriaIcons;
      end;
end;

procedure TF_CadAnClientes.act_NovoExecute(Sender: TObject);
begin
  inherited;
  TF_CadClientes.Inicia(Self.Handle);
end;

procedure TF_CadAnClientes.DblClica(Sender: TObject);
begin
 inherited;
 TF_CadClientes.Inicia(Self.Handle, False);
end;

procedure TF_CadAnClientes.FormCreate(Sender: TObject);
begin
  SetInformacoes(DM.cds_clientes, 'CLI_Nome', 'CLI_Cod', 'Data', cs_Cliente);
  //RecriaIcons;
  inherited;
end;

end.
