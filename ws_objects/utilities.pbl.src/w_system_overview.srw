$PBExportHeader$w_system_overview.srw
forward
global type w_system_overview from window
end type
type dw_1 from datawindow within w_system_overview
end type
type st_10 from statictext within w_system_overview
end type
type st_prac_inact from statictext within w_system_overview
end type
type st_exports from statictext within w_system_overview
end type
type st_reports from statictext within w_system_overview
end type
type st_views from statictext within w_system_overview
end type
type st_roles from statictext within w_system_overview
end type
type st_groups from statictext within w_system_overview
end type
type st_users from statictext within w_system_overview
end type
type st_8 from statictext within w_system_overview
end type
type st_7 from statictext within w_system_overview
end type
type st_6 from statictext within w_system_overview
end type
type st_5 from statictext within w_system_overview
end type
type st_4 from statictext within w_system_overview
end type
type st_2 from statictext within w_system_overview
end type
type st_facil from statictext within w_system_overview
end type
type st_3 from statictext within w_system_overview
end type
type st_prac_act from statictext within w_system_overview
end type
type st_1 from statictext within w_system_overview
end type
type cb_close from commandbutton within w_system_overview
end type
type cb_1 from commandbutton within w_system_overview
end type
type gb_1 from groupbox within w_system_overview
end type
type gb_2 from groupbox within w_system_overview
end type
end forward

global type w_system_overview from window
integer width = 2679
integer height = 1900
boolean titlebar = true
string title = "System Overview"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
st_10 st_10
st_prac_inact st_prac_inact
st_exports st_exports
st_reports st_reports
st_views st_views
st_roles st_roles
st_groups st_groups
st_users st_users
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_2 st_2
st_facil st_facil
st_3 st_3
st_prac_act st_prac_act
st_1 st_1
cb_close cb_close
cb_1 cb_1
gb_1 gb_1
gb_2 gb_2
end type
global w_system_overview w_system_overview

on w_system_overview.create
this.dw_1=create dw_1
this.st_10=create st_10
this.st_prac_inact=create st_prac_inact
this.st_exports=create st_exports
this.st_reports=create st_reports
this.st_views=create st_views
this.st_roles=create st_roles
this.st_groups=create st_groups
this.st_users=create st_users
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_2=create st_2
this.st_facil=create st_facil
this.st_3=create st_3
this.st_prac_act=create st_prac_act
this.st_1=create st_1
this.cb_close=create cb_close
this.cb_1=create cb_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.dw_1,&
this.st_10,&
this.st_prac_inact,&
this.st_exports,&
this.st_reports,&
this.st_views,&
this.st_roles,&
this.st_groups,&
this.st_users,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_2,&
this.st_facil,&
this.st_3,&
this.st_prac_act,&
this.st_1,&
this.cb_close,&
this.cb_1,&
this.gb_1,&
this.gb_2}
end on

on w_system_overview.destroy
destroy(this.dw_1)
destroy(this.st_10)
destroy(this.st_prac_inact)
destroy(this.st_exports)
destroy(this.st_reports)
destroy(this.st_views)
destroy(this.st_roles)
destroy(this.st_groups)
destroy(this.st_users)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_facil)
destroy(this.st_3)
destroy(this.st_prac_act)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

type dw_1 from datawindow within w_system_overview
integer x = 46
integer y = 748
integer width = 2542
integer height = 964
integer taborder = 30
string title = "none"
string dataobject = "d_system_setup"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type st_10 from statictext within w_system_overview
integer x = 439
integer y = 228
integer width = 315
integer height = 124
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Inactive Providers"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prac_inact from statictext within w_system_overview
integer x = 453
integer y = 360
integer width = 261
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_exports from statictext within w_system_overview
integer x = 457
integer y = 556
integer width = 261
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_reports from statictext within w_system_overview
integer x = 69
integer y = 556
integer width = 261
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_views from statictext within w_system_overview
integer x = 1490
integer y = 360
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_roles from statictext within w_system_overview
integer x = 1211
integer y = 360
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_groups from statictext within w_system_overview
integer x = 1211
integer y = 556
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_users from statictext within w_system_overview
integer x = 919
integer y = 360
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_8 from statictext within w_system_overview
integer x = 425
integer y = 460
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Exports"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within w_system_overview
integer x = 59
integer y = 460
integer width = 366
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "IntelliReports"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_6 from statictext within w_system_overview
integer x = 1463
integer y = 276
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Views"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within w_system_overview
integer x = 1184
integer y = 276
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Roles"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within w_system_overview
integer x = 1230
integer y = 460
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Groups"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_system_overview
integer x = 882
integer y = 276
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Users"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_facil from statictext within w_system_overview
integer x = 923
integer y = 556
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_system_overview
integer x = 923
integer y = 460
integer width = 274
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Facilities"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prac_act from statictext within w_system_overview
integer x = 82
integer y = 360
integer width = 233
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 16777215
string text = "0"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_system_overview
integer x = 50
integer y = 228
integer width = 274
integer height = 136
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Active Providers"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_system_overview
integer x = 2272
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close (parent)
end event

type cb_1 from commandbutton within w_system_overview
integer x = 1001
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;long cnt

select count(pd_affil_stat.prac_id) into :cnt from pd_affil_stat, pd_basic where pd_basic.prac_id = pd_affil_stat.prac_id and active_status in (1,4);
st_prac_act.text = string(cnt)

select count(pd_affil_stat.prac_id) into :cnt from pd_affil_stat, pd_basic where pd_basic.prac_id = pd_affil_stat.prac_id and active_status in (3);
st_prac_inact.text = string(cnt)

select count(export_id) into :cnt from export_header;
st_exports.text = string(cnt)

select count(rec_id) into :cnt from group_practice;
st_groups.text = string(cnt)

select count(role_id) into :cnt from security_roles;
st_roles.text = string(cnt)

select count(user_id) into :cnt from security_users;
st_users.text = string(cnt)

select count(data_view_id) into :cnt from data_view_screen;
st_views.text = string(cnt)

select count(facility_id) into :cnt from facility;
st_facil.text = string(cnt)

select count(view_id) into :cnt from conv_view where project_id = 99;
st_reports.text = string(cnt)
end event

type gb_1 from groupbox within w_system_overview
integer x = 27
integer y = 160
integer width = 2615
integer height = 520
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Record Counts"
end type

type gb_2 from groupbox within w_system_overview
integer x = 23
integer y = 692
integer width = 2624
integer height = 1056
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "System"
end type

