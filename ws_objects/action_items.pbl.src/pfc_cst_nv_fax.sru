$PBExportHeader$pfc_cst_nv_fax.sru
forward
global type pfc_cst_nv_fax from nonvisualobject
end type
end forward

global type pfc_cst_nv_fax from nonvisualobject
end type
global pfc_cst_nv_fax pfc_cst_nv_fax

type variables
long il_export_id//Added by  Nova 11.25.2010
Long il_ae_id //webview audit email id, only used when excuting of_email_new_wv_audit, Added by Appeon long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
Long il_facility_id //for webview audit email facility id, Added by Appeon long.zhang 07.03.2017 (v15.4 WebView Email Notifications)

n_cst_email_log inv_EmailLog //Evan 06.11.2012


end variables

forward prototypes
public function integer of_msfax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext)
public function integer of_fax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext)
public function integer of_winfax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext)
public function integer of_email (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id)
public subroutine of_get_emailinfo (long ai_mail_id, ref str_email astr_email)
public subroutine of_getemailmessage (long al_email_id, ref blob ablb_message)
public function string of_getfilename (string as_file)
public function integer of_email_outlook (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, string as_email_cc)
public function integer of_email_new (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id, blob ab_mess, string as_cc_recp)
public function integer of_email_outlookapp (string as_reciptions, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, string as_email_cc)
public function integer of_email_new_wv_audit (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id, blob ab_mess, string as_cc_recp, long al_ae_id, long al_facility_id, long al_export_id)
end prototypes

public function integer of_msfax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext);//////////////////////////////////////////////////////////////////////
// $<function>pfc_cst_nv_faxof_msfax()
// $<arguments>
//		value	string	as_recipient    		
//		value	string	as_company    --Not use for msfax 		
//		value	string	as_fax_number   		
//		value	string	as_subject      		
//		value	string	as_cover_text   		
//		value	string	as_attachments[]	--only one attachment can be send for msfax	
//		value	string	as_cover_page   		
// $<returns> integer
// $<description> Send fax with MSfax printer
//////////////////////////////////////////////////////////////////////
// $<add> 05/30/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
String ls_attach
String ls_errtext
n_cst_msfax nvo_msfax
nvo_msfax = Create n_cst_msfax

integer i,li_ret,li_ret1 
//If upperbound(as_attachments) > 0 Then
//	ls_attach = as_attachments[1]
//Else
//	ls_attach = ''
//End If
//

If upperbound(as_attachments) = 0 Then
	ls_attach = ''
	li_ret =  nvo_msfax.of_fax(as_recipient,  as_fax_number, as_subject, as_cover_text, ls_attach, as_cover_page )	
Else
	//------------------- APPEON BEGIN -------------------
	//$<midify> Stephen 11.08.2011
	//$<reason> V12.1-Fax modification
	For i = 1 To upperbound(as_attachments)
		IF i = 1 THEN
			ls_attach = as_attachments[i]
		ELSE
			ls_attach = ls_attach + ',' +as_attachments[i]
		END IF
	next
	li_ret1 =  nvo_msfax.of_fax(as_recipient,  as_fax_number, as_subject, as_cover_text, ls_attach, as_cover_page )	
	If li_ret1 < 0 Then
		li_ret = li_ret1
	End If
//		For i = 1 To upperbound(as_attachments)
//			ls_attach = as_attachments[i]
//			li_ret1 =  nvo_msfax.of_fax(as_recipient,  as_fax_number, as_subject, as_cover_text, ls_attach, as_cover_page )	
//			If li_ret1 < 0 Then
//				li_ret = li_ret1
//			End If
//		Next
//------------------- APPEON END -------------------

End If
as_errtext = ''
If li_ret < 0 Then
	as_errtext = nvo_msfax.of_get_errtext( li_ret)
	Destroy nvo_msfax
	Return -1
End If

return 1
end function

public function integer of_fax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/29/2007 By: Ken.Guo
//$<reason> Added for MSFax Printer. Set_52 is fax type(Fax_type,2:MSFax,1:WINFax)
integer li_ret 
//String ls_errtext

If gds_settings.GetItemNumber(1,'set_52') = 1  THEN
	//1: WinFax Type
	li_ret = of_winfax( as_recipient, as_company, as_fax_number, as_subject, as_cover_text, as_attachments[], as_cover_page,as_errtext )	
Else
	//2: MSFax Type
	li_ret = of_msfax( as_recipient, as_company, as_fax_number, as_subject, as_cover_text, as_attachments[], as_cover_page,as_errtext )	
END IF

Return li_ret


//$<modify> 05/30/2007 By: Ken.Guo
//$<reason> Cut all below script to of_winfax() For support WinFax.

/*
	string sQ = "~""
	Long ChanNum
	Integer iRC
	Integer a
	String ls_resolution
	String ls_time
	String ls_date
	gs_fax lgs_fax
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<add> 10.19.2006 By: Alfee
	//$<reason> The DDE server is not completed supported by APB.
	//$<modification> Using SDK function to replace DDE function on web application.
	/*
	as_company = Mid( as_company, 1 , 42 )
	
	ls_time = String( Now(), "HH:MM:SS" )
	ls_date = String( Today( ), "mm/dd/yy"  )
	
	ls_resolution = "High"
	
	
	ChanNum = OpenChannel("FAXMNG32", "CONTROL")
	
	
	IF ChanNum < 0 THEN
		MessageBox("Error", "Winfax is not installed or needs to be configured." )
		Return -1
	END IF
	
	ExecRemote("GoIdle", ChanNum )
	
	
	CloseChannel (ChanNum)
	
	//'Create a new link with the TRANSMIT topic.
	ChanNum = OpenChannel ("FAXMNG32", "TRANSMIT")
	
	//set recipient
	iRC = SetRemote ( "Sendfax", "recipient(" + sQ + as_fax_number + sQ + "," + sQ + ls_time + sQ + "," + sQ + ls_date + sQ + "," + sQ + as_recipient + sQ + "," + sQ + as_company + sQ + "," + sQ + as_subject + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + ")", ChanNum )
	
	//'setcoverpage
	iRC = SetRemote ( "Sendfax", "setcoverpage(" + sQ + as_cover_page + sQ + ")", ChanNum )
	
	//'fillcoverpage
	iRC = SetRemote ( "Sendfax", "fillcoverpage(" + sQ + as_cover_text + sQ + ")", ChanNum )
	//DDEPoke ChanNum, "sendfax", "fillcoverpage(" + sQ + "Please send comments by Friday noon." + sQ + ")"
	
	//'attach
	FOR a = 1 TO UpperBound( as_attachments[] )
		//messagebox("","attach(" + sQ + as_attachments[a] + sQ + ")")
		iRC = SetRemote ( "Sendfax", "attach(" + sQ + as_attachments[a] + sQ + ")", ChanNum )
	END FOR
	
	
	
	//showsendscreen
	iRC = SetRemote ( "Sendfax", "showsendscreen(" + sQ + "0" + sQ + ")", ChanNum )
	//DDEPoke ChanNum, "sendfax", "showsendscreen(" + sQ + "0" + sQ + ")"
	
	iRC = SetRemote ( "Sendfax", "ShowMaximized()", ChanNum )
	
	//resolution
	iRC = SetRemote ( "Sendfax", "resolution(" + sQ + ls_resolution + sQ + ")", ChanNum )
	
	
	//'Tell WinFax to send the fax.
	iRC = SetRemote ( "Sendfax", "SendfaxUI", ChanNum )
	
	CloseChannel (ChanNum)
	//DDETerminate ChanNum
	
	ChanNum = OpenChannel ("FAXMNG32", "CONTROL")
	//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")
	
	
	ExecRemote("GoActive", ChanNum )
	
	
	//'Close the link between the applications.
	CloseChannel (ChanNum)
	//DDETerminate ChanNum
	*/
	If AppeonGetclientType() = 'PB' Then
		as_company = Mid( as_company, 1 , 42 )
	
		ls_time = String( Now(), "HH:MM:SS" )
		ls_date = String( Today( ), "mm/dd/yy"  )
		
		ls_resolution = "High"
		
		ChanNum = OpenChannel("FAXMNG32", "CONTROL")
		
		IF ChanNum < 0 THEN
			MessageBox("Error", "Winfax is not installed or needs to be configured." )
			Return -1
		END IF
		
		ExecRemote("GoIdle", ChanNum )
		
		CloseChannel (ChanNum)
		
		//'Create a new link with the TRANSMIT topic.
		ChanNum = OpenChannel ("FAXMNG32", "TRANSMIT")
		
		//set recipient
		iRC = SetRemote ( "Sendfax", "recipient(" + sQ + as_fax_number + sQ + "," + sQ + ls_time + sQ + "," + sQ + ls_date + sQ + "," + sQ + as_recipient + sQ + "," + sQ + as_company + sQ + "," + sQ + as_subject + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + ")", ChanNum )
		
		//'setcoverpage
		iRC = SetRemote ( "Sendfax", "setcoverpage(" + sQ + as_cover_page + sQ + ")", ChanNum )
		
		//'fillcoverpage
		iRC = SetRemote ( "Sendfax", "fillcoverpage(" + sQ + as_cover_text + sQ + ")", ChanNum )
		//DDEPoke ChanNum, "sendfax", "fillcoverpage(" + sQ + "Please send comments by Friday noon." + sQ + ")"
		
		//'attach
		FOR a = 1 TO UpperBound( as_attachments[] )
			//messagebox("","attach(" + sQ + as_attachments[a] + sQ + ")")
			iRC = SetRemote ( "Sendfax", "attach(" + sQ + as_attachments[a] + sQ + ")", ChanNum )
		END FOR
		
		//showsendscreen
		iRC = SetRemote ( "Sendfax", "showsendscreen(" + sQ + "0" + sQ + ")", ChanNum )
		//DDEPoke ChanNum, "sendfax", "showsendscreen(" + sQ + "0" + sQ + ")"
		
		iRC = SetRemote ( "Sendfax", "ShowMaximized()", ChanNum )
		
		//resolution
		iRC = SetRemote ( "Sendfax", "resolution(" + sQ + ls_resolution + sQ + ")", ChanNum )
		
		//'Tell WinFax to send the fax.
		iRC = SetRemote ( "Sendfax", "SendfaxUI", ChanNum )
		
		CloseChannel (ChanNum)
		//DDETerminate ChanNum
		
		ChanNum = OpenChannel ("FAXMNG32", "CONTROL")
		//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")
		
		ExecRemote("GoActive", ChanNum )
		
		//'Close the link between the applications.
		CloseChannel (ChanNum)
		//DDETerminate ChanNum
	Else
		OLEObject objWinfaxSend
	
		as_company = Mid( as_company, 1 , 42 )
		
		ls_time = String( Now(), "HH:MM:SS" )
		ls_date = String( Today( ), "mm/dd/yy"  )
		
		ls_resolution = "High"
		
		objWinfaxSend = CREATE OLEObject
		iRC = objWinfaxSend.ConnectToNewObject("WinFax.SDKSend")
		if iRC < 0 then
			MessageBox("Error","Winfax is not installed or needs to be configured.")
			Return -1
		end if
		
		objWinfaxSend.LeaveRunning()
		
		objWinfaxSend.SetNumber(as_fax_number)
		objWinfaxSend.SetTime(ls_time)
		objWinfaxSend.SetDate(ls_date)
		objWinfaxSend.SetTo(as_recipient)
		objWinfaxSend.setCompany(as_company)
		objWinfaxSend.setSubject(as_subject)
		objWinfaxSend.setCoverFile(as_cover_page)   
		objWinfaxSend.setCoverText(as_cover_text)
		
		FOR a = 1 TO UpperBound( as_attachments[] )
			if objWinfaxSend.AddAttachmentFile(as_attachments[a]) = 1 THEN
				Messagebox('Error', "Add attachment file failed!")
				return -1
			end if
		END FOR
		
		objWinfaxSend.ShowSendScreen(0) //Don't display the send dialog
		objWinfaxSend.SetResolution(1) //Set High resolution
		objWinfaxSend.AddRecipient()  // Add Recipient
		
		iRC = objWinfaxSend.Send(0) //Tell WinFax to send the fax.
		if iRC = 1 then
			MessageBox("Error","Send fax error!")
		END IF
		
		objWinfaxSend.Done //Tell WinFax job done to performs some internal cleaning.
		
		objWinfaxSend.DisconnectObject()
		Destroy objWinfaxSend
	
	End if
	
	// mbs 23 dec 2004 run fax pro -- begin
	string ls_key
	n_cst_string lnvo_string 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<add> 04.13.2006 By: Cao YongWang
	//$<reason> The RegistryGet function is currently unsupported.
	//$<modification> Use Appeon DLL function to provide the same functionality.
	/*
	RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
	*/
	If appeongetclienttype() = 'PB' Then
		RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
	Else
		gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
	End if
	//---------------------------- APPEON END ----------------------------
	
	run( LS_KEY + "faxmng32.exe")
	// mbs 23 dec 2004 run fax pro -- begin
	
	
	/*
	ShellExecuteA ( Handle( This ), "open", "faxmng32.exe" , ls_Null, ls_Null, 4)
	*/
	
	Return 1
	*/
//---------------------------- APPEON END ----------------------------	
end function

public function integer of_winfax (string as_recipient, string as_company, string as_fax_number, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, ref string as_errtext);string sQ = "~""
Long ChanNum
Integer iRC
Integer a
String ls_resolution
String ls_time
String ls_date
gs_fax lgs_fax



//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 10.19.2006 By: Alfee
//$<reason> The DDE server is not completed supported by APB.
//$<modification> Using SDK function to replace DDE function on web application.
/*
as_company = Mid( as_company, 1 , 42 )

ls_time = String( Now(), "HH:MM:SS" )
ls_date = String( Today( ), "mm/dd/yy"  )

ls_resolution = "High"


ChanNum = OpenChannel("FAXMNG32", "CONTROL")


IF ChanNum < 0 THEN
	MessageBox("Error", "Winfax is not installed or needs to be configured." )
	Return -1
END IF

ExecRemote("GoIdle", ChanNum )


CloseChannel (ChanNum)

//'Create a new link with the TRANSMIT topic.
ChanNum = OpenChannel ("FAXMNG32", "TRANSMIT")

//set recipient
iRC = SetRemote ( "Sendfax", "recipient(" + sQ + as_fax_number + sQ + "," + sQ + ls_time + sQ + "," + sQ + ls_date + sQ + "," + sQ + as_recipient + sQ + "," + sQ + as_company + sQ + "," + sQ + as_subject + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + ")", ChanNum )

//'setcoverpage
iRC = SetRemote ( "Sendfax", "setcoverpage(" + sQ + as_cover_page + sQ + ")", ChanNum )

//'fillcoverpage
iRC = SetRemote ( "Sendfax", "fillcoverpage(" + sQ + as_cover_text + sQ + ")", ChanNum )
//DDEPoke ChanNum, "sendfax", "fillcoverpage(" + sQ + "Please send comments by Friday noon." + sQ + ")"

//'attach
FOR a = 1 TO UpperBound( as_attachments[] )
	//messagebox("","attach(" + sQ + as_attachments[a] + sQ + ")")
	iRC = SetRemote ( "Sendfax", "attach(" + sQ + as_attachments[a] + sQ + ")", ChanNum )
END FOR



//showsendscreen
iRC = SetRemote ( "Sendfax", "showsendscreen(" + sQ + "0" + sQ + ")", ChanNum )
//DDEPoke ChanNum, "sendfax", "showsendscreen(" + sQ + "0" + sQ + ")"

iRC = SetRemote ( "Sendfax", "ShowMaximized()", ChanNum )

//resolution
iRC = SetRemote ( "Sendfax", "resolution(" + sQ + ls_resolution + sQ + ")", ChanNum )


//'Tell WinFax to send the fax.
iRC = SetRemote ( "Sendfax", "SendfaxUI", ChanNum )

CloseChannel (ChanNum)
//DDETerminate ChanNum

ChanNum = OpenChannel ("FAXMNG32", "CONTROL")
//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")


ExecRemote("GoActive", ChanNum )


//'Close the link between the applications.
CloseChannel (ChanNum)
//DDETerminate ChanNum
*/

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 11.08.2011
//$<reason> V12.1-Fax modification
string  ls_outfile, ls_out[]

if upperbound(as_attachments) > 1 then
	if f_combine_file(as_attachments, ls_outfile, 'winfax') = 1 then
		ls_out[1] = ls_outfile
		as_attachments = ls_out
	end if
end if
//------------------- APPEON End -------------------

If AppeonGetclientType() = 'PB' Then
	as_company = MidA( as_company, 1 , 42 )

	ls_time = String( Now(), "HH:MM:SS" )
	ls_date = String( Today( ), "mm/dd/yy"  )
	
	ls_resolution = "High"
	
	ChanNum = OpenChannel("FAXMNG32", "CONTROL")
	
	IF ChanNum < 0 THEN
		//MessageBox("Error", "Winfax is not installed or needs to be configured." )
		as_errtext = "Winfax is not installed or needs to be configured."
		Return -1
	END IF
	
	ExecRemote("GoIdle", ChanNum )
	
	CloseChannel (ChanNum)
	
	//'Create a new link with the TRANSMIT topic.
	ChanNum = OpenChannel ("FAXMNG32", "TRANSMIT")
	
	//set recipient
	iRC = SetRemote ( "Sendfax", "recipient(" + sQ + as_fax_number + sQ + "," + sQ + ls_time + sQ + "," + sQ + ls_date + sQ + "," + sQ + as_recipient + sQ + "," + sQ + as_company + sQ + "," + sQ + as_subject + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + "," + sQ + "" + sQ + ")", ChanNum )
	
	//'setcoverpage
	iRC = SetRemote ( "Sendfax", "setcoverpage(" + sQ + as_cover_page + sQ + ")", ChanNum )
	
	//'fillcoverpage
	iRC = SetRemote ( "Sendfax", "fillcoverpage(" + sQ + as_cover_text + sQ + ")", ChanNum )
	//DDEPoke ChanNum, "sendfax", "fillcoverpage(" + sQ + "Please send comments by Friday noon." + sQ + ")"
	
	//'attach
	FOR a = 1 TO UpperBound( as_attachments[] )
		//messagebox("","attach(" + sQ + as_attachments[a] + sQ + ")")
		iRC = SetRemote ( "Sendfax", "attach(" + sQ + as_attachments[a] + sQ + ")", ChanNum )
	END FOR
	
	//showsendscreen
	iRC = SetRemote ( "Sendfax", "showsendscreen(" + sQ + "0" + sQ + ")", ChanNum )
	//DDEPoke ChanNum, "sendfax", "showsendscreen(" + sQ + "0" + sQ + ")"
	
	iRC = SetRemote ( "Sendfax", "ShowMaximized()", ChanNum )
	
	//resolution
	iRC = SetRemote ( "Sendfax", "resolution(" + sQ + ls_resolution + sQ + ")", ChanNum )
	
	//'Tell WinFax to send the fax.
	iRC = SetRemote ( "Sendfax", "SendfaxUI", ChanNum )
	
	CloseChannel (ChanNum)
	//DDETerminate ChanNum
	
	ChanNum = OpenChannel ("FAXMNG32", "CONTROL")
	//ChanNum = DDEInitiate("FAXMNG32", "CONTROL")
	
	ExecRemote("GoActive", ChanNum )
	
	//'Close the link between the applications.
	CloseChannel (ChanNum)
	//DDETerminate ChanNum
Else
	OLEObject objWinfaxSend

	as_company = MidA( as_company, 1 , 42 )
	
	ls_time = String( Now(), "HH:MM:SS" )
	ls_date = String( Today( ), "mm/dd/yy"  )
	
	ls_resolution = "High"
	
	objWinfaxSend = CREATE OLEObject
	iRC = objWinfaxSend.ConnectToNewObject("WinFax.SDKSend")
	if iRC < 0 then
		//MessageBox("Error","Winfax is not installed or needs to be configured.")
		as_errtext = "Winfax is not installed or needs to be configured."
		Return -1
	end if
	
	objWinfaxSend.LeaveRunning()
	
	objWinfaxSend.SetNumber(as_fax_number)
	objWinfaxSend.SetTime(ls_time)
	objWinfaxSend.SetDate(ls_date)
	objWinfaxSend.SetTo(as_recipient)
	objWinfaxSend.setCompany(as_company)
	objWinfaxSend.setSubject(as_subject)
	objWinfaxSend.setCoverFile(as_cover_page)   
	objWinfaxSend.setCoverText(as_cover_text)
	
	FOR a = 1 TO UpperBound( as_attachments[] )
		if objWinfaxSend.AddAttachmentFile(as_attachments[a]) = 1 THEN
			//Messagebox('Error', "Add attachment file failed!")
			as_errtext = "Add attachment file failed!"
			return -1
		end if
	END FOR
	
	objWinfaxSend.ShowSendScreen(0) //Don't display the send dialog
	objWinfaxSend.SetResolution(1) //Set High resolution
	objWinfaxSend.AddRecipient()  // Add Recipient
	
	iRC = objWinfaxSend.Send(0) //Tell WinFax to send the fax.
	if iRC = 1 then
		//MessageBox("Error","Send fax error!")
		as_errtext = "Send fax error!"
		objWinfaxSend.Done //Tell WinFax job done to performs some internal cleaning.
		objWinfaxSend.DisconnectObject()
		Destroy objWinfaxSend		
		Return -1
	END IF
	
	objWinfaxSend.Done //Tell WinFax job done to performs some internal cleaning.
	
	objWinfaxSend.DisconnectObject()
	Destroy objWinfaxSend

End if

// mbs 23 dec 2004 run fax pro -- begin
string ls_key
n_cst_string lnvo_string 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 04.13.2006 By: Cao YongWang
//$<reason> The RegistryGet function is currently unsupported.
//$<modification> Use Appeon DLL function to provide the same functionality.
/*
RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
*/
If appeongetclienttype() = 'PB' Then
	RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
Else
	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\FAXMNG32.EXE",  "PATH", RegString!, ls_key)
End if
//---------------------------- APPEON END ----------------------------

run( LS_KEY + "faxmng32.exe")
// mbs 23 dec 2004 run fax pro -- begin


/*
ShellExecuteA ( Handle( This ), "open", "faxmng32.exe" , ls_Null, ls_Null, 4)
*/

Return 1
end function

public function integer of_email (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id);//Replaced with of_email_new () - alfee 06.11.2014

RETURN 1

////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 06/13/2007 By: Ken.Guo
////$<reason> Send Email.
//
////Start Code Change ----10.06.2008 #V85 maha
//if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
//	Integer res
//	res = of_email_outlook( as_recipient, as_company, as_email_address,as_subject ,as_cover_text, as_attachments[],  as_cover_page,"" )
//	RETURN res
//END IF
////End Code Change---10.06.2008
//
///******************************************************************************************************************
//**  [PUBLIC]   : of_email
//**==================================================================================================================
//**  Purpose   	: Send email out with attachments
//**==================================================================================================================
//**  Arguments 	: [string] as_recipient
//**          	: [string] as_company        - not used
//**          	: [string] as_email_address
//**          	: [string] as_subject
//**          	: [string] as_cover_text      -not used
//**          	: [string] as_attachments[]
//**          	: [string] as_cover_page      -not used 
//**==================================================================================================================
//**  Returns   	: [long]   1 none oter used 
//**==================================================================================================================
//**  Notes     	: 	   
//**==================================================================================================================
//**  Created By	: ?? 
//**==================================================================================================================
//**  Modification Log
//**   Changed By             Change Date                                               Reason
//** ------------------------------------------------------------------------------------------------------------------
//**  mskinner               16 December 2005                                  -- Added error messages
//**                                                                           -- cleaned up code
//**                                                                           -- The code will now acceept an infinate attachments
//**                                                                           -- The function no longer returns -1, if it did the rest
//**                                                                              of the emails will not be sent
//********************************************************************************************************************/
//
///*
//mailSession mSes
//mailReturnCode mRet
//mailMessage mMsg
//mailFileDescription mAttach
//
//STRING ls_attach 
//STRING ls_emp_mail_login
//STRING ls_file_name
//STRING ls_temp_path
//STRING ls_message
//LONG   ll_return,ll_i
//LONG   AttachFile_Index
//LONG   li_attachment_cnt
//
//ll_return = 1
//
//mSes = create mailSession
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-02
////$<add> 01.25.2006 By: LeiWei
////$<reason> mailSession is currently unsupported.
////$<modification> Manually specify mailReturnSuccess! as the initial value to mRet.
//mRet = mailReturnSuccess!
////---------------------------- APPEON END ----------------------------
//
//mRet = mSes.mailLogon( mailNewSession!) 
//IF mRet <> mailReturnSuccess! THEN
//	MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
//	Return -1
//END IF
//
//li_attachment_cnt = UpperBound( as_attachments )
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// add the attachments
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//FOR ll_i = 1 TO li_attachment_cnt
//	ls_temp_path =  gs_temp_path + "fax\"
//	ls_file_name = Mid( as_attachments[ll_i], Len( ls_temp_path) + 1, 1000 )
//	AttachFile_Index = UpperBound(mMsg.AttachmentFile) + 1
//	mAttach.FileType = MailAttach!
//	mAttach.PathName = as_attachments[ll_i] 
//	mAttach.FileName = as_attachments[ll_i] 
//	mAttach.position = ll_i
//	mMsg.AttachmentFile[AttachFile_Index] = mAttach
//END FOR
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// send the mail out
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//mMsg.Subject = as_subject
//mMsg.NoteText = as_cover_text
//mMsg.Recipient[1].name = as_email_address
//mRet = mSes.mailSend(mMsg)
//
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// check for errors
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//choose case mret 
//        case mailReturnAccessDenied! 
//                ls_message = 'Access Denied' 
//        case mailReturnAttachmentNotFound! 
//                ls_message = 'Attachment Not Found' 
//        case mailReturnAttachmentOpenFailure! 
//                ls_message = 'Attachment Open Failure' 
//        case mailReturnAttachmentWriteFailure! 
//                ls_message = 'Attachment Write Failure' 
//        case mailReturnDiskFull! 
//                ls_message = 'Disk Full' 
//        case mailReturnFailure! 
//                ls_message = 'Failure' 
//        case mailReturnInsufficientMemory! 
//                ls_message = 'Insufficient Memory' 
//        case mailReturnInvalidMessage! 
//                ls_message = 'Invalid Message' 
//        case mailReturnLoginFailure! 
//                ls_message = 'Login Failure' 
//        case mailReturnMessageInUse! 
//                ls_message = 'Message In Use' 
//        case mailReturnNoMessages! 
//                ls_message = 'No Messages' 
//        case mailReturnTextTooLarge! 
//                ls_message = 'Text Too Large' 
//        case mailReturnTooManyFiles! 
//                ls_message = 'Too Many Files' 
//        case mailReturnTooManyRecipients! 
//                ls_message = 'Too Many Recipients' 
//        case mailReturnTooManySessions! 
//                ls_message = 'Too Many Sessions' 
//        case mailReturnUnknownRecipient! 
//                ls_message = 'Unknown Recipient' 
//        case mailReturnUserAbort! 
//                ls_message = 'User Abort' 
//        case mailReturnSuccess! 
//                ls_message = '' 
//        case else 
//                ls_message = 'Other' 
//end choose 
//
//if ls_message <> '' then 
//	MessageBox ( 'Mail Return Code', ls_message, Exclamation!)
//end if 
//
//mSes.mailLogoff()
//
//DESTROY mSes
//
//Return ll_return
//*/
//
//Integer i
//String ls_address_mailcc,ls_attachments
////parameter  long al_email_id     Added by  Nova 11.25.2010 
////parameter  long al_prac_id     Added by  Nova 11.25.2010 
//str_email ls_email_info//Added by  Nova 11.25.2010
//Blob lblb_data//Added by  Nova 11.25.2010
//String ls_filename//Added by  Nova 11.25.2010
//Long ll_BlobLen, ll_WriteLength//Added by  Nova 11.25.2010
//Blob lbob_Message//Added by  Nova 11.25.2010
//FOR i = 1 To UpperBound(as_attachments)
//	IF i = 1 THEN
//		ls_attachments = as_attachments[i]
//	ELSE
//		ls_attachments = ls_attachments + ',' +as_attachments[i]
//	END IF
//	
//NEXT
////--------Begin Added by Nova 11.25.2010------------------------
////get mail attach info by mail_id
//of_get_emailinfo(al_email_id,ls_email_info)
//
////Save attact to temp dir
//IF LenA(ls_email_info.attach) > 0 THEN
//	ls_filename = gs_temp_path + ls_email_info.attach_name
//	IF FileExists(ls_filename) THEN
//		FileDelete (ls_filename )
//	END IF
//	ll_BlobLen = LenA(ls_email_info.attach)
//	lblb_data = ls_email_info.attach //Add by Stephen 08.26.2011 --- email send failed.
//	ll_WriteLength = AppeonWriteFile(ls_filename, lblb_data, ll_BlobLen)
//	IF ll_WriteLength < 0 THEN RETURN -1
//	ls_attachments = ls_attachments + ',' +ls_filename
//END IF
////--------End Added --------------------------------------------
////--------------------------- APPEON BEGIN ---------------------------
////$<Modify> 2007-11-21 By: Scofield
////$<Reason> Change the interface of send mail
//
////IF lnv_redemption_mail.of_start_email( as_email_address,ls_address_mailcc,as_cover_text, as_subject, ls_attachments) < 0 THEN
////	Return -1
////END IF
//
//Long		ll_Return
//n_cst_easymail_smtp 	lnv_Mail
//
//IF lnv_Mail.of_CreateObject() = -1 THEN
//	//--------Begin Modified by Nova 11.07.2008-----------
//	//MessageBox("Error", "Failed to create email object!",StopSign!)
//	f_show_message('create Email object','','','','')
//	//--------End Modified -------------------------------
//	RETURN -1
//END IF
//
////START---Modify by Evan 2008-03-24 (Reasion:Send email with current user account)
///*
////--------------------------- APPEON BEGIN ---------------------------
////$< Add  > 2008-02-22 By: Scofield
////$<Reason> Get the Addresser's user id.
//
//String	ls_Addresser
//
//select top 1 set_addresser into :ls_Addresser from icred_settings;
//
//if IsNull(ls_Addresser) or Trim(ls_Addresser) = "" then
//	ls_Addresser = gs_User_Id
//end if
////---------------------------- APPEON END ----------------------------
//
////Send EMail
//ll_Return = lnv_Mail.of_SendText(ls_Addresser, as_email_address, ls_address_mailcc, '',as_subject, as_cover_text, ls_attachments)
//*/
////--------Begin Added by Nova 11.25.2010------------------------
////get mail message by email_id
//of_GetEmailMessage(al_email_id,lbob_Message)
//Open(w_email_edit)
//w_email_edit.ole_word.of_Open(lbob_Message)
//
////merge mail
//n_cst_word_utility lnv_word
//lnv_word = Create n_cst_word_utility
//lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, al_prac_id, il_export_id)
//Destroy lnv_word
////--------End Added --------------------------------------------
//
//ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, as_email_address, ls_address_mailcc,'', as_subject, w_email_edit.ole_word, ls_attachments,True)
////ll_Return = lnv_Mail.of_SendText(gs_user_id, as_email_address, ls_address_mailcc, '',as_subject, as_cover_text, ls_attachments)//commented by nova 11.25.2010
////END---Modify by Evan 2008-03-24
//
//IF ll_Return <> 0 THEN
//	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
//	/*
//	//--------Begin Modified by Nova 11.07.2008-----------
//	//MessageBox("Error Code: " + String(ll_Return), "Failed to send email!~r~n~r~n" + lnv_Mail.of_GetEMailError(ll_Return),Exclamation!)
//	f_show_message('error_code_'+String(ll_Return),'%1S%',String(ll_Return),'','')
//	//--------End Modified -------------------------------
//	*/
//	If lnv_Mail.is_sendprotocol = 'SMTP' Then
//		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
//	Else
//		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
//	End If
//	//---------End Modfiied ------------------------------------------------------
//	
//	lnv_Mail.of_DeleteObject()
//	Close(w_email_edit)//Added by  Nova 11.25.2010
//	RETURN -1
//END IF
//
//lnv_Mail.of_DeleteObject()
//Close(w_email_edit)//Added by  Nova 11.25.2010
////---------------------------- APPEON END ----------------------------
//RETURN 1
//

end function

public subroutine of_get_emailinfo (long ai_mail_id, ref str_email astr_email);//==============================APPEON BEGIN==========================
// Function: of_get_emailinfo
//--------------------------------------------------------------------
// Description: get email attach infor
//--------------------------------------------------------------------
// Arguments:
//           ai_mail_id long      value
//				 astr_email str_email reference
//--------------------------------------------------------------------
// Returns:  none
//--------------------------------------------------------------------
// Author:	Nova		Date: Nov 25,2010
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------

//==============================APPEON END============================
Long 		ll_data_length,ll_start
Integer 	li_loops,li_counter
Blob 		lb_data

//Get Email Information
SELECT 
	wf_email.attach_name,
	export_id,
	Datalength(attachment)
	INTO 
	:astr_email.attach_name,
	:il_export_id,
	:ll_data_length
	FROM wf_email
	Where wf_email.email_id = :ai_Mail_id;

IF appeongetclienttype() = 'PB' And gs_dbtype = 'SQL' And ll_data_length > 0 THEN
	IF ll_data_length > 8000 THEN
		IF Mod(ll_data_length,8000) = 0 THEN
			li_loops = ll_data_length/8000
		ELSE
			li_loops = (ll_data_length/8000) + 1
		END IF
	ELSE
		li_loops = 1
	END IF
	
	FOR li_counter = 1 To li_loops
		ll_start = (li_counter - 1) * 8000 + 1
		SelectBlob substring(attachment,:ll_start,8000)
		Into :lb_data
		From wf_email
		Where wf_email.email_id = :ai_Mail_id;
		astr_email.attach += lb_data
	NEXT
ELSE
	SelectBlob attachment
	Into :astr_email.attach
	From wf_email
	Where wf_email.email_id = :ai_Mail_id;
END IF

end subroutine

public subroutine of_getemailmessage (long al_email_id, ref blob ablb_message);//==============================APPEON BEGIN==========================
// Function: of_getemailmessage
//--------------------------------------------------------------------
// Description: get email message infor
//--------------------------------------------------------------------
// Arguments:
//           ai_mail_id   long     value
//				 ablb_message blob     reference
//--------------------------------------------------------------------
// Returns:  none
//--------------------------------------------------------------------
// Author:	Nova		Date: Nov 25,2010
//--------------------------------------------------------------------
//	All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//	-------------------------------------------------------------------

//==============================APPEON END============================
Long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

Long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
	INTO :ll_DataLen
	FROM wf_email
	Where wf_email.email_id = :al_EMail_Id;
	
IF AppeonGetClientType() = 'PB' And gs_dbtype = 'SQL' And ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SelectBlob SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		Into :lb_Temp
		From wf_email
		Where wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	NEXT
ELSE
	SelectBlob Email_Message
	Into :ablb_Message
	From wf_email
	Where wf_email.email_id = :al_EMail_Id;
END IF

end subroutine

public function string of_getfilename (string as_file);//////////////////////////////////////////////////////////////////////
// $<function> of_getfilename
// $<arguments>
//			string	as_file
// $<returns> integer
// $<description> Get file short name
//////////////////////////////////////////////////////////////////////
// $<add> Evan 06.11.2010
//////////////////////////////////////////////////////////////////////

string ls_FileName
integer li_Pos

as_File = Trim(as_File)
if not f_validstr(as_File) then Return ""

li_Pos = LastPos(Lower(as_File), "\")
if li_Pos < 1 then LastPos(Lower(as_File), "/")

ls_FileName = MidA(as_File, li_Pos + 1, 255)

Return ls_FileName
end function

public function integer of_email_outlook (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, string as_email_cc);////Start Code Change ----10.06.2008 #V85 maha - readded this function under this name
/******************************************************************************************************************
**  [PUBLIC]   : of_email
**==================================================================================================================
**  Purpose   	: Send email out with attachments
**==================================================================================================================
**  Arguments 	: [string] as_recipient
**          	: [string] as_company        - not used
**          	: [string] as_email_address
**          	: [string] as_subject
**          	: [string] as_cover_text      -not used
**          	: [string] as_attachments[]
**          	: [string] as_cover_page      -not used 
**==================================================================================================================
**  Returns   	: [long]   1 none oter used 
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: ?? 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**  mskinner               16 December 2005                                  -- Added error messages
**                                                                           -- cleaned up code
**                                                                           -- The code will now acceept an infinate attachments
**                                                                           -- The function no longer returns -1, if it did the rest
**                                                                              of the emails will not be sent
********************************************************************************************************************/

mailSession mSes
mailReturnCode mRet
mailMessage mMsg
mailFileDescription mAttach

STRING ls_attach 
STRING ls_emp_mail_login
STRING ls_file_name
STRING ls_temp_path
STRING ls_message
STRING ls_AttachmentName
blob   lblb_MailContent
LONG   ll_return,ll_i
LONG   AttachFile_Index
LONG   li_attachment_cnt
n_cst_string lnv_string  
string ls_mailcc_arr[]
string ls_mailto_arr[]
integer li_cnt, li_cc
ll_return = 1

mSes = create mailSession
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.25.2006 By: LeiWei
//$<reason> mailSession is currently unsupported.
//$<modification> Manually specify mailReturnSuccess! as the initial value to mRet.
mRet = mailReturnSuccess!
//---------------------------- APPEON END ----------------------------

mRet = mSes.mailLogon( mailNewSession!) 
IF mRet <> mailReturnSuccess! THEN
	MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
	Return -1
END IF

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 11.09.2011
//$<reason> V12.1-Fax modification
string ls_outfile, ls_out[]
if upperbound(as_attachments) > 1 then
	if f_combine_file(as_attachments, ls_outfile, 'email') = 1 then
		ls_out[1] = ls_outfile
		as_attachments = ls_out
	end if
end if
//------------------- APPEON End -------------------

li_attachment_cnt = UpperBound( as_attachments )

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// add the attachments
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

FOR ll_i = 1 TO li_attachment_cnt
	//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
	//ls_temp_path =  gs_dir_path + "intellicred\fax\"
	ls_temp_path =  gs_temp_path + "fax\"
	//---------End Modfiied ------------------------------------------------------
	
	ls_file_name = MidA( as_attachments[ll_i], LenA( ls_temp_path) + 1, 1000 )
	AttachFile_Index = UpperBound(mMsg.AttachmentFile) + 1
	mAttach.FileType = MailAttach!
	mAttach.PathName = as_attachments[ll_i] 
	mAttach.FileName = as_attachments[ll_i] 
	mAttach.position = ll_i
	mMsg.AttachmentFile[AttachFile_Index] = mAttach
	//---------- APPEON BEGIN ----------
	//$<add> Evan 06.11.2012
	//$<reason> V12.2-Email Logging
	if Len(ls_AttachmentName) > 0 then ls_AttachmentName += ", "
	ls_AttachmentName += of_GetFileName(as_attachments[ll_i])
	//---------- APPEON END ------------
END FOR

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// send the mail out
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

mMsg.Subject = as_subject

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 12.21.2011
//$<reason> Screen Shot for Email Error
do while pos(trim(as_cover_text),'~r') = 1 
	as_cover_text = mid(trim(as_cover_text), 3)	
loop
//------------------- APPEON END -------------------

mMsg.NoteText = as_cover_text
//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 05.07.2013
//$<reason> add email cc V12.3 Modification estimate
/*
mMsg.Recipient[1].name = as_email_address
*/
lnv_String.of_ParseToArray(as_email_address, ";", ls_mailto_arr[])
lnv_String.of_ParseToArray(as_email_cc, ";", ls_mailcc_arr[])
li_cc = 0
for li_cnt = 1 to upperbound(ls_mailto_arr)
	li_cc +=1
	mMsg.Recipient[li_cc].RecipientType = mailTo!
	mMsg.Recipient[li_cc].name = ls_mailto_arr[li_cnt]
next
for li_cnt = 1 to upperbound(ls_mailcc_arr)
	li_cc +=1
	mMsg.Recipient[li_cc].RecipientType = mailCC!  //CC
	mMsg.Recipient[li_cc].name = ls_mailcc_arr[li_cnt]
next
//------------------- APPEON END -------------------

mRet = mSes.mailSend(mMsg)

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// check for errors
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

choose case mret 
        case mailReturnAccessDenied! 
                ls_message = 'Access Denied' 
        case mailReturnAttachmentNotFound! 
                ls_message = 'Attachment Not Found' 
        case mailReturnAttachmentOpenFailure! 
                ls_message = 'Attachment Open Failure' 
        case mailReturnAttachmentWriteFailure! 
                ls_message = 'Attachment Write Failure' 
        case mailReturnDiskFull! 
                ls_message = 'Disk Full' 
        case mailReturnFailure! 
                ls_message = 'Failure' 
        case mailReturnInsufficientMemory! 
                ls_message = 'Insufficient Memory' 
        case mailReturnInvalidMessage! 
                ls_message = 'Invalid Message' 
        case mailReturnLoginFailure! 
                ls_message = 'Login Failure' 
        case mailReturnMessageInUse! 
                ls_message = 'Message In Use' 
        case mailReturnNoMessages! 
                ls_message = 'No Messages' 
        case mailReturnTextTooLarge! 
                ls_message = 'Text Too Large' 
        case mailReturnTooManyFiles! 
                ls_message = 'Too Many Files' 
        case mailReturnTooManyRecipients! 
                ls_message = 'Too Many Recipients' 
			   ll_return	= -8 //continue in a loop for invalid recipient; bug4068 - long.zhang 06.11.2014							 
        case mailReturnTooManySessions! 
                ls_message = 'Too Many Sessions' 
        case mailReturnUnknownRecipient! 
                ls_message = 'Unknown Recipient' 
			  ll_return	= -8 //continue in a loop for invalid recipient; bug4068 - long.zhang 06.11.2014							 		 
        case mailReturnUserAbort! 
                ls_message = 'User Abort' 
        case mailReturnSuccess! 
                ls_message = '' 
				//---------- APPEON BEGIN ----------
				//$<add> Evan 06.11.2012
				//$<reason> V12.2-Email Logging
				lblb_MailContent = Blob(as_cover_text, EncodingANSI!)
				inv_EmailLog.of_SaveSentItem(gs_user_id,as_Subject,"",as_email_address, as_email_cc, "",&
							ls_AttachmentName,2,2,lblb_MailContent,&
							il_ae_id) //add il_ae_id, modified by Appeon long.zhang 07.05.2017 (v15.4 WebView Email Notifications))
				//---------- APPEON END ------------
        case else 
                ls_message = 'Other' 
end choose 

//-------------appeon begin----------------------
//<$>added:long.zhang 09.17.2013
//<$>reason:Ticket # 00036994: Problem with Failure in IC When sending email  
if ls_message = "Failure" then
	if of_email_outlookapp(as_recipient,as_company,as_email_address,as_subject,as_cover_text,as_attachments[],as_cover_page,as_email_cc) = 1 then
		ls_message = ''
	//------------------- APPEON BEGIN -------------------
	//<$>Comment:long.zhang 07.05.2017
	//<$>reason: these scripts have been moved to of_email_outlookapp.
//		lblb_MailContent = Blob(as_cover_text, EncodingANSI!)
//		inv_EmailLog.of_SaveSentItem(gs_user_id,as_Subject,"",as_email_address, as_email_cc, "",ls_AttachmentName,2,2,lblb_MailContent)
	//------------------- APPEON END -------------------	
	end if
end if
//-------------appeon End------------------------

if ls_message <> '' then 
	MessageBox ( 'Mail Return Code', ls_message, Exclamation!)
end if 

mSes.mailLogoff()

DESTROY mSes

Return ll_return
end function

public function integer of_email_new (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id, blob ab_mess, string as_cc_recp);//////////////////////////////////////////////////////////////////////
// $<event> of_email_new
// $<arguments>
// $<returns> long
// $<description> Editing Fax Template while in process - Bug id 2668
//////////////////////////////////////////////////////////////////////
// $<add> 09.27.2011 by Stephen
//////////////////////////////////////////////////////////////////////
Integer i
Integer res, li_export_id
Long ll_BlobLen, ll_WriteLength
Long ll_Return
String ls_address_mailcc,ls_attachments
String ls_filename
String ls_sendcc  
Blob lbob_Message
Blob lblb_data

str_email ls_email_info
datastore lds_export
pfc_n_cst_ai_export_apb lnv_export
n_cst_word_utility lnv_word_outlook
n_cst_easymail_smtp lnv_Mail

//---------Begin Added for bug4068 by long.zhang 06.11.2014 for V142 ISG-CLX --------
as_email_address = of_email_validation (as_email_address)
if as_email_address = "-1" then return -8 //continue in a loop for invalid recipient; 
//---------End Added ----------------------------------------------------------------------------

//1. For Outlook
if  gi_email_type = 1 then  
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 12.22.2011
	//$<reason> Merge fields not populating from email templates -Bug 2833 
	lnv_word_outlook = Create n_cst_word_utility
	lds_export = create datastore
	lnv_export = create pfc_n_cst_ai_export_apb	
	select export_id,  cc_recip into :li_export_id, :ls_sendcc                    
	  from wf_email where email_id = :al_email_id;   //modify by stephen 05.07.2013 add cc_recip --V12.3 add email cc
	if Not IsNull(li_export_id) then //add if statement for Bug 3380 - alfee 01.14.2013
		If il_ae_id > 0 Then //WebView Audit Email,Added by Appeon long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
			n_cst_wv_audit_email lnv_wv_audit_email
			
			lnv_wv_audit_email = Create n_cst_wv_audit_email
			
			li_export_id = il_export_id
			
			if lnv_wv_audit_email.of_get_wv_audit_data(li_export_id, il_ae_id, il_facility_id, al_prac_id, lds_export) = 1 then	
				if lds_export.rowcount() > 0 then
					lnv_word_outlook.of_replace_export_text(as_cover_text, al_prac_id, lds_export)
					lnv_word_outlook.of_replace_export_text(as_subject, al_prac_id, lds_export) 
				end if
			end if
			
			Destroy lnv_wv_audit_email
		Else //Normal Export Id
			if lnv_export.of_get_export_data(li_export_id, al_prac_id, lds_export) = 1 then	
				if lds_export.rowcount() > 0 then
					lnv_word_outlook.of_replace_export_text(as_cover_text, al_prac_id, lds_export)
					lnv_word_outlook.of_replace_export_text(as_subject, al_prac_id, lds_export)  //(Appeon)Harry 03.16.2015 - for Requesting new V14.2 Web Package - Bug # 4439 - Merge fields in subject are not populating
				end if
			end if
		End If
	end if
	destroy lnv_word_outlook
	destroy lds_export
	destroy lnv_export
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 05.07.2013
	//$<reason>V12.3 add email cc
	/*	res = of_email_outlook( as_recipient, as_company, as_email_address,as_subject ,as_cover_text, as_attachments[],  as_cover_page )	*/
	//Start Code Change ----06.27.2013 #V12 maha - modified to allow cc from email window
	//	if isnull(ls_sendcc) then ls_sendcc = '' end if
	if  as_cc_recp = "DEFAULT" then
		//leave value from template
	else
		ls_sendcc = as_cc_recp
	end if
	//End Code Change ----06.27.2013	
	
	//---------Begin Added by (Appeon)Harry 02.02.2015 for bug of Allegheny- Attachments to Email Templates--------
	of_get_emailinfo(al_email_id,ls_email_info)

	//Save attact to temp dir
	IF LenA(ls_email_info.attach) > 0 THEN
		ls_filename = gs_temp_path  + "fax\" + ls_email_info.attach_name
		IF FileExists(ls_filename) THEN
			FileDelete (ls_filename )
		END IF
		ll_BlobLen = LenA(ls_email_info.attach)
		lblb_data = ls_email_info.attach //Add by Stephen 08.26.2011 --- email send failed.
		ll_WriteLength = AppeonWriteFile(ls_filename, lblb_data, ll_BlobLen)
		IF ll_WriteLength < 0 THEN RETURN -1
		as_attachments[UpperBound(as_attachments) + 1] = ls_filename
	END IF
	//---------End Added ------------------------------------------------------
	
	//---------Begin Modified by (Appeon)Stephen 04.28.2014 for  Emailing out of Intellicred in 64 bit office 2010--------
	//res = of_email_outlook( as_recipient, as_company, as_email_address,as_subject ,as_cover_text, as_attachments[],  as_cover_page, ls_sendcc )
	if gb_outlook_64bit = true then
		res = of_email_outlookapp( as_recipient, as_company, as_email_address,as_subject ,as_cover_text, as_attachments[],  as_cover_page, ls_sendcc )
	else
		res = of_email_outlook( as_recipient, as_company, as_email_address,as_subject ,as_cover_text, as_attachments[],  as_cover_page, ls_sendcc )
	end if
	//---------End Modfiied ------------------------------------------------------
	//------------------- APPEON END -------------------	
	return res
end if


//2. For Easymail
FOR i = 1 To UpperBound(as_attachments)
	IF i = 1 THEN
		ls_attachments = as_attachments[i]
	ELSE
		ls_attachments = ls_attachments + ',' +as_attachments[i]
	END IF	
NEXT

//get mail attach info by mail_id
of_get_emailinfo(al_email_id,ls_email_info)

//Save attact to temp dir
IF LenA(ls_email_info.attach) > 0 THEN
	//---------Begin Modified by (Appeon)Stephen 02.18.2014 for citrix user's temporary file paths in the Letter Printing--------
	//ls_filename = gs_dir_path + "IntelliCred\" + ls_email_info.attach_name
	ls_filename = gs_temp_path + ls_email_info.attach_name
	//---------End Modfiied ------------------------------------------------------	
	IF FileExists(ls_filename) THEN
		FileDelete (ls_filename )
	END IF
	ll_BlobLen = LenA(ls_email_info.attach)
	lblb_data = ls_email_info.attach //Add by Stephen 08.26.2011 --- email send failed.
	ll_WriteLength = AppeonWriteFile(ls_filename, lblb_data, ll_BlobLen)
	IF ll_WriteLength < 0 THEN RETURN -1
	ls_attachments = ls_attachments + ',' +ls_filename	
END IF

IF lnv_Mail.of_CreateObject() = -1 THEN
	f_show_message('create Email object','','','','')
	RETURN -1
END IF

if len(ab_mess) > 0 then
	lbob_Message = ab_mess
else
	of_GetEmailMessage(al_email_id,lbob_Message)
end if

Open(w_email_edit)
w_email_edit.ole_word.of_Open(lbob_Message)

//merge mail
n_cst_word_utility lnv_word
lnv_word = Create n_cst_word_utility
IF NOT IsNull(il_export_id) THEN //add if statement for Bug 3380 - alfee 01.14.2013
	If il_ae_id > 0 Then //WebView Audit Email,Added by Appeon long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
		lds_export = create datastore
		
		n_cst_wv_audit_email lnv_wv_audit_email2
		li_export_id = il_export_id
		lnv_wv_audit_email2 = Create n_cst_wv_audit_email
		if lnv_wv_audit_email2.of_get_wv_audit_data(li_export_id, il_ae_id, il_facility_id, al_prac_id, lds_export) = 1 then			
			lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, lds_export)
		End If
		
		Destroy lnv_wv_audit_email2
	Else	
		//lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, al_prac_id, il_export_id)  //Commented by (Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
		lnv_word.of_replace_export_word(w_email_edit.ole_word.Object.ActiveDocument, as_subject, al_prac_id, il_export_id) //(Appeon)Harry 03.09.2015 - Bug # 4439 - Merge fields in subject are not populating
	End If
END IF
Destroy lnv_word

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 05.07.2013
//$<reason>V12.3 add email cc
select   cc_recip into  :ls_sendcc                    
	  from wf_email where email_id = :al_email_id;   
ls_sendcc = trim(ls_sendcc)
if isnull(ls_sendcc) then 	ls_sendcc = ''

//Start Code Change ----06.27.2013 #V12 maha - modified to allow cc from email window
if  as_cc_recp = "DEFAULT" then
	//leave value from template
else
	ls_sendcc = as_cc_recp
end if
//End Code Change ----06.27.2013
//------------------- APPEON END -------------------

//ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, as_email_address, ls_address_mailcc,'', as_subject, w_email_edit.ole_word, ls_attachments,True)  //Commented by (Appeon)Harry 12.12.2014
//ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, as_email_address, ls_sendcc,'', as_subject, w_email_edit.ole_word, ls_attachments,True)  //(Appeon)Harry 12.12.2014 - for  Bug 4352
ll_Return = lnv_Mail.of_SendHtml(gs_user_Id, as_email_address, ls_sendcc,'', as_subject, w_email_edit.ole_word, ls_attachments,True, 0, 0, il_ae_id) //Add il_ae_id, by Appeon long.zhang 07.05.2017 (v15.4 WebView Email Notifications)

IF ll_Return <> 0 THEN
	//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
	//f_show_message('error_code_'+String(ll_Return),'%1S%',String(ll_Return),'','')
	If lnv_Mail.is_sendprotocol = 'SMTP' Then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
	Else
		f_show_message('error_code_'+string(ll_Return),'ALL',lnv_Mail.of_getemailerror(ll_Return),'','')
	End If
	//--------End Modified -------------------------------
	lnv_Mail.of_DeleteObject()
	Close(w_email_edit)//Added by  Nova 11.25.2010
	IF ll_Return = 8  THEN RETURN -8 //continue in a loop for invalid recipient; bug4068 - long.zhang 06.11.2014
	IF ll_Return = 30  THEN RETURN -30 //(Appeon)Harry 08.11.2014 - for Email Failed Again
	IF ll_Return = 7  THEN RETURN -7 //(Appeon)Harry 09.26.2014 - Email Error
	RETURN -1
END IF

lnv_Mail.of_DeleteObject()
Close(w_email_edit)//Added by  Nova 11.25.2010
//---------------------------- APPEON END ----------------------------

RETURN 1


end function

public function integer of_email_outlookapp (string as_reciptions, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, string as_email_cc);//====================================================================
//$<Function>: of_email_outlookapp
//$<Arguments>:
// 	value    string    as_reciptions
// 	value    string    as_company
// 	value    string    as_email_address
// 	value    string    as_subject
// 	value    string    as_cover_text
// 	value    string    as_attachments[]
// 	value    string    as_cover_page
// 	value    string    as_email_cc
//$<Return>:  integer
//$<Description>: Sent Email via outlook application,only sent failure by mailsession,
//This Funtion called from of_email_outlook
//$<Author>: (Appeon) long.zhang 09.17.2013 (V14.1 Recruitment Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
	//if appeongetclientType() = "WEB" then return -1  --//Commented by (Appeon)Stephen 04.28.2014 -  Emailing out of Intellicred in 64 bit office 2010
	
	//if gi_test_mode <> 1 then return -1
	OLEObject lole_outlook,lole_Msg
	Integer li_rtn,i
	Integer li_attachment_cnt
	boolean lb_outlook = false
	string ls_attach_file
	Blob lblb_MailContent //Added by Appeon long.zhang 07.05.2017
	
//	
//	if MessageBox("OLE Outlook","Email sent failure,would you like to send this email in outlook application?",Question!,YesNo!,1) = 1 then
//			lb_outlook = true
//	end if
	
	lole_outlook = Create OLEObject
	li_rtn = lole_outlook.connecttonewobject( "Outlook.Application")
	
	IF li_rtn <> 0 THEN
		MessageBox("OLE Outlook"," can not connected to the outlook application.~r~n Return value = " + String(li_rtn))
		Destroy lole_outlook
		Return -1
	END IF
	
	//------------------- APPEON BEGIN -------------------
	//$<add> Stephen 04.28.2014
	//$<reason> Emailing out of Intellicred in 64 bit office 2010
	string ls_outfile, ls_out[]
	if upperbound(as_attachments) > 1 then
		if f_combine_file(as_attachments, ls_outfile, 'email') = 1 then
			ls_out[1] = ls_outfile
			as_attachments = ls_out
		end if
	end if
	//------------------- APPEON End -------------------
	
	li_attachment_cnt = UpperBound(as_attachments[])
try
		lole_msg = lole_outlook.CreateItem(0)	//Mail Item
		lole_msg.Subject = as_subject
		lole_msg.body =as_cover_text
		
		lole_msg.to = as_email_address
		if lenA(as_email_cc) > 0 then lole_msg.cc = as_email_cc
	
		For i = 1 to li_attachment_cnt
			if not FileExists(as_attachments[i]) then continue //(Appeon)Stephen 04.28.2014 - Emailing out of Intellicred 
			if ls_attach_file <> '' then
				ls_attach_file +="*"+as_attachments[i]
			else
				ls_attach_file = as_attachments[i]
			end if
			lole_msg.attachments.add(as_attachments[i])
		end for
		
		//Display Outlook dialog when there is no Email To. Added by Appeon long.zhang 05.03.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
		If IsNull(as_email_address) or Trim(as_email_address) = '' Then
			lb_outlook = True
		End If
		
		if lb_outlook then
			lole_msg.display(true)
		else	
			lole_msg.send()
		end if	
		lole_msg.disconnectobject( )
		lole_outlook.disconnectobject( )
		if isvalid(lole_msg) then Destroy lole_msg
		if isvalid(lole_outlook) then Destroy lole_outlook
catch(OLERuntimeError er)		
		if isvalid(lole_msg) then Destroy lole_msg
		if isvalid(lole_outlook) then Destroy lole_outlook
		MessageBox("OLE Outlook", "Email sent failure the error is " + er.Description + ".~r~n" + er.Text)	
		if isNull(as_email_cc) then as_email_cc = ''
		//of_log_outlook(as_subject,as_cover_text,as_email_address, ls_attach_file,ls_attach_file,'','','',as_email_cc)//long.zhang 03.18.2013
		return -1
end try

//Log Email, Added by Appeon long.zhang 07.05.2017 (v15.4 WebView Email Notifications)
lblb_MailContent = Blob(as_cover_text, EncodingANSI!)
inv_EmailLog.of_SaveSentItem(gs_user_id,as_Subject,"",as_email_address, as_email_cc, "",&
		ls_attach_file,2,2,lblb_MailContent, &
		il_ae_id)
				
return 1
end function

public function integer of_email_new_wv_audit (string as_recipient, string as_company, string as_email_address, string as_subject, string as_cover_text, string as_attachments[], string as_cover_page, long al_email_id, long al_prac_id, blob ab_mess, string as_cc_recp, long al_ae_id, long al_facility_id, long al_export_id);//====================================================================
//$<Function>: of_email_new_wv_audit
//$<Arguments>:
// 	value    string    as_recipient
// 	value    string    as_company
// 	value    string    as_email_address
// 	value    string    as_subject
// 	value    string    as_cover_text
// 	value    string    as_attachments[]
// 	value    string    as_cover_page
// 	value    long      al_email_id
// 	value    long      al_prac_id
// 	value    blob      ab_mess
// 	value    string    as_cc_recp
// 	value    long      al_ae_id
// 	value    long      al_facility_id
// 	value    long      al_export_id
//$<Return>:  integer
//$<Description>: Send email, only used by webview audit email.
//$<Author>: (Appeon) long.zhang 07.03.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_rtn

If al_ae_id < 1 Then Return -1

//Set il_ae_id, it will be used in of_email_new
il_ae_id = al_ae_id
il_facility_id = al_facility_id
il_export_id = al_export_id

//Send mail
li_rtn = This.of_email_new( as_recipient, as_company,  as_email_address,  as_subject,  as_cover_text,  as_attachments[],  as_cover_page,  al_email_id,  al_prac_id, ab_mess,  as_cc_recp )

//Reset
il_ae_id = 0
il_facility_id = 0
il_export_id = 0

RETURN li_rtn


end function

on pfc_cst_nv_fax.create
call super::create
TriggerEvent( this, "constructor" )
end on

on pfc_cst_nv_fax.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

