$PBExportHeader$w_batch_update_alarm_create_ai.srw
forward
global type w_batch_update_alarm_create_ai from w_response
end type
type st_info from statictext within w_batch_update_alarm_create_ai
end type
type mle_2 from multilineedit within w_batch_update_alarm_create_ai
end type
type mle_1 from multilineedit within w_batch_update_alarm_create_ai
end type
type cb_select from commandbutton within w_batch_update_alarm_create_ai
end type
type cb_close from commandbutton within w_batch_update_alarm_create_ai
end type
type cb_update from commandbutton within w_batch_update_alarm_create_ai
end type
type dw_1 from u_dw within w_batch_update_alarm_create_ai
end type
end forward

global type w_batch_update_alarm_create_ai from w_response
integer width = 1938
integer height = 1660
string title = "Batch Update Create Action Item"
long backcolor = 33551856
st_info st_info
mle_2 mle_2
mle_1 mle_1
cb_select cb_select
cb_close cb_close
cb_update cb_update
dw_1 dw_1
end type
global w_batch_update_alarm_create_ai w_batch_update_alarm_create_ai

forward prototypes
public subroutine of_setinfo (string as_info)
end prototypes

public subroutine of_setinfo (string as_info);st_info.text = as_info

end subroutine

event open;call super::open;dw_1.Modify("create_action.visible = '0'")
dw_1.Modify("selected_t.text = 'Select'")

dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

end event

on w_batch_update_alarm_create_ai.create
int iCurrent
call super::create
this.st_info=create st_info
this.mle_2=create mle_2
this.mle_1=create mle_1
this.cb_select=create cb_select
this.cb_close=create cb_close
this.cb_update=create cb_update
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_info
this.Control[iCurrent+2]=this.mle_2
this.Control[iCurrent+3]=this.mle_1
this.Control[iCurrent+4]=this.cb_select
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.dw_1
end on

on w_batch_update_alarm_create_ai.destroy
call super::destroy
destroy(this.st_info)
destroy(this.mle_2)
destroy(this.mle_1)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.cb_update)
destroy(this.dw_1)
end on

type st_info from statictext within w_batch_update_alarm_create_ai
integer x = 425
integer y = 1480
integer width = 453
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean focusrectangle = false
end type

type mle_2 from multilineedit within w_batch_update_alarm_create_ai
integer x = 32
integer y = 192
integer width = 1856
integer height = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Please select one or several users, and then click Update button. It will automatically check the Create Action Item in all Date Alarm associated with the user(s) if their email addresses are in the Users To Notify column."
boolean border = false
end type

type mle_1 from multilineedit within w_batch_update_alarm_create_ai
integer x = 32
integer y = 20
integer width = 1838
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "This function is intended to be used to fix the data error caused by the bug in System -> User ID Batch Update in previous versions, which could mistakenly uncheck the Create Action Item for the user in Date Alarm."
boolean border = false
boolean displayonly = true
end type

type cb_select from commandbutton within w_batch_update_alarm_create_ai
integer x = 37
integer y = 1460
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All"
end type

event clicked;long ll_Row,i

if this.Text = "Select &All" then
	this.Text = "Deselect &All"
	For i = 1 To dw_1.Rowcount()
		dw_1.Setitem(i,'Selected',1)
	Next
else
	this.Text = "Select &All"
	For i = 1 To dw_1.Rowcount()
		dw_1.Setitem(i,'Selected',0)
	Next	
end if



end event

type cb_close from commandbutton within w_batch_update_alarm_create_ai
integer x = 1550
integer y = 1460
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_update from commandbutton within w_batch_update_alarm_create_ai
integer x = 1189
integer y = 1460
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;Long i,j, ll_cnt,ll_current
String ls_user_email, ls_user_id
String ls_alarm_emails,ls_alarm_create

//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//n_cst_update_data lnv_update_data
//lnv_update_data = Create n_cst_update_data
n_cst_update_data_clx lnv_update_data
lnv_update_data = Create n_cst_update_data_clx
//---------End Modfiied ------------------------------------------------------

For i = 1 To dw_1.RowCount()
	If dw_1.GetItemNumber(i, 'Selected') = 1 Then ll_cnt++
Next

If ll_cnt = 0 Then Return

For i = 1 To dw_1.RowCount()
	If dw_1.GetItemNumber(i, 'Selected') = 0 Then Continue
	ll_current++
	Parent.of_setinfo(String(Ceiling ((ll_current/ll_cnt*100))) + '%' +   ' Updating...'  )
	ls_user_id = dw_1.GetItemString(i, 'user_id')
	ls_user_email = dw_1.GetItemString(i, 'email_id')
	
	lnv_update_data.of_fix_alarm_create_action(ls_user_id,ls_user_email )

Next
Parent.of_setinfo('')
Messagebox('Update','Batch Update Successfully.')


end event

type dw_1 from u_dw within w_batch_update_alarm_create_ai
integer x = 23
integer y = 364
integer width = 1870
integer height = 1068
integer taborder = 10
string dataobject = "d_notification_users_select"
end type

event constructor;call super::constructor;This.of_setupdateable( False )
This.of_setsort(True)
This.inv_sort.of_SetColumnHeader(TRUE)
end event

