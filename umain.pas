unit umain;

{$mode objfpc}{$H+}

interface

uses
    Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ulicense;

type

    { TForm1 }

    TForm1 = class(TForm)
        ButtonGenPrivKey: TButton;
        ButtonGenerate: TButton;
        EditPrivateKey: TEdit;
        EditAppVersion: TEdit;
        EditApp: TEdit;
        EditInfo: TEdit;
        EditLicense: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        procedure ButtonGenerateClick(Sender: TObject);
        procedure ButtonGenPrivKeyClick(Sender: TObject);
    const
        Private_Key_Length : int8 = 16;
        AlphaKeys : String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
		procedure FormCreate(Sender: TObject);
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
    Data: String;
    LicenseKey: String;
begin
    Data:='';
    LicenseKey:='';
    EditLicense.Caption:='';

    Data:= uppercase(EditInfo.Caption + EditApp.Caption + EditAppVersion.Caption);
    LicenseKey:=GenerateLicenseKey(data, PrivateKey);
    EditLicense.Caption:=LicenseKey;
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
    PrivateKey:='1230A6701B12cc39';
    EditPrivateKey.Caption:=PrivateKey;
end;

end.

