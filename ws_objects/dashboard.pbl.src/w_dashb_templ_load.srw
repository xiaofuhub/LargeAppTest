$PBExportHeader$w_dashb_templ_load.srw
forward
global type w_dashb_templ_load from window
end type
type dw_templ_list from datawindow within w_dashb_templ_load
end type
type cb_cancel from commandbutton within w_dashb_templ_load
end type
type cb_ok from commandbutton within w_dashb_templ_load
end type
type gb_2 from groupbox within w_dashb_templ_load
end type
end forward

global type w_dashb_templ_load from window
integer width = 2299
integer height = 1280
boolean titlebar = true
string title = "Choose Dashboard Templates"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_templ_list dw_templ_list
cb_cancel cb_cancel
cb_ok cb_ok
gb_2 gb_2
end type
global w_dashb_templ_load w_dashb_templ_load

on w_dashb_templ_load.create
this.dw_templ_list=create dw_templ_list
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.gb_2=create gb_2
this.Control[]={this.dw_templ_list,&
this.cb_cancel,&
this.cb_ok,&
this.gb_2}
end on

on w_dashb_templ_load.destroy
destroy(this.dw_templ_list)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.gb_2)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_dashb_templ_load
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

dw_templ_list.SetTransObject(SQLCA)
dw_templ_list.Retrieve()
dw_templ_list.Modify( 'Datawindow.Readonly = Yes')
dw_templ_list.Modify( 'Datawindow.color = '+ String(RGB(255,255,255)))
If dw_templ_list.RowCount() = 0 Then
	cb_ok.enabled = False
End If
end event

type dw_templ_list from datawindow within w_dashb_templ_load
integer x = 64
integer y = 92
integer width = 2144
integer height = 904
integer taborder = 30
string dataobject = "d_dashb_templates_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;This.Selectrow(0,False)
This.Selectrow(GetRow(),True)
end event

event clicked;This.Selectrow(0,False)
This.Selectrow(GetRow(),True)
end event

event doubleclicked;cb_ok.event clicked( )
end event

type cb_cancel from commandbutton within w_dashb_templ_load
integer x = 1861
integer y = 1060
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;long ll_templ_id
ll_templ_id = -100
CloseWithReturn(Parent,ll_templ_id)
end event

type cb_ok from commandbutton within w_dashb_templ_load
integer x = 1499
integer y = 1060
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;long ll_templ_id


If dw_templ_list.GetRow() < 1 Then Return

If Messagebox('Load Template','Are you sure you want to load the dashboard template?~r~n'+ &
'If you load the dashboard template, your current dashboard settings will be replaced.',Question!,YesNo!) <> 1 Then 
	Return -1
End If

ll_templ_id = dw_templ_list.GetItemNumber(dw_templ_list.GetRow(),'id')

If Isnull(ll_templ_id) or ll_templ_id < 0 Then
	Messagebox('Load Template','Failed to get the template ID. Please call support.',StopSign!)
	Return -1
End If

CloseWithReturn(Parent,ll_templ_id)
Return 1
end event

type gb_2 from groupbox within w_dashb_templ_load
integer x = 27
integer y = 24
integer width = 2217
integer height = 996
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Existent Dashboard Templates:"
borderstyle borderstyle = stylebox!
end type

