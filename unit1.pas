unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType, Buttons, ExtCtrls, ShellApi, Types;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit2: TEdit;
    ImageStorno: TImage;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ImageStornoClick(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Login;
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

  Loginy = record
    meno: string;
    heslo: integer;
  end;

var
  Form1: TForm1;
  itemIndex: integer;
  medzisucet: integer;
  prihlasenie: textfile;
  menoPokladnika: string;
  menoHeslo: array[1..50] of Loginy;
  stop: boolean;

implementation

{$R *.lfm}

{ TForm1 }



procedure TForm1.Button4Click(Sender: TObject);
begin

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
   Stop := false;


   Login;

   if Stop then
      Timer1.Enabled := True;
   //meno pokladnika
   Label2.Caption := menoPokladnika;

   //Strono button
   ImageStorno.Canvas.Brush.Color := clRed;
   ImageStorno.Canvas.FillRect( ImageStorno.ClientRect );
   ImageStorno.Canvas.Font.Color := clBlack;
   ImageStorno.Canvas.Font.Size := 13;
   ImageStorno.Canvas.TextOut( 53 , 13, 'STORNO');


   ListBox1.Items.Clear;             //Delete all existing strings


   ListBox1.Items.Add('First line');
  ListBox1.Items.Add('Second Line');
  ListBox1.Items.Add('Third Line');
end;

procedure TForm1.ImageStornoClick(Sender: TObject);
begin
  if MessageDlg('Question', 'Do you wish to Execute?', mtConfirmation,
   [mbYes, mbNo],0) = mrYes
  then
  Close;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
var i: integer;
begin

      for i := 0 to ListBox1.Count-1 do
    if ListBox1.Selected[i] = True then
       begin
        itemIndex := i;
        break;
       end;
   Memo1.Append( ListBox1.Items[itemIndex] );
   Label1.Caption := ListBox1.Items[itemIndex];
end;



procedure TForm1.Login;
var
  passwordIn: string;
  q: boolean;
  size, i ,j : integer;
  udaj: string;
  attempts: integer;
begin
  AssignFile( prihlasenie , 'pokladnici.txt' );
  Reset( prihlasenie );
  Read( prihlasenie , size );
  ReadLn( prihlasenie , udaj );

  for i := 1 to size do
     begin
        ReadLn( prihlasenie , udaj );
        menoHeslo[i].meno := udaj;

        ReadLn( prihlasenie , udaj );
        menoHeslo[i].heslo := strtoint( udaj );
     end;


  q := false;
  attempts := 1;


  repeat
  if InputQuery( 'LOGIN' , 'Zadajte pin:' , True , passwordIn ) then
  begin
    for j := 1 to size do
       begin
            if passwordIn = inttostr( menoHeslo[ j ].heslo ) then
              begin
               q := True;
               menoPokladnika := menoHeslo[ j ].meno;
               Break;
              end;
      end;

      if attempts = 3 then
         begin
          ShowMessage( '3 krát ste zadali nesprávne heslo.' );
          Stop := true;
          Break;
         end;

      if passwordIn <> inttostr( menoHeslo[ j ].heslo ) then
            begin
             ShowMessage( 'Nesprávne heslo' );
             inc( attempts );
             Continue;
            end;
  end
  else
    begin
       Stop := true;
          Break;
    end;
  until q = True;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  Close;
end;

end.

