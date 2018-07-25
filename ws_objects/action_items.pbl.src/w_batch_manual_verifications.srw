$PBExportHeader$w_batch_manual_verifications.srw
forward
global type w_batch_manual_verifications from w_main
end type
type cbx_show from checkbox within w_batch_manual_verifications
end type
type cb_logs from commandbutton within w_batch_manual_verifications
end type
type st_2 from statictext within w_batch_manual_verifications
end type
type dw_log from u_dw within w_batch_manual_verifications
end type
type dw_crawler from u_dw within w_batch_manual_verifications
end type
type cb_crawl from commandbutton within w_batch_manual_verifications
end type
type dw_last_log from u_dw within w_batch_manual_verifications
end type
type cb_close from commandbutton within w_batch_manual_verifications
end type
type cb_web from commandbutton within w_batch_manual_verifications
end type
type cb_save from commandbutton within w_batch_manual_verifications
end type
type st_1 from statictext within w_batch_manual_verifications
end type
type dw_select from u_dw within w_batch_manual_verifications
end type
type cb_prac from commandbutton within w_batch_manual_verifications
end type
type cb_batch from commandbutton within w_batch_manual_verifications
end type
type cb_forward from commandbutton within w_batch_manual_verifications
end type
type cb_back from commandbutton within w_batch_manual_verifications
end type
type dw_pracs from u_dw within w_batch_manual_verifications
end type
type dw_batch from u_dw within w_batch_manual_verifications
end type
type dw_browse from u_dw within w_batch_manual_verifications
end type
type dw_data from u_dw within w_batch_manual_verifications
end type
type cb_capture from commandbutton within w_batch_manual_verifications
end type
type dw_status from u_dw within w_batch_manual_verifications
end type
type ole_browser from olecustomcontrol within w_batch_manual_verifications
end type
type cb_get from commandbutton within w_batch_manual_verifications
end type
type st_stamp from statictext within w_batch_manual_verifications
end type
end forward

global type w_batch_manual_verifications from w_main
integer width = 4965
integer height = 2900
string title = "Batch Web Verifications"
windowtype windowtype = popup!
long backcolor = 33551856
cbx_show cbx_show
cb_logs cb_logs
st_2 st_2
dw_log dw_log
dw_crawler dw_crawler
cb_crawl cb_crawl
dw_last_log dw_last_log
cb_close cb_close
cb_web cb_web
cb_save cb_save
st_1 st_1
dw_select dw_select
cb_prac cb_prac
cb_batch cb_batch
cb_forward cb_forward
cb_back cb_back
dw_pracs dw_pracs
dw_batch dw_batch
dw_browse dw_browse
dw_data dw_data
cb_capture cb_capture
dw_status dw_status
ole_browser ole_browser
cb_get cb_get
st_stamp st_stamp
end type
global w_batch_manual_verifications w_batch_manual_verifications

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
pfc_cst_nv_data_entry_functions inv_data_fun
pfc_n_cst_ai_action_items  inv_action_items
string is_Site //Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
end variables

forward prototypes
public function integer of_batch_type (string as_type)
public function integer of_screen_id (integer ai_table)
public function integer of_get_data ()
public function integer of_get_prac_data (string as_table, string as_field, long al_entid, string as_filter)
public function integer of_set_lookup_filter ()
public function integer of_get_sreen_print (integer ai_format)
public function integer of_capture_html ()
public function integer of_capture_bmp ()
public function integer of_reset ()
public function integer of_get_crawler ()
public function integer of_seterrorevent (oleobject aole_object)
end prototypes

public function integer of_batch_type (string as_type);long n
string s

//O = oig; W = website; C = crawler

choose case as_type
	case "O"
		dw_batch.setitem(1,"screen_id" , 25)
		setnull(n)
		dw_batch.setitem(1,"entity_id" , n )
		dw_batch.modify("entity_id.protect = true ")
		dw_batch.modify("screen_id.protect = true ")
		dw_batch.modify("screen_id.color = 0 ")
		dw_batch.modify("addtl_filter.protect = true ")
		cb_web.enabled = false
		cb_forward.enabled = false
		cb_back.enabled = false
	case "W"
		dw_batch.modify("entity_id.protect = false ")
		dw_batch.modify("screen_id.protect = false ")
		dw_batch.modify("addtl_filter.protect = false ")
		cb_web.enabled = true
		cb_crawl.enabled = false
	case "C"
		dw_batch.modify("entity_id.protect = false ")
		dw_batch.modify("screen_id.protect = false ")
		dw_batch.modify("addtl_filter.protect = false ")
		cb_web.enabled = false
		cb_crawl.enabled = true
		dw_status.retrieve()
		dw_status.insertrow(1)
end choose

is_type = as_type

of_set_lookup_filter( )
		
return 1
end function

public function integer of_screen_id (integer ai_table); //Start Code Change ----07.07.2015 #V15 maha - gets the lookup table name and the screen id for the table

datawindowchild dwchild
string ls_lu
select top 1 lookup_code into :ls_lu from sys_fields where table_id = :ai_table and lookup_type = 'A' and lookup_code is not null;
select screen_id into :il_screen from data_view_screen where table_id = :ai_table and data_view_id = 1;

dw_batch.getchild( "entity_id", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(ls_lu)

of_set_lookup_filter( )

return 1
end function

public function integer of_get_data ();string r
SetRedraw(false)
r = inv_data_fun.of_create_dynamic_dw(il_pracid, il_dvid , il_screen, dw_data, dw_browse,false, 0, false)
//messagebox("", r)

dw_data.SetFilter( "rec_id = " + String( il_rec_id ) )
dw_data.Filter( )

//dw_last_log.retrieve( il_rec_id)  not using
dw_log.retrieve( il_rec_id)

if is_type = "W" then  //
	dw_log.insertrow(1)
end if


SetRedraw(true)

return 1
end function

public function integer of_get_prac_data (string as_table, string as_field, long al_entid, string as_filter);string ls_sql
string ls_org
//string ls_table
string ls_where
string ls_filter
string ls_ent_id
integer r


//al_entid = 1205
//as_table = "pd_license"
//as_field = "verifying_agency"
dw_pracs.of_settransobject( sqlca)
ls_org =  dw_pracs.GetSQLSelect ()

ls_ent_id = string(al_entid)

ls_sql =  "SELECT distinct pd_basic.last_name,   pd_basic.first_name, " + as_table + ".prac_id, " + as_table + ".rec_id FROM "
ls_sql+= as_table  + ", pd_affil_stat, pd_basic "

ls_where = " WHERE " + as_table + ".prac_id = pd_affil_stat.prac_id AND pd_basic.prac_id = pd_affil_stat.prac_id AND pd_affil_stat.active_status in(1,4)  AND "  //should it be only active?
//ls_where+=  " pd." + as_field + " = " + ls_ent_id
ls_where+=  as_table + "." + as_field + " = " + ls_ent_id

//parent_facility_id conditon, Added by Appeon long.zhang 08.15.2017 (V15.3 Bug  #5758  - Batch Verifications are not filtering on selected facility case 00071879)
If il_facility > 0 Then
	ls_where+= " AND (pd_affil_stat.parent_facility_id = " + String(il_facility) + ") "
End If

if len(as_filter) > 3 then
	ls_where+= " AND " + as_filter
end if


ls_sql+= ls_where

ls_sql+= " ORDER by last_name ASC,first_name ASC ;"

//messagebox("",ls_sql)
//clipboard(ls_sql)

r = dw_pracs.of_settransobject( sqlca)
r = dw_pracs.SetSQLSelect ( ls_sql )
//messagebox(" set sql",r)

r = dw_pracs.Retrieve( )

dw_pracs.SetSQLSelect ( ls_org )


return 1
end function

public function integer of_set_lookup_filter (); //Start Code Change ----07.01.2015 #V15 maha
string ls_filter
datawindowchild dwchild
integer res

choose case is_type
	case "O"
		ls_filter = "lookup_code = 0"
	case "C"
		ls_filter = "not isnull(wc_id)"
	case "W"
		ls_filter = "not isnull(web_address)"
end choose

dw_batch.getchild( "entity_id", dwchild)

res = dwchild.setfilter(ls_filter)
if res < 0 then
	messagebox("Lookup List filter error",ls_filter)
end if

dwchild.filter()

return 1


		
end function

public function integer of_get_sreen_print (integer ai_format);//Start Code Change ----07.10.2014 #V14.2 maha - added alternative capture method
String ls_fname
Blob lblb_bitmap
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir
string ls_doc_id
string ls_text
long ll_id

//if il_current_row < 1 then return //(Appeon)Stephen 10.22.2014 - BugS101401
if ai_format = 2 then  //html
//	Return of_Capture() //Add by Evan 03.26.2009
elseif ai_format = 1 then //screenprint
	SetPointer(HourGlass!)
	
	ls_fname = gs_dir_path + "intellicred\webcapt.bmp"
	
//	ls_text = "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now())
//	st_datestamp.text = ls_text
//	st_datestamp.visible = true
//	st_datestamp.bringtotop = true
	
	lblb_bitmap = in_bitmap.of_WindowCapture(w_batch_manual_verifications, False)
	
//	st_datestamp.visible = false
//	st_datestamp.bringtotop = false
	
	in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap)

//	tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
//	ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")
	
	UPDATEBLOB verif_info
	SET verification_picture = :lblb_bitmap
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
//	tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."
	
	UPDATE verif_info
	SET verification_picture_flag = 3
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
//	idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 4)
	
	//MessageBox("Capture", "Update successfully!")
//	MessageBox("Capture", "Update successful!") //Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
end if

end function

public function integer of_capture_html (); //Start Code Change ----07.20.2015 #V15 maha
//Copied from verification batch screen capture function

integer li_Return
integer li_Null
long ll_counter, ll_loops
long ll_logid
long ll_cnt
string ls_doc_id
string ls_Error
string ls_URL
string ls_FileName
blob lblb_verif_picture

inet lnv_inet
n_internetresult lnv_InternetResult
n_cst_dm_utils lnv_file
n_cst_appeondll lnv_AppeonDll

SetNull(li_Null)
ls_FileName =  gs_temp_path + "capture.htm"
FileDelete(ls_FileName)

SetPointer(HOURGLASS!) 

ll_logid = dw_log.getitemnumber(1,"log_id")

try
	//-----Begin modified by alfee 04.16.2010 ---------------------------------
	lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 1) //modify file name & save	
	ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)


catch (RuntimeError e)
//	tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
	lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread - alfee 04.16.2010
	Return -1
end try

do while true
	Yield()
	if FileExists(ls_FileName) then Exit
	//---------Begin Added by alfee 04.16.2010 -------------------------------
	ll_loops ++
	if ll_loops > 99999 and appeongetclienttype() = 'WEB' then 
		//Prompt user from second time
		if ll_counter > 0 then 
			if messagebox(ls_FileName, "Waiting for capture file. Continue to wait?",question!,yesno!,1) = 2 then
//				tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
				lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread
				Return -1								
			end if
		end if
		
		//Popup the SaveAs dialog and wait to save the Web page manually
		ll_loops = 0
		ll_counter ++
//		tab_1.tabpage_view.st_cap_mess.text = "Make sure the File name is '" + ls_FileName + "' and the Save as type is 'Web Page, HTML only'."
		lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 2)	//modify the file name (not always working)
		ole_browser.object.ExecWB(4, 1, ls_FileName, li_Null) 
	end if
	//---------End Added ------------------------------------------------------
loop

lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread - alfee 04.16.2010

lnv_file.of_ReadBlob(ls_FileName, lblb_verif_picture)
//------------------- APPEON END ---------------------

// Update HTML source to database
//tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
//ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")

//---------Begin Added by (Appeon)Stephen 09.18.2016 for V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row--------
select count(1) into :ll_cnt from verif_batch_log_image where log_id = :ll_logid;
if ll_cnt < 1 then
//---------End Added ------------------------------------------------------
	insert into verif_batch_log_image (log_id, prac_id, rec_id, image_type) values(:ll_logid, :il_pracid, :il_rec_id, 'htm' );
	if SQLCA.SQLCode = -1 then
			MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
end if //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row

UPDATEBLOB verif_batch_log_image
SET image_data = :lblb_verif_picture
WHERE log_id = :ll_logid
USING SQLCA;

if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
//tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."

//UPDATE verif_info
//SET verification_picture_flag = 3
//WHERE doc_id = :ls_doc_id
//USING SQLCA;
//if SQLCA.SQLCode = -1 then
//	ROLLBACK USING SQLCA;
//	MessageBox("SQL Error", SQLCA.SQLErrText)
//	Return -1
//end if
//idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 3)


MessageBox("Capture", "Update successful!")// Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
Return 1
end function

public function integer of_capture_bmp ();//Start Code Change ----07.21.2015 #V15 maha - copied from Web verifications screen
String ls_fname
Blob lblb_bitmap
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir
string ls_doc_id
string ls_text
long ll_logid
long lw
long lh
long ll_cnt
n_cst_datetime lnv
string ls_FileName, ls_PdfName, ls_PathFile
n_cst_image_functions_cp ln_pdf //Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
Integer	li_rc

SetPointer(HourGlass!)
	
//ls_fname = gs_dir_path + "intellicred\webcapt.bmp" //Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign

//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
ls_pathFile =gs_dir_path + "intellicred\webcapt" 
li_rc = GetFileSaveName ( "Select File", ls_pathFile, ls_fname, "BMP", "BMP Files (*.BMP),*.BMP,PDF Files (*.PDF),*.PDF" , gs_dir_path+"intellicred\",  32770)
If li_Rc <> 1 Then
	Return -1
End If	
//---------End Added ------------------------------------------------------
	
	
ls_text = "   Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now()) + + "   " + is_Site  //Modifed by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
st_stamp.text = ls_text
st_stamp.visible = true
st_stamp.bringtotop = true

lw =  w_batch_manual_verifications.Width 
lh = w_batch_manual_verifications.Height

//---------Begin Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
//ole_browser.bringtotop = true
//ole_browser.width = w_batch_manual_verifications.Width 
//ole_browser.height = w_batch_manual_verifications.Height
//ole_browser.x = 10
//ole_browser.y = 100
//---------End Added ------------------------------------------------------
this.windowstate  = maximized!
ole_browser.x = 10
ole_browser.width = w_batch_manual_verifications.Width 
ole_browser.bringtotop = true

lnv.of_wait(1)

//return 1
//lblb_bitmap = in_bitmap.of_WindowCapture(w_batch_manual_verifications, False)  //Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
ls_FileName = gs_dir_path + "intellicred\webpageprint.bmp"

lblb_bitmap= in_bitmap.of_scroll_capturescreen( ole_browser, st_stamp )
//---------End Added ------------------------------------------------------

//messagebox(string(lw) + " - " + string(lh),  string(ole_browser.width) + " - " + string(ole_browser.height))
//w_batch_manual_verifications.triggerevent(resize!)
st_stamp.visible = false
	
//	st_datestamp.visible = false
//	st_datestamp.bringtotop = false
//	
//in_bitmap.of_WriteBlob(ls_fname, lblb_bitmap) //Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign

//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
If Upper(Right( ls_fname, 3 )) = "BMP" Then
	in_bitmap.of_WriteBlob(ls_pathFile, lblb_bitmap)
Else
	in_bitmap.of_WriteBlob(ls_FileName, lblb_bitmap)
	ln_pdf = create n_cst_image_functions_cp
	ln_pdf.of_convert2pdf( ls_FileName, ls_pathFile )

	If IsValid( ln_pdf) Then Destroy ln_pdf
End If	
w_batch_manual_verifications.triggerevent(resize!)
this.SetRedraw( true )
//---------End Added ------------------------------------------------------

dw_log.update()

ll_logid = dw_log.getitemnumber(1,"log_id")

//---------Begin Added by (Appeon)Stephen 09.18.2016 for V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row--------
select count(1) into :ll_cnt from verif_batch_log_image where log_id = :ll_logid;
if ll_cnt < 1 then
//---------End Added ------------------------------------------------------
	insert into verif_batch_log_image (log_id, prac_id, rec_id, image_type) values(:ll_logid, :il_pracid, :il_rec_id, 'bmp' );
	if SQLCA.SQLCode = -1 then
			MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
end if //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row

UPDATEBLOB verif_batch_log_image
SET image_data = :lblb_bitmap
WHERE log_id = :ll_logid
USING SQLCA;

if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
	
//MessageBox("Capture", "Update successful!") 


end function

public function integer of_reset ();
debugbreak()

dw_pracs.reset()

dw_data.reset()

dw_log.reset()

return 1
end function

public function integer of_get_crawler ();//gets the web crawler id from the selected entity
long wcid
long ll_row
long ll_ent
string sss
datawindowchild dwchild

ll_ent = dw_batch.getitemnumber(1, "entity_id")
sss = "lookup_code = " + string(ll_ent )

dw_batch.getchild("entity_id", dwchild)
ll_row = dwchild.find(sss ,1,dwchild.rowcount())
wcid = dwchild.getitemnumber(ll_row, 'wc_id')

if isnull(wcid)  then 
	messagebox("WebCrawler error", "There is no WebCrawler connected to this Entity")
else
	il_wc_id = wcid
	//messagebox("wc id", wcid)
end if


RETURN 1
end function

public function integer of_seterrorevent (oleobject aole_object);//====================================================================
//$<Function>: of_seterrorevent
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 11.03.2017 (V16.1 Web Capture Redesign)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long i, ll_Len
string ls_Script
oleobject lole_frame

ls_Script = &
"function window_onerror() {return true;} " + &
"var bErrorEvent = false; " + &
"try " + &
"{ " + &
"  var nLen = window.onerror.toString().length; " + &
"  if (nLen> 0) bErrorEvent = true; " + &
"} " + &
"catch (e) " + &
"{ " + &
"} " + &
"if (bErrorEvent == false) window.onerror = window_onerror; "

try
	aole_object.document.parentWindow.execScript(ls_Script, "JScript")	
	ll_Len = aole_object.document.frames.length
	if ll_Len > 0 then
		for i = 0 to ll_Len - 1
			lole_frame = aole_object.document.frames[i]
			of_SetErrorEvent(lole_frame)
		next
	end if
catch (RuntimeError e)
end try

Return 1
end function

on w_batch_manual_verifications.create
int iCurrent
call super::create
this.cbx_show=create cbx_show
this.cb_logs=create cb_logs
this.st_2=create st_2
this.dw_log=create dw_log
this.dw_crawler=create dw_crawler
this.cb_crawl=create cb_crawl
this.dw_last_log=create dw_last_log
this.cb_close=create cb_close
this.cb_web=create cb_web
this.cb_save=create cb_save
this.st_1=create st_1
this.dw_select=create dw_select
this.cb_prac=create cb_prac
this.cb_batch=create cb_batch
this.cb_forward=create cb_forward
this.cb_back=create cb_back
this.dw_pracs=create dw_pracs
this.dw_batch=create dw_batch
this.dw_browse=create dw_browse
this.dw_data=create dw_data
this.cb_capture=create cb_capture
this.dw_status=create dw_status
this.ole_browser=create ole_browser
this.cb_get=create cb_get
this.st_stamp=create st_stamp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_show
this.Control[iCurrent+2]=this.cb_logs
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.dw_log
this.Control[iCurrent+5]=this.dw_crawler
this.Control[iCurrent+6]=this.cb_crawl
this.Control[iCurrent+7]=this.dw_last_log
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_web
this.Control[iCurrent+10]=this.cb_save
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_select
this.Control[iCurrent+13]=this.cb_prac
this.Control[iCurrent+14]=this.cb_batch
this.Control[iCurrent+15]=this.cb_forward
this.Control[iCurrent+16]=this.cb_back
this.Control[iCurrent+17]=this.dw_pracs
this.Control[iCurrent+18]=this.dw_batch
this.Control[iCurrent+19]=this.dw_browse
this.Control[iCurrent+20]=this.dw_data
this.Control[iCurrent+21]=this.cb_capture
this.Control[iCurrent+22]=this.dw_status
this.Control[iCurrent+23]=this.ole_browser
this.Control[iCurrent+24]=this.cb_get
this.Control[iCurrent+25]=this.st_stamp
end on

on w_batch_manual_verifications.destroy
call super::destroy
destroy(this.cbx_show)
destroy(this.cb_logs)
destroy(this.st_2)
destroy(this.dw_log)
destroy(this.dw_crawler)
destroy(this.cb_crawl)
destroy(this.dw_last_log)
destroy(this.cb_close)
destroy(this.cb_web)
destroy(this.cb_save)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.cb_prac)
destroy(this.cb_batch)
destroy(this.cb_forward)
destroy(this.cb_back)
destroy(this.dw_pracs)
destroy(this.dw_batch)
destroy(this.dw_browse)
destroy(this.dw_data)
destroy(this.cb_capture)
destroy(this.dw_status)
destroy(this.ole_browser)
destroy(this.cb_get)
destroy(this.st_stamp)
end on

event resize;call super::resize; //Start Code Change ----05.14.2015 #V15 maha 
long ll_win_h
long ll_win_w
long ll_ole_h
long ll_ole_w
long ll_split


ll_win_h = this.WorkSpaceHeight() - 440
ll_ole_h = ll_win_h /10 *8
ole_browser.height = ll_ole_h
dw_pracs.height = ll_win_h     //ole_browser.height 
//dw_last_log.y = dw_pracs.y + dw_pracs.height + 10
//dw_last_log.height = 260

ll_ole_w = this.WorkSpaceWidth() - dw_pracs.width - 10
ole_browser.width = ll_ole_w
//debugbreak()
//dw_log.y = ole_browser.height + ole_browser.y +5
if ole_browser.visible = true then
	dw_log.height =  ll_win_h /10 *2 - 10
	dw_data.height =  ll_win_h /10 *2 - 10
//dw_data.y = ole_browser.height + ole_browser.y +5
	ole_browser.y = dw_log.y + dw_log.height + 10
	ole_browser.x = dw_data.x
else
	dw_log.height = dw_pracs.height
	dw_data.height = dw_pracs.height
end if

ll_split = (this.WorkSpaceWidth()  - dw_pracs.width - 30) / 2
dw_data.width = ll_split
dw_log.width = ll_split
//dw_data.width = this.WorkSpaceWidth() /5 * 3 - 10  //takes 3/5 of the width

dw_log.x = dw_data.x + 10 + dw_data.width
//dw_log.width = this.WorkSpaceWidth() /5 * 2 - 10   //takes 2/5 of the width

//cb_close.x = dw_batch.x + dw_batch.width + 50
//this.WorkSpaceWidth() - 230
//cb_save.x = dw_batch.x + dw_batch.width + 50



end event

event open;call super::open; //Start Code Change ----07.07.2015 #V15 maha - Added for 15.1
 inv_data_fun = create pfc_cst_nv_data_entry_functions
 inv_data_fun.of_setup_cache()
inv_data_fun.of_refresh_cache()

IF w_mdi.of_security_access( 7802 ) = 0 THEN
	cb_logs.visible = false
end if

end event

event close;call super::close;destroy inv_data_fun
end event

type cbx_show from checkbox within w_batch_manual_verifications
integer x = 2053
integer y = 24
integer width = 407
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Show Crawler"
end type

type cb_logs from commandbutton within w_batch_manual_verifications
integer x = 2894
integer y = 8
integer width = 585
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

type st_2 from statictext within w_batch_manual_verifications
boolean visible = false
integer x = 5216
integer y = 400
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

type dw_log from u_dw within w_batch_manual_verifications
integer x = 2770
integer y = 428
integer width = 2126
integer height = 400
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_batch_verif_log_rec"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;dw_log.setitem(row,"verif_date", datetime(today(),Now()))
dw_log.setitem(row,"user_id", gs_user_id)
end event

type dw_crawler from u_dw within w_batch_manual_verifications
boolean visible = false
integer x = 3959
integer y = 368
integer width = 91
integer height = 56
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_wc_hdr_imp"
boolean hscrollbar = true
end type

type cb_crawl from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 2473
integer y = 8
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Crawl"
end type

event clicked;Integer li_number_sent
Integer i
Integer li_rc
Integer li_facility_id
Integer li_cnt
Boolean lb_show
Long ll_prac_id
Long ll_retval
Integer li_crawl
integer li_type
integer newrow  //maha 08.10.2017
String ls_doc_id
string ls_emes
string ls_ret
long   ll_rec_id
long ll_log

//li_rc = idw_verif_list.RowCount( )
li_rc = dw_pracs.RowCount( )

if li_rc < 1 then
	messagebox("Providers","There are no providers in the connected records list.")
end if

nvo_web_crawler_engine lnvo_web_crawler

li_cnt = dw_pracs.rowcount()

if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.title = "Running WebCrawlers"
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = "Running" 
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_cnt)

//Start Code Change ----08.10.2017 #V154 maha
if cbx_show.checked then
	lb_show = true	
else
	lb_show = false	
end if
//End Code Change ----08.10.2017

FOR i = 1 TO li_rc	
	SetPointer( HourGlass! )

	dw_pracs.SelectRow( 0, False )
	dw_pracs.SelectRow( i, True )
	dw_pracs.ScrolltoRow( i )  //Start Code Change ----11.22.2013 #V14 maha
	
	li_crawl++
	
	if isvalid(w_infodisp) then w_infodisp.st_1.text = "Running crawler for " + dw_pracs.getitemstring(i,"first_name") + " " +  dw_pracs.getitemstring(i,"last_name")
	
	ll_prac_id = dw_pracs.GetItemNumber( i, "prac_id" )
	ll_rec_id =  dw_pracs.GetItemNumber( i, "rec_id" )  //add by Stephen 07.02.2012  -V12.2 WebCrawler extract data
	
	newrow = dw_log.insertrow(0)
	dw_log.setitem(newrow,"prac_id", ll_prac_id )
	dw_log.setitem(newrow, "rec_id", ll_rec_id )
	dw_log.setitem(newrow,"screen_id",il_screen)
	dw_log.setitem(newrow,"entity_id",il_entity)
	dw_log.setitem(newrow,"verif_date", datetime(today(),Now()))
	dw_log.setitem(newrow,"user_id", gs_user_id)
	dw_log.setitem(newrow,"batch_id",il_batch)//Added by Appeon long.zhang 12.14.2015 (BugL120804 )
	
	dw_log.update()   //pk is auto set in the database
	
	ll_log = dw_log.getitemnumber(newrow,"log_id")
	if isnull(il_facility)  then il_facility = 1
	
	//ls_doc_id = string(ll_rec_id) + "-" + string(ll_prac_id) + "-" +  string(il_facility)  + "-0-" +  string(ll_log)
	//ls_doc_id =  string(ll_log)
	ls_doc_id =  "B-" + string(ll_log)  //Start Code Change ----08.10.2017 #V16 maha	
	//messagebox("",ls_doc_id)


//Start Code Change ----11.22.2013 #V14 maha - trap for 0 id
	if il_wc_id = 0 then
		if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		Exit
	end if
//End Code Change ----11.22.2013	

	lnvo_web_crawler.ib_from_batch_verif = true   //Start Code Change ----07.21.2015 #V15 maha - set variable before running
	
	ls_ret = lnvo_web_crawler.of_crawl_new( il_wc_id,  ll_prac_id, ls_doc_id , lb_show, ll_rec_id, il_facility )
	
	//-------------Begin Modified by Alfee 02.08.2010 ---------------------
	//Set verif rec after Web Crawl - reorganized for scheduler	
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
	
	ll_retval = long(MidA(ls_ret, 1, PosA(ls_ret,"*",1) - 1))
	
	//if the crawler fails delet the created log row
	if ll_retval < 1 then 
		dw_log.deleterow(1)
		dw_log.update()
	end if
//	lnvo_web_crawler.of_set_verifs_aftercrawl( idw_verif_list, ls_ret, i)

// A FUNCTION TO ADD THE LOG RECORDS


//	hpb_1.Position = li_crawl * 50		
//	idw_verif_list.SetItem( i, "selected", 0 )	
END FOR

//hpb_1.Visible = False
if isvalid( w_infodisp ) then close(w_infodisp)
//tab_1.tabpage_verif.st_1.Text = "Web Crawl Complete."


end event

type dw_last_log from u_dw within w_batch_manual_verifications
boolean visible = false
integer x = 3607
integer y = 344
integer width = 210
integer height = 84
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_batch_verif_log_last"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.settransobject(sqlca)
this.of_setupdateable(false)
end event

type cb_close from commandbutton within w_batch_manual_verifications
integer x = 4562
integer y = 8
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

type cb_web from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 3515
integer y = 8
integer width = 325
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go To Site"
end type

event clicked;long ll_lu
string ls_site

if dw_batch.getrow() < 1 then return //(Appeon)Stephen 08.01.2016 - BugS072501
ll_lu = dw_batch.getitemnumber(1,"entity_id")

if isnull(ll_lu) then
	messagebox("Select Entity","No Entity selected for this batch")
end if

select web_address into :ls_site from address_lookup where lookup_code = :ll_lu;

if isnull(ls_site) or len(ls_site) < 10 then 
	messagebox("No Web Link","No valid WebSite for this entity. Please check the lookup list.")
	return
end if

try
	is_site = ls_site //Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
	ole_browser.object.navigate(ls_site)
	catch (RuntimeError e)
end try
end event

type cb_save from commandbutton within w_batch_manual_verifications
integer x = 1618
integer y = 8
integer width = 343
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;long ll_batch


//verif batch data
if dw_batch.getitemstatus( 1, 0, primary!) = datamodified! or dw_batch.getitemstatus( 1, 0, primary!) = newmodified! then
	if isnull(dw_batch.getitemnumber(1,"batch_id")) then
		select max(batch_id) into :ll_batch from verif_batch_setup;
		if isnull(ll_batch) then ll_batch = 0
		ll_batch++
		il_batch = ll_batch
		dw_batch.setitem(1,"batch_id",ll_batch)
	end if
end if

dw_batch.update()

 //Start Code Change ----07.10.2015 #V15 maha
 dw_log.accepttext()
if dw_log.getitemstatus( 1, 0, primary!) = newmodified! then
	dw_log.setitem(1,"prac_id", il_pracid )
	dw_log.setitem(1,"rec_id", il_rec_id )
	dw_log.setitem(1,"screen_id",il_screen)
	dw_log.setitem(1,"entity_id",il_entity)
	dw_log.setitem(1,"batch_id",il_batch)
	if isnull(dw_log.getitemdatetime(1,"verif_date")) then
		dw_log.setitem(1,"verif_date", datetime(today(),Now()))
		dw_log.setitem(1,"user_id", gs_user_id)
	end if
	
	dw_log.update()
end if

 dw_data.accepttext()
if dw_data.getitemstatus( 1, 0, primary!) = datamodified! then
	dw_data.event pfc_preupdate( )
	dw_data.update()
end if






end event

type st_1 from statictext within w_batch_manual_verifications
integer x = 59
integer y = 24
integer width = 594
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Verification Batch:"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_batch_manual_verifications
integer x = 640
integer y = 12
integer width = 759
integer height = 84
integer taborder = 20
string dataobject = "d_verif_batch_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)

this.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;long ll_table
string ls_type
string ls_site
long ll_lu
string ls_save


il_batch = long(data)

if il_batch < 1 then return

if il_batch > 0 then
	dw_batch.retrieve(il_batch)
	
	ls_type = dw_batch.getitemstring(1,"batch_type")
	of_batch_type(ls_type)

	ll_table = dw_batch.getitemnumber(1,"screen_id")
	of_screen_id(ll_table)
	
	il_dvid = dw_batch.getitemnumber(1,"dv_id")
	if isnull(il_dvid) or il_dvid = 0 then il_dvid = 1
	
	ls_save = dw_batch.getitemstring(1,"image_yn")
	choose case ls_save
		case "0"
			is_save_type = "N"
		case "1"
			is_save_type = "B"
		case "2"
			is_save_type = "H"
	end choose
	
	il_facility =  dw_batch.getitemnumber(1,"facility_id")

end if

if il_batch > 0 then cb_get.enabled = true

ll_lu = dw_batch.getitemnumber(1,"entity_id")
il_entity = ll_lu

//of_reset()
dw_pracs.reset()
dw_data.reset()
dw_log.reset()

cb_get.PostEvent(Clicked!)

//Start Code Change ----08.10.2017 #V154 maha - changes to hide some objects
if ls_type = "W" then
	ole_browser.visible = true
	if ll_lu > 0 then
		select web_address into :ls_site from address_lookup where lookup_code = :ll_lu;
		try
			is_site = ls_site //Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
			ole_browser.object.navigate(ls_site)
			catch (RuntimeError e)
		end try
	end if
	cb_capture.visible = true
	cb_web.visible = true
	cb_back.visible = true
	cb_forward.visible = true
	cb_crawl.visible = false
	cbx_show.visible = false
	
elseif ls_type = "C" then	
	ole_browser.visible = false
	cb_capture.visible = false
	cb_web.visible = false
	cb_back.visible = false
	cb_forward.visible = false
	cb_crawl.visible = true
	cbx_show.visible = true
//End Code Change ----08.10.2017	
	of_get_crawler()

end if

parent.triggerevent("resize")
end event

type cb_prac from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 27
integer y = 324
integer width = 82
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_pracs )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_pracs[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_pracs[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


//st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF

 

end event

type cb_batch from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 55
integer y = 320
integer width = 82
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;gs_batch_search lst_search

openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

lst_search = message.powerobjectparm
il_pracs[] = lst_search.li_prac_id[]
is_prac_names[] = lst_search.ls_name[]

//st_pracs.Text = String( UpperBound( il_pracs[] ) ) + " Providers selected."

IF UpperBound( il_pracs ) > 0 THEN
	dw_pracs.retrieve(il_pracs)
END IF



 

end event

type cb_forward from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 4192
integer y = 8
integer width = 325
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Forward >>"
end type

event clicked;//---------Begin Modified by alfee 08.11.2010 --------
//If ole_browser.bringtotop = True Then
	ole_browser.object.goforward()
//ElseIf ole_browser2.bringtotop = True Then
//	ole_browser2.object.goforward()
//End If
//tab_1.tabpage_view.ole_browser.object.goforward()
//---------End Modified ------------------------------

end event

type cb_back from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 3858
integer y = 8
integer width = 325
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<< Back"
end type

event clicked;try

//	If ole_browser.bringtotop = True Then
		ole_browser.object.goback()
//	ElseIf ole_browser2.bringtotop = True Then
//		ole_browser2.object.goback()
//	End If

	//---------End Modified ------------------------------	
catch (RuntimeError e) // Add by Evan on 10.19.2009
end try
end event

type dw_pracs from u_dw within w_batch_manual_verifications
integer x = 18
integer y = 428
integer width = 937
integer height = 2364
integer taborder = 10
string title = "Providers"
string dataobject = "d_verif_batch_prac_data"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable(false)

end event

event clicked;call super::clicked;long r
string s
r = this.getclickedrow()
if r < 1 then return



this.setrow(r)
this.selectrow( 0, false)
this.selectrow( r, true)
il_pracid = this.getitemnumber(r,"prac_id")
il_rec_id = this.getitemnumber(r,"rec_id")
//messagebox("Prac",il_pracid)

of_get_data()
//dw_log.insertrow(1)
//dw_log.setitem(1,"prac_id", il_pracid)
//dw_log.setitem(1,"verif_date", datetime(today(),now()))
////dw_log.setitem(1,"rec_id", il_pracid)
//dw_log.setitem(1,"_id", il_pracid)
//dw_log.setitem(1,"_id", il_pracid)



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

type dw_batch from u_dw within w_batch_manual_verifications
integer x = 37
integer y = 132
integer width = 4855
integer height = 276
integer taborder = 10
string dataobject = "d_verif_batch_detail"
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;string v

if dwo.name = "batch_type" then
	v = data
	of_batch_type(v)
end if

if dwo.name = "screen_id" then
	v = data
	of_screen_id(integer(data))
end if

if dwo.name = "dv_id" then
	v = data
	il_dvid = long(data)
end if

if dwo.name = "image_yn" then
	choose case data
		case "0"
			is_save_type = "N"
		case "1"
			is_save_type = "B"
		case "2"
			is_save_type = "H"
	end choose
end if

if dwo.name = "entity_id" then
	this.accepttext()
	of_get_crawler()
end if

if dwo.name = "facility_id" then
	this.accepttext()
	il_facility = long(data)
end if
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_link" then
	long l
	string s
	l = this.getitemnumber(1,"entity_id")
	select web_address into :s from address_lookup where lookup_code = :l;
	messagebox("On Clipboard", s)
	::clipboard(s)
end if
end event

event constructor;call super::constructor;datawindowchild dwchild

this.settransobject(sqlca)

this.getchild("facility_id", dwchild)

dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
end event

type dw_browse from u_dw within w_batch_manual_verifications
boolean visible = false
integer x = 3831
integer y = 352
integer width = 133
integer height = 76
integer taborder = 30
boolean bringtotop = true
boolean hscrollbar = true
end type

type dw_data from u_dw within w_batch_manual_verifications
integer x = 965
integer y = 428
integer width = 1797
integer height = 400
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_SetDropDownCalendar( TRUE )
end event

event pfc_preupdate;call super::pfc_preupdate;//messagebox("","preupdate")

inv_data_fun.of_field_audit( This )

return 1
end event

event doubleclicked;call super::doubleclicked;string ls_type
string ls_value
string ls_field
integer li_col

//li_col = this.getclickedcolumn()
ls_field = this.getcolumnname( )
//messagebox("",ls_field)
ls_type = This.Describe( ls_field + ".ColType") 
//messagebox("",ls_type)

if row < 1 then return //(Appeon)Stephen 09.18.2016 - V15.2 Testing Bug #5335: Primary key violation in Batch Verifications if you use the Capture button twice in a row
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

type cb_capture from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 2272
integer y = 8
integer width = 402
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Capture"
end type

event clicked;long bw
long bh
long orgh
long orgw

If dw_log.RowCount() = 0 Then Return//Added by Appeon long.zhang 12.14.2015 (BugL120803)
//parent.SetRedraw ( false )

//orgw = parent.Width
//orgh = parent.Height
//bw = ole_browser.width
//bh = ole_browser.height
//
//parent.width = bw + 10
//parent.height = bh + 10
//ole_browser.x = 5
//ole_browser.y = 5
//ole_browser.width = parent.width - 10
//ole_browser.height = parent.height - 10

if isnull(dw_log.getitemdatetime(1,"verif_date")) then
	dw_log.setitem(1,"verif_date", datetime(today(),Now()))
	dw_log.setitem(1,"user_id", gs_user_id)
end if

dw_log.setitem(1,"prac_id", il_pracid )
dw_log.setitem(1,"rec_id", il_rec_id )
dw_log.setitem(1,"screen_id",il_screen)
dw_log.setitem(1,"entity_id",il_entity)
dw_log.setitem(1,"batch_id",il_batch)//Added by Appeon long.zhang 12.14.2015 (BugL120804 )

dw_log.update()

if is_save_type = "H" then
	of_capture_html()
elseif  is_save_type = "B" then
	of_capture_bmp() 
end if

//parent.width = orgw
//parent.height = orgh
//ole_browser.x = dw_data.x

//parent.SetRedraw ( true )
end event

type dw_status from u_dw within w_batch_manual_verifications
boolean visible = false
integer x = 5088
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

type ole_browser from olecustomcontrol within w_batch_manual_verifications
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
integer x = 965
integer y = 836
integer width = 3927
integer height = 1956
integer taborder = 20
boolean bringtotop = true
boolean focusrectangle = false
string binarykey = "w_batch_manual_verifications.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button
of_SetErrorEvent(this.object) //(Appeon)Stephen 11.03.2017 - V16.1-Web Capture Redesign

end event

type cb_get from commandbutton within w_batch_manual_verifications
boolean visible = false
integer x = 41
integer y = 320
integer width = 914
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Get Connected Records"
end type

event clicked; //Start Code Change ----07.08.2015 #V15 maha
long ll_entity
long ll_table_id
string ls_table
string ls_field
string ls_filter

if dw_batch.rowcount() < 1 then return

ll_entity = dw_batch.getitemnumber(1,"entity_id")
ll_table_id = dw_batch.getitemnumber(1,"screen_id")
ls_filter = dw_batch.getitemstring(1,"addtl_filter")

//debugbreak()
//select table_name, sys_tables.table_id into :ls_table, :ll_table_id from sys_tables, data_view_screen where sys_tables.table_id =  data_view_screen.table_id and data_view_screen.screen_id = :ll_screen and data_view_screen.data_view_id = 1;
select table_name into :ls_table from sys_tables where table_id = :ll_table_id;

select field_name into :ls_field  from sys_fields where sys_fields.table_id = :ll_table_id and lookup_type = 'A';


of_get_prac_data(ls_table, ls_field, ll_entity, ls_filter)
end event

type st_stamp from statictext within w_batch_manual_verifications
integer x = 9
integer width = 4910
integer height = 128
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_batch_manual_verifications.bin 
2700000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000084682f7001d3634500000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f0000000084682f7001d3634584682f7001d36345000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Cffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000058c80000328a0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000058c80000328a0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_batch_manual_verifications.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
