$PBExportHeader$w_u_temp.srw
forward
global type w_u_temp from Window
end type
type sle_1 from singlelineedit within w_u_temp
end type
type cb_1 from commandbutton within w_u_temp
end type
end forward

global type w_u_temp from Window
int X=1056
int Y=484
int Width=1554
int Height=556
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
sle_1 sle_1
cb_1 cb_1
end type
global w_u_temp w_u_temp

on w_u_temp.create
this.sle_1=create sle_1
this.cb_1=create cb_1
this.Control[]={this.sle_1,&
this.cb_1}
end on

on w_u_temp.destroy
destroy(this.sle_1)
destroy(this.cb_1)
end on

type sle_1 from singlelineedit within w_u_temp
int X=283
int Y=80
int Width=869
int Height=92
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_u_temp
int X=549
int Y=276
int Width=247
int Height=108
int TabOrder=10
string Text="none"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;

if fileexists(sle_1.text) then
	messagebox("TEST","OK")
else
	messagebox("TEST","Failed")
end if
end event

