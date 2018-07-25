$PBExportHeader$w_dashb_templ_use.srw
forward
global type w_dashb_templ_use from window
end type
type cb_1 from commandbutton within w_dashb_templ_use
end type
type st_1 from statictext within w_dashb_templ_use
end type
type dw_1 from datawindow within w_dashb_templ_use
end type
end forward

global type w_dashb_templ_use from window
integer width = 1079
integer height = 1064
boolean titlebar = true
string title = "Dashboard Template Use Info"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_1 st_1
dw_1 dw_1
end type
global w_dashb_templ_use w_dashb_templ_use

event open;String ls_name
Long ll_templ_id

ll_templ_id = Message.DoubleParm
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve(ll_templ_id)
dw_1.modify('Datawindow.Readonly = Yes')

If dw_1.RowCount() > 0 Then
	ls_name = dw_1.GetItemString(1,'dashboard_template_template_name')
	This.title = 'Template "'+ls_name + '"'
End If
end event

on w_dashb_templ_use.create
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.st_1,&
this.dw_1}
end on

on w_dashb_templ_use.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_dashb_templ_use
integer x = 283
integer y = 1072
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "OK"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_dashb_templ_use
integer x = 18
integer y = 28
integer width = 1157
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Below user(s) use this template on:"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_dashb_templ_use
integer x = 14
integer y = 112
integer width = 1033
integer height = 856
integer taborder = 10
string title = "none"
string dataobject = "d_dashb_template_users"
boolean vscrollbar = true
boolean livescroll = true
end type

