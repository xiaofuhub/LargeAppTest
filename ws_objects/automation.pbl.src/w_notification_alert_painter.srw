$PBExportHeader$w_notification_alert_painter.srw
forward
global type w_notification_alert_painter from w_sheet
end type
type cb_audit from commandbutton within w_notification_alert_painter
end type
type cb_copy_step from commandbutton within w_notification_alert_painter
end type
type cb_1 from commandbutton within w_notification_alert_painter
end type
type st_1 from statictext within w_notification_alert_painter
end type
type dw_step_detail from u_dw within w_notification_alert_painter
end type
type dw_step_browse from u_dw within w_notification_alert_painter
end type
type dw_alert_detail from u_dw within w_notification_alert_painter
end type
type dw_alert_browse from u_dw within w_notification_alert_painter
end type
type cb_add_alert from commandbutton within w_notification_alert_painter
end type
type cb_del_alert from commandbutton within w_notification_alert_painter
end type
type cb_save from commandbutton within w_notification_alert_painter
end type
type cb_close from commandbutton within w_notification_alert_painter
end type
type cb_copy_alert from commandbutton within w_notification_alert_painter
end type
type cb_add_step from commandbutton within w_notification_alert_painter
end type
type cb_del_step from commandbutton within w_notification_alert_painter
end type
type gb_2 from groupbox within w_notification_alert_painter
end type
type gb_1 from groupbox within w_notification_alert_painter
end type
end forward

global type w_notification_alert_painter from w_sheet
integer width = 4443
integer height = 2496
string title = "Notification Setup"
long backcolor = 33551856
cb_audit cb_audit
cb_copy_step cb_copy_step
cb_1 cb_1
st_1 st_1
dw_step_detail dw_step_detail
dw_step_browse dw_step_browse
dw_alert_detail dw_alert_detail
dw_alert_browse dw_alert_browse
cb_add_alert cb_add_alert
cb_del_alert cb_del_alert
cb_save cb_save
cb_close cb_close
cb_copy_alert cb_copy_alert
cb_add_step cb_add_step
cb_del_step cb_del_step
gb_2 gb_2
gb_1 gb_1
end type
global w_notification_alert_painter w_notification_alert_painter

type variables
boolean ib_CopyAlert = false
boolean ib_DeleteAlert = false
end variables

forward prototypes
public function integer of_savemaster ()
public function boolean of_datachanged (datawindow adw_data)
public function integer of_savedata ()
public function integer of_savedetail ()
public function integer of_filteralerttypedddw (integer ai_alert_catetory)
public function integer of_selectemail ()
public function integer of_inittablenamedddw ()
public function integer of_filtertablenamedddw (integer ai_alert_type)
public function integer of_setfieldname (string as_table_name)
public function integer of_setemailinfonull ()
public function integer of_setemailenabled (integer ai_flag)
public function integer of_setactionitemenabled (integer ai_alert_type, boolean ab_clear)
public function boolean of_alerttypeexists (integer ai_alert_type)
public function integer of_setadvancedaysenabled ()
public function integer of_determinerunfrom (long al_alert_type, long al_row)
public function integer of_filterfieldnamedddw (string as_table_name)
public function integer of_initfieldnamedddw ()
public function integer of_select_attachment ()
end prototypes

public function integer of_savemaster ();//////////////////////////////////////////////////////////////////////
// $<function> of_savemaster
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_alert_id
long i, ll_NewRowCount
string ls_Label
string ls_Column
DWItemStatus ldis_Status

// Check data
if not of_DataChanged(dw_alert_browse) then Return 1
for i = 1 to dw_alert_detail.RowCount()
	ldis_Status = dw_alert_detail.GetItemStatus(i, 0, Primary!)
	if ldis_Status = NotModified! then Continue
	if ldis_Status = New! or ldis_Status = NewModified! then
		ll_NewRowCount ++
	end if
	ls_Column = ""
	if not f_validstr(String(dw_alert_detail.object.alert_name[i])) then ls_Column = "alert_name"
	if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.alert_category[i])) then ls_Column = "alert_category"
	if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.alert_type[i])) then ls_Column = "alert_type"
	if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.active_status[i])) then ls_Column = "active_status"
	//modify Michael 07.12.2012 V12.2 Notification Email an Attachment
	//if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.run_from[i])) then ls_Column = "run_from"
	if dw_alert_detail.object.alert_type[i] <> 22 then
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.run_from[i])) then ls_Column = "run_from"
	end if
	if dw_alert_detail.object.alert_type[i] <> 30 and dw_alert_detail.object.alert_type[i] <> 22 and  dw_alert_detail.object.alert_type[i] <> 40 then //modify Michael 07.11.2012 :add '22' V12.2 Notification Email an Attachment //(Appeon)Stephen 11.24.2016 - add '40' V15.3-Combined Expiring Credentials in Notifications
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.table_name[i])) then ls_Column = "table_name"
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.field_name[i])) then ls_Column = "field_name"
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.upper_range[i])) then ls_Column = "upper_range"
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.active_only[i])) then ls_Column = "active_only"
		if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.facility_id[i])) then ls_Column = "facility_id"
	end if
//	if ls_Column = "" and dw_alert_detail.object.run_frequency[i] < 1 then
//		dw_alert_browse.ScrollToRow(i)
//		dw_alert_detail.SetColumn("run_frequency")
//		MessageBox("Prompt", "The Run Frequency is invalid.")
//		dw_alert_detail.SetFocus()
//		Return -1
//	end if
	if ls_Column = "" and not f_validstr(String(dw_alert_detail.object.next_run_date[i])) then ls_Column = "next_run_date"
	if ls_Column <> "" then
		ls_Label = dw_alert_detail.Describe(ls_Column + "_t.text")
		dw_alert_browse.ScrollToRow(i)
		dw_alert_detail.SetColumn(ls_Column)
		MessageBox("Prompt", "The " + ls_Label + " cannot be null.")
		dw_alert_detail.SetFocus()
		Return -1
	end if
next

// Set primary key
if ll_NewRowCount > 0 then
	SELECT max(alert_id) INTO :ll_alert_id FROM alert_hdr;
	if IsNull(ll_alert_id) then ll_alert_id = 0
	for i = 1 to dw_alert_browse.RowCount()
		if dw_alert_browse.GetItemStatus(i, 0, Primary!) = NewModified! then
			ll_alert_id ++
			dw_alert_browse.SetItem(i, "alert_id", ll_alert_id)
		end if
	next
end if

// Save data
if dw_alert_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
	Return -1
end if

Return 1
end function

public function boolean of_datachanged (datawindow adw_data);//////////////////////////////////////////////////////////////////////
// $<function> of_datachanged
// $<arguments>
//			datawindow	adw_data
// $<returns> boolean
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

adw_data.AcceptText()
dw_alert_detail.AcceptText()
dw_step_detail.AcceptText()

if adw_data.ModifiedCount() + adw_data.DeletedCount() > 0 then
	Return true
else
	Return false
end if
end function

public function integer of_savedata ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedata
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

if of_SaveMaster() = -1 then Return -1
if of_SaveDetail() = -1 then Return -1

Return 1
end function

public function integer of_savedetail ();//////////////////////////////////////////////////////////////////////
// $<function> of_savedetail
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_as_id
long ll_alert_type
long ll_upper_range
long ll_MasterRow
long i, ll_NewRowCount
string ls_Label
string ls_Column
DWItemStatus ldis_Status

ll_MasterRow = dw_alert_browse.GetRow()
if ll_MasterRow < 1 then Return 1
if not of_DataChanged(dw_step_browse) then Return 1
ll_alert_type = dw_alert_browse.object.alert_type[ll_MasterRow]

// Check data
for i = 1 to dw_step_detail.RowCount()
	ldis_Status = dw_step_detail.GetItemStatus(i, 0, Primary!)
	if ldis_Status = NotModified! then Continue
	if ldis_Status = New! or ldis_Status = NewModified! then
		ll_NewRowCount ++
	end if
	
	ls_Column = ""
	if not f_validstr(String(dw_step_detail.object.step_description[i])) then ls_Column = "step_description"
	if ll_alert_type <> 30 and  ll_alert_type <> 22 and  ll_alert_type <> 40 then //(Appeon)Stephen 12.02.2016 -add '40' V15.3-Combined Expiring Credentials in Notifications//modify Michael 07.11.2012:add '22' V12.2 Notification Email an Attachment
		if ls_Column = "" and not f_validstr(String(dw_step_detail.object.advance_days[i])) then ls_Column = "advance_days"
	end if
	
	//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
	if ll_alert_type = 40 then
		if ls_Column = "" and not f_validstr(String(dw_step_detail.object.next_run_days[i])) then ls_Column = "next_run_days"
	end if
	//---------End Added ------------------------------------------------------
	
	if ls_Column <> "" then
		ls_Label = dw_step_detail.Describe(ls_Column + "_t.text")
		dw_step_browse.ScrollToRow(i)
		dw_step_detail.SetColumn(ls_Column)
		MessageBox("Prompt", "The " + ls_Label + " cannot be null.")
		dw_step_detail.SetFocus()
		Return -1
	end if
next

// Sort steps and check advance_days
if dw_step_browse.RowCount() > 0 then
	dw_step_browse.Sort()
	dw_step_browse.ScrollToRow(1)
	dw_step_detail.ScrollToRow(1)
	dw_step_browse.SelectRow(0, false)
	dw_step_browse.SelectRow(1, true)
	for i = 1 to dw_step_browse.RowCount()
		dw_step_browse.SetItem(i, "step_order", i)
	next
	if ll_alert_type <> 30 and ll_alert_type <> 40  then //(Appeon)Stephen 12.02.2016 - add '40' V15.3-Combined Expiring Credentials in Notifications
		ll_upper_range = dw_alert_detail.object.upper_range[ll_MasterRow]
		if dw_step_browse.object.advance_days[1] <> ll_upper_range then
			dw_step_detail.SetColumn("advance_days")
			MessageBox("Prompt", "The Advance Days of first step must be " + String(ll_upper_range))
			dw_step_detail.SetFocus()
			Return -1
		end if
	end if
end if

// Set primary and foreign key
if ll_NewRowCount > 0 then
	SELECT max(as_id) INTO :ll_as_id FROM alert_steps;
	if IsNull(ll_as_id) then ll_as_id = 0
	for i = 1 to dw_step_browse.RowCount()
		if dw_step_browse.GetItemStatus(i, 0, Primary!) = NewModified! then
			ll_as_id ++
			dw_step_browse.SetItem(i, "as_id", ll_as_id)
			dw_step_browse.SetItem(i, "alert_id", dw_alert_browse.object.alert_id[ll_MasterRow])
		end if
	next
end if

// Save data
if dw_step_browse.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Error", "Failed to save data.", StopSign!)
	Return -1
end if

Return 1
end function

public function integer of_filteralerttypedddw (integer ai_alert_catetory);//////////////////////////////////////////////////////////////////////
// $<function> of_filteralerttypedddw
// $<arguments>
//			integer	ai_alert_catetory
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.06.2010
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_child

dw_alert_detail.GetChild("alert_type", ldwc_child)
if IsNull(ai_alert_catetory) then
	ldwc_child.SetFilter("1 <> 1")
else
	ldwc_child.SetFilter("alert_category = " + String(ai_alert_catetory))
end if
ldwc_child.Filter()

Return 1
end function

public function integer of_selectemail ();//////////////////////////////////////////////////////////////////////
// $<function> of_selectemail
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.07.2010
//////////////////////////////////////////////////////////////////////

long   i, j
string ls_email_to
string ls_email_list
string ls_new_mail[]
string ls_curr_email[]
boolean lb_Exists
n_cst_string lnv_string

//---------Begin Modified by (Appeon)Harry 08.09.2013 for V141 ISG-CLX--------
//OpenWithParm(w_ctx_alarm_users, "NotSelectIC!")
OpenWithParm(w_alarm_users, "NotSelectIC!")
//---------End Modfiied ------------------------------------------------------

ls_email_list = Message.StringParm
IF LenA(Trim(ls_email_list)) < 1 THEN RETURN 0

dw_step_detail.AcceptText()
ls_email_to = dw_step_detail.GetItemString(dw_step_detail.GetRow(), "email_to")

IF IsNull(ls_email_to) OR LenA(Trim(ls_email_to)) < 1 THEN
	dw_step_detail.SetItem(dw_step_detail.GetRow(), "email_to", ls_email_list)
ELSE
	lnv_string.of_parsetoarray(Trim(ls_email_to), ';', ls_curr_email)
	lnv_string.of_parsetoarray(Trim(ls_email_list), ';', ls_new_mail)
	ls_email_list = ""
	FOR i = 1 to UpperBound(ls_new_mail)
		lb_Exists = false
		FOR j = 1 to UpperBound(ls_curr_email)
			IF Upper(Trim(ls_new_mail[i])) = Upper(Trim(ls_curr_email[j])) THEN
				lb_Exists = true
				EXIT
			END IF
		NEXT		
		IF lb_Exists THEN CONTINUE
		
		IF LenA(ls_email_list) < 1 THEN
			ls_email_list = ls_new_mail[i]
		ELSE
			ls_email_list += '; ' + ls_new_mail[i]
		END IF
	NEXT

	IF LenA(ls_email_list) > 0 THEN 
		IF	RightA(Trim(ls_email_to),1) <> ';' THEN ls_email_to = RightTrim(ls_email_to) + '; '
		ls_email_to = ls_email_to + ls_email_list
		dw_step_detail.SetItem(dw_step_detail.GetRow(), "email_to", ls_email_to)
	END IF
END IF	

RETURN 1
end function

public function integer of_inittablenamedddw ();//////////////////////////////////////////////////////////////////////
// $<function> of_inittablenamedddw
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.08.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
DataWindowChild ldwc_child
DataWindowChild ldwc_temp

dw_alert_browse.GetChild("table_name", ldwc_child)

//////////////////////////////////////////////////////////////////
// Alert category for Expired Record
// Appointments
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 11)
ldwc_child.SetItem(ll_Row, "table_name", "pd_affil_stat")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Appointments")

// OPPE/FPPE
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 12)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "table_name_allias", "OPPE/FPPE")

// Appl Stat Items Due
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 13)
ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Appl Stat Items")

// Missing App Audit
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 14)
ldwc_child.SetItem(ll_Row, "table_name", "pd_app_audit")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Missing App Audit")

// Verification Due
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 15)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Verification Infomation")

// Verif Last Sent Date
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 16)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Verification Infomation")

//////////////////////////////////////////////////////////////////
// Alert category for Scheduled by Date
// Birthday
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 20)
ldwc_child.SetItem(ll_Row, "table_name", "pd_basic")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Basic Infomation")

// Meeting Notices
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 21)
ldwc_child.SetItem(ll_Row, "table_name", "meetings")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Meetings")

//////////////////////////////////////////////////////////////////
// Alert category for Created Data
// New Practitioner
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "alert_type", 30)
ldwc_child.SetItem(ll_Row, "table_name", "pd_basic")
ldwc_child.SetItem(ll_Row, "table_name_allias", "Basic Infomation")

//////////////////////////////////////////////////////////////////
dw_alert_detail.GetChild("table_name", ldwc_temp)
ldwc_temp.Reset()
ldwc_child.RowsCopy(1, ldwc_child.RowCount(), Primary!, ldwc_temp, 1, Primary!)

Return 1
end function

public function integer of_filtertablenamedddw (integer ai_alert_type);//////////////////////////////////////////////////////////////////////
// $<function> of_filtertablenamedddw
// $<arguments>
//			integer	ai_alert_type
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.08.2010
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_child

dw_alert_detail.GetChild("table_name", ldwc_child)
if IsNull(ai_alert_type) then
	ldwc_child.SetFilter("1 <> 1")
else
	ldwc_child.SetFilter("alert_type = " + String(ai_alert_type))
end if
ldwc_child.Filter()

Return 1
end function

public function integer of_setfieldname (string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_setfieldname
// $<arguments>
//			string	as_table_name
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.08.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
string ls_table_name
string ls_field_name

ls_table_name = Lower(Trim(as_table_name))

choose case ls_table_name
	case "10-pd_license", "10-pd_dea_state_csr", "10-pd_special_certs", "10-pd_board_specialty", "10-pd_cpr_certifiation"
		ls_field_name = "expiration_date" //Credential Data
	case "11-pd_affil_stat"        //Appointments
		ls_field_name = "apptmnt_end_date"
	case "12-pd_oppe_hrd"          //OPPE/FPPE
		ls_field_name = "to_date"
	case "13-net_dev_action_items" //Appl Stat Items Due
		ls_field_name = "due_date"
	case "14-pd_app_audit"         //Missing App Audit
		ls_field_name = "date_completed"
	case "15-verif_info"           //Verification Due
		ls_field_name = "due_date"
	case "16-verif_info"           //Verif last sent date
		ls_field_name = "last_sent"
	case "20-pd_basic"             //Birthday
		ls_field_name = "date_of_birth"
	case "21-meetings"             //Meeting Notices
		ls_field_name = "start_date"
	case "30-pd_basic"             //New Practitioner
		ls_field_name = "(None)"
	case else
		ls_field_name = ""
end choose

ll_Row = dw_alert_detail.GetRow()
if ll_Row > 0 then
	dw_alert_detail.SetItem(ll_Row, "field_name", ls_field_name)
end if

Return 1
end function

public function integer of_setemailinfonull ();//////////////////////////////////////////////////////////////////////
// $<function> of_setemailinfonull
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.08.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_Null

SetNull(ll_Null)
for ll_Row = 1 to dw_step_browse.RowCount()
	dw_step_browse.SetItem(ll_Row, "email_template", ll_Null)
	dw_step_browse.SetItem(ll_Row, "email_prac", 0)
	dw_step_browse.SetItem(ll_Row, "email_from", "")
	dw_step_browse.SetItem(ll_Row, "email_to", "")	
next

Return 1
end function

public function integer of_setemailenabled (integer ai_flag);//////////////////////////////////////////////////////////////////////
// $<function> of_setemailenabled
// $<arguments>
//				integer	ai_Flag
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.08.2010
//////////////////////////////////////////////////////////////////////

if ai_Flag = 0 then
	ai_Flag = 1
	dw_step_detail.object.b_select.enabled = "no"
else
	ai_Flag = 0
	dw_step_detail.object.b_select.enabled = "yes"
end if

dw_step_detail.object.email_template.protect = ai_Flag
dw_step_detail.object.email_prac.protect = ai_Flag
dw_step_detail.object.email_from.protect = ai_Flag
dw_step_detail.object.email_to.protect = ai_Flag

Return 1
end function

public function integer of_setactionitemenabled (integer ai_alert_type, boolean ab_clear);//////////////////////////////////////////////////////////////////////
// $<function> of_setactionitemenabled
// $<arguments>
//				integer	ai_alert_type
//				boolean	ab_clear
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.06.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_Null

choose case ai_alert_type
	case 13, 30
		dw_step_detail.object.action_type.protect = 0
		dw_step_detail.object.app_id.protect = 0
	case else
		dw_step_detail.object.action_type.protect = 1
		dw_step_detail.object.app_id.protect = 1
end choose

if ab_Clear then
	SetNull(ll_Null)
	for ll_Row = 1 to dw_step_detail.RowCount()
		dw_step_detail.SetItem(ll_Row, "action_type", ll_Null)
		dw_step_detail.SetItem(ll_Row, "app_id", ll_Null)
	next
end if

Return 1
end function

public function boolean of_alerttypeexists (integer ai_alert_type);//////////////////////////////////////////////////////////////////////
// $<function> of_alerttypeexists
// $<arguments>
//				integer	ai_alert_type
// $<returns> integer
// $<description> Check alert type if exists
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.09.2010
//////////////////////////////////////////////////////////////////////

long ll_FindRow

ll_FindRow = dw_alert_browse.Find("alert_type = " + String(ai_alert_type), 1, dw_alert_browse.RowCount())
if ll_FindRow > 0 then
	MessageBox("Prompt", "The alert type already exists.")
	Return true
else
	Return false
end if
end function

public function integer of_setadvancedaysenabled ();//////////////////////////////////////////////////////////////////////
// $<function> of_setadvancedaysenabled
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 02.25.2010
//////////////////////////////////////////////////////////////////////

long ll_alert_type
long ll_MasterRow
String ls_null
datawindowchild ldwc_1

ll_MasterRow = dw_alert_browse.GetRow()
if ll_MasterRow = 0 then Return 1
ll_alert_type = dw_alert_browse.object.alert_type[ll_MasterRow]

if ll_alert_type = 30 or ll_alert_type = 22 then //modify Michael 07.11.2012:add '22' V12.2 Notification Email an Attachment
	dw_step_detail.object.advance_days.protect = 1				
else
	dw_step_detail.object.advance_days.protect = 0
end if

//------------------- APPEON BEGIN -------------------
//$<add> Michael 07.11.2012
//$<reason> V12.2 Notification Email an Attachment
if ll_alert_type = 22  then //email_prac
	dw_step_detail.object.attachment_file.protect = 0	
	dw_step_detail.object.b_browse.enabled = "yes"
	//dw_step_detail.object.email_template.protect = 1	
	dw_step_detail.object.email_prac.protect = 1
else
	dw_step_detail.object.attachment_file.protect = 1
	dw_step_detail.object.b_browse.enabled = "no"
	//dw_step_detail.object.email_template.protect = 0
	dw_step_detail.object.email_prac.protect = 0
	//------------------appeon begin--------------------------
	//<$>added :long.zhang 09.04.2012
	//<$>reason:Fixed BugS072604 if alert type is not scheduled email then should clear attach ment file
	if dw_step_detail.getrow() < 1 then return 1 //(Appeon)Stephen 05.30.2014 
	setNull(ls_null)
	if not isNull(dw_step_detail.getitemstring( dw_step_detail.getrow(), "attachment_file")) and dw_step_detail.getitemstring( dw_step_detail.getrow(), "attachment_file") <> "" then
		dw_step_detail.setitem( dw_step_detail.getrow(), "attachment_file",ls_null)
	end if	
	//-----------------appeon end-----------------------------
end if
//------------------- APPEON END ---------------------

//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
dw_step_detail.setredraw(false)
dw_step_detail.getchild("email_template", ldwc_1)
if ll_alert_type = 40 then
	ldwc_1.setfilter("merge_type= 2")
	ldwc_1.filter()
else
	ldwc_1.setfilter("merge_type <> 2")
	ldwc_1.filter()
end if
dw_step_detail.setredraw(true)
//---------End Added ------------------------------------------------------

Return 1
end function

public function integer of_determinerunfrom (long al_alert_type, long al_row);//////////////////////////////////////////////////////////////////////
// $<function> of_determinerunfrom
// $<arguments>
//			long	al_alert_type
//			long	al_row
// $<returns> integer
// $<description> The run_from field is insignificant currently
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.05.2010
//////////////////////////////////////////////////////////////////////

// Determine run from
choose case al_alert_type
	case 10,11 // Expired Record
		dw_alert_detail.SetItem(al_Row, "run_from", 1)
	case 12,13,14,15,16
		dw_alert_detail.SetItem(al_Row, "run_from", 1)
	case 20,21,22, 23 // Scheduled by Date//modify Michael 07.11.2012:add '22' V12.2 Notification Email an Attachment  //Start Code Change ----08.02.016 #V152 maha - added 23
		dw_alert_detail.SetItem(al_Row, "run_from", 1)
	case 30 // Created Data
		dw_alert_detail.SetItem(al_Row, "run_from", 2)
	case 31
		dw_alert_detail.SetItem(al_Row, "run_from", 1)
	case 40 //(Appeon)Stephen 11.24.2016 - V15.3-Combined Expiring Credentials in Notifications
		dw_alert_detail.SetItem(al_Row, "run_from", 1)
end choose

Return 1
end function

public function integer of_filterfieldnamedddw (string as_table_name);//////////////////////////////////////////////////////////////////////
// $<function> of_filterfieldnamedddw
// $<arguments>
//			string	as_table_name
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.25.2010
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_child

dw_alert_detail.GetChild("field_name", ldwc_child)
if IsNull(as_table_name) then
	ldwc_child.SetFilter("table_name = ''")
else
	ldwc_child.SetFilter("table_name = '" + as_table_name + "'")
end if
ldwc_child.Filter()

Return 1
end function

public function integer of_initfieldnamedddw ();//////////////////////////////////////////////////////////////////////
// $<function> of_initfieldnamedddw
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.25.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
DataWindowChild ldwc_child
DataWindowChild ldwc_temp

dw_alert_browse.GetChild("field_name", ldwc_child)

// OPPE/FPPE
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "field_name", "from_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "From Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "field_name", "to_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "To Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "field_name", "req_recieved")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Req Recieved")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "field_name", "plan_comp")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Plan Comp")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_oppe_hrd")
ldwc_child.SetItem(ll_Row, "field_name", "proct_compl")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Proct Compl")

// Appl Stat Items Due
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
ldwc_child.SetItem(ll_Row, "field_name", "action_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Action Date")
//
//ll_Row = ldwc_child.InsertRow(0)
//ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
//ldwc_child.SetItem(ll_Row, "field_name", "next_action_date")
//ldwc_child.SetItem(ll_Row, "field_name_allias", "Next Action Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
ldwc_child.SetItem(ll_Row, "field_name", "due_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Due Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
ldwc_child.SetItem(ll_Row, "field_name", "first_sent")
ldwc_child.SetItem(ll_Row, "field_name_allias", "First Sent")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "net_dev_action_items")
ldwc_child.SetItem(ll_Row, "field_name", "last_sent")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Last Sent")

// Missing App Audit
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "pd_app_audit")
ldwc_child.SetItem(ll_Row, "field_name", "date_completed")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Date Completed")

// Verification Due
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "field_name", "first_sent")
ldwc_child.SetItem(ll_Row, "field_name_allias", "First Sent")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "field_name", "last_sent")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Last Sent")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "field_name", "date_recieved")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Date Recieved")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "field_name", "expiration_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Expiration Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "verif_info")
ldwc_child.SetItem(ll_Row, "field_name", "due_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Due Date")

// Meeting Notices
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "meetings")
ldwc_child.SetItem(ll_Row, "field_name", "start_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "Start Date")
//
ll_Row = ldwc_child.InsertRow(0)
ldwc_child.SetItem(ll_Row, "table_name", "meetings")
ldwc_child.SetItem(ll_Row, "field_name", "end_date")
ldwc_child.SetItem(ll_Row, "field_name_allias", "End Date")

//////////////////////////////////////////////////////////////////
dw_alert_detail.GetChild("field_name", ldwc_temp)
ldwc_temp.Reset()
ldwc_child.RowsCopy(1, ldwc_child.RowCount(), Primary!, ldwc_temp, 1, Primary!)

Return 1
end function

public function integer of_select_attachment ();///////////////////////////////////////////////////////////////////////////
// $<event> of_select_Attachment
// $<arguments>
// $<returns> (None)
// $<description> select attachment file
///////////////////////////////////////////////////////////////////////////
// Add by Appeon: Michael 01.28.2012 V12.2 Notification Email an Attachment
///////////////////////////////////////////////////////////////////////////
int il_rtn
long ll_i
string ls_filepath,ls_file_name[]
string ls_all_files

il_rtn = GetFileOpenName("Select File",	ls_filepath, ls_file_name,  "All Files (*.*),*.*")
if il_rtn = 1 then
	//----------------appeon begin----------------
	//<$>added:long.zhang 09.04.2012
	//<$>reason:Fixed BugS072601
	dw_step_detail.accepttext( )
	ls_all_files = dw_step_detail.getitemstring(dw_step_detail.getrow(),"attachment_file")
	if isNull(ls_all_files) then ls_all_files = ""
	if lenA(ls_all_files) > 0 and right(ls_all_files,1) <> "," then ls_all_files += ","
	//---------------appeon end-------------------
	if UpperBound(ls_file_name) =  1 then
		//ls_all_files = ls_filepath
		ls_all_files += ls_filepath	//long.zhang 09.04.2012
	else 		
		if right(ls_filepath,1) <> "\" then //not root
			ls_filepath = ls_filepath + "\"
		end if
		for ll_i =  1 to UpperBound(ls_file_name)
			if ll_i = UpperBound(ls_file_name) then
				ls_all_files = ls_all_files + ls_filepath + ls_file_name[ll_i] 
			else 
				ls_all_files = ls_all_files + ls_filepath + ls_file_name[ll_i] + ","
			end if
		next 
	end if
	dw_step_detail.setitem(dw_step_detail.getrow(),"attachment_file",ls_all_files)	
	ChangeDirectory(gs_current_path)
end if

return 1
end function

on w_notification_alert_painter.create
int iCurrent
call super::create
this.cb_audit=create cb_audit
this.cb_copy_step=create cb_copy_step
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_step_detail=create dw_step_detail
this.dw_step_browse=create dw_step_browse
this.dw_alert_detail=create dw_alert_detail
this.dw_alert_browse=create dw_alert_browse
this.cb_add_alert=create cb_add_alert
this.cb_del_alert=create cb_del_alert
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_copy_alert=create cb_copy_alert
this.cb_add_step=create cb_add_step
this.cb_del_step=create cb_del_step
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_audit
this.Control[iCurrent+2]=this.cb_copy_step
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.dw_step_detail
this.Control[iCurrent+6]=this.dw_step_browse
this.Control[iCurrent+7]=this.dw_alert_detail
this.Control[iCurrent+8]=this.dw_alert_browse
this.Control[iCurrent+9]=this.cb_add_alert
this.Control[iCurrent+10]=this.cb_del_alert
this.Control[iCurrent+11]=this.cb_save
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_copy_alert
this.Control[iCurrent+14]=this.cb_add_step
this.Control[iCurrent+15]=this.cb_del_step
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_1
end on

on w_notification_alert_painter.destroy
call super::destroy
destroy(this.cb_audit)
destroy(this.cb_copy_step)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_step_detail)
destroy(this.dw_step_browse)
destroy(this.dw_alert_detail)
destroy(this.dw_alert_browse)
destroy(this.cb_add_alert)
destroy(this.cb_del_alert)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_copy_alert)
destroy(this.cb_add_step)
destroy(this.cb_del_step)
destroy(this.gb_2)
destroy(this.gb_1)
end on

event open;call super::open;long ll_alert_type
string ls_table_name
DataWindowChild ldwc_child

dw_alert_browse.SetTransObject(SQLCA)
dw_alert_detail.SetTransObject(SQLCA)
dw_step_browse.SetTransObject(SQLCA)
dw_step_detail.SetTransObject(SQLCA)

dw_alert_browse.ShareData(dw_alert_detail)
dw_step_browse.ShareData(dw_step_detail)
dw_alert_browse.Retrieve()

//------------------- APPEON BEGIN -------------------
//$<add> Evan 02.06.2012
//$<reason> The ability to select facility for new practitioner
dw_alert_browse.GetChild("facility_id", ldwc_child)
ldwc_child.InsertRow(1)
ldwc_child.SetItem(1, "facility_id", 0)
//ldwc_child.SetItem(1, "facility_name", "All Facility")
ldwc_child.SetItem(1, "facility_name", "All Facilities")//long.zhang 11.07.2012
dw_alert_detail.GetChild("facility_id_1", ldwc_child)
ldwc_child.InsertRow(1)
ldwc_child.SetItem(1, "facility_id", 0)
//ldwc_child.SetItem(1, "facility_name", "All Facility")
ldwc_child.SetItem(1, "facility_name", "All Facilities")//long.zhang 11.07.2012
//------------------- APPEON END ---------------------

dw_step_detail.GetChild("email_template", ldwc_child)
ldwc_child.InsertRow(1)
dw_step_detail.GetChild("email_from", ldwc_child)
ldwc_child.InsertRow(1)
dw_step_detail.GetChild("action_type", ldwc_child)
ldwc_child.InsertRow(1)
dw_step_detail.GetChild("app_id", ldwc_child)
ldwc_child.InsertRow(1)

of_InitTableNameDddw()
of_InitFieldNameDddw()
if dw_alert_browse.GetRow() > 0 then
	ll_alert_type = dw_alert_browse.object.alert_type[dw_alert_browse.GetRow()]
	ls_table_name = dw_alert_browse.object.table_name[dw_alert_browse.GetRow()]
	of_FilterTableNameDddw(ll_alert_type)
	of_FilterFieldNameDddw(ls_table_name)
end if
end event

event closequery;//Override
integer li_Result

if of_DataChanged(dw_alert_browse) or of_DataChanged(dw_step_browse) then
	li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			if of_SaveData() = -1 then Return 1
		case 2
			Return 0
		case 3
			Return 1
	end choose
end if

Return 0
end event

event activate;call super::activate;//Inherit
if w_mdi.menuname <> "m_pfe_cst_mdi_menu" then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
end if
end event

event pfc_preopen;call super::pfc_preopen;this.of_SetResize(true)
inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

inv_resize.of_Register(gb_1, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_alert_browse, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(dw_alert_detail, inv_resize.FIXEDBOTTOM_SCALERIGHT)

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 03.20.2013
//$<reason> BugS031806
inv_resize.of_Register(cb_add_step, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_del_step, inv_resize.FIXEDBOTTOM)
inv_resize.of_Register(cb_copy_step, inv_resize.FIXEDBOTTOM)
//------------------- APPEON END -------------------

inv_resize.of_Register(gb_2, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(dw_step_browse, inv_resize.FIXEDBOTTOM_SCALERIGHT)
inv_resize.of_Register(dw_step_detail, inv_resize.FIXEDBOTTOM_SCALERIGHT)
end event

type cb_audit from commandbutton within w_notification_alert_painter
integer x = 3200
integer y = 28
integer width = 425
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&lert Audit"
end type

event clicked;//Start Code Change ----04.12.2010 #V10 maha
open(w_alert_audit)
end event

type cb_copy_step from commandbutton within w_notification_alert_painter
integer x = 2345
integer y = 1344
integer width = 302
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy Ste&p"
end type

event clicked;//Start Code Change ----03.23.2010 #V10 maha
long ll_Row
long ll_alert_id
long ll_alert_type

ll_Row = dw_alert_browse.GetRow()
if ll_Row < 1 then Return
ll_alert_id = dw_alert_browse.object.alert_id[ll_Row]
ll_alert_type = dw_alert_browse.object.alert_type[ll_Row]

//----Begin Modified by Alfee 03.29.2010---
ll_Row = dw_step_browse.GetRow()
if ll_Row < 1 then Return

if of_DataChanged(dw_step_browse) then
//if of_DataChanged(dw_alert_browse) then
//----End Modified ------------------------	
	MessageBox("Prompt", "Please save data first.")
	Return
end if


choose case ll_alert_type
	//case 30
	case 30,22, 40	//(Appeon)Stephen 12.23.2016 - add '40' V15.3-Combined Expiring Credentials in Notifications //long.zhang 09.04.2012 Fixed BugS072602
		if dw_step_browse.RowCount() = 1 then
			MessageBox("Prompt", "You can only define one step for this alert type.")
			Return
		end if		
	case else
		if dw_step_browse.RowCount() = 10 then
			MessageBox("Prompt", "You can only define ten steps for this alert type.")
			Return
		end if
end choose

dw_step_browse.rowscopy( ll_row, ll_row,primary!, dw_step_browse, 100, primary!)

//dw_step_browse.SetItem(ll_Row, "alert_id", ll_alert_id)
//dw_step_browse.SetItem(ll_Row, "email_from", "MASTER")
//dw_step_browse.SetItem(ll_Row, "email_prac", 0)

dw_step_browse.ScrollToRow(ll_Row)
dw_step_detail.SetColumn("step_description")
dw_step_detail.SetFocus()
end event

type cb_1 from commandbutton within w_notification_alert_painter
integer x = 3630
integer y = 28
integer width = 425
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Email Templates"
end type

event clicked;//Start Code Change ----03.23.2010 #V10 maha
open(w_email_painter)

//------------------- APPEON BEGIN -------------------
//$<add> Evan 05.12.2010
//$<reason> Refresh template DDDW data
datawindowchild ldwc_child1
datawindowchild ldwc_child2
dw_step_browse.GetChild("email_template", ldwc_child1)
dw_step_detail.GetChild("email_template", ldwc_child2)
ldwc_child1.SetTransObject(SQLCA)
ldwc_child1.Retrieve()
ldwc_child2.Reset()
ldwc_child1.RowsCopy(1, ldwc_child1.RowCount(), Primary!, ldwc_child2, 1, Primary!)
//------------------- APPEON END ---------------------
end event

type st_1 from statictext within w_notification_alert_painter
integer x = 50
integer y = 24
integer width = 2761
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Note: Changing the Setup of a Notification may affect records currently in the alert process.  This may cause alerts to be triggered unexpectedly, or not triggered, for the existing alert records."
boolean focusrectangle = false
end type

type dw_step_detail from u_dw within w_notification_alert_painter
integer x = 14
integer y = 1880
integer width = 4361
integer height = 496
integer taborder = 140
string dataobject = "d_na_step_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event other;call super::other;if Message.Number = 522 then
	Return 1
end if
end event

event buttonclicked;call super::buttonclicked;
if dwo.name = "b_select" then	
	of_SelectEmail()
	this.SetColumn("email_to")
end if

//------------------- APPEON BEGIN -------------------
//$<add> Michael 07.11.2012
//$<reason> V12.2 Notification Email an Attachment
if dwo.name = "b_browse" then
	of_select_Attachment()
	this.SetColumn("attachment_file")	
end if
ChangeDirectory(gs_current_path)
//------------------- APPEON END ---------------------
end event

type dw_step_browse from u_dw within w_notification_alert_painter
integer x = 14
integer y = 1432
integer width = 4361
integer height = 436
integer taborder = 130
string dataobject = "d_na_step_browse"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_step_detail.ScrollToRow(CurrentRow)
end event

event clicked;call super::clicked;this.SetRow(Row)
dw_step_detail.ScrollToRow(Row)
end event

event dberror;Return 1
end event

type dw_alert_detail from u_dw within w_notification_alert_painter
integer x = 14
integer y = 760
integer width = 4361
integer height = 456
integer taborder = 120
string dataobject = "d_na_hdr_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event other;call super::other;if Message.Number = 522 then
	Return 1
end if
end event

event itemchanged;call super::itemchanged;long ll_Null
long ll_alert_type
string ls_Null

SetNull(ll_Null)
SetNull(ls_Null)

choose case dwo.name
	case "alert_category"
		this.SetItem(Row, "alert_type", ll_Null)
		this.SetItem(Row, "run_from", ll_Null)
		this.SetItem(Row, "table_name", ls_Null)
		this.SetItem(Row, "field_name", ls_Null)
		this.SetItem(Row, "upper_range", ll_Null)
		this.SetItem(Row, "active_only", ll_Null)
		this.SetItem(Row, "facility_id", ll_Null)
		of_FilterAlertTypeDddw(Long(Data))
		//---------Begin Added by (Appeon)Stephen 02.14.2017 for V15.3-Combined Expiring Credentials in Notifications :BugL020301--------
		if Long(Data) = 4 then
			this.SetItem(Row, "alert_type", 40)
			this.post event itemchanged(row, this.object.alert_type, '40')
		end if
		//---------End Added ------------------------------------------------------
	case "alert_type"
		// Do not have two New Practitioners alert type
		ll_alert_type = Long(Data)
	//	if ll_alert_type = 30 or ll_alert_type = 22 then //modify Michael 07.17.2012:add '22' V12.1 Notification Email an Attachment
		if ll_alert_type = 30 then	//long.zhang 09.04.2012 BugS072606 allow multi scheduled email type 
			if of_AlertTypeExists(ll_alert_type) then
				Post SetItem(Row, "alert_type", ll_Null)
				Return 1 // Do not accept text
			end if
		end if 
		
		// Set some fields status
		this.SetItem(Row, "table_name", ls_Null)
		this.SetItem(Row, "field_name", ls_Null)
		this.SetItem(Row, "upper_range", ll_Null)
		this.SetItem(Row, "active_only", ll_Null)
		//-------------appeon begin---------------
		//<$>Modified:long.zhang 11.07.2012
		//<$>reason:New practitoner facility can not be null
		//this.SetItem(Row, "facility_id", ll_Null)
		if ll_alert_type = 30 then
			this.setitem( Row, "facility_id",0)
		else 
			this.SetItem(Row, "facility_id", ll_Null)	
		end if	
		//------------appeon end-------------------
		of_FilterTableNameDddw(ll_alert_type)
		of_SetActionItemEnabled(ll_alert_type, true)
		Post of_SetAdvanceDaysEnabled()
		
		// There is one step only if alert type is New Practitioner
		if ll_alert_type = 30 or ll_alert_type = 22 then //modify Michael 07.11.2012:add '22' V12.1 Notification Email an Attachment
			dw_step_browse.RowsMove(1, dw_step_browse.RowCount(), Primary!, dw_step_browse, 1, Delete!)
			dw_step_detail.InsertRow(0)
			dw_step_detail.SetItem(1, "step_order", 1)
			dw_step_detail.ScrollToRow(1)
		end if
		
		//---------Begin Added by (Appeon)Stephen 12.05.2016 for V15.3-Combined Expiring Credentials in Notifications--------
		if ll_alert_type = 40 then
			this.SetItem(Row, "table_name", "Exp Cred Combined")
		end if
		//---------End Added ------------------------------------------------------
		
		// Determine run from value
		of_DetermineRunFrom(ll_alert_type, Row)
	case "table_name"
		this.SetItem(Row, "field_name", ls_Null)
		of_FilterFieldNameDddw(Data)
end choose
end event

event clicked;call super::clicked;choose case dwo.name
	case "alert_type"
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
	case "table_name"
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.alert_type[Row]) then
			MessageBox("Prompt", "Please select Alert Type first.")
			this.SetColumn("alert_type")
			this.SetFocus()
			Return 1
		end if
	case "field_name"
		if (this.object.alert_type[Row] = 22 or this.object.alert_type[Row] = 40) then return	//(Appeon)Stephen 11.17.2016 - V15.3-Combined Expiring Credentials in Notifications//long.zhang 09.04.2012 Fixed BugS072603
		if IsNull(this.object.alert_category[Row]) then
			MessageBox("Prompt", "Please select Alert Category first.")
			this.SetColumn("alert_category")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.alert_type[Row]) then
			MessageBox("Prompt", "Please select Alert Type first.")
			this.SetColumn("alert_type")
			this.SetFocus()
			Return 1
		end if
		if IsNull(this.object.table_name[Row]) then
			MessageBox("Prompt", "Please select Table Name first.")
			this.SetColumn("table_name")
			this.SetFocus()
			Return 1
		end if
end choose
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_alert_type
long ll_alert_category
string ls_table_name
string ls_field_name
DWItemStatus ldis_ColStatus
DWItemStatus ldis_RowStatus

if CurrentRow > 0 then
	ll_alert_category = this.object.alert_category[CurrentRow]
	ll_alert_type = this.object.alert_type[CurrentRow]
	ls_table_name = this.object.table_name[CurrentRow]
	ls_field_name = this.object.field_name[CurrentRow]
	of_FilterAlertTypeDddw(ll_alert_category)
	of_FilterTableNameDddw(ll_alert_type)
	of_FilterFieldNameDddw(ls_table_name)
	
	// The following codes correct PB bug about dddw display
	ldis_RowStatus = this.GetItemStatus(CurrentRow, 0, Primary!)
	ldis_ColStatus = this.GetItemStatus(CurrentRow, "alert_type", Primary!)
	this.SetItem(CurrentRow, "alert_type", ll_alert_type)
	this.SetItemStatus(CurrentRow, "alert_type", Primary!, ldis_ColStatus)
	ldis_ColStatus = this.GetItemStatus(CurrentRow, "table_name", Primary!)		
	this.SetItem(CurrentRow, "table_name", ls_table_name)
	this.SetItemStatus(CurrentRow, "table_name", Primary!, ldis_ColStatus)
	ldis_ColStatus = this.GetItemStatus(CurrentRow, "field_name", Primary!)		
	this.SetItem(CurrentRow, "field_name", ls_field_name)
	this.SetItemStatus(CurrentRow, "field_name", Primary!, ldis_ColStatus)
	this.SetItemStatus(CurrentRow, 0, Primary!, ldis_RowStatus)
end if
end event

event buttonclicked;call super::buttonclicked;if dwo.name = "b_upperhelp" then
	messagebox("Upper Range","Upper Range is how many days in the future the oldest alert will be.~rFor example, if the steps are at 90, 60 and 30 days, the upper range should be 90.")
end if


//---------Begin Added by (Appeon)Harry 03.12.2015 for V151-Additional Notification Filters--------
string ls_table_name
string ls_mess
Long ll_table_id
if dwo.name = "cb_filter" then
	ls_table_name = this.getitemstring(row, 'table_name')
	if isnull(ls_table_name) or ls_table_name = "" then return
	SELECT table_id INTO :ll_table_id FROM sys_tables WHERE table_name = :ls_table_name;
	if isnull(ll_table_id) or ll_table_id = 0 then ll_table_id = 0
	if ll_table_id <> 0 then
		ls_mess = "PD_EXPORT|" + String(ll_table_id) + "|NULL|NULL"
	else
		ls_mess = "Notification|NULL|" + ls_table_name + "|NULL" 
	end if
	OpenWithParm(w_query_wizard, ls_Mess)
	ls_mess = message.stringparm
	if ls_mess = "Cancel" then
		return
	else
		this.setitem(row,"addtl_filter",ls_mess)
	end if
end if
//---------End Added ------------------------------------------------------
end event

type dw_alert_browse from u_dw within w_notification_alert_painter
integer x = 14
integer y = 284
integer width = 4361
integer height = 468
integer taborder = 110
string dataobject = "d_na_hdr_browse"
boolean hscrollbar = true
end type

event clicked;call super::clicked;//this.SetRow(Row)
//dw_alert_detail.ScrollToRow(Row)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_alert_id
long ll_alert_type

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
dw_alert_detail.ScrollToRow(CurrentRow)

if CurrentRow > 0 then	
	// Retrieve alert step
	if not ib_CopyAlert then
		ll_alert_id = this.object.alert_id[CurrentRow]
		dw_step_browse.Retrieve(ll_alert_id)
		dw_step_browse.SelectRow(0, false)
		dw_step_browse.SelectRow(1, true)
	end if
	
	// Set action item options status
	ll_alert_type = this.object.alert_type[CurrentRow]
	of_SetActionItemEnabled(ll_alert_type, false)
	
	// Set advance_days status
	of_SetAdvanceDaysEnabled()

else
	dw_step_browse.Reset()
end if
end event

event dberror;Return 1
end event

event rowfocuschanging;//Override
integer li_Result

if ib_CopyAlert or ib_DeleteAlert then
	Return 0
end if

if of_DataChanged(dw_step_browse) then
	li_Result = MessageBox("Save", "The data is changed, would you like to save data?", Question!, YesNoCancel!)
	choose case li_Result
		case 1
			if of_SaveData() = -1 then Return 1
		case 2
			dw_step_browse.Reset()
		case 3
			Return 1
	end choose
end if

Return 0
end event

type cb_add_alert from commandbutton within w_notification_alert_painter
integer x = 1705
integer y = 192
integer width = 302
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Alert"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row

if of_DataChanged(dw_step_browse) then
	MessageBox("Prompt", "Please save data first.")
	Return
end if

ll_Row = dw_alert_browse.InsertRow(0)
dw_alert_browse.ScrollToRow(ll_Row)
dw_alert_detail.ScrollToRow(ll_Row)

dw_alert_detail.SetItem(ll_Row, "active_status", 1)
dw_alert_detail.SetItem(ll_Row, "active_only", 1)
dw_alert_detail.SetItem(ll_Row, "run_frequency", 1)
dw_alert_detail.SetItem(ll_Row, "next_run_date", DateTime(today(), 00:00:00))

dw_alert_detail.SetColumn("alert_name")
dw_alert_detail.SetFocus()
end event

type cb_del_alert from commandbutton within w_notification_alert_painter
integer x = 2016
integer y = 192
integer width = 325
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Alert"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_alert_id

ll_Row = dw_alert_browse.GetRow()
if ll_Row < 1 then Return

ll_alert_id = dw_alert_browse.object.alert_id[ll_Row]
if MessageBox("Delete", "Are you sure you want to delete the selected notification?", Question!, YesNo!) = 2 then
	Return
end if

// Delete notification alert
ib_DeleteAlert = true
dw_alert_browse.DeleteRow(ll_Row)

gnv_appeondb.of_StartQueue()
DELETE FROM alert_steps WHERE alert_id = :ll_alert_id;
DELETE FROM alert_records WHERE alert_id = :ll_alert_id;
dw_alert_browse.Update()
gnv_appeondb.of_CommitQueue()

ll_Row = dw_alert_browse.GetRow()
dw_alert_browse.Event RowFocusChanged(ll_Row)
ib_DeleteAlert = false
end event

type cb_save from commandbutton within w_notification_alert_painter
integer x = 2889
integer y = 28
integer width = 302
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////
integer li_ret

li_ret = of_SaveData()

// V10.1 - Notification Alert - Andy 03/04/2010
if li_ret = 1 then
	gnv_data.of_retrieve('alert_hdr')
end if
end event

type cb_close from commandbutton within w_notification_alert_painter
integer x = 4064
integer y = 28
integer width = 302
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event

type cb_copy_alert from commandbutton within w_notification_alert_painter
integer x = 2350
integer y = 192
integer width = 302
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&opy Alert"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.06.2010
//////////////////////////////////////////////////////////////////////

long ll_MasterRow
long ll_DetailRowCount
long ll_alert_type

ll_MasterRow = dw_alert_browse.GetRow()
if ll_MasterRow < 1 then Return

if of_DataChanged(dw_alert_browse) or of_DataChanged(dw_step_browse) then
	MessageBox("Prompt", "Please save data first.")
	Return
end if
ll_alert_type = dw_alert_browse.object.alert_type[ll_MasterRow]
if ll_alert_type = 30 then
	MessageBox("Prompt", "The New Practitioner alert type cannot be copied.")
	Return
end if


// Copy master record
ll_MasterRow = dw_alert_browse.InsertRow(0)
dw_alert_browse.object.data[ll_MasterRow] = dw_alert_browse.object.data[dw_alert_browse.getrow()]
if of_SaveMaster() = -1 then Return

// Copy detail records
ll_DetailRowCount = dw_step_browse.RowCount()
if ll_DetailRowCount > 0 then
	dw_step_browse.RowsCopy(1, ll_DetailRowCount, Primary!, dw_step_browse, ll_DetailRowCount + 1, Primary!)
	dw_step_browse.RowsMove(1, ll_DetailRowCount, Primary!, dw_step_browse, 1, Delete!)
	dw_step_browse.RowsDiscard(1, dw_step_browse.DeletedCount(), Delete!)
	ib_CopyAlert = true
	dw_alert_browse.ScrollToRow(ll_MasterRow)
	dw_step_browse.SelectRow(1, true)
	of_SaveDetail()
	ib_CopyAlert = false
else
	dw_alert_browse.ScrollToRow(ll_MasterRow)
end if
end event

type cb_add_step from commandbutton within w_notification_alert_painter
integer x = 1701
integer y = 1344
integer width = 302
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add S&tep"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row
long ll_alert_id
long ll_alert_type
datawindowchild ldwc_1 //(Appeon)Stephen 12.02.2016 - V15.3-Combined Expiring Credentials in Notifications

ll_Row = dw_alert_browse.GetRow()
if ll_Row < 1 then Return
ll_alert_id = dw_alert_browse.object.alert_id[ll_Row]
ll_alert_type = dw_alert_browse.object.alert_type[ll_Row]

if of_DataChanged(dw_alert_browse) then
	MessageBox("Prompt", "Please save data first.")
	Return
end if
choose case ll_alert_type
	case 30,22, 40  //modify Michael Michael 07.09.2012:add '22' V12.2 Notification Email an Attachment //(Appeon)Stephen 11.24.2016 - add '40' V15.3-Combined Expiring Credentials in Notifications
		if dw_step_browse.RowCount() = 1 then
			MessageBox("Prompt", "You can only define one step for this alert type.")
			Return
		end if	
	case else
		if dw_step_browse.RowCount() = 10 then
			MessageBox("Prompt", "You can only define ten steps for this alert type.")
			Return
		end if
end choose

ll_Row = dw_step_browse.InsertRow(0)
dw_step_browse.SetItem(ll_Row, "alert_id", ll_alert_id)
dw_step_browse.SetItem(ll_Row, "email_from", "MASTER")
dw_step_browse.SetItem(ll_Row, "email_prac", 0)

dw_step_browse.ScrollToRow(ll_Row)
dw_step_detail.SetColumn("step_description")
dw_step_detail.SetFocus()

//---------Begin Added by (Appeon)Stephen 12.02.2016 for V15.3-Combined Expiring Credentials in Notifications--------
dw_step_detail.setitem(ll_row, "alert_hdr_alert_type", ll_alert_type) 
dw_step_detail.getchild("email_template", ldwc_1)
if ll_alert_type = 40 then
	ldwc_1.setfilter("merge_type= 2")
	ldwc_1.filter()
else
	ldwc_1.setfilter("merge_type <> 2")
	ldwc_1.filter()
end if
//---------End Added ------------------------------------------------------


end event

type cb_del_step from commandbutton within w_notification_alert_painter
integer x = 2011
integer y = 1344
integer width = 329
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "D&elete Step"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.05.2010
//////////////////////////////////////////////////////////////////////

long ll_Row

ll_Row = dw_step_browse.GetRow()
if ll_Row < 1 then Return

if of_DataChanged(dw_alert_browse) then
	MessageBox("Prompt", "Please save data first.")
	Return
end if

if MessageBox("Delete", "Are you sure you want to delete the selected alert step?", Question!, YesNo!) = 2 then
	Return
end if

dw_step_browse.DeleteRow(ll_Row)
ll_Row = dw_step_browse.GetRow()
dw_step_browse.Event RowFocusChanged(ll_Row)
end event

type gb_2 from groupbox within w_notification_alert_painter
integer x = 23
integer y = 1340
integer width = 384
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Alert Steps"
end type

type gb_1 from groupbox within w_notification_alert_painter
integer x = 32
integer y = 192
integer width = 416
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Notifications"
end type

