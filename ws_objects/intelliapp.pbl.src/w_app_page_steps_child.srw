$PBExportHeader$w_app_page_steps_child.srw
forward
global type w_app_page_steps_child from w_app_page_steps
end type
end forward

global type w_app_page_steps_child from w_app_page_steps
integer width = 1422
boolean minbox = true
windowtype windowtype = popup!
end type
global w_app_page_steps_child w_app_page_steps_child

on w_app_page_steps_child.create
call super::create
end on

on w_app_page_steps_child.destroy
call super::destroy
end on

event open;call super::open;//====================================================================
//$<Event>: open()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 10.30.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Adjust the field properties
dw_1.Modify("sort_order.Protect = 1")
dw_1.Modify("action_type.Protect = 1")
dw_1.Modify("element_name.Protect = 1")

end event

type st_2 from w_app_page_steps`st_2 within w_app_page_steps_child
boolean visible = false
integer x = 64
integer y = 804
end type

type st_1 from w_app_page_steps`st_1 within w_app_page_steps_child
boolean visible = false
integer x = 69
integer y = 732
end type

type cb_close from w_app_page_steps`cb_close within w_app_page_steps_child
integer x = 1015
integer y = 16
end type

type cb_add from w_app_page_steps`cb_add within w_app_page_steps_child
boolean visible = false
integer x = 439
integer y = 988
end type

type cb_2 from w_app_page_steps`cb_2 within w_app_page_steps_child
boolean visible = false
integer x = 782
integer y = 988
end type

type cb_save from w_app_page_steps`cb_save within w_app_page_steps_child
boolean visible = false
integer x = 91
integer y = 988
end type

type dw_1 from w_app_page_steps`dw_1 within w_app_page_steps_child
integer x = 32
integer y = 140
integer width = 1326
integer height = 2068
boolean hscrollbar = true
end type

