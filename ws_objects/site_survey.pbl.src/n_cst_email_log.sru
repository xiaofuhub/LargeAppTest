$PBExportHeader$n_cst_email_log.sru
forward
global type n_cst_email_log from nonvisualobject
end type
end forward

global type n_cst_email_log from nonvisualobject autoinstantiate
end type

type variables
DataStore ids_EmailSentItem
end variables

forward prototypes
public function integer of_savesentitem (string as_user_id, string as_subject, string as_mail_from, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_attach_name, integer ai_mail_type, integer ai_mail_format, blob ablb_mail_content)
public function integer of_reset ()
public function integer of_update ()
public function integer of_add ()
public function integer of_savesentitem (string as_user_id, string as_subject, string as_mail_from, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_attach_name, integer ai_mail_type, integer ai_mail_format, blob ablb_mail_content, long al_mail_action_item_id)
end prototypes

public function integer of_savesentitem (string as_user_id, string as_subject, string as_mail_from, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_attach_name, integer ai_mail_type, integer ai_mail_format, blob ablb_mail_content);//////////////////////////////////////////////////////////////////////
// $<function> of_SaveSentItem
// $<arguments>
//		...
// $<returns> integer
// $<description> Save one sent item only, for IntelliCred
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////
Long ll_mail_action_item_id = 0

//Modified by Appeon long.zhang 07.05.2017 (v15.4 WebView Email Notifications)
Return This.of_savesentitem( as_user_id, as_subject, as_mail_from, as_mail_to, as_mail_cc, &
						as_mail_bcc, as_attach_name, ai_mail_type, ai_mail_format, ablb_mail_content, &
						ll_mail_action_item_id)

//long ll_id
//DateTime ldt_sent 
//
//ldt_sent = DateTime(Today(), Now()) //alfee 09.24.2013
//
//ids_EmailSentItem.Reset()
//ids_EmailSentItem.InsertRow(0)
////---------Begin Modified by (Appeon)Eugene 06.28.2013 for V141 ISG-CLX--------
//  /*
//	ids_EmailSentItem.SetItem(1, "user_id", as_user_id)
//	ids_EmailSentItem.SetItem(1, "subject", as_Subject)
//	ids_EmailSentItem.SetItem(1, "mail_from", as_mail_from)
//	ids_EmailSentItem.SetItem(1, "mail_to", as_mail_to)
//	ids_EmailSentItem.SetItem(1, "mail_cc", as_mail_cc)
//	ids_EmailSentItem.SetItem(1, "mail_bcc", as_mail_bcc)
//	ids_EmailSentItem.SetItem(1, "sent_time", DateTime(Today(), Now()))
//	ids_EmailSentItem.SetItem(1, "attach_name", as_attach_name)
//	ids_EmailSentItem.SetItem(1, "mail_type", ai_mail_type)
//	ids_EmailSentItem.SetItem(1, "mail_format", ai_mail_format)
//	
//	if ids_EmailSentItem.Update() = 1 then
//		ll_id = ids_EmailSentItem.GetItemNumber(1, "id")
//		UPDATEBLOB em_sent_items SET mail_content = :ablb_mail_content WHERE id = :ll_id;
//		if SQLCA.SQLCode <> 0 then Return 0
//	else
//		Return -1
//	end if      
//  */
//ids_EmailSentItem.SetItem(1, "user_id", as_user_id)
//ids_EmailSentItem.SetItem(1, "mail_date", ldt_sent)
//ids_EmailSentItem.SetItem(1, "mail_subject", as_Subject)
//ids_EmailSentItem.SetItem(1, "mail_from", as_mail_from)
//ids_EmailSentItem.SetItem(1, "mail_to", as_mail_to)
//ids_EmailSentItem.SetItem(1, "mail_cc", as_mail_cc)
//ids_EmailSentItem.SetItem(1, "mail_attach_name", as_attach_name)
//ids_EmailSentItem.SetItem(1, "mail_type", ai_mail_type)
//ids_EmailSentItem.SetItem(1, "mail_format", ai_mail_format)
////---------Begin Added by Alfee 09.24.2013 (BugA083001)---------------------
//ids_EmailSentItem.SetItem(1,'folder_id',3)
//ids_EmailSentItem.SetItem(1,'sub_folder_id',3)
//ids_EmailSentItem.SetItem(1,'mail_msg_id','')
//ids_EmailSentItem.SetItem(1,'mail_importance',0)
//ids_EmailSentItem.SetItem(1,'mail_fromclx',1)
//ids_EmailSentItem.SetItem(1,'mail_save_format','doc') 
//ids_EmailSentItem.SetItem(1,'read_status',1)
//ids_EmailSentItem.SetItem(1,'locked',0)
//ids_EmailSentItem.SetItem(1,'deleted',0)
//ids_EmailSentItem.SetItem(1,'flag',0)
//ids_EmailSentItem.SetItem(1,'last_modify_date',ldt_sent)
//ids_EmailSentItem.SetItem(1,'ctx_id_list', '') 
//ids_EmailSentItem.SetItem(1,'doc_id_list', '') 
//ids_EmailSentItem.SetItem(1,'mail_ctx_id',0)
//ids_EmailSentItem.SetItem(1,'mail_doc_id',0)
//ids_EmailSentItem.SetItem(1,'mail_action_item_id',0)
////---------End Added ------------------------------------------------------------------
//
//if ids_EmailSentItem.Update() = 1 then
//	ll_id = ids_EmailSentItem.GetItemNumber(1, "id")
//	UPDATEBLOB em_mail_items SET mail_rfc822 = :ablb_mail_content WHERE id = :ll_id;
//	if SQLCA.SQLCode <> 0 then Return 0
//else
//	Return -1
//end if
////---------End Modfiied ------------------------------------------------------------------
//
//Return 1
//
end function

public function integer of_reset ();//////////////////////////////////////////////////////////////////////
// $<function> of_Reset()
// $<arguments>
// $<returns> integer
// $<description> Reset datastore of email sent item 
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////

ids_EmailSentItem.Reset()

Return 1
end function

public function integer of_update ();//////////////////////////////////////////////////////////////////////
// $<function> of_Update()
// $<arguments>
// $<returns> integer
// $<description> Update email sent items to database
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////

// Add codes here

Return 1
end function

public function integer of_add ();//////////////////////////////////////////////////////////////////////
// $<function> of_Add()
// $<arguments>
//		...
// $<returns> integer
// $<description> Add a item to datastore but not update
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////

// Add codes here

Return 1
end function

public function integer of_savesentitem (string as_user_id, string as_subject, string as_mail_from, string as_mail_to, string as_mail_cc, string as_mail_bcc, string as_attach_name, integer ai_mail_type, integer ai_mail_format, blob ablb_mail_content, long al_mail_action_item_id);//====================================================================
//$<Function>: of_SaveSentItem
//$<Arguments>:
// 	value    string     as_user_id
// 	value    string     as_subject
// 	value    string     as_mail_from
// 	value    string     as_mail_to
// 	value    string     as_mail_cc
// 	value    string     as_mail_bcc
// 	value    string     as_attach_name
// 	value    integer    ai_mail_type
// 	value    integer    ai_mail_format
// 	value    blob       ablb_mail_content
// 	value    long       mail_action_item_id
//$<Return>:  integer
//$<Description>: Save one sent item only, for IntelliCred. Copied from original of_SaveSentItem and add argument al_mail_action_item_id .
//$<Author>: (Appeon) long.zhang 07.05.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_id
DateTime ldt_sent 

ldt_sent = DateTime(Today(), Now()) //alfee 09.24.2013

ids_EmailSentItem.Reset()
ids_EmailSentItem.InsertRow(0)
//---------Begin Modified by (Appeon)Eugene 06.28.2013 for V141 ISG-CLX--------
  /*
	ids_EmailSentItem.SetItem(1, "user_id", as_user_id)
	ids_EmailSentItem.SetItem(1, "subject", as_Subject)
	ids_EmailSentItem.SetItem(1, "mail_from", as_mail_from)
	ids_EmailSentItem.SetItem(1, "mail_to", as_mail_to)
	ids_EmailSentItem.SetItem(1, "mail_cc", as_mail_cc)
	ids_EmailSentItem.SetItem(1, "mail_bcc", as_mail_bcc)
	ids_EmailSentItem.SetItem(1, "sent_time", DateTime(Today(), Now()))
	ids_EmailSentItem.SetItem(1, "attach_name", as_attach_name)
	ids_EmailSentItem.SetItem(1, "mail_type", ai_mail_type)
	ids_EmailSentItem.SetItem(1, "mail_format", ai_mail_format)
	
	if ids_EmailSentItem.Update() = 1 then
		ll_id = ids_EmailSentItem.GetItemNumber(1, "id")
		UPDATEBLOB em_sent_items SET mail_content = :ablb_mail_content WHERE id = :ll_id;
		if SQLCA.SQLCode <> 0 then Return 0
	else
		Return -1
	end if      
  */
ids_EmailSentItem.SetItem(1, "user_id", as_user_id)
ids_EmailSentItem.SetItem(1, "mail_date", ldt_sent)
ids_EmailSentItem.SetItem(1, "mail_subject", as_Subject)
ids_EmailSentItem.SetItem(1, "mail_from", as_mail_from)
ids_EmailSentItem.SetItem(1, "mail_to", as_mail_to)
ids_EmailSentItem.SetItem(1, "mail_cc", as_mail_cc)
ids_EmailSentItem.SetItem(1, "mail_attach_name", as_attach_name)
ids_EmailSentItem.SetItem(1, "mail_type", ai_mail_type)
ids_EmailSentItem.SetItem(1, "mail_format", ai_mail_format)
//---------Begin Added by Alfee 09.24.2013 (BugA083001)---------------------
ids_EmailSentItem.SetItem(1,'folder_id',3)
ids_EmailSentItem.SetItem(1,'sub_folder_id',3)
ids_EmailSentItem.SetItem(1,'mail_msg_id','')
ids_EmailSentItem.SetItem(1,'mail_importance',0)
ids_EmailSentItem.SetItem(1,'mail_fromclx',1)
ids_EmailSentItem.SetItem(1,'mail_save_format','doc') 
ids_EmailSentItem.SetItem(1,'read_status',1)
ids_EmailSentItem.SetItem(1,'locked',0)
ids_EmailSentItem.SetItem(1,'deleted',0)
ids_EmailSentItem.SetItem(1,'flag',0)
ids_EmailSentItem.SetItem(1,'last_modify_date',ldt_sent)
ids_EmailSentItem.SetItem(1,'ctx_id_list', '') 
ids_EmailSentItem.SetItem(1,'doc_id_list', '') 
ids_EmailSentItem.SetItem(1,'mail_ctx_id',0)
ids_EmailSentItem.SetItem(1,'mail_doc_id',0)
//ids_EmailSentItem.SetItem(1,'mail_action_item_id',0)
ids_EmailSentItem.SetItem(1,'mail_action_item_id', al_mail_action_item_id)
//---------End Added ------------------------------------------------------------------

if ids_EmailSentItem.Update() = 1 then
	ll_id = ids_EmailSentItem.GetItemNumber(1, "id")
	UPDATEBLOB em_mail_items SET mail_rfc822 = :ablb_mail_content WHERE id = :ll_id;
	if SQLCA.SQLCode <> 0 then Return 0
else
	Return -1
end if
//---------End Modfiied ------------------------------------------------------------------

Return 1

end function

on n_cst_email_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_email_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////

ids_EmailSentItem = Create Datastore
//---------Begin Modified by (Appeon)Eugene 06.28.2013 for V141 ISG-CLX--------
  /*
   ids_EmailSentItem.DataObject = "d_email_sent_items"   
  */
 ids_EmailSentItem.DataObject = "d_em_items" 
//---------End Modfiied ------------------------------------------------------------------
ids_EmailSentItem.SetTransObject(SQLCA)
end event

event destructor;//////////////////////////////////////////////////////////////////////
// $<event> destructor()
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.07.2012 by Evan
//////////////////////////////////////////////////////////////////////

Destroy ids_EmailSentItem
end event

