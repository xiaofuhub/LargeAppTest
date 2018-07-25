$PBExportHeader$w_alarm_users.srw
forward
global type w_alarm_users from w_popup
end type
type cb_ic from commandbutton within w_alarm_users
end type
type cb_cancel from commandbutton within w_alarm_users
end type
type cb_ok from commandbutton within w_alarm_users
end type
type dw_1 from u_dw_contract within w_alarm_users
end type
end forward

global type w_alarm_users from w_popup
integer width = 1865
integer height = 1428
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_ic cb_ic
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_alarm_users w_alarm_users

forward prototypes
public subroutine of_seliccontacts ()
end prototypes

public subroutine of_seliccontacts ();//Alfee 08.20.2008

String 	ls_email, ls_addr
str_pass lstr_pass

lstr_pass.s_string = "EMail_Send"
lstr_pass.l_facility_id = -999

OpenWithParm ( w_contract_contact, lstr_pass)

ls_email = Trim(Message.StringParm)

CloseWithReturn(This, ls_email)
end subroutine

on w_alarm_users.create
int iCurrent
call super::create
this.cb_ic=create cb_ic
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ic
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_1
end on

on w_alarm_users.destroy
call super::destroy
destroy(this.cb_ic)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

//------------------- APPEON BEGIN -------------------
//$<ADD> Evan 01.07.2010
//$<reason> V10.1 - Notification Alert
if Message.StringParm = "NotSelectIC!" then
	cb_ic.Hide()
end if
//------------------- APPEON END ---------------------

//---------Begin Modified by (Appeon)Harry 08.09.2013 for V141 ISG-CLX--------
dw_1.modify("create_action.visible = '0'") 
//---------End Modfiied ------------------------------------------------------

end event

type cb_ic from commandbutton within w_alarm_users
integer x = 27
integer y = 1228
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&IC Contacts"
end type

event clicked;of_seliccontacts() //Alfee 08.20.2008
end event

type cb_cancel from commandbutton within w_alarm_users
integer x = 1495
integer y = 1228
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

type cb_ok from commandbutton within w_alarm_users
integer x = 1147
integer y = 1228
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

event clicked;//Modified by Alfee 08.20.2008
Long ll_row, ll_selected
String ls_mail, ls_maillist

FOR ll_row = 1 to dw_1.RowCount()
	ll_selected = dw_1.GetItemNumber(ll_row, "selected") 
	IF ll_selected = 0 THEN Continue
	
	ls_mail = dw_1.GetItemString(ll_row, "email_id") 
	IF NOT IsNull(ls_mail) AND LenA(Trim(ls_mail)) > 0 THEN
		IF LenA(ls_maillist) < 1 THEN 
			ls_maillist = ls_mail 
		ELSE
			ls_maillist += "; " + ls_mail
		END IF
	END IF
NEXT

ClosewithReturn(Parent, ls_maillist)


end event

type dw_1 from u_dw_contract within w_alarm_users
integer x = 27
integer y = 36
integer width = 1810
integer taborder = 10
string dataobject = "d_notification_users_select"
borderstyle borderstyle = stylebox!
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
boolean ib_use_row_selection = true
boolean ib_allow_sort = true
boolean ib_allow_save = false
end type

event constructor;call super::constructor;of_setupdateable(false)
of_SetRowSelect(true)
end event

event getfocus;//
end event

event losefocus;//
end event

