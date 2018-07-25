$PBExportHeader$w_bidq_setdefaults.srw
forward
global type w_bidq_setdefaults from window
end type
type cb_ok from commandbutton within w_bidq_setdefaults
end type
type cb_cancel from commandbutton within w_bidq_setdefaults
end type
type dw_prop from u_dw within w_bidq_setdefaults
end type
type gb_1 from groupbox within w_bidq_setdefaults
end type
end forward

global type w_bidq_setdefaults from window
integer width = 1390
integer height = 824
boolean titlebar = true
string title = "Set Defaults"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_ok cb_ok
cb_cancel cb_cancel
dw_prop dw_prop
gb_1 gb_1
end type
global w_bidq_setdefaults w_bidq_setdefaults

type variables
DataWindow idw_data
end variables

on w_bidq_setdefaults.create
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_prop=create dw_prop
this.gb_1=create gb_1
this.Control[]={this.cb_ok,&
this.cb_cancel,&
this.dw_prop,&
this.gb_1}
end on

on w_bidq_setdefaults.destroy
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_prop)
destroy(this.gb_1)
end on

event open;idw_data = Message.PowerObjectParm
end event

type cb_ok from commandbutton within w_bidq_setdefaults
integer x = 617
integer y = 612
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

event clicked;string ls_doc_type
string ls_doc_from_name
long ll_category
long ll_Row
Integer li_delete_flag

// Get properties value
ls_doc_type = dw_prop.object.doc_type[1]
ls_doc_from_name = dw_prop.object.doc_from_name[1]
ll_category = dw_prop.object.category[1]
li_delete_flag = dw_prop.object.delete_flag[1]

if Trim(ls_doc_type) = "" then SetNull(ls_doc_type)
if Trim(ls_doc_from_name) = "" then SetNull(ls_doc_from_name)

// Set properties value
for ll_Row = 1 to idw_data.RowCount()
	if not IsNull(ls_doc_type) and IsNull(idw_data.object.doc_type[ll_Row]) then
		idw_data.SetItem(ll_Row, "doc_type", ls_doc_type)
	end if
	if not IsNull(ll_category) and IsNull(idw_data.object.category[ll_Row]) then
		idw_data.SetItem(ll_Row, "category", ll_category)
	end if
	if not IsNull(ls_doc_from_name) and IsNull(idw_data.object.doc_from_name[ll_Row]) then
		idw_data.SetItem(ll_Row, "doc_from_name", ls_doc_from_name)
	end if
	
	//Added By Ken.Guo 2010-07-01.
	If not IsNull(li_delete_flag) and IsNull(idw_data.object.delete_flag[ll_Row]) Then
		idw_data.SetItem(ll_Row, "delete_flag", li_delete_flag)
	End If

next

// Close window
Close(Parent)
end event

type cb_cancel from commandbutton within w_bidq_setdefaults
integer x = 987
integer y = 612
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

type dw_prop from u_dw within w_bidq_setdefaults
integer x = 142
integer y = 124
integer width = 1111
integer height = 420
integer taborder = 10
string dataobject = "d_bidq_setdefaults"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;// Inherit
DataWindowChild ldwc_child

// Set doc_from_name DDDW
this.SetTransObject(SQLCA)
this.GetChild("doc_from_name", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
ldwc_child.Retrieve(-1)
ldwc_child.SetSort("id A")
ldwc_child.Sort()
ldwc_child.InsertRow(1)

// Set category DDDW
this.InsertRow(0)
this.GetChild("category", ldwc_child)
ldwc_child.InsertRow(1)


DataWindowChild ldwc_child_doctype
this.SetTransObject(SQLCA)
this.GetChild("doc_type", ldwc_child_doctype)
ldwc_child_doctype.SetTransObject(SQLCA)
ldwc_child_doctype.Retrieve('Contract Document Type')
end event

type gb_1 from groupbox within w_bidq_setdefaults
integer x = 41
integer y = 32
integer width = 1285
integer height = 540
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Default Value Settings"
end type

