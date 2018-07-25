$PBExportHeader$u_dw_calendar_item.sru
forward
global type u_dw_calendar_item from datawindow
end type
end forward

global type u_dw_calendar_item from datawindow
integer width = 686
integer height = 400
boolean livescroll = true
borderstyle borderstyle = stylelowered!
event ue_property ( )
event ue_gotodatefield ( )
event ue_gotoactiontab ( )
event ue_gotodetailtab ( )
event mousemove pbm_dwnmousemove
end type
global u_dw_calendar_item u_dw_calendar_item

type variables
CONSTANT STRING AREABKMARK    = "Date_BackGD_"

CONSTANT STRING DISPITEMDWMARK = "dw_disp_list_"

m_items_property im_OptionMenu

end variables

forward prototypes
public subroutine of_displaydetail (long al_row)
public subroutine of_setdwcolfocus (long al_entrytype, string as_colname)
public subroutine of_gotorow (long al_entrytype, long al_ctx_id, long al_item_id)
end prototypes

event ue_property();of_DisplayDetail(This.GetRow())

end event

event ue_gotodatefield();long		ll_EntryType,ll_ctx_id,ll_doc_id,ll_Row,ll_seq_id
String	ls_ColName

PowerObject lpo_NullParm

ll_Row = This.GetRow()

if ll_Row <= 0 or ll_Row > This.RowCount() then Return

ll_ctx_id    = This.GetItemNumber(ll_Row,"ctx_id")
ll_EntryType = This.GetItemNumber(ll_Row,"entry_type")
ls_ColName   = This.GetItemString(ll_Row,"column_name")
ll_doc_id    = This.GetItemNumber(ll_Row,"doc_id")
ll_seq_id =  This.GetItemNumber(ll_Row,"seq_id")

if ll_EntryType >= 20 then Return

if Not IsValid(gw_Contract) then gf_OpenContractFolder(lpo_NullParm)

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
if ll_EntryType = 11 then
	Post gf_GoTo_Contract(ll_ctx_id,"20",0)
elseif ll_EntryType = 12 then
	Post gf_GoTo_Contract(ll_ctx_id,"100",0)
elseif ll_EntryType = 13 then
	Post gf_GoTo_Contract(ll_ctx_id,"92",ll_doc_id)
//Added By Ken.Guo 06/19/2012
elseif ll_EntryType = 14 then //custom 2
	Post gf_GoTo_Contract(ll_ctx_id,"22",ll_doc_id)
elseif ll_EntryType = 15 then //ctx_custom_multi_hdr
	Post gf_GoTo_Contract(ll_ctx_id,"111",ll_doc_id)
elseif ll_EntryType = 16 then //ctx_custom_multi_detail
	Post gf_GoTo_Contract(ll_ctx_id,"112",ll_doc_id)
elseif ll_EntryType = 17 then //ctx_fee_sched_nm 2
	Post gf_GoTo_Contract(ll_ctx_id,"80",ll_doc_id)

end if
*/
if ll_EntryType = 11 then
	Post gf_GoTo_Contract(ll_ctx_id,"20",0, 0, 0 ,ls_ColName)
elseif ll_EntryType = 12 then
	Post gf_GoTo_Contract(ll_ctx_id,"100",0, ll_doc_id, 0,ls_ColName )
elseif ll_EntryType = 13 then
	Post gf_GoTo_Contract(ll_ctx_id,"92",ll_doc_id, ll_seq_id, 0, ls_ColName )
//Added By Ken.Guo 06/19/2012
elseif ll_EntryType = 14 then //custom 2
	Post gf_GoTo_Contract(ll_ctx_id,"22",ll_doc_id, 0, 0, ls_ColName )
elseif ll_EntryType = 15 then //ctx_custom_multi_hdr
	Post gf_GoTo_Contract(ll_ctx_id,"111",0, ll_doc_id, 0, ls_ColName )
elseif ll_EntryType = 16 then //ctx_custom_multi_detail
	Post gf_GoTo_Contract(ll_ctx_id,"112",0,ll_doc_id,ll_seq_id, ls_ColName )
elseif ll_EntryType = 17 then //ctx_fee_sched_nm 2
	Post gf_GoTo_Contract(ll_ctx_id,"80",0, ll_doc_id, 0, ls_ColName )

end if
//---------End Modfiied ------------------------------------------------------
Post of_SetdwColFocus(ll_EntryType,ls_ColName)

end event

event ue_gotoactiontab();long	ll_EntryType,ll_ctx_id,ll_item_id,ll_doc_id,ll_seq_id,ll_Row

PowerObject lpo_NullParm

ll_Row = This.GetRow()

if ll_Row <= 0 or ll_Row > This.RowCount() then Return

ll_EntryType = This.GetItemNumber(ll_Row,"Entry_Type")

ll_ctx_id    = This.GetItemNumber(ll_Row,"ctx_id")
ll_item_id   = This.GetItemNumber(ll_Row,"item_id")

ll_doc_id    = This.GetItemNumber(ll_Row,"doc_id")
ll_seq_id    = This.GetItemNumber(ll_Row,"seq_id")

if ll_EntryType < 20 then Return

if Not IsValid(gw_Contract) then gf_OpenContractFolder(lpo_NullParm)

if ll_EntryType = 21 then
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//Post gf_goto_contract(ll_ctx_id,"100",0)
	Post gf_goto_contract(ll_ctx_id,"100",0, 0, 0,'due_date' )
	//---------End Modfiied ------------------------------------------------------
	Post of_GoToRow(ll_EntryType,ll_ctx_id,ll_item_id)
elseif ll_EntryType = 22 then
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//Post gf_goto_contract(ll_ctx_id,"92",ll_doc_id)
	Post gf_goto_contract(ll_ctx_id,"92",ll_doc_id, 0, 0, 'due_date' )
	//---------End Modfiied ------------------------------------------------------
	Post of_GoToRow(ll_EntryType,ll_doc_id,ll_seq_id)
end if

end event

event ue_gotodetailtab();long	ll_ctx_id,ll_Row

PowerObject lpo_NullParm

ll_Row = This.GetRow()

if ll_Row <= 0 or ll_Row > This.RowCount() then Return

ll_ctx_id = This.GetItemNumber(ll_Row,"ctx_id")

if Not IsValid(gw_Contract) then gf_OpenContractFolder(lpo_NullParm)

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
//Post gf_goto_contract(ll_ctx_id,"20",0)
Post gf_goto_contract(ll_ctx_id,"20",0, 0, 0, '' )
//---------End Modfiied ------------------------------------------------------

end event

event mousemove;if dwo.Name = "p_more" then
	This.Modify("p_more.FileName = 'More_Yellow.gif'")
else
	This.Modify("p_more.FileName = 'More_Gray.gif'")
end if

end event

public subroutine of_displaydetail (long al_row);long		ll_EntryType,ll_ctx_id,ll_AcItemID,ll_Doc_ID,ll_Seq_ID
String	ls_AlarmTable,ls_AlarmCol,ls_ColTitle

str_pass lstr_Pass

if al_Row <= 0 or al_Row > This.RowCount() then Return

ll_EntryType  = This.GetItemNumber(al_Row,"entry_type")
ll_ctx_id     = This.GetItemNumber(al_Row,"ctx_id")
ls_AlarmTable = This.GetItemString(al_Row,"table_name")
ls_AlarmCol   = This.GetItemString(al_Row,"column_name")
ls_ColTitle   = This.GetItemString(al_Row,"column_title")
ll_AcItemID   = This.GetItemNumber(al_Row,"item_id")
ll_Doc_ID     = This.GetItemNumber(al_Row,"doc_id")
ll_Seq_ID     = This.GetItemNumber(al_Row,"seq_id")

if ll_EntryType < 20 then
	if ls_AlarmTable = "ctx_am_action_item" then
		lstr_pass.s_string_array[1] = String(ll_Doc_ID)
		lstr_pass.s_string_array[5] = String(ll_Seq_ID)
	else
		lstr_pass.s_string_array[1] = String(ll_ctx_id)
		lstr_pass.s_string_array[5] = String(ll_AcItemID)
	end if
	
	lstr_pass.s_string_array[2] = ls_AlarmTable
	lstr_pass.s_string_array[3] = ls_AlarmCol
	lstr_pass.s_string_array[4] = ls_ColTitle
	
	If ls_AlarmTable = 'ctx_custom_multi_hdr' or ls_AlarmTable = 'ctx_custom_multi_detail' or  ls_AlarmTable = 'ctx_fee_sched_nm' Then //Added By Ken.Guo 06/19/2012
		lstr_pass.s_string_array[6] = String(ll_Doc_ID)
		lstr_pass.s_string_array[7] = String(ll_Seq_ID)
	Else
		lstr_pass.s_string_array[6] = '0'
		lstr_pass.s_string_array[7] = '0'
	End If
	lstr_pass.s_datetime[1] = this.GetItemDatetime( al_row, 'alm_date')
	
	OpenWithParm(w_ctx_alarm,lstr_Pass)
else
	if ll_Doc_ID = 0 and ll_Seq_ID = 0 then
		lstr_pass.s_string_array[1] = String(ll_ctx_id)
		lstr_pass.s_string_array[2] = String(ll_AcItemID)
		lstr_pass.s_string_array[3] = "ctx_action_item"
	else
		lstr_pass.s_string_array[1] = String(ll_Doc_ID)
		lstr_pass.s_string_array[2] = String(ll_Seq_ID)
		lstr_pass.s_string_array[3] = "ctx_am_action_item"
	end if
	
	OpenWithParm(w_ctx_action_item,lstr_pass)
end if

if Message.StringParm = "OK" then
	Parent.GetParent().Dynamic of_Refresh_Disp_List()
	Parent.GetParent().Dynamic of_RefreshSelectScope(0)
end if

end subroutine

public subroutine of_setdwcolfocus (long al_entrytype, string as_colname);//====================================================================
// Function: of_SetdwColFocus()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_EntryType
// 	value    string    as_ColName
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-12-21
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String		ls_Visible

DataWindow	ldw_Temp

if Not IsValid(gw_Contract) then Return

if al_EntryType >= 20 then Return

if al_EntryType = 11 then
	ldw_Temp = gw_Contract.tab_contract_details.tabpage_details.uo_1.dw_contract_dates
	ls_Visible = ldw_Temp.Describe(as_ColName + ".Visible")
	if gw_Contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.Visible and ls_Visible = "0" then
		ldw_Temp = gw_Contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_custom.dw_1
	end if
elseif al_EntryType = 12 then
	ldw_Temp = gw_Contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1
elseif al_EntryType = 13 then
	ldw_Temp = gw_Contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail
	
//Added By Ken.Guo 06/19/2012
elseif al_EntryType = 14 then //custom 2
	ldw_Temp = gw_contract.tab_contract_details.tabpage_details.uo_1.tab_1.tabpage_1.dw_1
elseif al_EntryType = 15 then //ctx_custom_multi_hdr
	ldw_Temp = gw_contract.tab_contract_details.tabpage_multi.tab_multi.tabpage_header.dw_header
elseif al_EntryType = 16 then //ctx_custom_multi_detail
	ldw_Temp = gw_contract.tab_contract_details.tabpage_multi.tab_multi.tabpage_detail.dw_detail
elseif al_EntryType = 17 then //ctx_fee_sched_nm
	ldw_Temp = gw_contract.tab_contract_details.tabpage_fee_sched2.dw_fee_nm
	
end if

Yield()

If Len(ldw_Temp.Describe(as_ColName + ".type")) > 1 Then
	ldw_Temp.Post SetColumn(as_ColName)
End If

ldw_Temp.Post SelectText(1,255)
ldw_Temp.Post SetFocus()

end subroutine

public subroutine of_gotorow (long al_entrytype, long al_ctx_id, long al_item_id);//====================================================================
// Function: of_GoToRow()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_EntryType
// 	value    long    al_ctx_id
// 	value    long    al_item_id
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-12-21
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FoundRow,ll_ArrangeMode
String	ls_FocusColumn

DataWindow	ldw_Temp

Yield()

if al_EntryType = 21 then
	if gw_contract.tab_contract_details.tabpage_action_items.Visible then
		ldw_Temp = gw_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1
		
		do while IsValid(ldw_Temp)
			if ldw_Temp.RowCount() > 0 then Exit
			Yield()
		loop
		
		if IsValid(ldw_Temp) then
			ll_FoundRow = ldw_Temp.Find("ctx_id = " + String(al_ctx_id) + " and ctx_action_item_id = " + String(al_item_id),1,ldw_Temp.RowCount())
		end if
	end if
elseif al_EntryType = 22 then
	if gw_contract.tab_contract_details.tabpage_images.Visible and gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.Visible then
		ldw_Temp = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail
		
		do while IsValid(ldw_Temp)
			if ldw_Temp.RowCount() > 0 then Exit
			Yield()
		loop
		
		if IsValid(ldw_Temp) then
			ll_FoundRow = ldw_Temp.Find("doc_id = " + String(al_ctx_id) + " and seq_id = " + String(al_item_id),1,ldw_Temp.RowCount())
		end if
	end if
end if

if ll_FoundRow > 0 then
	ll_ArrangeMode = long(gnv_data.of_GetItem("icred_settings","CalArrangeMode",false))
	if ll_ArrangeMode = 0 then
		ls_FocusColumn = "start_date"
	else
		ls_FocusColumn = "due_date"
	end if

	ldw_Temp.Post ScrolltoRow(ll_FoundRow)
	ldw_Temp.Post SetRow(ll_FoundRow)
	ldw_Temp.Post SetColumn(ls_FocusColumn)
	ldw_Temp.Post SetFocus()
	ldw_Temp.Post SelectText(1,255)
end if

end subroutine

on u_dw_calendar_item.create
end on

on u_dw_calendar_item.destroy
end on

event clicked;String	ls_ObjName,ls_AreaName,ls_ClassName

ls_ClassName = This.ClassName()
ls_ObjName   = dwo.Name

ls_AreaName = AREABKMARK + Right(ls_ClassName,2) + "_t"
Parent.Dynamic of_PitchOnDate(ls_AreaName)

if ls_ObjName = "p_more" then
	Parent.GetParent().Dynamic of_RefreshSelectScope(1)
end if

end event

event doubleclicked;of_DisplayDetail(Row)

end event

event getfocus;This.Post Modify("disp_value.Font.Weight = '0~tif(GetRow() = CurrentRow(),700,400)'")

end event

event losefocus;This.Modify("disp_value.Font.Weight = '400'")

end event

event constructor;if Not IsValid(im_OptionMenu) then
	im_OptionMenu = Create m_items_property
	im_OptionMenu.iu_dwItems = This
end if

end event

event destructor;if IsValid(im_OptionMenu) then Destroy im_OptionMenu

end event

event rbuttondown;long	ll_EnterType,ll_Row

ll_Row = This.GetRow()

if ll_Row <= 0 or ll_Row > This.RowCount() then Return

ll_EnterType = This.GetItemNumber(ll_Row,"Entry_Type")

//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
if ll_EnterType < 20 then
	im_OptionMenu.m_GoToDateField.Enabled = true
	im_OptionMenu.m_GoToActionItemTab.Enabled = false
else
	im_OptionMenu.m_GoToDateField.Enabled = false
	im_OptionMenu.m_GoToActionItemTab.Enabled = true
end if
*/
if ll_EnterType < 20 then
	gnv_app.of_modify_menu_attr( im_OptionMenu.m_GoToDateField,'Enabled', true)
	gnv_app.of_modify_menu_attr( im_OptionMenu.m_GoToActionItemTab,'Enabled', false)
else
	gnv_app.of_modify_menu_attr( im_OptionMenu.m_GoToDateField,'Enabled', false)
	gnv_app.of_modify_menu_attr( im_OptionMenu.m_GoToActionItemTab,'Enabled', true)
end if
//---------End Modfiied ------------------------------------------------------
im_OptionMenu.PopMenu(w_Mdi.PointerX(),w_Mdi.PointerY())

end event

