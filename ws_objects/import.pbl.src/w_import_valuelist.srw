$PBExportHeader$w_import_valuelist.srw
forward
global type w_import_valuelist from window
end type
type cb_getvalue from commandbutton within w_import_valuelist
end type
type cb_reset from commandbutton within w_import_valuelist
end type
type dw_data from u_dw within w_import_valuelist
end type
type cb_delete from commandbutton within w_import_valuelist
end type
type cb_add from commandbutton within w_import_valuelist
end type
type cb_cancel from commandbutton within w_import_valuelist
end type
type cb_saveas from commandbutton within w_import_valuelist
end type
end forward

global type w_import_valuelist from window
integer width = 1801
integer height = 2040
boolean titlebar = true
string title = "Create Value List"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_getvalue cb_getvalue
cb_reset cb_reset
dw_data dw_data
cb_delete cb_delete
cb_add cb_add
cb_cancel cb_cancel
cb_saveas cb_saveas
end type
global w_import_valuelist w_import_valuelist

type variables
long il_import_id
string is_import_name
string is_imp_field_name

end variables

on w_import_valuelist.create
this.cb_getvalue=create cb_getvalue
this.cb_reset=create cb_reset
this.dw_data=create dw_data
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_cancel=create cb_cancel
this.cb_saveas=create cb_saveas
this.Control[]={this.cb_getvalue,&
this.cb_reset,&
this.dw_data,&
this.cb_delete,&
this.cb_add,&
this.cb_cancel,&
this.cb_saveas}
end on

on w_import_valuelist.destroy
destroy(this.cb_getvalue)
destroy(this.cb_reset)
destroy(this.dw_data)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_cancel)
destroy(this.cb_saveas)
end on

event open;integer li_NewPos
integer li_OldPos

// Get il_import_id
li_OldPos = PosA(Message.StringParm, "|")
il_import_id = Long(LeftA(Message.StringParm, li_OldPos - 1))
li_OldPos ++

// Get is_import_name
li_NewPos = PosA(Message.StringParm, "|", li_OldPos)
is_import_name = MidA(Message.StringParm, li_OldPos, li_NewPos - li_OldPos)

// Get is_imp_field_name
is_imp_field_name = RightA(Message.StringParm, LenA(Message.StringParm) - li_NewPos)
this.Title = "Create Value List : " + is_imp_field_name

cb_getvalue.triggerevent(clicked!)  //Start Code Change ----02.08.2008 #V8 maha - run get value when opening.
end event

type cb_getvalue from commandbutton within w_import_valuelist
integer x = 1202
integer y = 168
integer width = 549
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Get Import File Values"
end type

event clicked;string ls_Error
string ls_Value
integer li_Return
long ll_FindRow
long i, ll_InsertRow
DataStore lds_imp_data
n_cst_import lnv_import

lds_imp_data = Create DataStore
lnv_import = Create n_cst_import

//Get import data
lnv_import.of_GetImportInfo(il_import_id, false)
ls_Error = lnv_import.of_GetImportData(il_import_id, lds_imp_data)
if LenA(ls_Error) > 0 then
	Destroy lnv_import
	Destroy lds_imp_data	
	MessageBox("Prompt", ls_Error)
	Return
end if

//Prompt
if dw_data.RowCount() > 0 then
	li_Return = MessageBox("Prompt", "Do you want to delete current import values?", Question!, YesNoCancel!)
	if li_Return = 3 then
		Destroy lnv_import
		Destroy lds_imp_data
		Return		
	elseif li_Return = 1 then
		dw_data.Reset()
	end if
end if

//Create value list
for i = 1 to lds_imp_data.RowCount()
	ls_Value = lds_imp_data.GetItemString(i, is_imp_field_name)
	if LenA(ls_value) < 1 or isnull(ls_value) then ls_Value = ''  //Start Code Change ----02.08.2008 #V8 maha - test for blanks blanks
	ll_FindRow = dw_data.Find("valuelist = '" + of_ReviseExpValue(ls_Value, "~~") + "'", 1, dw_data.RowCount()) //Modify by Evan 06.25.2009 --- Use of_ReviseExpValue function to corrected value
	if ll_FindRow > 0 then
	else
		ll_InsertRow = dw_data.InsertRow(0)
		dw_data.object.valuelist[ll_InsertRow] = ls_Value
	end if
next

dw_data.sort()  //Start Code Change ----02.08.2008 #V8 maha

Destroy lnv_import
Destroy lds_imp_data
end event

type cb_reset from commandbutton within w_import_valuelist
integer x = 1202
integer y = 744
integer width = 549
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;dw_data.Reset()

end event

type dw_data from u_dw within w_import_valuelist
integer x = 14
integer y = 20
integer width = 1166
integer height = 1844
integer taborder = 70
string dataobject = "d_import_valuelist"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

type cb_delete from commandbutton within w_import_valuelist
integer x = 1202
integer y = 600
integer width = 549
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_data.DeleteRow(0)
dw_data.SetFocus()
end event

type cb_add from commandbutton within w_import_valuelist
integer x = 1202
integer y = 456
integer width = 549
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;long ll_InsertRow

ll_InsertRow = dw_data.InsertRow(0)
dw_data.ScrollToRow(ll_InsertRow)

dw_data.SetFocus()
end event

type cb_cancel from commandbutton within w_import_valuelist
integer x = 1202
integer y = 24
integer width = 549
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_saveas from commandbutton within w_import_valuelist
integer x = 1202
integer y = 312
integer width = 549
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save as File"
boolean default = true
end type

event clicked;string ls_Path
string ls_File
integer li_Return

if dw_data.RowCount() <= 0 then
	MessageBox("Prompt", "Please add value.")
	Return
end if

ls_Path = is_import_name + "_" + is_imp_field_name
//---------Begin Modified by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
  /*
	li_Return = GetFileSaveName ("Save As", ls_Path, ls_File, "TXT", "Text Files (*.TXT),*.TXT" , gs_current_path)
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008      
  */
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
li_Return = GetFileSaveName ("Save As", ls_Path, ls_File, "TXT", "Text Files (*.TXT),*.TXT" )
gf_save_dir_path(ls_Path) //Added by Ken.Guo on 2009-03-10 
//---------End Modfiied ------------------------------------------------------------------
if li_Return <> 1 then Return

if FileExists(ls_Path) then
	li_Return = MessageBox("Confirm File Replace", "This folder already contains a file named '" + ls_File + "'." + &
									"~r~nWould you like to replace the existing file?", Question!, YesNo!)
	if li_Return <> 1 then Return 
end if
//---------Begin Added by (Appeon)Toney 06.18.2013 for V141 ISG-CLX--------
gnv_rights.of_check_dir_right( ls_Path, true, 'Import Save')
//---------End Added ------------------------------------------------------------------

dw_data.SaveAs(ls_Path, Text!, false)
end event

