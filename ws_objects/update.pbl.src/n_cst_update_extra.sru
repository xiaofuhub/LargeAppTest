$PBExportHeader$n_cst_update_extra.sru
forward
global type n_cst_update_extra from nonvisualobject
end type
end forward

global type n_cst_update_extra from nonvisualobject autoinstantiate
end type

type variables
String is_sql_statements[]

n_cst_update_view_fields_alias inv_upd_vfld //alfee 07.30.2014
n_cst_update_data inv_upd_data //alfee 12.26.2014
end variables

forward prototypes
public function integer of_update_profile_id ()
public function integer of_update_data_v8 ()
public function integer of_update_caqh_fields ()
public function integer of_update_extra ()
public function integer of_update_data_v101 ()
public function integer of_update_launch_pad ()
public function integer of_add_alert_sched_data ()
public function integer of_execute (string as_sql, string as_title)
public subroutine of_execute_sqls (string as_title)
public function integer of_update_app_filters ()
public function integer of_update_priv ()
public function integer of_update_object_band ()
public function integer of_update_data_v121 ()
public subroutine of_login_buttons_data ()
public function integer of_update_data_v141 ()
public function integer of_login_button_data2 ()
public function integer of_update_data_v142 ()
public function integer of_profile_personal_info ()
public function integer of_update_data_v151 ()
public function integer of_update_data_v152 ()
public function integer of_update_data_v153 ()
public function integer of_download_file (string as_file_path)
public function integer of_update_data_v154 ()
public function integer of_update_data_v161 ()
end prototypes

public function integer of_update_profile_id ();//To fix a bug that profile ids in profile_reports are inconsistent with table ids in
//system_tables.  For calling from V8.1 - Alfee 01.23.2009

//Note: the changes are stored in d_profile_id_updlst

Long i, j, ll_cnt_updlst, ll_cnt_upd, ll_cnt_view_upd
Long ll_prf_id, ll_prf_id_new, ll_found
String ls_prf_name, ls_find

DataStore ds_prf_id_updlst 
DataStore ds_prf_id_upd, ds_prf_id_view_upd 
DataStore ds_prf_id_upd_tmp, ds_prf_id_view_upd_tmp 

ds_prf_id_updlst = Create DataStore
ds_prf_id_upd = Create DataStore
ds_prf_id_view_upd = Create DataStore
ds_prf_id_upd_tmp = Create DataStore
ds_prf_id_view_upd_tmp = Create DataStore

//Initialize profile info
ds_prf_id_updlst.dataobject = 'd_profile_id_updlst'
ds_prf_id_upd.DataObject = 'd_profile_id_upd'
ds_prf_id_view_upd.DataObject = 'd_profile_id_view_upd'
ds_prf_id_upd_tmp.DataObject = 'd_profile_id_upd'
ds_prf_id_view_upd_tmp.DataObject = 'd_profile_id_view_upd'

ds_prf_id_upd.SetTransObject(SQLCA)
ds_prf_id_view_upd.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
ds_prf_id_upd.Retrieve()
ds_prf_id_view_upd.Retrieve()
gnv_appeondb.of_commitqueue( )

//Modify profile ids based on the specified change list 
ll_cnt_updlst = ds_prf_id_updlst.RowCount()
FOR i = 1 to ll_cnt_updlst
	ll_prf_id = ds_prf_id_updlst.GetItemNumber(i, 'profile_report_id')
	ls_prf_name = ds_prf_id_updlst.GetItemString(i, 'profile_report_name')
	ll_prf_id_new = ds_prf_id_updlst.GetItemNumber(i, 'profile_report_id_new')
	
	ls_find = "profile_report_id = " + String(ll_prf_id) + " And Lower(profile_report_name) = '" + Lower(ls_prf_name) + "'"
	ll_found = ds_prf_id_upd.Find(ls_find, 1, ds_prf_id_upd.RowCount())
	IF ll_found > 0 THEN 
		IF ds_prf_id_upd.Rowscopy( ll_found, ll_found, Primary!, ds_prf_id_upd_tmp, ds_prf_id_upd_tmp.RowCount() + 1, primary!) <> 1 THEN RETURN -1
		ds_prf_id_upd_tmp.SetItem(ds_prf_id_upd_tmp.RowCount(), 'profile_report_id', ll_prf_id_new)
		ds_prf_id_upd.DeleteRow(ll_found) 
		DO 		
			ll_found = ds_prf_id_view_upd.Find("profile_report_id = " + String(ll_prf_id), 1, ds_prf_id_view_upd.RowCount() )
			IF ll_found > 0 THEN 
				IF ds_prf_id_view_upd.Rowscopy(ll_found, ll_found, Primary!, ds_prf_id_view_upd_tmp, ds_prf_id_view_upd_tmp.RowCount() + 1, primary!) <> 1 THEN RETURN -1
				ds_prf_id_view_upd_tmp.SetItem(ds_prf_id_view_upd_tmp.RowCount(), 'profile_report_id', ll_prf_id_new)
				ds_prf_id_view_upd.DeleteRow(ll_found) 
			END IF
		LOOP WHILE (ll_found > 0 )
	END IF
	ll_found = 0
NEXT

//Update changes on profile_view_reports  
ll_cnt_view_upd = ds_prf_id_view_upd_tmp.RowCount() 
IF ll_cnt_view_upd > 0 THEN 
	ds_prf_id_view_upd_tmp.AcceptText()
	IF ds_prf_id_view_upd.update() <> 1 THEN RETURN -1
	IF ds_prf_id_view_upd_tmp.RowsCopy(1, ll_cnt_view_upd, primary!, ds_prf_id_view_upd, ds_prf_id_view_upd.RowCount() + 1, primary!) <> 1 THEN RETURN -1
	IF ds_prf_id_view_upd.Update() <> 1 THEN RETURN -1
END IF

//Update changes on profile_reports  
ll_cnt_upd = ds_prf_id_upd_tmp.RowCount() 
IF ll_cnt_upd > 0 THEN 
	ds_prf_id_upd_tmp.AcceptText()
	IF ds_prf_id_upd.update() <> 1 THEN RETURN -1
	IF ds_prf_id_upd_tmp.RowsCopy(1, ll_cnt_upd, primary!, ds_prf_id_upd, ds_prf_id_upd.RowCount() + 1, primary!) <> 1 THEN RETURN -1
	IF	ds_prf_id_upd.Update() <> 1 THEN RETURN -1
END IF

Destroy ds_prf_id_updlst
Destroy ds_prf_id_upd
Destroy ds_prf_id_view_upd
Destroy ds_prf_id_upd_tmp
Destroy ds_prf_id_view_upd_tmp

RETURN 1
end function

public function integer of_update_data_v8 ();//Update extra data in V8 - Alfee 01.23.2009

String ls_error

//1. Update profile report id 
IF of_update_profile_id() = -1 THEN
	ls_Error = "n_cst_update_extra.of_update_profile_id() Information: Failed to update profile report id, call support."
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) //warning level
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF	
END IF

RETURN 1
end function

public function integer of_update_caqh_fields ();//Update CAQH Mapping fields - Alfee 07.23.2009

Integer li_rtn = 1
String ls_path, ls_Error
n_cst_datastore lds_mapping_fields
n_appeon_download lnv_download 

lds_mapping_fields = Create n_cst_datastore
lds_mapping_fields.DataObject = 'd_caqh_mapping_fields_update'
lds_mapping_fields.SetTransObject(SQLCA)

IF appeongetclienttype() = 'WEB' THEN 
	ls_path = gs_dir_path + "intellicred\caqh_mapping_fields_data.txt"
	//Download the text file
	IF lnv_download.of_downloadfile("", ls_path) <> 0 THEN
		ls_Error = "n_cst_update_extra.of_update_caqh_fields() Information: Failed to download " + ls_path + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) 
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF		
	END IF
ELSE 
	ls_path = Gs_Current_Directory + "\caqh_mapping_fields_data.txt"
END IF

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN
	w_infodisp.Title = 'Update CAQH mapping fields'
	w_infodisp.Center = True
	w_infodisp.st_complete.Visible = False
	w_infodisp.st_3.Visible = False
	w_infodisp.st_information.Visible = False
	w_infodisp.st_1.Text = 'Update CAQH mapping fields, Please stand by'
	w_infodisp.wf_set_min_max(1,2)
END IF

//Update data
IF FileExists(ls_path) = True THEN
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Tables 1 of 1, Please stand by'
	END IF
	DELETE FROM caqh_mapping_fields;
	
	lds_mapping_fields.Reset()
	IF lds_mapping_fields.ImportFile( ls_path ) >= 0 THEN
		lds_mapping_fields.Update()
		COMMIT Using SQLCA;		
		IF SQLCA.SQLCode = -1 THEN ls_Error = "n_cst_update_extra.of_update_caqh_fields() Information:Failed to update CAQH mapping fields due to ~r~n " + SQLCA.SQLErrText
	ELSE
		ls_Error = "n_cst_update_extra.of_update_caqh_fields() Information: The file " + ls_path + " cannot be imported to the table."
	END IF
ELSE
	ls_Error = "n_cst_update_extra.of_update_caqh_fields() Information: File  does not exist " + ls_path + ". Unable to update CAQH mapping fields."
END IF

//Log error 
IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice)THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	li_rtn = -1	
END IF

Destroy lds_mapping_fields

//If isvalid(w_infodisp) Then Close(w_infodisp)

RETURN li_rtn
end function

public function integer of_update_extra ();//Update extra data - called in all versions 
//Alfee 07.23.2009

String ls_error

//Update CAQH Mapping fields
of_update_caqh_fields()

//Add launch pad seed data - from maha - moved from of_update_data_v101 (alfee 04.11.2011)
IF of_update_launch_pad() = -1 THEN
	ls_Error = "n_cst_update_extra.of_update_launch_pad() Information: Failed to add launch pad seed data, call support."
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) 
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF	
END IF

//Add alert & sched sample data -  - moved from of_update_data_v101 (alfee 04.11.2011)
IF of_add_alert_sched_data() = -1 THEN
	ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: Failed to add alert & sched sample data, call support."
	IF IsValid(gnv_logservice)THEN 
		gnv_logservice.of_setloglevel(2) 
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE			
	END IF	
END IF

//Update app_filter records
of_update_app_filters() // Evan 11.04.2010

RETURN 1
end function

public function integer of_update_data_v101 ();//Update extra data in V101 - Alfee 01.20.2010
//Moved to of_update_extra() - Alfee 04.11.2011

//String ls_error
//
////1. Add launch pad seed data - from maha
//IF of_update_launch_pad() = -1 THEN
//	ls_Error = "n_cst_update_extra.of_update_launch_pad() Information: Failed to add launch pad seed data, call support."
//	IF IsValid(gnv_logservice)THEN 
//		gnv_logservice.of_setloglevel(2) 
//		gnv_logservice.of_log_warning(ls_Error)
//		gb_upgrade_failed = TRUE			
//	END IF	
//END IF
//
////2. Add alert & sched sample data - alfee 04.30.2010
//IF of_add_alert_sched_data() = -1 THEN
//	ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: Failed to add alert & sched sample data, call support."
//	IF IsValid(gnv_logservice)THEN 
//		gnv_logservice.of_setloglevel(2) 
//		gnv_logservice.of_log_warning(ls_Error)
//		gb_upgrade_failed = TRUE			
//	END IF	
//END IF


RETURN 1
end function

public function integer of_update_launch_pad ();//update launch pad seed data - called in v10.1 - alfee 01.20.2010
//modified by alfee 03.25.2010

integer i, li_rtn = 1
long ll_cnt
string ls_launch_info[12]
string ls_file, ls_error

datastore lds_launch_pad
n_appeon_download lnv_download 

lds_launch_pad = create datastore
//Start Code Change ----04.04.2011 #V11 maha 
//lds_launch_pad.dataobject = "d_launch_pad_import"
lds_launch_pad.dataobject = "d_launch_pad_data_imp"
//Start Code Change ----04.04.2011
lds_launch_pad.settransobject(sqlca)
ll_cnt = lds_launch_pad.retrieve()

if ll_cnt > 0 then //alfee 04.30.2010
	destroy lds_launch_pad
	return 1 
end if

//Get the text file
IF appeongetclienttype() = 'WEB' THEN 
	ls_file = gs_dir_path + "intellicred\launch_pad_data_imp.txt"
	//Download the text file
	IF lnv_download.of_downloadfile("", ls_file) <> 0 THEN
		ls_Error = "n_cst_update_extra.of_update_launch_pad() Information: Failed to download " + ls_file + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) 
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF		
		Destroy lds_launch_pad
		RETURN -1 		
	END IF
ELSE 
	ls_file =  gs_dir_path + "intellicred\launch_pad_data_imp.txt"
	//ls_file = Gs_Current_Directory + "\launch_pad_data_imp.txt"
END IF

//Update data
IF FileExists(ls_file) = True THEN
	//DELETE FROM launch_pad;
	//lds_launch_pad.Reset()
	//lds_launch_pad.rowsmove(1, ll_cnt, primary!, lds_launch_pad, 1, delete!)	- commented by alfee 04.30.2010
	IF lds_launch_pad.ImportFile( ls_file ) >= 0 THEN
		li_rtn = lds_launch_pad.Update()
		COMMIT Using SQLCA;		
		IF SQLCA.SQLCode = -1 THEN ls_Error = "n_cst_update_extra.of_update_launch_pad() Information:Failed to update launch pad data due to ~r~n " + SQLCA.SQLErrText
	ELSE
		ls_Error = "n_cst_update_extra.of_update_launch_pad() Information: The file " + ls_file + " cannot be imported to the table."
	END IF
ELSE
	ls_Error = "n_cst_update_extra.of_update_launch_pad() Information: File does not exist " + ls_file + ". Unable to update launch pad data."
END IF

//Log error 
IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice)THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	li_rtn = -1	
END IF

Destroy lds_launch_pad

RETURN li_rtn


//by maha
//ls_file = gs_dir_path + "intellicred\launch_pad_data_imp.txt"
//if not fileexists( ls_file) then return -1
//
//lds_launch_pad = create datastore
//lds_launch_pad.dataobject = "d_launch_pad_import"
//lds_launch_pad.settransobject(sqlca)
//li_rtn = lds_launch_pad.retrieve()
//
//if li_rtn > 0 then
//	return 1
//	//delete from launch_pad;
//	//commit using sqlca;
//end if
//
//li_rtn = lds_launch_pad.importfile( ls_file)
//if li_rtn < 1 then return li_rtn
//
//li_rtn = lds_launch_pad.update()
//
//return li_rtn


//by alfee 
//set launch info
//ls_launch_info[1]  = "View Painter:" + "~r~n"
//ls_launch_info[1] += "" + "~r~n"
//ls_launch_info[1] += "1) Click on Create View and give your view a name (usually your company name)." + "~r~n"
//ls_launch_info[1] += "2) Review the Practitioner Application/Profile and determine the order and applicable data screens you will use for your practitioners data. Add or Remove data screens as needed. Be sure to save!!"
//
//ls_launch_info[2]  = "Facility Painter:" + "~r~n"
//ls_launch_info[2] += "" + "~r~n"
//ls_launch_info[2] += "1) Modify the name of the default facility (if applicable) be sure to include the physical address of the facility. " + "~r~n"
//ls_launch_info[2] += "2) Enter the Return Address (Mailing) if different from the physical address." +"~r~n"
//ls_launch_info[2] += "3) Click on the Settings tab to set the default view to your custom view and set the default letter path. This is where you will also set your default Audit Template(sets of required documents) and your Verifying Facility. Set the information for Reappointments such as, how far in advance you would like to be notified of reappoint for your practitioner. Set up your Reappointment verification information including incorporating the application and letters. Set up any Provisional appointment information and also your Allied Health information." + "~r~n"
//ls_launch_info[2] += "4) Click on the NPDB/OIG tab. Determine which method will be used: QPRAC (the manual method) or ITP (Interface Control Document Transfer Program). Set up the appropriate fields if ITP is selected." + "~r~n"
//ls_launch_info[2] += "5) Click on the Verf. Rules Tab. Click through each data screen and determine when your verifying facility verifies and what method you use for the verification. Methods include but are not limited to: Web, Verification Letter, Hard Copy, Query." + "~r~n"
//ls_launch_info[2] += "6) Click on the Committees tab and set up the committees that your practitioners will need to attend for approval." + "~r~n"
//ls_launch_info[2] += "7) Click on the Department Chair tab and enter demographic information." + "~r~n"
//ls_launch_info[2] += "8) Add additional facilities that may be needed for tracking appointments." 
//
//ls_launch_info[3]  = "Role Painter: Establish security parameters for your users" + "~r~n"
//ls_launch_info[3] += "" + "~r~n"
//ls_launch_info[3] += "1) Determine if you will need additional roles other than Administrator, Lower or Read Only" + "~r~n"
//ls_launch_info[3] += "2) When creating additional roles, copy and/or create new roles and set access levels." + "~r~n"
//ls_launch_info[3] += "	Full Access = dark black checkmark" + "~r~n"
//ls_launch_info[3] += "	No Access= blank box" + "~r~n"
//ls_launch_info[3] += "	Read Only= either a shaded checkmark or solid Green box" 
//
//ls_launch_info[4]  = "User Painter: Create your users, give them access to views and facilities. Assign them a role" + "~r~n"
//ls_launch_info[4] += "" + "~r~n"
//ls_launch_info[4] += "1) Create your user ID. " + "~r~n"
//ls_launch_info[4] += "2) Give your user access to any/all of the Facilities and Views you have created" + "~r~n"
//ls_launch_info[4] += "    You do not need access to the default system view" + "~r~n"
//ls_launch_info[4] += "3) Assign your user a Role. " + "~r~n"
//ls_launch_info[4] += "4) Set your default facility and your default view" + "~r~n"
//ls_launch_info[4] += "5) Set the page option to the page you would like to open at login" + "~r~n"
//ls_launch_info[4] += "6) Set the To Do list to No" + "~r~n"
//ls_launch_info[4] += "7) Set the Task List to Yes" + "~r~n"
//ls_launch_info[4] += "8) Remember to talk to your IT about setting up each user's Email Properties so that they will be able to email applications, images and letters directly from IntelliApp."  + "~r~n"
//ls_launch_info[4] += "9) Add additional users if necessary."
//
//ls_launch_info[5]  = "Group Practice: This will be the address book that will hold all of your group locations as well as billing addresses and credentialing address records. Once entered in Group Practices, you can use the Find button on the address d/e screen to retrieve the address." + "~r~n"
//ls_launch_info[5] += "" + "~r~n"
//ls_launch_info[5] += "1) Go to the File Menu; choose Group Practices from the dropdown." + "~r~n"
//ls_launch_info[5] += "2) Click the Add Button." + "~r~n"
//ls_launch_info[5] += "3) Complete the Location Detail , click Save." + "~r~n"
//ls_launch_info[5] += "4) Click on Practice Data Tab add any Group information (Group NPI Number, Group Insurance information, Gender Limitations etc)." + "~r~n"
//ls_launch_info[5] += "5) Add any additional locations." 
//
//ls_launch_info[6]  = "Email Painter"
//
//ls_launch_info[7]  = "Required Document Painter: Set up your list of required documents. This list will automatically be linked to all new practitioners. " + "~r~n"
//ls_launch_info[7] += "" + "~r~n"
//ls_launch_info[7] += "1) Change Item 1 to the first element in your list tab to the Letter Description field and type the description once again." + "~r~n"
//ls_launch_info[7] += "2) Click the Add button and type your next description, tab to the Letter Description field which will already be populated." + "~r~n"
//ls_launch_info[7] += "3) Continue to add your Required Document List." 
//
//ls_launch_info[8]  = "App Audit Painter: Set up your list of required documents. This list will automatically be linked to all new practitioners. " + "~r~n"
//ls_launch_info[8] += "" + "~r~n"
//ls_launch_info[8] += "1) Select the Facility on the left of the screen. Remember each Facility can have their own App Audit List(this may be necessary if each Facility requires different documentation)" + "~r~n"
//ls_launch_info[8] += "2) Change Item 1 to the first element in your list tab to the Letter Description field and type the description once again. " + "~r~n"
//ls_launch_info[8] += "3) Click the Add button and type your next description, tab to the Letter Description field which will already be populated" + "~r~n"
//ls_launch_info[8] += "4) Click on the Reappointment Required Data tab. If the Reappointment Required Data elements are the same as the Initial List you may delete Item 1 and click the Copy Initial button. This will copy the Initial list you just created to the Reappointment tab. If there are items that need to be deleted for " + "~r~n"
//ls_launch_info[8] += "5) Reappointment click in the field and click on the delete button." + "~r~n"
//ls_launch_info[8] += "6) Review and set the Use as Verification, App Audit Auto Gen, Complete from D/E boxes." 
//
//ls_launch_info[9]  = "Screen Painter: Modify data entry screens (hide or reveal fields, move fields, use Custom fields). " + "~r~n"
//ls_launch_info[9] += "" + "~r~n"
//ls_launch_info[9] += "1) Choose your Custom View" + "~r~n"
//ls_launch_info[9] += "2) Choose the Basic Information Screen" + "~r~n"
//ls_launch_info[9] += "3) Modify the screen setup:" + "~r~n"
//ls_launch_info[9] += "    Hide any fields you may not be using" + "~r~n"
//ls_launch_info[9] += "    Modify any labels" + "~r~n"
//ls_launch_info[9] += "    Do NOT hide or modify any Required (underlined) fields" 
//
//ls_launch_info[10]  = "Image Type Painter: Holds the list of the document types that you will need to scan for your providers." + "~r~n"
//ls_launch_info[10] += "" + "~r~n"
//ls_launch_info[10] += "1) Modify the list of Scanned Documents: Delete the ones that you will not need. Add ones that you will need. Don't forget that each image type must be connected to a data screen.  If the document is not connected to a specific data screen, (for example a CV), connect it to the Basic Information Screen." + "~r~n"
//ls_launch_info[10] += "2) Modify the order: If you want to see the images in a specific order you will need to change the numbers. Make sure that you do not duplicate or leave out any numbers." 
//
//ls_launch_info[11]  = "Letter Painter:  This is where you add the letters used for Practitioner correspondence (not verification letters)." 
//
//ls_launch_info[12]  = "Letter Storage Painter: This is where all letters are stored in the database." 
//
////update launch pad data
//lds_launch_pad = create datastore
//lds_launch_pad.dataobject = "d_launch_pad_data_imp"
//lds_launch_pad.settransobject(sqlca)
//li_rtn = lds_launch_pad.retrieve()
//if li_rtn > 0 then return li_rtn //return if existed
//
//lds_launch_pad.dataobject = "d_launch_pad_data_imp"
//lds_launch_pad.settransobject(sqlca)
//
//for i = 1 to lds_launch_pad.rowcount()
//	if i <= 12 then lds_launch_pad.setitem(i, "launch_info", ls_launch_info[i])
//	lds_launch_pad.setitem(i, "sort_order", i)
//	lds_launch_pad.setitemstatus( i, 0, primary!, newmodified!)
//next
//
//li_rtn = lds_launch_pad.update()
//
//return li_rtn
end function

public function integer of_add_alert_sched_data ();//Start Code Change ----04.26.2010 #V10 maha - function created
//Created for the import of sample data for notifications and schedule items
//modified for Web version - alfee 04.30.2010

integer i, ic, li_rtn
string ls_path, ls_error
n_ds lds_header, lds_steps
n_appeon_download lnv_download 

IF appeongetclienttype() = 'WEB' THEN 
	ls_path = gs_dir_path + "intellicred\"
ELSE
	ls_path = Gs_Current_Directory + "\"
END IF

//Alert data
select count(alert_id) into :ic from alert_hdr;

if ic = 0 then
	//Download text files for Web version
	IF appeongetclienttype() = 'WEB' THEN
		IF NOT fileexists(ls_path + "alert_hdr.txt") THEN lnv_download.of_downloadfile("", ls_path + "alert_hdr.txt")
		IF NOT fileexists(ls_path + "alert_steps.txt") THEN lnv_download.of_downloadfile("", ls_path + "alert_steps.txt")		
	END IF

	//Log error if text files not existed
	if not fileexists(ls_path + "alert_hdr.txt")	then
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: File does not exist: " + ls_path + "alert_hdr.txt" + ". Unable to update alert sample data."
	elseif not fileexists(ls_path + "alert_steps.txt")	then
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: File does not exist: " + ls_path + "alert_steps.txt" + ". Unable to update alert sample data."	
	end if		
	IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice) THEN 
		gnv_logservice.of_setloglevel(2) 
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE
		RETURN -1	
	END IF		
	
	//Import alert hdr and steps
	lds_header = create n_ds
	lds_steps = create n_ds	
	lds_header.dataobject = "d_alert_header_import"
	lds_steps.dataobject = "d_alert_steps_import"
	lds_header.settransobject(sqlca)
	lds_steps.settransobject(sqlca)

	if lds_header.importfile(ls_path + "alert_hdr.txt") < 0 then //importtype is unsupported by APB - alfee 05.04.2010
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: The file " + ls_path + "alert_hdr.txt" + " cannot be imported to the table."
	elseif lds_steps.importfile(ls_path + "alert_steps.txt") < 0 then
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: The file " + ls_path + "alert_steps.txt" + " cannot be imported to the table."		
	elseif gnv_appeondb.of_update(lds_header, lds_steps) < 0  then
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: Failed to update alert sample data."				
	end if
	
	IF LenA(ls_error) > 0 AND IsValid(gnv_logservice) THEN 
		gnv_logservice.of_setloglevel(2) 
		gnv_logservice.of_log_warning(ls_Error)
		gb_upgrade_failed = TRUE
		ls_error = ""
		Destroy lds_header
		Destroy lds_steps
		//RETURN -1			
	END IF			
end if


//Scheduler data
select count(sched_id) into :ic from schedule_hrd;

if ic = 0 then
	//Download text files for Web version
	IF appeongetclienttype() = 'WEB' AND NOT fileexists(ls_path + "schedule_hrd.txt") THEN
		lnv_download.of_downloadfile("", ls_path + "schedule_hrd.txt")
	END IF	
	
	//Import sched sample data
	if fileexists(ls_path + "schedule_hrd.txt")	then
		if not isvalid(lds_header) then lds_header = create n_ds
		lds_header.dataobject = "d_schedule_import"
		lds_header.settransobject(sqlca)
		if lds_header.importfile(ls_path + "schedule_hrd.txt") < 0 then
			ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: The file " + ls_path + "schedule_hrd.txt" + " cannot be imported to the table."
		elseif lds_header.update() < 0 then
			ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: Failed to update sched sample data."
		end if			
	else //Log error if text files not existed
		ls_Error = "n_cst_update_extra.of_add_alert_sched_data() Information: File does not exist: " + ls_path + "schedule_hrd.txt" + ". Unable to update sched sample data."	
	end if		
end if

IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice) THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	RETURN -1	
END IF		

RETURN 1

//n_ds ids_header
//n_ds ids_steps
//integer i
//integer ic
//string ls_file
//
//ls_file = gs_dir_path + "\IntelliCred\"
//ids_header = create n_ds
//
//select count(alert_id) into :ic from alert_hdr;
//
//if ic = 0 and fileexists(ls_file + "alert_hdr.txt") then
//	ids_steps = create n_ds
//	
//	ids_header.dataobject = "d_alert_header_import"
//	ids_steps.dataobject = "d_alert_steps_import"
//	ids_header.settransobject(sqlca)
//	ids_steps.settransobject(sqlca)
//	
//	ic = ids_header.importfile(text!, ls_file + "alert_hdr.txt")
//	ic = ids_header.update()
//	//import steps
//	if ic > 0 and fileexists(ls_file + "alert_steps.txt") then
//		ic = ids_steps.importfile(text!, ls_file + "alert_steps.txt")
//		ic = ids_steps.update()
//	end if
//end if
//
////scheduler data
//select count(sched_id) into :ic from schedule_hrd;
//
//if ic = 0 and fileexists(ls_file + "schedule_hrd.txt") then
//	
//	ids_header.dataobject = "d_schedule_import"
//	ids_header.settransobject(sqlca)
//	ic = ids_header.importfile(text!, ls_file + "schedule_hrd.txt")
//	ic = ids_header.update()
//end if
//
//
//return 1
end function

public function integer of_execute (string as_sql, string as_title);Yield()

EXECUTE Immediate :as_sql Using Sqlca;
IF Sqlca.SQLCode <> 0 THEN
	
	IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(as_sql, Sqlca.SQLErrText,as_title)
	gb_upgrade_failed = TRUE
	RETURN -1
END IF
//IF Sqlca.AutoCommit = False THEN
	COMMIT Using Sqlca;
//END IF


RETURN 1

end function

public subroutine of_execute_sqls (string as_title);//-----------------------------------------------------------------------------
// [PUBLIC]    : of_execute_sqls
// Arguments 	: string as_title
// Returns   	: [none]   
// Created By	: Alfee 01.30.2008
//------------------------------------------------------------------------------
Long ll_i
String ls_null[]

// IF IsValid(gnv_logservice)THEN gnv_logservice.of_log("work_flow", '****',as_title)
IF UPPERBOUND(is_sql_statements) > 0 THEN 
		if Not isvalid( w_infodisp ) then open(w_infodisp)
		if isvalid(w_infodisp) then w_infodisp.title = "Update DB - " + as_title + "()"
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = as_title
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statements))
			
		FOR ll_i = 1 TO upperbound(is_sql_statements)
			If isvalid(w_infodisp) Then w_infodisp.st_1.text = 'Modification ' +string(ll_i) +' of '+ string(upperbound(is_sql_statements)) +', Please stand by!'
			of_execute(is_sql_statements[ll_i],as_title)
			if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT	
     // if isvalid(w_infodisp) then close(w_infodisp)	    
END IF

is_sql_statements = ls_null

RETURN
end subroutine

public function integer of_update_app_filters ();//Update app_filter records - Evan 11.04.2010

Integer li_rtn = 1
String ls_path, ls_Error
n_cst_datastore lds_app_filters
n_appeon_download lnv_download 

lds_app_filters = Create n_cst_datastore
lds_app_filters.DataObject = 'd_app_filters_update'
lds_app_filters.SetTransObject(SQLCA)

IF appeongetclienttype() = 'WEB' THEN
	ls_path = gs_dir_path + "intellicred\app_filters_data.txt"
	//Download the text file
	IF lnv_download.of_downloadfile("", ls_path) <> 0 THEN
		ls_Error = "n_cst_update_extra.of_update_app_filters() Information: Failed to download " + ls_path + ", call support."
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) 
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF		
	END IF
ELSE 
	ls_path = Gs_Current_Directory + "\app_filters_data.txt"
END IF

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN
	w_infodisp.Title = 'Update App Filters'
	w_infodisp.Center = True
	w_infodisp.st_complete.Visible = False
	w_infodisp.st_3.Visible = False
	w_infodisp.st_information.Visible = False
	w_infodisp.st_1.Text = 'Update App Filters, Please stand by'
	w_infodisp.wf_set_min_max(1,2)
END IF

//Update data
IF FileExists(ls_path) = True THEN
	IF IsValid(w_infodisp) THEN
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Tables 1 of 1, Please stand by'
	END IF
	DELETE FROM app_filters;
	
	lds_app_filters.Reset()
	IF lds_app_filters.ImportFile( ls_path ) >= 0 THEN
		lds_app_filters.Update()
		COMMIT Using SQLCA;		
		IF SQLCA.SQLCode = -1 THEN ls_Error = "n_cst_update_extra.of_update_app_filters() Information:Failed to update App Filters due to ~r~n " + SQLCA.SQLErrText
	ELSE
		ls_Error = "n_cst_update_extra.of_update_app_filters() Information: The file " + ls_path + " cannot be imported to the table."
	END IF
ELSE
	ls_Error = "n_cst_update_extra.of_update_app_filters() Information: File  does not exist " + ls_path + ". Unable to update App Filters."
END IF

//Log error 
IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice)THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	li_rtn = -1	
END IF

Destroy lds_app_filters

//If isvalid(w_infodisp) Then Close(w_infodisp)

RETURN li_rtn
end function

public function integer of_update_priv ();//////////////////////////////////////////////////////////////////////
// $<function> of_update_priv
// $<arguments>
// $<returns> integer
// $<description> V11.2-Privilege data migration
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.18.2011
//////////////////////////////////////////////////////////////////////

long ll_Do, ll_Pos, ll_lookup_code
long ll_Row, ll_RowCount, ll_InsertRow, ll_FindRow
string ls_Description, ls_Code, ls_lookup_name
string ls_procd_desc, ls_procd_name, ls_Find
datastore lds_code_lookup, lds_list_data
datastore lds_clin_data, lds_procd_lookup

//Start Code Change ----04.06.2011 #V11 maha - modified so that the different sections can be run separately
// The below updates should only be done once each.
//AAA
select count(*) into :ll_RowCount from priv_template;
if ll_RowCount > 0 then 
	//Return 0
else
	//A - Create privilege template records according to priv_clinical_area table records.
	insert into priv_template (template_id, template_name)
	select DISTINCT
		  facility.facility_id, 
		  facility.facility_name
	from facility, priv_clinical_area
	where facility.facility_id = priv_clinical_area.facility_id;
	
	//E - Update facility privilege template value for any facilities that has privileges.
	update facility
	  set facility.priv_template = facility.facility_id
	from facility, priv_clinical_area
	where facility.facility_id = priv_clinical_area.facility_id;
end if


/////////////////////////////////////////////////////////////////////////////////////
//BBB Create lookup tables
select count(*) into :ll_RowCount from code_lookup where lookup_name = 'Priv Clinical Area';
if ll_RowCount > 0 then
	//skip
else
	
	//B - Code lookup table Privilege Clinical Area from distinct list of clinical areas.
	//    Update clinical area records with created lookup codes.
	//C - Code lookup table Privilege Section from distinct list of Sections.
	//    Update sections records with created lookup codes.
	lds_code_lookup = Create datastore
	lds_list_data = Create datastore
	lds_code_lookup.dataobject = "d_dddw_code_lookup_clin_area"
	lds_code_lookup.SetTransObject(SQLCA)
	for ll_Do = 1 to 2
		if ll_Do = 1 then
			ls_lookup_name = "Priv Clinical Area"
			lds_list_data.dataobject = "d_clin_area_migrate"
		else
			ls_lookup_name = "Priv Section"
			lds_list_data.dataobject = "d_section_migrate"
		end if
		// Add records to code lookup table
		lds_list_data.SetTransObject(SQLCA)
		ll_RowCount = lds_list_data.Retrieve()
		for ll_Row = 1 to ll_RowCount
			ls_Description = lds_list_data.GetItemString(ll_Row, 1)
			if IsNull(ls_Description) or Trim(ls_Description) = "" then
				Continue
			end if
			// Get code and description values
			ll_Pos = Pos(ls_Description, " ", 1)
			if ll_Pos = 0 then ll_Pos = 15		
			ls_Code = Mid(ls_Description, 1, ll_Pos - 1)
			ls_Code = Left(ls_Code, 30)
			ls_Code = Upper(ls_Code)
			ls_Description = Left(ls_Description, 75)
			// Add record if it not exists
			ls_Find = "(upper(code) = '" + ls_Code + "') AND (upper(description) = '" + upper(ls_Description) + "')"
			ll_FindRow = lds_code_lookup.Find(ls_Find, 1, lds_code_lookup.RowCount())
			if ll_FindRow > 0 then
				lds_list_data.SetItem(ll_Row, "lookup_code", ll_FindRow)
			else
				ll_InsertRow = lds_code_lookup.InsertRow(0)
				lds_list_data.SetItem(ll_Row, "lookup_code", ll_InsertRow)
				lds_code_lookup.SetItem(ll_InsertRow, "code", ls_Code)
				lds_code_lookup.SetItem(ll_InsertRow, "description", ls_Description)
				lds_code_lookup.SetItem(ll_InsertRow, "lookup_name", ls_lookup_name)		
			end if
		next
		// Set lookup codes
		ll_RowCount = lds_code_lookup.RowCount()
		ll_lookup_code = gnv_app.of_get_id("LOOKUP", ll_RowCount)
		for ll_Row = 1 to ll_RowCount
			lds_code_lookup.SetItem(ll_Row, "lookup_code", ll_lookup_code)
			ll_lookup_code ++
		next
		ll_RowCount = lds_list_data.RowCount()
		for ll_Row = 1 to ll_RowCount
			ll_InsertRow = lds_list_data.GetItemNumber(ll_Row, "lookup_code")
			if ll_InsertRow > 0 then
				lds_list_data.SetItem(ll_Row, "lookup_code", lds_code_lookup.object.lookup_code[ll_InsertRow])
			end if
		next
		lds_code_lookup.Update()
		lds_list_data.Update()
		lds_code_lookup.Reset()
	next
	Destroy lds_code_lookup
	Destroy lds_list_data
end if

/////////////////////////////////////////////////////////////////////////////////////////
//CCC Create procedure lookup
select count(*) into :ll_RowCount from priv_procd_lookup;
if ll_RowCount > 0 then
	//skip
else
	//D - Create list of procedure lookup records from distinct procedures, including section
	//    and clinical Area codes.  Update template procedures with created lookup codes.
	lds_clin_data = Create datastore
	lds_procd_lookup = Create datastore
	lds_clin_data.DataObject = "d_procd_migration"
	lds_procd_lookup.DataObject = "d_priv_procd_lookup_browse"
	lds_clin_data.SetTransObject(SQLCA)
	lds_procd_lookup.SetTransObject(SQLCA)
	ll_RowCount = lds_clin_data.Retrieve()
	
	for ll_Row = 1 to ll_RowCount
		ll_InsertRow = lds_procd_lookup.InsertRow(0)
		lds_procd_lookup.SetItem(ll_InsertRow, "procedure_pk", lds_clin_data.object.priv_core_procd_procd_id[ll_Row])
		lds_procd_lookup.SetItem(ll_InsertRow, "clinical_area_id", lds_clin_data.object.priv_clinical_area_clin_lookup[ll_Row])
		lds_procd_lookup.SetItem(ll_InsertRow, "section_id", lds_clin_data.object.priv_core_sect_lookup[ll_Row])
		lds_procd_lookup.SetItem(ll_InsertRow, "facility_specific", lds_clin_data.object.facility_id[ll_Row])
		lds_procd_lookup.SetItem(ll_InsertRow, "active_status", 1)
		// If name or desc are blank copy other value.
		ls_procd_desc = lds_clin_data.GetItemString(ll_Row, "procd_description")
		ls_procd_name = lds_clin_data.GetItemString(ll_Row, "procd_name")
		if IsNull(ls_procd_desc) or Len(ls_procd_desc) = 0 then ls_procd_desc = ls_procd_name
		if IsNull(ls_procd_name) or Len(ls_procd_name) = 0 then ls_procd_name = Left(ls_procd_desc, 50)
		lds_procd_lookup.SetItem(ll_InsertRow, "procedure_description", ls_procd_desc)
		lds_procd_lookup.SetItem(ll_InsertRow, "procd_name", ls_procd_name)
	next
	lds_procd_lookup.Update()
	Destroy lds_clin_data
	Destroy lds_procd_lookup
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 04.07.2011
	//$<reason> update priv_core_procd.procd_lookup_id 
	update priv_core_procd 
	set priv_core_procd.procd_lookup_id = priv_procd_lookup.procedure_pk
	from priv_core_procd, priv_procd_lookup
	where priv_core_procd.procd_id = priv_procd_lookup.procedure_pk;
	//------------------- APPEON END ---------------------
end if

//DDD
//F - Update practitioner assigned privileges with procedure lookup ids.
//Start Code Change ----04.06.2011 #V11 maha - changed update query
//update pd_priv_list set procd_lookup_id = procd_id where procd_lookup_id is null;

update pd_priv_list 
set pd_priv_list.procd_lookup_id = priv_core_procd.procd_lookup_id
from pd_priv_list join priv_core_procd on pd_priv_list.procd_id = priv_core_procd.procd_id
where pd_priv_list.procd_lookup_id is null;
//Start Code Change ----04.06.2011


Return 1
end function

public function integer of_update_object_band ();//Update the objcet_band field in screen_report_objects for profile report
//V12.1 meeting - alfee 02.22.2012

Integer 	li_prf_id, li_rtn
Long 		ll_cnt, ll_cnt_obj, ll_i, ll_found
String		ls_prfdw, ls_objects, ls_obj
String		ls_objtype, ls_objband
String		ls_visible, ls_Error

//Return if updated
Select count(*) into :ll_cnt from screen_report_objects where object_band is not null;
if ll_cnt > 0 then return 0

//fix a datawindow bug for d_prf_clin_spec
update screen_report_objects set object_name = 't_1' where screen_id = 3 and convert(varchar, object_text) = 'Clinical Specialities';
update screen_report_objects set object_name = 't_2' where screen_id = 3 and convert(varchar, object_text) = 'Clinical Specialty';
update screen_report_objects set object_name = 't_3' where screen_id = 3 and convert(varchar, object_text) = 'Rank';

//Initialization 
datastore lds_data
datastore lds_profile_report_dw
datastore lds_screen_report_objects

lds_data = create datastore
lds_profile_report_dw = create datastore
lds_screen_report_objects = create datastore
lds_profile_report_dw.dataobject='d_profile_report_dw_band'
lds_screen_report_objects.dataobject='d_screen_report_objects_band'
lds_profile_report_dw.settransobject(sqlca)
lds_screen_report_objects.settransobject(sqlca)

ll_cnt = lds_profile_report_dw.retrieve()
ll_cnt_obj = lds_screen_report_objects.retrieve()

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Update Screen Report Objects, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.Center = True
IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Update Screen Report Objects, Please stand by'
IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,ll_cnt)

//Loop for each profile report datawindow
for ll_i=1 to ll_cnt
	IF IsValid(w_infodisp) THEN
		Yield()
		w_infodisp.wf_step_pbar(1)
		w_infodisp.st_1.Text = 'Generate ' + String(ll_i) + ' of ' + String(ll_cnt)+' Please stand by!'
	END IF
	
	li_prf_id=lds_profile_report_dw.getitemnumber(ll_i,"prf_id")
	ls_prfdw=lds_profile_report_dw.getitemstring(ll_i,"prf_dw")

	//Filter objects with the current profile id
	lds_screen_report_objects.SetFilter("screen_id = " + String(li_prf_id))
	lds_screen_report_objects.Filter()
	ll_cnt_obj = lds_screen_report_objects.RowCount()
	IF ll_cnt_obj < 1 THEN Continue	

	//Get objects list and loop for each object
	lds_data.dataobject=ls_prfdw
	ls_objects=lds_data.describe("datawindow.objects")+'~t'
	ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
	do while LenA(ls_obj)>0
		//Get object properties
		ls_objtype=lds_data.describe(ls_obj+".type")
		//ls_visible=lds_data.describe(ls_obj+".visible")
		if ls_objtype='column' then
			ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
			ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
			continue
		end if
		ls_objband=lds_data.describe(ls_obj+".band")
		
		//Find and set the band field according to the object name
		ll_found = lds_screen_report_objects.Find("Lower(object_name) = '" + Lower(ls_obj)  + "'", 1, ll_cnt_obj)
		do while ll_found > 0
			lds_screen_report_objects.SetItem(ll_found, "object_band", ls_objband)
			if ll_found >= ll_cnt_obj  then exit
			ll_found = lds_screen_report_objects.Find("Lower(object_name) = '" + Lower(ls_obj)  + "'", ll_found + 1, ll_cnt_obj)
		loop
		
		ls_objects=MidA(ls_objects,PosA(ls_objects,'~t')+LenA('~t'))
		ls_obj=LeftA(ls_objects,PosA(ls_objects,'~t') - 1)
	loop
next

li_rtn = lds_screen_report_objects.update()
commit using sqlca;

IF SQLCA.SQLCode <> 0 THEN 
	ls_Error = "n_cst_update_extra.of_update_object_band() Information:Failed to update the object_band field due to ~r~n " + SQLCA.SQLErrText
END IF

//Log error 
IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice)THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	li_rtn = -1	
END IF

Destroy lds_data
Destroy lds_profile_report_dw
Destroy lds_screen_report_objects

Return li_rtn


end function

public function integer of_update_data_v121 ();//Update extra data for V12.1 meeting-  Alfee 02.22.2012

//1. Update the object_band field in screen_report_objects

Integer li_rtn

li_rtn = of_update_object_band ()

return li_rtn
end function

public subroutine of_login_buttons_data ();//From Maha - Moved from n_cst_update_data by Alfee 07.09.2013

integer cnt

select count(button_type) into :cnt from button_type;

if cnt = 0 or isnull(cnt) then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (1,'provider14.jpg','Provider',40) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (2,'contracts14.jpg','Contracts',2070) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (3,'actions14.jpg','Actions',240) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (4,'reports14.jpg','Reports',700) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (5,'intellireport14.jpg','IntelliReport',1470) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (6,'appmap14.jpg','Appl Mapping',1460) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (7,'export14.jpg','Export',550) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (8,'import14.jpg','Import',6928) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (9,'calllog14.jpg','Contact Log', 7661) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (10,'privileges14.jpg','Privileges',1310) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (11,'groups14.jpg','Groups',1320) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (12,'printapps14.jpg','Print Apps',1330) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (13,'utilities14.jpg','Utilities',1340) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (14,'setup14.jpg','Setup',NULL) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (15,'letters14.jpg','Letters',400) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (16,'todolist14.jpg','To Do List',5850) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (17,'mainscreen14.jpg','Main Screen',-1) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (0,'displaynobutton.jpg','None',-1) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (18,'callactions14.jpg','Contact Log Actions', 7671) "
end if

 //Start Code Change ----05.26.2015 #V15 maha
is_sql_statements[upperbound(is_sql_statements) + 1] = &
"if not exists (select 1 from button_type where button_type = 19 ) " + &
"	INSERT INTO button_type VALUES (19,'recruitment.jpg','Recruitment', 7711)  "
 //End Code Change ----05.26.2015

select count(temp_id) into :cnt from button_template;

if cnt = 0 then
	select set_9 into :cnt from icred_settings;
	choose case cnt
		case 0  //cred
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default',1,10,11,16,17,3,14,4,5) "
		case 4 //contract
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 0,2,0,14,17,16,0,5,0) "
		case 1 //app
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 1,11,6,12,17,16,5,4,3) "
		case else //smart and other
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 0,1,0,4,17,12,0,11,0) "
	end choose
	
end if

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"Update security_roles set button_temp = 1 where button_temp is null "
			
of_execute_sqls ("Loading Button Type Data")


end subroutine

public function integer of_update_data_v141 ();//Update extra data for V14.1 -  Alfee 07.09.2013

//1. Update the login button data
of_login_buttons_data ()


RETURN 1

end function

public function integer of_login_button_data2 ();//Start Code Change ----08.20.2013 #V14 maha - org button data

integer cnt

select count(button_type) into :cnt from button_type;

if cnt = 0 or isnull(cnt) then
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (1,'prac1.jpg','Provider',40) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (2,'contract.png','Contracts',2070) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (3,'actions2.jpg','Actions',240) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (4,'report1.jpg','Reports',700) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (5,'checklistlinking.png','IntelliReport',1470) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (6,'mapping.jpg','Appl Mapping',1460) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (7,'export2.bmp','Export',550) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (8,'import2.bmp','Import',6928) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (9,'call1.jpg','Contact Log',1350) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (10,'priv3.jpg','Privileges',1310) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (11,'group1.jpg','Groups',1320) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (12,'appprint.jpg','Print Apps',1330) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (13,'utilities1.jpg','Utilities',1340) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (14,'settings2.bmp','Setup',NULL) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (15,'letters2.bmp','Letters',400) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (16,'tdl1.jpg','To Do List',5850) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (17,'Splash-v12.jpg','Main Screen',-1) "
		is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (0,'displaynobutton.jpg','None',-1) "
	is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
	"INSERT INTO button_type VALUES (18,'tdl3.jpg','Contact Log Actions',1330) "
end if

select count(temp_id) into :cnt from button_template;

if cnt = 0 then
	select set_9 into :cnt from icred_settings;
	choose case cnt
		case 0  //cred
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default',1,10,11,16,17,3,14,4,5) "
		case 4 //contract
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 0,2,0,14,17,16,0,5,0) "
		case 1 //app
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 1,11,6,12,17,16,5,4,3) "
		case else //smart and other
			is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"insert into button_template values (1,'Default', 0,1,0,4,17,12,0,11,0) "
	end choose
	
end if

is_sql_statements[UpperBound(is_sql_statements) + 1] =  &
			"Update security_roles set button_temp = 1 where button_temp is null "
			
of_execute_sqls ("Loading Button Type Data")

return 1
end function

public function integer of_update_data_v142 ();//Update extra data for V14.2 -  Alfee 07.30.2014

//1. New view field alias after released - alfee 07.30.2014
inv_upd_vfld.of_InsertField("v_claims", "carrier_lookup", "carrier lookup" , 1, "carrier_lookup" )
inv_upd_vfld.of_InsertField("v_claims", "carrier_lookup_name", "carrier lookup name" , 1, "carrier_lookup")
inv_upd_vfld.of_InsertField("v_claims", "case_included_npdb", "case included npdb" , 1, 'case_included_npdb')
inv_upd_vfld.of_InsertField("v_claims", "case_included_npdb_description", "case included npdb description" , 1, 'case_included_npdb')
inv_upd_vfld.of_InsertField("v_claims", "judgement_for", "judgement for" , 1, "judgement_for")
inv_upd_vfld.of_InsertField("v_claims", "judgement_for_description", "judgement for description" , 1,"judgement_for")
inv_upd_vfld.of_InsertField("v_claims", "num_defendant", "num defendant" , 1)
inv_upd_vfld.of_InsertField("v_claims", "policy_num", "policy num" , 1)
inv_upd_vfld.of_InsertField("v_claims", "reference_value", "reference value" , 1)
inv_upd_vfld.of_InsertField("v_claims", "primary_defendant", "primary defendant" , 1, "primary_defendant")
inv_upd_vfld.of_InsertField("v_claims", "primary_defendant_description", "primary defendant description" , 1, "primary_defendant")
inv_upd_vfld.of_InsertField("v_claims", "resolution_method", "resolution method" , 1, "resolution_method")
inv_upd_vfld.of_InsertField("v_claims", "resolution_method_description", "resolution method description" , 1, "resolution_method")
inv_upd_vfld.of_InsertField("v_claims", "result_in_death", "result in death" , 1, "result_in_death")
inv_upd_vfld.of_InsertField("v_claims", "result_in_death_description", "result in death description" , 1, "result_in_death")

//Added by Appeon long.zhang 12.10.2014(Feature Request # 4345, Customer requests adding pd_insurance.shared_individ to Report View)
inv_upd_vfld.of_InsertField("v_insurance", "self_insured_code", "self_insured_code" , 1, "self_insured")
inv_upd_vfld.of_InsertField("v_insurance", "self_insured_description", "self_insured_description" , 1, "self_insured")
inv_upd_vfld.of_InsertField("v_insurance", "shared_individ_code", "shared_individ_code" , 1, "shared_individ")
inv_upd_vfld.of_InsertField("v_insurance", "shared_individ_description", "shared_individ_description" , 1, "shared_individ")
inv_upd_vfld.of_InsertField("v_insurance", "coverage_unlimited_code", "coverage_unlimited_code" , 1, "coverage_unlimited")
inv_upd_vfld.of_InsertField("v_insurance", "coverage_unlimited_description", "coverage_unlimited_description" , 1, "coverage_unlimited")

//Added by Appeon long.zhang 12.25.2014(v14.129 Customer Bug #4378, Case # 50780, v_qa_* views are not being updated)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "rec_id", "Rec Id" , 1,0)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "prac_id", "Prac Id" , 1,0)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "metric_id", "Metric Id" , 1, 0,"metric_id")
inv_upd_vfld.of_InsertField("v_pd_qa_data", "qa_metrics_indicator", "Metric Indicator" , 1, 0,"metric_id")
inv_upd_vfld.of_InsertField("v_pd_qa_data", "facility_id", "Facility Id" ,1,0)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "from_date", "From Date",1  ,0)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "to_date", "To Date" , 1,0)
inv_upd_vfld.of_InsertField("v_pd_qa_data", "measurment", "Measurment" , 1,0)
inv_upd_vfld.of_deletefield('v_qa_measurements','qa_profile_group_id')
inv_upd_vfld.of_deletefield('v_qa_measurements','qa_profile_group_name')
inv_upd_vfld.of_deletefield('v_qa_measurements','threshold')
inv_upd_vfld.of_deletefield('v_qa_measurements','qa_measurement_name')
inv_upd_vfld.of_InsertField("v_qa_measurements", "pd_qa_profile_data_id", "Data Id" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "qa_measurement_acceptable_threshold", "Acceptable Threshold" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "qa_measurement_excellence_threshold", "Excellence Threshold" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "qa_measurement_threshold_hi_low", "Threshold hi/low" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "qa_measurement_threshold_hi_low_desc", "Threshold hi/low Description" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "category_name", "Category Name" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "metric_id", "Metric Id" , 1,0)
inv_upd_vfld.of_InsertField("v_qa_measurements", "metric_indicator", "Metric Indicator" , 1,0)

//alfee 01.08.2015 - for  50919  / Issue Adding Practicing in iReport
inv_upd_vfld.of_InsertField("v_board_specialty", "practicing", "Practicing(Y/N)" , 1, "practicing")
inv_upd_vfld.of_InsertField("v_board_specialty", "not_certified_reason", "Reason For Not Certified" , 1, "not_certified_reason")
inv_upd_vfld.of_InsertField("v_board_specialty", "exam_date", "Exam Date" , 1 )

//alfee 02.04.2015
inv_upd_vfld.of_InsertField("v_verif_info", "direct_parent_facility_link", "Direct Parent Facility Link" , 0, 0)
inv_upd_vfld.of_InsertField("v_verif_info", "verification_picture_flag", "Verification Picture Flag" , 0, 0)
inv_upd_vfld.of_InsertField("v_verif_info", "due_date", "Due Date" , 1, 0)
inv_upd_vfld.of_InsertField("v_verif_info", "data_status", "Data Status" , 1, 0)
inv_upd_vfld.of_InsertField("v_verif_info", "fee", "Fee" , 1, 0)

//2. Update profile data for basic information - alfee 12.26.2014
of_profile_personal_info ()

RETURN 1

end function

public function integer of_profile_personal_info ();//Support Personal Information in Profile Report Design - alfee 12.27.2014

Long i, ll_max_id,j, ll_cnt
String ls_Error
String ls_null []
n_cst_datastore lds_viewid,lds_dw,lds_update

Select Count(*) Into :ll_cnt From profile_report_dw Where prf_id = 40 And scr_dw = 'd_scr_personal' And scr_id = 1;
IF ll_cnt > 0 THEN RETURN 0 //Run only one time

//1. Update data in profile_reports & profile_report_dw
is_sql_statements = ls_null
is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update profile_reports Set profile_report_name = 'Personal Information' Where profile_report_id = 40 And profile_report_name = 'Personal with Photo' "

is_sql_statements[upperbound(is_sql_statements) + 1] =  &
"Update profile_report_dw Set scr_dw = 'd_scr_personal', scr_id = 1, dw_name = 'Personal Information'  Where prf_id = 40 And (scr_dw IS Null Or scr_dw <> 'd_scr_personal') "

of_execute_sqls("of_profile_presonal_info")

//2. Copy data in profile_report_dw for personal information and other views 
lds_viewid = Create n_cst_datastore
lds_viewid.DataObject = 'd_profile_views_prfid'
lds_viewid.SetTransObject(sqlca)
lds_viewid.Retrieve(40) 

lds_dw = Create n_cst_datastore
lds_dw.DataObject = 'd_profile_report_dw' //999
lds_dw.SetTransObject(sqlca)
lds_dw.Retrieve()
lds_dw.SetFilter("prf_id = 40")
lds_dw.Filter()

lds_update = Create n_cst_datastore
lds_update.DataObject = 'd_profile_report_dw'
lds_update.SetTransObject(sqlca)

FOR i = 1 To lds_viewid.RowCount()	
	IF lds_dw.RowCount() > 0 THEN
		lds_dw.RowsCopy(1, 1, Primary!, lds_update, 1, Primary!)
		lds_update.Object.profile_view_id[1] = lds_viewid.Object.profile_view_id[i]			
	END IF
NEXT

IF lds_update.Update( ) = -1 THEN
		ls_Error+= "n_cst_update_extra.of_profile_presonal_info() Information: Copy data in profile_report_dw for personal information and other views failed, call support."
		IF IsValid(gnv_logservice)THEN
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = True
		END IF
		lds_update.Reset()
END IF

//3. Copy data in profile_report_dw for home address and other views  - history bug
lds_viewid.Retrieve(42) 
lds_dw.SetFilter("prf_id = 42")
lds_dw.Filter()
lds_update.Reset()

FOR i = 1 To lds_viewid.RowCount()	
	IF lds_dw.RowCount() > 0 THEN
		lds_dw.RowsCopy(1, 1, Primary!, lds_update, 1, Primary!)
		lds_update.Object.profile_view_id[1] = lds_viewid.Object.profile_view_id[i]			
	END IF
NEXT

IF lds_update.Update( ) = -1 THEN
		ls_Error+= "n_cst_update_extra.of_profile_presonal_info() Information: Copy data in profile_report_dw for home address and other views failed, call support."
		IF IsValid(gnv_logservice)THEN
			gnv_logservice.of_setloglevel(2) //warning level
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = True
		END IF
		lds_update.Reset()
END IF

//4. Append feilds in sys_report_fields if not existed.
inv_upd_data.of_create_dwdata ("d_prf_personal_w_photo", true) 

RETURN 1

end function

public function integer of_update_data_v151 ();//Update extra data for V15.1 //Added by Appeon long.zhang 04.29.2016

//1. New view field alias after released 
inv_upd_vfld.of_InsertField("v_group_covering", "covering_description", "Covering Description" , 1, "covering" )

RETURN 1

end function

public function integer of_update_data_v152 ();//Update extra data for V15.2 //Added by Appeon long.zhang 06.01.2016

//update view_fields_alias, Added by Appeon long.zhang 06.01.2016 (Bug id 5186 - Fields missing from Views, Cannot Quick Select in IntelliReport V14.2 and V15)
inv_upd_vfld.of_update_view_fields_alias_f("v_affil_stat", "date_completed", "date_comm_review_completed")

//add v_basic.used_another_name
inv_upd_vfld.of_InsertField("v_basic", "used_another_name_code", "Used Another Name Code" , 1, "used_another_name")
inv_upd_vfld.of_InsertField("v_basic", "used_another_name_description", "Used Another Name Description" , 1, "used_another_name")

//For Checklist Standardization - alfee 08.11.2016
inv_upd_vfld.of_InsertField("v_data_view_app_audit", "app_audit_id", "App Audit Id" ,1, 0)
inv_upd_vfld.of_InsertField("v_data_view_app_audit", "template_id", "Template Id" ,1, 0)
inv_upd_vfld.of_InsertField("v_data_view_app_audit", "screen_description", "Screen Description", 1, 0)
inv_upd_vfld.of_InsertField("v_data_view_app_audit", "letter_description", "Letter Description", 1, 0)
inv_upd_vfld.of_InsertField("v_data_view_app_audit", "screen_id", "Screen Id", 1, 0)


RETURN 1

end function

public function integer of_update_data_v153 ();
return 1
end function

public function integer of_download_file (string as_file_path);//====================================================================
//$<Function>: of_download_file
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.05.2017 (V15.3 Bug # 5631 - import zip data file is missing in SaaS)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_rtn = 1
String ls_path, ls_Error
n_appeon_download lnv_download 

IF appeongetclienttype() = 'WEB' THEN 
	ls_path = as_file_path
	//Download the text file
	IF lnv_download.of_downloadfile("", ls_path) <> 0 THEN
		ls_Error = "n_cst_update_extra.of_download_file() Information: Failed to download " + ls_path + ", call support."			
		IF IsValid(gnv_logservice)THEN 
			gnv_logservice.of_setloglevel(2) 
			gnv_logservice.of_log_warning(ls_Error)
			gb_upgrade_failed = TRUE			
		END IF
		
	END IF
ELSE 
	ls_path = as_file_path
END IF

IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
IF IsValid(w_infodisp) THEN
	w_infodisp.Title = 'Update fields'
	w_infodisp.Center = True
	w_infodisp.st_complete.Visible = False
	w_infodisp.st_3.Visible = False
	w_infodisp.st_information.Visible = False
	w_infodisp.st_1.Text = 'Update fields, Please stand by'
	w_infodisp.wf_set_min_max(1,2)
END IF

//Update data
If isvalid(w_infodisp) Then Close(w_infodisp)
IF FileExists(ls_path) = True THEN
	return 1
ELSE
	return -1
END IF

//Log error 
IF LenA(ls_Error) > 0 AND IsValid(gnv_logservice)THEN 
	gnv_logservice.of_setloglevel(2) 
	gnv_logservice.of_log_warning(ls_Error)
	gb_upgrade_failed = TRUE
	li_rtn = -1	
END IF

RETURN li_rtn
end function

public function integer of_update_data_v154 ();return 1
end function

public function integer of_update_data_v161 ();return 1
end function

on n_cst_update_extra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_extra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_upd_vfld = create n_cst_update_view_fields_alias //alfee 07.30.2014
inv_upd_data = create n_cst_update_data  //alfee 12.26.2014
end event

event destructor;destroy inv_upd_vfld  //alfee 07.30.2014
destroy inv_upd_data  //alfee 12.26.2014
end event

