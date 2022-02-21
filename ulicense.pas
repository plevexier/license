unit ulicense;

{$mode ObjFPC}{$H+}

interface

uses
    Classes, SysUtils, blowfish, base64, math;

const
  AlphaKeys : String = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz;0123456789';

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
  Enc: TBlowFishEncryptStream;
  S1,S2: TStringStream;
begin
  S1:=TStringStream.Create(Data);
  S2:=TStringStream.Create('');
  Enc:=TBlowfishEncryptStream.Create(PrivateKey, s2);
  Enc.WriteAnsiString(Data);
  Enc.free;

  result:=EncodeStringBase64(S2.datastring);
end;

function Decrypt(Data: String; PrivateKey: String): String;
var
  Dec: TBlowFishDeCryptStream;
  S1,S2: TStringStream;
begin
  S1 := TStringStream.Create(DecodeStringBase64(Data));
  Dec := TBlowFishDeCryptStream.Create(PrivateKey,S1);
  Result:=Dec.ReadAnsiString;
end;

// end unit
end.

