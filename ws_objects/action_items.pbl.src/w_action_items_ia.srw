$PBExportHeader$w_action_items_ia.srw
forward
global type w_action_items_ia from w_action_items
end type
end forward

global type w_action_items_ia from w_action_items
integer height = 2500
end type
global w_action_items_ia w_action_items_ia

forward prototypes
public function integer of_graph_case (integer ai_case)
end prototypes

public function integer of_graph_case (integer ai_case);//Start Code Change ----04.22.2008 #V8 maha - overwrite of ancestor

CHOOSE CASE ai_case
	//verification status
	CASE 1	
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail Action Types."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph)
	//expiring credentials
	CASE 3
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of All Expiring Credential verifications."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph)
	//app audit
	CASE 5
		tab_1.tabpage_analysis.st_msg.text = "Double click graph to view detail of All Missing Required Documents."
		inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph, is_user_id )
		of_filter_by_intellibatch(tab_1.tabpage_analysis.tab_analysis.tabpage_audit.dw_app_audit_graph)
end choose
//End Code Change---04.22.2008

return 1
end function

on w_action_items_ia.create
int iCurrent
call super::create
end on

on w_action_items_ia.destroy
call super::destroy
end on

event close;call super::close;IF IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF
end event

event pfc_postopen;call super::pfc_postopen;//String ls_filter_syntax
//DataWindowChild dwchild
//Integer li_found
//
////if this is not IntelliApp only then do not use any of this stuff
////IF gs_cust_type <> "I" THEN
////	Return
////END IF
//
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SetRow( 1 )
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 0, False )
//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 1, True )
//
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SetRow( 1 )
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 0, False )
//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 1, True )
//
//CHOOSE CASE ii_dashboard_macro
//	//Items over due Today
//	CASE 0
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
//		li_found = dwchild.Find( "filter_code = 'Items Due TODAY'", 1, 199 )
//		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )
//		
//	//overdue net dev action items
//	CASE 1
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
//		li_found = dwchild.Find( "filter_code = 'Items Over Due'", 1, 199 )
//		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )
//		
//	CASE 2
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
//		li_found = dwchild.Find( "filter_code = 'Applications Needing Printed'", 1, 199 )
//		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )		
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
//	
//	//You have # App Rcvd Prac follow letters to send	
//	CASE 3
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
//		li_found = dwchild.Find( "filter_code = 'Applications Not Back From Provider'", 1, 199 )
//		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )		
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
//		
//	//You have # Par Rcvd Payor follow letters to send	
//	CASE 4
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.GetChild( "quick_filter", dwchild )
//		li_found = dwchild.Find( "filter_code = 'PAR # Not Back From Payor'", 1, 199 )
//		ls_filter_syntax = dwchild.GetItemString( li_found, "filter_syntax" )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.SetItem( 1, "quick_filter", ls_filter_syntax )
//		tab_1.tabpage_net_dev.uo_net_dev.dw_qf.AcceptText( )				
//		tab_1.tabpage_net_dev.uo_net_dev.of_set_quick_filter( ls_filter_syntax )		
//		
//	//You have # Expiring letters to send	
//	CASE 5
//		tab_1.SelectTab( 2 )
//		ddplb_filters.SelectItem( 1 ) 
//
//		ii_filter_index = 1
//
//		is_filter = ddplb_filters.Text
//
//		is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
//
//		IF is_display_text = "-1" THEN
//			Return 
//		END IF
//		
//		This.Event pfc_cst_print_letters()
//
//	//Application Status Report by Practitioner
//	CASE 6
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 4 ) 
//		
//	//Application Status Report by Plan
//	CASE 7
//		tab_1.SelectTab( 4 )
//		tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 4 ) 		
//		tab_1.tabpage_net_dev.uo_net_dev.ddlb_group_by.SelectItem( 2 )
//
//	//You have # Missing Information Items
//	CASE 10
//		tab_1.SelectTab( 2 )
//		ddplb_filters.Visible = True
//		ddplb_filters.SelectItem( 4 ) 		
//	
//		ii_filter_index = 4
//
//		is_filter = ddplb_filters.Text
//
//		is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
//
//		IF is_display_text = "-1" THEN
//			Return 
//		END IF
//				
//END CHOOSE
//
//
end event

type cb_bb10 from w_action_items`cb_bb10 within w_action_items_ia
end type

type cb_bb9 from w_action_items`cb_bb9 within w_action_items_ia
end type

type cb_bb8 from w_action_items`cb_bb8 within w_action_items_ia
end type

type cb_bb7 from w_action_items`cb_bb7 within w_action_items_ia
end type

type cb_bb6 from w_action_items`cb_bb6 within w_action_items_ia
end type

type cb_bb5 from w_action_items`cb_bb5 within w_action_items_ia
end type

type cb_bb4 from w_action_items`cb_bb4 within w_action_items_ia
end type

type cb_bb3 from w_action_items`cb_bb3 within w_action_items_ia
end type

type cb_bb2 from w_action_items`cb_bb2 within w_action_items_ia
end type

type cb_save from w_action_items`cb_save within w_action_items_ia
end type

type p_buttons from w_action_items`p_buttons within w_action_items_ia
end type

type dw_filter from w_action_items`dw_filter within w_action_items_ia
end type

type p_1 from w_action_items`p_1 within w_action_items_ia
end type

type st_filter from w_action_items`st_filter within w_action_items_ia
end type

type dw_select_org_facility from w_action_items`dw_select_org_facility within w_action_items_ia
end type

event dw_select_org_facility::itemchanged;Integer li_rc
Integer li_dummy_array[]
DatawindowChild dwchild

ii_facility_ids_all = li_dummy_array

AcceptText()

IF This.GetColumnName() = "facility_id" THEN
	ii_facility_id = Integer( data )
	tab_1.tabpage_net_dev.uo_net_dev.of_Set_Facility_id( ii_facility_id )
END IF

debugbreak()
CHOOSE CASE tab_1.SelectedTab
	//analysis graphs
	CASE 1
		of_graph_case(tab_1.tabpage_analysis.tab_analysis.SelectedTab)
//		CHOOSE CASE tab_1.tabpage_analysis.tab_analysis.SelectedTab
//			//application status
//			CASE 1
//				inv_action_items.of_filter_graph_ia( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_last_attempt.dw_last_attemp_graph, is_user_id )
//			//expiring credentials
//			CASE 3
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_expiring_credentials.dw_expiring_credential_graph, is_user_id )
//			//expiring appointments	
//			CASE 4
//				inv_action_items.of_filter_graph( ii_facility_id, tab_1.tabpage_analysis.tab_analysis.tabpage_exp_appointments.dw_expiring_appointments_graph, is_user_id )
//		END CHOOSE
	//action item detail tab
	CASE 2
		inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters)	
	CASE 3
		of_get_ready_for_committee()
	CASE 4
		//Start Code Change ----05.03.2016 #V15 maha - copied from ancester
		 tab_1.tabpage_net_dev.uo_net_dev.of_set_facility_id( ii_facility_id )   
		inv_action_items.il_facility = ii_facility_id
		inv_action_items.of_filter_appl_actions( tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities, ib_incomplete_only,  is_user_id)
		of_filter_by_intellibatch(tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev)
		//End Code Change ----05.03.2016
		//tab_1.tabpage_net_dev.uo_net_dev.of_Retrieve_Detail( ii_facility_id )
END CHOOSE

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 04.18.2011
//$<reason> fixed a bug
tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetRowFocusIndicator( p_1 )
//------------------- APPEON END ---------------------

idw_active.SetFocus()
end event

type dw_user from w_action_items`dw_user within w_action_items_ia
integer x = 1298
end type

type tab_1 from w_action_items`tab_1 within w_action_items_ia
end type

event tab_1::selectionchanged;call super::selectionchanged;dw_select_org_facility.Visible = True
dw_user.Visible = True
IF newindex = 2 AND tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.RowCount() = 0 THEN
	Integer li_picture_index
	Integer li_index
	Integer li_index_1
	Integer i

	IF ii_dashboard_macro = 0 then
		ddplb_filters.SelectItem( 1 )

		ii_filter_index = 1

		is_filter = ddplb_filters.Text

		is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )

		IF is_display_text = "-1" THEN
			Return 1
		END IF
	END IF

	tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse.SetFocus()

	ddplb_filters.PostEvent( "after_select" )
	dw_select_org_facility.Modify( "facilities_t.Text = 'Select Payor/Group'")
	Return 0
ELSEIF newindex = 4 THEN
	//Start Code Change ----05.03.2016 #V15 maha - removed overwrite
//	dw_select_org_facility.Visible = False
//	dw_user.Visible = False
	//End Code Change ----05.03.2016
	tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab(1)
END IF

dw_select_org_facility.Modify( "facilities_t.Text = 'Select Payor/Group'")

IF IsValid( w_net_dev_filter ) THEN
	Close( w_net_dev_filter )
END IF

// start code change --- 22 March 2006 MSKINNER
IF newindex = 5 or newindex = 6 THEN			//Modified by Scofield on 2008-05-06: Add "or newindex = 6"
	dw_select_org_facility.Visible = False
	dw_user.Visible = False
end if

end event

type tabpage_analysis from w_action_items`tabpage_analysis within tab_1
integer y = 112
integer height = 2076
long tabbackcolor = 81324524
end type

type tab_analysis from w_action_items`tab_analysis within tabpage_analysis
integer y = 244
end type

type tabpage_last_attempt from w_action_items`tabpage_last_attempt within tab_analysis
long backcolor = 81324524
string text = "Application Status"
long tabbackcolor = 81324524
end type

type dw_last_attemp_graph from w_action_items`dw_last_attemp_graph within tabpage_last_attempt
string dataobject = "d_ai_intelliapp_graph"
end type

event dw_last_attemp_graph::doubleclicked;Integer li_facility_id
Integer SeriesNbr
Integer ItemNbr
Integer li_found
Long ll_action_type
Long ll_action_status
String ls_series_name
String ls_category_name
String ls_where, ls_sql
String ls_from, ls_to
double data_value
integer res
string f

grObjectType MouseHit

MouseHit = This.ObjectAtPointer("gr_1", SeriesNbr, ItemNbr)

data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
ls_category_name = This.CategoryName("gr_1", ItemNbr)
ls_series_name = This.SeriesName("gr_1", SeriesNbr)

IF MouseHit = 	TypeCategory!  THEN
	//nothing
ELSEIF MouseHit = TypeData! THEN
//	//debugbreak()
	data_value = This.GetData("gr_1", SeriesNbr, ItemNbr)
	ls_series_name = UPPER(This.SeriesName("gr_1", SeriesNbr))
	ls_category_name = UPPER(This.CategoryName("gr_1", ItemNbr))
	//messagebox("","typedata")

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-01
	//$<modify> 02.27.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
		SELECT lookup_code INTO :ll_action_status FROM code_lookup WHERE code = 'Incomplete' and lookup_name = 'Action Status';				
	*/	
	
	ll_action_status = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(code) = upper('Incomplete') and upper(lookup_name) = upper('Action Status')"))
	
	//---------------------------- APPEON END ----------------------------
	tab_1.selecttab(4)								

	li_facility_id = dw_select_org_facility.GetItemNumber( 1, "facility_id" )
	li_found = tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.Find( "parent_facility_id = " + String( li_facility_id ), 1, 1000 )
	tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.ScrollToRow( li_found )			
	tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SetRow( li_found )
		
	//------------Begin Modified by alfee 09.17.2010 -----------------------------------
	//SK Practitioner Folder
	if gi_intelliapp_type > 0 then //non single group
		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.collapseall( )
		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.expand(li_found, 1)
		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.selecttreenode(li_found, 1, true)
	else  //single group
		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 0, False )
		tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( li_found, True )
	end if
	//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( 0, False )
	//tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.SelectRow( li_found, True )			
	//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SetRow( 1 )			
	//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 0, False )									
	//tab_1.tabpage_net_dev.uo_net_dev.dw_payors.SelectRow( 1, True )
	//------------End Modified ------------------------------------------------------------
	
//	tab_1.tabpage_net_dev.uo_net_dev.of_retrieve_detail( li_facility_id )  not needed maha071905
	tab_1.tabpage_net_dev.uo_net_dev.st_as_msg.Visible = True
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<modify> 02.27.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	/*
	SELECT lookup_code INTO :ll_action_type FROM code_lookup WHERE code = :ls_category_name and lookup_name = 'Action Type';
	IF SQLCA.SQLCODE = 100 THEN
		SELECT lookup_code INTO :ll_action_type FROM code_lookup WHERE custom_1 = :ls_category_name and lookup_name = 'Action Type';		
	END IF
	*/	
	
	ll_action_type = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(code) = '" + Upper(ls_category_name) + "' and upper(lookup_name) = upper('Action Type')"))
	If ll_action_type = 0 Then
		ll_action_type = Long(gnv_data.of_getitem( "code_lookup", "lookup_code", "upper(custom_1) = '" + Upper(ls_category_name) + "' and upper(lookup_name) = upper('Action Type')"))
	End If
	//---------------------------- APPEON END ----------------------------
	
	//f = tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.getsqlselect()
	
	//messagebox("prefilter",tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.rowcount())
	
	f = "action_type = " + String( ll_action_type ) + " AND action_status = " + String( ll_action_status)
	//messagebox("",f)
	res = tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.SetFilter(f)
	res = tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.Filter()
	//res = tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.dw_report_data.SetFilter("action_type = " + String( ll_action_type ) + " AND action_status = " + String( ll_action_status) )
	//res = tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.dw_report_data.Filter()
	tab_1.tabpage_net_dev.uo_net_dev.st_as_msg.Text = "Bar Graph Clicked!  Report filter based on Action Type = " + ls_category_name + " AND Action Status = Incomplete"				
	//messagebox("postfilter",tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.rowcount())
ELSE
	RETURN 1
END IF

tab_1.tabpage_net_dev.uo_net_dev.tab_1.SelectTab( 1 )
tab_1.tabpage_net_dev.uo_net_dev.dw_orgs_facilities.of_SetUpdateAble(False)
tab_1.tabpage_net_dev.uo_net_dev.dw_payors.of_SetUpdateAble(False)
tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_report.dw_report_data.of_SetUpdateAble(False)
tab_1.tabpage_net_dev.uo_net_dev.tab_1.tabpage_ai.dw_net_dev.Modify( "DataWindow.Table.UpdateTable = 'net_dev_action_items'" )
end event

event dw_last_attemp_graph::constructor;call super::constructor;This.of_SetUpdateAble( False )
end event

type tabpage_total_attempts from w_action_items`tabpage_total_attempts within tab_analysis
boolean visible = false
long backcolor = 81324524
long tabbackcolor = 81324524
end type

type dw_total_attempts from w_action_items`dw_total_attempts within tabpage_total_attempts
end type

type tabpage_expiring_credentials from w_action_items`tabpage_expiring_credentials within tab_analysis
end type

type dw_expiring_credential_graph from w_action_items`dw_expiring_credential_graph within tabpage_expiring_credentials
end type

event dw_expiring_credential_graph::doubleclicked;//maha 082203  override

ii_filter_index = 1
ddplb_filters.SelectItem(1)
is_filter = ddplb_filters.Text
//messagebox("is_filter",is_filter)
tab_1.SelectTab(2)

is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters ) //evan 08.05.2011 - set return value to is_display_text

//tab_1.SelectTab(2)
end event

event dw_expiring_credential_graph::constructor;call super::constructor;This.of_SetUpdateAble(False)
end event

type tabpage_exp_appointments from w_action_items`tabpage_exp_appointments within tab_analysis
boolean visible = false
long backcolor = 81324524
long tabbackcolor = 81324524
end type

type dw_expiring_appointments_graph from w_action_items`dw_expiring_appointments_graph within tabpage_exp_appointments
end type

type tabpage_audit from w_action_items`tabpage_audit within tab_analysis
end type

type dw_app_audit_graph from w_action_items`dw_app_audit_graph within tabpage_audit
end type

event dw_app_audit_graph::doubleclicked;ii_filter_index = 4
ddplb_filters.SelectItem(4)
is_filter = ddplb_filters.Text
//messagebox("is_filter",is_filter)


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 03.03.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Since CreateOnDemand is used, the sequence of the original script should be changed.
/*
inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters )
tab_1.SelectTab(2)
*/
tab_1.SelectTab(2)
is_display_text = inv_action_items.of_filter( ii_org_id, ii_facility_id, is_filter, tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse, is_user_id, ddplb_filters ) //evan 08.05.2011 - set return value to is_display_text
//---------------------------- APPEON END ----------------------------



//tab_1.SelectTab(2)
end event

event dw_app_audit_graph::constructor;call super::constructor;This.of_SetUpdateAble(False)
end event

type tabpage_process from w_action_items`tabpage_process within tab_analysis
end type

type dw_process_graph from w_action_items`dw_process_graph within tabpage_process
end type

type st_msg from w_action_items`st_msg within tabpage_analysis
integer x = 5
integer y = 176
end type

type cb_refresh from w_action_items`cb_refresh within tabpage_analysis
end type

type tabpage_detail from w_action_items`tabpage_detail within tab_1
integer y = 112
integer height = 2076
string text = "Action Items Details"
long tabbackcolor = 80269524
string picturename = "Watcom!"
end type

type cbx_preserve from w_action_items`cbx_preserve within tabpage_detail
end type

type cbx_add_missing from w_action_items`cbx_add_missing within tabpage_detail
end type

type tab_view from w_action_items`tab_view within tabpage_detail
integer y = 196
integer width = 3470
boolean fixedwidth = true
end type

type tabpage_browse from w_action_items`tabpage_browse within tab_view
integer y = 112
integer width = 3433
integer height = 1492
long backcolor = 81324524
string text = "Action Items"
long tabbackcolor = 81324524
string picturename = "Custom023!"
long picturemaskcolor = 553648127
end type

type dw_browse from w_action_items`dw_browse within tabpage_browse
integer x = 46
integer y = 20
end type

type tabpage_details from w_action_items`tabpage_details within tab_view
integer y = 112
integer width = 3433
integer height = 1492
long backcolor = 81324524
long tabbackcolor = 81324524
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
end type

type dw_detail from w_action_items`dw_detail within tabpage_details
end type

type dw_dummy_browse from w_action_items`dw_dummy_browse within tabpage_details
end type

type st_name from w_action_items`st_name within tabpage_details
end type

type sle_doc_find from w_action_items`sle_doc_find within tabpage_detail
end type

type cb_find from w_action_items`cb_find within tabpage_detail
end type

type st_find from w_action_items`st_find within tabpage_detail
end type

type cb_init_recred from w_action_items`cb_init_recred within tabpage_detail
end type

type st_1 from w_action_items`st_1 within tabpage_detail
end type

type cb_recred_no_ver from w_action_items`cb_recred_no_ver within tabpage_detail
end type

type dw_tracker from w_action_items`dw_tracker within tabpage_detail
end type

type cbx_priv from w_action_items`cbx_priv within tabpage_detail
end type

type tabpage_ready from w_action_items`tabpage_ready within tab_1
boolean visible = false
integer y = 112
integer height = 2076
long backcolor = 81324524
long tabbackcolor = 81324524
end type

type rb_meet from w_action_items`rb_meet within tabpage_ready
end type

type rb_record from w_action_items`rb_record within tabpage_ready
end type

type tab_ready from w_action_items`tab_ready within tabpage_ready
integer y = 200
end type

type tabpage_ready_to_send from w_action_items`tabpage_ready_to_send within tab_ready
end type

type dw_ready from w_action_items`dw_ready within tabpage_ready_to_send
end type

type tabpage_sent_to_comm from w_action_items`tabpage_sent_to_comm within tab_ready
end type

type uo_meeting from w_action_items`uo_meeting within tabpage_sent_to_comm
end type

type dw_sent_to_comm from w_action_items`dw_sent_to_comm within tabpage_sent_to_comm
end type

type cb_send from w_action_items`cb_send within tabpage_ready
end type

type dw_committee from w_action_items`dw_committee within tabpage_ready
end type

type st_committee from w_action_items`st_committee within tabpage_ready
end type

type cb_post from w_action_items`cb_post within tabpage_ready
end type

type cb_1 from w_action_items`cb_1 within tabpage_ready
end type

type tabpage_net_dev from w_action_items`tabpage_net_dev within tab_1
integer y = 112
integer height = 2076
long tabbackcolor = 81324524
string picturename = "PasteStatement!"
end type

type uo_net_dev from w_action_items`uo_net_dev within tabpage_net_dev
end type

event uo_net_dev::constructor;call super::constructor;lb_from_prac_folder = False

This.tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '56'" )
This.tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '2583'" )
end event

type tabpage_contract from w_action_items`tabpage_contract within tab_1
integer y = 112
integer height = 2076
end type

type uo_1 from w_action_items`uo_1 within tabpage_contract
end type

type tabpage_document_manager from w_action_items`tabpage_document_manager within tab_1
integer y = 112
integer height = 2076
end type

type uo_lights from w_action_items`uo_lights within w_action_items_ia
end type

type cbx_checklist from w_action_items`cbx_checklist within w_action_items_ia
integer x = 23
integer y = 24
integer width = 0
integer height = 4
end type

type st_buttons from w_action_items`st_buttons within w_action_items_ia
end type

type cb_close from w_action_items`cb_close within w_action_items_ia
end type

type ddplb_filters from w_action_items`ddplb_filters within w_action_items_ia
integer x = 1833
string item[] = {"Expiration Letters Needing Printing","Expiration Letters Awaiting Response","All Action Items For A Practitioner","Incomplete Checklist Items"}
integer itempictureindex[] = {1,0,0,10}
end type

