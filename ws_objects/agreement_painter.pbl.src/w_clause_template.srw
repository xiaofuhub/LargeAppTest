$PBExportHeader$w_clause_template.srw
$PBExportComments$Create by Jack 11/16/2006
forward
global type w_clause_template from w_response
end type
type cb_select from commandbutton within w_clause_template
end type
type cb_close from commandbutton within w_clause_template
end type
type cb_save from commandbutton within w_clause_template
end type
type dw_template from u_dw within w_clause_template
end type
end forward

global type w_clause_template from w_response
integer width = 3099
integer height = 1256
string title = "Update Templates"
boolean controlmenu = false
long backcolor = 33551856
cb_select cb_select
cb_close cb_close
cb_save cb_save
dw_template dw_template
end type
global w_clause_template w_clause_template

type variables
//long il_ctx_acp_clause_id
str_clause istr_clause
end variables

on w_clause_template.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_template=create dw_template
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_template
end on

on w_clause_template.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_template)
end on

event open;call super::open;long ll_row,ll_rowcount
datawindowchild child

dw_template.of_SetTransObject( SQLCA )

//il_ctx_acp_clause_id = message.doubleparm
istr_clause = Message.Powerobjectparm
//il_ctx_acp_clause_id = istr_clause.al_clause_id

If UpperBound(istr_clause.al_clause_id_arr[]) = 0 Then
	istr_clause.al_clause_id_arr[1] = istr_clause.al_clause_id
End If

dw_template.retrieve(istr_clause.al_clause_id_arr[])
dw_template.setfocus()




end event

type cb_select from commandbutton within w_clause_template
integer x = 37
integer y = 1060
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Deselect All"
end type

event clicked;Integer li_value0[], li_value1[]
long i,ll_cnt

ll_cnt = dw_template.rowcount() 
If ll_cnt = 0 Then Return

For i = 1 to ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1
Next

If This.text = '&Deselect All' Then
	This.Text = '&Select All'
	dw_template.object.checked[1,ll_cnt] = li_value0[]
Else
	This.Text = '&Deselect All'
	dw_template.object.checked[1,ll_cnt] = li_value1[]
End If

end event

type cb_close from commandbutton within w_clause_template
integer x = 2693
integer y = 1060
integer width = 334
integer height = 92
integer taborder = 30
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

type cb_save from commandbutton within w_clause_template
integer x = 2354
integer y = 1060
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;//---------Modified by Alfee 05.10.2007--------------------
Integer li_rtn
Long ll_rowcount, i, j, ll_template_id[]
DateTime ldt_modify_date[]
Boolean lb_failed = False
str_sys_tracking_log_arr			str_sys_tracking_log_arr_s		//Added By Mark Lee 07/20/12
Long 			ll_upperbound, k											//Added By Mark Lee 07/20/12
String 		ls_user_name,	ls_template_name, ls_msg			//Added By Mark Lee 07/20/12

j = 0
ll_rowcount = dw_template.rowcount()

If ll_rowcount = 0 Then Return

If isvalid(w_agreement_template_painter) Then
	If Messagebox('Update Template','The Template Painter is open and needs to be closed in order for the system to update the selected Templates.  Would you like the system to close the Template Folder?',Question!, YesNO!) = 1 Then
		Close(w_agreement_template_painter)
	Else
		Messagebox('Update Template','No updates made.  Please close Template Painter.')
		Return 
	End If
End If

FOR i = 1 TO ll_rowcount
	IF dw_template.getitemnumber(i,'checked') = 1 THEN
		OpenwithParm( w_appeon_gifofwait, "Updating template files...")
		dw_template.SetItem(i,'update_result','Updating ...')
		dw_template.SetRow(i)
		dw_template.ScrollToRow(i)
		dw_template.SelectRow(0,False)
		dw_template.SelectRow(i,True)
		ll_template_id[1] = dw_template.getitemnumber(i,'ctx_acp_template_id')
		//ldt_modify_date[1] = dw_template.getitemdatetime(i,'modify_date')
		//Begin - Added By Mark Lee 07/20/12
		li_rtn = gnv_tracking.of_find_recorde(gnv_tracking.template_library_painter,string(ll_template_id[1]),'','',str_sys_tracking_log_arr_s)
		If li_rtn > 0 Then 
			ls_user_name = ''
			ll_upperbound = Upperbound(str_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[])
			ls_template_name = string(dw_template.describe("evaluate('LookUpDisplay ( ctx_acp_template_id )', "+string(i)+")" ))
			For k = 1 to ll_upperbound 
				ls_user_name	= str_sys_tracking_log_arr_s.astr_sys_tracking_log_arr[k].as_user + ","
			Next 
			If len(ls_user_name) > 2 Then
				ls_user_name = left(ls_user_name,len(ls_user_name) - 1)
			End If 
//			Currently <User Name> is editing the <Template name> Template.  You will have to wait until <User> has finished editing that Template and closed the Template before continuing. 
			ls_msg =	"Currently <"+ls_user_name+ "> is editing the <"+ls_template_name+"> Template.~r~n You will have to wait until <"+ls_user_name+"> has finished editing that Template and closed the Template before continuing. "
			dw_template.SetItem(i,'update_result','Failure. '+ls_msg)
			lb_failed = True
			continue
		End If
		//End - Added By Mark Lee 07/20/12
		Select modify_date into :ldt_modify_date[1] From ctx_acp_template Where ctx_acp_template_id = :ll_template_id[1] ;
		
		li_rtn = w_clause_painter.tab_1.of_update_template(ll_template_id, ldt_modify_date,istr_clause.ai_type,istr_clause.al_clause_id_arr[] )
		Choose Case li_rtn 
			Case 1
				dw_template.SetItem(i,'update_result','Successfully.')
			Case -2
				dw_template.SetItem(i,'update_result','Failure. The template is locked for update by another user. Please try again later.')
				lb_failed = True
			Case Else
				dw_template.SetItem(i,'update_result','Failure ' + String(li_rtn) +'. '+ SQLCA.SQLErrText)
				lb_failed = True				
		End Choose
		j ++ 
	END IF
NEXT

If Isvalid( w_appeon_gifofwait) Then Close( w_appeon_gifofwait)
IF j = 0 Then 
	Return
End If

If Isvalid( w_appeon_gifofwait) Then Close( w_appeon_gifofwait)

IF Not lb_failed THEN 
	//Close(Parent)
	Messagebox('Clause','Update template successfully.')
Else
	Messagebox('Clause','Failed to update template.')
End If


end event

type dw_template from u_dw within w_clause_template
integer x = 14
integer y = 20
integer width = 3054
integer height = 1016
integer taborder = 20
string dataobject = "d_clause_template"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateable( False )
end event

