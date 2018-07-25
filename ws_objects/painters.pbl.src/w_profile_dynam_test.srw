$PBExportHeader$w_profile_dynam_test.srw
forward
global type w_profile_dynam_test from window
end type
type mle_1 from multilineedit within w_profile_dynam_test
end type
type cb_1 from commandbutton within w_profile_dynam_test
end type
type dw_view from datawindow within w_profile_dynam_test
end type
type st_4 from statictext within w_profile_dynam_test
end type
type st_3 from statictext within w_profile_dynam_test
end type
type st_2 from statictext within w_profile_dynam_test
end type
type st_1 from statictext within w_profile_dynam_test
end type
type sle_prac from singlelineedit within w_profile_dynam_test
end type
type sle_facil from singlelineedit within w_profile_dynam_test
end type
type dw_dw from datawindow within w_profile_dynam_test
end type
type dw_screen from datawindow within w_profile_dynam_test
end type
end forward

global type w_profile_dynam_test from window
integer width = 3291
integer height = 3184
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
mle_1 mle_1
cb_1 cb_1
dw_view dw_view
st_4 st_4
st_3 st_3
st_2 st_2
st_1 st_1
sle_prac sle_prac
sle_facil sle_facil
dw_dw dw_dw
dw_screen dw_screen
end type
global w_profile_dynam_test w_profile_dynam_test

type variables
integer ii_profile_id
end variables

on w_profile_dynam_test.create
this.mle_1=create mle_1
this.cb_1=create cb_1
this.dw_view=create dw_view
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.sle_prac=create sle_prac
this.sle_facil=create sle_facil
this.dw_dw=create dw_dw
this.dw_screen=create dw_screen
this.Control[]={this.mle_1,&
this.cb_1,&
this.dw_view,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_1,&
this.sle_prac,&
this.sle_facil,&
this.dw_dw,&
this.dw_screen}
end on

on w_profile_dynam_test.destroy
destroy(this.mle_1)
destroy(this.cb_1)
destroy(this.dw_view)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_prac)
destroy(this.sle_facil)
destroy(this.dw_dw)
destroy(this.dw_screen)
end on

type mle_1 from multilineedit within w_profile_dynam_test
integer x = 32
integer y = 464
integer width = 3090
integer height = 1296
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_profile_dynam_test
integer x = 274
integer y = 328
integer width = 402
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

event clicked;
long ll_profile
long ll_screen
long ll_prac
integer li_facil
string ls_syntax
string ls_sql


li_facil = integer(sle_facil.text)
ll_prac = long(sle_prac.text)

ll_profile = ii_profile_id
ll_screen = dw_screen.getitemnumber(dw_screen.getrow(),"profile_report_id")

ls_syntax = of_get_profile_screen_syntax(ll_profile,ll_screen)

//
mle_1.text = ls_syntax

dw_dw.modify("Object.DataWindow.Syntax = " + ls_syntax)
ls_sql = dw_dw.describe("DataWindow.Syntax.Data")
openwithparm(w_sql_msg,ls_sql)


dw_dw.settransobject(sqlca)
dw_dw.retrieve(ll_prac)


end event

type dw_view from datawindow within w_profile_dynam_test
integer x = 32
integer y = 148
integer width = 942
integer height = 112
integer taborder = 30
string title = "none"
string dataobject = "d_pfl_select_views_dddw_list_no_hdr"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_profile_id = integer (data)
dw_screen.Retrieve(ii_profile_id)
end event

event constructor;this.settransobject(sqlca)
this.retrieve(1)
dw_screen.settransobject(sqlca)
dw_screen.retrieve(1)

end event

type st_4 from statictext within w_profile_dynam_test
integer x = 2139
integer y = 68
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facility Id"
boolean focusrectangle = false
end type

type st_3 from statictext within w_profile_dynam_test
integer x = 754
integer y = 44
integer width = 229
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Screen"
boolean focusrectangle = false
end type

type st_2 from statictext within w_profile_dynam_test
integer x = 2528
integer y = 68
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prac Id"
boolean focusrectangle = false
end type

type st_1 from statictext within w_profile_dynam_test
integer x = 69
integer y = 84
integer width = 229
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "View"
boolean focusrectangle = false
end type

type sle_prac from singlelineedit within w_profile_dynam_test
integer x = 2519
integer y = 136
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
end type

type sle_facil from singlelineedit within w_profile_dynam_test
integer x = 2144
integer y = 140
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "2"
borderstyle borderstyle = stylelowered!
end type

type dw_dw from datawindow within w_profile_dynam_test
integer x = 41
integer y = 1796
integer width = 3086
integer height = 1088
integer taborder = 30
string title = "none"
string dataobject = "d_pfc_selected_reports"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen from datawindow within w_profile_dynam_test
integer x = 1001
integer y = 48
integer width = 1019
integer height = 364
integer taborder = 20
string title = "none"
string dataobject = "d_pfc_selected_reports"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;long i

i= this.getclickedrow()

this.selectrow( 0, false)
this.selectrow( i, true)
this.setrow(i)
end event

