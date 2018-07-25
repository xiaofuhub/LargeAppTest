$PBExportHeader$pfc_cst_u_security_roles_painter.sru
forward
global type pfc_cst_u_security_roles_painter from userobject
end type
type dw_example from datawindow within pfc_cst_u_security_roles_painter
end type
type dw_audit from datawindow within pfc_cst_u_security_roles_painter
end type
type cb_save from u_cb within pfc_cst_u_security_roles_painter
end type
type cb_print from u_cb within pfc_cst_u_security_roles_painter
end type
type st_3 from statictext within pfc_cst_u_security_roles_painter
end type
type st_2 from statictext within pfc_cst_u_security_roles_painter
end type
type st_1 from statictext within pfc_cst_u_security_roles_painter
end type
type dw_modules from u_dw within pfc_cst_u_security_roles_painter
end type
type dw_sub_modules from u_dw within pfc_cst_u_security_roles_painter
end type
type dw_actions from u_dw within pfc_cst_u_security_roles_painter
end type
type gb_1 from groupbox within pfc_cst_u_security_roles_painter
end type
type dw_print from datawindow within pfc_cst_u_security_roles_painter
end type
end forward

global type pfc_cst_u_security_roles_painter from userobject
string tag = "of_rename"
integer width = 3045
integer height = 1596
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_example dw_example
dw_audit dw_audit
cb_save cb_save
cb_print cb_print
st_3 st_3
st_2 st_2
st_1 st_1
dw_modules dw_modules
dw_sub_modules dw_sub_modules
dw_actions dw_actions
gb_1 gb_1
dw_print dw_print
end type
global pfc_cst_u_security_roles_painter pfc_cst_u_security_roles_painter

type variables
Integer ii_id = 1

w_security_roles_painter  iw_win

boolean ib_1  = true
boolean ib_2 = true
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2007 By: Jack 
//$<reason> Fix a defect.
boolean ib_update
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_set_parent_window (window aw_win)
public function integer of_save ()
public function integer of_delete ()
public function integer of_new (integer ai_role_id)
public function integer of_copy_role (integer ai_role_id)
public function integer of_add_audit (integer ai_role, string as_name, string as_from)
public function integer of_rename ()
public function integer of_filter_by_settings ()
end prototypes

public function integer of_set_parent_window (window aw_win);iw_win = aw_win

RETURN 1
end function

public function integer of_save ();Integer li_retval

dw_actions.AcceptText()
li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return -1
END IF

RETURN 1


end function

public function integer of_delete ();DataWindowChild dwchild
Integer li_ans
string ls_role_name 
integer li_find

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04/24/2007 By: Ken.Guo
//$<reason> Can't be delete when the role is administrator or used by user.
long ll_count
if ii_id = 1 then //administrator role
	messagebox('Delete','The administrator role can~'t be deleted.',Exclamation!)
	Return -1
end if

select count(*) into :ll_count from security_users where role_id = :ii_id;
if ll_count > 0 then 
	messagebox('Delete','This role is connected to ' + string(ll_count) + ' user(s) and cannot be deleted.',Exclamation!)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

li_ans = MessageBox("Confirm Delete", "Are you sure you want to delete this role?", Question!, YesNo!, 2 )		//Modified by Scofield on 2008-04-09: Change StopSign! to Question!
IF li_ans = 2 THEN
	RETURN -1
END IF

//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
iw_win.dw_select_role.GetChild( "role_id", dwchild )
li_find = dwchild.find( "role_id = " + string(ii_id), 1, dwchild.rowcount())
if li_find > 0 then
	ls_role_name = dwchild.getitemstring(li_find,"role_name")
else
	ls_role_name = ""
end if
//End Code Change---06.25.2009

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
DELETE FROM ctx_acp_contract_management_right
WHERE role_id = :ii_id;
iw_win.ib_retrieve = True
//---------------------------- APPEON END ----------------------------

DELETE FROM security_roles_rights
WHERE role_id = :ii_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF

DELETE FROM security_roles
WHERE role_id = :ii_id;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	RETURN -1
END IF


dw_actions.Reset()
dw_modules.Reset()
dw_sub_modules.Reset()

//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
of_add_audit(ii_id, ls_role_name, "D")
 li_ans =  dw_audit.update()
 if li_ans < 1 then messagebox("Delete role","Failed to create audit record")
//End Code Change ----06.25.2009 #V92 maha 

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.GetChild( "role_id", dwchild )
*/
iw_win.dw_select_role.GetChild( "role_id", dwchild )
//---------------------------- APPEON END ----------------------------
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.Reset()
dw_select_role.InsertRow( 0 )
*/
iw_win.dw_select_role.Reset()
iw_win.dw_select_role.InsertRow( 0 )
//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_new (integer ai_role_id);n_ds lds_actions
n_ds lds_role
Integer li_row_cnt
Integer li_nr
Integer i
Integer li_rights_id
Integer li_next_role_id
String ls_role_name
DataWindowChild dwchild

Open( w_security_get_role_name )

ls_role_name = Message.StringParm

IF ls_role_name = "Cancel" THEN
	Return -1
END IF

if LenA(ls_role_name) < 1 then //maha 082203
	return -1
end if

This.SetRedraw( False )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
SELECT Max( role_id )  
INTO :li_next_role_id  
FROM security_roles;

IF IsNull( li_next_role_id ) THEN
	li_next_role_id = 1
ELSE
	li_next_role_id ++
END IF

lds_actions = CREATE n_ds
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.of_SetTransObject( SQLCA )
li_row_cnt = lds_actions.Retrieve()

dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
*/

lds_actions = CREATE n_ds
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.of_SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.GetChild( "role_id", dwchild )
*/
iw_win.dw_select_role.GetChild( "role_id", dwchild )
//---------------------------- APPEON END ----------------------------
dwchild.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_actions.Retrieve()
dwchild.Retrieve()

SELECT Max( role_id )  
INTO :li_next_role_id  
FROM security_roles;

gnv_appeondb.of_commitqueue( )

li_row_cnt = lds_actions.Rowcount( )

IF IsNull( li_next_role_id ) THEN
	li_next_role_id = 1
ELSE
	li_next_role_id ++
END IF
//---------------------------- APPEON END ----------------------------

lds_role = CREATE n_ds
lds_role.DataObject = 'd_dddw_security_roles'
lds_role.of_SetTransObject( SQLCA )
lds_role.InsertRow( 0 )
lds_role.SetItem( 1, "role_id", li_next_role_id )
lds_role.SetItem( 1, "role_name", ls_role_name )

IF lds_role.Update() = -1 THEN
	MessageBox( "Update Error", "Update to role table failed!" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<modify> 03.13.2006 By: LiuHongXin
	//$<reason> The Goto statement is currently unsupported.
	//$<modification> Copy the script associated with the GOTO label here.
	//GOTO ERROR
	Destroy lds_actions
	Destroy lds_role
	This.SetRedraw( True )
	
	Return -1
	//---------------------------- APPEON END ----------------------------	
END IF

dw_actions.Reset()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04 
//$<modify> 02.16.2006 By: owen chen
//$<reason> Performance tuning
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
IF li_row_cnt > 0 THEN
	li_rights_id = gnv_app.of_get_id( "RIGHTS", li_row_cnt) - 1
END IF
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_row_cnt
	li_nr = dw_actions.InsertRow( 0 )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 02.16.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Comment out the following script to reduce client-server interaction.
	//$<modification> refer to PT-04 and of_get_id for more information.
	/*
	li_rights_id = gnv_app.of_get_id( "RIGHTS" )
	*/
	li_rights_id ++
	//---------------------------- APPEON END ----------------------------

	
	dw_actions.SetItem( li_nr, "security_roles_rights_rights_id", li_rights_id )
	dw_actions.SetItem( li_nr, "security_roles_rights_role_id", li_next_role_id )                                                                                                                                                                                                                                                                                    
	dw_actions.SetItem( li_nr, "security_roles_rights_action_id", lds_actions.GetItemNumber( i, "action_id" ) )
	IF lds_actions.GetItemNumber( i, "dddw_type" ) = 1 THEN
		dw_actions.SetItem( li_nr, "security_roles_rights_value_id", 1 )
	ELSE
		dw_actions.SetItem( li_nr, "security_roles_rights_value_id", 2 )
	END IF
END FOR


IF dw_actions.Update() = -1 THEN
	MessageBox( "Update Error", "Update to role table failed!" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<modify> 03.13.2006 By: LiuHongXin
	//$<reason> The Goto statement is currently unsupported.
	//$<modification> Copy the script associated with the GOTO label here.
	//GOTO ERROR
	Destroy lds_actions
	Destroy lds_role
	This.SetRedraw( True )
	
	Return -1
	//---------------------------- APPEON END ----------------------------	
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dw_select_role.SetItem( 1, "role_id", li_next_role_id )
*/
iw_win.dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
iw_win.dw_select_role.SetItem( 1, "role_id", li_next_role_id )
//---------------------------- APPEON END ----------------------------

ii_id = li_next_role_id

dw_modules.Retrieve( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
iw_win.ib_retrieve = True
iw_win.of_contract_management_rights( li_next_role_id)
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-07 By: Allen
Insert Into TDL_Security_Roles_Rights
Select :li_next_role_id, Tdl_id, 0 From TDL_Basic_info;
//---------------------------- APPEON END ----------------------------
iw_win.tab_security.tabpage_tdl.uo_tdl.of_refresh(li_next_role_id) //Add by Jack 08.28.2007

of_add_audit(ii_id, ls_role_name, "I")
dw_audit.update()

This.SetRedraw( True )

RETURN 1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03
//$<comment> 03.13.2006 By: LiuHongXin
//$<reason> The Goto statement is currently unsupported.
//$<modification> Move the scripts to the location of GOTO ERROR.
//ERROR:
//DESTROY lds_actions
//DESTROY lds_role
//This.SetRedraw( True )
//
//RETURN -1
//---------------------------- APPEON END ----------------------------

end function

public function integer of_copy_role (integer ai_role_id);//maha created 021103 

n_ds lds_actions
n_ds lds_role
Integer li_row_cnt
Integer li_nr
Integer i
Integer li_rights_id
Integer li_next_role_id
String ls_role_name
DataWindowChild dwchild
//messagebox("No role selected","Please select a role to copy.")
if ai_role_id < 1 then //variable is initialized to 1
	messagebox("No role selected","Please select a role to copy.")
	return -1
end if

Open( w_security_get_role_name )

ls_role_name = Message.StringParm

IF ls_role_name = "Cancel" THEN
	Return -1
END IF

if LenA(ls_role_name) < 1 then //maha 082203
	return -1
end if

This.SetRedraw( False )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<modify> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
SELECT Max( role_id )  
INTO :li_next_role_id  
FROM security_roles;

IF IsNull( li_next_role_id ) THEN
	li_next_role_id = 1
ELSE
	li_next_role_id ++
END IF

lds_actions = CREATE n_ds
lds_actions.DataObject = 'd_security_role_actions_4_role'
lds_actions.of_SetTransObject( SQLCA )
li_row_cnt = lds_actions.Retrieve(ai_role_id)
*/


lds_actions = CREATE n_ds
lds_actions.DataObject = 'd_security_role_actions_4_role'
lds_actions.of_SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( )

lds_actions.Retrieve(ai_role_id)
SELECT Max( role_id )  
INTO :li_next_role_id  
FROM security_roles;

gnv_appeondb.of_commitqueue( )

IF IsNull( li_next_role_id ) THEN
	li_next_role_id = 1
ELSE
	li_next_role_id ++
END IF

li_row_cnt = lds_actions.Rowcount( )

//---------------------------- APPEON END ----------------------------

lds_role = CREATE n_ds
lds_role.DataObject = 'd_dddw_security_roles'
lds_role.of_SetTransObject( SQLCA )
lds_role.InsertRow( 0 )
lds_role.SetItem( 1, "role_id", li_next_role_id )
lds_role.SetItem( 1, "role_name", ls_role_name )

IF lds_role.Update() = -1 THEN
	MessageBox( "Update Error", "Update to role table failed!" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-05
	//$<modify> 03.13.2006 By: LiuHongXin
	//$<reason> The Goto statement is currently unsupported.
	//$<modification> Copy the script associated with the GOTO label here.
	//GOTO ERROR
	Destroy lds_actions
	Destroy lds_role
	This.SetRedraw( True )
	
	Return -1
	//---------------------------- APPEON END ----------------------------
END IF

dw_actions.Reset()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
/*
li_rights_id = gnv_app.of_get_id( "RIGHTS" )
*/
IF li_row_cnt > 0 THEN
	li_rights_id = gnv_app.of_get_id( "RIGHTS" ,li_row_cnt) - 1
END IF
//---------------------------- APPEON END ----------------------------



FOR i = 1 TO li_row_cnt //for each of the original records copy and update
	lds_actions.rowscopy(i, i, primary!, lds_actions, 1000, 	primary! )
	li_nr = lds_actions.rowcount() 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-08
	//$<modify> 02.17.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Comment out the following script to reduce client-server interaction.
	//$<modification> refer to PT-07 and of_get_id for more information.
	/*
	li_rights_id = gnv_app.of_get_id( "RIGHTS" )
	*/
	li_rights_id ++
	
	//---------------------------- APPEON END ----------------------------

	lds_actions.SetItem( li_nr, "rights_id", li_rights_id )
	lds_actions.SetItem( li_nr, "role_id", li_next_role_id )                                                                                                                                                                                                                                                                                    
//lds_actions.SetItem( li_nr, "security_roles_rights_action_id", lds_actions.GetItemNumber( i, "action_id" ) )
//	IF lds_actions.GetItemNumber( i, "dddw_type" ) = 1 THEN
//		dw_actions.SetItem( li_nr, "security_roles_rights_value_id", 1 )
//	ELSE
//		dw_actions.SetItem( li_nr, "security_roles_rights_value_id", 2 )
//	END IF
END FOR

IF lds_actions.Update() = -1 THEN
	MessageBox( "Update Error", "Update to rights table failed!" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-06
	//$<modify> 03.13.2006 By: LiuHongXin
	//$<reason> The Goto statement is currently unsupported.
	//$<modification> Copy the script associated with the GOTO label here.
	//GOTO ERROR
	Destroy lds_actions
	Destroy lds_role
	This.SetRedraw( True )
	
	Return -1
	//---------------------------- APPEON END ----------------------------
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dw_select_role.SetItem( 1, "role_id", li_next_role_id )
*/

//Add by Jack 21.08.2007
gnv_appeondb.of_startqueue( )
Insert into ctx_acp_contract_management_right (role_id,category,types,rights)
  Select :li_next_role_id,b.category,b.types,b.rights From ctx_acp_contract_management_right b
  Where b.role_id = :ai_role_id;
  
Delete from tdl_security_roles_rights Where role_id = :li_next_role_id;
Insert into tdl_security_roles_rights (role_id,tdl_id,access_rights)
  Select :li_next_role_id,b.tdl_id,b.access_rights From tdl_security_roles_rights b
  Where b.role_id = :ai_role_id;
//End add 21.08.2007

iw_win.dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
iw_win.dw_select_role.SetItem( 1, "role_id", li_next_role_id )

//---------------------------- APPEON END ----------------------------

ii_id = li_next_role_id
dw_modules.Retrieve( )
COMMIT USING SQLCA;

gnv_appeondb.of_commitqueue( ) //Add by Jack 21.08.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.31.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Contract Management Rights.
iw_win.ib_retrieve = True
iw_win.of_contract_management_rights( li_next_role_id)
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-12-07 By: Allen
Insert Into TDL_Security_Roles_Rights
Select :li_next_role_id, Tdl_id, 0 From TDL_Basic_info;
//---------------------------- APPEON END ----------------------------
This.SetRedraw( True )

RETURN 1

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-07
//$<comment> 03.13.2006 By: LiuHongXin
//$<reason> The Goto statement is currently unsupported.
//$<modification> Move the scripts to the location of GOTO ERROR.
//ERROR:
//DESTROY lds_actions
//DESTROY lds_role
//This.SetRedraw( True )
//
//RETURN -1
//---------------------------- APPEON END ----------------------------


end function

public function integer of_add_audit (integer ai_role, string as_name, string as_from);long ll_recid
datetime ldt_now
string ls_new
string ls_old
integer nr

select max(rec_id) into :ll_recid from sys_audit_role;
if isnull(ll_recid) then ll_recid = 0
ldt_now = datetime(today(),now())

if as_from = "I"  then //insert
	ls_new = as_name  +  " - " + string(ai_role)
	ls_old = "Role Inserted"
elseif  as_from = "D" then  //delete 
	ls_new = "Role Deleted"
	ls_old = as_name  +  " - " + string(ai_role)
end if

nr = dw_audit.insertrow(0)
dw_audit.setitem(nr,"role_id",ai_role)
dw_audit.setitem(nr,"audit_type",as_from)
dw_audit.setitem(nr,"new_value",ls_new)
dw_audit.setitem(nr,"old_value",ls_old)
ll_recid++
dw_audit.setitem(nr,"rec_id",ll_recid)
dw_audit.setitem(nr,"date_time_modified",ldt_now)
dw_audit.setitem(nr,"mod_by",gs_user_id )	

return 1
end function

public function integer of_rename ();//Start Code Change ----10.03.2012 #V12 maha 

n_ds lds_actions
n_ds lds_role
Integer li_row_cnt
Integer li_nr
Integer i
Integer li_rights_id
Integer li_next_role_id
String ls_role_name
DataWindowChild dwchild

if ii_id = 1 then //variable is initialized to 1
	messagebox("Administrator","The Administrator role cannot be renamed.")
	return -1
end if

if ii_id < 1 then //variable is initialized to 1
	messagebox("No role selected","Please select a role to copy.")
	return -1
end if

Open( w_security_get_role_name )

ls_role_name = Message.StringParm

IF ls_role_name = "Cancel" THEN
	Return -1
END IF

if LenA(ls_role_name) < 1 then //maha 082203
	return -1
end if

update security_roles set role_name = :ls_role_name where role_id = :ii_id;


iw_win.dw_select_role.GetChild( "role_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
iw_win.dw_select_role.SetItem( 1, "role_id", ii_id)




RETURN 1



end function

public function integer of_filter_by_settings ();//Start Code Change ----11.13.2012 #V12 maha - added to filter out non-active modules
//CURRENTLY NOT WORKING
long rc
long ll_find

rc = dw_modules.rowcount()
debugbreak()
//App mapping
if of_get_app_setting("set_iapps","I") = 0 then 
	ll_find = dw_modules.find("module_id = 24", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//contracts
if of_get_app_setting("set_cont","I") = 0 then 
	ll_find = dw_modules.find("module_id = 33", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)	
end if
//contract doc create
if of_get_app_setting("set_51","I") = 0 then 
	ll_find = dw_modules.find("module_id = 60", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//contract global search
if of_get_app_setting("set_48","I") = 0 then 
	ll_find = dw_modules.find("module_id = ", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Export
if of_get_app_setting("set_iauto","I") = 0 then 
	ll_find = dw_modules.find("module_id = 10", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Import
if of_get_app_setting("set_import","I") = 0 then 
	ll_find = dw_modules.find("module_id = 66", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)	
end if
//Intellireport
if of_get_app_setting("set_ireport","I") = 0 then 
	ll_find = dw_modules.find("module_id = 28", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Peer Review
if of_get_app_setting("set_peer","I") = 0 then 
	ll_find = dw_modules.find("module_id = 31", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Privileges
if of_get_app_setting("set_priv","I") = 0 then 
	ll_find = dw_modules.find("module_id = 81", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//QA
if of_get_app_setting("set_qa","I") = 0 then 
	ll_find = dw_modules.find("module_id = 30", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Site Survey
if of_get_app_setting("set_site","I") = 0 then 
	ll_find = dw_modules.find("module_id = 14", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//WebCrawler
if of_get_app_setting("web_crawl","I") = 0 then 
	ll_find = dw_modules.find("module_id = 82", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//WebView
if of_get_app_setting("set_web","I") = 0 then 
	ll_find = dw_modules.find("module_id = 29", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if
//Workflow
if of_get_app_setting("set_47","I") = 0 then 
	ll_find = dw_modules.find("module_id = 61", 1,rc )
	if ll_find > 0 then dw_modules.setitem(ll_find, 'filtered', 1)
end if

dw_modules.setfilter("filtered = 0")
dw_modules.filter()

return 1











end function

on pfc_cst_u_security_roles_painter.create
this.dw_example=create dw_example
this.dw_audit=create dw_audit
this.cb_save=create cb_save
this.cb_print=create cb_print
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_modules=create dw_modules
this.dw_sub_modules=create dw_sub_modules
this.dw_actions=create dw_actions
this.gb_1=create gb_1
this.dw_print=create dw_print
this.Control[]={this.dw_example,&
this.dw_audit,&
this.cb_save,&
this.cb_print,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_modules,&
this.dw_sub_modules,&
this.dw_actions,&
this.gb_1,&
this.dw_print}
end on

on pfc_cst_u_security_roles_painter.destroy
destroy(this.dw_example)
destroy(this.dw_audit)
destroy(this.cb_save)
destroy(this.cb_print)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_modules)
destroy(this.dw_sub_modules)
destroy(this.dw_actions)
destroy(this.gb_1)
destroy(this.dw_print)
end on

event constructor;dw_actions.of_SetTransObject( SQLCA )
dw_modules.of_SetTransObject( SQLCA )
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 12.12.2006 By: Jack
//$<reason> The Selected Role Group Box should be moved to above the Tab Folder.
/*
dw_select_role.of_SetTransObject( SQLCA )
*/
//---------------------------- APPEON END ----------------------------
dw_sub_modules.of_SetTransObject( SQLCA )


IF w_mdi.of_security_access( 540 ) = 1 THEN
	dw_actions.Object.DataWindow.ReadOnly = 'Yes'
ELSE
	dw_actions.Object.DataWindow.ReadOnly = 'No'
END IF
end event

type dw_example from datawindow within pfc_cst_u_security_roles_painter
integer width = 1627
integer height = 88
integer taborder = 90
boolean enabled = false
string title = "none"
string dataobject = "d_role_setting_example"
boolean livescroll = true
end type

event constructor;this.insertrow(1)
end event

type dw_audit from datawindow within pfc_cst_u_security_roles_painter
boolean visible = false
integer x = 50
integer y = 1444
integer width = 1577
integer height = 128
integer taborder = 70
string title = "none"
string dataobject = "d_role_audit_add"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_save from u_cb within pfc_cst_u_security_roles_painter
integer x = 2670
integer width = 338
integer taborder = 60
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Integer li_retval

li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF

gnv_app.of_setcontraccache_code_lookup(True)		//Added By Scofield on 2008-01-06

end event

type cb_print from u_cb within pfc_cst_u_security_roles_painter
integer x = 2322
integer width = 338
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Print"
end type

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF ii_id < 1 or isnull(ii_id ) THEN
	messagebox('Alert','Please first select a role.')
	return 
END IF
//---------------------------- APPEON END ----------------------------


openwithparm(w_print_report,ii_id)

//dw_print.settransobject(sqlca)
//dw_print.retrieve(ii_id)
//dw_print.print()
end event

type st_3 from statictext within pfc_cst_u_security_roles_painter
integer x = 1783
integer y = 148
integer width = 325
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
string text = "Access"
boolean focusrectangle = false
end type

type st_2 from statictext within pfc_cst_u_security_roles_painter
integer x = 923
integer y = 148
integer width = 325
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
string text = "Function"
boolean focusrectangle = false
end type

type st_1 from statictext within pfc_cst_u_security_roles_painter
integer x = 64
integer y = 148
integer width = 247
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
string text = "Module"
boolean focusrectangle = false
end type

type dw_modules from u_dw within pfc_cst_u_security_roles_painter
integer x = 32
integer y = 208
integer width = 896
integer height = 1372
integer taborder = 70
string dataobject = "d_security_modules"
boolean hscrollbar = true
end type

event constructor;This.of_SetUpdateAble( False )


end event

event retrieveend;call super::retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<reason> The RowFocusChanges event has already retrieved data for dw_sub_modules.
//$<modification> Comment out the script to retrieve data for dw_sub_modules.
/*
This.SelectRow( 1, True )

IF rowcount > 0 THEN
	dw_sub_modules.Retrieve( This.GetItemNumber( 1, "module_id" ) )
END IF
*/

IF rowcount > 0 THEN
	This.SelectRow( 1, True )
END IF

//---------------------------- APPEON END ----------------------------


end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow()
IF li_row > 0 THEN
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
This.SelectRow( currentrow, True )

IF This.RowCount() > 0 THEN
	Parent.SetRedraw( False )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.26.2006 By: LeiWei
	//$<reason> Fix a defect.
	dw_sub_modules.Reset()
	dw_actions.Reset()
	//---------------------------- APPEON END ----------------------------

	dw_sub_modules.Retrieve( This.GetItemNumber( currentrow, "module_id" ) )
	Parent.SetRedraw( True )
END IF



end event

event rowfocuschanging;call super::rowfocuschanging;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 03.03.2006 By: owen chen
//$<reason> Performance tuning.
//$<modification> RowFocusChanging will not be triggered by ItemChanged.
//$<modification> Refer to PT-13 for more information.
/*
Integer li_retval
li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF
*/
Integer li_retval
If ib_1 Then
	ib_1 = false
	return
End If
li_retval = iw_win.Event pfc_save()
IF li_retval < 0 THEN
	Return 1
END IF
//---------------------------- APPEON END ----------------------------


end event

event retrievestart;call super::retrievestart;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2006 By: LeiWei
//$<reason> Fix a defect
This.Reset( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.17.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
String ls_filter
IF gb_contract_version THEN
	ls_filter = "prod_id = 1"
END IF

IF gnv_data.of_GetItem("icred_settings", "set_47", False) = '0' THEN
	//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
	//Fixed bug - jervis 06.24.2010
	/*	IF ls_filter = "" THEN
		ls_filter = "Module_name <> 'WorkFlow Painter' and Module_name <> 'Email Painter'"
	ELSE
		ls_filter += " and Module_name <> 'WorkFlow Painter' and Module_name <> 'Email Painter'"
	END IF*/
	IF ls_filter = "" THEN
		//ls_filter = "Module_name <> 'WorkFlow Painter' "
		ls_filter = "module_id <> 61 " //BugE112901 - Eugene 11.29.2013
	ELSE
		//ls_filter += " and Module_name <> 'WorkFlow Painter' "
		ls_filter += " and module_id <> 61 " //BugE112901 - Eugene 11.29.2013
	END IF
	//---------End Modfiied ------------------------------------------------------
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.27.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Making the Contract Module a Standalone Product
If gb_agreement_manager = False Or gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '0' Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.25.2007 By: Jack
	//$<reason> 
	/*
	If ls_filter = '' Then
		ls_filter = "module_id not in (58,59,60) "
	Else
		ls_filter += " and module_id not in (58,59,60) "
	End If
	*/
	If gnv_data.of_getitem( "icred_settings", "set_51", FALSE) = '3' Then
		If ls_filter = '' Then
			ls_filter = "module_id not in (58,59) "
		Else
			ls_filter += " and module_id not in (58,59) "
		End If
	Else
		If ls_filter = '' Then
			ls_filter = "module_id not in (58,59,60) "
		Else
			ls_filter += " and module_id not in (58,59,60) "
		End If
	End If		
	//---------------------------- APPEON END ----------------------------	
End If
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.22.2007 By: Frank.Gui
//$<reason> WebView Required Document Template Painter security settings.
IF gnv_data.of_getitem( "icred_settings", "set_9", FALSE)="4" THEN//IntelliContract=4
	If ls_filter = '' Then
		ls_filter = "module_id <> 65 "
	Else
		ls_filter += " and module_id <> 65"
	End If
END IF
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Evan 05.21.2009
//$<reason> Corrected BugA101303
if of_get_app_setting("set_9", "I") <> 4 and of_get_app_setting("set_cont", "I") <> 0  then // IntelliCred/App and Contract 
elseif of_get_app_setting("set_9", "I") <> 4 then 	// IntelliCred/App 
	if LenA(ls_Filter) > 0 then ls_Filter += " and "
	ls_Filter += "module_id not in (33,53,54,56,57,58,59,60,67, 72) " //for BugT111801 - Eugene 11.29.2013
	//ls_Filter += "module_id not in (33,53,54,56,60,65,67)"
elseif of_get_app_setting("set_cont", "I") <> 0 then 	//IntelliContract 
end if
//------------------- APPEON END ---------------------

IF ls_filter<> "" THEN THIS.Setfilter(ls_filter)
//---------------------------- APPEON END ----------------------------


end event

type dw_sub_modules from u_dw within pfc_cst_u_security_roles_painter
integer x = 937
integer y = 208
integer width = 891
integer height = 1372
integer taborder = 100
string dataobject = "d_security_sub_modules"
boolean hscrollbar = true
end type

event constructor;This.of_SetUpdateAble( False )


end event

event retrieveend;call super::retrieveend;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<reason> The RowFocusChanges event has already retrieved data for dw_actions.
//$<modification> Comment out the script to retrieve data for dw_actions.
/*
This.SelectRow( 1, True )

IF rowcount > 0 THEN
	dw_actions.Retrieve( ii_id, This.GetItemNumber( 1, "sub_module_id" ) )
END IF
*/

IF rowcount > 0 THEN
	This.SelectRow( 1, True )
END IF

//---------------------------- APPEON END ----------------------------


end event

event rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
This.SelectRow( currentrow, True )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 03.03.2006 By: owen chen
//$<reason> Performance tuning.
//$<modification> RowFocusChanging will not be triggered by ItemChanged.
//$<modification> Refer to PT-13 for more information.
/*
IF of_save() = -1 THEN
	Return 1
END IF
*/
If ib_2 Then
	ib_2 = false
Else
	IF of_save() = -1 THEN
		Return 1
	END IF
End If

//---------------------------- APPEON END ----------------------------

IF This.RowCount() > 0 THEN
	dw_actions.Retrieve( ii_id, This.GetItemNumber( currentrow, "sub_module_id" ) )
END IF



end event

event retrievestart;call super::retrievestart;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2006 By: LeiWei
//$<reason> Fix a defect.
This.Reset( )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.17.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
//IF gb_contract_version THEN
//	THIS.Setfilter("prod_id = 1")
//END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.27.2006 By: Jack (IntelliContract Agreement Manager Painters)
//$<reason> Making the Contract Module a Standalone Product
string ls_filter
If gb_agreement_manager = False Or gnv_data.of_getitem('icred_settings' ,'set_cont' , False ) = '0' Then
	If long(gnv_data.of_getitem( "icred_settings", "set_51", FALSE)) = 0  Then
		ls_filter = "sub_module_id not in (370,583) "
	Else
		ls_filter = "sub_module_id not in (583) "
	End If
	If gb_contract_version = True Then
		ls_filter = ls_filter + " and prod_id = 1"
	End If
Else
	If gb_contract_version = True Then
		ls_filter = "prod_id = 1"
	End If	
End If

//------------------- APPEON BEGIN -------------------
//$<add> Evan 05.21.2009
//$<reason> Corrected BugA101303
if of_get_app_setting("set_9", "I") <> 4 and of_get_app_setting("set_cont", "I") <> 0  then
	// IntelliCred/App and Contract module
elseif of_get_app_setting("set_9", "I") <> 4 then
	// IntelliCred/App module (Do not show contract sub modules)
	if LenA(ls_Filter) > 0 then ls_Filter += " and "
	ls_Filter += "sub_module_id not in (521,650)"
elseif of_get_app_setting("set_cont", "I") <> 0 then
	// Contract module
end if
//------------------- APPEON END ---------------------

This.setfilter(ls_filter)
//---------------------------- APPEON END ----------------------------

end event

type dw_actions from u_dw within pfc_cst_u_security_roles_painter
integer x = 1838
integer y = 208
integer width = 1189
integer height = 1372
integer taborder = 110
string dataobject = "d_security_actions"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.26.2006 By: LeiWei
//$<reason> Fix a defect.
IF currentrow <=0 THEN RETURN
//---------------------------- APPEON END ----------------------------

This.SelectRow( 0, False )
This.SelectRow( currentrow, True )


end event

event retrieveend;call super::retrieveend;Integer i
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.12.2007 By: Jack (Document Manager)
//$<reason> 
/*
IF rowcount > 0 THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.26.2006 By: LeiWei
	//$<reason> Fix a defect.
	This.SelectRow( 0, False )
	//---------------------------- APPEON END ----------------------------

	This.SelectRow( 1, True )
	
	FOR i = 1 TO rowcount
		IF This.GetItemNumber( i, "dddw_type" ) = 1 THEN
			This.SetItem( i, "value_id_1", This.GetItemNumber( i, "security_roles_rights_value_id" ) )
		ELSE
			This.SetItem( i, "value_id_2", This.GetItemNumber( i, "security_roles_rights_value_id" ) )
		END IF
	END FOR	
END IF
*/

long ll_rowcount
ll_rowcount = this.rowcount()

IF ll_rowcount > 0 THEN

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 09.26.2006 By: LeiWei
	//$<reason> Fix a defect.
	This.SelectRow( 0, False )
	//---------------------------- APPEON END ----------------------------

	This.SelectRow( 1, True )
	
	FOR i = 1 TO ll_rowcount
		IF This.GetItemNumber( i, "dddw_type" ) = 1 THEN
			This.SetItem( i, "value_id_1", This.GetItemNumber( i, "security_roles_rights_value_id" ) )
		ELSE
			This.SetItem( i, "value_id_2", This.GetItemNumber( i, "security_roles_rights_value_id" ) )
		END IF
	END FOR	
END IF

//---------------------------- APPEON END ----------------------------

This.AcceptText()


end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow()
IF li_row > 0 THEN
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
END IF
end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer li_row_cnt
integer nr //maha 05.15.2009
string ls_new  //maha 05.15.2009
string ls_old  //maha 05.15.2009
long ll_recid  //maha 05.15.2009
datetime ldt_now  //maha 05.15.2009

li_row_cnt = This.RowCount()
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.26.2006 By: LeiWei
//$<reason> Fix a defect.
This.SelectRow( 0, False )
//---------------------------- APPEON END ----------------------------
This.SelectRow( 1, True )
FOR i = 1 TO li_row_cnt
	IF This.GetItemNumber( i, "dddw_type" ) = 1 THEN
		This.SetItem( i, "security_roles_rights_value_id", This.GetItemNumber( i, "value_id_1" ) )
	ELSE
		This.SetItem( i, "security_roles_rights_value_id", This.GetItemNumber( i, "value_id_2" ) )
	END IF
END FOR	

this.accepttext()

//Start Code Change ----06.15.2009 #V92 maha - role audit functionality for ameripath
select max(rec_id) into :ll_recid from sys_audit_role;
if isnull(ll_recid) then ll_recid = 0
ldt_now = datetime(today(),now())

FOR i = 1 TO li_row_cnt
	ls_new = string(this.getitemnumber(i,"security_roles_rights_value_id"))
	ls_old = string(this.getitemnumber(i,"security_roles_rights_value_id",primary!,true))
	if ls_old <> ls_new then
	//if this.getitemstatus( i, "security_roles_rights_value_id", primary!) = datamodified! then
		nr = dw_audit.insertrow(0)
		dw_audit.setitem(nr,"role_id",this.getitemnumber(i,"security_roles_rights_role_id"))
		dw_audit.setitem(nr,"mod_id",this.getitemnumber(i,"module_id"))
		dw_audit.setitem(nr,"sub_id",this.getitemnumber(i,"sub_module_id"))
		dw_audit.setitem(nr,"action_id",this.getitemnumber(i,"action_id"))
		dw_audit.setitem(nr,"audit_type","E")

		dw_audit.setitem(nr,"new_value",ls_new)
		dw_audit.setitem(nr,"old_value",ls_old)
		ll_recid++
		dw_audit.setitem(nr,"rec_id",ll_recid)
		dw_audit.setitem(nr,"date_time_modified",ldt_now)
		dw_audit.setitem(nr,"mod_by",gs_user_id )		
	end if
END FOR	
//End Code Change---06.15.2009



RETURN AncestorReturnValue
end event

event itemchanged;call super::itemchanged;IF This.GetItemNumber( row, "dddw_type" ) = 1 THEN
	This.SetItem( row, "security_roles_rights_value_id", Integer( data ) )
ELSE
	This.SetItem( row, "security_roles_rights_value_id", Integer(data ) )
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.25.2007 By: Jack 
//$<reason> Fix a defect.
ib_update = True
//---------------------------- APPEON END ----------------------------

end event

event retrievestart;call super::retrievestart;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.19.2006 By: LeiWei
//$<reason> Fix a defect.
This.Reset( )
//---------------------------- APPEON END ----------------------------
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2007 By: Jack (Document Manager)
//$<reason> 
string ls_filter
If long(gnv_data.of_getitem( "icred_settings", "set_51", FALSE)) = 3  Then
	ls_filter = "security_roles_rights_rights_id not in (7402) "
ElseIf long(gnv_data.of_getitem( "icred_settings", "set_51", FALSE)) = 2  Then
	ls_filter = "security_roles_rights_rights_id not in (7401) "
End If
This.setfilter(ls_filter)

//---------------------------- APPEON END ----------------------------

end event

event pfc_postupdate;call super::pfc_postupdate;//Start Code Change ----05.15.2009 #V92 maha - role audit functionality for ameripath
dw_audit.update()
//End Code Change---05.15.2009

return 1
end event

type gb_1 from groupbox within pfc_cst_u_security_roles_painter
integer y = 96
integer width = 3040
integer height = 1492
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Role Settings"
end type

type dw_print from datawindow within pfc_cst_u_security_roles_painter
integer x = 2446
integer y = 16
integer width = 119
integer height = 56
integer taborder = 80
string dataobject = "d_role_print"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

