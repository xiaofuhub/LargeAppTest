$PBExportHeader$w_ctx_alarm.srw
forward
global type w_ctx_alarm from w_response
end type
type ole_message from u_email_edit within w_ctx_alarm
end type
type cb_field from commandbutton within w_ctx_alarm
end type
type cb_help from commandbutton within w_ctx_alarm
end type
type cb_default from commandbutton within w_ctx_alarm
end type
type cb_preview from commandbutton within w_ctx_alarm
end type
type cb_ok from u_cb within w_ctx_alarm
end type
type cb_cancel from u_cb within w_ctx_alarm
end type
type dw_alm_det from u_dw_contract within w_ctx_alarm
end type
type gb_1 from u_gb within w_ctx_alarm
end type
type st_1 from statictext within w_ctx_alarm
end type
type sle_subject from singlelineedit within w_ctx_alarm
end type
type gb_2 from u_gb within w_ctx_alarm
end type
type st_2 from statictext within w_ctx_alarm
end type
type dw_alm_msg from u_dw_contract within w_ctx_alarm
end type
end forward

global type w_ctx_alarm from w_response
integer width = 2926
integer height = 2616
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
ole_message ole_message
cb_field cb_field
cb_help cb_help
cb_default cb_default
cb_preview cb_preview
cb_ok cb_ok
cb_cancel cb_cancel
dw_alm_det dw_alm_det
gb_1 gb_1
st_1 st_1
sle_subject sle_subject
gb_2 gb_2
st_2 st_2
dw_alm_msg dw_alm_msg
end type
global w_ctx_alarm w_ctx_alarm

type variables
str_pass istr_pass 

//----Begin Added by Alfee on 06.11.2008 --------------
Long il_ctx_id, il_ai_id, il_doc_id, il_seq_id
long il_level_id1,il_level_id2
String is_table, is_column

Boolean ib_DW_Retrieve = FALSE //added by gavin 2011-12-28
Boolean ib_new_mode = FALSE 
Boolean ib_users_modified = FALSE
Boolean ib_attachment_modified = FALSE
Boolean ib_attachment_from_template = FALSE 
String is_attachment

n_cst_ctx_mail inv_mail 
DataWindowChild idwc_template 
//----End Added ---------------------------------------

CONSTANT STRING SEMICOLON = ";"				//Added by Scofield on 2009-02-23
Boolean ib_delete_attach = False				//Added by Scofield on 2009-02-23

//n_cst_contract inv_contract 08.23.2007 By Jervis

datastore ids_notification_templates
datastore ids_snooze_ctx //added by gavin  2011-12-28
datastore ids_snooze_template //added by gavin  2011-12-28


datastore ids_user_mail_map //Added By Ken.Guo 2010-03-02.
Boolean ib_reset = False //Added By Ken.Guo 09/27/2011. 

n_cst_string inv_string

end variables

forward prototypes
public function integer wf_retrieve ()
public function integer of_add_notification_users (string as_userlist)
public function integer of_update_attachment ()
public function integer of_parse_keyvalues ()
public function integer of_update_message ()
public function boolean of_is_messagechanged ()
public subroutine of_set_messagechanged (boolean ab_changed)
public function integer of_set_insertfield ()
public function string of_getfilename (string as_pathname)
public function integer of_set_as_default ()
public function integer of_get_from_default ()
public function integer of_update_snooze ()
public subroutine of_add_merge_field (string as_merge_field, string as_type)
public subroutine of_ini_data ()
public function integer of_reset_action_items ()
public function integer of_add_notification_users (str_alarm_user astr_alarm, string as_type)
public function integer of_get_default_message (long al_view_id, string as_alm_table, string as_alm_column, ref blob ablb_message)
end prototypes

public function integer wf_retrieve ();
//----------Begin Added by Alfee on 06.11.2008---------------
blob lblb_Message

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-10-17 By: Scofield
//$<Reason> Retrieve wf_id's dddw data
DataWindowChild	ldwc_Child
dw_alm_det.GetChild('wf_id',ldwc_Child)
ldwc_Child.SetTransObject(SQLCA)
//---------------------------- APPEON END ----------------------------

//Initilize email template //DataWindowChild idwc_template
dw_alm_msg.Getchild( "alm_email_template_id", idwc_template)
idwc_template.Settransobject( SQLCA )


ids_user_mail_map = Create Datastore
ids_user_mail_map.dataobject = 'd_user_email'
ids_user_mail_map.SetTransobject(SQLCA)

ids_snooze_ctx = Create DataStore
ids_snooze_ctx.Dataobject = 'd_ctx_alm_snooze'
ids_snooze_ctx.SetTransObject(SQLCA)

ids_snooze_template = Create DataStore
ids_snooze_template.Dataobject = 'd_ctx_alm_snooze_template'
ids_snooze_template.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
	ldwc_Child.Retrieve()
	idwc_template.Retrieve( )
	ids_user_mail_map.Retrieve()
	
	//add by gavin 2011-12-28
	ib_DW_Retrieve = False  
	Choose Case Upper(istr_pass.s_string_array[2])
		Case 'CTX_BASIC_INFO','CTX_CUSTOM'
			dw_alm_det.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3]) 
		Case 'CTX_ACTION_ITEM'
			dw_alm_det.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		
		Case 'CTX_AM_ACTION_ITEM'
			dw_alm_det.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		Case Else
			dw_alm_det.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3],0, long(istr_pass.s_string_array[6]),long(istr_pass.s_string_array[7]))	
	End Choose
gnv_appeondb.of_commitqueue( )	
If dw_alm_det.RowCount( ) = 0 Then ib_new_Mode = True	//add by gavin 2011-12-28

If ib_new_mode Then // modified by gavin 2011-12-28
	gnv_appeondb.of_startqueue( )
	ids_snooze_ctx.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2) 
	ids_snooze_template.Retrieve(gw_contract.il_data_view_id ,is_table,is_column)
	ids_notification_templates.Retrieve(gw_contract.il_data_view_id, is_table,is_column)
	//SelectBlob alm_message_blob Into :lblb_Message From ctx_notification_templates Where view_id = :gw_contract.il_data_view_id and alm_table = :is_table and alm_column = :is_column; //Commented By Ken.Guo 12/13/2012
	gnv_appeondb.of_commitqueue( )
	//---------Begin Modified by (Appeon)Toney 11.07.2013 for V141 ISG-CLX--------
	//$Reason:Fix BugT102501
	  /*
	  of_get_default_message(gw_contract.il_data_view_id, is_table, is_column, lblb_Message) //Modified By Ken.Guo 12/13/2012    
	  */
	 long ll_view_id
	 IF IsValid(gw_contract) THEN
		ll_view_id = gw_contract.il_data_view_id
	ELSE
		ll_view_id = integer(gnv_data.of_getitem('security_users','contract_default_view',"upper(user_id)='" + upper(gs_user_id) + "'"))
	END IF
	IF IsNull(ll_view_id) OR ll_view_id = 0 THEN
		ll_view_id = 1001
	END IF
	of_get_default_message(ll_view_id, is_table, is_column, lblb_Message) //Modified By Ken.Guo 12/13/2012
	//---------End Modfiied ------------------------------------------------------------------

End If


dw_alm_det.event pfc_retrieve( )//modified by gavin 2011-12-28
ib_DW_Retrieve = True  

ldwc_Child.InsertRow(1)
idwc_template.Insertrow( 1 )
idwc_template.SetItem( 1, "email_id", 0)
idwc_template.SetItem( 1, "email_name", "Blank Email")

//share data
dw_alm_det.ShareData(dw_alm_msg) //Alfee 02.22.2008

//Set Subject - jervis 12.02.2010
if dw_alm_msg.rowcount( ) > 0 then sle_subject.text = dw_alm_msg.GetItemString( 1,"alm_subject")

IF ib_new_mode And IsNull(dw_alm_msg.GetItemNumber(1, 'alm_email_template_id') ) THEN 
	dw_alm_msg.SetItem(1, 'alm_email_template_id', 0)
	dw_alm_msg.SetItemStatus(1, 0, Primary!, NotModified!)
END IF

//Set insert field button
of_set_insertfield()

SetRedraw(TRUE)
SetRedraw(FALSE)
//Get and display alert message
IF ib_new_mode THEN
	
	If Len(lblb_Message) > 0 Then
		ole_Message.of_Open(lblb_Message)
	Else
		ole_Message.of_Open( )	
		of_ini_data() //Added By Ken 09/15/2011. 
	End If
	This.of_set_messagechanged(True) //Added By Ken.Guo 2010-08-13.
ELSE
	CHOOSE CASE Upper(is_table)
		CASE 'CTX_BASIC_INFO','CTX_CUSTOM' //add ctx_custom - jervis 05.19.2011
			inv_mail.of_get_alertmsg(il_ctx_id, is_table, is_column, -1, lblb_Message )
		CASE 'CTX_ACTION_ITEM'
			inv_mail.of_get_alertmsg_ai(il_ctx_id, il_ai_id, is_table, is_column, -1, lblb_Message )
		CASE 'CTX_AM_ACTION_ITEM'
			inv_mail.of_get_alertmsg_amai(il_doc_id, il_seq_id, is_table, is_column, -1, lblb_Message )
		//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'  //add by jervis -- 06.30.201
		case else //add fee scheduce - jervis 08.02.2011
			inv_mail.of_get_alertmsg_all(il_ctx_id,il_doc_id, il_level_id1,il_level_id2, is_table, is_column, -1, lblb_Message )
	END CHOOSE
	//---------Begin Modified by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
	//ole_message.of_open(lblb_Message)	
	If isnull(lblb_Message) or len(lblb_Message) = 0 Then
		//Added By Ken.Guo 02/17/2014
		Messagebox('Error','Failed to get the email message content or email message content is empty. please quit IntelliCred and then try agian or reset the message content.')
	Else
		ole_message.of_open(lblb_Message)		
	End If
	//---------End Modfiied ------------------------------------------------------
END IF
SetRedraw(TRUE)
//----------End Added -----------------------------------------


return 0
end function

public function integer of_add_notification_users (string as_userlist);//Add notification users  - Alfee 06.11.2008

Long i, j
String ls_current_users[], ls_new_users[], ls_new_userlist, ls_mailto
n_cst_string lnv_string

IF Len(Trim(as_userlist)) < 1 THEN RETURN 0
IF dw_alm_msg.rowcount() < 1 THEN RETURN 0

dw_alm_msg.AcceptText() //alfee 12.10.2008
ls_mailto = dw_alm_msg.getitemstring(1, 'alm_mailto')
IF IsNull(ls_mailto) OR Len(Trim(ls_mailto)) < 1 THEN
	dw_alm_msg.SetItem(1, 'alm_mailto', as_userlist)
ELSE
	lnv_string.of_parsetoarray(Trim(ls_mailto), ';', ls_current_users)
	lnv_string.of_parsetoarray(Trim(as_userlist), ';', ls_new_users)
	FOR i = 1 to UpperBound(ls_new_users) 
		FOR j = 1 to UpperBound(ls_current_users)
			IF Upper(Trim(ls_new_users[i])) = Upper(Trim(ls_current_users[j])) THEN EXIT	
		NEXT
		//Skip the duplicated user
		IF j <= UpperBound(ls_current_users) THEN CONTINUE
		//Keep the user in new user list
		IF Len(ls_new_userlist) < 1 THEN
			ls_new_userlist = ls_new_users[i]
		ELSE
			ls_new_userlist += '; ' + ls_new_users[i]
		END IF
	NEXT
	//Add them to current user list	
	IF Len(ls_new_userlist) > 0 THEN 
		IF	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + '; '
		ls_mailto = ls_mailto + ls_new_userlist
		dw_alm_msg.SetItem(1, 'alm_mailto', ls_mailto)
	END IF
END IF	

RETURN 1
end function

public function integer of_update_attachment ();//Update attachment - Alfee 06.11.2008
String	ls_PathName,ls_FileName,ls_AttachName[],ls_attach_name
long		ll_email_id,ll_Pos,ll_AttachCycle,ll_AttachCnts,ll_AttachID

Blob 		lblb_attachment[]

n_cst_filesrv lnv_filesrv

//Return if attachment not modified
IF NOT ib_attachment_modified THEN RETURN 0

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-02-23 By: Scofield
//$<Reason> Save multi-attachment files to database.

lnv_filesrv = Create n_cst_filesrv

//Get attachment into blob
IF ib_attachment_from_template THEN
	//If attachment from an email template
	ll_email_id = 	dw_alm_msg.GetItemNumber(1, 'alm_email_template_id')
	ls_attach_name = dw_alm_msg.GetItemString(1, 'alm_attachment_name')
	IF IsNull(ll_email_id) THEN ll_email_id = 0
	IF IsNull(ls_attach_name) THEN ls_attach_name = ''
	IF ll_email_id > 0 and Len(Trim(ls_attach_name)) > 0 THEN
		inv_mail.of_get_mail_template_attachment(ll_email_id, ls_AttachName,lblb_attachment)	
	END IF
END IF

if Not (IsNull(is_Attachment) or Trim(is_Attachment) = "") then
	//If attachment from a local file
	if Right(is_Attachment,1) <> SEMICOLON then is_Attachment += SEMICOLON
	
	ll_Pos = Pos(is_Attachment,SEMICOLON)
	do while ll_Pos > 0
		ls_PathName = Trim(Left(is_Attachment,ll_Pos - 1))
		ls_FileName = of_GetFileName(ls_PathName)
		if FileExists(ls_PathName) and ls_FileName <> "" then
			ls_AttachName[UpperBound(ls_AttachName) + 1] = ls_FileName
			lnv_FileSrv.of_FileRead(ls_PathName,lblb_attachment[UpperBound(lblb_attachment) + 1])
		end if
		is_Attachment = Trim(Mid(is_Attachment,ll_Pos + 1))
		ll_Pos = Pos(is_Attachment,SEMICOLON)
	loop
	/*
	IF Len(is_attachment) > 0 AND FileExists(is_attachment) THEN
		IF NOT (lnv_FileSrv.of_FileRead(is_attachment, lblb_attachment) > 0 ) THEN
			SetNull(lblb_attachment)
		END IF
	END IF
	*/
end if

ll_AttachCnts = UpperBound(lblb_attachment)

if ll_AttachCnts <= 0 or ib_delete_attach then
	Choose Case Upper(is_table)
		Case 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
			DELETE FROM ctx_alarm_attachment
			      WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column;
		Case 'CTX_ACTION_ITEM'
			DELETE FROM ctx_ai_alarm_attachment
			      WHERE ctx_id = :il_ctx_id AND item_id = :il_ai_id AND alm_table = :is_table AND alm_column = :is_column;
		Case 'CTX_AM_ACTION_ITEM'
			DELETE FROM ctx_am_ai_alarm_attachment
					WHERE doc_id = :il_doc_id AND seq_id = :il_seq_id AND alm_table = :is_table AND alm_column = :is_column;
		//Case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
		case else //add fee scheduce - jervis 08.02.2011
			DELETE FROM ctx_ALL_alarm_attachment
					WHERE ctx_id = :il_ctx_id and doc_id = :il_doc_id AND level_id1 = :il_level_id1 and level_id2 = :il_level_id2 AND alm_table = :is_table AND alm_column = :is_column;
	end choose
end if

//Update attachment
IF ll_AttachCnts > 0 THEN
	CHOOSE CASE Upper(is_table)
		
		CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_alarm_attachment 
				 WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_alarm_attachment(ctx_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:il_ctx_id,:is_table,:is_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_notification Set alm_attachment = :lblb_attachment 
			 	  Where ctx_id = :il_ctx_id And alm_table = :is_table And alm_column = :is_column;
			*/
		CASE 'CTX_ACTION_ITEM'
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_ai_alarm_attachment 
				 WHERE ctx_id = :il_ctx_id AND item_id = :il_ai_id AND alm_table = :is_table AND alm_column = :is_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_ai_alarm_attachment(ctx_id,item_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:il_ctx_id,:il_ai_id,:is_table,:is_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_ai_alarm_attachment
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :il_ctx_id AND item_id = :il_ai_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_ai_notification Set alm_attachment = :lblb_attachment
		 	 	 Where ctx_id = :il_ctx_id And ctx_action_item_id = :il_ai_id And alm_table = :is_table And alm_column = :is_column;	
			*/		
		CASE 'CTX_AM_ACTION_ITEM'
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id)
				  INTO :ll_AttachID
				  FROM ctx_am_ai_alarm_attachment
				 WHERE doc_id = :il_doc_id AND seq_id = :il_seq_id AND alm_table = :is_table AND alm_column = :is_column;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_am_ai_alarm_attachment(doc_id,seq_id,alm_table,alm_column,attach_id,alm_attachment_name)
					  VALUES (:il_doc_id,:il_seq_id,:is_table,:is_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle]);
					  
				UPDATEBLOB ctx_am_ai_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE doc_id = :il_doc_id AND seq_id = :il_seq_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_AttachID;	
			next
			/*
			UpdateBlob ctx_am_ai_notification Set alm_attachment = :lblb_attachment 
			 	  Where doc_id = :il_doc_id And seq_id = :il_seq_id And alm_table = :is_table And alm_column = :is_column;
			*/
		case else //add fee scheduce - jervis 08.02.2011
		//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
			for ll_AttachCycle = 1 to ll_AttachCnts
				SELECT Max(attach_id) 
				  INTO :ll_AttachID 
				  FROM ctx_all_alarm_attachment 
				 WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column and 
				 		 doc_id = :il_doc_id AND level_id1 = :il_level_id1 and level_id2 = :il_level_id2;
				 
				if IsNull(ll_AttachID) then ll_AttachID = 0
				ll_AttachID++
				
				INSERT INTO ctx_all_alarm_attachment(ctx_id,alm_table,alm_column,attach_id,alm_attachment_name,doc_id,level_id1,level_id2)
					  VALUES (:il_ctx_id,:is_table,:is_column,:ll_AttachID,:ls_AttachName[ll_AttachCycle],:il_doc_id,:il_level_id1,:il_level_id2);
					  
				UPDATEBLOB ctx_all_alarm_attachment 
				       SET alm_attachment = :lblb_attachment[ll_AttachCycle]
					  WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_AttachID and 
					  			doc_id = :il_doc_id AND level_id1 = :il_level_id1 and level_id2 = :il_level_id2;	 
			next
	END CHOOSE
/*ELSE
	CHOOSE CASE Upper(is_table)
		CASE 'CTX_BASIC_INFO'
			DELETE FROM ctx_alarm_attachment
			      WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column;
			/*
			Update ctx_notification Set alm_attachment = Null, alm_attachment_name = Null  
	 	    Where ctx_id = :il_ctx_id And alm_table = :is_table And alm_column = :is_column;
			*/
		CASE 'CTX_ACTION_ITEM'
			DELETE FROM ctx_ai_alarm_attachment
			      WHERE ctx_id = :il_ctx_id AND item_id = :il_ai_id AND alm_table = :is_table AND alm_column = :is_column;
			/*
			Update ctx_ai_notification Set alm_attachment = Null, alm_attachment_name = Null  
		 	 	 Where ctx_id = :il_ctx_id And ctx_action_item_id = :il_ai_id And alm_table = :is_table And alm_column = :is_column;	
			*/
		CASE 'CTX_AM_ACTION_ITEM'
			DELETE FROM ctx_am_ai_alarm_attachment
					WHERE doc_id = :il_doc_id AND seq_id = :il_seq_id AND alm_table = :is_table AND alm_column = :is_column;
			/*
			Update ctx_am_ai_notification Set alm_attachment = Null, alm_attachment_name = Null   
			 	  Where doc_id = :il_doc_id And seq_id = :il_seq_id And alm_table = :is_table And alm_column = :is_column;
			*/
	END CHOOSE*/
END IF

Destroy lnv_filesrv

//---------------------------- APPEON END ----------------------------

//Execute update SQL statement
IF SQLCA.SQLCode = -1 THEN
	MessageBox("Save Attachment","Update attachment failed due to: " + SQLCA.SQLErrText)
	RETURN -1		
END IF

ib_attachment_modified = FALSE

RETURN 1

end function

public function integer of_parse_keyvalues ();//Assign key values - Alfee 06.11.2008

is_table = istr_pass.s_string_array[2]
is_column = istr_pass.s_string_array[3]

CHOOSE CASE Upper(istr_pass.s_string_array[2])
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		il_ctx_id = long(istr_pass.s_string_array[1])
	CASE 'CTX_ACTION_ITEM'
		il_ctx_id = long(istr_pass.s_string_array[1])
		il_ai_id = long(istr_pass.s_string_array[5])
	CASE 'CTX_AM_ACTION_ITEM'
		il_doc_id = long(istr_pass.s_string_array[1])
		il_seq_id = long(istr_pass.s_string_array[5])
		il_level_id1 = il_seq_id //Added By Ken.Guo 12/27/2012
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' //add custom multi data  - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		il_ctx_id = long(istr_pass.s_string_array[1])
		il_doc_id = 0
		il_level_id1 =  long(istr_pass.s_string_array[6])
		il_level_id2 = long(istr_pass.s_string_array[7])
END CHOOSE

RETURN 1
end function

public function integer of_update_message ();//Update attachment - Alfee 06.11.2008
String ls_sql
Blob lblb_message

//Return if no document opened or not modified
IF ole_message.object.doctype <> 1 THEN RETURN 0
IF NOT of_is_messagechanged() THEN RETURN 0

//Save message to blob
ole_Message.of_GetBlob(lblb_message)

//---------Begin Added by (Appeon)Harry 03.19.2014 for V142 ISG-CLX--------
//Added By Ken.Guo 02/14/2014
If isnull(lblb_message) or Len(lblb_message) = 0 Then
	MessageBox("Save Message", "Failed to get the message content. Please quit IntelliCred then try again.")
	Return -2
End If
//---------End Added ------------------------------------------------------

//Update message
CHOOSE CASE Upper(is_table)
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		UpdateBlob ctx_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :il_ctx_id And alm_table = :is_table And alm_column = :is_column;		
	CASE 'CTX_ACTION_ITEM'
		UpdateBlob ctx_ai_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :il_ctx_id And ctx_action_item_id = :il_ai_id And alm_table = :is_table And alm_column = :is_column;	
	CASE 'CTX_AM_ACTION_ITEM'
		UpdateBlob ctx_am_ai_notification Set alm_message_blob = :lblb_message 
		 	  Where doc_id = :il_doc_id And seq_id = :il_seq_id And alm_table = :is_table And alm_column = :is_column;
	//Case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' // ADD CUTOM MULTI DATA - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		UpdateBlob ctx_all_notification Set alm_message_blob = :lblb_message 
		 	  Where ctx_id = :il_ctx_id And alm_table = :is_table And alm_column = :is_column and 
						doc_id = :il_doc_id and level_id1 = :il_level_id1 and level_id2 = :il_level_id2;	
END CHOOSE

IF SQLCA.SQLCode = -1 THEN
	MessageBox("Save Message", "Update message failed due to: " + SQLCA.SQLErrText)
	RETURN -1
END IF

of_set_messagechanged(FALSE)

RETURN 1

end function

public function boolean of_is_messagechanged ();//Alfee 06.11.2008
IF ole_message.object.doctype <> 1 THEN RETURN FALSE

RETURN (not ole_message.object.activedocument.saved)
end function

public subroutine of_set_messagechanged (boolean ab_changed);//Alfee 06.11.2008
IF ole_message.object.doctype <> 1 THEN RETURN 

ole_message.object.activedocument.saved = (Not ab_changed)
end subroutine

public function integer of_set_insertfield ();//Alfee 06.11.2008
Long ll_email_id, ll_export_id, ll_found 

IF dw_alm_msg.RowCount( ) < 1 THEN RETURN 0

ll_email_id = dw_alm_msg.GetItemNumber(1,'alm_email_template_id')
IF IsNull(ll_email_id) OR ll_email_id = 0 THEN
	cb_field.Enabled = FALSE
	RETURN 1	
END IF

ll_found = idwc_template.Find('email_id = ' + String(ll_email_id), 1, idwc_template.RowCount())
IF ll_found > 0 THEN ll_export_id = idwc_template.GetItemNumber(ll_found,'export_id')
IF IsNull(ll_export_id ) or ll_export_id < 1 THEN
	cb_field.Enabled = FALSE
ELSE
	cb_field.Enabled = TRUE
END IF

RETURN 1

	

end function

public function string of_getfilename (string as_pathname);long	ll_Pos,ll_LastPos

as_PathName = Trim(as_PathName)

ll_Pos = Pos(as_PathName,"\")
do while ll_Pos > 0
	ll_LastPos = ll_Pos
	ll_Pos = Pos(as_PathName,"\",ll_Pos + 1)
loop

Return Trim(Mid(as_PathName,ll_LastPos + 1))

end function

public function integer of_set_as_default ();Boolean lb_new,lb_set_snooze = False
Long ll_Pos,ll_AttachCnts,i,ll_id,ll_find,ll_attach_id
String ls_PathName,ls_FileName,ls_AttachName[]
Blob lblb_attachment[]
n_cst_filesrv lnv_filesrv
String ls_Attachment
n_cst_ctx_mail lnv_mail 
Long ll_email_id
String ls_attach_name
String ls_attach_name_arr[]
Long ll_attach_id_arr[] 

If Not isvalid(gw_contract) Then Return -1

lnv_filesrv = Create n_cst_filesrv

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	Timer(0,w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Saving as Default Date Alarm...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)	
End If

SetPointer(HourGlass!)
dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()

DataStore lds_snooze_ctx
lds_snooze_ctx = Create DataStore
lds_snooze_ctx.Dataobject = 'd_ctx_alm_snooze'
lds_snooze_ctx.SetTransObject(SQLCA)

DataStore lds_snooze_template
lds_snooze_template = Create DataStore
lds_snooze_template.Dataobject = 'd_ctx_alm_snooze_template'
lds_snooze_template.SetTransObject(SQLCA)


gnv_appeondb.of_startqueue( )
	lds_snooze_ctx.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2) //add by jervis - 06.30.2011
	lds_snooze_template.Retrieve(gw_contract.il_data_view_id ,is_table,is_column)
	ids_notification_templates.Retrieve(gw_contract.il_data_view_id, is_table,is_column)
gnv_appeondb.of_commitqueue( )

ll_find = ids_notification_templates.Find('view_id = '+String(gw_contract.il_data_view_id) +' and alm_table = "' +String(is_table) +'" and alm_column = "'+String(is_column)+'"',1,ids_notification_templates.rowcount())
If ll_find <= 0 Then
	ll_find = ids_notification_templates.InsertRow(0)
	lb_new = True
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(30)

//Set Default Value
ids_notification_templates.SetItem(ll_find,'view_id',gw_contract.il_data_view_id)
ids_notification_templates.SetItem(ll_find,'alm_table',is_table)
ids_notification_templates.SetItem(ll_find,'alm_column',is_column)
ids_notification_templates.SetItem(ll_find,'alm_enabled',dw_alm_det.getItemString(1,'alm_enabled'))
ids_notification_templates.SetItem(ll_find,'alm_notification_days',dw_alm_det.getItemNumber(1,'alm_notification_days'))
ids_notification_templates.SetItem(ll_find,'alm_frequency',dw_alm_det.getItemNumber(1,'alm_frequency'))
ids_notification_templates.SetItem(ll_find,'alm_total_tries',dw_alm_det.getItemNumber(1,'alm_total_tries'))
ids_notification_templates.SetItem(ll_find,'alm_auto_increment_years',dw_alm_det.getItemNumber(1,'alm_auto_increment_years'))
ids_notification_templates.SetItem(ll_find,'alm_auto_increment_unit',dw_alm_det.getItemString(1,'alm_auto_increment_unit'))
ids_notification_templates.SetItem(ll_find,'create_action_item',dw_alm_det.getItemString(1,'create_action_item'))
ids_notification_templates.SetItem(ll_find,'alm_action_title',dw_alm_det.getItemString(1,'alm_action_title'))
ids_notification_templates.SetItem(ll_find,'wf_id',dw_alm_det.getItemNumber(1,'wf_id'))
ids_notification_templates.SetItem(ll_find,'alm_email_template_id',dw_alm_msg.getItemNumber(1,'alm_email_template_id'))
ids_notification_templates.SetItem(ll_find,'auto_sign',dw_alm_msg.getItemString(1,'auto_sign'))
ids_notification_templates.SetItem(ll_find,'alm_attachment_name',dw_alm_msg.getItemString(1,'alm_attachment_name'))
ids_notification_templates.SetItem(ll_find,'alm_mailto',dw_alm_msg.getItemString(1,'alm_mailto'))
ids_notification_templates.SetItem(ll_find,'alm_subject',dw_alm_msg.getItemString(1,'alm_subject'))
ids_notification_templates.SetItem(ll_find,'alm_create',dw_alm_msg.getItemString(1,'alm_create'))

//Save Snooze Advance Settings
For i = 1 To lds_snooze_template.RowCount()
	lds_snooze_template.DeleteRow(i)
Next
For i = 1 To lds_snooze_ctx.RowCount()
	lds_snooze_template.InsertRow(0)
	lds_snooze_template.SetItem(i,'ctx_id',0)
	//add level id - jervis 06.30.2011
	lds_snooze_template.SetItem(i,'doc_id',0)
	lds_snooze_template.SetItem(i,'level_id1',0)
	lds_snooze_template.SetItem(i,'level_id2',0)
	
	lds_snooze_template.SetItem(i,'view_id',gw_contract.il_data_view_id)
	lds_snooze_template.SetItem(i,'alm_table',is_table)
	lds_snooze_template.SetItem(i,'alm_column',is_column)
	If lds_snooze_ctx.GetItemNumber(i,'asnooze_executed') = 0 and lb_set_snooze = False and dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') > 0 Then
		lds_snooze_template.SetItem(i,'increment_value',dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') )
		lds_snooze_template.SetItem(i,'increment_unit',dw_alm_det.GetItemString(1,'alm_auto_increment_unit'))				
		lb_set_snooze = true
	Else
		lds_snooze_template.SetItem(i,'increment_value',lds_snooze_ctx.GetItemNumber(i,'increment_value') )
		lds_snooze_template.SetItem(i,'increment_unit',lds_snooze_ctx.GetItemString(i,'increment_unit'))		
	End If
	
	lds_snooze_template.SetItem(i,'asnooze_executed',0)	
	lds_snooze_template.SetItem(i,'snooze_loop',lds_snooze_ctx.GetItemNumber(i,'snooze_loop'))
Next
If lds_snooze_ctx.RowCount() > 0 and ids_notification_templates.GetItemNumber(ll_find,'alm_auto_increment_years') > 0 Then
	ids_notification_templates.SetItem(ll_find,'alm_auto_increment_years',lds_snooze_template.GetItemNumber(1,'increment_value'))
	ids_notification_templates.SetItem(ll_find,'alm_auto_increment_unit',lds_snooze_template.GetItemString(1,'increment_unit'))	
End If


If ids_notification_templates.update() = 1 Then
	//Attachment from an email template
	IF ib_attachment_from_template THEN
		ll_email_id = 	dw_alm_msg.GetItemNumber(1, 'alm_email_template_id')
		ls_attach_name = dw_alm_msg.GetItemString(1, 'alm_attachment_name')
		IF IsNull(ll_email_id) THEN ll_email_id = 0
		IF IsNull(ls_attach_name) THEN ls_attach_name = ''
		IF ll_email_id > 0 and Len(Trim(ls_attach_name)) > 0 THEN
			lnv_mail.of_get_mail_template_attachment(ll_email_id, ls_AttachName[],lblb_attachment[])	
		END IF
	END IF
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(40)
	
	//Save attachment from a local file
	ls_Attachment = is_Attachment
	if Not (IsNull(ls_Attachment) or Trim(ls_Attachment) = "") then
		if Right(ls_Attachment,1) <> SEMICOLON then ls_Attachment += SEMICOLON
		ll_Pos = Pos(ls_Attachment,SEMICOLON)
		do while ll_Pos > 0
			ls_PathName = Trim(Left(ls_Attachment,ll_Pos - 1))
			ls_FileName = of_GetFileName(ls_PathName)
			if FileExists(ls_PathName) and ls_FileName <> "" then
				ls_AttachName[UpperBound(ls_AttachName) + 1] = ls_FileName
				lnv_FileSrv.of_FileRead(ls_PathName,lblb_attachment[UpperBound(lblb_attachment[]) + 1])
			end if
			ls_Attachment = Trim(Mid(ls_Attachment,ll_Pos + 1))
			ll_Pos = Pos(ls_Attachment,SEMICOLON)
		loop
	end if
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(50)
	
	lds_snooze_template.update()
	
	//Acctach 
	ll_AttachCnts = UpperBound(lblb_attachment[])	
	gnv_appeondb.of_startqueue( )
	Delete From ctx_notification_templates_attachments Where view_id = :gw_contract.il_data_view_id and alm_table = :is_table and alm_column = :is_column;
	Select Max(id) Into :ll_id From ctx_notification_templates_attachments;
	gnv_appeondb.of_commitqueue( )
	If isnull(ll_id) Then ll_id = 0 
	For i = 1 To ll_AttachCnts
		ll_id++
		Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name)
			Values(:ll_id,:gw_contract.il_data_view_id, :is_table,:is_column,:ls_AttachName[i]);
		UpdateBlob ctx_notification_templates_attachments Set alm_attachment = :lblb_attachment[i] Where id = :ll_id;
	Next
	commit;
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(60)
	//Attach original saved file.
	
	If Not ib_delete_attach and Not ib_new_mode Then
		Choose Case Upper(is_table)
						
			Case 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
				DECLARE cur_attachment CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_alarm_attachment 
						WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column;
				OPEN  cur_attachment;
				FETCH cur_attachment INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:gw_contract.il_data_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_alarm_attachment Where ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next

			Case 'CTX_ACTION_ITEM'
				
				DECLARE cur_attachment_ai CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_ai_alarm_attachment 
						WHERE ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND item_id = :il_ai_id;
				OPEN  cur_attachment_ai;
				FETCH cur_attachment_ai INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment_ai INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment_ai;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:gw_contract.il_data_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_ai_alarm_attachment Where ctx_id = :il_ctx_id AND alm_table = :is_table AND alm_column = :is_column AND item_id = :il_ai_id AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next				
				
				
			Case 'CTX_AM_ACTION_ITEM'	
				DECLARE cur_attachment_am_ai CURSOR FOR  
					SELECT attach_id,alm_attachment_name
						FROM ctx_am_ai_alarm_attachment 
						WHERE alm_table = :is_table AND alm_column = :is_column AND doc_id = :il_doc_id AND seq_id = :il_seq_id;
				OPEN  cur_attachment_am_ai;
				FETCH cur_attachment_am_ai INTO :ll_attach_id,:ls_attach_name;
				DO WHILE SQLCA.sqlcode = 0
					ll_attach_id_arr[UpperBound(ll_attach_id_arr[]) + 1 ] = ll_attach_id
					ls_attach_name_arr[UpperBound(ls_attach_name_arr[]) + 1 ] = ls_attach_name
					FETCH cur_attachment_am_ai INTO :ll_attach_id,:ls_attach_name;
				LOOP
				CLOSE cur_attachment_am_ai;
				
				For i = 1 to Upperbound(ll_attach_id_arr[])
					ll_id++
					Insert Into ctx_notification_templates_attachments(id,view_id,alm_table,alm_column,alm_attachment_name) 
						Values(:ll_id,:gw_contract.il_data_view_id, :is_table,:is_column,:ls_attach_name_arr[i]);
					Update ctx_notification_templates_attachments 
						Set alm_attachment = (Select alm_attachment From ctx_am_ai_alarm_attachment Where alm_table = :is_table AND alm_column = :is_column AND doc_id = :il_doc_id AND seq_id = :il_seq_id AND attach_id = :ll_attach_id_arr[i] )
						Where id = :ll_id ;			
				Next			
			case else //add fee scheduce - jervis 08.02.2011
			//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'  //ADD cumtom mulit alarm - jervis 06.30.2011
				
		End Choose
	End If
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(80)

	//Save Message Body.
	Blob lblb_message
	IF ole_message.object.doctype <> 1 THEN 
		If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
		RETURN 0
	End If
	ole_Message.of_GetBlob(lblb_message)
	gnv_appeondb.of_startqueue( )
	UpdateBlob ctx_notification_templates Set alm_message_blob = :lblb_message Where view_id = :gw_contract.il_data_view_id and alm_table = :is_table and alm_column = :is_column;
	Commit;
	gnv_appeondb.of_commitqueue( )
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(100)
Else
	Rollback;
	Messagebox('Error','Failed to save it, please call support.')
End If

If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
SetPointer(Arrow!)

Messagebox('Contract Alarm ','Default alarm was set successfully.')

Return 1


end function

public function integer of_get_from_default ();long ll_find
n_cst_ctx_mail lnv_ctx_mail
String ls_AttachName[]
Blob lblb_attachment[]
Long ll_AttachCnts,ll_AttachCycle
String ls_color_disabled


If	ib_DW_Retrieve Then //modify by gavin 2011-12-28
	gnv_appeondb.of_startqueue( )
	ids_snooze_ctx.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2) 
	ids_snooze_template.Retrieve(gw_contract.il_data_view_id ,is_table,is_column)
	ids_notification_templates.Retrieve(gw_contract.il_data_view_id, is_table,is_column)
	gnv_appeondb.of_commitqueue( )
End If

ll_find = ids_notification_templates.Find('view_id = '+String(gw_contract.il_data_view_id) +' and alm_table = "' +String(is_table) +'" and alm_column = "'+String(is_column)+'"',1,ids_notification_templates.rowcount())
If ll_find <= 0 Then Return 1

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	Timer(0,w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Getting Default Date Alarm...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(20)	
End If

SetPointer(HourGlass!)

//Set Default Value
dw_alm_det.SetItem(1,'alm_table',ids_notification_templates.getItemString(ll_find,'alm_table'))
dw_alm_det.SetItem(1,'alm_column',ids_notification_templates.getItemString(ll_find,'alm_column'))
dw_alm_det.SetItem(1,'alm_enabled',ids_notification_templates.getItemString(ll_find,'alm_enabled'))
dw_alm_det.SetItem(1,'alm_notification_days',ids_notification_templates.getItemNumber(ll_find,'alm_notification_days'))
dw_alm_det.SetItem(1,'alm_frequency',ids_notification_templates.getItemNumber(ll_find,'alm_frequency'))
dw_alm_det.SetItem(1,'alm_total_tries',ids_notification_templates.getItemNumber(ll_find,'alm_total_tries'))
dw_alm_det.SetItem(1,'alm_auto_increment_years',ids_notification_templates.getItemNumber(ll_find,'alm_auto_increment_years'))
dw_alm_det.SetItem(1,'alm_auto_increment_unit',ids_notification_templates.getItemString(ll_find,'alm_auto_increment_unit'))
dw_alm_det.SetItem(1,'create_action_item',ids_notification_templates.getItemString(ll_find,'create_action_item'))
dw_alm_det.SetItem(1,'alm_action_title',ids_notification_templates.getItemString(ll_find,'alm_action_title'))
dw_alm_det.SetItem(1,'wf_id',ids_notification_templates.getItemNumber(ll_find,'wf_id'))

dw_alm_det.SetItem(1,'alm_email_template_id',ids_notification_templates.getItemNumber(ll_find,'alm_email_template_id'))
dw_alm_det.SetItem(1,'auto_sign',ids_notification_templates.getItemString(ll_find,'auto_sign'))
dw_alm_det.SetItem(1,'alm_attachment_name',ids_notification_templates.getItemString(ll_find,'alm_attachment_name'))
dw_alm_det.SetItem(1,'alm_mailto',ids_notification_templates.getItemString(ll_find,'alm_mailto'))
dw_alm_det.SetItem(1,'alm_subject',ids_notification_templates.getItemString(ll_find,'alm_subject'))
dw_alm_det.SetItem(1,'alm_create',ids_notification_templates.getItemString(ll_find,'alm_create'))

If ids_notification_templates.getItemString(ll_find,'create_action_item') = 'N' Then
	ls_color_disabled = dw_alm_det.Describe("alm_last_notification_sent.Background.Color")
	dw_alm_det.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )		
End If


//Get Snooze Advance Settings
Long i

ids_snooze_ctx.RowsMove( 1, ids_snooze_ctx.RowCount( ), Primary!, ids_snooze_ctx, 1, Delete! )//modify by gavin 2011-12-28

For i = 1 To ids_snooze_template.RowCount()
	ids_snooze_ctx.InsertRow(0)
	ids_snooze_ctx.SetItem(i,'ctx_id',il_ctx_id)
	ids_snooze_ctx.SetItem(i,'doc_id',il_doc_id)
	ids_snooze_ctx.SetItem(i,'level_id1',il_level_id1)
	ids_snooze_ctx.SetItem(i,'level_id2',il_level_id2)
	ids_snooze_ctx.SetItem(i,'alm_table',is_table)
	ids_snooze_ctx.SetItem(i,'alm_column',is_column)
	ids_snooze_ctx.SetItem(i,'increment_value',ids_snooze_template.GetItemNumber(i,'increment_value') )
	ids_snooze_ctx.SetItem(i,'increment_unit',ids_snooze_template.GetItemString(i,'increment_unit'))
	ids_snooze_ctx.SetItem(i,'asnooze_executed',0)	
	ids_snooze_ctx.SetItem(i,'snooze_loop',ids_snooze_template.GetItemNumber(i,'snooze_loop'))
Next
ids_snooze_ctx.update()

ib_attachment_from_template = False

////Get message into blob
lnv_ctx_mail.of_get_almattach_template(gw_contract.il_data_view_id, is_table,is_column,ls_AttachName[],lblb_attachment[])

ll_AttachCnts = UpperBound(lblb_attachment)
if ll_AttachCnts > 0 then
	for ll_AttachCycle = 1 to ll_AttachCnts
		If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(1)
		if Len(lblb_attachment[ll_AttachCycle]) > 0 then
			is_attachment += lnv_ctx_mail.of_write_attachfile(lblb_attachment[ll_AttachCycle],ls_AttachName[ll_AttachCycle]) + SEMICOLON
		end if
	next
	//is_attachment = Left(is_attachment,len(is_attachment) - 1) //Commented By Ken.Guo 12/06/2012. fixed bug
	ib_attachment_modified = True
end if
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_SetPosition(100)
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)	
Return 1
end function

public function integer of_update_snooze ();//////////////////////////////////////////////////////////////////////
// $<function>w_ctx_alarm::of_update_snooze()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Update Advance Snooze Settings.
//////////////////////////////////////////////////////////////////////
// $<add> 2009-09-16 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long i
DataStore lds_snooze
lds_snooze = Create DataStore
lds_snooze.Dataobject = 'd_ctx_alm_snooze'
lds_snooze.SetTransObject(SQLCA)
lds_snooze.Retrieve(il_ctx_id,is_table,is_column,il_doc_id,il_level_id1,il_level_id2)   //add level id - jervis 06.30.2011


If dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') = 0 Then
	//If no snooze
	Return 1
Else
	//Update
	For i = 1 to lds_snooze.RowCount()
			If lds_snooze.GetItemNumber(i,'asnooze_executed') = 0 Then
				If lds_snooze.GetitemNumber(i,'increment_value') <> dw_alm_det.GetItemNumber(1,'alm_auto_increment_years') Then 
					lds_snooze.SetItem(i,'increment_value',dw_alm_det.GetItemNumber(1,'alm_auto_increment_years'))
				End If
				If lds_snooze.GetItemString(i,'increment_unit') <> dw_alm_det.GetItemString(1,'alm_auto_increment_unit') Then
					lds_snooze.SetItem(i,'increment_unit',dw_alm_det.GetItemString(1,'alm_auto_increment_unit'))
				End If
				Exit
			End If
	Next
	If lds_snooze.modifiedcount( ) > 0 Then
		lds_snooze.update()
	End If
End If

Return 1


end function

public subroutine of_add_merge_field (string as_merge_field, string as_type);//Alfee 06.11.2008

If not len(as_merge_field) > 0 Then return

IF ole_message.Object.Doctype <> 1 THEN RETURN

//Commented By Ken.Guo 2010-12-06
//ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_merge_field + ">$")


//Jervis 03.30.2010
//Add as_type - Insert Subject/Body

If not len(as_merge_field) > 0 Then return

if as_type = 'body' then
	//--------Begin Modified by Alfee 11.23.2007---------
	//<$Reason>Replaced the email edit control with Word OCX
	IF ole_message.Object.Doctype <> 1 THEN RETURN
	
	ole_message.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_merge_field + ">$")
	//dw_email.replacetext("$<"+as_merge_field+">$")
	//--------End Modified --------------------------------
else
	//Begin - Modified By Ken.Guo 2010-12-06
	//sle_subject.replacetext( "$<"+as_merge_field+">$")
	//dw_alm_msg.SetItem(dw_alm_msg.GetRow(),'alm_subject',sle_subject.text)
	dw_alm_msg.SetFocus()
	If dw_alm_msg.GetColumnName() <> 'alm_subject' Then
		dw_alm_msg.SetColumn('alm_subject')
	End If
	dw_alm_msg.replacetext( "$<"+as_merge_field+">$")
	//End - Modified By Ken.Guo 2010-12-06	
end if
end subroutine

public subroutine of_ini_data ();String ls_owner, ls_owner_email
SELECT ctx_contacts.user_d,security_users.email_id  into :ls_owner, :ls_owner_email FROM ctx_contract_contacts,ctx_contacts,app_facility,security_users
WHERE (ctx_contract_contacts.contact_id = ctx_contacts.contact_id )
	AND (ctx_contacts.facility_id = app_facility.facility_id)
	AND ( ctx_contract_contacts.ctx_id = :il_ctx_id )
	AND ctx_contract_contacts.owner = 'Y'
	AND ctx_contract_contacts.ic_area = 'I'  
	AND security_users.user_id = ctx_contacts.user_d ;
	
If 	ls_owner_email = '' or isnull(ls_owner_email) Then Return

str_alarm_user lstr_alarm_user
lstr_alarm_user.s_create_list = ls_owner
lstr_alarm_user.s_to_list = ls_owner_email
lstr_alarm_user.s_flag = 'Y'

this.of_add_notification_users(lstr_alarm_user,'append')
end subroutine

public function integer of_reset_action_items ();//Added By Ken.Guo 09/27/2011.  Delete the action items.

Long ll_ctxid = 0,ll_action_id = 0,ll_doc_id = 0,ll_level_id1 = 0,ll_level_id2 = 0

Choose case lower(is_table)
	case 'ctx_basic_info','ctx_custom'
		ll_ctxid = dw_alm_det.getitemnumber( 1, "ctx_id")
		//delete from ctx_action_items where ctx_id = :ll_ctxid and alm_table = :is_table and alm_column = :is_column ;  
	case 'ctx_action_item','ctx_am_action_item'
		//No Action Items to delete
	case 'ctx_custom_multi_hdr','ctx_custom_multi_detail','ctx_fee_sched_nm'
		ll_ctxid = dw_alm_det.getitemnumber( 1, "ctx_id")
		ll_doc_id = dw_alm_det.getitemnumber( 1, "doc_id")
		ll_level_id1 = dw_alm_det.getitemnumber( 1, "level_id1")
		ll_level_id2 = dw_alm_det.getitemnumber( 1, "level_id2")
		//delete from ctx_action_items where  ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_level_id1 and level_id2 = :ll_level_id2 and alm_table = :is_table and alm_column = :is_column;			
	case else
		//
End Choose

//Update ctx_alm_snooze Set asnooze_executed = 0 where ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_hdr_id and level_id2 = :ll_detail_id and alm_table = :is_table and alm_column = :is_column;	
delete from ctx_action_items where  ctx_id = :ll_ctxid and doc_id = :ll_doc_id and level_id1 = :ll_level_id1 and level_id2 = :ll_level_id2 and alm_table = :is_table and alm_column = :is_column;			


Return 1
end function

public function integer of_add_notification_users (str_alarm_user astr_alarm, string as_type);//Add notification users  - Alfee 06.11.2008

Long i, j
String ls_current_users[], ls_new_users[], ls_new_userlist, ls_mailto
string ls_create_users[],ls_create_list,ls_create_list_all,ls_create_arr[]
n_cst_string lnv_string
string	ls_currentAppointmentuser[] , ls_newAppointmentuser[], ls_appointment_list, ls_appointment



IF Len(Trim(astr_alarm.s_to_list)) < 1 THEN RETURN 0
IF dw_alm_msg.rowcount() < 1 THEN RETURN 0


dw_alm_msg.AcceptText() //alfee 12.10.2008


//Set user list
ls_mailto = dw_alm_msg.getitemstring(1, 'alm_mailto')
ls_create_list = dw_alm_msg.getitemstring(1, 'alm_create') //Added By Ken.Guo 03/20/2012. 
ls_appointment = dw_alm_msg.GetItemString( 1, 'alm_appointment' )//added by gavins 20121024

//---------Begin Modified by (Appeon)Harry 09.03.2014 for Bug # 4171 --------
/*
IF IsNull(ls_mailto) OR Len(Trim(ls_mailto)) < 1 THEN
	dw_alm_msg.SetItem(1, 'alm_mailto', lower(astr_alarm.s_to_list ))
ELSE
	lnv_string.of_parsetoarray(Trim(ls_mailto), ';', ls_current_users)
	lnv_string.of_parsetoarray(Trim(lower(astr_alarm.s_to_list )), ';', ls_new_users)
	FOR i = 1 to UpperBound(ls_new_users) 
		FOR j = 1 to UpperBound(ls_current_users)
			IF Upper(Trim(ls_new_users[i])) = Upper(Trim(ls_current_users[j])) THEN EXIT	
		NEXT
		//Skip the duplicated user
		IF j <= UpperBound(ls_current_users) THEN CONTINUE
		//Keep the user in new user list
		IF Len(ls_new_userlist) < 1 THEN
			ls_new_userlist = ls_new_users[i]
		ELSE
			ls_new_userlist += '; ' + ls_new_users[i]
		END IF
	NEXT
	//Add them to current user list	
	IF Len(ls_new_userlist) > 0 THEN 
		IF	Right(Trim(ls_mailto),1) <> ';' THEN ls_mailto = Righttrim(ls_mailto) + '; '
		ls_mailto = ls_mailto + ls_new_userlist
		dw_alm_msg.SetItem(1, 'alm_mailto', ls_mailto)
	END IF
END IF
*/
dw_alm_msg.SetItem(1, 'alm_mailto', lower(astr_alarm.s_to_list ))
//---------End Modfiied ------------------------------------------------------

//added by gavins 20121024
dw_alm_msg.SetItem(1, 'alm_appointment', lower(astr_alarm.s_appointment   ))


//set create action item list
if astr_alarm.s_flag = 'N' then
	dw_alm_msg.SetItem(1, 'alm_create', "")
	dw_alm_det.SetItem( 1,'create_action_item','N')
else
	
	If lower(as_type) = 'append' Then
		//Added By Ken.Guo 03/20/2012. Append to create list
		If ls_create_list = '' or isnull(ls_create_list) Then
			ls_create_list_all = astr_alarm.s_create_list
		Else
			ls_create_list_all = ls_create_list +';'+ astr_alarm.s_create_list
		End If
		gnv_string.of_parsetoarray( ls_create_list_all,';', ls_create_arr[] )
		gnv_string.of_delete_duplicate(ls_create_arr[])
		gnv_string.of_arraytostring(ls_create_arr[], ';', ls_create_list_all)
		dw_alm_msg.SetItem(1, 'alm_create', ls_create_list_all )
	Else
		dw_alm_msg.SetItem(1, 'alm_create', astr_alarm.s_create_list )
	End If
	
	//dw_alm_msg.SetItem(1, 'alm_create', astr_alarm.s_create_list )
	dw_alm_det.SetItem( 1,'create_action_item','Y')
end if


RETURN 1
end function

public function integer of_get_default_message (long al_view_id, string as_alm_table, string as_alm_column, ref blob ablb_message);//====================================================================
// Function: of_get_default_message
//--------------------------------------------------------------------
// Description: Get Default Message Blob
//--------------------------------------------------------------------
// Arguments:
//                al_view_id
//                as_alm_table	
//                as_alm_column
// ref          ablb_message
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/13/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


long	ll_DataLen,ll_Cycle,ll_Count,ll_Start
Blob	lb_Temp
long READ_ONE_LENGTH = 8000

SELECT Datalength(alm_message_blob)
INTO :ll_DataLen
FROM ctx_notification_templates
Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;

If sqlca.sqlcode <> 0 Then Return -1
If ll_DataLen <= 0 or isnull(ll_DataLen) Then Return 0

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECTBLOB SubString(alm_message_blob,:ll_Start,:READ_ONE_LENGTH)
		      INTO :lb_Temp
		      FROM ctx_notification_templates
		      Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;

		ablb_Message += lb_Temp
	next
else
	SELECTBLOB alm_message_blob
		INTO :ablb_Message
		FROM ctx_notification_templates
		Where view_id = :al_view_id and alm_table = :as_alm_table and alm_column = :as_alm_column;
end if


Return 1
end function

on w_ctx_alarm.create
int iCurrent
call super::create
this.ole_message=create ole_message
this.cb_field=create cb_field
this.cb_help=create cb_help
this.cb_default=create cb_default
this.cb_preview=create cb_preview
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_alm_det=create dw_alm_det
this.gb_1=create gb_1
this.st_1=create st_1
this.sle_subject=create sle_subject
this.gb_2=create gb_2
this.st_2=create st_2
this.dw_alm_msg=create dw_alm_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_message
this.Control[iCurrent+2]=this.cb_field
this.Control[iCurrent+3]=this.cb_help
this.Control[iCurrent+4]=this.cb_default
this.Control[iCurrent+5]=this.cb_preview
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.cb_cancel
this.Control[iCurrent+8]=this.dw_alm_det
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.sle_subject
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.dw_alm_msg
end on

on w_ctx_alarm.destroy
call super::destroy
destroy(this.ole_message)
destroy(this.cb_field)
destroy(this.cb_help)
destroy(this.cb_default)
destroy(this.cb_preview)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_alm_det)
destroy(this.gb_1)
destroy(this.st_1)
destroy(this.sle_subject)
destroy(this.gb_2)
destroy(this.st_2)
destroy(this.dw_alm_msg)
end on

event pfc_postopen;call super::pfc_postopen;/******************************************************************************************************************
**  [PUBLIC]   : event pfc_postopen( )
**  Purpose   	: 
**  Arguments 	: [none] 
**  Returns   	: [none]   
**  Created By	: Michael B. Skinner 11 October 2005  © Intellisoftgroup, Inc
**  ---------------------------------------------------------------------------------------------------------------
**  Modify Log : 
**  Changed By : Alfee  Change Date: 08.20.2008  Reason: Enhancement on notificaiton users from V8.5
********************************************************************************************************************/

SetRedraw(FALSE)
//istr_pass = message.powerobjectparm
CHOOSE CASE Upper(istr_pass.s_string_array[2])
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM'  //add ctx_custom - jervis 05.19.2011
		//nothing 
	CASE 'CTX_ACTION_ITEM'
		dw_alm_det.dataobject = 'd_ai_notification'
		dw_alm_msg.dataobject = 'd_ai_notification_message'
	CASE 'CTX_AM_ACTION_ITEM'
		dw_alm_det.dataobject = 'd_am_ai_notification'
		dw_alm_msg.dataobject = 'd_am_ai_notification_message'
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL' //add custom multi - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		dw_alm_det.dataobject = 'd_all_notification'
		dw_alm_msg.dataobject = 'd_all_notification_message'
END CHOOSE
IF Upper(istr_pass.s_string_array[2]) <> 'CTX_BASIC_INFO' THEN
	dw_alm_det.of_SetTransObject(SQLCA)
	dw_alm_msg.of_SetTransObject(SQLCA)
END IF
SetRedraw(TRUE)

//catch the message
gb_1.text =  'Alarm Details for ' +  istr_pass.s_string_array[4]

//Assign key values
of_parse_keyvalues() 

wf_retrieve( )

This.Title = 'Contract Alarms - Contract ID: ' + String(il_ctx_id) //Added By Ken.Guo 03/19/2012. 
If ib_new_mode Then This.Title += ' [New Mode]' //Added By Ken.Guo 05/07/2012

this.show( )

gnv_win_backcolor.of_ChangeWindowBackColor(this) //Add by Evan 11/24/2008

end event

event pfc_endtran;call super::pfc_endtran;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Refresh global cache when ctx_notification changed.

//------Begin Modified by Alfee 02.26.2008 -------------
//<$Reason>for date alarm enhancement
//gnv_data.of_retrieve( "ctx_notification" )
gnv_appeondb.of_startqueue( )
gnv_data.of_retrieve( "ctx_notification" )
gnv_data.of_retrieve( "ctx_ai_notification")
gnv_data.of_retrieve( "ctx_am_ai_notification")
gnv_data.of_retrieve( "ctx_all_notification" ) //jervis 07.08.2011
gnv_appeondb.of_commitqueue( )
//------End Modified -----------------------------------

RETURN success

//---------------------------- APPEON END ----------------------------
end event

event close;call super::close;ole_Message.of_Close() //Alfee 06.11.2008
If isvalid(ids_notification_templates) Then Destroy ids_notification_templates

If isvalid(ids_user_mail_map) Then Destroy ids_user_mail_map
end event

event closequery;//Override - Alfee 06.11.20
Boolean lb_modified = FALSE

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()

IF dw_alm_det.GetItemStatus( 1,0, Primary!) = NewModified! OR &
   dw_alm_det.GetItemStatus( 1,0, Primary!) = DataModified! OR &
	ib_users_modified THEN
	lb_modified = TRUE
ELSEIF ole_message.Object.DocType = 1 THEN
	IF of_is_messagechanged() THEN
		lb_modified = TRUE
	END IF
END IF

if lb_modified then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event pfc_preopen;call super::pfc_preopen;this.hide( )
ids_notification_templates = Create datastore
ids_notification_templates.dataobject = 'd_notification_templates'
ids_notification_templates.SetTransObject(SQLCA)


end event

event open;call super::open;if AppeonGetClientType() = "WEB" then
	This.Width  += 20
	This.Height += 15
end if

istr_pass = message.powerobjectparm //Moved By Ken.Guo 01/18/2012

//Added By Ken.Guo 01/18/2012. 
Long ll_ctx_status
String ls_alarm_enabled,ls_msg
If istr_pass.s_string_array[2] = 'ctx_am_action_item' Then
	//Added By Ken.Guo 02/27/2012. 
	Select ctx_basic_info.status Into :ll_ctx_status  
		From ctx_basic_info,ctx_am_document 
		Where ctx_basic_info.ctx_id = ctx_am_document.ctx_id and ctx_am_document.doc_id = :istr_pass.s_string_array[1];
Else
	Select status Into :ll_ctx_status From ctx_basic_info Where ctx_id = :istr_pass.s_string_array[1];
End If

IF NOT IsNull(ll_ctx_status) THEN ls_alarm_enabled = gnv_data.of_getitem('code_lookup','custom_1',"lookup_name = 'Contract Status' and lookup_code = " + String(ll_ctx_status))
IF Upper(ls_alarm_enabled) <> 'YES' THEN
	ls_msg = "Alarms can't be set because the Contract Status you have selected has the Alarmed Enabled flag set to No.  "
	ls_msg +="To change this setting go to the System->Lookup Painter and select the Contract Status lookup table and change the Alarms Enabled Flag to Yes." 
	MessageBox("Contract Alarms", ls_msg)
	cb_cancel.event clicked( )
	Return
END IF


end event

event activate;call super::activate;//Added By Ken.Guo 2011-11-30. Workaround Office OCX's bug
If isvalid(ole_message ) Then
	ole_message.object.activate(true)
End If
end event

type ole_message from u_email_edit within w_ctx_alarm
integer x = 59
integer y = 1140
integer width = 2802
integer height = 1296
integer taborder = 40
string binarykey = "w_ctx_alarm.win"
end type

event onwordwpsselchange;call super::onwordwpsselchange;if isvalid(w_agreement_template_merge_fields) then
	w_agreement_template_merge_fields.rb_body.checked = true
end if
end event

type cb_field from commandbutton within w_ctx_alarm
integer x = 731
integer y = 2496
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert Field"
end type

event clicked;//Alfee 06.11.2008

long		ll_email_id, ll_export_id, ll_found
string	ls_merge_field
str_pass lstr_pass
DataWindowChild ldwc_1

IF dw_alm_msg.RowCount() < 1 THEN RETURN

//Check email template
ll_email_id = dw_alm_msg.GetItemNumber(1,'alm_email_template_id')
IF IsNull(ll_email_id) OR ll_email_id < 1 THEN 
	MessageBox("IntelliSoftGroup","There isn't an Email template found, please check it first!")
	RETURN
END IF

//Find and check export id
dw_alm_msg.Getchild( "alm_email_template_id", ldwc_1)
ldwc_1.Settransobject( SQLCA )
ll_found = ldwc_1.Find('email_id = ' + String(ll_email_id), 1, ldwc_1.Rowcount())
IF ll_found > 0 THEN ll_export_id = ldwc_1.GetItemNumber(ll_found,'export_id')

IF IsNull(ll_export_id) OR ll_export_id < 1 THEN 
	MessageBox("IntelliSoftGroup","There isn't a related export id found, please check it first!")
	RETURN
END IF

//Open merge fields window
lstr_pass.s_long[1] = ll_export_id
lstr_pass.s_string = "ALARM"
lstr_pass.s_string_array[1] = 'body'

OpenWithParm(w_agreement_template_merge_fields,lstr_pass)
w_agreement_template_merge_fields.of_set_parent(parent)



end event

type cb_help from commandbutton within w_ctx_alarm
integer x = 2551
integer y = 2496
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;open(w_ctx_help)
end event

type cb_default from commandbutton within w_ctx_alarm
integer x = 23
integer y = 2496
integer width = 384
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Set As Default"
end type

event clicked;//Check Create Action Item. //Added By Ken 09/15/2011. 

String ls_value

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()
ls_value = dw_alm_msg.GetItemString(1, "alm_mailto")
if (IsNull(ls_value) or Len(Trim(ls_value)) < 1) then 
	If MessageBox("Verification","The Users to Notify field is empty, do you want to continue?",Question!, Yesno!) = 2 Then 
		dw_alm_msg.setfocus()
		dw_alm_msg.setcolumn("alm_mailto")
		Messagebox('Contract Alarm','Failed to set as default alarm.')
		Return -1
	End If
End If

If (dw_alm_msg.GetItemString(1, 'alm_create') = '' or isnull(dw_alm_msg.GetItemString(1, 'alm_create') )) And &
	dw_alm_det.GetItemString( 1,'create_action_item') = 'Y'  Then
		If Messagebox('Verification','You have checked Create Action Item without assigning a user. Do you want to uncheck Create Action Item?',Question!,YesNo!) = 1 Then
			dw_alm_det.SetItem(1,'create_action_item','N')
		Else
			Messagebox('Contract Alarm ','Failed to set as default alarm.')
			Return -1
		End If
End If

//Insert the word 'New' between the words all and start(name of field) - jervis 09.07.2010
If Messagebox('Contract Alarms',"This will set all new "+istr_pass.s_string_array[4] +" alarms to the settings you currently have in this Alarm window.  This will not affect existing alarms, Continue?",Question!,YesNo!) = 1 Then
	of_set_as_default()
End If

end event

type cb_preview from commandbutton within w_ctx_alarm
integer x = 1097
integer y = 2496
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Preview"
end type

event clicked;Long ll_template_id
String ls_email
n_cst_string lnv_string
str_alarm_email lstr_alarm_email

lstr_alarm_email.ctx_id = il_ctx_id

lstr_alarm_email.as_to = dw_alm_msg.GetItemString(1, "alm_mailto")

//Added By Ken.Guo 11/01/2012. Support Owner for Alarms
If Pos(lstr_alarm_email.as_to, Lower('$<OwnerEmail>$' )) > 0 Then
	Select security_users.email_id
	Into :ls_email
	From ctx_basic_info,ctx_contract_contacts,ctx_contacts,security_users
	Where ctx_basic_info.ctx_id = ctx_contract_contacts.ctx_id 
	And ctx_contacts.contact_id = ctx_contract_contacts.contact_id
	And security_users.user_id = ctx_contacts.user_d;	
	
	If isnull(ls_email) Then ls_email = ''
	lstr_alarm_email.as_to = lnv_string.of_globalreplace( lstr_alarm_email.as_to, Lower('$<OwnerEmail>$'), ls_email)
End If


lstr_alarm_email.as_subject = dw_alm_msg.GetItemString(1, "alm_subject")
lstr_alarm_email.as_attach = dw_alm_msg.GetItemString(1, "alm_attachment_name")
lstr_alarm_email.aole_message = ole_message.object
lstr_alarm_email.al_template_id = dw_alm_msg.GetItemNumber(1, "alm_email_template_id")
lstr_alarm_email.as_sign =   dw_alm_msg.GetItemString(1, "auto_sign")

OpenWithParm(w_ctx_alarm_preview, lstr_alarm_email)


end event

type cb_ok from u_cb within w_ctx_alarm
integer x = 1810
integer y = 2496
integer width = 343
integer taborder = 60
string text = "&OK"
end type

event clicked;call super::clicked;//-----Begin Modified by Alfee on 06.11.2008-----------
//parent.event pfc_save( )

Long 		ll_rtn,ll_WfID,ll_Length
String 	ls_value
long ll_value

dw_alm_det.AcceptText()
dw_alm_msg.AcceptText()
//Restore the status
IF ib_new_mode and dw_alm_det.RowCount() > 0 THEN
	dw_alm_det.SetItemStatus(1, 0, Primary!, NewModified!)
END IF

//Added By Ken.Guo 2009-09-11.
if dw_alm_msg.RowCount() > 0 then
	ls_value = dw_alm_msg.GetItemString(1, "alm_mailto")
	if (IsNull(ls_value) or Len(Trim(ls_value)) < 1) then 
		MessageBox("Verification","The Users to Notify field cannot be empty!")
		dw_alm_msg.setfocus()
		dw_alm_msg.setcolumn("alm_mailto")
		Return -1
	End If
	
	If Not inv_string.of_check_name(ls_value,0, false)  Then
		Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an email address. ')
		dw_alm_msg.SetColumn('alm_mailto')
		dw_alm_msg.SetFocus()
		Return -11
	End If
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_notification_days")
	if IsNull(ll_value) Then // or ll_value = 0) then  //Allow 0, KenGuo20110803
		MessageBox("Verification","The Days In Advance field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_notification_days")
		Return -1
	End If	
	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_frequency")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Reminder Frequency field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_frequency")
		Return -1
	End If	
	ll_value = dw_alm_det.GetItemNumber(1, "alm_total_tries")
	if (IsNull(ll_value) or ll_value = 0) then 
		MessageBox("Verification","The Times to Remind field cannot be empty!")
		dw_alm_det.setfocus()
		dw_alm_det.setcolumn("alm_total_tries")
		Return -1
	End If		

	//Check Create Action Item. //Added By Ken 09/15/2011. 
	If (dw_alm_msg.GetItemString(1, 'alm_create') = '' or isnull(dw_alm_msg.GetItemString(1, 'alm_create') )) And &
		dw_alm_det.GetItemString( 1,'create_action_item') = 'Y'  Then
			If Messagebox('Verification','You have checked Create Action Item without assigning a user. Do you want to uncheck Create Action Item?',Question!,YesNo!) = 1 Then
				dw_alm_det.SetItem(1,'create_action_item','N')
			Else
				Return -1
			End If
	End If
		
	
End If
/* //Commented By Ken.Guo 2009-09-11
if dw_alm_det.RowCount() > 0 and dw_alm_msg.RowCount() > 0 then //Added by Scofield on 2008-12-22
	ll_WfID = dw_alm_det.GetItemNumber(1,"wf_id")
	if IsNull(ll_WfID) then
		//Verify Notification users field - Alfee 12.08.2008
		ll_Length = long(Ole_Message.Object.activedocument.content.End)
		ls_alm_mailto = dw_alm_msg.GetItemString(1, "alm_mailto")
		if (IsNull(ls_alm_mailto) or Len(Trim(ls_alm_mailto)) < 1) and (ll_Length > 1) then 
			MessageBox("Verification","The Users to Notify field cannot be empty!")
			Return -1
		end if
	end if
end if
*/

//Save Alarm Setting
ll_rtn = parent.event pfc_save( )
if ll_Rtn < 0 then 
	Messagebox('Error -1','Failed to save it, please close the window and try again.')
	return -1
End If
ib_users_modified = FALSE

//Update Attachment
ll_rtn = of_update_attachment()
if ll_Rtn < 0 then 
	Messagebox('Error -2','Failed to save it, please close the window and try again.')
	return -1
End If

//Update Message
ll_rtn = of_update_message()
if ll_Rtn < 0 then 
	Messagebox('Error -3','Failed to save it, please close the window and try again.')
	return -1
End If
//-----End Modified -----------------------------------

//Added By Ken.Guo 2009-09-16.
//add ctx_custom - jervis 05.19.2011
//add custom multi data  - - jervis 06.30.2011
If (lower(is_table) = 'ctx_fee_sched_nm' or Lower(is_table) = 'ctx_basic_info' or Lower(is_table) = 'ctx_custom'  or Lower(is_table) = 'ctx_custom_multi_hdr'  or Lower(is_table) = 'ctx_custom_multi_detail') Then 
	of_update_snooze() 
end if

//Added By Ken.Guo 09/27/2011. 
If ib_reset Then
	of_reset_action_items()
	If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.ib_select10 Then
			gw_contract.tab_contract_details.ib_select10 = False //Need refresh action item data.
		End If
	End If
End If

parent.event pfc_close( )

end event

type cb_cancel from u_cb within w_ctx_alarm
integer x = 2181
integer y = 2496
integer width = 343
integer taborder = 70
string text = "&Cancel"
end type

event clicked;call super::clicked;


ib_disableclosequery =  true
parent.event pfc_close( )
end event

type dw_alm_det from u_dw_contract within w_ctx_alarm
string tag = "Alarm Details"
integer x = 41
integer y = 52
integer width = 2834
integer height = 580
integer taborder = 10
string title = "Alarm Details"
string dataobject = "d_notification"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_rmbmenu = false
end type

event pfc_retrieve;call super::pfc_retrieve;Integer li_setting //02.20.2008
Long ll_width //Alfee 06.27.2008
Blob	lblb_Message //Alfee 06.11.2008

//---------------Begin Modified by Alfee on 02.26.2008 ---------------------
//<$Reason>for date alarm enhancement
CHOOSE CASE Upper(istr_pass.s_string_array[2])
	CASE 'CTX_BASIC_INFO','CTX_CUSTOM' //add ctx_custom- jervis 05.11.2011
		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])//modified by gavin 2011-12-28
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008
		end if
	CASE 'CTX_ACTION_ITEM'
		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.ctx_action_item_id[1] = long(istr_pass.s_string_array[5])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4]
			//this.object.alm_date = istr_pass.s_datetime[1]
			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008
		end if				
	CASE 'CTX_AM_ACTION_ITEM'
		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), long(istr_pass.s_string_array[5]), istr_pass.s_string_array[2], istr_pass.s_string_array[3])
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.doc_id[1] = long(istr_pass.s_string_array[1])
			this.object.seq_id[1] = long(istr_pass.s_string_array[5])
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
			//this.object.alm_date = istr_pass.s_datetime[1]
			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008											
		end if	
	//case 'CTX_CUSTOM_MULTI_HDR','CTX_CUSTOM_MULTI_DETAIL'  //ADD CUSTOM MULTI - jervis 06.30.2011
	case else //add fee scheduce - jervis 08.02.2011
		If ib_DW_Retrieve Then this.retrieve(long(istr_pass.s_string_array[1]), istr_pass.s_string_array[2], istr_pass.s_string_array[3],0, long(istr_pass.s_string_array[6]),long(istr_pass.s_string_array[7]))
		if rowcount( ) < 1 then 
			event pfc_addrow( )
			this.object.ctx_id[1] = long(istr_pass.s_string_array[1])
			this.object.doc_id[1] = 0
			this.object.alm_table[1] = istr_pass.s_string_array[2]
			this.object.alm_column[1] = istr_pass.s_string_array[3]
			this.object.alm_action_title[1] = istr_pass.s_string_array[4] 
			this.object.level_id1[1] = long(istr_pass.s_string_array[6])
			this.object.level_id2[1] = long(istr_pass.s_string_array[7])
			//this.object.alm_date = istr_pass.s_datetime[1]
			this.Setitem(1,'alm_date',istr_pass.s_datetime[1])
			ib_new_mode = TRUE //Alfee 06.11.2008											
		end if	
END CHOOSE


//---------------Begin Added by Alfee 07.26.2007-----------------------------------
String ls_color_enabled, ls_color_disabled
ls_color_disabled = dw_alm_det.Describe("alm_last_notification_sent.Background.Color alm_notification_days.Background.Color")
//modified by alfee 09.11.2007 for new column of 'alm_action_title'
IF dw_alm_det.GetItemString(dw_alm_det.GetRow(), 'create_action_item') = 'Y' THEN
	dw_alm_det.Modify("alm_action_title.Protect = 0 alm_action_title.Background.Color= '" + ls_color_enabled + "'" )	
ELSE
	dw_alm_det.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )			
END IF
//Set work flow field according to the support setting - Alfee 03.27.2008
li_setting = of_get_app_setting("set_47","I")
IF li_setting = 1 THEN  
	dw_alm_det.Modify("wf_id.Visible = 1 wf_id_t.Visible = 1")
ELSE
	ll_width = Long(this.object.alm_last_wf_trigger.width) + Long(this.object.alm_last_wf_trigger.x) - Long(this.object.alm_action_title.x)
	dw_alm_det.Modify("wf_id.Visible = 0 wf_id_t.Visible = 0 alm_last_wf_trigger_t.Visible =0 alm_last_wf_trigger.Visible =0 t_5.Visible =0 " + "alm_action_title.width = " + String(ll_width))
END IF
//---------------End Added --------------------------------------------------------

//Added By Ken.Guo 2009-09-11.
If ib_new_mode Then
	of_get_from_default()
End If

IF ib_new_mode and dw_alm_det.RowCount() > 0 THEN 
	dw_alm_det.SetItemStatus(1, 0, Primary!, NotModified!) //Alfee 06.11.2008
END IF

return success


end event

event pfc_validation;call super::pfc_validation;




if not f_validstr(string(this.object.alm_notification_days[1] )) then 
	messagebox('Validation', 'Please enter a value for Notification days')
	return failure
end if


return success
end event

event pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.05.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database.
//$<modification> Comment out the following script to reduce client-server interaction.
//$<modification> refer to of_get_id for more information.
/*
this.object.record_id[1]= inv_contract.of_get_next_record_id( )
*/
long ll_rowcount_local,ll_WfID
LONG LL_MAX_ROW,ll_Length
LL_MAX_ROW = rowcount( )

Long ll_record_id = 0
String ls_alm_mailto//alfee 12.08.2008

for ll_rowcount_local = 1 to LL_MAX_ROW
	 if (not f_validstr(string(this.getitemNumber(ll_rowcount_local,'record_id')))) OR ll_rowcount_local = 1 then
			if ll_record_id = 0 then
				ll_record_id = gnv_app.of_get_id('RECORD_ID', LL_MAX_ROW)
			Else
				ll_record_id++
			end if

         this.setItem(ll_rowcount_local,'record_id', ll_record_id)
	 end if 
next
//---------------------------- APPEON end ----------------------------

dw_alm_msg.AcceptText() //Alfee 02.22.2008

Return success

end event

event itemchanged;call super::itemchanged;String ls_create_action_item
long ll_incream

String ls_color_enabled, ls_color_disabled, ls_action_title
ls_color_enabled = This.Describe("alm_notification_days.Background.Color")
ls_color_disabled = This.Describe("alm_last_notification_sent.Background.Color")
Choose Case dwo.name 
	Case'create_action_item' 
		If data = 'Y' Then
			This.Modify("alm_action_title.Protect = 0 alm_action_title.Background.Color= '" + ls_color_enabled + "'" )			
			ls_action_title = This.GetItemString(row,"alm_action_title")
			IF IsNull(ls_action_title) or Len(Trim(ls_action_title)) < 1 THEN 
				This.SetItem(row, "alm_action_title", Left(istr_pass.s_string_array[4], 20))
			END IF
			dw_alm_msg.post event buttonclicked(row,0,dw_alm_msg.object.b_sendto)
		Else
			This.Modify("alm_action_title.Protect = 1 alm_action_title.Background.Color= '" + ls_color_disabled + "'" )						
		End If
		ll_incream = This.GetItemnumber(row,'alm_auto_increment_years')
		If data = 'N' and ll_incream > 0 Then
			Messagebox('Information','Because you have Auto Snooze selected and do not want an Action Item created, the system will automatically increment the Date field once the initial email reminder is sent.')
		End If
	Case 'alm_auto_increment_years'
		ls_create_action_item = This.GetItemString(row,'create_action_item')
		If ls_create_action_item = 'N' and long(data) > 0 Then
			Messagebox('Information','Because you have Auto Snooze selected and do not want an Action Item created, the system will automatically increment the Date field once the initial email reminder is sent.')
		End If		
End Choose


end event

event buttonclicked;call super::buttonclicked;str_pass lstr_pass_in,lstr_pass_out
If dwo.name = 'b_snooze' Then
	This.AcceptText()
	lstr_pass_in.s_string_array[1] = String(il_ctx_id)
	lstr_pass_in.s_string_array[2] = is_table
	lstr_pass_in.s_string_array[3] = is_column	
	lstr_pass_in.s_string_array[4] = String(This.GetItemNumber(Row,'alm_auto_increment_years'))
	lstr_pass_in.s_string_array[5] = This.GetItemString(Row,'alm_auto_increment_unit')
	lstr_pass_in.s_string_array[6] = string(il_level_id1)
	lstr_pass_in.s_string_array[7] = string(il_level_id2)
	
	OpenWithParm(w_alm_snooze,lstr_pass_in)
	If isvalid(Message.powerobjectparm) Then
		lstr_pass_out = Message.powerobjectparm
		If lstr_pass_in <> lstr_pass_out Then
			This.SetItem(Row,'alm_auto_increment_years',Long(lstr_pass_out.s_string_array[4]))
			This.SetItem(Row,'alm_auto_increment_unit',lstr_pass_out.s_string_array[5])
		End If
	End If
End If

//Added By Ken.Guo 09/27/2011. 
Datetime ldt_null
Long ll_null
SetNull(ll_null)
Setnull(ldt_null)
If dwo.name = 'b_reset' Then
	If This.GetItemNumber(1,'alm_total_tries_counter',Primary!, True) = 0 or isnull( This.GetItemNumber(1,'alm_total_tries_counter',Primary!,True)) Then
		Messagebox('Contract Alarm','This Date Alarm has not been sent yet. There is no need to reset.')
		Return
	End If
	If Messagebox('Contract Alarm','Do you want to reset the Times Emailed to zero?  ~r~n~r~nClick ‘Yes’ to set Times Emailed to zero and delete the corresponding Action Items.', Question!, YesNo!) = 1 Then
		This.SetItem(Row,'alm_total_tries_counter',ll_null)
		This.SetItem(Row,'alm_last_notification_sent',ldt_null)
		This.SetItem(Row,'alm_last_wf_trigger',ldt_null)
		ib_reset = True
	End If
End If


//Added By Ken.Guo 12/26/2012. Support Alarm Email Log
String ls_where, ls_alarm_type
n_cst_notification lnv_notification

If dwo.name = 'b_log' Then
	lnv_notification = Create 	n_cst_notification
	ls_alarm_type = lnv_notification.of_get_alarm_type( is_table )
	
	//add table clause
	ls_where  = ' Where 1 = 1 '
	ls_where += " and (alarm_type = '"+ls_alarm_type+"' or alarm_type = 'Group Email') "

	lstr_pass_in.s_string_array[1] = 'Email Log for ' + dw_alm_det.GetItemString(1, 'alm_action_title')

	//Add Column Clause
	If is_column <> '' Then
		ls_where += " And (CharIndex('(" + is_column + ")', em_mail_audit.field_name) > 0 or ( alarm_type = 'Group Email' And CharIndex('(" + is_column + ")', em_mail_audit.notes) > 0 And CharIndex('(" + ls_alarm_type + ")', em_mail_audit.alarm_type) > 0 )  )  " 
	End If
	
	If il_ctx_id > 0 Then
		ls_where += " And CharIndex('," + String(il_ctx_id) + ",', ',' + em_mail_audit.ctx_id_list + ',' )  > 0 " 
	End If
	If il_doc_id > 0 Then
		ls_where += " And CharIndex('," + String(il_doc_id) + ",', ',' + em_mail_audit.doc_id_list + ',' ) > 0 " 
	End If		
	If il_ai_id > 0 Then
		ls_where += " And CharIndex('," + String(il_ai_id) + ",', ',' + em_mail_audit.ai_id_list + ',' ) > 0 " 
	End If				
	If il_level_id1 > 0 Then
		ls_where += " And CharIndex('," + String(il_level_id1) + ",', ',' + em_mail_audit.level_id1_list + ',' ) > 0 " 
	End If			
	If il_level_id2 > 0 Then
		ls_where += " And CharIndex('," + String(il_level_id2) + ",', ','+ em_mail_audit.level_id2_list + ',' ) > 0 " 
	End If			
	
	If isvalid(lnv_notification) Then Destroy lnv_notification
	
	lstr_pass_in.s_string = ls_Where
	OpenWithParm(w_email_audit,lstr_pass_in )
End If


end event

type gb_1 from u_gb within w_ctx_alarm
integer x = 23
integer width = 2871
integer height = 640
integer taborder = 0
long backcolor = 33551856
string text = "Alarm Details"
end type

type st_1 from statictext within w_ctx_alarm
boolean visible = false
integer x = 69
integer y = 1044
integer width = 402
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 80263581
string text = "Subject:"
boolean focusrectangle = false
end type

type sle_subject from singlelineedit within w_ctx_alarm
integer x = 475
integer y = 924
integer width = 2377
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

event modified;dw_alm_msg.SetItem( 1,'alm_subject',this.text)
end event

event getfocus;if isvalid(w_agreement_template_merge_fields) then
	w_agreement_template_merge_fields.rb_subject.checked = true
end if
end event

type gb_2 from u_gb within w_ctx_alarm
integer x = 23
integer y = 652
integer width = 2871
integer height = 1816
integer taborder = 0
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Email Notification"
end type

type st_2 from statictext within w_ctx_alarm
integer x = 69
integer y = 1064
integer width = 457
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 80263581
string text = "Alert Message:"
boolean focusrectangle = false
end type

type dw_alm_msg from u_dw_contract within w_ctx_alarm
string tag = "Alarm Details"
integer x = 50
integer y = 708
integer width = 2825
integer height = 424
integer taborder = 20
boolean bringtotop = true
string title = "Alarm Details"
string dataobject = "d_notification_message"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_allow_save = false
end type

event itemchanged;call super::itemchanged;//Refresh alert message with the new email template - Alfee 06.11.2008
Long ll_email_id, ll_found
string ls_attach_name, ls_attach_ori
Blob lblb_Message, lblb_attachment
string ls_autosign
//n_cst_string lnv_string
string ls_create_users[],ls_create_list,ls_create_users_new[], ls_create_email_new[]
long ll_i,ll_count,i
string ls_subject

CHOOSE CASE Lower(dwo.name)
	CASE 'alm_email_template_id'
		if Not IsNumber(data) then return
		ll_email_id = long(data)
		IF ll_email_id < 0 THEN RETURN

		//Set insert field button
		Post of_set_insertfield()
				
		SetPointer(HourGlass!)
		SetRedraw(FALSE)
		
		//Set attachment from email template
		ll_found = idwc_template.Find('email_id = ' + String(data), 1, idwc_template.RowCount())
		IF ll_found > 0 THEN 
			ls_attach_name = idwc_template.GetItemString(ll_found, 'attach_name')
			ls_autosign = idwc_template.GetItemString(ll_found, 'auto_sign') //01.20.2009 By Jervis
			ls_subject = idwc_template.GetItemString(ll_found, 'subject') //03.29.2010 By Jervis
			this.SetItem(row,'auto_sign',ls_autosign)
			this.SetItem(row,'alm_subject',ls_subject) //03.29.2010 By Jervis
			//sle_subject.text = ls_subject
		end if
		
		ls_attach_ori = This.GetItemString(row, 'alm_attachment_name')				
		
		IF IsNull(ls_attach_name) THEN ls_attach_name = ''
		IF IsNull(ls_attach_ori) THEN ls_attach_ori = ''	
		IF Len(trim(ls_attach_ori)) > 0 OR Len(trim(ls_attach_name)) > 0 THEN
			This.SetItem(row, 'alm_attachment_name', ls_attach_name)
			ib_attachment_modified = TRUE
		END IF
		
		is_attachment = ''
		
		if ll_email_id = 0 then			//Added by Scofield on 2009-02-23
			ib_attachment_from_template= FALSE
		else
			ib_attachment_from_template= TRUE
		end if
		
		ib_delete_attach = true			//Added by Scofield on 2009-02-23
		
		//Get and open message from email template
		inv_mail.of_get_mail_template(ll_email_id, lblb_Message)
		ole_message.of_open(lblb_Message)	
		
		SetRedraw(TRUE)
		
		of_set_messagechanged(TRUE)
	case 'alm_mailto'		
		//Begin - Modified By Ken.Guo 2010-03-02
		//because alm_create field saved user_id, not saved email_id yet.
		
		/*
		//jervis 10.13.2009
		//set alm_create
		ls_create_list = this.GetItemString( row,"alm_create")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users)
		ll_count = UpperBound(ls_create_users)
		if ll_count > 0 then
			for ll_i = 1 to ll_count
				if Pos(data,trim(ls_create_users[ll_i])) =  0 then
					ls_create_users[ll_i] = ''
				end if
			next
			lnv_string.of_arraytostring( ls_create_users, ";", true, ls_create_list)
			this.SetItem( row, "alm_create",ls_create_list)
		end if
		*/
		long ll_find
		String ls_email
		ls_create_list = this.GetItemString( row,"alm_create")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
		For i = 1 To UpperBound(ls_create_users[])
			ll_find = ids_user_mail_map.Find('trim(lower(user_id)) = "' + trim(lower(ls_create_users[i])) + '"' ,1,ids_user_mail_map.rowcount())
			If ll_find <= 0 Then Continue
			ls_email = ids_user_mail_map.GetItemString(ll_find,'email_id')
			If Pos(lower(data),lower(trim(ls_email))) > 0 Then
				ls_create_users_new[UpperBound(ls_create_users_new[]) + 1 ] = ls_create_users[i]
			End If
		Next
		If UpperBound(ls_create_users_new[]) > 0 Then
			lnv_string.of_arraytostring( ls_create_users_new, ";", true, ls_create_list)
		Else
			ls_create_list = ''
		End If
		this.SetItem( row, "alm_create",ls_create_list)
		//End - Modified By Ken.Guo 2010-03-02
		
		ls_create_users = ls_create_email_new
		ls_create_list = this.GetItemString( row,"alm_appointment")
		lnv_string.of_parsetoarray( ls_create_list,";",ls_create_users[])
		For i = 1 To UpperBound(ls_create_users[])
			If Pos(lower(data),lower(trim(ls_create_users[i]))) > 0 Then
				ls_create_email_new[UpperBound(ls_create_email_new[]) + 1 ] = ls_create_users[i]
			End If
		Next
		If UpperBound(ls_create_users_new[]) > 0 Then
			lnv_string.of_arraytostring( ls_create_email_new, ";", true, ls_create_list)
		Else
			ls_create_list = ''
		End If
		this.SetItem( row, "alm_appointment",ls_create_list)
		
END CHOOSE

end event

event buttonclicked;call super::buttonclicked;//Alfee 06.11.2008
Integer li_rtn
String docpath, docname, ls_userlist

String	ls_PathName,ls_FileName[],ls_AttachList,ls_FileList
long		ll_Rtn,ll_Cycle,ll_FileCnts

This.Accepttext( )
CHOOSE CASE Lower(dwo.name)
	CASE 'b_attach'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<Modify> 2009-02-23 By: Scofield
		//$<Reason> Select Multi-Files as Attachment.
		gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
		ll_Rtn = GetFileOpenName("Select File", ls_PathName, ls_FileName, "DOC", "All Files (*.*), *.*")
		gf_save_dir_path(ls_PathName) //Added by Ken.Guo on 2009-03-10
		//ChangeDirectory(gs_current_path)
		if ll_Rtn <> 1 then Return
		
		ll_FileCnts = UpperBound(ls_FileName)
		
		if ll_FileCnts > 1 then
			if Right(ls_PathName,1) <> "\" then ls_PathName += "\"
			
			for ll_Cycle = 1 to ll_FileCnts
				ls_FileList += ls_FileName[ll_Cycle] + SEMICOLON
				is_attachment += ls_PathName + ls_FileName[ll_Cycle] + SEMICOLON
			next
		elseif ll_FileCnts = 1 then
			ls_FileList += ls_FileName[ll_FileCnts] + SEMICOLON
			is_attachment += ls_PathName + SEMICOLON
		else
			Return
		end if
		
		ls_AttachList = Trim(dw_alm_msg.GetItemString(1,"alm_attachment_name"))
		if IsNull(ls_AttachList) then ls_AttachList = ""
		if Trim(ls_AttachList) <> "" and Right(ls_AttachList,1) <> SEMICOLON then ls_AttachList += SEMICOLON
		
		ls_AttachList += ls_FileList
		dw_alm_msg.SetItem(1, "alm_attachment_name", ls_AttachList)
		
		ib_attachment_modified = TRUE
		
		/*
		li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC", &
					+ "All Files (*.*), *.*", gs_dir_path + gs_DefDirName + "\") 			
		ChangeDirectory(gs_current_path)		
		IF li_rtn < 1 THEN RETURN
		
		dw_alm_msg.SetItem(1, "alm_attachment_name", docname)
		is_attachment = docpath 
		ib_attachment_modified = TRUE
		ib_attachment_from_template= FALSE
		*/
		
		//---------------------------- APPEON END ----------------------------
	CASE 'b_clear'
		IF Len(Trim(dw_alm_msg.GetItemString(1, "alm_attachment_name"))) > 0 THEN
			dw_alm_msg.SetItem(1, "alm_attachment_name", '')
			is_attachment = ''
			ib_attachment_modified = TRUE
			ib_attachment_from_template = FALSE
			ib_delete_attach = true
		END IF
	CASE 'b_sendto'
		//Modify by jervis 10.12.2009
		str_alarm_user	lstr_alarm
		
		lstr_alarm.s_flag = dw_alm_det.GetItemString( 1,"create_action_item")
		lstr_alarm.s_to_list = this.GetItemString(row,'alm_mailto')
		lstr_alarm.s_create_list = this.GetItemString( row,'alm_create')
		lstr_alarm.s_type = istr_pass.s_string_array[2] //Added By Ken.Guo 2010-03-04.
		lstr_alarm.s_appointment = This.GetItemString(row, 'alm_appointment') //added by gavins 20121031
		Openwithparm(w_ctx_alarm_users,lstr_alarm)
		
		/*
		ls_userlist = Message.StringParm
		IF Not IsNull(ls_userlist) AND Len(ls_userlist) > 0 THEN
			of_add_notification_users(Lower(ls_userlist))
		END IF
		*/
		lstr_alarm = message.PowerObjectParm
		if isvalid(lstr_alarm) then
			of_add_notification_users(lstr_alarm,'')
		end if
END CHOOSE

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
08w_ctx_alarm.bin 
2D00000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000009fb3cc7001d172b600000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000009fb3cc7001d172b69fb3cc7001d172b60000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00003f5b0000217d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00003f5b0000217d00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
18w_ctx_alarm.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
