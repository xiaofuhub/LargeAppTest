$PBExportHeader$w_security_ldap_user.srw
forward
global type w_security_ldap_user from window
end type
type cb_2 from commandbutton within w_security_ldap_user
end type
type cb_close from commandbutton within w_security_ldap_user
end type
type cb_save from commandbutton within w_security_ldap_user
end type
type dw_ldap_user from datawindow within w_security_ldap_user
end type
end forward

global type w_security_ldap_user from window
integer width = 1938
integer height = 2024
boolean titlebar = true
string title = "Auto-Login User Mapping"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_close cb_close
cb_save cb_save
dw_ldap_user dw_ldap_user
end type
global w_security_ldap_user w_security_ldap_user

type variables
Long il_row
end variables

on w_security_ldap_user.create
this.cb_2=create cb_2
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_ldap_user=create dw_ldap_user
this.Control[]={this.cb_2,&
this.cb_close,&
this.cb_save,&
this.dw_ldap_user}
end on

on w_security_ldap_user.destroy
destroy(this.cb_2)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_ldap_user)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_security_ldap_useropen()
// $<arguments>(None)
// $<returns> long
// $<description> LDAP Login User <--> IntelliCred Login User
//////////////////////////////////////////////////////////////////////
// $<add> 10/09/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_user_id

dw_ldap_user.SetTransObject(SQLCA)
dw_ldap_user.Retrieve()

Ls_user_id = Message.stringparm

//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
If Ls_user_id = '' or isnull(ls_user_id) Then 
	ls_User_ID = gs_User_ID
End If
//---------End Modfiied ------------------------------------------------------


If ls_user_id <> '' And not isnull(ls_user_id) Then
	il_row = dw_ldap_user.Find( 'user_id = "'+ls_user_id+'"', 1,dw_ldap_user.rowcount())
	If il_row > 0 Then
		dw_ldap_user.Setfocus()
		dw_ldap_user.ScrollToRow(il_row)
		dw_ldap_user.SetRow(il_row)
		dw_ldap_user.SetColumn('ic_ldap_user')
	End If
End If

end event

event closequery;Integer li_ret
dw_ldap_user.AcceptText()
If dw_ldap_user.ModifiedCount() > 0 Then
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

event close;String ls_current_ldapuser
If il_row > 0 Then
	ls_current_ldapuser = Dw_ldap_user.GetItemString(il_row,'ic_ldap_user',Primary!	,True)
End If
CloseWithReturn(this,ls_current_ldapuser)

end event

type cb_2 from commandbutton within w_security_ldap_user
integer x = 27
integer y = 24
integer width = 626
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Local Domain Name"
end type

event clicked;//Display Domain & UserName(OS Login User)
String ls_os_username,ls_domainname
n_cst_systeminfo lnv_systeminfo
lnv_systeminfo = Create n_cst_systeminfo
ls_os_username = lnv_systeminfo.of_get_username()
ls_domainname = lnv_systeminfo.of_get_domainname()

//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
//Messagebox('Domain info',"Local Computer's Domain Name is: '" + ls_domainname + "';" + '~r~n' + &
//								 "Local Computer's Login User Name is: '" + ls_os_username + "'." 	)
Boolean lb_Need_Modify = False
String ls_cur_username, ls_cur_domainname
Long ll_row

ll_row = dw_ldap_user.Find('user_id = "' +gs_user_id+ '"',1,dw_ldap_user.RowCount())

If ll_Row > 0 Then
	ls_cur_domainname = dw_ldap_user.GetItemString(ll_row,'domain_name')
	ls_cur_username = dw_ldap_user.GetItemString(ll_row,'ic_ldap_user')
	
	If ls_os_username = ls_cur_username and ls_domainname = ls_cur_domainname Then
		//Ignore
	Else
		lb_Need_Modify = True
	End If
End If

If Not lb_Need_Modify Then
	Messagebox('Domain info',"Local Computer's Domain Name is: '" + ls_domainname + "'." + '~r~n' + &
								  "Local Computer's Login User Name is: '" + ls_os_username + "'." 	)
Else
	If Messagebox('Domain info',"Local Computer's Domain Name is: '" + ls_domainname + "'." + '~r~n' + &
								  "Local Computer's Login User Name is: '" + ls_os_username + "'.~r~n~r~n" + &
								  'Do you want to set the information to the current login user ~'' + gs_user_id +'~'?' , Question!, YesNo! 	) = 1 Then //alfee 05.10.2016
								  //'Do you want to set the LDAP information to the current login user ~'' + gs_user_id +'~'?' , Question!, YesNo! 	) = 1 Then
		dw_ldap_user.SetItem(ll_row,'domain_name', ls_domainname)								  
		dw_ldap_user.SetItem(ll_row,'ic_ldap_user', ls_os_username)
		dw_ldap_user.ScrollToRow(ll_row)
		dw_ldap_user.SetRow(ll_row)
	End If
End If
//---------End Modfiied ------------------------------------------------------


end event

type cb_close from commandbutton within w_security_ldap_user
integer x = 1550
integer y = 24
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

type cb_save from commandbutton within w_security_ldap_user
integer x = 1189
integer y = 24
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

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_saveclicked()
// $<arguments>(None)
// $<returns> long
// $<description> Save data
//////////////////////////////////////////////////////////////////////
// $<add> 10/10/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////


//If exist duplicate LDAP user, forbid save it
Long ll_rowcount,i,ll_findrow
String ls_ldapuser,ls_user1,ls_user2
dw_ldap_user.AcceptText()
SetPointer(HourGlass!)
ll_rowcount = dw_ldap_user.rowcount()
For i = 1 to ll_rowcount
	If ll_rowcount < 2 Then Exit
	ls_ldapuser = dw_ldap_user.GetItemString(i,'ic_ldap_user')
	If dw_ldap_user.GetItemStatus(i,'ic_ldap_user',Primary!) = NotModified! or &
		ls_ldapuser = '' or Isnull(ls_ldapuser)  Then Continue
	//Finding duplicate row
	If i = 1 Then
		ll_findrow = dw_ldap_user.Find('ic_ldap_user = "'+ls_ldapuser+'"',2,ll_rowcount)
	ElseIf i = ll_rowcount Then
		ll_findrow = dw_ldap_user.Find('ic_ldap_user = "'+ls_ldapuser+'"',1,ll_rowcount -1 )	
	Else
		ll_findrow = dw_ldap_user.Find('ic_ldap_user = "'+ls_ldapuser+'"',1,i - 1)		
		If ll_findrow < 1 Then
			ll_findrow = dw_ldap_user.Find('ic_ldap_user = "'+ls_ldapuser+'"',i + 1,ll_rowcount)
		End If
	End If
	//If found
	If ll_findRow > 0 Then
		ls_user1 = dw_ldap_user.GetItemString(i,'user_id')
		ls_user2 = dw_ldap_user.GetItemString(ll_findrow,'user_id')
		//Messagebox('Save Error','User "' +ls_user1+ '" and "'+ ls_user2 +'"'+  ' have been linked to the same LDAP user. Please modify either of them before saving.')
		Messagebox('Save Error','User "' +ls_user1+ '" and "'+ ls_user2 +'"'+  ' have been linked to the same domain user. Please modify either of them before saving.') //alfee 05.10.2016
		//SetRow
		dw_ldap_user.SetFocus()
		dw_ldap_user.ScrollToRow(i)
		dw_ldap_user.SetRow(i)
		dw_ldap_user.SetColumn('ic_ldap_user')
		Return -1
	End If
Next


//Save It
If Dw_ldap_user.Update() = 1 Then
	Commit;
	Return 1
Else
	Rollback;
	Messagebox('Save Error','Failed to save it.',Exclamation!)
	Return -1
End If
Return 1
end event

type dw_ldap_user from datawindow within w_security_ldap_user
integer x = 18
integer y = 152
integer width = 1893
integer height = 1776
integer taborder = 10
string title = "none"
string dataobject = "d_security_ldap_user"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event>dw_ldap_userbuttonclicked()
// $<arguments>
//		long    	row             		
//		long    	actionreturncode		
//		dwobject	dwo             		
// $<returns> long
// $<description> Batch update domain name
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11/19/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
Long ll_count,i
dw_ldap_user.AcceptText()
If Dwo.name = 'b_batch' Then
	ll_count = This.Rowcount()
	For i = 1 To ll_count
		This.SetItem(i,'domain_name',This.GetItemString(1,'domain_name'))
	Next
End If
end event

