inherited F_ProtocoloIni: TF_ProtocoloIni
  Caption = 'Protocollo v 1.0.0'
  PixelsPerInch = 96
  TextHeight = 13
  inherited act_Cadastros: TActionList
    inherited act_CadEmpresa: TAction
      OnExecute = act_CadEmpresaExecute
    end
    inherited act_CadClientes: TAction
      OnExecute = act_CadClientesExecute
    end
    inherited act_CadDocumentos: TAction
      OnExecute = act_CadDocumentosExecute
    end
    inherited act_EmiProtocolos: TAction
      OnExecute = act_EmiProtocolosExecute
    end
    inherited ac_CadUsuarios: TAction
      OnExecute = ac_CadUsuariosExecute
    end
    inherited ac_CadSetores: TAction
      OnExecute = ac_CadSetoresExecute
    end
    inherited act_ArquivoCliente: TAction
      OnExecute = act_ArquivoClienteExecute
    end
    inherited act_AgendaCompCad: TAction
      OnExecute = act_AgendaCompCadExecute
    end
  end
  inherited pm_rotinas: TPopupMenu
    object Agendadecompromissos3: TMenuItem
      Action = act_AgendaCompCad
    end
  end
  inherited pm_ferramentas: TPopupMenu
    inherited Caixadocliente2: TMenuItem
      Action = act_ArquivoCliente
    end
  end
end
