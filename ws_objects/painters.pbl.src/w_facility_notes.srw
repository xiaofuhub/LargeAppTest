$PBExportHeader$w_facility_notes.srw
forward
global type w_facility_notes from w_popup
end type
type cb_1 from commandbutton within w_facility_notes
end type
type dw_1 from u_dw within w_facility_notes
end type
end forward

global type w_facility_notes from w_popup
integer width = 3241
integer height = 1972
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_1 cb_1
dw_1 dw_1
end type
global w_facility_notes w_facility_notes

event open;call super::open; //Start Code Change ----05.02.2017 #V154 maha - Added
 
 long ll_facil
 
 ll_facil = message.doubleparm
 
 dw_1.settransobject(sqlca)
 
 dw_1.retrieve(ll_facil)
end event

on w_facility_notes.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_facility_notes.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_facility_notes
integer x = 2793
integer y = 8
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean default = true
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_facility_notes
integer x = 14
integer y = 120
integer width = 3200
integer height = 1752
integer taborder = 10
string dataobject = "d_facility_notes"
boolean vscrollbar = false
end type

