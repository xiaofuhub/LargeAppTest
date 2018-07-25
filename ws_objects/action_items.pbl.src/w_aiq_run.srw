$PBExportHeader$w_aiq_run.srw
forward
global type w_aiq_run from window
end type
type st_2 from statictext within w_aiq_run
end type
type st_1 from statictext within w_aiq_run
end type
type r_1 from rectangle within w_aiq_run
end type
type r_status from rectangle within w_aiq_run
end type
type r_2 from rectangle within w_aiq_run
end type
type r_status2 from rectangle within w_aiq_run
end type
end forward

global type w_aiq_run from window
integer x = 1056
integer y = 484
integer width = 2373
integer height = 648
windowtype windowtype = popup!
long backcolor = 33551856
st_2 st_2
st_1 st_1
r_1 r_1
r_status r_status
r_2 r_2
r_status2 r_status2
end type
global w_aiq_run w_aiq_run

on w_aiq_run.create
this.st_2=create st_2
this.st_1=create st_1
this.r_1=create r_1
this.r_status=create r_status
this.r_2=create r_2
this.r_status2=create r_status2
this.Control[]={this.st_2,&
this.st_1,&
this.r_1,&
this.r_status,&
this.r_2,&
this.r_status2}
end on

on w_aiq_run.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.r_1)
destroy(this.r_status)
destroy(this.r_2)
destroy(this.r_status2)
end on

event open;//Timer ( 1 ,this )
//
//st_2.text = string(50)
end event

event timer;//integer w
//
//w = r_status.width
//
//if w > 499 then w = 0
//
//w = w + 10
//
//r_status.width = w
//
//st_2.text = string(w)
end event

type st_2 from statictext within w_aiq_run
boolean visible = false
integer x = 91
integer y = 412
integer width = 2071
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Sending Email..."
boolean focusrectangle = false
end type

type st_1 from statictext within w_aiq_run
integer x = 91
integer y = 136
integer width = 2071
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Running Action Items Query"
boolean focusrectangle = false
end type

type r_1 from rectangle within w_aiq_run
integer linethickness = 4
long fillcolor = 80269524
integer x = 91
integer y = 296
integer width = 2094
integer height = 72
end type

type r_status from rectangle within w_aiq_run
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 16711680
integer x = 96
integer y = 300
integer width = 50
integer height = 64
end type

type r_2 from rectangle within w_aiq_run
boolean visible = false
integer linethickness = 4
long fillcolor = 80269524
integer x = 91
integer y = 496
integer width = 2094
integer height = 72
end type

type r_status2 from rectangle within w_aiq_run
boolean visible = false
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 16711680
integer x = 96
integer y = 500
integer width = 50
integer height = 64
end type

