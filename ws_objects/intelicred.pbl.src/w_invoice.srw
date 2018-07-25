$PBExportHeader$w_invoice.srw
forward
global type w_invoice from w_main
end type
type cb_inv from commandbutton within w_invoice
end type
type cb_filt from commandbutton within w_invoice
end type
type dw_range from u_dw within w_invoice
end type
type dw_facility from datawindow within w_invoice
end type
type cb_charges from commandbutton within w_invoice
end type
type dw_records from datawindow within w_invoice
end type
type cb_close from commandbutton within w_invoice
end type
type cb_delete from commandbutton within w_invoice
end type
type cb_save from commandbutton within w_invoice
end type
type gb_1 from groupbox within w_invoice
end type
end forward

global type w_invoice from w_main
integer x = 27
integer y = 32
integer width = 4398
integer height = 1864
string title = "Invoices"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
cb_inv cb_inv
cb_filt cb_filt
dw_range dw_range
dw_facility dw_facility
cb_charges cb_charges
dw_records dw_records
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
gb_1 gb_1
end type
global w_invoice w_invoice

type variables
integer ii_selected_facility_id

long il_prac_id
long il_invoice
integer ii_days
end variables

forward prototypes
public function double of_compute_item (integer ai_row)
public function integer of_compute_total ()
end prototypes

public function double of_compute_item (integer ai_row);integer li_quant
double li_price
double li_total

//tab_1.tabpage_detail.dw_items.accepttext()
//li_quant = tab_1.tabpage_detail.dw_items.getitemnumber(ai_row,"quantity")
//li_price = tab_1.tabpage_detail.dw_items.getitemnumber(ai_row,"price")
//li_total = li_quant * li_price
//
//
//tab_1.tabpage_detail.dw_items.setitem(ai_row,"extended",li_total)


return li_total
end function

public function integer of_compute_total ();integer i
double li_price
double li_total

//for i = 1 to tab_1.tabpage_detail.dw_items.rowcount()
//	li_total = li_total + tab_1.tabpage_detail.dw_items.getitemnumber(i,"extended")
//next
//
//tab_1.tabpage_browse.dw_detail.setitem(1,"invc_amt",li_total)

return 1
end function

on w_invoice.create
int iCurrent
call super::create
this.cb_inv=create cb_inv
this.cb_filt=create cb_filt
this.dw_range=create dw_range
this.dw_facility=create dw_facility
this.cb_charges=create cb_charges
this.dw_records=create dw_records
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_inv
this.Control[iCurrent+2]=this.cb_filt
this.Control[iCurrent+3]=this.dw_range
this.Control[iCurrent+4]=this.dw_facility
this.Control[iCurrent+5]=this.cb_charges
this.Control[iCurrent+6]=this.dw_records
this.Control[iCurrent+7]=this.cb_close
this.Control[iCurrent+8]=this.cb_delete
this.Control[iCurrent+9]=this.cb_save
this.Control[iCurrent+10]=this.gb_1
end on

on w_invoice.destroy
call super::destroy
destroy(this.cb_inv)
destroy(this.cb_filt)
destroy(this.dw_range)
destroy(this.dw_facility)
destroy(this.cb_charges)
destroy(this.dw_records)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.gb_1)
end on

event open;call super::open;datawindowchild dwchild

//debugbreak()
//il_prac_id = message.doubleparm
il_prac_id = gl_prac_id

if il_prac_id < 0 then
	messagebox("?","Unknown practitioner. Please close and reselect practitioner.")
end if


dw_facility.settransobject(sqlca)

//tab_1.tabpage_browse.dw_browse.settransobject(sqlca)
//tab_1.tabpage_browse.dw_detail.settransobject(sqlca)
//tab_1.tabpage_detail.dw_items.settransobject(sqlca)

dw_facility.retrieve(il_prac_id,gs_user_id)

gnv_appeondb.of_startqueue( )

select term_days into :ii_days from inv_company;

//tab_1.tabpage_browse.dw_detail.GetChild( "facility_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(gs_user_id)
//
//tab_1.tabpage_browse.dw_browse.GetChild( "facility_id", dwchild )
//dwchild.settransobject(sqlca)
//dwchild.retrieve(gs_user_id)

gnv_appeondb.of_commitqueue( )
//Locate the button in the correct position in web application.
//If appeongetclienttype()<> 'PB' Then
//	cb_save.y = cb_save.y - 12
//	cb_delete.y = cb_delete.y - 12
//	cb_close.y = cb_close.y - 12
//End If
//---------------------------- APPEON END ----------------------------

//dwchild.insertrow(1)


//tab_1.tabpage_detail.dw_invt.settransobject(sqlca)
//tab_1.tabpage_detail.dw_invt.retrieve()
//tab_1.tabpage_detail.dw_invt.insertrow(1)

//Start Code Change ----09.30.2016 #V152 maha - added
if w_mdi.of_security_access( 7830 ) = 1 THEN //read only
	cb_charges.visible = false
	cb_delete.visible = false
end if


	
return 1
end event

type cb_inv from commandbutton within w_invoice
integer x = 3662
integer y = 60
integer width = 389
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go to Invoices"
end type

event clicked;//open(w_invoice_printing)
open(w_invoice_view)
end event

type cb_filt from commandbutton within w_invoice
integer x = 2455
integer y = 60
integer width = 274
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string ls_filter
date ld_from
date ld_to
date d_from
date d_to
integer r

dw_range.accepttext()
ld_from  = dw_range.getitemdate(1,"from_date")
ld_to  = dw_range.getitemdate(1,"to_date")
//ld_from  = date(dw_range.getitemdate(1,"from_date"))
//ld_to  = date(dw_range.getitemdate(1,"to_date"))

if not isnull( ld_from) then
	ls_filter = "charge_date >= date('" + string(ld_from) + "')"
end if

if not isnull(ld_from ) and not isnull(ld_to) then
	ls_filter = ls_filter + " and "
end if

if not isnull( ld_to) then
	ls_filter =  ls_filter + "charge_date <= date('" + string(ld_to) + "')"
end if

//d_from  = dw_range.getitemdate(1, "from_date")
//if isnull(d_from) then
//	ldt_from = datetime(date("2016-01-01"), time("00:00:00"))
//else
//	ldt_from = datetime(d_from, time("00:00:00"))
//end if
//
//d_to  = dw_range.getitemdate(1, "to_date")
//if isnull(d_to) then
//	ldt_to = datetime(date("2099-12-31"), time("23:59:59"))
//else
//	ldt_to = datetime(d_to, time("00:00:00"))
//end if

//ls_filter = "charge_date > '" + string(ldt_from) + "' and charge_date < '" + string(ldt_to) + "'"

r = dw_records.setfilter(ls_filter)
if r < 0 then messagebox("Filter failed",ls_filter)
dw_records.filter()


end event

type dw_range from u_dw within w_invoice
integer x = 933
integer y = 60
integer width = 1467
integer height = 88
integer taborder = 60
string dataobject = "d_date_range_get_blue"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type dw_facility from datawindow within w_invoice
integer x = 5
integer width = 878
integer height = 1772
integer taborder = 40
boolean titlebar = true
string title = "Select Facility"
string dataobject = "d_invoice_facilities"
boolean livescroll = true
end type

event clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row = 0 THEN
	Return -1
END IF

This.SetRow( li_row )
end event

event rowfocuschanged;IF This.RowCount() > 0  THEN
	//messagebox("","rfc")
  	 ii_selected_facility_id = This.GetItemNumber( currentrow, "parent_facility_id")
	dw_records.retrieve(il_prac_id, ii_selected_facility_id)

END IF
end event

type cb_charges from commandbutton within w_invoice
integer x = 2857
integer y = 60
integer width = 343
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Get Charges"
end type

type dw_records from datawindow within w_invoice
integer x = 901
integer y = 208
integer width = 3470
integer height = 1560
integer taborder = 40
string title = "none"
string dataobject = "d_invoice_items"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_close from commandbutton within w_invoice
integer x = 4073
integer y = 60
integer width = 247
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_delete from commandbutton within w_invoice
integer x = 3214
integer y = 60
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer i

i = messagebox("Delete","Are you sure you want to delete this record?", question!,yesno!, 2)

if i = 2 then return

dw_records.deleterow(0)
dw_records.update()

end event

type cb_save from commandbutton within w_invoice
boolean visible = false
integer x = 4334
integer y = 72
integer width = 247
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Save"
end type

event clicked;integer s = 0
integer res
integer li_facid
integer r
long ll_recid


//if  tab_1.tabpage_browse.dw_detail.GetItemStatus (1, 0, primary! ) = NewModified! then
//	s = 1
//end if
//	
//res = w_invoice.triggerevent("pfc_save")
//
//if res = 1 and s = 1 then //if a new record
//	li_facid = tab_1.tabpage_browse.dw_detail.getitemnumber(1,"facility_id")
//	ll_recid = tab_1.tabpage_browse.dw_detail.getitemnumber(1,"rec_id")
//	r = dw_facility.retrieve(il_prac_id,gs_user_id)
//	res = dw_facility.find("facility_id = " + string(li_facid),1,r)
//	if res > 0 then
//		dw_facility.scrolltorow(res)
//	end if
//	r = tab_1.tabpage_browse.dw_browse.retrieve(il_prac_id,gs_user_id,li_facid)
//	res = tab_1.tabpage_browse.dw_browse.find("rec_id = " + string(ll_recid),1,r)
//	if res > 0 then
//		tab_1.tabpage_browse.dw_browse.scrolltorow(res)
//	end if
//end if


end event

type gb_1 from groupbox within w_invoice
integer x = 901
integer width = 1509
integer height = 184
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range"
end type

