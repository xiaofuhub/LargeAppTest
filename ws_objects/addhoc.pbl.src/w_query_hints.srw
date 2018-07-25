$PBExportHeader$w_query_hints.srw
forward
global type w_query_hints from window
end type
type st_1 from statictext within w_query_hints
end type
type cb_1 from commandbutton within w_query_hints
end type
type st_13 from statictext within w_query_hints
end type
type st_7 from statictext within w_query_hints
end type
type st_8 from statictext within w_query_hints
end type
type st_9 from statictext within w_query_hints
end type
type st_12 from statictext within w_query_hints
end type
type st_11 from statictext within w_query_hints
end type
type st_17 from statictext within w_query_hints
end type
type st_14 from statictext within w_query_hints
end type
type st_10 from statictext within w_query_hints
end type
type st_16 from statictext within w_query_hints
end type
end forward

global type w_query_hints from window
integer x = 1056
integer y = 484
integer width = 2747
integer height = 1984
boolean titlebar = true
string title = "Query Hints"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_1 st_1
cb_1 cb_1
st_13 st_13
st_7 st_7
st_8 st_8
st_9 st_9
st_12 st_12
st_11 st_11
st_17 st_17
st_14 st_14
st_10 st_10
st_16 st_16
end type
global w_query_hints w_query_hints

on w_query_hints.create
this.st_1=create st_1
this.cb_1=create cb_1
this.st_13=create st_13
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_12=create st_12
this.st_11=create st_11
this.st_17=create st_17
this.st_14=create st_14
this.st_10=create st_10
this.st_16=create st_16
this.Control[]={this.st_1,&
this.cb_1,&
this.st_13,&
this.st_7,&
this.st_8,&
this.st_9,&
this.st_12,&
this.st_11,&
this.st_17,&
this.st_14,&
this.st_10,&
this.st_16}
end on

on w_query_hints.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.st_13)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_17)
destroy(this.st_14)
destroy(this.st_10)
destroy(this.st_16)
end on

type st_1 from statictext within w_query_hints
integer x = 101
integer y = 1444
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
string text = "8) When using Board specialty information, if you want to filter on whether the practitioners are practicing or not, you must also use the Specialty Facility Link table, linking the Board Specialty>rec id field to the Specialty Facility Link>specialty id field."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_query_hints
integer x = 1147
integer y = 1748
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

type st_13 from statictext within w_query_hints
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
string text = "Query Hints"
boolean focusrectangle = false
end type

type st_7 from statictext within w_query_hints
integer x = 101
integer y = 168
integer width = 2533
integer height = 72
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
string text = "1) If you want any report to have facility data you must use the v_affil_stat table in the query."
boolean focusrectangle = false
end type

type st_8 from statictext within w_query_hints
integer x = 101
integer y = 268
integer width = 2533
integer height = 136
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
string text = "2) When using the v_affil_dept or v_affil_staff_cat tables, they should be linked to the v_affil_stat table by the rec_id."
boolean focusrectangle = false
end type

type st_9 from statictext within w_query_hints
integer x = 101
integer y = 428
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
string text = "3) When using the v_affil_stat table you should use the active_status field, and create a filter on the filter with the active_status equal to 1."
boolean focusrectangle = false
end type

type st_12 from statictext within w_query_hints
integer x = 101
integer y = 596
integer width = 2533
integer height = 88
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
string text = "4) Appointment active status values History = 0, Active = 1, Purge = 2, Inactive = 3 ,Pending = 4"
boolean focusrectangle = false
end type

type st_11 from statictext within w_query_hints
integer x = 101
integer y = 692
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
string text = "5) Any table that has active_status active is equal to 1."
boolean focusrectangle = false
end type

type st_17 from statictext within w_query_hints
integer x = 101
integer y = 1128
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
string text = "7) When using address information in a report, if you want to filter by an address type (primary office, home, etc.) you have to also use the address link table, linking by the address- rec_id to the v_address_link.address_id.  If you have more than one affiliation facility, you must also use the v_affil_stat table and link its facility_id to the v_address_link.facility_id"
boolean focusrectangle = false
end type

type st_14 from statictext within w_query_hints
integer x = 101
integer y = 920
integer width = 2533
integer height = 160
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
string text = "For NPDB  and Expiring Appointment Letter Verifications the facility is the the parent facility from affiliation status"
boolean focusrectangle = false
end type

type st_10 from statictext within w_query_hints
integer x = 101
integer y = 776
integer width = 2533
integer height = 168
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "6) When using the v_verif_info table, if also using the v_affil_stat table there should be a link between the two tables as follows:"
boolean focusrectangle = false
end type

type st_16 from statictext within w_query_hints
integer x = 101
integer y = 1052
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
string text = "For other verifications, the facility is the verifying facility from affiliation status."
boolean focusrectangle = false
end type

