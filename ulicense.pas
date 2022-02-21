unit ulicense;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, md5, math;

const
  AlphaKeys : String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

function GeneratePrivateKey(L: LongInt): String;

function Encrypt(Data: String; PrivateKey: String): String;
function Decrypt(Data: String; PrivateKey: String): String;

implementation

function GeneratePrivateKey(L: LongInt): String;
var
  r: String;
  a: int8;
begin
  r := '';
  a := 0;
  while Length(r) < L do
  begin
    a := RandomRange(1, Length(AlphaKeys) + 1);
    r := r + String(AlphaKeys[a]);
  end;

  Result := r;
end;

function Encrypt(Data: String; PrivateKey: String): String;
var
  C, P, Key, EncryptedData, LicenseKey: String;
  I, Pos1, Pos2, Pos3, Z, SrcLen, AKLen: Integer;
begin
  C:='';
  P:='';
  Key:='';
  EncryptedData:='';
  LicenseKey:='';
  I:=0;
  Pos1:=0;
  Pos2:=0;
  Pos3:=0;
  Z:=0;
  SrcLen:= 0;
  AKLen:= Length(AlphaKeys);

  Key:=Uppercase(MD5Print(MD5String(Data)));

  SrcLen:= Length(Key);
  Z := 0;
  For I:= 0 to SrcLen - 1 do
  begin
    C := Key[I + 1];
    Pos1 := AlphaKeys.IndexOf(C) + 1;
    P := PrivateKey[Z + 1];
    Pos2 := AlphaKeys.IndexOf(P) + 1;
    Pos3 := ((Pos1 + Pos2) Mod AKLen);

    if (Pos1 > 0 = true) and (Pos2 > 0 = true) and (Pos3 > 0 = true) then
         EncryptedData += AlphaKeys[Pos3];

    Z:=Z + 1;
  // end for
  end;

  Result:= EncryptedData;
end;

function Decrypt(Data: String; PrivateKey: String): String;
var
  CleanData: String;
begin
  CleanData := Data.Replace('-', '');
  Result:=CleanData;
end;

// end unit
end.

