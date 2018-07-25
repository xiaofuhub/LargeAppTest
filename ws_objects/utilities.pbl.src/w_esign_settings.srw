$PBExportHeader$w_esign_settings.srw
forward
global type w_esign_settings from w_response
end type
type dw_1 from u_dw within w_esign_settings
end type
type cb_default from commandbutton within w_esign_settings
end type
type cb_verify from commandbutton within w_esign_settings
end type
type st_1 from statictext within w_esign_settings
end type
type cb_ok from commandbutton within w_esign_settings
end type
type cb_cancel from commandbutton within w_esign_settings
end type
type mle_1 from multilineedit within w_esign_settings
end type
end forward

global type w_esign_settings from w_response
integer width = 1810
integer height = 408
string title = "Electronic Signature Settings"
long backcolor = 33551856
event sys_command pbm_syscommand
dw_1 dw_1
cb_default cb_default
cb_verify cb_verify
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
mle_1 mle_1
end type
global w_esign_settings w_esign_settings

type variables

end variables

event sys_command;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_esign_settings.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_default=create cb_default
this.cb_verify=create cb_verify
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.mle_1=create mle_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_default
this.Control[iCurrent+3]=this.cb_verify
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.mle_1
end on

on w_esign_settings.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_default)
destroy(this.cb_verify)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.mle_1)
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

//Added By Jay Chen 10-18-2013
choose case gs_esigntype
	case 'sertifi'
		dw_1.modify("es_apicode.visible = true")
		dw_1.modify("echo_apicode.visible = false")
		dw_1.modify("t_1.text = 'Sertifi API Code:'")
		mle_1.text = 'The default API code is IntelliSoftGroup, but you can obtain your own API code from https://www.sertifi.com/'
	case 'echosign'
		dw_1.modify("es_apicode.visible = false")
		dw_1.modify("echo_apicode.visible = true")
		dw_1.modify("t_1.text = 'Echosign API Code:'")
		if dw_1.getitemstring(1,"echo_apicode") = 'XY5JXPL2M3X7I8M' then
			mle_1.text = 'The default API code is demo use only, but you can obtain your own API code from https://secure.echosign.com/'
		else
			mle_1.text = 'The default API code is IntelliSoftGroup, but you can obtain your own API code from https://secure.echosign.com/'
		end if
end choose

This.of_setalwaysvalidate( True)


end event

event close;//Override ancestor script
end event

type dw_1 from u_dw within w_esign_settings
integer x = 18
integer y = 56
integer width = 1787
integer height = 104
integer taborder = 30
string dataobject = "d_esign_settings"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
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
ls_apicode_name = dw_1.GetItemString(1,'es_apicode')

If ls_apicode_name = '' Or Isnull(ls_apicode_name) Then Return -1

Return 1
end event

type cb_default from commandbutton within w_esign_settings
boolean visible = false
integer x = 334
integer y = 192
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

event clicked;choose case gs_esigntype //Modified By Jay Chen 10-21-2013
	case 'sertifi'
		dw_1.SetItem(1,'es_apicode','DC1317FF-E03E-475D-87E7-AAE70E8D97A4')
	case 'echosign'
		dw_1.SetItem(1,'echo_apicode','XY5JXPL2M3X7I8M')
end choose


end event

type cb_verify from commandbutton within w_esign_settings
integer x = 1047
integer y = 192
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

event clicked;String ls_apicode
integer li_ret

dw_1.AcceptText() //Added By Ken.Guo 08/17/2012

choose case gs_esigntype //Added By Jay Chen 10-18-2013
	case 'sertifi'
		ls_apicode = dw_1.GetitemString(1,'es_apicode')
		If ls_apicode = '' or isnull(ls_apicode) Then
			Messagebox('Error','Please input the Sertifi API Code.',Exclamation!)
			Return
		End If
		
		If Not gnv_sertifi.of_check_sertifi(false) Then Return
		
         li_ret = gnv_sertifi.of_ping_apicode(ls_apicode) 
			Choose Case li_ret 
				Case -1
					Messagebox('Sertifi Error','Invalid Sertifi API Code, please input a valid value.',Exclamation!)
				Case -2
					Messagebox('Sertifi Error','Cannot connect to Sertifi server. You may experience some network connection issue.',Exclamation!)
				Case 1
					Messagebox('Sertifi','Sertifi API Code is OK.')
			End Choose
		
	case 'echosign'
		ls_apicode = dw_1.GetitemString(1,'echo_apicode')
		If ls_apicode = '' or isnull(ls_apicode) Then
			Messagebox('Error','Please input the Echosign API Code.',Exclamation!)
			Return
		End If
		
		If Not gnv_echosign.of_check_sertifi(false) Then Return
		
         li_ret = gnv_echosign.of_ping_apicode(ls_apicode) 
			Choose Case li_ret 
				Case -1
					Messagebox('Echosign Error','Invalid Echosign API Code, please input a valid value.',Exclamation!)
				Case -2
					Messagebox('Echosign Error','Cannot connect to Echosign server. You may experience some network connection issue.',Exclamation!)
				Case 1
					Messagebox('Echosign','Echosign API Code is OK.')
			End Choose
			
	end choose

Return

end event

type st_1 from statictext within w_esign_settings
boolean visible = false
integer x = 32
integer y = 456
integer width = 1819
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Attention: Web Link Settings will use default value if it don~'t fill data."
boolean focusrectangle = false
end type

type cb_ok from commandbutton within w_esign_settings
integer x = 690
integer y = 192
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

event clicked;If dw_1.update() = 1 Then
	Commit;
	gnv_data.of_retrieve('icred_settings')
Else
	Rollback;
	Messagebox('Save Error','Failed to save data, please call support.')
	Return -1
End If

Close(Parent)
Return 1
end event

type cb_cancel from commandbutton within w_esign_settings
integer x = 1403
integer y = 192
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

type mle_1 from multilineedit within w_esign_settings
boolean visible = false
integer x = 78
integer y = 336
integer width = 1673
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "The default API code is IntelliSoftGroup, but you can obtain your own API code from https://www.sertifi.com/"
boolean border = false
end type

