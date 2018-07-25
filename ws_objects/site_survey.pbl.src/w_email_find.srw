$PBExportHeader$w_email_find.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_email_find from w_response
end type
type cb_reset from commandbutton within w_email_find
end type
type cb_cancel from commandbutton within w_email_find
end type
type cb_search from commandbutton within w_email_find
end type
type dw_search from u_dw within w_email_find
end type
type gb_1 from groupbox within w_email_find
end type
end forward

global type w_email_find from w_response
integer width = 2862
integer height = 1352
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_reset cb_reset
cb_cancel cb_cancel
cb_search cb_search
dw_search dw_search
gb_1 gb_1
end type
global w_email_find w_email_find

type variables
str_email_reply istr_email
end variables

forward prototypes
public function integer of_disable_ctx_flds ()
end prototypes

public function integer of_disable_ctx_flds ();//====================================================================
//$<Function>: of_disable_ctx_flds()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Disable ctx fields
//$<Author>: (Appeon) Eugene 09.23.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:for BugA082002 
//====================================================================

IF dw_search.Describe("mail_ctx_id.ColType") <> "!" THEN
	dw_search.Modify("mail_ctx_id.Protect=1")
	dw_search.Modify("mail_ctx_id.Background.Color='553648127'")
END IF

IF dw_search.Describe("mail_doc_id.ColType") <> "!" THEN
	dw_search.Modify("mail_doc_id.Protect=1")
	dw_search.Modify("mail_doc_id.Background.Color='553648127'")
END IF

IF dw_search.Describe("mail_action_item_id.ColType") <> "!" THEN
	dw_search.Modify("mail_action_item_id.Protect=1")
	dw_search.Modify("mail_action_item_id.Background.Color='553648127'")
END IF

IF gi_email_type = 1 THEN //Outlook
	IF dw_search.Describe("folder_id.ColType") <> "!" THEN
	dw_search.Modify("folder_id.Edit.DisplayOnly='Yes'")
	dw_search.Modify("folder_id.Enabled=")
	dw_search.Modify("folder_id.Background.Color='553648127'")
	END IF
END IF

RETURN 1
end function

on w_email_find.create
int iCurrent
call super::create
this.cb_reset=create cb_reset
this.cb_cancel=create cb_cancel
this.cb_search=create cb_search
this.dw_search=create dw_search
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reset
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_search
this.Control[iCurrent+4]=this.dw_search
this.Control[iCurrent+5]=this.gb_1
end on

on w_email_find.destroy
call super::destroy
destroy(this.cb_reset)
destroy(this.cb_cancel)
destroy(this.cb_search)
destroy(this.dw_search)
destroy(this.gb_1)
end on

event open;call super::open;dw_search.InsertRow(0)
dw_search.setcolumn('mail_body')

istr_email = Message.powerobjectparm

end event

event pfc_postopen;call super::pfc_postopen;If Isvalid(w_email_folder) Then
	If Len(w_email_folder.iblb_search) > 0 Then
		dw_search.SetFullstate(w_email_folder.iblb_search)
	Else
		If len(istr_email.as_mail_ctx_id) > 0 Then
			dw_search.SetItem(1,'mail_ctx_id',long(istr_email.as_mail_ctx_id))
		End If		
	End If
End If

end event

type cb_reset from commandbutton within w_email_find
integer x = 1765
integer y = 1208
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reset"
end type

event clicked;dw_search.Reset()
dw_search.InsertRow(0)
end event

type cb_cancel from commandbutton within w_email_find
integer x = 2459
integer y = 1208
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,'')
end event

type cb_search from commandbutton within w_email_find
integer x = 2112
integer y = 1208
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Seach"
boolean default = true
end type

event clicked;Long i,ll_value
String ls_sql,ls_text,ls_value[]
String ls_from,ls_to,ls_cc
String ls_from_arr[],ls_to_arr[],ls_cc_arr[]
Datetime ldt_start,ldt_end
n_cst_string lnv_string

dw_search.AcceptText()

If dw_search.modifiedcount( ) = 0 Then
	Messagebox('Search','Please input the search criteria.')
	Return 0
End If

ldt_start = dw_search.GetItemDateTime(1,'mail_start_date')
ldt_end = dw_search.GetItemDateTime(1,'mail_end_date')
If ldt_end < ldt_start Then
	Messagebox('Search','The End Date is less than the Start Date, please correct it.')
	dw_search.setcolumn('mail_end_date')
	Return 0
End If

//Mail From
ls_from = Trim(dw_search.GetItemString(1,'mail_from'))
If Not isnull(ls_from) and ls_from <> '' Then
	lnv_string.of_parsetoarray(ls_from, ';', ls_from_arr[])
	For i = 1 to UpperBound(ls_from_arr[])
		ls_sql += " And em_mail_items.mail_from like '%" + Trim(ls_from_arr[i]) +"%'"
	Next
End If

//Mail To
ls_to = Trim(dw_search.GetItemString(1,'mail_to'))
If Not isnull(ls_to) and ls_to <> '' Then
	lnv_string.of_parsetoarray(ls_to, ';', ls_to_arr[])
	For i = 1 to UpperBound(ls_to_arr[])
		ls_sql += " And em_mail_items.mail_to like '%" + Trim(ls_to_arr[i]) +"%'"
	Next
End If

//Mail cc
ls_cc = Trim(dw_search.GetItemString(1,'mail_cc'))
If Not isnull(ls_cc) and ls_cc <> '' Then
	lnv_string.of_parsetoarray(ls_cc, ';', ls_cc_arr[])
	For i = 1 to UpperBound(ls_cc_arr[])
		ls_sql += " And em_mail_items.mail_cc like '%" + Trim(ls_cc_arr[i]) +"%'"
	Next
End If

ls_text = Trim(dw_search.GetItemString(1,'mail_subject'))
If Not isnull(ls_text) and ls_text <> '' Then
	lnv_string.of_parsetoarray(ls_text, ' ', ls_value[])
	For i = 1 To UpperBound(ls_value[])
		ls_sql += " And em_mail_items.mail_subject like '%" + Trim(ls_value[i]) +"%'"
	Next
End If

ls_text = Trim(dw_search.GetItemString(1,'mail_body'))

If Not isnull(ls_text) and ls_text <> '' Then
	lnv_string.of_parsetoarray(ls_text, ' ', ls_value[])
	ls_text = lnv_string.of_do_fulltext(ls_text)
	ls_sql += ' And (('
	For i = 1 To UpperBound(ls_value[])
		ls_sql += " em_mail_items.mail_plaintext like '%" + Trim(ls_value[i]) +"%' And "
	Next
	ls_sql += " em_mail_items.mail_save_format <> 'doc' ) or CONTAINS(em_mail_items.mail_rfc822, '" + ls_text + "') and em_mail_items.mail_save_format = 'doc') "
End If

//If Not isnull(ls_text) and ls_text <> '' Then
//	ls_text = lnv_string.of_do_fulltext(ls_text)
//	If ls_text = '' Then Return -1
//	ls_sql += " And CONTAINS(em_mail_items.mail_rfc822, '" + ls_text + "')  "
//End If

ls_text = Trim(dw_search.GetItemString(1,'mail_attach_name'))
If Not isnull(ls_text) and ls_text <> '' Then
	lnv_string.of_parsetoarray(ls_text, ' ', ls_value[])
	For i = 1 to UpperBound(ls_value[])
		ls_sql += " And (em_mail_items.mail_attach_name like '%" + Trim(ls_value[i]) +"%' and em_mail_items.mail_fromclx <> 2)"
	Next
End If

ll_value = dw_search.GetItemnumber(1,'folder_id')
If Not gb_contract_module And gi_email_type = 1 Then ll_value = 3 //Sent Items for IC + Outlook - (BugA082102) Alfee 09.23.2013	
If Not isnull(ll_value) and ll_value <> 100 Then
	ls_sql += " And em_mail_items.sub_folder_id = " + String(ll_value)
End If

If Not isnull(ldt_start) Then
	ls_sql += " And em_mail_items.mail_date >= Convert(Datetime,'" + String(ldt_start,'yyyy-mm-dd') + " 00:00:00.000')"
End If

If Not isnull(ldt_end) Then
	ls_sql += " And em_mail_items.mail_date <= Convert(Datetime,'" + String(ldt_end,'yyyy-mm-dd') + " 23:59:59.999')"
End If

ll_value = dw_search.GetItemnumber(1,'read_status')
If Not isnull(ll_value) and ll_value <> 100 Then
	ls_sql += " And em_mail_items.read_status = " + String(ll_value)
End If

ll_value = dw_search.GetItemnumber(1,'locked')
If Not isnull(ll_value) and ll_value <> 100 Then
	ls_sql += " And em_mail_items.locked = " + String(ll_value)
End If

ll_value = dw_search.GetItemnumber(1,'mail_importance')
If Not isnull(ll_value) and ll_value <> 100 Then
	ls_sql += " And em_mail_items.mail_importance = " + String(ll_value)
End If

ll_value = dw_search.GetItemnumber(1,'mail_ctx_id')
If Not isnull(ll_value) and ll_value <> 0 Then
	ls_sql += " And (em_mail_items.mail_ctx_id = " + String(ll_value) + " or CharIndex('"+String(ll_value)+"' , em_mail_items.ctx_id_list + ',' , 0) > 0) "
End If

ll_value = dw_search.GetItemnumber(1,'mail_doc_id')
If Not isnull(ll_value) and ll_value <> 0 Then
	ls_sql += " And (em_mail_items.mail_doc_id = " + String(ll_value) + " or CharIndex('"+String(ll_value)+"' , em_mail_items.doc_id_list + ',' , 0) > 0) "
End If

ll_value = dw_search.GetItemnumber(1,'mail_action_item_id')
If Not isnull(ll_value) and ll_value <> 0 Then
	ls_sql += " And em_mail_items.mail_action_item_id = " + String(ll_value)
End If

If ls_sql <> '' Then
	ls_sql = " Where em_mail_items.user_id = '" + gs_user_id +"' " + ls_sql
	If Not gb_contract_module And gi_email_type = 1 Then //IC + Outlook	
		ls_sql += " And em_mail_items.deleted = 0 "	 //(BugA082102) Alfee 09.23.2013
	End If
End If
	
If Isvalid(w_email_folder) Then
	dw_search.GetFullstate(w_email_folder.iblb_search)
End If

CloseWithReturn(Parent,ls_sql)
end event

type dw_search from u_dw within w_email_find
integer x = 78
integer y = 116
integer width = 2706
integer height = 1012
integer taborder = 10
string dataobject = "d_em_find"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.Post of_setdropdowncalendar( True)

IF NOT gb_contract_module THEN	of_disable_ctx_flds ()  //for BugA082002  - (Appeon) Eugene 09.23.2013 (V141 ISG-CLX)

end event

type gb_1 from groupbox within w_email_find
integer x = 59
integer y = 20
integer width = 2743
integer height = 1144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search Criteria"
end type

