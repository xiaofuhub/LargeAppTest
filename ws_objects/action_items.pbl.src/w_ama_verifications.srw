$PBExportHeader$w_ama_verifications.srw
forward
global type w_ama_verifications from w_main
end type
type cb_parse from commandbutton within w_ama_verifications
end type
type cb_logs from commandbutton within w_ama_verifications
end type
type st_2 from statictext within w_ama_verifications
end type
type cb_close from commandbutton within w_ama_verifications
end type
type cb_save from commandbutton within w_ama_verifications
end type
type dw_pracs from u_dw within w_ama_verifications
end type
type dw_data from u_dw within w_ama_verifications
end type
type dw_status from u_dw within w_ama_verifications
end type
type ole_browser from olecustomcontrol within w_ama_verifications
end type
end forward

global type w_ama_verifications from w_main
integer width = 4046
integer height = 2900
string title = "AMA Verifications"
windowtype windowtype = popup!
long backcolor = 33551856
cb_parse cb_parse
cb_logs cb_logs
st_2 st_2
cb_close cb_close
cb_save cb_save
dw_pracs dw_pracs
dw_data dw_data
dw_status dw_status
ole_browser ole_browser
end type
global w_ama_verifications w_ama_verifications

type variables
long il_pracs[]
long il_batch
long il_pracid
long il_screen
long il_dvid = 1
long il_rec_id
long il_wc_id
long il_facility
long il_entity
string is_save_type = 'N'
string is_prac_names[]
string is_url
string is_type
string is_lookup_search_column_field = "None" 
string is_lookup_search_column_table = "None"
string is_file
string is_parsed_file
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
end variables

forward prototypes
public function integer of_get_prac_data (string as_table, string as_field, long al_entid, string as_filter)
public function integer of_get_image (string as_docid)
public function integer of_get_profile ()
public function integer of_parse_file (string as_file)
public function integer of_security ()
end prototypes

public function integer of_get_prac_data (string as_table, string as_field, long al_entid, string as_filter);string ls_sql
string ls_org
////string ls_table
//string ls_where
//string ls_filter
//string ls_ent_id
//integer r
//
//
////al_entid = 1205
////as_table = "pd_license"
////as_field = "verifying_agency"
//dw_pracs.of_settransobject( sqlca)
//ls_org =  dw_pracs.GetSQLSelect ()
//
//ls_ent_id = string(al_entid)
//
//ls_sql =  "SELECT distinct pd_basic.last_name,   pd_basic.first_name, " + as_table + ".prac_id, " + as_table + ".rec_id FROM "
//ls_sql+= as_table  + ", pd_affil_stat, pd_basic "
//
//ls_where = " WHERE " + as_table + ".prac_id = pd_affil_stat.prac_id AND pd_basic.prac_id = pd_affil_stat.prac_id AND pd_affil_stat.active_status in(1,4)  AND "  //should it be only active?
////ls_where+=  " pd." + as_field + " = " + ls_ent_id
//ls_where+=  as_table + "." + as_field + " = " + ls_ent_id
//
//if len(as_filter) > 3 then
//	ls_where+= " AND " + as_filter
//end if
//
//
//ls_sql+= ls_where
//
//ls_sql+= " ORDER by last_name ASC,first_name ASC ;"
//
////messagebox("",ls_sql)
////clipboard(ls_sql)
//
//r = dw_pracs.of_settransobject( sqlca)
//r = dw_pracs.SetSQLSelect ( ls_sql )
////messagebox(" set sql",r)
//
//r = dw_pracs.Retrieve( )
//
//dw_pracs.SetSQLSelect ( ls_org )


return 1
end function

public function integer of_get_image (string as_docid);//Start Code Change ----07.15.2016 #V153 maha - 

Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
long ll_prac[]
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_verif_picture
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob
string ls_file
String ls_url,ls_null
string ls_docids[]


//get the blob data
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_verif_info(as_docid, lb_verif_picture)
ELSE
	SELECTBLOB verification_picture
	INTO :lb_verif_picture
	FROM verif_info
	WHERE doc_id = :as_docid
	USING SQLCA;
END IF
//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_verif_picture )

IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

//set file path ane delete existing file
ls_file = gs_temp_path + "Images\"
gnv_appeondll.of_parsepath(ls_file)

ls_file = ls_file + as_docid + ".xml"
is_file = ls_file //for parse file
FileDelete(  ls_file)

//open file
li_filenum =  FileOpen(  ls_file, StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_verif_picture, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
//		 st_wait.text = "Writing File"
		 IF ll_bytes_written = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_verif_picture = total_blob
	
	FileClose( li_filenum )
//   st_wait.text = "File Closed"
ELSE
	MessageBox( "of_ama_display: File Open Error", "Could not open the file!" )
	Return -	1
END IF

DO While Not FileExists(  ls_file )
	Yield( )
LOOP

//display the file
try
	ole_browser.object.navigate(ls_file)
	catch (RuntimeError e)
end try

return 1

end function

public function integer of_get_profile ();
integer li_find
string ls_doc
string ls_file


li_find = dw_data.find("verification_picture_flag = 6", 1, dw_data.rowcount())

if li_find > 0 then
	ls_doc = dw_data.getitemstring(li_find, "doc_id")
	ls_file = inv_action_items.of_get_ama_xml(ls_doc, "ama_temp.xml")
	ole_browser.object.navigate(ls_file)
	is_file = ls_file
end if

return 1


end function

public function integer of_parse_file (string as_file);//Start Code Change ----.2016 #V153 maha

long i
long ic
long pa
long pb
long pc
long pd
long ll_len //maha 120611
long res
long pend2
long r
long pstart
long pstart2
long pid
long pend
long ptest
boolean ib_skip
integer li_read
integer li_write
integer li_new_format
integer li_loops

string ls_read
string ls_name
string ls_value
string ls_write
string ls_table
string ls_write_path
string ls_parse_file
string ls_seg
string ls_seg_data

//Create the caqh directory if not exists
//is_file = as_file
//is_file = "C:\intellicred\AMA_profile.txt" 

ll_len = FileLength ( as_file )
li_loops = ll_len/32765
li_loops+= 1

li_read = FileOpen (as_file,   LineMode!)
//messagebox("fileopen", li_read)

ls_write_path = gs_temp_path + "AMA"

if DirectoryExists ( ls_write_path ) = false then
	res = CreateDirectory ( ls_write_path )
	if res = -1 then
		MessageBox("Parse file","Unable to create file directory:" + ls_write_path)
		return -1
	end if
end if

is_parsed_file = ls_write_path +  "\AMA_profile.txt"
li_write = FileOpen (is_parsed_file, LineMode!, Write!, LockWrite!, Replace!)


for i = 1 to li_loops

	pend2 = 1 //reset the end
	res = FileRead ( li_read, ls_read)
	ls_read  = ls_seg + ls_read //add the stub from the previous loop
//	ls_test = mid(ls_read,1,15)
//	messagebox("",ls_test)
	for r = 1 to 50000
		pstart = pos(ls_read, "<" ,pend2)
		pid = pos(ls_read, "ID=" ,pend)	
		pstart2 =  pos(ls_read, ">" ,pstart)
		ptest = pos(ls_read, "<" ,pstart + 1) //test to see if subsection exists
		pend = pos(ls_read, "</" ,pstart2)
		pend2 = pos(ls_read, ">" ,pend)
		
		if mid(ls_read,pstart,2) = "</" then //for sub end stubs
			pend2 = pstart2
		elseif pid > 0 and pid < pstart2 then  //for sub sections
			pend2 = pstart2	
		elseif ptest <> pend then //for sub section starts
			pend2 = pstart2	
		end if
		
		if pstart = 0 then exit
		
		If pstart >0 and pend2 = 0 Then //deal with the end of 32765 , Added by Appeon long.zhang 04.07.2015 (v15.1 CAQH Import Data Approval)
			ls_seg = mid(ls_read,pstart)
		Else
			ls_seg = upper(mid(ls_read, pstart, pstart2 - pstart)) + ": "
			ls_seg_data = mid(ls_read, pstart2 + 1, pend - pstart2 -1 ) + "~n"
			ls_seg+=ls_seg_data
			choose case mid(upper(ls_seg), 1, 10) //skip some exception lines
				case "<?XML VERS", 'xmlns="htt', "<DEMOGRAPH", "PREFIX XM", "<PATHWAYBO", "<ENDDATE X"
					Continue
				case "<DISCLAIME", "<ADDRESSUN", "</ABMS: <A", "<METADATAU", "</FULLPROF",  "<FULLPROFI", "<PREFIX XM"
					Continue
				case else
					res = FileWriteEx ( li_write, ls_seg)
					if res < 1 then 
						messagebox("","Write Failed")
						return -1
					end if
				end choose
		End If
	next
next

FileClose(li_read)
FileClose(li_write)

messagebox("Parsed File", is_parsed_file)


return 1

end function

public function integer of_security ();//Start Code Change ----10.24.2016 #V153 maha - added
integer li_s

if w_mdi.of_security_access(160) = 0 then  //enter response code
	cb_save.visible = false
	dw_data.enabled = false
end if

//if w_mdi.of_security_access(150) = 0 //process verifications

return 1
	

end function

on w_ama_verifications.create
int iCurrent
call super::create
this.cb_parse=create cb_parse
this.cb_logs=create cb_logs
this.st_2=create st_2
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_pracs=create dw_pracs
this.dw_data=create dw_data
this.dw_status=create dw_status
this.ole_browser=create ole_browser
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_parse
this.Control[iCurrent+2]=this.cb_logs
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_pracs
this.Control[iCurrent+7]=this.dw_data
this.Control[iCurrent+8]=this.dw_status
this.Control[iCurrent+9]=this.ole_browser
end on

on w_ama_verifications.destroy
call super::destroy
destroy(this.cb_parse)
destroy(this.cb_logs)
destroy(this.st_2)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_pracs)
destroy(this.dw_data)
destroy(this.dw_status)
destroy(this.ole_browser)
end on

event resize;call super::resize; //Start Code Change ----07.26.2016 #V15 maha 
long ll_win_h
long ll_win_w
long ll_ole_h
long ll_ole_w
long ll_div
long ll_split


ll_win_h = this.WorkSpaceHeight() - 150
ll_div = ll_win_h /5
ll_ole_h = ll_div * 4
 
dw_pracs.height = ll_div
ole_browser.y = dw_pracs.y + ll_div + 10
ole_browser.height = ll_ole_h
dw_data.height = dw_pracs.height

ll_ole_w = this.WorkSpaceWidth() - 20
ole_browser.width = ll_ole_w

ll_split =  ll_ole_w /3

dw_pracs.width = ll_split - 250
dw_data.x = dw_pracs.width +10
dw_data.width = ll_split *2 + 250







end event

event open;call super::open;//Start Code Change ----07.15.2016 #V153 maha - added window
gs_pass_ids lst_ids
integer rc

lst_ids = message.powerobjectparm
il_facility = lst_ids.facility_id
il_pracs = lst_ids.sl_prac_ids

dw_pracs.retrieve(il_pracs)
rc = dw_data.retrieve(1, il_pracs[1], il_facility)

inv_action_items = create pfc_n_cst_ai_action_items

if rc > 0 then
	of_get_profile()
end if

dw_data.of_SetDropDownCalendar( TRUE )

of_security()



end event

event close;call super::close;destroy inv_action_items
end event

type cb_parse from commandbutton within w_ama_verifications
integer x = 283
integer y = 12
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Parse File"
end type

event clicked;of_parse_file(is_file)
end event

type cb_logs from commandbutton within w_ama_verifications
boolean visible = false
integer y = 12
integer width = 114
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Incomplete Logs"
end type

event clicked; //Start Code Change ----10.28.2015 #V15 maha
 gs_pass_ids lst_data
 
lst_data.s_stringval = gs_user_id
lst_data.l_app_id =  il_batch
lst_data.ls_ref_value = "I" //incomplete

lst_data.prac_id = 0
lst_data.i_ids[1] = 0
lst_data.i_ids[2] = 0
lst_data.ls_from_window = "N"  //Y will show message

openwithparm(w_verif_scan_log_incompl,lst_data)
end event

type st_2 from statictext within w_ama_verifications
boolean visible = false
integer x = 4581
integer y = 272
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Response:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_ama_verifications
integer x = 3648
integer y = 12
integer width = 343
integer height = 84
integer taborder = 30
boolean bringtotop = true
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

type cb_save from commandbutton within w_ama_verifications
integer x = 1947
integer y = 12
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;
long ll_batch

dw_data.update()

//create audit items







end event

type dw_pracs from u_dw within w_ama_verifications
integer y = 124
integer width = 1065
integer height = 524
integer taborder = 10
string title = "Providers"
string dataobject = "d_prac_name_facility"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable(false)
this.of_settransobject( sqlca)

end event

event clicked;call super::clicked;long r
string s
r = this.getclickedrow()
if r < 1 then return



this.setrow(r)
this.selectrow( 0, false)
this.selectrow( r, true)
il_pracid = this.getitemnumber(r,"prac_id")
//messagebox("Prac",il_pracid)


of_get_profile()



end event

event buttonclicked;call super::buttonclicked;string s

//this does not work
if dwo.name = 'b_last' then 
	s = this.getitemstring(row,"last_name")
	//messagebox("",s)
	clipboard(s)
end if

if dwo.name = 'b_first' then 
	s = this.getitemstring(row,"first_name")
	clipboard(s)
end if
end event

event doubleclicked;call super::doubleclicked;any la_value
string ls_value
integer li_col

if row < 1 then return   //Start Code Change ----11.18.2015 #V15 maha - error trap
li_col = this.getclickedcolumn()

choose case li_col
	//case "last_name", "first_name"
	case 1,2
		ls_value = this.getitemstring(row,li_col)
	case else
		ls_value = string(this.getitemnumber(row,li_col))
end choose

//messagebox("",ls_value)
::clipboard(ls_value)

end event

type dw_data from u_dw within w_ama_verifications
integer x = 1079
integer y = 124
integer width = 2917
integer height = 520
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ver_ama_records"
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
end event

event pfc_preupdate;call super::pfc_preupdate;//messagebox("","preupdate")

inv_data_fun.of_field_audit( This )

return 1
end event

event doubleclicked;call super::doubleclicked;string ls_type
string ls_value
string ls_field
integer li_col

if row < 1 then return //(Appeon)Stephen 02.24.2017 - BugS022205 
//li_col = this.getclickedcolumn()
ls_field = this.getcolumnname( )
//messagebox("",ls_field)
ls_type = This.Describe( ls_field + ".ColType") 
//messagebox("",ls_type)

choose case upper(mid(ls_type,1,3))
	//case "last_name", "first_name"
	case "VAR","CHA"
		ls_value = this.getitemstring(row,ls_field)
	case "DAT"
		ls_value = string(this.getitemdatetime(row,ls_field))
	case else
		ls_value = string(this.getitemnumber(row,ls_field))
end choose

//messagebox("",ls_value)
::clipboard(ls_value)
end event

event clicked;call super::clicked;IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
	Long ll_verification_id
	gs_pass_ids ls_pass_ids
	integer li_type
	string ls_file
	string ls_docid
	//messagebox(string(row), "ff")
	li_type = dw_data.GetItemNumber( row,"verification_picture_flag")
	ls_docid = dw_data.GetItemstring( row,"doc_id")
	
	if  li_type <> 6 then 
		messagebox("","The attached document is not an AMA profile.")
	else	
		ls_pass_ids.s_doc_ids[1] = ls_docid
		ls_file = "display.xml"
		of_get_image(ls_docid)
		//inv_action_items.of_display_web_image(ls_docid, ls_file)
	end if
//	choose case li_type
//		case 4
//			ls_file = "display.bmp"
//		case 2
//			ls_file = "display.pdf"
//		case 3
//			ls_file = "display.htm"
//		Case 5 //Start Code Change ----04.29.2016 #V15 maha
//			ls_file = "display.png"
//		//case 1 = HTML
//		Case 6  //Start Code Change ----05.31.2016 #V152 maha
//			ls_file = "display.xml"
//	end choose
//	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
//	
//	ll_ver_method = This.GetItemnumber( row, "verification Method" )  //Start Code Change ----07.15.2016 #V153 maha
//	
//	ls_pass_ids.ls_doc_id = This.GetItemString( row, "doc_id" )
//	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	ls_pass_ids.ll_verification_id = ll_verification_id
//	
//	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
	

////Start Code Change ----07.15.2016 #V153 maha - for AMA xml 
//	if ll_ver_method = -570 and li_type = 6 then  //AMA & XML
//		ls_pass_ids.s_doc_ids[1] = ls_pass_ids.ls_doc_id
//		inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
////		ls_file = ls_pass_ids.ls_doc_id + ".xml"
////		inv_action_items.of_ama_display(ls_pass_ids.ls_doc_id, ls_file)
//	else
//		if li_type > 1 then
//			inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//		else
//			IF Not IsValid( w_capture ) THEN
//				OpenWithParm( w_capture,  ls_pass_ids )
//			ELSE
//				w_capture.of_setup( ls_pass_ids )
//			END IF
//		end if
//	end if
////End Code Change ----07.15.2016
	
	//------------------- APPEON END -------------------
END IF
end event

event itemchanged;call super::itemchanged;IF This.GetColumnName() = "response_code" THEN
	This.SetItem( row, "user_name", gs_user_id )
	This.SetItem( row, "source", "P" )
	This.SetItem( row, "date_recieved", Today() )
	This.SetItem( row, "exp_credential_flag", 0 )
	This.SetItem( row, "print_flag", 0 )
	//Start Code Change ----08.01.2008 #V85 maha - if status flag indicates historical or inactive set to not create expired verif
	if this.getitemstring(row, "reference_value") <> 'Expiring Appointment Letter' then//maha 100400 to keep recieved letters from being recredentialed
		if this.getitemnumber(row,"verif_info_data_status") = 0 or this.getitemnumber(row,"verif_info_data_status") = 2 then
			This.SetItem( row, "exp_credential_flag", 2 )
		else
			This.SetItem( row, "exp_credential_flag", 0 )
		end if
	end if
	//End Code Change---08.01.2008
END IF

IF This.GetColumnName() = "verification_method" THEN  //maha 061504 make the verification 'expired' if method changed to EXP CRED
	//Start Code Change ----05.29.2009 #V92 maha - added to trap for mistaken changes.
	if messagebox("Verification method","Are you sure you want to change the Verification Method?",question!,Yesno!,2) = 2 then
		This.SetItem( row, "exp_credential_flag", This.getItemnumber( row, "exp_credential_flag", primary!,true) )
		return 2
	else
		this.accepttext()
		if this.getitemnumber( row, "verification_method" ) = 10015 then
			if isnull(this.getitemnumber(row,"response_code")) then  //Start Code Change ----11.098.2011 #V12 maha - trap for change after completed.
				This.SetItem( row, "exp_credential_flag", 1 )
			end if
		end if
	end if
	//End Code Change---05.29.2009
end if
end event

type dw_status from u_dw within w_ama_verifications
boolean visible = false
integer x = 4891
integer y = 256
integer width = 635
integer height = 76
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_code_lookup_verif_log_status"
boolean vscrollbar = false
boolean border = false
end type

event itemchanged;call super::itemchanged;this.of_setupdateable(false)
this.of_settransobject(sqlca)
end event

type ole_browser from olecustomcontrol within w_ama_verifications
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer y = 652
integer width = 3995
integer height = 2132
integer taborder = 20
boolean bringtotop = true
boolean focusrectangle = false
string binarykey = "w_ama_verifications.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_ama_verifications.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000cc023eb001d28e7600000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000cc023eb001d28e76cc023eb001d28e76000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00005a55000037160000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00005a55000037160000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_ama_verifications.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
