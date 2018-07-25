$PBExportHeader$w_filter_hints_ir.srw
forward
global type w_filter_hints_ir from window
end type
type st_1 from statictext within w_filter_hints_ir
end type
type cb_1 from commandbutton within w_filter_hints_ir
end type
type st_13 from statictext within w_filter_hints_ir
end type
type st_9 from statictext within w_filter_hints_ir
end type
type st_12 from statictext within w_filter_hints_ir
end type
type st_11 from statictext within w_filter_hints_ir
end type
type st_17 from statictext within w_filter_hints_ir
end type
end forward

global type w_filter_hints_ir from window
integer x = 1056
integer y = 484
integer width = 2747
integer height = 1492
windowtype windowtype = response!
long backcolor = 33551856
st_1 st_1
cb_1 cb_1
st_13 st_13
st_9 st_9
st_12 st_12
st_11 st_11
st_17 st_17
end type
global w_filter_hints_ir w_filter_hints_ir

on w_filter_hints_ir.create
this.st_1=create st_1
this.cb_1=create cb_1
this.st_13=create st_13
this.st_9=create st_9
this.st_12=create st_12
this.st_11=create st_11
this.st_17=create st_17
this.Control[]={this.st_1,&
this.cb_1,&
this.st_13,&
this.st_9,&
this.st_12,&
this.st_11,&
this.st_17}
end on

on w_filter_hints_ir.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_13)
destroy(this.st_9)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_17)
end on

type st_1 from statictext within w_filter_hints_ir
integer x = 101
integer y = 944
integer width = 2533
integer height = 276
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "5) When using Board specialty information, if you want to filter on whether the practitioners are practicing or not, you must also use the Specialty Facility Link table, linking the Board Specialty>rec id field to the Specialty Facility Link>specialty id field."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_filter_hints_ir
integer x = 1120
integer y = 1352
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close(Parent)
end event

type st_13 from statictext within w_filter_hints_ir
integer x = 110
integer y = 68
integer width = 389
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Filter Hints"
boolean focusrectangle = false
end type

type st_9 from statictext within w_filter_hints_ir
integer x = 101
integer y = 208
integer width = 2533
integer height = 176
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "1) When using the v_affil_stat table you should use the active_status field, and create a filter on the filter with the active_status equal to 1."
boolean focusrectangle = false
end type

type st_12 from statictext within w_filter_hints_ir
integer x = 101
integer y = 364
integer width = 2533
integer height = 132
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) Appointment active status values History = 0, Active = 1, Purge = 2, Inactive = 3 ,Pending = 4, Midcycle = 6"
boolean focusrectangle = false
end type

type st_11 from statictext within w_filter_hints_ir
integer x = 101
integer y = 524
integer width = 2533
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "3) Any table that has active_status active is equal to 1."
boolean focusrectangle = false
end type

type st_17 from statictext within w_filter_hints_ir
integer x = 101
integer y = 620
integer width = 2533
integer height = 304
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "4) When using address information in a report, if you want to filter by an address type (primary office, home, etc.) you have to also use the address link table, linking by the address- rec_id to the v_address_link.address_id.  If you have more than one affiliation facility, you must also use the v_affil_stat table and link its facility_id to the v_address_link.facility_id"
boolean focusrectangle = false
end type

