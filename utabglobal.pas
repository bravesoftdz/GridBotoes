unit utabglobal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, db, FileUtil, ZConnection, ZDataset, ZSqlUpdate;

type

  { TTabGlobal }

  TTabGlobal = class(TDataModule)
    conexao: TZConnection;
    dsGrupo: TDataSource;
    tbGrupo: TZQuery;
    tbGrupocodigo: TLongintField;
    tbGrupocria_botao: TLongintField;
    tbGrupodescricao: TStringField;
    tbGrupodesc_botao: TStringField;
    tbGrupogrupocol: TStringField;
    tbGrupoimagem_botao: TBlobField;
    upGrupo: TZUpdateSQL;
    procedure tbGrupoAfterPost(DataSet: TDataSet);
  private

  public

  end;

var
  TabGlobal: TTabGlobal;

implementation

{$R *.lfm}

{ TTabGlobal }

procedure TTabGlobal.tbGrupoAfterPost(DataSet: TDataSet);
begin
  tbGrupo.ApplyUpdates;
end;

end.

