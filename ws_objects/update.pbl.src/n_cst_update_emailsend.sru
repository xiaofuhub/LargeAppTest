$PBExportHeader$n_cst_update_emailsend.sru
forward
global type n_cst_update_emailsend from nonvisualobject
end type
end forward

global type n_cst_update_emailsend from nonvisualobject
end type
global n_cst_update_emailsend n_cst_update_emailsend

forward prototypes
public function integer of_update_almusers ()
end prototypes

public function integer of_update_almusers ();//Update date alarm notification users to alm_mailto field from v85 - Alfee 08.20.2008



Long i, li_module, ll_cnt_users, ll_cnt_mailto, ll_found, ll_begin
Long ll_ctx_id, ll_ai_id, ll_doc_id, ll_seq_id
String ls_table, ls_column, ls_mailto, ls_mailid
String ls_find, ls_Error
integer li_set //maha111608

//Start Code Change ----11.06.2008 #V85 maha
select set_56 into :li_set from icred_settings;
if li_set = 1 then return 1
//End Code Change---11.06.2008

DataStore lds_alm_users, lds_alm_mailto

SetPointer(HourGlass!)

lds_alm_users = Create DataStore
lds_alm_mailto = Create DataStore

FOR li_module = 1 to 3
	//Initialize DataStores
	CHOOSE CASE li_module
		CASE 1 //Date Alarm in Contract
			lds_alm_users.DataObject = 'd_alm_mailid'
			lds_alm_mailto.DataObject = 'd_alm_mailto'
		CASE 2 //Date Alarm in Contract Action Item	
			lds_alm_users.DataObject = 'd_alm_ai_mailid'
			lds_alm_mailto.DataObject = 'd_alm_ai_mailto'
		CASE 3 //Date Alarm in Document Manager Action Item	
			lds_alm_users.DataObject = 'd_alm_am_ai_mailid'
			lds_alm_mailto.DataObject = 'd_alm_am_ai_mailto'
	END CHOOSE
	lds_alm_users.SetTransObject(SQLCA)
	lds_alm_mailto.SetTransObject(SQLCA)	
	
	//Retieve notification info
	ll_cnt_mailto = lds_alm_mailto.Retrieve() //target 
	IF ll_cnt_mailto > 0 THEN ll_cnt_users = lds_alm_users.Retrieve() //source

	//Find and Get Email ids 
	FOR i = 1 to ll_cnt_mailto
		//Get and initialize variables	
		ls_table = lds_alm_mailto.GetItemString(i, 'alm_table')
		ls_column = lds_alm_mailto.GetItemString(i, 'alm_column')
		CHOOSE CASE li_module
			CASE 1 //Date Alarm in Contract
				ll_ctx_id = lds_alm_mailto.GetItemNumber(i, 'ctx_id')
				ls_find = "ctx_id = " + String(ll_ctx_id)	+ " AND alm_table = '" + ls_table + &
						  "' AND alm_column = '" + ls_column + "'"				
			CASE 2 //Date Alarm in Contract Action Item	
				ll_ctx_id = lds_alm_mailto.GetItemNumber(i, 'ctx_id')
				ll_ai_id = lds_alm_mailto.GetItemNumber(i, 'ctx_action_item_id')
				ls_find = "ctx_id = " + String(ll_ctx_id)	+  " AND ctx_action_item_id = " + String(ll_ai_id) + &
						  " AND alm_table = '" + ls_table + "' AND alm_column = '" + ls_column + "'"								
			CASE 3 //Date Alarm in Document Manager Action Item		
				ll_doc_id = lds_alm_mailto.GetItemNumber(i, 'doc_id')
				ll_seq_id = lds_alm_mailto.GetItemNumber(i, 'seq_id')
				ls_find = "doc_id = " + String(ll_doc_id)	+  " AND seq_id = " + String(ll_seq_id) + &
						  " AND alm_table = '" + ls_table + "' AND alm_column = '" + ls_column + "'"					
		END CHOOSE
		ls_mailto = ""
				  
		//Find and Combine Email ids
		ll_found = lds_alm_users.Find(ls_find, 1, ll_cnt_users)
		DO WHILE ll_found > 0 
			ls_mailid = lds_alm_users.GetItemString(ll_found, 'email_id')	
			IF Not IsNull(ls_mailid) AND LenA(Trim(ls_mailid)) > 0 THEN 
				IF LenA(Trim(ls_mailto)) > 0 THEN ls_mailto += "; "
				ls_mailto += ls_mailid
			END IF
			//-----Begin Modified by Alfee 04.24.2009--------------------------
			IF ll_found >= ll_cnt_users THEN EXIT
			ll_found = lds_alm_users.Find(ls_find, ll_found + 1, ll_cnt_users)
			//IF ll_found >= ll_cnt_mailto THEN EXIT
			//ll_found = lds_alm_users.Find(ls_find, ll_found + 1, ll_cnt_mailto)
			//-----End Modified -----------------------------------------------
		LOOP	
	
		//Set alm_mailto field
		IF LenA(Trim(ls_mailto)) > 0 THEN lds_alm_mailto.SetItem(i, 'alm_mailto', ls_mailto)
	NEXT

	//Update to DB
	IF lds_alm_mailto.modifiedcount( ) > 0 THEN 
		IF lds_alm_mailto.Update( ) <> 1 THEN
			ls_Error = "n_cst_update_emailsend.of_upgrade_email Information: Upate Date Alarm Notification users failed, call support."
			IF SQLCA.SQLCode <> 0 THEN ls_error += "~r~n "+SQLCA.SQLErrText+". "		
			IF IsValid(gnv_logservice)THEN
				gnv_logservice.of_setloglevel(2) //warning level
				gnv_logservice.of_log_warning(ls_Error)
				gb_upgrade_failed = True
			END IF
		END IF
	END IF
	
NEXT

Destroy lds_alm_users
Destroy lds_alm_mailto

SetPointer(Arrow!)

RETURN 1
end function

on n_cst_update_emailsend.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_update_emailsend.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

