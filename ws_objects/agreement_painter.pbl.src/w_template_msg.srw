$PBExportHeader$w_template_msg.srw
forward
global type w_template_msg from w_response
end type
type cb_print from commandbutton within w_template_msg
end type
type cb_close from commandbutton within w_template_msg
end type
type dw_template from u_dw within w_template_msg
end type
end forward

global type w_template_msg from w_response
integer width = 3099
integer height = 1256
string title = "Message"
boolean controlmenu = false
long backcolor = 33551856
cb_print cb_print
cb_close cb_close
dw_template dw_template
end type
global w_template_msg w_template_msg

type variables
//long il_ctx_acp_clause_id
str_clause istr_clause
end variables

on w_template_msg.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cb_close=create cb_close
this.dw_template=create dw_template
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_template
end on

on w_template_msg.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cb_close)
destroy(this.dw_template)
end on

event open;call super::open;//long ll_row,ll_rowcount
//datawindowchild child
//
//dw_template.of_SetTransObject( SQLCA )
//
////il_ctx_acp_clause_id = message.doubleparm
//istr_clause = Message.Powerobjectparm
////il_ctx_acp_clause_id = istr_clause.al_clause_id
//
//If UpperBound(istr_clause.al_clause_id_arr[]) = 0 Then
//	istr_clause.al_clause_id_arr[1] = istr_clause.al_clause_id
//End If
//
//dw_template.retrieve(istr_clause.al_clause_id_arr[])
//dw_template.setfocus()
//
//
//
//

n_ds 				lds_msg

dw_template.of_SetTransObject( SQLCA )
dw_template.reset( )

lds_msg =  Message.Powerobjectparm
IF lds_msg.rowcount()  > 0 then
	lds_msg.rowscopy( 1, lds_msg.rowcount(), Primary!, dw_template ,1, Primary!)
End IF 
end event

type cb_print from commandbutton within w_template_msg
integer x = 2245
integer y = 1060
integer width = 421
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Out&Put Options"
end type

event clicked;//dw_run.Print()
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_template)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
newmenu.m_options.m_saveasexcel.visible = true	
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
NewMenu.m_options.PopMenu(Parent.pointerx(),Parent.pointerY())

end event

type cb_close from commandbutton within w_template_msg
integer x = 2693
integer y = 1060
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)


end event

type dw_template from u_dw within w_template_msg
integer x = 14
integer y = 20
integer width = 3054
integer height = 1016
integer taborder = 20
string dataobject = "d_template_msg"
boolean hscrollbar = true
end type

event constructor;call super::constructor;This.of_SetUpdateable( False )
end event

