$PBExportHeader$w_select_privtemp.srw
forward
global type w_select_privtemp from window
end type
type cb_1 from commandbutton within w_select_privtemp
end type
type cb_2 from commandbutton within w_select_privtemp
end type
type st_2 from statictext within w_select_privtemp
end type
type dw_template from datawindow within w_select_privtemp
end type
end forward

global type w_select_privtemp from window
integer width = 1733
integer height = 388
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_2 cb_2
st_2 st_2
dw_template dw_template
end type
global w_select_privtemp w_select_privtemp

type variables
long il_template_id
end variables

on w_select_privtemp.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
this.dw_template=create dw_template
this.Control[]={this.cb_1,&
this.cb_2,&
this.st_2,&
this.dw_template}
end on

on w_select_privtemp.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.dw_template)
end on

event close;CloseWithReturn(this, il_template_id)
end event

type cb_1 from commandbutton within w_select_privtemp
integer x = 1019
integer y = 156
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;il_template_id = dw_template.GetItemNumber(1, "template_id")
if IsNull(il_template_id) or il_template_id = 0 then
	il_template_id = 0
	MessageBox("Select", "You must select a template.")
	dw_template.SetFocus()
	Return -1
end if

Close(Parent)
end event

type cb_2 from commandbutton within w_select_privtemp
integer x = 1353
integer y = 156
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type st_2 from statictext within w_select_privtemp
integer x = 46
integer y = 96
integer width = 919
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "Select Template to which to copy "
boolean focusrectangle = false
end type

type dw_template from datawindow within w_select_privtemp
integer x = 41
integer y = 168
integer width = 937
integer height = 72
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ddlb_priv_template"
boolean border = false
boolean livescroll = true
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 01.20.2011
//////////////////////////////////////////////////////////////////////

this.SetTransObject(SQLCA)
this.InsertRow(1)
end event

