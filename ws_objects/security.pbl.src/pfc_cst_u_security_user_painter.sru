$PBExportHeader$pfc_cst_u_security_user_painter.sru
forward
global type pfc_cst_u_security_user_painter from userobject
end type
type cb_cvo from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_ad from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_h2 from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_batch_provd from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_2 from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_reset from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_setup_ctx from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_h1 from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_image_security from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_security from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_ldap from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_email from commandbutton within pfc_cst_u_security_user_painter
end type
type cb_copy from u_cb within pfc_cst_u_security_user_painter
end type
type dw_departments from datawindow within pfc_cst_u_security_user_painter
end type
type cb_sad from u_cb within pfc_cst_u_security_user_painter
end type
type st_view from statictext within pfc_cst_u_security_user_painter
end type
type dw_department from u_dw within pfc_cst_u_security_user_painter
end type
type cb_sav from u_cb within pfc_cst_u_security_user_painter
end type
type cb_saf from u_cb within pfc_cst_u_security_user_painter
end type
type dw_facility from u_dw within pfc_cst_u_security_user_painter
end type
type cb_save from u_cb within pfc_cst_u_security_user_painter
end type
type cb_delete from u_cb within pfc_cst_u_security_user_painter
end type
type dw_select_user from u_dw within pfc_cst_u_security_user_painter
end type
type cb_new from u_cb within pfc_cst_u_security_user_painter
end type
type dw_views from u_dw within pfc_cst_u_security_user_painter
end type
type st_1 from statictext within pfc_cst_u_security_user_painter
end type
type st_department from statictext within pfc_cst_u_security_user_painter
end type
type cb_close from u_cb within pfc_cst_u_security_user_painter
end type
type cb_print from u_cb within pfc_cst_u_security_user_painter
end type
type gb_select from groupbox within pfc_cst_u_security_user_painter
end type
type gb_main from groupbox within pfc_cst_u_security_user_painter
end type
type dw_audit from datawindow within pfc_cst_u_security_user_painter
end type
type dw_roles from u_dw within pfc_cst_u_security_user_painter
end type
type gb_sec from groupbox within pfc_cst_u_security_user_painter
end type
type cb_4 from commandbutton within pfc_cst_u_security_user_painter
end type
end forward

global type pfc_cst_u_security_user_painter from userobject
integer width = 4169
integer height = 2616
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_cvo cb_cvo
cb_ad cb_ad
cb_h2 cb_h2
cb_batch_provd cb_batch_provd
cb_2 cb_2
cb_reset cb_reset
cb_setup_ctx cb_setup_ctx
cb_h1 cb_h1
cb_image_security cb_image_security
cb_security cb_security
cb_ldap cb_ldap
cb_email cb_email
cb_copy cb_copy
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
st_1 st_1
st_department st_department
cb_close cb_close
cb_print cb_print
gb_select gb_select
gb_main gb_main
dw_audit dw_audit
dw_roles dw_roles
gb_sec gb_sec
cb_4 cb_4
end type
global pfc_cst_u_security_user_painter pfc_cst_u_security_user_painter

type variables
String is_user_id
w_security_user_painter iw_win
Integer ii_dept_secure_setting
long il_audit_id //maha 06.08.2010

DataStore ids_facility //added by Alfee 06.11.2007

integer ii_readonly
end variables

forward prototypes
public function integer of_create_user ()
public function integer of_delete ()
public function integer of_set_parent_window (w_security_user_painter aw_win)
public function integer of_copy_user ()
public function integer of_set_security ()
public function integer of_add_audit (string as_user, string as_from, integer as_row)
public function integer of_readonly_hide ()
public subroutine of_refresh_selectbutton ()
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

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-17 By: Scofield
//$<Reason> Save the data before create user.

//li_retval = iw_win.Event pfc_save()
//IF li_retval < 0 THEN
//	Return 1
//END IF

cb_save.TriggerEvent(Clicked!)
//---------------------------- APPEON END ----------------------------

Open( w_get_user_id_v5 )  //maha 083105 changed window name
IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	is_user_id = Message.StringParm
END IF

debugbreak()

dw_roles.enabled = true  //Start Code Change ----04.28.2008 #V8 maha
if LenA(is_user_id) < 1 then return -1 //maha 082203 

dw_facility.Reset()
dw_facility.SetTransObject( SQLCA )

dw_roles.Reset()
dw_roles.SetTransObject( SQLCA )

dw_views.Reset()
dw_views.SetTransObject( SQLCA )

Long li_rc_facility
//---------Begin Modified by Alfee 06.11.2007------------------------
li_rc_facility = ids_facility.Rowcount()
//li_rc_facility = gnv_data.ids_facility.Rowcount()


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


li_rec_id = gnv_app.of_get_id( "user_facility_id" ,li_rc_facility) - 1
li_rc = li_rc_facility


FOR i = 1 TO li_rc

	li_rec_id ++
	dw_facility.InsertRow( 0 )
	dw_facility.SetItem( i, "user_facility_id", li_rec_id )
	dw_facility.SetItem( i, "user_id", is_user_id )
	//---------Begin Modified by Alfee 06.11.2007------------------------
	dw_facility.SetItem( i, "facility_id", ids_facility.GetItemNumber( i, "facility_id" ) )
	//dw_facility.SetItem( i, "facility_id", gnv_data.ids_facility.GetItemNumber( i, "facility_id" ) )
	//---------End Modified ----------------------------------------------
	//---------------------------- APPEON END ----------------------------
	if gb_sk_ver then
		dw_facility.SetItem( i, "access_rights", 1 ) //Start Code Change ----07.07.2010 #V10 maha - for SK rights to all
	else
		dw_facility.SetItem( i, "access_rights", 0 )
	end if
	//dw_facility.SetItem( i, "active_status", 0 ) //Start Code Change ----11.10.2009 #V10 maha //Start Code Change ----12.04.2009 #V10 maha removed
END FOR

li_rc = lds_views.Rowcount()
li_rec_id = gnv_app.of_get_id( "user_view_id" ,li_rc) - 1
FOR i = 1 TO li_rc
	li_rec_id ++
//---------------------------- APPEON END ----------------------------
	dw_views.InsertRow( 0 )
	dw_views.SetItem( i, "user_view_id", li_rec_id )
	dw_views.SetItem( i, "user_id", is_user_id )
	if gb_sk_ver then
		dw_views.SetItem( i, "access_rights", 1 ) //Start Code Change ----07.07.2010 #V10 maha - for SK rights to all
	else
		dw_views.SetItem( i, "access_rights", 0 )	
	end if
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

//Start Code Change ----04.06.2009 #V92 maha - ameripath mod //-12.07.2009 #V92 maha - corrected so values actually populate
dwchild.SetItem( li_nr, "read_only", 0 )
dwchild.SetItem( li_nr, "active_status", 1 )
//End Code Change---04.06.2009

//Start Code Change ----07.07.2010 #V102 maha - SK auto settings
if gb_sk_ver then
	dwchild.SetItem( li_nr, "set_go_on_open", 1 )
	dwchild.SetItem( li_nr, "open_tdl", 0 )
	dwchild.SetItem( li_nr, "set_dashboard", 1 )
	dwchild.SetItem( li_nr, "role_id", 2 )
end if
//End Code Change---07.07.2010

//add department data for security_user_department
IF dw_department.Visible THEN
		
	Integer li_dept_cnt
	Integer li_user_cnt
	Integer d
	Integer u
	Long ll_department

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
//---------Begin Added by (Appeon)Toney 09.04.2013 for V141 ISG-CLX--------
//$Reason:Fix reintegration BugT081302
DataStore  lds_getting
n_cst_getting_started  ln_getting
IF ln_getting.of_initgettingstart(is_user_id,lds_getting) <> 1 THEN
	Destroy lds_getting
	Messagebox('Getting Started','Failed to initialize data, please call support.')
	RETURN -1
END IF
//---------End Added ------------------------------------------------------------------

int li_updateflag = 1

li_updateflag = gnv_appeondb.of_update( dwchild, dw_facility, dw_roles)
if li_updateflag < 0 then
	messagebox("Update failure"," Failure to update user record.")
	ROLLBACK USING SQLCA;
	RETURN -1
end if

li_updateflag = gnv_appeondb.of_update( dw_views, dw_department,lds_getting)//(Appeon)Toney 09.04.2013 - V141 ISG-CLX Fix reintegration BugT081302 Add lds_getting
if li_updateflag < 0 then
	messagebox("Update failure"," Failure to update  view or department or getting started records.")//(Appeon)Toney 09.04.2013 - V141 ISG-CLX Fix reintegration BugT081302 Add lds_getting
	ROLLBACK USING SQLCA;
	Destroy lds_getting//(Appeon)Toney 09.04.2013 - V141 ISG-CLX Fix reintegration BugT081302
	RETURN -1
else
	dw_facility.ResetUpdate()
	dw_roles.ResetUpdate()
	dw_views.ResetUpdate()
	dwchild.ResetUpdate()
	dw_department.ResetUpdate()	
	gnv_appeondb.of_startqueue( )
	COMMIT USING SQLCA;
	Destroy lds_getting//(Appeon)Toney 09.04.2013 - V141 ISG-CLX Fix reintegration BugT081302
end if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
select max(rec_id) into :il_audit_id from sys_audit_user; //Start Code Change ----07.07.2010 #V10 maha
of_add_audit( is_user_id, "I",0)
dw_audit.update()
//End Code Change---06.25.2009


dw_facility.Retrieve( is_user_id )
dw_views.Retrieve( is_user_id )
dw_roles.Retrieve( is_user_id )

IF dw_department.Visible THEN
	dw_department.Retrieve( is_user_id )
END IF
gnv_appeondb.of_commitqueue( )

dw_select_user.SetItem( 1, "user_id", is_user_id )
//---------------------------- APPEON END ----------------------------
//Start Code Change ----07.07.2010 #V102 maha - SK auto settings
if gb_sk_ver then
	dw_roles.SetItem( 1, "set_go_on_open", 1 )
	dw_roles.SetItem( 1, "set_tdl", 0 )
 	dw_roles.SetItem( 1, "set_dashboard", 1 )
	dw_roles.SetItem( 1, "role_id", 2 )
	dw_roles.update()
end if
//End Code Change---07.07.2010

//---------Begin Added by (Appeon)Harry 07.08.2016 for Docusign--------
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'sertifi');
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'echosign');
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'docusign');
//---------End Added ------------------------------------------------------

of_readonly_hide( ) //Start Code Change ----08.05.2010 #V102 maha -

RETURN 1
end function

public function integer of_delete ();DataWindowChild dwchild

Integer li_ans
//comment 08/01/2007 by: Andy
//Long ll_cnt 
String ls_sql
//<add> 08/01/2007 by: Andy
String ls_first_name,ls_last_name
//end of add

if upper( is_user_id) = "MASTER" then  //Start Code Change ----05.20.2008 #V8 maha - added trap for master user
	 MessageBox("Delete", "User MASTER cannot be deleted as it is used for support purposes." )
	 RETURN -1
end if

li_ans = MessageBox("Delete", "Are you sure you want to delete this User " + Upper( is_user_id ) + "?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	RETURN -1
END IF

/*comment 08/01/2007 by: Andy
//Reason:Instead these codes with the below code.
//---------Begin Added by Alfee 06.12.2007-----------------------------------
Select count(*) Into :ll_cnt From ctx_contacts Where user_d = :is_user_id ;
If ll_cnt > 0 Then
	MessageBox("Delete","This user id has been used a contact in contracts, and can't be deleted!")
	Return -1
End If
//----------End Added --------------------------------------------------------
*/

//add 08/01/2007 by: Andy
Select TOP 1 ISNULL(first_name,''),ISNULL(last_name,'') Into :ls_first_name,:ls_last_name From ctx_contacts Where user_d = :is_user_id ;
If SQLCA.sqlcode = 0 Then
	MessageBox("Delete","This user id is linked to " + ls_first_name + " " + ls_last_name +  "'s Contact record and can't be deleted.")
	Return -1
End If
//end of add

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

DELETE FROM em_smtp_accounts
WHERE em_smtp_accounts.user_id = :is_user_id; //Add by Evan 09/17/2008

Delete From conv_view_rights Where user_id = :is_user_id ;  //Start Code Change ----06.29.2011 #V11 maha - ireport security

Delete from security_user_images where user_id = :is_user_id; //Start Code Change ----12.04.2012 #V12 maha - image security

Delete from security_user_ireport where user_id = :is_user_id; //Start Code Change ----07.14.2016 #V152 maha - image security

//---------Begin Added by (Appeon)Harry 08.30.2013-------
//Reason:BugT081303
DELETE FROM security_group_users
WHERE security_group_users.user_id = :is_user_id;   //Added By Ken.Guo 2009-05-12
//---------End Added ------------------------------------------------------
//---------Begin Added by (Appeon)Toney 09.04.2013 for V141 ISG-CLX--------
//$Reason:Fix reintegration BugT081302
DELETE FROM dashboard_gadgets_getting_started  
Where user_id = :is_user_id;
//---------End Added ------------------------------------------------------------------

// (Appeon)Harry 07.08.2016 - for docusign
DELETE FROM personal_license_setting
WHERE user_id = :is_user_id   ;


//Delete From security_user_images Where user_id = :is_user_id ;  //Start Code Change ----09.29.2011 #V12 maha - image security

//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
select max(rec_id) into :il_audit_id from sys_audit_user; //Start Code Change ----07.07.2010 #V10 maha
of_add_audit( is_user_id, "I",0)
dw_audit.update()
//End Code Change---06.25.2009

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

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.16.2017
//<$>reason:Comment, for BugS011701.
////IF ii_dept_secure_setting = 1 THEN	
//IF ii_dept_secure_setting = 1 and not gb_contract_version  THEN //08.10.2007 By Jervis
//	//iw_win.Width = 3232 // Delete by Evan 01.31.2008
//	iw_win.Width = 3260 // Add by Evan 01.31.2008
//END IF
//------------------- APPEON END -------------------

IF gb_contract_version THEN
	//iw_win.height =  996  //Start Code Change ----11.29.2008 #V8 maha changed from 900
	//iw_win.height = 830 // Add by Evan 01.31.2008
	iw_win.height = 1000 // Add by Ken 08.26.2008
END IF
//Start Code Change ----07.06.2010 #V10 maha
IF gb_sk_ver THEN
	dw_roles.dataobject = "d_security_user_roles_access_sk"
	dw_roles.settransobject(sqlca)
	dw_roles.height = 500
	this.height = 884
	iw_win.height = 1000 // Add by Ken 08.26.2008
	cb_ldap.visible = false
	gb_sec.height = 625  //Start Code Change ----11.04.2010 #V10 maha
	IF appeongetclienttype() = 'PB' THEN  //Start Code Change ----08.01.2011 #V11 maha - for sk version
		dw_roles.Modify("image_flag.Visible = 0") 
	end if
//End Code Change ----07.06.2010
elseif gs_cust_type = 'I' then
	dw_roles.object.npdb_user_id.visible = false
	dw_roles.object.t_npdb_uid.visible = false
	dw_roles.object.npdb_password.visible = false
	dw_roles.object.t_npdb_pw.visible = false
	//dw_roles.object.gb_npdb.text = 'Additional'  //Start Code Change ----02.04.2011 #V11 maha - removed
else //cred
	//dw_roles.object.t_tab.text = "Photo on Search Tab only"  //Start Code Change ----08.10.2016 #V152 maha - removed
	//dw_roles.object.prac_window_type.visible = false
	//dw_roles.object.t_tab.visible = false
END IF
//End Code Change ----07.06.2010


if of_get_app_setting("set_60","I") = 0 or w_mdi.of_security_access(7195) = 0 then cb_security.visible = false  //Start Code Change ----08.17.2011 #V11 maha - if not using ireport security, hide button
if of_get_app_setting("set_69","I") = 0 or w_mdi.of_security_access(7195) = 0 then cb_image_security.visible = false  //Start Code Change ----12.04.2012 #V12 maha - if not using ireport security, hide button
if w_mdi.of_security_access( 1345 ) = 0   then cb_reset.Visible = False //Start Code Change ----06.25.2013 #V14 maha

if w_mdi.of_security_access( 7765 ) = 0   then cb_reset.Visible = False //Added by Appeon long.zhang 11.18.2014 (Testing Bug # 4298 / From User Administration the Reset User Settings button is active when No Access)
	
Return 1
end function

public function integer of_copy_user ();//--------------------------- APPEON BEGIN ---------------------------
//$<modified> 2007-05-24 By: Wu ZhiJun
//$<reason> Fix a bug
Integer	li_Rtn
long		ll_Cycle,ll_Count,ll_Row,ll_FindRow
long		ll_MaxFac,ll_MaxView,ll_MaxDep
String	ls_UserId
DateTime ldt_null
SetNull(ldt_null)  //(Appeon)Harry 03.30.2016 - for Bug # 5074

DataWindowChild dwchild

//li_Rtn = iw_win.Event pfc_save()
//if li_Rtn < 0 then Return -1

ll_Row = dw_Select_User.GetRow()
ls_UserId = dw_Select_User.GetItemString(ll_Row,'user_id')
if IsNull(ls_UserId) or Trim(ls_UserId) = '' then
	MessageBox(gnv_app.iapp_object.DisplayName,'Please select a user first!')
	Return -1
end if

cb_save.TriggerEvent(Clicked!)

Open(w_get_user_id_v5 )

if Message.StringParm = "Cancel" then
	Return 0
else
	is_user_id = Message.StringParm
end if

if LenA(is_user_id) < 1 then return -1

ll_Row = dw_roles.GetRow()
dw_roles.SetItem(ll_Row,'user_id',is_user_id)
dw_roles.SetItem(ll_Row,'email_id',"")
dw_roles.SetItem(ll_Row,'last_login_date',ldt_null)  //(Appeon)Harry 03.30.2016 - for Bug # 5074
dw_roles.SetItemStatus(ll_Row,0,Primary!,NewModified!)

ll_Count = dw_facility.RowCount()
ll_MaxFac = gnv_app.of_get_id("user_facility_id" ,ll_Count) - 1
for ll_Cycle = 1 to ll_Count
	dw_facility.SetItem(ll_Cycle, "user_facility_id", ll_MaxFac + ll_Cycle)
	dw_facility.SetItem(ll_Cycle, "user_id", is_user_id )
	dw_facility.SetItemStatus(ll_Cycle,0,Primary!,NewModified!)
next

ll_Count = dw_department.RowCount()
Select Max(user_depart_id)
  into :ll_MaxDep
  from security_user_department ;
for ll_Cycle = 1 to ll_Count
	dw_department.SetItem(ll_Cycle, "user_depart_id", ll_MaxDep + ll_Cycle)
	dw_department.SetItem(ll_Cycle, "user_id", is_user_id )
	dw_department.SetItemStatus(ll_Cycle,0,Primary!,NewModified!)
next

ll_Count = dw_views.RowCount()
ll_MaxView = gnv_app.of_get_id("user_view_id" ,ll_Count) - 1
for ll_Cycle = 1 to ll_Count
	dw_views.SetItem(ll_Cycle, "user_view_id", ll_MaxView + ll_Cycle )
	dw_views.SetItem(ll_Cycle, "user_id", is_user_id )
	dw_views.SetItemStatus(ll_Cycle,0,Primary!,NewModified!)
next

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
	dwchild.SetItem(ll_FindRow, "contract_default_view", 1001 )
end if
//---------Begin Added by (Appeon)Toney 09.04.2013 for V141 ISG-CLX--------
//$Reason:Fix reintegration BugT081302
DataStore  lds_getting
n_cst_getting_started  ln_getting
IF ln_getting.of_initgettingstart(is_user_id,lds_getting) <> 1 THEN
	Destroy lds_getting
	Messagebox('Getting Started','Failed to initialize data, please call support.')
	RETURN -1
END IF
if lds_getting.Update( ) < 1 then
	messagebox("Copy user failed"," Failure to update  getting started records.~r~n"+sqlca.sqlerrtext,StopSign!)
	ROLLBACK USING SQLCA;	
	Destroy lds_getting
	return -1
end if
Destroy lds_getting
//---------End Added ------------------------------------------------------------------

if dwchild.Update() < 1 then
	MessageBox('Copy user failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

if dw_facility.Update() < 1 then
	MessageBox('Copy user failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

if dw_department.Update() < 1 then
	MessageBox('Copy user failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

if dw_views.Update() < 1 then
	MessageBox('Copy user failed',SQLCA.SQLErrText,StopSign!)
	ROLLBACK USING SQLCA;
	return -1
end if

COMMIT USING SQLCA;

//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
of_add_audit( is_user_id, "I",0)
dw_audit.update()
//End Code Change---06.25.2009

//---------Begin Added by (Appeon)Harry 07.08.2016 for Docusign--------
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'sertifi');
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'echosign');
insert into personal_license_setting(user_id,esign_type) values(:is_user_id,'docusign');
//---------End Added ------------------------------------------------------

dw_roles.Retrieve(is_user_id)
dw_facility.Retrieve(is_user_id)
dw_department.Retrieve(is_user_id)
dw_views.Retrieve(is_user_id)

dw_select_user.SetItem(1, "user_id", is_user_id )

return 1
//--------------------------- APPEON END -----------------------------
end function

public function integer of_set_security ();// NOTE: other security is set in the constructor event
//Start Code Change ----06.16.2009 #V92 maha - function created

dw_roles.enabled = false
dw_facility.enabled = false
dw_department.enabled = false
dw_views.enabled = false
cb_new.enabled = false
cb_delete.enabled = false
cb_save.enabled = false
cb_email.enabled = false
cb_ldap.enabled = false
cb_copy.enabled = false
cb_security.enabled = false

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.20.2016
//<$>reason:V15.1 Applause Cycle 3 Bug #4926 - User with RO access to User Admin can modify existing user settings and add a new user
cb_reset.enabled = false
cb_image_security.enabled = false
cb_setup_ctx.enabled = false
cb_saf.enabled = false
cb_sav.enabled = false
cb_sad.enabled = false
cb_2.enabled = false
//------------------- APPEON END -------------------
	
return 1
end function

public function integer of_add_audit (string as_user, string as_from, integer as_row);//Start Code Change ----06.25.2009 #V92 maha - created for ameripath customization
//long ll_recid
datetime ldt_now
string ls_new
string ls_old
string ls_field
string ls_type
string ls_value
integer nr

//Start Code Change ----06.08.2010 #V10 maha - change to use instance variable
//select max(rec_id) into :ll_recid from sys_audit_user;  
//if isnull(ll_recid) then ll_recid = 0
//End Code Change---06.08.2010
ldt_now = datetime(today(),now())

ls_type = as_from

if as_from = "I"  then//insert
	ls_new = as_user
	ls_field = "User Inserted"
	ls_old = ""
elseif  as_from = "D" then //delete 
	ls_field = "User Deleted"
	ls_old = as_user
	ls_new = ""
elseif  as_from = "F" then // facility
	ls_field = "Facility Access"
	ls_type = "E"
	ls_value = dw_facility.getitemstring(as_row,"facility_facility_name")
	ls_new = ls_value + " - " + string(dw_facility.getitemnumber(as_row,"access_rights"))
	ls_old = ls_value + " - " + string(dw_facility.getitemnumber(as_row, "access_rights", primary!, true))
elseif  as_from = "V" then //view 
	ls_field = "View Access"
	ls_type = "E"
	ls_value = dw_views.getitemstring(as_row,"data_view_data_view_name")
	ls_new = ls_value + " - " + string(dw_views.getitemnumber(as_row,"access_rights")) //Evan 08.04.2009 --- Replace dw_facility with dw_views
	ls_old = ls_value + " - " + string(dw_views.getitemnumber(as_row, "access_rights", primary!, true)) //Evan 08.04.2009 --- Replace dw_facility with dw_views
elseif  as_from = "R" then //department
	ls_field = "Department Access"
	ls_type = "E"
	ls_value = dw_department.getitemstring(as_row,"code_lookup_description") //Evan 08.28.2009 --- Replace dw_departmentS with dw_department
	ls_new = ls_value + " - " + string(dw_department.getitemnumber(as_row,"access_rights")) //Evan 08.28.2009 --- Replace dw_facility with dw_department
	ls_old = ls_value + " - " + string(dw_department.getitemnumber( as_row, "access_rights", primary!, true)) //Evan 08.28.2009 --- Replace dw_facility with dw_department
end if

nr = dw_audit.insertrow(0)
dw_audit.setitem(nr,"user_id",as_user)
dw_audit.setitem(nr,"audit_type",ls_type)
dw_audit.setitem(nr,"new_value",ls_new)
dw_audit.setitem(nr,"old_value",ls_old)
dw_audit.setitem(nr,"field_name",ls_field)
il_audit_id++ //Start Code Change ----06.08.2010 #V10 maha 
dw_audit.setitem(nr,"rec_id",il_audit_id)
dw_audit.setitem(nr,"date_time_modified",ldt_now)
dw_audit.setitem(nr,"mod_by",gs_user_id )	

return 1
end function

public function integer of_readonly_hide ();if ii_readonly = 0 then
	dw_roles.object.read_only.tabsequence = 0
	dw_roles.object.read_only.Color = RGB(185,185,185)
end if

return 1
end function

public subroutine of_refresh_selectbutton ();//====================================================================
//$<Function>: of_refresh_selectbutton
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Refresh Select All buttons. 
//						For V14.2 Applause Bug #4831  - select all/unselect all buttons not refreshing in user admin 
//$<Author>: (Appeon) long.zhang 11.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//dw_facility, cb_saf
If dw_facility.RowCount() > 0 Then
	If dw_facility.Find('access_rights = 0', 1, dw_facility.RowCount())  > 0 Then
		cb_saf.Text = "Select All"
	Else
		cb_saf.Text = "Unselect All"
	End If
Else
	cb_saf.Text = "Select All"
End If

//dw_views, cb_sav
If dw_views.RowCount() > 0 Then
	If dw_views.Find('access_rights = 0', 1, dw_views.RowCount())  > 0 Then
		cb_sav.Text = "Select All"
	Else
		cb_sav.Text = "Unselect All"
	End If
Else
	cb_sav.Text = "Select All"
End If

//dw_department, cb_sad
If dw_department.RowCount() > 0 Then
	If dw_department.Find('access_rights = 0', 1, dw_department.RowCount())  > 0 Then
		cb_sad.Text = "Select All"
	Else
		cb_sad.Text = "Unselect All"
	End If
Else
	cb_sad.Text = "Select All"
End If

Return
end subroutine

on pfc_cst_u_security_user_painter.create
this.cb_cvo=create cb_cvo
this.cb_ad=create cb_ad
this.cb_h2=create cb_h2
this.cb_batch_provd=create cb_batch_provd
this.cb_2=create cb_2
this.cb_reset=create cb_reset
this.cb_setup_ctx=create cb_setup_ctx
this.cb_h1=create cb_h1
this.cb_image_security=create cb_image_security
this.cb_security=create cb_security
this.cb_ldap=create cb_ldap
this.cb_email=create cb_email
this.cb_copy=create cb_copy
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
this.st_1=create st_1
this.st_department=create st_department
this.cb_close=create cb_close
this.cb_print=create cb_print
this.gb_select=create gb_select
this.gb_main=create gb_main
this.dw_audit=create dw_audit
this.dw_roles=create dw_roles
this.gb_sec=create gb_sec
this.cb_4=create cb_4
this.Control[]={this.cb_cvo,&
this.cb_ad,&
this.cb_h2,&
this.cb_batch_provd,&
this.cb_2,&
this.cb_reset,&
this.cb_setup_ctx,&
this.cb_h1,&
this.cb_image_security,&
this.cb_security,&
this.cb_ldap,&
this.cb_email,&
this.cb_copy,&
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
this.st_1,&
this.st_department,&
this.cb_close,&
this.cb_print,&
this.gb_select,&
this.gb_main,&
this.dw_audit,&
this.dw_roles,&
this.gb_sec,&
this.cb_4}
end on

on pfc_cst_u_security_user_painter.destroy
destroy(this.cb_cvo)
destroy(this.cb_ad)
destroy(this.cb_h2)
destroy(this.cb_batch_provd)
destroy(this.cb_2)
destroy(this.cb_reset)
destroy(this.cb_setup_ctx)
destroy(this.cb_h1)
destroy(this.cb_image_security)
destroy(this.cb_security)
destroy(this.cb_ldap)
destroy(this.cb_email)
destroy(this.cb_copy)
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
destroy(this.st_1)
destroy(this.st_department)
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.gb_select)
destroy(this.gb_main)
destroy(this.dw_audit)
destroy(this.dw_roles)
destroy(this.gb_sec)
destroy(this.cb_4)
end on

event constructor;//Setup to use security on departments //users can only see physician data if they have access to the department the physician belongs

ii_dept_secure_setting = gi_dept_security


//IF ii_dept_secure_setting = 1 THEN
IF ii_dept_secure_setting = 1 and not gb_contract_version  THEN //08.10.2007 By Jervis
	dw_department.Visible = True
//	dw_views.x = 2103
//	gb_main.Width = 3127
//	gb_select.Width = 3127
//	st_view.x = 2103
//	cb_sav.x = 2400
	dw_department.of_SetUpdateAble( True )
ELSE 
	dw_department.Visible = False
	cb_sad.Visible = False
	st_department.Visible = False
	dw_department.Visible = False
	dw_department.of_SetUpdateAble( False )
//	gb_main.Width = 2098
//	gb_select.Width = 2100 //1659 //Modify 11.08.2007 By Evan
//	dw_views.x = 1083
//	st_view.x = 1083
//	cb_sav.x = 1381
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-16 By: Rodger Wu (Contract)
//$<reason> Modification for contract module.
String ls_set_cont

ls_set_cont = gnv_data.of_GetItem( "icred_settings", "set_cont", False )
IF IsNull( ls_set_cont ) THEN ls_set_cont = '0'

//IF ls_set_cont = '0' THEN //Start Code Change ----05.20.2008 #V8 maha - bug; moved below
//	dw_roles.Modify( "contract_default_view.visible=0 t_7.visible=0" )
//END IF

//Webview settings
//Start Code Change ----11.29.2009 #V8 maha 
IF gnv_data.of_GetItem( "icred_settings", "set_web", False ) = '0' THEN
	dw_roles.Modify( "wv_role_id.visible=0 t_4.visible=0" )
	dw_roles.Modify( "wv_ldap_user.visible=0 t_8.visible=0" )
	dw_roles.Modify( "audit_type.visible=0 t_3.visible=0" )
	dw_roles.Modify( "prac_id.visible=0 t_9.visible=0" )
	dw_roles.Modify( "b_search.visible=0" )
	dw_roles.Modify( "b_ps_link.visible=0" )  //Start Code Change ----12.08.2016 #V153 maha
END IF
//End Code Change---11.29.2007


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.19.2008 By: Ken.Guo
//$<reason> 
If gnv_data.of_GetItem( "icred_settings", "set_dashb", False ) = '0' Then
	dw_roles.Modify( "default_dashboard_id.visible=0 t_16.visible=0" )
	dw_roles.Modify( "set_dashboard.visible=0 t_15.visible=0" )	
End If
//---------------------------- APPEON END ----------------------------

//22/09/2006 Allen begin
IF gb_contract_version THEN
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.19.2008 By: Ken.Guo
	dw_roles.Modify("t_9.Visible = 0") 
	dw_roles.Modify("prac_id.Visible = 0")
	dw_roles.Modify("b_search.Visible = 0")
	//---------------------------- APPEON END ----------------------------	
	
	dw_roles.Modify("t_2.Visible = 0")
	dw_roles.Modify("default_view.Visible = 0")
	//Start Code Change ----11.29.2009 #V8 maha 
	dw_roles.Modify( "npdb_user_id.visible=0 t_10.visible=0" )
	dw_roles.Modify( "npdb_password.visible=0 t_11.visible=0" )
	//End Code Change---11.29.2007
	dw_roles.Modify( "set_task.visible=0 t_5.visible=0" ) //Start Code Change ----.2008 #V8 maha
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

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 11.19.2008 By: Ken.Guo
	//$<reason> 
	dw_roles.Modify("t_15.y =" + dw_roles.Describe("t_5.Y"))
	dw_roles.Modify("set_dashboard.y =" + dw_roles.Describe("set_task.Y"))
	dw_roles.Modify("t_16.y =" + dw_roles.Describe("t_1.Y"))
	dw_roles.Modify("default_dashboard_id.y =" + dw_roles.Describe("default_search_facility.Y"))	
	//---------------------------- APPEON END ----------------------------
	
	dw_roles.Modify("t_7.Y = " + dw_roles.Describe("t_2.Y"))
	dw_roles.Modify("contract_default_view.Y = " + dw_roles.Describe("default_view.Y"))
	dw_roles.Modify("Read_only.y =" + dw_roles.Describe("npdb_user_id.Y"))
	dw_roles.Modify("active_status.y =" + dw_roles.Describe("npdb_password.Y"))  //Start Code Change ----07.29.2009 #V92 maha
	dw_roles.Modify("image_flag.y =" + dw_roles.Describe("npdb_password.Y"))
//	dw_roles.Modify("Readonly.x =" + dw_roles.Describe("default_search_facility.x")+ ' ' + "Readonly.y =" + dw_roles.Describe("default_search_facility.Y"))
	
	//gb_1.height = 440  //Start Code Change ----01.07.2008 #V8 maha
	//dw_roles.height = 340 //Start Code Change ----01.07.2008 #V8 maha
	gb_sec.height = 600 //Added by Ken.Guo on 2008-08-26
	dw_roles.height = 525 //Added by Ken.Guo on 2008-08-26
	
//Start Code Change ----11.29.2007 #V8 maha	removed
//	cb_save.y = 660
//	cb_close.y = 660
//	dw_roles.height = 330
//End Code Change---11.29.2007

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
	IF ls_set_cont = '0' THEN //Start Code Change ----05.20.2008 #V8 maha - bug; moved from above
		dw_roles.Modify("t_7.Visible = 0")
		dw_roles.Modify("contract_default_view.Visible = 0")
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 11.19.2008 By: Ken.Guo
		//$<reason> 
		dw_roles.Modify("t_16.y =" + dw_roles.Describe("t_7.Y"))
		dw_roles.Modify("default_dashboard_id.y =" + dw_roles.Describe("contract_default_view.Y"))
		//---------------------------- APPEON END ----------------------------
	end if
END IF

//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
IF ls_set_cont = '1' then  // gb_contract_module
	cb_setup_ctx.visible = true
Else
	cb_setup_ctx.visible = false
End if
//---------End Modfiied ------------------------------------------------------

//---------Begin Added by (Appeon)Harry 08.31.2015 for Bug # 4694 --------
IF w_mdi.of_security_access( 6931 ) = 0 THEN
	cb_email.visible= false
ELSE
	cb_email.visible= true
END IF
//---------End Added ------------------------------------------------------

IF appeongetclienttype() = "WEB" and Not gb_AutoDwnReg Then
	dw_roles.Modify("image_flag.Visible = 0") //v12.1 web component - alfee 04.21.2012
END IF

IF appeongetclienttype() = 'PB' THEN
//Start Code Change ----11.15.2007 #V8 maha
//	st_1.Y = st_1.Y - 150
//	st_department.Y = st_department.Y - 150
//	st_view.Y = st_view.Y - 150
//	
//	dw_facility.Y = dw_facility.Y - 150
//	dw_department.Y = dw_department.Y - 150
//	dw_views.Y = dw_views.Y - 150
//	
//	dw_facility.Height = dw_facility.Height + 150
//	dw_department.Height = dw_department.Height + 150
//	dw_views.Height = dw_views.Height + 150
//
	dw_roles.Modify("image_flag.Visible = 0") //Start Code Change ----01.02.2008 #V8 maha readded
//Start Code Change ---- 11.15.2007 #V7 maha
END IF
//22/09/2006 Allen end
//---------------------------- APPEON END ----------------------------

if gb_cvo_user then cb_cvo.visible = true   //Start Code Change ----02.07.2017 #V153 maha

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

type cb_cvo from commandbutton within pfc_cst_u_security_user_painter
boolean visible = false
integer x = 3598
integer y = 128
integer width = 489
integer height = 84
integer taborder = 290
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "ISG CVO Users"
end type

event clicked;open(w_isg_cvo_user_set)
end event

type cb_ad from commandbutton within pfc_cst_u_security_user_painter
integer x = 2917
integer y = 128
integer width = 311
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "AD User"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 11.11.2016 (v15.3 AD Authentication)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_user_id

If dw_roles.RowCount() > 0 Then
	ls_user_id = dw_roles.GetItemString(1,'user_id')
End If

OpenWithParm(w_security_ad_user,ls_user_id)
end event

type cb_h2 from commandbutton within pfc_cst_u_security_user_painter
integer x = 3611
integer y = 424
integer width = 96
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;string s

s = "The Contact Settings can be used in Application mapping, Letters, and Reporting functions."

messagebox("About the user list",s)
end event

type cb_batch_provd from commandbutton within pfc_cst_u_security_user_painter
boolean visible = false
integer x = 2309
integer y = 44
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Batch Add Providers"
end type

type cb_2 from commandbutton within pfc_cst_u_security_user_painter
integer x = 457
integer y = 1616
integer width = 393
integer height = 76
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check Settings"
end type

event clicked;openwithparm(w_user_security_fix_single, is_user_id )
end event

type cb_reset from commandbutton within pfc_cst_u_security_user_painter
integer x = 507
integer y = 128
integer width = 535
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&User Reset Utilities"
end type

event clicked;open(w_user_reset)
end event

type cb_setup_ctx from commandbutton within pfc_cst_u_security_user_painter
integer x = 1618
integer y = 44
integer width = 635
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Contracts Settings"
end type

event clicked;// (Appeon)Eugene 06.20.2013 - V141 ISG-CLX
open(w_security_user_painter_ctx)

end event

type cb_h1 from commandbutton within pfc_cst_u_security_user_painter
integer x = 507
integer y = 44
integer width = 96
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "?"
end type

event clicked;string s

s = "The user list in the dropdown is sorted into 3 groups:~r "
s+= "Active users with an IntelliSoft role ~r" 
s+= "Inactive users with an IntelliSoft role(if any) - in pink~r" 
s+= "Webview only users (if any) - in blue.~r" 

messagebox("About the user list",s)
end event

type cb_image_security from commandbutton within pfc_cst_u_security_user_painter
integer x = 1618
integer y = 128
integer width = 489
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Image Type Security"
end type

event clicked;//Start Code Change ----09.26.2012 #V12 maha - added for 12.3
string ls_parm
//report*I@ALL

if is_user_id = '' then
	messagebox("","No User Selected")
	return
end if

ls_parm = "ALL*I@" + is_user_id
openwithparm(w_image_user_access,ls_parm)
end event

type cb_security from commandbutton within pfc_cst_u_security_user_painter
integer x = 1070
integer y = 128
integer width = 530
integer height = 84
integer taborder = 250
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "IntelliReport Security"
end type

event clicked;string ls_parm
//report*I@ALL

if is_user_id = '' then
	messagebox("","No User Selected")
	return
end if

ls_parm = "ALL*I@" + is_user_id
openwithparm(w_ireport_user_access,ls_parm)
end event

type cb_ldap from commandbutton within pfc_cst_u_security_user_painter
integer x = 3246
integer y = 128
integer width = 343
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Auto-Login"
end type

event clicked;//Start Code Change ----11.21.2008 #V7 maha
//Button added to replace on on dw object
string ls_user_id
If Dw_roles.RowCount() > 0 Then
	ls_user_id = Dw_roles.GetItemString(1,'user_id')
End If
OpenWithParm(w_security_ldap_user,ls_user_id)
end event

type cb_email from commandbutton within pfc_cst_u_security_user_painter
integer x = 2126
integer y = 128
integer width = 489
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Email Properties"
end type

event clicked;string ls_Message

ls_Message = dw_select_user.object.user_id[1]
if IsNull(ls_Message) then ls_Message = ""
ls_Message = "ALL|" + ls_Message

//Start Code Change ----10.08.2008 #V85 maha
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
//if of_get_app_setting("set_56","I") = 1 then
	OpenWithParm(w_email_account_edit_for_outlook, ls_Message)
else
	OpenWithParm(w_email_account_edit, ls_Message)
end if
//End Code Change---10.08.2008
end event

type cb_copy from u_cb within pfc_cst_u_security_user_painter
integer x = 1326
integer y = 44
integer width = 274
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "C&opy User"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modified> 2007-05-24 By: Wu ZhiJun
//$<reason> Fixed a bug

//Start Code Change ----01.04.2008 #V8 maha - trap added
if dw_roles.rowcount() < 1 then 
	messagebox("Copy User","Select a user to copy.")
	return
end if
//End Code Change---01.04.2008

if of_copy_user() = 1 then
	if Not cb_delete.Enabled then
		cb_delete.Enabled = true
	end if
end if
//--------------------------- APPEON END -----------------------------

end event

type dw_departments from datawindow within pfc_cst_u_security_user_painter
boolean visible = false
integer x = 1435
integer y = 2936
integer width = 270
integer height = 68
integer taborder = 110
string dataobject = "d_all_departments"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_sad from u_cb within pfc_cst_u_security_user_painter
integer x = 2743
integer y = 1688
integer width = 325
integer height = 72
integer taborder = 290
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;call super::clicked;Integer 	i
Integer 	li_rc
Integer 	li_select_val
long		ll_Row
String	ls_UserID

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-27 By: Scofield
//$<Reason> Check the user_id if is valid.

ll_Row = dw_select_user.GetRow()
if ll_Row <= 0 or ll_Row > dw_select_user.RowCount() then Return

ls_UserID = dw_select_user.GetItemString(ll_Row,"user_id")
if IsNull(ls_UserID) or Trim(ls_UserID) = "" then Return

//---------------------------- APPEON END ----------------------------

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

type st_view from statictext within pfc_cst_u_security_user_painter
integer x = 1102
integer y = 1700
integer width = 347
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "View Access"
boolean focusrectangle = false
end type

type dw_department from u_dw within pfc_cst_u_security_user_painter
integer x = 2098
integer y = 1772
integer width = 974
integer height = 764
integer taborder = 230
string dataobject = "d_security_user_department_access"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
integer i

for i = 1 to this.rowcount()
	if this.getitemstatus( i,  "access_rights", primary!) = datamodified! then
		of_add_audit( is_user_id, "R", i)
	end if
next

return 1
end event

type cb_sav from u_cb within pfc_cst_u_security_user_painter
integer x = 1742
integer y = 1688
integer width = 325
integer height = 72
integer taborder = 300
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;Integer 	li_select_val
long		ll_Cycle,ll_RowCnt,ll_Row,ll_DefView,ll_View
String	ls_Dispaly,ls_UserID

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-27 By: Scofield
//$<Reason> Check the user_id if is valid.

ll_Row = dw_select_user.GetRow()
if ll_Row <= 0 or ll_Row > dw_select_user.RowCount() then Return

ls_UserID = dw_select_user.GetItemString(ll_Row,"user_id")
if IsNull(ls_UserID) or Trim(ls_UserID) = "" then Return

//---------------------------- APPEON END ----------------------------

IF cb_sav.Text = "Select All" THEN
	cb_sav.text = "Unselect All"
	li_select_val = 1
ELSE
	cb_sav.Text = "Select All" 
	li_select_val = 0	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-21 By: Scofield
//$<Reason> If current view is Practitioner Default View. Can't be canceled.

ll_Row = dw_Roles.GetRow()
ll_DefView = dw_Roles.GetItemNumber(ll_Row,'default_view')
ls_Dispaly = dw_Roles.Describe("Evaluate('LookUpDisplay(default_view)'," + String(ll_Row) + ")")
		
ll_RowCnt = dw_views.RowCount()
FOR ll_Cycle = 1 TO ll_RowCnt
	if li_select_val = 0 then
		ll_View = dw_views.GetItemNumber(ll_Cycle,'view_id')
		if ll_View = ll_DefView then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Dispaly + " is Practitioner Default View. Can't be canceled.")
		else
			dw_views.SetItem(ll_Cycle, "access_rights", li_select_val )
		end if
	else
		dw_views.SetItem(ll_Cycle, "access_rights", li_select_val )
	end if
next
//---------------------------- APPEON END ----------------------------

end event

type cb_saf from u_cb within pfc_cst_u_security_user_painter
integer x = 727
integer y = 1692
integer width = 325
integer height = 72
integer taborder = 280
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;Integer 	li_select_val
long		ll_Cycle,ll_RowCnt,ll_Row,ll_DefFacility,ll_Facility
String	ls_Dispaly,ls_UserID

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-27 By: Scofield
//$<Reason> Check the user_id if is valid.

ll_Row = dw_select_user.GetRow()
if ll_Row <= 0 or ll_Row > dw_select_user.RowCount() then Return

ls_UserID = dw_select_user.GetItemString(ll_Row,"user_id")
if IsNull(ls_UserID) or Trim(ls_UserID) = "" then Return

//---------------------------- APPEON END ----------------------------

IF cb_saf.Text = "Select All" THEN
	cb_saf.text = "Unselect All"
	li_select_val = 1
ELSE
	cb_saf.Text = "Select All" 
	li_select_val = 0	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-21 By: Scofield
//$<Reason> If current facility is Default Search Facility. Can't be canceled.

ll_Row = dw_Roles.GetRow()
ll_DefFacility = dw_Roles.GetItemNumber(ll_Row,'default_search_facility')
ls_Dispaly = dw_Roles.Describe("Evaluate('LookUpDisplay(default_search_facility)'," + String(ll_Row) + ")")

ll_RowCnt = dw_facility.RowCount()
FOR ll_Cycle = 1 TO ll_RowCnt
	if li_select_val = 0 then
		ll_Facility = dw_facility.GetItemNumber(ll_Cycle,'facility_id')
		if ll_Facility = ll_DefFacility then
			MessageBox(gnv_app.iapp_object.DisplayName,ls_Dispaly + " is Default Search Facility. Can't be canceled.")
		else
			dw_facility.SetItem(ll_Cycle, "access_rights", li_select_val )
		end if
	else
		dw_facility.SetItem(ll_Cycle, "access_rights", li_select_val )
	end if
next
//---------------------------- APPEON END ----------------------------

end event

type dw_facility from u_dw within pfc_cst_u_security_user_painter
integer x = 73
integer y = 1772
integer width = 983
integer height = 764
integer taborder = 220
string dataobject = "d_security_user_facility_access"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-18 By: Scofield
//$<Reason> This facility is Default Search Facility. Can't be canceled.

long	ll_FacilityID,ll_DefFacility,ll_Row

if dwo.name = 'access_rights' then
	if long(data) = 0 then
		ll_Row = dw_Roles.GetRow()
		ll_DefFacility = dw_Roles.GetItemNumber(ll_Row,'default_search_facility')
		ll_FacilityID = dw_facility.GetItemNumber(Row,'facility_id')

		if ll_FacilityID = ll_DefFacility then
			MessageBox(gnv_app.iapp_object.DisplayName,"This facility is Default Search Facility. Can't be canceled.")
			Return 2
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_update;call super::pfc_update;//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
integer i

for i = 1 to this.rowcount()
	if this.getitemstatus( i,  "access_rights", primary!) = datamodified! then
		of_add_audit( is_user_id, "F", i)
	end if
next
dw_audit.Update() //Added by Evan 09.01.2011

return 1
end event

type cb_save from u_cb within pfc_cst_u_security_user_painter
integer x = 3099
integer y = 44
integer width = 489
integer height = 84
integer taborder = 310
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-04 By: Scofield
//$<Reason> if there is not any user,then return.

long		ll_Row
String	ls_UserId

ll_Row = dw_Select_User.GetRow()
ls_UserId = dw_Select_User.GetItemString(ll_Row,'user_id')

if IsNull(ls_UserId) or Trim(ls_UserId) = '' then return
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
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

////--------------------------- APPEON BEGIN ---------------------------
//Commented by Ken.Guo 11/1912007. Move All LDAP data to LDAP Painter.
////$<add> 10/09/2007 By: Ken.Guo
////$<reason> Forbid one LDAP user relate multi-user
//String ls_ldapuser,ls_user_id,ls_exist_user_id
//ls_ldapuser = dw_roles.Getitemstring( 1, "ic_ldap_user")
//ls_user_id = dw_roles.Getitemstring( 1, "user_id")
//If ls_ldapuser <> '' And NOT isnull(ls_ldapuser) Then
//	Select user_id into :ls_exist_user_id from security_users where upper(ic_ldap_user) = upper(:ls_ldapuser) and user_id <> :ls_user_id  ;
//	If ls_exist_user_id <> '' and not isnull(ls_exist_user_id) Then
//		Messagebox('Save Error','The LDAP user "'+ls_ldapuser+'" has already been linked to the user "'+ls_exist_user_id+'". Please input another LDAP user.')
//		Return -1
//	End If
//End If
////---------------------------- APPEON END ----------------------------
//



Integer li_retval

select max(rec_id) into :il_audit_id from sys_audit_user; //Start Code Change ----06.09.2010 #V10 maha
li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-13
//$<add> 04.21.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> Refresh the security_users data after updating.

dw_audit.Update()//(Appeon)Harry 11.25.2013 - V141 for BugH092301 of History Issues

SetNull(gnv_win_backcolor.il_win_backcolor) //Add by Evan 11/28/2008

gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve( "security_users")
SELECT readonly Into :gi_user_readonly From security_users Where Upper(user_id) = :gs_user_id; //Added By Ken.Guo 09-10-2008
SELECT data_view.win_backcolor INTO :gnv_win_backcolor.il_win_backcolor
FROM  security_users, data_view
WHERE data_view.data_view_id = security_users.contract_default_view AND
		security_users.user_id = :gs_user_id;//Add by Evan 11/28/2008
gnv_appeondb.of_commitqueue( ) 
//---------------------------- APPEON END ----------------------------

end event

type cb_delete from u_cb within pfc_cst_u_security_user_painter
integer x = 969
integer y = 44
integer width = 347
integer height = 84
integer taborder = 150
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
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

type dw_select_user from u_dw within pfc_cst_u_security_user_painter
integer x = 46
integer y = 48
integer width = 457
integer height = 76
integer taborder = 10
string dataobject = "d_select_user_for_audit_trail"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )




end event

event itemchanged;call super::itemchanged;Is_user_id = data



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
//Start Code Change ----06.16.2009 #V92 maha - trap for RO user
if gi_user_readonly = 0 and w_mdi.of_security_access( 900 ) > 1 then //Add 900, modified by Appeon long.zhang 01.20.2016 (V15.1 Applause Cycle 3 Bug #4926 - User with RO access to User Admin can modify existing user settings and add a new user)
	dw_roles.enabled = true  
	cb_delete.enabled = lower(data)<>'master'
end if
//End Code Change---06.16.2009
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

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-04-17 By: Scofield
//$<Reason> Change "None" to ""

//dwchild.setitem(1,"data_view_name","None")
dwchild.SetItem(1,"data_view_name","")
//---------------------------- APPEON END ----------------------------

dw_facility.AcceptText()
dw_views.AcceptText()
dw_roles.AcceptText()

of_readonly_hide( )

of_refresh_selectbutton() //Added by Appeon long.zhang 11.06.2015 (V14.2 Applause Bug #4831  - select all/unselect all buttons not refreshing in user admin)
end event

type cb_new from u_cb within pfc_cst_u_security_user_painter
integer x = 608
integer y = 44
integer height = 84
integer taborder = 160
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Create User"
end type

event clicked;of_create_user()
Parent.SetRedraw(true)

end event

type dw_views from u_dw within pfc_cst_u_security_user_painter
integer x = 1093
integer y = 1772
integer width = 974
integer height = 768
integer taborder = 210
string dataobject = "d_security_user_views_access"
end type

event constructor;This.of_SetTransObject( SQLCA )

end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-18 By: Scofield
//$<Reason> This view is Practitioner Default View. Can't be canceled.

long	ll_View,ll_DefView,ll_Row

if dwo.name = 'access_rights' then
	if long(data) = 0 then
		ll_Row = dw_Roles.GetRow()
		ll_DefView = dw_Roles.GetItemNumber(ll_Row,'default_view')
		ll_View = dw_views.GetItemNumber(Row,'view_id')

		if ll_View = ll_DefView then
			MessageBox(gnv_app.iapp_object.DisplayName,"This view is Practitioner Default View. Can't be canceled.")
			Return 2
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
integer i

for i = 1 to this.rowcount()
	if this.getitemstatus( i,  "access_rights", primary!) = datamodified! then
		of_add_audit( is_user_id, "V", i)
	end if
next

return 1
end event

type st_1 from statictext within pfc_cst_u_security_user_painter
integer x = 73
integer y = 1700
integer width = 407
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Facility Access"
boolean focusrectangle = false
end type

type st_department from statictext within pfc_cst_u_security_user_painter
integer x = 2103
integer y = 1700
integer width = 521
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Department Access"
boolean focusrectangle = false
end type

type cb_close from u_cb within pfc_cst_u_security_user_painter
integer x = 3598
integer y = 44
integer width = 489
integer height = 84
integer taborder = 260
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close( iw_win )
end event

type cb_print from u_cb within pfc_cst_u_security_user_painter
boolean visible = false
integer x = 2811
integer y = 2868
integer width = 338
integer height = 84
integer taborder = 240
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print"
end type

type gb_select from groupbox within pfc_cst_u_security_user_painter
integer x = 9
integer width = 4114
integer height = 228
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select User"
end type

type gb_main from groupbox within pfc_cst_u_security_user_painter
integer x = 27
integer y = 1632
integer width = 3072
integer height = 944
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Access Settings"
end type

type dw_audit from datawindow within pfc_cst_u_security_user_painter
boolean visible = false
integer x = 763
integer y = 2872
integer width = 549
integer height = 200
integer taborder = 270
boolean bringtotop = true
string title = "none"
string dataobject = "d_view_audit_user"
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type dw_roles from u_dw within pfc_cst_u_security_user_painter
integer x = 32
integer y = 308
integer width = 4069
integer height = 1288
integer taborder = 180
string dataobject = "d_security_user_roles_access_w_sets"
boolean vscrollbar = false
boolean border = false
end type

event constructor;//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.14.2009
//$<reason> Corrected BugA101403
string ls_Filter
DataWindowChild ldwc_Child
this.GetChild("set_go_on_open", ldwc_Child)

// Filter go on window name
if of_get_app_setting("set_9", "I") <> 4 and of_get_app_setting("set_cont", "I") <> 0  then
	// IntelliCred/App and Contract module
elseif of_get_app_setting("set_9", "I") <> 4 then
	// IntelliCred/App module
	ls_Filter = "module_type = 0 or module_type = 1"
elseif of_get_app_setting("set_cont", "I") <> 0 then
	// Contract module
	ls_Filter = "module_type = 0 or module_type = 2"
end if
ldwc_Child.SetFilter(ls_Filter)
ldwc_Child.Filter()
//------------------- APPEON END ---------------------

//Start Code Change ----10.04.2012 #V12 maha
this.GetChild("role_id", ldwc_Child)
ldwc_Child.settransobject(sqlca)
ldwc_Child.retrieve()
ldwc_Child.insertrow(1)
ldwc_Child.setitem(1,"role_id", 0)
//End Code Change ----10.04.2012

//Start Code Change ----02.12.2012 #V12 maha
this.GetChild("wv_role_id", ldwc_Child)
ldwc_Child.settransobject(sqlca)
ldwc_Child.retrieve()
ldwc_Child.insertrow(1)
//End Code Change ----12.12.2012


This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )
this.enabled = false ////Start Code Change ----04.28.2008 #V8 maha
end event

event pfc_preupdate;call super::pfc_preupdate;Long ll_recid
string ls_old
string ls_new
string ls_column
string ls_type
datetime ldt_now
integer i
integer ic
integer nr
string ls_license

IF This.GetItemStatus( 1, 0, Primary! ) = NewModified! THEN
	dw_roles.SetItem( 1, "user_id", is_user_id )
END IF
//Start Code Change ----08.11.2009 #V92 maha - read only user notice
if this.getitemnumber(1,"read_only") = 1 then
	select license_info into :ls_license from icred_settings;
	ls_license = MidA(  ls_license , 15, 3 )
	if integer(ls_license) = 0 then
		messagebox("Read Only license","This user is set to read only, but your system has no read only licenses.  This user will not be able to login.")
	end if
elseif isnull(this.getitemnumber(1,"read_only")) then  //Start Code Change ----10.04.2012 #V12 maha
	this.setitem(1,"read_only", 0)  //Start Code Change ----05.30.2014 #V14.2 maha - changed from 1
end if
//End Code Change---08.11.2009

//Start Code Change ----10.04.2012 #V12 maha - set if null
if isnull(this.getitemnumber(1,"active_status")) then
	this.setitem(1,"active_status", 0)
end if
//End Code Change ----10.04.2012 
debugbreak()

If not (this.describe("set_home.visible") = '!') then //Added by Appeon long.zhang 10.16.2014
	//Start Code Change ----07.10.2014 #V14.2 maha
	if this.getitemnumber(1,'set_home') = 0 then 
		gb_home_icon = False
	else
		gb_home_icon = True	
	end if
	//End Code Change ----07.10.2014
End If

//Start Code Change ----06.25.2009 #V92 maha - role audit functionality for ameripath
IF This.GetItemStatus( 1, 0, Primary! ) = DataModified! THEN
	select max(rec_id) into :ll_recid from sys_audit_user;
	if isnull(ll_recid) then ll_recid = 0
	ldt_now = datetime(today(),now())
	
	FOR i = 1 TO 19
		choose case i
			case 1
				ls_column = "role_id"
				ls_type = "N"
				case 2
				ls_column = "default_view"
				ls_type = "N"
				case 3
				ls_column = "default_search_facility"
				ls_type = "N"
				case 4
				ls_column = "contract_default_view"
				ls_type = "N"
				case 5
				ls_column = "default_dashboard_id"
				ls_type = "N"
				case 6
				ls_column = "user_name"
				ls_type = "S"
				case 7
				ls_column = "npdb_user_id"
				ls_type = "S"
				case 8
				ls_column = "npdb_password"
				ls_type = "S"
				case 9
				ls_column = "set_go_on_open"
				ls_type = "N"
				case 11
				ls_column = "set_tdl"
				ls_type = "N"
				case 12
				ls_column = "set_task"
				ls_type = "N"
				case 13
				ls_column = "set_dashboard"
				ls_type = "N"
				case 14
				ls_column = "wv_role_id"
				ls_type = "N"
				case 15
				ls_column = "wv_ldap_user"
				ls_type = "S"
				case 16
				ls_column = "audit_type"
				ls_type = "N"
				case 17
				ls_column = "image_flag"
				ls_type = "S"
				case 18
				ls_column = "read_only"
				ls_type = "N"
				case 19
				ls_column = "active_status"
				ls_type = "N"
		end choose
		
		if this.getitemstatus( 1, ls_column, primary!) <> datamodified! then continue
		
		//Start Code Change ----11.17.2014 #V14.2 maha - added trap to blank this field
		if ls_column = "npdb_password" then
			ls_new = '*******'
			ls_old = '********'
		 //End Code Change ----11.17.2014
		elseif ls_type = "S" then
			ls_new = this.getitemstring(1,ls_column)
			ls_old = this.getitemstring(1,ls_column,primary!,true)
		elseif ls_type = "N" then
			ls_new = string(this.getitemnumber(1,ls_column))
			ls_old = string(this.getitemnumber(1,ls_column,primary!,true))
		end if
		if ls_old <> ls_new then
		//if this.getitemstatus( i, "security_roles_rights_value_id", primary!) = datamodified! then
			nr = dw_audit.insertrow(0)
			dw_audit.setitem(nr,"user_id",this.getitemstring(1,"user_id"))
			dw_audit.setitem(nr,"field_name", ls_column)
			//dw_audit.setitem(nr,"sub_id",this.getitemnumber(i,"sub_module_id"))
			//dw_audit.setitem(nr,"action_id",this.getitemnumber(i,"action_id"))
			dw_audit.setitem(nr,"audit_type","E")
	
			dw_audit.setitem(nr,"new_value",ls_new)
			dw_audit.setitem(nr,"old_value",ls_old)
			ll_recid++
			dw_audit.setitem(nr,"rec_id",ll_recid)
			dw_audit.setitem(nr,"date_time_modified",ldt_now)
			dw_audit.setitem(nr,"mod_by",gs_user_id )		
		end if
	END FOR	
end if
//End Code Change---06.25.2009

RETURN 1
end event

event buttonclicked;call super::buttonclicked;Integer li_rtn  //(V15.3 PrivSearch) alfee 01.18.2017
String ls_user_id,ls_ldapuser
String ls_enval, ls_link //maha 12.08.2016
String ls_delimiter="*-*-" //(V15.3 PrivSearch) alfee 01.18.2017
OleObject wsh //(V15.3 PrivSearch) alfee 01.18.2017

If dwo.name = 'b_ldap_user_batch' Then
	ls_user_id = Dw_roles.GetItemString(1,'user_id')
	OpenWithParm(w_security_ldap_user,ls_user_id)
	ls_ldapuser = Message.Stringparm
	If ls_ldapuser <> Dw_roles.GetItemString(1,'ic_ldap_user') Then
		dw_roles.SetItem(1,'ic_ldap_user',ls_ldapuser)
	End If	
elseif 	dwo.name = 'b_search' Then //Start Code Change ----11.15.2008 #V8 maha
	//Start Code Change ----04.02.2008 #V8 maha
	Integer li_nr
	Integer li_find
	Long ll_prac_id
	gs_search lstr_search
	integer i
	integer ic

	lstr_search.stran_transaction = SQLCA
	lstr_search.ls_open_for = "ACTIONITEMS" 
	OpenWithParm( w_extended_search_new , lstr_search )
 
	IF Message.DoubleParm = -1 THEN
		Return -1
	END If
	ll_prac_id = Long( Message.StringParm )

	this.setitem(this.getrow(),"prac_id", ll_prac_id)
	//End Code Change---04.02.2008
elseif 	dwo.name = 'b_ps_link' then
	n_cst_encrypt ln_encrypt
	ls_link = gnv_data.of_getitem('ids','wv_meeting_link',false)
	ls_user_id = this.GetItemString(1,'user_id')
	ls_enval = this.GetItemString(1,'brown_val')
	
	if isnull(ls_enval) or len(ls_enval) = 0 then
		ls_enval = of_create_random_password(10)
		this.setitem(1,"brown_val", ls_enval)
		messagebox("New user note:", "If this user's password is changed, this link will have to be regenerated.")
		this.update()
	end if
	
	if right(ls_link,1) <> '/' then
		ls_link+= "/"
	end if
	
	ls_user_id = ln_encrypt.of_encrypt( ls_user_id)

	//--------Begin Modified by (V15.3 PrivSearch) alfee 01.18.2017 ----------------
	Try 
		wsh = Create OleObject
		li_rtn = wsh.ConnectToNewObject("MSScriptControl.ScriptControl")
		If li_rtn = 0 Then
			wsh.language = "javascript"
			ls_user_id = wsh.Eval("encodeURIComponent('" + ls_user_id + "')")
			ls_enval = wsh.Eval("encodeURIComponent('" + ls_enval + "')")
		Else
			If isvalid(wsh) Then Destroy wsh	 
			messagebox("PrivSearch Link","ConnectToNewObject('MSScriptControl.ScriptControl') is failed. The returned value is " + String(li_rtn));
			Return
		End If	 
	Catch (Throwable th1)
		//
	End Try
	If isvalid(wsh) Then Destroy wsh		

	ls_link = ls_link + "privsearch/?" + ls_user_id + ls_delimiter + ls_enval
	//ls_link = ls_link + "privsearch/?" + ls_user_id + "***" + ls_enval
	//--------End Modified -------------------------------------------------------------------
	
	openwithparm(w_wv_link,ls_link)
end if





end event

event itemchanged;call super::itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-18 By: Scofield
//$<Reason> if current user have no access rights for selected view or facility,then give user a tip.

long	ll_Cycle,ll_Cnt,ll_ViewID,ll_FacilityID,ll_Right

if dwo.name = 'default_view' then
	ll_Cnt = dw_views.RowCount()
	for ll_Cycle = 1 to ll_Cnt
		ll_ViewID = dw_views.GetItemNumber(ll_Cycle,'view_id')
		if ll_ViewID = long(data) then
			ll_Right = dw_views.GetItemNumber(ll_Cycle,'access_rights')
			if ll_Right <> 1 then
				//Start Code Change ----06.09.2016 #V152 maha - add the right
				dw_views.SetItem(ll_Cycle,'access_rights', 1)
//				MessageBox(gnv_app.iapp_object.DisplayName,"You have no access rights to this view.  Please assign rights in the View Access list.")
//				Return 2
				//End Code Change ----06.09.2016
			end if
			Return 0
		end if
	next
elseif dwo.name = 'default_search_facility' then
	ll_Cnt = dw_facility.RowCount()
	for ll_Cycle = 1 to ll_Cnt
		ll_FacilityID = dw_facility.GetItemNumber(ll_Cycle,'facility_id')
		if ll_FacilityID = long(data) then
			ll_Right = dw_facility.GetItemNumber(ll_Cycle,'access_rights')
			if ll_Right <> 1 then
				//Start Code Change ----06.09.2016 #V152 maha - add the right
				dw_facility.setItem(ll_Cycle,'access_rights', 1)
//				MessageBox(gnv_app.iapp_object.DisplayName,"You have no access rights to this facility.  Please assign rights in the Facility Access list.")
//				Return 2
				//End Code Change ----06.09.2016
			end if
			Return 0
		end if
	next
//---------------------------- APPEON END ----------------------------	
elseif dwo.name = 'prac_window_type' then  //Start Code Change ----08.10.2016 #V152 maha
	if gs_cust_type <> 'I' and data = '10' then
		messagebox("","This option is only used in the IntelliApp Version of the program. Please select another option")
//		this.setitem(row, "prac_window_type", this.getitemnumber(this.getrow(), "prac_window_type", primary!, false))
		return 1
	end if
	
elseif  dwo.name = 'font_zoom' then  //Start Code Change ----08.01.2017 #V154 maha
	gi_zoom = integer(data)
end if


end event

type gb_sec from groupbox within pfc_cst_u_security_user_painter
integer x = 27
integer y = 256
integer width = 4101
integer height = 1352
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Security Settings"
end type

type cb_4 from commandbutton within pfc_cst_u_security_user_painter
integer x = 2633
integer y = 128
integer width = 265
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&SAML"
end type

event clicked;//Button added to replace on on dw object
string ls_Message

ls_Message = dw_select_user.object.user_id[1]
if IsNull(ls_Message) then ls_Message = ""
ls_Message = "ALL|" + ls_Message

OpenWithParm(w_saml_config_setting,ls_Message)
end event

