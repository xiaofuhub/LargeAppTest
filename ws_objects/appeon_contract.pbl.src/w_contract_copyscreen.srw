$PBExportHeader$w_contract_copyscreen.srw
forward
global type w_contract_copyscreen from window
end type
type cb_cancel from commandbutton within w_contract_copyscreen
end type
type cb_ok from commandbutton within w_contract_copyscreen
end type
type dw_view from u_dw within w_contract_copyscreen
end type
type st_2 from statictext within w_contract_copyscreen
end type
type sle_screen from singlelineedit within w_contract_copyscreen
end type
type st_1 from statictext within w_contract_copyscreen
end type
end forward

global type w_contract_copyscreen from window
integer width = 1431
integer height = 620
boolean titlebar = true
string title = "Copy Screen"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
dw_view dw_view
st_2 st_2
sle_screen sle_screen
st_1 st_1
end type
global w_contract_copyscreen w_contract_copyscreen

type variables
string is_Return = "cancel!"
end variables

on w_contract_copyscreen.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_view=create dw_view
this.st_2=create st_2
this.sle_screen=create sle_screen
this.st_1=create st_1
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_view,&
this.st_2,&
this.sle_screen,&
this.st_1}
end on

on w_contract_copyscreen.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_view)
destroy(this.st_2)
destroy(this.sle_screen)
destroy(this.st_1)
end on

event close;CloseWithReturn(this, is_Return)
end event

event open;sle_screen.Text = Message.StringParm
end event

type cb_cancel from commandbutton within w_contract_copyscreen
integer x = 987
integer y = 384
integer width = 343
integer height = 92
integer taborder = 30
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

type cb_ok from commandbutton within w_contract_copyscreen
integer x = 617
integer y = 384
integer width = 343
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

event clicked;long ll_data_view_id

ll_data_view_id = dw_view.object.data_view_id[1]
if ll_data_view_id > 0 then
	is_Return = String(ll_data_view_id)
	Close(Parent)
else
	MessageBox("Select View", "Please select a view.")
	dw_view.SetFocus()
end if
end event

type dw_view from u_dw within w_contract_copyscreen
event ue_dddwdelete ( long al_data_view_id )
integer x = 389
integer y = 228
integer width = 955
integer height = 96
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event ue_dddwdelete(long al_data_view_id);long ll_FindRow
DataWindowChild ldwc_child

this.GetChild("data_view_id", ldwc_child)

ll_FindRow = ldwc_child.Find("data_view_id=" + String(al_data_view_id), 1, ldwc_child.RowCount())
ldwc_child.DeleteRow(ll_FindRow)
end event

event constructor;// Retrieve views
this.of_SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.InsertRow(0)
this.Event ue_DDDWDelete(1001)
end event

type st_2 from statictext within w_contract_copyscreen
integer x = 73
integer y = 244
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "to:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_screen from singlelineedit within w_contract_copyscreen
integer x = 398
integer y = 96
integer width = 928
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_contract_copyscreen
integer x = 73
integer y = 108
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Copy screen:"
alignment alignment = right!
boolean focusrectangle = false
end type

