$PBExportHeader$pfc_cst_u_tabpg_wv_audit_email.sru
forward
global type pfc_cst_u_tabpg_wv_audit_email from u_base
end type
type cb_run from u_cb within pfc_cst_u_tabpg_wv_audit_email
end type
type rb_sent from u_rb within pfc_cst_u_tabpg_wv_audit_email
end type
type rb_not_sent from u_rb within pfc_cst_u_tabpg_wv_audit_email
end type
type cb_1 from u_cb within pfc_cst_u_tabpg_wv_audit_email
end type
type rb_reject from u_rb within pfc_cst_u_tabpg_wv_audit_email
end type
type rb_accept from u_rb within pfc_cst_u_tabpg_wv_audit_email
end type
type dw_emails from u_dw within pfc_cst_u_tabpg_wv_audit_email
end type
type cb_reset from commandbutton within pfc_cst_u_tabpg_wv_audit_email
end type
type dw_date_range from u_dw within pfc_cst_u_tabpg_wv_audit_email
end type
type gb_2 from groupbox within pfc_cst_u_tabpg_wv_audit_email
end type
type gb_1 from groupbox within pfc_cst_u_tabpg_wv_audit_email
end type
type gb_3 from groupbox within pfc_cst_u_tabpg_wv_audit_email
end type
end forward

global type pfc_cst_u_tabpg_wv_audit_email from u_base
integer width = 4489
integer height = 2028
long backcolor = 33551856
event ue_selectionchanged ( )
event ue_facility_filter_changed ( long al_facility_id )
cb_run cb_run
rb_sent rb_sent
rb_not_sent rb_not_sent
cb_1 cb_1
rb_reject rb_reject
rb_accept rb_accept
dw_emails dw_emails
cb_reset cb_reset
dw_date_range dw_date_range
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
end type
global pfc_cst_u_tabpg_wv_audit_email pfc_cst_u_tabpg_wv_audit_email

type variables
Long ii_facility_id_filter
w_audit_trail_wv lw_parent
end variables

forward prototypes
public function integer of_select_all (boolean ab_select)
public function integer of_send_email ()
public subroutine of_set_facility_id (long al_facility_id)
public function integer of_filter_by_facility ()
public function long of_retrieve ()
end prototypes

event ue_selectionchanged();//====================================================================
//$<Event>: ue_selectionchanged
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Called by selectionchanged event of parent tab.
//$<Author>: (Appeon) long.zhang 06.29.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.of_retrieve()
end event

event ue_facility_filter_changed(long al_facility_id);//====================================================================
//$<Event>: ue_facility_filter_changed
//$<Arguments>:
// 	value    long    al_facility_id
//$<Return>:  (None)
//$<Description>: Called by facility filter control in parent window.
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.of_set_facility_id( al_facility_id)

This.of_filter_by_facility()
end event

public function integer of_select_all (boolean ab_select);//====================================================================
//$<Function>: of_select_all
//$<Arguments>:
// 	value    boolean    ab_select
//$<Return>:  integer
//$<Description>: select all records in dw_emails
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_row

If dw_emails.rowcount() < 1 Then return 0

If ab_select Then//Show Deselect All button
	dw_emails.modify('b_select_all.visible = 0')
	dw_emails.modify('b_deselect_all.visible = 1')
Else
	//Show Deselect All button
	dw_emails.modify('b_select_all.visible = 1')
	dw_emails.modify('b_deselect_all.visible = 0')
End If

for ll_row = 1 to dw_emails.rowcount()
	If ab_select Then
		dw_emails.setitem(ll_row, "select_flag", 1)
	Else
		dw_emails.setitem(ll_row, "select_flag", 0)
	End If
next

return 0

end function

public function integer of_send_email ();//====================================================================
//$<Function>: of_send_email
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Send email
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_prac_ids[]
Long ll_ae_ids[]
Long i, ll_cnt
Long ll_email_cnt
Long ll_facility_id
Long ll_rtn
String ls_accept_reject

ll_cnt = dw_emails.RowCount()
If ll_cnt = 0 Then Return 0

//Check facility
If ii_facility_id_filter = 0 Then
	Messagebox('Prompt', 'Please select a facility in Facility Filter before sending email.')
	lw_parent.dw_select.SetFocus()
	Return 0
Else
	ll_facility_id = ii_facility_id_filter
End If

//Check selected records
For i =1 to ll_cnt
	If dw_emails.GetItemNumber(i,'select_flag') = 1 Then
		ll_email_cnt++
	End If
Next
If ll_email_cnt = 0 Then
	Messagebox('Prompt', 'Please select at least one record before sending email.') //add 'select' word, modified by Appeon long.zhang 07.31.2017 (BugS072402)
	Return 0
End If

//Accept or Reject
If rb_accept.checked Then
	ls_accept_reject = 'A'
Else
	ls_accept_reject = 'R'
End If

//Send Emails:
//	select email template
//	Prepare email data d_wv_audit_accept_reject_email.
//	send email
//	update wv.audit_email.sent_status/sent_user/sent_date/facility_id
ll_rtn = lw_parent.inv_wv_audit_email.of_send( ls_accept_reject, ll_facility_id, dw_emails)

//4.Refresh dw_email
If ll_rtn <> 0 Then //0 means canceled.
	of_retrieve()
End If

If ll_rtn > 0 Then
	Messagebox('Send Email',  "Processing Completed.")
End If

Return 1
end function

public subroutine of_set_facility_id (long al_facility_id);//====================================================================
//$<Function>: of_set_facility_id
//$<Arguments>:
// 	value    long    al_facility_id
//$<Return>:  (None)
//$<Description>: Set ii_facility_id_filter, called by ue_facility_filter_changed() event.
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ii_facility_id_filter = al_facility_id
end subroutine

public function integer of_filter_by_facility ();//====================================================================
//$<Function>: of_filter_by_facility
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Filter by facility
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Return lw_parent.of_filter_by_facility(dw_emails)

end function

public function long of_retrieve ();//====================================================================
//$<Function>: of_retrieve
//$<Arguments>:
//$<Return>:  long
//$<Description>: Retrieve details
//$<Author>: (Appeon) long.zhang 07.31.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return dw_emails.of_retrieve()
end function

on pfc_cst_u_tabpg_wv_audit_email.create
int iCurrent
call super::create
this.cb_run=create cb_run
this.rb_sent=create rb_sent
this.rb_not_sent=create rb_not_sent
this.cb_1=create cb_1
this.rb_reject=create rb_reject
this.rb_accept=create rb_accept
this.dw_emails=create dw_emails
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_run
this.Control[iCurrent+2]=this.rb_sent
this.Control[iCurrent+3]=this.rb_not_sent
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.rb_reject
this.Control[iCurrent+6]=this.rb_accept
this.Control[iCurrent+7]=this.dw_emails
this.Control[iCurrent+8]=this.cb_reset
this.Control[iCurrent+9]=this.dw_date_range
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_3
end on

on pfc_cst_u_tabpg_wv_audit_email.destroy
call super::destroy
destroy(this.cb_run)
destroy(this.rb_sent)
destroy(this.rb_not_sent)
destroy(this.cb_1)
destroy(this.rb_reject)
destroy(this.rb_accept)
destroy(this.dw_emails)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event constructor;call super::constructor;//Get Parent window
This.of_getparentwindow( lw_parent)
end event

type cb_run from u_cb within pfc_cst_u_tabpg_wv_audit_email
integer x = 3630
integer y = 64
integer width = 370
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Retrieve"
boolean default = true
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 06.30.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Parent.of_retrieve()
end event

type rb_sent from u_rb within pfc_cst_u_tabpg_wv_audit_email
integer x = 2811
integer y = 80
integer width = 206
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Sent"
end type

event clicked;call super::clicked;Parent.of_retrieve()
end event

type rb_not_sent from u_rb within pfc_cst_u_tabpg_wv_audit_email
integer x = 2491
integer y = 80
integer width = 375
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Not Sent"
boolean checked = true
end type

event clicked;call super::clicked;Parent.of_retrieve()
end event

type cb_1 from u_cb within pfc_cst_u_tabpg_wv_audit_email
integer x = 4064
integer y = 64
integer width = 370
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Send Email"
end type

event clicked;call super::clicked;of_send_email()
end event

type rb_reject from u_rb within pfc_cst_u_tabpg_wv_audit_email
integer x = 498
integer y = 68
integer width = 343
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Rejection"
end type

event clicked;call super::clicked;Parent.of_retrieve()
end event

type rb_accept from u_rb within pfc_cst_u_tabpg_wv_audit_email
integer x = 87
integer y = 68
integer width = 375
integer height = 68
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Acceptance"
boolean checked = true
end type

event clicked;call super::clicked;Parent.of_retrieve()
end event

type dw_emails from u_dw within pfc_cst_u_tabpg_wv_audit_email
integer x = 32
integer y = 192
integer width = 4407
integer height = 1808
integer taborder = 30
string dataobject = "d_wv_audit_email_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setTransobject(SQLCA)
This.of_setrowselect( True)
end event

event pfc_retrieve;call super::pfc_retrieve;//====================================================================
//$<Event>: pfc_retrieve
//$<Arguments>:
//$<Return>:  long
//$<Description>: Retreve conditions, called by of_retrieve()
//$<Author>: (Appeon) long.zhang 06.30.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_accept_reject
DateTime ldt_start,ldt_end
Int li_sent_status
Long ll_rtn

//accept_reject
If rb_accept.Checked Then
	ls_accept_reject = 'A'
Else
	ls_accept_reject = 'R'
End If

//Create date
if dw_date_range.accepttext() = -1 then return -1
ldt_start = DateTime((dw_date_range.GetItemDate(1, 'from_date')), Time('00:00:00'))
ldt_end = DateTime((dw_date_range.GetItemDate(1, 'to_date')), Time('23:59:59'))

//Sent Status
If rb_not_sent.checked Then
	li_sent_status = 0
Else
	li_sent_status = 1
End If

//Retrieve
ll_rtn = This.Retrieve(gs_user_id, ls_accept_reject, ldt_start, ldt_end, li_sent_status)

//Filter by facility
of_filter_by_facility()

Return ll_rtn
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.01.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
int i

//button
If dwo.name ='b_select_all' or dwo.name ='b_deselect_all' Then
	i = of_select_all((dwo.name ='b_select_all'))
End If
end event

type cb_reset from commandbutton within pfc_cst_u_tabpg_wv_audit_email
integer x = 2144
integer y = 60
integer width = 183
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re&set"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Initiate date
//$<Author>: (Appeon) long.zhang 06.29.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )

dw_date_range.setitem(1,'from_date', RelativeDate ( today(), -1 ))
dw_date_range.setitem(1,'to_date', today())

end event

type dw_date_range from u_dw within pfc_cst_u_tabpg_wv_audit_email
integer x = 992
integer y = 76
integer width = 1166
integer height = 80
integer taborder = 20
string dataobject = "d_faxlog_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 06.29.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.of_setupdateable(False)
this.settransobject(sqlca)

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
dw_date_range.of_setupdateable(false) 

this.insertrow(1)
this.setitem(1,'from_date', RelativeDate ( today(), -1 ))
this.setitem(1,'to_date', today())






end event

type gb_2 from groupbox within pfc_cst_u_tabpg_wv_audit_email
integer x = 978
integer y = 20
integer width = 1362
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Create Date"
end type

type gb_1 from groupbox within pfc_cst_u_tabpg_wv_audit_email
integer x = 37
integer y = 16
integer width = 827
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Email Type"
end type

type gb_3 from groupbox within pfc_cst_u_tabpg_wv_audit_email
integer x = 2459
integer y = 24
integer width = 571
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Sent Status"
end type

