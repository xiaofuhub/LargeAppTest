$PBExportHeader$w_wf_ctx_status_select.srw
forward
global type w_wf_ctx_status_select from w_response
end type
type st_1 from statictext within w_wf_ctx_status_select
end type
type dw_view from u_dw within w_wf_ctx_status_select
end type
type cb_select from commandbutton within w_wf_ctx_status_select
end type
type cb_cancel from commandbutton within w_wf_ctx_status_select
end type
type cb_ok from commandbutton within w_wf_ctx_status_select
end type
end forward

global type w_wf_ctx_status_select from w_response
integer width = 1362
string title = "Select CTX Status"
long backcolor = 33551856
st_1 st_1
dw_view dw_view
cb_select cb_select
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_wf_ctx_status_select w_wf_ctx_status_select

type variables
String is_status_list


end variables

on w_wf_ctx_status_select.create
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

on w_wf_ctx_status_select.destroy
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
// Description: Select Triggered Status
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
Long ll_lookup_code
is_status_list = Message.Stringparm

dw_view.SetTransObject(SQLCA)
dw_view.Retrieve()

If dw_view.RowCount() = 0 Then
	Messagebox('Error','Failed to retrieve CTX status data.')
	CloseWithReturn(This, 'cancel')
End If

If is_status_list = 'all' or isnull(is_status_list) Then
	cb_select.text = 'Select &All'
	cb_select.event clicked( )
Else
	For i = 1 To dw_view.RowCount()
		ll_lookup_code = dw_view.GetItemNumber(i, 'lookup_code')
		If Pos(is_status_list + ',', String(ll_lookup_code) + ',') > 0 Then
			dw_view.SetItem(i, 'selected', 1)
		End If
	Next
End If



end event

type st_1 from statictext within w_wf_ctx_status_select
integer x = 32
integer y = 1176
integer width = 1307
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Only selected contract status(es) can trigger work flow."
boolean focusrectangle = false
end type

type dw_view from u_dw within w_wf_ctx_status_select
integer x = 23
integer y = 12
integer width = 1289
integer height = 1136
integer taborder = 10
string dataobject = "d_ctx_status_choose"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_Setupdateable( False )
end event

type cb_select from commandbutton within w_wf_ctx_status_select
integer x = 23
integer y = 1280
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

type cb_cancel from commandbutton within w_wf_ctx_status_select
integer x = 955
integer y = 1280
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

type cb_ok from commandbutton within w_wf_ctx_status_select
integer x = 590
integer y = 1280
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
String ls_lookup_code_list

If dw_view.Find('selected = 1', 1, dw_view.RowCount()) = 0 Then
	Messagebox('IntelliSoft','You need to select at least one CTX status.')
	Return
End If

If dw_view.Find('selected = 0', 1, dw_view.RowCount()) = 0 Then
	CloseWithReturn(Parent, 'all')
	Return
End If

For i = 1 To dw_view.RowCount()
	If dw_view.GetItemNumber(i, 'selected') = 1 Then
		ls_lookup_code_list += String(dw_view.GetItemNumber(i, 'lookup_code')) + ','
	End If
Next

ls_lookup_code_list = Left(ls_lookup_code_list, Len(ls_lookup_code_list) -1 )
CloseWithReturn(Parent, ls_lookup_code_list)

end event

