$PBExportHeader$w_email_folder.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_email_folder from w_sheet
end type
type ole_mail_view from u_email_edit within w_email_folder
end type
type cb_selectback from commandbutton within w_email_folder
end type
type dw_search from u_dw_mail within w_email_folder
end type
type lv_attachment from u_lv_attachment within w_email_folder
end type
type st_v_bar2 from u_st_splitbar within w_email_folder
end type
type st_tip from statictext within w_email_folder
end type
type dw_drafts from u_dw_mail within w_email_folder
end type
type dw_favorite from u_dw_mail within w_email_folder
end type
type dw_history from u_dw_mail within w_email_folder
end type
type dw_recycle from u_dw_mail within w_email_folder
end type
type dw_inbox from u_dw_mail within w_email_folder
end type
type st_v_bar from u_st_splitbar within w_email_folder
end type
type tv_mail from u_tv within w_email_folder
end type
type cb_refresh from commandbutton within w_email_folder
end type
type rb_all from radiobutton within w_email_folder
end type
type rb_select from radiobutton within w_email_folder
end type
type st_split from u_st_splitbar within w_email_folder
end type
type cb_close from commandbutton within w_email_folder
end type
type dw_sent_items from u_dw_mail within w_email_folder
end type
type rte_header from richtextedit within w_email_folder
end type
type ole_1 from olecustomcontrol within w_email_folder
end type
end forward

global type w_email_folder from w_sheet
integer width = 4645
integer height = 1772
string title = "Email Manager"
windowstate windowstate = maximized!
long backcolor = 33551856
event type integer pfc_cst_receive ( string as_type )
event type integer pfc_cst_reply ( )
event type integer pfc_cst_reply_all ( )
event type integer pfc_cst_find ( )
event type integer pfc_cst_options ( )
event type integer pfc_cst_forward ( )
event type integer ue_rowfocuschanged ( datawindow adw_item,  long al_currentrow )
event ue_do_attachment ( string as_emlfile,  long al_mailid,  integer ai_index,  string as_dotype )
event pfc_cst_read ( integer ai_readstatus )
event pfc_cst_delete ( )
event pfc_cst_properties ( )
event pfc_cst_movetofolder ( integer ai_main_folder )
event pfc_cst_newmail ( )
event pfc_cst_lock ( integer ai_lockstatus )
event pfc_cst_checkin ( )
event pfc_cst_importmsg ( )
event type integer ue_change_ctx ( long al_ctx_id,  boolean ab_check_select,  boolean ab_show_message )
event pfc_cst_email_log ( )
event pfc_cst_reset_search ( )
event pfc_cst_refresh ( )
ole_mail_view ole_mail_view
cb_selectback cb_selectback
dw_search dw_search
lv_attachment lv_attachment
st_v_bar2 st_v_bar2
st_tip st_tip
dw_drafts dw_drafts
dw_favorite dw_favorite
dw_history dw_history
dw_recycle dw_recycle
dw_inbox dw_inbox
st_v_bar st_v_bar
tv_mail tv_mail
cb_refresh cb_refresh
rb_all rb_all
rb_select rb_select
st_split st_split
cb_close cb_close
dw_sent_items dw_sent_items
rte_header rte_header
ole_1 ole_1
end type
global w_email_folder w_email_folder

type variables
Integer ii_retrieve_type   //0: all, 1: Contract,2: Document Manager Action Item,3: Contract Action Item
Integer ii_folder_type 

String is_folder_name[] = {'Email Folders','Inbox','Sent Items','Drafts','Favorite Items','History Items','Deleted Items','Search Result'}
Long il_folder_data[] = {1,2,3,4,5,6,7,8}
Long il_folder_handle[]
Boolean ib_retrieved_all[] = {False,False,False,False,False,False,False,False}
Boolean ib_retrieved_single[] = {False,False,False,False,False,False,False,False}
Integer ii_current_retrieve_type[] = {-1,-1,-1,-1,-1,-1,-1,-1}  //0: all;  1: special CTX; -1: not retrieve
Integer ii_current_folder_id = -1
Long il_current_tv_handle = -1
Integer ii_current_main_folder_id = -1
Boolean ib_stop_show = False
u_dw_mail idw_folder_browse[] //Must set value in Open Event. = {dw_inbox,dw_inbox,dw_sent_items,dw_favorite,dw_history,dw_recycle}

Long il_current_disp_mail = -1 //current preview mail id for office control

n_cst_easymail_pop3 inv_em_pop3
n_cst_easymail_imap4 inv_em_imap4
n_cst_easymail_eamail inv_em_eamail

String is_sql_org
String is_current_doc_file = '',is_current_eml_file = ''

str_folder_handle istr_folder_handle[], istr_null[]

Long ii_timer_cnt,ii_timer = 10

Integer il_autoreceive_timer

Blob iblb_search

Long il_ctx_id, il_pre_ctx_id_from_search_tab
Boolean ib_opened = False

String is_purchase = "You did not purchase the Receive Email Module. To access this option please contact your sales representative at (866)371-4445 for more information."

String	is_Email_Protocol//added by gavins 20121120

Boolean ib_tdl_ctx = false  //(Appeon)Harry 09.10.2014 - for BugH070904
end variables

forward prototypes
public function blob of_downloadfile (long al_id)
public function integer of_build_mail_tv ()
public function integer of_set_folder (integer ai_folder_type)
public function integer of_get_retrieve_type ()
public subroutine of_retrieve_data_bak (integer ai_main_folder_id, long al_sub_folder_id, integer ai_retrieve_type)
public subroutine of_retrieve_data (integer ai_main_folder_id, long al_sub_folder_id, integer ai_retrieve_type)
public function integer of_get_main_folder_id (long al_folder_id)
public function integer of_refresh_data (integer ai_main_folder_id, long al_sub_folder_id)
public function integer of_open_word (integer ai_main_folder_id)
public function integer of_set_header (datawindow adw_item, long al_row)
public subroutine of_refresh_label ()
public subroutine of_clearall ()
public function integer of_add_sentitem (datastore ads_source)
public subroutine of_reset_timer ()
public function integer of_reset_attachui ()
public function integer of_reply_email (string as_replymode)
public subroutine of_check_menu ()
public function integer of_set_column_visible (integer ai_main_folder_id)
public subroutine of_reset_all ()
public function integer of_get_select_type ()
public function string of_create_empty_file ()
public subroutine of_refresh_ref_label ()
public function string of_get_empty_html ()
public subroutine of_set_options_visible (boolean ab_value)
public subroutine wf_change_emailprotocol ()
public subroutine of_adjust_position ()
end prototypes

event type integer pfc_cst_receive(string as_type);//If Not isvalid(m_pfe_cst_mail) Then Return -1
String			ls_protocol

If Not gb_contract_module And gi_email_type = 1 Then Return 0 //IC + Outlook - (BugA082103) Alfee 09.23.2013

If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' Then
	If as_type = 'auto' Then
		//Continue
	Else
		Messagebox('Email',is_purchase)
	End If
	Return 1
End If

/***************************************/ //added by gavins 20121120
Select  protocol Into  :ls_protocol
From em_smtp_accounts
Where user_id = :gs_user_id and is_default = 'Y';
If sqlca.sqlcode <> 0 Then
	Messagebox('Email','You do not have Email account yet, please config it first.')
	Return -1
End If

/***************************************/
If ls_protocol = 'POP3' Then
	If inv_em_pop3.is_status = inv_em_pop3.IS_PROCESSING OR inv_em_pop3.is_status = inv_em_pop3.IS_STOPING Then
		inv_em_pop3.of_stop_receive( )
		Return 1
	Else
		inv_em_pop3.is_status = inv_em_pop3.IS_PROCESSING
	End If
	
	inv_em_pop3.of_set_tip_object(st_tip)
	inv_em_pop3.of_set_inbox_dw(dw_inbox)
	
	If inv_em_pop3.of_connect_pop3(gs_user_id) < 0 Then
		inv_em_pop3.is_status = inv_em_pop3.IS_COMPLETE
		Return -1
	End If
	
	If  isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', True)
	End If
	inv_em_pop3.of_receive_emails(as_type)
	If Not Isvalid(This) Then Return -1  //because this window maybe closed when receiving email.
	
	If isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', False)
	End If
	
	If Not isvalid(This) Then Return 0
	
	If isvalid(inv_em_pop3) Then
		inv_em_pop3.of_disconnect_pop3()
	End If
ElseIf ls_protocol = 'IMAP4' Then//IMAP4
	If inv_em_imap4.is_status = inv_em_imap4.IS_PROCESSING OR inv_em_imap4.is_status = inv_em_imap4.IS_STOPING Then
		inv_em_imap4.of_stop_receive( )
		Return 1
	Else
		inv_em_imap4.is_status = inv_em_imap4.IS_PROCESSING
	End If
	
	inv_em_imap4.of_set_tip_object(st_tip)
	inv_em_imap4.of_set_inbox_dw(dw_inbox)
	
	If inv_em_imap4.of_connect_IMAP4(gs_user_id) < 0 Then
		inv_em_imap4.is_status = inv_em_imap4.IS_COMPLETE
		Return -1
	End If
	
	If  isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', True)
	End If
	inv_em_imap4.of_receive_emails(as_type)
	If Not Isvalid(This) Then Return -1  //because this window maybe closed when receiving email.
	
	If isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', False)
	End If
	
	If Not isvalid(This) Then Return 0
	
	If isvalid(inv_em_imap4) Then
		inv_em_imap4.of_disconnect_imap4()
	End If
Else//Exchange //Added By Ken.Guo 07/09/2013
	If inv_em_eamail.is_status = inv_em_eamail.IS_PROCESSING OR inv_em_eamail.is_status = inv_em_eamail.IS_STOPING Then
		inv_em_eamail.of_stop_receive( )
		Return 1
	Else
		inv_em_eamail.is_status = inv_em_eamail.IS_PROCESSING
	End If
	
	inv_em_eamail.of_set_tip_object(st_tip)
	inv_em_eamail.of_set_inbox_dw(dw_inbox)
	
	If inv_em_eamail.of_connect_ea(gs_user_id) < 0 Then
		inv_em_eamail.is_status = inv_em_eamail.IS_COMPLETE
		Return -1
	End If
	
	If  isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', True)
	End If
	inv_em_eamail.of_receive_emails(as_type)
	If Not Isvalid(This) Then Return -1  //because this window maybe closed when receiving email.
	
	If isvalid(m_pfe_cst_mail) Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', False)
	End If
	
	If Not isvalid(This) Then Return 0
	
	If isvalid(inv_em_eamail) Then
		inv_em_eamail.of_disconnect_ea()
	End If	
End If
	

//Added By Ken.Guo 2011-03-07.
If rb_select.checked and il_ctx_id > 0 Then
	This.event ue_change_ctx( il_ctx_id, True, False)
End If

of_refresh_label()

SetPointer(Arrow!)
Return 1
end event

event type integer pfc_cst_reply();of_reply_email('REPLY')
//
/*
Long ll_row,ll_mail_id
str_ctx_email lstr_ctx_email
Datawindow ldw_current

ldw_current = idw_folder_browse[ii_current_folder_id]
If ldw_current.RowCount() = 0 Then Return 0

ll_row = ldw_current.GetSelectedRow(0)
If ll_row =0 Then 
	Messagebox('Reply','Please select a mail item to reply.')
	Return 0
End If

lstr_ctx_email.doc_from = 'EMAIL'
ll_mail_id = ldw_current.GetItemNumber(ll_row,'id')
lstr_ctx_email.al_mail_id = ll_mail_id
lstr_ctx_email.as_mail_from = ldw_current.GetItemString(ll_row,'mail_from')
lstr_ctx_email.as_mail_to = ldw_current.GetItemString(ll_row,'mail_to')
lstr_ctx_email.as_mail_cc = ldw_current.GetItemString(ll_row,'mail_cc')
lstr_ctx_email.adt_mail_date = ldw_current.GetItemDateTime(ll_row,'mail_date')
lstr_ctx_email.ai_mail_importance = ldw_current.GetItemNumber(ll_row,'mail_importance')
lstr_ctx_email.as_mail_subject = ldw_current.GetItemString(ll_row,'mail_subject')
lstr_ctx_email.as_mail_attach_name = ldw_current.GetItemString(ll_row,'mail_attach_name')
lstr_ctx_email.al_mail_ctx_id = ldw_current.GetItemNumber(ll_row,'mail_ctx_id')
lstr_ctx_email.al_mail_doc_id = ldw_current.GetItemNumber(ll_row,'mail_doc_id')
lstr_ctx_email.al_mail_action_item_id = ldw_current.GetItemNumber(ll_row,'mail_action_item_id')
lstr_ctx_email.as_mail_save_format = ldw_current.GetItemString(ll_row,'mail_save_format')
lstr_ctx_email.as_mail_filename = inv_em_pop3.of_download_email( ll_mail_id, lstr_ctx_email.as_mail_save_format)
lstr_ctx_email.as_mail_reply_mode = 'REPLY'

lstr_ctx_email.ctx_id = lstr_ctx_email.al_mail_ctx_id
OpenwithParm(w_dm_email_document_send,lstr_ctx_email)
*/
Return  1
end event

event type integer pfc_cst_reply_all();of_reply_email('REPLYALL')
/*
Long ll_row,ll_mail_id
str_ctx_email lstr_ctx_email
Datawindow ldw_current

ldw_current = idw_folder_browse[ii_current_folder_id]
If ldw_current.RowCount() = 0 Then Return 0

ll_row = ldw_current.GetSelectedRow(0)
If ll_row =0 Then 
	Messagebox('Reply','Please select a mail item to reply.')
	Return 0
End If

lstr_ctx_email.doc_from = 'EMAIL'
ll_mail_id = ldw_current.GetItemNumber(ll_row,'id')
lstr_ctx_email.al_mail_id = ll_mail_id
lstr_ctx_email.as_mail_from = ldw_current.GetItemString(ll_row,'mail_from')
lstr_ctx_email.as_mail_to = ldw_current.GetItemString(ll_row,'mail_to')
lstr_ctx_email.as_mail_cc = ldw_current.GetItemString(ll_row,'mail_cc')
lstr_ctx_email.adt_mail_date = ldw_current.GetItemDateTime(ll_row,'mail_date')
lstr_ctx_email.ai_mail_importance = ldw_current.GetItemNumber(ll_row,'mail_importance')
lstr_ctx_email.as_mail_subject = ldw_current.GetItemString(ll_row,'mail_subject')
lstr_ctx_email.as_mail_attach_name = ldw_current.GetItemString(ll_row,'mail_attach_name')
lstr_ctx_email.al_mail_ctx_id = ldw_current.GetItemNumber(ll_row,'mail_ctx_id')
lstr_ctx_email.al_mail_doc_id = ldw_current.GetItemNumber(ll_row,'mail_doc_id')
lstr_ctx_email.al_mail_action_item_id = ldw_current.GetItemNumber(ll_row,'mail_action_item_id')
lstr_ctx_email.as_mail_save_format = ldw_current.GetItemString(ll_row,'mail_save_format')
lstr_ctx_email.as_mail_filename = inv_em_pop3.of_download_email( ll_mail_id, lstr_ctx_email.as_mail_save_format)
lstr_ctx_email.as_mail_reply_mode = 'REPLYALL'

lstr_ctx_email.ctx_id = lstr_ctx_email.al_mail_ctx_id
OpenwithParm(w_dm_email_document_send,lstr_ctx_email)
*/
Return  1
end event

event type integer pfc_cst_find();Integer li_log
String ls_sql
str_email_reply lstr_email


If il_ctx_id > 0 and rb_select.checked Then
	lstr_email.as_mail_ctx_id = String(il_ctx_id)
Else
	lstr_email.as_mail_ctx_id = '0'
End If
OpenWithParm(w_email_find,lstr_email)

ls_sql = Message.stringparm
If ls_sql = '' Then Return 0

SetPointer(HourGlass!)
st_tip.text = 'Search...'
If dw_search.SetSqlSelect( is_sql_org + ls_sql) <> 1 Then
	li_log = Integer(gnv_data.of_getItem("em_user_config", "email_log", False))
	If li_log <> 0 Then
		inv_em_pop3.of_log( '', 'Search Email(SetSqlSelect)', -1, is_sql_org + ls_sql)
	End If	
	Messagebox('Search','Failed to set the SQL to datawindow, please call support.')
	st_tip.text = ''
	Return 1
End If		

dw_search.SetTransObject(SQLCA)
If dw_search.Retrieve() = -1 Then
	li_log = Integer(gnv_data.of_getItem("em_user_config", "email_log", False))
	If li_log <> 0 Then
		inv_em_pop3.of_log( '', 'Search Email(Retrieve)', -1, is_sql_org + ls_sql)
	End If	
	Messagebox('Search','Failed to retrieve the data, '+ sqlca.sqlerrtext +' please call support.')
	st_tip.text = ''
	Return 1
End If

//---------Begin Modified by (Appeon)Toney 11.07.2013 for V141 ISG-CLX--------
//$Reason:
  /*
	tv_mail.Selectitem(8)
	tv_mail.event selectionchanged(8, 8)      
  */
tv_mail.Selectitem(il_folder_handle[8])
tv_mail.event selectionchanged(il_folder_handle[8], il_folder_handle[8])
//---------End Modfiied ------------------------------------------------------------------
of_refresh_label()
st_tip.text = 'Complete to Search.'
Return 1
end event

event type integer pfc_cst_options();If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' Then
	Messagebox('Email',is_purchase)
	Return 1
End If


OpenwithParm(w_em_user_config,gs_user_id)
Return 1
end event

event type integer pfc_cst_forward();of_reply_email('FORWARD')
return 1
end event

event type integer ue_rowfocuschanged(datawindow adw_item, long al_currentrow);Long ll_id,ll_doc_id,ll_data_length,i
String ls_email_type
String ls_email_file,ls_word_file,ls_html_file
String ls_attach_list
Integer li_fromclx //2: from old sent item
String ls_old_info

If idw_folder_browse[ii_current_main_folder_id] <> adw_item Then Return 0 //(Appeon)Harry 11.28.2013 - V141 for BugS111301 of Reintegration Issues

If al_currentrow > adw_item.RowCount() Then Return 0

if al_currentrow <= 0 then
	ole_mail_view.SetRedraw(false)
	of_clearall()
	of_reset_attachUI()
	ole_mail_view.SetRedraw(true)
	Return 0
end if

ll_id = adw_item.object.id[al_currentrow]
ll_doc_id = adw_item.object.mail_doc_id[al_currentrow]
If il_current_disp_mail = ll_id Then Return 1 

If ib_stop_show Then Return 1

ls_email_type = adw_item.Object.mail_save_format[al_currentrow]
ls_email_file = inv_em_pop3.of_download_email( ll_id, ls_email_type) 
If ls_email_file = '' Then
	SELECT Datalength(mail_rfc822) INTO :ll_data_length FROM em_mail_items WHERE id = :ll_id;
	If ll_data_length = 0 or isnull(ll_data_length) Then
		Messagebox('Error 1','Failed to download the email file because the email content is not saved to the database.')	
	Else
		Messagebox('Error 2','Failed to download the email file.')	
	End If
	Return -1
End If

//Added By Ken.Guo 12/12/2013
If Not FileExists(ls_email_file) Then
	Messagebox('Error 3','Failed to download the email file.')	
	Return -1
End If

ls_old_info = st_tip.text
st_tip.text = 'Opening...'
ole_mail_view.SetRedraw(false)
rte_header.SetRedraw(false)
lv_attachment.SetRedraw(False)
ole_1.SetRedraw(false)
ole_mail_view.of_close()

Choose Case ls_email_type
	Case 'eml' //EML format
	//	"EasyMail.Message.6"
		//ls_word_file = inv_em_pop3.of_eml2word(ll_id,ls_email_file)
		ls_html_file = inv_em_pop3.of_eml2html(ll_id,ls_email_file)
		is_current_eml_file = ls_email_file //Added By Ken.Guo 03/29/2013
		//is_current_eml_file = ls_email_file
		If FileExists(ls_html_file) Then
			//ole_mail_view.of_Open(ls_word_file,True)	
			//is_current_doc_file = ls_word_file
			ole_1.object.Navigate(ls_html_file)
			inv_em_pop3.of_setattachment(ll_id, ll_doc_id,ls_email_file,ls_attach_list,lv_attachment)
			
			//Added By Ken.Guo 07/31/2013
			If lv_attachment.TotalItems( ) > 0 And (adw_item.object.mail_attach_name[al_currentrow] = '' or isnull(adw_item.object.mail_attach_name[al_currentrow]) or adw_item.object.mail_attach_name[al_currentrow] = 'unnamed') Then
				adw_item.SetItem(al_currentrow,'mail_attach_name',ls_attach_list)
				adw_item.Update()
			End If
		Else
			//Return 
			is_current_doc_file = ''
			ls_email_file = ''
			//ole_mail_view.of_Open('Error! Failed to convert EML file to Word format.')	
			Messagebox('Error','Failed to convert EML file to Word format.')
		End If
	Case 'doc'  //Word format
		//ole_mail_view.of_Open(ls_email_file,True)	
		ls_html_file = inv_em_pop3.of_get_email_cachedir() + '\' + inv_em_pop3.of_get_Email_name(ll_id, 'htm')
		inv_em_pop3.of_doc2html( ls_email_file, ls_html_file)
		ole_1.object.Navigate(ls_html_file)
		is_current_eml_file = '' //EML file N/A
		is_current_doc_file = ls_email_file
		li_fromclx = adw_item.Object.mail_fromclx[al_currentrow]
		If li_fromclx = 2 Then
			ls_attach_list = ''
		Else
			ls_attach_list = adw_item.Object.mail_attach_name[al_currentrow]
		End If
		inv_em_pop3.of_setattachment(ll_id,ll_doc_id, '',ls_attach_list,lv_attachment)
	Case 'txt'  //txt format //Added By Ken.Guo 10/26/2012
		ole_1.object.Navigate(ls_email_file)
		is_current_eml_file = '' //EML file N/A
		is_current_doc_file = ls_email_file
		li_fromclx = adw_item.Object.mail_fromclx[al_currentrow]
		If li_fromclx = 2 Then
			ls_attach_list = ''
		Else
			ls_attach_list = adw_item.Object.mail_attach_name[al_currentrow]
		End If
		inv_em_pop3.of_setattachment(ll_id,ll_doc_id, '',ls_attach_list,lv_attachment)		
End Choose

Post of_check_menu() 

//
//ole_mail_view.object.ActiveDocument.ActiveWindow.View.Type = 6 //wdWebView
//ole_mail_view.object.ActiveDocument.ActiveWindow.DocumentMap = False
//
of_reset_attachUI()

il_current_disp_mail = ll_id

of_set_header(adw_item,al_currentrow)

ole_mail_view.SetRedraw(true)
rte_header.SetRedraw(true)
lv_attachment.SetRedraw(True)
ole_1.SetRedraw(True)
st_tip.text = ls_old_info

adw_item.Post SetFocus()

Return 1
end event

event ue_do_attachment(string as_emlfile, long al_mailid, integer ai_index, string as_dotype);String ls_exportfile
str_add_doc lstr_add_doc
Long ll_doc_id,ll_ctx_id
String ls_doc_name,ls_doc_ext,ls_checkout_status,ls_checkout_by,ls_revision_control
Decimal ldec_revision
Boolean lb_revision_control
Datawindow ldw_current
ListViewItem lvi_attach
PowerObject lpo_NullParm
n_cst_dm_utils 					lnv_dm_utils						//Added By Mark Lee 06/13/2013
Integer 							li_count
String 							ls_contract_name

//Open or SaveAs or Export(for check in) 
inv_em_pop3.of_do_attach(as_emlfile , al_mailid , ai_index,as_dotype,ls_exportfile)

ldw_current = idw_folder_browse[ii_current_main_folder_id]

ll_ctx_id = ldw_current.GetItemNumber(ldw_current.GetRow(),'mail_ctx_id')
ll_doc_id = ldw_current.GetItemNumber(ldw_current.GetRow(),'mail_doc_id')

ls_doc_ext = lnv_dm_utils.of_get_fileext( ls_exportfile )				//Added By Mark Lee 06/13/2013
ls_doc_ext = Lower(ls_doc_ext)
ls_doc_name = lnv_dm_utils.of_get_filename(ls_exportfile)			// only the name 
li_count = 0   

Choose Case Lower(as_dotype)
	Case 'checkin'  //Check In Attachment
		st_tip.text = 'Checking in...'
		SELECT	doc_name,   
					revision,   
					doc_ext,   
					checkout_by,   
					checkout_status,   
					revision_control 
		Into	:ls_doc_name,
				:ldec_revision,
				:ls_doc_ext,
				:ls_checkout_by,
				:ls_checkout_status,
				:ls_revision_control
		FROM ctx_am_document 
		WHERE doc_id = :ll_doc_id    ;
		
		If sqlca.sqlcode <> 0 Then
			Messagebox('Check In','Failed to check in the document, the target document might be deleted.')
			st_tip.text = ''
			Return 
		End if
		 
		If ls_revision_control = '1' Then
			lb_revision_control = True
		Else
			lb_revision_control = False		
		End If
		
		If ls_checkout_status = '0' Then 
			Messagebox('Check In','Can not be checked in, because the document has not been checked out,')
			st_tip.text = ''
			Return 
		End If
		
		If lower(ls_checkout_by) <> Lower(gs_user_id) Then
			Messagebox('Check In','You have no right to check in, because the document is checking out by another user.')
			st_tip.text = ''
			Return 	
		End If
		
		lstr_add_doc.ctx_id = ll_ctx_id
		lstr_add_doc.new = False
		lstr_add_doc.doc_id = ll_doc_id
		lstr_add_doc.revision = ldec_revision
		lstr_add_doc.Revision_control = lb_revision_control
		lstr_add_doc.doc_ext = ls_doc_ext
		lstr_add_doc.checkout_status = ls_checkout_status
		lstr_add_doc.filename = Mid(ls_exportfile, Lastpos(ls_exportfile,'\') + 1, Len(ls_exportfile))
		lstr_add_doc.doc_from = 'email_doc'
		lstr_add_doc.operation = 'checkin'
		lstr_add_doc.filepathname = ls_exportfile

		OpenwithParm(w_dm_checkin_document,lstr_add_doc)
		If Message.doubleparm = 1 Then
			If lv_attachment.GetItem(ai_index,lvi_attach) > 0 Then
				lvi_attach.pictureindex = 1
				lv_attachment.SetItem(ai_index,lvi_attach)
			End If
			of_check_menu()
			ldw_current.SetItem(ldw_current.GetRow(),'checkin_status',0)
			ldw_current.ResetUpdate()
			st_tip.text = 'Complete to Check In.'
			If Messagebox('Check In','Check In Successfully. Do you want to preview the document in the Document Manager now?',Question!,YesNo!) = 1 Then
				If Not isvalid(gw_contract) Then
					gf_OpenContractFolder(lpo_NullParm)
				End If
				Post gf_goto_contract(ll_ctx_id,'912',ll_doc_id, 0, 0,'' )				
			End If
		Else
			st_tip.text = ''
		End If
		
	Case 'copy'
		
	Case 'add to document-ctx', 'add to document-select ctx'					//Added By Mark Lee 06/10/2013
		IF  Lower(as_dotype) = 'add to document-ctx' Then 
			st_tip.text = "Add to Document Manager -- CTX " +string(ll_ctx_id)
		Else 
			OpenWithParm(w_mastert_contract_search,'ALL')
			ls_contract_name = message.stringparm  
			ll_ctx_id = long(mid(ls_contract_name,1,pos(ls_contract_name,'-') - 1))  
			If not isnull(ll_ctx_id)  and ll_ctx_id > 0 Then
				st_tip.text = "Add to Document Manager -- Select Contract " +string(ll_ctx_id)
			Else
				Return
			End If
		End If 
		Select count(1)
		Into :li_count
  		 From ctx_am_document  
   		where ctx_id = :ll_ctx_id and doc_name = :ls_doc_name
			and lower(doc_ext) = :ls_doc_ext ;
			
		If not isnull(li_count) and li_count > 0  then 
			li_count = Messagebox(gnv_app.iapp_object.DisplayName,"There is already a document with the same name in the Document Manager for CTX_ID "+String(ll_ctx_id)+".~r~n~r~n Do you want to continue? ",Information!, YesNo! )
			IF li_count <> 1 then 
				st_tip.text = ''
				Return 
			End If
		End IF 
		
		lstr_add_doc.new = TRUE
		lstr_add_doc.ctx_id = ll_ctx_id
		lstr_add_doc.doc_id = 0
		//
		lstr_add_doc.revision = 1.0
		lstr_add_doc.Revision_control = False
		lstr_add_doc.doc_ext = ls_doc_ext
//		lstr_add_doc.filename = Mid(ls_exportfile, Lastpos(ls_exportfile,'\') + 1, Len(ls_exportfile))
		lstr_add_doc.filename = ls_doc_name
		lstr_add_doc.doc_from = 'email_doc'
		lstr_add_doc.operation = 'add to document'
		lstr_add_doc.filepathname = ls_exportfile
		
		OpenWithParm(w_dm_buy_document, lstr_add_doc)
		IF Message.Doubleparm > 0 THEN
			Messagebox(gnv_app.iapp_object.DisplayName,"Document is successfully added to the Document Manager for CTX_ID "+String(ll_ctx_id)+"." )
		End IF 
		st_tip.text = ''
End Choose


end event

event pfc_cst_read(integer ai_readstatus);Long ll_row,ll_rowlist[]
u_dw_mail ldw_mail
If ii_current_main_folder_id <= 1 Then Return
ldw_mail = idw_folder_browse[ii_current_main_folder_id]

ll_row = ldw_mail.GetSelectedRow(0)
If ll_row <= 0 Then Return 

If ai_readstatus = 1 Then
	st_tip.text = 'Setting Read Status...'
Else
	st_tip.text = 'Setting Unread Status...'
End If
Do While ll_row > 0
	ll_rowlist[UpperBound(ll_rowlist[]) + 1 ] = ll_row
	If ldw_mail.GetItemNumber(ll_row,'read_status') = ai_readstatus Then 
		ll_row = ldw_mail.GetSelectedRow(ll_row)
		Continue
	End If
	ldw_mail.SetItem(ll_row,'read_status',ai_readstatus)
	ll_row = ldw_mail.GetSelectedRow(ll_row)
Loop

If ldw_mail.Modifiedcount( ) > 0 Then
	If ldw_mail.update() <> 1 Then
		Messagebox('Save Error','Failed to mark as read, please refresh the data then try again.')
	End If
	of_refresh_label()
End If

If ai_readstatus = 1 Then
	st_tip.text = 'Complete to Set Read Status.'
Else
	st_tip.text = 'Complete to Set Unread Status.'
End If

return
end event

event pfc_cst_delete();Long ll_row,ll_rowlist[],i
Boolean lb_exists_locked
u_dw_mail ldw_mail
If ii_current_main_folder_id <= 1 Then Return
ldw_mail = idw_folder_browse[ii_current_main_folder_id]

ll_row = ldw_mail.GetSelectedRow(0)
If ll_row <= 0 Then Return 

st_tip.text = 'Deleting...'
If ii_current_main_folder_id = 7 or KeyDown(KeyShift!) Then //7: Recycle(delete items) 
	If MessageBox('Delete','Are you sure that you want to permanently delete the selected item(s)?',Question!,YesNo!) = 2 Then 
		st_tip.text = ''
		Return 
	End If
	Do While ll_row > 0
		If ldw_mail.GetItemnumber(ll_row,'locked') = 1 Then
			lb_exists_locked = True
			ll_row = ldw_mail.GetSelectedRow(ll_row)
			Continue
		End If	
		ldw_mail.DeleteRow(ll_row)
		ll_row = ldw_mail.GetSelectedRow(ll_row - 1)
	Loop
	If ldw_mail.Deletedcount( ) > 0 Then
		If ldw_mail.update() <> 1 Then
			Messagebox('Save Error','Failed to delete the Email items in the Recycle, please refresh the data then try again.')
			st_tip.text = ''
			Return
		End If
	End If
Else //Other folder
	//---------Begin Added by (Appeon)Alfee 07.25.2013 for V141 ISG-CLX--------
	If Not gb_contract_module And gi_email_type = 1 Then //IC + Outlook
		If MessageBox('Delete','Are you sure that you want to delete the selected item(s)?',Question!,YesNo!) = 2 Then 
			st_tip.text = ''
			Return 
		End If
	End If
	//---------End Added ------------------------------------------------------------------
	
	Do While ll_row > 0
		If ldw_mail.GetItemnumber(ll_row,'locked') = 1 Then
			lb_exists_locked = True
			ll_row = ldw_mail.GetSelectedRow(ll_row)
			Continue
		End If	
		ll_rowlist[UpperBound(ll_rowlist[]) + 1 ] = ll_row
		ldw_mail.SetItem(ll_row,'deleted',1)
		ll_row = ldw_mail.GetSelectedRow(ll_row)
	Loop
	
	If ldw_mail.Modifiedcount( ) = 0 Then 
		If lb_exists_locked Then
			Messagebox('Delete Tips','The locked Email item(s) can not be deleted. if you want to delete it, please mark it as unclock first.')
		End If	
		st_tip.text = ''
		Return 
	End If
	
	If ldw_mail.update() <> 1 Then
		Messagebox('Save Error','Failed to move the Email item(s) to the Recycle Bin, please refresh the data then try again.')
		st_tip.text = ''
		Return
	End If
	
	ib_stop_show = True 
	For i = UpperBound(ll_rowlist[]) to 1 Step -1
		ldw_mail.RowsDiscard(ll_rowlist[i],ll_rowlist[i],Primary!)
		//ldw_mail.RowsMove(ll_rowlist[i],ll_rowlist[i],Primary!,idw_folder_browse[7],1,Primary!)
		//idw_folder_browse[7].SetItemStatus(1,0,Primary!,Notmodified!)
	Next
	ib_stop_show = False
	
//	If Not ib_retrieved_all[7] and Not ib_retrieved_single[7] Then idw_folder_browse[7].Reset()
	idw_folder_browse[7].Reset()
	ib_retrieved_all[7] = False
	ib_retrieved_single[7] = False
	ii_current_retrieve_type[7] = -1
End If

of_refresh_label()

//Locate next row
If ldw_mail.GetRow() > 0 Then
	ll_row = ldw_mail.getselectedrow(0)
	If ll_row > 0 Then
		event ue_rowfocuschanged(ldw_mail, ll_row) //because maybe selected multi-row. need high-light yet.
	Else
		ldw_mail.event rowfocuschanged(ldw_mail.getrow()) //High-light one row
	End If
Else
	of_clearall()
End If

st_tip.text = 'Complete to Delete.'

If lb_exists_locked Then
	Messagebox('Delete Tips','The locked Email item(s) can not be deleted. If you want to delete it, please mark it as unclock first.')
End If

Return
end event

event pfc_cst_properties();Messagebox('Developing','Properties')
end event

event pfc_cst_movetofolder(integer ai_main_folder);Datawindow ldw_mail
Boolean lb_exists_locked
Long ll_row,i
long ll_rowlist[]

If ai_main_folder = 7 Then
	This.event pfc_cst_delete( )
	Return 
End If

ldw_mail = idw_folder_browse[ii_current_main_folder_id]
ll_row = ldw_mail.GetSelectedRow(0)
If ll_row = 0 Then Return

st_tip.text = 'Moving...'
Do While ll_row > 0
	ll_rowlist[UpperBound(ll_rowlist[]) + 1 ] = ll_row
	ldw_mail.SetItem(ll_row,'folder_id',ai_main_folder)
	ldw_mail.SetItem(ll_row,'sub_folder_id',ai_main_folder)	
	If ii_current_main_folder_id = 7 Then
		ldw_mail.SetItem(ll_row,'deleted',0)
	End If
	ll_row = ldw_mail.GetSelectedRow(ll_row)
Loop

If ldw_mail.Modifiedcount( ) = 0 Then 
	If lb_exists_locked Then
		Messagebox('Delete Tips','The locked Email item(s) can not be deleted. if you want to delete it, please mark it as unclock first.')
	End If
	st_tip.text = ''
	Return 
End If

If ldw_mail.update() <> 1 Then
	Messagebox('Save Error','Failed to move the Email items to the Recycle Bin, please refresh the data then try again.')
	st_tip.text = ''
	Return
End If

ib_stop_show = True 
For i = UpperBound(ll_rowlist[]) to 1 Step -1
	ldw_mail.RowsDiscard(ll_rowlist[i],ll_rowlist[i],Primary!)
	//ldw_mail.RowsMove(ll_rowlist[i],ll_rowlist[i],Primary!,idw_folder_browse[ai_main_folder],1,Primary!)
	//idw_folder_browse[ai_main_folder].SetItemStatus(1,0,Primary!,Notmodified!)
Next
ib_stop_show = False
//If Not ib_retrieved_all[ai_main_folder] and Not ib_retrieved_single[ai_main_folder] Then idw_folder_browse[ai_main_folder].Reset()
idw_folder_browse[ai_main_folder].Reset()
ib_retrieved_all[ai_main_folder] = False
ib_retrieved_single[ai_main_folder] = False
ii_current_retrieve_type[ai_main_folder] = -1

of_refresh_label()

//Locate next row
If ldw_mail.GetRow() > 0 Then
	ll_row = ldw_mail.getselectedrow(0)
	If ll_row > 0 Then
		event ue_rowfocuschanged(ldw_mail, ll_row) //because maybe selected multi-row. need high-light yet.
	Else
		ldw_mail.event rowfocuschanged(ldw_mail.getrow()) //High-light one row
	End If
Else
	of_clearall()
End If

st_tip.text = 'Complete to Move.'
end event

event pfc_cst_newmail();//Open(w_general_email_send)
str_ctx_email lstr_ctx_email

If rb_select.checked Then
	lstr_ctx_email.ctx_id = il_ctx_id
Else
	lstr_ctx_email.ctx_id = 0
End If
lstr_ctx_email.doc_from = 'EMAIL'
lstr_ctx_email.as_mail_reply_mode = 'NEW'

//---------Begin Added by (Appeon)Alfee 09.17.2013 for V141 ISG-CLX--------
If Not gb_contract_module Then 
	OpenWithParm( w_dm_email_document_send_ic, lstr_ctx_email)
	Return
End If
//---------End Added ------------------------------------------------------------------

OpenWithParm( w_dm_email_document_send, lstr_ctx_email)
end event

event pfc_cst_lock(integer ai_lockstatus);Long ll_row,ll_rowlist[]
u_dw_mail ldw_mail
If ii_current_main_folder_id <= 1 Then Return
ldw_mail = idw_folder_browse[ii_current_main_folder_id]

ll_row = ldw_mail.GetSelectedRow(0)
If ll_row <= 0 Then Return 

If ai_lockstatus = 1 Then
	st_tip.text = 'Setting Lock Status...'
Else
	st_tip.text = 'Setting Unlock Status...'
End If

Do While ll_row > 0
	ll_rowlist[UpperBound(ll_rowlist[]) + 1 ] = ll_row
	If ldw_mail.GetItemNumber(ll_row,'locked') = ai_lockstatus Then 
		ll_row = ldw_mail.GetSelectedRow(ll_row)
		Continue
	End If
	ldw_mail.SetItem(ll_row,'locked',ai_lockstatus)
	ll_row = ldw_mail.GetSelectedRow(ll_row)
Loop

If ldw_mail.Modifiedcount( ) > 0 Then
	If ldw_mail.update() <> 1 Then
		Messagebox('Save Error','Failed to mark as lock, please refresh the data then try again.')
	End If
	of_refresh_label()
End If

If ai_lockstatus = 1 Then
	st_tip.text = 'Complete to Set Lock Status.'
Else
	st_tip.text = 'Complete to Set Unlock Status.'
End If
return
end event

event pfc_cst_checkin();//inv_em_pop3.of_do_attach(as_emlfile , al_mailid , ai_index,'export')

Integer li_cnt,i
ListViewItem llvi_attach
li_cnt = lv_attachment.totalitems()
If li_cnt < 0 Then 
	Messagebox('Check In','No document can be checked in.')
	Return 
End If

For i = 1 To li_cnt
	lv_attachment.GetItem(i,llvi_attach)
	If llvi_attach.pictureindex = 2 Then
		llvi_attach.Selected = True
		This.event ue_do_attachment(is_current_eml_file, il_current_disp_mail, i, 'checkin')		
		Return
	End If
Next

st_tip.text = 'No document can be checked in.'



Return 
end event

event pfc_cst_importmsg();str_import_msg lstr_import_msg

lstr_import_msg.al_folder_id = ii_current_main_folder_id
lstr_import_msg.al_sub_folder_id = ii_current_main_folder_id
//Added By Mark Lee 07/04/2013
If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.Selectedtab = 12 Then 
		IF isvalid(w_contract_email_folder) and il_ctx_id > 0 then	  
			lstr_import_msg.al_ctx_id = 	il_ctx_id
		End If
	End If
End If 
inv_em_pop3.of_import_msg(lstr_import_msg )


/*
str_import_msg lstr_msg
Integer li_importtance,li_readed
String ls_filename,ls_from,ls_to,ls_cc,ls_bcc
String ls_subject, ls_bodydocfile, ls_attachlist[]
Datetime ldt_date

OpenWithParm(w_em_import_msg,lstr_msg)

If Message.powerobjectparm.classname() <> 'str_import_msg' Then
	Return 
End If
lstr_msg = Message.powerobjectparm 

If lstr_msg.as_filename = '' Then
	Return
End If

//istr_import_msg.al_ctx_id = dw_1.GetItemNumber(1,'ctx_id')

If lstr_msg.as_filename <> '' Then
	If FileExists(lstr_msg.as_filename) Then
		If inv_em_pop3.of_parse_msg(lstr_msg.as_filename, ls_from, ls_to, ls_cc, ls_bcc, ls_subject, ls_bodydocfile, ldt_date, li_importtance, ls_attachlist[],li_readed) > 0 Then
			If inv_em_pop3.of_save_msg( lstr_msg.al_folder_id, lstr_msg.al_sub_folder_id, ls_subject, ls_bodydocfile, li_importtance, ls_from, ls_to, ls_cc, ls_attachlist[], ldt_date, li_readed, lstr_msg.al_ctx_id, lstr_msg.al_doc_id, lstr_msg.al_ai_id ) > 0 Then
				//Refresh
			End If
		End If
	Else
		Messagebox('Import','Failed to Paste the email file.')
		Return 
	End If
End If
*/


end event

event type integer ue_change_ctx(long al_ctx_id, boolean ab_check_select, boolean ab_show_message);If al_ctx_id = 0 Then Return 0

If ab_check_select Then
	If This.of_get_select_type( ) = 0 Then 
		Return 0//Only Selected Contract RadioButton has been check, then do it.
	End If
End If

Integer li_ret
If ab_show_message and il_ctx_id <> 0 Then
	This.Bringtotop = True
	li_ret = Messagebox('Email','Display emails associated with Contract #' + String(al_ctx_id) + '?',Question!,yesno!) 
	If li_ret = 2 Then Return 1
End If

of_reset_all()
rb_select.enabled = True
rb_select.checked = True
rb_all.enabled = True
rb_all.checked = False
ii_retrieve_type = 1
il_ctx_id = al_ctx_id
of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,ii_retrieve_type)

il_pre_ctx_id_from_search_tab = al_ctx_id

Return 1
end event

event pfc_cst_email_log();Open(w_email_audit)
Return 
//
//If Isvalid(w_email_audit) Then
//	w_email_audit.BringtoTop = True
//	w_email_audit.WindowState = Normal!
//Else
//	//OpenSheet(w_email_audit, w_mdi, 4, original!) 
//	Open(w_email_audit)
//End If
//
end event

event pfc_cst_reset_search();//Reset Search Result
idw_folder_browse[8].Reset()


end event

event pfc_cst_refresh();//====================================================================
// Event: pfc_cst_refresh
//--------------------------------------------------------------------
// Description: move from cb_refresh clicked event()
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/07/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
 
ib_retrieved_all[ii_current_main_folder_id] = False
ib_retrieved_single[ii_current_main_folder_id] = False
ii_current_retrieve_type[ii_current_main_folder_id] = -1
 
idw_folder_browse[ii_current_main_folder_id].SetRedraw(False) 
If rb_all.checked then
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,0)
Else
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,ii_retrieve_type)
END IF
idw_folder_browse[ii_current_main_folder_id].SetRedraw(True) 
end event

public function blob of_downloadfile (long al_id);blob lb_data
blob lb_all_data
long ll_data_length
long ll_start
long ll_counter
long ll_loops

If gs_dbtype = "ASA" Or appeongetclienttype() <> 'PB' Then
	SELECTBLOB mail_rfc822 INTO :lb_all_data
	FROM em_mail_items
	WHERE id = :al_id;
Else
	SELECT DataLength(mail_rfc822) INTO :ll_data_length
	FROM em_mail_items
	WHERE id = :al_id;
	
	If isnull(ll_data_length) Then ll_data_length = 0
	
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			ll_loops = ll_data_length / 8000 
		Else
			ll_loops = (ll_data_length / 8000) + 1
		End If 
	ElseIf ll_data_length > 0 Then 
		ll_loops = 1 
	End If 
	
	For ll_counter = 1 To ll_loops			
		ll_start = (ll_counter - 1) * 8000 + 1
		SELECTBLOB substring(mail_rfc822,:ll_start,8000) INTO :lb_data
		FROM em_mail_items
		WHERE id = :al_id;
		lb_all_data += lb_data
	Next
End If
If isnull(lb_all_data) Then lb_all_data = blob('')

Return lb_all_data
end function

public function integer of_build_mail_tv ();treeviewitem litv_root,litv_child
Integer i

tv_mail.PictureHeight = 32
For i = 1 To UpperBound(is_folder_name[])
	//---------Begin Added by (Appeon)Alfee 07.25.2013 for V141 ISG-CLX--------
	il_folder_handle[i] = -1
	If Not gb_contract_module And gi_email_type = 1 Then //IC + Outlook
		If i <> 1 And i <> 3 And i <> 8 Then Continue 
	End If
	//---------End Added ------------------------------------------------------------------
	litv_child.label =  is_folder_name[i]
	litv_child.data = il_folder_data[i]
	If i = 1 Then
		litv_child.children = True
	Else
		litv_child.children = False
	End If
	litv_child.pictureindex = il_folder_data[i]
	litv_child.selectedpictureindex = il_folder_data[i]
	If i = 1 Then
		il_folder_handle[i] = tv_mail.insertitemlast(0,litv_child)	
	Else
		il_folder_handle[i] = tv_mail.insertitemlast(il_folder_handle[1],litv_child)	
	End If
Next

tv_mail.expandall(il_folder_handle[1])
If Not gb_contract_module And gi_email_type = 1 Then Return 1//IC + Outlook - (Appeon)Alfee 07.25.2013 for V141 ISG-CLX

tv_mail.Deleteitem(4) //Delete Draft items.
Return 1


/*
tv_mail.PictureHeight = 32
litv_root.label = 'Email Folders'
litv_root.data = 1
litv_root.children = true
litv_root.pictureindex =1
litv_root.selectedpictureindex = 1
il_home_handle = tv_mail.insertitemlast(0,litv_root)

litv_child.label =  'Inbox'
litv_child.data = 2
litv_child.children = False
litv_child.pictureindex = 2
litv_child.selectedpictureindex = 2
il_inbox_handle = tv_mail.insertitemlast(il_home_handle,litv_child)		

litv_child.label =  'Sent Items'
litv_child.data = 3
litv_child.children = False
litv_child.pictureindex = 3
litv_child.selectedpictureindex = 3
il_senditem_handle = tv_mail.insertitemlast(il_home_handle,litv_child)	

litv_child.label =  'History Items'
litv_child.data = 4
litv_child.children = False
litv_child.pictureindex = 4
litv_child.selectedpictureindex = 4
il_recycle_handle = tv_mail.insertitemlast(il_home_handle,litv_child)	

litv_child.label =  'Deleted Items'
litv_child.data = 5
litv_child.children = False
litv_child.pictureindex = 5
litv_child.selectedpictureindex = 5
il_recycle_handle = tv_mail.insertitemlast(il_home_handle,litv_child)	
*/

end function

public function integer of_set_folder (integer ai_folder_type);Integer i
If ai_folder_type <= 1 or ai_folder_type > UpperBound(idw_folder_browse[]) Then Return 0

For i = 1 to UpperBound(idw_folder_browse[])
	idw_folder_browse[i].Visible = False
Next
idw_folder_browse[ai_folder_type].visible = True

Return 1
/*
dw_inbox.visible = False
dw_sent_items.visible = False
dw_recycle.visible = False
Choose Case ai_folder_type
	Case 1
		//Home
	Case 2
		dw_inbox.visible = True
	Case 3
		dw_sent_items.visible = True
	Case 4
		dw_recycle.visible = True
End Choose

Return 1

*/
end function

public function integer of_get_retrieve_type ();If rb_all.checked Then
	Return 0
Else
	Return ii_retrieve_type
End If

end function

public subroutine of_retrieve_data_bak (integer ai_main_folder_id, long al_sub_folder_id, integer ai_retrieve_type);//long	ll_ctx_id,ll_doc_id,ll_action_item_id
//long	i,ll_count
//long	ll_row,ll_findrow
//String ls_sql
//
//SetPointer(HourGlass!)
//if ai_retrieve_type=0 then	
//	//Added By Ken.Guo 2009-05-20.
//	//cbx_all.Checked = True   
//	If ib_retrieved_sent_all = False Then
//		dw_sent_items.Dataobject = 'd_em_items'
//		dw_sent_items.SetTransObject(SQLCA)
//		ls_sql = dw_sent_items.getsqlselect( )
//		ls_sql += " Where em_mail_items.user_id = '" + gs_user_id + "'"
//		If dw_sent_items.SetSQLSelect(ls_sql) <> 1 Then
//			Messagebox('Error','Failed to create datawindow, please call support.')
//			Return 
//		End If		
//		
//		dw_sent_items.SetTransObject(SQLCA)
//		dw_sent_items.SetRedraw(False)
//		dw_sent_items.Retrieve(gs_user_id)
//		dw_sent_items.SetRedraw(True)
//		ib_retrieved_sent_all = True
//	End If	
//	dw_sent_items.setfilter("")
//	dw_sent_items.filter()
//	ib_retrieved_sent_all = True
//else
//	ll_ctx_id=w_contract.tab_contract_details.tabpage_search.dw_search_det1.getitemdecimal(w_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow(),"ctx_id")
//	if isnull(ll_ctx_id) then return	//jervis 04.13.2009
//	rb_select.text = 'Selected Contract - '+String(ll_ctx_id)
//	
//	If ib_retrieved_sent_all Then
//		dw_sent_items.setfilter("mail_ctx_id="+string(ll_ctx_id)	)
//		dw_sent_items.filter()
//	Else
//		If ib_retrieved_sent_single Then
//			//
//		Else
//			dw_sent_items.dataobject = 'd_em_items'
//			dw_sent_items.SetTransObject(SQLCA)
//			ls_sql = dw_sent_items.getsqlselect( )
//			ls_sql += " Where em_mail_items.user_id = '"+ gs_user_id +"'" + " And em_mail_items.mail_ctx_id = " + String(ll_ctx_id)
//			If dw_sent_items.SetSQLSelect(ls_sql) <> 1 Then
//				Messagebox('Error','Failed to create datawindow, please call support.')
//				Return 
//			End If
//			dw_sent_items.SetTransObject(SQLCA)
//			dw_sent_items.SetRedraw(False)
//			dw_sent_items.Retrieve(gs_user_id)
//			dw_sent_items.setfilter("")
//			dw_sent_items.filter()	
//			dw_sent_items.SetRedraw(True)
//			ib_retrieved_sent_single = True
//		End If
//	End If
//	
//	ll_count=dw_sent_items.rowcount()
//	if ai_retrieve_type=2 then	//Document manager Action Item
//		ll_row=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getrow()
//		if ll_row=0 then return
//		ll_doc_id=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getitemdecimal(ll_row,'doc_id')
//		ll_action_item_id=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getitemdecimal(ll_row,'seq_id')
//		if isnull(ll_doc_id) or isnull(ll_action_item_id) then return   //jervis 04.13.2009
//		ll_findrow=dw_sent_items.find("mail_doc_id="+string(ll_doc_id)+" and mail_action_item_id="+string(ll_action_item_id),1,ll_count)
//		if ll_findrow>0 then
//			dw_sent_items.scrolltorow(ll_findrow)
//			dw_sent_items.selectrow(0,false)
//			dw_sent_items.selectrow(ll_findrow,true)
//		end if
//	elseif ai_retrieve_type=3 then
//		ll_row=w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.getrow()
//		if ll_row=0 then return
//		ll_action_item_id=w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.getitemdecimal(ll_row,'ctx_action_item_id')
//		if isnull(ll_action_Item_id) then return  //jervis 04.13.2009
//		//ll_findrow=dw_sent_items.find("doc_id="+string(ll_doc_id)+" and action_item_id="+string(ll_action_item_id),1,ll_count)
//		ll_findrow=dw_sent_items.find("mail_ctx_id="+string(ll_ctx_id)+" and mail_action_item_id="+string(ll_action_item_id),1,ll_count)
//		if ll_findrow>0 then
//			dw_sent_items.scrolltorow(ll_findrow)
//			dw_sent_items.selectrow(0,false)
//			dw_sent_items.selectrow(ll_findrow,true)
//		end if
//	end if	
//end if
//
//dw_sent_items.event rowfocuschanged(dw_sent_items.GetRow()) //Added
//
return 
end subroutine

public subroutine of_retrieve_data (integer ai_main_folder_id, long al_sub_folder_id, integer ai_retrieve_type);//ai_retrieve_type:1-Contract,2-Document Manager Action Item,3-Contract Action Item

long	ll_doc_id,ll_action_item_id
long	i,ll_count
long	ll_row,ll_findrow
String ls_sql

If ai_main_folder_id <= 1 Then Return
IF ii_current_main_folder_id = 8 Then Return //Search Folder

If ii_current_retrieve_type[ai_main_folder_id] = of_get_retrieve_type() Then Return

SetPointer(HourGlass!)
if ai_retrieve_type=0 then	//Show ALL Email of any contracts
	If ib_retrieved_all[ai_main_folder_id] = False Then
		//idw_folder_browse[ai_main_folder_id].Dataobject = 'd_em_items'
		//idw_folder_browse[ai_main_folder_id].SetTransObject(SQLCA)
		//ls_sql = idw_folder_browse[ai_main_folder_id].getsqlselect( )
		IF ai_main_folder_id <> 7 Then
			ls_sql = is_sql_org + " Where em_mail_items.user_id = '" + gs_user_id + "' And folder_id = " + String(ai_main_folder_id) + ' And deleted <> 1 '
		Else
			//Deleted Items
			ls_sql = is_sql_org + " Where em_mail_items.user_id = '" + gs_user_id + "'" + ' And deleted = 1 '
		End If
		If idw_folder_browse[ai_main_folder_id].SetSQLSelect(ls_sql) <> 1 Then
			Messagebox('Error','Failed to create datawindow, please call support.')
			Return 
		End If		
		
		idw_folder_browse[ai_main_folder_id].SetTransObject(SQLCA)
		idw_folder_browse[ai_main_folder_id].Retrieve(gs_user_id)
		ib_retrieved_all[ai_main_folder_id] = True
	End If	
	IF ai_main_folder_id <> 7 Then
		idw_folder_browse[ai_main_folder_id].setfilter("sub_folder_id = " + String(al_sub_folder_id))
	Else
		idw_folder_browse[ai_main_folder_id].setfilter("")
	End If
	idw_folder_browse[ai_main_folder_id].filter()

else
	if isnull(il_ctx_id) or il_ctx_id = 0 then 
		return	
	End If
	rb_select.text = 'Selected Contract - '+String(il_ctx_id)
	cb_selectback.Text = 'Back To Contract  ' + String( il_ctx_id )  //added by gavin 20111220
		
	If ib_retrieved_all[ai_main_folder_id] Then
		IF ai_main_folder_id <> 7 Then
			idw_folder_browse[ai_main_folder_id].setfilter("(mail_ctx_id = "+string(il_ctx_id) + " Or Pos(','+ctx_id_list+',' , ',"+String(il_ctx_id)+",') > 0 " + ") And sub_folder_id = " + String(al_sub_folder_id)	)
		Else
			//Deleted Items
			idw_folder_browse[ai_main_folder_id].setfilter("(mail_ctx_id = "+string(il_ctx_id) + " Or Pos(','+ctx_id_list+',' , ',"+String(il_ctx_id)+",') > 0 " + ")")
		End If
		
		idw_folder_browse[ai_main_folder_id].filter()
	Else
		If ib_retrieved_single[ai_main_folder_id] Then
			//
		Else
			IF ai_main_folder_id <> 7 Then
				//or CharIndex(',126,',','+ctx_id_list + ',') > 0
				ls_sql = is_sql_org + " Where em_mail_items.user_id = '"+ gs_user_id +"'" + " And (em_mail_items.mail_ctx_id = " + String(il_ctx_id) + " or CharIndex(',"+String(il_ctx_id)+",' , ','+ctx_id_list + ',') > 0  "+ ") And folder_id = " + String(ai_main_folder_id) + "  And deleted <> 1 "
			Else
				//Deleted Items
				ls_sql = is_sql_org + " Where em_mail_items.user_id = '"+ gs_user_id +"'" + " And (em_mail_items.mail_ctx_id = " + String(il_ctx_id) + " or CharIndex(',"+String(il_ctx_id)+",' , ','+ctx_id_list + ',') > 0  "+ ") And deleted = 1 "
			End If
			If idw_folder_browse[ai_main_folder_id].SetSQLSelect(ls_sql) <> 1 Then
				Messagebox('Error','Failed to create datawindow, please call support.')
				Return 
			End If
			idw_folder_browse[ai_main_folder_id].SetTransObject(SQLCA)
			idw_folder_browse[ai_main_folder_id].Retrieve(gs_user_id)
			IF ai_main_folder_id <> 7 Then
				idw_folder_browse[ai_main_folder_id].setfilter("sub_folder_id = " + String(al_sub_folder_id))
			Else
				idw_folder_browse[ai_main_folder_id].setfilter("")	
			End If				
			idw_folder_browse[ai_main_folder_id].filter()	

			ib_retrieved_single[ai_main_folder_id] = True
		End If
	End If
	
	ll_count=idw_folder_browse[ai_main_folder_id].rowcount()
	
	//Added By Ken.Guo 04/18/2013. To workaround APB Bug. in the web it has not trigger rowfocuschanged event when the rowcount is zero.
	If ll_count = 0 and AppeonGetClientType() = 'WEB' Then
		idw_folder_browse[ai_main_folder_id].event rowfocuschanged(0) //Added By Ken.Guo 2009-05-22.
	End If
	
	if ai_retrieve_type=2 then	//Document manager Action Item
		ll_row=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getrow()
		if ll_row=0 then 
			return
		End If
		ll_doc_id=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getitemdecimal(ll_row,'doc_id')
		ll_action_item_id=w_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.tab_1.tabpage_detail.dw_detail.getitemdecimal(ll_row,'seq_id')
		if isnull(ll_doc_id) or isnull(ll_action_item_id) then 
			return   
		End If
		ll_findrow=idw_folder_browse[ai_main_folder_id].find("mail_doc_id="+string(ll_doc_id)+" and mail_action_item_id="+string(ll_action_item_id),1,ll_count)
		if ll_findrow>0 then
			idw_folder_browse[ai_main_folder_id].scrolltorow(ll_findrow)
			idw_folder_browse[ai_main_folder_id].selectrow(0,false)
			idw_folder_browse[ai_main_folder_id].selectrow(ll_findrow,true)
		end if
	elseif ai_retrieve_type=3 then //Action Items
		ll_row=w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.getrow()
		if ll_row=0 then return
		ll_action_item_id=w_contract.tab_contract_details.tabpage_action_items.tab_1.tabpage_detail.dw_1.getitemdecimal(ll_row,'ctx_action_item_id')
		if isnull(ll_action_Item_id) then return  
		//ll_findrow=idw_folder_browse[ai_main_folder_id].find("doc_id="+string(ll_doc_id)+" and action_item_id="+string(ll_action_item_id),1,ll_count)
		ll_findrow=idw_folder_browse[ai_main_folder_id].find("mail_ctx_id="+string(il_ctx_id)+" and mail_action_item_id="+string(ll_action_item_id),1,ll_count)
		if ll_findrow>0 then
			idw_folder_browse[ai_main_folder_id].scrolltorow(ll_findrow)
			idw_folder_browse[ai_main_folder_id].selectrow(0,false)
			idw_folder_browse[ai_main_folder_id].selectrow(ll_findrow,true)
		end if
	end if	
end if

If idw_folder_browse[ai_main_folder_id].GetRow() > 0 Then
	idw_folder_browse[ai_main_folder_id].event rowfocuschanged(idw_folder_browse[ai_main_folder_id].GetRow()) //Added By Ken.Guo 2009-05-22.
Else
	ole_1.object.Navigate(of_create_empty_file())
End If

ii_current_retrieve_type[ai_main_folder_id] = ai_retrieve_type
end subroutine

public function integer of_get_main_folder_id (long al_folder_id);//For Extend. Maybe allow use-defind mail folders.
Return al_folder_id
end function

public function integer of_refresh_data (integer ai_main_folder_id, long al_sub_folder_id);Return 1
end function

public function integer of_open_word (integer ai_main_folder_id);Return 1
end function

public function integer of_set_header (datawindow adw_item, long al_row);String ls_subject,ls_from,ls_to,ls_cc
String ls_header
String ls_date
n_cst_datetime lnv_cst_datetime
If al_row = 0 or al_row > adw_item.RowCount() Then Return -1

ls_subject = adw_item.GetItemString(al_row,'mail_subject')
ls_from = adw_item.GetItemString(al_row,'mail_from')
ls_to = adw_item.GetItemString(al_row,'mail_to')
ls_cc = adw_item.GetItemString(al_row,'mail_cc')
ls_date = String(adw_item.GetItemDatetime(al_row,'mail_date'),'mmm dd yyyy HH:mm:ss')
ls_date = lnv_cst_datetime.of_DaynameOfWeek(Date(adw_item.GetItemDateTime(al_row,'mail_date')),True) + ', ' + ls_date

rte_header.displayonly = False
rte_header.selecttextall( )
//rte_header.clear( ) //modified by gavins 20130227
rte_header.ReplaceText( "" )

//Add Subject with Bold
//clipboard(ls_subject + ' ')
//rte_header.Paste()//modified by gavins 20130227
rte_header.replacetext( ls_subject + ' ' )
rte_header.selecttextall( )
rte_header.settextstyle( True, False,False,False,False,False)

//Add From with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
//clipboard('~r~nFrom: ')//modified by gavins 20130227
//rte_header.Paste()
rte_header.replacetext( '~r~nFrom: ' )
rte_header.settextstyle( False, False,False,False,False,False)
//clipboard(ls_from + ' ')//modified by gavins 20130227
//rte_header.Paste()
rte_header.replacetext( ls_from + ' ' )

//Add To with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
//clipboard('~r~nTo: ')
//rte_header.Paste()
rte_header.replacetext( '~r~nTo: ' )
rte_header.settextstyle( False, False,False,False,False,False)
//clipboard(ls_to + ' ')
//rte_header.Paste()
rte_header.replacetext( ls_to + ' ' )

//Add Cc with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
//clipboard('~r~nCc: ')
//rte_header.Paste()
rte_header.replacetext( '~r~nCc: ' )
rte_header.settextstyle( False, False,False,False,False,False)
//clipboard(ls_cc + ' ')
//rte_header.Paste()
rte_header.replacetext( ls_cc + ' ' )

//Add Date with Bold
rte_header.selecttext(rte_header.LineCount(),rte_header.LineLength(), 0, 0, Detail! )	
rte_header.settextstyle( True, False,False,False,False,False)
//clipboard('~r~nDate: ')
//rte_header.Paste()
rte_header.replacetext( '~r~nDate: ' )
rte_header.settextstyle( False, False,False,False,False,False)
//clipboard(ls_date + ' ~r~n')
//rte_header.Paste()
rte_header.replacetext( ls_date + ' ~r~n' )

rte_header.scroll(0 - rte_header.LineCount())
clipboard('')
rte_header.displayonly = True

Return 1
end function

public subroutine of_refresh_label ();//////////////////////////////////////////////////////////////////////
// $<function>w_email_folderof_refresh_label()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Refresh current Treeview label. show unread Item count.
//////////////////////////////////////////////////////////////////////
// $<add> 2010-04-15 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_label
Integer li_pos
Long ll_unread_cnt
TreeviewItem ltvi_folder

If idw_folder_browse[ii_current_main_folder_id].RowCount() = 0 Then
	ll_unread_cnt = 0
Else
	ll_unread_cnt = idw_folder_browse[ii_current_main_folder_id].GetItemNumber(idw_folder_browse[ii_current_main_folder_id].RowCount(),'compute_unread_cnt')
End If

tv_mail.GetItem(il_current_tv_handle,ltvi_folder)
ls_label = ltvi_folder.label
li_pos = Pos(ls_label,' (')
If li_pos > 0 Then
	ls_label = Mid(ls_label, 1, li_pos - 1)
End If
If ll_unread_cnt > 0 Then
	ltvi_folder.label = ls_label + ' (' + String(ll_unread_cnt) + ')'
	ltvi_folder.bold = True
Else
	ltvi_folder.label = ls_label 
	ltvi_folder.bold = False	
End If
tv_mail.SetItem(il_current_tv_handle,ltvi_folder)

of_refresh_ref_label()
end subroutine

public subroutine of_clearall ();rte_header.displayonly = False
rte_header.selecttextall( )
//rte_header.clear( ) //modified by gavins 20130227
rte_header.ReplaceText( "" )
rte_header.displayonly = True
//ole_mail_view.of_open( )
ole_1.object.Navigate(of_get_empty_html())
lv_attachment.deleteitems( )
il_current_disp_mail = -1
end subroutine

public function integer of_add_sentitem (datastore ads_source);Long ll_row
Boolean lb_need_scrollrow = True
If ib_retrieved_all[3] or ib_retrieved_single[3] Then
	If ads_source.rowcount() <= 0 Then Return 0
	ll_row = idw_folder_browse[3].GetRow()
	If ii_current_folder_id = 3 and ll_row = 1 Then
		lb_need_scrollrow = True
	End If
	ads_source.RowsCopy(1, ads_source.Rowcount(),Primary!,idw_folder_browse[3],1,Primary!)
	idw_folder_browse[3].ResetUpdate()
	If lb_need_scrollrow Then
		idw_folder_browse[3].ScrolltoRow(1) 
		idw_folder_browse[3].SetRow(ll_row + ads_source.Rowcount())
		idw_folder_browse[3].SelectRow(0,False)
		idw_folder_browse[3].SelectRow(ll_row + ads_source.Rowcount(),True)		
	End If
Else
	Return 0
End If

Return 1
end function

public subroutine of_reset_timer ();ii_timer_cnt = 0
il_autoreceive_timer = Long(gnv_data.of_getItem("em_user_config", "email_timer", False))*60
end subroutine

public function integer of_reset_attachui ();//This.SetRedraw(False)
If lv_attachment.TotalItems() > 0 Then
	ole_mail_view.y = st_split.y + st_split.height + 5
	ole_mail_view.height = dw_sent_items.y + dw_sent_items.height - ole_mail_view.y 
	st_split.visible = True
	lv_attachment.visible = True
Else
	ole_mail_view.y = rte_header.y + rte_header.height + 5
	ole_mail_view.height = dw_sent_items.y + dw_sent_items.height - ole_mail_view.y 
	st_split.visible = False
	lv_attachment.visible = False
End If
ole_1.y = ole_mail_view.y
ole_1.height = ole_mail_view.height

//This.SetRedraw(True)
Return 1
end function

public function integer of_reply_email (string as_replymode);
Long ll_row,ll_mail_id
str_ctx_email lstr_ctx_email
Datawindow ldw_current

ldw_current = idw_folder_browse[ii_current_folder_id]
If ldw_current.RowCount() = 0 Then Return 0

ll_row = ldw_current.GetSelectedRow(0)
If ll_row <> ldw_current.GetRow() Then
	Messagebox('Email','Please click the Email item in Email Browse then reply or forward.')
	Return 0
End If

If ll_row =0 Then 
	Messagebox('Email','Please select an Email item to reply or forward.')
	Return 0
End If

lstr_ctx_email.doc_from = 'EMAIL'
ll_mail_id = ldw_current.GetItemNumber(ll_row,'id')
lstr_ctx_email.al_mail_id = ll_mail_id
lstr_ctx_email.as_mail_from = ldw_current.GetItemString(ll_row,'mail_from')
lstr_ctx_email.as_mail_to = ldw_current.GetItemString(ll_row,'mail_to')
lstr_ctx_email.as_mail_cc = ldw_current.GetItemString(ll_row,'mail_cc')
lstr_ctx_email.adt_mail_date = ldw_current.GetItemDateTime(ll_row,'mail_date')
lstr_ctx_email.ai_mail_importance = ldw_current.GetItemNumber(ll_row,'mail_importance')
lstr_ctx_email.as_mail_subject = ldw_current.GetItemString(ll_row,'mail_subject')
lstr_ctx_email.as_mail_attach_name = ldw_current.GetItemString(ll_row,'mail_attach_name')
//lstr_ctx_email.al_mail_ctx_id = ldw_current.GetItemNumber(ll_row,'mail_ctx_id')
//lstr_ctx_email.al_mail_doc_id = ldw_current.GetItemNumber(ll_row,'mail_doc_id')
lstr_ctx_email.as_ctx_id_list = ldw_current.GetItemString(ll_row,'ctx_id_list')
lstr_ctx_email.as_doc_id_list = ldw_current.GetItemString(ll_row,'doc_id_list')
lstr_ctx_email.al_mail_action_item_id = ldw_current.GetItemNumber(ll_row,'mail_action_item_id')
lstr_ctx_email.as_mail_save_format = ldw_current.GetItemString(ll_row,'mail_save_format')
lstr_ctx_email.ai_fromctx = ldw_current.GetItemNumber(ll_row,'mail_fromclx')
If lstr_ctx_email.as_mail_save_format = 'eml' Then
	lstr_ctx_email.as_mail_emlname = inv_em_pop3.of_download_email( ll_mail_id, lstr_ctx_email.as_mail_save_format)
	lstr_ctx_email.as_mail_docname = inv_em_pop3.of_eml2word( ll_mail_id, lstr_ctx_email.as_mail_emlname)
Else
	lstr_ctx_email.as_mail_emlname = ''
	lstr_ctx_email.as_mail_docname = is_current_doc_file
End If

lstr_ctx_email.as_mail_reply_mode = as_replymode //'REPLYALL'

lstr_ctx_email.ctx_id = lstr_ctx_email.al_mail_ctx_id
//---------Begin Modified by (Appeon)Alfee 09.17.2013 for V141 ISG-CLX--------
If Not gb_contract_module Then 
	OpenWithParm( w_dm_email_document_send_ic, lstr_ctx_email)
ELSE
	OpenwithParm(w_dm_email_document_send,lstr_ctx_email)
End If
//OpenwithParm(w_dm_email_document_send,lstr_ctx_email)
//---------End Modified ------------------------------------------------------------------

If Message.doubleparm  = 1 Then
	//must find again. because sent item dw will auto add a record after send a email.
	ll_row  = ldw_current.Find('id = ' + string(ll_mail_id),1,ldw_current.RowCount())
	If ll_row > 0 Then
		Choose Case Upper(as_replymode)
			Case 'REPLY','REPLYALL'
				If ldw_current.GetItemNumber(ll_row,'Read_Status') <> 2 Then
					ldw_current.SetItem(ll_row,'Read_Status',2)
				End If
			Case 'FORWARD'
				If ldw_current.GetItemNumber(ll_row,'Read_Status') <> 3 Then
					ldw_current.SetItem(ll_row,'Read_Status',3)
				End If
		End Choose
		If ldw_current.Modifiedcount( ) > 0 Then
			ldw_current.Update()
			of_refresh_label()
		End If
	End If
Else
	If ldw_current.GetItemNumber(ll_row,'Read_Status') = 0 Then
		ldw_current.SetItem(ll_row,'Read_Status',1)
		ldw_current.Update()
		of_refresh_label()
	End If	
End If


Return  1
end function

public subroutine of_check_menu ();//Check for Check in menu
Integer li_cnt,i
Boolean lb_need = False
ListViewItem llvi_attach

If Not gb_contract_module And gi_email_type = 1 Then Return //IC + Outlook - (Appeon)Alfee 09.23.2013 for V141 ISG-CLX

li_cnt = lv_attachment.totalitems()
If li_cnt <= 0 Then 
	lb_need = False
Else
	For i = 1 To li_cnt
		lv_attachment.GetItem(i,llvi_attach)
		If llvi_attach.pictureindex = 2 Then
			lb_need = True
			Exit
		End If
	Next
End If

If isvalid(m_pfe_cst_mail) Then
	If lb_need Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_checkindoc,'toolbaritemvisible', True)
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_checkindoc,'toolbaritemvisible', False)
	End If

	If inv_em_pop3.is_status = inv_em_pop3.IS_PROCESSING Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', False)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', True)					
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_receive,'toolbaritemvisible', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_stopreceive,'toolbaritemvisible', False)
	End If

	If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_options,'toolbaritemvisible', False)
//		m_pfe_cst_mail.m_email.m_options.enabled = False
//		m_pfe_cst_mail.m_email.m_receive.enabled = False
//		m_pfe_cst_mail.m_email.m_stopreceive.enabled = False
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mail.m_email.m_options,'toolbaritemvisible', True)
//		m_pfe_cst_mail.m_email.m_options.enabled = True
//		m_pfe_cst_mail.m_email.m_receive.enabled = True
//		m_pfe_cst_mail.m_email.m_stopreceive.enabled = True
	End If

End If
end subroutine

public function integer of_set_column_visible (integer ai_main_folder_id);//Set Readonly and column's visible.
idw_folder_browse[ai_main_folder_id].Modify("DataWindow.ReadOnly='yes'" )
Choose Case ai_main_folder_id
	Case 2 //Inbox
		idw_folder_browse[ai_main_folder_id].Modify("mail_to_c.visible = '0' folder_display.visible = '0'")
	Case 3 //Sent Items
		idw_folder_browse[ai_main_folder_id].Modify("mail_from_c.visible = '0'  folder_display.visible = '0'")
	Case 4 //Drafts
		idw_folder_browse[ai_main_folder_id].Modify("mail_from_c.visible = '0'  folder_display.visible = '0'")
	Case 5 //Favarity
		idw_folder_browse[ai_main_folder_id].Modify("folder_display.visible = '0'")
	Case 6 //History
		idw_folder_browse[ai_main_folder_id].Modify("folder_display.visible = '0'")
	Case 7 //Delete
		idw_folder_browse[ai_main_folder_id].Modify("folder_display.visible = '0'")
	Case 8 //Search result
		idw_folder_browse[ai_main_folder_id].modify("b_reset.visible = '1'")
		//idw_folder_browse[ai_main_folder_id].Modify("folder_display.visible = '1'") //Search Result Folder
End Choose
Return 1
end function

public subroutine of_reset_all ();Long i

For i = 1 To UpperBound(ib_retrieved_all[])
	ib_retrieved_all[i] = False
Next	

For i = 1 To UpperBound(ib_retrieved_single[])
	ib_retrieved_single[i] = False
Next	

For i = 1 To UpperBound(ii_current_retrieve_type[])
	ii_current_retrieve_type[i] = -1
Next	

For i = 1 To UpperBound(idw_folder_browse[])
	idw_folder_browse[i].Reset()
Next	

ole_1.object.Navigate(of_create_empty_file())
ole_mail_view.of_close( )
//rte_header.clear() //modified by gavins 20130227
rte_header.ReplaceText( "" )
lv_attachment.deleteitems( )

is_current_doc_file = ''
is_current_eml_file = ''
il_current_disp_mail = -1

end subroutine

public function integer of_get_select_type ();If rb_all.checked Then 
	Return 0 //for all
Else
	Return 1 //For Selected/Special CTX.
End If
end function

public function string of_create_empty_file ();String ls_filename,ls_EmailDirectory
Blob lb_empty

ls_EmailDirectory = gs_dir_path + gs_DefDirName + "\Email"
gnv_appeondll.of_parsepath(ls_EmailDirectory)

ls_filename = ls_EmailDirectory + '\empty.txt'

If FileExists(ls_filename) Then Return ls_filename

lb_empty = Blob("")
AppeonWriteFile(ls_filename,lb_empty,Len(lb_empty))

Return ls_filename
end function

public subroutine of_refresh_ref_label ();Long ll_unread_cnt
ll_unread_cnt = inv_em_pop3.of_getunreademailcount(2,gs_user_id) //Search for Inbox Items

If Isvalid(m_pfe_cst_mdi_menu) Then
	If ll_unread_cnt > 0 Then
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems,'toolbarItemname',  'folder_full.png')  //Start Code Change ----03.28.2016 #V15 maha - was home_fill.gif
	Else
		gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu.m_system.m_emailsignature.m_emailsentitems,'toolbarItemname', 'folder_man.png')  //Start Code Change ----03.28.2016 #V15 maha - was home.gif
	End If
End If

If Isvalid(w_todolist) Then w_todolist.event ue_refresh_unread_email()
If Isvalid(w_dashboard) Then w_dashboard.event ue_refresh_unread_email()

end subroutine

public function string of_get_empty_html ();String ls_empty_file
Long ll_handle

ls_empty_file = ole_mail_view.of_getemaildir( ) + '\empty.html'

If Not FileExists(ls_empty_file) Then
	ll_handle = FileOpen(ls_empty_file,LineMode!, Write!,LockWrite! ,Replace!  )
	FileClose(ll_handle)
End If

Return ls_empty_file
end function

public subroutine of_set_options_visible (boolean ab_value);rb_select.visible = ab_value
rb_all.visible = ab_value
end subroutine

public subroutine wf_change_emailprotocol ();//is_Email_Protocol
end subroutine

public subroutine of_adjust_position ();//====================================================================
// Function: of_adjust_position
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Mark Lee		Date: 02/07/2013
//--------------------------------------------------------------------
//	Copyright (c) 2008-2012 Contract Logix,Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================
Integer 		i	
String 		ls_pos,  ls_pos2	


ls_pos = gnv_user_option.of_Get_option_value( gs_user_id, "Email_Manager_folder_st_v_bar.x" )
gnv_string.of_convert_numeric_for_language( ls_pos)				//Added By Mark Lee 05/09/2013

If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos)  Then 
	if Dec(ls_pos) > 0  then					//Added By Mark Lee 09/04/2013
		st_v_bar.x =  Dec(ls_pos)  *  this.width
	end if
End If

ls_pos = gnv_user_option.of_Get_option_value( gs_user_id, "Email_Manager_folder_st_v_bar2.x" )
gnv_string.of_convert_numeric_for_language( ls_pos)				//Added By Mark Lee 05/09/2013

If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos)  Then 
	if Dec(ls_pos) > 0 then					//Added By Mark Lee 09/04/2013
		st_v_bar2.x =  Dec(ls_pos)  *  this.width
	end if
End If

tv_mail.width = st_v_bar.x - tv_mail.x
For i = 1 To UpperBound(idw_folder_browse[])
	idw_folder_browse[i].x  = st_v_bar.x +  st_v_bar.width 
	idw_folder_browse[i].width = st_v_bar2.x - idw_folder_browse[i].x 
Next

st_split.x = st_v_bar2.x + st_v_bar2.width
ole_mail_view.x = st_v_bar2.x + st_v_bar2.width
ole_1.x = st_v_bar2.x + st_v_bar2.width
lv_attachment.x = st_v_bar2.x + st_v_bar2.width
rte_header.x = st_v_bar2.x + st_v_bar2.width

st_split.width = this.width - st_split.x
ole_mail_view.width =  this.width - ole_mail_view.x
ole_1.width =  this.width - ole_1.x
lv_attachment.width =  this.width - lv_attachment.x
rte_header.width =  this.width - rte_header.x

////inherit					// move from the window's open() event.
//this.of_SetResize(true)
//inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
//inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())
//
//inv_resize.of_Register(ole_mail_view, inv_resize.SCALERIGHTBOTTOM)
//inv_resize.of_Register(ole_1, inv_resize.SCALERIGHTBOTTOM)
//
//inv_resize.of_Register(rte_header, inv_resize.SCALERIGHT)
//inv_resize.of_Register(st_split, inv_resize.SCALERIGHT )
//inv_resize.of_Register(lv_attachment, inv_resize.SCALERIGHT)
//
//inv_resize.of_Register(tv_mail, inv_resize.SCALEBOTTOM) 
//inv_resize.of_Register(st_v_bar, inv_resize.SCALEBOTTOM)
//inv_resize.of_Register(st_v_bar2, inv_resize.SCALEBOTTOM)
//
//inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHTBOTTOM)
//inv_resize.of_Register(cb_refresh, inv_resize.FIXEDRIGHTBOTTOM)
//inv_resize.of_Register(rb_all, inv_resize.FIXEDBOTTOM)    
//inv_resize.of_Register(rb_select, inv_resize.FIXEDBOTTOM)  
//inv_resize.of_Register(cb_selectback, inv_resize.FIXEDBOTTOM)   
//inv_resize.of_Register(st_tip, inv_resize.FIXEDBOTTOM) 
//
//st_split.of_Register(ole_mail_view , st_split.below )
//st_split.of_Register(ole_1 , st_split.below )
//st_split.of_Register(lv_attachment , st_split.above )
//
//st_v_bar.of_Register(tv_mail, st_v_bar.Left)
//
//st_v_bar2.of_Register(st_split , st_v_bar2.Right)
//st_v_bar2.of_Register(ole_mail_view , st_v_bar2.Right)
//st_v_bar2.of_Register(ole_1 , st_v_bar2.Right)
//st_v_bar2.of_Register(lv_attachment , st_v_bar2.Right)
//st_v_bar2.of_Register(rte_header , st_v_bar2.Right)
//
//For i = 1 To UpperBound(idw_folder_browse[])
//	inv_resize.of_Register(idw_folder_browse[i], inv_resize.SCALEBOTTOM)
//	st_v_bar.of_Register(idw_folder_browse[i], st_v_bar.Right)
//	st_v_bar2.of_Register(idw_folder_browse[i] , st_v_bar2.Left)
//Next
//
//// set minimun position
//st_v_bar.of_SetMinobjectsize( 600)		
//st_v_bar2.of_SetMinobjectsize( 600)		
end subroutine

on w_email_folder.create
int iCurrent
call super::create
this.ole_mail_view=create ole_mail_view
this.cb_selectback=create cb_selectback
this.dw_search=create dw_search
this.lv_attachment=create lv_attachment
this.st_v_bar2=create st_v_bar2
this.st_tip=create st_tip
this.dw_drafts=create dw_drafts
this.dw_favorite=create dw_favorite
this.dw_history=create dw_history
this.dw_recycle=create dw_recycle
this.dw_inbox=create dw_inbox
this.st_v_bar=create st_v_bar
this.tv_mail=create tv_mail
this.cb_refresh=create cb_refresh
this.rb_all=create rb_all
this.rb_select=create rb_select
this.st_split=create st_split
this.cb_close=create cb_close
this.dw_sent_items=create dw_sent_items
this.rte_header=create rte_header
this.ole_1=create ole_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_mail_view
this.Control[iCurrent+2]=this.cb_selectback
this.Control[iCurrent+3]=this.dw_search
this.Control[iCurrent+4]=this.lv_attachment
this.Control[iCurrent+5]=this.st_v_bar2
this.Control[iCurrent+6]=this.st_tip
this.Control[iCurrent+7]=this.dw_drafts
this.Control[iCurrent+8]=this.dw_favorite
this.Control[iCurrent+9]=this.dw_history
this.Control[iCurrent+10]=this.dw_recycle
this.Control[iCurrent+11]=this.dw_inbox
this.Control[iCurrent+12]=this.st_v_bar
this.Control[iCurrent+13]=this.tv_mail
this.Control[iCurrent+14]=this.cb_refresh
this.Control[iCurrent+15]=this.rb_all
this.Control[iCurrent+16]=this.rb_select
this.Control[iCurrent+17]=this.st_split
this.Control[iCurrent+18]=this.cb_close
this.Control[iCurrent+19]=this.dw_sent_items
this.Control[iCurrent+20]=this.rte_header
this.Control[iCurrent+21]=this.ole_1
end on

on w_email_folder.destroy
call super::destroy
destroy(this.ole_mail_view)
destroy(this.cb_selectback)
destroy(this.dw_search)
destroy(this.lv_attachment)
destroy(this.st_v_bar2)
destroy(this.st_tip)
destroy(this.dw_drafts)
destroy(this.dw_favorite)
destroy(this.dw_history)
destroy(this.dw_recycle)
destroy(this.dw_inbox)
destroy(this.st_v_bar)
destroy(this.tv_mail)
destroy(this.cb_refresh)
destroy(this.rb_all)
destroy(this.rb_select)
destroy(this.st_split)
destroy(this.cb_close)
destroy(this.dw_sent_items)
destroy(this.rte_header)
destroy(this.ole_1)
end on

event open;call super::open;Integer i
Long ll_row
DatawindowChild ldwc_folderlist
DataStore lds_folderlist

idw_folder_browse[] = {dw_inbox,dw_inbox,dw_sent_items,dw_drafts,dw_favorite,dw_history,dw_recycle,dw_search}

lds_folderlist = Create DataStore
lds_folderlist.DataObject = 'd_dddw_em_folder'
For i = 2 To 7
	ll_row = lds_folderlist.InsertRow(0)
	lds_folderlist.SetItem(ll_row,'folder_id',i)
	lds_folderlist.SetItem(ll_row,'folder_label',is_folder_name[i])
Next
ll_row = lds_folderlist.InsertRow(0)
lds_folderlist.SetItem(ll_row,'folder_id',-1)
lds_folderlist.SetItem(ll_row,'folder_label',is_folder_name[7])

For i = 1 To UpperBound(idw_folder_browse[])
	idw_folder_browse[i].ii_main_folder_id = il_folder_data[i]
	idw_folder_browse[i].dataobject = 'd_em_items'
	idw_folder_browse[i].SetTransObject(SQLCA)
	idw_folder_browse[i].GetChild('folder_display',ldwc_folderlist)
	lds_folderlist.RowsCopy(1,lds_folderlist.RowCount(),Primary!,ldwc_folderlist,1,Primary!)
	This.of_set_column_visible(il_folder_data[i])
Next

is_sql_org = idw_folder_browse[1].getsqlselect( )

str_email_parm lstr_email_parm

If isvalid(message.powerobjectparm) Then
	lstr_email_parm = message.powerobjectparm
	ii_retrieve_type = lstr_email_parm.ai_from_type
	ii_folder_type = lstr_email_parm.ai_folder_type
	rb_select.checked = True
	rb_all.checked = False	
Else
	ii_retrieve_type = 0
	ii_folder_type = 2 //Inbox
	rb_select.checked = False
	rb_all.checked = True	
End If

//Added By Ken.Guo 2010-12-03.
If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' Then
	If ii_folder_type = 2 Then ii_folder_type = 3 
End If

//Added By Ken.Guo 2009-05-27.
If ii_retrieve_type <> 0 and Isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount() = 0 Then
		ii_retrieve_type = 0
	End If
End If

if ii_retrieve_type = 0 then
	rb_all.checked = True
	rb_select.checked = false
	rb_select.enabled = false
	rb_all.enabled = false
end if

//Begin - Added By Mark Lee 02/07/2013
////inherit
//this.of_SetResize(true)
//inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
//inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())
//
//inv_resize.of_Register(ole_mail_view, inv_resize.SCALERIGHTBOTTOM)
//inv_resize.of_Register(ole_1, inv_resize.SCALERIGHTBOTTOM)
//
//inv_resize.of_Register(rte_header, inv_resize.SCALERIGHT)
//inv_resize.of_Register(st_split, inv_resize.SCALERIGHT )
//inv_resize.of_Register(lv_attachment, inv_resize.SCALERIGHT)
//
//inv_resize.of_Register(tv_mail, inv_resize.SCALEBOTTOM) //Added By Ken.Guo 2010-03-26.
//inv_resize.of_Register(st_v_bar, inv_resize.SCALEBOTTOM)
//inv_resize.of_Register(st_v_bar2, inv_resize.SCALEBOTTOM)
//
//inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHTBOTTOM)
//inv_resize.of_Register(cb_refresh, inv_resize.FIXEDRIGHTBOTTOM)
//inv_resize.of_Register(rb_all, inv_resize.FIXEDBOTTOM)   //Added By Ken.Guo 2009-05-20.
//inv_resize.of_Register(rb_select, inv_resize.FIXEDBOTTOM)   //Added By Ken.Guo 2009-05-20.
//inv_resize.of_Register(cb_selectback, inv_resize.FIXEDBOTTOM)  // added by gavin  20111220
//inv_resize.of_Register(st_tip, inv_resize.FIXEDBOTTOM) 
//
//st_split.of_Register(ole_mail_view , st_split.below )
//st_split.of_Register(ole_1 , st_split.below )
//st_split.of_Register(lv_attachment , st_split.above )
//
//st_v_bar.of_Register(tv_mail, st_v_bar.Left)
//
//st_v_bar2.of_Register(st_split , st_v_bar2.Right)
//st_v_bar2.of_Register(ole_mail_view , st_v_bar2.Right)
//st_v_bar2.of_Register(ole_1 , st_v_bar2.Right)
//st_v_bar2.of_Register(lv_attachment , st_v_bar2.Right)
//st_v_bar2.of_Register(rte_header , st_v_bar2.Right)
//
//For i = 1 To UpperBound(idw_folder_browse[])
//	inv_resize.of_Register(idw_folder_browse[i], inv_resize.SCALEBOTTOM)
//	st_v_bar.of_Register(idw_folder_browse[i], st_v_bar.Right)
//	st_v_bar2.of_Register(idw_folder_browse[i] , st_v_bar2.Left)
//Next
//End - Added By Mark Lee 02/07/2013

If Not gb_contract_module And gi_email_type = 1 Then ii_folder_type = 2 //IC + Outlook - (Appeon)Alfee 07.25.2013 for V141 ISG-CLX

of_build_mail_tv()
this.tv_mail.SelectItem(ii_folder_type)

If isvalid(gw_contract) Then
	If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow() > 0 Then
		il_ctx_id = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getitemdecimal(gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow(),"ctx_id")
	End If
End If

If isvalid(lds_folderlist ) Then Destroy lds_folderlist

If rb_select.Checked And rb_select.Enabled Then // add by gavin  20121220
	cb_selectback.Enabled = True	
End If

//Added By Mark Lee 02/07/2013
//of_adjust_position()
//Integer 		i	
of_adjust_position()				//Added By Mark Lee 03/04/2013
//String 		ls_pos,  ls_pos2	
//
//
//ls_pos = gnv_user_option.of_Get_option_value( gs_user_id, "Email_Manager_folder_st_v_bar.x" )
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_v_bar.x =  Dec(ls_pos)  *  this.width
//End If
//
//ls_pos = gnv_user_option.of_Get_option_value( gs_user_id, "Email_Manager_folder_st_v_bar2.x" )
//If not isnull(ls_pos) and trim(ls_pos)  <> '' and  IsNumber(ls_pos) Then 
//	st_v_bar2.x =  Dec(ls_pos)  *  this.width
//End If
//
//tv_mail.width = st_v_bar.x - tv_mail.x
//For i = 1 To UpperBound(idw_folder_browse[])
//	idw_folder_browse[i].x  = st_v_bar.x +  st_v_bar.width 
//	idw_folder_browse[i].width = st_v_bar2.x - idw_folder_browse[i].x 
//Next
//
//st_split.x = st_v_bar2.x + st_v_bar2.width
//ole_mail_view.x = st_v_bar2.x + st_v_bar2.width
//ole_1.x = st_v_bar2.x + st_v_bar2.width
//lv_attachment.x = st_v_bar2.x + st_v_bar2.width
//rte_header.x = st_v_bar2.x + st_v_bar2.width
//
//st_split.width = this.width - st_split.x
//ole_mail_view.width =  this.width - ole_mail_view.x
//ole_1.width =  this.width - ole_1.x
//lv_attachment.width =  this.width - lv_attachment.x
//rte_header.width =  this.width - rte_header.x

//inherit					// move from the window's open() event.
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(ole_mail_view, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(ole_1, inv_resize.SCALERIGHTBOTTOM)

inv_resize.of_Register(rte_header, inv_resize.SCALERIGHT)
inv_resize.of_Register(st_split, inv_resize.SCALERIGHT )
inv_resize.of_Register(lv_attachment, inv_resize.SCALERIGHT)

inv_resize.of_Register(tv_mail, inv_resize.SCALEBOTTOM) 
inv_resize.of_Register(st_v_bar, inv_resize.SCALEBOTTOM)
inv_resize.of_Register(st_v_bar2, inv_resize.SCALEBOTTOM)

inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_refresh, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(rb_all, inv_resize.FIXEDBOTTOM)    
inv_resize.of_Register(rb_select, inv_resize.FIXEDBOTTOM)  
inv_resize.of_Register(cb_selectback, inv_resize.FIXEDBOTTOM)   
inv_resize.of_Register(st_tip, inv_resize.FIXEDBOTTOM) 

st_split.of_Register(ole_mail_view , st_split.below )
st_split.of_Register(ole_1 , st_split.below )
st_split.of_Register(lv_attachment , st_split.above )

st_v_bar.of_Register(tv_mail, st_v_bar.Left)

st_v_bar2.of_Register(st_split , st_v_bar2.Right)
st_v_bar2.of_Register(ole_mail_view , st_v_bar2.Right)
st_v_bar2.of_Register(ole_1 , st_v_bar2.Right)
st_v_bar2.of_Register(lv_attachment , st_v_bar2.Right)
st_v_bar2.of_Register(rte_header , st_v_bar2.Right)

For i = 1 To UpperBound(idw_folder_browse[])
	inv_resize.of_Register(idw_folder_browse[i], inv_resize.SCALEBOTTOM)
	st_v_bar.of_Register(idw_folder_browse[i], st_v_bar.Right)
	st_v_bar2.of_Register(idw_folder_browse[i] , st_v_bar2.Left)
Next

// set minimun position
st_v_bar.of_SetMinobjectsize( 600)		
st_v_bar2.of_SetMinobjectsize( 600)		

//---------Begin Added by (Appeon)Alfee 07.25.2013 for V141 ISG-CLX--------
If Not gb_contract_module Then 
	rb_all.visible = False
	rb_select.visible = False
	cb_selectback.visible = False
End If
w_mdi.SetRedraw(False) //(Appeon)Eugene 08.06.2013 for V141 ISG-CLX
w_mdi.Post SetRedraw(True)	 //(Appeon)Eugene 08.06.2013 for V141 ISG-CLX
//---------End Added ------------------------------------------------------------------
end event

event activate;call super::activate;//Added By Ken.Guo 2010-03-26.
If Not isValid(This) Then Return

If w_mdi.MenuName <> "m_pfe_cst_mail" Then
	w_mdi.SetRedraw(False) //(Appeon)Eugene 08.06.2013 for V141 ISG-CLX
	w_mdi.ChangeMenu(m_pfe_cst_mail)
	w_mdi.of_menu_security(w_mdi.MenuName)
	w_mdi.SetRedraw(True)	 //(Appeon)Eugene 08.06.2013 for V141 ISG-CLX
End If

If Not gb_contract_module And gi_email_type = 1 Then Return //IC + Outlook - (Appeon)Alfee 07.25.2013 for V141 ISG-CLX

of_check_menu()

//Auto Refresh Email for Selected CTX
Long ll_ctx_id
If ib_opened Then
	If isvalid(gw_contract) Then
		If rb_select.visible and gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow() > 0 Then
			ll_ctx_id = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getitemdecimal(gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow(),"ctx_id")
			If ll_ctx_id <> il_ctx_id and ll_ctx_id <> il_pre_ctx_id_from_search_tab  Then
				This.Post event ue_change_ctx(ll_ctx_id, true, true)
			End If
			il_pre_ctx_id_from_search_tab = ll_ctx_id
		End If
		If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow() > 0 Then
			rb_select.enabled = True
			rb_all.enabled = True
		ElseIf il_ctx_id = 0 Then
			rb_select.enabled = False
			rb_all.enabled = False		
		End If
	ElseIf il_ctx_id = 0 Then
		rb_select.enabled = False
		rb_all.enabled = False		
	End If
End If

end event

event close;call super::close;ole_mail_view.of_Close()		//Added by Scofield on 2009-04-21

If isvalid(inv_em_pop3) Then 
	If inv_em_pop3.is_status = inv_em_pop3.is_processing Then
		inv_em_pop3.of_set_status(inv_em_pop3.is_stoping)
	End If
	inv_em_pop3.of_disconnect_pop3()
End If

//Added By Ken.Guo 07/09/2013
If isvalid(inv_em_imap4) Then 
	If inv_em_imap4.is_status = inv_em_imap4.is_processing Then
		inv_em_imap4.of_set_status(inv_em_imap4.is_stoping)
	End If
	inv_em_imap4.of_disconnect_imap4()
End If

if w_mdi.menuname <> 'm_pfe_cst_mdi_menu' then
	w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
	w_mdi.of_menu_security(w_mdi.MenuName)
End If

//---------Begin Added by (Appeon)Harry 09.10.2014 for BugH070904--------
long doc_id
if Upper(AppeonGetClienttype()) = 'WEB'  and isvalid(gw_contract) and ib_tdl_ctx then
	If isvalid(w_tabpg_contract_doc_mgr) Then 
		doc_id = w_tabpg_contract_doc_mgr.dw_dddw.getitemnumber(1, 'doc_id') 
		if not isnull(doc_id) and doc_id > 0 then
			gw_contract.setredraw(false)

			if gw_contract.windowstate <> Maximized! then
				gw_contract.windowstate = Maximized!
			end if 

			gw_contract.post setredraw(True)
		end if 
	End If
end if
//---------End Added ------------------------------------------------------
SetPointer(Arrow!)

end event

event pfc_postopen;call super::pfc_postopen;//Added By Mark Lee 02/07/2013
of_adjust_position()

of_retrieve_data(ii_folder_type,ii_folder_type,ii_retrieve_type)     //Modified By Ken.Guo 2009-05-20
of_refresh_ref_label()
il_autoreceive_timer = Long(gnv_data.of_getItem("em_user_config", "email_timer", False))*60
Timer(ii_timer,This)

ib_opened = True //After do post open then do activate(). or ignore first activate() event.
end event

event resize;call super::resize;//lv_attachment.width = ole_mail_view.width
//st_split.width = ole_mail_view.width
//
//st_tip.width = cb_refresh.x - rb_select.x - rb_select.width - 200
//ole_mail_view.height = dw_sent_items.y + dw_sent_items.height - ole_mail_view.y
//
//ole_1.move(ole_mail_view.x,ole_mail_view.y)
//ole_1.resize(ole_mail_view.width,ole_mail_view.height)

//lv_attachment.width = ole_1.width				//Commented By Mark Lee 02/07/2013
st_split.width = ole_1.width

st_tip.width = cb_refresh.x - cb_selectback.x - cb_selectback.width - 200  // modifed  by gavin 20111220

ole_1.height = dw_sent_items.y + dw_sent_items.height - ole_1.y

of_adjust_position() //Added By Mark Lee 03/04/2013
end event

event timer;call super::timer;ii_timer_cnt = ii_timer_cnt + ii_timer
If ii_timer_cnt >= 3600 Then ii_timer_cnt = 0

//for auto receive
If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '1' Then
	IF il_autoreceive_timer <> 0 Then
		If Mod(ii_timer_cnt,il_autoreceive_timer) = 0 Then
				If inv_em_pop3.is_status = inv_em_pop3.IS_COMPLETE Then
					This.event pfc_cst_receive('auto')		
				End If
		End If
	End If
End If

end event

type ole_mail_view from u_email_edit within w_email_folder
boolean visible = false
integer x = 3328
integer y = 468
integer width = 1271
integer height = 1032
integer taborder = 40
string binarykey = "w_email_folder.win"
end type

event constructor;call super::constructor;ole_mail_view.object.ToolBars = False
ole_mail_view.object.Menubar = False
end event

type cb_selectback from commandbutton within w_email_folder
integer x = 1211
integer y = 1528
integer width = 654
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Back To Contract "
end type

event clicked;//  add back to contract    by gavin  20121220

powerobject  lpo_null

If IsValid( w_contract ) Then
 
    Parent.ParentWindow().SetRedraw( False )
	
	If Not w_contract.Visible Then

		post gf_opencontractfolder( lpo_null )
		
	Else
		w_contract.SetPosition( ToTop! )
	End If

    Parent.ParentWindow().SetRedraw( True )
Else
	
	gf_opencontractfolder( lpo_null )
	
End If
end event

type dw_search from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

type lv_attachment from u_lv_attachment within w_email_folder
integer x = 4137
integer y = 448
integer width = 462
integer height = 144
integer taborder = 30
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
boolean hideselection = false
listviewview view = listviewsmallicon!
string largepicturename[] = {"attachment.jpg","checkout.bmp"}
string smallpicturename[] = {"attachment.jpg","checkout.bmp"}
boolean ib_rmbmenu = false
end type

event rightclicked;call super::rightclicked;listviewitem lvi_attach
m_mail_attach lm_mail
Datawindow			ldw_current
long 					ll_ctx_id

If index <= 0 Then Return 0

lm_mail = Create m_mail_attach
lm_mail.ilv_attachment = This

If This.GetItem(index,lvi_attach) > 0 Then
	If lvi_attach.pictureindex <> 2 Then
		lm_mail.m_checkin.visible = False
	End If
Else
	lm_mail.m_checkin.visible = False
End If

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
If Not gb_contract_module Then
	lm_mail.m_addtodocumentmanager_ctx.visible = False
	lm_mail.m_addtodocumentmanager_select_ctx.visible = False
Else
//---------End Added ------------------------------------------------------
	//Begin - Added By Mark Lee 06/13/2013
	ldw_current = idw_folder_browse[ii_current_main_folder_id]
	ll_ctx_id = ldw_current.GetItemNumber(ldw_current.GetRow(),'mail_ctx_id')
	If not isnull(ll_ctx_id) and ll_ctx_id > 0  then 
		lm_mail.m_addtodocumentmanager_ctx.visible = True 
		lm_mail.m_addtodocumentmanager_ctx.text ="Add to Document Manager -- CTX "+ string(ll_ctx_id)
	Else 
		lm_mail.m_addtodocumentmanager_ctx.visible = False	
	End IF 
	//End - Added By Mark Lee 06/13/2013
End If

lm_mail.Popmenu(w_mdi.PointerX(),w_mdi.PointerY())
end event

event doubleclicked;call super::doubleclicked;If index <= 0 Then Return

Parent.event ue_do_attachment( This.is_emlfile , This.il_mailid , This.SelectedIndex() ,'open')

end event

type st_v_bar2 from u_st_splitbar within w_email_folder
integer x = 4119
integer y = 8
integer width = 18
integer height = 1488
end type

event lbuttonup;call super::lbuttonup;//Added By Mark Lee 02/07/2013
gnv_user_option.of_Set_option_value(gs_user_id, "Email_Manager_folder_st_v_bar2.x",string(this.x  / parent.width ) )
gnv_user_option.of_save()			
end event

type st_tip from statictext within w_email_folder
integer x = 1897
integer y = 1552
integer width = 1070
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_drafts from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.Modify("mail_from.visible = '0'")
end event

type dw_favorite from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

type dw_history from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

type dw_recycle from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

type dw_inbox from u_dw_mail within w_email_folder
integer x = 658
integer y = 8
integer width = 3461
integer height = 1492
integer taborder = 20
string dataobject = "d_em_items"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.Modify("mail_to.visible = '0'")



end event

type st_v_bar from u_st_splitbar within w_email_folder
integer x = 645
integer y = 8
integer width = 18
integer height = 1488
end type

event lbuttonup;call super::lbuttonup;//Added By Mark Lee 02/07/2013
gnv_user_option.of_Set_option_value(gs_user_id, "Email_Manager_folder_st_v_bar.x",string(this.x  / parent.width ) )
gnv_user_option.of_save()	
end event

type tv_mail from u_tv within w_email_folder
integer x = 5
integer y = 8
integer width = 645
integer height = 1488
integer taborder = 20
fontcharset fontcharset = ansi!
borderstyle borderstyle = stylebox!
boolean hideselection = false
boolean fullrowselect = true
string picturename[] = {"home.gif","inbox.gif","sentitem.gif","DosEdit5!","favorite.gif","history.gif","recycle.gif","findemail.gif","Custom039!","Custom050!"}
end type

event selectionchanged;call super::selectionchanged;Treeviewitem ltvi_mail

If This.GetItem(NewHandle,ltvi_mail) <> 1 Then Return

IF ltvi_mail.data = 1 Then Return  //Home Folder

If newhandle = il_folder_handle[2] Then //added by gavins 20121121
	dw_inbox.Modify( "protocoltype.visible = 1 protocoltype_t.visible = 1" )
End If

ii_current_folder_id = ltvi_mail.data
ii_current_main_folder_id = of_get_main_folder_id(ii_current_folder_id)
il_current_tv_handle = Newhandle

//Set UI
of_set_folder(ii_current_main_folder_id) 

//Reset Option Settings
//If ii_current_main_folder_id = 8 Then
If ii_current_main_folder_id = 8 Or Not gb_contract_module Then	 //(Appeon)Alfee 07.25.2013 - V141 ISG-CLX
	of_set_options_visible(False)
Else
	of_set_options_visible(True)
End If

//Retrieve Data
idw_folder_browse[ii_current_main_folder_id].SetRedraw(False) 
of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,of_get_retrieve_type())
idw_folder_browse[ii_current_main_folder_id].SetRedraw(True) 

Long ll_row
ll_row = idw_folder_browse[ii_current_main_folder_id].GetRow()
If ll_row >0 Then
	idw_folder_browse[ii_current_main_folder_id].Event Rowfocuschanged(ll_row)
Else
	ole_mail_view.SetRedraw(false)
	of_clearall()
	of_reset_attachUI()
	ole_mail_view.SetRedraw(True)
End If

Parent.of_refresh_label()

/*
Choose Case ltvi_mail.data
	Case 1 //Home
		Return
	Case 3 //Sent Items
		Parent.of_retrieve_sentitems(of_get_retrieve_type())
	Case 4 //Favorite
		
	Case 5 //History
		
	Case 6 //Recycle
		
	Case Else //Inbox(2) or maybe customer folders
		
End Choose
*/
end event

event selectionchanging;call super::selectionchanging;//modify by  liushuliang
//modify dt 2013-07-8-07
//drop the window message
//If gnv_data.of_getitem('icred_settings', 'receive_email', False) = '0' and newhandle = il_folder_handle[2] Then //Inbox
//	Messagebox('Email',is_purchase)
//	Return 1 //Prevent the selection from changing
//End If
//
end event

type cb_refresh from commandbutton within w_email_folder
integer x = 3872
integer y = 1528
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked; 
 //Retrieve Sent Items
// ib_retrieved_sent_all = False
// ib_retrieved_sent_single = False 
// ii_current_retrieve_sent_type = -1

ib_retrieved_all[ii_current_main_folder_id] = False
ib_retrieved_single[ii_current_main_folder_id] = False
ii_current_retrieve_type[ii_current_main_folder_id] = -1
 
idw_folder_browse[ii_current_main_folder_id].SetRedraw(False) 
If rb_all.checked then
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,0)
Else
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,ii_retrieve_type)
END IF
idw_folder_browse[ii_current_main_folder_id].SetRedraw(True) 
end event

type rb_all from radiobutton within w_email_folder
integer x = 46
integer y = 1544
integer width = 343
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
string text = "All Emails"
boolean checked = true
end type

event clicked;if this.checked then
	cb_selectback.Enabled = False // add by gavin  20111220
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,0)
END IF
end event

type rb_select from radiobutton within w_email_folder
integer x = 389
integer y = 1544
integer width = 814
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
string text = "Selected Contract"
end type

event clicked;if this.checked then
	
	cb_selectback.Enabled = True // add by gavin  20111220
	
	//Auto Refresh Email for Selected CTX
	Long ll_ctx_id
	If ib_opened Then
		If isvalid(gw_contract) Then
			If gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow() > 0 Then
				ll_ctx_id = gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getitemdecimal(gw_contract.tab_contract_details.tabpage_search.dw_search_det1.getrow(),"ctx_id")
				If ll_ctx_id <> il_ctx_id Then //and ll_ctx_id <> il_pre_ctx_id_from_search_tab  Then
					If Parent.event ue_change_ctx(ll_ctx_id, false, true) = 0 Then
						Return
					End If
				End If
			Else
				Return
			End If
		Else
			Return
		End If
	End If	
	of_retrieve_data(ii_current_main_folder_id,ii_current_folder_id,ii_retrieve_type)
	
end if

end event

type st_split from u_st_splitbar within w_email_folder
integer x = 4142
integer y = 588
integer width = 453
integer height = 16
end type

type cb_close from commandbutton within w_email_folder
integer x = 4229
integer y = 1528
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

type dw_sent_items from u_dw_mail within w_email_folder
integer x = 658
integer y = 4
integer width = 3461
integer height = 1492
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_em_items"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.Modify("mail_from.visible = '0'")

end event

type rte_header from richtextedit within w_email_folder
integer x = 4137
integer y = 8
integer width = 462
integer height = 440
integer taborder = 30
boolean init_vscrollbar = true
boolean init_wordwrap = true
borderstyle borderstyle = stylelowered!
end type

type ole_1 from olecustomcontrol within w_email_folder
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( boolean activedocument,  ref boolean cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
event setphishingfilterstatus ( long phishingfilterstatus )
event newprocess ( long lcauseflag,  oleobject pwb2,  ref boolean cancel )
event redirectxdomainblocked ( oleobject pdisp,  any starturl,  any redirecturl,  any frame,  any statuscode )
integer x = 4137
integer y = 4
integer width = 462
integer height = 1504
integer taborder = 40
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_email_folder.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
00w_email_folder.bin 
2800000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002c59d0e001d188ef00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d3000000002c59a9d001d188ef2c59d0e001d188ef0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Effffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00001cbb00001aaa00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00001cbb00001aaa00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
2Ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000002c59d0e001d188ef00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000002c59d0e001d188ef2c59d0e001d188ef000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c00000a70000026dc0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c00000a70000026dc0000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000
2000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
10w_email_folder.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
