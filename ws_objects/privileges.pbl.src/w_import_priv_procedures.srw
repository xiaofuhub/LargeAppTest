$PBExportHeader$w_import_priv_procedures.srw
forward
global type w_import_priv_procedures from window
end type
type dw_lookup from datawindow within w_import_priv_procedures
end type
type cb_sort from commandbutton within w_import_priv_procedures
end type
type cb_delete from commandbutton within w_import_priv_procedures
end type
type cb_save from commandbutton within w_import_priv_procedures
end type
type cb_import from commandbutton within w_import_priv_procedures
end type
type cb_close from commandbutton within w_import_priv_procedures
end type
type dw_import from datawindow within w_import_priv_procedures
end type
end forward

global type w_import_priv_procedures from window
integer width = 3922
integer height = 2132
boolean titlebar = true
string title = "Import Privilege Procedures"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
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
global w_import_priv_procedures w_import_priv_procedures

on w_import_priv_procedures.create
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

on w_import_priv_procedures.destroy
destroy(this.dw_lookup)
destroy(this.cb_sort)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_import)
destroy(this.cb_close)
destroy(this.dw_import)
end on

type dw_lookup from datawindow within w_import_priv_procedures
integer x = 3067
integer y = 196
integer width = 795
integer height = 1820
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup_priv_ca_sect"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_sort from commandbutton within w_import_priv_procedures
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

type cb_delete from commandbutton within w_import_priv_procedures
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

type cb_save from commandbutton within w_import_priv_procedures
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
string ls_find2

ic = dw_import.rowcount()
//debugbreak()
dw_lookup.retrieve()


for i = 1 to ic
	ls_ca = dw_import.getitemstring(i,"ca_description")
	ls_find = 'description = "' + ls_ca + ' " and lookup_name = "Priv Clinical Area" '  //Start Code Change ----10.07.2013 #V14 maha 
//		ls_find = "description = '" + ls_ca + "' " + " and lookup_name = 'Priv Clinical Area' "   //Start Code Change ----09.23.2013 #V14 maha - recorrect find strings
	li_find = dw_lookup.find( ls_find ,1,100000)
	if li_find < 0 then
		messagebox("Find failure","find failure for clin area~r" + ls_find )
		return 0
	end if
	if li_find = 0 then
		nr = dw_lookup.insertrow(0)
		dw_lookup.setitem( nr, "description", ls_ca)
		dw_lookup.setitem( nr, "code", upper(mid(ls_ca,1,9)))
		dw_lookup.setitem( nr, "lookup_name", "Priv Clinical Area")
	end if
next

for i = 1 to ic
	ls_sect = dw_import.getitemstring(i,"sect_desc")
	ls_find = 'description = "' + ls_sect + ' " and lookup_name = "Priv Section" '	//Start Code Change ----10.07.2013 #V14 maha -
//	ls_find = "description = '" + ls_sect + "'"  + " and lookup_name = 'Priv Section' "    //Start Code Change ----09.23.2013 #V14 maha - recorrect find strings
//	ls_find = "description = '" + ls_sect + ' " and lookup_name = "Priv Section" '  //Start Code Change ----08.14.2013 #V14 maha - modified for apostrophie
	li_find = dw_lookup.find(ls_find ,1 ,1000000)
		if li_find < 0 then
		messagebox("Find failure","find failure for Section~r" + ls_find )
		return 0
	end if
	if li_find < 1 then
		nr = dw_lookup.insertrow(0)
		dw_lookup.setitem( nr, "description", ls_sect)
		dw_lookup.setitem( nr, "code", upper(mid(ls_sect,1,9)))
		dw_lookup.setitem( nr, "lookup_name", "Priv Section")
	end if
next

lrc = dw_lookup.rowcount()
ll_code = gnv_app.of_get_id( "LOOKUP", lrc )

for i = 1 to lrc   
	if isnull(dw_lookup.getitemnumber(i, "lookup_code")) then  //Start Code Change ----08.22.2013 #V14 maha
		dw_lookup.setitem(i,"lookup_code",ll_code)
		ll_code++
	end if
next

for i = 1 to ic
	dw_import.setitem( i, "facility_specific", 0)
	dw_import.setitem(i,"active_status", 1)
	ls_ca = dw_import.getitemstring(i,"ca_description")
//	ls_find = 'description = "' + ls_ca + '" and lookup_name = "Priv Clinical Area" '
//	ls_find = "description = '" + ls_ca + "' " + " and lookup_name = 'Priv Clinical Area' "   //Start Code Change ----09.23.2013 #V14 maha - recorrect find strings
	ls_find = 'description = "' + ls_ca + ' " and lookup_name = "Priv Clinical Area" '   //Start Code Change ----10.07.2013 #V14 maha -
	li_find = dw_lookup.find( ls_find      ,1,100000)
	if li_find < 0 then
		messagebox("Find failure","find failure for clin area (2)~r" + ls_find )
		return 0
	end if
	if li_find > 0 then
		ll_code = dw_lookup.getitemnumber( li_find, "lookup_code")
		dw_import.setitem( i, "clinical_area_id", ll_code)
	end if
next

for i = 1 to ic
	debugbreak()
	ls_sect = dw_import.getitemstring(i,"sect_desc")  //Start Code Change ----02.04.2014 #V14 maha - corrected variable
	ls_find2 = 'description = "' + ls_sect + ' " and lookup_name = "Priv Section" '  //Start Code Change ----10.07.2013 #V14 maha -
//	ls_find2 = "description = '" + ls_ca + "'" + " and lookup_name = 'Priv Section' "    //Start Code Change ----09.23.2013 #V14 maha - recorrect find strings
	li_find = dw_lookup.find( ls_find2    ,1,100000)
//	li_find = dw_lookup.find('description = "' + ls_ca + ' " and lookup_name = "Priv Section" '    ,1,100000)   //Start Code Change ----08.14.2013 #V14 maha - modified for apostrophie
	if li_find < 0 then
		messagebox("Find failure","find failure for Section (2)~r~r" + ls_find2 )
		return 0
	end if
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
next


dw_lookup.update()
dw_import.update()

messagebox("Procedure Import","Completed.  " + string(ic) + " procedures imported.")
end event

type cb_import from commandbutton within w_import_priv_procedures
integer x = 1669
integer y = 68
integer width = 475
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

dw_import.reset()

//---------Begin Modified by (Appeon)Stephen 02.17.2014 for file paths modify --------
//if  GetFileOpenName("Select File",    pathandfile, file, "TXT",  "Text Files (*.TXT),*.TXT",    "C:\IntelliCred\", 18) < 1 then return
if  GetFileOpenName("Select File",    pathandfile, file, "TXT",  "Text Files (*.TXT),*.TXT",   gs_dir_path + gs_DefDirName+ "\", 18) < 1 then return
//---------End Modfiied ------------------------------------------------------
 
dw_import.importfile(pathandfile)
 
 
end event

type cb_close from commandbutton within w_import_priv_procedures
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

type dw_import from datawindow within w_import_priv_procedures
integer x = 14
integer y = 196
integer width = 3045
integer height = 1820
integer taborder = 10
string title = "none"
string dataobject = "d_priv_procd_import"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

