$PBExportHeader$n_cst_ama_profiles.sru
forward
global type n_cst_ama_profiles from nonvisualobject
end type
end forward

global type n_cst_ama_profiles from nonvisualobject autoinstantiate
end type

type variables
//Request Id in Support Utilities - Web API Setting.
Constant Int REQ_ID_GET_TOKEN = 3 
Constant Int REQ_ID_SEARCH = 5
Constant Int REQ_ID_PROFILE_LIST_FULL = 6
Constant Int REQ_ID_PROFILE_FULL_ID = 7

String is_err_text = ''
String is_last_token = '' //try to use one token muti time.
Long il_token_cpu_expire = 0 //try to use one token muti time. Use Cpu function.


end variables

forward prototypes
public function string of_get_errtext ()
public function integer of_get_token (ref string as_token)
public function String of_get_last_token ()
public function integer of_search (str_ama_searchrequest astr_searchrequest, ref str_ama_searchmatchitem str_searchmatchitems[])
private function string of_parse_token (readonly string as_body)
public function string of_create_request_search (str_ama_searchrequest str_request)
public function string of_xml_add_element (string as_element, string as_value)
public function string of_xml_get_element (string as_xml, string as_element)
public function integer of_parse_search_resp (string as_xml, ref str_ama_searchmatchitem astr_matchitems[])
public function integer of_xml_get_elements (string as_xml, string as_element, ref string as_elements[])
public function string of_create_request_listfull (long al_entityids[])
public function string of_xml_add_elements (string as_element, any aa_value[])
public function integer of_single_full (long al_entity_id, ref string as_path)
public function string of_get_xml_path (string as_file_name)
public function integer of_parse_list_full_resp (string as_xml_path, ref str_ama_listfull_resp astr_resp[])
public function integer of_list_full (long al_entityids[], ref str_ama_listfull_resp astr_resp[])
end prototypes

public function string of_get_errtext ();//====================================================================
//$<Function>: of_get_errtext
//$<Arguments>:
//$<Return>:  string
//$<Description>: Return last error text.
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return this.is_err_text
end function

public function integer of_get_token (ref string as_token); //====================================================================
//$<Function>: of_get_token
//$<Arguments>:ref as_token
//$<Return>:  Int 1:succeed/-x:failed
//$<Description>: This method will return an authorization token that should be passed within the header of each subsequent API call. This token expires after one hour. 
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_token
String ls_reponse_body
String ls_response_status
String ls_response_status_code
String ls_web_api_name
int li_rtn

//Find last usefull token
ls_token = of_get_last_token()
If Not(ls_token = '') Then
	as_token = ls_token
	Return 1
End If

n_cst_webapi lnv_webapi
ls_web_api_name = 'Web API (' +String(REQ_ID_GET_TOKEN) + ') '

//1.Ini
li_rtn = lnv_webapi.of_ini( REQ_ID_GET_TOKEN)
If li_rtn < 0 Then
	is_err_text = 'Initialize ' +ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -1
End If

//2.Set In Parameters if needs.
//lnv_webapi.of_set_inout_value(ls_arg, ls_value)

//3.Request
li_rtn = lnv_webapi.of_request()
If li_rtn < 0 Then
	is_err_text = 'Request ' + ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -2
End If

//4.Get Out parameters
//4.1 Response Status Code
li_rtn = lnv_webapi.of_get_inout_value('response_status_code', ls_response_status_code)
If li_rtn < 0 Then
	is_err_text = 'Get '+ ls_web_api_name + "Response Status Code" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -3
Else	 
	 Choose Case Long(ls_response_status_code)
		Case 200 //Successful 
			//Go ahead
		Case 401 //Unauthorized
			is_err_text = 'Unauthorized, please check your Client Id and Client Secret Settings in Web API (' +String(REQ_ID_GET_TOKEN) + ') '
			Return -4
		Case Else
			//4.2 Response Status
			li_rtn = lnv_webapi.of_get_inout_value('response_status', ls_response_status) 
			If li_rtn < 0 Then
				is_err_text = 'Get '+ ls_web_api_name + "Response Status" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
				Return -5
			Else
				is_err_text = 'Response Status: ' + ls_response_status_code +' - ' + ls_response_status
				Return -6
			End If
	End Choose			
End If

//4.3 Parse Response Body
li_rtn = lnv_webapi.of_get_inout_value('response_body', ls_reponse_body)
If li_rtn < 0 Then
	is_err_text = 'Get ' + "Response Body" +  'failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -7
Else
	//4.4 Get token from response body (Content-Type: application/json;charset=UTF-8)
	ls_token = of_parse_token(ls_reponse_body)
	If ls_token = '' Then
		is_err_text = 'Parse token failed.'
		Return -8
	End If	
End If

as_token = ls_token

Return  1


end function

public function String of_get_last_token ();//====================================================================
//$<Function>: of_get_last_token
//$<Arguments>:
//$<Return>:  string
//$<Description>: Use last token if not expired.
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If Cpu() < il_token_cpu_expire Then
	Return is_last_token
Else
	Return ''
End If
end function

public function integer of_search (str_ama_searchrequest astr_searchrequest, ref str_ama_searchmatchitem str_searchmatchitems[]); //====================================================================
//$<Function>: of_search
//$<Arguments>:
// 	value        str_ama_searchrequest      astr_searchrequest 
// 	reference    str_ama_searchmatchitem    str_searchmatchitems[]
//$<Return>:  Int  
//						<0:failed (call of_get_errtext for get last error text)
//						=0: did not find any matches
//						>0:Search result count.
//$<Description>: Search for AMA entities.
//						Note: It gets token automatically.
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_token
String ls_reponse_body
String ls_response_status
String ls_response_status_code
String ls_web_api_name
String ls_request_body
int li_rtn
n_cst_webapi lnv_webapi

ls_web_api_name = 'Web API (' +String(REQ_ID_SEARCH) + ') '

//0.Get Token
li_rtn = of_get_token(ls_token)
If li_rtn < 0 Then
	is_err_text = 'Get Token for ' + ls_web_api_name + " failed.~r~n" + this.of_get_errtext()
	Return -9
End If

//1.Ini
li_rtn = lnv_webapi.of_ini( REQ_ID_SEARCH)
If li_rtn < 0 Then
	is_err_text = 'Initialize ' +ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -1
End If

//2.Set In Parameters if needs.
//2.1 Token
li_rtn = lnv_webapi.of_set_inout_value('token', ls_token)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' token parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -21
End If

//2.2 Set Request Body,Create a xml string.
ls_request_body = of_create_request_search(astr_searchrequest)
If ls_request_body = '' Then
	is_err_text = 'Create ' + ls_web_api_name + ' Search Request File failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -22
End If

li_rtn = lnv_webapi.of_set_inout_value('request_body', ls_request_body)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' request_body parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -23
End If

//3.Request
li_rtn = lnv_webapi.of_request()
If li_rtn < 0 Then
	is_err_text = 'Request ' + ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -3
End If

//4.Get Out parameters
//4.1 Response Status Code
/*Status Codes:
200 - Successful
204 - No Content: Search request did not find any matches
400 - Bad Request
500 - Internal Server Error */

li_rtn = lnv_webapi.of_get_inout_value('response_status_code', ls_response_status_code)
If li_rtn < 0 Then
	is_err_text = 'Get '+ ls_web_api_name + "Response Status Code" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -41
Else	 
	 Choose Case Long(ls_response_status_code)
		Case 200 //Successful 
			//Go ahead
		Case 204
			is_err_text = 'No Content: Search request did not find any matches.'
			Return 0
		Case 400 //Bad Request
			is_err_text = ls_web_api_name + ' - Bad Request.'
			Return -42
		Case 500 
			is_err_text = ls_web_api_name + ' - Internal Server Error.'
			Return -43
		Case Else
			//4.2 Response Status
			li_rtn = lnv_webapi.of_get_inout_value('response_status', ls_response_status) 
			If li_rtn < 0 Then
				is_err_text = 'Get '+ ls_web_api_name + "Response Status" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
				Return -44
			Else
				is_err_text = ls_web_api_name + ' Response Status: ' + ls_response_status_code +' - ' + ls_response_status
				Return -45
			End If
	End Choose			
End If

//5 Parse Response Body
li_rtn = lnv_webapi.of_get_inout_value('response_body', ls_reponse_body) //Parse xml string
If li_rtn < 0 Then
	is_err_text = 'Get '+ls_web_api_name + " Response Body" +  'failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -5
Else
	//6 Get search results from response body (Content-Type: application/xml)
	li_rtn = of_parse_search_resp(ls_reponse_body, str_searchmatchitems[])
	If li_rtn < 0 Then
		is_err_text = 'Parse' +ls_web_api_name  + ' Response Body failed.~r~n' + lnv_webapi.of_get_errtext()
		Return -6
	Else
		Return li_rtn //Search result count. Added by Appeon long.zhang 06.01.2016
	End If	
End If

Return  1


end function

private function string of_parse_token (readonly string as_body);//====================================================================
//$<Function>: of_parse_token
//$<Arguments>:
// 	value    string    as_body： Response Body
//$<Return>:  string
//$<Description>: Parse token from Response Body (json), using n_cst_sailjson to parse json format.
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

/*as_body Sample
Content-Type: application/json;charset=UTF-8
{   "access_token":"aaaDQli1r1BBBaNmMLtgWgnmL0uXIccc08pmH7DD",   "token_type":"bearer",   "expires_in":3599,   "scope":""
}
*/

Long ll_start
Long ll_expires_in
String ls_rtn =''
String ls_json
Any la_rtn
n_cst_sailjson lnv_json

ll_start =  PosA(as_body, '{')
If ll_start >0 Then
	ls_json = MidA(as_body, ll_start)
	
	//Create Parse json class
	lnv_json =Create n_cst_sailjson
	lnv_json.parse( ls_json)
	
	la_rtn = lnv_json.getattribute("access_token")
	If String(la_rtn) <> "!ERROR!" Then
		//Got token
		ls_rtn = String(la_rtn)
		
		//Remember this cpu expire value. We can use this token before this value.
		la_rtn = lnv_json.getattribute("expires_in")
		If String(la_rtn) <> "!ERROR!" Then
			ll_expires_in = Long(la_rtn)
			If ll_expires_in > 0 Then
				il_token_cpu_expire = Cpu() + ll_expires_in *950 //Don't use 1000 because 'few seconds have gone' before now.
				is_last_token = ls_rtn 
			End If
		End If	
	End If	
	
	//Destroy Parse json class
	Destroy lnv_json
End If

//Old Method
//Long  ll_end, ll_length
//String ls_find
//String ls_expires_in
////Find Token
//ls_find ='"'+"access_token" + '"' + ':' + '"'
//ll_start = PosA(as_body, ls_find) + LenA(ls_find)
//If ll_start > 0 Then
//	ls_find = '",'
//	ll_end  = PosA(as_body, ls_find , ll_start) - 1
//	ll_length = ll_end - ll_start + 1
//	ls_rtn = MidA(as_body, ll_start, ll_length)
//End If
//
////Find expires_in , try to use this token for a long time.
//ls_find ="~"expires_in~":"
//ll_start = PosA(as_body, ls_find) + LenA(ls_find)
//If ll_start > 0 Then
//	ls_find = ','
//	ll_end  = PosA(as_body, ls_find , ll_start) - 1
//	ll_length = ll_end - ll_start + 1
//	
//	ls_expires_in = MidA(as_body, ll_start, ll_length)
//	
//	ll_expires_in = Long(ls_expires_in)
//	If Long(ls_expires_in) > 0 Then
//		//Remember this cpu expire value. We can use this token before this value.
//		il_token_cpu_expire = Cpu() + Long(ls_expires_in) *950 //Don't use 1000 because 'few seconds has gone' before now.
//		is_last_token = ls_rtn 
//	End If
//End If

Return ls_rtn
end function

public function string of_create_request_search (str_ama_searchrequest str_request);//====================================================================
//$<Function>: of_create_request_search
//$<Arguments>:
// 	value    str_ama_searchrequest    str_request
//$<Return>:  integer
//$<Description>:  Create a xml string for Search Request (<xs:complexType name="SearchRequest">).
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
 
 //complexType name="SearchRequest"
String ls_firstName, ls_lastName
String ls_stateOfPractice
String ls_npiNumber
String ls_dateOfBirth
String ls_rtn
//ecfmgNumber, meNumber,slnNumber,slnStateCd are not support now, please add it if needed.

ls_firstName = str_request.firstname
If Trim(ls_firstName) = '' Or IsNull(ls_firstName) Then
	is_err_text = "Generate Request XML failed: firstname is required."
	Return ''
End If

ls_lastName = str_request.lastname
If Trim(ls_lastName) = '' Or IsNull(ls_lastName) Then
	is_err_text = "Generate Request XML failed: lastname is required."
	Return ''
End If

ls_dateOfBirth	= String(Date(str_request.dateOfBirth), 'YYYY-MM-DD')
If Not IsDate(ls_dateOfBirth) Then
	is_err_text = "Generate Request XML failed: dateOfBirth is required."
	Return ''	
End If

ls_npiNumber = str_request.npinumber
ls_stateOfPractice = str_request.stateofpractice

ls_rtn = "<?xml version='1.0' encoding='ISO-8859-1' standalone='yes'?><searchRequest xmlns=~"http://eprofiles.myama.com/core/~">" &  
+ of_xml_add_element('firstName',ls_firstName) & 
+ of_xml_add_element('lastName',ls_lastName) & 
+ of_xml_add_element('dateOfBirth',ls_dateOfBirth) & 
+  of_xml_add_element('npinumber',ls_npiNumber) & 
+  of_xml_add_element('stateofpractice',ls_stateOfPractice) & 
+ "</searchRequest>"

Return ls_rtn
end function

public function string of_xml_add_element (string as_element, string as_value);//====================================================================
//$<Function>: of_xml_add_element
//$<Arguments>:
// 	value    string    as_element
// 	value    string    as_value
//$<Return>:  string
//$<Description>: add xml element and value
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If Trim(as_value) = '' or IsNull(as_value) Then
	Return "<" + as_element + "/>"
Else
	Return "<" + as_element + ">" + Trim(as_value) + "</"+ as_element + ">"
End If
end function

public function string of_xml_get_element (string as_xml, string as_element);//====================================================================
//$<Function>: of_xml_get_element
//$<Arguments>:
// 	value    as_string    as_element
//$<Return>:  string
//$<Description>: Get element from a xml string.
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//XML Example: <?xml version="1.0" encoding="UTF-8" standalone="yes"?><searchResponse xmlns="http://eprofiles.myama.com/core/"><matches><entityId>1</entityId><labelName>Brian E Meyer</labelName><city>Ventura</city><state>CA</state><zip>93003</zip><lastOrderedDate>2016-05-27</lastOrderedDate></matches></searchResponse>

String ls_rtn
String ls_start
String ls_end
Long ll_start = 0
Long ll_end = 0

ls_start = '<' + as_element + '>'
ls_end = '</' + as_element + '>'

ll_start = PosA(as_xml, ls_start ) 
If ll_start > 0 Then
	ll_start = ll_start + LenA(ls_start)
	ll_end = PosA(as_xml, ls_end, ll_start)
	If ll_end > 0 Then
		ll_end = ll_end - 1
		ls_rtn = MidA(as_xml, ll_start, ll_end + 1 - ll_start)
	Else
		ls_rtn = ''
	End If	
Else
	ls_rtn = ''
End If

Return ls_rtn
end function

public function integer of_parse_search_resp (string as_xml, ref str_ama_searchmatchitem astr_matchitems[]);//====================================================================
//$<Function>: of_parse_search_resp
//$<Arguments>:
// 	value        string                     as_xml
// 	reference    str_ama_searchmatchitem    astr_matchitems[]
//$<Return>:  >0: successful and return match item count /-1: failed
//$<Description>: Parse Search Response Body XML to str_ama_searchmatchitem.
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Sample: <?xml version="1.0" encoding="UTF-8" standalone="yes"?><searchResponse xmlns="http://eprofiles.myama.com/core/"><matches><entityId>1</entityId><labelName>Brian E Meyer</labelName><city>Ventura</city><state>CA</state><zip>93003</zip><lastOrderedDate>2016-05-27</lastOrderedDate></matches><matches><entityId>3</entityId><labelName>Brian E3 Meyer</labelName><city>aVentura</city><state>CA</state><zip>93003</zip><lastOrderedDate>2016-05-27</lastOrderedDate></matches></searchResponse>

String ls_matchs[]
String ls_tmp
Long ll_cnt
Long i

If LenA(as_xml) = 0 Then Return -1

//Seperate multi-rows
of_xml_get_elements(as_xml, 'matches', ls_matchs[])
ll_cnt = UpperBound(ls_matchs[])
If ll_cnt = 0 Then Return -2

//Get sub-element to str_ama_searchmatchitem
For i = 1 to ll_cnt
	astr_matchitems[i].entityId = Long(of_xml_get_element(ls_matchs[i], 'entityId'))
	astr_matchitems[i].labelName = of_xml_get_element(ls_matchs[i], 'labelName')
	astr_matchitems[i].prefix = of_xml_get_element(ls_matchs[i], 'prefix')
	astr_matchitems[i].firstName = of_xml_get_element(ls_matchs[i], 'firstName')
	astr_matchitems[i].middleName = of_xml_get_element(ls_matchs[i], 'middleName')
	astr_matchitems[i].lastName = of_xml_get_element(ls_matchs[i], 'lastName')
	astr_matchitems[i].suffix = of_xml_get_element(ls_matchs[i], 'suffix')
	astr_matchitems[i].city = of_xml_get_element(ls_matchs[i], 'city')
	astr_matchitems[i].state = of_xml_get_element(ls_matchs[i], 'state')
	astr_matchitems[i].zip = of_xml_get_element(ls_matchs[i], 'zip')
	
	//lastOrderedDate
	ls_tmp = of_xml_get_element(ls_matchs[i], 'lastOrderedDate')
	If ls_tmp <> '' Then astr_matchitems[i].lastOrderedDate = DateTime(Date(ls_tmp))
	
	astr_matchitems[i].ecfmgNumber = of_xml_get_element(ls_matchs[i], 'ecfmgNumber')
	astr_matchitems[i].npiNumber = of_xml_get_element(ls_matchs[i], 'npiNumber')
	astr_matchitems[i].slnNumber = of_xml_get_element(ls_matchs[i], 'slnNumber')
	astr_matchitems[i].slnStateCd = of_xml_get_element(ls_matchs[i], 'slnStateCd')
	astr_matchitems[i].meNumber = of_xml_get_element(ls_matchs[i], 'meNumber')
	astr_matchitems[i].nccpaNumber = of_xml_get_element(ls_matchs[i], 'nccpaNumber')
	astr_matchitems[i].dnrInd = of_xml_get_element(ls_matchs[i], 'dnrInd')
Next

Return ll_cnt //return match item count, modified by Appeon long.zhang 06.01.2016
end function

public function integer of_xml_get_elements (string as_xml, string as_element, ref string as_elements[]);//====================================================================
//$<Function>: of_xml_get_elements
//$<Arguments>:
// 	value    string    as_xml
// 	value    string    as_element  //element name
//	reference	string	as_elements[] //each row of this element.
//$<Return>:  integer
//$<Description>: Get element from a xml string (one element has many rows).
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//------------------------------------------------  --------------------
//$<Modify History>:
//====================================================================

//XML Example: <?xml version="1.0" encoding="UTF-8" standalone="yes"?><searchResponse xmlns="http://eprofiles.myama.com/core/"><matches><entityId>1</entityId><labelName>Brian E Meyer</labelName><city>Ventura</city><state>CA</state><zip>93003</zip><lastOrderedDate>2016-05-27</lastOrderedDate></matches></searchResponse>

String ls_rtn[]
String ls_start
String ls_end
Long ll_start = 0
Long ll_end = 0
Long ll_start_next = 1
Long ll_len

ll_len = LenA(as_xml)
ls_start = '<' + as_element + '>'
ls_end = '</' + as_element + '>'

ll_start = PosA(as_xml, ls_start, ll_start_next ) 
Do While (ll_start > 0) 
	ll_start = ll_start + LenA(ls_start)
	ll_end = PosA(as_xml, ls_end, ll_start)
	If ll_end > 0 Then
		ll_end = ll_end - 1
		ls_rtn[UpperBound(ls_rtn[]) + 1] = MidA(as_xml, ll_start, ll_end + 1 - ll_start)
	Else
		Exit
	End If	
	
	//Loop again
	If ll_len >  ll_end + LenA(ls_end) Then
		ll_start_next = ll_end + LenA(ls_end)
		ll_start = PosA(as_xml, ls_start, ll_start_next ) 
	Else
		Exit
	End If
Loop

as_elements[] =  ls_rtn[]

Return 1
end function

public function string of_create_request_listfull (long al_entityids[]);//====================================================================
//$<Function>: of_create_request_listfull
//$<Arguments>:
// 	value    Long    al_entityIds[]
//$<Return>:  integer
//$<Description>:  Create a xml string for profile/list/full Request (<xs:complexType name="bulkFullProfileRequest">).
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
 
String ls_rtn
String ls_tmp
Long li_cnt, i

li_cnt = UpperBound(al_entityIds[])
If li_cnt < 1 Then Return ''

//add ids
ls_tmp = of_xml_add_elements('entityIds', al_entityids[])
If ls_tmp = '' Then Return ''

ls_rtn = "<?xml version='1.0' encoding='UTF-8' standalone='yes'?><bulkFullProfileRequest xmlns=~"http://eprofiles.myama.com/core/~">"  & 
+ ls_tmp &
+ "</bulkFullProfileRequest>"

Return ls_rtn
end function

public function string of_xml_add_elements (string as_element, any aa_value[]);//====================================================================
//$<Function>: of_xml_add_elements
//$<Arguments>:
// 	value    string    as_element
// 	value    any    aa_value[][]
//$<Return>:  string 
//$<Description>: add xml element and value
//$<Author>: (Appeon) long.zhang 05.30.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long i
Long ll_cnt
String ls_rtn
String ls_value

ll_cnt = UpperBound(aa_value[])
If ll_cnt = 0 Then Return ''

For i = 1 to ll_cnt
	//Convert to string
	ls_value =String(aa_value[i])
	If Trim(ls_value) = '' or IsNull(ls_value) Then
		ls_rtn += "<" + as_element + "/>"
	Else
		ls_rtn += "<" + as_element + ">" + Trim(ls_value) + "</"+ as_element + ">"
	End If
Next

Return ls_rtn
end function

public function integer of_single_full (long al_entity_id, ref string as_path);//====================================================================
//$<Function>: of_single_full
//$<Arguments>:
// 	value        long      al_entity_id
// 	reference    string    as_path :return the xml path.
//$<Return>:  Int  
//						<0:failed (call of_get_errtext for get last error text)
//						= 1:successful.
//$<Description>: Get a [single] AMA entitiy profile xml file.
//						Note: It gets token automatically.
//$<Author>: (Appeon) long.zhang 05.31.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================


String ls_token
String ls_reponse_body
String ls_response_status
String ls_response_status_code
String ls_web_api_name
String ls_request_body
String ls_path
int li_rtn
n_cst_webapi lnv_webapi

ls_web_api_name = 'Web API (' +String(REQ_ID_PROFILE_FULL_ID) + ') '

If Not( al_entity_id >0) Then
	is_err_text = 'Entity Id for ' + ls_web_api_name + " is not valid."
	Return -8
End If

//0.Get Token
li_rtn = of_get_token(ls_token)
If li_rtn < 0 Then
	is_err_text = 'Get Token for ' + ls_web_api_name + " failed.~r~n" + this.of_get_errtext()
	Return -9
End If

//1.Ini
li_rtn = lnv_webapi.of_ini( REQ_ID_PROFILE_FULL_ID)
If li_rtn < 0 Then
	is_err_text = 'Initialize ' +ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -1
End If

//2.Set In Parameters if needs.
//2.1 Token
li_rtn = lnv_webapi.of_set_inout_value('token', ls_token)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' token parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -21
End If

//2.2 AMA ID
li_rtn = lnv_webapi.of_set_inout_value('ama_id', String(al_entity_id))
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' ama_id parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -22
End If

//2.3 Set Response xml file path.
ls_path = of_get_xml_path('fullProfile_' + string(al_entity_id) + '.xml')
li_rtn = lnv_webapi.of_set_inout_value('response_file', String(ls_path))
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' response_file parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -23
End If

//3.Do Request
li_rtn = lnv_webapi.of_request()
If li_rtn < 0 Then
	is_err_text = 'Request ' + ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -3
End If

//4.Get Out parameters
//4.1 Response Status Code
/*200 - Successful
202 - A Full Profile was found for the provided entity ID but cannot be released
404 - A Full Profile was not found for the provided entity ID.
500 - Internal Server Error*/

li_rtn = lnv_webapi.of_get_inout_value('response_status_code', ls_response_status_code)
If li_rtn < 0 Then
	is_err_text = 'Get '+ ls_web_api_name + "Response Status Code" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -41
Else	 
	 Choose Case Long(ls_response_status_code)
		Case 200 //Successful 
			//Go ahead
		Case 202
			is_err_text = ls_web_api_name+ ' A Full Profile was found for the provided entity ID but cannot be released.'
			Return -42
		Case 404 
			is_err_text = ls_web_api_name + ' A Full Profile was not found for the provided entity ID.'
			Return -43
		Case 500 
			is_err_text = ls_web_api_name + ' - Internal Server Error.'
			Return -44
		Case Else
			//4.2 Response Status
			li_rtn = lnv_webapi.of_get_inout_value('response_status', ls_response_status) 
			If li_rtn < 0 Then
				is_err_text = 'Get '+ ls_web_api_name + "Response Status" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
				Return -45
			Else
				is_err_text = ls_web_api_name + ' Response Status: ' + ls_response_status_code +' - ' + ls_response_status
				Return -46
			End If
	End Choose			
End If

//Return xml path
as_path = ls_path

Return  1


end function

public function string of_get_xml_path (string as_file_name);//====================================================================
//$<Function>: of_get_xml_path
//$<Arguments>:
// 	value    string    as_file_name
//$<Return>:  string Empty String:failed/Else:successful
//$<Description>: get full path of the xml file in AMA folder
//$<Author>: (Appeon) long.zhang 05.31.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_xml_path
String ls_file_name
Long res

ls_xml_path = gs_temp_path + "AMA"
if DirectoryExists ( ls_xml_path ) = false then
	res = CreateDirectory ( ls_xml_path )
	if res = -1 then
		is_err_text = "Unable to create file directory:" + ls_xml_path
		return ''
	end if
end if

ls_file_name = ls_xml_path +  "\" + as_file_name
If FileExists(ls_file_name) Then 
	If Not FileDelete(ls_file_name) Then
		is_err_text = "Unable to Delete:" + ls_file_name
		Return ''
	End If
End If		

Return ls_file_name
end function

public function integer of_parse_list_full_resp (string as_xml_path, ref str_ama_listfull_resp astr_resp[]);//====================================================================
//$<Function>: of_parse_list_full_resp
//$<Arguments>:
// 	value        string                   as_xml_path
// 	reference    str_ama_listfull_resp    astr_resp
//$<Return>:  integer -x:failed/1 successful
//$<Description>: parse (application/xml) bulkFullProfileResponse file to single xml files. 
//$<Author>: (Appeon) long.zhang 05.31.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//1.Read file to string
String ls_read
String ls_profiles[]
String ls_entity_id
String ls_status_code
String ls_status
String ls_xml_path
Long ll_read
Long ll_length
Long ll_cnt
Long i
Long li_rtn
Long ll_write
Long ll_start


//Read the file
ll_read = FileOpen (as_xml_path, TextMode!)
ll_length = FileReadEx ( ll_read, ls_read) 
FileClose(ll_read)
If ll_length < 1  then 
	is_err_text = 'FileReadEx failed.'
	Return -1
End If

//2.parse string to many parts.
of_xml_get_elements(ls_read, 'profiles', ls_profiles[])

ll_cnt = UpperBound(ls_profiles[])
If ll_cnt< 1 Then
	is_err_text = 'Parse xml profiles failed.'
	Return -2
End If

//3.create xml files.
For i = 1 to ll_cnt
	ls_entity_id = of_xml_get_element(ls_profiles[i], 'entityId')
	ls_status_code = of_xml_get_element(ls_profiles[i], 'status')
	
	/*200 - Successful
	202 - A Full Profile was found for the provided entity ID but cannot be released
	400 - Bad Request
	404 - A Full Profile was not found for the provided entity ID.
	500 - Internal Server Error */
	Choose Case ls_status_code
		Case '200' //Successful
			ls_status = 'Successful'
		Case '202'
			ls_status = 'A Full Profile was found for the provided entity ID but cannot be released'
		Case '404'
			ls_status = 'A Full Profile was not found for the provided entity ID.'
		Case '500'		
			ls_status = 'Internal Server Error.'
	End Choose
	
	astr_resp[i].entityid = Long(ls_entity_id)
	astr_resp[i].status_code = ls_status_code
	astr_resp[i].status = ls_status
	
	//Create xml file
	If ls_status_code = '200' Then
		ll_start = PosA( ls_profiles[i], '<profile>')
		If ll_start > 0 Then 
			//Only need profile
			ls_profiles[i] = MidA(ls_profiles[i], ll_start)
			
			ls_xml_path = of_get_xml_path("list_full_" + ls_entity_id + '.xml' )
			If ls_xml_path = '' Then
				is_err_text = 'Get xml path failed: ' + "list_full_" + ls_entity_id + '.xml'
				Return -3
			End If
			
			//Write file
			ll_write = FileOpen (ls_xml_path, TextMode!, Write!)
			ll_length = FileWriteEx ( ll_write, ls_profiles[i]) 
			FileClose(ll_read)
			If ll_length < 1  then 
				is_err_text = 'FileWriteEx failed.'
				Return -4
			Else
				astr_resp[i].xml_path = ls_xml_path
			End If
		End If
	End If
Next

Return 1
end function

public function integer of_list_full (long al_entityids[], ref str_ama_listfull_resp astr_resp[]); //====================================================================
//$<Function>: of_list_full
//$<Arguments>:
// 	value        string    as_entityIds[]
// 	reference    str_ama_listfull_resp    astr_resp
//$<Return>:  integer
//						<0:failed (call of_get_errtext for get last error text)
//						=1: Done.
//$<Description>: This method will Retrieves a list of full physician profiles into many xml files. 
//						Note: It gets token automatically.
//$<Author>: (Appeon) long.zhang 05.26.2016 (AMA Profiles API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_token
String ls_reponse_body
String ls_response_status
String ls_response_status_code
String ls_web_api_name
String ls_request_body
String ls_xml_path
int li_rtn
n_cst_webapi lnv_webapi

ls_web_api_name = 'Web API (' +String(REQ_ID_PROFILE_LIST_FULL) + ') '

//0.Get Token
li_rtn = of_get_token(ls_token)
If li_rtn < 0 Then
	is_err_text = 'Get Token for ' + ls_web_api_name + " failed.~r~n" + this.of_get_errtext()
	Return -9
End If

//1.Ini
li_rtn = lnv_webapi.of_ini( REQ_ID_PROFILE_LIST_FULL)
If li_rtn < 0 Then
	is_err_text = 'Initialize ' +ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -1
End If

//2.Set In Parameters.
//2.1 Token
li_rtn = lnv_webapi.of_set_inout_value('token', ls_token)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' token parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -21
End If

//2.2 Set Reponse file path, it will save response xml to this path.
ls_xml_path = of_get_xml_path("list_full_response.xml")
li_rtn = lnv_webapi.of_set_inout_value('response_file', ls_xml_path)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' response_file parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -22
End If

//2.3 Set Request Body,Create a xml string.
ls_request_body = of_create_request_listfull(al_entityids[])
If ls_request_body = '' Then
	is_err_text = 'Create ' + ls_web_api_name + ' Request Body failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -23
End If

li_rtn = lnv_webapi.of_set_inout_value('request_body', ls_request_body)
If li_rtn < 0 Then
	is_err_text = 'Set ' + ls_web_api_name + ' request_body parameter failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -24
End If

//3.Do Request
li_rtn = lnv_webapi.of_request()
If li_rtn < 0 Then
	is_err_text = 'Request ' + ls_web_api_name + ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -3
End If

//4.Get Out parameters
//4.1 Response Status Code
/*Status Codes:
200 - Successful
else - Failed*/

li_rtn = lnv_webapi.of_get_inout_value('response_status_code', ls_response_status_code)
If li_rtn < 0 Then
	is_err_text = 'Get '+ ls_web_api_name + "Response Status Code" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -41
Else	 
	 Choose Case Long(ls_response_status_code)
		Case 200 //Successful 
			//Go ahead
		Case Else
			//4.2 Response Status
			li_rtn = lnv_webapi.of_get_inout_value('response_status', ls_response_status) 
			If li_rtn < 0 Then
				is_err_text = 'Get '+ ls_web_api_name + "Response Status" +  ' failed.~r~n' + lnv_webapi.of_get_errtext()
				Return -44
			Else
				is_err_text = ls_web_api_name + ' Response Status: ' + ls_response_status_code +' - ' + ls_response_status
				Return -45
			End If
	End Choose			
End If

//5 Parse Response Body (File)
li_rtn = of_parse_list_full_resp(ls_xml_path, astr_resp[])
If li_rtn < 0 Then
	is_err_text = 'Parse ' + ls_web_api_name + ' Response File failed.~r~n' + lnv_webapi.of_get_errtext()
	Return -5
End If


Return  1


end function

on n_cst_ama_profiles.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_ama_profiles.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

