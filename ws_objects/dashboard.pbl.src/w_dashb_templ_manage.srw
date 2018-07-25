$PBExportHeader$w_dashb_templ_manage.srw
forward
global type w_dashb_templ_manage from window
end type
type cb_select from commandbutton within w_dashb_templ_manage
end type
type cb_refresh from commandbutton within w_dashb_templ_manage
end type
type cb_delete from commandbutton within w_dashb_templ_manage
end type
type dw_templ_list from u_dw within w_dashb_templ_manage
end type
type cb_cancel from commandbutton within w_dashb_templ_manage
end type
type gb_2 from groupbox within w_dashb_templ_manage
end type
end forward

global type w_dashb_templ_manage from window
integer width = 3186
integer height = 1676
boolean titlebar = true
string title = "Dashboard Templates Management"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_select cb_select
cb_refresh cb_refresh
cb_delete cb_delete
dw_templ_list dw_templ_list
cb_cancel cb_cancel
gb_2 gb_2
end type
global w_dashb_templ_manage w_dashb_templ_manage

type variables

end variables

on w_dashb_templ_manage.create
this.cb_select=create cb_select
this.cb_refresh=create cb_refresh
this.cb_delete=create cb_delete
this.dw_templ_list=create dw_templ_list
this.cb_cancel=create cb_cancel
this.gb_2=create gb_2
this.Control[]={this.cb_select,&
this.cb_refresh,&
this.cb_delete,&
this.dw_templ_list,&
this.cb_cancel,&
this.gb_2}
end on

on w_dashb_templ_manage.destroy
destroy(this.cb_select)
destroy(this.cb_refresh)
destroy(this.cb_delete)
destroy(this.dw_templ_list)
destroy(this.cb_cancel)
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
dw_templ_list.Modify( 'Datawindow.color = '+ String(RGB(255,255,255)))
cb_refresh.event clicked( )
end event

type cb_select from commandbutton within w_dashb_templ_manage
integer x = 50
integer y = 1456
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select All"
end type

event clicked;Long ll_cnt,i 
ll_cnt = dw_templ_list.RowCount()
If ll_cnt = 0 Then Return 1

If This.Text = '&Select All' Then
	For i = 1 To ll_cnt
		dw_templ_list.SetItem(i,'Selected',1)
	Next
	This.Text = 'De&select All'
Else
	For i = 1 To ll_cnt
		dw_templ_list.SetItem(i,'selected',0)
	Next	
	This.Text = '&Select All'
End If

end event

type cb_refresh from commandbutton within w_dashb_templ_manage
integer x = 2094
integer y = 1456
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;Long i,ll_use_cnt
dw_templ_list.Retrieve()
If dw_templ_list.RowCount() = 0 Then
	cb_delete.enabled = False
End If

For i = 1 to dw_templ_list.Rowcount()
	ll_use_cnt = dw_templ_list.GetItemNumber(i,'use_cnt')
	If ll_use_cnt > 0 Then
		dw_templ_list.SetItem(i,'Templ_Status','Being used by ' +String(ll_use_cnt) + ' user(s).')
	End If
Next

end event

type cb_delete from commandbutton within w_dashb_templ_manage
integer x = 2446
integer y = 1456
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Long ll_cnt,i,ll_templ_id
Integer li_result

ll_cnt = dw_templ_list.RowCount()
If ll_cnt = 0 Then Return 1
If dw_templ_list.GetItemNumber(ll_cnt,'exist_selected') > 0 Then
	If Messagebox('Delete','Are you sure you want to delete the selected dashboard template(s)?',Question!,YesNo!,2) = 2 Then Return 1
End If

If Not Isvalid(w_dashboard) Then
	Messagebox('Delete','You must open the dashboard window before you delete the dashboard template(s).',Exclamation!)
	Return -1
End If
SetPointer(HourGlass!)

For i = 1 To ll_cnt
	If dw_templ_list.GetItemNumber(i,'Selected') = 1 Then
		If dw_templ_list.GetItemNumber(i,'use_cnt') > 0 Then 
			dw_templ_list.SetItem(i,'Templ_Status','Template is in use and cannot be deleted.')
			Continue
		End If
		ll_templ_id = dw_templ_list.GetItemNumber(i,'id')
		li_result = w_dashboard.of_delete_template(ll_templ_id)
		If li_result > 0 Then
			dw_templ_list.SetItem(i,'Templ_Status','Deleted.')
		Else
			dw_templ_list.SetItem(i,'Templ_Status','Failed to delete. Error '+ string(li_result)+'.')
		End If
	End If
Next

end event

type dw_templ_list from u_dw within w_dashb_templ_manage
integer x = 64
integer y = 92
integer width = 3045
integer height = 1296
integer taborder = 40
string dataobject = "d_dashb_templates_selected"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;Long ll_templ_id
String ls_status
If Row > 0 Then
	If dwo.name = 'templ_status' Then
		ls_status = This.GetItemString(Row,'templ_status')
		If PosA(ls_status,'use',1) > 0 Then
			ll_templ_id = This.GetItemNumber(Row,'ID')
			OpenwithParm(w_dashb_templ_use,ll_templ_id)
		End If
	End If
End If
end event

type cb_cancel from commandbutton within w_dashb_templ_manage
integer x = 2798
integer y = 1456
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

event clicked;Close(Parent)
end event

type gb_2 from groupbox within w_dashb_templ_manage
integer x = 27
integer y = 24
integer width = 3118
integer height = 1388
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Dashboard Templates:"
end type

