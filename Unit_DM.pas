unit Unit_DM;

interface

uses
  SysUtils, Classes, DB, DBClient, Dialogs, Forms;

type
  TDM = class(TDataModule)
    cds_empresa: TClientDataSet;
    cds_clientes: TClientDataSet;
    cds_documentos: TClientDataSet;
    cds_protocolos: TClientDataSet;
    cds_empresaEMP_Nome: TStringField;
    cds_empresaEMP_Fantasia: TStringField;
    cds_empresaEMP_Logradouro: TStringField;
    cds_empresaEMP_Numero: TStringField;
    cds_empresaEMP_Bairro: TStringField;
    cds_empresaEMP_Cidade: TStringField;
    cds_empresaEMP_UF: TStringField;
    cds_empresaEMP_CEP: TStringField;
    cds_empresaEMP_FoneFax: TStringField;
    cds_empresaEMP_Email: TStringField;
    cds_empresaEMP_Url: TStringField;
    cds_empresaEMP_Logo: TGraphicField;
    cds_clientesCLI_Nome: TStringField;
    cds_clientesCLI_Atencao: TStringField;
    cds_clientesCLI_Logradouro: TStringField;
    cds_clientesCLI_Numero: TStringField;
    cds_clientesCLI_Bairro: TStringField;
    cds_clientesCLI_Cidade: TStringField;
    cds_clientesCLI_UF: TStringField;
    cds_clientesCLI_CEP: TStringField;
    cds_clientesCLI_FoneFax: TStringField;
    cds_clientesCLI_Ativo: TBooleanField;
    cds_documentosDOC_Nome: TStringField;
    cds_protocolosPRO_Cod: TAutoIncField;
    cds_clientesCLI_Cod: TAutoIncField;
    cds_documentosDOC_Cod: TAutoIncField;
    cds_protocolosPRO_Time: TDateTimeField;
    cds_protocolosPRO_CLI_Cod: TIntegerField;
    cds_protocolosPRO_Obs: TMemoField;
    cds_protocolosPRO_USU_Cod: TIntegerField;
    cds_usuarios: TClientDataSet;
    cds_usuariosUSU_Cod: TAutoIncField;
    cds_usuariosUSU_Nome: TStringField;
    cds_usuariosUSU_SET_Cod: TIntegerField;
    cds_setor: TClientDataSet;
    cds_setorSET_Cod: TAutoIncField;
    cds_setorSET_Nome: TStringField;
    cds_itensProtocolo: TClientDataSet;
    cds_itensProtocoloITE_PRO_Cod: TIntegerField;
    cds_itensProtocoloITE_Cod: TAutoIncField;
    cds_itensProtocoloITE_DOC_Cod: TIntegerField;
    cds_itensProtocoloITE_DOC_Comp: TStringField;
    cds_itensProtocoloITE_DOC_Vencimento: TDateField;
    cds_itensProtocoloITE_DOC_Valor: TCurrencyField;
    cds_itensProtocoloITE_DOC_Obs: TStringField;
    ds_empresa: TDataSource;
    ds_clientes: TDataSource;
    ds_documentos: TDataSource;
    ds_protocolos: TDataSource;
    ds_usuarios: TDataSource;
    ds_setor: TDataSource;
    ds_itensProtocolo: TDataSource;
    cds_documentosData: TDateTimeField;
    cds_usuariosData: TDateTimeField;
    cds_setorData: TDateTimeField;
    cds_clientesData: TDateTimeField;
    cds_empresaData: TDateTimeField;
    cds_empresaEMP_Cod: TAutoIncField;
    cds_protocolosPRO_EMP_Cod: TIntegerField;
    cds_protocolosData: TDateTimeField;
    cds_itensProtocoloData: TDateTimeField;
    cds_pasta: TClientDataSet;
    ds_pasta: TDataSource;
    cds_pastaPST_Cod: TAutoIncField;
    cds_pastaPST_CLI_Cod: TIntegerField;
    cds_pastaPST_Nome: TStringField;
    cds_pastaPST_Obs: TMemoField;
    cds_pastaPST_Path: TStringField;
    cds_arquivo: TClientDataSet;
    ds_arquivo: TDataSource;
    cds_arquivoARQ_Cod: TAutoIncField;
    cds_arquivoARQ_PST_Cod: TIntegerField;
    cds_arquivoARQ_Nome: TStringField;
    cds_arquivoARQ_Path: TStringField;
    cds_arquivoARQ_Obs: TMemoField;
    cds_arquivoARQ_USU_Cod: TIntegerField;
    cds_arquivoData: TDateTimeField;
    cds_arquivoARQ_NomeGuid: TStringField;
    cds_AgendaCompromisso: TClientDataSet;
    ds_AgendaCompromisso: TDataSource;
    cds_AgendaCompromissoAGC_Cod: TAutoIncField;
    cds_AgendaCompromissoAGC_Data: TDateTimeField;
    cds_AgendaCompromissoAGC_USU_Cod: TIntegerField;
    cds_AgendaCompromissoAGC_EMP_Cod: TIntegerField;
    cds_AgendaCompromissoAGC_Prioridade: TIntegerField;
    cds_AgendaCompromissoAGC_Descricao: TStringField;
    cds_AgendaCompromissoAGC_Observacao: TMemoField;
    cds_AgendaCompromissoAGC_Status: TBooleanField;
    cds_AgendaCompromissoData: TDateTimeField;
    cds_AgendaCompromissoAGC_Hora: TIntegerField;
    cds_AgendaCompromissoAGC_Minuto: TIntegerField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cds_documentosNewRecord(DataSet: TDataSet);
    procedure cds_documentosAfterDelete(DataSet: TDataSet);
    procedure cds_documentosAfterCancel(DataSet: TDataSet);
    procedure DataModuleDestroy(Sender: TObject);
    procedure cds_usuariosAfterCancel(DataSet: TDataSet);
    procedure cds_usuariosAfterDelete(DataSet: TDataSet);
    procedure cds_usuariosNewRecord(DataSet: TDataSet);
    procedure cds_setorAfterCancel(DataSet: TDataSet);
    procedure cds_setorAfterDelete(DataSet: TDataSet);
    procedure cds_setorNewRecord(DataSet: TDataSet);
    procedure cds_clientesAfterCancel(DataSet: TDataSet);
    procedure cds_clientesAfterDelete(DataSet: TDataSet);
    procedure cds_clientesNewRecord(DataSet: TDataSet);
    procedure cds_empresaAfterCancel(DataSet: TDataSet);
    procedure cds_empresaAfterDelete(DataSet: TDataSet);
    procedure cds_empresaNewRecord(DataSet: TDataSet);
    procedure cds_protocolosAfterCancel(DataSet: TDataSet);
    procedure cds_protocolosAfterDelete(DataSet: TDataSet);
    procedure cds_protocolosNewRecord(DataSet: TDataSet);
    procedure cds_itensProtocoloAfterCancel(DataSet: TDataSet);
    procedure cds_itensProtocoloAfterDelete(DataSet: TDataSet);
    procedure cds_itensProtocoloNewRecord(DataSet: TDataSet);
    procedure cds_itensProtocoloPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure cds_protocolosBeforeInsert(DataSet: TDataSet);
    procedure cds_empresaBeforeInsert(DataSet: TDataSet);
    procedure cds_clientesBeforeInsert(DataSet: TDataSet);
    procedure cds_documentosBeforeInsert(DataSet: TDataSet);
    procedure cds_usuariosBeforeInsert(DataSet: TDataSet);
    procedure cds_setorBeforeInsert(DataSet: TDataSet);
    procedure cds_pastaBeforeInsert(DataSet: TDataSet);
    procedure cds_pastaAfterCancel(DataSet: TDataSet);
    procedure cds_pastaAfterDelete(DataSet: TDataSet);
    procedure cds_pastaNewRecord(DataSet: TDataSet);
    procedure cds_arquivoAfterCancel(DataSet: TDataSet);
    procedure cds_arquivoAfterDelete(DataSet: TDataSet);
    procedure cds_arquivoBeforeInsert(DataSet: TDataSet);
    procedure cds_arquivoNewRecord(DataSet: TDataSet);
    procedure cds_AgendaCompromissoBeforeInsert(DataSet: TDataSet);
    procedure cds_AgendaCompromissoAfterCancel(DataSet: TDataSet);
    procedure cds_AgendaCompromissoAfterDelete(DataSet: TDataSet);
    procedure cds_AgendaCompromissoNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    IDDocumento: Integer;
    IDUsuario: Integer;
    IDSetor: Integer;
    IDCliente: Integer;
    IDEmpresa: Integer;
    IDProtocolo: Integer;
    IDItProtocolo: Integer;
    IDPasta: Integer;
    IDArquivo: Integer;
    IDAgendaCompromisso: Integer;
    procedure CreateClientDataSet;
    procedure SalvaTabelas;
    procedure CarregaTabelas;
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

{ TDM }

procedure TDM.CarregaTabelas;
var
  i: Integer;
  nome: string;
begin
  try
    for I := 0 to Self.ComponentCount - 1 do
      if (Self.Components[i].ClassType = TClientDataSet) then
          begin
            nome:= ExtractFileDir(Application.ExeName)+'/'+copy(Self.Components[i].Name, 5,
                                                      length(Self.Components[i].Name))+'.prot';
            if FileExists(nome) then
              TClientDataSet(Self.Components[i]).LoadFromFile(nome);
          end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TDM.cds_AgendaCompromissoAfterCancel(DataSet: TDataSet);
begin
  Dec(IDAgendaCompromisso);
end;

procedure TDM.cds_AgendaCompromissoAfterDelete(DataSet: TDataSet);
begin
  Dec(IDAgendaCompromisso);
end;

procedure TDM.cds_AgendaCompromissoBeforeInsert(DataSet: TDataSet);
begin
  cds_AgendaCompromisso.IndexFieldNames:= 'AGC_Cod';
  if cds_AgendaCompromisso.RecordCount > 0 then
    begin
      cds_AgendaCompromisso.Last;
      IDAgendaCompromisso:= cds_AgendaCompromissoAGC_Cod.AsInteger;
    end;
end;

procedure TDM.cds_AgendaCompromissoNewRecord(DataSet: TDataSet);
begin
  inc(IDAgendaCompromisso);
  cds_AgendaCompromissoAGC_Cod.AsInteger:= IDAgendaCompromisso;
end;

procedure TDM.cds_arquivoAfterCancel(DataSet: TDataSet);
begin
  Dec(IDArquivo);
end;

procedure TDM.cds_arquivoAfterDelete(DataSet: TDataSet);
begin
  Dec(IDArquivo);
end;

procedure TDM.cds_arquivoBeforeInsert(DataSet: TDataSet);
begin
  cds_arquivo.IndexFieldNames:= 'ARQ_Cod';
  if cds_arquivo.RecordCount > 0 then
    begin
      cds_arquivo.Last;
      IDArquivo:= cds_arquivoARQ_Cod.AsInteger;
    end;
end;

procedure TDM.cds_arquivoNewRecord(DataSet: TDataSet);
begin
  inc(IDArquivo);
  cds_arquivoARQ_Cod.AsInteger:= IDArquivo;
end;

procedure TDM.cds_clientesAfterCancel(DataSet: TDataSet);
begin
  Dec(IDCliente);
end;

procedure TDM.cds_clientesAfterDelete(DataSet: TDataSet);
begin
  Dec(IDCliente);
end;

procedure TDM.cds_clientesBeforeInsert(DataSet: TDataSet);
begin
  cds_clientes.IndexFieldNames:= 'CLI_Cod';
  if cds_clientes.RecordCount > 0 then
    begin
      cds_clientes.Last;
      IDCliente:= cds_clientesCLI_Cod.AsInteger;
    end;
end;

procedure TDM.cds_clientesNewRecord(DataSet: TDataSet);
begin
  inc(IDCliente);
  cds_clientesCLI_Cod.AsInteger:= IDCliente;
end;

procedure TDM.cds_documentosAfterCancel(DataSet: TDataSet);
begin
  Dec(IDDocumento);
end;

procedure TDM.cds_documentosAfterDelete(DataSet: TDataSet);
begin
  Dec(IDDocumento);
end;

procedure TDM.cds_documentosBeforeInsert(DataSet: TDataSet);
begin
  cds_documentos.IndexFieldNames:= 'DOC_Cod';
  if cds_documentos.RecordCount > 0 then
    begin
      cds_documentos.Last;
      IDDocumento:= cds_documentosDOC_Cod.AsInteger;
    end;
end;

procedure TDM.cds_documentosNewRecord(DataSet: TDataSet);
begin
  inc(IDDocumento);
  cds_documentosDOC_Cod.AsInteger:= IDDocumento;
end;

procedure TDM.cds_empresaAfterCancel(DataSet: TDataSet);
begin
  Dec(IDEmpresa);
end;

procedure TDM.cds_empresaAfterDelete(DataSet: TDataSet);
begin
  Dec(IDEmpresa);
end;

procedure TDM.cds_empresaBeforeInsert(DataSet: TDataSet);
begin
  cds_empresa.IndexFieldNames:= 'EMP_Cod';
  if cds_empresa.RecordCount > 0 then
    begin
      cds_empresa.Last;
      IDEmpresa:= cds_empresaEMP_Cod.AsInteger;
    end;
end;

procedure TDM.cds_empresaNewRecord(DataSet: TDataSet);
begin
  inc(IDEmpresa);
  cds_empresaEMP_Cod.AsInteger:= IDEmpresa;
end;

procedure TDM.cds_itensProtocoloAfterCancel(DataSet: TDataSet);
begin
  Dec(IDItProtocolo);
end;

procedure TDM.cds_itensProtocoloAfterDelete(DataSet: TDataSet);
begin
  Dec(IDItProtocolo);
end;

procedure TDM.cds_itensProtocoloNewRecord(DataSet: TDataSet);
begin
  inc(IDItProtocolo);
  cds_itensProtocoloITE_Cod.AsInteger:= IDItProtocolo;
end;

procedure TDM.cds_itensProtocoloPostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
  ShowMessage(e.Message);
end;

procedure TDM.cds_pastaAfterCancel(DataSet: TDataSet);
begin
  Dec(IDPasta);
end;

procedure TDM.cds_pastaAfterDelete(DataSet: TDataSet);
begin
  Dec(IDPasta);
end;

procedure TDM.cds_pastaBeforeInsert(DataSet: TDataSet);
begin
  cds_pasta.IndexFieldNames:= 'PST_Cod';
  if cds_pasta.RecordCount > 0 then
    begin
      cds_pasta.Last;
      IDPasta:= cds_pastaPST_Cod.AsInteger;
    end;
end;

procedure TDM.cds_pastaNewRecord(DataSet: TDataSet);
begin
  inc(IDPasta);
  cds_pastaPST_Cod.AsInteger:= IDPasta;
end;

procedure TDM.cds_protocolosAfterCancel(DataSet: TDataSet);
begin
  Dec(IDProtocolo);
end;

procedure TDM.cds_protocolosAfterDelete(DataSet: TDataSet);
begin
  Dec(IDProtocolo);
end;

procedure TDM.cds_protocolosBeforeInsert(DataSet: TDataSet);
begin
  cds_protocolos.IndexFieldNames:= 'PRO_Cod';
  if cds_protocolos.RecordCount > 0 then
    begin
      cds_protocolos.Last;
      IDProtocolo:= cds_protocolosPRO_Cod.AsInteger;
    end;
end;

procedure TDM.cds_protocolosNewRecord(DataSet: TDataSet);
begin
  inc(IDProtocolo);
  cds_protocolosPRO_Cod.AsInteger:= IDProtocolo;
end;

procedure TDM.cds_setorAfterCancel(DataSet: TDataSet);
begin
  Dec(IDSetor);
end;

procedure TDM.cds_setorAfterDelete(DataSet: TDataSet);
begin
  Dec(IDSetor);
end;

procedure TDM.cds_setorBeforeInsert(DataSet: TDataSet);
begin
  cds_setor.IndexFieldNames:= 'SET_Cod';
  if cds_setor.RecordCount > 0 then
    begin
      cds_setor.Last;
      IDSetor:= cds_setorSET_Cod.AsInteger;
    end;
end;

procedure TDM.cds_setorNewRecord(DataSet: TDataSet);
begin
  inc(IDSetor);
  cds_setorSET_Cod.AsInteger:= IDSetor;
end;

procedure TDM.cds_usuariosAfterCancel(DataSet: TDataSet);
begin
  Dec(IDUsuario);
end;

procedure TDM.cds_usuariosAfterDelete(DataSet: TDataSet);
begin
  Dec(IDUsuario);
end;

procedure TDM.cds_usuariosBeforeInsert(DataSet: TDataSet);
begin
  cds_usuarios.IndexFieldNames:= 'USU_Cod';
  if cds_usuarios.RecordCount > 0 then
    begin
      cds_usuarios.Last;
      IDUsuario:= cds_usuariosUSU_Cod.AsInteger;
    end;
end;

procedure TDM.cds_usuariosNewRecord(DataSet: TDataSet);
begin
  inc(IDUsuario);
  cds_usuariosUSU_Cod.AsInteger:= IDUsuario;
end;

procedure TDM.CreateClientDataSet;
var
  i: Integer;
begin
  try
  for I := 0 to Self.ComponentCount - 1 do
    if (Self.Components[i].ClassType = TClientDataSet) then
      TClientDataSet(Self.Components[i]).CreateDataSet;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  CreateClientDataSet;
  CarregaTabelas;
  IDDocumento:= 0;
  IDUsuario:= 0;
  IDItProtocolo:= 0;
  IDSetor:= 0;
  IDCliente:= 0;
  IDEmpresa:= 0;
  IDProtocolo:= 0;
  IDPasta:= 0;
  IDArquivo:= 0;
  IDAgendaCompromisso:= 0;

  cds_documentos.IndexFieldNames:= 'DOC_Cod';
  if cds_documentos.RecordCount > 0 then
    begin
      cds_documentos.Last;
      IDDocumento:= cds_documentosDOC_Cod.AsInteger;
    end;

  cds_usuarios.IndexFieldNames:= 'USU_Cod';
  if cds_usuarios.RecordCount > 0 then
    begin
      cds_usuarios.Last;
      IDUsuario:= cds_usuariosUSU_Cod.AsInteger;
    end;

  cds_setor.IndexFieldNames:= 'SET_Cod';
  if cds_setor.RecordCount > 0 then
    begin
      cds_setor.Last;
      IDSetor:= cds_setorSET_Cod.AsInteger;
    end;

  cds_clientes.IndexFieldNames:= 'CLI_Cod';
  if cds_clientes.RecordCount > 0 then
    begin
      cds_clientes.Last;
      IDCliente:= cds_clientesCLI_Cod.AsInteger;
    end;

  cds_empresa.IndexFieldNames:= 'EMP_Cod';
  if cds_empresa.RecordCount > 0 then
    begin
      cds_empresa.Last;
      IDEmpresa:= cds_empresaEMP_Cod.AsInteger;
    end;

  cds_protocolos.IndexFieldNames:= 'PRO_Cod';
  if cds_protocolos.RecordCount > 0 then
    begin
      cds_protocolos.Last;
      IDProtocolo:= cds_protocolosPRO_Cod.AsInteger;
    end;

  cds_itensProtocolo.IndexFieldNames:= 'ITE_Cod';
  if cds_itensProtocolo.RecordCount > 0 then
    begin
      cds_itensProtocolo.Last;
      IDItProtocolo:= cds_itensProtocoloITE_Cod.AsInteger;
    end;

  cds_pasta.IndexFieldNames:= 'PST_Cod';
  if cds_pasta.RecordCount > 0 then
    begin
      cds_pasta.Last;
      IDPasta:= cds_pastaPST_Cod.AsInteger;
    end;

  cds_arquivo.IndexFieldNames:= 'ARQ_Cod';
  if cds_arquivo.RecordCount > 0 then
    begin
      cds_arquivo.Last;
      IDArquivo:= cds_arquivoARQ_Cod.AsInteger;
    end;

  cds_AgendaCompromisso.IndexFieldNames:= 'AGC_Cod';
  if cds_AgendaCompromisso.RecordCount > 0 then
    begin
      cds_AgendaCompromisso.Last;
      IDAgendaCompromisso:= cds_AgendaCompromissoAGC_Cod.AsInteger;
    end;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  SalvaTabelas;
end;

procedure TDM.SalvaTabelas;
var
  i: Integer;
  nome: string;
begin
  try
    for I := 0 to Self.ComponentCount - 1 do
      if (Self.Components[i].ClassType = TClientDataSet) then
          begin
            nome:= ExtractFileDir(Application.ExeName)+'/'+copy(Self.Components[i].Name, 5,
                                                      length(Self.Components[i].Name))+'.prot';
            TClientDataSet(Self.Components[i]).SaveToFile(nome);
          end;
  except
    on e: Exception do
      MessageDlg(e.Message, mtError, [mbOK], 0);
  end;
end;

end.
