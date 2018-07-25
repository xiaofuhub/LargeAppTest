$PBExportHeader$w_ctx_alarm_users.srw
forward
global type w_ctx_alarm_users from w_popup
end type
type cbx_appointment from checkbox within w_ctx_alarm_users
end type
type st_tips from statictext within w_ctx_alarm_users
end type
type cb_ic from commandbutton within w_ctx_alarm_users
end type
type cb_cancel from commandbutton within w_ctx_alarm_users
end type
type cb_ok from commandbutton within w_ctx_alarm_users
end type
type dw_1 from u_dw_contract within w_ctx_alarm_users
end type
end forward

global type w_ctx_alarm_users from w_popup
integer width = 2272
integer height = 1340
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cbx_appointment cbx_appointment
st_tips st_tips
cb_ic cb_ic
cb_cancel cb_cancel
cb_ok cb_ok
dw_1 dw_1
end type
global w_ctx_alarm_users w_ctx_alarm_users

type variables
str_alarm_user	istr_alarm_user
end variables

forward prototypes
public subroutine of_seliccontacts ()
public subroutine of_init_selected ()
end prototypes

public subroutine of_seliccontacts ();//Alfee 08.20.2008

String 	ls_email, ls_addr
str_pass lstr_pass
str_alarm_user lstr_alarm

lstr_pass.s_string = "EMail_Send"
lstr_pass.l_facility_id = -999

OpenWithParm ( w_contract_contact, lstr_pass)

ls_email = Trim(Message.StringParm)

If ls_email = '' or isnull(ls_email) Then Return //Added by Ken.Guo on 2009-01-06

//Modified by jervis 10.12.2009
//CloseWithReturn(This, ls_email)
lstr_alarm.s_flag = istr_alarm_user.s_flag
lstr_alarm.s_to_list = ls_email
if istr_alarm_user.s_flag = 'Y' then
	if len(trim(istr_alarm_user.s_create_list)) > 0 then
		lstr_alarm.s_create_list = istr_alarm_user.s_create_list + ";" + ls_email
	else
		lstr_alarm.s_create_list = ls_email
	end if
end if
CloseWithReturn(This, lstr_alarm)


end subroutine

public subroutine of_init_selected ();String ls_to_users[],ls_create_users[], ls_create_appoint[]
n_cst_string lnv_string
long ll_i,ll_count,ll_find

//Begin - Modified By Ken.Guo 2010-03-02
/*
//init selected
lnv_string.of_parsetoarray( trim(istr_alarm_user.s_to_list ),";",ls_to_users)
ll_count = UpperBound(ls_to_users)
for ll_i = 1 to ll_count
	ll_find = dw_1.Find( "email_id ='" + trim(ls_to_users[ll_i]) + "'", 1, dw_1.RowCount())
	if ll_find > 0 then
		dw_1.SetItem( ll_find,'selected', 1)
	end if
next
//init Create action item
lnv_string.of_parsetoarray( trim(istr_alarm_user.s_create_list ),";",ls_create_users)
ll_count = UpperBound(ls_create_users)
for ll_i = 1 to ll_count
	ll_find = dw_1.Find( "email_id ='" + trim(ls_create_users[ll_i]) + "'", 1, dw_1.RowCount())
	if ll_find > 0 then
		dw_1.SetItem( ll_find,'create_action', 1)
	end if
next
*/

//init selected
lnv_string.of_parsetoarray( trim(istr_alarm_user.s_to_list ),";",ls_to_users)
ll_count = UpperBound(ls_to_users)
for ll_i = 1 to ll_count
	ll_find = dw_1.Find( "lower(trim(email_id)) ='" + lower(trim(ls_to_users[ll_i])) + "'", 1, dw_1.RowCount())
	Do While ll_find > 0
		dw_1.SetItem( ll_find,'selected', 1)
		If ll_find = dw_1.rowcount() Then Exit
		ll_find = dw_1.Find( "lower(trim(email_id)) ='" + lower(trim(ls_to_users[ll_i])) + "'", ll_find + 1, dw_1.RowCount())
	Loop
next

//init Create action item
lnv_string.of_parsetoarray( trim(istr_alarm_user.s_create_list ),";",ls_create_users)
ll_count = UpperBound(ls_create_users)
for ll_i = 1 to ll_count
	ll_find = dw_1.Find( "lower(trim(user_id)) ='" + lower(trim(ls_create_users[ll_i])) + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		If dw_1.GetitemNumber(ll_find,'selected') = 1 then
			dw_1.SetItem( ll_find,'create_action', 1)
		End If
	End If
next
//End - Modified By Ken.Guo 2010-03-02
//init Create appointment  //added by gavins 20121031
lnv_string.of_parsetoarray( trim(istr_alarm_user.s_appointment ),";",ls_create_appoint)
ll_count = UpperBound(ls_create_appoint)
for ll_i = 1 to ll_count
	ll_find = dw_1.Find( "lower(trim(email_id)) ='" + lower(trim(ls_create_appoint[ll_i])) + "'", 1, dw_1.RowCount())
	If ll_find > 0 Then
		If dw_1.GetitemNumber(ll_find,'selected') = 1 then
			dw_1.SetItem( ll_find,'create_appointment', 1)
		End If
	End If
next
If  Len( trim(istr_alarm_user.s_appointment )  ) > 1 Then cbx_appointment.Checked = true

end subroutine

on w_ctx_alarm_users.create
int iCurrent
call super::create
this.cbx_appointment=create cbx_appointment
this.st_tips=create st_tips
this.cb_ic=create cb_ic
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_appointment
this.Control[iCurrent+2]=this.st_tips
this.Control[iCurrent+3]=this.cb_ic
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.dw_1
end on

on w_ctx_alarm_users.destroy
call super::destroy
destroy(this.cbx_appointment)
destroy(this.st_tips)
destroy(this.cb_ic)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;String			ls_Appointment

istr_alarm_user = message.powerobjectparm	//10.12.2009 by jervis
dw_1.SetTransObject(SQLCA)
dw_1.Retrieve()

If lower(istr_alarm_user.s_type) = 'normal' Then
	//Ignore //Added By Ken.Guo 08/16/2013
Else
	//Added By Ken.Guo 11/01/2012. Support Owner for Alarms
	dw_1.InsertRow(1)
	dw_1.SetItem(1,'user_id', '$<Owner>$')
	dw_1.SetItem(1,'email_id', '$<OwnerEmail>$')
End If

If Lower(istr_alarm_user.s_type) = 'ctx_am_action_item' or Lower(istr_alarm_user.s_type)  = 'ctx_action_item' or lower(istr_alarm_user.s_type) = 'normal' Then
	dw_1.Modify("create_action.visible = '0'")
End If

of_init_selected()	//10.12.2009 by jervis

If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '0' Then 
	cbx_appointment.Visible = false	
Else
	ls_Appointment = gnv_user_option.of_Get_option_value( gs_user_id, "ctx_alarm_users_attach_outlook_appointment" ) //added by gavins 20130319
	If ls_Appointment = '1' Or ls_Appointment = '' Then
		cbx_appointment.Checked = True
	Else
		cbx_appointment.Checked = False
	End If

	If istr_alarm_user.s_type = 'Esign' Then
		dw_1.Height = dw_1.Height - 50
		st_tips.Visible = true
	End If
End If

//Added By Ken.Guo 08/16/2013
If lower(istr_alarm_user.s_type) = 'normal' Then
	cbx_appointment.Visible = False
End If

/*
If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '0' Then //added by gavins 20121031

	dw_1.Modify( "create_appointment.Visible=0 create_appointment_t.visible=0" )
Else
	If istr_alarm_user.s_type = 'Esign' Then
		st_tips.Visible = true
	End If
	If Lower(istr_alarm_user.s_type) = 'ctx_am_action_item' or Lower(istr_alarm_user.s_type)  = 'ctx_action_item' Then
	Else
		
		this.Width = 2893
		dw_1.Width = 2813
		cb_ok.x = 2145
		cb_cancel.x = 2493
	End If
//	If istr_alarm_user.s_create_list = 'cc_createlist' Then
//		dw_1.Modify( "create_appointment.Visible=0 create_appointment_t.visible=0" )
//	End If
End If
*/
end event

type cbx_appointment from checkbox within w_ctx_alarm_users
integer x = 763
integer y = 1220
integer width = 773
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Attach Outlook Appointment "
end type

event clicked;//If istr_alarm_user.s_type = 'Esign' Then
//	MessageBox( 'Tips', st_tips.Text )
//End If

if This.Checked Then
	gnv_user_option.of_set_option_value(gs_user_id, "ctx_alarm_users_attach_outlook_appointment" , '1' ) //added by gavins 20130319
Else
	gnv_user_option.of_set_option_value(gs_user_id, "ctx_alarm_users_attach_outlook_appointment" , '0' ) 
End If
end event

type st_tips from statictext within w_ctx_alarm_users
boolean visible = false
integer x = 27
integer y = 1128
integer width = 2208
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "The appointment for e-signature will be sent to the recipient(s) in a separate email."
boolean focusrectangle = false
end type

type cb_ic from commandbutton within w_ctx_alarm_users
integer x = 27
integer y = 1212
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

type cb_cancel from commandbutton within w_ctx_alarm_users
integer x = 1893
integer y = 1212
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

type cb_ok from commandbutton within w_ctx_alarm_users
integer x = 1545
integer y = 1212
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
Long ll_row, ll_selected,li_create, ll_Appointment
String ls_mail, ls_maillist, ls_createlist, ls_CreateAppoint=''
str_alarm_user  lstr_alarm
String ls_user_id 

FOR ll_row = 1 to dw_1.RowCount()
	ll_selected = dw_1.GetItemNumber(ll_row, "selected") 
	IF ll_selected = 0 THEN Continue
	
	ls_mail = dw_1.GetItemString(ll_row, "email_id") 
	ls_user_id = dw_1.GetItemString(ll_row, "user_id") 
//	ll_Appointment = dw_1.GetItemNumber(ll_row, "create_appointment") //added by gavins 20121024
	If cbx_appointment.Checked Then ll_Appointment = 1  //modifed by gavins 20121105                
	IF NOT IsNull(ls_mail) AND Len(Trim(ls_mail)) > 0 THEN
		IF Len(ls_maillist) < 1 THEN 
			ls_maillist = ls_mail 
		ELSE
			ls_maillist += "; " + ls_mail
		END IF
		If ll_Appointment = 1 Then
			IF Len(ls_CreateAppoint) < 1 THEN //added by gavins 20121024
				ls_CreateAppoint = ls_mail 
			ELSE
				ls_CreateAppoint += "; " + ls_mail
			END IF
		End If
		//Add by jervis 10.12.2009
		li_create = dw_1.GetItemNumber( ll_row,"create_action")
		if li_create = 1 then
			if len(ls_createlist) < 1 then
				ls_createlist = ls_user_id //Modified By Ken.Guo 2010-03-02
			else
				ls_createlist += ";" + ls_user_id //Modified By Ken.Guo 2010-03-02
			end if
		end if
	END IF
NEXT

If lstr_alarm.s_type <> 'Review/Approve' and lstr_alarm.s_type <> 'Esign'  Then //Added By Ken.Guo 10/31/2011.  Added if statement
	//Check - jervis 10.12.2009
	lstr_alarm.s_flag  =istr_alarm_user.s_flag //Set Init Value - Jervis 12.15.2009
	if istr_alarm_user.s_flag = 'Y' then
		if len(ls_maillist) > 0 and len(ls_createlist) < 1 then
			if MessageBox('IntelliContract','If you want to create Action Item, at least one Create Action Item checkbox must be selected, Click Yes will return to re-select, Click No will not create the Action Item.',Information! ,YesNo!) = 1 then
				return
			else
				lstr_alarm.s_flag = 'N'
			end if
		end if
	end if
	if istr_alarm_user.s_flag = 'N' then
		if len(ls_maillist) > 0 and len(ls_createlist) > 1 then
			if MessageBox('IntelliContract','Are you sure you want to create the Action Item?',Question!,YesNo!) = 1 then  //(Appeon)Harry 01.28.2014 - V142 ISG-CLX  Modify "ContractLogix" to "IntelliContract"
				lstr_alarm.s_flag = 'Y'
			else
				lstr_alarm.s_flag = 'N'
			end if
		end if
	end if
End If

lstr_alarm.s_to_list = ls_maillist
lstr_alarm.s_create_list = ls_createlist
lstr_alarm.s_appointment = ls_CreateAppoint

//ClosewithReturn(Parent, ls_maillist)
ClosewithReturn(Parent, lstr_alarm)


end event

type dw_1 from u_dw_contract within w_ctx_alarm_users
integer x = 23
integer y = 20
integer width = 2213
integer height = 1168
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

event itemchanged;call super::itemchanged;//add by jervis 10.12.2009
if dwo.name = 'selected' then
	if data = '1' and istr_alarm_user.s_flag = 'Y' then
		this.SetItem(row,'create_action',1)
	elseif data = '0' then
		this.SetItem(row,'create_action',0)
		this.SetItem(row,'create_appointment',0)
	end if
	If gnv_data.of_getitem( 'icred_settings', 'Appointment_create', False) = '1' and data = '1' Then //added by gavins 20121031
		this.SetItem(row,'create_appointment',1)
	End If
end if

//Added By Ken.Guo 10/31/2011. 
If dwo.name = 'create_action' Then
	if data = '1' Then
		this.SetItem(row,'selected',1)
	End If
End If


//added by gavins 20121024
If dwo.name = 'create_appointment' Then
	if data = '1' Then
		this.SetItem(row,'selected',1)
	End If
End If
end event

