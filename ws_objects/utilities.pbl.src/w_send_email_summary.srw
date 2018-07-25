$PBExportHeader$w_send_email_summary.srw
forward
global type w_send_email_summary from w_response
end type
type st_result from statictext within w_send_email_summary
end type
type cb_report from commandbutton within w_send_email_summary
end type
type cb_close from commandbutton within w_send_email_summary
end type
type st_info from statictext within w_send_email_summary
end type
end forward

global type w_send_email_summary from w_response
integer width = 1399
integer height = 336
string title = "Email Alert Complete"
long backcolor = 33551856
st_result st_result
cb_report cb_report
cb_close cb_close
st_info st_info
end type
global w_send_email_summary w_send_email_summary

on w_send_email_summary.create
int iCurrent
call super::create
this.st_result=create st_result
this.cb_report=create cb_report
this.cb_close=create cb_close
this.st_info=create st_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_result
this.Control[iCurrent+2]=this.cb_report
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.st_info
end on

on w_send_email_summary.destroy
call super::destroy
destroy(this.st_result)
destroy(this.cb_report)
destroy(this.cb_close)
destroy(this.st_info)
end on

event pfc_preopen;call super::pfc_preopen;str_pass lstr_pass

lstr_pass = Message.powerobjectparm
If UpperBound(lstr_pass.s_long[]) = 3 Then 
	st_info.text   = 'The system has sent '+String(lstr_pass.s_long[1]) + ' email alerts.' 
	st_result.text = 'Results    Successful:'+String(lstr_pass.s_long[3])+'     Failed:'+String(lstr_pass.s_long[2])
End If

If lstr_pass.s_long[2] > 0 Then
	st_info.textcolor = RGB(255,0,0)
	st_result.textcolor = RGB(255,0,0)
End If

If lstr_pass.s_long[1] = 0 Then
	cb_report.enabled = False
End if
end event

type st_result from statictext within w_send_email_summary
integer x = 32
integer y = 124
integer width = 942
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Results    Successful:5     Failed:0"
boolean focusrectangle = false
end type

type cb_report from commandbutton within w_send_email_summary
integer x = 992
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Report..."
end type

event clicked;CloseWithReturn(Parent,1)
end event

type cb_close from commandbutton within w_send_email_summary
integer x = 992
integer y = 132
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
boolean default = true
end type

event clicked;CloseWithReturn(Parent,0)
end event

type st_info from statictext within w_send_email_summary
integer x = 27
integer y = 52
integer width = 942
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The system has sent 5 email alerts."
boolean focusrectangle = false
end type

