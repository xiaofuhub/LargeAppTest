$PBExportHeader$n_cst_update_wv_hist.sru
forward
global type n_cst_update_wv_hist from nonvisualobject
end type
end forward

global type n_cst_update_wv_hist from nonvisualobject autoinstantiate
end type

type variables
//Update WV history data for PracView Mobile - Alfee 12.10.2015

String is_sql_statements[]
end variables

forward prototypes
public function integer of_execute (string as_sql, string as_title)
public subroutine of_execute_sqls (string as_title)
public function integer of_startup_esign ()
public function integer of_startup_verify_db_setup ()
public function integer of_startup_verify_workflow_schema ()
public function integer of_startup_verify_painters ()
public function integer of_startup_verify_security_modules ()
public function integer of_startup_verify_security_role ()
public function integer of_startup_verify_security_role_rights ()
public function integer of_startup_dynamicgen_privviewopts_set ()
public function integer of_startup_upload_letter_into_db ()
public function integer of_startup_process ()
end prototypes

public function integer of_execute (string as_sql, string as_title);//Alfee 12.10.2015

Yield()

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
// Created By	: Alfee 12.10.2015
//------------------------------------------------------------------------------
Long ll_i
String ls_null[]

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
END IF

is_sql_statements = ls_null

RETURN
end subroutine

public function integer of_startup_esign ();RETURN 1
end function

public function integer of_startup_verify_db_setup ();RETURN 1
end function

public function integer of_startup_verify_workflow_schema ();RETURN 1
end function

public function integer of_startup_verify_painters ();RETURN 1
end function

public function integer of_startup_verify_security_modules ();RETURN 1
end function

public function integer of_startup_verify_security_role ();RETURN 1
end function

public function integer of_startup_verify_security_role_rights ();RETURN 1
end function

public function integer of_startup_dynamicgen_privviewopts_set ();RETURN 1
end function

public function integer of_startup_upload_letter_into_db ();RETURN 1
end function

public function integer of_startup_process ();//Update history tables and data from WebView - Added for Pracview Mobile by alfee 12.16.2015

RETURN 1
end function

on n_cst_update_wv_hist.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_wv_hist.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

