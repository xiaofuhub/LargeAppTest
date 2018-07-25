$PBExportHeader$w_provider_mockup1.srw
forward
global type w_provider_mockup1 from window
end type
type dw_1 from datawindow within w_provider_mockup1
end type
type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_provider_mockup1
end type
type ddlb_search_type from dropdownlistbox within w_provider_mockup1
end type
type sle_srch_val from singlelineedit within w_provider_mockup1
end type
type cb_search from u_cb within w_provider_mockup1
end type
type gb_facility from groupbox within w_provider_mockup1
end type
end forward

global type w_provider_mockup1 from window
integer width = 4786
integer height = 2676
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
dw_org_facility_select dw_org_facility_select
ddlb_search_type ddlb_search_type
sle_srch_val sle_srch_val
cb_search cb_search
gb_facility gb_facility
end type
global w_provider_mockup1 w_provider_mockup1

on w_provider_mockup1.create
this.dw_1=create dw_1
this.dw_org_facility_select=create dw_org_facility_select
this.ddlb_search_type=create ddlb_search_type
this.sle_srch_val=create sle_srch_val
this.cb_search=create cb_search
this.gb_facility=create gb_facility
this.Control[]={this.dw_1,&
this.dw_org_facility_select,&
this.ddlb_search_type,&
this.sle_srch_val,&
this.cb_search,&
this.gb_facility}
end on

on w_provider_mockup1.destroy
destroy(this.dw_1)
destroy(this.dw_org_facility_select)
destroy(this.ddlb_search_type)
destroy(this.sle_srch_val)
destroy(this.cb_search)
destroy(this.gb_facility)
end on

type dw_1 from datawindow within w_provider_mockup1
integer x = 50
integer y = 168
integer width = 928
integer height = 2352
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_provider_mockup1
integer x = 59
integer y = 56
integer width = 933
integer height = 80
integer taborder = 30
string dataobject = "d_org_facility_select_vertical_no_label"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;////This.Object.facilities_t.Visible = False
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-11
////$<modify> 01.24.2006 By: Cao YongWang
////$<reason> Performance tuning
////$<modification> The following script is copied from the ancester object pfc_cst_u_org_facility_selector_vertical.
////$<modification> Uncheck the Extend Ancester Script item from PowerBuilder painter.
//DataWindowChild dwchild
//
//This.SetTransObject( SQLCA )
////This.InsertRow( 0 )
//If This.RowCount() < 1 Then This.InsertRow(0) //alfee 11.24.2009
//
//This.GetChild( "facility_id", dwchild )
//dwchild.SetTransObject( SQLCA )
////dwchild.Retrieve( gs_user_id )
////Write scripts to retrieve data from the cache instead of retrieve.
//If not isvalid(ids_facilitys) Then of_init_dddw()
//dwchild.reset()
//ids_facilitys.rowscopy(1, ids_facilitys.rowcount(),Primary!, dwchild , 1, Primary!)
//dwchild.InsertRow(1)
//dwchild.SetItem( 1, "facility_name", "All" )
//dwchild.SetItem( 1, "facility_id", 0 )
//
////This.SetItem( 1, "facility_id", 0 )
//IF IsNull(this.getItemNumber(1,"facility_id")) then This.SetItem( 1, "facility_id", 0 )	//long.zhang 09.26.2011 Department Secuirty and Profile Module - Bug id 2658
////---------------------------- APPEON END ----------------------------
//
end event

type ddlb_search_type from dropdownlistbox within w_provider_mockup1
integer x = 1129
integer y = 52
integer width = 475
integer height = 904
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"Last Name","Prac ID","SS #","NPI #","Provider ID","Primary Department","Custom Search","Apps Needing Printing","Address - Street 1","Address - Street 2","Address - Tax Id","Standing/Flag","WebView Tracking (name)","Professional Suffix","Assigned User","Contract"}
borderstyle borderstyle = stylelowered!
end type

event constructor;This.Text = "Last Name"
if gb_webview = false then this.deleteitem( 15) //Start Code Change ----08.25.2011 #V11 maha - hide webview tracking if webview not in system //Start Code Change ----06.13.2013 #V14 maha - changed from 12
end event

event selectionchanged;//if this.text = "Primary Department" then
//	dw_dept.visible = true
//	dw_dept.bringtotop = true
//	sle_srch_val.text = ""
//	dw_dept.settransobject(sqlca)
//	dw_dept.retrieve()
//	dw_dept.insertrow(1)
//elseif this.text = "Professional Suffix" then  //Start Code Change ----12.06.2012 #V12 maha - new search
//	dw_prof_suffix.visible = true
//	dw_prof_suffix.bringtotop = true
//	sle_srch_val.text = ""
//	dw_prof_suffix.settransobject(sqlca)
//	dw_prof_suffix.retrieve()
//	dw_prof_suffix.insertrow(1)
//else
//	dw_dept.visible = false
//	dw_prof_suffix.visible = false
//	il_dept = 0
//	il_prof = 0
//end if
//
//
//
//if this.text = "WebView Tracking (name)" then  //Start Code Change ----08.25.2011 #V11 maha 
//	gb_letters.bringtotop = true
//else
//	gb_letters.bringtotop = false
//end if
//
////Start Code Change ---- 02.08.2006 #262 maha
//if this.text = "Custom Search" then
//	cb_search.triggerevent(clicked!)
//elseif this.text = "Standing/Flag" then  //Start Code Change ----02.01.2011 #V11 maha 
//	cb_search.triggerevent(clicked!)
//elseif  this.text = "Assigned User" then  //Start Code Change ----12.13.2012 #V12 maha - new search
//	sle_srch_val.SetFocus()
//	sle_srch_val.text = gs_user_id
//elseif this.text = "Contract" then //(Appeon)Harry 08.13.2014 - BugS072201
//	cb_search.triggerevent(clicked!)
//else
//	sle_srch_val.SetFocus()
//	sle_srch_val.text = ""  //maha 011306
//end if
////End Code Change---02.08.2006
//
////Start Code Change ----01.16.2014 #V14 maha - added
//choose case this.text
//	case "Address - Tax Id", "NPI #" , "SS #"
//		cbx_valid.visible = true
//	case else 
//		cbx_valid.visible = false
//end choose
//
end event

type sle_srch_val from singlelineedit within w_provider_mockup1
integer x = 1627
integer y = 52
integer width = 704
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_search from u_cb within w_provider_mockup1
integer x = 2350
integer y = 52
integer width = 329
integer height = 84
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "S&earch"
boolean default = true
end type

event clicked;//of_search_new("")

//String ls_fld
//String ls_sql
//String ls_ssn
//String ls_name
//String ls_depart_sql
//string ls_prac_list
//Integer li_name_len
//Integer li_Rc
//Integer li_val_len
//Integer i
//String ls_all_facilities
//Long ll_action_type
//Long ll_action_status
//DataWindowChild dwchild
//
//IF li_num_of_departments_user_has_rights_to <> li_num_of_departments THEN
//	dw_department.GetChild( "department", dwchild )
//	li_rc = dwchild.RowCount()
//	ls_depart_sql = "("
//	//start with 2 because 0 = all
//	FOR i = 2 TO li_rc
//		ls_depart_sql = ls_depart_sql + String( dwchild.GetItemNumber( i, "lookup_code" ) ) + ","
//	END FOR
//	ls_depart_sql = Mid( ls_depart_sql, 1, Len( ls_depart_sql ) -1 )
//	ls_depart_sql = ls_depart_sql + ")"
//END IF
////messagebox("",is_open_for)
//IF is_open_for = "INTELLIAPP" THEN
//	dw_search.DataObject = "d_extended_search_list_intelliapp"
//elseif is_open_for = "REPORTS" THEN
//	dw_search.DataObject = "d_extended_search_list_multi"
//ELSE
//	dw_search.DataObject = "d_extended_search_list"	
//	
//END IF
//
//IF ddlb_search_type.Text = "I.D." THEN
//	ls_fld = "prac_id"
//ELSEIF ddlb_search_type.Text = "Last Name" THEN
//	ls_fld = "last_name"
//ELSEIF ddlb_search_type.Text = "SS #" THEN
//	ls_fld = "ssn"
//ELSEIF ddlb_search_type.Text = "Provider ID" THEN //maha 081202
//	ls_fld = "provider_id"
//ELSEIF ddlb_search_type.Text = "Apps Needing Printed" THEN
//	ls_fld = "Apps Needing Printed"	
//ELSEIF ddlb_search_type.Text = "Primary Department" THEN
//	ls_fld = "Primary Department"
//ELSEIF ddlb_search_type.Text = "Custom Search" THEN //maha 1000604
//	ls_fld = "Custom Search"
//	open(w_search_query)
//	ls_prac_list = message.stringparm
//	if ls_prac_list = "Cancel" then return
//	//ls_prac_list = "1,2,3,4,5"
//	
//END IF
//debugbreak()
//li_val_len = Len(sle_srch_val.Text)
//
//
//il_facility_id = dw_org_facility_select.GetItemNumber( 1, "facility_id" )
//
//ls_sql =   "SELECT DISTINCT pd_basic.first_name, "+&   
//         "pd_basic.middle_name,"+&      
//         "pd_basic.title,"+&      
//         "pd_basic.name_suffix,"+&      
//         "pd_basic.prof_suffix,"+&      
//         "pd_basic.ssn,"+&      
//         "pd_basic.sex,"+&      
//         "pd_basic.prac_category,"+&      
//         "pd_basic.date_of_birth,"+&      
//         "pd_basic.rec_id,"+&      
//         "pd_basic.prac_id,"+&      
//         "pd_affil_stat.parent_facility_id,"+&      
//         "facility.facility_name,"+&      
//         "facility.default_data_view_id,"+&      
//         "pd_basic.last_name,"+&      
//         "code_lookup.code "
//	  IF is_open_for = "INTELLIAPP" THEN
//   // 	IF ls_fld = "Apps Needing Printed" THEN	    
//          ls_sql = ls_sql + ",net_dev_action_items.action_type,"+&      
//         "net_dev_action_items.app_id,"+&      	    
//         "net_dev_action_items.action_status " +&
//	   "FROM {oj pd_basic  LEFT OUTER JOIN code_lookup  ON pd_basic.name_suffix = code_lookup.lookup_code}, "+&
//	    "{oj pd_affil_stat  LEFT OUTER JOIN net_dev_action_items  ON pd_affil_stat.parent_facility_id =  "+&
//	    "net_dev_action_items.facility_id AND pd_affil_stat.prac_id = net_dev_action_items.prac_id}, "+&      
//     	    "facility "
//				
//		//if one department is selected or if all departments are selected and the number of departments the users
//		//has rights to is less then the number of departments in lookup table then do this
//		//if the number of departments in lookup are the same as the number of departments the user has rights to
//		//then the department security is turned off or they have rights to all departments so do nothing
//		if il_dept > 0 OR ( il_dept = 0 AND li_num_of_departments <> li_num_of_departments_user_has_rights_to ) then //maha 121002
//			ls_sql = ls_sql + ", pd_affil_dept "
//		end if
//		
//     	ls_sql = ls_sql +  "WHERE ( pd_basic.prac_id = pd_affil_stat.prac_id ) and "+&     
//     		 "( pd_affil_stat.parent_facility_id = facility.facility_id ) "
//		
//		//if only 1 department is selected then do a regular where clause
//		if il_dept > 0 then //maha 121002
//			ls_sql = ls_sql + "and ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and "+& 
//			"( pd_affil_dept.primary_dept = 1 ) "
//			ls_sql = ls_sql + " AND (pd_affil_dept.department = " + string(il_dept) + ")"
//		//if ALL is selected and number of departments in lookup is not = to number of depart user has
//		//rights to then department security is turned on so do this.
//		elseif il_dept = 0 AND li_num_of_departments <> li_num_of_departments_user_has_rights_to THEN
//				ls_sql = ls_sql + " and ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and "+& 
//			"( pd_affil_dept.primary_dept = 1 ) "
//			//if il_dept > 0 then 
//				ls_sql = ls_sql + " AND (pd_affil_dept.department in " + ls_depart_sql + ")"			
//		end if
//	ELSE
//		ls_sql = ls_sql + ",pd_affil_stat.date_app_audit_completed," +&   
//      "pd_affil_stat.date_data_entry_completed," +&
//	   "pd_affil_stat.date_verif_completed," +&  
//     	"pd_affil_stat.apptmnt_start_date, " +& 
//		"pd_affil_stat.active_status " 
//		if dw_search.DataObject = "d_extended_search_list_multi" then //maha added 091605 not used
//			ls_sql += " , 0 as selected, v_full_name.full_name "
//		end if
//     	ls_sql = ls_sql +  "FROM {oj pd_basic  LEFT OUTER JOIN code_lookup  ON pd_basic.name_suffix = code_lookup.lookup_code}, "+&
//     	"facility, "+&   
//		"pd_affil_stat "
//		if dw_search.DataObject = "d_extended_search_list_multi" then
//			ls_sql += ", v_full_name "
//		end if
//		
//		
//		//if one department is selected or if all departments are selected and the number of departments the users
//		//has rights to is less then the number of departments in lookup table then do this
//		//if the number of departments in lookup are the same as the number of departments the user has rights to
//		//then the department security is turned off or they have rights to all departments so do nothing
//		if il_dept > 0 OR ( il_dept = 0 AND li_num_of_departments <> li_num_of_departments_user_has_rights_to ) then //maha 121002
//			ls_sql = ls_sql + ", pd_affil_dept "
//		end if
//		
//     	ls_sql = ls_sql +  "WHERE ( pd_basic.prac_id = pd_affil_stat.prac_id ) and "+&     
//     		 "( pd_affil_stat.parent_facility_id = facility.facility_id ) "
//		
//		//if only 1 department is selected then do a regular where clause
//		if il_dept > 0 then //maha 121002
//			ls_sql = ls_sql + "and ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and "+& 
//			"( pd_affil_dept.primary_dept = 1 ) "
//			ls_sql = ls_sql + " AND (pd_affil_dept.department = " + string(il_dept) + ")"
//		//if ALL is selected and number of departments in lookup is not = to number of depart user has
//		//rights to then department security is turned on so do this.
//		elseif il_dept = 0 AND li_num_of_departments <> li_num_of_departments_user_has_rights_to THEN
//				ls_sql = ls_sql + " and ( pd_affil_stat.rec_id = pd_affil_dept.rec_id ) and "+& 
//			"( pd_affil_dept.primary_dept = 1 ) "
//			//if il_dept > 0 then 
//				ls_sql = ls_sql + " AND (pd_affil_dept.department in " + ls_depart_sql + ")"			
//		end if
//		if dw_search.DataObject = "d_extended_search_list_multi" then
//			ls_sql += " and ( v_full_name.prac_id = pd_basic.prac_id ) "
//		end if
//	END IF	    
// //  "FROM {oj pd_basic  LEFT OUTER JOIN code_lookup  ON pd_basic.name_suffix = code_lookup.lookup_code}, "+&   	    
//IF il_facility_id <> 0 THEN
//	ls_sql = ls_sql + " AND pd_affil_stat.parent_facility_id = " + String( il_facility_id )
//ELSE
//	dw_org_facility_select.GetChild( "facility_id", dwchild )
//	FOR i = 1 TO dwchild.RowCount()
//		ls_all_facilities = ls_all_facilities + String( dwchild.GetItemNumber( i, "facility_id" ) ) + ","
//	END FOR
//	ls_all_facilities = Mid( ls_all_facilities , 1 , Len( ls_all_facilities ) -1 ) //gets rid of the extra comma
//	ls_sql = ls_sql + " AND pd_affil_stat.parent_facility_id in (" + ls_all_facilities + ")"
//END IF
//
//IF cbx_status.Checked = True THEN
//	ls_sql = ls_sql + " AND (pd_affil_stat.active_status = 1 OR pd_affil_stat.active_status = 5 OR pd_affil_stat.active_status = 3 OR pd_affil_stat.active_status = 4 )" 
//ELSE
//	ls_sql = ls_sql + " AND (pd_affil_stat.active_status = 1 OR pd_affil_stat.active_status = 4 or pd_affil_stat.active_status = 5)" 	
//END IF
//IF is_open_for = "DELETE" THEN
//	ls_sql = ls_sql + " AND pd_affil_stat.active_status = 2 " 
//END IF
//
//IF ls_fld = "Custom Search" THEN //maha 1000604
//		ls_sql = ls_sql + " AND pd_basic.prac_id in (" + ls_prac_list + ")"
//ELSEIF Len(sle_srch_val.Text) > 0 OR ls_fld = "Apps Needing Printed" THEN
//	IF ls_fld = "prac_id" THEN
//		ls_sql = ls_sql + " AND pd_basic.prac_id = " + sle_srch_val.Text
//	ELSEIF ls_fld = "last_name" THEN
//		ls_name = sle_srch_val.Text
//		li_name_len = Len( ls_name )
//		FOR i = 1 TO li_name_len
//			IF Mid(ls_name, i,1 )  = "'" THEN
//				ls_name = Mid(ls_name, 1, i ) + "'" + Mid(ls_name, i+1 , 100 )
//				i++
//		END IF	
//		END FOR
//		ls_sql = ls_sql + " AND {fn left(pd_basic.last_name," + String( li_name_len ) + ")}  = '" + Upper(ls_name) + "'"
//	ELSEIF ls_fld = "ssn" THEN
//		ls_ssn = sle_srch_val.Text
//		IF Pos( ls_ssn, "-" ) > 0 THEN
//		 	ls_ssn = Mid( sle_srch_val.Text, 1, 3 ) + Mid( sle_srch_val.Text, 5, 2 ) + Mid( sle_srch_val.Text, 8, 4 )
//		END IF
//		ls_sql = ls_sql + " AND ssn = '" + ls_ssn + "'"
//	elseIF ls_fld = "provider_id" THEN //maha 081202
//		ls_sql = ls_sql + " AND pd_basic.provider_id = '" + sle_srch_val.Text + "'"
//	end if
//	IF ls_fld = "Apps Needing Printed" THEN
//		//\/maha 032102
//		select lookup_code into :ll_action_type from code_lookup where lookup_name = 'Action Type' and code = 'App Out To MD';		
//		IF SQLCA.SQLCODE = 100 THEN
//				MessageBox("Error", "You need to add 'App Out To MD' to the Action Type lookup table." )
//				Return -1
//		end if
//		select lookup_code into :ll_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Incomplete';
//		IF SQLCA.SQLCODE = 100 THEN
//				MessageBox("Error", "You will need to add 'Incomplete' to the Action Status lookup table." )
//				Return -1
//		END IF
//		//\maha
//		ls_sql = ls_sql + "AND action_type = " + String( ll_action_type ) + " AND action_status = " + string(ll_action_status)  //-3 AND action_status = -110"
//		
//	END IF
//
//	
//END IF
//
//
//
//ls_sql = ls_sql + " ORDER BY pd_basic.last_name ASC"   
////messagebox("", ls_sql )
////CLIPBOARD( LS_SQL )
////messagebox("", dw_search.DataObject )
//dw_search.SetTransObject( SQLCA_1 )
//
//
//dw_search.SetSQLSelect ( ls_sql )
//li_rc = dw_search.Retrieve( )
//
//FOR i = 1 TO li_rc
//	dw_search.SetItem( i, "rec_id", 0 )
//END FOR
//
//of_hide_ssn()
//
//
//dw_search.SetFocus()
//	
end event

type gb_facility from groupbox within w_provider_mockup1
integer x = 46
integer width = 1061
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Select Facility"
end type

event constructor;//BEGIN---Delete by Evan 09/19/2008
/*
IF gs_cust_type = "C" THEN
	This.Text = 'Client'
ELSEIF gs_cust_type = "I" THEN
	This.Text = 'Payor/Hospital'
END IF
*/
//BEGIN---Delete by Evan 09/19/2008
end event

