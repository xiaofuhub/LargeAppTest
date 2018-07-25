$PBExportHeader$w_get_checklist_name.srw
forward
global type w_get_checklist_name from w_get_view_name
end type
end forward

global type w_get_checklist_name from w_get_view_name
integer width = 1993
integer height = 344
string title = "Enter New Template Name"
long backcolor = 33551856
end type
global w_get_checklist_name w_get_checklist_name

on w_get_checklist_name.create
call super::create
end on

on w_get_checklist_name.destroy
call super::destroy
end on

type st_1 from w_get_view_name`st_1 within w_get_checklist_name
long backcolor = 33551856
string text = "Template Name"
end type

type sle_1 from w_get_view_name`sle_1 within w_get_checklist_name
end type

type cb_1 from w_get_view_name`cb_1 within w_get_checklist_name
end type

event cb_1::clicked;String ls_retval
string ls_name

ls_retval = trim(sle_1.Text)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF ls_retval='' THEN
	messagebox('Alert','Please enter a template name.')
	return
END IF
//---------------------------- APPEON END ----------------------------

select template_name 
into :ls_name
from data_view_app_audit_template
where template_name = :ls_retval;

if LenA (ls_name) > 0 THEN 
	MESSAGEBOX(PARENT.TITLE, 'A template with this name currently exists. Please add a new one.')
	return
else
	CloseWithReturn(Parent,ls_retval )
END IF 





end event

type gb_1 from w_get_view_name`gb_1 within w_get_checklist_name
end type

type rb_a from w_get_view_name`rb_a within w_get_checklist_name
end type

type rb_c from w_get_view_name`rb_c within w_get_checklist_name
end type

type cb_2 from w_get_view_name`cb_2 within w_get_checklist_name
boolean visible = false
integer x = 1157
integer y = 276
boolean cancel = true
end type

type cb_3 from w_get_view_name`cb_3 within w_get_checklist_name
integer x = 1605
integer taborder = 50
string text = "&Cancel"
end type

