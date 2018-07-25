$PBExportHeader$w_dm_option.srw
forward
global type w_dm_option from w_response
end type
type cb_cancel from commandbutton within w_dm_option
end type
type dw_1 from u_dw within w_dm_option
end type
type cb_ok from commandbutton within w_dm_option
end type
end forward

global type w_dm_option from w_response
integer width = 1687
integer height = 1096
string title = "Document Version Settings"
long backcolor = 33551856
cb_cancel cb_cancel
dw_1 dw_1
cb_ok cb_ok
end type
global w_dm_option w_dm_option

on w_dm_option.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.dw_1=create dw_1
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_ok
end on

on w_dm_option.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.dw_1)
destroy(this.cb_ok)
end on

event open;call super::open;dw_1.Retrieve()
end event

type cb_cancel from commandbutton within w_dm_option
integer x = 1248
integer y = 864
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

type dw_1 from u_dw within w_dm_option
integer x = 23
integer y = 20
integer height = 804
integer taborder = 10
string dataobject = "d_dm_option_version"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.SetTransObject(SQLCA)

end event

type cb_ok from commandbutton within w_dm_option
integer x = 878
integer y = 864
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
end type

event clicked;Integer li_ret 
li_ret = Parent.event pfc_save( )
If li_ret = 1 Then
	//Refresh Global Cache
	gnv_data.of_retrieve('icred_settings')
	gds_settings.retrieve()
	Close(Parent)
ElseIf li_ret = 0 Then
	Close(Parent)
End If
end event

