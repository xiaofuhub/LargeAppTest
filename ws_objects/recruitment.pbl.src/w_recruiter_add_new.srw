$PBExportHeader$w_recruiter_add_new.srw
forward
global type w_recruiter_add_new from w_popup
end type
type cb_1 from commandbutton within w_recruiter_add_new
end type
type cb_close from commandbutton within w_recruiter_add_new
end type
type dw_detail from u_dw within w_recruiter_add_new
end type
end forward

global type w_recruiter_add_new from w_popup
integer width = 1678
integer height = 1204
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
cb_1 cb_1
cb_close cb_close
dw_detail dw_detail
end type
global w_recruiter_add_new w_recruiter_add_new

type variables
boolean ab_new = false
end variables

on w_recruiter_add_new.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_detail=create dw_detail
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_detail
end on

on w_recruiter_add_new.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_detail)
end on

event open;call super::open;dw_detail.settransobject(sqlca)
dw_detail.insertrow(1)

end event

type cb_1 from commandbutton within w_recruiter_add_new
integer x = 384
integer y = 1048
integer width = 393
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;
long rid

select max(rec_id)	 into :rid from recruit_recruiters;
if isnull(rid) then rid = 0
rid++
dw_detail.setitem(1, "rec_id", rid)
	
dw_detail.update()

closewithreturn(parent,rid)
end event

type cb_close from commandbutton within w_recruiter_add_new
integer x = 805
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type dw_detail from u_dw within w_recruiter_add_new
integer width = 1664
integer height = 1036
integer taborder = 60
boolean titlebar = true
string title = "Recruiter/Member"
string dataobject = "d_recruiters_detail"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

