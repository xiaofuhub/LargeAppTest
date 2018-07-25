$PBExportHeader$w_facility_view.srw
forward
global type w_facility_view from w_response
end type
type st_1 from u_st within w_facility_view
end type
type cb_2 from u_cb within w_facility_view
end type
type cb_1 from u_cb within w_facility_view
end type
type sle_1 from u_sle within w_facility_view
end type
type dw_1 from u_dw within w_facility_view
end type
end forward

global type w_facility_view from w_response
integer width = 1623
integer height = 1288
st_1 st_1
cb_2 cb_2
cb_1 cb_1
sle_1 sle_1
dw_1 dw_1
end type
global w_facility_view w_facility_view

type variables
str_pass istr_pass

string is_filter
end variables

on w_facility_view.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.sle_1=create sle_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.sle_1
this.Control[iCurrent+5]=this.dw_1
end on

on w_facility_view.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.dw_1)
end on

event open;call super::open;




istr_pass = message.powerobjectparm




DW_1.setfilter('facility_id <> ' + istr_pass.s_string  )
dw_1.filter()
dw_1.retrieve()


end event

event close;call super::close;

CloseWithReturn ( this, istr_pass )
end event

type st_1 from u_st within w_facility_view
integer x = 32
integer y = 1020
integer width = 398
fontcharset fontcharset = ansi!
boolean underline = true
string text = "New Profile Name"
end type

type cb_2 from u_cb within w_facility_view
integer x = 1248
integer y = 1100
integer taborder = 40
string text = "&Cancel"
end type

event clicked;call super::clicked;

long ll_null
string ls_null
setnull(ll_null)
setnull(ls_null)

istr_pass.l_facility_id = ll_null
istr_pass.s_string = ls_null


parent.event close( )
end event

type cb_1 from u_cb within w_facility_view
integer x = 873
integer y = 1100
integer taborder = 30
string text = "&OK"
boolean default = true
end type

event clicked;call super::clicked;
long ll_selected_row

ll_selected_row = dw_1.GetSelectedRow (0)

if ll_selected_row < 1 then 
	of_messagebox( '', Parent.title, 'Please select a row.', information!, ok!, 1)
	return
end if 


if LenA(trim(sle_1.text))  < 1 then 
	of_messagebox( '', Parent.title, 'Please enter a profile name.', information!, ok!, 1)
	return
end if 



istr_pass.l_facility_id = dw_1.object.facility_id[dw_1.getrow()]
istr_pass.s_string = trim(sle_1.text)


parent.event close( )
end event

type sle_1 from u_sle within w_facility_view
integer x = 466
integer y = 1004
integer width = 1134
integer taborder = 20
end type

type dw_1 from u_dw within w_facility_view
integer taborder = 10
string dataobject = "d_view_facilities"
end type

event constructor;call super::constructor;THIS.of_SetRowSelect(TRUE)

THIS.inv_rowselect.of_SetStyle(THIS.inv_rowselect.single )



end event

