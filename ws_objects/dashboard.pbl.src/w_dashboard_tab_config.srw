$PBExportHeader$w_dashboard_tab_config.srw
forward
global type w_dashboard_tab_config from w_response
end type
type dw_tab_position from datawindow within w_dashboard_tab_config
end type
type dw_tab from datawindow within w_dashboard_tab_config
end type
type uo_font_list from u_cst_fonts_list within w_dashboard_tab_config
end type
type cb_apply from commandbutton within w_dashboard_tab_config
end type
type dw_style from datawindow within w_dashboard_tab_config
end type
type cb_cancel from commandbutton within w_dashboard_tab_config
end type
type cb_ok from commandbutton within w_dashboard_tab_config
end type
type dw_gadgets from datawindow within w_dashboard_tab_config
end type
type gb_1 from groupbox within w_dashboard_tab_config
end type
end forward

global type w_dashboard_tab_config from w_response
integer width = 2473
integer height = 2324
string title = "Dashboard Tab Settings"
long backcolor = 16777215
event ue_syscommand pbm_syscommand
event ue_retrieve ( )
dw_tab_position dw_tab_position
dw_tab dw_tab
uo_font_list uo_font_list
cb_apply cb_apply
dw_style dw_style
cb_cancel cb_cancel
cb_ok cb_ok
dw_gadgets dw_gadgets
gb_1 gb_1
end type
global w_dashboard_tab_config w_dashboard_tab_config

type variables
Long il_tab_id

u_cst_tabpg_gadget iuo_tabpg

Boolean ib_allow_close = true
end variables

forward prototypes
public function integer of_apply_tab_style ()
public function integer of_apply_tab_gadgets ()
public function integer of_delete_gadget (long al_gadget_id)
public subroutine of_set_locked ()
public subroutine of_hide_gadget ()
public subroutine of_set_fonts_dwc ()
end prototypes

event ue_syscommand;//////////////////////////////////////////////////////////////////////
// $<event>ue_syscommandw_dashboard_config()
// $<arguments>
//		value	unsignedlong	commandtype		
//		value	integer     	xpos       		
//		value	integer     	ypos       		
// $<returns> long
// $<description> If click 'Close' button on title bar, 
// $<description> Need trigger clickced event for 'Cancel' button.
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

event ue_retrieve();dw_gadgets.SetRedraw(False)
gnv_appeondb.of_startqueue( )
	dw_style.Retrieve(il_tab_id)
	dw_gadgets.Retrieve(il_tab_id)
	dw_tab.Retrieve(gs_user_id)
	dw_tab_position.Retrieve(gs_user_id)
gnv_appeondb.of_commitqueue( )
of_hide_gadget()

f_apply_gadgets_right_dw(dw_gadgets,'gadget_id')
dw_gadgets.SetRedraw(True)
end event

public function integer of_apply_tab_style ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_config::of_apply_tab_style()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Apply tab's title and tab's new style
//////////////////////////////////////////////////////////////////////
// $<add> 24/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_title_org,ls_title_new
String ls_style_org,ls_style_new
String ls_style_type_org,ls_style_type_new
String ls_gadget_title_font_face_org,ls_gadget_title_font_face_new
Integer li_gadget_title_font_size_org,li_gadget_title_font_size_new
String ls_tab_header_font_face_org,ls_tab_header_font_face_new
Integer li_tab_header_font_size_org,li_tab_header_font_size_new
Long ll_gadget_title_bg_color_org,ll_gadget_title_bg_color_new
Long ll_tab_bg_color_org,ll_tab_bg_color_new
Long ll_gadget_bg_color_org,ll_gadget_bg_color_new
Boolean lb_changed = False
Integer li_ret1,li_ret2,li_ret3
Long ll_gadget_title_font_color_org,ll_gadget_title_font_color_new
Long ll_tab_text_color_org,ll_tab_text_color_new

If dw_style.RowCount() <> 1 Then Return 1
If dw_style.Modifiedcount() = 0 and dw_tab.Modifiedcount() = 0 and dw_tab_position.Modifiedcount() = 0 Then Return 1

//Get modification data status
ls_title_org = dw_style.GetItemString(1,'tab_title',Primary!,True)
ls_title_new = dw_style.GetItemString(1,'tab_title',Primary!,False)

ls_style_org = dw_style.GetItemString(1,'tab_style',Primary!,True)
ls_style_new= dw_style.GetItemString(1,'tab_style',Primary!,False)

ls_style_type_org = dw_style.GetItemString(1,'tab_style_type',Primary!,True)
ls_style_type_new= dw_style.GetItemString(1,'tab_style_type',Primary!,False)

ll_gadget_title_bg_color_org = dw_style.GetItemNumber(1,'gadget_title_color',Primary!,True)
ll_gadget_title_bg_color_new = dw_style.GetItemNumber(1,'gadget_title_color',Primary!,False)

ll_gadget_bg_color_org = dw_style.GetItemNumber(1,'gadget_bg_color',Primary!,True)
ll_gadget_bg_color_new = dw_style.GetItemNumber(1,'gadget_bg_color',Primary!,False)

ll_tab_bg_color_org = dw_style.GetItemNumber(1,'tab_bg_color',Primary!,True)
ll_tab_bg_color_new = dw_style.GetItemNumber(1,'tab_bg_color',Primary!,False)

ll_tab_text_color_org = dw_style.GetItemNumber(1,'tab_text_color',Primary!,True)
ll_tab_text_color_new = dw_style.GetItemNumber(1,'tab_text_color',Primary!,False)

ls_gadget_title_font_face_org = dw_style.GetItemString(1,'gadget_title_font_face',Primary!,True)
ls_gadget_title_font_face_new = dw_style.GetItemString(1,'gadget_title_font_face',Primary!,False)

li_gadget_title_font_size_org = dw_style.GetItemNumber(1,'gadget_title_font_size',Primary!,True)
li_gadget_title_font_size_new = dw_style.GetItemNumber(1,'gadget_title_font_size',Primary!,False)

ll_gadget_title_font_color_org = dw_style.GetItemNumber(1,'gadget_title_font_color',Primary!,True)
ll_gadget_title_font_color_new = dw_style.GetItemNumber(1,'gadget_title_font_color',Primary!,False)


//Save Changing to DB
gnv_appeondb.of_startqueue( )
	li_ret1 = dw_style.update()
	li_ret2 = dw_tab.update()
	li_ret3 = dw_tab_position.update()	
	Commit;
gnv_appeondb.of_commitqueue( )

If li_ret1 <> 1 Then
	Messagebox('Save error',"Failed to save dashboard's settings, please call support.")
	Return -1
Else
	//synchronize inv_dashboard data.
	w_dashboard.inv_dashboard.of_retrieve_data()
End If

//Check data whether changed
If ls_title_org <> ls_title_new Then
	iuo_tabpg.istr_current_tab.ss_tab_title = ls_title_new
	lb_changed = True
End If

If ls_style_org <> ls_style_new Then
	iuo_tabpg.ib_style_changed = True //Auto arrange gadgets.
	iuo_tabpg.istr_current_tab.ss_tab_style = ls_style_new
	lb_changed = True	
End If

If ls_style_type_org <> ls_style_type_new Then
	iuo_tabpg.istr_current_tab.ss_tab_style_type = ls_style_type_new
	lb_changed = True	
End If

If ll_gadget_title_bg_color_org <> ll_gadget_title_bg_color_new  Then
	iuo_tabpg.istr_current_tab.sl_gadget_title_bg_color = ll_gadget_title_bg_color_new
	lb_changed = True	
End If

If ll_tab_bg_color_org <> ll_tab_bg_color_new Then
	iuo_tabpg.istr_current_tab.sl_tab_bg_color = ll_tab_bg_color_new
	lb_changed = True
End If

If ll_tab_text_color_org <> ll_tab_text_color_new Then
	iuo_tabpg.istr_current_tab.sl_tab_text_color = ll_tab_text_color_new
	lb_changed = True
End If

If ll_gadget_bg_color_org <> ll_gadget_bg_color_new Then
	iuo_tabpg.istr_current_tab.sl_gadget_bg_color = ll_gadget_bg_color_new
	lb_changed = True
End If

If ls_gadget_title_font_face_org <> ls_gadget_title_font_face_new Then
	iuo_tabpg.istr_current_tab.ss_gadget_title_font_face  = ls_gadget_title_font_face_new
	lb_changed = True
End If

If li_gadget_title_font_size_org <> li_gadget_title_font_size_new Then
	iuo_tabpg.istr_current_tab.si_gadget_title_font_size  = li_gadget_title_font_size_new
	lb_changed = True
End If

If ll_gadget_title_font_color_org <> ll_gadget_title_font_color_new Then
	iuo_tabpg.istr_current_tab.sl_gadget_title_font_color  = ll_gadget_title_font_color_new
	lb_changed = True
End If

iuo_tabpg.istr_current_tab.si_tab_locked = dw_style.GetItemNumber(1,'tab_locked')
iuo_tabpg.istr_current_tab.si_single_double_clk = dw_style.GetItemNumber(1,'single_double_clk')

//Refresh UI
If lb_changed Then 
	iuo_tabpg.of_refresh_ui()
	If iuo_tabpg.u_gadget_18.visible Then
		iuo_tabpg.of_refresh_ui() //Do again to Refresh Getting Started data
	End If
End If

//For locked property.
iuo_tabpg.of_set_tab_properties() 

//For Tab header Properties
w_dashboard.of_set_tab_header_properties()

Return 1

end function

public function integer of_apply_tab_gadgets ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_config::of_apply_tab_gadgets()
// $<arguments>(None)
// $<returns> integer
// $<description> Add or Delete gadgets in current tabpage.
// $<description> And save changing to DB
//////////////////////////////////////////////////////////////////////
// $<add> 24/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_cnt,i,j,li_ret1,li_ret2
Integer li_selected_org,li_selected_new
Long ll_order = 10
Long ll_gadget_id
long ll_deleted_gadget_id[]
str_gadget lstr_area1_temp[],lstr_area2_temp[],lstr_area3_temp[],lstr_area4_temp[]
Boolean lb_added_getting_stared

li_cnt = dw_gadgets.RowCount() 
If li_cnt < 1 Then Return 1

//Save to restore
lstr_area1_temp[] = iuo_tabpg.istr_area1[]
lstr_area2_temp[] = iuo_tabpg.istr_area2[]
lstr_area3_temp[] = iuo_tabpg.istr_area3[]
lstr_area4_temp[] = iuo_tabpg.istr_area4[]

j = 1

For i = 1 To li_cnt
	li_selected_org = dw_gadgets.GetItemNumber(i,'Selected',Primary!,True)
	li_selected_new = dw_gadgets.GetItemNumber(i,'Selected',Primary!,False)	
	ll_gadget_id = dw_gadgets.GetItemNumber(i,'gadget_id')
	//Only changed data will do it.
	If li_selected_org <> li_selected_new Then
		If li_selected_new = 1 and ll_gadget_id = 18 Then
			lb_added_getting_stared = True
		End If
		If li_selected_new = 1 Then
			If Mod(j,3) = 1 Then  
				//Add to Area1
				iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])+1].gadget_id = ll_gadget_id
				iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].area_number = 1
				iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_title = dw_gadgets.GetItemString(i,'gadget_title')
				iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_Maximize = 1
				If dw_gadgets.GetItemNumber(i,'gadget_auto_height') = 1 Then
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_rows_number = 5  //Default row number
				Else
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_rows_number = 0  //Fixed height
				End If
			ElseIf  Mod(j,3) = 2 Then 
				//Add to Area2
				iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])+1].gadget_id = ll_gadget_id
				iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].area_number = 2		
				iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_title = dw_gadgets.GetItemString(i,'gadget_title')				
				iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_Maximize = 1				
				If dw_gadgets.GetItemNumber(i,'gadget_auto_height') = 1 Then
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_rows_number = 5  //Default row number
				Else
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_rows_number = 0  //Fixed height
				End If	
			ElseIf Mod(j,3) = 0 Then   
				//If style has area3, then added to area3, otherwise added to area1 and area2
				If dw_style.GetItemString(1,'tab_style') = '30' or dw_style.GetItemString(1,'tab_style') = '31' Then
					//Add to Area3
					iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])+1].gadget_id = ll_gadget_id
					iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])].area_number = 3
					iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])].gadget_title = dw_gadgets.GetItemString(i,'gadget_title')
					iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])].gadget_Maximize = 1
					If dw_gadgets.GetItemNumber(i,'gadget_auto_height') = 1 Then
						iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])].gadget_rows_number = 5  //Default row number
					Else
						iuo_tabpg.istr_area3[UpperBound(iuo_tabpg.istr_area3[])].gadget_rows_number = 0  //Fixed height
					End If					
				ElseIf Mod(j,2) = 1 Then
					//Add to Area1
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])+1].gadget_id = ll_gadget_id
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].area_number = 1
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_title = dw_gadgets.GetItemString(i,'gadget_title')
					iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_Maximize = 1
					If dw_gadgets.GetItemNumber(i,'gadget_auto_height') = 1 Then
						iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_rows_number = 5  //Default row number
					Else
						iuo_tabpg.istr_area1[UpperBound(iuo_tabpg.istr_area1[])].gadget_rows_number = 0  //Fixed height
					End If
				ElseIf Mod(j,2) = 0 Then
					//Add to Area2
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])+1].gadget_id = ll_gadget_id
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].area_number = 2		
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_title = dw_gadgets.GetItemString(i,'gadget_title')				
					iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_Maximize = 1				
					If dw_gadgets.GetItemNumber(i,'gadget_auto_height') = 1 Then
						iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_rows_number = 5  //Default row number
					Else
						iuo_tabpg.istr_area2[UpperBound(iuo_tabpg.istr_area2[])].gadget_rows_number = 0  //Fixed height
					End If						
				End If
			End If
			J++
		Else
			//Delete UnSelected gadget in Area array.
			of_delete_gadget(ll_gadget_id)
			ll_deleted_gadget_id[UpperBound(ll_deleted_gadget_id[])+1] = ll_gadget_id
		End If
	End If
Next

//Delete Unselected gadgets from DB
li_ret1 = w_dashboard.inv_dashboard.of_delete_gadget(il_tab_id,ll_deleted_gadget_id[])

//Re-Generate Area array and Save Added gadget to DB
li_ret2 = iuo_tabpg.of_reset_area_array()

//Reset row's status and Refresh data(If failed to save).
Trigger Event ue_retrieve()

//If failed. Restore to original data
If li_ret1 < 0 or li_ret2 < 0 Then
	iuo_tabpg.istr_area1[] = lstr_area1_temp[]
	iuo_tabpg.istr_area2[] = lstr_area2_temp[]
	iuo_tabpg.istr_area3[] = lstr_area3_temp[]
	iuo_tabpg.istr_area4[] = lstr_area4_temp[]	
	Messagebox('Save error','Failed to save gadget list for the current dashboard, please call support.')
	Return -1
End If 

//Refresh visible
iuo_tabpg.of_set_visiable()

//Refresh Data
iuo_tabpg.event ue_retrieve()

//Refresh UI
iuo_tabpg.of_refresh_ui()

//Refresh Again for Getting Started height. //Added By Ken.Guo 2010-10-19.
If lb_added_getting_stared Then
	iuo_tabpg.of_refresh_ui() 
End If

//Refresh Do For new gadget.
iuo_tabpg.of_refresh_do()


Return 1
end function

public function integer of_delete_gadget (long al_gadget_id);Integer i

//Find and delete gadget from area1
For i = 1 To UpperBound(iuo_tabpg.istr_area1[])
	If iuo_tabpg.istr_area1[i].gadget_id = al_gadget_id Then
		iuo_tabpg.istr_area1[i].gadget_id = 0
		Return 1
	End If
Next

//Find and delete gadget from area2
For i = 1 To UpperBound(iuo_tabpg.istr_area2[])
	If iuo_tabpg.istr_area2[i].gadget_id = al_gadget_id Then
		iuo_tabpg.istr_area2[i].gadget_id = 0
		Return 1
	End If
Next

//Find and delete gadget from area3
For i = 1 To UpperBound(iuo_tabpg.istr_area3[])
	If iuo_tabpg.istr_area3[i].gadget_id = al_gadget_id Then
		iuo_tabpg.istr_area3[i].gadget_id = 0
		Return 1
	End If
Next

//Find and delete gadget from area4
For i = 1 To UpperBound(iuo_tabpg.istr_area4[])
	If iuo_tabpg.istr_area4[i].gadget_id = al_gadget_id Then
		iuo_tabpg.istr_area4[i].gadget_id = 0
		Return 1
	End If
Next

Return 1
end function

public subroutine of_set_locked ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_config::of_set_locked()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>Locks tab to prevent modification
//////////////////////////////////////////////////////////////////////
// $<add> 30/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_locked
If dw_style.RowCount() = 0 Then Return 

//Modify datawindow's UI
li_locked =  dw_style.GetItemnumber(1,'tab_locked') 
If li_locked = 1 Then
	dw_style.Modify("tab_style.RadioButtons.3D='No'")
	dw_style.Modify("tab_style_type.RadioButtons.3D='No'")	
	dw_style.Modify("single_double_clk.RadioButtons.3D='NO'")		
	dw_gadgets.Modify("Selected_1.CheckBox.3D='NO'")	
	dw_gadgets.Modify("Selected_2.CheckBox.3D='NO'")	
	dw_gadgets.Enabled = False
	dw_tab.SetItem(1,'tab_locked',1)
	dw_tab.SetItemStatus(1,'tab_locked',Primary!,NotModified!)
	dw_tab.Modify("tab_header_font_face.Protect='1'") //Added by Ken.Guo on 2008-12-08. To workaround PB's Bug
	dw_tab.Modify("tab_header_font_size.Protect='1'")	
	dw_tab_position.SetItem(1,'tab_locked',1)
	dw_tab_position.SetItemStatus(1,'tab_locked',Primary!,NotModified!)	
	dw_tab_position.Modify("tab_position.Protect='1'")
End If
If li_locked = 0 Then
	dw_style.Modify("tab_style.RadioButtons.3D='YES'")
	dw_style.Modify("tab_style_type.RadioButtons.3D='YES'")		
	dw_style.Modify("single_double_clk.RadioButtons.3D='YES'")		
	dw_gadgets.Modify("Selected_1.CheckBox.3D='YES'")		
	dw_gadgets.Modify("Selected_2.CheckBox.3D='YES'")			
	dw_gadgets.Enabled = True
	dw_tab.SetItem(1,'tab_locked',0)
	dw_tab.SetItemStatus(1,'tab_locked',Primary!,NotModified!)	
	dw_tab.Modify("tab_header_font_face.Protect='0'")  //Added by Ken.Guo on 2008-12-08. To workaround PB's Bug
	dw_tab.Modify("tab_header_font_size.Protect='0'")	
	dw_tab_position.SetItem(1,'tab_locked',0)
	dw_tab_position.SetItemStatus(1,'tab_locked',Primary!,NotModified!)
	dw_tab_position.Modify("tab_position.Protect='0'")
End If

end subroutine

public subroutine of_hide_gadget ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_tab_config::of_hide_gadget()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Hide some gadgets,To Optimize Performance
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-18 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_row

//Only for Non-First Page.
If Not iuo_tabpg.ib_first_page Then
	//For To Do List
	li_row = dw_gadgets.Find('gadget_id = 1',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If

	//For Meet/Calendar
	li_row = dw_gadgets.Find('gadget_id = 5',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	
	//For Notes
	li_row = dw_gadgets.Find('gadget_id = 9',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If	
End If

//Start Code Change ----05.09.2012 #V12 maha - if not contract module hide summaries
if gb_contract_module = false then
	li_row = dw_gadgets.Find('gadget_id = 8',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 12',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 13',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 14',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 15',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 16',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	//(Appeon)Harry 10.12.2013 - For BugH101103
	li_row = dw_gadgets.Find('gadget_id = 17',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	li_row = dw_gadgets.Find('gadget_id = 18',1,dw_gadgets.RowCount())
	If li_row > 0 Then
		dw_gadgets.RowsDiscard(li_row,li_row,Primary!)
	End If
	//End  - For BugH101103
end if
//End Code Change ----05.09.2012	

end subroutine

public subroutine of_set_fonts_dwc ();Datawindowchild ldwc_gadget_fonts1,ldwc_gadget_fonts2

dw_style.GetChild('gadget_title_font_face',ldwc_gadget_fonts1)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_gadget_fonts1,1,primary!)

dw_tab.GetChild('tab_header_font_face',ldwc_gadget_fonts2)
uo_font_list.idwc_fonts.RowsCopy(1,uo_font_list.idwc_fonts.RowCount(),primary!,ldwc_gadget_fonts2,1,primary!)

end subroutine

on w_dashboard_tab_config.create
int iCurrent
call super::create
this.dw_tab_position=create dw_tab_position
this.dw_tab=create dw_tab
this.uo_font_list=create uo_font_list
this.cb_apply=create cb_apply
this.dw_style=create dw_style
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_gadgets=create dw_gadgets
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_tab_position
this.Control[iCurrent+2]=this.dw_tab
this.Control[iCurrent+3]=this.uo_font_list
this.Control[iCurrent+4]=this.cb_apply
this.Control[iCurrent+5]=this.dw_style
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.dw_gadgets
this.Control[iCurrent+9]=this.gb_1
end on

on w_dashboard_tab_config.destroy
call super::destroy
destroy(this.dw_tab_position)
destroy(this.dw_tab)
destroy(this.uo_font_list)
destroy(this.cb_apply)
destroy(this.dw_style)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_gadgets)
destroy(this.gb_1)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard_config::open()
// $<arguments>(None)
// $<returns> long
// $<description> Config current tab for dashboard
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 29/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

SetPointer(HourGlass!)

//APB Bug.  Workaround BugJ050801
dw_tab_position.visible = False

il_tab_id = iuo_tabpg.istr_current_tab.sl_tab_id

dw_style.SetTransObject(sqlca)
dw_gadgets.SetTransObject(sqlca)
dw_tab.SetTransObject(SQLCA)
dw_tab_position.SetTransObject(SQLCA)

Trigger Event ue_retrieve()

end event

event pfc_preopen;call super::pfc_preopen;iuo_tabpg = Message.powerobjectparm
end event

event closequery;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard_configControl List()
// $<arguments>(None)
// $<returns> (none)
// $<description> If no these script, it will show message twice.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 28/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Override Ancestor Script
If ib_allow_close Then
	Return 0
Else
	Return 1
End If


end event

event pfc_postopen;call super::pfc_postopen;of_set_locked()
of_set_fonts_dwc()
end event

type dw_tab_position from datawindow within w_dashboard_tab_config
integer x = 50
integer y = 2108
integer width = 745
integer height = 92
integer taborder = 30
string title = "none"
string dataobject = "d_dashb_tab_settings_position"
boolean border = false
boolean livescroll = true
end type

type dw_tab from datawindow within w_dashboard_tab_config
integer x = 1317
integer y = 1116
integer width = 1056
integer height = 112
integer taborder = 20
string title = "none"
string dataobject = "d_dashb_tab_settings_edit"
boolean border = false
boolean livescroll = true
end type

type uo_font_list from u_cst_fonts_list within w_dashboard_tab_config
boolean visible = false
integer width = 0
integer height = 0
integer taborder = 30
end type

on uo_font_list.destroy
call u_cst_fonts_list::destroy
end on

type cb_apply from commandbutton within w_dashboard_tab_config
integer x = 2048
integer y = 2112
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Apply"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_apply::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description> Apply The Changes.
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_tabname
SetPointer(HourGlass!)
dw_style.AcceptText()
dw_gadgets.AcceptText()
dw_tab.AcceptText()
dw_tab_position.AcceptText()

ls_tabname = dw_style.GetItemString(1,'tab_title')
If ls_tabname = '' or isnull(ls_tabname) Then
	Messagebox('Tab Name','Please input the tab name.')
	Return -1
End If

If dw_style.ModifiedCount() > 0 or dw_tab.ModifiedCount() > 0 or dw_tab_position.ModifiedCount() > 0 Then
	If of_apply_tab_style() < 0 Then Return -1
End If

If dw_gadgets.Modifiedcount() > 0 Then
	If of_apply_tab_gadgets() < 0 Then Return -1
End If

Return 1
end event

type dw_style from datawindow within w_dashboard_tab_config
integer width = 2519
integer height = 1260
integer taborder = 10
string title = "none"
string dataobject = "d_dashb_tab_style_property"
boolean border = false
boolean livescroll = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>dw_style::clicked()
// $<arguments>
//		value	integer 	xpos		
//		value	integer 	ypos		
//		value	long    	row 		
//		value	dwobject	dwo 		
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 26/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


Long ll_color,ll_color_org
gl_custom_colors[16] = Parent.Backcolor  //Button Face!

If dwo.name <> 'tab_locked' and This.GetItemnumber(1,'tab_locked') = 1 Then Return 1

SetPointer(HourGlass!)

//For button for Tab backgroup color.
If dwo.name = 'r_tab_bg_color' Then
	ll_color = This.GetItemNumber(1,'tab_bg_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tab_bg_color',ll_color)
	End If
End If

//For button for Gadget Title backgroup color. 
If dwo.name = 'r_gadget_title_bg_color' Then
	ll_color = This.GetItemNumber(1,'gadget_title_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'gadget_title_color',ll_color)
	End If
End If

//For button for Gadget backgroup color.  
If dwo.name = 'r_gadget_bg_color' Then
	ll_color = This.GetItemNumber(1,'gadget_bg_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'gadget_bg_color',ll_color)
	End If
End If

//For button for Tab text color.
If dwo.name = 'r_tab_text_color' Then
	ll_color = This.GetItemNumber(1,'tab_text_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'tab_text_color',ll_color)
	End If
End If

//For button for Gadget title text color.  
If dwo.name = 'r_gadget_title_color' Then
	ll_color = This.GetItemNumber(1,'gadget_title_font_color')
	ll_color_org = ll_color
	ChooseColor(ll_color,gl_custom_colors[])
	If ll_color_org <> ll_color Then
		This.SetItem(1,'gadget_title_font_color',ll_color)
	End If
End If


end event

event itemchanged;If dwo.name = 'tab_locked' Then
	Post of_set_locked()
End If
end event

type cb_cancel from commandbutton within w_dashboard_tab_config
integer x = 1669
integer y = 2112
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Integer li_ret
SetPointer(HourGlass!)
ib_allow_close = True
If dw_style.Modifiedcount() + dw_tab.Modifiedcount() + dw_gadgets.Modifiedcount() > 0 Then
	li_ret = Messagebox('Save','You have modified some data. ~r~nDo you want to save the changes?',Question!,YesNoCancel!)
	If li_ret = 1 Then
		cb_ok.Trigger Event Clicked()
	ElseIf li_ret = 2 Then
		Close(Parent)
	Else
		ib_allow_close = False
		Return
	End If
Else
	Close(Parent)
End If
end event

type cb_ok from commandbutton within w_dashboard_tab_config
integer x = 1289
integer y = 2112
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Integer li_ret 
li_ret = cb_apply.trigger event clicked()
If li_ret > 0 Then
	ib_allow_close = True
	Close(Parent)
End If
end event

type dw_gadgets from datawindow within w_dashboard_tab_config
integer x = 91
integer y = 1360
integer width = 2226
integer height = 684
integer taborder = 20
string title = "none"
string dataobject = "d_dashb_gadgets_selected_nup"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_dashboard_tab_config
integer x = 69
integer y = 1292
integer width = 2322
integer height = 772
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 16777215
string text = "Gadgets Selection"
end type

