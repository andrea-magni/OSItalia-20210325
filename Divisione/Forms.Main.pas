unit Forms.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LSL: TStringList;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Utils.Divisione;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ShowMessage(Divisione(7, 1).ToString);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LRisultato: Double;
begin
  try
    LRisultato := Divisione(7, 0);
  except
    LRisultato := -1;
  end;

  ShowMessage(LRisultato.ToString);
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  LRisultato: Double;
begin
  LRisultato := -1;
  try
    LRisultato := Divisione(7, 0);
  finally
    ShowMessage(LRisultato.ToString);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  LRisultato: Double;
begin
  Caption := 'Calcolo...';
  try
    try
      LRisultato := Divisione(7, 0);
      ShowMessage(LRisultato.ToString);
    except
      ShowMessage('Errore durante la divisione');
    end;
  finally
    Caption := 'Terminato';
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
var LRisultato: Double;
begin
  try
    LRisultato := Divisione(101, 1);
    ShowMessage( LRisultato.ToString );
  except
    on EDivByZero do
      ShowMessage('Divisione per zero!');
    on Exception do
      ShowMessage('Altro errore');
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
var LRisultato: Double;
begin
  try
    LRisultato := Divisione(101, 3);
    ShowMessage( LRisultato.ToString );
  except
    on E: EDivByZero do
      ShowMessage(E.Message);
    on E: Exception do
      ShowMessage('Altro errore: ' + E.Message);
    else
      ShowMessage('Altro errore');
  end;
end;

end.
