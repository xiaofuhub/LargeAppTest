$PBExportHeader$w_attest_quest_sync_utility.srw
forward
global type w_attest_quest_sync_utility from window
end type
type dw_1 from datawindow within w_attest_quest_sync_utility
end type
type cb_close from commandbutton within w_attest_quest_sync_utility
end type
type cb_1 from commandbutton within w_attest_quest_sync_utility
end type
end forward

global type w_attest_quest_sync_utility from window
integer width = 1979
integer height = 1832
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_close cb_close
cb_1 cb_1
end type
global w_attest_quest_sync_utility w_attest_quest_sync_utility

event open;long i

dw_1.settransobject(sqlca)
i = dw_1.retrieve()

if i = 0 then
	messagebox("Data Sync Utility","There were no Attestation Question records found with the Facility_Id out of sync .")
	close(this)
end if
end event

on w_attest_quest_sync_utility.create
this.dw_1=create dw_1
this.cb_close=create cb_close
this.cb_1=create cb_1
this.Control[]={this.dw_1,&
this.cb_close,&
this.cb_1}
end on

on w_attest_quest_sync_utility.destroy
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.cb_1)
end on

type dw_1 from datawindow within w_attest_quest_sync_utility
integer x = 41
integer y = 140
integer width = 1838
integer height = 1480
integer taborder = 30
string title = "none"
string dataobject = "d_attest_quest_sync"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_close from commandbutton within w_attest_quest_sync_utility
integer x = 1527
integer y = 20
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_1 from commandbutton within w_attest_quest_sync_utility
integer x = 1166
integer y = 20
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;long i 
long f

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"facility_id",dw_1.getitemnumber(i,"parent_facility_id"))
next

dw_1.update()
commit using sqlca;
end event

