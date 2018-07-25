$PBExportHeader$uo_oppe_fppe_evals.sru
forward
global type uo_oppe_fppe_evals from userobject
end type
type cb_email from commandbutton within uo_oppe_fppe_evals
end type
type cb_letter from commandbutton within uo_oppe_fppe_evals
end type
type cb_add_flag from commandbutton within uo_oppe_fppe_evals
end type
type p_1 from picture within uo_oppe_fppe_evals
end type
type cb_view from commandbutton within uo_oppe_fppe_evals
end type
type cb_save from commandbutton within uo_oppe_fppe_evals
end type
type cb_close from commandbutton within uo_oppe_fppe_evals
end type
type cb_delete from commandbutton within uo_oppe_fppe_evals
end type
type cb_add from commandbutton within uo_oppe_fppe_evals
end type
type rb_oppe from radiobutton within uo_oppe_fppe_evals
end type
type rb_fppe from radiobutton within uo_oppe_fppe_evals
end type
type rb_all_stat from radiobutton within uo_oppe_fppe_evals
end type
type rb_cur from radiobutton within uo_oppe_fppe_evals
end type
type rb_his from radiobutton within uo_oppe_fppe_evals
end type
type rb_all_type from radiobutton within uo_oppe_fppe_evals
end type
type tab_1 from tab within uo_oppe_fppe_evals
end type
type tabpage_1 from userobject within tab_1
end type
type dw_detail from u_dw within tabpage_1
end type
type dw_detailxx from datawindow within tabpage_1
end type
type dw_browse from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_detail dw_detail
dw_detailxx dw_detailxx
dw_browse dw_browse
end type
type tabpage_2 from userobject within tab_1
end type
type dw_docs from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_docs dw_docs
end type
type tabpage_actions from userobject within tab_1
end type
type dw_act_browse from datawindow within tabpage_actions
end type
type dw_actions from u_dw within tabpage_actions
end type
type tabpage_actions from userobject within tab_1
dw_act_browse dw_act_browse
dw_actions dw_actions
end type
type tab_1 from tab within uo_oppe_fppe_evals
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_actions tabpage_actions
end type
type cb_update from commandbutton within uo_oppe_fppe_evals
end type
type gb_1 from groupbox within uo_oppe_fppe_evals
end type
type gb_2 from groupbox within uo_oppe_fppe_evals
end type
end forward

global type uo_oppe_fppe_evals from userobject
integer width = 3653
integer height = 1824
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_email cb_email
cb_letter cb_letter
cb_add_flag cb_add_flag
p_1 p_1
cb_view cb_view
cb_save cb_save
cb_close cb_close
cb_delete cb_delete
cb_add cb_add
rb_oppe rb_oppe
rb_fppe rb_fppe
rb_all_stat rb_all_stat
rb_cur rb_cur
rb_his rb_his
rb_all_type rb_all_type
tab_1 tab_1
cb_update cb_update
gb_1 gb_1
gb_2 gb_2
end type
global uo_oppe_fppe_evals uo_oppe_fppe_evals

type variables
long il_prac
long il_hdr_id
integer il_parent
integer ii_security[]  //1 = screen readonly; 2 = upload docs; 3 = view docs
string is_stat_filter
string is_type_filter
string is_document_path
datawindow idw_browse
datawindow idw_detail
datawindow idw_docs
u_dw idw_actions

pfc_cst_nv_image_functions  inv_image_functions-
n_cst_process_actions inv_pro_actions

n_cst_dm_utils inv_dm_utils //alfee 07.14.2009
end variables

forward prototypes
public function integer of_filter ()
public function integer of_setup (long al_prac, long al_facility)
public function integer of_view_document (string as_file, string as_ext, long al_record)
public function integer of_set_security ()
public function integer of_set_rb ()
public function integer of_add_process_step (long al_header, long al_step)
public function integer of_add_next_action (long al_temp, long al_hdr, integer al_step, long al_prac, long al_facility)
public function integer of_check_existing (long al_step)
public function integer of_action_preupdate ()
public function integer of_add_document (string as_from)
public function integer of_template_change ()
public function integer of_save ()
public function integer of_evals_preupdate ()
public function integer of_post_resize (long al_height, long al_width)
public subroutine of_zoom ()
end prototypes

public function integer of_filter ();string ls_filter

if LenA(is_stat_filter  ) > 0 then
	ls_filter = is_stat_filter
	if LenA(is_type_filter) > 0 then
		ls_filter = ls_filter + " and " + is_type_filter
	end if
else
	if LenA(is_type_filter) > 0 then ls_filter = is_type_filter
end if

idw_browse.setfilter(ls_filter)
idw_browse.filter()
idw_detail.setfilter(ls_filter)
idw_detail.filter()

return 1
end function

public function integer of_setup (long al_prac, long al_facility);Int li_selected

idw_browse = tab_1.tabpage_1.dw_browse
idw_detail = tab_1.tabpage_1.dw_detail
idw_docs = tab_1.tabpage_2.dw_docs
idw_actions = tab_1.tabpage_actions.dw_actions

il_prac = al_prac
il_parent = al_facility

idw_actions.reset() //Start Code Change ----07.05.2011 #V11 maha  
idw_browse.retrieve(il_prac, il_parent)
//----Begin Modified by alfee 09.16.2011 (BugA090602) --------
idw_detail.retrieve(il_prac, il_parent)
//idw_browse.sharedata(idw_detail)
//----End Modified ---------------------------------------------------

is_document_path = gs_temp_path + "temp\oppe\"
gnv_appeondll.of_parsepath(is_document_path) //alfee 07.14.2009
tab_1.tabpage_1.dw_detail.of_SetDropDownCalendar(TRUE)
idw_actions.of_SetDropDownCalendar(TRUE)

//Call selectionchanged to refresh data, Added by Appeon long.zhang 10.15.2015 (Bug id 4776 - Refresh Issue with Uploading of Documentation for OPPE/FPPE)
li_selected = tab_1.SelectedTab
If li_selected = 2 Or li_selected = 3 Then
	tab_1.Event SelectionChanged(1, li_selected)
End If

return 1
end function

public function integer of_view_document (string as_file, string as_ext, long al_record);//View the current document - alfee 07.14.2009

String ls_file_temp, ls_file, ls_Null
string ls_ext  //maha 07.13.2011
Blob lblb_data
str_office_ocx lstr_parms

IF IsValid(w_office_display) THEN Close(w_office_display)
IF IsValid(w_image_display) THEN Close(w_image_display)

//Download document to blob
lblb_data = of_download_file("OPPE","", al_record)
IF isnull(lblb_data) THEN
	messagebox("File Download","There is no document data associated with this record.")
	RETURN -1
END IF
//Start Code Change ----07.13.2011 #V11 maha 
ls_ext = as_ext
ls_file = as_file
if isnull(ls_file) then ls_file = ""

if as_file = "*GETFILE*" then
	select file_name, file_type into :ls_file, :ls_ext from pd_oppe_docs where dcmt_id = :al_record;
end if

ls_ext = of_strip_char(".",ls_ext,"") //check for period
//Start Code Change ----07.13.2011
  
//Save blob to document
ls_file_temp = is_document_path + "view_document." + ls_ext
IF inv_dm_utils.of_saveblob( ls_file_temp, lblb_data) = -1 THEN 
	messagebox("File Download","Failed to save blob to the document of " + ls_file_temp + '!')
	RETURN -1
END IF	

DO 
	Yield( )
LOOP UNTIL FileExists(ls_file_temp)
	
//Open document
CHOOSE CASE Upper(ls_ext)
	CASE 'TIF', 'BMP','JPG' //,'PDF' -commented by alfee 10.28.2014 for BugA102801
		//IF IsNull(ls_file) THEN as_file = ''  maha moved above
		OpenWithParm(w_image_display, ls_file_temp + '|' + ls_file)
	CASE 'DOC', 'XLS'
		lstr_parms.call_from = 'OPPE'
		lstr_parms.file_ext = ls_ext
		lstr_parms.file_name = ls_file_temp
		lstr_parms.file_name_ori = ls_file
		lstr_parms.read_only = TRUE
		OpenWithParm(w_office_display, lstr_parms)
	CASE ELSE
		SetNull(ls_Null)
		ShellExecuteA ( Handle( This ), "open", ls_file_temp , ls_Null, ls_Null, 4)
END CHOOSE

RETURN 1
end function

public function integer of_set_security ();//sets security in the object
//---------Begin Modified by (Appeon)Alfee 06.29.2013 for V141 ISG-CLX--------
//ii_security[1] = w_mdi.of_security_access(6971) //screen 2    
//ii_security[2] = w_mdi.of_security_access(6981) //upload 1
//ii_security[3] = w_mdi.of_security_access(6991) //documents
//ii_security[4] = w_mdi.of_security_access(7192) //action items//Start Code Change ----07.12.2011 #V11 maha  //corrected from 7191 09.30.2011
ii_security[1] = w_mdi.of_security_access(7621) //screen 2   
ii_security[2] = w_mdi.of_security_access(7631) //upload 1
ii_security[3] = w_mdi.of_security_access(7641) //documents
ii_security[4] = w_mdi.of_security_access(7651) //action items
//---------End Modfiied ----------------------------------------------------------------
ii_security[5] = w_mdi.of_security_access(7160) //red flag  //Start Code Change ----07.12.2011 #V11 maha 

if not isvalid(idw_detail) then of_setup( il_prac, il_parent)

if ii_security[1] = 1 then // readonly
	idw_detail.enabled = false
	idw_docs.object.file_name.protect = 1
	idw_docs.object.doc_type.protect = 1
	cb_add.visible= false
	cb_delete.visible = false
	cb_save.visible = false
	cb_update.visible = false
end if

if ii_security[2] = 0 then
	cb_update.visible = false
end if

if ii_security[3] = 0 then
	tab_1.tabpage_2.dw_docs.visible = false
	idw_docs.object.b_view.enabled = false
end if

//Start Code Change ----07.12.2011 #V11 maha 
if ii_security[4] = 0 then
	tab_1.tabpage_actions.visible = false
elseif ii_security[4] = 1 then
	tab_1.tabpage_actions.dw_actions.enabled = false
	cb_email.enabled =  false
	cb_letter.enabled = false
end if

if ii_security[5] = 0 then
	cb_add_flag.enabled = false
end if
//Start Code Change ----07.12.2011 #V11 maha 

return 1
end function

public function integer of_set_rb ();//Start Code Change ----06.22.2011 #V11 maha - function added

choose case tab_1.selectedtab
	case 1
		rb_all_stat.enabled = true
		rb_all_type.enabled = true
		rb_cur.enabled = true
		rb_fppe.enabled = true
		rb_his.enabled = true
		rb_oppe.enabled = true
	case else
		rb_all_stat.enabled = false
		rb_all_type.enabled = false
		rb_cur.enabled = false
		rb_fppe.enabled = false
		rb_his.enabled = false
		rb_oppe.enabled = false
end choose

return 1
		
end function

public function integer of_add_process_step (long al_header, long al_step);//Start Code Change ----06.27.2011 #V11 maha 
//al_header = the OFE header id
//al_step = the current process step















return 1
end function

public function integer of_add_next_action (long al_temp, long al_hdr, integer al_step, long al_prac, long al_facility);////Start Code Change ----06.27.2011 #V11 maha - added for action creation
//al_temp, al_hdr, al_step, al_prac, al_facility,  adw_actions
//of_add_next_action(al_temp,al_hdr,0,al_prac, al_facility)  zero for the step means create first
datawindow ldw_actions

ldw_actions = tab_1.tabpage_actions.dw_actions
inv_pro_actions.of_add_next_process_action( al_temp, al_hdr,  al_step,  al_prac, al_facility, ldw_actions )

return 1

//datawindow ldw_actions
//datetime ldt_today
//integer nr
//integer li_compl
//integer li_pos
//integer li_add = 1
//integer li_type
//integer li_days
//integer li_find
//long ll_step
//long ll_rec
//long ll_docid
//string ls_res
//string ls_ref
//
//ldt_today = datetime(today(),now())
//ldw_actions = tab_1.tabpage_actions.dw_actions
//
////tab_1.selecttab(3)
//
//ls_res = gnv_data.of_getitem( "process_steps", "next_step", string(al_temp) + "*" + string(al_step))
//select max(rec_id) into :ll_rec from pd_process_actions;
//if isnull(ll_rec ) then ll_rec = 0
////get the initial step.  if an auto-complete then loop until one is not.
//
//if ls_res = "0" then
//	return 0
//else
//	li_pos = pos(ls_res,"*",1)
//	ll_step = long(mid(ls_res,1,li_pos - 1))
//	li_compl = long(mid(ls_res,li_pos + 1))
//	
//	li_find = ldw_actions.find( "process_step =" + string(ll_step)  , 1, 10000)
//	if li_find > 0 then return 0
//
//	do while li_add = 1
//		nr = ldw_actions.insertrow(0)
//	//debugbreak()	
//		li_days = integer(gnv_data.of_getitem( "process_steps", "due_days", "item_id = " + string(ll_step)))
//		li_type = integer(gnv_data.of_getitem( "process_steps", "process_type", "item_id = " + string(ll_step)))
//		ll_docid = long(gnv_data.of_getitem( "process_steps", "document_id", "item_id = " + string(ll_step))) 
//		if li_type = 1 then //note
//			ls_ref = gnv_data.of_getitem( "process_steps", "item_name", "item_id = " + string(ll_step))
//		elseif li_type = 2 then //letter
//			select doc_name into :ls_ref from sys_storage_docs where dct_id = :ll_docid;
//			if isnull(ls_ref) or ls_ref = "" then ls_ref = "Letter"
//		elseif li_type = 3 then //email
//			select email_name into :ls_ref from wf_email where email_id = :ll_docid;
//			if isnull(ls_ref) or ls_ref = "" then ls_ref = "Email"
//		end if
//	
//		ll_rec++
//		ldw_actions.setitem(nr ,"rec_id" ,ll_rec )
//		ldw_actions.setitem(nr , "function_id" ,al_hdr )
//		ldw_actions.setitem(nr , "prac_id" ,al_prac )
//		ldw_actions.setitem(nr , "facility_id" ,al_facility )
//		ldw_actions.setitem(nr , "function_type" , 1 ) //for ofe
//		ldw_actions.setitem(nr , "document_id" , ll_docid)
//		ldw_actions.setitem(nr , "active_status" , 1 )
//		ldw_actions.setitem(nr , "process_type" , li_type)
//		ldw_actions.setitem(nr , "due_date" , datetime(RelativeDate ( today(), li_days ),time("00:00:00")))
//		ldw_actions.setitem(nr , "reference_value" ,ls_ref )
//		ldw_actions.setitem(nr , "process_step" ,ll_step )
//		ldw_actions.setitem(nr , "create_date" ,ldt_today )
//		ldw_actions.setitem(nr , "create_user" , gs_user_id)
//		ldw_actions.setitem(nr , "mod_date" , ldt_today)
//		ldw_actions.setitem(nr , "mod_user" , gs_user_id)
//		if li_compl = 1 then
//			ldw_actions.setitem(nr , "response_code" ,-420 ) //auto-complete
//			ldw_actions.setitem(nr , "user_name" ,gs_user_id )
//			ldw_actions.setitem(nr , "print_flag" , 0)
//			ldw_actions.setitem(nr , "priority_user" , gs_user_id)
//			ldw_actions.setitem(nr , "complete_date" , ldt_today)
//			ls_res = gnv_data.of_getitem( "process_steps", "next_step", string(al_temp) + "*" + string(ll_step))
//			li_pos = pos(ls_res,"*",1)
//			ll_step = long(mid(ls_res,1,li_pos - 1))
//			li_compl = long(mid(ls_res,li_pos + 1))
//		else
//			li_add = 0
//			ldw_actions.setitem(nr , "priority_user" , "PUBLIC")
//			if li_type = 1 then //notation
//				ldw_actions.setitem(nr , "print_flag" , 0)
//			else
//				ldw_actions.setitem(nr , "print_flag" , 1)
//			end if
//		end if
//		
//	loop
//	nr = ldw_actions.update()
//end if
//
//return 1
//
end function

public function integer of_check_existing (long al_step);return 1	
end function

public function integer of_action_preupdate ();//Start Code Change ----07.01.2011 #V11 maha -

datetime ldt_date
Long ll_hdr_id, ll_cnt, i
long ll_template
long ll_org
long ll_facil
long ll_step
integer cnt
string ls_mess = ""

idw_actions.accepttext()
IF idw_actions.ModifiedCount( ) < 1 THEN RETURN 0 //continue

ll_cnt = idw_actions.RowCount()
FOR i = 1 to ll_cnt
	IF idw_actions.getitemstatus( i, 0, Primary!) = NewModified! or idw_actions.getitemstatus( i, 0, Primary!) = DataModified! 	THEN
		if idw_actions.getitemstatus( i, "response_code", Primary!) = DataModified! then
			if not isnull( idw_actions.getitemnumber( i, "response_code")) then //and not isnull( idw_actions.getitemnumber( i, "response_code"),primary!,true) then
				ll_hdr_id = idw_actions.getitemnumber(i,"function_id")
				ll_template = idw_detail.getitemnumber(idw_detail.getrow(),"process_template")
				ll_step = idw_actions.getitemnumber(i,"process_step")
				ll_facil = idw_actions.getitemnumber(i,"facility_id")
				//------------------- APPEON BEGIN -------------------
				//$<modify> Stephen 04.26.2012
				//$<reason> Alpha Test Disappearing Oppe Fppe Evaluations
				/*
				idw_detail.SetItem(i, 'pd_oppe_hdr_id', ll_hdr_id)
				idw_detail.SetItem(i, 'prac_id', il_prac)
				*/
				idw_detail.SetItem(idw_detail.getrow(), 'prac_id', il_prac)
				//------------------- APPEON END ---------------------
				
				if not isnull(ll_template) then of_add_next_action(ll_template,ll_hdr_id,ll_step, il_prac,ll_facil)
			end if
		end if
	END IF

NEXT

return 1
end function

public function integer of_add_document (string as_from);string ls_fullname, ls_name
string ls_ext
integer value
integer li_pos ,p
integer li_ret
integer nr
long li_rec

Value = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Word Documents(*.docx),*.docx," &
	+ "Excel Files (*.xls),*.xls" 	)   

if Value = 0 then return 0 //alfee 07.14.2009

//Start Code Change ----07.12.2011 #V11 maha 
p = 1
Do until p = 0
	p = pos(ls_fullname,"." , p + 1)
	if p > 0 then li_pos = p
loop
	
//ls_ext = Upper(RightA(Trim(ls_fullname),3)) 
ls_ext = Upper(mid(ls_fullname,li_pos + 1)) 
//End Code Change ----07.12.2011
//ls_ext = Upper(RightA(Trim(ls_fullname),4)) 

select max(dcmt_id) into :li_rec from pd_oppe_docs;
if isnull(li_rec) then li_rec = 0
li_rec++

nr = tab_1.tabpage_2.dw_docs.insertrow(0)
tab_1.tabpage_2.dw_docs.setitem(nr,"dcmt_id",li_rec)
tab_1.tabpage_2.dw_docs.setitem(nr,"file_name",ls_name )
tab_1.tabpage_2.dw_docs.setitem(nr,"file_type",ls_ext)
tab_1.tabpage_2.dw_docs.setitem(nr,"oppe_hdr_id",il_hdr_id)
tab_1.tabpage_2.dw_docs.setitem(nr,"prac_id",il_prac)
tab_1.tabpage_2.dw_docs.setitem(nr,"facility_id",il_parent)
tab_1.tabpage_2.dw_docs.setitem(nr,"add_date",datetime(today(),now()))
tab_1.tabpage_2.dw_docs.setitem(nr,"add_user",gs_user_id )
tab_1.tabpage_2.dw_docs.update()

//of_upload_doc_data("OPPE", ls_fullname,"",li_rec) //app function
IF of_upload_doc_data("OPPE", ls_fullname,"",li_rec) = -1 THEN //alfee 07.14.2009
	Messagebox( "Upload Document", "Failed to upload the document!")
	RETURN -1
ELSE
	Messagebox( "Upload Document", "The document has been successfuly uploaded!")
	tab_1.tabpage_2.dw_docs.setitem(nr,"flen",10 ) //Start Code Change ----08.13.2009 #V92 maha - added to show the checkmark as green
END IF

//Start Code Change ----.2011 #V11 maha 
if as_from = "D" then //documents
	tab_1.tabpage_2.dw_docs.setrow(nr)
	tab_1.tabpage_2.dw_docs.setfocus( )
	return 1
else //from actions
	return li_rec
end if


//RETURN 1
end function

public function integer of_template_change ();//Start Code Change ----09.7.2011 #V11 maha 
integer res
integer cnt
integer row
long ll_header
long ll_org
long ll_new
string ls_res

row = idw_detail.getrow()
debugbreak()
if isnull( idw_detail.getitemnumber(row,"process_template",primary!,true)) then return 1

ll_org =  idw_detail.getitemnumber(row,"process_template",primary!,True)
ll_new =  idw_detail.getitemnumber(row,"process_template", primary!,False)
ll_header =  idw_detail.getitemnumber(row,"pd_oppe_hdr_id")
	
if isnull( ll_header ) then //Start Code Change ----09.07.2011 #V11 maha 
	return 0
else
	select count(rec_id) into :cnt from pd_process_actions where function_id = :ll_header;
	if cnt > 0 then 
		open(w_template_change_message)
			ls_res = message.stringparm
		choose case ls_res
			case "D" //delete all
				delete from pd_process_actions where function_id = :ll_header;
				commit using sqlca;
			case "K" //delete incompletes
				delete from pd_process_actions where function_id = :ll_header and response_code is null;
				commit using sqlca;
			case "O" //reset to original
				 idw_detail.setitem(row,"process_template", ll_org)
				 idw_detail.accepttext()
				 idw_detail.setitemstatus(row,"process_template", primary!,notmodified!)
			
		end choose
	end if
end if

tab_1.tabpage_actions.dw_act_browse.retrieve(ll_header)           //add by Stephen 09.08.2011 --Bug id 2608
tab_1.tabpage_actions.dw_act_browse.sharedata( idw_actions )  //add by Stephen 09.08.2011 --Bug id 2608

return 1
end function

public function integer of_save ();//Moved and modified from cb_save.clicked() - alfee 09.16.2011

Integer li_rtn
n_cst_notification_alert_upd	lnv_na

//Update evaluations
li_rtn = of_evals_preupdate() 
if li_rtn = -1 then return -1

if li_rtn = 1 then
	idw_detail.update(True, False)
	lnv_na.of_update_alert_records( "pd_oppe_hrd", idw_detail)
	idw_detail.ResetUpdate()
end if

//update docs
if idw_docs.modifiedcount() > 0 then 
	idw_docs.update()
end if

//Update actions
if of_action_preupdate() > 0 then 
	idw_actions.update() 
end if

return 1
end function

public function integer of_evals_preupdate ();//Start Code Change ----06.30.2011 #V11 maha - moved from detail updatestart
datetime ldt_date
Long ll_hdr_id, ll_cnt, i
long ll_template
long ll_org
long ll_facil
integer cnt
string ls_mess = ""

idw_detail.accepttext()
//--------Begin Modified by alfee 09.16.2011 --------------------
//<$Reason>Continue updating other DWs in the cb_save.clicked() - BugS090902
//IF idw_detail.ModifiedCount( ) < 1 THEN RETURN -1 //continue
IF idw_detail.ModifiedCount( ) < 1 THEN RETURN 0 
//--------End Modified ------------------------------------------------

//Start Code Change ----06.30.2011 #V11 maha - added validation
//------Begin Modified by alfee 09.16.2011 ------------
//<$Reason>add looping since the current row may be changed
for i = 1 to idw_detail.RowCount() // - alfee 09.16.2011
	if idw_detail.getitemstatus( i, 0, Primary!) = NotModified! then continue
	//i = idw_detail.getrow()
//------End Modified ---------------------------------------	
	ll_facil = idw_detail.getitemnumber(i, "facility_id")
	if isnull(ll_facil) then ls_mess = "Facility~r"
	
	ldt_date = idw_detail.getitemdatetime(i, "from_date")
	if isnull(ldt_date) then ls_mess+= "From Date~r"
	
	ldt_date = idw_detail.getitemdatetime(i, "to_date")
	if isnull(ldt_date) then ls_mess+= "To Date~r"
	
	if isnull(idw_detail.getitemstring(i, "oppe_fppe")) then ls_mess =+"Eval. Type~r"
	
	if len(ls_mess) > 0 then
		ls_mess = "The following data fields are required:~r" + ls_mess
		messagebox("Required Data",ls_mess)
		return -1
	end if
next //alfee 09.26.2011
//End Code Change ----06.30.2011 

//Set key fields
Select IsNull(Max(pd_oppe_hdr_id), 0)  Into :ll_hdr_id From pd_oppe_hrd;
IF SQLCA.SQLCode = -1 THEN 
	MessageBox("SQL error", "Failed to update due to: " + SQLCA.SQLErrText)
	RETURN -1
END IF

//Start Code Change ----06.30.2011 #V11 maha - added a save to the add function so looping is not required
//Restored the looping since the current row may be changed - alfee 09.16.2011
ll_cnt = idw_detail.RowCount()
FOR i = 1 to ll_cnt
	IF idw_detail.getitemstatus( i, 0, Primary!) = NewModified!	THEN
		ll_hdr_id ++ //Bugl081601 - added by alfee 08.25.2011
		idw_detail.SetItem(i, 'pd_oppe_hdr_id', ll_hdr_id)
		idw_detail.SetItem(i, 'prac_id', il_prac)
		//ll_hdr_id ++ //Bugl081601- commented by alfee 08.25.2011
		ll_template = idw_detail.getitemnumber(i,"process_template")
		if not isnull(ll_template) then of_add_next_action(ll_template,ll_hdr_id,0, il_prac,ll_facil)
	elseif idw_detail.getitemstatus( i, 0, Primary!) = DataModified!	THEN
		if idw_detail.getitemstatus( i, "process_template", Primary!) = DataModified! then
			if of_template_change( ) = -1 then return - 1
			ll_hdr_id = idw_detail.getitemnumber(i,"pd_oppe_hdr_id")
			ll_template = idw_detail.getitemnumber(i,"process_template")
			of_add_next_action(ll_template,ll_hdr_id,0, il_prac,ll_facil)
		end if
	END IF
NEXT

RETURN 1
end function

public function integer of_post_resize (long al_height, long al_width);//of_resize_from_appt(tab_view.tabpage_ofe.uo_ofe.width, tab_view.tabpage_ofe.uo_ofe.height )
long hig
long thig

tab_1.height = al_height - tab_1.y - 25
tab_1.width = al_width - 40
hig = tab_1.height - 96

tab_1.tabpage_1.height = hig
tab_1.tabpage_1.width = tab_1.width 
tab_1.tabpage_1.dw_browse.width = tab_1.tabpage_1.width - 60
tab_1.tabpage_1.dw_detail.width = tab_1.tabpage_1.width -60

tab_1.tabpage_1.dw_detail.height = 904 //this should remain fixed
tab_1.tabpage_1.dw_browse.height = hig - tab_1.tabpage_1.dw_detail.height - 35
tab_1.tabpage_1.dw_detail.y = tab_1.tabpage_1.dw_browse.y + tab_1.tabpage_1.dw_browse.height + 10

tab_1.tabpage_2.width = tab_1.width 
tab_1.tabpage_2.dw_docs.width = tab_1.tabpage_1.width - 60

tab_1.tabpage_actions.width = tab_1.width 
tab_1.tabpage_actions.dw_act_browse.width = tab_1.tabpage_1.width - 60
tab_1.tabpage_actions.dw_actions.height = 404  //fixed
tab_1.tabpage_actions.dw_act_browse.height = hig - tab_1.tabpage_actions.dw_actions.height - 35
tab_1.tabpage_actions.dw_actions.y = tab_1.tabpage_actions.dw_act_browse.y + tab_1.tabpage_actions.dw_act_browse.height + 10





return 1
end function

public subroutine of_zoom ();//Start Code Change ----07.13.2017 #V154 maha - added for font increase
tab_1.tabpage_1.dw_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_1.dw_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_1.tabpage_2.dw_docs.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_1.tabpage_actions.dw_act_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))
tab_1.tabpage_actions.dw_actions.Modify("DataWindow.Zoom=" + string(gi_zoom))
end subroutine

on uo_oppe_fppe_evals.create
this.cb_email=create cb_email
this.cb_letter=create cb_letter
this.cb_add_flag=create cb_add_flag
this.p_1=create p_1
this.cb_view=create cb_view
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.rb_oppe=create rb_oppe
this.rb_fppe=create rb_fppe
this.rb_all_stat=create rb_all_stat
this.rb_cur=create rb_cur
this.rb_his=create rb_his
this.rb_all_type=create rb_all_type
this.tab_1=create tab_1
this.cb_update=create cb_update
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_email,&
this.cb_letter,&
this.cb_add_flag,&
this.p_1,&
this.cb_view,&
this.cb_save,&
this.cb_close,&
this.cb_delete,&
this.cb_add,&
this.rb_oppe,&
this.rb_fppe,&
this.rb_all_stat,&
this.rb_cur,&
this.rb_his,&
this.rb_all_type,&
this.tab_1,&
this.cb_update,&
this.gb_1,&
this.gb_2}
end on

on uo_oppe_fppe_evals.destroy
destroy(this.cb_email)
destroy(this.cb_letter)
destroy(this.cb_add_flag)
destroy(this.p_1)
destroy(this.cb_view)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.rb_oppe)
destroy(this.rb_fppe)
destroy(this.rb_all_stat)
destroy(this.rb_cur)
destroy(this.rb_his)
destroy(this.rb_all_type)
destroy(this.tab_1)
destroy(this.cb_update)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;inv_pro_actions = create n_cst_process_actions

end event

event destructor;destroy inv_pro_actions
end event

type cb_email from commandbutton within uo_oppe_fppe_evals
integer x = 2519
integer y = 164
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Send &Email"
end type

event clicked;integer ll_temp_id
integer cnt
long ll_dept

if idw_actions.getrow() < 1 then Return // Added by Evan on 03.24.2012
ll_temp_id = idw_actions.getitemnumber(idw_actions.getrow(),"document_id")

if ll_temp_id > 0 then
	debugbreak()
	inv_pro_actions.of_email_template("OPPE" + string(ll_temp_id) + "-EMAIL")
else //manual email
	inv_pro_actions.of_email()
end if

end event

type cb_letter from commandbutton within uo_oppe_fppe_evals
integer x = 2153
integer y = 164
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print &Letter"
end type

event clicked;integer ll_temp_id
integer cnt
long ll_recid[]
gs_pass_ids lst_ids

if idw_actions.getrow() < 1 then Return // Added by Evan on 03.24.2012
ll_temp_id = idw_actions.getitemnumber(idw_actions.getrow(),"document_id")

if ll_temp_id > 0 then
	ll_recid[1] =  idw_actions.getitemnumber(idw_actions.getrow(),"rec_id")
	lst_ids.l_ids = ll_recid[]
	lst_ids.committee_id = 1
	lst_ids.dw = idw_actions
	openwithparm(w_ai_print_letters,lst_ids)
else
	messagebox("No Letter template","There is no letter template connected to this action.")
	return
end if
end event

type cb_add_flag from commandbutton within uo_oppe_fppe_evals
integer x = 2743
integer y = 48
integer width = 475
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Red Flag Data"
end type

event clicked;//red flag data:added by long.zhang 07.11.2011
str_rfd_data ls_str_rfd
ls_str_rfd.s_type = "OFE"
ls_str_rfd.u_datawindow = tab_1.tabpage_1.dw_detail
OpenWithParm(w_red_flag_add,ls_str_rfd)	
end event

type p_1 from picture within uo_oppe_fppe_evals
boolean visible = false
integer x = 3515
integer y = 136
integer width = 82
integer height = 64
boolean originalsize = true
string picturename = "arrowhead.png"
boolean focusrectangle = false
end type

type cb_view from commandbutton within uo_oppe_fppe_evals
boolean visible = false
integer x = 1797
integer y = 168
integer width = 343
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "View Doc"
end type

event clicked;//alfee 07.14.2009

Long ll_row, ll_dcmt_id
String ls_file_name, ls_file_type

ll_row = tab_1.tabpage_2.dw_docs.getrow() 
IF ll_row > 0 THEN
	ll_dcmt_id = tab_1.tabpage_2.dw_docs.GetItemNumber(ll_row, "dcmt_id")
	ls_file_name = tab_1.tabpage_2.dw_docs.GetItemString(ll_row, "file_name")
	ls_file_type = tab_1.tabpage_2.dw_docs.GetItemString(ll_row, "file_type")
	IF LeftA(ls_file_type, 1) = '.' THEN ls_file_type = MidA(ls_file_type, 2)
	ls_file_type = Trim(Lower(ls_file_type))
	
	of_view_document(ls_file_name, ls_file_type, ll_dcmt_id)
END IF
end event

type cb_save from commandbutton within uo_oppe_fppe_evals
integer x = 1710
integer y = 48
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//-------Modified by alfee 09.16.2011 -------------
long ll_crow //add Michael 04.27.2012 Alpha Test 3046 Oppe/FPPE Process Steps are not being generated
if of_save() = -1 then return -1

ll_crow = idw_detail.getrow( )//Alpha Test 3046 Oppe/FPPE Process Steps are not being generated

gnv_appeondb.of_startqueue( )
idw_browse.retrieve(il_prac, il_parent) 
idw_detail.retrieve(il_prac, il_parent) //add by stephen 04.26.2012 Alpha Test Disappearing Oppe Fppe Evaluations
gnv_appeondb.of_commitqueue( )	

//------------------- APPEON BEGIN -------------------
//$<add> Michael 04.27.2012
//$<reason>Alpha Test 3046 Oppe/FPPE Process Steps are not being generated 
idw_browse.setrow(ll_crow)
idw_browse.scrolltorow(ll_crow)
idw_browse.selectrow(0,false)
idw_browse.selectrow(ll_crow,true)
//------------------- APPEON END ---------------------

return 1

//n_cst_notification_alert_upd	lnv_na
//
////if of_preupdate() = 1 then return
//if of_preupdate() = -1 then return -1	//long.zhang 09.02.2011 #BugL082902
//
//of_action_preupdate()
//idw_detail.update(True, False)
//idw_docs.update()
//idw_actions.update()  //Start Code Change ----06.22.2011 #V11 maha 
//
//lnv_na.of_update_alert_records( "pd_oppe_hrd", idw_detail)
//idw_detail.ResetUpdate()
//
//idw_browse.retrieve(il_prac, il_parent) //Start Code Change ----08.13.2009 #V92 maha
//
//return 1 //alfee 09.02.2011 - BugL082901 
//--------End Modified ------------------------------
end event

type cb_close from commandbutton within uo_oppe_fppe_evals
boolean visible = false
integer x = 3223
integer y = 48
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(w_oppe_fppe_hdr_prac)
end event

type cb_delete from commandbutton within uo_oppe_fppe_evals
integer x = 2400
integer y = 48
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;integer li_ans

choose case tab_1.selectedtab
	case 1
		if idw_browse.getrow() > 0 then
			li_ans = messagebox("Delete","Are you sure you wish to deleted the selected record including all Documents and Actions that may be connected to it?",question!,yesno!,2)
			if li_ans = 2 then return
			//idw_detail.reset() //Start Code Change ----08.13.2009 #V92 maha
			//Start Code Change ----07.01.2011 #V11 maha 
			//delete from pd_oppe_documents where oppe_hdr_id =  :il_hdr_id;
			delete from pd_oppe_docs where oppe_hdr_id =  :il_hdr_id; //alfee 09.02.2011 - bugl090201						
			delete from pd_process_actions where function_id = :il_hdr_id;
			commit using sqlca;
			//End Code Change ----07.01.2011
			idw_browse.deleterow(0)
			idw_browse.update() 			
		end if
	case 2
		if idw_docs.getrow() > 0 then
			li_ans = messagebox("Delete","Are you sure you wist to deleted the selected document record including the document that is connected to it?",question!,yesno!,2)
			if li_ans = 2 then return
			idw_docs.deleterow(0) //alfee 07.14.2009
			idw_docs.update()			
		end if
	case 3 //Start Code Change ----06.22.2011 #V11 maha 
		if idw_actions.getrow() > 0 then
			li_ans = messagebox("Delete","Are you sure you wist to deleted the selected Action record?",question!,yesno!,2)
			if li_ans = 2 then return
			idw_actions.deleterow(0)
			idw_actions.update()			
		end if
end choose

//idw_browse.update()
//idw_docs.update()


//delete message
//delete record
//delete documents
end event

type cb_add from commandbutton within uo_oppe_fppe_evals
integer x = 2053
integer y = 48
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer nr
integer cnt
long ll_dept

//cb_save.triggerevent(clicked!)  //Start Code Change ----08.30.2011 #V11 maha 
//if cb_save.event clicked() = -1 then Return //long.zhang 09.02.2011 #BugL082902 
if of_save() = -1 then return //alfee 09.16.2011

if tab_1.selectedtab = 1 then
	//idw_detail.update()  //Start Code Change ----06.30.2011 #V11 maha - commented by alfee 09.16.2011
	nr = idw_detail.insertrow(0)
	idw_detail.setitem(nr,"facility_id",il_parent)
	select count(department) into :cnt from pd_affil_dept where prac_id = :il_prac and facility_id = :il_parent and active_status in (1,4);
	if cnt = 1 then
		select department into :ll_dept from pd_affil_dept where prac_id = :il_prac and facility_id = :il_parent and active_status in (1,4);
		idw_detail.setitem(nr,"department",ll_dept)
	end if
	idw_detail.setitem(nr,"active_status",1) //Start Code Change ----08.13.2009 #V92 maha
	idw_detail.scrolltorow(nr)
elseif tab_1.selectedtab = 2 then
	of_add_document("D" )
elseif tab_1.selectedtab = 3 then //Start Code Change ----06.22.2011 #V11 maha 
	//add a manual action
end if
end event

type rb_oppe from radiobutton within uo_oppe_fppe_evals
integer x = 1125
integer y = 60
integer width = 261
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "OPPE"
end type

event clicked;is_type_filter = "oppe_fppe = 'OPPE'"

of_filter()
end event

type rb_fppe from radiobutton within uo_oppe_fppe_evals
integer x = 1390
integer y = 60
integer width = 242
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "FPPE"
end type

event clicked;is_type_filter = "oppe_fppe = 'FPPE'"

of_filter()
end event

type rb_all_stat from radiobutton within uo_oppe_fppe_evals
integer x = 46
integer y = 60
integer width = 178
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "All"
boolean checked = true
end type

event clicked;is_stat_filter = ""
of_filter()
end event

type rb_cur from radiobutton within uo_oppe_fppe_evals
integer x = 238
integer y = 60
integer width = 302
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Current"
end type

event clicked;is_stat_filter = "active_status = 1"
of_filter()


end event

type rb_his from radiobutton within uo_oppe_fppe_evals
integer x = 553
integer y = 64
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "History"
end type

event clicked;is_stat_filter = "active_status = 0"
of_filter()

end event

type rb_all_type from radiobutton within uo_oppe_fppe_evals
integer x = 901
integer y = 60
integer width = 192
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "All"
boolean checked = true
end type

event clicked;is_type_filter = ""

of_filter()
end event

type tab_1 from tab within uo_oppe_fppe_evals
event create ( )
event destroy ( )
integer x = 9
integer y = 172
integer width = 3557
integer height = 1624
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_actions tabpage_actions
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_actions=create tabpage_actions
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_actions}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_actions)
end on

event selectionchanged;if tab_1.tabpage_1.dw_browse.rowcount() > 0 then
	il_hdr_id =tab_1.tabpage_1.dw_browse.getitemnumber(tab_1.tabpage_1.dw_browse.getrow(),"pd_oppe_hdr_id") 
	
//end if  --delete by stephen 09.22.2011 BugS091901

	if newindex = 2 then
		tab_1.tabpage_2.dw_docs.retrieve(il_hdr_id)
	elseif newindex = 3 then
		tab_1.tabpage_actions.dw_act_browse.retrieve(il_hdr_id)
		tab_1.tabpage_actions.dw_act_browse.sharedata( idw_actions )
		
	end if
//------------------- APPEON BEGIN -------------------
//$<add> Stephen 19.22.2011
//$<reason> Profile Module Refresh Issue  --BugS091901
else
	if newindex = 2 then
		tab_1.tabpage_2.dw_docs.reset()
	elseif newindex = 3 then
		tab_1.tabpage_actions.dw_act_browse.reset()
		tab_1.tabpage_actions.dw_act_browse.sharedata( idw_actions )
		
	end if
end if 
//------------------- APPEON BEGIN -------------------

if upperbound(ii_security) = 0 then//Start Code Change ----08.13.2009 #V92 maha
	of_set_security( )
end if


IF newindex = 2  and  tab_1.tabpage_2.dw_docs.rowcount() > 0 THEN  //alfee 07.14.2009
//Start Code Change ----07.22.2009 #V92 maha - added security
	if ii_security[1] < 2 or ii_security[3] < 2 then
		cb_add.visible = false
		cb_update.visible = FALSE
	else
		cb_update.visible = TRUE
		cb_add.visible = true
	end if
Elseif newindex = 3 then  //Start Code Change ----08.09.2012 #V12 maha
	cb_add.visible = false
ELSE
	cb_update.visible = FALSE
	if ii_security[1] < 2 then
		cb_add.visible = false
	else
		cb_add.visible = true
	end if
END IF
//End Code Change---07.22.2009
IF newindex = 1 THEN	//long.zhang 08.09.2011 red flag data: #v11.3
	IF ii_security[5] = 0 THEN
		cb_add_flag.visible =  false
	ELSE
		cb_add_flag.visible =  true
	END IF
ELSE
	cb_add_flag.visible =  false
END IF

of_set_rb()  //Start Code Change ----06.22.2011 #V11 maha 

if newindex = 3 then
	cb_letter.visible = true
	cb_email.visible = true
else
	cb_letter.visible = false
	cb_email.visible = false	
end if
end event

event selectionchanging;//Save new record first - alfee 09.16.2011

long ll_row

if oldindex = 1 and newindex <> oldindex then
	
	ll_row = tab_1.tabpage_1.dw_browse.getrow()
	if ll_row > 0 then
		if tab_1.tabpage_1.dw_browse.getitemstatus(ll_row, 0, Primary!) = New! or  tab_1.tabpage_1.dw_browse.getitemstatus(ll_row, 0, Primary!) = NewModified!  THEN
			if of_save() = -1 then return 1	//prevent changing		
		end if
	end if
end if

end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3520
integer height = 1508
long backcolor = 16777215
string text = "Evaluations"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
dw_detailxx dw_detailxx
dw_browse dw_browse
end type

on tabpage_1.create
this.dw_detail=create dw_detail
this.dw_detailxx=create dw_detailxx
this.dw_browse=create dw_browse
this.Control[]={this.dw_detail,&
this.dw_detailxx,&
this.dw_browse}
end on

on tabpage_1.destroy
destroy(this.dw_detail)
destroy(this.dw_detailxx)
destroy(this.dw_browse)
end on

type dw_detail from u_dw within tabpage_1
integer x = 23
integer y = 852
integer width = 3465
integer height = 640
integer taborder = 11
string dataobject = "d_oppe_fppe_prac_detail"
end type

event constructor;call super::constructor;this.settransobject(sqlca)



end event

event itemchanged;call super::itemchanged;if dwo.name = "process_template" then
//	return 1 //delete by Stephen 09.08.2011 --Bug id 2608
//	integer res
//	integer cnt
//	long ll_header
//	long ll_org
//	long ll_new
//	string ls_res
//
//		this.accepttext()
//	if not isnull(this.getitemnumber(row,"process_template",primary!,true)) then //test for change of template and delete existing actions
//		ll_org = this.getitemnumber(row,"process_template",primary!,True)
//		ll_new = this.getitemnumber(row,"process_template", primary!,False)
//		ll_header = this.getitemnumber(row,"pd_oppe_hdr_id")
//		
//		if isnull( ll_header ) then //Start Code Change ----09.07.2011 #V11 maha 
//			return
//		else
//			select count(rec_id) into :cnt from pd_process_actions where function_id = :ll_header;
//			if cnt > 0 then 
//				open(w_template_change_message)
//
//				ls_res = message.stringparm
//				choose case ls_res
//					case "D" //delete all
//						delete from pd_process_actions where function_id = :ll_header;
//						commit using sqlca;
//					case "K" //delete incompletes
//						delete from pd_process_actions where function_id = :ll_header and response_code is null;
//						commit using sqlca;
//					case "O" //reset to original
//						this.setitem(row,"process_template", ll_org)
//						this.accepttext()
//						this.setitemstatus(row,"process_template", primary!,notmodified!)
//					
//				end choose
//			end if
//		end if
//	end if
//Start Code Change ----07.06.2011 #V11 maha - default process template
elseif dwo.name = "oppe_fppe" then
	integer li_temp
	long ll_facil
	ll_facil = this.getitemnumber(row,"facility_id")
	if ll_facil > 0 then
		if data = "OPPE" then
			li_temp = integer(gnv_data.of_getitem("facility", "default_oppe_process", "facility_id = " + string(ll_facil)))
		elseif data = "OPPE" then
			li_temp = integer(gnv_data.of_getitem("facility", "default_fppe_process", "facility_id = " + string(ll_facil)))
		end if
		if li_temp > 0 and isnull(this.getitemnumber(row,"process_template")) then this.setitem(row,"process_template",li_temp)
	end if
//End Code Change ----07.06.2011 #V11 maha	
end if















end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----06.29.2011 #V11 maha  - added
if dwo.name = "b_link" then
	long ll_prac
	long ll_fac
	gs_variable_array lst_data
	long ll_profile
	
	lst_data.as_number[1] = il_prac
	lst_data.as_number[2] = il_parent
	
	openwithparm(w_qa_profile_select,lst_data)
	
	ll_profile = message.doubleparm
	
	if ll_profile > 0 then this.setitem(row,"profile_id", ll_profile)
end if

if dwo.name = "b_view" then
	long pid
	pid = this.getitemnumber(row,"profile_id")
	if isnull(pid) or pid = 0 then
		messagebox("Profile","There is no connected QA profile for this record")
		return
	else
		gs_report_variables lst_arg

		lst_arg.as_report_object = "d_rpt_pd_qa_detail_data"
		lst_arg.ai_num_variables = 1
		lst_arg.as_var_type[1] = "N"
		lst_arg.as_value[1] = string(pid)
		
		if isvalid(w_report_view) then close(w_report_view)
		
		openwithparm(w_report_view,lst_arg)
	end if
end if

if dwo.name = "b_plan" then
	string ls_name
	select full_name into :ls_name from v_full_name where prac_id = :il_prac;
	
	ls_name = ls_name + "@" + string(il_hdr_id) + "&" + "PRAC"
	openwithparm( w_fppe_prac_plan, ls_name)	
	
end if
end event

event pfc_update;//Overrided and added by alfee 09.02.2011 - BugL082901 
//Called only in the Window's closequery()

//return cb_save.event clicked() 
return of_save() //alfee 09.16.2011

end event

event pfc_postupdate;call super::pfc_postupdate;//Start Code Change ----09.07.2011 #V11 maha 
if this.rowcount() > 0 then
	il_hdr_id = this.getitemnumber(this.getrow(),"pd_oppe_hdr_id")
end if

return 1
end event

event rowfocuschanged;call super::rowfocuschanged;//alfee 09.15.2011 - BugA090601 

if currentrow < 1 then return 0

if dw_browse.getrow() <> currentrow and dw_browse.rowcount() >= currentrow then
	dw_browse.scrolltorow(currentrow)	
end if
end event

type dw_detailxx from datawindow within tabpage_1
boolean visible = false
integer x = 3374
integer y = 1412
integer width = 87
integer height = 72
integer taborder = 90
string title = "none"
string dataobject = "d_oppe_fppe_prac_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//Start Code Change ----06.29.2011 #V11 maha  - added
if dwo.name = "b_link" then
	long ll_prac
	long ll_fac
	gs_variable_array lst_data
	long ll_profile
	
	lst_data.as_number[1] = il_prac
	lst_data.as_number[2] = il_parent
	
	openwithparm(w_qa_profile_select,lst_data)
	
	ll_profile = message.doubleparm
	
	if ll_profile > 0 then this.setitem(row,"profile_id", ll_profile)
end if

if dwo.name = "b_view" then
	long pid
	pid = this.getitemnumber(row,"profile_id")
	if isnull(pid) or pid = 0 then
		messagebox("Profile","There is no connected QA profile for this record")
		return
	else
		gs_report_variables lst_arg

		lst_arg.as_report_object = "d_rpt_pd_qa_detail_data"
		lst_arg.ai_num_variables = 1
		lst_arg.as_var_type[1] = "N"
		lst_arg.as_value[1] = string(pid)
		
		if isvalid(w_report_view) then close(w_report_view)
		openwithparm(w_report_view,lst_arg)
			end if
		end if
end event

event constructor;this.settransobject(sqlca)
end event

event itemchanged;if this.dataobject = "process_template" then
	integer res
	integer cnt
	long ll_header
	long ll_org
	string ls_res
	if not isnull(this.getitemnumber(row,"process_template",primary!,true)) then //test for change of template and delete existing actions
		ll_org = this.getitemnumber(row,"process_template",primary!,True)
		select count(rec_id) into :cnt from pd_process_actions where function_id = :ll_header;
		if cnt > 0 then 
			open(w_template_change_message)
			ls_res = message.stringparm
			choose case ls_res
				case "D" //delete all
					delete from pd_process_actions where function_id = :ll_header;
					commit using sqlca;
				case "K" //delete incompletes
					delete from pd_process_actions where function_id = :ll_header and response_code is null;
					commit using sqlca;
				case "O" //reset to original
					this.setitem(row,"process_template",this.getitemnumber(row,"process_template",primary!,true))
			end choose
		end if
	end if
end if
end event

event updatestart;////alfee 07.14.2009
//
//datetime ldt_date
//Long ll_hdr_id, ll_cnt, i
//long ll_template
//long ll_org
//long ll_facil
//integer cnt
//string ls_mess = ""
//
//
////
//
//IF This.ModifiedCount( ) < 1 THEN RETURN 0 //continue
//
////Start Code Change ----06.30.2011 #V11 maha - added validation
//i = this.getrow()
//ll_facil = this.getitemnumber(i, "facility_id")
//if isnull(ll_facil) then ls_mess = "Facility~r"
//
//ldt_date = this.getitemdatetime(i, "from_date")
//if isnull(ldt_date) then ls_mess = "From Date~r"
//
//ldt_date = this.getitemdatetime(i, "to_date")
//if isnull(ldt_date) then ls_mess = "To Date~r"
//
//if isnull(this.getitemstring(i, "oppe_fppe")) then ls_mess = "Eval. Type~r"
//
//if len(ls_mess) > 0 then
//	ls_mess = "The following data fields are required:~r" + ls_mess
//	return 1
//end if
////End Code Change ----06.30.2011 
//
////Set key fields
//Select IsNull(Max(pd_oppe_hdr_id), 0) + 1 Into :ll_hdr_id From pd_oppe_hrd;
//IF SQLCA.SQLCode = -1 THEN 
//	MessageBox("SQL error", "Faild to update due to: " + SQLCA.SQLErrText)
//	RETURN 1	
//END IF
//debugbreak()
////Start Code Change ----06.30.2011 #V11 maha - added a save to the add function so looping is not required
////ll_cnt = This.RowCount()
////FOR i = 1 to ll_cnt
//	IF This.getitemstatus( i, 0, Primary!) = NewModified!	THEN
//		this.SetItem(i, 'pd_oppe_hdr_id', ll_hdr_id)
//		this.SetItem(i, 'prac_id', il_prac)
//		ll_hdr_id ++
//		ll_template = this.getitemnumber(i,"process_template")
//		if not isnull(ll_template) then of_add_next_action(ll_template,ll_hdr_id,0, il_prac,ll_facil)
//	elseif This.getitemstatus( i, 0, Primary!) = DataModified!	THEN
//		if This.getitemstatus( i, "process_template", Primary!) = DataModified! then
//			ll_template = this.getitemnumber(i,"process_template")
//			of_add_next_action(ll_template,ll_hdr_id,0, il_prac,ll_facil)
//		end if
//	END IF
//
////NEXT

RETURN 0
end event

type dw_browse from datawindow within tabpage_1
integer x = 18
integer y = 12
integer width = 3474
integer height = 812
integer taborder = 10
boolean titlebar = true
string title = "Browse"
string dataobject = "d_oppe_fppe_prac_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

end event

event constructor;this.settransobject(sqlca)
end event

event rowfocuschanged;integer r

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 09.22.2011
//$<reason> Profile Module Refresh Issue  --BugS091901
if currentrow < 1 then 
	setnull(il_hdr_id)
	return  
end if
//------------------- APPEON END -------------------

r = currentrow
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

//r = tab_1.tabpage_1.dw_detail.find("",1,tab_1.tabpage_1.dw_detail..rowcount())

//if r > 0 then 
if r > 0 and tab_1.tabpage_1.dw_detail.getrow() <> r then //alfee 09.15.2011
	tab_1.tabpage_1.dw_detail.setrow(r)
	tab_1.tabpage_1.dw_detail.scrolltorow(r)
end if

il_hdr_id = this.getitemnumber(currentrow, "pd_oppe_hdr_id") //alfee 09.16.2011
end event

event doubleclicked;tab_1.selecttab( 2)
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3520
integer height = 1508
long backcolor = 16777215
string text = "Documentation"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_docs dw_docs
end type

on tabpage_2.create
this.dw_docs=create dw_docs
this.Control[]={this.dw_docs}
end on

on tabpage_2.destroy
destroy(this.dw_docs)
end on

type dw_docs from datawindow within tabpage_2
integer x = 9
integer y = 16
integer width = 3497
integer height = 1472
integer taborder = 10
boolean titlebar = true
string title = "Evaluation Documents"
string dataobject = "d_oppe_prac_documents"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleshadowbox!
end type

event constructor;this.settransobject(sqlca)
this.setrowfocusindicator( p_1)
end event

event clicked;integer r

r = this.getclickedrow( )
this.setrow(r)
end event

event buttonclicked;//Start Code Change ----07.16.2009 #V92 maha - moved from separate button
if dwo.name = "b_view" then 
	//alfee 07.14.2009
	Long ll_row, ll_dcmt_id
	String ls_file_name, ls_file_type
	
	ll_row = this.getrow() 
	IF ll_row > 0 THEN
		ll_dcmt_id = this.GetItemNumber(ll_row, "dcmt_id")
		ls_file_name = this.GetItemString(ll_row, "file_name")
		ls_file_type = this.GetItemString(ll_row, "file_type")
		IF LeftA(ls_file_type, 1) = '.' THEN ls_file_type = MidA(ls_file_type, 2)
		ls_file_type = Trim(Lower(ls_file_type))
		
		of_view_document(ls_file_name, ls_file_type, ll_dcmt_id)
	END IF
end if
end event

event rowfocuschanged;//this.selectrow(0 ,false)
//this.selectrow(currentrow,true)
end event

type tabpage_actions from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3520
integer height = 1508
long backcolor = 16777215
string text = "Action Items"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_act_browse dw_act_browse
dw_actions dw_actions
end type

on tabpage_actions.create
this.dw_act_browse=create dw_act_browse
this.dw_actions=create dw_actions
this.Control[]={this.dw_act_browse,&
this.dw_actions}
end on

on tabpage_actions.destroy
destroy(this.dw_act_browse)
destroy(this.dw_actions)
end on

type dw_act_browse from datawindow within tabpage_actions
integer y = 4
integer width = 3511
integer height = 1100
integer taborder = 70
string title = "none"
string dataobject = "d_process_actions_ofe_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;this.getclickedrow()
this.SetRow(Row)
this.selectrow(0,false)
this.selectrow(row,true)
idw_actions.ScrollToRow(Row)
end event

event rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event constructor;this.settransobject(sqlca)
end event

type dw_actions from u_dw within tabpage_actions
integer y = 1120
integer width = 3168
integer height = 404
integer taborder = 11
string dataobject = "d_process_actions_ofe"
boolean vscrollbar = false
boolean border = false
end type

event pfc_postupdate;call super::pfc_postupdate;//create the next step

return 1
end event

event constructor;call super::constructor;datawindowchild dwchild

//this.setrowfocusindicator( p_1)  //Start Code Change ----02.03.2016 #V15 maha - removed
this.settransobject(sqlca)


end event

event itemchanged;call super::itemchanged;//debugbreak()
if dwo.name = "response_code" then
	if isnull(this.getitemdatetime(row, "complete_date")) then this.setitem(row, "complete_date", datetime(today(),now()))
	if isnull(this.getitemstring(row, "user_name")) then this.setitem(row, "user_name", gs_user_id )
end if
end event

event rowfocuschanged;call super::rowfocuschanged;boolean lb_e
boolean lb_l

if currentrow = 0 then 
	lb_e = false
	lb_l = false
else
	if this.getitemnumber(currentrow,"print_flag") = 0 then
		lb_e = false
		lb_l = false
	else
		choose case this.getitemnumber(currentrow,"process_type")
			case 2 
				lb_e = false
				lb_l = true
			case 3
				lb_e = true
				lb_l = false		
			case else
				lb_e = false
				lb_l = false
		end choose
	end if
end if

if lb_e then 
	cb_email.enabled = true
else
	cb_email.enabled = false
end if

if lb_l then 
	cb_letter.enabled = true
else
	cb_letter.enabled = false
end if

	
	
end event

event pfc_preupdate;call super::pfc_preupdate;integer r
datetime ldt_today

ldt_today = datetime(today(),now())

for r = 1 to this.rowcount()
	if this.getitemstatus( r, 0, Primary!) = NewModified! or this.getitemstatus( r, 0, Primary!) = DataModified! then
		this.setitem(r , "mod_date" , ldt_today)
		this.setitem(r , "mod_user" , gs_user_id)
	end if
next
			
			
return 1
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,1 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event retrieveend;call super::retrieveend;datawindowchild dwchild

this.getchild( "response_code", dwchild)
dwchild.settransobject(sqlca)
dwchild.insertrow(1)
end event

event buttonclicked;call super::buttonclicked;IF dwo.name = 'b_notes' THEN
	//Start Code Change ----02.03.2016 #V15 maha - moved to clicked event
//		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new, This.GetItemString( row, "notes" ))
//	string ls_notes
//	ls_notes = This.GetItemString( row, "notes" )
//	if isnull(ls_notes) then ls_notes = ""
//	OpenWithParm( w_ai_notes_new, ls_notes)
//	//---------End Modfiied ------------------------------------------------------
////	IF appeongetclienttype() = 'WEB' THEN  
////		//OpenWithParm( w_ai_notes_web, "A" + This.GetItemString( row, "notes" ))
////		OpenWithParm( w_ai_notes_web, This.GetItemString( row, "notes" ))	//changed by long.zhang 08.25.2011--removed A from front
////	ELSE		
////		//OpenWithParm( w_ai_notes, "A" + This.GetItemString( row, "notes" ))  
////		OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))  //changed by long.zhang 08.25.2011--removed A from front
////	END IF	
//
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		This.SetItem( row, "notes", Message.StringParm )
//		this.update() 
//	END IF

ELSEIF dwo.name = "b_doc" then
	long ll_doc
	ll_doc = This.GetItemnumber( row, "dcmt_id" )
	
	if ll_doc > 0 then
		of_view_document("*GETFILE*", "", ll_doc)
	else
		ll_doc = of_add_document("A")
		if ll_doc > 0 then this.setitem(row,"dcmt_id",ll_doc)
	end if

END IF


end event

event clicked;call super::clicked;//Start Code Change ----02.03.2016 #V15 maha - moved from buttonclicked

IF dwo.name = 'b_notes' THEN
	string ls_notes
	ls_notes = This.GetItemString( row, "notes" )
	if isnull(ls_notes) then ls_notes = ""
	OpenWithParm( w_ai_notes_new, ls_notes)

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		This.SetItem( row, "notes", Message.StringParm )
		this.update() 
	END IF
end if
end event

type cb_update from commandbutton within uo_oppe_fppe_evals
integer x = 2761
integer y = 48
integer width = 462
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update Doc"
end type

event clicked;string ls_fullname, ls_name
string ls_ext
integer value
integer li_pos, p
string ls_file_name
integer li_ret
integer nr
long li_rec

//-----------Begin Added by Alfee 07.14.2009 ------------------------
nr = tab_1.tabpage_2.dw_docs.GetRow()
IF nr < 1 THEN
	of_add_document("D")
	RETURN 1
END IF

IF tab_1.tabpage_2.dw_docs.GetItemNumber(nr, "flen") > 0 THEN
	li_ret = MessageBox("Upload Document","A document is already exists for current record, would you like to replace it?", Question!, YesNo!, 2)
	IF li_ret = 2 THEN RETURN 0
END IF
//------------End Added ---------------------------------------------

Value = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Word Documents(*.docx),*.docx," &
	+ "Excel Files (*.xls),*.xls" 	)   

if value  = 0 then return 0 //cancel

//Start Code Change ----07.12.2011 #V11 maha 
p = 1
Do until p = 0
	p = pos(ls_fullname,"." , p + 1)
	if p > 0 then li_pos = p
loop
	
//ls_ext = Upper(RightA(Trim(ls_fullname),3)) 
ls_ext = Upper(mid(ls_fullname,li_pos + 1)) 
//End Code Change ----07.12.2011


//-----------Begin Modified by Alfee 07.14.2009----------------------
li_rec = tab_1.tabpage_2.dw_docs.GetItemNumber(nr,"dcmt_id")
tab_1.tabpage_2.dw_docs.setitem(nr,"file_name",ls_name )
tab_1.tabpage_2.dw_docs.setitem(nr,"file_type",ls_ext)
tab_1.tabpage_2.dw_docs.setitem(nr,"add_date",datetime(today(),now()))
tab_1.tabpage_2.dw_docs.setitem(nr,"add_user",gs_user_id )
tab_1.tabpage_2.dw_docs.update()

IF of_upload_doc_data("OPPE", ls_fullname,"",li_rec) = -1 THEN
	Messagebox( "Upload Document", "Failed to upload the document!")
	RETURN -1
ELSE
	Messagebox( "Upload Document", "The document has been successfuly uploaded!")
END IF
/*
select max(dcmt_id) into :li_rec from pd_oppe_docs;
if isnull(li_rec) then li_rec = 0
li_rec++

nr = tab_1.tabpage_2.dw_docs.insertrow(0)
tab_1.tabpage_2.dw_docs.setitem(nr,"dcmt_id",li_rec)
tab_1.tabpage_2.dw_docs.setitem(nr,"file_name",ls_name )
tab_1.tabpage_2.dw_docs.setitem(nr,"file_type",ls_ext)
tab_1.tabpage_2.dw_docs.setitem(nr,"oppe_hdr_id",il_hdr_id)
tab_1.tabpage_2.dw_docs.setitem(nr,"prac_id",il_prac)
tab_1.tabpage_2.dw_docs.setitem(nr,"facility_id",il_parent)
tab_1.tabpage_2.dw_docs.setitem(nr,"add_date",datetime(today(),now()))
tab_1.tabpage_2.dw_docs.setitem(nr,"add_user",gs_user_id )

tab_1.tabpage_2.dw_docs.update()

of_upload_doc_data("OPPE", ls_file_name,"",li_rec) //app function
*/
//------------End Modified ------------------------------------------

if tab_1.selectedtab = 1 then
	tab_1.selecttab(2)
end if

RETURN 1
end event

type gb_1 from groupbox within uo_oppe_fppe_evals
integer x = 859
integer y = 4
integer width = 809
integer height = 148
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Type"
end type

type gb_2 from groupbox within uo_oppe_fppe_evals
integer x = 14
integer y = 4
integer width = 837
integer height = 148
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "Status"
end type

