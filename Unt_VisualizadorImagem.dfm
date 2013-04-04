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
  object cxGrid1: TcxGrid
    Left = 672
    Top = 0
    Width = 213
    Height = 574
    Align = alRight
    Constraints.MaxWidth = 213
    TabOrder = 0
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
  object cxSplitter1: TcxSplitter
    Left = 664
    Top = 0
    Width = 8
    Height = 574
    AlignSplitter = salRight
    Control = cxGrid1
    ExplicitLeft = 730
  end
  object cxscrlbx_base: TcxScrollBox
    Left = 0
    Top = 0
    Width = 664
    Height = 574
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 128
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 41
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
  end
  object cds_Imagens: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterScroll = cds_ImagensAfterScroll
    Left = 280
    Top = 184
  end
  object ds_imagens: TDataSource
    DataSet = cds_Imagens
    Left = 480
    Top = 184
  end
end
