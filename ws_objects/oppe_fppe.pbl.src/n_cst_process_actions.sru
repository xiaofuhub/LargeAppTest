$PBExportHeader$n_cst_process_actions.sru
forward
global type n_cst_process_actions from nonvisualobject
end type
end forward

global type n_cst_process_actions from nonvisualobject
end type
global n_cst_process_actions n_cst_process_actions

forward prototypes
public function integer of_add_next_process_action (long al_temp, long al_hdr, long al_step, long al_prac, long al_facility, datawindow adw_actions)
public function integer of_email ()
public function integer of_email_template (string as_mess)
end prototypes

public function integer of_add_next_process_action (long al_temp, long al_hdr, long al_step, long al_prac, long al_facility, datawindow adw_actions);////Start Code Change ----06.27.2011 #V11 maha - added for action creation
//al_temp, al_hdr, al_step, al_prac, al_facility,  adw_actions
//of_add_next_action(al_temp,al_hdr,0)  zero for the step means create first
datawindow ldw_actions
datetime ldt_today
integer nr
integer li_compl
integer li_pos
integer li_add = 1
integer li_type
integer li_days
integer li_find
long ll_step
long ll_rec
long ll_docid
string ls_res
string ls_ref

ldt_today = datetime(today(),now())
ldw_actions = adw_actions

//tab_1.selecttab(3)

ls_res = gnv_data.of_getitem( "process_steps", "next_step", string(al_temp) + "*" + string(al_step))
select max(rec_id) into :ll_rec from pd_process_actions;
if isnull(ll_rec ) then ll_rec = 0
//get the initial step.  if an auto-complete then loop until one is not.

if ls_res = "0" then
	return 0
else
	li_pos = pos(ls_res,"*",1)
	ll_step = long(mid(ls_res,1,li_pos - 1))
	li_compl = long(mid(ls_res,li_pos + 1))
	
	li_find = ldw_actions.find( "process_step =" + string(ll_step)  , 1, 10000)
	if li_find > 0 then return 0

	do while li_add = 1
		nr = ldw_actions.insertrow(0)
	//debugbreak()	
		li_days = integer(gnv_data.of_getitem( "process_steps", "due_days", "item_id = " + string(ll_step)))
		li_type = integer(gnv_data.of_getitem( "process_steps", "process_type", "item_id = " + string(ll_step)))
		ll_docid = long(gnv_data.of_getitem( "process_steps", "document_id", "item_id = " + string(ll_step))) 
		ls_ref = ""  //add by Stephen 09.08.2011 --Bug id 2608
		if li_type = 1 then //note
			ls_ref = gnv_data.of_getitem( "process_steps", "item_name", "item_id = " + string(ll_step))
		elseif li_type = 2 then //letter
			select doc_name into :ls_ref from sys_storage_docs where dct_id = :ll_docid;
			if isnull(ls_ref) or ls_ref = "" then ls_ref = "Letter"
		elseif li_type = 3 then //email
			select email_name into :ls_ref from wf_email where email_id = :ll_docid;
			if isnull(ls_ref) or ls_ref = "" then ls_ref = "Email"
		end if
	
		ll_rec++
		ldw_actions.setitem(nr ,"rec_id" ,ll_rec )
		ldw_actions.setitem(nr , "function_id" ,al_hdr )
		ldw_actions.setitem(nr , "prac_id" ,al_prac )
		ldw_actions.setitem(nr , "facility_id" ,al_facility )
		ldw_actions.setitem(nr , "function_type" , 1 ) //for ofe
		ldw_actions.setitem(nr , "document_id" , ll_docid)
		ldw_actions.setitem(nr , "active_status" , 1 )
		ldw_actions.setitem(nr , "process_type" , li_type)
		ldw_actions.setitem(nr , "due_date" , datetime(RelativeDate ( today(), li_days ),time("00:00:00")))
		ldw_actions.setitem(nr , "reference_value" ,ls_ref )
		ldw_actions.setitem(nr , "process_step" ,ll_step )
		ldw_actions.setitem(nr , "create_date" ,ldt_today )
		ldw_actions.setitem(nr , "create_user" , gs_user_id)
		ldw_actions.setitem(nr , "mod_date" , ldt_today)
		ldw_actions.setitem(nr , "mod_user" , gs_user_id)
		if li_compl = 1 then
			ldw_actions.setitem(nr , "response_code" ,-420 ) //auto-complete
			ldw_actions.setitem(nr , "user_name" ,gs_user_id )
			ldw_actions.setitem(nr , "print_flag" , 0)
			ldw_actions.setitem(nr , "priority_user" , gs_user_id)
			ldw_actions.setitem(nr , "complete_date" , ldt_today)
			ls_res = gnv_data.of_getitem( "process_steps", "next_step", string(al_temp) + "*" + string(ll_step))
			li_pos = pos(ls_res,"*",1)
			ll_step = long(mid(ls_res,1,li_pos - 1))
			li_compl = long(mid(ls_res,li_pos + 1))
			if ll_step = 0 then li_add = 0  //add by Stephen 09.08.2011 --Bug id 2608
		else
			li_add = 0
			ldw_actions.setitem(nr , "priority_user" , "PUBLIC")
			if li_type = 1 then //notation
				ldw_actions.setitem(nr , "print_flag" , 0)
			else
				ldw_actions.setitem(nr , "print_flag" , 1)
			end if
		end if
		
	loop
	nr = ldw_actions.update()
end if

return 1

end function

public function integer of_email ();//Start Code Change ----07.13.2011 #V11 maha - created
String ls_email_address
String ls_subject
String ls_notetext
Integer li_sub
string mess 
String	ls_Rtn
String ls_address_mailcc
string ls_attach = ""
long ll_Return

if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	//outlook
	n_cst_string lnv_string
	String ls_Recipient[]
	
	Open( w_get_email_address_message )
	
	mess = Message.StringParm
	IF Message.StringParm = "Cancel" THEN Return -1
	IF IsNull(mess) OR LenA(Trim(mess)) < 1 THEN Return -1 
	
	ls_email_address = MidA( Mess, 1, PosA( Mess, "*" ) -1)
	li_sub = PosA( Mess, "**" ) 
	ls_notetext = MidA( Mess, PosA( Mess, "*" ) +1, li_sub - PosA( Mess, "*" ) - 1)	
	ls_subject = MidA( Mess, li_sub +2) 
	
	//---------- APPEON BEGIN ----------
	//$<modify> Evan 06.13.2012
	//$<reason> V12.2-Email Logging
	/*
	mailSession mSes
	mailReturnCode mRet
	mailMessage mMsg
	mailFileDescription nfile1
	mailFileDescription nfile2
	mailFileDescription nfile3
	
	mSes = create mailSession
	
	mRet = mailReturnSuccess!
	
	mRet = mSes.mailLogon( mailNewSession!) 
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail", 'Logon failed.  Check to make sure you have an email id setup in the user painter.')		
		Return -1
	END IF
	
	mMsg.Subject = ls_subject
	mMsg.NoteText = ls_notetext
	
	mRet = mSes.mailSend(mMsg)
	
	IF mRet <> mailReturnSuccess! THEN
		MessageBox("Mail Send", 'Mail not sent')
		mSes.mailLogoff()
		DESTROY mSes
		Return -1
	END IF
	
	mSes.mailLogoff()
	DESTROY mSes
	
	Return -1
	*/
	n_cst_outlook lnv_Outlook
	if lnv_Outlook.of_Logon() = -1 then
		MessageBox("Mail", "Logon failed.  Check to make sure you have an email id setup in the user painter.")
		Return -1
	end if
	ll_Return = lnv_Outlook.of_Send(ls_email_address, "", "", ls_subject, ls_notetext, "")
	lnv_Outlook.of_Logoff()
	if ll_Return <> 1 then
		MessageBox("Mail Send", "Mail not sent.")
		Return -1
	end if
	//---------- APPEON END ------------
else		//easymail
	n_cst_easymail_smtp 	lnv_Mail
	
	Open( w_get_email_address_message )
	
	mess = Message.StringParm
	IF Message.StringParm = "Cancel" THEN Return -1
	IF IsNull(mess) OR LenA(Trim(mess)) < 1 THEN Return -1
	
	ls_email_address = MidA( Mess, 1, PosA( Mess, "*" ) -1)
	li_sub = PosA( Mess, "**" )
	ls_notetext = MidA( Mess, PosA( Mess, "*" ) +1, li_sub - PosA( Mess, "*" ) - 1)	
	ls_subject = MidA( Mess, li_sub +2) 
	
	if lnv_Mail.of_CreateObject() = -1 then
		f_show_message('create Email object','','','','')
		Return -1
	end if
	
	
	//---------- APPEON BEGIN ----------
	//$<modify> Evan 06.08.2012
	//$<reason> V12.2-Email Logging
	/*
	long 		ll_Port,ll_Authmode
	string 	ls_Server,ls_Account,ls_Password,ls_Email,ls_HtmlFile
	
	ls_HtmlFile = ls_notetext
	// Set SMTP information from user ID
	if lnv_Mail.of_GetDefaultAccount(gs_user_id,ls_Server,ll_Port,ll_Authmode,ls_Account,ls_Password,ls_Email) = -1 then Return -1
	
	ll_Return = lnv_Mail.of_SetSmtpInfo(ls_Server, ll_Port, ll_Authmode)
	if  ll_Return < 0 then return ll_Return
	
	ll_Return = lnv_Mail.of_SetAccountAddress(ls_Account, ls_Password, ls_Email)
	
	ll_Return = lnv_Mail.of_SendHtml(ls_email_address, ls_address_mailcc, '',ls_subject,ls_HtmlFile, ls_attach)
	*/
	ll_Return = lnv_Mail.of_SendHtml(gs_user_id, ls_email_address, ls_address_mailcc, '', ls_subject, ls_notetext, ls_attach)
	//---------- APPEON END ------------
	
	if ll_Return <> 0 then
		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')

		lnv_Mail.of_DeleteObject()
		return -1
	end if
	
	lnv_Mail.of_DeleteObject()
	
	Return 1
end if

end function

public function integer of_email_template (string as_mess);string ls_mes

ls_mes = as_mess

OpenWithParm( w_fax_win, ls_mes)



return 1
end function

on n_cst_process_actions.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_process_actions.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

