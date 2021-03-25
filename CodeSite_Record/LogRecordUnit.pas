unit LogRecordUnit;

interface

uses
  Classes, SysUtils;

type
  TLogRecord = record
  private
    FName: string;
  public
    class operator Initialize(out ARec: TLogRecord);
    class operator Finalize(var ARec: TLogRecord);
  public
    procedure Msg(const AMsg: string);
    property Name: string read FName;
  end;

implementation

uses CodeSiteLogging;

{ TLogRecord }

class operator TLogRecord.Finalize(var ARec: TLogRecord);
begin
  CodeSite.ExitMethod('Rec ' + ARec.Name);
end;

class operator TLogRecord.Initialize(out ARec: TLogRecord);
begin
  ARec.FName := Format('%p', [Pointer(@ARec)]);
  CodeSite.EnterMethod('Rec ' + ARec.Name);
end;

procedure TLogRecord.Msg(const AMsg: string);
begin
  CodeSite.SendFmtMsg('%s', [AMsg]);
end;

end.
