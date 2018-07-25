$PBExportHeader$w_ctx_search_print.srw
forward
global type w_ctx_search_print from w_response
end type
type st_1 from statictext within w_ctx_search_print
end type
type cb_output from commandbutton within w_ctx_search_print
end type
type cb_sort from commandbutton within w_ctx_search_print
end type
type cb_setup from commandbutton within w_ctx_search_print
end type
type cb_print from commandbutton within w_ctx_search_print
end type
type cb_close from commandbutton within w_ctx_search_print
end type
type cb_export from commandbutton within w_ctx_search_print
end type
type dw_report from u_dw within w_ctx_search_print
end type
end forward

global type w_ctx_search_print from w_response
integer width = 4014
integer height = 2336
string title = "Contract Search Report"
long backcolor = 33551856
st_1 st_1
cb_output cb_output
cb_sort cb_sort
cb_setup cb_setup
cb_print cb_print
cb_close cb_close
cb_export cb_export
dw_report dw_report
end type
global w_ctx_search_print w_ctx_search_print

type variables
str_print_search_dw istr_search
end variables

forward prototypes
public subroutine of_show_report ()
public function integer of_gen_report ()
end prototypes

public subroutine of_show_report ();
end subroutine

public function integer of_gen_report ();String ls_objects_string,ls_hide_columns_string
String ls_objects_all[]
String ls_default,ls_sql,ls_syntax,ls_err,ls_mask,ls_format
Long i,j,ll_columns_x[],ll_row_cnt,ll_row,ll_step
String ls_coltype,ls_value
Datetime ldt_null

Setnull(ldt_null)
n_cst_string_appeon lnv_string
DataStore lds_report

SetPointer(HourGlass!)
This.SetRedraw(False)
If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Generating Report Data...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(10)
End If

//Gen column list for SQL
For i = 1 To UpperBound(istr_search.col_name[])
	ls_default = Space(istr_search.col_length[i])
	
	If Left(Lower(istr_search.col_type[i]), 4) = 'date' Then //Added By Ken.Guo 04/19/2012. add date column for format
		If i = 1 Then
			ls_sql = istr_search.col_name[i] + " = getdate()"
		Else
			ls_sql += "~r~n , " + istr_search.col_name[i] + " = getdate()"
		End If
	Else
		If i = 1 Then
			ls_sql = istr_search.col_name[i] + " = '" + ls_default + "'"
		Else
			ls_sql += "~r~n , " + istr_search.col_name[i] + " = '" + ls_default + "'"
		End If
	End If
Next

//Create Report datawindow with any table name
ls_sql = 'Select ~r~n' + ls_sql + '~r~n From ctx_basic_info'
ls_syntax = SQLCA.syntaxfromsql( ls_SQL, "style(type=grid)",ls_err)
If Len(ls_err) = 0 Then
	dw_report.Create(ls_syntax,ls_err)
	If Len(ls_err) > 0 Then
		If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		This.SetRedraw(True)
		Messagebox('Error','Failed to create datawindow, please call support.')
		Return -2
	End If
Else
	If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
	This.SetRedraw(True)
	Messagebox('Error','Failed to generate SQL syntax, please call support.')
	Return -1
End If

//Modify datawindow properties: column's length and label text and Alignment
ls_syntax = ''
For i = 1 To UpperBound(istr_search.col_name[])
	ls_syntax +=  istr_search.col_name[i] + ".width = '" + istr_search.adw_search.Describe(istr_search.col_name[i] + '.width') + "' "
	ls_syntax +=  istr_search.col_name[i] + ".Alignment = '" + istr_search.adw_search.Describe(istr_search.col_name[i] + '.Alignment') + "' "
	
	ls_syntax +=  istr_search.col_name[i] + "_t.Text = '" + istr_search.col_label[i] + "' "
	
	If Len(istr_search.adw_search.Describe(istr_search.col_name[i] + '_t.Type')) > 1 Then
		ls_syntax +=  istr_search.col_name[i] + "_t.Alignment = '" + istr_search.adw_search.Describe(istr_search.col_name[i] + '_t.Alignment') + "' "
	ElseIf Len(istr_search.adw_search.Describe(Left(istr_search.col_name[i],Len(istr_search.col_name[i]) - 2) + '_t.Type')) > 1 Then
		ls_syntax +=  istr_search.col_name[i] + "_t.Alignment = '" + istr_search.adw_search.Describe(Left(istr_search.col_name[i],Len(istr_search.col_name[i]) - 2) + '_t.Alignment') + "' "
	End If
//	
//	//Added By Ken.Guo 04/19/2012
//	If Left(Lower(istr_search.col_type[i]), 4) = 'date' Then
//		ls_mask = istr_search.adw_search.Describe(istr_search.col_name[j] + '.EditMask.Mask')
//		ls_syntax += istr_search.col_name[i] + ".EditMask.Mask = '" + ls_mask +  "' " 
//	End If

Next
dw_report.Modify(ls_syntax)
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)

//Fill Data to dw_target from dw_source
ll_row_cnt = istr_search.adw_search.RowCount()
ll_step = Round(ll_row_cnt / 20,0) + 1

For i = 1 To ll_row_cnt
	If Mod(i,ll_step) = 0 Then
		If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20 + (i/ll_step) * (100 - 20)/20 )
	End If
	ll_row = dw_report.InsertRow(0)
	ls_value = ''
	For j = 1 To UpperBound(istr_search.col_name[])
		ls_mask = istr_search.adw_search.Describe(istr_search.col_name[j] + '.EditMask.Mask')
		ls_coltype = istr_search.adw_search.Describe(istr_search.col_name[j] + '.coltype')
		If ls_mask <> '!' and ls_mask <> '?' Then
			//For EditMask Column
			Choose Case Left(Lower(ls_coltype),5)
				Case 'char(','char'
					ls_value = String(istr_search.adw_search.GetItemString(i,istr_search.col_name[j]),ls_mask)
					dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
				Case 'date'
					If i = 1 Then
						dw_report.Modify(istr_search.col_name[j] + ".EditMask.Mask = '" + ls_mask + "'" )
					End If					
					dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDate(i,istr_search.col_name[j]))
				Case 'datet'
					If i = 1 Then
						dw_report.Modify(istr_search.col_name[j] + ".EditMask.Mask = '" + ls_mask + "'" )
					End If
					dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDateTime(i,istr_search.col_name[j]))					
				Case 'decim','real'
					ls_value = String(istr_search.adw_search.GetItemDecimal(i,istr_search.col_name[j]),ls_mask)
					dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
				Case 'int','long','numbe','ulong'
					ls_value = String(istr_search.adw_search.GetItemNumber(i,istr_search.col_name[j]),ls_mask)
					dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
				Case Else
					dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.Describe("Evaluate('Lookupdisplay("+istr_search.col_name[j]+")',"+String(i)+")" ))
			End Choose
		Else
			//For non-EditMask Column
			If Upper(istr_search.adw_search.Describe(istr_search.col_name[j] + '.type')) = "COMPUTE" Then
				//For Compute Column
				ls_format = istr_search.adw_search.Describe(istr_search.col_name[j] + '.Format')
				ls_coltype = istr_search.adw_search.Describe(istr_search.col_name[j] + '.coltype')
				If ls_format <> '!' and ls_format <> '?' Then 
					Choose Case Left(Lower(ls_coltype),5)
						Case 'char(','char'
							ls_value = String(istr_search.adw_search.GetItemString(i,istr_search.col_name[j]),ls_format)
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case 'date'
							If i = 1 Then
								dw_report.Modify(istr_search.col_name[j] + ".Format = '" + ls_format + "'" )
							End If							
							dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDate(i,istr_search.col_name[j]))
						Case 'datet'
							If i = 1 Then
								dw_report.Modify(istr_search.col_name[j] + ".Format = '" + ls_format + "'" )
							End If
							dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDateTime(i,istr_search.col_name[j]))	
						Case 'decim','real'
							ls_value = String(istr_search.adw_search.GetItemDecimal(i,istr_search.col_name[j]),ls_format)
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case 'int','long','numbe','ulong'
							ls_value = String(istr_search.adw_search.GetItemNumber(i,istr_search.col_name[j]),ls_format)
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case Else
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
					End Choose
				Else
					Choose Case Left(Lower(ls_coltype),5)
						Case 'char(','char' //compute column have no length
							ls_value = String(istr_search.adw_search.GetItemString(i,istr_search.col_name[j]))
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case 'date'
							dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDate(i,istr_search.col_name[j]))	
						Case 'datet'
							dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDateTime(i,istr_search.col_name[j]))
						Case 'decim','real'
							ls_value = String(istr_search.adw_search.GetItemDecimal(i,istr_search.col_name[j]))
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case 'int','long','numbe','ulong'
							ls_value = String(istr_search.adw_search.GetItemNumber(i,istr_search.col_name[j]))
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
						Case Else
							dw_report.SetItem(ll_row,istr_search.col_name[j],ls_value)
					End Choose					
					
				End If
			Else
				//For Normal Column
				Choose Case Left(Lower(istr_search.col_type[j]), 5)
					Case 'date'
						dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDate(i,istr_search.col_name[j]))	
					Case 'datet'
						dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.GetItemDateTime(i,istr_search.col_name[j]))	
					Case Else
						dw_report.SetItem(ll_row,istr_search.col_name[j],istr_search.adw_search.Describe("Evaluate('Lookupdisplay("+istr_search.col_name[j]+")',"+String(i)+")" ))		
				End Choose
			End If
			
			//Workaround APB' bug for null value for datetime column
			If Left(Lower(ls_coltype),5) = 'datet' Then
				If IsNull(istr_search.adw_search.GetItemDatetime(i,istr_search.col_name[j])) Then
					dw_report.SetItem(ll_row,istr_search.col_name[j],ldt_null)
				End If
			End If
			
		End If
	Next
Next

dw_report.Modify("datawindow.Print.Preview = 'Yes'")
dw_report.Modify("datawindow.Print.Preview.Rulers = 'Yes'")
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
st_1.Text = "Returned " + String( dw_report.RowCount( ) ) + " Rows"
This.SetRedraw(True)
Return 1
end function

on w_ctx_search_print.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_output=create cb_output
this.cb_sort=create cb_sort
this.cb_setup=create cb_setup
this.cb_print=create cb_print
this.cb_close=create cb_close
this.cb_export=create cb_export
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_output
this.Control[iCurrent+3]=this.cb_sort
this.Control[iCurrent+4]=this.cb_setup
this.Control[iCurrent+5]=this.cb_print
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_export
this.Control[iCurrent+8]=this.dw_report
end on

on w_ctx_search_print.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_output)
destroy(this.cb_sort)
destroy(this.cb_setup)
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.cb_export)
destroy(this.dw_report)
end on

event open;call super::open;If isvalid(Message.powerobjectparm) Then
	istr_search = Message.powerobjectparm
Else
	Messagebox('Error','Failed to get data, please call support')
	Return -1
End If

end event

event pfc_postopen;call super::pfc_postopen;If Not Isvalid(istr_search.adw_search) Then Return 

of_gen_report()

end event

type st_1 from statictext within w_ctx_search_print
integer x = 50
integer y = 2056
integer width = 937
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type cb_output from commandbutton within w_ctx_search_print
integer x = 2775
integer y = 2092
integer width = 448
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

type cb_sort from commandbutton within w_ctx_search_print
integer x = 2427
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

type cb_setup from commandbutton within w_ctx_search_print
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

type cb_print from commandbutton within w_ctx_search_print
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

type cb_close from commandbutton within w_ctx_search_print
integer x = 3575
integer y = 2092
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

type cb_export from commandbutton within w_ctx_search_print
integer x = 3227
integer y = 2092
integer width = 343
integer height = 92
integer taborder = 10
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

type dw_report from u_dw within w_ctx_search_print
event ue_syscommand pbm_syscommand
event ue_mail_current ( )
integer x = 27
integer y = 24
integer width = 3895
integer height = 2012
integer taborder = 20
boolean titlebar = true
string title = "Report Preview"
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
end event

