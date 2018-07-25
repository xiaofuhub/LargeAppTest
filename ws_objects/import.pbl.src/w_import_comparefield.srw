$PBExportHeader$w_import_comparefield.srw
forward
global type w_import_comparefield from window
end type
type dw_data from u_dw within w_import_comparefield
end type
type cb_close from commandbutton within w_import_comparefield
end type
end forward

global type w_import_comparefield from window
integer width = 1710
integer height = 2152
boolean titlebar = true
string title = "Compare Fields"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_compare ( )
dw_data dw_data
cb_close cb_close
end type
global w_import_comparefield w_import_comparefield

event ue_compare();string ls_input_field
string ls_file_field
string ls_Fields[]
integer i, li_FieldCount
DataWindow ldw_Field

// Get file field
li_FieldCount = w_import_painter.of_GetImportFields(ls_Fields[])
if li_FieldCount > 0 then
	dw_data.object.file_field[1, li_FieldCount] = ls_Fields[]
end if

// Get import field
ldw_Field = w_import_painter.tab_1.tabpage_field_data.dw_field_list
li_FieldCount = ldw_Field.RowCount()
if li_FieldCount > 0 then
	dw_data.object.input_field[1, li_FieldCount] = ldw_Field.object.imp_field_name[1, li_FieldCount]
end if

// Compare import fields with file fields
for i = 1 to dw_data.RowCount()
	// Import field is computed field
	if i <= li_FieldCount then
		if	LenA(Trim(ldw_Field.object.comp_def[i])) > 0 then
			dw_data.object.input_field[i] = dw_data.object.input_field[i] + " (computed field)"
		end if
	end if
	
	// Compare
	ls_input_field = Lower(dw_data.object.input_field[i])
	ls_file_field = Lower(dw_data.object.file_field[i])
	if IsNull(ls_input_field) then ls_input_field = ""
	if IsNull(ls_file_field) then ls_file_field = ""
	
	if ls_input_field = ls_file_field then
		dw_data.object.flag[i] = 0
	else
		dw_data.object.flag[i] = 1
	end if
next
end event

on w_import_comparefield.create
this.dw_data=create dw_data
this.cb_close=create cb_close
this.Control[]={this.dw_data,&
this.cb_close}
end on

on w_import_comparefield.destroy
destroy(this.dw_data)
destroy(this.cb_close)
end on

event open;this.Event ue_Compare()
end event

type dw_data from u_dw within w_import_comparefield
integer x = 18
integer y = 20
integer width = 1664
integer height = 1900
integer taborder = 10
string dataobject = "d_import_comparefield"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.Modify("DataWindow.ReadOnly = 'yes'")
end event

event rowfocuschanged;call super::rowfocuschanged;//Inherit
this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

type cb_close from commandbutton within w_import_comparefield
integer x = 1262
integer y = 1956
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

