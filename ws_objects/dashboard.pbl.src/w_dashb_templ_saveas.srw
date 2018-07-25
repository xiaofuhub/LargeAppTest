$PBExportHeader$w_dashb_templ_saveas.srw
forward
global type w_dashb_templ_saveas from window
end type
type cb_1 from commandbutton within w_dashb_templ_saveas
end type
type st_2 from statictext within w_dashb_templ_saveas
end type
type mle_comment from multilineedit within w_dashb_templ_saveas
end type
type st_1 from statictext within w_dashb_templ_saveas
end type
type dw_templ_list from datawindow within w_dashb_templ_saveas
end type
type cb_cancel from commandbutton within w_dashb_templ_saveas
end type
type cb_ok from commandbutton within w_dashb_templ_saveas
end type
type sle_name from singlelineedit within w_dashb_templ_saveas
end type
type gb_1 from groupbox within w_dashb_templ_saveas
end type
type gb_2 from groupbox within w_dashb_templ_saveas
end type
end forward

global type w_dashb_templ_saveas from window
integer width = 2299
integer height = 1280
boolean titlebar = true
string title = "Save Dashboard To Template"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_retrieve ( )
event ue_unselect ( )
cb_1 cb_1
st_2 st_2
mle_comment mle_comment
st_1 st_1
dw_templ_list dw_templ_list
cb_cancel cb_cancel
cb_ok cb_ok
sle_name sle_name
gb_1 gb_1
gb_2 gb_2
end type
global w_dashb_templ_saveas w_dashb_templ_saveas

event ue_retrieve();dw_templ_list.Retrieve()
Event ue_unselect()
end event

event ue_unselect();dw_templ_list.SelectRow(0,False)
sle_name.Text = ''
mle_comment.Text = ''
end event

on w_dashb_templ_saveas.create
this.cb_1=create cb_1
this.st_2=create st_2
this.mle_comment=create mle_comment
this.st_1=create st_1
this.dw_templ_list=create dw_templ_list
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.sle_name=create sle_name
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_1,&
this.st_2,&
this.mle_comment,&
this.st_1,&
this.dw_templ_list,&
this.cb_cancel,&
this.cb_ok,&
this.sle_name,&
this.gb_1,&
this.gb_2}
end on

on w_dashb_templ_saveas.destroy
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.mle_comment)
destroy(this.st_1)
destroy(this.dw_templ_list)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.sle_name)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_dashb_templ_saveas()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

dw_templ_list.SetTransObject(SQLCA)
dw_templ_list.Modify( 'Datawindow.Readonly = Yes')
Event ue_retrieve()

end event

type cb_1 from commandbutton within w_dashb_templ_saveas
integer x = 64
integer y = 1060
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;Parent.Event ue_retrieve()
end event

type st_2 from statictext within w_dashb_templ_saveas
integer x = 855
integer y = 96
integer width = 265
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Comments:"
boolean focusrectangle = false
end type

type mle_comment from multilineedit within w_dashb_templ_saveas
integer x = 1120
integer y = 80
integer width = 1088
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_dashb_templ_saveas
integer x = 69
integer y = 96
integer width = 165
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Name:"
boolean focusrectangle = false
end type

type dw_templ_list from datawindow within w_dashb_templ_saveas
integer x = 64
integer y = 312
integer width = 2144
integer height = 676
integer taborder = 30
string dataobject = "d_dashb_templates_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;String ls_name

If This.GetRow() < 1 Then Return

This.SelectRow( 0,False)
This.SelectRow( GetRow(),True)

ls_name = This.GetItemString(GetRow(),'template_name')

sle_name.Text = ls_name
end event

event clicked;This.SelectRow( 0,False)
This.SelectRow( GetRow(),True)
If Row = GetRow() Then
	This.event rowfocuschanged(GetRow())
End If
end event

type cb_cancel from commandbutton within w_dashb_templ_saveas
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
CloseWithReturn(Parent, ll_templ_id)
end event

type cb_ok from commandbutton within w_dashb_templ_saveas
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

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>cb_ok::clicked()
// $<arguments>(None)
// $<returns> long
// $<description> Create new template name.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.14.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_name
Long ll_row
long ll_templ_id,ll_templ_id_org
long ll_result,ll_exist
ls_name = sle_name.text 
If ls_name = '' Then
	Messagebox('Save As','Please input the template name.',Exclamation!)
	Return -1
End If

Select id into :ll_templ_id_org from dashboard_template where template_name = :ls_name;
ll_row = dw_templ_list.Find('template_name = "'+ls_name+'"',1,dw_templ_list.RowCount())
If ll_Row > 0 Then
	If Messagebox('Save As','The template "'+ls_name+'" already exists. Do you want to replace it?',Question!,YesNo!,2) = 2 Then Return 1
Else
	ll_row = dw_templ_list.InsertRow(0)
End If
dw_templ_list.SetItem(ll_row,'template_name',ls_name)
dw_templ_list.SetItem(ll_row,'create_user',gs_user_id)
dw_templ_list.SetItem(ll_row,'comments',mle_comment.text)

gnv_appeondb.of_autocommitrollback( )
If dw_templ_list.update() = 1 Then
	Commit;
	ll_result = 1
Else
	Rollback;
	ll_result = -1
End If

If ll_result = 1 Then
	ll_templ_id = dw_templ_list.GetItemNumber(ll_row,'id')
	CloseWithReturn(Parent, ll_templ_id)
	Return 1
Else
	//Restore data.
	dw_templ_list.Retrieve()
	Messagebox('Save Template','Failed to create the template. Please call support.',StopSign!)
	Return -1
End If

Return 1
end event

type sle_name from singlelineedit within w_dashb_templ_saveas
integer x = 233
integer y = 80
integer width = 549
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_dashb_templ_saveas
integer x = 27
integer y = 12
integer width = 2217
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "New Template:"
end type

type gb_2 from groupbox within w_dashb_templ_saveas
integer x = 27
integer y = 244
integer width = 2217
integer height = 768
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Existing Templates:"
end type

