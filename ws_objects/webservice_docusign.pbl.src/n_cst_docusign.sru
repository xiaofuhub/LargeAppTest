$PBExportHeader$n_cst_docusign.sru
forward
global type n_cst_docusign from nonvisualobject
end type
end forward

global type n_cst_docusign from nonvisualobject
end type
global n_cst_docusign n_cst_docusign

type variables
SoapConnection isoap_conn
contractlogixdocusignsoap isoap_docusign
String is_apicode,is_emailaddress,is_username,is_password,is_userid,is_acctid
Long il_esign, il_complete,il_incomplete,il_signed,il_doccheckin,il_doc_signed,il_doc_declined, il_action_declined //added by gavins 20160525

Boolean ib_isvalid_sertifi = False

String ls_soap_link = 'http://web.intellisoftgroup.com/templates/soapsdk.exe'

//String is_soap_url = 'http://clxintranet.contractlogix.com/contractlogixdocusign/ContractlogixDocusign.asmx?wsdl'						//Added By Mark Lee 09/18/2015
String is_soap_url = 'http://qa.contractlogix.com/contractlogixdocusign/ContractlogixDocusign.asmx?wsdl'			
//String  is_soap_url = 'http://192.0.1.228/contractlogixdocusigndemo/ContractlogixDocusign.asmx?wsdl'

Boolean ib_ping_server = true //Added By Jay Chen 07-24-2014
string is_es_license_user_id = 'global_license_user' //Added By Jay Chen 09-04-2014
boolean ib_change_license_user = true //Added By Jay Chen 09-04-2014  avoid repeat ping docusign server in same apicode when refresh docusign unsigned document
end variables

forward prototypes
public function string of_get_apicode ()
public function integer of_create ()
public function boolean of_check_sertifi ()
public function long of_hex2dec (string as_hex)
public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc)
public function string of_download_doc (str_sertifi_doc astr_sertifi_doc)
public function integer of_show_sertifi_status (str_sertifi_doc astr_sertifi_doc, boolean ab_refresh)
public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc)
public function integer of_refresh_sertifi_status (long al_ctx_id, long al_doc_id)
public function boolean of_get_doc_signed_status (string as_sertifi_docid, str_sertifi_file astr_sertifi_file)
public function integer of_refresh_sertifi_status ()
public function integer of_ping_apicode ()
public function boolean of_check_sertifi (boolean ab_ping_apicode)
public function boolean of_ping_sertifi_server ()
public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror)
public function integer of_ping_apicode (string as_username, string as_password, string as_apicode)
public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email)
public function integer of_show_sertifi_status (long al_docid, string as_es_docid, string as_type, boolean ab_refresh, string as_es_fileid)
public function boolean of_check_sertifi (boolean ab_ping_apicode, string as_apicode, string as_username, string as_password, boolean ab_personal_data)
public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror, string as_license_user_id)
public function string of_download_doc (str_sertifi_doc astr_sertifi_doc, string as_license_user_id)
public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc, string as_license_user_id)
public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email, string as_license_user_id)
public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc, string as_license_user_id)
public function integer of_trigger_workflow (str_action_item astr_action[])
public function integer of_refresh_sertifi_status (long al_prac_id, long al_rec_id, long al_app_id)
public function integer of_download_from_sertifi (long al_rec_id)
end prototypes

public function string of_get_apicode ();if is_es_license_user_id = 'global_license_user' then
	is_apicode = gnv_data.of_getitem( 'icred_settings', 'docusign_apicode', False)
	is_username = gnv_data.of_getitem( 'icred_settings', 'docusign_username', False)
	is_password = gnv_data.of_getitem( 'icred_settings', 'docusign_password', False)
	is_userid = gnv_data.of_getitem( 'icred_settings', 'docusign_userid', False)
	is_acctid = gnv_data.of_getitem( 'icred_settings', 'docusign_accountid', False)
else   //Modified By Jay Chen 09-04-2014
	select esign_apicode,esign_username,esign_password,esign_userid,esign_accountid
	into :is_apicode, :is_username, :is_password, :is_userid, :is_acctid
	from personal_license_setting 
	where user_id = :is_es_license_user_id and esign_type='docusign';
end if

//is_userName = "ken.guo@appeon.com"
//is_password = "appeon0101"
//is_apicode = "APPE-c19b1299-2bac-45fc-9b1b-3440e91b7285"
//is_userid = "3e9bcfac-9e05-4514-9aac-450a9ba31c22"
//is_acctid = "0990bb99-cfb3-43ff-91af-64060b95b0d7"

Return is_apicode
end function

public function integer of_create ();long ll_ret = -1
string ls_ret

Try
	isoap_conn = Create SoapConnection
	ll_ret = isoap_conn.CreateInstance(isoap_docusign, "contractlogixdocusignsoap",is_soap_url)

//	messagebox('info', "CreateInstance "+string(ll_ret))
	If ll_ret <> 0 Then
		If isvalid(isoap_docusign) Then Destroy isoap_docusign
	End If
	
	
Catch (throwable e1)
	If isvalid(isoap_docusign) Then Destroy isoap_docusign
	Return -1
End Try

Return ll_ret
end function

public function boolean of_check_sertifi ();Return of_check_sertifi(True)



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

public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc);return of_get_doc_maintance_link(astr_sertifi_doc,'global_license_user') //Added By Jay Chen 09-04-2014

//String ls_link = 'error'
//SetPointer(HourGlass!)
//
//If Not ib_isvalid_sertifi Then 
//	If Not This.of_check_sertifi( ) Then Return ''
//End If
//
//Try
////	ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
//	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
//		ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid)
//	else
//		ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
//	end if
//Catch (Throwable	E2)	
//	ib_isvalid_sertifi = False
//	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//End Try
//
//If Left(Lower(ls_link),5) = 'error' Then
//	ib_isvalid_sertifi = False
//	Messagebox('Error',ls_link+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//	Return ''
//End If
//
//
//Return ls_link
end function

public function string of_download_doc (str_sertifi_doc astr_sertifi_doc);return of_download_doc(astr_sertifi_doc,'global_license_user') //Added By Jay Chen 09-04-2014

////////////////////////////////////////////////////////////////////////
//// Function: of_download_doc()
//// Arguments:
//// 	value    str_sertifi_doc    astr_sertifi_doc
////--------------------------------------------------------------------
//// Return:  string
////--------------------------------------------------------------------
//// Author:	 Jay.Chen 2013-09-30.
////--------------------------------------------------------------------
//// Description: Download the file from echosign.
////--------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
//Long ll_max,i,ll_readlength,ll_writelength
//String ls_SertifiDirectory,ls_FileName
//Blob lb_doc
//w_appeon_gifofwait lw_appeon_gifofwait
//tns__docusigneddocument ltns__SignedDocument
//
//If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Downloading document from Docusign server...")		
//
//
////Get the file name
//ll_max = 100
//ls_SertifiDirectory = gs_dir_path + gs_DefDirName + "\Sertifi"
//gnv_appeondll.of_parsepath(ls_SertifiDirectory)
//IF NOT DirectoryExists(ls_SertifiDirectory) THEN RETURN ""
//For i = 1 To ll_max
//	If i = 1 Then
//		ls_FileName = ls_SertifiDirectory + "\Document" + String(astr_sertifi_doc.al_doc_id) + "_signed.pdf"
//	Else
//		ls_FileName = ls_SertifiDirectory + "\Document" + String(astr_sertifi_doc.al_doc_id) + "_signed_" +String(i)+".pdf"
//	End If
//	If FileExists(ls_filename) Then
//		If Not FileDelete(ls_filename) Then
//			If i = ll_max Then
//				If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//				Return ''
//			End If
//			Continue
//		Else
//			Exit
//		End If
//	Else
//		Exit
//	End If
//Next
//
////Download the file from docusign
//SetPointer(HourGlass!)
//If Not ib_isvalid_sertifi Then 
//	If Not This.of_check_sertifi( ) Then 
//		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//		Return ''
//	End If
//End If
//
//Try
////	ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password, astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_docid,true)
//	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
//		ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode ,astr_sertifi_doc.as_es_fileid,true,long(astr_sertifi_doc.as_es_docid))
//	else
//		ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode ,astr_sertifi_doc.as_es_docid,true,0)
//	end if
//Catch (Throwable	E2)	
//	Messagebox('Error', E2.text+" ~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
//End Try	
//
//If Left(Lower(ltns__SignedDocument.errorText),5) = 'error' Then
//	ib_isvalid_sertifi = False
//	Return ''
//End If
//
////Write blob into file
//lb_doc = ltns__SignedDocument.document
//ll_readlength = Len(lb_doc)
//
//If ll_readlength = 0 Then 
//	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//	Return ""
//End If
//
//ll_writelength = AppeonWriteFile(ls_FileName, lb_doc, ll_readlength)
//
//If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
//
//if ll_writelength < 0 then return ""
//
//If FileExists(ls_FileName) Then
//	Return ls_FileName
//Else
//	Return ''
//End If
//
//
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


return 1
end function

public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc);return of_removesignaturerequest(astr_sertifi_doc,'global_license_user') //Added By Jay Chen 09-04-2014

//string ls_errcode,ls_errdesc
//boolean lb_success = false
//String ls_ret = 'error'
//
//SetPointer(HourGlass!)
//
//If Not ib_isvalid_sertifi Then 
//	If Not This.of_check_sertifi( ) Then Return -1
//End If
//
//Try
////	ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_docid,gnv_docusign.is_acctid)
//	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
//	 	if astr_sertifi_doc.as_es_fileid <> '' then
//			ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_fileid,gnv_docusign.is_acctid)
//		else
//			Return -1
//		end if
//	else
//		if astr_sertifi_doc.as_es_docid <> '' then
//			ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_docid,gnv_docusign.is_acctid)
//		else
//			Return -1
//		end if
//	end if
//Catch (Throwable	E2)	
//	ib_isvalid_sertifi = False
//	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
//	return -1
//End Try
//
//If Left(Lower(ls_ret),5) = 'error' Then
//	ib_isvalid_sertifi = False
//	Messagebox('Error ','Failed to remove the signature request. ' + ls_ret+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//	Return -1
//End If
//
//
//Return 1
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
Long i,ll_cnt,j
String ls_filter,ls_es_fileid,ls_es_apicode,ls_docid_list,ls_es_docid_list,ls_sql
n_ds lds_waiting_sign
str_sertifi_doc lstr_sertifi_doc ,str_sertifi_doc_temp
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp
w_appeon_gifofwait lw_appeon_gifofwait
string ls_license_user_id,ls_license_user_id_old //Added By Jay Chen 09-04-2014
Boolean lb_need_refresh //Added By Ken.Guo 2016-02-23
Boolean	lb_TriggerWF //added by gavins 20160525

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
ls_filter += " and esign_type = 'docusign'" //Modified By Jay Chen 04-09-2014
lds_waiting_sign.SetFilter(ls_filter)
lds_waiting_sign.Filter()
ll_cnt = lds_waiting_sign.Rowcount( ) 
If ll_cnt = 0 Then Return 1

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Retrieving E-sign documents status from docusign server...")
timer(0,lw_appeon_gifofwait)
lw_appeon_gifofwait.of_setmaxposition(ll_cnt+2)

//Get Sertifi Sign Status
For i = 1 To ll_cnt
	lw_appeon_gifofwait.of_settext("Retrieving E-sign documents status from docusign server "+String(i)+'/'+String(ll_cnt)+"...")
	lw_appeon_gifofwait.of_setposition(i)
	
	lstr_sertifi_doc = str_sertifi_doc_temp
	lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'doc_id')
	lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
	lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
	lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
	lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
	lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')

	lstr_sertifi_file = lstr_sertifi_file_temp
	//Added By Jay Chen 09-04-2014
	ls_license_user_id = lds_waiting_sign.GetItemString(i, 'es_license_user_id')
	if ls_license_user_id_old = ls_license_user_id then 
		ib_change_license_user = false
	else
		ib_change_license_user = true
		ib_isvalid_sertifi = False
	end if
	If This.of_get_doc_status( lstr_sertifi_doc, lstr_sertifi_file,false,ls_license_user_id) < 0 Then Continue

	//Added By Ken.Guo 2016-02-23  set document status to declined when decline signature
	For j = 1 to UpperBound(lstr_sertifi_file.astr_sertifi_document[]) 
		If lower(lstr_sertifi_file.astr_sertifi_document[j].Status) = "declined"  then
			If gnv_docusign.il_doc_declined > 0 Then
				Update Ctx_am_document Set status = :gnv_docusign.il_doc_declined  Where doc_id = :lstr_sertifi_doc.al_doc_id;
			End If
			//added by gavins 20160525 action item status //or Action_type = :gnv_docusign.il_doccheckin
			If gnv_docusign.il_action_declined > 0 Then
				Update ctx_am_action_item Set Action_status = :gnv_docusign.il_action_declined
					Where doc_id = :lstr_sertifi_doc.al_doc_id and (Action_type = :gnv_docusign.il_esign  )  
							and Action_status = :gnv_docusign.il_incomplete and (es_docid = :lstr_sertifi_doc.as_es_docid or es_docid is null) ;
				lb_TriggerWF = True			
			end If
			lb_need_refresh = True
			Exit
		end if	
	Next

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
	ls_license_user_id_old = ls_license_user_id //Added By Jay Chen 09-04-2014
Next

//Added By Ken.Guo 2016-02-23
If lb_need_refresh Then
	if IsValid(gw_contract) then	
		If gw_contract.tab_contract_details.ib_select9 Then
			gw_contract.tab_contract_details.tabpage_images.tab_1.tabpage_data.event ue_retrieve()
		End If
	end if
End If

ib_change_license_user = true //Added By Jay Chen 09-04-2014

//Update CL Status
If lds_waiting_sign.Modifiedcount( ) > 0 Then
	If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.of_settext('Updating documents status...')
	//Update checkout status
	If lds_waiting_sign.update() = 1 Then
		ls_docid_list = Mid(ls_docid_list,2,Len(ls_docid_list))
		ls_es_docid_list = Mid(ls_es_docid_list,2,Len(ls_es_docid_list))	
		//Update Action item Status  // 
		ls_sql = "Update ctx_am_action_item Set Action_status = " + String(gnv_docusign.il_signed) + &
					" Where doc_id in (" + ls_docid_list + ") and (Action_type = " + String(gnv_docusign.il_doccheckin) + " or  Action_type = " + String(gnv_docusign.il_esign)  + ") "  +&
					" and Action_status = " + String(gnv_docusign.il_incomplete) + " and (es_docid in ( "+ls_es_docid_list+") or es_docid is null) "		
		EXECUTE IMMEDIATE :ls_sql USING SQLCA;		
		If sqlca.sqlcode <> 0 Then
			gnv_debug.of_output( True, 'Failed to run SQL:' + ls_sql)
			gnv_debug.of_output( True, 'SQLCA Error:' + sqlca.sqlerrtext )
			if gb_message = true then 
				gnv_debug.of_message("Docusign Error: The document(s) check out status have been updated, but failed to update the action item status.")
			else
				Messagebox('Error','The document(s) check out status have been updated, but failed to update the action item status.')
			end if 
			If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
			Return -1
		End If
		lb_TriggerWF = TRUE
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

public function boolean of_get_doc_signed_status (string as_sertifi_docid, str_sertifi_file astr_sertifi_file);Long i

For i = 1 To UpperBound(astr_sertifi_file.astr_sertifi_document[])
	If as_sertifi_docid = astr_sertifi_file.astr_sertifi_document[i].DocumentID Then
		If lower(astr_sertifi_file.astr_sertifi_document[i].status) = 'completed' Then //Added By Jay Chen 04-09-2014
			Return True
		End If
	End If
Next

Return False
end function

public function integer of_refresh_sertifi_status ();Integer li_ret

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) = '1' Then
	//used
Else
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error: You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.")
	else
		Messagebox('Docusign Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.')
	end if 
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

public function integer of_ping_apicode ();of_get_apicode()
Return of_ping_apicode(is_userName,is_password,is_apicode)

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
	
	if gb_contract_module or gb_contract_version then  //(Appeon)Harry 07.14.2016 - for Application Electronic Signature - Docusign--------
	//Get Esign,Incomplete,Complte code
		Select Top 1 lookup_code Into :il_esign    From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-Request';
		Select Top 1 lookup_code Into :il_doccheckin From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-CheckIn';
		Select Top 1 lookup_code Into :il_complete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete';
		Select Top 1 lookup_code Into :il_incomplete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete';
		Select Top 1 lookup_code Into :il_signed From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Signed';
		select Top 1 lookup_code Into :il_action_declined From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Declined'; //added by gavin  20160525
		
		Select Top 1 lookup_code Into :il_doc_signed From code_lookup Where lookup_name = 'Contract Document Status' And code = 'Signed';
		
		//Added By Ken.Guo 2016-02-23
		Select Top 1 lookup_code Into :il_doc_declined From code_lookup Where lookup_name = 'Contract Document Status' And code = 'Declined';
	end if
gnv_appeondb.of_commitqueue( )


//Check Create it.
ll_ret = This.of_create()
If ll_ret <> 0 Then
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
		If Messagebox('Docusign Error' + String(ll_ret) ,'The system detected that you do not have SOAP Toolkit installed on your machine. '+ &
		+'You need to install it before you can use the Electronic Signature function. ~r~n~r~nDo you want to download it now??') = 1 Then
			//------------Begin Added by alfee 11.08.2016 ---------------------------------
			ls_url = Trim(gnv_data.of_getitem( "icred_settings", "downloadurl", false)) 
			If Len(ls_url) > 0 Then 
				If Right(ls_url, 1) <> "/" And Right(ls_url, 1) <> "\" Then ls_url = ls_url + "/"
				ls_soap_link  = ls_url + "soapsdk.exe"
			End If
			//------------End Added -------------------------------------------------------------				
			ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_soap_link , ls_Null, 4)			
		End If
		Return False
	Else
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error"+ String(ll_ret) +" : Failed to create the SOAP instance, please contact your system administrator or IntelliSoft Group support for additional help.")
		else
			Messagebox('Docusign Error' + String(ll_ret) ,'Failed to create the SOAP instance, please contact your system administrator or IntelliSoft Group support for additional help.')
		end if 
	End If
	Return False 
End If

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' Then
	//used
Else
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error: You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.")
	else
		Messagebox('Docusign Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.')
	end if 
	Return False
End If
 
If is_emailaddress = '' or isnull(is_emailaddress) Then
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error: Your email address is empty, please open System -> Personal Settings -> Email Account, then input the email account info.")
	else
		Messagebox('Docusign Error','Your email address is empty, please open System -> Personal Settings -> Email Account, then input the email account info.')
	end if 
	Return False
End If
If Pos(is_emailaddress,'@') <= 0 Then
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error: Your email address is incorrect, please open System -> Personal Settings -> Email Account, then input the full email address.")
	else
		Messagebox('Docusign Error','Your email address is incorrect, please open System -> Personal Settings -> Email Account, then input the full email address.')
	end if 
	Return False
End If

if gb_contract_module or gb_contract_version then  //(Appeon)Harry 07.14.2016 - for Application Electronic Signature - Docusign--------
	//Check code
	If isnull(il_esign) Then
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error: It have no Esign code in the Lookup Painter for Contract Action Type, please add it.")
		else
			Messagebox('Docusign Error','It have no Esign code in the Lookup Painter for Contract Action Type, please add it.')
		end if 
		Return False
	End If
	If isnull(il_signed) Then
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error: It have no Signed code in the Lookup Painter for Contract Action Status, please add it.")
		else
			Messagebox('Docusign Error','It have no Signed code in the Lookup Painter for Contract Action Status, please add it.')
		end if 
		Return False
	End If
	If isnull(il_incomplete) Then
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error: It have no Incomplete code in the Lookup Painter for Contract Action Status, please add it.")
		else
			Messagebox('Docusign Error','It have no Incomplete code in the Lookup Painter for Contract Action Status, please add it.')
		end if 
		Return False
	End If
	
	//Added By Ken.Guo 2016-02-23
	If isnull(il_doc_signed) Then
		Messagebox('Docusign Error','It have no Signed code in the Lookup Painter for Contract Document Status, please add it.')
		Return False
	End If
	If isnull(il_doc_declined) Then
		Messagebox('Docusign Error','It have no Declined code in the Lookup Painter for Contract Document Status, please add it.')
		Return False
	End If
end if

ls_apicode = This.of_get_apicode()
If isnull(ls_apicode) or ls_apicode = '' Then
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error: The Docusign API code is empty, plese open System -> Utilites -> Electronic Signature Settings, then input the Docusign API code.")
	else
		Messagebox('Docusign Error','The Docusign API code is empty, plese open System -> Utilites -> Electronic Signature Settings, then input the Docusign API code.')
	end if 
	Return False
End If

//Ping Server or local env.
if ib_ping_server then //Added By Jay Chen 07-24-2014
	If Not of_ping_sertifi_server( ) Then
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error: Cannot connect to Docusign server. You may experience some network connection issue or failed to install the SOAP toolkit.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
		else
			Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue or failed to install the SOAP toolkit.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.')
		end if 
		Return False
	End If
end if

//Ping current API code
integer li_ret
If ab_ping_apicode Then
	if ib_ping_server then //Added By Jay Chen 07-24-2014
		li_ret = This.of_ping_apicode(is_username,is_password,is_apicode) 
		Choose Case li_ret 
			Case -1
				if gb_message = true then 
					gnv_debug.of_message("Docusign Error: The Docusign API code is invalid, plese open System -> Utilites -> Electronic Signature Settings, then input the correct Docusign API code.")
				else
					Messagebox('Docusign Error','The Docusign API code is invalid, plese open System -> Utilites -> Electronic Signature Settings, then input the correct Docusign API code.')
				end if 
				Return False
			Case -2
				if gb_message = true then 
					gnv_debug.of_message("Docusign Error: Cannot connect to Docusign server. You may experience some network connection issue.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
				else
					Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.')
				end if 
				Return False
		End Choose
	end if
End If

ib_isvalid_sertifi = True

Return True



end function

public function boolean of_ping_sertifi_server ();
boolean lb_ret

Try
	lb_ret = isoap_docusign.ping(is_username,is_password,is_apicode)

	If lb_ret Then
		Return True
	Else
		Return False
	End If
Catch (Throwable	E2)
	Messagebox('Error',e2.text+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	Return False //Failed to connect to echosign server
End Try

Return False
end function

public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror);return of_get_doc_status(astr_sertifi_doc,astr_sertifi_file,ab_showerror,'global_license_user') //Added By Jay Chen 09-04-2014

//String ls_filestatus = 'error'
//String ls_error,ls_errormessage
//integer li_ret,i = 1,j,k
//string ls_null,ls_docname
//
//setnull(ls_null)
//tns__docusigndocumentinformation ltns__documentinfo
//
//SetPointer(HourGlass!)
//
//If Not ib_isvalid_sertifi Then 
//	If Not This.of_check_sertifi( ) Then Return -1
//End If
//
//Try
////     ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
//	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
//		ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid, long(astr_sertifi_doc.as_es_docid))
//	else
//		ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid,0)
//	end if
//	 ls_errormessage = ltns__documentinfo.errormessage
//Catch (Throwable	E2)	
//	ib_isvalid_sertifi = False
//	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//End Try
//
//If Left(Lower(ls_errormessage),5) = 'error' Then
//	If ab_showerror Then Messagebox('Error',ls_errormessage+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//	gnv_debug.of_output(True, 'Failed to get file docusign status.' + ls_errormessage)
//	gnv_debug.of_output(True, 'Document ID:' + String(astr_sertifi_doc.al_doc_id ))
//	gnv_debug.of_output(True, 'ES File ID:' + astr_sertifi_doc.as_es_fileid  )
//	ib_isvalid_sertifi = False
//	Return -1
//End If
//
//
////Get docusign Document Info
//select doc_name into :ls_docname from ctx_am_document where es_docid = :astr_sertifi_doc.as_es_docid and es_fileid = :astr_sertifi_doc.as_es_fileid; //Modified By Jay Chen 04-30-2014
//astr_sertifi_file.astr_sertifi_document[i].DocumentID  = astr_sertifi_doc.as_es_docid
//astr_sertifi_file.name = ltns__documentinfo.documentname 
//astr_sertifi_file.astr_sertifi_document[i].Name  = ls_docname
//astr_sertifi_file.astr_sertifi_document[i].Status  = ltns__documentinfo.status
//
////Get docusign Signature Info
//For j = 1 To UpperBound(ltns__documentinfo.signature[])
//    	if pos(upper(ltns__documentinfo.signature[j].doctype),'SIGNER') = 0 then continue 
//	k++
//	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].Email  = ltns__documentinfo.signature[j].signeremail
//	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].NameSigned  = ltns__documentinfo.signature[j].namesigned
//	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].IpAddress  =  ltns__documentinfo.signature[j].signerip
//	if isnull(ltns__documentinfo.signature[j].routingorder) then ltns__documentinfo.signature[j].routingorder = 1
//	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].signmethod = string(ltns__documentinfo.signature[j].routingorder)
////	messagebox('aaa',ltns__documentinfo.signature[j].signeddate)
////	if ltns__documentinfo.signature[j].signeddate = '01/01/0001 00:00:00' or date(ltns__documentinfo.signature[j].signeddate) = 1900-01-01 then	
//    if isnull(ltns__documentinfo.signature[j].signstatus)  or lower(ltns__documentinfo.signature[j].signstatus) <> 'completed' then
//		astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].DateSigned  =  ls_null
//	else
//	    astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].DateSigned  = ltns__documentinfo.signature[j].signeddate
//	end if
//Next
//		
//Return li_ret
//
end function

public function integer of_ping_apicode (string as_username, string as_password, string as_apicode);String ls_ret
boolean lb_ret

Try
	//test api code.
	if as_apicode = '' or isnull(as_apicode) then
		if gb_message = true then 
			gnv_debug.of_message("Docusign Error(of_ping_apicode): DocuSign API code is empty,please set it first")
		else
			Messagebox('Information','DocuSign API code is empty,please set it first')
		end if 
	    Return -1
	end if
	
	lb_ret = isoap_docusign.ping(as_username,as_password,as_apicode)
	if lb_ret then
		Return 1
	else
		Return -2
	end if

	
Catch (Throwable	E2)
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error(of_ping_apicode): "+e2.text+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	else
		Messagebox('Error',e2.text+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	end if 
	Return -2 //Failed to connect to sertifi server
End Try

Return -2
end function

public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email);return of_invite_again(astr_sertifi_doc,as_email,'global_license_user') //Added By Jay Chen 09-04-2014

////////////////////////////////////////////////////////////////////////
//// Function: of_invite_again()
//// Arguments:
//// 	value    str_sertifi_doc    astr_sertifi_doc
//// 	value    string             as_email
////--------------------------------------------------------------------
//// Return:  integer
////--------------------------------------------------------------------
//// Author:	 Jay.Chen 04-30-2014.
////--------------------------------------------------------------------
//// Description: Sends out an email to the signer
////--------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////
//String ls_link = 'error'
//SetPointer(HourGlass!)
//
//If Not ib_isvalid_sertifi Then 
//	If Not This.of_check_sertifi( ) Then Return -1
//End If
//
//Try	
//	if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
//		ls_link = isoap_docusign.correctandresendenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_fileid,as_email)
//	else
//		ls_link = isoap_docusign.correctandresendenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_docid,as_email)
//	end if
//Catch (Throwable	E2)	
//	ib_isvalid_sertifi = False
//	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
//End Try
//
//If Left(Lower(ls_link),5) = 'error' Then
//	ib_isvalid_sertifi = False
//	Messagebox('Error',ls_link+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
//	Return -1
//End If
//
//Return 1
//
//
end function

public function integer of_show_sertifi_status (long al_docid, string as_es_docid, string as_type, boolean ab_refresh, string as_es_fileid);str_sertifi_doc lstr_sertifi_doc 
String ls_es_docid

If isnull(as_es_docid) or as_es_docid = '' Then 
	Messagebox('tip','No signature document data.')
	Return -1
End If

gnv_appeondb.of_startqueue( )
	Select Top 1 doc_name = (select doc_name from ctx_am_document where doc_id = :al_docid) ,  ctx_am_doc_audit.es_apicode,ctx_am_doc_audit.es_fileid,ctx_am_doc_audit.es_docid,ctx_am_doc_audit.es_sender,ctx_am_doc_audit.es_sender_email 
	Into :lstr_sertifi_doc.as_filename, :lstr_sertifi_doc.as_es_apicode, :lstr_sertifi_doc.as_es_fileid, :lstr_sertifi_doc.as_es_docid, :lstr_sertifi_doc.as_es_sender, :lstr_sertifi_doc.as_es_email 
	From ctx_am_action_item, Ctx_am_doc_audit 
	Where ctx_am_action_item.doc_id =:al_docid And ctx_am_action_item.doc_id = Ctx_am_doc_audit.doc_id And Ctx_am_doc_audit.es_docid = :as_es_docid And Ctx_am_doc_audit.es_fileid = :as_es_fileid ; //Modified By Jay Chen 04-30-2014
	
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

return 1
end function

public function boolean of_check_sertifi (boolean ab_ping_apicode, string as_apicode, string as_username, string as_password, boolean ab_personal_data);//====================================================================
// Function: of_check_sertifi
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	value    boolean    ab_ping_apicode
// 	value    string     as_apicode
// 	value    string     as_username
// 	value    string     as_password
// 	value    boolean    ab_personal_data
//--------------------------------------------------------------------
// Returns:  boolean
//--------------------------------------------------------------------
// Author:	Jay Chen		Date: 09-04-2014
//--------------------------------------------------------------------
//	Copyright (c) 2008-2013 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

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
	
	if gb_contract_module or gb_contract_version then  //(Appeon)Harry 07.20.2016 - for Application Electronic Signature - Docusign--------
		//Get Esign,Incomplete,Complte code
		Select Top 1 lookup_code Into :il_esign    From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-Request';
		Select Top 1 lookup_code Into :il_doccheckin From code_lookup Where lookup_name = 'Contract Action Type' And code = 'Doc-Esign-CheckIn';
		Select Top 1 lookup_code Into :il_complete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Complete';
		Select Top 1 lookup_code Into :il_incomplete From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Incomplete';
		select Top 1 lookup_code Into :il_action_declined From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Declined'; //added by gavin  20160525
		
		Select Top 1 lookup_code Into :il_signed From code_lookup Where lookup_name = 'Contract Action Status' And code = 'Signed';
		Select Top 1 lookup_code Into :il_doc_signed From code_lookup Where lookup_name = 'Contract Document Status' And code = 'Signed';
		
		//Added By Ken.Guo 2016-02-23
		Select Top 1 lookup_code Into :il_doc_declined From code_lookup Where lookup_name = 'Contract Document Status' And code = 'Declined';
	end if
gnv_appeondb.of_commitqueue( )


//Check Create it.
ll_ret = This.of_create()
If ll_ret <> 0 Then
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
		If Messagebox('Docusign Error' + String(ll_ret) ,'The system detected that you do not have SOAP Toolkit installed on your machine. '+ &
		+'You need to install it before you can use the Electronic Signature function. ~r~n~r~nDo you want to download it now??') = 1 Then
			//------------Begin Added by alfee 11.08.2016 ---------------------------------
			ls_url = Trim(gnv_data.of_getitem( "icred_settings", "downloadurl", false)) 
			If Len(ls_url) > 0 Then 
				If Right(ls_url, 1) <> "/" And Right(ls_url, 1) <> "\" Then ls_url = ls_url + "/"
				ls_soap_link  = ls_url + "soapsdk.exe"
			End If
			//------------End Added -------------------------------------------------------------				
			ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_soap_link , ls_Null, 4)			
		End If
		Return False
	Else
		Messagebox('Docusign Error' + String(ll_ret) ,'Failed to create the SOAP instance, please contact your system administrator or IntelliSoft Group support for additional help.')
	End If
	Return False 
End If

//Check Sertifi Module whether set to On.
If gnv_data.of_getitem( 'icred_settings', 'esign', False) ='1' Then
	//used
Else
	Messagebox('Docusign Error','You did not purchase the Electronic Signature Module. To access this option please contact your sales representative at (866)371-4445 for more information.')
	Return False
End If
 
If is_emailaddress = '' or isnull(is_emailaddress) Then
	Messagebox('Docusign Error','Your email address is empty, please open System -> Personal Settings -> Email Account, then input the email account info.')
	Return False
End If
If Pos(is_emailaddress,'@') <= 0 Then
	Messagebox('Docusign Error','Your email address is incorrect, please open System -> Personal Settings -> Email Account, then input the full email address.')
	Return False
End If

if gb_contract_module or gb_contract_version then  //(Appeon)Harry 07.20.2016 - for Application Electronic Signature - Docusign--------
	//Check code
	If isnull(il_esign) Then
		Messagebox('Docusign Error','It have no Esign code in the Lookup Painter for Contract Action Type, please add it.')
		Return False
	End If
	If isnull(il_signed) Then
		Messagebox('Docusign Error','It have no Signed code in the Lookup Painter for Contract Action Status, please add it.')
		Return False
	End If
	If isnull(il_incomplete) Then
		Messagebox('Docusign Error','It have no Incomplete code in the Lookup Painter for Contract Action Status, please add it.')
		Return False
	End If
	
	//Added By Ken.Guo 2016-02-23
	If isnull(il_doc_signed) Then
		Messagebox('Docusign Error','It have no Signed code in the Lookup Painter for Contract Document Status, please add it.')
		Return False
	End If
	If isnull(il_doc_declined) Then
		Messagebox('Docusign Error','It have no Declined code in the Lookup Painter for Contract Document Status, please add it.')
		Return False
	End If
end if

if ab_personal_data then
	select esign_apicode,esign_username,esign_password,esign_userid,esign_accountid
	into :is_apicode, :is_username, :is_password, :is_userid, :is_acctid
	from personal_license_setting 
	where user_id = :gs_user_id and esign_type='docusign';

	If isnull(is_apicode) or is_apicode = '' Then
		Messagebox('Docusign Error','The system has detected that there is no personal E-Signature license API code configured for the current user. Please go to User Painter -> E-Signature License to configure valid license API code information.')
		Return False
	End If
	
	If isnull(is_username) or is_username = '' Then
		Messagebox('Docusign Error','The system has detected that there is no personal E-Signature license user name configured for the current user. Please go to User Painter -> E-Signature License to configure valid license user name information.')
		Return False
	End If
	
	If isnull(is_password) or is_password = '' Then
		Messagebox('Docusign Error','The system has detected that there is no personal E-Signature license password configured for the current user. Please go to User Painter -> E-Signature License to configure valid license password information.')
		Return False
	End If
	
	If isnull(is_userid) or is_userid = '' Then
		Messagebox('Docusign Error','The system has detected that there is no personal E-Signature license user ID configured for the current user. Please go to User Painter -> E-Signature License to configure valid license user ID information.')
		Return False
	End If
	
	If isnull(is_acctid) or is_acctid = '' Then
		Messagebox('Docusign Error','The system has detected that there is no personal E-Signature license account ID configured for the current user. Please go to User Painter -> E-Signature License to configure valid license account ID information.')
		Return False
	End If
	
	//Ping Server or local env.
	if ib_ping_server then
		If Not of_ping_sertifi_server( ) Then
			Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue or failed to install the SOAP toolkit.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.')
			Return False
		End If
	end if
	
else
	is_apicode = as_apicode
	is_username = as_username
	is_password = as_password
end if

//Ping current API code
integer li_ret
If ab_ping_apicode Then
	if ib_ping_server then //Added By Jay Chen 07-24-2014
		li_ret = This.of_ping_apicode(is_username,is_password,is_apicode) 
		Choose Case li_ret 
			Case -1
				if ab_personal_data then
					Messagebox('Docusign Error','The Docusign API code is invalid, please go to User Painter -> E-Signature License to configure valid license information..')
				else
					Messagebox('Docusign Error','The Docusign API code is invalid, plese open System -> Utilites -> Electronic Signature Settings, then input the correct Docusign API code.')
				end if
				Return False
			Case -2
				Messagebox('Docusign Error','Cannot connect to Docusign server. You may experience some network connection issue.~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.')
				Return False
		End Choose
	end if
End If

ib_isvalid_sertifi = True

Return True



end function

public function integer of_get_doc_status (str_sertifi_doc astr_sertifi_doc, ref str_sertifi_file astr_sertifi_file, boolean ab_showerror, string as_license_user_id);//Added By Jay Chen 09-04-2014 override of_get_doc_status add parameter as_license_user_id

String ls_filestatus = 'error'
String ls_error,ls_errormessage
integer li_ret,i = 1,j,k
string ls_null,ls_docname

setnull(ls_null)
tns__docusigndocumentinformation ltns__documentinfo

SetPointer(HourGlass!)

is_es_license_user_id = as_license_user_id //Added By Jay Chen 09-04-2014
if isnull(is_es_license_user_id) or is_es_license_user_id = '' then is_es_license_user_id = 'global_license_user' 

if ib_change_license_user then //Added By Jay Chen 09-04-2014 avoid repeat ping docusign server in same apicode when refresh docusign unsigned document
//	If Not ib_isvalid_sertifi Then 
		If Not This.of_check_sertifi( ) Then Return -1
//	End If
end if
	
Try
//     ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
		ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid, long(astr_sertifi_doc.as_es_docid))
	else
		ltns__documentinfo = isoap_docusign.requeststatus(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid,0)
	end if
	 ls_errormessage = ltns__documentinfo.errormessage
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	if gb_message = true then 
		gnv_debug.of_message("Docusign Error(of_get_doc_status("+astr_sertifi_doc.as_es_fileid+" , "+astr_sertifi_doc.as_es_docid+")): "+E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	else
		Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	end if 
End Try

If Left(Lower(ls_errormessage),5) = 'error' Then
	If ab_showerror Then Messagebox('Error',ls_errormessage+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	gnv_debug.of_output(True, 'Failed to get file docusign status.' + ls_errormessage)
	gnv_debug.of_output(True, 'Document ID:' + String(astr_sertifi_doc.al_doc_id ))
	gnv_debug.of_output(True, 'ES File ID:' + astr_sertifi_doc.as_es_fileid  )
	ib_isvalid_sertifi = False
	Return -1
End If


//Get docusign Document Info
//select doc_name into :ls_docname from ctx_am_document where es_docid = :astr_sertifi_doc.as_es_docid and es_fileid = :astr_sertifi_doc.as_es_fileid; //Modified By Jay Chen 04-30-2014
select doc_name into :ls_docname from ctx_am_document where doc_id = :astr_sertifi_doc.al_doc_id;
astr_sertifi_file.astr_sertifi_document[i].DocumentID  = astr_sertifi_doc.as_es_docid
astr_sertifi_file.name = ltns__documentinfo.documentname 
astr_sertifi_file.astr_sertifi_document[i].Name  = ls_docname
astr_sertifi_file.astr_sertifi_document[i].Status  = ltns__documentinfo.status

//Get docusign Signature Info
For j = 1 To UpperBound(ltns__documentinfo.signature[])
    	if pos(upper(ltns__documentinfo.signature[j].doctype),'SIGNER') = 0 then continue 
	k++
	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].Email  = ltns__documentinfo.signature[j].signeremail
	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].NameSigned  = ltns__documentinfo.signature[j].namesigned
	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].IpAddress  =  ltns__documentinfo.signature[j].signerip
	if isnull(ltns__documentinfo.signature[j].routingorder) then ltns__documentinfo.signature[j].routingorder = 1
	astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].signmethod = string(ltns__documentinfo.signature[j].routingorder)
//	messagebox('aaa',ltns__documentinfo.signature[j].signeddate)
//	if ltns__documentinfo.signature[j].signeddate = '01/01/0001 00:00:00' or date(ltns__documentinfo.signature[j].signeddate) = 1900-01-01 then	
    if isnull(ltns__documentinfo.signature[j].signstatus)  or lower(ltns__documentinfo.signature[j].signstatus) <> 'completed' then
		astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].DateSigned  =  ls_null
	else
	    astr_sertifi_file.astr_sertifi_document[i].astr_sertifi_signature[k].DateSigned  = ltns__documentinfo.signature[j].signeddate
	end if
Next
		
Return li_ret

end function

public function string of_download_doc (str_sertifi_doc astr_sertifi_doc, string as_license_user_id);//Added By Jay Chen 09-04-2014 override of_download_doc add parameter as_license_user_id

Long ll_max,i,ll_readlength,ll_writelength
String ls_SertifiDirectory,ls_FileName
Blob lb_doc
w_appeon_gifofwait lw_appeon_gifofwait
tns__docusigneddocument ltns__SignedDocument

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Downloading document from Docusign server...")		

is_es_license_user_id = as_license_user_id 
if isnull(is_es_license_user_id) or is_es_license_user_id = '' then is_es_license_user_id = 'global_license_user' 

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

//Download the file from docusign
SetPointer(HourGlass!)
If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then 
		If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
		Return ''
	End If
End If

Try
//	ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password, astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_docid,true)
	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
		ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode ,astr_sertifi_doc.as_es_fileid,true,long(astr_sertifi_doc.as_es_docid))
	else
		ltns__SignedDocument = isoap_docusign.requestenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode ,astr_sertifi_doc.as_es_docid,true,0)
	end if
Catch (Throwable	E2)	
	Messagebox('Error', E2.text+" ~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
End Try	

If Left(Lower(ltns__SignedDocument.errorText),5) = 'error' Then
	ib_isvalid_sertifi = False
	Return ''
End If

//Write blob into file
lb_doc = ltns__SignedDocument.document
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

public function string of_get_doc_maintance_link (str_sertifi_doc astr_sertifi_doc, string as_license_user_id);//Added By Jay Chen 09-04-2014 override of_get_doc_maintance_link add parameter as_license_user_id

String ls_link = 'error'
SetPointer(HourGlass!)

is_es_license_user_id = as_license_user_id //Added By Jay Chen 09-04-2014
if isnull(is_es_license_user_id) or is_es_license_user_id = '' then is_es_license_user_id = 'global_license_user' 

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return ''
End If

Try
//	ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
		ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_fileid)
	else
		ls_link = isoap_docusign.getauthenticationtoken(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode , astr_sertifi_doc.as_es_docid)
	end if
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
End Try

If Left(Lower(ls_link),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error',ls_link+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	Return ''
End If


Return ls_link
end function

public function integer of_invite_again (str_sertifi_doc astr_sertifi_doc, string as_email, string as_license_user_id);//Added By Jay Chen 09-04-2014 override of_invite_again add parameter as_license_user_id

String ls_link = 'error'
SetPointer(HourGlass!)

is_es_license_user_id = as_license_user_id //Added By Jay Chen 09-04-2014
if isnull(is_es_license_user_id) or is_es_license_user_id = '' then is_es_license_user_id = 'global_license_user' 

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try	
	if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
		ls_link = isoap_docusign.correctandresendenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_fileid,as_email)
	else
		ls_link = isoap_docusign.correctandresendenvelope(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode,astr_sertifi_doc.as_es_docid,as_email)
	end if
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
End Try

If Left(Lower(ls_link),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error',ls_link+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	Return -1
End If

Return 1


end function

public function integer of_removesignaturerequest (str_sertifi_doc astr_sertifi_doc, string as_license_user_id);//Added By Jay Chen 09-04-2014 override of_removesignaturerequest add parameter as_license_user_id

string ls_errcode,ls_errdesc
boolean lb_success = false
String ls_ret = 'error'

SetPointer(HourGlass!)

is_es_license_user_id = as_license_user_id //Added By Jay Chen 09-04-2014
if isnull(is_es_license_user_id) or is_es_license_user_id = '' then is_es_license_user_id = 'global_license_user' 


If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

Try
//	ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_docid,gnv_docusign.is_acctid)
	 if IsNumber(astr_sertifi_doc.as_es_docid) then //Added By Jay Chen 04-30-2014
	 	if astr_sertifi_doc.as_es_fileid <> '' then
			ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_fileid,gnv_docusign.is_acctid)
		else
			Return -1
		end if
	else
		if astr_sertifi_doc.as_es_docid <> '' then
			ls_ret = isoap_docusign.deleteenvelopes(gnv_docusign.is_username,gnv_docusign.is_password,astr_sertifi_doc.as_es_apicode, astr_sertifi_doc.as_es_docid,gnv_docusign.is_acctid)
		else
			Return -1
		end if
	end if
Catch (Throwable	E2)	
	ib_isvalid_sertifi = False
	Messagebox('Error', E2.text +"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help." )
	return -1
End Try

If Left(Lower(ls_ret),5) = 'error' Then
	ib_isvalid_sertifi = False
	Messagebox('Error ','Failed to remove the signature request. ' + ls_ret+"~r~n~r~nPlease contact your system administrator or IntelliSoft Group support for additional help.")
	Return -1
End If


Return 1
end function

public function integer of_trigger_workflow (str_action_item astr_action[]);
str_action_item 				lstr_action[1]
n_cst_WorkFlow_triggers		lnv_Trigger
	
 
	 

// Trigger work flow
If gb_WorkFlow and Not IsNull( astr_action[1].wf_id) Then
	lstr_action[1].ctx_id = astr_action[1].ctx_id
	lstr_action[1].seq_no = astr_action[1].seq_no
	lstr_action[1].doc_id = astr_action[1].doc_id
	lstr_action[1].wf_id = astr_action[1].wf_id
	lstr_action[1].wf_Action_Status_id = astr_action[1].wf_Action_Status_id
	lstr_action[1].wf_action_type_id =astr_action[1].wf_action_type_id
	lstr_action[1].status_changed_flag = False
	lstr_action[1].module = "04" 				//Contract Logix Document manager
	lstr_action[1].trigger_by = "008"		//Trigger By Action Item Changed
	lstr_action[1].screen_id = -10

	//Create Work Flow By Action Item Changed
	lnv_Trigger.of_WorkFlow_triggers(lstr_action)
End If
If Isvalid( lnv_Trigger ) Then Destroy( lnv_Trigger )

Return 0

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
// Author:	 Harry 2016-07-14.
//--------------------------------------------------------------------
// Description: Refresh the Sertifi Document Status, Reset sig_status and Download the signed files.
//				   Application Electronic Signature - Docusign
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////


Long i,ll_cnt,j, ll_signed_count, ll_downerror_cnt, ll_need_down
String ls_filter,ls_es_fileid,ls_es_apicode,ls_docid_list,ls_es_docid_list,ls_sql
n_ds lds_waiting_sign
str_sertifi_doc lstr_sertifi_doc ,str_sertifi_doc_temp
str_sertifi_file lstr_sertifi_file,lstr_sertifi_file_temp
w_appeon_gifofwait lw_appeon_gifofwait
string ls_license_user_id,ls_license_user_id_old //Added By Jay Chen 09-04-2014
Int li_sig_status
integer  li_msg = 1
String ls_download_path
DateTime ldt_null
string ls_ext, ls_filename
Blob	lblb_ImageData
long ll_complete
long ll_status
n_cst_dm_utils lnv_utils

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

ls_filter += " and esign_type = 'docusign'"

lds_waiting_sign.SetFilter(ls_filter)
lds_waiting_sign.Filter()
ll_cnt = lds_waiting_sign.Rowcount( ) 
If ll_cnt = 0 Then Return 1

If Not ib_isvalid_sertifi Then 
	If Not This.of_check_sertifi( ) Then Return -1
End If

If not isvalid(lw_appeon_gifofwait) Then OpenwithParm(lw_appeon_gifofwait,"Retrieving E-sign documents status from docusign server...")
timer(0,lw_appeon_gifofwait)
lw_appeon_gifofwait.of_setmaxposition(ll_cnt+2)

//Get Sertifi Sign Status
For i = 1 To ll_cnt
	li_sig_status = lds_waiting_sign.GetItemNumber(i, 'sig_status')
	If li_sig_status = 1 Then
		lstr_sertifi_doc = str_sertifi_doc_temp
		lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
		lstr_sertifi_doc.as_es_apicode =  lds_waiting_sign.GetItemString(i, 'es_apicode')
		lstr_sertifi_doc.as_es_fileid =  lds_waiting_sign.GetItemString(i, 'es_fileid')
		lstr_sertifi_doc.as_es_docid =  lds_waiting_sign.GetItemString(i, 'es_docid')
		lstr_sertifi_doc.as_es_sender =  lds_waiting_sign.GetItemString(i, 'es_sender')
		lstr_sertifi_doc.as_es_email =  lds_waiting_sign.GetItemString(i, 'es_sender_email')
		
		
		lstr_sertifi_file = lstr_sertifi_file_temp
		//Added By Jay Chen 09-04-2014
		ls_license_user_id = lds_waiting_sign.GetItemString(i, 'es_license_user_id')
		if ls_license_user_id_old = ls_license_user_id then 
			ib_change_license_user = false
		else
			ib_change_license_user = true
			ib_isvalid_sertifi = False
		end if
		
		If This.of_get_doc_status( lstr_sertifi_doc, lstr_sertifi_file,false,ls_license_user_id) < 0 Then Continue
		
		If This.of_get_doc_signed_status( lstr_sertifi_doc.as_es_docid , lstr_sertifi_file)	Then
			lds_waiting_sign.SetItem(i, 'sig_status' ,2)
			ll_signed_count ++
		End If
		ls_es_apicode = lstr_sertifi_doc.as_es_apicode
		ls_es_fileid = lstr_sertifi_doc.as_es_fileid
		ls_license_user_id_old = ls_license_user_id //Added By Jay Chen 09-04-2014
	Else
		ll_signed_count ++
	End If
Next

ib_change_license_user = true //Added By Jay Chen 09-04-2014

ll_need_down = 0
If ll_signed_count > 0 Then
	If al_rec_id = 0 Then
		li_msg = Messagebox("Prompt", "There are " +String(ll_signed_count) + " documents that have been signed and need to be downloaded.  Do you wish to do this now?  It may take several minutes. ", Exclamation!, YesNo!, 2)	//Modified by (Appeon)Freeze 2017-08-17 for Bug 5760: Refresh Document Signature Data typo
	End If
	//DownLoad Docment from Sertifi Server, Then upload db.
	If li_msg = 1 Then
		//DownLoad Document from Sertifi Server, Then upload db.
		ll_downerror_cnt = 0
		For i = 1 To ll_cnt
			li_sig_status = lds_waiting_sign.GetItemNUmber(i, 'sig_status')
			If li_sig_status <> 2 Then Continue
			ll_need_down ++
			lw_appeon_gifofwait.of_settext("Download the signed document from docusign server "+String(ll_need_down)+'/'+String(ll_signed_count)+"...")
			lw_appeon_gifofwait.of_setposition(i)
			
			lstr_sertifi_doc.al_doc_id = lds_waiting_sign.GetItemNumber(i, 'rec_id')
			If of_download_from_sertifi(lstr_sertifi_doc.al_doc_id) =  1 then
				lds_waiting_sign.SetItem(i, 'sig_status' ,3)
				lds_waiting_sign.SetItem(i, 'sig_in_date', DateTime(Today(),Now()))  
				//Add by Harry 07.19.2016 for BugA071501
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
	Return 0
End If

//Update net_dev_action_items
If isvalid(lw_appeon_gifofwait) Then lw_appeon_gifofwait.of_settext('Updating documents status...')
If lds_waiting_sign.update() = 1 Then
Else
	If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
	Return -2
End If
	
lw_appeon_gifofwait.of_setposition(ll_cnt  + 2)
If isvalid(lw_appeon_gifofwait) Then Close(lw_appeon_gifofwait)
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

on n_cst_docusign.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_docusign.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If isvalid(isoap_conn) Then Destroy isoap_conn
end event

