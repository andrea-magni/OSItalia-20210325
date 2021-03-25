unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure MyGlobalExceptionHandler(Sender: TObject; E: Exception);
    procedure MyThreadTerminateHandler(Sender: TObject);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses CodeSiteLogging;

procedure TForm1.Button1Click(Sender: TObject);
begin
  raise Exception.Create('This is my error message');
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LThread: TThread;
begin
  LThread := TThread.CreateAnonymousThread(
    procedure
    var
      LCounter: Integer;
    begin
      CodeSite.SendFmtMsg('AnonymousThread %d started', [TThread.CurrentThread.ThreadID]);
      TThread.NameThreadForDebugging('Anonymous ' + TThread.CurrentThread.ThreadID.ToString);
      LCounter := 0;
      while not TThread.CheckTerminated do
      begin
        Sleep(250 + Random(500));
        Inc(LCounter);

        CodeSite.SendFmtMsg('AnonymousThread %d working ... %d', [TThread.CurrentThread.ThreadID, LCounter]);

        if Random(100) < 10 then
          raise Exception.Create('Random error in thread occurred');
      end;
    end
  );

  LThread.OnTerminate := MyThreadTerminateHandler;

  LThread.Start;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Application.OnException := MyGlobalExceptionHandler;
  CodeSite.Clear;
  Randomize;
end;

procedure TForm1.MyGlobalExceptionHandler(Sender: TObject; E: Exception);
begin
  CodeSite.SendException(E);
//  Application.HandleException(E); // recursion!
  Application.ShowException(E);
end;

procedure TForm1.MyThreadTerminateHandler(Sender: TObject);
var
  LThread: TThread;
  LException: Exception;
begin
  LThread := Sender as TThread;

  if Assigned(LThread.FatalException) then
  begin
    LException := LThread.FatalException as Exception;
    CodeSite.SendFmtMsg(csmWarning
      , 'Thread %d terminato con eccezione %s %s'
      , [LThread.ThreadID, LException.ClassName, LException.Message]
    );
  end
  else
    CodeSite.SendFmtMsg(csmInfo, 'Thread %d terminato senza errori', [LThread.ThreadID]);

end;

end.
