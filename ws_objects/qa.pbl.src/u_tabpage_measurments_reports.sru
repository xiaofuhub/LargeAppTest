$PBExportHeader$u_tabpage_measurments_reports.sru
forward
global type u_tabpage_measurments_reports from u_tabpg
end type
type cb_1 from uo_cb_output within u_tabpage_measurments_reports
end type
type cbx_remove_threshold from u_cbx within u_tabpage_measurments_reports
end type
type cb_run from u_cb within u_tabpage_measurments_reports
end type
type cb_mail from u_cb within u_tabpage_measurments_reports
end type
type st_1 from statictext within u_tabpage_measurments_reports
end type
type rb_physician_profile_comparison from u_rb within u_tabpage_measurments_reports
end type
type rb_qa_physician_profile_report from u_rb within u_tabpage_measurments_reports
end type
type dw_report from u_dw within u_tabpage_measurments_reports
end type
type gb_1 from u_gb within u_tabpage_measurments_reports
end type
end forward

global type u_tabpage_measurments_reports from u_tabpg
integer width = 3579
integer height = 1536
string text = "Reports"
string picturename = "DataWindow!"
cb_1 cb_1
cbx_remove_threshold cbx_remove_threshold
cb_run cb_run
cb_mail cb_mail
st_1 st_1
rb_physician_profile_comparison rb_physician_profile_comparison
rb_qa_physician_profile_report rb_qa_physician_profile_report
dw_report dw_report
gb_1 gb_1
end type
global u_tabpage_measurments_reports u_tabpage_measurments_reports

type variables
boolean ib_cancelbut_open 
long     il_total_rows
long     ll_complete

Datetime   idtm_start, idtm_finish

n_cst_datetime   inv_datetime


n_cst_report_helper invo_report_helper
protected:
string ls_primary_speciality,ls_department
long   il_hdr_id
long   il_facility_id
end variables

forward prototypes
protected subroutine of_set_report (string as_report_name)
public function integer of_set_hdr_id (long al_hdr_id)
public subroutine of_set_facility_id (long al_facility_id)
public subroutine of_remove_threshold ()
end prototypes

protected subroutine of_set_report (string as_report_name);
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

this.dw_report.setredraw( false)
this.dw_report.dataobject = as_report_name
this.dw_report.of_settransobject( sqlca)
this.dw_report.setredraw(true)
end subroutine

public function integer of_set_hdr_id (long al_hdr_id);
/****************************************************************************************************************
** [PUBLIC] EVENT   of_set_hdr_id
**--------------------------------------------------------------------------------------------------------------
** Description	:
**--------------------------------------------------------------------------------------------------------------
** Arguments	:	[long] al_hdr_id
**
**--------------------------------------------------------------------------------------------------------------
** Returns		:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author		:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/



il_hdr_id = al_hdr_id

return 1 
end function

public subroutine of_set_facility_id (long al_facility_id);


il_facility_id = al_facility_id
end subroutine

public subroutine of_remove_threshold ();
if dw_report.dataoBJECT = "d_rpt_pd_qa_detail" THEN
	IF cbx_remove_threshold.checked  THEN
			dw_report.Object.t_qa_measurement_threshold.Visible=FalsE
			dw_report.Object.qa_measurement_threshold.Visible=FalsE
		ELSE 
			dw_report.Object.t_qa_measurement_threshold.Visible=TRUE
			dw_report.Object.qa_measurement_threshold.Visible=TRUE
	END IF
END IF 

end subroutine

on u_tabpage_measurments_reports.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cbx_remove_threshold=create cbx_remove_threshold
this.cb_run=create cb_run
this.cb_mail=create cb_mail
this.st_1=create st_1
this.rb_physician_profile_comparison=create rb_physician_profile_comparison
this.rb_qa_physician_profile_report=create rb_qa_physician_profile_report
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cbx_remove_threshold
this.Control[iCurrent+3]=this.cb_run
this.Control[iCurrent+4]=this.cb_mail
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.rb_physician_profile_comparison
this.Control[iCurrent+7]=this.rb_qa_physician_profile_report
this.Control[iCurrent+8]=this.dw_report
this.Control[iCurrent+9]=this.gb_1
end on

on u_tabpage_measurments_reports.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cbx_remove_threshold)
destroy(this.cb_run)
destroy(this.cb_mail)
destroy(this.st_1)
destroy(this.rb_physician_profile_comparison)
destroy(this.rb_qa_physician_profile_report)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event constructor;call super::constructor;

//this.of_setresize( true)
end event

event destructor;call super::destructor;//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(invo_report_helper) then Destroy invo_report_helper
//---------------------------- APPEON END ----------------------------
end event

type cb_1 from uo_cb_output within u_tabpage_measurments_reports
integer x = 3072
integer y = 1404
integer height = 92
integer taborder = 20
end type

event clicked;m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'Mail'
NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(NewMenu.parentwindow.x + NewMenu.parentwindow.x  + 850, NewMenu.parentwindow.y + NewMenu.parentwindow.y + 175)

end event

event constructor;call super::constructor;

idw = parent.dw_report
end event

type cbx_remove_threshold from u_cbx within u_tabpage_measurments_reports
integer x = 1646
integer y = 1408
integer width = 823
integer height = 64
string text = "Remove Theshold from view."
end type

event clicked;call super::clicked;


of_remove_threshold()
end event

type cb_run from u_cb within u_tabpage_measurments_reports
integer x = 2656
integer y = 1404
integer taborder = 40
fontcharset fontcharset = ansi!
string text = "&Run"
end type

event clicked;call super::clicked;/****************************************************************************************************************
** [PUBLIC] EVENT	cb_run::clicked!
**--------------------------------------------------------------------------------------------------------------
** Description	:
**--------------------------------------------------------------------------------------------------------------
** Arguments	:	none
**--------------------------------------------------------------------------------------------------------------
** Returns		:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author		:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

long ll_active_status[]
string ls_prac_name
string ls_stataus
string ls_departmen
string ls_provider_id
string ls_apptmnt_start_date
string ls_last_reappointment_date
string ls_staff_category
string ls_division
long ll_department_code
long ll_null

setnull(ll_null)

ll_active_status[1] = 1
//ll_active_status[2] = 2
//ll_active_status[3] = 3
ll_active_status[4] = 4

if il_facility_id < 1 or isnull(il_facility_id) then
	of_messagebox( '', iw_parent.title , 'Please select a profile before running a report.', information!, ok!, 1)
	return 
end if

Parent.SetRedraw(false)				//Added by Scofield on 2008-04-30

n_cst_report_helper l_nvo 
l_nvo = create n_cst_report_helper
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 03.14.2006 By: LiuHongXin
//$<reason> The statement f1(Dynamic f2()) is unsupported. If a function is dynamically called,
//$<reason>  its return value cannot be passed as an argument of another function.
//$<modification> 1)Create a variable; 2)Specify the return of the function that is dynamically
//$<modification> called to the variable; 3)Use the variable as an argument.
/*
l_nvo.of_set_prac_header(iw_parent.DYNAMIC of_getprac_id(), &
														 ls_prac_name,  &
														 ls_stataus,  &
														 ls_department, &
														 ls_provider_id, &
														 ls_apptmnt_start_date,  &
														 ls_last_reappointment_date,&
														 ls_staff_category,  &
														 ls_division,  &
														 ls_primary_speciality, &
														 ll_department_code)

	
long ll_rowcount
ll_rowcount = parent.dw_report.retrieve(iw_parent.DYNAMIC of_getprac_id() ,& 
																			  il_facility_id,&
																			  ll_active_status,&
																			  il_hdr_id)

*/
long ll_prac_id
ll_prac_id = iw_parent.DYNAMIC of_getprac_id()

l_nvo.of_set_prac_header(ll_prac_id, &
								 ls_prac_name,  &
								 ls_stataus,  &
								 ls_department, &
								 ls_provider_id, &
								 ls_apptmnt_start_date,  &
								 ls_last_reappointment_date,&
								 ls_staff_category,  &
								 ls_division,  &
								 ls_primary_speciality, &
								 ll_department_code,il_facility_id) //Start Code Change ---- 10.04.2006 #675 maha added argument
								 
	
long ll_rowcount
ll_rowcount = parent.dw_report.retrieve(ll_prac_id ,& 
												  il_facility_id,&
												  ll_active_status,&
												  il_hdr_id)
//---------------------------- APPEON END ----------------------------
//messagebox('',ll_rowcount)

if  ll_rowcount > 0 then 
			 parent.dw_report.object.prac_name[1] = ls_prac_name
			 parent.dw_report.object.stataus[1] = ls_stataus
			 parent.dw_report.object.department_1[1] = ls_department
			 parent.dw_report.object.provider_id[1] = ls_provider_id
			 parent.dw_report.object.apptmnt_start_date[1] = ls_apptmnt_start_date
			 parent.dw_report.object.last_reappointment_date_1[1] = ls_last_reappointment_date
			 parent.dw_report.object.staff_category[1] = ls_staff_category
			 parent.dw_report.object.division[1] = ls_division
			 parent.dw_report.object.primary_speciality[1] = ls_primary_speciality
          parent.dw_report.object.report_name_1[1] = parent.dw_report.Describe("DataWindow.Print.DocumentName")
END IF

 
destroy l_nvo

parent.setredraw(true)
end event

type cb_mail from u_cb within u_tabpage_measurments_reports
boolean visible = false
integer x = 3200
integer y = 24
integer taborder = 30
fontcharset fontcharset = ansi!
string text = "&Mail"
end type

event clicked;
parent.dw_report.event ue_save_pdf_for_mailing( )

parent.dw_report.event ue_mail( 'Measurement Report','')
end event

type st_1 from statictext within u_tabpage_measurments_reports
boolean visible = false
integer y = 1408
integer width = 1609
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean focusrectangle = false
end type

type rb_physician_profile_comparison from u_rb within u_tabpage_measurments_reports
integer x = 1029
integer y = 72
integer width = 914
integer height = 68
string text = "Physician Profile Comparison"
end type

event clicked;call super::clicked;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  today()
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/



long ll_count
long ll_prac_id

ll_prac_id = iw_parent.DYNAMIC of_getprac_id()

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2005-11-03 By: Zhang Lingping
//$<reason> This valuable has same name with instance valuable. must be 
//$<reason> comment out
// n_cst_datetime inv_datetime
//---------------------------- APPEON END ----------------------------



select count(*) 
into :ll_count 
from pd_affil_dept 
where prac_id = :ll_prac_id and primary_dept = 1;



if ll_count < 1 then 
	If gs_cust_type <> 'I' Then	//Added By Ken.Guo 05.27.2008.IntelliAPP should not show tabpage_apptmnt_status.
		if messagebox('QA Profile Reports', 'This report cannot be run because the practitioner is not associated with a PRIMARY department.' + &
							'Would you like to do this now?',question!,YesNo!,1) = 1 then
							
			if not isvalid(	w_prac_data_1) THEN
					W_MDI.EVENT pfc_cst_practitioner()
			end if
			If isvalid(w_prac_data_1) Then //Added By Ken.Guo 05.27.2008
				inv_datetime.of_Wait(1)
				w_prac_data_1.TAB_1.TABpage_search.UO_search.sle_srch_val.text = string(ll_prac_id)
				w_prac_data_1.TAB_1.TABpage_search.UO_search.ddlb_search_type.SelectItem ('I.D.',1 )
				w_prac_data_1.TAB_1.TABpage_search.UO_search.cb_search.event clicked( )
				w_prac_data_1.TAB_1.TABpage_search.UO_search.cb_select.event clicked( )
				w_prac_data_1.BringToTop = TRUE
				inv_datetime.of_Wait(2)
				w_prac_data_1.tab_1.SelectTab ( 4 )
				w_prac_data_1.tab_1.tabpage_apptmnt_status.uo_affill_status.tab_view.Post SelectTab ( 3)
			End If	
		end if
	Else
		//Added By Ken.Guo 05.27.2008. For IntelliApp
		Messagebox('QA Profile Reports', 'This report cannot be run because the practitioner is not associated with a PRIMARY department.')
	End If					
	Return 
end if




parent.of_set_report( 'd_rpt_pd_qa_detail_comparison')

cbx_remove_threshold.visible =false //Start Code Change ---- 10.04.2006 #676 maha changed from enabled
end event

type rb_qa_physician_profile_report from u_rb within u_tabpage_measurments_reports
integer x = 59
integer y = 72
integer width = 832
integer height = 68
string text = "QA Physician Profile Report"
boolean checked = true
end type

event clicked;call super::clicked;

parent.of_set_report( 'd_rpt_pd_qa_detail')


cbx_remove_threshold.visible = true //Start Code Change ---- 10.04.2006 #677 maha changed from enabled
end event

type dw_report from u_dw within u_tabpage_measurments_reports
event pfc_cst_print_net_dev_report ( )
event ue_mail_current ( )
integer y = 192
integer width = 3511
integer height = 1184
integer taborder = 10
string dataobject = "d_rpt_pd_qa_detail"
boolean hsplitscroll = true
boolean ib_isupdateable = false
end type

event ue_mail_current();
Super::EVENT ue_save_pdf_for_mailing( )

//releasecapture( )

//Start Code Change ----10.09.2008 #V85 maha -  readded option to use outlook email
if  gi_email_type = 1 then //Start Code Change ----12.11.2012 #V12 maha
	Super::EVENT ue_mail('Profile Report','' )
else
	Super::EVENT ue_mail('Profile Report','' )
end if
//End Code Change---10.09.2008
end event

event constructor;call super::constructor;this.of_SetReport(TRUE)



end event

event retrievestart;call super::retrievestart;/****************************************************************************************************************
** [PUBLIC] Event retrievestart in u_report_run_tabpage inherited from u_tabpg
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		Date: Friday, June 15, 2001    10:01:54
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	

** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------


****************************************************************************************************************/


//powerobject l_userobject
//l_userobject = parent
//reset()
//
//n_cst_sql nv_cst_sql
//
//
//
//ib_cancelbut_open = true
//
//
//
//setredraw(false)
//
//// get the count(*)
//il_total_rows  = nv_cst_sql.of_get_count(dw_report)
//
////if il_total_rows >  200 THEN
////	OpenwithParm(w_cancel_button,l_userobject)
////END IF
//
//idtm_start = DateTime(Today( ), Now( ) )
//


end event

event retrieveend;call super::retrieveend;/****************************************************************************************************************
** [PUBLIC] Event retrieveend in u_report_run_tabpage inherited from u_tabpg
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] long rowcount      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		Date: Friday, June 15, 2001    10:02:22
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	

** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------


****************************************************************************************************************/

invo_report_helper = create n_cst_report_helper


Long ll_between

idtm_finish = DateTime(Today( ), Now( ) )

if ib_cancelbut_open then
	ib_cancelbut_open = false
end if

if IsValid(w_cancel_button) then	
	Close(w_cancel_button)
end if 
//////////////////////////////////////////////////////////////////////////////////////////////
// Display the time it took to do the query
//////////////////////////////////////////////////////////////////////////////////////////////

ll_between = inv_datetime.of_SecondsAfter (idtm_start, idtm_finish)

if ll_between = 0 then
	ll_between = inv_datetime.of_MilliSecsAfter(time(idtm_start), time(idtm_finish))
	st_1.text = "Rows Retrieved: " + string(rowcount) + "     " + "In: " +  string(ll_between/1000, '0.#######')  + '  ' +"second"
else
	st_1.text = "Rows Retrieved: " + string(rowcount) + "    " + "In : " +  string(ll_between,'#######.00')  + '  ' +"seconds"
end if

//////////////////////////////////////////////////////////////////////////////////////////////
// modify comment text
//////////////////////////////////////////////////////////////////////////////////////////////

//if this.rowcount() > 0 then
//	thsi.setItem(1,'t_comment', g_const.is_report_text)
//end if 

of_remove_threshold()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<add> 01.13.2006 By: Liang QingShi
//$<reason> The RetrieveRow event of DataWindow control is currently unsupported.
//$<modification> Add the following script to provide the same functionality that
//$<modification> RetrieveRow event has.
if IsValid(w_cancel_button) then	
	w_cancel_button.st_count.text = String(This.RowCount( ))
	w_cancel_button.st_4.text = 'of ' + String(il_total_rows)
	w_cancel_button.st_2.text = String((This.RowCount( )/il_total_rows) * 100, "##.000") 	
end if
//---------------------------- APPEON END ----------------------------
setredraw(true)



end event

event retrieverow;call super::retrieverow;/****************************************************************************************************************
** [PUBLIC] Event retrieverow in u_report_run_tabpage inherited from u_tabpg
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	
**
**	[value] long row      <Description>
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	MSKINNER		Date: Friday, June 15, 2001    10:01:35
**--------------------------------------------------------------------------------------------------------------
** Modification Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------


****************************************************************************************************************/
//
//// Display a running count of rows retrieved
//if IsValid(w_cancel_button) then	
//	w_cancel_button.st_count.text = String(This.RowCount( ))
//	w_cancel_button.st_4.text = 'of ' + String(il_total_rows)
//	w_cancel_button.st_2.text = String((This.RowCount( )/il_total_rows) * 100, "##.000") 
//	
//end if
//
//if ib_cancelbut_open = false then 
//	return 1
//end if
end event

event sqlpreview;call super::sqlpreview;



//messagebox('',sqlsyntax)
end event

event pfc_print;
DW_REPORT.Object.DataWindow.Zoom = 100
SUPER::event pfc_print( )

RETURN 0
end event

type gb_1 from u_gb within u_tabpage_measurments_reports
integer width = 3511
integer height = 164
integer taborder = 10
string text = "Report Selection"
end type

