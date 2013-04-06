unit Unt_VisualizadorProcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2007Blue, dxSkinscxPCPainter, cxPC, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient, Grids,
  Unt_Util, DBGrids;

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
  ADataSet, ADataSetProcess: TClientDataSet;
begin
  with Self.Create(Application) do
    begin
      try
        with cds_processosUni do
          begin
            with FieldDefs do
              begin
                Add('Codigo', ftInteger);
                Add('Nome', ftString, 50);
                Add('Dominio', ftString, 80);
                Add('Usuario', ftString, 100);
                Add('Path', ftString, 200);
                Add('Data', ftDateTime);
              end;
            CreateDataSet;
          end;

        ADataSetProcess:= TClientDataSet.Create(Application);
        try
          ADataSetProcess.Data:= ADados;
          ADataSetProcess.First;
          while not ADataSetProcess.eof do
            begin
              cds_processosUni.AppendRecord([ADataSetProcess.FieldByName('Codigo').AsInteger,
                                             ADataSetProcess.FieldByName('Nome').AsString,
                                             ADataSetProcess.FieldByName('Dominio').AsString,
                                             ADataSetProcess.FieldByName('Usuario').AsString,
                                             ADataSetProcess.FieldByName('Path').AsString,
                                             ADataSetProcess.FieldByName('Data').AsDateTime]);
              ADataSetProcess.Next;
            end;
        finally
          ADataSetProcess.Free;
        end;

        //CriaEstruturaModulos(cds_modulos);
        //ADataSet:= TClientDataSet.Create(Application);
        //ADataSet.DataSetField:= TDataSetField(ADataSetProcess.FieldByName('Modulos'));
        //cds_modulos.Data:= ADataSet.Data;
        //cds_modulos.DataSetField:= nil;
        //ADataSet.Free;
        cds_processosUni.First;
        //cds_modulos.DataSetField:= TDataSetField(cds_processosUni.FieldByName('Modulos'));
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
