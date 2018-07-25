$PBExportHeader$w_app_audit_complete_mes.srw
forward
global type w_app_audit_complete_mes from window
end type
type st_app from statictext within w_app_audit_complete_mes
end type
type dw_response from datawindow within w_app_audit_complete_mes
end type
type st_ver from statictext within w_app_audit_complete_mes
end type
type cb_2 from commandbutton within w_app_audit_complete_mes
end type
type cb_1 from commandbutton within w_app_audit_complete_mes
end type
end forward

global type w_app_audit_complete_mes from window
integer width = 2039
integer height = 752
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_app st_app
dw_response dw_response
st_ver st_ver
cb_2 cb_2
cb_1 cb_1
end type
global w_app_audit_complete_mes w_app_audit_complete_mes

type variables
long il_response = 0
string is_vis //maha 060908
end variables

on w_app_audit_complete_mes.create
this.st_app=create st_app
this.dw_response=create dw_response
this.st_ver=create st_ver
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_app,&
this.dw_response,&
this.st_ver,&
this.cb_2,&
this.cb_1}
end on

on w_app_audit_complete_mes.destroy
destroy(this.st_app)
destroy(this.dw_response)
destroy(this.st_ver)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//string ls_vis //variable to determine message changed to instance variable - maha 060908
long ll_res
integer li_find
datawindowchild dwchild

is_vis = MidA(message.stringparm,1,1)
ll_res = long (MidA(message.stringparm,3))

if is_vis = "N" then //from DE
	st_app.text = "Do you want to complete the Checklist item now?"

	dw_response.visible = false
	st_ver.visible = false
else
	if is_vis = "A" then //Start Code Change ----04.08.2008 #V8 maha - from app audit comp
		st_app.text = "Do you want to complete the Verification now?"
	else //Y from DE when use as verif checked
		st_app.text = "Do you want to complete the Checklist item and Verification now?"
	end if
	dw_response.settransobject(sqlca)
	//dw_response.insertrow(1)
	dw_response.retrieve()
	dw_response.GetChild( "lookup_code", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve("Credentials Verification Response")
	dw_response.insertrow(1) //Start Code Change ----04.08.2008 #V8 maha - moved from above
	//dwchild.insertrow(1)
	il_response = ll_res //Start Code Change ----04.08.2008 #V8 maha - moved from below
	if ll_res > 0 then //set the default response if passed
		dw_response.setitem (1,"lookup_code",ll_res)
		//il_response = ll_res
	end if
end if
end event

type st_app from statictext within w_app_audit_complete_mes
integer x = 64
integer y = 128
integer width = 1829
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Do you want to complete the App Audit item now?"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_response from datawindow within w_app_audit_complete_mes
integer x = 910
integer y = 352
integer width = 997
integer height = 80
integer taborder = 10
string title = "none"
string dataobject = "d_code_lookup_only"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_response = long(data)
end event

type st_ver from statictext within w_app_audit_complete_mes
integer x = 82
integer y = 360
integer width = 814
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Verification Response Code:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_app_audit_complete_mes
integer x = 1001
integer y = 544
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "No"
end type

event clicked;Closewithreturn(parent,"N*0")
end event

type cb_1 from commandbutton within w_app_audit_complete_mes
integer x = 640
integer y = 544
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Yes"
end type

event clicked;string ls_ret
//messagebox("il_response",il_response)

if is_vis <> "N" then //Start Code Change ----05.09.2008 #V81 maha - do only is rersponse dddw is visible
	if il_response = 0 then //Start Code Change ----04.09.2008 #V8 maha - added trap for non- selected response
		messagebox("Response Code", "Please select a response code or click NO to not complete records.")
		return
	else
		ls_ret = "Y*" + string(il_response)
	end if
end if


Closewithreturn(parent,ls_ret)
end event

