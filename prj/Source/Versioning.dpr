program Versioning;

uses
  Vcl.Forms,
  Versioning.Main in 'Versioning.Main.pas' {frmVersioning},
  Versioning.WebView in 'Versioning.WebView.pas' {frmWebViewLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmVersioning, frmVersioning);
  Application.Run;
end.