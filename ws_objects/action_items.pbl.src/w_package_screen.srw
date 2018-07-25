$PBExportHeader$w_package_screen.srw
forward
global type w_package_screen from w_sheet
end type
type dw_defaults from datawindow within w_package_screen
end type
type dw_report from u_dw within w_package_screen
end type
type cb_ver_docs from commandbutton within w_package_screen
end type
type cb_checktest from commandbutton within w_package_screen
end type
type ole_scan_edit from olecustomcontrol within w_package_screen
end type
type cb_reset from commandbutton within w_package_screen
end type
type dw_select_template from u_dw within w_package_screen
end type
type cbx_1 from checkbox within w_package_screen
end type
type st_4 from statictext within w_package_screen
end type
type st_pracs from statictext within w_package_screen
end type
type cb_view from commandbutton within w_package_screen
end type
type cb_batch from commandbutton within w_package_screen
end type
type cb_prac from commandbutton within w_package_screen
end type
type sle_subject from singlelineedit within w_package_screen
end type
type st_3 from statictext within w_package_screen
end type
type st_2 from statictext within w_package_screen
end type
type sle_email from singlelineedit within w_package_screen
end type
type st_1 from statictext within w_package_screen
end type
type cb_close from commandbutton within w_package_screen
end type
type cb_ok from commandbutton within w_package_screen
end type
type dw_1 from u_dw within w_package_screen
end type
type mle_cover_text from multilineedit within w_package_screen
end type
type dw_template from u_dw within w_package_screen
end type
type gb_1 from groupbox within w_package_screen
end type
type gb_2 from groupbox within w_package_screen
end type
type gb_3 from groupbox within w_package_screen
end type
type dw_facility from datawindow within w_package_screen
end type
type ole_admin from olecustomcontrol within w_package_screen
end type
type ole_mail from u_email_edit within w_package_screen
end type
type dw_profile from u_dw within w_package_screen
end type
end forward

global type w_package_screen from w_sheet
integer width = 3346
integer height = 2624
string title = "Zip Package Settings"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
dw_defaults dw_defaults
dw_report dw_report
cb_ver_docs cb_ver_docs
cb_checktest cb_checktest
ole_scan_edit ole_scan_edit
cb_reset cb_reset
dw_select_template dw_select_template
cbx_1 cbx_1
st_4 st_4
st_pracs st_pracs
cb_view cb_view
cb_batch cb_batch
cb_prac cb_prac
sle_subject sle_subject
st_3 st_3
st_2 st_2
sle_email sle_email
st_1 st_1
cb_close cb_close
cb_ok cb_ok
dw_1 dw_1
mle_cover_text mle_cover_text
dw_template dw_template
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
dw_facility dw_facility
ole_admin ole_admin
ole_mail ole_mail
dw_profile dw_profile
end type
global w_package_screen w_package_screen

type variables
long il_prac_ids[]
long il_view_id
Long il_profile_view_id = 999
integer ii_facility_id = 0
integer ii_export_id
integer ii_file_count
integer ii_pack_lim
string is_prac_names[]
string is_curr_name   //maha 10.25.2017
string   is_facility_name
string is_app_name
boolean ib_email = true  //maha 10.24.2017
str_prac_id  istr_open_from
gs_batch_search ist_search
pfc_cst_nv_image_functions  inv_image_functions
pfc_cst_u_reports inv_reports
appeon_pdfservice inv_pdf
pfc_n_cst_ai_printletters inv_printletters
n_cst_filesrvwin32 inv_filesrv
n_cst_dirattrib inv_dirlist[]
datastore ids_image

Boolean ib_processing = False //Added by Appeon long.zhang 01.18.2017


end variables

forward prototypes
public function integer of_pre_open ()
public function integer of_get_appfile (long al_app_id, long al_prac_id)
public function integer of_pro_profile (long al_prac_id)
public function integer of_ver_profile (long al_prac_id)
public function integer of_chklist_report (long al_prac_id)
public function integer of_current_img (long al_prac_id, integer ai_img_type)
public subroutine of_getemailmessage (integer al_email_id, ref blob ablb_message)
public function integer of_set_emailtemp (long al_temp_id)
public function integer of_set_enabled (integer ai_num)
public function integer of_send_email (long al_prac_id, string as_full_name)
public function integer of_zip_package (long al_prac_id, string as_name)
public function string of_set_name (string as_name)
public function integer of_get_report (long al_prac, string as_type)
public function integer of_extract_verif_docs (long al_prac, string as_path)
end prototypes

public function integer of_pre_open ();//====================================================================
//$<Function>: of_pre_open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.10.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer r, li_app_chx, li_img_chx, li_pro_chx
integer li_ver_chx, li_chk, li_file, li_ver_img
integer li_ver_from_ver, li_npdb, li_oig, li_redflag, li_email_save 
integer li_facility_arr
long ll_app_id
string ls_full_name
string ls_describe
datawindowchild ldwc_email_temp
datawindowchild ldwc_facility
datawindowchild ldwc_app

dw_1.settransobject(sqlca)

dw_select_template.GetChild( "template_id", ldwc_email_temp )
//dw_facility.GetChild( "facility_id", ldwc_facility )
dw_1.GetChild( "facility_id", ldwc_facility ) //for UI adjustment - alfee 10.16.2013
dw_1.GetChild( "app_id", ldwc_app )
ldwc_email_temp.SetTransObject( SQLCA )
ldwc_facility.SetTransObject( SQLCA )
ldwc_app.SetTransObject( SQLCA )
dw_defaults.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue()
ldwc_email_temp.Retrieve()
ldwc_facility.Retrieve(gs_user_id)
ldwc_app.Retrieve()
//Start Code Change ----11.30.2017 #V16 maha
dw_defaults.retrieve()

//select inc_application, inc_images, inc_profile, inc_ver_profile, inc_check_report, inc_file_path, inc_verif_images, app_id, inc_limited
//   into :li_app_chx, :li_img_chx, :li_pro_chx, :li_ver_chx, :li_chk, :li_file, :li_ver_img, :ll_app_id, :ii_pack_lim
//  from sys_package_setting using sqlca;
gnv_appeondb.of_commitqueue()	

li_app_chx = dw_defaults.getitemnumber(1,"inc_application")
li_img_chx = dw_defaults.getitemnumber(1,"inc_images")
li_pro_chx = dw_defaults.getitemnumber(1,"inc_profile")
li_ver_chx = dw_defaults.getitemnumber(1,"inc_ver_profile")
li_chk = dw_defaults.getitemnumber(1,"inc_check_report")
li_file = dw_defaults.getitemnumber(1,"inc_file_path")
li_ver_img = dw_defaults.getitemnumber(1,"inc_verif_images")
ll_app_id = dw_defaults.getitemnumber(1,"app_id")
ii_pack_lim = dw_defaults.getitemnumber(1,"inc_limited")
debugbreak()
li_email_save =  dw_defaults.getitemnumber(1,"email_save")
li_ver_from_ver =  dw_defaults.getitemnumber(1,"inc_verif_image")
li_npdb =  dw_defaults.getitemnumber(1,"npdb_report")
li_oig =  dw_defaults.getitemnumber(1,"oig_report")
li_redflag =  dw_defaults.getitemnumber(1,"redflag_report")
//End Code Change ----11.30.2017

dw_1.insertrow(1)
if li_app_chx = 1 then 
	dw_1.setitem(1,"inc_application", 'Y')
	if not isnull(ll_app_id) then 
		dw_1.setitem(1,"app_id", ll_app_id)
		select application_name into :is_app_name from app_hdr where app_id = :ll_app_id;
	end if
else
	dw_1.modify("app_id.TabSequence='0'")
end if

if li_img_chx = 1 then dw_1.setitem(1,"inc_images", 'Y')
if li_pro_chx = 1 then dw_1.setitem(1,"inc_profile", 'Y')
if li_ver_chx = 1 then dw_1.setitem(1,"inc_ver_profile", 'Y')
if li_chk = 1 then dw_1.setitem(1,"inc_check_report", 'Y')
if li_file = 1 then 
	dw_1.setitem(1,"inc_addi_file", 'Y')
else
	dw_1.modify("inc_file_path.TabSequence='0'")
	dw_1.modify("b_1.enabled='No'")
end if
if li_ver_img = 1 then dw_1.setitem(1,"inc_verif_images", 'Y')
//Start Code Change ----11.30.2017 #V16 maha
if li_email_save = 0 then 
	dw_1.setitem(1,"email_save", 0)
	w_package_screen. height = gb_2.y + gb_2.height + 120
else
	dw_1.setitem(1,"email_save", 1)
end if
if li_ver_from_ver =  1 then dw_1.setitem(1,"inc_verif_image", 'Y')
if li_npdb = 1 then dw_1.setitem(1,"npdb_report", 'Y')
if li_oig =  1 then dw_1.setitem(1,"oig_report", 'Y')
if li_redflag = 1 then dw_1.setitem(1,"redflag_report", 'Y')


//End Code Change ----11.30.2017

//Start Code Change ----11.03.2014 #V14.2 maha
dw_1.setitem(1,"midcycle_status", 0)  
if gs_cust_type = "I" then
	dw_1.setitem(1,"show_status", 0) 
else
	dw_1.setitem(1,"show_status", 1) 
end if
//End Code Change ----11.03.2014



if lower(istr_open_from.types) = 'ver-app' then
	//dw_facility.enabled = false
//	dw_1.modify("facility_id.TabSequence='0'") //for UI adjustment - alfee 10.16.2013
	cb_prac.enabled = false
	cb_batch.enabled = false
	cb_reset.enabled = false
	st_pracs.enabled = false	
	
	//---------Begin Added by (Appeon)Stephen 10.17.2013 for BugL100804--------
	dw_1.modify("facility_id.dddw.name='d_dddw_zip_facility'")
	dw_1.modify("facility_id.dddw.datacolumn='parent_facility_id'")
	dw_1.modify("facility_id.dddw.displaycolumn='facility_name'")
	dw_1.GetChild( "facility_id", ldwc_facility ) 
	ldwc_facility.SetTransObject( SQLCA )
	
	dw_1.modify("app_id.dddw.name='d_dddw_zip_app'")
	dw_1.modify("app_id.dddw.datacolumn='app_id'")
	dw_1.modify("app_id.dddw.displaycolumn='application_name'")
	dw_1.GetChild( "app_id", ldwc_app ) 
	ldwc_app.SetTransObject( SQLCA )
	
	gnv_appeondb.of_startqueue()
	ldwc_app.retrieve( istr_open_from.prac_id, istr_open_from.facility_id)
	ldwc_facility.retrieve(istr_open_from.prac_id)
	select full_name into :ls_full_name from v_full_name where prac_id = :istr_open_from.prac_id;
	gnv_appeondb.of_commitqueue()
	//---------End Added ------------------------------------------------------	
	
	//dw_facility.setitem(1,"facility_id", istr_open_from.facility_id)
	dw_1.setitem(1,"facility_id", istr_open_from.facility_id) //for UI adjustment - alfee 10.16.2013	
	ii_facility_id = istr_open_from.facility_id
	st_pracs.Text = "1 Provider selected."
	il_prac_ids[1] = istr_open_from.prac_id
	is_prac_names[1] = ls_full_name
end if
return 1
end function

public function integer of_get_appfile (long al_app_id, long al_prac_id);//====================================================================
//$<Function>: of_get_app
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.11.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_page
long	  ll_FileNo,ll_Cycle,ll_DataLen,ll_Count,ll_Start
long     ll_rec_id
long     ll_Pos
long 	  READ_ONE_COUNT = 8000
string     ls_Null
string     ls_app_image_name, ls_file_name
string     ls_file_ext
Blob		lblb_Buffer

if isnull(al_app_id) or al_app_id = 0 then return 1
//---------Begin Modified by (Appeon)Stephen 10.17.2013  for test bug--------
//uo_app.of_connections( "IntelliCred", "0" )
//uo_app.ii_prac_id = al_prac_id
//uo_app.ii_app_id = al_app_id
//
//gs_app_image_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)
//if uo_app.of_load_app() = -1 then return -1
//if uo_app.of_setup( al_app_id, 0, 99, ii_facility_id) = -1 then return -1
//
//for li_page = 1 to uo_app.ole_edit.Object.PageCount()
//	uo_app.ole_edit.Object.Page(li_page)
//	uo_app.ole_edit.Object.Display()
//	uo_app.ole_edit.Object.BurnInAnnotations( 1, 2 )	
//	
//	uo_app.ole_edit.Object.save()
//next
		
//ls_app_image_name = uo_app.ole_edit.Object.Image()

SELECT top 1 net_dev_action_images.rec_id, datalength(net_dev_action_images.image_data)
    into  :ll_rec_id, :ll_DataLen
 FROM   net_dev_action_items , net_dev_action_images, code_lookup				  
WHERE  (net_dev_action_items.prac_id = :al_prac_id)  and  
             (net_dev_action_items.prac_id = net_dev_action_images.prac_id) and
		   (net_dev_action_items.app_id = :al_app_id) and
		   (net_dev_action_items.app_id = net_dev_action_images.app_id)  and  
		   (datalength(net_dev_action_images.image_data) > 0) and
		   (net_dev_action_items.facility_id = :ii_facility_id)  and
		   (net_dev_action_items.action_type = code_lookup.lookup_code) and
		   (code_lookup.lookup_name = 'Action Type' and code_lookup.code = 'App Out To MD')
	order by net_dev_action_images.rec_id desc
using   sqlca;

if isnull(ll_rec_id) or ll_rec_id =0 then return 1

//---------Begin Modified by (Appeon)Stephen 11.30.2015 for BugA113001--------
//ls_file_name =  gs_temp_path + "packagezip\app_"+ String(al_prac_id) + "_"  + String(al_app_id) + ".tif"
SELECT file_name
	 INTO :ls_file_ext
	FROM net_dev_action_images
  WHERE rec_id = :ll_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;

if not isnull(ls_file_ext) then
	ll_Pos = LastPos (ls_file_ext, "." )
	IF ll_Pos > 0 THEN 
		ls_file_ext = Mid (ls_file_ext, ll_Pos)  
		if pos(".doc, .docx, .jpg, .bmp, .pdf, .tif", lower(ls_file_ext)) < 1 then
			ls_file_ext = ".tif"
		end if
	else
		ls_file_ext = ".tif"
	end if
else
	ls_file_ext = ".tif"
end if
  
ls_file_name =  gs_temp_path + "packagezip\APP_" + is_curr_name + "_" + String(al_prac_id) + "_"  + is_app_name + ls_file_ext
//---------End Modified ------------------------------------------------------
	
ll_FileNo = FileOpen(ls_file_name,StreamMode!,Write!,LockReadWrite!,Replace!)
if ll_FileNo <= 0 then 
	messagebox("Application","Open file " + ls_file_name +" failed.") //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
	Return -1
End If

ll_Count = Ceiling(ll_DataLen/READ_ONE_COUNT)

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_COUNT then	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_COUNT + 1
		SELECTBLOB SubString(image_data,:ll_Start,:READ_ONE_COUNT)
		       INTO :lblb_Buffer
		      FROM net_dev_action_images
		     WHERE rec_id = :ll_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;
		
		FileWrite(ll_FileNo,lblb_Buffer)
	next
else	
	SELECTBLOB image_data
	      INTO :lblb_Buffer
	      FROM net_dev_action_images
 		  WHERE rec_id = :ll_rec_id AND prac_id = :al_prac_id AND app_id = :al_app_id ;
	
	for ll_Cycle = 1 To ll_Count
		FileWrite(ll_FileNo,BlobMid(lblb_Buffer,(ll_Cycle - 1) * READ_ONE_COUNT + 1,READ_ONE_COUNT))
	next
end if

FileClose(ll_FileNo)
//---------End Modfiied ------------------------------------------------------

return 1
end function

public function integer of_pro_profile (long al_prac_id);//====================================================================
//$<Function>: of_pro_profile
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.17.2013 (V141 File Packet creation)
//                  get Provider Profile
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string   ls_file_name
long     ll_len
integer li_Return

if isnull(gl_data_view_id) or gl_data_view_id = 0 then
	il_view_id = 1
else
	il_view_id = gl_data_view_id
end if

inv_reports.of_profile_report_v8( dw_profile, ii_facility_id, al_prac_id, il_profile_view_id, false,dw_profile,il_view_id, false)

dw_profile.Modify( "selected_facility_t.text = '" + is_facility_name + "'" )

ls_file_name =  gs_temp_path + "packagezip\" + is_curr_name +  "_data_profile.pdf"
li_Return = inv_pdf.of_Print(dw_profile, ls_file_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.18.2017
//<$>reason:Case #000068546 What is this error please
If li_Return <> 1 Then
	messagebox("Provider Profile","Print PDF failed.")
	return -1
End If
//------------------- APPEON END -------------------		

return li_Return
end function

public function integer of_ver_profile (long al_prac_id);//====================================================================
//$<Function>: of_ver_profile
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.18.2013 (V141 File Packet creation)
//                  get Verification Profile
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_set_chk 
integer li_facility_id[]
integer li_return
long ll_pracs[]
string ls_ir_filter 
string ls_appt_type 
string ls_user
string ls_file_name

ll_pracs[1] = al_prac_id

dw_profile.DataObject = "d_prf_ver_results"
dw_profile.of_SetTransObject( SQLCA )

li_facility_id[1]= ii_facility_id
dw_profile.Retrieve( li_facility_id , ll_pracs )

dw_profile.Modify( "selected_facility_t.text = '" + is_facility_name + "'" )
ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
dw_profile.Modify( ls_user )

li_set_chk = of_get_app_setting("set_55","I") 
if  li_set_chk = 1 then //CCVS filter
	select apptmnt_type into :ls_appt_type from pd_affil_stat where active_status in (1,4) and parent_facility_id = :ii_facility_id and prac_id = :al_prac_id;
	ls_ir_filter  = MidA (ls_ir_filter,8)
	ls_ir_filter  = MidA (ls_ir_filter,1,LenA(ls_ir_filter ) - 2) 
	if dw_profile.setfilter(ls_ir_filter) = 1 then
		dw_profile.filter()
	else
		messagebox("Prompt","ccvs filter failed")
		return -1
	end if
elseif  li_set_chk = 2 then
	ls_ir_filter = "code_lookup_code <> 'Exp Cred Ltr'"
	if dw_profile.setfilter(ls_ir_filter) = 1 then
		dw_profile.filter()
	else
		messagebox("Verification Profile","exp cred filter failed")
		return -1
	end if
end if

ls_file_name =  gs_temp_path +  "packagezip\" + is_curr_name +  "_verif_profile.pdf"
li_Return = inv_pdf.of_Print(dw_profile, ls_file_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.18.2017
//<$>reason:Case #000068546 What is this error please
If li_Return <> 1 Then
	messagebox("Verification Profile","Print PDF failed.")
	return -1
End If
//------------------- APPEON END -------------------

return 1
end function

public function integer of_chklist_report (long al_prac_id);//====================================================================
//$<Function>: of_chklist_report
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.18.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_rec_id
integer li_Return
integer cnt
string ls_user, ls_file_name

datawindowchild dwchild

//Start Code Change ----11.03.2014 #V14.2 maha
if dw_1.getitemnumber(1,"midcycle_status") = 6 then
	select count(rec_id) into :cnt from pd_affil_stat where  (prac_id = :al_prac_id ) AND (parent_facility_id = :ii_facility_id) and	(active_status = 6) using sqlca;
	if cnt = 0 then //skip if no midcycle
		return 1
	elseif cnt > 1 then  //multiple midcycle
		openwithparm(w_get_midcycle_affil_stat,string(al_prac_id) + "*" + string(ii_facility_id))
		if message.stringparm = "Cancel" then
			return 1
		else
			ll_rec_id = message.doubleparm
		end if
	else //single midcycle
		select top 1 pd_affil_stat.rec_id 
		 into  :ll_rec_id 
		 FROM pd_affil_stat  
		WHERE (prac_id = :al_prac_id ) AND  
				(parent_facility_id = :ii_facility_id) and
			(active_status = 6) using sqlca;
	end if
else
	select top 1 pd_affil_stat.rec_id 
    into  :ll_rec_id 
    FROM pd_affil_stat  
   WHERE (prac_id = :al_prac_id ) AND  
         (parent_facility_id = :ii_facility_id) and
		(active_status in (1,3,4)) using sqlca;
end if
//End Code Change ----11.03.2014

if isnull(ll_rec_id) then return 1
dw_profile.DataObject = "d_pd_app_audit_rqrd_data_print"
dw_profile.of_SetTransObject( SQLCA )

dw_profile.Retrieve(ll_rec_id)
if dw_profile.rowcount() < 1 then return 1

dw_profile.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)

ls_user = "t_printed_by.text = 'Printed by: " + gs_user_id + "'"
dw_profile.modify(ls_user)

ls_file_name =  gs_temp_path + "packagezip\" + is_curr_name +  "_checklist_report.pdf"
li_Return = inv_pdf.of_Print(dw_profile, ls_file_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.18.2017
//<$>reason:Case #000068546 What is this error please
If li_Return <> 1 Then
	messagebox("Checklist Report","Print PDF failed.")
	return -1
End If
//------------------- APPEON END -------------------

return li_Return
end function

public function integer of_current_img (long al_prac_id, integer ai_img_type);//====================================================================
//$<Function>: of_current_img
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.16.2013 (V141 File Packet creation)
//                  get Current image 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_rec_id
Long ll_seq_no
Integer li_facility_id
Integer li_screen_id
integer li_status
Integer li_cr
integer li_pagecount
integer li_type
integer li_first
string   ls_file, ls_img
string ls_type  //maha 10.25.2017
string ls_reference //maha 10.25.2017
string ls_name  //maha 11.20.2017

ids_image.retrieve(al_prac_id, gs_user_id)
//---------Begin Added by (Appeon)Stephen 10.17.2013 for BugA101702--------
if of_get_app_setting("set_69","I") = 1 then
	ids_image.setfilter("view_rights = 1")
	ids_image.filter()
end if
//---------End Added ------------------------------------------------------

li_first = 0
for li_cr  = 1 to ids_image.rowcount()
	ll_rec_id       =ids_image.GetItemNumber( li_cr, "pd_images_rec_id" )
	li_facility_id  = ids_image.GetItemNumber( li_cr, "pd_images_facility_id" )	
	li_screen_id = ids_image.GetItemNumber( li_cr, "pd_images_screen_id" )		
	ll_seq_no     = ids_image.GetItemNumber( li_cr, "image_pk" )
	li_status      = ids_image.GetItemNumber( li_cr, "active_status" ) 
	li_type        = ids_image.GetItemNumber( li_cr, "image_type_id" )  
	//Start Code Change ----10.25.2017 #V154 maha
	ls_type = ids_image.GetItemString( li_cr, "image_type_description" )
	ls_reference = ids_image.GetItemString( li_cr, "reference_name" )
	IF  Match(ls_reference,'[\/:*?"<>|]') THEN //Added by (APPEON) Harry 12.21.2017 (Bug_id 5917)
		IF Pos(ls_reference, "\") > 0 THEN ls_reference = of_strip_char("\", ls_reference, "-")
		IF Pos(ls_reference, "/") > 0 THEN ls_reference = of_strip_char(ls_reference, "/", "-") //Start Code Change ----11.29.2017 #V154 maha
		IF Pos(ls_reference, ":") > 0 THEN ls_reference = of_strip_char(":", ls_reference, "-")
		IF Pos(ls_reference, "*") > 0 THEN ls_reference = of_strip_char("*", ls_reference, "-")
		IF Pos(ls_reference, "?") > 0 THEN ls_reference = of_strip_char("?", ls_reference, "-")
		IF Pos(ls_reference, '"') > 0 THEN ls_reference = of_strip_char('"', ls_reference, "-")
		IF Pos(ls_reference, "<") > 0 THEN ls_reference = of_strip_char("<", ls_reference, "-")
		IF Pos(ls_reference, ">") > 0 THEN ls_reference = of_strip_char(">", ls_reference, "-")
		IF Pos(ls_reference, "|") > 0 THEN ls_reference = of_strip_char("|", ls_reference, "-")
	END IF
	
	
	ls_reference = is_curr_name + "-" + ls_type + "-" + ls_reference
	//End Code Change ----10.25.2017 
debugbreak()	
	//Start Code Change ----11.21.2017 #V154 maha
	if ai_img_type = 99 and  li_type <> 99 then continue
	if ai_img_type = 0 and  li_type = 99 then continue
	if li_status < 1 then continue
	if li_facility_id > 0 and li_facility_id <> ii_facility_id then continue
//messagebox("","image")
	IF inv_image_functions.of_retrieve_image_from_db( ll_rec_id, al_prac_id, li_facility_id, li_screen_id, ll_seq_no, false ) = -1 THEN
		MessageBox("Image File", "Retrieve image from database failed." )//Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
		RETURN -1
	END IF
		
	yield()
		
	//@@@@@@@@@@@@@@@@@@
	ls_file = gs_temp_path + "images\" + String(al_prac_id) + "_" + String(ll_seq_no) + ".tif"  //this is the file retrieved from db
	ls_name = ls_reference  + ".tif"  //the copied file

	IF NOT FileExists( ls_file ) THEN
		MessageBox("Image File", "The image file " + ls_file + " does not exist,  Check to make sure the path exists or if the database record has an image stored in the image field." )
		RETURN -1
	end if
		
	if li_type = 99 then
		ls_img ='VER_' + mid(ls_name, lastpos(ls_name, '\') + 1)
	else
		ls_img ='DOC_' + mid(ls_name, lastpos(ls_name, '\') + 1)
	end if
		
	ls_img = gs_temp_path + "packagezip\" + ls_img
//		messagebox("", ls_img)
	filecopy(ls_file, ls_img)
		
//		li_first +=1
//		if li_first = 1 then		
//			filecopy(ls_file, gs_temp_path + "packagezip\" +ls_img)
//			ole_admin.object.Image( gs_temp_path + "packagezip\" +ls_img)
//		else
//			ole_scan_edit.Object.ClearDisplay()
//			ole_scan_edit.Object.Image( ls_file )
//			
//			li_pagecount = ole_scan_edit.Object.Pagecount()
//			ole_admin.object.Append( ls_file, 1 , li_pagecount  )		
//		end if
		//End Code Change ----11.20.2017
		//@@@@@@@@@@@@@@@@@

	//end if
next

return 1
end function

public subroutine of_getemailmessage (integer al_email_id, ref blob ablb_message);//====================================================================
//$<Function>: of_getemailmessage
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.22.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email
		     WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	next
else
	SELECTBLOB Email_Message
	      INTO :ablb_Message
	      FROM wf_email
	     WHERE wf_email.email_id = :al_EMail_Id;
end if

end subroutine

public function integer of_set_emailtemp (long al_temp_id);//====================================================================
//$<Function>: of_set_emailtemp
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.25.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Blob lblb_Message
string ls_EmailType
 
dw_template.Retrieve( al_temp_id )	
if dw_template.rowcount() < 1 then return -1
IF gi_email_type = 1 THEN  //outlook
	mle_cover_text.Text = dw_template.GetItemString( 1, "email_msg" )
ELSE  //easymail
	of_GetEMailMessage(al_temp_id, lblb_Message)
	ole_mail.setredraw( false)
	ole_mail.of_Open(lblb_Message)
	ole_mail.setredraw( true)
END IF
sle_subject.Text = dw_template.GetItemString( 1, "subject" )

select export_id into :ii_export_id                    
	  from wf_email where email_id = :al_temp_id using sqlca;
	  
return 1

end function

public function integer of_set_enabled (integer ai_num);//====================================================================
//$<Function>: of_set_enabled
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.09.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if ai_num > 1 then
	dw_1.setitem(1, "inc_addi_file", 'N')
	dw_1.setitem(1, "inc_file_path", '')
	dw_1.modify("inc_addi_file.TabSequence='0'")
	dw_1.modify("inc_file_path.TabSequence='0'")
	dw_1.modify("b_1.enabled='No'")
else
	dw_1.modify("inc_addi_file.TabSequence='100'")
	dw_1.modify("inc_file_path.TabSequence='110'")
	dw_1.modify("b_1.enabled='Yes'")
end if
st_pracs.Text = String( ai_num ) + " Providers selected."

return 1
end function

public function integer of_send_email (long al_prac_id, string as_full_name);//====================================================================
//$<Function>: of_send_email
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.25.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_attach, ls_notetext, ls_emailcc
string ls_email_address, ls_subject
long   ll_Return, ll_export_id
integer li_ret
blob   lb_mess

//ls_attach = gs_temp_path + "packagezip\" + "package_" + string(al_prac_id) +".zip" //Start Code Change ----11.30.2017 #V16 maha
ls_attach = gs_temp_path + "packagezip\"+ "package_" + is_curr_name + "-" + string(al_prac_id) +".zip"

if not FileExists(ls_attach) then
	MessageBox("Prompt", "Email Zip package process failed; unable to find file " + ls_attach + " please retry." )
	return -1
end if

//---------Begin Added by (Appeon)Stephen 10.21.2013 for add packet limit--------
decimal ldc_filelen

ldc_filelen = filelength(ls_attach)
ldc_filelen = Round((ldc_filelen/1024)/1024, 2)
if ii_pack_lim > 0 and not isnull(ii_pack_lim) then
	if ldc_filelen > ii_pack_lim then
		li_ret = messagebox("Prompt", "The package file size ("+string(ldc_filelen)+" MB) has exceeded the preset limit ("+string(ii_pack_lim) +" MB). "&
		+"Would you like to continue the Email for the provider ("+as_full_name+")?",Question!, YesNoCancel!, 2 ) 
		if li_ret = 2 then
			return 1
		elseif li_ret = 3 then
			return -1
		end if
	end if
end if
//---------End Added ------------------------------------------------------

ls_notetext = mle_cover_text.Text
ls_subject = sle_subject.Text
ls_email_address = sle_email.text

if cbx_1.checked then
	select pd_address.e_mail_address
	   into :ls_emailcc
	  from pd_address, pd_address_link
	  where
	    (pd_address_link.address_id = pd_address.rec_id ) and  
         ( pd_address_link.prac_id = :al_prac_id ) and  
         ( pd_address_link.facility_id = :ii_facility_id ) and          
         ( pd_address_link.mailing = 1 )  using sqlca; 
	if isnull(ls_emailcc) then ls_emailcc = ''
else
	ls_emailcc = ""
end if

IF gi_email_type = 1 THEN  //outlook
	n_cst_outlook lnv_Outlook
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return -1
	end if
	
	datastore lds_export
	pfc_n_cst_ai_export_apb lnv_export
	n_cst_word_utility lnv_word_outlook
	
	lnv_word_outlook = Create n_cst_word_utility
	lds_export = create datastore
	lnv_export = create pfc_n_cst_ai_export_apb
	
	if Not IsNull(ii_export_id) then 
		if lnv_export.of_get_export_data(ii_export_id, al_prac_id, lds_export) = 1 then	
			if lds_export.rowcount() > 0 then
				lnv_word_outlook.of_replace_export_text(ls_notetext, al_prac_id, lds_export)
				lnv_word_outlook.of_replace_export_text(ls_subject, al_prac_id, lds_export)  //(Appeon)Harry 03.16.2015 - for Requesting new V14.2 Web Package - Bug # 4439 - Merge fields in subject are not populating
			end if
		end if
	end if
	destroy lnv_word_outlook
	destroy lds_export
	destroy lnv_export
	
	ll_Return = lnv_Outlook.of_Send(ls_email_address, ls_emailcc, "", ls_subject, ls_notetext, ls_attach)
	
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if		
else
	n_cst_easymail_smtp lnv_mail
	if lnv_mail.of_CreateObject() = -1 then
		f_show_message('create Email object','','','','')
		Return -1
	end if	
	ole_mail.of_GetBlob(lb_mess)
	
	Open(w_email_edit)
	w_email_edit.ole_word.of_Open(lb_mess)
	
	//merge mail
	n_cst_word_utility lnv_word
	lnv_word = Create n_cst_word_utility
	IF NOT IsNull(ii_export_id) THEN 
		//lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, al_prac_id, ii_export_id)  //Commented by (Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, ls_subject, al_prac_id, ii_export_id) //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
	END IF
	Destroy lnv_word

	ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, ls_email_address, ls_emailcc,'', ls_Subject, w_email_edit.ole_word, ls_Attach,True)
	w_email_edit.ole_word.of_close()
	if isvalid(w_email_edit) then close(w_email_edit)
	lnv_mail.of_DeleteObject()
	
	if ll_Return <> 0 then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
		Return -1
	end if
				 
end if

dw_1.setitem(1, "email_sent_to", ls_email_address +";" + ls_emailcc)
return 1
end function

public function integer of_zip_package (long al_prac_id, string as_name);//====================================================================
//$<Function>: of_zip_package
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.24.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//maha - 10.24.2017 - Added as_name argument
//====================================================================
string   ls_path, ls_zip_file
string ls_zip_path  //maha 10.24.2017
string   ls_file_name
integer li_entries
long     ll_i
char    lc_chx 
n_cst_filesrvwin32 lnv_filesrv
n_cst_dirattrib lnv_dirlist[]

ls_path = gs_temp_path + "packagezip\"

//Start Code Change----10.24.2017 #V154 maha
if ib_email then
	ls_zip_path = ls_path
else //separate path if save only
	ls_zip_path = ls_path + "saved\"
end if

if not DirectoryExists(ls_zip_path) then CreateDirectory(ls_zip_path)
//End Code Change----10.24.2017

if not DirectoryExists(ls_path) then CreateDirectory(ls_path)

If NOT isvalid(lnv_filesrv) Then
	lnv_filesrv =  create n_cst_filesrvwin32
End If
li_entries = lnv_filesrv.of_DirList(ls_path+"*.*", 0, lnv_dirlist)

//Start Code Change ----10.24.2017 #V154 maha - add name to file
//ls_zip_file = ls_path +"package_" + string(al_prac_id) +".zip"
ls_zip_file = ls_zip_path + "package_" + is_curr_name + "-" + string(al_prac_id) +".zip"
//End Code Change ----10.24.2017 

ls_path = '"' + ls_path + '"' 

if not fileexists(gs_dllocx_path+"7z.dll") then
	messagebox("Prompt", "The file " + gs_dllocx_path + "7z.dll does not exist!"+&
	                   "~r~nPlease check if you have rights to the folder of " + gs_dllocx_path)
	return -1
end if
ChangeDirectory(gs_dllocx_path) 
run("7z a " + ls_zip_file + " " + ls_path + "*.*" , Minimized!)	
ii_file_count =  upperbound(lnv_dirlist)

do while 1=1
	if FileExists(ls_zip_file) then exit
loop
sleep(1000)

//Additional File
lc_chx = dw_1.getitemstring(1, "inc_addi_file")
if lc_chx = 'Y' and upperbound(il_prac_ids)  = 1 then
	ls_path = dw_1.getitemstring(1, "inc_file_path")	
	ls_path = Trim(ls_path) //alfee 10.23.2013
	if Right(ls_path, 1) = "\" then ls_path = Mid(ls_path,1, Len(ls_path) - 1) //alfee 10.23.2013
	if not (isnull(ls_path) or ls_path = "") then
		li_entries = lnv_filesrv.of_DirList(ls_path+"\*.*", 0, lnv_dirlist)		
		ls_path = ls_path+ "\"
		ls_path = '"'+ls_path+'"' 
		ii_file_count =  ii_file_count + upperbound(lnv_dirlist)
		
		run("7z a " + ls_zip_file + " " +  ls_path , Minimized!)	
	end if
end if

do while 1=1
	if FileExists(ls_zip_file) then exit
loop
sleep(500)
yield()
If isvalid(lnv_filesrv) Then Destroy lnv_filesrv
ChangeDirectory(gs_current_path)

return 1
end function

public function string of_set_name (string as_name);//Start Code Change ----10.25.2017 #V154 maha - added
string ls_name

ls_name = as_name

ls_name = of_strip_char("'", ls_name, "")
ls_name = of_strip_char(" ", ls_name, "-")
ls_name = of_strip_char(".", ls_name, "-")
ls_name = of_strip_char(",", ls_name, "")

return ls_name
end function

public function integer of_get_report (long al_prac, string as_type);//Start Code Change ----11.28.2017 #V16 maha
string   ls_file_name
string ls_dwo
string ls_rpt
long     ll_len
integer li_Return
integer rc

choose case as_type
	case "R" //red flag
		ls_dwo = "d_rpt_red_flag_4_prac"
		ls_rpt = "Red Flag.pdf"
	Case "O"  //OIG
		ls_dwo = "d_oig_scan_log_prac"
		ls_rpt = "OIG Report.pdf"
end choose

dw_report.dataobject = ls_dwo
dw_report.settransobject(sqlca)
rc = dw_report.retrieve(al_prac)

if rc = 0 then return 1

//debugbreak()
ls_file_name =  gs_temp_path +  "packagezip\" + is_curr_name + "_" + ls_rpt
li_Return = inv_pdf.of_Print(dw_report, ls_file_name)

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.18.2017
//<$>reason:Case #000068546 What is this error please
If li_Return <> 1 Then
	messagebox("Provider Profile","Print PDF failed.")
	return -1
End If
//------------------- APPEON END -------------------		

return li_Return
end function

public function integer of_extract_verif_docs (long al_prac, string as_path);//Start Code Change ----12.11.2017 #V16 maha - from w_extract_prac_ver_docs
Long ll_rec_id
Long ll_prac_id
Integer li_facility_id
long ll_facils[]
Integer li_screen_id
integer li_type
integer p
integer li_file_count 
integer res 
string ls_docid
String ls_image_path
string ls_file
string ls_ref
string ls_name
string ls_type
string ls_screen
Integer li_rc
Integer i
Integer li_count
gs_pass_ids lst_ids
n_ds lds_browse
DataWindowChild dwchild

n_cst_string lnv_string
String ls_Recipient[]

ll_prac_id = al_prac

ll_facils[1] =  ii_facility_id
//ls_image_path = gnv_data.of_getitem("ids" , "imaging_path" , False)
ls_image_path = as_path
if right(ls_image_path, 1) <> "\" then
	ls_image_path+= "\"
end if
//gs_app_image_path = gnv_data.of_getitem("ids" , "intelliapp_app_path" , False)

lds_browse = create n_ds
lds_browse.dataobject = "d_verif_download_file_select"
lds_browse.settransobject(sqlca)
li_rc = lds_browse.retrieve( 1, ll_prac_id, ll_facils[] )


IF li_rc = 0 THEN
	Return -1
END IF

FOR i = 1 TO li_rc
	ls_file = ""

	ls_ref = lds_browse.GetItemString( i, "reference_value" )
	ls_ref = of_strip_char(  "/", ls_ref, "-") //Start Code Change ----11.29.2017 #V154 maha
	ls_screen = lds_browse.GetItemstring( i, "screen" )		
	ls_docid = lds_browse.GetItemstring( i, "doc_id" ) 
	li_type = lds_browse.GetItemnumber( i, "verification_picture_flag" )
	
	choose case li_type
		case 1
			ls_type = ".html"
		case 2
			ls_type = ".pdf"
		case 3
			ls_type = ".htm"
		case 4
			ls_type = ".bmp"
		case 5
			ls_type = ".png"
		case 6
			ls_type = ".xml"
		case 7
			ls_type = ".jpg"
	end choose
	
	p = pos(ls_screen, " ", 1)
	if p > 0 then ls_screen = left(ls_screen, p - 1)
			
	ls_name = of_prac_name_for_file(ll_prac_id)

	ls_file = ls_name + "_" + ls_screen  + "_" + ls_ref  //name less file type
	ls_file = ls_image_path + ls_file //add path
	ls_file = of_strip_char( "/",ls_file, "-") //Start Code Change ----11.29.2017 #V154 maha
	
	if len(ls_file) > 200 then leftA(ls_file, 200)  //check length
	ls_file+= ls_type

	IF  inv_image_functions.of_get_verif_doc(ls_docid, "Verif", 0 , ls_file)  = -1 THEN
		continue
	else
		li_count++
	END IF

	//MessageBox("Files", ls_file )
END FOR	

destroy lds_browse

return 1

end function

on w_package_screen.create
int iCurrent
call super::create
this.dw_defaults=create dw_defaults
this.dw_report=create dw_report
this.cb_ver_docs=create cb_ver_docs
this.cb_checktest=create cb_checktest
this.ole_scan_edit=create ole_scan_edit
this.cb_reset=create cb_reset
this.dw_select_template=create dw_select_template
this.cbx_1=create cbx_1
this.st_4=create st_4
this.st_pracs=create st_pracs
this.cb_view=create cb_view
this.cb_batch=create cb_batch
this.cb_prac=create cb_prac
this.sle_subject=create sle_subject
this.st_3=create st_3
this.st_2=create st_2
this.sle_email=create sle_email
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.mle_cover_text=create mle_cover_text
this.dw_template=create dw_template
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_facility=create dw_facility
this.ole_admin=create ole_admin
this.ole_mail=create ole_mail
this.dw_profile=create dw_profile
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_defaults
this.Control[iCurrent+2]=this.dw_report
this.Control[iCurrent+3]=this.cb_ver_docs
this.Control[iCurrent+4]=this.cb_checktest
this.Control[iCurrent+5]=this.ole_scan_edit
this.Control[iCurrent+6]=this.cb_reset
this.Control[iCurrent+7]=this.dw_select_template
this.Control[iCurrent+8]=this.cbx_1
this.Control[iCurrent+9]=this.st_4
this.Control[iCurrent+10]=this.st_pracs
this.Control[iCurrent+11]=this.cb_view
this.Control[iCurrent+12]=this.cb_batch
this.Control[iCurrent+13]=this.cb_prac
this.Control[iCurrent+14]=this.sle_subject
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.sle_email
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.cb_close
this.Control[iCurrent+20]=this.cb_ok
this.Control[iCurrent+21]=this.dw_1
this.Control[iCurrent+22]=this.mle_cover_text
this.Control[iCurrent+23]=this.dw_template
this.Control[iCurrent+24]=this.gb_1
this.Control[iCurrent+25]=this.gb_2
this.Control[iCurrent+26]=this.gb_3
this.Control[iCurrent+27]=this.dw_facility
this.Control[iCurrent+28]=this.ole_admin
this.Control[iCurrent+29]=this.ole_mail
this.Control[iCurrent+30]=this.dw_profile
end on

on w_package_screen.destroy
call super::destroy
destroy(this.dw_defaults)
destroy(this.dw_report)
destroy(this.cb_ver_docs)
destroy(this.cb_checktest)
destroy(this.ole_scan_edit)
destroy(this.cb_reset)
destroy(this.dw_select_template)
destroy(this.cbx_1)
destroy(this.st_4)
destroy(this.st_pracs)
destroy(this.cb_view)
destroy(this.cb_batch)
destroy(this.cb_prac)
destroy(this.sle_subject)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_email)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.mle_cover_text)
destroy(this.dw_template)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_facility)
destroy(this.ole_admin)
destroy(this.ole_mail)
destroy(this.dw_profile)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.10.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_temp_id

istr_open_from = message.powerobjectparm
if of_pre_open() <> 1 then close(this)

if  gi_email_type = 1 then 
	ole_mail.Hide()
	mle_cover_text.Show()
ELSE
	ole_mail.Show()
	mle_cover_text.Hide()
	ole_mail.of_Open()
	ole_mail.SetFocus()
END IF

end event

event closequery;call super::closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
//$<Return>:  long
//$<Description>: Prevent it from close when processing.
//$<Author>: (Appeon) long.zhang 01.18.2017 (Case #000068546 What is this error please)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

If ib_processing Then
	If Messagebox('Zip Package Settings', "Curent window is still processing.~r~n" +&
		"Close without waiting it?", exclamation!, YesNo!, 2) = 1 Then
		Return ALLOW_CLOSE
	Else
		Return PREVENT_CLOSE
	End If
End If
end event

type dw_defaults from datawindow within w_package_screen
integer x = 3369
integer y = 44
integer width = 686
integer height = 400
integer taborder = 130
string title = "none"
string dataobject = "d_sys_package_default"
boolean livescroll = true
end type

type dw_report from u_dw within w_package_screen
integer x = 3493
integer y = 164
integer width = 1381
integer height = 1968
integer taborder = 150
end type

type cb_ver_docs from commandbutton within w_package_screen
boolean visible = false
integer x = 3666
integer y = 40
integer width = 745
integer height = 80
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Images from Verifications"
end type

event clicked;gs_pass_ids lst_ids
string ls_path

If ii_facility_id = 0 then
	messagebox("Verif Documents","Please select the Facility for the provider")
	return
end if

ls_path = gs_temp_path + "packagezip\verif_docs"
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)
ls_path = ls_path + "\"

gnv_app.gnvlo_msword.of_delete_file(ls_path )

dw_1.setitem(1, "inc_addi_file", "Y")
dw_1.setitem(1, "inc_file_path", ls_path)

lst_ids.s_stringval = ls_path
lst_ids.prac_id = il_prac_ids[1]
lst_ids.facility_id = ii_facility_id


openwithparm(w_extract_prac_verif_docs, lst_ids)
end event

type cb_checktest from commandbutton within w_package_screen
boolean visible = false
integer x = 3520
integer y = 620
integer width = 96
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "check test"
end type

event clicked;debugbreak()
ii_facility_id =  dw_1.getitemnumber(1, "facility_id") 
of_chklist_report(il_prac_ids[1])
end event

type ole_scan_edit from olecustomcontrol within w_package_screen
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
boolean visible = false
integer x = 2729
integer y = 2592
integer width = 393
integer height = 168
integer taborder = 130
boolean border = false
long backcolor = 67108864
boolean focusrectangle = false
string binarykey = "w_package_screen.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

event markselect(integer button, integer shift, long left, long top, long ocx_width, long ocx_height, integer marktype, string groupname);////Start Code Change ---- 05.17.2006 #457 maha was not carried over from v4.5
//is_annotation_name = groupname
////End Code Change---05.17.2006
end event

type cb_reset from commandbutton within w_package_screen
integer x = 2651
integer y = 832
integer width = 535
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Remove All Providers"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.30.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_null[]

il_prac_ids = ll_null
of_set_enabled(UpperBound( il_prac_ids[] )) //(Appeon)Stephen 08.09.2013 - V141  File Packet creation
end event

type dw_select_template from u_dw within w_package_screen
integer x = 626
integer y = 996
integer width = 942
integer height = 80
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_select_email_temp_pack"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.10.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

This.of_SetUpdateable( False )
this.settransobject(sqlca)
this.insertrow(0)
end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.22.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_set_emailtemp(long(data))

end event

type cbx_1 from checkbox within w_package_screen
integer x = 2670
integer y = 1096
integer width = 562
integer height = 52
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email to Practitioner"
end type

type st_4 from statictext within w_package_screen
boolean visible = false
integer x = 494
integer y = 1324
integer width = 361
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Select Facility:"
boolean focusrectangle = false
end type

type st_pracs from statictext within w_package_screen
integer x = 160
integer y = 836
integer width = 608
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "No provider selected"
boolean focusrectangle = false
end type

type cb_view from commandbutton within w_package_screen
integer x = 2117
integer y = 832
integer width = 489
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Selected"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.11.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
gs_batch_search ls_b

IF UpperBound( il_prac_ids ) > 0 THEN
	ls_b.li_prac_id[] = il_prac_ids[]
	ls_b.ls_name[] = is_prac_names[]
	ls_b.ls_title = "T^Selected Practitioners"
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type cb_batch from commandbutton within w_package_screen
integer x = 1582
integer y = 832
integer width = 489
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;integer ic, rc, i
long ll_null[]
datastore lds_current_prac

openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return


ist_search = message.powerobjectparm

//---------Begin Modified by (Appeon)Stephen 10.19.2013 for BugL100804--------
/*
il_prac_ids[] = ist_search.li_prac_id[]
is_prac_names[] = ist_search.ls_name[]
*/
ii_facility_id =  dw_1.getitemnumber(1, "facility_id") //for UI adjustment - alfee 10.16.2013
if isnull(ii_facility_id) then
	messagebox("Required Data Missing", "You must first select a Facility !")
	return
end if
lds_current_prac = create datastore
lds_current_prac.dataobject = 'd_zip_current_prac'
lds_current_prac.settransobject(sqlca)
lds_current_prac.retrieve(ist_search.li_prac_id[], ii_facility_id)
ic = lds_current_prac.rowcount()
rc = 0
il_prac_ids = ll_null

for i = 1 to ic
	rc++
	il_prac_ids[rc] =  lds_current_prac.getitemnumber(i, "prac_id") 
	is_prac_names[rc] = lds_current_prac.getitemstring(i, "full_name") 
next
//---------End Modified ------------------------------------------------------

destroy lds_current_prac
of_set_enabled(UpperBound( il_prac_ids[] )) //(Appeon)Stephen 08.09.2013 - V141  File Packet creation



 

end event

type cb_prac from commandbutton within w_package_screen
integer x = 1010
integer y = 832
integer width = 526
integer height = 84
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

//---------Begin Added by (Appeon)Stephen 10.16.2013 for BugL100804--------
ii_facility_id =  dw_1.getitemnumber(1, "facility_id") 
if isnull(ii_facility_id) then
	messagebox("Required Data Missing", "Please select a Facility first!")
	return
end if
//---------End Added ------------------------------------------------------

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_prac_ids )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
//ic = upperbound(lst_batch.li_prac_id[])
//maha app101305

//---------Begin Added by (Appeon)Stephen 10.16.2013 for BugL100804--------
ic = upperbound(lst_batch.li_prac_id[])
//---------End Added ------------------------------------------------------

for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i]
	if lst_batch.ll_facility[i] <> ii_facility_id then continue
	li_find = 0  //(Appeon)Stephen 08.09.2013 - V141  File Packet creation
	for r = 1 to rc
		if il_prac_ids[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_prac_ids[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next

of_set_enabled(UpperBound( il_prac_ids[] )) //(Appeon)Stephen 08.09.2013 - V141  File Packet creation




 

end event

type sle_subject from singlelineedit within w_package_screen
integer x = 626
integer y = 1176
integer width = 2542
integer height = 72
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_package_screen
integer x = 160
integer y = 1184
integer width = 421
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Subject:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_package_screen
integer x = 160
integer y = 1096
integer width = 421
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email To:"
boolean focusrectangle = false
end type

type sle_email from singlelineedit within w_package_screen
integer x = 626
integer y = 1088
integer width = 2011
integer height = 72
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
integer limit = 100
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_package_screen
integer x = 160
integer y = 1004
integer width = 421
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Template:"
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_package_screen
integer x = 1696
integer y = 28
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type cb_ok from commandbutton within w_package_screen
integer x = 1344
integer y = 28
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Continue"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.11.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
char     lc_chx
string   ls_notetext, ls_subject, ls_email_address
string   ls_path
long     ll_app_id
integer li_i, li_return
datetime ldt_CurrentTime
boolean lb_db
Boolean lb_failed = False //Added by Appeon long.zhang 01.18.2017

dw_1.AcceptText () //alfee 10.23.2013

if  dw_1.getitemnumber(1, "email_save") = 0 then ib_email = false  //Start Code Change ----10.24.2017 #V154 maha

//ii_facility_id =  dw_facility.getitemnumber(1, "facility_id")
ii_facility_id =  dw_1.getitemnumber(1, "facility_id") //for UI adjustment - alfee 10.16.2013
if isnull(ii_facility_id) then
	messagebox("Required Data Missing", "You must first select a Facility !")
	return
end if
if upperbound(il_prac_ids) < 1 then
	messagebox("Required Data Missing", "You must first select Provider !")
	return
end if

if ib_email then   //Start Code Change ----10.24.2017 #V154 maha - added save only option
	ls_notetext = mle_cover_text.Text
	ls_subject = sle_subject.Text
	ls_email_address = sle_email.text
	
	IF ls_subject = "" OR IsNull(ls_subject) THEN
		MessageBox("Required Data Missing", "You must fill in the subject text." )
		sle_subject.setfocus()
		Return 
	END IF
	
	IF ls_email_address = "" OR IsNull(ls_email_address) THEN
		MessageBox("Required Data Missing", "You must fill in the Email To." )
		sle_email.setfocus()
		Return 
	END IF
	
	IF (ls_notetext = "" OR IsNull(ls_notetext)) and gi_email_type = 1 THEN
		MessageBox("Required Data Missing", "You must fill in the Email message." )
		mle_cover_text.setfocus()
		Return 
	END IF
end if

lc_chx = dw_1.getitemstring(1, "inc_addi_file")
if lc_chx = 'Y' then
	ls_path = dw_1.getitemstring(1, "inc_file_path")
	if isnull(ls_path) or not DirectoryExists(ls_path) then
		MessageBox("Prompt", "Please set a correct Additional Files Path." )
		return
	end if
end if

//---------Begin Added by (Appeon)Stephen 10.24.2013 for BugL100806--------
lc_chx = dw_1.getitemstring(1, "inc_application")
if lc_chx = 'Y' then
	ll_app_id = dw_1.getitemnumber(1, "app_id")
	if isnull(ll_app_id) or ll_app_id = 0 then
		messagebox("Prompt", "Please first select Application !")
		return
	end if
end if
//---------End Added ------------------------------------------------------
		
//Prevent from clicked twice, Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
If ib_processing Then 
	Return
Else
	ib_processing = True 
End If

SELECT facility.facility_name  
INTO :is_facility_name  
FROM facility  
WHERE facility.facility_id = :ii_facility_id  using sqlca ;	

ls_path = gs_temp_path + "packagezip"
if not DirectoryExists(ls_path) then CreateDirectory(ls_path)
ls_path = ls_path + "\"

SELECT getdate() INTO :ldt_CurrentTime FROM ids;	
lb_db = true

for li_i = 1 to upperbound(il_prac_ids)
	if gnv_app.gnvlo_msword.of_delete_file(ls_path ) = -1 then 
		lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
		exit
	End If
	
	
	//---------Begin Added by (Appeon)Stephen 10.21.2013 for BugA101704 --------
	if not isvalid(w_package_gifofwait) then
		open(w_package_gifofwait)
		if upperbound(il_prac_ids) > 1 then w_package_gifofwait.st_2.visible = true
	end if
	w_package_gifofwait.title = "File Packet Creation - " + is_prac_names[li_i]
	w_package_gifofwait.st_2.text = "Provider "+string(li_i) +" of " +string(upperbound(il_prac_ids)) +", Please stand by!"
	w_package_gifofwait.BringToTop = TRUE
	//---------End Added ------------------------------------------------------
	
	is_curr_name = of_set_name( is_prac_names[li_i] )  //Start Code Change ----10.25.2017 #V154 maha

	ii_file_count = 0
	//create application file	
	lc_chx = dw_1.getitemstring(1, "inc_application")
	if lc_chx = 'Y' then
		ll_app_id = dw_1.getitemnumber(1, "app_id")
		if not isnull(ll_app_id) then
			//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
			//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)		
			//openwithparm( w_appeon_gifofwait, "Creating application file, Please wait..." ) 
			w_package_gifofwait.st_1.text = "Creating application file, Please wait..."
			w_package_gifofwait.hpb_1.Position = 10
			w_package_gifofwait.BringToTop = TRUE
			//---------End Modfiied ------------------------------------------------------
			
			if of_get_appfile(ll_app_id, il_prac_ids[li_i])	= -1 then 
				lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
				exit	
			End If
			yield()
		end if
	end if
	
	//create current image	
	if not isvalid(ids_image) then ids_image = create datastore
	ids_image.dataobject = "d_pd_image_list"
	ids_image.settransobject(sqlca)
	if not isvalid(inv_image_functions) then inv_image_functions = create pfc_cst_nv_image_functions
	lc_chx = dw_1.getitemstring(1, "inc_images")
	
	if lc_chx = 'Y' then
		//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
		//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
		//openwithparm( w_appeon_gifofwait, "Creating current images, Please wait..." )  
		w_package_gifofwait.st_1.text = "Creating current images, Please wait..."
		w_package_gifofwait.hpb_1.Position = 20
		w_package_gifofwait.BringToTop = TRUE
		//---------End Modfiied ------------------------------------------------------		
		if of_current_img(il_prac_ids[li_i], 0) = -1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit
		End If
		yield()
	end if
	
	//create Verification Images
	lc_chx = dw_1.getitemstring(1, "inc_verif_images")
	if lc_chx = 'Y' then
		//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
		//if  isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
		//openwithparm( w_appeon_gifofwait, "Creating Verification Images, Please wait..." )	
		w_package_gifofwait.st_1.text = "Creating Verification Documents, Please wait..."
		w_package_gifofwait.hpb_1.Position = 30
		w_package_gifofwait.BringToTop = TRUE
		//---------End Modfiied ------------------------------------------------------		
		if of_current_img(il_prac_ids[li_i], 99) = -1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit
		End If
		yield()
	end if		

	//create Verification Images (verifications)
	lc_chx = dw_1.getitemstring(1, "inc_verif_image")
	if lc_chx = 'Y' then	
		w_package_gifofwait.st_1.text = "Creating Verification Images, Please wait..."
		w_package_gifofwait.hpb_1.Position = 35
		w_package_gifofwait.BringToTop = TRUE
		of_extract_verif_docs(il_prac_ids[li_i], gs_temp_path + "packagezip\")
	end if
	 
	//create Provider Profile
	lc_chx = dw_1.getitemstring(1, "inc_profile")
	if not isvalid(inv_pdf) then inv_pdf = Create appeon_pdfservice
	if lc_chx = 'Y' then
		//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
		//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
		//openwithparm( w_appeon_gifofwait, "Creating Provider Profile, Please wait..." )		
		w_package_gifofwait.st_1.text = "Creating Provider Profile, Please wait..."
		w_package_gifofwait.hpb_1.Position = 40
		w_package_gifofwait.BringToTop = TRUE
		//---------End Modfiied ------------------------------------------------------	
		
		if not isvalid(inv_reports) then inv_reports = CREATE pfc_cst_u_reports	
		if of_pro_profile(il_prac_ids[li_i]) = -1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit	
		End If
		yield()
	end if
	
	//create Verification Profile
	lc_chx = dw_1.getitemstring(1, "inc_ver_profile")
	if lc_chx = 'Y' then
		//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
		//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
		//openwithparm( w_appeon_gifofwait, "Creating Verification Profile, Please wait..." )
		w_package_gifofwait.st_1.text = "Creating Verification Profile, Please wait..."
		w_package_gifofwait.hpb_1.Position = 50
		w_package_gifofwait.BringToTop = TRUE
		//---------End Modfiied ------------------------------------------------------	
		
		if not isvalid(inv_printletters) then inv_printletters =  create pfc_n_cst_ai_printletters 
		if of_ver_profile(il_prac_ids[li_i])	= -1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit
		End If
		yield()
	end if
	
	//create Checklist Report
	lc_chx = dw_1.getitemstring(1, "inc_check_report")
	if lc_chx = 'Y' then
		//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
		//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
		//openwithparm( w_appeon_gifofwait, "Creating Checklist Report, Please wait..." )
		w_package_gifofwait.st_1.text = "Creating Checklist Report, Please wait..."
		w_package_gifofwait.hpb_1.Position = 55
		w_package_gifofwait.BringToTop = TRUE
		//---------End Modfiied ------------------------------------------------------	
		if of_chklist_report(il_prac_ids[li_i]) = -1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit
		End If
		yield()
	end if

	//Start Code Change ----11.28.2017 #V16 maha	
	//Redflag report
	lc_chx = dw_1.getitemstring(1, "redflag_report")
	if lc_chx = 'Y' then
		w_package_gifofwait.st_1.text = "Creating Red Flag Report, Please wait..."
		w_package_gifofwait.hpb_1.Position = 60
		w_package_gifofwait.BringToTop = TRUE
		
		of_get_report( il_prac_ids[li_i], "R")
		
		yield()
	end if
	
	//OIG report
	lc_chx = dw_1.getitemstring(1, "oig_report")
	if lc_chx = 'Y' then
		w_package_gifofwait.st_1.text = "Creating OIG Scan Flag Report, Please wait..."
		w_package_gifofwait.hpb_1.Position = 65
		w_package_gifofwait.BringToTop = TRUE
		
		of_get_report( il_prac_ids[li_i], "O")
		
		yield()
	end if	
	//End Code Change ----11.28.2017
	
	lc_chx = dw_1.getitemstring(1, "npdb_report")
	if lc_chx = 'Y' then
		w_package_gifofwait.st_1.text = "Creating OIG Scan Flag Report, Please wait..."
		w_package_gifofwait.hpb_1.Position = 70
		w_package_gifofwait.BringToTop = TRUE
//		of_npdb_report(il_prac_ids[li_i], ii_facility_id )
	end if
	
	//@@@@@@@@@  create zip file  @@@@@@@@@@@@@@@@@

	w_package_gifofwait.st_1.text = "Creating zip package, Please wait..."
	w_package_gifofwait.hpb_1.Position = 80
	w_package_gifofwait.BringToTop = TRUE
	//---------End Modfiied ------------------------------------------------------
	if of_zip_package(il_prac_ids[li_i], is_prac_names[li_i] ) = -1 then
		lb_failed = True
		exit
	End If
	yield()
	
	
	
	//send email
	//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
	//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	//openwithparm( w_appeon_gifofwait, "Sending Email,  Please wait..." )
	w_package_gifofwait.st_1.text = "Sending Email, Please wait..."
	w_package_gifofwait.hpb_1.Position = 90
	w_package_gifofwait.BringToTop = TRUE
	//---------End Modfiied ------------------------------------------------------
	if ib_email then //Start Code Change ----10.24.2017 #V154 maha - added save only option
		li_return = of_send_email(il_prac_ids[li_i], is_prac_names[li_i])
		if li_return <> 1 then 
			lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
			exit
		End If
	end if
	yield()
	
	//set pd_package_log data
	dw_1.SetItemStatus(1, 0,primary!,newmodified!)
	dw_1.setitem(1, "prac_id", il_prac_ids[li_i])
	dw_1.setitem(1, "facility_id", ii_facility_id)
	dw_1.setitem(1, "file_count", ii_file_count)
	dw_1.setitem(1, "date_sent", ldt_CurrentTime)
	if dw_1.update() <> 1 then 
		lb_db = false
		lb_failed = True //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
		exit
	end if
	//---------Begin Modified by (Appeon)Stephen 10.21.2013 for BugA101704--------
	w_package_gifofwait.hpb_1.Position = 100
	w_package_gifofwait.BringToTop = TRUE
	//---------End Modfiied ------------------------------------------------------
	//if isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)		//Commented by (Appeon)Stephen 10.21.2013 - BugA101704
	
next

//---------Begin Add by (Appeon)Stephen 10.22.2013 for BugL100809--------
if lb_db = false then
	rollback using sqlca;	
else
	commit using sqlca;
end if
//---------End Add ------------------------------------------------------

if isvalid(w_package_gifofwait) then close(w_package_gifofwait)		
if isvalid(inv_image_functions) then DESTROY inv_image_functions
if isvalid(ids_image) then DESTROY  ids_image
if isvalid(inv_pdf) then Destroy inv_pdf
if isvalid(inv_printletters) then Destroy inv_printletters	
if isvalid(inv_reports) then Destroy inv_reports	

 //Start Code Change ----11.20.2017 #V154 maha - delete verification records
 ls_path = ls_path + "verif_docs\"
 gnv_app.gnvlo_msword.of_delete_file(ls_path ) 
 //End Code Change ----11.20.2017 



ib_processing = False //Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)

//Added by Appeon long.zhang 01.18.2017 (Case #000068546 What is this error please)
If Not lb_failed Then
	If Messagebox('Zip Package','Successful.~r~nDo you want to close current window right now?', &
		Question!,YesNo!,1) = 1 Then
		Close(Parent)
	End If
End If
end event

type dw_1 from u_dw within w_package_screen
integer x = 69
integer y = 176
integer width = 3081
integer height = 588
integer taborder = 10
string title = "none"
string dataobject = "d_provider_package"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.10.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_null
integer li_ret
string ls_describe  //maha 12.13.2017
long ll_app
datawindowchild ldwc_app

setnull(li_null)
choose case dwo.name
	case "inc_addi_file"
		if data = 'Y' then 
			this.modify("inc_file_path.TabSequence='90'")
			this.modify("b_1.enabled='Yes'")
		else
			this.modify("inc_file_path.TabSequence='0'")
			this.modify("b_1.enabled='No'")
			this.setitem(1,"inc_file_path", "")
		end if
	case "inc_application"
		if data = 'Y' then
			this.modify("app_id.TabSequence='10'")
		else
			this.modify("app_id.TabSequence='0'")
			this.setitem(1, "app_id", li_null)
		end if
	case "facility_id" //(Appeon)Stephen 10.16.2013 -BugL100804
		if upperbound(il_prac_ids) > 0 and istr_open_from.types <> 'ver-app' then
			li_ret = messagebox("Prompt", "Changing the facility will delete all selected providers , " + &
			"do you want to continue?", Exclamation!, YesNo!, 2)
			if li_ret = 2 then
				this.setitem(1, "facility_id", ii_facility_id)
				return 2				
			else
				cb_reset.event clicked()
			end if
			this.accepttext()
		end if
		
		if istr_open_from.types = 'ver-app'  then
			dw_1.setitem(1, "app_id", li_null)
			dw_1.GetChild( "app_id", ldwc_app ) 
			ldwc_app.SetTransObject( SQLCA )			
			ldwc_app.retrieve( istr_open_from.prac_id, long(data))
		end if
		
	case "email_save"
		if this.getitemnumber(1, "email_save") = 0 then 
			w_package_screen. height =3080
		else
			w_package_screen. height = gb_2.y + gb_2.height + 120
		end if
		
	case "app_id"  //Start Code Change ----12.13.2017 #V16 maha
		ll_app = long(data)
		select application_name into :is_app_name from app_hdr where app_id = :ll_app;
		
end choose


end event

event buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.11.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_path, ls_filename[]
string ls_file
integer li_ret, li_i

if row < 1 then return
choose case dwo.name
	case "b_1"
         li_ret = GetFolder("Select Directory", ls_path)
		
		ChangeDirectory(gs_current_path)
		this.setitem(row, "inc_file_path", ls_path)
end choose
end event

event constructor;this.of_setupdateable(false) //(Appeon)Stephen 08.09.2013 - V141 File Packet creation
end event

type mle_cover_text from multilineedit within w_package_screen
integer x = 59
integer y = 1296
integer width = 3237
integer height = 1200
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_template from u_dw within w_package_screen
boolean visible = false
integer x = 1550
integer y = 1392
integer width = 1362
integer height = 912
integer taborder = 160
string dataobject = "d_email_temp_by_id"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;string is_path
string docname, named
integer value


value = GetFileOpenName("Select File", docname, named, "CVO", "Cover Page Files (*.CVP),*.CVP")
ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008

IF value > 0 THEN
	dw_template.SetItem( dw_template.GetRow( ), "cover_sheet", docname  )
END IF


end event

type gb_1 from groupbox within w_package_screen
integer x = 27
integer y = 116
integer width = 3296
integer height = 660
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Included File Types"
end type

type gb_2 from groupbox within w_package_screen
integer x = 32
integer y = 776
integer width = 3296
integer height = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Providers"
end type

type gb_3 from groupbox within w_package_screen
integer x = 32
integer y = 944
integer width = 3287
integer height = 1588
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Email Info"
end type

type dw_facility from datawindow within w_package_screen
boolean visible = false
integer x = 814
integer y = 1312
integer width = 1033
integer height = 96
integer taborder = 170
boolean enabled = false
string title = "none"
string dataobject = "d_dddw_facility_select_pack"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.insertrow(0)
end event

type ole_admin from olecustomcontrol within w_package_screen
event filepropertiesclose ( )
boolean visible = false
integer x = 2235
integer y = 2552
integer width = 265
integer height = 176
integer taborder = 150
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
string binarykey = "w_package_screen.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
end type

type ole_mail from u_email_edit within w_package_screen
boolean visible = false
integer x = 59
integer y = 1300
integer width = 3237
integer height = 1200
integer taborder = 180
boolean bringtotop = true
borderstyle borderstyle = stylebox!
string binarykey = "w_package_screen.win"
integer binaryindex = 2
end type

type dw_profile from u_dw within w_package_screen
boolean visible = false
integer x = 3410
integer y = 2116
integer width = 709
integer height = 404
integer taborder = 140
boolean bringtotop = true
string dataobject = "d_prf_master"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_package_screen.bin 
2E00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ffce74f001d37a2700000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000ffce74f001d37a27ffce74f001d37a27000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000008e30000000300000457000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000b3fc000000020000b3fc000000030043b44c000000030043b44c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020005000008e3000004570000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000ee000100b49c00001000b49c100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ffce74f001d37a2700000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000ffce74f001d37a27ffce74f001d37a27000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020106009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f0000000070000010000000040000001010000004800000102000000500000010300000058000001040000006000000105000000680000000000000070000000030003000200000003000005ff000000030000048c0000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000030002000005ff0000048c00000000000001000000000000000000000000000101000000000000000000000000000001000300000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000100000000020000030000000000030000010000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ffce74f001d37a2700000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d300000000ffce74f001d37a27ffce74f001d37a270000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd0000492d00001f0200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f007200700075000000500034004300430035003000410042003700350043003800300037003500460042003600410038003600360031004600310045003600370033003500450030003000440035003400310037004400300036
2900000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd0000492d00001f0200dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_package_screen.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
