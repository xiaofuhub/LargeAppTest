$PBExportHeader$w_import_priv_procedures_maha.srw
forward
global type w_import_priv_procedures_maha from window
end type
type dw_lookup from datawindow within w_import_priv_procedures_maha
end type
type cb_sort from commandbutton within w_import_priv_procedures_maha
end type
type cb_delete from commandbutton within w_import_priv_procedures_maha
end type
type cb_save from commandbutton within w_import_priv_procedures_maha
end type
type cb_import from commandbutton within w_import_priv_procedures_maha
end type
type cb_close from commandbutton within w_import_priv_procedures_maha
end type
type dw_import from datawindow within w_import_priv_procedures_maha
end type
end forward

global type w_import_priv_procedures_maha from window
integer width = 4375
integer height = 2232
boolean titlebar = true
string title = "Import Privilege Procedures"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
string icon = "AppIcon!"
boolean center = true
dw_lookup dw_lookup
cb_sort cb_sort
cb_delete cb_delete
cb_save cb_save
cb_import cb_import
cb_close cb_close
dw_import dw_import
end type
global w_import_priv_procedures_maha w_import_priv_procedures_maha

on w_import_priv_procedures_maha.create
this.dw_lookup=create dw_lookup
this.cb_sort=create cb_sort
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_import=create cb_import
this.cb_close=create cb_close
this.dw_import=create dw_import
this.Control[]={this.dw_lookup,&
this.cb_sort,&
this.cb_delete,&
this.cb_save,&
this.cb_import,&
this.cb_close,&
this.dw_import}
end on

on w_import_priv_procedures_maha.destroy
destroy(this.dw_lookup)
destroy(this.cb_sort)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.dw_import)
end on

type dw_lookup from datawindow within w_import_priv_procedures_maha
integer x = 3493
integer y = 200
integer width = 750
integer height = 1740
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup_priv_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_sort from commandbutton within w_import_priv_procedures_maha
integer x = 2149
integer y = 48
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

type cb_delete from commandbutton within w_import_priv_procedures_maha
integer x = 2149
integer y = 116
integer width = 247
integer height = 64
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

type cb_save from commandbutton within w_import_priv_procedures_maha
integer x = 2409
integer y = 68
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2) Save"
end type

event clicked;long i
long ic
long a
long nr
long lrc
long ll_code
long ll_procedure_pk
integer li_find
string ls_ca
string ls_sect
string ls_find

ic = dw_import.rowcount()
debugbreak()


for i = 1 to ic
	ls_ca = dw_import.getitemstring(i,"ca_description")
	ls_find = 'description = "' + ls_ca + '" and lookup_name = "Priv Clinical Area" '
	li_find = dw_lookup.find( ls_find ,1,100000)
	if li_find < 0 then
		messagebox("Find Error for Priv Clinical Area", ls_find)
		return
	elseif li_find = 0 then
		nr = dw_lookup.insertrow(0)
		dw_lookup.setitem( nr, "description", ls_ca)
		dw_lookup.setitem( nr, "code", upper(mid(ls_ca,1,9)))
		dw_lookup.setitem( nr, "lookup_name", "Priv Clinical Area")
	end if
next

for i = 1 to ic
	ls_sect = dw_import.getitemstring(i,"sect_desc")
	ls_find = 'description = "' + ls_sect + '" and lookup_name = "Priv Section" '  
	li_find = dw_lookup.find( ls_find ,1 ,1000000)
	if li_find < 0 then
		messagebox("Find Error for Priv Section", ls_find)
		return
	elseif li_find = 0 then
		nr = dw_lookup.insertrow(0)
		dw_lookup.setitem( nr, "description", ls_sect)
		dw_lookup.setitem( nr, "code", upper(mid(ls_sect,1,9)))
		dw_lookup.setitem( nr, "lookup_name", "Priv Section")
	end if
next

lrc = dw_lookup.rowcount()
ll_code = -1300

for i = 1 to lrc
	dw_lookup.setitem(i,"lookup_code",ll_code)
	ll_code = ll_code - 1
next

for i = 1 to ic
	dw_import.setitem( i, "facility_specific", 0)
	ls_ca = dw_import.getitemstring(i,"ca_description")
	li_find = dw_lookup.find( 'description = "' + ls_ca + '" and lookup_name = "Priv Clinical Area" '         ,1,100000)
	if li_find > 0 then
		ll_code = dw_lookup.getitemnumber( li_find, "lookup_code")
		dw_import.setitem( i, "clinical_area_id", ll_code)
	end if
next

for i = 1 to ic
	ls_sect = dw_import.getitemstring(i,"sect_desc")
	li_find = dw_lookup.find('description = "' + ls_sect + '" and lookup_name = "Priv Section" '    ,1,100000)
	if li_find > 0 then
		ll_code = dw_lookup.getitemnumber( li_find, "lookup_code")
		dw_import.setitem( i, "section_id", ll_code)
	end if
next


// Set primary keys of new record
SELECT max(procedure_pk) INTO :ll_procedure_pk FROM priv_procd_lookup;
if IsNull(ll_procedure_pk) then ll_procedure_pk = 0

for i = 1 to ic
	ll_procedure_pk ++
	dw_import.SetItem(i, "procedure_pk", ll_procedure_pk)
	dw_import.SetItem( i, "isg_code", string( ll_procedure_pk))
next


dw_lookup.update()
dw_import.update()

messagebox("Procedure Import","Completed.  " + string(ic) + " procedures imported.")
end event

type cb_import from commandbutton within w_import_priv_procedures_maha
integer x = 1714
integer y = 68
integer width = 411
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) Get Import File"
end type

event clicked;string pathandfile
string file
long rc
long r

dw_import.reset()

if  GetFileOpenName("Select File",    pathandfile, file, "TXT",  "Text Files (*.TXT),*.TXT",    "C:\IntelliCred\", 18) < 1 then return
 
rc = dw_import.importfile(pathandfile)

for r = 1 to rc
	dw_import.setitem( r,"procd_name", midA(dw_import.getitemstring( r, "name_temp"), 1,50))
next

for r = rc to 1 step -1
	if isnull(dw_import.getitemstring( r, "procedure_description")) or len(dw_import.getitemstring( r, "procedure_description")) = 0 then
		dw_import.deleterow(r)
	end if
next
 
 
end event

type cb_close from commandbutton within w_import_priv_procedures_maha
integer x = 2766
integer y = 68
integer width = 343
integer height = 92
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

type dw_import from datawindow within w_import_priv_procedures_maha
integer x = 37
integer y = 220
integer width = 3419
integer height = 1724
integer taborder = 10
string title = "none"
string dataobject = "d_priv_procd_import_maha"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

