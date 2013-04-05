object F_VisualizadorProcessos: TF_VisualizadorProcessos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Visualizador de processos'
  ClientHeight = 593
  ClientWidth = 912
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  PixelsPerInch = 96
  TextHeight = 13
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 912
    Height = 593
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tab_processos
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ExplicitLeft = 184
    ExplicitTop = 112
    ExplicitWidth = 289
    ExplicitHeight = 193
    ClientRectBottom = 592
    ClientRectLeft = 1
    ClientRectRight = 911
    ClientRectTop = 1
    object tab_processos: TcxTabSheet
      Caption = 'tab_processos'
      ImageIndex = 0
      ExplicitWidth = 287
      ExplicitHeight = 191
      object cxGrid1: TcxGrid
        Left = 0
        Top = 0
        Width = 910
        Height = 591
        Align = alClient
        TabOrder = 0
        LookAndFeel.SkinName = 'Office2007Blue'
        ExplicitWidth = 778
        ExplicitHeight = 399
        object cxGridDBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          Navigator.Buttons.First.Visible = False
          Navigator.Buttons.PriorPage.Visible = False
          Navigator.Buttons.Prior.Visible = False
          Navigator.Buttons.Next.Visible = False
          Navigator.Buttons.NextPage.Visible = False
          Navigator.Buttons.Last.Visible = False
          Navigator.Buttons.Insert.Visible = False
          Navigator.Buttons.Append.Enabled = False
          Navigator.Buttons.Append.Visible = True
          Navigator.Buttons.Delete.Visible = False
          Navigator.Buttons.Edit.Visible = False
          Navigator.Buttons.Post.Visible = False
          Navigator.Buttons.Cancel.Visible = False
          Navigator.Buttons.Refresh.Visible = False
          Navigator.Buttons.SaveBookmark.Visible = False
          Navigator.Buttons.GotoBookmark.Visible = False
          Navigator.Buttons.Filter.Visible = False
          Navigator.InfoPanel.DisplayMask = '[RecordIndex] de [RecordCount]'
          Navigator.Visible = True
          DataController.DataSource = ds_processosUni
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <
            item
              Links = <>
              SummaryItems = <>
            end>
          FilterRow.InfoText = 'Click para definir o filtro'
          OptionsBehavior.CellHints = True
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Editing = False
          OptionsData.Inserting = False
          OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' registros'
          OptionsView.ColumnAutoWidth = True
          object cxGridDBTableView1Column2: TcxGridDBColumn
            DataBinding.FieldName = 'Data'
            Visible = False
            GroupIndex = 0
            Options.Editing = False
            Options.Focusing = False
            Width = 107
          end
          object cxGridDBColumn1: TcxGridDBColumn
            DataBinding.FieldName = 'Nome'
            Options.Editing = False
            Options.Focusing = False
            Width = 139
          end
          object cxGridDBColumn2: TcxGridDBColumn
            DataBinding.FieldName = 'Path'
            Options.Editing = False
            Options.Focusing = False
            Width = 317
          end
          object cxGridDBColumn3: TcxGridDBColumn
            DataBinding.FieldName = 'Dominio'
            Options.Editing = False
            Options.Focusing = False
            Width = 193
          end
          object cxGridDBTableView1Column1: TcxGridDBColumn
            DataBinding.FieldName = 'Usuario'
            Options.Editing = False
            Options.Focusing = False
            Width = 152
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
        end
      end
    end
  end
  object cds_processosUni: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 480
    Top = 176
  end
  object ds_processosUni: TDataSource
    DataSet = cds_processosUni
    Left = 416
    Top = 184
  end
end
