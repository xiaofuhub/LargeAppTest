$PBExportHeader$pfc_cst_u_facility_setup_intelliapp.sru
forward
global type pfc_cst_u_facility_setup_intelliapp from pfc_cst_u_facility_setup
end type
end forward

global type pfc_cst_u_facility_setup_intelliapp from pfc_cst_u_facility_setup
integer width = 4178
integer height = 1980
end type
global pfc_cst_u_facility_setup_intelliapp pfc_cst_u_facility_setup_intelliapp

type variables
string is_Label //Add by Evan 09/19/2008
end variables

on pfc_cst_u_facility_setup_intelliapp.create
call super::create
end on

on pfc_cst_u_facility_setup_intelliapp.destroy
call super::destroy
end on

event constructor;call super::constructor;//BEGIN---Modify by Evan 09/19/2008
/*
debugbreak()
CHOOSE CASE gi_intelliapp_type
		//SINGLE GROUP
	CASE 0
		tab_facilty.tabpage_address.Text = "Payor/Hospital"
		//MULTI SITE GROUP
	CASE 1
		tab_facilty.tabpage_address.Text = "Group"		
		//BILLING COMPANY
	CASE 2
		tab_facilty.tabpage_address.Text = "Client"		
END CHOOSE
*/
SELECT TOP 1 app_stat_facility_label INTO :is_Label FROM icred_settings;	
if IsNull(is_Label) or Trim(is_Label) = '' then is_Label = 'Facility'
tab_facilty.tabpage_address.Text = is_Label 
//END---Modify by Evan 09/19/2008
end event

type cb_links from pfc_cst_u_facility_setup`cb_links within pfc_cst_u_facility_setup_intelliapp
integer x = 2633
integer y = 20
integer width = 507
integer height = 80
end type

type cb_notes from pfc_cst_u_facility_setup`cb_notes within pfc_cst_u_facility_setup_intelliapp
integer x = 1326
end type

type st_step from pfc_cst_u_facility_setup`st_step within pfc_cst_u_facility_setup_intelliapp
integer y = 420
integer height = 68
end type

type cb_next_tab from pfc_cst_u_facility_setup`cb_next_tab within pfc_cst_u_facility_setup_intelliapp
integer y = 292
integer height = 88
end type

event cb_next_tab::clicked;
IF il_last_tab = 4 THEN
	IF cb_save.Event Clicked() = -1 THEN
		Return
	END IF
	ib_adding_new = False
	ib_rules_added = True
	This.Visible = False
	st_step.Visible = False
	tab_facilty.selectTab( 2 )
	cb_add.Enabled = True
	cb_delete.Enabled = True
	cb_save.Enabled = True
	cb_print.Enabled = True
	cb_user.Enabled = True
	tab_facilty.tabpage_browse.Visible = True
	tab_facilty.tabpage_address.Visible = True
	tab_facilty.tabpage_return.Visible = True
	tab_facilty.tabpage_settings.Visible = True
	MessageBox("User Painter", "To assign this facility to a user you need to update the User Painter.")	
	dw_detail.BringToTop = True
	Return
END IF


tab_facilty.SelectTab( il_last_tab )

IF ib_fld_error = True THEN
	This.BringToTop = True
	Return
ELSE
	tab_facilty.tabpage_browse.Visible = False
	tab_facilty.tabpage_address.Visible = False	
	tab_facilty.tabpage_return.Visible = False
	tab_facilty.tabpage_settings.Visible = False
	tab_facilty.tabpage_npdb.Visible = False
	tab_facilty.tabpage_verif.Visible = False
	tab_facilty.tabpage_committee.Visible = False
	il_last_tab ++
	CHOOSE CASE il_last_tab 
		CASE 3
			tab_facilty.tabpage_return.Visible = True
			st_step.Text = "Step 2 of 3"
		CASE 4
			tab_facilty.tabpage_settings.Visible = True
			st_step.Text = "Step 3 of 3"			
//		CASE 5
//			tab_facilty.tabpage_npdb.Visible = True
//			st_step.Text = "Step 4 of 6"			
//		CASE 6
//			tab_facilty.tabpage_verif.Visible = True	
//			st_step.Text = "Step 5 of 6"			
//		CASE 7		
//			tab_facilty.tabpage_committee.Visible = True
//			st_step.Text = "Step 6 of 6"			
//			This.Text = "Save"
	END CHOOSE
	tab_facilty.SelectTab( il_last_tab )				
END IF


This.BringToTop = True
st_step.Visible = True
st_step.BringToTop = True







end event

type cb_user from pfc_cst_u_facility_setup`cb_user within pfc_cst_u_facility_setup_intelliapp
integer x = 2181
end type

type cb_add from pfc_cst_u_facility_setup`cb_add within pfc_cst_u_facility_setup_intelliapp
integer x = 448
integer width = 430
string text = "&Add "
end type

event cb_add::clicked;Integer li_nr
Integer i
Integer li_rc
Integer li_facility_id

IF iw_parent_window.Event pfc_save() < 0 THEN
	Return -1
END IF

tab_facilty.SelectTab( 2 )

ib_adding_new = True
ib_rules_added = False

cb_add.Enabled = False
cb_delete.Enabled = False
//cb_save.Enabled = False
cb_print.Enabled = False
cb_user.Enabled = False

SELECT Max( facility.facility_id )  
INTO :li_facility_id  
FROM facility ;

li_facility_id ++

il_facility_id = li_facility_id

dw_detail.Reset()

li_nr = dw_detail.InsertRow( 0 )
dw_detail.SetItem( li_nr, "facility_id", li_facility_id)
dw_detail.SetItem( li_nr, "appointment_years", 2)// maha 020801
dw_detail.ScrollToRow( li_nr )
dw_detail.SetRow( li_nr )
dw_detail.SetFocus( )

tab_facilty.tabpage_verif.dw_verif_rules.Reset()
tab_facilty.tabpage_committee.dw_committee.Reset()


//tab_facilty.tabpage_committee.Enabled = False
//ib_adding_new = False
end event

type cb_delete from pfc_cst_u_facility_setup`cb_delete within pfc_cst_u_facility_setup_intelliapp
integer x = 887
integer width = 430
end type

type cb_print from pfc_cst_u_facility_setup`cb_print within pfc_cst_u_facility_setup_intelliapp
integer x = 1742
integer width = 430
string text = "Print "
end type

type cb_save from pfc_cst_u_facility_setup`cb_save within pfc_cst_u_facility_setup_intelliapp
integer x = 32
end type

event cb_save::clicked;Integer li_row
Integer li_last_tab
Integer li_last_facility_id
Integer li_retval
Integer li_cr

dw_detail.AcceptText()

li_cr = dw_detail.GetRow()

IF IsNull( dw_detail.GetItemString( li_cr, "facility_name" ) ) THEN
	MessageBox("Required Field", "Please enter the facility name." )
	tab_facilty.SelectTab( 2 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "facility_name" )		
	Return -1
END IF

IF IsNull( dw_detail.GetItemString( li_cr, "street" ) )  THEN
	MessageBox("Required Field", "Please enter the street." )
	tab_facilty.SelectTab( 2 )
	dw_detail.SetFocus( )	
	dw_detail.SetColumn( "street" )	
	Return -1	
END IF


dw_detail.SetColumn( "return_facility_name" )	
IF dw_detail.GetItemString( li_cr, "return_facility_name" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_facility_name" ) )  THEN
	dw_detail.SetItem( li_cr, "return_facility_name", dw_detail.GetItemString( li_cr, "facility_name" ) )
END IF
IF dw_detail.GetItemString( li_cr, "return_street" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_street" ) )  THEN
	dw_detail.SetItem( li_cr, "return_street", dw_detail.GetItemString( li_cr, "street" ) )
END IF		
IF dw_detail.GetItemString( li_cr, "return_street_2" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_street_2" ) )  THEN
	dw_detail.SetItem( li_cr, "return_street_2", dw_detail.GetItemString( li_cr, "street_2" ) )
END IF		
IF dw_detail.GetItemString( li_cr, "return_city" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_city" ) )  THEN
	dw_detail.SetItem( li_cr, "return_city", dw_detail.GetItemString( li_cr, "city" ) )
END IF		
IF dw_detail.GetItemString( li_cr, "return_state" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_state" ) )  THEN
	dw_detail.SetItem( li_cr, "return_state", dw_detail.GetItemString( li_cr, "state" ) )
END IF		
IF dw_detail.GetItemString( li_cr, "return_zip" ) = "" OR +&
   IsNull( dw_detail.GetItemString( li_cr, "return_zip" ) )  THEN
	dw_detail.SetItem( li_cr, "return_zip", dw_detail.GetItemString( li_cr, "zip" ) )
END IF		
		


//IF IsNull( dw_detail.GetItemString( li_cr, "return_facility_name" ) ) THEN
//	MessageBox("Required Field", "Please enter the return facility name." )
//	tab_facilty.SelectTab( 3 )
//	dw_detail.SetFocus( )	
//	dw_detail.SetColumn( "return_facility_name" )	
//	Return -1	
//END IF
//
//IF IsNull( dw_detail.GetItemString( li_cr, "return_street" ) ) THEN
//	MessageBox("Required Field", "Please enter the return street." )
//	tab_facilty.SelectTab( 3 )
//	dw_detail.SetFocus( )	
//	dw_detail.SetColumn( "return_street" )	
//	Return -1	
//END IF
//
//IF IsNull( dw_detail.GetItemNumber( li_cr, "default_data_view_id" ) ) THEN
//	MessageBox("Required Field", "Please enter the default data view for this facility." )
//	tab_facilty.SelectTab( 4 )
//	dw_detail.SetFocus( )	
//	dw_detail.SetColumn( "default_data_view_id" )	
//	Return -1	
//END IF
//
//IF IsNull( dw_detail.GetItemString( li_cr, "letter_path" ) )THEN
//	MessageBox("Required Field", "Please enter the default letter path for this facility." )
//	tab_facilty.SelectTab( 4 )
//	dw_detail.SetFocus( )	
//	dw_detail.SetColumn( "letter_path" )	
//	Return -1	
//END IF
//

li_last_tab = tab_facilty.SelectedTab

li_retval = iw_parent_window.Event pfc_save( )
IF li_retval < 0 THEN
	Return -1
ELSEIF li_retval = 0 THEN
	Return 0
END IF

li_last_facility_id = dw_detail.GetItemNumber( 1, "facility_id" )

iw_parent_window.SetRedraw( False )

tab_facilty.tabpage_browse.dw_browse.Retrieve()
li_row = tab_facilty.tabpage_browse.dw_browse.Find( "facility_id = " + String( li_last_facility_id ), 1, 10000 )
IF li_row < 1 THEN
	Return -1
END IF
tab_facilty.tabpage_browse.dw_browse.SetRow( li_row )
tab_facilty.tabpage_browse.dw_browse.ScrollToRow( li_row )

IF li_last_tab = 1 OR li_last_tab = 5 THEN
	tab_facilty.tabpage_browse.dw_browse.SetFocus( )
	dw_detail.Visible = False
ELSEIF li_last_tab = 6 THEN
	tab_facilty.tabpage_committee.dw_committee.SetFocus()
	dw_detail.Visible = False
ELSE
	dw_detail.Visible = True
	dw_detail.SetFocus( )
	IF li_last_tab = 2 THEN
		dw_detail.Object.DataWindow.VerticalScrollPosition='0'
	ELSEIF li_last_tab = 3 THEN
		dw_detail.Object.DataWindow.VerticalScrollPosition='1888'
	ELSEIF li_last_tab = 4 THEN
		dw_detail.Object.DataWindow.VerticalScrollPosition='4190'		
	END IF
END IF

iw_parent_window.SetRedraw( True )

COMMIT USING SQLCA;

//IF tab_facilty.tabpage_committee.dw_committee.RowCount() = 0 THEN
//	MessageBox("Committee", "Please enter at least one committee and save." )
//	tab_facilty.SelectTab( 6 )
//	tab_facilty.tabpage_committee.Enabled = true //maha 061301
//	Return -1
//END IF	
//
tab_facilty.tabpage_verif.Enabled = True

tab_facilty.SelectTab( li_last_tab )

cb_add.Enabled = True
cb_delete.Enabled = True
cb_print.Enabled = True
cb_user.Enabled = True
end event

type cb_close from pfc_cst_u_facility_setup`cb_close within pfc_cst_u_facility_setup_intelliapp
integer x = 3712
integer y = 20
end type

type tab_facilty from pfc_cst_u_facility_setup`tab_facilty within pfc_cst_u_facility_setup_intelliapp
integer x = 5
integer y = 120
integer width = 4169
integer height = 1852
end type

type tabpage_browse from pfc_cst_u_facility_setup`tabpage_browse within tab_facilty
integer width = 4133
integer height = 1736
end type

type dw_browse from pfc_cst_u_facility_setup`dw_browse within tabpage_browse
integer x = 27
integer y = 24
integer width = 4069
integer height = 1700
end type

event dw_browse::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.02.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

IF This.RowCount() > 0 THEN
	il_facility_id = This.GetItemNumber( currentrow, "facility_id" )

	tab_facilty.tabpage_committee.dw_committee.Retrieve( il_facility_id )
	dw_detail.Retrieve( il_facility_id )
	This.SelectRow( 0, False )
	This.SelectRow( currentrow, True )

	//--------------------------- APPEON BEGIN ---------------------------
	//$<comment> 08.15.2006 By: LeiWei
	//$<reason> Fix a defect.
	//	dw_detail.SetFocus()
	//---------------------------- APPEON END ----------------------------
	//BEGIN---Modify by Evan 09/19/2008
	//iw_parent_window.Title = "Payor/Hospital Painter  ( " + This.GetItemString( currentrow, "facility_name" ) + " )"
	iw_parent_window.Title = is_Label + " Setup ( " + This.GetItemString( currentrow, "facility_name" ) + " )"   //Start Code Change ----05.15.2015 #V15 maha - removed word Painter
	//END---Modify by Evan 09/19/2008
	tab_facilty.tabpage_verif.dw_select_section.Retrieve( 1 )
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.02.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------
end event

type tabpage_address from pfc_cst_u_facility_setup`tabpage_address within tab_facilty
integer width = 4133
integer height = 1736
string text = "Payor/Hospital"
long tabbackcolor = 81324524
end type

type tabpage_return from pfc_cst_u_facility_setup`tabpage_return within tab_facilty
integer width = 4133
integer height = 1736
long tabbackcolor = 81324524
end type

type tabpage_settings from pfc_cst_u_facility_setup`tabpage_settings within tab_facilty
integer width = 4133
integer height = 1736
end type

type tabpage_npdb from pfc_cst_u_facility_setup`tabpage_npdb within tab_facilty
boolean visible = false
integer width = 4133
integer height = 1736
long tabbackcolor = 81324524
end type

type tabpage_verif from pfc_cst_u_facility_setup`tabpage_verif within tab_facilty
boolean visible = false
integer width = 4133
integer height = 1736
long tabbackcolor = 81324524
end type

type mle_3 from pfc_cst_u_facility_setup`mle_3 within tabpage_verif
end type

type mle_2 from pfc_cst_u_facility_setup`mle_2 within tabpage_verif
end type

type mle_1 from pfc_cst_u_facility_setup`mle_1 within tabpage_verif
end type

type cb_2 from pfc_cst_u_facility_setup`cb_2 within tabpage_verif
end type

type dw_verif_rules from pfc_cst_u_facility_setup`dw_verif_rules within tabpage_verif
end type

type dw_select_section from pfc_cst_u_facility_setup`dw_select_section within tabpage_verif
end type

type dw_copy_rules from pfc_cst_u_facility_setup`dw_copy_rules within tabpage_verif
end type

type tabpage_committee from pfc_cst_u_facility_setup`tabpage_committee within tab_facilty
boolean visible = false
integer width = 4133
integer height = 1736
long tabbackcolor = 81324524
end type

type cb_del_all from pfc_cst_u_facility_setup`cb_del_all within tabpage_committee
end type

type cb_del_m from pfc_cst_u_facility_setup`cb_del_m within tabpage_committee
end type

type cb_non_prac from pfc_cst_u_facility_setup`cb_non_prac within tabpage_committee
end type

type cb_batch from pfc_cst_u_facility_setup`cb_batch within tabpage_committee
end type

type cb_member from pfc_cst_u_facility_setup`cb_member within tabpage_committee
end type

type dw_committee_mem from pfc_cst_u_facility_setup`dw_committee_mem within tabpage_committee
end type

type dw_committee_d from pfc_cst_u_facility_setup`dw_committee_d within tabpage_committee
end type

type cb_add_committee from pfc_cst_u_facility_setup`cb_add_committee within tabpage_committee
end type

type dw_committee from pfc_cst_u_facility_setup`dw_committee within tabpage_committee
end type

type cb_del_committee from pfc_cst_u_facility_setup`cb_del_committee within tabpage_committee
end type

type gb_committee from pfc_cst_u_facility_setup`gb_committee within tabpage_committee
end type

type gb_comm_member from pfc_cst_u_facility_setup`gb_comm_member within tabpage_committee
end type

type tabpage_dept_chair from pfc_cst_u_facility_setup`tabpage_dept_chair within tab_facilty
integer width = 4133
integer height = 1736
end type

type cb_1 from pfc_cst_u_facility_setup`cb_1 within tabpage_dept_chair
end type

type cb_del_chair1 from pfc_cst_u_facility_setup`cb_del_chair1 within tabpage_dept_chair
end type

type cb_add_chair1 from pfc_cst_u_facility_setup`cb_add_chair1 within tabpage_dept_chair
end type

type dw_dc_browse from pfc_cst_u_facility_setup`dw_dc_browse within tabpage_dept_chair
end type

type dw_dc_detail from pfc_cst_u_facility_setup`dw_dc_detail within tabpage_dept_chair
end type

type tabpage_workflow from pfc_cst_u_facility_setup`tabpage_workflow within tab_facilty
integer width = 4133
integer height = 1736
end type

type tabpage_webview from pfc_cst_u_facility_setup`tabpage_webview within tab_facilty
integer width = 4133
integer height = 1736
end type

type dw_detail from pfc_cst_u_facility_setup`dw_detail within pfc_cst_u_facility_setup_intelliapp
integer x = 64
integer width = 3653
integer height = 1564
end type

