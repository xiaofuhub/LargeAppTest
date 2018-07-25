$PBExportHeader$n_cst_outlook.sru
forward
global type n_cst_outlook from nonvisualobject
end type
end forward

global type n_cst_outlook from nonvisualobject autoinstantiate
end type

type prototypes
function long GetDllDirectory(ref string as_Path) library "appeondll.dll" alias for "GetDllDirectory;Ansi"
function long SetDllDirectory(string as_Path) library "appeondll.dll" alias for "SetDllDirectory;Ansi"
function long LookupOutlookAccount(string as_DisplayName, ref string as_Account, long al_Retrieve) library "appeondll.dll" alias for "LookupOutlookAccount;Ansi"
function long SelectOutlookContacts(ref string as_To, ref string as_Cc, ref string as_Bcc, long al_Flags) library "appeondll.dll" alias for "SelectOutlookContacts;Ansi" //add by Evan 04.07.2011

FUNCTION ulong FindWindowByClassA(string classname,string windowname) LIBRARY "User32.dll" alias for "FindWindowA;Ansi"
FUNCTION boolean BringWindowToTop(ulong w_handle) LIBRARY "User32.dll"
end prototypes

type variables
string is_DllDirectory
boolean ib_Logon = false
mailSession ima_Session
n_cst_email_log inv_EmailLog //Evan 06.11.2012
//---------Begin Added by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
boolean ib_existsoutlook
//---------End Added ------------------------------------------------------------------

end variables

forward prototypes
public function integer of_selectcontacts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc)
public function integer of_lookupaccount (string as_displayname, ref string as_account, long al_retrieve)
public function integer of_setdlldirectory (string as_path)
public function string of_getdlldirectory ()
public function integer of_logon ()
public function integer of_logoff ()
public function integer of_parsetoarray (string as_mailto, string as_mailcc, string as_mailbcc, string as_attchment, ref string as_mailto_arr[], ref string as_mailcc_arr[], ref string as_mailbcc_arr[], ref string as_attchment_arr[])
public function string of_getfilename (string as_file)
public function integer of_selectxpcontacts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc)
public function integer of_send (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attachment)
public function string of_getaddressfromoutlook (string as_contactname)
public function integer of_send_64bit (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attach)
public function integer of_selectcontacts_ole (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc)
public function boolean of_refreshcontracts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc)
public subroutine of_bring_outlook_top ()
end prototypes

public function integer of_selectcontacts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc);long   ll_Cycle
long   ll_Result
string ls_DisplayName
string ls_Account
string ls_Prompt
string ls_DllDirectory
mailSession 	lma_Session
mailMessage 	lma_Message
mailReturnCode lma_ReturnCode

// Get DLL directory and load appeon.dll library firstly
ChangeDirectory(gs_current_path)
ls_DllDirectory = of_GetDllDirectory()

// Logon to Outlook
lma_Session = Create mailSession
lma_ReturnCode = lma_Session.mailLogon(mailNewSession!)
if lma_ReturnCode <> mailReturnSuccess! then
	Destroy lma_Session
	ChangeDirectory(gs_current_path)
	of_SetDllDirectory(ls_DllDirectory)
   MessageBox("Mail", "Logging in failed.")
   Return -1
end if

// Select contacts from AddressBook of Outlook
lma_ReturnCode = lma_Session.mailAddress(lma_Message)
if lma_ReturnCode = mailReturnSuccess! then
	for ll_Cycle = 1 to UpperBound(lma_Message.Recipient)
		// Lookup account according to display name
		ls_DisplayName = lma_Message.Recipient[ll_Cycle].Name
		ll_Result = of_LookupAccount(ls_DisplayName, ls_Account, 1)
		//---------Begin Added by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
		if ll_result = 0 and trim(ls_account) <> "" then ls_DisplayName = ls_account //jervis 08.30.2011		
		//---------End Added ------------------------------------------------------------------

		// Add account to single line edit control
		if lma_Message.Recipient[ll_Cycle].RecipientType = mailTo! then
			if sle_to.Text <> "" then sle_to.Text += ';'
			sle_to.Text += ls_DisplayName
		elseif lma_Message.Recipient[ll_Cycle].RecipientType = mailCc! then
			if sle_cc.Text <> "" then sle_cc.Text += ';'
			sle_cc.Text += ls_DisplayName
		elseif lma_Message.Recipient[ll_Cycle].RecipientType = mailBcc! then
			if sle_bcc.Text <> "" then sle_bcc.Text += ';'
			sle_bcc.Text += ls_DisplayName
		end if
		
		// Prompt user if no match account or an error occures
		if ll_Result = -1 then
			ls_Prompt = "No account is found for '" + ls_DisplayName + "' in Global Address List of Address Book, so emails may not reach '" + ls_DisplayName + "'."
			MessageBox("Prompt", ls_Prompt)
		//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------		
		  /*
			elseif ll_Result > 0 then	
		  */
		elseif ll_Result > 0  and ll_result <> 1000 then //1000:no install outlook or do not need to parse - jervis 09.05.2011		  
		//---------End Modfiied ------------------------------------------------------------------		
			ls_Prompt = "Failed to find the account. Error code is : " + String(ll_Result)
			MessageBox("Prompt", ls_Prompt)
		end if
	next
end if

// Logoff from Outlook
lma_Session.mailLogoff()
Destroy lma_Session
ChangeDirectory(gs_current_path)
of_SetDllDirectory(ls_DllDirectory)

Return 1
end function

public function integer of_lookupaccount (string as_displayname, ref string as_account, long al_retrieve);long ll_Result
string ls_Account

ls_Account = Space(255)
//---------Begin Modified by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
  /*
ll_Result = LookupOutlookAccount(as_DisplayName, ls_Account, al_Retrieve)
if ll_Result = 0 then	
	as_Account = ls_Account
end if      
  */
//if ib_ExistsOutLook and pos(as_DisplayName,'@') = 0 then //jervis 08.30.2011  //Commented by (Appeon)Harry 04.22.2014
if pos(as_DisplayName,'@') = 0 then  //(Appeon)Harry 04.22.2014 
	ll_Result = LookupOutlookAccount(as_DisplayName, ls_Account, al_Retrieve)
	ChangeDirectory(gs_current_path) //Added By Ken.Guo 10/17/2011. 
//---------Begin Modified by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
/*
	if ll_Result = 0 then	
		as_Account = ls_Account
	end if
else
	ll_Result = 1000  //no install outlook or do not need to parse - jervis 08.30.2011
end if

//Added debug log Ken.Guo 2011-08-29
If ls_Account = Space(255) Then
	gnv_debug.of_output( false, 'n_cst_outlook.of_lookupaccount('+as_DisplayName + ',ref Space(255),' + string(al_Retrieve)+') = ' + String(ll_Result) )
ElseIf isnull(ls_account) Then
	gnv_debug.of_output( false, 'n_cst_outlook.of_lookupaccount('+as_DisplayName + ',ref null,' + string(al_Retrieve)+') = ' + String(ll_Result) )
Else
	gnv_debug.of_output( false, 'n_cst_outlook.of_lookupaccount('+as_DisplayName + ',ref ' + ls_Account+',' + string(al_Retrieve)+') = ' + String(ll_Result) )
End If
*/
	if ll_Result = 0 then	
		as_Account = ls_Account
		gnv_debug.of_output(False, 'LookupOutlookAccount('+as_DisplayName+')= ' + as_Account)
	else
		gnv_debug.of_output(True, 'LookupOutlookAccount('+as_DisplayName+') failed. ret = ' + String(ll_Result))
		as_Account = This.of_getaddressfromoutlook( as_displayname )
		gnv_debug.of_output(True, 'GetAddressFromOutlook('+as_DisplayName+') = ' + as_Account)
		If as_Account <> ls_account and as_Account <> as_displayname Then
			ll_Result = 0
		End If
	end if
else
	If Not ib_ExistsOutLook Then
		gnv_debug.of_output(False, 'ib_ExistsOutLook = ' + String(ib_ExistsOutLook) + ' and ' + 'pos('+as_DisplayName+',~'@~') = ' + String(pos(as_DisplayName,'@'))  )
	End If
	ll_Result = 1000  //no install outlook or do not need to parse - jervis 08.30.2011
end if
//---------End Modfiied ------------------------------------------------------

//---------End Modfiied ------------------------------------------------------------------

// Returns  0 if it match account succeeds
// Returns -1 if it no match account
// Returns greater than 0 if an error occurs
Return ll_Result
end function

public function integer of_setdlldirectory (string as_path);SetDllDirectory(as_Path)

Return 1
end function

public function string of_getdlldirectory ();string ls_Path

ls_Path = Space(255)
GetDllDirectory(ls_Path)
ls_Path = Trim(ls_Path)

Return ls_Path
end function

public function integer of_logon ();//////////////////////////////////////////////////////////////////////
// $<function> of_logon
// $<arguments>
// $<returns> integer
// $<description> Logon outlook
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

if ib_Logon then Return 1
if gb_outlook_64bit = true then //(Appeon)Stephen 04.29.2014 - Emailing out of Intellicred in 64 bit office 2010
	return 1  
end if

if not IsValid(ima_Session) then
	ima_Session = Create mailSession
end if

if ima_Session.mailLogon(mailNewSession!) <> mailReturnSuccess! then
	Return -1
end if
ib_Logon = true

Return 1
end function

public function integer of_logoff ();//////////////////////////////////////////////////////////////////////
// $<function> of_logoff
// $<arguments>
// $<returns> integer
// $<description> Logoff outlook
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

if IsValid(ima_Session) then
	ima_Session.mailLogoff()
	Destroy ima_Session
end if
ib_Logon = false

ChangeDirectory(gs_current_path)
of_SetDllDirectory(is_DllDirectory)

Return 1
end function

public function integer of_parsetoarray (string as_mailto, string as_mailcc, string as_mailbcc, string as_attchment, ref string as_mailto_arr[], ref string as_mailcc_arr[], ref string as_mailbcc_arr[], ref string as_attchment_arr[]);//////////////////////////////////////////////////////////////////////
// $<function> of_parsetoarray
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

string ls_Temp
long i, ll_Return
n_cst_string lnv_string
string ls_mailto_temp[]
string ls_mailcc_temp[]
string ls_mailbcc_temp[]
string ls_attchment_temp[]

// Parse string to array
lnv_String.of_ParseToArray(as_mailto, ";", ls_mailto_temp[])
lnv_String.of_ParseToArray(as_mailcc, ";", ls_mailcc_temp[])
lnv_String.of_ParseToArray(as_mailbcc, ";", ls_mailbcc_temp[])
lnv_String.of_ParseToArray(as_attchment, ",", ls_attchment_temp[])

// To
for i = 1 to UpperBound(ls_mailto_temp[])
	ls_Temp = Trim(ls_mailto_temp[i])
	if LenA(ls_Temp) > 0 then
		as_mailto_arr[UpperBound(as_mailto_arr) + 1] = ls_Temp
	end if
next
// CC
for i = 1 to UpperBound(ls_mailcc_temp[])
	ls_Temp = Trim(ls_mailcc_temp[i])
	if LenA(ls_Temp) > 0 then
		as_mailcc_arr[UpperBound(as_mailcc_arr) + 1] = ls_Temp
	end if
next
// BCC
for i = 1 to UpperBound(ls_mailbcc_temp[])
	ls_Temp = Trim(ls_mailbcc_temp[i])
	if LenA(ls_Temp) > 0 then
		as_mailbcc_arr[UpperBound(as_mailbcc_arr) + 1] = ls_Temp
	end if
next
// Attchment
for i = 1 to UpperBound(ls_attchment_temp[])
	ls_Temp = Trim(ls_attchment_temp[i])
	if LenA(ls_Temp) > 0 then
		as_attchment_arr[UpperBound(as_attchment_arr) + 1] = ls_Temp
	end if
next

Return 1
end function

public function string of_getfilename (string as_file);//////////////////////////////////////////////////////////////////////
// $<function> of_getfilename
// $<arguments>
//			string	as_file
// $<returns> integer
// $<description> Get file short name
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
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

public function integer of_selectxpcontacts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc);//////////////////////////////////////////////////////////////////////
// $<function> of_SelectXpContacts
// $<arguments>
//		ref singlelineedit sle_to
//		ref singlelineedit sle_cc
//		ref singlelineedit sle_bcc
// $<returns> integer
// $<description> Select outlook contacts with XPmapi32.dll
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 04.07.2011
//////////////////////////////////////////////////////////////////////

long ll_Result
long i, ll_Count
string ls_Null[]
string ls_Recipients[]
string ls_To, ls_Cc, ls_Bcc
string ls_DisplayName, ls_Account
string ls_Prompt
n_cst_string lnv_string

ls_To = Space(3000)
ls_Cc = Space(3000)
ls_Bcc = Space(3000)

//Added by Appeon long.zhang 07.16.2015 (Email Configuration issue)
If gb_IsOS64 and gb_outlook_64bit Then 
	Return of_selectcontacts_ole(sle_to,sle_cc,sle_bcc)
End If

// Open Address Book dialog
SelectOutlookContacts(ls_To, ls_Cc, ls_Bcc, 0)

// Get Address Book dialog return value
ll_Count = SelectOutlookContacts(ls_To, ls_Cc, ls_Bcc, 1)
if ll_Count = -100 then
	MessageBox("Address Book", "Failed to select recipient. Error code is : -100", StopSign!)
	Return -1
elseif ll_Count < 1 then
	Return 0
end if

// To
if Len(Trim(ls_To)) > 0 then
	if Trim(sle_to.Text) = "" then sle_to.Text = ""
	lnv_String.of_ParseToArray(ls_To, ";", ls_Recipients[])
	for i = 1 to UpperBound(ls_Recipients)
		if sle_to.Text <> "" then sle_to.Text += ';'
		sle_to.Text += ls_Recipients[i]
		// Prompt user if no match account or an error occures
		ll_Result = of_LookupAccount(ls_Recipients[i], ls_Account, 1)
		if ll_Result = -1 then
			ls_DisplayName = ls_Recipients[i] //(Appeon)Harry 01.22.2014 - V142 ISG-CLX
			ls_Prompt = "No account is found for '" + ls_DisplayName + "' in Global Address List of Address Book, so emails may not reach '" + ls_DisplayName + "'."
			MessageBox("Prompt", ls_Prompt)
		elseif ll_Result > 0 then
			ls_Prompt = "Failed to find the account. Error code is : " + String(ll_Result)
			MessageBox("Prompt", ls_Prompt)
		end if
	next
end if

// Cc
if Len(Trim(ls_Cc)) > 0 then
	ls_Recipients[] = ls_Null[]
	if Trim(sle_cc.Text) = "" then sle_cc.Text = ""
	lnv_String.of_ParseToArray(ls_Cc, ";", ls_Recipients[])
	for i = 1 to UpperBound(ls_Recipients)
		if sle_cc.Text <> "" then sle_cc.Text += ';'
		sle_cc.Text += ls_Recipients[i]
		// Prompt user if no match account or an error occures
		ll_Result = of_LookupAccount(ls_Recipients[i], ls_Account, 1)
		if ll_Result = -1 then
			ls_DisplayName = ls_Recipients[i] //(Appeon)Harry 01.22.2014 - V142 ISG-CLX
			ls_Prompt = "No account is found for '" + ls_DisplayName + "' in Global Address List of Address Book, so emails may not reach '" + ls_DisplayName + "'."
			MessageBox("Prompt", ls_Prompt)
		elseif ll_Result > 0 then
			ls_Prompt = "Failed to find the account. Error code is : " + String(ll_Result)
			MessageBox("Prompt", ls_Prompt)
		end if
	next
end if

// Bcc
if Len(Trim(ls_Bcc)) > 0 then
	ls_Recipients[] = ls_Null[]
	if Trim(sle_bcc.Text) = "" then sle_bcc.Text = ""
	lnv_String.of_ParseToArray(ls_Bcc, ";", ls_Recipients[])
	for i = 1 to UpperBound(ls_Recipients)
		if sle_bcc.Text <> "" then sle_bcc.Text += ';'
		sle_bcc.Text += ls_Recipients[i]
		// Prompt user if no match account or an error occures
		ll_Result = of_LookupAccount(ls_Recipients[i], ls_Account, 1)
		if ll_Result = -1 then
			ls_DisplayName = ls_Recipients[i] //(Appeon)Harry 01.22.2014 - V142 ISG-CLX
			ls_Prompt = "No account is found for '" + ls_DisplayName + "' in Global Address List of Address Book, so emails may not reach '" + ls_DisplayName + "'."
			MessageBox("Prompt", ls_Prompt)
		elseif ll_Result > 0 then
			ls_Prompt = "Failed to find the account. Error code is : " + String(ll_Result)
			MessageBox("Prompt", ls_Prompt)
		end if
	next
end if

Return 1
end function

public function integer of_send (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attachment);//////////////////////////////////////////////////////////////////////
// $<function> of_send
// $<arguments>
//		string	as_mailto
//		string	as_mailcc
//		string	as_mailto
//		string	as_mailbcc
//		string	as_subject
//		string	as_message
//		string	as_attachment
// $<returns> integer
// $<description> Send email with outlook
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

string ls_MailTo[]
string ls_MailCc[]
string ls_MailBcc[]
string ls_Attachment[]
string ls_AttachmentName
integer i, li_Count
blob lblb_MailContent
mailMessage lma_Message
mailFileDescription lma_File
mailReturnCode lma_Return

//---------Begin Added by (Appeon)Stephen 04.29.2014 for Emailing out of Intellicred in 64 bit office 2010--------
if gb_outlook_64bit = true then
	return of_send_64bit(as_mailto, as_mailcc, as_mailbcc, as_subject, as_message, as_attachment)
end if
//---------End Added ------------------------------------------------------

if not ib_Logon then Return -1
do while(pos(trim(as_Message),"~r") = 1)  //add by stephen 04.19.2013--Ticket # 00041301: Notifications are not being emailed
	as_Message = mid(trim(as_Message), 3)
loop
		
if IsNull(as_Subject) then as_Subject = ""
if IsNull(as_Message) then as_Message = ""

// Parse string to array
of_ParseToArray(as_MailTo, as_MailCc, as_MailBcc, as_Attachment, ls_MailTo[], ls_MailCc[], ls_MailBcc[], ls_Attachment[])

// Add recipients
for i = 1 to UpperBound(ls_MailTo[])
	li_Count ++
	lma_Message.Recipient[li_Count].RecipientType = mailTo!  //To
	lma_Message.Recipient[li_Count].name = ls_MailTo[i]
next
for i = 1 to UpperBound(ls_MailCc[])
	li_Count ++
	lma_Message.Recipient[li_Count].RecipientType = mailCC!  //CC
	lma_Message.Recipient[li_Count].name = ls_MailCc[i]
next
for i = 1 to UpperBound(ls_MailBcc[])
	li_Count ++
	lma_Message.Recipient[li_Count].RecipientType = mailBCC! //BCC
	lma_Message.Recipient[li_Count].name = ls_MailBcc[i]
next
if li_Count < 1 then Return 0

// Add attachments
for i = 1 to UpperBound(ls_Attachment[])
	lma_File.FileType = MailAttach!
	lma_File.Position = i
	lma_File.FileName = of_GetFileName(ls_Attachment[i])
	lma_File.PathName = ls_Attachment[i]
	lma_Message.AttachmentFile[i] = lma_File
	//---------- APPEON BEGIN ----------
	//$<add> Evan 06.11.2012
	//$<reason> V12.2-Email Logging
	if Len(ls_AttachmentName) > 0 then ls_AttachmentName += ", "
	ls_AttachmentName += lma_File.FileName
	//---------- APPEON END ------------
next

// Send email
lma_Message.Subject = as_Subject
lma_Message.NoteText = as_Message
lma_Return = ima_Session.mailSend(lma_Message)
if lma_Return <> mailReturnSuccess! then
	Return -1
else //Evan 06.11.2012 --- V12.2-Email Logging
	lblb_MailContent = Blob(as_Message, EncodingANSI!)
	inv_EmailLog.of_SaveSentItem(gs_user_id,as_Subject,"",as_MailTo,as_MailCc,as_MailBcc,ls_AttachmentName,2,2,lblb_MailContent)
end if

Return 1
end function

public function string of_getaddressfromoutlook (string as_contactname);//====================================================================
// Function: of_getaddressfromoutlook
//--------------------------------------------------------------------
// Description:  Get Full SMTP Email Address from contact name
//--------------------------------------------------------------------
// Arguments:
//                as_contactname
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/27/2013
//--------------------------------------------------------------------
//Copyright (c) 2008-2013 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.22.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

oleobject lole_outlook,lole_NameSpace,lole_receipt, lole_Address_entry,lole_ExchangeUser
integer Li_Ret

lole_outlook = Create oleobject
Li_Ret = lole_outlook.ConnectToNewObject( "outlook.application")
If Li_Ret <> 0 Then
	Return as_contactname
End If

Try 
	lole_NameSpace = lole_outlook.GetNameSpace("MAPI")
	lole_receipt = lole_NameSpace.CreateRecipient(as_contactname)
	
	of_bring_outlook_top() //Added by Appeon long.zhang 12.20.2016 ( IC - Email Issue)

	lole_receipt.Resolve()
	If lole_receipt.Resolved Then
		lole_Address_entry = lole_receipt.AddressEntry
		If lole_Address_entry.type = 'SMTP' Then
			Return lole_Address_entry.Address
		ElseIf lole_Address_entry.type = 'EX' Then
			lole_ExchangeUser = lole_Address_entry.GetExchangeUser()
			Return lole_ExchangeUser.PrimarySmtpAddress  
		End If
	Else
		Return as_contactname
	End If
Catch (oleruntimeerror err1)
End Try

If isvalid(lole_outlook) Then
	lole_outlook.disconnectobject()
	Destroy lole_outlook
End If

Return as_contactname
end function

public function integer of_send_64bit (string as_mailto, string as_mailcc, string as_mailbcc, string as_subject, string as_message, string as_attach);//====================================================================
//$<Function>: of_send_64bit
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.29.2014 (Emailing out of Intellicred in 64 bit office 2010)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_att[]
string ls_attchment_temp[]
string ls_Temp
long   ll_Return
Long i
pfc_cst_nv_fax lnv_emailfax
n_cst_string lnv_string

lnv_emailfax = Create pfc_cst_nv_fax	

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 05.03.2017
//<$>reason:Attechment Support comma, for Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting
//ls_att[1] = as_attach
lnv_String.of_ParseToArray(as_attach, ",", ls_attchment_temp[])
for i = 1 to UpperBound(ls_attchment_temp[])
	ls_Temp = Trim(ls_attchment_temp[i])
	if LenA(ls_Temp) > 0 then
		ls_att[UpperBound(ls_att) + 1] = ls_Temp
	end if
next
//------------------- APPEON END -------------------

ll_Return = lnv_emailfax.of_email_outlookapp( "", "", as_mailto,as_subject , as_message, ls_att[],  "", as_mailcc )
destroy lnv_emailfax
if ll_Return <> 1 then
	Return -1
end if	

return 1
end function

public function integer of_selectcontacts_ole (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc);//////////////////////////////////////////////////////////////////////
// $<function> of_SelectContacts_ole
// $<arguments>
//		ref singlelineedit sle_to
//		ref singlelineedit sle_cc
//		ref singlelineedit sle_bcc
// $<returns> integer
// $<description> Select outlook contacts with ole outlook.application
//$<Author>: (Appeon) long.zhang 07.14.2015
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long i
Long ll_handle
Integer li_rtn,j
Integer li_type
string ls_Recipients[]
string ls_To, ls_Cc, ls_Bcc
string ls_DisplayName, ls_Account
string ls_Prompt
String ls_windowname
string ls_name,ls_address
Constant String OUTLOOK_CLASSNAME = 'rctrl_renwnd32'
Constant String PR_SMTP_ADDRESS = 'http://schemas.microsoft.com/mapi/proptag/0x39FE001E'
n_cst_string lnv_string
OLEObject lole_outlook, lole_session, lole_Msg
OLEOBject lole_recipients,lole_recipient
OLEOBject lole_exchange
Boolean lb_logon = false


lole_outlook = Create OLEObject
lole_outlook.disconnectobject( )
li_rtn = lole_outlook.connecttonewobject( "Outlook.Application")
IF li_rtn <> 0 THEN
	MessageBox("OLE Outlook"," can not connected to the outlook application.~r~n Return value = " + String(li_rtn))
	Destroy lole_outlook
	Return -1
END IF

//Create Session
SetNull( ls_windowname )
ll_handle = FindWindowByClassA(OUTLOOK_CLASSNAME,ls_windowname)
If ll_handle = 0 Then 	
	lole_session = lole_outlook.GetNameSpace('MAPI')
	lole_session.logon('','',false,true)
	lb_logon = True
Else
	lole_session = lole_outlook.Session
End If
yield()

//Bring Outlook to Top
SetNull( ls_windowname )
ll_handle = FindWindowByClassA(OUTLOOK_CLASSNAME,ls_windowname)
If ll_handle> 0 Then 	
	BringWindowToTop(ll_handle)
End If

try
	//Show Dialog
	lole_Msg = lole_session.GetSelectNamesDialog()
	//lole_Msg.NumberOfRecipientSelectors = 2 //Only show to and cc.
	lole_Msg.Display()
	
	//Receive address
	lole_recipients = lole_Msg.recipients
	i = lole_recipients.Count 
	If i >0 Then
		For j = 1 to i
			lole_recipient = lole_recipients.Item(j)
			ls_name = lole_recipient.name
			li_type = lole_recipient.Type //To 1,CC 2, BCC 3
			ls_address = ''
			
			//Office 2007+ OlAddressEntryUserType
			//0.olExchangeUserAddressEntry:	An Exchange user that belongs to the same Exchange forest.
			//1.olExchangeDistributionListAddressEntry:	An address entry that is an Exchange distribution list.
			//2.olExchangePublicFolderAddressEntry:	An address entry that is an Exchange public folder.
			//3.olExchangeAgentAddressEntry:  An address entry that is an Exchange agent.
			//4.olExchangeOrganizationAddressEntry:	An address entry that is an Exchange organization.
			//5.olExchangeRemoteUserAddressEntry:	An Exchange user that belongs to a different Exchange forest.
			//10.olOutlookContactAddressEntry:	An address entry in an Outlook Contacts folder.
			//11.olOutlookDistributionListAddressEntry:	An address entry that is an Outlook distribution list.	
			//20.olLdapAddressEntry:	An address entry that uses the Lightweight Directory Access Protocol (LDAP).
			//40.olOtherAddressEntry:	A custom or some other type of address entry such as FAX
			//30.olSmtpAddressEntry:	An address entry that uses the Simple Mail Transfer Protocol (SMTP).
	
			Choose case lole_recipient.AddressEntry.AddressEntryUserType
				Case 0, 3, 5
					lole_exchange = lole_recipient.AddressEntry.GetExchangeUser()
					If Not IsNull(lole_exchange) Then
						ls_address = lole_exchange.PrimarySmtpAddress
					End If
				Case else
					ls_address = lole_recipient.PropertyAccessor.GetProperty(PR_SMTP_ADDRESS)
			End Choose
			
			If IsNull(ls_address) Then ls_address = ''	
			
			If ls_address<> '' Then
				Choose case li_type//To 1,CC 2, BCC 3
					case 1 //To
						If ls_To <>'' Then
							ls_To += ';' + ls_address
						Else
							ls_To = ls_address
						End If
					Case 2 //CC
						If ls_Cc <>'' Then
							ls_Cc += ';' + ls_address
						Else
							ls_Cc = ls_address
						End If
					Case 3//BCC
						If ls_Bcc <>'' Then
							ls_Bcc += ';' + ls_address
						Else
							ls_Bcc = ls_address
						End If
				End Choose
			End If
		Next
	End If
catch(OLERuntimeError er)	
	If lb_logon Then  lole_session.logoff()
	lole_outlook.disconnectobject( )
	if isvalid(lole_outlook) then Destroy lole_outlook
	MessageBox("OLE Outlook", "Select Email Address failure the error is " + er.Description + ".~r~n" + er.Text)	
	return -1
end try

If lb_logon Then  lole_session.logoff()
lole_outlook.disconnectobject( )
Destroy lole_outlook

sle_to.text = ls_To
sle_cc.text = ls_Cc
sle_bcc.text = ls_Bcc

Return 1
end function

public function boolean of_refreshcontracts (ref singlelineedit sle_to, ref singlelineedit sle_cc, ref singlelineedit sle_bcc);//////////////////////////////////////////////////////////////////////
//====================================================================
//$<Function>: of_refreshcontracts
//$<Arguments>:
// 	reference    singlelineedit    sle_to
// 	reference    singlelineedit    sle_cc
// 	reference    singlelineedit    sle_bcc
//$<Return>:  boolean
//$<Description>: check outlook contacts with SelectOutlookContacts, and replace them with email address.
//$<Author>: (Appeon) long.zhang 12.19.2016 (IC - Email Issue)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_Result
long i, ll_Count, j
string ls_Recipients[]
string ls_To, ls_Cc, ls_Bcc, ls_process
string ls_DisplayName, ls_Account
string ls_Prompt
String ls_address
String ls_tmp
n_cst_string lnv_string
Boolean lb_succeed = True

ls_To = Trim(sle_to.text)
ls_Cc = Trim(sle_cc.text)
ls_Bcc = Trim(sle_bcc.text)

For j = 1 to 3
	ls_tmp = ''
	Choose Case j
		Case 1
			ls_process = ls_To
		Case 2
			ls_process = ls_Cc
		Case 3
			ls_process = ls_Bcc
	End Choose
	
	if Len(ls_process) > 0 then
		lnv_String.of_ParseToArray(ls_process, ";", ls_Recipients[])
		for i = 1 to UpperBound(ls_Recipients)
			If PosA(ls_Recipients[i],'@') = 0 Then				
				// Prompt user if no match account or an error occures
				ll_Result = of_LookupAccount(ls_Recipients[i], ls_address, 1)
				if ll_Result = -1 then
					ls_DisplayName = ls_Recipients[i]
					ls_Prompt = "Check contracts: No account is found for '" + ls_DisplayName + "' in Global Address List of Address Book, so emails may not reach '" + ls_DisplayName + "'."
					MessageBox("Prompt", ls_Prompt)
					lb_succeed = False
					ls_tmp += ls_Recipients[i] + ';'
				elseif ll_Result > 0 then
					ls_DisplayName = ls_Recipients[i]
					ls_Prompt = "Check contracts: Failed to find the account for '" + ls_DisplayName + "'. Error code is : " + String(ll_Result)
					MessageBox("Prompt", ls_Prompt)
					lb_succeed = False
					ls_tmp += ls_Recipients[i] + ';'
				Else
					ls_tmp += ls_address + ';'
				end if
			Else
				ls_tmp += ls_Recipients[i] + ';'
			End If
		next
	end if
	
	Choose Case j
		Case 1
			sle_to.text = ls_tmp
		Case 2
			sle_cc.text = ls_tmp
		Case 3
			sle_bcc.text = ls_tmp
	End Choose
Next

Return lb_succeed
end function

public subroutine of_bring_outlook_top ();//====================================================================
//$<Function>: of_bring_outlook_top
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Bring Outlook window to top
//$<Author>: (Appeon) long.zhang 12.20.2016 (v15.3 AD Authentication)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_windowname
Long ll_handle
Constant String OUTLOOK_CLASSNAME = 'rctrl_renwnd32'

//Bring Outlook to Top
SetNull( ls_windowname )
ll_handle = FindWindowByClassA(OUTLOOK_CLASSNAME,ls_windowname)
If ll_handle> 0 Then 	
	BringWindowToTop(ll_handle)
End If
end subroutine

on n_cst_outlook.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_outlook.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;//////////////////////////////////////////////////////////////////////
// $<event> destructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

of_Logoff()
end event

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 01.26.2010
//////////////////////////////////////////////////////////////////////

// Get DLL directory and load appeon.dll library firstly
ChangeDirectory(gs_current_path)
is_DllDirectory = of_GetDllDirectory()

//---------Begin Commented by (Appeon)Harry  04.22.2014 for V142 ISG-CLX--------
/*
//---------Begin Added by (Appeon)Eugene 06.26.2013 for V141 ISG-CLX--------
//Is installed outlook  - jervis 08.30.2011
oleobject lole_outlook
lole_outlook = Create oleobject
IF lole_outlook.Connecttonewobject("outlook.application") <> 0 THEN 
	ib_ExistsOutLook = false
else
	ib_ExistsOutLook = true
end if
Destroy lole_outlook
//---------End Added ------------------------------------------------------------------
*/
//---------End Commented ------------------------------------------------------
end event

