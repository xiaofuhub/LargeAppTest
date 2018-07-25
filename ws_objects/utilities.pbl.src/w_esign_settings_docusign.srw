$PBExportHeader$w_esign_settings_docusign.srw
forward
global type w_esign_settings_docusign from w_response
end type
type cb_1 from commandbutton within w_esign_settings_docusign
end type
type rb_2 from radiobutton within w_esign_settings_docusign
end type
type rb_1 from radiobutton within w_esign_settings_docusign
end type
type mle_1 from multilineedit within w_esign_settings_docusign
end type
type dw_1 from u_dw within w_esign_settings_docusign
end type
type cb_default from commandbutton within w_esign_settings_docusign
end type
type cb_verify from commandbutton within w_esign_settings_docusign
end type
type st_1 from statictext within w_esign_settings_docusign
end type
type cb_ok from commandbutton within w_esign_settings_docusign
end type
type cb_cancel from commandbutton within w_esign_settings_docusign
end type
type gb_1 from groupbox within w_esign_settings_docusign
end type
type gb_2 from groupbox within w_esign_settings_docusign
end type
end forward

global type w_esign_settings_docusign from w_response
integer x = 214
integer y = 221
integer width = 1883
integer height = 1200
string title = "Electronic Signature Settings"
long backcolor = 33551856
event sys_command pbm_syscommand
cb_1 cb_1
rb_2 rb_2
rb_1 rb_1
mle_1 mle_1
dw_1 dw_1
cb_default cb_default
cb_verify cb_verify
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
gb_2 gb_2
end type
global w_esign_settings_docusign w_esign_settings_docusign

type variables

end variables

forward prototypes
public function integer of_save ()
end prototypes

event sys_command;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

public function integer of_save ();string ls_mode,ls_apicode,ls_apicode2
long ll_cnt

dw_1.accepttext( )
//Added By Jay Chen 09-03-2014
if rb_1.checked then
	ls_mode = "global_license"
elseif rb_2.checked then
	ls_mode = "personal_license"
end if

//check docusign apicode if or not modify
ls_apicode = dw_1.getitemstring(1,'docusign_apicode',Primary!,true)
ls_apicode2 = dw_1.getitemstring(1,'docusign_apicode',Primary!,false)
if ls_apicode <> ls_apicode2 then
	select count(*) into :ll_cnt from ctx_am_document where esign_type = 'docusign' and es_license_user_id = 'global_license_user' and es_apicode = :ls_apicode;
	if isnull(ll_cnt) then ll_cnt = 0
	if ll_cnt < 1 then
		select count(*) into :ll_cnt from ctx_am_doc_audit where esign_type = 'docusign' and es_license_user_id = 'global_license_user' and es_apicode = :ls_apicode;
		if isnull(ll_cnt) then ll_cnt = 0
	end if
	if ll_cnt > 0 then
		if Messagebox('IntelliSoftGroup','The system has detected that this API code has been used for sending document signing requests. You will not be able to check the signing status for those documents if you change it. Do you want to continue?',Exclamation!, YesNo!, 2) = 2 then
			dw_1.setfocus()
			dw_1.SetColumn('docusign_apicode')
			return -1
		end if
	end if
end if

If dw_1.update() = 1 Then
	Commit;
	gnv_data.of_retrieve('icred_settings')
	if gnv_user_option.of_get_option_value(gs_user_id, "docusign_license_mode" ) <> ls_mode then //Added By Jay Chen 09-05-2014
		gnv_docusign.ib_isvalid_sertifi = false
	end if
	gnv_user_option.of_Set_option_value(gs_user_id, "docusign_license_mode",ls_mode )
	gnv_user_option.of_save( )
Else
	Rollback;
	Messagebox('Save Error','Failed to save data, please call support.')
	Return -1
End If


Return 1
end function

on w_esign_settings_docusign.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.rb_2=create rb_2
this.rb_1=create rb_1
this.mle_1=create mle_1
this.dw_1=create dw_1
this.cb_default=create cb_default
this.cb_verify=create cb_verify
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.rb_2
this.Control[iCurrent+3]=this.rb_1
this.Control[iCurrent+4]=this.mle_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_default
this.Control[iCurrent+7]=this.cb_verify
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.cb_ok
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_esign_settings_docusign.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.mle_1)
destroy(this.dw_1)
destroy(this.cb_default)
destroy(this.cb_verify)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// Event: open()
// Arguments:
//--------------------------------------------------------------------
// Return:  long
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-05-26.
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

This.of_setalwaysvalidate( True)

//Added By Jay Chen 09-03-2014
string ls_mode
ls_mode = gnv_user_option.of_get_option_value(gs_user_id, "docusign_license_mode" )
if isnull(ls_mode) or ls_mode = '' then ls_mode = "global_license"
if ls_mode = "global_license" then
	rb_1.checked = true
else
	rb_2.checked = true
	cb_default.enabled = false
	cb_verify.enabled = false
	dw_1.object.datawindow.readonly = true
end if

end event

event close;//Override ancestor script
end event

event pfc_save;//Added By Jay Chen 09-04-2014
cb_ok.triggerevent(clicked!)
return 1
end event

event closequery;//Override ancestor script
end event

type cb_1 from commandbutton within w_esign_settings_docusign
integer x = 1298
integer y = 856
integer width = 146
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "..."
boolean cancel = true
end type

event clicked;OpenWithParm(w_security_license_user,gs_user_id)
end event

type rb_2 from radiobutton within w_esign_settings_docusign
integer x = 699
integer y = 864
integer width = 617
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Personal License"
end type

event clicked;dw_1.accepttext()
if this.checked then
	cb_default.enabled = false
	cb_verify.enabled = false
	dw_1.object.datawindow.readonly = true
end if
end event

type rb_1 from radiobutton within w_esign_settings_docusign
integer x = 64
integer y = 864
integer width = 558
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Use Global License"
boolean checked = true
end type

event clicked;if this.checked then
	cb_default.enabled = true
	cb_verify.enabled = true
	dw_1.object.datawindow.readonly = false
end if
end event

type mle_1 from multilineedit within w_esign_settings_docusign
integer x = 50
integer y = 640
integer width = 1765
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The default API code is IntelliSoftGroup, but you can obtain your own API code from https://www.docusign.com/"
boolean border = false
boolean displayonly = true
end type

type dw_1 from u_dw within w_esign_settings_docusign
integer x = 59
integer y = 44
integer width = 1751
integer height = 608
integer taborder = 30
string dataobject = "d_esign_settings_docusign"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable( True)

end event

event pfc_validation;call super::pfc_validation;//////////////////////////////////////////////////////////////////////
// $<event>dw_weblink::pfc_validation()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-30 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_apicode_name
This.AcceptText()
ls_apicode_name = dw_1.GetItemString(1,'docusign_apicode')

If ls_apicode_name = '' Or Isnull(ls_apicode_name) Then Return -1

Return 1
end event

type cb_default from commandbutton within w_esign_settings_docusign
integer x = 434
integer y = 996
integer width = 352
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Load Default"
end type

event clicked;//dw_1.SetItem(1,'docusign_apicode','APPE-c19b1299-2bac-45fc-9b1b-3440e91b7285')
//dw_1.SetItem(1,'docusign_username','ken.guo@appeon.com')
//dw_1.SetItem(1,'docusign_password','appeon0101')
//dw_1.SetItem(1,'docusign_userid','3e9bcfac-9e05-4514-9aac-450a9ba31c22')
//dw_1.SetItem(1,'docusign_accountid','0990bb99-cfb3-43ff-91af-64060b95b0d7')

dw_1.SetItem(1,'docusign_apicode','')
dw_1.SetItem(1,'docusign_username','')
dw_1.SetItem(1,'docusign_password','')
dw_1.SetItem(1,'docusign_userid','')
dw_1.SetItem(1,'docusign_accountid','')
end event

type cb_verify from commandbutton within w_esign_settings_docusign
integer x = 1147
integer y = 996
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;String ls_apicode,ls_username,ls_password,ls_userid,ls_accountid
integer li_ret

dw_1.AcceptText()
If of_save() < 1 Then Return -1  //(Appeon) Added by Harry 07.27.2016 - BugL072601

ls_apicode = dw_1.GetitemString(1,'docusign_apicode')
If ls_apicode = '' or isnull(ls_apicode) Then
	Messagebox('Error','Please input the Docusign API Code.',Exclamation!)
	Return
End If
ls_username = dw_1.GetitemString(1,'docusign_username')
If ls_username = '' or isnull(ls_username) Then
	Messagebox('Error','Please input the Docusign User Name.',Exclamation!)
	Return
End If
ls_password = dw_1.GetitemString(1,'docusign_password')
If ls_password = '' or isnull(ls_password) Then
	Messagebox('Error','Please input the Docusign Password.',Exclamation!)
	Return
End If
ls_userid = dw_1.GetitemString(1,'docusign_userid')
If ls_userid = '' or isnull(ls_userid) Then
	Messagebox('Error','Please input the Docusign User Id.',Exclamation!)
	Return
End If
ls_accountid = dw_1.GetitemString(1,'docusign_accountid')
If ls_accountid = '' or isnull(ls_accountid) Then
	Messagebox('Error','Please input the Docusign Account Id.',Exclamation!)
	Return
End If
		
If Not gnv_docusign.of_check_sertifi(false) Then Return
		
li_ret = gnv_docusign.of_ping_apicode(ls_username,ls_password,ls_apicode) 
Choose Case li_ret 
	Case -1
		Messagebox('Docusign Error','Invalid Docusign API Code, please input a valid value.',Exclamation!)
	Case -2
		Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue.',Exclamation!)
	Case 1
		Messagebox('Docusign','Docusign API Code is OK.')
End Choose


Return

end event

type st_1 from statictext within w_esign_settings_docusign
boolean visible = false
integer x = 59
integer y = 1128
integer width = 1819
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 33551856
string text = "Attention: Web Link Settings will use default value if it don~'t fill data."
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_esign_settings_docusign
integer x = 791
integer y = 996
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;
If of_save() < 1 Then Return -1  //(Appeon) Added by Harry 07.27.2016 - BugL072601

Close(Parent)
Return 1
end event

type cb_cancel from commandbutton within w_esign_settings_docusign
integer x = 1504
integer y = 996
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_esign_settings_docusign
integer x = 27
integer width = 1815
integer height = 788
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Global License"
end type

type gb_2 from groupbox within w_esign_settings_docusign
integer x = 27
integer y = 784
integer width = 1815
integer height = 200
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "License Mode"
end type

