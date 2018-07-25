$PBExportHeader$w_user_reset.srw
forward
global type w_user_reset from window
end type
type rb_inactive from radiobutton within w_user_reset
end type
type rb_active from radiobutton within w_user_reset
end type
type cb_sort from commandbutton within w_user_reset
end type
type rb_inact from radiobutton within w_user_reset
end type
type rb_act from radiobutton within w_user_reset
end type
type gb_3 from groupbox within w_user_reset
end type
type gb_type from groupbox within w_user_reset
end type
type cb_7 from commandbutton within w_user_reset
end type
type st_1 from statictext within w_user_reset
end type
type dw_role from datawindow within w_user_reset
end type
type rb_ssn from radiobutton within w_user_reset
end type
type rb_random from radiobutton within w_user_reset
end type
type rb_name from radiobutton within w_user_reset
end type
type rb_123 from radiobutton within w_user_reset
end type
type dw_audit from datawindow within w_user_reset
end type
type cb_lockout from commandbutton within w_user_reset
end type
type cb_mod_user from commandbutton within w_user_reset
end type
type cb_exp from commandbutton within w_user_reset
end type
type cb_5 from commandbutton within w_user_reset
end type
type cb_4 from commandbutton within w_user_reset
end type
type dw_from from datawindow within w_user_reset
end type
type cb_3 from commandbutton within w_user_reset
end type
type cb_inact from commandbutton within w_user_reset
end type
type gb_pw from groupbox within w_user_reset
end type
type gb_2 from groupbox within w_user_reset
end type
type rb_non from radiobutton within w_user_reset
end type
type rb_prac from radiobutton within w_user_reset
end type
type gb_1 from groupbox within w_user_reset
end type
end forward

global type w_user_reset from window
integer x = 965
integer y = 256
integer width = 4416
integer height = 2464
boolean titlebar = true
string title = "User Reset Utilities"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
rb_inactive rb_inactive
rb_active rb_active
cb_sort cb_sort
rb_inact rb_inact
rb_act rb_act
gb_3 gb_3
gb_type gb_type
cb_7 cb_7
st_1 st_1
dw_role dw_role
rb_ssn rb_ssn
rb_random rb_random
rb_name rb_name
rb_123 rb_123
dw_audit dw_audit
cb_lockout cb_lockout
cb_mod_user cb_mod_user
cb_exp cb_exp
cb_5 cb_5
cb_4 cb_4
dw_from dw_from
cb_3 cb_3
cb_inact cb_inact
gb_pw gb_pw
gb_2 gb_2
rb_non rb_non
rb_prac rb_prac
gb_1 gb_1
end type
global w_user_reset w_user_reset

type variables
string is_from
string is_to
integer ii_facil
integer ii_set //Start Code Change ---- 11.07.2006 #1 maha
long il_dept = 0
integer il_role
long il_recid

end variables

forward prototypes
public function integer of_no_user ()
public function integer of_update_user (string as_util)
public function integer of_filter_users (integer ai_set)
public function integer of_audit (string as_from, string as_user, long al_row)
end prototypes

public function integer of_no_user ();integer i
integer ck = 0

//Start Code Change ---- 11.14.2006 #426 maha  new function
for i = 1 to dw_from.rowcount()
	if dw_from.getitemnumber(i,"selected") = 1 then
		ck = 1
		exit
	end if
next

if ck = 0 then
	messagebox("Select Error","No users are selected.")
	return -1
else
	return 1
end if

//if isnull(is_from) or is_from = "" then
//	messagebox("Select Error","You must select a user.")
//	return -1
//else
//	return 1
//end if
//End Code Change---11.14.2006
end function

public function integer of_update_user (string as_util);//Start Code Change ---- 11.14.2006 #V7 maha new function to allow multiple user functionality
//maha new 11.14.06
integer i
integer ic
integer li_status  //maha 01.11.2017
long nr
long ll_prac //11.22.2011
datetime ldt_now
string ls_user
string ls_sql
string ls_pw //11.22.2011

ic  = dw_from.rowcount()
debugbreak()
select max(rec_id) into :il_recid from sys_audit_user;
if isnull(il_recid) then il_recid = 0

for i = 1 to ic
	if dw_from.getitemnumber(i,"selected") = 1 then
		ls_user = dw_from.getitemstring(i,"user_id")
		ll_prac = dw_from.getitemnumber(i,"prac_id")
		if upper(ls_user) = "DBA" or  upper(ls_user) = "MASTER" then continue
		
		choose case as_util
			case "DATE"
				ldt_now = datetime(today(),Now())
				dw_from.setitem(i,"last_pass_update",ldt_now)
			case "NULL"
				setnull(ldt_now)
				dw_from.setitem(i,"last_pass_update",ldt_now)
				of_audit("E",ls_user,i)
				
			case "PW" //Start Code Change ----11.22.2011 #V12 maha
				if rb_123.checked then
					dw_from.setitem(i,"user_password","123")
				elseif rb_name.checked then
					dw_from.setitem(i,"user_password",ls_user)
				elseif rb_ssn.checked then
					if isnull(ll_prac) then 
						messagebox("Reset Password","User " + ls_user + " is not a practitioner user and has no SSN")
						continue
					else
						ls_pw = of_create_password("SSN",ll_prac, ls_user )  //Start Code Change ----04.04.2012 #V12 maha - corrected case of SSN
						dw_from.setitem(i,"user_password",ls_pw )
					end if
				elseif rb_random.checked then
						ls_pw = of_create_password("RAND",ll_prac, ls_user )
						dw_from.setitem(i,"user_password",ls_pw )
				end if
				of_audit("P",ls_user , i)
			case "REPORT"
				//ls_sql =  "update conv_view set mod_user = 'All' where mod_user = :" + ls_user + ";" //Delete by Michael 06.02.2011 --- Fixed a bug Need to reset the user lock on several intellireports
				ls_sql =  "update conv_view set mod_user = 'All' where mod_user = '" + ls_user + "';"
				execute immediate :ls_sql using sqlca;
			case "Active"  //Start Code Change ----05.15.2009 #V92 maha - ameripath customization			
				//ldt_now = datetime(relativedate(today(),3),Now())
				setnull(ldt_now)  //Start Code Change ----01.11.2017 #V153 maha - set value to null
				li_status = dw_from.getitemnumber(i,"active_status") 
				if li_status = 0 or isnull(li_status) then   //Start Code Change ----01.11.2017 #V153 maha - added null check
					dw_from.setitem(i,"expiration_date",ldt_now)  //Start Code Change ----01.11.2017 #V153 maha - clear expiration field
					dw_from.setitem(i,"active_status",1)
					dw_from.setitem(i,"fail_count",0)  //Start Code Change ----03.25.2013 #V12 maha
					of_audit("A",ls_user, i)
				end if
			case "Inactive" //Start Code Change ----12.01.2011 #V12 maha - added inactive
				dw_from.setitem(i,"active_status",0)  //Start Code Change ----04.04.2012 #V12 maha - corrected from setting to  '1'
				of_audit("I",ls_user, i)
			case "Lockout"  //Start Code Change ----08.12.2009 #V92 maha
				//ldt_now = datetime(today(),Now())   //Start Code Change ----03.19.2015 #V15 maha
				setnull(ldt_now)
				dw_from.setitem(i,"lock_until",ldt_now)	
				of_audit("L",ls_user, i)
		end choose
		
	end if
next	

dw_from.update()
dw_audit.update()
commit using sqlca;

return 1
end function

public function integer of_filter_users (integer ai_set);string ls_filter
string ls_act
integer res


if ai_set = 0 then  //clear
	ls_filter = ""
	rb_prac.checked = false
	rb_non.checked = false
	rb_act.checked = false
	rb_inact.checked = false
	il_role = 0
	dw_role.setitem(1,"role_id", 0)
else //
	if rb_prac.checked then
		ls_filter = "prac_id > 0 "
	elseif rb_non.checked then
		ls_filter = "isnull(prac_id) "
	else 
		ls_filter = ""
	end if
	
	if il_role > 0 then
		if len(ls_filter) > 0 then ls_filter = ls_filter + " and "
		ls_filter = ls_filter + " role_id = " + string(il_role)
	end if
	
	if rb_act.checked then
		ls_act = " active_status = 1 "
		if len(ls_filter) > 0 then ls_filter = ls_filter + " and "
		ls_filter = ls_filter + ls_act
	elseif rb_inact.checked then
		ls_act = " (active_status = 0 or isnull(active_status)) "
		if len(ls_filter) > 0 then ls_filter = ls_filter + " and "
		ls_filter = ls_filter + ls_act
	else
		ls_act = ""
	end if
	
end if

res = dw_from.setfilter( ls_filter)
if res < 0 then 
	messagebox("Filter failed", ls_filter)
	clipboard(ls_filter)
end if

dw_from.filter()

return 1
	
end function

public function integer of_audit (string as_from, string as_user, long al_row);//Start Code Change ----06.25.2009 #V92 maha - created for ameripath customization
//long ll_recid  maha removed 11-29-2011
datetime ldt_now
string ls_new
string ls_old
string ls_field
string ls_type
string ls_value
integer nr

//select max(rec_id) into :ll_recid from sys_audit_user;//Start Code Change ----11.29.2011 #V12 maha - migrated to instance variable
//if isnull(ll_recid) then ll_recid = 0
ldt_now = datetime(today(),now())

ls_type = as_from

if as_from = "P"  then//insert
	//ls_new = dw_from.getitemstring(al_row,"user_password") //Start Code Change ----11.17.2014 #V14.2 maha - modified to blank new password
	ls_new = "*****"
	ls_field = "Password reset"
	ls_old = "****"
elseif  as_from = "A" then //delete 
	ls_field = "Active status reset"
	ls_old = "0"
	ls_new = "1"
elseif  as_from = "I" then	//Start Code Change ----12.01.2011 #V12 maha - added inactive
	ls_field = "Active status"
	ls_old = "1"
	ls_new = "0"
elseif  as_from = "L" then // facility
	ls_field = "Lockout Reset"
	ls_new = ""
	ls_old = ""
elseif  as_from = "E" then //view 
	ls_field = "Expiration Date reset"
	ls_new = ""
	ls_old = ""
end if

nr = dw_audit.insertrow(0)
dw_audit.setitem(nr,"user_id",as_user)
dw_audit.setitem(nr,"audit_type","RES") //Start Code Change ----11.17.2014 #V14.2 maha - changed from U
dw_audit.setitem(nr,"new_value",ls_new)
dw_audit.setitem(nr,"old_value",ls_old)
dw_audit.setitem(nr,"field_name",ls_field)
il_recid++  //Start Code Change ----11.29.2011 #V12 maha - migrated to instance variable
dw_audit.setitem(nr,"rec_id",il_recid)  //Start Code Change ----11.29.2011 #V12 maha - migrated to instance variable
dw_audit.setitem(nr,"date_time_modified",ldt_now)
dw_audit.setitem(nr,"mod_by",gs_user_id )	

return 1
end function

on w_user_reset.create
this.rb_inactive=create rb_inactive
this.rb_active=create rb_active
this.cb_sort=create cb_sort
this.rb_inact=create rb_inact
this.rb_act=create rb_act
this.gb_3=create gb_3
this.gb_type=create gb_type
this.cb_7=create cb_7
this.st_1=create st_1
this.dw_role=create dw_role
this.rb_ssn=create rb_ssn
this.rb_random=create rb_random
this.rb_name=create rb_name
this.rb_123=create rb_123
this.dw_audit=create dw_audit
this.cb_lockout=create cb_lockout
this.cb_mod_user=create cb_mod_user
this.cb_exp=create cb_exp
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_from=create dw_from
this.cb_3=create cb_3
this.cb_inact=create cb_inact
this.gb_pw=create gb_pw
this.gb_2=create gb_2
this.rb_non=create rb_non
this.rb_prac=create rb_prac
this.gb_1=create gb_1
this.Control[]={this.rb_inactive,&
this.rb_active,&
this.cb_sort,&
this.rb_inact,&
this.rb_act,&
this.gb_3,&
this.gb_type,&
this.cb_7,&
this.st_1,&
this.dw_role,&
this.rb_ssn,&
this.rb_random,&
this.rb_name,&
this.rb_123,&
this.dw_audit,&
this.cb_lockout,&
this.cb_mod_user,&
this.cb_exp,&
this.cb_5,&
this.cb_4,&
this.dw_from,&
this.cb_3,&
this.cb_inact,&
this.gb_pw,&
this.gb_2,&
this.rb_non,&
this.rb_prac,&
this.gb_1}
end on

on w_user_reset.destroy
destroy(this.rb_inactive)
destroy(this.rb_active)
destroy(this.cb_sort)
destroy(this.rb_inact)
destroy(this.rb_act)
destroy(this.gb_3)
destroy(this.gb_type)
destroy(this.cb_7)
destroy(this.st_1)
destroy(this.dw_role)
destroy(this.rb_ssn)
destroy(this.rb_random)
destroy(this.rb_name)
destroy(this.rb_123)
destroy(this.dw_audit)
destroy(this.cb_lockout)
destroy(this.cb_mod_user)
destroy(this.cb_exp)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_from)
destroy(this.cb_3)
destroy(this.cb_inact)
destroy(this.gb_pw)
destroy(this.gb_2)
destroy(this.rb_non)
destroy(this.rb_prac)
destroy(this.gb_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	//MESSAGEBOX("","LOGIN OK")
//END if

DataWindowChild dwchild

dw_from.settransobject(sqlca)
dw_from.retrieve()
//dw_from.insertrow(1)//Start Code Change ---- 11.14.2006 #V7 maha


//
//
//dw_facility.GetChild( "facility_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
//dwchild.insertrow(1)
//dwchild.setitem(1,"facility_name","All")
//dwchild.setitem(1,"facility_id",-1)


end event

event close;//disCONNECT USING SQLCA;
end event

type rb_inactive from radiobutton within w_user_reset
integer x = 1426
integer y = 64
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Inactive"
end type

type rb_active from radiobutton within w_user_reset
integer x = 882
integer y = 64
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Active"
boolean checked = true
end type

type cb_sort from commandbutton within w_user_reset
integer x = 3630
integer y = 52
integer width = 274
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_from.SetSort(null_str)

dw_from.Sort( )
end event

type rb_inact from radiobutton within w_user_reset
integer x = 3063
integer y = 308
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Inactive"
end type

event clicked;of_filter_users(1)
end event

type rb_act from radiobutton within w_user_reset
integer x = 2638
integer y = 308
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Active"
end type

event clicked;of_filter_users(1)
end event

type gb_3 from groupbox within w_user_reset
integer x = 2450
integer y = 132
integer width = 1125
integer height = 124
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Type"
end type

type gb_type from groupbox within w_user_reset
integer x = 2446
integer y = 268
integer width = 1129
integer height = 120
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type

type cb_7 from commandbutton within w_user_reset
integer x = 3278
integer y = 52
integer width = 274
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;of_filter_users(0)
end event

type st_1 from statictext within w_user_reset
integer x = 2469
integer y = 72
integer width = 142
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Role:"
boolean focusrectangle = false
end type

type dw_role from datawindow within w_user_reset
integer x = 2610
integer y = 56
integer width = 594
integer height = 80
integer taborder = 40
string title = "none"
string dataobject = "d_role_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_role = integer(data)
of_filter_users(1)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type rb_ssn from radiobutton within w_user_reset
integer x = 910
integer y = 224
integer width = 709
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "last 4 of SSN(prac user)"
end type

type rb_random from radiobutton within w_user_reset
integer x = 2048
integer y = 224
integer width = 297
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Random"
end type

type rb_name from radiobutton within w_user_reset
integer x = 1655
integer y = 224
integer width = 370
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "User Name"
end type

type rb_123 from radiobutton within w_user_reset
integer x = 658
integer y = 224
integer width = 215
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "123"
boolean checked = true
end type

type dw_audit from datawindow within w_user_reset
boolean visible = false
integer x = 622
integer y = 2148
integer width = 549
integer height = 200
integer taborder = 70
boolean bringtotop = true
string title = "none"
string dataobject = "d_view_audit_user"
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_lockout from commandbutton within w_user_reset
integer x = 631
integer y = 328
integer width = 558
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Lock Out"
end type

event clicked;//Start Code Change ----08.12.2009 #V92 maha - new function
string ls_sql
integer i
datetime ldt_now

i = messagebox("Lockout Reset","This will reset the lockout time for the selected users.~r~rContinue?",question!,yesno!,2)

if i = 2 then return

if of_no_user() = -1 then return

of_update_user( "Lockout")

end event

type cb_mod_user from commandbutton within w_user_reset
integer x = 37
integer y = 328
integer width = 590
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset IReport Owner"
end type

event clicked;//Start Code Change ---- 04.26.2006 #427 maha  //new function 
string ls_sql
integer i

//i = messagebox("User Reset","This will reset the 'Can be modified by' field to All all IntelliReports where the Modifiy User is the selected user.~r~rContinue?",question!,yesno!,2)
i = messagebox("User Reset","This will reset the 'Can be modified by' field to All for all IntelliReports where the Modifiy User is the selected user.~r~rContinue?",question!,yesno!,2)	//long.zhang 04.06.2012
if i = 2 then return

if of_no_user() = -1 then return
//Start Code Change ---- 11.14.2006 #V7 maha
of_update_user( "REPORT")

//maha 122205 resetting per new dba connections
//ls_sql =  "update conv_view set mod_user = 'All' where mod_user = : " + is_from + ";"
//execute immediate :ls_sql using sqlca;
//commit using sqlca;
//End Code Change---11.14.2006


end event

type cb_exp from commandbutton within w_user_reset
integer x = 1193
integer y = 328
integer width = 699
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Password Exp Dates"
end type

event clicked;//maha 031605 to reset all exp dates on passwords
integer i

i = messagebox("Null exp Date","This will clear user password expiration Dates for selected users. The expiration date for each user will be set the first time they log in.~r~rContinue?",question!,yesno!,2)

if i = 2 then return

//Start Code Change ---- 11.14.2006 #V7 maha using function
if of_no_user() = -1 then
	return
else
	of_update_user( "NULL")
end if
//update security_users set last_pass_update = null;
//
//commit using sqlca;
//End Code Change---11.14.2006
end event

type cb_5 from commandbutton within w_user_reset
boolean visible = false
integer x = 1883
integer y = 2556
integer width = 800
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Drop Catalog tables"
end type

event clicked;string ls_sql
string ls_user
integer i


if of_no_user() = -1 then return 

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.17.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//Start Code Change ---- 11.14.2006 #1 maha chalged to allow multiple users at once
for i = 1 to dw_from.rowcount()
	ls_user = dw_from.getitemstring(i,"user_id")
	if upper(ls_user) = "DBA" or  upper(ls_user) = "MASTER" then continue
	
	ls_sql = "drop table " + ls_user  + ".pbcatcol;"
	//messagebox("ls_sql",ls_sql)
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	
	ls_sql = "drop table " + ls_user  + ".pbcatedt;"
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	
	ls_sql = "drop table " + ls_user  + ".pbcatfmt;"
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	
	ls_sql = "drop table " + ls_user  + ".pbcattbl;"
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
	
	ls_sql = "drop table " + ls_user  + ".pbcatvld;"
	execute immediate :ls_sql using sqlca;
	commit using sqlca;
next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 01.17.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------



end event

type cb_4 from commandbutton within w_user_reset
integer x = 46
integer y = 224
integer width = 562
integer height = 76
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Passwords"
end type

event clicked;string ls_sql
string ls_pw
integer i
n_cst_encrypt ln_enc

if of_no_user() = -1 then return //Start Code Change ---- 04.26.2006 #426 maha

i = messagebox("User Reset","This will reset the temporary password per the selected temp password type for the selected users.~r~rContinue?",question!,yesno!,2)

if i = 2 then return


//Start Code Change ---- 11.14.2006 #V7 maha to use function
of_update_user( "PW")
//Start Code Change ---- 11.07.2006 #1 maha
//ls_sql = "Grant connect to " + is_from  + " identified by '123';"
//maha 122205 resetting per new dba connections
//select new_change_pw into :ii_set from security_settings;
//
//if ii_set = 1 then
//	ls_pw = "123"
//else
//	ls_pw = ln_enc.of_encrypt( "123")  
//end if
//
//ls_sql =  "update security_users set user_password = '" + ls_pw +  "' where user_id = '" + is_from + "';"
////messagebox("",ls_sql)
//execute immediate :ls_sql using sqlca;
//commit using sqlca;

//End Code Change---11.14.2006

//DECLARE ChangePassword PROCEDURE FOR dbo.sp_password  
//         @caller_pswd = :gs_password,   
//         @new_pswd = :ls_password,   
//         @login_name = :gs_user_id  ;
//
//EXECUTE ChangePassword;
end event

type dw_from from datawindow within w_user_reset
integer x = 27
integer y = 428
integer width = 4343
integer height = 1896
integer taborder = 50
string dataobject = "d_user_select_list"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;is_from = data
end event

event buttonclicked;//Start Code Change ----12.01.2011 #V12 maha
long r
	
If dwo.text = 'Select All' Then
	for r = 1 to this.rowcount()
		This.Object.Selected[r] = 1
	next
	dwo.text = 'Deselect All'
ElseIf dwo.text = 'Deselect All' Then 
	for r = 1 to this.rowcount()
		This.Object.Selected[r] = 0
	next
	dwo.text = 'Select All'
End If
end event

type cb_3 from commandbutton within w_user_reset
integer x = 4064
integer y = 52
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

type cb_inact from commandbutton within w_user_reset
integer x = 46
integer y = 56
integer width = 558
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset Active Status"
end type

event clicked;//Start Code Change ----12.01.2011 #V12 maha - modified to allow set to inactive
integer i

if rb_active.checked = false and rb_inactive.checked = false then
	messagebox("Reset user", "Please select a status value")
	return 
end if

//Start Code Change ----04.04.2012 #V12 maha - created separate messages
if rb_active.checked then
	i = messagebox("Reset user","This will reset the selected user(s) Status to Active.~r~rContinue?",question!,yesno!,2)  //Start Code Change ----01.11.2017 #V153 maha -  removed this part of the message: The user will have 3 days to login before becoming Inactive again.
else //inactive
	i = messagebox("Reset user","This will reset the selected user(s) Status to Inactive.~r~rContinue?",question!,yesno!,2)
end if
//End Code Change ----04.04.2012

if i = 2 then return


if of_no_user() = -1 then return //Start Code Change ---- 04.26.2006 #426 maha

//Start Code Change ---- 11.14.2006 #V7 maha to use function

if rb_active.checked = true then
	of_update_user( "Active")
elseif rb_inactive.checked = true then
	of_update_user( "Inactive")
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-07 By: Zhang Lingping
//$<reason> 

//update security_users set last_pass_update = today() where user_id = :is_from;
//update security_users set last_pass_update = getdate() where user_id = :is_from;
////---------------------------- APPEON END ----------------------------
//
//commit using sqlca;

//End Code Change---11.14.2006
end event

type gb_pw from groupbox within w_user_reset
integer x = 23
integer y = 4
integer width = 2359
integer height = 152
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Set Active Status"
end type

type gb_2 from groupbox within w_user_reset
integer x = 2409
integer width = 1207
integer height = 408
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

type rb_non from radiobutton within w_user_reset
integer x = 3063
integer y = 172
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Non-Providers"
end type

event clicked;of_filter_users(1)
end event

type rb_prac from radiobutton within w_user_reset
integer x = 2638
integer y = 172
integer width = 338
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Providers"
end type

event clicked;of_filter_users(1)
end event

type gb_1 from groupbox within w_user_reset
integer x = 23
integer y = 168
integer width = 2359
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Set Temp Password to"
end type

