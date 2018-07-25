$PBExportHeader$w_set_filedlist.srw
forward
global type w_set_filedlist from w_response
end type
type cb_2 from commandbutton within w_set_filedlist
end type
type cb_1 from commandbutton within w_set_filedlist
end type
type dw_1 from u_dw within w_set_filedlist
end type
end forward

global type w_set_filedlist from w_response
integer width = 3205
integer height = 1792
long backcolor = 33551856
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_set_filedlist w_set_filedlist

on w_set_filedlist.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_set_filedlist.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_2 from commandbutton within w_set_filedlist
integer x = 2469
integer y = 1588
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

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_set_filedlist
integer x = 2825
integer y = 1588
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

event clicked;parent.event pfc_save( )
update ctx_screen set fix_field = t2.fix_field
from (select fix_field,screen_id from ctx_screen  where data_view_id = 1001)t2
where ctx_screen.screen_id = t2.screen_id;
commit;
close(parent)
end event

type dw_1 from u_dw within w_set_filedlist
integer x = 32
integer y = 32
integer width = 3127
integer height = 1524
integer taborder = 10
string dataobject = "d_set_fieldlist"
boolean hsplitscroll = true
boolean livescroll = false
end type

event constructor;call super::constructor;this.Settransobject( sqlca)
this.retrieve( )
end event

