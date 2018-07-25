$PBExportHeader$w_dw_syntax_mod_test.srw
forward
global type w_dw_syntax_mod_test from window
end type
type cb_6 from commandbutton within w_dw_syntax_mod_test
end type
type cb_5 from commandbutton within w_dw_syntax_mod_test
end type
type cb_4 from commandbutton within w_dw_syntax_mod_test
end type
type cb_3 from commandbutton within w_dw_syntax_mod_test
end type
type cb_2 from commandbutton within w_dw_syntax_mod_test
end type
type cb_1 from commandbutton within w_dw_syntax_mod_test
end type
type dw_1 from datawindow within w_dw_syntax_mod_test
end type
end forward

global type w_dw_syntax_mod_test from window
integer width = 1797
integer height = 1932
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_dw_syntax_mod_test w_dw_syntax_mod_test

type variables
string is_sql
end variables

on w_dw_syntax_mod_test.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_dw_syntax_mod_test.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject( sqlca)
dw_1.retrieve()
end event

type cb_6 from commandbutton within w_dw_syntax_mod_test
integer x = 101
integer y = 1512
integer width = 352
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2) Modify SQL"
end type

event clicked;string ls_sql
string ls_add
string ls_statement
string ls_where
long p

ls_sql = is_sql
//ls_sql = upper(dw_1.getsqlselect( ))

p = PosA(ls_sql, "FROM",1 )

ls_add = ", cust_1 ,cust_2  	"

if p = 0 then
	p = LenA(ls_sql)
	ls_where = ""
else
	ls_where = MidA(ls_sql, p)
end if

ls_statement = MidA(ls_sql, 1, p - 1) + ls_add + ls_where

//p = dw_1.setsqlselect(ls_statement )
dw_1.Modify("DataWindow.Table.Select="+ ls_statement +"")

//if p = -1 then 
//	messagebox("","Set SQL failed")
	openwithparm(w_sql_msg,ls_statement  )
//end if


end event

type cb_5 from commandbutton within w_dw_syntax_mod_test
integer x = 1106
integer y = 1512
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Re-retrieve"
end type

event clicked;dw_1.retrieve()
end event

type cb_4 from commandbutton within w_dw_syntax_mod_test
integer x = 1339
integer y = 1636
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_3 from commandbutton within w_dw_syntax_mod_test
integer x = 101
integer y = 1628
integer width = 718
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
end type

type cb_2 from commandbutton within w_dw_syntax_mod_test
integer x = 475
integer y = 1512
integer width = 608
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "3) add the additional fields"
end type

event clicked;string ls_mod
integer i

ls_mod = ' create column(name=cust_1 visible="1" band=detail id=7 x="590" y="744" height="52" width="626" color="33554432" border="5" alignment="0" format="[general]" edit.focusrectangle=no edit.autohscroll=no edit.autoselect=no edit.autovscroll=no edit.case=any edit.codetable=no edit.displayonly=no edit.hscrollbar=no edit.imemode=0 edit.limit=0 edit.password=no edit.vscrollbar=no edit.validatecode=no edit.nilisnull=no edit.required=no criteria.required=no criteria.override_edit=no crosstab.repeat=no background.mode="2" background.color="16777215" font.charset="0" font.face="MS Sans Serif" font.family="2" font.height="-8" font.pitch="2" font.weight="400" tabsequence=70 )'
dw_1.Modify(ls_mod)
ls_mod = ' create column(name=cust_2 visible="1" band=detail id=8 x="585" y="828" height="52" width="640" color="33554432" border="5" alignment="0" format="[general]" edit.focusrectangle=no edit.autohscroll=no edit.autoselect=no edit.autovscroll=no edit.case=any edit.codetable=no edit.displayonly=no edit.hscrollbar=no edit.imemode=0 edit.limit=0 edit.password=no edit.vscrollbar=no edit.validatecode=no edit.nilisnull=no edit.required=no criteria.required=no criteria.override_edit=no crosstab.repeat=no background.mode="2" background.color="16777215" font.charset="0" font.face="MS Sans Serif" font.family="2" font.height="-8" font.pitch="2" font.weight="400" tabsequence=80 )'
dw_1.Modify(ls_mod)
ls_mod = ' create text(name=t_2 visible="1" band=detail font.charset="0" font.face="MS Sans Serif" font.family="2" font.height="-8" font.pitch="2" font.weight="400" background.mode="1" background.color="536870912" color="33554432" alignment="2" border="6" x="46" y="824" height="52" width="503" text="Custom 2" )'
dw_1.Modify(ls_mod)
ls_mod = ' create text(name=t_3 visible="1" band=detail font.charset="0" font.face="MS Sans Serif" font.family="2" font.height="-8" font.pitch="2" font.weight="400" background.mode="1" background.color="536870912" color="33554432" alignment="2" border="6" x="46" y="748" height="52" width="503" text="Custom 1" )'
dw_1.Modify(ls_mod)
end event

type cb_1 from commandbutton within w_dw_syntax_mod_test
integer x = 96
integer y = 1400
integer width = 750
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) get the sytax build the window"
end type

event clicked;string ls_syn1
string ls_syn2


ls_syn1 = dw_1.Describe("DataWindow.Syntax")

is_sql = dw_1.getsqlselect( )

openwithparm(w_sql_msg,ls_syn1  )
end event

type dw_1 from datawindow within w_dw_syntax_mod_test
integer x = 91
integer y = 56
integer width = 1518
integer height = 1280
integer taborder = 10
string title = "none"
string dataobject = "d_syntax_test"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

