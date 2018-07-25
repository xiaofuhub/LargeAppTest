$PBExportHeader$u_tabpg_contract_action_items_det_browse.sru
forward
global type u_tabpg_contract_action_items_det_browse from u_tabpg_contract_master
end type
type dw_1 from u_dw_contract within u_tabpg_contract_action_items_det_browse
end type
type dw_filter from u_dw_contract within u_tabpg_contract_action_items_det_browse
end type
end forward

global type u_tabpg_contract_action_items_det_browse from u_tabpg_contract_master
integer width = 3863
integer height = 1884
long backcolor = 33551856
string text = "Browse"
string powertiptext = "Action item Browse"
event ue_set_screen_properties ( )
dw_1 dw_1
dw_filter dw_filter
end type
global u_tabpg_contract_action_items_det_browse u_tabpg_contract_action_items_det_browse

forward prototypes
public subroutine of_showhidesearch (boolean ab_show)
end prototypes

event ue_set_screen_properties();// Set screen properties
dw_1.of_set_properties(dw_1.il_ViewID, dw_1.il_ScreenID, "Y")
dw_filter.of_set_properties(dw_filter.il_ViewID, dw_filter.il_ScreenID, "Y")

dw_filter.Border = dw_1.Border
dw_filter.BorderStyle = dw_1.BorderStyle
dw_filter.TitleBar = dw_1.TitleBar

end event

public subroutine of_showhidesearch (boolean ab_show);//====================================================================
// Function: of_ShowHideSearch()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_Show
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2010-05-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_BottomSpace

if ab_Show then
	if dw_Filter.Visible then Return
	dw_Filter.Visible = true
	
	ll_BottomSpace = This.Height - dw_1.Y - dw_1.Height
	dw_1.Y = dw_Filter.Y + dw_Filter.Height + 20
	dw_1.Height = This.Height - ll_BottomSpace - dw_1.Y
else
	if Not dw_Filter.Visible then Return
	dw_Filter.Visible = false
	
	ll_BottomSpace = This.Height - dw_1.Y - dw_1.Height
	dw_1.Y = dw_Filter.Y
	dw_1.Height = This.Height - ll_BottomSpace - dw_1.Y
	
	dw_1.SetFocus()
end if

if IsValid(m_pfe_cst_mdi_menu_contract) then
	//---------Begin Modified by (Appeon)Harry 03.10.2014 for V142 ISG-CLX--------
	//m_pfe_cst_mdi_menu_contract.m_view.m_filter.ToolbarItemVisible = true
	//m_pfe_cst_mdi_menu_contract.m_view.m_filter.ToolbarItemDown = ab_Show
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemVisible', true)
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_view.m_filter,'ToolbarItemDown', ab_Show)
	//---------End Modfiied ------------------------------------------------------
end if

end subroutine

on u_tabpg_contract_action_items_det_browse.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_filter=create dw_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_filter
end on

on u_tabpg_contract_action_items_det_browse.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.dw_filter)
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_contract_action_items_det_browse
integer taborder = 10
end type

type dw_1 from u_dw_contract within u_tabpg_contract_action_items_det_browse
string tag = "Action item Browse"
integer y = 4
integer width = 3840
integer height = 1852
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Action item Browse"
boolean hscrollbar = true
boolean ib_rmbmenu = false
string dataobject_original = "d_cntx_action_items_browse"
boolean ib_allow_sort = true
end type

event clicked;call super::clicked;//IF This.GetClickedRow() > 0 THEN
//	This.ScrollToRow( This.GetClickedRow() )
//	This.SetRow( This.GetClickedRow() )
//END IF
end event

event doubleclicked;call super::doubleclicked;u_tab_action_items_det luo_tab_action_items_det
luo_tab_action_items_det = Parent.Getparent( )
IF Isvalid(luo_tab_action_items_det) THEN
	luo_tab_action_items_det.selecttab( 2 )
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow > 0 THEN
//	This.Selectrow( 0, False)
//	This.Selectrow( currentrow, True)
	
	u_tab_action_items_det luo_tab_action_items_det
	luo_tab_action_items_det = Parent.Getparent( )
	IF Isvalid(luo_tab_action_items_det) THEN
		IF luo_tab_action_items_det.tabpage_detail.dw_1.Rowcount( ) >= currentrow AND luo_tab_action_items_det.selectedtab = 1  THEN
			luo_tab_action_items_det.tabpage_detail.dw_1.Setrow( currentrow )
			luo_tab_action_items_det.tabpage_detail.dw_1.Scrolltorow( currentrow )
		END IF
	END IF

END IF
end event

event pfc_deleterow;//-------Begin Commented by Alfee 09.30.2007-------------
//<$Reason>For a read only contract, it shouldn't be enabled
//m_pfe_cst_mdi_menu_contract.m_file.m_save.enabled = True 
//-------End Commented ----------------------------------


//Added By Ken 08/17/2011.
//Override Ancestor Script
u_tab_action_items_det luo_tab_action_items_det
luo_tab_action_items_det = Parent.Getparent( )
IF Isvalid(luo_tab_action_items_det) THEN
	Return luo_tab_action_items_det.tabpage_detail.dw_1.event pfc_deleterow( )
END IF


return success

end event

event constructor;call super::constructor;This.event ue_populatedddws( )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.24.2006 By: Davis
//$<reason> Fix a defect.
this.of_setupdateable( false)
//---------------------------- APPEON END ----------------------------

this.of_SetRowManager(TRUE)
this.of_setrowselect( true)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.extended )
end event

event pfc_filterdlg;call super::pfc_filterdlg;/*
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 10.30.2006 By: Jack 
//$<reason>Make the Action Items filters available at the top of the window instead of in a separate window. 
/*
OpenWithParm( w_contract_action_item_filter, This)
Return 1
*/
if dw_filter.visible then return 1
m_pfe_cst_mdi_menu_contract.m_view.m_filter.Enabled = false

dw_filter.visible = true
dw_filter.setfocus()
dw_1.y = dw_filter.y + dw_filter.height + 10

dw_1.height = Parent.height - dw_filter.y - dw_filter.height - 30
//dw_1.height = dw_1.height - dw_filter.y - dw_filter.height + 20
Return 1
//---------------------------- APPEON END ----------------------------
*/

of_ShowHideSearch(Not dw_filter.visible)

Return 1

end event

type dw_filter from u_dw_contract within u_tabpg_contract_action_items_det_browse
string tag = "Action Item Filter"
boolean visible = false
integer y = 4
integer width = 3840
integer height = 396
integer taborder = 20
boolean bringtotop = true
boolean titlebar = true
string title = "Action Item Filter"
string dataobject = "d_contract_action_items_filter"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack 
//$<reason>	Make the Action Items filters available at the top of the window instead of in a separate window.
choose case dwo.name
	case 'b_1'
		dw_filter.Reset()
		dw_filter.InsertRow( 0 )
		dw_1.SetFilter("")
		dw_1.Filter()
	case 'b_2'
		Long ll_act_type 
		Long ll_act_status 
		String ls_act_user
		String ls_new_sql
		Datetime ldt_act_date,ldt_act_date1
		Datetime ldt_due_date,ldt_due_date1
		long ll_rec_status
		
		// Initial
		dw_filter.AcceptText()
		dw_filter.SetColumn( "action_type" )
		ls_new_sql = "1=1"
		
		// Get Filter condition
		ll_act_type = dw_filter.GetitemNumber(1, "action_type")
		ls_act_user = dw_filter.GetitemString(1, "action_user")
		ll_act_status = dw_filter.GetitemNumber(1, "action_status")
		ldt_act_date = dw_filter.GetitemDatetime(1, "action_date")
		ldt_act_date1 = dw_filter.GetitemDatetime(1, "action_date_1")
		ldt_due_date = dw_filter.GetitemDatetime(1, "due_date")
		ldt_due_date1 = dw_filter.GetitemDatetime(1, "due_date_1")
		ll_rec_status = dw_filter.GetItemNumber(1,"active_status")
		
		
		// Set Filter condition
		IF Not IsNull( ll_act_type ) AND ll_act_type > 0 THEN
			ls_new_sql = ls_new_sql + " AND action_type = " + String( ll_act_type )
		END IF
		
		IF Not IsNull( ls_act_user ) AND LEN(ls_act_user) > 0 THEN
			ls_new_sql = ls_new_sql + " AND action_user = '" + ls_act_user + "'"
		END IF
		
		IF Not IsNull( ll_act_status ) THEN
			ls_new_sql = ls_new_sql + " AND action_status = " + String( ll_act_status )
		END IF
		
		IF Not IsNull( ldt_act_date ) THEN
			ls_new_sql = ls_new_sql + " AND action_date >= Date('" + String( Date( ldt_act_date ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_act_date1 ) THEN
			ls_new_sql = ls_new_sql + " AND action_date <= Date('" + String( Date( ldt_act_date1 ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_due_date ) THEN
			ls_new_sql = ls_new_sql + " AND due_date >= Date('" + String( Date( ldt_due_date ), "yyyy-mm-dd" ) + "')"
		END IF
		
		IF Not IsNull( ldt_due_date1 ) THEN
			ls_new_sql = ls_new_sql + " AND due_date <= Date('" + String( Date( ldt_due_date1 ), "yyyy-mm-dd" ) + "')"
		END IF
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 12.27.2006 By: Jervis
		//$<reason> 
		IF Not IsNull( ll_rec_status ) THEN
			if ll_rec_status = -1 then
				ls_new_sql = ls_new_sql + " and active_status < 0"
			elseif ll_rec_status = 1 then
				ls_new_sql = ls_new_sql + " and active_status >= 0 or isnull(active_status)"
			end if
		END IF
		//---------------------------- APPEON END ----------------------------

		// Filter Action item
		dw_1.SetFilter(ls_new_sql)
		dw_1.Filter()		
	case 'b_3'
		dw_1.SetFilter("")
		dw_1.Filter()
		
		/*
		dw_filter.visible = false
		dw_1.y = 48
		dw_1.height = Parent.Height - This.Y - 30
		m_pfe_cst_mdi_menu_contract.m_view.m_filter.Enabled = True
		dw_1.setfocus()
		*/
		
		of_ShowHideSearch(false)		//Added by Scofield on 2010-05-12
	//---------Begin Added by (Appeon)Toney 11.29.2013 for V141 ISG-CLX--------
	//$Reason:Fix history BugT082101
	Case 'b_me'
		THIS.SetItem(row,"Action_User",gs_user_id)
		THIS.SetColumn("Action_User")
	//---------End Added ------------------------------------------------------------------

	case else
end choose

//---------------------------- APPEON END ----------------------------

end event

event constructor;call super::constructor;//Disable ib_rmbmenu by Alfee 09.30.2007

ib_allow_save = FALSE //for of_enable_save(), added by Alfee 09.30.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 10.30.2006 By: Jack
//$<reason> Make the Action Items filters available at the top of the window instead of in a separate window.
This.InsertRow( 0 )

dw_filter.of_SetUpdateAble( False )
dw_filter.of_SetDropDownCalendar(TRUE)

dw_filter.of_SetTransObject(SQLCA)

This.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------

of_ShowHideSearch(false)		//Added by Scofield on 2010-05-12

end event

event pfc_filterdlg;call super::pfc_filterdlg;Return dw_1.event pfc_filterdlg( ) //Added By Ken.Guo 2010-07-26.
end event

