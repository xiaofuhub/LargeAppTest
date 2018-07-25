$PBExportHeader$uo_peer_review.sru
forward
global type uo_peer_review from userobject
end type
type tab_1 from tab within uo_peer_review
end type
type tabpage_browse from userobject within tab_1
end type
type dw_browse from u_dw within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
dw_browse dw_browse
end type
type tabpage_detail from userobject within tab_1
end type
type cb_4 from commandbutton within tabpage_detail
end type
type cb_2 from commandbutton within tabpage_detail
end type
type dw_committee from u_dw within tabpage_detail
end type
type cb_3 from commandbutton within tabpage_detail
end type
type cb_1 from commandbutton within tabpage_detail
end type
type dw_physicians from u_dw within tabpage_detail
end type
type dw_detail from u_dw within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
cb_4 cb_4
cb_2 cb_2
dw_committee dw_committee
cb_3 cb_3
cb_1 cb_1
dw_physicians dw_physicians
dw_detail dw_detail
end type
type tabpage_ai from userobject within tab_1
end type
type tabpage_ai from userobject within tab_1
end type
type tab_1 from tab within uo_peer_review
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_ai tabpage_ai
end type
end forward

global type uo_peer_review from userobject
integer width = 3259
integer height = 1844
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_1 tab_1
end type
global uo_peer_review uo_peer_review

on uo_peer_review.create
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on uo_peer_review.destroy
destroy(this.tab_1)
end on

type tab_1 from tab within uo_peer_review
integer width = 3250
integer height = 1832
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 80269524
boolean fixedwidth = true
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
tabpage_ai tabpage_ai
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.tabpage_ai=create tabpage_ai
this.Control[]={this.tabpage_browse,&
this.tabpage_detail,&
this.tabpage_ai}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
destroy(this.tabpage_ai)
end on

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3214
integer height = 1716
long backcolor = 80269524
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
dw_browse dw_browse
end type

on tabpage_browse.create
this.dw_browse=create dw_browse
this.Control[]={this.dw_browse}
end on

on tabpage_browse.destroy
destroy(this.dw_browse)
end on

type dw_browse from u_dw within tabpage_browse
integer x = 5
integer y = 16
integer width = 3195
integer height = 1684
integer taborder = 20
string dataobject = "d_case_review_browse"
borderstyle borderstyle = stylebox!
end type

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3214
integer height = 1716
long backcolor = 80269524
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_4 cb_4
cb_2 cb_2
dw_committee dw_committee
cb_3 cb_3
cb_1 cb_1
dw_physicians dw_physicians
dw_detail dw_detail
end type

on tabpage_detail.create
this.cb_4=create cb_4
this.cb_2=create cb_2
this.dw_committee=create dw_committee
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_physicians=create dw_physicians
this.dw_detail=create dw_detail
this.Control[]={this.cb_4,&
this.cb_2,&
this.dw_committee,&
this.cb_3,&
this.cb_1,&
this.dw_physicians,&
this.dw_detail}
end on

on tabpage_detail.destroy
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.dw_committee)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_physicians)
destroy(this.dw_detail)
end on

type cb_4 from commandbutton within tabpage_detail
integer x = 2921
integer y = 1348
integer width = 215
integer height = 88
integer taborder = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

type cb_2 from commandbutton within tabpage_detail
integer x = 2921
integer y = 1252
integer width = 215
integer height = 88
integer taborder = 41
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

type dw_committee from u_dw within tabpage_detail
integer x = 87
integer y = 1252
integer width = 2811
integer height = 248
integer taborder = 11
string dataobject = "d_case_review_committee"
end type

type cb_3 from commandbutton within tabpage_detail
integer x = 1376
integer y = 632
integer width = 215
integer height = 88
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

type cb_1 from commandbutton within tabpage_detail
integer x = 1376
integer y = 536
integer width = 215
integer height = 88
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

type dw_physicians from u_dw within tabpage_detail
integer x = 73
integer y = 516
integer width = 1289
integer height = 232
integer taborder = 11
string dataobject = "d_case_review_attrib_physicians"
end type

type dw_detail from u_dw within tabpage_detail
integer x = 5
integer y = 12
integer width = 3205
integer height = 1692
integer taborder = 20
string dataobject = "d_case_review_detail"
boolean vscrollbar = false
end type

type tabpage_ai from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3214
integer height = 1716
long backcolor = 80269524
string text = "Action Items"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
end type

