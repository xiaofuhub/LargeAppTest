$PBExportHeader$u_cst_gadget_contract_details.sru
forward
global type u_cst_gadget_contract_details from userobject
end type
type st_msg from statictext within u_cst_gadget_contract_details
end type
type u_gadget_4 from u_cst_gadget_contract within u_cst_gadget_contract_details
end type
type u_gadget_5 from u_cst_gadget_contract within u_cst_gadget_contract_details
end type
type u_gadget_6 from u_cst_gadget_contract within u_cst_gadget_contract_details
end type
type st_vbar from u_st_splitbar within u_cst_gadget_contract_details
end type
type uo_tab_detail from u_cst_gadget_contract_detail_detail within u_cst_gadget_contract_details
end type
type u_gadget_7 from u_cst_gadget_contract within u_cst_gadget_contract_details
end type
type gb_left from groupbox within u_cst_gadget_contract_details
end type
type gb_right from groupbox within u_cst_gadget_contract_details
end type
type u_gadget_3 from u_cst_gadget_contract within u_cst_gadget_contract_details
end type
type st_hbar from u_st_splitbar within u_cst_gadget_contract_details
end type
end forward

global type u_cst_gadget_contract_details from userobject
integer width = 3977
integer height = 2060
boolean vscrollbar = true
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_buttondown ( u_cst_gadget_contract auo_gadget )
event ue_buttonup ( )
event ue_mousemove ( )
event ue_nclbuttondblclk pbm_nclbuttondblclk
event resize pbm_size
st_msg st_msg
u_gadget_4 u_gadget_4
u_gadget_5 u_gadget_5
u_gadget_6 u_gadget_6
st_vbar st_vbar
uo_tab_detail uo_tab_detail
u_gadget_7 u_gadget_7
gb_left gb_left
gb_right gb_right
u_gadget_3 u_gadget_3
st_hbar st_hbar
end type
global u_cst_gadget_contract_details u_cst_gadget_contract_details

type variables
u_cst_gadget_contract 	iuo_current_gadget 
u_cst_gadget_contract	iuo_gadget_list[]
Boolean 	ib_mouse_down, ib_title, ib_bottom
Long 		il_pointer_x_ini, il_pointer_y_ini
Boolean  ib_product_visible  = False
Boolean  ib_date_visible  = False
Long 		il_x = 0 
Boolean  ib_modify = False
Long 		il_view_id 

w_contract_layout	iw_parent

n_ds 			ids_screen_prop
end variables

forward prototypes
public subroutine of_layout_position_save ()
public function integer of_generate_control ()
public subroutine of_set_position ()
public subroutine of_get_layout_list (ref u_cst_gadget_contract auo_new_right[], ref u_cst_gadget_contract auo_new_left[], long al_x)
public subroutine of_create_dw ()
public function integer of_getparentwindow (window aw_parent)
public subroutine of_set_dw_title ()
public subroutine of_get_position (boolean abn_reset_flag)
public subroutine of_set_other_default_position (boolean abn_reset_flag)
end prototypes

event ue_buttondown(u_cst_gadget_contract auo_gadget);//====================================================================
// Event: ue_buttondown
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                auo_gadget
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/17/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
iuo_current_gadget = auo_gadget
//iuo_current_gadget.bringtotop = True
ib_mouse_down = True
ib_bottom = iuo_current_gadget.ib_from_bottom
ib_title 	= iuo_current_gadget.ib_from_title
il_pointer_x_ini = PointerX() 
il_pointer_y_ini = PointerY()

end event

event ue_buttonup();//====================================================================
// Event: ue_buttonup
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/17/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
If Not isvalid(iuo_current_gadget) Then Return

ib_mouse_down = False

IF ib_bottom or ib_title Then
	//Reset Position
	of_set_position()
End IF

iuo_current_gadget.of_release_button()

ib_bottom = False
ib_title 	= False

ib_modify = True 

If isvalid(w_contract_layout)  Then
	w_contract_layout.cb_apply.enabled = True
End IF 
end event

event ue_mousemove();//====================================================================
// Event: ue_mousemove
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/17/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
If PointerX() < 10 or PointerY() < 10 Then Return
If PointerX() > This.width	or PointerY() > This.Height Then Return

IF ib_title = True Then 
	iuo_current_gadget.Move(iuo_current_gadget.x + (PointerX() - il_pointer_X_ini) ,iuo_current_gadget.y + (PointerY() - il_pointer_Y_ini))
ElseIf ib_bottom = True Then  
	IF iuo_current_gadget.st_bottom.y >= iuo_current_gadget.st_title.y + iuo_current_gadget.st_title.height + 60 or &
		iuo_current_gadget.PointerY() >  iuo_current_gadget.st_title.y + iuo_current_gadget.st_title.height + 60  Then 
		iuo_current_gadget.height =  iuo_current_gadget.height + (PointerY() - il_pointer_Y_ini)
	Else
		Return  
	End IF 
End If 

il_pointer_X_ini = PointerX()
il_pointer_Y_ini = PointerY()

end event

event ue_nclbuttondblclk;//// comment	 Maximized event
//return 1
end event

event resize;of_set_other_default_position(False)

//layout
of_get_position(False)
end event

public subroutine of_layout_position_save ();u_cst_gadget_contract 	luo_new_right[] , luo_new_left[]
Integer 		i, li_upperbound, li_position
Long 			ll_height
String 		ls_tmp

of_get_layout_list(luo_new_right,luo_new_left,0)

li_upperbound = UpperBound(luo_new_left)
For i = 1 to li_upperbound
	ls_tmp =  "Contract_Tabpage_Details_"+trim(luo_new_left[i].tag)+".height"
	// record the height
	gnv_user_option.of_set_viewid_option_value( il_view_id,ls_tmp,string(luo_new_left[i].height  / this.height ) )
	ls_tmp = "Contract_Tabpage_Details_"+trim(luo_new_left[i].tag)+"_Num"
	gnv_user_option.of_set_viewid_option_value( il_view_id, ls_tmp , 'L'+string(i))
Next

li_upperbound   = UpperBound(luo_new_right)
For i = 1 to li_upperbound
	// record the height
	gnv_user_option.of_set_viewid_option_value( il_view_id, "Contract_Tabpage_Details_"+luo_new_right[i].tag+".height",string(luo_new_right[i].height  / this.height ) )	
	gnv_user_option.of_set_viewid_option_value( il_view_id, "Contract_Tabpage_Details_"+luo_new_right[i].tag+"_Num",'R'+string(i))
Next 

// record the height of the tab_detail
gnv_user_option.of_set_viewid_option_value( il_view_id, "Contract_Tabpage_Details_Tab_Detail.height",string(uo_tab_detail.height  / this.height ) )	
	
//	recorde the divider position
//gnv_user_option.of_set_viewid_option_value( il_view_id, "Contract_Detail_Tab_Detail_Tab.x",string(st_vbar.x  / (this.width - 90 - 15) ) )
gnv_user_option.of_set_viewid_option_value( il_view_id, "Contract_Detail_Tab_Detail_Tab.x",string(st_vbar.x  / (this.width - 90)) )
	
gnv_user_option.of_viewid_save( )

//If ib_modify = true Then 
//	If isvalid(w_contract) Then
//		w_contract.ib_IsMDIClose = True
//		Close(w_contract)
//	End If 
//	If isvalid(gw_contract) Then
//		gw_contract.ib_IsMDIClose = True
//		Close(gw_contract)
//	End If 
//End If 
end subroutine

public function integer of_generate_control ();//====================================================================
// Function: of_generate_control
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/17/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Int i,li_num,li_cnt
li_cnt = UpperBound(Control[])
For i = 1 to li_cnt
	If Control[i].typeof() = userobject! Then
		If Left(Control[i].Classname(),9) = 'u_gadget_' Then
			li_num = Integer(Mid(Control[i].Classname(),10)) 
			iuo_gadget_list[li_num] = Control[i]
		End If
	End If
Next
Return 1


end function

public subroutine of_set_position ();//====================================================================
// Function: of_set_position
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/08/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
u_cst_gadget_contract	luo_left_list[],	luo_right_list[],  luo_tmp[], luo_new_right[], luo_new_left[]
Long 				ll_x, ll_y, ll_restore_y
Integer 			i, j , k, li_left[], li_right[], li_upperbound, li_tmp 
String 			ls_tag[], ls_tmp[]
n_cst_string		ln_cst_string
Boolean			lbn_flag = False


ll_x = st_vbar.x
//restore the positon
If st_vbar.y < 0 Then  
	ll_restore_y = st_vbar.y 
Else
	ll_restore_y = 15 
End If 

IF ib_title = True Then 
	If iuo_current_gadget.x > ll_x    Then 
		iuo_current_gadget.x = gb_right.x
		iuo_current_gadget.width = gb_right.width	
//		iuo_current_gadget.height = gb_right.height
	Else
		iuo_current_gadget.x = gb_left.x
		iuo_current_gadget.width = gb_left.width	
//		iuo_current_gadget.height = gb_left.height	
	End If
End IF 

//order arrary list
of_get_layout_list(luo_new_right,luo_new_left, 0)

ll_y = ll_restore_y
//right reorder position
li_upperbound = Upperbound(luo_new_right)
For i =1 to li_upperbound
	luo_new_right[i].y = ll_y
	ll_y = luo_new_right[i].y  + luo_new_right[i].height + 20
Next
uo_tab_detail.y = ll_y

//Left reorder position
li_upperbound = Upperbound(luo_new_left)
ll_y = ll_restore_y 
For i =1 to li_upperbound
	luo_new_left[i].y = ll_y
	ll_y = luo_new_left[i].y  + luo_new_left[i].height + 20
Next
IF li_upperbound = 0 Then 
	st_msg.visible = True
Else
	st_msg.visible = False
End If
If  li_upperbound = 1  Then
	 IF  luo_new_left[1].visible = False  Then 
		st_msg.visible = True
	End IF 
End IF 

//reset st_vbar.height
If li_upperbound > 0 Then 
	If uo_tab_detail.y + uo_tab_detail.height <  luo_new_left[li_upperbound].y   + luo_new_left[li_upperbound].height Then 
		st_vbar.height = luo_new_left[li_upperbound].y   + luo_new_left[li_upperbound].height
	Else
		st_vbar.height = uo_tab_detail.y + uo_tab_detail.height
	End If 
Else
	st_vbar.height = uo_tab_detail.y + uo_tab_detail.height
End IF 

end subroutine

public subroutine of_get_layout_list (ref u_cst_gadget_contract auo_new_right[], ref u_cst_gadget_contract auo_new_left[], long al_x);//====================================================================
// Function: of_get_layout_list
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                auo_new_right[]
//                auo_new_left[]
//                al_x
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/10/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
u_cst_gadget_contract	luo_left_list[],	luo_right_list[],  luo_tmp[]
Long 				ll_x, ll_y
Integer 			i, j , k, li_left[], li_right[], li_upperbound, li_tmp 
String 			ls_tag[], ls_tmp[]
n_cst_string		ln_cst_string
Boolean			lbn_flag = False

If isnull(al_x ) or al_x = 0 Then 
	ll_x = st_vbar.x
Else
	ll_x = al_x 
End If 

//get layout list
li_upperbound = Upperbound(iuo_gadget_list) 
IF li_upperbound > 1 Then 
	For i = 1 to li_upperbound
		If not Isvalid(iuo_gadget_list[i]) then 
			Continue
		End IF
//		If iuo_gadget_list[i].visible = False then 
//			Continue
//		End IF
		IF iuo_gadget_list[i].x > ll_x    Then
			j++
			luo_right_list[j] =  iuo_gadget_list[i]
			li_right[j] = iuo_gadget_list[i].y
		Else
			k++
			luo_left_list[k] =  iuo_gadget_list[i]
			li_left[k] = iuo_gadget_list[i].y
		End If
	Next
	// order no  ---right
	li_upperbound = Upperbound(li_right)
	For i =1  to li_upperbound
		lbn_flag = False
		For j = li_upperbound  to i + 1 step - 1 
			If li_right[j - 1] > li_right[j] then 
				li_tmp = li_right[j - 1]
				li_right[j - 1] = li_right[j]
				li_right[j] = li_tmp
				lbn_flag = True
			End If
		Next
		If lbn_flag = False Then
			Exit
		End If 
	Next
	// clear calssname array				---right
	ls_tag = ls_tmp
	For i = 1 to li_upperbound 
		For j = 1 to li_upperbound 
			If li_right[i] =  luo_right_list[j].y  Then 
				// adjust the duplicate Y value
				If i > 1  Then 
					If ln_cst_string.of_isexists(ls_tag, luo_right_list[j].tag ) = True then 
						continue
					End If 
				End If 
				auo_new_right[i] =  luo_right_list[j]
				ls_tag[i] = luo_right_list[j].tag
				exit
			End If
		Next
	Next
	// order no  ---left
	li_upperbound = Upperbound(li_left)
	For i = 1  to li_upperbound
		lbn_flag = False		
		For j = li_upperbound  to i + 1 step - 1 
			If li_left[j - 1] > li_left[j] then 
				li_tmp = li_left[j - 1]
				li_left[j - 1] = li_left[j]
				li_left[j] = li_tmp
				lbn_flag = True
			End If
		Next
		If lbn_flag = False Then
			Exit
		End If 
	Next
	// clear calssname array				---left
	ls_tag = ls_tmp
	For i = 1 to li_upperbound 
		For j = 1 to li_upperbound 
			If li_left[i] =  luo_left_list[j].y  Then 
				// adjust the duplicate Y value
				If i > 1  Then 
					If ln_cst_string.of_isexists(ls_tag, luo_left_list[j].tag ) = True then 
						continue
					End If 
				End If 
				auo_new_left[i] =  luo_left_list[j]
				ls_tag[i] = luo_left_list[j].tag
				exit
			End If
		Next
	Next
End If
end subroutine

public subroutine of_create_dw ();//====================================================================
// Function: of_create_dw
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/18/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
string ls_tab_name
string ls_dw_name[]
string ls_dataobject[]
integer li_view_id	,  i 
datawindow ld_dw[]
string 	ls_visible, ls_date_visible

ls_tab_name = 'tabpage_details'

ld_dw[1] = u_gadget_3.dw_content
ld_dw[2] = u_gadget_4.dw_content
ld_dw[3] = u_gadget_6.dw_content
ld_dw[4] = u_gadget_7.dw_content
ld_dw[5] = u_gadget_5.dw_content
ld_dw[6] = 	uo_tab_detail.tab_1.tabpage_1.dw_1

ls_dw_name[1] = 'dw_1'
ls_dw_name[2] = 'dw_products'
ls_dw_name[3] = 'dw_ccc'
ls_dw_name[4] = 'dw_occ'
ls_dw_name[5] = 'dw_contract_dates'
ls_dw_name[6] = 'dw_1'

ls_dataobject[1] = 'd_contract_det_master'
ls_dataobject[2] = 'd_ctx_products'
ls_dataobject[3] = 'd_contract_det_contact_external'
ls_dataobject[4] = 'd_contract_det_contact_external'
ls_dataobject[5] = 'd_contract_det_master_2'
ls_dataobject[6] = 'd_contract_det_custom'

IF isnull(il_view_id) or il_view_id = 0 Then 
	il_view_id = gi_contract_view_id 
End If

f_create_contract_dw(il_view_id,ls_tab_name,ld_dw,ls_dw_name,ls_dataobject)		

// set dw title
of_set_dw_title()

//---------Begin Added by (Appeon)Harry 05.30.2014 for V142 ISG-CLX--------
if Upper(ld_dw[1].describe("app_facility.DDDW.AutoRetrieve") ) = 'YES' then  
	ld_dw[1].modify("app_facility.DDDW.AutoRetrieve='No'")
end if
//---------End Added ------------------------------------------------------

u_gadget_3.dw_content.insertrow( 0)
u_gadget_5.dw_content.insertrow( 0)
u_gadget_7.dw_content.insertrow( 0)
uo_tab_detail.tab_1.tabpage_1.dw_1.insertrow( 0)
For i = 1 to 6 
	ld_dw[i].modify( "Datawindow.readonly = True ")
Next 

gnv_appeondb.of_startqueue()
//visible products dw
select screen_visible into :ls_visible from ctx_screen
where data_view_id = :il_view_id 
and screen_id = 4 ;
//visible Contract Dates Dw
select screen_visible into :ls_date_visible from ctx_screen
where data_view_id = :il_view_id 
and screen_id = 5 ;
gnv_appeondb.of_commitqueue()

IF Not isnull(ls_visible) and ls_visible = 'N' Then 
	u_gadget_4.visible = False
	ib_product_visible = False
Else
	u_gadget_4.visible = True
	ib_product_visible =   True
End If

IF Not isnull(ls_date_visible) and ls_date_visible = 'N' Then 
	u_gadget_5.visible = False
	ib_date_visible = False
Else
	u_gadget_5.visible = True
	ib_date_visible =   True
End If
end subroutine

public function integer of_getparentwindow (window aw_parent);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_GetParentWindow
//
//	Access:  		public
//
//	Arguments:
//	aw_parent		The Parent window for this object (passed by reference).
//						If a parent window is not found, variable returns
//						with NULL.
//
//	Returns:  		Integer
//						1 if it succeeds and -1 if an error occurs.
//
//	Description:	Calculates the parent window of a window object.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996 Powersoft Corporation.  All Rights Reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

powerobject	lpo_parent

//Loop getting the parent of the object until it is of type window!
lpo_parent = this.GetParent()
do while IsValid (lpo_parent)
	If lpo_parent.TypeOf() = window! Then Exit
	lpo_parent = lpo_parent.GetParent()
loop

if not IsValid (lpo_parent) then
	setnull(aw_parent)	
	return -1
end If

aw_parent = lpo_parent
return 1

end function

public subroutine of_set_dw_title ();Integer 			i , li_upperbound
String 			ls_condition, ls_title_name 
Long 				ll_Row

IF ids_screen_prop.rowcount( ) <= 0 Then
	 Return
End IF

li_upperbound = Upperbound(iuo_gadget_list)

For i = 1 to li_upperbound
	If isvalid(iuo_gadget_list[i]) Then
		ls_condition = " data_view_id = " + string(il_view_id )+ " and screen_id = " + string(i) 
		ll_Row = ids_screen_prop.find( ls_condition, 1, ids_screen_prop.rowcount( ))
		IF ll_Row > 0 Then 
			ls_title_name = ids_screen_prop.object.titlebar_text[ll_Row]
			IF not isnull(ls_title_name) and trim(ls_title_name) <> '' Then 
				iuo_gadget_list[i].st_title.text = ls_title_name
			End IF
		End If
	End If
Next


end subroutine

public subroutine of_get_position (boolean abn_reset_flag);//====================================================================
// Function: of_get_position
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_reset_flag				: get the default layout setting.
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/24/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
u_cst_gadget_contract luo_new_right[], luo_new_left[]
Integer 	i, j, k, li_upperbound
String 		ls_position
Long 			ll_y, ll_height, ll_x, ll_view_id, ll_left_y, ll_right_y


ll_left_y = 0 
ll_right_y = 15 
IF abn_reset_flag Then 
	ll_view_id = 1000
Else 
	ll_view_id = il_view_id
End If

ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Detail_Tab_Detail_Tab.x" )
gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
If  isnull(ls_position) or trim(ls_position) = '' then 
	st_vbar.x =  this.width *  1080 / 3800
Else
	st_vbar.x =  this.width * Dec(ls_position)
End If
st_vbar.width = 18
ll_x = st_vbar.x 

ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Tabpage_Details_"+Trim(u_gadget_3.tag)+"_Num" )
//default
If isnull(ls_position) or trim(ls_position) = '' Then 
	u_gadget_3.x = gb_left.x
	u_gadget_3.width = gb_left.width
	
	u_gadget_4.x = gb_left.x
	u_gadget_4.width = gb_left.width
	
	u_gadget_6.x = gb_right.x
	u_gadget_6.width = gb_right.width
	
	u_gadget_7.x = gb_right.x
	u_gadget_7.width = gb_right.width
	
	//     move to proper position for the hide's dw. 
	ll_height = u_gadget_4.y + u_gadget_4.height
	IF u_gadget_5.visible = False Then 
		u_gadget_5.x = gb_left.x
		u_gadget_5.y = ll_height + 20
		u_gadget_5.width = gb_left.width
		
		u_gadget_6.y = ll_right_y
		u_gadget_7.y = ll_right_y + u_gadget_6.height + 20 
		uo_tab_detail.y = ll_right_y + u_gadget_6.height + 20  + u_gadget_7.height + 20
	Else
		u_gadget_5.x = gb_right.x
		u_gadget_5.width = gb_right.width
	End If
	
	IF uo_tab_detail.y + uo_tab_detail.height + 4 < this.height Then 
		ll_height = uo_tab_detail.y + uo_tab_detail.height + 24
		
		// adjust full screen
//		u_gadget_3.height = Int ( u_gadget_3.height * this.height / ll_height  ) 
//		u_gadget_4.height = Int ( u_gadget_4.height * this.height / ll_height  ) 
//		u_gadget_5.height = Int ( u_gadget_5.height * this.height / ll_height  )
//		u_gadget_6.height = Int ( u_gadget_6.height * this.height / ll_height  )
//		u_gadget_7.height = Int ( u_gadget_7.height * this.height / ll_height  )	
//		uo_tab_detail.height = Int ( uo_tab_detail.height * this.height / ll_height  )
		//left
		u_gadget_4.y = u_gadget_3.y + u_gadget_3.height + 20
		ll_left_y  = u_gadget_4.y  + u_gadget_4.height											//record the y position in the left 
			
		//right
		IF u_gadget_5.visible = False Then 
			u_gadget_5.y  = ll_left_y + 20 
			u_gadget_6.y  = ll_right_y
			u_gadget_7.y = ll_right_y + u_gadget_6.height + 20
			uo_tab_detail.y = ll_right_y + u_gadget_6.height + 20 + u_gadget_7.height + 20
		Else
			u_gadget_5.y  = ll_right_y
			u_gadget_6.y = u_gadget_5.y + u_gadget_5.height + 20
			u_gadget_7.y = u_gadget_6.y + u_gadget_6.height  + 20 
			uo_tab_detail.y = u_gadget_7.y  + u_gadget_7.height + 20 
		End IF 
		
		If st_vbar.height < this.height Then 
			st_vbar.height = this.height 
		End If
	End If 
Else
	//the setting
	li_upperbound = Upperbound(iuo_gadget_list)
	For i = 1 to li_upperbound
		If not Isvalid(iuo_gadget_list[i]) then 
			Continue
		End IF
		ls_position = Trim(gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Tabpage_Details_"+iuo_gadget_list[i].tag+"_Num" ))
		j = Integer(Mid(ls_position,2,len(ls_position)))
		If left(ls_position,1) = 'L' Then 
			luo_new_left[j] = iuo_gadget_list[i]
		ElseIf left(ls_position,1) = 'R' Then
			luo_new_right[j] = iuo_gadget_list[i]
		End IF 
	Next 
	
	li_upperbound = Upperbound(luo_new_left)
	ll_y =  0 
	For i = 1 to li_upperbound
		If not Isvalid(luo_new_left[i]) then 
			Continue
		End IF
		IF luo_new_left[i].visible = False Then 
			COntinue
		End IF
		ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Tabpage_Details_"+luo_new_left[i].tag+".height" )
		gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
		luo_new_left[i].move( 15, ll_y)
		luo_new_left[i].resize(ll_x - 10, Integer(Dec(ls_position) * this.height))
		ll_y = luo_new_left[i].y + luo_new_left[i].height + 20
	Next
	ll_left_y = ll_y 						//record the y position in the left 
	If li_upperbound = 0 Then 
		st_msg.visible = True
	Else
		st_msg.visible = False
	End If
	If  li_upperbound = 1  Then
		 IF  luo_new_left[1].visible = False  Then 
			st_msg.visible = True
	 	End IF 
	End IF 
	
	li_upperbound = Upperbound(luo_new_right)
	ll_y =  0 
	For i = 1 to li_upperbound
		If not Isvalid(luo_new_right[i]) then 
			Continue
		End IF
		IF luo_new_right[i].visible = False Then 
			COntinue
		End IF
		ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Tabpage_Details_"+luo_new_right[i].tag+".height" )
		gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
		luo_new_right[i].move( ll_x + st_vbar.width, ll_y)
		luo_new_right[i].resize( this.width - ll_x - st_vbar.width - 90  , Integer( Dec(ls_position) * this.height))
		ll_y = luo_new_right[i].y + luo_new_right[i].height + 20
	Next
	uo_tab_detail.y = ll_y						
	
	//hidder userobject
	IF ib_product_visible = False Then 
		u_gadget_4.x = 15
		li_upperbound = Upperbound(luo_new_left)
		If li_upperbound > 0 Then 
			u_gadget_4.y  = luo_new_left[li_upperbound].y + luo_new_left[li_upperbound].height + 20
		Else
			u_gadget_4.y = 15
		End IF 
		ll_left_y = u_gadget_4.y + u_gadget_4.height + 20					//record the y position in the left 
	End If 
	//hidder the contract dates dw
	If ib_date_visible = False Then
		u_gadget_5.x = 15
		u_gadget_5.y = ll_left_y
	End If 
End If 


end subroutine

public subroutine of_set_other_default_position (boolean abn_reset_flag);//====================================================================
// Function: of_set_other_default_position
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//                abn_reset_flag
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 01/24/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
String 		ls_position
Long 			ll_height, ll_view_id

If abn_reset_flag = True then 
	ll_view_id = 1000
Else
	ll_view_id = il_view_id
End If

//
ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Detail_Tab_Detail_Tab.x" )
gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
If  isnull(ls_position) or trim(ls_position) = '' then 
	//
	st_vbar.x =  this.width *  1080 / 3800
Else
	st_vbar.x =  this.width * Dec(ls_position)
End If

gb_left.x = 15
gb_left.width = st_vbar.x - gb_left.x 
st_msg.x = 80
st_msg.width = gb_left.width - 80 + 15
gb_right.x = st_vbar.x + st_vbar.width 
gb_right.width = this.width - gb_right.x  - 90
uo_tab_detail.x = gb_right.x
//uo_tab_detail.width = gb_right.width

ls_position = gnv_user_option.of_get_viewid_option_value(ll_view_id, "Contract_Tabpage_Details_Tab_Detail.height") 
gnv_string.of_convert_numeric_for_language( ls_position)				//Added By Mark Lee 05/09/2013
IF isnull(ls_position) or trim(ls_position) = '' Then 
	ll_height = uo_tab_detail.height
Else
	ll_height = this.height * Dec(ls_position)
End If 
uo_tab_detail.resize( gb_right.width - 10, ll_height - 10)
uo_tab_detail.tab_1.tabpage_1.dw_1.resize( gb_right.width - 10, ll_height - 10)

st_hbar.y = this.height - st_hbar.height -10 
st_hbar.x = 0
st_hbar.width = this.width

st_vbar.y = 0
st_vbar.height = this.height
end subroutine

on u_cst_gadget_contract_details.create
this.st_msg=create st_msg
this.u_gadget_4=create u_gadget_4
this.u_gadget_5=create u_gadget_5
this.u_gadget_6=create u_gadget_6
this.st_vbar=create st_vbar
this.uo_tab_detail=create uo_tab_detail
this.u_gadget_7=create u_gadget_7
this.gb_left=create gb_left
this.gb_right=create gb_right
this.u_gadget_3=create u_gadget_3
this.st_hbar=create st_hbar
this.Control[]={this.st_msg,&
this.u_gadget_4,&
this.u_gadget_5,&
this.u_gadget_6,&
this.st_vbar,&
this.uo_tab_detail,&
this.u_gadget_7,&
this.gb_left,&
this.gb_right,&
this.u_gadget_3,&
this.st_hbar}
end on

on u_cst_gadget_contract_details.destroy
destroy(this.st_msg)
destroy(this.u_gadget_4)
destroy(this.u_gadget_5)
destroy(this.u_gadget_6)
destroy(this.st_vbar)
destroy(this.uo_tab_detail)
destroy(this.u_gadget_7)
destroy(this.gb_left)
destroy(this.gb_right)
destroy(this.u_gadget_3)
destroy(this.st_hbar)
end on

event constructor;of_generate_control()

ids_screen_prop = Create n_ds
ids_screen_prop.DataObject = "d_screen_properties"
ids_screen_prop.SetTransObject(SQLCA)
ids_screen_prop.retrieve( )


//of_get_position()
end event

event destructor;IF isvalid(ids_screen_prop) Then
	Destroy ids_screen_prop
End IF
end event

type st_msg from statictext within u_cst_gadget_contract_details
boolean visible = false
integer x = 18
integer y = 80
integer width = 1006
integer height = 664
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Note: The screens on the right side will automatically fill up this area if you do not have screen in this section."
boolean focusrectangle = false
end type

type u_gadget_4 from u_cst_gadget_contract within u_cst_gadget_contract_details
event destroy ( )
string tag = "Products"
integer x = 14
integer y = 1676
integer width = 1029
integer height = 348
integer taborder = 60
string is_title = "Products"
end type

on u_gadget_4.destroy
call u_cst_gadget_contract::destroy
end on

type u_gadget_5 from u_cst_gadget_contract within u_cst_gadget_contract_details
event destroy ( )
string tag = "Contract_Dates"
integer x = 1088
integer y = 32
integer width = 2789
integer height = 456
integer taborder = 20
borderstyle borderstyle = styleshadowbox!
string is_title = "Contract Dates"
end type

on u_gadget_5.destroy
call u_cst_gadget_contract::destroy
end on

type u_gadget_6 from u_cst_gadget_contract within u_cst_gadget_contract_details
event destroy ( )
string tag = "Contracted_Company_Contact_Info"
integer x = 1088
integer y = 512
integer width = 2789
integer height = 404
integer taborder = 70
string is_title = "Contracted Company Contact Info"
end type

on u_gadget_6.destroy
call u_cst_gadget_contract::destroy
end on

type st_vbar from u_st_splitbar within u_cst_gadget_contract_details
event lbutton_down pbm_lbuttondown
integer x = 1056
integer width = 18
integer height = 2032
long backcolor = 128
long bordercolor = 128
borderstyle borderstyle = styleraised!
end type

event lbutton_down;il_x = st_vbar.x

parent.setredraw(False)


end event

event constructor;call super::constructor;
this.of_Register(gb_left , LEFT)
this.of_Register(gb_right , RIGHT)
this.of_Register(uo_tab_detail , RIGHT)
this.of_Register(st_msg , LEFT)

//this.backcolor = parent.backcolor  

this.of_SetMinobjectsize( 600)
end event

event lbuttonup;call super::lbuttonup;u_cst_gadget_contract 	luo_new_right[] , luo_new_left[]
Integer 		i, li_upperbound


//order arrary list
of_get_layout_list(luo_new_right,luo_new_left,il_x)

//parent.setredraw(False)

li_upperbound = Upperbound(luo_new_right)
For i = 1 to li_upperbound
	luo_new_right[i].x = gb_right.x
	luo_new_right[i].width = gb_right.width
Next

li_upperbound = Upperbound(luo_new_left)
For i = 1 to li_upperbound
	luo_new_left[i].x = gb_left.x
	luo_new_left[i].width = gb_left.width
Next

uo_tab_detail.tab_1.tabpage_1.dw_1.width = uo_tab_detail.tab_1.width

parent.setredraw(True)

il_x = 0 
ib_modify = True 

If isvalid(w_contract_layout)  Then
	w_contract_layout.cb_apply.enabled = True
End IF 


end event

type uo_tab_detail from u_cst_gadget_contract_detail_detail within u_cst_gadget_contract_details
event destroy ( )
string tag = ""
integer x = 1088
integer y = 1368
integer width = 2789
integer height = 660
integer taborder = 90
end type

on uo_tab_detail.destroy
call u_cst_gadget_contract_detail_detail::destroy
end on

type u_gadget_7 from u_cst_gadget_contract within u_cst_gadget_contract_details
event destroy ( )
string tag = "Our_Company_Contact_Info"
integer x = 1088
integer y = 936
integer width = 2789
integer height = 404
integer taborder = 70
borderstyle borderstyle = styleshadowbox!
string is_title = "Our Company Contact Info"
end type

on u_gadget_7.destroy
call u_cst_gadget_contract::destroy
end on

type gb_left from groupbox within u_cst_gadget_contract_details
boolean visible = false
integer x = 14
integer width = 1042
integer height = 348
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Left"
end type

type gb_right from groupbox within u_cst_gadget_contract_details
boolean visible = false
integer x = 1074
integer width = 2789
integer height = 404
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Right"
end type

type u_gadget_3 from u_cst_gadget_contract within u_cst_gadget_contract_details
event destroy ( )
string tag = "Contract_Detail"
integer x = 14
integer y = 32
integer width = 1029
integer height = 1624
integer taborder = 60
boolean bringtotop = true
string is_title = "Contract Detail"
end type

on u_gadget_3.destroy
call u_cst_gadget_contract::destroy
end on

type st_hbar from u_st_splitbar within u_cst_gadget_contract_details
event lbutton_down pbm_lbuttondown
integer y = 2032
integer width = 3913
integer weight = 700
fontcharset fontcharset = ansi!
string pointer = "Arrow!"
long backcolor = 128
long bordercolor = 128
borderstyle borderstyle = styleraised!
string is_verticalpointer = "Arrow!"
string is_horizontalpointer = "Arrow!"
end type

event constructor;call super::constructor;
//this.backcolor = parent.backcolor  
this.backcolor =RGB( 255,0,0)
end event

