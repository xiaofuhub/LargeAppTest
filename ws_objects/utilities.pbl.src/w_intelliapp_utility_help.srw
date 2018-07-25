$PBExportHeader$w_intelliapp_utility_help.srw
forward
global type w_intelliapp_utility_help from Window
end type
type cb_1 from commandbutton within w_intelliapp_utility_help
end type
type st_1 from statictext within w_intelliapp_utility_help
end type
end forward

global type w_intelliapp_utility_help from Window
int X=1056
int Y=484
int Width=2103
int Height=368
boolean TitleBar=true
string Title="Help"
long BackColor=80269524
cb_1 cb_1
st_1 st_1
end type
global w_intelliapp_utility_help w_intelliapp_utility_help

on w_intelliapp_utility_help.create
this.cb_1=create cb_1
this.st_1=create st_1
this.Control[]={this.cb_1,&
this.st_1}
end on

on w_intelliapp_utility_help.destroy
destroy(this.cb_1)
destroy(this.st_1)
end on

type cb_1 from commandbutton within w_intelliapp_utility_help
int X=1769
int Y=76
int Width=247
int Height=108
int TabOrder=10
string Text="Close"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;Close( Parent )
end event

type st_1 from statictext within w_intelliapp_utility_help
int X=37
int Y=28
int Width=1659
int Height=356
boolean Enabled=false
string Text="Use this utility to check and see if there are query values in IntelliApp fields mappings that do not have data associated with them in a lookup table.  This will avoid any Data Window Child errors."
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

