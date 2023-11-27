{ @author: Sylvain Maltais (support@gladir.com)
  @created: 1993
  @website(https://www.gladir.com/CODER/GRAPHICSSOLUTIONLIB-TP)
  @abstract(Target: Turbo Pascal 7)
}

Unit MODES;

INTERFACE

Procedure GSColors640x200_4Colors;
Procedure GSColors320x200_16Colors;
Procedure GSColors640x200_16Colors;
Procedure GSEmul320x200_16Colors;
Procedure GSEmul640x200_4Colors;
Procedure GSEmul640x200_16Colors;
Procedure GSEmulTextModeC132x25;
Procedure GSTextMode80x25;
Procedure GSTextModeC132x25;

IMPLEMENTATION

Type
 PresentInfoVideoMode=Record
  IBMLogical:Boolean;
  BiosSupport:Boolean;
  Color:Boolean;
  Graphics:Boolean;
  SegVideo:Word;
  HeightChar:Byte;
  NumXPixels:Word;
  NumYPixels:Word;
  NumXTexts:Byte;
  NumYTexts:Byte;
  NumVideoPages:Byte;
  NumColors:LongInt;
  BitsPerPixel:Byte;
  BytesPerLine:Word;
  Page:Byte;
  AddrPage:Word;
  ShowPage:Byte;
 End;

Const
 GS_C80x25:PresentInfoVideoMode=(
  IBMLogical:True;
  BIOSSupport:True;
  Color:True;
  Graphics:False;
  SegVideo:$B800;
  HeightChar:8;
  NumXPixels:640;
  NumYPixels:200;
  NumXTexts:80;
  NumYTexts:25;
  NumVideoPages:4;
  NumColors:16;
  BitsPerPixel:0;
  BytesPerLine:80 * 2
 );

 GS_C132x25:PresentInfoVideoMode=(
  IBMLogical:True;
  BIOSSupport:False;
  Color:True;
  Graphics:False;
  SegVideo:$B800;
  HeightChar:8;
  NumXPixels:660;
  NumYPixels:200;
  NumXTexts:132;
  NumYTexts:25;
  NumVideoPages:2;
  NumColors:16;
  BitsPerPixel:0;
  BytesPerLine:132 * 2
 );

 GS_640x200_4Colors:PresentInfoVideoMode=(
  IBMLogical:True;
  BIOSSupport:False;
  Color:True;
  Graphics:True;
  SegVideo:$B800;
  HeightChar:8;
  NumXPixels:640;
  NumYPixels:200;
  NumXTexts:80;
  NumYTexts:25;
  NumVideoPages:1;
  NumColors:4;
  BitsPerPixel:2;
  BytesPerLine:640 div (8 div 2)
 );

 GS_320x200_16Colors:PresentInfoVideoMode=(
  IBMLogical:True;
  BIOSSupport:False;
  Color:True;
  Graphics:True;
  SegVideo:$B800;
  HeightChar:8;
  NumXPixels:320;
  NumYPixels:200;
  NumXTexts:40;
  NumYTexts:25;
  NumVideoPages:1;
  NumColors:16;
  BitsPerPixel:4;
  BytesPerLine:320 div (8 div 4)
 );

 GS_640x200_16Colors:PresentInfoVideoMode=(
  IBMLogical:True;
  BIOSSupport:False;
  Color:True;
  Graphics:True;
  SegVideo:$B000;
  HeightChar:8;
  NumXPixels:640;
  NumYPixels:200;
  NumXTexts:80;
  NumYTexts:25;
  NumVideoPages:1;
  NumColors:16;
  BitsPerPixel:4;
  BytesPerLine:640 div (8 div 4)
 );

Procedure GSEmul320x200_16Colors;
Const
 Parms:Array[0..15] of Byte=($36,$28,$2D,$08,$64,$06,$64,$64,
		             $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$10;
 Port[$3DF]:=$A2;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DF]:=$A0;
 Port[$3DD]:=$10;
End;

Procedure GSEmul640x200_4Colors;
Const
 Parms:Array[0..15] of Byte=($36,$28,$2D,$08,$64,$06,$64,$64,
                             $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$20;
 Port[$3DF]:=$A2;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DF]:=$A0;
 Port[$3DD]:=$20;
End;

Procedure GSEmul640x200_16Colors;
Const
 Parms:Array[0..15] of Byte=($61,$50,$52,$08,$32,$06,$32,$32,
			     $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$80;
 Port[$3DF]:=$A2;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DF]:=$A0;
 Port[$3DD]:=$80;
End;

Procedure GSColors320x200_16Colors;
Const
 Parms:Array[0..15] of Byte=($38,$28,$2D,$0A,$7F,$06,$64,$70,
			     $02,$01,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$10;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DD]:=$10;
End;

Procedure GSColors640x200_4Colors;
Const
 Parms:Array[0..15] of Byte=($38,$28,$2D,$0A,$7F,$06,$64,$70,
			     $02,$01,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$20;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DD]:=$20;
End;

Procedure GSColors640x200_16Colors;
Const
 Parms:Array[0..15] of Byte=($70,$50,$58,$0A,$40,$06,$32,$38,
			     $02,$03,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$80;
 Port[$3D8]:=$02;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0A;
 Port[$3D9]:=$30;
 Port[$3DD]:=$80;
End;

Procedure GSTextMode80x25;
Const
 Parms:Array[0..15] of Byte=($71,$50,$5A,$0A,$1F,$06,$19,$1C,
                             $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$00;
 Port[$3D8]:=$25;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$2D;
 Port[$3D9]:=$30;
 Port[$3DD]:=$00;
End;

Procedure GSTextModeC132x25;
Const
 Parms:Array[0..15] of Byte=($B5,$84,$97,$0A,$1F,$06,$19,$1C,
			     $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$00;
 Port[$3D8]:=$05;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0D;
 Port[$3D9]:=$30;
 Port[$3DD]:=$00;
 Port[$3DF]:=$90;
End;

Procedure GSEmulTextModeC132x25;
Const
 Parms:Array[0..15] of Byte=($B5,$84,$97,$0A,$1F,$06,$19,$1C,
			     $02,$07,$06,$07,$00,$00,$00,$00);
Var
 I:Byte;
Begin
 Port[$3D8]:=$02;
 Port[$3DD]:=$00;
 Port[$3D8]:=$05;
 For I:=0 to 15 do Begin
  Port[$3D4]:=I;
  Port[$3D5]:=Parms[I];
 End;
 Port[$3D8]:=$0D;
 Port[$3D9]:=$30;
 Port[$3DD]:=$00;
 Port[$3DF]:=$A8;
End;

END.