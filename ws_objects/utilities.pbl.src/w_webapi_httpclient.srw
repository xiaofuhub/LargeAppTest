$PBExportHeader$w_webapi_httpclient.srw
forward
global type w_webapi_httpclient from w_popup
end type
type cb_1 from commandbutton within w_webapi_httpclient
end type
type st_1 from statictext within w_webapi_httpclient
end type
type mle_re_body from multilineedit within w_webapi_httpclient
end type
type ole_http from olecustomcontrol within w_webapi_httpclient
end type
type st_state from statictext within w_webapi_httpclient
end type
end forward

global type w_webapi_httpclient from w_popup
boolean visible = false
integer x = 214
integer y = 221
integer width = 2949
integer height = 1592
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_1 st_1
mle_re_body mle_re_body
ole_http ole_http
st_state st_state
end type
global w_webapi_httpclient w_webapi_httpclient

type variables
Private:
Boolean ib_test = False //Test Mode, show the window
Boolean ib_trace = False //Initiates loopback trace on remote server. 
Boolean ib_connected = False //From connected disconnected event
Boolean ib_requesting = False

Long il_errorcode //From Done event
Long il_req_method //set in of_set_properties.

String is_errortext	//From Done event
String is_state_text //From Statechange event

Int il_state_old = 0
Int il_state = 0
end variables

forward prototypes
public function integer of_set_properties (str_webapi_req astr_prop)
public function integer of_request ()
public function integer of_get_response (ref str_webapi_resp astr_resp)
public function String of_get_charset_text (long al_charset)
public function string of_get_errtext ()
public function integer of_request (str_webapi_req astr_req, ref str_webapi_resp astr_resp)
public subroutine of_set_trace (boolean ab_trace)
public subroutine of_set_testmode (boolean ab_test)
public subroutine of_abort ()
public function string of_get_request_body ()
end prototypes

public function integer of_set_properties (str_webapi_req astr_prop);//====================================================================
//$<Function>: of_set_properties
//$<Arguments>:
// 	value    str_webapi_req    astr_prop
//$<Return>:  integer 1:success /-1:Unsupported body type/ -2:RuntimeError
//$<Description>: set ole properties by str_webapi_req
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long li_cnt
Long i

TRY
	//1.ole_http.object.
	ole_http.object.hostname = astr_prop.hostname
	ole_http.object.Port = astr_prop.Port
	If IsNull(astr_prop.Timeout) Then astr_prop.Timeout = 120
	ole_http.object.Timeout = astr_prop.Timeout
	ole_http.object.httpversion = astr_prop.httpversion
	ole_http.object.secure = astr_prop.secure
	ole_http.object.Authentication = astr_prop.Authentication
	
	If IsNull(astr_prop.login) Then astr_prop.login = ''
	ole_http.object.login = astr_prop.login
	
	If IsNull(astr_prop.password) Then astr_prop.password = ''
	ole_http.object.password = astr_prop.password
	
	ole_http.object.Proxytype = astr_prop.Proxy_type
	
	If IsNull(astr_prop.Proxy_hostname) Then astr_prop.Proxy_hostname = ''
	ole_http.object.Proxyhostname = astr_prop.Proxy_hostname
	If IsNull(astr_prop.Proxy_port) Then astr_prop.Proxy_port = 80
	ole_http.object.ProxyPort = astr_prop.Proxy_port
	
	If IsNull(astr_prop.Proxy_authentication) Then astr_prop.Proxy_authentication = 0
	ole_http.object.ProxyAuthentication = astr_prop.Proxy_authentication
	
	If IsNull(astr_prop.Proxy_login) Then astr_prop.Proxy_login = ''
	ole_http.object.ProxyLogin = astr_prop.Proxy_login
	
	If IsNull(astr_prop.Proxy_password) Then astr_prop.Proxy_password = ''
	ole_http.object.ProxyPassword = astr_prop.Proxy_password
	
	//2.ole_http.object.request
	il_req_method= astr_prop.req_method
	ole_http.object.request.URI = astr_prop.req_uri
	
	//3.ole_http.object.request.headers
	ole_http.object.request.headers.RemoveAll()
	li_cnt = Upperbound(astr_prop.req_header_name[])
	If li_cnt > 0 Then
		For i = 1 to li_cnt
			ole_http.object.Request.Headers.Add(astr_prop.req_header_name[i], astr_prop.req_header_value[i])
		Next
	End If
	
	//4. ole_http.object.request.body
	li_cnt = Upperbound(astr_prop.req_body_name[])
	ole_http.object.Request.FormPost.RemoveAll()
	If li_cnt > 0 Then
		For i = 1 to li_cnt
			Choose case astr_prop.req_body_type[i] //variables 1(Username=joe&Password=joe)/string 2/ file 3
				Case 1//variables 1(Username=joe&Password=joe)
					ole_http.object.Request.FormPost.Add(astr_prop.req_body_name[i], astr_prop.req_body_value[i])
				Case 2
					If Upper(astr_prop.req_body_name[i]) = 'REQUEST BODY' and li_cnt = 1 Then//Set Request Body Directly, Added by Appeon long.zhang 05.27.2016 ()
						ole_http.object.Request.Body = astr_prop.req_body_value[i]
					Else
						ole_http.object.Request.FormUpload.Add(astr_prop.req_body_name[i], astr_prop.req_body_value[i])
					End If
				Case 3
					If FileExists(astr_prop.req_body_value[i]) Then					
						If Upper(astr_prop.req_body_name[i]) = 'REQUEST BODY' and li_cnt = 1 Then//Set Request Body Directly, Added by Appeon long.zhang 05.27.2016 ()
							ole_http.object.Request.FileName = astr_prop.req_body_value[i]
						Else
							ole_http.object.Request.FormUpload.AddFile(astr_prop.req_body_name[i], astr_prop.req_body_value[i])
						End If	
					End If
				Case Else //Unsupported body type	
					is_errortext = 'Unsupported body type'
					Return -1
			End Choose
		Next
	End If
	
	//5.ole_http.object.response.Filename
	//(This is the property where wodHttpDLX holds the filename of the file that will be stored.)
	//If LenA(astr_prop.response_filename) > 0 Then
		ole_http.object.response.Filename = astr_prop.response_filename
	//End If

CATCH ( RuntimeError e1 )
	is_errortext = e1.GetMessage()
	Return -2

END TRY

Return 1
end function

public function integer of_request ();//====================================================================
//$<Function>: of_request
//$<Arguments>:
//$<Return>:  integer -1:No method specified/-2 RuntimeError/-3 error code/ 1 sucess
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:Submit request to server
//====================================================================
n_cst_datetime lnv

//Trace for test
If ib_trace Then il_req_method = 6

Try
	//No blocking
	ole_http.object.Blocking = False
	ib_requesting = True
	
	Choose case il_req_method
		Case 0 //MethodUnknown 0 No method specified. 
			is_errortext = 'No method specified.'
			Return -1
		Case 1 //MethodGET 1 GET method is issued. Full resource should be retrieved, including resource body. 
			ole_http.object.Get()
		Case 2 //MethodHEAD 2 HEAD method is issued. Only resource headers should be retrieved. 
			ole_http.object.Head()
		Case 3 //MethodPOST 3 POST method is issued. Data is posted using some known content definition 
			//ole_http.object.Post()
			ole_http.object.Custom('POST')
		Case 4 //MethodPUT 4 PUT method is issued. Resource should be saved on the server on specified path. 
			ole_http.object.Put()
		Case 5 //MethodDELETE 5 DELETE method is issued. Resource should be deleted from the server. 
			//ole_http.object.Delete()
			ole_http.object.Custom('DELETE')
		Case 6 //MethodTRACE 6 TRACE method is issued. Server should generate loopback response. 
			ole_http.object.Trace()
		Case Else
			is_errortext = 'No method specified.'
			Return -1
	End Choose

CATCH ( RuntimeError e1 )
	
	is_errortext = e1.GetMessage ( )
	Return -2

END TRY

//Wait the method
Do while ib_requesting
	Yield()	
	lnv.of_wait(0.5)
Loop

//Restore blocking
ole_http.object.Blocking = True

//Check result
If il_errorcode <> 0 Then
	Return -3
End If

Return 1
end function

public function integer of_get_response (ref str_webapi_resp astr_resp);//====================================================================
//$<Function>: of_get_response
//$<Arguments>:
// 	reference    str_webapi_resp    astr_resp
//$<Return>:  integer -1 runtime error/1 success
//$<Description>: Set response information to Structure str_webapi_resp, and return it.
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt, i
OLEObject lole_headers

Try
	//Status
	astr_resp.status_code = ole_http.object.Response.StatusCode
	astr_resp.status = ole_http.object.Response.Status
	
	//Headers
	lole_headers = ole_http.object.Response.Headers 
	astr_resp.Headers = lole_headers.ToString()//ALL
	li_cnt = lole_headers.Count 
	If li_cnt > 0 Then
		For i = 1 to li_cnt
			astr_resp.hdr_name[i] = lole_headers.Item(i - 1).Name
			astr_resp.hdr_value[i] = lole_headers.Item(i - 1).Value
		Next
	End If
	
	//Charset
	astr_resp.charset = of_get_charset_text(Long(ole_http.object.Response.charset))
	
	astr_resp.contenttype = ole_http.object.Response.ContentType
	astr_resp.ContentEncoding = ole_http.object.Response.ContentEncoding
	
	//File
	astr_resp.length = ole_http.object.Response.length
	astr_resp.filename = ole_http.object.Response.filename
	
	astr_resp.body = ole_http.object.Response.body

CATCH ( RuntimeError e1 )
	is_errortext = e1.GetMessage ( )
	Return -1

END TRY

Return 1
end function

public function String of_get_charset_text (long al_charset);//====================================================================
//$<Function>: of_get_charset_text
//$<Arguments>:
// 	value    long    al_charset
//$<Return>:  String
//$<Description>: Get charset text
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_return
Choose Case al_charset 
	Case 0 //ActiveCP 0 ActiveCP 
		ls_return = 'ActiveCP'
	Case 20127// ASCII 20127 ASCII 
		ls_return = 'ASCII'
 	Case 950// BIG5 950 BIG5 
		ls_return = 'BIG5'
	Case 1125//  CP1125 1125 CP1125 
		ls_return = 'CP1125'
 	Case 1250// CP1250 1250 CP1250 
		ls_return = 'CP1250'
 	Case 1251// CP1251 1251 CP1251 
		ls_return = 'CP1251'
 	Case 1252// CP1252 1252 CP1252 
		ls_return = 'CP1252'
 	Case 1253// CP1253 1253 CP1253 
		ls_return = 'CP1253'
 	Case 1254// CP1254 1254 CP1254 
		ls_return = 'CP1254'
 	Case 1255// CP1255 1255 CP1255 
		ls_return = 'CP1255'
 	Case 1256// CP1256 1256 CP1256 
		ls_return = 'CP1256'
 	Case 1257// CP1257 1257 CP1257 
		ls_return = 'CP1257'
 	Case 1258// CP1258 1258 CP1258 
		ls_return = 'CP1258'
 	Case 437// CP437 437 CP437 
		ls_return = 'CP437'
	Case 720//  CP720 720 CP720 
		ls_return = 'CP720'
 	Case 737// CP737 737 CP737 
		ls_return = 'CP737'
 	Case 775// CP775 775 CP775 
		ls_return = 'CP775'
 	Case 850// CP850 850 CP850 
		ls_return = 'CP850'
 	Case 852// CP852 852 CP852 
		ls_return = 'CP852'
 	Case 855// CP855 855 CP855 
		ls_return = 'CP855'
 	Case 857// CP857 857 CP857 
		ls_return = 'CP857'
 	Case 858// CP858 858 CP858 
		ls_return = 'CP858'
 	Case 862// CP862 862 CP862 
		ls_return = 'CP862'
 	Case 866// CP866 866 CP866 
		ls_return = 'CP866'
 	Case 874// CP874 874 CP874 
		ls_return = 'CP874'
 	Case 932// CP932 932 CP932 
		ls_return = 'CP932'
 	Case 936// EUCCN 936 EUCCN 
		ls_return = 'EUCCN'
 	Case 20932// EUCJP 20932 EUCJP 
		ls_return = 'EUCJP'
 	Case 949// EUCKR 949 EUCKR 
		ls_return = 'EUCKR'
 	Case 936// GB18030 936 GB18030 
		ls_return = 'GB18030'
 	Case 936// GB2312 936 GB2312 
		ls_return = 'GB2312'
 	Case 936// GBK 936 GBK 
		ls_return = 'GBK'
 	Case 28591// ISO8859_1 28591 ISO8859_1 
		ls_return = 'ISO8859_1'
 	Case 28603// ISO8859_13 28603 ISO8859_13 
		ls_return = 'ISO8859_13'
 	Case 28605// ISO8859_15 28605 ISO8859_15 
		ls_return = 'ISO8859_15'
	Case 28592//  ISO8859_2 28592 ISO8859_2 
		ls_return = 'ISO8859_2'
	Case 28593//  ISO8859_3 28593 ISO8859_3 
		ls_return = 'ISO8859_3'
	Case 28594//  ISO8859_4 28594 ISO8859_4 
		ls_return = 'ISO8859_4'
	Case 28595//  ISO8859_5 28595 ISO8859_5 
		ls_return = 'ISO8859_5'
	Case 28596//  ISO8859_6 28596 ISO8859_6 
		ls_return = 'ISO8859_6'
	Case 28597//  ISO8859_7 28597 ISO8859_7 
		ls_return = 'ISO8859_7'
	Case 28598//  ISO8859_8 28598 ISO8859_8 
		ls_return = 'ISO8859_8'
	Case 28599//  ISO8859_9 28599 ISO8859_9 
		ls_return = 'ISO8859_9'
	Case 20866//  KOI8R 20866 KOI8R 
		ls_return = 'KOI8R'
	Case 21866//  KOI8U 21866 KOI8U 
		ls_return = 'KOI8U'
	Case 874//  TIS620 874 TIS620 
		ls_return = 'TIS620'
	Case 65001//  UTF8 65001 UTF8 
		ls_return = 'UTF8'
	Case Else
		ls_return = ''
End Choose

Return ls_return
end function

public function string of_get_errtext ();//====================================================================
//$<Function>: of_get_errtext
//$<Arguments>:
//$<Return>:  string
//$<Description>: Get last error text.
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return is_errortext
end function

public function integer of_request (str_webapi_req astr_req, ref str_webapi_resp astr_resp);//====================================================================
//$<Function>: of_request
//$<Arguments>:
//$<Return>:  integer 1 sucess/ -1X:Set properties error/ -2X:Requset Error/ -3X Get Response Error
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:Submit request to server
//====================================================================
Int li_rtn

//1.Set Properties
li_rtn = this.of_set_properties(astr_req)
If	li_rtn > 0 Then
	//2.Requset
	li_rtn =  of_request()
	If li_rtn > 0 Then
		//3.Get response
		li_rtn = of_get_response(astr_resp)
		If li_rtn > 0 Then
			Return 1
		Else
			is_errortext = 'Get Response error: ' + is_errortext
			Return -30 + li_rtn
		End If
	Else //of_request error
		is_errortext = 'Request error: ' + is_errortext
		Return -20 + li_rtn
	End If
Else //of_set_properties error
	is_errortext = 'Set properties error: ' + is_errortext
	Return -10 + li_rtn
End If

Return 1
end function

public subroutine of_set_trace (boolean ab_trace);//====================================================================
//$<Function>: of_set_trace
//$<Arguments>:
// 	value    boolean    ab_trace
//$<Return>:  (None)
//$<Description>: Trace method for test
//$<Author>: (Appeon) long.zhang 08.07.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_trace = ab_trace
end subroutine

public subroutine of_set_testmode (boolean ab_test);//====================================================================
//$<Function>: of_set_testmode
//$<Arguments>:
// 	value    boolean    ab_test
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.07.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_test = ab_test
this.visible = ab_test

If ab_test = False Then
	this.width = 0
	this.height = 0
Else
	this.width = 2949
	this.height = 1592
End If
end subroutine

public subroutine of_abort ();//====================================================================
//$<Function>: of_abort
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Aborts current request.
//$<Author>: (Appeon) long.zhang 08.13.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
n_cst_datetime lnv

If ib_requesting = False Then Return 

ole_http.object.abort()

lnv.of_wait(0.5)

ib_requesting = False
end subroutine

public function string of_get_request_body ();//====================================================================
//$<Function>: of_get_request_body
//$<Arguments>:
//$<Return>:  Request Body String
//$<Description>: Get Request body string. Called by n_cst_webapi.of_request.  Used in webapi setting - test tab.
//$<Author>: (Appeon) long.zhang 05.27.2016 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_rtn

Try
	//Status
	ls_rtn = ole_http.object.Request.Body
CATCH ( RuntimeError e1 )
	is_errortext = e1.GetMessage ( )
	Return ''
END TRY

Return ls_rtn
end function

on w_webapi_httpclient.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.st_1=create st_1
this.mle_re_body=create mle_re_body
this.ole_http=create ole_http
this.st_state=create st_state
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.mle_re_body
this.Control[iCurrent+4]=this.ole_http
this.Control[iCurrent+5]=this.st_state
end on

on w_webapi_httpclient.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.mle_re_body)
destroy(this.ole_http)
destroy(this.st_state)
end on

event open;call super::open;//Walkaround for web version.
this.width = 0
this.height = 0
this.hide()
end event

type cb_1 from commandbutton within w_webapi_httpclient
integer x = 2455
integer y = 20
integer width = 457
integer height = 132
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Abort"
end type

event clicked;of_abort()
end event

type st_1 from statictext within w_webapi_httpclient
integer x = 73
integer y = 60
integer width = 224
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "State:"
boolean focusrectangle = false
end type

type mle_re_body from multilineedit within w_webapi_httpclient
integer x = 27
integer y = 172
integer width = 2898
integer height = 1388
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ole_http from olecustomcontrol within w_webapi_httpclient
event done ( long errorcode,  string errortext )
event statechange ( integer oldstate )
event connected ( )
event disconnected ( long errorcode,  string errortext )
event headersdone ( )
event progress ( long position,  long total )
event clientcertrequired ( )
event hostcertificate ( oleobject cert,  long errorcode,  string errortext,  boolean accept )
event redirect ( string url,  boolean allow )
event progress64 ( long positionlo,  long positionhi,  long totallo,  long totalhi )
boolean visible = false
integer x = 1979
integer y = 20
integer width = 146
integer height = 128
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_webapi_httpclient.win"
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
end type

event done(long errorcode, string errortext);//====================================================================
//$<Event>: done
//$<Arguments>:
// 	value    long      errorcode
// 	value    string    errortext
//$<Return>:  (None)
//$<Description>: Fires when wodHttpDLX completes request.
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_errorcode = errorcode
is_errortext = errortext
ib_requesting = False

//Test Mode
If ib_test Then 
	If il_errorcode = 0 Then
		mle_re_body.Text = ole_http.object.Response.Body
	Else
		mle_re_body.Text = ErrorText
	End If
End If


end event

event statechange(integer oldstate);//====================================================================
//$<Event>: statechange
//$<Arguments>:
// 	value    integer    oldstate
//$<Return>:  (None)
//$<Description>: Fires when wodHttpDLX changes its state.
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_state_old = oldstate

il_state = ole_http.object.State
is_state_text= ole_http.object.StateString(ole_http.object.State)

//Test Mode
If ib_test Then st_state.Text = is_state_text

/*
StateNotConnected 0 Not connected. 
StateConnecting 1 Connecting to server. 
StateConnected 2 Connected - idle. 
StateSendingHeaders 3 Sending Headers data. 
StateSendingBody 4 Sending body data. 
StateWaitingResponse 5 Waiting for response from the server. 
StateReceivingHeaders 6 Receiving Headers data. 
StateReceivingBody 7 Receiving body data. 
StateDisconnecting 8 Disconnecting. 
*/
end event

event connected();//====================================================================
//$<Event>: connected
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Fires when wodHttpDLX connects to the server. 
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_connected = True
end event

event disconnected(long errorcode, string errortext);//====================================================================
//$<Event>: disconnected
//$<Arguments>:
// 	value    long      errorcode
// 	value    string    errortext
//$<Return>:  (None)
//$<Description>: Fires when wodHttpDLX disconnects from the server.
//$<Author>: (Appeon) long.zhang 08.04.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_connected = False

If ib_requesting Then 
	If il_errorcode = 0 Then //Unknown error.
		il_errorcode = -1
		is_errortext	= 'The last request was not successful, connection was closed.'
		of_abort()
	End If
End If
end event

event constructor;ole_http.object.Blocking = True
end event

type st_state from statictext within w_webapi_httpclient
integer x = 315
integer y = 52
integer width = 562
integer height = 96
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
03w_webapi_httpclient.bin 
2600000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000a0dc5f2001d1ba4d00000003000001400000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000260000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000010000005e00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004a353b0ab44ad3dfddf0a21ae5715ab6f00000000a0dc5f2001d1ba4da0dc5f2001d1ba4d000000000000000000000000fffffffe00000002fffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
25ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0058004e005500370048002d004a0050002d005a004100340059004d0043002d0051004d000000430000000000000000000000000000000000000000000000000000090000020008000000000050000300020000000b00780008000000000002000800000000000200030000000000000000000b000200080000000000030003000800000000000200080000000000020003000000000050005000030000000000000000000000000000000000000000000000000000000000000000000000000000090000020008000000000050000300020000000b00780008000000000002000800000000000200030000000000000000000b00020008000000000003000300080000000000020008000000000002000300000000005000500003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000005e000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
13w_webapi_httpclient.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
