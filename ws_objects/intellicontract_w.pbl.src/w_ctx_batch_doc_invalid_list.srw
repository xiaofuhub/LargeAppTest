$PBExportHeader$w_ctx_batch_doc_invalid_list.srw
forward
global type w_ctx_batch_doc_invalid_list from w_response
end type
type st_tips from statictext within w_ctx_batch_doc_invalid_list
end type
type cb_cancel from commandbutton within w_ctx_batch_doc_invalid_list
end type
type cb_continue from commandbutton within w_ctx_batch_doc_invalid_list
end type
type dw_list from u_dw within w_ctx_batch_doc_invalid_list
end type
end forward

global type w_ctx_batch_doc_invalid_list from w_response
integer width = 2784
integer height = 1548
string title = "Invalid Contract List"
long backcolor = 33551856
event sys_command pbm_syscommand
st_tips st_tips
cb_cancel cb_cancel
cb_continue cb_continue
dw_list dw_list
end type
global w_ctx_batch_doc_invalid_list w_ctx_batch_doc_invalid_list

type variables
str_batch_doc istr_batch_doc
end variables

event sys_command;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_ctx_batch_doc_invalid_list.create
int iCurrent
call super::create
this.st_tips=create st_tips
this.cb_cancel=create cb_cancel
this.cb_continue=create cb_continue
this.dw_list=create dw_list
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_tips
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_continue
this.Control[iCurrent+4]=this.dw_list
end on

on w_ctx_batch_doc_invalid_list.destroy
call super::destroy
destroy(this.st_tips)
destroy(this.cb_cancel)
destroy(this.cb_continue)
destroy(this.dw_list)
end on

event open;call super::open;istr_batch_doc = Message.Powerobjectparm
end event

event pfc_postopen;call super::pfc_postopen;SetPointer(HourGlass!)

Long ll_row,i
For i = 1 To UpperBound(istr_batch_doc.al_ctx_id[])
	ll_row = dw_list.InsertRow(0)
	dw_list.SetItem(ll_row,'ctx_id',istr_batch_doc.al_ctx_id[i])
	dw_list.SetItem(ll_row,'company',istr_batch_doc.as_companyname[i])
	dw_list.SetItem(ll_row,'category',istr_batch_doc.as_category[i])
	dw_list.SetItem(ll_row,'notes',istr_batch_doc.as_errtext[i])
Next

dw_list.SetSort('Notes Asc')
dw_list.Sort()
dw_list.ScrollToRow(1)
dw_list.SetRow(1)
dw_list.SelectRow(0,False)
dw_list.SelectRow(1,True)
SetPointer(Arrow!)


end event

type st_tips from statictext within w_ctx_batch_doc_invalid_list
integer x = 32
integer y = 32
integer width = 2030
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217857
long backcolor = 33551856
string text = "Warning: Documents can~'t be created or added to the below contract(s)."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_ctx_batch_doc_invalid_list
integer x = 2409
integer y = 1352
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&ancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent,0)
end event

type cb_continue from commandbutton within w_ctx_batch_doc_invalid_list
integer x = 2048
integer y = 1352
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Continue"
boolean default = true
end type

event clicked;CloseWithReturn(Parent,1)
end event

type dw_list from u_dw within w_ctx_batch_doc_invalid_list
integer x = 23
integer y = 108
integer width = 2747
integer height = 1216
integer taborder = 10
string dataobject = "d_ctx_batch_doc_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.of_setsort(True)
This.inv_sort.of_setcolumnheader(True) 

end event

