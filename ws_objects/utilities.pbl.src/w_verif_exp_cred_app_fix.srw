$PBExportHeader$w_verif_exp_cred_app_fix.srw
forward
global type w_verif_exp_cred_app_fix from window
end type
type st_1 from statictext within w_verif_exp_cred_app_fix
end type
type cb_1 from commandbutton within w_verif_exp_cred_app_fix
end type
type rb_inact from radiobutton within w_verif_exp_cred_app_fix
end type
type rb_del from radiobutton within w_verif_exp_cred_app_fix
end type
type cb_close from commandbutton within w_verif_exp_cred_app_fix
end type
type cb_run from commandbutton within w_verif_exp_cred_app_fix
end type
type dw_del from datawindow within w_verif_exp_cred_app_fix
end type
type dw_fix from datawindow within w_verif_exp_cred_app_fix
end type
type dw_dupe from datawindow within w_verif_exp_cred_app_fix
end type
type gb_1 from groupbox within w_verif_exp_cred_app_fix
end type
end forward

global type w_verif_exp_cred_app_fix from window
integer width = 4160
integer height = 1924
boolean titlebar = true
string title = "Expiring Appointment Verifications "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_1 cb_1
rb_inact rb_inact
rb_del rb_del
cb_close cb_close
cb_run cb_run
dw_del dw_del
dw_fix dw_fix
dw_dupe dw_dupe
gb_1 gb_1
end type
global w_verif_exp_cred_app_fix w_verif_exp_cred_app_fix

forward prototypes
public subroutine of_run ()
end prototypes

public subroutine of_run ();
long prac
long fac
long r
long rc
integer i


rc = dw_dupe.rowcount()

for r = 1 to rc
	prac = dw_dupe.getitemnumber(r,"prac_id")
	fac = dw_dupe.getitemnumber(r,"facility_id")
	
	dw_fix.retrieve(prac,fac)
	
	for i = 2 to dw_fix.rowcount()
		dw_fix.setitem(i,"reference_value","To Delete")
		dw_fix.setitem(i,"active_status",-1)
		dw_fix.rowscopy( i, i,primary!, dw_del, 1, primary!)
	next
	
next
end subroutine

on w_verif_exp_cred_app_fix.create
this.st_1=create st_1
this.cb_1=create cb_1
this.rb_inact=create rb_inact
this.rb_del=create rb_del
this.cb_close=create cb_close
this.cb_run=create cb_run
this.dw_del=create dw_del
this.dw_fix=create dw_fix
this.dw_dupe=create dw_dupe
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.cb_1,&
this.rb_inact,&
this.rb_del,&
this.cb_close,&
this.cb_run,&
this.dw_del,&
this.dw_fix,&
this.dw_dupe,&
this.gb_1}
end on

on w_verif_exp_cred_app_fix.destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.rb_inact)
destroy(this.rb_del)
destroy(this.cb_close)
destroy(this.cb_run)
destroy(this.dw_del)
destroy(this.dw_fix)
destroy(this.dw_dupe)
destroy(this.gb_1)
end on

event open;dw_dupe.settransobject(sqlca)
dw_fix.settransobject(sqlca)
dw_dupe.retrieve()

if dw_dupe.rowcount() < 1 then
	messagebox("","No bad data found.")
	return
end if
	
end event

type st_1 from statictext within w_verif_exp_cred_app_fix
integer x = 1093
integer y = 1716
integer width = 2505
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Note: changes are not tracked in the data audit."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_verif_exp_cred_app_fix
integer x = 3177
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Complete"
end type

event clicked;
long r
string s
integer res

parent.setredraw( false)


if rb_del.checked then
	s = "You have selected to delete the duplicate records."
else
	s = "You have selected to set the duplicate records as inactive."
end if

res = messagebox("Complete?", s + "  Continue?",question!,yesno!,2)
if res = 2 then 	return

dw_del.settransobject(sqlca)

for r = 1 to dw_del.rowcount() 
	dw_del.setitemstatus(r, 0,primary!,datamodified!)
next

if rb_del.checked then
	for r = dw_del.rowcount() to 1 step -1
		dw_del.deleterow(r)
	next
else
	for r = 1 to dw_del.rowcount() 
		dw_del.setitemstatus(r, "active_status",primary!,datamodified!)
		dw_del.setitemstatus(r, "response_code",primary!,datamodified!)
	next

end if


parent.setredraw( True)



dw_del.update()
cb_close.triggerevent(clicked!)

end event

type rb_inact from radiobutton within w_verif_exp_cred_app_fix
integer x = 1486
integer y = 64
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Inactive"
end type

type rb_del from radiobutton within w_verif_exp_cred_app_fix
integer x = 1193
integer y = 64
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Delete"
boolean checked = true
end type

type cb_close from commandbutton within w_verif_exp_cred_app_fix
integer x = 3712
integer y = 36
integer width = 343
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

event clicked;close(parent)
end event

type cb_run from commandbutton within w_verif_exp_cred_app_fix
integer x = 2816
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;of_run()
end event

type dw_del from datawindow within w_verif_exp_cred_app_fix
integer x = 1074
integer y = 984
integer width = 2999
integer height = 720
integer taborder = 20
string title = "none"
string dataobject = "d_verif_exp_cred_appt_fix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_fix from datawindow within w_verif_exp_cred_app_fix
integer x = 1061
integer y = 180
integer width = 2999
integer height = 720
integer taborder = 20
string title = "none"
string dataobject = "d_verif_exp_cred_appt_fix"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_dupe from datawindow within w_verif_exp_cred_app_fix
integer x = 69
integer y = 32
integer width = 974
integer height = 1668
integer taborder = 10
string title = "none"
string dataobject = "d_verif_exp_cred_app_dupe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_verif_exp_cred_app_fix
integer x = 1106
integer y = 4
integer width = 763
integer height = 152
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Action"
end type

