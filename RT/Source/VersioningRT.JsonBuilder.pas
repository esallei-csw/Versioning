unit VersioningRT.JsonBuilder;

interface

uses
  System.SysUtils, System.JSON;
type
  TJSONBuilder = class
  public
    class function CreateMigrationJSON(const AUser, ADate, AMigrationQuery, ADescription: string): TJSONObject;
  end;
implementation

uses
  VersioningRT.Constants;
{ TJSONBuilder }
class function TJSONBuilder.CreateMigrationJSON(const AUser, ADate, AMigrationQuery, ADescription: string): TJSONObject;
begin
  Result := TJSONObject.Create;
  Result.AddPair(UTENTE, AUser);
  Result.AddPair(DATA, ADate);
  Result.AddPair(MIGRATIONQUERY, AMigrationQuery);
  Result.AddPair(DESCRIZIONE, ADescription);
end;

end.
