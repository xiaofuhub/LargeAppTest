$PBExportHeader$w_ad_server_verify.srw
forward
global type w_ad_server_verify from w_response
end type
type mle_2 from multilineedit within w_ad_server_verify
end type
type cbx_verify_client from checkbox within w_ad_server_verify
end type
type mle_1 from multilineedit within w_ad_server_verify
end type
type st_4 from statictext within w_ad_server_verify
end type
type cbx_verify from checkbox within w_ad_server_verify
end type
type sle_pwd from singlelineedit within w_ad_server_verify
end type
type sle_user from singlelineedit within w_ad_server_verify
end type
type sle_server from singlelineedit within w_ad_server_verify
end type
type st_3 from statictext within w_ad_server_verify
end type
type st_2 from statictext within w_ad_server_verify
end type
type st_1 from statictext within w_ad_server_verify
end type
type cb_save from commandbutton within w_ad_server_verify
end type
type gb_1 from groupbox within w_ad_server_verify
end type
type gb_2 from groupbox within w_ad_server_verify
end type
type cb_2 from commandbutton within w_ad_server_verify
end type
end forward

global type w_ad_server_verify from w_response
integer x = 214
integer y = 221
integer width = 1678
integer height = 828
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
mle_2 mle_2
cbx_verify_client cbx_verify_client
mle_1 mle_1
st_4 st_4
cbx_verify cbx_verify
sle_pwd sle_pwd
sle_user sle_user
sle_server sle_server
st_3 st_3
st_2 st_2
st_1 st_1
cb_save cb_save
gb_1 gb_1
gb_2 gb_2
cb_2 cb_2
end type
global w_ad_server_verify w_ad_server_verify

type variables
n_cst_encrypt in_encrypt //Added by Appeon long.zhang 03.16.2017 (Major AD Authentication Bug)
end variables

on w_ad_server_verify.create
int iCurrent
call super::create
this.mle_2=create mle_2
this.cbx_verify_client=create cbx_verify_client
this.mle_1=create mle_1
this.st_4=create st_4
this.cbx_verify=create cbx_verify
this.sle_pwd=create sle_pwd
this.sle_user=create sle_user
this.sle_server=create sle_server
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_save=create cb_save
this.gb_1=create gb_1
this.gb_2=create gb_2
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_2
this.Control[iCurrent+2]=this.cbx_verify_client
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.st_4
this.Control[iCurrent+5]=this.cbx_verify
this.Control[iCurrent+6]=this.sle_pwd
this.Control[iCurrent+7]=this.sle_user
this.Control[iCurrent+8]=this.sle_server
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cb_save
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
this.Control[iCurrent+15]=this.cb_2
end on

on w_ad_server_verify.destroy
call super::destroy
destroy(this.mle_2)
destroy(this.cbx_verify_client)
destroy(this.mle_1)
destroy(this.st_4)
destroy(this.cbx_verify)
destroy(this.sle_pwd)
destroy(this.sle_user)
destroy(this.sle_server)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_save)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.cb_2)
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
String ls_pwd //Added by Appeon long.zhang 03.16.2017

If gnv_user_option.of_get_option_value('ad_server_need_verify') = '1' Then
	cbx_verify.checked = True
Else
	cbx_verify.checked = False
End If
cbx_verify.  event clicked( )

If gnv_user_option.of_get_option_value('ad_server_need_verify_client') = '1' Then
	cbx_verify_client.checked = True
Else
	cbx_verify_client.checked = False
End If

If gnv_user_option.of_get_option_value('ad_verify_server_name') <> '' Then
	sle_server.text = gnv_user_option.of_get_option_value('ad_verify_server_name')
End If

If gnv_user_option.of_get_option_value('ad_verify_user_name') <> '' Then
	sle_user.text = gnv_user_option.of_get_option_value('ad_verify_user_name')
End If

If gnv_user_option.of_get_option_value('ad_verify_pwd') <> '' Then
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 03.16.2017
	//<$>reason:Major AD Authentication Bug
	//sle_pwd.text = gnv_user_option.of_get_option_value('ad_verify_pwd')
	ls_pwd = gnv_user_option.of_get_option_value('ad_verify_pwd')
	ls_pwd = in_encrypt.of_decrypt( ls_pwd)  //Decrypt
	sle_pwd.text = ls_pwd
	//------------------- APPEON END -------------------

End If



end event

type mle_2 from multilineedit within w_ad_server_verify
integer x = 105
integer y = 1376
integer width = 1541
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Note: Check the client environment before using the AD function. Only after the client logs into the domain, can he use the AD function."
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cbx_verify_client from checkbox within w_ad_server_verify
integer x = 96
integer y = 1292
integer width = 1554
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verify the client environment before using the AD function (Optional)  "
end type

type mle_1 from multilineedit within w_ad_server_verify
integer x = 91
integer y = 124
integer width = 1509
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Note: Before using the AD function, the system will use the following account to check if the AD server is working correctly."
boolean border = false
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type st_4 from statictext within w_ad_server_verify
integer x = 110
integer y = 140
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
boolean focusrectangle = false
end type

type cbx_verify from checkbox within w_ad_server_verify
integer x = 82
integer y = 48
integer width = 1527
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verify the AD server before using the AD function (Optional)  "
end type

event clicked;If Not this.checked Then
	sle_server.displayonly = True
	//sle_server.backcolor = RGB(192,192,192)
	sle_server.backcolor = RGB(243,243,243)
	sle_user.displayonly = True
	//sle_user.backcolor = RGB(192,192,192)
	sle_user.backcolor = RGB(243,243,243)
	sle_pwd.displayonly = True
	//sle_pwd.backcolor = RGB(192,192,192)	
	sle_pwd.backcolor = RGB(243,243,243)
Else
	sle_server.displayonly = False
	sle_server.backcolor = RGB(255,255,255)
	sle_user.displayonly = False
	sle_user.backcolor = RGB(255,255,255)
	sle_pwd.displayonly = False
	sle_pwd.backcolor = RGB(255,255,255)	
End If


end event

type sle_pwd from singlelineedit within w_ad_server_verify
integer x = 571
integer y = 508
integer width = 791
integer height = 92
integer taborder = 30
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

type sle_user from singlelineedit within w_ad_server_verify
integer x = 571
integer y = 384
integer width = 791
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type sle_server from singlelineedit within w_ad_server_verify
integer x = 571
integer y = 256
integer width = 791
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_ad_server_verify
integer x = 110
integer y = 524
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

type st_2 from statictext within w_ad_server_verify
integer x = 110
integer y = 396
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

type st_1 from statictext within w_ad_server_verify
integer x = 110
integer y = 272
integer width = 475
integer height = 72
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

type cb_save from commandbutton within w_ad_server_verify
integer x = 896
integer y = 668
integer width = 343
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;String ls_server, ls_user, ls_pwd,ls_error
n_cst_ad lnv_ad  
lnv_ad = Create n_cst_ad

ls_server = sle_server.text
ls_user = sle_user.text
ls_pwd = sle_pwd.text

If ls_server = '' Then
	Messagebox('Save','The AD Server Name/IP cannot be empty.',Exclamation!)
	Destroy lnv_ad
	Return
End If
If ls_user = '' Then
	Messagebox('Save','The AD User Name cannot be empty.',Exclamation!)
	Destroy lnv_ad
	Return
End If

If cbx_verify.checked Then
	If lnv_ad.of_connect_ad( ls_server, ls_user, ls_pwd, ls_error) = 0 Then
		//Messagebox('Save','Successful.')
	Else
		Messagebox('Save','Failure. '  +ls_error,Exclamation!)
		Destroy lnv_ad
		Return
	End If
End If

If cbx_verify.checked Then
	gnv_user_option.of_set_option_value('ad_server_need_verify',  '1' )
Else
	gnv_user_option.of_set_option_value('ad_server_need_verify',  '0' )
End If

If cbx_verify_client.checked Then
	gnv_user_option.of_set_option_value('ad_server_need_verify_client',  '1' )
Else
	gnv_user_option.of_set_option_value('ad_server_need_verify_client',  '0' )
End If

gnv_user_option.of_set_option_value('ad_verify_server_name',  sle_server.text )
gnv_user_option.of_set_option_value('ad_verify_user_name',  sle_user.text )

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 03.16.2017
//<$>reason:Major AD Authentication Bug
//gnv_user_option.of_set_option_value('ad_verify_pwd',  sle_pwd.text )
ls_pwd = in_encrypt.of_encrypt(ls_pwd) //Encrypt
gnv_user_option.of_set_option_value('ad_verify_pwd',  ls_pwd )
//------------------- APPEON END -------------------

gnv_user_option.of_system_save( ) 
Messagebox('Save','Successful.')

Destroy lnv_ad
end event

type gb_1 from groupbox within w_ad_server_verify
integer x = 37
integer y = 52
integer width = 1595
integer height = 588
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type gb_2 from groupbox within w_ad_server_verify
integer x = 50
integer y = 1300
integer width = 1614
integer height = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type cb_2 from commandbutton within w_ad_server_verify
integer x = 1262
integer y = 668
integer width = 343
integer height = 104
integer taborder = 50
boolean bringtotop = true
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

