$PBExportHeader$w_demo.srw
forward
global type w_demo from Window
end type
type dw_1 from datawindow within w_demo
end type
type cb_4 from commandbutton within w_demo
end type
type cb_3 from commandbutton within w_demo
end type
type cb_2 from commandbutton within w_demo
end type
type cb_1 from commandbutton within w_demo
end type
end forward

global type w_demo from Window
int X=823
int Y=360
int Width=2318
int Height=1364
boolean TitleBar=true
string Title="Untitled"
long BackColor=15780518
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_1 dw_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_demo w_demo

on w_demo.create
this.dw_1=create dw_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_demo.destroy
destroy(this.dw_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_demo
int X=338
int Y=296
int Width=494
int Height=360
int TabOrder=20
string DataObject="d_pd_affil_status_cvo_data"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

type cb_4 from commandbutton within w_demo
int X=55
int Y=368
int Width=2149
int Height=212
int TabOrder=40
string Text="Sample Screen Shots"
int TextSize=-24
int Weight=700
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_demo
int X=55
int Y=940
int Width=2153
int Height=212
int TabOrder=30
string Text="Run PcAnywhere Install"
int TextSize=-24
int Weight=700
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_demo
int X=55
int Y=656
int Width=2153
int Height=212
int TabOrder=20
string Text="View Sample Report"
int TextSize=-24
int Weight=700
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_demo
int X=55
int Y=80
int Width=2153
int Height=212
int TabOrder=10
string Text="View Powerpoint Presentation"
int TextSize=-24
int Weight=700
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String ls_val

ls_val = dw_1.Describe( "custom_4.coltype" )
messagebox("", ls_val)


end event

