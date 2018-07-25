$PBExportHeader$pfc_cst_qa_peer_profile.sru
forward
global type pfc_cst_qa_peer_profile from u_tab
end type
type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile
end type
type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile
end type
type tabpage_quality_profile from userobject within pfc_cst_qa_peer_profile
end type
type uo_qa from pfc_cst_u_qa_new_profiles within tabpage_quality_profile
end type
type tabpage_quality_profile from userobject within pfc_cst_qa_peer_profile
uo_qa uo_qa
end type
type tabpage_site_survey from userobject within pfc_cst_qa_peer_profile
end type
type uo_5 from pfc_cst_u_site_survey_collect_dat within tabpage_site_survey
end type
type tabpage_site_survey from userobject within pfc_cst_qa_peer_profile
uo_5 uo_5
end type
type tabpage_case_review from userobject within pfc_cst_qa_peer_profile
end type
type uo_case from uo_prac_peer_review within tabpage_case_review
end type
type tabpage_case_review from userobject within pfc_cst_qa_peer_profile
uo_case uo_case
end type
type tabpage_oppe from userobject within pfc_cst_qa_peer_profile
end type
type uo_oppe from uo_oppe_fppe_evals within tabpage_oppe
end type
type tabpage_oppe from userobject within pfc_cst_qa_peer_profile
uo_oppe uo_oppe
end type
type tabpage_profile from userobject within pfc_cst_qa_peer_profile
end type
type cb_runr from commandbutton within tabpage_profile
end type
type cb_printp from commandbutton within tabpage_profile
end type
type uo_profile from pfc_cst_u_profile within tabpage_profile
end type
type tabpage_profile from userobject within pfc_cst_qa_peer_profile
cb_runr cb_runr
cb_printp cb_printp
uo_profile uo_profile
end type
type tabpage_priv from userobject within pfc_cst_qa_peer_profile
end type
type uo_priv from pfc_cst_qa_priv within tabpage_priv
end type
type tabpage_priv from userobject within pfc_cst_qa_peer_profile
uo_priv uo_priv
end type
end forward

global type pfc_cst_qa_peer_profile from u_tab
integer width = 3566
integer height = 2180
long backcolor = 16777215
tabpage_search tabpage_search
tabpage_quality_profile tabpage_quality_profile
tabpage_site_survey tabpage_site_survey
tabpage_case_review tabpage_case_review
tabpage_oppe tabpage_oppe
tabpage_profile tabpage_profile
tabpage_priv tabpage_priv
end type
global pfc_cst_qa_peer_profile pfc_cst_qa_peer_profile

forward prototypes
public subroutine of_retrieve_site_survey ()
public subroutine of_retrive_case_review ()
public subroutine of_retrieve_measurements (long al_facil, long al_prac)
end prototypes

public subroutine of_retrieve_site_survey ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////// //
//  [PUBLIC]   : of_retrieve_measuremts
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


Long ll_row

IF  This.tabpage_search.uo_search.dw_search.RowCount( ) > 0 THEN
	This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_addresses.Reset( )
	This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_browse.Reset( )
	This.tabpage_site_survey.uo_5.tab_review.tabpage_questions.dw_answers.Reset( )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<modify> 03.14.2006 By: LiuHongXin
	//$<reason> The statement f1(Dynamic f2()) is unsupported. If a function is dynamically called,
	//$<reason>  its return value cannot be passed as an argument of another function.
	//$<modification> 1)Create a variable; 2)Specify the return of the function that is dynamically
	//$<modification> called to the variable; 3)Use the variable as an argument.
					/*
					this.tabpage_site_survey.uo_1.of_set_prac_id(iw_parent.dynamic of_getprac_id())
					//this.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.event pfc_retrieve( )
					this.TABPage_site_survey.uo_1.of_set_prac_id(iw_parent.dynamic of_getprac_id())
	*/
	Long ll_prac_id
	ll_prac_id = iw_parent.Dynamic of_getprac_id()
	This.tabpage_site_survey.uo_5.of_set_prac_id(ll_prac_id)
	//---------------------------- APPEON END ----------------------------
	
	This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_addresses.Event pfc_retrieve( )
	
	IF This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_addresses.RowCount( ) > 0 THEN
		//Added by  Nova 03.01.2010
		IF This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_browse.RowCount( ) > 0 THEN
			This.tabpage_site_survey.uo_5.of_retrieve_detail(This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_browse.GetItemNumber(This.tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_browse.GetRow(), "rec_id") )
		END IF
			//tabpage_site_survey.Text = Tabpage_site_survey.tag + " ("  + String(tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_addresses.RowCount( )) + ")"
			tabpage_site_survey.Text = This.tabpage_site_survey.uo_5.tag + " ("  + String(tabpage_site_survey.uo_5.tab_review.tabpage_browse.dw_addresses.RowCount( )) + ")"

ELSE
//		This.tabpage_site_survey.Text = This.tabpage_site_survey.is_title
	END IF
END IF

end subroutine

public subroutine of_retrive_case_review ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_retrive_case_review
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

long ll_row

//debugbreak()
//if  this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.rowcount( ) > 0 then
	tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.reset()
	tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.reset()
	tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_ai_report.reset()
	tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.reset()
	tabpage_case_review.uo_case.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.reset()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<modify> 03.14.2006 By: LiuHongXin
	//$<reason> The statement f1(Dynamic f2()) is unsupported. If a function is dynamically called,
	//$<reason>  its return value cannot be passed as an argument of another function.
	//$<modification> 1)Create a variable; 2)Specify the return of the function that is dynamically
	//$<modification> called to the variable; 3)Use the variable as an argument.
	/*
	this.tabpage_case_review.uo_1.of_set_prac_id( iw_parent.dynamic of_getprac_id()  )
	*/
	//begin commented by  Nova 12.08.2009 --v10.1 Profiles Build out
	//	long ll_prac_id
	//	ll_prac_id = iw_parent.DYNAMIC of_getprac_id()
	//	this.tabpage_case_review.uo_1.of_set_prac_id( ll_prac_id )
	// end commented 
	//---------------------------- APPEON END ----------------------------

	tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.event pfc_retrieve( )
	// modify the tab text		
	if tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.rowcount( ) > 0 then
		tabpage_case_review.text = tabpage_case_review.uo_case.is_title + " ("  + string(tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.rowcount( )) + ")"
	 else
		tabpage_case_review.text = tabpage_case_review.uo_case.is_title
	end if
//end if

  

end subroutine

public subroutine of_retrieve_measurements (long al_facil, long al_prac);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_retrieve_measuremts
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

datawindowchild dwchild //maha 04.25.2012
long ll_row
datawindow ldw_dw_1

//------------------- APPEON BEGIN -------------------
//$<move> stephen 09.22.2011
//$<reason> Profile Module Refresh Issue - Bug id 2659
tabpage_quality_profile.uo_qa.il_prac_id = al_prac
tabpage_quality_profile.uo_qa.il_facility = al_facil
//------------------- APPEON END -------------------
debugbreak()
ldw_dw_1 = tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.dw_browse

//Start Code Change ----03.26.2013 #V12 maha
ldw_dw_1.retrieve(al_prac,al_facil)
//tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.dw_browse.event pfc_retrieve( )

if ldw_dw_1.rowcount( ) > 0 then
   tabpage_quality_profile.text = tabpage_quality_profile.uo_qa.tag + ' (' + string(ldw_dw_1.rowcount()) + ")"
     else
	tabpage_quality_profile.text = tabpage_quality_profile.uo_qa.tag
end if


//Start Code Change ----04.25.2012 #V12 maha - retrieve the facilities the provider has
tabpage_quality_profile.uo_qa.dw_settings.GetChild( "facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id,al_prac )

//Ene Code Change ----04.25.2012

tabpage_quality_profile.uo_qa.dw_settings.setitem(1,"facility_id",al_facil)
tabpage_quality_profile.uo_qa.tab_measurments.tabpage_data.dw_pd_metrics.retrieve(al_prac,al_facil)
end subroutine

on pfc_cst_qa_peer_profile.create
this.tabpage_search=create tabpage_search
this.tabpage_quality_profile=create tabpage_quality_profile
this.tabpage_site_survey=create tabpage_site_survey
this.tabpage_case_review=create tabpage_case_review
this.tabpage_oppe=create tabpage_oppe
this.tabpage_profile=create tabpage_profile
this.tabpage_priv=create tabpage_priv
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_search
this.Control[iCurrent+2]=this.tabpage_quality_profile
this.Control[iCurrent+3]=this.tabpage_site_survey
this.Control[iCurrent+4]=this.tabpage_case_review
this.Control[iCurrent+5]=this.tabpage_oppe
this.Control[iCurrent+6]=this.tabpage_profile
this.Control[iCurrent+7]=this.tabpage_priv
end on

on pfc_cst_qa_peer_profile.destroy
call super::destroy
destroy(this.tabpage_search)
destroy(this.tabpage_quality_profile)
destroy(this.tabpage_site_survey)
destroy(this.tabpage_case_review)
destroy(this.tabpage_oppe)
destroy(this.tabpage_profile)
destroy(this.tabpage_priv)
end on

event selectionchanged;call super::selectionchanged;Long ll_parent 
Long ll_prac 
Long ll_view_id
long ll_row
datawindow ldw_dw_1
//ldw_dw_1 = this.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.dw_1
IF oldindex < 1 Or newindex < 1 THEN RETURN

IF oldindex = 1 THEN
	IF tabpage_search.uo_search.dw_search.RowCount() > 0 THEN
		ll_parent = tabpage_search.uo_search.dw_search.GetItemNumber(tabpage_search.uo_search.dw_search.GetRow(),'parent_facility_id')
		ll_prac = tabpage_search.uo_search.dw_search.GetItemNumber(tabpage_search.uo_search.dw_search.GetRow(),'prac_id')
		ll_view_id = tabpage_search.uo_search.dw_view.GetItemNumber(1,"data_view_id")
		iw_parent.SetRedraw( False)
		iw_parent.Dynamic of_retrieve_measuremts(ll_parent,ll_prac)
		iw_parent.Dynamic of_retrieve_site_survey()
		iw_parent.Dynamic of_retrieve_case_review(ll_prac,ll_parent)
		iw_parent.Dynamic of_retrieve_oppe(ll_prac,ll_parent)
		iw_parent.Dynamic of_retrieve_priv(ll_prac,ll_parent)
		iw_parent.Dynamic of_run_report(ll_prac,ll_parent,ll_view_id)
	ELSE
		selecttab( 1)
		This.of_messagebox( '',iw_parent.Title , 'Please select a practitioner before continuing.', information!, ok!, 1)
		
		RETURN
	END IF
	
END IF

iw_parent.SetRedraw( False)

 //Start Code Change ----12.03.2015 #V15 maha - no longer using any menus for this window
IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
	IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
	w_mdi.of_menu_security( w_mdi.MenuName )
	w_mdi.SetToolbar (2, false )
END IF

//choose case newindex
//	case 1
//		IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
//			IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
//			w_mdi.of_menu_security( w_mdi.MenuName )
//		END IF
//			
//	case 2
////		Parent.of_set_measurments_menu( )
//		IF w_mdi.MenuName <> 'm_pfe_cst_qa' THEN w_mdi.ChangeMenu(m_pfe_cst_qa)
//		w_mdi.of_menu_security( w_mdi.MenuName )
////		tab_qa.tabpage_quality_profile.uo_qa.tab_measurments.tabpage_browse.dw_browse.setfocus( )
//	case 3
//
//	case 4
//		  	this.tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.event pfc_retrieve( )
////			Parent.of_set_caseview_menu()
////			tab_qa.tabpage_case_review.uo_case.tab_1.tabpage_browse.dw_browse.setfocus( )
//	case 6
////		Parent.of_set_profile_menu( )
//	case else
//			IF w_mdi.MenuName	 <> 'm_pfe_cst_mdi_menu' THEN
//				w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
//
//				IF w_mdi.MenuName <> 'm_pfe_cst_mdi_menu' THEN w_mdi.ChangeMenu( m_pfe_cst_mdi_menu )
//				w_mdi.of_menu_security( w_mdi.MenuName )
//			//---------------------------- APPEON END ----------------------------
//			END IF
//end choose
  
//End Code Change ----12.03.2015

iw_parent.SetRedraw( True)
end event

type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string picturename = "Custom062!"
end type

type tabpage_quality_profile from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "Quality Profile"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "EditDataTabular!"
long picturemaskcolor = 536870912
uo_qa uo_qa
end type

on tabpage_quality_profile.create
this.uo_qa=create uo_qa
this.Control[]={this.uo_qa}
end on

on tabpage_quality_profile.destroy
destroy(this.uo_qa)
end on

type uo_qa from pfc_cst_u_qa_new_profiles within tabpage_quality_profile
event destroy ( )
string tag = "QA Profiles"
integer width = 3941
integer height = 1976
integer taborder = 40
end type

on uo_qa.destroy
call pfc_cst_u_qa_new_profiles::destroy
end on

type tabpage_site_survey from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "Site Survey"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Paste!"
long picturemaskcolor = 536870912
uo_5 uo_5
end type

on tabpage_site_survey.create
this.uo_5=create uo_5
this.Control[]={this.uo_5}
end on

on tabpage_site_survey.destroy
destroy(this.uo_5)
end on

type uo_5 from pfc_cst_u_site_survey_collect_dat within tabpage_site_survey
event destroy ( )
string tag = "Site Surveys"
integer y = 24
integer width = 3785
integer height = 2028
integer taborder = 21
end type

on uo_5.destroy
call pfc_cst_u_site_survey_collect_dat::destroy
end on

type tabpage_case_review from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "Case Review"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DosEdit5!"
long picturemaskcolor = 536870912
uo_case uo_case
end type

on tabpage_case_review.create
this.uo_case=create uo_case
this.Control[]={this.uo_case}
end on

on tabpage_case_review.destroy
destroy(this.uo_case)
end on

type uo_case from uo_prac_peer_review within tabpage_case_review
event destroy ( )
string tag = "Case Review"
integer y = 24
integer width = 3634
integer height = 1776
integer taborder = 440
end type

on uo_case.destroy
call uo_prac_peer_review::destroy
end on

type tabpage_oppe from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "OPPE/FPPE"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "SelectStartRemote!"
long picturemaskcolor = 536870912
uo_oppe uo_oppe
end type

on tabpage_oppe.create
this.uo_oppe=create uo_oppe
this.Control[]={this.uo_oppe}
end on

on tabpage_oppe.destroy
destroy(this.uo_oppe)
end on

type uo_oppe from uo_oppe_fppe_evals within tabpage_oppe
event destroy ( )
string tag = "OPPE/FPPE"
integer y = 8
integer width = 3602
integer height = 1820
integer taborder = 440
end type

on uo_oppe.destroy
call uo_oppe_fppe_evals::destroy
end on

type tabpage_profile from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "Data Profiles"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Retrieve5!"
long picturemaskcolor = 536870912
cb_runr cb_runr
cb_printp cb_printp
uo_profile uo_profile
end type

on tabpage_profile.create
this.cb_runr=create cb_runr
this.cb_printp=create cb_printp
this.uo_profile=create uo_profile
this.Control[]={this.cb_runr,&
this.cb_printp,&
this.uo_profile}
end on

on tabpage_profile.destroy
destroy(this.cb_runr)
destroy(this.cb_printp)
destroy(this.uo_profile)
end on

type cb_runr from commandbutton within tabpage_profile
integer x = 2921
integer y = 32
integer width = 343
integer height = 84
integer taborder = 440
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Report"
end type

event clicked;//Start Code Change ----02.17.2012 #V12 maha - added button
uo_profile.of_Run_Report()
end event

type cb_printp from commandbutton within tabpage_profile
integer x = 2569
integer y = 32
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;//Start Code Change ----02.17.2012 #V12 maha - added button
uo_profile.of_print_report( )
end event

type uo_profile from pfc_cst_u_profile within tabpage_profile
event destroy ( )
string tag = "Profiles"
integer y = 24
integer width = 3570
integer height = 1844
integer taborder = 30
end type

on uo_profile.destroy
call pfc_cst_u_profile::destroy
end on

type tabpage_priv from userobject within pfc_cst_qa_peer_profile
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3529
integer height = 2052
long backcolor = 16777215
string text = "Privileges"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Custom016!"
long picturemaskcolor = 536870912
uo_priv uo_priv
end type

on tabpage_priv.create
this.uo_priv=create uo_priv
this.Control[]={this.uo_priv}
end on

on tabpage_priv.destroy
destroy(this.uo_priv)
end on

type uo_priv from pfc_cst_qa_priv within tabpage_priv
event destroy ( )
string tag = "Privileges"
integer width = 3378
integer height = 1812
integer taborder = 440
end type

on uo_priv.destroy
call pfc_cst_qa_priv::destroy
end on

