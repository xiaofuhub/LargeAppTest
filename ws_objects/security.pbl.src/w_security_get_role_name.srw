$PBExportHeader$w_security_get_role_name.srw
forward
global type w_security_get_role_name from w_get_view_name
end type
end forward

global type w_security_get_role_name from w_get_view_name
integer width = 1993
integer height = 312
string title = "Enter New Role Name"
end type
global w_security_get_role_name w_security_get_role_name

on w_security_get_role_name.create
call super::create
end on

on w_security_get_role_name.destroy
call super::destroy
end on

type st_1 from w_get_view_name`st_1 within w_security_get_role_name
string text = "Role Name"
end type

type sle_1 from w_get_view_name`sle_1 within w_security_get_role_name
end type

type cb_1 from w_get_view_name`cb_1 within w_security_get_role_name
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

event cb_1::clicked;String ls_retval
string ls_dataview

ls_retval = trim(sle_1.Text)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF ls_retval='' THEN
	messagebox('Alert','Please enter a role name.')
	return
END IF
//---------------------------- APPEON END ----------------------------

select role_name 
into :ls_dataview
from security_roles
where role_name = :ls_retval;

if LenA (ls_dataview) > 0 THEN 
	MESSAGEBOX(PARENT.TITLE, 'Current role already exists. Please create a new one.')
	return
else
	CloseWithReturn(Parent,ls_retval )
END IF 





end event

type gb_1 from w_get_view_name`gb_1 within w_security_get_role_name
end type

type rb_a from w_get_view_name`rb_a within w_security_get_role_name
end type

type rb_c from w_get_view_name`rb_c within w_security_get_role_name
end type

type cb_2 from w_get_view_name`cb_2 within w_security_get_role_name
boolean visible = false
integer x = 1157
integer y = 248
boolean cancel = true
end type

type cb_3 from w_get_view_name`cb_3 within w_security_get_role_name
integer x = 1605
integer taborder = 50
string text = "&Cancel"
end type

