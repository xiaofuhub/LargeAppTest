$PBExportHeader$w_security_quest_select.srw
forward
global type w_security_quest_select from window
end type
type cb_1 from commandbutton within w_security_quest_select
end type
type cb_close from commandbutton within w_security_quest_select
end type
type dw_1 from datawindow within w_security_quest_select
end type
end forward

global type w_security_quest_select from window
integer width = 2693
integer height = 1824
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_close cb_close
dw_1 dw_1
end type
global w_security_quest_select w_security_quest_select

on w_security_quest_select.create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_close,&
this.dw_1}
end on

on w_security_quest_select.destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_1)
end on

event open; //Start Code Change ----12.10.2015 #V15 maha - new window
 string ls_path
 
dw_1.settransobject(sqlca)
dw_1.retrieve()

if dw_1.rowcount() = 0 then
	ls_path = gs_dir_path + "security question data.txt"
	
	if fileexists(ls_path) then
		//messagebox("",ls_path)
		dw_1.importfile( ls_path)
	end if
end if


	
	
end event

type cb_1 from commandbutton within w_security_quest_select
integer x = 1115
integer y = 8
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;long qid

qid = dw_1.getitemnumber( dw_1.getrow(), "quest_id")


closewithreturn(parent,qid)
end event

type cb_close from commandbutton within w_security_quest_select
integer x = 2304
integer y = 8
integer width = 343
integer height = 84
integer taborder = 10
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

type dw_1 from datawindow within w_security_quest_select
integer x = 18
integer y = 116
integer width = 2661
integer height = 1696
integer taborder = 10
string title = "none"
string dataobject = "d_security_quest_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;
this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event doubleclicked;cb_1.triggerevent(clicked!)
end event

