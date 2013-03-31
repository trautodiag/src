inherited F_CadAgendaCompromisso: TF_CadAgendaCompromisso
  Caption = 'Cadastro de compromissos'
  ClientHeight = 240
  ClientWidth = 465
  OnShow = FormShow
  ExplicitWidth = 471
  ExplicitHeight = 268
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 465
    Height = 240
    ExplicitWidth = 465
    ExplicitHeight = 240
    ClientRectBottom = 239
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
        Top = 205
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
      object btn_VincularArq: TcxButton
        Left = 303
        Top = 66
        Width = 106
        Height = 25
        Action = act_VincularArq
        Anchors = [akTop, akRight]
        TabOrder = 8
      end
    end
  end
  inherited act_cadastros: TActionList
    Left = 72
    Top = 152
    object act_VincularArq: TAction
      Caption = 'Vincular arquivo...'
      Enabled = False
      OnExecute = act_VincularArqExecute
    end
  end
end
