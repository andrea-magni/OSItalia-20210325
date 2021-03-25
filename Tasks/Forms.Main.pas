unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.Threading;

type
  TForm1 = class(TForm)
    RunButton: TButton;
    Timer1: TTimer;
    CancelButton: TButton;
    WaitButton: TButton;
    procedure RunButtonClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
    procedure WaitButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTask: ITask;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  System.Rtti, CodeSiteLogging;

function TaskStatusStr(const ATask: ITask): string;
begin
  Result := TRttiEnumerationType.GetName<TTaskStatus>(ATask.Status);
end;


function CurrentTaskStatusStr: string;
begin
  Result := TaskStatusStr(TTask.CurrentTask);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CodeSite.Clear;
end;

procedure TForm1.RunButtonClick(Sender: TObject);
begin
  FTask := TTask.Run(
    procedure
    var
      LCounter: Integer;
    begin
      LCounter := 0;

      while TTask.CurrentTask.Status <> TTaskStatus.Canceled do
      begin
        try
          Inc(LCounter);
          Sleep(250);
          CodeSite.SendFmtMsg('Task %d is alive: %d', [TTask.CurrentTask.Id, LCounter]);

          if Random(100) < 25 then
            raise Exception.Create('My task random exception occurred');
        except
          CodeSite.SendFmtMsg(csmWarning
            , 'Exception in task %d, status: %s'
            , [TTask.CurrentTask.Id, CurrentTaskStatusStr]
          );
          raise;
//          TTask.CurrentTask.Cancel;
        end;
      end;

      CodeSite.SendFmtMsg('Task %d completed, status: %s'
        , [TTask.CurrentTask.Id, CurrentTaskStatusStr]
      );
    end
  );
end;

procedure TForm1.CancelButtonClick(Sender: TObject);
begin
  if Assigned(FTask) and (FTask.Status <= TTaskStatus.Running) then
  begin
    FTask.Cancel;

    FTask := nil;
  end;
end;

procedure TForm1.WaitButtonClick(Sender: TObject);
begin
  if Assigned(FTask) and (FTask.Status = TTaskStatus.Exception) then
  try
    FTask.Wait(0); // causa un'eccezione se Status = Exception
  except on E: EAggregateException do
    begin
      CodeSite.SendFmtMsg(csmError, 'Exceptions in task %d : %s', [FTask.Id, E.ToString]);

      for var LIndex := 0 to E.Count - 1 do
        CodeSite.SendFmtMsg(csmError, 'Task %d, Exception %d: %s', [FTask.Id, LIndex, E[LIndex].Message]);

      FTask := nil;
    end;
  end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Caption := 'Default pool MaxThreads: '
    + TThreadPoolStats.Default.WorkerThreadCount.ToString;

  if Assigned(FTask) then
    Caption := Caption + ' Status: ' + TaskStatusStr(FTask);
end;

end.
