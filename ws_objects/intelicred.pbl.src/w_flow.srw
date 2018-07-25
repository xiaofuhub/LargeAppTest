$PBExportHeader$w_flow.srw
forward
global type w_flow from Window
end type
type cb_13 from commandbutton within w_flow
end type
type cb_12 from commandbutton within w_flow
end type
type cb_11 from commandbutton within w_flow
end type
type cb_10 from commandbutton within w_flow
end type
type cb_9 from commandbutton within w_flow
end type
type cb_8 from commandbutton within w_flow
end type
type cb_7 from commandbutton within w_flow
end type
type cb_6 from commandbutton within w_flow
end type
type cb_5 from commandbutton within w_flow
end type
type cb_4 from commandbutton within w_flow
end type
type cb_3 from commandbutton within w_flow
end type
type cb_2 from commandbutton within w_flow
end type
type cb_1 from commandbutton within w_flow
end type
end forward

global type w_flow from Window
int X=823
int Y=360
int Width=2610
int Height=1664
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_flow w_flow

on w_flow.create
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_13,&
this.cb_12,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_7,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_flow.destroy
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

type cb_13 from commandbutton within w_flow
int X=119
int Y=332
int Width=763
int Height=108
int TabOrder=40
string Text="IntelliApp"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_12 from commandbutton within w_flow
int X=119
int Y=192
int Width=763
int Height=108
int TabOrder=30
string Text="Expiring Credentials Tracking"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_11 from commandbutton within w_flow
int X=119
int Y=52
int Width=763
int Height=108
int TabOrder=20
string Text="Credentials Verification"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_10 from commandbutton within w_flow
int X=1349
int Y=1340
int Width=763
int Height=108
int TabOrder=120
string Text="Print Correspondence Letter"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_9 from commandbutton within w_flow
int X=1344
int Y=1200
int Width=763
int Height=108
int TabOrder=110
string Text="Print Credentialing Application"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_8 from commandbutton within w_flow
int X=1344
int Y=1056
int Width=763
int Height=108
int TabOrder=100
string Text="Recieve From Committee"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_7 from commandbutton within w_flow
int X=1344
int Y=916
int Width=763
int Height=108
int TabOrder=90
string Text="Send to Committee"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_6 from commandbutton within w_flow
int X=1344
int Y=780
int Width=763
int Height=108
int TabOrder=80
string Text="Post Verification Result"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_5 from commandbutton within w_flow
int X=1344
int Y=636
int Width=763
int Height=108
int TabOrder=70
string Text="Recieve Verification Letter Back"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_4 from commandbutton within w_flow
int X=1344
int Y=488
int Width=763
int Height=108
int TabOrder=60
string Text="Print Verification Letters"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_3 from commandbutton within w_flow
int X=1344
int Y=340
int Width=763
int Height=108
int TabOrder=50
string Text="Recieve an application audit item"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_2 from commandbutton within w_flow
int X=1344
int Y=192
int Width=763
int Height=108
int TabOrder=40
string Text="Edit Physhician"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_flow
int X=1344
int Y=44
int Width=763
int Height=108
int TabOrder=10
string Text="Enter New Phycian"
int TextSize=-8
int Weight=400
string FaceName="Segoe UI"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

