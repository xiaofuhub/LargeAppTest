$PBExportHeader$w_wv_email_setting.srw
forward
global type w_wv_email_setting from window
end type
type rb_compl from radiobutton within w_wv_email_setting
end type
type rb_normal from radiobutton within w_wv_email_setting
end type
type dw_detail from datawindow within w_wv_email_setting
end type
type cb_close from commandbutton within w_wv_email_setting
end type
type cb_save from commandbutton within w_wv_email_setting
end type
end forward

global type w_wv_email_setting from window
integer width = 2487
integer height = 1048
boolean titlebar = true
string title = "WebView Email Setting"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_compl rb_compl
rb_normal rb_normal
dw_detail dw_detail
cb_close cb_close
cb_save cb_save
end type
global w_wv_email_setting w_wv_email_setting

type variables
String is_type = 'NORMAL'  //NORMAL: Send normal WV email / COMPLETE:Auto Send email when complete.
end variables

forward prototypes
public subroutine of_set_dataobject ()
end prototypes

public subroutine of_set_dataobject ();//====================================================================
//$<Function>: of_set_dataobject
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.06.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If is_type = 'NORMAL'  Then//NORMAL: Send normal WV email / COMPLETE:Auto Send email when complete.
	dw_detail.dataobject = 'd_wv_email_setting'
	dw_detail.SetTransobject(sqlca);
	dw_Detail.Retrieve()
	
	if isNull(dw_detail.getItemNumber(1,"email_to")) then
		dw_detail.setitem( 1,"email_to",1)
	end if
ElseIf is_type = 'COMPLETE' Then
	dw_detail.dataobject = 'd_wv_email_setting_compl'
	dw_detail.SetTransobject(sqlca);
	dw_Detail.Retrieve()
Else
	Return
End if
end subroutine

on w_wv_email_setting.create
this.rb_compl=create rb_compl
this.rb_normal=create rb_normal
this.dw_detail=create dw_detail
this.cb_close=create cb_close
this.cb_save=create cb_save
this.Control[]={this.rb_compl,&
this.rb_normal,&
this.dw_detail,&
this.cb_close,&
this.cb_save}
end on

on w_wv_email_setting.destroy
destroy(this.rb_compl)
destroy(this.rb_normal)
destroy(this.dw_detail)
destroy(this.cb_close)
destroy(this.cb_save)
end on

event open;//added by long.zhang appeon 12.19.2012 v12.3 pracview Email

dw_detail.settransobject( sqlca)
dw_detail.retrieve( )


if isNull(dw_detail.getItemNumber(1,"email_to")) then
		dw_detail.setitem( 1,"email_to",1)
end if
end event

type rb_compl from radiobutton within w_wv_email_setting
integer x = 462
integer y = 52
integer width = 530
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "WV Completed"
end type

event clicked;//Added by Appeon long.zhang 07.06.2017 (v15.4 WebView Email Notifications)
If This.Checked Then
	is_type = 'COMPLETE' 
	of_set_dataobject()
End If
end event

type rb_normal from radiobutton within w_wv_email_setting
integer x = 78
integer y = 52
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Normal"
boolean checked = true
end type

event clicked;//Added by Appeon long.zhang 07.06.2017 (v15.4 WebView Email Notifications)
If This.Checked Then
	is_type = 'NORMAL' 	
	of_set_dataobject()
End If
end event

type dw_detail from datawindow within w_wv_email_setting
integer x = 46
integer y = 172
integer width = 2405
integer height = 764
integer taborder = 30
string title = "none"
string dataobject = "d_wv_email_setting"
boolean border = false
boolean livescroll = true
end type

event itemchanged;//added by long.zhang appeon 12.19.2012 v12.3 pracview Email
long ll_null

if dwo.name = "email_to" then
	
		if data <> "3" then
			setNull(ll_null)
			this.setitem( row,"role_id",ll_null)
		end if
		
end if
end event

event buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.06.2017 (v15.4 WebView Email Notifications)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String  ls_user_id

If is_type = 'COMPLETE' Then
	if dwo.name = 'b_email' then
			ls_user_id = this.getitemstring( 1,'sender_email_compl')
			if not isNull(ls_user_id) then
				OpenWithParm(w_email_account_edit,"RECRUIT|" + ls_user_id)  //use the same logic as w_recruitment_settings
			end if	
	end if
End If
end event

type cb_close from commandbutton within w_wv_email_setting
integer x = 2098
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_wv_email_setting
integer x = 1728
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;//added by long.zhang 12.19.2012 v12.3 pracview Email
dw_detail.accepttext( )

if dw_detail.modifiedcount( ) = 0 then return

If  is_type = 'NORMAL' Then
	if dw_detail.getitemnumber( 1,"email_to") = 3 then
		
				if isNull(dw_detail.getItemNumber(1,"role_id")) then
					MessageBox("Prompt","Required value missing for the Role Id, please select a value. ")
					return -1		
			end if
			
	end if
ElseIf is_type = 'COMPLETE' Then //Added by Appeon long.zhang 07.06.2017 (v15.4 WebView Email Notifications)
	If dw_detail.getItemNumber(1,"active_status") = 1  then
		if isNull(dw_detail.getItemString(1,"sender_email_compl"))  then
				MessageBox("Prompt","Required value missing for the Email From, please select a value. ")
				dw_detail.SetColumn("sender_email_compl")
				dw_detail.SetFocus()
				return -1		
		end if
	
		if isNull(dw_detail.getItemNumber(1,"email_template_compl"))  then
				MessageBox("Prompt","Required value missing for the Email Template, please select a value. ")
				dw_detail.SetColumn("email_template_compl")
				dw_detail.SetFocus()
				return -1		
		end if
	End If
End If

dw_detail.update()
end event

