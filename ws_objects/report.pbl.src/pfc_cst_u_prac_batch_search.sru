$PBExportHeader$pfc_cst_u_prac_batch_search.sru
forward
global type pfc_cst_u_prac_batch_search from userobject
end type
type cbx_prac_cat from checkbox within pfc_cst_u_prac_batch_search
end type
type st_1 from statictext within pfc_cst_u_prac_batch_search
end type
type cbx_state from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_addr_type from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_city from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_county from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_contracts from checkbox within pfc_cst_u_prac_batch_search
end type
type st_app from statictext within pfc_cst_u_prac_batch_search
end type
type dw_app from datawindow within pfc_cst_u_prac_batch_search
end type
type st_facility from statictext within pfc_cst_u_prac_batch_search
end type
type cbx_network from checkbox within pfc_cst_u_prac_batch_search
end type
type dw_wizard from datawindow within pfc_cst_u_prac_batch_search
end type
type cbx_primary_only from checkbox within pfc_cst_u_prac_batch_search
end type
type cb_return from u_cb within pfc_cst_u_prac_batch_search
end type
type cbx_specialty from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_dept from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_facility from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_exp from checkbox within pfc_cst_u_prac_batch_search
end type
type cbx_status from checkbox within pfc_cst_u_prac_batch_search
end type
type cb_next from u_cb within pfc_cst_u_prac_batch_search
end type
type cb_prior from u_cb within pfc_cst_u_prac_batch_search
end type
type cb_search1 from commandbutton within pfc_cst_u_prac_batch_search
end type
type dw_criteria from u_dw within pfc_cst_u_prac_batch_search
end type
type st_help_text from statictext within pfc_cst_u_prac_batch_search
end type
type cb_close from u_cb within pfc_cst_u_prac_batch_search
end type
type gb_1 from groupbox within pfc_cst_u_prac_batch_search
end type
type dw_criteria_box from u_dw within pfc_cst_u_prac_batch_search
end type
end forward

global type pfc_cst_u_prac_batch_search from userobject
integer width = 3173
integer height = 1912
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cbx_prac_cat cbx_prac_cat
st_1 st_1
cbx_state cbx_state
cbx_addr_type cbx_addr_type
cbx_city cbx_city
cbx_county cbx_county
cbx_contracts cbx_contracts
st_app st_app
dw_app dw_app
st_facility st_facility
cbx_network cbx_network
dw_wizard dw_wizard
cbx_primary_only cbx_primary_only
cb_return cb_return
cbx_specialty cbx_specialty
cbx_dept cbx_dept
cbx_facility cbx_facility
cbx_exp cbx_exp
cbx_status cbx_status
cb_next cb_next
cb_prior cb_prior
cb_search1 cb_search1
dw_criteria dw_criteria
st_help_text st_help_text
cb_close cb_close
gb_1 gb_1
dw_criteria_box dw_criteria_box
end type
global pfc_cst_u_prac_batch_search pfc_cst_u_prac_batch_search

type variables
pfc_cst_u_reports inv_reports

boolean ib_facility

Integer il_current_wizard_step = 0
Integer il_wizard_step_cnt = 0
Integer il_facility_ids_all[]
Integer il_facility_id
Integer il_profile_view_id
Integer ii_prac_cnt
integer ii_multi_grp_id
integer ii_prime_dept_only
integer ii_appt_stat[]
long il_app_id = 0


string is_openedfor
String is_group_name
String is_address_types
String is_facility_name
String is_provider_type
String is_users[]
String is_user
String is_user_name
String is_date_range_name
String is_sql
String is_specialties
String is_net_dev_types
String is_department
String is_group
String is_group_id
string is_appmnt_status
string is_contracts
string is_county
string is_city
string is_state
string is_prac_cat

Long il_prac_id
long il_clin_id
long il_num_days
long il_dept[]

String ls_group_id

long il_grp_loc

Date id_from
Date id_to
gs_batch_search ist_search
end variables

forward prototypes
public function integer of_reset ()
public function integer of_wizard (long as_row)
public function integer of_run ()
end prototypes

public function integer of_reset ();string ls_wizard_dw
datawindowchild dwchild
gs_batch_search lst_null


is_specialties = ""
is_department = ""
is_appmnt_status = ""
is_date_range_name = ""
//setnull(il_facility_id)
is_sql = ""
setnull(id_from)
setnull(id_to)
ist_search = lst_null
is_contracts = ""
is_city = ""
is_county = ""
is_state = ""
is_address_types = ""
is_prac_cat = ""

if is_openedfor = "A" then
	dw_app.enabled = true
end if

il_current_wizard_step = 1



ls_wizard_dw = dw_wizard.getitemstring(1,"wizard_dw")

IF ls_wizard_dw = "d_crit_org_facility" then
	if ib_facility then
		ls_wizard_dw = dw_wizard.getitemstring(2,"wizard_dw")
		il_current_wizard_step = 2
	else
		setnull(il_facility_id)
	end if
end if

dw_criteria.dataobject = ls_wizard_dw
dw_criteria.settransobject(sqlca)

		IF ls_wizard_dw = "d_crit_specialties"  THEN   
			dw_criteria.Retrieve()
			//IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
//				dw_criteria.InsertRow( 1 )
//				dw_criteria.SetItem( 1, "lookup_code", 0 )
//				dw_criteria.SetItem( 1, "code", "All" )
//				dw_criteria.SetItem( 1, "description", "Include All Specialties" )		
//				dw_criteria.SetItem( 1, "selected", 1 )
//				st_help_text.Text = 'Select Specialty(s)'
			//END IF	
			st_help_text.Text = 'Select Specialties'
		ELSEIF ls_wizard_dw = "d_crit_department"  THEN    
			dw_criteria.Retrieve()
			//IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
//				dw_criteria.InsertRow( 1 )
//				dw_criteria.SetItem( 1, "lookup_code", 0 )
//				dw_criteria.SetItem( 1, "code", "All" )
//				dw_criteria.SetItem( 1, "description", "Include All Departments" )		
//				dw_criteria.SetItem( 1, "selected", 1 )
//				st_help_text.Text = 'Select Department(s)'
			//END IF		
		////ELSEIF ls_wizard_dw = "d_crit_net_dev_type"  THEN    
		////	dw_criteria.Retrieve()
		////	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
		////		dw_criteria.InsertRow( 1 )
		////		dw_criteria.SetItem( 1, "lookup_code", 0 )
		////		dw_criteria.SetItem( 1, "code", "All" )		
		////		dw_criteria.SetItem( 1, "description", "Include All Selections" )		
		////		dw_criteria.SetItem( 1, "selected", 1 )		
		////	END IF
			ELSEIF ls_wizard_dw = "d_crit_appmnt_status"  THEN   		
				dw_criteria.insertrow(1)
				dw_criteria.SetItem( 1, "active", 1 )
				st_help_text.Text = 'Select Appointment Status'
			ELSEIF ls_wizard_dw = "d_crit_date_range" THEN
				dw_criteria.of_SetDropDownCalendar( TRUE )
				dw_criteria.iuo_calendar.of_Register(dw_criteria.iuo_calendar.DDLB)
				dw_criteria.insertrow(1)
				st_help_text.Text = 'Select Appointment End Date Range'
			ELSEIF ls_wizard_dw = "d_crit_contracts"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select Product/Contract"
			ELSEIF ls_wizard_dw = "d_crit_city"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select City"
			ELSEIF ls_wizard_dw = "d_crit_county"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select County"
			ELSEIF ls_wizard_dw = "d_crit_state"  THEN   
				dw_criteria.Retrieve()
				st_help_text.Text = "Select State"
			ELSEIF ls_wizard_dw = "d_crit_prac_category"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select Category"
			ELSEIF ls_wizard_dw = "d_crit_address_type"  THEN
				//dw_criteria.Retrieve()
				dw_criteria.insertrow(1)
//				dw_criteria.Retrieve()
				st_help_text.Text = "Select Address Type"
			ELSEIF ls_wizard_dw = "d_crit_org_facility" THEN
				dw_criteria.GetChild( "facility_id", dwchild )				
				dwchild.SetTransObject( SQLCA )
				dwchild.Retrieve( gs_user_id )

			IF gs_cust_type = "C" THEN
				st_help_text.Text = 'Select Client'
			ELSEIF gs_cust_type = "I" THEN
				st_help_text.Text = 'Select Payor/Hospital'
			ELSE
				st_help_text.Text = 'Select Facility'
			END IF	
			
		
		END IF
			
			if dw_criteria.DataObject = "d_crit_department" then
				cbx_primary_only.visible = true
			else
				cbx_primary_only.visible = false
			end if


//cb_syntax.enabled = false
cb_next.enabled = true

cb_next.Text = "Next->"

if ib_facility then
	if dw_wizard.rowcount() = 2 then
		cb_next.Text = "Run"
	end if
end if





return 1
end function

public function integer of_wizard (long as_row);String ls_wizard_dw
String ls_last_wizard
String ls_val
String ls_dummy_array[]
String ls_action_status
String ls_action_type

Integer li_rc
Integer li_found
Integer i
Integer li_dummy_array[]
Integer li_appt_row //maha073002
integer li_as_cnt = 0 //maha080902
DataWindowChild dwchild

il_wizard_step_cnt = dw_wizard.rowcount()
//messagebox("",il_wizard_step_cnt)
ls_wizard_dw = dw_wizard.getitemstring(as_row,"wizard_dw")
//dw_criteria.dataobject = ls_wizard_dw
//dw_criteria.settransobject(sqlca)

	choose case ls_wizard_dw
		CASE "d_crit_org_facility"
			if ib_facility = false then
				dw_criteria.GetChild( "facility_id", dwchild )				
				//dwchild.SetTransObject( SQLCA )
				//dwchild.Retrieve( gs_user_id )
				ls_val = dw_criteria.GetText()  
				IF ls_val = "" OR IsNull( ls_val ) THEN
					MessageBox("Selection Error", "You must select a specific Facility. ")
					Return -1
				ELSE
					il_facility_id = dw_criteria.GetItemNumber( 1, "facility_id" )			
					li_found = dwchild.Find( "facility_id = " + String( il_facility_id ), 1, 1000 )					
					IF li_found > 0 THEN
						is_facility_name = dwchild.GetItemString( li_found, "facility_name" )					
					END IF
				END IF
			end if
			
		case "d_crit_department"
//			IF dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
//				is_department = "ALL"
//			ELSE
				is_department = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_department = is_department + String( dw_criteria.GetItemnumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_department = MidA( is_department, 1, LenA( is_department ) -2 )
//			END IF
			IF is_department = "" THEN
				MessageBox("Selection Error", "You must check off at least one department or unselect the criteria and reset." )
				Return -1
			END IF
			
			if cbx_primary_only.checked = true then
				ii_prime_dept_only = 1
			else
				ii_prime_dept_only = 0
			end if
			
		case "d_crit_specialties"
//			IF dw_criteria.GetItemNumber( 1, "selected" ) = 1 THEN
//				is_specialties = "ALL"
//			ELSE
				is_specialties = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_specialties = is_specialties + "'" + String( dw_criteria.GetItemNumber( i, "lookup_code" )) + "', "
					END IF
				END FOR
				is_specialties = MidA( is_specialties, 1, LenA( is_specialties ) -2 )
//			END IF
			IF is_specialties  = "" THEN
				MessageBox("Selection Error", "You must check off at least one Specialty or unselect the criteria and reset." )
				Return -1
			END IF
			
		case "d_crit_date_range"
			dw_criteria.accepttext()
			id_from = dw_criteria.GetItemDate( 1, "from_date" )
			id_to = dw_criteria.GetItemDate( 1, "to_date" )
			IF IsNull( id_from ) AND NOT IsNull( id_to ) THEN
				MessageBox( "Required Data", "You must enter in a From Date." )
				Return -1
			ELSEIF IsNull( id_to ) AND NOT IsNull( id_from ) THEN
				MessageBox( "Required Data", "You must enter in a To Date." )
				Return -1
			END IF
			dw_criteria.iuo_calendar.of_UnRegister()
			is_date_range_name = String( id_from, "mm/dd/yyyy" ) + " - " + String( id_to, "mm/dd/yyyy" )
			
		case "d_crit_appmnt_status"
			is_appmnt_status = ""
			IF dw_criteria.GetItemNumber( 1, "active" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "1,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 1
			END IF
			IF dw_criteria.GetItemNumber( 1, "pending" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "4,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 4
			END IF			
			IF dw_criteria.GetItemNumber( 1, "inactive" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "3,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 3
			END IF						
			IF dw_criteria.GetItemNumber( 1, "history" ) = 1 THEN
				is_appmnt_status = is_appmnt_status + "0,"
				li_as_cnt++
				ii_appt_stat[li_as_cnt] = 0
			END IF
			if is_appmnt_status = "" then
				MessageBox("Selection Error", "You must select at least one status. ")
				Return -1
			ELSE
				is_appmnt_status =  MidA( is_appmnt_status, 1, LenA( is_appmnt_status ) -1 )
			end if
			
			
		case "d_crit_contracts"

				is_contracts = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_contracts = is_contracts + String( dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_contracts = MidA( is_contracts, 1, LenA( is_contracts ) -2 )
			IF is_contracts  = "" THEN
				MessageBox("Selection Error", "You must check off at least one Contract/Product or unselect the criteria and reset." )
				Return -1
			END IF

		case "d_crit_city"

				is_city = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_city = is_city + "'" + String( dw_criteria.GetItemstring( i, "city" )) + "', "
					END IF
				END FOR
				is_city = MidA( is_city, 1, LenA( is_city ) -2 )
			IF is_city  = "" THEN
				MessageBox("Selection Error", "You must check off at least one City or unselect the criteria and reset." )
				Return -1
			END IF
			
		case "d_crit_county"

				is_county = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_county = is_county + String( dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_county = MidA( is_county, 1, LenA( is_county ) -2 )
			IF is_county  = "" THEN
				MessageBox("Selection Error", "You must check off at least one County or unselect the criteria and reset." )
				Return -1
			END IF			
		case "d_crit_state"

				is_state = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_state = is_state + String( dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_state = MidA( is_state, 1, LenA( is_state ) -2 )
			IF is_state  = "" THEN
				MessageBox("Selection Error", "You must check off at least one State or unselect the criteria and reset." )
				Return -1
			END IF			
			
		CASE "d_crit_address_type"
			is_address_types = " And ("
			IF dw_criteria.GetItemNumber( 1, "primary" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.primary_office = 1 OR "
			END IF
			IF dw_criteria.GetItemNumber( 1, "additional" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.additional_office = 1 OR "
			END IF			
			IF dw_criteria.GetItemNumber( 1, "billing" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.billing = 1 OR "
			END IF						
			IF dw_criteria.GetItemNumber( 1, "home" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.home_address = 1 OR "
			END IF
			IF dw_criteria.GetItemNumber( 1, "mailing" ) = 1 THEN
				is_address_types = is_address_types + " pd_address_link.mailing = 1 OR "
			END IF
			is_address_types = MidA( is_address_types, 1, LenA( is_address_types ) -3 ) + ")"

			IF is_address_types = " And (" THEN
				is_address_types = ""
			END IF		

		case "d_crit_prac_category"

				is_prac_cat = ""
				li_rc = dw_criteria.RowCount()
				FOR i = 1 TO li_rc
					IF dw_criteria.GetItemNumber( i, "selected" ) = 1 THEN
						is_prac_cat = is_prac_cat + String( dw_criteria.GetItemNumber( i, "lookup_code" )) + ", "
					END IF
				END FOR
				is_prac_cat = MidA( is_prac_cat, 1, LenA( is_prac_cat ) -2 )
			IF is_prac_cat  = "" THEN
				MessageBox("Selection Error", "You must check off at least one Category or unselect the criteria and reset." )
				Return -1
			END IF
			
			
			
			
			
			
	end choose		


IF cb_next.Text = "Run" THEN
	//cb_syntax.enabled = true
	of_run()
ELSE //next step
	il_current_wizard_step = as_row + 1
	//MessageBox("il_current_wizard_step",il_current_wizard_step)
	//MessageBox("il_wizard_step_cnt", il_wizard_step_cnt)
	
		ls_wizard_dw = dw_wizard.getitemstring(il_current_wizard_step,"wizard_dw")
		dw_criteria.dataobject = ls_wizard_dw
		dw_criteria.settransobject(sqlca)
//		CHOOSE CASE dw_criteria.DataObject
//			CASE "d_crit_address_type"
//				is_address_types = ""
//			CASE "d_crit_specialties"
//				is_specialties = ""
//			CASE "d_crit_provider_type"
//				is_provider_type = ""
//			CASE "d_crit_user"
//				il_facility_ids_all[] = li_dummy_array
//			CASE "d_crit_date_range"
//				SetNull( id_from )
//				SetNull( id_to )
//				is_date_range_name = ""
//			CASE "d_crit_pracs"
//				
//			CASE "d_crit_org_facility"
//				SetNull( il_facility_id )
//				is_facility_name = ""
//				il_facility_ids_all = li_dummy_array
//			CASE "d_crit_profile_view"
//				SetNull( il_profile_view_id )
//		END CHOOSE
	
			IF ls_wizard_dw = "d_crit_specialties"  THEN   
				dw_criteria.Retrieve()
				//IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
//					dw_criteria.InsertRow( 1 )
//					dw_criteria.SetItem( 1, "lookup_code", 0 )
//					dw_criteria.SetItem( 1, "code", "All" )
//					dw_criteria.SetItem( 1, "description", "Include All Specialties" )		
//					dw_criteria.SetItem( 1, "selected", 1 )
					st_help_text.Text = 'Select Specialties'
				//END IF	
			ELSEIF ls_wizard_dw = "d_crit_department"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = 'Select Departments'
					
				//END IF		
			////ELSEIF ls_wizard_dw = "d_crit_net_dev_type"  THEN    
			////	dw_criteria.Retrieve()
			////	IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "insert_blank_row" ) = "Y" THEN
			////		dw_criteria.InsertRow( 1 )
			////		dw_criteria.SetItem( 1, "lookup_code", 0 )
			////		dw_criteria.SetItem( 1, "code", "All" )		
			////		dw_criteria.SetItem( 1, "description", "Include All Selections" )		
			////		dw_criteria.SetItem( 1, "selected", 1 )		
			////	END IF
			
			ELSEIF ls_wizard_dw = "d_crit_appmnt_status"  THEN   		
				dw_criteria.insertrow(1)
				dw_criteria.SetItem( 1, "active", 1 )
				st_help_text.Text = 'Select Appointment Status'
			ELSEIF ls_wizard_dw = "d_crit_date_range" THEN
				dw_criteria.of_SetDropDownCalendar( TRUE )
				dw_criteria.iuo_calendar.of_Register(dw_criteria.iuo_calendar.DDLB)
				dw_criteria.insertrow(1)
				st_help_text.Text = 'Select Appointment End Date Range'
			ELSEIF ls_wizard_dw = "d_crit_contracts"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select Product/Contract"
			ELSEIF ls_wizard_dw = "d_crit_city"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select City"
			ELSEIF ls_wizard_dw = "d_crit_county"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select County"
			ELSEIF ls_wizard_dw = "d_crit_state"  THEN   
				dw_criteria.Retrieve()
				st_help_text.Text = "Select State"
			ELSEIF ls_wizard_dw = "d_crit_prac_category"  THEN    
				dw_criteria.Retrieve()
				st_help_text.Text = "Select Category"
			ELSEIF ls_wizard_dw = "d_crit_address_type"  THEN
				//dw_criteria.Retrieve()
				dw_criteria.insertrow(1)
//				dw_criteria.Retrieve()
				st_help_text.Text = "Select Address Type"
			ELSEIF ls_wizard_dw = "d_crit_org_facility" THEN
				dw_criteria.GetChild( "facility_id", dwchild )				
				dwchild.SetTransObject( SQLCA )
				dwchild.Retrieve( gs_user_id )	
				//IF tab_rpt.tabpage_criteria.dw_wizard_seq.GetItemString( il_current_wizard_step, "multi_select" ) = "Y" THEN				 		
//					dwchild.InsertRow(1)
//					dwchild.SetItem( 1, "facility_id", 0 )
//					dwchild.SetItem( 1, "facility_name", "All")
				//END IF
				IF gs_cust_type = "C" THEN //for intelliapp settings
					st_help_text.Text = 'Select Client'
				ELSEIF gs_cust_type = "I" THEN
					st_help_text.Text = 'Select Payor/Hospital'
				ELSE
					st_help_text.Text = 'Select Facility'
				END IF	
				
			
			END IF
				
				if dw_criteria.DataObject = "d_crit_department" then
					cbx_primary_only.visible = true
				else
					cbx_primary_only.visible = false
				end if
			
	end if
	
	
	IF il_current_wizard_step = il_wizard_step_cnt  THEN
		cb_next.Text = "Run"
	
	ELSE
		cb_next.Text = "Next->"
	END IF
	
st_1.text = string(il_current_wizard_step) + " of " + string(dw_wizard.rowcount()) 

dw_criteria.SetFocus()

Return 1
////
end function

public function integer of_run ();
integer i
integer r
integer rc
string ls_facil
string ls_depart
string ls_specs
string ls_stats
string ls_crit
String ls_presentation_str
String ls_dwsyntax_str
string errors
string ls_month
string ls_day
string ls_year
string ls_value
integer w
long ll_ret_cnt
datetime ldt_from
datetime ldt_to//
n_ds lds_prac_list



is_sql = "select distinct v_full_name.prac_id, v_full_name.full_name from v_full_name"

rc = dw_wizard.rowcount()
 
for i = 1 to rc
	ls_crit = dw_wizard.getitemstring(i,"wizard_dw")
	choose case ls_crit
		case "d_crit_org_facility"
			is_sql  = is_sql + ", pd_affil_stat "
			
		case "d_crit_department"
			is_sql  = is_sql + ", pd_affil_dept "
		case "d_crit_specialties"
			is_sql  = is_sql + ", pd_board_specialty, pd_spec_facility_link "
		case "d_crit_date_range"
			is_sql  = is_sql
		case "d_crit_appmnt_status"
			if PosA(is_sql,"pd_affil_stat ",1) = 0 then
				is_sql  = is_sql  + ", pd_affil_stat "
			end if
		case "d_crit_contracts"
			is_sql  = is_sql + ", pd_contract "
		case "d_crit_city"
			is_sql  = is_sql + ", pd_address "
		case "d_crit_county"
			if PosA(is_sql,"pd_address ",1) = 0 then
				is_sql  = is_sql + ", pd_address "
			end if
		case "d_crit_state"
			if PosA(is_sql,"pd_address ",1) = 0 then
				is_sql  = is_sql + ", pd_address "
			end if
		case "d_crit_prac_category"
			if PosA(is_sql,"pd_basic ",1) = 0 then
				is_sql  = is_sql + ", pd_basic "
			end if
		case "d_crit_address_type"
			if PosA(is_sql,"pd_address ",1) = 0 then
				is_sql  = is_sql + ", pd_address "
			end if
			is_sql  = is_sql + ", pd_address_link "
	end choose	
next
	

//**********************LINKS******************************

is_sql  = is_sql + "~r WHERE "

for i = 1 to rc
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_org_facility" then
		is_sql  = is_sql + "(v_full_name.prac_id = pd_affil_stat.prac_id) "
	end if

	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_department" then
		if i > 1 then is_sql  = is_sql + " and " 
		is_sql  = is_sql + "(pd_affil_stat.rec_id = pd_affil_dept.rec_id) "
	end if

	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_specialties" then
		if i > 1 then is_sql  = is_sql + " and " 
		is_sql  = is_sql + "(v_full_name.prac_id = pd_board_specialty.prac_id)  "
	end if
	
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_contracts" then
		if i > 1 then is_sql  = is_sql + " and " 
		is_sql  = is_sql + "(v_full_name.prac_id = pd_contract.prac_id)  "
	end if
	
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_city" then
		if i > 1 then is_sql  = is_sql + " and " 
		is_sql  = is_sql + "(v_full_name.prac_id = pd_address.prac_id)  "
	end if
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_county" then
		if i > 1 then
			if PosA(is_sql,"= pd_address.prac_id)",1) = 0 then
				is_sql  = is_sql + " and (v_full_name.prac_id = pd_address.prac_id)  "
			end if
		end if
	end if
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_address_type" then
		if i > 1 then 
			if PosA(is_sql,"= pd_address.prac_id)",1) = 0 then
				is_sql  = is_sql + " and (v_full_name.prac_id = pd_address.prac_id)  "
			end if
			is_sql  = is_sql + " and (pd_address.rec_id = pd_address_link.address_id)  "
		end if
	end if	
	if dw_wizard.getitemstring(i,"wizard_dw") = "d_crit_prac_category" then
		if i > 1 then is_sql  = is_sql + " and " 
		is_sql  = is_sql + " (v_full_name.prac_id = pd_basic.prac_id)  "
	end if	
	
	
	
	
	
	
	
next


//messagebox("is_specialties",is_specialties)
//messagebox("is_department",is_department)
//messagebox("is_appmnt_status",is_appmnt_status)
//messagebox("il_facility_id",il_facility_id)
//messagebox("id_from",string(id_from))
//messagebox("id_to",string(id_to))

//*********************Where*************************************

if not isnull(il_facility_id) then
	is_sql  = is_sql + "~r and (pd_affil_stat.parent_facility_id = "  + string(il_facility_id) + ") "
end if 

if not isnull(id_from) then
	//messagebox("id_from",string(id_from))
	ls_month = string(month(id_from))
	//messagebox("id_from",id_from)
	ls_year = string(year(id_from))
	//messagebox("ls_year",li_year)
	if LenA(ls_month) = 1 then ls_month = "0" + ls_month
	ls_day  = string(day(date(id_from)))
	if LenA(ls_day) = 1 then ls_day = "0" + ls_day
	ls_value = ls_year + "-" + ls_month + "-" + ls_day
	is_sql  = is_sql + "~r and (pd_affil_stat.apptmnt_end_date >= '" + ls_value + " 00:00:00"  + "') "
end if

if not isnull(id_to) then
	ls_month = string(month(id_to))
	ls_year = string(year(id_to))
	if LenA(ls_month) = 1 then ls_month = "0" + ls_month
	ls_day  = string(day(id_to))
	if LenA(ls_day) = 1 then ls_day = "0" + ls_day
	ls_value = ls_year + "-" + ls_month + "-" + ls_day	
	is_sql  = is_sql + "~r and (pd_affil_stat.apptmnt_end_date <= '" + ls_value + " 23:59:59" + "') "
end if

if is_appmnt_status <> "" then
	is_sql  = is_sql + "~r and (pd_affil_stat.active_status in( "  + is_appmnt_status + ")) "
end if

if is_specialties <> "" then
	is_sql  = is_sql + "~r and (pd_board_specialty.specialty in( "  + is_specialties + ")) "
end if

if is_department <> "" then
	is_sql  = is_sql + "~r and (pd_affil_dept.department in( "  + is_department + ")) "
end if

if ii_prime_dept_only = 1 then
	is_sql  = is_sql + "~r and (pd_affil_dept.primary_dept = 1) "
end if

IF is_address_types <> "" THEN			
	is_sql = is_sql + is_address_types
END IF
		
IF is_contracts <> "" THEN  //maha 021803
	is_sql = is_sql + " AND ( pd_contract.group_plan IN ( " + is_contracts + "))"			
END IF

IF is_state <> "" THEN  //maha 021803
	is_sql = is_sql + " AND ( pd_address.state IN ( " + is_state + "))"			
END IF

IF is_city <> "" THEN  //maha 021803
	is_sql = is_sql + " AND ( pd_address.city IN ( " + is_city + "))"			
END IF

IF is_county <> "" THEN  //maha 021803
	is_sql = is_sql + " AND ( pd_address.county IN ( " + is_county + "))"			
END IF

IF is_prac_cat <> "" THEN  //maha 021803
	is_sql = is_sql + " AND ( pd_basic.prac_category IN ( " + is_prac_cat + "))"			
END IF

//order by
is_sql  = is_sql + " order by v_full_name.full_name "


//final semicolon

	is_sql  = is_sql + ";"
//messagebox("is_sql",is_sql)
//clipboard(is_sql)

		
		ls_presentation_str = "style(type=grid)"		

		ls_dwsyntax_str = SQLCA.SyntaxFromSQL(is_sql, ls_presentation_str, ERRORS)
		IF LenA(ERRORS) > 0 THEN
			MessageBox("Caution on export field " + is_sql, &
			"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + is_sql)
		//	MessageBox("ls_select_table",ls_select_table)
			
			RETURN -1
		END IF
		lds_prac_list = CREATE n_ds
		w = lds_prac_list.Create( ls_dwsyntax_str, ERRORS)
		if w < 1 then
			messagebox("error on create",errors)
			
			return -1
		end if
		lds_prac_list.SetTransObject( SQLCA )
		ll_ret_cnt = lds_prac_list.retrieve()
		st_help_text.text = string(ll_ret_cnt) + " records"
		
		
		
	//create structure	
	for r = 1 to ll_ret_cnt
		// mskinner 27 dec 2005 -- begin
		ist_search.li_prac_id[r] =  long(lds_prac_list.of_getitem( 'prac_id', r))
		ist_search.ls_name[r]  =  lds_prac_list.of_getitem( 'full_name', r)
		/*
		if upper(gs_user_id) = "MASTER" then
			ist_search.li_prac_id[r] = lds_prac_list.getitemnumber(r,"v_full_name_prac_id")
			ist_search.ls_name[r] = lds_prac_list.getitemstring(r,"v_full_name_full_name")
		else
			ist_search.li_prac_id[r] = lds_prac_list.getitemnumber(r,"prac_id")
			ist_search.ls_name[r] = lds_prac_list.getitemstring(r,"full_name")
		end if
		*/
		// mskinner 27 dec 2005 -- begin
		
		if is_openedfor = "A" then
			ist_search.ll_facility[r] = il_facility_id
			ist_search.ll_app[r] = il_app_id
		end if
	next
		
		
	
		cb_return.enabled = true
				



return 1






end function

on pfc_cst_u_prac_batch_search.create
this.cbx_prac_cat=create cbx_prac_cat
this.st_1=create st_1
this.cbx_state=create cbx_state
this.cbx_addr_type=create cbx_addr_type
this.cbx_city=create cbx_city
this.cbx_county=create cbx_county
this.cbx_contracts=create cbx_contracts
this.st_app=create st_app
this.dw_app=create dw_app
this.st_facility=create st_facility
this.cbx_network=create cbx_network
this.dw_wizard=create dw_wizard
this.cbx_primary_only=create cbx_primary_only
this.cb_return=create cb_return
this.cbx_specialty=create cbx_specialty
this.cbx_dept=create cbx_dept
this.cbx_facility=create cbx_facility
this.cbx_exp=create cbx_exp
this.cbx_status=create cbx_status
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_search1=create cb_search1
this.dw_criteria=create dw_criteria
this.st_help_text=create st_help_text
this.cb_close=create cb_close
this.gb_1=create gb_1
this.dw_criteria_box=create dw_criteria_box
this.Control[]={this.cbx_prac_cat,&
this.st_1,&
this.cbx_state,&
this.cbx_addr_type,&
this.cbx_city,&
this.cbx_county,&
this.cbx_contracts,&
this.st_app,&
this.dw_app,&
this.st_facility,&
this.cbx_network,&
this.dw_wizard,&
this.cbx_primary_only,&
this.cb_return,&
this.cbx_specialty,&
this.cbx_dept,&
this.cbx_facility,&
this.cbx_exp,&
this.cbx_status,&
this.cb_next,&
this.cb_prior,&
this.cb_search1,&
this.dw_criteria,&
this.st_help_text,&
this.cb_close,&
this.gb_1,&
this.dw_criteria_box}
end on

on pfc_cst_u_prac_batch_search.destroy
destroy(this.cbx_prac_cat)
destroy(this.st_1)
destroy(this.cbx_state)
destroy(this.cbx_addr_type)
destroy(this.cbx_city)
destroy(this.cbx_county)
destroy(this.cbx_contracts)
destroy(this.st_app)
destroy(this.dw_app)
destroy(this.st_facility)
destroy(this.cbx_network)
destroy(this.dw_wizard)
destroy(this.cbx_primary_only)
destroy(this.cb_return)
destroy(this.cbx_specialty)
destroy(this.cbx_dept)
destroy(this.cbx_facility)
destroy(this.cbx_exp)
destroy(this.cbx_status)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_search1)
destroy(this.dw_criteria)
destroy(this.st_help_text)
destroy(this.cb_close)
destroy(this.gb_1)
destroy(this.dw_criteria_box)
end on

type cbx_prac_cat from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 764
integer width = 782
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Practitioner Category"
end type

type st_1 from statictext within pfc_cst_u_prac_batch_search
integer x = 1106
integer y = 1536
integer width = 517
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cbx_state from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 1172
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "State"
end type

type cbx_addr_type from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 1464
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Address Type"
end type

type cbx_city from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 1268
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "City"
end type

type cbx_county from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 1364
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "County"
end type

type cbx_contracts from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 944
integer width = 699
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Product/Contract"
end type

type st_app from statictext within pfc_cst_u_prac_batch_search
integer x = 78
integer y = 1704
integer width = 379
integer height = 56
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Application"
boolean focusrectangle = false
end type

type dw_app from datawindow within pfc_cst_u_prac_batch_search
integer x = 73
integer y = 1772
integer width = 914
integer height = 92
integer taborder = 90
string dataobject = "d_apps_in_batch"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

event itemchanged;il_app_id = long(data)
end event

type st_facility from statictext within pfc_cst_u_prac_batch_search
integer x = 105
integer y = 108
integer width = 800
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cbx_network from checkbox within pfc_cst_u_prac_batch_search
boolean visible = false
integer x = 142
integer y = 1600
integer width = 809
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Network Development"
end type

type dw_wizard from datawindow within pfc_cst_u_prac_batch_search
boolean visible = false
integer x = 1536
integer y = 1460
integer width = 1403
integer height = 220
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_wizard_sequence"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_primary_only from checkbox within pfc_cst_u_prac_batch_search
boolean visible = false
integer x = 1943
integer y = 212
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 80269524
string text = "Use Primary Department Only"
end type

event clicked;if this.checked = true then 
	ii_prime_dept_only = 1
else
	ii_prime_dept_only = 1
end if

//messagebox("ii_prime_dept_only",ii_prime_dept_only)
end event

type cb_return from u_cb within pfc_cst_u_prac_batch_search
integer x = 1646
integer y = 1764
integer width = 731
integer taborder = 70
boolean bringtotop = true
integer weight = 700
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Return with Practitioners"
end type

event clicked;if is_openedfor = "E" then
	Closewithreturn( w_batch_prac_select,is_sql )
	
else //A,P,R
	Closewithreturn( w_batch_prac_select,ist_search )	
end if
end event

type cbx_specialty from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 684
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Specialty"
end type

type cbx_dept from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 484
integer width = 480
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Department"
end type

event clicked;cbx_facility.checked = true
cbx_status.checked = true
end event

type cbx_facility from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 176
integer width = 567
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Parent Facility"
boolean checked = true
end type

event clicked;
cbx_status.checked = true
end event

type cbx_exp from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 384
integer width = 841
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Appointment Expiration"
end type

event clicked;cbx_facility.checked = true
cbx_status.checked = true
end event

type cbx_status from checkbox within pfc_cst_u_prac_batch_search
integer x = 119
integer y = 280
integer width = 526
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Active Status"
boolean checked = true
end type

type cb_next from u_cb within pfc_cst_u_prac_batch_search
integer x = 2519
integer y = 1324
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "Next->"
end type

event clicked;of_wizard( il_current_wizard_step )
end event

type cb_prior from u_cb within pfc_cst_u_prac_batch_search
integer x = 2158
integer y = 1324
integer height = 104
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "<- Reset"
end type

event clicked;of_reset( )
end event

type cb_search1 from commandbutton within pfc_cst_u_prac_batch_search
integer x = 1275
integer y = 1324
integer width = 690
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Start "
end type

event clicked;integer i
integer r
integer rc
string ls_facil
string ls_depart
string ls_specs
string ls_stats
string ls_crit
string ls_obj
datetime ldt_from
datetime ldt_to

if is_openedfor = "A" and il_app_id < 1 then
	messagebox("Start Error","Please select an application")
	return
else
	dw_app.enabled = false
end if


dw_wizard.reset()
//create list of wizards
if cbx_facility.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_org_facility")
	if cbx_facility.enabled = false then
		//set facility
	end if
end if

if cbx_status.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_appmnt_status")
end if

if cbx_exp.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_date_range")
end if

if cbx_dept.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_department")
end if

if cbx_specialty.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_specialties")
end if

if cbx_prac_cat.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_prac_category")
end if

if cbx_contracts.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_contracts")
end if

if cbx_state.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_state")
end if

if cbx_city.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_city")
end if

if cbx_county.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_county")
end if

if cbx_addr_type.checked = true then
	r = dw_wizard.insertrow(0)
	dw_wizard.setitem(r,"wizard_dw","d_crit_address_type")
end if




rc = dw_wizard.rowcount()
st_1.text = "1 of " + string(rc)

if rc < 1 then return

cb_next.enabled = true
cb_prior.enabled = true

of_reset()


end event

type dw_criteria from u_dw within pfc_cst_u_prac_batch_search
event pfc_cst_set_focus ( )
integer x = 1102
integer y = 320
integer width = 1838
integer height = 960
integer taborder = 30
boolean bringtotop = true
end type

event pfc_cst_set_focus;This.SetFocus()
end event

event clicked;call super::clicked;IF row > 0 AND This.DataObject = "d_crit_pracs" THEN
	This.SetRow( row )
	This.ScrollToRow( row )
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
END IF
end event

event constructor;This.of_Setupdateable(False )
end event

event itemchanged;call super::itemchanged;Integer i

//IF This.GetColumnName() = "selected" THEN
//	IF row > 1 THEN
//		This.SetItem( 1, "selected", 0 )
//	ELSE
//		FOR i = 2 TO This.RowCount( )
//			This.SetItem( i, "selected", 0 )
//		END FOR	
//		This.SetItem( 1, "selected", 1 )
//	END IF
//END IF
end event

event rowfocuschanged;call super::rowfocuschanged;	IF This.RowCount() > 1 AND This.DataObject = 'd_crit_pracs' THEN
		//st_batch.Visible = True
	END IF
end event

type st_help_text from statictext within pfc_cst_u_prac_batch_search
integer x = 1125
integer y = 216
integer width = 1637
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
string text = "Click Start When Ready"
boolean focusrectangle = false
end type

type cb_close from u_cb within pfc_cst_u_prac_batch_search
integer x = 2752
integer y = 1764
integer width = 306
integer taborder = 90
boolean bringtotop = true
fontcharset fontcharset = ansi!
string text = "&Cancel"
end type

event clicked;Closewithreturn( w_batch_prac_select ,"Cancel")
end event

type gb_1 from groupbox within pfc_cst_u_prac_batch_search
integer x = 73
integer y = 20
integer width = 914
integer height = 1684
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 80269524
string text = "Select Filters"
end type

type dw_criteria_box from u_dw within pfc_cst_u_prac_batch_search
integer x = 1061
integer y = 44
integer width = 2002
integer height = 1656
integer taborder = 10
boolean titlebar = true
string title = "Selection Criteria"
string dataobject = "d_crit_background"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Integer li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SelectRow( 0, False )
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
	This.SelectRow( li_row, True )
END IF
end event

event constructor;This.of_Setupdateable(False )
end event

