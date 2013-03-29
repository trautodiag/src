inherited F_CadClientes: TF_CadClientes
  Caption = 'Cadastro de clientes'
  ClientHeight = 170
  ClientWidth = 513
  OnShow = FormShow
  ExplicitWidth = 519
  ExplicitHeight = 202
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 513
    Height = 170
    ClientRectBottom = 169
    ClientRectRight = 512
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
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label1: TLabel [2]
        Left = 375
        Top = 7
        Width = 46
        Height = 13
        Caption = 'Fone/Fax'
      end
      object lbl_logradouro: TLabel [3]
        Left = 8
        Top = 49
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object lbl_numero: TLabel [4]
        Left = 272
        Top = 49
        Width = 37
        Height = 13
        Caption = 'Numero'
      end
      object lbl_cidade: TLabel [5]
        Left = 375
        Top = 49
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lbl_UF: TLabel [6]
        Left = 8
        Top = 93
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object lbl_CEP: TLabel [7]
        Left = 69
        Top = 93
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lbl_atencao: TLabel [8]
        Left = 172
        Top = 93
        Width = 101
        Height = 13
        Caption = 'Aten'#231#227'o [Protocolos]'
      end
      inherited pnl_Base: TPanel
        Top = 135
        Width = 511
        inherited btn_Salvar: TcxButton
          Left = 319
        end
        inherited btn_Cancelar: TcxButton
          Left = 416
        end
      end
      object dbedt_CLI_Cod: TDBEdit
        Left = 8
        Top = 24
        Width = 97
        Height = 21
        DataField = 'CLI_Cod'
        DataSource = DM.ds_clientes
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object dbedt_CLI_Nome: TDBEdit
        Left = 111
        Top = 24
        Width = 258
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_Nome'
        DataSource = DM.ds_clientes
        TabOrder = 2
      end
      object dbedt_CLI_FoneFax: TDBEdit
        Left = 375
        Top = 24
        Width = 130
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_FoneFax'
        DataSource = DM.ds_clientes
        TabOrder = 3
      end
      object dbedt_Logradouro: TDBEdit
        Left = 8
        Top = 66
        Width = 258
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_Logradouro'
        DataSource = DM.ds_clientes
        TabOrder = 4
      end
      object dbedt_numero: TDBEdit
        Left = 272
        Top = 66
        Width = 97
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_Numero'
        DataSource = DM.ds_clientes
        TabOrder = 5
        OnKeyPress = dbedt_numeroKeyPress
      end
      object dbedt_cidade: TDBEdit
        Left = 375
        Top = 66
        Width = 130
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_Cidade'
        DataSource = DM.ds_clientes
        TabOrder = 6
      end
      object dbcbb_UF: TDBComboBox
        Left = 8
        Top = 110
        Width = 55
        Height = 21
        Style = csDropDownList
        DataField = 'CLI_UF'
        DataSource = DM.ds_clientes
        ItemHeight = 13
        Items.Strings = (
          'AC'
          'AL'
          'AP'
          'AM'
          'BA'
          'CE'
          'DF'
          'ES'
          'GO'
          'MA'
          'MT'
          'MS'
          'MG'
          'PA'
          'PB'
          'PR'
          'PE'
          'PI'
          'RJ'
          'RN'
          'RS'
          'RO'
          'RR'
          'SC'
          'SP'
          'SE'
          'TO')
        TabOrder = 7
      end
      object dbedt_CEP: TDBEdit
        Left = 69
        Top = 110
        Width = 97
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_CEP'
        DataSource = DM.ds_clientes
        TabOrder = 8
      end
      object dbedt_atencao: TDBEdit
        Left = 172
        Top = 110
        Width = 278
        Height = 21
        CharCase = ecUpperCase
        DataField = 'CLI_Atencao'
        DataSource = DM.ds_clientes
        TabOrder = 9
      end
      object cxDBCheckBox1: TcxDBCheckBox
        Left = 456
        Top = 110
        Caption = 'Ativo'
        DataBinding.DataField = 'CLI_Ativo'
        DataBinding.DataSource = DM.ds_clientes
        TabOrder = 10
        Transparent = True
        Width = 49
      end
    end
  end
  inherited act_cadastros: TActionList
    Left = 448
    Top = 8
  end
end
