$PBExportHeader$n_cst_role_right_sql.sru
$PBExportComments$Sql of Role Right
forward
global type n_cst_role_right_sql from nonvisualobject
end type
end forward

global type n_cst_role_right_sql from nonvisualobject autoinstantiate
end type

type variables
string is_init
string is_sql_statments[]
end variables

forward prototypes
public function integer of_execute (string as_sql)
public subroutine of_execute_sqls ()
public subroutine of_update_version_70 ()
public subroutine of_update_version_60 ()
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

public subroutine of_update_version_70 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_role_right_sqlof_update_version_7()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007.09.18 by Jack
//////////////////////////////////////////////////////////////////////

//Update secuity Rights
//To Do List Painter
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_modules Values(63, 0,'To Do List Painter', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_sub_module Values(602, 63, 'Main', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_rights_action Values(5840, 63, 602, 'View Rights', 2);"

//To Do List
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_modules Values(64, 0,'To Do List', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_sub_module Values(603, 64, 'Main', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_rights_action Values(5850, 64, 603, 'View Rights', 2);"

//Four new records used for the role rights of Letter Storage Area Painter.
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_modules( module_id, software_version, module_name) values( 51, 4, 'Letter Storage Area Painter' ); " 
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 510, 51, 'Main' );" 
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5010, 51, 510, 'View Rights', 2 );" 

//Fix a defect that no rights data for Question Painter.
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_modules( module_id, software_version, module_name) values( 34, 4, 'Question Painter' ); " 
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 420, 34, 'Main' );" 
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2210, 34, 420, 'Access Rights', 1 );" 

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 128, 2, 5, 'Attest Quest Full Access', 1 );" 

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_modules(module_id,software_version,module_name,prod_id) values (65,4,'WebView Required Documents Template Painter',1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( sub_module_id, module_id,sub_module_name,prod_id ) VALUES ( 604, 65,'Main',1 ) ;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id,sub_module_id,action_name,dddw_type ) values(6927,65,604,'View Rights',1 );"

IF gs_dbtype = "SQL" THEN
	is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2076, 33, 290, 'Global Search', 2 ); "
END IF

//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6800,6801,6802,6803);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 58, 4, 'Clause Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values ( 58, 580, 'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6800, 58, 580, 'View Rights', 2 );"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 59, 4, 'Template Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 59,581,  'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6801, 59, 581, 'View Rights', 2 );"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version,module_name ,prod_id) values ( 60, 4, 'Document Library Painter',1 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values (  60, 582,'Main' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6802, 60, 582, 'View Rights', 2 );"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 9,583, 'Contract Management Rights' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6803, 9, 583, 'View Rights', 2 );"

is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_modules ( module_id, software_version,module_name ,prod_id) Values (61, 0,'Work Flow Painter', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) Values (61,600, 'Main', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) Values(5830, 61, 600, 'View Rights', 2);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_modules ( module_id, software_version,module_name ,prod_id) Values (62, 0,'Email Painter', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  Values ( 62, 601,'Main', 1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "Insert Into security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) Values(5831, 62, 601, 'View Rights', 2);"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (5831);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET sub_module_name = 'Document Manager' WHERE sub_module_id = 370;"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6901, 33, 370, 'Add Buy', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6902, 33, 370, 'Add Sell', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6903, 33, 370, 'Properties', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6904, 33, 370, 'Report', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6905, 33, 370, 'Email', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6906, 33, 370, 'Output->Print', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6907, 33, 370, 'Output->Email', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6909, 33, 370, 'Output->Save to File', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6910, 33, 370, 'Check In', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6911, 33, 370, 'Check Out', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6912, 33, 370, 'Save', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6913, 33, 370, 'Add Clause', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6914, 33, 370, 'Merge Field', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6915, 33, 370, 'Merge Data', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6916, 33, 370, 'Work Flow', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6917, 33, 370, 'Clause Map', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6918, 33, 370, 'Add Action Item', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6919, 33, 370, 'Delete Action Item', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6920, 33, 370, 'Print Letters', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6921, 33, 370, 'Revision Control', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6922, 33, 370, 'Delete Document', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6925, 33, 370, 'Modify Other Users AI', 2 );"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6926, 33, 370, 'Add Other', 2 );"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6901,6902,6903,6904,6905,6906,6907,6908,6909,6910,6911,6912,6913,6914,6915,6916,6917,6918,6919,6920,6921,6922,6925,6926);"

is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 25,552,  'User ID Batch Update' ,1);"
is_sql_statments[upperbound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5511, 25, 552, 'View Rights', 2 );"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (5511);"

is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 66, 4, 'Import Painter', 1);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 66, 605, 'Main', 1);"
is_sql_statments[UpperBound(is_sql_statments) + 1] = "INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6928, 66, 605, 'View Rights', 2);"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6928);"

of_execute_sqls()

datastore lds_actions,lds_roles,lds_rights
string ls_filter,ls_find
long i,j,k,ll_module_id[],ll_sub_module_id[]
long ll_find,ll_module_id1,ll_sub_module_id1,ll_role_id,ll_action_id,ll_rights_id
long ll_row,ll_action_rowcount,ll_role_rowcount,ll_right_rowcount

lds_actions = CREATE datastore
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.SetTransObject( SQLCA )

lds_roles = CREATE datastore
lds_roles.dataobject = 'd_security_roles_new'
lds_roles.settransobject(sqlca)

lds_rights = CREATE datastore
lds_rights.dataobject = 'd_security_roles_rights_new'
lds_rights.settransobject(sqlca)

lds_actions.retrieve()
lds_roles.retrieve()
lds_rights.retrieve()
Select Max( rights_id ) Into :ll_rights_id From security_roles_rights;

If IsNull( ll_rights_id ) Then ll_rights_id = 0;
ll_role_rowcount = lds_roles.rowcount()
ll_right_rowcount = lds_rights.rowcount()

ll_module_id[upperbound(ll_module_id) + 1] = 63	 //To Do List Painter
ll_module_id[upperbound(ll_module_id) + 1] = 64	 //To Do List
ll_module_id[upperbound(ll_module_id) + 1] = 51	 //Letter Storage Area Painter
ll_module_id[upperbound(ll_module_id) + 1] = 34	 //Question Painter
ll_module_id[upperbound(ll_module_id) + 1] = 2	 //Practitioner Folder
ll_module_id[upperbound(ll_module_id) + 1] = 65	 //WebView Required Document Template
ll_module_id[upperbound(ll_module_id) + 1] = 58  //Clause Library Painter
ll_module_id[upperbound(ll_module_id) + 1] = 59  //Template Library Painter
ll_module_id[upperbound(ll_module_id) + 1] = 60  //Document Library Painter
ll_module_id[upperbound(ll_module_id) + 1] = 9  //Roles Painter
ll_module_id[upperbound(ll_module_id) + 1] = 61  //Work Flow Painter
ll_module_id[upperbound(ll_module_id) + 1] = 62  //Email Painter
ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract
ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
ll_module_id[upperbound(ll_module_id) + 1] = 66	 //Import Painter

ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 602	//Main 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 603	//Main 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 510	//Main 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 402	//Main 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 5	//Appointment Status 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 604	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 580	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 581	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 582	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 583	//Contract Management Rights
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 600	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 601	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 370	//Document Manager
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 552	//User ID Batch Update
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 605	//Main

For i = 1 To upperbound(ll_module_id)
	ll_module_id1 = ll_module_id[i]
	ll_sub_module_id1 = ll_sub_module_id[i]
	ls_filter = "module_id = " + string(ll_module_id1) + " And sub_module_id = " + string(ll_sub_module_id1)
	lds_actions.setfilter(ls_filter)
	lds_actions.filter()
	ll_action_rowcount = lds_actions.rowcount()
	For j = 1 To ll_role_rowcount
		ll_role_id = lds_roles.getitemnumber(j,'role_id')				
		For k = 1 To ll_action_rowcount
			ll_action_id = lds_actions.getitemnumber(k,'action_id')
			ls_find = "role_id = " + string(ll_role_id) + " and action_id = " + string(ll_action_id)
			ll_find = lds_rights.find(ls_find,1,ll_right_rowcount)
			If ll_find < 1 Then
				ll_row = lds_rights.insertrow(0)
				ll_rights_id ++
				lds_rights.setitem(ll_row,'rights_id',ll_rights_id)
				lds_rights.setitem(ll_row,'role_id',ll_role_id)
				lds_rights.setitem(ll_row,'action_id',ll_action_id)
				lds_rights.setitem(ll_row,'value_id',2)
			End If
		Next
	Next
Next
lds_rights.update()
UPDATE ids SET rights_id = :ll_rights_id;	

Destroy lds_actions
Destroy lds_roles
Destroy lds_rights








end subroutine

public subroutine of_update_version_60 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_role_right_sqlof_update_version_7()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007.09.18 by Jack
//////////////////////////////////////////////////////////////////////


is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5820, 1, 1, 'Print/Export Search Results', 1 );" 

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 520, 'Application Status'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5200, 3, 520, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 521, 'Contracts'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5210, 3, 521, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 53, 4, 'Screen Painter - Contract'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 530, 'Main'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5300, 53, 530, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 531, 'View Manager'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5310, 53, 531, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 532, 'Field Properties'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5320, 53, 532, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 533, 'Screen Parameters'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5330, 53, 533, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 54, 4, 'View Painter - Contract'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 54, 540, 'Main'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5400, 54, 540, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 550, 'Scan OIG'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5500, 25, 550, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 551, 'Import OIG'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5510, 25, 551, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 56, 4, 'Contract Requirement Profile'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 56, 560, 'Main'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5600, 56, 560, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_modules( module_id, software_version, module_name ) values( 57, 4, 'Code Import (CPT Code)'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 57, 570, 'Main'); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5700, 57, 570, 'View Rights', 2 ); "

is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set prod_id = 1 Where module_id in(3,5,53,9,10,11,13,16,19,23,25,28,33,54,56,57,51); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_sub_module Set prod_id = 1 Where sub_module_id in(521,15,530,531,532,533,28,29,30,32,35,540,37,60,80,150,170,290,300,310,320,330,340,350,360,370,380,390,400,430,560,570,510); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET SUB_MODULE_NAME = 'Fee Schedules' where SUB_MODULE_ID = 360 ; "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set module_name = 'Screen Painter - Prac Data' Where module_id = 6; "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set module_name = 'View Painter - Prac Data' Where module_id = 18; "

is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5800, 25, 150, 'Practitioner Data', 2 ) "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5810, 25, 150, 'Contract Data', 2 ); "
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2075, 33, 290, 'Add Lookup Data', 2 ); " 
is_sql_statments[upperbound(is_sql_statments) + 1] = "insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2078, 33, 290, 'Delete Contract', 2 ); "



datastore lds_user,lds_currentview
string ls_new_syntax,ls_sql,ls_error,ls_userid
long ll_max_userviewid,ll_temp,ll_rows,ll_found,i

lds_user = CREATE datastore
lds_user.DataObject = "d_dddw_users"
lds_user.SetTransObject( SQLCA )

lds_currentview = CREATE datastore
ls_sql = "select security_user_views.user_id, security_user_views.view_id from security_user_views"
ls_new_syntax = SQLCA.SyntaxFromSQL( ls_sql, "", ls_error )
lds_currentview.Create( ls_new_syntax, ls_error )
lds_currentview.SetTransObject(SQLCA)

lds_user.Retrieve()
lds_currentview.Retrieve()
select max( user_view_id ) into :ll_max_userviewid from security_user_views;
select top 1 rights_id into :ll_temp from ids;

ll_rows = lds_currentview.rowcount()
if ll_rows > 0 then
	ll_rows = lds_user.RowCount()
	if isnull( ll_max_userviewid ) then ll_max_userviewid = 0
	if isnull( ll_temp ) then ll_temp = 0
	if ll_temp > ll_max_userviewid then ll_max_userviewid = ll_temp;
	
	For i = 1 to ll_rows
		ls_userid = lds_user.GetItemString( i, "user_id" )
		ll_found = lds_currentview.Find( "user_id = '" + ls_userid + "' and view_id = 1001 ", 1, lds_currentview.rowcount() )
		if ll_found < 1 then
			ll_max_userviewid ++
			is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_user_views( user_view_id, user_id, view_id, access_rights) VALUES( " + string( ll_max_userviewid ) + ", '" + ls_userid + "', 1001, 1 ); "
		end if
	Next
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE ids SET rights_id = " + string( ll_max_userviewid ) + ";"	//Rodger Wu modified.
end if
of_execute_sqls()

datastore lds_actions,lds_roles,lds_rights
string ls_filter,ls_find
long j,k,ll_module_id[],ll_sub_module_id[]
long ll_find,ll_module_id1,ll_sub_module_id1,ll_role_id,ll_action_id,ll_rights_id
long ll_row,ll_action_rowcount,ll_role_rowcount,ll_right_rowcount

lds_actions = CREATE datastore
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.SetTransObject( SQLCA )

lds_roles = CREATE datastore
lds_roles.dataobject = 'd_security_roles_new'
lds_roles.settransobject(sqlca)

lds_rights = CREATE datastore
lds_rights.dataobject = 'd_security_roles_rights_new'
lds_rights.settransobject(sqlca)

lds_actions.retrieve()
lds_roles.retrieve()
lds_rights.retrieve()
Select Max( rights_id ) Into :ll_rights_id From security_roles_rights;

If IsNull( ll_rights_id ) Then ll_rights_id = 0;
ll_role_rowcount = lds_roles.rowcount()
ll_right_rowcount = lds_rights.rowcount()

ll_module_id[upperbound(ll_module_id) + 1] = 1	 //Practitioner Search
ll_module_id[upperbound(ll_module_id) + 1] = 3	 //Action Items
ll_module_id[upperbound(ll_module_id) + 1] = 3	 //Action Items
ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
ll_module_id[upperbound(ll_module_id) + 1] = 54	 //View Painter - Contract
ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
ll_module_id[upperbound(ll_module_id) + 1] = 56	 //Contract Requirement Profile
ll_module_id[upperbound(ll_module_id) + 1] = 57	 //Code Import (CPT Code)
ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract

ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 1	//Main 
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 520	//Application Status
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 521	//Contracts
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 530	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 531	//'View Manager
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 532	//Field Properties
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 533	//Screen Parameters
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 540	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 550	//Scan OIG
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 551	//Import OIG
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 560	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 570	//Main
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 150	//Audit Trail
ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 290	//Main

For i = 1 To upperbound(ll_module_id)
	ll_module_id1 = ll_module_id[i]
	ll_sub_module_id1 = ll_sub_module_id[i]
	ls_filter = "module_id = " + string(ll_module_id1) + " And sub_module_id = " + string(ll_sub_module_id1)
	lds_actions.setfilter(ls_filter)
	lds_actions.filter()
	ll_action_rowcount = lds_actions.rowcount()
	For j = 1 To ll_role_rowcount
		ll_role_id = lds_roles.getitemnumber(j,'role_id')				
		For k = 1 To ll_action_rowcount
			ll_action_id = lds_actions.getitemnumber(k,'action_id')
			ls_find = "role_id = " + string(ll_role_id) + " and action_id = " + string(ll_action_id)
			ll_find = lds_rights.find(ls_find,1,ll_right_rowcount)
			If ll_find < 1 Then
				ll_row = lds_rights.insertrow(0)
				ll_rights_id ++
				lds_rights.setitem(ll_row,'rights_id',ll_rights_id)
				lds_rights.setitem(ll_row,'role_id',ll_role_id)
				lds_rights.setitem(ll_row,'action_id',ll_action_id)
				lds_rights.setitem(ll_row,'value_id',2)
			End If
		Next
	Next
Next
lds_rights.update()
UPDATE ids SET rights_id = :ll_rights_id;	

Destroy lds_actions
Destroy lds_roles
Destroy lds_rights

DESTROY lds_user;
DESTROY lds_currentview;








end subroutine

on n_cst_role_right_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_role_right_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

