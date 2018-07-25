$PBExportHeader$n_cst_notification_alert_upd.sru
forward
global type n_cst_notification_alert_upd from nonvisualobject
end type
end forward

global type n_cst_notification_alert_upd from nonvisualobject autoinstantiate
end type

type variables

end variables

forward prototypes
public function long of_update_alert_records (string as_table, datawindow adw)
public function string of_init_update (string as_table, datawindow adw, long al_row, ref boolean ab_upd_cre)
public function boolean of_activestatusfieldexists (string as_table_name)
end prototypes

public function long of_update_alert_records (string as_table, datawindow adw);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_update_alert_records
//
//	Access:  		public
//
//	Arguments:
// as_table			<string> table name
// adw				<datawindow> relative datawindow
//
//	Returns:  		Long
//						1: successful/ -1: failed
//
//	Description:  	Update alert records.
//
//////////////////////////////////////////////////////////////////////////////
//
// Add by andy 01/30/2010 V10.1 - Notification Alert
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_rec_id
String	ls_sql
Long		ll_i, ll_n
String	ls_recid_field
Long		ll_facility_id
Long		ll_prac_id
String	ls_doc_id
String	ls_alert_ids
Boolean	lb_upd_cre
Long		ll_active_status

If IsNull(as_table) Then Return 1
If Not IsValid(adw) Then Return 1

// Get rec_id field name.
Choose Case Lower(as_table)
	Case "meetings"
		ls_recid_field = "meeting_id"		
	Case "pd_oppe_hrd"
		ls_recid_field = "pd_oppe_hdr_id"
	Case Else
		ls_recid_field = "rec_id"		
End Choose

// Update for each row
ll_n = adw.RowCount()
For ll_i = 1 To ll_n
	If adw.Describe(ls_recid_field + ".ColType") <> "!" Then
		ll_rec_id = adw.GetItemNumber(ll_i, ls_recid_field)	
	End If
	
	Choose Case Lower(as_table)
		Case "verif_info"
			ls_doc_id = adw.GetItemString(ll_i, "doc_id")
		Case "pd_affil_stat"
			ll_prac_id = adw.GetItemNumber(ll_i, "prac_id")
			ll_facility_id = adw.GetItemNumber(ll_i, "parent_facility_id")			
	End Choose
	
	// Reset flag
	ls_alert_ids = ""
	lb_upd_cre = False
	// Get some information for update
	ls_alert_ids = of_init_update(as_table, adw, ll_i, lb_upd_cre)
	If lb_upd_cre Then
		ll_active_status = adw.GetItemNumber(ll_i, "active_status")
	End If
	
	Choose Case Lower(as_table)
//		Case "meetings"
			//
			
			
		Case "verif_info"
			// 1. Update active_status.
			If LenA(ls_alert_ids) >0 Then
				ls_sql += &
					"Update alert_records " + & 
					"  Set active_status = 0, reset_date = getdate() " + &
					"Where alert_id in (" + ls_alert_ids + ") " + &
					"  and key_id = '" + ls_doc_id + "' " + &
					"  and active_status > 0; ~r~n"
			End If			
			// 2. Update cre_active_status.
			If lb_upd_cre Then
				ls_sql += &
					"Update alert_records " + & 
					"  Set cre_active_status = " + String(ll_active_status) + &
					" Where table_name = '" + as_table + "' " + &
					"  and key_id = '" + ls_doc_id + "'; ~r~n"
			End If
			
			
		Case "pd_affil_stat"
			// 1. Update active_status.
			If LenA(ls_alert_ids) >0 Then
				if IsNull(ll_rec_id) then continue	//added by long.zhang 09.02.2011 #BugL082902 
				ls_sql += &
					"Update alert_records " + & 
					"  Set active_status = 0, reset_date = getdate() " + &
					"Where alert_id in (" + ls_alert_ids + ") " + &
					"  and rec_id = " + String(ll_rec_id) + &
					"  and active_status > 0; ~r~n"
			End If			
			// 2. Update cre_active_status.
			If lb_upd_cre Then
				if IsNull(ll_rec_id) then continue	//added by long.zhang 09.02.2011 #BugL082902 
				ls_sql += &
					"Update alert_records " + & 
					"  Set cre_active_status = " + String(ll_active_status) + &
					" Where table_name = '" + as_table + "'" + &
					"  and rec_id = " + String(ll_rec_id) + "; ~r~n"
			End If			
			// 3. Update affil_active_status.
			If lb_upd_cre Then
				ls_sql += &
					"Update alert_records " + &
					"  Set affil_active_status = " + String(ll_active_status) + &
					" Where prac_id = " + String(ll_prac_id) + &
					"	and facility_id = " + String(ll_facility_id) + "; ~r~n"
			End If
			
			
		Case Else
			// 1. Update active_status.
			If LenA(ls_alert_ids) >0 Then
				if IsNull(ll_rec_id) then continue	//added by long.zhang 09.02.2011 #BugL082902 
				ls_sql += &
					"Update alert_records " + & 
					"  Set active_status = 0, reset_date = getdate() " + &
					"Where alert_id in (" + ls_alert_ids + ") " + &
					"  and rec_id = " + String(ll_rec_id) + &
					"  and active_status > 0; ~r~n"
			End If			
			// 2. Update cre_active_status.
			If lb_upd_cre Then
				if IsNull(ll_rec_id) then continue	//added by long.zhang 09.02.2011 #BugL082902 
				ls_sql += &
					"Update alert_records " + & 
					"  Set cre_active_status = " + String(ll_active_status) + &
					" Where table_name = '" + as_table + "'" + &
					"  and rec_id = " + String(ll_rec_id) + "; ~r~n"
			End If			
	End Choose
Next

If IsNull(ls_sql) or ls_sql = '' Then Return -1//Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)
	
Execute Immediate :ls_sql;
If SQLCA.SQLCODE = -1 Then 
	Return -1
End If
		
Return 1

end function

public function string of_init_update (string as_table, datawindow adw, long al_row, ref boolean ab_upd_cre);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_init_update
//
//	Access:  		public
//
//	Arguments:
//	as_table		<string> table name
//	adw			<datawindow> relative datawindow
// al_row		<long> row
// ab_upd_cre  <ref boolean>
//
//	Returns:  	<string> Return alert lists 
//
//	Description:  	Get some information for update.
//
//////////////////////////////////////////////////////////////////////////////
//
// Add by andy 01/30/2010 V10.1 - Notification Alert
//
//////////////////////////////////////////////////////////////////////////////

Long		ll_i, ll_Cnt
String	ls_field
Long		ll_alert_id
String	ls_alert_ids


//-----------------------2.25.2016 RP added for just-in-time cache---------------------
gnv_data.of_retrieveIfNecessary("alert_hdr", FALSE)
//---------------------------------------------------------------------------------------------

// 1. Get alert ids
gnv_data.ids_na.SetFilter("table_name='" + as_table + "'")
gnv_data.ids_na.Filter()

ll_Cnt = gnv_data.ids_na.RowCount()
For ll_i = 1 To ll_Cnt
	ls_field = gnv_data.ids_na.GetItemString(ll_i, "field_name")
	If adw.Describe(ls_field + ".ColType") <> "!" Then
		If adw.GetItemStatus(al_row, ls_field, Primary!) = DataModified! Then
			ll_alert_id = gnv_data.ids_na.GetItemNumber(ll_i, "alert_id")
			ls_alert_ids += String(ll_alert_id) + ", "
		End If
	End If
Next
ls_alert_ids = LeftA(ls_alert_ids, LenA(ls_alert_ids) - 2)

// 2. Check active_status
If of_ActiveStatusFieldExists(as_table) Then
	If adw.Describe("active_status.ColType") <> "!" Then
		If adw.GetItemStatus(al_row, "active_status", Primary!) = DataModified! Then
			ab_upd_cre = True
		End If
	End If
End If

Return ls_alert_ids
end function

public function boolean of_activestatusfieldexists (string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_activestatusfieldexists
// $<arguments>
//		string	as_table_name
// $<returns> integer
// $<description> Check active status field if exists in table
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.15.2010
//////////////////////////////////////////////////////////////////////

as_table_name = Lower(Trim(as_table_name))

choose case as_table_name
	case "pd_address", "pd_affil_dept", "pd_attest_questions"
		Return true
	case "pd_dea_state_csr", "pd_dues_fees", "pd_insurance", "pd_license"
		Return true
	case "pd_app_audit", "pd_affil_stat", "pd_oppe_hrd", "net_dev_action_items", "verif_info"
		Return true
	case "meetings"
		// The attendence table have active status field
		Return true
end choose

Return false
end function

on n_cst_notification_alert_upd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_notification_alert_upd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

