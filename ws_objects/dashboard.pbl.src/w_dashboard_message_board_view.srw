$PBExportHeader$w_dashboard_message_board_view.srw
forward
global type w_dashboard_message_board_view from w_main
end type
type st_row_num from statictext within w_dashboard_message_board_view
end type
type st_1 from statictext within w_dashboard_message_board_view
end type
type mle_body from multilineedit within w_dashboard_message_board_view
end type
type cb_select from commandbutton within w_dashboard_message_board_view
end type
type cb_delete from commandbutton within w_dashboard_message_board_view
end type
type cb_ok from commandbutton within w_dashboard_message_board_view
end type
type dw_list from datawindow within w_dashboard_message_board_view
end type
type rb_sent from radiobutton within w_dashboard_message_board_view
end type
type rb_in from radiobutton within w_dashboard_message_board_view
end type
type gb_1 from groupbox within w_dashboard_message_board_view
end type
type gb_2 from groupbox within w_dashboard_message_board_view
end type
type gb_3 from groupbox within w_dashboard_message_board_view
end type
end forward

global type w_dashboard_message_board_view from w_main
integer width = 2761
integer height = 1892
string title = "Message Board Browse"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
event type integer ue_save ( )
st_row_num st_row_num
st_1 st_1
mle_body mle_body
cb_select cb_select
cb_delete cb_delete
cb_ok cb_ok
dw_list dw_list
rb_sent rb_sent
rb_in rb_in
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_dashboard_message_board_view w_dashboard_message_board_view

type variables
u_cst_gadget iuo_gadget
end variables

event type integer ue_save();If dw_list.Modifiedcount() > 0 Then 
	gnv_appeondb.of_autocommitrollback( )
	If dw_list.Update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Save error',"Failed to save message's status, please call support.")
		dw_list.Retrieve(gs_user_id)
		Return -1
	End If
	iuo_gadget.event ue_retrieve( )
End If

Return 1

end event

on w_dashboard_message_board_view.create
int iCurrent
call super::create
this.st_row_num=create st_row_num
this.st_1=create st_1
this.mle_body=create mle_body
this.cb_select=create cb_select
this.cb_delete=create cb_delete
this.cb_ok=create cb_ok
this.dw_list=create dw_list
this.rb_sent=create rb_sent
this.rb_in=create rb_in
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_row_num
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.mle_body
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_ok
this.Control[iCurrent+7]=this.dw_list
this.Control[iCurrent+8]=this.rb_sent
this.Control[iCurrent+9]=this.rb_in
this.Control[iCurrent+10]=this.gb_1
this.Control[iCurrent+11]=this.gb_2
this.Control[iCurrent+12]=this.gb_3
end on

on w_dashboard_message_board_view.destroy
call super::destroy
destroy(this.st_row_num)
destroy(this.st_1)
destroy(this.mle_body)
destroy(this.cb_select)
destroy(this.cb_delete)
destroy(this.cb_ok)
destroy(this.dw_list)
destroy(this.rb_sent)
destroy(this.rb_in)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;call super::open;If isvalid(message.powerobjectparm) Then
	iuo_gadget = message.powerobjectparm
End If

rb_in.Post Event clicked( )
end event

event closequery;//Override Ancestor Script
end event

event timer;call super::timer;Integer li_isread
If dw_list.GetRow() < 1 Then Return 0
If rb_in.checked = False Then Return 0

li_isread = dw_list.GetItemNumber(dw_list.GetRow(),'is_read')
If li_isread = 1 Then 
	Return 0
Else
	dw_list.SetItem(dw_list.GetRow(),'is_read',1)
End If


end event

type st_row_num from statictext within w_dashboard_message_board_view
integer x = 2226
integer y = 148
integer width = 352
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_dashboard_message_board_view
integer y = 912
integer width = 2903
integer height = 24
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string pointer = "Arrow!"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type mle_body from multilineedit within w_dashboard_message_board_view
integer x = 69
integer y = 1016
integer width = 2610
integer height = 588
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean displayonly = true
end type

type cb_select from commandbutton within w_dashboard_message_board_view
integer x = 59
integer y = 1680
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

event clicked;Long i, ll_cnt
Integer li_value0[],li_value1[]

//Only for Inbox browse

ll_cnt = dw_list.Rowcount() 
If ll_cnt < 1 Then Return
If dw_list.dataobject <> 'd_dashb_gadget_message_in_list' Then Return

For i = 1 To ll_cnt
	li_value0[i] = 0
	li_value1[i] = 1	
Next

If This.Text = '&Select All' Then
	This.Text = '&Deselect All'
	dw_list.object.selected[1,ll_cnt] = li_value1[]
Else
	This.Text = '&Select All'
	dw_list.object.selected[1,ll_cnt] = li_value0[]	
End If


end event

type cb_delete from commandbutton within w_dashboard_message_board_view
integer x = 439
integer y = 1680
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Integer li_ret
Long i,ll_cnt

ll_cnt = dw_list.RowCount()
If ll_cnt < 1 Then Return
If dw_list.GetItemNumber(ll_cnt,'selected_cnt') > 0 Then
	If Messagebox('Delete','Are you sure you want to delete the seleced message?',question!,yesno!) = 1 Then
		For i = ll_cnt To 1 Step -1
			If dw_list.GetItemNumber(i,'selected') = 1 Then
				dw_list.DeleteRow(i)
			End If
		Next
	End If
	gnv_appeondb.of_autocommitrollback()
	If dw_list.update() = 1 Then
		Commit;
		If isvalid(iuo_gadget) Then
			iuo_gadget.iuo_tabpge_gadget.event ue_retrieve_same_gadget(iuo_gadget.classname())
		End If
	Else
		Rollback;
		Messagebox('Delete Error','Failed to delete the message, please call support.')
	End If
End If

This.Setfocus()
This.bringtotop = True
If dw_list.GetRow() > 0 Then
	dw_list.event rowfocuschanged(dw_list.GetRow())
End If
end event

type cb_ok from commandbutton within w_dashboard_message_board_view
integer x = 2350
integer y = 1680
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Parent.event ue_save( )
Close(Parent)
end event

type dw_list from datawindow within w_dashboard_message_board_view
integer x = 69
integer y = 260
integer width = 2610
integer height = 592
integer taborder = 30
string title = "none"
string dataobject = "d_dashb_gadget_message_in_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;String ls_to,ls_sender,ls_message
long ll_row
Datetime ldt_sent_date

ll_row = GetRow()
If ll_row > 0 Then
	Timer(0)
	Timer(2)
	dw_list.SelectRow(0,False)
	dw_list.SelectRow(ll_row,True)
	st_row_num.Text = String(ll_row) + '/' + String(This.RowCount())
	ls_to = dw_list.GetItemString(ll_row,'To')
	ls_sender = dw_list.GetItemString(ll_row,'Sender')
	ldt_sent_date = dw_list.GetItemDatetime(ll_row,'send_date')
	ls_message = dw_list.GetItemString(ll_row,'Message_body')
	ls_message = &
	'From: '+ ls_sender + &
	'~r~nTo: ' + ls_to + &
	'~r~nSent Date: '+ String(ldt_sent_date,'mm/dd/yyyy hh:mm:ss') + & 
	'~r~n'+'~r~n' + ls_message 
	mle_body.Text = ls_message		
Else  //Bug #4984 -Dashboard-Message Board: After deleting the last message, the message body is still visible
	mle_body.Text = ""
End If
end event

event clicked;If Row > 0 Then
	dw_list.SelectRow(0,False)
	dw_list.SelectRow(Row,True)
	dw_list.Scrolltorow(Row)
	dw_list.SetRow(Row)
End If
end event

event retrieveend;//Added by Appeon long.zhang 12.21.2015 (V14.2 Applause Cycle 2 Cosmetic Bug #4904 - Dashboard>>Message - Message body in sent items still appears under inbox)
If this.RowCount() < 1 Then mle_body.Text = ''
end event

type rb_sent from radiobutton within w_dashboard_message_board_view
integer x = 325
integer y = 68
integer width = 306
integer height = 64
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sent Item"
end type

event clicked;dw_list.dataobject = 'd_dashb_gadget_message_send_list'
dw_list.SetTransObject(SQLCA)
dw_list.Retrieve(gs_user_id)

cb_select.enabled = False
cb_delete.enabled = False

end event

type rb_in from radiobutton within w_dashboard_message_board_view
integer x = 87
integer y = 68
integer width = 343
integer height = 64
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Inbox"
boolean checked = true
end type

event clicked;dw_list.dataobject = 'd_dashb_gadget_message_in_list'
dw_list.SetTransObject(SQLCA)
dw_list.Retrieve(gs_user_id)

cb_select.enabled = True
cb_delete.enabled = True
end event

type gb_1 from groupbox within w_dashboard_message_board_view
integer x = 23
integer y = 956
integer width = 2702
integer height = 692
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Message Body"
end type

type gb_2 from groupbox within w_dashboard_message_board_view
integer x = 27
integer width = 645
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Type"
end type

type gb_3 from groupbox within w_dashboard_message_board_view
integer x = 23
integer y = 196
integer width = 2702
integer height = 696
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Message List"
end type

