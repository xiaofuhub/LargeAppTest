$PBExportHeader$w_cred_comm_meeting.srw
forward
global type w_cred_comm_meeting from w_sheet
end type
type cb_4 from commandbutton within w_cred_comm_meeting
end type
type cb_3 from commandbutton within w_cred_comm_meeting
end type
type cb_2 from commandbutton within w_cred_comm_meeting
end type
type cb_1 from commandbutton within w_cred_comm_meeting
end type
type dw_approve from datawindow within w_cred_comm_meeting
end type
type cb_close from commandbutton within w_cred_comm_meeting
end type
type cb_save from commandbutton within w_cred_comm_meeting
end type
type cb_delete from commandbutton within w_cred_comm_meeting
end type
type cb_add from commandbutton within w_cred_comm_meeting
end type
type dw_pracs from u_dw within w_cred_comm_meeting
end type
type dw_7 from datawindow within w_cred_comm_meeting
end type
type tab_1 from tab within w_cred_comm_meeting
end type
type tabpage_red from userobject within tab_1
end type
type dw_1 from datawindow within tabpage_red
end type
type dw_2 from datawindow within tabpage_red
end type
type tabpage_red from userobject within tab_1
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_qa from userobject within tab_1
end type
type dw_10 from datawindow within tabpage_qa
end type
type dw_9 from datawindow within tabpage_qa
end type
type tabpage_qa from userobject within tab_1
dw_10 dw_10
dw_9 dw_9
end type
type tabpage_ofe from userobject within tab_1
end type
type uo_2 from uo_oppe_fppe_evals within tabpage_ofe
end type
type tabpage_ofe from userobject within tab_1
uo_2 uo_2
end type
type tabpage_profiles from userobject within tab_1
end type
type uo_1 from pfc_cst_u_profile within tabpage_profiles
end type
type tabpage_profiles from userobject within tab_1
uo_1 uo_1
end type
type tabpage_quest from userobject within tab_1
end type
type dw_3 from datawindow within tabpage_quest
end type
type dw_5 from datawindow within tabpage_quest
end type
type tabpage_quest from userobject within tab_1
dw_3 dw_3
dw_5 dw_5
end type
type tabpage_privs from userobject within tab_1
end type
type dw_6 from datawindow within tabpage_privs
end type
type dw_4 from datawindow within tabpage_privs
end type
type tabpage_privs from userobject within tab_1
dw_6 dw_6
dw_4 dw_4
end type
type tabpage_images from userobject within tab_1
end type
type uo_3 from pfc_cst_u_imaging within tabpage_images
end type
type tabpage_images from userobject within tab_1
uo_3 uo_3
end type
type tab_1 from tab within w_cred_comm_meeting
tabpage_red tabpage_red
tabpage_qa tabpage_qa
tabpage_ofe tabpage_ofe
tabpage_profiles tabpage_profiles
tabpage_quest tabpage_quest
tabpage_privs tabpage_privs
tabpage_images tabpage_images
end type
end forward

global type w_cred_comm_meeting from w_sheet
integer width = 4763
integer height = 2268
long backcolor = 32891346
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_approve dw_approve
cb_close cb_close
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
dw_pracs dw_pracs
dw_7 dw_7
tab_1 tab_1
end type
global w_cred_comm_meeting w_cred_comm_meeting

type variables
long il_prac
end variables

on w_cred_comm_meeting.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_approve=create dw_approve
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_pracs=create dw_pracs
this.dw_7=create dw_7
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_approve
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_delete
this.Control[iCurrent+9]=this.cb_add
this.Control[iCurrent+10]=this.dw_pracs
this.Control[iCurrent+11]=this.dw_7
this.Control[iCurrent+12]=this.tab_1
end on

on w_cred_comm_meeting.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_approve)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_pracs)
destroy(this.dw_7)
destroy(this.tab_1)
end on

event open;call super::open;long ll_meeting

ll_meeting = message.doubleparm

dw_pracs.retrieve(ll_meeting)
end event

type cb_4 from commandbutton within w_cred_comm_meeting
integer x = 439
integer y = 100
integer width = 425
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

type cb_3 from commandbutton within w_cred_comm_meeting
integer x = 105
integer y = 100
integer width = 343
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Table"
end type

type cb_2 from commandbutton within w_cred_comm_meeting
integer x = 439
integer y = 28
integer width = 425
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = " Not Recommend"
end type

type cb_1 from commandbutton within w_cred_comm_meeting
integer x = 105
integer y = 28
integer width = 343
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Recommend"
end type

type dw_approve from datawindow within w_cred_comm_meeting
integer x = 901
integer y = 32
integer width = 1682
integer height = 100
integer taborder = 40
string title = "none"
string dataobject = "d_comm_review_mockup"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve(71560)
end event

type cb_close from commandbutton within w_cred_comm_meeting
integer x = 4091
integer y = 36
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

type cb_save from commandbutton within w_cred_comm_meeting
integer x = 3730
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

type cb_delete from commandbutton within w_cred_comm_meeting
integer x = 3374
integer y = 40
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Report"
end type

type cb_add from commandbutton within w_cred_comm_meeting
integer x = 2619
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Approve"
end type

type dw_pracs from u_dw within w_cred_comm_meeting
integer x = 27
integer y = 192
integer width = 1317
integer height = 1900
integer taborder = 10
string dataobject = "d_meeting_prac_list_elect"
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)

il_prac = this.getitemnumber(currentrow,"prac_id")
end event

type dw_7 from datawindow within w_cred_comm_meeting
boolean visible = false
integer x = 2121
integer y = 192
integer width = 320
integer height = 1900
integer taborder = 30
string title = "none"
string dataobject = "D_TAB_ICONS_MEETINGS"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;THIS.SETTRANSOBJECT(SQLCA)
this.retrieve()

end event

type tab_1 from tab within w_cred_comm_meeting
integer x = 1367
integer y = 188
integer width = 3333
integer height = 1904
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 32891346
boolean focusonbuttondown = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
tabpage_red tabpage_red
tabpage_qa tabpage_qa
tabpage_ofe tabpage_ofe
tabpage_profiles tabpage_profiles
tabpage_quest tabpage_quest
tabpage_privs tabpage_privs
tabpage_images tabpage_images
end type

on tab_1.create
this.tabpage_red=create tabpage_red
this.tabpage_qa=create tabpage_qa
this.tabpage_ofe=create tabpage_ofe
this.tabpage_profiles=create tabpage_profiles
this.tabpage_quest=create tabpage_quest
this.tabpage_privs=create tabpage_privs
this.tabpage_images=create tabpage_images
this.Control[]={this.tabpage_red,&
this.tabpage_qa,&
this.tabpage_ofe,&
this.tabpage_profiles,&
this.tabpage_quest,&
this.tabpage_privs,&
this.tabpage_images}
end on

on tab_1.destroy
destroy(this.tabpage_red)
destroy(this.tabpage_qa)
destroy(this.tabpage_ofe)
destroy(this.tabpage_profiles)
destroy(this.tabpage_quest)
destroy(this.tabpage_privs)
destroy(this.tabpage_images)
end on

type tabpage_red from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "Red Flag"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "red_flag.bmp"
long picturemaskcolor = 536870912
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_red.create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.dw_1,&
this.dw_2}
end on

on tabpage_red.destroy
destroy(this.dw_1)
destroy(this.dw_2)
end on

type dw_1 from datawindow within tabpage_red
integer x = 23
integer y = 28
integer width = 2917
integer height = 588
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within tabpage_red
integer x = 27
integer y = 644
integer width = 2903
integer height = 1080
integer taborder = 40
boolean bringtotop = true
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_qa from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "OPPE"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "action.bmp"
long picturemaskcolor = 536870912
dw_10 dw_10
dw_9 dw_9
end type

on tabpage_qa.create
this.dw_10=create dw_10
this.dw_9=create dw_9
this.Control[]={this.dw_10,&
this.dw_9}
end on

on tabpage_qa.destroy
destroy(this.dw_10)
destroy(this.dw_9)
end on

type dw_10 from datawindow within tabpage_qa
integer x = 114
integer y = 452
integer width = 2802
integer height = 1292
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_9 from datawindow within tabpage_qa
integer x = 105
integer y = 92
integer width = 2807
integer height = 308
integer taborder = 30
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_ofe from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "FPPE"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "astamp_s.bmp"
long picturemaskcolor = 536870912
uo_2 uo_2
end type

on tabpage_ofe.create
this.uo_2=create uo_2
this.Control[]={this.uo_2}
end on

on tabpage_ofe.destroy
destroy(this.uo_2)
end on

type uo_2 from uo_oppe_fppe_evals within tabpage_ofe
integer x = 18
integer taborder = 70
end type

on uo_2.destroy
call uo_oppe_fppe_evals::destroy
end on

type tabpage_profiles from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "Profiles"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "4PHONES.BMP"
long picturemaskcolor = 536870912
uo_1 uo_1
end type

on tabpage_profiles.create
this.uo_1=create uo_1
this.Control[]={this.uo_1}
end on

on tabpage_profiles.destroy
destroy(this.uo_1)
end on

type uo_1 from pfc_cst_u_profile within tabpage_profiles
integer x = 37
integer y = 20
integer taborder = 20
end type

on uo_1.destroy
call pfc_cst_u_profile::destroy
end on

type tabpage_quest from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "Attestation"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "quest.bmp"
long picturemaskcolor = 536870912
dw_3 dw_3
dw_5 dw_5
end type

on tabpage_quest.create
this.dw_3=create dw_3
this.dw_5=create dw_5
this.Control[]={this.dw_3,&
this.dw_5}
end on

on tabpage_quest.destroy
destroy(this.dw_3)
destroy(this.dw_5)
end on

type dw_3 from datawindow within tabpage_quest
integer x = 37
integer y = 1216
integer width = 3502
integer height = 556
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_5 from datawindow within tabpage_quest
integer x = 27
integer y = 12
integer width = 3506
integer height = 1188
integer taborder = 50
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_privs from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
string text = "Privileges"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "rights.bmp"
long picturemaskcolor = 536870912
dw_6 dw_6
dw_4 dw_4
end type

on tabpage_privs.create
this.dw_6=create dw_6
this.dw_4=create dw_4
this.Control[]={this.dw_6,&
this.dw_4}
end on

on tabpage_privs.destroy
destroy(this.dw_6)
destroy(this.dw_4)
end on

type dw_6 from datawindow within tabpage_privs
integer x = 55
integer y = 1096
integer width = 3479
integer height = 684
integer taborder = 40
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_4 from datawindow within tabpage_privs
integer x = 41
integer y = 12
integer width = 3488
integer height = 1068
integer taborder = 70
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_images from userobject within tab_1
integer x = 393
integer y = 16
integer width = 2921
integer height = 1872
long backcolor = 32891346
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
uo_3 uo_3
end type

on tabpage_images.create
this.uo_3=create uo_3
this.Control[]={this.uo_3}
end on

on tabpage_images.destroy
destroy(this.uo_3)
end on

type uo_3 from pfc_cst_u_imaging within tabpage_images
integer x = 37
integer y = 20
integer taborder = 70
end type

on uo_3.destroy
call pfc_cst_u_imaging::destroy
end on

