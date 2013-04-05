unit Unt_VisualizadorProcessos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinOffice2007Blue, dxSkinscxPCPainter, cxPC, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData,
  cxSplitter, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, DBClient;

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
begin
  with Self.Create(Application) do
    begin
      try
        cds_processosUni.Data:= ADados;
        cds_processosUni.First;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

end.
