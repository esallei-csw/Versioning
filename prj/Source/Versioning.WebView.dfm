object frmWebViewLogin: TfrmWebViewLogin
  Left = 0
  Top = 0
  Caption = 'WebViewLogin'
  ClientHeight = 586
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object WebBrowser: TEdgeBrowser
    Left = 0
    Top = 0
    Width = 551
    Height = 586
    Align = alClient
    TabOrder = 0
    OnNavigationStarting = WebBrowserNavigationStarting
  end
end
