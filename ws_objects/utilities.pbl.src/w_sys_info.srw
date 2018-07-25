$PBExportHeader$w_sys_info.srw
forward
global type w_sys_info from window
end type
type cb_save from commandbutton within w_sys_info
end type
type cb_add from commandbutton within w_sys_info
end type
type cb_close from commandbutton within w_sys_info
end type
type dw_detail from datawindow within w_sys_info
end type
type dw_browse from datawindow within w_sys_info
end type
end forward

global type w_sys_info from window
integer width = 4032
integer height = 2476
boolean titlebar = true
string title = "System Setup info"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_save cb_save
cb_add cb_add
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_sys_info w_sys_info

on w_sys_info.create
this.cb_save=create cb_save
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.cb_save,&
this.cb_add,&
this.cb_close,&
this.dw_detail,&
this.dw_browse}
end on

on w_sys_info.destroy
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;string ls_from

ls_from = message.stringparm

if ls_from = "Cust" then 
	cb_save.visible = false
	cb_add.visible = false
end if

dw_browse.settransobject(sqlca)
dw_detail.settransobject(sqlca)

dw_browse.retrieve()
end event

type cb_save from commandbutton within w_sys_info
integer x = 3218
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_detail.update()
end event

type cb_add from commandbutton within w_sys_info
integer x = 2853
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;long id

dw_detail.insertrow(1)

select max(info_id) into :id from sys_info;

if isnull(id) then id = 0

id++

dw_detail.setitem(1,"info_id",id)
dw_detail.setitem(1,"add_date",today())



end event

type cb_close from commandbutton within w_sys_info
integer x = 3589
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_detail from datawindow within w_sys_info
integer x = 41
integer y = 744
integer width = 3881
integer height = 1476
integer taborder = 20
string title = "none"
string dataobject = "d_sys_info_detail"
boolean livescroll = true
end type

type dw_browse from datawindow within w_sys_info
integer x = 41
integer y = 152
integer width = 3890
integer height = 560
integer taborder = 10
string title = "none"
string dataobject = "d_sys_info_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;long i

this.selectrow(0,false)
this.selectrow(currentrow,true)

i = this.getitemnumber(currentrow,"info_id")

dw_detail.retrieve(i)
end event

event clicked;long i

i = this.getclickedrow()
this.setrow(i)
end event

