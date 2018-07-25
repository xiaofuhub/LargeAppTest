$PBExportHeader$u_tabpage_report_criteria.sru
forward
global type u_tabpage_report_criteria from u_tabpg
end type
type st_rpt_cnt from statictext within u_tabpage_report_criteria
end type
type st_notfound from statictext within u_tabpage_report_criteria
end type
type cb_1 from commandbutton within u_tabpage_report_criteria
end type
type sle_search from singlelineedit within u_tabpage_report_criteria
end type
type st_status from statictext within u_tabpage_report_criteria
end type
type ddlb_status from dropdownlistbox within u_tabpage_report_criteria
end type
type st_batch from statictext within u_tabpage_report_criteria
end type
type cbx_peer from checkbox within u_tabpage_report_criteria
end type
type dw_select_report from u_dw within u_tabpage_report_criteria
end type
type cb_search from commandbutton within u_tabpage_report_criteria
end type
type cb_batch from commandbutton within u_tabpage_report_criteria
end type
type cb_prior from u_cb within u_tabpage_report_criteria
end type
type cb_next from u_cb within u_tabpage_report_criteria
end type
type dw_criteria from u_dw within u_tabpage_report_criteria
end type
type dw_wizard_seq from u_dw within u_tabpage_report_criteria
end type
type dw_criteria_box from u_dw within u_tabpage_report_criteria
end type
type cbx_primary_only from checkbox within u_tabpage_report_criteria
end type
type dw_profile_temp from u_dw within u_tabpage_report_criteria
end type
type st_help_text from statictext within u_tabpage_report_criteria
end type
end forward

global type u_tabpage_report_criteria from u_tabpg
integer width = 3547
integer height = 2196
long backcolor = 33551856
string text = "Select Report / Criteria"
string picturename = "CheckStatus!"
st_rpt_cnt st_rpt_cnt
st_notfound st_notfound
cb_1 cb_1
sle_search sle_search
st_status st_status
ddlb_status ddlb_status
st_batch st_batch
cbx_peer cbx_peer
dw_select_report dw_select_report
cb_search cb_search
cb_batch cb_batch
cb_prior cb_prior
cb_next cb_next
dw_criteria dw_criteria
dw_wizard_seq dw_wizard_seq
dw_criteria_box dw_criteria_box
cbx_primary_only cbx_primary_only
dw_profile_temp dw_profile_temp
st_help_text st_help_text
end type
global u_tabpage_report_criteria u_tabpage_report_criteria

type variables
w_report iw_parent_window



end variables

on u_tabpage_report_criteria.create
int iCurrent
call super::create
this.st_rpt_cnt=create st_rpt_cnt
this.st_notfound=create st_notfound
this.cb_1=create cb_1
this.sle_search=create sle_search
this.st_status=create st_status
this.ddlb_status=create ddlb_status
this.st_batch=create st_batch
this.cbx_peer=create cbx_peer
this.dw_select_report=create dw_select_report
this.cb_search=create cb_search
this.cb_batch=create cb_batch
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.dw_criteria=create dw_criteria
this.dw_wizard_seq=create dw_wizard_seq
this.dw_criteria_box=create dw_criteria_box
this.cbx_primary_only=create cbx_primary_only
this.dw_profile_temp=create dw_profile_temp
this.st_help_text=create st_help_text
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_rpt_cnt
this.Control[iCurrent+2]=this.st_notfound
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.sle_search
this.Control[iCurrent+5]=this.st_status
this.Control[iCurrent+6]=this.ddlb_status
this.Control[iCurrent+7]=this.st_batch
this.Control[iCurrent+8]=this.cbx_peer
this.Control[iCurrent+9]=this.dw_select_report
this.Control[iCurrent+10]=this.cb_search
this.Control[iCurrent+11]=this.cb_batch
this.Control[iCurrent+12]=this.cb_prior
this.Control[iCurrent+13]=this.cb_next
this.Control[iCurrent+14]=this.dw_criteria
this.Control[iCurrent+15]=this.dw_wizard_seq
this.Control[iCurrent+16]=this.dw_criteria_box
this.Control[iCurrent+17]=this.cbx_primary_only
this.Control[iCurrent+18]=this.dw_profile_temp
this.Control[iCurrent+19]=this.st_help_text
end on

on u_tabpage_report_criteria.destroy
call super::destroy
destroy(this.st_rpt_cnt)
destroy(this.st_notfound)
destroy(this.cb_1)
destroy(this.sle_search)
destroy(this.st_status)
destroy(this.ddlb_status)
destroy(this.st_batch)
destroy(this.cbx_peer)
destroy(this.dw_select_report)
destroy(this.cb_search)
destroy(this.cb_batch)
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.dw_criteria)
destroy(this.dw_wizard_seq)
destroy(this.dw_criteria_box)
destroy(this.cbx_primary_only)
destroy(this.dw_profile_temp)
destroy(this.st_help_text)
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

this.inv_resize.of_UnRegister(sle_search)			//Added by Scofield on 2008-11-25
this.inv_resize.of_UnRegister(cb_1)					//Added by Scofield on 2008-11-25
this.inv_resize.of_UnRegister(st_notfound)		//Added by Scofield on 2008-11-25

this.of_setresize( true)

//Start Code By Jervis 11.08.2007
//Prevent set dw zoom
this.inv_resize.of_setdwzoom( false)
//End Code By Jervis 11.08.2007

this.of_getparentwindow( iw_parent_window)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-11-17 By: Scofield
//$<Reason> Do not have the search visible if CTX only system.

if gb_Contract_Version then
	sle_Search.Visible = false
	cb_1.Visible = false
	st_notfound.Visible = false
	dw_select_report.Modify("DataWindow.Header.Height='108'")
end if
//---------------------------- APPEON END ----------------------------

end event

type st_rpt_cnt from statictext within u_tabpage_report_criteria
integer x = 23
integer y = 2248
integer width = 128
integer height = 64
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

type st_notfound from statictext within u_tabpage_report_criteria
boolean visible = false
integer x = 1093
integer y = 128
integer width = 270
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 16777215
string text = "Not found"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within u_tabpage_report_criteria
integer x = 855
integer y = 112
integer width = 229
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Search"
end type

event clicked;string ls_search
integer li_found

ls_search = upper(sle_search.text)

li_found = dw_select_report.find( "upper(report_name) like '%" + ls_search + "%'", dw_select_report.getrow() + 1,dw_select_report.rowcount())

if li_found < 0 then
	messagebox("Find failure","Incorrect syntax, contract ISG support")
elseif li_found > 0 then
	dw_select_report.scrolltorow(li_found)
	dw_select_report.selectrow(0,false)
	dw_select_report.selectrow(li_found,true)
	dw_select_report.setrow(li_found)
else // 0
	st_notfound.visible = true
end if
	

end event

type sle_search from singlelineedit within u_tabpage_report_criteria
integer x = 41
integer y = 116
integer width = 795
integer height = 80
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type st_status from statictext within u_tabpage_report_criteria
boolean visible = false
integer x = 2757
integer y = 240
integer width = 631
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = " Select Status"
boolean focusrectangle = false
end type

type ddlb_status from dropdownlistbox within u_tabpage_report_criteria
boolean visible = false
integer x = 2405
integer y = 240
integer width = 462
integer height = 352
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
integer limit = 3
string item[] = {"Active","Requested","Inactive"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
	case 1 //active
		iw_parent_window.ii_staff_cat_status = 1
	case 2 //history
		iw_parent_window.ii_staff_cat_status = 0
	case 3 //requested
		iw_parent_window.ii_staff_cat_status = 2
end choose
end event

type st_batch from statictext within u_tabpage_report_criteria
boolean visible = false
integer x = 1568
integer y = 412
integer width = 1911
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
boolean enabled = false
string text = "Because you are batch printing this print job will go directly to the printer."
boolean focusrectangle = false
end type

type cbx_peer from checkbox within u_tabpage_report_criteria
boolean visible = false
integer x = 1600
integer y = 236
integer width = 745
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
string text = "Include Peer Review Data"
end type

type dw_select_report from u_dw within u_tabpage_report_criteria
event pfc_after_select ( )
integer width = 1527
integer height = 2188
integer taborder = 10
boolean titlebar = true
string title = "Select Report"
string dataobject = "d_report_list"
end type

event clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF

This.SelectRow( 0, False )
This.SelectRow( li_row, True )
This.ScrollToRow( li_row )
This.SetRow( li_row )

end event

event constructor;integer i
integer priv
integer meet
integer appmap
integer peer
integer ctx
integer cnt
string s
This.of_Setupdateable(False )
This.of_SetTransObject( SQLCA)


//---------Begin Modified by (Appeon)Harry 11.20.2013 for V141 for BugH111901 of IntelliCredApp V14.1 History Issues 2--------
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.18.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
//$<reason> If the Product Setting is IntelliContract then filter the 
//$<reason> report list by looking for an X in the r_type field.  
IF gb_contract_version THEN
	this.SetFilter("Lower(r_type) = 'x'")
	This.Retrieve()

	This.SelectRow( 1, True )
	This.ScrollToRow( 1 )
	This.SetRow( 1 )
	
	RETURN
END IF
//---------------------------- APPEON END ----------------------------

 This.Retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.13.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*select set_34,set_priv,set_meetings,set_iapps,set_peer into :i,:priv,:meet,:appmap,:peer from icred_settings;*/
//Start Code Change ----11.02.2010 #V10 maha - rebuilt filter code based on program setting
//i = Integer( gnv_data.of_GetItem( "icred_settings", "set_34", False ))
i = Integer( gnv_data.of_GetItem( "icred_settings", "set_9", False ))
priv = Integer( gnv_data.of_GetItem( "icred_settings", "set_priv", False ))
meet = Integer( gnv_data.of_GetItem( "icred_settings", "set_meetings", False ))
appmap = Integer( gnv_data.of_GetItem( "icred_settings", "set_iapps", False ))
peer = Integer( gnv_data.of_GetItem( "icred_settings", "set_peer", False ))
ctx = Integer( gnv_data.of_GetItem( "icred_settings", "set_cont", False ))
//---------------------------- APPEON END ----------------------------

//if i > 0 then  //maha 100404 filtering reports based on program settings
s = "('D'"

choose case i
	case 0 //cred
		 s = s + ",'C','B','M'"
		if appmap = 1 then s = s + ",'A'"
	case 1 //app
		 s = s + ",'A','B','M'"
	case 2 //se
		 s = s + ",'C'"
	case 3 //credapp
		 s = s + ",'C','B','A','M'"
	case 4 //ctx
		s = s + ",'X'"
	case 5 //SK
		 s = s + ",'A','B'"
end choose
		
//	if i = 1 then
//		s = "('D','C','B'"  //C= intellicred D=database  //Start Code Change ---- 02.06.2007 #V7 maha
//	elseif i = 2 then
//		s = "('D','B'"	
//	end if
	
if i <> 4 then //if not contracts
	if priv = 1 then s = s + ",'P'"
//	if meet = 1 then s = s + ",'M'"
//	if appmap = 1 then s = s + ",'A'"
	if peer = 1 then s = s + ",'R'"
	if ctx  = 1 then s = s + ",'X'"
end if
		
	s = s + ")"
//End Code Change ----11.02.2010	
	//MESSAGEBOX("S",s)
	this.setfilter("upper(r_type) in " + s)
	this.filter()
	
	cnt = this.rowcount()
	st_rpt_cnt.text = string(cnt)  //Start Code Change ----09.24.2013 #V14 maha
//end if

This.SelectRow( 1, True )
This.ScrollToRow( 1 )
This.SetRow( 1 )
*/
pfc_cst_u_reports inv_rports
inv_rports = Create pfc_cst_u_reports
s = inv_rports.of_get_report_filter( )

This.Retrieve()
this.SetFilter(s)
this.filter()
This.SelectRow( 1, True )
This.ScrollToRow( 1 )
This.SetRow( 1 )

cnt = this.rowcount()
st_rpt_cnt.text = string(cnt)  //Start Code Change ----09.24.2013 #V14 maha

if isvalid(inv_rports) then destroy inv_rports
//---------End Modfiied ------------------------------------------------------
this.event rowfocuschanged(1) //add Michael 04.16.2012 Alpha id 2984


end event

event rowfocuschanged;call super::rowfocuschanged;String ls_report_dw
String ls_graph_dw
String ls_wizard_dw
String ls_export
Integer li_report_id
Integer li_dummy_array[]
integer li_save_count  //maha 12.12.2017

if CurrentRow < 1 then Return //evan 12.24.2010

iw_parent_window.tab_rpt.tabpage_report.Enabled = False
iw_parent_window.tab_rpt.tabpage_graph.Enabled = False

st_notfound.visible = false  //Start Code Change ----09.11.2008 #V85 maha - reset search not found
st_batch.Visible = False

iw_parent_window.il_current_wizard_step = 0
iw_parent_window.il_wizard_step_cnt = 0
iw_parent_window.is_provider_type = "ALL"
iw_parent_window.is_specialties = "ALL"
iw_parent_window.is_address_types = "ALL"
iw_parent_window.is_department = "ALL"
iw_parent_window.is_group_id = "ALL"
iw_parent_window.is_net_dev_types = "ALL"
iw_parent_window.ii_prac_cnt = 0
iw_parent_window.is_facility_name = "ALL"
iw_parent_window.is_appmnt_status = ""
iw_parent_window.ii_appt_stat[] = li_dummy_array[]
iw_parent_window.ii_using_export = 0  //maha 021803
iw_parent_window.ii_export_id  = 0  //maha 021803
iw_parent_window.is_contracts = "ALL"
iw_parent_window.is_priv_stat = ""
iw_parent_window.is_division = "ALL"
iw_parent_window.is_section = "ALL"
iw_parent_window.is_staff_cat = "ALL"
iw_parent_window.is_assn_user = "ALL"
iw_parent_window.ii_staff_cat_status = -1
iw_parent_window.is_affil_status = "ALL"
iw_parent_window.ii_prime_dept_only = 0 //maha 111303
iw_parent_window.is_sex = "ALL"
iw_parent_window.il_sex = 0
iw_parent_window.ii_prov_status = 1
iw_parent_window.ib_oppe = false  //Start Code Change ----07.17.2009 #V92 maha - oppe reports
iw_parent_window.il_num_days = 0   //Start Code Change ----09.01.2015 #V15 maha
iw_parent_window.is_health_type = "ALL"
iw_parent_window.is_cpr_type = "ALL"  //Start Code Change ----10.26.2016 #V153 maha
iw_parent_window.is_verif_type = "ALL" //Start Code Change ----10.26.2016 #V153 maha
iw_parent_window.is_fee_type = "ALL" //Start Code Change ----10.26.2016 #V153 maha
iw_parent_window.is_verif_entity = "ALL"  //maha 10.26.2016

iw_parent_window.il_facility_ids_all[] = li_dummy_array[]
SetNull( iw_parent_window.il_facility_id )
SetNull( iw_parent_window.il_profile_view_id )
SetNull( iw_parent_window.il_prac_id )
SetNull( iw_parent_window.id_from )
SetNull( iw_parent_window.id_to )
SetNull( iw_parent_window.id_appt_from )
SetNull( iw_parent_window.id_appt_to )
SetNull( iw_parent_window.id_meet_from )
SetNull( iw_parent_window.id_meet_to )
SetNull(iw_parent_window.ii_multi_grp_id)
SetNull(iw_parent_window.il_grp_loc)
SetNull(iw_parent_window.id_prov_from )
SetNull(iw_parent_window.id_prov_to )
iw_parent_window.il_prac_ids[] = li_dummy_array[]

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-01 By: Rodger Wu (Contract)
//$<reason> Modification for contract report.
String ls_dummy[]
Long ll_dummy[]

iw_parent_window.ii_ctx_grouping = 1
iw_parent_window.is_ctx_status = ''
iw_parent_window.is_ctx_owner = ''
iw_parent_window.is_ctx_category = ''
iw_parent_window.is_ctx_service = ''
iw_parent_window.il_ctxid = ll_dummy
iw_parent_window.is_cptcode = ls_dummy
iw_parent_window.is_ctx_data_contract = ''
iw_parent_window.is_ctx_data_cptcode = ''
iw_parent_window.ii_ctx_days = 0
//---------------------------- APPEON END ----------------------------

IF dw_criteria.DataObject = "d_crit_date_range" THEN
	dw_criteria.iuo_calendar.of_UnRegister()
END IF
IF dw_criteria.DataObject = "d_crit_appt_date_range" THEN
	dw_criteria.iuo_calendar.of_UnRegister()
END IF

li_report_id = This.GetItemNumber( currentrow, "report_id" )
ls_report_dw = This.GetItemString( currentrow, "report_dw" )
ls_graph_dw = This.GetItemString( currentrow, "graph_dw" )
w_report.ii_report_id = li_report_id //Start Code Change ----09.11.2008 #V85 maha - added for log tracking
//Start Code Change ----07.25.2016 #V152 maha
w_report.is_report_name = This.GetItemString( currentrow, "report_name" )
w_report.is_prov_name = ""
//End Code Change ----07.25.2016

//Start Code Change ----09.23.2013 #V14 maha - net dev ids addresses
if ls_report_dw = "d_rpt_par_numbers_details_new" then
	if of_get_app_setting("set_74","I") = 1 then
		ls_report_dw = "d_rpt_par_numbers_details_new_addr"
	end if
end if
//End Code Change ----09.23.2013

dw_wizard_seq.of_SetTransObject( SQLCA )
iw_parent_window.il_wizard_step_cnt  = dw_wizard_seq.Retrieve( li_report_id )
iw_parent_window.il_current_wizard_step = 0

IF iw_parent_window.il_wizard_step_cnt = 0 THEN
	dw_criteria.DataObject = ""
ELSE
	iw_parent_window.of_wizard("Next")
END IF

IF IsNull( ls_report_dw ) OR ls_report_dw = "" THEN
	iw_parent_window.tab_rpt.tabpage_report.dw_report.DataObject = ""
ELSE
	iw_parent_window.tab_rpt.tabpage_report.dw_report.DataObject = ls_report_dw
	iw_parent_window.tab_rpt.tabpage_report.dw_report.of_SetTransObject( SQLCA )
	
	
  	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 2005-11-18 By: Zhang Lingping
	//$<reason> Special process for systable and syscolumn. 
	
	String ls_sqlreplace
	Integer lr
	
	if gs_dbtype = "SQL" then
		 if ls_report_dw = "d_data_dictionary" then
			 ls_sqlreplace = "  SELECT DISTINCT v_systable.table_name,  " + & 
           "v_syscolumns.cname,v_syscolumns.coltype, v_syscolumns.length,   " + &  
           "v_syscolumns.in_primary_key,    " + & 
           "v_systable.creator   " + & 
           "FROM v_syscolumns, v_systable   " + & 
           " WHERE ( v_systable.table_name = v_syscolumns.tname ) and   " + & 
           "( ( v_syscolumns.creator = 'DBO' ) )    " + & 
           " ORDER BY v_systable.table_name ASC,v_syscolumns.in_primary_key DESC,    " + & 
           " v_syscolumns.cname ASC  "
			  lr = iw_parent_window.tab_rpt.tabpage_report.dw_report.setsqlselect(ls_sqlreplace)
			  
			  if lr < 0 then
				 messagebox("error","set sql select error. u_tabpage_report_criteria::dw_select_report:;rowfocuschanged")
			  end if
		 end if
	end if
	//---------------------------- APPEON END ----------------------------
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.20.2006 By: Cao YongWang
	//$<reason> Fix a defect.
	/*
	iw_parent_window.is_sql = iw_parent_window.tab_rpt.tabpage_report.dw_report.Object.DataWindow.Table.Select	
	*/
	iw_parent_window.is_sql = iw_parent_window.tab_rpt.tabpage_report.dw_report.GetSQLSelect()
	//---------------------------- APPEON END ----------------------------
END IF

IF IsNull( ls_graph_dw ) OR ls_graph_dw = "" THEN
	iw_parent_window.tab_rpt.tabpage_graph.dw_graph.DataObject = ""
elseIF not isnull( ls_graph_dw ) and  isnumber(ls_graph_dw)  THEN //maha 021003 this would designate an export
	iw_parent_window.tab_rpt.tabpage_graph.dw_graph.DataObject = ""
	iw_parent_window.ii_export_id = integer(ls_graph_dw)
	iw_parent_window.ii_using_export = 1
	select export_name into :ls_export from export_header where export_id = :iw_parent_window.ii_export_id;
	dw_criteria.object.exp_name.text = ls_export
ELSE
	iw_parent_window.tab_rpt.tabpage_graph.dw_graph.DataObject = ls_graph_dw
	iw_parent_window.tab_rpt.tabpage_graph.dw_graph.of_SetTransObject( SQLCA )
END IF

IF iw_parent_window.il_wizard_step_cnt = 0 THEN
	iw_parent_window.tab_rpt.tabpage_report.dw_report.Event pfc_Retrieve()
	iw_parent_window.tab_rpt.SelectTab( 2 )
	IF Not IsNull( ls_graph_dw ) THEN
		iw_parent_window.tab_rpt.tabpage_graph.dw_graph.Event pfc_Retrieve()
	END IF
ELSE
	dw_criteria.SetFocus()
	iw_parent_window.tab_rpt.SelectTab( 1 )
END IF


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.20.2006 By: Cao YongWang
//$<reason> Fix a defect.
/*
parent.dw_criteria.object.datawindow.zoom = iw_parent_window.il_zoom
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.10.2007 By: Jack
//$<reason> Fix a defect.
/*
If len(iw_parent_window.is_sql) > 0 Then parent.dw_criteria.object.datawindow.zoom = iw_parent_window.il_zoom
*/
long li_zoom
If gb_autozoom Then  //added by gavins 20130107 //(Appeon)Harry 01.23.2014 - V142 ISG-CLX
	li_zoom = iw_parent_window.il_zoom
	If isnull(li_zoom) Or li_zoom = 0 Then li_zoom = 100
	//If len(iw_parent_window.is_sql) > 0 Then parent.dw_criteria.object.datawindow.zoom = li_zoom
	if LenA(iw_parent_window.is_sql) > 0 then dw_criteria.modify("datawindow.zoom = '"+string(li_zoom) + "'")	//05/10/2007 By Jervis
End If
//---------------------------- APPEON END ----------------------------
//---------------------------- APPEON END ----------------------------

//--------------------APPEON BEGIN----------------------------------
//<$>Modified :long.zhang 04.27.2012
//<$>Reason:Fixed a APB detect bug alpha test 2984  Standard report Info boxes 
//dw_criteria.PostEvent("pfc_cst_set_focus")
if AppeonGetClientType() = "PB" THEN
	dw_criteria.PostEvent("pfc_cst_set_focus")
Else
	dw_criteria.Triggerevent( "pfc_cst_set_focus")
END IF
//------------------Appeon End---------------------------------------

//Start Code Change ----12.12.2017 #V16 maha - Store button visibility
select count(srs_id) into :li_save_count from sys_report_storage where report_id = :li_report_id and report_type = 'S';
if li_save_count > 0 then
	iw_parent_window.cb_store.visible = true
else
	iw_parent_window.cb_store.visible = false
end if




end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event resize;call super::resize;


iw_parent_window.il_zoom =   long(this.Object.DataWindow.Zoom)
end event

event buttonclicked;call super::buttonclicked;long ll_report

ll_report = This.GetItemNumber( row, "report_id" )

if dwo.name = "b_prop" then 
	if isvalid(w_report_properties) then
		w_report_properties.dw_1.retrieve(ll_report)
	else
		openwithparm(w_report_properties,ll_report)
		//--------------------Appeon begin---------------
		//<$>added long.zhang 04.27.2012
		//<$>Reason:Fixed a Apb detect bug alpha test 2984
		if AppeonGetClientType() <> "PB" then
			dw_criteria.Triggerevent( "pfc_cst_set_focus")
		end if
		//--------------------Appeon End------------------
	end if
end if 
end event

type cb_search from commandbutton within u_tabpage_report_criteria
integer x = 1655
integer y = 320
integer width = 503
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Provider Search"
end type

event clicked;Integer li_nr
Integer li_find
Long ll_prac_id
String ls_full_name
gs_search lstr_search
gs_batch_search ist_search
integer i
integer ic

lstr_search.stran_transaction = SQLCA
IF Not IsNull( iw_parent_window.il_facility_id ) THEN
	lstr_search.ls_open_for = "REPORTS" + String( iw_parent_window.il_facility_id ) 
ELSE
	lstr_search.ls_open_for = "REPORTS1" 
END IF

//messagebox("", lstr_search.ls_open_for )
OpenWithParm( w_extended_search_new , lstr_search )

// start code change --- 11.22.2005 MSKINNER
if not isvalid( message.powerobjectparm) then return 
// end code change --- 11.22.2005 MSKINNER

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm
//maha 091605 allowing for multi selection
ic = upperbound(ist_search.li_prac_id[])
for i = 1 to ic
//ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )
//ls_full_name = Mid( Message.StringParm, Pos( Message.StringParm, "-" ) +1, 100 )
	ll_prac_id = ist_search.li_prac_id[i] //maha 091605
	select full_name into :ls_full_name from v_full_name where prac_id = :ll_prac_id;
	//ls_full_name = ist_search.ls_name[i] //maha 091605


	li_find = dw_criteria.Find( "prac_id = " + String( ll_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN
		MessageBox("Select Error", "You have allready selected this person to attend!, Please reselect." )
		Return -1
	END IF
	
	li_nr = dw_criteria.InsertRow( 0 )
	
	dw_criteria.SetItem( li_nr, "prac_id", ll_prac_id )
	//messagebox("", ll_prac_id )
	dw_criteria.SetItem( li_nr, "full_name", ls_full_name )
next
//ll_prac_id = Long( Mid( Message.StringParm, 1, Pos( Message.StringParm, "-" ) -1 ) )
//w_report.il_prac_id = ll_prac_id
//
//ls_full_name = Mid( Message.StringParm, Pos( Message.StringParm, "-" ) +1, 100 )
//
//li_find = dw_criteria.Find( "prac_id = " + String( ll_prac_id ), 1, 1000 )
//
//IF li_find > 0 THEN
//	MessageBox("Select Error", "You have already selected this person (id# " + string(ll_prac_id) + "), Please reselect." )
//	Return -1
//END IF
//
//li_nr = dw_criteria.InsertRow( 0 )

dw_criteria.SetItem( li_nr, "prac_id", ll_prac_id )
dw_criteria.SetItem( li_nr, "full_name", ls_full_name )

dw_criteria.SetFocus( )
dw_criteria.SelectRow( 0 , False )
dw_criteria.ScrollToRow( li_nr )
dw_criteria.SetRow ( li_nr )
dw_criteria.SelectRow( li_nr , True )


end event

type cb_batch from commandbutton within u_tabpage_report_criteria
integer x = 2162
integer y = 320
integer width = 485
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Search"
end type

event clicked;//return

gs_batch_search lst_search
long i
long ic
long r
long rc
long pracids[]
string names[]
string ls_openstring

if iw_parent_window.ii_using_export = 1 then
	if iw_parent_window.il_facility_id > 0 then  //report batch
		ls_openstring = "P*" + string(iw_parent_window.il_facility_id)
	elseif iw_parent_window.il_facility_id = 0 then 
		ls_openstring = "P*ALL" 
	else 
		ls_openstring = "P"
	end if
else
	if iw_parent_window.il_facility_id > 0 then  //report batch
		ls_openstring = "R*" + string(iw_parent_window.il_facility_id)
	elseif iw_parent_window.il_facility_id = 0 then 
		ls_openstring = "R*ALL" 
	else 
		ls_openstring = "R"
	end if
end if
	


openwithparm(w_batch_prac_select_new,ls_openstring)


if message.stringparm = "Cancel" then
	return

else 
	lst_search = message.powerobjectparm
	if isnull(lst_search) then return
	
	pracids[] = lst_search.li_prac_id[]
	names[] = lst_search.ls_name[]
	ic = upperbound(pracids[]) 
	
	if iw_parent_window.ii_using_export = 1 then
		w_report.il_prac_ids[] = pracids[]
	end if 
	 
	for i = 1 to ic
		r = dw_criteria.InsertRow( 0 )
		dw_criteria.SetItem( r, "prac_id", pracids[i])
		dw_criteria.SetItem( r, "full_name", names[i] )
	next
	
	dw_criteria.SetFocus( )
	dw_criteria.SelectRow( 0 , False )
	dw_criteria.ScrollToRow( 1 )
	dw_criteria.SetRow ( 1 )
	dw_criteria.SelectRow( 1 , True )
	if iw_parent_window.ii_using_export <> 1 then
		
		if iw_parent_window.tab_rpt.tabpage_report.dw_report.DataObject = "d_prf_master" then
			if dw_criteria.rowcount() > 1 then
				st_batch.visible = true
			end if
		end if
		 
	end if
	
end if

end event

event constructor;IF gb_sk_ver = True THEN  //Start Code Change ----11.19.2010 #V10 maha - hide for SK
	this.visible = false
end if
end event

type cb_prior from u_cb within u_tabpage_report_criteria
integer x = 2798
integer y = 320
integer height = 84
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "<- &Prior"
end type

event clicked;





iw_parent_window.of_wizard( "Prior" )
end event

type cb_next from u_cb within u_tabpage_report_criteria
integer x = 3159
integer y = 320
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Next->"
end type

event clicked;iw_parent_window.of_wizard( "Next" )
end event

type dw_criteria from u_dw within u_tabpage_report_criteria
event pfc_cst_set_focus ( )
integer x = 1550
integer y = 476
integer width = 1975
integer height = 1708
integer taborder = 20
boolean hscrollbar = true
end type

event pfc_cst_set_focus;This.SetFocus()
end event

event clicked;call super::clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-07-31 By: Rodger Wu (Contract)
//$<reason> Modification for contract report.
/*
	IF row > 0 AND This.DataObject = "d_crit_pracs" THEN
		This.SetRow( row )
		This.ScrollToRow( row )
		This.SelectRow( 0, False )
		This.SelectRow( row, True )
	END IF
*/
if row < 1 then return;
if This.DataObject = "d_crit_pracs" or &
   This.DataObject = "d_rpt_ctx_wiz_select" or &
	This.DataObject = "d_rpt_ctx_wiz_select_cptcode" then
	
	This.SetRow( row )
	This.ScrollToRow( row )
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
	
end if
//---------------------------- APPEON END ----------------------------
end event

event constructor;This.of_Setupdateable(False )
end event

event itemchanged;call super::itemchanged;//$<modify> 05.22.2008 by Andy
//fixed BugN050607
//Integer i
//
//IF This.GetColumnName() = "selected" THEN
//	IF row > 1 THEN
//		This.SetItem( 1, "selected", 0 )
//	ELSE
//		if this.getitemnumber(1,"lookup_code") < 1 then //maha 091103
//			FOR i = 2 TO This.RowCount( )
//				This.SetItem( i, "selected", 0 )
//			END FOR	
//			This.SetItem( 1, "selected", 1 )
//		end if
//	END IF
//END IF

Integer i

//------------------- APPEON BEGIN -------------------
//$<add> Michael 01.18.20.2012
//$<reason> Bug 2870 enhancement request  
IF This.GetColumnName() = "selected" and this.dataobject = 'd_crit_multi_group' then
	if row <> 1 then
		This.SetItem( 1, "selected", 0 )
	else
		if data ='1' then //select All
			for i = 2 TO This.RowCount( )
				This.SetItem( i, "selected", 0 )
			next
		end if
	end if	
	return
end if
//------------------- APPEON END ---------------------


IF This.GetColumnName() = "selected"  THEN
	//Start Code Change ----10.22.2012 #V12 maha - added d_crit_priv_status
	IF row > 1 and (this.dataobject<>'d_crit_contract_det_contact' and this.dataobject<>'d_crit_contract_status' ) and this.dataobject <> 'd_crit_priv_status' THEN
		This.SetItem( 1, "selected", 0 )
	ELSEif  (this.dataobject<>'d_crit_contract_det_contact' and this.dataobject<>'d_crit_contract_status')  then
		//Start Code Change ----06.25.2009 #V92 maha - ameripath customization
		if this.dataobject = 'd_crit_user_multi'  then
			if this.getrow() = 1 then //maha 091103
				FOR i = 2 TO This.RowCount( )
					This.SetItem( i, "selected", 0 )
				END FOR	
				This.SetItem( 1, "selected", 1 )
			end if
		//End Code Change---06.25.2009
		elseif this.dataobject = 'd_crit_appl_tracking_step' then
			//nothing

		else
			if this.getitemnumber(1,"lookup_code") < 1 then //maha 091103
				FOR i = 2 TO This.RowCount( )
					This.SetItem( i, "selected", 0 )
				END FOR	
				This.SetItem( 1, "selected", 1 )
			end if
		end if
	END IF
END IF
//end 05.22.2008
end event

event rowfocuschanged;call super::rowfocuschanged;if iw_parent_window.ii_using_export = 1 then
	
else
	
	IF This.RowCount() > 1 AND This.DataObject = 'd_crit_pracs' then
		choose case iw_parent_window.tab_rpt.tabpage_report.dw_report.DataObject
			case "d_prf_master" 
				st_batch.Visible = True
			case "d_prf_ver_results"
				//st_batch.Visible = True
		end choose
	END IF

end if
end event

event retrieveend;call super::retrieveend;

if LenA(this.dataobject) > 0 then
	//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
	//Object.DataWindow.Zoom = iw_parent_window.il_zoom 
	If gb_autozoom Then  //added by gavins 20130107
		Object.DataWindow.Zoom = iw_parent_window.il_zoom 
	End If
	//---------End Modfiied ------------------------------------------------------
  end if
end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.31.2006 By: Rodger Wu (Contract)
//$<reason> Modification for Contract Analysis Reporting

String ls_return, ls_temp, ls_ctxid, ls_company, ls_cptcode, ls_description
Long ll_found, ll_inserted, ll_selected
Integer li_position

Choose Case dwo.Name
	Case "b_ctx_add"
		if This.DataObject = "d_rpt_ctx_wiz_select" then //Add contract
			Open( w_rpt_contract_search )
			ls_return = Message.StringParm
			if ls_return = '' then return;
			
			This.SetRedraw( False )
			
			Do
				ls_temp = f_get_token( ls_return, "|" )
				li_position = PosA( ls_temp, "~t" )
				ls_ctxid = LeftA( ls_temp, li_position - 1 )
				ls_company = RightA( ls_temp, LenA( ls_temp ) - li_position )
				
				ll_found = This.Find( "lookup_code = " + ls_ctxid, 1, This.Rowcount() )
				if ll_found > 0 then continue;
				
				ll_inserted = This.InsertRow( 0 )
				This.SetItem( ll_inserted, "lookup_code", Long( ls_ctxid ) )
				This.SetItem( ll_inserted, "code", ls_company )
				This.SetItem( ll_inserted, "selectitem", 1 )
			Loop While ls_return <> ''
			
			This.SetRedraw( True )
		else//Add CPT code
			Open( w_rpt_contract_cptcode )
			ls_return = Message.StringParm
			if ls_return = '' then return;
			
			This.SetRedraw( False )
			
			Do
				ls_temp = f_get_token( ls_return, "|" )
				li_position = PosA( ls_temp, "~t" )
				ls_cptcode = LeftA( ls_temp, li_position - 1 )
				ls_description = RightA( ls_temp, LenA( ls_temp ) - li_position )
				
				ll_found = This.Find( "cptcode = '" + ls_cptcode + "'", 1, This.Rowcount() )
				if ll_found > 0 then continue;
				
				ll_inserted = This.InsertRow( 0 )
				This.SetItem( ll_inserted, "cptcode", ls_cptcode )
				This.SetItem( ll_inserted, "description", ls_description )
				This.SetItem( ll_inserted, "selectitem", 1 )
			Loop While ls_return <> ''
			
			This.SetRedraw( True )
		end if
		
		if This.GetSelectedRow( 0 ) < 1 then
			This.Trigger Event Clicked( 0, 0, 1, This.Object.SelectItem )
		end if
		
	Case "b_ctx_delete"
		ll_selected = This.GetSelectedRow( 0 )
		if ll_selected > 0 then This.DeleteRow( ll_selected )
	
		if ll_selected = 1 then ll_selected ++;
		This.Trigger Event Clicked( 0, 0, ll_selected - 1, This.Object.SelectItem )
		
End Choose
//---------------------------- APPEON END ----------------------------
end event

type dw_wizard_seq from u_dw within u_tabpage_report_criteria
boolean visible = false
integer x = 2958
integer y = 284
integer width = 256
integer height = 104
integer taborder = 30
string dataobject = "d_wizard_sequence"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type dw_criteria_box from u_dw within u_tabpage_report_criteria
integer x = 1536
integer y = 4
integer width = 2002
integer height = 2196
integer taborder = 20
boolean enabled = false
boolean titlebar = true
string title = "Report Criteria"
string dataobject = "d_crit_background"
boolean vscrollbar = false
end type

event clicked;call super::clicked;Integer li_row

li_row = GetClickedRow()

IF li_row > 0 THEN
	This.SelectRow( 0, False )
	This.SetRow( li_row )
	This.ScrollToRow( li_row )
	This.SelectRow( li_row, True )
END IF
end event

event constructor;This.of_Setupdateable(False )
end event

type cbx_primary_only from checkbox within u_tabpage_report_criteria
boolean visible = false
integer x = 2423
integer y = 236
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
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

type dw_profile_temp from u_dw within u_tabpage_report_criteria
boolean visible = false
integer x = 1591
integer y = 28
integer width = 1902
integer height = 148
integer taborder = 20
boolean bringtotop = true
boolean hscrollbar = true
boolean resizable = true
end type

type st_help_text from statictext within u_tabpage_report_criteria
integer x = 1701
integer y = 132
integer width = 1637
integer height = 84
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Provider"
alignment alignment = center!
boolean focusrectangle = false
end type

