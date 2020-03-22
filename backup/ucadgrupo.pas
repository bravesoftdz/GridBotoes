unit ucadgrupo;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, DBGrids,
  DbCtrls, StdCtrls, jdblabeledintegeredit, JDBLabeledEdit;

type

  { TfrmCadGrupo }

  TfrmCadGrupo = class(TForm)
    DBCheckBox1: TDBCheckBox;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    JDBLabeledEdit1: TJDBLabeledEdit;
    JDBLabeledEdit2: TJDBLabeledEdit;
    nCodigo: TJDBLabeledIntegerEdit;
    OpenDialog1: TOpenDialog;
    procedure DBImage1Click(Sender: TObject);
  private

  public

  end;

var
  frmCadGrupo: TfrmCadGrupo;

implementation
  uses utabglobal;

{$R *.lfm}

  { TfrmCadGrupo }

  procedure TfrmCadGrupo.DBImage1Click(Sender: TObject);
  begin
    OpenDialog1.Execute;
    TabGlobal.tbGrupoimagem_botao.LoadFromFile(OpenDialog1.FileName);
  end;

end.

