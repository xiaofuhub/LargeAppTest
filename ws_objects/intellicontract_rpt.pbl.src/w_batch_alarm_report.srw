$PBExportHeader$w_batch_alarm_report.srw
forward
global type w_batch_alarm_report from w_response
end type
type cb_output from commandbutton within w_batch_alarm_report
end type
type cb_sort from commandbutton within w_batch_alarm_report
end type
type cb_setup from commandbutton within w_batch_alarm_report
end type
type cb_print from commandbutton within w_batch_alarm_report
end type
type cb_close from commandbutton within w_batch_alarm_report
end type
type dw_report from u_dw within w_batch_alarm_report
end type
type cb_export from commandbutton within w_batch_alarm_report
end type
end forward

global type w_batch_alarm_report from w_response
integer width = 4142
integer height = 2336
string title = "Unset Alarm Report"
long backcolor = 33551856
cb_output cb_output
cb_sort cb_sort
cb_setup cb_setup
cb_print cb_print
cb_close cb_close
dw_report dw_report
cb_export cb_export
end type
global w_batch_alarm_report w_batch_alarm_report

type variables
str_pass istr_pass
end variables

forward prototypes
public subroutine of_show_report ()
end prototypes

public subroutine of_show_report ();
end subroutine

on w_batch_alarm_report.create
int iCurrent
call super::create
this.cb_output=create cb_output
this.cb_sort=create cb_sort
this.cb_setup=create cb_setup
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_report=create dw_report
this.cb_export=create cb_export
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_output
this.Control[iCurrent+2]=this.cb_sort
this.Control[iCurrent+3]=this.cb_setup
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_report
this.Control[iCurrent+7]=this.cb_export
end on

on w_batch_alarm_report.destroy
call super::destroy
destroy(this.cb_output)
destroy(this.cb_sort)
destroy(this.cb_setup)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_report)
destroy(this.cb_export)
end on

event open;call super::open;If isvalid(Message.powerobjectparm) Then
	istr_pass = Message.powerobjectparm
Else
	Messagebox('Error','Failed to get data, please call support')
	Return -1
End If

end event

event pfc_postopen;call super::pfc_postopen;//====================================================================
// Event: pfc_postopen
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/03/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long ll_row, i, ll_cnt
String ls_category
u_dw ldw_search

//Set Report UI - Visible
If UpperBound(istr_pass.s_string_array[]) > 0 Then
	Choose Case Lower(istr_pass.s_string_array[1]) 
		Case 'ctx_basic_info', 'ctx_custom'
			dw_report.Modify('doc_id.visible = 0 level_id1.visible = 0 level_id2.visible = 0 ')
		Case 'ctx_am_action_item'
			dw_report.Modify('doc_id.visible = 1 level_id1.visible = 1 level_id2.visible = 0 ')	
			dw_report.Modify('level_id1_t.text = "Seq_ID" ')	
		Case 'ctx_action_item'
			dw_report.Modify('doc_id.visible = 0 level_id1.visible = 0 level_id2.visible = 0 ')
			dw_report.Modify('level_id1_t.text = "ActionItem_ID" ')	
		Case 'ctx_custom_multi_hdr'
			dw_report.Modify('doc_id.visible = 0 level_id1.visible = 1  level_id2.visible = 0 ')	
			dw_report.Modify('level_id1_t.text = "Header_ID"')	
		Case 'ctx_custom_multi_detail'
			dw_report.Modify('doc_id.visible = 0 level_id1.visible = 1 level_id2.visible = 1 ')	
			dw_report.Modify('level_id1_t.text = "Header_ID" level_id2_t.text = "Detail_ID"')	
		Case 'ctx_fee_sched_nm'
			dw_report.Modify('doc_id.visible = 0 level_id1.visible = 1 level_id2.visible = 0 ')
			dw_report.Modify('level_id1_t.text = "FeeNM_ID" ')
	End Choose
End If

//Set Report UI - Text
If isvalid(gw_contract) Then
	If IsValid(gw_contract.tab_contract_details.tabpage_search.dw_search_det1) Then
		ldw_search = gw_contract.tab_contract_details.tabpage_search.dw_search_det1
		If ldw_search.Describe( 'category_t.type' ) = 'text' Then
			If Len(ldw_search.Describe( 'category_t.text' )) > 1 Then
				dw_report.Modify('category_t.text = "' +ldw_search.Describe( 'category_t.text' )+ '"')
			End If
		End If
		If ldw_search.Describe( 'status_t.type' ) = 'text' Then
			If Len(ldw_search.Describe( 'status_t.text' )) > 1 Then
				dw_report.Modify('status_t.text = "' +ldw_search.Describe( 'status_t.text' )+ '"')
			End If
		End If
		If ldw_search.Describe( 'app_facility_t.type' ) = 'text' Then
			If Len(ldw_search.Describe( 'app_facility_t.text' )) > 1 Then
				dw_report.Modify('company_t.text = "' +ldw_search.Describe( 'app_facility_t.text' )+ '"')
			End If
		End If		
	End If
End If


//Retrieve Report
n_ds lds_unset_alarm_report
dw_report.SetRedraw(False)
Choose Case Lower(istr_pass.s_string_array[13])
	Case 'not' 
		dw_report.SetTransObject(SQLCA)
		dw_report.SetSQLselect( istr_pass.s_string_array[11] )
		dw_report.SetTransObject(SQLCA)
		dw_report.Retrieve()
		This.Title = 'Unset Alarms Report for ' + istr_pass.s_string_array[3]
	Case 'all'
		//Retrieve all alarms
		dw_report.SetTransObject(SQLCA)
		dw_report.SetSQLselect( istr_pass.s_string_array[12] )
		dw_report.SetTransObject(SQLCA)
		dw_report.Retrieve()
		//Retrieve not set alarms
		lds_unset_alarm_report = Create n_ds
		lds_unset_alarm_report.DataObject = 'd_batch_alarm_analysis_report'
		lds_unset_alarm_report.SetTransObject(SQLCA)
		lds_unset_alarm_report.SetSqlSelect(istr_pass.s_string_array[11])
		lds_unset_alarm_report.SetTransObject(SQLCA)		
		ll_cnt = lds_unset_alarm_report.Retrieve()
		For i = 1 To ll_cnt
			ll_row = dw_report.Find('ctx_id = ' + String(lds_unset_alarm_report.GetItemNumber(i, 'ctx_id'))  +&
										' and doc_id = ' + String( lds_unset_alarm_report.GetItemNumber(i, 'doc_id') )  +&
										' and level_id1 = ' + String( lds_unset_alarm_report.GetItemNumber(i, 'level_id1')  ) +&
										' and level_id2 = ' + String( lds_unset_alarm_report.GetItemNumber(i, 'level_id2') ) , 1,dw_report.rowcount()  )
			If ll_row > 0 Then
				dw_report.SetItem(ll_row, 'alarm_exists',0)
			End If
		Next
		lds_unset_alarm_report.Sort()
		This.Title = 'Alarms Report for ' + istr_pass.s_string_array[3]
		If isvalid(lds_unset_alarm_report) Then Destroy lds_unset_alarm_report
	Case 'ds' //pass result datastore
		This.Title = 'Alarms Report for Result' 
		dw_report.Modify('alarm_exists.visible = 0 result.visible = 1')
		istr_pass.s_ds.RowsCopy(1, istr_pass.s_ds.RowCount(),Primary!, dw_report, 1, Primary!)
End Choose

dw_report.SetRedraw(True)


end event

type cb_output from commandbutton within w_batch_alarm_report
integer x = 3301
integer y = 2088
integer width = 439
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Out&Put Options"
end type

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_report)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())
end event

type cb_sort from commandbutton within w_batch_alarm_report
boolean visible = false
integer x = 2446
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort..."
end type

event clicked;String ls_null

SetNull( ls_null )

dw_report.SetSort( ls_null )
dw_report.Sort()
dw_report.groupcalc()
end event

type cb_setup from commandbutton within w_batch_alarm_report
integer x = 2542
integer y = 2360
integer width = 352
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Print &Setup..."
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_setup::clicked()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-19 by Ken.Guo
//////////////////////////////////////////////////////////////////////

dw_report.SetRedraw(False)
dw_report.Modify("DataWindow.Print.Paper.Size= '0'") //Workaround APB's Bug
dw_report.Modify("datawindow.Print.Preview = 'No'")
dw_report.Modify("datawindow.Print.Preview.Rulers = 'No'")

PrintSetup ( )

dw_report.Modify("datawindow.Print.Preview = 'Yes'")
dw_report.Modify("datawindow.Print.Preview.Rulers = 'Yes'")
dw_report.SetRedraw(True)
end event

type cb_print from commandbutton within w_batch_alarm_report
integer x = 2935
integer y = 2360
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Print"
end type

event clicked;dw_report.Print()
end event

type cb_close from commandbutton within w_batch_alarm_report
integer x = 3762
integer y = 2088
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
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_report from u_dw within w_batch_alarm_report
event ue_syscommand pbm_syscommand
event ue_mail_current ( )
integer x = 27
integer y = 24
integer width = 4073
integer height = 2008
integer taborder = 20
string title = "Report Preview"
string dataobject = "d_batch_alarm_analysis_report"
boolean hscrollbar = true
end type

event ue_syscommand;if Message.WordParm = 61458 then 
	Message.Processed = true
	Message.ReturnValue = 0 
end if
end event

event ue_mail_current();long	ll_Rtn
ll_Rtn = EVENT ue_save_pdf_for_mailing( )
if ll_Rtn <> 0 then return

if of_get_app_setting("set_56","I") = 1 then
	Super::EVENT ue_mail_bak('Contract','' )
else
	Super::EVENT ue_mail('Contract','' )
end if
end event

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect( True )
This.of_SetRowManager(True)
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)

end event

type cb_export from commandbutton within w_batch_alarm_report
boolean visible = false
integer x = 2171
integer y = 2088
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export..."
end type

event clicked;gf_load_dir_path() 
String ls_file,ls_null
Setnull(ls_null)
ls_file = ''
If dw_report.SaveAs(ls_file,Excel5!,True) = 1 Then
	If FileExists(ls_file) Then
		ShellExecuteA(Handle(This),'open',ls_file,ls_null,ls_null,4)
	End If
End If
gf_save_dir_path(' ') 
end event

