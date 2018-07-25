$PBExportHeader$w_email_audit.srw
forward
global type w_email_audit from w_sheet
end type
type cb_saveas from commandbutton within w_email_audit
end type
type cb_close from commandbutton within w_email_audit
end type
type tab_1 from tab within w_email_audit
end type
type tabpage_browse from u_tabpg_email_audit_browse within tab_1
end type
type tabpage_browse from u_tabpg_email_audit_browse within tab_1
end type
type tabpage_detail from u_tabpg_email_audit_detail within tab_1
end type
type tabpage_detail from u_tabpg_email_audit_detail within tab_1
end type
type tab_1 from tab within w_email_audit
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
end forward

global type w_email_audit from w_sheet
integer width = 3959
integer height = 2592
string title = "Sent Emails Log"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event ue_show_detail ( )
cb_saveas cb_saveas
cb_close cb_close
tab_1 tab_1
end type
global w_email_audit w_email_audit

type variables
str_pass istr_pass
Boolean ib_report_mode = False, ib_alarm_report = False
end variables

event ue_show_detail();Tab_1.Selecttab(2)
end event

on w_email_audit.create
int iCurrent
call super::create
this.cb_saveas=create cb_saveas
this.cb_close=create cb_close
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_saveas
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.tab_1
end on

on w_email_audit.destroy
call super::destroy
destroy(this.cb_saveas)
destroy(this.cb_close)
destroy(this.tab_1)
end on

event pfc_preopen;call super::pfc_preopen;integer i

If isvalid(Message.powerobjectparm) Then
	istr_pass = Message.powerobjectparm
	
	If istr_pass.s_string <> '' Then //Added By Ken.Guo 12/26/2012. Support alarm report.
		ib_alarm_report = True
	Else
		ib_report_mode = True
	End If
End If

this.of_SetResize(true)
this.inv_resize.of_setorigsize(3950, 2512)
for i =  1 to UpperBound(this.Control)
	this.inv_resize.of_Register(this.Control[i], this.inv_resize.scale)
next

tab_1.tabpage_browse.dw_browse.ShareData(tab_1.tabpage_detail.dw_1 )



end event

event open;call super::open;DatawindowChild ldwc_email_search,ldwc_email_browse,ldwc_email_detail
DatawindowChild ldwc_wf_search,ldwc_wf_browse,ldwc_wf_detail
DatawindowChild ldwc_email_type,ldwc_company,ldwc_user_id,ldwc_pc_info

Tab_1.tabpage_browse.dw_search.GetChild('compute_info',ldwc_pc_info)
Tab_1.tabpage_browse.dw_search.GetChild('user_id',ldwc_user_id)

Tab_1.tabpage_browse.dw_search.GetChild('mail_template_id',ldwc_email_search)
Tab_1.tabpage_browse.dw_browse.GetChild('mail_template_id',ldwc_email_browse)
Tab_1.tabpage_detail.dw_1.GetChild('mail_template_id',ldwc_email_detail)

Tab_1.tabpage_browse.dw_search.GetChild('wf_id',ldwc_wf_search)
Tab_1.tabpage_browse.dw_browse.GetChild('wf_id',ldwc_wf_browse)
Tab_1.tabpage_detail.dw_1.GetChild('wf_id',ldwc_wf_detail)

Tab_1.tabpage_browse.dw_search.GetChild('alarm_type',ldwc_email_type)
Tab_1.tabpage_browse.dw_search.GetChild('company_name',ldwc_company)


ldwc_email_search.SetTransObject(SQLCA)
ldwc_email_browse.SetTransObject(SQLCA)
ldwc_email_detail.SetTransObject(SQLCA)
ldwc_wf_search.SetTransObject(SQLCA)
ldwc_wf_browse.SetTransObject(SQLCA)
ldwc_wf_detail.SetTransObject(SQLCA)
ldwc_email_type.SetTransObject(SQLCA)
ldwc_company.SetTransObject(SQLCA)
ldwc_user_id.SetTransObject(SQLCA)
ldwc_pc_info.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ldwc_email_search.Retrieve()
	ldwc_wf_search.Retrieve()
	ldwc_email_type.Retrieve()
	ldwc_company.Retrieve('all')
	ldwc_user_id.Retrieve()
	ldwc_pc_info.Retrieve()
gnv_appeondb.of_commitqueue( )

ldwc_email_search.ShareData(ldwc_email_browse)
ldwc_email_search.ShareData(ldwc_email_detail)
ldwc_wf_search.ShareData(ldwc_wf_browse)
ldwc_wf_search.ShareData(ldwc_wf_detail)

If ib_report_mode Then
	Tab_1.tabpage_browse.Dynamic Event ue_report(istr_pass.l_facility_id)
End If

//Added By Ken.Guo 12/26/2012
If ib_alarm_report Then
	Tab_1.tabpage_browse.Dynamic Event ue_report_alarm(istr_pass.s_string )
	This.Title = istr_pass.s_string_array[1] 
End IF


end event

type cb_saveas from commandbutton within w_email_audit
integer x = 3232
integer y = 2396
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export..."
end type

event clicked;//tab_1.tabpage_browse.dynamic Event ue_export()

//Modified By Ken.Guo 2011-05-24. workaround PB's bug
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(tab_1.tabpage_browse.dw_browse)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.visible = False
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())
end event

type cb_close from commandbutton within w_email_audit
integer x = 3584
integer y = 2396
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_email_audit
integer width = 3945
integer height = 2468
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
tabposition tabposition = tabsonbottom!
alignment alignment = center!
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

event selectionchanged;long ll_row

If newindex = 1 Then
	ll_row = tabpage_detail.dw_1.GetRow()
	tabpage_browse.dw_browse.ScrollToRow(ll_row)
	tabpage_browse.dw_browse.SetRow(ll_row)	
	tabpage_detail.dw_1.SetFocus()
ElseIf newindex = 2 Then
	ll_row = tabpage_browse.dw_browse.GetRow()
	tabpage_detail.dw_1.ScrollToRow(ll_row)
	tabpage_detail.dw_1.SetRow(ll_row)	
	tabpage_browse.dw_browse.SetFocus()
End If


end event

type tabpage_browse from u_tabpg_email_audit_browse within tab_1
string tag = "Browse"
integer x = 18
integer y = 16
integer width = 3909
integer height = 2340
string text = "Browse"
string picturename = "custom065!"
end type

type tabpage_detail from u_tabpg_email_audit_detail within tab_1
string tag = "Detail"
integer x = 18
integer y = 16
integer width = 3909
integer height = 2340
string text = "Detail "
string picturename = "custom100!"
boolean ib_isupdateable = false
end type

