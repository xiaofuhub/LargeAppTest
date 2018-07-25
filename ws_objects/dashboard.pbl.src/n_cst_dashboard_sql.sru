$PBExportHeader$n_cst_dashboard_sql.sru
$PBExportComments$Sql of To Do List
forward
global type n_cst_dashboard_sql from nonvisualobject
end type
end forward

global type n_cst_dashboard_sql from nonvisualobject autoinstantiate
end type

type variables
string is_init
string is_sql_statments[]
end variables

forward prototypes
public function integer of_execute (string as_sql)
public subroutine of_execute_sqls ()
public subroutine of_update_version_7 ()
end prototypes

public function integer of_execute (string as_sql);string ls_sql

ls_sql = as_sql
//sle_1.text = ls_sql
execute immediate :ls_sql using sqlca;
commit using sqlca;

return 1
end function

public subroutine of_execute_sqls ();/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_i
string ls_null[]
boolean lb_ref_cache

IF UPPERBOUND(is_sql_statments) > 0 THEN  lb_ref_cache  = true

IF UPPERBOUND(is_sql_statments) > 0 THEN 
	   is_sql_statments[upperbound(is_sql_statments) + 1] = "commit;"

		if Not isvalid( w_infodisp ) then open(w_infodisp)

		if isvalid(w_infodisp) then w_infodisp.title = 'Creating Work Flow Module tables, Please stand by'
		if isvalid(w_infodisp) then w_infodisp.Center = TRUE
		if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating Work Flow Module Tabels, Please stand by for version 7.0: ' 
		if isvalid(w_infodisp) then w_infodisp.wf_set_min_max(1,upperbound(is_sql_statments))
		
		
		gnv_appeondb.of_startqueue( )
		
		FOR ll_i = 1 TO upperbound(is_sql_statments)
			if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Modification:' +string(ll_i) +' of '+ string(upperbound(is_sql_statments)) +' Please stand by!'
				 EXECUTE IMMEDIATE :is_sql_statments[LL_I] using sqlca;
				 IF LenA(sqlca.sqlerrtext) > 0 THEN
					// Added by Davis 11.14.2006
					IF handle(getapplication()) = 0 THEN
//						messagebox(string(LL_I), string(sqlca.sqlerrtext)  + new_line + error.object + new_line +    string(is_sql_statments[LL_I]) + new_line + "Please contact software vendor."   )
					END IF
					// Added by Davis 11.14.2006

					else
				  commit;
					
				END IF
				if isvalid(w_infodisp) then w_infodisp.wf_step_pbar(1)
		NEXT
		
		gnv_appeondb.of_commitqueue( )
		
		if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Commiting modifications Please stand by!'
		
      if isvalid(w_infodisp) then close(w_infodisp)
	    
END IF


is_sql_statments = ls_null

return 
end subroutine

public subroutine of_update_version_7 ();//This function contained all db updates for workflow
String ls_sql
//Update the secuity
Long ll_Module_id

if Not isvalid( w_infodisp ) then open(w_infodisp)

if isvalid(w_infodisp) then w_infodisp.title = 'Creating To Do List tables, Please stand by'
if isvalid(w_infodisp) then w_infodisp.Center = TRUE
if isvalid(w_infodisp) then w_infodisp.st_complete.visible = false
if isvalid(w_infodisp) then w_infodisp.st_3.visible = false
if isvalid(w_infodisp) then w_infodisp.st_information.visible = false
if isvalid(w_infodisp) then w_infodisp.st_1.text = 'Creating security roles for To Do List module, Please stand by for version 7.0: '

//Update secuity Rights
Select Count(*) Into :ll_Module_id From security_modules Where module_name = 'To Do List';
If ll_Module_id = 0 Then
	//To Do List Painter
	ls_sql = "Insert Into security_modules Values(63, 0,'To Do List Painter', 1)"
	of_execute(ls_sql)
	ls_sql = "Insert Into security_sub_module Values(602, 63, 'Main', 1)"
	of_execute(ls_sql)
	ls_sql = "Insert Into security_rights_action Values(5840, 63, 602, 'View Rights', 2)"
	of_execute(ls_sql)

	//To Do List
	ls_sql = "Insert Into security_modules Values(64, 0,'To Do List', 1)"
	of_execute(ls_sql)
	ls_sql = "Insert Into security_sub_module Values(603, 64, 'Main', 1)"
	of_execute(ls_sql)
	ls_sql = "Insert Into security_rights_action Values(5850, 64, 603, 'View Rights', 2)"
	of_execute(ls_sql)
	
	n_ds ds_roles, lds_rolerights
	Integer li_rows, i
	Long ll_roleid, ll_maxid, ll_found
	String ls_new_syntax, ls_error
	
	ds_roles = Create n_ds
	ds_roles.DataObject = "d_roles"
	ds_roles.SetTransObject( SQLCA )
	
	lds_rolerights = Create n_ds
	ls_sql = "select security_roles_rights.role_id, security_roles_rights.action_id from security_roles_rights "
	ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
	lds_rolerights.Create( ls_new_syntax, ls_error )
	lds_rolerights.SetTransObject(SQLCA)
	
	gnv_appeondb.of_startqueue()
	ds_roles.Retrieve()
	lds_rolerights.Retrieve()
	Select Max( rights_id ) Into :ll_maxid From security_roles_rights;
	gnv_appeondb.of_commitqueue()
	
	If IsNull( ll_maxid ) Then ll_maxid = 0;
	li_rows = ds_roles.RowCount()
	
	For i = 1 To li_rows
		ll_roleid = ds_roles.GetItemNumber( i, "role_id" )
		//To Do List Painter
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5840", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid ++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5840, 2);" )
		End If
		//To Do List
		ll_found = lds_rolerights.Find( "role_id = " + String( ll_roleid ) + " and action_id = 5850", 1, lds_rolerights.RowCount() )
		If ll_found < 1 Then
			ll_maxid++
			of_execute( "insert security_roles_rights( rights_id, role_id, action_id, value_id ) values( " + String( ll_maxid ) +  ", " + String( ll_roleid ) + ", 5850, 2);" )
		End If
	Next
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 01.27.2007 By: Jack (Document Manager)
	//$<reason> Fix a defect.
	UPDATE ids SET rights_id = :ll_maxid;	
	//---------------------------- APPEON END ----------------------------	
	Destroy( ds_roles );
	Destroy( lds_rolerights );
End If

//1. To Do List table
ls_sql = "Create Table TDL_Basic_info( &
TDL_ID 		Integer Not Null, &
TDL_Name 	Varchar(100) Not Null, &
Module 		VarChar(2) Not Null,	&
Notes 		Varchar(250) Null,	&
CONSTRAINT pk_TDL_Basic_info PRIMARY KEY (TDL_ID) &
);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Create Unique Index todolist_id_x on TDL_Basic_info(TDL_ID);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//1. To Do List Detail table
ls_sql = " &
Create Table TDL_Detail( &
TDL_ID 			Integer	Not Null, &
TDLI_ID 		Integer	Not Null, &
TDLI_Name 		Varchar(100)	Null, &
TDL_Sort		Integer	Not Null,	 &
Verbiage 		Varchar(255)	Not Null, &
Notes 			Text	Null, &
Allow_Drill_Down 	VarChar(1)	Default '1', &
Include_In_Graph 	VarChar(1)	Default '0', &
Action_Type 		Numeric(6,0) Null,	 &
Action_Status 		Numeric(6,0) Null,	 &
Print_Flag		Integer	Null,		 &
Due_Date		Integer	Null,		 &
Max_Sends_Flag		VarChar(1)	Default '0', &
Display01		VarChar(50)	Null, &
Updateable01		VarChar(1)	Null,	 &
Display02		VarChar(50)	Null, &
Updateable02		VarChar(1)	Null, &
Display03		VarChar(50)	Null, &
Updateable03		VarChar(1)	Null, &
Display04		VarChar(50)	Null, &
Updateable04		VarChar(1)	Null, &
Display05		VarChar(50)	Null, &
Updateable05		VarChar(1)	Null, &
Display06		VarChar(50)	Null, &
Updateable06		VarChar(1)	Null, &
Display07		VarChar(50)	Null, &
Updateable07		VarChar(1)	Null, &
Display08		VarChar(50)	Null, &
Updateable08		VarChar(1)	Null, &
Display09		VarChar(50)	Null, &
Updateable09		VarChar(1)	Null, &
Display10		VarChar(50)	Null, &
Updateable10		VarChar(1)	Null, &
Display11		VarChar(50)	Null, &
Updateable11		VarChar(1)	Null, &
Display12		VarChar(50)	Null, &
Updateable12		VarChar(1)	Null, &
MoveTo			VarChar(2)	Null,	 &
Perform			VarChar(2)	Null,	 &
CONSTRAINT pk_TDL_Detail PRIMARY KEY(TDL_ID, TDLI_ID) &
);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

ls_sql = "Create UNIQUE INDEX TDL_Detail_x on TDL_Detail(TDL_ID, TDLI_ID);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//3. Right of roles
ls_sql = "&
Create Table TDL_Security_Roles_Rights(&
ROLE_ID   	Integer Not Null,&
TDL_ID	 	Integer Not Null,&
Access_Rights  	Integer Not Null Default 0,&
CONSTRAINT pk_TDL_Security_Roles_Rights PRIMARY KEY(ROLE_ID, TDL_ID)&
);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Create UNIQUE INDEX TDL_Security_Roles_Rights_x on TDL_Security_Roles_Rights(ROLE_ID, TDL_ID);"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//4. Alter User Table of TDL Access
ls_sql = "Alter table Security_users Add TDL_Rights Integer Default 0"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Alter table Security_users Add TDL_Other_user Varchar(10) null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "Update Security_users Set TDL_Rights = 0 Where TDL_Rights Is Null"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//5. Update TDL Role Rights data
ls_sql = "Insert Into TDL_Security_Roles_Rights &
Select b.Role_id, a.Tdl_id, 0 From TDL_Basic_info a, Security_roles b"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//6. Ones we create and include in "Clean Database" the default access to these will be set to ON
ls_sql = "Update icred_settings Set set_49 = 1;"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

//7. Add FOREIGN KEY
ls_sql = "ALTER TABLE TDL_detail ADD CONSTRAINT FK_Tdl_detail_tdl_id FOREIGN KEY (tdl_id) REFERENCES tdl_basic_info"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql
ls_sql = "ALTER TABLE TDL_Security_Roles_Rights ADD CONSTRAINT FK_TDL_Security_Roles_Rights_tdl_id FOREIGN KEY (tdl_id) REFERENCES tdl_basic_info"
is_sql_statments[upperbound(is_sql_statments)+1] = ls_sql

of_execute_sqls()
end subroutine

on n_cst_dashboard_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dashboard_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

