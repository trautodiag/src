unit Arquivos; 

interface

uses

Windows, Dialogs, Messages, SysUtils, Classes, Controls, StdCtrls,FileCtrl,
Graphics, shellapi, Printers;

function fileSize(const FileName: String): LongInt;
function GetFileDate(TheFileName: string): string;
function FileDate(Arquivo: String): String;
function FillDir(Const AMask: string): TStringList;
function WinExecAndWait32(FileName:String; Visibility : integer):integer;
function FileCopy(source,dest: String): Boolean;
function FileTypeName(const aFile: String): String;
Procedure ZapFiles(vMasc:String);
procedure ListFileDir(Path: string; FileList: TStrings);
procedure Comprimir(ArquivoCompacto: TFileName; Arquivos: array of TFileName);
procedure Descomprimir(ArquivoZip: TFileName; DiretorioDestino: string);

implementation

procedure Comprimir(ArquivoCompacto: TFileName; Arquivos: array of TFileName);
var
  FileInName: TFileName;
  FileEntrada, FileSaida: TFileStream;
  Compressor: TCompressionStream;
  NumArq, I, Len, Size: Integer;
  Fim: Byte;
begin
  FileSaida := TFileStream.Create(ArquivoCompacto, fmCreate or fmShareExclusive);
  Compressor := TCompressionStream.Create(clMax, FileSaida);
  NumArq := Length(Arquivos);
  Compressor.Write(NumArq, SizeOf(Integer));
  try
    for I := Low(Arquivos) to High(Arquivos) do begin
      FileEntrada := TFileStream.Create(Arquivos[I], fmOpenRead and fmShareExclusive);
      try
        FileInName := ExtractFileName(Arquivos[I]);
        Len := Length(FileInName);
        Compressor.Write(Len, SizeOf(Integer));
        Compressor.Write(FileInName[1], Len);
        Size := FileEntrada.Size;
        Compressor.Write(Size, SizeOf(Integer));
        Compressor.CopyFrom(FileEntrada, FileEntrada.Size);
        Fim := 0;
        Compressor.Write(Fim, SizeOf(Byte));
      finally
        FileEntrada.Free;
      end;
    end;
  finally
    FreeAndNil(Compressor);
    FreeAndNil(FileSaida);
  end;
end;

procedure Descomprimir(ArquivoZip: TFileName; DiretorioDestino: string);
var
  NomeSaida: string;
  FileEntrada, FileOut: TFileStream;
  Descompressor: TDecompressionStream;
  NumArq, I, Len, Size: Integer;
  Fim: Byte;
begin
  FileEntrada := TFileStream.Create(ArquivoZip, fmOpenRead and fmShareExclusive);
  Descompressor := TDecompressionStream.Create(FileEntrada);
  Descompressor.Read(NumArq, SizeOf(Integer));
  try
    I := 0;
    while I < NumArq do begin
      Descompressor.Read(Len, SizeOf(Integer));
      SetLength(NomeSaida, Len);
      Descompressor.Read(NomeSaida[1], Len);
      Descompressor.Read(Size, SizeOf(Integer));
      FileOut := TFileStream.Create(
        IncludeTrailingBackslash(DiretorioDestino) + NomeSaida, 
        fmCreate or fmShareExclusive);
      try
        FileOut.CopyFrom(Descompressor, Size);
      finally
        FileOut.Free;
      end;
      Descompressor.Read(Fim, SizeOf(Byte));
      Inc(I);
    end;
  finally
    FreeAndNil(Descompressor);
    FreeAndNil(FileEntrada);
  end;
end;

//Um exemplo de uso, seria:
//var
//  //vetor para guardar os nomes dos arquivos a ser compactados
//  ListaArquivos: Array of TFileName;
//begin
//  //define o tamanho do vetor (qtde. de arquivos)
//  SetLength(ListaArquivos, 2);
//  //preenche a lista com os arquivos
//  ListaArquivos[0] := 'C:\Windows\Bruma.bmp';
//  ListaArquivos[1] := 'C:\Windows\Cafezinho.bmp';
//  //executa a compactação, gerando o arquivo C:\Compactado.xxx
//  Comprimir('C:\Compactado.xxx', ListaArquivos);
//  //cria um diretório de teste para descompactarmos
//  MkDir('C:\Descompactado');
//  //executa a descompactação no diretório criado
//  Descomprimir('C:\Compactado.xxx', 'C:\Descompactado');
//end;

procedure ListFileDir(Path: string; FileList: TStrings);
var
  SR: TSearchRec;
begin
  if FindFirst(Path + '*.*', faAnyFile, SR) = 0 then
  begin
    repeat
      if (SR.Attr <> faDirectory) then
      begin
        FileList.Add(SR.Name);
      end;
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

function fileSize(const FileName: String): LongInt;
{Retorna o tamanho de um arquivo}
var
 SearchRec : TSearchRec;
begin { !Win32! -> GetFileSize }
  if FindFirst(FileName,faAnyFile,SearchRec)=0 then
    Result:=SearchRec.Size
  else Result:=0;
  FindClose(SearchRec);
end;

function GetFileDate(TheFileName: string): string;
var
  FHandle: integer;
begin
  FHandle := FileOpen(TheFileName, 0);
  result := DateToStr((FileDateToDateTime(FileGetDate(FHandle))));
  FileClose(FHandle);
end;

function FileDate(Arquivo: String): String;
{Retorna a data e a hora de um arquivo}
var
  FHandle: integer;
begin
  if not fileexists(Arquivo) then
    begin
      Result := 'Nome de Arquivo Inválido';
    end
  else
    begin
      FHandle := FileOpen(Arquivo, 0);
      try
        Result := DateTimeToStr(FileDateToDateTime(FileGetDate(FHandle)));
      finally
        FileClose(FHandle);
      end;
    end;
end;

Procedure ZapFiles(vMasc:String);
{Apaga arquivos usando mascaras tipo: *.zip, *.* }
Var
  Dir : TsearchRec;
  Erro: Integer;
Begin
  Erro := FindFirst(vMasc,faArchive,Dir);
  While Erro = 0 do Begin
    DeleteFile( ExtractFilePAth(vMasc)+Dir.Name );
    Erro := FindNext(Dir);
  End;
  FindClose(Dir);
End;

function FillDir(Const AMask: string): TStringList;
{Retorna uma TStringlist de todos os arquivos localizados
no path corrente , Esta função trabalha com mascaras}
var
  SearchRec : TSearchRec;
  intControl : integer;
begin
  Result := TStringList.create;
  intControl := FindFirst( AMask, faAnyFile, SearchRec );
  if intControl = 0 then
    begin
      while (intControl = 0) do
      begin
        Result.Add( SearchRec.Name );
        intControl := FindNext( SearchRec );
      end;
      FindClose( SearchRec );
    end;
end;

function WinExecAndWait32(FileName: string; Visibility: Integer): Longword;
var { by Pat Ritchey }
  zAppName: array[0..512] of Char;
  zCurDir: array[0..255] of Char;
  WorkDir: string;
  StartupInfo: TStartupInfo;
  ProcessInfo: TProcessInformation;
begin
  StrPCopy(zAppName, FileName);
  GetDir(0, WorkDir);
  StrPCopy(zCurDir, WorkDir);
  FillChar(StartupInfo, SizeOf(StartupInfo), #0);
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESHOWWINDOW;
  StartupInfo.wShowWindow := Visibility;
  if not CreateProcess(nil,
    zAppName, // pointer to command line string
    nil, // pointer to process security attributes
    nil, // pointer to thread security attributes
    False, // handle inheritance flag
    CREATE_NEW_CONSOLE or // creation flags
    NORMAL_PRIORITY_CLASS,
    nil, //pointer to new environment block
    nil, // pointer to current directory name
    StartupInfo, // pointer to STARTUPINFO
    ProcessInfo) // pointer to PROCESS_INF
    then Result := WAIT_FAILED
  else
  begin
    WaitForSingleObject(ProcessInfo.hProcess, INFINITE);
    GetExitCodeProcess(ProcessInfo.hProcess, Result);
    CloseHandle(ProcessInfo.hProcess);
    CloseHandle(ProcessInfo.hThread);
  end;
end;

function FileCopy(source,dest: String): Boolean;
{copia um arquivo de um lugar para outro. Retornando falso em caso de erro}
var
  fSrc,fDst,len: Integer;
  size: Longint;
  buffer: packed array [0..2047] of Byte;
begin
  if source <> dest then
    begin
      fSrc := FileOpen(source,fmOpenRead);
      if fSrc >= 0 then
      begin
        size := FileSeek(fSrc,0,2);
        FileSeek(fSrc,0,0);
        fDst := FileCreate(dest);
        if fDst >= 0 then
          begin
            while size > 0 do
              begin
                len := FileRead(fSrc,buffer,sizeof(buffer));
                FileWrite(fDst,buffer,len);
                size := size - len;
              end;
            FileSetDate(fDst,FileGetDate(fSrc));
            FileClose(fDst);
            FileSetAttr(dest,FileGetAttr(source));
            Result := True;
          end
        else
          begin
            Result := False;
          end;
        FileClose(fSrc);
      end;
    end;
end;

function FileTypeName(const aFile: String): String;
{Retorna descrição do tipo do arquivo. Requer a unit ShellApi}
var
  aInfo: TSHFileInfo;
begin
  if SHGetFileInfo(PChar(aFile),0,aInfo,Sizeof(aInfo),SHGFI_TYPENAME)<>0 then
    Result := StrPas(aInfo.szTypeName)
  else
    begin
      Result := ExtractFileExt(aFile);
      Delete(Result,1,1);
      Result := Result +' Arquivo';
    end;
end;

end.


