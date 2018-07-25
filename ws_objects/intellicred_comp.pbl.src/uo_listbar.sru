$PBExportHeader$uo_listbar.sru
forward
global type uo_listbar from u_dw
end type
end forward

global type uo_listbar from u_dw
integer width = 1019
integer height = 2136
string dataobject = "d_ezmenu_list"
boolean border = false
boolean ib_isupdateable = false
boolean ib_showtipshelp = false
event type integer ue_pre_click ( string as_click_item,  integer ai_x,  integer ai_y )
event ue_clicked ( string as_click_items )
event ue_dock ( string as_status )
end type
global uo_listbar uo_listbar

type variables
Integer				ii_Width = 1019
Boolean				ib_Dock_Prevent

Private:
DataStore			ids_Store, ids_Expand, ids_Main, ids_original

Boolean				ib_Resize
Boolean				ib_Split
Boolean				ib_CustomizeToolbarAttr

String					is_LastMenuName

n_tooltip				inv_ToolTip

Integer				ii_DwTabular, il_LastRow

Long					il_VScrollPosition

n_cst_dm_utils		inv_utils

String					is_User ='intellisoft-super-master'
String					is_ErrorPictrue = 'error.gif'
end variables

forward prototypes
public function integer of_addgroup (integer al_groupno, string as_groupname)
public function integer of_expand (integer ai_groupno)
public function integer of_collapse (integer ai_groupno)
public subroutine of_adjustwidth ()
public subroutine of_resizemdi ()
public function integer of_click_item (menu am_menu, string as_click_items)
public subroutine of_set_menu (menu am_menu)
public function integer of_add_child_item (integer ai_groupno, integer ai_itemno, integer ai_childitemno, string as_child_item, string as_child_pic)
public function integer of_additem (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, string as_item, string as_pic, string as_toolbarname, integer ai_index)
public function integer of_getgroup (string as_menuname, integer ai_itemsorts2)
public function integer of_addsplitbar (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, integer ai_index, integer ai_row)
public function integer of_addgroupblank (integer ai_groupno, integer ai_itemno, integer ai_row)
public function integer of_additem (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, string as_item, string as_pic, string as_toolbarname, integer ai_index, integer ai_row)
public function string of_getstring (string as_source, string as_char)
public function integer of_copyezmenuto (datawindow adw_target)
public subroutine of_setenabled (string as_parentmenuname, string as_menuname, boolean ab_enabled)
public subroutine of_refreshenabled (menu ab_menu)
public subroutine of_set_menu_quick (menu am_menu)
public subroutine of_setvisible (string as_parentmenu, string as_menu, boolean ab_value)
public subroutine of_setchecked (string as_parentmenu, string as_menu, boolean ab_value)
public subroutine of_settext (string as_parentmenu, string as_menu, string as_text)
public subroutine of_setitemname (string as_parentmenu, string as_menu, string as_name)
public subroutine of_set_screen ()
public subroutine of_settoolbarattr (string as_parent, string as_name, menu am_menu)
public subroutine of_refresh_toolbar (menu am_menu)
public subroutine of_restore_toolbar_attr (menu am_menu)
public subroutine of_show_child_menu (string as_name, integer ai_x, integer ai_y)
public subroutine of_reset_original (menu am_menu)
public subroutine of_setoriginalvalue (string as_parent, string as_toolbarname, ref string as_text, ref string as_pic)
public function string of_get_user ()
end prototypes

event type integer ue_pre_click(string as_click_item, integer ai_x, integer ai_y);//event  before  clicking

Window			lw_ActiveW

lw_ActiveW = w_mdi.GetActivesheet( )

If Isvalid( lw_ActiveW ) Then
	//---------Begin Modified by (Appeon)Harry 05.05.2014 for V142 ISG-CLX--------
	//SetFocus(  lw_activeW )
	If isvalid( gw_contract ) Then //added by gavins 20140428
		If	IsValid( gw_contract.of_GetActiveDataWindow( ) ) Then gw_Contract.of_GetActiveDataWindow( ).SetFocus( )
	End If	
	//---------End Modfiied ------------------------------------------------------
End If


If as_click_Item = "m_newctx" Or as_click_item = 'm_copyctx' or as_click_item = 'm_usetemplate' Then
	of_show_child_menu(   as_click_item, ai_x, ai_y )
	return -1
End If


Return 1
end event

event ue_clicked(string as_click_items);//   clicking  event

Long			ll_i
Menu			lm_Relate_menu


If IsValid( w_mdi) Then lm_Relate_menu = w_mdi.menuid

If IsValid( lm_Relate_menu ) Then

	of_click_item( lm_Relate_menu, as_click_items )
End If



end event

event ue_dock(string as_status);if as_status = '0' then
	
	event clicked ( 0, 0 ,0 , this.object.t_contract )
Else
	event clicked ( 0, 0 ,0 , this.object.t_expand )
end if
end event

public function integer of_addgroup (integer al_groupno, string as_groupname);Long			ll_Find	, ll_row

ll_Find = ids_Store.Find( "groupname='" + as_groupname + "'", 1, rowcount() )


If ll_Find > 0 Then
	Return 1
	//pause 	
End If




ll_Row = ids_Store.Insertrow( 0 )

ids_Store.SetItem( ll_Row, 'groupname', as_groupname  )

ids_Store.SetItem( ll_Row, 'groupno', al_groupno  )

ids_Store.SetItem( ll_Row, 'items_sorts', '0'  )

ids_Store.SetItem( ll_Row, 'arrowdirect', 0 )	

ids_Store.SetItem( ll_Row, 'groupblank', -1 )	

ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  1 )




Return 1
end function

public function integer of_expand (integer ai_groupno);Long			ll_Find, ll_i, ll_ScrollBarPosition

this.setredraw( false )

ll_Find = This.Find( "groupno = " + string( ai_groupno)  + " and groupblank =-1"  ,1, This.RowCount( ) )
If ll_Find > 0 Then
	This.SetItem( ll_Find, 'arrowdirect', 0 )	
End If

ll_ScrollBarPosition = Long( This.Describe( "datawindow.verticalscrollposition" ) )

For ll_i = 1 To ids_Expand.Rowcount( )
	If ids_Expand.object.groupno[ll_i] =   ai_groupno Then
		ids_Expand.RowsMove( ll_i, ll_i, Primary!, This, 1, Primary! )
		ll_i = ll_i - 1
	End If	
Next

This.Sort( )

This.Modify( "datawindow.verticalscrollposition=" + string( ll_ScrollBarPosition  ) )
this.setredraw( true )
return 1
end function

public function integer of_collapse (integer ai_groupno);Long			ll_Find, ll_i

this.setredraw( false )
ll_Find = This.Find( "groupno = " + string( ai_groupno) + " and groupblank=-1"    ,1, This.RowCount( ) )
If ll_Find > 0 Then
	This.SetItem( ll_Find, 'arrowdirect', 1 )	
End If

For ll_i = 1 To This.Rowcount( )
	If  This.Object.groupno[ll_i] = ai_groupno and  This.Object.groupblank[ll_i] =0 Then
		this.RowsMove( ll_i, ll_i, Primary!, ids_Expand, 1, Primary! )
		ll_i = ll_i - 1
	End If	
Next
this.setredraw( true )


return 1
end function

public subroutine of_adjustwidth ();
//If ( Long( this.describe( "datawindow.verticalscrollmaximum" )) <= 0 And this.width <> 933 ) Then
//	this.Resize( 933, this.Height )
//	
//End If


//If Long( this.describe( "datawindow.verticalscrollmaximum" ) ) > 0  And this.width <> 1019 Then
//	
//	this.Resize( 1019, This.Height )
//	
//End If


end subroutine

public subroutine of_resizemdi ();w_mdi.mdi_1.move( This.x + This.width + 12 ,  This.y )
w_mdi.mdi_1.resize(w_mdi.workspaceWidth() - This.width - 12 , This.height + 4 )

If IsValid( w_dashboard ) Then
	w_dashboard.Post Event  ue_resize( )
End If
end subroutine

public function integer of_click_item (menu am_menu, string as_click_items);Long				ll_i, ll_k, ll_o, ll_j

If Not isValid( am_menu  ) Then  Return 1
	
For ll_i = 1 To UpperBound( am_menu.Item )
	If Not isValid( am_menu  ) Then Exit
	If   am_menu.item[ ll_i ].classname( ) = as_click_items  and  am_menu.item[ ll_i ].enabled and  am_menu.item[ ll_i ].toolbaritemvisible Then
		am_menu.item[ll_i].Event Clicked( )
		return 1
	End If	
	
	If UpperBound( am_menu.Item[ll_i].Item ) > 0 Then
		For ll_k = 1 To UpperBound( am_menu.Item[ll_i].Item )
			If  ( (am_menu.item[ ll_i ].enabled and am_menu.item[ll_i].typeof( ) = menucascade!) or am_menu.item[ll_i].typeof( ) <> menucascade!  ) &
				And  am_menu.item[ ll_i ].item[ll_k].classname( ) = as_click_items  and  am_menu.item[ ll_i ].item[ll_k].enabled and  am_menu.item[ ll_i ].item[ll_k].toolbaritemvisible   Then
				am_menu.item[ll_i].item[ll_k].Event Clicked( )
				return 1
			End If	
			
			If UpperBound( am_menu.Item[ll_i].item[ll_k].Item ) > 0 Then
				For ll_o = 1 To UpperBound( am_menu.Item[ll_i].item[ll_k].Item )
					If  ( (am_menu.item[ ll_i ].item[ll_k].Enabled  and am_menu.item[ll_i].item[ll_k].typeof( ) = menucascade!) or am_menu.item[ll_i].item[ll_k].typeof( ) <> menucascade!  ) &
					And am_menu.item[ ll_i ].item[ll_k].item[ll_o].classname( )=  as_click_items and  am_menu.item[ ll_i ].item[ll_k].item[ll_o].enabled and  am_menu.item[ ll_i ].item[ll_k].item[ll_o].toolbaritemvisible  Then
						am_menu.item[ll_i].item[ll_k].item[ll_o].Event Clicked( )
						return 1
					End If	
					
					//---------Begin Added by (Appeon)Harry 04.28.2014 for V142 ISG-CLX--------
					If UpperBound( am_menu.Item[ll_i].item[ll_k].item[ll_o].Item ) > 0 Then
						For ll_j = 1 To UpperBound( am_menu.Item[ll_i].item[ll_k].item[ll_o].Item )
							If  ( (am_menu.item[ ll_i ].item[ll_k].item[ll_o].Enabled  and am_menu.item[ll_i].item[ll_k].item[ll_o].typeof( ) = menucascade!) or am_menu.item[ll_i].item[ll_k].item[ll_o].typeof( ) <> menucascade!  ) &
							And am_menu.item[ ll_i ].item[ll_k].item[ll_o].item[ll_j].classname( )=  as_click_items and  am_menu.item[ ll_i ].item[ll_k].item[ll_o].item[ll_j].enabled and  am_menu.item[ ll_i ].item[ll_k].item[ll_o].item[ll_j].toolbaritemvisible  Then
								am_menu.item[ll_i].item[ll_k].item[ll_o].item[ll_j].Event Clicked( )
								return 1
							End If	
						Next
					End If
					//---------End Added ------------------------------------------------------
				Next
			End If			
		Next
	End If
Next








Return 1
end function

public subroutine of_set_menu (menu am_menu);//
If ib_Dock_Prevent Then Return
of_set_menu_quick(  am_menu )
Return 


//Menu				lm_list
//Long				ll_i, ll_k, ll_a, ll_b, ll_o, ll_c, ll_LastOrder, ll_PriorOrder, ll_ShiftToRight
//Long				ll_Order, ll_Order2, ll_MenuIndex, ll_Row, ll_MaxOrder1, ll_MaxOrder2
//Long				ll_Count, ll_GroupMinNum,ll_Find,ll_LastRow, ll_Find2
//String				ls_ItemText1, ls_ItemText2, ls_ClassName1, ls_ClassName2, ls_ClassName3
//String				ls_ParentMenu, ls_MenuTips, ls_NewItem, ls_NewTip
//String				ls_ShowMainToolBar
//Boolean			lb_Cascade,lb_Cascade2, lb_LastCascade
//
//
//lm_List = am_Menu
//
////This.SetSort( "" )
//ids_Store.Reset( )
//ll_k =9//group 
//
//For ll_i = 1 To Upperbound( lm_List.item )//1
//	ll_MenuIndex   = lm_List.Item[ll_i].toolbaritembarindex
//	ls_ClassName1 =  lm_List.Item[ll_i].classname( )
//	If lm_List.Item[ll_i].toolbaritemvisible and  Len( lm_List.Item[ll_i].toolbaritemname ) > 0  and 	Lower(lm_List.Item[ll_i].toolbaritemname ) <> "notfound!" Then
//		ls_ItemText1 =  lm_List.Item[ll_i].ToolbarItemText
//		ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName1 + '_TEXT' , FALSE )
//		ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName1 + '_TIP' , FALSE )
//		If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
//			ls_MenuTips = of_GetString( ls_ItemText1, 'last' )
//		End If
//		If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
//			ls_ItemText1 = of_GetString( ls_ItemText1, '' )
//		Else
//			ls_ItemText1 = ls_NewItem
//		End If		
//				
//		ll_b ++//sequence.
//		ll_Order = lm_List.Item[ll_i].toolbaritemorder
//		
//		ll_k = of_GetGroup(  ls_ClassName1, 0 )
//		ll_Row = This.of_Additem( ll_k,ll_b , ll_Order,100, ls_ItemText1 ,   lm_List.Item[ll_i].toolbaritemname , ls_ClassName1, ll_MenuIndex )
//		ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
//		ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
//		If Not lm_List.Item[ll_i].enabled Then
//			ids_Store.SetItem( ll_Row, 'enabled',  0 )
//		Else
//			ids_Store.SetItem( ll_Row, 'enabled',  1 )
//		End If
//	End If
//	If  lm_List.Item[ll_i].typeof( ) = menucascade! Then//
//		ll_Order = lm_List.Item[ll_i].toolbaritemorder
//		If ll_order = 0 Then  
//			ll_order = ll_b
//		End If
//		lb_Cascade = True
//	Else
//		lb_Cascade = False
//		
//	End If//
//	ll_MaxOrder1 = 0
//	For ll_a = 1 To Upperbound( lm_list.item[ll_i].item )//2
//		ll_MenuIndex   = lm_List.Item[ll_i].item[ll_a].toolbaritembarindex
//		ls_ClassName2 =  lm_List.Item[ll_i].item[ll_a].classname( )
//		If ls_ClassName2 = 'm_output' and ls_ClassName1 = 'm_reports' then continue
//		If  lm_List.Item[ll_i].item[ll_a].toolbaritemvisible and  Len( lm_List.Item[ll_i].item[ll_a].toolbaritemname ) > 0  and &
//					Lower(lm_List.Item[ll_i].item[ll_a].toolbaritemname ) <> "notfound!" Then
//			ls_ItemText1 =  lm_List.Item[ll_i].item[ll_a].ToolbarItemText
//			
//			ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName2 + '_TEXT' , FALSE )
//			ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName2 + '_TIP' , FALSE )
//			If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
//				ls_MenuTips = of_GetString( ls_ItemText1, 'last' )
//			End If
//			If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
//				ls_ItemText1 = of_GetString( ls_ItemText1, '' )
//			Else
//				ls_ItemText1 = ls_NewItem
//			End If		
//			ll_PriorOrder = lm_List.Item[ll_i].item[ll_a].toolbaritemorder
//			
//			ll_k = of_GetGroup(  ls_ClassName2, 0 )
//			If lb_Cascade Then
//				If  lm_List.Item[ll_i].toolbaritemvisible Then
//					ll_b ++
//					If ll_PriorOrder = 0 Then ll_PriorOrder = ll_a
//					If ll_MaxOrder1 < ll_PriorOrder Then ll_MaxOrder1 = ll_PriorOrder 
//					ll_Row = This.of_Additem( ll_k, ll_b, ll_Order , ll_PriorOrder, ls_ItemText1 ,   lm_List.Item[ll_i].item[ll_a].toolbaritemname,ls_ClassName2 , ll_MenuIndex )
//					ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
//					ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
//					If Not lm_List.Item[ll_i].item[ll_a].enabled Then 
//						ids_Store.SetItem( ll_Row, 'enabled',  0 )
//					Else
//						ids_Store.SetItem( ll_Row, 'enabled',  1 )
//					End If	
//				End If
//			Else
//				ll_b ++
//				ll_Row = This.of_Additem( ll_k, ll_b, ll_PriorOrder ,100, ls_ItemText1 ,   lm_List.Item[ll_i].item[ll_a].toolbaritemname , ls_ClassName2, ll_MenuIndex )
//				If lm_List.Item[ll_i].item[ll_a].ShiftToRight Then  ids_Store.SetItem( ll_Row, 'items_child_sorts', ll_a )
//				ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
//				ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
//				If Not lm_List.Item[ll_i].item[ll_a].enabled Then
//					ids_Store.SetItem( ll_Row, 'enabled',  0 )
//				Else
//					ids_Store.SetItem( ll_Row, 'enabled',  1 )
//				End If	
//			End If
//		End If
//	
//		If  lm_List.Item[ll_i].item[ll_a].typeof( ) = menucascade! Then//
//			ll_Order2 = lm_List.Item[ll_i].item[ll_a].toolbaritemorder
//			If ll_order2 = 0 Then 
//				ll_order2 = ll_b
//			End If
//			lb_Cascade2 = True
//		Else
//			lb_Cascade2 = False
//		End If//
//		ll_MaxOrder2 = 0		
//		For ll_o = 1 To Upperbound( lm_list.item[ll_i].item[ll_a].item )//3
//			ll_MenuIndex   = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritembarindex
//			ls_ClassName3 =  lm_List.Item[ll_i].item[ll_a].item[ll_o].classname( )
//			If ls_ClassName3 = 'm_merge0' And ls_ClassName2 = 'm_merge' Then Continue
//			If lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemvisible  and len(  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemname ) > 0 Then
//				ls_ItemText2 = lm_List.Item[ll_i].item[ll_a].item[ll_o].ToolbarItemText
//				
//				ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName2 + '_' + ls_ClassName3 + '_TEXT' , FALSE )
//				ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName2 + '_' + ls_ClassName3 + '_TIP' , FALSE )
//				If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
//					ls_MenuTips = of_GetString( ls_ItemText2, 'last' )
//				End If
//				If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
//					ls_ItemText2 = of_GetString( ls_ItemText2, '' )
//				Else
//					ls_ItemText2 = ls_NewItem
//				End If		
//					
//				ll_LastOrder = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemorder
//				
//				ll_k = of_GetGroup(  ls_ClassName3, 0 )
//				If lb_Cascade2 Then
//					If  lm_List.Item[ll_i].item[ll_a].toolbaritemvisible Then
//						ll_b ++
//						If ll_LastOrder = 0 Then ll_LastOrder = ll_o
//						If ll_MaxOrder2 < ll_LastOrder Then ll_MaxOrder2 = ll_LastOrder 
//						ll_Row = This.of_Additem( ll_k, ll_b, ll_Order2, ll_LastOrder, ls_ItemText2 ,  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemname ,ls_ClassName3 , ll_MenuIndex )
//						ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName2 )
//						ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
//						If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].enabled Then 
//							ids_Store.SetItem( ll_Row, 'enabled',  0 )
//						Else
//							ids_Store.SetItem( ll_Row, 'enabled',  1 )
//						End If	
//					End If
//				Else
//					ll_b ++
//					ll_Row = This.of_Additem( ll_k, ll_b, ll_LastOrder,100, ls_ItemText2 ,  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemname , ls_ClassName3, ll_MenuIndex )
//					ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName2 )
//					ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
//					If Not  lm_List.Item[ll_i].item[ll_a].item[ll_o].enabled Then
//						ids_Store.SetItem( ll_Row, 'enabled',  0 )
//					Else
//						ids_Store.SetItem( ll_Row, 'enabled',  1 )
//					End If	
//				End If
//			End If
//			
//		Next
//		
//	Next
//	//
//Next
//
//ll_Count = ids_Store.RowCount( )
//
//ll_Find = ids_Store.Find( "menuindex>1", 1, ids_store.Rowcount( ) )//have multi-menu
//If ll_Find = 0 Then
//	ll_Find = ids_Store.Find( "groupno < 9 and len( toolbarname)>0", 1, ids_store.Rowcount( ) )
//	If ll_Find> 0 Then
//		ll_GroupMinNum = ids_Store.object.items_sorts2[ll_Find] 
//	End If
//	
//	//grouping
//	For ll_i = 1 To ll_Count
//		If ll_Find > 0 and 	ids_Store.object.groupno[ll_i] =9  And  ids_Store.object.splitbar[ll_i] = 0  Then
//			ids_Store.object.groupno[ll_i] = of_GetGroup(  ids_Store.object.toolbarname[ll_i], ll_GroupMinNum ) 
//		End If
//	Next
//Else
//	ll_Find = ids_Store.Find( "toolbarname = 'm_close'", 1, ids_store.Rowcount( ) )
//	If ll_Find> 0 Then
//		ids_Store.object.groupno[ll_Find] = 1
//	End If
//End If
//
//ids_Store.Sort( )
////----------------------------------------------------//copy to main  , it is  used for comparing .
//If Lower(am_Menu.ClassName( )) = "m_pfe_cst_mdi_menu" Then
//	ids_Main.Reset( )
//	ids_Store.RowsCopy(1, ids_Store.RowCount( ), primary!, ids_Main, 1, Primary! )
//	ll_Row = ids_Main.insertRow( 0 )
//	ids_Main.SetItem( ll_Row, 'toolbarname' , 'm_actionitems' )
//	ids_Main.SetItem( ll_Row, 'parentmenu' , 'm_file' )
//	ids_Main.SetItem( ll_Row, 'items_sorts2' ,  9 )
//End If
////----------------------------------------------------//
//
////Add splitbar
//lb_Cascade = False
//lb_LastCascade =False
//If ll_Count > 0 Then ll_order = ids_Store.object.groupno[1]
//
//For ll_i = 1 To ll_Count
//	If ids_Store.object.items_sorts3[ll_i] <> 100  And Not lb_Cascade Then
//		ls_ParentMenu = ids_Store.object.parentmenu[ll_i]
//		lb_Cascade = True
//		If ll_i > 1 Then
//			If  ids_Store.object.splitbar[ll_i - 1] = 0 Then
//				ll_Count++
//				This.of_AddSplitBar( ids_Store.object.groupno[ll_i],  ids_Store.object.items_sorts[ll_i], ids_Store.object.items_sorts2[ll_i] , 0 , ids_Store.object.MenuIndex[ll_i], ll_i )
//				Continue
//			End If
//		End If
//	End If
//
//	If lb_CasCade And ls_ParentMenu <>  string(ids_Store.object.parentmenu[ll_i]) And ll_i < ll_Count Then
//		lb_Cascade = False
//		ll_Count++
//		This.of_AddSplitBar( ids_Store.object.groupno[ll_i - 1],  ids_Store.object.items_sorts[ll_i - 1], ids_Store.object.items_sorts2[ll_i - 1] , ids_Store.object.items_sorts3[ll_i - 1] + 1 , ids_Store.object.MenuIndex[ll_i - 1], ll_i )
//	End If
//	
//Next
//
//ll_Find = ids_Store.Find( "groupno < 9", 1, ids_store.Rowcount( ) )
//If ll_Find > 0 Then
//	ll_Find = ids_Store.Find( "groupno = 9", 1, ids_store.Rowcount( ) )
//	If ll_Find > 0 Then
//		ll_Find = this.of_addgroupblank( 2, ids_Store.object.items_sorts[ll_Find], ll_Find )
//		This.of_Additem( 1,999999, 999999,0, '' ,  '' , '', 1, ll_Find  ) 
//	End If
//End If
////blank row
//This.of_Additem( ll_k,999999, 999999,0, '' ,  '' , '', 1 ) 
//
//
//ls_ShowMainToolBar = gnv_user_option.of_Get_Option_value( gs_user_id, 'EZMENU_SHOWMAINTOOLBAR' )
//If isnull(ls_ShowMainToolBar) Then ls_ShowMainToolBar = ''
//If trim(ls_ShowMainToolBar) = '' Or ls_ShowMainToolBar = '1' Then
//	ll_Find = ids_Store.Find( "groupno = 2", 1, ids_store.Rowcount( ) )
//	If ll_Find > 0 Then ids_Store.RowsMove( ll_Find, ids_Store.RowCount( ), primary!, ids_Store, 1, delete! )
//End If
//
//
//of_AdjustWidth( )
//
//This.ShareDataoff(   )
//ids_Store.ShareData( This )
//



end subroutine

public function integer of_add_child_item (integer ai_groupno, integer ai_itemno, integer ai_childitemno, string as_child_item, string as_child_pic);Long			ll_Find	, ll_row

ll_Row = ids_Store.Insertrow( 0 )

ids_Store.SetItem( ll_Row, 'items_child', as_child_item  )

ids_Store.SetItem( ll_Row, 'groupno', ai_groupno  )

ids_Store.SetItem( ll_Row, 'items_sorts', ai_itemno  )
ids_Store.SetItem( ll_Row, 'items_child_sorts', ai_childitemno  )

ids_Store.SetItem( ll_Row, 'childpic', as_child_pic  )

ids_Store.SetItem( ll_Row, 'groupblank', 0 )	
ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  1 )


Return 1
end function

public function integer of_additem (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, string as_item, string as_pic, string as_toolbarname, integer ai_index);//
Return of_additem( ai_groupno, ai_itemno, ai_itemno2, ai_itemno3,as_item,as_pic, as_toolbarname, ai_index , 0 )
end function

public function integer of_getgroup (string as_menuname, integer ai_itemsorts2);Long			ll_Find

If ids_Main.RowCount( ) = 0 Then
	ll_Find = 9
Else

	ll_Find = ids_Main.Find( "toolbarname='" + as_menuname+"'", 1, ids_Main.RowCount( ) )
	
	If ll_Find > 0 Then
		If ai_itemsorts2 > 0  And ids_Main.object.items_sorts2[ll_Find] > ai_itemsorts2 then
			ll_Find = 1
		Else
			ll_Find = 9
		End If
	Else
		ll_Find = 1
	End If
End If


Return ll_Find
end function

public function integer of_addsplitbar (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, integer ai_index, integer ai_row);Long			ll_Find	, ll_row


If ai_Row > 0 Then
	ll_Row = ids_Store.Insertrow(ai_Row )	
Else
	ll_Row = ids_Store.Insertrow( 0 )
End If


ids_Store.SetItem( ll_Row, 'groupno', ai_groupno  )

ids_Store.SetItem( ll_Row, 'items_sorts', ai_itemno  )
ids_Store.SetItem( ll_Row, 'items_sorts2', ai_itemno2  )
ids_Store.SetItem( ll_Row, 'items_sorts3', ai_itemno3  )

ids_Store.SetItem( ll_Row, 'splitbar', 1  )

ids_Store.SetItem( ll_Row, 'groupblank', 0 )	
ids_Store.SetItem( ll_Row, 'menuindex', ai_index )	
ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  1 )

Return 1
end function

public function integer of_addgroupblank (integer ai_groupno, integer ai_itemno, integer ai_row);Long			ll_Find	, ll_row


If ai_Row > 0 Then
	ll_Row = ids_Store.Insertrow(ai_Row )
Else
	ll_Row = ids_Store.Insertrow( 0  )
End If


ids_Store.SetItem( ll_Row, 'groupno', ai_groupno  )

ids_Store.SetItem( ll_Row, 'items_sorts', ai_itemno  )

ids_Store.SetItem( ll_Row, 'groupblank', 1 )	

ids_Store.SetItem( ll_Row, 'menuindex', 1 )	
ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  1 )
Return ll_Row
end function

public function integer of_additem (integer ai_groupno, integer ai_itemno, decimal ai_itemno2, decimal ai_itemno3, string as_item, string as_pic, string as_toolbarname, integer ai_index, integer ai_row);Long			ll_Find	, ll_row


If Len( as_toolbarname ) > 1 Then
	ll_Find = ids_Store.Find( "toolbarname='" + as_toolbarname + "'", 1, rowcount() )
	
	If ll_Find > 0 Then
		Return 1
		//pause 	
	End If
End If


If ai_Row > 0 Then
	ll_Row = ids_Store.Insertrow( ai_Row )
Else
	ll_Row = ids_Store.Insertrow( 0 )
End If

//If  as_toolbarname =  "m_newctx" Or as_toolbarname = 'm_copyctx' or as_toolbarname = 'm_usetemplate' Then
//	as_item = as_item + "  ▲"
//End If

ids_Store.SetItem( ll_Row, 'items', as_item  )

ids_Store.SetItem( ll_Row, 'groupno', ai_groupno  )

ids_Store.SetItem( ll_Row, 'items_sorts', ai_itemno  )
ids_Store.SetItem( ll_Row, 'items_sorts2', ai_itemno2  )
ids_Store.SetItem( ll_Row, 'items_sorts3', ai_itemno3  )

ids_Store.SetItem( ll_Row, 'pic', as_pic  )

ids_Store.SetItem( ll_Row, 'groupblank', 0 )	


ids_Store.SetItem( ll_Row, 'toolbarname', as_toolbarname )

ids_Store.SetItem( ll_Row, 'menuindex', ai_index )
//ids_Store.SetItem( ll_Row, 'itempic', 'listbarrow.jpg'  )
ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  1 )
Return  ll_Row


end function

public function string of_getstring (string as_source, string as_char);int							li_pos

If as_char  = 'last' Then
	li_pos =  Pos( as_source, ',' )
	If li_pos > 0 Then
		as_source = Mid( as_source, li_pos + 1 )
	End If
elseIf as_char  = 'tips' Then
	li_pos =  Pos( as_source, ',' )
	If li_pos > 0 Then
		as_source = Mid( as_source, li_pos  )
	else 
		as_source = ""
	End If	
Else
	li_pos =  Pos( as_source, ',' )
	If li_pos > 0 Then
		as_source = Left( as_source, li_pos - 1 )
	End If
	
End If




return as_source
end function

public function integer of_copyezmenuto (datawindow adw_target);Integer					li_i, li_Count, li_Row
String						ls_name, ls_Tip, ls_Parent, ls_newitem, ls_newtips, ls_pic, ls_pic_file
String						ls_toolbarvalue

li_Count = This.RowCount( )

For li_i = 1 To li_Count
	
	ls_name = trim( This.getItemstring( li_i,'toolbarname' ))
	If IsNull( ls_Name) Or Len( ls_name ) = 0 Then  Continue
	
	ls_Parent = trim( This.getItemstring( li_i,'parentmenu' ))
	li_Row = adw_target.InsertRow( 0 )	
	adw_target.object.items[li_Row] = This.object.originalText[li_i]
	adw_target.object.newitems[li_Row] = This.object.items[li_i]
	adw_target.object.parentmenu[li_Row] = ls_Parent
	adw_target.object.toolbarname[li_Row] = ls_name
	adw_target.object.itemtip[li_Row] = This.object.itemtip[li_i]
	adw_target.object.newitemtip[li_Row] = This.object.itemtip[li_i]
	adw_target.object.menuico[li_Row] = This.object.originalpic[li_i]
	adw_target.object.newmenuico[li_Row] = This.object.pic[li_i]
	
	adw_target.object.toolbarico[li_Row] = This.object.originalpic[li_i]
	adw_target.object.toolbaritem[li_Row] = of_getstring( string(This.object.originalText[li_i]) , '' )
	adw_target.object.toolbartip[li_Row] = of_getstring( string(This.object.originalText[li_i]) , 'last' )
	
	ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_ICON' , FALSE )
	ls_pic_file = ls_pic
	If IsNumber( ls_pic ) Then 
		If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
			if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
		End If
	End If
	If Not ( IsNull( ls_pic_file ) Or Trim( ls_pic_file )= '' ) Then
		adw_target.object.newmenuico[li_Row] = ls_pic_file
	End If
	ls_newitem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TEXT' , FALSE )
	If Not ( IsNull( ls_newitem ) Or Trim( ls_newitem )= '' ) Then
		adw_target.object.newitems[li_Row] =  ls_newitem
	End If
	ls_newtips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TIP' , FALSE )
	If Not ( IsNull( ls_newtips ) Or Trim( ls_newtips )= '' ) Then
		adw_target.object.newitemtip[li_Row] =  ls_newtips
	End If
	
	ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARICON' , FALSE )
	ls_pic_file = ls_pic
	If IsNumber( ls_pic ) Then
		If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
			if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
		End If
	End If
	If Not ( IsNull( ls_pic_file ) Or Trim( ls_pic_file )= '' ) Then
		adw_target.object.toolbarico[li_Row] = ls_pic_file
	End If
	
	ls_toolbarvalue = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARITEMTEXT' , FALSE )
	If Not( isnull( ls_toolbarvalue ) Or trim( ls_toolbarvalue ) = '' ) Then
		 adw_target.object.toolbaritem[li_Row] = ls_toolbarvalue
	End If	
	
	ls_toolbarvalue = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_Parent + '_' + ls_name + '_TOOLBARITEMTIP' , FALSE )
	If Not( isnull( ls_toolbarvalue ) Or trim( ls_toolbarvalue ) = '' ) Then
		adw_target.object.toolbartip[li_Row] = ls_toolbarvalue
	End If	
	
	
	adw_target.SetItemStatus( li_Row, 0, primary!, notModified! )
Next	
	
	
	
	
	
	


Return 1
end function

public subroutine of_setenabled (string as_parentmenuname, string as_menuname, boolean ab_enabled);Integer					li_Find, li_i

If ib_Dock_Prevent Then Return

If as_ParentMenuname = '' Or isnull( as_ParentMenuname ) Then
	li_Find = This.Find( "toolbarname='" + as_menuname + "'", 1, This.RowCount() )
Else
	li_Find = This.Find( "toolbarname='" + as_menuname + "' and parentmenu='" + as_ParentMenuname + "'", 1, This.RowCount() )
End If
If li_Find > 0 Then
	If ab_enabled Then
		This.SetItem( li_Find, 'enabled', 1 )
	Else
		This.SetItem( li_Find, 'enabled', 0 )
	End If
Else
	For li_i = 1 To This.FilteredCount( )
		if this.object.toolbarname.filter[li_i] =  as_menuname Then
			If ab_enabled Then
				this.object.enabled.filter[li_i] = 1
			Else
				this.object.enabled.filter[li_i] = 0
			End If
			exit
		End If
	Next
	
End If
end subroutine

public subroutine of_refreshenabled (menu ab_menu);//
Integer				li_i
Menu					lm_Temp

For li_i = 1 To Upperbound( ab_Menu.Item )
	If ab_Menu.Item[li_i].Visible And ab_Menu.Item[li_i].ToolbarItemvisible And Len( ab_Menu.Item[li_i].ToolbarItemName ) > 0 Then
		of_SetEnabled( '', ab_Menu.Item[li_i].classname( ), ab_Menu.Item[li_i].enabled )
	End If
	If UpperBound( ab_Menu.Item[li_i].Item ) > 0 Then
		of_RefreshEnabled(  ab_Menu.Item[li_i] )
	End If
Next
end subroutine

public subroutine of_set_menu_quick (menu am_menu);//
Menu				lm_list
Long				ll_i, ll_k, ll_a, ll_b, ll_o, ll_c, ll_LastOrder, ll_PriorOrder, ll_ShiftToRight
Long				ll_Order, ll_Order2, ll_MenuIndex, ll_Row, ll_MaxOrder1, ll_MaxOrder2
Long				ll_Count, ll_GroupMinNum,ll_Find,ll_LastRow, ll_Find2
Long				ll_VScrollLocate
String				ls_ItemText1, ls_ItemText2, ls_ClassName1, ls_ClassName2, ls_ClassName3
String				ls_ParentMenu, ls_MenuTips, ls_NewItem, ls_NewTip
String				ls_ShowMainToolBar, ls_originalText, ls_pic, ls_pic_file, ls_originalpic
Boolean			lb_Cascade,lb_Cascade2, lb_LastCascade, lb_calendar
//---------Begin Added by (Appeon)Harry 04.28.2014 for V142 ISG-CLX--------
Long				ll_d, ll_Order3, ll_MaxOrder3
String				ls_ItemText3, ls_ClassName4
Boolean			lb_Cascade3
//---------End Added ------------------------------------------------------

lm_List = am_Menu

//messagebox("set quick menu", string(am_menu))
gl_maha_test++
if AppeonGetClientType() = 'PB' then
	This.SetRedraw( false )
	This.ShareDataoff(   )
End If
//This.SetSort( "" )
ids_Store.Reset( )
ll_k =9//group 

For ll_i = 1 To Upperbound( lm_List.item )//1
	ll_MenuIndex   = lm_List.Item[ll_i].toolbaritembarindex
	ls_ClassName1 =  lm_List.Item[ll_i].classname( )
	If   Len( lm_List.Item[ll_i].toolbaritemname ) > 0  and 	Lower(lm_List.Item[ll_i].toolbaritemname ) <> "notfound!" Then
		ls_originalText =  lm_List.Item[ll_i].ToolbarItemText
		ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName1 + '_TEXT' , FALSE )
		ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName1 + '_TIP' , FALSE )
		If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
			ls_MenuTips = of_GetString( ls_originalText, 'last' )
		End If
		If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
			ls_ItemText1 = of_GetString( ls_originalText, '' )
		Else
			ls_ItemText1 = ls_NewItem
		End If	
		ls_pic_file = lm_List.Item[ll_i].toolbaritemname
		ls_originalpic = ls_pic_file
		ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName1 + '_ICON' , FALSE )
		If IsNumber( ls_pic ) Then
			If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
				if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
			End If
		ElseIf Len( ls_pic ) > 0 Then
			ls_pic_file = ls_pic
		End If
		
		//************************//
		If ib_CustomizeToolbarAttr Then of_SetToolbarAttr( ls_ClassName1, ls_ClassName1,  lm_List.Item[ll_i] )
		
		ll_b ++//sequence.
		ll_Order = lm_List.Item[ll_i].toolbaritemorder
		
		ll_k = of_GetGroup(  ls_ClassName1, 0 )
		ll_Row = This.of_Additem( ll_k,ll_b , ll_Order,100, ls_ItemText1 ,   ls_pic_file , ls_ClassName1, ll_MenuIndex )
		of_SetOriginalvalue( lm_List.classname( ),ls_ClassName1, ls_originalText, ls_originalpic )//ori
		ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
		ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )
		ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
		ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
		ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
		If  lm_List.Item[ll_i].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
		If Not lm_List.Item[ll_i].toolbaritemvisible Then
			ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
		End If
		If Not lm_List.Item[ll_i].enabled Then
			ids_Store.SetItem( ll_Row, 'enabled',  0 )
		Else
			ids_Store.SetItem( ll_Row, 'enabled',  1 )
		End If
	
		
	End If
	If  lm_List.Item[ll_i].typeof( ) = menucascade! Then//
		ll_Order = lm_List.Item[ll_i].toolbaritemorder
		If ll_order = 0 Then  
			ll_order = ll_b
		End If
		lb_Cascade = True
	Else
		lb_Cascade = False
		
	End If//
	ll_MaxOrder1 = 0
	For ll_a = 1 To Upperbound( lm_list.item[ll_i].item )//2
		ll_MenuIndex   = lm_List.Item[ll_i].item[ll_a].toolbaritembarindex
		ls_ClassName2 =  lm_List.Item[ll_i].item[ll_a].classname( )
		If ( ls_ClassName2 = 'm_output' and ls_ClassName1 = 'm_reports' )  then continue
		If    Len( lm_List.Item[ll_i].item[ll_a].toolbaritemname ) > 0  and &
					Lower(lm_List.Item[ll_i].item[ll_a].toolbaritemname ) <> "notfound!" Then
			ls_originalText =  lm_List.Item[ll_i].item[ll_a].ToolbarItemText
			
			ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName2 + '_TEXT' , FALSE )
			ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName2 + '_TIP' , FALSE )
			If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
				ls_MenuTips = of_GetString( ls_originalText, 'last' )
			End If
			If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
				ls_ItemText1 = of_GetString( ls_originalText, '' )
			Else
				ls_ItemText1 = ls_NewItem
			End If	
			ls_pic_file = lm_List.Item[ll_i].item[ll_a].toolbaritemname
			ls_originalpic = ls_pic_file
			ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName1 + '_' + ls_ClassName2 + '_ICON' , FALSE )
			If IsNumber( ls_pic ) Then
				If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
					if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
				End If
			ElseIf Len( ls_pic ) > 0 Then
				ls_pic_file = ls_pic
			End If
			of_SetOriginalvalue( ls_ClassName1, ls_ClassName2, ls_originalText, ls_originalpic )//ori
						
			ll_PriorOrder = lm_List.Item[ll_i].item[ll_a].toolbaritemorder
			
			ll_k = of_GetGroup(  ls_ClassName2, 0 )
			If lb_Cascade Then
				If  lm_List.Item[ll_i].toolbaritemvisible Then
					ll_b ++
					If ll_PriorOrder = 0 Then ll_PriorOrder = ll_a
					If ll_MaxOrder1 < ll_PriorOrder Then ll_MaxOrder1 = ll_PriorOrder 
					ll_Row = This.of_Additem( ll_k, ll_b, ll_Order , ll_PriorOrder, ls_ItemText1 , ls_pic_file,ls_ClassName2 , ll_MenuIndex )
					ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
					ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )
					ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
					ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
					ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
					If  lm_List.Item[ll_i].item[ll_a].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
					If Not lm_List.Item[ll_i].item[ll_a].toolbaritemvisible   Then
						ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
					End If
					If Not lm_List.Item[ll_i].item[ll_a].enabled Or Not lm_List.Item[ll_i].enabled Then 
						ids_Store.SetItem( ll_Row, 'enabled',  0 )
					Else
						ids_Store.SetItem( ll_Row, 'enabled',  1 )
					End If	
				End If
			Else
				ll_b ++
				ll_Row = This.of_Additem( ll_k, ll_b, ll_PriorOrder ,100, ls_ItemText1 ,  ls_pic_file , ls_ClassName2, ll_MenuIndex )
				If lm_List.Item[ll_i].item[ll_a].ShiftToRight Then  ids_Store.SetItem( ll_Row, 'items_child_sorts', ll_a )
				ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
				ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )	
				ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
				ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName1 )
				ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
				If  lm_List.Item[ll_i].item[ll_a].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
				If Not lm_List.Item[ll_i].item[ll_a].toolbaritemvisible   Then
					ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
				End If
				If Not lm_List.Item[ll_i].item[ll_a].enabled Then
					ids_Store.SetItem( ll_Row, 'enabled',  0 )
				Else
					ids_Store.SetItem( ll_Row, 'enabled',  1 )
				End If	
			End If
			
			//************************//
			If ib_CustomizeToolbarAttr Then of_SetToolbarAttr( ls_ClassName1, ls_ClassName2,  lm_List.Item[ll_i].item[ll_a] )
		End If
	
		If  lm_List.Item[ll_i].item[ll_a].typeof( ) = menucascade! Then//
			ll_Order2 = lm_List.Item[ll_i].item[ll_a].toolbaritemorder
			If ll_order2 = 0 Then 
				ll_order2 = ll_b
			End If
			lb_Cascade2 = True
		Else
			lb_Cascade2 = False
		End If//
		ll_MaxOrder2 = 0		
		For ll_o = 1 To Upperbound( lm_list.item[ll_i].item[ll_a].item )//3
			ll_MenuIndex   = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritembarindex
			ls_ClassName3 =  lm_List.Item[ll_i].item[ll_a].item[ll_o].classname( )
			If ( ls_ClassName3 = 'm_merge0' And ls_ClassName2 = 'm_merge' ) Or ( ls_ClassName3 = 'm_output1' and ls_ClassName2 = 'm_output0' ) Or &
				 ( ls_ClassName3 = 'm_options0' And ls_ClassName2 = 'm_options' )	 Then Continue
			If  len(  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemname ) > 0 Then
				ls_originalText = lm_List.Item[ll_i].item[ll_a].item[ll_o].ToolbarItemText
				
				ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName2 + '_' + ls_ClassName3 + '_TEXT' , FALSE )
				ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName2 + '_' + ls_ClassName3 + '_TIP' , FALSE )
				If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
					ls_MenuTips = of_GetString( ls_originalText, 'last' )
				End If
				If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
					ls_ItemText2 = of_GetString( ls_originalText, '' )
				Else
					ls_ItemText2 = ls_NewItem
				End If		
				ls_pic_file = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemname
				ls_originalpic = ls_pic_file
				ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName2 + '_' + ls_ClassName3 + '_ICON' , FALSE )
				If IsNumber( ls_pic ) Then
					If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
						if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
					End If
				ElseIf Len( ls_pic ) > 0 Then
					ls_pic_file = ls_pic
				End If
				of_SetOriginalvalue( ls_ClassName2, ls_ClassName3, ls_originalText, ls_originalpic )//ori
															
				ll_LastOrder = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemorder
				
				ll_k = of_GetGroup(  ls_ClassName3, 0 )
				If lb_Cascade2 Then
					If  lm_List.Item[ll_i].item[ll_a].toolbaritemvisible Then
						ll_b ++
						If ll_LastOrder = 0 Then ll_LastOrder = ll_o
						If ll_MaxOrder2 < ll_LastOrder Then ll_MaxOrder2 = ll_LastOrder 
						ll_Row = This.of_Additem( ll_k, ll_b, ll_Order2, ll_LastOrder, ls_ItemText2 , ls_pic_file ,ls_ClassName3 , ll_MenuIndex )
						ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
						ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )	
						ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
						ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName2 )
						ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
						If  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
						If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemvisible  Then
							ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
						End If
						If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].enabled Or Not lm_List.Item[ll_i].item[ll_a].enabled  Then 
							ids_Store.SetItem( ll_Row, 'enabled',  0 )
						Else
							ids_Store.SetItem( ll_Row, 'enabled',  1 )
						End If	
					End If
				Else
					ll_b ++
					ll_Row = This.of_Additem( ll_k, ll_b, ll_LastOrder,100, ls_ItemText2 ,  ls_pic_file , ls_ClassName3, ll_MenuIndex )
					ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
					ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )	
					ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
					ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName2 )
					ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
					If  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
					If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemvisible  Then
						ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
					End If
					If Not  lm_List.Item[ll_i].item[ll_a].item[ll_o].enabled Then
						ids_Store.SetItem( ll_Row, 'enabled',  0 )
					Else
						ids_Store.SetItem( ll_Row, 'enabled',  1 )
					End If	
				End If
				//************************//
				If ib_CustomizeToolbarAttr Then 	of_SetToolbarAttr( ls_ClassName2, ls_ClassName3,  lm_List.Item[ll_i].item[ll_a].item[ll_o] )
				//---------Begin Added by (Appeon)Harry 04.28.2014 for V142 ISG-CLX--------
				If  lm_List.Item[ll_i].item[ll_a].item[ll_o].typeof( ) = menucascade! Then
					ll_Order3 = lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemorder
					If ll_order3 = 0 Then 
						ll_order3 = ll_b
					End If
					lb_Cascade3 = True
				Else
					lb_Cascade3 = False
				End If
				//---------End Added ------------------------------------------------------
			End If
			//---------Begin Added by (Appeon)Harry 04.28.2014 for V142 ISG-CLX--------
			ll_MaxOrder3 = 0
			For ll_d = 1 To Upperbound( lm_list.item[ll_i].item[ll_a].item[ll_o].item )//4
				ll_MenuIndex   = lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritembarindex
				ls_ClassName4 =  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].classname( )
				If  len(  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemname ) > 0 Then
					ls_originalText = lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].ToolbarItemText
				
					ls_NewItem = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName3 + '_' + ls_ClassName4 + '_TEXT' , FALSE )
					ls_MenuTips = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName3 + '_' + ls_ClassName4 + '_TIP' , FALSE )
					If Len( ls_MenuTips ) = 0 Or isNull( ls_MenuTips ) Then
						ls_MenuTips = of_GetString( ls_originalText, 'last' )
					End If
					If Len( ls_NewItem ) = 0 Or isNull( ls_NewItem ) Then
						ls_ItemText3 = of_GetString( ls_originalText, '' )
					Else
						ls_ItemText3 = ls_NewItem
					End If	
					ls_pic_file = lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemname
					ls_originalpic = ls_pic_file
					ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + ls_ClassName3 + '_' + ls_ClassName4 + '_ICON' , FALSE )
					If IsNumber( ls_pic ) Then
						If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
							if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
						End If
					ElseIf Len( ls_pic ) > 0 Then
						ls_pic_file = ls_pic
					End If
					of_SetOriginalvalue( ls_ClassName3, ls_ClassName4, ls_originalText, ls_originalpic )//ori
															
					ll_LastOrder = lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemorder
					
					ll_k = of_GetGroup(  ls_ClassName4, 0 )
					If lb_Cascade3 Then
						If  lm_List.Item[ll_i].item[ll_a].item[ll_o].toolbaritemvisible Then
							ll_b ++
							If ll_LastOrder = 0 Then ll_LastOrder = ll_o
							If ll_MaxOrder3 < ll_LastOrder Then ll_MaxOrder3 = ll_LastOrder 
							ll_Row = This.of_Additem( ll_k, ll_b, ll_Order3, ll_LastOrder, ls_ItemText3 , ls_pic_file ,ls_ClassName4 , ll_MenuIndex )
							ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
							ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )	
							ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
							ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName3 )
							ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
							If  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
							If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemvisible  Then
								ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
							End If
							If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].enabled Or Not lm_List.Item[ll_i].item[ll_a].item[ll_o].enabled  Then 
								ids_Store.SetItem( ll_Row, 'enabled',  0 )
							Else
								ids_Store.SetItem( ll_Row, 'enabled',  1 )
							End If	
						End If
					Else
						ll_b ++
						ll_Row = This.of_Additem( ll_k, ll_b, ll_LastOrder,100, ls_ItemText3 ,  ls_pic_file , ls_ClassName4, ll_MenuIndex )
						ids_Store.SetItem( ll_Row, 'originaltext', ls_originalText )
						ids_Store.SetItem( ll_Row, 'originalpic', ls_originalpic )	
						ids_Store.SetItem( ll_Row, 'picnumber1', ls_pic )
						ids_Store.SetItem( ll_Row, 'parentmenu', ls_ClassName3 )
						ids_Store.SetItem( ll_Row, 'itemtip', ls_MenuTips )
						If  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemdown Then ids_Store.SetItem( ll_Row, 'toolbaritemdown', 1 )
						If Not lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].toolbaritemvisible  Then
							ids_Store.SetItem( ll_Row, 'toolbaritemvisible',  0 )
						End If
						If Not  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d].enabled Then
							ids_Store.SetItem( ll_Row, 'enabled',  0 )
						Else
							ids_Store.SetItem( ll_Row, 'enabled',  1 )
						End If	
					End If
					//************************//
					If ib_CustomizeToolbarAttr Then 	of_SetToolbarAttr( ls_ClassName3, ls_ClassName4,  lm_List.Item[ll_i].item[ll_a].item[ll_o].item[ll_d] )
				End If
				
			Next //4
			//---------End Added ------------------------------------------------------
		Next//3
		
	Next//2
	//
Next//1

//filter visible = 1
ids_Store.SetFilter( "toolbaritemvisible=1" )
ids_Store.Filter( )

ll_Count = ids_Store.RowCount( )

ll_Find = ids_Store.Find( "menuindex>1", 1, ids_store.Rowcount( ) )//have multi-menu
If ll_Find = 0 Then
	ll_Find = ids_Store.Find( "groupno < 9 and len( toolbarname)>0", 1, ids_store.Rowcount( ) )
	If ll_Find> 0 Then
		ll_GroupMinNum = ids_Store.object.items_sorts2[ll_Find] 
	End If
	
	//grouping
	For ll_i = 1 To ll_Count
		If ll_Find > 0 and 	ids_Store.object.groupno[ll_i] =9  And  ids_Store.object.splitbar[ll_i] = 0  Then
			ids_Store.object.groupno[ll_i] = of_GetGroup(  ids_Store.object.toolbarname[ll_i], ll_GroupMinNum ) 
		End If
	Next
Else
	ll_Find = ids_Store.Find( "toolbarname = 'm_close'", 1, ids_store.Rowcount( ) )
	If ll_Find> 0 Then
		ids_Store.object.groupno[ll_Find] = 1
	End If
End If

ids_Store.Sort( )
//----------------------------------------------------//copy to main  , it is  used for comparing .
If Lower(am_Menu.ClassName( )) = "m_pfe_cst_mdi_menu" Then
	If isvalid( w_mdi.GetActiveSheet( )  ) then 
		if w_mdi.GetActiveSheet( ).Classname( ) = 'w_calendarview'  then lb_calendar = true
	End if
	if not lb_calendar then 
		ids_Main.Reset( )
		ids_Store.RowsCopy(1, ids_Store.RowCount( ), primary!, ids_Main, 1, Primary! )
		ll_Row = ids_Main.insertRow( 0 )
		ids_Main.SetItem( ll_Row, 'toolbarname' , 'm_actionitems' )
		ids_Main.SetItem( ll_Row, 'parentmenu' , 'm_file' )
		ids_Main.SetItem( ll_Row, 'items_sorts2' ,  9 )
	End If
End If
//----------------------------------------------------//

//Add splitbar
lb_Cascade = False
lb_LastCascade =False
If ll_Count > 0 Then ll_order = ids_Store.object.groupno[1]

For ll_i = 1 To ll_Count
	If ids_Store.object.items_sorts3[ll_i] <> 100  And Not lb_Cascade Then
		ls_ParentMenu = ids_Store.object.parentmenu[ll_i]
		lb_Cascade = True
		If ll_i > 1 Then
			If  ids_Store.object.splitbar[ll_i - 1] = 0 Then
				ll_Count++
				This.of_AddSplitBar( ids_Store.object.groupno[ll_i],  ids_Store.object.items_sorts[ll_i], ids_Store.object.items_sorts2[ll_i] , 0 , ids_Store.object.MenuIndex[ll_i], ll_i )
				Continue
			End If
		End If
	End If

	If lb_CasCade And ls_ParentMenu <>  string(ids_Store.object.parentmenu[ll_i]) And ll_i < ll_Count Then
		lb_Cascade = False
		ll_Count++
		This.of_AddSplitBar( ids_Store.object.groupno[ll_i - 1],  ids_Store.object.items_sorts[ll_i - 1], ids_Store.object.items_sorts2[ll_i - 1] , ids_Store.object.items_sorts3[ll_i - 1] + 1 , ids_Store.object.MenuIndex[ll_i - 1], ll_i )
	End If
	
Next

ll_Find = ids_Store.Find( "groupno < 9", 1, ids_store.Rowcount( ) )
If ll_Find > 0 Then
	ll_Find = ids_Store.Find( "groupno = 9", 1, ids_store.Rowcount( ) )
	If ll_Find > 0 Then
		ll_Find = this.of_addgroupblank( 2, ids_Store.object.items_sorts[ll_Find], ll_Find )
		This.of_Additem( 1,999999, 999999,9999, '' ,  '' , '', 3, ll_Find  ) 
	End If
End If

//blank row
This.of_Additem( 9,999999, 999999,9999, '' ,  '' , '', 1 ) 

ls_ShowMainToolBar = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_SHOWMAINTOOLBAR' )
If isnull(ls_ShowMainToolBar) Then ls_ShowMainToolBar = ''
If trim(ls_ShowMainToolBar) = '' Or ls_ShowMainToolBar = '1' Then
	ll_Find = ids_Store.Find( "groupno = 2", 1, ids_store.Rowcount( ) )
	If ll_Find > 0 Then ids_Store.RowsMove( ll_Find, ids_Store.RowCount( ), primary!, ids_Store, 1, delete! )
End If


of_AdjustWidth( )

ids_Store.ShareData( This )

If il_VScrollPosition > 0 Then  This.Modify ( "datawindow.VerticalScrollPosition=" + string( il_VScrollPosition ) )

If Lm_List.ClassName( ) <> is_LastMenuName Or IsNull(  Lm_List.ClassName( ) ) Then
	is_LastMenuName =  Lm_List.ClassName( )
//	ids_original.Reset( )
End If
if AppeonGetClientType() = 'PB' then
	This.SetRedraw( True )
End If


end subroutine

public subroutine of_setvisible (string as_parentmenu, string as_menu, boolean ab_value);//
Integer					li_Find, li_i


If ib_Dock_Prevent Then Return

If ab_value Then
	If as_parentmenu = '' Or isnull( as_parentmenu ) Then
		If This.Find( "toolbarname='" + as_menu + "'", 1, This.RowCount() ) > 0 Then Return
		For li_i = 1 To This.FilteredCount( )
			if this.object.toolbarname.filter[li_i] =  as_menu Then
				this.object.toolbaritemvisible.filter[li_i] = 1
				exit
			End If
		Next
	Else
		For li_i = 1 To This.FilteredCount( )
			if this.object.toolbarname.filter[li_i] =  as_menu   and this.object.parentmenu.filter[li_i] = as_parentmenu Then
				this.object.toolbaritemvisible.filter[li_i] = 1
				exit
			End If
		Next
	End If
Else
	If as_parentmenu = '' Or isnull( as_parentmenu ) Then
		li_Find = This.Find( "toolbarname='" + as_menu + "'", 1, This.RowCount() )
	Else
		li_Find = This.Find( "toolbarname='" + as_menu + "' and parentmenu='" + as_parentmenu + "'", 1, This.RowCount() )
	End If
	If li_Find > 0 Then
		This.SetItem( li_Find, 'toolbaritemvisible', 0 )
	End If
End If
This.SetRedraw( False )
This.SetFilter( "toolbaritemvisible=1" )
This.Filter( )
This.SetRedraw( True )

end subroutine

public subroutine of_setchecked (string as_parentmenu, string as_menu, boolean ab_value);//
Integer					li_Find, li_i


If ib_Dock_Prevent Then Return

If as_parentmenu = '' Or isnull( as_parentmenu ) Then
	li_Find = This.Find( "toolbarname='" + as_menu + "'", 1, This.RowCount() )
Else
	li_Find = This.Find( "toolbarname='" + as_menu + "' and parentmenu='" + as_parentmenu + "'", 1, This.RowCount() )
End If
If li_Find > 0 Then
	If ab_value Then
		This.SetItem( li_Find, 'toolbaritemdown', 1 )
	Else
		This.SetItem( li_Find, 'toolbaritemdown', 0 )
	End If
Else
	For li_i = 1 To This.FilteredCount( )
		if this.object.toolbarname.filter[li_i] =  as_menu Then
			If ab_value Then
				this.object.toolbaritemdown.filter[li_i] = 1
			Else
				this.object.toolbaritemdown.filter[li_i] = 0
			End If
			exit
		End If
	Next
	
End If
end subroutine

public subroutine of_settext (string as_parentmenu, string as_menu, string as_text);//
Integer					li_Find, li_i
String						ls_Tip


If ib_Dock_Prevent Then Return

If as_parentmenu = '' Or isnull( as_parentmenu ) Then
	li_Find = This.Find( "toolbarname='" + as_menu + "'", 1, This.RowCount() )
Else
	li_Find = This.Find( "toolbarname='" + as_menu + "' and parentmenu='" + as_parentmenu + "'", 1, This.RowCount() )
End If

If li_Find > 0 Then
	
	This.SetItem( li_Find, 'items', of_GetString( as_Text, '' ) )
	ls_Tip = of_GetString( as_Text, 'last' )
	
	if ls_Tip <> as_Text Then
		This.SetItem( li_Find, 'itemtip', ls_Tip )
	End If
Else
	For li_i = 1 To This.FilteredCount( )
		if this.object.toolbarname.filter[li_i] =  as_menu Then
			this.object.items.filter[li_i] =  of_GetString( as_Text, '' )
			exit
		End If
	Next
End If
end subroutine

public subroutine of_setitemname (string as_parentmenu, string as_menu, string as_name);//
Integer					li_Find


If as_parentmenu = '' Or isnull( as_parentmenu ) Then
	li_Find = This.Find( "toolbarname='" + as_menu + "'", 1, This.RowCount() )
Else
	li_Find = This.Find( "toolbarname='" + as_menu + "' and parentmenu='" + as_parentmenu + "'", 1, This.RowCount() )
End If
If li_Find > 0 Then
	This.SetItem( li_Find, 'pic', as_name )
End If
end subroutine

public subroutine of_set_screen ();string			ls_Value, ls_Modify
integer		li_i, li_k, li_o
Menu			lm_Menu


ls_Modify = ''

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'backgroundcolor' )
If Len( ls_Value ) > 0 Then  ls_Modify = "datawindow.color=" + ls_value
	
ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headfontname' )
If Len( ls_Value ) > 0 Then ls_Modify += " t_Title.font.face='" + ls_value + "'"// t_painter.font.face='" + ls_value + "' t_refresh.font.face='" + ls_value + "'"

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headfontsize' )
If Len( ls_Value ) > 0 Then ls_Modify += " t_Title.font.Height=-" + ls_value  //+ " t_painter.font.Height=-" + ls_value + " t_refresh.font.Height=-" + ls_value
If long( ls_value ) > 12 Then 
	ls_Modify += " t_Title.Height= " + String((long( ls_value) - 9 ) * 10 + 64  ) + " p_titlebar.height="+ String((long( ls_value) - 9 ) * 10 + 64  )
Else
	ls_Modify += " t_Title.Height= " + String(68 ) + " p_titlebar.height="+ String(88 )
End If
	
ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headfontcolor' )
If Len( ls_Value ) > 0 Then ls_Modify += " t_Title.color=" + ls_value + " t_painter.color=" + ls_value + " t_refresh.color=" + ls_value + " t_contract.color=" + ls_value + " t_expand.color=" + ls_value

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headbackcolor' )
If Len( ls_Value ) > 0 Then  ls_Modify += " p_titlebar.background.color=" + ls_value + " t_dock.background.color=" + ls_value

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headfontbold' )
If Len( ls_Value ) > 0 Then
	If ls_value = '0' Or ls_value = '' Then 
		ls_value = '400'
	Else
		ls_value = '700'
	End If
	ls_Modify += " t_Title.font.Weight=" + ls_value + " t_painter.font.Weight	=" + ls_value + " t_refresh.font.Weight=" + ls_value
End If

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'headfontitalic' )
If Len( ls_Value ) > 0 Then  ls_Modify += " t_Title.font.Italic=" + ls_value + " t_painter.font.Italic=" + ls_value + " t_refresh.font.Italic=" + ls_value

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowfontname' )
If Len( ls_Value ) > 0 Then ls_Modify += " items.font.face='" + ls_value + "'"

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowfontsize' )
If Len( ls_Value ) > 0 Then  ls_Modify += " items.font.height=-" + ls_value

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowfontcolor' )
If Len( ls_Value ) > 0 Then  ls_Modify += " items.color='" + ls_value + "~tif( enabled = 0, 8421504,if( getrow( ) = currentrow(), 13018996 , "+ls_value +") )'"

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowbackcolor' )
If Len( ls_Value ) > 0 Then  ls_Modify += " itempic.background.color=" + ls_value

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowfontbold' )
If Len( ls_Value ) > 0 Then
	If ls_value = '0' Or ls_value = '' Then 
		ls_value = '400'
	Else
		ls_value = '700'
	End If
	ls_Modify += " items.font.weight=" + ls_value
End If

ls_Value = gnv_user_option.of_Get_Option_value( is_User, 'EZMENU_' + 'rowfontitalic' )
If Len( ls_Value ) > 0 Then  ls_Modify += " items.font.Italic=" + ls_value

ls_Value =gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'ezmenutitle' )
If Len( ls_Value ) > 0 Then  ls_Modify += " t_Title.text= '" + ls_value + "'"

ls_Value = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'showezmenuicon'  )
If Len( ls_Value ) > 0 Then 
	If ls_value = '1' Or isnull( ls_Value ) or Trim( ls_Value ) = '' Then
		ls_Modify += " pic.visible= " + ls_value + " t_checked.x=46"  
	Else
		ls_Modify += " pic.visible= " + ls_value + " t_checked.x=" + This.Describe( "pic.x" )
	End If
End If

If Len( ls_Modify ) > 0  Then
	This.Modify( ls_Modify )	
End If
//---------------------------------------------------//	
ib_CustomizeToolbarAttr = True
ls_Value = gnv_user_option.of_Get_Option_value( Is_User, 'EZMENU_' + 'showcustomizetoolbartexticontips'  )
If Len( ls_Value ) > 0 Then ib_CustomizeToolbarAttr = ( ls_Value = '1' )


	


	
end subroutine

public subroutine of_settoolbarattr (string as_parent, string as_name, menu am_menu);Menu		lm_Temp
string		ls_pic, ls_pic_file, ls_toolbarvalue, ls_OriginalText, ls_OriginalPic
Integer	li_find, li_Row
Boolean	lb_Find

If IsNull( as_parent ) Or Trim( as_parent ) = '' Then
	
	as_name = am_menu.ClassName( )
	as_parent = as_name 
	lm_Temp = am_menu.GetParent( )
	If IsValid( lm_Temp ) Then	as_parent = lm_Temp.ClassName( )	

End If

ls_OriginalPic = am_menu.toolbaritemname
ls_OriginalText = am_menu.toolbaritemtext

ls_pic = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + as_parent + '_' + as_name + '_TOOLBARICON' , FALSE )
ls_pic_file = ls_pic
If IsNumber( ls_pic ) Then 
	If inv_utils.of_download_picture( Long( ls_pic ), ls_pic_file) < 0 Then
		if AppeonGetClientType() = "PB" then ls_pic_file = is_ErrorPictrue
	End If
End If
If Not ( IsNull( ls_pic_file ) Or Trim( ls_pic_file )= '' )  and am_menu.toolbaritemvisible Then
	lb_Find = True
//	am_menu.toolbaritemname = ls_pic_file
End If

ls_toolbarvalue = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + as_parent + '_' + as_name + '_TOOLBARITEMTEXT' , FALSE )
If Not( isnull( ls_toolbarvalue ) Or trim( ls_toolbarvalue ) = '' )  and am_menu.toolbaritemvisible  Then
	lb_Find = True
	If ls_toolbarvalue <> am_menu.toolbaritemtext Then am_menu.toolbaritemtext = ls_toolbarvalue + of_Getstring( ls_OriginalText, 'tips' )
End If	

ls_toolbarvalue = gnv_user_option.of_get_viewid_option_value( 1001, 'EZMENU_' + as_parent + '_' + as_name + '_TOOLBARITEMTIP' , FALSE )
If Not( isnull( ls_toolbarvalue ) Or trim( ls_toolbarvalue ) = '' )  and am_menu.toolbaritemvisible Then
	If Trim(am_menu.toolbaritemtext) = Trim(ls_toolbarvalue) Then
	Else
		lb_Find = True
		am_menu.toolbaritemtext = of_getstring( am_menu.toolbaritemtext, '' ) + "," + ls_toolbarvalue
	End If
End If	
If lb_Find Then
	li_Find = ids_original.Find( "toolbarname='" + as_name + "' and parentmenu ='"+ as_parent + "'", 1, ids_original.RowCount( ) )
	If li_Find = 0 Then
		li_Row = ids_original.insertRow( 0 )
		ids_original.SetItem( li_Row, 'parentmenu', as_parent )
		ids_original.SetItem( li_Row, 'toolbarname', as_name )
		ids_original.SetItem( li_Row, 'originaltext', ls_OriginalText )
		ids_original.SetItem( li_Row, 'originalpic', ls_OriginalPic )
	End If
End If



end subroutine

public subroutine of_refresh_toolbar (menu am_menu);//
Menu			lm_Menu
Integer		li_i, li_o, li_k, li_j


If am_Menu.classname( ) = is_LastMenuName Then Return

lm_Menu = am_menu

If Not ib_CustomizeToolbarAttr Then Return

For li_i = 1 To Upperbound( lm_Menu.item )
	If   Len( lm_Menu.Item[li_i].toolbaritemname ) > 0  and 	Lower(lm_Menu.Item[li_i].toolbaritemname ) <> "notfound!" Then
//		of_SetOriginalvalue(  lm_Menu.Item[li_i].classname( ),  lm_Menu.Item[li_i].toolbaritemtext,  lm_Menu.Item[li_i].toolbaritemname )
		If ib_CustomizeToolbarAttr  Then This.of_settoolbarattr( "", "", lm_Menu.Item[li_i] )
	End If
	For li_k = 1 To  Upperbound( lm_Menu.item[li_i].item )
		If   Len( lm_Menu.Item[li_i].item[li_k].toolbaritemname ) > 0  and 	Lower(lm_Menu.Item[li_i].item[li_k].toolbaritemname ) <> "notfound!" Then
	//		of_SetOriginalvalue(  lm_Menu.Item[li_i].classname( ),  lm_Menu.Item[li_i].toolbaritemtext,  lm_Menu.Item[li_i].toolbaritemname )
			If ib_CustomizeToolbarAttr  Then This.of_settoolbarattr( "", "", lm_Menu.Item[li_i].item[li_k] )
		End If
		For li_o = 1 To  Upperbound( lm_Menu.item[li_i].item[li_k].item )
			If   Len( lm_Menu.Item[li_i].item[li_k].item[li_o].toolbaritemname ) > 0  and 	Lower(lm_Menu.Item[li_i].item[li_k].item[li_o].toolbaritemname ) <> "notfound!" Then
		//		of_SetOriginalvalue(  lm_Menu.Item[li_i].classname( ),  lm_Menu.Item[li_i].toolbaritemtext,  lm_Menu.Item[li_i].toolbaritemname )
				If ib_CustomizeToolbarAttr  Then This.of_settoolbarattr( "", "", lm_Menu.Item[li_i].item[li_k].item[li_o] )
			End If
			//---------Begin Added by (Appeon)Harry 04.28.2014 for V142 ISG-CLX--------
			For li_j = 1 To  Upperbound( lm_Menu.item[li_i].item[li_k].item[li_o].item )
				If   Len( lm_Menu.Item[li_i].item[li_k].item[li_o].item[li_j].toolbaritemname ) > 0  and 	Lower(lm_Menu.Item[li_i].item[li_k].item[li_o].item[li_j].toolbaritemname ) <> "notfound!" Then
			//		of_SetOriginalvalue(  lm_Menu.Item[li_i].classname( ),  lm_Menu.Item[li_i].toolbaritemtext,  lm_Menu.Item[li_i].toolbaritemname )
					If ib_CustomizeToolbarAttr  Then This.of_settoolbarattr( "", "", lm_Menu.Item[li_i].item[li_k].item[li_o].item[li_j] )
				End If
			Next
			//---------End Added ------------------------------------------------------
		Next		
	Next
//	If UpperBound( lm_Menu.Item[li_i].Item ) > 0 Then of_Refresh_toolbar(  lm_Menu.Item[li_i] )
Next



end subroutine

public subroutine of_restore_toolbar_attr (menu am_menu);//
Menu			lm_Menu
Integer		li_i, li_o, li_k, li_Find

lm_Menu = am_menu

For li_i = 1 To Upperbound( lm_Menu.item )
	If   Len( lm_Menu.Item[li_i].toolbaritemname ) > 0  and 	Lower(lm_Menu.Item[li_i].toolbaritemname ) <> "notfound!" Then
		li_Find = ids_original.Find( "toolbarname='" + lm_Menu.Item[li_i].classname() + "'", 1, ids_original.RowCount( ) )
		If li_Find > 0 Then
//			If ids_Original.GetItemString( li_Find, 'originalpic' ) <> lm_Menu.Item[li_i].toolbaritemname Then 
			If ids_Original.GetItemString( li_Find, 'originaltext' ) <> lm_Menu.Item[li_i].toolbaritemtext Then 
//				lm_Menu.Item[li_i].toolbaritemname = ids_Original.GetItemString( li_Find, 'originalpic' )
				lm_Menu.Item[li_i].toolbaritemtext = ids_Original.GetItemString( li_Find, 'originaltext' )
			End If			
		End If
	End If
	If UpperBound( lm_Menu.Item[li_i].Item ) > 0 Then of_restore_toolbar_attr(  lm_Menu.Item[li_i] )
Next


end subroutine

public subroutine of_show_child_menu (string as_name, integer ai_x, integer ai_y);m_search_screen_browse    lm_child 
Integer							li_i


lm_child = Create m_search_screen_browse

If IsValid( gw_contract ) Then
	If IsValid( gw_contract.tab_contract_details.tabpage_search   ) Then
		gw_contract.tab_contract_details.tabpage_search.is_Rightmenutype = as_name
		gw_contract.tab_contract_details.tabpage_search.dw_search_det1.Event Rbuttondown( 0, 0, 0, 	gw_contract.tab_contract_details.tabpage_search.dw_search_det1.object.datawindow  )
	End If
End If


//Choose Case as_name
//	Case 'm_newctx'
//		For li_i  = 1  To UpperBound( m_search_screen_browse.m_new.item )
//			m_search_screen_browse.m_new.item[li_i].visible = True 
//		Next
//		lm_child.m_new.Popmenu( pointerx( ),  long( this.describe( "datawindow.header.height" ) ) + pointery( ) )
//	case 'm_copyctx'
//		For li_i  = 1  To UpperBound( m_search_screen_browse.m_copy.item )
//			m_search_screen_browse.m_copy.item[li_i].visible = True 
//		Next
//		lm_child.m_copy.Popmenu( pointerx( ),  long( this.describe( "datawindow.header.height" ) ) + pointery( ) )
//	Case 'm_usetemplate'
//		m_menu_create_item_child  lm_template
//		
//		
//		For li_i  = 1  To UpperBound( m_search_screen_browse.m_usetemplate.item )
//			m_search_screen_browse.m_usetemplate.item[li_i].visible = True 
//		Next
//		lm_child.m_usetemplate.Popmenu( pointerx( ),  long( this.describe( "datawindow.header.height" ) ) + pointery( ) )
//End choose


end subroutine

public subroutine of_reset_original (menu am_menu);//If am_menu.ClassName( ) <> is_LastMenuName Or IsNull(  am_menu.ClassName( ) ) Then
//	is_LastMenuName =  am_menu.ClassName( )
//	ids_original.Reset( )
//End If
end subroutine

public subroutine of_setoriginalvalue (string as_parent, string as_toolbarname, ref string as_text, ref string as_pic);//
Integer			li_Find, li_Row

li_Find = ids_original.Find( "toolbarname='" + as_toolbarname + "' and parentmenu ='"+ as_parent + "'", 1, ids_original.RowCount( ) )
If li_Find = 0 Then
//	li_Row = ids_original.insertRow( 0 )
//	ids_original.SetItem( li_Row, 'toolbarname', as_toolbarname )
//	ids_original.SetItem( li_Row, 'originaltext', as_text )
//	ids_original.SetItem( li_Row, 'originalpic', as_pic )
ElseIf li_Find > 0 Then
	as_text = ids_original.GetItemString( li_Find, 'originaltext' )
	as_pic = ids_original.GetItemString( li_Find, 'originalpic' )
End If
end subroutine

public function string of_get_user ();return is_user
end function

on uo_listbar.create
call super::create
end on

on uo_listbar.destroy
call super::destroy
end on

event clicked;call super::clicked;
If dwo.Name = 't_contract' Then
	ib_Resize = True
	this.width = 120
	Modify( "t_expand.visible = 1 t_dock.visible=1 " )
	this.vscrollbar = false
	of_Resizemdi( )
	parent.dynamic of_Set_spitbar_visible(  false ) 
	ib_Dock_Prevent = True
	gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_DOCK_STATUS", '0' )
Elseif dwo.Name = 't_expand' Then
	ib_Dock_Prevent = False
	parent.dynamic event ue_refreshezmenu(   ) 
	ib_Resize = True
	this.vscrollbar = true
	Modify( "t_expand.visible = 0 t_dock.visible=0 " )
	this.width = ii_Width
	of_adjustWidth( )
	of_Resizemdi( )
	parent.dynamic of_Set_spitbar_visible(  True  ) 
	gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_DOCK_STATUS", '1' )
	
End If

If dwo.Name = 't_refresh' Then
	setpointer( HourGlass! )
	w_MDI.Event ue_RefreshEZMenu( ) //added by gavins 20130306
	setpointer( Arrow! )
End If

if dwo.name = 't_painter' then
	IF w_mdi.of_security_access( 6985 ) = 0 THEN
		Messagebox('EZ menu Setup',"You do not have permission to modify the setup.")
	Else
		w_MDI.Event pfc_cst_ezmenu_painter( )	
	End If
end if


If Pos( dwo.Name ,'t_arrowdown' ) > 0  Then
		
	of_expand(  this.object.groupno[row] )
	of_adjustWidth( )
	of_Resizemdi( )
ElseIf Pos( dwo.Name , 't_arrowup' ) > 0  Then
	
	of_collapse(  this.object.groupno[row] )
	of_adjustWidth( )
	of_Resizemdi( )
End If

ib_Resize = false



If row > 0 and dwo.Name = 'items'  Then
	
	If  This.object.groupblank[row] = 0 Then
		If Event ue_pre_click( This.object.toolbarname[row], xpos, ypos  ) <> 1 Then Return
		Event ue_clicked( This.object.toolbarname[row] )
	End If	

End If




end event

event mousemove;string			ls_object, ls_temp, ls_ClientType
long			ll_Row


ls_temp = Getobjectatpointer( )


ls_object = left( ls_temp, pos( ls_temp, '~t' ) - 1 )
ll_Row = Long( mid( ls_temp, pos( ls_temp, '~t') + 1 ) )
ls_ClientType = AppeonGetClientType()
If   ll_row >= 0 then 
	setrow( ll_Row )
	if ls_ClientType <> 'PB' then	
		If 	il_LastRow <> ll_Row And ls_object = 'items' Then
			ls_temp = this.getItemString( ll_Row, 'itemtip' )
			If IsNull(ls_temp ) Then ls_temp  = ''
			inv_ToolTip.of_settiptext(this,ii_DwTabular,ls_temp )
			il_LastRow = ll_Row
		End If
		If ls_object = 't_painter' Then
			inv_ToolTip.of_settiptext(this,ii_DwTabular, 'EZ Menu Settings' )
		ElseIf ls_Object = 't_refresh' Then
			inv_ToolTip.of_settiptext(this,ii_DwTabular, 'Refresh' )
		Elseif ls_object <> 'items' then
			inv_ToolTip.of_settiptext(this,ii_DwTabular, '' )
		End If
	End If
Else
	il_LastRow = -1
	If ls_ClientType <> 'PB' Then 	
		inv_ToolTip.of_settiptext(this,ii_DwTabular, '' )
	End If
End If

if ls_object = 't_contract' then
	If  describe( 't_contract.border' ) <> '6' then modify( 't_contract.border=6  ' )
	
Else
	If  describe( 't_contract.border' ) <> '0' then modify( 't_contract.border= 0' )
end if

if ls_object = 't_expand' then
	If  describe( 't_expand.border' ) <> '6' then modify( 't_expand.border=6 ' )
Else
	If  describe( 't_expand.border' ) <> '0' then modify( 't_expand.border = 0' )
end if

if ls_object = 't_refresh' then
	If  describe( 't_refresh.border' ) <> '6' then modify( 't_refresh.border=6 ' )
Else
	If  describe( 't_refresh.border' ) <> '0' then modify( 't_refresh.border = 0' )
end if

if ls_object = 't_painter' then
	If  describe( 't_painter.border' ) <> '6' then modify( 't_painter.border=6 ' )
Else
	If  describe( 't_painter.border' ) <> '0' then modify( 't_painter.border = 0' )
end if

end event

event constructor;call super::constructor;ids_Store = Create DataStore
ids_Expand = Create DataStore
ids_Main = Create DataStore
ids_original = create datastore

ids_Store.DataObject = This.DataObject
ids_Expand.DataObject = This.DataObject
ids_Main.DataObject = This.DataObject
ids_original.DataObject = This.DataObject

//iM_Relation_Menu = Create Menu

if AppeonGetClientType() = 'PB' then	
//	This.Modify( "pic.visible=0 t_checked.x=" + This.Describe( "pic.x" )  )	
Else
	If ii_DwTabular > 0 Then inv_ToolTip.of_RemoveTool( This, ii_dwtabular )

	ii_DwTabular = inv_ToolTip.of_AddTool( This, "" , inv_ToolTip.TTF_SUBCLASS )	 
End If

ib_Dock_Prevent = False

of_Set_screen( )
end event

event resize;call super::resize;If Not ib_Resize Then 
//	of_adjustwidth( )
//	of_ResizeMDI( )
	If this.height <> long( this.describe( "p_backgound.height" ) ) Then
		Modify( "p_background.height=" + string(this.height  ) )
	End If
END If
end event

event doubleclicked;call super::doubleclicked;

If dwo.name = 't_dock' or ( ib_Dock_Prevent and dwo.name = 'itempic' ) Then
	this.event clicked( 0,0, 0, this.object.t_expand )
	
End If
end event

event ue_key;call super::ue_key;if key = keyp! then
	this.Event clicked ( 0,0, 0, this.object.t_painter )
end if

if key = keyr! then
	this.Event clicked ( 0,0, 0, this.object.t_refresh )
end if

end event

event losefocus;call super::losefocus;If  describe( 't_contract.border' ) <> '0' then modify( 't_contract.border= 0' )

If  describe( 't_expand.border' ) <> '0' then modify( 't_expand.border = 0' )


If  describe( 't_refresh.border' ) <> '0' then modify( 't_refresh.border = 0' )

If  describe( 't_painter.border' ) <> '0' then modify( 't_painter.border = 0' )


end event

event scrollvertical;call super::scrollvertical;il_VScrollPosition = scrollpos
end event

event pfc_deleterow;//

return 1
end event

