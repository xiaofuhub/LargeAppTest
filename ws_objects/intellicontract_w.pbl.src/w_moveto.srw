$PBExportHeader$w_moveto.srw
forward
global type w_moveto from w_response
end type
type cb_cancel from commandbutton within w_moveto
end type
type cb_ok from commandbutton within w_moveto
end type
type dw_company from datawindow within w_moveto
end type
type gb_note from groupbox within w_moveto
end type
end forward

global type w_moveto from w_response
integer width = 1371
integer height = 492
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_cancel cb_cancel
cb_ok cb_ok
dw_company dw_company
gb_note gb_note
end type
global w_moveto w_moveto

on w_moveto.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_company=create dw_company
this.gb_note=create gb_note
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_company
this.Control[iCurrent+4]=this.gb_note
end on

on w_moveto.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_company)
destroy(this.gb_note)
end on

event open;call super::open;dw_Company.SetTransObject(SQLCA)
dw_Company.InsertRow(0)

end event

type cb_cancel from commandbutton within w_moveto
integer x = 709
integer y = 348
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn(Parent,-1)
end event

type cb_ok from commandbutton within w_moveto
integer x = 265
integer y = 348
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;long	ll_CompanyId

ll_CompanyId = dw_company.GetItemNumber(1,'facility_id')

CloseWithReturn(Parent,ll_CompanyId)

end event

type dw_company from datawindow within w_moveto
integer x = 110
integer y = 132
integer width = 1120
integer height = 88
integer taborder = 20
string dataobject = "d_contact_company"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_note from groupbox within w_moveto
integer x = 55
integer y = 36
integer width = 1243
integer height = 248
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Please select the target company"
end type

