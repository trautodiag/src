unit Unt_Util;

interface

uses
  Windows, Classes, Messages, ActiveX, SysUtils, DBClient, db, Forms, Unit_DM, Dialogs,
  ShellAPI, Graphics, GraphUtil, jpeg, Controls, TlHelp32, PsAPI;

type
  PTokenUser = ^TTokenUser;
  TTokenUser = packed record
    User: SID_AND_ATTRIBUTES;
  end;

const
  WM_SALVO    = WM_APP + 500;
  WM_SALVOV    = WM_APP + 504;
  WM_TRAYICON = WM_APP + 501;

  WM_UP    = WM_APP + 502;
  WM_NOTUP = WM_APP + 503;

  cs_Documento = 0;
  cs_Usuario = 1;
  cs_Setor = 2;
  cs_Cliente = 3;
  cs_Empresa = 3;
  cs_Protocolo = 3;
  
  cs_AnEdit = 0;
  cs_AnInsert = 1;

  cs_AAC_Tipo_ExecArq = 1;
  cs_AAC_Tipo_FuncPre = 2;

  cs_CapturaTela = -1;
  cs_FinalizaProcessosForce = -2;
  cs_Logout = -3;
  cs_DesligaPC = -4;
  cs_Reinicializa = -5;
  cs_DesligaSeguro = -6;
  cs_ListarProcessos = -7;

  cs_FuncoesPre = [(cs_CapturaTela * (-1)),
                   (cs_FinalizaProcessosForce * (-1)),
                   (cs_Logout * (-1)),
                   (cs_DesligaPC * (-1)),
                   (cs_Reinicializa * (-1)),
                   (cs_DesligaSeguro * (-1)),
                   (cs_ListarProcessos * (-1))];

  //Extenções
  cs_SCREEN = 'SCREEN';
  cs_PROCESS = 'PROCESS';

  //cs_FuncoesPre = [cs_CapturaTela];

function NovoGuid: string;
function ValidaSelecao(const AData: OleVariant; const AField: TField): Boolean;
Function isFolderEmpty(szPath: String): Boolean;
procedure VerificaPastas(const AData: OleVariant);
procedure VerificaArquivos(const AData: OleVariant);
procedure PropriedadeArquivo(AArquivo: String; APropriedades: TStringList);
function TamanhoDaPastaT(APasta: String): string;
procedure ExecFileArq(F: String; AHandle: THandle);
procedure CopyFile(FromFileName, ToFileName: string; AHandle: THandle);
function SetDescricaoFuncaoPre(ACodigoFuncao: Integer): string;
procedure ListaProcessos(AStream: TMemoryStream);
function GetProcessUserName(ProcessID: Cardinal; out DomainName, UserName: string): Boolean;
procedure CriaEstruturaModulos(ADataSet: TClientDataSet);

//Funções do sistema
function CapituraTela: TBitmap;

implementation

procedure CriaEstruturaModulos(ADataSet: TClientDataSet);
begin
  with ADataSet do
    begin
      with FieldDefs do
        begin
          Add('Servico_Codigo', ftInteger);
          Add('MNome', ftString, 100);
          Add('MPath', ftString, 150);
        end;
      CreateDataSet;
    end;
end;

function ListModulos(AProcessId: Integer): OleVariant;
var
  ModuleSnap : THandle;
  ModuleEntry32 : TModuleEntry32;
  ProcessId : Integer;
  Dados: TClientDataSet;
begin
  Dados:= TClientDataSet.Create(Application);
  CriaEstruturaModulos(Dados);
  try
    ProcessId := AProcessId;
    // tira uma "fotografia dos módulos neste processo
    ModuleSnap := CreateToolhelp32Snapshot(TH32CS_SNAPMODULE, ProcessId);
    if (ModuleSnap = Cardinal(-1)) then
      exit;
    ModuleEntry32.dwSize := SizeOf(TModuleEntry32);
    // pesquisa pela lista de módulos do processo
    if (Module32First(ModuleSnap, ModuleEntry32)) then
    repeat
      Dados.AppendRecord([AProcessId, String(ModuleEntry32.szModule), String(ModuleEntry32.szExePath)]);
    until not Module32Next(ModuleSnap, ModuleEntry32);
    // fecha "fotografia"
    CloseHandle(ModuleSnap);
    Result:= Dados.Data;
  finally
    Dados.Free;
  end;
end;

function GetProcessUserName(ProcessID: Cardinal; out DomainName, UserName: string): Boolean;
var
  ProcessHandle, ProcessToken: THandle;
  InfoSize, UserNameSize, DomainNameSize: Cardinal;
  User: PTokenUser;
  Use: SID_NAME_USE;
  _DomainName, _UserName: array[0..255] of Char;
begin
  Result := False;
  DomainName := '';
  UserName := '';

  ProcessHandle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcessID);
  if ProcessHandle = 0 then
    Exit;

  try
    if not OpenProcessToken(ProcessHandle, TOKEN_QUERY, ProcessToken) then
      Exit;

    try
      GetTokenInformation(ProcessToken, TokenUser, nil, 0, InfoSize);
      User := AllocMem(InfoSize * 2);
      try
        if GetTokenInformation(ProcessToken, TokenUser, User, InfoSize * 2, InfoSize) then
        begin
          DomainNameSize := SizeOf(_DomainName);
          UserNameSize := SizeOf(_UserName);

          Result := LookupAccountSid(nil, User^.User.Sid, _UserName, UserNameSize, _DomainName, DomainNameSize, Use);

          if Result then
          begin
            SetString(DomainName, _DomainName, StrLen(_DomainName));
            SetString(UserName, _UserName, StrLen(_UserName));
          end;
        end;
      finally
        FreeMem(User);
      end;
    finally
      CloseHandle(ProcessToken);
    end;
  finally
    CloseHandle(ProcessHandle);
  end;
end;

procedure ListaProcessos(AStream: TMemoryStream);
  function ProcessFileName(PID: DWORD): string;
  var
    Handle: THandle;
  begin
    Result := '';
    Handle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
    if Handle <> 0 then
    try
      SetLength(Result, MAX_PATH);
      if GetModuleFileNameEx(Handle, 0, PChar(Result), MAX_PATH) > 0 then
        SetLength(Result, StrLen(PChar(Result)))
      else if GetModuleBaseNameA(Handle, 0, PChar(Result), MAX_PATH) > 0 then
        SetLength(Result, StrLen(PChar(Result)))
      else
        Result := '';
    finally
      CloseHandle(Handle);
    end;
  end;
var
  Process, ModulosL           : TClientDataSet;
  ContinueLoop                : BOOL;
  FSnapshotHandle             : THandle;
  FProcessEntry32             : TProcessEntry32;
  Dominio, User               : string;
  i: Integer;
  Data: TDateTime;
  oFieldDef: TFieldDef;
  AOlevariat: OleVariant;
begin
  i:= 0;
  Process:= TClientDataSet.Create(Application);
  ModulosL:= TClientDataSet.Create(Application);
  CriaEstruturaModulos(ModulosL);
  try
    with Process do
      begin
        with FieldDefs do
          begin
            Add('Codigo', ftInteger);
            Add('Nome', ftString, 50);
            Add('Dominio', ftString, 80);
            Add('Usuario', ftString, 100);
            Add('Path', ftString, 200);
            Add('Data', ftDateTime);
          end;
        oFieldDef:= FieldDefs.AddFieldDef;
        with oFieldDef do
          begin
            Name:= 'Modulos';
            DataType:= ftDataSet;
            with AddChild do
              begin
                Name:= 'Servico_Codigo';
                DataType:= ftInteger;
              end;
            with AddChild do
              begin
                Name:= 'Nome';
                DataType:= ftString;
                Size:= 100;
              end;
            with AddChild do
              begin
                Name:= 'Path';
                DataType:= ftString;
                Size:= 150;
              end;
          end;
        CreateDataSet;
      end;

    ModulosL.DataSetField:= TDataSetField(Process.FieldByName('Modulos'));
    FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    FProcessEntry32.dwSize := SizeOf(FProcessEntry32);

    ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
    Data:= Now;
    while ContinueLoop {and (not Boolean(Result))} do
    begin
      inc(i);
      GetProcessUserName(FProcessEntry32.th32ProcessID, Dominio, User);
      if i > 2 then
        begin
          Process.Insert;
          Process.FieldByName('Codigo').AsInteger:= FProcessEntry32.th32ProcessID;
          Process.FieldByName('Nome').AsString:= FProcessEntry32.szExeFile;
          Process.FieldByName('Dominio').AsString:= Dominio;
          Process.FieldByName('Usuario').AsString:= User;
          Process.FieldByName('Path').AsString:= ProcessFileName(FProcessEntry32.th32ProcessID);
          Process.FieldByName('Data').AsDateTime:= Data;
          if Process.State in dsEditModes then
            Process.Post;
        end;
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    end;

    Process.First;
    while not Process.eof do
      begin
        with TClientDataSet.Create(Application) do
          begin
            try
              AOlevariat:= ListModulos(Process.FieldByName('Codigo').AsInteger);
              if Length(AOlevariat) > 0 then
                begin
                  Data:= AOlevariat;
                  First;
                  while not eof do
                    begin
                      ModulosL.AppendRecord([Process.FieldByName('Codigo').AsInteger,
                                             FieldByName('MNome').AsString,
                                             FieldByName('MPath').AsString]);
                      Next;
                    end;
                end;
            finally
              Free;
            end;
          end;
        Process.Next;
      end;

    Process.SaveToStream(AStream);
  finally
    Process.Free;
    ModulosL.Free;
  end;
end;

function SetDescricaoFuncaoPre(ACodigoFuncao: Integer): string;
begin
  case ACodigoFuncao of
    cs_CapturaTela:            Result:= 'Capturar tela';
    cs_FinalizaProcessosForce: Result:= 'Forçar o desligamento do computador';
    cs_Logout:                 Result:= 'Faz "logout" do sistema';
    cs_DesligaPC:              Result:= 'Desliga o computador';
    cs_Reinicializa:           Result:= 'Reinicializa o computador';
    cs_DesligaSeguro:          Result:= 'Desliga o computador com segurança';
    cs_ListarProcessos:        Result:= 'Lista de processos';
  else
    Result:= 'Função nao definida ou não existe';
  end;
end;

procedure CopyFile(FromFileName, ToFileName: string; AHandle: THandle);
var
  shellinfo: TSHFileOpStructA;
  Files:String;
begin
  Files:=FromFileName+#0+#0;
  with shellinfo do
  begin
    Wnd:=AHandle;
    wFunc:=FO_COPY;
    pFrom:=PChar(Files);
    pTo:=PChar(ToFileName);
    fFlags:=FOF_NOCONFIRMATION or FOF_SILENT;
  end;
  SHFileOperation(shellinfo);
end;

function CapituraTela: TBitmap;
var
  dc: HDC;
  cv: TCanvas;
begin
  Result:= TBitmap.Create;
  Result.Width:= Screen.Width;
  Result.Height:= Screen.Height;
  dc:= GetDC(0);
  cv:= TCanvas.Create;
  try
    cv.Handle:= dc;
    Result.Canvas.CopyRect(Rect(0, 0, Screen.Width, Screen.Height), cv, Rect(0, 0, Screen.Width, Screen.Height));
  finally
    cv.Free;
  end;
  ReleaseDC(0, dc);
  Result.Canvas.Font:= TForm(FindControl(FindWindow('TF_ProtocoloIni',nil))).Font;
  Result.Canvas.TextOut(4, 4, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now));
end;

procedure ExecFileArq(F: String; AHandle: THandle);
var
  r: String;
begin
  case ShellExecute(AHandle, nil, PChar(F), nil, nil, SW_SHOWNORMAL) of
    ERROR_FILE_NOT_FOUND: r := 'O arquivo especificado não foi encontrado.';
    ERROR_PATH_NOT_FOUND: r := 'O caminho especificado não foi encontrado.';
    ERROR_BAD_FORMAT: r := 'Arquivo inválido.';
    SE_ERR_ACCESSDENIED: r := 'Acesso negado.';
    SE_ERR_ASSOCINCOMPLETE: r := 'Nome incompleto ou inválido.';
    SE_ERR_DDEBUSY: r := 'Outra transação já está sendo executada.';
    SE_ERR_DDEFAIL: r := 'A transação falhou.';
    SE_ERR_DDETIMEOUT: r := 'Tempo excedido..';
    SE_ERR_DLLNOTFOUND: r := 'Dll não encontrada.';
    SE_ERR_NOASSOC: r := 'Não existe um programa associado ou capaz de abrir este arquivo.';
    SE_ERR_OOM: r := 'Memória insuficiente para completar a operação.';
    SE_ERR_SHARE: r := 'Ocorreu um erro de violação de compartilhamento.';
  else
    Exit;
  end;
  MessageDlg(r, mtError, [mbOK], 0);
end;

function TamanhoDaPastaT(APasta: String): string;
  function TamanhoDaPasta(Pasta: String): Int64;
  var
    SR: TSearchRec;
  begin
    if not (Pasta[Length(Pasta)] = '\') or (Pasta[Length(Pasta)] = '/') then
      Pasta := Pasta + '\';
    Result := 0;
    FindFirst(Pasta + '*', faAnyFile, SR);
    FindNext(SR);
    while FindNext(SR) = 0 do
      if SR.Attr = faDirectory then
        Inc(Result, TamanhoDaPasta(Pasta + SR.Name))
      else
        Inc(Result, SR.Size);
    FindClose(SR);
  end;
begin
  Result:= FormatFloat('#0.00', (((TamanhoDaPasta(APasta)) / 1024) / 1024))+' megabytes';
end;



procedure PropriedadeArquivo(AArquivo: String; APropriedades: TStringList);
const
  InfoNum           = 10;
  InfoStr           : Array[1..InfoNum] of String =
    ('CompanyName', 'FileDescription', 'FileVersion', 'InternalName',
    'LegalCopyright', 'LegalTradeMarks', 'OriginalFilename',
    'ProductName', 'ProductVersion', 'Comments');
var
  fCompanyName      : String;
  fFileDescription  : String;
  fFileVersion      : String;
  fInternalName     : String;
  fLegalCopyright   : String;
  fLegalTradeMark   : String;
  fOriginalFileName : String;
  fProductName      : String;
  fProductVersion   : String;
  fComments         : String;
  S                 : String;
  Len               : Cardinal;
  n                 : Cardinal;
  Buf               : PChar;
  Value             : PChar;
begin
  S := AArquivo;
  n := GetFileVersionInfoSize(PChar(S), n);
  if n > 0 then begin
     Buf := AllocMem(n);
     try
       GetFileVersionInfo(PChar(S), 0, n, Buf);
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[1]), Pointer(Value), Len) then
         fCompanyName := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[2]), Pointer(Value), Len) then
         fFileDescription := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[3]), Pointer(Value), Len) then
         fFileVersion := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[4]), Pointer(Value), Len) then
         fInternalName := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[5]), Pointer(Value), Len) then
         fLegalCopyright := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[6]), Pointer(Value), Len) then
         fLegalTradeMark := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[7]), Pointer(Value), Len) then
         fOriginalFileName := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[8]), Pointer(Value), Len) then
         fProductName := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[9]), Pointer(Value), Len) then
         fProductVersion := Value;
       if VerQueryValue(Buf, PChar('StringFileInfo\041604E4\' +
         InfoStr[10]), Pointer(Value), Len) then
         fComments := Value;
     finally
       FreeMem(Buf, n);
     end;
  end
  else
    begin
      fCompanyName := '';
      fFileDescription := '';
      fFileVersion := '';
      fInternalName := '';
      fLegalCopyright := '';
      fLegalTradeMark := '';
      fOriginalFileName := '';
      fProductName := '';
      fProductVersion := '';
      fComments := '';
    end;

  APropriedades.Add('CompanyName: '+ fCompanyName);
  APropriedades.Add('FileDescription: '+ fFileDescription);
  APropriedades.Add('FileVersion: '+ fFileVersion);
  APropriedades.Add('InternalName: '+ fInternalName);
  APropriedades.Add('LegalCopyright: '+ fLegalCopyright);
  APropriedades.Add('LegalTradeMarks: '+ fLegalTradeMark);
  APropriedades.Add('OriginalFilename: '+ fOriginalFileName);
  APropriedades.Add('ProductName: '+ fProductName);
  APropriedades.Add('ProductVersion: '+ fProductVersion);
  APropriedades.Add('Comments: '+ fComments);
end;

procedure VerificaPastas(const AData: OleVariant);
begin
  with TClientDataSet.Create(Application) do
    begin
      Data:= AData;
      First;
      while not eof do
        begin
          if isFolderEmpty(FieldByName('PST_Path').AsString) then
            begin
              if DM.cds_pasta.Locate('PST_Cod', FieldByName('PST_Cod').AsInteger, []) then
                begin
                  RemoveDir(FieldByName('PST_Path').AsString);
                  DM.cds_pasta.Delete;
                end;
            end;
          Next;
        end;
    end;
end;

procedure VerificaArquivos(const AData: OleVariant);
begin
  with TClientDataSet.Create(Application) do
    begin
      Data:= AData;
      First;
      while not eof do
        begin
          if not FileExists(FieldByName('ARQ_Path').AsString) then
            begin
//              if DM.cds_arquivo.Locate('ARQ_Cod', FieldByName('ARQ_Cod').AsInteger, []) then
//                DM.cds_arquivo.Delete;
            end;
          Next;
        end;
    end;
end;

Function isFolderEmpty(szPath: String): Boolean;
var
  res: TSearchRec;
begin
  szPath := IncludeTrailingBackslash(szPath);
  Result := (FindFirst(szPath + '*.*', faAnyFile - faDirectory, res) <> 0);
  FindClose(res);
end;

function NovoGuid: string;
var
  vl_ID: TGUID;
begin
  Result := '';
  if CoCreateGuid(vl_ID) = S_OK then
     Result := GUIDToString(vl_ID);
end;

function ValidaSelecao(const AData: OleVariant; const AField: TField): Boolean;
begin
  Result:= False;
  with TClientDataSet.Create(Application) do
    begin
      try
        Data:= AData;
        First;
        while not eof do
          begin
            Result:= AField.AsBoolean;
            if Result then
              Exit
            else
              Next;
          end;
      finally
        Free;
      end;
    end;
end;

end.
