$PBExportHeader$w_export_apps.srw
forward
global type w_export_apps from window
end type
type st_3 from statictext within w_export_apps
end type
type dw_app_list from datawindow within w_export_apps
end type
type cb_7 from commandbutton within w_export_apps
end type
type st_2 from statictext within w_export_apps
end type
type sle_email_address from singlelineedit within w_export_apps
end type
type cb_6 from commandbutton within w_export_apps
end type
type cb_5 from commandbutton within w_export_apps
end type
type st_1 from statictext within w_export_apps
end type
type dw_fld_prop from datawindow within w_export_apps
end type
type dw_app_hdr from datawindow within w_export_apps
end type
type dw_2 from datawindow within w_export_apps
end type
type cb_4 from commandbutton within w_export_apps
end type
type cb_3 from commandbutton within w_export_apps
end type
type cb_2 from commandbutton within w_export_apps
end type
type cb_1 from commandbutton within w_export_apps
end type
type dw_1 from datawindow within w_export_apps
end type
end forward

global type w_export_apps from window
integer x = 5
integer y = 4
integer width = 3621
integer height = 2344
boolean titlebar = true
string title = "Export Applications"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
st_3 st_3
dw_app_list dw_app_list
cb_7 cb_7
st_2 st_2
sle_email_address sle_email_address
cb_6 cb_6
cb_5 cb_5
st_1 st_1
dw_fld_prop dw_fld_prop
dw_app_hdr dw_app_hdr
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_export_apps w_export_apps

on w_export_apps.create
this.st_3=create st_3
this.dw_app_list=create dw_app_list
this.cb_7=create cb_7
this.st_2=create st_2
this.sle_email_address=create sle_email_address
this.cb_6=create cb_6
this.cb_5=create cb_5
this.st_1=create st_1
this.dw_fld_prop=create dw_fld_prop
this.dw_app_hdr=create dw_app_hdr
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.dw_app_list,&
this.cb_7,&
this.st_2,&
this.sle_email_address,&
this.cb_6,&
this.cb_5,&
this.st_1,&
this.dw_fld_prop,&
this.dw_app_hdr,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_export_apps.destroy
destroy(this.st_3)
destroy(this.dw_app_list)
destroy(this.cb_7)
destroy(this.st_2)
destroy(this.sle_email_address)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.dw_fld_prop)
destroy(this.dw_app_hdr)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.SetTransObject( sqlca )
dw_1.Retrieve( )

dw_app_hdr.SetTransObject( SQLCA )
dw_fld_prop.SetTransObject( SQLCA )
end event

type st_3 from statictext within w_export_apps
integer x = 50
integer y = 36
integer width = 645
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Type Application Name:"
boolean focusrectangle = false
end type

type dw_app_list from datawindow within w_export_apps
boolean visible = false
integer x = 3136
integer y = 1668
integer width = 279
integer height = 224
integer taborder = 90
string dataobject = "d_app_lists"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject( sqlca )
This.Retrieve( )
end event

type cb_7 from commandbutton within w_export_apps
integer x = 3113
integer y = 988
integer width = 439
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Create List"
end type

event clicked;dw_app_list.SaveAs( "c:\applist.csv", CSV!, True )
end event

type st_2 from statictext within w_export_apps
integer x = 59
integer y = 2092
integer width = 421
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Email Address:"
boolean focusrectangle = false
end type

type sle_email_address from singlelineedit within w_export_apps
integer x = 485
integer y = 2084
integer width = 1893
integer height = 92
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_6 from commandbutton within w_export_apps
integer x = 3113
integer y = 816
integer width = 439
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Email"
end type

event clicked;mailSession mSes

mailReturnCode mRet
mailMessage mMsg
mailFileDescription nfile1
String ls_attach
String ls_file
String ls_email_address 
String ls_salutation
String ls_subject
String ls_emp_mail_logon = "Johnd"
Integer i

long		ll_Return

n_cst_easymail_smtp 	lnv_Mail

ls_email_address = sle_email_address.Text


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06/13/2007 By: Ken.Guo
//$<reason> Send Email

		/*
		// Create a mail session
		mSes = create mailSession
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-01
		//$<add> 01.25.2006 By: LeiWei
		//$<reason> mailSession is currently unsupported.
		//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet.  
		mRet = mailReturnSuccess!
		//---------------------------- APPEON END ----------------------------
		// Log on to the session
		
		FOR i = 1 TO 1000
		
			IF IsNull( ls_salutation ) OR ls_salutation = "" THEN
				ls_salutation = "Hello," + "~n" + "~n"
			END IF
		
			IF i < 10 THEN
				ls_attach = "s:\appexport\Apps.ZIP.z0" + String( i ) 
				ls_file = "Apps.ZIP.z0" + String( i ) 
			ELSE
				ls_attach = "s:\appexport\Apps.ZIP.z" + String( i ) 
				ls_file = "Apps.ZIP.z" + String( i ) 		
			END IF
		
			IF NOT FileExists( ls_attach ) THEN
				Exit
			END IF
		//mRet = mSes.mailLogon( ls_emp_mail_logon ,"",mailNewSession!)
			mRet = mSes.mailLogon( mailNewSession!) //maha 042005
			IF mRet <> mailReturnSuccess! THEN
				MessageBox("Mail", 'Logon failed.')
				RETURN
			END IF
			
			// Populate the attachment object
			nfile1.FileType = MailAttach!
			nfile1.FileName = ls_file
			nfile1.PathName = ls_attach
			nfile1.position = 1
			mMsg.AttachmentFile[1] = nfile1	
		
			//Populate the mailMessage structure
			mMsg.Subject = "Applications File " + String (i)
			mMsg.NoteText = "Save the attached " + ls_file + " file to your c:\IntelliApp\Applications directory~n~r" +&
								 "for complete instruction on importing applications see the email with the subject ****Applications File 1****"
			mMsg.Recipient[1].name = ls_email_address
		
			//Send the mail
			mRet = mSes.mailSend(mMsg)
			IF mRet <> mailReturnSuccess! THEN
				MessageBox("Mail Send", 'Mail not sent')
				RETURN
			END IF
		
		END FOR
		
		//mRet = mSes.mailLogon( ls_emp_mail_logon ,"",mailNewSession!)
		mRet = mSes.mailLogon( mailNewSession!) //maha 042005
		IF mRet <> mailReturnSuccess! THEN
			MessageBox("Mail", 'Logon failed.')
			RETURN
		END IF
		
		//// Populate the attachment object
		nfile1.FileType = MailAttach!
		nfile1.FileName = "Apps.zip"
		nfile1.PathName = "s:\appexport\Apps.zip"
		nfile1.position = 1
		mMsg.AttachmentFile[1] = nfile1	
		
		//Populate the mailMessage structure
		mMsg.Subject = "*****Applications File 1*****"
		mMsg.NoteText = "Please complete the following steps to import your requested credentialing applications into IntelliApp SE.~n~r" +&
							 "Attached is a zip file with your applications.~n~r" + &
							 "1) Save the attached Apps.zip file to your c:\IntelliApp\Applications\~n~r" + &
							 "2) If you receive more than one email from IntelliSoft Group go to each email and save the attachment to c:\IntelliApp\Applications\~n~r" + &
							 "3) Open up the IntelliApp SE Software ~n~r" +&
							 "4) Click on the Import Apps menu icon ~n~r" +&
							 "5) Click the Import Applications Button~n~r"+&
							 "Your applications will be imported into IntelliApp SE and ready for use.~n~r" +&
							 "If you have any question please contact IntelliSoft Group at 888-634-4464."
							 
		mMsg.Recipient[1].name = ls_email_address
		
		//Send the mail
		mRet = mSes.mailSend(mMsg)
		IF mRet <> mailReturnSuccess! THEN
			MessageBox("Mail Send", 'Mail not sent')
			RETURN
		END IF
		
		
		
		mSes.mailLogoff()
		DESTROY mSes
		*/


String ls_address_mailcc,ls_attachments
String ls_notetext
FOR i = 1 TO 1000
	IF i < 10 THEN
		ls_attach = "s:\appexport\Apps.ZIP.z0" + String( i ) 
		ls_file = "Apps.ZIP.z0" + String( i ) 
	ELSE
		ls_attach = "s:\appexport\Apps.ZIP.z" + String( i ) 
		ls_file = "Apps.ZIP.z" + String( i ) 		
	END IF
	IF NOT FileExists( ls_attach ) THEN
		Exit
	Else
		ls_attach = ls_attach + ',' + ls_file
	END IF
Next


ls_subject = "Applications File(s)"
ls_notetext = "Save the attached file(s) to your c:\IntelliApp\Applications directory~n~r" +&
					 "for complete instruction on importing applications see the email with the subject ****Applications File 1****"

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//IF lnv_redemption_mail.of_start_email( ls_email_address,ls_address_mailcc,ls_notetext, ls_subject, ls_attach) < 0 THEN
//	Messagebox('Mail send','Faile to send Email.')
//	Return -1
//END IF

if lnv_Mail.of_CreateObject() = -1 then
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error", "Failed to create email object!",StopSign!)
	f_show_message('create Email object','','','','')
	//--------End Modified -------------------------------
	Return -1
end if

//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
/*
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-02-22 By: Scofield
//$<Reason> Get the Addresser's user id.

String	ls_Addresser

select top 1 set_addresser into :ls_Addresser from icred_settings;

if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
	ls_Addresser = gs_User_Id
end if
//---------------------------- APPEON END ----------------------------

//Send EMail
ll_Return = lnv_Mail.of_SendText(ls_Addresser, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
*/
ll_Return = lnv_Mail.of_SendText(gs_user_id, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
//END---Modify by Evan 2008-03-24

if ll_Return <> 0 then
	//--------Begin Modified by Nova 11.07.2008-----------
	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	//---------Begin Modified by (Appeon)Harry 03.13.2014 for V142 ISG-CLX--------
	//f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	If lnv_Mail.is_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If
	//---------End Modfiied ------------------------------------------------------
	//--------End Modified -------------------------------
	return -1
end if

//---------------------------- APPEON END ----------------------------

//Populate the mailMessage structure
ls_subject = "*****Applications File 1*****"
ls_notetext = "Please complete the following steps to import your requested credentialing applications into IntelliApp SE.~n~r" +&
					 "Attached is a zip file with your applications.~n~r" + &
					 "1) Save the attached Apps.zip file to your c:\IntelliApp\Applications\~n~r" + &
					 "2) If you receive more than one email from IntelliSoft Group go to each email and save the attachment(s) to c:\IntelliApp\Applications\~n~r" + &
					 "3) Open up the IntelliApp SE Software ~n~r" +&
					 "4) Click on the Import Apps menu icon ~n~r" +&
					 "5) Click the Import Applications Button~n~r"+&
					 "Your applications will be imported into IntelliApp SE and ready for use.~n~r" +&
					 "If you have any question please contact IntelliSoft Group at 888-634-4464."
ls_attach = "s:\appexport\Apps.zip"

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-21 By: Scofield
//$<Reason> Change the interface of send mail.

//IF lnv_redemption_mail.of_start_email( ls_email_address,ls_address_mailcc,ls_notetext, ls_subject, ls_attach) < 0 THEN
//	Messagebox('Mail send','Faile to send Email.')
//	Return -1
//END IF

//START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
//Send EMail
//ll_Return = lnv_Mail.of_SendText(ls_Addresser, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
ll_Return = lnv_Mail.of_SendText(gs_user_id, ls_email_address, ls_address_mailcc, '',ls_subject, ls_notetext, ls_attach)
//END---Modify by Evan 2008-03-24

if ll_Return <> 0 then
	MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
	lnv_Mail.of_DeleteObject()
	return -1
end if

lnv_Mail.of_DeleteObject()
//---------------------------- APPEON END ----------------------------

Return 1
//---------------------------- APPEON END ----------------------------
end event

type cb_5 from commandbutton within w_export_apps
integer x = 3113
integer y = 404
integer width = 439
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sort By App ID"
end type

event clicked;dw_app_list.SetSort( "app_id A" )
dw_app_list.Sort( )
end event

type st_1 from statictext within w_export_apps
integer x = 2085
integer y = 36
integer width = 1454
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_fld_prop from datawindow within w_export_apps
boolean visible = false
integer x = 2528
integer y = 1348
integer width = 960
integer height = 552
integer taborder = 90
string dataobject = "d_app_fld_prop"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_app_hdr from datawindow within w_export_apps
boolean visible = false
integer x = 2514
integer y = 932
integer width = 951
integer height = 392
integer taborder = 70
string dataobject = "d_app_hdr"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_export_apps
integer x = 709
integer y = 24
integer width = 1362
integer height = 112
integer taborder = 30
string dataobject = "d_app_name"
boolean border = false
boolean livescroll = true
end type

event constructor;This.InsertRow( 0 )
end event

event editchanged;Integer li_len
Integer li_row


li_len = LenA( data )

li_row = dw_1.Find( "Mid(UPPER(application_name),1," + String(li_len) + ") = '" + UPPER( data ) + "'" , 1, 100000)

IF li_row = 0 THEN
	Return
END IF
dw_1.SetRow( li_row )
dw_1.ScrollToRow( li_row )
dw_1.SelectRow( 0 , False )
dw_1.SelectRow( li_row, True )
end event

type cb_4 from commandbutton within w_export_apps
integer x = 3113
integer y = 692
integer width = 439
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export"
end type

event clicked;Integer li_rc
Integer i
Integer li_cnt
Long ll_apps[]

li_rc = dw_1.RowCount( )

dw_1.AcceptText( )

st_1.Text = "Scanning for apps to export."

FOR i = 1 TO li_rc
	IF dw_1.GetItemNumber( i, "checked" ) = 1 THEN
		li_cnt ++
		ll_apps[ li_cnt ] = dw_1.GetItemNumber( i, "app_id" )
	END IF
END FOR

dw_app_hdr.Retrieve( ll_apps[] )
dw_fld_prop.Retrieve( ll_apps[] )

st_1.Text = "Deleting old apps in appexport directory."

FileDelete( "s:\appexport\app_hdr.txt" )
FileDelete( "s:\appexport\app_fld_prop.txt" )
FileDelete( "s:\appexport\apps.zip" )

FOR i = 1 TO 100
	FileDelete( "s:\appexport\" + String( i ) + ".tif" )
	IF i < 10 THEN
		FileDelete( "s:\appexport\Apps.ZIP.z0" + String( i ) )	
	ELSE
		FileDelete( "s:\appexport\Apps.zip.z" + String( i ) )	
	END IF
END FOR


FOR i = 1 TO li_rc
	IF dw_1.GetItemNumber( i, "checked" ) = 1 THEN
		st_1.Text = "Copying over application " + String( dw_1.GetItemNumber( i, "app_id" )) + '.tif"'		
		//messagebox("", 's:\appexport\export.bat "s:\intelliapp perm\applications\' + String( dw_1.GetItemNumber( i, "app_id" )) + '.tif"' )
		Run( 's:\appexport\export.bat "s:\intelliapp perm\applications\' + String( dw_1.GetItemNumber( i, "app_id" )) + '.tif"', Minimized! )
	END IF
END FOR

st_1.Text = "Exporting Applications."
dw_app_hdr.SaveAs ( "s:\appexport\app_hdr.txt", Text!, False )
dw_fld_prop.SaveAs ( "s:\appexport\app_fld_prop.txt", Text!, False )

st_1.Text = "Export Complete."


Run( '"C:\Program Files\PKWARE\PKZIPC\pkzipc.exe" -add -span=1.2 s:\appexport\Apps.zip s:\appexport\*.*' )
end event

type cb_3 from commandbutton within w_export_apps
integer x = 3113
integer y = 568
integer width = 439
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Find"
end type

type cb_2 from commandbutton within w_export_apps
integer x = 3113
integer y = 280
integer width = 439
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sort By App"
end type

event clicked;dw_1.SetSort( "application_name A" )
dw_1.Sort( )

dw_app_list.SetSort( "application_name A" )
dw_app_list.Sort( )
end event

type cb_1 from commandbutton within w_export_apps
integer x = 3113
integer y = 160
integer width = 439
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sort By Facility"
end type

event clicked;dw_1.SetSort( "facility_name A, application_name A" )
dw_1.Sort( )

dw_app_list.SetSort( "facility_name A, application_name A" )
dw_app_list.Sort( )
end event

type dw_1 from datawindow within w_export_apps
integer x = 46
integer y = 144
integer width = 3040
integer height = 1900
integer taborder = 10
string dataobject = "d_app_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

