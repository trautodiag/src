object F_VisualizadorImagem: TF_VisualizadorImagem
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Visualizador de imagems'
  ClientHeight = 574
  ClientWidth = 885
  Color = clBtnFace
  Constraints.MinHeight = 600
  Constraints.MinWidth = 900
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 885
    Height = 574
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tab_visualizador
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ExplicitLeft = 280
    ExplicitTop = 104
    ExplicitWidth = 289
    ExplicitHeight = 193
    ClientRectBottom = 573
    ClientRectLeft = 1
    ClientRectRight = 884
    ClientRectTop = 1
    object tab_visualizador: TcxTabSheet
      Caption = 'tab_visualizador'
      ImageIndex = 0
      object img_Base: TImage
        Left = 0
        Top = 0
        Width = 209
        Height = 161
        Center = True
        Stretch = True
        OnMouseDown = img_BaseMouseDown
        OnMouseMove = img_BaseMouseMove
        OnMouseUp = img_BaseMouseUp
      end
      object pnl_imagens: TPanel
        Left = 711
        Top = 0
        Width = 172
        Height = 572
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object cxGrid1: TcxGrid
          Left = 0
          Top = 0
          Width = 172
          Height = 572
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 64
          ExplicitTop = 224
          ExplicitWidth = 250
          ExplicitHeight = 200
          object cxGrid1DBCardView1: TcxGridDBCardView
            Navigator.Buttons.CustomButtons = <>
            OnCellClick = cxGrid1DBCardView1CellClick
            DataController.DataSource = ds_imagens
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            OptionsView.CardIndent = 7
            object cxGrid1DBCardView1Row1: TcxGridDBCardViewRow
              DataBinding.FieldName = 'Imagem'
              PropertiesClassName = 'TcxImageProperties'
              Properties.PopupMenuLayout.MenuItems = [pmiCustom]
              Options.Editing = False
              Options.Filtering = False
              Options.FilteringFilteredItemsList = False
              Options.FilteringMRUItemsList = False
              Options.FilteringPopup = False
              Options.FilteringPopupMultiSelect = False
              Options.Focusing = False
              Options.IncSearch = False
              Options.ShowCaption = False
              Position.BeginsLayer = True
              Position.LineCount = 6
              IsCaptionAssigned = True
            end
          end
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBCardView1
          end
        end
      end
    end
  end
  object cds_Imagens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 184
  end
  object ds_imagens: TDataSource
    DataSet = cds_Imagens
    Left = 480
    Top = 184
  end
end
