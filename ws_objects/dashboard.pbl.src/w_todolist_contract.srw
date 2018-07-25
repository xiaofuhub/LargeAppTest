$PBExportHeader$w_todolist_contract.srw
forward
global type w_todolist_contract from w_todolist
end type
end forward

global type w_todolist_contract from w_todolist
integer width = 2843
integer height = 1612
boolean titlebar = false
string title = ""
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = child!
boolean ib_movetozero = false
end type
global w_todolist_contract w_todolist_contract

type variables

end variables

forward prototypes
public subroutine of_adjustsize ()
public subroutine of_refreshdata ()
public subroutine of_reset ()
end prototypes

public subroutine of_adjustsize ();//====================================================================
// Function: of_adjustsize
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 12/21/2012
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
long	ll_XPos,ll_YPos,ll_Width,ll_Height, ll_width_browse, ll_x_browse, ll_move_x, ll_move_x_browse, ll_move_y
DataWindow	ldw_Browse, ldw_search
Long 		ll_width_doc_id

if IsValid(gw_Contract) then
	
	ldw_Browse = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1
	ldw_search = gw_Contract.tab_contract_details.tabpage_search.dw_search

	ll_XPos = gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + ldw_search.X
	ll_YPos = gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + ldw_Browse.Y

	ll_Height = ldw_Browse.height
	
	//Position Setting					// 1 : Document Preview left ; 					0 : Document Preview right;	 
											// 1 : Contract Parent Child Tree right; 		0 : Contract Parent Child Tree Left; 
	//is_position_setting_other		// 1 : To Do List left;								0 : To Do List right;
	If  gw_Contract.tab_contract_details.tabpage_search.is_position_setting_other = '0' then
		
		If gw_Contract.tab_contract_details.tabpage_search.st_hbar2.visible = True Then 
//Added By Mark Lee 04/08/2013
//			gw_Contract.tab_contract_details.tabpage_search.tv_ctx.height = gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y - gw_Contract.tab_contract_details.tabpage_search.tv_ctx.y - 10	
			gw_Contract.tab_contract_details.tabpage_search.tv_ctx.height = gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y - gw_Contract.tab_contract_details.tabpage_search.tv_ctx.y 
			gw_Contract.tab_contract_details.tabpage_search.st_hbar2.x = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar.width	
			gw_Contract.tab_contract_details.tabpage_search.st_hbar2.width = ldw_search.x + ldw_search.width - gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - gw_Contract.tab_contract_details.tabpage_search.st_vbar.width

//			ll_move_x 	=	gw_Contract.tab_contract_details.tabpage_search.tv_ctx.x +15
			ll_move_x 	=	gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + gw_Contract.tab_contract_details.tabpage_search.tv_ctx.x 
			ll_Width 		= 	gw_Contract.tab_contract_details.tabpage_search.tv_ctx.width
//			ll_move_y 	=  gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.height + 10
			ll_move_y 	=  gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.height + 10
//			ll_Height 		=  ll_YPos + ldw_Browse.height -  ll_move_y		//Added By Mark Lee 04/12/2013
			ll_Height 		=  ll_YPos + ldw_Browse.height -  ll_move_y -3
		Else
			//Added By Mark Lee 04/08/2013
//			ll_move_x 	=  gw_Contract.tab_contract_details.tabpage_search.st_vbar.x  +  gw_Contract.tab_contract_details.tabpage_search.st_vbar.width + 18 + 10
			ll_move_x 	=  gw_Contract.tab_contract_details.X + gw_Contract.tab_contract_details.tabpage_search.X + gw_Contract.tab_contract_details.tabpage_search.st_vbar.x  +  gw_Contract.tab_contract_details.tabpage_search.st_vbar.width + 10
//			ll_Width 		=  ldw_search.x + ldw_search.width - ll_move_x + 18		
			ll_Width 		=  ll_XPos + ldw_search.width - ll_move_x 
			ll_move_y    =  ll_YPos 
			ll_Height		=  	 ldw_Browse.height
			
			If  gw_Contract.tab_contract_details.tabpage_search.st_vbar2.visible = True Then
//				ll_x_browse =  gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width 
				ll_x_browse =  gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x + gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width + 10
				ll_width_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_x_browse
			Else
//				ll_x_browse = ll_XPos				//Added By Mark Lee 04/08/2013
				ll_x_browse = ldw_search.x
				ll_width_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_x_browse 
			End If
			
//			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.move( ll_x_browse, ldw_Browse.Y)
//			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.resize(ll_width_browse, ldw_Browse.height)
			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.x = ll_x_browse
			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.width = ll_width_browse
		End If
	Else 
		If gw_Contract.tab_contract_details.tabpage_search.st_hbar2.visible = True Then 
			//Added By Mark Lee 04/08/2013
//			gw_Contract.tab_contract_details.tabpage_search.tv_ctx.height = gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y - gw_Contract.tab_contract_details.tabpage_search.tv_ctx.y - 10					
			gw_Contract.tab_contract_details.tabpage_search.tv_ctx.height = gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y - gw_Contract.tab_contract_details.tabpage_search.tv_ctx.y 					
			gw_Contract.tab_contract_details.tabpage_search.st_hbar2.x = ldw_search.x	
			gw_Contract.tab_contract_details.tabpage_search.st_hbar2.width = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x - ldw_search.x	
			
//			ll_move_x 	=  gw_Contract.tab_contract_details.tabpage_search.tv_ctx.x+15
			ll_move_x 	=  ll_XPos
			ll_Width 		= 	gw_Contract.tab_contract_details.tabpage_search.tv_ctx.width
			ll_move_y 	=  gw_Contract.tab_contract_details.Y + gw_Contract.tab_contract_details.tabpage_search.Y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.y + gw_Contract.tab_contract_details.tabpage_search.st_hbar2.height + 10
			ll_Height 		=  ll_YPos + ldw_Browse.height -  ll_move_y
		Else
			ll_move_x 	=  ll_XPos 
			ll_Width 		=  w_Contract.tab_contract_details.tabpage_search.st_vbar2.x - ll_move_x 
			ll_move_y    =  ll_YPos
			ll_Height		=  ldw_Browse.height

			ll_x_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar2.x +gw_Contract.tab_contract_details.tabpage_search.st_vbar2.width
			If gw_Contract.tab_contract_details.tabpage_search.st_vbar.visible = True Then 
				ll_width_browse = gw_Contract.tab_contract_details.tabpage_search.st_vbar.x - ll_x_browse
			Else
				ll_width_browse = ldw_search.x + ldw_search.width - ll_x_browse
			End If
//			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.move( ll_x_browse, ldw_Browse.y)
//			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.resize(ll_width_browse, ldw_Browse.height)
			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.x = ll_x_browse
			gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.width = ll_width_browse
		End If
	End If

	This.Move(ll_move_x,ll_move_y)
	This.Resize(ll_Width,ll_Height) 
			
	gw_Contract.tab_contract_details.tabpage_search.gb_to_do_list.move(ll_move_x, ll_move_y)		
	gw_Contract.tab_contract_details.tabpage_search.gb_to_do_list.resize( ll_Width, ll_Height)

//	If AppeonGetClientType() = 'WEB' then 
		uo_todolist.resize(ll_Width, ll_Height - 20 )
		uo_todolist.event ue_resize( )
		uo_todolist.of_invisible_close_button( False)
//	End If
end if

uo_todolist.cb_max.bringtotop = True //Added By Ken.Guo 04/10/2013
end subroutine

public subroutine of_refreshdata ();//Added By Mark Lee 12/25/2012  refresh data
if IsValid(gw_Contract) then
	this.uo_todolist.ibn_use_ctx_id = True
	this.uo_todolist.il_ctx_id = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
	uo_todolist.Post Event ue_retrieve_todolist()		
	This.Event ue_refresh_unread_email()
	If isnull(uo_todolist.il_ctx_id)  and uo_todolist.il_ctx_id = 0 Then 
		this.uo_todolist.dw_facility.modify( "gb_1.text = 'Filter' ")
	Else
		this.uo_todolist.dw_facility.modify( "gb_1.text = 'Filter For CTX #"+String(uo_todolist.il_ctx_id)+"' ")
	End If
End If
end subroutine

public subroutine of_reset ();//Added By Mark Lee 12/25/2012			clear data
If isvalid(gw_contract) Then
	this.uo_todolist.ibn_use_ctx_id = True
	this.uo_todolist.il_ctx_id = 0
	uo_todolist.Post Event ue_retrieve_todolist()
	this.uo_todolist.dw_facility.modify( "gb_1.text = 'Filter' ")

End if 
end subroutine

on w_todolist_contract.create
int iCurrent
call super::create
end on

on w_todolist_contract.destroy
call super::destroy
end on

event open;call super::open;if IsValid(gw_Contract) then
	uo_todolist.of_invisible_close_button( False)
	of_AdjustSize()	
	//uo_todolist.of_set_contractmodule('Y')  //(Appeon)Harry 03.20.2014 - V142 ISG-CLX
	//refreshdata
//	this.of_refreshdata()
end if

uo_todolist.of_set_contractmodule('Y')  //(Appeon)Harry 03.20.2014 - V142 ISG-CLX
end event

event resize;//uo_todolist.event ue_resize( )			//Added By Mark Lee 12/26/2012
//uo_todolist.cb_close.visible = False				//need close this button.
//uo_todolist.p_close.visible = False
end event

event pfc_postopen;call super::pfc_postopen;//Added By Mark Lee 01/03/2013
If IsValid(gw_Contract) then
	uo_todolist.il_ctx_id = 0 
	this.uo_todolist.ibn_use_ctx_id = True
End If
end event

event activate;//Added By Mark Lee 03/27/2013 do not refresh the menu
end event

type uo_todolist from w_todolist`uo_todolist within w_todolist_contract
end type

