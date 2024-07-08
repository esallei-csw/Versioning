unit Versioning.WebView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls, SHDocVw, WebView2,
  Winapi.ActiveX, Vcl.Edge, Vcl.ExtCtrls, Vcl.StdCtrls;

type
  TOperationViewType = (ovtLogIn, ovtLogOut);

  TfrmWebViewLogin = class(TForm)
    WebBrowser: TEdgeBrowser;
    procedure FormCreate(Sender: TObject);
    procedure WebBrowserNavigationStarting(Sender: TCustomEdgeBrowser;
      Args: TNavigationStartingEventArgs);
  private
    { Private declarations }
    FOperationType: TOperationViewType;
    FRedirectURI: string;
  public
    { Public declarations }
    procedure LoadURL(const AURL, ARedirectURI: string);
    procedure InjectJavascript;

    property OperationType: TOperationViewType read FOperationType write FOperationType;
  end;

implementation

uses
  LoginSSO.Constants;

{$R *.dfm}

procedure TfrmWebViewLogin.FormCreate(Sender: TObject);
begin
  OperationType := ovtLogIn;
  ModalResult := mrNone;

  WebBrowser.Navigate('about:blank');
end;

procedure TfrmWebViewLogin.LoadURL(const AURL, ARedirectURI: string);
begin
  FRedirectURI := ARedirectURI;
  WebBrowser.Navigate(AURL);
end;

procedure TfrmWebViewLogin.WebBrowserNavigationStarting(Sender: TCustomEdgeBrowser;
  Args: TNavigationStartingEventArgs);
var
  LURL: PChar;
begin
  Args.ArgsInterface.Get_uri(LURL);

  if Pos(FRedirectURI, LURL) > 0 then
    ModalResult := mrOK;

  if Pos(LOGOUT_URL, LURL) > 0 then
    InjectJavascript;
end;

procedure TfrmWebViewLogin.InjectJavaScript;
begin
  WebBrowser.ExecuteScript(JAVASCRIPT);
end;

end.
