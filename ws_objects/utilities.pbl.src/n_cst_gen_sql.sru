$PBExportHeader$n_cst_gen_sql.sru
forward
global type n_cst_gen_sql from nonvisualobject
end type
end forward

global type n_cst_gen_sql from nonvisualobject autoinstantiate
end type

forward prototypes
public function string of_gen_sql_insert (datawindow adw[])
end prototypes

public function string of_gen_sql_insert (datawindow adw[]);//====================================================================
//$<Function>: of_gen_sql_insert
//$<Arguments>:
// 	value    datawindow    adw[]
//$<Return>:  string
//$<Description>: Generate insert sql by adw[]
//$<Author>: (Appeon) long.zhang 11.02.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_old_dbparm, ls_return = ''
Int i, j
Int li_rtn
Boolean lb_autocommit
n_ds_gen_sql lds_save

If UpperBound(adw[]) = 0 Then Return ''

lds_save = Create n_ds_gen_sql

//Remember DBPARM and AUTOCOMMIT.
ls_old_dbparm = SQLCA.DBPARM
lb_autocommit = SQLCA.AUTOCOMMIT

SQLCA.DBPARM = "DISABLEBIND = 1"

SQLCA.AUTOCOMMIT = True
SQLCA.AUTOCOMMIT = False
	
//adw[]
For j = 1 to UpperBound(adw[]) 
	If adw[j].RowCount() > 0 Then
		lds_save.dataobject = adw[j].dataobject
		lds_save.SetTransObject(SQLCA);
		
		//Rows
		For i = 1 to adw[j].RowCount()
			adw[j].RowsCopy(i,  i, Primary!, lds_save, 1, Primary!)	 
			
			//Generate DBError and get insert sql from it.
			li_rtn = lds_save.Update()
			If li_rtn = -1 and LenA(lds_save.is_last_sql) >0 Then
				ls_return += lds_save.is_last_sql +'~r~n'
			End If
		Next
	End If
	ls_return += '~r~n'
Next

//Restore DBPARM and AUTOCOMMIT.
Rollback Using SQLCA;
SQLCA.AUTOCOMMIT = lb_autocommit
SQLCA.DBPARM = ls_old_dbparm
	
Destroy lds_save

Return ls_return
end function

on n_cst_gen_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_gen_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

