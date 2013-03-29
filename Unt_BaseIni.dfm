object F_BaseIni: TF_BaseIni
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 200
  ClientHeight = 28
  ClientWidth = 361
  Color = clWhite
  TransparentColor = True
  TransparentColorValue = clAqua
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDefault
  ShowHint = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pgctrl_base: TcxPageControl
    Left = 0
    Top = 0
    Width = 361
    Height = 28
    Align = alClient
    TabOrder = 0
    Properties.ActivePage = ts_base
    Properties.CustomButtons.Buttons = <>
    Properties.HideTabs = True
    ClientRectBottom = 27
    ClientRectLeft = 1
    ClientRectRight = 360
    ClientRectTop = 1
    object ts_base: TcxTabSheet
      Caption = 'ts_base'
      ImageIndex = 0
      object pnl_menu: TPanel
        Left = 0
        Top = 0
        Width = 359
        Height = 26
        Align = alClient
        BevelOuter = bvNone
        Color = clWhite
        TabOrder = 0
        object img_base: TImage
          Left = 321
          Top = 0
          Width = 38
          Height = 26
          Align = alClient
          Center = True
          Picture.Data = {
            0B546478504E47496D61676589504E470D0A1A0A0000000D4948445200000020
            000000200806000000737A7AF4000000017352474200AECE1CE9000000046741
            4D410000B18F0BFC6105000000206348524D00007A26000080840000FA000000
            80E8000075300000EA6000003A98000017709CBA513C00000117494441545847
            CD96610E83200C853D82F7FFB3A3EC083B1203024D41681FD5B299906884BECF
            FA5A380EFB75C6A59F385EF610F695553CC410696C85E8C5B742CCC4B74068E2
            AE10A8F833102184431BC57C55304E1FAF31F95C134FEF5D0172F4F245BD90E1
            D99484F32900160706C986EB0190DFC2E7D44CB13850B322B73B00401D335166
            673B01881024EE0C308468C4474EB77A40A81AF2842ACE33828280E59A21D29E
            4E1D6D768F0A2F966F0680FABC034053961708C72A98564203E1082036A49F37
            22F2844306A0564C1BC6A29BA75564D98C32C4DF0008279DE6ABA53285F7613E
            51ABFBBE61B9003020A85931A835C38D5254CE7DFC150A715F5CF8671A84AB78
            E59A416C119F416C15E710EFF8704BFC0B52461B01E6D121990000000049454E
            44AE426082}
          OnMouseDown = img_baseMouseDown
          OnMouseLeave = btn_cadastroMouseLeave
          OnMouseMove = btn_cadastroMouseMove
          ExplicitWidth = 40
        end
        object btn_cadastro: TcxButton
          Left = 0
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Cadastros'
          TabOrder = 0
          OnMouseLeave = btn_cadastroMouseLeave
          OnMouseMove = btn_cadastroMouseMove
          DropDownMenu = pm_cadastros
          Kind = cxbkDropDownButton
        end
        object btn_rotinas: TcxButton
          Left = 75
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Rotinas'
          TabOrder = 1
          OnMouseLeave = btn_cadastroMouseLeave
          OnMouseMove = btn_cadastroMouseMove
          DropDownMenu = pm_rotinas
          Kind = cxbkDropDownButton
        end
        object btn_relatorios: TcxButton
          Left = 150
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Rel'#225'torios'
          TabOrder = 2
          OnMouseLeave = btn_cadastroMouseLeave
          OnMouseMove = btn_cadastroMouseMove
          DropDownMenu = pm_relatorios
          Kind = cxbkDropDownButton
        end
        object btn_ferramentas: TcxButton
          Left = 225
          Top = 0
          Width = 96
          Height = 26
          Align = alLeft
          Caption = 'Ferramentas'
          TabOrder = 3
          OnMouseLeave = btn_cadastroMouseLeave
          OnMouseMove = btn_cadastroMouseMove
          DropDownMenu = pm_ferramentas
          Kind = cxbkDropDownButton
        end
      end
    end
  end
  object act_Cadastros: TActionList
    Left = 64
    Top = 56
    object act_CadEmpresa: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro da empresa...'
    end
    object act_CadClientes: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de clientes...'
    end
    object act_CadDocumentos: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de documentos...'
    end
    object act_Sair: TAction
      Category = 'Ferramentas'
      Caption = 'Fechar aplica'#231#227'o'
      OnExecute = act_SairExecute
    end
    object act_EmiProtocolos: TAction
      Category = 'Rotinas'
      Caption = 'Emiss'#227'o de protocolos...'
    end
    object act_RelClientes: TAction
      Category = 'Relatorios'
      Caption = 'Rel'#225'torio de clientes...'
    end
    object act_RelProtocolos: TAction
      Category = 'Relatorios'
      Caption = 'Rel'#225'torio de protocolos...'
    end
    object act_RelDocumentos: TAction
      Category = 'Relatorios'
      Caption = 'Rel'#225'torio de documentos...'
    end
    object ac_CadUsuarios: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de usuarios...'
    end
    object ac_CadSetores: TAction
      Category = 'Cadastros'
      Caption = 'Cadastro de setores...'
    end
    object act_Sobre: TAction
      Category = 'Ferramentas'
      Caption = 'Sobre a aplica'#231#227'o...'
      OnExecute = act_SobreExecute
    end
    object act_AgendaCompromisso: TAction
      Category = 'Ferramentas'
      Caption = 'Agenda de compromissos...'
      OnExecute = act_AgendaCompromissoExecute
    end
    object ac_IniciarWindows: TAction
      AutoCheck = True
      Caption = 'Iniciar aplica'#231#227'o com o windows'
      OnExecute = ac_IniciarWindowsExecute
    end
    object ac_CaixaCliente: TAction
      Category = 'Ferramentas'
      Caption = 'Caixa do cliente...'
      OnExecute = ac_CaixaClienteExecute
    end
    object act_ArquivoCliente: TAction
      Category = 'Rotinas'
      Caption = 'Arquivo do cliente...'
    end
    object act_AgendaCompCad: TAction
      Category = 'Rotinas'
      Caption = 'Agenda de compromissos...'
    end
  end
  object skin_base: TdxSkinController
    NativeStyle = False
    SkinName = 'Office2007Blue'
    Left = 304
    Top = 120
  end
  object pm_cadastros: TPopupMenu
    Left = 48
    Top = 208
    object mni_act_CadEmpresa: TMenuItem
      Action = act_CadEmpresa
    end
    object mni_act_CadClientes: TMenuItem
      Action = act_CadClientes
    end
    object acCadUsuarios1: TMenuItem
      Action = ac_CadUsuarios
    end
    object mni_act_CadDocumentos: TMenuItem
      Action = act_CadDocumentos
    end
    object Cadastrodesetores1: TMenuItem
      Action = ac_CadSetores
    end
    object mniN2: TMenuItem
      Caption = '-'
    end
    object mni_act_Sair: TMenuItem
      Action = act_Sair
    end
  end
  object pm_rotinas: TPopupMenu
    Left = 120
    Top = 200
    object mni_act_EmiProtocolos: TMenuItem
      Action = act_EmiProtocolos
    end
    object Arquivodocliente1: TMenuItem
      Action = act_ArquivoCliente
    end
  end
  object pm_relatorios: TPopupMenu
    Left = 200
    Top = 208
    object mni_act_RelClientes: TMenuItem
      Action = act_RelClientes
    end
    object mni_act_RelProtocolos: TMenuItem
      Action = act_RelProtocolos
    end
    object mni_act_RelDocumentos: TMenuItem
      Action = act_RelDocumentos
    end
  end
  object pm_ferramentas: TPopupMenu
    Left = 320
    Top = 216
    object Agendadecompromissos2: TMenuItem
      Action = act_AgendaCompromisso
    end
    object Caixadocliente2: TMenuItem
      Action = ac_CaixaCliente
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Sobreaaplicao1: TMenuItem
      Action = act_Sobre
    end
  end
  object pm_try: TPopupMenu
    Left = 64
    object mni_Cadastros: TMenuItem
      Caption = 'Cadastro'
      object Cadastrodaempresa1: TMenuItem
        Action = act_CadEmpresa
      end
      object Cadastrodeusuarios1: TMenuItem
        Action = ac_CadUsuarios
      end
      object Cadastrodesetores2: TMenuItem
        Action = ac_CadSetores
      end
      object Cadastrodedocumentos1: TMenuItem
        Action = act_CadDocumentos
      end
      object Cadastrodeclientes1: TMenuItem
        Action = act_CadClientes
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Ferramentas1: TMenuItem
      Caption = 'Ferramentas'
      object Agendadecompromissos1: TMenuItem
        Action = act_AgendaCompromisso
      end
      object Caixadocliente1: TMenuItem
        Action = ac_CaixaCliente
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Iniciaraplicaocomowindows1: TMenuItem
        Action = ac_IniciarWindows
        AutoCheck = True
      end
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Fecharaplicao1: TMenuItem
      Action = act_Sair
    end
  end
  object tm_sobre: TTimer
    Enabled = False
    Interval = 100
    OnTimer = tm_sobreTimer
    Left = 104
  end
  object hint_base: TcxHintStyleController
    HintStyleClassName = 'TcxHintStyle'
    HintStyle.CallOutPosition = cxbpAuto
    HintStyle.CaptionFont.Charset = DEFAULT_CHARSET
    HintStyle.CaptionFont.Color = clWindowText
    HintStyle.CaptionFont.Height = -11
    HintStyle.CaptionFont.Name = 'Tahoma'
    HintStyle.CaptionFont.Style = [fsBold]
    HintStyle.Font.Charset = DEFAULT_CHARSET
    HintStyle.Font.Color = clWindowText
    HintStyle.Font.Height = -11
    HintStyle.Font.Name = 'Tahoma'
    HintStyle.Font.Style = []
    Left = 152
  end
end
