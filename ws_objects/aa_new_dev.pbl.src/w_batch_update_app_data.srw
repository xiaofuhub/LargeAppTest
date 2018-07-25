$PBExportHeader$w_batch_update_app_data.srw
forward
global type w_batch_update_app_data from window
end type
type dw_9 from datawindow within w_batch_update_app_data
end type
type rb_2 from radiobutton within w_batch_update_app_data
end type
type rb_1 from radiobutton within w_batch_update_app_data
end type
type cb_3 from commandbutton within w_batch_update_app_data
end type
type cb_2 from commandbutton within w_batch_update_app_data
end type
type cb_1 from commandbutton within w_batch_update_app_data
end type
type st_8 from statictext within w_batch_update_app_data
end type
type st_7 from statictext within w_batch_update_app_data
end type
type st_6 from statictext within w_batch_update_app_data
end type
type st_5 from statictext within w_batch_update_app_data
end type
type st_4 from statictext within w_batch_update_app_data
end type
type st_3 from statictext within w_batch_update_app_data
end type
type st_2 from statictext within w_batch_update_app_data
end type
type st_1 from statictext within w_batch_update_app_data
end type
type dw_4 from datawindow within w_batch_update_app_data
end type
type dw_3 from datawindow within w_batch_update_app_data
end type
type dw_2 from datawindow within w_batch_update_app_data
end type
type dw_1 from datawindow within w_batch_update_app_data
end type
type gb_1 from groupbox within w_batch_update_app_data
end type
type dw_5 from datawindow within w_batch_update_app_data
end type
type dw_8 from datawindow within w_batch_update_app_data
end type
type dw_7 from datawindow within w_batch_update_app_data
end type
type dw_6 from datawindow within w_batch_update_app_data
end type
type gb_2 from groupbox within w_batch_update_app_data
end type
type gb_3 from groupbox within w_batch_update_app_data
end type
end forward

global type w_batch_update_app_data from window
integer width = 3904
integer height = 2664
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_9 dw_9
rb_2 rb_2
rb_1 rb_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
dw_5 dw_5
dw_8 dw_8
dw_7 dw_7
dw_6 dw_6
gb_2 gb_2
gb_3 gb_3
end type
global w_batch_update_app_data w_batch_update_app_data

on w_batch_update_app_data.create
this.dw_9=create dw_9
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.dw_5=create dw_5
this.dw_8=create dw_8
this.dw_7=create dw_7
this.dw_6=create dw_6
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.dw_9,&
this.rb_2,&
this.rb_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.gb_1,&
this.dw_5,&
this.dw_8,&
this.dw_7,&
this.dw_6,&
this.gb_2,&
this.gb_3}
end on

on w_batch_update_app_data.destroy
destroy(this.dw_9)
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.dw_5)
destroy(this.dw_8)
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type dw_9 from datawindow within w_batch_update_app_data
integer x = 50
integer y = 600
integer width = 3735
integer height = 1888
integer taborder = 40
string title = "none"
string dataobject = "d_net_dev_action_items_sk"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type rb_2 from radiobutton within w_batch_update_app_data
integer x = 507
integer y = 52
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Delete"
end type

type rb_1 from radiobutton within w_batch_update_app_data
integer x = 114
integer y = 52
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Update"
end type

type cb_3 from commandbutton within w_batch_update_app_data
integer x = 3438
integer y = 20
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type cb_2 from commandbutton within w_batch_update_app_data
integer x = 3077
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

type cb_1 from commandbutton within w_batch_update_app_data
integer x = 2697
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

type st_8 from statictext within w_batch_update_app_data
integer x = 2990
integer y = 464
integer width = 699
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Status"
boolean focusrectangle = false
end type

type st_7 from statictext within w_batch_update_app_data
integer x = 2135
integer y = 464
integer width = 763
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Action Type"
boolean focusrectangle = false
end type

type st_6 from statictext within w_batch_update_app_data
integer x = 1157
integer y = 464
integer width = 878
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Application"
boolean focusrectangle = false
end type

type st_5 from statictext within w_batch_update_app_data
integer x = 101
integer y = 468
integer width = 878
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Group"
boolean focusrectangle = false
end type

type st_4 from statictext within w_batch_update_app_data
integer x = 101
integer y = 224
integer width = 878
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Group"
boolean focusrectangle = false
end type

type st_3 from statictext within w_batch_update_app_data
integer x = 1157
integer y = 224
integer width = 878
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Application"
boolean focusrectangle = false
end type

type st_2 from statictext within w_batch_update_app_data
integer x = 2135
integer y = 224
integer width = 763
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Action Type"
boolean focusrectangle = false
end type

type st_1 from statictext within w_batch_update_app_data
integer x = 2994
integer y = 224
integer width = 699
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Status"
boolean focusrectangle = false
end type

type dw_4 from datawindow within w_batch_update_app_data
integer x = 2962
integer y = 208
integer width = 782
integer height = 96
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_batch_update_app_data
integer x = 2107
integer y = 208
integer width = 827
integer height = 96
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_batch_update_app_data
integer x = 1097
integer y = 208
integer width = 987
integer height = 96
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_1 from datawindow within w_batch_update_app_data
integer x = 69
integer y = 208
integer width = 987
integer height = 96
integer taborder = 10
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_batch_update_app_data
integer x = 32
integer width = 827
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Batch Function"
end type

type dw_5 from datawindow within w_batch_update_app_data
integer x = 2962
integer y = 448
integer width = 782
integer height = 96
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_8 from datawindow within w_batch_update_app_data
integer x = 69
integer y = 448
integer width = 987
integer height = 96
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_7 from datawindow within w_batch_update_app_data
integer x = 1097
integer y = 448
integer width = 987
integer height = 96
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_6 from datawindow within w_batch_update_app_data
integer x = 2107
integer y = 448
integer width = 827
integer height = 96
integer taborder = 20
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_batch_update_app_data
integer x = 23
integer y = 376
integer width = 3771
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Update Values"
end type

type gb_3 from groupbox within w_batch_update_app_data
integer x = 23
integer y = 136
integer width = 3771
integer height = 196
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Search Parameters"
end type

