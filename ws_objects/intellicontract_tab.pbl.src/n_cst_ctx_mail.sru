$PBExportHeader$n_cst_ctx_mail.sru
$PBExportComments$User object for creating letters
forward
global type n_cst_ctx_mail from nonvisualobject
end type
end forward

global type n_cst_ctx_mail from nonvisualobject autoinstantiate
end type

forward prototypes
public subroutine of_get_alertmsg_ai (long al_ctx_id, long al_ai_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message)
public subroutine of_get_alertmsg_amai (long al_doc_id, long al_seq_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message)
public subroutine of_get_mail_template (long al_email_id, ref blob ablb_message)
public subroutine of_get_alertmsg (long al_ctx_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message)
public function integer of_get_message (string as_alarm_from, str_alarm astr_alm, ref blob ablb_message)
public function string of_write_attachfile (blob ablb_attachment, string as_attachment)
public subroutine of_get_mail_template_attachment (long al_email_id, ref string as_attachname[], ref blob ablb_attachment[])
public subroutine of_get_almattach (long al_ctx_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[])
public function integer of_get_attachment (string as_alarm_from, str_alarm astr_alm, ref string as_attachname[], ref blob ablb_attachment[])
public subroutine of_get_almattach_ai (long al_ctx_id, long al_ai_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[])
public subroutine of_get_almattach_amai (long al_doc_id, long al_seq_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[])
public subroutine of_get_almattach_template (long al_view_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[])
public function integer of_get_mail_template_attachment (long al_email_id, ref string al_attachfullname[])
public subroutine of_get_alertmsg_all (long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2, string as_table, string as_column, long al_len_msg, ref blob ablb_message)
public subroutine of_get_almattach_all (long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[])
public function integer of_get_mail_template (long al_email_id, ref blob ablb_message, ref str_email astr_email)
end prototypes

public subroutine of_get_alertmsg_ai (long al_ctx_id, long al_ai_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message);//Get Date Alarm Message of Contract Action Item - Alfee 06.11.2008

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000


//Get length of the message if not specified 
ll_DataLen = al_len_msg
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_Message_blob) INTO :ll_DataLen FROM ctx_ai_notification
	 WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_Message_blob,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_ai_notification 
		  WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_Message += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_Message_blob
	      INTO :ablb_Message
	      FROM ctx_ai_notification
	     WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF

end subroutine

public subroutine of_get_alertmsg_amai (long al_doc_id, long al_seq_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message);//Get Date Alarm Message of Contract Action Item - Alfee 06.11.2008

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000


//Get length of the message if not specified 
ll_DataLen = al_len_msg
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_Message_blob) INTO :ll_DataLen FROM ctx_am_ai_notification
	 WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_Message_blob,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_am_ai_notification 
		  WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_Message += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_Message_blob
	      INTO :ablb_Message
	      FROM ctx_am_ai_notification
	     WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF

end subroutine

public subroutine of_get_mail_template (long al_email_id, ref blob ablb_message);str_email lstr_email

of_get_mail_template(al_email_id,ablb_message,lstr_email)

/*
long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message)
  INTO :ll_DataLen
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email
		     WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	next
else
	SELECTBLOB Email_Message
	      INTO :ablb_Message
	      FROM wf_email
	     WHERE wf_email.email_id = :al_EMail_Id;
end if
*/
end subroutine

public subroutine of_get_alertmsg (long al_ctx_id, string as_table, string as_column, long al_len_msg, ref blob ablb_message);//Get Date Alarm Message of Contract - Alfee 06.11.2008

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000


//Get length of the message if not specified 
ll_DataLen = al_len_msg
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_Message_blob) INTO :ll_DataLen FROM ctx_notification
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_Message_blob,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_notification 
		  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_Message += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_Message_blob
	      INTO :ablb_Message
	      FROM ctx_notification
	     WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF

end subroutine

public function integer of_get_message (string as_alarm_from, str_alarm astr_alm, ref blob ablb_message);//Get Alarm Message
Integer li_rtn

CHOOSE CASE Upper(as_alarm_from)
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'   //add ctx_custom - jervis 06.07.2011
		of_get_alertmsg(astr_alm.ctx_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_message_length, ablb_message )
	CASE 'CTX_ACTION_ITEM'
		of_get_alertmsg_ai(astr_alm.ctx_id, astr_alm.ai_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_message_length, ablb_message )	
	CASE 'CTX_AM_ACTION_ITEM'
		of_get_alertmsg_amai(astr_alm.doc_id, astr_alm.seq_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_message_length, ablb_message )	
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' //add by jervis 07.05.2011
	case else //add fee scheduce - jervis 08.02.2011
		of_get_alertmsg_all(astr_alm.ctx_id,astr_alm.doc_id,astr_alm.level_id1,astr_alm.level_id2, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_message_length, ablb_message )
END CHOOSE

RETURN 1
end function

public function string of_write_attachfile (blob ablb_attachment, string as_attachment);//Write blob into an attachment temproary file 
Integer li_rtn
String ls_attach_fullname

n_cst_filesrv lnv_file

f_SetFileSrv(lnv_file,true)

//Gen attachment full name
gnv_appeondll.of_parsepath(gs_dir_path + gs_DefDirName + "\Email\")
ls_attach_fullname = gs_dir_path + gs_DefDirName + "\Email\" + as_attachment

//write attachment file
li_rtn = lnv_file.of_FileWrite(ls_attach_fullname, ablb_attachment,false) 

f_SetFileSrv(lnv_file,false)

IF li_rtn < 0 THEN RETURN ''	

RETURN ls_attach_fullname

end function

public subroutine of_get_mail_template_attachment (long al_email_id, ref string as_attachname[], ref blob ablb_attachment[]);//====================================================================
// Function: of_get_mail_template_attachment()
//--------------------------------------------------------------------
// Description: Get attachments from email painter 
//--------------------------------------------------------------------
// Arguments:
// 	value    	long		al_Email_id
// 	value    	string	as_AttachName[]
// 	reference	blob		ablb_Attachment[]
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_EmailCycle,ll_EmailCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_EmailAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_EmailAttach = Create DataStore

lds_EmailAttach.DataObject = "d_email_attach"
lds_EmailAttach.SetTransObject(SQLCA)
lds_EmailAttach.Retrieve(al_EMail_Id)

ll_EmailCnts = lds_EmailAttach.RowCount()
for ll_EmailCycle = 1 to ll_EmailCnts
	ll_Attach_id = lds_EmailAttach.GetItemNumber(ll_EmailCycle,"attach_id")
	as_AttachName[ll_OriAttachCnt + ll_EmailCycle] = lds_EmailAttach.GetItemString(ll_EmailCycle,"attach_name")
	
	SELECT Datalength(Attachment)
	  INTO :ll_AttachLen
	  FROM wf_email_attachment
	 WHERE email_id = :al_EMail_Id AND attach_id = :ll_Attach_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(Attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM wf_email_attachment
				  WHERE email_id = :al_EMail_Id AND attach_id = :ll_Attach_id;
			
			ablb_Attachment[ll_OriAttachCnt + ll_EmailCycle] += lb_Temp
		next
	else
		SELECTBLOB Attachment
				INTO :ablb_Attachment[ll_OriAttachCnt + ll_EmailCycle]
				FROM wf_email_attachment
			  WHERE email_id = :al_EMail_Id AND attach_id = :ll_Attach_id;
	end if
next

Destroy lds_EmailAttach

end subroutine

public subroutine of_get_almattach (long al_ctx_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[]);//====================================================================
// Function: of_get_almattach()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long  	al_ctx_id        	
// 	value    	string	as_table         	
// 	value    	string	as_column        	
// 	reference	string	as_attachname[]  	
// 	reference	blob  	ablb_attachment[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_AlarmCycle,ll_AlarmCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_AlarmAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_AlarmAttach = Create DataStore

lds_AlarmAttach.DataObject = "d_alarm_attach"
lds_AlarmAttach.SetTransObject(SQLCA)
lds_AlarmAttach.Retrieve(al_ctx_id,as_table,as_column)

ll_AlarmCnts = lds_AlarmAttach.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnts
	ll_Attach_id = lds_AlarmAttach.GetItemNumber(ll_AlarmCycle,"attach_id")
	as_AttachName[ll_OriAttachCnt + ll_AlarmCycle] = lds_AlarmAttach.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_AttachLen
	  FROM ctx_alarm_attachment
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_alarm_attachment
				  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
			
			ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle]
				FROM ctx_alarm_attachment
			  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	end if
next

Destroy lds_AlarmAttach

/*
//Get Date Alarm Attachment of Contract - Alfee 06.11.2008

//Get length of the message if not specified 
ll_DataLen = al_length
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_attachment) INTO :ll_DataLen FROM ctx_notification
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_notification 
		  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_attachment += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_attachment
	      INTO :ablb_attachment
	      FROM ctx_notification
	     WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF
*/

end subroutine

public function integer of_get_attachment (string as_alarm_from, str_alarm astr_alm, ref string as_attachname[], ref blob ablb_attachment[]);//Get alarm attachment 
Integer li_rtn

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-23 By: Scofield
//$<Reason> Get multi-attachment files.

CHOOSE CASE Upper(as_alarm_from)
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 06.07.2011
		of_get_almattach(astr_alm.ctx_id, astr_alm.alm_table, astr_alm.alm_column, as_AttachName, ablb_attachment)
		//of_get_almattach(astr_alm.ctx_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_attachment_length, ablb_attachment )
	CASE 'CTX_ACTION_ITEM'
		of_get_almattach_ai(astr_alm.ctx_id, astr_alm.ai_id, astr_alm.alm_table, astr_alm.alm_column, as_attachname, ablb_attachment)	
		//of_get_almattach_ai(astr_alm.ctx_id, astr_alm.ai_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_attachment_length, ablb_attachment )	
	CASE 'CTX_AM_ACTION_ITEM'
		of_get_almattach_amai(astr_alm.doc_id, astr_alm.seq_id, astr_alm.alm_table, astr_alm.alm_column, as_attachname, ablb_attachment)
		//of_get_almattach_amai(astr_alm.doc_id, astr_alm.seq_id, astr_alm.alm_table, astr_alm.alm_column, astr_alm.alm_attachment_length, ablb_attachment )	
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' //jervis 07.05.2011
	case else //add fee scheduce - jervis 08.02.2011
		of_get_almattach_all(astr_alm.ctx_id,astr_alm.doc_id,astr_alm.level_id1,astr_alm.level_id2, astr_alm.alm_table, astr_alm.alm_column, as_AttachName, ablb_attachment)
END CHOOSE

//---------------------------- APPEON END ----------------------------

RETURN 1

end function

public subroutine of_get_almattach_ai (long al_ctx_id, long al_ai_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[]);//====================================================================
// Function: of_get_almattach_ai()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long  	al_ctx_id        	
// 	value    	long  	al_ai_id         	
// 	value    	string	as_table         	
// 	value    	string	as_column        	
// 	reference	string	as_AttachName[]  	
// 	reference	blob  	ablb_Attachment[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_AlarmCycle,ll_AlarmCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_AlarmAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_AlarmAttach = Create DataStore

lds_AlarmAttach.DataObject = "d_ai_alarm_attach"
lds_AlarmAttach.SetTransObject(SQLCA)
lds_AlarmAttach.Retrieve(al_ctx_id,al_ai_id,as_table,as_column)

ll_AlarmCnts = lds_AlarmAttach.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnts
	ll_Attach_id = lds_AlarmAttach.GetItemNumber(ll_AlarmCycle,"attach_id")
	as_AttachName[ll_OriAttachCnt + ll_AlarmCycle] = lds_AlarmAttach.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_AttachLen
	  FROM ctx_ai_alarm_attachment
	 WHERE ctx_id = :al_ctx_id AND item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_ai_alarm_attachment
				  WHERE ctx_id = :al_ctx_id AND item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
			
			ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle]
				FROM ctx_ai_alarm_attachment
			  WHERE ctx_id = :al_ctx_id AND item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	end if
next

Destroy lds_AlarmAttach

/*
//Get Date Alarm Attachment of Contract Action Item - Alfee 06.11.2008

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000


//Get length of the message if not specified 
ll_DataLen = al_length
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_attachment) INTO :ll_DataLen FROM ctx_ai_notification
	 WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_ai_notification 
		  WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_attachment += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_attachment
	      INTO :ablb_attachment
	      FROM ctx_ai_notification
	     WHERE ctx_id = :al_ctx_id AND ctx_action_item_id = :al_ai_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF
*/
end subroutine

public subroutine of_get_almattach_amai (long al_doc_id, long al_seq_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[]);//====================================================================
// Function: of_get_almattach_amai()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long  	al_doc_id
// 	value    	long  	al_seq_id
// 	value    	string	as_table
// 	value    	string	as_column
// 	reference	string	as_AttachName[]
// 	reference	blob  	ablb_Attachment[]
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-24
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_AlarmCycle,ll_AlarmCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_AlarmAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_AlarmAttach = Create DataStore

lds_AlarmAttach.DataObject = "d_am_ai_alarm_attach"
lds_AlarmAttach.SetTransObject(SQLCA)
lds_AlarmAttach.Retrieve(al_doc_id,al_seq_id,as_table,as_column)

ll_AlarmCnts = lds_AlarmAttach.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnts
	ll_Attach_id = lds_AlarmAttach.GetItemNumber(ll_AlarmCycle,"attach_id")
	as_AttachName[ll_OriAttachCnt + ll_AlarmCycle] = lds_AlarmAttach.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_AttachLen
	  FROM ctx_am_ai_alarm_attachment
	 WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_am_ai_alarm_attachment
				  WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
			
			ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle]
				FROM ctx_am_ai_alarm_attachment
			  WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id;
	end if
next

Destroy lds_AlarmAttach

/*
//Get Date Alarm Attachment of Contract Action Item - Alfee 06.11.2008

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

//Get length of the message if not specified 
ll_DataLen = al_length
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_attachment) INTO :ll_DataLen FROM ctx_am_ai_notification
	 WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_am_ai_notification 
		  WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_attachment += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_attachment
	      INTO :ablb_attachment
	      FROM ctx_am_ai_notification
	     WHERE doc_id = :al_doc_id AND seq_id = :al_seq_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF
*/

end subroutine

public subroutine of_get_almattach_template (long al_view_id, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_mailof_get_almattach_template()
// $<arguments>
//		value    	long  	al_view_id     		
//		value    	string	as_table       		
//		value    	string	as_column      		
//		reference	string	s              		
//		reference	string	ablb_attachment		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-09-11 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long	i,ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_AlarmCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_AlarmAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_AlarmAttach = Create DataStore

lds_AlarmAttach.DataObject = "d_notification_templates_attachment"
lds_AlarmAttach.SetTransObject(SQLCA)
lds_AlarmAttach.Retrieve(al_view_id,as_table,as_column)

ll_AlarmCnts = lds_AlarmAttach.RowCount()
for i = 1 to ll_AlarmCnts
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(1)
	ll_Attach_id = lds_AlarmAttach.GetItemNumber(i,"id")
	as_AttachName[i] = lds_AlarmAttach.GetItemString(i,"alm_attachment_name")
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_AttachLen
	  FROM ctx_notification_templates_attachments
	  WHERE  id = :ll_Attach_id;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_notification_templates_attachments
				   WHERE  id = :ll_Attach_id;
			
			ablb_Attachment[i] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :ablb_Attachment[i]
				FROM ctx_notification_templates_attachments
	  		   WHERE  id = :ll_Attach_id;
	end if
next

Destroy lds_AlarmAttach


end subroutine

public function integer of_get_mail_template_attachment (long al_email_id, ref string al_attachfullname[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_ctx_mailof_get_mail_template_attachment()
// $<arguments>
//		value    	long  	al_email_id        		
//		reference	string	al_attachfullname[]		
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2010-08-09 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i
String ls_attchname[]
Blob lb_message[]
This.of_get_mail_template_attachment( al_email_id, ls_attchname[], lb_message[])

For i = 1 To UpperBound(ls_attchname[])
	al_attachfullname[i] = of_write_attachfile(lb_message[i], ls_attchname[i])
Next

Return 1
end function

public subroutine of_get_alertmsg_all (long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2, string as_table, string as_column, long al_len_msg, ref blob ablb_message);//Get Date Alarm Message of Contract - add by jervis 07.04.2011

long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000


//Get length of the message if not specified 
ll_DataLen = al_len_msg
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_Message_blob) INTO :ll_DataLen FROM ctx_all_notification
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column and
	 			doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_Message_blob,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_all_notification 
		  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column and 
		  			doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
		
		ablb_Message += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_Message_blob
	      INTO :ablb_Message
	      FROM ctx_all_notification
	     WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column and 
		  doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
END IF

end subroutine

public subroutine of_get_almattach_all (long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2, string as_table, string as_column, ref string as_attachname[], ref blob ablb_attachment[]);//====================================================================
// Function: of_get_almattach_all()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    	long  	al_ctx_id        	
// 	value    	string	as_table         	
// 	value    	string	as_column        	
// 	reference	string	as_attachname[]  	
// 	reference	blob  	ablb_attachment[]	
//--------------------------------------------------------------------
// Returns:  (none)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-02-23
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_AttachLen,ll_ReadCycle,ll_ReadCnts,ll_Start,ll_Attach_id
long	ll_AlarmCycle,ll_AlarmCnts,ll_OriAttachCnt
Blob	lb_Temp

DataStore	lds_AlarmAttach

long READ_ONE_LENGTH = 8000

ll_OriAttachCnt = UpperBound(ablb_Attachment)

lds_AlarmAttach = Create DataStore

lds_AlarmAttach.DataObject = "d_all_alarm_attach"
lds_AlarmAttach.SetTransObject(SQLCA)
lds_AlarmAttach.Retrieve(al_ctx_id,al_doc_id,al_level_id1,al_level_id2,as_table,as_column)

ll_AlarmCnts = lds_AlarmAttach.RowCount()
for ll_AlarmCycle = 1 to ll_AlarmCnts
	ll_Attach_id = lds_AlarmAttach.GetItemNumber(ll_AlarmCycle,"attach_id")
	as_AttachName[ll_OriAttachCnt + ll_AlarmCycle] = lds_AlarmAttach.GetItemString(ll_AlarmCycle,"alm_attachment_name")
	
	SELECT Datalength(alm_attachment)
	  INTO :ll_AttachLen
	  FROM ctx_all_alarm_attachment
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id and 
	 			doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
	
	if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_AttachLen > READ_ONE_LENGTH then
		ll_ReadCnts = Ceiling(ll_AttachLen/READ_ONE_LENGTH)
		
		for ll_ReadCycle = 1 To ll_ReadCnts
			ll_Start = (ll_ReadCycle - 1) * READ_ONE_LENGTH + 1
			SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH)
					INTO :lb_Temp
					FROM ctx_all_alarm_attachment
				  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id and 
				   doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
			
			ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle] += lb_Temp
		next
	else
		SELECTBLOB alm_attachment
				INTO :ablb_Attachment[ll_OriAttachCnt + ll_AlarmCycle]
				FROM ctx_all_alarm_attachment
			  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column AND attach_id = :ll_Attach_id and 
				  doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2;
	end if
next

Destroy lds_AlarmAttach

/*
//Get Date Alarm Attachment of Contract - Alfee 06.11.2008

//Get length of the message if not specified 
ll_DataLen = al_length
IF IsNull(ll_DataLen) or ll_DataLen < 0 THEN 
	SELECT Datalength(alm_attachment) INTO :ll_DataLen FROM ctx_notification
	 WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column;
END IF	 

//Get blob data of the message 
IF AppeonGetClientType() = 'PB' AND gs_dbtype = 'SQL' AND ll_DataLen > READ_ONE_LENGTH THEN
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)

	FOR ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_attachment,:ll_Start,:READ_ONE_LENGTH) 
	      INTO :lb_Temp 
			FROM ctx_notification 
		  WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
		
		ablb_attachment += lb_Temp
	NEXT
ELSE
	SELECTBLOB alm_attachment
	      INTO :ablb_attachment
	      FROM ctx_notification
	     WHERE ctx_id = :al_ctx_id AND alm_table = :as_table AND alm_column = :as_column ;
END IF
*/

end subroutine

public function integer of_get_mail_template (long al_email_id, ref blob ablb_message, ref str_email astr_email);long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp

long READ_ONE_LENGTH = 8000

SELECT Datalength(wf_email.Email_Message),subject,export_id,auto_sign,attach_name
  INTO :ll_DataLen, :astr_email.subject, :astr_email.export_id,:astr_email.autosign,:astr_email.attach_name
  FROM wf_email
 WHERE wf_email.email_id = :al_EMail_Id;

If sqlca.sqlcode <> 0 Then Return -1
If ll_DataLen <= 0 or isnull(ll_DataLen) Then Return 0

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(Email_Message,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM wf_email
		     WHERE wf_email.email_id = :al_EMail_Id;
		
		ablb_Message += lb_Temp
	next
else
	SELECTBLOB Email_Message
	      INTO :ablb_Message
	      FROM wf_email
	     WHERE wf_email.email_id = :al_EMail_Id;
end if

Return 1
end function

on n_cst_ctx_mail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ctx_mail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

