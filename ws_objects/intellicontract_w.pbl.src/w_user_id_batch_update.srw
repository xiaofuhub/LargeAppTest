$PBExportHeader$w_user_id_batch_update.srw
forward
global type w_user_id_batch_update from w_response
end type
type rb_2 from radiobutton within w_user_id_batch_update
end type
type rb_1 from radiobutton within w_user_id_batch_update
end type
type cbx_8 from checkbox within w_user_id_batch_update
end type
type cbx_7 from checkbox within w_user_id_batch_update
end type
type st_2 from statictext within w_user_id_batch_update
end type
type st_1 from statictext within w_user_id_batch_update
end type
type cb_filter from commandbutton within w_user_id_batch_update
end type
type dw_1 from datawindow within w_user_id_batch_update
end type
type cb_select from commandbutton within w_user_id_batch_update
end type
type cb_cancel from commandbutton within w_user_id_batch_update
end type
type cb_ok from commandbutton within w_user_id_batch_update
end type
type cbx_update from checkbox within w_user_id_batch_update
end type
type cbx_6 from checkbox within w_user_id_batch_update
end type
type cbx_5 from checkbox within w_user_id_batch_update
end type
type cbx_4 from checkbox within w_user_id_batch_update
end type
type cbx_3 from checkbox within w_user_id_batch_update
end type
type cbx_2 from checkbox within w_user_id_batch_update
end type
type cbx_1 from checkbox within w_user_id_batch_update
end type
type gb_1 from groupbox within w_user_id_batch_update
end type
type gb_2 from groupbox within w_user_id_batch_update
end type
type gb_3 from groupbox within w_user_id_batch_update
end type
end forward

global type w_user_id_batch_update from w_response
integer width = 1705
integer height = 1768
string title = "User ID and Email Address Batch Update"
long backcolor = 33551856
rb_2 rb_2
rb_1 rb_1
cbx_8 cbx_8
cbx_7 cbx_7
st_2 st_2
st_1 st_1
cb_filter cb_filter
dw_1 dw_1
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
cbx_update cbx_update
cbx_6 cbx_6
cbx_5 cbx_5
cbx_4 cbx_4
cbx_3 cbx_3
cbx_2 cbx_2
cbx_1 cbx_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_user_id_batch_update w_user_id_batch_update

type variables
long il_ctx_id[]
datastore ids_ctx_id


end variables

forward prototypes
public subroutine wf_get_ctx_id ()
public function integer wf_ok3 ()
public function string wf_replace_address (string as_address_list, string as_oriname, string as_curname)
public subroutine wf_setdatealarmuser (long ai_ctxid[], string as_oriname, string as_curname, string as_oriuserid, string as_curuserid)
public subroutine wf_setdatealarmuser (long ai_ctxid[], string as_oriname, string as_curname, string as_oriuserid, string as_curuserid, string as_class)
public function string wf_replace_address (string as_address_list, string as_oriname, string as_curname, string as_class)
public function integer wf_updateemail ()
end prototypes

public subroutine wf_get_ctx_id ();//////////////////////////////////////////////////////////////////////
// $<function>w_user_id_batch_updatewf_get_ctx_id()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.15.2007 by Jack
//////////////////////////////////////////////////////////////////////
long i,ll_rowcount,ll_ctx_id[]

If cbx_update.checked = True Then
	ll_rowcount = ids_ctx_id.rowcount()
	For i = 1 To ll_rowcount
		ll_ctx_id[i] = ids_ctx_id.getitemnumber(i,'ctx_id')
	Next
End If
st_2.text = string(ll_rowcount)
il_ctx_id = ll_ctx_id

	
end subroutine

public function integer wf_ok3 ();//////////////////////////////////////////////////////////////////////
// $<function>w_user_id_batch_update.wf_ok3()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.15.2007 by Jack
//////////////////////////////////////////////////////////////////////
long i,ll_row,ll_ctx_id,ll_seq_no1,ll_seq_no2,ll_seq_no3,ll_seq_no4,ll_pos
string ls_original_user_id,ls_set_to_user_id,ls_wf_assigned_by,ls_action_user
string ls_to_user,ls_by_user,ls_send_to_user,ls_cc_user
string ls_to_notify_user,ls_cc_notify_user,ls_to_reminder_user,ls_cc_reminder_user,ls_to_message_user,ls_cc_message_user
boolean lb_select = False
n_ds lds_ctx_action_items
n_ds lds_ctx_am_action_item
n_ds lds_ctx_contacts
n_ds lds_ctx_contacts_exists
n_ds lds_wf_action_types
n_ds lds_wf_action_status
n_ds lds_sys_audit


//<add> 08/13/2007 by: Andy
long      ll_all = 1
Long      ll_contact_id
Long      ll_Cnt
n_ds lds_ctx_contacts_chk
String    ls_Str = ""
String ls_first_name,ls_last_name
//end of add

If cbx_1.checked = True Then lb_select = True
If cbx_2.checked = True Then lb_select = True
If cbx_3.checked = True Then lb_select = True
If cbx_4.checked = True Then lb_select = True
If cbx_5.checked = True Then lb_select = True
If cbx_6.checked = True Then lb_select = True
If cbx_7.checked = True Then lb_select = True		//Added by Scofield on 2007-09-12

If lb_select = False Then Return 0

ls_original_user_id = Trim( dw_1.getitemstring(dw_1.getrow(),'original_user_id') )
ls_set_to_user_id = Trim ( dw_1.getitemstring(dw_1.getrow(),'set_to_user_id') )
If isnull(ls_original_user_id) Then ls_original_user_id = ''
If isnull(ls_set_to_user_id) Then ls_set_to_user_id = ''
ls_original_user_id= trim(ls_original_user_id)
ls_set_to_user_id = trim(ls_set_to_user_id)

If Len( ls_original_user_id ) = 0 And Len( ls_set_to_user_id ) > 0 And cbx_7.Checked = false Then Return 0

If Len( ls_original_user_id ) > 0 And Len( ls_set_to_user_id )= 0 Then
	MessageBox( this.Title, 'Please enter "set to user id".' )
	Return 0
End If
If Len( ls_original_user_id ) = 0 And Len( ls_set_to_user_id )= 0 Then
	MessageBox( this.Title, 'Please enter "original user id" and "set to user id".' )
	Return 0
End If	
If ls_original_user_id = ls_set_to_user_id Then Return 0//modified by gavins 20121207


//add 08/13/2007 by: Andy
if Not cbx_update.checked then ll_all = 0


If ( cbx_5.checked or cbx_8.checked ) and  cbx_8.enabled = true Then //Add Our Company Contacts - jervis 07.26.2010
	Select TOP 1 a.contact_id,ISNULL(a.first_name,''),ISNULL(a.last_name,'') Into :ll_contact_id,:ls_first_name,:ls_last_name from ctx_contacts a inner join app_facility b on (a.facility_id = b.facility_id) where b.contact_type2 = 'A' and a.user_d = :ls_set_to_user_id ;
	If SQLCA.sqlcode <> 0 Then
		if cbx_8.checked then
			MessageBox(gnv_app.iapp_object.DisplayName,"When Our Company Contacts is selected to update, the Set To User ID must be linked to a Contact Record before proceeding.")
		else
			MessageBox(gnv_app.iapp_object.DisplayName,"When Contact Owner is selected to update, the Set To User ID must be linked to a Contact Record before proceeding.")
		end if
		return 0
	End If
	
	//Commented By Ken.Guo 02/15/2012
	//	lds_ctx_contacts_chk = Create n_ds
	//	lds_ctx_contacts_chk.dataobject = 'd_ctx_contacts_user_id_batch_update_chk'
	//	lds_ctx_contacts_chk.settransobject(sqlca)
	//	ll_Cnt = lds_ctx_contacts_chk.retrieve(il_ctx_id,ls_original_user_id,ll_all,ll_contact_id)	
	//	
	//	if ll_Cnt > 0 then 
	//		//get contract list.
	//		FOR i = 1 to ll_Cnt
	//			ll_ctx_id = lds_ctx_contacts_chk.GetItemNumber( i, "ctx_id")
	//			if IsNull(ll_ctx_id) then ll_ctx_id = 0
	//			ls_Str += string(ll_ctx_id) + ", "
	//		next
	//		
	//		ls_Str = Left(ls_Str,len(ls_Str) - 2)
	//		ls_Str = "Cannot proceed, because the contact " + ls_first_name + " " + ls_last_name + " which is linked to the Set To User ID already exists in the following contracts:~r" + ls_Str
	//		messagebox(gnv_app.iapp_object.DisplayName,ls_Str)
	//		destroy lds_ctx_contacts_chk
	//		return 0
	//	end if
	//	destroy lds_ctx_contacts_chk
	
end if

//If ls_original_user_id = ls_set_to_user_id Then Return 0

lds_ctx_action_items = Create n_ds
lds_ctx_action_items.dataobject = 'd_ctx_action_items_user_id_batch_update'
lds_ctx_action_items.settransobject(sqlca)

lds_ctx_am_action_item = Create n_ds
lds_ctx_am_action_item.dataobject = 'd_ctx_am_action_item_user_id_batch'
lds_ctx_am_action_item.settransobject(sqlca)

lds_ctx_contacts = Create n_ds
if cbx_8.checked then
	//Our company contacts - jervis 07.26.2010
	lds_ctx_contacts.dataobject = 'd_ctx_contacts_all_user_id_batch_update'
else
	lds_ctx_contacts.dataobject = 'd_ctx_contacts_user_id_batch_update'
end if
lds_ctx_contacts.settransobject(sqlca)

//Added By Ken.Guo 02/15/2012. 
lds_ctx_contacts_exists = Create n_ds
lds_ctx_contacts_exists.dataobject = 'd_ctx_contacts_all_user_id_batch_update'
lds_ctx_contacts_exists.settransobject(sqlca)

lds_wf_action_types = Create n_ds
lds_wf_action_types.dataobject = 'd_wf_action_types_user_id_batch_update'
lds_wf_action_types.settransobject(sqlca)

lds_wf_action_status = Create n_ds
lds_wf_action_status.dataobject = 'd_wf_action_status_user_id_batch_update'
lds_wf_action_status.settransobject(sqlca)

lds_sys_audit = Create n_ds
lds_sys_audit.dataobject = 'd_sys_audit_user_id_batch_update'
lds_sys_audit.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
lds_ctx_action_items.retrieve(il_ctx_id)
lds_ctx_am_action_item.retrieve(il_ctx_id)
lds_ctx_contacts.retrieve(il_ctx_id,ls_original_user_id,ll_all)
lds_ctx_contacts_exists.retrieve(il_ctx_id,ls_set_to_user_id,ll_all)
lds_wf_action_types.retrieve()
lds_wf_action_status.retrieve()
Select max(seq_no) into :ll_seq_no1 from sys_audit Where rec_id = 0 and field_id = 20800 and table_id = 1021;
Select max(seq_no) into :ll_seq_no2 from sys_audit Where rec_id = 0 and field_id = 20117 and table_id = 1021;
Select max(seq_no) into :ll_seq_no3 from sys_audit Where rec_id = 0 and field_id = 20801 and table_id = 1064;
Select max(seq_no) into :ll_seq_no4 from sys_audit Where rec_id = 0 and field_id = 20802 and table_id = 1064;
gnv_appeondb.of_commitqueue( )

//Parent Level Action Item Assigned By field
If cbx_1.checked = True and  cbx_1.enabled = true  Then 
	For i = 1 To lds_ctx_action_items.rowcount()
		ls_wf_assigned_by = lds_ctx_action_items.getitemstring(i,'wf_assigned_by')
		If isnull(ls_wf_assigned_by) Then ls_wf_assigned_by = ''
		
		If upper(ls_original_user_id) = trim(upper(ls_wf_assigned_by)) Then
			lds_ctx_action_items.setitem(i,'wf_assigned_by',ls_set_to_user_id)
			
			ll_ctx_id = lds_ctx_action_items.getitemnumber(i,'ctx_id')			
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no1++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',20800)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no1)
			lds_sys_audit.setitem(ll_row,'table_id',1021)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',ls_wf_assigned_by)
			lds_sys_audit.setitem(ll_row,'new_value',ls_set_to_user_id)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		End If		
	Next
End If

//Parent Level Action Item Assigned To field
If cbx_2.checked = True and  cbx_2.enabled = true  Then 
	For i = 1 To lds_ctx_action_items.rowcount()
		ls_action_user = lds_ctx_action_items.getitemstring(i,'action_user')
		If isnull(ls_action_user) Then ls_action_user = ''
		
		If upper(ls_original_user_id) = trim(upper(ls_action_user)) Then
			lds_ctx_action_items.setitem(i,'action_user',ls_set_to_user_id)
			
			ll_ctx_id = lds_ctx_action_items.getitemnumber(i,'ctx_id')			
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no2++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',20117)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no2)
			lds_sys_audit.setitem(ll_row,'table_id',1021)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',ls_action_user)
			lds_sys_audit.setitem(ll_row,'new_value',ls_set_to_user_id)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		End If
	Next
End If

//Document Manager Action Items Assigned By field
If cbx_3.checked = True and  cbx_3.enabled = true  Then 
	For i = 1 To lds_ctx_am_action_item.rowcount()
		ls_wf_assigned_by = lds_ctx_am_action_item.getitemstring(i,'wf_assigned_by')
		If isnull(ls_wf_assigned_by) Then ls_wf_assigned_by = ''
		
		If upper(ls_original_user_id) = trim(upper(ls_wf_assigned_by)) Then
			lds_ctx_am_action_item.setitem(i,'wf_assigned_by',ls_set_to_user_id)
			
			ll_ctx_id = lds_ctx_am_action_item.getitemnumber(i,'ctx_id')			
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no3++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',20801)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no3)
			lds_sys_audit.setitem(ll_row,'table_id',1064)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',ls_wf_assigned_by)
			lds_sys_audit.setitem(ll_row,'new_value',ls_set_to_user_id)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		End If		
	Next
End If

//Document Manager Action Items Assigned To field
If cbx_4.checked = True and  cbx_4.enabled = true  Then 
	For i = 1 To lds_ctx_am_action_item.rowcount()
		ls_action_user = lds_ctx_am_action_item.getitemstring(i,'action_user')
		If isnull(ls_action_user) Then ls_action_user = ''
		
		If upper(ls_original_user_id) = trim(upper(ls_action_user)) Then
			lds_ctx_am_action_item.setitem(i,'action_user',ls_set_to_user_id)
			
			ll_ctx_id = lds_ctx_am_action_item.getitemnumber(i,'ctx_id')			
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no4++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',20802)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no4)
			lds_sys_audit.setitem(ll_row,'table_id',1064)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',ls_action_user)
			lds_sys_audit.setitem(ll_row,'new_value',ls_set_to_user_id)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		End If
	Next
End If


Long ll_org_contact_id, ll_new_contact_id,ll_find
//Contract Owner
If ( cbx_5.checked = True or cbx_8.checked ) and  cbx_8.enabled = true  Then //Add our company contacts - jervis 07.26.2010
	//modify 08/13/2007 by: Andy
	/*
	For i = 1 To lds_ctx_contacts.rowcount()
		ls_action_user = lds_ctx_contacts.getitemstring(i,'user_d')
		If isnull(ls_action_user) Then ls_action_user = ''
		ls_action_user = trim(ls_action_user)
		
		If ls_original_user_id = ls_action_user Then
			lds_ctx_contacts.setitem(i,'user_d',ls_set_to_user_id)
		End If
	Next
	*/	
	
	//Modified By Ken.Guo 02/15/2012. If the Set To User is exists, then Delete Original user and copy the owner and default email values.
	ll_Cnt = lds_ctx_contacts.rowcount()
	For i = ll_Cnt To 1 Step -1
		//lds_ctx_contacts.setitem(i,'contact_id',ll_contact_id)
		ll_org_contact_id = lds_ctx_contacts.GetItemNumber(i,'contact_id')
		ll_ctx_id =  lds_ctx_contacts.GetItemNumber(i,'ctx_contract_contacts_ctx_id')
		ll_find = lds_ctx_contacts_exists.find('ctx_contract_contacts_ctx_id = ' + String(ll_ctx_id) + ' and user_d ="' + ls_set_to_user_id  + '"' ,1,lds_ctx_contacts_exists.rowcount() )
		If ll_find > 0 Then
			If lds_ctx_contacts.GetItemString(i,'ctx_contract_contacts_owner') = 'Y' Then 
				lds_ctx_contacts_exists.SetItem(ll_find, 'ctx_contract_contacts_owner','Y')
			End If
			If lds_ctx_contacts.GetItemString(i,'ctx_contract_contacts_default_email') = 'Y' Then 
				lds_ctx_contacts_exists.SetItem(ll_find, 'ctx_contract_contacts_default_email','Y')
			End If			
	
			lds_ctx_contacts.DeleteRow(i)
		Else
			lds_ctx_contacts.SetItem(i,'contact_id',ll_contact_id)
		End If
		
	Next

	
	
	
	
	//end of modify
End If

//All References in Work Flow Painter
If cbx_6.checked = True and  cbx_6.enabled = true  Then 
	For i = 1 To lds_wf_action_types.rowcount()
		ls_to_user = lds_wf_action_types.getitemstring(i,'to_user')
		ls_by_user = lds_wf_action_types.getitemstring(i,'by_user')
		ls_send_to_user = lds_wf_action_types.getitemstring(i,'send_to_user')
		ls_cc_user = lds_wf_action_types.getitemstring(i,'cc_user')
		
		If isnull(ls_to_user) Then ls_to_user = ''
		If isnull(ls_by_user) Then ls_by_user = ''
		If isnull(ls_send_to_user) Then ls_send_to_user = ''
		If isnull(ls_cc_user) Then ls_cc_user = ''
		ls_to_user = trim(upper(ls_to_user))
		ls_by_user = trim(upper(ls_by_user))
		ls_send_to_user = trim(upper(ls_send_to_user))
		ls_cc_user = trim(upper(ls_cc_user))
//		ls_original_user_id = upper(ls_original_user_id )
		
//		If ls_original_user_id = ls_to_user Then
//			lds_wf_action_types.setitem(i,'to_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_by_user Then
//			lds_wf_action_types.setitem(i,'by_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_send_to_user Then
//			lds_wf_action_types.setitem(i,'send_to_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_cc_user Then
//			lds_wf_action_types.setitem(i,'cc_user',ls_set_to_user_id)
//		End If

		If upper(ls_original_user_id) = ls_to_user Then
			lds_wf_action_types.setitem(i,'to_user',ls_set_to_user_id)
		Else
			ls_to_user = lds_wf_action_types.getitemstring(i,'to_user')
			ll_pos = pos(ls_to_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_to_user = Replace(ls_to_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_types.setitem(i,'to_user',ls_to_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_by_user Then
			lds_wf_action_types.setitem(i,'by_user',ls_set_to_user_id)
		Else
			ls_by_user = lds_wf_action_types.getitemstring(i,'by_user')
			ll_pos = pos(ls_by_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_by_user = Replace(ls_by_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_types.setitem(i,'by_user',ls_by_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_send_to_user Then
			lds_wf_action_types.setitem(i,'send_to_user',ls_set_to_user_id)
		Else
			ls_send_to_user = lds_wf_action_types.getitemstring(i,'send_to_user')
			ll_pos = pos(ls_send_to_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_send_to_user = Replace(ls_send_to_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_types.setitem(i,'send_to_user',ls_send_to_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_cc_user Then
			lds_wf_action_types.setitem(i,'cc_user',ls_set_to_user_id)
		Else
			ls_cc_user = lds_wf_action_types.getitemstring(i,'cc_user')
			ll_pos = pos(ls_cc_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_cc_user = Replace(ls_cc_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_types.setitem(i,'cc_user',ls_cc_user)				
			End If
		End If		
	Next
	
	For i = 1 To lds_wf_action_status.rowcount()
		ls_to_notify_user = lds_wf_action_status.getitemstring(i,'to_notify_user')
		ls_cc_notify_user = lds_wf_action_status.getitemstring(i,'cc_notify_user')
		ls_to_reminder_user = lds_wf_action_status.getitemstring(i,'to_reminder_user')
		ls_cc_reminder_user = lds_wf_action_status.getitemstring(i,'cc_reminder_user')
		ls_to_message_user = lds_wf_action_status.getitemstring(i,'to_message_user')
		ls_cc_message_user = lds_wf_action_status.getitemstring(i,'cc_message_user')
		
		If isnull(ls_to_notify_user) Then ls_to_notify_user = ''
		If isnull(ls_cc_notify_user) Then ls_cc_notify_user = ''
		If isnull(ls_to_reminder_user) Then ls_to_reminder_user = ''
		If isnull(ls_cc_reminder_user) Then ls_cc_reminder_user = ''
		If isnull(ls_to_message_user) Then ls_to_message_user = ''
		If isnull(ls_cc_message_user) Then ls_cc_message_user = ''
		ls_to_notify_user = trim(upper(ls_to_notify_user))
		ls_cc_notify_user = trim(upper(ls_cc_notify_user))
		ls_to_reminder_user = trim(upper(ls_to_reminder_user))
		ls_cc_reminder_user = trim(upper(ls_cc_reminder_user))
		ls_to_message_user = trim(upper(ls_to_message_user))
		ls_cc_message_user = trim(upper(ls_cc_message_user))		
//		ls_original_user_id = upper(ls_original_user_id )
		
//		If ls_original_user_id = ls_to_notify_user Then
//			lds_wf_action_status.setitem(i,'to_notify_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_cc_notify_user Then
//			lds_wf_action_status.setitem(i,'cc_notify_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_to_reminder_user Then
//			lds_wf_action_status.setitem(i,'to_reminder_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_cc_reminder_user Then
//			lds_wf_action_status.setitem(i,'cc_reminder_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_to_message_user Then
//			lds_wf_action_status.setitem(i,'to_message_user',ls_set_to_user_id)
//		End If
//		If ls_original_user_id = ls_cc_message_user Then
//			lds_wf_action_status.setitem(i,'cc_message_user',ls_set_to_user_id)
//		End If

		If upper(ls_original_user_id) = ls_to_notify_user Then
			lds_wf_action_status.setitem(i,'to_notify_user',ls_set_to_user_id)
		Else
			ls_to_notify_user = lds_wf_action_status.getitemstring(i,'to_notify_user')
			ll_pos = pos(ls_to_notify_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_to_notify_user = Replace(ls_to_notify_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'to_notify_user',ls_to_notify_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_cc_notify_user Then
			lds_wf_action_status.setitem(i,'cc_notify_user',ls_set_to_user_id)
		Else
			ls_cc_notify_user = lds_wf_action_status.getitemstring(i,'cc_notify_user')
			ll_pos = pos(ls_cc_notify_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_cc_notify_user = Replace(ls_cc_notify_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'cc_notify_user',ls_cc_notify_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_to_reminder_user Then
			lds_wf_action_status.setitem(i,'to_reminder_user',ls_set_to_user_id)
		Else
			ls_to_reminder_user = lds_wf_action_status.getitemstring(i,'to_reminder_user')
			ll_pos = pos(ls_to_reminder_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_to_reminder_user = Replace(ls_to_reminder_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'to_reminder_user',ls_to_reminder_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_cc_reminder_user Then
			lds_wf_action_status.setitem(i,'cc_reminder_user',ls_set_to_user_id)
		Else
			ls_cc_reminder_user = lds_wf_action_status.getitemstring(i,'cc_reminder_user')
			ll_pos = pos(ls_cc_reminder_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_cc_reminder_user = Replace(ls_cc_reminder_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'cc_reminder_user',ls_cc_reminder_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_to_message_user Then
			lds_wf_action_status.setitem(i,'to_message_user',ls_set_to_user_id)
		Else
			ls_to_message_user = lds_wf_action_status.getitemstring(i,'to_message_user')
			ll_pos = pos(ls_to_message_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_to_message_user = Replace(ls_to_message_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'to_message_user',ls_to_message_user)				
			End If
		End If
		If upper(ls_original_user_id) = ls_cc_message_user Then
			lds_wf_action_status.setitem(i,'cc_message_user',ls_set_to_user_id)
		Else
			ls_cc_message_user = lds_wf_action_status.getitemstring(i,'cc_message_user')
			ll_pos = pos(ls_cc_message_user,ls_original_user_id)
			If ll_pos > 0 Then
				ls_cc_message_user = Replace(ls_cc_message_user, ll_pos, Len(ls_original_user_id), ls_set_to_user_id)
				lds_wf_action_status.setitem(i,'cc_message_user',ls_cc_message_user)				
			End If
		End If

	Next	
End If

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-12 By: Scofield
//$<Reason> Add Date Alarm Notification User Email process
if cbx_7.Checked then
//	MessageBox(gnv_app.iapp_object.DisplayName,'You have selected the "Date Alarm Notification User Email" option.~r~nIf "Set To User Id" already exists in the "Users to be Notified" list of a Contract Alarms dialog, then "Original User Id" in this "Users to be Notified" list will not be replaced.')
	//---------------Begin Modified by Alfee on 08.22.2008------------------
	//$<Reason>Date Alarm Enhancement on Notification User
	String ls_original_mail, ls_set_to_mail 
	gnv_appeondb.of_startqueue( )
 		Select email_id into :ls_original_mail from security_users where user_id = :ls_original_user_id ;
		Select email_id into :ls_set_to_mail from security_users where user_id = :ls_set_to_user_id ;		 
	gnv_appeondb.of_commitqueue( )
	
	If Len(   ls_set_to_user_id   )   >  0   And  Len( ls_original_user_id ) = 0 Then
		If MessageBox(gnv_app.iapp_object.DisplayName, 'You entered the Set to User Id without the Original User Id.This will add the Set to User Id.~r~rDo you want to continue?' , question!, yesno!, 1 ) = 1 then // to the updatable scope you choose  //modified by gavins 20130306
			wf_SetDateAlarmUser(il_ctx_id,ls_original_mail,ls_set_to_mail,ls_original_user_id,ls_set_to_user_id, 'INSERT_USER' )
		Else
			Return 0
		End If
	Else
		MessageBox(gnv_app.iapp_object.DisplayName,'You have selected the "Date Alarm Notification User Email" option.~r~nIf "Set To User Id" already exists in the "Users to be Notified" list of a Contract Alarms dialog, then "Original User Id" in this "Users to be Notified" list will not be replaced.')		
		wf_SetDateAlarmUser(il_ctx_id,ls_original_mail,ls_set_to_mail,ls_original_user_id,ls_set_to_user_id)
	End If
	//wf_SetDateAlarmUser(il_ctx_id,ls_original_user_id,ls_set_to_user_id)
	//wf_SetDateAlarmUser_AI(il_ctx_id,ls_original_user_id,ls_set_to_user_id) //Alfee 02.26.2008
	//---------------End Modified ------------------------------------------
end if
//---------------------------- APPEON END ----------------------------

gnv_appeondb.of_startqueue( )
lds_ctx_action_items.update()
lds_ctx_am_action_item.update()
lds_ctx_contacts.update()
lds_ctx_contacts_exists.update()
lds_wf_action_types.update()
lds_wf_action_status.update()
lds_sys_audit.update()
gnv_appeondb.of_commitqueue( )

Destroy lds_ctx_action_items
Destroy lds_ctx_am_action_item
Destroy lds_ctx_contacts
Destroy lds_wf_action_types
Destroy lds_wf_action_status
Destroy lds_ctx_contacts_exists

Return 1


end function

public function string wf_replace_address (string as_address_list, string as_oriname, string as_curname);
Return wf_replace_address( as_address_list, as_oriname, as_curname , 'UPDATE' )//modified by gavins 20121207




/*

//Add by jervis 10.14.2009
//Initialize variables
n_cst_string lnv_string
string ls_mail[],ls_mailto
long j,ll_ori,ll_cur,ll_cnt_mail

//Added By Ken.Guo 2011-07-22.  ignore case
as_address_list = Lower(as_address_list)
as_oriname = Lower(as_oriname)
as_curname = Lower(as_curname)

//Get mail addresses and parse to array	
ls_mailto = as_address_list
lnv_string.of_parsetoarray( ls_mailto, ";", ls_mail)
ll_cnt_mail = UpperBound(ls_mail)
ls_mailto = ''

//Find the original and current email address 
For j = 1 To ll_cnt_mail
	If Lower(Trim(ls_mail[j])) = as_oriname Then ll_ori = j
	If Lower(Trim(ls_mail[j])) = as_curname Then ll_cur = j
Next

//Replace it if found
If ll_ori > 0 Then
	If ll_cur > 0  Then //If duplicate
		ls_mail[ll_ori] = ""
	Else
		ls_mail[ll_ori] = as_curname
	End If
	//Combine the new email addresses
	For j = 1 To ll_cnt_mail
		If Len(Trim(ls_mail[j])) > 0 Then
			If j > 1 Then ls_mailto += "; "
			ls_mailto += ls_mail[j]
		End If
	Next
End If

return ls_mailto

*/
end function

public subroutine wf_setdatealarmuser (long ai_ctxid[], string as_oriname, string as_curname, string as_oriuserid, string as_curuserid);
wf_SetDateAlarmUser( ai_ctxid, as_oriname, as_curname, as_oriuserid, as_curuserid, 'UPDATE' )//modified by gavins 20121207


/*
//$< Add  > 2007-09-12 By: Scofield
//$<Reason> Set Date Alarm Notification User Email
//Rewriten by Alfee on 08.22.2008, for date alarm enhancement on notification user
Integer  li_module
Long		i, j, ll_cnt, ll_cnt_mail, ll_ori, ll_cur
String	ls_mailto, ls_mail[], ls_null[]

DataStore	lds_notification
n_cst_string lnv_string

if Trim(as_OriName) = Trim(as_CurName) then return
IF IsNull(as_oriname) OR Len(Trim(as_oriname)) < 1 THEN RETURN

IF IsNull(as_curname) THEN as_curname = ""
as_oriname = Lower(Trim(as_oriname))
as_curname = Lower(Trim(as_curname))

lds_notification = Create DataStore

FOR li_module = 1 to 4 //for all modules
	CHOOSE CASE li_module
		CASE 1 
			lds_notification.DataObject = 'd_notification_byctx'
		CASE 2
			lds_notification.DataObject = 'd_ai_notification_byctx'
		CASE 3
			lds_notification.DataObject = 'd_am_ai_notification_byctx'
		case 4   //add by jervis 08.08.2011
			lds_notification.DataObject = 'd_all_notification_byctx'
	END CHOOSE

	//Retrieve and filter first for performance tuning 	
	lds_notification.SetTransObject(SQLCA)
	lds_notification.Retrieve(ai_CtxId)
	lds_notification.SetFilter("lower(alm_mailto) like '%" + Lower(as_oriname) + "%'")
	lds_notification.Filter()
	ll_cnt = lds_notification.RowCount()

	//Find and replace the email address in all notification records
	FOR i = 1 TO ll_cnt
		//Modified by jervis 10.14.2009
		/*
		//Initialize variables
		ll_ori = 0
		ll_cur = 0
		ls_mail = ls_null

		//Get mail addresses and parse to array	
		ls_mailto = lds_notification.GetItemString(i,'alm_mailto')	
		lnv_string.of_parsetoarray( ls_mailto, ";", ls_mail)
		ll_cnt_mail = UpperBound(ls_mail)
		ls_mailto = ''
		
		//Find the original and current email address 
		FOR j = 1 to ll_cnt_mail
			IF Lower(Trim(ls_mail[j])) = as_oriname THEN ll_ori = j
			IF Lower(Trim(ls_mail[j])) = as_curname THEN ll_cur = j
		NEXT
		
		//Replace it if found
		IF ll_ori > 0 THEN 
			IF ll_cur > 0  THEN //If duplicate
				ls_mail[ll_ori] = ""
			ELSE
				ls_mail[ll_ori] = as_curname
			END IF
			//Combine the new email addresses
			FOR j = 1 to ll_cnt_mail
				IF Len(Trim(ls_mail[j])) > 0 THEN
					IF j > 1 THEN ls_mailto += "; "
					ls_mailto += ls_mail[j]
				END IF
			NEXT
			lds_notification.SetItem(i, 'alm_mailto', ls_mailto)
		END IF
		*/
		ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_mailto'),as_oriname,as_curname)
		if ls_mailto <> '' then lds_notification.SetItem(i, 'alm_mailto', ls_mailto)
		//ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_create'),as_oriname,as_curname)
		ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_create'),as_oriuserid,as_curuserid) //Modified By Ken.Guo 2011-07-22
		if ls_mailto <> '' then lds_notification.SetItem(i, 'alm_create', ls_mailto)
	NEXT
	
	//Update to DB
	IF lds_notification.ModifiedCount() > 0 THEN lds_notification.Update()
NEXT
	
Destroy lds_notification
*/


end subroutine

public subroutine wf_setdatealarmuser (long ai_ctxid[], string as_oriname, string as_curname, string as_oriuserid, string as_curuserid, string as_class);//$< Add  > 2007-09-12 By: Scofield
//$<Reason> Set Date Alarm Notification User Email
//Rewriten by Alfee on 08.22.2008, for date alarm enhancement on notification user
Integer  li_module
Long		i, j, ll_cnt, ll_cnt_mail, ll_ori, ll_cur
Long		ll_ctx_id, ll_row, ll_seq_no1, ll_seq_no2
String	ls_mailto, ls_mail[], ls_null[]

DataStore	lds_notification
n_cst_string lnv_string
n_ds		lds_sys_audit



lds_sys_audit = Create n_ds
lds_sys_audit.dataobject = 'd_sys_audit_user_id_batch_update'
lds_sys_audit.settransobject(sqlca)


if Trim(as_OriName) = Trim(as_CurName) then return
//IF ( IsNull(as_oriname) OR Len(Trim(as_oriname)) < 1 ) And as_class <> 'INSERT'  THEN RETURN

IF IsNull(as_curname) THEN as_curname = ""
IF IsNull(as_oriname) THEN as_oriname = ""
as_oriname = Lower(Trim(as_oriname))
as_curname = Lower(Trim(as_curname))

lds_notification = Create DataStore

gnv_appeondb.of_startqueue( )
Select isnull(max(seq_no), 0 ) into :ll_seq_no1 from sys_audit Where rec_id = 0 and field_id = 200825 and table_id = 1031;
Select isnull(max(seq_no), 0 ) into :ll_seq_no2 from sys_audit Where rec_id = 0 and field_id = 200826 and table_id = 1031;
gnv_appeondb.of_commitqueue( )



FOR li_module = 1 to 4 //for all modules
	CHOOSE CASE li_module
		CASE 1 
			lds_notification.DataObject = 'd_notification_byctx'
		CASE 2
			lds_notification.DataObject = 'd_ai_notification_byctx'
		CASE 3
			lds_notification.DataObject = 'd_am_ai_notification_byctx'
		case 4   //add by jervis 08.08.2011
			lds_notification.DataObject = 'd_all_notification_byctx'
	END CHOOSE
	If as_class = 'INSERT_USER' And( li_module = 2 or li_module = 3 ) Then Continue
	//Retrieve and filter first for performance tuning 	
	lds_notification.SetTransObject(SQLCA)
	lds_notification.Retrieve(ai_CtxId)
	Choose Case as_class
			Case 'INSERT'
			Case 'DELETE'
				lds_notification.SetFilter("lower(alm_mailto) like '%" + Lower(as_oriname) + "%'")
				lds_notification.Filter()
			Case 'UPDATE'
				lds_notification.SetFilter("lower(alm_mailto) like '%" + Lower(as_oriname) + "%'")
				lds_notification.Filter()
		End Choose

	ll_cnt = lds_notification.RowCount()

	//Find and replace the email address in all notification records
	FOR i = 1 TO ll_cnt
		ll_ctx_id = lds_notification.GetItemNumber( i, 'ctx_id' )
		If  as_class <> ' INSERT_USER' Then
			ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_mailto'),as_oriname,as_curname, as_class )
			
			lds_notification.SetItem(i, 'alm_mailto', ls_mailto)
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no1++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',200825)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no1)
			lds_sys_audit.setitem(ll_row,'table_id',1031)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',as_oriname)
			lds_sys_audit.setitem(ll_row,'new_value',as_curname)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		
		End If
		If as_Class <> 'INSERT' Then
			If Len( as_oriuserid ) = 0 And Len( as_curuserid ) = 0 Then Continue
			ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_create'),as_oriuserid,as_curuserid, as_class ) //Modified By Ken.Guo 2011-07-22
			
			lds_notification.SetItem(i, 'alm_create', ls_mailto)
			ll_row = lds_sys_audit.insertrow(0)
			ll_seq_no1++
			lds_sys_audit.setitem(ll_row,'rec_id',0)
			lds_sys_audit.setitem(ll_row,'field_id',200826)
			lds_sys_audit.setitem(ll_row,'seq_no',ll_seq_no1)
			lds_sys_audit.setitem(ll_row,'table_id',1031)
			lds_sys_audit.setitem(ll_row,'prac_id',ll_ctx_id)
			lds_sys_audit.setitem(ll_row,'old_value',as_oriuserid)
			lds_sys_audit.setitem(ll_row,'new_value',as_curuserid)
			lds_sys_audit.setitem(ll_row,'user_id',gs_user_id)
			lds_sys_audit.setitem(ll_row,'date_time_modified',today())
			lds_sys_audit.setitem(ll_row,'audit_type','E')			
			lds_sys_audit.setitem(ll_row,'exported',1)
		
		End If
		If as_Class = 'UPDATE' Or as_Class = 'DELETE' Then
			ls_mailto = wf_replace_address(lds_notification.GetItemString(i,'alm_appointment'),as_oriname,as_curname, as_class )
			lds_notification.SetItem(i, 'alm_appointment', ls_mailto)
		End If
				
	NEXT
	
	//Update to DB
	IF lds_notification.ModifiedCount() > 0 THEN lds_notification.Update()
NEXT

IF lds_sys_audit.ModifiedCount() > 0 THEN lds_sys_audit.Update()
	
Destroy lds_notification



end subroutine

public function string wf_replace_address (string as_address_list, string as_oriname, string as_curname, string as_class);//Add by jervis 10.14.2009
//Initialize variables
n_cst_string lnv_string
string ls_mail[],ls_mailto
long j,ll_ori,ll_cur,ll_cnt_mail

//Added By Ken.Guo 2011-07-22.  ignore case
as_address_list = Lower(as_address_list)
as_oriname = Lower(as_oriname)
as_curname = Lower(as_curname)

//Get mail addresses and parse to array	
ls_mailto = as_address_list
lnv_string.of_parsetoarray( ls_mailto, ";", ls_mail)
ll_cnt_mail = UpperBound(ls_mail)


//Find the original and current email address 
For j = 1 To ll_cnt_mail
	If Lower(Trim(ls_mail[j])) = as_oriname Then ll_ori = j
	If Lower(Trim(ls_mail[j])) = as_curname Then ll_cur = j
Next


Choose Case as_class //Modified by gavins 20121207
	Case 'INSERT', 'INSERT_USER'
		If ll_cur = 0 Then
			ls_mailto = ''
			ls_mail[ upperbound( ls_mail ) + 1 ] = as_curname
			//Combine the new email addresses
			ll_cnt_mail =  upperbound( ls_mail )
			For j = 1 To ll_cnt_mail
				If Len(Trim(ls_mail[j])) > 0 Then
					If Len(ls_mailto) > 1 Then ls_mailto += "; "
					ls_mailto += ls_mail[j]
				End If
			Next
		End If
		
	Case 'DELETE' 
		If ll_ori > 0 Then
			ls_mailto = ''
			ls_mail[ll_ori ] = ''
			//Combine the new email addresses
			For j = 1 To ll_cnt_mail
				If Len(Trim(ls_mail[j])) > 0 Then
					If Len(ls_mailto ) > 1 Then ls_mailto += "; "
					ls_mailto += ls_mail[j]
				End If
			Next
		End If
		
	Case 'UPDATE'
		//Replace it if found
		If ll_ori > 0 Then
			ls_mailto = ''
			If ll_cur > 0  Then //If duplicate
				ls_mail[ll_ori] = ""
			Else
				ls_mail[ll_ori] = as_curname
			End If
			//Combine the new email addresses
			For j = 1 To ll_cnt_mail
				If Len(Trim(ls_mail[j])) > 0 Then
					If j > 1 Then ls_mailto += "; "
					ls_mailto += ls_mail[j]
				End If
			Next
		End If
End Choose

If isnull( ls_mailto ) Then ls_mailto = ''


return ls_mailto


end function

public function integer wf_updateemail ();//====================================================================
// Function: wf_updateemail
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	ls_originalemail
// 	ls_newemail
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-12-07
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Long		ll_seq_no1,ll_seq_no2, i, ll_pos
String		ls_originaluser, ls_newuser
String		ls_to_user, ls_by_user, ls_send_to_user, ls_cc_user, ls_original_user_id, ls_set_to_user_id
String		ls_to_notify_user, ls_cc_notify_user, ls_to_reminder_user, ls_cc_reminder_user,ls_to_message_user,ls_cc_message_user
n_ds		lds_wf_action_types, lds_wf_action_status, lds_approve, lds_approve_detail
String		ls_originalemail, ls_newemail



ls_originalemail = Trim ( dw_1.getitemstring(dw_1.getrow(),'original_user_id') )
ls_newemail = Trim( dw_1.getitemstring(dw_1.getrow(),'set_to_user_id') )
If isnull( ls_originalemail ) Then ls_originalemail = ''
If isnull( ls_newemail ) Then ls_newemail = ''
If  Not cbx_6.checked and Not cbx_7.checked Then RETURN 0
If Len( trim( ls_originalemail  ) ) = 0 and  Len( trim( ls_newemail  ) ) = 0 Then Return 0
If  Len( trim( ls_originalemail  ) ) > 0 Then
	If Pos( ls_originalemail, '@' ) = 0 Then
		MessageBox( 'Tips', '"Original email address" must include @ symbol.' )
		Return -1
	End If
End If
If  Len( trim( ls_newemail  ) ) > 0 Then
	If Pos( ls_newemail, '@' ) = 0 Then
		MessageBox( 'Tips', '"Set to email address" must include @ symbol.' )
		Return -1
	End If
End If
If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
		If MessageBox(gnv_app.iapp_object.DisplayName,'You entered the Original Email Address without the Set to Email Address. '+&
'This will delete the Original Email Address.~r~rDo you want to continue?', question!, yesno!, 1 ) <> 1 Then Return 0// from the updatable scope you choose modified by gavins 20130306

End If
If Len(  ls_originalemail )= 0 And Len( ls_newemail ) > 0 Then
	If MessageBox(gnv_app.iapp_object.DisplayName,'You entered the Set to Email Address without the Original Email Address. ' + &
'This will add the Set to Email Address.~r~rDo you want to continue?', question!, yesno!, 1 ) <> 1 Then Return 0// to the updatable scope you choose
End If

If cbx_6.Checked Then
	lds_approve = Create n_ds
	lds_approve.dataobject = 'ds_am_email_master_batchupdate'
	lds_approve.settransobject(sqlca)
			
	lds_approve_detail = Create n_ds
	lds_approve_detail.dataobject = 'ds_am_email_detail_batchupdate'
	lds_approve_detail.settransobject(sqlca)
	
	lds_wf_action_types = Create n_ds
	lds_wf_action_types.dataobject = 'd_wf_action_types_user_id_batch_update'
	lds_wf_action_types.settransobject(sqlca)
	
	lds_wf_action_status = Create n_ds
	lds_wf_action_status.dataobject = 'd_wf_action_status_user_id_batch_update'
	lds_wf_action_status.settransobject(sqlca)
	
	gnv_appeondb.of_startqueue( )
	lds_wf_action_types.retrieve()
	lds_wf_action_status.retrieve()
	lds_approve_detail.Retrieve( il_ctx_id  )
	lds_approve.Retrieve( il_ctx_id )
	gnv_appeondb.of_commitqueue( )
	
	
	For i = 1 To lds_approve.RowCount( )
		ls_to_user = lds_approve.getitemstring(i,'notify_emails2')	
		If isnull(ls_to_user) Then ls_to_user = ''
		If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
			lds_approve.setitem(i,'notify_emails2', wf_replace_address( ls_to_user, ls_originalemail, ls_newemail , 'DELETE' ) )
		ElseIf  Len( ls_originalemail ) > 0 And Len( ls_newemail ) > 0 Then
			lds_approve.setitem(i,'notify_emails2', wf_replace_address( ls_to_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
		End If
	Next
	
	For i = 1 To lds_approve_detail.RowCount( )
		ls_to_user = lds_approve_detail.getitemstring(i,'email_address')	
		ls_by_user = lds_approve_detail.getitemstring(i,'alm_appointment')
		If isnull(ls_to_user) Then ls_to_user = ''
		If isnull(ls_by_user) Then ls_by_user = ''
		If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
			If ls_to_user = ls_originalemail Then
				lds_approve_detail.DeleteRow( i )
				i =i - 1
			End If
//			lds_approve_detail.setitem(i,'email_address', wf_replace_address( ls_to_user, ls_originalemail, ls_newemail , 'DELETE' ) )
//			lds_approve_detail.setitem(i,'alm_appointment', wf_replace_address( ls_by_user, ls_originalemail, ls_newemail , 'DELETE' ) )
		ElseIf  Len( ls_originalemail ) > 0 And Len( ls_newemail ) > 0 Then
			lds_approve_detail.setitem(i,'email_address', wf_replace_address( ls_to_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
			lds_approve_detail.setitem(i,'alm_appointment', wf_replace_address( ls_by_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
		End If
	Next
		
	For i = 1 To lds_wf_action_types.rowcount()
		ls_to_user = lds_wf_action_types.getitemstring(i,'to_user')
		ls_by_user = lds_wf_action_types.getitemstring(i,'by_user')
		ls_send_to_user = lds_wf_action_types.getitemstring(i,'send_to_user')
		ls_cc_user = lds_wf_action_types.getitemstring(i,'cc_user')
		
		If isnull(ls_to_user) Then ls_to_user = ''
		If isnull(ls_by_user) Then ls_by_user = ''
		If isnull(ls_send_to_user) Then ls_send_to_user = ''
		If isnull(ls_cc_user) Then ls_cc_user = ''
		ls_to_user = trim(upper(ls_to_user))
		ls_by_user = trim(upper(ls_by_user))
		ls_send_to_user = trim(upper(ls_send_to_user))
		ls_cc_user = trim(upper(ls_cc_user))

		If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
			lds_wf_action_types.setitem(i,'cc_user', wf_replace_address( ls_cc_user, ls_originalemail, ls_newemail , 'DELETE' ) )
		ElseIf Len(  ls_originalemail )= 0 And Len( ls_newemail ) > 0 Then
			lds_wf_action_types.setitem(i,'cc_user', wf_replace_address( ls_cc_user, ls_originalemail, ls_newemail , 'INSERT' ) )
		ElseIf  Len( ls_originalemail ) > 0 And Len( ls_newemail ) > 0 Then
			lds_wf_action_types.setitem(i,'cc_user', wf_replace_address( ls_cc_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
		End If
	
	Next
	
	For i = 1 To lds_wf_action_status.rowcount()
		ls_to_notify_user = lds_wf_action_status.getitemstring(i,'to_notify_user')
		ls_cc_notify_user = lds_wf_action_status.getitemstring(i,'cc_notify_user')
		ls_to_reminder_user = lds_wf_action_status.getitemstring(i,'to_reminder_user')
		ls_cc_reminder_user = lds_wf_action_status.getitemstring(i,'cc_reminder_user')
		ls_to_message_user = lds_wf_action_status.getitemstring(i,'to_message_user')
		ls_cc_message_user = lds_wf_action_status.getitemstring(i,'cc_message_user')
		
		If isnull(ls_to_notify_user) Then ls_to_notify_user = ''
		If isnull(ls_cc_notify_user) Then ls_cc_notify_user = ''
		If isnull(ls_to_reminder_user) Then ls_to_reminder_user = ''
		If isnull(ls_cc_reminder_user) Then ls_cc_reminder_user = ''
		If isnull(ls_to_message_user) Then ls_to_message_user = ''
		If isnull(ls_cc_message_user) Then ls_cc_message_user = ''
		ls_to_notify_user = trim(upper(ls_to_notify_user))
		ls_cc_notify_user = trim(upper(ls_cc_notify_user))
		ls_to_reminder_user = trim(upper(ls_to_reminder_user))
		ls_cc_reminder_user = trim(upper(ls_cc_reminder_user))
		ls_to_message_user = trim(upper(ls_to_message_user))
		ls_cc_message_user = trim(upper(ls_cc_message_user))		

		If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
			lds_wf_action_status.setitem(i,'cc_notify_user', wf_replace_address( ls_cc_notify_user, ls_originalemail, ls_newemail , 'DELETE' ) )
			lds_wf_action_status.setitem(i,'cc_reminder_user', wf_replace_address( ls_cc_reminder_user, ls_originalemail, ls_newemail , 'DELETE' ) )
			lds_wf_action_status.setitem(i,'cc_message_user', wf_replace_address( ls_cc_message_user, ls_originalemail, ls_newemail , 'DELETE' ) )
		ElseIf Len(  ls_originalemail )= 0 And Len( ls_newemail ) > 0 Then
			lds_wf_action_status.setitem(i,'cc_notify_user', wf_replace_address( ls_cc_notify_user, ls_originalemail, ls_newemail , 'INSERT' ) )
			lds_wf_action_status.setitem(i,'cc_reminder_user', wf_replace_address( ls_cc_reminder_user, ls_originalemail, ls_newemail , 'INSERT' ) )			
			lds_wf_action_status.setitem(i,'cc_message_user', wf_replace_address( ls_cc_message_user, ls_originalemail, ls_newemail , 'INSERT' ) )			
		ElseIf  Len( ls_originalemail ) > 0 And Len( ls_newemail ) > 0 Then
			lds_wf_action_status.setitem(i,'cc_notify_user', wf_replace_address( ls_cc_notify_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
			lds_wf_action_status.setitem(i,'cc_reminder_user', wf_replace_address( ls_cc_reminder_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
			lds_wf_action_status.setitem(i,'cc_message_user', wf_replace_address( ls_cc_message_user, ls_originalemail, ls_newemail , 'UPDATE' ) )
		End If

	Next	
	
	
End If


if cbx_7.Checked then
	
	gnv_appeondb.of_startqueue( )
		If Len( ls_originalemail  ) > 1 Then 
			Select top 1 user_id into :ls_originaluser from security_users where email_id = :ls_originalemail ;
		End If
		If Len( ls_newemail ) > 1 Then
			Select top 1 user_id into :ls_newuser from security_users where email_id = :ls_newemail ;		 
		End If
	gnv_appeondb.of_commitqueue( )
	
	If IsNull( ls_originaluser ) Then ls_originaluser = '' 
	If IsNull( ls_newuser ) Then ls_newuser = '' 
	
	If Len( ls_originalemail ) > 0 And Len( ls_newemail ) = 0 Then
		wf_SetDateAlarmUser(il_ctx_id,ls_originalemail,ls_newemail,ls_originaluser,ls_newuser, 'DELETE' )
	ElseIf Len(  ls_originalemail )= 0 And Len( ls_newemail ) > 0 Then
		wf_SetDateAlarmUser(il_ctx_id,ls_originalemail,ls_newemail,ls_originaluser,ls_newuser, 'INSERT' )
	ElseIf  Len( ls_originalemail ) > 0 And Len( ls_newemail ) > 0 Then
		wf_SetDateAlarmUser(il_ctx_id,ls_originalemail,ls_newemail,ls_originaluser,ls_newuser, 'UPDATE' )
	End If
	
//	wf_SetDateAlarmUser(il_ctx_id,ls_original_mail,ls_set_to_mail,ls_original_user_id,ls_set_to_user_id)
	
	//---------------End Modified ------------------------------------------
end if


gnv_appeondb.of_startqueue( )
lds_approve.update( )
lds_approve_detail.update()
lds_wf_action_types.update()
lds_wf_action_status.update()
gnv_appeondb.of_commitqueue( )




Return 1
end function

on w_user_id_batch_update.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cbx_8=create cbx_8
this.cbx_7=create cbx_7
this.st_2=create st_2
this.st_1=create st_1
this.cb_filter=create cb_filter
this.dw_1=create dw_1
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.cbx_update=create cbx_update
this.cbx_6=create cbx_6
this.cbx_5=create cbx_5
this.cbx_4=create cbx_4
this.cbx_3=create cbx_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.cbx_8
this.Control[iCurrent+4]=this.cbx_7
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_filter
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.cb_select
this.Control[iCurrent+10]=this.cb_cancel
this.Control[iCurrent+11]=this.cb_ok
this.Control[iCurrent+12]=this.cbx_update
this.Control[iCurrent+13]=this.cbx_6
this.Control[iCurrent+14]=this.cbx_5
this.Control[iCurrent+15]=this.cbx_4
this.Control[iCurrent+16]=this.cbx_3
this.Control[iCurrent+17]=this.cbx_2
this.Control[iCurrent+18]=this.cbx_1
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_3
end on

on w_user_id_batch_update.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cbx_8)
destroy(this.cbx_7)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_filter)
destroy(this.dw_1)
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.cbx_update)
destroy(this.cbx_6)
destroy(this.cbx_5)
destroy(this.cbx_4)
destroy(this.cbx_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>openw_user_id_batch_update()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.13.2007 by Jack
//////////////////////////////////////////////////////////////////////
dw_1.settransobject(sqlca)
dw_1.insertrow(0)
ids_ctx_id = create datastore
//ids_ctx_id.dataobject = 'd_user_id_batch_update_for_ctx_id'
ids_ctx_id.dataobject = 'ds_contract_access'
ids_ctx_id.settransobject(sqlca)
//ids_ctx_id.retrieve()
ids_ctx_id.retrieve(gs_user_id)
wf_get_ctx_id()


If dw_1.RowCount( ) > 0 Then
	
	dw_1.SetItem( dw_1.GetRow( ), 'original_user_id', '' )
	dw_1.SetItem( dw_1.GetRow( ), 'set_to_user_id', '' )
End If
end event

event closequery;call super::closequery;Destroy ids_ctx_id

end event

type rb_2 from radiobutton within w_user_id_batch_update
integer x = 946
integer y = 108
integer width = 457
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Email Address"
end type

event clicked;If This.Checked Then
	DataWindowChild		ldwc_Child, ldwc_Child2
	
	
	If dw_1.RowCount( ) = 0  Then dw_1.InsertRow( 0 )
	dw_1.SetItem( dw_1.GetRow( ), 'original_user_id', '' )
	dw_1.SetItem( dw_1.GetRow( ), 'set_to_user_id', '' )
	
	dw_1.Modify( "original_user_id_t.text = 'Original Email Address'" )
	dw_1.Modify( "set_to_user_id_t.text = 'Set To Email Address'" )	
	
	dw_1.Modify( "original_user_id_t.width = 480 " )
	dw_1.Modify( "original_user_id.dddw.name='dddw_batchupdate_emailselect'" )
	dw_1.Modify( "original_user_id.dddw.datacolumn='email_id'" )
	dw_1.Modify( "original_user_id.dddw.displaycolumn='email_id'" )
	dw_1.Modify( "original_user_id.dddw.AllowEdit	='yes'" )
	dw_1.Modify( "original_user_id.dddw.AutoHScroll	= 'yes' " ) //(Appeon)Harry 10.16.2014 - for BugH101401
	dw_1.Modify( "original_user_id.dddw.PercentWidth ='120'" )
	//dw_1.Modify( "original_user_id.dddw.AutoHScroll	= 'yes' " ) //Commented by (Appeon)Harry 10.16.2014 - for BugH101401 
	
	dw_1.Modify( "set_to_user_id_t.width = 480 " )
	dw_1.Modify( "set_to_user_id.dddw.name='dddw_batchupdate_emailselect'" )
	dw_1.Modify( "set_to_user_id.dddw.datacolumn='email_id'" )
	dw_1.Modify( "set_to_user_id.dddw.displaycolumn='email_id'" )
	dw_1.Modify( "set_to_user_id.dddw.AllowEdit	='yes'" )
	dw_1.Modify( "set_to_user_id.dddw.AutoHScroll	= 'yes' " )	//(Appeon)Harry 10.16.2014 - for BugH101401
	dw_1.Modify( "set_to_user_id.dddw.PercentWidth ='120'" )
	//dw_1.Modify( "set_to_user_id.dddw.AutoHScroll	= 'yes' " )	//Commented by (Appeon)Harry 10.16.2014 - for BugH101401 
	
	cbx_1.enabled = false
	cbx_2.enabled = false
	cbx_3.enabled = false
	cbx_4.enabled = false
	cbx_5.enabled = false
	cbx_8.enabled = false
	
	cbx_6.enabled = true 
	cbx_7.enabled = true 
//	If dw_1.GetChild( "original_user_id", ldwc_Child ) > 0 Then
//		ldwc_Child.SetTransObject( sqlca )
//		ldwc_child.Retrieve( )
//	End If
//	
//	If dw_1.GetChild( "set_to_user_id", ldwc_child2 ) > 0 Then
//		ldwc_child2.reset( )
//		ldwc_child.Rowscopy( 1, ldwc_child.RowCount( ), primary!, ldwc_child2, 1 , primary! )
//	End If
	
End If
end event

type rb_1 from radiobutton within w_user_id_batch_update
integer x = 91
integer y = 116
integer width = 416
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "System Users"
boolean checked = true
end type

event clicked;If This.Checked Then
	DataWindowChild			ldwc_child, ldwc_child2
	string							ls_original, ls_set
	
	If dw_1.RowCount( ) = 0  Then dw_1.InsertRow( 0 )
	
	dw_1.SetItem( dw_1.GetRow( ), 'original_user_id', '' )
	dw_1.SetItem( dw_1.GetRow( ), 'set_to_user_id', '' )
	dw_1.Modify( "original_user_id_t.text = 'Original User Id'" )
	dw_1.Modify( "set_to_user_id_t.text = 'Set To User Id'" )	
	
	dw_1.Modify( "original_user_id.dddw.name=''" )
	
	dw_1.Modify( "original_user_id.dddw.name='dddw_security_users'" )
	dw_1.Modify( "original_user_id.dddw.datacolumn='user_id'" )
	dw_1.Modify( "original_user_id.dddw.displaycolumn='user_id'" )
	dw_1.Modify( "original_user_id.dddw.AllowEdit	='no'" )
	dw_1.Modify( "original_user_id.dddw.PercentWidth ='100'" )	
	
	dw_1.Modify( "set_to_user_id.dddw.name=''" )
	dw_1.Modify( "set_to_user_id.dddw.name='dddw_security_users'" )
	dw_1.Modify( "set_to_user_id.dddw.datacolumn='user_id'" )
	dw_1.Modify( "set_to_user_id.dddw.displaycolumn='user_id'" )
	dw_1.Modify( "set_to_user_id.dddw.AllowEdit	='no'" )
	dw_1.Modify( "set_to_user_id.dddw.PercentWidth ='100'" )	
	
//	If dw_1.GetChild( "original_user_id", ldwc_Child ) > 0 Then
//		ldwc_Child.SetTransObject( sqlca )
//		ldwc_child.Retrieve( )
//	End If
//	
//	If dw_1.GetChild( "set_to_user_id", ldwc_child2 ) > 0 Then
//		ldwc_child2.reset( )
//		ldwc_child.Rowscopy( 1, ldwc_child.RowCount( ), primary!, ldwc_child2, 1 , primary! )
//	End If

	ls_original = dw_1.GetItemString( dw_1.GetRow( ), 'original_user_id' )
	ls_Set = dw_1.GetItemString( dw_1.GetRow( ), 'set_to_user_id' )
	If Len(  ls_original ) > 0 or ( ls_original = '' and ls_set = ''   )	Then
		cbx_1.enabled = true
		cbx_2.enabled = true
		cbx_3.enabled = true
		cbx_4.enabled = true
		cbx_5.enabled = true
		cbx_8.enabled = true
		if cbx_8.checked then
			cbx_5.checked = true
			cbx_5.enabled = false
		else
			cbx_5.enabled = true
		end if
	End If
	
End If
end event

type cbx_8 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 848
integer width = 1230
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Our Company Contacts"
boolean checked = true
end type

event clicked;if this.checked then
	cbx_5.checked = true
	cbx_5.enabled = false
else
	cbx_5.enabled = true
end if
end event

type cbx_7 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 1112
integer width = 1038
integer height = 64
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Date Alarm Notification User Email"
boolean checked = true
end type

type st_2 from statictext within w_user_id_batch_update
integer x = 73
integer y = 1412
integer width = 174
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "123"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_user_id_batch_update
integer x = 261
integer y = 1412
integer width = 713
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217746
long backcolor = 33551856
string text = "Contracts will be updated."
boolean focusrectangle = false
end type

type cb_filter from commandbutton within w_user_id_batch_update
integer x = 1271
integer y = 1344
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Set a &Filter..."
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_filter()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.13.2007 by Jack
//////////////////////////////////////////////////////////////////////
string ls_return,ls_temp,ls_ctxid
integer li_position
long i,ll_current,ll_ctx_id[]
boolean b_found

cbx_update.checked = False
st_2.text = '0'
Open( w_rpt_contract_search )

ls_return = Message.StringParm
IF ls_return = '' THEN 
	il_ctx_id = ll_ctx_id
	Return
End If
SetPointer(Hourglass!)
Do
  ls_temp = f_get_token( ls_return, "|" )
  li_position = Pos( ls_temp, "~t" )
  ls_ctxid = Left(ls_temp,li_position - 1)
  ll_current = Long(ls_ctxid)

	b_found = FALSE
	
	FOR i = 1 TO upperbound(ll_ctx_id)
		IF ll_current = ll_ctx_id[i] THEN
			b_found = TRUE
			EXIT
		END IF
	NEXT

	IF NOT b_found THEN ll_ctx_id[upperbound(ll_ctx_id) + 1] = ll_current

Loop While ls_return <> ''
st_2.text = string(upperbound(ll_ctx_id))
il_ctx_id = ll_ctx_id


end event

type dw_1 from datawindow within w_user_id_batch_update
integer x = 14
integer y = 232
integer width = 1911
integer height = 196
integer taborder = 10
string title = "none"
string dataobject = "d_user_id_batch_update"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event itemchanged;AcceptText( )

If row > 0 Then
	If dwo.Name = 'set_to_user_id' Then
		If rb_1.Checked  Then
			If Not ( isnull( data ) or trim( data ) = '' )  and  ( isnull( GetItemString( row, 'original_user_id' ) ) or GetItemString( row, 'original_user_id' ) = ''   )  Then
				cbx_1.enabled = false
				cbx_2.enabled = false
				cbx_3.enabled = false
				cbx_4.enabled = false
				cbx_5.enabled = false
				cbx_6.enabled = false
				cbx_8.enabled = false
			Else 
				cbx_1.enabled = true
				cbx_2.enabled = true
				cbx_3.enabled = true
				cbx_4.enabled = true
				cbx_5.enabled = true
				cbx_6.enabled = true
				cbx_8.enabled = true
				if cbx_8.checked then
					cbx_5.checked = true
					cbx_5.enabled = false
				else
					cbx_5.enabled = true
				end if
				
			End If
		End If		
	End If	
	
	
	if rb_1.Checked and dwo.Name = 'original_user_id'   Then
		If  Len( data ) > 0   Then
			cbx_1.enabled = true
			cbx_2.enabled = true
			cbx_3.enabled = true
			cbx_4.enabled = true
			cbx_5.enabled = true
			cbx_6.enabled = true
			cbx_8.enabled = true
			if cbx_8.checked then
				cbx_5.checked = true
				cbx_5.enabled = false
			else
				cbx_5.enabled = true
			end if
		End If
		If (   Len( data ) = 0 Or isnull( data )) And Not ( isnull( GetItemString( row, 'set_to_user_id' ) ) or GetItemString( row, 'set_to_user_id' ) = ''   )  Then
			cbx_1.enabled = false
			cbx_2.enabled = false
			cbx_3.enabled = false
			cbx_4.enabled = false
			cbx_5.enabled = false
			cbx_6.enabled = false
			cbx_8.enabled = false
			
		End If
		
	End If
	SetItemStatus( row, string( dwo.name),primary!, notmodified! )
End If



end event

event losefocus;AcceptText( )
end event

type cb_select from commandbutton within w_user_id_batch_update
integer x = 46
integer y = 1560
integer width = 352
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Deselect All"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_2()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.13.2007 by Jack
//////////////////////////////////////////////////////////////////////
string			ls_original, ls_Set


If dw_1.Getrow( ) = 0 Then Return
ls_original = dw_1.GetItemString( dw_1.GetRow( ), 'original_user_id' )
ls_Set = dw_1.GetItemString( dw_1.GetRow( ), 'set_to_user_id' )

If rb_1.Checked Then
	If Len(  ls_original ) > 0  or (   trim( ls_original ) = '' and trim( ls_Set ) = ''  )  Then
		
		If this.text = '&Select All' Then
			cbx_1.checked = True
			cbx_2.checked = True
			cbx_3.checked = True
			cbx_4.checked = True
			cbx_5.checked = True
			cbx_6.checked = True
			cbx_7.checked = True				//Added by Scofield on 2007-09-12
			this.text = '&Deselect All'
		Else
			cbx_1.checked = False
			cbx_2.checked = False
			cbx_3.checked = False
			cbx_4.checked = False
			cbx_5.checked = False
			cbx_6.checked = False
			cbx_7.checked = False			//Added by Scofield on 2007-09-12
			this.text = '&Select All'
		End If	
	Else
		If this.text = '&Select All' Then
			
			cbx_7.checked = True				//Added by Scofield on 2007-09-12
			this.text = '&Deselect All'
		Else
			cbx_7.checked = False			//Added by Scofield on 2007-09-12
			this.text = '&Select All'
		End If	
		
	End If
ElseIf rb_2.Checked Then
	
	If this.text = '&Select All' Then
		cbx_6.checked = True
		cbx_7.checked = True				//Added by Scofield on 2007-09-12
		this.text = '&Deselect All'
	Else
		cbx_6.checked = False
		cbx_7.checked = False			//Added by Scofield on 2007-09-12
		this.text = '&Select All'
	End If	
	
End If
end event

type cb_cancel from commandbutton within w_user_id_batch_update
integer x = 1271
integer y = 1560
integer width = 343
integer height = 92
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_cancel()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.08.2007 by Jack
//////////////////////////////////////////////////////////////////////
closewithreturn(parent,0)

end event

type cb_ok from commandbutton within w_user_id_batch_update
integer x = 923
integer y = 1560
integer width = 343
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clickedcb_ok()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.13.2007 by Jack
//////////////////////////////////////////////////////////////////////
string 	ls_module

If upperbound(il_ctx_id) < 1 and cbx_6.Checked = false Then Return

ls_module = '03'

Choose Case ls_module
	Case '01'
		
	Case '02'
		
	Case '03'
		If rb_1.Checked Then
			If wf_ok3() = 1 Then
				MessageBox( parent.Title,'User ID Batch Update Successfully.')
				Close(Parent)			//Added by Scofield on 2010-02-23
			End If
		ElseIf rb_2.Checked Then //added by gavins 20121207
			If wf_updateemail() = 1 Then
				MessageBox(parent.title,'User ID Batch Update Successfully.')
				Close(Parent)			 
			End If			
		ENd If
End Choose

end event

type cbx_update from checkbox within w_user_id_batch_update
integer x = 82
integer y = 1316
integer width = 617
integer height = 64
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update All Contracts"
boolean checked = true
end type

event clicked;wf_get_ctx_id()

end event

type cbx_6 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 1024
integer width = 1230
integer height = 64
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All References in Work Flow Painter"
boolean checked = true
end type

type cbx_5 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 936
integer width = 1230
integer height = 64
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Contract Owner"
boolean checked = true
end type

type cbx_4 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 760
integer width = 1381
integer height = 64
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Document Manager Action Items Assigned To field"
boolean checked = true
end type

type cbx_3 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 672
integer width = 1367
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Document Manager Action Items Assigned By field"
boolean checked = true
end type

type cbx_2 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 584
integer width = 1230
integer height = 64
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Parent Level Action Item Assigned To field"
boolean checked = true
end type

type cbx_1 from checkbox within w_user_id_batch_update
integer x = 82
integer y = 496
integer width = 1230
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Parent Level Action Item Assigned By field"
boolean checked = true
end type

type gb_1 from groupbox within w_user_id_batch_update
integer x = 46
integer y = 420
integer width = 1605
integer height = 804
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Areas To Update"
end type

type gb_2 from groupbox within w_user_id_batch_update
integer x = 46
integer y = 1236
integer width = 1605
integer height = 272
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Contracts To Update"
end type

type gb_3 from groupbox within w_user_id_batch_update
integer x = 46
integer y = 24
integer width = 1605
integer height = 192
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "User Batch Update Type "
end type

