$PBExportHeader$w_import_export.srw
forward
global type w_import_export from window
end type
type rb_exp from radiobutton within w_import_export
end type
type dw_code from datawindow within w_import_export
end type
type dw_auto from datawindow within w_import_export
end type
type cb_getauto from commandbutton within w_import_export
end type
type sle_auto from singlelineedit within w_import_export
end type
type cb_getcode from commandbutton within w_import_export
end type
type sle_code from singlelineedit within w_import_export
end type
type dw_fac from datawindow within w_import_export
end type
type cb_1 from commandbutton within w_import_export
end type
type dw_app from datawindow within w_import_export
end type
type sle_app from singlelineedit within w_import_export
end type
type cb_getapp from commandbutton within w_import_export
end type
type cb_13 from commandbutton within w_import_export
end type
type cb_11 from commandbutton within w_import_export
end type
type dw_table from datawindow within w_import_export
end type
type cb_10 from commandbutton within w_import_export
end type
type cb_3 from commandbutton within w_import_export
end type
type sle_1 from singlelineedit within w_import_export
end type
end forward

global type w_import_export from window
integer x = 613
integer y = 64
integer width = 2670
integer height = 2184
boolean titlebar = true
string title = "Import Export data"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
rb_exp rb_exp
dw_code dw_code
dw_auto dw_auto
cb_getauto cb_getauto
sle_auto sle_auto
cb_getcode cb_getcode
sle_code sle_code
dw_fac dw_fac
cb_1 cb_1
dw_app dw_app
sle_app sle_app
cb_getapp cb_getapp
cb_13 cb_13
cb_11 cb_11
dw_table dw_table
cb_10 cb_10
cb_3 cb_3
sle_1 sle_1
end type
global w_import_export w_import_export

type variables
string is_dwname
integer ii_exp_id
end variables

on w_import_export.create
this.rb_exp=create rb_exp
this.dw_code=create dw_code
this.dw_auto=create dw_auto
this.cb_getauto=create cb_getauto
this.sle_auto=create sle_auto
this.cb_getcode=create cb_getcode
this.sle_code=create sle_code
this.dw_fac=create dw_fac
this.cb_1=create cb_1
this.dw_app=create dw_app
this.sle_app=create sle_app
this.cb_getapp=create cb_getapp
this.cb_13=create cb_13
this.cb_11=create cb_11
this.dw_table=create dw_table
this.cb_10=create cb_10
this.cb_3=create cb_3
this.sle_1=create sle_1
this.Control[]={this.rb_exp,&
this.dw_code,&
this.dw_auto,&
this.cb_getauto,&
this.sle_auto,&
this.cb_getcode,&
this.sle_code,&
this.dw_fac,&
this.cb_1,&
this.dw_app,&
this.sle_app,&
this.cb_getapp,&
this.cb_13,&
this.cb_11,&
this.dw_table,&
this.cb_10,&
this.cb_3,&
this.sle_1}
end on

on w_import_export.destroy
destroy(this.rb_exp)
destroy(this.dw_code)
destroy(this.dw_auto)
destroy(this.cb_getauto)
destroy(this.sle_auto)
destroy(this.cb_getcode)
destroy(this.sle_code)
destroy(this.dw_fac)
destroy(this.cb_1)
destroy(this.dw_app)
destroy(this.sle_app)
destroy(this.cb_getapp)
destroy(this.cb_13)
destroy(this.cb_11)
destroy(this.dw_table)
destroy(this.cb_10)
destroy(this.cb_3)
destroy(this.sle_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END IF

 is_dwname = "None"
 
 dw_fac.settransobject(sqlca)
 dw_fac.retrieve()
 dw_fac.insertrow(1)
end event

event close;//disCONNECT USING SQLCA;
end event

type rb_exp from radiobutton within w_import_export
integer x = 416
integer y = 588
integer width = 754
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Import for selected export"
boolean lefttext = true
end type

type dw_code from datawindow within w_import_export
integer x = 37
integer y = 1744
integer width = 2565
integer height = 316
integer taborder = 110
string dataobject = "d_export_eqivcode_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_auto from datawindow within w_import_export
integer x = 37
integer y = 1384
integer width = 2565
integer height = 348
integer taborder = 100
string dataobject = "d_export_auto_for_imp"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_getauto from commandbutton within w_import_export
integer x = 1806
integer y = 316
integer width = 475
integer height = 76
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "get export auto"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	sle_auto.text = docname
END IF
end event

type sle_auto from singlelineedit within w_import_export
integer x = 82
integer y = 312
integer width = 1691
integer height = 92
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_getcode from commandbutton within w_import_export
integer x = 1806
integer y = 452
integer width = 475
integer height = 76
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "get equiv codes"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	sle_code.text = docname
END IF
end event

type sle_code from singlelineedit within w_import_export
integer x = 82
integer y = 448
integer width = 1691
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_fac from datawindow within w_import_export
integer x = 1234
integer y = 576
integer width = 864
integer height = 104
integer taborder = 140
string dataobject = "d_exp_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;ii_exp_id = integer(data)
end event

type cb_1 from commandbutton within w_import_export
integer x = 2327
integer y = 168
integer width = 247
integer height = 108
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("About Importing","Browse to and select previously created import files. Clinking Import will add the files to the database.  Delete allows you to select data to be deleted for an export")
end event

type dw_app from datawindow within w_import_export
integer x = 37
integer y = 1020
integer width = 2565
integer height = 348
integer taborder = 40
string dataobject = "d_export_fields_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type sle_app from singlelineedit within w_import_export
integer x = 82
integer y = 180
integer width = 1691
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_getapp from commandbutton within w_import_export
integer x = 1806
integer y = 184
integer width = 475
integer height = 76
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "get export fields"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	sle_app.text = docname
END IF
end event

type cb_13 from commandbutton within w_import_export
integer x = 73
integer y = 568
integer width = 247
integer height = 108
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Import "
end type

event clicked;string object
string filetable
string filefields
string fileauto
string fileecodes
string mes
long ll_code
long ll_exp_id
long ll_auto
long ll_fld
long i
integer a
long tc = 0
long ac = 0
long cc = 0
long fc = 0
integer ck = 0

//dw_table.dataobject = is_dwname
//if is_dwname = "None" then return
dw_table.settransobject(sqlca)
dw_table.reset()
dw_app.settransobject(sqlca)
dw_app.reset()
dw_auto.settransobject(sqlca)
dw_auto.reset()
dw_code.settransobject(sqlca)
dw_code.reset()
filetable = sle_1.text
filefields = sle_app.text
fileauto = sle_auto.text
fileecodes = sle_code.text

if rb_exp.checked = true then
	ck = 1
end if


if len(filetable	) > 0 then
	if not fileexists(filetable) then 
		messagebox("Hrd file","Can't find file    " + filetable)
		return
	end if
end if

if len(filefields	) > 0 then
	if not fileexists(filefields) then 
		messagebox("Field file","Can't find file    " + filefields)
		return
	end if
end if

if len(fileauto) > 0 then 
	if not fileexists(fileauto) then 
		messagebox("Auto export file","Can't find file    " + fileauto)
		return
	end if
end if

if len(fileecodes) > 0 then 
	if not fileexists(fileecodes) then 
		messagebox("Auto export file","Can't find file    " + fileecodes)
		return
	end if
end if

if len(filetable) > 0 then
tc = dw_table.importfile(filetable)
end if

if len(filefields) > 0 then
fc = dw_app.importfile(filefields)
end if

if len(fileauto) > 0 then
	ac = dw_auto.importfile(fileauto)
end if

if len(fileecodes) > 0 then
	cc = dw_code.importfile(fileecodes)
end if



		SELECT max(export_id) 
		INTO :ll_exp_id 
		FROM export_header;
		if ll_exp_id < 1 or isnull(ll_exp_id) then ll_exp_id = 0	
		ll_exp_id ++
//		dw_fac.setitem(1,"facility_id",ll_facid)
//		dw_fac.setitem(1,"facility_name","New Apps " + string(today()))
		if ck = 1 then ll_exp_id = ii_exp_id
	
		SELECT max(rec_id) 
		INTO :ll_fld 
		FROM export_fields;
		if ll_fld < 1 or isnull(ll_fld) then ll_fld = 0
			
		SELECT max(auto_export_id) 
		INTO :ll_auto 
		FROM export_auto_settings;
		if ll_auto < 1 or isnull(ll_auto) then ll_auto = 0
		
		SELECT max(export_code_id) 
		INTO :ll_code 
		FROM export_equiv_code;
		if ll_code < 1 or isnull(ll_code) then ll_code = 0
		
if tc > 0 then		
	for a = 1 to tc //hdr
			dw_table.setitem(a,"export_id",ll_exp_id)
	next
end if

if fc > 0 then
	for i = 1 to fc //fields
			dw_app.setitem(i,"export_id",ll_exp_id)
			ll_fld++
			dw_app.setitem(i,"rec_id",ll_fld)
	next	
end if

if ac > 0 then
	for i = 1 to ac //auto
			dw_auto.setitem(i,"export_id",ll_exp_id)
			ll_auto++
			dw_auto.setitem(i,"auto_export_id",ll_auto)
	next
end if

if cc > 0 then
	for i = 1 to cc //codes
			dw_code.setitem(i,"export_id",ll_exp_id)
			ll_code++
			dw_code.setitem(i,"export_code_id",ll_code)
	next
end if

	if dw_table.update() < 1 then
		messagebox("","Unable to update hdr")
		return
	end if
	
	if dw_app.update() < 1 then
		messagebox("","Unable to update fields")
		return
	end if

	if dw_auto.update() < 1 then
		messagebox("","Unable to update auto")
		return
	end if
	
	if dw_code.update() < 1 then
		messagebox("","Unable to update equiv codes")
		return
	end if

	commit using sqlca;
messagebox("Done","Import complete")
end event

type cb_11 from commandbutton within w_import_export
integer x = 2313
integer y = 588
integer width = 261
integer height = 84
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete"
end type

event clicked;open(w_delete_exp)
end event

type dw_table from datawindow within w_import_export
integer x = 37
integer y = 704
integer width = 2565
integer height = 300
integer taborder = 30
string dataobject = "d_export_hdr_for_imp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_10 from commandbutton within w_import_export
integer x = 1806
integer y = 68
integer width = 466
integer height = 76
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "get export hdr"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value

value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")

IF value = 1 THEN
	sle_1.text = docname
END IF
end event

type cb_3 from commandbutton within w_import_export
integer x = 2313
integer y = 44
integer width = 274
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type sle_1 from singlelineedit within w_import_export
integer x = 82
integer y = 64
integer width = 1691
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

