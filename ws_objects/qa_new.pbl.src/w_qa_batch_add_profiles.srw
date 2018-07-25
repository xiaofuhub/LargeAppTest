$PBExportHeader$w_qa_batch_add_profiles.srw
forward
global type w_qa_batch_add_profiles from window
end type
type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_qa_batch_add_profiles
end type
type dw_exist from datawindow within w_qa_batch_add_profiles
end type
type dw_profile from u_dw within w_qa_batch_add_profiles
end type
type cb_close from commandbutton within w_qa_batch_add_profiles
end type
type cb_create from commandbutton within w_qa_batch_add_profiles
end type
type cb_view from commandbutton within w_qa_batch_add_profiles
end type
type cb_batch from commandbutton within w_qa_batch_add_profiles
end type
type cb_prac from commandbutton within w_qa_batch_add_profiles
end type
type st_pracs from statictext within w_qa_batch_add_profiles
end type
type dw_detail from datawindow within w_qa_batch_add_profiles
end type
type dw_metrics from datawindow within w_qa_batch_add_profiles
end type
type dw_hdr from datawindow within w_qa_batch_add_profiles
end type
type gb_prac from groupbox within w_qa_batch_add_profiles
end type
type gb_1 from groupbox within w_qa_batch_add_profiles
end type
type r_1 from rectangle within w_qa_batch_add_profiles
end type
type r_blue from rectangle within w_qa_batch_add_profiles
end type
end forward

global type w_qa_batch_add_profiles from window
integer width = 2464
integer height = 1048
boolean titlebar = true
string title = "Batch Add Profiles"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_org_facility_select dw_org_facility_select
dw_exist dw_exist
dw_profile dw_profile
cb_close cb_close
cb_create cb_create
cb_view cb_view
cb_batch cb_batch
cb_prac cb_prac
st_pracs st_pracs
dw_detail dw_detail
dw_metrics dw_metrics
dw_hdr dw_hdr
gb_prac gb_prac
gb_1 gb_1
r_1 r_1
r_blue r_blue
end type
global w_qa_batch_add_profiles w_qa_batch_add_profiles

type variables
gs_batch_search ist_search
Long il_prac_ids[] 
long il_facility_id
long il_prof
String is_prac_names[] 
long il_header_id
datetime id_from
datetime id_to
long il_reason
end variables

forward prototypes
public function integer of_add_measurements (long al_profile)
public function integer of_validation ()
end prototypes

public function integer of_add_measurements (long al_profile);//of_add_measurements( /*long al_profile */)
datastore lds_profile
integer ic
integer i
integer pc
integer li_find
integer li_new
long ll_item_id
long ll_id, ll_qa_metric_id
string ls_metric
datawindow ldw_detail

ldw_detail = dw_detail
//debugbreak()
select max(pd_qap_id) into :ll_id from pd_qa_profile_data;
if isnull(ll_id) then ll_id = 0

//lds_profile = create datastore
//
//lds_profile.dataobject = "d_get_qa_measurement"
ldw_detail.settransobject( sqlca)
//ic = lds_profile.retrieve(al_profile)
ic = dw_metrics.rowcount()

for i = 1 to ic
	ll_item_id = dw_metrics.getitemnumber(i,"profile_group_measurement_id")
	ls_metric = dw_metrics.getitemstring(i,"qa_metrics_indicator")
	ll_qa_metric_id = dw_metrics.getitemnumber(i,"qa_metric_id")
//	li_find = ldw_detail.find("pd_qa_profile_data_profile_measurement_id =" + string(ll_item_id),1,ldw_detail.rowcount())
//	if li_find = 0 then
		li_new = ldw_detail.insertrow(0)
		ll_id++
		ldw_detail.setitem(li_new,"pd_qa_profile_data_pd_qap_id",ll_id)  //unique value
		ldw_detail.setitem(li_new,"pd_qa_profile_data_profile_measurement_id",ll_item_id) //item
//		ldw_detail.setitem(li_new,"qa_measurement_new_qa_measurement_name",ls_metric) 
		ldw_detail.setitem(li_new,"qa_metric_id",ll_qa_metric_id) 
		ldw_detail.setitem(li_new,"pd_qa_profile_data_pd_qa_hdr_id", al_profile) //provider profile id
		
		//header value set in pfc_updateprep
//	end if	
next




return 1
end function

public function integer of_validation ();
//check for required data
if il_prof < 1 then
	messagebox("Batch Profiles","Please select the Profile")
	return -1
end if

if il_facility_id < 1 then
	messagebox("Batch Profiles","Please select the Facility")
	return -1
end if

id_from = dw_profile.getitemdatetime(1, "from_date")
if isnull( id_from) then
	messagebox("Batch Profiles","Please set the From Date")
	return -1
end if

id_to = dw_profile.getitemdatetime(1, "to_date")
if isnull(id_to ) then
	messagebox("Batch Profiles","Please set the To Date")
	return -1
end if

il_reason = dw_profile.getitemnumber(1, "reason") 
if isnull( il_reason ) then
	messagebox("Batch Profiles","Please set the Purpose")
	return -1
end if

return 1
end function

on w_qa_batch_add_profiles.create
this.dw_org_facility_select=create dw_org_facility_select
this.dw_exist=create dw_exist
this.dw_profile=create dw_profile
this.cb_close=create cb_close
this.cb_create=create cb_create
this.cb_view=create cb_view
this.cb_batch=create cb_batch
this.cb_prac=create cb_prac
this.st_pracs=create st_pracs
this.dw_detail=create dw_detail
this.dw_metrics=create dw_metrics
this.dw_hdr=create dw_hdr
this.gb_prac=create gb_prac
this.gb_1=create gb_1
this.r_1=create r_1
this.r_blue=create r_blue
this.Control[]={this.dw_org_facility_select,&
this.dw_exist,&
this.dw_profile,&
this.cb_close,&
this.cb_create,&
this.cb_view,&
this.cb_batch,&
this.cb_prac,&
this.st_pracs,&
this.dw_detail,&
this.dw_metrics,&
this.dw_hdr,&
this.gb_prac,&
this.gb_1,&
this.r_1,&
this.r_blue}
end on

on w_qa_batch_add_profiles.destroy
destroy(this.dw_org_facility_select)
destroy(this.dw_exist)
destroy(this.dw_profile)
destroy(this.cb_close)
destroy(this.cb_create)
destroy(this.cb_view)
destroy(this.cb_batch)
destroy(this.cb_prac)
destroy(this.st_pracs)
destroy(this.dw_detail)
destroy(this.dw_metrics)
destroy(this.dw_hdr)
destroy(this.gb_prac)
destroy(this.gb_1)
destroy(this.r_1)
destroy(this.r_blue)
end on

event open;//Start Code Change ----01.15.2015 #V14.2 maha - created

dw_profile.settransobject(sqlca)
dw_profile.insertrow(1)
end event

type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_qa_batch_add_profiles
integer x = 96
integer y = 56
integer width = 933
integer height = 80
integer taborder = 170
string dataobject = "d_org_facility_select_vertical_no_label"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;//This.Object.facilities_t.Visible = False
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 01.24.2006 By: Cao YongWang
//$<reason> Performance tuning
//$<modification> The following script is copied from the ancester object pfc_cst_u_org_facility_selector_vertical.
//$<modification> Uncheck the Extend Ancester Script item from PowerBuilder painter.
DataWindowChild dwchild

This.SetTransObject( SQLCA )
//This.InsertRow( 0 )
If This.RowCount() < 1 Then This.InsertRow(0) //alfee 11.24.2009

This.GetChild( "facility_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( gs_user_id )
//Write scripts to retrieve data from the cache instead of retrieve.
//If not isvalid(ids_facilitys) Then of_init_dddw()
//dwchild.reset()
//ids_facilitys.rowscopy(1, ids_facilitys.rowcount(),Primary!, dwchild , 1, Primary!)
//dwchild.InsertRow(1)
//dwchild.SetItem( 1, "facility_name", "All" )
//dwchild.SetItem( 1, "facility_id", 0 )

//This.SetItem( 1, "facility_id", 0 )
//IF IsNull(this.getItemNumber(1,"facility_id")) then This.SetItem( 1, "facility_id", 0 )	//long.zhang 09.26.2011 Department Secuirty and Profile Module - Bug id 2658
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;IF This.GetColumnName() = "facility_id" THEN	
	//il_facility_id = Integer( data )
	parent.il_facility_id = Integer( data ) //Add parent, by Appeon long.zhang 05.28.2015 (Batch Add Profiles and Batch Add Metrics (Harvard Vangaurd) Case #54892)
END IF
end event

type dw_exist from datawindow within w_qa_batch_add_profiles
integer x = 1815
integer y = 1068
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_pd_qa_header_for_batch"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_profile from u_dw within w_qa_batch_add_profiles
integer x = 64
integer y = 168
integer width = 2309
integer height = 384
integer taborder = 190
string dataobject = "d_pd_qa_header_for_batch"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;if dwo.name = "qa_profile_id" then
	il_prof = long(data)
	dw_metrics.retrieve(il_prof)
end if



end event

event constructor;call super::constructor;this.settransobject(sqlca)
this.of_setupdateable( true)
this.of_setlinkage( true)
//this.of_settransobject(sqlca)

this.of_SetRowManager(TRUE)
//this.inv_rowmanager.of_SetRestoreRow(TRUE)
//this.of_SetReqColumn(false)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)
this.ib_rmbmenu = true

this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("from_date",this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("to_date",this.iuo_calendar.DDLB)
end event

type cb_close from commandbutton within w_qa_batch_add_profiles
integer x = 2011
integer y = 28
integer width = 343
integer height = 92
integer taborder = 180
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

type cb_create from commandbutton within w_qa_batch_add_profiles
integer x = 1504
integer y = 28
integer width = 480
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "4 - Add Profiles"
end type

event clicked;long r
long pc
long ec
long ll_find
long ll_prac
long ll_rec
long ll_max
long cnt
integer li_plier
n_cst_datetime lnv


pc = upperbound(il_prac_ids)
if pc < 1 then
	messagebox("Batch Profiles","Please select Providers")
	return
end if

if of_validation() < 0 then 
	return
end if

r_blue.width = 10

dw_exist.settransobject(sqlca)
ec = dw_exist.retrieve( il_prac_ids, il_prof, id_from, id_to)

if ec < 0 then
	messagebox("Error getting existing data","Contact ISG support")
	return
end if

r_blue.width = 50
 
li_plier = 1900/pc


for r = 1 to pc
	dw_hdr.reset()
	dw_detail.reset()
	//check for existing 
	ll_prac = il_prac_ids[r]
	
	ll_find = dw_exist.find("prac_id = " + string(ll_prac),1, ec)
	
	if ll_find < 0 then
		messagebox("Error in Find of existing data","Contact ISG support")
		return
	elseif ll_find > 0 then
		continue
	end if	
	
	
	SELECT max(pd_qa_hdr.pd_qa_hdr_id) INTO :ll_max FROM pd_qa_hdr ;
	if isnull(ll_max) then ll_max = 0
	ll_max++
	il_header_id = ll_max
	
	
	dw_hdr.insertrow(1)
	dw_hdr.setitem(1,"qa_profile_id", il_prof)
	dw_hdr.setitem(1,"pd_qa_hdr_id", il_header_id)
	dw_hdr.setitem(1,"prac_id", ll_prac)
	dw_hdr.setitem(1,"facility_id", il_facility_id)
	dw_hdr.setitem(1,"from_date", id_from)
	dw_hdr.setitem(1,"to_date", id_to)
	dw_hdr.setitem(1,"reason",il_reason )
	
	of_add_measurements( il_header_id)
		
	dw_hdr.update()
	dw_detail.update()
	
	//increment meter...
	r_blue.width = r_blue.width + li_plier
//	lnv.of_wait(1)
	cnt++
next

r_blue.width = 3000

messagebox("Process completed","Profile added for " + string(cnt) + " provider(s).")
end event

type cb_view from commandbutton within w_qa_batch_add_profiles
integer x = 1902
integer y = 636
integer width = 448
integer height = 84
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Selected"
end type

event clicked;gs_batch_search ls_b



IF UpperBound( il_prac_ids ) > 0 THEN
	ls_b.li_prac_id[] = il_prac_ids[]
	openwithparm(w_selected_prac_list,ls_b)
END IF
end event

type cb_batch from commandbutton within w_qa_batch_add_profiles
integer x = 1445
integer y = 636
integer width = 448
integer height = 84
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Select"
end type

event clicked;openwithparm(w_batch_prac_select_new, "R" )

if message.stringparm = "Cancel" then return

ist_search = message.powerobjectparm
il_prac_ids[] = ist_search.li_prac_id[]
is_prac_names[] = ist_search.ls_name[]

st_pracs.Text = String( UpperBound( il_prac_ids[] ) ) + " Providers selected."

IF UpperBound( il_prac_ids ) > 0 THEN
	cb_create.Enabled = True
END IF

 

end event

type cb_prac from commandbutton within w_qa_batch_add_profiles
integer x = 951
integer y = 636
integer width = 485
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select Provider"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
long r
long rc
long i
long ic
gs_search lstr_search
gs_batch_search lst_batch

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF
debugbreak()
rc = UpperBound( il_prac_ids )
////ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )

lst_batch = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(lst_batch.li_prac_id[])
//maha app101305
for i = 1 to ic
	ll_prac_id = lst_batch.li_prac_id[i] //maha 091605
	for r = 1 to rc
		if il_prac_ids[r] = ll_prac_id then
			li_find = 1
			exit
		end if
	next
	IF li_find > 0 THEN
		//skip
	else
		rc++
		il_prac_ids[rc] = ll_prac_id
		//Start Code Change ---- 04.10.2006 #396 maha
		is_prac_names[rc] = lst_batch.ls_name[i]
		//End Code Change---04.10.2006
	END IF
next


st_pracs.Text = String( UpperBound( il_prac_ids[] ) ) + " Providers selected."

IF UpperBound( il_prac_ids ) > 0 THEN
	cb_create.Enabled = True
END IF

 

end event

type st_pracs from statictext within w_qa_batch_add_profiles
integer x = 105
integer y = 648
integer width = 777
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "No provider selected"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_qa_batch_add_profiles
integer x = 873
integer y = 1076
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_pd_qa_detail_existing_new"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.settransobject(sqlca)
end event

type dw_metrics from datawindow within w_qa_batch_add_profiles
integer x = 2693
integer y = 1052
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_get_qa_measurement"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_hdr from datawindow within w_qa_batch_add_profiles
integer x = 155
integer y = 1072
integer width = 686
integer height = 400
integer taborder = 10
string title = "none"
string dataobject = "d_pd_qa_header_for_batch"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type gb_prac from groupbox within w_qa_batch_add_profiles
integer x = 59
integer y = 592
integer width = 2295
integer height = 144
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "3 - Select Providers"
end type

type gb_1 from groupbox within w_qa_batch_add_profiles
integer x = 69
integer y = 8
integer width = 1015
integer height = 144
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "1 - Select Facility"
end type

type r_1 from rectangle within w_qa_batch_add_profiles
integer linethickness = 4
long fillcolor = 16777215
integer x = 178
integer y = 784
integer width = 2034
integer height = 84
end type

type r_blue from rectangle within w_qa_batch_add_profiles
integer linethickness = 4
long fillcolor = 16711680
integer x = 187
integer y = 796
integer width = 2002
integer height = 60
end type

