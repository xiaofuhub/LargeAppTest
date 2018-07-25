$PBExportHeader$pfc_cst_u_wf_provider.sru
forward
global type pfc_cst_u_wf_provider from userobject
end type
type dw_detail from u_dw within pfc_cst_u_wf_provider
end type
type dw_app from u_dw within pfc_cst_u_wf_provider
end type
type dw_cred from u_dw within pfc_cst_u_wf_provider
end type
end forward

global type pfc_cst_u_wf_provider from userobject
integer width = 4293
integer height = 2004
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_detail dw_detail
dw_app dw_app
dw_cred dw_cred
end type
global pfc_cst_u_wf_provider pfc_cst_u_wf_provider

type variables
long il_prac_id //Added by Appeon long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
end variables

forward prototypes
public function integer of_set_prac_id (long al_prac_id)
public function integer of_retrieve ()
public function integer of_hide_view ()
public function integer of_read_only ()
public function integer of_bg_color (long al_rgb)
public function integer of_post_resize ()
end prototypes

public function integer of_set_prac_id (long al_prac_id);//====================================================================
//$<Function>: of_set_prac_id
//$<Arguments>:
// 	value    long    al_prac_id
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
il_prac_id = al_prac_id
return 1
end function

public function integer of_retrieve ();//====================================================================
//$<Function>: of_retrieve
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//gnv_appeondb.of_startqueue( )
//
//	dw_direct.retrieve( il_prac_id,gs_user_id )
//	
//	dw_location.retrieve( il_prac_id,gs_user_id )
//	
//gnv_appeondb.of_commitqueue( )

return 1
end function

public function integer of_hide_view ();//====================================================================
//$<Function>: of_hide_view
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//if w_mdi.of_security_access(7741) = 0 then
//		dw_direct.modify( "b_view.visible='0'")
//		dw_location.modify( "b_view.visible='0'")
//end if

return 1
end function

public function integer of_read_only ();//====================================================================
//$<Function>: of_read_only
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Harry 10.15.2014 for BugA101403
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//if w_mdi.of_security_access(7731) = 1 then
//		dw_direct.modify("DataWindow.ReadOnly='Yes'")
//		dw_location.Modify("DataWindow.ReadOnly='Yes'")
//end if

return 1
end function

public function integer of_bg_color (long al_rgb); //Start Code Change ----09.09.2015 #V15 maha
this.backcolor = al_rgb

return 1
end function

public function integer of_post_resize ();//Start Code Change ----02.04.2016 #V15 maha
long ll_w
long ll_h


	ll_w = this.width - 60
	ll_h = this.height / 2 - 60
	
	dw_cred.width = ll_w 
	dw_cred.height = ll_h
	
	dw_app.y = dw_cred.y + ll_h + 16
	dw_app.width = ll_w 
	dw_app.height = ll_h


return 1
end function

on pfc_cst_u_wf_provider.create
this.dw_detail=create dw_detail
this.dw_app=create dw_app
this.dw_cred=create dw_cred
this.Control[]={this.dw_detail,&
this.dw_app,&
this.dw_cred}
end on

on pfc_cst_u_wf_provider.destroy
destroy(this.dw_detail)
destroy(this.dw_app)
destroy(this.dw_cred)
end on

event constructor;//Start Code Change ----07.12.2017 #V16 maha
end event

type dw_detail from u_dw within pfc_cst_u_wf_provider
event ue_after_row_focus_changed ( )
event type long ue_clicked ( integer xpos,  integer ypos,  long row,  dwobject dwo )
integer x = 974
integer width = 3287
integer height = 936
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Appointment Actions"
string dataobject = "d_ver_summary_record_view"
boolean border = false
end type

event ue_after_row_focus_changed;IF This.GetColumnName( ) = "notes" THEN
	This.SetColumn( "first_sent" )
END IF


end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----02.08.2016 #V15 maha - moved to clicked event


////Start Code Change ---- 01.29.2007 #V7 maha
//IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
//	Long ll_verification_id
//	gs_pass_ids ls_pass_ids
//	integer li_type
//	string ls_file
//	//messagebox(string(row), "ff")
//	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
//	choose case li_type
//		case 4
//			ls_file = "display.bmp"
//		case 2
//			ls_file = "display.pdf"
//		case 3
//			ls_file = "display.htm"
//	end choose
//	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
//	
//	ls_pass_ids.ls_doc_id = This.GetItemString( row, "doc_id" )
//	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	ls_pass_ids.ll_verification_id = ll_verification_id
//	
//	
//	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
//	
//	if li_type > 1 then
//		inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//	else
//		IF Not IsValid( w_capture ) THEN
//			OpenWithParm( w_capture,  ls_pass_ids )
//		ELSE
//			w_capture.of_setup( ls_pass_ids )
//		END IF
//	end if
//END IF
////End Code Change---01.09.2007
//
////------------------- APPEON BEGIN -------------------
////$<Modify> 04.16.2010 By: Evan
////$<Reason> V10.1 - NPDB QRXS
///*
//if dwo.name  = "b_npdb" then
//  //window w_npdb_report
//  OpenSheetWithParm(w_npdb_report, dw_detail.GetItemstring( row, "DOC_id"), "w_npdb_report", w_mdi, 0, original!)
//end if
//*/
//string ls_doc_id
//integer li_Interface
//if dwo.name = "b_npdb" then
//	ls_doc_id = dw_detail.GetItemString(Row, "doc_id")
//	li_Interface = of_get_app_setting("set_8", "I")
//	choose case li_Interface
//		case 1 //ITP_INTERFACE
//			OpenSheetWithParm(w_npdb_report, ls_doc_id, "w_npdb_report", w_mdi, 0, original!)
//		case 2 //QRXS_INTERFACE
//			if not IsValid(w_npdb_reports) then Open(w_npdb_reports)
//			w_npdb_reports.SetFocus()
//			w_npdb_reports.of_show_prac_rpts(ls_doc_id)
//	end choose
//end if
////------------------- APPEON END ---------------------
//
//Start Code Change ----08.04.2009 #V92 maha - added expanded notes
//Start Code Change ----02.08.2016 #V15 maha - moved notes code to clicked event
//IF dwo.name = 'b_notes' THEN
//	string s
//	//------Begin Modified by Alfee 01.15.2010 ---------------
//	//<$Reason> for a richtext bug in APB 6.0 
//		//Start Code Change ----09.12.2012 #V12 maha - new exp. notes screen
//
//	//---------Begin Modified by (Appeon)Harry 07.17.2014  for the Bug 4115
//	//OpenWithParm( w_ai_notes_new, "V#" +  This.GetItemString( row, "notes" ))
//	string ls_notes
//	ls_notes = This.GetItemString( row, "notes" )
//	if isnull(ls_notes) then ls_notes = ""
//	OpenWithParm( w_ai_notes_new,  "V#" + ls_notes)
//	//---------End Modfiied ------------------------------------------------------	
////	IF appeongetclienttype() = 'WEB' THEN  
////		//OpenWithParm( w_ai_notes_web, "V" + This.GetItemString( row, "notes" ))
////		OpenWithParm( w_ai_notes_web, "V#" + This.GetItemString( row, "notes" ))
////	ELSE		
////		//OpenWithParm( w_ai_notes, "V" + This.GetItemString( row, "notes" ))//Start Code Change ----03.03.2011 #V11 maha - added V to front
////		OpenWithParm( w_ai_notes, "V#" + This.GetItemString( row, "notes" )) //Changed by long.zhang 08.25.2011 added V# to front
////	END IF		
//	//OpenWithParm( w_ai_notes, This.GetItemString( row, "notes" ))
//	//------End Modified --------------------------------------		
//
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		s = Message.StringParm
////		if LenA(s) > 255 then  //Start Code Change ----11.4.2010 #V10 maha - removed with change to varchar
////			s = MidA(s,1,255)
////			messagebox("Notes","This Notes field is limited to 255 characters.")
////		end if
//		//This.SetItem( row, "notes", s )
//		 if this.getitemnumber( row, "active_status") <> 0 then This.SetItem( row, "notes", s )	//long.zhang 10.19.2012 history record do not set notes BugL100905
//	END IF
//End if
//End Code Change---08.04.2009
//
//IF dwo.name = 'b_web' THEN
//	//debugbreak()
//	gs_passstring[1] = dw_detail.GetItemString(Row, "doc_id")
//	gs_passstring[2] =  string(dw_detail.GetItemnumber(Row, "rec_id"))
//	gs_passstring[3] =  string(dw_detail.GetItemnumber(Row, "prac_id"))
//	gs_passstring[4] =  string(dw_detail.GetItemnumber(Row, "screen_id"))
//	gs_passstring[5] =  string(dw_detail.GetItemnumber(Row, "parent_facility_id"))
//	
//	open(w_wc_accept_data_verif)
//end if
//	
end event

event clicked;////Start Code Change ----05.05.2008 #V8 maha - changed to variable rather than repeating getclickedrow function
//integer r
//long res
//long ll_ver_method //maha 07.15.2016
//long ll_facil
//string ls_path
//
//r = This.GetClickedRow()
//IF r > 0 THEN
//	This.SetRow( r)
//END IF
////End Code Change---05.05.2008
//
////Start Code Change ----02.08.2016 #V15 maha -  moved from buttonclicked
//IF dwo.name = 'b_notes' THEN
//	string s
//	
//	s = This.GetItemString( row, "notes" )
//	if isnull(s) then s = ""
//	OpenWithParm( w_ai_notes_new,  "V#" + s)
//
//	IF Message.StringParm = "Cancel" THEN
//		Return -1
//	ELSE
//		s = Message.StringParm
//
//		 if this.getitemnumber( row, "active_status") <> 0 then This.SetItem( row, "notes", s )	//long.zhang 10.19.2012 history record do not set notes BugL100905
//	END IF
//End if
//
//this.Event ue_Clicked(xPos, yPos, Row, DWO) //Add by Evan 05.11.2009 --- Corrected BugG061301. Register for due date only.
//
//
////Start Code Change ---- 01.29.2007 #V7 maha
//IF dwo.name  = "image_data" OR dwo.name = "image_button_no_image" THEN
//	Long ll_verification_id
//	gs_pass_ids ls_pass_ids
//	integer li_type
//	string ls_file
//	string ls_ext
//	string ls_docid
//	//messagebox(string(row), "ff")
//	li_type = dw_detail.GetItemNumber( row,"verification_picture_flag")
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
//		Case 7  //Start Code Change ----10.24.2016 #V152 maha
//			ls_file = "display.jpg"	
//	end choose
//	
//	ll_verification_id = dw_detail.GetItemNumber( row, "address_lookup_code")
//	
//	ll_ver_method = This.GetItemnumber( row, "verification_method" )  //Start Code Change ----07.15.2016 #V153 maha
//	
//	ls_docid = This.GetItemString( row, "doc_id" )
//	ls_pass_ids.ls_doc_id = ls_docid
//	ls_pass_ids.ls_ref_value = This.GetItemString( row, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	ls_pass_ids.ll_verification_id = ll_verification_id
//	
//	IF This.GetItemNumber( row, "verification_picture_flag" ) = 1 THEN		
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
//	
//	//debugbreak()
//	
//	//------------------- APPEON BEGIN -------------------
//	//<$>added:long.zhang 06.14.2016
//	//<$>reason:Restore if statement (Missing Capture Software Case#64368 Bug_id#5190)
//
////	//Start Code Change ----05.31.2016 #V152 maha - changed to case statement
////	//if li_type > 1 then  
////	Choose case li_type
////		case 1, 6 , 2 , 3, 4, 5 //add 2,3,4,5 by Appeon long.zhang 06.08.2016 (Missing Capture Software Case#64368 Bug_id#5190)
////			inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
////		case else
////			IF Not IsValid( w_capture ) THEN
////				OpenWithParm( w_capture,  ls_pass_ids )
////			ELSE
////				w_capture.of_setup( ls_pass_ids )
////			END IF
////	End choose
////	//end if
////Start Code Change ----10.24.2016 #V152 maha - split code for the two buttons
//	if dwo.name = "image_button_no_image" THEN
//		if w_mdi.of_security_access(150) = 0 then return 
//		ls_path = getcurrentdirectory() //(Appeon)Stephen 02.25.2017 - BugS022206
//		ls_ext = inv_action_items.of_upload_document( This.GetItemString( row, "doc_id" )) 
//		ChangeDirectory(ls_path)  //(Appeon)Stephen 02.25.2017 - BugS022206
//		if ls_ext = "F" then 
//			//failed
//		else
//			choose case upper(ls_ext)
//				case "XML"
//					li_type = 6
//				case "PNG"
//					li_type = 5
//				case "BMP"
//					li_type = 4
//				case "HTM"
//					li_type = 3
//				case "PDF"
//					li_type = 2
//				case "JPG"
//					li_type = 7
//			end choose
//			 dw_detail.SetItem( row,"verification_picture_flag", li_type)
//			 dw_detail.update()
//		end if
//		
//	else  //display image
//	//Start Code Change ----07.15.2016 #V153 maha - for AMA xml 
//		if ll_ver_method = -570 and li_type = 6 then  //AMA & XML
//			//Start Code Change ----10.20.2016 #V153 maha - change to use ama verif window
//			ll_facil = dw_orgs_facilities.GetItemNumber( dw_orgs_facilities.getrow()  , "verifying_facility" )
//			of_get_ama_verifs(ll_facil)
//			//End Code Change ----10.20.2016 
//		else
//			if li_type > 1 then
//				inv_action_items.of_display_web_image(ls_pass_ids.ls_doc_id, ls_file)
//			else
//				IF Not IsValid( w_capture ) THEN
//					OpenWithParm( w_capture,  ls_pass_ids )
//				ELSE
//					w_capture.of_setup( ls_pass_ids )
//				END IF
//			end if
//		end if
//	//End Code Change ----07.15.2016
//	End if
////End Code Change ----10.24.2016	
//	//------------------- APPEON END -------------------
//END IF
////End Code Change---01.29.2007
//
//
//string ls_doc_id
//integer li_Interface
//if dwo.name = "b_npdb" then
//
//	ls_doc_id = dw_detail.GetItemString(Row, "doc_id")
//	li_Interface = of_get_app_setting("set_8", "I")
//	choose case li_Interface
//		case 1 //ITP_INTERFACE
//			OpenSheetWithParm(w_npdb_report, ls_doc_id, "w_npdb_report", w_mdi, 0, original!)
//		case 2 //QRXS_INTERFACE
//			if not IsValid(w_npdb_reports) then Open(w_npdb_reports)
//			w_npdb_reports.SetFocus()
//			w_npdb_reports.of_show_prac_rpts(ls_doc_id)
//	end choose
//end if
//
//
//IF dwo.name = 'b_web' THEN
//	//debugbreak()
//	gs_passstring[1] = dw_detail.GetItemString(Row, "doc_id")
//	gs_passstring[2] =  string(dw_detail.GetItemnumber(Row, "rec_id"))
//	gs_passstring[3] =  string(dw_detail.GetItemnumber(Row, "prac_id"))
//	gs_passstring[4] =  string(dw_detail.GetItemnumber(Row, "screen_id"))
//	gs_passstring[5] =  string(dw_detail.GetItemnumber(Row, "parent_facility_id"))
//	
//	//Start Code Change ----03.22.2016 #V15 maha - if modified re-retrieve data
//	open(w_wc_accept_data_verif)
//	res = message.doubleparm
//	if res = 1 then 
//		of_retrieve_detail( dw_orgs_facilities.getrow())
//	end if
//	//End Code Change ----03.22.2016
//	
//end if
////End Code Change ----02.08.2016
//
////Start Code Change ----11.04.2016 #V153 maha
//IF dwo.name = 'oig_view' THEN
//	openwithparm(w_oig_scan_log_prac, il_prac_id)
//End if
//
end event

event constructor;//ib_rmbmenu = False

this.of_SetDropDownCalendar(true) //Add by Evan 05.11.2009 --- Corrected BugG061301. Register for due date only.
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
		elseif this.getitemnumber( row, "verification_method" ) = 10015 and (data='' or isnull(data)) then //(Appeon)Stephen 04.07.2017 - V15.2 Bug # 5592 - Verifications-> Expiring Credential: Selecting a response code then clearing sets the Expired Notice to No
			This.SetItem( row, "exp_credential_flag", 1 )
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

event itemfocuschanged;call super::itemfocuschanged;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 12.05.2006 By: Jervis
////$<reason> Filter Status
//datawindowchild ldwc
//long ll_wf_id,ll_wf_step_id
//string ls_filter
//
//ll_wf_id = this.GetItemNumber(row,"verif_info_wf_id")
//ll_wf_step_id = this.GetItemNumber(row,"verif_info_wf_action_type_id")
//	
//if dwo.name = "response_code" and ll_wf_id > 0 then
//	if this.GetChild(dwo.name,ldwc) = 1 then
//		ls_filter = "wf_id =" + string(ll_wf_id) + " and step_id = " + string(ll_wf_step_id) 
//		ls_filter = gnv_data.of_get_filter_data("workflow_status_filter",ls_filter,"lookup_code")
//		if ls_filter <> "" then
//			ls_filter += " or isnull(lookup_code) or lookup_code = -777"
//		else
//			ls_filter = "isnull(lookup_code) or lookup_code = -777"
//		end if
//		ldwc.SetFilter( ls_filter)
//		ldwc.Filter()
//		//this.SetRedraw( false)
//		is_prior = dwo.name
//	end if
//elseif is_prior = "response_code" then
//	if this.GetChild(is_prior,ldwc) = 1 then
//		ldwc.SetFilter("")
//		ldwc.Filter()
//		is_prior = ""
//		this.SetRedraw( true )
//	end if
//end if
//
return 1

end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)

col = this.getclickedcolumn()
colname = this.getcolumnname() 

if this.Describe( colname + ".ColType") = "datetime" THEN
	//messagebox("dt","dt")
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

event retrieveend;call super::retrieveend;integer r    //maha  12.18.2012
double ld_fee   //maha  12.18.2012

IF This.RowCount() > 0 THEN
//	dw_browse.SelectRow( 0, False )   //Start Code Change ----01.20.2016 #V15 maha - removed
//	dw_browse.SelectRow(1, True)

//	st_recs.Text = "Record 1 of " + String( This.rowcount() )

	
	Long ll_exp_appt_ltr	

ELSE
//	st_recs.Text = "Record 0 of 0"
END IF

//Start Code Change ----12.18.2012 #V12 maha - set fee value
for r = 1 to this.rowcount()
	if not isnull(this.getitemnumber(r, "address_lookup_code")) then
		if isnull(this.getitemnumber(r, "verif_info_fee")) then
			ld_fee = this.getitemnumber(r, "address_lookup_fee")
			if not isnull( ld_fee) then
				this.setitem(r, "verif_info_fee", ld_fee)
			end if
		end if
	end if
next
//End Code Change ----12.18.2012
end event

event rowfocuschanged;call super::rowfocuschanged;//IF IsValid( m_pfe_cst_verif_info ) THEN
//	inv_action_items.of_enable_action_menu( This, "1" ,2)  //Start Code Change ----02.10.2010 #V10 maha - 3rd arg based on action items tabs
//	w_mdi.of_menu_security( "m_pfe_cst_verif_info" )		
//END IF
//
//IF This.RowCount() >= currentrow AND This.RowCount() > 0 AND currentrow >0 THEN
//	
//	Long ll_exp_appt_ltr	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-35
//	//$<modify> 01.24.2006 By: Cao YongWang
//	//$<reason> performance tuning
//	//$<modification> Write script to retrieve data from a cache instead of from the database.
//	/*
//	SELECT code_lookup.lookup_code  
//   INTO :ll_exp_appt_ltr  
//   FROM code_lookup  
//   WHERE code_lookup.code = 'Exp Appt Ltr'   ;
//	*/
////	ll_exp_appt_ltr = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(code)='" + upper('Exp Appt Ltr') + "'"))
////	//---------------------------- APPEON END ----------------------------
////		
////	IF This.GetItemNumber( currentrow, "verification_method" ) = ll_exp_appt_ltr  AND +&
////		This.GetItemNumber( currentrow, "active_status" ) = 1 THEN
////		tab_view.tabpage_recred.Enabled = True
////	ELSE
////		tab_view.tabpage_recred.Enabled = False
////	END IF
//	
//	dw_browse.SetRow( currentrow )
//	
//END IF
//
//st_recs.Text = "Record " + String( currentrow ) + " of " + String( This.RowCount() )
//
//IF IsValid( w_capture ) THEN
//	gs_pass_ids ls_pass_ids
//	
//	ls_pass_ids.ls_doc_id = This.GetItemString( currentrow, "doc_id" )
//	ls_pass_ids.ls_ref_value = This.GetItemString( currentrow, "reference_value" )
//	ls_pass_ids.ls_from_window = "Prac_Folder"
//	IF This.GetItemNumber( currentrow, "verification_picture_flag" ) = 1 THEN
//		ls_pass_ids.ls_image_available = True
//	ELSE
//		ls_pass_ids.ls_image_available = False
//	END IF
//
//	w_capture.of_setup( ls_pass_ids )
//END IF
//
//
//PostEvent( "ue_after_row_focus_changed" )
end event

event pfc_addrow;//of_new_record( il_prac_id )

This.SetFocus( )

Return 0


end event

event pfc_retrieve;call super::pfc_retrieve;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.23.2006 By: Jervis
////$<reason> 
//Integer li_facility_id[2]
//Integer li_row_cnt,li_row
//
//li_row = dw_orgs_facilities.GetRow()
//if li_row = 0 THEN
//	Return 0
//END IF
//
//li_facility_id[1] = dw_orgs_facilities.GetItemNumber( li_row, "verifying_facility" )
//li_facility_id[2] = dw_orgs_facilities.GetItemNumber( li_row, "parent_facility_id" )
//ii_facility_id = li_facility_id[2]
//ii_ver_id = li_facility_id[1]
//li_row_cnt = dw_detail.Retrieve(1, il_prac_id, li_facility_id[]  )
//
//IF dw_detail.RowCount() > 0 THEN
//	il_rec_id = dw_detail.GetItemNumber( 1, "rec_id" )
//END IF

//RETURN li_row_cnt
//---------------------------- APPEON END ----------------------------
return 1
end event

event pfc_validation;call super::pfc_validation;//IF inv_action_items.of_Validate_Receive( This ) = -1 THEN
//	Return -1
//ELSE
//	Return AncestorReturnValue
//END IF
return 1
end event

event pfc_postupdate;////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.06.2006 By: Jervis
////$<reason> modify work flow
//long ll_i,ll_count
//n_cst_workflow_triggers    lnv_trigger
//
//If not gb_workflow Then return 1
//
////Added by Appeon long.zhang 09.19.2014 (v14.1 bug of Duplicate IntelliCred Emails)
//if isvalid(w_mdi) then
//	if isvalid(w_mdi.iw_prac_window) then w_mdi.iw_prac_window.cb_save.enabled = false
//end if
//
//lnv_trigger = create n_cst_workflow_triggers
//
//
//ll_count = UpperBound(istr_action)
//
//For ll_i = 1 to ll_count
//	if istr_action[ll_i].status_changed_flag then
//		lnv_trigger.of_status_changed( istr_action[ll_i])
//	end if
//Next
//
////2006-11-20 by jervis
////Create Work Flow By Action Item Changed
//lnv_trigger.of_workflow_triggers(istr_action)   
////2006-11-20
//
//destroy lnv_trigger
//
////
//// Add by andy 01/30/2010 V10.1 - Notification Alert
////
//n_cst_notification_alert_upd	lnv_na
//
//lnv_na.of_update_alert_records( "verif_info", This)
//
////Added by Appeon long.zhang 09.19.2014 (v14.1 bug of Duplicate IntelliCred Emails)
//if isvalid(w_mdi) then
//	if isvalid(w_mdi.iw_prac_window) then w_mdi.iw_prac_window.cb_save.enabled = true
//end if
//
//// Because I must check column status in the above function,
//// I unextend ancestor script and call it at last.
//Call Super::pfc_postupdate

return 1




end event

event pfc_preupdate;call super::pfc_preupdate;//Integer li_rc
//Integer i,li_seq
//Integer z
//Integer li_cnt
//Integer li_facility_id
//Integer li_facility_ids[]
//Boolean lb_found
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 11.20.2006 By: Jervis
////$<reason> 
//str_action_item lstr_init[]
//
////Reset str_action_item value
//istr_action = lstr_init
//
//long ll_ori,ll_cur
////---------------------------- APPEON END ----------------------------
//
//
//ii_facility_ids = li_facility_ids //nulling it out
//ii_screen_ids = li_facility_ids
//li_rc = This.RowCount()
//li_seq = 1
////gets the unique verifying facilities; should not be more than 2 (verif and npdb); used by of_is_verif_compete
//FOR i = 1 TO li_rc
//	IF This.GetItemStatus( i, "response_code", Primary! ) = DataModified! THEN
//		//li_facility_id = This.GetItemNumber( i, "facility_id" )
//		ii_facility_ids[1] = This.GetItemNumber( i, "verif_info_facility_id" )
//		ii_screen_ids[1] = This.GetItemNumber( i, "screen_id" )//maha 110304
//		lb_found = False
//		
//	END IF
//	
//	//Start Code Change ----08.05.2011 #V11 maha 
//	IF This.GetItemStatus( i, 0, Primary! ) = DataModified! then
//		this.setitem(i,"mod_user",gs_user_id)
//		this.setitem(i,"mod_date",datetime(today(),now()))
//	end if
//	//End Code Change ----08.05.2011
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 11.20.2006 By: Jervis
//	//$<reason> modify work flow
//	If gb_workflow Then
//		IF This.GetItemStatus( i, 0, Primary! ) = DataModified! then
//			//if this.GetItemNumber(i,"response_code",primary!,true) <> this.GetItemNumber(i,"response_code") Then
//			ll_ori = this.GetItemNumber(i,"response_code",primary!,true)
//			ll_cur = this.GetItemNumber(i,"response_code")
//			if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
//				istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
//				istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
//				istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
//				istr_action[li_seq].wf_id = this.GetItemNumber(i,"verif_info_wf_id")
//				istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
//				istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
//				istr_action[li_seq].status_changed_flag = false
//				istr_action[li_seq].module = "01"	//IntelliGred
//				istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
//				istr_action[li_seq].screen_id = -10
//				
//				if istr_action[li_seq].wf_id > 0 and this.GetItemString(i,"verif_info_wf_complete_flag") = "N" THEN
//					istr_action[li_seq].wf_step_id = this.GetItemNumber(i,"verif_info_wf_action_type_id")
//					istr_action[li_seq].notes = this.GetItemString(i,"notes")
//					istr_action[li_seq].status_changed_flag = true
//					istr_action[li_seq].seq_no = This.getItemnumber( i, "seq_no" )
//				end if
//				li_seq++
//			//elseif this.GetItemNumber(i,"verification_method",primary!,true) <> this.GetItemNumber(i,"verification_method") Then
//			else
//				ll_ori = this.GetItemNumber(i,"verification_method",primary!,true)
//				ll_cur = this.GetItemNumber(i,"verification_method")
//				if ((ll_ori <> ll_cur) or (isnull(ll_ori) and not isnull(ll_cur)) or (not isnull(ll_ori) and isnull(ll_cur))) Then
//					istr_action[li_seq].rec_id = This.getItemnumber( i, "rec_id" )
//					istr_action[li_seq].prac_id = This.getItemnumber( i, "prac_id" )
//					istr_action[li_seq].facility_id = This.getItemnumber( i, "verif_info_facility_id" )
//					istr_action[li_seq].wf_action_status_id = this.GetItemNumber(i,"response_code")
//					istr_action[li_seq].wf_action_type_id = this.GetItemNumber(i,"verification_method")
//					istr_action[li_seq].status_changed_flag = false
//					istr_action[li_seq].module = "01"	//IntelliGred
//					istr_action[li_seq].trigger_by = "008"		//Trigger By Action Item Changed
//					istr_action[li_seq].screen_id = -10
//					li_seq++
//				end if
//			end if
//		END IF
//	End if
//		
//END For
//

Return 1
end event

type dw_app from u_dw within pfc_cst_u_wf_provider
integer x = 969
integer y = 948
integer width = 3287
integer height = 1004
integer taborder = 10
boolean titlebar = true
string title = "Application Steps"
boolean hscrollbar = true
end type

event constructor;call super::constructor;
//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//this.retrieve(1)
this.settransobject( sqlca)
end event

type dw_cred from u_dw within pfc_cst_u_wf_provider
integer x = 969
integer y = 260
integer width = 3287
integer height = 936
integer taborder = 10
boolean titlebar = true
string title = "Appointment Steps"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.16.2014 (v14.2 Provider-Contract direct linking)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//this.retrieve(1)
this.settransobject( sqlca)
end event

