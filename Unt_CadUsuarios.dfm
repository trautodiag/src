inherited F_CadUsuarios: TF_CadUsuarios
  Caption = 'Cadastro de usuarios'
  ClientHeight = 84
  ClientWidth = 593
  OnShow = FormShow
  ExplicitWidth = 599
  ExplicitHeight = 116
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 593
    Height = 84
    ExplicitWidth = 593
    ExplicitHeight = 84
    ClientRectBottom = 83
    ClientRectRight = 592
    inherited ts_base: TcxTabSheet
      ExplicitWidth = 591
      ExplicitHeight = 82
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
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object lbl_setor: TLabel [2]
        Left = 373
        Top = 7
        Width = 26
        Height = 13
        Caption = 'Setor'
      end
      inherited pnl_Base: TPanel
        Top = 49
        Width = 591
        ExplicitTop = 49
        ExplicitWidth = 591
        DesignSize = (
          591
          33)
        inherited btn_Salvar: TcxButton
          Left = 398
          Top = 4
          ExplicitLeft = 398
          ExplicitTop = 4
        end
        inherited btn_Cancelar: TcxButton
          Left = 495
          Top = 4
          ExplicitLeft = 495
          ExplicitTop = 4
        end
      end
      object dbedt_USU_Cod: TDBEdit
        Left = 8
        Top = 24
        Width = 97
        Height = 21
        DataField = 'USU_Cod'
        DataSource = DM.ds_usuarios
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object dbedt_USU_Nome: TDBEdit
        Left = 111
        Top = 24
        Width = 258
        Height = 21
        CharCase = ecUpperCase
        DataField = 'USU_Nome'
        DataSource = DM.ds_usuarios
        TabOrder = 2
      end
      object cbb_Setores: TcxDBLookupComboBox
        Left = 373
        Top = 24
        DataBinding.DataField = 'USU_SET_Cod'
        DataBinding.DataSource = DM.ds_usuarios
        Properties.KeyFieldNames = 'SET_Cod'
        Properties.ListColumns = <
          item
            FieldName = 'SET_Nome'
          end>
        Properties.ListOptions.ShowHeader = False
        Properties.ListSource = ds_setores
        TabOrder = 3
        Width = 212
      end
    end
  end
  object cds_setores: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 200
    Top = 8
  end
  object ds_setores: TDataSource
    DataSet = cds_setores
    Left = 248
    Top = 8
  end
end
