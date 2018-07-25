$PBExportHeader$u_tab_report_tab.sru
forward
global type u_tab_report_tab from u_tab
end type
type tabpage_criteria from u_tabpage_report_criteria within u_tab_report_tab
end type
type tabpage_criteria from u_tabpage_report_criteria within u_tab_report_tab
end type
type tabpage_report from u_tabpage_report_report within u_tab_report_tab
end type
type tabpage_report from u_tabpage_report_report within u_tab_report_tab
end type
type tabpage_graph from u_tabpage_report_graph within u_tab_report_tab
end type
type tabpage_graph from u_tabpage_report_graph within u_tab_report_tab
end type
end forward

global type u_tab_report_tab from u_tab
integer width = 4055
integer height = 2456
long backcolor = 33551856
tabpage_criteria tabpage_criteria
tabpage_report tabpage_report
tabpage_graph tabpage_graph
end type
global u_tab_report_tab u_tab_report_tab

forward prototypes
public function boolean of_is_closewindow_allowed ()
end prototypes

public function boolean of_is_closewindow_allowed ();//====================================================================
//$<Function>: of_is_closewindow_allowed
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: Whether allowed to close window
//$<Author>: (Appeon) long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return tabpage_report.of_is_closewindow_allowed()
end function

on u_tab_report_tab.create
this.tabpage_criteria=create tabpage_criteria
this.tabpage_report=create tabpage_report
this.tabpage_graph=create tabpage_graph
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_criteria
this.Control[iCurrent+2]=this.tabpage_report
this.Control[iCurrent+3]=this.tabpage_graph
end on

on u_tab_report_tab.destroy
call super::destroy
destroy(this.tabpage_criteria)
destroy(this.tabpage_report)
destroy(this.tabpage_graph)
end on

event selectionchanged;call super::selectionchanged;//---------Begin Added by (Appeon)Harry 11.10.2014 for practitoner profile standard report --------
if tabpage_criteria.dw_select_report.getitemnumber(tabpage_criteria.dw_select_report.getrow(), 'report_id') = 2 and newindex = 2 then
	long ll_prac_id 
	w_report w_parent_window
	if tabpage_criteria.dw_criteria.getrow() < 1 then return 
	w_parent_window = tabpage_criteria.iw_parent_window
	ll_prac_id =  tabpage_criteria.dw_criteria.GetItemNumber( tabpage_criteria.dw_criteria.getrow(), "prac_id" )
	if ll_prac_id = w_parent_window.il_prac_id then return
	if not isnull(ll_prac_id) and ll_prac_id > 0 then
		w_parent_window.il_prac_id = ll_prac_id
		w_parent_window.inv_reports.of_profile_report_v8( tabpage_report.dw_report, w_parent_window.il_facility_id, w_parent_window.il_prac_id, w_parent_window.il_profile_view_id, w_parent_window.ib_peer_data, tabpage_criteria.dw_profile_temp,w_parent_window.il_screen_view_id  )	
	end if
end if
//---------End Added ------------------------------------------------------
end event

type tabpage_criteria from u_tabpage_report_criteria within u_tab_report_tab
integer x = 18
integer y = 100
integer width = 4018
integer height = 2340
string picturename = ""
end type

type tabpage_report from u_tabpage_report_report within u_tab_report_tab
integer x = 18
integer y = 100
integer width = 4018
integer height = 2340
string picturename = ""
end type

type tabpage_graph from u_tabpage_report_graph within u_tab_report_tab
boolean visible = false
integer x = 18
integer y = 100
integer width = 4018
integer height = 2340
string picturename = ""
end type

