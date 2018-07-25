$PBExportHeader$w_user_choose.srw
forward
global type w_user_choose from window
end type
type cb_cancel from commandbutton within w_user_choose
end type
type cb_ok from commandbutton within w_user_choose
end type
type dw_users from datawindow within w_user_choose
end type
end forward

global type w_user_choose from window
integer width = 978
integer height = 1588
boolean titlebar = true
string title = "Select Roles/Users"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_cancel cb_cancel
cb_ok cb_ok
dw_users dw_users
end type
global w_user_choose w_user_choose

type variables
str_message istr_message
string is_empty[]
end variables

forward prototypes
public subroutine of_set_status ()
end prototypes

public subroutine of_set_status ();Long i,ll_cnt,ll_find_row

ll_cnt = dw_users.RowCount()
For i = 1 To UpperBound(istr_message.Roles[])
	ll_find_row = dw_users.Find('to_type = "R" and to_name = "'+istr_message.Roles[i]+'"',1,ll_cnt)
	If ll_find_row > 0 Then
		dw_users.SetItem(ll_find_row,'selected',1)
	End If
Next

For i = 1 To UpperBound(istr_message.Users[])
	ll_find_row = dw_users.Find('to_type = "U" and to_name = "'+istr_message.Users[i]+'"',1,ll_cnt)
	If ll_find_row > 0 Then
		dw_users.SetItem(ll_find_row,'selected',1)
	End If	
Next

dw_users.ResetUpdate()



end subroutine

on w_user_choose.create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_users=create dw_users
this.Control[]={this.cb_cancel,&
this.cb_ok,&
this.dw_users}
end on

on w_user_choose.destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_users)
end on

event open;dw_users.SetTransObject(SQLCA)
dw_users.Retrieve()

If Isvalid(Message.powerobjectparm) Then
	istr_message = Message.powerobjectparm
	of_set_status()
End If


end event

type cb_cancel from commandbutton within w_user_choose
integer x = 512
integer y = 1380
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

type cb_ok from commandbutton within w_user_choose
integer x = 110
integer y = 1380
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

event clicked;Long i
If dw_users.Modifiedcount() > 0 Then
	istr_message.roles[] = is_empty[] //Reset at first
	istr_message.users[] = is_empty[]
	For i = 1 To dw_users.Rowcount()
		If dw_users.GetItemNumber(i,'Selected') = 1 Then
			If dw_users.GetItemString(i,'to_type') = 'R' Then
				istr_message.roles[UpperBound(istr_message.roles[])+1] = dw_users.GetItemString(i,'to_name')
			Else
				istr_message.users[UpperBound(istr_message.users[])+1] = dw_users.GetItemString(i,'to_name')
			End If
		End If
	Next
End If

ClosewithReturn(Parent,istr_message)
end event

type dw_users from datawindow within w_user_choose
integer x = 23
integer y = 20
integer width = 928
integer height = 1312
integer taborder = 10
string title = "none"
string dataobject = "d_user_choose"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;Integer li_value_1[],li_value_0[]
Long i,ll_cnt
If dwo.name = 'b_select' Then
	ll_cnt = dw_users.Rowcount()
	For i = 1 To ll_cnt
		li_value_1[i] = 1
		li_value_0[i] = 0
	Next
	If dw_users.describe('b_select.text') = 'Select All' Then
		dw_users.Modify("b_select.text = 'Deselect All'")
		dw_users.object.selected[1,ll_cnt] = li_value_1[]
	Else
		dw_users.Modify("b_select.text = 'Select All'")		
		dw_users.object.selected[1,ll_cnt] = li_value_0[]
	End If
End If
end event

