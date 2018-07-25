$PBExportHeader$w_get_midcycle_affil_stat.srw
forward
global type w_get_midcycle_affil_stat from window
end type
type st_facil from statictext within w_get_midcycle_affil_stat
end type
type st_prac from statictext within w_get_midcycle_affil_stat
end type
type cb_2 from commandbutton within w_get_midcycle_affil_stat
end type
type cb_1 from commandbutton within w_get_midcycle_affil_stat
end type
type dw_mid from datawindow within w_get_midcycle_affil_stat
end type
end forward

global type w_get_midcycle_affil_stat from window
integer width = 2985
integer height = 1468
boolean titlebar = true
string title = "Midcycle Appointments for:"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_facil st_facil
st_prac st_prac
cb_2 cb_2
cb_1 cb_1
dw_mid dw_mid
end type
global w_get_midcycle_affil_stat w_get_midcycle_affil_stat

on w_get_midcycle_affil_stat.create
this.st_facil=create st_facil
this.st_prac=create st_prac
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_mid=create dw_mid
this.Control[]={this.st_facil,&
this.st_prac,&
this.cb_2,&
this.cb_1,&
this.dw_mid}
end on

on w_get_midcycle_affil_stat.destroy
destroy(this.st_facil)
destroy(this.st_prac)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_mid)
end on

event open;//Start Code Change ----11.03.2014 #V14.2 maha - screen added
string s, sp,sf
long ll_prac
long ll_fac
integer p

s = message.stringparm

p = pos(s,"*")

ll_prac = long(mid(s, 1, p - 1))
ll_fac = long(mid(s,  p + 1))

select facility_name into :sf from facility where facility_id = :ll_fac; 
select full_name into :sp from v_full_name where prac_id = :ll_prac; 

st_facil.text = sf
st_prac.text = sp

dw_mid.settransobject(sqlca)
dw_mid.retrieve(ll_prac,ll_fac)




end event

type st_facil from statictext within w_get_midcycle_affil_stat
integer x = 1467
integer y = 40
integer width = 1449
integer height = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Facility"
boolean focusrectangle = false
end type

type st_prac from statictext within w_get_midcycle_affil_stat
integer x = 50
integer y = 40
integer width = 1239
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Practitioner"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_get_midcycle_affil_stat
integer x = 1518
integer y = 1276
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type cb_1 from commandbutton within w_get_midcycle_affil_stat
integer x = 1115
integer y = 1276
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;long r

r = dw_mid.getitemnumber(dw_mid.getrow(), "rec_id")
closewithreturn(parent, r)
end event

type dw_mid from datawindow within w_get_midcycle_affil_stat
integer x = 18
integer y = 140
integer width = 2912
integer height = 1104
integer taborder = 10
string title = "none"
string dataobject = "d_pd_affil_status_mid_4_package"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer r

if data = '1' then
	for r = 1 to this.rowcount()
		if r <> row then
			this.setitem(r,"selected", 0)
		end if
	next
end if
			
	
end event

