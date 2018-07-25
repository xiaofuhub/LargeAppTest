$PBExportHeader$w_weblink_settings.srw
forward
global type w_weblink_settings from w_response
end type
type cb_default from commandbutton within w_weblink_settings
end type
type cb_1 from commandbutton within w_weblink_settings
end type
type st_1 from statictext within w_weblink_settings
end type
type dw_weblink from u_dw within w_weblink_settings
end type
type cb_ok from commandbutton within w_weblink_settings
end type
type cb_cancel from commandbutton within w_weblink_settings
end type
end forward

global type w_weblink_settings from w_response
integer width = 2286
integer height = 632
string title = "Web Link Settings"
long backcolor = 33551856
event sys_command pbm_syscommand
cb_default cb_default
cb_1 cb_1
st_1 st_1
dw_weblink dw_weblink
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_weblink_settings w_weblink_settings

type variables

end variables

event sys_command;If message.wordparm = 61536 Then
	cb_cancel.Trigger Event Clicked()
End If

end event

on w_weblink_settings.create
int iCurrent
call super::create
this.cb_default=create cb_default
this.cb_1=create cb_1
this.st_1=create st_1
this.dw_weblink=create dw_weblink
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_default
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_weblink
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
end on

on w_weblink_settings.destroy
call super::destroy
destroy(this.cb_default)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.dw_weblink)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_weblink_settings::open()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-31 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_ie_url,ls_web_link

dw_weblink.SetTransObject(SQLCA)
dw_weblink.Retrieve()
This.of_setalwaysvalidate( True)

If dw_weblink.GetItemString(1,'web_link_name') = '' &
	Or Isnull(dw_weblink.GetItemString(1,'web_link_name')) Then
		ls_ie_url = AppeonGetIEURL()
		If left(lower(ls_ie_url),7) = 'http://' Then
			ls_ie_url = 'http://' + Mid(ls_ie_url,8,len(ls_ie_url))
		ElseIf left(lower(ls_ie_url),8) = 'https://' Then
			ls_ie_url = 'https://' + Mid(ls_ie_url,9,len(ls_ie_url))
		End If
		If ls_ie_url <> '' Then
			ls_ie_url = Mid(ls_ie_url,1,Len(ls_ie_url) - 1) //Cut last '/'
			ls_web_link = Mid(ls_ie_url,1,LastPos(ls_ie_url,'/')) //Cut application root name
			ls_web_link = ls_web_link + 'fileservice/'
			dw_weblink.SetItem(1,'web_link_name',ls_web_link)
		End If
End If

If dw_weblink.GetItemString(1,'cache_name') = '' &
	Or Isnull(dw_weblink.GetItemString(1,'cache_name')) Then
		dw_weblink.SetItem(1,'cache_name',gs_cachename)
End If

dw_weblink.SetItemStatus(1,0,Primary!,NotModified!)


end event

event close;//Override ancestor script
end event

type cb_default from commandbutton within w_weblink_settings
integer x = 1870
integer y = 364
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Default"
end type

event clicked;String ls_ie_url,ls_web_link

ls_ie_url = AppeonGetIEURL()
If left(lower(ls_ie_url),7) = 'http://' Then
	ls_ie_url = 'http://' + Mid(ls_ie_url,8,len(ls_ie_url))
ElseIf left(lower(ls_ie_url),8) = 'https://' Then
	ls_ie_url = 'https://' + Mid(ls_ie_url,9,len(ls_ie_url))	
End If
If ls_ie_url <> '' Then
	ls_ie_url = Mid(ls_ie_url,1,Len(ls_ie_url) - 1) //Cut last '/'
	ls_web_link = Mid(ls_ie_url,1,LastPos(ls_ie_url,'/')) //Cut application root name
	ls_web_link = ls_web_link + 'fileservice/'
	dw_weblink.SetItem(1,'web_link_name',ls_web_link)
End If

dw_weblink.SetItem(1,'cache_name',gs_cachename)

end event

type cb_1 from commandbutton within w_weblink_settings
integer x = 1870
integer y = 260
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ping"
end type

event clicked;String ls_cachename,ls_link,ls_Null
int li_pos
n_tr TR_WEBLINK

SetNull(ls_Null)
This.enabled = False
dw_weblink.Accepttext()
TR_WEBLINK = Create n_tr

//ping database
ls_link = Trim(dw_weblink.GetItemString(1,'web_link_name'))
ls_cachename = Trim(dw_weblink.GetItemString(1,'cache_name'))
TR_WEBLINK.AutoCommit = True
TR_WEBLINK.DBMS = 'ODB-MSS'
TR_WEBLINK.DBParm = "CacheName='" + ls_cachename + "'"
Connect USING TR_WEBLINK;
IF TR_WEBLINK.SQLCODE = -1 THEN
	MessageBox("Error", "Failed to connect the database '" +ls_cachename+ "'")
	This.enabled = True
	Destroy TR_WEBLINK
	Return -1
END IF
DisConnect USING TR_WEBLINK;

//ping web link
If Right(ls_link,1) = '/' Then
	ls_link += 'ping.htm'
Else
	ls_link += '/ping.htm'	 
End If
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_link , ls_Null, 4)	   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_link , ls_Null, 4)	 //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

This.enabled = True
Destroy TR_WEBLINK
end event

type st_1 from statictext within w_weblink_settings
boolean visible = false
integer x = 32
integer y = 456
integer width = 1819
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Attention: Web Link Settings will use default value if  data is not entered."
boolean focusrectangle = false
end type

type dw_weblink from u_dw within w_weblink_settings
integer x = 46
integer y = 12
integer width = 1787
integer height = 472
integer taborder = 10
string dataobject = "d_weblink_settings"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;This.of_setupdateable( True)

end event

event pfc_validation;call super::pfc_validation;//////////////////////////////////////////////////////////////////////
// $<event>dw_weblink::pfc_validation()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-03-30 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_weblink_name
This.AcceptText()
ls_weblink_name = dw_weblink.GetItemString(1,'web_link_name')

If ls_weblink_name =  '' Or Isnull(ls_weblink_name) Then Return 1
If Left(trim( Lower( ls_weblink_name )),4) <> 'http' Then
	Return -1
End If
Return 1
end event

type cb_ok from commandbutton within w_weblink_settings
integer x = 1870
integer y = 52
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

event clicked;If dw_weblink.update() = 1 Then
	Commit;
Else
	Rollback;
	Messagebox('Save Error','Failed to save data, please call support.')
	Return -1
End If

Close(Parent)
Return 1
end event

type cb_cancel from commandbutton within w_weblink_settings
integer x = 1870
integer y = 156
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

