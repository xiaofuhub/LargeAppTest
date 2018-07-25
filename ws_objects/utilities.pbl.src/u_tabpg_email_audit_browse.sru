$PBExportHeader$u_tabpg_email_audit_browse.sru
forward
global type u_tabpg_email_audit_browse from u_tabpg
end type
type dw_search from u_dw within u_tabpg_email_audit_browse
end type
type dw_browse from u_dw within u_tabpg_email_audit_browse
end type
end forward

global type u_tabpg_email_audit_browse from u_tabpg
integer width = 3918
integer height = 2344
long backcolor = 33551856
event ue_filter ( )
event ue_report ( long al_id )
event ue_export ( )
event ue_report_alarm ( string as_where )
dw_search dw_search
dw_browse dw_browse
end type
global u_tabpg_email_audit_browse u_tabpg_email_audit_browse

type variables
Boolean ib_retrieved = False
//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
//String is_sql_org
String is_sql_org, is_ext_where
//---------End Modfiied ------------------------------------------------------

end variables

forward prototypes
public subroutine of_filter ()
public function integer of_disable_ctx_flds ()
end prototypes

event ue_filter();
dw_browse.SetRedraw(False)

//Filter Data
of_filter()

dw_browse.title = 'Email Browse (' + String(dw_browse.RowCount()) + ')'
dw_browse.SetRedraw(True)
Return 
end event

event ue_report(long al_id);String ls_where

//Reset UI
dw_search.hide( )
dw_browse.Move(0,0)
dw_browse.Height = Height - 20

//Build SQL
ls_where = ' Where 1 = 1 '
ls_where += " And em_mail_audit.user_id = '" + gs_user_id + "'"
If Not isnull(al_id) Then
	ls_where += " And em_mail_audit.id > " + String(al_id ) + " " 
End If

//Retrieve Data
dw_browse.SetRedraw(False)
dw_browse.SetSQLSelect(is_sql_org + ls_where)
dw_browse.Settransobject(SQLCA)
If dw_browse.Retrieve() = -1 Then
	Messagebox('Error','Failed to retrieve the data. Please call support.~r~n~r~n' + is_sql_org+ls_where)
End If
dw_browse.title = 'Email Browse (' + String(dw_browse.RowCount()) + ')'
dw_browse.SetRedraw(True)

Return 
end event

event ue_export();gf_load_dir_path() 
String ls_file,ls_null
Setnull(ls_null)
ls_file = ''

If dw_browse.SaveAs(ls_file,Excel5!,True) = 1 Then
	If FileExists(ls_file) Then
		ShellExecuteA(Handle(This),'open',ls_file,ls_null,ls_null,4)
	End If
Else
	//Messagebox('Error','Failed to export data.')
End If

gf_save_dir_path(' ') 
end event

event ue_report_alarm(string as_where);// (Appeon)Harry 03.13.2014 - V142 ISG-CLX Copy from CLX12.0
String ls_where

//Reset UI
dw_search.hide( )
dw_browse.Move(0,0)
dw_browse.Height = Height - 20

//Retrieve Data
dw_browse.SetRedraw(False)
dw_browse.SetSQLSelect(is_sql_org + as_where)
dw_browse.Settransobject(SQLCA)
If dw_browse.Retrieve() = -1 Then
	Messagebox('Error','Failed to retrieve the data. Please call support.~r~n~r~n' + is_sql_org+ls_where)
End If
dw_browse.title = 'Email Browse (' + String(dw_browse.RowCount()) + ')'
dw_browse.SetRedraw(True)

Return
end event

public subroutine of_filter ();String ls_where
String ls_user_id, ls_mail_from,ls_mail_to,ls_errtext,ls_compute_info
String ls_subject,ls_fieldname, ls_company,ls_notes,ls_ctx_id,ls_email_type
Datetime ldt_datefrom,ldt_dateto
Integer li_sendresult
Long li_wf_id,ll_email_id

dw_search.Accepttext( )
ls_user_id = dw_search.GetItemString(1,'user_id')
ls_mail_from = dw_search.GetItemString(1,'mail_from')
ls_mail_to = dw_search.GetItemString(1,'mail_to')
ldt_datefrom = dw_search.GetItemDatetime(1,'date_from')
ldt_dateto = dw_search.GetItemDatetime(1,'date_to')
li_sendresult = dw_search.GetItemNumber(1,'send_result')
ls_errtext = dw_search.GetItemString(1,'error_text')
ls_subject = dw_search.GetItemString(1,'mail_subject')
li_wf_id = dw_search.GetItemNumber(1,'wf_id')
ls_fieldname = dw_search.GetItemString(1,'field_name')
ls_ctx_id = dw_search.GetItemString(1,'ctx_id_list')
ls_company = dw_search.GetItemString(1,'company_name')
ls_notes = dw_search.GetItemString(1,'notes')
ls_email_type = dw_search.GetItemString(1,'alarm_type')
ll_email_id = dw_search.GetItemNumber(1,'mail_template_id')
ls_compute_info = dw_search.GetItemString(1,'compute_info') 


ls_where = ' Where 1 = 1 '
If ls_user_id <> '' and Not isnull(ls_user_id) Then
	ls_where += " And em_mail_audit.user_id = '" + ls_user_id + "'"
End If

If ls_mail_from <> '' and Not isnull(ls_mail_from) Then
	ls_where += " And CharIndex('" + ls_mail_from + "', em_mail_audit.mail_from) > 0 "
End If

If ls_mail_to <> '' and Not isnull(ls_mail_to) Then
	ls_where += " And CharIndex('" + ls_mail_to + "', em_mail_audit.mail_to) > 0 "
End If

If Not isnull(li_sendresult) Then
	ls_where += " And em_mail_audit.send_result = " + String(li_sendresult ) + " " 
End If

If ls_errtext <> '' and Not isnull(ls_errtext) Then
	ls_where += " And CharIndex('" + ls_errtext + "', em_mail_audit.error_text) > 0 "
End If

If ls_subject <> '' and Not isnull(ls_subject) Then
	ls_where += " And CharIndex('" + ls_subject + "', em_mail_audit.mail_subject) > 0 "
End If

If Not isnull(li_wf_id) Then
	ls_where += " And em_mail_audit.wf_id = " + String(li_wf_id ) + " " 
End If

If ls_fieldname <> '' and Not isnull(ls_fieldname) Then
	ls_where += " And CharIndex('" + ls_fieldname + "', em_mail_audit.field_name) > 0 "
End If

If ls_ctx_id <> '' and Not isnull(ls_ctx_id) Then
	ls_where += " And CharIndex('" + ls_ctx_id + "', em_mail_audit.ctx_id_list) > 0 "
End If

If ls_company <> '' and Not isnull(ls_company) Then
	ls_where += " And (CharIndex('" + ls_company + "', app_facility.facility_name) > 0 or  " + " CharIndex('" + ls_company + "', em_mail_audit.notes) > 0 )"
End If

If ls_notes <> '' and Not isnull(ls_notes) Then
	ls_where += " And CharIndex('" + ls_notes + "', em_mail_audit.notes) > 0 "
End If

If Not isnull(ldt_datefrom) Then
	ls_where += " And mail_date >= Convert(Datetime,'" + String(ldt_datefrom,"yyyy-mm-dd") + " 00:00:00') " 
End If

If Not isnull(ldt_dateto) Then
	ls_where += " And mail_date <= Convert(Datetime,'" + String(ldt_dateto,"yyyy-mm-dd") + " 23:59:59') " 
End If

If ls_email_type <> '' and Not isnull(ls_email_type) Then
	ls_where += " And CharIndex('" + ls_email_type + "', em_mail_audit.alarm_type) > 0 "
End If

If Not isnull(ll_email_id) Then
	ls_where += " And em_mail_audit.mail_template_id = " + String(ll_email_id ) + " " 
End If

If ls_compute_info <> '' and Not isnull(ls_compute_info) Then
	ls_where += " And CharIndex('" + ls_compute_info + "', em_mail_audit.compute_info) > 0 "
End If

If Not isnull(ldt_datefrom) and Not isnull(ldt_dateto) and ldt_datefrom > ldt_dateto Then
	Messagebox('Search','Date To can not be less than Date From.',Exclamation!)
	Return
End If

//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
//dw_browse.SetSQLSelect(is_sql_org + ls_where)
dw_browse.SetSQLSelect(is_sql_org + ls_where + is_ext_where )
//---------End Modfiied ------------------------------------------------------
dw_browse.Settransobject(SQLCA)
If dw_browse.Retrieve() = -1 Then
	Messagebox('Error','Failed to retrieve the data. Please call support.~r~n~r~n' + is_sql_org+ls_where)
End If


Return
end subroutine

public function integer of_disable_ctx_flds ();//====================================================================
//$<Function>: of_disable_ctx_flds()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Disable ctx fields
//$<Author>: (Appeon) Eugene 09.23.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:for BugA082002 
//====================================================================

IF dw_search.Describe("field_name.ColType") <> "!" THEN
	dw_search.Modify("field_name.Protect=1")
	dw_search.Modify("field_name.Background.Color='553648127'")
END IF

IF dw_search.Describe("ctx_id_list.ColType") <> "!" THEN
	dw_search.Modify("ctx_id_list.Protect=1")
	dw_search.Modify("ctx_id_list.Background.Color='553648127'")
END IF

IF dw_search.Describe("company_name.ColType") <> "!" THEN
	dw_search.Modify("company_name.Protect=1")
	dw_search.Modify("company_name.Background.Color='553648127'")
END IF

IF dw_search.Describe("alarm_type.ColType") <> "!" THEN
	dw_search.Modify("alarm_type.Protect=1")
	dw_search.Modify("alarm_type.Background.Color='553648127'")
END IF

RETURN 1
end function

on u_tabpg_email_audit_browse.create
int iCurrent
call super::create
this.dw_search=create dw_search
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_search
this.Control[iCurrent+2]=this.dw_browse
end on

on u_tabpg_email_audit_browse.destroy
call super::destroy
destroy(this.dw_search)
destroy(this.dw_browse)
end on

type dw_search from u_dw within u_tabpg_email_audit_browse
integer width = 3909
integer height = 792
integer taborder = 10
boolean titlebar = true
string title = "Search Criteria"
string dataobject = "d_email_audit_search"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;This.InsertRow(0)
This.of_setupdateable(False)
This.Post of_setdropdowncalendar(True)

IF NOT gb_contract_module THEN	of_disable_ctx_flds ()  //for BugA082002  - (Appeon) Eugene 09.23.2013 (V141 ISG-CLX) 
end event

event buttonclicked;call super::buttonclicked;Choose Case dwo.name 
	Case 'b_clear'
		dw_search.Reset()
		dw_search.InsertRow(0)
	Case 'b_search'
		Parent.Dynamic Event ue_filter()
End Choose

end event

event ue_key;call super::ue_key;If Key = Keyenter! Then
	Parent.Dynamic Event ue_filter()
End If
end event

type dw_browse from u_dw within u_tabpg_email_audit_browse
integer y = 800
integer width = 3909
integer height = 1536
integer taborder = 10
boolean titlebar = true
string title = "Email Browse"
string dataobject = "d_email_audit_browse"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.Modify("Datawindow.readonly = Yes")

this.of_SetSort(true)
This.inv_sort.of_SetColumnHeader(true)

This.SetTransObject(SQLCA)
is_sql_org = This.GetSQLSelect()


end event

event doubleclicked;call super::doubleclicked;iw_parent.Dynamic Event ue_show_detail()
end event

