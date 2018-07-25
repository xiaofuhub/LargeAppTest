$PBExportHeader$w_ad_account_verify.srw
forward
global type w_ad_account_verify from w_response
end type
type sle_pwd from singlelineedit within w_ad_account_verify
end type
type sle_user from singlelineedit within w_ad_account_verify
end type
type sle_server from singlelineedit within w_ad_account_verify
end type
type st_3 from statictext within w_ad_account_verify
end type
type st_2 from statictext within w_ad_account_verify
end type
type cb_2 from commandbutton within w_ad_account_verify
end type
type st_1 from statictext within w_ad_account_verify
end type
type cb_verify from commandbutton within w_ad_account_verify
end type
end forward

global type w_ad_account_verify from w_response
integer width = 1376
integer height = 592
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
sle_pwd sle_pwd
sle_user sle_user
sle_server sle_server
st_3 st_3
st_2 st_2
cb_2 cb_2
st_1 st_1
cb_verify cb_verify
end type
global w_ad_account_verify w_ad_account_verify

on w_ad_account_verify.create
int iCurrent
call super::create
this.sle_pwd=create sle_pwd
this.sle_user=create sle_user
this.sle_server=create sle_server
this.st_3=create st_3
this.st_2=create st_2
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_verify=create cb_verify
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_pwd
this.Control[iCurrent+2]=this.sle_user
this.Control[iCurrent+3]=this.sle_server
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_verify
end on

on w_ad_account_verify.destroy
call super::destroy
destroy(this.sle_pwd)
destroy(this.sle_user)
destroy(this.sle_server)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_verify)
end on

event open;call super::open;//====================================================================
// Event: open
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

String ls_domain
str_ad_pass lstr_ad_pass
n_cst_systeminfo lnv_systeminfo
lnv_systeminfo = Create n_cst_systeminfo
lstr_ad_pass = Message.powerobjectparm
//sle_server.text = lstr_ad_pass.ls_server

sle_server.text  = lnv_systeminfo.of_get_domaindnsname( )
sle_user.text = lstr_ad_pass.ls_user
If sle_server.text <> '' Then
	sle_server.displayonly = True
	//sle_server.backcolor = RGB(192,192,192)
	sle_server.backcolor = RGB(243,243,243)
	sle_user.displayonly = True
	//sle_user.backcolor = RGB(192,192,192)	
	sle_user.backcolor = RGB(243,243,243)	
End If

If sle_server.text = '' Then
	sle_server.setfocus( )
ElseIf sle_user.text = '' Then
	sle_user.setfocus( )
Else
	sle_pwd.setfocus()
End If
end event

type sle_pwd from singlelineedit within w_ad_account_verify
integer x = 549
integer y = 296
integer width = 759
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_user from singlelineedit within w_ad_account_verify
integer x = 549
integer y = 172
integer width = 759
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type sle_server from singlelineedit within w_ad_account_verify
integer x = 549
integer y = 40
integer width = 759
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_ad_account_verify
integer x = 64
integer y = 312
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Password:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ad_account_verify
integer x = 64
integer y = 184
integer width = 443
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "AD User Name:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ad_account_verify
integer x = 942
integer y = 436
integer width = 343
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_ad_account_verify
integer x = 64
integer y = 60
integer width = 485
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "AD Server Name/IP:"
boolean focusrectangle = false
end type

type cb_verify from commandbutton within w_ad_account_verify
integer x = 576
integer y = 436
integer width = 343
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
boolean default = true
end type

event clicked;String ls_server, ls_user, ls_pwd,ls_error
n_cst_ad lnv_ad  
lnv_ad = Create n_cst_ad

ls_server = sle_server.text
ls_user = sle_user.text
ls_pwd = sle_pwd.text

If ls_server = '' Then
	Messagebox('AD Verify','The AD Server Name/IP cannot be empty.',Exclamation!)
	Destroy lnv_ad
	Return
End If
If ls_user = '' Then
	Messagebox('AD Verify','The AD User Name cannot be empty.',Exclamation!)
	Destroy lnv_ad
	Return
End If

If lnv_ad.of_connect_ad( ls_server, ls_user, ls_pwd, ls_error) = 0 Then
	//Messagebox('AD Verify','Successful.')
Else
	Messagebox('AD Verify','Failure. '  +ls_error,Exclamation!)
	Destroy lnv_ad
	Return 
End If

Messagebox('AD Verify','Successful.')
Destroy lnv_ad

end event

