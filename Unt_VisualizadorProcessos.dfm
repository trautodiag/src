object F_VisualizadorProcessos: TF_VisualizadorProcessos
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'Visualizador de processos'
  ClientHeight = 490
  ClientWidth = 912
  Color = clBtnFace
  Constraints.MinHeight = 528
  Constraints.MinWidth = 928
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
    Height = 490
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tab_processos
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ExplicitHeight = 593
    ClientRectBottom = 489
    ClientRectLeft = 1
    ClientRectRight = 911
    ClientRectTop = 1
    object tab_processos: TcxTabSheet
      Caption = 'tab_processos'
      ImageIndex = 0
      ExplicitLeft = 2
      ExplicitTop = 2
      object cxGrid1: TcxGrid
        Left = 0
        Top = 41
        Width = 910
        Height = 447
        Align = alClient
        TabOrder = 0
        LookAndFeel.SkinName = 'Office2007Blue'
        ExplicitTop = 0
        ExplicitHeight = 313
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
          DataController.KeyFieldNames = 'Codigo'
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
          OptionsView.ExpandButtonsForEmptyDetails = False
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
            Caption = 'Local'
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
        object cxGrid1DBTableView1: TcxGridDBTableView
          Navigator.Buttons.CustomButtons = <>
          DataController.DataSource = ds_modulos
          DataController.DetailKeyFieldNames = 'Servico_Codigo'
          DataController.MasterKeyFieldNames = 'Codigo'
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsView.GroupByBox = False
          object cxGrid1DBTableView1Column1: TcxGridDBColumn
            Caption = 'Nome do modulo'
            DataBinding.FieldName = 'MNome'
            Options.Editing = False
            Options.Focusing = False
          end
          object cxGrid1DBTableView1Column2: TcxGridDBColumn
            Caption = 'Local'
            DataBinding.FieldName = 'MPath'
            Options.Editing = False
            Options.Focusing = False
          end
        end
        object cxGridLevel1: TcxGridLevel
          GridView = cxGridDBTableView1
          object cxGrid1Level1: TcxGridLevel
            GridView = cxGrid1DBTableView1
          end
        end
      end
      object pnl_base: TPanel
        Left = 0
        Top = 0
        Width = 910
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object chk_MostrarModulos: TCheckBox
          Left = 16
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Mostrar modulos'
          TabOrder = 0
          OnClick = chk_MostrarModulosClick
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
  object cds_modulos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 512
    Top = 264
  end
  object ds_modulos: TDataSource
    DataSet = cds_modulos
    Left = 448
    Top = 264
  end
end
