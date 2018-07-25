$PBExportHeader$w_priv_template_prop.srw
forward
global type w_priv_template_prop from window
end type
type cb_save from commandbutton within w_priv_template_prop
end type
type dw_detail from datawindow within w_priv_template_prop
end type
type cb_close from commandbutton within w_priv_template_prop
end type
end forward

global type w_priv_template_prop from window
integer x = 123
integer y = 112
integer width = 3296
integer height = 2780
boolean titlebar = true
string title = "Privilege Template Properties"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_save cb_save
dw_detail dw_detail
cb_close cb_close
end type
global w_priv_template_prop w_priv_template_prop

type variables
long il_openfor
long il_temp
end variables

on w_priv_template_prop.create
this.cb_save=create cb_save
this.dw_detail=create dw_detail
this.cb_close=create cb_close
this.Control[]={this.cb_save,&
this.dw_detail,&
this.cb_close}
end on

on w_priv_template_prop.destroy
destroy(this.cb_save)
destroy(this.dw_detail)
destroy(this.cb_close)
end on

event open;il_temp = message.doubleparm

dw_detail.settransobject(sqlca)
dw_detail.retrieve(il_temp)
end event

type cb_save from commandbutton within w_priv_template_prop
integer x = 2455
integer y = 20
integer width = 352
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Save"
end type

event clicked;dw_detail.update()

//------------------- APPEON BEGIN -------------------
//$<add> Evan 03.09.2010
//$<reason> Refresh dropdown datawindow
datawindowchild ldw_child
if IsValid(w_privilege_painter) then
	w_privilege_painter.dw_template.GetChild("template_id", ldw_child)
	ldw_child.SetItem(ldw_child.GetRow(), "template_name", dw_detail.object.template_name[1])
	w_privilege_painter.dw_template.SetRedraw(true)
end if
//------------------- APPEON END ---------------------
end event

type dw_detail from datawindow within w_priv_template_prop
integer y = 140
integer width = 3282
integer height = 2556
integer taborder = 80
string dataobject = "d_priv_temp_prop"
boolean livescroll = true
end type

type cb_close from commandbutton within w_priv_template_prop
integer x = 2857
integer y = 20
integer width = 352
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

