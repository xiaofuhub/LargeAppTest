$PBExportHeader$w_committee_return_type.srw
forward
global type w_committee_return_type from window
end type
type cbx_privs from checkbox within w_committee_return_type
end type
type rb_ind from radiobutton within w_committee_return_type
end type
type rb_batch from radiobutton within w_committee_return_type
end type
type cb_2 from commandbutton within w_committee_return_type
end type
type cb_1 from commandbutton within w_committee_return_type
end type
type cbx_let from checkbox within w_committee_return_type
end type
type gb_1 from groupbox within w_committee_return_type
end type
end forward

global type w_committee_return_type from window
integer x = 987
integer y = 676
integer width = 1454
integer height = 804
boolean titlebar = true
string title = "Return from Committee ProcessType"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cbx_privs cbx_privs
rb_ind rb_ind
rb_batch rb_batch
cb_2 cb_2
cb_1 cb_1
cbx_let cbx_let
gb_1 gb_1
end type
global w_committee_return_type w_committee_return_type

type variables
long il_apprcode
end variables

on w_committee_return_type.create
this.cbx_privs=create cbx_privs
this.rb_ind=create rb_ind
this.rb_batch=create rb_batch
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cbx_let=create cbx_let
this.gb_1=create gb_1
this.Control[]={this.cbx_privs,&
this.rb_ind,&
this.rb_batch,&
this.cb_2,&
this.cb_1,&
this.cbx_let,&
this.gb_1}
end on

on w_committee_return_type.destroy
destroy(this.cbx_privs)
destroy(this.rb_ind)
destroy(this.rb_batch)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cbx_let)
destroy(this.gb_1)
end on

type cbx_privs from checkbox within w_committee_return_type
integer x = 201
integer y = 396
integer width = 910
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Update Requested Privileges"
end type

type rb_ind from radiobutton within w_committee_return_type
integer x = 846
integer y = 156
integer width = 393
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Individual  "
boolean checked = true
end type

type rb_batch from radiobutton within w_committee_return_type
integer x = 197
integer y = 156
integer width = 517
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Batch process  "
end type

type cb_2 from commandbutton within w_committee_return_type
integer x = 1065
integer y = 512
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"C")
end event

type cb_1 from commandbutton within w_committee_return_type
integer x = 795
integer y = 512
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;

string ret

if cbx_let.checked = true then
	w_action_items.ib_letters = true
else 
	w_action_items.ib_letters = false
end if

if cbx_privs.checked = true then
	w_action_items.ib_privs = true
else 
	w_action_items.ib_privs = false
end if

if rb_batch.checked = true then
	ret = "B"
else
	ret = "I"
end if

closewithreturn(parent,ret)
end event

type cbx_let from checkbox within w_committee_return_type
integer x = 201
integer y = 296
integer width = 745
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Create Approval Letters"
end type

type gb_1 from groupbox within w_committee_return_type
integer x = 87
integer y = 52
integer width = 1262
integer height = 212
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = " Select  Process Type"
end type

