$PBExportHeader$w_upgradetexttodoc.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_upgradetexttodoc from window
end type
type cbx_upgradeemailsig from checkbox within w_upgradetexttodoc
end type
type st_tip from statictext within w_upgradetexttodoc
end type
type cb_upgrade from commandbutton within w_upgradetexttodoc
end type
type cbx_upgradenotify from checkbox within w_upgradetexttodoc
end type
type cbx_upgradeemailtmp from checkbox within w_upgradetexttodoc
end type
type cb_close from commandbutton within w_upgradetexttodoc
end type
type gb_upgrade from groupbox within w_upgradetexttodoc
end type
type hpb_progress from hprogressbar within w_upgradetexttodoc
end type
end forward

global type w_upgradetexttodoc from window
integer width = 1353
integer height = 932
boolean titlebar = true
string title = "Upgrade Email Template and Notification"
boolean controlmenu = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cbx_upgradeemailsig cbx_upgradeemailsig
st_tip st_tip
cb_upgrade cb_upgrade
cbx_upgradenotify cbx_upgradenotify
cbx_upgradeemailtmp cbx_upgradeemailtmp
cb_close cb_close
gb_upgrade gb_upgrade
hpb_progress hpb_progress
end type
global w_upgradetexttodoc w_upgradetexttodoc

type variables
CONSTANT LONG MINPROPOS = 0
CONSTANT LONG MAXPROPOS = 65535

CONSTANT LONG WRITE_ONCE_COUNT = 32760

long		READ_ONE_LENGTH = 8000

Oleobject	iole_Word

String	is_Dir
String	is_TxtName
String	is_DocName

end variables

forward prototypes
public function string of_getemailmsg (long al_email_id)
public subroutine of_upgradeemailmsg ()
public subroutine of_upgradeemailsig ()
public function string of_getemailsig (string as_user_id)
public function string of_getnotifymsg (long al_ctx_id, string as_table, string as_column)
public subroutine of_upgradenotifymsg ()
public function string of_getainotifymsg (long al_ctx_id, long al_item_id, string as_table, string as_column)
public function string of_getamnotifymsg (long al_doc_id, long al_seq_id, string as_table, string as_column)
public subroutine of_upgradeainotifymsg ()
public subroutine of_upgradeamnotifymsg ()
public function long of_writefile (string as_filename, blob ab_data)
public function long of_createdirectory (string as_fullpath)
public function long of_readfile (string as_filename, ref blob ab_data)
public function long of_texttodoc (string as_text, ref blob ablb_data)
end prototypes

public function string of_getemailmsg (long al_email_id);//====================================================================
// Function: of_GetEmailMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long    al_EMail_Id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
String	ls_EmailMsg,ls_Temp

SELECT Datalength(Email_Msg) INTO :ll_DataLen FROM wf_email WHERE Email_id = :al_EMail_Id;

if IsNull(ll_DataLen) or ll_DataLen = 0 then Return ''

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECT SubString(Email_Msg,:ll_Start,:READ_ONE_LENGTH)
		  INTO :ls_Temp
		  FROM wf_email
		 WHERE Email_id = :al_EMail_Id;
		
		ls_EmailMsg += ls_Temp
	next
else
	SELECT Email_Msg
	  INTO :ls_EmailMsg
	  FROM wf_email
	 WHERE Email_id = :al_EMail_Id;
end if

Return ls_EmailMsg

end function

public subroutine of_upgradeemailmsg ();//====================================================================
// Function: of_UpgradeEmailMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_EmailMsg
long		ll_Cycle,ll_RowCnts,ll_EMail_Id
Blob		lblb_EmailMsg,lblb_Empty

DataStore	lds_EmailMsg

lds_EmailMsg = Create DataStore
lds_EmailMsg.DataObject = "d_all_email_id"
lds_EmailMsg.SetTransObject(SQLCA)
lds_EmailMsg.Retrieve()

ll_RowCnts = lds_EmailMsg.RowCount()
if ll_RowCnts <= 0 then
	Destroy lds_EmailMsg
	Return
end if

hpb_Progress.SetStep = long(hpb_Progress.MaxPosition/ll_RowCnts)

for ll_Cycle = 1 to ll_RowCnts
	ll_EMail_Id = lds_EmailMsg.GetItemNumber(ll_Cycle,"email_id")
	ls_EmailMsg = of_GetEmailMsg(ll_EMail_Id)
	
	lblb_EmailMsg = lblb_Empty
	of_TextToDoc(ls_EmailMsg,lblb_EmailMsg)
	
	UPDATEBLOB wf_email
		    SET EMail_Message = :lblb_EmailMsg
	     WHERE email_id = :ll_EMail_Id;
		  
	hpb_Progress.StepIt()
next

COMMIT;

Destroy lds_EmailMsg

end subroutine

public subroutine of_upgradeemailsig ();//====================================================================
// Function: of_UpgradeEmailSig()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_User_id,ls_EmailSig
long		ll_Cycle,ll_RowCnts
Blob		lblb_EmailSig,lblb_Empty

DataStore	lds_EmailSig

lds_EmailSig = Create DataStore
lds_EmailSig.DataObject = "d_all_sig_user_id"
lds_EmailSig.SetTransObject(SQLCA)
lds_EmailSig.Retrieve()

ll_RowCnts = lds_EmailSig.RowCount()
if ll_RowCnts <= 0 then
	Destroy lds_EmailSig
	Return
end if

hpb_Progress.SetStep = long(hpb_Progress.MaxPosition/ll_RowCnts)

for ll_Cycle = 1 to ll_RowCnts
	ls_User_id = lds_EmailSig.GetItemString(ll_Cycle,"user_id")
	ls_EmailSig = of_GetEmailSig(ls_User_id)

	lblb_EmailSig = lblb_Empty
	of_TextToDoc(ls_EmailSig,lblb_EmailSig)
	
	UPDATEBLOB Security_User_Mailsetting
			 SET Signature = :lblb_EmailSig
		  WHERE user_id = :ls_User_id;
	
	hpb_Progress.StepIt()
next

COMMIT;

Destroy lds_EmailSig

end subroutine

public function string of_getemailsig (string as_user_id);//====================================================================
// Function: of_GetEmailSig()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_user_id
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
String	ls_EmailSig,ls_Temp

SELECT Datalength(Mail_Signature) INTO :ll_DataLen FROM Security_User_Mailsetting WHERE user_id = :as_user_id;

if IsNull(ll_DataLen) or ll_DataLen = 0 then Return ''

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECT SubString(Mail_Signature,:ll_Start,:READ_ONE_LENGTH)
		  INTO :ls_Temp
		  FROM Security_User_Mailsetting
		 WHERE user_id = :as_user_id;
		
		ls_EmailSig += ls_Temp
	next
else
	SELECT Mail_Signature
	  INTO :ls_EmailSig
	  FROM Security_User_Mailsetting
	 WHERE user_id = :as_user_id;
end if

Return ls_EmailSig

end function

public function string of_getnotifymsg (long al_ctx_id, string as_table, string as_column);//====================================================================
// Function: of_GetNotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_ctx_id
// 	value    string    as_table
// 	value    string    as_column
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
String	ls_AlmSig,ls_Temp

SELECT Datalength(alm_Message) INTO :ll_DataLen FROM ctx_Notification WHERE ctx_id = :al_ctx_id and alm_table = :as_table and alm_column = :as_column;

if IsNull(ll_DataLen) or ll_DataLen = 0 then Return ''

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECT SubString(alm_Message,:ll_Start,:READ_ONE_LENGTH)
		  INTO :ls_Temp
		  FROM ctx_Notification
		 WHERE ctx_id = :al_ctx_id and alm_table = :as_table and alm_column = :as_column;
		
		ls_AlmSig += ls_Temp
	next
else
	SELECT alm_Message
	  INTO :ls_AlmSig
	  FROM ctx_Notification
	 WHERE ctx_id = :al_ctx_id and alm_table = :as_table and alm_column = :as_column;
end if

Return ls_AlmSig

end function

public subroutine of_upgradenotifymsg ();//====================================================================
// Function: of_UpgradeNotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Table,ls_Column,ls_AlmMsg
long		ll_ctx_id,ll_Cycle,ll_RowCnts
Blob		lblb_AlmMsg,lblb_Empty

DataStore	lds_AlmMsg

lds_AlmMsg = Create DataStore
lds_AlmMsg.DataObject = "d_all_ctx_notification"
lds_AlmMsg.SetTransObject(SQLCA)
lds_AlmMsg.Retrieve()

ll_RowCnts = lds_AlmMsg.RowCount()
if ll_RowCnts <= 0 then
	Destroy lds_AlmMsg
	Return
end if

hpb_Progress.SetStep = long(hpb_Progress.MaxPosition/ll_RowCnts)

for ll_Cycle = 1 to ll_RowCnts
	ll_ctx_id = lds_AlmMsg.GetItemNumber(ll_Cycle,"ctx_id")
	ls_Table  = lds_AlmMsg.GetItemString(ll_Cycle,"alm_table")
	ls_Column = lds_AlmMsg.GetItemString(ll_Cycle,"alm_column")
	
	ls_AlmMsg = of_GetNotifyMsg(ll_ctx_id,ls_Table,ls_Column)

	lblb_AlmMsg = lblb_Empty
	of_TextToDoc(ls_AlmMsg,lblb_AlmMsg)
	
	UPDATEBLOB ctx_notification
			 SET alm_message_blob = :lblb_AlmMsg
		  WHERE ctx_id = :ll_ctx_id and alm_table = :ls_Table and alm_column = :ls_Column;
	
	hpb_Progress.StepIt()
next

COMMIT;

Destroy lds_AlmMsg

end subroutine

public function string of_getainotifymsg (long al_ctx_id, long al_item_id, string as_table, string as_column);//====================================================================
// Function: of_GetAINotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_ctx_id
// 	value    long      al_item_id
// 	value    string    as_table
// 	value    string    as_column
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
String	ls_AiAlmSig,ls_Temp

SELECT Datalength(alm_Message) INTO :ll_DataLen FROM ctx_Ai_Notification WHERE ctx_id = :al_ctx_id and ctx_action_item_id = :al_item_id and alm_table = :as_table and alm_column = :as_column;

if IsNull(ll_DataLen) or ll_DataLen = 0 then Return ''

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECT SubString(alm_Message,:ll_Start,:READ_ONE_LENGTH)
		  INTO :ls_Temp
		  FROM ctx_Ai_Notification
		 WHERE ctx_id = :al_ctx_id and ctx_action_item_id = :al_item_id and alm_table = :as_table and alm_column = :as_column;
		
		ls_AiAlmSig += ls_Temp
	next
else
	SELECT alm_Message
	  INTO :ls_AiAlmSig
	  FROM ctx_Ai_Notification
	 WHERE ctx_id = :al_ctx_id and ctx_action_item_id = :al_item_id and alm_table = :as_table and alm_column = :as_column;
end if

Return ls_AiAlmSig

end function

public function string of_getamnotifymsg (long al_doc_id, long al_seq_id, string as_table, string as_column);//====================================================================
// Function: of_GetAmNotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    long      al_doc_id
// 	value    long      al_seq_id
// 	value    string    as_table
// 	value    string    as_column
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_DataLen,ll_Cycle,ll_Count,ll_Start
String	ls_AiAlmSig,ls_Temp

SELECT Datalength(alm_Message) INTO :ll_DataLen FROM ctx_Am_Ai_Notification WHERE doc_id = :al_doc_id and seq_id = :al_seq_id and alm_table = :as_table and alm_column = :as_column;

if IsNull(ll_DataLen) or ll_DataLen = 0 then Return ''

if AppeonGetClientType() = 'PB' and gs_dbtype = 'SQL' and ll_DataLen > READ_ONE_LENGTH then
	ll_Count = Ceiling(ll_DataLen/READ_ONE_LENGTH)
	
	for ll_Cycle = 1 To ll_Count
		ll_Start = (ll_Cycle - 1) * READ_ONE_LENGTH + 1
		SELECT SubString(alm_Message,:ll_Start,:READ_ONE_LENGTH)
		  INTO :ls_Temp
		  FROM ctx_Am_Ai_Notification
		 WHERE doc_id = :al_doc_id and seq_id = :al_seq_id and alm_table = :as_table and alm_column = :as_column;
		
		ls_AiAlmSig += ls_Temp
	next
else
	SELECT alm_Message
	  INTO :ls_AiAlmSig
	  FROM ctx_Am_Ai_Notification
	 WHERE doc_id = :al_doc_id and seq_id = :al_seq_id and alm_table = :as_table and alm_column = :as_column;
end if

Return ls_AiAlmSig

end function

public subroutine of_upgradeainotifymsg ();//====================================================================
// Function: of_UpgradeAINotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Table,ls_Column,ls_AlmMsg
long		ll_ctx_id,ll_item_id,ll_Cycle,ll_RowCnts
Blob		lblb_AiAlmMsg,lblb_Empty

DataStore	lds_AiAlmMsg

lds_AiAlmMsg = Create DataStore
lds_AiAlmMsg.DataObject = "d_all_ai_notification"
lds_AiAlmMsg.SetTransObject(SQLCA)
lds_AiAlmMsg.Retrieve()

ll_RowCnts = lds_AiAlmMsg.RowCount()
if ll_RowCnts <= 0 then
	Destroy lds_AiAlmMsg
	Return
end if

hpb_Progress.SetStep = long(hpb_Progress.MaxPosition/ll_RowCnts)

for ll_Cycle = 1 to ll_RowCnts
	ll_ctx_id  = lds_AiAlmMsg.GetItemNumber(ll_Cycle,"ctx_id")
	ll_item_id = lds_AiAlmMsg.GetItemNumber(ll_Cycle,"ctx_action_item_id")
	ls_Table   = lds_AiAlmMsg.GetItemString(ll_Cycle,"alm_table")
	ls_Column  = lds_AiAlmMsg.GetItemString(ll_Cycle,"alm_column")
	
	ls_AlmMsg = of_GetAINotifyMsg(ll_ctx_id,ll_item_id,ls_Table,ls_Column)
	lblb_AiAlmMsg = lblb_Empty
	of_TextToDoc(ls_AlmMsg,lblb_AiAlmMsg)
	
	UPDATEBLOB ctx_ai_notification
			 SET alm_message_blob = :lblb_AiAlmMsg
		  WHERE ctx_id = :ll_ctx_id and ctx_action_item_id = :ll_item_id and alm_table = :ls_Table and alm_column = :ls_Column;

	hpb_Progress.StepIt()
next

COMMIT;

Destroy lds_AiAlmMsg

end subroutine

public subroutine of_upgradeamnotifymsg ();//====================================================================
// Function: of_UpgradeAmNotifyMsg()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Table,ls_Column,ls_AmAlmMsg
long		ll_doc_id,ll_seq_id,ll_Cycle,ll_RowCnts
Blob		lblb_AmAlmMsg,lblb_Empty

DataStore	lds_AmAlmMsg

lds_AmAlmMsg = Create DataStore
lds_AmAlmMsg.DataObject = "d_all_am_notification"
lds_AmAlmMsg.SetTransObject(SQLCA)
lds_AmAlmMsg.Retrieve()

ll_RowCnts = lds_AmAlmMsg.RowCount()
if ll_RowCnts <= 0 then
	Destroy lds_AmAlmMsg
	Return
end if

hpb_Progress.SetStep = long(hpb_Progress.MaxPosition/ll_RowCnts)

for ll_Cycle = 1 to ll_RowCnts
	ll_doc_id  = lds_AmAlmMsg.GetItemNumber(ll_Cycle,"doc_id")
	ll_seq_id = lds_AmAlmMsg.GetItemNumber(ll_Cycle,"seq_id")
	ls_Table   = lds_AmAlmMsg.GetItemString(ll_Cycle,"alm_table")
	ls_Column  = lds_AmAlmMsg.GetItemString(ll_Cycle,"alm_column")
	
	ls_AmAlmMsg = of_GetAMNotifyMsg(ll_doc_id,ll_seq_id,ls_Table,ls_Column)
	
	lblb_AmAlmMsg = lblb_Empty
	of_TextToDoc(ls_AmAlmMsg,lblb_AmAlmMsg)
	
	UPDATEBLOB ctx_am_ai_notification
			 SET alm_message_blob = :lblb_AmAlmMsg
		  WHERE doc_id = :ll_doc_id and seq_id = :ll_seq_id and alm_table = :ls_Table and alm_column = :ls_Column;
	
	hpb_Progress.StepIt()
next

COMMIT;

Destroy lds_AmAlmMsg

end subroutine

public function long of_writefile (string as_filename, blob ab_data);//====================================================================
// Function: of_writefile()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_FileName
// 	value    blob      ab_Data
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_FileNo,ll_CurPos,ll_Cycle,ll_Cnts
Blob		lblb_Buf

ll_Cnts = Ceiling(Len(ab_Data) * 1.0 / WRITE_ONCE_COUNT)

ll_FileNo = FileOpen(as_FileName,StreamMode!,Write!,LockReadWrite!,Replace!)
if ll_FileNo <= 0 then Return -1

for ll_Cycle = 1 to ll_Cnts
	ll_CurPos = (ll_Cycle - 1) * WRITE_ONCE_COUNT + 1
	lblb_Buf = BlobMid(ab_Data,ll_CurPos,WRITE_ONCE_COUNT)
	FileWrite(ll_FileNo,lblb_Buf)
next

FileClose(ll_FileNo)

Return 1

end function

public function long of_createdirectory (string as_fullpath);//====================================================================
// Function: of_CreateDirectory()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_FullPath
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_AncesPath
long		ll_Pos,ll_Rtn

as_FullPath = Trim(as_FullPath)

if Right(as_FullPath,1) <> "\" then as_FullPath += "\"

ll_Pos = Pos(as_FullPath,"\")
do while ll_Pos > 0
	ls_AncesPath = Left(as_FullPath,ll_Pos)
	if Not DirectoryExists(ls_AncesPath) then
		ll_Rtn = CreateDirectory(ls_AncesPath)
		if ll_Rtn <> 1 then Return -1
	end if
	ll_Pos = Pos(as_FullPath,"\",ll_Pos + 1)
loop

Return 1

end function

public function long of_readfile (string as_filename, ref blob ab_data);//====================================================================
// Function: of_ReadFile()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_FileName
// 	value    blob      ab_Data
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Byte
long	ll_FileNo
blob	lblb_Buf

ll_FileNo = FileOpen(as_FileName, StreamMode!, Read!, Shared!)
if ll_FileNo = -1 then 
	SetNull(ab_Data)
	Return -1
end if

do
	ll_Byte = FileRead(ll_FileNo, lblb_Buf)
	if ll_Byte > 0 then
		ab_Data += lblb_Buf
	else
		Exit
	end if
loop while true

FileClose(ll_FileNo)

Return 1
end function

public function long of_texttodoc (string as_text, ref blob ablb_data);//====================================================================
// Function: of_TextToDoc()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    string    as_Text
// 	ref      blob      ablb_Data
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-09-02
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long		ll_Rtn

ll_Rtn = of_WriteFile(is_TxtName,Blob(as_Text))
if ll_Rtn > 0 then
	TRY
		iole_Word.documents.Open(is_TxtName,false,true)
		//---------Begin Added by (Appeon)Harry 01.22.2014 for V142 ISG-CLX--------
		gnv_word_utility.of_modify_word_property( iole_Word.Activedocument)	//Added By Mark Lee 06/20/2013 change for office 2013.
		//---------End Added ------------------------------------------------------
		gnv_shell.of_delete_recent( is_TxtName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_Word.ActiveDocument.SaveAs(is_DocName,0,false,'',false)
		gnv_shell.of_delete_recent( is_DocName, true) //Added By Ken.Guo 2010-05-25. Delete Windows Recent Document.
		iole_Word.ActiveDocument.Close(0)
	CATCH(Throwable th)
		if IsValid(iole_Word) then
			iole_Word.Quit(0)
			iole_Word.DisconnectObject( )
			iole_Word.ConnectToNewObject("word.application")
		end if
	END TRY
	
	of_ReadFile(is_DocName,ablb_Data)
end if

Return 1

end function

on w_upgradetexttodoc.create
this.cbx_upgradeemailsig=create cbx_upgradeemailsig
this.st_tip=create st_tip
this.cb_upgrade=create cb_upgrade
this.cbx_upgradenotify=create cbx_upgradenotify
this.cbx_upgradeemailtmp=create cbx_upgradeemailtmp
this.cb_close=create cb_close
this.gb_upgrade=create gb_upgrade
this.hpb_progress=create hpb_progress
this.Control[]={this.cbx_upgradeemailsig,&
this.st_tip,&
this.cb_upgrade,&
this.cbx_upgradenotify,&
this.cbx_upgradeemailtmp,&
this.cb_close,&
this.gb_upgrade,&
this.hpb_progress}
end on

on w_upgradetexttodoc.destroy
destroy(this.cbx_upgradeemailsig)
destroy(this.st_tip)
destroy(this.cb_upgrade)
destroy(this.cbx_upgradenotify)
destroy(this.cbx_upgradeemailtmp)
destroy(this.cb_close)
destroy(this.gb_upgrade)
destroy(this.hpb_progress)
end on

event open;is_Dir = gs_dir_path + gs_DefDirName + "\Email\"
of_CreateDirectory(is_Dir)

is_TxtName = is_Dir + "Temp.txt"
is_DocName = is_Dir + "Temp.doc"

iole_Word = Create OleObject

if iole_Word.ConnectToNewObject("word.application") = 0  then
	iole_Word.ChangeFileOpenDirectory(is_Dir)
else
	MessageBox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.',Exclamation!)
	Close(This)
end if

end event

event close;if IsValid(iole_Word) then
	iole_Word.Quit(0)
	iole_Word.DisconnectObject( )
	Destroy iole_Word
end if

end event

type cbx_upgradeemailsig from checkbox within w_upgradetexttodoc
integer x = 338
integer y = 272
integer width = 667
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Upgrade Email Signature"
boolean checked = true
end type

type st_tip from statictext within w_upgradetexttodoc
integer x = 105
integer y = 532
integer width = 1138
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Ready"
boolean focusrectangle = false
end type

type cb_upgrade from commandbutton within w_upgradetexttodoc
integer x = 530
integer y = 716
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Upgrade"
end type

event clicked;if Not cbx_UpgradeEmailTmp.Checked and Not cbx_UpgradeEmailSig.Checked and Not cbx_UpgradeNotify.Checked then Return

hpb_Progress.MinPosition = MINPROPOS
hpb_Progress.MaxPosition = MAXPROPOS

SetPointer(HourGlass!)

This.Enabled = false

if cbx_UpgradeEmailTmp.Checked then
	st_Tip.Text = "Now it is Upgrading Email Template, please wait..."
	hpb_Progress.Position = 0
	of_UpgradeEmailMsg()
end if

if cbx_UpgradeEmailSig.Checked then
	st_Tip.Text = "Now it is Upgrading Email Signature, please wait..."
	hpb_Progress.Position = 0
	of_UpgradeEmailSig()
end if

if cbx_UpgradeNotify.Checked then
	st_Tip.Text = "Now it is Upgrading Notification(1/3), please wait..."
	hpb_Progress.Position = 0
	of_UpgradeNotifyMsg()
	
	st_Tip.Text = "Now it is Upgrading Notification(2/3), please wait..."
	hpb_Progress.Position = 0
	of_UpgradeAiNotifyMsg()
	
	st_Tip.Text = "Now it is Upgrading Notification(3/3), please wait..."
	hpb_Progress.Position = 0
	of_UpgradeAmNotifyMsg()
end if

st_Tip.Text = "Upgrade is Completed."

This.Enabled = true

SetPointer(Arrow!)

end event

type cbx_upgradenotify from checkbox within w_upgradetexttodoc
integer x = 338
integer y = 372
integer width = 667
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Upgrade Notification"
boolean checked = true
end type

type cbx_upgradeemailtmp from checkbox within w_upgradetexttodoc
integer x = 338
integer y = 172
integer width = 667
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Upgrade Email Template"
boolean checked = true
end type

type cb_close from commandbutton within w_upgradetexttodoc
integer x = 901
integer y = 716
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)

end event

type gb_upgrade from groupbox within w_upgradetexttodoc
integer x = 105
integer y = 56
integer width = 1138
integer height = 444
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Upgrade Scope"
end type

type hpb_progress from hprogressbar within w_upgradetexttodoc
integer x = 105
integer y = 608
integer width = 1138
integer height = 68
unsignedinteger maxposition = 100
integer setstep = 10
boolean smoothscroll = true
end type

