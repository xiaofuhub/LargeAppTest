$PBExportHeader$u_tab_measurments_search.sru
$PBExportComments$The Measurements serach tab
forward
global type u_tab_measurments_search from u_tab
end type
type tabpage_browse from u_tabpg_measurments_browse within u_tab_measurments_search
end type
type tabpage_browse from u_tabpg_measurments_browse within u_tab_measurments_search
end type
type tabpage_detail from u_tabpg_measurments_detail within u_tab_measurments_search
end type
type tabpage_detail from u_tabpg_measurments_detail within u_tab_measurments_search
end type
type tabpage_reports from u_tabpage_measurments_reports within u_tab_measurments_search
end type
type tabpage_reports from u_tabpage_measurments_reports within u_tab_measurments_search
end type
type tabpage_action_items from u_tabpage_measurments_action_items within u_tab_measurments_search
end type
type tabpage_action_items from u_tabpage_measurments_action_items within u_tab_measurments_search
end type
end forward

global type u_tab_measurments_search from u_tab
integer width = 3639
integer height = 1772
boolean fixedwidth = false
boolean boldselectedtext = false
tabposition tabposition = tabsonbottom!
alignment alignment = right!
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_reports tabpage_reports
tabpage_action_items tabpage_action_items
end type
global u_tab_measurments_search u_tab_measurments_search

type variables



window lw_parent_window

end variables

forward prototypes
public function integer of_select_data ()
end prototypes

public function integer of_select_data ();

return this.selecttab( 2)
end function

on u_tab_measurments_search.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_reports=create tabpage_reports
this.tabpage_action_items=create tabpage_action_items
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_browse
this.Control[iCurrent+2]=this.tabpage_detail
this.Control[iCurrent+3]=this.tabpage_reports
this.Control[iCurrent+4]=this.tabpage_action_items
end on

on u_tab_measurments_search.destroy
call super::destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_reports)
destroy(this.tabpage_action_items)
end on

event selectionchanged;call super::selectionchanged;/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: 
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

// only retrieve the datawindows if this is a new header ID or if there are no rows in the detail
if oldindex = -1 or newindex = -1 then return

iw_parent.setredraw( false)

IF newindex = 2 and  oldindex = 1 THEN
	IF tabpage_detail.dw_measuremt_header.ROWcount( ) >	0 AND tabpage_browse.dw_1.rowcount( ) > 0 	THEN
		   IF tabpage_browse.dw_1.object.pd_qa_hdr_id[tabpage_browse.dw_1.GETROW()] <>  tabpage_detail.dw_measuremt_header.object.pd_qa_hdr_id[1]  THEN
				tabpage_detail.event ue_reset( )
				tabpage_detail.of_retrieve_master_dw(tabpage_browse.of_get_header_id( ))
			END IF
		ELSE
			tabpage_detail.event ue_reset( )
			tabpage_detail.of_retrieve_master_dw(tabpage_browse.of_get_header_id( ))
	   END IF
END IF

/////////////////////////////////////////////////////////////////////////////////
// keep the datawindow in sync
/////////////////////////////////////////////////////////////////////////////////

IF newindex = 1  AND oldindex > 1 THEN
	tabpage_browse.dw_1.EVENT pfc_retrieve( )
END IF

/////////////////////////////////////////////////////////////////////////////////
// set the prac_id and header_id for the actionitems tab
/////////////////////////////////////////////////////////////////////////////////


this.tabpage_action_items.of_set_hdr_id( tabpage_browse.of_get_header_id( ))
this.tabpage_action_items.of_set_prac_id(tabpage_browse.of_get_prac_id( ))
//this.tabpage_reports.of_set_facility_id( this.tabpage_browse.il_facility_id)
 long ll_selected_row
 ll_selected_row = this.tabpage_browse.dw_1.GetSelectedRow(0)
 if ll_selected_row > 0 then
 this.tabpage_reports.of_set_facility_id( this.tabpage_browse.dw_1.object.facility_id[ll_selected_row])
end if


iw_parent.setredraw(true)


if newindex = 4 then
	w_mdi.ChangeMenu( m_pfe_cst_qa )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-11-15 By: Allen
	//$<reason> Fix APB Bug: the Toolbar Icon is invalid.
	/*
	w_mdi.ChangeMenu(m_pfe_cst_qa)
	*/
	If w_mdi.menuname <> 'm_pfe_cst_qa' Then w_mdi.ChangeMenu( m_pfe_cst_qa )
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 08.21.2006 By: LeiWei
	//$<reason> Fix a defect.
	w_mdi.of_menu_security( w_mdi.MenuName )
	//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<add> 01.20.2006 By: Rodger Wu
	//$<reason> The SetToolbarPos function is currently unsupported. 
	//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
	//$<modification> the same functionality.
	long ll_handle
	ll_handle = handle(w_mdi)
	gnv_appeondll.of_settoolbarpos(ll_handle)
	//---------------------------- APPEON END ----------------------------

	tabpage_action_items.dw_1.event pfc_retrieve( )
else
   lw_parent_window.dynamic of_set_measurments_menu()
end if




end event

event doubleclicked;call super::doubleclicked;


THIS.SELecttab(THIS.tabpage_detail)

end event

type tabpage_browse from u_tabpg_measurments_browse within u_tab_measurments_search
event ue_doubleclicked pbm_tcndoubleclicked
integer x = 18
integer y = 16
integer width = 3602
integer height = 1644
end type

event constructor;call super::constructor;




this.of_getparentwindow(lw_parent_window)

end event

type tabpage_detail from u_tabpg_measurments_detail within u_tab_measurments_search
integer x = 18
integer y = 16
integer width = 3602
integer height = 1644
end type

type tabpage_reports from u_tabpage_measurments_reports within u_tab_measurments_search
integer x = 18
integer y = 16
integer width = 3602
integer height = 1644
end type

type tabpage_action_items from u_tabpage_measurments_action_items within u_tab_measurments_search
integer x = 18
integer y = 16
integer width = 3602
integer height = 1644
end type

