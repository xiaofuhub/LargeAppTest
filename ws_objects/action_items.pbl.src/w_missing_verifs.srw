$PBExportHeader$w_missing_verifs.srw
forward
global type w_missing_verifs from window
end type
type cb_1 from commandbutton within w_missing_verifs
end type
type cb_close from commandbutton within w_missing_verifs
end type
type cb_add from commandbutton within w_missing_verifs
end type
type dw_1 from datawindow within w_missing_verifs
end type
end forward

global type w_missing_verifs from window
integer width = 3360
integer height = 1736
boolean titlebar = true
string title = "Find Missing Verifications"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_close cb_close
cb_add cb_add
dw_1 dw_1
end type
global w_missing_verifs w_missing_verifs

on w_missing_verifs.create
this.cb_1=create cb_1
this.cb_close=create cb_close
this.cb_add=create cb_add
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.cb_close,&
this.cb_add,&
this.dw_1}
end on

on w_missing_verifs.destroy
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.dw_1)
end on

event open;datastore lds_verif

dw_1.settransobject(sqlca)
dw_1.retrieve(0) //retrieving bogus prac id

lds_verif = message.powerobjectparm

lds_verif.rowscopy( 1, lds_verif.rowcount(), primary!, dw_1,1000, primary!)
end event

type cb_1 from commandbutton within w_missing_verifs
integer x = 50
integer y = 1504
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Deselect All"
end type

event clicked;long i
integer v


if this.text = 'Select All' then
	v = 1
	this.text = 'Deselect All'
else
	v = 0
	this.text = 'Select All'
end if

for i = 1 to dw_1.rowcount()
	dw_1.setitem(i,"selected",v)
next
end event

type cb_close from commandbutton within w_missing_verifs
integer x = 2903
integer y = 1508
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_add from commandbutton within w_missing_verifs
integer x = 2537
integer y = 1508
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Ok"
end type

event clicked;integer i
integer ic

//Start Code Change ----05.07.2009 #V92 maha - added trap for unselected method
ic = dw_1.rowcount()

for i = 1 to ic
	if dw_1.getitemnumber(i,"selected") = 1 then
		if isnull(dw_1.getitemnumber(i,"new_verification_method"))  then
			messagebox("Verification Method","For each selected item, there must be Verification Method selected.")
			return
		end if
	end if
next
//End Code Change---05.07.2009

for i  = ic to 1 step -1
	if dw_1.getitemnumber(i,"selected") <> 1 then
		dw_1.rowsdiscard( i,i,primary!)
	end if
next

dw_1.update()

//closewithreturn(parent,dw_1)
close (parent)


end event

type dw_1 from datawindow within w_missing_verifs
integer x = 32
integer y = 32
integer width = 3259
integer height = 1448
integer taborder = 10
string dataobject = "d_copy_verification_missing"
boolean vscrollbar = true
boolean livescroll = true
end type

event itemchanged;IF This.GetColumnName() = "new_verification_method" THEN
	this.setitem(this.getrow(),"verification_method",long(data))
end if
end event

event buttonclicked;if dwo.name = 'b_copy' then
	this.accepttext( )
	string s
	integer i
	s = this.getitemstring(1,"priority_user")
	for i = 2 to this.rowcount()
		this.setitem(i,"priority_user", s)
	next
end if
end event

