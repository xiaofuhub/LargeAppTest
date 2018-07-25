$PBExportHeader$u_cst_gadget_favorite_reports.sru
forward
global type u_cst_gadget_favorite_reports from u_cst_gadget_favorite_master
end type
end forward

global type u_cst_gadget_favorite_reports from u_cst_gadget_favorite_master
string tag = "u_gadget_2.Favorite Reports"
end type
global u_cst_gadget_favorite_reports u_cst_gadget_favorite_reports

forward prototypes
public function integer of_settings ()
end prototypes

public function integer of_settings ();OpenwithParm(w_dashboard_gadget_favorite_report_cfg,This)
Return 1

end function

event constructor;call super::constructor;of_register('REPORT')
end event

on u_cst_gadget_favorite_reports.create
call super::create
end on

on u_cst_gadget_favorite_reports.destroy
call super::destroy
end on

event ue_run;call super::ue_run;Long ll_data_id
String ls_type
str_dashboard str_para

If al_row <= 0 Then Return 1

ls_type = dw_content.GetItemString(al_row,'dashboard_gadgets_favorite_favorite_type')
ll_data_id = dw_content.GetItemNumber(al_row,'dashboard_gadgets_favorite_data_id')
str_para.data_id = ll_data_id

If ls_type = 'REPORT' Then
	IF IsValid(w_report)  THEN
		 w_report.of_dashboard(str_para.data_id)
	ELSE
		OpenSheetWithParm( w_report,str_para,w_mdi,4,Original! )
	END IF
ElseIf ls_type = 'INTELLIREP' Then
	IF IsValid(w_custom_report)  THEN
		 w_custom_report.of_dashboard(str_para.data_id)
	ELSE
		OpenSheetWithParm( w_custom_report,str_para,w_mdi,4,Original! )
	END IF	
End If

Return 1
end event

event ue_retrieve;call super::ue_retrieve;////---------Begin Modified by (Appeon)Harry 11.20.2013 for V141 ISG-CLX--------
////for BugH111901 of IntelliCredApp V14.1 History Issues 2 and BugH081603 of IntelliCredApp V14.1 History Issues
//n_cst_dashboard inv_dashb
//inv_dashb = Create n_cst_dashboard
//inv_dashb.of_report_data_filter(dw_content, "dashboard_gadgets_favorite_favorite_type", "dashboard_gadgets_favorite_data_id")
//if isvalid(inv_dashb) then destroy inv_dashb
////---------End Modfiied ------------------------------------------------------


end event

type dw_content from u_cst_gadget_favorite_master`dw_content within u_cst_gadget_favorite_reports
string dataobject = "d_dashb_gadget_favorite_reports"
end type

event dw_content::retrieveend;call super::retrieveend;//---------Begin Modified by (Appeon)Harry 11.20.2013 for V141 ISG-CLX--------
//for BugH111901 of IntelliCredApp V14.1 History Issues 2 and BugH081603 of IntelliCredApp V14.1 History Issues
n_cst_dashboard inv_dashb
inv_dashb = Create n_cst_dashboard
inv_dashb.of_report_data_filter(dw_content, "dashboard_gadgets_favorite_favorite_type", "dashboard_gadgets_favorite_data_id")
if isvalid(inv_dashb) then destroy inv_dashb
//---------End Modfiied ------------------------------------------------------

end event

type ln_split from u_cst_gadget_favorite_master`ln_split within u_cst_gadget_favorite_reports
end type

type st_1 from u_cst_gadget_favorite_master`st_1 within u_cst_gadget_favorite_reports
end type

type st_title from u_cst_gadget_favorite_master`st_title within u_cst_gadget_favorite_reports
end type

type pb_close from u_cst_gadget_favorite_master`pb_close within u_cst_gadget_favorite_reports
end type

type pb_max from u_cst_gadget_favorite_master`pb_max within u_cst_gadget_favorite_reports
end type

type pb_edit from u_cst_gadget_favorite_master`pb_edit within u_cst_gadget_favorite_reports
end type

