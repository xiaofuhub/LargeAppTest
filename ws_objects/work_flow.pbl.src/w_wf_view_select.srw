$PBExportHeader$w_wf_view_select.srw
forward
global type w_wf_view_select from w_response
end type
type st_1 from statictext within w_wf_view_select
end type
type dw_view from u_dw within w_wf_view_select
end type
type cb_select from commandbutton within w_wf_view_select
end type
type cb_cancel from commandbutton within w_wf_view_select
end type
type cb_ok from commandbutton within w_wf_view_select
end type
end forward

global type w_wf_view_select from w_response
integer width = 1362
string title = "Select View"
long backcolor = 33551856
st_1 st_1
dw_view dw_view
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_wf_view_select w_wf_view_select

type variables
String is_view_list
n_cst_string inv_string

end variables

on w_wf_view_select.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_view=create dw_view
this.cb_select=create cb_select
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_view
this.Control[iCurrent+3]=this.cb_select
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
end on

on w_wf_view_select.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_view)
destroy(this.cb_select)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;//====================================================================
// Event: open
//--------------------------------------------------------------------
// Description: Select Triggered Views
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:         Ken.Guo           Date: 12/19/2012
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

Long i
Long ll_view_id
is_view_list = Message.Stringparm

dw_view.SetTransObject(SQLCA)
dw_view.Retrieve()

If dw_view.RowCount() = 0 Then
	Messagebox('Error','Failed to retrieve view data.')
	CloseWithReturn(This, 'cancel')
End If

If is_view_list = 'all' or isnull(is_view_list) Then
	cb_select.text = 'Select &All'
	cb_select.event clicked( )
Else
	For i = 1 To dw_view.RowCount()
		ll_view_id = dw_view.GetItemNumber(i, 'data_view_id')
		If Pos(is_view_list + ',', String(ll_view_id) + ',') > 0 Then
			dw_view.SetItem(i, 'selected', 1)
		End If
	Next
End If



end event

type st_1 from statictext within w_wf_view_select
integer x = 32
integer y = 1180
integer width = 1275
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Only selected view(s) can trigger work flow."
boolean focusrectangle = false
end type

type dw_view from u_dw within w_wf_view_select
integer x = 23
integer y = 12
integer width = 1289
integer height = 1144
integer taborder = 10
string dataobject = "d_select_views_choose"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_Setupdateable( False )
end event

type cb_select from commandbutton within w_wf_view_select
integer x = 23
integer y = 1272
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;//Added By Ken.Guo 12/19/2012
Long i
If This.text = 'Select &All' Then
	For i = 1 To dw_view.RowCount()
		dw_view.SetItem(i, 'selected', 1)
	Next
	This.text = 'Deselect &All'
Else
	For i = 1 To dw_view.RowCount()
		dw_view.SetItem(i, 'selected', 0)
	Next	
	This.text = 'Select &All'
End If
end event

type cb_cancel from commandbutton within w_wf_view_select
integer x = 955
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
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, 'cancel')
end event

type cb_ok from commandbutton within w_wf_view_select
integer x = 590
integer y = 1272
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Long i
String ls_view_list

If dw_view.Find('selected = 1', 1, dw_view.RowCount()) = 0 Then
	Messagebox('IntelliSoft','You need to select at least one view.')
	Return
End If

If dw_view.Find('selected = 0', 1, dw_view.RowCount()) = 0 Then
	CloseWithReturn(Parent, 'all')
	Return
End If

For i = 1 To dw_view.RowCount()
	If dw_view.GetItemNumber(i, 'selected') = 1 Then
		ls_view_list += String(dw_view.GetItemNumber(i, 'data_view_id')) + ','
	End If
Next

ls_view_list = Left(ls_view_list, Len(ls_view_list) -1 )
CloseWithReturn(Parent, ls_view_list)

end event

