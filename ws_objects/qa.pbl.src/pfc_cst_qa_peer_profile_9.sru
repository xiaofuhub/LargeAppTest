$PBExportHeader$pfc_cst_qa_peer_profile_9.sru
forward
global type pfc_cst_qa_peer_profile_9 from u_tab
end type
type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile_9
end type
type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile_9
end type
type tabpage_quality_profile from u_tabpage_measurments within pfc_cst_qa_peer_profile_9
end type
type tabpage_quality_profile from u_tabpage_measurments within pfc_cst_qa_peer_profile_9
end type
type tabpage_site_survey from u_tab_site_survey within pfc_cst_qa_peer_profile_9
end type
type tabpage_site_survey from u_tab_site_survey within pfc_cst_qa_peer_profile_9
end type
type tabpage_case_review from u_tabpage_case_review within pfc_cst_qa_peer_profile_9
end type
type tabpage_case_review from u_tabpage_case_review within pfc_cst_qa_peer_profile_9
end type
type tabpage_oppe from u_tabpage_oppe within pfc_cst_qa_peer_profile_9
end type
type tabpage_oppe from u_tabpage_oppe within pfc_cst_qa_peer_profile_9
end type
type tabpage_profile from u_tabpage_profiles within pfc_cst_qa_peer_profile_9
end type
type tabpage_profile from u_tabpage_profiles within pfc_cst_qa_peer_profile_9
end type
type tabpage_priv from u_tabpage_priv within pfc_cst_qa_peer_profile_9
end type
type tabpage_priv from u_tabpage_priv within pfc_cst_qa_peer_profile_9
end type
end forward

global type pfc_cst_qa_peer_profile_9 from u_tab
integer width = 3707
integer height = 1944
tabpage_search tabpage_search
tabpage_quality_profile tabpage_quality_profile
tabpage_site_survey tabpage_site_survey
tabpage_case_review tabpage_case_review
tabpage_oppe tabpage_oppe
tabpage_profile tabpage_profile
tabpage_priv tabpage_priv
end type
global pfc_cst_qa_peer_profile_9 pfc_cst_qa_peer_profile_9

forward prototypes
public subroutine of_retrieve_measuremts ()
public subroutine of_retrieve_site_survey ()
public subroutine of_retrive_case_review ()
end prototypes

public subroutine of_retrieve_measuremts ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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


long ll_row
datawindow ldw_dw_1

ldw_dw_1 = this.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.dw_1

this.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.dw_1.event pfc_retrieve( )

if ldw_dw_1.rowcount( ) > 0 then
   this.tabpage_quality_profile.text = this.tabpage_quality_profile.uo_1.tag + ' (' + string(ldw_dw_1.rowcount()) + ")"
     else
	this.tabpage_quality_profile.text = this.tabpage_quality_profile.uo_1.tag
end if
end subroutine

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
	This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_addresses.Reset( )
	This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.Reset( )
	This.tabpage_site_survey.uo_1.tab_review.tabpage_questions.dw_answers.Reset( )
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
	This.tabpage_site_survey.uo_1.of_set_prac_id(ll_prac_id)
	//---------------------------- APPEON END ----------------------------
	
	This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_addresses.Event pfc_retrieve( )
	
	IF This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_addresses.RowCount( ) > 0 THEN
		//Added by  Nova 03.01.2010
		IF This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.RowCount( ) > 0 THEN
			This.tabpage_site_survey.uo_1.of_retrieve_detail(This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.GetItemNumber(This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_browse.GetRow(), "rec_id") )
		END IF
		This.tabpage_site_survey.Text = This.tabpage_site_survey.is_title + " ("  + String(This.tabpage_site_survey.uo_1.tab_review.tabpage_browse.dw_addresses.RowCount( )) + ")"
	ELSE
		This.tabpage_site_survey.Text = This.tabpage_site_survey.is_title
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

//if  this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.rowcount( ) > 0 then
	this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.reset()
	this.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_action_item.reset()
	this.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_ai.dw_ai_report.reset()
	this.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_detail.reset()
	this.tabpage_case_review.uo_1.tab_1.tabpage_detail.tab_2.tabpage_case_detail.dw_physicians.reset()
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

	this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.event pfc_retrieve( )
	// modify the tab text		
	if this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.rowcount( ) > 0 then
		this.tabpage_case_review.text = this.tabpage_case_review.uo_1.is_title + " ("  + string(this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.rowcount( )) + ")"
	 else
		this.tabpage_case_review.text = this.tabpage_case_review.uo_1.is_title
	end if
//end if

  

end subroutine

on pfc_cst_qa_peer_profile_9.create
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

on pfc_cst_qa_peer_profile_9.destroy
call super::destroy
destroy(this.tabpage_search)
destroy(this.tabpage_quality_profile)
destroy(this.tabpage_site_survey)
destroy(this.tabpage_case_review)
destroy(this.tabpage_oppe)
destroy(this.tabpage_profile)
destroy(this.tabpage_priv)
end on

event selectionchanged;call super::selectionchanged;
long ll_row
datawindow ldw_dw_1
ldw_dw_1 = this.tabpage_quality_profile.uo_1.tab_measurements.tabpage_browse.dw_1
choose case newindex
	case 1
	case 2
	case 3

	case 4
		  	this.tabpage_case_review.uo_1.tab_1.tabpage_browse.dw_browse.event pfc_retrieve( )
	case else
		
end choose
end event

type tabpage_search from u_tabpage_search within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

type tabpage_quality_profile from u_tabpage_measurments within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

type tabpage_site_survey from u_tab_site_survey within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
string picturename = "StyleLibraryList5!"
end type

type tabpage_case_review from u_tabpage_case_review within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

type tabpage_oppe from u_tabpage_oppe within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

type tabpage_profile from u_tabpage_profiles within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

type tabpage_priv from u_tabpage_priv within pfc_cst_qa_peer_profile_9
integer x = 18
integer y = 112
integer width = 3671
integer height = 1816
end type

