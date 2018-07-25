$PBExportHeader$n_cst_date_alarm.sru
forward
global type n_cst_date_alarm from nonvisualobject
end type
end forward

global type n_cst_date_alarm from nonvisualobject autoinstantiate
end type

forward prototypes
public function integer of_reset_alart_status (string as_table, string as_column, long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2)
end prototypes

public function integer of_reset_alart_status (string as_table, string as_column, long al_ctx_id, long al_doc_id, long al_level_id1, long al_level_id2);//====================================================================
// Function: of_reset_alart_status
//--------------------------------------------------------------------
// Description: Reset the date alarm's Times Emailed to zero. 
//--------------------------------------------------------------------
// Arguments:
//                as_table
//                as_column
//                al_ctx_id
//                al_doc_id
//                al_level_id1
//                al_level_id2
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 05/08/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================


string ls_flag,ls_enabled, ls_message
Long ll_complete


Choose Case Lower(as_table)
	Case 'ctx_basic_info','ctx_custom'
		SELECT '1' 
		 INTO :ls_flag  
		 FROM ctx_notification  
		WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
				And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
				And (ctx_id = :al_ctx_id)  And alm_enabled = '1'  ;		
	Case 'ctx_action_item'
		SELECT '1' 
		 INTO :ls_flag  
		 FROM ctx_ai_notification  
		WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
				And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
				And (ctx_id = :al_ctx_id)  And ctx_ai_notification.ctx_action_item_id = :al_level_id1
				And alm_enabled = '1'  ;				
	Case 'ctx_am_action_item'
		SELECT '1' 
		 INTO :ls_flag  
		 FROM ctx_am_ai_notification  
		WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
				And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
				And doc_id = :al_doc_id And seq_id = :al_level_id1
				And alm_enabled = '1'  ;		
	Case Else
		SELECT '1' 
		 INTO :ls_flag  
		 FROM ctx_all_notification  
		WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
				And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
				And (ctx_id = :al_ctx_id)  And doc_id = :al_doc_id And level_id1 = :al_level_id1 And level_id2 = :al_level_id2
				And  alm_enabled = '1'  ;			
End Choose 


If Lower(as_table) =  'ctx_action_item' or  Lower(as_table) = 'ctx_am_action_item' Then
	ls_message = 'The system detects that the corresponding email alarm status of this date field is ~'Complete~'. '+&
						'Do you want to reset the email alarm’s Times Emailed to zero immediately?' +& 
						'~r~n~r~nClick ‘Yes’ to reset Times Emailed to zero. The system will restart sending email alarms based on the new date.' +&
						'~r~nClick ‘No’ if you don’t want to reset the alarm. The system will stop sending corresponding email alarms.' 
Else

	ls_message = 'The system detects that the corresponding email alarm status of this date field is ~'Complete~'. '+&
						'Do you want to reset the email alarm’s Times Emailed to zero immediately?' +& 
						'~r~n~r~nClick ‘Yes’ to reset Times Emailed to zero and delete the corresponding Action Items. The system will restart sending email alarms based on the new date.' +&
						'~r~nClick ‘No’ if you don’t want to reset the alarm. The system will stop sending corresponding email alarms.' 						
End If
If ls_flag = '1' Then

	If Messagebox('Email Alarm',ls_message, Question!, YesNo!) = 1 Then
		SetPointer(HourGlass!)
		Choose Case Lower(as_table)
			Case 'ctx_basic_info','ctx_custom'
				Update ctx_notification Set alm_total_tries_counter = null, alm_last_notification_sent = null, alm_last_wf_trigger = null
				 FROM ctx_notification  
				WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
						And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
						And (ctx_id = :al_ctx_id)  And alm_enabled = '1'  ;	
				gnv_data.of_retrieve( 'ctx_notification' )		
			Case 'ctx_action_item'
				Update ctx_ai_notification Set alm_total_tries_counter = null, alm_last_notification_sent = null, alm_last_wf_trigger = null
				WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
						And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
						And (ctx_id = :al_ctx_id)  And ctx_ai_notification.ctx_action_item_id = :al_level_id1
						And alm_enabled = '1'  ;	
				gnv_data.of_retrieve( 'ctx_ai_notification' )		
			Case 'ctx_am_action_item'
				Update ctx_am_ai_notification Set alm_total_tries_counter = null, alm_last_notification_sent = null, alm_last_wf_trigger = null
				WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
						And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
						And doc_id = :al_doc_id And seq_id = :al_level_id1
						And alm_enabled = '1'  ;		
				gnv_data.of_retrieve( 'ctx_am_ai_notification' )						
			Case Else
				Update ctx_all_notification Set alm_total_tries_counter = null, alm_last_notification_sent = null, alm_last_wf_trigger = null
				WHERE ( alm_table = :as_table ) AND  ( alm_column = :as_column ) 
						And alm_total_tries > 0 And alm_total_tries_counter = alm_total_tries 
						And (ctx_id = :al_ctx_id)  And doc_id = :al_doc_id And level_id1 = :al_level_id1 And level_id2 = :al_level_id2
						And  alm_enabled = '1'  ;	
				gnv_data.of_retrieve( 'ctx_all_notification' )						
		End Choose 		
		If Lower(as_table) =  'ctx_action_item' or  Lower(as_table) = 'ctx_am_action_item' Then		
			//No Action Item to be deleted.
		Else
			Delete From ctx_action_items Where  ctx_id = :al_ctx_id and doc_id = :al_doc_id and level_id1 = :al_level_id1 and level_id2 = :al_level_id2 and alm_table = :as_table and alm_column = :as_column;			
		End If
	Else
		Return 0
	End If
Else
	Return 0
End If


Return 1
end function

on n_cst_date_alarm.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_date_alarm.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

