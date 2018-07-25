$PBExportHeader$w_imp_type.srw
forward
global type w_imp_type from Window
end type
type st_1 from statictext within w_imp_type
end type
type cb_3 from commandbutton within w_imp_type
end type
type cb_2 from commandbutton within w_imp_type
end type
type cb_1 from commandbutton within w_imp_type
end type
end forward

global type w_imp_type from Window
int X=827
int Y=612
int Width=2089
int Height=716
boolean TitleBar=true
string Title="Import type"
long BackColor=79741120
boolean ControlMenu=true
WindowType WindowType=response!
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_imp_type w_imp_type

on w_imp_type.create
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_imp_type.destroy
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type st_1 from statictext within w_imp_type
int X=18
int Y=152
int Width=1874
int Height=144
boolean Enabled=false
string Text="Appending records or replacing?"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-16
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_imp_type
int X=1280
int Y=400
int Width=247
int Height=108
int TabOrder=30
string Text="Cancel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,'C')
end event

type cb_2 from commandbutton within w_imp_type
int X=773
int Y=400
int Width=315
int Height=108
int TabOrder=20
string Text="Replacing"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,'R')
end event

type cb_1 from commandbutton within w_imp_type
int X=288
int Y=400
int Width=334
int Height=108
int TabOrder=10
string Text="Appending"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;closewithreturn(parent,'A')
end event

