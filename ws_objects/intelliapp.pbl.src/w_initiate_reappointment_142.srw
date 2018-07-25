$PBExportHeader$w_initiate_reappointment_142.srw
forward
global type w_initiate_reappointment_142 from window
end type
type st_2 from statictext within w_initiate_reappointment_142
end type
type dw_1 from datawindow within w_initiate_reappointment_142
end type
type cb_2 from commandbutton within w_initiate_reappointment_142
end type
type cb_1 from commandbutton within w_initiate_reappointment_142
end type
type st_payor from statictext within w_initiate_reappointment_142
end type
type st_1 from statictext within w_initiate_reappointment_142
end type
end forward

global type w_initiate_reappointment_142 from window
integer x = 1056
integer y = 456
integer width = 2405
integer height = 492
boolean titlebar = true
string title = "Initiate Reappointment Process"
windowtype windowtype = response!
long backcolor = 81324524
st_2 st_2
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
st_payor st_payor
st_1 st_1
end type
global w_initiate_reappointment_142 w_initiate_reappointment_142

on w_initiate_reappointment_142.create
this.st_2=create st_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_payor=create st_payor
this.st_1=create st_1
this.Control[]={this.st_2,&
this.dw_1,&
this.cb_2,&
this.cb_1,&
this.st_payor,&
this.st_1}
end on

on w_initiate_reappointment_142.destroy
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_payor)
destroy(this.st_1)
end on

event open;Integer li_app_id

st_payor.Text = MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 )

li_app_id = Integer( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 100 ) )

IF li_app_id > 0 THEN
	dw_1.SetItem( 1, "app_id", li_app_id )
END IF


end event

type st_2 from statictext within w_initiate_reappointment_142
integer x = 59
integer y = 148
integer width = 832
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Reappointment Application"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_initiate_reappointment_142
integer x = 46
integer y = 240
integer width = 2290
integer height = 116
integer taborder = 30
string dataobject = "d_app_list"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject( SQLCA )
This.InsertRow( 0 )
end event

type cb_2 from commandbutton within w_initiate_reappointment_142
integer x = 1993
integer y = 104
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn ( w_initiate_reappointment, "Cancel" )
end event

type cb_1 from commandbutton within w_initiate_reappointment_142
integer x = 1993
integer y = 16
integer width = 283
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;CloseWithReturn( w_initiate_reappointment, dw_1.GetItemNumber( 1, "app_id" ) )
end event

type st_payor from statictext within w_initiate_reappointment_142
integer x = 1033
integer y = 40
integer width = 974
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 81324524
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_initiate_reappointment_142
integer x = 64
integer y = 40
integer width = 992
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Initiating the reappointment process for "
boolean focusrectangle = false
end type

