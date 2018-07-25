$PBExportHeader$w_dm_sertifi_status.srw
forward
global type w_dm_sertifi_status from w_response
end type
type dw_sertifi_data from u_dw within w_dm_sertifi_status
end type
type st_link from statictext within w_dm_sertifi_status
end type
type cb_preview from commandbutton within w_dm_sertifi_status
end type
type cb_checkin from commandbutton within w_dm_sertifi_status
end type
type dw_signer_status from u_dw within w_dm_sertifi_status
end type
type dw_doc_status from u_dw within w_dm_sertifi_status
end type
type cb_close from commandbutton within w_dm_sertifi_status
end type
type gb_1 from groupbox within w_dm_sertifi_status
end type
type gb_2 from groupbox within w_dm_sertifi_status
end type
type gb_3 from groupbox within w_dm_sertifi_status
end type
end forward

global type w_dm_sertifi_status from w_response
integer x = 214
integer y = 221
integer width = 3337
integer height = 1896
string title = "Sertifi Document Status"
long backcolor = 33551856
event ue_systemcommand pbm_syscommand
dw_sertifi_data dw_sertifi_data
st_link st_link
cb_preview cb_preview
cb_checkin cb_checkin
dw_signer_status dw_signer_status
dw_doc_status dw_doc_status
cb_close cb_close
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_dm_sertifi_status w_dm_sertifi_status

type variables
str_sertifi_file istr_sertifi_file
str_sertifi_doc  istr_sertifi_doc
String is_pathfullfilename,is_esigntype 

string is_license_user_id  // (Appeon)Harry 07.11.2016 - for docusign
end variables

forward prototypes
public function integer wf_sendappointment (string as_email)
end prototypes

event ue_systemcommand;If message.wordparm = 61536 Then // if click close (X) button on title bar.
	cb_close.Trigger Event Clicked()
End If

Return 1
end event

public function integer wf_sendappointment (string as_email);String							ls_AppointmentList, ls_to_AppointmentList[]
String							ls_errtext, ls_email_type, ls_computer_info, ls_ctxidlist, ls_docidlist
n_cst_easymail_smtp 	lnv_Mail
Long							ll_Return, li_send_result, ll_email_template_id
Long							ll_ctx_id_list[]
n_cst_string					lnv_string
DateTime					ldt_duedate

ls_AppointmentList = dw_sertifi_data.GetItemString( 1, 'dw_sertifi_data' )


//__________send appointment_________________//added by gavins 20121025
If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '1' And Len( ls_AppointmentList ) > 1 And Pos( ls_AppointmentList, as_email ) > 0 Then
	
//	//Create Email object
//	if lnv_Mail.of_CreateObject() = -1 then
//		f_show_message('create Email object','','','','')
//		Return -1
//	end if
//	
//	lnv_string.of_parsetoarray( ls_AppointmentList,';',ls_to_AppointmentList[])
//	lnv_string.of_delete_duplicate( ls_to_AppointmentList[])
//	lnv_string.of_arraytostring(ls_to_AppointmentList[], ';', ls_AppointmentList)
//	
//	li_send_result =0	
//	
//	If IsNull( ldt_duedate ) Then ldt_duedate = datetime( today( ) )
//	lnv_Mail.of_setappointmentarguments( true, ldt_duedate , '' )
//	ll_Return = lnv_Mail.of_sendtext(gs_user_id, ls_AppointmentList,'', '','Appointment for Contractlogix Sandbox Documents for E-signatue',ls_message ,'')
//	//Show Error Info	
//	if ll_Return <> 0 then
//		f_show_message('error_code_'+string(ll_Return),'%1S%',String(ll_Return),'','')
//		lnv_Mail.of_DeleteObject()
//		li_send_result = -1
//	end if
//	
//	//Added Email Audit  
//	If ll_Return <> 0 then 
//		ls_errtext = gnv_message.of_get_error_message( ll_Return)
//	End If
//	ls_email_type = 'Electronic signature'
//
//	ls_computer_info = lnv_Mail.of_get_compute_info( )
//	
//	ll_ctx_id_list[] = istr_ctx_email.ctx_id_list[]
//	inv_string.of_delete_duplicate( ll_ctx_id_list[] )
//	inv_string.of_arraytostring( ll_ctx_id_list, ',', ls_ctxidlist)
//	inv_string.of_arraytostring( istr_ctx_email.doc_id_list[], ',', ls_docidlist)
//	
//	For i = 1 To UpperBound( istr_ctx_email.doc_id_list[] )
//		update Ctx_am_document set alm_appointment = :ls_AppointmentList where Doc_id = :istr_ctx_email.doc_id_list[i];
//	Next
//	
//	Insert Into em_mail_audit
//	(user_id,mail_from,mail_to,mail_cc,mail_bcc,mail_subject,mail_date,mail_attach_name,mail_template_id,ctx_id_list,doc_id_list,ai_id_list,wf_id,alarm_type,field_name,send_result,error_text,notes,compute_info)
//	Values 
//	(:gs_user_id,:gs_user_id,:ls_AppointmentList,'','','Appointment for Contractlogix Sandbox Documents for E-signatue',getdate(),'', :ll_email_template_id,:ls_ctxidlist,:ls_docidlist,'',null,:ls_email_type,'',:li_send_result,:ls_errtext,null,:ls_computer_info);
//	
//	lnv_Mail.of_DeleteObject()
End If

//_________________________________________//











RETURN 1
end function

on w_dm_sertifi_status.create
int iCurrent
call super::create
this.dw_sertifi_data=create dw_sertifi_data
this.st_link=create st_link
this.cb_preview=create cb_preview
this.cb_checkin=create cb_checkin
this.dw_signer_status=create dw_signer_status
this.dw_doc_status=create dw_doc_status
this.cb_close=create cb_close
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_sertifi_data
this.Control[iCurrent+2]=this.st_link
this.Control[iCurrent+3]=this.cb_preview
this.Control[iCurrent+4]=this.cb_checkin
this.Control[iCurrent+5]=this.dw_signer_status
this.Control[iCurrent+6]=this.dw_doc_status
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
this.Control[iCurrent+10]=this.gb_3
end on

on w_dm_sertifi_status.destroy
call super::destroy
destroy(this.dw_sertifi_data)
destroy(this.st_link)
destroy(this.cb_preview)
destroy(this.cb_checkin)
destroy(this.dw_signer_status)
destroy(this.dw_doc_status)
destroy(this.cb_close)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event pfc_preopen;call super::pfc_preopen;string ls_license_from,ls_text  // (Appeon)Harry 07.11.2016 - for docusign
istr_sertifi_doc = Message.Powerobjectparm
//Added By Jay Chen 10-18-2013
//select esign_type into :is_esigntype from ctx_am_document where es_docid = :istr_sertifi_doc.as_es_docid;
//if not istr_sertifi_doc.ab_history then   // (Appeon)Harry 07.11.2016 - for docusign
	select esign_type,es_license_user_id into :is_esigntype,:is_license_user_id from ctx_am_document where doc_id = :istr_sertifi_doc.al_doc_id; // (Appeon)Harry 07.11.2016 - for docusign
//else
//	is_esigntype = istr_sertifi_doc.as_esign_type
//	is_license_user_id = istr_sertifi_doc.as_esign_license_user_id
//end if
if isnull(is_esigntype) or is_esigntype = '' then is_esigntype = gs_esigntype

// (Appeon)Harry 07.11.2016 - for docusign
if isnull(is_license_user_id) or is_license_user_id = '' then is_license_user_id = "global_license_user"
if is_license_user_id = "global_license_user" then
	ls_license_from = " From Global License"
else
	ls_license_from = " From " + is_license_user_id + " License"
end if


choose case is_esigntype
	case  'sertifi'
		this.title = 'Sertifi Document Status'
		st_link.text = 'Sertifi Document Maintenance Link'
		gb_1.text = 'Sertifi Document Info'
		dw_sertifi_data.modify("es_apicode_t.text = 'Sertifi API Code'")
		dw_sertifi_data.modify("es_fileid_t.text = 'Sertifi File ID'")
		dw_sertifi_data.modify("es_docid_t.text = 'Sertifi Document ID'")
	case 'echosign'
		this.title = 'Echosign Document Status'
		st_link.text = 'Echosign Document Quick View Link'
		gb_1.text = 'Echosign Document Info'
		dw_doc_status.dataobject = 'd_am_echosign_doc_status'
		dw_signer_status.dataobject = 'd_am_echosign_doc_signer_status'
		dw_sertifi_data.dataobject = 'd_am_echosign_info'
		dw_sertifi_data.modify("es_apicode_t.text = 'Echosign API Code'")
		dw_sertifi_data.modify("es_fileid_t.text = 'Echosign File ID'")
		dw_sertifi_data.modify("es_docid_t.text = 'Echosign Document ID'")
	case 'docusign'  // (Appeon)Harry 07.11.2016 - for docusign
		this.title = 'Docusign Document Status'
		st_link.text = 'Docusign Document Quick View Link'
		gb_1.text = 'Docusign Document Info'
		dw_doc_status.dataobject = 'd_am_docusign_doc_status'
		dw_signer_status.dataobject = 'd_am_docusign_doc_signer_status'
		dw_sertifi_data.dataobject = 'd_am_docusign_info'
		ls_text = 'Docusign API Code' + ls_license_from
		dw_sertifi_data.modify("es_apicode_t.text = '"+ls_text+"'" )
end choose
//end added

dw_doc_status.InsertRow(0)
dw_sertifi_data.InsertRow(0)


end event

event pfc_postopen;call super::pfc_postopen;Integer li_ret
String ls_filestatus,ls_link, ls_AppointmentList
str_sertifi_file lstr_sertifi_file
Long i,j,ll_row
Boolean lb_exists = False, lb_signed = False
u_tabpg_dm_data uo_document 

//Added By Jay Chen 10-18-2013
If not isvalid(w_appeon_gifofwait) Then  
    choose case is_esigntype
		case  'sertifi'
			OpenwithParm(w_appeon_gifofwait,"Getting document status from sertifi server...")		
		case 'echosign'
			OpenwithParm(w_appeon_gifofwait,"Getting document status from echosign server...")
		case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
			OpenwithParm(w_appeon_gifofwait,"Getting document status from docusign server...")
	end choose
end if	

//Set sertifi document info
dw_sertifi_data.SetItem(1,'es_apicode',istr_sertifi_doc.as_es_apicode )
dw_sertifi_data.SetItem(1,'es_fileid',istr_sertifi_doc.as_es_fileid )
dw_sertifi_data.SetItem(1,'es_docid',istr_sertifi_doc.as_es_docid )
dw_doc_status.SetItem(1, 'inviteremail', istr_sertifi_doc.as_es_email )
dw_doc_status.SetItem(1, 'inviter', istr_sertifi_doc.as_es_sender )

//Get Sertifi Info from Server
SetPointer(HourGlass!)
choose case is_esigntype //Modified By Jay Chen 10-18-2013
	case 'sertifi'
		li_ret = gnv_sertifi.of_get_doc_status( istr_sertifi_doc, lstr_sertifi_file,true )
	case 'echosign'
		li_ret = gnv_echosign.of_get_doc_status( istr_sertifi_doc, lstr_sertifi_file,true )
	case 'docusign'  // (Appeon)Harry 07.11.2016 - for docusign
		li_ret = gnv_docusign.of_get_doc_status( istr_sertifi_doc, lstr_sertifi_file,true,is_license_user_id ) 
end choose
If li_ret < 0 Then
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
	cb_preview.enabled = False
	cb_checkin.enabled = False
	Return
End If

//Get Maintance Link. 
choose case is_esigntype //Modified By Jay Chen 10-18-2013
	case 'sertifi'
		ls_link = gnv_sertifi.of_get_doc_maintance_link(istr_sertifi_doc)
	case 'echosign'
		ls_link = gnv_echosign.of_get_doc_maintance_link(istr_sertifi_doc)
	case 'docusign'  // (Appeon)Harry 07.11.2016 - for docusign
		ls_link = gnv_docusign.of_get_doc_maintance_link(istr_sertifi_doc,is_license_user_id) 
end choose

//Set Sertifi info to dw
dw_doc_status.SetRedraw(False)
dw_signer_status.SetRedraw(False)
dw_doc_status.SetItem(1, 'filename', istr_sertifi_doc.as_es_fileid )
For i = 1 To UpperBound(lstr_sertifi_file.astr_sertifi_document[] )
	If istr_sertifi_doc.as_es_docid = lstr_sertifi_file.astr_sertifi_document[i].DocumentID Then
		dw_doc_status.SetItem(1, 'invitedate', lstr_sertifi_file.astr_sertifi_document[i].DateCreated  )
		dw_doc_status.SetItem(1, 'documentname', lstr_sertifi_file.astr_sertifi_document[i].Name  )
		dw_doc_status.SetItem(1, 'docstatus', lstr_sertifi_file.astr_sertifi_document[i].Status  )

		//Set Button status
		if is_esigntype = 'docusign' then  // (Appeon)Harry 07.11.2016 - for docusign
			If lower(lstr_sertifi_file.astr_sertifi_document[i].Status) = 'completed' Then
				lb_signed = True
				cb_preview.enabled = True
				If istr_sertifi_doc.as_checkout_by = gs_user_id Then
					cb_checkin.enabled = True
				End If
			End If		
		else
			If lower(lstr_sertifi_file.astr_sertifi_document[i].Status) = 'signed' Then
				lb_signed = True
				cb_preview.enabled = True
				If istr_sertifi_doc.as_checkout_by = gs_user_id Then
					cb_checkin.enabled = True
				End If
			End If		
		end if
		
		// (Appeon) Added ByHarry 07.11.2016  set document status to declined when decline signature
		if lower(lstr_sertifi_file.astr_sertifi_document[i].Status) = 'declined' then
			lb_signed = False
			cb_preview.enabled = True
			If istr_sertifi_doc.as_checkout_by = gs_user_id Then
				cb_checkin.enabled = True
			End If
			If gnv_docusign.il_doc_declined  > 0 Then
				Update Ctx_am_document Set status = :gnv_docusign.il_doc_declined Where doc_id = :istr_sertifi_doc.al_doc_id;
			End If
			//added by gavins 20160525   //or Action_type = :gnv_docusign.il_doccheckin
			If gnv_docusign.il_action_declined  > 0  Then
				Update ctx_am_action_item Set Action_status = :gnv_docusign.il_action_declined 
						Where doc_id = :istr_sertifi_doc.al_doc_id and (Action_type = :gnv_docusign.il_esign  )  
								and Action_status = :gnv_docusign.il_incomplete and (es_docid = :istr_sertifi_doc.as_es_docid or es_docid is null) ;
			End If
			if IsValid(gw_contract) then	
				uo_document = gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data
				uo_document.event ue_retrieve()
				uo_document.of_locate_doc(istr_sertifi_doc.al_doc_id)
			end if
		end if
		//end
		
		For j = 1 To UpperBound(lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[])
			ll_row = dw_signer_status.InsertRow(0)
			dw_signer_status.SetItem(ll_row, 'signeremail', lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].Email )
			dw_signer_status.SetItem(ll_row, 'NameSigned', lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].NameSigned )
			dw_signer_status.SetItem(ll_row, 'signerip', lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].IpAddress )
			dw_signer_status.SetItem(ll_row, 'signeddate', lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].DateSigned )
			dw_signer_status.SetItem(ll_row, 'signertype', lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].SignerType )
		Next
		lb_exists = True
		Exit
	End If
Next

dw_doc_status.SetRedraw(True)
dw_signer_status.SetRedraw(True)

//Write log if error
If Not lb_exists Then
	If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
	gnv_debug.of_output( True, 'Failed to parse the Sertifi XML.')
	gnv_debug.of_output( True, 'sertifi_apicode: ' + istr_sertifi_doc.as_es_apicode )
	gnv_debug.of_output( True, 'sertifi_fileid: ' + istr_sertifi_doc.as_es_fileid )
	gnv_debug.of_output( True, 'sertifi_docid: ' + istr_sertifi_doc.as_es_docid )
	Messagebox('Error','Failed to parse the XML to datawindow, please call support.')
	cb_preview.enabled = False
	cb_checkin.enabled = False
	Return 
End If

//Set the maintaince link
If ls_link <> '' Then
	st_link.tag = ls_link
Else
	st_link.text = ls_link
End If

choose case is_esigntype //Added By Jay Chen 10-18-2013
	case 'sertifi'
		If istr_sertifi_doc.as_checkout_by = gs_user_id or gnv_sertifi.is_emailaddress = istr_sertifi_doc.as_es_email Then
			st_link.visible = True
		End If
	case 'echosign'
		If istr_sertifi_doc.as_checkout_by = gs_user_id or gnv_echosign.is_emailaddress = istr_sertifi_doc.as_es_email Then
			st_link.visible = True
		End If
	case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
		If istr_sertifi_doc.as_checkout_by = gs_user_id or gnv_docusign.is_emailaddress = istr_sertifi_doc.as_es_email Then
			st_link.visible = True
		End If
end choose

//Set the document status to Document Manager
If istr_sertifi_doc.as_checkout_status = '5' and lb_signed Then
	istr_sertifi_doc.as_checkout_status = '6'
	gnv_appeondb.of_startqueue( )		
		//Modified By Jay Chen 10-18-2013
//		Update Ctx_am_document Set checkout_status = '6' Where doc_id = :istr_sertifi_doc.al_doc_id; 
         choose case is_esigntype
				case 'sertifi'
         			Update Ctx_am_document Set checkout_status = '6',status = :gnv_sertifi.il_doc_signed Where doc_id = :istr_sertifi_doc.al_doc_id;
					Update ctx_am_action_item Set Action_status = :gnv_sertifi.il_signed
					Where doc_id = :istr_sertifi_doc.al_doc_id and (Action_type = :gnv_sertifi.il_esign or Action_type = :gnv_sertifi.il_doccheckin) 
							and Action_status = :gnv_sertifi.il_incomplete and (es_docid = :istr_sertifi_doc.as_es_docid or es_docid is null) ;
			  	case 'echosign'
					Update Ctx_am_document Set checkout_status = '6',status = :gnv_echosign.il_doc_signed Where doc_id = :istr_sertifi_doc.al_doc_id;
					Update ctx_am_action_item Set Action_status = :gnv_echosign.il_signed
					Where doc_id = :istr_sertifi_doc.al_doc_id and (Action_type = :gnv_echosign.il_esign  or Action_type = :gnv_echosign.il_doccheckin)  
							and Action_status = :gnv_echosign.il_incomplete and (es_docid = :istr_sertifi_doc.as_es_docid or es_docid is null) ;
				case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
					Update Ctx_am_document Set checkout_status = '6',status = :gnv_docusign.il_doc_signed Where doc_id = :istr_sertifi_doc.al_doc_id;
					Update ctx_am_action_item Set Action_status = :gnv_docusign.il_signed
					Where doc_id = :istr_sertifi_doc.al_doc_id and ( Action_type = :gnv_docusign.il_doccheckin or Action_type = :gnv_docusign.il_esign)  //Modified By Jay Chen 10-15-2013
							and Action_status = :gnv_docusign.il_incomplete and (es_docid = :istr_sertifi_doc.as_es_docid or es_docid is null) ;
		end choose
		//end Modify
	gnv_appeondb.of_commitqueue( )
End If
//******************************************//added by gavins 20121025
//select alm_appointment into:ls_AppointmentList from Ctx_am_document where doc_id = :istr_sertifi_doc.al_doc_id;
//dw_sertifi_data.SetItem( 1, 'alm_appointment', ls_AppointmentList )

//******************************************//
If isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)
Return 
end event

type dw_sertifi_data from u_dw within w_dm_sertifi_status
integer x = 87
integer y = 1384
integer width = 3136
integer height = 208
integer taborder = 20
string dataobject = "d_am_sertifi_info"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type st_link from statictext within w_dm_sertifi_status
boolean visible = false
integer x = 64
integer y = 1696
integer width = 1051
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 134217856
long backcolor = 33551856
string text = "Sertifi Document Maintenance Link"
boolean focusrectangle = false
end type

event clicked;String ls_null,ls_url

Setnull(ls_null)

ls_url = This.tag
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
end event

type cb_preview from commandbutton within w_dm_sertifi_status
integer x = 2203
integer y = 1684
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Preview"
end type

event clicked;String ls_file,ls_null
Setnull(ls_null)

If Not FileExists(is_pathfullfilename) Then
	choose case is_esigntype  //Modified By Jay Chen 10-18-2013
		case 'sertifi'
			ls_file = gnv_sertifi.of_download_doc(istr_sertifi_doc)
		case 'echosign'
			ls_file = gnv_echosign.of_download_doc(istr_sertifi_doc)
		case 'docusign'  // (Appeon)Harry 07.11.2016 - for docusign
			ls_file = gnv_docusign.of_download_doc(istr_sertifi_doc,is_license_user_id) //Added By Jay Chen 09-04-2014
	end choose 
	If Not FileExists(ls_file) Then
		Messagebox('Error','Failed to download the document from signature server.')
		Return
	End If	
	is_pathfullfilename = ls_file
End If

ShellExecuteA ( Handle( This ), ls_Null, is_pathfullfilename , ls_Null, ls_Null, 4)

end event

type cb_checkin from commandbutton within w_dm_sertifi_status
integer x = 2560
integer y = 1684
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Check &In"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// Event: clicked()
// Arguments:
//--------------------------------------------------------------------
// Return:  long
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-16.
//--------------------------------------------------------------------
// Description: Check In the Document from sertifi.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

str_add_doc lstr_add_doc
lstr_add_doc.doc_id = istr_sertifi_doc.al_doc_id

SetPointer(HourGlass!)
//Get document from sertifi.
If Not FileExists(is_pathfullfilename) Then
	//Added By Jay Chen 10-18-2013 
	choose case is_esigntype
		case 'sertifi'
			is_pathfullfilename = gnv_sertifi.of_download_doc(istr_sertifi_doc)
		case 'echosign'
			is_pathfullfilename = gnv_echosign.of_download_doc(istr_sertifi_doc)
		case 'docusign'   // (Appeon)Harry 07.11.2016 - for docusign
			is_pathfullfilename = gnv_docusign.of_download_doc(istr_sertifi_doc,is_license_user_id) //Added By Jay Chen 09-04-2014
	end choose
	If Not FileExists(is_pathfullfilename) Then
		Messagebox('Error','Failed to download the document from signature server.')
		Return
	End If
End If

//Check In the Document
lstr_add_doc.doc_from = 'DM_BROWSE'
lstr_add_doc.new = FALSE
lstr_add_doc.checkout_status = istr_sertifi_doc.as_checkout_status
lstr_add_doc.operation = 'checkin'
lstr_add_doc.astr_sertifi_doc = istr_sertifi_doc
lstr_add_doc.ab_sertifi_auto = True
lstr_add_doc.Revision_control = True
lstr_add_doc.filepathname = is_pathfullfilename
lstr_add_doc.filename = istr_sertifi_doc.as_filename

OpenWithParm( w_dm_checkin_document, lstr_add_doc )

If Message.doubleparm <> 1 Then Return

istr_sertifi_doc.as_checkout_status= '0' //reset the status.

CloseWithReturn(Parent,istr_sertifi_doc)



end event

type dw_signer_status from u_dw within w_dm_sertifi_status
integer x = 96
integer y = 592
integer width = 3136
integer height = 652
integer taborder = 20
string dataobject = "d_am_sertifi_doc_signer_status"
boolean hscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

event buttonclicked;call super::buttonclicked;String ls_emailaddress

If row <= 0 Then Return

//Invite again
If lower(dwo.name) = 'b_invite' Then
	ls_emailaddress = This.GetItemString(row, 'signeremail')	
	 // (Appeon)Modified by Harry 07.11.2016 - for docusign
//	If gnv_sertifi.of_invite_again(istr_sertifi_doc,ls_emailaddress) = 1 Then
//		Messagebox('Sertifi','Invitation email is sent successfully.')
//	End If
	choose case is_esigntype //Modified By Jay Chen 04-30-2014
		case 'sertifi'
			If gnv_sertifi.of_invite_again(istr_sertifi_doc,ls_emailaddress) = 1 Then
				Messagebox('Sertifi','Invitation email is sent successfully.')
			End If
		case 'docusign'
			If gnv_docusign.of_invite_again(istr_sertifi_doc,ls_emailaddress,is_license_user_id) = 1 Then //Added By Jay Chen 09-04-2014
				Messagebox('Docusign','Invitation email is sent successfully.')
			End If
	end choose
	//End  modified---------
End If
end event

type dw_doc_status from u_dw within w_dm_sertifi_status
integer x = 91
integer y = 100
integer width = 3095
integer height = 372
integer taborder = 10
string dataobject = "d_am_sertifi_doc_status"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_setupdateable(false)
end event

type cb_close from commandbutton within w_dm_sertifi_status
integer x = 2917
integer y = 1684
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,istr_sertifi_doc)
end event

type gb_1 from groupbox within w_dm_sertifi_status
integer x = 59
integer y = 1324
integer width = 3214
integer height = 288
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Sertifi Document Info"
end type

type gb_2 from groupbox within w_dm_sertifi_status
integer x = 59
integer y = 24
integer width = 3214
integer height = 472
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Document Status"
end type

type gb_3 from groupbox within w_dm_sertifi_status
integer x = 59
integer y = 516
integer width = 3214
integer height = 784
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Signature Status"
end type

