$PBExportHeader$n_cst_ws_sendmail.sru
forward
global type n_cst_ws_sendmail from nonvisualobject
end type
end forward

global type n_cst_ws_sendmail from nonvisualobject
end type
global n_cst_ws_sendmail n_cst_ws_sendmail

type prototypes
Function boolean CryptBinaryToString ( &
	Blob pbBinary, &
	ulong cbBinary, &
	ulong dwFlags, &
	Ref string pszString, &
	Ref ulong pcchString &
	) Library "crypt32.dll" Alias For "CryptBinaryToStringW"

Function boolean CryptStringToBinary ( &
	string pszString, &
	ulong cchString, &
	ulong dwFlags, &
	Ref blob pbBinary, &
	Ref ulong pcbBinary, &
	Ref ulong pdwSkip, &
	Ref ulong pdwFlags &
	) Library "crypt32.dll" Alias For "CryptStringToBinaryW"
end prototypes

type variables
SoapConnection isoap_conn
//wssendmailsoap isoap_ws_sendmail
sendmailsoap isoap_ws_sendmail

String is_soap_url = 'http://web.intellisoftgroup.com/webservice/sendmail.asmx?WSDL' //alfee 07.11.2016
//String is_soap_url = 'http://192.0.2.230:8081/webservice/sendmail.asmx?WSDL'
//String is_soap_url = 'http://192.0.3.172/webservice/sendmail.asmx?WSDL'

String is_err_text = '' //last error

Constant ULong CRYPT_STRING_BASE64 = 1
end variables

forward prototypes
public function integer of_create ()
public function string of_gen_validation (string as_password, string as_mailto)
public function integer of_sendemail (string as_subject, boolean ab_isbodyhtml, string as_body, string as_password, string as_emailto)
public function string of_encode64 (readonly blob ablob_data)
public function string of_encode64 (readonly string as_data)
public function string of_decode64 (readonly string as_encoded)
public function boolean of_testping ()
public function string of_get_err_text ()
public function string of_get_soap_url ()
end prototypes

public function integer of_create ();long ll_ret = -1
string ls_ret

Try
	isoap_conn = Create SoapConnection
	isoap_conn.SetTimeout (100) //TimeOut, Added by Appeon long.zhang 06.28.2016
	ll_ret = isoap_conn.CreateInstance(isoap_ws_sendmail, "sendmailsoap",is_soap_url)	
	If ll_ret <> 0 Then
		If isvalid(isoap_ws_sendmail) Then Destroy isoap_ws_sendmail
	End If
Catch (throwable e1)
	If isvalid(isoap_ws_sendmail) Then Destroy isoap_ws_sendmail
	Return ll_ret
End Try

Return 0
end function

public function string of_gen_validation (string as_password, string as_mailto);

//Generate a validation string using as_password and as_mailto, it will be parsed in Web Service

String ls_auth
String ls_email
String ls_pass
String ls_validation
n_cst_encrypt luo_encrypt
Constant Int  ENCRYPTION_VAL_SUBTRACT = 80 //Only used to encrypt 'Encryption Value'.

ls_auth = luo_encrypt.of_encrypt2( as_password, as_mailto)
ls_email =  luo_encrypt.of_encrypt( as_mailto)
ls_pass =  luo_encrypt.of_encrypt( as_password)

//Check values
If  (gi_encryption_val >160 or gi_encryption_val< 126 or LenA(ls_pass) <> 20 or LenA(ls_auth) <> 21) Then
	Return '' //Failed
Else
	//Combine values to a string
	//Encryption Value [1 bytes]: CharA(set_45  - 80)  //set_45(126~160) //80 is used to encrypt 'Encryption Value'.
	//							+2.Password [20 bytes]
	//							+3.Auth [21 bytes]
	//							+4.Emailto[n bytes]

	ls_validation = CharA(gi_encryption_val - ENCRYPTION_VAL_SUBTRACT) + ls_pass + ls_auth + ls_email
	
	//base64
	ls_validation = of_encode64(ls_validation)
End If

Return  ls_validation

end function

public function integer of_sendemail (string as_subject, boolean ab_isbodyhtml, string as_body, string as_password, string as_emailto);Int i
Int li_rtn
Int iResult
String ls_rtn
String ls_validation
any paralist[]
appeonwebservicecomponent caller

If AppeonGetClientType() = "PB" then	
	i = of_create()
	If i <> 0 Then
		is_err_text = 'WS Proxy Error' + String(i) + ': Failed to create the SOAP instance, please call support.'
		Return -1
	End If
End If

If Not of_testping() Then
	is_err_text = 'Test Ping Failed. ' + is_err_text
	Return -2
End If

//validation 
ls_validation = of_gen_validation(as_password, as_emailto)
If LenA(ls_validation) = 0 Then
	is_err_text ="Failed to generate validation string."
	Return -3
End If

tns__of_sendmail lstr_sendmail
lstr_sendmail.as_subject = as_subject
lstr_sendmail.ab_isbodyhtml = ab_isbodyhtml
lstr_sendmail.as_body = as_body
lstr_sendmail.as_validation = ls_validation

If AppeonGetClientType() = "PB" then
	Try
		li_rtn = isoap_ws_sendmail.of_sendmail( lstr_sendmail.as_subject, lstr_sendmail.ab_isbodyhtml, lstr_sendmail.as_body, lstr_sendmail.as_validation)
	Catch (Throwable  ee)
		Destroy isoap_conn
		is_err_text = ee.getmessage()
		Return -4
	End Try
	
Else //Web
	
	caller=create appeonwebservicecomponent
	
	caller.calltype="1"
	caller.proxydllorurl= is_soap_url
	
	caller.classdescript=""
	paralist[1] = lstr_sendmail.as_subject
	paralist[2] = lstr_sendmail.ab_isbodyhtml
	paralist[3] = lstr_sendmail.as_body
	paralist[4] =lstr_sendmail.as_validation
	li_rtn=caller.of_callwebservice("of_sendmail",paralist)
	if li_rtn=0 then
		iResult=caller.ReturnValue //-x:failed/ 1:successful
	else
		iResult = 0
		is_err_text = caller.ErrorText
	end if
	
	Destroy caller
	
	If iResult = 0 Then Return -5
	
	li_rtn = iResult
End If

//WebService return value
If li_rtn <0 Then
	If li_rtn <= -30 and li_rtn>=-50 Then //.net System.Net.Mail.SmtpException, generate when excuting Send() method.
		is_err_text = 'SMTP Exception. (' + String(li_rtn) + ')'
	ElseIf li_rtn <= -20 and li_rtn>-30 Then//-20,-21,-22, -23, -24, -25 (MySMTPHost,MySMTPPort,MySMTPEnableSsl,MyEmailAddress,MyUseDefaultCredentials,MyAccount,MyPassword)
		is_err_text = 'SMTP Settings (Web Service) are not correct.'
	ElseIf li_rtn<= -10 and li_rtn > -20 Then
		is_err_text = 'Wrong parameters.'		
	ElseIf li_rtn = -1 Then
		is_err_text = 'Sendemail Method failed.'
	Else
		is_err_text = 'Undefined error.'
	End If
	Return li_rtn
End If

Return 1


end function

public function string of_encode64 (readonly blob ablob_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_winsock.of_Encode64
//
// PURPOSE:    This function converts binary data to a Base64 encoded string.
//
//					Note: Requires Windows XP or Server 2003
//
// ARGUMENTS:  ablob_data - Blob containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 08/20/2010	RolandS		Initial coding
// 09/27/2010	RolandS		Changed to remove trailing CRLF characters
// 03/17/2012	RolandS		Changed argument to read-only
// -----------------------------------------------------------------------------

String ls_encoded
ULong lul_len, lul_buflen
Boolean lb_rtn

lul_len = Len(ablob_data)

lul_buflen = lul_len * 3

ls_encoded = Space(lul_buflen)

lb_rtn = CryptBinaryToString(ablob_data, lul_len, &
					CRYPT_STRING_BASE64, ls_encoded, lul_buflen)
If lb_rtn Then
	ls_encoded = Left(ls_encoded, lul_buflen - 2)
Else
	SetNull(ls_encoded)
End If

Return ls_encoded

end function

public function string of_encode64 (readonly string as_data);// -----------------------------------------------------------------------------
// SCRIPT:     n_smtp.of_Encode64
//
// PURPOSE:    This function converts string to blob and
//					calls ancestor function.
//
// ARGUMENTS:  as_data - String containing data
//
// RETURN:     String containing encoded data
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------  --------		-----------------------------------------------------
// 09/27/2010	RolandS		Initial coding
// 03/17/2012	RolandS		Changed argument to read-only
// -----------------------------------------------------------------------------

Return of_Encode64(Blob(as_data, EncodingAnsi!))

end function

public function string of_decode64 (readonly string as_encoded);// -----------------------------------------------------------------------------
// SCRIPT:    	of_Decode64
//
// PURPOSE:    This function converts a Base64 encoded string to binary.
//
//					Note: Requires Windows XP or Server 2003
// -----------------------------------------------------------------------------

Blob lblob_data
ULong lul_len, lul_buflen, lul_skip, lul_pflags
Boolean lb_rtn

lul_len = Len(as_encoded)
lul_buflen = lul_len
lblob_data = Blob(Space(lul_len))

lb_rtn = CryptStringToBinary(as_encoded, &
					lul_len, CRYPT_STRING_BASE64, lblob_data, &
					lul_buflen, lul_skip, lul_pflags)

//Return BlobMid(lblob_data, 1, lul_buflen)

Return String(BlobMid(lblob_data, 1, lul_buflen), EncodingANSI! )

end function

public function boolean of_testping ();//====================================================================
//$<Function>: of_testping
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: Test the connect to webservice server
//$<Author>: (Appeon) long.zhang 06.03.2016 (v15.2 Forgotten Password Web Service)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int li_ret
Int iResult = 0
Any paralist[]
appeonwebservicecomponent caller

If AppeonGetClientType() = "PB" then	
	Try
		li_ret = isoap_ws_sendmail.of_testping(0) 
	
		If li_ret = 0 Then 
			Return False //Failed to connect to webservice server
		Else
			Return True
		End If
	Catch (Throwable	e1)
		is_err_text = e1.text
		Return False
	End Try
Else
	caller=create appeonwebservicecomponent
	
	caller.calltype="1"
	caller.proxydllorurl= is_soap_url
	
	caller.classdescript=""
	paralist[1] = '0'
	li_ret=caller.of_callwebservice("of_testping",paralist)
	if li_ret= 0 then
		iResult=caller.ReturnValue
	else
		iResult = 0
		is_err_text = caller.ErrorText
	end if
	
	Destroy caller
	
	Return (iResult = 1)		
End If

Return False
end function

public function string of_get_err_text ();Return is_err_text
end function

public function string of_get_soap_url ();//====================================================================
//$<Function>: of_get_soap_url
//$<Arguments>:
//$<Return>:  string
//$<Description>: Get Web Service URL
//$<Author>: (Appeon) long.zhang 06.06.2016 (v15.2 Forgotten Password Web Service)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_soap_url = ''

//Comment by Appeon long.zhang 10.21.2016
////Replace value of SOAP_URL_DEFAULT with ISG WebService URL HERE. ( e.g.: 'http://x.x.x/webservice/sendmail.asmx?WSDL')
//CONSTANT String SOAP_URL_DEFAULT = 'http://192.0.3.172/webservice/sendmail.asmx?WSDL' 

SELECT TOP 1 password_url INTO :ls_soap_url FROM ids;
If SQLCA.SQLCODE <> 0 or IsNull(ls_soap_url) Or Trim(ls_soap_url) = '' Then
	//ls_soap_url = SOAP_URL_DEFAULT
	ls_soap_url = is_soap_url //Don't change is_soap_url when not setting in ids.password_url, modified by Appeon long.zhang 10.21.2016 (for issue:Need help with setting up forgot password on QA app server)
End If

Return ls_soap_url
end function

on n_cst_ws_sendmail.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ws_sendmail.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If isvalid(isoap_conn) Then Destroy isoap_conn
end event

event constructor;is_soap_url = of_get_soap_url()
end event

