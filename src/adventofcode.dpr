program adventofcode;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Fadventofcod};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFadventofcod, Fadventofcod);
  Application.Run;
end.
