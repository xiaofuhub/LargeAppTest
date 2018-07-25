$PBExportHeader$u_cst_gadget_todolist.sru
forward
global type u_cst_gadget_todolist from u_cst_gadget
end type
type uo_todolist from u_cst_todolist within u_cst_gadget_todolist
end type
end forward

global type u_cst_gadget_todolist from u_cst_gadget
string tag = "u_gadget_1.To Do List"
integer width = 2839
integer height = 1704
uo_todolist uo_todolist
end type
global u_cst_gadget_todolist u_cst_gadget_todolist

type variables
Boolean ib_initialized = False
end variables

forward prototypes
public subroutine of_set_bg_color (long al_color_value)
public function integer of_settings ()
end prototypes

public subroutine of_set_bg_color (long al_color_value);uo_todolist.of_set_bg_color(al_color_value)
end subroutine

public function integer of_settings ();OpenwithParm(w_dashboard_gadget_todolist_config,This)


Return 1
end function

on u_cst_gadget_todolist.create
int iCurrent
call super::create
this.uo_todolist=create uo_todolist
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_todolist
end on

on u_cst_gadget_todolist.destroy
call super::destroy
destroy(this.uo_todolist)
end on

event ue_retrieve;//Override Ancestor Script

//Use Post Event to JUMP OUT appeon-queue
//uo_todolist.Post Event ue_retrieve_todolist()
uo_todolist.cb_refresh.Post Event clicked( ) //Modified By Ken.Guo 2011-04-19

uo_todolist.event ue_refresh_unread_email( )
end event

event resize;call super::resize;uo_todolist.x = 0
uo_todolist.y = st_title.y + st_title.height + 8

If uo_todolist.width <> This.width - 25 or uo_todolist.height <> This.height - 72 Then
	uo_todolist.width = This.width - 25
	uo_todolist.height = This.height - 72
	uo_todolist.Event ue_resize()
End If
end event

event ue_do;call super::ue_do;If Not ib_initialized Then
	uo_todolist.event ue_ini()
	ib_initialized = True
End If
Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_todolist
boolean visible = false
integer x = 1426
integer y = 968
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_todolist
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_todolist
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_todolist
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_todolist
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_todolist
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_todolist
end type

type uo_todolist from u_cst_todolist within u_cst_gadget_todolist
integer y = 88
integer height = 1612
integer taborder = 30
boolean bringtotop = true
long backcolor = 33551856
end type

on uo_todolist.destroy
call u_cst_todolist::destroy
end on

event ue_close;//Override Ancestor Script
pb_close.Trigger Event clicked()
end event

event constructor;call super::constructor;//cb_close.enabled = False
end event

