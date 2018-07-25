$PBExportHeader$w_entity_select_prac_address.srw
forward
global type w_entity_select_prac_address from w_response
end type
type cb_can from commandbutton within w_entity_select_prac_address
end type
type cb_ok from commandbutton within w_entity_select_prac_address
end type
type dw_1 from u_dw within w_entity_select_prac_address
end type
end forward

global type w_entity_select_prac_address from w_response
integer x = 214
integer y = 221
integer width = 3470
long backcolor = 33551856
cb_can cb_can
cb_ok cb_ok
dw_1 dw_1
end type
global w_entity_select_prac_address w_entity_select_prac_address

forward prototypes
public function integer of_select (integer ai_row)
end prototypes

public function integer of_select (integer ai_row);long ll_rec

if ai_row = 0 then
	messagebox("Select Address","Please Select an address ot click Cancel.")
	return -1
else
	ll_rec = dw_1.getitemnumber(ai_row, "rec_id")
	closewithreturn(w_entity_select_prac_address, ll_rec)
	return 1
end if
end function

on w_entity_select_prac_address.create
int iCurrent
call super::create
this.cb_can=create cb_can
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_can
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_entity_select_prac_address.destroy
call super::destroy
destroy(this.cb_can)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event open;call super::open;//Start Code Change ----11.21.2016 #V153 maha
long ll_prac

ll_prac = message.doubleparm

dw_1.settransobject(sqlca)
dw_1.retrieve(ll_prac)
end event

type cb_can from commandbutton within w_entity_select_prac_address
integer x = 3049
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(w_entity_select_prac_address, -1)
end event

type cb_ok from commandbutton within w_entity_select_prac_address
integer x = 2619
integer y = 20
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;of_select ( dw_1.getrow())
end event

type dw_1 from u_dw within w_entity_select_prac_address
integer y = 124
integer width = 3451
integer height = 1284
integer taborder = 10
string dataobject = "d_entity_prac_addr_link"
end type

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0, false)
this.selectrow(r, true)
end event

event doubleclicked;call super::doubleclicked;of_select(row)
end event

