unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  LCLType, Buttons, ShellApi, Types;
type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    ListBox2: TListBox;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Login;
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

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin

end;



procedure TForm1.FormCreate(Sender: TObject);
begin



   Login;
   Label2.Caption := menoPokladnika;
   ListBox1.Items.Clear;             //Delete all existing strings
  ListBox1.Items.Add('First line');
  ListBox1.Items.Add('Second Line');
  ListBox1.Items.Add('Third Line');
  ListBox1.Items.Add('First line');
  ListBox1.Items.Add('Second Line');
  ListBox1.Items.Add('Third Line');
  ListBox1.Items.Add('First line');
  ListBox1.Items.Add('Second Line');
  ListBox1.Items.Add('Third Line');
  ListBox1.Items.Add('First line');
  ListBox1.Items.Add('Second Line');
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

  InputQuery( 'LOGIN' , 'Zadajte heslo:' , True , passwordIn );

  repeat
  for j := 1 to size do
     begin
          if strtoint( passwordIn ) = menoHeslo[ j ].heslo then
            begin
             q := True;
             menoPokladnika := menoHeslo[ j ].meno;
             Break;
            end;
      end;
          if q = false then
            begin
             ShowMessage( 'Nesprávne heslo' );
             InputQuery( 'LOGIN' , 'Zadajte heslo:' , True , passwordIn );
            end;
  until q = True;
end;

end.

