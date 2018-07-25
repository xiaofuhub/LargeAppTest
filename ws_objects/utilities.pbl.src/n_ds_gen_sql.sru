$PBExportHeader$n_ds_gen_sql.sru
forward
global type n_ds_gen_sql from datastore
end type
end forward

global type n_ds_gen_sql from datastore
end type
global n_ds_gen_sql n_ds_gen_sql

type variables
String is_last_sql = ''
end variables

event dberror;//====================================================================
//$<Event>: dberror
//$<Arguments>:
// 	value    long        sqldbcode
// 	value    string      sqlerrtext
// 	value    string      sqlsyntax
// 	value    dwbuffer    buffer
// 	value    long        row
//$<Return>:  long
//$<Description>: Set insert sql to is_last_sql in this event.
//$<Author>: (Appeon) long.zhang 11.02.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_pos = 0

li_pos = PosA(Upper(sqlsyntax), 'INSERT INTO')
If li_pos >= 1 Then
	is_last_sql = MidA(sqlsyntax,li_pos)
Else
	is_last_sql = ''
End If

end event

on n_ds_gen_sql.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ds_gen_sql.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

