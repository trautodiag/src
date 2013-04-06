unit Unt_VisualizadorProcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2007Blue, dxSkinscxPCPainter, cxPC, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient, Grids,
  Unt_Util, DBGrids, StdCtrls, ExtCtrls;

type
  TF_VisualizadorProcessos = class(TForm)
    cxPageControl1: TcxPageControl;
    tab_processos: TcxTabSheet;
    cxGrid1: TcxGrid;
    cxGridDBTableView1: TcxGridDBTableView;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    cxGridDBTableView1Column1: TcxGridDBColumn;
    cds_processosUni: TClientDataSet;
    ds_processosUni: TDataSource;
    cxGridDBTableView1Column2: TcxGridDBColumn;
    cds_modulos: TClientDataSet;
    ds_modulos: TDataSource;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1DBTableView1Column1: TcxGridDBColumn;
    cxGrid1DBTableView1Column2: TcxGridDBColumn;
    pnl_base: TPanel;
    chk_MostrarModulos: TCheckBox;
    procedure chk_MostrarModulosClick(Sender: TObject);
  private
    { Private declarations }
    ADadosGrid: OleVariant;
    procedure CarregaGrid(ACarregaModulos: Boolean);
  public
    { Public declarations }
    class procedure Inicia(ADados: OleVariant; const ACarregaModulos: Boolean = false);
  end;

var
  F_VisualizadorProcessos: TF_VisualizadorProcessos;

implementation

{$R *.dfm}

{ TF_VisualizadorProcessos }

procedure TF_VisualizadorProcessos.CarregaGrid(ACarregaModulos: Boolean);
begin
  if cds_processosUni.Active then
    cds_processosUni.EmptyDataSet;
  //cds_processosUni.Close;
  if cds_modulos.Active then
    cds_modulos.EmptyDataSet;
  //cds_modulos.Close;

  cds_processosUni.DisableControls;
  cds_modulos.DisableControls;

  cds_processosUni.Data:= ADadosGrid;
  if not cds_modulos.Active then
    CriaEstruturaModulos(cds_modulos);
  cds_processosUni.IndexFieldNames:= 'Codigo';
  cds_modulos.IndexFieldNames:= 'Servico_Codigo';
  //cds_modulos.DataSetField:= TDataSetField(cds_processosUni.FieldByName('Modulos'));
  cds_processosUni.First;
  if ACarregaModulos then
    begin
      while not cds_processosUni.Eof do
        begin
          with TClientDataSet.Create(Application) do
            begin
              try
                DataSetField:= TDataSetField(cds_processosUni.FieldByName('Modulos'));
                First;
                Next;
                while not eof do
                  begin
                    cds_modulos.AppendRecord([Integer(DataSetField.FieldValues[0]),
                                             string(DataSetField.FieldValues[1]),
                                             string(DataSetField.FieldValues[2])]);
                    Next;
                  end;
              finally
                Free;
              end;
            end;
          cds_processosUni.Next;
        end;
    end;
  cds_modulos.IndexFieldNames:= 'Servico_Codigo';
  cds_processosUni.First;
  cds_processosUni.EnableControls;
  cds_modulos.EnableControls;
end;

procedure TF_VisualizadorProcessos.chk_MostrarModulosClick(Sender: TObject);
begin
  CarregaGrid(chk_MostrarModulos.Checked);
end;

class procedure TF_VisualizadorProcessos.Inicia(ADados: OleVariant; const ACarregaModulos: Boolean = false);
var
  ADataSet, ADataSetProcess: TClientDataSet;
begin
  with Self.Create(Application) do
    begin
      try
        ADadosGrid:= ADados;
        CarregaGrid(ACarregaModulos);
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
