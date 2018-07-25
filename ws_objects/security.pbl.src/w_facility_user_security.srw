$PBExportHeader$w_facility_user_security.srw
forward
global type w_facility_user_security from window
end type
type st_1 from statictext within w_facility_user_security
end type
type st_facil from statictext within w_facility_user_security
end type
type cb_cancel from commandbutton within w_facility_user_security
end type
type cb_ok from commandbutton within w_facility_user_security
end type
type dw_users from datawindow within w_facility_user_security
end type
end forward

global type w_facility_user_security from window
integer width = 1253
integer height = 2400
boolean titlebar = true
string title = "Facility Access"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
st_facil st_facil
cb_cancel cb_cancel
cb_ok cb_ok
dw_users dw_users
end type
global w_facility_user_security w_facility_user_security

type variables
str_message istr_message
string is_empty[]
end variables

on w_facility_user_security.create
this.st_1=create st_1
this.st_facil=create st_facil
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_users=create dw_users
this.Control[]={this.st_1,&
this.st_facil,&
this.cb_cancel,&
this.cb_ok,&
this.dw_users}
end on

on w_facility_user_security.destroy
destroy(this.st_1)
destroy(this.st_facil)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_users)
end on

event open;//Start Code Change ----05.25.2011 #V11 maha 
long ll_id
string ls_title
string ls_from
gs_pass_ids lst_ids

lst_ids = message.powerobjectparm

ll_id = lst_ids.l_app_id
ls_title = lst_ids.ls_ref_value
ls_from  = lst_ids.ls_from_window

If ls_from = "View" then
	dw_users.dataobject = "d_user_view_secure_select"
	this.title = "View Access"
elseif ls_from = "Facility" then 
	dw_users.dataobject = "d_user_facil_secure_select"
	this.title = "Facility Access"
end if

st_facil.text = ls_title
dw_users.SetTransObject(SQLCA)
dw_users.Retrieve(ll_id)




end event

type st_1 from statictext within w_facility_user_security
integer x = 73
integer y = 156
integer width = 827
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "WebView only users are in Red."
boolean focusrectangle = false
end type

type st_facil from statictext within w_facility_user_security
integer x = 37
integer y = 48
integer width = 1138
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Facility Name"
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_facility_user_security
integer x = 645
integer y = 2208
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_facility_user_security
integer x = 283
integer y = 2208
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;dw_users.update()

Close(Parent)
end event

type dw_users from datawindow within w_facility_user_security
integer y = 256
integer width = 1239
integer height = 1940
integer taborder = 10
string title = "none"
string dataobject = "d_user_facil_secure_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;Integer li_value
Long i,ll_cnt
If dwo.name = 'b_select' Then
	ll_cnt = dw_users.Rowcount()
	If dw_users.describe('b_select.text') = 'Select All' Then
		dw_users.Modify("b_select.text = 'Deselect All'")
		li_value = 1
	Else
		dw_users.Modify("b_select.text = 'Select All'")		
		li_value = 0
	End If
	For i = 1 To ll_cnt
		dw_users.setitem(i,"access_rights",li_value)
	Next
	
End If
end event

