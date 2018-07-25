$PBExportHeader$n_cst_sertifi.sru
forward
global type n_cst_sertifi from nonvisualobject
end type
end forward

global type n_cst_sertifi from nonvisualobject
end type
global n_cst_sertifi n_cst_sertifi

type variables
SoapConnection isoap_conn
//Sertifigatewaysoap isoap_sertifi  
sertifisertifisoap isoap_sertifi  //(appeon) Harry 06.27.2016
String is_apicode,is_emailaddress
Long il_esign, il_complete,il_incomplete,il_signed,il_doccheckin,il_doc_signed

Boolean ib_isvalid_sertifi = False

//---------Begin Modified by (Appeon)Harry 07.13.2013 for V141 ISG-CLX--------
//String ls_soap_link = 'http://web.contractlogix.com/templates/soapsdk.exe'
String ls_soap_link = 'http://web.intellisoftgroup.com/templates/soapsdk.exe'
//---------End Modfiied ------------------------------------------------------


end variables

forward prototypes
public function string of_get_apicode ()
public function integer of_create ()
public function boolean of_check_sertifi ()
public function string of_paser_keyword (string as_source, string as_keyword)
public function long of_hex2dec (string as_hex)
public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc)
public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email)
public function string of_download_doc (str_sertifi_doc astr_sertifi_doc)
public function integer of_parse_file_status (string as_status_xml, ref str_sertifi_file astr_sertifi_file, ref string as_error)
public function integer of_show_sertifi_status (str_sertifi_doc astr_sertifi_doc, boolean ab_refresh)
public function integer of_show_sertifi_status (long al_docid, string as_es_docid, string as_type, boolean ab_refresh)
public function integer of_invitesigners (str_sertifi_doc astr_sertifi_doc, string as_user)
public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc)
public function integer of_refresh_sertifi_status (long al_ctx_id, long al_doc_id)
public function boolean of_get_doc_signed_status (str_sertifi_doc astr_sertifi_doc)
public function boolean of_get_doc_signed_status (string as_sertifi_docid, str_sertifi_file astr_sertifi_file)
public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror)
public function integer of_refresh_sertifi_status ()
public function integer of_ping_apicode (string as_apicode)
public function integer of_ping_apicode ()
public function boolean of_check_sertifi (boolean ab_ping_apicode)
public function boolean of_ping_sertifi_server ()
public function integer of_refresh_sertifi_status_bak (long al_prac_id, long al_rec_id, long al_app_id)
public function integer of_refresh_sertifi_status (long al_prac_id, long al_rec_id, long al_app_id)
public function integer of_download_from_sertifi (long al_rec_id)
end prototypes

public function string of_get_apicode ();is_apicode = gnv_data.of_getitem( 'icred_settings', 'es_apicode', False)
Return is_apicode
end function

public function integer of_create ();long ll_ret = -1

If isvalid(isoap_sertifi) Then Return 0

Try
	isoap_conn = Create SoapConnection
	//ll_ret = isoap_conn.CreateInstance(isoap_sertifi, "sertifigatewaysoap")
	ll_ret = isoap_conn.CreateInstance(isoap_sertifi, "sertifisertifisoap")  //(appeon) Harry 06.27.2016
	
	If ll_ret <> 0 Then
		If isvalid(isoap_sertifi) Then Destroy isoap_sertifi
	End If
Catch (throwable e1)
	If isvalid(isoap_sertifi) Then Destroy isoap_sertifi
	Return -1
End Try

Return ll_ret
end function

public function boolean of_check_sertifi ();Return of_check_sertifi(True)



end function

public function string of_paser_keyword (string as_source, string as_keyword);//////////////////////////////////////////////////////////////////////
// Function: of_paser_keyword()
// Arguments:
// 	value    string    as_source
// 	value    string    as_keyword
//--------------------------------------------------------------------
// Return:  string
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-14.
//--------------------------------------------------------------------
// Description: Get value by Key Word from XML
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
long ll_pos_start,ll_pos_end,ll_line_end
long ll_start,ll_end,ll_pos
String ls_line_value, ls_value
String ls_hex
Long ll_dec

If as_source = '' Then Return ''

//Get start position
ll_pos_start = Pos(as_source, '<' + as_keyword + '>')
If ll_pos_start = 0 Then Return ''
ll_line_end = Pos(as_source, '~n',ll_pos_start)

//Get Line Value of the Key Word
ls_line_value = Mid(as_source,ll_pos_start,ll_line_end - ll_pos_start )

//If no value
If Pos(ls_line_value,'/>') > 0 Then Return ''

//Get end position
ll_pos_end = Pos(as_source, '</' + as_keyword + '>',ll_pos_start )
If ll_pos_end = 0 Then Return ''

//Get value
ls_value = Mid(as_source, ll_pos_start + Len(as_keyword) + 2, ll_pos_end - (ll_pos_start + Len(as_keyword) + 2) )


If as_keyword = 'DocumentID' Then
	ll_pos = Pos(ls_value,'%',1)
	Do While ll_pos > 0 
		ls_hex = Mid(ls_value, ll_pos + 1, 2)
		ll_dec = This.of_hex2dec(ls_hex)
		ls_value = Replace( ls_value, ll_pos, 3, Char(ll_dec) )
		ll_pos = Pos(ls_value,'%',1)
	Loop
End If

Choose Case as_keyword
	Case 'DocumentID' ////Convert Hex to Dec for DocumentID.
		ll_pos = Pos(ls_value,'%',1)
		Do While ll_pos > 0 
			ls_hex = Mid(ls_value, ll_pos + 1, 2)
			ll_dec = This.of_hex2dec(ls_hex)
			ls_value = Replace( ls_value, ll_pos, 3, Char(ll_dec) )
			ll_pos = Pos(ls_value,'%',1)
		Loop		
	Case 'DateSigned','DateCreated' //Set 01/01/0001 to empty.
		If Pos(ls_value,'0001') > 0 Then
			ls_value = ''
		End If
End Choose



Return ls_value
end function

public function long of_hex2dec (string as_hex);//////////////////////////////////////////////////////////////////////
// Function: of_hex2dec()
// Arguments:
// 	value    string    as_hex
//--------------------------------------------------------------------
// Return:  long
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-14.
//--------------------------------------------------------------------
// Description: Convert Hex to Dec numeric
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

Long i,j, ll_value
String ls_char

For i = Len(as_hex) to 1 Step -1
	j++
	ls_char = Lower(Mid(as_hex,i,1))
	Choose Case ls_char
		Case '0'	to '9'
			ll_value += 16^(j - 1) * Long(ls_char)
		Case 'a' 
			ll_value += 16^(j - 1) * 10
		Case 'b'	
			ll_value += 16^(j - 1) * 11
		Case 'c'
			ll_value += 16^(j - 1) * 12
		Case 'd'
			ll_value += 16^(j - 1) * 13
		Case 'e'
			ll_value += 16^(j - 1) * 14
		Case 'f'
			ll_value += 16^(j - 1) * 15
	End Choose
Next
	
Return ll_value
end function

public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc);String ls_link = 'error'
SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return ''
End If

Try
	ls_link = isoap_sertifi.GetMaintenanceLink( astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid )
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If Left(Lower(ls_link),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error',ls_link)
	Return ''
End If


Return ls_link
end function

public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email);//////////////////////////////////////////////////////////////////////
// Function: of_invite_again()
// Arguments:
// 	value    str_sertifi_doc    astr_sertifi_doc
// 	value    string             as_email
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-15.
//--------------------------------------------------------------------
// Description: Sends out an email to the signer
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_link = 'error'
SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try	
	ls_link = isoap_sertifi.InviteSigner( astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid,'',as_email )
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If Left(Lower(ls_link),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error',ls_link)
	Return -1
End If

Return 1
end function

public function string of_download_doc (str_sertifi_doc astr_sertifi_doc);//////////////////////////////////////////////////////////////////////
// Function: of_download_doc()
// Arguments:
// 	value    str_sertifi_doc    astr_sertifi_doc
//--------------------------------------------------------------------
// Return:  string
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-16.
//--------------------------------------------------------------------
// Description: Download the file from sertifi.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_max,i,ll_readlength,ll_writelength
String ls_SertifiDirectory,ls_FileName
Blob lb_doc
w_appeon_gifofwait lw_appeon_gifofwait

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Downloading document from sertifi server...")		


//Get the file name
ll_max = 100
ls_SertifiDirectory = gs_dir_path + gs_DefDirName + "\Sertifi"
gnv_appeondll.of_parsepath(ls_SertifiDirectory)
IF NOT DirectoryExists(ls_SertifiDirectory) THEN RETURN ""
For i = 1 To ll_max
	If i = 1 Then
		ls_FileName = ls_SertifiDirectory + "\Document" + String(astr_sertifi_doc.al_doc_id) + "_signed.pdf"
	Else
		ls_FileName = ls_SertifiDirectory + "\Document" + String(astr_sertifi_doc.al_doc_id) + "_signed_" +String(i)+".pdf"
	End If
	If FileExists(ls_filename) Then
		If Not FileDelete(ls_filename) Then
			If i = ll_max Then
				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
				Return ''
			End If
			Continue
		Else
			Exit
		End If
	Else
		Exit
	End If
Next

//Download the file from sertifi
SetPointer(HourGlass!)
If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then 
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Return ''
	End If
End If

Try
	lb_doc = isoap_sertifi.downloadsigneddocument( astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid, astr_sertifi_doc.as_es_docid )
Catch (Throwable	E2)	
	Messagebox('Error', E2.text )
End Try	

//Write blob into file
ll_readlength = Len(lb_doc)

If ll_readlength = 0 Then 
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	Return ""
End If

ll_writelength = AppeonWriteFile(ls_FileName, lb_doc, ll_readlength)

If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)

if ll_writelength < 0 then return ""

If FileExists(ls_FileName) Then
	Return ls_FileName
Else
	Return ''
End If


end function

public function integer of_parse_file_status (string as_status_xml, ref str_sertifi_file astr_sertifi_file, ref string as_error);//////////////////////////////////////////////////////////////////////
// Function: of_parse_file_status()
// Arguments:
// 	value        string              as_status_xml
// 	reference    str_sertifi_file    lstr_sertifi_file
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-14.
//--------------------------------------------------------------------
// Description: Parse XML to Structure
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long ll_pos_code
String ls_file,ls_document,ls_signature[],ls_signature_empty[],ls_signatures,ls_documents
str_sertifi_file lstr_sertifi_file
Long ll_doc_pos,ll_sign_pos,ll_sign_end_pos,i,j,ll_email_pos,ll_email_next_pos

//Check XML
If as_status_xml = '' or isnull(as_status_xml) Then Return -1
If Pos(Lower(as_status_xml),'xml') <= 0 Then
	as_error = ' No XML data.'
End If

If Pos(as_status_xml,'<Document>') <= 0 Then 
	as_error = ' The document maybe has been removed on the sertifi server.'
	Return -2
End If

If Pos(as_status_xml,'<Signatures>') <= 0 Then 
	as_error = ' The signatures maybe have been removed on the sertifi server.'
	Return -3
End If


//Get Sertifi File Info
lstr_sertifi_file.code = This.of_paser_keyword( as_status_xml, 'Code')
lstr_sertifi_file.name = This.of_paser_keyword( as_status_xml, 'Name')
lstr_sertifi_file.Status = This.of_paser_keyword( as_status_xml, 'Status')

i = 0
ll_doc_pos = Pos(as_status_xml, '<Document>')
Do While ll_doc_pos > 0
	i++
	//Get Sertifi Document Info
	ls_documents = Mid(as_status_xml, ll_doc_pos)
	ls_document = This.of_paser_keyword( ls_documents, 'Document')
	lstr_sertifi_file.astr_sertifi_document[i].DocumentID  = This.of_paser_keyword( ls_document, 'DocumentID')
	lstr_sertifi_file.astr_sertifi_document[i].Name  = This.of_paser_keyword( ls_document, 'Name')
	lstr_sertifi_file.astr_sertifi_document[i].Status  = This.of_paser_keyword( ls_document, 'Status')
	lstr_sertifi_file.astr_sertifi_document[i].DateCreated  = This.of_paser_keyword( ls_document, 'DateCreated')	
	lstr_sertifi_file.astr_sertifi_document[i].DateSigned  = This.of_paser_keyword( ls_document, 'DateSigned')
		
	//Get Sertifi Signature Info
	ls_signature[] = ls_signature_empty[]
	ll_sign_pos = Pos(ls_document, '<Signatures>')
	ll_sign_end_pos = Pos(ls_document, '</Signatures>')
	If ll_sign_pos > 0 Then
		ls_signatures = This.of_paser_keyword( ls_document, 'Signatures')
		ll_email_pos = Pos(ls_document,'<Email>')
		If ll_email_pos <= 0 Then Continue
		ll_email_next_pos = Pos(ls_document,'<Email>',ll_email_pos + 7)
		Do While ll_email_next_pos > 0
			ls_signature[UpperBound(ls_signature[]) + 1] = Mid(ls_document,ll_email_pos, ll_email_next_pos - ll_email_pos )
			ll_email_pos = ll_email_next_pos
			ll_email_next_pos = Pos(ls_document,'<Email>',ll_email_pos + 7)
		Loop
		ls_signature[UpperBound(ls_signature[]) + 1] = Mid(ls_document,ll_email_pos, ll_sign_end_pos - ll_email_pos )

		For j = 1 To UpperBound(ls_signature[])
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].Email  = This.of_paser_keyword( ls_signature[j], 'Email')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].NameSigned  = This.of_paser_keyword( ls_signature[j], 'NameSigned')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].IpAddress  = This.of_paser_keyword( ls_signature[j], 'IpAddress')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].SignMethod  = This.of_paser_keyword( ls_signature[j], 'SignMethod')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].DateSigned  = This.of_paser_keyword( ls_signature[j], 'DateSigned')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].SignerType  = This.of_paser_keyword( ls_signature[j], 'SignerType')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].CustomField1  = This.of_paser_keyword( ls_signature[j], 'CustomField1')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].CustomField2  = This.of_paser_keyword( ls_signature[j], 'CustomField2')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].CustomField3  = This.of_paser_keyword( ls_signature[j], 'CustomField3')
			lstr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[j].CustomField4  = This.of_paser_keyword( ls_signature[j], 'CustomField4')
			ll_sign_pos = Pos(ls_document, '<Signatures>', ll_sign_pos + 12 )
		Next
	End IF

	
	ll_doc_pos = Pos(as_status_xml, '<Document>', ll_doc_pos + 10 )
Loop

astr_sertifi_file = lstr_sertifi_file

Return 1
end function

public function integer of_show_sertifi_status (str_sertifi_doc astr_sertifi_doc, boolean ab_refresh);str_sertifi_doc lstr_sertifi_doc_ret
OpenWithParm(w_dm_sertifi_status,astr_sertifi_doc)

SetPointer(HourGlass!)
//Refresh checkout status if document is signed.
If ab_refresh Then
	If isvalid(Message.powerobjectparm) Then
		lstr_sertifi_doc_ret = Message.powerobjectparm
		If astr_sertifi_doc.as_checkout_status <> lstr_sertifi_doc_ret.as_checkout_status and isvalid(gw_contract) Then
			
			If gw_contract.tab_contract_details.ib_select9 Then
			
				//Refresh the browse window if refresh status or checked in.
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Event ue_retrieve( )
				gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.of_locate_doc(astr_sertifi_doc.al_doc_id)	
			
				If lstr_sertifi_doc_ret.as_checkout_status <> astr_sertifi_doc.as_checkout_status Then
					//Need Refresh Action Item after signed.
					If lstr_sertifi_doc_ret.as_checkout_status = '6' Then //5 become to 6
						If gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_get_doc_id() = astr_sertifi_doc.al_doc_id Then
							gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() 
						End If
					End If
					//Begin - Added By Mark Lee 08/06/12 not exists parameter
//					//Refresh Audit after do checked in
//					If lstr_sertifi_doc_ret.as_checkout_status = '0' Then 
//						gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.Event ue_do('ue_retrieve')
//					End If 
					//End - Added By Mark Lee 08/06/12
				End If
			End If
		Else
		End If
	End If
End If

If astr_sertifi_doc.as_checkout_status = lstr_sertifi_doc_ret.as_checkout_status Then
	Return 0  //no change
Else
	Return 1 //changed
End If


end function

public function integer of_show_sertifi_status (long al_docid, string as_es_docid, string as_type, boolean ab_refresh);str_sertifi_doc lstr_sertifi_doc 
String ls_es_docid

If isnull(as_es_docid) or as_es_docid = '' Then 
	Messagebox('tip','No sertifi document data.')
	Return -1
End If

gnv_appeondb.of_startqueue( )
	Select Top 1 doc_name = (select doc_name from ctx_am_document where doc_id = :al_docid) ,  ctx_am_doc_audit.es_apicode,ctx_am_doc_audit.es_fileid,ctx_am_doc_audit.es_docid,ctx_am_doc_audit.es_sender,ctx_am_doc_audit.es_sender_email 
	Into :lstr_sertifi_doc.as_filename, :lstr_sertifi_doc.as_es_apicode, :lstr_sertifi_doc.as_es_fileid, :lstr_sertifi_doc.as_es_docid, :lstr_sertifi_doc.as_es_sender, :lstr_sertifi_doc.as_es_email 
	From ctx_am_action_item, Ctx_am_doc_audit 
	Where ctx_am_action_item.doc_id =:al_docid And ctx_am_action_item.doc_id = Ctx_am_doc_audit.doc_id And Ctx_am_doc_audit.es_docid = :as_es_docid ;
	
	Select checkout_by, checkout_status, es_docid
	Into :lstr_sertifi_doc.as_checkout_by, :lstr_sertifi_doc.as_checkout_status ,:ls_es_docid
	From ctx_am_document
	Where doc_id = :al_docid;
gnv_appeondb.of_commitqueue( )

If ls_es_docid = lstr_sertifi_doc.as_es_docid Then
	//ignore
Else
	//not allow check in
	lstr_sertifi_doc.as_checkout_by = ''
	lstr_sertifi_doc.as_checkout_status = '0'
End If

lstr_sertifi_doc.as_type = as_type
lstr_sertifi_doc.al_doc_id = al_docid

Return This.of_show_sertifi_status( lstr_sertifi_doc, ab_refresh)


end function

public function integer of_invitesigners (str_sertifi_doc astr_sertifi_doc, string as_user);
String ls_ret = 'error'
SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try
	ls_ret = isoap_sertifi.invitesigners(astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid, as_user)
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If Left(Lower(ls_ret),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error',ls_ret)
	Return -1
End If


Return 1


end function

public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc);
String ls_ret = 'error'
SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try
	ls_ret = isoap_sertifi.removesignaturerequest(astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_fileid)
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If Left(Lower(ls_ret),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error ','Failed to remove the signature request. ' + ls_ret)
	Return -1
End If


Return 1
end function

public function integer of_refresh_sertifi_status (long al_ctx_id, long al_doc_id);//////////////////////////////////////////////////////////////////////
// Function: of_refresh_sertifi_status()
// Arguments:
// 	value    long    al_ctx_id
// 	value    long    al_doc_id
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-21.
//--------------------------------------------------------------------
// Description: Refresh the Sertifi Document Status, Reset Action Status.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
Long i,ll_cnt
String ls_filter,ls_es_fileid,ls_es_apicode,ls_docid_list,ls_es_docid_list,ls_sql
n_ds lds_waiting_sign
str_sertifi_doc lstr_sertifi_doc ,str_sertifi_doc_temp
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp
w_appeon_gifofwait lw_appeon_gifofwait

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	//On
Else
	Return -1
End If

//Get waiting sign documents
lds_waiting_sign = Create n_ds
lds_waiting_sign.Dataobject = 'd_am_sertifi_doc_waiting_sign'
lds_waiting_sign.SetTransObject(SQLCA)
//Added By Mark Lee 08/06/12
lds_waiting_sign.of_set_idle_flag( False)

lds_waiting_sign.Retrieve()
ls_filter = '1 = 1 '
If al_ctx_id > 0 Then
	ls_filter += ' and ctx_id = ' + string(al_ctx_id)
End If
If al_doc_id > 0 Then
	ls_filter += ' and doc_id = ' + string(al_doc_id)
End If

//---------Begin Added by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
ls_filter += " and esign_type = 'sertifi'"  //Added By Jay Chen 10-18-2013
//---------End Added ------------------------------------------------------

lds_waiting_sign.SetFilter(ls_filter)
lds_waiting_sign.Filter()
ll_cnt = lds_waiting_sign.Rowcount( ) 
If ll_cnt = 0 Then Return 1

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Retrieving E-sign documents status from sertifi server...")
timer(0,lw_appeon_gifofwait)
lw_appeon_gifofwait.of_setmaxposition(ll_cnt+2)

//Get Sertifi Sign Status
For i = 1 To ll_cnt
	lw_appeon_gifofwait.of_settext("Retrieving E-sign documents status from sertifi server "+String(i)+'/'+String(ll_cnt)+"...")
	lw_appeon_gifofwait.of_setposition(i)
	
	lstr_sertifi_doc = str_sertifi_doc_temp
	lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'doc_id')
	lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
	lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
	lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
	lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
	lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')
	
	If ls_es_apicode = lstr_sertifi_doc.as_es_apicode and ls_es_fileid = lstr_sertifi_doc.as_es_fileid Then
		//Use prior lstr_sertifi_file when same fileid
	Else
		lstr_sertifi_file = lstr_sertifi_file_temp
		If This.of_get_doc_status( lstr_sertifi_doc, lstr_sertifi_file,false) < 0 Then Continue
	End If

	If This.of_get_doc_signed_status( lstr_sertifi_doc.as_es_docid , lstr_sertifi_file)	Then
		lds_waiting_sign.SetItem(i, 'checkout_status' ,'6')
		If il_doc_signed > 0 Then
			lds_waiting_sign.SetItem(i,'Status',il_doc_signed)
		End If
		ls_docid_list = ls_docid_list + ',' + String(lstr_sertifi_doc.al_doc_id)
		ls_es_docid_list = ls_es_docid_list + ",'" + lstr_sertifi_doc.as_es_docid + "'"
	End If
	
	ls_es_apicode = lstr_sertifi_doc.as_es_apicode
	ls_es_fileid = lstr_sertifi_doc.as_es_fileid
Next

//Update CL Status
If lds_waiting_sign.Modifiedcount( ) > 0 Then
	If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.of_settext('Updating documents status...')
	//Update checkout status
	If lds_waiting_sign.update() = 1 Then
		ls_docid_list = Mid(ls_docid_list,2,Len(ls_docid_list))
		ls_es_docid_list = Mid(ls_es_docid_list,2,Len(ls_es_docid_list))	
		//Update Action item Status
		ls_sql = "Update ctx_am_action_item Set Action_status = " + String(gnv_sertifi.il_signed) + &
					" Where doc_id in (" + ls_docid_list + ") and (Action_type = " + String(gnv_sertifi.il_doccheckin)  + " or  Action_type = " + String(gnv_sertifi.il_esign) + ") "  +&
					" and Action_status = " + String(gnv_sertifi.il_incomplete) + " and (es_docid in ( "+ls_es_docid_list+") or es_docid is null) "		
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;		
		If sqlca.sqlcode <> 0 Then
			gnv_debug.of_output( True, 'Failed to run SQL:' + ls_sql)
			gnv_debug.of_output( True, 'SQLCA Error:' + sqlca.sqlerrtext )
			Messagebox('Error','The document(s) check out status have been updated, but failed to update the action item status.')
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Return -1
		End If
	Else
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Return -2
	End If
Else
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	Return 0
End If

lw_appeon_gifofwait.of_setposition(ll_cnt)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
Return 1
end function

public function boolean of_get_doc_signed_status (str_sertifi_doc astr_sertifi_doc);Integer li_ret = -1
String ls_filestatus
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp

SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return False
End If

Try
	li_ret = This.of_get_doc_status( astr_sertifi_doc, lstr_sertifi_file,false)
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If li_ret < 0 Then
	ib_isvalid_sertifi = False
	Return False
End if

Return of_get_doc_signed_status(astr_sertifi_doc.as_es_docid, lstr_sertifi_file )


end function

public function boolean of_get_doc_signed_status (string as_sertifi_docid, str_sertifi_file astr_sertifi_file);Long i

For i = 1 To UpperBound(astr_sertifi_file.astr_sertifi_document[])
	If as_sertifi_docid = astr_sertifi_file.astr_sertifi_document[i].DocumentID Then
		If astr_sertifi_file.astr_sertifi_document[i].status = 'Signed' Then
			Return True
		End If
	End If
Next

Return False
end function

public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror);String ls_filestatus = 'error'
String ls_error
integer li_ret

SetPointer(HourGlass!)

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try
	ls_filestatus = isoap_sertifi.getfilestatus( astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid,false )
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text )
End Try

If Left(Lower(ls_filestatus),5) = 'error' Then
	If ab_showerror Then Messagebox('Error',ls_filestatus)
	gnv_debug.of_output(True, 'Failed to get file sertifi status.' + ls_filestatus)
	gnv_debug.of_output(True, 'Document ID:' + String(astr_sertifi_doc.al_doc_id ))
	gnv_debug.of_output(True, 'ES File ID:' + astr_sertifi_doc.as_es_fileid  )
	ib_isvalid_sertifi = False
	Return -1
End If

li_ret = This.of_parse_file_status( ls_filestatus, astr_sertifi_file, ls_error)
If li_ret < 0 Then
	If ab_showerror Then Messagebox('Error','Failed to parse the sertifi XML data.' + ls_error)
	gnv_debug.of_output(True, 'Failed to parse the sertifi XML data.' + ls_error)
	gnv_debug.of_output(True, 'Document ID:' + String(astr_sertifi_doc.al_doc_id ))
	gnv_debug.of_output(True, ls_filestatus)
End If

Return li_ret

end function

public function integer of_refresh_sertifi_status ();Integer li_ret

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	//used
Else
	//---------Begin Modified by (Appeon)Harry 08.20.2013 for V141 ISG-CLX--------
	//Messagebox('Sertifi Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.')
	Messagebox('Sertifi Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales for more information.')
	//---------End Modfiied ------------------------------------------------------
	Return 0
End If

li_ret = of_refresh_sertifi_status(0,0)
 
//Refresh document manager data 
If li_ret > 0 Then
	 If isvalid(gw_contract) Then
		If gw_contract.tab_contract_details.ib_select9 Then
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.Event ue_retrieve( )
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.of_retrieve() 
			//Added By Mark Lee 08/06/12 not exists parameter
//			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_action.Event ue_do('ue_retrieve')
		End If
	End If
End If

If li_ret >= 0 Then
	Update ids Set es_last_refresh = getdate();
End If

Return li_ret 
end function

public function integer of_ping_apicode (string as_apicode);//////////////////////////////////////////////////////////////////////
// Function: of_ping_apicode()
// Arguments:
// 	value    string    as_apicode
//--------------------------------------------------------------------
// Return:  boolean
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-14.
//--------------------------------------------------------------------
// Description: Check the Sertifi API Code whether available.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_ret

Try
	//ping a not exists user to test api code.
	ls_ret = Lower(isoap_sertifi.GetUserInfo(as_apicode,'t01e2s3t4e5r6')) 
	
	If ls_ret = '' Then Return -2 //Failed to connect to sertifi server
	
	If Pos(ls_ret, 'invalid user') > 0 Then
		Return 1
	Else
		gnv_debug.of_output(true, 'Ping API code result: ' + ls_ret)
		Return -1
	End If
Catch (Throwable	E2)
	Messagebox('Error',e2.text)
	Return -2 //Failed to connect to sertifi server
End Try

Return -2
end function

public function integer of_ping_apicode ();of_get_apicode()
Return of_ping_apicode(is_apicode)

end function

public function boolean of_check_sertifi (boolean ab_ping_apicode);//////////////////////////////////////////////////////////////////////
// Function: of_check_sertifi()
// Arguments:
// 	value    Booleab    ab_ping_apicode
//--------------------------------------------------------------------
// Return:  boolean
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-21.
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

long ll_ret ,i
String ls_apicode,ls_Key_OCXs[], ls_value, ls_null
String ls_url //alfee 11.08.2016
n_cst_AppeonDll lnv_appeon
Boolean lb_soap_installed = True

Setnull(ls_null)

//Get data from DB
gnv_appeondb.of_startqueue( )
	//Check My Email Address.
	SELECT email INTO :is_emailaddress
	FROM em_smtp_accounts
	WHERE (user_id = :gs_user_id) AND (is_default = 'Y');
	
	if gb_contract_module or gb_contract_version then  //(Appeon)Harry 05.11.2016 - for Application Electronic Signature - Sertifi--------
		//Get Esign,Incomplete,Complte code
		Select Top 1 lookup_code Into :il_esign    From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-Request';
		Select Top 1 lookup_code Into :il_doccheckin From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-CheckIn';
		Select Top 1 lookup_code Into :il_complete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete';
		Select Top 1 lookup_code Into :il_incomplete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete';
		Select Top 1 lookup_code Into :il_signed From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Signed';
		Select Top 1 lookup_code Into :il_doc_signed From code_lookup Where lookup_name = 'Contract Document Status' And code = 'Signed';
	end if

gnv_appeondb.of_commitqueue( )

//---------Begin Added by (Appeon)Harry 05.22.2014 Sertifi Code for IntelliContract--------
//Check SOAP Toolkit whether installed for Web version.
If AppeonGetClientType() = 'WEB' Then
	String ls_ARCHITECTURE
	n_cst_systeminfo lnv_systeminfo
	lnv_systeminfo = Create n_cst_systeminfo
	If lnv_systeminfo.of_get_envvar('ProgramW6432') <> '' or lnv_systeminfo.of_get_envvar('ProgramFiles(x86)')  <> '' Then
		ls_ARCHITECTURE = '64-bit'
	Else
		ls_ARCHITECTURE = '32-bit'
	End If
	If  isvalid(lnv_systeminfo) Then Destroy lnv_systeminfo
	If ls_ARCHITECTURE = '64-bit' Then
		ls_Key_OCXs[1] = "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{05AE7FB3-C4E9-4F79-A5C3-DAB525E31F2C}\InprocServer32"		
		ls_Key_OCXs[2] = "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{0AF40C55-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"																		
		ls_Key_OCXs[3] = "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{0AF40C54-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"
	Else
		ls_Key_OCXs[1] = "HKEY_CLASSES_ROOT\CLSID\{05AE7FB3-C4E9-4F79-A5C3-DAB525E31F2C}\InprocServer32"		
		ls_Key_OCXs[2] = "HKEY_CLASSES_ROOT\CLSID\{0AF40C55-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"																		
		ls_Key_OCXs[3] = "HKEY_CLASSES_ROOT\CLSID\{0AF40C54-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"
	End If
	For i = 1 To UpperBound(ls_Key_OCXs[])
		ls_Value = ''
		lnv_Appeon.of_registryget(ls_Key_OCXs[i],"", RegString!, ls_Value)
		If ls_value = '' Then
			lb_soap_installed = False
			Exit
		End If
	Next
	If Not lb_soap_installed  Then
		If Messagebox('Sertifi Error' + String(ll_ret) ,'The system detected that you do not have SOAP Toolkit installed on your machine. '+ &
		+'You need to install it before you can use the Electronic Signature function. ~r~n~r~nDo you want to download it now??') = 1 Then	
			//------------Begin Added by alfee 11.08.2016 ---------------------------------
			ls_url = Trim(gnv_data.of_getitem( "icred_settings", "downloadurl", false)) 
			If Len(ls_url) > 0 Then 
				If Right(ls_url, 1) <> "/" And Right(ls_url, 1) <> "\" Then ls_url = ls_url + "/"
				ls_soap_link  = ls_url + "soapsdk.exe"
			End If
			//------------End Added -------------------------------------------------------------		
			//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_soap_link , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
			ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_soap_link, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
		End If
		Return False
	End If
End If	
	
//---------End Added ------------------------------------------------------

//Check Create it.
ll_ret = This.of_create()
If ll_ret <> 0 Then
	//---------Begin Commented by (Appeon)Harry  05.22.2014 Sertifi Code for IntelliContract--------
	/*
	//Check SOAP Toolkit whether installed for Web version.
	If AppeonGetClientType() = 'Web' Then
		ls_Key_OCXs[1] = "HKEY_CLASSES_ROOT\CLSID\{05AE7FB3-C4E9-4F79-A5C3-DAB525E31F2C}\InprocServer32"
		ls_Key_OCXs[2] = "HKEY_CLASSES_ROOT\CLSID\{00b7e0ab-817a-44ad-a04b-d1148d524136}\InProcServer32"				
		ls_Key_OCXs[3] = "HKEY_CLASSES_ROOT\CLSID\{0AF40C55-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"
		ls_Key_OCXs[4] = "HKEY_CLASSES_ROOT\CLSID\{91e2ead3-ab7e-4d5c-88de-f7fa382172bc}\InProcServer32"																				
		ls_Key_OCXs[5] = "HKEY_CLASSES_ROOT\CLSID\{0AF40C54-9257-11D5-87EA-00B0D0BE6479}\InprocServer32"
		For i = 1 To UpperBound(ls_Key_OCXs[])
			ls_Value = ''
			lnv_Appeon.of_registryget(ls_Key_OCXs[i],"", RegString!, ls_Value)
			If ls_value = '' Then
				lb_soap_installed = False
				Exit
			End If
		Next
	End If	
	If Not lb_soap_installed  Then
		If Messagebox('Sertifi Error' + String(ll_ret) ,'The system detected that you do not have SOAP Toolkit installed on your machine. '+ &
		+'You need to install it before you can use the Electronic Signature function. ~r~n~r~nDo you want to download it now??') = 1 Then
			ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_soap_link , ls_Null, 4)			
		End If
		Return False
	Else
		Messagebox('Sertifi Error' + String(ll_ret) ,'Failed to create the SOAP instance, please call support.')
	End If
	*/
	Messagebox('Sertifi Error' + String(ll_ret) ,'Failed to create the SOAP instance, please call support.')
	//---------End Commented ------------------------------------------------------
	Return False 
End If

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' Then
	//used
Else
	//---------Begin Modified by (Appeon)Harry 08.20.2013 for V141 ISG-CLX--------
	//Messagebox('Sertifi Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.')
	Messagebox('Sertifi Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales for more information.')
	//---------End Modfiied ------------------------------------------------------
	Return False
End If
 
If is_emailaddress = '' or isnull(is_emailaddress) Then
	Messagebox('Sertifi Error','Your email address is empty, please open System -> Personal Settings -> Email Account, then input the email account info.')
	Return False
End If
If Pos(is_emailaddress,'@') <= 0 Then
	Messagebox('Sertifi Error','Your email address is incorrect, please open System -> Personal Settings -> Email Account, then input the full email address.')
	Return False
End If

if gb_contract_module or gb_contract_version then  //(Appeon)Harry 05.11.2016 - for Application Electronic Signature - Sertifi--------
	//Check code
	If isnull(il_esign) Then
		Messagebox('Sertifi Error','It have no Esign code in the Lookup Painter for Contract Action Type, please add it.')
		Return False
	End If
	If isnull(il_signed) Then
		Messagebox('Sertifi Error','It have no Signed code in the Lookup Painter for Contract Action Status, please add it.')
		Return False
	End If
	If isnull(il_incomplete) Then
		Messagebox('Sertifi Error','It have no Incomplete code in the Lookup Painter for Contract Action Status, please add it.')
		Return False
	End If
end if

ls_apicode = This.of_get_apicode()
If isnull(ls_apicode) or ls_apicode = '' Then
	//---------Begin Modified by (Appeon)Harry 08.20.2013 for V141 ISG-CLX--------
	//Messagebox('Sertifi Error','The Sertifi API code is empty, plese open System -> Utilites -> Electronic Signature Settings, then input the Sertifi API code.')
	if gb_contract_version then
		Messagebox('Sertifi Error','The Sertifi API code is empty, plese open System -> Utilites -> Electronic Signature Settings, then input the Sertifi API code.')
	else
		if gb_contract_module then
			Messagebox('Sertifi Error','The Sertifi API code is empty, plese open System -> Utilites -> CTX Utilities -> Electronic Signature Settings, then input the Sertifi API code.')
		end if
	end if
	//---------End Modfiied ------------------------------------------------------
	Return False
End If

//Ping Server or local env.
If Not of_ping_sertifi_server( ) Then
	Messagebox('Sertifi Error','Cannot connect to Sertifi server. You may experience some network connection issue or failed to install the SOAP toolkit.')
	Return False
End If

//Ping current API code
integer li_ret
If ab_ping_apicode Then
	li_ret = This.of_ping_apicode(ls_apicode) 
	Choose Case li_ret 
		Case -1
			//---------Begin Modified by (Appeon)Harry 08.20.2013 for V141 ISG-CLX--------
			//Messagebox('Sertifi Error','The Sertifi API code is invalid, plese open System -> Utilites -> Electronic Signature Settings, then input the correct Sertifi API code.')
			if gb_contract_version then
				Messagebox('Sertifi Error','The Sertifi API code is invalid, plese open System -> Utilites -> Electronic Signature Settings, then input the correct Sertifi API code.')
			else
				if gb_contract_module then
					Messagebox('Sertifi Error','The Sertifi API code is invalid, plese open System -> Utilites -> CTX Utilities -> Electronic Signature Settings, then input the correct Sertifi API code.')
				end if
			end if
			//---------End Modfiied ------------------------------------------------------
			Return False
		Case -2
			Messagebox('Sertifi Error','Cannot connect to Sertifi server. You may experience some network connection issue.')
			Return False
	End Choose
End If

ib_isvalid_sertifi = True

Return True



end function

public function boolean of_ping_sertifi_server ();//////////////////////////////////////////////////////////////////////
// Function: of_ping_sertifi_server()
// Arguments:
//--------------------------------------------------------------------
// Return:  boolean
//--------------------------------------------------------------------
// Author:	 Ken.Guo 2011-06-24.
//--------------------------------------------------------------------
// Description: Check the Sertifi server available.
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
String ls_ret

Try
	//ping a not exists user to test api code.
	ls_ret = Lower(isoap_sertifi.GetUserInfo('testapicode','t01e2s3t4e5r6')) 

	If Pos(ls_ret, 'invalid api code') > 0 Then
		Return True
	Else
		Return False
	End If
Catch (Throwable	E2)
	Messagebox('Error',e2.text)
	Return False //Failed to connect to sertifi server
End Try

Return False
end function

public function integer of_refresh_sertifi_status_bak (long al_prac_id, long al_rec_id, long al_app_id);//////////////////////////////////////////////////////////////////////
// Function: of_refresh_sertifi_status()
// Arguments:
// 	value    long    al_prac_id
// 	value    long    al_rec_id
//	value    long    al_app_id
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Harry 2016-06-05.
//--------------------------------------------------------------------
// Description: Refresh the Sertifi Document Status, Reset sig_status and Download the signed files.
//				   Application Electronic Signature - Sertifi
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////


Long i,ll_cnt, ll_signed_count, ll_downerror_cnt, ll_need_down
integer li_msg
String ls_filter,ls_es_fileid,ls_es_apicode,ls_docid_list,ls_es_docid_list,ls_sql
n_ds lds_waiting_sign
str_sertifi_doc lstr_sertifi_doc ,str_sertifi_doc_temp
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp
Int li_sig_status
String ls_download_path
DateTime ldt_null
string ls_ext, ls_filename
Blob	lblb_ImageData
n_cst_dm_utils lnv_utils
n_cst_image_functions_cp inv_image_func

w_appeon_gifofwait lw_appeon_gifofwait

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	//On
Else
	Return -1
End If

ls_ext = '.pdf'
SetNull(ldt_null)
//Get waiting sign documents
lds_waiting_sign = Create n_ds
lds_waiting_sign.Dataobject = 'd_app_sertifi_doc_waiting_sign'
lds_waiting_sign.SetTransObject(SQLCA)
//Added By Mark Lee 08/06/12
lds_waiting_sign.of_set_idle_flag( False)

ll_signed_count = 0  //signed records
lds_waiting_sign.Retrieve()
ls_filter = '1 = 1 '
If al_prac_id > 0 Then
	ls_filter += ' and prac_id = ' + string(al_prac_id)
End If
If al_rec_id > 0 Then
	ls_filter += ' and rec_id = ' + string(al_rec_id)
End If
If al_app_id > 0 Then
	ls_filter += ' and app_id = ' + string(al_app_id)
End If

ls_filter += " and esign_type = 'sertifi'"  //(Appeon) Add by Harry 07.14.2016

lds_waiting_sign.SetFilter(ls_filter)
lds_waiting_sign.Filter()
ll_cnt = lds_waiting_sign.Rowcount( ) 
If ll_cnt = 0 Then Return 1


If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Retrieving E-sign documents status from sertifi server...")
timer(0,lw_appeon_gifofwait)
lw_appeon_gifofwait.of_setmaxposition(ll_cnt + 2)

//Get Sertifi Sign Status
For i = 1 To ll_cnt
//	lw_appeon_gifofwait.of_settext("Retrieving E-sign documents status from sertifi server "+String(i)+'/'+String(ll_cnt)+"...")
//	lw_appeon_gifofwait.of_setposition(i)
	
	lstr_sertifi_doc = str_sertifi_doc_temp
	lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
	lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
	lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
	lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
	lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
	lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')
	
	If ls_es_apicode = lstr_sertifi_doc.as_es_apicode and ls_es_fileid = lstr_sertifi_doc.as_es_fileid Then
		//Use prior lstr_sertifi_file when same fileid
	Else
		lstr_sertifi_file = lstr_sertifi_file_temp
		If This.of_get_doc_status( lstr_sertifi_doc, lstr_sertifi_file,false) < 0 Then Continue
	End If

	If This.of_get_doc_signed_status( lstr_sertifi_doc.as_es_docid , lstr_sertifi_file) Then
		lds_waiting_sign.SetItem(i, 'sig_status' ,2)
		lds_waiting_sign.SetItem(i, 'sig_in_date', DateTime(Today(),Now()))  
		ll_signed_count ++
	End If
	
	ls_es_apicode = lstr_sertifi_doc.as_es_apicode
	ls_es_fileid = lstr_sertifi_doc.as_es_fileid
Next

ll_need_down = 0
If ll_signed_count > 0 Then
	If al_rec_id = 0 Then
		li_msg = Messagebox("Prompt", "There are " +String(ll_signed_count) + " documents that have been signed and need to be downloaded.  Do you wish to do this now?  It may take several minutes. ", Exclamation!, YesNo!, 2)	//Modified by (Appeon)Freeze 2017-08-17 for Bug 5760: Refresh Document Signature Data typo
		If li_msg = 2 Then Return 0
	End If
	//DownLoad Docment from Sertifi Server, Then upload db.
	ll_downerror_cnt = 0
	For i = 1 To ll_cnt
		li_sig_status = lds_waiting_sign.GetItemNUmber(i, 'sig_status')
		If li_sig_status <> 2 Then Continue
		ll_need_down ++
		lw_appeon_gifofwait.of_settext("Download the signed document from sertifi server "+String(ll_need_down)+'/'+String(ll_signed_count)+"...")
		lw_appeon_gifofwait.of_setposition(i)
		lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
		lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
		lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
		lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
		lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
		lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')	
		ls_download_path = of_download_doc( lstr_sertifi_doc)   //Download Docment from Sertifi Server
		If Len(ls_download_path) <= 0 Then  //Download Docment fail.
			lds_waiting_sign.SetItem(i, 'sig_status' ,1)
			lds_waiting_sign.SetItem(i, 'sig_in_date', ldt_null)
			ll_downerror_cnt ++
			Continue
		End If 
		
		/*
		ls_filename =  lds_waiting_sign.GetItemString(i, 'file_name')
		If isnull(ls_filename) or  ls_filename = '' Then
			ls_ext = ".tif"
		Else
			ls_ext = Right(ls_filename,4)
		End If
		
		//Convert PDF to TIF
		If lower(ls_ext) = ".tif" Then
			If gnv_reg_ocx.of_check_ocx(4,'',True) = '' Then //check ImageViewer2.OCX 
				If Not isvalid(inv_image_func) Then inv_image_func = Create n_cst_image_functions_cp 
				ls_filename = LeftA(ls_download_path, LastPos(ls_download_path,".") - 1) + '.tif'
				li_msg = inv_image_func.of_pdf2tif( ls_download_path, ls_filename)  //Convert PDF to TIF
				IF li_msg <> 0 THEN
					ls_download_path = ls_filename
				ELSE
					ChangeDirectory(gs_current_path)
					lds_waiting_sign.SetItem(i, 'sig_status' ,1)
					lds_waiting_sign.SetItem(i, 'sig_in_date', ldt_null)
					ll_downerror_cnt ++
					Continue
				END IF
			End If
		End If
		*/
		
		//Upload the signed document
		If lnv_utils.of_ReadBlob(ls_download_path, lblb_ImageData) = -1 Then 
			lds_waiting_sign.SetItem(i, 'sig_status' ,1)
			lds_waiting_sign.SetItem(i, 'sig_in_date', ldt_null)
			ll_downerror_cnt ++
			Continue
		Else
			//update file_name 
			ls_filename = String(lstr_sertifi_doc.al_doc_id) + "_signed" + ls_ext
			UPDATE net_dev_action_images
			SET file_name = :ls_filename
			WHERE rec_id = :lstr_sertifi_doc.al_doc_id;  
			
			UPDATEBLOB net_dev_action_images
					 SET image_data = :lblb_ImageData
					WHERE rec_id = :lstr_sertifi_doc.al_doc_id ; 
			If sqlca.sqlcode = 0 Then
				COMMIT USING SQLCA ;
			Else
				lds_waiting_sign.SetItem(i, 'sig_status' ,1)
				lds_waiting_sign.SetItem(i, 'sig_in_date', ldt_null)
				ll_downerror_cnt ++
			End If
		End If
	Next
	
	//Update net_dev_action_items
	If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.of_settext('Updating documents status...')
	If lds_waiting_sign.update() = 1 Then
	Else
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		If isvalid(inv_image_func) Then Destroy inv_image_func
		Return -2
	End If
Else
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	If isvalid(inv_image_func) Then Destroy inv_image_func
	Return 0
End If

lw_appeon_gifofwait.of_setposition(ll_cnt * 2 + 1)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
If isvalid(inv_image_func) Then Destroy inv_image_func

Return 1
end function

public function integer of_refresh_sertifi_status (long al_prac_id, long al_rec_id, long al_app_id);//////////////////////////////////////////////////////////////////////
// Function: of_refresh_sertifi_status()
// Arguments:
// 	value    long    al_prac_id
// 	value    long    al_rec_id
//	value    long    al_app_id
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Harry 2016-06-05.
//--------------------------------------------------------------------
// Description: Refresh the Sertifi Document Status, Reset sig_status and Download the signed files.
//				   Application Electronic Signature - Sertifi
// Modify: Harry 2016-07-15
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////


Long i,ll_cnt, ll_signed_count, ll_downerror_cnt, ll_need_down
integer li_msg = 1
String ls_filter,ls_es_fileid,ls_es_apicode,ls_docid_list,ls_es_docid_list,ls_sql
n_ds lds_waiting_sign
str_sertifi_doc lstr_sertifi_doc ,str_sertifi_doc_temp
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp
Int li_sig_status
String ls_download_path
DateTime ldt_null
string ls_ext, ls_filename
Blob	lblb_ImageData
long ll_complete
long ll_status
n_cst_dm_utils lnv_utils
n_cst_image_functions_cp inv_image_func

w_appeon_gifofwait lw_appeon_gifofwait

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	//On
Else
	Return -1
End If

ls_ext = '.pdf'
SetNull(ldt_null)
//Get waiting sign documents
lds_waiting_sign = Create n_ds
lds_waiting_sign.Dataobject = 'd_app_sertifi_doc_waiting_sign'
lds_waiting_sign.SetTransObject(SQLCA)
//Added By Mark Lee 08/06/12

lds_waiting_sign.of_set_idle_flag( False)

ll_signed_count = 0  //signed records

lds_waiting_sign.Retrieve()

ls_filter = '1 = 1 '
If al_prac_id > 0 Then
	ls_filter += ' and prac_id = ' + string(al_prac_id)
End If
If al_rec_id > 0 Then
	ls_filter += ' and rec_id = ' + string(al_rec_id)
End If
If al_app_id > 0 Then
	ls_filter += ' and app_id = ' + string(al_app_id)
End If

ls_filter += " and esign_type = 'sertifi'"  //(Appeon) Add by Harry 07.14.2016

lds_waiting_sign.SetFilter(ls_filter)
lds_waiting_sign.Filter()
ll_cnt = lds_waiting_sign.Rowcount( ) 
If ll_cnt = 0 Then Return 1


If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Retrieving E-sign documents status from sertifi server...")
timer(0,lw_appeon_gifofwait)
lw_appeon_gifofwait.of_setmaxposition(ll_cnt + 2)

//Get Sertifi Sign Status
For i = 1 To ll_cnt
	lw_appeon_gifofwait.of_settext("Retrieving E-sign documents status from sertifi server "+String(i)+'/'+String(ll_cnt)+"...")
	lw_appeon_gifofwait.of_setposition(i)
	li_sig_status = lds_waiting_sign.GetItemNumber(i, 'sig_status')
	
	If li_sig_status = 1 Then
		lstr_sertifi_doc = str_sertifi_doc_temp
		lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
		lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
		lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
		lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
		lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
		lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')
		
		
		If ls_es_apicode = lstr_sertifi_doc.as_es_apicode and ls_es_fileid = lstr_sertifi_doc.as_es_fileid Then
			//Use prior lstr_sertifi_file when same fileid
		Else
			lstr_sertifi_file = lstr_sertifi_file_temp
			If This.of_get_doc_status( lstr_sertifi_doc, lstr_sertifi_file,false) < 0 Then Continue
		End If
		
		If This.of_get_doc_signed_status( lstr_sertifi_doc.as_es_docid , lstr_sertifi_file) Then
			lds_waiting_sign.SetItem(i, 'sig_status' ,2)
			ll_signed_count ++
		End If
	
		ls_es_apicode = lstr_sertifi_doc.as_es_apicode
		ls_es_fileid = lstr_sertifi_doc.as_es_fileid
	Else
		ll_signed_count ++
	End If
Next

ll_need_down = 0
If ll_signed_count > 0 Then
	If al_rec_id = 0 Then
		li_msg = Messagebox("Prompt", "There are " +String(ll_signed_count) + " documents that have been signed and need to be downloaded.  Do you wish to do this now?  It may take several minutes. ", Information!, YesNo!, 2)
		//If li_msg = 2 Then Return 0
	End If
	If li_msg = 1 Then  //Add by Harry 07.15.2016 for BugA071502
		//DownLoad Document from Sertifi Server, Then upload db.
		ll_downerror_cnt = 0
		For i = 1 To ll_cnt
			li_sig_status = lds_waiting_sign.GetItemNumber(i, 'sig_status')
			If li_sig_status <> 2 Then Continue
			ll_need_down ++
			lw_appeon_gifofwait.of_settext("Download the signed document from sertifi server "+String(ll_need_down)+'/'+String(ll_signed_count)+"...")
			lw_appeon_gifofwait.of_setposition(i)
			
			lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
			If of_download_from_sertifi(lstr_sertifi_doc.al_doc_id) =  1 then
				lds_waiting_sign.SetItem(i, 'sig_status' ,3)
				lds_waiting_sign.SetItem(i, 'sig_in_date', DateTime(Today(),Now()))  
				//Add by Harry 07.18.2016 for BugA071501
				ll_complete = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Complete')")) 
				ll_status  = lds_waiting_sign.GetItemNumber(i, 'action_status')
				If ll_status <> ll_complete Then
					lds_waiting_sign.SetItem(i, 'action_status' ,ll_complete)
					lds_waiting_sign.SetItem(i, 'action_date' ,DateTime(Today(),Now()))
					f_get_next_app_step(lds_waiting_sign, i)
				End If
			else
				ll_downerror_cnt ++
				Continue
			end if
			
		Next
	End If
Else
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	If isvalid(inv_image_func) Then Destroy inv_image_func
	Return 0
End If

//Update net_dev_action_items
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.of_settext('Updating documents status...')
If lds_waiting_sign.update() = 1 Then
Else
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	If isvalid(inv_image_func) Then Destroy inv_image_func
	Return -2
End If

lw_appeon_gifofwait.of_setposition(ll_cnt * 2 + 1)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
If isvalid(inv_image_func) Then Destroy inv_image_func

Return 1
end function

public function integer of_download_from_sertifi (long al_rec_id);//////////////////////////////////////////////////////////////////////
// Function: of_download_from_sertifi()
// Arguments:
// 	value    long    al_prac_id
// 	value    long    al_rec_id
//	value    long    al_app_id
//--------------------------------------------------------------------
// Return:  integer
//--------------------------------------------------------------------
// Author:	 Harry 2016-07-15.
//--------------------------------------------------------------------
// Description:  Download the signed files and upload to db
//				   Application Electronic Signature - Sertifi
//				  For BugA071502
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////

String ls_es_fileid,ls_es_apicode, ls_es_docid, ls_es_sender, ls_es_sender_email
str_sertifi_doc lstr_sertifi_doc
Int li_sig_status
String ls_download_path
string ls_ext, ls_filename
Blob	lblb_ImageData
n_cst_dm_utils lnv_utils

ls_ext = '.pdf'


SELECT es_apicode, es_fileid, es_docid, es_sender, es_sender_email
INTO :ls_es_apicode, :ls_es_fileid, :ls_es_docid, :ls_es_sender, :ls_es_sender_email
FROM net_dev_action_items
WHERE rec_id = :al_rec_id;


lstr_sertifi_doc.al_doc_id = al_rec_id
lstr_sertifi_doc.as_es_apicode =  ls_es_apicode
lstr_sertifi_doc.as_es_fileid =  ls_es_fileid
lstr_sertifi_doc.as_es_docid =  ls_es_docid
lstr_sertifi_doc.as_es_sender =  ls_es_sender
lstr_sertifi_doc.as_es_email =  ls_es_sender_email
ls_download_path = of_download_doc( lstr_sertifi_doc)   //Download Document from Sertifi Server
If Len(ls_download_path) <= 0 Then  //Download Document fail.
	Return 0
End If 

//Upload the signed document
If lnv_utils.of_ReadBlob(ls_download_path, lblb_ImageData) = -1 Then 
	Return 0
Else
	//update file_name 
	ls_filename = String(lstr_sertifi_doc.al_doc_id) + "_signed" + ls_ext
	UPDATE net_dev_action_images
	SET file_name = :ls_filename
	WHERE rec_id = :lstr_sertifi_doc.al_doc_id;  
	
	UPDATEBLOB net_dev_action_images
			 SET image_data = :lblb_ImageData
			WHERE rec_id = :lstr_sertifi_doc.al_doc_id ; 
	If sqlca.sqlcode = 0 Then
		COMMIT USING SQLCA ;
	Else
		Return -1
	End If
End If


Return 1
end function

on n_cst_sertifi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_sertifi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If isvalid(isoap_conn) Then Destroy isoap_conn
end event

