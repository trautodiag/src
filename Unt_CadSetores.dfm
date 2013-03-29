inherited F_CadSetores: TF_CadSetores
  Caption = 'Cadastro de setores'
  ClientHeight = 85
  ClientWidth = 464
  OnShow = FormShow
  ExplicitWidth = 470
  ExplicitHeight = 117
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 464
    Height = 85
    ClientRectBottom = 84
    ClientRectRight = 463
    inherited ts_base: TcxTabSheet
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
        Width = 26
        Height = 13
        Caption = 'Setor'
      end
      inherited pnl_Base: TPanel
        Top = 50
        Width = 462
        inherited btn_Salvar: TcxButton
          Left = 270
        end
        inherited btn_Cancelar: TcxButton
          Left = 367
        end
      end
      object dbedt_SET_Cod: TDBEdit
        Left = 8
        Top = 24
        Width = 97
        Height = 21
        DataField = 'SET_Cod'
        DataSource = DM.ds_setor
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object dbedt_SET_Nome: TDBEdit
        Left = 111
        Top = 24
        Width = 345
        Height = 21
        CharCase = ecUpperCase
        DataField = 'SET_Nome'
        DataSource = DM.ds_setor
        TabOrder = 2
      end
    end
  end
  inherited act_cadastros: TActionList
    Left = 72
    Top = 8
  end
end
