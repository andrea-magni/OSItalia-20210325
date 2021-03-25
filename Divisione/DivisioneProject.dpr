program DivisioneProject;

uses
  Vcl.Forms,
  Forms.Main in 'Forms.Main.pas' {Form1},
  Utils.Divisione in 'Utils.Divisione.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
