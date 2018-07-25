$PBExportHeader$w_batch_update_staff_cat.srw
forward
global type w_batch_update_staff_cat from window
end type
type st_1 from statictext within w_batch_update_staff_cat
end type
type dw_1 from u_dw within w_batch_update_staff_cat
end type
type rb_r from radiobutton within w_batch_update_staff_cat
end type
type rb_a from radiobutton within w_batch_update_staff_cat
end type
type rb_b from radiobutton within w_batch_update_staff_cat
end type
type cb_2 from commandbutton within w_batch_update_staff_cat
end type
type cb_up from commandbutton within w_batch_update_staff_cat
end type
type em_to from editmask within w_batch_update_staff_cat
end type
type st_1a from statictext within w_batch_update_staff_cat
end type
type st_2a from statictext within w_batch_update_staff_cat
end type
type em_from from editmask within w_batch_update_staff_cat
end type
type dw_pracs from datawindow within w_batch_update_staff_cat
end type
type dw_facility from datawindow within w_batch_update_staff_cat
end type
type gb_filt from groupbox within w_batch_update_staff_cat
end type
type gb_f from groupbox within w_batch_update_staff_cat
end type
type gb_1 from groupbox within w_batch_update_staff_cat
end type
type ddlb_1 from dropdownlistbox within w_batch_update_staff_cat
end type
end forward

global type w_batch_update_staff_cat from window
integer x = 46
integer y = 176
integer width = 3648
integer height = 1940
boolean titlebar = true
string title = "Staff Category Batch Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_1 st_1
dw_1 dw_1
rb_r rb_r
rb_a rb_a
rb_b rb_b
cb_2 cb_2
cb_up cb_up
em_to em_to
st_1a st_1a
st_2a st_2a
em_from em_from
dw_pracs dw_pracs
dw_facility dw_facility
gb_filt gb_filt
gb_f gb_f
gb_1 gb_1
ddlb_1 ddlb_1
end type
global w_batch_update_staff_cat w_batch_update_staff_cat

type variables
integer ii_facil
integer ii_status = 20
long il_pracs[]
end variables

forward prototypes
public function integer of_filter (string as_status)
end prototypes

public function integer of_filter (string as_status);string s
string ls_filt

//s = as_status

if rb_a.checked then
	ls_filt = "requested = 1"
elseif  rb_r.checked then
	ls_filt = "requested = 2"
else
	ls_filt = ""
end if

if as_status = "A" then //prefilter for audit
	if ls_filt = "" then
		ls_filt = "selected = 1"
	else
		ls_filt = "selected = 1 and " + ls_filt
	end if
end if
//messagebox("",ls_filt)
dw_1.setfilter(ls_filt)
dw_1.filter()

return 1
end function

on w_batch_update_staff_cat.create
this.st_1=create st_1
this.dw_1=create dw_1
this.rb_r=create rb_r
this.rb_a=create rb_a
this.rb_b=create rb_b
this.cb_2=create cb_2
this.cb_up=create cb_up
this.em_to=create em_to
this.st_1a=create st_1a
this.st_2a=create st_2a
this.em_from=create em_from
this.dw_pracs=create dw_pracs
this.dw_facility=create dw_facility
this.gb_filt=create gb_filt
this.gb_f=create gb_f
this.gb_1=create gb_1
this.ddlb_1=create ddlb_1
this.Control[]={this.st_1,&
this.dw_1,&
this.rb_r,&
this.rb_a,&
this.rb_b,&
this.cb_2,&
this.cb_up,&
this.em_to,&
this.st_1a,&
this.st_2a,&
this.em_from,&
this.dw_pracs,&
this.dw_facility,&
this.gb_filt,&
this.gb_f,&
this.gb_1,&
this.ddlb_1}
end on

on w_batch_update_staff_cat.destroy
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.rb_r)
destroy(this.rb_a)
destroy(this.rb_b)
destroy(this.cb_2)
destroy(this.cb_up)
destroy(this.em_to)
destroy(this.st_1a)
destroy(this.st_2a)
destroy(this.em_from)
destroy(this.dw_pracs)
destroy(this.dw_facility)
destroy(this.gb_filt)
destroy(this.gb_f)
destroy(this.gb_1)
destroy(this.ddlb_1)
end on

event open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
string errors
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent
gs_batch_search lst_search

lst_sent = message.powerobjectparm
ll_pracs[] = lst_sent.li_prac_id[]

//if upperbound(ll_pracs[]) < 0 then return
//Start Code Change ----01.28.2015 #V14.2 maha - modified code for new choice window
if upperbound(ll_pracs[]) = 0 then
	open(w_practitioner_filter_choice_new)
	
	if message.stringparm = "C" then  //cancel
	   // mskinner 21 dec 2005 -- begin
		close(this)
		// mskinner 21 dec 2005 -- end
		return -1
	else 
		lst_search = message.powerobjectparm
		ll_pracs[] = lst_search.li_prac_id
	end if
end if
//End Code Change ----01.28.2015


gnv_appeondb.of_startqueue( )

dw_facility.settransobject(sqlca)

dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

il_pracs[] = ll_pracs[]

dw_pracs.settransobject(sqlca)
p = dw_pracs.retrieve(il_pracs)

gnv_appeondb.of_commitqueue( )

dw_facility.insertrow(1)


end event

type st_1 from statictext within w_batch_update_staff_cat
integer x = 2213
integer y = 48
integer width = 265
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Requested"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_batch_update_staff_cat
integer x = 878
integer y = 280
integer width = 2697
integer height = 1508
integer taborder = 80
boolean titlebar = true
string title = "Staff Category"
string dataobject = "d_batch_up_staff_cat"
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/17/2008 By: Ken.Guo
//$<reason> Filter with staff category data
Long nulllong
DatawindowChild dwchild
This.GetChild( "pd_affil_staff_cat_staff_category", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('staff category') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )
//---------------------------- APPEON END ----------------------------

end event

event dberror;//Overide - alfee 09.16.2009

string	ls_message

ls_message = " A database error has occurred." + &
             " Database error code:  " + String (sqldbcode)  + &
	           " Database error message:" + sqlerrtext  + "~r~n Data Object: " + string(dataobject)

MessageBox(gnv_app.iapp_object.DisplayName, ls_message, StopSign!, Ok!, 1)

return 1
end event

type rb_r from radiobutton within w_batch_update_staff_cat
integer x = 2866
integer y = 168
integer width = 334
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Requested"
end type

event clicked;of_filter("R")
end event

type rb_a from radiobutton within w_batch_update_staff_cat
integer x = 2866
integer y = 108
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Active"
end type

event clicked;of_filter("A")
end event

type rb_b from radiobutton within w_batch_update_staff_cat
integer x = 2866
integer y = 48
integer width = 247
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Both"
boolean checked = true
end type

event clicked;of_filter("B")
end event

type cb_2 from commandbutton within w_batch_update_staff_cat
integer x = 3337
integer y = 24
integer width = 247
integer height = 84
integer taborder = 60
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

type cb_up from commandbutton within w_batch_update_staff_cat
integer x = 3337
integer y = 128
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Update"
end type

event clicked;date ld_from
date ld_to
integer i
integer rc
integer res
long p
long pcnt
long rcnt
pfc_cst_nv_data_entry_functions lnv_data_entry

//dw_browse.SetRedraw(False)

ld_from = date(em_from.text)
ld_to = date(em_to.text)
//messagebox("ld_from",em_from.text)

if  ii_facil < 1 then
	messagebox("User Select Error","You must select a facility to run this function.")
	return
end if

//if  ii_status < 1 then
//	messagebox("Missing Value","You must have a Status.")
//	return
//end if

if em_from.text = "" and  em_to.text = ""  and ii_status > 10 then
	res = messagebox("Missing Value","You must select a value to update")
	return
end if

//if rb_all.checked then
//	for p = 1 to dw_pracs.rowcount()
//		il_prac = dw_pracs.getitemnumber(p,"prac_id")
//		dw_pracs.scrolltorow(p)
//		dw_pracs.selectrow(0,false)
//		dw_pracs.selectrow(p,true)
//		of_retrieve_data("U")
//		rc = dw_browse.rowcount()
//		if rc < 1 then continue
//		pcnt++
//		for i = 1 to rc
//			if not em_from.text = "" then dw_browse.setitem(i,"start_date",ld_from)
//			if not em_to.text = "" then dw_browse.setitem(i,"end_date",ld_to)
//			if not il_status = 1 then dw_browse.setitem(i,"status_code",ii_status)
//			rcnt++
//		next
//		dw_browse.update()
//		commit using sqlca;
//	next
//single prac
rc = dw_1.rowcount()

if rc < 1 then return

lnv_data_entry = create pfc_cst_nv_data_entry_functions
//for i = 1 to dw_select.rowcount()
//	if upper(ls_valup) = "NULL" then setnull(is_fieldup)
//	ll_rec = dw_select.getitemnumber(i,"rec_id")
//	ll_pracid = dw_select.getitemnumber(i,"prac_id")
//	dw_audit.insertrow(i)
//	dw_audit.setitem(i,"rec_id",ll_rec)
//	dw_audit.setitem(i,"prac_id",ll_pracid)
//	
//	choose case ls_ftype3
//		case "I","N"
//			old_val = string(dw_select.getitemnumber(i,is_fieldup))
//			dw_select.setitem(i,is_fieldup,long(ls_valup))
//		case "D"
//			old_val = string(dw_select.getitemdatetime(i,is_fieldup))
//			
//		
//			//ls_valup = ls_valup + " 00:00:00"
//			dw_select.setitem(i,is_fieldup,ld_valup)
//		Case "C"
//			old_val = dw_select.getitemstring(i,is_fieldup)
//			
//			dw_select.setitem(i,is_fieldup,ls_valup)		
//	end choose
//	select max(seq_no) into :li_seq from sys_audit where rec_id = :ll_rec and field_id = :ll_field;
//	if li_seq < 1  or isnull(li_seq)then li_seq = 0
//	li_seq++
//	dw_audit.setitem(i,"seq_no",li_seq)
//	dw_audit.setitem(i,"table_id",ll_table)
//	dw_audit.setitem(i,"field_id",ll_field)
//	dw_audit.setitem(i,"old_value",old_val)
//	dw_audit.setitem(i,"new_value",ls_valup)
//	dw_audit.setitem(i,"user_id",gs_user_id)
//	dw_audit.setitem(i,"date_time_modified",datetime(today(),now()))
//	dw_audit.setitem(i,"audit_type","B")
//next

for i = 1 to rc	
	if dw_1.getitemnumber(i,"selected") = 1 then //update
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 02.28.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*		
		if not em_from.text = "" then dw_1.setitem(i,"from_date",ld_from)
		if not em_to.text = "" then dw_1.setitem(i,"to_date",ld_to)
		*/
		
		if isnull(trim(em_from.text)) = false and trim(em_from.text) <> '' then dw_1.setitem(i,"from_date",ld_from)
		if isnull(trim(em_to.text)) = false and trim(em_to.text) <> '' then dw_1.setitem(i,"to_date",ld_to)
		
		//---------------------------- APPEON END ----------------------------
		if ii_status < 20 then dw_1.setitem(i,"requested",ii_status)	
	end if
next

of_filter("A") //pre sys_audit filter
lnv_data_entry.of_field_audit( dw_1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 02.15.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.


gnv_appeondb.of_startqueue( )

//---------------------------- APPEON END ----------------------------

dw_1.update()
commit using sqlca;

dw_1.retrieve(il_pracs[],ii_facil)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<add> 02.15.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

of_filter("U")


//end if


end event

type em_to from editmask within w_batch_update_staff_cat
integer x = 1815
integer y = 108
integer width = 315
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type st_1a from statictext within w_batch_update_staff_cat
integer x = 987
integer y = 120
integer width = 247
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Start Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2a from statictext within w_batch_update_staff_cat
integer x = 1573
integer y = 120
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "End Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_from from editmask within w_batch_update_staff_cat
integer x = 1248
integer y = 108
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type dw_pracs from datawindow within w_batch_update_staff_cat
integer x = 23
integer y = 276
integer width = 841
integer height = 1516
integer taborder = 70
boolean titlebar = true
string title = "Practitoner List"
string dataobject = "d_practitioner_list"
boolean livescroll = true
end type

event clicked;//integer r
//
//r  = this.getclickedrow()
//if r < 1 then return
//
//this.setrow(r)
//this.selectrow(0,false)
//this.selectrow(r,true)
//
//il_prac = this.getitemnumber(r,"prac_id")
////dw_browse.settransobject(sqlca)
////dw_browse.retrieve(il_prac,ii_facil)
//of_retrieve_data(is_ret_type)
end event

event retrieveend;//debugbreak()
//if this.rowcount() > 0 then
//	//this.selectrow(0,false)
//	//this.selectrow(1,true)
//	il_prac = this.getitemnumber(1,"prac_id")
//	//of_retrieve_data("R")
//	//messagebox("rc",string(dw_browse.rowcount()))
//	dw_browse.setredraw(true)
//end if
end event

event rowfocuschanged;
//debugbreak()

end event

type dw_facility from datawindow within w_batch_update_staff_cat
integer x = 69
integer y = 112
integer width = 837
integer height = 84
integer taborder = 10
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)

dw_1.settransobject(sqlca)

dw_1.retrieve(il_pracs[],ii_facil)
of_filter("F")

cb_up.enabled = true
rb_a.enabled = true
rb_b.enabled = true
rb_r.enabled = true



end event

type gb_filt from groupbox within w_batch_update_staff_cat
integer x = 2839
integer y = 4
integer width = 402
integer height = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter"
end type

type gb_f from groupbox within w_batch_update_staff_cat
integer x = 32
integer y = 8
integer width = 914
integer height = 216
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

type gb_1 from groupbox within w_batch_update_staff_cat
integer x = 960
integer y = 8
integer width = 1851
integer height = 216
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update Settings"
end type

type ddlb_1 from dropdownlistbox within w_batch_update_staff_cat
integer x = 2213
integer y = 108
integer width = 571
integer height = 424
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Active","Requested","Inactive","Blank"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;

choose case index
	case 1 //active
		ii_status = 1
	case 2 
		ii_status = 2
	case 3
		ii_status = 0
	case 4
		ii_status = -1
end choose
end event

