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

var
  Form1: TForm1;
  itemIndex: integer;

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
  password: string;
  q: boolean;
begin
  q := false;

  InputQuery( 'LOGIN' , 'Zadajte heslo:' , True , password );

  repeat
  if password = '1' then
     q := True
  else
   begin
    ShowMessage( 'fok of' );
    InputQuery( 'LOGIN' , 'Zadajte heslo:' , True , password );
   end;
  until q = True;
end;

end.

