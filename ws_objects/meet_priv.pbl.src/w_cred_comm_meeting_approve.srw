$PBExportHeader$w_cred_comm_meeting_approve.srw
forward
global type w_cred_comm_meeting_approve from w_sheet
end type
type cb_close from commandbutton within w_cred_comm_meeting_approve
end type
type uo_meeting from uo_meet_approval within w_cred_comm_meeting_approve
end type
end forward

global type w_cred_comm_meeting_approve from w_sheet
integer width = 3552
integer height = 1932
string title = "Meeting Approval"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_close cb_close
uo_meeting uo_meeting
end type
global w_cred_comm_meeting_approve w_cred_comm_meeting_approve

type variables

end variables

on w_cred_comm_meeting_approve.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.uo_meeting=create uo_meeting
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.uo_meeting
end on

on w_cred_comm_meeting_approve.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.uo_meeting)
end on

event open;call super::open;long ll_meeting

//ll_meeting = message.doubleparm
//messagebox("id", ll_meeting)
//note: the meeting id is set in the constructor of the uo because of the regiester calendar function changing the message value

uo_meeting.of_set_one()
uo_meeting.of_get_pracs( )
end event

event closequery;return 0
end event

type cb_close from commandbutton within w_cred_comm_meeting_approve
integer x = 3063
integer y = 60
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type uo_meeting from uo_meet_approval within w_cred_comm_meeting_approve
integer y = 4
integer taborder = 60
end type

on uo_meeting.destroy
call uo_meet_approval::destroy
end on

