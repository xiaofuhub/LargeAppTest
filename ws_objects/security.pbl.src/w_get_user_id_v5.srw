$PBExportHeader$w_get_user_id_v5.srw
forward
global type w_get_user_id_v5 from window
end type
type sle_1 from singlelineedit within w_get_user_id_v5
end type
type cb_2 from commandbutton within w_get_user_id_v5
end type
type cb_1 from commandbutton within w_get_user_id_v5
end type
type st_1 from statictext within w_get_user_id_v5
end type
type st_2 from statictext within w_get_user_id_v5
end type
type st_3 from statictext within w_get_user_id_v5
end type
end forward

global type w_get_user_id_v5 from window
integer width = 1499
integer height = 656
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
st_2 st_2
st_3 st_3
end type
global w_get_user_id_v5 w_get_user_id_v5

on w_get_user_id_v5.create
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.Control[]={this.sle_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.st_2,&
this.st_3}
end on

on w_get_user_id_v5.destroy
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
end on

event open;//maha rebuilt this window 083105
// was previously inherited and code could not be modified
end event

type sle_1 from singlelineedit within w_get_user_id_v5
integer x = 183
integer y = 228
integer width = 398
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
integer limit = 10
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_get_user_id_v5
integer x = 928
integer y = 228
integer width = 293
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_get_user_id_v5
integer x = 617
integer y = 228
integer width = 288
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;String ls_retval
int  li_Count

ls_retval = trim(sle_1.Text )
IF ls_retval='' THEN
	messagebox("User name","Please enter a User Name.")
	return 
END IF

//Start Code Change ----11.10.2009 #V10 maha - removed this restriction; no longer necessary
//if IsNumber(ls_retval) then
//	Messagebox("Warning","User name cannot be all numbers.")
//	return 
//end if
//End Code Change---11.10.2009

if LenA(ls_retval) > 10 then 
	messagebox("User name","The user name can be only a maximum of 10 characters.")
	return 
else
	
	
 SELECT count(1)  
   INTO :li_Count  
   FROM security_users  
 where  upper(user_id)  =upper(:ls_retval); //Start Code Change ----02.13.2008 #V8 maha - added upper test

IF li_Count > 0 THEN
	sle_1.setfocus( )
	messagebox('User Name',"Current User Name already exists. Please re-enter another one.")
	return
END IF
	CloseWithReturn(Parent, ls_retval )
end if

end event

type st_1 from statictext within w_get_user_id_v5
integer x = 183
integer y = 132
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User ID"
boolean focusrectangle = false
end type

type st_2 from statictext within w_get_user_id_v5
integer x = 187
integer y = 348
integer width = 562
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "10 character maximum."
boolean focusrectangle = false
end type

type st_3 from statictext within w_get_user_id_v5
integer x = 197
integer y = 404
integer width = 722
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Default password will be 123."
boolean focusrectangle = false
end type

