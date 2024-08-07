object frmVersioning: TfrmVersioning
  Left = 0
  Top = 0
  Caption = 'Versioning Application'
  ClientHeight = 342
  ClientWidth = 799
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblUser: TLabel
    Left = 248
    Top = 8
    Width = 22
    Height = 13
    Caption = 'User'
  end
  object lblUserName: TLabel
    Left = 288
    Top = 8
    Width = 68
    Height = 13
    Caption = 'Not Logged In'
  end
  object lblMigrationQuery: TLabel
    Left = 16
    Top = 44
    Width = 77
    Height = 13
    Caption = 'Migration Query'
  end
  object lblDescription: TLabel
    Left = 16
    Top = 154
    Width = 53
    Height = 13
    Caption = 'Description'
  end
  object lblMigrationResult: TLabel
    Left = 16
    Top = 261
    Width = 77
    Height = 13
    Caption = 'Migration Result'
  end
  object lblExecuteResult: TLabel
    Left = 189
    Top = 260
    Width = 72
    Height = 13
    Caption = 'Execute Result'
  end
  object lblMigrationList: TLabel
    Left = 399
    Top = 37
    Width = 63
    Height = 13
    Caption = 'Migration List'
  end
  object btnLogin: TButton
    Left = 240
    Top = 32
    Width = 65
    Height = 25
    Caption = 'Login'
    TabOrder = 0
    OnClick = btnLoginClick
  end
  object btnLogout: TButton
    Left = 311
    Top = 32
    Width = 64
    Height = 25
    Caption = 'Logout'
    TabOrder = 1
    OnClick = btnLogoutClick
  end
  object btnAddMigration: TButton
    Left = 8
    Top = 279
    Width = 105
    Height = 41
    Caption = 'Add Migration'
    TabOrder = 2
    OnClick = btnAddMigrationClick
  end
  object btnExecuteMigrations: TButton
    Left = 181
    Top = 279
    Width = 105
    Height = 41
    Caption = 'Execute Migrations'
    TabOrder = 3
    OnClick = btnExecuteMigrationsClick
  end
  object memMigrationQuery: TMemo
    Left = 8
    Top = 63
    Width = 369
    Height = 82
    Hint = 'Migration Query'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object memDescription: TMemo
    Left = 8
    Top = 173
    Width = 369
    Height = 82
    Hint = 'Description'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 5
  end
  object lbMigrationList: TListBox
    Left = 399
    Top = 63
    Width = 378
    Height = 257
    ItemHeight = 13
    TabOrder = 6
    OnClick = lbMigrationListClick
  end
  object edtMigrationLocation: TEdit
    Left = 592
    Top = 36
    Width = 185
    Height = 21
    TabOrder = 7
  end
end
