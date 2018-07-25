$PBExportHeader$w_reportname_search.srw
forward
global type w_reportname_search from window
end type
type cb_1 from commandbutton within w_reportname_search
end type
type cb_select from commandbutton within w_reportname_search
end type
type cb_find from commandbutton within w_reportname_search
end type
type dw_1 from datawindow within w_reportname_search
end type
type st_find from statictext within w_reportname_search
end type
type sle_1 from singlelineedit within w_reportname_search
end type
end forward

global type w_reportname_search from window
integer width = 1893
integer height = 1768
boolean titlebar = true
string title = "Find Report"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_select cb_select
cb_find cb_find
dw_1 dw_1
st_find st_find
sle_1 sle_1
end type
global w_reportname_search w_reportname_search

on w_reportname_search.create
this.cb_1=create cb_1
this.cb_select=create cb_select
this.cb_find=create cb_find
this.dw_1=create dw_1
this.st_find=create st_find
this.sle_1=create sle_1
this.Control[]={this.cb_1,&
this.cb_select,&
this.cb_find,&
this.dw_1,&
this.st_find,&
this.sle_1}
end on

on w_reportname_search.destroy
destroy(this.cb_1)
destroy(this.cb_select)
destroy(this.cb_find)
destroy(this.dw_1)
destroy(this.st_find)
destroy(this.sle_1)
end on

event open;sle_1.setfocus()
end event

type cb_1 from commandbutton within w_reportname_search
integer x = 1481
integer y = 1552
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_select from commandbutton within w_reportname_search
integer x = 1125
integer y = 1552
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Select"
end type

event clicked;long id
integer r

r = dw_1.getrow()

if r > 0 then
	id = dw_1.getitemnumber(r,"view_id")
end if
	
Closewithreturn(parent,id)	

end event

type cb_find from commandbutton within w_reportname_search
integer x = 1431
integer y = 156
integer width = 256
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Find"
end type

event clicked;string s
integer rc

s = sle_1.text

if LenA(s) < 1 then 
	messagebox("Search Value","You have not entered a search value.")
	return
else
	dw_1.settransobject(sqlca)
	rc = dw_1.retrieve(s)
	if rc > 0 then dw_1.selectrow(1,true)
	
end if
end event

type dw_1 from datawindow within w_reportname_search
integer x = 55
integer y = 268
integer width = 1778
integer height = 1264
integer taborder = 20
string title = "none"
string dataobject = "d_cust_report_search"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;integer i

i = this.getclickedrow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.26.2006 By: Rodger Wu
//$<reason> Fix a defect. 
/* if i > 1 then */
if i >= 1 then
//---------------------------- APPEON END ----------------------------
	this.setrow(i)
end if
end event

event rowfocuschanged;integer i

i = this.getrow()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.26.2006 By: Rodger Wu
//$<reason> Fix a defect. 
/* if i > 1 then */
if i >= 1 then
//---------------------------- APPEON END ----------------------------
	this.selectrow( 0, false)
	this.selectrow( i, true)
end if
	
	
end event

event doubleclicked;cb_select.triggerevent(clicked!)
end event

type st_find from statictext within w_reportname_search
integer x = 549
integer y = 84
integer width = 809
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Enter search value and click Find"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_reportname_search
integer x = 521
integer y = 156
integer width = 891
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

