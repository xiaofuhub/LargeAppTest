$PBExportHeader$w_select_checklist.srw
forward
global type w_select_checklist from window
end type
type st_1 from statictext within w_select_checklist
end type
type cb_close from commandbutton within w_select_checklist
end type
type cb_ok from commandbutton within w_select_checklist
end type
type dw_1 from datawindow within w_select_checklist
end type
end forward

global type w_select_checklist from window
integer width = 1019
integer height = 348
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_close cb_close
cb_ok cb_ok
dw_1 dw_1
end type
global w_select_checklist w_select_checklist

type variables
long il_temp = 0
end variables

on w_select_checklist.create
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_close,&
this.cb_ok,&
this.dw_1}
end on

on w_select_checklist.destroy
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open; //Start Code Change ----10.20.2015 #V15 maha
string s
datawindowchild dwchild

s = message.stringparm

choose case s
	case "recruit"
		dw_1.dataobject = "d_select_checklist"
	case "review"
		dw_1.dataobject = "d_select_checklist_review"
end choose

dw_1.settransobject(sqlca)
//dw_1.retrieve()
dw_1.insertrow(0) // (Appeon)Harry 03.31.2016 for BugH032503

dw_1.getchild( "template_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.insertrow(1)
dwchild.setitem(1, "template_id", 0)
dw_1.setitem(1, "template_id", 0)
end event

type st_1 from statictext within w_select_checklist
integer x = 50
integer y = 24
integer width = 375
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Checklist"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_select_checklist
integer x = 517
integer y = 192
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_ok from commandbutton within w_select_checklist
integer x = 155
integer y = 192
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;closewithreturn(parent,il_temp)
end event

type dw_1 from datawindow within w_select_checklist
integer x = 59
integer y = 96
integer width = 891
integer height = 76
integer taborder = 10
string title = "none"
string dataobject = "d_select_checklist"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_temp = long(data)

end event

