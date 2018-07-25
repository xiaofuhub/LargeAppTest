$PBExportHeader$w_import_iapp.srw
forward
global type w_import_iapp from window
end type
type rb_2 from radiobutton within w_import_iapp
end type
type rb_1 from radiobutton within w_import_iapp
end type
type cbx_reset from checkbox within w_import_iapp
end type
type dw_fac from datawindow within w_import_iapp
end type
type cb_1 from commandbutton within w_import_iapp
end type
type dw_fields from datawindow within w_import_iapp
end type
type sle_fields from singlelineedit within w_import_iapp
end type
type cb_getapp from commandbutton within w_import_iapp
end type
type cb_import from commandbutton within w_import_iapp
end type
type cb_11 from commandbutton within w_import_iapp
end type
type dw_hdr from datawindow within w_import_iapp
end type
type cb_10 from commandbutton within w_import_iapp
end type
type cb_3 from commandbutton within w_import_iapp
end type
type sle_hdr from singlelineedit within w_import_iapp
end type
type gb_1 from groupbox within w_import_iapp
end type
end forward

global type w_import_iapp from window
integer x = 197
integer y = 124
integer width = 2752
integer height = 2356
boolean titlebar = true
string title = "Data update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
rb_2 rb_2
rb_1 rb_1
cbx_reset cbx_reset
dw_fac dw_fac
cb_1 cb_1
dw_fields dw_fields
sle_fields sle_fields
cb_getapp cb_getapp
cb_import cb_import
cb_11 cb_11
dw_hdr dw_hdr
cb_10 cb_10
cb_3 cb_3
sle_hdr sle_hdr
gb_1 gb_1
end type
global w_import_iapp w_import_iapp

type variables
string is_dwname
end variables

on w_import_iapp.create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_reset=create cbx_reset
this.dw_fac=create dw_fac
this.cb_1=create cb_1
this.dw_fields=create dw_fields
this.sle_fields=create sle_fields
this.cb_getapp=create cb_getapp
this.cb_import=create cb_import
this.cb_11=create cb_11
this.dw_hdr=create dw_hdr
this.cb_10=create cb_10
this.cb_3=create cb_3
this.sle_hdr=create sle_hdr
this.gb_1=create gb_1
this.Control[]={this.rb_2,&
this.rb_1,&
this.cbx_reset,&
this.dw_fac,&
this.cb_1,&
this.dw_fields,&
this.sle_fields,&
this.cb_getapp,&
this.cb_import,&
this.cb_11,&
this.dw_hdr,&
this.cb_10,&
this.cb_3,&
this.sle_hdr,&
this.gb_1}
end on

on w_import_iapp.destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_reset)
destroy(this.dw_fac)
destroy(this.cb_1)
destroy(this.dw_fields)
destroy(this.sle_fields)
destroy(this.cb_getapp)
destroy(this.cb_import)
destroy(this.cb_11)
destroy(this.dw_hdr)
destroy(this.cb_10)
destroy(this.cb_3)
destroy(this.sle_hdr)
destroy(this.gb_1)
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
end event

event close;//disCONNECT USING SQLCA;
end event

type rb_2 from radiobutton within w_import_iapp
integer x = 709
integer y = 456
integer width = 1541
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
boolean enabled = false
string text = "Replace existing (use only if replacing for same app_id)"
end type

event clicked;cbx_reset.checked = false
end event

type rb_1 from radiobutton within w_import_iapp
integer x = 187
integer y = 460
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "New apps"
boolean checked = true
end type

event clicked;cbx_reset.checked = true
end event

type cbx_reset from checkbox within w_import_iapp
integer x = 1193
integer y = 308
integer width = 352
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 32891346
boolean enabled = false
string text = "Reset IDs"
boolean checked = true
end type

type dw_fac from datawindow within w_import_iapp
integer x = 87
integer y = 300
integer width = 1070
integer height = 96
integer taborder = 90
string dataobject = "d_app_facil_utl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_1 from commandbutton within w_import_iapp
integer x = 2423
integer y = 184
integer width = 247
integer height = 84
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("About Importing","Browse to and select previously created import files. Clicking Import will add the files to the database resetting app_ids to next number.  A new facility with the day's date will be created.")
end event

type dw_fields from datawindow within w_import_iapp
integer x = 78
integer y = 1140
integer width = 2542
integer height = 968
integer taborder = 40
string dataobject = "d_app_field_prop"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type sle_fields from singlelineedit within w_import_iapp
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

type cb_getapp from commandbutton within w_import_iapp
integer x = 1806
integer y = 184
integer width = 558
integer height = 84
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "2) Get app prop file"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value
gf_load_dir_path() //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
gf_save_dir_path(docname) //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX

IF value = 1 THEN
	sle_fields.text = docname
END IF
end event

type cb_import from commandbutton within w_import_iapp
integer x = 1806
integer y = 308
integer width = 558
integer height = 84
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3) Import Apps"
end type

event clicked;string object
string hdr_file
string fields_file
string mes
long ll_code
long ll_appid
long ll_facid
long ll_app_org
long i
integer a
long rc
long ac

//dw_table.dataobject = is_dwname
//if is_dwname = "None" then return
dw_hdr.settransobject(sqlca)
dw_hdr.reset()
dw_fields.settransobject(sqlca)
dw_fields.reset()
hdr_file = sle_hdr.text
fields_file = sle_fields.text

if hdr_file = "" or fields_file = "" then 
	messagebox("?","Need both file names")
	return
end if

if not fileexists(hdr_file) then 
	messagebox("Hrd file","Can't find file    " + hdr_file)
	return
end if
if not fileexists(fields_file) then 
	messagebox("App file","Can't find file    " + fields_file)
	return
end if


rc = dw_hdr.importfile(hdr_file)
ac = dw_fields.importfile(fields_file)


SELECT max(facility_id) 
INTO :ll_facid 
FROM app_facility;
if ll_facid < 1 or isnull(ll_facid) then ll_facid = 0	
ll_facid ++
dw_fac.settransobject(sqlca)
dw_fac.insertrow(1)
dw_fac.setitem(1,"facility_id",ll_facid)
dw_fac.setitem(1,"facility_name","New Apps " + string(today()))

SELECT max(app_id) 
		INTO :ll_appid 
		FROM app_hdr;
		if ll_appid < 1 or isnull(ll_appid) then ll_appid = 0
			
SELECT max(app_field_id) 
		INTO :ll_code 
		FROM app_field_prop;
		if ll_code < 1 or isnull(ll_code) then ll_code = 0		
		

if cbx_reset.checked = true then
	SELECT max(app_id) 
	INTO :ll_appid 
	FROM app_hdr;
	if ll_appid < 1 or isnull(ll_appid) then ll_appid = 0
			
	SELECT max(app_field_id) 
	INTO :ll_code 
	FROM app_field_prop;
	if ll_code < 1 or isnull(ll_code) then ll_code = 0
		
	for a = 1 to ac //save original app id
			dw_fields.setitem(a,"box_no_x",dw_fields.getitemnumber(a,"app_id"))
	next		
			//messagebox("box set","")
	for i = 1 to rc //save original app id
			dw_hdr.setitem(i,"two_sided",dw_hdr.getitemnumber(i,"app_id"))
	next		
			//messagebox("2-side set","")
		

	FOR i = 1 TO rc //for each app record
		ll_appid++
		ll_app_org = dw_hdr.getitemnumber(i,"two_sided")
		//messagebox("ll_app_org",ll_app_org)
		//messagebox("ll_appid",ll_appid)
		dw_hdr.setitem(i,"app_id",ll_appid)
		for a = 1 to ac //for each field record set the new appid
			//if dw_fields.getitemnumber(a,"box_no_x") <> "Y" then
				if dw_fields.getitemnumber(a,"box_no_x") = ll_app_org then
					dw_fields.setitem(a,"app_id",ll_appid)
					
					//dw_fields.setitem(a,"box_no_value","Y")
			//	end if
			end if
			//ll_code++
			//dw_fields.setitem(a,"app_field_id",ll_code)
		next
		dw_hdr.setitem(i,"facility_id",ll_facid)
	
			//messagebox("ll_lookup_code",ll_appid)
	NEXT	
	
else //reset false
	messagebox("Reset off","Are you sure you wish to replace the mapping for existing applications with the same id number?")
end if

for a = 1 to ac
	ll_code++
	dw_fields.setitem(a,"app_field_id",ll_code)
next


if dw_hdr.update() < 1 then
	messagebox("","Unable to update app hdr")
	return
end if
	
if dw_fac.update() < 1 then
	messagebox("","Unable to update app facility")
	return
end if

	
if dw_fields.update() < 1 then
	messagebox("","Unable to update app fields")
	return
end if

commit using sqlca;
messagebox("Done","Import complete")
end event

type cb_11 from commandbutton within w_import_iapp
integer x = 869
integer y = 2136
integer width = 997
integer height = 84
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Delete ALL Intelliapp Training"
end type

event clicked;integer res

res = messagebox("Are you sure?","Are you sure you wish to delete ALL existing intelliapp mapping?",question!,yesno!,2)

if res = 2 then 
	return
else
	res = messagebox("Are you positive?","You really want to delete ALL existing intelliapp mapping?",question!,yesno!,2)
end if

if res = 2 then 
	return
else
	res = messagebox("Really, really positive?","Are you absolutely positive you want to delete ALL mapping for ALL applications?",question!,yesno!,2)
end if

if res = 2 then return

delete from app_field_prop;
delete from app_hdr;
end event

type dw_hdr from datawindow within w_import_iapp
integer x = 78
integer y = 556
integer width = 2537
integer height = 564
integer taborder = 30
string dataobject = "d_app_hdr_ids"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_10 from commandbutton within w_import_iapp
integer x = 1806
integer y = 64
integer width = 558
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "1) Get hdr file"
end type

event clicked;//sle_1.text = "C:\intellicred\lehigh_addr_new.txt"
//sle_2.text = "dba.addr_new"

string docname, named

integer value
gf_load_dir_path() //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX
value = GetFileOpenName("Select File",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
gf_save_dir_path(docname) //(Appeon)Eugene 06.06.2013 - V141 ISG-CLX

IF value = 1 THEN
	sle_hdr.text = docname
END IF
end event

type cb_3 from commandbutton within w_import_iapp
integer x = 2427
integer y = 64
integer width = 247
integer height = 84
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

type sle_hdr from singlelineedit within w_import_iapp
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

type gb_1 from groupbox within w_import_iapp
integer x = 91
integer y = 396
integer width = 2519
integer height = 156
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32891346
string text = "New/Existing"
end type

