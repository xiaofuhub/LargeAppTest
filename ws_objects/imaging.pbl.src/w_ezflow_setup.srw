$PBExportHeader$w_ezflow_setup.srw
forward
global type w_ezflow_setup from w_response
end type
type dw_1 from u_dw within w_ezflow_setup
end type
type cb_1 from commandbutton within w_ezflow_setup
end type
type cb_2 from commandbutton within w_ezflow_setup
end type
end forward

global type w_ezflow_setup from w_response
int Width=2738
int Height=492
boolean TitleBar=true
string Title="EZ-Flow Setup"
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
end type
global w_ezflow_setup w_ezflow_setup

on w_ezflow_setup.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_ezflow_setup.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;dw_1.of_SetTransObject( SQLCA )
dw_1.Retrieve( Message.DoubleParm )
end event

type dw_1 from u_dw within w_ezflow_setup
int X=14
int Y=40
int Width=2674
int Height=220
int TabOrder=10
boolean BringToTop=true
string DataObject="d_ezflow_setup"
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
boolean LiveScroll=false
end type

type cb_1 from commandbutton within w_ezflow_setup
int X=2062
int Y=276
int Width=270
int Height=76
int TabOrder=20
boolean BringToTop=true
string Text="Ok"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_1.Update( )

Close( Parent )
end event

type cb_2 from commandbutton within w_ezflow_setup
int X=2354
int Y=276
int Width=270
int Height=76
int TabOrder=30
boolean BringToTop=true
string Text="Cancel"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close( Parent )
end event

