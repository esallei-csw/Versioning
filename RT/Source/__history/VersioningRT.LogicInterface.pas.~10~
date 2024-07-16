unit VersioningRT.LogicInterface;

interface

uses
  System.JSON, Classes;

type
  IDatabaseVersioning = interface
    ['{B5B7A05E-1DCE-4F5E-9C2C-3A58F9B63EFA}']
    procedure AddMigration(AUser, AMigrationQuery, ADescription: string);
    procedure ExecuteMigrations;
    function GetMigrations: TStringList;
end;

implementation

end.
