$PBExportHeader$w_priv_merge_fields.srw
forward
global type w_priv_merge_fields from w_popup
end type
type plb_1 from picturelistbox within w_priv_merge_fields
end type
type cb_close from commandbutton within w_priv_merge_fields
end type
type cb_insert from commandbutton within w_priv_merge_fields
end type
end forward

global type w_priv_merge_fields from w_popup
integer width = 1239
integer height = 1552
string title = "Merge Fields"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
plb_1 plb_1
cb_close cb_close
cb_insert cb_insert
end type
global w_priv_merge_fields w_priv_merge_fields

type variables
window iw_parent
integer ii_Index = 1
end variables

forward prototypes
public function integer of_getfields ()
end prototypes

public function integer of_getfields ();//////////////////////////////////////////////////////////////////////
// $<function> of_getfields
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

string ls_Field
integer i, li_Count
datastore lds_data

lds_data = Create datastore
lds_data.DataObject = "d_priv_data_source"

li_Count = Long(lds_data.Describe("datawindow.column.count"))
for i = 1 to li_Count
	ls_Field = lds_data.Describe("#" + String(i) + ".name")
	plb_1.AddItem(ls_Field, 1)
next
plb_1.SelectItem(1)

Destroy lds_data

Return 1
end function

on w_priv_merge_fields.create
int iCurrent
call super::create
this.plb_1=create plb_1
this.cb_close=create cb_close
this.cb_insert=create cb_insert
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.plb_1
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_insert
end on

on w_priv_merge_fields.destroy
call super::destroy
destroy(this.plb_1)
destroy(this.cb_close)
destroy(this.cb_insert)
end on

event open;call super::open;iw_parent = Message.PowerObjectParm
of_GetFields()
end event

type plb_1 from picturelistbox within w_priv_merge_fields
integer y = 4
integer width = 1225
integer height = 1332
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
string picturename[] = {"EditMask!"}
long picturemaskcolor = 12632256
end type

event selectionchanged;ii_Index = Index
end event

event doubleclicked;cb_insert.Event Clicked()
end event

type cb_close from commandbutton within w_priv_merge_fields
integer x = 855
integer y = 1348
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_insert from commandbutton within w_priv_merge_fields
integer x = 507
integer y = 1348
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

string ls_Field

ls_Field = plb_1.Text(ii_Index)

if Len(ls_Field) > 0 then
	if IsValid(iw_parent) then
		iw_parent.Dynamic of_InsertField(ls_Field)
	end if
else
	MessageBox("Warning", "You have no selected a field!", Exclamation!)
end if
end event

