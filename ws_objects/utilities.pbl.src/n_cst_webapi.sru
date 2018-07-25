$PBExportHeader$n_cst_webapi.sru
forward
global type n_cst_webapi from nonvisualobject
end type
end forward

global type n_cst_webapi from nonvisualobject autoinstantiate
end type

type variables
Public:
datastore ids_inout 
String is_err_text

Protected:

//Settings - datastore objects are set in the constructor event
datastore ids_set_inout 
datastore ids_set_req
datastore ids_set_req_hdr
datastore ids_set_req_body
datastore ids_set_resp
datastore ids_set_resp_hdr
//datastore ids_set_resp_body may be used in later version

str_webapi_resp istr_response //last response

boolean ib_inout_used = false //use inout setting or not
Boolean ib_test_mode = false //Use test mode
Constant Integer INOUT_SIZE = 100

String is_request_body
end variables

forward prototypes
public function integer of_get_inout_ds (ref datastore ads_inout)
public function integer of_ini (long al_request_id)
public function integer of_set_request (ref str_webapi_req astr_req)
public function integer of_evaluate (ref string as_value)
public function integer of_request ()
public function integer of_set_outparms ()
public function integer of_set_inout_value (string as_col_nm, string as_value)
public function string of_get_response_value (string as_col_nm)
public function string of_get_response_value (string as_nm, boolean ab_header)
public subroutine of_set_testmode (boolean ab_test)
public function string of_get_errtext ()
public function integer of_get_inout_value (string as_col_nm, ref string as_value)
public function string of_get_request_body ()
end prototypes

public function integer of_get_inout_ds (ref datastore ads_inout);//====================================================================
//$<Function>: of_get_inout_ds
//$<Arguments>:
// 	reference    datastore    ads_inout
//$<Return>:  integer
//$<Description>: Return ids_inout, used to set in parms or get out parms.
//$<Author>: (Appeon) long.zhang 08.05.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Set Reference
If IsValid(ids_inout) Then
	ads_inout = ids_inout	
	Return 1
Else
	Return -1
End If
end function

public function integer of_ini (long al_request_id);//====================================================================
//$<Function>: of_ini
//$<Arguments>:
// 	value    long    al_request_id
//$<Return>:  integer -1:No Request Setting
//							 -2:SyntaxFromSQL error
//							 -3:Create ids_inout error
//							 1:succeed and ids_inout created
//							 0::succeed and no ids_inout created
//$<Description>: Initiate setting for one request id.
//$<Author>: (Appeon) long.zhang 08.05.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt
Int i
String ls_sql, ls_error, ls_dwsyntax_str
String ls_col

str_webapi_resp lstr_temp

//1.Reset instance variables
If IsValid(ids_inout) Then Destroy ids_inout
istr_response = lstr_temp

//2.Retrieve settings
gnv_appeondb.of_startqueue( )
ids_set_inout.Retrieve(al_request_id) 
ids_set_req.Retrieve(al_request_id) 
ids_set_req_hdr.Retrieve(al_request_id) 
ids_set_req_body.Retrieve(al_request_id) 
ids_set_resp.Retrieve(al_request_id) 
ids_set_resp_hdr.Retrieve(al_request_id) 
//ids_set_resp_body.Retrieve(al_request_id) 
gnv_appeondb.of_CommitQueue( )

//Check
If ids_set_req.RowCount() < 1 Then
	is_err_text = 'No Request Setting, Check Request Id ' + String(al_request_id) + ' please.'
	Return -1
End If

//3.Create syntax by in/out  parameters  
li_cnt = ids_set_inout.RowCount()
If li_cnt > 0 Then
	ib_inout_used = True
	ls_sql = 'SELECT '
	For i = 1 to li_cnt
		ls_col = ids_set_inout.GetItemString(i, 'name')
		If i = li_cnt Then
			ls_sql += ' Space(' +String(INOUT_SIZE) + ') as ' + ls_col 
		Else
			ls_sql += ' Space(' + String(INOUT_SIZE) + ') as ' + ls_col +','
		End If
	Next
	ls_sql += ' FROM ids'
	
	ids_inout = Create datastore
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, '', ls_error)
	IF Len(ls_error) > 0 THEN
		is_err_text = "SyntaxFromSQL caused these errors: " + ls_error + "~r~r" + ls_sql
		RETURN -2
	END IF

	i = ids_inout.Create( ls_dwsyntax_str, ls_error)
	if i < 1 then
		is_err_text = "Error on create ids_inout:" + ls_error
		RETURN -3
	end if

	ids_inout.InsertRow(0)
Else
	ib_inout_used = False
	Return 0
End If

Return 1
end function

public function integer of_set_request (ref str_webapi_req astr_req);//====================================================================
//$<Function>: of_set_request
//$<Arguments>:
// 	reference    str_webapi_req    astr_req
//$<Return>:  integer -1: No Request Setting
//							-2X:calculate URI error
//							-3X:calulate response_filename error
//							-4X:calulate reqest header value error
//							-5X:calulate reqest body value error
//$<Description>: Prepare settings to a str_webapi_req before request.
//$<Author>: (Appeon) long.zhang 08.05.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt
Int i, j
String ls_tmp

If ids_set_req.rowcount() = 0 Then
	is_err_text = 'No Request Setting initiated.'
	Return -1
End If

//1.ole_http.object.
astr_req.hostname = ids_set_req.GetItemString(1, 'webapi_main_hostname')
astr_req.Port = ids_set_req.GetItemNumber(1, 'webapi_main_port')
astr_req.httpversion = ids_set_req.GetItemString(1, 'webapi_main_httpversion')
astr_req.secure = ids_set_req.GetItemNumber(1, 'webapi_main_secure')
astr_req.Authentication = ids_set_req.GetItemNumber(1, 'webapi_main_authentication')
astr_req.login = ids_set_req.GetItemString(1, 'webapi_main_login_1')
astr_req.password = ids_set_req.GetItemString(1, 'webapi_main_password')

astr_req.Proxy_type = ids_set_req.GetItemNumber(1, 'webapi_main_proxy_type')
astr_req.Proxy_hostname = ids_set_req.GetItemString(1, 'webapi_main_proxy_hostname')
astr_req.Proxy_port = ids_set_req.GetItemNumber(1, 'webapi_main_proxy_port')
astr_req.Proxy_authentication = ids_set_req.GetItemNumber(1, 'webapi_main_proxy_authentication')
astr_req.Proxy_login = ids_set_req.GetItemString(1, 'webapi_main_proxy_login')
astr_req.Proxy_password = ids_set_req.GetItemString(1, 'webapi_main_proxy_password')
astr_req.timeout = ids_set_req.GetItemNumber(1, 'webapi_main_timeout')

//2.ole_http.object.request
astr_req.req_method = ids_set_req.GetItemNumber(1, 'method')

ls_tmp = ids_set_req.GetItemString(1, 'request_uri')
i = this.of_evaluate(ls_tmp)
If i < 0 Then
	is_err_text += ' (Request URI)'
	Return -20 + i
Else
	astr_req.req_uri = ls_tmp
End If

ls_tmp = ids_set_req.GetItemString(1, 'response_filename')
If IsNull(ls_tmp) Then
	ls_tmp = '' //This column is not required. Set default "" if it is null.
	astr_req.response_filename = ls_tmp
Else
	i = this.of_evaluate(ls_tmp)
	If i < 0 Then
		is_err_text += ' (Response File Name)'
		Return -30 + i
	Else
		astr_req.response_filename = ls_tmp
	End If
End If

//3.ole_http.object.request.headers
li_cnt = ids_set_req_hdr.rowcount()
For i = 1 to li_cnt
	astr_req.req_header_name[i] = ids_set_req_hdr.GetItemString(i, 'name')
	
	//Expresssion
	ls_tmp = ids_set_req_hdr.GetItemString(i, 'value')
	j = this.of_evaluate(ls_tmp)
	If j < 0 Then
		is_err_text += ' (Request Header)'
		Return -40 + j
	Else
		astr_req.req_header_value[i]  = ls_tmp
	End If
Next
	
//4. ole_http.object.request.body
li_cnt = ids_set_req_body.rowcount()
For i = 1 to li_cnt
	astr_req.req_body_type[i] = ids_set_req_body.GetItemNumber(i, 'type')
	astr_req.req_body_name[i] = ids_set_req_body.GetItemString(i, 'name')
	
	//Expresssion
	ls_tmp = ids_set_req_body.GetItemString(i, 'value_part')
	j = this.of_evaluate(ls_tmp)
	If j < 0 Then
		is_err_text += ' (Request Body)'
		Return -50 + j
	Else
		astr_req.req_body_value[i]  = ls_tmp
	End If
Next	

Return 1
end function

public function integer of_evaluate (ref string as_value);//====================================================================
//$<Function>: of_evaluate
//$<Arguments>:
// 	reference    string    as_exp
//$<Return>:  integer -1:Describe error 1/ -2:Describe error 2/1 success
//$<Description>: use ids_inout to calculate expression.
//$<Author>: (Appeon) long.zhang 08.05.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_rtn

If ib_inout_used Then
	ls_rtn = ids_inout.Describe("evaluate('"+as_value+"',1)")
	If ls_rtn = '!' Then
		is_err_text = 'Describe expression error:' + as_value + ', please check your setting.'
		Return -1
	End If
Else //change "xxx" to xxx if do not use parameters.
	ls_rtn = ids_set_req.Describe("evaluate('"+as_value+"',1)")
	If ls_rtn = '!' Then
		is_err_text = 'Describe expression error 2:' + as_value + ', please check your setting.'
		Return -2
	End If
End If

as_value = ls_rtn

Return 1

end function

public function integer of_request ();//====================================================================
//$<Function>: of_request
//$<Arguments>:
//$<Return>:  integer	-1XX:of_set_request error
//								 -2XX:w_webapi_httpclient.of_request error
//								 -3XX:of_set_outparms error
//$<Description>: send request and receive response data.
//$<Author>: (Appeon) long.zhang 08.07.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_rtn

str_webapi_req lstr_request

//1.Retrieve Setting from database by request_id
li_rtn = of_set_request(lstr_request)
If li_rtn < 0 Then
	Return -100+ li_rtn
End If

//2.Request
//2.1 open w_webapi_httpclient
If Not IsValid(w_webapi_httpclient) Then Open(w_webapi_httpclient)

//2.2 test mode, make it visible.
If ib_test_mode Then w_webapi_httpclient.of_set_testmode(true)	

li_rtn = w_webapi_httpclient.of_request(lstr_request, istr_response)
If li_rtn < 0 Then
	is_err_text = w_webapi_httpclient.of_get_errtext()
	Close(w_webapi_httpclient) //close window
	Return -200+ li_rtn
End If

//2.2 test mode, get request body.
If ib_test_mode Then is_request_body = w_webapi_httpclient.of_get_request_body()

//2.3 Close w_webapi_httpclient
Close(w_webapi_httpclient)//close window

//3.Refresh 'Out parameters' of ids_inout by istr_response
If ib_inout_used Then 
	li_rtn = of_set_outparms()
	If li_rtn < 0 Then
		Return -300+ li_rtn
	End If
End If

Return 1
end function

public function integer of_set_outparms ();//====================================================================
//$<Function>: of_set_outparms
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Set response value to ids_inout
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt,i
Int li_rtn
Long ll_find
String ls_value
String ls_col_nm
String ls_out_nm
String ls_head_nm

If Not  ib_inout_used Then Return -1

If ids_set_resp.rowcount() <> 1 and  ids_set_resp_hdr.rowcount() < 1 Then
	Return 0
End If

//Response setting
If ids_set_resp.rowcount() > 0 Then
	li_cnt = Integer(ids_set_resp.object.datawindow.Column.Count)
	For i = 1 to li_cnt
		If i = 1 Then Continue //request_id
		
		ls_out_nm = trim(ids_set_resp.GetItemString(1,  i)) //out parameter name
		If  IsNull(ls_out_nm) or Trim(ls_out_nm) = '' Then
			Continue
		ElseIf ids_inout.Describe(ls_out_nm+'.ColType') <> '!' Then //If in inout list
			ls_col_nm = ids_set_resp.Describe('#'+ String(i) +'.name') //Column name
	
			//Get value from istr_response
			ls_value = of_get_response_value(ls_col_nm) //response value
			
			//set value to ids_inout
			li_rtn = of_set_inout_value(ls_out_nm, ls_value)
			If li_rtn < 0 Then 
				is_err_text = 'Set ids_inout failed.'
				Return -3
			End If
		Else //bad  inout-parameters-list setting
			is_err_text = 'Bad In/Out Parameters setting.'
			Return -4	
		End If
	Next
End If

//datastore ids_set_resp_hdr
li_cnt = ids_set_resp_hdr.rowcount()
For i = 1 to li_cnt
	ls_head_nm = ids_set_resp_hdr.GetItemString(i, 'name')
	ls_out_nm = ids_set_resp_hdr.GetItemString(i, 'value')
	ls_value = of_get_response_value(ls_head_nm, True) //response value-header
	
	//set value to ids_inout
	li_rtn = of_set_inout_value(ls_out_nm, ls_value)
	If li_rtn < 0 Then 
		is_err_text = 'Set ids_inout failed (header).'
		Return -5
	End If
Next

//datastore ids_set_resp_body, may be used in later version

Return 1
end function

public function integer of_set_inout_value (string as_col_nm, string as_value);//====================================================================
//$<Function>: of_set_inout_value
//$<Arguments>:
// 	value    string    as_col_nm
// 	value    string    as_value
//$<Return>:  integer
//$<Description>: Set value to ids_inout, all in/out parameters are stored in it.
//$<Author>: (Appeon) long.zhang 08.12.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//ids_inout
Long ll_len
Int i

If Not ib_inout_used Then 
	is_err_text = 'No In/Out Parameters setting for current Request Id.'
	Return -1
End If

//Check colomn name
If ids_inout.Describe(as_col_nm+'.ColType') = '!' Then
	is_err_text = as_col_nm + ' is not valid.'
	Return -2
End If
	
//Modify coltype if needed.
ll_len = LenA(as_value)
If ll_len > INOUT_SIZE and ll_len <= 32767 Then //32767, Added by Appeon long.zhang 05.30.2016
	ids_inout.Modify(as_col_nm+'.ColType = ' + "'char("+ String(ll_len)+")'")
ElseIf ll_len > 32767 Then
	is_err_text = 'String value of ' + as_col_nm+ ' is too long. Please try to define a File type argument.'
	Return -4
End If

//SetItem
i = ids_inout.SetItem(1, as_col_nm, as_value)
If i = -1 Then
	is_err_text = 'SetItem for '+as_col_nm+ ' failed.'
	Return -3
End If
	
Return 1
end function

public function string of_get_response_value (string as_col_nm);//====================================================================
//$<Function>: of_get_response_value
//$<Arguments>:
// 	value    string    as_col_nm
//$<Return>:  string
//$<Description>: Get Value from returned istr_response
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Not header (default)
Return of_get_response_value(as_col_nm, False)
end function

public function string of_get_response_value (string as_nm, boolean ab_header);//====================================================================
//$<Function>: of_get_response_value
//$<Arguments>:
// 	value    string    as_col_nm
//	value	  boolean ab_header
//$<Return>:  string
//$<Description>: Get Value from returned istr_response
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_rtn
Int li_cnt, i

as_nm = Lower(as_nm)

If Not ab_header Then
	Choose case as_nm
		case 'status_code'
			ls_rtn = String(istr_response.status_code)
		case 'status'
			ls_rtn = istr_response.status
		case 'headers'
			ls_rtn = istr_response.headers
		case 'charset'
			ls_rtn = istr_response.charset
		case 'contenttype'
			ls_rtn = istr_response.contenttype
		case 'contentencoding'
			ls_rtn = istr_response.contentencoding
		case 'length'
			ls_rtn = String(istr_response.length)
		case 'filename'
			ls_rtn = String(istr_response.filename)
		case 'body'
			ls_rtn = String(istr_response.body)	
	End Choose
Else //header
	li_cnt = UpperBound(istr_response.hdr_name[])
	For i = 1 to li_cnt 
		If as_nm = Lower(istr_response.hdr_name[i]) Then
			ls_rtn = istr_response.hdr_value[i]
			Exit
		End If
	Next
End If

Return ls_rtn
end function

public subroutine of_set_testmode (boolean ab_test);//====================================================================
//$<Function>: of_set_testmode
//$<Arguments>:
// 	value    boolean    ab_test
//$<Return>:  None
//$<Description>: Set test mode, only used in of_request().
//$<Author>: (Appeon) long.zhang 08.07.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
ib_test_mode = ab_test
end subroutine

public function string of_get_errtext ();//====================================================================
//$<Function>: of_get_errtext
//$<Arguments>:
//$<Return>:  string
//$<Description>: Return last error.
//$<Author>: (Appeon) long.zhang 08.12.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return is_err_text
end function

public function integer of_get_inout_value (string as_col_nm, ref string as_value);//====================================================================
//$<Function>: of_get_inout_value
//$<Arguments>:
// 	value    string    as_col_nm
// 	value    string    as_value
//$<Return>:  integer
//$<Description>: Set value to ids_inout, all in/out parameters are stored in it.
//$<Author>: (Appeon) long.zhang 08.12.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//ids_inout
Long ll_len
Int i

If Not ib_inout_used Then 
	is_err_text = 'No In/Out Parameters setting for current Request Id.'
	Return -1
End If

//Check colomn name
If ids_inout.Describe(as_col_nm+'.ColType') = '!' Then
	is_err_text = as_col_nm + ' is not valid.'
	Return -2
End If

//SetItem, there is alway row 1 in ids_inout.
as_value = ids_inout.GetItemString(1, as_col_nm)
	
Return 1
end function

public function string of_get_request_body ();//====================================================================
//$<Function>: of_get_request_body
//$<Arguments>:
//$<Return>:  string
//$<Description>: get request_body after last request. For webapi setting - test tab
//$<Author>: (Appeon) long.zhang 05.27.2016 ( (v15.1 Verification API))
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Return is_request_body
end function

event constructor;//Create
ids_set_inout = Create datastore
ids_set_req= Create datastore
ids_set_req_hdr = Create datastore
ids_set_req_body = Create datastore
ids_set_resp = Create datastore
ids_set_resp_hdr = Create datastore
//ids_set_resp_body = Create datastore

//Dataobject
ids_set_inout.dataobject = 'd_webapi_inout'
ids_set_req.dataobject = 'd_webapi_req' //two tables together
ids_set_req_hdr.dataobject = 'd_webapi_req_hdr'
ids_set_req_body.dataobject = 'd_webapi_req_body'
ids_set_resp.dataobject = 'd_webapi_resp'
ids_set_resp_hdr.dataobject = 'd_webapi_resp_hdr'
//ids_set_resp_body.dataobject = 'd_webapi_resp_body'

//SetTransObject
ids_set_inout.SetTransObject(SQLCA);
ids_set_req.SetTransObject(SQLCA);
ids_set_req_hdr.SetTransObject(SQLCA);
ids_set_req_body.SetTransObject(SQLCA);
ids_set_resp.SetTransObject(SQLCA);
ids_set_resp_hdr.SetTransObject(SQLCA);
//ids_set_resp_body.SetTransObject(SQLCA);

end event

on n_cst_webapi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_webapi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy ids_set_inout
Destroy ids_set_req
Destroy ids_set_req_hdr
Destroy ids_set_req_body
Destroy ids_set_resp
Destroy ids_set_resp_hdr
//Destroy ids_set_resp_body

If IsValid(ids_inout) Then Destroy ids_inout
end event

