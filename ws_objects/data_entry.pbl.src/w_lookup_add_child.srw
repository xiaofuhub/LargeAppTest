$PBExportHeader$w_lookup_add_child.srw
forward
global type w_lookup_add_child from w_lookup_add
end type
end forward

global type w_lookup_add_child from w_lookup_add
boolean minbox = true
windowtype windowtype = popup!
end type
global w_lookup_add_child w_lookup_add_child

on w_lookup_add_child.create
call super::create
end on

on w_lookup_add_child.destroy
call super::destroy
end on

type cb_clip from w_lookup_add`cb_clip within w_lookup_add_child
end type

type cb_close from w_lookup_add`cb_close within w_lookup_add_child
end type

type cb_save from w_lookup_add`cb_save within w_lookup_add_child
end type

type sle_1 from w_lookup_add`sle_1 within w_lookup_add_child
end type

type dw_1 from w_lookup_add`dw_1 within w_lookup_add_child
end type

event dw_1::clicked;call super::clicked;if ib_view = false then return 1

if dwo.type = "column" then
	is_drag_field_name = dwo.name
	is_value = this.getitemstring(this.getrow(), is_drag_field_name)
	this.Drag(Begin!)
	idw_detail.is_typedown_value = is_value
else
	is_drag_field_name = ""
end if
end event

type st_message from w_lookup_add`st_message within w_lookup_add_child
end type

