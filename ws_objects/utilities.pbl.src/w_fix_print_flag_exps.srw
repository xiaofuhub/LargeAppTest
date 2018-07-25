$PBExportHeader$w_fix_print_flag_exps.srw
forward
global type w_fix_print_flag_exps from window
end type
type cb_5 from commandbutton within w_fix_print_flag_exps
end type
type cb_10 from commandbutton within w_fix_print_flag_exps
end type
type sle_2 from singlelineedit within w_fix_print_flag_exps
end type
type sle_1 from singlelineedit within w_fix_print_flag_exps
end type
type cb_4 from commandbutton within w_fix_print_flag_exps
end type
type cb_8 from commandbutton within w_fix_print_flag_exps
end type
type dw_2 from datawindow within w_fix_print_flag_exps
end type
type cb_3 from commandbutton within w_fix_print_flag_exps
end type
type cb_1 from commandbutton within w_fix_print_flag_exps
end type
type dw_1 from datawindow within w_fix_print_flag_exps
end type
type dw_3 from datawindow within w_fix_print_flag_exps
end type
type dw_4 from datawindow within w_fix_print_flag_exps
end type
end forward

global type w_fix_print_flag_exps from window
integer x = 123
integer y = 112
integer width = 2080
integer height = 616
boolean titlebar = true
string title = "Adjust print flagsand removes exp cred l"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_5 cb_5
cb_10 cb_10
sle_2 sle_2
sle_1 sle_1
cb_4 cb_4
cb_8 cb_8
dw_2 dw_2
cb_3 cb_3
cb_1 cb_1
dw_1 dw_1
dw_3 dw_3
dw_4 dw_4
end type
global w_fix_print_flag_exps w_fix_print_flag_exps

type variables
integer ii_row
end variables

on w_fix_print_flag_exps.create
this.cb_5=create cb_5
this.cb_10=create cb_10
this.sle_2=create sle_2
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_8=create cb_8
this.dw_2=create dw_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_4=create dw_4
this.Control[]={this.cb_5,&
this.cb_10,&
this.sle_2,&
this.sle_1,&
this.cb_4,&
this.cb_8,&
this.dw_2,&
this.cb_3,&
this.cb_1,&
this.dw_1,&
this.dw_3,&
this.dw_4}
end on

on w_fix_print_flag_exps.destroy
destroy(this.cb_5)
destroy(this.cb_10)
destroy(this.sle_2)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_8)
destroy(this.dw_2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_4)
end on

event close;disCONNECT USING SQLCA;
end event

type cb_5 from commandbutton within w_fix_print_flag_exps
integer x = 1042
integer y = 192
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "save"
end type

event clicked;	dw_3.update()
	commit using sqlca;
end event

type cb_10 from commandbutton within w_fix_print_flag_exps
integer x = 955
integer y = 52
integer width = 475
integer height = 108
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Del exp Creds"
end type

event clicked;long i
integer l
long rc
long recid
long meth
integer lc
integer cnt = 0
integer facid
integer screen
datetime lattmp
datetime dcheck
integer redays
long cnt2 = 0
datetime expdate
integer rc2
//messagebox("",meth)
sle_2.text = string(cnt2)
dw_3.settransobject(sqlca)
rc = dw_3.retrieve()

for i = rc to 1 step -1
	recid = dw_3.getitemnumber(i,"rec_id")
	facid = dw_3.getitemnumber(i,"facility_id")
	screen = dw_3.getitemnumber(i,"screen_id")
	lattmp = dw_3.getitemdatetime(i,"last_sent")
	expdate = dw_3.getitemdatetime(i,"expiration_date")
	dw_2.settransobject(sqlca)
	lc = dw_2.retrieve(facid,screen)
	if lc < 1 then
		cnt++
		sle_1.text = string(cnt) + "- fac#" + string(facid)
	else
		//if isnull(lattmp) then
			
			dw_4.settransobject(sqlca)
			rc2 = dw_4.retrieve(recid,facid)
			if rc2 > 0 then
				dw_4.setitem(1,"exp_credential_flag",0)
				dw_4.update()
				commit using sqlca;
				dw_3.deleterow(i)
				cnt2++
				sle_2.text = string(cnt2)		
			end if
		//end if
	end if
next	
messagebox("letter flags","Finished. click save")
end event

type sle_2 from singlelineedit within w_fix_print_flag_exps
integer x = 841
integer y = 388
integer width = 247
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_1 from singlelineedit within w_fix_print_flag_exps
integer x = 517
integer y = 388
integer width = 247
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_fix_print_flag_exps
integer x = 311
integer y = 172
integer width = 247
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "save"
end type

event clicked;	dw_1.update()
	commit using sqlca;
end event

type cb_8 from commandbutton within w_fix_print_flag_exps
integer x = 297
integer y = 52
integer width = 411
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fix print flags"
end type

event clicked;long i
integer l
long rc
long recid
long meth
integer lc
integer cnt = 0
integer facid
integer screen
datetime lattmp
datetime dcheck
integer redays
long cnt2 = 0
//messagebox("",meth)
sle_2.text = string(cnt2)
dw_1.settransobject(sqlca)
dw_1.retrieve()
rc = dw_1.rowcount()

for i = 1 to rc
	recid = dw_1.getitemnumber(i,"rec_id")
	facid = dw_1.getitemnumber(i,"facility_id")
	screen = dw_1.getitemnumber(i,"screen_id")
	lattmp = dw_1.getitemdatetime(i,"last_sent")
	dw_2.settransobject(sqlca)
	lc = dw_2.retrieve(facid,screen)
	if lc < 1 then
		cnt++
		sle_1.text = string(cnt) + "- fac#" + string(facid)
	else
		redays = dw_2.getitemnumber(1,"ver_letter_resend_days")
		if relativedate (date(lattmp), redays) > today() then
		dw_1.setitem(i,"print_flag",0)
		cnt2++
		sle_2.text = string(cnt2)
		end if
	end if
next	
messagebox("letter flags","Finished. click save")
end event

type dw_2 from datawindow within w_fix_print_flag_exps
integer x = 571
integer y = 56
integer width = 146
integer height = 68
integer taborder = 100
string dataobject = "d_fac_screen_rule"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_fix_print_flag_exps
integer x = 1746
integer y = 36
integer width = 274
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_fix_print_flag_exps
integer x = 1746
integer y = 168
integer width = 265
integer height = 72
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("this program :","Will reset print flags for verifs that should not be printed. Also deletes exp cred letters and resets exp_cred_flag on current org verifs. Will not work on verifs expiring for a 2nd time currently.")
end event

type dw_1 from datawindow within w_fix_print_flag_exps
integer x = 379
integer y = 72
integer width = 78
integer height = 72
integer taborder = 90
string dataobject = "d_verifs_w_print_nonull_noexp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_3 from datawindow within w_fix_print_flag_exps
integer x = 978
integer y = 60
integer width = 197
integer height = 64
integer taborder = 70
string dataobject = "d_verifs_exp_cred_del"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within w_fix_print_flag_exps
integer x = 1211
integer y = 60
integer width = 169
integer height = 80
integer taborder = 30
string dataobject = "d_verifs_exp_org_verif"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

