inherited F_CadDocumentos: TF_CadDocumentos
  Caption = 'Cadastro de documentos'
  ClientHeight = 85
  ClientWidth = 464
  OnShow = FormShow
  ExplicitWidth = 470
  ExplicitHeight = 113
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_codigo: TLabel [0]
    Left = 8
    Top = 8
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
    FocusControl = dbedt_DOC_Cod
  end
  object lbl_documento: TLabel [1]
    Left = 111
    Top = 8
    Width = 54
    Height = 13
    Caption = 'Documento'
    FocusControl = dbedt_DOC_Nome
  end
  inherited pgctrl_base: TcxPageControl
    Width = 464
    Height = 85
    TabOrder = 2
    ExplicitWidth = 464
    ExplicitHeight = 85
    ClientRectBottom = 84
    ClientRectRight = 463
    inherited ts_base: TcxTabSheet
      ExplicitWidth = 462
      ExplicitHeight = 83
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
        Width = 54
        Height = 13
        Caption = 'Documento'
      end
      inherited pnl_Base: TPanel
        Top = 50
        Width = 462
        ExplicitTop = 50
        ExplicitWidth = 462
        inherited btn_Salvar: TcxButton
          Left = 263
          ExplicitLeft = 263
        end
        inherited btn_Cancelar: TcxButton
          Left = 361
          ExplicitLeft = 361
        end
      end
    end
  end
  object dbedt_DOC_Cod: TDBEdit [3]
    Left = 8
    Top = 24
    Width = 97
    Height = 21
    DataField = 'DOC_Cod'
    DataSource = DM.ds_documentos
    Enabled = False
    ReadOnly = True
    TabOrder = 0
  end
  object dbedt_DOC_Nome: TDBEdit [4]
    Left = 111
    Top = 24
    Width = 345
    Height = 21
    CharCase = ecUpperCase
    DataField = 'DOC_Nome'
    DataSource = DM.ds_documentos
    TabOrder = 1
  end
end
