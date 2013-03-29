object F_BaseCad: TF_BaseCad
  Left = 0
  Top = 0
  AlphaBlend = True
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  ClientHeight = 497
  ClientWidth = 670
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object pgctrl_base: TcxPageControl
    Left = 0
    Top = 0
    Width = 670
    Height = 497
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = ts_base
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 496
    ClientRectLeft = 1
    ClientRectRight = 669
    ClientRectTop = 1
    object ts_base: TcxTabSheet
      Caption = 'ts_base'
      ImageIndex = 0
      object pnl_Base: TPanel
        Left = 0
        Top = 462
        Width = 668
        Height = 33
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        DesignSize = (
          668
          33)
        object btn_Salvar: TcxButton
          Left = 476
          Top = 5
          Width = 91
          Height = 25
          Action = act_Salvar
          Anchors = [akTop, akRight]
          TabOrder = 0
        end
        object btn_Cancelar: TcxButton
          Left = 573
          Top = 5
          Width = 91
          Height = 25
          Action = act_Cancelar
          Anchors = [akTop, akRight]
          TabOrder = 1
        end
      end
    end
  end
  object act_cadastros: TActionList
    Left = 136
    Top = 136
    object act_Salvar: TAction
      Caption = 'Salvar registro'
      OnExecute = act_SalvarExecute
    end
    object act_Cancelar: TAction
      Caption = 'Cancelar registro'
      OnExecute = act_CancelarExecute
    end
  end
end
