$PBExportHeader$w_invoice_14.srw
forward
global type w_invoice_14 from w_main
end type
type p_1 from picture within w_invoice_14
end type
type tab_1 from tab within w_invoice_14
end type
type tabpage_browse from userobject within tab_1
end type
type rb_all from radiobutton within tabpage_browse
end type
type rb_paid from radiobutton within tabpage_browse
end type
type rb_open from radiobutton within tabpage_browse
end type
type r_1 from rectangle within tabpage_browse
end type
type dw_browse from u_dw within tabpage_browse
end type
type dw_detail from u_dw within tabpage_browse
end type
type cb_add from commandbutton within tabpage_browse
end type
type gb_1 from groupbox within tabpage_browse
end type
type tabpage_browse from userobject within tab_1
rb_all rb_all
rb_paid rb_paid
rb_open rb_open
r_1 r_1
dw_browse dw_browse
dw_detail dw_detail
cb_add cb_add
gb_1 gb_1
end type
type tabpage_detail from userobject within tab_1
end type
type st_add from statictext within tabpage_detail
end type
type dw_invt from datawindow within tabpage_detail
end type
type dw_items from u_dw within tabpage_detail
end type
type cb_edit from commandbutton within tabpage_detail
end type
type cb_1 from commandbutton within tabpage_detail
end type
type tabpage_detail from userobject within tab_1
st_add st_add
dw_invt dw_invt
dw_items dw_items
cb_edit cb_edit
cb_1 cb_1
end type
type tab_1 from tab within w_invoice_14
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type
type dw_facility from u_dw within w_invoice_14
end type
type cb_close from commandbutton within w_invoice_14
end type
type cb_delete from commandbutton within w_invoice_14
end type
type cb_save from commandbutton within w_invoice_14
end type
end forward

global type w_invoice_14 from w_main
integer x = 27
integer y = 32
integer width = 3538
integer height = 1864
string title = "Invoices"
boolean maxbox = false
boolean resizable = false
windowtype windowtype = popup!
long backcolor = 33551856
p_1 p_1
tab_1 tab_1
dw_facility dw_facility
cb_close cb_close
cb_delete cb_delete
cb_save cb_save
end type
global w_invoice_14 w_invoice_14

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

tab_1.tabpage_detail.dw_items.accepttext()
li_quant = tab_1.tabpage_detail.dw_items.getitemnumber(ai_row,"quantity")
li_price = tab_1.tabpage_detail.dw_items.getitemnumber(ai_row,"price")
li_total = li_quant * li_price


tab_1.tabpage_detail.dw_items.setitem(ai_row,"extended",li_total)


return li_total
end function

public function integer of_compute_total ();integer i
double li_price
double li_total

for i = 1 to tab_1.tabpage_detail.dw_items.rowcount()
	li_total = li_total + tab_1.tabpage_detail.dw_items.getitemnumber(i,"extended")
next

tab_1.tabpage_browse.dw_detail.setitem(1,"invc_amt",li_total)

return 1
end function

on w_invoice_14.create
int iCurrent
call super::create
this.p_1=create p_1
this.tab_1=create tab_1
this.dw_facility=create dw_facility
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_facility
this.Control[iCurrent+4]=this.cb_close
this.Control[iCurrent+5]=this.cb_delete
this.Control[iCurrent+6]=this.cb_save
end on

on w_invoice_14.destroy
call super::destroy
destroy(this.p_1)
destroy(this.tab_1)
destroy(this.dw_facility)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.cb_save)
end on

event open;call super::open;datawindowchild dwchild

debugbreak()
il_prac_id = message.doubleparm

if il_prac_id < 0 then
	messagebox("?","Unknown practitioner. Please close and reselect practitioner.")
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Integrate SQL statements into Appeon Queue labels to reduce client-server interactions for performance
//$<modification> tuning.
/*
dw_facility.settransobject(sqlca)
dw_facility.retrieve(il_prac_id,gs_user_id)

tab_1.tabpage_browse.dw_browse.settransobject(sqlca)
tab_1.tabpage_browse.dw_detail.settransobject(sqlca)
tab_1.tabpage_detail.dw_items.settransobject(sqlca)

select term_days into :ii_days from inv_company;
*/

dw_facility.settransobject(sqlca)

tab_1.tabpage_browse.dw_browse.settransobject(sqlca)
tab_1.tabpage_browse.dw_detail.settransobject(sqlca)
tab_1.tabpage_detail.dw_items.settransobject(sqlca)

dw_facility.retrieve(il_prac_id,gs_user_id)

gnv_appeondb.of_startqueue( )

select term_days into :ii_days from inv_company;

tab_1.tabpage_browse.dw_detail.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

tab_1.tabpage_browse.dw_browse.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

gnv_appeondb.of_commitqueue( )
//Locate the button in the correct position in web application.
If appeongetclienttype()<> 'PB' Then
	cb_save.y = cb_save.y - 12
	cb_delete.y = cb_delete.y - 12
	cb_close.y = cb_close.y - 12
End If
//---------------------------- APPEON END ----------------------------

//Start Code Change ----09.30.2016 #V152 maha - added
if w_mdi.of_security_access( 7830 ) = 1 THEN //read only
	cb_save.visible = false
	cb_delete.visible = false
	tab_1.tabpage_detail.cb_edit.visible = false
	tab_1.tabpage_detail.dw_invt.visible = false
	tab_1.tabpage_detail.st_add.visible = false
	tab_1.tabpage_browse.cb_add.visible = false
end if

end event

type p_1 from picture within w_invoice_14
boolean visible = false
integer x = 800
integer y = 20
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type tab_1 from tab within w_invoice_14
integer x = 814
integer y = 32
integer width = 2670
integer height = 1696
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_detail tabpage_detail
end type

on tab_1.create
this.tabpage_browse=create tabpage_browse
this.tabpage_detail=create tabpage_detail
this.Control[]={this.tabpage_browse,&
this.tabpage_detail}
end on

on tab_1.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_detail)
end on

type tabpage_browse from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2633
integer height = 1568
long backcolor = 33551856
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
string picturename = "Justify!"
long picturemaskcolor = 553648127
rb_all rb_all
rb_paid rb_paid
rb_open rb_open
r_1 r_1
dw_browse dw_browse
dw_detail dw_detail
cb_add cb_add
gb_1 gb_1
end type

on tabpage_browse.create
this.rb_all=create rb_all
this.rb_paid=create rb_paid
this.rb_open=create rb_open
this.r_1=create r_1
this.dw_browse=create dw_browse
this.dw_detail=create dw_detail
this.cb_add=create cb_add
this.gb_1=create gb_1
this.Control[]={this.rb_all,&
this.rb_paid,&
this.rb_open,&
this.r_1,&
this.dw_browse,&
this.dw_detail,&
this.cb_add,&
this.gb_1}
end on

on tabpage_browse.destroy
destroy(this.rb_all)
destroy(this.rb_paid)
destroy(this.rb_open)
destroy(this.r_1)
destroy(this.dw_browse)
destroy(this.dw_detail)
destroy(this.cb_add)
destroy(this.gb_1)
end on

type rb_all from radiobutton within tabpage_browse
integer x = 599
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;dw_browse.setfilter("")
dw_browse.filter()
end event

type rb_paid from radiobutton within tabpage_browse
integer x = 343
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Paid"
end type

event clicked;dw_browse.setfilter("paid = 1")
dw_browse.filter()
end event

type rb_open from radiobutton within tabpage_browse
integer x = 78
integer y = 68
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Open "
end type

event clicked;dw_browse.setfilter("paid <> 1")
dw_browse.filter()
end event

type r_1 from rectangle within tabpage_browse
long linecolor = 67108864
integer linethickness = 4
long fillcolor = 33551856
integer x = 14
integer y = 24
integer width = 869
integer height = 144
end type

type dw_browse from u_dw within tabpage_browse
integer x = 14
integer y = 184
integer width = 2560
integer height = 652
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_invoice_browse_prac_14"
boolean hscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;
if this.rowcount() > 0 then
	
	il_invoice = this.getitemnumber(currentrow,"rec_id")
	dw_detail.settransobject(sqlca)
	dw_detail.retrieve(il_invoice)
	tab_1.tabpage_detail.dw_items.settransobject(sqlca)
	tab_1.tabpage_detail.dw_items.retrieve(il_invoice)
	dw_detail.setfocus()
end if
end event

event retrieveend;call super::retrieveend;if this.rowcount() > 0 then
	
	il_invoice = this.getitemnumber(this.getrow(),"rec_id")
	dw_detail.settransobject(sqlca)
	dw_detail.retrieve(il_invoice)
	tab_1.tabpage_detail.dw_items.settransobject(sqlca)
	tab_1.tabpage_detail.dw_items.retrieve(il_invoice)
	dw_detail.setfocus()
end if
end event

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

//DEBUGBREAK()

IF li_row = 0 THEN
	//tab_1.tabpage_browse_1.dw_apptmnt_status.SetFocus( )
	Return -1
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event doubleclicked;call super::doubleclicked;tab_1.selecttab(2)
end event

event constructor;call super::constructor;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<comment> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Remove all scripts to the window::open event.  Refer to PT-01 for details.
/*
datawindowchild dwchild

this.settransobject(sqlca)


this.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
*/
//---------------------------- APPEON END ----------------------------

end event

type dw_detail from u_dw within tabpage_browse
integer x = 23
integer y = 852
integer width = 2551
integer height = 700
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_invoice_detail"
boolean vscrollbar = false
end type

event retrieveend;call super::retrieveend;
datawindowchild dwchild

tab_1.tabpage_detail.dw_invt.settransobject(sqlca)
tab_1.tabpage_detail.dw_invt.retrieve()
tab_1.tabpage_detail.dw_invt.insertrow(1)

//tab_1.tabpage_detail.dw_invt.GetChild( "invt_id", dwchild )
//dwchild.insertrow(1)

//tab_1.tabpage_detail.dw_items.GetChild( "invt_id", dwchild )
//dwchild.scrolltorow(1)
end event

event pfc_preupdate;call super::pfc_preupdate;if isnull(this.getitemnumber(1,"facility_id")) then
	messagebox("Missing Data","You must have a facility Selected.  Save not made.")
	tab_1.selecttab(1)
	tab_1.tabpage_browse.dw_detail.setfocus()
	return -1
else
	return 1
end if
end event

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<comment> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Remove all scripts to the window::open event.  Refer to PT-01 for details.
/*
datawindowchild dwchild

this.settransobject(sqlca)


this.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//dwchild.insertrow(1)
*/
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;//date 

if dwo.name = "inv_date" then
//	of_duedate()
//	if ii_days > 0 then
//		
//		this.setitem(row,"due_date",this.getitemdatetime())
end if
end event

type cb_add from commandbutton within tabpage_browse
integer x = 1061
integer y = 36
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;long ll_recid
integer nr
datawindowchild dwchild

nr = dw_detail.insertrow(1)

ll_recid = gnv_app.of_Get_Id("RECORD_ID")
dw_detail.setitem(nr,"rec_id",ll_recid)
dw_detail.setitem(nr,"prac_id",il_prac_id)
dw_detail.setitem(nr,"inv_date",today())
tab_1.tabpage_detail.dw_items.reset()

tab_1.tabpage_detail.dw_invt.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

//datawindowchild dwchild
//
//tab_1.tabpage_detail.dw_invt.GetChild( "invt_id", dwchild )
//dwchild.insertrow(1)
//tab_1.tabpage_detail.dw_invt.settransobject(sqlca)
//tab_1.tabpage_detail.dw_invt.retrieve()
//tab_1.tabpage_detail.dw_invt.insertrow(1)
end event

type gb_1 from groupbox within tabpage_browse
integer x = 27
integer y = 8
integer width = 859
integer height = 156
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter"
end type

type tabpage_detail from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2633
integer height = 1568
long backcolor = 33551856
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
st_add st_add
dw_invt dw_invt
dw_items dw_items
cb_edit cb_edit
cb_1 cb_1
end type

on tabpage_detail.create
this.st_add=create st_add
this.dw_invt=create dw_invt
this.dw_items=create dw_items
this.cb_edit=create cb_edit
this.cb_1=create cb_1
this.Control[]={this.st_add,&
this.dw_invt,&
this.dw_items,&
this.cb_edit,&
this.cb_1}
end on

on tabpage_detail.destroy
destroy(this.st_add)
destroy(this.dw_invt)
destroy(this.dw_items)
destroy(this.cb_edit)
destroy(this.cb_1)
end on

type st_add from statictext within tabpage_detail
integer x = 27
integer y = 56
integer width = 439
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Select Item to Add"
boolean focusrectangle = false
end type

type dw_invt from datawindow within tabpage_detail
integer x = 462
integer y = 40
integer width = 841
integer height = 80
integer taborder = 30
string dataobject = "d_invt_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;datawindowchild dwchild
integer nr
integer fr
string st
long li_inv
double ld_ext
long ll_item


This.GetChild( "invt_id", dwchild )
st = "invt_id = " + data 
fr = dwchild.find(st,1,dwchild.rowcount())
//messagebox("find",st)
li_inv = long(data)

if fr < 1 then
	messagebox("no find",fr)
	return
end if



nr = dw_items.insertrow(0)
dw_items.setitem(nr,"cost",dwchild.getitemnumber(fr,"cost"))
dw_items.setitem(nr,"price",dwchild.getitemnumber(fr,"price"))
dw_items.setitem(nr,"quantity",1)
dw_items.setitem(nr,"invt_id",li_inv)
dw_items.setitem(nr,"billing_item",dwchild.getitemstring(fr,"description"))
//dw_items.setitem(nr,"item_id",long(data)) //set in preupdate
dw_items.setitem(nr,"rec_id",tab_1.tabpage_browse.dw_detail.getitemnumber(1,"rec_id"))
ld_ext = of_compute_item(nr)
dw_items.setitem(nr,"extended",ld_ext)
of_compute_total()

end event

event constructor;
datawindowchild dwchild

this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)

This.GetChild( "invt_id", dwchild )
dwchild.insertrow(1)
end event

type dw_items from u_dw within tabpage_detail
integer x = 14
integer y = 184
integer width = 2597
integer height = 1332
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_invoice_items_14"
end type

event pfc_preupdate;integer i
long iid

select max(item_id) into :iid from pd_inv_rows;
if isnull(iid) then iid = 0;
//messagebox("pre up",iid)
for i = 1 to this.rowcount()
	if isnull(this.getitemnumber(i,"item_id")) then
		iid++
		this.setitem(i,"item_id",iid)
	end if
next

return 1


end event

event constructor;call super::constructor;this.SetRowFocusIndicator (p_1) 
end event

event clicked;call super::clicked;integer r

r = this.getclickedrow()
this.setrow(r)
end event

event itemchanged;call super::itemchanged;//messagebox("","ifc")
of_compute_item(row)
of_compute_total()
end event

type cb_edit from commandbutton within tabpage_detail
integer x = 1842
integer y = 36
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
string text = "Edit Items"
end type

event clicked;open(w_inventory_edit)

datawindowchild dwchild

tab_1.tabpage_detail.dw_invt.settransobject(sqlca)
tab_1.tabpage_detail.dw_invt.retrieve()
tab_1.tabpage_detail.dw_invt.insertrow(1)

tab_1.tabpage_detail.dw_invt.GetChild( "invt_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
end event

type cb_1 from commandbutton within tabpage_detail
integer x = 2107
integer y = 36
integer width = 247
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;open(w_invoice_printing_14)
end event

type dw_facility from u_dw within w_invoice_14
integer x = 5
integer y = 32
integer width = 795
integer height = 1696
integer taborder = 10
boolean titlebar = true
string title = "Select Facility"
string dataobject = "d_pd_invoice_orgs"
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

//DEBUGBREAK()

IF li_row = 0 THEN
	//tab_1.tabpage_browse_1.dw_apptmnt_status.SetFocus( )
	Return -1
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )
end event

event constructor;call super::constructor;IF gs_cust_type = "C" THEN
	This.Title = 'Select Client'
ELSEIF gs_cust_type = "I" THEN
	This.Title = 'Select Payor/Hospital'
ELSE
	This.Title = 'Select Facility'
END IF
end event

event rowfocuschanged;call super::rowfocuschanged;Integer li_org_id
Integer li_facility_id
debugbreak()
IF This.RowCount() > 0  THEN
	//messagebox("","rfc")
   ii_selected_facility_id = This.GetItemNumber( currentrow, "facility_id")
	tab_1.tabpage_browse.dw_browse.settransobject(sqlca)
	tab_1.tabpage_browse.dw_browse.retrieve(il_prac_id,gs_user_id,ii_selected_facility_id)
	
	tab_1.tabpage_browse.dw_browse.SelectRow(1, True)
END IF





end event

event rowfocuschanging;call super::rowfocuschanging;//ib_retrieved_allready = True
end event

event retrieveend;call super::retrieveend;IF this.rowcount() > 0 THEN
	
	This.SelectRow( 0, False )
	This.SelectRow( 1, True )
end if
end event

type cb_close from commandbutton within w_invoice_14
integer x = 3200
integer y = 32
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

type cb_delete from commandbutton within w_invoice_14
integer x = 2144
integer y = 180
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

if tab_1.selectedtab = 1 then//browse/detail
	for i = tab_1.tabpage_detail.dw_items.rowcount() to 1 step - 1
		tab_1.tabpage_detail.dw_items.deleterow(i)
	next
	tab_1.tabpage_browse.dw_detail.deleterow(1)
		
elseif tab_1.selectedtab = 2 then //items
	tab_1.tabpage_detail.dw_items.deleterow(tab_1.tabpage_detail.dw_items.getrow())
end if

of_compute_total()
end event

type cb_save from commandbutton within w_invoice_14
integer x = 2409
integer y = 180
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer s = 0
integer res
integer li_facid
integer r
long ll_recid

of_compute_total()
if  tab_1.tabpage_browse.dw_detail.GetItemStatus (1, 0, primary! ) = NewModified! then
	s = 1
end if
	
res = w_invoice.triggerevent("pfc_save")

if res = 1 and s = 1 then //if a new record
	li_facid = tab_1.tabpage_browse.dw_detail.getitemnumber(1,"facility_id")
	ll_recid = tab_1.tabpage_browse.dw_detail.getitemnumber(1,"rec_id")
	r = dw_facility.retrieve(il_prac_id,gs_user_id)
	res = dw_facility.find("facility_id = " + string(li_facid),1,r)
	if res > 0 then
		dw_facility.scrolltorow(res)
	end if
	r = tab_1.tabpage_browse.dw_browse.retrieve(il_prac_id,gs_user_id,li_facid)
	res = tab_1.tabpage_browse.dw_browse.find("rec_id = " + string(ll_recid),1,r)
	if res > 0 then
		tab_1.tabpage_browse.dw_browse.scrolltorow(res)
	end if
end if


end event

