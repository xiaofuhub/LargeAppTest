$PBExportHeader$w_lost_provider_message.srw
forward
global type w_lost_provider_message from window
end type
type st_12 from statictext within w_lost_provider_message
end type
type cb_2 from commandbutton within w_lost_provider_message
end type
type st_11 from statictext within w_lost_provider_message
end type
type st_10 from statictext within w_lost_provider_message
end type
type cb_1 from commandbutton within w_lost_provider_message
end type
type st_9 from statictext within w_lost_provider_message
end type
type st_8 from statictext within w_lost_provider_message
end type
type st_7 from statictext within w_lost_provider_message
end type
type st_6 from statictext within w_lost_provider_message
end type
type st_5 from statictext within w_lost_provider_message
end type
type st_4 from statictext within w_lost_provider_message
end type
type st_3 from statictext within w_lost_provider_message
end type
type st_2 from statictext within w_lost_provider_message
end type
type st_1 from statictext within w_lost_provider_message
end type
end forward

global type w_lost_provider_message from window
integer width = 3031
integer height = 1368
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_12 st_12
cb_2 cb_2
st_11 st_11
st_10 st_10
cb_1 cb_1
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
end type
global w_lost_provider_message w_lost_provider_message

on w_lost_provider_message.create
this.st_12=create st_12
this.cb_2=create cb_2
this.st_11=create st_11
this.st_10=create st_10
this.cb_1=create cb_1
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.Control[]={this.st_12,&
this.cb_2,&
this.st_11,&
this.st_10,&
this.cb_1,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1}
end on

on w_lost_provider_message.destroy
destroy(this.st_12)
destroy(this.cb_2)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.cb_1)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
end on

type st_12 from statictext within w_lost_provider_message
integer x = 955
integer y = 16
integer width = 1147
integer height = 116
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Searching for missing providers:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_lost_provider_message
integer x = 178
integer y = 1216
integer width = 777
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Appointment Aberations Check"
end type

event clicked;openwithparm(w_utl_multi_nonhist_check, "P")
end event

type st_11 from statictext within w_lost_provider_message
integer x = 69
integer y = 612
integer width = 2839
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "2. Search on All Facilities rather than just a single one."
boolean focusrectangle = false
end type

type st_10 from statictext within w_lost_provider_message
integer x = 169
integer y = 1120
integer width = 2519
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The Orphan Basic files check will look for provider records that have no appointment records."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_lost_provider_message
integer x = 1312
integer y = 1216
integer width = 398
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

type st_9 from statictext within w_lost_provider_message
integer x = 165
integer y = 1040
integer width = 2702
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The Purged files check will look for providers that have been set to purge in preparation for Deletion."
boolean focusrectangle = false
end type

type st_8 from statictext within w_lost_provider_message
integer x = 155
integer y = 964
integer width = 2039
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "The History only check will look for providers that have only history records."
boolean focusrectangle = false
end type

type st_7 from statictext within w_lost_provider_message
integer x = 69
integer y = 892
integer width = 2615
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "To check to see if the provider still has data in the system run the Appointment Aberation Check."
boolean focusrectangle = false
end type

type st_6 from statictext within w_lost_provider_message
integer x = 69
integer y = 684
integer width = 2839
integer height = 212
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "3. The most common cause of ~'missing~' providers is a change to the Appointment Status.  For the provider to appear on the search screen there must be an appointment records set to Active, Inactive or Pending."
boolean focusrectangle = false
end type

type st_5 from statictext within w_lost_provider_message
integer x = 69
integer y = 540
integer width = 2839
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "1. Search on another value than last name, for example SSN or NPI."
boolean focusrectangle = false
end type

type st_4 from statictext within w_lost_provider_message
integer x = 69
integer y = 468
integer width = 2839
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Things to try:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_lost_provider_message
integer x = 69
integer y = 292
integer width = 2821
integer height = 152
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reasons can include Facility Rights, improper changes to the Appointment Status, and inadvertent changes to the provider last name. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_lost_provider_message
integer x = 69
integer y = 220
integer width = 2839
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "There are several reasons why a provider may become unsearchable."
boolean focusrectangle = false
end type

type st_1 from statictext within w_lost_provider_message
integer x = 69
integer y = 148
integer width = 2839
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Just because a provider is ~'lost~' (unsearchable) it does not necessarily mean the provider data is gone."
boolean focusrectangle = false
end type

