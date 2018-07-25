$PBExportHeader$w_saml_config_setting.srw
forward
global type w_saml_config_setting from w_response
end type
type tab_setting from tab within w_saml_config_setting
end type
type tabpage_usermapping from u_saml_user_mapping within tab_setting
end type
type tabpage_usermapping from u_saml_user_mapping within tab_setting
end type
type tabpage_idpservers from u_saml_idpserver_config within tab_setting
end type
type tabpage_idpservers from u_saml_idpserver_config within tab_setting
end type
type tabpage_sp_application from u_saml_application_config within tab_setting
end type
type tabpage_sp_application from u_saml_application_config within tab_setting
end type
type tab_setting from tab within w_saml_config_setting
tabpage_usermapping tabpage_usermapping
tabpage_idpservers tabpage_idpservers
tabpage_sp_application tabpage_sp_application
end type
end forward

global type w_saml_config_setting from w_response
integer width = 4091
integer height = 1944
string title = "SAML Painter"
long backcolor = 33551856
event ue_do ( string as_parm )
tab_setting tab_setting
end type
global w_saml_config_setting w_saml_config_setting

event ue_do(string as_parm);Choose Case as_parm
	Case 'addidpserver'
		Tab_setting.Selecttab(2)
		Tab_setting.tabpage_idpservers.cb_add.event clicked()
	Case 'refresh_servername_dddw'
		Tab_setting.tabpage_usermapping.ue_refresh_dddw( )
End Choose

end event

on w_saml_config_setting.create
int iCurrent
call super::create
this.tab_setting=create tab_setting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_setting
end on

on w_saml_config_setting.destroy
call super::destroy
destroy(this.tab_setting)
end on

event open;call super::open;long 		ll_Handle,ll_LeftIndent,ll_TopIndent
integer 	li_Pos

// Get window message (Format: TYPE|USERID)
li_Pos = Pos(Message.StringParm, "|")
tab_setting.tabpage_usermapping.is_Type = Left(Message.StringParm, li_Pos - 1)
tab_setting.tabpage_usermapping.is_UserID = Right(Message.StringParm, Len(Message.StringParm) - li_Pos)
tab_setting.tabpage_usermapping.of_CreateUserTree("")

ll_Handle = tab_setting.tabpage_usermapping.of_FindUserTreeItem(tab_setting.tabpage_usermapping.is_UserID)
tab_setting.tabpage_usermapping.tv_user.SelectItem(ll_Handle)

end event

type tab_setting from tab within w_saml_config_setting
integer x = 23
integer y = 28
integer width = 4000
integer height = 1780
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_usermapping tabpage_usermapping
tabpage_idpservers tabpage_idpservers
tabpage_sp_application tabpage_sp_application
end type

on tab_setting.create
this.tabpage_usermapping=create tabpage_usermapping
this.tabpage_idpservers=create tabpage_idpservers
this.tabpage_sp_application=create tabpage_sp_application
this.Control[]={this.tabpage_usermapping,&
this.tabpage_idpservers,&
this.tabpage_sp_application}
end on

on tab_setting.destroy
destroy(this.tabpage_usermapping)
destroy(this.tabpage_idpservers)
destroy(this.tabpage_sp_application)
end on

type tabpage_usermapping from u_saml_user_mapping within tab_setting
integer x = 18
integer y = 100
integer width = 3963
integer height = 1664
string text = "User Mapping"
end type

event constructor;call super::constructor;iw_parent = tab_setting.GetParent()
end event

type tabpage_idpservers from u_saml_idpserver_config within tab_setting
integer x = 18
integer y = 100
integer width = 3963
integer height = 1664
string text = "Identity Provider Servers"
end type

event constructor;call super::constructor;iw_parent = tab_setting.GetParent()
end event

type tabpage_sp_application from u_saml_application_config within tab_setting
integer x = 18
integer y = 100
integer width = 3963
integer height = 1664
string text = "Service Provider Application"
end type

event constructor;call super::constructor;iw_parent = tab_setting.GetParent()
end event

