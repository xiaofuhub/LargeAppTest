$PBExportHeader$w_webapi_setting.srw
forward
global type w_webapi_setting from w_main
end type
type cb_import from commandbutton within w_webapi_setting
end type
type cb_export from commandbutton within w_webapi_setting
end type
type cb_1 from commandbutton within w_webapi_setting
end type
type cb_delete from commandbutton within w_webapi_setting
end type
type cb_add from commandbutton within w_webapi_setting
end type
type cb_close from commandbutton within w_webapi_setting
end type
type cb_save from commandbutton within w_webapi_setting
end type
type tab_1 from tab within w_webapi_setting
end type
type tabpage_main from userobject within tab_1
end type
type st_4 from statictext within tabpage_main
end type
type st_3 from statictext within tabpage_main
end type
type st_2 from statictext within tabpage_main
end type
type dw_tv from u_dw within tabpage_main
end type
type dw_main from u_dw within tabpage_main
end type
type dw_req_main from u_dw within tabpage_main
end type
type dw_copy from datawindow within tabpage_main
end type
type st_1 from statictext within tabpage_main
end type
type tabpage_main from userobject within tab_1
st_4 st_4
st_3 st_3
st_2 st_2
dw_tv dw_tv
dw_main dw_main
dw_req_main dw_req_main
dw_copy dw_copy
st_1 st_1
end type
type tabpage_req from userobject within tab_1
end type
type dw_inout from u_dw within tabpage_req
end type
type dw_req_bd from u_dw within tabpage_req
end type
type dw_req_hdr from u_dw within tabpage_req
end type
type tabpage_req from userobject within tab_1
dw_inout dw_inout
dw_req_bd dw_req_bd
dw_req_hdr dw_req_hdr
end type
type tabpage_resp from userobject within tab_1
end type
type dw_resp_body from u_dw within tabpage_resp
end type
type dw_resp_hdr from u_dw within tabpage_resp
end type
type dw_resp from u_dw within tabpage_resp
end type
type tabpage_resp from userobject within tab_1
dw_resp_body dw_resp_body
dw_resp_hdr dw_resp_hdr
dw_resp dw_resp
end type
type tabpage_test from userobject within tab_1
end type
type cbx_show from checkbox within tabpage_test
end type
type cb_3 from commandbutton within tabpage_test
end type
type cb_test_3 from commandbutton within tabpage_test
end type
type cb_test_2 from commandbutton within tabpage_test
end type
type dw_test_out from u_dw within tabpage_test
end type
type dw_test_in from u_dw within tabpage_test
end type
type cb_test_1 from commandbutton within tabpage_test
end type
type cb_2 from commandbutton within tabpage_test
end type
type tabpage_test from userobject within tab_1
cbx_show cbx_show
cb_3 cb_3
cb_test_3 cb_test_3
cb_test_2 cb_test_2
dw_test_out dw_test_out
dw_test_in dw_test_in
cb_test_1 cb_test_1
cb_2 cb_2
end type
type tab_1 from tab within w_webapi_setting
tabpage_main tabpage_main
tabpage_req tabpage_req
tabpage_resp tabpage_resp
tabpage_test tabpage_test
end type
end forward

global type w_webapi_setting from w_main
integer x = 9
integer y = 4
integer width = 4206
integer height = 2228
string title = "Web API Setup"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
cb_import cb_import
cb_export cb_export
cb_1 cb_1
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
cb_save cb_save
tab_1 tab_1
end type
global w_webapi_setting w_webapi_setting

type prototypes

end prototypes

type variables
u_dw idw_tv
u_dw idw_main
u_dw idw_req_main
u_dw	idw_inout
u_dw idw_req_hdr
u_dw	idw_req_bd
u_dw idw_resp
u_dw idw_resp_hdr


Long il_webapi_id //current webapi_id
Long il_request_id //current request_id

datastore ids_in
datastore ids_resp_dddw

String is_columns[]
String is_drag_parm

n_cst_webapi inv_webapi //only used in test tab
end variables

forward prototypes
public function integer of_verify (ref datawindow adw, integer row, string col)
public function integer of_create_in_ds ()
public function integer of_check_inout_names ()
public subroutine of_reset_resp_dddw ()
public subroutine of_add_default_parms ()
public function integer of_verify (ref datawindow adw, integer row, string col, boolean ab_edit)
end prototypes

public function integer of_verify (ref datawindow adw, integer row, string col);//====================================================================
//$<Function>: of_verify
//$<Arguments>:
// 	reference    string     as_expression
// 	value        integer    ai_inout
//$<Return>:  integer -1:failed/ 1:succeed
//$<Description>: Verify the PB expression.
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Only check expression
Return of_verify(adw, row, col, False)
end function

public function integer of_create_in_ds ();//====================================================================
//$<Function>: of_create_inout_ds
//$<Arguments>:
//$<Return>:  integer 1:succeed/ -1:failed.
//$<Description>: Create ids_in for of_verify() to check expression.
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long li_cnt, i, j
String ls_sql, ls_col, ls_dwsyntax_str, ls_error
String  ls_null[]

If IsValid(ids_in) Then Destroy ids_in
is_columns[] = ls_null[]

//Create syntax by in/out  parameters  
li_cnt = idw_inout.RowCount()
If li_cnt > 0 Then
	ls_sql = 'SELECT '
	For i = 1 to li_cnt
		ls_col = idw_inout.GetItemString(i, 'name')
		 If idw_inout.GetItemNumber(i, 'inout') <> 1 Then Continue
		 j++
		 is_columns[j] = ls_col

		ls_sql += ' Space(' + String(1) + ') as ' + ls_col +','
	Next
	
	//delete the last ','
	If j > 0 Then ls_sql = LeftA(ls_sql,LenA(ls_sql) - 1)
	
	ls_sql += ' FROM ids'
End If

If j = 0 Then ls_sql = "select ' ' as tmpstring from ids" //No In parameters setting, Create a empty datastore
	
ids_in = Create datastore
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, '', ls_error)
IF Len(ls_error) > 0 THEN
	Messagebox('of_create_inout_ds',"SyntaxFromSQL caused these errors: " + ls_error + "~r~r" + ls_sql)
	RETURN -1
END IF

i = ids_in.Create( ls_dwsyntax_str, ls_error)
if i < 1 then
	Messagebox('of_create_inout_ds',ls_error)
	RETURN -1
end if

Return 1




end function

public function integer of_check_inout_names ();//====================================================================
//$<Function>: of_check_inout_names
//$<Arguments>:
//$<Return>:  integer 1:succeed/ -1:failed.
//$<Description>: Check in/out names.
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long li_cnt, i, j
String ls_sql, ls_col, ls_dwsyntax_str, ls_error
String  ls_null[]
datastore lds_test

//Create syntax by in/out  parameters  
li_cnt = idw_inout.RowCount()
If li_cnt > 0 Then
	ls_sql = 'SELECT '
	For i = 1 to li_cnt
		ls_col = idw_inout.GetItemString(i, 'name')
		 j++
		 is_columns[j] = ls_col
		If i = li_cnt Then
			ls_sql += ' Space(' +String(1) + ') as ' + ls_col 
		Else
			ls_sql += ' Space(' + String(1) + ') as ' + ls_col +','
		End If
	Next
	ls_sql += ' FROM ids'
Else //No Setting
	Return 1
End If
	
lds_test = Create datastore
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, '', ls_error)
IF Len(ls_error) > 0 THEN
	RETURN -1
END IF

i = lds_test.Create( ls_dwsyntax_str, ls_error)
if i < 1 then
	RETURN -1
end if

destroy lds_test

Return 1




end function

public subroutine of_reset_resp_dddw ();//====================================================================
//$<Function>: of_reset_resp_dddw
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Set dddw of  idw_resp and idw_resp_hdr
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_cnt, i, li_type, j
String ls_name

ids_resp_dddw.Reset()
ids_resp_dddw.Insertrow(0)

li_cnt = idw_inout.rowcount()
For i = 1 to li_cnt
	If idw_inout.GetItemNumber(i,'inout') = 2 Then
		li_type = idw_inout.GetItemNumber(i,'type')
		ls_name = idw_inout.GetItemString(i,'name')
		
		j = ids_resp_dddw.Insertrow(0)
		ids_resp_dddw.SetItem(j, 'type', li_type)
		ids_resp_dddw.SetItem(j, 'name', ls_name)
	End If
Next


end subroutine

public subroutine of_add_default_parms ();//====================================================================
//$<Function>: of_add_default_parms
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Set default parms for idw_inout
//$<Author>: (Appeon) long.zhang 08.13.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_parms[]
Int li_inout[]
Int i , li_cnt, j

//Set default parameters
ls_parms[] = {'response_status_code', 'response_status', 'response_headers', 'response_body'}
li_inout[] = { 2,2,2,2}
li_cnt = Upperbound(ls_parms[])
For i = 1 to li_cnt
	j = idw_inout.event pfc_addrow()
	idw_inout.SetItem(j , 'name', ls_parms[i])
	idw_inout.SetItem(j , 'inout', li_inout[i])
Next

end subroutine

public function integer of_verify (ref datawindow adw, integer row, string col, boolean ab_edit);//====================================================================
//$<Function>: of_verify
//$<Arguments>:
// 	reference    string     as_expression
// 	value        integer    ai_inout
// 	value        integer    ab_edit  True:Open w_webapi_expression/False: only check expression.(Default)
//$<Return>:  integer -1:failed/ 1:succeed
//$<Description>: Verify the PB expression.
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

str_webapi_exp lstr_exp
Int i,li_cnt, li_inout
String ls_return
String ls_expression

adw.accepttext()
ls_expression = adw.GetItemString(row, col)

lstr_exp.ds_source = ids_in
lstr_exp.expression = ls_expression
lstr_exp.is_columns[] = is_columns[]

If Not ab_edit Then //Called by pfc_validation() event.
	ls_return = ids_in.Describe("evaluate('"+ls_expression+"',1)")
	If ls_return = '!' Then
		Return -1
	End If
Else //Open window
	OpenWithParm(w_webapi_expression, lstr_exp)
	
	ls_return = Message.stringparm
	If ls_return <> 'Cancel' Then
		ls_expression = ls_return
		adw.SetItem(row,col,ls_expression)
	End If
End If

Return 1
end function

on w_webapi_setting.create
int iCurrent
call super::create
this.cb_import=create cb_import
this.cb_export=create cb_export
this.cb_1=create cb_1
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.cb_save=create cb_save
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_import
this.Control[iCurrent+2]=this.cb_export
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.tab_1
end on

on w_webapi_setting.destroy
call super::destroy
destroy(this.cb_import)
destroy(this.cb_export)
destroy(this.cb_1)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.tab_1)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
datawindowchild ldw

//Create repsonse dddw
ids_resp_dddw = create datastore
ids_resp_dddw.dataobject = 'd_dddw_webapi_resp'
ids_resp_dddw.settransobject(sqlca);

//Create ids_in
of_create_in_ds()

idw_resp.GetChild('status_code',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('Status',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('headers',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('charset',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('ContentType',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('ContentEncoding',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('length',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('length',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('filename',ldw)
ids_resp_dddw.sharedata( ldw)
idw_resp.GetChild('body',ldw)
ids_resp_dddw.sharedata( ldw)

idw_resp_hdr.GetChild('value',ldw)
ids_resp_dddw.sharedata( ldw)

//Retrieve All Settings
idw_tv.of_Retrieve()
end event

event close;call super::close;//====================================================================
//$<Event>: close
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Destroy ids_resp_dddw

If IsValid(ids_in) Then Destroy ids_in
end event

type cb_import from commandbutton within w_webapi_setting
integer x = 2839
integer y = 8
integer width = 334
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Import Files"
end type

event clicked;n_ds lds_main
n_ds lds_req
n_ds lds_inout
n_ds lds_req_hdr
n_ds lds_req_body
n_ds lds_resp
n_ds lds_resp_hdr
n_ds lds_resp_body

open(w_api_setup_import)










end event

type cb_export from commandbutton within w_webapi_setting
integer x = 3177
integer y = 8
integer width = 329
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export Files"
end type

event clicked;open(w_api_setup_export)
end event

type cb_1 from commandbutton within w_webapi_setting
integer x = 3515
integer y = 8
integer width = 311
integer height = 92
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_mes
String ls_tip_1, ls_tip_2, ls_tip_3

ls_tip_1 = 'Web API Tab.~r~n' +&
'1) Add a record for Server Infomation.~r~n' +&
'2) Click API Request and add a record for it.~r~n'+&
'	Request URI and Response File Name are PB expressions.~r~n'+&
'	Response File Name holds the filename of the file that will be stored after Response.~r~n'

ls_tip_2 = 'Parameter/Request Tab.~r~n' +&
'1) Define parameters in In/Out Parameters. They can be used to facilitate the request and response.~r~n' +&
'	API Request-Request URI, Request Header-Value and Request Body-Value/Part can use In Parameters.~r~n' +&
'	API Response and Response Header-Value can use Out Parameters.~r~n'+&
'	All Parameters can only hold string value. IF you want to send a file, the Parameter can hold a file name for you.~r~n'+&
'2) Add records in Request Header if needed. Note that the Value column are PB expressions.~r~n'+&
'3) Add records in Request Body if needed. Note that the Value/Part column are PB expressions.~r~n'+&
"Type 'Variable' will produce request body like 'Username=joe&Password=joe'~r~n"+&
"Type 'String' will produce  request body like: ~r~n" +&
"Content-Disposition: form-data; name=~"Name~"~r~n" +&
"Test String~r~n" +&
"Type 'File' will produce  request body like: ~r~n" +&
"Content-Disposition: form-data; name=~"TheFile~"; filename=~"log.txt~"~r~n" +&
"Content-Type: application/octet-stream~r~n" +&
"DHCP Server Started~r~n~r~n" +&
"Note: Set 'Request Body - Name' to 'REQUEST BODY' to modify Request Body directly ( 'String' or  'File' type). "


ls_tip_3 = 'Response Tab.~r~n' +&
'1) Select Out Parameters in API Response to receive response values.~r~n' +&
'2) Add records in Response Header to receive specified response header values.~r~n'

Choose case tab_1.selectedtab
	case 1
		ls_mes = ls_tip_1
	case 2
		ls_mes = ls_tip_2
	case 3
		ls_mes = ls_tip_3
	case 4
		ls_mes = 'Please follow test steps.'
End choose

messagebox("Web API Setup help",ls_mes)
end event

type cb_delete from commandbutton within w_webapi_setting
integer x = 2514
integer y = 8
integer width = 311
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

parent.dynamic event pfc_messagerouter ('pfc_deleterow')
end event

type cb_add from commandbutton within w_webapi_setting
integer x = 2203
integer y = 8
integer width = 311
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

parent.dynamic event pfc_messagerouter ('pfc_addrow')

end event

type cb_close from commandbutton within w_webapi_setting
integer x = 3849
integer y = 8
integer width = 311
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

close(parent)
end event

type cb_save from commandbutton within w_webapi_setting
integer x = 1883
integer y = 8
integer width = 311
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return Parent.Event pfc_Save()
end event

type tab_1 from tab within w_webapi_setting
event create ( )
event destroy ( )
integer x = 41
integer y = 124
integer width = 4119
integer height = 2016
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
alignment alignment = center!
integer selectedtab = 1
tabpage_main tabpage_main
tabpage_req tabpage_req
tabpage_resp tabpage_resp
tabpage_test tabpage_test
end type

on tab_1.create
this.tabpage_main=create tabpage_main
this.tabpage_req=create tabpage_req
this.tabpage_resp=create tabpage_resp
this.tabpage_test=create tabpage_test
this.Control[]={this.tabpage_main,&
this.tabpage_req,&
this.tabpage_resp,&
this.tabpage_test}
end on

on tab_1.destroy
destroy(this.tabpage_main)
destroy(this.tabpage_req)
destroy(this.tabpage_resp)
destroy(this.tabpage_test)
end on

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If newindex = 1 Then //main
	idw_req_main.SetFocus()
ElseIf newindex = 2 Then //request
	//Auto add Parameters
	If idw_inout.rowcount() = 0 Then of_add_default_parms() 
	
	idw_inout.SetFocus()
ElseIf newindex = 3 Then //response
	idw_resp.SetFocus()
	
	//Add new response record, by Appeon long.zhang 10.24.2015 (BugS102101)
	If idw_resp.RowCount() = 0 Then	idw_resp.event pfc_addrow() 
ElseIf newindex = 4 Then //test
	//
End If

If newindex = 4 Then //test
	cb_save.enabled = false
	cb_add.enabled = false
	cb_delete.enabled = false
Else
	cb_save.enabled = True
	cb_add.enabled = True
	cb_delete.enabled = True
End If
end event

event selectionchanging;//====================================================================
//$<Event>: selectionchanging
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: Must save tabpage_main first.
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_rc
Boolean lb_need_save = False

If oldindex = 1 Then
	idw_main.AcceptText()
	if idw_main.GetItemStatus(1, 0, Primary!) <> NotModified!  then
		MessageBox("Prompt", "Please save Server Infomation first!")
		Return 1
	end if
	
	idw_req_main.AcceptText()
	if idw_req_main.GetItemStatus(1, 0, Primary!) <> NotModified! or il_request_id = 0 then
		MessageBox("Prompt", "Please save API Request first!")
		Return 1
	end if

//	if tab_1.tabpage_main.Event ue_IsDataChanged() then
//		lb_need_save = True
//	End If
ElseIf oldindex = 2 Then
	if tab_1.tabpage_req.Event ue_IsDataChanged() then
		lb_need_save = True
	End If	
ElseIf oldindex = 3 Then
	if tab_1.tabpage_resp.Event ue_IsDataChanged() then
		lb_need_save = True
	End If	
End If

If lb_need_save Then
	li_rc = cb_save.Event Clicked()
	If li_rc < 0 Then Return 1 //prevent it from changing
End If

Return 0
end event

type tabpage_main from userobject within tab_1
event create ( )
event destroy ( )
event type boolean ue_isdatachanged ( )
integer x = 18
integer y = 100
integer width = 4082
integer height = 1900
long backcolor = 33551856
string text = "Web API"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_4 st_4
st_3 st_3
st_2 st_2
dw_tv dw_tv
dw_main dw_main
dw_req_main dw_req_main
dw_copy dw_copy
st_1 st_1
end type

on tabpage_main.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.dw_tv=create dw_tv
this.dw_main=create dw_main
this.dw_req_main=create dw_req_main
this.dw_copy=create dw_copy
this.st_1=create st_1
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.dw_tv,&
this.dw_main,&
this.dw_req_main,&
this.dw_copy,&
this.st_1}
end on

on tabpage_main.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.dw_tv)
destroy(this.dw_main)
destroy(this.dw_req_main)
destroy(this.dw_copy)
destroy(this.st_1)
end on

event type boolean ue_isdatachanged();//====================================================================
//$<Event>: ue_isdatachanged
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_main.AcceptText()
idw_req_main.AcceptText()

if idw_main.ModifiedCount() + idw_main.DeletedCount() > 0 then Return true
if idw_req_main.ModifiedCount() + idw_req_main.DeletedCount() > 0 then Return true

Return false
end event

type st_4 from statictext within tabpage_main
integer width = 1111
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "API Components"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_3 from statictext within tabpage_main
integer x = 1134
integer width = 2935
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Server Information"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_2 from statictext within tabpage_main
integer x = 1138
integer y = 1248
integer width = 2921
integer height = 112
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "API Request"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_tv from u_dw within tabpage_main
event ue_rightclick ( string as_parm,  long al_row,  long al_level )
event type long ue_locate ( long webapi_id,  long request_id )
integer y = 100
integer width = 1111
integer height = 1780
integer taborder = 110
string title = "Server/API Request"
string dataobject = "d_webapi_tv"
boolean hscrollbar = true
end type

event ue_rightclick(string as_parm, long al_row, long al_level);//====================================================================
//$<Event>: ue_rightclick
//$<Arguments>:
// 	value    string    as_parm
// 	value    long      al_row
// 	value    long      al_level
//$<Return>:  (None)
//$<Description>: Right Click.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

CHOOSE CASE Lower(as_parm)
	CASE 'expand'
		if al_row > 0 and al_level > 0 then this.expandallchildren( al_row, al_level)
	CASE 'expand all'
		this.expandall( )
	CASE 'collapse'
		if al_row > 0 and al_level > 0 then this.collapseallchildren(al_row, al_level)
	CASE 'collapse all'
		this.collapseall( )
END CHOOSE
end event

event type long ue_locate(long webapi_id, long request_id);//====================================================================
//$<Event>: ue_locate
//$<Arguments>:
// 	value    long    webapi_id
// 	value    long    request_id
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_Return
long ll_FindRow
long ll_RowCount

ll_RowCount = this.RowCount()

ll_FindRow = this.Find("request_id=" + String(request_id), 1, ll_RowCount)
if ll_FindRow > 0 then
	this.ScrollToRow(ll_FindRow)
	this.Expand(ll_FindRow, 1)	
	this.SelectTreeNode(ll_FindRow, 2, true)
	Return ll_FindRow	
end if

ll_FindRow = this.Find("webapi_id=" + String(webapi_id), 1, ll_RowCount)
if ll_FindRow > 0 then
	this.ScrollToRow(ll_FindRow)
	this.Expand(ll_FindRow, 1)
	this.SelectTreeNode(ll_FindRow, 1, true)		
end if

Return ll_FindRow

end event

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	if this.isexpanded(lstr_band.row, 1)  then
		this.collapse( lstr_band.row, 1)
	else
		this.expand( lstr_band.row, 1)
	end if
end if


end event

event treenodeselected;//====================================================================
//$<Event>: treenodeselected
//$<Arguments>:
// 	value    long    row
// 	value    long    grouplevel
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if row > 0 then
	w_webapi_setting.Title = "Web API Setup  (" + this.GetItemString(Row, "webapi_request_request_name") +  " )"
	il_webapi_id = this.GetItemNumber(Row, "webapi_id")
	il_request_id  = this.GetItemNumber(Row, "webapi_request_request_id")
	if IsNull(il_request_id) then il_request_id = 0
	If tab_1.Selectedtab = 1 Then
		idw_main.of_retrieve()
		idw_req_main.of_retrieve()
	End If
	
	If idw_req_main.rowcount() < 1 Then 
		idw_req_main.Insertrow(0)
		//idw_req_main.SetItemStatus(1, 0, Primary!, NotModified!)
		
		//Recreate  ids_in
		of_create_in_ds()
	End If
Else
	If tab_1.Selectedtab = 1 Then
		idw_main.of_reset( )
		idw_req_main.of_reset( )
	End If
end if

If tab_1.Selectedtab = 1 Then
	if grouplevel = 1 then 
		idw_main.SetFocus()
	elseif grouplevel  = 2 then
		idw_req_main.SetFocus()
	end if
End If


end event

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.SetTransObject(SQLCA);

idw_tv = tab_1.tabpage_main.dw_tv

this.of_setupdateable( False)
end event

event rbuttondown;//====================================================================
//$<Event>: rbuttondown
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_grouplevel, ll_row
string  ls_dw_band
str_dw_band lstr_band
m_popup_tv lm_tv

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	ll_grouplevel = 1
elseif lstr_band.band = 'detail' then
	ll_grouplevel = 2
end if
ll_row = lstr_band.row

if ll_grouplevel > 0 and ll_row > 0 then
	//locate current row
	this.setrow(ll_row)
	this.scrolltorow(ll_row)
	this.selecttreenode(ll_row, ll_grouplevel, true)

	//Popup menu
	if ll_grouplevel = 1 then
		lm_tv = Create m_popup_tv	
		lm_tv.of_set_parent (this, ll_row, ll_grouplevel )
		if this.isexpanded(ll_row, ll_grouplevel) then
			lm_tv.m_expand.enabled = false
			lm_tv.m_collapse.enabled = true			
		else
			lm_tv.m_expand.enabled = true
			lm_tv.m_collapse.enabled = false
		end if		
		lm_tv.m_expandall.enabled = true	
		lm_tv.m_collapseall.enabled = true			
		 gnv_app.of_popmenu(this,lm_tv)
		Destroy lm_tv		
	end if		
end if

end event

event pfc_retrieve;call super::pfc_retrieve;//====================================================================
//$<Event>: pfc_retrieve
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_RowCount

this.Retrieve()

ll_RowCount = this.RowCount()
If ll_RowCount > 0 Then
	this.ScrollToRow(1)
	this.ExpandAll( )
	this.SelectTreeNode(1, 2, true)	
End If

Return 0
end event

event pfc_deleterow;//====================================================================
//$<Event>: pfc_deleterow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	idw_main.event pfc_deleterow () 
ELse
	idw_req_main.event pfc_deleterow () 
End If

Return 1
end event

event pfc_addrow;//====================================================================
//$<Event>: pfc_addrow
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 02.22.2016 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.2' then 
	idw_req_main.event pfc_addrow () 	
ELse
	idw_main.event pfc_addrow () 
End If

Return 1
end event

type dw_main from u_dw within tabpage_main
string tag = "flag"
integer x = 1134
integer y = 96
integer width = 2935
integer height = 1112
integer taborder = 10
boolean bringtotop = true
string title = "Server Infomation"
string dataobject = "d_webapi_main"
boolean vscrollbar = false
end type

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.SetTransObject(SQLCA)

idw_main = tab_1.tabpage_main.dw_main

of_SetUpdateable(True)

of_SetRowManager(True)

of_SetReqColumn(TRUE)
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_id
long ll_RowCount

// Set primary key
ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	if this.GetItemNumber(ll_RowCount, "webapi_id") = 0 then
		SELECT Max(webapi_id)
		INTO :ll_id
		FROM webapi_main;
		if IsNull(ll_id) then	ll_id = 0
		ll_id ++
		this.SetItem(ll_RowCount, "webapi_id", ll_id)
	end if
end if

Return 1
end event

event pfc_postupdate;call super::pfc_postupdate;Long ll_id
Long ll_RowCount
Long ll_webapi_id
Long ll_find
Int i, li_cnt
String ls_webapi_name

// Set primary key
ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	//New Insert
	if this.GetItemNumber(ll_RowCount, "webapi_id") <> il_webapi_id then
		ll_webapi_id = this.GetItemNumber(ll_RowCount, "webapi_id")
		idw_tv.of_Retrieve()
		idw_tv.dynamic event ue_locate(ll_webapi_id, 0)
	Else
		//Refresh name if need
		ls_webapi_name =  this.GetItemString(ll_RowCount, "webapi_name")
		li_cnt = idw_tv.RowCount()
		For i = 1 to li_cnt
			If idw_tv.GetItemNumber(i, "webapi_id") = il_webapi_id Then
				If  idw_tv.GetItemString(i, "webapi_main_webapi_name")<> ls_webapi_name Then
					idw_tv.SetItem(i, "webapi_main_webapi_name", ls_webapi_name)
				End If
			End If
		Next	
	end if
end if

Return 1
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//====================================================================
//$<Event>: pfc_postinsertrow
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.14.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.SetItem(al_row,'webapi_id', 0)

//Reset dw_req_main, Added by Appeon long.zhang 10.14.2015 (BugS101301)
idw_req_main.of_reset()
end event

event pfc_retrieve;call super::pfc_retrieve;//====================================================================
//$<Event>: pfc_retrieve
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Return this.Retrieve(il_webapi_id)
end event

event pfc_predeleterow;call super::pfc_predeleterow;//New Insert, then delete it.
if this.GetItemNumber(getrow(), "webapi_id") <> il_webapi_id then
	idw_tv.of_Retrieve()
	Return 0
End If
		
		//Check request
If idw_tv.Find("webapi_id = " + String(il_webapi_id) +" And request_id > 0 ", 1, idw_tv.rowcount()) > 0 Then
	If Messagebox('Delete Server Information ',"Some request settings are still depending on this Server Information.~r~n"+ &
		"If click 'Yes', all request settings related will be deleted.~r~n ",Question!,YesNo!, 2) = 1 Then
		Return 1
	Else
		Return 0
	End If	
End If

Return 1
end event

event pfc_deleterow;call super::pfc_deleterow;//====================================================================
//$<Event>: pfc_deleterow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Delete all related tables
//$<Author>: (Appeon) long.zhang 08.10.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If Not (AncestorReturnValue = SUCCESS) Then Return  AncestorReturnValue//Added by Appeon long.zhang 02.22.2016

gnv_appeondb.of_startqueue( )

Delete from webapi_inout where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_request_header where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_request_body where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_response where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_response_header where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_response_body where request_id in (select request_id from webapi_request where webapi_id = :il_webapi_id);

Delete from webapi_request where  webapi_id = :il_webapi_id;

gnv_appeondb.of_CommitQueue( )

//Do not need to click 'Save'
If idw_main.Update(True, True) = 1 Then
	idw_tv.of_Retrieve()
End If

Return 1



end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//====================================================================
//$<Event>: pfc_preinsertrow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Save it before insertrow
//$<Author>: (Appeon) long.zhang 10.14.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_rc
if tab_1.tabpage_main.Event ue_IsDataChanged() then
	li_rc = cb_save.Event Clicked()
	If li_rc < 0 Then Return 0 //prevent it from insert row
End If

Return 1
end event

type dw_req_main from u_dw within tabpage_main
event type integer ue_save ( )
event type long ue_insertselectrow ( datastore ads_proc_lookup )
string tag = "flag"
integer x = 1138
integer y = 1356
integer width = 2926
integer height = 528
integer taborder = 50
boolean bringtotop = true
string title = "API Request"
string dataobject = "d_webapi_req_main"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_req_main = tab_1.tabpage_main.dw_req_main

this.SetTransObject(SQLCA)
of_SetUpdateable(True)

of_SetRowManager(True)
this.inv_RowManager.of_SetConfirmOnDelete(TRUE)

//PFC linkage
of_SetLinkage(true)
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
this.inv_linkage.of_SetDeleteStyle(inv_linkage.DELETE_ROWS )
this.inv_linkage.of_setupdateonrowchange(TRUE)

This.of_SetReqColumn(TRUE)
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//====================================================================
//$<Event>: pfc_preinsertrow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If il_webapi_id =0 Then
	Messagebox('Warning','No Server Information.')
	Return 0
End If

Return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.06.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_id
long ll_RowCount

// Set primary key
ll_RowCount = this.RowCount()
if ll_RowCount > 0 then
	if this.GetItemNumber(ll_RowCount, "request_id") = 0 then
		SELECT Max(request_id)
		INTO :ll_id
		FROM webapi_request;
		if IsNull(ll_id) then	ll_id = 0
		ll_id ++
		this.SetItem(ll_RowCount, "request_id", ll_id)
		
		this.SetItem(ll_RowCount, "webapi_id", il_webapi_id)
	end if
end if

Return 1
end event

event pfc_postupdate;call super::pfc_postupdate;//====================================================================
//$<Event>: pfc_postupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_id
long ll_Row
Long ll_webapi_id
Long ll_request_id
Int li_cnt, i
String ls_request_name

// Set primary key
ll_Row = this.GetRow()
if ll_Row > 0 then
	if this.GetItemNumber(ll_Row, "request_id") <> il_request_id then
		il_request_id = this.GetItemNumber(ll_Row, "request_id")
		
		ll_webapi_id = il_webapi_id
		ll_request_id = il_request_id
		
		idw_tv.SetRedraw(False)
		idw_tv.of_Retrieve()
		idw_tv.dynamic event ue_locate(ll_webapi_id, ll_request_id)
		idw_tv.SetRedraw(True)
	Else
		//Refresh name if need
		ls_request_name =  this.GetItemString(ll_Row, "request_name")
		li_cnt = idw_tv.RowCount()
		For i = 1 to li_cnt
			If idw_tv.GetItemNumber(i, "request_id") = il_request_id Then
				If  idw_tv.GetItemString(i, "webapi_request_request_name")<> ls_request_name Then
					idw_tv.SetItem(i, "webapi_request_request_name", ls_request_name)
					Exit
				End If
			End If
		Next	
	end if
Else //Delete
	ll_webapi_id = il_webapi_id
	
	idw_tv.SetRedraw(False)
	idw_tv.of_Retrieve()
	idw_tv.dynamic event ue_locate(ll_webapi_id, 0)
	idw_tv.SetRedraw(True)
end if


Return 1
end event

event pfc_postinsertrow;call super::pfc_postinsertrow;//====================================================================
//$<Event>: pfc_postinsertrow
//$<Arguments>:
// 	value    long    al_row
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

il_request_id = 0

//Recreate  ids_in
of_create_in_ds()
end event

event pfc_retrieve;call super::pfc_retrieve;//====================================================================
//$<Event>: pfc_retrieve
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Return this.Retrieve(il_request_id)

end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_col

If dwo.name = 'b_verify' Then
	ls_col = 'request_uri'
	of_verify(idw_req_main, row, ls_col, True) 
ElseIf dwo.name = 'b_verify_2' Then
	ls_col = 'response_filename'
	of_verify(idw_req_main, row, ls_col, True) 
End If
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check request_uri expression
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If AncestorReturnValue < 0 Then Return -1

Int li_row
Int i
String ls_expression

li_row =  idw_req_main.getrow() 
If li_row > 0 Then
	i = of_verify(idw_req_main,li_row, 'request_uri')
	If i < 0 Then 
		Messagebox('API Request Validation', 'Expression of Request URI is not valid.')
		this.SetFocus()
		Return -1	
	End If

	idw_req_main.accepttext()
	ls_expression = idw_req_main.GetItemString(li_row, 'response_filename')
	If Not( IsNull(ls_expression) or Trim(ls_expression) = '') Then //response_filename may be empty
		i = of_verify(idw_req_main,li_row, 'response_filename')
		If i < 0 Then 
			Messagebox('API Request Validation', 'Expression of Response File Name is not valid.')
			this.SetFocus()
			Return -1	
		End If	
	End If
End If

Return 1
end event

type dw_copy from datawindow within tabpage_main
boolean visible = false
integer x = 3653
integer y = 20
integer width = 114
integer height = 56
integer taborder = 40
string dataobject = "d_priv_core_procd_copy"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type st_1 from statictext within tabpage_main
integer x = 1134
integer width = 2935
integer height = 100
boolean bringtotop = true
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Server Information"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type tabpage_req from userobject within tab_1
event create ( )
event destroy ( )
event type boolean ue_isdatachanged ( )
integer x = 18
integer y = 100
integer width = 4082
integer height = 1900
long backcolor = 33551856
string text = "Parameter/Request"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_inout dw_inout
dw_req_bd dw_req_bd
dw_req_hdr dw_req_hdr
end type

on tabpage_req.create
this.dw_inout=create dw_inout
this.dw_req_bd=create dw_req_bd
this.dw_req_hdr=create dw_req_hdr
this.Control[]={this.dw_inout,&
this.dw_req_bd,&
this.dw_req_hdr}
end on

on tabpage_req.destroy
destroy(this.dw_inout)
destroy(this.dw_req_bd)
destroy(this.dw_req_hdr)
end on

event type boolean ue_isdatachanged();//====================================================================
//$<Event>: ue_isdatachanged
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
idw_inout.AcceptText()
idw_req_hdr.AcceptText()
idw_req_bd.AcceptText()

if idw_inout.ModifiedCount() + idw_inout.DeletedCount() > 0 then Return true
if idw_req_hdr.ModifiedCount() + idw_req_hdr.DeletedCount() > 0 then Return true
if idw_req_bd.ModifiedCount() + idw_req_bd.DeletedCount() > 0 then Return true

Return false
end event

type dw_inout from u_dw within tabpage_req
string tag = "flag"
integer x = 27
integer y = 36
integer width = 1504
integer height = 1124
integer taborder = 70
string dragicon = ".\row.ico"
boolean bringtotop = true
boolean titlebar = true
string title = "In/Out Parameters"
string dataobject = "d_webapi_inout"
boolean border = false
end type

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_inout = tab_1.tabpage_req.dw_inout

this.SetTransObject(SQLCA)
of_SetUpdateable(True)
of_SetRowManager(True)

//Link with idw_req_main
of_SetLinkage(true)
inv_linkage.of_SetMaster(idw_req_main) 
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
inv_linkage.of_Register("request_id", "request_id")

end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Set Seq no.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i,li_cnt

li_cnt = this.rowcount()

For i = 1 to li_cnt
	If IsNull(this.object.seq_no[i]) or this.object.seq_no[i] <> i Then
		this.object.seq_no[i] = i
	End If
Next

Return 0
end event

event retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend
//$<Arguments>:
// 	value    long    rowcount
//$<Return>:  long
//$<Description>:  
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Used for editing expression
of_create_in_ds()

//Reset dddw in idw_resp_main and idw_resp_header.
of_reset_resp_dddw()
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check value
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_row,li_cnt
Int i
String ls_name
idw_inout.accepttext()

li_cnt =  idw_inout.rowcount() 
If li_cnt > 0 Then
	For li_row = 1 to li_cnt
		//check required
		ls_name = Trim(idw_inout.GetItemString(li_row,'name'))
		If IsNull(ls_name) or ls_name = '' Then
			Messagebox('In/Out Parameters Validation', 'Name in row ' + String(li_row)+' is required.')
			Return -1	
		End If
		
		//Check Duplicate name
		If li_row<>li_cnt and idw_inout.Find("Upper(trim(name)) = '" +upper(ls_name) +"'", li_row + 1, li_cnt) > 0 Then
			Messagebox('In/Out Parameters Validation', 'Name in row ' + String(li_row)+' is duplicate.')
			Return -1	
		End If
	Next
	
	//Check name format
	If of_check_inout_names() = -1 Then
		Messagebox('In/Out Parameters Validation', 'In/Out Names should be defined with correct name format.')
		Return -1
	End If
End If

Return i
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: For Drag.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String dwobjectname
String ls_drag_parm
Int li_inout
Long ll_pos

//reset is_drag_parm to ''
dwobjectname = This.GetObjectAtPointer()
IF dwo.Type = 'column' and (row >0) Then
	ls_drag_parm = GetItemString(row, 'name')
	li_inout = GetItemNumber(row, 'inout')
	If LenA(ls_drag_parm) > 0 and li_inout = 1 Then //Only in parameters
		is_drag_parm = ls_drag_parm
		This.Drag(Begin!)
	End If
END IF
end event

event pfc_accepttext;call super::pfc_accepttext;//====================================================================
//$<Event>: pfc_accepttext
//$<Arguments>:
// 	value    boolean    ab_focusonerror
//$<Return>:  integer
//$<Description>: Refresh ids_in and ids_resp_dddw
//$<Author>: (Appeon) long.zhang 08.28.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If AncestorReturnValue = SUCCESS THEN
	If	this.ModifiedCount() + this.DeletedCount() > 0 then			
		of_create_in_ds()
		of_reset_resp_dddw()
	End If
End If

Return AncestorReturnValue
end event

type dw_req_bd from u_dw within tabpage_req
string tag = "flag"
integer x = 32
integer y = 1180
integer width = 3982
integer height = 708
integer taborder = 80
boolean bringtotop = true
boolean titlebar = true
string title = "Request Body"
string dataobject = "d_webapi_req_body"
boolean border = false
end type

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_req_bd = tab_1.tabpage_req.dw_req_bd

this.SetTransObject(SQLCA)
of_SetUpdateable(True)
//of_SetRowManager(True)

//Link with idw_tv
of_SetLinkage(true)
inv_linkage.of_SetMaster(idw_req_main) 
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
inv_linkage.of_Register("request_id", "request_id")
end event

event pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check value expression
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_row,li_cnt
Int i
String ls_name
Boolean lb_has_request_body = False

li_cnt = idw_req_bd.rowcount()
If li_cnt > 0 Then
	For li_row = 1 to li_cnt
		ls_name = idw_req_bd.GetItemString(li_row,'name')
		If IsNull(ls_name) or Trim(ls_name) = '' Then
			Messagebox('Request Body Validation', 'Name in row ' + String(li_row)+' is not valid.')
			Return -1	
		End If
		
		If Trim(Upper(ls_name)) = 'REQUEST BODY' Then
			lb_has_request_body = True
		End If
					
		i = of_verify(idw_req_bd,li_row, 'value_part')
		If i < 0 Then 
			Messagebox('Request Body Validation', 'Expression of Value/Part in row ' + String(li_row)+' is not valid.')
			this.SetFocus()
			Return -1	
		End If
	Next
	
	If lb_has_request_body and li_cnt> 1 Then
		Messagebox('Request Body Validation', "If use 'REQUEST BODY', only one row is allowed.")
		this.SetFocus()
		Return -1	
	End If
		
End If

Return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Set seq_no.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i,li_cnt

li_cnt = this.rowcount()

For i = 1 to li_cnt
	If IsNull(this.object.seq_no[i]) or this.object.seq_no[i] <> i Then
		this.object.seq_no[i] = i
	End If
Next

Return 0
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_col

If dwo.name = 'b_verify' Then
	ls_col = 'value_part'
	of_verify(idw_req_bd, row, ls_col, True) 
End If
end event

event dragdrop;call super::dragdrop;//====================================================================
//$<Event>: dragdrop
//$<Arguments>:
// 	value    dragobject    source
// 	value    long          row
// 	value    dwobject      dwo
//$<Return>:  long
//$<Description>: Drag from dw_inout.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

DragObject	ldo_control
Long i

// Get the dragged object.
ldo_control = DraggedObject()

// Determine if the dragged object datawindow
IF ldo_control = idw_inout THEN
	i = this.event pfc_addrow()
	this.SetItem(i , 'value_part', is_drag_parm)
END IF

end event

type dw_req_hdr from u_dw within tabpage_req
string tag = "flag"
integer x = 1573
integer y = 36
integer width = 2446
integer height = 1124
integer taborder = 60
boolean bringtotop = true
boolean titlebar = true
string title = "Request Header"
string dataobject = "d_webapi_req_hdr"
boolean border = false
end type

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_req_hdr = tab_1.tabpage_req.dw_req_hdr

this.SetTransObject(SQLCA)
of_SetUpdateable(True)

//Link with idw_tv
of_SetLinkage(true)
inv_linkage.of_SetMaster(idw_req_main) 
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
inv_linkage.of_Register("request_id", "request_id")
end event

event pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check value expression
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_row,li_cnt
Int i
String ls_name

li_cnt =  idw_req_hdr.rowcount() 
If li_cnt > 0 Then
	For li_row = 1 to li_cnt
		ls_name = Trim(idw_req_hdr.GetItemString(li_row,'name'))
		If IsNull(ls_name) or ls_name = '' Then
			Messagebox('Request Header Validation', 'Name in row ' + String(li_row)+' is not valid.')
			Return -1	
		End If
		
		//Check Duplicate name
		If li_row<>li_cnt and idw_inout.Find("Upper(trim(name)) = '" +upper(ls_name) +"'", li_row + 1, li_cnt) > 0 Then
			Messagebox('Request Header Validation', 'Name in row ' + String(li_row)+' is duplicate.')
			Return -1	
		End If
		
		i = of_verify(idw_req_hdr,li_row, 'value')
		If i < 0 Then 
			Messagebox('Request Header Validation', 'Expression of Value in row ' + String(li_row)+' is not valid.')
			this.SetFocus()
			Return -1	
		End If
	Next
End If

Return 1
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Set seq_no.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i,li_cnt

li_cnt = this.rowcount()

For i = 1 to li_cnt
	If IsNull(this.object.seq_no[i]) or this.object.seq_no[i] <> i Then
		this.object.seq_no[i] = i
	End If
Next

Return 0
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

string ls_col

If dwo.name = 'b_verify' Then
	ls_col = 'value'
	of_verify(idw_req_hdr, row, ls_col, True) 
End If
end event

event dragdrop;call super::dragdrop;//====================================================================
//$<Event>: dragdrop
//$<Arguments>:
// 	value    dragobject    source
// 	value    long          row
// 	value    dwobject      dwo
//$<Return>:  long
//$<Description>: Drag from dw_inout.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

DragObject	ldo_control
Long i

// Get the dragged object.
ldo_control = DraggedObject()

// Determine if the dragged object datawindow
IF ldo_control = idw_inout THEN
	i = this.event pfc_addrow()
	this.SetItem(i , 'value', is_drag_parm)
	this.SetColumn('name')
END IF

end event

type tabpage_resp from userobject within tab_1
event type boolean ue_isdatachanged ( )
integer x = 18
integer y = 100
integer width = 4082
integer height = 1900
long backcolor = 33551856
string text = "Response"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_resp_body dw_resp_body
dw_resp_hdr dw_resp_hdr
dw_resp dw_resp
end type

event type boolean ue_isdatachanged();//====================================================================
//$<Event>: ue_isdatachanged
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
idw_resp.AcceptText()
idw_resp_hdr.AcceptText()

if idw_resp.ModifiedCount() + idw_resp.DeletedCount() > 0 then Return true
if idw_resp_hdr.ModifiedCount() + idw_resp_hdr.DeletedCount() > 0 then Return true

Return false
end event

on tabpage_resp.create
this.dw_resp_body=create dw_resp_body
this.dw_resp_hdr=create dw_resp_hdr
this.dw_resp=create dw_resp
this.Control[]={this.dw_resp_body,&
this.dw_resp_hdr,&
this.dw_resp}
end on

on tabpage_resp.destroy
destroy(this.dw_resp_body)
destroy(this.dw_resp_hdr)
destroy(this.dw_resp)
end on

type dw_resp_body from u_dw within tabpage_resp
boolean visible = false
integer x = 3776
integer y = 1792
integer width = 233
integer height = 124
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Body"
string dataobject = "d_webapi_resp_body"
end type

type dw_resp_hdr from u_dw within tabpage_resp
integer x = 23
integer y = 788
integer width = 3264
integer height = 1084
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Response Header"
string dataobject = "d_webapi_resp_hdr"
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_resp_hdr = tab_1.tabpage_resp.dw_resp_hdr

this.SetTransObject(SQLCA)
of_SetUpdateable(True)

//Link with idw_tv
of_SetLinkage(true)
inv_linkage.of_SetMaster(idw_req_main) 
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
inv_linkage.of_Register("request_id", "request_id")
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Set seq_no.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i,li_cnt

li_cnt = this.rowcount()

For i = 1 to li_cnt
	If IsNull(this.object.seq_no[i]) or this.object.seq_no[i] <> i Then
		this.object.seq_no[i] = i
	End If
Next

Return 0
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check name and value
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_row,li_cnt
Int li_col
Int i
Int li_cnt_2
String ls_name
idw_resp_hdr.accepttext()
li_cnt =  idw_resp_hdr.rowcount() 
If li_cnt > 0 Then
	For li_row = 1 to li_cnt
		//check required name
		ls_name = Trim(idw_resp_hdr.GetItemString(li_row,'name'))
		If IsNull(ls_name) or ls_name = '' Then
			Messagebox('Response Header', 'Name in row ' + String(li_row)+' is required.')
			Return -1	
		End If
		
		//Check Duplicate name
		If li_row<>li_cnt and idw_resp_hdr.Find("Upper(trim(name)) = '" +upper(ls_name) +"'", li_row + 1, li_cnt) > 0 Then
			Messagebox('In/Out Parameters Validation', 'Name in row ' + String(li_row)+' is duplicate.')
			Return -1	
		End If
		
		//check required value
		ls_name = Trim(idw_resp_hdr.GetItemString(li_row,'value'))
		If IsNull(ls_name) or ls_name = '' Then
			Messagebox('Response Header', 'Value in row ' + String(li_row)+' is required.')
			Return -1	
		End If
		
		//Exists in dddw 
		If ids_resp_dddw.Find( "name = '" + ls_name +"'", 1,ids_resp_dddw.rowcount()) = 0 Then
			Messagebox('Response Header', 'Out Parameter ' + ls_name +' is not existing.')
			Return -1
		End If
		
		//Check Duplicate value
		If li_row<>li_cnt and idw_resp_hdr.Find("Upper(trim(value)) = '" +upper(ls_name) +"'", li_row + 1, li_cnt) > 0 Then
			Messagebox('In/Out Parameters Validation', 'Value in row ' + String(li_row)+' is duplicate.')
			Return -1	
		End If
		
		//Check Duplicate value in idw_resp
		If idw_resp.rowcount() > 0 Then
			li_cnt_2 =  Integer(idw_resp.object.datawindow.column.count)
			For li_col = 2 to li_cnt_2 //don't need to check #1:request_id
				//Check Duplicate value			
				If  ls_name = Trim(idw_resp.GetItemString(1, li_col)) Then
					Messagebox('In/Out Parameters Validation', 'Value in row ' + String(li_row)+' is being used in API Response.')
					Return -1
				End If
			Next
		End If
	Next
End If

Return 1
end event

type dw_resp from u_dw within tabpage_resp
integer x = 23
integer y = 24
integer width = 3264
integer height = 740
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "API Response"
string dataobject = "d_webapi_resp"
boolean vscrollbar = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

idw_resp = tab_1.tabpage_resp.dw_resp

this.SetTransObject(SQLCA)
of_SetUpdateable(True)

//Link with idw_tv
of_SetLinkage(true)
inv_linkage.of_SetMaster(idw_req_main) 
this.inv_linkage.of_SetStyle(inv_linkage.retrieve )
inv_linkage.of_Register("request_id", "request_id")
end event

event pfc_preinsertrow;call super::pfc_preinsertrow;//====================================================================
//$<Event>: pfc_preinsertrow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Can not add more than one API response setting.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If this.rowcount() = 1 Then
	Messagebox("Response","Can not add more than one API response setting.")
	Return -1
End If
	
end event

event pfc_validation;call super::pfc_validation;//====================================================================
//$<Event>: pfc_validation
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Check value
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_col,li_cnt
Int i
String ls_name

idw_resp.accepttext()

If idw_resp.rowcount() > 0 Then
	li_cnt =  Integer(idw_resp.object.datawindow.column.count)
	For li_col = 2 to li_cnt //don't need to check #1:request_id
		
		//Check required name
		ls_name = Trim(idw_resp.GetItemString(1, li_col))
		
		If IsNull(ls_name) Then Continue// Added by Appeon long.zhang 08.22.2016 (Bug id 5297 - Getting errors setting up API for AMA)
				
		If ids_resp_dddw.Find( "name = '" + ls_name +"'", 1,ids_resp_dddw.rowcount()) = 0 Then
			Messagebox('API Response Validation', 'Out Parameter ' + ls_name +' is not existing.')
			Return -1
		End If
		
		//Check Duplicate value
		If li_col<>li_cnt Then
			For i = (li_col + 1) to li_cnt		
				If (Not IsNull(ls_name)) And ls_name = Trim(idw_resp.GetItemString(1, i)) Then
					Messagebox('API Response Validation', 'Out Parameter ' + ls_name +' is duplicate.')
					Return -1
				End If
			Next
		End If
	Next
End If

Return 1
end event

type tabpage_test from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 4082
integer height = 1900
long backcolor = 33551856
string text = "Test"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cbx_show cbx_show
cb_3 cb_3
cb_test_3 cb_test_3
cb_test_2 cb_test_2
dw_test_out dw_test_out
dw_test_in dw_test_in
cb_test_1 cb_test_1
cb_2 cb_2
end type

on tabpage_test.create
this.cbx_show=create cbx_show
this.cb_3=create cb_3
this.cb_test_3=create cb_test_3
this.cb_test_2=create cb_test_2
this.dw_test_out=create dw_test_out
this.dw_test_in=create dw_test_in
this.cb_test_1=create cb_test_1
this.cb_2=create cb_2
this.Control[]={this.cbx_show,&
this.cb_3,&
this.cb_test_3,&
this.cb_test_2,&
this.dw_test_out,&
this.dw_test_in,&
this.cb_test_1,&
this.cb_2}
end on

on tabpage_test.destroy
destroy(this.cbx_show)
destroy(this.cb_3)
destroy(this.cb_test_3)
destroy(this.cb_test_2)
destroy(this.dw_test_out)
destroy(this.dw_test_in)
destroy(this.cb_test_1)
destroy(this.cb_2)
end on

type cbx_show from checkbox within tabpage_test
integer x = 1673
integer y = 836
integer width = 603
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Show Request Body"
end type

type cb_3 from commandbutton within tabpage_test
integer x = 3520
integer y = 32
integer width = 521
integer height = 76
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Generate SQL"
end type

event clicked;datawindow ldw[]
n_cst_gen_sql lnv_gen_sql
String ls_sql

ldw[1] = idw_main
ldw[2] = idw_req_main
ldw[3] = idw_inout
ldw[4] = idw_req_hdr
ldw[5] = idw_req_bd
ldw[6] = idw_resp
ldw[7] = idw_resp_hdr

ls_sql = lnv_gen_sql.of_gen_sql_insert(ldw[])
If LenA(ls_sql) > 0 Then
	Messagebox('Insert',ls_sql)
	//Clipboard(ls_sql)
End If
end event

type cb_test_3 from commandbutton within tabpage_test
integer x = 55
integer y = 824
integer width = 1554
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "(3) Send request, and fetch response values into Out Parameters."
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Test Step 3, Send request, and fetch response values into Out Parameters.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i, li_cnt, li_rtn
String ls_arg
String ls_value

//Send request
i = inv_webapi.of_request()
If i < 0 Then
	messagebox('Step 3', inv_webapi.of_get_errtext())
Else
	//Set dw_test_out
	li_cnt = dw_test_out.rowcount()
	For i = 1 to li_cnt
		ls_value = ''
		ls_arg = dw_test_out.GetItemString(i, 'name')
		li_rtn = inv_webapi.of_get_inout_value(ls_arg, ls_value)
		If li_rtn < 0 Then
			Messagebox('Step 3', inv_webapi.of_get_errtext())
			Return -1
		Else
			dw_test_out.SetItem(i, 'value', ls_value)
		End If
	Next
	
	dw_test_out.SetFocus()
	
	//Added by Appeon long.zhang 05.27.2016
	If cbx_show.checked Then Messagebox("Request Body",inv_webapi.of_get_request_body( ))

	messagebox('Step 3','Finished.')
End If



Return
	
	


end event

type cb_test_2 from commandbutton within tabpage_test
integer x = 55
integer y = 704
integer width = 1961
integer height = 92
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "(2) Please enter test values for In Parameters first, then click this button. (Optional)"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Test step 2, submit In Parameters.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i, li_cnt, li_rtn
String ls_arg
String ls_value

dw_test_in.accepttext()

li_cnt = dw_test_in.rowcount()
For i = 1 to li_cnt
	ls_arg = dw_test_in.GetItemString(i, 'name')
	ls_value = dw_test_in.GetItemString(i, 'value')
	li_rtn = inv_webapi.of_set_inout_value(ls_arg, ls_value)
	If li_rtn < 0 Then
		Messagebox('Step 2', inv_webapi.of_get_errtext())
		Return -1
	End If
Next

Messagebox('Step 2', 'Finished.')

Return 1
	
	


end event

type dw_test_out from u_dw within tabpage_test
integer x = 59
integer y = 928
integer width = 3986
integer height = 956
integer taborder = 31
boolean bringtotop = true
boolean titlebar = true
string title = "Show Out Parameters here"
string dataobject = "d_webapi_test_out"
boolean hscrollbar = true
end type

event constructor;call super::constructor;of_SetUpdateable(False)
end event

type dw_test_in from u_dw within tabpage_test
integer x = 59
integer y = 140
integer width = 3986
integer height = 548
integer taborder = 21
boolean bringtotop = true
boolean titlebar = true
string title = "Enter In Parameters here"
string dataobject = "d_webapi_test_in"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_SetUpdateable(False)
end event

type cb_test_1 from commandbutton within tabpage_test
integer x = 55
integer y = 36
integer width = 562
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "(1) Initiate Request Id."
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Test step 1, Initiate Request Id.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i, li_cnt, j
String ls_arg

If il_request_id <= 0 Then 
	MessageBox('Step 1','Please select an Request Id first.')
	Return 
End If

//Ini dw_test_in and dw_test_out for test
dw_test_in.reset()
dw_test_out.reset()
li_cnt = idw_inout.RowCount()
If li_cnt > 0 Then
	For i = 1 to li_cnt
		ls_arg = idw_inout.GetItemString(i, 'name')
		If idw_inout.GetItemNumber(i, 'inout') = 1 Then
			j = dw_test_in.insertrow(0)
			dw_test_in.SetItem(j,'name',ls_arg)
		Else
			j = dw_test_out.insertrow(0)
			dw_test_out.SetItem(j,'name',ls_arg)
		End If
	Next
End If

//Set test mode, only for test.
inv_webapi.of_set_testmode(True)

//Request Ini
i =inv_webapi.of_ini( il_request_id)//1:succeed and ids_inout created, 0::succeed and no ids_inout created
If i < 0 Then
	Messagebox('Step 1', inv_webapi.of_get_errtext())
	Return -1
Else
	Messagebox('Step 1', 'Finished.')	
End If

Return 1
	
	


end event

type cb_2 from commandbutton within tabpage_test
boolean visible = false
integer x = 2802
integer y = 32
integer width = 521
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Quick Test (Not used)"
end type

event clicked;Int i

If il_request_id <= 0 Then 
	MessageBox('Test','Please select an Request Id first.')
	Return 
End If
n_cst_webapi lnv_webapi

//Set test mode
lnv_webapi.of_set_testmode(True)

//Request Ini
i =lnv_webapi.of_ini( il_request_id)


//Send request
i = lnv_webapi.of_request()
If i < 0 Then
	messagebox('Test Error',lnv_webapi.is_err_text)
Else
	messagebox('Test','OK!')
End If
end event

