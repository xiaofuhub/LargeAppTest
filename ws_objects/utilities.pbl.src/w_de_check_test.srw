$PBExportHeader$w_de_check_test.srw
forward
global type w_de_check_test from window
end type
type cb_2 from commandbutton within w_de_check_test
end type
type st_2 from statictext within w_de_check_test
end type
type st_1 from statictext within w_de_check_test
end type
type sle_f from singlelineedit within w_de_check_test
end type
type sle_p from singlelineedit within w_de_check_test
end type
type cb_1 from commandbutton within w_de_check_test
end type
end forward

global type w_de_check_test from window
integer width = 1824
integer height = 792
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
st_2 st_2
st_1 st_1
sle_f sle_f
sle_p sle_p
cb_1 cb_1
end type
global w_de_check_test w_de_check_test

on w_de_check_test.create
this.cb_2=create cb_2
this.st_2=create st_2
this.st_1=create st_1
this.sle_f=create sle_f
this.sle_p=create sle_p
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.st_2,&
this.st_1,&
this.sle_f,&
this.sle_p,&
this.cb_1}
end on

on w_de_check_test.destroy
destroy(this.cb_2)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_f)
destroy(this.sle_p)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_de_check_test
integer x = 119
integer y = 556
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Report"
end type

event clicked;gs_report_variables lst_arg

lst_arg.as_report_object = "d_req_data_errors_rpt"
lst_arg.ai_num_variables = 1
lst_arg.as_var_type[1] = "N"
lst_arg.as_value[1] = sle_p.text

if isvalid(w_report_view) then close(w_report_view)
openwithparm(w_report_view,lst_arg)
end event

type st_2 from statictext within w_de_check_test
integer x = 1033
integer y = 104
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Facility"
boolean focusrectangle = false
end type

type st_1 from statictext within w_de_check_test
integer x = 219
integer y = 80
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prac"
boolean focusrectangle = false
end type

type sle_f from singlelineedit within w_de_check_test
integer x = 1024
integer y = 164
integer width = 402
integer height = 92
integer taborder = 20
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

type sle_p from singlelineedit within w_de_check_test
integer x = 219
integer y = 160
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "1252"
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_de_check_test
integer x = 699
integer y = 368
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "run"
end type

event clicked;long prac
long facil

pfc_cst_nv_data_entry_functions nv_data

nv_data = create pfc_cst_nv_data_entry_functions 

prac = long(sle_p.text)
facil = long(sle_f.text)


nv_data.of_check_required_data( 2, prac, facil)


destroy nv_data
end event

