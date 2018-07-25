$PBExportHeader$u_to_open.sru
forward
global type u_to_open from UserObject
end type
type cb_1 from commandbutton within u_to_open
end type
end forward

global type u_to_open from UserObject
int Width=686
int Height=360
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
cb_1 cb_1
end type
global u_to_open u_to_open

on u_to_open.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on u_to_open.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within u_to_open
int X=55
int Y=96
int Width=247
int Height=108
int TabOrder=10
string Text="none"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

