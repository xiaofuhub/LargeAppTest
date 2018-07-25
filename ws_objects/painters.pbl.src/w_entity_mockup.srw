$PBExportHeader$w_entity_mockup.srw
forward
global type w_entity_mockup from window
end type
type st_1 from statictext within w_entity_mockup
end type
type cb_8 from commandbutton within w_entity_mockup
end type
type cb_7 from commandbutton within w_entity_mockup
end type
type cb_close from commandbutton within w_entity_mockup
end type
type cb_save from commandbutton within w_entity_mockup
end type
type cb_6 from commandbutton within w_entity_mockup
end type
type cb_5 from commandbutton within w_entity_mockup
end type
type cb_4 from commandbutton within w_entity_mockup
end type
type cb_3 from commandbutton within w_entity_mockup
end type
type cb_2 from commandbutton within w_entity_mockup
end type
type cb_1 from commandbutton within w_entity_mockup
end type
type dw_detail from datawindow within w_entity_mockup
end type
type dw_browse from datawindow within w_entity_mockup
end type
type cb_lookup from commandbutton within w_entity_mockup
end type
type cb_provider from commandbutton within w_entity_mockup
end type
type cb_location from commandbutton within w_entity_mockup
end type
type cb_org from commandbutton within w_entity_mockup
end type
type cb_group from commandbutton within w_entity_mockup
end type
type cb_facility from commandbutton within w_entity_mockup
end type
end forward

global type w_entity_mockup from window
integer width = 3986
integer height = 2272
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_8 cb_8
cb_7 cb_7
cb_close cb_close
cb_save cb_save
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_detail dw_detail
dw_browse dw_browse
cb_lookup cb_lookup
cb_provider cb_provider
cb_location cb_location
cb_org cb_org
cb_group cb_group
cb_facility cb_facility
end type
global w_entity_mockup w_entity_mockup

on w_entity_mockup.create
this.st_1=create st_1
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_lookup=create cb_lookup
this.cb_provider=create cb_provider
this.cb_location=create cb_location
this.cb_org=create cb_org
this.cb_group=create cb_group
this.cb_facility=create cb_facility
this.Control[]={this.st_1,&
this.cb_8,&
this.cb_7,&
this.cb_close,&
this.cb_save,&
this.cb_6,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_detail,&
this.dw_browse,&
this.cb_lookup,&
this.cb_provider,&
this.cb_location,&
this.cb_org,&
this.cb_group,&
this.cb_facility}
end on

on w_entity_mockup.destroy
destroy(this.st_1)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_lookup)
destroy(this.cb_provider)
destroy(this.cb_location)
destroy(this.cb_org)
destroy(this.cb_group)
destroy(this.cb_facility)
end on

type st_1 from statictext within w_entity_mockup
integer x = 142
integer y = 24
integer width = 983
integer height = 84
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Not used in program"
boolean focusrectangle = false
end type

type cb_8 from commandbutton within w_entity_mockup
integer x = 1650
integer y = 24
integer width = 530
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

type cb_7 from commandbutton within w_entity_mockup
integer x = 2203
integer y = 24
integer width = 530
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

type cb_close from commandbutton within w_entity_mockup
integer x = 3319
integer y = 28
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type cb_save from commandbutton within w_entity_mockup
integer x = 2752
integer y = 24
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

type cb_6 from commandbutton within w_entity_mockup
integer x = 242
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Facility"
end type

type cb_5 from commandbutton within w_entity_mockup
integer x = 809
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Group"
end type

type cb_4 from commandbutton within w_entity_mockup
integer x = 1943
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Organization"
end type

type cb_3 from commandbutton within w_entity_mockup
integer x = 1376
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Location"
end type

type cb_2 from commandbutton within w_entity_mockup
integer x = 3077
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Provider"
end type

type cb_1 from commandbutton within w_entity_mockup
integer x = 2510
integer y = 2040
integer width = 530
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Lookup"
end type

type dw_detail from datawindow within w_entity_mockup
integer x = 146
integer y = 960
integer width = 3721
integer height = 980
integer taborder = 20
string title = "none"
string dataobject = "d_entity_lookup_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_browse from datawindow within w_entity_mockup
integer x = 146
integer y = 136
integer width = 3712
integer height = 812
integer taborder = 10
string title = "none"
string dataobject = "d_entity_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_lookup from commandbutton within w_entity_mockup
integer x = 2510
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Lookup"
end type

type cb_provider from commandbutton within w_entity_mockup
integer x = 3077
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Provider"
end type

type cb_location from commandbutton within w_entity_mockup
integer x = 1376
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Location"
end type

type cb_org from commandbutton within w_entity_mockup
integer x = 1943
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Organization"
end type

type cb_group from commandbutton within w_entity_mockup
integer x = 809
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Group"
end type

type cb_facility from commandbutton within w_entity_mockup
integer x = 242
integer y = 1944
integer width = 530
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Facility"
end type

