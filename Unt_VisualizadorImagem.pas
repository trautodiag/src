unit Unt_VisualizadorImagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, jpeg, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, dxSkinscxPCPainter, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, DB, cxDBData, ExtCtrls,
  DBClient, cxGridCustomTableView, cxGridCardView, cxGridDBCardView,
  cxGridCustomView, cxGridCustomLayoutView, cxClasses, cxGridLevel, cxGrid, cxPC,
  cxImage, cxSplitter, cxScrollBox;

type
  TCanSize = (csLeft, csUp, csRight, csDown);
  TCanSizes = set of TCanSize;

  TF_VisualizadorImagem = class(TForm)
    cds_Imagens: TClientDataSet;
    ds_imagens: TDataSource;
    cxGrid1: TcxGrid;
    cxGrid1DBCardView1: TcxGridDBCardView;
    cxGrid1DBCardView1Row1: TcxGridDBCardViewRow;
    cxGrid1Level1: TcxGridLevel;
    cxSplitter1: TcxSplitter;
    cxscrlbx_base: TcxScrollBox;
    img_Base: TImage;
    procedure FormShow(Sender: TObject);
    procedure img_BaseMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure img_BaseMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img_BaseMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxGrid1DBCardView1CellClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
    procedure cds_ImagensAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    FCanSizes : TCanSizes; //Declaração de variável importante
    procedure SetImagem(AStream: TMemoryStream);
    procedure SetPosicaoImagem;
  public
    { Public declarations }
    class procedure Inicia(ADados: OleVariant);
  end;

var
  F_VisualizadorImagem: TF_VisualizadorImagem;
  mouse_x : integer;     //Distância do Cursor do Mouse até o início do TImage em X
  mouse_y : integer;     //Distância do Cursor do Mouse até o início do TImage em Y
  IS_DRAG : boolean;     //Verificar se o usuário está "desenhando"
  CURSOR_ATUAL: integer; //Tipo de Cursor: crSizeNWSE, crSizeNS, etc...

const
  sc_WIN_TITLE_BAR = 25; //Constante da altura da Barra de título do Windows

implementation

{$R *.dfm}

procedure TF_VisualizadorImagem.cds_ImagensAfterScroll(DataSet: TDataSet);
var
  stream: TMemoryStream;
begin
  stream:= TMemoryStream.Create;
  try
    SetImagem(stream);
  finally
    stream.Free
  end; 
end;

procedure TF_VisualizadorImagem.cxGrid1DBCardView1CellClick(
  Sender: TcxCustomGridTableView; ACellViewInfo: TcxGridTableDataCellViewInfo;
  AButton: TMouseButton; AShift: TShiftState; var AHandled: Boolean);
var
  stream: TMemoryStream;
  btn: TBitmap;
begin
  stream:= TMemoryStream.Create;
  try
    if ACellViewInfo.GridRecord.Values[cxGrid1DBCardView1Row1.Index] <> null then
      begin
        SetImagem(stream);
      end;
  finally
    stream.Free
  end;
end;

procedure TF_VisualizadorImagem.FormShow(Sender: TObject);
begin
   IS_DRAG := false;     //Ao iniciar o programa o usuário não está desenhando.
   DoubleBuffered:=True; //Para mover e redimensionar um TImage sem que ele "pisque"
                         //Obrigado Dapper Rodrigo pela dica.
end;

procedure TF_VisualizadorImagem.img_BaseMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   //Distância do Cursor do Mouse até o início do TImage - em X
   mouse_x := Mouse.CursorPos.X - img_Base.Left - Self.Left;

   //Distância do Cursor do Mouse até o início do TImage - em Y
   mouse_y := Mouse.CursorPos.Y - img_Base.Top - Self.Top;

   //O usuário está desenhando
   IS_DRAG := true;
end;

procedure TF_VisualizadorImagem.img_BaseMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  Rects : array[0..7]of TRect;
  delta : integer;
  old_imagex : integer; //variável auxiliar: antiga posição x do TImage
  old_imagey : integer; //variável auxiliar: antiga posição y do TImage
  pt : TPoint;
begin
    if IS_DRAG = false then
    //Se não estiver desenhando, o programa somente alterará o
    //cursor do mouse dependendo da região do TImage
    begin
      if Shift = [] then begin
          with Sender as TImage do begin

            delta := 6;
            pt := Point(X,Y);

            Rects[0] := Rect(0, 0, delta, delta);
            Rects[1] := Rect(delta, 0, Width -delta, delta);
            Rects[2] := Rect(Width -delta, 0, Width, delta);

            Rects[3] := Rect(0, delta, delta, Height -delta);
            Rects[4] := Rect(Width -delta, delta, Width, Height -delta);

            Rects[5] := Rect(0, Height -delta, delta, Height);
            Rects[6] := Rect(delta, Height -delta, Width -delta, Height);
            Rects[7] := Rect(Width -delta, Height -delta, Width, Height);

            //Definindo o cursor do mouse para cada "canto" do TImage
            if PtInRect(Rects[0], pt) then begin Cursor := crSizeNWSE;
            FCanSizes := [csLeft, csUp]; CURSOR_ATUAL := 0 end
            else
            if PtInRect(Rects[1], pt) then begin Cursor := crSizeNS  ;
            FCanSizes := [csUp]; CURSOR_ATUAL := 1 end
            else
            if PtInRect(Rects[2], pt) then begin Cursor := crSizeNESW;
            FCanSizes := [csRight, csUp]; CURSOR_ATUAL := 2 end
            else
            if PtInRect(Rects[3], pt) then begin Cursor := crSizeWE  ;
            FCanSizes := [csLeft];  CURSOR_ATUAL := 3 end
            else
            if PtInRect(Rects[4], pt) then begin Cursor := crSizeWE  ;
            FCanSizes := [csRight]; CURSOR_ATUAL := 4 end
            else
            if PtInRect(Rects[5], pt) then begin Cursor := crSizeNESW;
            FCanSizes := [csLeft, csDown]; CURSOR_ATUAL := 5 end
            else
            if PtInRect(Rects[6], pt) then begin Cursor := crSizeNS  ;
            FCanSizes := [csDown]; CURSOR_ATUAL := 6 end
            else
            if PtInRect(Rects[7], pt) then begin Cursor := crSizeNWSE;
            FCanSizes := [csRight, csDown]; CURSOR_ATUAL := 7 end
            else
              begin Cursor := crDefault; img_Base.cursor := crDefault; CURSOR_ATUAL := 8; end;
          end;
      end;
    end
    else
    //Caso contrário (usuário está desenhando) o programa irá redimensionar ou
    //mover o TImage
    begin
        case CURSOR_ATUAL of
            0: //Redimensionamento para cima e à esquerda
               begin
                   old_imagex := img_Base.Left;
                   img_Base.left := Mouse.CursorPos.X - mouse_x - Self.Left;
                   img_Base.Width := img_Base.Width + (old_imagex - img_Base.Left);

                   old_imagey := img_Base.top;
                   img_Base.Top := Mouse.CursorPos.Y - mouse_y - Self.Top;
                   img_Base.Height := img_Base.Height + (old_imagey - img_Base.top);
               end;

            1: //Redimensionamento para cima
               begin
                   old_imagey := img_Base.top;
                   img_Base.Top := Mouse.CursorPos.Y - mouse_y - Self.Top;
                   img_Base.Height := img_Base.Height + (old_imagey - img_Base.top);
               end;

            2: //Redimensionamento para cima e à direita
               begin
                   img_Base.Width := Mouse.CursorPos.X - Self.Left - img_Base.Left;

                   old_imagey := img_Base.top;
                   img_Base.Top := Mouse.CursorPos.Y - mouse_y - Self.Top;
                   img_Base.Height := img_Base.Height + (old_imagey - img_Base.top);
               end;

            3: //Redimensionamento para a esquerda
               begin
                   old_imagex := img_Base.Left;
                   img_Base.left := Mouse.CursorPos.X - mouse_x - Self.Left;
                   img_Base.Width := img_Base.Width + (old_imagex - img_Base.Left);
               end;

            4: //Redimensionamento para a direita
               begin
                   img_Base.Width := Mouse.CursorPos.X - Self.Left - img_Base.Left;
               end;

            5: //Redimensionamento para baixo e à esquerda
               begin
                   old_imagex := img_Base.Left;
                   img_Base.left := Mouse.CursorPos.X - mouse_x - Self.Left;
                   img_Base.Width := img_Base.Width + (old_imagex - img_Base.Left);

                   img_Base.Height := Mouse.CursorPos.Y - Self.Top - img_Base.top - sc_WIN_TITLE_BAR;
               end;

            6: //Redimensionamento para baixo
               begin
                   img_Base.Height := Mouse.CursorPos.Y - Self.Top - img_Base.top - sc_WIN_TITLE_BAR;
               end;

            7: //Redimensionamento para baixo e à direita
               begin
                   img_Base.Width := Mouse.CursorPos.X - Self.Left - img_Base.Left;
                   img_Base.Height := Mouse.CursorPos.Y - Self.Top - img_Base.top - sc_WIN_TITLE_BAR;
               end;

            8: //Mover TImage
               begin
                   img_Base.left := Mouse.CursorPos.X - mouse_x - Self.Left;
                   img_Base.Top := Mouse.CursorPos.Y - mouse_y - Self.Top;
               end;
          end;
    end;

end;

procedure TF_VisualizadorImagem.img_BaseMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
   //O usuário não está desenhando mais...
   IS_DRAG := false;
end;

class procedure TF_VisualizadorImagem.Inicia(ADados: OleVariant);
begin
  with Self.Create(Application) do
    begin
      try
        cds_Imagens.Data:= ADados;
        cds_Imagens.First;
        ShowModal;
      finally
        Free;
      end;
    end;
end;

procedure TF_VisualizadorImagem.SetImagem(AStream: TMemoryStream);
var
  btn: TBitmap;
begin
  TGraphicField(cds_Imagens.FieldByName('Imagem')).SaveToStream(AStream);
  AStream.Position:= 0;
  btn:= TBitmap.Create;
  with btn do
    begin
      try
        LoadFromStream(AStream);
        img_Base.Width:= btn.Width;
        img_Base.Height:= btn.Height;
      finally
        btn.Free;
      end;
    end;
  AStream.Position:= 0;
  img_Base.Picture.Bitmap.LoadFromStream(AStream);
  SetPosicaoImagem;
end;

procedure TF_VisualizadorImagem.SetPosicaoImagem;
begin
  img_Base.Top:= 0;
  img_Base.Left:= 0;
end;

end.
