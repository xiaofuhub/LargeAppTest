$PBExportHeader$w_get_view_name.srw
forward
global type w_get_view_name from w_get_lookup_name
end type
end forward

global type w_get_view_name from w_get_lookup_name
integer width = 1970
integer height = 328
string title = "View Name"
end type
global w_get_view_name w_get_view_name

type variables
//$<add> 01.04.2008 by: Andy
String is_type_c
end variables

on w_get_view_name.create
call super::create
end on

on w_get_view_name.destroy
call super::destroy
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.04.2008 by: Andy
is_type_c = Message.StringParm
//---------------------------- APPEON END ----------------------------
end event

type st_1 from w_get_lookup_name`st_1 within w_get_view_name
integer x = 110
integer y = 60
string text = "View Name"
end type

type sle_1 from w_get_lookup_name`sle_1 within w_get_view_name
integer x = 110
integer y = 124
integer width = 1097
integer height = 96
end type

type cb_1 from w_get_lookup_name`cb_1 within w_get_view_name
integer x = 1243
integer y = 124
end type

event cb_1::clicked;String ls_retval
string ls_dataview

//$<modify> 01.07.2008 by: Andy Reason: fixed BugN122721
//ls_retval = sle_1.Text
ls_retval = trim(sle_1.Text)
//end of modify
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Frank.Gui
//$<reason> 
IF ls_retval='' THEN
	messagebox('Alert','Please enter a view name.')
	return
END IF
//---------------------------- APPEON END ----------------------------

select data_view_name 
into :ls_dataview
from data_view
where data_view_name = :ls_retval 
	and upper(type_c) = upper(:is_type_c);//$<add> 01.04.2008 by: Andy Reason:Should identify the type(P or C).

if LenA (ls_dataview) > 0 THEN 
	MESSAGEBOX(PARENT.TITLE, 'View with this name exists. Please create a new one.')
else
	CloseWithReturn(Parent, sle_1.Text )
END IF 





end event

type gb_1 from w_get_lookup_name`gb_1 within w_get_view_name
boolean visible = false
integer y = 308
end type

type rb_a from w_get_lookup_name`rb_a within w_get_view_name
boolean visible = false
integer y = 388
end type

type rb_c from w_get_lookup_name`rb_c within w_get_view_name
boolean visible = false
integer y = 392
end type

type cb_2 from w_get_lookup_name`cb_2 within w_get_view_name
integer x = 1061
integer y = 528
integer height = 76
end type

type cb_3 from w_get_lookup_name`cb_3 within w_get_view_name
integer x = 1582
integer y = 124
end type

