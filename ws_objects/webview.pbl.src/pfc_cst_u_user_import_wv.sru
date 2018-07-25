$PBExportHeader$pfc_cst_u_user_import_wv.sru
forward
global type pfc_cst_u_user_import_wv from userobject
end type
type st_2 from statictext within pfc_cst_u_user_import_wv
end type
type dw_2 from datawindow within pfc_cst_u_user_import_wv
end type
type cb_x2 from commandbutton within pfc_cst_u_user_import_wv
end type
type cb_x1 from commandbutton within pfc_cst_u_user_import_wv
end type
type rb_f from radiobutton within pfc_cst_u_user_import_wv
end type
type rb_np from radiobutton within pfc_cst_u_user_import_wv
end type
type rb_fl from radiobutton within pfc_cst_u_user_import_wv
end type
type cb_imp_run from commandbutton within pfc_cst_u_user_import_wv
end type
type rb_ext from radiobutton within pfc_cst_u_user_import_wv
end type
type rb_imp from radiobutton within pfc_cst_u_user_import_wv
end type
type cb_browse from commandbutton within pfc_cst_u_user_import_wv
end type
type sle_file from singlelineedit within pfc_cst_u_user_import_wv
end type
type cb_import from commandbutton within pfc_cst_u_user_import_wv
end type
type dw_1 from u_dw within pfc_cst_u_user_import_wv
end type
type cb_1 from u_cb within pfc_cst_u_user_import_wv
end type
type dw_departments from datawindow within pfc_cst_u_user_import_wv
end type
type cb_sad from u_cb within pfc_cst_u_user_import_wv
end type
type st_view from statictext within pfc_cst_u_user_import_wv
end type
type dw_department from u_dw within pfc_cst_u_user_import_wv
end type
type cb_sav from u_cb within pfc_cst_u_user_import_wv
end type
type cb_saf from u_cb within pfc_cst_u_user_import_wv
end type
type dw_facility from u_dw within pfc_cst_u_user_import_wv
end type
type cb_save from u_cb within pfc_cst_u_user_import_wv
end type
type cb_delete from u_cb within pfc_cst_u_user_import_wv
end type
type dw_select_user from u_dw within pfc_cst_u_user_import_wv
end type
type cb_new from u_cb within pfc_cst_u_user_import_wv
end type
type dw_views from u_dw within pfc_cst_u_user_import_wv
end type
type dw_roles from u_dw within pfc_cst_u_user_import_wv
end type
type st_1 from statictext within pfc_cst_u_user_import_wv
end type
type st_department from statictext within pfc_cst_u_user_import_wv
end type
type cb_close from u_cb within pfc_cst_u_user_import_wv
end type
type cb_print from u_cb within pfc_cst_u_user_import_wv
end type
type gb_select from groupbox within pfc_cst_u_user_import_wv
end type
type gb_main from groupbox within pfc_cst_u_user_import_wv
end type
type gb_1 from groupbox within pfc_cst_u_user_import_wv
end type
type gb_2 from groupbox within pfc_cst_u_user_import_wv
end type
end forward

global type pfc_cst_u_user_import_wv from userobject
integer width = 3602
integer height = 2200
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_2 st_2
dw_2 dw_2
cb_x2 cb_x2
cb_x1 cb_x1
rb_f rb_f
rb_np rb_np
rb_fl rb_fl
cb_imp_run cb_imp_run
rb_ext rb_ext
rb_imp rb_imp
cb_browse cb_browse
sle_file sle_file
cb_import cb_import
dw_1 dw_1
cb_1 cb_1
dw_departments dw_departments
cb_sad cb_sad
st_view st_view
dw_department dw_department
cb_sav cb_sav
cb_saf cb_saf
dw_facility dw_facility
cb_save cb_save
cb_delete cb_delete
dw_select_user dw_select_user
cb_new cb_new
dw_views dw_views
dw_roles dw_roles
st_1 st_1
st_department st_department
cb_close cb_close
cb_print cb_print
gb_select gb_select
gb_main gb_main
gb_1 gb_1
gb_2 gb_2
end type
global pfc_cst_u_user_import_wv pfc_cst_u_user_import_wv

type variables
String is_user_id
w_security_user_painter iw_win
Integer ii_dept_secure_setting

DataStore ids_facility //added by Alfee 06.11.2007
end variables

forward prototypes
public function integer of_create_user ()
public function integer of_delete ()
public function integer of_set_parent_window (w_security_user_painter aw_win)
public function integer of_copy_user ()
end prototypes

public function integer of_create_user ();
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Comment out the following script. Use the global datastore gnv_data.ids_facility
//$<modification> to replace the local datastore.
/* n_ds lds_facility */
//---------------------------- APPEON END ----------------------------
n_ds lds_roles
n_ds lds_views
long i
long li_nr
long li_rc
long li_rec_id
DataWindowChild dwchild
String ls_version
string ls_sql,ls_sql2
Integer li_retval

li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF

//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
//Open( w_get_user_id_v5 )  //maha 083105 changed window name
If gb_contract_version Then
	Open( w_get_user_id_v5_ctx )
Else
	Open( w_get_user_id_v5 )
End If
//---------End Modfiied ------------------------------------------------------

IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	is_user_id = Message.StringParm
END IF

if LenA(is_user_id) < 1 then return -1 //maha 082203 

dw_facility.Reset()
dw_facility.SetTransObject( SQLCA )

dw_roles.Reset()
dw_roles.SetTransObject( SQLCA )

dw_views.Reset()
dw_views.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Write script to retrieve data from a cache instead of from the database.
/*
//facility_id,  facility_name
lds_facility = CREATE n_ds
lds_facility.DataObject = "d_dddw_facility"
lds_facility.SetTransObject( SQLCA )
li_rc = lds_facility.Retrieve()
*/
Long li_rc_facility
//---------Begin Modified by Alfee 06.11.2007------------------------
li_rc_facility = ids_facility.Rowcount()
//li_rc_facility = gnv_data.ids_facility.Rowcount()
//---------End Modified ---------------------------------------------
//---------------------------- APPEON END ----------------------------

ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 01.17.2006 By: Cao YongWang
//$<reason> The Web application does not need to check whether there is an INI file on local machine.
//$<modification> Make an condition that when the application runs on the Web, the application does not check
//$<modification> the local INI file.

/*
IF NOT FileExists( gs_dir_path + "intellicred\intellicred.ini" ) THEN
	MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_dir_path + "intellicred\intellicred.ini" )
	Return -1
END IF
*/
If appeongetclienttype() = 'PB' Then
	IF NOT FileExists(gs_IniFilePathName) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		Return -1
	END IF
End If
//---------------------------- APPEON END ----------------------------


IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 04.12.2006 By: Rodger Wu
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

IF dw_department.Visible THEN
	Long ll_security_dept_code
	dw_departments.SetTransObject( SQLCA )
End If
lds_views = CREATE n_ds
lds_views.DataObject = "ds_dataview_all"
lds_views.SetTransObject( SQLCA )

gnv_appeondb.of_StartQueue()
lds_views.Retrieve()
IF dw_department.Visible THEN
	SELECT MAX( user_depart_id ) 
	INTO :ll_security_dept_code
	FROM security_user_department;
	
	dw_departments.Retrieve()
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	END IF
End If	
gnv_appeondb.of_CommitQueue()
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
//li_rc = lds_views.Rowcount() + li_rc_facility
//li_rec_id = gnv_app.of_get_id( "RIGHTS" ,li_rc) - 1
li_rec_id = gnv_app.of_get_id( "user_facility_id" ,li_rc_facility) - 1
li_rc = li_rc_facility
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-06
	//$<modify> 02.17.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Comment out the following script to reduce client-server interaction.
	//$<modification> refer to PT-15 and of_get_id for more information.
	/*
	li_rec_id = gnv_app.of_get_id( "RIGHTS" )
	dw_facility.InsertRow( 0 )
	dw_facility.SetItem( i, "user_facility_id", li_rec_id )
	dw_facility.SetItem( i, "user_id", is_user_id )
	dw_facility.SetItem( i, "facility_id", lds_facility.GetItemNumber( i, "facility_id" ) )
	*/
	li_rec_id ++
	dw_facility.InsertRow( 0 )
	dw_facility.SetItem( i, "user_facility_id", li_rec_id )
	dw_facility.SetItem( i, "user_id", is_user_id )
	//---------Begin Modified by Alfee 06.11.2007------------------------
	dw_facility.SetItem( i, "facility_id", ids_facility.GetItemNumber( i, "facility_id" ) )
	//dw_facility.SetItem( i, "facility_id", gnv_data.ids_facility.GetItemNumber( i, "facility_id" ) )
	//---------End Modified ----------------------------------------------
	//---------------------------- APPEON END ----------------------------
	dw_facility.SetItem( i, "access_rights", 0 )
END FOR

////role_id, role_name
//lds_roles = CREATE n_ds
//lds_roles.DataObject = "d_dddw_security_roles"
//lds_roles.SetTransObject( SQLCA )
//li_rc = lds_roles.Retrieve()
//
//FOR i = 1 TO li_rc
//	ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
//	dw_roles.InsertRow( 0 )
//	dw_roles.SetItem( i, "security_user_roles_user_role_id", ll_rec_id )
//	dw_roles.SetItem( i, "security_user_roles_user_id", is_user_id )
//	dw_roles.SetItem( i, "security_user_roles_access_rights", 0 )	
//	dw_roles.SetItem( i, "security_user_roles_role_id", lds_roles.GetItemNumber( i, "role_id" ))	
//END FOR
//

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<comment> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Move the following script to PT-04. It is integrated into Appeon Queue
//$<modification> labels to reduce client-server interactions.
/*
//data_view_id, data_view_name
lds_views = CREATE n_ds
lds_views.DataObject = "d_dddw_select_view"
lds_views.SetTransObject( SQLCA )
li_rc = lds_views.Retrieve()
*/
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
/*
FOR i = 1 TO li_rc
	li_rec_id = gnv_app.of_get_id( "RIGHTS" )
*/
li_rc = lds_views.Rowcount()
li_rec_id = gnv_app.of_get_id( "user_view_id" ,li_rc) - 1
FOR i = 1 TO li_rc
	li_rec_id ++
//---------------------------- APPEON END ----------------------------
	dw_views.InsertRow( 0 )
	dw_views.SetItem( i, "user_view_id", li_rec_id )
	dw_views.SetItem( i, "user_id", is_user_id )
	dw_views.SetItem( i, "access_rights", 0 )	
	dw_views.SetItem( i, "view_id", lds_views.GetItemNumber( i, "data_view_id" ) )	
END FOR

dw_select_user.GetChild( "user_id", dwchild )
dwchild.SetTransObject( SQLCA )
li_nr = dwchild.InsertRow( 0 )
dwchild.SetItem( li_nr, "user_id", is_user_id )
dwchild.SetItem( li_nr, "user_password", "123" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.16.2006 By: LeiWei
//$<reason> Fix a defect.
dwchild.SetItem( li_nr, "image_flag", "0" )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.22.2006 By: Davis
//$<reason> Fix a defect.
dwchild.SetItem( li_nr, "contract_default_view", 1001 )
//---------------------------- APPEON END ----------------------------

//add department data for security_user_department
IF dw_department.Visible THEN
		
	Integer li_dept_cnt
	Integer li_user_cnt
	Integer d
	Integer u
	Long ll_department
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-09
	//$<comment> 04.12.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<modification> Move the following script to PT-04. It is integrated into Appeon Queue
	//$<modification> labels to reduce client-server interactions.
	/*
	Long ll_security_dept_code
	
	SELECT MAX( user_depart_id ) 
	INTO :ll_security_dept_code
	FROM security_user_department;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	END IF
	
	dw_departments.SetTransObject( SQLCA )
	dw_departments.Retrieve( )
	*/
	//---------------------------- APPEON END ----------------------------

	li_dept_cnt = dw_departments.RowCount( )
		
	//Loop through all department and setup department security
	FOR d = 1 TO li_dept_cnt
		ll_security_dept_code ++
		ll_department = dw_departments.GetItemNumber( d, "lookup_code" )
							
		li_nr = dw_department.InsertRow( 0 )
		dw_department.SetItem( li_nr, "user_depart_id", ll_security_dept_code )
		dw_department.SetItem( li_nr, "user_id", is_user_id )
		dw_department.SetItem( li_nr, "department_id", ll_department )		
		dw_department.SetItem( li_nr, "access_rights", 0 )
	END FOR			

END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Update label to reduce client-server interactions to improve runtime performance.
/*
SQLCA.AutoCommit = false //maha 111604 because some of the data was not rolling back
IF dwchild.Update( True, False ) = 1 THEN
	IF dw_facility.Update( True, False ) = 1 THEN
		IF dw_roles.Update( True, False ) = 1 THEN
			IF dw_views.Update( True, False ) = 1 THEN
				IF dw_department.Update( True, False ) = 1 THEN
					dw_facility.ResetUpdate()
					dw_roles.ResetUpdate()
					dw_views.ResetUpdate()
					dwchild.ResetUpdate()
					dw_department.ResetUpdate()					
					COMMIT USING SQLCA;
				ELSE
					ROLLBACK USING SQLCA;
					RETURN -1				
				END IF
			ELSE
				ROLLBACK USING SQLCA;
				RETURN -1
			END IF
		ELSE
			ROLLBACK USING SQLCA;
			RETURN -1
		END IF
	ELSE
		ROLLBACK USING SQLCA;	
		RETURN -1
	END IF
ELSE
	ROLLBACK USING SQLCA;	
	RETURN -1	
END IF
SQLCA.AutoCommit = TRUE
*/
int li_updateflag = 1
li_updateflag = gnv_appeondb.of_update( dwchild, dw_facility, dw_roles)
if li_updateflag < 0 then
	ROLLBACK USING SQLCA;
	RETURN -1
end if
li_updateflag = gnv_appeondb.of_update( dw_views, dw_department)
if li_updateflag < 0 then
	ROLLBACK USING SQLCA;
	RETURN -1
else
	dw_facility.ResetUpdate()
	dw_roles.ResetUpdate()
	dw_views.ResetUpdate()
	dwchild.ResetUpdate()
	dw_department.ResetUpdate()	
	gnv_appeondb.of_startqueue( )
	COMMIT USING SQLCA;
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dw_facility.Retrieve( is_user_id )
IF dw_facility.RowCount() > 0 THEN
	dw_roles.InsertRow( 0 )
END IF
dw_views.Retrieve( is_user_id )
dw_select_user.SetItem( 1, "user_id", is_user_id )
dw_roles.Retrieve( is_user_id )

IF dw_department.Visible THEN
	dw_department.Retrieve( is_user_id )
END IF
*/
dw_facility.Retrieve( is_user_id )
dw_views.Retrieve( is_user_id )
dw_roles.Retrieve( is_user_id )
IF dw_department.Visible THEN
	dw_department.Retrieve( is_user_id )
END IF
gnv_appeondb.of_commitqueue( )

dw_select_user.SetItem( 1, "user_id", is_user_id )
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 03.06.2006 #247 maha  removed user add to db
//ls_sql = "Grant connect to " + is_user_id  + " identified by '123';"
//execute immediate :ls_sql using sqlca;
//commit using sqlca;
//ls_sql = "Grant dba to " + is_user_id  + ";"
//execute immediate :ls_sql using sqlca;
//commit using sqlca;
//End Code Change---03.06.2006

RETURN 1
end function

public function integer of_delete ();DataWindowChild dwchild

Integer li_ans
Long ll_cnt
String ls_sql

li_ans = MessageBox("Delete", "Are you sure you want to delete this User " + Upper( is_user_id ) + "?", StopSign!, YesNo!, 2 )
IF li_ans = 2 THEN
	RETURN -1
END IF

//---------Begin Added by Alfee 06.12.2007-----------------------------------
Select count(*) Into :ll_cnt From ctx_contacts Where user_d = :is_user_id ;
If ll_cnt > 0 Then
	MessageBox("Delete","This user id has been used a contact in contracts, and can't be deleted!")
	Return -1
End If
//----------End Added --------------------------------------------------------

dw_department.Reset( )
dw_department.SetTransObject( SQLCA )

dw_facility.Reset()
dw_facility.SetTransObject( SQLCA )

dw_roles.Reset()
dw_roles.SetTransObject( SQLCA )

dw_views.Reset()
dw_views.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
DELETE FROM security_user_department
WHERE security_user_department.user_id = :is_user_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

DELETE FROM security_user_facilities  
WHERE security_user_facilities.user_id = :is_user_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

DELETE FROM security_user_roles
WHERE security_user_roles.user_id = :is_user_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

DELETE FROM security_user_views
WHERE security_user_views.user_id = :is_user_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

DELETE FROM security_users
WHERE security_users.user_id = :is_user_id   ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

COMMIT USING SQLCA;
*/
gnv_appeondb.of_startqueue( )

DELETE FROM security_user_department
WHERE security_user_department.user_id = :is_user_id   ;

DELETE FROM security_user_facilities  
WHERE security_user_facilities.user_id = :is_user_id   ;

DELETE FROM security_user_roles
WHERE security_user_roles.user_id = :is_user_id   ;

DELETE FROM security_user_views
WHERE security_user_views.user_id = :is_user_id   ;

DELETE FROM security_users
WHERE security_users.user_id = :is_user_id   ;

gnv_appeondb.of_commitqueue( )

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

//---------------------------- APPEON END ----------------------------

dw_select_user.GetChild( "user_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dw_select_user.Reset()
dw_select_User.InsertRow( 0 )

if upper(is_user_id) <> "DBA" then //Start Code Change ---- 05.17.2007 #V7 maha added trap for DBA
	ls_sql = "revoke connect from " + is_user_id  + ";"
end if

//commit using sqlca;


RETURN 1



end function

public function integer of_set_parent_window (w_security_user_painter aw_win);iw_win = aw_win



IF ii_dept_secure_setting = 1 THEN
	iw_win.Width = 3232
END IF
IF gb_contract_version THEN
	iw_win.height = 900
END IF

Return 1
end function

public function integer of_copy_user ();//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-24 By: Wu ZhiJun
//$<reason> Fix a bug
Integer	li_Rtn
long		ll_Cycle,ll_Count,ll_Row,ll_FindRow
long		ll_MaxFac,ll_MaxView

DataWindowChild dwchild

li_Rtn = iw_win.Event pfc_save()
if li_Rtn < 0 then Return -1

//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
//Open(w_get_user_id_v5 )
If gb_contract_version Then
	Open( w_get_user_id_v5_ctx )
Else
	Open( w_get_user_id_v5 )
End If
//---------End Modfiied ------------------------------------------------------

if Message.StringParm = "Cancel" then
	Return 0
else
	is_user_id = Message.StringParm
end if

if LenA(is_user_id) < 1 then return -1

ll_Row = dw_roles.GetRow()
dw_roles.SetItem(ll_Row,'user_id',is_user_id)
dw_roles.SetItem(ll_Row,'email_id',"")
dw_roles.SetItemStatus(ll_Row,0,Primary!,NewModified!)

ll_Count = dw_facility.RowCount()
ll_MaxFac = gnv_app.of_get_id("user_facility_id" ,ll_Count) - 1
for ll_Cycle = 1 to ll_Count
	dw_facility.SetItem(ll_Cycle, "user_facility_id", ll_MaxFac + ll_Cycle)
	dw_facility.SetItem(ll_Cycle, "user_id", is_user_id )
	dw_facility.SetItemStatus(ll_Cycle,0,Primary!,NewModified!)
END FOR

ll_Count = dw_views.RowCount()
ll_MaxView = gnv_app.of_get_id("user_view_id" ,ll_Count) - 1
for ll_Cycle = 1 to ll_Count
	dw_views.SetItem(ll_Cycle, "user_view_id", ll_MaxView + ll_Cycle )
	dw_views.SetItem(ll_Cycle, "user_id", is_user_id )
	dw_views.SetItemStatus(ll_Cycle,0,Primary!,NewModified!)
END FOR

if dw_roles.Update() < 1 then
	MessageBox('Copy the role failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

dw_select_user.GetChild("user_id", dwchild)
dwchild.SetTransObject(SQLCA)
ll_Count = dwchild.Retrieve()
ll_FindRow = dwchild.Find("user_id='" + is_user_id + "'",1,ll_Count)
if ll_FindRow > 0 then
	dwchild.SetItem(ll_FindRow, "user_password", "123")
	dwchild.SetItem(ll_FindRow, "image_flag", "0" )
	dwchild.SetItem(ll_FindRow, "contract_default_view", 1001 )
end if

if dwchild.Update() < 1 then
	MessageBox('Copy the role failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

if dw_facility.Update() < 1 then
	MessageBox('Copy role failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

if dw_views.Update() < 1 then
	MessageBox('Copy the role failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

COMMIT USING SQLCA;

dw_roles.Retrieve(is_user_id)
dw_facility.Retrieve(is_user_id)
dw_views.Retrieve(is_user_id)

dw_select_user.SetItem(1, "user_id", is_user_id )

return 1
//--------------------------- APPEON END -----------------------------
end function

on pfc_cst_u_user_import_wv.create
this.st_2=create st_2
this.dw_2=create dw_2
this.cb_x2=create cb_x2
this.cb_x1=create cb_x1
this.rb_f=create rb_f
this.rb_np=create rb_np
this.rb_fl=create rb_fl
this.cb_imp_run=create cb_imp_run
this.rb_ext=create rb_ext
this.rb_imp=create rb_imp
this.cb_browse=create cb_browse
this.sle_file=create sle_file
this.cb_import=create cb_import
this.dw_1=create dw_1
this.cb_1=create cb_1
this.dw_departments=create dw_departments
this.cb_sad=create cb_sad
this.st_view=create st_view
this.dw_department=create dw_department
this.cb_sav=create cb_sav
this.cb_saf=create cb_saf
this.dw_facility=create dw_facility
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.dw_select_user=create dw_select_user
this.cb_new=create cb_new
this.dw_views=create dw_views
this.dw_roles=create dw_roles
this.st_1=create st_1
this.st_department=create st_department
this.cb_close=create cb_close
this.cb_print=create cb_print
this.gb_select=create gb_select
this.gb_main=create gb_main
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.st_2,&
this.dw_2,&
this.cb_x2,&
this.cb_x1,&
this.rb_f,&
this.rb_np,&
this.rb_fl,&
this.cb_imp_run,&
this.rb_ext,&
this.rb_imp,&
this.cb_browse,&
this.sle_file,&
this.cb_import,&
this.dw_1,&
this.cb_1,&
this.dw_departments,&
this.cb_sad,&
this.st_view,&
this.dw_department,&
this.cb_sav,&
this.cb_saf,&
this.dw_facility,&
this.cb_save,&
this.cb_delete,&
this.dw_select_user,&
this.cb_new,&
this.dw_views,&
this.dw_roles,&
this.st_1,&
this.st_department,&
this.cb_close,&
this.cb_print,&
this.gb_select,&
this.gb_main,&
this.gb_1,&
this.gb_2}
end on

on pfc_cst_u_user_import_wv.destroy
destroy(this.st_2)
destroy(this.dw_2)
destroy(this.cb_x2)
destroy(this.cb_x1)
destroy(this.rb_f)
destroy(this.rb_np)
destroy(this.rb_fl)
destroy(this.cb_imp_run)
destroy(this.rb_ext)
destroy(this.rb_imp)
destroy(this.cb_browse)
destroy(this.sle_file)
destroy(this.cb_import)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.dw_departments)
destroy(this.cb_sad)
destroy(this.st_view)
destroy(this.dw_department)
destroy(this.cb_sav)
destroy(this.cb_saf)
destroy(this.dw_facility)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.dw_select_user)
destroy(this.cb_new)
destroy(this.dw_views)
destroy(this.dw_roles)
destroy(this.st_1)
destroy(this.st_department)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.gb_select)
destroy(this.gb_main)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;//Setup to use security on departments //users can only see physician data if they have access to the department the physician belongs
//SELECT set_37
//INTO: ii_dept_secure_setting
//FROM icred_settings;
ii_dept_secure_setting = gi_dept_security


IF ii_dept_secure_setting = 1 THEN
	dw_department.Visible = True
	dw_views.x = 2103
	gb_main.Width = 3127
	gb_select.Width = 3127
	st_view.x = 2103
	cb_sav.x = 2400
	dw_department.of_SetUpdateAble( True )
ELSE 
	dw_department.Visible = False
	cb_sad.Visible = False
	st_department.Visible = False
	dw_department.Visible = False
	dw_department.of_SetUpdateAble( False )
	gb_main.Width = 2098
	gb_select.Width = 1659
	dw_views.x = 1083
	st_view.x = 1083
	cb_sav.x = 1381
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-16 By: Rodger Wu (Contract)
//$<reason> Modification for contract module.
String ls_set_cont

ls_set_cont = gnv_data.of_GetItem( "icred_settings", "set_cont", False )
IF IsNull( ls_set_cont ) THEN ls_set_cont = '0'

IF ls_set_cont = '0' THEN
	dw_roles.Modify( "contract_default_view.visible=0 t_7.visible=0" )
END IF

//22/09/2006 Allen begin
IF gb_contract_version THEN
	dw_roles.Modify("t_2.Visible = 0")
	dw_roles.Modify("default_view.Visible = 0")
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	dw_roles.Modify("t_1.Visible = 0")
	dw_roles.Modify("default_search_facility.Visible = 0")
	st_1.visible = False
	st_view.visible = False
	dw_facility.visible = False
	dw_views.visible = False
	cb_saf.visible = False
	cb_sav.visible = False
	//---------------------------- APPEON END ----------------------------
	
	dw_roles.Modify("t_7.Y = " + dw_roles.Describe("t_2.Y"))
	dw_roles.Modify("contract_default_view.Y = " + dw_roles.Describe("default_view.Y"))
	dw_roles.Modify("image_flag.y =" + dw_roles.Describe("default_view.Y"))
	
	cb_save.y = 660
	cb_close.y = 660
	gb_main.height = 400
	dw_roles.height = 330

ELSE
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	dw_roles.Modify("t_1.Visible = 1")
	dw_roles.Modify("default_search_facility.Visible = 1")
	st_1.visible = True
	st_view.visible = True
	dw_facility.visible = True
	dw_views.visible = True
	cb_saf.visible = True
	cb_sav.visible = True
	//---------------------------- APPEON END ----------------------------
	dw_roles.Modify("t_7.Visible = 0")
	dw_roles.Modify("contract_default_view.Visible = 0")	
END IF

IF appeongetclienttype() = 'PB' THEN
	st_1.Y = st_1.Y - 150
	st_department.Y = st_department.Y - 150
	st_view.Y = st_view.Y - 150
	
	dw_facility.Y = dw_facility.Y - 150
	dw_department.Y = dw_department.Y - 150
	dw_views.Y = dw_views.Y - 150
	
	dw_facility.Height = dw_facility.Height + 150
	dw_department.Height = dw_department.Height + 150
	dw_views.Height = dw_views.Height + 150

	dw_roles.Modify("image_flag.Visible = 0")
END IF
//22/09/2006 Allen end
//---------------------------- APPEON END ----------------------------

//--------------Begin Added by Alfee 06.11.2007-----------------------
//<$Reason>Fix the duplicated facility records' problem
ids_facility = Create DataStore
ids_facility.DataObject = 'd_security_facility'
ids_facility.SetTransObject(SQLCA)
ids_facility.Retrieve()
//---------------End Added --------------------------------------------

end event

event destructor;Destroy ids_facility //Aded by Alfee 06.11.2007
end event

type st_2 from statictext within pfc_cst_u_user_import_wv
integer x = 1015
integer y = 228
integer width = 306
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Import File:"
boolean focusrectangle = false
end type

type dw_2 from datawindow within pfc_cst_u_user_import_wv
integer x = 2976
integer y = 372
integer width = 553
integer height = 80
integer taborder = 50
boolean enabled = false
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_x2 from commandbutton within pfc_cst_u_user_import_wv
integer x = 2414
integer y = 380
integer width = 91
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Ex"
end type

type cb_x1 from commandbutton within pfc_cst_u_user_import_wv
integer x = 1755
integer y = 376
integer width = 91
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Ex"
end type

type rb_f from radiobutton within pfc_cst_u_user_import_wv
integer x = 2597
integer y = 384
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "From Field:"
end type

type rb_np from radiobutton within pfc_cst_u_user_import_wv
integer x = 1906
integer y = 384
integer width = 594
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "Intl and Prac Id"
end type

type rb_fl from radiobutton within pfc_cst_u_user_import_wv
integer x = 1093
integer y = 380
integer width = 631
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
boolean enabled = false
string text = "First Intl + Last name"
end type

type cb_imp_run from commandbutton within pfc_cst_u_user_import_wv
integer x = 2853
integer y = 52
integer width = 379
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Create Users"
end type

type rb_ext from radiobutton within pfc_cst_u_user_import_wv
integer x = 1486
integer y = 76
integer width = 430
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Existing Data"
end type

type rb_imp from radiobutton within pfc_cst_u_user_import_wv
integer x = 1070
integer y = 76
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Import File"
end type

type cb_browse from commandbutton within pfc_cst_u_user_import_wv
integer x = 2711
integer y = 212
integer width = 402
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Browse"
end type

type sle_file from singlelineedit within pfc_cst_u_user_import_wv
integer x = 1326
integer y = 216
integer width = 1367
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean enabled = false
borderstyle borderstyle = stylelowered!
end type

type cb_import from commandbutton within pfc_cst_u_user_import_wv
integer x = 3131
integer y = 212
integer width = 402
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Import"
end type

type dw_1 from u_dw within pfc_cst_u_user_import_wv
integer x = 14
integer y = 32
integer width = 974
integer height = 2112
integer taborder = 80
boolean titlebar = true
string title = "Imported Users"
boolean controlmenu = true
end type

type cb_1 from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 1262
integer y = 64
integer width = 338
integer height = 84
integer taborder = 20
fontcharset fontcharset = ansi!
string text = "C&opy User"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 2007-05-24 By: Wu ZhiJun
//$<reason> Fixed a bug
if of_copy_user() = 1 then
	if Not cb_delete.Enabled then
		cb_delete.Enabled = true
	end if
end if
//--------------------------- APPEON END -----------------------------

end event

type dw_departments from datawindow within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2382
integer y = 44
integer width = 274
integer height = 136
integer taborder = 30
string dataobject = "d_all_departments"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_sad from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2295
integer y = 2024
integer width = 338
integer height = 84
integer taborder = 140
string text = "Select All"
end type

event clicked;call super::clicked;Integer i
Integer li_rc
Integer li_select_val

IF cb_sad.Text = "Select All" THEN
	cb_sad.text = "Unselect All"
	li_select_val = 1
ELSE
	cb_sad.Text = "Select All" 
	li_select_val = 0	
END IF

li_rc = dw_department.RowCount()

FOR i = 1 TO li_rc
	dw_department.SetItem( i, "access_rights", li_select_val )
END FOR
end event

type st_view from statictext within pfc_cst_u_user_import_wv
integer x = 2117
integer y = 1128
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "View Access"
boolean focusrectangle = false
end type

type dw_department from u_dw within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2094
integer y = 2016
integer width = 151
integer height = 112
integer taborder = 100
string dataobject = "d_security_user_department_access"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type cb_sav from u_cb within pfc_cst_u_user_import_wv
integer x = 2450
integer y = 2004
integer width = 302
integer height = 84
integer taborder = 150
string text = "Select All"
end type

event clicked;Integer i
Integer li_rc
Integer li_select_val

IF cb_sav.Text = "Select All" THEN
	cb_sav.text = "Unselect All"
	li_select_val = 1
ELSE
	cb_sav.Text = "Select All" 
	li_select_val = 0	
END IF

li_rc = dw_views.RowCount()

FOR i = 1 TO li_rc
	dw_views.SetItem( i, "access_rights", li_select_val )
END FOR
end event

type cb_saf from u_cb within pfc_cst_u_user_import_wv
integer x = 1399
integer y = 2004
integer width = 302
integer height = 84
integer taborder = 130
string text = "Select All"
end type

event clicked;Integer i
Integer li_rc
Integer li_select_val

IF cb_saf.Text = "Select All" THEN
	cb_saf.text = "Unselect All"
	li_select_val = 1
ELSE
	cb_saf.Text = "Select All" 
	li_select_val = 0	
END IF

li_rc = dw_facility.RowCount()

FOR i = 1 TO li_rc
	dw_facility.SetItem( i, "access_rights", li_select_val )
END FOR
end event

type dw_facility from u_dw within pfc_cst_u_user_import_wv
integer x = 1070
integer y = 1192
integer width = 983
integer height = 800
integer taborder = 90
string dataobject = "d_security_user_facility_access"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type cb_save from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 3159
integer y = 1932
integer width = 338
integer height = 84
integer taborder = 160
string text = "&Save"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.16.2006 By: LeiWei
//$<reason> Fix a defect.

If dw_roles.Rowcount( ) > 0 Then
	dw_roles.Accepttext( )
	
	String ls_image_flag
	ls_image_flag = dw_roles.Getitemstring( 1, "image_flag")
	IF Isnull(ls_image_flag) THEN
		dw_roles.Setitem( 1, "image_flag", "0")
	End If
End If

//---------------------------- APPEON END ----------------------------

Integer li_retval


li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 04.21.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Refresh the security_users data after updating.
gnv_data.of_retrieve( "security_users")
//---------------------------- APPEON END ----------------------------

end event

type cb_delete from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2309
integer y = 20
integer width = 338
integer height = 84
integer taborder = 40
string text = "&Delete User"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
String	ls_UserId

ls_UserId = dw_select_user.GetItemString(dw_select_user.GetRow(),'user_id')

if IsNull(ls_UserId) or Trim(ls_UserId) = "" then
	MessageBox('Warning','Please select a user first!',Exclamation!)
	return
end if
//---------------------------- APPEON END ----------------------------

of_delete()
end event

type dw_select_user from u_dw within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2331
integer y = 52
integer width = 475
integer height = 92
integer taborder = 10
string dataobject = "d_select_user_for_audit_trail"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )




end event

event itemchanged;call super::itemchanged;Is_user_id = data

cb_delete.enabled = lower(data)<>'master'

datawindowchild dwchild
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.


/*
dw_facility.Retrieve( Is_user_id )

dw_views.Retrieve( is_user_id )
dw_roles.Retrieve( is_user_id )
dw_department.Retrieve( is_user_id )
dw_roles.GetChild( "default_search_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
dwchild.setitem(1,"facility_name","All")
dw_roles.GetChild( "default_view", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
*/
dw_roles.GetChild( "default_search_facility", dwchild )
dwchild.settransobject(sqlca)

gnv_appeondb.of_startqueue( )

dw_facility.Retrieve( Is_user_id )

dw_views.Retrieve( is_user_id )
dw_roles.Retrieve( is_user_id )
dw_department.Retrieve( is_user_id )
dwchild.retrieve()

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

dwchild.insertrow(1)
dwchild.setitem(1,"facility_name","All")
dw_roles.GetChild( "default_view", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()

dwchild.insertrow(1)
dwchild.setitem(1,"data_view_name","None")

dw_facility.AcceptText()
dw_views.AcceptText()
dw_roles.AcceptText()
end event

type cb_new from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 3168
integer y = 1928
integer width = 338
integer height = 84
integer taborder = 50
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Create User"
end type

event clicked;of_create_user()
Parent.SetRedraw(true)

end event

type dw_views from u_dw within pfc_cst_u_user_import_wv
integer x = 2103
integer y = 1192
integer width = 983
integer height = 800
integer taborder = 80
string dataobject = "d_security_user_views_access"
end type

event constructor;This.of_SetTransObject( SQLCA )

end event

type dw_roles from u_dw within pfc_cst_u_user_import_wv
integer x = 1051
integer y = 552
integer width = 2053
integer height = 488
integer taborder = 70
string dataobject = "d_wv_user_security_setting"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_rec_id

IF This.GetItemStatus( 1, 0, Primary! ) = NewModified! THEN
	dw_roles.SetItem( 1, "user_id", is_user_id )
END IF

RETURN 1
end event

type st_1 from statictext within pfc_cst_u_user_import_wv
integer x = 1079
integer y = 1128
integer width = 407
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Facility Access"
boolean focusrectangle = false
end type

type st_department from statictext within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 2149
integer y = 776
integer width = 521
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Department Access"
boolean focusrectangle = false
end type

type cb_close from u_cb within pfc_cst_u_user_import_wv
integer x = 3241
integer y = 52
integer width = 338
integer height = 84
integer taborder = 120
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( iw_win )
end event

type cb_print from u_cb within pfc_cst_u_user_import_wv
boolean visible = false
integer x = 1019
integer y = 1744
integer width = 338
integer height = 84
integer taborder = 110
string text = "&Print"
end type

type gb_select from groupbox within pfc_cst_u_user_import_wv
integer x = 1024
integer y = 1068
integer width = 2533
integer height = 1072
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Access Settings"
end type

type gb_main from groupbox within pfc_cst_u_user_import_wv
integer x = 1024
integer y = 496
integer width = 2528
integer height = 564
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Security Settings"
end type

type gb_1 from groupbox within pfc_cst_u_user_import_wv
integer x = 1019
integer y = 324
integer width = 2528
integer height = 152
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "User Name Type"
end type

type gb_2 from groupbox within pfc_cst_u_user_import_wv
integer x = 1015
integer y = 16
integer width = 960
integer height = 164
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Batch Type"
end type

