$PBExportHeader$w_printed_app_mockup.srw
forward
global type w_printed_app_mockup from window
end type
type rb_save from radiobutton within w_printed_app_mockup
end type
type rb_fax from radiobutton within w_printed_app_mockup
end type
type rb_email from radiobutton within w_printed_app_mockup
end type
type rb_print from radiobutton within w_printed_app_mockup
end type
type cb_2 from commandbutton within w_printed_app_mockup
end type
type cb_1 from commandbutton within w_printed_app_mockup
end type
type dw_1 from datawindow within w_printed_app_mockup
end type
type gb_2 from groupbox within w_printed_app_mockup
end type
end forward

global type w_printed_app_mockup from window
integer width = 3017
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
rb_save rb_save
rb_fax rb_fax
rb_email rb_email
rb_print rb_print
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_2 gb_2
end type
global w_printed_app_mockup w_printed_app_mockup

on w_printed_app_mockup.create
this.rb_save=create rb_save
this.rb_fax=create rb_fax
this.rb_email=create rb_email
this.rb_print=create rb_print
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_2=create gb_2
this.Control[]={this.rb_save,&
this.rb_fax,&
this.rb_email,&
this.rb_print,&
this.cb_2,&
this.cb_1,&
this.dw_1,&
this.gb_2}
end on

on w_printed_app_mockup.destroy
destroy(this.rb_save)
destroy(this.rb_fax)
destroy(this.rb_email)
destroy(this.rb_print)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve(307)
end event

type rb_save from radiobutton within w_printed_app_mockup
integer x = 919
integer y = 68
integer width = 306
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Save only"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("S")
end event

type rb_fax from radiobutton within w_printed_app_mockup
integer x = 640
integer y = 68
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Fax"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("F")
end event

type rb_email from radiobutton within w_printed_app_mockup
integer x = 343
integer y = 68
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Email"
boolean checked = true
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("E")
end event

type rb_print from radiobutton within w_printed_app_mockup
integer x = 55
integer y = 68
integer width = 251
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Print"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 05.19.2015 (V15.1 View Apps)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//of_set_rbbutton ("P")
end event

type cb_2 from commandbutton within w_printed_app_mockup
integer x = 1285
integer y = 48
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Process"
end type

type cb_1 from commandbutton within w_printed_app_mockup
integer x = 2638
integer y = 48
integer width = 311
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

type dw_1 from datawindow within w_printed_app_mockup
integer x = 9
integer y = 180
integer width = 2958
integer height = 1692
integer taborder = 10
string title = "none"
string dataobject = "d_printed_apps_mockup"
boolean livescroll = true
end type

type gb_2 from groupbox within w_printed_app_mockup
integer x = 18
integer y = 12
integer width = 1239
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Process Type"
end type

