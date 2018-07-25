$PBExportHeader$w_listen.srw
forward
global type w_listen from Window
end type
type cb_1 from commandbutton within w_listen
end type
end forward

global type w_listen from Window
int X=823
int Y=360
int Width=2016
int Height=1208
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_1 cb_1
end type
global w_listen w_listen

on w_listen.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on w_listen.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within w_listen
int X=777
int Y=356
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

event clicked;Integer li_retval
//
//transport mytransport
//
//mytransport = create transport
//mytransport.driver = "WinSock"
//mytransport.application = "iverify"
//
//li_retval = mytransport.Listen()
//
//messagebox("", li_retval)
end event

