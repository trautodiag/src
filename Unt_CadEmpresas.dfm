inherited F_CadEmpresas: TF_CadEmpresas
  Caption = 'Cadastro de empresas'
  ClientHeight = 255
  ClientWidth = 511
  OnShow = FormShow
  ExplicitWidth = 517
  ExplicitHeight = 283
  PixelsPerInch = 96
  TextHeight = 13
  inherited pgctrl_base: TcxPageControl
    Width = 511
    Height = 255
    ClientRectBottom = 254
    ClientRectRight = 510
    inherited ts_base: TcxTabSheet
      object lbl_cod: TLabel [0]
        Left = 145
        Top = 7
        Width = 33
        Height = 13
        Caption = 'Codigo'
      end
      object lbl_Descricao: TLabel [1]
        Left = 247
        Top = 7
        Width = 27
        Height = 13
        Caption = 'Nome'
      end
      object Label1: TLabel [2]
        Left = 325
        Top = 134
        Width = 46
        Height = 13
        Caption = 'Fone/Fax'
      end
      object lbl_logradouro: TLabel [3]
        Left = 145
        Top = 49
        Width = 55
        Height = 13
        Caption = 'Logradouro'
      end
      object lbl_numero: TLabel [4]
        Left = 408
        Top = 49
        Width = 37
        Height = 13
        Caption = 'Numero'
      end
      object lbl_cidade: TLabel [5]
        Left = 145
        Top = 92
        Width = 33
        Height = 13
        Caption = 'Cidade'
      end
      object lbl_UF: TLabel [6]
        Left = 281
        Top = 92
        Width = 13
        Height = 13
        Caption = 'UF'
      end
      object lbl_CEP: TLabel [7]
        Left = 342
        Top = 92
        Width = 19
        Height = 13
        Caption = 'CEP'
      end
      object lbl_atencao: TLabel [8]
        Left = 3
        Top = 134
        Width = 34
        Height = 13
        Caption = 'E - Mail'
      end
      object lbl_Url: TLabel [9]
        Left = 3
        Top = 177
        Width = 42
        Height = 13
        Caption = 'Url [Site]'
      end
      object lbl_Logo: TLabel [10]
        Left = 3
        Top = 7
        Width = 23
        Height = 13
        Caption = 'Logo'
        FocusControl = img_EMP_Logo
      end
      inherited pnl_Base: TPanel
        Top = 220
        Width = 509
        TabOrder = 11
        inherited btn_Salvar: TcxButton
          Left = 317
        end
        inherited btn_Cancelar: TcxButton
          Left = 414
        end
      end
      object dbedt_EMP_Cod: TDBEdit
        Left = 145
        Top = 24
        Width = 97
        Height = 21
        DataField = 'EMP_Cod'
        DataSource = DM.ds_empresa
        Enabled = False
        ReadOnly = True
        TabOrder = 1
      end
      object dbedt_EMP_Nome: TDBEdit
        Left = 247
        Top = 24
        Width = 258
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_Nome'
        DataSource = DM.ds_empresa
        TabOrder = 2
      end
      object dbedt_EMP_FoneFax: TDBEdit
        Left = 325
        Top = 151
        Width = 114
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_FoneFax'
        DataSource = DM.ds_empresa
        TabOrder = 9
      end
      object dbedt_EMP_Logradouro: TDBEdit
        Left = 145
        Top = 66
        Width = 258
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_Logradouro'
        DataSource = DM.ds_empresa
        TabOrder = 3
      end
      object dbedt_EMP_Numero: TDBEdit
        Left = 408
        Top = 66
        Width = 97
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_Numero'
        DataSource = DM.ds_empresa
        TabOrder = 4
        OnKeyPress = dbedt_EMP_NumeroKeyPress
      end
      object dbedt_EMP_Cidade: TDBEdit
        Left = 145
        Top = 109
        Width = 130
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_Cidade'
        DataSource = DM.ds_empresa
        TabOrder = 5
      end
      object dbcbb_EMP_UF: TDBComboBox
        Left = 281
        Top = 109
        Width = 55
        Height = 21
        Style = csDropDownList
        DataField = 'EMP_UF'
        DataSource = DM.ds_empresa
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
        TabOrder = 6
      end
      object dbedt_EMP_CEP: TDBEdit
        Left = 342
        Top = 109
        Width = 97
        Height = 21
        CharCase = ecUpperCase
        DataField = 'EMP_CEP'
        DataSource = DM.ds_empresa
        TabOrder = 7
      end
      object dbedt_atencao: TDBEdit
        Left = 3
        Top = 151
        Width = 316
        Height = 21
        DataField = 'EMP_Email'
        DataSource = DM.ds_empresa
        TabOrder = 8
      end
      object dbedt_EMP_Url: TDBEdit
        Left = 3
        Top = 194
        Width = 436
        Height = 21
        DataField = 'EMP_Email'
        DataSource = DM.ds_empresa
        TabOrder = 10
      end
      object img_EMP_Logo: TcxDBImage
        Left = 3
        Top = 24
        DataBinding.DataField = 'EMP_Logo'
        DataBinding.DataSource = DM.ds_empresa
        TabOrder = 0
        Height = 106
        Width = 137
      end
    end
  end
  inherited act_cadastros: TActionList
    Left = 400
    Top = 264
  end
end
