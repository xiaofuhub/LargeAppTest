$PBExportHeader$w_invoice_printing.srw
forward
global type w_invoice_printing from w_master
end type
type cb_4 from commandbutton within w_invoice_printing
end type
type dw_charge from datawindow within w_invoice_printing
end type
type dw_range from u_dw within w_invoice_printing
end type
type dw_sets from datawindow within w_invoice_printing
end type
type cb_charges from commandbutton within w_invoice_printing
end type
type dw_facility from datawindow within w_invoice_printing
end type
type cb_up from commandbutton within w_invoice_printing
end type
type cb_2 from commandbutton within w_invoice_printing
end type
type gb_3 from groupbox within w_invoice_printing
end type
type gb_f from groupbox within w_invoice_printing
end type
type dw_browse from u_dw within w_invoice_printing
end type
type cb_3 from commandbutton within w_invoice_printing
end type
type rb_ddr from radiobutton within w_invoice_printing
end type
type rb_all from radiobutton within w_invoice_printing
end type
type rb_sdree from radiobutton within w_invoice_printing
end type
type rb_ldr from radiobutton within w_invoice_printing
end type
type gb_1 from groupbox within w_invoice_printing
end type
type cb_1 from commandbutton within w_invoice_printing
end type
type gb_2 from groupbox within w_invoice_printing
end type
end forward

global type w_invoice_printing from w_master
integer x = 14
integer y = 16
integer width = 3749
integer height = 2580
string title = "Print Invoices"
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
cb_4 cb_4
dw_charge dw_charge
dw_range dw_range
dw_sets dw_sets
cb_charges cb_charges
dw_facility dw_facility
cb_up cb_up
cb_2 cb_2
gb_3 gb_3
gb_f gb_f
dw_browse dw_browse
cb_3 cb_3
rb_ddr rb_ddr
rb_all rb_all
rb_sdree rb_sdree
rb_ldr rb_ldr
gb_1 gb_1
cb_1 cb_1
gb_2 gb_2
end type
global w_invoice_printing w_invoice_printing

type variables
integer ii_facil
integer ii_usedates = 1
long il_status
long il_prac
long il_req
string is_type
string is_ret_type
n_cst_invoice_functions in_invoice
end variables

forward prototypes
public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps)
public function integer of_set_date_range ()
public function integer of_create_invoice ()
end prototypes

public function integer of_get_charges (long al_facility, date ad_from, date ad_to, boolean ab_ver, boolean ab_rec, boolean ab_apps);//Start Code Change ----08.24.2016 #V153 maha - added for creation of invoice charges
// ii_facil, ld_from,  ld_to, true, false, false)

return 1


//decimal ll_fee
//long v
//long vc = 0
//long r
//long rc = 0
//long a
//long ac = 0
//long nr
//long ll_find
//long ll_id
//long ll_inv
//long ll_cnt
//long ll_recid
//long ll_prac
//long ll_pracs[]
//long ll_act
//long ll_app
//long ll_status
//string ls_ref
//string ls_filter
//string ls_doc_id
//string ls_sql
//string ls_sql_org
//string ls_where
//string ls_crit
//string ls_from_date
//string ls_to_date
//datetime ld_charge
//datetime ldt_from
//datetime ldt_to
//datetime ldt_now
//integer res
//integer rcnt
//integer li_rules
//n_ds lds_ver
//n_ds lds_rec
//n_ds lds_apps
//datawindow lds_charge
//n_ds lds_rules
//
//
//ldt_from = datetime(ad_from, time("00:00:00"))
//ls_from_date = of_date_to_string(ldt_from, "yyyy-mm-dd")
//ls_from_date = ls_from_date + " 00:00:00"
//ldt_to = datetime(ad_to, time("23:59:59"))
//ls_to_date = of_date_to_string(ldt_to, "yyyy-mm-dd")
//ls_to_date = ls_to_date + " 23:59:59"
//ldt_now = datetime(today(), now())
//debugbreak()
//ll_status = long(gnv_data.of_getitem("code_lookup" ,'lookup_code',"upper(lookup_name) = '" + upper('Action Status') + "'" + " and upper(code) = '" + upper('Complete') + "'"))	
//
////get rules
//lds_rules = create n_ds
//lds_rules.dataobject = "d_facility_bill_browse"
//lds_rules.settransobject(sqlca)
//lds_rules.retrieve(al_facility)
//
//lds_charge = dw_charge
////	lds_charge = create n_ds
////	lds_charge.dataobject = "d_invoice_items"
//lds_charge.settransobject(sqlca)
//
////verification charges
//if ab_ver then
//	lds_ver = create n_ds
//	lds_ver.dataobject = "d_invoice_charge_ver"
//	lds_ver.settransobject(sqlca)
//	vc = lds_ver.retrieve( ldt_from, ldt_to, al_facility)
//	if vc < 1 then messagebox("of_get_charges","Verification record failed.")
//	
//	for v = 1 to vc
//		nr = lds_charge.insertrow(0)
//		ll_prac = lds_ver.getitemnumber(v, "prac_id")
//		ll_recid =  lds_ver.getitemnumber(v, "rec_id")
//		ls_ref =  lds_ver.getitemstring(v, "reference_value")
//		ll_fee = lds_ver.getitemnumber(v, "fee")
//		ls_doc_id = lds_ver.getitemstring(v, "doc_id")
//		ld_charge = lds_ver.getitemdatetime(v, "date_recieved")
//		
//		lds_charge.setitem(nr, "prac_id", ll_prac)
//		lds_charge.setitem(nr, "facility_id", al_facility)
//		lds_charge.setitem(nr, "ref_number", ll_recid)
//		lds_charge.setitem(nr, "billing_item", ls_ref)
//		lds_charge.setitem(nr, "quantity", 1)
//		lds_charge.setitem(nr, "price", ll_fee)
//		lds_charge.setitem(nr, "rec_id", ll_recid)
//		lds_charge.setitem(nr, "doc_id", ls_doc_id)
//		lds_charge.setitem(nr, "charge_date", ld_charge)
//		lds_charge.setitem(nr, "add_date", today())
//		lds_charge.setitem(nr, "add_user", gs_user_id)
//		lds_charge.setitem(nr, "charge_type", "V")
//		
//	next	
//end if
//
////RECURRING
//if ab_rec then
//	ls_filter = "bill_type = 'R' and active_status = 1"
//	res = lds_rules.setfilter(ls_filter)
//	if res < 0 then messagebox("Recurring filter failed", ls_filter)
//	lds_rules.filter()
//	rcnt = lds_rules.rowcount()
//	
//	lds_rec = create n_ds
//	lds_rec.dataobject = "d_invoice_charge_recur"
//	lds_rec.settransobject(sqlca)
//	
//	if rcnt > 0 then
//		for li_rules = 1 to rcnt
//			ls_sql_org = lds_rec.GetSQLSelect()
//			ls_sql = ls_sql_org
//			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
//			ls_where = " and (pd_affil_stat.parent_facility_id = " + string(al_facility) + ") and "
//			if isnull(ls_crit) or ls_crit = "" then
//				ls_where+= " (pd_affil_stat.active_status in (1,4) )"
//			else
//				ls_where+= ls_where
//			end if
//			
//			ls_sql+= ls_where
//			
//			lds_rec.SetSQLSelect(ls_sql)
//			lds_rec.settransobject(sqlca)
//			rc = lds_rec.retrieve()
//			if rc < 0 then
//				messagebox("Recurring retrieval failed", ls_sql)
//			end if
//			
//			for r = 1 to rc
//				nr = lds_charge.insertrow(0)
//				ll_prac = lds_rec.getitemnumber(r, "prac_id")
//				ll_recid =  lds_rec.getitemnumber(r, "rec_id")
//				ls_ref  = lds_rules.getitemstring(1, "description")
//				ll_fee  = lds_rules.getitemnumber(1, "bill_amount")
//				//for docid get rec id and prac id
//				ls_doc_id = string(ll_recid) + "-" + string(ll_prac)
//				
//				lds_charge.setitem(nr, "prac_id", ll_prac)
//				lds_charge.setitem(nr, "facility_id", al_facility)
//				lds_charge.setitem(nr, "ref_number", ll_recid)
//				lds_charge.setitem(nr, "billing_item", ls_ref)
//				lds_charge.setitem(nr, "quantity", 1)
//				lds_charge.setitem(nr, "price", ll_fee)
//				lds_charge.setitem(nr, "rec_id", ll_recid)
//				lds_charge.setitem(nr, "doc_id", ls_doc_id)
//				lds_charge.setitem(nr, "charge_date", ad_to )
//				lds_charge.setitem(nr, "add_date", today())
//				lds_charge.setitem(nr, "add_user", gs_user_id)
//				lds_charge.setitem(nr, "charge_type", "R")
//			next
//			
//			lds_rec.SetSQLSelect(ls_sql_org)
//			lds_rec.settransobject(sqlca)
//		next
//	end if
//
//end if
//
//debugbreak()
////APPLICATION charges
//if ab_apps then
//	lds_apps = create n_ds
//	lds_apps.dataobject = "d_invoice_charge_apps"
//	lds_apps.settransobject(sqlca)
//
//	ls_filter = "bill_type = 'A' and active_status = 1"
//	res = lds_rules.setfilter(ls_filter)
//	if res < 0 then messagebox("Recurring filter failed", ls_filter)
//	lds_rules.filter()
//	rcnt = lds_rules.rowcount()
//	
//	if rcnt > 0 then
//		for li_rules = 1 to rcnt
//			ls_sql_org = lds_apps.GetSQLSelect()
//			ls_sql = ls_sql_org
//			ls_crit  = lds_rules.getitemstring(li_rules, "provider_criteria")
//			ll_act = lds_rules.getitemnumber(li_rules, "action_type_id")
//			ll_app = lds_rules.getitemnumber(li_rules, "app_id")
//			if isnull(ll_act) then
//				messagebox("Application rules setup error","For an Application type billing rule there is no action type selected.  Skipping charge creation for this step")
//				Continue
//			end if
//					
//			ls_where = " and ( pd_affil_stat.parent_facility_id = " + string(al_facility) + ")"
//			ls_where+= " and  ( net_dev_action_items.action_status =  " + string(ll_status) + " ) and "
//			if isnull(ls_crit) or ls_crit = "" then
//				ls_where+= " ( pd_affil_stat.active_status in (1,4) )"
//			else
//				ls_where+= ls_where
//			end if
//			
//			ls_where+= " and ( net_dev_action_items.action_type = " + string(ll_act) + ") "
//			
//			if ll_app > 0 then
//				ls_where+= " and  (net_dev_action_items.app_id = " + string(ll_app) + ") "
//			end if
//			
//			//set date range			
//       	 	ls_where+= " and  ( net_dev_action_items.action_date >= '" + ls_from_date + "' ) "
//        		ls_where+= " and  ( net_dev_action_items.action_date <= '" +  ls_to_date  + "' ) "			
//			
//			ls_sql+= ls_where
//			
//			lds_apps.SetSQLSelect(ls_sql)
//			lds_apps.settransobject(sqlca)
//			ac = lds_apps.retrieve()
//			if ac < 0 then
//				messagebox("Applications retrieval failed", ls_sql)
//			end if
//			messagebox("Application retrieval", ls_sql)
//			//clipboard(ls_sql)
//			
//			for a = 1 to ac
//				nr = lds_charge.insertrow(0)
//				ll_prac = lds_apps.getitemnumber(a, "prac_id")
//				ll_recid =  lds_apps.getitemnumber(a, "rec_id")
//				ls_ref  = lds_rules.getitemstring(1, "description")
//				ll_fee  = lds_rules.getitemnumber(1, "bill_amount")
//				//for docid get rec id and prac id
//				ls_doc_id =  lds_apps.getitemstring(a, "doc_id")
//				ld_charge = lds_apps.getitemdatetime(a, "action_date")
//				
//				lds_charge.setitem(nr, "prac_id", ll_prac)
//				lds_charge.setitem(nr, "facility_id", al_facility)
//				lds_charge.setitem(nr, "ref_number", ll_recid)
//				lds_charge.setitem(nr, "billing_item", ls_ref)
//				lds_charge.setitem(nr, "quantity", 1)
//				lds_charge.setitem(nr, "price", ll_fee)
//				lds_charge.setitem(nr, "rec_id", ll_recid)
//				lds_charge.setitem(nr, "doc_id", ls_doc_id)
//				lds_charge.setitem(nr, "charge_date", ld_charge)
//				lds_charge.setitem(nr, "add_date", today())
//				lds_charge.setitem(nr, "add_user", gs_user_id)
//				lds_charge.setitem(nr, "charge_type", "A")
//			next
//			
//			lds_apps.SetSQLSelect(ls_sql_org)
//			lds_apps.settransobject(sqlca)
//		next
//	end if
//
//end if
//
////set the item ids	
////,"invt_id"	
//select max(item_id) into :ll_id from pd_inv_rows;
//if isnull(ll_id) then ll_id = 0
//
//for r = 1 to lds_charge.rowcount()
//	ll_id++
//	lds_charge.setitem(r, "item_id", ll_id)
//next
//
//v = lds_charge.update()
////if v < 1 then messagebox("Update failed", lds_charge.DBErrorMessage)
//
////create the pd_invoice records
//
//
//if isvalid(lds_ver) then destroy lds_ver
//if isvalid(lds_rec) then destroy lds_rec
//if isvalid(lds_apps) then destroy lds_apps
//if isvalid(lds_charge) then destroy lds_charge
//if isvalid(lds_rules) then destroy lds_rules
//
//return 1
end function

public function integer of_set_date_range ();date ld_from
date ld_to
date ld_now
integer ll_month
integer ll_day
integer ll_year

ld_now = today()

ll_month = month(ld_now)
ll_year = year(ld_now)

ld_from = date( string(ll_month) + "-" + "01-" +  string(ll_year))

choose case ll_month
	case 1, 3, 4, 7, 8, 10, 12
		ll_day = 31
	case 2
		if mod(ll_year, 4) = 0 then
			ll_day = 29
		else
			ll_day = 28
		end if
	case else
		ll_day = 30
end choose

ld_to = date( string(ll_month) + "-" + string(ll_day) + "-" +  string(ll_year))

dw_range.setitem(1, "from_date",  ld_from)
dw_range.setitem(1, "to_date",  ld_to)



return 1



end function

public function integer of_create_invoice ();//Start Code Change ----08.30.2016 #V153 maha








return 1


end function

on w_invoice_printing.create
int iCurrent
call super::create
this.cb_4=create cb_4
this.dw_charge=create dw_charge
this.dw_range=create dw_range
this.dw_sets=create dw_sets
this.cb_charges=create cb_charges
this.dw_facility=create dw_facility
this.cb_up=create cb_up
this.cb_2=create cb_2
this.gb_3=create gb_3
this.gb_f=create gb_f
this.dw_browse=create dw_browse
this.cb_3=create cb_3
this.rb_ddr=create rb_ddr
this.rb_all=create rb_all
this.rb_sdree=create rb_sdree
this.rb_ldr=create rb_ldr
this.gb_1=create gb_1
this.cb_1=create cb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.dw_charge
this.Control[iCurrent+3]=this.dw_range
this.Control[iCurrent+4]=this.dw_sets
this.Control[iCurrent+5]=this.cb_charges
this.Control[iCurrent+6]=this.dw_facility
this.Control[iCurrent+7]=this.cb_up
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_f
this.Control[iCurrent+11]=this.dw_browse
this.Control[iCurrent+12]=this.cb_3
this.Control[iCurrent+13]=this.rb_ddr
this.Control[iCurrent+14]=this.rb_all
this.Control[iCurrent+15]=this.rb_sdree
this.Control[iCurrent+16]=this.rb_ldr
this.Control[iCurrent+17]=this.gb_1
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.gb_2
end on

on w_invoice_printing.destroy
call super::destroy
destroy(this.cb_4)
destroy(this.dw_charge)
destroy(this.dw_range)
destroy(this.dw_sets)
destroy(this.cb_charges)
destroy(this.dw_facility)
destroy(this.cb_up)
destroy(this.cb_2)
destroy(this.gb_3)
destroy(this.gb_f)
destroy(this.dw_browse)
destroy(this.cb_3)
destroy(this.rb_ddr)
destroy(this.rb_all)
destroy(this.rb_sdree)
destroy(this.rb_ldr)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.gb_2)
end on

event open;call super::open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent


dw_facility.settransobject(sqlca)

dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//dw_facility.retrieve(gs_user_id)
dw_facility.insertrow(1)
if li_facility_id < 1 or isnull(li_facility_id) then
	SELECT security_users.default_search_facility  
	INTO :li_facility_id  
	FROM security_users  
	WHERE security_users.user_id = :gs_user_id;
end if

IF Not IsNull( li_facility_id ) THEN //set user default facility
	dw_facility.SetItem( 1, "facility_facility_id", li_facility_id )
	dw_sets.retrieve(li_facility_id)
END IF
ii_facil = li_facility_id

//in_invoice = create n_cst_invoice_functions

of_set_date_range( )

end event

event closequery;//no message
end event

event resize;call super::resize;//Start Code Change ----08.08.2016 #V152 maha
long ll_h
long ll_w

ll_h = this.workspaceheight( )
ll_w = this.workspacewidth( )

dw_browse.height = ll_h - 25 - 348
dw_browse.width = ll_w - 25 - 10
end event

type cb_4 from commandbutton within w_invoice_printing
integer x = 2491
integer y = 56
integer width = 411
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save Invoice"
end type

event clicked;date ld_from
date ld_to
integer i
integer rc
integer res
long p
long pcnt
long rcnt

if  ii_facil < 1 then
	messagebox("User Select Error","You must select a facility to run this function.")
	return
end if

ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if not isnull(ld_from)  then
	//ldt_from = datetime(ld_from, time("00:00:00"))
else
	ld_from = date("01-01-2000")
end if

if not isnull(ld_to)  then
	//
else
	ld_to = date("12-31-2099")
end if

//if em_from.text = "" then ld_from = date(01-01-1950)
//if em_to.text = ""  then ld_to = date(12-31-2099)
//messagebox("ii_usedates",ii_usedates)
if ii_usedates = 1 then
	dw_browse.retrieve(ii_facil,ld_from,ld_to)
else
	dw_browse.retrieve(ii_facil)
end if

end event

type dw_charge from datawindow within w_invoice_printing
integer x = 50
integer width = 91
integer height = 176
integer taborder = 10
string title = "none"
string dataobject = "d_invoice_items"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_range from u_dw within w_invoice_printing
integer x = 2176
integer y = 244
integer width = 1467
integer height = 88
integer taborder = 110
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

type dw_sets from datawindow within w_invoice_printing
integer x = 933
integer y = 252
integer width = 1198
integer height = 72
integer taborder = 10
string title = "none"
string dataobject = "d_facility_billing_set"
boolean border = false
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

type cb_charges from commandbutton within w_invoice_printing
integer x = 1664
integer y = 56
integer width = 402
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Get Charges"
end type

event clicked;date ld_from
date ld_to
boolean lb_ver = false
boolean lb_rec = false
boolean lb_apps = false

debugbreak()
dw_range.accepttext( )
ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if isnull(ld_from) then
	messagebox("Get Charges","You must have a date range")
	return 
end if

if isnull(ld_to) then
	messagebox("Get Charges","You must have a date range")
	return 
end if

if dw_sets.getitemnumber(1, "bill_ver") = 1 then lb_ver = true
if dw_sets.getitemnumber(1, "bill_recur") = 1 then lb_rec = true
if dw_sets.getitemnumber(1, "bill_apps") = 1 then lb_apps = true

in_invoice.of_get_charges( ii_facil, ld_from,  ld_to, lb_ver , lb_rec, lb_apps, 0)
end event

type dw_facility from datawindow within w_invoice_printing
integer x = 55
integer y = 240
integer width = 814
integer height = 84
integer taborder = 60
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)
dw_sets.retrieve(ii_facil)



end event

type cb_up from commandbutton within w_invoice_printing
integer x = 2071
integer y = 56
integer width = 411
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Preview Invoice"
end type

event clicked;date ld_from
date ld_to
integer i
integer rc
integer res
long p
long pcnt
long rcnt

if  ii_facil < 1 then
	messagebox("User Select Error","You must select a facility to run this function.")
	return
end if

ld_from = dw_range.getitemdate(1,"from_date")
ld_to = dw_range.getitemdate(1,"to_date")

if not isnull(ld_from)  then
	//ldt_from = datetime(ld_from, time("00:00:00"))
else
	ld_from = date("01-01-2000")
end if

if not isnull(ld_to)  then
	//
else
	ld_to = date("12-31-2099")
end if

//if em_from.text = "" then ld_from = date(01-01-1950)
//if em_to.text = ""  then ld_to = date(12-31-2099)
//messagebox("ii_usedates",ii_usedates)
if ii_usedates = 1 then
	dw_browse.retrieve(ii_facil,ld_from,ld_to)
else
	dw_browse.retrieve(ii_facil)
end if

end event

type cb_2 from commandbutton within w_invoice_printing
integer x = 3447
integer y = 56
integer width = 247
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type gb_3 from groupbox within w_invoice_printing
integer x = 3913
integer y = 136
integer width = 576
integer height = 596
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "InvoiceType"
end type

type gb_f from groupbox within w_invoice_printing
integer x = 18
integer y = 180
integer width = 873
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
string text = "Select Facility"
end type

type dw_browse from u_dw within w_invoice_printing
integer x = 14
integer y = 380
integer width = 3666
integer height = 2080
integer taborder = 10
string dataobject = "d_invoice_for_date_range"
boolean hscrollbar = true
end type

event clicked;//
//Integer li_row
//
//li_row = This.GetClickedRow( )
//
//IF li_row < 1 THEN
//	Return
//END IF
//
//
//This.ScrollToRow( li_row )
//This.SetRow( li_row )
////this.selectrow(0,false)
////this.selectrow(li_row,true)
//
end event

event doubleclicked;call super::doubleclicked;
//long ll_core
//integer li_row
//integer li_end
//
//if this.rowcount() > 0 then
//	tab_1.selecttab (2)
//	
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;
integer res

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	this.deleterow(this.getrow())
end if

this.update()

return 0
end event

event buttonclicked;call super::buttonclicked;integer i

for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type cb_3 from commandbutton within w_invoice_printing
integer x = 2912
integer y = 56
integer width = 256
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_browse.print()
end event

type rb_ddr from radiobutton within w_invoice_printing
integer x = 3909
integer y = 180
integer width = 544
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Detail (Date Range)"
boolean checked = true
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_detail"
dw_browse.settransobject(sqlca)
dw_browse.title = "Detail Date Range"
ii_usedates = 1
end event

type rb_all from radiobutton within w_invoice_printing
integer x = 3904
integer y = 256
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All Open (No Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_all_open"
dw_browse.settransobject(sqlca)
dw_browse.title = "All Open"

ii_usedates = 0
end event

type rb_sdree from radiobutton within w_invoice_printing
integer x = 3936
integer y = 412
integer width = 608
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Summary (Date Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_summary"
dw_browse.settransobject(sqlca)
dw_browse.title = "Summary Date Range"
//st_mess.text = "Sets all REQUESTED Privileges to the update settings ,and sends all other active privileges to history."
ii_usedates = 1
end event

type rb_ldr from radiobutton within w_invoice_printing
integer x = 3922
integer y = 348
integer width = 571
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "List (Date Range)"
end type

event clicked;dw_browse.dataobject = "d_frm_facility_invoice_4_date"
dw_browse.settransobject(sqlca)
dw_browse.title = "List Date Range"
ii_usedates = 1
end event

type gb_1 from groupbox within w_invoice_printing
integer x = 2171
integer y = 180
integer width = 1509
integer height = 184
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Invoice Date Range"
end type

type cb_1 from commandbutton within w_invoice_printing
integer x = 3182
integer y = 56
integer width = 247
integer height = 84
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;openwithparm(w_help_window,1)
end event

type gb_2 from groupbox within w_invoice_printing
integer x = 914
integer y = 180
integer width = 1239
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Service Types"
end type

