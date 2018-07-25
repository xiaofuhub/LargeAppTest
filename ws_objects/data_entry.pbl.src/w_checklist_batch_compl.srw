$PBExportHeader$w_checklist_batch_compl.srw
forward
global type w_checklist_batch_compl from w_response
end type
type cb_update from commandbutton within w_checklist_batch_compl
end type
type cb_all from commandbutton within w_checklist_batch_compl
end type
type cb_clear from commandbutton within w_checklist_batch_compl
end type
type dw_items from u_dw within w_checklist_batch_compl
end type
type dw_1 from u_dw within w_checklist_batch_compl
end type
type cb_can from commandbutton within w_checklist_batch_compl
end type
end forward

global type w_checklist_batch_compl from w_response
integer x = 214
integer y = 221
integer width = 3191
integer height = 2068
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_update cb_update
cb_all cb_all
cb_clear cb_clear
dw_items dw_items
dw_1 dw_1
cb_can cb_can
end type
global w_checklist_batch_compl w_checklist_batch_compl

type variables
long il_appt_id
integer ii_upped = 0
end variables

on w_checklist_batch_compl.create
int iCurrent
call super::create
this.cb_update=create cb_update
this.cb_all=create cb_all
this.cb_clear=create cb_clear
this.dw_items=create dw_items
this.dw_1=create dw_1
this.cb_can=create cb_can
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_update
this.Control[iCurrent+2]=this.cb_all
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.dw_items
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_can
end on

on w_checklist_batch_compl.destroy
call super::destroy
destroy(this.cb_update)
destroy(this.cb_all)
destroy(this.cb_clear)
destroy(this.dw_items)
destroy(this.dw_1)
destroy(this.cb_can)
end on

event open;call super::open;//Start Code Change ----08.01.2017 #V16 maha
DataWindowChild dwchild

il_appt_id=  message.doubleparm

dw_1.settransobject(sqlca)
dw_1.of_SetDropDownCalendar( TRUE )
dw_1.insertrow(1)

dw_1.setitem(1, "date_completed", datetime(today(), now()))
dw_1.setitem(1, "data_status", 662)

dw_1.GetChild( "data_status", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('required data status') + "'", dwchild)


dw_items.settransobject(sqlca)
dw_items.retrieve(il_appt_id)


end event

event closequery;return 0
end event

type cb_update from commandbutton within w_checklist_batch_compl
integer x = 914
integer y = 420
integer width = 439
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Selected"
end type

event clicked;//Start Code Change ----11.14.2017 #V16 maha
string ls_note
long ll_status
datetime ld_date
integer r

dw_1.accepttext( )

ld_date = dw_1.getitemdatetime(1, "date_completed")
ls_note = dw_1.getitemstring( 1, "notes")
ll_status = dw_1.getitemnumber(1, "data_status")

for r = 1 to dw_items.rowcount()
	if dw_items.getitemnumber(r, "selected") =  1 then
		dw_items.setitem(r, "date_completed", ld_date)
		dw_items.setitem(r, "data_status", ll_status)
		if len(ls_note) > 0 then dw_items.setitem(r, "notes", ls_note)
		ii_upped = 1
	end if
next

dw_items.update()

for r = dw_items.rowcount() to 1 step -1
	if dw_items.getitemnumber(r, "selected") =  1 then
		dw_items.rowsdiscard( r, r, primary!)
	end if
next

if dw_items.rowcount() = 0 then
	cb_can.triggerevent(clicked!)
end if
end event

type cb_all from commandbutton within w_checklist_batch_compl
integer x = 471
integer y = 420
integer width = 421
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;integer r

for r = 1 to dw_items.rowcount()
	dw_items.setitem(r, "selected", 1)
next
end event

type cb_clear from commandbutton within w_checklist_batch_compl
integer x = 37
integer y = 420
integer width = 421
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Selected"
end type

event clicked;integer r

for r = 1 to dw_items.rowcount()
	dw_items.setitem(r, "selected", 0)
next
end event

type dw_items from u_dw within w_checklist_batch_compl
integer x = 14
integer y = 516
integer width = 3150
integer height = 1524
integer taborder = 20
string dataobject = "d_checklist_for_batch_compl"
end type

type dw_1 from u_dw within w_checklist_batch_compl
integer x = 23
integer y = 24
integer width = 1902
integer height = 368
integer taborder = 10
string dataobject = "d_checklist_batch_setting"
boolean vscrollbar = false
boolean border = false
end type

type cb_can from commandbutton within w_checklist_batch_compl
integer x = 2725
integer y = 20
integer width = 398
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;closewithreturn(parent, ii_upped)
end event

