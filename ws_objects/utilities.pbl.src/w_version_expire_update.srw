$PBExportHeader$w_version_expire_update.srw
forward
global type w_version_expire_update from window
end type
type cb_3 from commandbutton within w_version_expire_update
end type
type st_1 from statictext within w_version_expire_update
end type
type cb_2 from commandbutton within w_version_expire_update
end type
type cb_1 from commandbutton within w_version_expire_update
end type
type ddlb_1 from dropdownlistbox within w_version_expire_update
end type
type dw_1 from datawindow within w_version_expire_update
end type
end forward

global type w_version_expire_update from window
integer width = 1829
integer height = 900
boolean titlebar = true
string title = "Reset Version License"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_3 cb_3
st_1 st_1
cb_2 cb_2
cb_1 cb_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_version_expire_update w_version_expire_update

on w_version_expire_update.create
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.st_1,&
this.cb_2,&
this.cb_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_version_expire_update.destroy
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

type cb_3 from commandbutton within w_version_expire_update
boolean visible = false
integer x = 1285
integer y = 800
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "save"
end type

event clicked;

dw_1.update()
end event

type st_1 from statictext within w_version_expire_update
integer x = 55
integer y = 76
integer width = 1701
integer height = 268
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This is for updating the version license.  Select the number of days and click update to reset.  It will clear the Notice Date as well."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_version_expire_update
integer x = 1207
integer y = 612
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_version_expire_update
integer x = 709
integer y = 616
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;//Start Code Change ----09.09.2009 #V92 maha - poison pill reset
date ld_reset
datetime ldt_date
datetime ldt_null
integer li_days

setnull(ldt_null)

choose case ddlb_1.text
	case "30 Days"
		li_days = 30
	case "60 Days"
		li_days = 60
	case "90 Days"
		li_days = 90
	case "180 Days"
		li_days = 180
	case "240 Days"  //Start Code Change ----05.03.2012 #V12 maha
		li_days = 240	
end choose

ld_reset = relativedate(today(),li_days)

dw_1.setitem(1,"pp_date", datetime(ld_reset,now()))
dw_1.setitem(1,"pp_end", ldt_null)

dw_1.update()
end event

type ddlb_1 from dropdownlistbox within w_version_expire_update
integer x = 110
integer y = 612
integer width = 503
integer height = 324
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"30 Days","60 Days","90 Days","180 Days","240 Days"}
end type

type dw_1 from datawindow within w_version_expire_update
integer x = 55
integer y = 376
integer width = 1705
integer height = 192
integer taborder = 10
string title = "none"
string dataobject = "d_pill_reset"
boolean livescroll = true
end type

event constructor;this.settransobject( sqlca)
this.retrieve()
end event

