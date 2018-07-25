$PBExportHeader$w_web_crawler_verifications.srw
forward
global type w_web_crawler_verifications from w_response
end type
type cb_max from commandbutton within w_web_crawler_verifications
end type
type rb_screenptint from radiobutton within w_web_crawler_verifications
end type
type rb_webpage from radiobutton within w_web_crawler_verifications
end type
type gb_2 from groupbox within w_web_crawler_verifications
end type
type cb_1 from commandbutton within w_web_crawler_verifications
end type
type st_reference from statictext within w_web_crawler_verifications
end type
type cbx_select from checkbox within w_web_crawler_verifications
end type
type tab_1 from tab within w_web_crawler_verifications
end type
type tabpage_verif from userobject within tab_1
end type
type st_1 from statictext within tabpage_verif
end type
type dw_verif_list from u_dw within tabpage_verif
end type
type tabpage_verif from userobject within tab_1
st_1 st_1
dw_verif_list dw_verif_list
end type
type tabpage_view from userobject within tab_1
end type
type cb_geturl from commandbutton within tabpage_view
end type
type ole_image from olecustomcontrol within tabpage_view
end type
type ole_browser2 from olecustomcontrol within tabpage_view
end type
type st_cap_mess from statictext within tabpage_view
end type
type ole_browser from olecustomcontrol within tabpage_view
end type
type tabpage_view from userobject within tab_1
cb_geturl cb_geturl
ole_image ole_image
ole_browser2 ole_browser2
st_cap_mess st_cap_mess
ole_browser ole_browser
end type
type tab_1 from tab within w_web_crawler_verifications
tabpage_verif tabpage_verif
tabpage_view tabpage_view
end type
type st_3 from statictext within w_web_crawler_verifications
end type
type st_2 from statictext within w_web_crawler_verifications
end type
type p_2 from picture within w_web_crawler_verifications
end type
type p_1 from picture within w_web_crawler_verifications
end type
type cbx_ama from checkbox within w_web_crawler_verifications
end type
type cbx_show from checkbox within w_web_crawler_verifications
end type
type cb_save from commandbutton within w_web_crawler_verifications
end type
type cb_close from commandbutton within w_web_crawler_verifications
end type
type cb_print from commandbutton within w_web_crawler_verifications
end type
type cb_crawl from commandbutton within w_web_crawler_verifications
end type
type hpb_1 from hprogressbar within w_web_crawler_verifications
end type
type dw_ama from u_dw within w_web_crawler_verifications
end type
type gb_1 from groupbox within w_web_crawler_verifications
end type
type st_datestamp from statictext within w_web_crawler_verifications
end type
type cb_forward from commandbutton within w_web_crawler_verifications
end type
type cb_back from commandbutton within w_web_crawler_verifications
end type
type cb_2 from commandbutton within w_web_crawler_verifications
end type
type cb_capture from commandbutton within w_web_crawler_verifications
end type
end forward

global type w_web_crawler_verifications from w_response
integer width = 4585
integer height = 2572
string title = "Web Verifications"
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
event ue_postupdate ( )
cb_max cb_max
rb_screenptint rb_screenptint
rb_webpage rb_webpage
gb_2 gb_2
cb_1 cb_1
st_reference st_reference
cbx_select cbx_select
tab_1 tab_1
st_3 st_3
st_2 st_2
p_2 p_2
p_1 p_1
cbx_ama cbx_ama
cbx_show cbx_show
cb_save cb_save
cb_close cb_close
cb_print cb_print
cb_crawl cb_crawl
hpb_1 hpb_1
dw_ama dw_ama
gb_1 gb_1
st_datestamp st_datestamp
cb_forward cb_forward
cb_back cb_back
cb_2 cb_2
cb_capture cb_capture
end type
global w_web_crawler_verifications w_web_crawler_verifications

type variables
Long il_prac_id[]
Integer ii_facility_id[]
Integer il_current_row = 0
Int ii_facility_ids[] //Added by Appeon long.zhang 12.23.2016
Int il_prac_ids[] //Added by Appeon long.zhang 12.23.2016
Int ii_screen_ids[]  //Added by Appeon long.zhang 12.23.2016
String ls_current_print_object = "Ver Data"
String ls_view_print_object = ""   //maha 07.06.2011 
string is_address  //maha 04.22.2016
Boolean ib_cancel = False
boolean ib_crawler = False
long il_orgh  //maha 07.25.2017

u_dw idw_verif_list
n_appeon_download inv_saveas

end variables

forward prototypes
public function integer of_set_verifs ()
public function integer of_get_image (string as_doc_id, string as_file)
public function string of_error_message (integer ai_mes)
public function integer of_capture ()
public function integer of_seterrorevent (oleobject aole_object)
end prototypes

event ue_postupdate();//====================================================================
//$<Event>: ue_postupdate
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Refresh date_verif_completed in appt_stat
//$<Author>: (Appeon) long.zhang 12.23.2016 (Issue id 5443 - Verification Date on Appointment Screen doesn't populate SaaS 15.2 Build date 11172016)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer i
Integer li_rc
Integer li_cnt
integer li_vfacil
integer fac
integer cnt
integer ck = 0
integer li_j 
Integer li_vfacil_arr[]
DateTime ldt_todaysDate
datastore ds_ver

//maha 10.02.08 note: ii_facility_ids, il_prac_ids[] are created in dw_browse,pfc_preupdate and are a list of distinct prac and facility for the list of verifications in dw_browse
li_rc = UpperBound( ii_facility_ids  )
IF li_rc <=0 THEN RETURN

ds_ver = create datastore
//ds_ver.dataobject = "d_ai_appt_stat_4_verif_compl"
ds_ver.dataobject = "d_ai_appt_stat_4_verif_compl_forpt"
ds_ver.settransobject(sqlca)

Datastore lds_verif_info
lds_verif_info = create datastore
lds_verif_info.dataobject = "d_verif_info_forpt"
lds_verif_info.settransobject(sqlca)

Datastore lds_affil_stat
lds_affil_stat = create datastore
lds_affil_stat.dataobject = "d_pd_affil_stat_forpt1"
lds_affil_stat.settransobject(sqlca)

gnv_appeondb.of_startqueue()

lds_affil_stat.Retrieve(ii_facility_ids[], il_prac_ids[])
lds_verif_info.Retrieve(ii_facility_ids[], il_prac_ids[])

gnv_appeondb.of_commitqueue()

ldt_todaysdate = DateTime( Today(), Now() )
FOR i = 1 TO li_rc
	fac = ii_facility_ids[i]
	
	if ii_screen_ids[i] = 1 then //if a screen 1 verification get the verifying facility for that parent id
		li_cnt = lds_affil_stat.Find("parent_facility_id = " + string(ii_facility_ids[i]) + " and prac_id = " + String(il_prac_ids[i]), 1, lds_affil_stat.rowcount())
		If li_cnt > 0 Then li_vfacil = lds_affil_stat.GetitemNumber(li_cnt, "verifying_facility")
	else
		li_vfacil = fac
	end if

	li_vfacil_arr[i] = li_vfacil
END FOR

ds_ver.retrieve(il_prac_ids[], li_vfacil_arr[])

ldt_todaysdate = DateTime( Today(), Now() )

gnv_appeondb.of_startqueue()

FOR i = 1 TO li_rc
	//$<reason> inv_action_items.of_is_last_verif( ii_facility_ids[ i ], il_prac_ids[ i ] ,ii_screen_ids[i])
	//$<reason> The following script is a copy from of_is_last_verif function in the pfc_n_cst_ai_action_items userobject
	fac = ii_facility_ids[i]
	
	if li_vfacil_arr[i] = ii_facility_ids[i] then ck = 1 //if parent and ver are the same then skip some work later down
	
	//cnt = ds_ver.retrieve(il_prac_ids[i],li_vfacil)
	ds_ver.Setfilter("prac_id = " + String(il_prac_ids[i]) + " And verifying_facility = " + String(li_vfacil) )
	ds_ver.Filter( )
	cnt = ds_ver.Rowcount( )
	
	IF cnt >= 0 THEN
		li_cnt = lds_verif_info.Find("facility_id = " + string(li_vfacil) + " and prac_id = " + String(il_prac_ids[i]) + " and active_status = 1", 1, lds_verif_info.rowcount())
		IF li_cnt = 0 THEN 
			if cnt > 0 then //redundant trap
				if ck = 1 then  //parent and verif are different
					for li_j = 1 to cnt //test for npdb,oig etc.  
						fac = ds_ver.getitemnumber(li_j,"parent_facility_id") 

						li_cnt = lds_verif_info.Find("facility_id = " + string(fac) + " and prac_id = " + String(il_prac_ids[i]) , 1, lds_verif_info.rowcount())
						if li_cnt = 0 then
							ds_ver.setitem(li_j,"date_verif_completed",ldt_todaysDate)
						end if
					next
				else //same parent and ver facility;  should normally be 1
					for li_j = 1 to cnt //already tested for verification above so just set date 
						ds_ver.setitem(li_j,"date_verif_completed",ldt_todaysDate) 
					next
				end if
			END IF
			ds_ver.update()
			COMMIT USING SQLCA;
		END IF
	END IF
NEXT

gnv_appeondb.of_commitqueue()

DESTROY ds_ver
DESTROY lds_verif_info
DESTROY lds_affil_stat
end event

public function integer of_set_verifs ();//Reorganized for Scheduler - Alfee 02.08.2010

nvo_web_crawler_engine lnv_webcrawl

return lnv_webcrawl.of_set_verifs(idw_verif_list, ib_crawler)


////Start Code Change ---- 02.06.2007 #V7 maha called from open of window
//long i
//long li_rc
//long li_wc_id
//long ll_addr_code
//string ls_ref
//string ls_ref_1
//string ls_ref_2
//integer li_screen_id
//
//li_rc = idw_verif_list.rowcount()
//
//FOR i = 1 TO li_rc
//	if ib_crawler then
//		li_wc_id = 0
//	else
//		li_wc_id = -5
//	end if
//	ls_ref = idw_verif_list.GetItemString( i, "reference_value" )
//	ls_ref_1 = Mid( ls_ref, 1, POS( ls_ref, "-" ) -1 )
//	ls_ref_2 = Mid( ls_ref, POS( ls_ref, "-" ) + 2, 100 )
//	li_screen_id = idw_verif_list.GetItemNumber( i, "screen_id" )
//	ll_addr_code = idw_verif_list.GetItemNumber( i, "address_lookup_code" )
//	
//	if isnull(li_screen_id) then
//		idw_verif_list.SetItem( i, "web_crawler_id", li_wc_id )
//		idw_verif_list.SetItem( i, "complete_status", -4 )	
//	else
//	
//	if ib_crawler then
//		Choose Case li_screen_id
//					
//		
//				//DEA Registration
//				Case 5
//					//this assumes that the the first reference value is the state.  if not it will fail
//					SELECT code
//					INTO :ls_ref_1
//					FROM code_lookup
//					WHERE lookup_name = 'State' AND
//							code = :ls_ref_1;
//					IF SQLCA.SQLCODE = -1 THEN
//						MessageBox( "SQL Error getting state for DEA", SQLCA.SQLERRTEXT + "  -  " + string(SQLCA.SQLDBCode ))
//						//Return -1
//					END IF
//					
//					ls_ref_1 = Trim( ls_ref_1 )
//						
//						//MESSAGEBOX("", LS_REF_1 )
//					SELECT wc_hdr.wc_id  
//					INTO :li_wc_id
//						FROM wc_hdr  
//						WHERE ( wc_hdr.wc_screen_id_link = 5 ) AND  
//									 ( wc_hdr.wc_screen_field_link_fixed_value = :ls_ref_1 );
//					IF SQLCA.SQLCODE = -1 THEN
//						//MessageBox( "SQL Error  getting crawler id for  dea screen", SQLCA.SQLERRTEXT  + "  -  " + string(SQLCA.SQLDBCode))
//						if SQLCA.SQLERRTEXT = "Select returned more than one row" then
//								openwithparm(w_wc_crawl_select,"5" + "*" + ls_ref_1)
//								li_wc_id = message.doubleparm
//							end if
//					END IF
//			
//					
//				//ECFMG
//				Case 20
//					SELECT DISTINCT wc_hdr.wc_id
//					INTO :li_wc_id
//					FROM wc_hdr  
//						WHERE wc_hdr.wc_screen_id_link = 20;
//					IF SQLCA.SQLCODE = -1 THEN
//						MessageBox( "SQL Error getting crawler id for  ECFMG screen", SQLCA.SQLERRTEXT )
//					//	Return -1
//					END IF
//					
//				//Other Ids	
//				Case 23
//					//this assumes that the the first reference value is the state.  if not it will fail
//					SELECT code
//					INTO :ls_ref_1
//					FROM code_lookup
//					WHERE lookup_name = 'Other Document Type' AND
//							code = :ls_ref_1;
//					IF SQLCA.SQLCODE = -1 THEN
//						MessageBox( "SQL Error getting state for Other id record", SQLCA.SQLERRTEXT + "  -  " + string(SQLCA.SQLDBCode ))
//						//Return -1
//					END IF
//					
//					ls_ref_1 = Trim( ls_ref_1 )
//						
//						//MESSAGEBOX("", LS_REF_1 )
//					SELECT wc_hdr.wc_id  
//					INTO :li_wc_id
//						FROM wc_hdr  
//						WHERE ( wc_hdr.wc_screen_id_link = 23 ) AND  
//									 ( wc_hdr.wc_screen_field_link_fixed_value = :ls_ref_1 );
//					IF SQLCA.SQLCODE = -1 THEN
//						//MessageBox( "SQL Error  getting crawler id for  dea screen", SQLCA.SQLERRTEXT  + "  -  " + string(SQLCA.SQLDBCode))
//						if SQLCA.SQLERRTEXT = "Select returned more than one row" then
//								openwithparm(w_wc_crawl_select,"23" + "*" + ls_ref_1)
//								li_wc_id = message.doubleparm
//							end if
//					END IF
//			
//				//other screens
//				Case ELSE
//					if isnull(ll_addr_code) or ll_addr_code = 0 then
//						li_wc_id = 0
//					else
//						SELECT DISTINCT wc_hdr.wc_id
//							INTO :li_wc_id
//							FROM wc_hdr,   
//								  wc_multi_entity_link,   
//								  address_lookup
//						WHERE ( wc_hdr.wc_id = wc_multi_entity_link.wc_id ) and  
//								( wc_multi_entity_link.wc_lookup_code = address_lookup.lookup_code ) and  
//								( ( wc_hdr.wc_screen_id_link = :li_screen_id ) AND  
//								( address_lookup.lookup_code = :ll_addr_code) ) ;
//						IF SQLCA.SQLCODE = -1 THEN
//							//MessageBox( "SQL Error getting crawler id for " + string(li_screen_id) + " screen and lookupcode= " + string(ll_addr_code), SQLCA.SQLERRTEXT  + "  -  " + string(SQLCA.SQLDBCode ))
//							if SQLCA.SQLERRTEXT = "Select returned more than one row" then
//								openwithparm(w_wc_crawl_select, string(li_screen_id) + "*" + string(ll_addr_code))
//								li_wc_id = message.doubleparm
//							end if
//						END IF
//					end if
//			End Choose
//		
//		else //crawler
//			li_wc_id = -5
//		end if
//			
//	//	debugbreak()
//	end if
//	
//	IF li_wc_id > 0 then //has a crawler
//		idw_verif_list.SetItem( i, "web_crawler_id", li_wc_id )
//		idw_verif_list.SetItem( i, "complete_status", 0 )
//	ELSE
//		idw_verif_list.SetItem( i, "web_crawler_id",0 )
//		if Len( idw_verif_list.GetItemString( i, "web_address") ) > 0 then
//			idw_verif_list.SetItem( i, "complete_status", -3 )	
//		else
//			if li_wc_id = -5 then //no crawler module
//				idw_verif_list.SetItem( i, "complete_status", -5 )
//			else
//				idw_verif_list.SetItem( i, "complete_status", -4 )
//			end if
//		end if
//	END IF
//			
//	
////	
////	IF li_wc_id = 0 or isnull(li_wc_id) THEN
////		idw_verif_list.SetItem( i, "web_crawler_id", 0 )
////		idw_verif_list.SetItem( i, "complete_status", -4 )		
////	ELSE
////		idw_verif_list.SetItem( i, "web_crawler_id", li_wc_id )
////		idw_verif_list.SetItem( i, "complete_status", 0 )		
////	END IF
////	
////	IF li_wc_id = 0 AND Len( idw_verif_list.GetItemString( i, "web_address") ) > 0 THEN
////		idw_verif_list.SetItem( i, "complete_status", -3 )					
////	END IF
//
//END FOR
//
//return 1
end function

public function integer of_get_image (string as_doc_id, string as_file);Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_verif_picture
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

//debugbreak()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
SELECTBLOB verification_picture
INTO :lb_verif_picture
FROM verif_info
WHERE doc_id = :as_doc_id
USING SQLCA;
*/
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_verif_info(as_doc_id, lb_verif_picture)
ELSE
	SELECTBLOB verification_picture
	INTO :lb_verif_picture
	FROM verif_info
	WHERE doc_id = :as_doc_id
	USING SQLCA;
END IF

//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

//tab_1.tabpage_preview.p_1.SetPicture( lb_verif_picture )

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

FileDelete( as_file )

li_filenum =  FileOpen( as_file , StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_verif_picture, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 tab_1.tabpage_verif.st_1.text = "Writing File"
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
   tab_1.tabpage_verif.st_1.text = "File Closed"
ELSE
	MessageBox( "File Open Error", "Could not open " + as_file + " for StreamMode!" )
	Return -	1
END IF


DO While Not FileExists( as_file )
	Yield( )
	 tab_1.tabpage_verif.st_1.text = "Waiting for Image Retrieval"
	IF ib_cancel THEN
		//cb_cancel.Enabled = False
		Return -1
	END IF
LOOP

 tab_1.tabpage_verif.st_1.text = "Image Retrieved" 

//cb_cancel.Enabled = True

Return 1

end function

public function string of_error_message (integer ai_mes);string ls_mes

choose case ai_mes
	case 3
		ls_mes = "Not found on Site"
	case -10
		ls_mes = "Error retrieving Verification Data"
	case -20
		ls_mes = "Error retrieving Web Crawler"
	case -30
		ls_mes = "Crawler requires a password"
	case -40
		ls_mes = "Error retrieving crawler steps"
	case -901
		ls_mes = "Error building Crawler macro "
	case -902
		ls_mes = "Failed to connect to InternetMacros program"
	case -903
		ls_mes = "Crawler Failed on website"
	case -904
		ls_mes = "_ResultPage.htm file was not created"
	case else
		ls_mes = ""
end choose 

return ls_mes
end function

public function integer of_capture ();//////////////////////////////////////////////////////////////////////
// $<function> of_capture
// $<arguments>
// $<returns> integer
// $<description> Update HTML source to database
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.26.2009
//////////////////////////////////////////////////////////////////////
integer li_Return
integer li_Null
long ll_counter, ll_loops
string ls_doc_id
string ls_Error
string ls_URL
string ls_FileName
string ls_notes  //maha 04.22.2016
blob lblb_verif_picture

inet lnv_inet
n_internetresult lnv_InternetResult
n_cst_dm_utils lnv_file
n_cst_appeondll lnv_AppeonDll

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 08.14.2009
//$<reason> The inet objects unable to get dynamic html page source
/*
// Get HTML source of current URL through INET objects
lnv_inet = Create inet
lnv_InternetResult = Create n_internetresult
SetPointer(HourGlass!)
ls_URL = tab_1.tabpage_view.ole_browser.object.LocationURL

if gi_test_mode = 1 then //Start Code Change ----07.27.2009 #V92 maha - test function
	messagebox("ls_url in of_capture",ls_url)
end if

li_Return = lnv_inet.GetURL(ls_URL, lnv_InternetResult)
choose case li_Return
	case -1
		ls_Error = "General error."
	case -2
		ls_Error = "Invalid URL."
	case -4
		ls_Error = "Cannot connect to the Internet."
	case else
		ls_Error = "Error code is: " + String(li_Return)
end choose
if li_Return <> 1 then
	Destroy lnv_inet
	Destroy lnv_InternetResult
	SetPointer(Arrow!)
	MessageBox("Get HTML Error", ls_Error)
	Return -1
end if
lblb_verif_picture = lnv_InternetResult.of_GetHtmlSource()
SetPointer(Arrow!)
Destroy lnv_inet
Destroy lnv_InternetResult
*/
SetNull(li_Null)
ls_FileName =  gs_temp_path + "capture.htm"
FileDelete(ls_FileName)

SetPointer(HOURGLASS!) 

try
	//-----Begin modified by alfee 04.16.2010 ---------------------------------
	lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 1) //modify file name & save	
	//-----Begin modified by alfee 08.11.2010 ---------------------------------
	if tab_1.tabpage_view.ole_browser2.BringtoTop = True then
		tab_1.tabpage_view.ole_browser2.object.ExecWB(4, 2, ls_FileName, li_Null)
	else 
		tab_1.tabpage_view.ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)
	end if	
	//tab_1.tabpage_view.ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)
	//-----End Modified -------------------------------------------------------
	//lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName)		
	//	//--------Begin modified by alfee 03.03.2010 ---------------------------
	//	//for ticket #23046 - Web + IE7/8 + http://profiles.massmedboard.org/MA-Physician-Profile-Verification.asp
	//	//	tab_1.tabpage_view.ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)
	//	if appeongetclienttype() = 'WEB' then
	//		tab_1.tabpage_view.ole_browser.object.ExecWB(4, 1, ls_FileName, li_Null)
	//	else
	//		tab_1.tabpage_view.ole_browser.object.ExecWB(4, 2, ls_FileName, li_Null)
	//	end if
	//	//--------End Modified -------------------------------------------------
	//-----End Modified -------------------------------------------------------	
catch (RuntimeError e)
	tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
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
				tab_1.tabpage_view.st_cap_mess.text = "Web Page not Captured"
				lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread
				Return -1								
			end if
		end if
		
		//Popup the SaveAs dialog and wait to save the Web page manually
		ll_loops = 0
		ll_counter ++
		tab_1.tabpage_view.st_cap_mess.text = "Make sure the File name is '" + ls_FileName + "' and the Save as type is 'Web Page, HTML only'."
		lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 2)	//modify the file name (not always working)
		tab_1.tabpage_view.ole_browser.object.ExecWB(4, 1, ls_FileName, li_Null) 
	end if
	//---------End Added ------------------------------------------------------
loop

lnv_AppeonDll.of_AutoCloseSaveHTMLDlg(ls_FileName, 0) //close the thread - alfee 04.16.2010

lnv_file.of_ReadBlob(ls_FileName, lblb_verif_picture)
//------------------- APPEON END ---------------------

// Update HTML source to database
tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")

UPDATEBLOB verif_info
SET verification_picture = :lblb_verif_picture
WHERE doc_id = :ls_doc_id
USING SQLCA;
if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."

UPDATE verif_info
SET verification_picture_flag = 3
WHERE doc_id = :ls_doc_id
USING SQLCA;
if SQLCA.SQLCode = -1 then
	ROLLBACK USING SQLCA;
	MessageBox("SQL Error", SQLCA.SQLErrText)
	Return -1
end if
idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 3)

//Start Code Change ----04.22.2016 #V15 maha
	ls_notes = idw_verif_list.getItemstring(il_current_row, "verif_info_notes")
	if isnull(ls_notes) then ls_notes = ""
//	ls_URL = tab_1.tabpage_view.ole_browser.object.LocationURL
	ls_notes =  "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now()) + " - Website: " + is_address + " - " + ls_notes
	idw_verif_list.SetItem(il_current_row, "verif_info_notes", ls_notes)
	//Start Code Change ----08.17.2017 #V154 maha - stamp upload values
	idw_verif_list.SetItem( il_current_row, "image_stamp", datetime( today(), Now()) ) 
	idw_verif_list.SetItem( il_current_row, "image_stamp_user", gs_user_id )
	idw_verif_list.SetItem( il_current_row, "image_stamp_site", "Capture: " + is_address)
	//End Code Change ----08.17.2017 
	//End Code Change ----04.22.2016

//MessageBox("Capture", "Update successfully!")
MessageBox("Capture", "Update successful!")// Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
Return 1
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

on w_web_crawler_verifications.create
int iCurrent
call super::create
this.cb_max=create cb_max
this.rb_screenptint=create rb_screenptint
this.rb_webpage=create rb_webpage
this.gb_2=create gb_2
this.cb_1=create cb_1
this.st_reference=create st_reference
this.cbx_select=create cbx_select
this.tab_1=create tab_1
this.st_3=create st_3
this.st_2=create st_2
this.p_2=create p_2
this.p_1=create p_1
this.cbx_ama=create cbx_ama
this.cbx_show=create cbx_show
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_print=create cb_print
this.cb_crawl=create cb_crawl
this.hpb_1=create hpb_1
this.dw_ama=create dw_ama
this.gb_1=create gb_1
this.st_datestamp=create st_datestamp
this.cb_forward=create cb_forward
this.cb_back=create cb_back
this.cb_2=create cb_2
this.cb_capture=create cb_capture
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_max
this.Control[iCurrent+2]=this.rb_screenptint
this.Control[iCurrent+3]=this.rb_webpage
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_reference
this.Control[iCurrent+7]=this.cbx_select
this.Control[iCurrent+8]=this.tab_1
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.p_2
this.Control[iCurrent+12]=this.p_1
this.Control[iCurrent+13]=this.cbx_ama
this.Control[iCurrent+14]=this.cbx_show
this.Control[iCurrent+15]=this.cb_save
this.Control[iCurrent+16]=this.cb_close
this.Control[iCurrent+17]=this.cb_print
this.Control[iCurrent+18]=this.cb_crawl
this.Control[iCurrent+19]=this.hpb_1
this.Control[iCurrent+20]=this.dw_ama
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.st_datestamp
this.Control[iCurrent+23]=this.cb_forward
this.Control[iCurrent+24]=this.cb_back
this.Control[iCurrent+25]=this.cb_2
this.Control[iCurrent+26]=this.cb_capture
end on

on w_web_crawler_verifications.destroy
call super::destroy
destroy(this.cb_max)
destroy(this.rb_screenptint)
destroy(this.rb_webpage)
destroy(this.gb_2)
destroy(this.cb_1)
destroy(this.st_reference)
destroy(this.cbx_select)
destroy(this.tab_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.p_2)
destroy(this.p_1)
destroy(this.cbx_ama)
destroy(this.cbx_show)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.cb_crawl)
destroy(this.hpb_1)
destroy(this.dw_ama)
destroy(this.gb_1)
destroy(this.st_datestamp)
destroy(this.cb_forward)
destroy(this.cb_back)
destroy(this.cb_2)
destroy(this.cb_capture)
end on

event open;call super::open;Integer li_rc
Integer i
Integer li_screen_id
Integer li_wc_id
String ls_web_site_address
String ls_ref
String ls_ref_1
String ls_ref_2
string ls_text //maha 04.22.2011
string ls_docid[]

idw_verif_list = create u_dw

idw_verif_list = tab_1.tabpage_verif.dw_verif_list
//debugbreak()
str_web_crawler lstr_web_crawler 

if of_get_app_setting("web_crawl","I") = 1 then
	ib_crawler = true
end if

if not ib_crawler then
	cb_crawl.visible = false
	cbx_show.visible = false
	cbx_select.visible = false
end if
	
lstr_web_crawler = Message.PowerObjectParm
ii_facility_id[] = lstr_web_crawler.si_facility_ids[]
il_prac_id[] = lstr_web_crawler.sl_prac_ids[]
ls_docid[] = lstr_web_crawler.ss_docid[]

li_rc = upperbound(ls_docid[])

idw_verif_list.of_SetTransObject( SQLCA )
//idw_verif_list.Retrieve( ii_facility_id, il_prac_id )
li_rc = idw_verif_list.Retrieve(ls_docid[] )
if li_rc < 1 then messagebox("","error retrieving verification(s)")

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.07.2006 By: LeiWei
//$<reason> Fix a defect.It should only retrieve records with no response code.
idw_verif_list.SetFilter("response_code = 0 OR IsNull(response_code)")
idw_verif_list.Filter( )
//---------------------------- APPEON END ----------------------------

li_rc = idw_verif_list.RowCount( )

//Start Code Change ----04.22.2011 #V11 maha - message option added
if ib_crawler = true then
	ls_text = "There are " + String( li_rc ) + " credential(s) to verify. To run the crawler, click the check box next to the credential you want to verify, then click on the Crawl button."
else
	ls_text = "There are " + String( li_rc ) + " credential(s) to verify.  if a web link is available you can double-click the link icon to browse to that website."
end if

 tab_1.tabpage_verif.st_1.Text = ls_text
//End Code Change ----04.22.2011 

if w_mdi.of_security_access(560) < 2 then idw_verif_list.object.b_uplink.visible = false   //Start Code Change ----11.14.2013 #V14 maha
 
 
of_set_verifs( ) //Start Code Change ---- 02.06.2007 #V7 maha moved code to function

idw_verif_list.AcceptText( )

//Start Code Change ----01.27.2009 #V92 maha - removed set sort.  Note: sort required because filter above
//idw_verif_list.Modify("DataWindow.Header.1.Height='0'")
//idw_verif_list.SetSort( "completed_status A, screen_name A, reference_value A" )	
idw_verif_list.Sort( )

//Start Code Change ----07.25.2017 #V154 maha
tab_1.tabpage_view.ole_browser.event windowsetresizable(true)
tab_1.tabpage_view.ole_browser2.event windowsetresizable(true)
il_orgh = this.height 
//End Code Change ----07.25.2017

end event

event pfc_postupdate;call super::pfc_postupdate;//====================================================================
//$<Event>: pfc_postupdate
//$<Arguments>:
// 	value    powerobject    apo_control[]
//$<Return>:  integer
//$<Description>: Call ue_postupdate() after update
//$<Author>: (Appeon) long.zhang 12.23.2016 (Issue id 5443 - Verification Date on Appointment Screen doesn't populate SaaS 15.2 Build date 11172016)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rc
Integer i
Integer ll_facility_ids[]
Long ll_prac_ids[]
Integer li_screen_ids[]

if upperbound(ii_facility_ids) < 1 or upperbound(il_prac_ids) < 1 or upperbound(ii_screen_ids) < 1 then 
	return 0
end if 

Trigger Event ue_postupdate()

ii_facility_ids = ll_facility_ids
il_prac_ids = il_prac_ids
ii_screen_ids = li_screen_ids

Return 1

end event

event resize;call super::resize;//Start Code Change ----07.21.2017 #V154 maha - see cb_max button
long ll_w
long ll_h

ll_w = this.workspacewidth( )
ll_h = this.workspaceheight( )

tab_1.width = ll_w - 20
tab_1.height = ll_h - tab_1.y - 20

tab_1.tabpage_verif.dw_verif_list.height = tab_1.height - 190
tab_1.tabpage_verif.dw_verif_list.width = tab_1.width - 40
tab_1.tabpage_view.ole_browser.height = tab_1.tabpage_verif.dw_verif_list.height
tab_1.tabpage_view.ole_browser.width = tab_1.tabpage_verif.dw_verif_list.width
tab_1.tabpage_view.ole_browser2.height = tab_1.tabpage_verif.dw_verif_list.height
tab_1.tabpage_view.ole_browser2.width = tab_1.tabpage_verif.dw_verif_list.width
tab_1.tabpage_view.ole_image.height = tab_1.tabpage_verif.dw_verif_list.height
tab_1.tabpage_view.ole_image.width = tab_1.tabpage_verif.dw_verif_list.width


end event

type cb_max from commandbutton within w_web_crawler_verifications
integer x = 3579
integer y = 40
integer width = 270
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "EXPAND"
end type

event clicked;//Start Code Change ----07.23.2017 #V154 maha
long ll_h

if this.text = "EXPAND" then
	ll_h = w_mdi.height
	parent.height = ll_h - 120
	parent.y = 1
	this.text = "NORMAL"
else
	parent.height = il_orgh
	this.text = "EXPAND"
end if


end event

type rb_screenptint from radiobutton within w_web_crawler_verifications
integer x = 2350
integer y = 72
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Screen Print"
end type

type rb_webpage from radiobutton within w_web_crawler_verifications
integer x = 1993
integer y = 72
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Web Page"
boolean checked = true
end type

type gb_2 from groupbox within w_web_crawler_verifications
integer x = 1915
integer y = 12
integer width = 946
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Capture Format"
end type

type cb_1 from commandbutton within w_web_crawler_verifications
boolean visible = false
integer x = 4658
integer y = 152
integer width = 187
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cap 2"
end type

event clicked;//Start Code Change ----08.13.2012 #V12 maha
gs_pass_ids ls_pass_ids

ls_pass_ids.ls_doc_id = tab_1.tabpage_verif.dw_verif_list.getitemstring(tab_1.tabpage_verif.dw_verif_list.getrow(), "doc_id")
ls_pass_ids.ls_from_window = "Web Verifications"
ls_pass_ids.ls_image_available = False
openwithparm(w_capture_imacro,  ls_pass_ids)
end event

type st_reference from statictext within w_web_crawler_verifications
integer x = 846
integer y = 292
integer width = 2469
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cbx_select from checkbox within w_web_crawler_verifications
integer x = 3067
integer y = 184
integer width = 503
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select for Crawl"
end type

type tab_1 from tab within w_web_crawler_verifications
event create ( )
event destroy ( )
integer y = 284
integer width = 4521
integer height = 2180
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_verif tabpage_verif
tabpage_view tabpage_view
end type

on tab_1.create
this.tabpage_verif=create tabpage_verif
this.tabpage_view=create tabpage_view
this.Control[]={this.tabpage_verif,&
this.tabpage_view}
end on

on tab_1.destroy
destroy(this.tabpage_verif)
destroy(this.tabpage_view)
end on

event selectionchanged;if this.selectedtab = 1 then
	ls_current_print_object = "Ver Data"
else
	//ls_current_print_object = ''
	//ls_current_print_object = ls_view_print_object  //Start Code Change ----07.06.2011 #V11 maha delete by stephen 07.07.2011
end if
end event

type tabpage_verif from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4485
integer height = 2064
long backcolor = 33551856
string text = "Verifications"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_1 st_1
dw_verif_list dw_verif_list
end type

on tabpage_verif.create
this.st_1=create st_1
this.dw_verif_list=create dw_verif_list
this.Control[]={this.st_1,&
this.dw_verif_list}
end on

on tabpage_verif.destroy
destroy(this.st_1)
destroy(this.dw_verif_list)
end on

type st_1 from statictext within tabpage_verif
integer x = 23
integer y = 16
integer width = 4439
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = true
boolean focusrectangle = false
end type

type dw_verif_list from u_dw within tabpage_verif
integer x = 5
integer y = 100
integer width = 4471
integer height = 1964
integer taborder = 60
boolean titlebar = true
string title = "Web Verifications"
string dataobject = "d_web_crawler_ama_verif_info"
end type

event clicked;call super::clicked;hpb_1.Visible = False

IF GetClickedRow( ) > 0 THEN
	This.SelectRow( 0 , False )
	This.SelectRow( row, True )
	il_current_row = row //(Appeon)Stephen 10.22.2014 - BugS101401
END IF


end event

event doubleclicked;call super::doubleclicked;SetPointer( HourGlass! )
cb_capture.Enabled = False
String ls_name
string ls_file
integer li_type
integer li_res
string ls_null
string ls_reference
setnull(ls_null)

ls_name = dwo.name
//debugbreak()
//This.GetItemNumber( row, "verification_picture_flag" ) > 0 OR
IF ls_name = "p_view_image" THEN
	tab_1.tabpage_view.ole_browser.Visible = False
	tab_1.tabpage_view.ole_browser2.Visible = False	//alfee 08.11.2010
	tab_1.tabpage_view.ole_image.Visible = False
	cb_back.enabled = false
	cb_forward.enabled = false
	//Start Code Change ---- 02.26.2007 #V7 maha
	li_type = This.Getitemnumber( row, "verification_picture_flag")
	choose case li_type //get file name
		case 1,4 //, bmp
			ls_file = gs_temp_path + "_ResultPage.bmp"
		case 2
			ls_file = gs_temp_path + "_ResultPage.pdf"
		case 3
			ls_file = gs_temp_path + "_ResultPage.htm"
		case 5 //Start Code Change ----06.16.2016 #V152 maha - added for png
			ls_file =  gs_temp_path + "_ResultPage.png"
		case 7  //Start Code Change ----08.17.2017 #V154 maha - added for jpeg
			ls_file =  gs_temp_path + "_ResultPage.jpeg"
	end choose
	
	li_res = of_get_image( This.GetitemString( row, "doc_id"),ls_file )
	if li_res = 1 then
		IF FileExists( ls_file ) THEN
			choose case li_type
				case 1,4
					tab_1.tabpage_view.ole_image.Object.Image = ls_file		
					tab_1.tabpage_view.ole_image.Object.Display( )	
					tab_1.tabpage_view.ole_image.Visible = true
					ls_current_print_object = "Image"  //Start Code Change ----07.29.2009 #V92 maha
				case 2,3,5  //Start Code Change ----06.16.2016 #V152 maha - added for png
					tab_1.tabpage_view.ole_browser.Object.Navigate2( ls_file)
					tab_1.tabpage_view.ole_browser.Visible = true
					tab_1.tabpage_view.ole_browser.BringtoTop = true //alfee 08.11.2010
					tab_1.tabpage_view.ole_browser2.BringtoTop = False //alfee 08.11.2010						
					ls_current_print_object = "Browser"   //Start Code Change ----07.29.2009 #V92 maha
					//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_file , ls_Null, 4)
			end choose
			ls_view_print_object = ls_current_print_object   //Start Code Change ----07.06.2011 #V11 maha 
			tab_1.selecttab(2)
		END IF
	end if
	//End Code Change---02.26.2007
//This.GetItemNumber( row, "complete_status" ) = -3 OR
	
ELSEIF ls_name = "p_link" THEN
	//Start Code Change ----08.12.2009 #V92 maha
	ls_reference = tab_1.tabpage_verif.dw_verif_list.getitemstring(row,"full_name") + ": "
	ls_reference += tab_1.tabpage_verif.dw_verif_list.getitemstring(row,"reference_value")
	st_reference.text = ls_reference
	st_reference.visible = true
	//End Code Change---08.12.2009
	tab_1.tabpage_view.ole_image.Visible = False	
	tab_1.tabpage_view.ole_browser.Visible = True
	tab_1.tabpage_view.ole_browser.Object.Visible = True 
	//Start Code Change ----04.22.2016 #V15 maha - set to variable
	is_address = This.GetItemString( row, "web_address" )
	tab_1.tabpage_view.ole_browser.Object.Navigate(is_address)	
	//tab_1.tabpage_view.ole_browser.Object.Navigate( This.GetItemString( row, "web_address" ))	
	//End Code Change ----04.22.2016	
	
	tab_1.tabpage_view.ole_browser.BringtoTop = True //alfee 08.11.2010
	tab_1.tabpage_view.ole_browser2.BringtoTop = False //alfee 08.11.2010		
	cb_capture.Enabled = True
	ls_current_print_object = "Browser"   //Start Code Change ----07.29.2009 #V92 maha
	il_current_row = row
	tab_1.selecttab(2)
END IF
end event

event getfocus;call super::getfocus;ls_current_print_object = "Ver_Data"
end event

event itemchanged;call super::itemchanged;
IF This.GetColumnName() = "response_code" THEN
	Integer li_number_sent
	//---------Begin Modified by (Appeon)Stephen 2013-10-15 for3.	The verification attempts #error--------
	//li_number_sent = This.GetitemNumber( row, "number_sent" )
	li_number_sent = This.GetitemNumber( row, "number_sent",primary!, true)
	//---------End Modfiied ------------------------------------------------------

	li_number_sent++
	This.SetItem( row, "number_sent", li_number_sent )		
	This.SetItem( row, "date_recieved", Today( ) )
	This.SetItem( row, "last_sent", Today( ) )
	IF IsNull( This.GetItemDateTime( row, "first_sent" ) ) THEN
		This.SetItem( row, "first_sent", Today( ) )	
	END IF
	This.SetItem( row, "user_name", gs_user_id )	
END IF
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----11.11.2008 #V85 maha - added Select All option
long i
integer li_val
string ls_text
long ll_lucode

if dwo.name = "b_all" then 
	if dwo.text = "Select All" then
		ls_text = "Deselect All"
		li_val = 1
	else
		ls_text = "Select All"
		li_val = 0
	end if
	for i = 1 to this.rowcount()
		if this.getitemnumber(i,"complete_status") < 0 then
			//nothing
		else
			this.setitem(i,"selected",li_val)
		end if
	next
	dwo.text = ls_text
	//Start Code Change ----06.14.2013 #V14 maha
elseif dwo.name = "b_uplink" then 
	ll_lucode = this.getitemnumber(row,"address_lookup_code")
	if isnull(ll_lucode) then
		messagebox("Web Link","There is no Lookup record associated with this verification")
		return
	else
		openwithparm(w_web_link_update, ll_lucode)		
		debugbreak()
		ls_text = message.stringparm
		
		if ls_text = "Cancel" then
			//do nothing
		else
			this.setitem(row,"web_address",ls_text)	
			if len(ls_text) > 1 then 
				this.setitem(row,"complete_status", -3)	
			else
				this.setitem(row,"complete_status", -5)
			end if
		end if
			
	end if

	//End Code Change ----06.14.2013
end if
//End Code Change---11.11.2008
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Remember facility_id,prac_id,screen_id which have been modified
//						Copied from w_action_items.pfc_preupdate and modified.
//$<Author>: (Appeon) long.zhang 12.22.2016 (For Issue id 5443 - Verification Date on Appointment Screen doesn't populate SaaS 15.2 Build date 11172016)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rc
Integer i
Integer z
Integer li_cnt,li_seq
Long ll_prac_id
Long ll_prac_ids[]
long ll_ori,ll_cur
Long li_facility_id
Long li_facility_ids[]
Boolean lb_found
datetime ldt_today

li_seq = 1
ldt_today = datetime(today(),now())

ii_facility_ids = li_facility_ids
il_prac_ids = ll_prac_ids
li_rc = This.RowCount()

FOR i = 1 TO li_rc
	IF This.GetItemStatus( i, 0, Primary! ) = DataModified! THEN  //for verification update
		//modification tracking
		this.setitem( i , "verif_info_mod_date" , ldt_today)
		this.setitem( i , "verif_info_mod_user" , gs_user_id)

		IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
			//li_facility_id = This.GetItemNumber( i, "verif_info_facility_id" )
			li_facility_id = This.GetItemNumber( i, "facility_id" )
			ll_prac_id = This.GetItemNumber( i, "prac_id" )
			lb_found = False
			FOR z = 1 TO li_cnt
				IF li_facility_id = ii_facility_ids[ z ] AND ll_prac_id = il_prac_ids[ z ] THEN
					lb_found = True
					Exit
				END IF
			END FOR
			
			IF NOT lb_found THEN
				li_cnt++
				ii_facility_ids[ li_cnt ] = li_facility_id
				il_prac_ids[ li_cnt ] = ll_prac_id
				ii_screen_ids[li_cnt] = This.GetItemNumber( i, "screen_id" )
			END IF
		END IF
	End If
END FOR

Return 1
end event

type tabpage_view from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4485
integer height = 2064
long backcolor = 33551856
string text = "View/Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_geturl cb_geturl
ole_image ole_image
ole_browser2 ole_browser2
st_cap_mess st_cap_mess
ole_browser ole_browser
end type

on tabpage_view.create
this.cb_geturl=create cb_geturl
this.ole_image=create ole_image
this.ole_browser2=create ole_browser2
this.st_cap_mess=create st_cap_mess
this.ole_browser=create ole_browser
this.Control[]={this.cb_geturl,&
this.ole_image,&
this.ole_browser2,&
this.st_cap_mess,&
this.ole_browser}
end on

on tabpage_view.destroy
destroy(this.cb_geturl)
destroy(this.ole_image)
destroy(this.ole_browser2)
destroy(this.st_cap_mess)
destroy(this.ole_browser)
end on

type cb_geturl from commandbutton within tabpage_view
integer x = 4160
integer y = 16
integer width = 297
integer height = 88
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get URL"
end type

event clicked;string s
s = ole_browser.object.LocationURL

clipboard(s)

messagebox("On Clipboard", s)

end event

type ole_image from olecustomcontrol within tabpage_view
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
integer x = 41
integer y = 124
integer width = 3415
integer height = 1932
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_web_crawler_verifications.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click();hpb_1.Visible = False
end event

event getfocus;ls_current_print_object = "IMAGE"
end event

type ole_browser2 from olecustomcontrol within tabpage_view
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
integer y = 116
integer width = 4105
integer height = 1952
integer taborder = 50
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_web_crawler_verifications.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);//alfee 08.11.2010
CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
	cb_back.enabled = enable
END CHOOSE
end event

event beforenavigate2(oleobject pdisp, any url, any flags, any targetframename, any postdata, any headers, ref boolean ab_cancel);//alfee 08.11.2010
ole_browser2.X = ole_browser.X
ole_browser2.Y = ole_browser.Y
ole_browser2.Width = ole_browser.Width
ole_browser2.Height = ole_browser.Height

ole_browser2.BringToTop = TRUE
ole_browser.BringToTop = FALSE
end event

event navigatecomplete2(oleobject pdisp, any url);of_SetErrorEvent(this.object) //(Appeon)Stephen 11.02.2017 - V16.1-Web Capture Redesign
end event

event windowclosing(boolean ischildwindow, ref boolean ab_cancel);//alfee 08.11.2010
ole_browser.bringtotop = true
ole_browser2.bringtotop = false
end event

type st_cap_mess from statictext within tabpage_view
integer y = 20
integer width = 4155
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean border = true
boolean focusrectangle = false
end type

type ole_browser from olecustomcontrol within tabpage_view
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
integer x = 5
integer y = 116
integer width = 4457
integer height = 1948
integer taborder = 40
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_web_crawler_verifications.win"
integer binaryindex = 2
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

ole_browser2.Visible = True
ole_browser2.object.RegisterAsBrowser = True
ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button
of_SetErrorEvent(this.object) //(Appeon)Stephen 11.02.2017 - V16.1-Web Capture Redesign

end event

type st_3 from statictext within w_web_crawler_verifications
integer x = 293
integer y = 196
integer width = 1266
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "= Image connected to record; Double-click to view"
boolean focusrectangle = false
end type

type st_2 from statictext within w_web_crawler_verifications
integer x = 1737
integer y = 188
integer width = 1211
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "= Web Address available; Double-click to browse"
boolean focusrectangle = false
end type

type p_2 from picture within w_web_crawler_verifications
integer x = 183
integer y = 184
integer width = 96
integer height = 76
string picturename = "sectiongreen.png"
boolean focusrectangle = false
end type

type p_1 from picture within w_web_crawler_verifications
integer x = 1614
integer y = 184
integer width = 96
integer height = 68
string picturename = "linked.bmp"
boolean focusrectangle = false
end type

type cbx_ama from checkbox within w_web_crawler_verifications
boolean visible = false
integer x = 4000
integer y = 832
integer width = 169
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Verify Using AMA"
end type

event clicked;//IF This.Checked THEN
//	dw_verif_list.Modify("DataWindow.Header.1.Height='75'")
//	dw_verif_list.SetSort( "full_name A, completed_status A, screen_name A, reference_value A" )	
//	IF dw_ama.RowCount( ) = 0 THEN
//		Integer li_rc
//		Integer i
//		Integer li_array_size
//		Integer a
//		Integer li_nr
//		Integer li_cnt
//		Integer li_facility_ids[]
//		Long ll_temp_prac_id
//		Long ll_prac_ids[ ]
//		String ls_names[]
//		Boolean lb_found = False
//	
//		li_rc = dw_verif_list.RowCount( )
//	
//		FOR i = 1 TO li_rc
//			lb_found = False
//			ll_temp_prac_id = dw_verif_list.GetItemNumber( i, "prac_id" )
//			li_array_size = UpperBound( ll_prac_ids )
//		
//			FOR a = 1 TO li_array_size
//				IF ll_temp_prac_id = ll_prac_ids[ a ] THEN
//					lb_found = True
//				END IF
//			END FOR
//		
//			IF NOT lb_found THEN
//				li_cnt++
//				ll_prac_ids[  li_cnt ] = ll_temp_prac_id
//				li_facility_ids[ li_cnt ] = dw_verif_list.GetItemNumber( i, "facility_id" )
//				ls_names[li_cnt] = dw_verif_list.GetItemString( i, "full_name" )
//			END IF
//		END FOR
//	
//		FOR i = 1 TO li_cnt
//			li_nr = dw_ama.InsertRow( 0 )
//			dw_ama.SetItem( li_nr, "prac_id", ll_prac_ids[ i ] )
//			dw_ama.SetItem( li_nr, "facility_id", li_facility_ids[i] )
//			dw_ama.SetItem( li_nr, "full_name", ls_names[i] )
//		END FOR
//		dw_verif_list.Visible = False
//	     dw_ama.Visible = True	
//		  
//		 st_1.Text =  String( li_cnt ) + " practitioners.  To run an AMA profile for a practitioner, Click on the check box next to their name then click Crawl button to run AMA web crawler."
//	ELSE
//		dw_verif_list.Visible = False
//		dw_ama.Visible = True	
//	END IF
//ELSE
//		dw_verif_list.Modify("DataWindow.Header.1.Height='0'")
//		dw_verif_list.SetSort( "completed_status A, screen_name A, reference_value A" )	
//		dw_verif_list.Visible = True
//		dw_ama.Visible = False
//END IF
//
//dw_verif_list.Sort( )
end event

type cbx_show from checkbox within w_web_crawler_verifications
integer x = 50
integer y = 60
integer width = 425
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
boolean lefttext = true
end type

type cb_save from commandbutton within w_web_crawler_verifications
integer x = 869
integer y = 40
integer width = 325
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Parent.Event pfc_Save()
end event

type cb_close from commandbutton within w_web_crawler_verifications
integer x = 4192
integer y = 40
integer width = 325
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close( Parent )
end event

type cb_print from commandbutton within w_web_crawler_verifications
integer x = 3858
integer y = 40
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign --------
n_bitmap ln_bitmap
blob  lbl_data
string ls_Text, ls_FileName, ls_PdfName, ls_Null
n_cst_image_functions_cp   ln_pdf
//---------End Added ------------------------------------------------------


debugbreak()
CHOOSE CASE Upper(ls_current_print_object)
	CASE "VER DATA"
		 tab_1.tabpage_verif.dw_verif_list.Print( )
	CASE "EXCEPTIONS"
		
	CASE "BROWSER"  //Start Code Change ----07.29.2009 #V92 maha
	
		 //----Begin Modified by alfee 08.11.2010 --------
		 IF tab_1.tabpage_view.ole_browser.BringtoTop = True THEN
			  //tab_1.tabpage_view.ole_browser.print( 1, 50, 50)        delete by Stephen 07.07.2011
			 tab_1.tabpage_view.ole_browser.object.execwb(6,2 ) // add by Stephen 07.07.2011 No print function in "go to web" Verifications bug 2503
		 ELSEIF tab_1.tabpage_view.ole_browser2.BringtoTop = True THEN
			 //tab_1.tabpage_view.ole_browser2.print( 1, 50, 50)    delete by Stephen 07.07.2011
			 
			 //------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 05.23.2016
			//<$>reason:Change ole_browser to ole_browser2, for Verifications printing home page of website, not captured image Case#63993 Bug_Id#5170
			 //tab_1.tabpage_view.ole_browser.object.execwb(6,2 ) // add by Stephen 07.07.2011 No print function in "go to web" Verifications bug 2503
			 tab_1.tabpage_view.ole_browser2.object.execwb(6,2 )
			 //------------------- APPEON END -------------------
	    END IF
		 //tab_1.tabpage_view.ole_browser.print( 1, 50, 50)
		 //----End Modified ------------------------------

	CASE "IMAGE"
		//--------Begin Modified by  Nova 05.05.2010------------------------
		// tab_1.tabpage_view.ole_image.Object.PrintImage()
		tab_1.tabpage_view.ole_image.Object.PrintImage(1,tab_1.tabpage_view.ole_image.Object.PageCount,3)
		//--------End Modified --------------------------------------------
 		//Navigate("www.intellisoftgroup.com")							
		

END CHOOSE

end event

type cb_crawl from commandbutton within w_web_crawler_verifications
integer x = 512
integer y = 40
integer width = 343
integer height = 92
integer taborder = 10
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
Integer li_wc_id
Integer li_facility_id
Integer li_cnt
Boolean lb_show
Long ll_prac_id
Long ll_retval
Integer li_crawl
integer li_type
String ls_doc_id
string ls_emes
string ls_ret
long   ll_rec_id

li_rc = idw_verif_list.RowCount( )

nvo_web_crawler_engine lnvo_web_crawler

//web_crawler id, doc_id, facility_id, prac_id

FOR i = 1 TO li_rc
	IF idw_verif_list.GetItemNumber( i, "selected" ) = 1 THEN
		li_cnt++
	END IF
END FOR

if Not isvalid( w_infodisp ) then open(w_infodisp)
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.title = "Running WebCrawlers"
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = "Running" 
if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,li_cnt)

hpb_1.MinPosition = 1
hpb_1.MaxPosition = li_cnt * 50

hpb_1.SetStep = 50

IF cbx_show.Checked THEN
	lb_show = True	
END IF

IF li_rc > 0 THEN
	hpb_1.Visible = True
END IF

FOR i = 1 TO li_rc	

	SetPointer( HourGlass! )
	
	IF idw_verif_list.GetItemNumber( i, "selected" ) = 0 THEN
		CONTINUE
	END IF
	
	idw_verif_list.SelectRow( 0, False )
	idw_verif_list.SelectRow( i, True )
	idw_verif_list.ScrolltoRow( i )  //Start Code Change ----11.22.2013 #V14 maha
	
	li_crawl++
	
	 tab_1.tabpage_verif.st_1.Text = "Verifying credential " + String( li_crawl ) + " of " + String( li_cnt )
	if isvalid(w_infodisp) then w_infodisp.st_1.text = "Running crawler for " +  idw_verif_list.getitemstring(i,"full_name")
	
	idw_verif_list.SetItem( i, "complete_status", 99 )
	
	li_wc_id = idw_verif_list.GetItemNumber( i, "web_crawler_id" )
	ls_doc_id = idw_verif_list.GetItemString( i, "doc_id" )
	ll_prac_id = idw_verif_list.GetItemNumber( i, "prac_id" )
	li_facility_id = idw_verif_list.GetItemNumber( i, "facility_id" )
	ll_rec_id =  idw_verif_list.GetItemNumber( i, "rec_id" )  //add by Stephen 07.02.2012  -V12.2 WebCrawler extract data


//Start Code Change ----11.22.2013 #V14 maha - trap for 0 id
	if li_wc_id = 0 then
		if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		continue
	end if
//End Code Change ----11.22.2013		

	ls_ret = lnvo_web_crawler.of_crawl_new( li_wc_id,  ll_prac_id,ls_doc_id , lb_show, ll_rec_id, li_facility_id )  //modify by Stephen 07.02.2012 - add rec_id, facility_id  -V12.2 WebCrawler extract data

	//-------------Begin Modified by Alfee 02.08.2010 ---------------------
	//Set verif rec after Web Crawl - reorganized for scheduler	
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
	lnvo_web_crawler.of_set_verifs_aftercrawl( idw_verif_list, ls_ret, i)
	
	/* ll_retval = long(mid(ls_ret,1,pos(ls_ret,"*",1) - 1))
	li_type = integer(mid(ls_ret,pos(ls_ret,"*",1)  + 1))
	if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
	
	IF ll_retval = 1 THEN
		idw_verif_list.SetItem( i, "complete_status", 1 )
		idw_verif_list.SetItem( i, "verification_picture_flag", li_type ) //set so the picture button is visible
	ELSEIF ll_retval = 3 THEN
		idw_verif_list.SetItem( i, "complete_status", 3 )
		idw_verif_list.SetItem( i, "verification_picture_flag", li_type )
		ls_emes = of_error_message(ll_retval )
		idw_verif_list.SetItem( i, "verif_info_notes", ls_emes + " - " + idw_verif_list.GetItemstring( i, "verif_info_notes" ) )	
	ELSEIF ll_retval > 1 THEN
		idw_verif_list.SetItem( i, "response_code", ll_retval )
		idw_verif_list.SetItem( i, "complete_status", 2 )
		idw_verif_list.SetItem( i, "verification_picture_flag", li_type )
		li_number_sent = idw_verif_list.GetitemNumber( i, "number_sent" )
		li_number_sent++
		idw_verif_list.SetItem( i, "number_sent", li_number_sent )		
		idw_verif_list.SetItem( i, "date_recieved", Today( ) )
		idw_verif_list.SetItem( i, "last_sent", Today( ) )
		IF IsNull( idw_verif_list.GetItemDateTime( i, "first_sent" ) ) THEN
			idw_verif_list.SetItem( i, "first_sent", Today( ) )	
		END IF
		idw_verif_list.SetItem( i, "user_name", gs_user_id )	
	elseif ll_retval < 0 then //maha 02.27.07
		idw_verif_list.SetItem( i, "complete_status", -1 )
		ls_emes = of_error_message(ll_retval )
		idw_verif_list.SetItem( i, "verif_info_notes", ls_emes + " - " + idw_verif_list.GetItemstring( i, "verif_info_notes" ) )	
	END IF */
	//-------------End Modified -----------------------------------

	//	IF ll_retval > 0 THEN //maha removed 022607 redundant and inaccurate code
	//		idw_verif_list.SetItem( i, "verification_picture_flag", 1 )
	//	END IF

	hpb_1.Position = li_crawl * 50		
	idw_verif_list.SetItem( i, "selected", 0 )	
END FOR

//Beep(1)
//hpb_1.Visible = False

hpb_1.Visible = False
if isvalid( w_infodisp ) then close(w_infodisp)
tab_1.tabpage_verif.st_1.Text = "Web Crawl Complete."


end event

type hpb_1 from hprogressbar within w_web_crawler_verifications
boolean visible = false
integer x = 4105
integer y = 708
integer width = 73
integer height = 64
unsignedinteger maxposition = 100
integer setstep = 10
boolean smoothscroll = true
end type

type dw_ama from u_dw within w_web_crawler_verifications
boolean visible = false
integer x = 3986
integer y = 364
integer width = 192
integer height = 300
integer taborder = 30
boolean titlebar = true
string title = "Web Verifications"
string dataobject = "d_select_prac_for_ama_crawl"
boolean resizable = true
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.22.2006 By: Liang QingShi
//$<reason> Performance tuning.
//$<modification> There is no need to update dw_ama after analysis.
this.of_setupdateable( false)
//---------------------------- APPEON END ----------------------------

end event

type gb_1 from groupbox within w_web_crawler_verifications
integer x = 50
integer y = 132
integer width = 3744
integer height = 136
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Actions:"
end type

type st_datestamp from statictext within w_web_crawler_verifications
boolean visible = false
integer width = 4535
integer height = 384
integer textsize = -15
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_forward from commandbutton within w_web_crawler_verifications
integer x = 1582
integer y = 44
integer width = 325
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Forward >>"
end type

event clicked;//---------Begin Modified by alfee 08.11.2010 --------
If tab_1.tabpage_view.ole_browser.bringtotop = True Then
	tab_1.tabpage_view.ole_browser.object.goforward()
ElseIf tab_1.tabpage_view.ole_browser2.bringtotop = True Then
	tab_1.tabpage_view.ole_browser2.object.goforward()
End If
//tab_1.tabpage_view.ole_browser.object.goforward()
//---------End Modified ------------------------------

end event

type cb_back from commandbutton within w_web_crawler_verifications
integer x = 1243
integer y = 44
integer width = 325
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "<< Back"
end type

event clicked;try
	//---------Begin Modified by alfee 08.11.2010 --------
	If tab_1.tabpage_view.ole_browser.bringtotop = True Then
		tab_1.tabpage_view.ole_browser.object.goback()
	ElseIf tab_1.tabpage_view.ole_browser2.bringtotop = True Then
		tab_1.tabpage_view.ole_browser2.object.goback()
	End If
	//tab_1.tabpage_view.ole_browser.object.goback()
	//---------End Modified ------------------------------	
catch (RuntimeError e) // Add by Evan on 10.19.2009
end try
end event

type cb_2 from commandbutton within w_web_crawler_verifications
integer x = 2761
integer y = 44
integer width = 87
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;string s

s = "Capture HTML will capture the source on the Web Page viewed but will not capture pictures.~r~rCapture Screen will save a screen print of the page, but only that which is viewed.  The file will be hundreds of times larger than the HTML Version, and will take longer to view, print, etc."

messagebox("About Capture",s)
end event

type cb_capture from commandbutton within w_web_crawler_verifications
integer x = 2875
integer y = 44
integer width = 352
integer height = 92
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Capture"
end type

event clicked;//Start Code Change ----07.10.2014 #V14.2 maha - added alternative capture method
String ls_fname
Blob lblb_bitmap
n_bitmap in_bitmap
n_runandwait in_runandwait
String is_tempdir
string ls_doc_id
string ls_text
string ls_notes  //maha 04.22.2016
string ls_FileName, ls_PdfName, ls_PathFile
n_cst_image_functions_cp ln_pdf //Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
Integer	li_rc

if il_current_row < 1 then return //(Appeon)Stephen 10.22.2014 - BugS101401
if rb_webpage.checked then
	Return of_Capture() //Add by Evan 03.26.2009
else
	SetPointer(HourGlass!)
	
	//ls_fname = gs_dir_path + "intellicred\webcapt.bmp" //Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
	//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
	ls_pathFile =gs_dir_path + "intellicred\webcapt.pdf" 
//	li_rc = GetFileSaveName ( "Select File", ls_pathFile, ls_fname, "BMP", "BMP Files (*.BMP),*.BMP,PDF Files (*.PDF),*.PDF" , gs_dir_path+"intellicred\",  32770)
//	If li_Rc <> 1 Then
//		Return
//	End If	
	//---------End Added ------------------------------------------------------
	
	//ls_text = "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now())
	ls_text = "Captured by: " + gs_user_id + "         Date: " + string(today()) + " " +  string(Now()) + "   " + is_address  //Start Code Change ----07.21.2017 #V154 maha - added link to stamp
	st_datestamp.text = ls_text
	st_datestamp.visible = true
	st_datestamp.bringtotop = true
	tab_1.tabpage_view.cb_geturl.visible = false  //Start Code Change ----07.25.2017 #V154 maha
	
//	lblb_bitmap = in_bitmap.of_WindowCapture(Parent, False)  //Commented by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign
	
	//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
	ls_FileName = gs_dir_path + "intellicred\webpageprint.bmp"
	
	IF tab_1.tabpage_view.ole_browser.BringtoTop = True THEN
		lblb_bitmap= in_bitmap.of_scroll_capturescreen( tab_1.tabpage_view.ole_browser, st_datestamp )
	ELSEIF tab_1.tabpage_view.ole_browser2.BringtoTop = True THEN
		lblb_bitmap= in_bitmap.of_scroll_capturescreen( tab_1.tabpage_view.ole_browser2, st_datestamp )
	END IF		
			
	//---------End Added ------------------------------------------------------
		
	st_datestamp.visible = false
	st_datestamp.bringtotop = false
	tab_1.tabpage_view.cb_geturl.visible = true  //Start Code Change ----07.25.2017 #V154 maha
	Parent.SetRedraw( true )
	//---------Begin Added by (Appeon)Gavin 11.10.2017 for V16.1 Web Capture Redesign--------
	If Upper(Right( ls_fname, 3 )) = "BMP" Then
		in_bitmap.of_WriteBlob(ls_pathFile, lblb_bitmap)
	Else
		in_bitmap.of_WriteBlob(ls_FileName, lblb_bitmap)
		ln_pdf = create n_cst_image_functions_cp
		ln_pdf.of_convert2pdf( ls_FileName, ls_pathFile )
	
		If IsValid( ln_pdf) Then Destroy ln_pdf
	End If	
	//---------End Added ------------------------------------------------------

	tab_1.tabpage_view.st_cap_mess.text = "Web Page Captured"
	ls_doc_id = idw_verif_list.GetItemString(il_current_row, "doc_id")
	
	UPDATEBLOB verif_info
	SET verification_picture = :lblb_bitmap
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
	tab_1.tabpage_view.st_cap_mess.text = "Database Updated With Web Screen Shot."
	
	UPDATE verif_info
	SET verification_picture_flag = 3
	WHERE doc_id = :ls_doc_id
	USING SQLCA;
	if SQLCA.SQLCode = -1 then
		ROLLBACK USING SQLCA;
		MessageBox("SQL Error", SQLCA.SQLErrText)
		Return -1
	end if
	idw_verif_list.SetItem(il_current_row, "verification_picture_flag", 4)
	
	//Start Code Change ----04.22.2016 #V15 maha
	ls_notes = idw_verif_list.getItemstring(il_current_row, "verif_info_notes")
	if isnull(ls_notes) then ls_notes = ""
	ls_notes = ls_text + " - Website: " + is_address + " - " + ls_notes
	idw_verif_list.SetItem(il_current_row, "verif_info_notes", ls_notes)
	//End Code Change ----04.22.2016
	
	//Start Code Change ----08.17.2017 #V154 maha - stamp upload values
	idw_verif_list.SetItem( il_current_row, "image_stamp", datetime( today(), Now()) ) 
	idw_verif_list.SetItem( il_current_row, "image_stamp_user", gs_user_id )
	idw_verif_list.SetItem( il_current_row, "image_stamp_site", "Capture: " + is_address)
	//End Code Change ----08.17.2017 
	
	//MessageBox("Capture", "Update successfully!")
	MessageBox("Capture", "Update successful!") //Modified by Appeon long.zhang 09.09.2014 (v14.2 update successfully->update successful)
end if

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_web_crawler_verifications.bin 
2400000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000f0d06c7001d3780f00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000f0d06c7001d3780ff0d06c7001d3780f000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00005cd0000032700000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00005cd0000032700000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c04600000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000f0d06c7001d3780f00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000f0d06c7001d3780ff0d06c7001d3780f000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
20ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000064c5000032550000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000064c5000032550000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c04600000000000080000000000000000000000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_web_crawler_verifications.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
