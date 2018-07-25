$PBExportHeader$u_cst_tabpg_gadget.sru
forward
global type u_cst_tabpg_gadget from userobject
end type
type u_gadget_18 from u_cst_gadget_getting_started within u_cst_tabpg_gadget
end type
type u_gadget_9 from u_cst_gadget_notes_new within u_cst_tabpg_gadget
end type
type u_gadget_17 from u_cst_gadget_contract_templates within u_cst_tabpg_gadget
end type
type u_gadget_16 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
end type
type u_gadget_15 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
end type
type u_gadget_14 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
end type
type u_gadget_13 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
end type
type u_gadget_12 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
end type
type u_gadget_5 from u_cst_gadget_calendar_meetings within u_cst_tabpg_gadget
end type
type u_gadget_11 from u_cst_gadget_clock within u_cst_tabpg_gadget
end type
type u_gadget_2 from u_cst_gadget_favorite_reports within u_cst_tabpg_gadget
end type
type u_gadget_10 from u_cst_gadget_global_search within u_cst_tabpg_gadget
end type
type u_gadget_3 from u_cst_gadget_favorite_correspondence within u_cst_tabpg_gadget
end type
type u_gadget_6 from u_cst_gadget_favorite_workflow within u_cst_tabpg_gadget
end type
type u_gadget_4 from u_cst_gadget_message_board within u_cst_tabpg_gadget
end type
type u_gadget_8 from u_cst_gadget_recent_ctx within u_cst_tabpg_gadget
end type
type u_gadget_7 from u_cst_gadget_recent_prac within u_cst_tabpg_gadget
end type
type u_gadget_1 from u_cst_gadget_todolist within u_cst_tabpg_gadget
end type
type gb_3 from groupbox within u_cst_tabpg_gadget
end type
type gb_2 from groupbox within u_cst_tabpg_gadget
end type
type gb_1 from groupbox within u_cst_tabpg_gadget
end type
type gb_4 from groupbox within u_cst_tabpg_gadget
end type
type ln_split from line within u_cst_tabpg_gadget
end type
end forward

global type u_cst_tabpg_gadget from userobject
integer width = 3634
integer height = 5000
boolean vscrollbar = true
boolean border = true
long backcolor = 67108864
string text = "Custom"
long tabtextcolor = 33554432
long picturemaskcolor = 553648127
event lbuttondown pbm_lbuttondown
event mousemove pbm_mousemove
event lbuttonup pbm_lbuttonup
event ue_buttondown ( u_cst_gadget auo_gadget )
event ue_buttonup ( )
event ue_mousemove ( )
event resize pbm_size
event ue_retrieve ( )
event ue_retrieve_same_gadget ( string as_classname )
u_gadget_18 u_gadget_18
u_gadget_9 u_gadget_9
u_gadget_17 u_gadget_17
u_gadget_16 u_gadget_16
u_gadget_15 u_gadget_15
u_gadget_14 u_gadget_14
u_gadget_13 u_gadget_13
u_gadget_12 u_gadget_12
u_gadget_5 u_gadget_5
u_gadget_11 u_gadget_11
u_gadget_2 u_gadget_2
u_gadget_10 u_gadget_10
u_gadget_3 u_gadget_3
u_gadget_6 u_gadget_6
u_gadget_4 u_gadget_4
u_gadget_8 u_gadget_8
u_gadget_7 u_gadget_7
u_gadget_1 u_gadget_1
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_4 gb_4
ln_split ln_split
end type
global u_cst_tabpg_gadget u_cst_tabpg_gadget

type variables
Boolean ib_mouse_down = False
Long il_pointer_x_ini = 0 ,il_pointer_y_ini = 0
u_cst_gadget iuo_current_gadget
u_cst_gadget iuo_gadget_list[]


Int ii_border_left //Left Border Space
Int ii_scrollbar_width 
Int ii_border_right //Right Border Space. Include Scrollbar width
Int ii_border_bt    //Top, Bottom Border Space
Int ii_area_Space   //Between Areas Space
Int ii_gadget_space //Between Gaggets Space

str_gadget istr_Area1[] 
str_gadget istr_Area2[] 
str_gadget istr_Area3[]
str_gadget istr_Area4[]
str_gadget istr_Area_Empty[]

Boolean ib_style_changed = False
Boolean ib_first_page 

//Move to Structure
//long il_tab_id
//String is_style
//String is_style_type
//Long il_gadget_title_bg_color 
//Long il_tab_bg_color 
//String is_title
//Integer ii_tab_locked

str_tab istr_current_tab
end variables

forward prototypes
public subroutine of_set_position ()
public function integer of_generate_control ()
public subroutine of_set_visiable ()
public subroutine of_gen_area_auto ()
public subroutine of_gen_area_move ()
public function integer of_gen_area_todb ()
public function integer of_delete_gadget (integer ai_number)
public subroutine of_resize_ini ()
public function integer of_gen_area_insert (ref str_gadget astr_area[], str_gadget astr_new_gadget)
public subroutine of_gen_area_ini (str_gadget astr_area1[], str_gadget astr_area2[], str_gadget astr_area3[], str_gadget astr_area4[])
public subroutine of_refresh_ui ()
public function integer of_reset_area_array ()
public subroutine of_set_gadgets_properties ()
public function integer of_set_tab_properties ()
public subroutine of_set_style (string as_style, string as_style_type)
public function integer of_update_from_gadget (str_gadget astr_gadget)
public function integer of_update_to_db ()
public function integer of_update_to_gadgets ()
public function integer of_set_invisiable ()
public function integer of_set_invisiable_status ()
public function integer of_refresh_do ()
public subroutine of_retrieve_same_gadget (string as_classname, boolean ab_queue)
public function integer of_update_clock_to_db (integer al_face_id)
end prototypes

event ue_buttondown(u_cst_gadget auo_gadget);//////////////////////////////////////////////////////////////////////
// $<event>ue_buttondownu_cst_tabpg_gadget()
// $<arguments>
//		value	u_cst_gadget	auo_gadget		
// $<returns> 
// $<description>
// $<description> Button down for drag gadget
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

iuo_current_gadget = auo_gadget
iuo_current_gadget.bringtotop = True
ib_mouse_down = True
il_pointer_x_ini = PointerX() 
il_pointer_y_ini = PointerY()
end event

event ue_buttonup();//////////////////////////////////////////////////////////////////////
// $<event>ue_buttonupu_cst_tabpg_gadget()
// $<arguments>(None)
// $<returns> 
// $<description> Button up to release dragged gadget
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If Not isvalid(iuo_current_gadget) Then Return
ib_mouse_down = False
iuo_current_gadget.of_release_button()

//Generta area array
If istr_current_tab.si_tab_locked = 0 Then
	of_gen_area_move()
End If

//Reset Position
of_set_position()

////Show a message
//If ib_moved = True and ii_tab_locked = 1 Then
//	Messagebox('Move','Gadget can not be moved in LOCKED tab. '+&
//	'~r~nIf you want to move gadget, Please unlock current tab first.')
//End If
//ib_moved = False
end event

event ue_mousemove();//////////////////////////////////////////////////////////////////////
// $<event>ue_mousemoveu_cst_tabpg_gadget()
// $<arguments>(None)
// $<returns> 
// $<description> Move dragged gadget
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If PointerX() < 10 or PointerY() < 10 Then Return
If PointerX() > This.width	or PointerY() > This.Height Then Return

//If iuo_current_gadget.x <> iuo_current_gadget.x + (PointerX() - il_pointer_X_ini) Or &
//	iuo_current_gadget.y <> iuo_current_gadget.y + (PointerY() - il_pointer_Y_ini) Then
//	ib_moved = True //ue_buttonup event will use this var.
//End If

iuo_current_gadget.Move(iuo_current_gadget.x + (PointerX() - il_pointer_X_ini) ,iuo_current_gadget.y + (PointerY() - il_pointer_Y_ini))
il_pointer_X_ini = PointerX()
il_pointer_Y_ini = PointerY()

If iuo_current_gadget.y + iuo_current_gadget.Height > This.Height Then
	//How to increase VScrollbar? 
	//APB not Support 'Units Per Line' and 'LinesPerPage'!
End If


end event

event resize;//////////////////////////////////////////////////////////////////////
// $<event>resizeu_cst_tabpg_gadget()
// $<arguments>
//		value	unsignedlong	sizetype 		
//		value	integer     	newwidth 		
//		value	integer     	newheight		
// $<returns> long
// $<description> Need Refresh UI after Resize 
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_width_space = 8
Long ll_heigth_space = 140

////For workaround WEB' Bug. It will be called three times when resize IE.
//If appeongetclienttype() = 'WEB' Then
//	If w_dashboard.tab_dashboard.width - newwidth <> ll_width_space And &
//		w_dashboard.tab_dashboard.height - newwidth <> ll_heigth_space Then
//		Return 1
//	End If
//End If
//
////Refresh UI
//If UpperBound(iuo_gadget_list[]) > 0 Then
//	of_refresh_ui()
//Else
//	Post of_refresh_ui()
//End If
end event

event ue_retrieve();//////////////////////////////////////////////////////////////////////
// $<event>u_cst_tabpg_gadget::ue_retrieve()
// $<arguments>(None)
// $<returns> 
// $<description> Retrieve data for all gadgets in current tab.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i,li_cnt
li_cnt = UpperBound(iuo_gadget_list[])
SetPointer(HourGlass!)
gnv_appeondb.of_startqueue()
For i = 1 to li_cnt
	If isvalid(iuo_gadget_list[i]) Then
		If iuo_gadget_list[i].visible Then
			iuo_gadget_list[i].Dynamic Event ue_retrieve()
		End If
	End If
Next
gnv_appeondb.of_commitqueue()
end event

event ue_retrieve_same_gadget(string as_classname);//////////////////////////////////////////////////////////////////////
// $<event>u_cst_tabpg_gadget::ue_retrieve_same_gadget()
// $<arguments>
//		value	string	as_classname		
// $<returns> 
// $<description>
// $<description> Retrieve same gadget from other tabpage.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-18 by Ken.Guo
//////////////////////////////////////////////////////////////////////


of_retrieve_same_gadget(as_classname,True)

end event

public subroutine of_set_position ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_set_position()
// $<arguments>(None)
// $<returns> (none)
// $<description> Set Gadgets' Position for every Area.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i,li_cnt
Long ll_next_y,ll_max_y


//For Area1
If gb_1.Enabled = True Then
	li_cnt = UpperBound(istr_Area1[])
	ll_next_y = gb_1.y + ii_border_bt
	For i = 1 To li_cnt 
		If istr_Area1[i].gadget_id = 0 Then Continue
		If Isvalid(iuo_gadget_list[istr_Area1[i].gadget_id]) Then
			iuo_gadget_list[istr_Area1[i].gadget_id].Visible = True
			If iuo_gadget_list[istr_Area1[i].gadget_id].Width <> gb_1.width Then
				iuo_gadget_list[istr_Area1[i].gadget_id].Width = gb_1.width
			End If
			If iuo_gadget_list[istr_Area1[i].gadget_id].x <>  gb_1.x Or iuo_gadget_list[istr_Area1[i].gadget_id].y <> ll_next_y Then
				iuo_gadget_list[istr_Area1[i].gadget_id].Move(gb_1.x, ll_next_y)
			End If
			ll_next_y = iuo_gadget_list[istr_Area1[i].gadget_id].y + iuo_gadget_list[istr_Area1[i].gadget_id].Height + ii_gadget_space 
		End If
	Next
	ll_max_y = ll_next_y
	gb_1.Height = ll_next_y - gb_1.y
End If

//For Area2
If gb_2.Enabled = True Then
	ll_next_y = gb_2.y + ii_border_bt
	li_cnt = UpperBound(istr_Area2[])
	For i = 1 To li_cnt 
		If istr_Area2[i].gadget_id = 0 Then Continue
		If Isvalid(iuo_gadget_list[istr_Area2[i].gadget_id])  Then
			iuo_gadget_list[istr_Area2[i].gadget_id].Visible = True
			If iuo_gadget_list[istr_Area2[i].gadget_id].Width <> gb_2.width Then
				iuo_gadget_list[istr_Area2[i].gadget_id].Width = gb_2.width
			End If
			If iuo_gadget_list[istr_Area2[i].gadget_id].x <> gb_2.x Or iuo_gadget_list[istr_Area2[i].gadget_id].y <> ll_next_y Then
				iuo_gadget_list[istr_Area2[i].gadget_id].Move(gb_2.x, ll_next_y)
			End If
			ll_next_y = iuo_gadget_list[istr_Area2[i].gadget_id].y + iuo_gadget_list[istr_Area2[i].gadget_id].Height + ii_gadget_space 
		End If
	Next
	If ll_max_y < ll_next_y Then
		ll_max_y = ll_next_y
	End If
	gb_2.Height = ll_next_y - gb_2.y
End If

//For Area3
If gb_3.Enabled = True Then
	ll_next_y = gb_3.y + ii_border_bt
	li_cnt = UpperBound(istr_Area3[])	
	For i = 1 To li_cnt 
		If istr_Area3[i].gadget_id = 0 Then Continue		
		If Isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then
			iuo_gadget_list[istr_Area3[i].gadget_id].Visible = True	
			If iuo_gadget_list[istr_Area3[i].gadget_id].Width <> gb_3.width Then
				iuo_gadget_list[istr_Area3[i].gadget_id].Width = gb_3.width
			End If
			If iuo_gadget_list[istr_Area3[i].gadget_id].x <> gb_3.x Or iuo_gadget_list[istr_Area3[i].gadget_id].y <> ll_next_y Then
				iuo_gadget_list[istr_Area3[i].gadget_id].Move(gb_3.x, ll_next_y)
			End If
			ll_next_y = iuo_gadget_list[istr_Area3[i].gadget_id].y + iuo_gadget_list[istr_Area3[i].gadget_id].Height + ii_gadget_space 
		End If
	Next		
	If ll_max_y < ll_next_y Then
		ll_max_y = ll_next_y
	End If
	gb_3.Height = ll_next_y - gb_3.y
End If

//For Area4
If gb_4.Enabled = True Then
	gb_4.y = ll_max_y + ii_area_space 
	ln_split.BeginY = gb_4.y - 14
	ln_split.EndY = gb_4.y - 14
	ll_next_y = gb_4.y + ii_gadget_space
	li_cnt = UpperBound(istr_Area4[])	
	For i = 1 To li_cnt 
		If istr_Area4[i].gadget_id = 0 Then Continue
		If Isvalid(iuo_gadget_list[istr_Area4[i].gadget_id])  Then
			iuo_gadget_list[istr_Area4[i].gadget_id].Visible = True
			If iuo_gadget_list[istr_Area4[i].gadget_id].Width <> gb_4.width Then
				iuo_gadget_list[istr_Area4[i].gadget_id].Width = gb_4.width
			End If
			If iuo_gadget_list[istr_Area4[i].gadget_id].x <> gb_4.x Or iuo_gadget_list[istr_Area4[i].gadget_id].y <> ll_next_y Then
				iuo_gadget_list[istr_Area4[i].gadget_id].Move(gb_4.x, ll_next_y)
			End If
			ll_next_y = iuo_gadget_list[istr_Area4[i].gadget_id].y + iuo_gadget_list[istr_Area4[i].gadget_id].Height + ii_gadget_space 
		End If
	Next
	gb_4.Height = ll_next_y - gb_4.y
End If

end subroutine

public function integer of_generate_control ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_generate_control()
// $<arguments>(None)
// $<returns> integer
// $<description> Set all gadget control to array var iuo_gadget_list[].
// $<description> iuo_gadget_list[1] = u_gadget_1;iuo_gadget_list[2] = u_gadget_2 and so on. 
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

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

public subroutine of_set_visiable ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_set_visiable()
// $<arguments>(None)
// $<returns> (none)
// $<description> INI gadgets' visible property.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i

of_set_invisiable_status()

For i = 1 To UpperBound(istr_Area1[])
	If istr_Area1[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area1[i].gadget_id]) Then 
		iuo_gadget_list[istr_Area1[i].gadget_id].Visible = True
		iuo_gadget_list[istr_Area1[i].gadget_id].ib_visible_status = True
//		iuo_gadget_list[istr_Area1[i].gadget_id].Post Event ue_do()
	End If
Next
For i = 1 To UpperBound(istr_Area2[])
	If istr_Area2[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area2[i].gadget_id]) Then 
		iuo_gadget_list[istr_Area2[i].gadget_id].Visible = True
		iuo_gadget_list[istr_Area2[i].gadget_id].ib_visible_status = True				
//		iuo_gadget_list[istr_Area2[i].gadget_id].Post Event ue_do()		
	End If
Next
For i = 1 To UpperBound(istr_Area3[])
	If istr_Area3[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then 
		iuo_gadget_list[istr_Area3[i].gadget_id].Visible = True
		iuo_gadget_list[istr_Area3[i].gadget_id].ib_visible_status = True				
//		iuo_gadget_list[istr_Area3[i].gadget_id].Post Event ue_do()		
	End If
Next
For i = 1 To UpperBound(istr_Area4[])
	If istr_Area4[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area4[i].gadget_id]) Then 
		iuo_gadget_list[istr_Area4[i].gadget_id].Visible = True
		iuo_gadget_list[istr_Area4[i].gadget_id].ib_visible_status = True				
//		iuo_gadget_list[istr_Area4[i].gadget_id].Post Event ue_do()		
	End If
Next
//Post of_refresh_do()		
of_set_invisiable()
end subroutine

public subroutine of_gen_area_auto ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadgetof_gen_area_auto()
// $<arguments>(None)
// $<returns> (none)
// $<description> After Style is changed, Re-generate gadget list in Area. 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i
Int j=1
Choose Case istr_current_tab.ss_tab_style
	Case	'20' //Move Area3 and Area4 to Area1 and Area2
		//For Area3
		For i = 1 to UpperBound(istr_Area3[])
			If istr_Area3[i].gadget_id = 0 Then Continue
			If Isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then
				If Mod(j,2) = 1 Then
					istr_Area1[Upperbound(istr_Area1[])+1] = istr_Area3[i]
				Else
					istr_Area2[Upperbound(istr_Area2[])+1] = istr_Area3[i]
				End if
				J++
			End If
		Next
		//For Area4
		For i = 1 to UpperBound(istr_Area4[])
			If istr_Area4[i].gadget_id = 0 Then Continue
			If Isvalid(iuo_gadget_list[istr_Area4[i].gadget_id]) Then
				If Mod(j,2) = 1 Then
					istr_Area1[Upperbound(istr_Area1[])+1] = istr_Area4[i]
				Else
					istr_Area2[Upperbound(istr_Area2[])+1] = istr_Area4[i]
				End if
				J++
			End If
		Next		
		//Delete Area3 and Area4
		istr_Area3[] = istr_Area_Empty[]
		istr_Area4[] = istr_Area_Empty[]
	Case	'21' 
		//Move Area3 to Area1 and Area2
		For i = 1 to UpperBound(istr_Area3[])
			If istr_Area3[i].gadget_id = 0 Then Continue
			If Isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then
				If Mod(j,2) = 1 Then
					istr_Area1[Upperbound(istr_Area1[])+1] = istr_Area3[i]
				Else
					istr_Area2[Upperbound(istr_Area2[])+1] = istr_Area3[i]
				End if
				J++
			End If
		Next	
		
		//Delete Area3
		istr_Area3[] = istr_Area_Empty[]
		
		//Move one to Area4 if Area4 have no one
		If UpperBound(istr_Area4[]) = 0 Then
			If UpperBound(istr_Area1[]) > 1 Then
				istr_Area4[1] = istr_Area1[UpperBound(istr_Area1[])] 
				istr_Area1[UpperBound(istr_Area1[])].gadget_id = 0
			Elseif UpperBound(istr_Area2[]) > 1 Then
				istr_Area4[1] = istr_Area2[UpperBound(istr_Area2[])] 
				istr_Area2[UpperBound(istr_Area2[])].gadget_id = 0
			End If
		End If
	Case	'30'
		//Move Area4 to Area1 and Area2 and Area3
		For i = 1 to UpperBound(istr_Area4[])
			If istr_Area4[i].gadget_id = 0 Then Continue
			If Isvalid(iuo_gadget_list[istr_Area4[i].gadget_id]) Then
				If Mod(j,3) = 1 Then
					istr_Area1[Upperbound(istr_Area1[])+1] = istr_Area4[i]
				ElseIf Mod(j,3) = 2 Then 
					istr_Area2[Upperbound(istr_Area2[])+1] = istr_Area4[i]
				Else
					istr_Area3[Upperbound(istr_Area3[])+1] = istr_Area4[i]
				End if
				J++
			End If
		Next	
		//Delete Area4
		istr_Area4[] = istr_Area_Empty[]
		
		//Move one from Area1 or Area 2 To Area3 If Area3 have no one
		If UpperBound(istr_Area3[]) = 0 Then
			If UpperBound(istr_Area1[]) > 1 Then
				istr_Area3[1] = istr_Area1[UpperBound(istr_Area1[])] 
				istr_Area1[UpperBound(istr_Area1[])].gadget_id = 0
			Elseif UpperBound(istr_Area2[]) > 1 Then
				istr_Area3[1] = istr_Area2[UpperBound(istr_Area2[])] 
				istr_Area2[UpperBound(istr_Area2[])].gadget_id = 0
			End If
		End If		
	Case	'31'
		//Move one from Area1 or Area 2 To Area3 If Area3 have no one
		If UpperBound(istr_Area3[]) = 0 Then
			If UpperBound(istr_Area1[]) > 1 Then
				istr_Area3[1] = istr_Area1[UpperBound(istr_Area1[])] 
				istr_Area1[UpperBound(istr_Area1[])].gadget_id = 0
			Elseif UpperBound(istr_Area2[]) > 1 Then
				istr_Area3[1] = istr_Area2[UpperBound(istr_Area2[])] 
				istr_Area2[UpperBound(istr_Area2[])].gadget_id = 0
			End If
		End If	
		//Move one from Area2 or Area1 to Area4 if Area4 have no one
		If UpperBound(istr_Area4[]) = 0 Then
			If UpperBound(istr_Area2[]) > 1 Then
				istr_Area4[1] = istr_Area2[UpperBound(istr_Area2[])] 
				istr_Area2[UpperBound(istr_Area2[])].gadget_id = 0
			Elseif UpperBound(istr_Area1[]) > 1 Then
				istr_Area4[1] = istr_Area1[UpperBound(istr_Area1[])] 
				istr_Area1[UpperBound(istr_Area1[])].gadget_id = 0
			End If
		End If		
End Choose

//Delete invalid gadgets, and save to db.
of_reset_area_array()

//Reset style flag
ib_style_changed = False
end subroutine

public subroutine of_gen_area_move ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_gen_area_move()
// $<arguments>(None)
// $<returns> (none)
// $<description>After drag gadget, Generate Area List again.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
/////////////////////////////////////////////////////////////////////


Int li_gadget_no
Int i
Int li_area_org
Int li_area_target = 0
str_gadget lstr_gadget_temp

li_gadget_no = Integer(Mid(iuo_current_gadget.ClassName(),10))
If li_gadget_no < 1 Then Return 

If Not Isvalid(iuo_gadget_list[li_gadget_no]) Then Return

//Find and Delete it from old Area
For i = 1 to Upperbound(istr_Area1[])
	If li_gadget_no = istr_Area1[i].gadget_id Then
		lstr_gadget_temp = istr_Area1[i]
		istr_Area1[i].gadget_id = 0
		li_area_org = 1
	End If
Next
For i = 1 to Upperbound(istr_Area2[])
	If li_gadget_no = istr_Area2[i].gadget_id Then
		lstr_gadget_temp = istr_Area2[i]
		istr_Area2[i].gadget_id = 0
		li_area_org = 2
	End If
Next
For i = 1 to Upperbound(istr_Area3[])
	If li_gadget_no = istr_Area3[i].gadget_id Then
		lstr_gadget_temp = istr_Area3[i]
		istr_Area3[i].gadget_id = 0
		li_area_org = 3		
	End If
Next
For i = 1 to Upperbound(istr_Area4[])
	If li_gadget_no = istr_Area4[i].gadget_id Then
		lstr_gadget_temp = istr_Area4[i]
		istr_Area4[i].gadget_id = 0
		li_area_org = 4		
	End If
Next

//Locate New Area
Long ll_location_posX,ll_location_PosY
ll_location_posX = iuo_gadget_list[li_gadget_no].x + iuo_gadget_list[li_gadget_no].Width / 2
ll_location_PosY = iuo_gadget_list[li_gadget_no].y
If ll_location_posX < (gb_1.x + gb_1.width + ii_area_space) Then
	li_area_target = 1
End If

If istr_current_tab.ss_tab_style = '20' or istr_current_tab.ss_tab_style = '21' Then
	If ll_location_posX >= (gb_1.x + gb_1.width + ii_area_space) Then
		li_area_target = 2
	End If
Else
	If ll_location_posX >= (gb_1.x + gb_1.width + ii_area_space) and &
		ll_location_posX < gb_2.x + gb_2.width + ii_area_space	Then
		li_area_target = 2
	End If	
End If

If istr_current_tab.ss_tab_style = '30' or istr_current_tab.ss_tab_style = '31' Then
	If ll_location_posX >= (gb_2.x + gb_2.width + ii_area_space) Then
		li_area_target = 3
	End If
End If

If istr_current_tab.ss_tab_style = '21' or istr_current_tab.ss_tab_style = '31' Then
	If ll_location_posY >= (gb_4.Y) Then
		li_area_target = 4
	End If
End If

If li_area_target = 0 Then li_area_target = li_area_org

lstr_gadget_temp.area_number = li_area_target

//Added it in new Area
Choose Case li_area_target
	Case	1
		of_gen_area_insert(istr_Area1[],lstr_gadget_temp)
	Case	2
		of_gen_area_insert(istr_Area2[],lstr_gadget_temp)
	Case	3
		of_gen_area_insert(istr_Area3[],lstr_gadget_temp)
	Case	4
		of_gen_area_insert(istr_Area4[],lstr_gadget_temp)
End Choose

//refresh to gadget object
iuo_current_gadget.istr_current_gadget = lstr_gadget_temp

of_reset_area_array()




end subroutine

public function integer of_gen_area_todb ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_gen_area_todb()
// $<arguments>(None)
// $<returns> integer
// $<description>Save Area list to DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Developing_Ken
Return 1
end function

public function integer of_delete_gadget (integer ai_number);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_delete_gadget()
// $<arguments>
//		value	integer	ai_number  Means gadget_id		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i,li_cnt
Long ll_gadget_id[]
ll_gadget_id[1] = ai_number

//Delete from DB
If w_dashboard.inv_dashboard.of_delete_gadget(istr_current_tab.sl_tab_id,ll_gadget_id[]) < 0 Then
	Messagebox('Delete gadget','Failed to delete the gadget.')
	Return -1
End If

//Delete from structure
li_cnt = Upperbound(istr_Area1[])
For i = 1 To li_cnt
	If istr_Area1[i].gadget_id = ai_number Then 
		istr_Area1[i].gadget_id = 0
		of_reset_area_array()
		Return 1
	End If
Next

li_cnt = Upperbound(istr_Area2[])
For i = 1 To li_cnt
	If istr_Area2[i].gadget_id = ai_number Then 
		istr_Area2[i].gadget_id = 0
		of_reset_area_array()		
		Return 1
	End If
Next

li_cnt = Upperbound(istr_Area3[])
For i = 1 To li_cnt
	If istr_Area3[i].gadget_id = ai_number Then 
		istr_Area3[i].gadget_id = 0
		of_reset_area_array()		
		Return 1
	End If
Next

li_cnt = Upperbound(istr_Area4[])
For i = 1 To li_cnt
	If istr_Area4[i].gadget_id = ai_number Then 
		istr_Area4[i].gadget_id = 0
		of_reset_area_array()		
		Return 1
	End If
Next

Return -1
end function

public subroutine of_resize_ini ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadgetof_ini()
// $<arguments>(None)
// $<returns> (none)
// $<description> INI base settings and Area position 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

ii_border_left = 14  //Left Border Space]
ii_scrollbar_width = 86
ii_border_right = ii_border_left + ii_scrollbar_width
ii_border_bt = 14  //Top, Bottom Border Space
ii_area_Space = 50 //Between Area Space
ii_gadget_space = 30

gb_1.y = ii_border_bt
gb_2.y = ii_border_bt
gb_3.y = ii_border_bt
end subroutine

public function integer of_gen_area_insert (ref str_gadget astr_area[], str_gadget astr_new_gadget);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_gen_area_insert()
// $<arguments>
//			str_gadget  astr_area[]		
//			str_gadget	astr_new_gadget		
// $<returns> integer
// $<description> Insert a gadget in Area List. And need sort gadget.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

str_gadget lstr_area_temp[]
Int i
Boolean lb_inserted = False

For i = 1 To Upperbound(astr_area[])
	If astr_area[i].gadget_id = 0 Then Continue
	If Not isvalid(iuo_gadget_list[astr_area[i].gadget_id]) Then Continue
	If lb_inserted Then
		lstr_area_temp[UpperBound(lstr_area_temp[]) + 1] = astr_area[i]
	Else
		If iuo_gadget_list[astr_area[i].gadget_id].y <= iuo_gadget_list[astr_new_gadget.gadget_id].y	Then
			lstr_area_temp[UpperBound(lstr_area_temp[]) + 1] = astr_area[i]
		Else
			lstr_area_temp[UpperBound(lstr_area_temp[]) + 1] = astr_new_gadget
			lstr_area_temp[UpperBound(lstr_area_temp[]) + 1] = astr_area[i]
			lb_inserted = True
		End If
	End If
Next
If lb_inserted = False Then lstr_area_temp[UpperBound(lstr_area_temp[]) + 1] = astr_new_gadget	
astr_area[] = lstr_area_temp[]

Return 1
	
end function

public subroutine of_gen_area_ini (str_gadget astr_area1[], str_gadget astr_area2[], str_gadget astr_area3[], str_gadget astr_area4[]);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadgetof_gen_area_ini()
// $<arguments>
//		str_gadget	astr_area1[]		
//		str_gadget	astr_area2[]		
//		str_gadget	astr_area3[]		
//		str_gadget	astr_area4[]		
// $<returns> (none)
// $<description>
// $<description>Set Area Array list.
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

istr_Area1[] = astr_area1[]
istr_Area2[] = astr_area2[]
istr_Area3[] = astr_area3[]
istr_Area4[] = astr_area4[]
end subroutine

public subroutine of_refresh_ui ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_refresh_ui()
// $<arguments>(None)
// $<returns> (none)
// $<description> Refresh UI.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If istr_current_tab.ss_tab_style = '' Then Return //Means new tabpage has no gadgets
This.SetRedraw(False)
of_set_visiable()
of_set_style(istr_current_tab.ss_tab_style,istr_current_tab.ss_tab_style_type)
of_set_tab_properties()
of_set_gadgets_properties() 
of_set_position()
This.SetRedraw(True)
end subroutine

public function integer of_reset_area_array ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadgetof_reset_area_array()
// $<arguments>(None)
// $<returns> (none)
// $<description> Delete empty value in Area List, and update to gadgets.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i,li_cnt,li_ret
str_gadget lstr_Area_temp[] 

//For Area1
lstr_Area_temp[] = istr_Area1[]
li_cnt = UpperBound(lstr_Area_temp[])
istr_Area1[] = istr_Area_Empty[]
For  i = 1 To li_cnt
	If lstr_Area_temp[i].gadget_id <> 0 Then
		lstr_Area_temp[i].area_number = 1		
		istr_Area1[UpperBound(istr_Area1)+1] = lstr_Area_temp[i]
	End If
Next

//For Area2
lstr_Area_temp[] = istr_Area2[]
li_cnt = UpperBound(lstr_Area_temp[])
istr_Area2[] = istr_Area_Empty[]
For  i = 1 To li_cnt
	If lstr_Area_temp[i].gadget_id <> 0 Then
		lstr_Area_temp[i].area_number = 2				
		istr_Area2[UpperBound(istr_Area2)+1] = lstr_Area_temp[i]
	End If
Next

//For Area3
lstr_Area_temp[] = istr_Area3[]
li_cnt = UpperBound(lstr_Area_temp[])
istr_Area3[] = istr_Area_Empty[]
For  i = 1 To li_cnt
	If lstr_Area_temp[i].gadget_id <> 0 Then
		lstr_Area_temp[i].area_number = 3		
		istr_Area3[UpperBound(istr_Area3)+1] = lstr_Area_temp[i]
	End If
Next

//For Area4
lstr_Area_temp[] = istr_Area4[]
li_cnt = UpperBound(lstr_Area_temp[])
istr_Area4[] = istr_Area_Empty[]
For  i = 1 To li_cnt
	If lstr_Area_temp[i].gadget_id <> 0 Then
		lstr_Area_temp[i].area_number = 4			
		istr_Area4[UpperBound(istr_Area4)+1] = lstr_Area_temp[i]
	End If
Next

//Save to DB
li_ret = of_update_to_db()

//Update to gadgets' structure var
of_update_to_gadgets()

Return li_ret
end function

public subroutine of_set_gadgets_properties ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_set_gadgets_properties()
// $<arguments>(None)
// $<returns> (none)
// $<description> Set all gadgets' properties
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Set all gadgets' properties in current tabpage

Integer i
u_cst_gadget luo_gadget

//For Area1
For i = 1 To UpperBound(istr_Area1[])
	If istr_Area1[i].gadget_id = 0 Then Continue
	If Not isvalid(iuo_gadget_list[istr_Area1[i].gadget_id]) Then Continue
	luo_gadget = iuo_gadget_list[istr_Area1[i].gadget_id]
	luo_gadget.istr_current_gadget = istr_Area1[i]
	luo_gadget.of_set_properties( )
Next

//For Area2
For i = 1 To UpperBound(istr_Area2[])
	If istr_Area2[i].gadget_id = 0 Then Continue	
	If Not isvalid(iuo_gadget_list[istr_Area2[i].gadget_id]) Then Continue	
	luo_gadget = iuo_gadget_list[istr_Area2[i].gadget_id]
	luo_gadget.istr_current_gadget = istr_Area2[i]
	luo_gadget.of_set_properties( )
Next

//For Area3
For i = 1 To UpperBound(istr_Area3[])
	If istr_Area3[i].gadget_id = 0 Then Continue	
	If Not isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then Continue	
	luo_gadget = iuo_gadget_list[istr_Area3[i].gadget_id]
	luo_gadget.istr_current_gadget = istr_Area3[i]
	luo_gadget.of_set_properties( )
Next

//For Area4
For i = 1 To UpperBound(istr_Area4[])
	If istr_Area4[i].gadget_id = 0 Then Continue	
	If Not isvalid(iuo_gadget_list[istr_Area4[i].gadget_id]) Then Continue	
	luo_gadget = iuo_gadget_list[istr_Area4[i].gadget_id]
	luo_gadget.istr_current_gadget = istr_Area4[i]
	luo_gadget.of_set_properties( )
Next


end subroutine

public function integer of_set_tab_properties ();//Set current tab's properties
w_dashboard.of_set_tab_bg_color(w_dashboard.tab_dashboard.SelectedTab)
This.backcolor = istr_current_tab.sl_tab_bg_color
This.tabbackcolor = istr_current_tab.sl_tab_bg_color
This.Text = istr_current_tab.ss_tab_title
This.Tabtextcolor = istr_current_tab.sl_tab_text_color
If istr_current_tab.si_tab_locked = 1 Then
	//This.picturename = 'Custom016!' 
	This.picturename = 'lock.gif'
Else
	This.picturename = '' 
End If
Return 1
end function

public subroutine of_set_style (string as_style, string as_style_type);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_set_style()
// $<arguments>
//		value	string	as_style	
//		value	string	as_style_type	
// $<returns> (none)
// $<description> Modify Groupbox's position That is template after Style is changed.
// Below is Style Figure:  
//          Style '20'                       Style '30'
//   *************************      *************************                                                              
//   *           *           *      *       *       *       *                                                                
//   *           *           *      *       *       *       *                                         	
//   * Area1     * Area2     *      * Area1 * Area2 * Area3 *          
//   *           *           *      *       *       *       *
//   *           *           *      *       *       *       *
//   *************************      *************************                                                
//
//          Style '21'                       Style '31'
//   *************************      *************************                                                              
//   *           *           *      *       *       *       *                                                                
//   * Area1     * Area2     *      * Area1 * Area2 * Area3 *          
//   *************************      *************************
//   *         Area4         *      *         Area4         *
//   *                       *      *                       *
//   *************************      *************************                                                
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Int li_Area_width

//Reset Groupbox
gb_1.Enabled = True
gb_2.Enabled = True
gb_3.Enabled = True
gb_4.Enabled = True

istr_current_tab.ss_tab_style = as_style
istr_current_tab.ss_tab_style_type = as_style_type

If istr_current_tab.ss_tab_style_type = 'A' Then
	//Set Style
	Choose Case as_style
		Case '20' //2 Columns and 0 bottom
			gb_3.Enabled = False
			gb_4.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 1*ii_area_Space) 
			gb_1.Width = li_area_width * (1/2)
			gb_2.Width = li_area_width * (1/2)
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = -10000
			gb_4.x = -10000
			ln_split.visible = False
		Case '30' //3 Columns and 0 bottom
			gb_4.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 2*ii_area_Space) 
			gb_1.Width = li_area_width * (1/3)
			gb_2.Width = li_area_width * (1/3)
			gb_3.Width = li_area_width * (1/3)
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = gb_2.x + gb_2.width + ii_area_Space
			gb_4.x = -10000
			ln_split.visible = False
		Case '21' //2 Cloumns and 1 Bottom 
			gb_3.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 1*ii_area_Space) 
			gb_1.Width = li_area_width * (1/2)
			gb_2.Width = li_area_width * (1/2)
			gb_4.Width = This.Width -ii_border_Left - ii_border_right
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_4.x = ii_border_left
			gb_3.x = -10000
			ln_split.visible = True		
			ln_split.BeginX = 0
			ln_split.EndX = gb_4.x	+ gb_4.width + 100	
		Case '31' //3 Columns and 1 Bottom
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 2*ii_area_Space) 
			gb_1.Width = li_area_width * (1/3)
			gb_2.Width = li_area_width * (1/3)
			gb_3.Width = li_area_width * (1/3)
			gb_4.Width = This.Width -ii_border_Left - ii_border_right
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = gb_2.x + gb_2.width + ii_area_Space
			gb_4.x = ii_border_left
			ln_split.visible = True
			ln_split.BeginX = 0
			ln_split.EndX = gb_4.x	+ gb_4.width + 100			
	End Choose
Else  //Type = 'B'
	//Set Style
	Choose Case as_style
		Case '20' //2 Columns and 0 bottom
			gb_3.Enabled = False
			gb_4.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 1*ii_area_Space) 
			gb_1.Width = li_area_width * (1/3)
			gb_2.Width = li_area_width * (2/3) 
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = -10000
			gb_4.x = -10000
			ln_split.visible = False
		Case '30' //3 Columns and 0 bottom
			gb_4.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 2*ii_area_Space) 
			gb_1.Width = li_area_width * (1/4)
			gb_2.Width = li_area_width * (2/4)
			gb_3.Width = li_area_width * (1/4)
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = gb_2.x + gb_2.width + ii_area_Space
			gb_4.x = -10000
			ln_split.visible = False
		Case '21' //2 Cloumns and 1 Bottom 
			gb_3.Enabled = False
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 1*ii_area_Space) 
			gb_1.Width = li_area_width * (1/3)
			gb_2.Width = li_area_width * (2/3)
			gb_4.Width = This.Width -ii_border_Left - ii_border_right
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_4.x = ii_border_left
			gb_3.x = -10000
			ln_split.visible = True		
			ln_split.BeginX = 0
			ln_split.EndX = gb_4.x	+ gb_4.width + 100	
		Case '31' //3 Columns and 1 Bottom
			li_area_width = (This.Width - ii_border_Left - ii_border_right - 2*ii_area_Space) 
			gb_1.Width = li_area_width * (1/4)
			gb_2.Width = li_area_width * (2/4)
			gb_3.Width = li_area_width * (1/4)
			gb_4.Width = This.Width -ii_border_Left - ii_border_right
			gb_1.x = ii_border_left
			gb_2.x = gb_1.x + gb_1.width + ii_area_Space
			gb_3.x = gb_2.x + gb_2.width + ii_area_Space
			gb_4.x = ii_border_left
			ln_split.visible = True
			ln_split.BeginX = 0
			ln_split.EndX = gb_4.x	+ gb_4.width + 100			
	End Choose	
End If

//If Style is changed, auto-generate area list.
If ib_style_changed Then of_gen_area_auto()
end subroutine

public function integer of_update_from_gadget (str_gadget astr_gadget);//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_update_from_gadget()
// $<arguments>
//		value	str_gadget	astr_gadget		
// $<returns> integer
// $<description> Update gadget's properties to DB
//////////////////////////////////////////////////////////////////////
// $<add> 31/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i,li_ret
Boolean lb_changed = False
Choose Case astr_gadget.area_number
	Case	1
		For i = 1 To UpperBound(istr_Area1[])
			If astr_gadget.Gadget_id = istr_Area1[i].gadget_id Then
				If istr_Area1[i] <> astr_gadget Then
					istr_Area1[i] = astr_gadget
					lb_changed = True
					Exit
				Else
					Exit
				End If
			End If
		Next
		If i > UpperBound(istr_Area1[]) Then Return -100 //Not Found
	Case	2
		For i = 1 To UpperBound(istr_Area2[])
			If astr_gadget.Gadget_id = istr_Area2[i].gadget_id Then
				If istr_Area2[i] <> astr_gadget Then
					istr_Area2[i] = astr_gadget
					lb_changed = True
					Exit
				Else
					Exit
				End If
			End If
		Next
		If i > UpperBound(istr_Area2[]) Then Return -100 //Not Found
	Case	3
		For i = 1 To UpperBound(istr_Area3[])
			If astr_gadget.Gadget_id = istr_Area3[i].gadget_id Then
				If istr_Area3[i] <> astr_gadget Then
					istr_Area3[i] = astr_gadget
					lb_changed = True
					Exit
				Else
					Exit
				End If
			End If
		Next
		If i > UpperBound(istr_Area3[]) Then Return -100 //Not Found
	Case	4
		For i = 1 To UpperBound(istr_Area4[])
			If astr_gadget.Gadget_id = istr_Area4[i].gadget_id Then
				If istr_Area4[i] <> astr_gadget Then
					istr_Area4[i] = astr_gadget
					lb_changed = True
					Exit
				Else
					Exit
				End If
			End If
		Next
		If i > UpperBound(istr_Area4[]) Then Return -100 //Not Found
End Choose
If lb_changed Then
	li_ret = of_update_to_db()
	Return li_ret
End If
Return 1
end function

public function integer of_update_to_db ();Integer li_ret

li_ret = w_dashboard.inv_dashboard.of_update_area_to_db(istr_current_tab.sl_tab_id,istr_Area1[],istr_Area2[],istr_Area3[],istr_Area4[])
Return li_ret
end function

public function integer of_update_to_gadgets ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_update_to_gadgets()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Update all gadgets' structure var.
//////////////////////////////////////////////////////////////////////
// $<add> 01/08/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int i,li_ret

//For Area1
For i = 1 To UpperBound(istr_Area1[])
	If Not isvalid(iuo_gadget_list[istr_Area1[i].Gadget_id]) Then Continue
	iuo_gadget_list[istr_Area1[i].Gadget_id].istr_current_gadget = istr_Area1[i]
Next

//For Area2
For i = 1 To UpperBound(istr_Area2[])
	If Not isvalid(iuo_gadget_list[istr_Area2[i].Gadget_id]) Then Continue
	iuo_gadget_list[istr_Area2[i].Gadget_id].istr_current_gadget = istr_Area2[i]
Next

//For Area3
For i = 1 To UpperBound(istr_Area3[])
	If Not isvalid(iuo_gadget_list[istr_Area3[i].Gadget_id]) Then Continue
	iuo_gadget_list[istr_Area3[i].Gadget_id].istr_current_gadget = istr_Area3[i]
Next

//For Area4
For i = 1 To UpperBound(istr_Area4[])
	If Not isvalid(iuo_gadget_list[istr_Area4[i].Gadget_id]) Then Continue
	iuo_gadget_list[istr_Area4[i].Gadget_id].istr_current_gadget = istr_Area4[i]
Next

Return 1
end function

public function integer of_set_invisiable ();Int i
For i = 1 To UpperBound(iuo_gadget_list[])
	If Not Isvalid(iuo_gadget_list[i]) Then Continue
	If iuo_gadget_list[i].ib_visible_status = False Then
		iuo_gadget_list[i].Visible = False
		iuo_gadget_list[i].Border = True
		iuo_gadget_list[i].BorderStyle = StyleBox!
		iuo_gadget_list[i].Trigger Event ue_close()
	End If
Next
Return 1
end function

public function integer of_set_invisiable_status ();Int i
For i = 1 To UpperBound(iuo_gadget_list[])
	If Not isvalid(iuo_gadget_list[i]) Then Continue
	iuo_gadget_list[i].ib_visible_status = False
Next
Return 1
end function

public function integer of_refresh_do ();//////////////////////////////////////////////////////////////////////
// $<function>u_cst_tabpg_gadget::of_refresh_do()
// $<arguments>(None)
// $<returns> integer
// $<description> 
// $<description> Execute ue_do event for every visible gadget
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-13 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer i

For i = 1 To UpperBound(istr_Area1[])
	If istr_Area1[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area1[i].gadget_id]) Then 
		If iuo_gadget_list[istr_Area1[i].gadget_id].visible Then
			iuo_gadget_list[istr_Area1[i].gadget_id].Event ue_do()
		End If
	End If
Next
For i = 1 To UpperBound(istr_Area2[])
	If istr_Area2[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area2[i].gadget_id]) Then 
		If iuo_gadget_list[istr_Area2[i].gadget_id].visible Then
			iuo_gadget_list[istr_Area2[i].gadget_id].Event ue_do()
		End If
	End If
Next
For i = 1 To UpperBound(istr_Area3[])
	If istr_Area3[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area3[i].gadget_id]) Then 
		If iuo_gadget_list[istr_Area3[i].gadget_id].visible Then
			iuo_gadget_list[istr_Area3[i].gadget_id].Event ue_do()
		End If
	End If
Next
For i = 1 To UpperBound(istr_Area4[])
	If istr_Area4[i].gadget_id = 0 Then Continue
	If Isvalid(iuo_gadget_list[istr_Area4[i].gadget_id]) Then 
		If iuo_gadget_list[istr_Area4[i].gadget_id].visible Then
			iuo_gadget_list[istr_Area4[i].gadget_id].Event ue_do()
		End If
	End If
Next

Return 1
end function

public subroutine of_retrieve_same_gadget (string as_classname, boolean ab_queue);
String ls_classname
Integer i,j,li_cnt_pages,li_current_page
u_cst_tabpg_gadget luo_tabpage
u_cst_gadget luo_gadget
If Not isvalid(w_dashboard) Then Return
li_cnt_pages = UpperBound(w_dashboard.tab_dashboard.Control[])
//If li_cnt_pages < 2 Then Return
li_current_page = w_dashboard.tab_dashboard.selectedtab

If ab_queue Then gnv_appeondb.of_startqueue()
For i = 1 to li_cnt_pages
	luo_tabpage = w_dashboard.tab_dashboard.Control[i]
	For j = 1 To UpperBound(luo_tabpage.Control[])
		If luo_tabpage.Control[j].Classname() = as_classname Then
			luo_gadget =  luo_tabpage.Control[j]
			If luo_gadget.visible Then
				luo_gadget.Dynamic Event ue_retrieve()
			End If
		End If
	Next
Next
If ab_queue Then gnv_appeondb.of_commitqueue()
end subroutine

public function integer of_update_clock_to_db (integer al_face_id);Long ll_Row
DataStore ids_dashboard_tabs

If Not isvalid(w_dashboard) Then Return -100

ids_dashboard_tabs = w_dashboard.inv_dashboard.ids_dashboard_tabs

If al_face_id <=0 Or isnull(al_face_id) Then Return -1

ll_row = ids_dashboard_tabs.Find('user_id = "'+gs_user_id+'" and tab_id = '+String(istr_current_tab.sl_tab_id),1,ids_dashboard_tabs.RowCount())
If ll_row <= 0 Then Return -2

ids_dashboard_tabs.SetItem(ll_row,'clock_face_id',al_face_id)

gnv_appeondb.of_autocommitrollback( )
If ids_dashboard_tabs.update( ) = 1 Then
	Commit;
	istr_current_tab.si_clock_face_id = al_face_id
	Return 1
Else
	Rollback;
	w_dashboard.inv_dashboard.of_retrieve_data_only() //Restore data
	Return -3
End IF


Return 1
end function

on u_cst_tabpg_gadget.create
this.u_gadget_18=create u_gadget_18
this.u_gadget_9=create u_gadget_9
this.u_gadget_17=create u_gadget_17
this.u_gadget_16=create u_gadget_16
this.u_gadget_15=create u_gadget_15
this.u_gadget_14=create u_gadget_14
this.u_gadget_13=create u_gadget_13
this.u_gadget_12=create u_gadget_12
this.u_gadget_5=create u_gadget_5
this.u_gadget_11=create u_gadget_11
this.u_gadget_2=create u_gadget_2
this.u_gadget_10=create u_gadget_10
this.u_gadget_3=create u_gadget_3
this.u_gadget_6=create u_gadget_6
this.u_gadget_4=create u_gadget_4
this.u_gadget_8=create u_gadget_8
this.u_gadget_7=create u_gadget_7
this.u_gadget_1=create u_gadget_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_4=create gb_4
this.ln_split=create ln_split
this.Control[]={this.u_gadget_18,&
this.u_gadget_9,&
this.u_gadget_17,&
this.u_gadget_16,&
this.u_gadget_15,&
this.u_gadget_14,&
this.u_gadget_13,&
this.u_gadget_12,&
this.u_gadget_5,&
this.u_gadget_11,&
this.u_gadget_2,&
this.u_gadget_10,&
this.u_gadget_3,&
this.u_gadget_6,&
this.u_gadget_4,&
this.u_gadget_8,&
this.u_gadget_7,&
this.u_gadget_1,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.gb_4,&
this.ln_split}
end on

on u_cst_tabpg_gadget.destroy
destroy(this.u_gadget_18)
destroy(this.u_gadget_9)
destroy(this.u_gadget_17)
destroy(this.u_gadget_16)
destroy(this.u_gadget_15)
destroy(this.u_gadget_14)
destroy(this.u_gadget_13)
destroy(this.u_gadget_12)
destroy(this.u_gadget_5)
destroy(this.u_gadget_11)
destroy(this.u_gadget_2)
destroy(this.u_gadget_10)
destroy(this.u_gadget_3)
destroy(this.u_gadget_6)
destroy(this.u_gadget_4)
destroy(this.u_gadget_8)
destroy(this.u_gadget_7)
destroy(this.u_gadget_1)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.ln_split)
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>u_cst_tabpg_gadget::constructor()
// $<arguments>(None)
// $<returns> long
// $<description> 
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

of_resize_ini()
of_generate_control()


end event

type u_gadget_18 from u_cst_gadget_getting_started within u_cst_tabpg_gadget
string tag = "u_gadget_18.Getting Started"
boolean visible = false
integer x = 594
integer y = 528
integer taborder = 60
boolean border = true
end type

on u_gadget_18.destroy
call u_cst_gadget_getting_started::destroy
end on

type u_gadget_9 from u_cst_gadget_notes_new within u_cst_tabpg_gadget
boolean visible = false
integer x = 361
integer y = 308
integer taborder = 30
boolean border = true
end type

on u_gadget_9.destroy
call u_cst_gadget_notes_new::destroy
end on

type u_gadget_17 from u_cst_gadget_contract_templates within u_cst_tabpg_gadget
boolean visible = false
integer x = 123
integer y = 680
integer taborder = 50
boolean border = true
end type

on u_gadget_17.destroy
call u_cst_gadget_contract_templates::destroy
end on

type u_gadget_16 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
string tag = "u_gadget_16"
boolean visible = false
integer x = 1664
integer y = 936
integer taborder = 40
boolean border = true
end type

event constructor;call super::constructor;This.ii_summary_id = 5
end event

on u_gadget_16.destroy
call u_cst_gadget_summary_master::destroy
end on

type u_gadget_15 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
string tag = "u_gadget_15"
boolean visible = false
integer x = 1573
integer y = 912
integer taborder = 40
boolean border = true
end type

event constructor;call super::constructor;This.ii_summary_id = 4
end event

on u_gadget_15.destroy
call u_cst_gadget_summary_master::destroy
end on

type u_gadget_14 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
string tag = "u_gadget_14"
boolean visible = false
integer x = 1518
integer y = 872
integer taborder = 40
boolean border = true
end type

event constructor;call super::constructor;This.ii_summary_id = 3
end event

on u_gadget_14.destroy
call u_cst_gadget_summary_master::destroy
end on

type u_gadget_13 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
string tag = "u_gadget_13"
boolean visible = false
integer x = 1486
integer y = 848
integer taborder = 40
boolean border = true
end type

event constructor;call super::constructor;This.ii_summary_id = 2
end event

on u_gadget_13.destroy
call u_cst_gadget_summary_master::destroy
end on

type u_gadget_12 from u_cst_gadget_summary_master within u_cst_tabpg_gadget
string tag = "u_gadget_12"
boolean visible = false
integer x = 1440
integer y = 820
integer taborder = 30
boolean border = true
end type

event constructor;call super::constructor;This.ii_summary_id = 1
end event

on u_gadget_12.destroy
call u_cst_gadget_summary_master::destroy
end on

type u_gadget_5 from u_cst_gadget_calendar_meetings within u_cst_tabpg_gadget
boolean visible = false
integer x = 1605
integer y = 2824
integer taborder = 30
boolean border = true
end type

on u_gadget_5.destroy
call u_cst_gadget_calendar_meetings::destroy
end on

type u_gadget_11 from u_cst_gadget_clock within u_cst_tabpg_gadget
integer x = 91
integer y = 2528
integer taborder = 70
boolean border = true
end type

on u_gadget_11.destroy
call u_cst_gadget_clock::destroy
end on

type u_gadget_2 from u_cst_gadget_favorite_reports within u_cst_tabpg_gadget
boolean visible = false
integer x = 1760
integer y = 2128
integer taborder = 60
boolean border = true
end type

on u_gadget_2.destroy
call u_cst_gadget_favorite_reports::destroy
end on

type u_gadget_10 from u_cst_gadget_global_search within u_cst_tabpg_gadget
boolean visible = false
integer x = 1609
integer y = 1676
integer taborder = 60
boolean border = true
end type

on u_gadget_10.destroy
call u_cst_gadget_global_search::destroy
end on

type u_gadget_3 from u_cst_gadget_favorite_correspondence within u_cst_tabpg_gadget
boolean visible = false
integer x = 1454
integer y = 96
integer taborder = 70
boolean border = true
end type

on u_gadget_3.destroy
call u_cst_gadget_favorite_correspondence::destroy
end on

type u_gadget_6 from u_cst_gadget_favorite_workflow within u_cst_tabpg_gadget
boolean visible = false
integer x = 1673
integer y = 2092
integer taborder = 60
boolean border = true
end type

on u_gadget_6.destroy
call u_cst_gadget_favorite_workflow::destroy
end on

type u_gadget_4 from u_cst_gadget_message_board within u_cst_tabpg_gadget
boolean visible = false
integer x = 82
integer y = 3188
integer taborder = 60
boolean border = true
end type

on u_gadget_4.destroy
call u_cst_gadget_message_board::destroy
end on

type u_gadget_8 from u_cst_gadget_recent_ctx within u_cst_tabpg_gadget
boolean visible = false
integer x = 210
integer y = 1844
integer taborder = 50
boolean border = true
end type

on u_gadget_8.destroy
call u_cst_gadget_recent_ctx::destroy
end on

type u_gadget_7 from u_cst_gadget_recent_prac within u_cst_tabpg_gadget
boolean visible = false
integer x = 82
integer y = 1796
integer taborder = 40
boolean border = true
end type

on u_gadget_7.destroy
call u_cst_gadget_recent_prac::destroy
end on

type u_gadget_1 from u_cst_gadget_todolist within u_cst_tabpg_gadget
boolean visible = false
integer x = 82
integer y = 104
integer width = 1275
integer taborder = 30
boolean border = true
end type

on u_gadget_1.destroy
call u_cst_gadget_todolist::destroy
end on

type gb_3 from groupbox within u_cst_tabpg_gadget
boolean visible = false
integer x = 2784
integer y = 24
integer width = 1339
integer height = 784
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area03"
end type

type gb_2 from groupbox within u_cst_tabpg_gadget
boolean visible = false
integer x = 1426
integer y = 24
integer width = 1339
integer height = 784
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area02"
end type

type gb_1 from groupbox within u_cst_tabpg_gadget
boolean visible = false
integer x = 37
integer y = 24
integer width = 1339
integer height = 784
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area01"
end type

type gb_4 from groupbox within u_cst_tabpg_gadget
boolean visible = false
integer x = 64
integer y = 836
integer width = 3589
integer height = 628
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Area04"
end type

type ln_split from line within u_cst_tabpg_gadget
boolean visible = false
long linecolor = 10789024
integer linethickness = 4
end type

