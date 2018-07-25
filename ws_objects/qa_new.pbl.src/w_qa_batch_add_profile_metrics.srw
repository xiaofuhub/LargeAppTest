$PBExportHeader$w_qa_batch_add_profile_metrics.srw
forward
global type w_qa_batch_add_profile_metrics from window
end type
type dw_add from datawindow within w_qa_batch_add_profile_metrics
end type
type st_match from statictext within w_qa_batch_add_profile_metrics
end type
type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_qa_batch_add_profile_metrics
end type
type dw_exist from datawindow within w_qa_batch_add_profile_metrics
end type
type dw_profile from u_dw within w_qa_batch_add_profile_metrics
end type
type cb_close from commandbutton within w_qa_batch_add_profile_metrics
end type
type cb_create from commandbutton within w_qa_batch_add_profile_metrics
end type
type cb_view from commandbutton within w_qa_batch_add_profile_metrics
end type
type cb_batch from commandbutton within w_qa_batch_add_profile_metrics
end type
type cb_prac from commandbutton within w_qa_batch_add_profile_metrics
end type
type st_pracs from statictext within w_qa_batch_add_profile_metrics
end type
type dw_detail from datawindow within w_qa_batch_add_profile_metrics
end type
type dw_metrics from datawindow within w_qa_batch_add_profile_metrics
end type
type dw_prof_met from datawindow within w_qa_batch_add_profile_metrics
end type
type gb_prac from groupbox within w_qa_batch_add_profile_metrics
end type
type gb_1 from groupbox within w_qa_batch_add_profile_metrics
end type
type r_1 from rectangle within w_qa_batch_add_profile_metrics
end type
type r_blue from rectangle within w_qa_batch_add_profile_metrics
end type
end forward

global type w_qa_batch_add_profile_metrics from window
integer width = 2199
integer height = 2176
boolean titlebar = true
string title = "Batch Add Profile Metrics"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_add dw_add
st_match st_match
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
dw_prof_met dw_prof_met
gb_prac gb_prac
gb_1 gb_1
r_1 r_1
r_blue r_blue
end type
global w_qa_batch_add_profile_metrics w_qa_batch_add_profile_metrics

type variables
gs_batch_search ist_search
Long il_prac_ids[] 
long il_facility_id[]
long il_prof
String is_prac_names[] 
long il_header_id
datetime id_from
datetime id_to
long il_reason
end variables

forward prototypes
public function integer of_validation ()
end prototypes

public function integer of_validation ();dw_profile.accepttext()
//check for required data
if il_prof < 1 then
	messagebox("Batch Profiles","Please select the Profile")
	return -1
end if

if il_facility_id[1] < 1 then
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

//il_reason = dw_profile.getitemnumber(1, "reason") 
//if isnull( il_reason ) then
//	messagebox("Batch Profiles","Please set the Purpose")
//	return -1
//end if

return 1
end function

on w_qa_batch_add_profile_metrics.create
this.dw_add=create dw_add
this.st_match=create st_match
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
this.dw_prof_met=create dw_prof_met
this.gb_prac=create gb_prac
this.gb_1=create gb_1
this.r_1=create r_1
this.r_blue=create r_blue
this.Control[]={this.dw_add,&
this.st_match,&
this.dw_org_facility_select,&
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
this.dw_prof_met,&
this.gb_prac,&
this.gb_1,&
this.r_1,&
this.r_blue}
end on

on w_qa_batch_add_profile_metrics.destroy
destroy(this.dw_add)
destroy(this.st_match)
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
destroy(this.dw_prof_met)
destroy(this.gb_prac)
destroy(this.gb_1)
destroy(this.r_1)
destroy(this.r_blue)
end on

event open;//Start Code Change ----01.22.2015 #V14.2 maha - created

dw_profile.settransobject(sqlca)
dw_profile.insertrow(1)
end event

type dw_add from datawindow within w_qa_batch_add_profile_metrics
integer x = 2533
integer y = 1132
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_pd_qa_existing_metrics"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_match from statictext within w_qa_batch_add_profile_metrics
integer x = 142
integer y = 1988
integer width = 800
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type dw_org_facility_select from pfc_cst_u_org_facility_selector_vertical within w_qa_batch_add_profile_metrics
integer x = 265
integer y = 560
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
	//il_facility_id[1] = Integer( data )
	parent.il_facility_id[1] = Integer( data ) //Add parent, by Appeon long.zhang 05.28.2015 (Batch Add Profiles and Batch Add Metrics (Harvard Vangaurd) Case #54892)
END IF
end event

type dw_exist from datawindow within w_qa_batch_add_profile_metrics
integer x = 2770
integer y = 636
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_pd_qa_header_for_metric_batch"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_profile from u_dw within w_qa_batch_add_profile_metrics
integer x = 224
integer y = 128
integer width = 1573
integer height = 360
integer taborder = 190
string dataobject = "d_pd_qa_header_for_batch_metrics"
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

type cb_close from commandbutton within w_qa_batch_add_profile_metrics
integer x = 1778
integer y = 12
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

type cb_create from commandbutton within w_qa_batch_add_profile_metrics
integer x = 1632
integer y = 548
integer width = 485
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "4 - Add Metrics"
end type

event clicked;long r
long m
long p
long pc
long ec
long ll_find
long ll_prac
long ll_exist_prof[]
long ll_max
long cnt
long nr
integer li_plier
long ll_met[]
n_cst_datetime lnv

dw_detail.reset()
dw_add.reset()

if of_validation() < 0 then 
	return
end if

dw_add.settransobject(sqlca)
r_blue.width = 10

//get list of selected metrics
for r = 1 to dw_metrics.rowcount()
	if dw_metrics.getitemnumber(r,"selected") = 1 then
		ll_met[upperbound(ll_met) + 1] = dw_metrics. getitemnumber(r,"profile_group_measurement_id")
	end if
next

if upperbound(ll_met) = 0 then
	messagebox("No Metrics selected","Please select metrics to add.")
	return
end if

//get list of connected profiles based on settings

dw_exist.settransobject(sqlca)
ec = dw_exist.retrieve( il_facility_id[], il_prof, id_from, id_to)  //change prac to facility will only be one facility
st_match.text = string(ec) + " Profiles matched"


if ec < 0 then
	messagebox("Error getting existing data","Contact ISG support")
	return
elseif ec = 0 then
	messagebox("Metrics Batch Add", "No Profiles found that match the selected criteria")
	return
end if

li_plier = 1900/ec

for r = 1 to ec
	ll_exist_prof[r] = dw_exist.getitemnumber(r,"pd_qa_hdr_id")
next
//debugbreak()
//get existing metrics for the existing profiles
dw_detail.settransobject(sqlca)
//---------Begin Modified by (Appeon)Stephen 07.31.2015 for Issue Expalnation from 7/29 meeting - Ticket 55928--------
//ec = dw_detail.retrieve(ll_exist_prof[], ll_met)
ec = dw_detail.retrieve(ll_met,il_prof)
//---------End Modfiied ------------------------------------------------------

if ec < 0 then
	messagebox("Error getting existing metric data","Contact ISG support")
	return
end if

//messagebox("","Pause")


r_blue.width = 50
 
for p = 1 to upperbound(ll_exist_prof)
	for m = 1 to upperbound(ll_met)
		ll_find = dw_detail.find("pd_qa_hdr_id = " + string(ll_exist_prof[p]) + " and profile_measurement_id =" + string(ll_met[m] ),1, ec)
		if ll_find < 0 then
			messagebox("Error in Find of existing metric","Contact ISG support")
			return
		elseif ll_find > 0 then
			continue
		end if	

		//if not found - add
		nr = dw_add.insertrow(0)
		dw_add.setitem(nr, "pd_qa_hdr_id", ll_exist_prof[p])
		dw_add.setitem(nr, "profile_measurement_id", ll_met[m])
		cnt++
	next
	//increment meter...
	r_blue.width = r_blue.width + li_plier
next

//get primary key value
SELECT max(pd_qap_id) INTO :ll_max FROM pd_qa_profile_data ;
if isnull(ll_max) then ll_max = 0

for r = 1 to dw_add.rowcount()
	//if isnull(dw_.getitemnumber(r, "pd_qa_profile_data_pd_qap_id")) then
		ll_max++
		dw_add.setitem(r,"pd_qa_profile_data_pd_qap_id", ll_max)
	//end if

next



r = dw_add.update()

if r < 1 then
	messagebox("","Save Failed")
end if
	
//	lnv.of_wait(1)

r_blue.width = 2000

messagebox("Process completed",string(cnt) + " metric record(s) added.")
end event

type cb_view from commandbutton within w_qa_batch_add_profile_metrics
integer x = 1879
integer y = 2236
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

type cb_batch from commandbutton within w_qa_batch_add_profile_metrics
integer x = 1422
integer y = 2236
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

type cb_prac from commandbutton within w_qa_batch_add_profile_metrics
integer x = 928
integer y = 2236
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

type st_pracs from statictext within w_qa_batch_add_profile_metrics
integer x = 133
integer y = 2248
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
long backcolor = 32233416
boolean enabled = false
string text = "No provider selected"
boolean focusrectangle = false
end type

type dw_detail from datawindow within w_qa_batch_add_profile_metrics
integer x = 2533
integer y = 712
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "d_pd_qa_existing_metrics"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;this.settransobject(sqlca)
end event

type dw_metrics from datawindow within w_qa_batch_add_profile_metrics
integer x = 288
integer y = 748
integer width = 1563
integer height = 1056
integer taborder = 10
string title = "none"
string dataobject = "d_qa_measurement_batch_metric"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_prof_met from datawindow within w_qa_batch_add_profile_metrics
integer x = 2793
integer y = 1092
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

type gb_prac from groupbox within w_qa_batch_add_profile_metrics
integer x = 238
integer y = 688
integer width = 1678
integer height = 1152
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "3 - Select Metrics to Add"
end type

type gb_1 from groupbox within w_qa_batch_add_profile_metrics
integer x = 238
integer y = 512
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
string text = "2 - Select Facility Filter"
end type

type r_1 from rectangle within w_qa_batch_add_profile_metrics
integer linethickness = 4
long fillcolor = 16777215
integer x = 96
integer y = 1880
integer width = 2030
integer height = 84
end type

type r_blue from rectangle within w_qa_batch_add_profile_metrics
integer linethickness = 4
long fillcolor = 16711680
integer x = 105
integer y = 1892
integer width = 2002
integer height = 60
end type

