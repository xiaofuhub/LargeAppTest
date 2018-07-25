$PBExportHeader$w_recruit_campaigns.srw
forward
global type w_recruit_campaigns from w_master
end type
type tab_1 from tab within w_recruit_campaigns
end type
type tabpage_reports from userobject within tab_1
end type
type dw_7 from datawindow within tabpage_reports
end type
type gb_1 from groupbox within tabpage_reports
end type
type dw_reports from u_dw within tabpage_reports
end type
type tabpage_reports from userobject within tab_1
dw_7 dw_7
gb_1 gb_1
dw_reports dw_reports
end type
type tabpage_camp from userobject within tab_1
end type
type dw_6 from u_dw within tabpage_camp
end type
type dw_5 from u_dw within tabpage_camp
end type
type dw_1 from u_dw within tabpage_camp
end type
type dw_3 from u_dw within tabpage_camp
end type
type tabpage_camp from userobject within tab_1
dw_6 dw_6
dw_5 dw_5
dw_1 dw_1
dw_3 dw_3
end type
type tabpage_reqs from userobject within tab_1
end type
type dw_applicants from datawindow within tabpage_reqs
end type
type dw_4 from u_dw within tabpage_reqs
end type
type dw_req_act from u_dw within tabpage_reqs
end type
type dw_2 from u_dw within tabpage_reqs
end type
type gb_2 from groupbox within tabpage_reqs
end type
type tabpage_reqs from userobject within tab_1
dw_applicants dw_applicants
dw_4 dw_4
dw_req_act dw_req_act
dw_2 dw_2
gb_2 gb_2
end type
type tab_1 from tab within w_recruit_campaigns
tabpage_reports tabpage_reports
tabpage_camp tabpage_camp
tabpage_reqs tabpage_reqs
end type
end forward

global type w_recruit_campaigns from w_master
integer width = 4562
integer height = 2780
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
tab_1 tab_1
end type
global w_recruit_campaigns w_recruit_campaigns

on w_recruit_campaigns.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_recruit_campaigns.destroy
call super::destroy
destroy(this.tab_1)
end on

type tab_1 from tab within w_recruit_campaigns
integer width = 4453
integer height = 2628
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_reports tabpage_reports
tabpage_camp tabpage_camp
tabpage_reqs tabpage_reqs
end type

on tab_1.create
this.tabpage_reports=create tabpage_reports
this.tabpage_camp=create tabpage_camp
this.tabpage_reqs=create tabpage_reqs
this.Control[]={this.tabpage_reports,&
this.tabpage_camp,&
this.tabpage_reqs}
end on

on tab_1.destroy
destroy(this.tabpage_reports)
destroy(this.tabpage_camp)
destroy(this.tabpage_reqs)
end on

type tabpage_reports from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4416
integer height = 2512
long backcolor = 33551856
string text = "Analysis"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_7 dw_7
gb_1 gb_1
dw_reports dw_reports
end type

on tabpage_reports.create
this.dw_7=create dw_7
this.gb_1=create gb_1
this.dw_reports=create dw_reports
this.Control[]={this.dw_7,&
this.gb_1,&
this.dw_reports}
end on

on tabpage_reports.destroy
destroy(this.dw_7)
destroy(this.gb_1)
destroy(this.dw_reports)
end on

type dw_7 from datawindow within tabpage_reports
integer x = 59
integer y = 72
integer width = 1829
integer height = 92
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within tabpage_reports
integer width = 1938
integer height = 216
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Report"
end type

type dw_reports from u_dw within tabpage_reports
integer y = 240
integer width = 4411
integer height = 2272
integer taborder = 30
boolean titlebar = true
string title = "Analysis"
end type

type tabpage_camp from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4416
integer height = 2512
long backcolor = 33551856
string text = "Campaigns"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_6 dw_6
dw_5 dw_5
dw_1 dw_1
dw_3 dw_3
end type

on tabpage_camp.create
this.dw_6=create dw_6
this.dw_5=create dw_5
this.dw_1=create dw_1
this.dw_3=create dw_3
this.Control[]={this.dw_6,&
this.dw_5,&
this.dw_1,&
this.dw_3}
end on

on tabpage_camp.destroy
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.dw_1)
destroy(this.dw_3)
end on

type dw_6 from u_dw within tabpage_camp
integer x = 1682
integer y = 160
integer width = 2738
integer height = 724
integer taborder = 40
boolean titlebar = true
string title = "Positions"
end type

type dw_5 from u_dw within tabpage_camp
integer x = 1682
integer y = 884
integer width = 2729
integer height = 1628
integer taborder = 30
boolean titlebar = true
string title = "Actions"
end type

type dw_1 from u_dw within tabpage_camp
integer y = 156
integer width = 1678
integer height = 1724
integer taborder = 40
boolean titlebar = true
string title = "Campaigns"
end type

type dw_3 from u_dw within tabpage_camp
integer y = 1884
integer width = 1682
integer height = 628
integer taborder = 20
boolean titlebar = true
string title = "Detail"
end type

type tabpage_reqs from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4416
integer height = 2512
long backcolor = 33551856
string text = "Positions"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
dw_applicants dw_applicants
dw_4 dw_4
dw_req_act dw_req_act
dw_2 dw_2
gb_2 gb_2
end type

on tabpage_reqs.create
this.dw_applicants=create dw_applicants
this.dw_4=create dw_4
this.dw_req_act=create dw_req_act
this.dw_2=create dw_2
this.gb_2=create gb_2
this.Control[]={this.dw_applicants,&
this.dw_4,&
this.dw_req_act,&
this.dw_2,&
this.gb_2}
end on

on tabpage_reqs.destroy
destroy(this.dw_applicants)
destroy(this.dw_4)
destroy(this.dw_req_act)
destroy(this.dw_2)
destroy(this.gb_2)
end on

type dw_applicants from datawindow within tabpage_reqs
integer x = 23
integer y = 1280
integer width = 1801
integer height = 1224
integer taborder = 21
boolean titlebar = true
string title = "Applicants"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from u_dw within tabpage_reqs
integer x = 9
integer y = 868
integer width = 4411
integer height = 408
integer taborder = 11
boolean titlebar = true
string title = "Detail"
end type

type dw_req_act from u_dw within tabpage_reqs
integer x = 1829
integer y = 1280
integer width = 2574
integer height = 1224
integer taborder = 11
boolean titlebar = true
string title = "Actions"
end type

type dw_2 from u_dw within tabpage_reqs
integer y = 352
integer width = 4411
integer height = 512
integer taborder = 30
boolean titlebar = true
string title = "Position Requisitions"
end type

type gb_2 from groupbox within tabpage_reqs
integer x = 37
integer y = 16
integer width = 4224
integer height = 324
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Search"
end type

