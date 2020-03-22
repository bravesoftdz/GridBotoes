unit uPrincipal;


{

IDE LAZARUS !

PROGRAMA: BOTÕES DINAMICOS

AUTOR COM PANELS: HUMBERTO SALES OLIVEIRA
ADAPTAÇÃO COM BUTTOM: DANIEL DE MORAIS

OBS:

HUMBERTO SALES OLIVEIRA DO CANAL SALESDOIDO DO YOUTUBE
MOSTROU COMO TRABALHAR DINAMICAMENTE COM PAINEIS.

EU DANIEL DE MORAIS DO CANAL INFOCOTIDIANO, ADAPTEI AS MINHAS
NECESSIDADES PARA TRABALHAR COM BOTOES.

PRECISAVA DE UMA SOLUÇÃO PARA UM PDV PARA RESTAURANTE E POR ISSO
O USO DE BOTOES EM UMA QUERY COM IMAGENS.


}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, Buttons, DBGrids, JLabeledIntegerEdit;

type

  { TfrmPrincipal }

  TfrmPrincipal = class(TForm)
    btnCadastro: TButton;
    btnExecuta: TButton;
    cmbPosicaoIcone: TComboBox;
    DBGrid1: TDBGrid;
    nColunas: TJLabeledIntegerEdit;
    Label1: TLabel;
    nAlturaBotao: TJLabeledIntegerEdit;
    Panel1: TPanel;
    Panel2: TPanel;
    pnpBotoesTitulo: TPanel;
    pnpTituloQuery: TPanel;
    pnpQueryGrupo: TPanel;
    ScrollBox1: TScrollBox;
    procedure btnCadastroClick(Sender: TObject);
    procedure btnExecutaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
  private
    procedure CliqueDoBotao(sender:TObject);

  public

  end;

var
  frmPrincipal: TfrmPrincipal;

implementation
   uses ucadgrupo, utabglobal;
{$R *.lfm}

{ TfrmPrincipal }



procedure TfrmPrincipal.FormActivate(Sender: TObject);
begin
  TabGlobal.conexao.Connect;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject; var CloseAction: TCloseAction
  );
begin
    TabGlobal.conexao.Connect;

end;

procedure TfrmPrincipal.CliqueDoBotao(sender: TObject);
begin
  ShowMessage('Você clicou em: '+ (sender as TBitBtn).Caption+#13+
  'O código é: '+ (sender as TBitBtn).Hint);
end;

procedure TfrmPrincipal.btnExecutaClick(Sender: TObject);
var
  nLin, nCol, nPosX, nPosY, nRegistros : integer;
  cImagem : TImage;
  msImagem : TMemoryStream;
  btn : TBitBtn;
  aImagem : TPicture;
begin
  ScrollBox1.DestroyComponents;
  TabGlobal.tbGrupo.Close;
  TabGlobal.tbGrupo.sql.Clear;
  TabGlobal.tbGrupo.sql.Add('Select * from grupo');
  TabGlobal.tbGrupo.sql.Add('where cria_botao in(1)');
  TabGlobal.tbGrupo.open;
  {
  o valor cria_botão in(1) significa que só será exibido
  os grupos que a propriedade do registro na tabela de grupo, campo
  CRIA_BOTAO = 1, se for igual a 0, o botão não será criado/exibido.
  }

  DBGrid1.DataSource := TabGlobal.dsGrupo;
  nRegistros:=TabGlobal.tbGrupo.RecordCount;
  nPosX:=0; nPosY:= 0;
  TabGlobal.tbGrupo.First;
  while not TabGlobal.tbGrupo.EOF do
     begin
       nLin:=1;
       while (nLin <= (nRegistros div nColunas.Value)) and (not TabGlobal.tbGrupo.EOF) do
            begin
               nCol:=1;
               while (nCol <= nColunas.Value) and (not TabGlobal.tbGrupo.EOF) do
                    begin
                       btn := TBitBtn.Create(ScrollBox1);
                       btn.Parent := ScrollBox1;
                       btn.Left:= nPosX+1;
                       btn.Top := nPosY+1;
                       btn.Width:=(ScrollBox1.Width div nColunas.Value)-1;
                       btn.Height:=nAlturaBotao.Value; // StrToInt(edit1.text);
                       btn.Caption:=TabGlobal.tbGrupodesc_botao.Value;
                       btn.Hint   := inttostr( TabGlobal.tbGrupocodigo.Value);
                       btn.OnClick := @CliqueDoBotao;
                       btn.ShowHint:=true;
                       if cmbPosicaoIcone.Text = 'Esquerda' then btn.Layout:=blGlyphLeft;
                       if cmbPosicaoIcone.Text = 'Direita' then btn.Layout:=blGlyphRight;
                       if cmbPosicaoIcone.Text = 'Em cima' then btn.Layout:=blGlyphTop;
                       if cmbPosicaoIcone.Text = 'Em baixo' then btn.Layout:=blGlyphBottom;
                       if not TabGlobal.tbGrupoimagem_botao.IsNull then
                          begin
                            try
                              msImagem := TMemoryStream.Create;
                              TabGlobal.tbGrupoimagem_botao.SaveToStream(msImagem);
                              msImagem.Position:=0;
                              aImagem := TPicture.Create;
                              aImagem.LoadFromStream(msImagem);
                              btn.Glyph.Assign(aImagem.Bitmap);
                            except
                            end;
                          end;
                       nPosX:=nPosX+btn.Width;
                       TabGlobal.tbGrupo.Next;
                       nCol:= nCol+1;
                    end;
                 nPosX:=0;
                 nPosY:= nPosY+btn.Height+1;
                 nLin:=nLin+1;
            end;
     end;


end;

procedure TfrmPrincipal.btnCadastroClick(Sender: TObject);
begin
  TabGlobal.tbGrupo.Close;
  TabGlobal.tbGrupo.sql.Clear;
  TabGlobal.tbGrupo.sql.Add('Select * from grupo');
  TabGlobal.tbGrupo.open;
  frmCadGrupo := TfrmCadGrupo.Create(self);
  try
    frmCadGrupo.ShowModal;
  finally
    FreeAndNil(frmCadGrupo);
  end;
  TabGlobal.tbGrupo.Close;
end;

end.

