$PBExportHeader$w_web_look.srw
forward
global type w_web_look from Window
end type
type d_1 from datawindow within w_web_look
end type
end forward

global type w_web_look from Window
int X=823
int Y=360
int Width=3506
int Height=2008
boolean TitleBar=true
string Title="Untitled"
long BackColor=16777215
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
d_1 d_1
end type
global w_web_look w_web_look

on w_web_look.create
this.d_1=create d_1
this.Control[]={this.d_1}
end on

on w_web_look.destroy
destroy(this.d_1)
end on

type d_1 from datawindow within w_web_look
int Width=3424
int Height=1860
int TabOrder=10
string DataObject="d_web_blue"
boolean Border=false
boolean LiveScroll=true
end type

