$PBExportHeader$w_link_question.srw
forward
global type w_link_question from window
end type
type cb_2 from commandbutton within w_link_question
end type
type cb_1 from commandbutton within w_link_question
end type
type mle_1 from multilineedit within w_link_question
end type
end forward

global type w_link_question from window
integer x = 1056
integer y = 484
integer width = 2446
integer height = 644
boolean titlebar = true
string title = "Action Item Link"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
end type
global w_link_question w_link_question

on w_link_question.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.mle_1}
end on

on w_link_question.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
end on

type cb_2 from commandbutton within w_link_question
integer x = 1157
integer y = 364
integer width = 480
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Verifying Facilty"
end type

event clicked;CloseWithReturn( Parent, "Verifying" )
end event

type cb_1 from commandbutton within w_link_question
integer x = 704
integer y = 364
integer width = 425
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Parent Facilty"
end type

event clicked;CloseWithReturn( Parent ,"Parent" )
end event

type mle_1 from multilineedit within w_link_question
integer x = 14
integer y = 76
integer width = 2473
integer height = 264
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 80269524
string text = "There are 2 possible links between V_AFFIL_STAT and V_ACTION_ITEMS that can occur.  If you are looking to get information on NPDB or Expiring Appointment action items then click on the PARENT FACILITY button otherwise, click on the VERIFICATION BUTTON"
boolean border = false
end type

