unit ulicense;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, md5, math, lazlogger;

const
  AlphaKeys : String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';

function GeneratePrivateKey(L: LongInt): String;
function GenerateLicenseKey(Data: String; PrivateKey: String): String;

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

function GenerateLicenseKey(Data: String; PrivateKey: String): String;
var
  C, P, Key, EncryptedData, LicenseKey: String;
  I, Pos1, Pos2, Pos3, Z, SrcLen: Integer;
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

  Key:=Uppercase(MD5Print(MD5String(Data)));
  DebugLn('MD5=' + Key);

  SrcLen:= Length(Key);
  Z := 0;
  For I:= 0 to SrcLen - 1 do
  begin
    C := Key[I + 1];
    Pos1 := AlphaKeys.IndexOf(C) + 1;
    P := PrivateKey[Z + 1];
    Pos2 := AlphaKeys.IndexOf(P) + 1;
    Pos3 := ((Pos1 + Pos2) Mod Length(AlphaKeys)) - 1;

    if (Pos1 > -1 = true) and (Pos2 > -1 = true) and (Pos3 > -1 = true) then
       EncryptedData:= EncryptedData + AlphaKeys[Pos3 + 1];

    Z:=Z + 1;
  // end for
  end;

  I:=1;
  SrcLen:= Length(EncryptedData);
  // now we split the encrypted data
  while I <= srcLen do
  begin
    if SrcLen - I >= 5 then
       begin
         LicenseKey += uppercase(Copy(EncryptedData, I, 5));
         if SrcLen - I >= 10 then
            LicenseKey += '-';
			 end;
    Inc(I, 5);
	end;

  Result:=LicenseKey;
//end function
end;

// end unit
end.

