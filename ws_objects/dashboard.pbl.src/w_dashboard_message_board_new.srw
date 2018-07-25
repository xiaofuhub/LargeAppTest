$PBExportHeader$w_dashboard_message_board_new.srw
forward
global type w_dashboard_message_board_new from w_main
end type
type cb_reply_all from commandbutton within w_dashboard_message_board_new
end type
type cb_reply from commandbutton within w_dashboard_message_board_new
end type
type cb_cancel from commandbutton within w_dashboard_message_board_new
end type
type cb_send from commandbutton within w_dashboard_message_board_new
end type
type mle_body from multilineedit within w_dashboard_message_board_new
end type
type sle_to from singlelineedit within w_dashboard_message_board_new
end type
type cb_to from commandbutton within w_dashboard_message_board_new
end type
end forward

global type w_dashboard_message_board_new from w_main
integer width = 1952
integer height = 1264
string title = "New Message"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event ue_send ( )
cb_reply_all cb_reply_all
cb_reply cb_reply
cb_cancel cb_cancel
cb_send cb_send
mle_body mle_body
sle_to sle_to
cb_to cb_to
end type
global w_dashboard_message_board_new w_dashboard_message_board_new

type variables
String is_send_to_roles,is_send_to_users

//str_message istr_gadget_message.sstr_message
str_gadget_message istr_gadget_message

n_ds ids_roles_users
n_ds ids_message_board

u_cst_gadget iuo_current_gadget

boolean ib_is_reply


String is_message_org
end variables

forward prototypes
public subroutine of_set_to ()
public subroutine of_insert_message (string as_user_id)
public subroutine of_set_isread ()
public subroutine of_set_status ()
end prototypes

event ue_send();Long i,j
Datetime ldt_send_date
If sle_to.Text = '' Then
	Messagebox('Message Board','There must be at least one name in the To box.',Exclamation!)
	cb_to.setfocus()
	Return
End If

If mle_body.Text = '' Then
	Messagebox('Message Board','Message is empty, please input it.',Exclamation!)
	mle_body.SetFocus()
	Return
End If

If is_message_org = mle_body.Text Then
	Messagebox('Message Board',"You haven't input any character, please input it.")
	mle_body.SetFocus()
	Return 
End If

ids_message_board.Reset()

For i = 1 To UpperBound(istr_gadget_message.sstr_message.roles[])
	ids_roles_users.SetFilter('security_roles_role_name = "'+ istr_gadget_message.sstr_message.roles[i] +'"')
	ids_roles_users.Filter()
	For j = 1 To ids_roles_users.RowCount()
		of_insert_message(ids_roles_users.GetItemString(j,'security_users_user_id'))
	Next
Next

For i = 1 To UpperBound(istr_gadget_message.sstr_message.users[])
	of_insert_message(istr_gadget_message.sstr_message.users[i])
Next

If ids_message_board.ModifiedCount() + ids_message_board.DeletedCount() > 0 Then

	//Must set the same datetime! --To Generate Sent items.
	ldt_send_date = Datetime(today(),Now())
	For i = 1 to ids_message_board.RowCount()
		ids_message_board.SetItem(i,'send_date',ldt_send_date)
	Next
	
	//Save
	gnv_appeondb.of_autocommitrollback()
	If ids_message_board.update() = 1 Then
		Commit;
	Else
		Messagebox('Error','Failed to send message, please call support.')
		Rollback;
		Return
	End If
End IF

istr_gadget_message.suo_gadget.event ue_retrieve()
istr_gadget_message.suo_gadget.iuo_tabpge_gadget.event ue_retrieve_same_gadget(istr_gadget_message.suo_gadget.classname())
istr_gadget_message.suo_gadget.iuo_tabpge_gadget.of_refresh_ui()

Close(This)
end event

public subroutine of_set_to ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard_message_board_new::of_set_to()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Set 'Receiver' by Structure var
//////////////////////////////////////////////////////////////////////
// $<add> 08.28.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long i
String ls_send_to
sle_to.Text = ''

is_send_to_roles = ''
is_send_to_users = ''

For i = 1 To UpperBound(istr_gadget_message.sstr_message.roles[])
	is_send_to_roles += istr_gadget_message.sstr_message.roles[i] + '; '
Next

For i = 1 To UpperBound(istr_gadget_message.sstr_message.users[])
	is_send_to_users += istr_gadget_message.sstr_message.users[i] + '; '
Next

ls_send_to = is_send_to_roles + is_send_to_users
sle_to.Text = MidA(ls_send_to,1,LenA(ls_send_to)-2)
end subroutine

public subroutine of_insert_message (string as_user_id);String ls_message
Long i,ll_find_row,ll_row

ll_find_row = ids_message_board.Find('user_id = "'+as_user_id+'"',1,ids_message_board.RowCount())
If ll_find_row > 0 Then Return  //Existed

ll_row = ids_message_board.InsertRow(0)
ids_message_board.SetItem(ll_row,'user_id',as_user_id)
ids_message_board.SetItem(ll_row,'message_body',mle_body.text)
ids_message_board.SetItem(ll_row,'is_read',0)
ids_message_board.SetItem(ll_row,'sender',gs_user_id)
ids_message_board.SetItem(ll_row,'send_to_roles',MidA(is_send_to_roles,1,LenA(is_send_to_roles)-2))
ids_message_board.SetItem(ll_row,'send_to_users',MidA(is_send_to_users,1,LenA(is_send_to_users)-2))

If ib_is_reply Then
	ids_message_board.SetItem(ll_row,'parent_message_id',istr_gadget_message.sstr_message.message_id )
	ids_message_board.SetItem(ll_row,'root_message_id',istr_gadget_message.sstr_message.root_message_id )
End If
//ids_message_board.SetItem(ll_row,'send_date',)  //use column default value in DB


end subroutine

public subroutine of_set_isread ();If istr_gadget_message.sstr_message.is_read = 0 Then
	istr_gadget_message.suo_gadget.dw_content.Dynamic Event ue_set_isread(istr_gadget_message.sstr_message.message_id,1)
	gnv_appeondb.of_startqueue( )
	Update dashboard_gadgets_message Set is_read = 1 where id = :istr_gadget_message.sstr_message.message_id;
	Commit;
	gnv_appeondb.of_commitqueue( )
End If
end subroutine

public subroutine of_set_status ();String ls_to,ls_message

Choose Case istr_gadget_message.sstr_message.ss_flag
	Case 'V'
		cb_reply.visible = True
		cb_reply_all.visible = True
		cb_send.visible = False
		cb_to.visible = False
		sle_to.visible = False
		mle_body.move(27,28)
		mle_body.Resize(1888,976)		
		cb_cancel.Text = '&OK'		
		This.Title = 'View Message'
		of_set_to()
		ls_to = is_send_to_roles + is_send_to_users
		ls_message = istr_gadget_message.sstr_message.message_body
		If LenA(ls_message) >= 4500 Then ls_message = MidA(ls_message,1,4000)
		ls_message = &
		'From: '+ istr_gadget_message.sstr_message.Sender + &
		'~r~nTo: ' + MidA(ls_to,1,LenA(ls_to)-2) + &
		'~r~nSent Date: '+ String(istr_gadget_message.sstr_message.send_date,'mm/dd/yyyy hh:mm:ss') + & 
		'~r~n'+'~r~n' + ls_message 
		mle_body.Text = ls_message
		is_message_org = ls_message
		mle_body.setfocus()
		mle_body.displayonly = True
		of_set_isread()
		
	Case 'R'
		ib_is_reply = True
		cb_reply.visible = False
		cb_reply_all.visible = False
		cb_send.visible = True
		cb_to.visible = True
		sle_to.visible = True
		cb_cancel.Text = '&Cancel'
		mle_body.move(27,176)
		mle_body.Resize(1888,828)
		This.Title = 'Reply Message'
		of_set_to()
		ls_to = is_send_to_roles + is_send_to_users
		ls_message = istr_gadget_message.sstr_message.message_body
		If LenA(ls_message) >= 4500 Then ls_message = MidA(ls_message,1,4000)
		ls_message = '~r~n' + '~r~n' + & 
		'----------------------------------------------------------------------------------------------------------------------------'+ &
		'~r~nFrom: '+ istr_gadget_message.sstr_message.Sender + &
		'~r~nTo: ' + MidA(ls_to,1,LenA(ls_to)-2) + &
		'~r~nSent Date: '+ String(istr_gadget_message.sstr_message.send_date,'mm/dd/yyyy hh:mm:ss') + & 
		'~r~n'+'~r~n' + ls_message 
		mle_body.Text = ls_message
		is_message_org = ls_message
		mle_body.setfocus()
		mle_body.displayonly = False
		of_set_isread()		
End Choose

/*
If istr_gadget_message.sstr_message.message_id > 0 Then
	ib_is_reply = True
End If

If ib_is_reply Then
	This.Title = 'Reply Message'
	istr_gadget_message.sstr_message = istr_gadget_message.sstr_message
	of_set_to()
	ls_to = is_send_to_roles + is_send_to_users
	ls_message = istr_gadget_message.sstr_message.message_body
	If Len(ls_message) >= 4500 Then ls_message = Mid(ls_message,1,4000)
	ls_message = '~r~n' + '~r~n' + & 
	'----------------------------------------------------------------------------------------------------------------------------'+ &
	'~r~nFrom: '+ istr_gadget_message.sstr_message.Sender + &
	'~r~nTo: ' + Mid(ls_to,1,Len(ls_to)-2) + &
	'~r~nSent Date: '+ String(istr_gadget_message.sstr_message.send_date,'mm/dd/yyyy hh:mm:ss') + & 
	'~r~n'+'~r~n' + ls_message 
	mle_body.Text = ls_message
	mle_body.setfocus()
	of_set_isread()
End If
*/
end subroutine

on w_dashboard_message_board_new.create
int iCurrent
call super::create
this.cb_reply_all=create cb_reply_all
this.cb_reply=create cb_reply
this.cb_cancel=create cb_cancel
this.cb_send=create cb_send
this.mle_body=create mle_body
this.sle_to=create sle_to
this.cb_to=create cb_to
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reply_all
this.Control[iCurrent+2]=this.cb_reply
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_send
this.Control[iCurrent+5]=this.mle_body
this.Control[iCurrent+6]=this.sle_to
this.Control[iCurrent+7]=this.cb_to
end on

on w_dashboard_message_board_new.destroy
call super::destroy
destroy(this.cb_reply_all)
destroy(this.cb_reply)
destroy(this.cb_cancel)
destroy(this.cb_send)
destroy(this.mle_body)
destroy(this.sle_to)
destroy(this.cb_to)
end on

event open;call super::open;String ls_message
String ls_to

istr_gadget_message = Message.Powerobjectparm

ids_roles_users = Create n_ds
ids_roles_users.Dataobject = 'd_roles_users'
ids_roles_users.SetTransObject(SQLCA)

ids_message_board = Create n_ds
ids_message_board.DataObject = 'd_dashb_gadget_message'
ids_message_board.SetTransObject(SQLCA)

ids_roles_users.Retrieve()
cb_to.setfocus()

of_set_status()

/*
If istr_gadget_message.sstr_message.message_id > 0 Then
	ib_is_reply = True
End If

If ib_is_reply Then
	This.Title = 'Reply Message'
	istr_gadget_message.sstr_message = istr_gadget_message.sstr_message
	of_set_to()
	ls_to = is_send_to_roles + is_send_to_users
	ls_message = istr_gadget_message.sstr_message.message_body
	If Len(ls_message) >= 4500 Then ls_message = Mid(ls_message,1,4000)
	ls_message = '~r~n' + '~r~n' + & 
	'----------------------------------------------------------------------------------------------------------------------------'+ &
	'~r~nFrom: '+ istr_gadget_message.sstr_message.Sender + &
	'~r~nTo: ' + Mid(ls_to,1,Len(ls_to)-2) + &
	'~r~nSent Date: '+ String(istr_gadget_message.sstr_message.send_date,'mm/dd/yyyy hh:mm:ss') + & 
	'~r~n'+'~r~n' + ls_message 
	mle_body.Text = ls_message
	mle_body.setfocus()
	of_set_isread()
End If
*/
end event

type cb_reply_all from commandbutton within w_dashboard_message_board_new
boolean visible = false
integer x = 398
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reply To A&ll"
end type

event clicked;String ls_empty[]
istr_gadget_message.sstr_message.ss_flag = 'R'
of_set_status()
end event

type cb_reply from commandbutton within w_dashboard_message_board_new
boolean visible = false
integer x = 37
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Reply"
end type

event clicked;String ls_empty[]
istr_gadget_message.sstr_message.ss_flag = 'R'
istr_gadget_message.sstr_message.roles[] = ls_empty[]
istr_gadget_message.sstr_message.users[] = ls_empty[]
istr_gadget_message.sstr_message.users[1] = istr_gadget_message.sstr_message.sender
of_set_status()
end event

type cb_cancel from commandbutton within w_dashboard_message_board_new
integer x = 1559
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 60
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

type cb_send from commandbutton within w_dashboard_message_board_new
integer x = 1184
integer y = 1048
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Send"
end type

event clicked;Parent.Trigger Event ue_send()
end event

type mle_body from multilineedit within w_dashboard_message_board_new
integer x = 27
integer y = 176
integer width = 1888
integer height = 828
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
integer limit = 5000
borderstyle borderstyle = stylelowered!
end type

type sle_to from singlelineedit within w_dashboard_message_board_new
integer x = 379
integer y = 44
integer width = 1536
integer height = 92
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32764915
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_to from commandbutton within w_dashboard_message_board_new
integer x = 27
integer y = 44
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&To..."
end type

event clicked;OpenwithParm(w_user_choose,istr_gadget_message.sstr_message)

If Isvalid(Message.powerobjectparm) Then
	istr_gadget_message.sstr_message = Message.powerobjectparm
	of_set_to()
End If

mle_body.setfocus( )
end event

