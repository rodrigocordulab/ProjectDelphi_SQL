object dtmConexao: TdtmConexao
  OldCreateOrder = False
  Height = 255
  Width = 613
  object ConexaoDB: TZConnection
    ControlsCodePage = cCP_UTF16
    Catalog = ''
    SQLHourGlass = True
    HostName = '.\SQLEXPRESS'
    Port = 1433
    Database = 'vendas'
    User = ''
    Password = 'curso@123'
    Protocol = 'mssql'
    LibraryLocation = 'C:\Users\Menew\Documents\ProjetoDelphi\ntwdblib.dll'
    Left = 16
    Top = 8
  end
end
