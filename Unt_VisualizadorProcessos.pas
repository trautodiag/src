unit Unt_VisualizadorProcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2007Blue, dxSkinscxPCPainter, cxPC, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient, Grids,
  Unt_Util;

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
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure Inicia(ADados: OleVariant);
  end;

var
  F_VisualizadorProcessos: TF_VisualizadorProcessos;

implementation

{$R *.dfm}

{ TF_VisualizadorProcessos }

class procedure TF_VisualizadorProcessos.Inicia(ADados: OleVariant);
var
  ADataSet: TClientDataSet;
begin
  with Self.Create(Application) do
    begin
      try
        cds_processosUni.Data:= ADados;
        CriaEstruturaModulos(cds_modulos);
        ADataSet:= TClientDataSet.Create(Application);
        ADataSet.DataSetField:= TDataSetField(cds_processosUni.FieldByName('Modulos'));
        cds_modulos.Data:= ADataSet.Data;
        cds_modulos.DataSetField:= nil;
        ADataSet.Free;
        //ShowMessage(IntToStr( TDataSetField(cds_processosUni.FieldByName('Modulos')).FieldCount));
//        ShowMessage(TDataSetField(cds_processosUni.FieldByName('Modulos')).Fields.Fields[1].AsString);
//        with ADataSet do
//          begin
//            First;
//            while not Eof do
//              begin
//                cds_modulos.AppendRecord([ADataSet.FieldByName('Servico_Codigo').AsInteger,
//                                         ADataSet.FieldByName('Nome').AsString,
//                                         ADataSet.FieldByName('Path').AsString]);
//                Next;
//              end;
//          end;
        cds_processosUni.First;
        //cds_modulos.DataSetField:= TDataSetField(cds_processosUni.FieldByName('Modulos'));
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
