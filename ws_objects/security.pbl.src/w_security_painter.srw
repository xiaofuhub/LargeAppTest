$PBExportHeader$w_security_painter.srw
forward
global type w_security_painter from window
end type
type st_1 from statictext within w_security_painter
end type
type cb_image_sec from commandbutton within w_security_painter
end type
type cb_report from commandbutton within w_security_painter
end type
type cb_reset from commandbutton within w_security_painter
end type
type cb_audit from commandbutton within w_security_painter
end type
type dw_2 from datawindow within w_security_painter
end type
type cb_save from commandbutton within w_security_painter
end type
type dw_1 from datawindow within w_security_painter
end type
type cb_close from commandbutton within w_security_painter
end type
end forward

global type w_security_painter from window
integer x = 965
integer y = 256
integer width = 3195
integer height = 2692
boolean titlebar = true
string title = "Security Settings"
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 33551856
st_1 st_1
cb_image_sec cb_image_sec
cb_report cb_report
cb_reset cb_reset
cb_audit cb_audit
dw_2 dw_2
cb_save cb_save
dw_1 dw_1
cb_close cb_close
end type
global w_security_painter w_security_painter

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

on w_security_painter.create
this.st_1=create st_1
this.cb_image_sec=create cb_image_sec
this.cb_report=create cb_report
this.cb_reset=create cb_reset
this.cb_audit=create cb_audit
this.dw_2=create dw_2
this.cb_save=create cb_save
this.dw_1=create dw_1
this.cb_close=create cb_close
this.Control[]={this.st_1,&
this.cb_image_sec,&
this.cb_report,&
this.cb_reset,&
this.cb_audit,&
this.dw_2,&
this.cb_save,&
this.dw_1,&
this.cb_close}
end on

on w_security_painter.destroy
destroy(this.st_1)
destroy(this.cb_image_sec)
destroy(this.cb_report)
destroy(this.cb_reset)
destroy(this.cb_audit)
destroy(this.dw_2)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.cb_close)
end on

event open;//Start Code Change ---- 10.03.2006 #1 maha new window
// Holds settings for specific password security functionality
DataWindowChild dwchild

dw_1.settransobject(sqlca)
dw_1.retrieve()

dw_2.settransobject(sqlca)
dw_2.retrieve()

if of_get_app_setting("set_60","I") = 0 or w_mdi.of_security_access(7195) = 0 then cb_report.visible = false	//added by long.zhang 09.23.2011	

//Start Code Change ----08.11.2014 #V14.2 maha
if w_mdi.of_security_access( 7765 ) = 0   then   cb_reset.visible = false




end event

type st_1 from statictext within w_security_painter
integer x = 2199
integer y = 540
integer width = 850
integer height = 1476
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "NOTE: If using Auto-Logon settings for Users, these Login Settings are ignored by the program as they are controlled by the network login policies."
boolean border = true
boolean focusrectangle = false
end type

type cb_image_sec from commandbutton within w_security_painter
integer x = 1134
integer y = 32
integer width = 677
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Image Type User Security"
end type

event clicked;string s

s = "ALL*S@ALL"
openwithparm(w_image_user_access,s)
end event

type cb_report from commandbutton within w_security_painter
integer x = 1838
integer y = 32
integer width = 677
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&IntelliReport User Security"
end type

event clicked;string s

s = "ALL*S@ALL"
openwithparm(w_ireport_user_access,s)
end event

type cb_reset from commandbutton within w_security_painter
integer x = 585
integer y = 32
integer width = 503
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&User Reset Utilities"
end type

event clicked;open(w_user_reset)
end event

type cb_audit from commandbutton within w_security_painter
integer x = 9
integer y = 32
integer width = 503
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Login Audit Report"
end type

event clicked;open(w_login_audit)
end event

type dw_2 from datawindow within w_security_painter
integer y = 432
integer width = 3136
integer height = 2136
integer taborder = 80
string title = "none"
string dataobject = "d_security_settings"
boolean livescroll = true
end type

event doubleclicked;string s

if dwo.name <> "banner_text" then return 0  //Start Code Change ----08.13.2009 #V92 maha

openwithparm(w_expand_text,this.getitemstring(row,"banner_text"))

s = message.stringparm

if upper(s) = "CANCEL" then
	return
else
	this.setitem(row,"Banner_text",s)
end if
end event

event buttonclicked; //Start Code Change ----12.10.2015 #V15 maha - added
string s

if dwo.name = "b_mess" then
	s = "If set to Minimum the failure message for User id or Password will be generic, not specifying which is in correct.  For max attempts, the message will not display the number of attempts."
	s+= "~n~nStandard will provider the user with more information: User id or Password was wrong and the max number of attempts."
	s+= "~n~nMaximum is like Standard, but will also provide the lockout length of time."
	messagebox("About Login Messages",s)
elseif dwo.name = "b_lock" then
	s = "If this is set to No Lock Out, the program will allow 3 attempts before closing the Program.  The user will be able to attempt to login in immediately."
	s+= "~n~nOtherwise the user will have the specified number of attempts to login.  If the user fails the login will be locked out for the specificed number of minutes."
	messagebox("About Attempts",s)
elseif dwo.name = "b_quest" then 	 //Start Code Change ----02.16.2017 #V153 maha - moved from screen button
	open(w_security_quest_lookup)
elseif dwo.name = "b_expand" then 	 //Start Code Change ----02.16.2017 #V153 maha - moved from screen button
	OpenWithParm( w_expand_text, This.GetItemString( row, "banner_text"  ))

	IF Message.StringParm = "Cancel" THEN
		Return -1
	ELSE
		s = Message.StringParm
		This.SetItem( row ,  "banner_text" , s )
	END IF
	
end if


end event

type cb_save from commandbutton within w_security_painter
integer x = 2546
integer y = 32
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;dw_1.update()
dw_2.update()

end event

type dw_1 from datawindow within w_security_painter
integer y = 132
integer width = 3136
integer height = 292
integer taborder = 70
string title = "none"
string dataobject = "d_icred_set_security"
boolean livescroll = true
end type

event itemchanged;//Start Code Change ----11.16.2016 #V153 maha - added
integer res
date ld_password

if dwo.name = "set_36" then
	if long(data) > 0 then
		messagebox("Expiration days","Do you want to set all logins to expire " + data + " days from today?~r If not, the expiration for the user will be set on the next login.", question!,yesno!,1)
		ld_password = RelativeDate ( Today(),long(data))			
		UPDATE security_users Set last_pass_update = :ld_password;
	elseif long(data) = 0 then
		messagebox("Expiration days","Do you want to clear any existing expiration dates for logins?", question!,yesno!,1)
		UPDATE security_users Set last_pass_update = null;
	end if
end if

end event

type cb_close from commandbutton within w_security_painter
integer x = 2857
integer y = 32
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)
end event

