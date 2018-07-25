$PBExportHeader$w_lookup_painter_filter.srw
forward
global type w_lookup_painter_filter from w_response
end type
type dw_lookup_filter from u_dw within w_lookup_painter_filter
end type
type cb_1 from u_cb within w_lookup_painter_filter
end type
type cb_2 from u_cb within w_lookup_painter_filter
end type
type cb_3 from u_cb within w_lookup_painter_filter
end type
type cb_4 from u_cb within w_lookup_painter_filter
end type
end forward

global type w_lookup_painter_filter from w_response
integer x = 14
integer y = 64
integer width = 1851
integer height = 2028
string title = "Lookup Painter Filter"
long backcolor = 33551856
dw_lookup_filter dw_lookup_filter
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_lookup_painter_filter w_lookup_painter_filter

on w_lookup_painter_filter.create
int iCurrent
call super::create
this.dw_lookup_filter=create dw_lookup_filter
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lookup_filter
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_4
end on

on w_lookup_painter_filter.destroy
call super::destroy
destroy(this.dw_lookup_filter)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event open;call super::open;dw_lookup_filter.of_SetTransObject( SQLCA )
dw_lookup_filter.Retrieve()

dw_lookup_filter.of_SetReqColumn(TRUE)
end event

type dw_lookup_filter from u_dw within w_lookup_painter_filter
integer x = 73
integer y = 64
integer width = 1280
integer height = 1792
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_lookup_filter_for_contract"
end type

type cb_1 from u_cb within w_lookup_painter_filter
integer x = 1426
integer y = 352
integer width = 311
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;Parent.Event pfc_save()
end event

type cb_2 from u_cb within w_lookup_painter_filter
integer x = 1426
integer y = 160
integer width = 311
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order
Integer li_next_id

li_row = dw_lookup_filter.InsertRow(0)
dw_lookup_filter.SetRow(li_row)
dw_lookup_filter.ScrollToRow(li_row)

dw_lookup_filter.SetFocus()
dw_lookup_filter.SetColumn(1)
	
end event

type cb_3 from u_cb within w_lookup_painter_filter
integer x = 1426
integer y = 256
integer width = 311
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_lookup_filter.Event pfc_deleterow()

dw_lookup_filter.SetFocus()
end event

type cb_4 from u_cb within w_lookup_painter_filter
integer x = 1426
integer y = 64
integer width = 311
integer height = 84
integer taborder = 11
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close( Parent )
end event

