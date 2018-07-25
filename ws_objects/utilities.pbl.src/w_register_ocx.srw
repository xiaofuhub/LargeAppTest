$PBExportHeader$w_register_ocx.srw
forward
global type w_register_ocx from w_response
end type
type cbx_http from checkbox within w_register_ocx
end type
type st_1 from statictext within w_register_ocx
end type
type cbx_ie from checkbox within w_register_ocx
end type
type cbx_imagecp from checkbox within w_register_ocx
end type
type cbx_email from checkbox within w_register_ocx
end type
type cbx_office from checkbox within w_register_ocx
end type
type cbx_image360 from checkbox within w_register_ocx
end type
type mle_output from multilineedit within w_register_ocx
end type
type cb_cancel from commandbutton within w_register_ocx
end type
type cb_register from commandbutton within w_register_ocx
end type
type gb_1 from groupbox within w_register_ocx
end type
type gb_2 from groupbox within w_register_ocx
end type
end forward

global type w_register_ocx from w_response
integer x = 214
integer y = 221
integer width = 1669
integer height = 604
string title = "Register Plugin"
long backcolor = 33551856
cbx_http cbx_http
st_1 st_1
cbx_ie cbx_ie
cbx_imagecp cbx_imagecp
cbx_email cbx_email
cbx_office cbx_office
cbx_image360 cbx_image360
mle_output mle_output
cb_cancel cb_cancel
cb_register cb_register
gb_1 gb_1
gb_2 gb_2
end type
global w_register_ocx w_register_ocx

forward prototypes
public function integer of_register_image_360 ()
end prototypes

public function integer of_register_image_360 ();Integer i, li_rtn
Long ll_pos
String ls_path
String ls_Controls[5] = {"imgedit.ocx","imgscan.ocx","imgadmin.ocx","imgocr.ocx","imgthumb.ocx"}

n_cst_imaging lnv_imaging
n_cst_appeondll lnv_appeondll

if AppeonGetClientType() = "PB" then Return 0

If lnv_imaging.of_check_windows_imaging( ) Then 
	//------------Begin Modified by Alfee 04.07.2013 -----------------------------------------------
	//MessageBox("Image 360","The Image 360 Plugin is skipped to register due to you have installed Imaging 360 program")
	//Return 0
	li_rtn = MessageBox("Imaging 360","The Imaging 360 has already been installed on your machine. Do you want to install it any more?", Question!, YesNo!)
	IF li_rtn = 2 THEN 	Return 0
	//------------End Modified -------------------------------------------------------------------------
End If

//(V12.3 Cab) - commented by alfee 02.28.2013
//If gs_image_flag <> '1' Then
//	MessageBox("Image 360","The Image 360 plugin is skipped to register, please check the 'Install Imaging Professional' option in the User Painter for '" + gs_user_id+ "'.")
//	Return 0
//End If

IF lnv_imaging.of_install_imaging () = 1 THEN RETURN 1 //(V12.3 Cab) alfee 02.28.2013

If not lnv_imaging.of_isdownload_ocx( ) Then
	If Not lnv_imaging.of_download_ocx() Then
		MessageBox("Image 360","The Image 360 plugin is not registered due to failed to download Imaging 360 OCX files from Web server.")
		Return -1
	End If
End If

If not lnv_imaging.of_registry_imaging( ) then
	MessageBox("Image 360","The Image 360 plugin is not registered due to failed to register the file 'Imaging.reg'.")
	Return -1
End if

FOR i = 1 to UpperBound(ls_Controls)
	run('regsvr32 "' + gs_dllocx_path +ls_Controls [i] + '"') 
NEXT


//If lnv_imaging.of_check_windows_imaging( ) Then 
//	mle_output.text += "Skipped to register Image 360 Plugin: "
//	mle_output.text += '~r~n	You have installed Imaging 360 program, need not register Imaging 360 OCX again.'
//	Return 0
//End If
//
//if AppeonGetClientType() = "PB" then 
//	mle_output.text += "Skipped to register Image 360 Plugin: "
//	mle_output.text += '~r~n	You should install Imaging 360 program manually for a Windows version program'
//	Return 0
//end if
//
//If gs_image_flag <> '1' Then
//	mle_output.text += "Skipped to register Image 360 Plugin: "
//	mle_output.text += '~r~n	Please check the "Install Imaging Professional" option in the User Painter for "' +gs_user_id+ '".'
//	Return 0
//End If
//
//If not lnv_imaging.of_isdownload_ocx( ) Then
//	If Not lnv_imaging.of_download_ocx() Then
//		mle_output.text += "Failed to register Image 360 Plugin: "
//		mle_output.text += '~r~n	Failed to download Imaging 360 OCX files from Web server.'
//		Return -1
//	End If
//End If
//
//If not lnv_imaging.of_registry_imaging( ) then
//	mle_output.text += "Failed to register Image 360 Plugin: "
//	mle_output.text += '~r~n	Failed to register the file of "Imaging.reg".'
//	Return -1
//End if
//
//FOR i = 1 to UpperBound(ls_Controls)
//	if run('regsvr32 -s "' + gs_dllocx_path +ls_Controls [i] + '"') < 0 then
//		mle_output.text += "Failed to register Image 360 Plugin: "
//		mle_output.text += '~r~n	Failed to register the OCX of "' + ls_Controls [i] +'".'
//		Return -1
//	end if
//NEXT
//
//mle_output.text += "Succeed to register Image 360 Plugin. "

Return 1 
end function

on w_register_ocx.create
int iCurrent
call super::create
this.cbx_http=create cbx_http
this.st_1=create st_1
this.cbx_ie=create cbx_ie
this.cbx_imagecp=create cbx_imagecp
this.cbx_email=create cbx_email
this.cbx_office=create cbx_office
this.cbx_image360=create cbx_image360
this.mle_output=create mle_output
this.cb_cancel=create cb_cancel
this.cb_register=create cb_register
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_http
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cbx_ie
this.Control[iCurrent+4]=this.cbx_imagecp
this.Control[iCurrent+5]=this.cbx_email
this.Control[iCurrent+6]=this.cbx_office
this.Control[iCurrent+7]=this.cbx_image360
this.Control[iCurrent+8]=this.mle_output
this.Control[iCurrent+9]=this.cb_cancel
this.Control[iCurrent+10]=this.cb_register
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
end on

on w_register_ocx.destroy
call super::destroy
destroy(this.cbx_http)
destroy(this.st_1)
destroy(this.cbx_ie)
destroy(this.cbx_imagecp)
destroy(this.cbx_email)
destroy(this.cbx_office)
destroy(this.cbx_image360)
destroy(this.mle_output)
destroy(this.cb_cancel)
destroy(this.cb_register)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;If appeongetclienttype() = 'PB' Then
	cbx_image360.checked = False
	cbx_image360.enabled = False
elseif appeongetclienttype() = 'WEB' then  //Start Code Change ----11.28.2012 #V12 maha
	cbx_ie.checked = False
	cbx_ie.enabled = False
end if
	

end event

type cbx_http from checkbox within w_register_ocx
integer x = 1120
integer y = 116
integer width = 485
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "HTTP/FTP Plugin"
boolean checked = true
end type

type st_1 from statictext within w_register_ocx
boolean visible = false
integer x = 59
integer y = 348
integer width = 1477
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
boolean focusrectangle = false
end type

event constructor;//V12.3 Cab - Alfee 03.05.2013

IF AppeonGetClientType() = 'WEB'  THEN
	this.visible = true
	this.text= "You may have to run IE as Administrator to register the OCX files."
END IF
end event

type cbx_ie from checkbox within w_register_ocx
boolean visible = false
integer x = 128
integer y = 504
integer width = 645
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Internet Explorer Plugin"
boolean checked = true
end type

type cbx_imagecp from checkbox within w_register_ocx
integer x = 151
integer y = 220
integer width = 503
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Image  CP Plugin"
boolean checked = true
end type

type cbx_email from checkbox within w_register_ocx
integer x = 151
integer y = 120
integer width = 370
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Plugin"
boolean checked = true
end type

type cbx_office from checkbox within w_register_ocx
integer x = 672
integer y = 116
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Office Plugin"
boolean checked = true
end type

type cbx_image360 from checkbox within w_register_ocx
integer x = 667
integer y = 212
integer width = 713
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Imaging 360 Plugin (WEB)"
end type

type mle_output from multilineedit within w_register_ocx
integer x = 87
integer y = 788
integer width = 1394
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_cancel from commandbutton within w_register_ocx
integer x = 1179
integer y = 412
integer width = 343
integer height = 92
integer taborder = 60
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

type cb_register from commandbutton within w_register_ocx
integer x = 823
integer y = 412
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Register"
boolean default = true
end type

event clicked;String ls_ret, ls_run
//String ls_controls[5]={'emsmtp.dll','OfficeControl.ocx','imageviewer2.ocx','imagethumbnailcp.ocx','scanner.ocx'}

mle_output.text = ""

If cbx_email.checked Then
	Run('Regsvr32 "' + gs_dllocx_path + 'emsmtp.dll"')	
	//---------Begin Modified by (Appeon)Harry 06.11.2013 for V141 ISG-CLX--------
	Run('Regsvr32 "' + gs_dllocx_path + 'empop3.dll"')
	Run('Regsvr32 "' + gs_dllocx_path + 'emmsg.dll"')
	Run('Regsvr32 "' + gs_dllocx_path + 'emssl.dll"')
	//---------End Modfiied ------------------------------------------------------
	
	//---------Begin Added by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
	Run('Regsvr32 "' + gs_dllocx_path + 'emimap4.dll"')
	Run('Regsvr32 "' + gs_dllocx_path + 'EAGetMailObj.dll"')
	Run('Regsvr32 "' + gs_dllocx_path + 'EASendMailObj.dll"')
	//---------End Added ------------------------------------------------------
	
	//	if not fileexists(gs_dllocx_path + 'emsmtp.dll') then
	//		mle_output.text += "Failed to register Email Plugin: "
	//		mle_output.text += '~r~n	The file "' + gs_dllocx_path + 'emsmtp.dll" is not existed. ~r~n'
	//		return 0		
	//	end if
	//	
	//	ls_run = 'Regsvr32 /s "' + gs_dllocx_path + 'emsmtp.dll"'
	//	if Run(ls_run) < 0 then
	//		mle_output.text += "Failed to register Email Plugin: "
	//		mle_output.text += '~r~n	Please check if you have rights to the folder "' + gs_dllocx_path + '"~r~n'		
	//		return 0		
	//	end if
	//	mle_output.text += "Succeed to register Email Plugin.~r~n"
End If

If cbx_office.checked Then	
	//---------Begin Added by (Appeon)Alfee 05.16.2014 for V142 ISG-CLX -------------------
	//<$Reason>It's a Windows system file and should not be included in the program folder.
	//This old version file will cause the office control cannot be registered under Windows 8.1 64 bit.
	If FileExists(gs_dllocx_path + 'urlmon.dll') and Left(Lower(gs_dllocx_path),11) <> 'c:\windows\' Then
		FileDelete (gs_dllocx_path + 'urlmon.dll')	 
	End If
	//---------End Added ----------------------------------------------------------------------------	

	Run('Regsvr32 "' + gs_dllocx_path + 'OfficeControl.ocx"')	
	//	if not fileexists(gs_dllocx_path + 'OfficeControl.ocx') then
	//		mle_output.text += "Failed to register Office Plugin: "
	//		mle_output.text += '~r~n	The file "' + gs_dllocx_path + 'OfficeControl.ocx" is not existed.~r~n'
	//		return 0		
	//	end if	
	//	
	//	ls_run = 'Regsvr32 /s "' + gs_dllocx_path + 'OfficeControl.ocx"'
	//	if Run(ls_run) < 0 then
	//		mle_output.text += "Failed to register Office Plugin: "
	//		mle_output.text += '~r~n	Please check if you have rights to the folder of "' + gs_dllocx_path + '"~r~n'		
	//		return 0		
	//	end if
	//	mle_output.text += "Succeed to register Office Plugin.~r~n"
	
	// check register for word2013 and above
	of_reg_office() //(Appeon) Added by Harry 08.31.2016
End If

If cbx_imagecp.checked Then
	Run('Regsvr32 "' + gs_dllocx_path + 'imageviewer2.ocx"')	
	Run('Regsvr32 "' + gs_dllocx_path + 'imagethumbnailcp.ocx"')
	Run('Regsvr32 "' + gs_dllocx_path + 'scanner.ocx"')
	//	if not fileexists(gs_dllocx_path + 'imageviewer2.ocx') then
	//		mle_output.text += "Failed to register Image CP Plugin: "
	//		mle_output.text += '~r~n	The file "' + gs_dllocx_path + 'imageviewer2.ocx" is not existed.~r~n'
	//		return 0		
	//	end if		
	//	ls_run = 'Regsvr32 /s "' + gs_dllocx_path + 'imageviewer2.ocx"'
	//	if Run(ls_run) < 0 then
	//		mle_output.text += "Failed to register Image CP Plugin: "
	//		mle_output.text += '~r~n	Please check if you have rights to the folder of "' + gs_dllocx_path + '"~r~n'		
	//		return 0		
	//	end if
	//	ls_run = 'Regsvr32 /s "' + gs_dllocx_path + 'imagethumbnailcp.ocx"'
	//	Run(ls_run)
	//	ls_run = 'Regsvr32 /s "' + gs_dllocx_path + 'scanner.ocx"'
	//	Run(ls_run)
	//	mle_output.text += "Succeed to register Image CP Plugin.~r~n"	
End If

//Added by Appeon long.zhang 06.15.2016 (Case # 00064501: Issue with a New Install )
If cbx_http.Checked Then
	Run('Regsvr32 "' + gs_dllocx_path + 'wodHttp.ocx"')	
	Run('Regsvr32 "' + gs_dllocx_path + 'wodFtpDLX.dll"')
End If
//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 ISG-CLX--------
////------------------- APPEON BEGIN -------------------
////$<add> Stephen 11.21.2012
////$<reason> Problems mapping web form for Women's Care Florida.
//If cbx_ie.checked then
//	long ll_ret
//	ulong ll_tst
//	IF appeongetclienttype() <> 'WEB' then
//		ll_ret = RegistryGet("HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_USE_WINDOWEDSELECTCONTROL","PB115.EXE",regulong!,ll_tst)
//		if ll_ret <> 1 or ll_tst <> 1 then
//			ll_tst = 1
//			RegistrySet("HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_USE_WINDOWEDSELECTCONTROL","PB115.EXE",regulong!,ll_tst)
//		end if
//	end if
//End if
////Start Code Change ----02.13.2013 #V12 maha
//If cbx_ie.checked then
//	IF appeongetclienttype() <> 'WEB' then
//		ll_ret = RegistryGet("HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_USE_WINDOWEDSELECTCONTROL","INTELLICRED.EXE",regulong!,ll_tst)
//		if ll_ret <> 1 or ll_tst <> 1 then
//			ll_tst = 1
//			RegistrySet("HKEY_LOCAL_MACHINE\Software\Microsoft\Internet Explorer\MAIN\FeatureControl\FEATURE_USE_WINDOWEDSELECTCONTROL","INTELLICRED.EXE",regulong!,ll_tst)
//		end if
//	end if
//End if
////End Code Change ----02.13.2013 #V12
////------------------- APPEON END -------------------
//---------End Commented ------------------------------------------------------

If cbx_image360.checked Then
	of_register_image_360()
End If



end event

type gb_1 from groupbox within w_register_ocx
integer x = 59
integer y = 44
integer width = 1545
integer height = 280
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Plugin List"
end type

type gb_2 from groupbox within w_register_ocx
integer x = 50
integer y = 728
integer width = 1467
integer height = 184
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Output"
end type

