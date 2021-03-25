unit Utils.Divisione;

interface

uses Classes, SysUtils;

function Divisione(const ADividendo, ADivisore: Double): Double;


implementation

uses Math, Dialogs;

function Divisione(const ADividendo, ADivisore: Double): Double;
begin
  if SameValue(ADivisore, 0) then
    raise EDivByZero.Create('Il divisore è nullo');

  if ADividendo > 100 then
    raise Exception.Create('Il dividendo è maggiore di 100');

  Result := ADividendo / ADivisore;
end;



end.
