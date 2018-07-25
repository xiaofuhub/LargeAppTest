$PBExportHeader$w_send_file.srw
forward
global type w_send_file from window
end type
type cb_viewfile from commandbutton within w_send_file
end type
type cb_parse from commandbutton within w_send_file
end type
type cb_rcv_2 from commandbutton within w_send_file
end type
type rb_imp from radiobutton within w_send_file
end type
type rb_exp from radiobutton within w_send_file
end type
type cb_rcv_1 from commandbutton within w_send_file
end type
type cb_view from commandbutton within w_send_file
end type
type dw_bad_pracs from datawindow within w_send_file
end type
type st_process from statictext within w_send_file
end type
type st_1 from statictext within w_send_file
end type
type cb_step_2 from commandbutton within w_send_file
end type
type cb_step_1 from commandbutton within w_send_file
end type
type st_hipdb from statictext within w_send_file
end type
type st_npdb from statictext within w_send_file
end type
type dw_select_org_facility from pfc_cst_u_org_facility_selector_horiz within w_send_file
end type
type cb_step_4 from commandbutton within w_send_file
end type
type cb_cancel from commandbutton within w_send_file
end type
type cb_step_3 from commandbutton within w_send_file
end type
type dw_verifsold from datawindow within w_send_file
end type
type dw_hipdb from datawindow within w_send_file
end type
type gb_3 from groupbox within w_send_file
end type
type gb_2 from groupbox within w_send_file
end type
type gb_1 from groupbox within w_send_file
end type
type dw_verifs from u_dw within w_send_file
end type
end forward

global type w_send_file from window
integer x = 750
integer y = 248
integer width = 1952
integer height = 1636
boolean titlebar = true
string title = "NPDB File Transfer"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_viewfile cb_viewfile
cb_parse cb_parse
cb_rcv_2 cb_rcv_2
rb_imp rb_imp
rb_exp rb_exp
cb_rcv_1 cb_rcv_1
cb_view cb_view
dw_bad_pracs dw_bad_pracs
st_process st_process
st_1 st_1
cb_step_2 cb_step_2
cb_step_1 cb_step_1
st_hipdb st_hipdb
st_npdb st_npdb
dw_select_org_facility dw_select_org_facility
cb_step_4 cb_step_4
cb_cancel cb_cancel
cb_step_3 cb_step_3
dw_verifsold dw_verifsold
dw_hipdb dw_hipdb
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_verifs dw_verifs
end type
global w_send_file w_send_file

type prototypes

end prototypes

type variables
String is_parent_facility_id
String is_file_name
integer ii_up_check
string is_exceptions 
string is_parse
string ls_retr_type
end variables

forward prototypes
public function integer of_qprac (datawindow adw_action_items)
end prototypes

public function integer of_qprac (datawindow adw_action_items);n_ds lds_action_items
n_ds lds_name
n_ds lds_license
n_ds lds_school
n_ds lds_address
n_ds lds_npdb_fields
Integer li_FileNum
Integer li_pad_len
Integer li_num_sent
Integer li_field_len
Integer li_name_rc
Integer li_license_rc
Integer li_school_rc
Integer li_address_rc
Integer li
Integer li_get_row
Integer li_row_cnt
Integer li_field_cnt
Integer i
Integer f
Integer li_rc
Long ll_prac_id
String ls_field_nm
String ls_record
String ls_header
String ls_section
String ls_field_val
String ls_file_nm

//link to action items screen
lds_action_items = CREATE n_ds
lds_action_items.DataObject = adw_action_items.DataObject
lds_action_items.of_SetTransObject( SQLCA )
adw_action_items.ShareData( lds_action_items )

li_row_cnt = lds_action_items.RowCount()

//npdb fields
lds_npdb_fields = CREATE n_ds
lds_npdb_fields.DataObject = "d_npdb_fields"
lds_npdb_fields.of_SetTransObject( SQLCA )
li_field_cnt = lds_npdb_fields.Retrieve( )

//name info
lds_name = CREATE n_ds
lds_name.DataObject = "d_npdb_name_info"
lds_name.of_SetTransObject( SQLCA )

//address info
lds_address = CREATE n_ds
lds_address.DataObject = "d_npdb_address"
lds_address.of_SetTransObject( SQLCA )

//license info
lds_license = CREATE n_ds
lds_license.DataObject = "d_npdb_license"
lds_license.of_SetTransObject( SQLCA )

//school info
lds_school = CREATE n_ds
lds_school.DataObject = "d_npdb_school"
lds_school.of_SetTransObject( SQLCA )


ls_header = "~~|~~NPDB-Q~~|~~ VER: 3.00"

ls_file_nm = String( Today(), "mmdd" ) + String(Hour(Now())) + String(Second(Now())) + "npdb" + ".txt"
li_FileNum = FileOpen(gs_dir_path + gs_DefDirName + "\NPDB\" + ls_file_nm, LineMode!, Write!, LockWrite!, Replace!)

FileWrite( li_filenum, ls_header )

FOR i = 1 TO li_row_cnt
	
	ls_record = ""
	ll_prac_id = adw_action_items.GetItemNumber( i, "prac_id" )
	//name
	li_name_rc = lds_name.Retrieve( ll_prac_id )		
	IF li_name_rc < 1 THEN
		MessageBox("Retrieve Error", "No data retrieved for name information. (" + String( ll_prac_id ) + ")")
		Return -1
	END IF

	//license
	li_license_rc = lds_license.Retrieve( ll_prac_id )		
	IF li_license_rc < 1 THEN
		MessageBox("Retrieve Error", "No data retrieved for license information. (" + String( ll_prac_id )  + ")")
		Return -1		
	END IF

	//school
	li_school_rc = lds_school.Retrieve( ll_prac_id )		
	IF li_school_rc < 1 THEN
		lds_school.DataObject = "d_npdb_school_other"
		lds_school.of_SetTransObject( SQLCA )
		li_school_rc = lds_school.Retrieve( ll_prac_id )		
		IF li_school_rc < 1 THEN
			MessageBox("Retrieve Error", "No data retrieved for school information. (" + String( ll_prac_id )  + ")")
			Return -1		
		END IF
	END IF

	//address
	li_address_rc = lds_address.Retrieve( ll_prac_id )		
	IF li_address_rc < 1 THEN
		MessageBox("Retrieve Error", "No data retrieved for address information. (" + String( ll_prac_id ) + ")" )
		Return -1		
	END IF

	FOR f = 1 TO li_field_cnt
		ls_field_val = ""
		li_get_row = lds_npdb_fields.GetItemNumber( f, "record_number" )
		ls_section = lds_npdb_fields.GetItemString( f, "dw_name" )
		ls_field_nm = lds_npdb_fields.GetItemString( f, "dw_field_name" )
		li_field_len = lds_npdb_fields.GetItemNumber( f, "field_length" )
		//name
		IF ls_section = "name" THEN
			IF ls_field_nm = "date_of_birth" THEN
				ls_field_val = String(lds_name.GetItemDateTime( 1, ls_field_nm ), "mmddyyyy" )
			ELSE
				ls_field_val = lds_name.GetItemString( 1, ls_field_nm )
			END IF
		END IF
		//address
		IF ls_section = "address" THEN
			ls_field_val = lds_address.GetItemString( 1, ls_field_nm )
		END IF
		//license
		IF ls_section = "license" THEN
			IF li_get_row <= li_license_rc THEN
				ls_field_val = lds_license.GetItemString( li_get_row, ls_field_nm )
			END IF
		END IF
		//school
		IF ls_section = "school" THEN
			IF li_get_row <= li_school_rc THEN
				IF ls_field_nm = "year" THEN
					ls_field_val = String( lds_school.GetItemNumber( li_get_row, ls_field_nm ) )
				ELSE
					ls_field_val = lds_school.GetItemString( li_get_row, ls_field_nm )
				END IF
			END IF
		END IF
		IF IsNull( ls_field_val)  THEN
			ls_field_val = ""
		END IF
		li_pad_len = li_field_len - Len( ls_field_val )
		IF Len( ls_field_val ) > li_field_len THEN
			ls_field_val = Mid( ls_field_val, 1, li_field_len )
		ELSE
			ls_field_val = ls_field_val + Fill( " " , li_pad_len )
		END IF
		IF IsNull( ls_field_val ) THEN
			ls_field_val = Fill( " ", li_field_len )
		END IF
		ls_record = ls_record + ls_field_val
	END FOR
	FileWrite( li_filenum, ls_record )

	//update action item dates
	li_num_sent = adw_action_items.GetItemNumber( i, "number_sent" )
	li_num_sent++
	adw_action_items.SetItem( i, "number_sent", 1 )
	adw_action_items.SetItem( i, "print_flag", 0 )
	IF IsNull( adw_action_items.GetItemDateTime( i, "first_sent" ) ) THEN
			adw_action_items.SetItem( i, "first_sent", DateTime(Today(), Now()) )
	END IF
	adw_action_items.SetItem( i, "last_sent", DateTime(Today(), Now()) )

END FOR

//update the action item detail view by updating then re-retrieving data
IF adw_action_items.Update() <> 1 THEN
	MessageBox("Update Failed", "Error while updating " + adw_action_items.DataObject )
	Return -1
ELSE
	COMMIT USING SQLCA;
	adw_action_items.Retrieve()
END IF

FileClose( li_filenum )

MessageBox("NPDB", "The NPDB export file has be saved as " + gs_dir_path + gs_DefDirName + "\npdb\"+ ls_file_nm )

Return 0
end function

on w_send_file.create
this.cb_viewfile=create cb_viewfile
this.cb_parse=create cb_parse
this.cb_rcv_2=create cb_rcv_2
this.rb_imp=create rb_imp
this.rb_exp=create rb_exp
this.cb_rcv_1=create cb_rcv_1
this.cb_view=create cb_view
this.dw_bad_pracs=create dw_bad_pracs
this.st_process=create st_process
this.st_1=create st_1
this.cb_step_2=create cb_step_2
this.cb_step_1=create cb_step_1
this.st_hipdb=create st_hipdb
this.st_npdb=create st_npdb
this.dw_select_org_facility=create dw_select_org_facility
this.cb_step_4=create cb_step_4
this.cb_cancel=create cb_cancel
this.cb_step_3=create cb_step_3
this.dw_verifsold=create dw_verifsold
this.dw_hipdb=create dw_hipdb
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_verifs=create dw_verifs
this.Control[]={this.cb_viewfile,&
this.cb_parse,&
this.cb_rcv_2,&
this.rb_imp,&
this.rb_exp,&
this.cb_rcv_1,&
this.cb_view,&
this.dw_bad_pracs,&
this.st_process,&
this.st_1,&
this.cb_step_2,&
this.cb_step_1,&
this.st_hipdb,&
this.st_npdb,&
this.dw_select_org_facility,&
this.cb_step_4,&
this.cb_cancel,&
this.cb_step_3,&
this.dw_verifsold,&
this.dw_hipdb,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.dw_verifs}
end on

on w_send_file.destroy
destroy(this.cb_viewfile)
destroy(this.cb_parse)
destroy(this.cb_rcv_2)
destroy(this.rb_imp)
destroy(this.rb_exp)
destroy(this.cb_rcv_1)
destroy(this.cb_view)
destroy(this.dw_bad_pracs)
destroy(this.st_process)
destroy(this.st_1)
destroy(this.cb_step_2)
destroy(this.cb_step_1)
destroy(this.st_hipdb)
destroy(this.st_npdb)
destroy(this.dw_select_org_facility)
destroy(this.cb_step_4)
destroy(this.cb_cancel)
destroy(this.cb_step_3)
destroy(this.dw_verifsold)
destroy(this.dw_hipdb)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_verifs)
end on

event closequery;//integer i 
//
//if ii_up_check = 1 then
//	i = messagebox("Update not complete.","You have created the NPDB file, but you have not completed the entire process.  ~rTo update the verification records, you must click the CHECK STATUS CODE button.~rDo you wish to close without updating?" ,question!,yesno!,2)
//	if i = 2 then return
//end if
//	
end event

event open;integer li_8

select set_8 into :li_8 from icred_settings;
li_8 = of_get_app_setting("set_8","I")

//if li_8 = 0 then //qprac
//	//messagebox("","qprac")
//	w_send_file.height = 900
//	cb_parse.visible = false
//	cb_rcv_1.visible = false
//	cb_rcv_2.visible = false
//	cb_step_1.visible = false
//	cb_step_2.visible = false
//	cb_step_3.visible = false
//	cb_step_4.visible = false
//	rb_imp.visible = false
//	rb_exp.visible = false
//	gb_1.visible = false
//	gb_2.visible = false	
//	gb_3.visible = false	
//	cb_cancel.y = 625
//	cb_qprac.visible = true
//	st_npdb.text = "Select Parent Facility"
//
//else
//	cb_qprac.visible = false
//end if

ls_retr_type = message.stringparm
//messagebox("",ls_retr_type)
end event

type cb_viewfile from commandbutton within w_send_file
integer x = 1047
integer y = 868
integer width = 754
integer height = 84
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View File"
end type

event clicked;string docname, named
integer value

//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
value = GetFileOpenName("Select File from " + gs_dir_path + gs_DefDirName + "\NPDB\Download directory",&
+ docname, named, "DOC", &
	+ "All Files (*.*),*.*")
//+ "CSM Files (*.csm),*.csm")
//gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
//---------End Modfiied ------------------------------------------------------


IF value = 1 THEN
	
END IF
end event

type cb_parse from commandbutton within w_send_file
boolean visible = false
integer x = 1422
integer y = 1012
integer width = 379
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
end type

event clicked;openwithparm(w_npdb_exceptions,is_parse )
w_npdb_exceptions.title = "File Translation"
end event

type cb_rcv_2 from commandbutton within w_send_file
boolean visible = false
integer x = 1042
integer y = 1012
integer width = 375
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
end type

event clicked;string ls_file_name
Integer li_filenum
String ls_sub_file
string docname, named
integer value
integer li_len
integer li_len1
long pos_isubj
long pos_cuse
long pos_qsta
long pos_trlr
long pos_l1
long pos_l2
long pos_next
long c
long lc
string sub
string ls_name
string st
integer li_prac_count = 0

is_parse = ""

/*i the response file the data sections should appear in the following order
HDR
QSTA	 will repeat
ISUBJ  will repeat
CUSE	 will repeat
TRLR

*/
//---------Begin Modified by (Appeon)Harry 06.05.2013 for V141 ISG-CLX--------
//gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
value = GetFileOpenName("Select File from " + gs_dir_path + gs_DefDirName + "\NPDB\Download directory",&
+ docname, named, "DOC", &
	+ "All Files (*.*),*.*")
//+ "CSM Files (*.csm),*.csm")
//gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008
//---------End Modfiied ------------------------------------------------------

IF value = 1 THEN
	ls_file_name = docname
END IF
//messagebox("", is_file_name )
li_FileNum = FileOpen( ls_file_name , streammode! , Read!, LockWrite!, Replace!)
FileRead( li_filenum, ls_sub_file )
//MessageBox("file", ls_sub_file )
//FileRead( li_filenum, ls_sub_file )
//MessageBox("file", ls_sub_file )
//FileRead( li_filenum, ls_sub_file )
//MessageBox("file", ls_sub_file )
//FileRead( li_filenum, ls_sub_file )
//MessageBox("file", ls_sub_file )
li_len = len(ls_sub_file)
//MessageBox("file length", li_len )
//sub = mid(ls_sub_file,li_len - 6 ,li_len)
//MessageBox("file", sub )
pos_qsta = 1 
pos_isubj = 1
pos_cuse = 1
//MessageBox("pos_id", pos_id )
pos_trlr = Pos ( ls_sub_file, "TRLR" ,1 )
//MessageBox("pos_trl", pos_trl )


//do until pos_qsta = 0
li_prac_count++
pos_qsta = Pos ( ls_sub_file, "QSTA" ,pos_qsta + 1 )
pos_isubj = Pos ( ls_sub_file, "ISUBJ" ,pos_isubj + 1 )	
pos_cuse = Pos ( ls_sub_file, "CUSE" ,pos_cuse + 1 )
//QSTA data
is_parse = "Response Data:~r"
pos_l1 = Pos ( ls_sub_file, "@" ,pos_qsta )
//MessageBox("pos_l1", pos_l1 )
pos_l1 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
//MessageBox("pos_l2", pos_l2 )
pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
sub = mid(ls_sub_file,pos_l1 + 1,pos_l2 - pos_l1 - 1)//getting response type
choose case sub
	case "M"
		ls_name = "Match"
	case "N"
		ls_name = "No Match"
	case ""
		ls_name = "Rejected"
	case "P"
		ls_name = "Pending"
end choose
is_parse = is_parse + " " + ls_name + ","
//messagebox("response type",sub)
pos_l1 = pos_l2	
pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
is_parse = is_parse + " Errors: "
do while pos_l2 + 2 < pos_isubj
	pos_l1 = pos_l2	
	pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
	sub = mid(ls_sub_file,pos_l1 + 1,pos_l2 - pos_l1 - 1)//getting error
	is_parse = is_parse + " " + sub + ","
	//messagebox("response",sub)
loop
debugbreak()
//doc_id ISUBJ
is_parse = is_parse + "~rPractitioner: "
pos_l1 = Pos ( ls_sub_file, "@" ,pos_isubj + 5 )
pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
//MessageBox("pos_isubj", pos_isubj )
//MessageBox("pos_l1", pos_l1 )
sub = mid(ls_sub_file,pos_l1 + 1,pos_l2 - pos_l1 - 1)//last name
ls_name = sub
pos_l1 = pos_l2	
pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
//pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
sub = mid(ls_sub_file,pos_l1 + 1,pos_l2 - pos_l1 - 1)//first name
ls_name = ls_name + ", " + sub
is_parse = is_parse + ls_name

//doc_id CUSE
is_parse = is_parse + "~rDocid: "
pos_l1 = Pos ( ls_sub_file, "@" ,pos_cuse + 4 )
pos_l2 = Pos ( ls_sub_file, "@" ,pos_l1 + 1 )
sub = mid(ls_sub_file,pos_l1 + 1,pos_l2 - pos_l1 - 1)//docid
is_parse = is_parse + sub






//loop



//li_sub_file = Mid( ls_sub_file, 1, Len( ls_sub_file ) -1)
//MessFileNum = FileOpen( is_file_name , StreamMode!, Write!, LockWrite!, Replace!)
//ls_ageBox("", ls_sub_file )
//FileWrite( li_filenum, ls_sub_file )
//FileClose( li_filenum )




FileClose( li_filenum )
messagebox("Translate file","Translation completed")
//openwithparm(w_npdb_exceptions,is_parse )
end event

type rb_imp from radiobutton within w_send_file
integer x = 1275
integer y = 588
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Import"
end type

event clicked;cb_step_1.enabled = false
cb_step_2.enabled = false
cb_step_3.enabled = false
cb_step_4.enabled = false
cb_view.enabled = false

cb_rcv_1.Enabled = True 

end event

type rb_exp from radiobutton within w_send_file
integer x = 393
integer y = 588
integer width = 256
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Export"
end type

event clicked;cb_rcv_1.enabled = false

if long(is_parent_facility_id) > 0 then
	cb_step_1.Enabled = True 
end if

end event

type cb_rcv_1 from commandbutton within w_send_file
integer x = 1042
integer y = 760
integer width = 763
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Retrieve Exported Files"
end type

event clicked;//Integer li_filenum
//String ls_sub_file
//messagebox("", is_file_name )
//li_FileNum = FileOpen( is_file_name , StreamMode!, Read!, LockWrite!, Replace!)
//FileRead( li_filenum, ls_sub_file )
//MessageBox("just read", ls_sub_file )
//FileClose( li_filenum )
//
//li_sub_file = Mid( ls_sub_file, 1, Len( ls_sub_file ) -1)
//MessFileNum = FileOpen( is_file_name , StreamMode!, Write!, LockWrite!, Replace!)
//ls_ageBox("", ls_sub_file )
//FileWrite( li_filenum, ls_sub_file )
//FileClose( li_filenum )
//ii_up_check = 1
Run( gs_dir_path + gs_DefDirName + "\npdb\receive.bat", Maximized! )//orig code 
//Run( "c:\icd\java Itp send", Maximized! )//maha 031302
Integer li_FileNum
Integer i
String ls_retval
String ls_error
Integer li_status_cd

li_FileNum = FileOpen( gs_dir_path + gs_DefDirName + "\npdb\itpstat.dat" ) 

FOR i = 1 TO 10
	FileRead ( li_FileNum, ls_retval )
	IF Pos( Upper( ls_retval ), "STATUSCODE" ) > 0  THEN
		Exit
	END IF
END FOR

//messagebox("", ls_retval)
li_status_cd = Integer( Mid( ls_retval, Pos( ls_retval, "=" ) +1, 100 ))

if li_status_cd < 0 then
	MessageBox("Retrieval Error", "Click Check Status Code for error information." )
else 
	MessageBox("Retrieval Code", "Retrieval Successful" )
end if

//cb_rcv_2.enabled = true
cb_step_4.Enabled = True
cb_viewfile.Enabled = True




end event

type cb_view from commandbutton within w_send_file
integer x = 594
integer y = 1068
integer width = 759
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "No Exceptions"
end type

event clicked;openwithparm(w_npdb_exceptions,is_exceptions )
end event

type dw_bad_pracs from datawindow within w_send_file
boolean visible = false
integer x = 1312
integer y = 788
integer width = 475
integer height = 612
integer taborder = 90
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
end type

type st_process from statictext within w_send_file
integer x = 151
integer y = 420
integer width = 1655
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_send_file
integer y = 1292
integer width = 142
integer height = 148
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

event clicked;dw_verifs.visible = true
parent.height = 2000
parent.width = 3500
parent.x = 10
parent.y = 10
dw_bad_pracs.visible = true
end event

type cb_step_2 from commandbutton within w_send_file
integer x = 512
integer y = 756
integer width = 384
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Verify File"
end type

event clicked;//messagebox("is_file_name",is_file_name)
IF FileExists( is_file_name ) THEN
	MessageBox("Success", "The NPDB upload file was created successfuly.~r" + is_file_name )
	cb_step_3.Enabled = True
ELSE
	MessageBox("Failed", "The NPDB upload file was NOT created successfuly." )
	cb_step_3.Enabled = false
END IF
end event

type cb_step_1 from commandbutton within w_send_file
integer x = 137
integer y = 756
integer width = 375
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Create File"
end type

event clicked;Integer li_parent_facility_id
String ls_param
integer c

this.enabled = false

if not(fileexists(gs_dir_path + gs_DefDirName + "\npdb\itp.ini")) then
	messagebox("File not found","Unable to find file itp.ini, check if itp.ini file is in " + gs_dir_path + gs_DefDirName + "\npdb directory.~r If this directory does not exist you will not be able to continue. ")
	return -1
end if
//ls_command = " intellicred client-f1*c:\icd\"
ii_up_check = 0
pfc_n_cst_npdb lnv_npdb

lnv_npdb = CREATE pfc_n_cst_npdb

ls_param = " intellicred client-f" + String( is_parent_facility_id ) + "*" + gs_dir_path + gs_DefDirName + "\npdb"

st_npdb.text = "Retrieving practitioner NPDB records for processing."
st_hipdb.text = "Retrieving HIPDB records for processing."
is_file_name = lnv_npdb.of_npdb_sub( ls_param )

IF is_file_name  <> "-1" THEN
	MessageBox("NPDB", "The NPDB export file has been saved as " + is_file_name )
	cb_step_2.Enabled = True
	cb_step_3.Enabled = True
	ii_up_check = 1
END IF

DESTROY lnv_npdb

Return 0
end event

type st_hipdb from statictext within w_send_file
integer x = 155
integer y = 324
integer width = 1614
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Click Create File button."
alignment alignment = center!
boolean focusrectangle = false
end type

type st_npdb from statictext within w_send_file
integer x = 169
integer y = 240
integer width = 1614
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Parent Facility and Transaction Type."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_select_org_facility from pfc_cst_u_org_facility_selector_horiz within w_send_file
integer x = 361
integer y = 44
integer width = 1211
integer height = 164
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;DataWindowChild dwchild

This.SetTransObject( SQLCA )
This.InsertRow( 0 )

This.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( gs_user_id )

AcceptText()

This.Modify( "facilities_t.text='Select Parent Facility'" )


end event

event itemchanged;call super::itemchanged;Integer li_npdb_cnt
Integer li_hipdb_cnt

is_parent_facility_id = data

//SELECT Count( doc_id )  old select
//INTO :li_npdb_cnt  
//FROM verif_info  
//WHERE ( verif_info.facility_id = :data ) AND  
//      ( verif_info.verification_method = 17 ) AND
//	 ( verif_info.active_status = 1 ) AND
//	 ( verif_info.number_sent < 1 );

//SELECT Count(distinct doc_id )  //new select 031302 maha
//INTO :li_npdb_cnt  
//FROM verif_info , pd_affil_stat
//WHERE (verif_info.facility_id = pd_affil_stat.parent_facility_id) and
//	( verif_info.facility_id = :data ) AND  
//      ( verif_info.verification_method = 17 ) AND
//	 ( verif_info.active_status = 1 ) AND
//	 ( pd_affil_stat.active_status = 1 ) AND
//	 ( verif_info.number_sent < 1 );
//	 
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
//	Return -1
//END IF
//
//st_npdb.Text = "There are " + String( li_npdb_cnt ) + " NPDB queries that have to be processed."
//
//
//SELECT Count( doc_id )  
//INTO :li_hipdb_cnt  
//FROM verif_info  
//WHERE ( verif_info.direct_parent_facility_link = :data ) AND  
//      ( verif_info.verification_method = 14 ) AND
//	 ( verif_info.active_status = 1 )  AND
//	 ( verif_info.number_sent < 1 )   ;
//	 
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("SQL ERROR", SQLCA.SQLERRTEXT )
//	Return -1
//END IF
//
//st_hipdb.Text = "There are " + String( li_hipdb_cnt ) + " HIPDB queries that have to be processed."
//

IF rb_exp.checked = true THEN
	cb_step_1.Enabled = True 
elseif rb_imp.checked = true THEN
	cb_rcv_1.Enabled = True
end if
	//cb_step_2.Enabled = True
	//cb_step_3.Enabled = True
	//cb_step_4.Enabled = True
//END IF
end event

type cb_step_4 from commandbutton within w_send_file
integer x = 594
integer y = 1176
integer width = 763
integer height = 84
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Check Status Code"
end type

event clicked;Integer li_FileNum
Integer i
String ls_retval
String ls_error
Integer li_status_cd
integer res

li_FileNum = FileOpen( gs_dir_path + gs_DefDirName + "\npdb\itpstat.dat" ) 

FOR i = 1 TO 10
	FileRead ( li_FileNum, ls_retval )
	IF Pos( Upper( ls_retval ), "STATUSCODE" ) > 0  THEN
		Exit
	END IF
END FOR

//messagebox("", ls_retval)
li_status_cd = Integer( Mid( ls_retval, Pos( ls_retval, "=" ) +1, 100 ))

CHOOSE CASE li_status_cd
	CASE 0
		ls_error = "Success, no errors"

	CASE -1
		ls_error = "Error on NPDB-HPDB server, reattempt transfer."		
	CASE -4
		ls_error = "Database error on NPDB-HIPDB server, reattempt transfer."		
	CASE -18
		ls_error = "Error in downloaded ICD response files, reattempt transfer."		
	CASE -19		
		ls_error = "Error in getting information from the downloaded file, reattempt transfer."		
	CASE -20
		ls_error = "Unable to open downloaded file, check if sufficient disk space is available to download file and reattempt transfer."		
	CASE -21
		ls_error = "Generic error code, some failure occured."		
	CASE -22
		ls_error = "Usage error, check command line parameter."		
	CASE -23 
		ls_error = "Error in reading Initialization file itp.ini, check if itp.ini file is in C:\icp directory."		
	CASE -24
		ls_error = "Unable to open program lg file, check if disk space is available."		
	CASE -25
		ls_error = "Error in username and password validation, check that the Data Bank Id number and Password are correct."		
	CASE -30
		ls_error = "Error validating parameter in itp.ini, a parameter is missing or value is invalid."		
	CASE -31
		ls_error = "Error validating UploadFile, upload file missing or a file listed in the upload file does not exist."		
	CASE -32
		ls_error = "Error validating DownloadDir, directory does not exist.  Check to see if C:\icp\download directory exists."		
	CASE -40
		ls_error = "Error opening connection to NPDB-HIPDB server, check internet connection and reattempt transfer."
	CASE -41
		ls_error = "Error getting input stream to NPDB-HIPDB server, check internet connection and reattempt transfer."		
	CASE -42
		ls_error = "Error getting output stream from NPDB-HIPDB server, check internet connection and reattempt transfer."		
	CASE -50
		ls_error = "Error reading status response from NPDB-HIPDB server, reattempt transfer."		
	CASE -51
		ls_error = "Error processing web request, reattempt transfer."		
	CASE -52
		ls_error = "Error getting status code, reattempt transfer."				
	CASE -53
		ls_error = "Error sending ICD submission files, reattempt transfer."				
	CASE -54
		ls_error = "Error downloading ICD response files, reattempt transfer."				
	CASE	-55
		ls_error = "Error movng ICD response files to the download directory, no permission to write to the directory or the device has run out of space."				
	CASE -56
		ls_error = "Error getting the list of ICD response file downloaded, reattempt transfer."				
	CASE ELSE
		ls_error = "Unkown error message."
END CHOOSE

FileClose( li_FileNum )
		//update the records at this point
		//update the action item detail view by updating then re-retrieving data
if li_status_cd = 0 then
	res = MessageBox( "Return Code  " + string(li_status_cd), ls_error + "~rUpdate Verifications?",Question!,yesno!,1)
	if res = 1 then
		IF dw_verifs.Update() <> 1 THEN
			MessageBox("7 Update Failed", "Error while updating " + dw_verifs.DataObject )
			Return -1
		ELSE
			COMMIT USING SQLCA;
			w_send_file.dw_verifs.reset()
		END IF
		
		IF dw_HIPDB.Update() <> 1 THEN
			MessageBox("7 Update Failed", "Error while updating " + dw_HIPDB.DataObject )
			Return -1
		ELSE
			COMMIT USING SQLCA;
		END IF
		ii_up_check = 0
	end if
else
	MessageBox( "Return Code  " + string(li_status_cd), ls_error )
end if

end event

type cb_cancel from commandbutton within w_send_file
integer x = 594
integer y = 1284
integer width = 763
integer height = 84
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quit"
boolean cancel = true
end type

event clicked;integer i 

if ii_up_check = 1 then
	i = messagebox("Update not complete.","You have created the NPDB file, but you have not completed the entire process.  ~rTo update the verification records, you must click the CHECK STATUS CODE button.~rDo you wish to close without updating?" ,question!,yesno!,2)
	if i = 2 then 
		return
	else
		close(parent)
	end if
else
	close(parent)
end if
end event

type cb_step_3 from commandbutton within w_send_file
integer x = 137
integer y = 864
integer width = 763
integer height = 84
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Start File Transfer"
end type

event clicked;//Integer li_filenum
//String ls_sub_file
//messagebox("", is_file_name )
//li_FileNum = FileOpen( is_file_name , StreamMode!, Read!, LockWrite!, Replace!)
//FileRead( li_filenum, ls_sub_file )
//MessageBox("just read", ls_sub_file )
//FileClose( li_filenum )
//
//li_sub_file = Mid( ls_sub_file, 1, Len( ls_sub_file ) -1)
//MessFileNum = FileOpen( is_file_name , StreamMode!, Write!, LockWrite!, Replace!)
//ls_ageBox("", ls_sub_file )
//FileWrite( li_filenum, ls_sub_file )
//FileClose( li_filenum )
ii_up_check = 1
Run( gs_dir_path + gs_DefDirName + "\npdb\send.bat", Maximized! )//orig code 
//Run( "c:\icd\java Itp send", Maximized! )//maha 031302
MessageBox("Completed", "Click Check Status Code to continue." )
cb_step_4.Enabled = True





end event

type dw_verifsold from datawindow within w_send_file
boolean visible = false
integer x = 1705
integer y = 36
integer width = 215
integer height = 76
integer taborder = 120
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_hipdb from datawindow within w_send_file
integer x = 439
integer y = 868
integer width = 457
integer height = 76
integer taborder = 130
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_3 from groupbox within w_send_file
integer x = 105
integer y = 520
integer width = 1737
integer height = 168
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transaction Type"
end type

type gb_2 from groupbox within w_send_file
integer x = 1001
integer y = 684
integer width = 841
integer height = 340
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Receive File"
end type

type gb_1 from groupbox within w_send_file
integer x = 101
integer y = 684
integer width = 846
integer height = 336
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Send File"
end type

type dw_verifs from u_dw within w_send_file
boolean visible = false
integer x = 18
integer y = 20
integer height = 560
integer taborder = 40
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

