$PBExportHeader$u_tabpage_report_report.sru
forward
global type u_tabpage_report_report from u_tabpg
end type
type cb_print from commandbutton within u_tabpage_report_report
end type
type cbx_hide_banner from checkbox within u_tabpage_report_report
end type
type cb_8 from uo_cb_output within u_tabpage_report_report
end type
type ddlb_zoom from dropdownlistbox within u_tabpage_report_report
end type
type st_rec_cnt from statictext within u_tabpage_report_report
end type
type st_page from statictext within u_tabpage_report_report
end type
type cb_next_page from commandbutton within u_tabpage_report_report
end type
type cb_prior_page from commandbutton within u_tabpage_report_report
end type
type cb_7 from commandbutton within u_tabpage_report_report
end type
type cb_6 from commandbutton within u_tabpage_report_report
end type
type cb_5 from commandbutton within u_tabpage_report_report
end type
type cb_4 from commandbutton within u_tabpage_report_report
end type
type cb_3 from commandbutton within u_tabpage_report_report
end type
type cb_prac_filt from commandbutton within u_tabpage_report_report
end type
type cb_export from commandbutton within u_tabpage_report_report
end type
type cb_1 from commandbutton within u_tabpage_report_report
end type
type cb_sort from commandbutton within u_tabpage_report_report
end type
type cb_2 from commandbutton within u_tabpage_report_report
end type
type cbx_primary_onlyxxx from checkbox within u_tabpage_report_report
end type
type dw_report from u_dw within u_tabpage_report_report
end type
end forward

global type u_tabpage_report_report from u_tabpg
integer width = 4009
integer height = 2180
long backcolor = 33551856
string text = "Report"
string picturename = "RunReport!"
cb_print cb_print
cbx_hide_banner cbx_hide_banner
cb_8 cb_8
ddlb_zoom ddlb_zoom
st_rec_cnt st_rec_cnt
st_page st_page
cb_next_page cb_next_page
cb_prior_page cb_prior_page
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_prac_filt cb_prac_filt
cb_export cb_export
cb_1 cb_1
cb_sort cb_sort
cb_2 cb_2
cbx_primary_onlyxxx cbx_primary_onlyxxx
dw_report dw_report
end type
global u_tabpage_report_report u_tabpage_report_report

type variables


w_report iw_parent_window
string is_syntax //maha 08.04.2010 - for w_report_view_window

end variables

forward prototypes
public function integer of_hide_banner (boolean ab_hide)
public function boolean of_is_closewindow_allowed ()
end prototypes

public function integer of_hide_banner (boolean ab_hide);//Start Code Change ----11.05.2013 #V14 maha - function added

if ab_hide = true then
	dw_report.object.r_blue.visible = false
else
	dw_report.object.r_blue.visible = true
end if



return 1
end function

public function boolean of_is_closewindow_allowed ();//====================================================================
//$<Function>: of_is_closewindow_allowed
//$<Arguments>:
//$<Return>:  boolean
//$<Description>: Whether allowed to close window.
//$<Author>: (Appeon) long.zhang 04.26.2017 (Bug id 5617 - Cannot email from Standard Reports when using the Outlook email setting)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If dw_report.of_get_outputing_flag( ) Then
	Return False
Else
	Return True
End If
end function

on u_tabpage_report_report.create
int iCurrent
call super::create
this.cb_print=create cb_print
this.cbx_hide_banner=create cbx_hide_banner
this.cb_8=create cb_8
this.ddlb_zoom=create ddlb_zoom
this.st_rec_cnt=create st_rec_cnt
this.st_page=create st_page
this.cb_next_page=create cb_next_page
this.cb_prior_page=create cb_prior_page
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_prac_filt=create cb_prac_filt
this.cb_export=create cb_export
this.cb_1=create cb_1
this.cb_sort=create cb_sort
this.cb_2=create cb_2
this.cbx_primary_onlyxxx=create cbx_primary_onlyxxx
this.dw_report=create dw_report
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_print
this.Control[iCurrent+2]=this.cbx_hide_banner
this.Control[iCurrent+3]=this.cb_8
this.Control[iCurrent+4]=this.ddlb_zoom
this.Control[iCurrent+5]=this.st_rec_cnt
this.Control[iCurrent+6]=this.st_page
this.Control[iCurrent+7]=this.cb_next_page
this.Control[iCurrent+8]=this.cb_prior_page
this.Control[iCurrent+9]=this.cb_7
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.cb_3
this.Control[iCurrent+14]=this.cb_prac_filt
this.Control[iCurrent+15]=this.cb_export
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.cb_sort
this.Control[iCurrent+18]=this.cb_2
this.Control[iCurrent+19]=this.cbx_primary_onlyxxx
this.Control[iCurrent+20]=this.dw_report
end on

on u_tabpage_report_report.destroy
call super::destroy
destroy(this.cb_print)
destroy(this.cbx_hide_banner)
destroy(this.cb_8)
destroy(this.ddlb_zoom)
destroy(this.st_rec_cnt)
destroy(this.st_page)
destroy(this.cb_next_page)
destroy(this.cb_prior_page)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_prac_filt)
destroy(this.cb_export)
destroy(this.cb_1)
destroy(this.cb_sort)
destroy(this.cb_2)
destroy(this.cbx_primary_onlyxxx)
destroy(this.dw_report)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : constructor
//==================================================================================================================
//  Purpose   	:
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


this.of_setresize( true)

//Start Code By Jervis 11.08.2007
//Prevent set dw zoom
this.inv_resize.of_setdwzoom( false)
//End Code By Jervis 11.08.2007

this.of_getparentwindow( iw_parent_window)


end event

type cb_print from commandbutton within u_tabpage_report_report
integer x = 1966
integer y = 40
integer width = 421
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;//Start Code Change ----11.03.2017 #V154 maha -  corrected for Application error
//w_report.triggerevent("pfc_cst_print_report")
boolean lb_dialog = false

if gi_print_dialog = 1 then
	lb_dialog = true
end if

dw_report.of_print(true,lb_dialog)
//Start Code Change ----11.03.2017 
end event

type cbx_hide_banner from checkbox within u_tabpage_report_report
integer x = 3566
integer y = 56
integer width = 425
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hide Banner"
end type

event clicked;if this.checked then
	of_hide_banner(true)
else
	of_hide_banner(false)
end if
end event

type cb_8 from uo_cb_output within u_tabpage_report_report
integer x = 2391
integer y = 40
integer width = 416
integer height = 84
integer taborder = 20
end type

event constructor;call super::constructor;idw = dw_report
end event

event clicked;string ls_dwtype  //maha 11.30.2016

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'

//Start Code Change ----11.30.2016 #V153 maha - disable excel for the profile
ls_DwType = dw_report.describe("Datawindow.Processing")
choose case ls_DwType 
	case '0','1'
		//ok to save as excel
	case else
		NewMenu.m_options.m_saveasexcel.enabled = false	
end choose
//End Code Change ----11.30.2016

//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
gnv_app.of_popmenu(this,NewMenu.m_options)//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501


//this calls events in u_dw
//the save as pdf calls ...
end event

type ddlb_zoom from dropdownlistbox within u_tabpage_report_report
integer x = 3099
integer y = 40
integer width = 425
integer height = 512
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"100%","90%","80%","70%","60%","50%"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;dw_report.Modify("DataWindow.Zoom = " + MidA(ddlb_zoom.Text, 1, LenA(ddlb_zoom.Text) -1 ) )
end event

type st_rec_cnt from statictext within u_tabpage_report_report
integer x = 37
integer y = 2108
integer width = 567
integer height = 56
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
string text = "Record Count:"
boolean focusrectangle = false
end type

type st_page from statictext within u_tabpage_report_report
integer x = 2811
integer width = 279
integer height = 60
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
string text = "Select Page"
boolean focusrectangle = false
end type

type cb_next_page from commandbutton within u_tabpage_report_report
integer x = 2949
integer y = 60
integer width = 105
integer height = 60
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ">"
end type

event clicked;dw_report.ScrollNextPage ( )
end event

type cb_prior_page from commandbutton within u_tabpage_report_report
integer x = 2834
integer y = 60
integer width = 105
integer height = 60
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<"
end type

event clicked;dw_report.ScrollPriorPage ( )
end event

type cb_7 from commandbutton within u_tabpage_report_report
boolean visible = false
integer x = 1550
integer y = 40
integer width = 379
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Provider Filter"
end type

event clicked;long ll_batch_id
integer i
integer ic
long ll_pracs[]
long p
string ls_filt
string ls_pracs
integer test = 0


open(w_practitioner_filter_choice)
	
	if message.stringparm = "C" then  //cancel
		return -1
	elseif isnumber(message.stringparm) then //selcted batch
		ll_batch_id  = long(message.stringparm)
		n_ds lds_batch
		lds_batch = CREATE n_ds
		lds_batch.DataObject = "d_batch_items_list"
		lds_batch.of_SetTransObject( SQLCA )
		ic = lds_batch.retrieve(ll_batch_id) 
		for i = 1 to ic
			ll_pracs[i] = long(lds_batch.getitemnumber(i,"prac_id"))
		next
	elseif message.stringparm = "B" then //batch window
		gs_batch_search lst_search
		OpenWithParm( w_batch_prac_select_new , "R" )
		//Start Code Change ---- 03.30.2006 #367 maha
		if message.stringparm = "Cancel" then
			return -1
		end if
		//End Code Change---03.30.2006
		lst_search = message.powerobjectparm
		for i = 1 to upperbound(lst_search.li_prac_id[])
			p = lst_search.li_prac_id[i]
			//messagebox("",p)
			ll_pracs[i] = long(lst_search.li_prac_id[i])
		next
	elseif message.stringparm = "S" then //single
		gs_search lstr_search
		lstr_search.stran_transaction = SQLCA
		lstr_search.ls_open_for = "ACTIONITEMS"
		OpenWithParm( w_extended_search_new , lstr_search )
		IF Message.DoubleParm = -1 THEN 
			Return -1
		else
		ll_pracs[1] = long(Message.stringParm)
			//messagebox("",ls_pracids)
		end if
	end if
for p = 1 to upperbound(ll_pracs[])
	ls_pracs = ls_pracs + string(ll_pracs[p]) + ","
next

ls_pracs = MidA(ls_pracs,1,LenA(ls_pracs) - 1)
debugbreak()

for i = 1 to upperbound(ll_pracs[]) //trap created because if filters to no records will crash program  maha 100203
	test = dw_report.find("v_full_name_prac_id = " + string(ll_pracs[i]),1,dw_report.rowcount())
	//messagebox(string(i),string(test))
	if test > 1 then exit
next

if test < 1 then
	//ls_filt = "v_full_name_prac_id = 0"
	dw_report.reset()
else
	ls_filt = "v_full_name_prac_id in (" + ls_pracs + ")"
	dw_report.setfilter(ls_filt)
	dw_report.filter()
end if
//messagebox("filt",ls_filt)






end event

type cb_6 from commandbutton within u_tabpage_report_report
integer x = 1170
integer y = 40
integer width = 375
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;gnv_dw.of_SaveAs(dw_report,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
//For restore directory  Added by Nova 04.29.2008
ChangeDirectory(gs_current_path)

end event

type cb_5 from commandbutton within u_tabpage_report_report
integer x = 795
integer y = 40
integer width = 375
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;String ls_filter

SetNull( ls_filter )

dw_report.SetFilter( ls_filter )
dw_report.Filter()// < 0 then
//	messagebox("","Filter error")
//	return
//end if

 dw_report.Sort()

dw_report.groupcalc()
//dw_report.Event pfc_FilterDlg()
end event

type cb_4 from commandbutton within u_tabpage_report_report
integer x = 416
integer y = 40
integer width = 375
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;String ls_sort

SetNull( ls_sort )

dw_report.SetSort( ls_sort )

dw_report.Sort()

dw_report.groupcalc()

//dw_report.Event pfc_SortDlg()


end event

type cb_3 from commandbutton within u_tabpage_report_report
integer x = 37
integer y = 40
integer width = 375
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Syntax"
end type

event clicked;//messagebox("Report Sql Syntax",is_sql)

openwithparm(w_sql_msg,iw_parent_window.is_sql_mod)
end event

type cb_prac_filt from commandbutton within u_tabpage_report_report
integer x = 1550
integer y = 40
integer width = 411
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Provider Filter"
end type

event clicked;long ll_batch_id
integer i
integer ic
long ll_pracs[]
long p
string ls_filt
string ls_pracs
integer test = 0
gs_batch_search lst_search //maha 01.28.2015

//Start Code Change ----01.28.2015 #V14.2 maha - simplified code for new choice window
open(w_practitioner_filter_choice_new)

if message.stringparm = "C" then  //cancel
	return -1
else 
	lst_search = message.powerobjectparm
	ll_pracs[] = lst_search.li_prac_id
end if	
//End Code Change ----01.28.2015

for p = 1 to upperbound(ll_pracs[])
	ls_pracs = ls_pracs + string(ll_pracs[p]) + ","
next

ls_pracs = MidA(ls_pracs,1,LenA(ls_pracs) - 1)
debugbreak()

//Start Code Change ----10.15.2013 #V14 maha -removed trap as the reset causes the report to have to be rerun;  not longer seems to cause a crash (former pb bug?)
//for i = 1 to upperbound(ll_pracs[]) //trap created because if filters to no records will crash program  maha 100203
//	test = dw_report.find("v_full_name_prac_id = " + string(ll_pracs[i]),1,dw_report.rowcount())
//	//messagebox(string(i),string(test))
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 04.26.2006 By: Rodger Wu
//	//$<reason> Fix a defect.
//	/* if test > 1 then exit */
//	if test >= 1 then exit
//	//---------------------------- APPEON END ----------------------------
//next
//
//if test < 1 then
//	//ls_filt = "v_full_name_prac_id = 0"
//	dw_report.reset()
//else
	ls_filt = "v_full_name_prac_id in (" + ls_pracs + ")"
	dw_report.setfilter(ls_filt)
	dw_report.filter()
//end if
//messagebox("filt",ls_filt)
//Start Code Change ----10.15.2013

//Start Code Change ----10.21.2014 #V14.2 maha - resort and calc
dw_report.sort()
dw_report.groupcalc( )
//Start Code Change ----10.21.2014

st_rec_cnt.Text = "Record Count: " + String(dw_report.RowCount() )//(Appeon)Toney 11.19.2013 - V141 ISG-CLX,Fix history BugT111301




end event

type cb_export from commandbutton within u_tabpage_report_report
integer x = 1170
integer y = 40
integer width = 375
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-02 By: Rodger Wu (Contract)
//$<reason> Get Crosstab data embedded in composite report of contract.

/* dw_report.SaveAs( "", Text!, True ) */

DatawindowChild ldwc_detail
IF dw_report.DataObject = "d_rpt_ctx_analysis" THEN
	dw_report.GetChild( "dw_detail", ldwc_detail )
	ldwc_detail.SaveAs( "", Text!, True )
ELSE
	gnv_dw.of_SaveAs(dw_report,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
END IF

//For restore directory  Added by Nova 04.29.2008
ChangeDirectory(gs_current_path)
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from commandbutton within u_tabpage_report_report
integer x = 795
integer y = 40
integer width = 375
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;//String ls_filter
//
//SetNull( ls_filter )
//
//dw_report.SetFilter( ls_filter )
//dw_report.Filter()// < 0 then
////	messagebox("","Filter error")
////	return
////end if
//




String    ls_exclude[ ]

ls_exclude[1] = "compute_2"
ls_exclude[2] = "compute_1"

dw_report.inv_filter.of_SetExclude(ls_exclude)
dw_report.inv_filter.of_SetStyle (dw_report.inv_filter.EXTENDED)
dw_report.Event pfc_FilterDlg()
dw_report.Sort()
dw_report.groupcalc()
//-----Begin Commented by Nova 09.27.2008---------------
//fixed BugN092402
//if dw_report.dataobject="d_prf_master" then
//	if dw_report.rowcount()=1 then w_report.inv_reports.of_profile_report_v8( w_report.tab_rpt.tabpage_report.dw_report, w_report.il_facility_id, w_report.il_prac_id, w_report.il_profile_view_id,w_report.ib_peer_data, w_report.tab_rpt.tabpage_criteria.dw_profile_temp,w_report.il_screen_view_id  )
//end if
//-----End Commented -----------------------------------

st_rec_cnt.Text = "Record Count: " + String(dw_report.RowCount() )//(Appeon)Toney 11.19.2013 - V141 ISG-CLX,Fix history BugT111301
end event

type cb_sort from commandbutton within u_tabpage_report_report
integer x = 416
integer y = 40
integer width = 375
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;//String ls_sort
//
//SetNull( ls_sort )
//
//dw_report.SetSort( ls_sort )
//
//dw_report.Sort()
//
//dw_report.groupcalc()
dw_report.inv_sort.of_setstyle(dw_report.inv_sort.dragdrop  )

dw_report.Event pfc_SortDlg()

//-----Begin Commented by Nova 09.27.2008---------------
//fixed BugN092402
//if dw_report.dataobject="d_prf_master" then
//	w_report.inv_reports.of_profile_report_v8( w_report.tab_rpt.tabpage_report.dw_report, w_report.il_facility_id, w_report.il_prac_id, w_report.il_profile_view_id,w_report.ib_peer_data, w_report.tab_rpt.tabpage_criteria.dw_profile_temp,w_report.il_screen_view_id  )
//end if
//-----End Commented -----------------------------------

end event

type cb_2 from commandbutton within u_tabpage_report_report
integer x = 37
integer y = 40
integer width = 375
integer height = 84
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Syntax"
end type

event clicked;//messagebox("Report Sql Syntax",is_sql)

 //Start Code Change ----08.04.2010 #V10 maha - changed to instance variable of this object
//openwithparm(w_sql_msg,iw_parent_window.is_sql_mod)

 if len(is_syntax) = 0 or isnull(is_syntax) then
	is_syntax = dw_report.GetSQLSelect()
end if
 
openwithparm(w_sql_msg,is_syntax)

 //End Code Change ----08.04.2010 #V10
end event

type cbx_primary_onlyxxx from checkbox within u_tabpage_report_report
boolean visible = false
integer x = 1975
integer y = 2100
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Use Primary Department Only"
end type

event clicked;if this.checked = true then 
	iw_parent_window.ii_prime_dept_only = 1
else
	iw_parent_window.ii_prime_dept_only = 0
end if

//messagebox("ii_prime_dept_only",ii_prime_dept_only)
end event

type dw_report from u_dw within u_tabpage_report_report
event ue_mail_current ( )
integer y = 144
integer width = 4005
integer height = 1948
integer taborder = 10
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event ue_mail_current();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-09 By: Scofield
//$<Reason> if save to pdf is failed,then don't send Email

long	ll_Rtn

ll_Rtn = Super::EVENT ue_save_pdf_for_mailing( )
if ll_Rtn <> 0 then return
//---------------------------- APPEON END ----------------------------

//Start Code Change ----10.09.2008 #V85 maha -  readded option to use outlook email
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
//if of_get_app_setting("set_56","I") = 1 then
	Super::EVENT ue_mail_bak('Report','' )
else
	Super::EVENT ue_mail('Report','' )
end if
//End Code Change---10.09.2008



end event

event constructor;

This.of_Setupdateable(False )

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(2)
This.inv_Filter.of_SetColumnDisplayNameStyle( 2 )

This.inv_sort.of_SetColumnHeader(True)

This.inv_sort.of_SetVisibleOnly( False )


end event

event pfc_retrieve;call super::pfc_retrieve;
IF This.DataObject = "d_rpt_expiring_credentials" THEN
	Return This.Retrieve( )
END IF
IF This.DataObject = "d_rpt_expiring_credentials_detail" THEN
	Return This.Retrieve( )
END IF
IF This.DataObject = "d_prf_master" THEN
	This.SetTransObject( sqlca )
//	Return This.Retrieve(4, 1175 )
END IF


Return 0
end event

