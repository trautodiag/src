inherited F_CadAgendaCompromisso: TF_CadAgendaCompromisso
  Caption = 'Cadastro de compromissos'
  ClientHeight = 488
  ClientWidth = 465
  OnShow = FormShow
  ExplicitWidth = 471
  ExplicitHeight = 516
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 465
    Height = 488
    ExplicitWidth = 465
    ExplicitHeight = 240
    ClientRectBottom = 487
    ClientRectRight = 464
    inherited ts_base: TcxTabSheet
      ExplicitWidth = 463
      ExplicitHeight = 238
      object lbl_cod: TLabel [0]
        Left = 8
        Top = 7
        Width = 33
        Height = 13
        Caption = 'Codigo'
      end
      object lbl_Descricao: TLabel [1]
        Left = 111
        Top = 7
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object lbl_vencimento: TLabel [2]
        Left = 8
        Top = 52
        Width = 23
        Height = 13
        Caption = 'Data'
        FocusControl = cbb_AGC_Data
      end
      object lbl_numero: TLabel [3]
        Left = 119
        Top = 51
        Width = 23
        Height = 13
        Caption = 'Hora'
      end
      object lbl_Minuto: TLabel [4]
        Left = 172
        Top = 51
        Width = 32
        Height = 13
        Caption = 'Minuto'
      end
      object lbl_Obs: TLabel [5]
        Left = 8
        Top = 95
        Width = 58
        Height = 13
        Caption = 'Observa'#231#227'o'
      end
      inherited pnl_Base: TPanel
        Top = 453
        Width = 463
        TabOrder = 7
        ExplicitTop = 205
        ExplicitWidth = 463
        inherited btn_Salvar: TcxButton
          Left = 271
          ExplicitLeft = 271
        end
        inherited btn_Cancelar: TcxButton
          Left = 368
          ExplicitLeft = 368
        end
        object btn_VincularArq: TcxButton
          Left = 8
          Top = 5
          Width = 161
          Height = 25
          Action = act_abriVinculo
          Anchors = [akTop, akRight]
          TabOrder = 2
        end
      end
      object dbedt_AGC_Cod: TDBEdit
        Left = 8
        Top = 24
        Width = 97
        Height = 21
        DataField = 'AGC_Cod'
        DataSource = DM.ds_AgendaCompromisso
        Enabled = False
        ReadOnly = True
        TabOrder = 0
      end
      object dbedt_AGC_Descricao: TDBEdit
        Left = 111
        Top = 24
        Width = 346
        Height = 21
        CharCase = ecUpperCase
        DataField = 'AGC_Descricao'
        DataSource = DM.ds_AgendaCompromisso
        TabOrder = 1
      end
      object cxDBCheckBox1: TcxDBCheckBox
        Left = 228
        Top = 68
        Caption = 'Resolvido'
        DataBinding.DataField = 'AGC_Status'
        DataBinding.DataSource = DM.ds_AgendaCompromisso
        TabOrder = 5
        Transparent = True
        Width = 69
      end
      object cbb_AGC_Data: TcxDBDateEdit
        Left = 8
        Top = 68
        DataBinding.DataField = 'AGC_Data'
        DataBinding.DataSource = DM.ds_AgendaCompromisso
        Style.BorderStyle = ebsUltraFlat
        TabOrder = 2
        Width = 107
      end
      object dbspndt_AGC_Hora: TcxDBSpinEdit
        Left = 119
        Top = 68
        DataBinding.DataField = 'AGC_Hora'
        DataBinding.DataSource = DM.ds_AgendaCompromisso
        Properties.AssignedValues.MinValue = True
        Properties.MaxValue = 23.000000000000000000
        TabOrder = 3
        Width = 50
      end
      object dbspndt_AGC_Minuto: TcxDBSpinEdit
        Left = 172
        Top = 68
        DataBinding.DataField = 'AGC_Minuto'
        DataBinding.DataSource = DM.ds_AgendaCompromisso
        Properties.AssignedValues.MinValue = True
        Properties.MaxValue = 59.000000000000000000
        TabOrder = 4
        Width = 50
      end
      object dbm_AGC_Observacao: TcxDBMemo
        Left = 8
        Top = 114
        DataBinding.DataField = 'AGC_Observacao'
        DataBinding.DataSource = DM.ds_AgendaCompromisso
        Properties.CharCase = ecUpperCase
        TabOrder = 6
        Height = 89
        Width = 449
      end
      object pnl_ArquivosVinculados: TPanel
        Left = 0
        Top = 209
        Width = 463
        Height = 244
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 8
        Visible = False
        object pnl_inserir: TPanel
          Left = 0
          Top = 0
          Width = 463
          Height = 35
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          DesignSize = (
            463
            35)
          object btn_novovinculo: TcxButton
            Left = 8
            Top = 5
            Width = 149
            Height = 25
            Action = act_VincularArq
            Anchors = [akTop, akRight]
            TabOrder = 0
          end
          object btn_ExcluirArqAcao: TcxButton
            Left = 162
            Top = 5
            Width = 127
            Height = 25
            Action = act_ExcluirArquivo
            Anchors = [akTop, akRight]
            TabOrder = 1
          end
        end
        object grid_base: TcxGrid
          Left = 0
          Top = 35
          Width = 463
          Height = 209
          Align = alClient
          TabOrder = 1
          LookAndFeel.SkinName = 'Office2010Blue'
          ExplicitTop = 0
          ExplicitWidth = 778
          ExplicitHeight = 399
          object vwl_base: TcxGridDBTableView
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
            DataController.DataSource = ds_ArqAcao
            DataController.Summary.DefaultGroupSummaryItems = <>
            DataController.Summary.FooterSummaryItems = <>
            DataController.Summary.SummaryGroups = <>
            FilterRow.InfoText = 'Click para definir o filtro'
            OptionsBehavior.CellHints = True
            OptionsData.CancelOnExit = False
            OptionsData.Deleting = False
            OptionsData.DeletingConfirmation = False
            OptionsData.Editing = False
            OptionsData.Inserting = False
            OptionsView.NoDataToDisplayInfoText = 'N'#227'o h'#225' registros'
            OptionsView.ColumnAutoWidth = True
            OptionsView.GroupByBox = False
            object vwl_baseColumn1: TcxGridDBColumn
              Caption = 'Arquivo/A'#231#227'o'
              DataBinding.FieldName = 'AAC_ARQ_Cod'
              OnGetDisplayText = vwl_baseColumn1GetDisplayText
            end
          end
          object tbl_base: TcxGridLevel
            GridView = vwl_base
          end
        end
      end
    end
  end
  inherited act_cadastros: TActionList
    Left = 72
    Top = 152
    object act_VincularArq: TAction
      Caption = 'Novo arquivo e/ou a'#231#245'es...'
      Enabled = False
      OnExecute = act_VincularArqExecute
    end
    object act_ExcluirArquivo: TAction
      Caption = 'Excluir a'#231#227'o/arquivo'
      Enabled = False
      OnExecute = act_ExcluirArquivoExecute
    end
    object act_abriVinculo: TAction
      AutoCheck = True
      Caption = 'Vincular arquivo/a'#231#227'o'
      OnExecute = act_abriVinculoExecute
    end
  end
  object cds_ArqAcao: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 120
    Top = 312
  end
  object ds_ArqAcao: TDataSource
    DataSet = cds_ArqAcao
    Left = 192
    Top = 312
  end
  object ds_Arquivo: TDataSource
    DataSet = cds_Arquivo
    Left = 312
    Top = 272
  end
  object cds_Arquivo: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 256
    Top = 272
  end
end
