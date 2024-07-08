unit VersioningRT.MigrationFileReader;

interface

uses
  System.SysUtils, System.Classes, System.IOUtils, Generics.Collections;
type
  TMigrationFileReader = class
  private
    FDirectory: string;
  public
    constructor Create(const Directory: string);
    function GetOrderedMigrationFiles: TStringList;
  end;
function CompareFileNames(List: TStringList; Index1, Index2: Integer): Integer;
implementation

uses
  VersioningRT.Constants;

function CompareFileNames(List: TStringList; Index1, Index2: Integer): Integer;
begin
  // Confronta i nomi dei file direttamente dato che il formato 'yyyy-mm-dd-hh-nn-ss-zzz' permette il confronto lessicografico
  Result := CompareStr(List[Index1], List[Index2]);
end;
{ TMigrationFileReader }
constructor TMigrationFileReader.Create(const Directory: string);
begin
  inherited Create;
  FDirectory := Directory;
end;

function TMigrationFileReader.GetOrderedMigrationFiles: TStringList;
var
  Files: TStringList;
  FileName: string;
begin
  Files := TStringList.Create;
  try
    // Ottiene tutti i file json dalla directory
    for FileName in TDirectory.GetFiles(FDirectory, JSON_EXTENTION) do
    begin
      Files.Add(FileName);
    end;
    // Ordina i file usando il metodo CustomSort
    Files.CustomSort(@CompareFileNames);
    Result := TStringList.Create;
    Result.AddStrings(Files);
  finally
    Files.Free;
  end;
end;

end.