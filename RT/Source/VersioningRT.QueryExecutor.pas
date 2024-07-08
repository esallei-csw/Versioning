unit VersioningRT.QueryExecutor;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.Intf, FireDAC.Phys, FireDAC.Phys.ODBCBase, FireDAC.Phys.MSSQL, FireDAC.VCLUI.Wait, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.Stan.Option, Data.DB;
type
  TQueryExecutor = class
  private
    FConnection: TFDConnection;
    procedure SetupConnection(ADataBaseName, AServerName, AUserName, APassword: string);
  public
    constructor Create(ADataBaseName, AServerName, AUserName, APassword: string);
    destructor Destroy; override;
    procedure ExecuteQuery(AQuery: string);
  end;
implementation

uses
  VersioningRT.Constants, VersioningRT.Messages;
{ TQueryExecutor }
constructor TQueryExecutor.Create(ADataBaseName, AServerName, AUserName, APassword: string);
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  SetupConnection(ADataBaseName, AServerName, AUserName, APassword);
end;
destructor TQueryExecutor.Destroy;
begin
  FConnection.Free;
  inherited Destroy;
end;
procedure TQueryExecutor.SetupConnection(ADataBaseName, AServerName, AUserName, APassword: string);
begin
  // Configurazione della connessione al database
  FConnection.DriverName := DRIVER_NAME; // Cambiare con il driver appropriato
  FConnection.Params.Database := ADataBaseName;
  FConnection.Params.UserName := AUserName;
  FConnection.Params.Password := APassword;
  FConnection.Params.Add(SERVER + AServerName); // Specificare il server
  FConnection.LoginPrompt := False;
  try
    FConnection.Connected := True;
  except
    on E: Exception do
      raise Exception.Create(DATABASE_CONNECTION_ERROR + E.Message);
  end;
end;
procedure TQueryExecutor.ExecuteQuery(AQuery: string);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := AQuery;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;
end.
