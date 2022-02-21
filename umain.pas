unit umain;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ulicense;

type

    { TForm1 }

    TForm1 = class(TForm)
        ButtonCheck: TButton;
        ButtonGenPrivKey: TButton;
        ButtonGenerate: TButton;
				EditCheckLicense: TEdit;
        EditLicense1: TEdit;
        EditPrivateKey: TEdit;
        EditApp: TEdit;
        EditLicense: TEdit;
        Label2: TLabel;
        Label4: TLabel;
		procedure ButtonCheckClick(Sender: TObject);
        procedure FormCreate(Sender: TObject);
        procedure ButtonGenerateClick(Sender: TObject);
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
procedure TForm1.ButtonGenerateClick(Sender: TObject);
var
    Data, EncryptedString: String;
begin
    Data:='';
    EncryptedString:='';
    EditLicense.Caption:='';

    Data:= EditApp.Caption;
    EncryptedString:=Encrypt(Data, PrivateKey);
    EditLicense.Caption:=EncryptedString;
//end proc
end;

procedure TForm1.ButtonGenPrivKeyClick(Sender: TObject);
begin
    PrivateKey:='';
    PrivateKey:=GeneratePrivateKey(16);
    EditPrivateKey.Caption := PrivateKey;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
end;

procedure TForm1.ButtonCheckClick(Sender: TObject);
var
    Data: String;
begin
    Data:='';
    EditCheckLicense.Caption:='';

    Data:= Decrypt(EditLicense.Caption, PrivateKey);
    EditCheckLicense.Caption:=Data;
//end proc
end;

end.

