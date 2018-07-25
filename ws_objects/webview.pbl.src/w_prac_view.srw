$PBExportHeader$w_prac_view.srw
forward
global type w_prac_view from window
end type
type st_2 from statictext within w_prac_view
end type
type tab_1 from tab within w_prac_view
end type
type tabpage_home from userobject within tab_1
end type
type st_5 from statictext within tabpage_home
end type
type st_4 from statictext within tabpage_home
end type
type st_3 from statictext within tabpage_home
end type
type dw_meetings from datawindow within tabpage_home
end type
type dw_enrolllment from datawindow within tabpage_home
end type
type dw_status from datawindow within tabpage_home
end type
type tabpage_home from userobject within tab_1
st_5 st_5
st_4 st_4
st_3 st_3
dw_meetings dw_meetings
dw_enrolllment dw_enrolllment
dw_status dw_status
end type
type tabpage_de from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_de
end type
type cb_4 from commandbutton within tabpage_de
end type
type cb_3 from commandbutton within tabpage_de
end type
type cb_2 from commandbutton within tabpage_de
end type
type cb_1 from commandbutton within tabpage_de
end type
type dw_detail from datawindow within tabpage_de
end type
type dw_browse from datawindow within tabpage_de
end type
type dw_screen from datawindow within tabpage_de
end type
type tabpage_de from userobject within tab_1
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_detail dw_detail
dw_browse dw_browse
dw_screen dw_screen
end type
type tabpage_docs from userobject within tab_1
end type
type dw_image from datawindow within tabpage_docs
end type
type dw_image_type from datawindow within tabpage_docs
end type
type tabpage_docs from userobject within tab_1
dw_image dw_image
dw_image_type dw_image_type
end type
type tabpage_privs from userobject within tab_1
end type
type tabpage_privs from userobject within tab_1
end type
type tabpage_attest from userobject within tab_1
end type
type tabpage_attest from userobject within tab_1
end type
type tabpage_aggree from userobject within tab_1
end type
type tabpage_aggree from userobject within tab_1
end type
type tab_1 from tab within w_prac_view
tabpage_home tabpage_home
tabpage_de tabpage_de
tabpage_docs tabpage_docs
tabpage_privs tabpage_privs
tabpage_attest tabpage_attest
tabpage_aggree tabpage_aggree
end type
type dw_help from datawindow within w_prac_view
end type
type st_1 from statictext within w_prac_view
end type
type p_logo from picture within w_prac_view
end type
type p_wv_logo from picture within w_prac_view
end type
end forward

global type w_prac_view from window
integer width = 3863
integer height = 2232
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
st_2 st_2
tab_1 tab_1
dw_help dw_help
st_1 st_1
p_logo p_logo
p_wv_logo p_wv_logo
end type
global w_prac_view w_prac_view

forward prototypes
public function integer of_get_help (integer ai_tab, integer ai_screen)
end prototypes

public function integer of_get_help (integer ai_tab, integer ai_screen);dw_help.retrieve(ai_tab,ai_screen)

return 1
end function

on w_prac_view.create
this.st_2=create st_2
this.tab_1=create tab_1
this.dw_help=create dw_help
this.st_1=create st_1
this.p_logo=create p_logo
this.p_wv_logo=create p_wv_logo
this.Control[]={this.st_2,&
this.tab_1,&
this.dw_help,&
this.st_1,&
this.p_logo,&
this.p_wv_logo}
end on

on w_prac_view.destroy
destroy(this.st_2)
destroy(this.tab_1)
destroy(this.dw_help)
destroy(this.st_1)
destroy(this.p_logo)
destroy(this.p_wv_logo)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
	
CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Not Logged In", "Login Failed!")
ELSE
	//MESSAGEBOX("","LOGIN OK")
END IF
end event

event close;DISCONNECT USING SQLCA;
end event

type st_2 from statictext within w_prac_view
integer x = 2587
integer y = 116
integer width = 539
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Log out"
boolean focusrectangle = false
end type

type tab_1 from tab within w_prac_view
integer x = 46
integer y = 288
integer width = 2542
integer height = 1808
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_home tabpage_home
tabpage_de tabpage_de
tabpage_docs tabpage_docs
tabpage_privs tabpage_privs
tabpage_attest tabpage_attest
tabpage_aggree tabpage_aggree
end type

on tab_1.create
this.tabpage_home=create tabpage_home
this.tabpage_de=create tabpage_de
this.tabpage_docs=create tabpage_docs
this.tabpage_privs=create tabpage_privs
this.tabpage_attest=create tabpage_attest
this.tabpage_aggree=create tabpage_aggree
this.Control[]={this.tabpage_home,&
this.tabpage_de,&
this.tabpage_docs,&
this.tabpage_privs,&
this.tabpage_attest,&
this.tabpage_aggree}
end on

on tab_1.destroy
destroy(this.tabpage_home)
destroy(this.tabpage_de)
destroy(this.tabpage_docs)
destroy(this.tabpage_privs)
destroy(this.tabpage_attest)
destroy(this.tabpage_aggree)
end on

event selectionchanged;integer t
integer s = 0

t = newindex
if t = 2 then
	s = 0
	
end if

of_get_help(t,s)
end event

type tabpage_home from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Home"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_5 st_5
st_4 st_4
st_3 st_3
dw_meetings dw_meetings
dw_enrolllment dw_enrolllment
dw_status dw_status
end type

on tabpage_home.create
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.dw_meetings=create dw_meetings
this.dw_enrolllment=create dw_enrolllment
this.dw_status=create dw_status
this.Control[]={this.st_5,&
this.st_4,&
this.st_3,&
this.dw_meetings,&
this.dw_enrolllment,&
this.dw_status}
end on

on tabpage_home.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_meetings)
destroy(this.dw_enrolllment)
destroy(this.dw_status)
end on

type st_5 from statictext within tabpage_home
integer x = 50
integer y = 280
integer width = 507
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Meeting Attandance"
boolean focusrectangle = false
end type

type st_4 from statictext within tabpage_home
integer x = 50
integer y = 196
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Enrollment Status"
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_home
integer x = 50
integer y = 116
integer width = 457
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Application Status"
boolean focusrectangle = false
end type

type dw_meetings from datawindow within tabpage_home
integer x = 562
integer y = 1104
integer width = 1915
integer height = 520
integer taborder = 30
string title = "none"
boolean livescroll = true
end type

type dw_enrolllment from datawindow within tabpage_home
integer x = 562
integer y = 576
integer width = 1915
integer height = 520
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

type dw_status from datawindow within tabpage_home
integer x = 562
integer y = 48
integer width = 1915
integer height = 520
integer taborder = 10
string title = "none"
boolean livescroll = true
end type

type tabpage_de from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Demographics"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_detail dw_detail
dw_browse dw_browse
dw_screen dw_screen
end type

on tabpage_de.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.dw_screen=create dw_screen
this.Control[]={this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_detail,&
this.dw_browse,&
this.dw_screen}
end on

on tabpage_de.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.dw_screen)
end on

type cb_5 from commandbutton within tabpage_de
integer x = 2121
integer y = 8
integer width = 343
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Profile"
end type

type cb_4 from commandbutton within tabpage_de
integer x = 1330
integer y = 8
integer width = 443
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Screen Complete"
end type

type cb_3 from commandbutton within tabpage_de
integer x = 978
integer y = 8
integer width = 343
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_2 from commandbutton within tabpage_de
integer x = 622
integer y = 8
integer width = 343
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_1 from commandbutton within tabpage_de
integer x = 32
integer y = 8
integer width = 576
integer height = 80
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Data Entry Completed"
end type

type dw_detail from datawindow within tabpage_de
integer x = 617
integer y = 424
integer width = 1861
integer height = 1252
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

type dw_browse from datawindow within tabpage_de
integer x = 622
integer y = 104
integer width = 1856
integer height = 304
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

type dw_screen from datawindow within tabpage_de
integer x = 37
integer y = 96
integer width = 562
integer height = 1580
integer taborder = 10
string title = "none"
boolean livescroll = true
end type

type tabpage_docs from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Documents"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_image dw_image
dw_image_type dw_image_type
end type

on tabpage_docs.create
this.dw_image=create dw_image
this.dw_image_type=create dw_image_type
this.Control[]={this.dw_image,&
this.dw_image_type}
end on

on tabpage_docs.destroy
destroy(this.dw_image)
destroy(this.dw_image_type)
end on

type dw_image from datawindow within tabpage_docs
integer x = 777
integer y = 44
integer width = 1477
integer height = 1540
integer taborder = 20
string title = "none"
boolean livescroll = true
end type

type dw_image_type from datawindow within tabpage_docs
integer x = 27
integer y = 44
integer width = 695
integer height = 1540
integer taborder = 30
string title = "none"
boolean livescroll = true
end type

type tabpage_privs from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Privileges"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_attest from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Attestation Questions"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type tabpage_aggree from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2505
integer height = 1692
long backcolor = 16777215
string text = "Aggreements"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
end type

type dw_help from datawindow within w_prac_view
integer x = 2601
integer y = 388
integer width = 1175
integer height = 1704
integer taborder = 10
string title = "none"
string dataobject = "d_wv_help_detail"
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type st_1 from statictext within w_prac_view
integer x = 2587
integer y = 36
integer width = 539
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Change Password"
boolean focusrectangle = false
end type

type p_logo from picture within w_prac_view
integer x = 937
integer y = 28
integer width = 1093
integer height = 260
string picturename = "C:\ISGDev\ver14.2\ISG email logo.gif"
boolean focusrectangle = false
end type

type p_wv_logo from picture within w_prac_view
integer x = 18
integer y = 32
integer width = 494
integer height = 104
string picturename = "logo.png"
boolean focusrectangle = false
end type

