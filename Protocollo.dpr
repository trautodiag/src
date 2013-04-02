program Protocollo;

uses
  Forms,
  Unt_BaseIni in 'Unt_BaseIni.pas' {F_BaseIni},
  Unt_ProtocoloIni in 'Unt_ProtocoloIni.pas' {F_ProtocoloIni},
  Unit_DM in 'Unit_DM.pas' {DM: TDataModule},
  Unt_BaseAnCad in 'Unt_BaseAnCad.pas' {F_BaseAnCad},
  Unt_CadAnDocumentos in 'Unt_CadAnDocumentos.pas' {F_CadAnDocumentos},
  Unt_BaseCad in 'Unt_BaseCad.pas' {F_BaseCad},
  Unt_CadDocumentos in 'Unt_CadDocumentos.pas' {F_CadDocumentos},
  Unt_Util in 'Unt_Util.pas',
  Unt_CadAnUsuarios in 'Unt_CadAnUsuarios.pas' {F_CadAnUsuarios},
  Unt_CadUsuarios in 'Unt_CadUsuarios.pas' {F_CadUsuarios},
  Unt_CadAnSetores in 'Unt_CadAnSetores.pas' {F_CadAnSetores},
  Unt_CadSetores in 'Unt_CadSetores.pas' {F_CadSetores},
  Unt_CadClientes in 'Unt_CadClientes.pas' {F_CadClientes},
  Unt_CadAnClientes in 'Unt_CadAnClientes.pas' {F_CadAnClientes},
  Unt_Sobre in 'Unt_Sobre.pas' {F_Sobre},
  Unt_UpDown in 'Unt_UpDown.pas' {F_UpDown},
  Unt_CadEmpresas in 'Unt_CadEmpresas.pas' {F_CadEmpresas},
  Unt_CadAnEmpresas in 'Unt_CadAnEmpresas.pas' {F_CadAnEmpresas},
  Unt_CadProtocolos in 'Unt_CadProtocolos.pas' {F_CadProtocolos},
  Unt_CadAnProtocolos in 'Unt_CadAnProtocolos.pas' {F_CadAnProtocolos},
  Unt_CadAnArquivo in 'Unt_CadAnArquivo.pas' {F_CadAnArquivo},
  Unt_CadAnAgendaCompromisso in 'Unt_CadAnAgendaCompromisso.pas' {F_CadAnAgendaCompromisso},
  Unt_CadAgendaCompromisso in 'Unt_CadAgendaCompromisso.pas' {F_CadAgendaCompromisso},
  Unt_FuncoesPredefinidas in 'Unt_FuncoesPredefinidas.pas' {F_FuncoesPredefinidas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TF_ProtocoloIni, F_ProtocoloIni);
  Application.Run;
end.
