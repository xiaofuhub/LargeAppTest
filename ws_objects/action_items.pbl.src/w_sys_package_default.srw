$PBExportHeader$w_sys_package_default.srw
forward
global type w_sys_package_default from window
end type
type cb_close from commandbutton within w_sys_package_default
end type
type cb_ok from commandbutton within w_sys_package_default
end type
type dw_1 from datawindow within w_sys_package_default
end type
end forward

global type w_sys_package_default from window
integer width = 1536
integer height = 1472
boolean titlebar = true
string title = "Zip Package Defaults"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
cb_ok cb_ok
dw_1 dw_1
end type
global w_sys_package_default w_sys_package_default

on w_sys_package_default.create
this.cb_close=create cb_close
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.Control[]={this.cb_close,&
this.cb_ok,&
this.dw_1}
end on

on w_sys_package_default.destroy
destroy(this.cb_close)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.10.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
//Start Code Change ----04.18.2013 #V12 maha - for mockup
integer r
datawindowchild ldwc_1

dw_1.settransobject(sqlca)
r = dw_1.retrieve()
dw_1.getchild("app_id", ldwc_1)
ldwc_1.insertrow(1)

if r = 0 then
	dw_1.insertrow(1)	
	dw_1.setitem(1,"inc_application",1)
	dw_1.setitem(1,"inc_images",1)
	dw_1.setitem(1,"inc_profile",1)
	dw_1.setitem(1,"inc_ver_profile",1)
	dw_1.setitem(1,"inc_check_report",1)
	dw_1.setitem(1,"inc_file_path",1)
	dw_1.setitem(1,"inc_verif_images",1)
	dw_1.setitem(1,"pack_id",1)
	dw_1.update()
end if
end event

type cb_close from commandbutton within w_sys_package_default
integer x = 704
integer y = 1272
integer width = 343
integer height = 92
integer taborder = 30
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

type cb_ok from commandbutton within w_sys_package_default
integer x = 352
integer y = 1272
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;dw_1.update()
close(parent)
end event

type dw_1 from datawindow within w_sys_package_default
integer x = 32
integer y = 32
integer width = 1435
integer height = 1200
integer taborder = 10
string title = "none"
string dataobject = "d_sys_package_default"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 09.18.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long ll_null

setnull(ll_null)
if dwo.name = "inc_application" then
	if data = '0' then
		this.setitem(1, "app_id", ll_null)
	end if
end if
end event

