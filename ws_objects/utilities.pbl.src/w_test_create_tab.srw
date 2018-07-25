$PBExportHeader$w_test_create_tab.srw
forward
global type w_test_create_tab from Window
end type
type tab_1 from u_tab_test within w_test_create_tab
end type
type cb_1 from commandbutton within w_test_create_tab
end type
type tab_1 from u_tab_test within w_test_create_tab
end type
end forward

global type w_test_create_tab from Window
int X=1056
int Y=484
int Width=2569
int Height=1516
boolean TitleBar=true
string Title="Untitled"
long BackColor=67108864
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
tab_1 tab_1
cb_1 cb_1
end type
global w_test_create_tab w_test_create_tab

on w_test_create_tab.create
this.tab_1=create tab_1
this.cb_1=create cb_1
this.Control[]={this.tab_1,&
this.cb_1}
end on

on w_test_create_tab.destroy
destroy(this.tab_1)
destroy(this.cb_1)
end on

type tab_1 from u_tab_test within w_test_create_tab
int X=137
int Y=80
int TabOrder=20
boolean CreateOnDemand=true
end type

type cb_1 from commandbutton within w_test_create_tab
int X=151
int Y=352
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

event clicked;IF tab_1.CreateOnDemand = True THEN
//
IF tab_1.tabpage_2.PageCreated() = False THEN
		tab_1.tabpage_2.CreatePage()
END IF

IF tab_1.tabpage_3.PageCreated() = False THEN
		tab_1.tabpage_3.CreatePage()
END IF

END IF
end event

