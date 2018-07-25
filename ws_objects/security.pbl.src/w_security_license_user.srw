$PBExportHeader$w_security_license_user.srw
forward
global type w_security_license_user from window
end type
type cb_close from commandbutton within w_security_license_user
end type
type cb_save from commandbutton within w_security_license_user
end type
type dw_1 from datawindow within w_security_license_user
end type
end forward

global type w_security_license_user from window
integer width = 3547
integer height = 2028
boolean titlebar = true
string title = "E-Signature License Maintains"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_save cb_save
dw_1 dw_1
end type
global w_security_license_user w_security_license_user

type variables
Long il_row
end variables

forward prototypes
public function integer of_get_token ()
end prototypes

public function integer of_get_token ();//====================================================================
// Function: of_get_token
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 02-17-2016
//--------------------------------------------------------------------
//	Copyright (c) 2008-2014 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

/*
String ls_client_id,ls_client_secret,ls_url,ls_redirect,ls_null,ls_user_id
long ll_row
n_cst_webapi lnv_webapi

dw_1.AcceptText() 
Setnull(ls_null)
ll_row = dw_1.getrow()
if ll_row < 1 then return -1
ls_user_id = dw_1.getitemstring(ll_row,"user_id")
ls_client_id = dw_1.getitemstring(ll_row,"esign_client_id")
ls_client_secret = dw_1.getitemstring(ll_row,"esign_client_secret")
if isnull(ls_client_id) then ls_client_id = ''
if isnull(ls_client_secret) then ls_client_secret = ''
if ls_client_id = '' then
	messagebox(gnv_app.iapp_object.DisplayName,'Please input the Echosign Client ID first!')
	dw_1.setfocus()
	dw_1.setcolumn("client_id")
	return -1
end if
if ls_client_secret = '' then
	messagebox(gnv_app.iapp_object.DisplayName,'Please input the Echosign Client Secret first!')
	dw_1.setfocus()
	dw_1.setcolumn("client_secret")
	return -1
end if

ls_url = 'https://appeon.na1.echosign.com/public/oauth'

ls_redirect = gnv_user_option.of_get_option_value('contractlogix-super-master', "esign_redirect" )
if isnull(ls_redirect) or ls_redirect = '' then ls_redirect = 'https://192.0.0.148/api/accesstoken/'
if isnull(ls_redirect ) or trim(ls_redirect) = '' then 
	messagebox(gnv_app.iapp_object.DisplayName,"The system cannot detect a valid echosign accesstoken redirect url.")
	return -1
end if

//https://appeon.na1.echosign.com/public/oauth?redirect_uri=***&response_type=***&client_id=***&scope=***&state=***
if isnull(gs_accesstoken) or trim(gs_accesstoken) = '' then 
	gs_accesstoken = lnv_webapi.of_convert_json_token()
end if
ls_url = ls_url+ "?redirect_uri=" + ls_redirect+ "&response_type=code" + "&client_id=" + ls_client_id + "&scope=agreement_read+agreement_send+agreement_write+user_login" + "&state=" + gs_accesstoken + '_' + ls_user_id
ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)	
*/
return 1
end function

on w_security_license_user.create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_1=create dw_1
this.Control[]={this.cb_close,&
this.cb_save,&
this.dw_1}
end on

on w_security_license_user.destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_1)
end on

event open;String ls_user_id,ls_esign_type

choose case gs_esigntype
	case 'docusign'
		ls_esign_type = 'Docusign'
		dw_1.dataobject = 'd_security_license_user'
		dw_1.width = 3503
		this.width = 3536
		cb_save.x = 2779 
		cb_close.x = 3141 
	case 'echosign'
		ls_esign_type = 'Echosign'
//		if gs_echosign_method = 'http' then //Added By Jay Chen 02-04-2016
//			dw_1.dataobject = 'd_security_license_user3'
//			dw_1.width = 2450
//			this.width = 2500
//			cb_save.x = 1721
//			cb_close.x = 2088
//		else
			dw_1.dataobject = 'd_security_license_user2'
			dw_1.width = 1600
			this.width = 1633
			cb_save.x = 871
			cb_close.x = 1233
//		end if
	case 'sertifi'
		ls_esign_type = 'Sertifi'
		dw_1.dataobject = 'd_security_license_user2'
		dw_1.width = 1600
		this.width = 1633
		cb_save.x = 871
		cb_close.x = 1233
end choose

this.title = "E-Signature License Maintains for " + ls_esign_type

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(gs_esigntype)

Ls_user_id = Message.stringparm

If Ls_user_id = '' or isnull(ls_user_id) Then 
	ls_User_ID = gs_User_ID
End If

If ls_user_id <> '' And not isnull(ls_user_id) Then
	il_row = dw_1.Find( 'user_id = "'+ls_user_id+'"', 1,dw_1.rowcount())
	If il_row > 0 Then
		dw_1.Setfocus()
		dw_1.ScrollToRow(il_row)
		dw_1.SetRow(il_row)
		dw_1.SetColumn('esign_apicode')
	End If
End If

//gnv_app.of_window_basic_code(this) //Added By Ken.Guo 2016-03-17


end event

event closequery;Integer li_ret
dw_1.AcceptText()
If dw_1.ModifiedCount() > 0 Then
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

type cb_close from commandbutton within w_security_license_user
integer x = 3141
integer y = 1824
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type cb_save from commandbutton within w_security_license_user
integer x = 2779
integer y = 1824
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "&Save"
end type

event clicked;long ll_row
string ls_userid,ls_personal_id
string ls_mode,ls_apicode,ls_apicode2
long ll_cnt
dwItemStatus l_status

dw_1.AcceptText()
SetPointer(HourGlass!)

//check docusign apicode if or not modify
if gs_esigntype = 'docusign' then
	for ll_row = 1 to dw_1.rowcount()
		l_status = dw_1.GetItemStatus(ll_row, "esign_apicode", Primary!)
		if l_status = DataModified! then
			ls_apicode = dw_1.getitemstring(ll_row,'esign_apicode',Primary!,true)
			ls_apicode2 = dw_1.getitemstring(ll_row,'esign_apicode',Primary!,false)
			ls_userid = dw_1.getitemstring(ll_row,'user_id')
			if ls_apicode <> ls_apicode2 then
				select count(*) into :ll_cnt from ctx_am_document where esign_type = 'docusign' and es_license_user_id = :ls_userid and es_apicode = :ls_apicode;
				if isnull(ll_cnt) then ll_cnt = 0
				if ll_cnt < 1 then
					select count(*) into :ll_cnt from ctx_am_doc_audit where esign_type = 'docusign' and es_license_user_id = :ls_userid and es_apicode = :ls_apicode;
					if isnull(ll_cnt) then ll_cnt = 0
				end if
				if ll_cnt > 0 then
					if Messagebox('IntelliSoftGroup','The system has detected that this API code has been used for sending document signing requests. You will not be able to check the signing status for those documents if you change it. Do you want to continue?',Exclamation!, YesNo!, 2) = 2 then
						dw_1.setfocus()
						dw_1.SetRow(ll_row)
						dw_1.SetColumn('esign_apicode')
						return -1
					else
						gnv_docusign.ib_isvalid_sertifi = false //Added By Jay Chen 09-05-2014
					end if
				end if
			end if
		end if
	next
end if

//Save 
If dw_1.Update() = 1 Then
	Commit;
	Return 1
Else
	Rollback;
	Messagebox('Save Error','Failed to save it.',Exclamation!)
	Return -1
End If
Return 1
end event

type dw_1 from datawindow within w_security_license_user
integer x = 14
integer y = 16
integer width = 3502
integer height = 1776
integer taborder = 10
string title = "E-Signature License Maintains"
string dataobject = "d_security_license_user"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;string ls_apicode,ls_username,ls_password,ls_userid,ls_accountid
int li_ret

dw_1.accepttext( )
if row < 1 then return
ls_apicode = this.getitemstring(row, "esign_apicode")
if gs_esigntype <> 'echosign' then //Added By Jay Chen 02-03-2016
	If ls_apicode = '' or isnull(ls_apicode) Then
		Messagebox('Error','Please input the API Code.',Exclamation!)
		Return
	End If
end if
		
if dwo.name = 'b_verify' then
	choose case gs_esigntype
		case 'sertifi' 
//			If Not gnv_sertifi.of_check_sertifi(false,ls_apicode,false) Then Return
//			li_ret = gnv_sertifi.of_ping_apicode(ls_apicode) 
//			choose case li_ret 
//				case -1
//					Messagebox('Sertifi Error','Invalid Sertifi API Code, please input a valid value.',Exclamation!)
//				case -2
//					Messagebox('Sertifi Error','Cannot connect to Sertifi server. You may experience some network connection issue.',Exclamation!)
//				case 1
//					Messagebox('Sertifi','Sertifi API Code is OK.')
//			end choose
		
		case 'echosign'
//			if gs_echosign_method <> 'http' then //Modified By Jay Chen 02-17-2016
//				If Not gnv_echosign.of_check_sertifi(false,ls_apicode,false) Then Return
//				li_ret = gnv_echosign.of_ping_apicode(ls_apicode) 
//				choose case li_ret 
//					case -1
//						Messagebox('Echosign Error','Invalid Echosign API Code, please input a valid value.',Exclamation!)
//					case -2
//						Messagebox('Echosign Error','Cannot connect to Echosign server. You may experience some network connection issue.',Exclamation!)
//					case 1
//						Messagebox('Echosign','Echosign API Code is OK.')
//				end choose
//			else
//				of_get_token()
//			end if
			
		case 'docusign'
			ls_username = dw_1.GetitemString(row,'esign_username')
			If ls_username = '' or isnull(ls_username) Then
				Messagebox('Error','Please input the Docusign User Name.',Exclamation!)
				Return
			End If
			ls_password = dw_1.GetitemString(row,'esign_password')
			If ls_password = '' or isnull(ls_password) Then
				Messagebox('Error','Please input the Docusign Password.',Exclamation!)
				Return
			End If
			ls_userid = dw_1.GetitemString(row,'esign_userid')
			If ls_userid = '' or isnull(ls_userid) Then
				Messagebox('Error','Please input the Docusign User Id.',Exclamation!)
				Return
			End If
			ls_accountid = dw_1.GetitemString(row,'esign_accountid')
			If ls_accountid = '' or isnull(ls_accountid) Then
				Messagebox('Error','Please input the Docusign Account Id.',Exclamation!)
				Return
			End If

			If Not gnv_docusign.of_check_sertifi(false,ls_apicode,ls_username,ls_password,false) Then Return
			li_ret = gnv_docusign.of_ping_apicode(ls_username,ls_password,ls_apicode) 
			choose case li_ret 
				case -1
					Messagebox('Docusign Error','Invalid Docusign API Code, please input a valid value.',Exclamation!)
				case -2
					Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue.',Exclamation!)
				case 1
					Messagebox('Docusign','Docusign API Code is OK.')
			end choose

	end choose
end if
end event

