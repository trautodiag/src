object F_FuncoesPredefinidas: TF_FuncoesPredefinidas
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Fun'#231#245'es pre-definidas'
  ClientHeight = 93
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cxPageControl1: TcxPageControl
    Left = 0
    Top = 0
    Width = 460
    Height = 93
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = tab_funcoes
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 92
    ClientRectLeft = 1
    ClientRectRight = 459
    ClientRectTop = 1
    object tab_funcoes: TcxTabSheet
      Caption = 'tab_funcoes'
      ImageIndex = 0
      object lbl_fincao: TLabel
        Left = 7
        Top = 4
        Width = 35
        Height = 13
        Caption = 'Fun'#231#227'o'
      end
      object pnl_base: TPanel
        Left = 0
        Top = 50
        Width = 458
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        DesignSize = (
          458
          41)
        object btn_Canc: TcxButton
          Left = 262
          Top = 9
          Width = 91
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Cancelar'
          TabOrder = 0
          OnClick = btn_CancClick
        end
        object btn_Ok: TcxButton
          Left = 359
          Top = 9
          Width = 91
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'OK'
          TabOrder = 1
          OnClick = btn_OkClick
        end
      end
      object img_funcoes: TcxImageComboBox
        Left = 7
        Top = 23
        Properties.Items = <
          item
            Description = 'Capturar tela'
            ImageIndex = 0
            Value = -1
          end
          item
            Description = 'For'#231'ar o desligamento do computador'
            Value = -2
          end
          item
            Description = 'Faz "logout" do sistema'
            Value = -3
          end
          item
            Description = 'Desliga o computador '
            Value = -4
          end
          item
            Description = 'Reinicializa o computador'
            Value = -5
          end
          item
            Description = 'Desliga o computador com seguran'#231'a'
            Value = -6
          end
          item
            Description = 'Lista de processos'
            Value = -7
          end>
        TabOrder = 0
        Width = 444
      end
    end
  end
end
