unit umain;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ulicense;

type

    { TForm1 }

    TForm1 = class(TForm)
        ButtonGenPrivKey: TButton;
        ButtonGenerateSerials: TButton;
				EditNumberSerial: TEdit;
        EditLicense1: TEdit;
        EditPrivateKey: TEdit;
        EditApp: TEdit;
				Label1: TLabel;
        Label2: TLabel;
        Label4: TLabel;
				MemoKeyList: TMemo;
        procedure FormCreate(Sender: TObject);
        procedure ButtonGenerateSerialsClick(Sender: TObject);
        procedure ButtonGenPrivKeyClick(Sender: TObject);
    const
        Private_Key_Length : int8 = 16;
        AlphaKeys : String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    private
           PrivateKey: String;
    public

    end;

var
    Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// https://stackoverflow.com/questions/55229772/using-openssl-to-generate-keypairs/55239810#55239810
//https://www.openssl.org/docs/man3.0/man3/RSA_generate_key_ex.html
procedure TForm1.ButtonGenerateSerialsClick(Sender: TObject);
var
    Data, Clear, EncryptedString: String;
    I: Integer;
begin
    MemoKeyList.Clear;
    Data:='';
    Clear:='';
    I:= 0;
    EncryptedString:='';

    For I:=1 to StrToInt(EditNumberSerial.Caption) do
    begin
      Data:= EditApp.Caption + ';' + IntToStr(I);
      EncryptedString:=Encrypt(Data, PrivateKey);

      // test
      Clear:=Decrypt(EncryptedString, PrivateKey);
      if Clear = EditApp.Caption + ';' + IntToStr(I) then
         MemoKeyList.Append(EncryptedString);
		end;


//end proc
end;

procedure TForm1.ButtonGenPrivKeyClick(Sender: TObject);
begin
    PrivateKey:='';
    PrivateKey:=GeneratePrivateKey(32);
    EditPrivateKey.Caption := PrivateKey;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

end.

