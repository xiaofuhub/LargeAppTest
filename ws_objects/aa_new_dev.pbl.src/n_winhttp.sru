$PBExportHeader$n_winhttp.sru
forward
global type n_winhttp from nonvisualobject
end type
end forward

global type n_winhttp from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetLastError( ) Library "kernel32.dll"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function boolean WinHttpCloseHandle ( &
	ulong hInternet &
	) Library "winhttp.dll"

Function ulong WinHttpOpen ( &
	string pwszUserAgent, &
	ulong dwAccessType, &
	ulong pwszProxyName, &
	ulong pwszProxyBypass, &
	ulong dwFlags &
	) Library "winhttp.dll"

Function ulong WinHttpConnect ( &
	ulong hSession, &
	string pswzServerName, &
	uint nServerPort, &
	ulong dwReserved &
	) Library "winhttp.dll"

Function ulong WinHttpOpenRequest ( &
	ulong hConnect, &
	string pwszVerb, &
	string pwszObjectName, &
	ulong pwszVersion, &
	ulong pwszReferrer, &
	ulong ppwszAcceptTypes, &
	ulong dwFlags &
	) Library "winhttp.dll"

Function boolean WinHttpSendRequest ( &
	ulong hRequest, &
	ulong pwszHeaders, &
	ulong dwHeadersLength, &
	ulong lpOptional, &
	ulong dwOptionalLength, &
	ulong dwTotalLength, &
	ulong dwContext &
	) Library "winhttp.dll"

Function boolean WinHttpReceiveResponse ( &
	ulong hRequest, &
	ulong lpReserved &
	) Library "winhttp.dll"

Function boolean WinHttpQueryDataAvailable ( &
	ulong hRequest, &
	Ref ulong lpdwNumberOfBytesAvailable &
	) Library "winhttp.dll"

Function boolean WinHttpReadData ( &
	ulong hRequest, &
	Ref blob lpBuffer, &
	ulong dwNumberOfBytesToRead, &
	Ref ulong lpdwNumberOfBytesRead &
	) Library "winhttp.dll"

Function boolean WinHttpWriteData ( &
	ulong hRequest, &
	Ref blob lpBuffer, &
	ulong dwNumberOfBytesToWrite, &
	Ref ulong lpdwNumberOfBytesWritten &
	) Library "winhttp.dll"

Function boolean WinHttpSetTimeouts ( &
	ulong hInternet, &
	ulong dwResolveTimeout, &
	ulong dwConnectTimeout, &
	ulong dwSendTimeout, &
	ulong dwReceiveTimeout &
	) Library "winhttp.dll"

Function boolean WinHttpAddRequestHeaders ( &
	ulong hRequest, &
	string pwszHeaders, &
	ulong dwHeadersLength, &
	ulong dwModifiers &
	) Library "winhttp.dll" Alias For "WinHttpAddRequestHeaders"

end prototypes

type variables
Private:

// WinHttpOpen dwAccessType values
Constant ulong WINHTTP_ACCESS_TYPE_DEFAULT_PROXY	= 0
Constant ulong WINHTTP_ACCESS_TYPE_NO_PROXY			= 1
Constant ulong WINHTTP_ACCESS_TYPE_NAMED_PROXY		= 3

// WinHttpOpen prettifiers for optional parameters
Constant ulong WINHTTP_NO_PROXY_NAME	= 0
Constant ulong WINHTTP_NO_PROXY_BYPASS	= 0

// WinHttpConnect ServerPort values
Constant uint INTERNET_DEFAULT_PORT			= 0
Constant uint INTERNET_DEFAULT_HTTP_PORT	= 80
Constant uint INTERNET_DEFAULT_HTTPS_PORT	= 443

// WinHttpOpenRequest prettifers for optional parameters
Constant ulong WINHTTP_NO_REFERER				= 0
Constant ulong WINHTTP_DEFAULT_ACCEPT_TYPES	= 0

// WinHttpOpenRequest dwFlags values
Constant ulong WINHTTP_FLAG_BYPASS_PROXY_CACHE	= 256
Constant ulong WINHTTP_FLAG_SECURE					= 8388608

// WinHttpSendRequest prettifiers for optional parameters.
Constant ulong WINHTTP_NO_ADDITIONAL_HEADERS	= 0
Constant ulong WINHTTP_NO_REQUEST_DATA			= 0

// WinHttpAddRequestHeaders values for dwModifiers parameter.
Constant ulong WINHTTP_ADDREQ_FLAG_ADD     = 536870912	// 0x20000000
Constant ulong WINHTTP_ADDREQ_FLAG_REPLACE = 2147483648	// 0x80000000

// timeout values
Long il_ResolveTimeout	= 0
Long il_ConnectTimeout	= 60000
Long il_SendTimeout		= 30000
Long il_ReceiveTimeout	= 30000

ULong iul_session, iul_connect, iul_request
String is_method

Public:

String ResponseText

end variables

forward prototypes
public function boolean setrequestheader (string as_name, string as_value)
public subroutine settimeouts (long al_resolvetimeout, long al_connecttimeout, long al_sendtimeout, long al_receivetimeout)
public function boolean open (string as_method, string as_url)
public function boolean send (string as_body)
public function boolean send ()
private function integer geterrormsg (string as_function, ref string as_msgtext)
end prototypes

public function boolean setrequestheader (string as_name, string as_value);// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.SetRequestHeader
//
// PURPOSE:		This function adds a request header.
//
// ARGUMENTS:	as_name	- The name of the header
//					as_value	- The value of the header
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

Constant String CRLF = "~r~n"
String ls_header, ls_errtext
Boolean lb_results
Integer li_errornum

ls_Header = Trim(as_name) + ": " + Trim(as_value) + CRLF
lb_Results = WinHttpAddRequestHeaders(iul_request, ls_Header, -1, &
						WINHTTP_ADDREQ_FLAG_ADD + WINHTTP_ADDREQ_FLAG_REPLACE)
If Not lb_Results Then
	WinHttpCloseHandle(iul_request)
	WinHttpCloseHandle(iul_connect)
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpAddRequestHeaders", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

Return True

end function

public subroutine settimeouts (long al_resolvetimeout, long al_connecttimeout, long al_sendtimeout, long al_receivetimeout);// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.SetTimeouts
//
// PURPOSE:		This function sets the timeout options. All are in
//					milliseconds.
//
// ARGUMENTS:	al_ResolveTimeout	-	Timeout for name resolution.
//												Default=0 (Infinite)
//					al_ConnectTimeout	-	Timeout for server connection requests.
//												Default=60000 (60 seconds)
//					al_SendTimeout		-	Timeout for sending requests.
//												Default=30000 (30 seconds)
//					al_ReceiveTimeout	-	Timeout for receiving a response.
//												Default=30000 (30 seconds)
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

il_ResolveTimeout	= al_ResolveTimeout
il_ConnectTimeout	= al_ConnectTimeout
il_SendTimeout		= al_SendTimeout
il_ReceiveTimeout	= al_ReceiveTimeout

end subroutine

public function boolean open (string as_method, string as_url);// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.Open
//
// PURPOSE:		This function initiates the request.
//
// ARGUMENTS:	as_method	- The HTTP method such as GET or PUT
//					as_url		- The requested URL
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

Long ll_pos
String ls_url, ls_ServerName, ls_FileName, ls_errtext
UInt lui_port
ULong lul_dwFlags
Integer li_errornum
Boolean lb_results

// parse the URL into protocol, server and file
ll_pos = Pos(as_url, "://")
If ll_pos > 0 Then
	ls_url = Mid(as_url, ll_pos + 3)
	If Lower(Left(as_url, 5)) = "https" Then
		lui_port = INTERNET_DEFAULT_HTTPS_PORT
		lul_dwFlags = lul_dwFlags + WINHTTP_FLAG_SECURE
	End If
Else
	ls_url = as_url
End If
ll_pos = Pos(ls_url, "/")
If ll_pos = 0 Then
	ls_ServerName = ls_url
	ls_FileName = ""
Else
	ls_ServerName = Left(ls_url, ll_pos - 1)
	ls_FileName = Mid(ls_url, ll_pos + 1)
End If

// Use WinHttpOpen to obtain a session handle.
iul_session = WinHttpOpen(this.ClassName(), &
								 WINHTTP_ACCESS_TYPE_DEFAULT_PROXY, &
								 WINHTTP_NO_PROXY_NAME, &
								 WINHTTP_NO_PROXY_BYPASS, 0)
If iul_session = 0 Then
	li_errornum = GetErrorMsg("WinHttpOpen", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

// set the timeouts
lb_results = WinHttpSetTimeouts(iul_session, il_ResolveTimeout, &
						il_ConnectTimeout, il_SendTimeout, il_ReceiveTimeout)
If Not lb_Results Then
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpSetTimeouts", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

// Specify an HTTP server.
iul_connect = WinHttpConnect(iul_session, &
						ls_ServerName, lui_port, 0)
If iul_connect = 0 Then
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpConnect", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

// Note that use of WINHTTP_DEFAULT_ACCEPT_TYPES restricts
// the request to Text type files.

// Create an HTTP request handle.
is_method = Upper(as_method)
iul_request = WinHttpOpenRequest(iul_connect, is_method, &
						ls_FileName, 0, WINHTTP_NO_REFERER, &
						WINHTTP_DEFAULT_ACCEPT_TYPES, lul_dwFlags)
If iul_request = 0 Then
	WinHttpCloseHandle(iul_connect)
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpOpenRequest", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

Return True

end function

public function boolean send (string as_body);// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.Send
//
// PURPOSE:		This function sends the request.
//
// ARGUMENTS:	as_body	- The data to be sent with the request
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

Boolean lb_results
ULong lul_size, lul_read, lul_written, ll_len
Blob lblob_buffer
Integer li_errornum
String ls_errtext
n_cst_datetime lnv

ResponseText = ""


ll_len = len(as_body)
// Send a request.
lb_Results = WinHttpSendRequest(iul_request, WINHTTP_NO_ADDITIONAL_HEADERS, 	0, WINHTTP_NO_REQUEST_DATA, 0, ll_len, 0)
If Not lb_Results Then
	WinHttpCloseHandle(iul_request)
	WinHttpCloseHandle(iul_connect)
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpSendRequest", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If

//lnv.of_wait(3)
// Write data to the server.
If Len(as_body) > 0 Then
	lblob_buffer = Blob(as_body, EncodingAnsi!)
	lb_Results = WinHttpWriteData(iul_request, lblob_buffer, Len(lblob_buffer), lul_written)
	If Not lb_Results Then
		WinHttpCloseHandle(iul_request)
		WinHttpCloseHandle(iul_connect)
		WinHttpCloseHandle(iul_session)
		li_errornum = GetErrorMsg("WinHttpWriteData", ls_errtext)
		PopulateError(li_errornum, ls_errtext)
		Return False
	End If
End If

// End the request.
lb_Results = WinHttpReceiveResponse(iul_request, 0)
If Not lb_Results Then
	WinHttpCloseHandle(iul_request)
	WinHttpCloseHandle(iul_connect)
	WinHttpCloseHandle(iul_session)
	li_errornum = GetErrorMsg("WinHttpReceiveResponse", ls_errtext)
	PopulateError(li_errornum, ls_errtext)
	Return False
End If
debugbreak()
// Keep checking for response data until there is nothing left.
do
	// Check for available data.
	lul_size = 0
	If Not WinHttpQueryDataAvailable(iul_request, lul_size) Then
		WinHttpCloseHandle(iul_request)
		WinHttpCloseHandle(iul_connect)
		WinHttpCloseHandle(iul_session)
		li_errornum = GetErrorMsg("WinHttpQueryDataAvailable", ls_errtext)
		PopulateError(li_errornum, ls_errtext)
		Return False
	End If
	If lul_size > 0 Then
		// Allocate space for the buffer.
		lblob_buffer = Blob(Space(lul_size+1), EncodingAnsi!)
		// Read the Data.
		If Not WinHttpReadData(iul_request, lblob_buffer, lul_size, lul_read) Then
			WinHttpCloseHandle(iul_request)
			WinHttpCloseHandle(iul_connect)
			WinHttpCloseHandle(iul_session)
			li_errornum = GetErrorMsg("WinHttpReadData", ls_errtext)
			PopulateError(li_errornum, ls_errtext)
			Return False
		End If
		// Append data to by reference argument
		ResponseText += String(BlobMid(lblob_buffer, 1, lul_read), EncodingAnsi!)
		// Free the memory allocated to the buffer.
		SetNull(lblob_buffer)
	End If
loop while lul_size > 0

// Close any open handles.
WinHttpCloseHandle(iul_request)
WinHttpCloseHandle(iul_connect)
WinHttpCloseHandle(iul_session)

Return True

end function

public function boolean send ();// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.Send
//
// PURPOSE:		This function sends the request.
//
// RETURN:		True=Success, False=Error
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

Return Send("")

end function

private function integer geterrormsg (string as_function, ref string as_msgtext);// -----------------------------------------------------------------------
// SCRIPT:		n_winhttp.GetErrorMsg
//
// PURPOSE:		This function gets the most recent API error message.
//
// ARGUMENTS:	as_function	- The function that failed
//					as_msgtext	- The error message text
//
// RETURN:		Error Number
//
// DATE        PROG/ID		DESCRIPTION OF CHANGE / REASON
// ----------	---------	-----------------------------------------------
// 04/22/2011	RolandS		Initial Coding
// -----------------------------------------------------------------------

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_rtn, lul_error
String ls_msgtext

lul_error = GetLastError()

ls_msgtext = Space(255)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				lul_error, LANG_NEUTRAL, ls_msgtext, Len(ls_msgtext), 0)

as_msgtext = as_function + ":~r~n~r~n" + Trim(ls_msgtext)

Return lul_error

end function

on n_winhttp.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_winhttp.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

