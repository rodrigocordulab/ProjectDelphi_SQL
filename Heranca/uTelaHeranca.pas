unit uTelaHeranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, ZAbstractRODataset, ZAbstractDataset, ZDataset, uDTMConexao, uEnum;

type
  TfrmTelaHeranca = class(TForm)
    pgcPrincipal: TPageControl;
    pnlRodape: TPanel;
    tabListagem: TTabSheet;
    TabManutencao: TTabSheet;
    pnlListagem: TPanel;
    mskPesquisar: TMaskEdit;
    btnPesquisar: TBitBtn;
    grdListagem: TDBGrid;
    btnNovo: TBitBtn;
    btnAlterar: TBitBtn;
    btnCancelar: TBitBtn;
    btnGravar: TBitBtn;
    btnApagar: TBitBtn;
    btnFechar: TBitBtn;
    btnNavigator: TDBNavigator;
    QryListagem: TZQuery;
    dtsListagem: TDataSource;
    lblIndice: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnApagarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure grdListagemTitleClick(Column: TColumn);
    procedure mskPesquisarChange(Sender: TObject);
  private
    { Private declarations }
    EstadoDoCadastro : TEstadoDoCadastro;

    procedure ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
    btnGravar, btnApagar:TBitBtn; btnNavigator:TDBNavigator; pgcPrincipal: TPageControl;
    Flag:Boolean);
    procedure ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
    function RetornarCampoTraduzido(Campo: String): string;
    procedure ExibirLabelIndice(Campo: String; aLabel: TLabel);
  public
    { Public declarations }
    IndiceAtual : string;
  end;

var
  frmTelaHeranca: TfrmTelaHeranca;

implementation

{$R *.dfm}

//Procedimento de controle de tela

procedure TfrmTelaHeranca.ControlarBotoes(btnNovo, btnAlterar, btnCancelar,
btnGravar, btnApagar:TBitBtn; btnNavigator:TDBNavigator; pgcPrincipal: TPageControl;
Flag:Boolean);
begin
 btnNovo.Enabled := Flag;
 btnApagar.Enabled := Flag;
 btnAlterar.Enabled := Flag;
 btnNavigator.Enabled := Flag;
 pgcPrincipal.Pages[0].TabVisible := Flag;

 btnCancelar.Enabled := not(Flag);
 btnGravar.Enabled := not(Flag);
end;

procedure TfrmTelaHeranca.ControlarIndiceTab(pgcPrincipal: TPageControl; Indice: Integer);
begin
  if (pgcPrincipal.Pages[Indice].TabVisible) then
      pgcPrincipal.TabIndex := Indice;

end;

function TfrmTelaHeranca.RetornarCampoTraduzido(Campo:String):string;
var i : Integer;
begin
  for I := 0 to QryListagem.Fields.Count - 1 do
  begin
    if (QryListagem.Fields[I].FieldName = Campo) then
    begin
      Result := QryListagem.Fields[I].DisplayLabel;
      Break;
    end;
  end;
end;

procedure TfrmTelaHeranca.ExibirLabelIndice(Campo:String; aLabel:TLabel);
begin
  aLabel.Caption := RetornarCampoTraduzido(Campo);
end;

procedure TfrmTelaHeranca.btnNovoClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
    btnNavigator,pgcPrincipal,false);

  EstadoDoCadastro := ecInserir;
end;

procedure TfrmTelaHeranca.btnAlterarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
    btnNavigator,pgcPrincipal,false);

  EstadoDoCadastro := ecAlterar;
end;

procedure TfrmTelaHeranca.btnApagarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
    btnNavigator,pgcPrincipal,true);

  ControlarIndiceTab(pgcPrincipal,0);

  EstadoDoCadastro := ecNenhum;
end;

procedure TfrmTelaHeranca.btnCancelarClick(Sender: TObject);
begin
  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
    btnNavigator,pgcPrincipal,true);

  ControlarIndiceTab(pgcPrincipal,0);
  EstadoDoCadastro := ecNenhum;
end;

procedure TfrmTelaHeranca.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmTelaHeranca.btnGravarClick(Sender: TObject);
begin
  Try
    ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
      btnNavigator,pgcPrincipal,true);

    ControlarIndiceTab(pgcPrincipal,0);

    if (EstadoDoCadastro = ecInserir) then
        ShowMessage('Inserir')
    else if(EstadoDoCadastro = ecAlterar) then
        ShowMessage('Alterar')
    else
        ShowMessage('Nada Aconteceu');

  Finally
    EstadoDoCadastro := ecNenhum;
  End;

end;

procedure TfrmTelaHeranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  QryListagem.Close;
end;

procedure TfrmTelaHeranca.FormCreate(Sender: TObject);
begin
  QryListagem.Connection := dtmConexao.ConexaoDB;
  dtsListagem.DataSet := QryListagem;
  grdListagem.DataSource := dtsListagem;
  grdListagem.Options:=[dgTitles,dgIndicator,dgColumnResize,
  dgColLines,dgRowLines,dgTabs,dgRowSelect,
  dgAlwaysShowSelection,dgCancelOnExit,dgTitleClick,
  dgTitleHotTrack]
end;

procedure TfrmTelaHeranca.FormShow(Sender: TObject);
begin
  if (QryListagem.SQL.Text <> EmptyStr) then
  begin
    QryListagem.IndexFieldNames := IndiceAtual;
    ExibirLabelIndice(IndiceAtual,lblIndice);
    QryListagem.Open;
  end;

  ControlarBotoes(btnNovo,btnAlterar,btnCancelar,btnGravar,btnApagar,
                  btnNavigator,pgcPrincipal,true);
end;

procedure TfrmTelaHeranca.grdListagemTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  QryListagem.IndexFieldNames := IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmTelaHeranca.mskPesquisarChange(Sender: TObject);
begin
  QryListagem.Locate(IndiceAtual,TMaskEdit(Sender).Text, [loPartialKey]);

end;

end.
