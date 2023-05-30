program StickManDemoPro;

uses
  Forms,
  MainU in 'MainU.pas' {Form1},
  StickMan in 'StickMan.pas',  // this must be in every program that uses the stickman class
  // you must identify where to find the pas file for the StickMan unit
  AboutStickMan in 'AboutStickMan.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
