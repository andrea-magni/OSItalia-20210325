unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  CodeSiteLogging, LogRecordUnit;

procedure TForm1.Button1Click(Sender: TObject);
begin
  CodeSite.EnterMethod('Button1Click');
  try
    CodeSite.SendMsg('Test');
  finally
    CodeSite.ExitMethod('Button1Click')
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  L: TLogRecord;
begin
  L.Msg('Test 1');

  var L2: TLogRecord;
  L2.Msg('Test 2');
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  L: TLogRecord;
begin
  L.Msg('Timer');
end;

end.
