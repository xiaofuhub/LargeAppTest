$PBExportHeader$w_web_browse.srw
forward
global type w_web_browse from window
end type
type st_not from statictext within w_web_browse
end type
type rb_down from radiobutton within w_web_browse
end type
type rb_up from radiobutton within w_web_browse
end type
type cb_find from commandbutton within w_web_browse
end type
type st_1 from statictext within w_web_browse
end type
type sle_1 from singlelineedit within w_web_browse
end type
type cb_close from commandbutton within w_web_browse
end type
type dw_1 from datawindow within w_web_browse
end type
type cb_go from commandbutton within w_web_browse
end type
end forward

global type w_web_browse from window
integer x = 645
integer y = 112
integer width = 1760
integer height = 2020
boolean titlebar = true
string title = "Browse Web"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
st_not st_not
rb_down rb_down
rb_up rb_up
cb_find cb_find
st_1 st_1
sle_1 sle_1
cb_close cb_close
dw_1 dw_1
cb_go cb_go
end type
global w_web_browse w_web_browse

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

on w_web_browse.create
this.st_not=create st_not
this.rb_down=create rb_down
this.rb_up=create rb_up
this.cb_find=create cb_find
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_close=create cb_close
this.dw_1=create dw_1
this.cb_go=create cb_go
this.Control[]={this.st_not,&
this.rb_down,&
this.rb_up,&
this.cb_find,&
this.st_1,&
this.sle_1,&
this.cb_close,&
this.dw_1,&
this.cb_go}
end on

on w_web_browse.destroy
destroy(this.st_not)
destroy(this.rb_down)
destroy(this.rb_up)
destroy(this.cb_find)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.cb_go)
end on

type st_not from statictext within w_web_browse
boolean visible = false
integer x = 1330
integer y = 32
integer width = 384
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Not Found"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_down from radiobutton within w_web_browse
integer x = 1161
integer y = 148
integer width = 247
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Down"
boolean checked = true
end type

type rb_up from radiobutton within w_web_browse
integer x = 1161
integer y = 84
integer width = 247
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Up"
end type

type cb_find from commandbutton within w_web_browse
integer x = 1472
integer y = 108
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;string s
long r
//long click
st_not.visible = false
s = sle_1.text
s = lower(s)

if LenA(s) < 1 then return

s = "lower(web_address) like '%" + s + "%'"
//messagebox("s",s)
if rb_up.checked then
	r = dw_1.find(s,dw_1.getrow() - 1,1)
else
	r = dw_1.find(s,dw_1.getrow() + 1,dw_1.rowcount())
end if
if r > 1 then 
	dw_1.scrolltorow(r)
	dw_1.setrow(r)
	dw_1.selectrow(0,false)
	dw_1.selectrow(r,true)
else
	st_not.visible = true
end if
end event

type st_1 from statictext within w_web_browse
integer x = 23
integer y = 36
integer width = 293
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Search for:"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_web_browse
event ue_keydown pbm_keydown
integer x = 23
integer y = 104
integer width = 1125
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

event ue_keydown;if Key = KeyEnter! then
	cb_Find.TriggerEvent(Clicked!)
end if

end event

type cb_close from commandbutton within w_web_browse
integer x = 1472
integer y = 1828
integer width = 247
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(parent)
end event

type dw_1 from datawindow within w_web_browse
integer x = 23
integer y = 232
integer width = 1696
integer height = 1572
integer taborder = 20
string dataobject = "d_web_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;long l

l = this.getclickedrow()
this.setrow(l)
this.selectrow(0,false)
this.selectrow(l,true)
end event

event doubleclicked;cb_go.triggerevent(clicked!)
end event

type cb_go from commandbutton within w_web_browse
integer x = 1198
integer y = 1828
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Go"
end type

event clicked;integer p
String ls_url
inet iinet_base


ls_url = dw_1.getitemstring(dw_1.getrow(),"web_address")

if LenA(ls_url) < 6 then 
	messagebox("Error","Invalid URL")
	return
end if

if gi_citrix = 1 then
	of_open_web(ls_url)
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.23.2006 By: Liang QingShi
	//$<reason>  GetContextService is currently unsupported. 
	//$<modification> Replace GetContextService with ShellExecuteA to provide the
	//$<modification> same functionality.
	/*
	GetContextService("Internet", iinet_base)
	iinet_base.HyperlinkToURL(ls_url)
	*/
	String ls_null
	setnull(ls_null)
	//---------Begin Modified by (Appeon)Harry 04.27.2015 for Keep Everything under One Browser--------
	//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)
	ShellExecuteA (Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4)
	//---------End Modfiied ------------------------------------------------------
	
	//---------------------------- APPEON END ----------------------------
	
end if



end event

