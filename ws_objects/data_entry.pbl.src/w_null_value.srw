$PBExportHeader$w_null_value.srw
forward
global type w_null_value from Window
end type
type st_1 from statictext within w_null_value
end type
type cb_2 from commandbutton within w_null_value
end type
type cb_1 from commandbutton within w_null_value
end type
end forward

global type w_null_value from Window
int X=823
int Y=360
int Width=887
int Height=560
boolean TitleBar=true
string Title="Untitled"
long BackColor=80269524
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
cb_2 cb_2
cb_1 cb_1
end type
global w_null_value w_null_value

on w_null_value.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1}
end on

on w_null_value.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_null_value
int X=133
int Y=64
int Width=672
int Height=120
boolean Enabled=false
string Text="Set value null?"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-14
int Weight=700
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_null_value
int X=457
int Y=276
int Width=247
int Height=108
int TabOrder=20
string Text="Cancel"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,0)
end event

type cb_1 from commandbutton within w_null_value
int X=119
int Y=276
int Width=247
int Height=108
int TabOrder=10
string Text="Yes"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer col

col = message.doubleparm




closewithreturn(parent,1)
end event

