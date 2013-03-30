object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 471
  Width = 734
  object cds_empresa: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_empresaBeforeInsert
    AfterCancel = cds_empresaAfterCancel
    AfterDelete = cds_empresaAfterDelete
    OnNewRecord = cds_empresaNewRecord
    Left = 48
    Top = 40
    object cds_empresaEMP_Nome: TStringField
      FieldName = 'EMP_Nome'
      Size = 50
    end
    object cds_empresaEMP_Fantasia: TStringField
      FieldName = 'EMP_Fantasia'
      Size = 50
    end
    object cds_empresaEMP_Logradouro: TStringField
      FieldName = 'EMP_Logradouro'
      Size = 100
    end
    object cds_empresaEMP_Numero: TStringField
      FieldName = 'EMP_Numero'
      Size = 6
    end
    object cds_empresaEMP_Bairro: TStringField
      FieldName = 'EMP_Bairro'
      Size = 50
    end
    object cds_empresaEMP_Cidade: TStringField
      FieldName = 'EMP_Cidade'
      Size = 50
    end
    object cds_empresaEMP_UF: TStringField
      FieldName = 'EMP_UF'
      Size = 2
    end
    object cds_empresaEMP_CEP: TStringField
      FieldName = 'EMP_CEP'
      EditMask = '99.999-999;0;_'
      Size = 8
    end
    object cds_empresaEMP_FoneFax: TStringField
      FieldName = 'EMP_FoneFax'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object cds_empresaEMP_Email: TStringField
      FieldName = 'EMP_Email'
      Size = 30
    end
    object cds_empresaEMP_Url: TStringField
      FieldName = 'EMP_Url'
      Size = 30
    end
    object cds_empresaEMP_Logo: TGraphicField
      FieldName = 'EMP_Logo'
      BlobType = ftGraphic
    end
    object cds_empresaData: TDateTimeField
      FieldName = 'Data'
    end
    object cds_empresaEMP_Cod: TAutoIncField
      FieldName = 'EMP_Cod'
    end
  end
  object cds_clientes: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_clientesBeforeInsert
    AfterCancel = cds_clientesAfterCancel
    AfterDelete = cds_clientesAfterDelete
    OnNewRecord = cds_clientesNewRecord
    Left = 136
    Top = 40
    object cds_clientesCLI_Nome: TStringField
      FieldName = 'CLI_Nome'
      Size = 80
    end
    object cds_clientesCLI_Atencao: TStringField
      FieldName = 'CLI_Atencao'
      Size = 30
    end
    object cds_clientesCLI_Logradouro: TStringField
      FieldName = 'CLI_Logradouro'
      Size = 80
    end
    object cds_clientesCLI_Numero: TStringField
      FieldName = 'CLI_Numero'
      Size = 6
    end
    object cds_clientesCLI_Bairro: TStringField
      FieldName = 'CLI_Bairro'
      Size = 30
    end
    object cds_clientesCLI_Cidade: TStringField
      FieldName = 'CLI_Cidade'
      Size = 30
    end
    object cds_clientesCLI_UF: TStringField
      FieldName = 'CLI_UF'
      Size = 2
    end
    object cds_clientesCLI_CEP: TStringField
      FieldName = 'CLI_CEP'
      EditMask = '99.999-999;0;_'
      Size = 8
    end
    object cds_clientesCLI_FoneFax: TStringField
      FieldName = 'CLI_FoneFax'
      EditMask = '(99)9999-9999;0;_'
      Size = 10
    end
    object cds_clientesCLI_Ativo: TBooleanField
      FieldName = 'CLI_Ativo'
    end
    object cds_clientesCLI_Cod: TAutoIncField
      FieldName = 'CLI_Cod'
    end
    object cds_clientesData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object cds_documentos: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_documentosBeforeInsert
    AfterCancel = cds_documentosAfterCancel
    AfterDelete = cds_documentosAfterDelete
    OnNewRecord = cds_documentosNewRecord
    Left = 232
    Top = 40
    object cds_documentosDOC_Cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'DOC_Cod'
    end
    object cds_documentosDOC_Nome: TStringField
      DisplayLabel = 'Documento'
      FieldName = 'DOC_Nome'
      Size = 80
    end
    object cds_documentosData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object cds_protocolos: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_protocolosBeforeInsert
    AfterCancel = cds_protocolosAfterCancel
    AfterDelete = cds_protocolosAfterDelete
    OnNewRecord = cds_protocolosNewRecord
    Left = 336
    Top = 40
    object cds_protocolosPRO_Cod: TAutoIncField
      FieldName = 'PRO_Cod'
    end
    object cds_protocolosPRO_Time: TDateTimeField
      FieldName = 'PRO_Time'
    end
    object cds_protocolosPRO_CLI_Cod: TIntegerField
      FieldName = 'PRO_CLI_Cod'
    end
    object cds_protocolosPRO_Obs: TMemoField
      FieldName = 'PRO_Obs'
      BlobType = ftMemo
    end
    object cds_protocolosPRO_USU_Cod: TIntegerField
      FieldName = 'PRO_USU_Cod'
    end
    object cds_protocolosPRO_EMP_Cod: TIntegerField
      FieldName = 'PRO_EMP_Cod'
    end
    object cds_protocolosData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object cds_usuarios: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_usuariosBeforeInsert
    AfterCancel = cds_usuariosAfterCancel
    AfterDelete = cds_usuariosAfterDelete
    OnNewRecord = cds_usuariosNewRecord
    Left = 432
    Top = 40
    object cds_usuariosUSU_Cod: TAutoIncField
      FieldName = 'USU_Cod'
    end
    object cds_usuariosUSU_Nome: TStringField
      FieldName = 'USU_Nome'
      Size = 50
    end
    object cds_usuariosUSU_SET_Cod: TIntegerField
      FieldName = 'USU_SET_Cod'
    end
    object cds_usuariosData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object cds_setor: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_setorBeforeInsert
    AfterCancel = cds_setorAfterCancel
    AfterDelete = cds_setorAfterDelete
    OnNewRecord = cds_setorNewRecord
    Left = 528
    Top = 40
    object cds_setorSET_Cod: TAutoIncField
      FieldName = 'SET_Cod'
    end
    object cds_setorSET_Nome: TStringField
      FieldName = 'SET_Nome'
      Size = 30
    end
    object cds_setorData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object cds_itensProtocolo: TClientDataSet
    Aggregates = <>
    Params = <>
    AfterCancel = cds_itensProtocoloAfterCancel
    AfterDelete = cds_itensProtocoloAfterDelete
    OnNewRecord = cds_itensProtocoloNewRecord
    OnPostError = cds_itensProtocoloPostError
    Left = 624
    Top = 40
    object cds_itensProtocoloITE_Cod: TAutoIncField
      FieldName = 'ITE_Cod'
    end
    object cds_itensProtocoloITE_PRO_Cod: TIntegerField
      FieldName = 'ITE_PRO_Cod'
    end
    object cds_itensProtocoloITE_DOC_Cod: TIntegerField
      FieldName = 'ITE_DOC_Cod'
    end
    object cds_itensProtocoloITE_DOC_Comp: TStringField
      FieldName = 'ITE_DOC_Comp'
      EditMask = '99/9999;0;_'
      Size = 6
    end
    object cds_itensProtocoloITE_DOC_Vencimento: TDateField
      FieldName = 'ITE_DOC_Vencimento'
    end
    object cds_itensProtocoloITE_DOC_Valor: TCurrencyField
      FieldName = 'ITE_DOC_Valor'
    end
    object cds_itensProtocoloITE_DOC_Obs: TStringField
      FieldName = 'ITE_DOC_Obs'
      Size = 100
    end
    object cds_itensProtocoloData: TDateTimeField
      FieldName = 'Data'
    end
  end
  object ds_empresa: TDataSource
    DataSet = cds_empresa
    Left = 48
    Top = 104
  end
  object ds_clientes: TDataSource
    DataSet = cds_clientes
    Left = 136
    Top = 104
  end
  object ds_documentos: TDataSource
    DataSet = cds_documentos
    Left = 232
    Top = 104
  end
  object ds_protocolos: TDataSource
    DataSet = cds_protocolos
    Left = 336
    Top = 104
  end
  object ds_usuarios: TDataSource
    DataSet = cds_usuarios
    Left = 432
    Top = 104
  end
  object ds_setor: TDataSource
    DataSet = cds_setor
    Left = 528
    Top = 104
  end
  object ds_itensProtocolo: TDataSource
    DataSet = cds_itensProtocolo
    Left = 624
    Top = 104
  end
  object cds_pasta: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_pastaBeforeInsert
    AfterCancel = cds_pastaAfterCancel
    AfterDelete = cds_pastaAfterDelete
    OnNewRecord = cds_pastaNewRecord
    Left = 48
    Top = 176
    object cds_pastaPST_Cod: TAutoIncField
      FieldName = 'PST_Cod'
    end
    object cds_pastaPST_CLI_Cod: TIntegerField
      FieldName = 'PST_CLI_Cod'
    end
    object cds_pastaPST_Nome: TStringField
      FieldName = 'PST_Nome'
      Size = 100
    end
    object cds_pastaPST_Obs: TMemoField
      FieldName = 'PST_Obs'
      BlobType = ftMemo
    end
    object cds_pastaPST_Path: TStringField
      FieldName = 'PST_Path'
      Size = 150
    end
  end
  object ds_pasta: TDataSource
    DataSet = cds_pasta
    Left = 48
    Top = 240
  end
  object cds_arquivo: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_arquivoBeforeInsert
    AfterCancel = cds_arquivoAfterCancel
    AfterDelete = cds_arquivoAfterDelete
    OnNewRecord = cds_arquivoNewRecord
    Left = 136
    Top = 176
    object cds_arquivoARQ_Cod: TAutoIncField
      FieldName = 'ARQ_Cod'
    end
    object cds_arquivoARQ_PST_Cod: TIntegerField
      FieldName = 'ARQ_PST_Cod'
    end
    object cds_arquivoARQ_Nome: TStringField
      FieldName = 'ARQ_Nome'
      Size = 100
    end
    object cds_arquivoARQ_Path: TStringField
      FieldName = 'ARQ_Path'
      Size = 150
    end
    object cds_arquivoARQ_Obs: TMemoField
      FieldName = 'ARQ_Obs'
      BlobType = ftMemo
    end
    object cds_arquivoARQ_USU_Cod: TIntegerField
      FieldName = 'ARQ_USU_Cod'
    end
    object cds_arquivoData: TDateTimeField
      FieldName = 'Data'
    end
    object cds_arquivoARQ_NomeGuid: TStringField
      FieldName = 'ARQ_NomeGuid'
      Size = 100
    end
  end
  object ds_arquivo: TDataSource
    DataSet = cds_arquivo
    Left = 136
    Top = 240
  end
  object cds_AgendaCompromisso: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cds_AgendaCompromissoBeforeInsert
    AfterCancel = cds_AgendaCompromissoAfterCancel
    AfterDelete = cds_AgendaCompromissoAfterDelete
    OnNewRecord = cds_AgendaCompromissoNewRecord
    Left = 232
    Top = 176
    object cds_AgendaCompromissoAGC_Cod: TAutoIncField
      FieldName = 'AGC_Cod'
    end
    object cds_AgendaCompromissoAGC_Data: TDateTimeField
      FieldName = 'AGC_Data'
    end
    object cds_AgendaCompromissoAGC_USU_Cod: TIntegerField
      FieldName = 'AGC_USU_Cod'
    end
    object cds_AgendaCompromissoAGC_EMP_Cod: TIntegerField
      FieldName = 'AGC_EMP_Cod'
    end
    object cds_AgendaCompromissoAGC_Prioridade: TIntegerField
      FieldName = 'AGC_Prioridade'
    end
    object cds_AgendaCompromissoAGC_Descricao: TStringField
      FieldName = 'AGC_Descricao'
      Size = 100
    end
    object cds_AgendaCompromissoAGC_Observacao: TMemoField
      FieldName = 'AGC_Observacao'
      BlobType = ftMemo
    end
    object cds_AgendaCompromissoAGC_Status: TBooleanField
      FieldName = 'AGC_Status'
    end
    object cds_AgendaCompromissoData: TDateTimeField
      FieldName = 'Data'
    end
    object cds_AgendaCompromissoAGC_Hora: TIntegerField
      FieldName = 'AGC_Hora'
    end
    object cds_AgendaCompromissoAGC_Minuto: TIntegerField
      FieldName = 'AGC_Minuto'
    end
    object cds_AgendaCompromissoAGC_Alerta: TBooleanField
      FieldName = 'AGC_Alerta'
    end
  end
  object ds_AgendaCompromisso: TDataSource
    DataSet = cds_AgendaCompromisso
    Left = 232
    Top = 240
  end
end
