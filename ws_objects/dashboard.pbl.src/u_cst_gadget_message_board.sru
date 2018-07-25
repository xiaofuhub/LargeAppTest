$PBExportHeader$u_cst_gadget_message_board.sru
forward
global type u_cst_gadget_message_board from u_cst_gadget
end type
end forward

global type u_cst_gadget_message_board from u_cst_gadget
string tag = "u_gadget_4.Message Board"
event ue_execute ( string do_type )
end type
global u_cst_gadget_message_board u_cst_gadget_message_board

forward prototypes
public function str_message of_generate_message (long al_row)
end prototypes

event ue_execute(string do_type);str_message lstr_message
str_gadget_message lstr_gadget_message
lstr_gadget_message.suo_gadget = This

Choose Case do_type
	Case 'b_new'
		OpenwithParm(w_dashboard_message_board_new,lstr_gadget_message)
	Case 'b_receive'
		Event ue_retrieve()
		iuo_tabpge_gadget.of_refresh_ui()
	Case 'b_view'
		If dw_content.GetRow() < 1 Then Return
		lstr_message = of_generate_message(dw_content.GetRow())
		lstr_gadget_message.sstr_message = lstr_message
		lstr_gadget_message.sstr_message.ss_flag = 'V'
		OpenwithParm(w_dashboard_message_board_new,lstr_gadget_message)
	Case 'b_reply'
		If dw_content.GetRow() < 1 Then Return
		lstr_gadget_message.sstr_message.users[1] = dw_content.GetItemString(dw_content.GetRow(),'sender')
		lstr_gadget_message.sstr_message.message_body = dw_content.GetItemString(dw_content.GetRow(),'message_body')
		lstr_gadget_message.sstr_message.message_id = dw_content.GetItemNumber(dw_content.GetRow(),'id')
		If isnull(dw_content.GetItemNumber(dw_content.GetRow(),'root_message_id')) or dw_content.GetItemNumber(dw_content.GetRow(),'id') = 0 Then
			lstr_gadget_message.sstr_message.root_message_id = dw_content.GetItemNumber(dw_content.GetRow(),'id')
		Else
			lstr_gadget_message.sstr_message.root_message_id = dw_content.GetItemNumber(dw_content.GetRow(),'root_message_id')
		End If
		lstr_gadget_message.sstr_message.is_read = dw_content.GetItemNumber(dw_content.GetRow(),'is_read')
		lstr_gadget_message.sstr_message.send_date = dw_content.GetItemDateTime(dw_content.GetRow(),'send_date')
		lstr_gadget_message.sstr_message.sender = dw_content.GetItemString(dw_content.GetRow(),'sender')
		lstr_gadget_message.sstr_message.ss_flag = 'R'
		OpenwithParm(w_dashboard_message_board_new,lstr_gadget_message)
	Case 'b_reply_all'
		If dw_content.GetRow() < 1 Then Return
		lstr_message = of_generate_message(dw_content.GetRow())
		lstr_gadget_message.sstr_message = lstr_message
		lstr_gadget_message.sstr_message.ss_flag = 'R'
		OpenwithParm(w_dashboard_message_board_new,lstr_gadget_message)
	Case 'b_history'
		OpenwithParm(w_dashboard_message_board_view,This)
End Choose

end event

public function str_message of_generate_message (long al_row);//
String ls_send_to_roles,ls_send_to_users
String ls_roles[],ls_users[],ls_users_temp[]
String ls_message,ls_sender
Boolean lb_exist
Long i,ll_message_id,ll_root_message_id
Datetime ldt_send_date

n_cst_string lnv_string
str_message lstr_message
If al_row < 1 Then Return lstr_message
ls_send_to_roles = dw_content.GetItemString(al_row,'send_to_roles')
ls_send_to_users = dw_content.GetItemString(al_row,'send_to_users')
ls_sender = dw_content.GetItemString(al_row,'sender')
ll_message_id = dw_content.GetItemNumber(al_row,'id')
ldt_send_date = dw_content.GetItemDatetime(al_row,'send_date')

If isnull(dw_content.GetItemNumber(al_row,'root_message_id')) or dw_content.GetItemNumber(al_row,'id') = 0 Then
	ll_root_message_id = dw_content.GetItemNumber(al_row,'id')
Else
	ll_root_message_id = dw_content.GetItemNumber(al_row,'root_message_id')
End If

//Get Roles and users list By send data
If ls_send_to_roles <> '' And Not isnull(ls_send_to_roles) Then
	lnv_string.of_parsetoarray(ls_send_to_roles , '; ',ls_roles[])
End If
If ls_send_to_users <> '' And Not isnull(ls_send_to_users) Then
	lnv_string.of_parsetoarray(ls_send_to_users , '; ',ls_users[])
End If

//Delete owner
For i = 1 To UpperBound(ls_users[])
	If ls_users[i] = gs_user_id Then continue
	ls_users_temp[UpperBound(ls_users_temp)+1] = ls_users[i]
Next
ls_users[] = ls_users_temp[]

//Add sender to receiver list
For i = 1 To UpperBound(ls_users[])
	If ls_users[i] = ls_sender Then
		lb_exist = True
		Exit
	End If
Next
If Not lb_exist Then
	ls_users[UpperBound(ls_users[])+1] = ls_sender
End If

ls_message = dw_content.GetItemString(al_row,'message_body')
lstr_message.roles[] = ls_roles[]
lstr_message.users[] = ls_users[]
lstr_message.message_body = ls_message
lstr_message.message_id = ll_message_id
lstr_message.root_message_id = ll_root_message_id
lstr_message.send_date = ldt_send_date
lstr_message.sender = ls_sender
lstr_message.is_read = dw_content.GetItemNumber(al_row,'is_read')
Return lstr_message
end function

on u_cst_gadget_message_board.create
call super::create
end on

on u_cst_gadget_message_board.destroy
call super::destroy
end on

event ue_run;call super::ue_run;Event ue_execute('b_view')
Return 1
end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_message_board
event ue_set_isread ( long al_message_id,  integer ai_value )
string dataobject = "d_dashb_gadget_message_view"
end type

event dw_content::ue_set_isread(long al_message_id, integer ai_value);String ls_message_id
Integer li_find_row
If This.GetRow() > 0 Then
	li_find_row = This.Find('id = '+String(al_message_id),1,This.RowCount())
	If li_find_row > 0 Then
		This.SetItem(li_find_row,'is_read',ai_value)
	End If
End If
end event

event dw_content::buttonclicked;call super::buttonclicked;Event ue_execute(dwo.name)

end event

event dw_content::rowfocuschanged;call super::rowfocuschanged;If dw_content.Getrow() > 0 Then
	dw_content.SelectRow(0,False)
	dw_content.SelectRow(dw_content.Getrow(),True)
End If
end event

event dw_content::clicked;//Override Ancestor Script
If Row > 0 Then
	dw_content.SelectRow(0,False)
	dw_content.SelectRow(Row,True)
	dw_content.SetRow(Row)
	Super::Event Clicked(xpos,ypos,row,dwo)
End If
end event

event dw_content::constructor;call super::constructor;This.of_set_idle_flag( False)  //(Appeon)Harry 11.06.2014 - Alleghany program timeout issue
This.of_setupdateable(False)
end event

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_message_board
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_message_board
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_message_board
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_message_board
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_message_board
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_message_board
end type

