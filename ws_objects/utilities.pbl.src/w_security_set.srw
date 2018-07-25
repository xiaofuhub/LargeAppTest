$PBExportHeader$w_security_set.srw
forward
global type w_security_set from window
end type
type st_3 from statictext within w_security_set
end type
type cb_11 from commandbutton within w_security_set
end type
type cb_10 from commandbutton within w_security_set
end type
type cb_9 from commandbutton within w_security_set
end type
type cb_8 from commandbutton within w_security_set
end type
type cb_mod_user from commandbutton within w_security_set
end type
type cb_7 from commandbutton within w_security_set
end type
type st_2 from statictext within w_security_set
end type
type dw_1 from datawindow within w_security_set
end type
type st_1 from statictext within w_security_set
end type
type dw_from from datawindow within w_security_set
end type
type cb_3 from commandbutton within w_security_set
end type
type cb_1 from commandbutton within w_security_set
end type
type gb_1 from groupbox within w_security_set
end type
end forward

global type w_security_set from window
integer x = 965
integer y = 256
integer width = 2935
integer height = 1624
boolean titlebar = true
string title = "Reset Users"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79680469
st_3 st_3
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_mod_user cb_mod_user
cb_7 cb_7
st_2 st_2
dw_1 dw_1
st_1 st_1
dw_from dw_from
cb_3 cb_3
cb_1 cb_1
gb_1 gb_1
end type
global w_security_set w_security_set

type variables
string is_from
string is_to
integer ii_facil
long il_dept = 0
end variables

forward prototypes
public function integer of_no_user ()
end prototypes

public function integer of_no_user ();//Start Code Change ---- 04.26.2006 #426 maha  new function
if isnull(is_from) or is_from = "" then
	messagebox("Select Error","You must select a user.")
	return -1
else
	return 1
end if
//End Code Change---04.26.2006
end function

on w_security_set.create
this.st_3=create st_3
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_mod_user=create cb_mod_user
this.cb_7=create cb_7
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
this.dw_from=create dw_from
this.cb_3=create cb_3
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.cb_11,&
this.cb_10,&
this.cb_9,&
this.cb_8,&
this.cb_mod_user,&
this.cb_7,&
this.st_2,&
this.dw_1,&
this.st_1,&
this.dw_from,&
this.cb_3,&
this.cb_1,&
this.gb_1}
end on

on w_security_set.destroy
destroy(this.st_3)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_mod_user)
destroy(this.cb_7)
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.dw_from)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;
DataWindowChild dwchild

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_from.settransobject(sqlca)
dw_from.retrieve()
dw_from.insertrow(1)




end event

type st_3 from statictext within w_security_set
integer x = 119
integer y = 1056
integer width = 2725
integer height = 188
integer textsize = -18
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Not being used 11-07-06  using w_security_painter"
boolean focusrectangle = false
end type

type cb_11 from commandbutton within w_security_set
integer x = 78
integer y = 404
integer width = 800
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset Password Expiration"
end type

event clicked;string ls_sql

if of_no_user() = -1 then return //Start Code Change ---- 04.26.2006 #426 maha

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-07 By: Zhang Lingping
//$<reason> 

//update security_users set last_pass_update = today() where user_id = :is_from;
update security_users set last_pass_update = getdate() where user_id = :is_from;
//---------------------------- APPEON END ----------------------------

commit using sqlca;


end event

type cb_10 from commandbutton within w_security_set
integer x = 78
integer y = 508
integer width = 800
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reset Password to 123"
end type

event clicked;string ls_sql

if of_no_user() = -1 then return //Start Code Change ---- 04.26.2006 #426 maha

if isnull(is_from) or is_from = "" then
	messagebox("select Error","You must select a user.")
	return
end if

//ls_sql = "Grant connect to " + is_from  + " identified by '123';"
//maha 122205 resetting per new dba connections
ls_sql =  "update security_users set user_password = '123' where user_id = '" + is_from + "';"
execute immediate :ls_sql using sqlca;
commit using sqlca;


//DECLARE ChangePassword PROCEDURE FOR dbo.sp_password  
//         @caller_pswd = :gs_password,   
//         @new_pswd = :ls_password,   
//         @login_name = :gs_user_id  ;
//
//EXECUTE ChangePassword;
end event

type cb_9 from commandbutton within w_security_set
integer x = 78
integer y = 620
integer width = 800
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Drop Catalog tables"
end type

event clicked;string ls_sql

if of_no_user() = -1 then return //Start Code Change ---- 04.26.2006 #426 maha

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

ls_sql = "Drop table " + is_from  + ".pbcatcol;"
messagebox("ls_sql",ls_sql)
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "drop table " + is_from  + ".pbcatedt;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "drop table " + is_from  + ".pbcatfmt;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "drop table " + is_from  + ".pbcattbl;"
execute immediate :ls_sql using sqlca;
commit using sqlca;

ls_sql = "drop table " + is_from  + ".pbcatvld;"
execute immediate :ls_sql using sqlca;
commit using sqlca;


//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------


end event

type cb_8 from commandbutton within w_security_set
integer x = 78
integer y = 732
integer width = 818
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Null All Password Exp Dates"
end type

event clicked;//maha 031605 to reset all exp dates on passwords
integer i

i = messagebox("Null exp Date","This will clear All user password expiration Dates. The expiration date for each user will be set the first time they log in.~r~rContinue?",question!,yesno!,2)

if i = 2 then return


update security_users set last_pass_update = null;

commit using sqlca;


end event

type cb_mod_user from commandbutton within w_security_set
integer x = 78
integer y = 840
integer width = 800
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Set IReport user to All"
end type

event clicked;//Start Code Change ---- 04.26.2006 #427 maha  //new function 
string ls_sql
integer i

i = messagebox("User Reset","This will reset to All all IntelliReports where the Modifiy User is the selected user.~r~rContinue?",question!,yesno!,2)

if i = 2 then return

if of_no_user() = -1 then return

//ls_sql = "Grant connect to " + is_from  + " identified by '123';"
//maha 122205 resetting per new dba connections
ls_sql =  "update conv_view set mod_user = 'All' where mod_user = : " + is_from + ";"
execute immediate :ls_sql using sqlca;
commit using sqlca;
//End Code Change---.2006


end event

type cb_7 from commandbutton within w_security_set
integer x = 2245
integer y = 32
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type st_2 from statictext within w_security_set
integer x = 1015
integer y = 128
integer width = 471
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Security Settings"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_security_set
integer x = 987
integer y = 160
integer width = 1829
integer height = 808
integer taborder = 70
string title = "none"
string dataobject = "d_icred_set_security"
boolean livescroll = true
end type

type st_1 from statictext within w_security_set
integer x = 73
integer y = 208
integer width = 343
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select User:"
boolean focusrectangle = false
end type

type dw_from from datawindow within w_security_set
integer x = 69
integer y = 280
integer width = 389
integer height = 88
integer taborder = 50
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_from = data
end event

type cb_3 from commandbutton within w_security_set
integer x = 2537
integer y = 32
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_security_set
integer x = 622
integer y = 280
integer width = 265
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("This program:","Designed for resetting a user password to 123 or to set the password expiration date to today to allow the user to change the password.~r.")
end event

type gb_1 from groupbox within w_security_set
integer x = 55
integer y = 124
integer width = 914
integer height = 848
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "User Functions"
end type

