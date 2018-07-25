$PBExportHeader$w_ctx_template_autonum.srw
forward
global type w_ctx_template_autonum from w_popup
end type
type st_2 from statictext within w_ctx_template_autonum
end type
type st_1 from statictext within w_ctx_template_autonum
end type
type cb_cancel from commandbutton within w_ctx_template_autonum
end type
type cb_insert from commandbutton within w_ctx_template_autonum
end type
type dw_example from datawindow within w_ctx_template_autonum
end type
type lb_tag from listbox within w_ctx_template_autonum
end type
end forward

global type w_ctx_template_autonum from w_popup
integer width = 827
integer height = 940
string title = "Auto Numbering"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_insert cb_insert
dw_example dw_example
lb_tag lb_tag
end type
global w_ctx_template_autonum w_ctx_template_autonum

on w_ctx_template_autonum.create
int iCurrent
call super::create
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_insert=create cb_insert
this.dw_example=create dw_example
this.lb_tag=create lb_tag
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_insert
this.Control[iCurrent+5]=this.dw_example
this.Control[iCurrent+6]=this.lb_tag
end on

on w_ctx_template_autonum.destroy
call super::destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_insert)
destroy(this.dw_example)
destroy(this.lb_tag)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-26 By: Rodger Wu (auto num)
/* 
New Datawindow:
	d_ctx_template_autonum
*/
//---------------------------- APPEON END ----------------------------

lb_tag.selectitem(1)
end event

event resize;call super::resize;if isvalid( w_mdi ) then
	This.x = w_mdi.x + 10
	This.y = ( w_mdi.height - This.height ) / 2
end if
end event

type st_2 from statictext within w_ctx_template_autonum
integer x = 14
integer y = 448
integer width = 773
integer height = 284
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_ctx_template_autonum
integer x = 14
integer y = 12
integer width = 773
integer height = 424
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_ctx_template_autonum
integer x = 507
integer y = 752
integer width = 283
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close( parent )
end event

type cb_insert from commandbutton within w_ctx_template_autonum
integer x = 219
integer y = 752
integer width = 283
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert"
end type

event clicked;/*
integer li_index
string ls_forinsert

li_index = lb_tag.selectedindex()
choose case li_index
	case 1
		ls_forinsert = "##"
	case 2
		ls_forinsert = "@@"
	case 3
		ls_forinsert = "#.0"
	case 4
		ls_forinsert = "#.#"
end choose

if isvalid( w_main ) then w_main.of_insertafter( ls_forinsert )
*/
end event

type dw_example from datawindow within w_ctx_template_autonum
integer x = 18
integer y = 16
integer width = 763
integer height = 416
boolean bringtotop = true
string title = "none"
string dataobject = "d_ctx_template_autonum"
boolean border = false
boolean livescroll = true
end type

type lb_tag from listbox within w_ctx_template_autonum
integer x = 18
integer y = 452
integer width = 763
integer height = 276
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean border = false
boolean sorted = false
string item[] = {"##    - Chapter Tag   (I, II, III, IV...)","@@ - Chapter Tag   (A,B,C,D...)","     #.0   - Paragraph Tag","          #.#   - Section Tag"}
end type

event selectionchanged;dw_example.setitem( 1, 1, index )
end event

event doubleclicked;if index > 0 then cb_insert.TriggerEvent( Clicked! )
end event

