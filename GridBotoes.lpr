program GridBotoes;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, zcomponent, uPrincipal, utabglobal, ucadgrupo
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='Botões Dinânicos';
  Application.Initialize;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TTabGlobal, TabGlobal);
  Application.CreateForm(TfrmCadGrupo, frmCadGrupo);
  Application.Run;
end.

