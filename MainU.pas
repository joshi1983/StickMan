unit MainU;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls,StickMan, Menus;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Button5: TButton;
    Button6: TButton;
    RadioGroup1: TRadioGroup;
    Button7: TButton;
    Button8: TButton;
    Button9: TButton;
    HairColourBTN: TButton;
    ColorDialog1: TColorDialog;
    SkinColourBTN: TButton;
    EyeColourBTN: TButton;
    ShirtColourBTN: TButton;
    MainMenu1: TMainMenu;
    Right1: TMenuItem;
    Left1: TMenuItem;
    Kick1: TMenuItem;
    Kick2: TMenuItem;
    Wave1: TMenuItem;
    StartWave1: TMenuItem;
    StopWave1: TMenuItem;
    StopWave2: TMenuItem;
    Button1: TButton;
    Button2: TButton;
    RadioGroup2: TRadioGroup;
    PantColourBTN: TButton;
    LipColourBTN: TButton;
    RadioGroup3: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Button9Click(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure HairColourBTNClick(Sender: TObject);
    procedure SkinColourBTNClick(Sender: TObject);
    procedure EyeColourBTNClick(Sender: TObject);
    procedure ShirtColourBTNClick(Sender: TObject);
    procedure Kick1Click(Sender: TObject);
    procedure Kick2Click(Sender: TObject);
    procedure Blink1Click(Sender: TObject);
    procedure Blink2Click(Sender: TObject);
    procedure Wave1Click(Sender: TObject);
    procedure StartWave1Click(Sender: TObject);
    procedure StopWave1Click(Sender: TObject);
    procedure StopWave2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure PantColourBTNClick(Sender: TObject);
    procedure LipColourBTNClick(Sender: TObject);
    procedure RadioGroup3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
   sm: tStickMan;

const SMPos: tpoint = (x:300;y:100);

implementation

uses AboutStickMan;

{$R *.DFM}


procedure TForm1.FormCreate(Sender: TObject);
begin
     sm:=tStickMan.create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin // when the program ends
     sm.Free;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     sm.DrawStickMan; // it is already known what canvas to draw the stickman on
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin // Beard
     sm.bearded:=checkbox1.checked;
end;

procedure TForm1.CheckBox2Click(Sender: TObject);
begin // Glasses
     sm.WearingGlasses:=checkbox2.checked;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin // Blink Left Eye
     sm.LeftEye.Blink;
end;

procedure TForm1.RadioGroup1Click(Sender: TObject);
begin // Hair Style
     case radioGroup1.ItemIndex of
       0: sm.HairStyle:=hsBald;
       1: sm.HairStyle:=hsNearBald;
       2: sm.HairStyle:=hsNormal;
       3: sm.HairStyle:=hsThick;
       4: sm.HairStyle:=hsMoHawk;
       5: sm.HairStyle:=hsLongStraight;
     end;
end;

procedure TForm1.Button7Click(Sender: TObject);
begin // hide
     sm.hide; // clear the canvas of the changes made by drawing him
     timer1.enabled:=false;
     // now the timer won't update the stickman and draw him anymore
end;

procedure TForm1.Button8Click(Sender: TObject);
begin // Show StickMan
     timer1.enabled:=true;
end;

procedure TForm1.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if sm.initialized then
     begin // get the eyes to look toward the cursor
          sm.LeftEye.Focus:=point(x-sm.x-(sm.height shr 5),y-sm.y);
          sm.RightEye.Focus:=point(x-sm.x+(sm.height shr 5),y-sm.y);
     end;
end;

procedure TForm1.Button9Click(Sender: TObject);
var
  x: integer;
  comp: tobject;
begin
     for x:=form1.ComponentCount-1 downto 0 do
     begin { loop through components the components on the form to have them
      link to this procedure
        After this, when the components are clicked, this procedure is called
        and the object is sent as a parameter.  The stick man gets told to remove
        the objects.
      }
          comp:=form1.Components[x];
          if comp<>nil then
          begin
             if comp is tButton then // if the object is a button
                (comp as tbutton).onclick:=button9click;
                // treat it like a button and set its onclick procedure to this procedure
             if comp is tCheckBox then
                (comp as tCheckbox).onclick:=button9click;
             if comp is tRadioGroup then // if its a radiogroup
                (comp as tRadioGroup).onclick:=button9click;
          end;
     end;
     sm.RemoveObject(Sender);
     // get sm to remove the sender object, in his own way

     if form1.ComponentCount<2 then
        ShowMessage('Wow!  I was really hungry.');
end;

procedure TForm1.FormPaint(Sender: TObject);
begin
    if not sm.initialized then
    begin
         sm.initialize(canvas,{have the stickman drawn on the form's canvas}
         300{height},300{x coordinate},100{y coordinate},rgb(190,150,140){skin colour},rgb(125,63,0){eye colour},
         clBlack{hair colour},clWhite{clothing},CheckBox2.Checked{glasses},CheckBox1.Checked{beard});
         RadioGroup1Click(Sender);
         sm.RightLeg.Colour:=clSilver;
         sm.LeftLeg.Colour:=clSilver;
         RadioGroup2Click(Sender);
         RadioGroup3Click(Sender);
         sm.LipColour:=rgb(200,120,100);
         //sm.LipStyle:=lsBold;
    end;
end;

procedure TForm1.HairColourBTNClick(Sender: TObject);
begin // Hair Colour
     ColorDialog1.Color:=sm.HairColour;
     if colordialog1.execute then
        sm.HairColour:=ColorDialog1.Color;
end;

procedure TForm1.SkinColourBTNClick(Sender: TObject);
begin // Skin Colour
     ColorDialog1.Color:=sm.SkinColour;
     if ColorDialog1.Execute then
        sm.SkinColour:=ColorDialog1.Color;
end;

procedure TForm1.EyeColourBTNClick(Sender: TObject);
begin // Eye Colour
     colordialog1.Color:=sm.LeftEye.EyeColour;
     if colordialog1.execute then
     begin
          sm.LeftEye.EyeColour:=colordialog1.color;
          sm.RightEye.EyeColour:=colordialog1.color;
     end;
end;

procedure TForm1.ShirtColourBTNClick(Sender: TObject);
begin // Clothing Colour
     colordialog1.Color:=sm.ShirtColour;
     if colordialog1.execute then
     begin
          sm.ShirtColour:=colordialog1.color;
     end;
end;

procedure TForm1.PantColourBTNClick(Sender: TObject);
begin // Pant Colour
     colordialog1.Color:=sm.RightLeg.Colour;
     if colordialog1.execute then
     begin
          sm.RightLeg.Colour:=colordialog1.color;
          sm.LeftLeg.Colour:=colordialog1.color;
     end;
end;

procedure TForm1.Kick1Click(Sender: TObject);
begin // Kick Right Leg
     sm.RightLeg.Kick(ksQuickKick,true);
end;

procedure TForm1.Kick2Click(Sender: TObject);
begin // Kick Left Leg
     sm.LeftLeg.kick(ksQuickKick,false);
end;

procedure TForm1.Blink1Click(Sender: TObject);
begin // Blink Right Eye
     sm.RightEye.Blink;
end;

procedure TForm1.Blink2Click(Sender: TObject);
begin // Eye Colour
     colordialog1.Color:=sm.LeftEye.EyeColour;
     if colordialog1.execute then
     begin
          sm.LeftEye.EyeColour:=colordialog1.color;
          sm.RightEye.EyeColour:=colordialog1.color;
     end;
end;

procedure TForm1.Wave1Click(Sender: TObject);
begin // Wave Right Arm
     sm.RightArm.StartWaving;
end;

procedure TForm1.StartWave1Click(Sender: TObject);
begin // Wave Left Arm
     sm.Leftarm.StartWaving;
end;

procedure TForm1.StopWave1Click(Sender: TObject);
begin // Stop Waving Left Arm
     sm.Leftarm.StopWaving;
end;

procedure TForm1.StopWave2Click(Sender: TObject);
begin // Stop Waving Right Arm
     sm.RightArm.StopWaving;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin // Blink Right Eye
     sm.RightEye.Blink;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin // Make Jumping Jack
     sm.MakeJumpingJack;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin // About StickMan
     sm.JackingShowModal(form2);
end;

procedure TForm1.RadioGroup2Click(Sender: TObject);
begin // Torso style
     case RadioGroup2.ItemIndex of
       0: sm.Torso:=tsSkinny;
       1: sm.Torso:=tsAverage;
       2: sm.Torso:=tsLarge;
       3: sm.Torso:=tsExtraLarge;
       4: sm.Torso:=tsSpherical;
       5: sm.Torso:=tsTooLarge;
     end;
end;


procedure TForm1.LipColourBTNClick(Sender: TObject);
begin // Lip Colour
     colordialog1.Color:=sm.LipColour;
     if colordialog1.execute then
     begin
          sm.LipColour:=colordialog1.color;
     end;
end;

procedure TForm1.RadioGroup3Click(Sender: TObject);
begin // Eyebrows
     case radioGroup3.ItemIndex of
     0: sm.EyebrowStyle:=ebBushy;
     1: sm.EyebrowStyle:=ebReallyBushy;
     2: sm.EyebrowStyle:=ebLifted;
     3: sm.EyebrowStyle:=ebVeryThin;
     4: sm.EyebrowStyle:=ebArced;
     end;
end;

end.
