unit Versioning.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Versioning.WebView, LoginSSO.User.Information, LoginSSO.Logic, VersioningRT.LogicInterface, VersioningRT.Logic;

type
  TfrmVersioning = class(TForm)
    btnLogin: TButton;
    btnLogout: TButton;
    lblUser: TLabel;
    lblUserName: TLabel;
    btnAddMigration: TButton;
    btnExecuteMigrations: TButton;
    memMigrationQuery: TMemo;
    memDescription: TMemo;
    lblMigrationQuery: TLabel;
    lblDescription: TLabel;
    lblMigrationResult: TLabel;
    lblExecuteResult: TLabel;
    lbMigrationList: TListBox;
    lblMigrationList: TLabel;
    procedure btnLoginClick(Sender: TObject);
    procedure btnLogoutClick(Sender: TObject);
    procedure btnAddMigrationClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExecuteMigrationsClick(Sender: TObject);
  private
    { Private declarations }
    FSSO: TMicrosoftSSO;
    FUserInfo: TSSOUserInformationModel;
    FWebForm: TfrmWebViewLogin;
    FDataBaseVersioning: IDatabaseVersioning;


    procedure ViewGoToWindow(AUrl: string);

    function GetWebForm: TfrmWebViewLogin;
    property WebForm: TfrmWebViewLogin read GetWebForm write FWebForm;

    function GetSSO: TMicrosoftSSO;
    property SSO: TMicrosoftSSO read GetSSO write FSSO;

    function GetUserInfo: TSSOUserInformationModel;
    property UserInfo: TSSOUserInformationModel read GetUserInfo write FUserInfo;

    function GetDataBaseVersioning: IDatabaseVersioning;
    property DataBaseVersioning: IDatabaseVersioning read GetDataBaseVersioning write FDataBaseVersioning;


    procedure LogIn(AProc: TGoToAccessURL);
    procedure LogOut(AProc: TGoToAccessURL);
  public
    { Public declarations }
  end;

var
  frmVersioning: TfrmVersioning;

implementation

uses
  LoginSSO.Constants, LoginSSO.Messages, VersioningRT.Constants, VersioningRT.Messages;

{$R *.dfm}

procedure TfrmVersioning.FormCreate(Sender: TObject);
begin
  FSSO := nil;
  FUserInfo := nil;
  FDataBaseVersioning := nil;
  FWebForm := nil;

  lbMigrationList.Items := DataBaseVersioning.GetMigrations;
end;

procedure TfrmVersioning.FormDestroy(Sender: TObject);
begin
  if Assigned(FSSO) then
    FSSO.Free;
  if Assigned(FUserInfo) then
    FUserInfo.Free;
  if Assigned(FWebForm) then
    FWebForm.Free;
end;

procedure TfrmVersioning.btnAddMigrationClick(Sender: TObject);
begin
  if not SSO.LoggedIn then
  begin
    ShowMessage(NOT_LOGGED);
    exit;
  end;
  if (memMigrationQuery.Text = EmptyStr) or (memDescription.Text = EmptyStr) then
  begin
    ShowMessage(EMPTY_PARAMS);
    exit;
  end;
  try
    DataBaseVersioning.AddMigration(UserInfo.DisplayName, memMigrationQuery.Text, memDescription.Text);
    lblMigrationResult.Caption := MIGRATION_CREATED;
    lbMigrationList.Items := DataBaseVersioning.GetMigrations;
  except
    lblMigrationResult.Caption := MIGRATION_FAILED;
  end;

end;

procedure TfrmVersioning.btnExecuteMigrationsClick(Sender: TObject);
begin
  if not SSO.LoggedIn then
  begin
    ShowMessage(NOT_LOGGED);
    exit;
  end;

  try
    DataBaseVersioning.ExecuteMigrations;
    lblExecuteResult.Caption := MIGRATION_EXECUTION_SUCCESS;
  except
    lblExecuteResult.Caption := MIGRATION_EXECUTION_FAILED;
  end;
end;

procedure TfrmVersioning.btnLoginClick(Sender: TObject);
begin
    LogIn(ViewGoToWindow);
end;

procedure TfrmVersioning.btnLogoutClick(Sender: TObject);
begin
  LogOut(ViewGoToWindow);
end;

function TfrmVersioning.GetDataBaseVersioning: IDatabaseVersioning;
begin
  if not Assigned(FDataBaseVersioning) then
    FDataBaseVersioning := TDatabaseVersioning.Create;
  Result := FDataBaseVersioning;
end;

function TfrmVersioning.GetSSO: TMicrosoftSSO;
begin
  if not Assigned(FSSO) then
    FSSO := TMicrosoftSSO.Create(DEFAULT_CLIENTID, DEFAULT_TENANTID);
  Result := FSSO;
end;

function TfrmVersioning.GetUserInfo: TSSOUserInformationModel;
begin
  if not assigned(FUserInfo) then
    FUserInfo := TSSOUserInformationModel.Create;
  Result := FUserInfo;
end;

function TfrmVersioning.GetWebForm: TfrmWebViewLogin;
begin
  if not Assigned(FWebForm) then
    FWebForm := TfrmWebViewLogin.Create(nil);
  Result := FWebForm;
end;

procedure TfrmVersioning.LogIn(AProc: TGoToAccessURL);
begin

  SSO.GoToAccessURL := AProc;
  UserInfo := SSO.LogIn;
  if ( not Assigned(UserInfo) ) then
    Exit;

  lblUserName.Caption := UserInfo.DisplayName;

end;


procedure TfrmVersioning.LogOut(AProc: TGoToAccessURL);
begin
  SSO.GoToAccessURL := AProc;
  SSO.LogOut;

  lblUserName.Caption := EmptyStr;
end;

procedure TfrmVersioning.ViewGoToWindow(AUrl: string);
begin
  WebForm.LoadURL(AUrl, SSO.GetRedirectURI);
  if AUrl.contains(LOGOUT_URL) then
    WebForm.OperationType := ovtLogOut
  else
    WebForm.OperationType := ovtLogIn;

  if ( WebForm.ShowModal <> mrOK ) then
    raise Exception.Create(LOGIN_CANCEL);

end;

end.
