$PBExportHeader$n_cst_report_helper.sru
forward
global type n_cst_report_helper from nonvisualobject
end type
end forward

global type n_cst_report_helper from nonvisualobject
end type
global n_cst_report_helper n_cst_report_helper

type variables
n_ds ids_prac_profile
end variables

forward prototypes
public function integer of_get_profile_group_name (long al_profile_group_measurement_id, long al_facility_id, long al_prac_id, long as_department, string as_specialty, ref decimal ldc_total_by_department, ref decimal ldc_total_by_speciality, ref decimal ldc_total_by_hospital, ref long al_group_name)
public function long of_set_prac_header (long al_prac_id, ref string al_prac_name, ref string al_stataus, ref string as_department, ref string al_provider_id, ref string adt_apptmnt_start_date, ref string adt_last_reappointment_date, ref string as_staff_category, ref string as_division, ref string as_primary_speciality, ref long al_department_code, long al_facil)
end prototypes

public function integer of_get_profile_group_name (long al_profile_group_measurement_id, long al_facility_id, long al_prac_id, long as_department, string as_specialty, ref decimal ldc_total_by_department, ref decimal ldc_total_by_speciality, ref decimal ldc_total_by_hospital, ref long al_group_name);//STRING LS_GROUP_NAME
//dec 	ldc_total_by_department, ldc_total_by_speciality, ldc_total_by_hospital 
	
	SELECT distinct QPG.qa_profile_group_name   
	  INTO :al_GROUP_NAME
     FROM pd_qa_hdr  PQH ,   
		 	 pd_qa_measurements PQM ,   
			 qa_measurement QM ,   
			 qa_profile_group QPG,   
			 qa_profile  QP 
	 WHERE ( PQH.pd_qa_hdr_id = PQM.pd_qa_hdr_id ) 											and  
		 	 ( PQM.profile_group_measurement_id = QM.profile_group_measurement_id ) and  
			 ( QPG.qa_profile_group_id = QM.qa_profile_group_id )                   and  
			 ( QPG.qa_profile_id = QM.qa_profile_id )                               and  
			 ( QP.qa_profile_id = QPG.qa_profile_id )                               and  
			 ( PQH.prac_id = :al_prac_id)                                           AND  
			 ( QP.facility_id = :al_facility_id  )                                  AND  
			 ( PQH.active_status = 1 ) 														   AND  
			 ( PQM.profile_group_measurement_id = :al_profile_group_measurement_id ) ;
			 
	messagebox('', al_GROUP_NAME)	 
			 
     SELECT  AVG(PQM.measurement_value) 
	  into    :ldc_total_by_department
	  FROM    pd_basic PB ,   
				 pd_qa_measurements PQM,   
				 pd_qa_hdr PQH ,   
				 pd_affil_dept PAD 
		WHERE ( PQH.pd_qa_hdr_id = PQM.pd_qa_hdr_id ) 								and  
				( PQH.prac_id = PB.prac_id ) 												and  
				( PQH.prac_id = PAD.prac_id ) 											and  
				( PAD.DEPARTMENT = :as_department  ) 									AND
				( PAD.primary_dept = 1 ) 													AND  
				( PQM.profile_group_measurement_id = :al_profile_group_measurement_id ) ;
																
																
select AVG(PQM.measurement_value)
into :ldc_total_by_speciality
FROM pd_basic PB ,   
 	  pd_board_specialty PBS,   
	  pd_qa_measurements PQM ,   
	  pd_qa_hdr  PQH
WHERE ( PQH.pd_qa_hdr_id = PQM.pd_qa_hdr_id ) and  
		( PQH.prac_id = PB.prac_id ) and  
		( PB.prac_id = PBS.prac_id ) and  
		( PBS.specialty_order = 10041 ) AND  
		( PBS.specialty = :as_specialty )  AND
		( PQM.profile_group_measurement_id = :al_profile_group_measurement_id );
		
		
SELECT avg(PQM.measurement_value)
into :ldc_total_by_hospital
FROM   pd_qa_measurements PQM, 
       qa_measurement QM,
		 qa_profile QP,   
		 qa_profile_group QPG   ,   
		 pd_qa_hdr PQH 
WHERE ( QM.qa_profile_id = QP.qa_profile_id ) and  
		( QPG.qa_profile_id = QP.qa_profile_id ) and  
		( QPG.qa_profile_group_id = QM.qa_profile_group_id ) and  														         
		( QPG.qa_profile_id = PQH.qa_profile_id ) and  
	 	(PQM.profile_group_measurement_id = QM.profile_group_measurement_id) and
		(QP.facility_id = :al_facility_id) AND  
		(PQH.active_status = 1 ) and
		(PQM.profile_group_measurement_id = :al_profile_group_measurement_id );




	return 1
end function

public function long of_set_prac_header (long al_prac_id, ref string al_prac_name, ref string al_stataus, ref string as_department, ref string al_provider_id, ref string adt_apptmnt_start_date, ref string adt_last_reappointment_date, ref string as_staff_category, ref string as_division, ref string as_primary_speciality, ref long al_department_code, long al_facil);//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_set_prac_header
//==================================================================================================================
//  Purpose   	: This function will set Header information for a report
//==================================================================================================================
//  Arguments 	: [long] 		VALUE	al_prac_id    		- The practitioner ID
//               [long]  		REf 	al_prac_name  		- The practiter Name
//					  [long]	 		REf  	al_stataus
//               [string] 		REf  	as_department
//               [long] 		REf 	al_provider_id
//               [datetime]	REf   adt_apptmnt_start_date
//               [datetime]	REf	adt_Last_Reappointment_Date
//   				  [string]		REf   as_staff_category
// 				  [string]		REf   as_division
// 				  [string]		REf   as_Primary_Speciality
// 
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
//
//Start Code Change ---- 10.04.2006 #674 maha
long ll_department
LONG  ll_row
STRING LS_DATEFORMAT
integer i

ids_prac_profile = CREATE n_ds
ids_prac_profile.dataobject = 'd_rpt_qa_physician_profile_report'
ids_prac_profile.of_settransobject(sqlca)
i = ids_prac_profile.retrieve(al_prac_id,al_facil)  //maha 081706  added facility param

if i < 1 then
	messagebox("Report Error","Unable to retrieve header data.  Check for Primary Address.")
	return 1
end if
//End Code Change---08.25.2006
LS_DATEFORMAT = 'mm/dd/yyyy'

IF ids_prac_profile.ROWcount( ) < 1 THEN RETURN 1



ll_row = 1 // there is only one row

al_prac_name  		 				= string(ids_prac_profile.object.NAME[ll_row] )
al_stataus 							= string(ids_prac_profile.object.active_status[ll_row] )
as_department  				 	= ids_prac_profile.object.department[ll_row] 


al_provider_id   					= string(ids_prac_profile.object.pd_basic_provider_id[ll_row] )
adt_apptmnt_start_date 			= string(ids_prac_profile.object.app_data[ll_row],LS_DATEFORMAT )


if LeftA(trim(string(ids_prac_profile.object.prior_appt_start[ll_row])),2) = 'No' then
    adt_Last_Reappointment_Date	= string(ids_prac_profile.object.prior_appt_start[ll_row] )
else 
	adt_Last_Reappointment_Date	= string(date(ids_prac_profile.object.prior_appt_start[ll_row]) , LS_DATEFORMAT)
end if
as_staff_category 				= string(ids_prac_profile.object.staff_category[ll_row] )
as_division  						= string(ids_prac_profile.object.division[ll_row] )
as_Primary_Speciality 			= string(ids_prac_profile.object.specialty[ll_row] )
//al_department_code            = (ids_prac_profile.object.pd_affil_dept_department[ll_row] )




return 1 


end function

on n_cst_report_helper.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_report_helper.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2005-11-03 By: Zhang Lingping
//$<reason> This varable has same name with instance valuable.

//n_ds ids_prac_profile
//---------------------------- APPEON END ----------------------------


end event

