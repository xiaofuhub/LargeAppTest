$PBExportHeader$w_wc_accept_data.srw
forward
global type w_wc_accept_data from w_response
end type
type dw_wc_audit from u_dw within w_wc_accept_data
end type
type cb_1 from commandbutton within w_wc_accept_data
end type
type rb_none from radiobutton within w_wc_accept_data
end type
type cb_clear from commandbutton within w_wc_accept_data
end type
type cb_date from commandbutton within w_wc_accept_data
end type
type rb_ind from radiobutton within w_wc_accept_data
end type
type rb_batch from radiobutton within w_wc_accept_data
end type
type st_note from statictext within w_wc_accept_data
end type
type sle_note from singlelineedit within w_wc_accept_data
end type
type st_response from statictext within w_wc_accept_data
end type
type dw_response from u_dw within w_wc_accept_data
end type
type dw_range from u_dw within w_wc_accept_data
end type
type dw_detail from u_dw within w_wc_accept_data
end type
type rb_all from radiobutton within w_wc_accept_data
end type
type rb_reject from radiobutton within w_wc_accept_data
end type
type cb_reject from commandbutton within w_wc_accept_data
end type
type cb_accept from commandbutton within w_wc_accept_data
end type
type cb_close from commandbutton within w_wc_accept_data
end type
type rb_tobe from radiobutton within w_wc_accept_data
end type
type rb_previous from radiobutton within w_wc_accept_data
end type
type gb_1 from groupbox within w_wc_accept_data
end type
type gb_2 from groupbox within w_wc_accept_data
end type
type dw_verif from u_dw within w_wc_accept_data
end type
type dw_wc_auditmm from u_dw within w_wc_accept_data
end type
end forward

global type w_wc_accept_data from w_response
integer x = 214
integer y = 221
integer width = 4654
integer height = 2268
string title = "WebCrawler Data Auditing"
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean clientedge = true
boolean palettewindow = true
boolean center = false
dw_wc_audit dw_wc_audit
cb_1 cb_1
rb_none rb_none
cb_clear cb_clear
cb_date cb_date
rb_ind rb_ind
rb_batch rb_batch
st_note st_note
sle_note sle_note
st_response st_response
dw_response dw_response
dw_range dw_range
dw_detail dw_detail
rb_all rb_all
rb_reject rb_reject
cb_reject cb_reject
cb_accept cb_accept
cb_close cb_close
rb_tobe rb_tobe
rb_previous rb_previous
gb_1 gb_1
gb_2 gb_2
dw_verif dw_verif
dw_wc_auditmm dw_wc_auditmm
end type
global w_wc_accept_data w_wc_accept_data

type variables

string is_filter
string is_update
long il_code = 0
pfc_n_cst_ai_action_items inv_action_items
pfc_cst_nv_data_entry_functions inv_data_entry
n_cst_dataflow inv_dataflow
end variables

forward prototypes
public function integer of_dw_filter ()
public function integer of_wc_update_screen (long al_row)
public function integer of_create_screen_dw (long al_row)
public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess)
public function integer of_complete_verifs ()
public function integer of_dw_retrieve ()
public function integer of_batch_visible (integer ai_true)
end prototypes

public function integer of_dw_filter ();//////////////////////////////////////////////////////////////////////
// $<Function> of_wc_update_screen
// $<arguments> N/A
// $<returns> integer
// $<description>data filter  (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////


dw_wc_audit.setfilter(is_filter)
dw_wc_audit.filter()
return 1
end function

public function integer of_wc_update_screen (long al_row);//////////////////////////////////////////////////////////////////////
// $<Function> of_wc_update_screen
// $<arguments> N/A
// $<returns> integer
// $<description>update screen  (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.06.2012 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_table_name, ls_field_name, ls_field_type
long  ll_rec_id, ll_prac_id, ll_field_id
string  ls_syntax, ls_error_syntax, ls_error_create
long   ll_table_id, ll_screen_id
string ls_extract_data, ls_sql
string ls_extract_data_org  //maha 
date  ldt_date

ls_table_name = dw_wc_audit.getitemstring(al_row, "sys_tables_table_name")
ls_field_name = dw_wc_audit.getitemstring(al_row, "sys_fields_field_name")
ls_field_type   = dw_wc_audit.getitemstring(al_row, "sys_fields_field_type")
ll_rec_id   =   dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_rec_id")
ll_prac_id = dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_prac_id")
ll_field_id = dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_field_id")
ll_screen_id =  dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_screen_id")
ll_table_id = dw_wc_audit.getitemnumber(al_row, "sys_tables_table_id")
ls_extract_data = dw_wc_audit.getitemstring(al_row, "wc_extracted_data_extract_value")
ls_extract_data_org = ls_extract_data  //Start Code Change ----01.05.2015 #V14.2 maha - added also changed the error message text

//field audit
choose case ls_field_type
	case 'N','I' //number
		if not isnumber(ls_extract_data) then 
			messagebox("Prompt", "The data type (Number) does not match that of the extracted string (" + ls_extract_data_org  + "), it cannot be saved!")
			return -1
		end if
	case 'D' //datetime
		ldt_date = f_convert_str_date(ls_extract_data)
		if isnull(ldt_date) or string(ldt_date, 'yyyy-mm-dd') = '1900-01-01' then
			ls_extract_data = left(trim(ls_extract_data), 10)
			ls_extract_data = string(datetime(date(ls_extract_data),time("00:00")), 'yyyy-mm-dd hh:mm')
					
			if isnull(ls_extract_data) or ls_extract_data = "1900-01-01 00:00" then
				messagebox("Prompt", "The data type (Date) does not match that of the extracted string (" + ls_extract_data_org  + "), it cannot be saved!")
				return -1
			end if
		else
			ls_extract_data = string(datetime(ldt_date,time("00:00")), 'yyyy-mm-dd hh:mm')
		end if
end choose

//update screen 
ls_sql = "update " + ls_table_name +" set " + ls_field_name +" = '" + ls_extract_data + "' where rec_id = " + string(ll_rec_id) + " and prac_id = " + string(ll_prac_id)
EXECUTE IMMEDIATE :ls_sql;
if sqlca.sqlcode <> 0 then 
	messagebox("Prompt", sqlca.sqlerrtext)
	return -1
end if

//Added for Work Flow trigger and run data flow if any 
if of_create_screen_dw(al_row) = -1 then return -1
return 1
end function

public function integer of_create_screen_dw (long al_row);//////////////////////////////////////////////////////////////////////
// $<Function> of_create_screen_dw
// $<arguments> N/A
// $<returns> integer
// $<description>create screen (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2012 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_prac_id, ll_seq
integer li_screen_id, li_facility
string   ls_sql_syntax
long ll_pos, ll_row
string ls_field_name

if not isvalid(inv_data_entry) then
	inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end if

inv_data_entry.ib_report = false
inv_data_entry.of_setup_cache()
inv_data_entry.of_refresh_cache()

ll_seq   =   dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_rec_id")
ll_prac_id = dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_prac_id")
li_screen_id =  dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_screen_id")
ls_field_name = dw_wc_audit.getitemstring(al_row, "sys_fields_field_name")
li_facility =  dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_facility_id")

ls_sql_syntax = inv_data_entry.of_create_dynamic_dw( ll_prac_id, 1, li_screen_id, dw_detail, dw_detail, false, li_facility, true )

ls_sql_syntax = dw_detail.getsqlselect()
ll_pos = pos(lower(ls_sql_syntax), 'order by' )
	
if pos(lower(ls_sql_syntax), 'where') > 0 then
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " and rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " and rec_id = "+string(ll_seq)+" "
	end if
else
	if ll_pos > 0 then
		ls_sql_syntax = left(ls_sql_syntax, ll_pos - 1) + " where rec_id = "+string(ll_seq)+" " + mid(ls_sql_syntax, ll_pos )
	else
		ls_sql_syntax = ls_sql_syntax + " where rec_id = "+string(ll_seq)+" "
	end if
end if

dw_detail.setsqlselect(ls_sql_syntax)
ll_row = dw_detail.retrieve()
if ll_row < 1 then 
	messagebox("Prompt", "Update failed, the matched record wasn’t found in the screen!")
	return -1
end if

dw_detail.setitemstatus(1,ls_field_name,primary!, datamodified!)
if dw_detail.event ue_update(li_facility, li_screen_id, ll_prac_id, ls_field_name) = -1 then return -1
if dw_detail.event ue_postupdate(al_row) = -1 then return -1
return 1
end function

public function integer of_error_message (string as_field, integer ai_row, string as_title, string as_mess);
//Start Code Change ---- 03.24.2006 #340 maha

integer res
string ls_plus

ls_plus = "~r~rData will not be saved for row " + string(ai_row) + "."

res = messagebox(as_title,as_mess + ls_plus,question!,ok!)
//if res = 1 then 
dw_detail.setitemstatus( ai_row, 0, primary!,notmodified!)
				
return 1

//End Code Change---03.24.2006
end function

public function integer of_complete_verifs ();//Start Code Change ----07.23.2013 #V14 maha - added for CVO
string ls_docids[]
string ls_note
long rc
long r
integer res

if il_code = 0 then
	messagebox("Response Code","Please select a Response code")
	return -1
end if

//get selected list
for r = 1 to dw_wc_audit.rowcount()
	if dw_wc_audit.getitemnumber(r, "opt_type") = 1 then
		ls_docids[upperbound(ls_docids) + 1] = dw_wc_audit.getitemstring(r, "wc_extracted_data_doc_id")
	end if
next

ls_note = sle_note.text

//get verifications
dw_verif.settransobject(sqlca)
rc = dw_verif.retrieve(ls_docids[])

//update
for r = 1 to dw_verif.rowcount()
	dw_verif.setitem(r, "response_code", il_code)
	dw_verif.setitem(r, "user_name", gs_user_id)
	dw_verif.setitem(r, "date_recieved", datetime(today(),now()) )
	dw_verif.setitem(r, "mod_date", datetime(today(),now()) )
	dw_verif.setitem(r, "mod_user", gs_user_id)
	if len(ls_note) > 0 then //Start Code Change ----08.19.2013 #V14 maha - added the if
		dw_verif.setitem(r, "notes", ls_note + "  " + dw_verif.getitemstring(r, "notes") )
	else //Start Code Change ----03.12.2015 #V15 maha - added to set if no existing note.
		dw_verif.setitem(r, "notes", ls_note )
	end if
	dw_verif.setitem(r, "print_flag", 0)
	dw_verif.setitem(r, "exp_credential_flag", 0)
next

res = dw_verif.update()

if res < 0 then
	messagebox("Batch Verifications", "Unable to update Verification data")
end if


return 1
end function

public function integer of_dw_retrieve ();//Start Code Change ----07.24.2013 #V14 maha - added to retrieve not filter data
string ls_sql
string ls_sql_org
string ls_where
string ls_street
string ls_phone
string sss
date ld_from
date ld_to
datetime ldt_from
datetime ldt_to
//integer rows
Long rows //Modified to Long, by Appeon long.zhang 04.28.2017 (For Mednax- Webcrawler Data Audit Error Case#70314)

ls_sql = dw_wc_audit.GetSQLSelect()
ls_sql_org = ls_sql

if rb_tobe.checked then
	ls_where =  " and wc_extracted_data.status = 0 "
elseif rb_previous.checked then
	ls_where =  " and  wc_extracted_data.status = 1 "
elseif rb_reject.checked then
	ls_where =  " and  wc_extracted_data.status = -1 "
elseif rb_all.checked then
	ls_where =  ""
end if

dw_range.accepttext()
ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if not isnull(ld_from)  then
	ldt_from = datetime(ld_from, time("00:00:00"))
	ls_where = ls_where + " and  wc_extracted_data.create_date >= Cast('" + String( ld_from, 'yyyy/mm/dd' ) + " 00:00:00" + "' AS DATETIME ) "
end if

if not isnull(ld_to)  then
	ldt_to = datetime(ld_from, time("00:00:00"))
	ls_where = ls_where + " and  wc_extracted_data.create_date <= Cast('" + String( ld_to, 'yyyy/mm/dd' ) + " 23:59:50" + "' AS DATETIME ) "
end if

ls_sql+= ls_where

//messagebox("SQL", ls_sql)
dw_wc_audit.SetSQLSelect ( ls_sql )
dw_wc_audit.SetTransObject( SQLCA )
rows = dw_wc_audit.Retrieve()

if rows < 0 then
		messagebox("of_dw_retrieve"," Failed:~r~r" + ls_sql)
end if
//debugbreak()

dw_wc_audit.SetSQLSelect ( ls_sql_org )

//Start Code Change ----08.13.2013 #V14 maha - reset the update properties
sss = dw_wc_audit.Modify("DataWindow.Table.updatetable = 'wc_extracted_data'")
sss = dw_wc_audit.Modify("wc_extracted_data_status.Update = Yes")
sss = dw_wc_audit.Modify("wc_extracted_data_accept_date.Update = Yes")
sss = dw_wc_audit.Modify("wc_extracted_data_accept_by.Update = Yes")
sss = dw_wc_audit.Modify("wc_extracted_data_pk_id.Key = Yes")
//End Code Change ----08.13.2013



//sss = dw_wc_audit.describe("DataWindow.Table.UpdateTable")
//messagebox("",sss)



return 1
end function

public function integer of_batch_visible (integer ai_true); //Start Code Change ----03.12.2015 #V15 maha


choose case ai_true
	case 2
		sle_note.visible = true
		dw_response.visible = true
		st_response.visible = true
		st_note.visible = true
	case 1
		sle_note.visible = false
		dw_response.visible = true
		st_response.visible = true
		st_note.visible = false
	case 0
		sle_note.visible = false
		dw_response.visible = false
		st_response.visible = false
		st_note.visible = false
end choose
return 1
end function

on w_wc_accept_data.create
int iCurrent
call super::create
this.dw_wc_audit=create dw_wc_audit
this.cb_1=create cb_1
this.rb_none=create rb_none
this.cb_clear=create cb_clear
this.cb_date=create cb_date
this.rb_ind=create rb_ind
this.rb_batch=create rb_batch
this.st_note=create st_note
this.sle_note=create sle_note
this.st_response=create st_response
this.dw_response=create dw_response
this.dw_range=create dw_range
this.dw_detail=create dw_detail
this.rb_all=create rb_all
this.rb_reject=create rb_reject
this.cb_reject=create cb_reject
this.cb_accept=create cb_accept
this.cb_close=create cb_close
this.rb_tobe=create rb_tobe
this.rb_previous=create rb_previous
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_verif=create dw_verif
this.dw_wc_auditmm=create dw_wc_auditmm
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_wc_audit
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.rb_none
this.Control[iCurrent+4]=this.cb_clear
this.Control[iCurrent+5]=this.cb_date
this.Control[iCurrent+6]=this.rb_ind
this.Control[iCurrent+7]=this.rb_batch
this.Control[iCurrent+8]=this.st_note
this.Control[iCurrent+9]=this.sle_note
this.Control[iCurrent+10]=this.st_response
this.Control[iCurrent+11]=this.dw_response
this.Control[iCurrent+12]=this.dw_range
this.Control[iCurrent+13]=this.dw_detail
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.rb_reject
this.Control[iCurrent+16]=this.cb_reject
this.Control[iCurrent+17]=this.cb_accept
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.rb_tobe
this.Control[iCurrent+20]=this.rb_previous
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
this.Control[iCurrent+23]=this.dw_verif
this.Control[iCurrent+24]=this.dw_wc_auditmm
end on

on w_wc_accept_data.destroy
call super::destroy
destroy(this.dw_wc_audit)
destroy(this.cb_1)
destroy(this.rb_none)
destroy(this.cb_clear)
destroy(this.cb_date)
destroy(this.rb_ind)
destroy(this.rb_batch)
destroy(this.st_note)
destroy(this.sle_note)
destroy(this.st_response)
destroy(this.dw_response)
destroy(this.dw_range)
destroy(this.dw_detail)
destroy(this.rb_all)
destroy(this.rb_reject)
destroy(this.cb_reject)
destroy(this.cb_accept)
destroy(this.cb_close)
destroy(this.rb_tobe)
destroy(this.rb_previous)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_verif)
destroy(this.dw_wc_auditmm)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<Event> open
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////
move(0,0)
// Set resize
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(dw_wc_audit, inv_resize.SCALERIGHTBOTTOM)

dw_wc_audit.setredraw(false)
 //Start Code Change ----07.24.2013 #V14 maha
// dw_range.setitem(1,"from_date", today())
//  dw_range.setitem(1,"to_date", today())
of_dw_retrieve( ) 
//dw_wc_audit.retrieve()
//rb_tobe.event clicked()
inv_action_items = create pfc_n_cst_ai_action_items
inv_data_entry = create pfc_cst_nv_data_entry_functions
 //End Code Change ----07.24.2013
 
is_filter = "wc_extracted_data_status =0"   //Start Code Change ----08.13.2013 #V14 maha
dw_wc_audit.setredraw(true)

 //Start Code Change ----03.12.2015 #V15 maha
of_batch_visible( 0)


end event

event close;call super::close;//Start Code Change ----07.24.2013 #V14 maha
if  isvalid(inv_action_items) then destroy inv_action_items
if  isvalid(inv_data_entry) then destroy inv_data_entry
end event

event resize;call super::resize;//Start Code Change ----02.18.2016 #V15 maha
dw_wc_audit.width = this.width - 100
dw_wc_audit.height = this.height - dw_wc_audit.y - 172
end event

type dw_wc_audit from u_dw within w_wc_accept_data
integer x = 5
integer y = 316
integer width = 4585
integer height = 1828
integer taborder = 80
string dataobject = "d_wc_accept_data"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<Event> buttonclicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_row, ll_cnt
string ls_txt
long ll_log  //maha 08.10.2017
string ls_type  //maha 08.10.2017

//debugbreak()
if dwo.name="b_select" then
	ls_txt = this.describe("b_select.text")
	ll_row = this.rowcount()
	if ll_row < 1 then return
	
	if ls_txt = "Select All" then
		for ll_cnt = 1 to ll_row
			this.setitem(ll_cnt,"opt_type", 1)
		next
		this.modify("b_select.text='Deselect All'")
	else
		for ll_cnt = 1 to ll_row
			this.setitem(ll_cnt,"opt_type", 0)
		next
		this.modify("b_select.text='Select All'")
	end if
end if

//Start Code Change ----07.24.2013 #V14 maha
if dwo.name="b_view" then
	debugbreak()
	string ls_docid
	Long ll_code
	gs_pass_ids ls_pass_ids
	integer li_type
	integer li_pict_flag
	string ls_file
	string ls_ref

	ls_docid = dw_wc_audit.getitemstring(row, "wc_extracted_data_doc_id")
	if isnull(ls_docid) then
		messagebox("View File", "The verification link to this record is invalid. Unable to display Image.")
		return 0
	end if
	debugbreak()
	//Start Code Change ----08.10.2017 #V154 maha - coded for log verification entries
	if pos(ls_docid, "B") > 0 then  //batch verification
		ll_log = long( mid(ls_docid, 3))
		select image_type into :ls_type from verif_batch_log_image where log_id = :ll_log;
		select log.entity_id, alu.entity_name into :ll_code, :ls_ref from verif_batch_log log, address_lookup alu where log.entity_id = alu.lookup_code;
		choose case lower(ls_type)
			case "pdf"
				li_type = 2
			case "htm"
				li_type = 3
			case "bmp"
				li_type = 4
			case "png"
				li_type = 5
		end choose
	else //prac verifications
		select reference_value, verification_picture_flag, address_lookup_code into :ls_ref, :li_type, :ll_code from verif_info where doc_id = :ls_docid;
	end if
	//End Code Change ----08.10.2017
	debugbreak()	
	
	
	if isnull(ls_ref) or ls_ref = "" then
		messagebox("View File", "The verification link to this record is invalid. Unable to display Image.")
		return 0
	end if
		
//	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
	choose case li_type
		case 2
			ls_file = "display.pdf"
		case 3
			ls_file = "display.htm"
		case 4
			ls_file = "display.bmp"		
		case 5  //Start Code Change ----08.10.2017 #V154 maha
			ls_file = "display.png"
		case 6
			ls_file = "display.xml"
		case 7
			ls_file = "display.jpg"
	end choose
	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
	
	ls_pass_ids.ls_doc_id = ls_docid
	ls_pass_ids.ls_ref_value = ls_ref
	ls_pass_ids.ls_from_window = "Prac_Folder"
	ls_pass_ids.ll_verification_id = ll_code
	
	
	IF li_type = 1 THEN		
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF
	
//Start Code Change ----08.21.2017 #V154 maha - changed to use display window	
//	if li_type > 1 then
//		//---------Begin Added by (Appeon)Stephen 03.16.2015 for Allegheny Webcrawler Audit V14.2--------
//		if not isvalid(inv_action_items) then 
//			inv_action_items = create pfc_n_cst_ai_action_items
//		end if
//		//---------End Added ------------------------------------------------------
//		inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//	else
//		IF Not IsValid( w_capture ) THEN
//			OpenWithParm( w_capture,  ls_pass_ids )
//		ELSE
//			w_capture.of_setup( ls_pass_ids )
//		END IF
//	
//	end if


	if li_type = 2 then
		if not isvalid(inv_action_items) then 
			inv_action_items = create pfc_n_cst_ai_action_items
		end if
	end if	
	
	choose case li_type
		case 1
			IF Not IsValid( w_capture ) THEN
				OpenWithParm( w_capture,  ls_pass_ids )
			ELSE
				w_capture.of_setup( ls_pass_ids )
			END IF	
		case 2 //pdf
			inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
		case else
			ls_pass_ids.s_stringval = "Verif"
			openwithparm(w_verif_image_view , ls_pass_ids)
	end choose
	//End Code Change ----08.21.2017
	
	
end if
//End Code Change ----07.24.2013
end event

event constructor;call super::constructor;this.of_settransobject( sqlca)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(2)
This.inv_Filter.of_SetColumnDisplayNameStyle( 2 )

This.inv_sort.of_SetColumnHeader(True)

This.inv_sort.of_SetVisibleOnly( False )
end event

type cb_1 from commandbutton within w_wc_accept_data
integer x = 3986
integer y = 48
integer width = 261
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;//string null_str
//SetNull(null_str)
//dw_wc_audit.SetSort(null_str)
//dw_wc_audit.Sort( )

dw_wc_audit.inv_sort.of_setstyle(dw_wc_audit.inv_sort.dragdrop  )

dw_wc_audit.Event pfc_SortDlg()
end event

type rb_none from radiobutton within w_wc_accept_data
integer x = 731
integer y = 212
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "None"
boolean checked = true
end type

event clicked; //Start Code Change ----03.12.2015 #V15 maha
of_batch_visible( 0)
end event

type cb_clear from commandbutton within w_wc_accept_data
integer x = 3735
integer y = 48
integer width = 187
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;datetime ldt_null

setnull(ldt_null)
dw_range.setitem(1,"from_date", ldt_null)
dw_range.setitem(1,"to_date", ldt_null)

of_dw_retrieve()
end event

type cb_date from commandbutton within w_wc_accept_data
integer x = 3538
integer y = 48
integer width = 187
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_dw_retrieve()
end event

type rb_ind from radiobutton within w_wc_accept_data
integer x = 379
integer y = 216
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Individual"
end type

event clicked; //Start Code Change ----03.12.2015 #V15 maha
of_batch_visible( 1)
end event

type rb_batch from radiobutton within w_wc_accept_data
integer x = 110
integer y = 220
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Batch"
end type

event clicked; //Start Code Change ----03.12.2015 #V15 maha
of_batch_visible( 2)
end event

type st_note from statictext within w_wc_accept_data
integer x = 2395
integer y = 212
integer width = 133
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Note:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_note from singlelineedit within w_wc_accept_data
integer x = 2542
integer y = 208
integer width = 1038
integer height = 76
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_response from statictext within w_wc_accept_data
integer x = 992
integer y = 220
integer width = 398
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Response Code:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_response from u_dw within w_wc_accept_data
integer x = 1385
integer y = 208
integer width = 992
integer height = 80
integer taborder = 60
string dataobject = "d_code_lookup_response_code_field"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.SetTransObject( SQLCA )
this.retrieve()
This.InsertRow( 1 )
end event

event itemchanged;call super::itemchanged;il_code = long(data) 
end event

type dw_range from u_dw within w_wc_accept_data
integer x = 2062
integer y = 48
integer width = 1504
integer height = 88
integer taborder = 40
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type dw_detail from u_dw within w_wc_accept_data
event type integer ue_update ( integer ai_parent_facility_id,  integer ai_screen_id,  long al_prac_id,  string as_field_name )
event type integer ue_postupdate ( long al_row )
boolean visible = false
integer x = 2651
integer y = 1020
integer width = 1527
integer height = 836
integer taborder = 0
boolean hscrollbar = true
end type

event type integer ue_update(integer ai_parent_facility_id, integer ai_screen_id, long al_prac_id, string as_field_name);//////////////////////////////////////////////////////////////////////
// $<Event> ue_update
// $<arguments>
// $<returns> long
// $<description>update verif_info  (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.12.2012 by Stephen
//////////////////////////////////////////////////////////////////////

DateTime ldt_exp_date
DateTime ldt_null_date
Long ll_rec_id
Long ll_address_code
long ll_appt_stat_recid  
long ll_templ_id[ ]  
long ll_verif_response  
long li_seq_no
long li_found
Long ll_rec_id_new 
Long ll_rec_id_changed[]
long ll_ver_method = -1 
Integer li_table_id
Integer li_facility_specific
Integer li_screen_id
Integer li_current_row
Integer i
Integer li_cnt
Integer li_rec_count
Integer li_data_cr
Integer li_verif_rc
Integer li_retval
integer li_year 
integer li_month
integer li_res  
integer li_complete[ ]   
integer li_auto_gen[ ] 
integer li_app_audit_facil 
integer li_appt_stat 
integer li_temp_cnt 
integer li_status = 1 
integer t  

string ls_use_as_ver
String ls_screen_name
String ls_ref_1
String ls_val
String ls_ref_2
String ls_ref_3
String ls_exp_field
String ls_reference
String ls_rec_status
string ls_app_type 
string ls_mess 
string ls_type1
string ls_type2
string ls_type3
DataWindowChild dwchild
n_ds lds_aa_template 
n_ds lds_select_section

SetNull( ldt_null_date )
This.AcceptText()

//initialize variables for dataflow: alfee 01.07.2010
inv_dataflow.of_init_data() 

li_rec_count = This.RowCount()
IF li_rec_count < 1 THEN
	RETURN -1
END IF

SetRedraw( False )

li_data_cr = This.GetRow()

lds_select_section = create n_ds
lds_select_section.dataobject = 'd_data_view_screens_list'
lds_select_section.settransobject(sqlca)
lds_select_section.retrieve(1)
lds_select_section.setfilter("screen_id = "+string(ai_screen_id)+"")
lds_select_section.filter()

ls_ref_1 = lds_select_section.GetItemString( 1, "ref_field_1")
ls_ref_2 = lds_select_section.GetItemString( 1, "ref_field_2")
ls_ref_3 = lds_select_section.GetItemString( 1, "ref_field_3")
ls_type1 = lds_select_section.GetItemString( 1, "ref_1_type")//maha102501
ls_type2 = lds_select_section.GetItemString( 1, "ref_2_type")//maha102501
ls_type3 = lds_select_section.GetItemString( 1, "ref_3_type")//maha102501

ls_exp_field = lds_select_section.GetItemString( 1, "exp_field")
li_screen_id = lds_select_section.GetItemNumber( 1, "screen_id")
ls_screen_name = lds_select_section.GetItemString( 1, "screen_name")
li_table_id = lds_select_section.GetItemNumber( lds_select_section.GetRow(), "table_id" )
DESTROY lds_select_section

FOR i = 1 TO li_rec_count
	//debugbreak()			
	SetNull( ll_address_code )
	ls_rec_status = "Modified"
	
	ll_rec_id = This.GetItemNumber( i, "rec_id" )
	
	IF This.Describe( "active_status.dddw.name" ) = 'd_code_lookup_active_inactive' THEN
		IF This.GetItemNumber( i, "active_status" ) < 1 THEN  //Start Code Change ----01.24.2011 #V11 maha - changd from = 0
			if ls_rec_status = "New" then
				CONTINUE
			else				//\/maha 031601  //Start Code Change ----01.24.2011 #V11 maha - modified update query to include prac_id
				update verif_info
				set active_status = 0
				where rec_id = :ll_rec_id and prac_id = :al_prac_id and active_status = 1;
				continue		 //\maha/\
			end if
		END IF
	END IF
	
	//\/maha 031601 get month and year end for check back date passed in verification add
	IF li_screen_id  = 7 or li_screen_id = 10 THEN  // training & hosp affil
		if This.Describe("year_thru.ColType") <> "!" then
			li_year = this.getitemnumber(i,"year_thru")
			if This.Describe("month_thru.ColType") <> "!" then
				li_month = this.getitemnumber(i,"month_thru")
			end if
			//maha added to using full end date field
		//--------Begin Modified by  Nova 07.15.2010------------------------
		elseif This.Describe("end_date.ColType") <> "!" then    
		//--------End Modified --------------------------------------------	
			li_year = year(date(this.getitemdatetime(i,"end_date")))
			li_month = month(date(this.getitemdatetime(i,"end_date")))
		end if
	end if
	//\maha
		
	li_facility_specific = Long(gnv_data.of_getitem( "sys_tables", "facility_specific", "table_id = "+String(li_table_id) ))
	
	IF li_screen_id = 19 THEN //specialty
		if This.Describe("board_code.ColType") = "!" then continue //Start Code Change----06.01.2010 #V10 maha - added trap for hidden board code
		
		IF IsNull( This.GetItemNumber( i, "board_code" ) ) THEN
			CONTINUE
		  //Start Code Change ---- 10.26.2007 #V7 maha	
		ELSE
			ll_address_code = This.GetItemNumber( i, "board_code" ) 
			IF ls_rec_status = "Modified" THEN
				SELECT count(*)  
				INTO :li_cnt  
						FROM verif_info  
						WHERE ( verif_info.rec_id = :ll_rec_id ) AND  
							( verif_info.active_status = 1 )   ;
				IF IsNull( li_cnt ) OR li_cnt = 0 THEN
					ls_rec_status = "New"
				END IF
			end if //modified
			//End Code Change---10.26.2007
		END IF
	END IF
	
	//Start Code Change ----08.31.2011 #V11 maha 
	IF li_table_id = 72 THEN  //other verifications
		if This.Describe("verif_method.ColType") = "!" then 
			//leave as default -1
		else
			ll_ver_method = this.GetItemNumber( i, "verif_method" )
			if isnull( ll_ver_method) then ll_ver_method = -1
		end if
	end if
	//End Code Change ----08.31.2011
	
	IF NOT IsNull( ls_ref_1 ) AND ls_ref_1 <> "" THEN
		This.ScrollToRow( i )
		This.SetRow( i )

		//move expiration date to verif info table if there is one
		IF Len(ls_exp_field) > 0 THEN
			IF ls_exp_field = "certification_expires" THEN	
				ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())			
			ELSEIF ls_exp_field = "cert_expiration_year" THEN
				li_month = this.GetItemNumber( i, "cert_expiration_month" )
				if isnull(li_month) then
					ldt_exp_date = DateTime(Date( String( This.GetItemNumber( i, ls_exp_field ) ) + "-12-30"),Now())			
				else
					ldt_exp_date = DateTime(Date(String( This.GetItemNumber( i, ls_exp_field ) ) + "-" + String(li_month) + "-28"),Now())
				end if
			ELSE
				if This.Describe(ls_exp_field + ".ColType") <> "!" then
					ldt_exp_date = This.GetItemDateTime( i, ls_exp_field )
				else
					of_error_message( ls_exp_field, i,"Unable to update data","The " + upper(ls_exp_field) + " field is required by your system settings.~r~rYou will not be able to save data on this screen~runtil the field is made visible in the Screen Painter for the view you are using.")
					return -1
				end if
			END IF
		ELSE
			ldt_exp_date = ldt_null_date
		END IF
	
		//get reference 1 data 		
		if This.Describe(ls_ref_1 + ".ColType") = "!"  or ls_ref_1 = "" then //trap for invisible field maha 012104 
			messagebox("Problem getting reference 1 value for verification","Required Field " + ls_ref_1 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
			return 1
		end if
		li_retval = This.SetColumn( ls_ref_1 )
		IF li_retval = 1 THEN
			IF IsNull( GetText() ) OR GetText() = "" THEN
				SetRedraw( True )
				of_error_message(ls_ref_1,i,"Required", "The data field " + ls_ref_1 + " is required.")
				Return -1
			END IF
			li_retval = This.GetChild(ls_ref_1, dwchild)
			IF li_retval = -1 THEN
				ls_reference =  This.GetText()				
			ELSE
				This.SetColumn( ls_ref_1 )
				li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
				IF li_found < 1 THEN // Add by Evan 05.04.2010 --- trap for row number
					ls_reference = This.GetText()
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "code" THEN
					ls_reference = dwchild.GetItemString( li_found, "code" )
					IF ai_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
					if This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "entity_name_original" THEN
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )  //Start Code Change ----03.04.2009 #V92 maha -  changed this to aloways use the entity name originalf the of containg the code as well, 
					else
						ls_reference = dwchild.GetItemString( li_found, "entity_name_original" )
					end if
					if ls_type1 = "C" then //maha 102501 took out specific exceptions and tested field type
						ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
					elseif ls_type1 = "N" then //maha 102501
						ll_address_code = This.GetItemNumber( i, ls_ref_1 )
					end if
				ELSEIF This.Describe( ls_ref_1 + ".dddw.displaycolumn") = "description" THEN //maha 110801
					ls_reference = dwchild.GetItemString( li_found, "description" )
					//Start Code Change ---- 10.10.2007 #V7 maha added same exception for verif ying agency as above
					IF ai_screen_id = 4 THEN					
						if This.Describe("verifying_agency.ColType") = "!" then //trap for invisible field maha 040403 
							of_error_message("VERIFYING_AGENCY",i,"Screen Setup Error"," The verifying_agency field is a required field, and must be visible to enter Licence data.  Please set up in the screen painter.")
							return -1
						else
							ll_address_code = This.GetItemNumber( i, "verifying_agency" )
						end if
					ELSEIF li_screen_id = 19 THEN  //Start Code Change ---- 10.26.2007 #V7 maha
						//do nothing, got the address code further up
					ELSE
						if ls_type1 = "C" then //maha 050802 
							ll_address_code = long(This.GetItemstring( i, ls_ref_1 ))//maha 072501
						elseif ls_type1 = "N" then //maha 050802
							ll_address_code = This.GetItemNumber( i, ls_ref_1 )
						end if
					END IF
					//End Code Change---10.10.2007
				ELSE
					ls_reference = This.GetText()			
				END IF
			END IF
		ELSE
			ls_reference = ""
		END IF

	   If NOT Isnull(ls_ref_2) THEN
			//get reference 2 data
			if This.Describe(ls_ref_2 + ".ColType") = "!" or ls_ref_2 = "" then //trap for invisible field maha 012104 
				messagebox("Problem getting reference 2 value for verification","Required Field " + ls_ref_2 + " is invisible.  The verification will not be created/updated.  Contact Customer support for assistance.")
				return 1
			end if
			li_retval = This.SetColumn( ls_ref_2 )
			IF li_retval = 1 THEN
				IF IsNull( GetText() ) OR GetText() = "" THEN
					SetRedraw( True )
					of_error_message(ls_ref_2,i,"Required", "The data field " + ls_ref_2 + " is required.")
					Return -1
				END IF		
				li_retval = This.GetChild(ls_ref_2, dwchild)
				IF li_retval = -1 THEN
					ls_reference = ls_reference + " - " + This.GetText()				
				ELSE
					This.SetColumn( ls_ref_2 )
					li_found = dwchild.Find( "lookup_code = " + This.GetText(), 1, 100000 )
					if li_found > 0 then //trap added maha 021704
						IF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "code" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "code" )
						ELSEIF dw_detail.Describe( ls_ref_2 + ".dddw.displaycolumn") = "description" THEN
							ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "description" )					
						ELSEIF This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name" or This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
							if This.Describe( ls_ref_2 + ".dddw.displaycolumn") = "entity_name_original" THEN
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name_original" )
							else
								ls_reference = ls_reference + " - " + dwchild.GetItemString( li_found, "entity_name" )
							end if
						ELSE
							ls_reference = ls_reference + " - " + This.GetText()
						END IF
					else
						ls_reference = ls_reference + " - " + ""
					end if
				END IF
			ELSE
				ls_reference = ls_reference + " - " + ""
			END IF
			
			ls_reference = mid(ls_reference,1,100) //maha 022704 4.1.1
		END IF

		//Start Code Change ----08.01.2008 #V85 maha - get active status to pass to function
		if this.Describe("active_status.ColType") <> "!" then
			li_status = this.getitemnumber(i,"active_status") //Start Code Change ----04.19.2010 V10 maha - changed from li_data_cr
		end if
		//End Code Change---08.01.2008
		//Start Code Change ---- 10.26.2006 #1 maha
		IF ls_rec_status = "Modified" THEN
			if not isvalid(inv_action_items) then 
				inv_action_items = create pfc_n_cst_ai_action_items
			end if
			inv_action_items.of_update_reference(  ls_reference, ll_rec_id, ll_address_code, ldt_exp_date, li_screen_id, li_status, ll_ver_method)
			inv_data_entry.of_app_audit_update_ref( al_prac_id , ll_rec_id , mid(ls_screen_name,1,5) + "-" + ls_reference )

			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 2006-10-11 By: Rodger Wu (Inova)
			//$<reason> 
			if as_field_name = ls_exp_field then
				ll_rec_id_changed[ Upperbound( ll_rec_id_changed ) + 1 ] = ll_rec_id
			END IF
			//---------------------------- APPEON END ----------------------------
		end if
	END IF	
	//---------------------------- APPEON END ----------------------------
END FOR

if inv_data_entry.of_field_audit( This ) = -1 then return -1

//keep qualified df ids - dataflow: alfee 12.24.2009
inv_dataflow.of_set_data_flow(this, li_table_id)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> Automatically poping up Verification Update window once
//$<reason> value in exp_field changed.
String ls_sql_where, ls_rec_id_str, ls_sql_original
n_ds lds_verify
gs_verif_update lstr_verif

li_cnt = UpperBound( w_mdi.ii_security_action_id )
FOR i = 1 TO li_cnt
	IF w_mdi.ii_security_action_id[ i ] = 160 THEN
		IF w_mdi.ii_security_action_value[ i ] = 0 THEN
			Return 1  //No rights	
		else
			exit
		END IF
	END IF		
NEXT

li_cnt = UpperBound( ll_rec_id_changed )

if rb_ind.checked  then  //Start Code Change ----07.23.2013 #V14 maha - using individual completion
	IF li_cnt > 0 THEN
		FOR i = 1 TO li_cnt
			ls_rec_id_str += string( ll_rec_id_changed[i] ) + ", "
		NEXt
		lds_verify = Create n_ds
		lds_verify.DataObject = "d_verification_facility_de_update_maha"
		lds_verify.SetTransObject( SQLCA )
		lstr_verif.sql_syntax = ""//ls_sql_original
		lstr_verif.al_prac_id = al_prac_id
		lstr_verif.al_screen_id = li_screen_id
		lstr_verif.al_rec_id = ll_rec_id_changed
		 //Start Code Change ----07.23.2013 #V14 maha - pass additional values
		if il_code > 0 then
			lstr_verif.al_resp_code = il_code
		end if
		lstr_verif.ai_select = 1
		 //Start Code Change ----07.23.2013 #V14 maha 
		
		OpenwithParm( w_verification_de_update, lstr_verif )
	END IF
end if
//---------------------------- APPEON END ----------------------------

RETURN 1

end event

event type integer ue_postupdate(long al_row);//////////////////////////////////////////////////////////////////////
// $<Event> ue_postupdate
// $<arguments>
// $<returns> integer
// $<description>Added for Work Flow trigger and run data flow if any (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2012 by Stephen
//////////////////////////////////////////////////////////////////////

integer li_parent_facility_id
long  ll_table_id, ll_screen
long  ll_prac_id

//Added for Work Flow trigger
string ls_module
long ll_screen_id[] 

If of_Get_app_setting("set_9" , "I") = 1 Then
	ls_module = '02'
Else
	ls_module = '01'
End if

ll_prac_id = dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_prac_id")
ll_screen =  dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_screen_id")
ll_table_id = dw_wc_audit.getitemnumber(al_row, "sys_tables_table_id")
li_parent_facility_id =  dw_wc_audit.getitemnumber(al_row, "wc_extracted_data_facility_id")

If gb_workflow Then
	n_cst_workflow_triggers lnv_workflow
	lnv_workflow = create n_cst_workflow_triggers

	ll_screen_id[1] = ll_screen
	lnv_workflow.of_data_value_comparision( ll_screen_id, ll_prac_id, li_parent_facility_id, ls_module, 'I')

	Destroy lnv_workflow
	
End If
inv_dataflow.of_init_data() 
inv_dataflow.of_set_data_flow(this, ll_table_id)

//run data flow if any - dataflow
inv_dataflow.of_run_data_flow()

String	ls_table_name
n_cst_notification_alert_upd	lnv_na

ls_table_name = This.Object.DataWindow.Table.UpdateTable
lnv_na.of_update_alert_records(ls_table_name, This)

Return 1

end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments>
// $<returns> long
// $<description>(V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2012 by Stephen
//////////////////////////////////////////////////////////////////////

This.of_SetRowManager( TRUE )
This.of_SetReqColumn(TRUE)
this.of_SetDropDownCalendar( TRUE )
this.of_setupdateable(false) 
end event

type rb_all from radiobutton within w_wc_accept_data
integer x = 1851
integer y = 64
integer width = 187
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

 //Start Code Change ----07.24.2013 #V14 maha
of_dw_retrieve( ) 
is_filter = "1=1"
//of_dw_filter()
 //End Code Change ----07.24.2013
end event

type rb_reject from radiobutton within w_wc_accept_data
integer x = 1243
integer y = 64
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Rejected"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

 //Start Code Change ----07.24.2013 #V14 maha
of_dw_retrieve( ) 
is_filter = "wc_extracted_data_status =-1"
//of_dw_filter()
 //End Code Change ----07.24.2013
end event

type cb_reject from commandbutton within w_wc_accept_data
integer x = 4160
integer y = 200
integer width = 402
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reject"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_cnt, ll_row
long ll_sel
datetime ldt_today
integer li_status

ll_row = dw_wc_audit.rowcount()
if ll_row < 1 then return

ldt_today = datetime(today(), now())
for ll_cnt = 1 to ll_row
	ll_sel = dw_wc_audit.getitemnumber(ll_cnt, "opt_type")
	li_status = dw_wc_audit.getitemnumber(ll_cnt, "wc_extracted_data_status")
	
	if ll_sel <> 1 or li_status <>0 then continue
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_status", -1)
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_accept_date", ldt_today)
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_accept_by", gs_user_id)
next

gnv_appeondb.of_startqueue( )
dw_wc_audit.update()
dw_wc_audit.retrieve()
gnv_appeondb.of_commitqueue( )	

of_dw_filter()

end event

type cb_accept from commandbutton within w_wc_accept_data
integer x = 3744
integer y = 200
integer width = 402
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Accept"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////
long ll_cnt, ll_row
long ll_sel
datetime ldt_today
integer   li_status
integer li_res

ll_row = dw_wc_audit.rowcount()
if ll_row < 1 then return

if not isvalid(inv_action_items) then 
	inv_action_items = create pfc_n_cst_ai_action_items
end if
if not isvalid(inv_data_entry) then 
	inv_data_entry = create pfc_cst_nv_data_entry_functions
end if

if rb_batch.checked and il_code = 0 then
	messagebox("Response Code","Please select a Response code")
	return -1
end if

ldt_today = datetime(today(), now())
for ll_cnt = 1 to ll_row
	ll_sel = dw_wc_audit.getitemnumber(ll_cnt, "opt_type")
	li_status = dw_wc_audit.getitemnumber(ll_cnt, "wc_extracted_data_status")
	
	if ll_sel <> 1 or li_status <>0 then continue
	
	if of_wc_update_screen(ll_cnt) = -1 then
		gnv_appeondb.of_startqueue( )
		li_res = dw_wc_audit.update()
		//dw_wc_audit.retrieve()  //Start Code Change ----08.13.2013 #V14 maha - removed as not necessary
		gnv_appeondb.of_commitqueue( )	
		//of_dw_filter()  //Start Code Change ----08.13.2013 #V14 maha - removed as not necessary

//		if  isvalid(inv_action_items) then destroy inv_action_items  
//		if  isvalid(inv_data_entry) then destroy inv_data_entry
		return
	end if
	
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_status", 1)
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_accept_date", ldt_today)
	dw_wc_audit.setitem(ll_cnt, "wc_extracted_data_accept_by", gs_user_id)	
next

if rb_batch.checked then
	of_complete_verifs( )
end if
	

//messagebox("", "")
//gnv_appeondb.of_startqueue( )
//li_res = parent.event pfc_save( )
li_res = dw_wc_audit.update()
//dw_wc_audit.retrieve()  //Start Code Change ----08.13.2013 #V14 maha - removed as not necessary
//gnv_appeondb.of_commitqueue( )	

of_dw_filter() 

if  isvalid(inv_action_items) then destroy inv_action_items
if  isvalid(inv_data_entry) then destroy inv_data_entry
end event

type cb_close from commandbutton within w_wc_accept_data
integer x = 4297
integer y = 48
integer width = 261
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close (parent)
end event

type rb_tobe from radiobutton within w_wc_accept_data
integer x = 73
integer y = 64
integer width = 448
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To be Accepted"
boolean checked = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

 //Start Code Change ----07.24.2013 #V14 maha
of_dw_retrieve( ) 
is_filter = "wc_extracted_data_status =0"
//of_dw_filter()
 //End Code Change ----07.24.2013
end event

type rb_previous from radiobutton within w_wc_accept_data
integer x = 626
integer y = 64
integer width = 544
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Previously Accepted"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<Event> clicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////



 //Start Code Change ----07.24.2013 #V14 maha
of_dw_retrieve( ) 
is_filter = "wc_extracted_data_status =1"
//of_dw_filter()
 //End Code Change ----07.24.2013
end event

type gb_1 from groupbox within w_wc_accept_data
integer x = 41
integer y = 4
integer width = 3899
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Record Status"
end type

type gb_2 from groupbox within w_wc_accept_data
integer x = 41
integer y = 164
integer width = 3570
integer height = 140
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Verification completion"
end type

type dw_verif from u_dw within w_wc_accept_data
boolean visible = false
integer x = 160
integer y = 1588
integer width = 3694
integer height = 484
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_verifs_for_docids"
end type

type dw_wc_auditmm from u_dw within w_wc_accept_data
boolean visible = false
integer x = 443
integer y = 1020
integer width = 686
integer height = 852
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_wc_accept_data"
boolean hscrollbar = true
end type

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<Event> buttonclicked
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

long ll_row, ll_cnt
string ls_txt

//debugbreak()
if dwo.name="b_select" then
	ls_txt = this.describe("b_select.text")
	ll_row = this.rowcount()
	if ll_row < 1 then return
	
	if ls_txt = "Select All" then
		for ll_cnt = 1 to ll_row
			this.setitem(ll_cnt,"opt_type", 1)
		next
		this.modify("b_select.text='Deselect All'")
	else
		for ll_cnt = 1 to ll_row
			this.setitem(ll_cnt,"opt_type", 0)
		next
		this.modify("b_select.text='Select All'")
	end if
end if

//Start Code Change ----07.24.2013 #V14 maha
if dwo.name="b_view" then
	debugbreak()
	string ls_docid
	Long ll_code
	gs_pass_ids ls_pass_ids
	integer li_type
	integer li_pict_flag
	string ls_file
	string ls_ref

	ls_docid = dw_wc_audit.getitemstring(row, "wc_extracted_data_doc_id")
	if isnull(ls_docid) then
		messagebox("View File", "The verification link to this record is invalid. Unable to display Image.")
		return 0
	end if
		
	select reference_value, verification_picture_flag, address_lookup_code into :ls_ref, :li_type, :ll_code from verif_info where doc_id = :ls_docid;
	
	if isnull(ls_ref) or ls_ref = "" then
		messagebox("View File", "The verification link to this record is invalid. Unable to display Image.")
		return 0
	end if
		
//	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
	choose case li_type
		case 4
			ls_file = "display.bmp"
		case 2
			ls_file = "display.pdf"
		case 3
			ls_file = "display.htm"
	end choose
	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
	
	ls_pass_ids.ls_doc_id = ls_docid
	ls_pass_ids.ls_ref_value = ls_ref
	ls_pass_ids.ls_from_window = "Prac_Folder"
	ls_pass_ids.ll_verification_id = ll_code
	
	
	IF li_type = 1 THEN		
		ls_pass_ids.ls_image_available = True
	ELSE
		ls_pass_ids.ls_image_available = False
	END IF
	
	if li_type > 1 then
		inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
	else
		IF Not IsValid( w_capture ) THEN
			OpenWithParm( w_capture,  ls_pass_ids )
		ELSE
			w_capture.of_setup( ls_pass_ids )
		END IF
	end if
	
	
end if
//End Code Change ----07.24.2013
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<Event> constructor
// $<arguments> N/A
// $<returns> long
// $<description>WebCrawler Data Audit   (V12.2 WebCrawler extract data)
//////////////////////////////////////////////////////////////////////
// $<add> 07.04.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)  //Start Code Change ----08.13.2013 #V14 maha - removed
end event

