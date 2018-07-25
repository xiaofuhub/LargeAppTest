$PBExportHeader$w_acp_document_doc_ref.srw
forward
global type w_acp_document_doc_ref from w_response
end type
type st_1 from statictext within w_acp_document_doc_ref
end type
type cb_2 from commandbutton within w_acp_document_doc_ref
end type
type cb_1 from commandbutton within w_acp_document_doc_ref
end type
type dw_1 from u_dw_contract within w_acp_document_doc_ref
end type
end forward

global type w_acp_document_doc_ref from w_response
integer width = 3547
integer height = 1680
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_acp_document_doc_ref w_acp_document_doc_ref

on w_acp_document_doc_ref.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_acp_document_doc_ref.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;str_pass lstr_pass

lstr_pass = message.powerobjectparm

dw_1.Dynamic Event ue_populatedddws()
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(lstr_pass.s_string,lstr_pass.s_long[1] )

end event

type st_1 from statictext within w_acp_document_doc_ref
integer x = 37
integer y = 20
integer width = 3378
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "The Document(s) below are using it :"
long bordercolor = 67108864
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_acp_document_doc_ref
integer x = 3131
integer y = 1524
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_acp_document_doc_ref
integer x = 2747
integer y = 1524
integer width = 361
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Output"
end type

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent( dw_1)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'Mail'
NewMenu.m_options.PopMenu(this.x, + this.y - 190)


end event

type dw_1 from u_dw_contract within w_acp_document_doc_ref
integer x = 27
integer y = 108
integer width = 3488
integer height = 1376
integer taborder = 10
string dataobject = "d_acp_document_doc_ref"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_setupdateable(False)
This.of_setrowselect(True)
This.inv_rowselect.of_setstyle(This.inv_rowselect.single )

end event

event rbuttonup;return  //(Appeon)Harry 11.21.2013 - V141 Cancel extend for BugH082301 of IntelliContract V14.1 History Issues
end event

