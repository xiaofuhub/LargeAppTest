$PBExportHeader$w_qa_profile_select.srw
forward
global type w_qa_profile_select from window
end type
type dw_1 from datawindow within w_qa_profile_select
end type
type cb_close from commandbutton within w_qa_profile_select
end type
type cb_select from commandbutton within w_qa_profile_select
end type
end forward

global type w_qa_profile_select from window
integer width = 2615
integer height = 1176
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_close cb_close
cb_select cb_select
end type
global w_qa_profile_select w_qa_profile_select

event open;long ll_prac
long ll_fac
long r
gs_variable_array lst_data

lst_data = message.powerobjectparm
ll_prac = lst_data.as_number[1]
ll_fac = lst_data.as_number[2]

dw_1.settransobject( sqlca)
r = dw_1.retrieve(ll_prac,ll_fac)

if r < 1 then
	messagebox("Profile Select","There are no Profiles associated with this Provider and Facility")
	closewithreturn(this,0)
end if
end event

on w_qa_profile_select.create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_select=create cb_select
this.Control[]={this.dw_1,&
this.cb_close,&
this.cb_select}
end on

on w_qa_profile_select.destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_select)
end on

type dw_1 from datawindow within w_qa_profile_select
integer x = 41
integer y = 52
integer width = 2510
integer height = 908
integer taborder = 10
string title = "none"
string dataobject = "d_qa_profile_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)
end event

event doubleclicked;integer t

t = this.getitemnumber(row,"pd_qa_hdr_id")

closewithreturn(parent,t)
end event

type cb_close from commandbutton within w_qa_profile_select
integer x = 1275
integer y = 996
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

event clicked;closewithreturn(parent,0)
end event

type cb_select from commandbutton within w_qa_profile_select
integer x = 914
integer y = 996
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select"
end type

event clicked;integer t

if dw_1.getrow( ) < 1 then return	//added by long.zhang 09.05.2011 #BugL083101
t = dw_1.getitemnumber(dw_1.getrow() ,"pd_qa_hdr_id")

closewithreturn(parent,t)
end event

