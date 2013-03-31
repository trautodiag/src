unit Unt_Util;

interface

uses
  Windows, Classes, Messages, ActiveX, SysUtils, DBClient, db, Forms, Unit_DM, Dialogs,
  ShellAPI;

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

function NovoGuid: string;
function ValidaSelecao(const AData: OleVariant; const AField: TField): Boolean;
Function isFolderEmpty(szPath: String): Boolean;
procedure VerificaPastas(const AData: OleVariant);
procedure VerificaArquivos(const AData: OleVariant);
procedure PropriedadeArquivo(AArquivo: String; APropriedades: TStringList);
function TamanhoDaPastaT(APasta: String): string;
procedure ExecFileArq(F: String; AHandle: THandle);

implementation

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
