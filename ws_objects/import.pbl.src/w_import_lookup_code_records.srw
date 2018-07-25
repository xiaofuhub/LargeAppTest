$PBExportHeader$w_import_lookup_code_records.srw
forward
global type w_import_lookup_code_records from window
end type
type sle_luc from singlelineedit within w_import_lookup_code_records
end type
type st_5 from statictext within w_import_lookup_code_records
end type
type st_4 from statictext within w_import_lookup_code_records
end type
type st_3 from statictext within w_import_lookup_code_records
end type
type st_2 from statictext within w_import_lookup_code_records
end type
type cb_sort from commandbutton within w_import_lookup_code_records
end type
type cb_delete from commandbutton within w_import_lookup_code_records
end type
type st_1 from statictext within w_import_lookup_code_records
end type
type cb_save from commandbutton within w_import_lookup_code_records
end type
type cb_import from commandbutton within w_import_lookup_code_records
end type
type cb_close from commandbutton within w_import_lookup_code_records
end type
type dw_table from datawindow within w_import_lookup_code_records
end type
type dw_import from datawindow within w_import_lookup_code_records
end type
end forward

global type w_import_lookup_code_records from window
integer width = 3145
integer height = 2124
boolean titlebar = true
string title = "Import Address Lookup Data"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_luc sle_luc
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
cb_sort cb_sort
cb_delete cb_delete
st_1 st_1
cb_save cb_save
cb_import cb_import
cb_close cb_close
dw_table dw_table
dw_import dw_import
end type
global w_import_lookup_code_records w_import_lookup_code_records

type variables
long il_code
string is_table
end variables

on w_import_lookup_code_records.create
this.sle_luc=create sle_luc
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_sort=create cb_sort
this.cb_delete=create cb_delete
this.st_1=create st_1
this.cb_save=create cb_save
this.cb_import=create cb_import
this.cb_close=create cb_close
this.dw_table=create dw_table
this.dw_import=create dw_import
this.Control[]={this.sle_luc,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.cb_sort,&
this.cb_delete,&
this.st_1,&
this.cb_save,&
this.cb_import,&
this.cb_close,&
this.dw_table,&
this.dw_import}
end on

on w_import_lookup_code_records.destroy
destroy(this.sle_luc)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_sort)
destroy(this.cb_delete)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.dw_table)
destroy(this.dw_import)
end on

event open;//Start Code Change ----03.24.2016 #V15 maha - created

long ll_code

select lookup_code_id into :ll_code from ids;

il_code = ll_code
sle_luc.text = string(ll_code)

end event

type sle_luc from singlelineedit within w_import_lookup_code_records
integer x = 2112
integer y = 16
integer width = 343
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_import_lookup_code_records
integer x = 1765
integer y = 28
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "LU_Code start:"
boolean focusrectangle = false
end type

type st_4 from statictext within w_import_lookup_code_records
integer x = 1591
integer y = 116
integer width = 1047
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "4) Delete any of the import records desired"
boolean focusrectangle = false
end type

type st_3 from statictext within w_import_lookup_code_records
integer x = 37
integer y = 108
integer width = 974
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "2) Delete desired existing lookup records"
boolean focusrectangle = false
end type

type st_2 from statictext within w_import_lookup_code_records
integer x = 9
integer y = 188
integer width = 2089
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "File should be in the format below. The first column values will be overwritten."
boolean focusrectangle = false
end type

type cb_sort from commandbutton within w_import_lookup_code_records
integer x = 2656
integer y = 184
integer width = 247
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_import.SetSort(null_str)

dw_import.Sort( )
end event

type cb_delete from commandbutton within w_import_lookup_code_records
integer x = 2651
integer y = 104
integer width = 247
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;dw_import.deleterow(0)
end event

type st_1 from statictext within w_import_lookup_code_records
integer x = 41
integer y = 12
integer width = 535
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1) Select Lookup Table"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_import_lookup_code_records
integer x = 2464
integer y = 12
integer width = 302
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "5) Save"
end type

event clicked;long i
long ic
long ll_code

if len(is_table) = 0 then
	messagebox("","Select lookup table")
	return
end if

ll_code = long(sle_luc.text)

ic = dw_import.rowcount()

for i = 1 to ic
	dw_import.setitem(i,"lookup_name", is_table)
	if isnull(dw_import.getitemstring(i,'code')) or LenA(dw_import.getitemstring(i,'code')) < 1 then
		dw_import.setitem(i,"code","imp_" + string(i))
	end if
	if isnull(dw_import.getitemnumber(i,'lookup_code')) then
		dw_import.setitem(i,"lookup_code",ll_code)
	end if
	ll_code++
next

if ll_code > il_code then
	update ids set lookup_code_id = :ll_code;
end if

dw_import.update()

end event

type cb_import from commandbutton within w_import_lookup_code_records
integer x = 1074
integer y = 96
integer width = 466
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) Get Import File"
end type

event clicked;string pathandfile
string file

//dw_import.reset()

//---------Begin Modified by (Appeon)Stephen 02.17.2014 for file paths modify --------
//if  GetFileOpenName("Select File",    pathandfile, file, "TXT",  "Text Files (*.TXT),*.TXT",    "C:\IntelliCred\", 18) < 1 then return
if  GetFileOpenName("Select File",    pathandfile, file, "TXT",  "Text Files (*.TXT),*.TXT",    gs_dir_path + gs_DefDirName+"\", 18) < 1 then return
//---------End Modfiied ------------------------------------------------------

dw_import.importfile(pathandfile)
 
 
end event

type cb_close from commandbutton within w_import_lookup_code_records
integer x = 2775
integer y = 12
integer width = 302
integer height = 84
integer taborder = 20
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

type dw_table from datawindow within w_import_lookup_code_records
integer x = 617
integer y = 12
integer width = 1134
integer height = 92
integer taborder = 10
string title = "none"
string dataobject = "d_lookup_tables_names"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)

This.GetChild( "lookup_name", dwchild )
dwchild.settransobject(sqlca)
dwchild.setfilter("ttype = 'C'")
dwchild.filter()

end event

event itemchanged;long i
long ic

is_table = data

dw_import.retrieve(data)


	

end event

type dw_import from datawindow within w_import_lookup_code_records
integer x = 14
integer y = 260
integer width = 3086
integer height = 1744
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup_import"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

