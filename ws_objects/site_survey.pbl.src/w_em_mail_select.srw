$PBExportHeader$w_em_mail_select.srw
$PBExportComments$(Appeon)Eugene 06.25.2013 - V141 ISG-CLX
forward
global type w_em_mail_select from w_response
end type
type st_1 from statictext within w_em_mail_select
end type
type rb_one from radiobutton within w_em_mail_select
end type
type rb_all from radiobutton within w_em_mail_select
end type
type lv_attachment from u_lv_attachment within w_em_mail_select
end type
type cb_cancel from commandbutton within w_em_mail_select
end type
type cb_select from commandbutton within w_em_mail_select
end type
type dw_mail from u_dw within w_em_mail_select
end type
type gb_1 from groupbox within w_em_mail_select
end type
type gb_2 from groupbox within w_em_mail_select
end type
end forward

global type w_em_mail_select from w_response
integer width = 2752
integer height = 1172
string title = "Select Email"
long backcolor = 33551856
st_1 st_1
rb_one rb_one
rb_all rb_all
lv_attachment lv_attachment
cb_cancel cb_cancel
cb_select cb_select
dw_mail dw_mail
gb_1 gb_1
gb_2 gb_2
end type
global w_em_mail_select w_em_mail_select

type variables
n_cst_easymail_pop3 inv_pop3
str_add_doc istr_ctx_email
end variables

on w_em_mail_select.create
int iCurrent
call super::create
this.st_1=create st_1
this.rb_one=create rb_one
this.rb_all=create rb_all
this.lv_attachment=create lv_attachment
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
this.dw_mail=create dw_mail
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.rb_one
this.Control[iCurrent+3]=this.rb_all
this.Control[iCurrent+4]=this.lv_attachment
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_select
this.Control[iCurrent+7]=this.dw_mail
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_em_mail_select.destroy
call super::destroy
destroy(this.st_1)
destroy(this.rb_one)
destroy(this.rb_all)
destroy(this.lv_attachment)
destroy(this.cb_cancel)
destroy(this.cb_select)
destroy(this.dw_mail)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;String ls_doc_name
String ls_doc,ls_ext
long ll_docid
decimal ldec_revision

If isvalid(Message.powerobjectparm) Then
	istr_ctx_email = Message.powerobjectparm
	ls_doc = istr_ctx_email.filename
	ls_ext = istr_ctx_email.doc_ext
	ll_docid = istr_ctx_email.doc_id
	ldec_revision = istr_ctx_email.revision
	ls_doc_name = gf_merge_file_name(ls_doc,ls_ext ,ll_docid , ldec_revision )
	dw_mail.Retrieve(ll_docid, ls_doc_name)
	If dw_mail.RowCount() = 0 Then 
		cb_select.enabled = False
	End If
End If

end event

type st_1 from statictext within w_em_mail_select
boolean visible = false
integer x = 32
integer y = 964
integer width = 288
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Filter:"
boolean focusrectangle = false
end type

type rb_one from radiobutton within w_em_mail_select
boolean visible = false
integer x = 663
integer y = 964
integer width = 855
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Filter By "
end type

type rb_all from radiobutton within w_em_mail_select
boolean visible = false
integer x = 334
integer y = 964
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "No Filter"
end type

type lv_attachment from u_lv_attachment within w_em_mail_select
integer x = 59
integer y = 688
integer width = 2601
integer height = 188
integer taborder = 30
boolean buttonheader = false
boolean showheader = false
boolean labelwrap = false
listviewview view = listviewsmallicon!
string largepicturename[] = {"attachment.jpg","checkout.bmp"}
string smallpicturename[] = {"attachment.jpg","checkout.bmp"}
boolean ib_rmbmenu = false
end type

type cb_cancel from commandbutton within w_em_mail_select
integer x = 2327
integer y = 952
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,'')
end event

type cb_select from commandbutton within w_em_mail_select
integer x = 1961
integer y = 952
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;listviewitem  lvi_attach
String ls_exportfile,ls_name
Long ll_id,ll_doc_id
Integer li_index,li_attach_cnt,i
String ls_format,ls_attach_list 
String ls_ext,ls_emlfile

ll_id = dw_mail.GetItemNumber(dw_mail.GetRow(),'em_mail_items_id')
ls_format = dw_mail.GetItemString(dw_mail.GetRow(),'em_mail_items_mail_save_format')

li_attach_cnt = lv_attachment.totalItems() 
If li_attach_cnt = 0 Then
	Messagebox('Check In','No attachment can be checked in.')
	Return
End If

For i = 1 To li_attach_cnt
	If lv_attachment.GetItem(i,lvi_attach) > 0 Then
		If lvi_attach.pictureindex = 2 Then
			li_index = i
			ls_name = lvi_attach.label
			Exit
		End If
	End If
Next

If li_index <= 0 Then
	Messagebox('Check In','No attachment can be checked in.')
	Return
End If

ls_name = Trim(Mid(ls_name,1,lastpos(ls_name,'(') - 1 ))
ls_ext = Trim(Mid(ls_name,lastpos(ls_name,'.') + 1, Len(ls_name)))

If Lower(ls_ext) <> Lower(istr_ctx_email.doc_ext ) Then
	Messagebox('Check In','The selected attachment type does not match the document type.')
	Return 
End If

Choose Case Lower(ls_format)
	Case 'eml'
		ls_emlfile = inv_pop3.of_download_email( ll_id, ls_format)
		inv_pop3.of_do_attach(ls_emlfile , ll_id , li_index,'checkin',ls_exportfile)
	Case 'doc'
		inv_pop3.of_do_attach('' , ll_id , li_index,'checkin',ls_exportfile)
End Choose

CloseWithReturn(Parent,ls_exportfile)


end event

type dw_mail from u_dw within w_em_mail_select
integer x = 59
integer y = 88
integer width = 2601
integer height = 480
integer taborder = 10
string dataobject = "d_em_match_document"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
//This.of_setrowselect(True)
This.SetTransObject(SQLCA)
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_id,ll_doc_id
Integer li_index
String ls_format,ls_attach_list ,ls_email_file

ll_id = dw_mail.GetItemNumber(dw_mail.GetRow(),'em_mail_items_id')
ll_doc_id = dw_mail.GetItemNumber(dw_mail.GetRow(),'em_mail_items_mail_doc_id')
ls_format = dw_mail.GetItemString(dw_mail.GetRow(),'em_mail_items_mail_save_format')
ls_attach_list = dw_mail.GetItemString(dw_mail.GetRow(),'em_mail_items_mail_attach_name')

Choose Case Lower(ls_format)
	Case 'eml'
		ls_email_file = inv_pop3.of_download_email( ll_id, ls_format)
		If Not FileExists(ls_email_file) Then Return 
		inv_pop3.of_setattachment(ll_id,ll_doc_id, ls_email_file,ls_attach_list,lv_attachment)
	Case 'doc'
		inv_pop3.of_setattachment(ll_id,ll_doc_id, '',ls_attach_list,lv_attachment)
End Choose


end event

event clicked;call super::clicked;If This.GetRow() = Row then Return
This.SetRow(row)
//This.event rowfocuschanged(Row)

end event

type gb_1 from groupbox within w_em_mail_select
integer x = 23
integer y = 24
integer width = 2674
integer height = 588
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Header"
end type

type gb_2 from groupbox within w_em_mail_select
integer x = 23
integer y = 624
integer width = 2674
integer height = 288
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email Attachments"
end type

