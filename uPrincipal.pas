unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus,Enter;

type
  TfrmPrincipal = class(TForm)
    mainPrincipal: TMainMenu;
    CADASTRO1: TMenuItem;
    MOVIMENTAO1: TMenuItem;
    RELATRIOS1: TMenuItem;
    Cliente1: TMenuItem;
    N1: TMenuItem;
    Categoria1: TMenuItem;
    Produto1: TMenuItem;
    N2: TMenuItem;
    menuFechar: TMenuItem;
    Vendas1: TMenuItem;
    Clientes1: TMenuItem;
    N3: TMenuItem;
    Produto2: TMenuItem;
    N4: TMenuItem;
    VendaporData1: TMenuItem;
    procedure menuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Categoria1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}


uses
  uDTMConexao, uCadCategoria;

procedure TfrmPrincipal.Categoria1Click(Sender: TObject);
begin
  frmCadCategoria := TfrmCadCategoria.Create(Self);
  frmCadCategoria.ShowModal;
  frmCadCategoria.Release;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(TeclaEnter);
  FreeAndNil(dtmConexao);
end;

procedure TfrmPrincipal.FormCreate(Sender: TObject);
begin
  {dtmConexao := TdtmConexao.Create(Self);
  dtmConexao.ConexaoDB.SQLHourGlass := True;
  dtmConexao.ConexaoDB.Protocol := 'mssql';
  dtmConexao.ConexaoDB.LibraryLocation := 'C:\Users\Menew\Documents\ProjetoDelphi\ntwdblib.dll';
  dtmConexao.ConexaoDB.HostName := '.\SQLEXPRESS';
  dtmConexao.ConexaoDB.Port := 1433;
  dtmConexao.ConexaoDB.User := 'sa';
  dtmConexao.ConexaoDB.Password := 'curso@123';
  dtmConexao.ConexaoDB.Database := 'vendas';
  dtmConexao.ConexaoDB.Connected := True;  }

  dtmConexao := TdtmConexao.Create(Self);
  with dtmConexao.ConexaoDB do
  begin
      SQLHourGlass := False;
      Protocol := 'mssql';
      LibraryLocation := 'C:\Users\Menew\Documents\ProjetoDelphi\ntwdblib.dll';
      HostName := '.\SQLEXPRESS';
      Port := 1433;
      User := 'sa';
      Password := 'curso@123';
      Database := 'vendas';
      Connected := True;
  end;

  TeclaEnter := TMREnter.Create(Self);
  TeclaEnter.FocusEnabled := true;
  TeclaEnter.FocusColor := clInfoBk;
end;

procedure TfrmPrincipal.menuFecharClick(Sender: TObject);
begin
  //Close;
  Application.Terminate;
end;


end.
