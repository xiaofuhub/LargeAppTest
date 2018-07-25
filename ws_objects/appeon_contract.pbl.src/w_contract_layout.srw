$PBExportHeader$w_contract_layout.srw
forward
global type w_contract_layout from w_popup
end type
type cb_reset from commandbutton within w_contract_layout
end type
type cb_ok from commandbutton within w_contract_layout
end type
type cb_apply from commandbutton within w_contract_layout
end type
type cb_close from commandbutton within w_contract_layout
end type
type uo_1 from u_cst_gadget_contract_details within w_contract_layout
end type
end forward

global type w_contract_layout from w_popup
integer width = 3986
integer height = 2296
string title = "Contract Details Layout Setting"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event ue_buttondown ( u_cst_gadget_contract auo_gadget )
event ue_buttonup ( )
event ue_mousemove ( )
event ue_vscrollbar pbm_vscroll
event ue_syscommand pbm_syscommand
event ue_nclbuttondblclk pbm_nclbuttondblclk
cb_reset cb_reset
cb_ok cb_ok
cb_apply cb_apply
cb_close cb_close
uo_1 uo_1
end type
global w_contract_layout w_contract_layout

type variables
u_cst_gadget_contract 	iuo_current_gadget 
u_cst_gadget_contract	iuo_gadget_list[]
Boolean 	ib_mouse_down, ib_title, ib_bottom
Long 		il_pointer_x_ini, il_pointer_y_ini
Boolean 	ib_vdivider = False
Long 		il_x = 0 
Boolean  ib_modify = False
Long 		il_view_id 
end variables

event ue_buttondown(u_cst_gadget_contract auo_gadget);////====================================================================
//// Event: ue_buttondown
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
////                auo_gadget
////--------------------------------------------------------------------
//// Returns:  (none)
////--------------------------------------------------------------------
//// Author:	Mark Lee		Date: 01/17/2013
////--------------------------------------------------------------------
////	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//iuo_current_gadget = auo_gadget
////iuo_current_gadget.bringtotop = True
//ib_mouse_down = True
//ib_bottom = iuo_current_gadget.ib_from_bottom
//ib_title 	= iuo_current_gadget.ib_from_title
//il_pointer_x_ini = PointerX() 
//il_pointer_y_ini = PointerY()
//
end event

event ue_buttonup();////====================================================================
//// Event: ue_buttonup
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
////--------------------------------------------------------------------
//// Returns:  (None)
////--------------------------------------------------------------------
//// Author:	Mark Lee		Date: 01/17/2013
////--------------------------------------------------------------------
////	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//If Not isvalid(iuo_current_gadget) Then Return
//
//ib_mouse_down = False
//
//IF ib_bottom or ib_title Then
//	//Reset Position
//	of_set_position()
//End IF
//
//iuo_current_gadget.of_release_button()
//
//ib_bottom = False
//ib_title 	= False
//
//ib_modify = True 
end event

event ue_mousemove();////====================================================================
//// Event: ue_mousemove
////--------------------------------------------------------------------
//// Description:
////--------------------------------------------------------------------
//// Arguments:
////--------------------------------------------------------------------
//// Returns:  (None)
////--------------------------------------------------------------------
//// Author:	Mark Lee		Date: 01/17/2013
////--------------------------------------------------------------------
////	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
////--------------------------------------------------------------------
//// Modify History:
////
////====================================================================
//If PointerX() < 10 or PointerY() < 10 Then Return
//If PointerX() > This.width	or PointerY() > This.Height Then Return
//
//IF ib_title = True Then 
//	iuo_current_gadget.Move(iuo_current_gadget.x + (PointerX() - il_pointer_X_ini) ,iuo_current_gadget.y + (PointerY() - il_pointer_Y_ini))
//ElseIf ib_bottom = True Then 
//	iuo_current_gadget.resize( iuo_current_gadget.width , iuo_current_gadget.height + (PointerY() - il_pointer_Y_ini) )
//End If 
//
//il_pointer_X_ini = PointerX()
//il_pointer_Y_ini = PointerY()
//
end event

event ue_syscommand;////////====================================================================
//////// Event: ue_syscommand
////////--------------------------------------------------------------------
//////// Description: max and min
////////--------------------------------------------------------------------
//////// Arguments:
////////                commandtype
////////                xpos
////////                ypos
////////--------------------------------------------------------------------
//////// Returns:  long
////////--------------------------------------------------------------------
//////// Author:	Mark Lee		Date: 01/15/2013
////////--------------------------------------------------------------------
////////	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
////////--------------------------------------------------------------------
//////// Modify History:
////////
////////====================================================================
////commandtype = 61488 or commandtype = 61472  or commandtype = 61730  or commandtype = 61458 or
//If commandtype = 61458  or commandtype = 61728 or commandtype = 61730   then 
//	Return 1
//End If 
//
////this.title = string(commandtype)
end event

event ue_nclbuttondblclk;//// comment	 Maximized event
//return 1
//
end event

on w_contract_layout.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.cb_ok=create cb_ok
this.cb_apply=create cb_apply
this.cb_close=create cb_close
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_apply
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.uo_1
end on

on w_contract_layout.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.cb_ok)
destroy(this.cb_apply)
destroy(this.cb_close)
destroy(this.uo_1)
end on

event open;call super::open;
il_view_id =	Message.doubleparm
uo_1.il_view_id = il_view_id

uo_1.of_create_dw( )
uo_1.of_get_position( False )
end event

event resize;call super::resize;//if isvalid(inv_resize) then
//   this.inv_resize.of_resize( this.control[],handle(this)  )
//end if

this.uo_1.x = 15
this.uo_1.y = 15

this.uo_1.width = this.width - 30
this.uo_1.height = this.height - 300

uo_1.resize( this.width - 30,this.height - 300)

cb_apply.y = this.height - cb_apply.height - 136
cb_close.y = cb_apply.y 
cb_ok.y = cb_apply.y 
cb_reset.y = cb_apply.y 

cb_apply.x = this.width - cb_apply.width - 136
cb_close.x = cb_apply.x - cb_close.width - 68
cb_ok.x 	  =  cb_close.x - cb_ok.width - 68
cb_reset.x = cb_ok.x - cb_reset.width - 68
end event

event closequery;//
Return 0
end event

type cb_reset from commandbutton within w_contract_layout
integer x = 2331
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;Integer 	li_rtn 	= 0
String 	ls_msg


ls_msg = "Are you sure you want to reset the current layout to the default layout? ~r~n"
li_rtn  = Messagebox(gnv_app.iapp_object.DisplayName,ls_msg, Question!,OKCancel! )

If li_rtn = 1 Then 
	Delete From security_viewid_options
	Where view_id = :il_view_id ;
	
	uo_1.of_set_other_default_position(True)
	uo_1.of_get_position( True)
End If 
end event

type cb_ok from commandbutton within w_contract_layout
integer x = 2770
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer 	li_rtn 	= 0
String 	ls_msg


If uo_1.ib_modify = true and isvalid(gw_contract) Then 
	ls_msg = "The system needs to close the Contract Folder for the new design to take effect. ~r~n~r~n"+ & 
			"Click Yes to save the design and reopen Contract Folder.~r~n"+ &
			"Click No to save the design only. " 
	li_rtn  = Messagebox(gnv_app.iapp_object.DisplayName,ls_msg, Exclamation!,YesNo! )
End If

uo_1.of_layout_position_save( )

IF li_rtn = 1 Then 
	If isvalid(w_contract) Then
		w_contract.ib_IsMDIClose = True
		Close(w_contract)
	End If 
	If isvalid(gw_contract) Then
		gw_contract.ib_IsMDIClose = True
		Close(gw_contract)
	End If 
	PowerObject lpo_NullParm
	gf_OpenContractFolder(lpo_NullParm)
	
End If 

parent.cb_close.event clicked( )

end event

type cb_apply from commandbutton within w_contract_layout
integer x = 3593
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Apply"
end type

event clicked;uo_1.of_layout_position_save( )

this.enabled = False
end event

type cb_close from commandbutton within w_contract_layout
integer x = 3182
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;
Close(Parent)
end event

type uo_1 from u_cst_gadget_contract_details within w_contract_layout
integer taborder = 50
boolean border = true
borderstyle borderstyle = styleraised!
end type

on uo_1.destroy
call u_cst_gadget_contract_details::destroy
end on

