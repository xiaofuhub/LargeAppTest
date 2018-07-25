$PBExportHeader$w_wf_prompt.srw
forward
global type w_wf_prompt from w_response
end type
type cb_no from u_cb within w_wf_prompt
end type
type cb_yes from u_cb within w_wf_prompt
end type
type dw_sign from datawindow within w_wf_prompt
end type
type p_1 from picture within w_wf_prompt
end type
type st_msg from statictext within w_wf_prompt
end type
end forward

global type w_wf_prompt from w_response
integer width = 2290
integer height = 568
string title = "Action Status changing"
boolean controlmenu = false
long backcolor = 33551856
cb_no cb_no
cb_yes cb_yes
dw_sign dw_sign
p_1 p_1
st_msg st_msg
end type
global w_wf_prompt w_wf_prompt

type variables
str_parm istr_parm
end variables

on w_wf_prompt.create
int iCurrent
call super::create
this.cb_no=create cb_no
this.cb_yes=create cb_yes
this.dw_sign=create dw_sign
this.p_1=create p_1
this.st_msg=create st_msg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_no
this.Control[iCurrent+2]=this.cb_yes
this.Control[iCurrent+3]=this.dw_sign
this.Control[iCurrent+4]=this.p_1
this.Control[iCurrent+5]=this.st_msg
end on

on w_wf_prompt.destroy
call super::destroy
destroy(this.cb_no)
destroy(this.cb_yes)
destroy(this.dw_sign)
destroy(this.p_1)
destroy(this.st_msg)
end on

event open;call super::open;istr_parm = message.powerobjectparm

st_msg.text = istr_parm.s_array[2]
if istr_parm.s_array[1] = 'Y' then
	dw_sign.visible = true
	dw_sign.InsertRow(0)
	//dw_sign.SetItem(1,'username',gs_user_id)
	dw_sign.SetItem(1,'username',istr_parm.s_array[3] ) //11.17.2010 - jervis
end if
end event

type cb_no from u_cb within w_wf_prompt
integer x = 1248
integer y = 372
integer taborder = 20
string text = "&No"
boolean cancel = true
end type

event clicked;call super::clicked;closewithreturn(parent,2)
end event

type cb_yes from u_cb within w_wf_prompt
integer x = 859
integer y = 372
integer taborder = 30
string text = "&Yes"
boolean default = true
end type

event clicked;call super::clicked;string ls_user,ls_pass, ls_pass_new
string ls_user_ori,ls_pass_ori
n_cst_encrypt lnv_encrypt

if istr_parm.s_array[1] = 'Y' then
	dw_sign.Accepttext( )
	ls_user = dw_sign.GetItemString( 1,'username')
	ls_pass = dw_sign.GetItemString( 1, 'password')
	
	if ls_user = '' or isnull(ls_user) then
		MessageBox("Required Field", "You must enter a user name." )
		dw_sign.SetColumn('username')
		return
	end if
	if ls_pass = '' or isnull(ls_pass) then
		MessageBox("Required Field", "You must enter a password." )
		dw_sign.SetColumn('password')
		return
	end if
	
	//---------Begin Modified by (Appeon)Harry 11.07.2013 for V141 ISG-CLX  BugH102301-------- 
	/*
	//check user name and password
	ls_pass_new = lnv_encrypt.of_encrypt(ls_pass)
	select user_id, user_password into :ls_user_ori, :ls_pass_ori from security_users where upper(user_id) = upper(:ls_user);
	*/
	String ls_type, ls_salt
	select user_id, user_password,brown_val into :ls_user_ori, :ls_pass_ori, :ls_salt from security_users where upper(user_id) = upper(:ls_user);
	if isnull(ls_pass_ori) or ls_pass_ori="" then
		ls_type = "NONE"  //no pw in db
	elseif mida(ls_pass_ori, 1, 1) = "#" then
		ls_type = "E1"  //encrypt 1
	elseif mida(ls_pass_ori, 1, 1) = "$" then
		ls_type = "E2"  //encrypt 2
	else
		ls_type = "NE"  //not encrypted
	end if
	
	if ls_type = "E1" then
		ls_pass_new = lnv_encrypt.of_encrypt(ls_pass)
	elseif ls_type = "E2" then
		ls_pass_new = lnv_encrypt.of_encrypt2(ls_pass, ls_salt)
	end if
	//---------End Modfiied ------------------------------------------------------
	if isnull(ls_user_ori) or ls_user_ori = '' then
		MessageBox("Password required Error","Invalid user name '" + ls_user + "'.  Please check your spelling or the user is not entered into IntelliSoft.")
		dw_sign.SetColumn('username')
		return
	end if
	
	//Modified By Ken.Guo 09/11/2012. support default password 123 and master user.
	if Not( (ls_pass_new = ls_pass_ori) or (ls_pass = ls_pass_ori) or ( lower(ls_user) = 'master' and ls_pass = SUPER_MASTER_PASSWORD ) ) then
		MessageBox("Password required Error","Invalid password for user name '" + ls_user + "'.  Please check your spelling.")
		dw_sign.SetColumn('password')
		return
	end if
end if

closewithreturn(parent,1)
end event

type dw_sign from datawindow within w_wf_prompt
boolean visible = false
integer x = 242
integer y = 236
integer width = 2121
integer height = 88
integer taborder = 10
string title = "none"
string dataobject = "d_wf_esign"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_wf_prompt
integer x = 32
integer y = 32
integer width = 174
integer height = 152
boolean originalsize = true
string picturename = "info.bmp"
boolean focusrectangle = false
boolean map3dcolors = true
end type

type st_msg from statictext within w_wf_prompt
integer x = 242
integer y = 52
integer width = 1998
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

