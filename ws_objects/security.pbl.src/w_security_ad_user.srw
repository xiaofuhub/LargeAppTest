$PBExportHeader$w_security_ad_user.srw
forward
global type w_security_ad_user from w_response
end type
type cb_server_verify from commandbutton within w_security_ad_user
end type
type cb_2 from commandbutton within w_security_ad_user
end type
type cbx_allow_ad from checkbox within w_security_ad_user
end type
type cb_close from commandbutton within w_security_ad_user
end type
type cb_save from commandbutton within w_security_ad_user
end type
type dw_ad_user from u_dw within w_security_ad_user
end type
end forward

global type w_security_ad_user from w_response
integer x = 214
integer y = 221
integer width = 3173
integer height = 2024
string title = "AD User Mapping Painter"
long backcolor = 33551856
string icon = "AppIcon!"
cb_server_verify cb_server_verify
cb_2 cb_2
cbx_allow_ad cbx_allow_ad
cb_close cb_close
cb_save cb_save
dw_ad_user dw_ad_user
end type
global w_security_ad_user w_security_ad_user

type variables
Long il_row
Boolean ib_allow_ad_org_value, ib_show_tips

end variables

on w_security_ad_user.create
int iCurrent
call super::create
this.cb_server_verify=create cb_server_verify
this.cb_2=create cb_2
this.cbx_allow_ad=create cbx_allow_ad
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_ad_user=create dw_ad_user
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_server_verify
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cbx_allow_ad
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.dw_ad_user
end on

on w_security_ad_user.destroy
call super::destroy
destroy(this.cb_server_verify)
destroy(this.cb_2)
destroy(this.cbx_allow_ad)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_ad_user)
end on

event open;//====================================================================
// Event: open
//--------------------------------------------------------------------
// Description: support AD function.
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo 2016-06-16
//--------------------------------------------------------------------
//Copyright (c) 2008-2015 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


String ls_user_id
Long ll_cnt, i

dw_ad_user.SetTransObject(SQLCA)
ll_cnt = dw_ad_user.Retrieve()

For i = 1 To  ll_cnt
	If isnull(dw_ad_user.GetItemNumber(i,'ad_status')) Then
		dw_ad_user.setitem(i, 'ad_status', 0)
		dw_ad_user.setitemstatus(i, 0, primary!,notmodified!)
	End If
Next

Ls_user_id = Message.stringparm

If Ls_user_id = '' or isnull(ls_user_id) Then 
	ls_User_ID = gs_User_ID
End If

If ls_user_id <> '' And not isnull(ls_user_id) Then
	il_row = dw_ad_user.Find( 'user_id = "'+ls_user_id+'"', 1,dw_ad_user.rowcount())
	If il_row > 0 Then
		dw_ad_user.Setfocus()
		dw_ad_user.ScrollToRow(il_row)
		dw_ad_user.SetRow(il_row)
		dw_ad_user.SetColumn('ad_user')
	End If
End If
//gnv_app.of_window_basic_code(this) 

If gnv_user_option.of_get_option_value('allow_ad_function') = '1' Then
	cbx_allow_ad.checked = True
	ib_allow_ad_org_value = True
Else
	cbx_allow_ad.checked = False
	ib_allow_ad_org_value = False
End If

end event

event closequery;Integer li_ret
dw_ad_user.AcceptText()
If dw_ad_user.ModifiedCount() > 0 Then
	li_ret = MessageBox('Information','You have modified some data. Do you want to save it before closing?',Question!,YesNoCancel! )
	If li_ret = 1 Then
		If cb_save.Trigger Event Clicked() = 1 Then
			Return 0 //Allow Close
		Else
			Return 1 //Prevent Close
		End If
	ElseIf li_ret= 2 Then
		Return 0
	Else
		Return 1
	End If
End If
end event

event close;String ls_current_aduser
If il_row > 0 Then
	ls_current_aduser = dw_ad_user.GetItemString(il_row,'ad_user',Primary!	,True)
End If
CloseWithReturn(this,ls_current_aduser)

end event

type cb_server_verify from commandbutton within w_security_ad_user
integer x = 1198
integer y = 24
integer width = 558
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Verification Settings..."
end type

event clicked;open(w_ad_server_verify)
end event

type cb_2 from commandbutton within w_security_ad_user
integer x = 27
integer y = 1816
integer width = 663
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Computer User Name"
end type

event clicked;//Display Domain & UserName(OS Login User)
Boolean lb_Need_Modify = False
Long ll_row
String ls_os_username,ls_domainname
String ls_cur_username, ls_cur_domainname
n_cst_systeminfo lnv_systeminfo
lnv_systeminfo = Create n_cst_systeminfo
ls_os_username = lnv_systeminfo.of_get_username()
ls_domainname = lnv_systeminfo.of_get_domaindnsname()

ll_row = dw_ad_user.Find('user_id = "' +gs_user_id+ '"',1,dw_ad_user.RowCount())

If ll_Row > 0 Then
//	ls_cur_domainname = dw_ad_user.GetItemString(ll_row,'ad_pc_domainname')
	ls_cur_username = dw_ad_user.GetItemString(ll_row,'ad_user')
	
	If ls_os_username = ls_cur_username Then
		//Ignore
	Else
		lb_Need_Modify = True
	End If
End If

If Not lb_Need_Modify Then
	Messagebox('Domain info',"Local Computer's Login User Name is: '" + ls_os_username + "'." 	)
Else
	If Messagebox('Domain info', "Local Computer's Login User Name is: '" + ls_os_username + "'.~r~n~r~n" + &
								  'Do you want to set it to the current login user ~'' + gs_user_id +'~'?' , Question!, YesNo! 	) = 1 Then
//		dw_ad_user.SetItem(ll_row,'ad_pc_domainname', ls_domainname)								  
		dw_ad_user.SetItem(ll_row,'ad_user', ls_os_username)
		dw_ad_user.ScrollToRow(ll_row)
		dw_ad_user.SetRow(ll_row)
	End If
End If


end event

type cbx_allow_ad from checkbox within w_security_ad_user
integer x = 55
integer y = 44
integer width = 1129
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Allow authentication with Active Directory"
end type

type cb_close from commandbutton within w_security_ad_user
integer x = 2757
integer y = 1812
integer width = 343
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

type cb_save from commandbutton within w_security_ad_user
integer x = 2409
integer y = 1812
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
// Event: clicked
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo 2016-06-17
//--------------------------------------------------------------------
//Copyright (c) 2008-2015 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================



//If exist duplicate LDAP user, forbid save it
Long ll_rowcount,i,ll_findrow
String ls_ldapuser,ls_user1,ls_user2, ls_value
dw_ad_user.AcceptText()
SetPointer(HourGlass!)
ll_rowcount = dw_ad_user.rowcount()
For i = 1 to ll_rowcount
	If ll_rowcount < 2 Then Exit
	ls_ldapuser = dw_ad_user.GetItemString(i,'ad_user')
	If dw_ad_user.GetItemStatus(i,'ad_user',Primary!) = NotModified! or &
		ls_ldapuser = '' or Isnull(ls_ldapuser)  Then Continue
	//Finding duplicate row
	If i = 1 Then
		ll_findrow = dw_ad_user.Find('ad_user = "'+ls_ldapuser+'"',2,ll_rowcount)
	ElseIf i = ll_rowcount Then
		ll_findrow = dw_ad_user.Find('ad_user = "'+ls_ldapuser+'"',1,ll_rowcount -1 )	
	Else
		ll_findrow = dw_ad_user.Find('ad_user = "'+ls_ldapuser+'"',1,i - 1)		
		If ll_findrow < 1 Then
			ll_findrow = dw_ad_user.Find('ad_user = "'+ls_ldapuser+'"',i + 1,ll_rowcount)
		End If
	End If
	//If found
	If ll_findRow > 0 Then
		ls_user1 = dw_ad_user.GetItemString(i,'user_id')
		ls_user2 = dw_ad_user.GetItemString(ll_findrow,'user_id')
		Messagebox('Save Error','User "' +ls_user1+ '" and "'+ ls_user2 +'"'+  ' have been linked to the same AD user. Please modify either of them before saving.',Exclamation!)
		//SetRow
		dw_ad_user.SetFocus()
		dw_ad_user.ScrollToRow(i)
		dw_ad_user.SetRow(i)
		dw_ad_user.SetColumn('ad_user')
		Return -1
	End If
Next

If cbx_allow_ad.checked <> ib_allow_ad_org_value Then
	If cbx_allow_ad.checked Then
		ls_value = '1'
	Else
		ls_value = '0'
	End If
	gnv_user_option.of_set_option_value( 'allow_ad_function', ls_value)
	gnv_user_option.of_system_save( )
End If

//Save It
If dw_ad_user.Update() = 1 Then
	Commit;
	Return 1
Else
	Rollback;
	Messagebox('Save Error','Failed to save it.',Exclamation!)
	Return -1
End If
Return 1
end event

type dw_ad_user from u_dw within w_security_ad_user
integer x = 14
integer y = 132
integer width = 3113
integer height = 1652
integer taborder = 10
string title = "none"
string dataobject = "d_security_ad_user"
boolean hscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//====================================================================
// Event: buttonclicked
//--------------------------------------------------------------------
// Description: Batch set data
//--------------------------------------------------------------------
// Arguments:
//                row
//                actionreturncode
//                dwo
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo 2016-06-15
//--------------------------------------------------------------------
//Copyright (c) 2008-2015 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String ls_value
Long ll_count,i
dw_ad_user.AcceptText()
ll_count = This.Rowcount()
If ll_count = 0 or row = 0 Then Return
Choose Case Dwo.name 
	Case  'b_server' 
		If isnull(This.GetItemString(1,'ad_server')) or This.GetItemString(1,'ad_server') = '' Then
			ls_value = 'Empty'
		Else
			ls_value = This.GetItemString(1,'ad_server')
		End If
		If Messagebox('AD Settings','Do you want to set all AD Servers as “'+ls_value+'”?', Question!, Yesno!) = 1 Then
			For i = 2 To ll_count
				This.SetItem(i,'ad_server',ls_value)
			Next
		Else
			Return 
		End If
	Case 'b_save_pwd'
		If isnull(This.GetItemNumber(1,'ad_save_pwd')) or This.GetItemNumber(1,'ad_save_pwd') = 0 Then
			ls_value = 'unchecked'
		Else
			ls_value = 'checked'
		End If
		If Messagebox('AD Settings','Do you want to set all Save AD Password as “'+ls_value+'”?', Question!, Yesno!) = 1 Then
			For i = 2 To ll_count
				This.SetItem(i,'ad_save_pwd',This.GetItemNumber(1,'ad_save_pwd'))
			Next
		Else
			Return 
		End If			
	Case 'b_status'
		If isnull(This.GetItemNumber(1,'ad_status')) or This.GetItemNumber(1,'ad_status') = 0 Then
			ls_value = 'off'
		Else
			ls_value = 'on'
		End If
		If Messagebox('AD Settings','Do you want to turn '+ls_value+' AD for all users?', Question!, Yesno!) = 1 Then
			For i = 2 To ll_count
				This.SetItem(i,'ad_status',This.GetItemNumber(1,'ad_status'))
			Next
		Else
			Return 
		End If		
	Case 'b_pc_domainname'	
		If isnull(This.GetItemString(1,'ad_pc_domainname')) or This.GetItemString(1,'ad_pc_domainname') = '' Then
			ls_value = 'Empty'
		Else
			ls_value = This.GetItemString(1,'ad_pc_domainname')
		End If
		If Messagebox('AD Settings','Do you want to set all Computer Domain Name as “'+ls_value+'”?', Question!, Yesno!) = 1 Then
			For i = 2 To ll_count
				This.SetItem(i,'ad_pc_domainname',ls_value)
			Next
		Else
			Return 
		End If			
	Case 'b_verify'
		If getitemnumber(row, 'ad_status') = 0 or isnull(getitemnumber(row, 'ad_status')) then return
		str_ad_pass lstr_ad_pass
		lstr_ad_pass.ls_server = this.getitemstring(row, 'ad_server')
		lstr_ad_pass.ls_user = this.getitemstring(row, 'ad_user')
		If lstr_ad_pass.ls_user = '' or isnull(lstr_ad_pass.ls_user) Then
			SetRow(row)
			Setcolumn('ad_user')			
			Messagebox('Verify','The AD User Name cannot be empty.',Exclamation!)
			Return 
		End If		
		OpenwithParm(w_ad_account_verify,lstr_ad_pass)
End Choose
end event

event itemchanged;
Choose Case dwo.name
	Case 'ad_save_pwd'
		If data = '1'  and Not ib_show_tips Then
			Post Messagebox('Notes','After you set up and check Save AD Password, the user’s password will be saved after the user logs in for the first time. It will be used for auto login for the specific computer next time.')
			ib_show_tips = True
		End If
End Choose
end event

event constructor;call super::constructor;dw_ad_user.of_SetRowSelect(True)
end event

