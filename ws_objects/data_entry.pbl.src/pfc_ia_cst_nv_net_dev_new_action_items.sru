$PBExportHeader$pfc_ia_cst_nv_net_dev_new_action_items.sru
forward
global type pfc_ia_cst_nv_net_dev_new_action_items from pfc_ia_cst_nv_net_dev_new
end type
end forward

global type pfc_ia_cst_nv_net_dev_new_action_items from pfc_ia_cst_nv_net_dev_new
integer width = 4805
integer height = 2012
event pfc_cst_set_security_na ( )
end type
global pfc_ia_cst_nv_net_dev_new_action_items pfc_ia_cst_nv_net_dev_new_action_items

type variables
Integer li_cnt
Boolean ib_done_once = False

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Define a variable to be used in subsequent script.
boolean ib_retr_for_aciton_item
//---------------------------- APPEON END ----------------------------

long il_tv_currentrow //add by appeon:Kater 03.30.2011


end variables

forward prototypes
public function integer of_batch_update_actions ()
public function integer of_set_security_nd ()
public function integer of_bg_color (long al_rgb)
public function integer of_post_resize_ai (integer ai_h, integer ai_w)
end prototypes

event pfc_cst_set_security_na();//===================================
// $<Event>V12.2 App Batch Update   : pfc_cst_set_security_na ()
// $<arguments>
// $ none
// $<returns> $none
// $<description> set Read only secuity control
// $<add> (Appeon) Long.zhang 06.19.2012
//===================================
of_set_security_nd()
end event

public function integer of_batch_update_actions ();//===================================
// $<Function>V12.2 App Batch Update   : of_batch_update_actions ()
// $<arguments>
// $ none
// $<returns>Integer 1 success -1 fail
// $<description> Batch update action items
// $<add> (Appeon) Long.zhang 06.13.2012
//===================================
long ll_row_count
long i
long ll_selected_row[]
long ll_complete_action_status
str_app_update ls_app
string ls_note

select lookup_code into :ll_complete_action_status from code_lookup where lookup_name = 'Action Status' and code = 'Complete';
ll_row_count = tab_1.tabpage_ai.dw_net_dev.rowcount( )
if ll_row_count < 1 then return -1

 tab_1.tabpage_ai.dw_net_dev.accepttext( )
 
for i = 1 to ll_row_count
	if tab_1.tabpage_ai.dw_net_dev.getitemnumber( i,"selected") = 1 then
		ll_selected_row[upperbound(ll_selected_row[])+1] = i
	end if
end for

if upperbound(ll_selected_row[]) = 0 then return -1

open(w_batch_update_actions)
ls_app = Message.powerobjectparm
if not isvalid(ls_app) or isNull(ls_app) then return -1

//Start Code Change ----07.26.2012 #V12 maha - only update if changed field
for i = 1 to upperBound(ll_selected_row[])
	if ls_app.action_status = -100 then
		//no update
	else
		tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"action_status",ls_app.action_status)
	end if
	
	if ls_app.action_type = -100 then
		//no update
	else
		tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"action_type",ls_app.action_type)
	end if
	
	if ls_app.notes = "NoUpdate" then
		//no update
	else //add to existing notes
		ls_note = tab_1.tabpage_ai.dw_net_dev.getitemstring( ll_selected_row[i],"notes")
		if isnull(ls_note) then ls_note = ""
		if len(ls_note) > 0 then ls_note+= "  "
		ls_note += ls_app.notes
		tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"notes",ls_note)
	end if
//End Code Change ----07.26.2012	
		
	if ls_app.action_status = ll_complete_action_status then
		if isnull(	tab_1.tabpage_ai.dw_net_dev.getitemdatetime( ll_selected_row[i],"action_date")) then 	tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"action_date",today())
	end if
	
	//Start Code Change ----10.15.2012 #V12 maha
	if ls_app.send_hist = 1 then
		tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"active_status",0)
	end if
	//End Code Change ----10.15.2012
	
	//Start Code Change ----10.18.2016 #V152 maha - assigned user update
	if ls_app.action_user = "NoUpdate" then
		//no update
	else //add to existing notes
		tab_1.tabpage_ai.dw_net_dev.setitem( ll_selected_row[i],"action_user", ls_app.action_user)
	end if	
	//End Code Change ----10.18.2016
	
end for

if IsValid(w_action_items) then
	w_action_items.event pfc_save()
elseif IsValid(w_action_items_ia) then
	w_action_items_ia.event pfc_save()
end if

return 1
end function

public function integer of_set_security_nd ();//added by long.zhang appeon 06.19.2012 v12.2 app batch update
//called from w_mdi.of_action_items_security for read only security control

tab_1.tabpage_ai.dw_net_dev.modify("selected.protect = 1")
tab_1.tabpage_ai.dw_net_dev.modify("sall.enabled = false")

return super::of_set_security_nd()
end function

public function integer of_bg_color (long al_rgb);return 1

end function

public function integer of_post_resize_ai (integer ai_h, integer ai_w);//Start Code Change ----02.04.2016 #V15 maha
integer li_y
integer li_h

//li_h = ai_w - dw_orgs_facilities.y - 20
dw_orgs_facilities.height = ai_h - 20
This.of_resize_manual() //Modify width, Added by Appeon long.zhang 02.17.2016 (BugL021701)

tab_1.height = dw_orgs_facilities.height - tab_1.y

//tab_1.tabpage_ai.dw_net_dev.y = 
//tab_1.tabpage_ai.dw_appoint_stat.y + tab_1.tabpage_ai.dw_appoint_stat.height + 4
//tab_1.tabpage_ai.dw_tracking.y = tab_1.height - tab_1.tabpage_ai.dw_tracking.height - 108

//tab_1.tabpage_ai.dw_net_dev.height = tab_1.tabpage_ai.height - 20 
tab_1.tabpage_ai.dw_net_dev.height = tab_1.height - 136 //Modified by Appeon long.zhang 02.17.2016 (BugL021701)

tab_1.tabpage_ai.dw_net_dev.width =  tab_1.tabpage_ai.width - 20

//tab_1.tabpage_ids.dw_ids.height = tab_1.height - 124
//tab_1.tabpage_ids.dw_ids.width = tab_1.tabpage_ai.dw_net_dev.width
//tab_1.tabpage_notes.dw_notes.height = tab_1.height - 124
//tab_1.tabpage_notes.dw_notes.width = tab_1.tabpage_ai.dw_net_dev.width
tab_1.tabpage_report.dw_report_data.height = tab_1.height - tab_1.tabpage_report.dw_report_data.y - 128
tab_1.tabpage_report.dw_report_data.width  = tab_1.tabpage_ai.dw_net_dev.width


return 1
end function

on pfc_ia_cst_nv_net_dev_new_action_items.create
call super::create
end on

on pfc_ia_cst_nv_net_dev_new_action_items.destroy
call super::destroy
end on

event constructor;call super::constructor;lb_from_prac_folder = False
tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.height = '56'" )
tab_1.tabpage_ai.dw_net_dev.Modify( "facility_name.width = '2583'" )

of_set_facility_id( -99 )

//---------Begin Modified by alfee 09.15.2010----------
//SK Practitioner Folder (d_net_dev_action_items - > d_..._ai_sk - alfee 10.21.2010)
//dw_orgs_facilities.Height = 1650  //Start Code Change ----02.10.2016 #V15 maha - removed
cb_batch.visible = False
cb_ma.visible = False

//---------Begin Commented by (Appeon)Stephen 07.27.2017 for repeat codes--------
/*
//-------Begin Added by alfee 07.25.2011 ----------------------
//<$Reason>allow use of old format dw
if of_get_app_setting("set_40","I") = 4 then
	tab_1.tabpage_ai.dw_net_dev.dataobject = "d_net_dev_action_items"
elseif tab_1.tabpage_ai.dw_net_dev.DataObject <> "d_net_dev_action_items_ai_sk" then 		
	tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sK"	
end if
//-------End Added ------------------------------------------------
*/
//---------End Commented ------------------------------------------------------

//Start Code Change ----05.23.2011 #V11 maha - moved to dw constructor
//if tab_1.tabpage_ai.dw_net_dev.DataObject <> "d_net_dev_action_items_ai_sk" then 		
//	tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sK"	
//	tab_1.tabpage_ai.dw_net_dev.Of_SetTransObject( sqlca )
//end if

if gb_sk_ver then //restore from the inherited event
	tab_1.tabpage_ai.dw_net_dev.y += 150	
	tab_1.tabpage_ai.dw_net_dev.height -= 150
end if

//if gl_bg_color > 0 then this.of_bg_color(gl_bg_color) //alfee 12.06.2010

//CHOOSE CASE gi_intelliapp_type
//		//SINGLE GROUP
//	CASE 0
//		dw_orgs_facilities.Height = 1672
//		//MULTI SITE GROUP
//	CASE 1
////		ddlb_group_by.DeleteItem( 2 )
////		ddlb_group_by.AddItem( "Group" )
////		ddlb_group_by.AddItem( "Group/Application" )						
//		dw_orgs_facilities.Height = 820
//		dw_payors.Height = 832
//		//BILLING COMPANY
//	CASE 2
//	//	ddlb_group_by.DeleteItem( 2 )		
//	//	ddlb_group_by.AddItem( "Client" )		
//	//	ddlb_group_by.AddItem( "Client/Application" )				
//		dw_orgs_facilities.Height = 820
//		dw_payors.Height = 832		
//END CHOOSE
//----------End Modified -----------------------------------

 //Start Code Change ----07.30.2015 #V15 maha - moved from tab selection changed event
	if of_get_app_setting("set_40","I") = 4 then //Start Code Change ----05.23.2011 #V11 maha - allow use of old format dw
		tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items"
	else
		if tab_1.tabpage_ai.dw_net_dev.DataObject <> "d_net_dev_action_items_ai_sk" then 		
			tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sk"
		end if
	end if
	tab_1.tabpage_ai.dw_net_dev.Of_SetTransObject( sqlca )
	
	DataWindowChild dwchild

	gnv_appeondb.of_startqueue( )

	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_dept", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Action Department")

	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_status", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve("Action Status")

//Comment by Appeon long.zhang 06.15.2017
//	//Added by Appeon long.zhang 06.12.2017 (V15.3 Bug #5674 - Workflow: When Changing the status of one action type, 1 or more actions statuses change to codes)
//	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_status_wf", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve("Action Status")
	
	//---------Begin Added by (Appeon)Stephen 07.27.2017 for Applications not showing in Action Items Case#71665 Bug_id#5733--------
	if tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sk" and (isvalid(w_action_items) or isvalid(w_action_items_ia)) then
		tab_1.tabpage_ai.dw_net_dev.modify("gp_id.dddw.name='d_dddw_pd_addresses_gp_id_all'")
		tab_1.tabpage_ai.dw_net_dev.GetChild( "gp_id", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve()			
	end if
	//---------End Added ------------------------------------------------------	
	gnv_appeondb.of_commitqueue( )
	
	//---------Begin Added by (Appeon)Stephen 07.27.2017 for Applications not showing in Action Items Case#71665 Bug_id#5733--------
	if tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sk" and (isvalid(w_action_items) or isvalid(w_action_items_ia)) then
		dwchild.insertrow(1)
		dwchild.setitem(1, "pd_address_gp_id", 0)
		dwchild.setitem(1, "alias_street", "Not Linked")
	end if
	//---------End Added ------------------------------------------------------	

	tab_1.tabpage_ai.dw_net_dev.of_SetDropDownCalendar( TRUE )
	tab_1.tabpage_ai.dw_net_dev.iuo_calendar.of_Register(tab_1.tabpage_ai.dw_net_dev.iuo_calendar.DDLB)





end event

event pfc_cst_net_dev_filter;
Open( w_net_dev_filter)

IF gs_cust_type = "I" THEN
	w_net_dev_filter.is_open_from1 = "PFIA"
ELSE
	w_net_dev_filter.is_open_from1 = "PFCA"	
END IF
w_net_dev_filter.y = w_net_dev_filter.y + 200

//st_as_msg.Visible = False


end event

type tab_1 from pfc_ia_cst_nv_net_dev_new`tab_1 within pfc_ia_cst_nv_net_dev_new_action_items
integer y = 248
integer width = 3465
integer height = 1752
long backcolor = 33551856
end type

event tab_1::selectionchanged;call super::selectionchanged;//IF Not ib_done_once THEN
//	ib_done_once = True
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> PT-02
//	//$<modfiy> 04.13.2006 By: LeiWei
//	//$<reason> Performance tuning
//	//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//	/*
//	tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items"
//	tab_1.tabpage_ai.dw_net_dev.Of_SetTransObject( sqlca )
//	
//	DataWindowChild dwchild
//
//	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_dept", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve("Action Department")
//
//	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_status", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve("Action Status")
//	*/
//	//-----------------Begin Modified by alfee 09.15.2010 --------------------
//	//SK Practitioner Folder (d_net_dev_action_items - > d_..._ai_sk - alfee 10.21.2010)
//	if of_get_app_setting("set_40","I") = 4 then //Start Code Change ----05.23.2011 #V11 maha - allow use of old format dw
//		tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items"
//	else
//		if tab_1.tabpage_ai.dw_net_dev.DataObject <> "d_net_dev_action_items_ai_sk" then 		
//			tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items_ai_sk"
//		end if
//	end if
//	tab_1.tabpage_ai.dw_net_dev.Of_SetTransObject( sqlca )
//	//tab_1.tabpage_ai.dw_net_dev.DataObject = "d_net_dev_action_items"
//	//tab_1.tabpage_ai.dw_net_dev.Of_SetTransObject( sqlca )
//	//-----------------End Modified ---------------------------------------------
//	
//	DataWindowChild dwchild
//
//	gnv_appeondb.of_startqueue( )
//
//	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_dept", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve("Action Department")
//
//	tab_1.tabpage_ai.dw_net_dev.GetChild( "action_status", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve("Action Status")
//
//	gnv_appeondb.of_commitqueue( )
//
//	//---------------------------- APPEON END ----------------------------
//
//	tab_1.tabpage_ai.dw_net_dev.of_SetDropDownCalendar( TRUE )
//	tab_1.tabpage_ai.dw_net_dev.iuo_calendar.of_Register(tab_1.tabpage_ai.dw_net_dev.iuo_calendar.DDLB)
//
//END IF
//
////IF newindex = 1 THEN
////	dw_report.Visible = False
////ELSE
////	dw_report.Visible = True
////END IF
//
////messagebox("","select tab")
end event

type tabpage_ai from pfc_ia_cst_nv_net_dev_new`tabpage_ai within tab_1
integer width = 3429
integer height = 1636
end type

type dw_net_dev from pfc_ia_cst_nv_net_dev_new`dw_net_dev within tabpage_ai
integer x = -9
integer y = 4
integer width = 3424
integer height = 1616
string dataobject = "d_net_dev_action_items_ai_sk"
end type

event dw_net_dev::constructor;call super::constructor;//This.of_SetUpdateable( True )
this.setrowfocusindicator( p_1) //Start Code Change ----01.06.2010 #V10 maha

//----------Begin Commented by alfee 07.25.2011----------------
//<$Reason>moved to the pfc_ia_cst_nv_net_dev_new_action_items.constructor() event;
//<$Reason>1.  pfc_ia_cst_nv_net_dev_new_action_items.constructor() - Change dataoject for dw_net_dev;
//<$Reason>2.  dw_net_dev.constructor() in pfc_cst_nv_net_dev_new - SetTransObject () and Initialize the DDDWs;
//<$Reason>Note: The DDDWs will be retrieved only one time once the dataoject is fixed.

//if of_get_app_setting("set_40","I") = 4 then //Start Code Change ----05.23.2011 #V11 maha - allow use of old format dw
//	this.DataObject = "d_net_dev_action_items"
//else
//	this.DataObject = "d_net_dev_action_items_ai_sK"	
//end if
//----------End Commented ---------------------------------------
end event

event dw_net_dev::buttonclicked;call super::buttonclicked;
long ll_val[],i
long ll_cur_row

if dwo.name = "sall" then //added by long.zhang 06.13.2012  V12.2 App Batch Update
	if this.rowcount( ) < 1 then return
	
	ll_cur_row = this.getrow( )	
	This.setredraw( false)
	if dwo.text = "Select All" then
		
		for i = 1 to this.rowcount( )
			//ll_val[i] = 1
			This.SetItem(i, "selected", 1) //performance tuning - alfee 04.02.2014
		end for
		
		//This.object.selected.Primary = ll_val  - commented by alfee 04.02.2014
		dwo.text = "Deselect All"		
	else
		
		for i = 1 to this.rowcount( )
			//ll_val[i] = 0
			This.SetItem(i, "selected", 0) //performance tuning - alfee 04.02.2014
		end for
		
		//This.object.selected.Primary = ll_val  - commented by alfee 04.02.2014
		dwo.text = "Select All"
	end if
	//-------------appeon begin---------------------
	//<$>added:long.zhang 09.13.2012
	//<$>reason:Fixed BugL091301
	for i = 1 to this.rowcount( )
		this.setitemstatus( i,"selected",Primary!,NotModified!)
	next	
	//--------------appeon end----------------------
	THis.setredraw( true)
	this.setrow( ll_cur_row)
	
end if

//---------Begin Added by (Appeon)Stephen 08.28.2013 for V141 Print Apps From Action Items-------
If w_mdi.menuname = 'm_pfe_cst_net_dev_action_items'  and (isvalid(w_action_items) or isvalid(w_action_items_ia)) then
	iw_action_items.dynamic of_app_print_menu(this,0,0)
end if
//---------End Added ------------------------------------------------------		
end event

event dw_net_dev::clicked;call super::clicked;integer li_select
if row > 0 then	//added by long.zhang 09.13.20120 Fixed BugL091301 
	if dwo.name = "selected" then
		//---------Begin Added by (Appeon)Stephen 08.28.2013 for V141 Print Apps From Action Items--------
		If w_mdi.menuname = 'm_pfe_cst_net_dev_action_items'  and (isvalid(w_action_items) or isvalid(w_action_items_ia)) then
			li_select = this.getitemnumber(row, "selected")
			if li_select = 1 then
				li_select = 0
			else
				li_select = 1
			end if
			iw_action_items.dynamic of_app_print_menu(this, row, li_select)
		end if
		//---------End Added ------------------------------------------------------

		this .post setitemstatus( row,"selected",primary!,NotModified!)
	end if
end if


end event

event dw_net_dev::retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 08.28.2013 (V141 Print Apps From Action Items)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If w_mdi.menuname = 'm_pfe_cst_net_dev_action_items'  and (isvalid(w_action_items) or isvalid(w_action_items_ia))  then
	m_pfe_cst_net_dev_action_items.m_file.m_printapps.enabled = false
end if
end event

type dw_appoint_stat from pfc_ia_cst_nv_net_dev_new`dw_appoint_stat within tabpage_ai
boolean visible = false
end type

type dw_tracking from pfc_ia_cst_nv_net_dev_new`dw_tracking within tabpage_ai
boolean visible = false
integer y = 1692
end type

type tabpage_ids from pfc_ia_cst_nv_net_dev_new`tabpage_ids within tab_1
boolean visible = false
integer width = 3429
integer height = 1636
long backcolor = 33551856
end type

type dw_ids from pfc_ia_cst_nv_net_dev_new`dw_ids within tabpage_ids
integer height = 1628
end type

type tabpage_notes from pfc_ia_cst_nv_net_dev_new`tabpage_notes within tab_1
boolean visible = false
integer width = 3429
integer height = 1636
long backcolor = 33551856
long tabbackcolor = 80269524
end type

type dw_notes from pfc_ia_cst_nv_net_dev_new`dw_notes within tabpage_notes
end type

type st_pnotes from pfc_ia_cst_nv_net_dev_new`st_pnotes within tabpage_notes
end type

type tabpage_report from pfc_ia_cst_nv_net_dev_new`tabpage_report within tab_1
integer width = 3429
integer height = 1636
long backcolor = 33551856
end type

type cb_export from pfc_ia_cst_nv_net_dev_new`cb_export within tabpage_report
integer x = 2656
integer y = 8
end type

type rb_par_sum from pfc_ia_cst_nv_net_dev_new`rb_par_sum within tabpage_report
end type

type rb_ai_wn from pfc_ia_cst_nv_net_dev_new`rb_ai_wn within tabpage_report
end type

type rb_par from pfc_ia_cst_nv_net_dev_new`rb_par within tabpage_report
end type

type rb_ai from pfc_ia_cst_nv_net_dev_new`rb_ai within tabpage_report
end type

type dw_report_data from pfc_ia_cst_nv_net_dev_new`dw_report_data within tabpage_report
integer height = 1536
string dataobject = "d_net_dev_action_items_report_by_prac_ai"
end type

type gb_filter_2 from pfc_ia_cst_nv_net_dev_new`gb_filter_2 within tabpage_report
end type

type cb_2 from pfc_ia_cst_nv_net_dev_new`cb_2 within tabpage_report
end type

type tabpage_ar from pfc_ia_cst_nv_net_dev_new`tabpage_ar within tab_1
integer width = 3429
integer height = 1636
long backcolor = 33551856
end type

type dw_ar from pfc_ia_cst_nv_net_dev_new`dw_ar within tabpage_ar
end type

type dw_orgs_facilities from pfc_ia_cst_nv_net_dev_new`dw_orgs_facilities within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 9
integer y = 32
integer width = 974
integer height = 1964
string dataobject = "d_net_dev_tv_ai"
end type

event dw_orgs_facilities::constructor;call super::constructor;//SK Practitioner Folder - alfee 09.15.2010

//Start Code Change ----03.03.2015 #V15 maha - changed to case; added two level option
choose case gi_intelliapp_type
	case 1,2 //three level
		this.dataobject = 'd_net_dev_tv_ai' 
	case 3  //two level
		this.dataobject = 'd_net_dev_tv_ai_2_level' 
	case 0
		this.dataobject = 'd_pd_affil_status_orgs_ia_action_items' //Start Code Change ----10.22.2012 #V12 maha 
end choose
//End Code Change ----03.03.2015

ib_insertblankrow = false   //Start Code Change ----07.30.2015 #V15 maha - suppress insert blank row

this.of_SetTransObject(SQLCA)	

end event

event dw_orgs_facilities::rowfocuschanged;
if gi_intelliapp_type > 0 then return //non single group (SK Practitioner Folder - alfee 09.15.2010)
//@@@@@@@@@@@!!!! this only runs for set to 0 !!!!@@@@@@@@@@@

//dw_qf.SetItem( 1, "quick_filter", "No Filter Selected" )

//st_as_msg.Visible = False
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 04.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write a condition that when ib_retr_for_action_item is TRUE, 
//$<modification> the RowFocusChanged event will not be executed.
//If ib_retr_for_aciton_item Then Return //Start Code Change ----10.08.2015 #V15 maha - removed
//---------------------------- APPEON END ----------------------------

IF This.GetItemNumber( 1, "parent_facility_id" ) <> 0 THEN
	Return
END IF

IF currentrow > 0 THEN
	ii_facility_id = This.GetItemNumber( currentrow, "parent_facility_id")
	of_retrieve_detail( ii_facility_id )
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )
END IF


IF gi_intelliapp_type > 0 THEN
	IF ii_facility_id = 0 THEN
		dw_payors.DataObject = "d_net_dev_payors_hospitals_ai_all" //maha chamged 063005
		dw_payors.SetTRansObject( SQLCA )
		dw_payors.Retrieve( il_prac_id )  //07.30.2015 maha - this is questionable???
	ELSE	
		dw_payors.DataObject = "d_net_dev_payors_hospitals_ai"
		dw_payors.SetTRansObject( SQLCA )	
		dw_payors.Retrieve( ii_facility_id )
		//messagebox( string( il_prac_id), string( ii_facility_id ))
	END IF
END IF

st_as_msg.visible = false //maha 063005
//IF NOT ib_filter_set THEN //maha 063005 removed filter added to dw query
//	tab_1.tabpage_ai.dw_net_dev.SetFilter( "active_status = 1" )
//	tab_1.tabpage_ai.dw_net_dev.Filter( )
//END IF
end event

event dw_orgs_facilities::clicked;//SK Practitioner Folder - alfee 09.15.2010

string  ls_dw_band
str_dw_band lstr_band

if gi_intelliapp_type > 0 then //non single group
	ls_dw_band = this.GetBandAtPointer()
	lstr_band = of_parse_bandinfo (ls_dw_band)
	
	if lstr_band.band = 'tree.level.1' then 
		if not this.isexpanded(lstr_band.row, 1)  then this.expand( lstr_band.row, 1)
	end if
end if

end event

event dw_orgs_facilities::u_after_retrieve;call super::u_after_retrieve;//SK Practitioner Folder -  alfee 09.16.2010

long i, ll_grpcnt, ll_app_id, ll_found
boolean lb_delete = false

//for non single group
if gi_intelliapp_type > 0 then 
	//remove redundant rows in the treeview datawindow
	for i = 1 to this.rowcount()
		ll_app_id = this.getitemnumber(i,'app_id')
		ll_grpcnt = this.getitemnumber(i,'group_count')
		if ll_app_id =0 and ll_grpcnt > 1 then //'**No Payor or Hospital**
			this.deleterow(i)
			i --
			lb_delete = true
		end if	
	next	
	//refresh treeview datawindow
	if lb_delete then
		this.sort()
		this.groupcalc( )
		ll_found = this.find("parent_facility_id <> 0", 1, this.rowcount())
		if ll_found > 0 then
			this.setrow(ll_found)
			this.scrolltorow(ll_found)
			this.collapseall()			
			this.expand(ll_found, 1)
			this.selecttreenode(ll_found, 2, true)
		end if
	end if
end if

this.modify("Datawindow.zoom=" + string(gi_zoom))  //Start Code Change ----08.01.2017 #V154 maha





end event

event dw_orgs_facilities::doubleclicked;//Start Code Change ----04.04.2011 #V11 maha - removed as funtionality is undeveloped.
//long ll_appid
//
//ll_appid = this.getitemnumber(il_tv_currentrow,"app_id")//modify by Kater 03.30.2011 row is not current row //ll_appid = this.getitemnumber(row,"app_id")
//
//if ll_appid > 0 then
//	openwithparm(w_app_w_prac_notes,ll_appid)
//else
//	//messagebox("Payor not selected",ll_appid)
//end if



end event

event dw_orgs_facilities::treenodeselected;call super::treenodeselected;//------------------- APPEON BEGIN -------------------
//$<add>Kater  03.30.2011
//$<reason>save the current row for treeview
if rowcount() > 0 then
	il_tv_currentrow = row
else
	il_tv_currentrow = 0
end if
//------------------- APPEON END ---------------------
end event

event dw_orgs_facilities::pfc_deleterow;return 1  //Start Code Change ----07.11.2016 #V152 maha - prevent delete from treeview
end event

type gb_filter_1 from pfc_ia_cst_nv_net_dev_new`gb_filter_1 within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 1001
integer y = 20
integer width = 3067
integer height = 220
end type

type cb_ma from pfc_ia_cst_nv_net_dev_new`cb_ma within pfc_ia_cst_nv_net_dev_new_action_items
boolean visible = false
end type

type dw_payors from pfc_ia_cst_nv_net_dev_new`dw_payors within pfc_ia_cst_nv_net_dev_new_action_items
integer y = 840
integer height = 832
end type

event dw_payors::rowfocuschanged;call super::rowfocuschanged;//st_as_msg.Visible = False

//dw_qf.SetItem( 1, "quick_filter", "No Filter Selected" )
end event

type st_as_msg from pfc_ia_cst_nv_net_dev_new`st_as_msg within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 3973
integer y = 252
integer width = 448
integer height = 64
long backcolor = 33551856
end type

type dw_facility_add from pfc_ia_cst_nv_net_dev_new`dw_facility_add within pfc_ia_cst_nv_net_dev_new_action_items
end type

type cb_batch from pfc_ia_cst_nv_net_dev_new`cb_batch within pfc_ia_cst_nv_net_dev_new_action_items
boolean visible = false
end type

type p_1 from pfc_ia_cst_nv_net_dev_new`p_1 within pfc_ia_cst_nv_net_dev_new_action_items
end type

type cbx_compl from pfc_ia_cst_nv_net_dev_new`cbx_compl within pfc_ia_cst_nv_net_dev_new_action_items
boolean visible = true
integer x = 2491
integer y = 260
integer width = 535
long backcolor = 33551856
boolean enabled = true
boolean checked = false
end type

event cbx_compl::constructor;call super::constructor;this.backcolor = parent.backcolor //alfee 10.21.2010
end event

event cbx_compl::clicked; //Start Code Change ----07.30.2015 #V15 maha - overwrite of ancestor
boolean lb_true

if this.checked then
	iw_actions.ib_incomplete_only = false
	lb_true = false
	ib_cbx_compl_checked = true
else
	iw_actions.ib_incomplete_only = true
	lb_true = true
	ib_cbx_compl_checked = false
end if


iw_actions.inv_action_items.of_filter_appl_actions( dw_orgs_facilities , lb_true, is_user_id)

end event

type cb_change from pfc_ia_cst_nv_net_dev_new`cb_change within pfc_ia_cst_nv_net_dev_new_action_items
integer y = 28
end type

type st_filter from pfc_ia_cst_nv_net_dev_new`st_filter within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 1015
integer y = 92
long backcolor = 33551856
end type

type dw_qf from pfc_ia_cst_nv_net_dev_new`dw_qf within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 1294
integer y = 88
end type

event dw_qf::constructor;call super::constructor;DataWindowChild dwchild
Integer li_nr
Long ll_action_status

This.GetChild( "quick_filter", dwchild )

ll_action_status = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(lookup_name) = '"+upper('Action Status') + "' and upper(code) = '"+upper('Complete') +"'"))

//Completed records
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "filter_code", "All completed Actions" )
dwchild.SetItem( li_nr, "filter_description", "Displays a list of all Completed Actions." )
dwchild.SetItem( li_nr, "filter_syntax", "active_status = 1 AND action_status = " + String( ll_action_status )  )
dwchild.SetItem( li_nr, "filter_index", 14  )
end event

type st_group_by from pfc_ia_cst_nv_net_dev_new`st_group_by within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 2286
integer y = 104
long backcolor = 33551856
end type

type ddlb_group_by from pfc_ia_cst_nv_net_dev_new`ddlb_group_by within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 2510
integer y = 92
end type

type st_zoom from pfc_ia_cst_nv_net_dev_new`st_zoom within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 3195
integer y = 96
long backcolor = 33551856
end type

type ddlb_zoom from pfc_ia_cst_nv_net_dev_new`ddlb_zoom within pfc_ia_cst_nv_net_dev_new_action_items
integer x = 3346
integer y = 92
end type

type cb_3 from pfc_ia_cst_nv_net_dev_new`cb_3 within pfc_ia_cst_nv_net_dev_new_action_items
end type

