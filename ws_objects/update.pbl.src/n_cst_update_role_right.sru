$PBExportHeader$n_cst_update_role_right.sru
$PBExportComments$Sql of Role Right
forward
global type n_cst_update_role_right from nonvisualobject
end type
end forward

global type n_cst_update_role_right from nonvisualobject
end type
global n_cst_update_role_right n_cst_update_role_right

type variables
string is_init
string is_sql_statments[]

//Note: Set prod_id to Null in security_modules and security_sub_modules for IntelliCredApp only modules and 1 for Contract & Public modules.
end variables

forward prototypes
public subroutine of_update_version_70 ()
public subroutine of_update_version_60 ()
public subroutine of_update_version_80 ()
public subroutine of_update_right_bak (long al_module_id[], long al_sub_module_id[])
public subroutine of_update_document_right ()
public function integer of_execute_sqls (string as_title)
public subroutine of_update_right ()
public subroutine of_update_version_91 ()
public subroutine of_update_version_92 ()
public subroutine of_update_version_101 ()
public subroutine of_update_version_111 ()
public subroutine of_update_version_112 ()
public subroutine of_update_version_113 ()
public subroutine of_update_version_121 ()
public subroutine of_update_version_122 ()
public subroutine of_update_version_123 ()
public subroutine of_update_version_141 ()
public function integer of_adjust_clx_110 ()
public function integer of_update_clx_110 ()
public subroutine of_update_version_142 ()
public function integer of_adjust_clx_120 ()
public function integer of_update_clx_120 ()
public subroutine of_update_version_151 ()
public subroutine of_update_version_152 ()
public subroutine of_update_version_153 ()
public subroutine of_update_version_154 ()
public subroutine of_update_version_161 ()
end prototypes

public subroutine of_update_version_70 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_role_right_sqlof_update_version_7()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2007.09.18 by Jack
//////////////////////////////////////////////////////////////////////
long ll_module_id[],ll_sub_module_id[]

//Update secuity Rights
//To Do List Painter
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 63)    " + &
"Insert Into security_modules Values(63, 0,'To Do List Painter', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 602)    " + &
"Insert Into security_sub_module Values(602, 63, 'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5840)    " + &
"Insert Into security_rights_action Values(5840, 63, 602, 'View Rights', 2)"

//To Do List
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 64)    " + &
"Insert Into security_modules Values(64, 0,'To Do List', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 603)    " + &
"Insert Into security_sub_module Values(603, 64, 'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5850)    " + &
"Insert Into security_rights_action Values(5850, 64, 603, 'View Rights', 2)"

//Four new records used for the role rights of Letter Storage Area Painter.
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 51)    " + &
"insert security_modules( module_id, software_version, module_name) values( 51, 4, 'Letter Storage Area Painter' ) " 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 510)    " + &
"insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 510, 51, 'Main' )" 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5010)    " + &
"insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5010, 51, 510, 'View Rights', 2 )" 

//Fix a defect that no rights data for Question Painter.
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 34)    " + & 
"insert security_modules( module_id, software_version, module_name) values( 34, 4, 'Question Painter' ) " 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 420)    " + &
"insert security_sub_module( sub_module_id, module_id, sub_module_name ) values( 420, 34, 'Main' )" 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 2210)    " + &
"insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2210, 34, 420, 'Access Rights', 1 )" 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 128)    " + &
"insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 128, 2, 5, 'Attest Quest Full Access', 1 )" 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 65)    " + &
"insert into security_modules(module_id,software_version,module_name,prod_id) values (65,4,'WebView Required Documents Template Painter',1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 604)    " + &
"INSERT INTO security_sub_module ( sub_module_id, module_id,sub_module_name,prod_id ) VALUES ( 604, 65,'Main',1 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6927)    " + &
"INSERT INTO security_rights_action ( action_id, module_id,sub_module_id,action_name,dddw_type ) values(6927,65,604,'View Rights',1 )"

IF gs_dbtype = "SQL" THEN
	is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 2076)    " + &
	"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2076, 33, 290, 'Global Search', 2 ) "
END IF

//is_sql_statments[upperbound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6800,6801,6802,6803)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 58)    " + &
"INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 58, 4, 'Clause Library Painter',1 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 580)    " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values ( 58, 580, 'Main' ,1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6800)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6800, 58, 580, 'View Rights', 2 )"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 59)    " + & 
"INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 59, 4, 'Template Library Painter',1 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id =581)    " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 59,581,  'Main' ,1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6801)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6801, 59, 581, 'View Rights', 2 )"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 60)    " + &
"INSERT INTO security_modules ( module_id, software_version,module_name ,prod_id) values ( 60, 4, 'Document Library Painter',1 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 582)    " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values (  60, 582,'Main' ,1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6802)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6802, 60, 582, 'View Rights', 2 )"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 583)    " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 9,583, 'Contract Management Rights' ,1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6803)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6803, 9, 583, 'View Rights', 2 )"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 61)    " + &
"Insert Into security_modules ( module_id, software_version,module_name ,prod_id) Values (61, 0,'Work Flow Painter', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 600)    " + &
"Insert Into security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) Values (61,600, 'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5830)    " + &
"Insert Into security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) Values(5830, 61, 600, 'View Rights', 2)"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 62)    " + & 
"Insert Into security_modules ( module_id, software_version,module_name ,prod_id) Values (62, 0,'Email Painter', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 601)    " + &
"Insert Into security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  Values ( 62, 601,'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5831)    " + &
"Insert Into security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) Values(5831, 62, 601, 'View Rights', 2)"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (5831)"

is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET sub_module_name = 'Document Manager' WHERE sub_module_id = 370;"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6901)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6901, 33, 370, 'Add Buy', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6902)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6902, 33, 370, 'Add Sell', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6903)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6903, 33, 370, 'Properties', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6904)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6904, 33, 370, 'Report', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6905)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6905, 33, 370, 'Email', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id =6906)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6906, 33, 370, 'Output->Print', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6907)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6907, 33, 370, 'Output->Email', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id =6909)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6909, 33, 370, 'Output->Save to File', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id =6910)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6910, 33, 370, 'Check In', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6911)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6911, 33, 370, 'Check Out', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6912)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6912, 33, 370, 'Save', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6913)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6913, 33, 370, 'Add Clause', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id =6914)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6914, 33, 370, 'Merge Field', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6915)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6915, 33, 370, 'Merge Data', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6916)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6916, 33, 370, 'Work Flow', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6917)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6917, 33, 370, 'Clause Map', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6918)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6918, 33, 370, 'Add Action Item', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6919)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6919, 33, 370, 'Delete Action Item', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6920)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6920, 33, 370, 'Print Letters', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6921)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6921, 33, 370, 'Revision Control', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6922)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6922, 33, 370, 'Delete Document', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6925)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6925, 33, 370, 'Modify Other Users AI', 2 )"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6926)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6926, 33, 370, 'Add Other', 2 )"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6901,6902,6903,6904,6905,6906,6907,6908,6909,6910,6911,6912,6913,6914,6915,6916,6917,6918,6919,6920,6921,6922,6925,6926)"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 552)    " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id )  values( 25,552,  'User ID Batch Update' ,1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5511)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5511, 25, 552, 'View Rights', 2 )"
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (5511)"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 66)    " + &
"INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 66, 4, 'Import Painter', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 605)    " + & 
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 66, 605, 'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6928)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6928, 66, 605, 'View Rights', 2)"
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET SUB_MODULE_NAME = 'Fee Schedules' where SUB_MODULE_ID = 360 ; "
//is_sql_statments[UpperBound(is_sql_statments) + 1] = "DELETE FROM security_roles_rights WHERE action_id IN (6928)"
of_execute_sqls('of_update_version_70')

//--------------------------- APPEON BEGIN ---------------------------
//$<Comment> 2007-12-20 By: Scofield
//$<Reason> the interface of of_update_right has been adjusted.

//ll_module_id[upperbound(ll_module_id) + 1] = 63	 //To Do List Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 64	 //To Do List
//ll_module_id[upperbound(ll_module_id) + 1] = 51	 //Letter Storage Area Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 34	 //Question Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 2	 //Practitioner Folder
//ll_module_id[upperbound(ll_module_id) + 1] = 65	 //WebView Required Document Template
//ll_module_id[upperbound(ll_module_id) + 1] = 58  //Clause Library Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 59  //Template Library Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 60  //Document Library Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 9  //Roles Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 61  //Work Flow Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 62  //Email Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
//ll_module_id[upperbound(ll_module_id) + 1] = 66	 //Import Painter
//ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract
//
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 602	//Main 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 603	//Main 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 510	//Main 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 402	//Main 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 5	//Appointment Status 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 604	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 580	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 581	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 582	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 583	//Contract Management Rights
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 600	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 601	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 370	//Document Manager
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 552	//User ID Batch Update
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 605	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 290	//Main
//---------------------------- APPEON END ----------------------------

of_update_right()

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
datastore lds_user,lds_currentview
string ls_new_syntax,ls_sql,ls_error,ls_userid
long ll_max_userviewid,ll_temp,ll_rows,ll_found,i
long ll_module_id[],ll_sub_module_id[]

//) 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5820)    " + &
" insert security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5820, 1, 1, 'Print/Export Search Results', 1 ) " 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 520)    " + & 
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 520, 'Application Status') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5200)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5200, 3, 520, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 521)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 3, 521, 'Contracts') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5210)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5210, 3, 521, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 53)    " + & 
"insert into security_modules( module_id, software_version, module_name ) values( 53, 4, 'Screen Painter - Contract') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 530)    " + & 
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 530, 'Main') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5300)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5300, 53, 530, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 531)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 531, 'View Manager') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5310)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5310, 53, 531, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 532)    " + & 
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 532, 'Field Properties') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5320)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5320, 53, 532, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 533)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 53, 533, 'Screen Parameters') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5330)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5330, 53, 533, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 54)    " + & 
"insert into security_modules( module_id, software_version, module_name ) values( 54, 4, 'View Painter - Contract') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 540)    " + & 
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 54, 540, 'Main') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5400)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5400, 54, 540, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 550)    " + & 
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 550, 'Scan OIG') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5500)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5500, 25, 550, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 551)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 25, 551, 'Import OIG') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5510)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5510, 25, 551, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 56)    " + &
"insert into security_modules( module_id, software_version, module_name ) values( 56, 4, 'Contract Requirement Profile') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 560)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 56, 560, 'Main') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5600)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5600, 56, 560, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 57)    " + & 
"insert into security_modules( module_id, software_version, module_name ) values( 57, 4, 'Code Import (CPT Code)') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 570)    " + &  
"insert security_sub_module( module_id, sub_module_id, sub_module_name ) values( 57, 570, 'Main') "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5700)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5700, 57, 570, 'View Rights', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set prod_id = 1 Where module_id in(3,5,53,9,10,11,13,16,19,23,25,28,33,54,56,57,51) "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_sub_module Set prod_id = 1 Where sub_module_id in(521,15,530,531,532,533,28,29,30,32,35,540,37,60,80,150,170,290,300,310,320,330,340,350,360,370,380,390,400,430,560,570,510) "
is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE security_sub_module SET SUB_MODULE_NAME = 'Fee Schedules' where SUB_MODULE_ID = 360 ; "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set module_name = 'Screen Painter - Prac Data' Where module_id = 6; "
is_sql_statments[upperbound(is_sql_statments) + 1] = "Update security_modules Set module_name = 'View Painter - Prac Data' Where module_id = 18; "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5800)    " + & 
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5800, 25, 150, 'Practitioner Data', 2 ) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 5810)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 5810, 25, 150, 'Contract Data', 2 ) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 2075)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2075, 33, 290, 'Add Lookup Data', 2 ) " 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id =2078)    " + &
"insert into security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 2078, 33, 290, 'Delete Contract', 2 ) "


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
			is_sql_statments[upperbound(is_sql_statments) + 1] = "insert security_user_views( user_view_id, user_id, view_id, access_rights) VALUES( " + string( ll_max_userviewid ) + ", '" + ls_userid + "', 1001, 1 ) "
		end if
	Next
	is_sql_statments[upperbound(is_sql_statments) + 1] = "UPDATE ids SET rights_id = " + string( ll_max_userviewid ) + ";"	//Rodger Wu modified.
end if
of_execute_sqls('of_update_version_60')
DESTROY lds_user;
DESTROY lds_currentview;

//--------------------------- APPEON BEGIN ---------------------------
//$<Comment> 2007-12-20 By: Scofield
//$<Reason> the interface of of_update_right has been adjusted.

//ll_module_id[upperbound(ll_module_id) + 1] = 1	 //Practitioner Search
//ll_module_id[upperbound(ll_module_id) + 1] = 3	 //Action Items
//ll_module_id[upperbound(ll_module_id) + 1] = 3	 //Action Items
//ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 53	 //Screen Painter - Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 54	 //View Painter - Contract
//ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
//ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
//ll_module_id[upperbound(ll_module_id) + 1] = 56	 //Contract Requirement Profile
//ll_module_id[upperbound(ll_module_id) + 1] = 57	 //Code Import (CPT Code)
//ll_module_id[upperbound(ll_module_id) + 1] = 25	 //System
//ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract
//
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 1	//Main 
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 520	//Application Status
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 521	//Contracts
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 530	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 531	//'View Manager
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 532	//Field Properties
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 533	//Screen Parameters
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 540	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 550	//Scan OIG
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 551	//Import OIG
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 560	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 570	//Main
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 150	//Audit Trail
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 290	//Main
//---------------------------- APPEON END ----------------------------

of_update_right()

end subroutine

public subroutine of_update_version_80 ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_role_right_sql.of_update_version_80()
// $<arguments>(None)
// $<returns> (none)
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.22.2007 Alfee
//////////////////////////////////////////////////////////////////////
long ll_module_id[],ll_sub_module_id[]

//Update secuity Rights

//Add approve/reject control in document manager
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6929)    " + & 
"Insert Into security_rights_action Values(6929, 33, 370, 'Approve/Reject', 2)"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-12-19 By: Scofield
//$<Reason> Add contact control.
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_modules where module_id = 67)    " + &  
"INSERT INTO security_modules ( module_id, software_version, module_name ,prod_id) values( 67, 4, 'Contact', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_sub_module where sub_module_id = 606)    " + & 
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 67, 606, 'Main', 1)"
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6930)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6930, 67, 606, 'View Rights', 2 ) "
//---------------------------- APPEON END ----------------------------
//--------Begin Added by Nova 01.03.2008------------------------
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 1345)    " + &  
"INSERT INTO security_rights_action VALUES ( 1345, 25, 80, 'Admin Utilities ', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 2081)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type) Values (2081,33,300,'More Button',2)    " 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6924)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type) Values (6924,33,370,'Search Criteria',2)    " 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 2091)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type)    " + &  
"     Values (2091,33,310,'Custom Data',2)    " 
 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 2092)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type)    " + &  
"     Values (2092,33,310,'Notes',2)    " 
 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 2093)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type)    "  + &  
 "    Values (2093,33,310,'Audit Trail',2)    " 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6935)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type)    " + &  
"     Values (6935,33,370,'Work Flow Painter',2)    " 
 
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6936)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type)    " + &  
"     Values (6936,33,370,'Audit Trail Painter',2)    "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 2094) " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type) " + &  
"     Values (2094,33,310,'Status Track',2) " 


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.20.2008 By: Ken.Guo
//$<reason> For Dashboard V9.1
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 710) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 710, 'Tab', 1) "
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_rights_action where action_id = 6943) " + &
//"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6943, 70, 710, 'Add Tab', 1) "
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_rights_action where action_id = 6944) " + &
//"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6944, 70, 710, 'Delete Tab', 1) "
//
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 720) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 720, 'Banner Setup', 1) "
//is_sql_statments[upperbound(is_sql_statments) + 1] =& 
//" if not exists (select 1 from security_rights_action where action_id = 6945)    " + & 
//"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6945, 70, 720, 'View Rights', 1 ) "
//
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 730) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 730, 'Save As', 1) "
//is_sql_statments[upperbound(is_sql_statments) + 1] =& 
//" if not exists (select 1 from security_rights_action where action_id = 6946)    " + & 
//"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6946, 70, 730, 'View Rights', 1 ) "
//
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 740) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 740, 'Load', 1) "
//is_sql_statments[upperbound(is_sql_statments) + 1] =& 
//" if not exists (select 1 from security_rights_action where action_id = 6947)    " + & 
//"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6947, 70, 740, 'View Rights', 1 ) "
//
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 750) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 750, 'Management', 1) "
//is_sql_statments[upperbound(is_sql_statments) + 1] =& 
//" if not exists (select 1 from security_rights_action where action_id = 6948)    " + & 
//"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6948, 70, 750, 'View Rights', 1 ) "
//---------------------------- APPEON END ----------------------------


//--------End Added ------------------------
of_execute_sqls('of_update_version_80')

//--------------------------- APPEON BEGIN ---------------------------
//$<Comment> 2007-12-20 By: Scofield
//$<Reason> the interface of of_update_right has been adjusted.

//ll_module_id[upperbound(ll_module_id) + 1] = 33  //Contract
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 370	//Document Manager
//
//ll_module_id[upperbound(ll_module_id) + 1] = 67  //Contact
//ll_sub_module_id[upperbound(ll_sub_module_id) + 1] = 606	//Main

//---------------------------- APPEON END ----------------------------
of_update_right()

//03.19.2008 By Jervis
//update document catagory right for contract
of_update_document_right()

end subroutine

public subroutine of_update_right_bak (long al_module_id[], long al_sub_module_id[]);datastore lds_actions,lds_roles,lds_rights
string ls_filter,ls_find
long i,j,k,ll_module_id[],ll_sub_module_id[]
long ll_find,ll_module_id1,ll_sub_module_id1,ll_role_id,ll_action_id,ll_rights_id
long ll_row,ll_action_rowcount,ll_role_rowcount,ll_right_rowcount

lds_actions = CREATE datastore
lds_actions.DataObject = 'd_security_all_actions'
lds_actions.SetTransObject( SQLCA )

lds_roles = CREATE datastore
lds_roles.dataobject = 'd_security_roles'
lds_roles.settransobject(sqlca)

lds_rights = CREATE datastore
lds_rights.dataobject = 'd_security_roles_rights'
lds_rights.settransobject(sqlca)

lds_actions.retrieve()
lds_roles.retrieve()
lds_rights.retrieve()
Select Max( rights_id ) Into :ll_rights_id From security_roles_rights;

If IsNull( ll_rights_id ) Then ll_rights_id = 0;
ll_role_rowcount = lds_roles.rowcount()
ll_right_rowcount = lds_rights.rowcount()
ll_module_id = al_module_id
ll_sub_module_id = al_sub_module_id

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

public subroutine of_update_document_right ();//Start Add Code By Jervis 03.19.2008
//Update document right for contract
//Copy from w_security_roles_painter.of_contract_management_rights
Long ll_roles_count
Long ll_lookup_count
Long ll_rowcount
Long i,j
Long ll_role_id
Long ll_category
Long ll_find
Long ll_row
String ls_filter

n_cst_datastore lds_contract_management_rights
n_cst_datastore lds_code_lookup
n_cst_datastore lds_roles

SetPointer(HourGlass!)
lds_roles = Create n_cst_datastore
lds_roles.DataObject = 'd_dddw_security_roles'
lds_roles.SetTransObject(sqlca)

lds_code_lookup = Create n_cst_datastore
lds_code_lookup.DataObject = 'd_g_code_lookup'
lds_code_lookup.SetTransObject(sqlca)

lds_contract_management_rights = Create n_cst_datastore
lds_contract_management_rights.DataObject = 'd_contract_management_rights'
lds_contract_management_rights.SetTransObject(sqlca)

gnv_appeondb.of_startqueue( )
lds_roles.Retrieve()

lds_code_lookup.Retrieve()
gnv_appeondb.of_commitqueue( )

ll_roles_count = lds_roles.RowCount()

ls_filter = "lookup_name = 'Contract Category'"
lds_code_lookup.SetFilter(ls_filter)
lds_code_lookup.Filter()
ll_lookup_count = lds_code_lookup.RowCount()

For j  = 1 To ll_roles_count
	ll_role_id = lds_roles.GetItemNumber( j,"role_id")
//--------Begin Modified by Nova 04.08.2008-----------
	lds_contract_management_rights.Retrieve(ll_role_id)
   ll_rowcount = lds_contract_management_rights.RowCount()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> 
	For i = 1 To ll_lookup_count
		ll_category = lds_code_lookup.GetItemNumber(i,'lookup_code')
		//ll_find = lds_contract_management_rights.find("category = " + string(ll_category),1,ll_rowcount)
		ll_find = lds_contract_management_rights.Find("category = " + String(ll_category) + " and types = 1",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.InsertRow(0)
			lds_contract_management_rights.SetItem(ll_row,'role_id',ll_role_id)
			lds_contract_management_rights.SetItem(ll_row,'category',ll_category)
			lds_contract_management_rights.SetItem(ll_row,'types',1)
			lds_contract_management_rights.SetItem(ll_row,'rights','11')
		End If
	Next
	
	
	
	//Start Changed 02.13.2007 By Jervis
	//Replace "Contract Clause Category" to "Contract Category"
	ls_filter = "lookup_name = 'Contract Clause Category'"  //Modify by Jack 03/12/2007
	//	ls_filter = "lookup_name = 'Contract Category'"
	//End Changed
	
	lds_code_lookup.SetFilter(ls_filter)
	lds_code_lookup.Filter()
	ll_lookup_count = lds_code_lookup.RowCount()
	ll_rowcount = lds_contract_management_rights.RowCount() //Add By Jervis 02.14.2007
	For i = 1 To ll_lookup_count
		ll_category = lds_code_lookup.GetItemNumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.Find("category = " + String(ll_category) + " and types = 2",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.InsertRow(0)
			lds_contract_management_rights.SetItem(ll_row,'role_id',ll_role_id)
			lds_contract_management_rights.SetItem(ll_row,'category',ll_category)
			lds_contract_management_rights.SetItem(ll_row,'types',2)
			lds_contract_management_rights.SetItem(ll_row,'rights','21')
		End If
	Next
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> Replace "Contract Document Category" to "Contract Category"
	//ls_filter = "lookup_name = 'Contract Document Category'" //Rodger changed on Jan. 19, 2007.
	ls_filter = "lookup_name = 'Contract Category'"
	//---------------------------- APPEON END ----------------------------
	
	
	lds_code_lookup.SetFilter(ls_filter)
	lds_code_lookup.Filter()
	ll_lookup_count = lds_code_lookup.RowCount()
	ll_rowcount = lds_contract_management_rights.RowCount() //Add by jervis 02.14.2007
	For i = 1 To ll_lookup_count
		ll_category = lds_code_lookup.GetItemNumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.Find("category = " + String(ll_category) + " and types = 3",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.InsertRow(0)
			lds_contract_management_rights.SetItem(ll_row,'role_id',ll_role_id)
			lds_contract_management_rights.SetItem(ll_row,'category',ll_category)
			lds_contract_management_rights.SetItem(ll_row,'types',3)
			lds_contract_management_rights.SetItem(ll_row,'rights','31')
		End If
	Next
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 02.14.2007 By: Jervis
	//$<reason> 
	//ls_filter = "lookup_name = 'Contract Document Category'"
	ls_filter = "lookup_name = 'Contract Category'"
//--------End Modified -----------
	
	
	lds_code_lookup.SetFilter(ls_filter)
	lds_code_lookup.Filter()
	ll_lookup_count = lds_code_lookup.RowCount()
	ll_rowcount = lds_contract_management_rights.RowCount()
	For i = 1 To ll_lookup_count
		ll_category = lds_code_lookup.GetItemNumber(i,'lookup_code')
		ll_find = lds_contract_management_rights.Find("category = " + String(ll_category) + " and types = 4",1,ll_rowcount)
		If ll_find < 1 Then
			ll_row = lds_contract_management_rights.InsertRow(0)
			lds_contract_management_rights.SetItem(ll_row,'role_id',ll_role_id)
			lds_contract_management_rights.SetItem(ll_row,'category',ll_category)
			lds_contract_management_rights.SetItem(ll_row,'types',4)
			lds_contract_management_rights.SetItem(ll_row,'rights','41')
		End If
	Next
//--------End Modified -----------
	gnv_appeondb.of_autocommitrollback( )
	lds_contract_management_rights.Update()
	commit;

Next

//---------------------------- APPEON END ----------------------------

SetPointer(Arrow!)

Destroy lds_code_lookup
Destroy lds_contract_management_rights
destroy lds_roles

//End Code By Jervis 03.19.2008

end subroutine

public function integer of_execute_sqls (string as_title);/******************************************************************************************************************
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
Long ll_i
String ls_null[]
Boolean lb_ref_cache
String ls_Error
Boolean   lb_Flag

IF UpperBound(is_sql_statments) > 0 THEN  lb_ref_cache  = True

IF UpperBound(is_sql_statments) > 0 THEN
	//is_sql_statments[UpperBound(is_sql_statments) + 1] = "commit;"
	
	IF Not IsValid( w_infodisp ) THEN Open(w_infodisp)
	
	IF IsValid(w_infodisp) THEN w_infodisp.Title = 'Updating Role Right'
	IF IsValid(w_infodisp) THEN w_infodisp.Center = True
	IF IsValid(w_infodisp) THEN w_infodisp.st_complete.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_3.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_information.Visible = False
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Updating Role Right, Please stand by!'
	IF IsValid(w_infodisp) THEN w_infodisp.wf_set_min_max(1,UpperBound(is_sql_statments))
	
	FOR ll_i = 1 To UpperBound(is_sql_statments)
		IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Modification:' +String(ll_i) +' of '+ String(UpperBound(is_sql_statments)) +', Please stand by!'
		EXECUTE Immediate :is_sql_statments[ll_i] Using sqlca;
		IF sqlca.SQLCode <> 0 THEN
			IF IsValid(gnv_logservice)THEN gnv_logservice.of_log(is_sql_statments[ll_i], sqlca.SQLErrText,'Updating Role Right Information ')
			gb_upgrade_failed = True
		ELSE
			COMMIT;
		END IF
		
		IF IsValid(w_infodisp) THEN w_infodisp.wf_step_pbar(1)
	NEXT
	
	IF IsValid(w_infodisp) THEN w_infodisp.st_1.Text = 'Committing modifications Please stand by!' 
	
	// if isvalid(w_infodisp) then close(w_infodisp)
	
END IF


is_sql_statments = ls_null

RETURN 1


end function

public subroutine of_update_right ();//////////////////////////////////////////////////////////////////////
// $<Function>of_Update_Right()
// $<Arguments> ai_action_value  1: When DDDW_type is 1; 2: When DDDW_type is 2 //Added By Ken.Guo 2008-11-20 
// $<Returns> (None)
// $<Description>
//////////////////////////////////////////////////////////////////////
// $<Add> 2007.12.20 By Scofield
//////////////////////////////////////////////////////////////////////

/* Ken.Guo. Add Description 2008-11-20
When DDDW_type is 1, use 2 States CheckBox. On: 1, Off: 0
When DDDW_type is 2, use 3 States CheckBox. On: 2, Off: 0 OtherState: 1
*/


long		ll_Roles,ll_Actions,ll_RoleCnt,ll_ActionCnt,ll_RightCnt,ll_Row,ll_Find
long		ll_Role_Id,ll_Action_Id,ll_Rights_Id,ll_dddw_value
String	ls_Find

DataStore lds_Roles,lds_Actions,lds_Rights

SetPointer(HourGlass!)

lds_Roles = CREATE DataStore
lds_Roles.DataObject = 'd_security_roles'
lds_Roles.SetTransObject(SQLCA)

lds_Actions = CREATE DataStore
lds_Actions.DataObject = 'd_security_all_actions'
lds_Actions.SetTransObject(SQLCA)

lds_Rights = CREATE DataStore
lds_Rights.DataObject = 'd_security_roles_rights'
lds_Rights.SetTransObject(SQLCA)

lds_Roles.Retrieve()
lds_Actions.Retrieve()
lds_Rights.Retrieve()

Select Max(rights_id) Into :ll_Rights_Id From security_roles_rights;
If IsNull(ll_Rights_Id) Then ll_Rights_Id = 0;

ll_RoleCnt = lds_Roles.RowCount()
ll_ActionCnt = lds_Actions.RowCount()
ll_RightCnt = lds_Rights.RowCount()

for ll_Roles = 1 to ll_RoleCnt
	ll_Role_Id = lds_Roles.GetItemNumber(ll_Roles,"role_id")
	for ll_Actions = 1 to ll_ActionCnt
		ll_Action_Id = lds_Actions.GetItemNumber(ll_Actions,"action_id")
		ll_dddw_value = lds_Actions.GetItemNumber(ll_Actions,"dddw_type")
		//dddw_type
		ls_Find = "role_id = " + String(ll_Role_Id) + " and action_id = " + String(ll_Action_Id)
		ll_Find = lds_Rights.Find(ls_Find,1,ll_RightCnt)
		if ll_find <= 0 then
			ll_Row = lds_Rights.insertrow(0)
			ll_Rights_Id ++
			lds_Rights.SetItem(ll_Row,'rights_id',ll_Rights_Id)
			lds_Rights.SetItem(ll_Row,'role_id',ll_Role_Id)
			lds_Rights.SetItem(ll_Row,'action_id',ll_Action_Id)
			lds_Rights.SetItem(ll_Row,'value_id',ll_dddw_value)//modified by nova 09/18/2008 //Ken.Guo use 'ai_action_value' var 2008-11-20
		end if
	next
next

lds_Rights.update()

UPDATE ids SET rights_id = :ll_Rights_Id;	

Destroy lds_Actions
Destroy lds_Roles
Destroy lds_Rights


SetPointer(Arrow!)

end subroutine

public subroutine of_update_version_91 ();
//Changed v85 to v91 - alfee 12.30.2008

//--------Begin Added by Nova 11.20.2008------------------------
//moved from n_cst_updte_data.of_ver91_release_data1
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_sub_module where sub_module_id = 650)    " + &
"INSERT INTO security_sub_module  values (650, 25, 'Batch Import Document Queue', 1) " //alfee 12.30.2008
//"INSERT INTO security_sub_module  values (25, 650, 'Batch Import Document Queue', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id = 6937)    " + &
 "INSERT INTO security_rights_action values (6937, 25, 650, 'Access Rights', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_modules where module_id = 69)    " + &
"Insert Into security_modules Values(69, 4,'Report Painter - Provider Data ', NULL)"

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_sub_module where sub_module_id = 660)    " + &
"Insert Into security_sub_module Values(660, 69, 'Main', 1)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_sub_module where sub_module_id = 670)    " + &
"Insert Into security_sub_module Values(670, 69, 'View Manager', 1)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_sub_module where sub_module_id = 680)    " + &
"Insert Into security_sub_module Values(680, 69, 'Field Properties', 1)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_sub_module where sub_module_id = 690)    " + &
"Insert Into security_sub_module Values(690, 69, 'Screen Parameters', 1)"

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id = 6938)    " + &
"Insert Into security_rights_action Values(6938, 69, 660, 'View Rights', 2)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id = 6939)    " + &
"Insert Into security_rights_action Values(6939, 69, 670, 'View Rights', 2)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id = 6940)    " + &
"Insert Into security_rights_action Values(6940, 69, 680, 'View Rights', 2)"
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id = 6941)    " + &
"Insert Into security_rights_action Values(6941, 69, 690, 'View Rights', 2)"

//$<add> 11.20.2008 By: Ken.Guo
//$<reason> For Dashboard V9.1

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 70) " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values(70, 4, 'Dashboard', 1) "
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 700) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 700, 'Main', 1) "
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6942) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6942, 70, 700, 'View Rights', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 710) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 710, 'Tab', 1) "
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6943) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6943, 70, 710, 'Add', 1) "
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6944) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6944, 70, 710, 'Delete', 1) "

/* Commented By Ken.Guo 2008-12-11 replace with 710
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 720) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 720, 'Banner Setup', 1) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6945)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6945, 70, 720, 'View Rights', 1 ) "
*/
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6945)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6945, 70, 710, 'Settings', 1 ) "


is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 730) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 730, 'Save As', 1) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6946)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6946, 70, 730, 'View Rights', 1 ) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 740) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 740, 'Load', 1) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6947)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6947, 70, 740, 'View Rights', 1 ) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 750) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 750, 'Management', 1) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6948)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6948, 70, 750, 'View Rights', 1 ) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 760) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 760, 'Banners Settings', 1) "
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6949)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6949, 70, 760, 'View Rights', 1 ) "

//---------Begin Commented by (Appeon)Alfee 05.31.2013 for V141 ISG-CLX--------
//<$Reason> for Dashboard - Close functionality.
//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where sub_module_id = 770) " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (70, 770, 'Close', 1) "
//is_sql_statments[upperbound(is_sql_statments) + 1] =& 
//" if not exists (select 1 from security_rights_action where action_id = 6950)    " + & 
//"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6950, 70, 770, 'View Rights', 1 ) "
//---------End Commented ------------------------------------------------------

//--------Begin Added by Nova 11.20.2008------------------------
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"update SECURITY_MODULES set prod_id=NULL where module_id=69 "

//--------Begin Added by Nova 12.11.2008------------------------
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"Update security_rights_action set sub_module_id = 710 , action_name = 'Settings'  " +&
"where action_id = 6945 and sub_module_id = 720  " 

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"Update security_sub_module Set sub_module_name = 'Banner Settings' " +&
"Where module_id = 70 and sub_module_id = 760 and sub_module_name = 'Logo Settings' "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"Delete security_sub_module where module_id = 70 and sub_module_id = 720 and sub_module_name = 'Banner Setup' "

of_execute_sqls('of_update_version_91')

of_update_right()
//---------------------------- APPEON END ----------------------------



end subroutine

public subroutine of_update_version_92 ();//////////////////////////////////////////////////////////////////////
// $<function> of_update_version_92
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.19.2009
//////////////////////////////////////////////////////////////////////

// For Peer Reference Painter right sqls
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 71) " + &
"   insert security_modules(module_id, software_version, module_name, prod_id) values(71, 4, 'Peer Reference Painter', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 780) " + &
"   insert security_sub_module(sub_module_id, module_id, sub_module_name, prod_id) values(780, 71, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6951) " + &
"   insert security_rights_action(action_id, module_id, sub_module_id, action_name, dddw_type ) values(6951, 71, 780, 'View Rights', 2) "

// Add by Evan 07.22.2009 --- For OPPE/FPPE right sqls
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 72) " + &
"   INSERT INTO security_modules VALUES (72, 4, 'OPPE/FPPE', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 790) " + &
"   INSERT INTO security_sub_module VALUES (790, 72, 'Appointment Status', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 800) " + &
"   INSERT INTO security_sub_module VALUES (800, 72, 'OPPE/FPPE Screen', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6961) " + &
"   INSERT INTO security_rights_action VALUES (6961, 72, 790, 'View Button Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6971) " + &
"   INSERT INTO security_rights_action VALUES (6971, 72, 800, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6981) " + &
"   INSERT INTO security_rights_action VALUES (6981, 72, 800, 'Upload Documents', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6991) " + &
"   INSERT INTO security_rights_action VALUES (6991, 72, 800, 'View Documents', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7001) " + &
"   INSERT INTO security_rights_action VALUES (7001, 25, 150, 'Role Data', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7011) " + &
"   INSERT INTO security_rights_action VALUES (7011, 25, 150, 'User Data', 2) "

// Execute sqls
of_execute_sqls('of_update_version_92')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_101 ();//////////////////////////////////////////////////////////////////////
// $<function> of_update_version_101
// $<arguments>
// $<returns> (None)
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 09.29.2009
//////////////////////////////////////////////////////////////////////

//Added by  Nova 12.04.2009 --v10.1 Profiles Build out
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 73) " + &
"   INSERT INTO security_modules VALUES (73, 4, 'Quality Profiles', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 810) " + &
"   INSERT INTO security_sub_module VALUES (810, 73, 'Profile Window Access', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 820) " + &
"   INSERT INTO security_sub_module VALUES (820, 73, 'Case Review', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 830) " + &
"   INSERT INTO security_sub_module VALUES (830, 73, 'OPPE/FPPE', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 840) " + &
"   INSERT INTO security_sub_module VALUES (840, 73, 'Privileges', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 850) " + &
"   INSERT INTO security_sub_module VALUES (850, 73, 'Profiles', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 860) " + &
"   INSERT INTO security_sub_module VALUES (860, 73, 'Site Survey', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7021) " + &
"   INSERT INTO security_rights_action VALUES (7021, 73, 810, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7031) " + &
"   INSERT INTO security_rights_action VALUES (7031, 73, 820, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7041) " + &
"   INSERT INTO security_rights_action VALUES (7041, 73, 830, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7051) " + &
"   INSERT INTO security_rights_action VALUES (7051, 73, 840, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7061) " + &
"   INSERT INTO security_rights_action VALUES (7061, 73, 850, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7071) " + &
"   INSERT INTO security_rights_action VALUES (7071, 73, 860, 'View Access', 2) "


is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7081) " + &
"  INSERT INTO security_rights_action VALUES (7081, 73,  820, 'Action Items', 2)"

//Move the items for the QA profile access under the new security module:
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_sub_module set module_id = 73  where sub_module_id = 250 and module_id <> 95 "  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//"update security_sub_module set module_id = 73  where sub_module_id = 250"

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_rights_action set module_id = 73  where sub_module_id = 250 and module_id <> 95 "  //(Appeon)Alfee 01.21.2014 - V142 ISG-CLX
//"update security_rights_action set module_id = 73  where sub_module_id = 250"

//from maha - alfee 02.02.2010
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 74) " + &
"INSERT INTO security_modules ( module_id, software_version, module_name,prod_id) values( 74, 4, 'Notification/Data Flow Painters', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 75) " + &
"INSERT INTO security_modules ( module_id, software_version, module_name,prod_id) values( 75, 4, 'CAQH Import', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 76) " + &
"INSERT INTO security_modules ( module_id, software_version, module_name,prod_id) values( 76, 4, 'Scheduler Painter', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 77) " + &
"INSERT INTO security_modules ( module_id, software_version, module_name,prod_id) values( 77, 4, 'Launch Pad', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 870) " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 74, 870, 'Main', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 880) " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 75, 880, 'Import Files', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 890) " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 76, 890, 'Main', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 900) " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 77, 900, 'Main', 1)  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7090) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7090, 74, 870, 'Access Rights', 1 )  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7100) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7100, 75, 880, 'Access Rights', 1 ) " 

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7110) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7110, 76, 890, 'Access Rights', 1 )  "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7120) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7120, 2, 5, 'Allow to Purge', 1 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7130) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7130, 2, 5, 'CVO Data', 1 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7140) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7140, 77, 900, 'Access', 1 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7150) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7150, 2, 6, 'Delete/Send to History', 1 ) "

// Add by Evan on 03.06.2010 (V10.1 - Notification Alert)
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 74) " + &
"   INSERT INTO security_modules VALUES (74, 4, 'Notification Alert Painter', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 870) " + &
"   INSERT INTO security_sub_module VALUES (870, 74, 'Main', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7090) " + &
"   INSERT INTO security_rights_action VALUES (7090, 74, 870, 'View Access', 2) "

// Execute sqls
of_execute_sqls('of_update_version_101')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_111 ();//Added by  Nova 06.23.2010
// Execute sqls
of_execute_sqls('of_update_version_111')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_112 ();//added - evan 01.10.2011

//added by Stephen 11.09.2011 V12.1 Fax log


// Execute sqls
of_execute_sqls('of_update_version_112')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_113 ();// For v113 db updates - evan 06.13.2011
//---------------------APPEON BEGIN----------------------
//$<add> long.zhang 07.27.2011
//$<Reason> For Red Flag Data
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 78) " + &
"   INSERT INTO security_modules (module_id, software_version, module_name, prod_id) VALUES (78, 4, 'Red Flag',1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 910) " + &
"   INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) VALUES (78, 910, 'Add Red Flag', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 920) " + &
"   INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id )  VALUES (78, 920, 'View Red Flag', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7160) " + &
"   INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) VALUES (7160, 78, 910, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7170) " + &
"   INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) VALUES (7170, 78, 920, 'Access Rights', 1) "

//----------------Appeon Begin------------------------
//$<add> long.zhang 09.16.2011
//$<reason> For view red flag data Edit Rights
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7171) " + &
"   INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) VALUES (7171, 78, 920, 'Edit Rights', 1) "
//---------------Appeon End----------------------------

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7180) " + &
"   INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) VALUES (7180, 78, 920, 'Delete Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7190) " + &
"   INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) VALUES (7190, 78, 920, 'Report Rights', 1) "
//-------------------------------APPEON END---------------------------------------------

//------------------- APPEON BEGIN -------------------
//$<add> Michael 07.13.2011
//$<reason>from maha
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select TOP 1 1 from security_modules where module_id = 79 and software_version=4) " + &
"INSERT INTO security_modules ( module_id, software_version, module_name,prod_id) values( 79, 4, 'Process Templates', 1)  " 

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select TOP 1 1 from security_sub_module where module_id =79 and sub_module_id=930) " + &
"INSERT INTO security_sub_module ( module_id, sub_module_id, sub_module_name,prod_id ) values ( 79, 930, 'Template Setup', 1)  " 

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select TOP 1 1 from security_rights_action where action_id=7191 and module_id = 79 and sub_module_id=930) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7191, 79, 930, 'Access Rights', 1 )  " 

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select TOP 1 1 from security_rights_action where action_id=7192 and module_id = 72 and sub_module_id=800) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7192, 72, 800, 'Action Items', 2 )  " 
//------------------- APPEON END ---------------------

//Start Code Change ----07.18.2011 #V11 maha 
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select TOP 1 1 from security_rights_action where action_id=7195 and module_id = 28 and sub_module_id=170) " + &
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 7195, 28, 170, 'Report Security', 1 )  " 
//End Code Change ----07.18.2011

// Execute sqls
of_execute_sqls('of_update_version_113')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_121 ();// For v121 db updates - evan 10.13.2011
//added by Stephen 11.09.2011 V12.1 Fax log
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 80) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (80, 4, 'View Fax Log', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 940) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (80, 940, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7210) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7210, 80, 940, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7220) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7220, 80, 940, 'Delete Rights', 1) "

//added by Stephen 01.04.2012 WV audit acceptance code migration to PB 
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if exists (select 1 from security_modules where  module_id = 81 and module_name = 'Audit Acceptance') " + &
" begin  delete from security_roles_rights where action_id in (select action_id from security_rights_action where sub_module_id=950) " +&
" delete from  security_rights_action where sub_module_id=950 " +&
" delete from  security_sub_module where sub_module_id=950 " +&
" delete from security_modules where module_id = 81 end "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 950) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 950, 'WebView Auditing', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7230) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7230, 29, 950, 'Access Rights', 1) "

//added by Stephen 03.06.2012 WebView Settings Maintenance (V12.1 WebView Painter Migration to Cred)
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 960) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 960, 'E-Signature Agreements', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7250) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7250, 29, 960, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 970) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 970, 'Letter Template Maintenance', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7260) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7260, 29, 970, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 980) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 980, 'Logo Image', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7270) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7270, 29, 980, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 990) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 990, 'Privilege View Options', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7280) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7280, 29, 990, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1000) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1000, 'WebView Access Role Management', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7290) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7290, 29, 1000, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1010) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1010, 'WebView Agreements Painter', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7300) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7300, 29, 1010, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1020) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1020, 'WebView Settings Maintenance', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7310) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7310, 29, 1020, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1030) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1030, 'WebView User Painter', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7320) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7320, 29, 1030, 'Access Rights', 1) "

//added by Evan 05.23.2012 --- for Privilege Procedures
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 81) " + &
"   INSERT INTO security_modules (module_id,software_version,module_name,prod_id) VALUES (81, 4, 'Privilege Procedures', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 941) " + & 
"   INSERT INTO security_sub_module (sub_module_id,module_id,sub_module_name,prod_id) VALUES (941, 81, 'Main', NULL) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7221) " + &
"   INSERT INTO security_rights_action (action_id,module_id,sub_module_id,action_name,dddw_type) VALUES (7221, 81, 941, 'View Access', 1) "
	
// Execute sqls
of_execute_sqls('of_update_version_121')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_122 ();// For v122 db updates - Stephen 06.04.2012

//added by Stephen 07.09.2012  -- V12.2 WebCrawler extract data
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 82) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (82, 4, 'WebCrawler Data Audit', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1040) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (82, 1040, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7330) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7330, 82, 1040, 'Access Rights', 1) "

//Start Code Change ----09.12.2012 #V12 maha - add but not edit notes
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1050) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (2, 1050, 'Notes - General', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1060) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (2, 1060, 'Notes - Record Specific', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7340) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7340, 2, 1050, 'View Access', 2) "  //alfee 10.23.2012
//"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7340, 82, 1050, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7350) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7350, 2, 1050, 'Edit - (Unchecked = Add but not Edit)', 1) " //alfee 10.23.2012 
//"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7350, 82, 1050, 'Edit - (Unchecked = Add but not Edit)', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7360) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7360, 2, 1060, 'Edit - (Unchecked = Add but not Edit)', 1) "  //alfee 10.23.2012
//"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7360, 82, 1060, 'Edit - (Unchecked = Add but not Edit)', 1) "

//End Code Change ----09.12.2012

// Execute sqls
of_execute_sqls('of_update_version_122')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_123 ();//Added by Alfee 12.03.2012

//added by long.zhang appeon 12.19.2012 v12.3 pracview Email
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1070) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1070, 'WebView Email Settings', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7370) " + &
 " Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7370, 29, 1070, 'Access Rights', 1) "

//from maha - alfee 01.16.2013
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1240) " + &
"	insert into security_sub_module ( sub_module_id, module_id,sub_module_name,prod_id ) values ( 1240, 16,'One-Click Reports',1 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7505) " + &
"	insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7505, 16, 1240, 'View Rights', 2) "

//added by Stephen 02.04.2013  -- V12.3 Import Logging modifications
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 83) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (83, 4, 'Import Audit', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1080) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (83, 1080, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7380) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7380, 83, 1080, 'Access Rights', 1) "

// Execute sqls
of_execute_sqls('of_update_version_123')

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_141 ();
//---------Begin Added by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//Adjust the conflicting data for ISG-CLX
of_adjust_clx_110 ()

//Update history data for CLX 110
of_update_clx_110 ()
//---------End Added ------------------------------------------------------------------

//Start Code Change ----07.18.2013 #V14 maha - contact log
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 93) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (93, 4, 'Contact Log', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1350) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (93, 1350, 'Log Window', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1330) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (93, 1330, 'Open Actions Window', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1340) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (93, 1340, 'Setup', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7661) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7661, 93, 1350, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7671) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7671, 93, 1330, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7681) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7681, 93, 1330, 'View All Users', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7691) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7691, 93, 1340, 'Access Rights', 1) "

//(Appeon)Stephen 2013-07-29 - V141 File Packet creation
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 84) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (84, 4, 'Zip Package Defaults', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1090) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (84, 1090, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7390) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7390, 84, 1090, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 86) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (86, 4, 'View Package log', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1120) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (86, 1120, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7410) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7410, 86, 1120, 'Access Rights', 1) "

//Added by Appeon long.zhang 09.13.2013 (V14.1 Recruitment Functionality)
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 94) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (94, 4, 'Recruitment Functionality', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1360) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (94, 1360, 'Recruitment Screen Design', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1370) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (94, 1370, 'Recruitment Evaluations', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1380) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (94, 1380, 'Recruitment Settings', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7701) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7701, 94, 1360, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7711) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7711, 94, 1370, 'Access Rights', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7721) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7721, 94, 1380, 'Access Rights', 1) "

//Set prod_id to Null for IntelliCredApp modules for BugT111801 - Eugene 11.29.2013
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_modules set prod_id = Null where module_id in (5,65,71,72,74,75,77,78,79,82,83,84,86,91,93,94) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_sub_module set prod_id = Null where module_id in (2,5,29,65,69,71,72,74,75,77,78,79,82,83,84,86,91,93,94) "

// Execute sqls
of_execute_sqls('of_update_version_141')

// Update rights of all roles
of_update_right()
end subroutine

public function integer of_adjust_clx_110 ();//====================================================================
//$<Function>: of_adjust_clx_110()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Update conflicting data for IntelliCred
//$<Author>: (Appeon) Alfee 06.17.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//71-780-6951	91-1300-7601	Peer Reference List - Main - View Rights
//72-790-6961	92-1310-7611	OPPE/FPPE - Appointment Status - View Button Access
//72-800-6971	92-1320-7621	OPPE/FPPE - OPPE/FPPE Screen - View Access
//72-800-6981	92-1320-7631	OPPE/FPPE - OPPE/FPPE Screen - Upload Documents
//72-800-6991	92-1320-7641	OPPE/FPPE - OPPE/FPPE Screen - View Documents
//72-800-7192	92-1320-7651	OPPE/FPPE - OPPE/FPPE Screen - Action Items

Long ll_cnt
Select count(*) into :ll_cnt from security_modules where module_id = 91; 

//1. Create new data for IntelliCred
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 91)  " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values (91, 4, 'Peer Reference List', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 92)  " + & 
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values (92, 4, 'OPPE/FPPE', Null) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where module_id = 91 and sub_module_id = 1300)  " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (91, 1300, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where module_id = 92 and sub_module_id = 1310)   " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (92, 1310, 'Appointment Status', Null) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where module_id = 92 and sub_module_id = 1320)   " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (92, 1320, 'OPPE/FPPE Screens', Null) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 91 and sub_module_id = 1300 and action_id =7601 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (91, 1300, 7601, 'View Rights', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 92 and sub_module_id = 1310 and action_id =7611 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (92, 1310, 7611, 'View Button Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 92 and sub_module_id = 1320 and action_id =7621 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (92, 1320, 7621, 'View Access', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 92 and sub_module_id = 1320 and action_id =7631 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (92, 1320, 7631, 'Upload Documents', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 92 and sub_module_id = 1320 and action_id =7641 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (92, 1320, 7641, 'View Documents', 2) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where module_id = 92 and sub_module_id = 1320 and action_id =7651 )    " + &
"INSERT INTO security_rights_action (module_id, sub_module_id, action_id, action_name, dddw_type) values (92, 1320, 7651, 'Action Items', 2) "


//2. move history role-rights for IntelliCred
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7601) " + &
"update security_roles_rights set action_id = 7601  where action_id = 6951 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7611) " + &
"update security_roles_rights set action_id = 7611  where action_id = 6961 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7621) " + &
"update security_roles_rights set action_id = 7621  where action_id = 6971 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7631) " + &
"update security_roles_rights set action_id = 7631  where action_id = 6981 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7641) " + &
"update security_roles_rights set action_id = 7641  where action_id = 6991 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_roles_rights where action_id = 7651) " + &
"update security_roles_rights set action_id = 7651  where action_id = 7192 "

//3. delete the original data for IntelliCred
IF ll_cnt < 1 THEN
	is_sql_statments[upperbound(is_sql_statments) + 1] = &
	"delete from security_rights_action where module_id in (71, 72) "
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = &
	"delete from security_sub_module where module_id in (71, 72) "
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = &
	"delete from security_modules where module_id in (71, 72) "
END IF

//these records may be re-added - alfee 12.12.2013 for BugA122001
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"delete from security_roles_rights where action_id in (6981,6991,7192) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"delete from security_rights_action where module_id = 72 and sub_module_id = 800 "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"delete from security_sub_module where module_id = 72 and sub_module_id = 800 "

// Execute sqls
of_execute_sqls('of_adjust_clx_110')

RETURN 1
end function

public function integer of_update_clx_110 ();//====================================================================
//$<Function>: of_update_clx_141()
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Update role rights for CLX 11 - Moved from CLX 11.
//$<Author>: (Appeon) Alfee 06.17.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//1. of_update_version_90 ()

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
" if not exists (select 1 from security_rights_action where action_id = 6951)    " + & 
"INSERT INTO security_rights_action( action_id, module_id, sub_module_id, action_name, dddw_type ) values( 6951, 33, 310, 'Group Access', 2 ) "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6952)    " + &  
"Insert Into security_rights_action(action_id,module_id,sub_module_id,action_name,dddw_type) Values (6952,33,300,'Report Button',1)    " 

//Added By Ken.Guo 2009-06-04.
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6953)    " + &  
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6953, 33, 370, 'Options', 2 )"

//Fixed BugJ042301 -- Jervis 04.24.2009
is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"delete security_roles_rights where action_id = 6950"

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"delete security_rights_action where module_id = 70 and sub_module_id = 770 and action_id = 6950"

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"delete security_sub_module where module_id = 70 and sub_module_id = 770 and prod_id = 1"

//Added By Ken.Guo 2009-06-30.
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id =6954)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6954, 33, 370, 'Insert Reqmnt.', 2 )"

of_execute_sqls('of_update_version_90')


//2. of_update_version_95 ()
//Added By Ken.Guo 2009-08-27.
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id =6955)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6955, 33, 290, 'Use Template', 1 )"

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
" if not exists (select 1 from security_rights_action where action_id =6956)    " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6956, 33, 310, 'Save As...', 1 )"

//Added by jervis 2009-9-27
//Change 'Screen Parameters' to 'Depend'
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"update security_sub_module set sub_module_name = 'Depend' where module_id = 53 and sub_module_id = 533"

//BEGIN---Modify by Scofield on 2010-01-13
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 71) " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values(71, 4, 'Calendar', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 770) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (71, 770, 'Main', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6957) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6957, 71, 770, 'View Rights', 1) "
//END---Modify by Scofield on 2010-01-13

//Begin - Added By Ken.Guo 2010-01-13.
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6958) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6958, 58, 580, 'Add Clause', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6959) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6959, 58, 580, 'Add Folder', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6960) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6960, 58, 580, 'Copy Clause', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6961) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6961, 58, 580, 'Delete', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6962) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6962, 58, 580, 'Save', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6963) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6963, 58, 580, 'Save As', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6964) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6964, 58, 580, 'Check In', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6965) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6965, 58, 580, 'Check Out', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6966) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6966, 58, 580, 'Insert Field', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6967) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6967, 58, 580, 'Insert Reqmnt', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6968) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6968, 58, 580, 'Merge Data', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6969) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6969, 58, 580, 'Properties', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6970) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6970, 58, 580, 'Rules', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6971) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6971, 58, 580, 'Email', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6972) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6972, 58, 580, 'Print', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6973) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6973, 58, 580, 'Auto Num', 1) "

//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_rights_action where action_id = 6974) " + &
//"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6974, 58, 580, 'Revision', 1) "
//
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6975) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6975, 58, 580, 'Compare', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6976) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6976, 58, 580, 'Analysis', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6977) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6977, 58, 580, 'Version Settings', 1) "
//End - Added By Ken.Guo 2010-01-13.

//Added By Ken.Guo 2010-02-22.
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6978) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6978, 33, 300, 'Display Options', 1) "

of_execute_sqls('of_update_version_95')


//3. of_update_version_100 ()
//Added by Ken on 2010-09-07
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 72) " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values(72, 4, 'Documents', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 780) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (72, 780, 'Main', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6979) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6979, 72, 780, 'View Rights', 2) "

//Added By Ken.Guo 2010-12-23.
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 790) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (68, 790, 'Getting Started', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6980) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6980, 68, 790, 'View Rights', 1) "

of_execute_sqls('of_update_clx_110')

RETURN 1
end function

public subroutine of_update_version_142 ();//---------Begin Added by (Appeon)Alfee 01.21.2014 for V142 ISG-CLX--------
//Adjust the conflicting data for ISG-CLX
of_adjust_clx_120 ()

//Update history data for CLX 
of_update_clx_120 ()
//---------End Added ------------------------------------------------------------------

//Update for IntelliCred .

//Added by Appeon long.zhang 04.17.2014 (v14.2 Provider-Contract direct linking)
is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from security_sub_module where sub_module_id = 1390) " + &
  " Insert into security_sub_module(module_id,sub_module_name,prod_id,sub_module_id)values(2,'Contracts Sub Module',null,1390) "
  
is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from SECURITY_RIGHTS_ACTION where ACTION_ID = 7731) " + &
  " INSERT INTO SECURITY_RIGHTS_ACTION(Action_id,Module_id,sub_module_id,Action_name,dddw_type)values(7731,2,1390,'View Rights',2) "
  
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from SECURITY_RIGHTS_ACTION where ACTION_ID = 7741) " + &
  " INSERT INTO SECURITY_RIGHTS_ACTION(Action_id,Module_id,sub_module_id,Action_name,dddw_type)values(7741,2,1390,'View Contracts',1) "
  
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from SECURITY_RIGHTS_ACTION where ACTION_ID = 7751) " + &
  " Insert into Security_Rights_Action(Action_id, module_id,sub_module_id,Action_name,dddw_type)values(7751,33,310,'Linked Providers',2)"
  
//---------Begin Added by (Appeon)Stephen 05.27.2014 for Using image OCR to import data into IntelliCred 14.2--------
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 98) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (98, 4, 'OCR Applications', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1400) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (98, 1400, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7760) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7760, 98, 1400, 'Access Rights', 1) "
//---------End Added ------------------------------------------------------

// Execute sqls
of_execute_sqls('of_update_version_142') 

// Update rights of all roles
of_update_right()
end subroutine

public function integer of_adjust_clx_120 ();//====================================================================
//$<Function>: of_adjust_clx_120()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Update conflicting data for IntelliCred
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Note: The sub_module_id and action_id needn't be changed.
//73->95	Quality Profiles
//74->96	Notifications/Dataflow Setup

Long ll_cnt
Select count(*) into :ll_cnt from security_modules where module_id in (95,96); 

//1. Create new data for IntelliCred
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 95)  " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values (95, 4, 'Quality Profiles', Null) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 96)  " + & 
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values (96, 4, 'Notifications/Dataflow Setup', Null) "

//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 250)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 250, 'QA Folder', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 810)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 810, 'Profile Window', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 820)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 820, 'Case Review', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 830)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 830, 'OPPE/FPPE', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 840)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 840, 'Privileges', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 850)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 850, 'Profiles', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 95 and sub_module_id = 860)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (95, 860, 'Site Survey', Null) "
//
//is_sql_statments[upperbound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_sub_module where module_id = 96 and sub_module_id = 870)   " + &
//"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (96, 870, 'Main', Null) "

//2. update module_id for IntelliCred
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_sub_module set module_id = 95 where module_id = 73 and sub_module_id in (250,250,810,820,830,840,850,860) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_sub_module set module_id = 96  where module_id = 74 and sub_module_id in (870) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_rights_action set module_id = 95  where module_id = 73 and sub_module_id in (250,250,810,820,830,840,850,860) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"update security_rights_action set module_id = 96  where module_id = 74 and sub_module_id in (870) "

//3. delete the original data for IntelliCred
IF ll_cnt < 1 THEN
	is_sql_statments[upperbound(is_sql_statments) + 1] = &
	"delete from security_sub_module where module_id in (73, 74) "
	
	is_sql_statments[upperbound(is_sql_statments) + 1] = &
	"delete from security_modules where module_id in (73, 74) "
END IF

// Execute sqls
of_execute_sqls('of_adjust_clx_120')

RETURN 1
end function

public function integer of_update_clx_120 ();//====================================================================
//$<Function>: of_update_clx_120()
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Update role rights for CLX 12 - Moved from CLX 12.
//$<Author>: (Appeon) Alfee 01.21.2014 (V142 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_update_version_115
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6981) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6981, 58, 580, 'Batch Update', 1) "

//Added By Mark Lee 09/11/12
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6982) " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6982, 33, 380, 'Modify Other Users AI', 1 ) "

of_execute_sqls('of_update_clx_115')


//of_update_version_120
//Added by gavins 20121229
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6983) " + &
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6983, 67, 606, 'Batch Update', 1 ) "

//Added By Mark Lee 02/06/2013
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 800) " + &
 "INSERT	INTO	security_sub_module	(	module_id		, sub_module_id		, sub_module_name, prod_id	)	VALUES		(	33		, 800	, 'Email Manager' , 1	) "
 
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6984) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	33	, 800	,6984 , 'Access Rights'	, 1	) "

//Added by gavins 20130312
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 73) " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values(73, 4, 'EZ Menu Painter', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 801) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (73, 801, 'Main', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6985) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6985, 73, 801, 'View Rights', 1) "

//is_sql_statments[UpperBound(is_sql_statments) + 1] = &
//"if not exists (select 1 from security_rights_action where action_id = 6986) " + &
//"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6986, 73, 801, 'System Level Settings', 1) "

//Added By Ken.Guo 03/27/2013
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 74) " + &
"INSERT INTO security_modules (module_id, software_version, module_name, prod_id) values(74, 4, 'Picture Painter', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 802) " + &
"INSERT INTO security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (74, 802, 'Main', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6987) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6987, 74, 802, 'View Rights', 2) "

//Added by gavins 20130329
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if exists (select 1 from security_rights_action where action_id = 6986) " + &
"   Begin~r~n" + &
"delete security_roles_rights where action_id = 6986 ~r~n" +&
"Delete From security_rights_action where action_id = 6986 and module_id = 73 and sub_module_id = 801~r~n" + &
"  end~r~n"

//Added By Ken.Guo 04/17/2013
is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6988) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6988, 33, 290, 'New CTX', 1) "

is_sql_statments[UpperBound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 6989) " + &
"INSERT INTO security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values(6989, 33, 290, 'Copy CTX', 1) "

of_execute_sqls('of_update_clx_120')

RETURN 1
end function

public subroutine of_update_version_151 ();

// Start Code Change ----03.11.2015 #V15 maha - granular security for mednax
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7771) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 3	,7771 , 'Delete Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7772) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 3	,7772 , 'Facility Specific Data'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7773) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 3	,7773 , 'Verify Cred Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7774) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 5	,7774 , 'Delete Button'	, 1	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7775) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7775 , 'Delete Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7776) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7776 , 'Batch Add Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7777) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7777 , 'Multi App Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7778) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7778 , 'Reappointment Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7779) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7779 , 'Print Applications'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7781) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7781 , 'Pop Web'	, 1	) "
 
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7782) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 8	,7782 , 'Reports Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7783) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 8	,7783 , 'Update Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7784) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 8	,7784 , 'Delete Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7785) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 4	,7785 , 'Delete Button'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7786) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 4	,7786 , 'Find Missing/Copy Rox'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7788) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 6	,7788 , 'Find Missing'	, 1	) " 


 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7787) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7787 , 'Add/Edit Orgs and Apps'	, 1	) " 
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7789) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7789 , 'Delete Applications Button'	, 1	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7791) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7791 , 'Delete Applications Option'	, 1	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7792) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7792 , 'Inactive Organization'	, 1	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7793) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7793 , 'Organization Notes'	, 2	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7794) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	24	, 160	,7794 , 'Application Notes'	, 2	) "

 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7795) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7795 , 'Email Payor'	, 1	) "
 // End Code Change ----03.11.2015
 
  //Start Code Change ----03.24.2015 #V15 maha - reset user option
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7796) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	29	, 1030	,7796 , 'Reset User from Provider Folder'	, 1	) "
  
  //---------Begin Added by (Appeon)Harry 08.11.2015 for  Bug 4638--------
is_sql_statments[upperbound(is_sql_statments) + 1] = & 
"if exists (select 1 from security_rights_action where action_id = 6953 And action_name = 'Options') " + &
"Update security_rights_action Set action_name = 'Version Settings' Where action_id = 6953 "

is_sql_statments[upperbound(is_sql_statments) + 1] =& 
"if not exists (select 1 from security_rights_action where action_id = 6990)    " + &  
"INSERT INTO security_rights_action ( action_id, module_id, sub_module_id, action_name, dddw_type ) values ( 6990, 33, 370, 'Compare', 2 )"
//---------End Added ------------------------------------------------------

  //Start Code Change ----08.24.2015 #V15 maha - document delete
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7797) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 38	,7797 , 'Delete Button'	, 1	) "
  
  //Start Code Change ----08.24.2015 #V15 maha - rename some items
 is_sql_statments[upperbound(is_sql_statments) + 1] = & 
"if exists (select 1 from security_modules where module_id = 2 And module_name = 'Practitioner Folder') " + &
"Update security_modules Set module_name = 'Provider Folder' Where module_id = 2 "

 is_sql_statments[upperbound(is_sql_statments) + 1] = & 
"if exists (select 1 from security_modules where module_id = 1 And module_name = 'Practitioner Search') " + &
"Update security_modules Set module_name = 'Provider Search' Where module_id = 1 "

  //Start Code Change ----10.05.2015 #V15 maha - recred option verif tab
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7798) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 6	,7798 , 'Initiate Recredentialing'	, 1	) "
     
 //Start Code Change ----10.20.2015 #V15 maha	  
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if exists (select 1 from security_rights_action where action_id = 7130 and action_name = 'CVO Data') " + &
 "update	security_rights_action set action_name = 'PSV Data' where action_id = 7130 "
 
  //Start Code Change ----10.27.2015 #V15 maha - priv edit
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7799) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 8	,7799 , 'Protect Privilege Edit'	, 1	) "
 
 //batch verifications
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 99) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (99, 4, 'Batch Verifications', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1411) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (99, 1411, 'Setup', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1412) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (99, 1412, 'Run Verifications', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1413) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (99, 1413, 'Audit Log', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7800) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7800, 99, 1411, 'Access Rights', 1) "
 
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7801) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7801, 99, 1412, 'Access Rights', 1) " 
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7802) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7802, 99, 1413, 'Access Rights', 2) "
 
  //Start Code Change ----10.29.2015 #V15 maha
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7803) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7803, 99, 1413, 'View All Users', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7805) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7805, 99, 1413, 'Delete Log Record', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7804) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7804, 2, 120, 'Change Facility button', 1) "

 //Start Code Change ----11.10.2015 #V15 maha - caqh roster
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1414) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (75, 1414, 'CAQH Roster', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7806) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7806, 75, 1414, 'Manual Roster Screen', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7807) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7807, 75, 1414, 'Roster Settings', 1) "

		//search screen quick process
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7808) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7808, 1, 1, 'Action Processing', 1) "

		//recruitment setup
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7809) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7809, 94, 1380, 'Positions Setup', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7810) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7810, 94, 1380, 'Screen Design', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7811) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7811, 94, 1380, 'Groups-Committees', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7812) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7812, 94, 1380, 'Qualification Questions', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7813) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7813, 94, 1380, 'Recruiters-Members', 2) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7814) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7814, 94, 1380, 'WebView Settings', 2) "

//---------Begin Added by (Appeon)Harry 12.07.2015 for Bug # 4867 -  IntelliContract v14.2: Issues With Configuration, Availability And Display Of "Home" Splash Window--------
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 100) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (100, 4, 'Home', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1415) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (100, 1415, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7815) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7815, 100, 1415, 'Access Rights', 1) "
//---------End Added ------------------------------------------------------ 
 
 //Start Code Change ----01.06.2016 #V15 maha - CAQH roster setting
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 87) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (87, 4, 'View Email Log', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1416) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (87, 1416, 'Main', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7816) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7816, 87, 1416, 'Access Rights', 1) "
 
 //Start Code Change ----01.07.2016 #V15 maha - ireport management
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7817) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7817, 28, 170, 'Access Rights', 1) " 

//Start Code Change ----03.16.2016 #V15 maha
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7818) " + &
"  Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7818, 2, 3, 'Relationship Report', 1) " 


 
// Execute sqls
of_execute_sqls('of_update_version_151') 

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_152 ();//Start Code Change ----05.11.2016 #V15 maha
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7819) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	18	, 36	,7819 , 'Search Results Design'	, 1	) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7820) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	18	, 36	,7820 , 'DE Validation Setup'	, 1	) "
 
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1417) " + &
" Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1417, 'WebView Logs', 1) "
 
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7821) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	29	, 1417	,7821 , 'WV Aff Letter Log'	, 1	) "
 
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7822) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 120	,7822 , 'Edit Saved Application'	, 1	) "
 //End Code Change ----05.11.2016

 //Start Code Change ----07.05.2016 #V152 maha
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7823) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	27	, 110	,7823 , 'Image Validation Templates'	, 1	) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7824) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 38	,7824 , 'Image Reassociation'	, 1	) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7825) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	25	, 150	,7825 , 'Report Modifications'	, 1	) " 
 
 //End Code Change ----07.05.2016 

//Start Code Change ----07.11.2016 #V152 maha
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7826) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 3	,7826 , 'Address Find Edit Existing'	, 1	) " 
 
 //Start Code Change ----09.29.2016 #V152 maha - invoice security
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 101) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (101, 4, 'Invoices', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1418) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (101, 1418, 'Invoice Window', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1419) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (101, 1419, 'Provider Charges', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7827) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	101	, 1418	,7827 , 'View access'	, 2	) " 
 
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7828) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	101	, 1418	,7828 , 'Create Charges'	, 1	) " 
 
    is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7829) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	101	, 1418	,7829 , 'Delete Invoices'	, 1	) " 
 
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7830) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	101	, 1419	,7830 , 'View access'	, 2	) " 


// Execute sqls
of_execute_sqls('of_update_version_152') 

// Update rights of all roles
of_update_right()


end subroutine

public subroutine of_update_version_153 ();//Start Code Change ----12.13.2016 #V153 maha
//user documents
 is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 102) " + &
"   Insert into security_modules (module_id, software_version, module_name, prod_id) values (102, 4, 'User Documents', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1421) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (102, 1421, 'Main', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7833) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	102	, 1421	,7833 , 'View access'	, 1	) " 
 
//group documents
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1420) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (23, 1420, 'Location Documents', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7832) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	23	, 1420	,7832 , 'View access'	, 2	) " 
 
  //Start Code Change ----02.08.2017 #V153 maha
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7840) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 4	,7840 , 'Review Audit Tab'	, 2	) "   

   is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7841) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 4	,7841 , 'Review Audit Add'	, 1	) " 
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7842) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 5	,7842 , 'Review Audit'	, 2	) "   

  //Start Code Change ----02.08.2017 #V153 maha
    is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7843) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	1	, 1	,7843 , 'Send Email/Text'	, 1	) "   

    is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7844) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(		24, 160	,7844 , 'Import Applications'	, 1	) "  
// Execute sqls
of_execute_sqls('of_update_version_153') 

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_154 (); //Start Code Change ----05.24.2017 #V154 maha - facility_notes
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1428) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (2, 1428, 'Notes - Facility', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7852) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 1428	, 7852 , 'Access'	, 1	) " 

 //Start Code Change ----05.24.2017  //photo profile setup
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1429) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (12, 1429, 'Photo Profile Design', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7851) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	12	, 1429 	, 7851 , 'Acess'	, 1	) " 

 //Start Code Change ----05.26.2017  //intellibatch
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7853) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	25	, 230	, 7853 , 'Run Batch'	, 1	) " 

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7854) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	25	, 230, 7854 , 'Edit Existing Batch'	, 1	) " 

 //Start Code Change ----06.01.2017 #V154 maha - texting
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_modules where module_id = 104) " + &
" Insert into security_modules (module_id, software_version, module_name, prod_id) values (104, 4, 'Texting Providers', 1) "
 
  is_sql_statments[upperbound(is_sql_statments) + 1] = & 
 "if not exists (select 1 from security_sub_module where sub_module_id = 1430) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (104, 1430, 'Batch Texting', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from security_sub_module where sub_module_id = 1431) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (104, 1431, 'Texting Log', 1) "

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7855) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	104	, 1430, 7855 , 'View Access'	, 1	) " 

  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7856) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	104	, 1431, 7856 , 'View Access'	, 1	) " 

 //Start Code Change ----06.05.2017 #V154 maha - document override
  is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7859) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	2	, 38, 7859 , 'Allow Override when Adding'	, 1	) " 


 //Start Code Change ----10.05.2017 #V154 maha - document override
   is_sql_statments[upperbound(is_sql_statments) + 1] = &
 "if not exists (select 1 from security_sub_module where sub_module_id = 1432) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (16, 1432, 'Activity Report', 1) "

    is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action where action_id = 7860) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	16	, 1432, 7860 , 'Setup Access'	, 1	) " 
 
   is_sql_statments[upperbound(is_sql_statments) + 1] = &	
"if not exists (select 1 from security_rights_action where action_id = 7861) " + &
 "INSERT	INTO	security_rights_action	(	module_id	, sub_module_id		, action_id	, action_name	, dddw_type	)	VALUES	(	16	, 1432, 7861 , 'Run Access'	, 2	) " 

//Start Code Change ----10.10.2017 #V154 maha - carried forward from 12.3
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_sub_module where sub_module_id = 1070) " + &
"  Insert into security_sub_module (module_id, sub_module_id, sub_module_name, prod_id) values (29, 1070, 'WebView Email Settings', 1) "

is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7370) " + &
 " Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (7370, 29, 1070, 'Access Rights', 1) "


// Execute sqls
of_execute_sqls('of_update_version_154') 

// Update rights of all roles
of_update_right()
end subroutine

public subroutine of_update_version_161 ();//Start Code Change ----12.01.2017 #V16 maha - to allow work flow action edits
is_sql_statments[upperbound(is_sql_statments) + 1] = &
"if not exists (select 1 from security_rights_action  where action_id = 7862) " + &
 " Insert into security_rights_action (action_id, module_id, sub_module_id, action_name, dddw_type) values (2, 120, 7862, 'Workflow Action Edit', 1) "



// Execute sqls
of_execute_sqls('of_update_version_161') 

// Update rights of all roles
of_update_right()
end subroutine

on n_cst_update_role_right.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_role_right.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

