$PBExportHeader$w_qa_profile_setup.srw
forward
global type w_qa_profile_setup from w_master
end type
type cb_delprof from commandbutton within w_qa_profile_setup
end type
type cb_addprof from commandbutton within w_qa_profile_setup
end type
type p_1 from picture within w_qa_profile_setup
end type
type cb_delete_measurement from u_cb within w_qa_profile_setup
end type
type cb_create_measurement from u_cb within w_qa_profile_setup
end type
type cb_copy from u_cb within w_qa_profile_setup
end type
type cb_1 from u_cb within w_qa_profile_setup
end type
type cb_save from u_cb within w_qa_profile_setup
end type
type cb_preview from u_cb within w_qa_profile_setup
end type
type cb_close from u_cb within w_qa_profile_setup
end type
type dw_category from u_dw within w_qa_profile_setup
end type
type dw_measurements from u_dw within w_qa_profile_setup
end type
type dw_profile from u_dw within w_qa_profile_setup
end type
end forward

global type w_qa_profile_setup from w_master
integer width = 4041
integer height = 2480
cb_delprof cb_delprof
cb_addprof cb_addprof
p_1 p_1
cb_delete_measurement cb_delete_measurement
cb_create_measurement cb_create_measurement
cb_copy cb_copy
cb_1 cb_1
cb_save cb_save
cb_preview cb_preview
cb_close cb_close
dw_category dw_category
dw_measurements dw_measurements
dw_profile dw_profile
end type
global w_qa_profile_setup w_qa_profile_setup

type variables
long il_qa_profile_id
end variables

event open;call super::open;dw_profile.retrieve()
end event

on w_qa_profile_setup.create
int iCurrent
call super::create
this.cb_delprof=create cb_delprof
this.cb_addprof=create cb_addprof
this.p_1=create p_1
this.cb_delete_measurement=create cb_delete_measurement
this.cb_create_measurement=create cb_create_measurement
this.cb_copy=create cb_copy
this.cb_1=create cb_1
this.cb_save=create cb_save
this.cb_preview=create cb_preview
this.cb_close=create cb_close
this.dw_category=create dw_category
this.dw_measurements=create dw_measurements
this.dw_profile=create dw_profile
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_delprof
this.Control[iCurrent+2]=this.cb_addprof
this.Control[iCurrent+3]=this.p_1
this.Control[iCurrent+4]=this.cb_delete_measurement
this.Control[iCurrent+5]=this.cb_create_measurement
this.Control[iCurrent+6]=this.cb_copy
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_save
this.Control[iCurrent+9]=this.cb_preview
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.dw_category
this.Control[iCurrent+12]=this.dw_measurements
this.Control[iCurrent+13]=this.dw_profile
end on

on w_qa_profile_setup.destroy
call super::destroy
destroy(this.cb_delprof)
destroy(this.cb_addprof)
destroy(this.p_1)
destroy(this.cb_delete_measurement)
destroy(this.cb_create_measurement)
destroy(this.cb_copy)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.cb_preview)
destroy(this.cb_close)
destroy(this.dw_category)
destroy(this.dw_measurements)
destroy(this.dw_profile)
end on

type cb_delprof from commandbutton within w_qa_profile_setup
integer x = 1042
integer y = 40
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Profile"
end type

type cb_addprof from commandbutton within w_qa_profile_setup
integer x = 654
integer y = 40
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Profile"
end type

type p_1 from picture within w_qa_profile_setup
boolean visible = false
integer x = 73
integer y = 20
integer width = 87
integer height = 64
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type cb_delete_measurement from u_cb within w_qa_profile_setup
string tag = "Delete the selected measurement."
integer x = 2880
integer y = 764
integer width = 494
integer height = 84
integer taborder = 20
fontcharset fontcharset = ansi!
string text = "Delete Measurement"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_count
long ll_profile_id

if  dw_profile.rowcount( ) < 1 then return 

////////////////////////////////////////////////////////////////////
// check to see if this group id is being used 
////////////////////////////////////////////////////////////////////

ll_profile_id = parent.dw_measurements.object.group_measurement_id[parent.dw_measurements.getRow()]

select count(*) 
into  :ll_count
from  pd_qa_measurements
where profile_group_measurement_id = :ll_profile_id;




if ll_count > 0  then
	Messagebox('Existing Records','There are records that reference this information. This measurement cannot be deleted!')
	return -1
else
	parent.dw_measurements.event pfc_deleterow( )

end if

return 1





end event

type cb_create_measurement from u_cb within w_qa_profile_setup
string tag = "Add a measurement."
integer x = 2377
integer y = 768
integer width = 494
integer height = 84
integer taborder = 20
string text = "Add Metrics"
end type

event clicked;//Start Code Change ----12.18.2009 #V10 maha
gs_variable_array lst_array
long ll_ids[]
long i
long r
long nr
long ll_met
long ll_meas_id
integer li_found


open(w_qa_metric_select)

if message.stringparm = "Cancel" then
	return
else
	select max(profile_group_measurement_id)   into :ll_meas_id from qa_measurement;
	if isnull(ll_meas_id) then ll_meas_id = 0
	lst_array = message.powerobjectparm
	ll_ids = lst_array.as_number
	for i = 1 to upperbound(ll_ids)
		ll_met = ll_ids[i]
		li_found = dw_measurements.find("qa_metric_id = " + string(ll_met), 1,100000)
		if li_found > 0 then
			//skip add
		elseif li_found < 0 then
			messagebox("Find Error","Contact ISG Development")
		else //add record
			nr = dw_measurements.insertrow(0)
			ll_meas_id++
			dw_measurements.setitem(nr,"group_measurement_id",ll_meas_id)
			dw_measurements.setitem(nr,"qa_metric_id",ll_meas_id)
			dw_measurements.setitem(nr,"profile_group_id",0)
			dw_measurements.setitem(nr,"qa_profile_id",il_qa_profile_id)
			dw_measurements.setitem(nr,"category",lst_array.as_string[i] )
		end if
	next
end if

dw_measurements.update()
dw_measurements.retrieve(il_qa_profile_id)
 			
			
			
end event

type cb_copy from u_cb within w_qa_profile_setup
string tag = "Copy this profile to another facility."
integer x = 1938
integer y = 40
integer width = 343
integer taborder = 40
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "&Copy"
end type

event clicked;call super::clicked;///****************************************************************************************************************
//** [PUBLIC] EVENT/FUNCTION selectionchanged :: UO_TAB_MEASUREMENTS
//**--------------------------------------------------------------------------------------------------------------
//** Description    : copy existing profile 
//**--------------------------------------------------------------------------------------------------------------
//** Arguments	   :	[NONE] 
//**--------------------------------------------------------------------------------------------------------------
//** Returns		   :	[NONE]
//**--------------------------------------------------------------------------------------------------------------
//** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
//**--------------------------------------------------------------------------------------------------------------
//** ModIFication Log:	
//**
//** Date            Who                   Change  	
//**--------------------------------------------------------------------------------------------------------------
//**
//**
//****************************************************************************************************************/
//
//long il_profile_id 				// old profile id
//long il_profile_id_new 			// new profile id
//long ll_group_id 					// old group id
//long ll_group_id_new 			// new group id
//long ll_count,ll_i,ll_j 		// counters
//long ll_group_measurement_id 	// measurement id
//string ls_filter 					// filter string
//// datastore datawindows
//string ls_datawindows[] = {'d_qa_profile_copy','d_qa_profile_group','d_qa_profile_group_measurements_copy'} 
//ls_filter = 'profile_group_id = ' 
//n_ds lds_array[] 
//
//if dw_profile.rowcount() < 1 then return 
//
//
//
//setnull(ll_group_measurement_id)
//setnull(ll_group_id_new)
//// STRUCTURES
//str_pass lstr_pass
//// DATASTORES
//n_ds lds_profile
//n_ds lds_group
//n_ds lds_measurement
//// create the array
//lds_array[upperbound(lds_array) + 1] = lds_profile
//lds_array[upperbound(lds_array) + 1] = lds_group
//lds_array[upperbound(lds_array) + 1] = lds_measurement
//
//// CREATE THE DATASTORES, ASSIGN DATAOBJECT,SETTRANSOBJECT
//for ll_count = 1 to upperbound(lds_array)
//	 lds_array[ll_count] = CREATE N_DS
//	 lds_array[ll_count].dataobject = ls_datawindows[ll_count]
//	 lds_array[ll_count].of_settransobject( sqlca)
//next
//
//il_profile_id = dw_profile.object.qa_profile_id[dw_profile.GETROW()]
//// CREATE THE DATASTORES BASED IN THE QA_PROFILE_ID
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-02
////$<modify> 03.21.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
///*
//for ll_count = 1 to upperbound(lds_array)
//	 lds_array[ll_count].retrieve(il_profile_id)
//next
//*/
//gnv_appeondb.of_startqueue( )
//
//for ll_count = 1 to upperbound(lds_array)
//	 lds_array[ll_count].retrieve(il_profile_id)
//next
//
//gnv_appeondb.of_commitqueue( )
////---------------------------- APPEON END ----------------------------
//
//if lds_array[1].rowcount() < 1 and lds_array[2].rowcount() < 1 THEN return -1
//
//// prompt the user for a new facility id/ profile name
//lstr_pass.s_string = string(il_profile_id)
//openwithparm(w_facility_view,lstr_pass)
//lstr_pass = message.powerobjectparm
//if isnull(lstr_pass.s_string) then
//	return 
//end if
//// Get a new qa profile id
//il_profile_id_new = parent.of_getsequence_number( )
//
//// Get the group id from lds_group filter both lds_array[2] and lds_array[3] for each row in lds_array[2]
//FOR ll_i = 1 TO lds_array[2].rowcount()
//	 ll_group_id =  lds_array[2].object.profile_group_id[ll_i]
//	  // FILTER
//	 lds_array[3].setfilter(ls_filter + string(ll_group_id))
//	 lds_array[3].filter()
//	 // get a new group_id
//	 if isnull(ll_group_id_new) then
//	 		ll_group_id_new = dw_category.event ue_get_sequence_number( ) + 1
//		else 
//			ll_group_id_new = ll_group_id_new + 1
//	 end if
//	 // set the ID on the lds_array[2] datastore
//	 lds_array[2].object.profile_group_id[ll_i] = ll_group_id_new
//	 lds_array[2].object.qa_profile_id[ll_i] = il_profile_id_new
//	 FOR ll_j = 1 TO  lds_array[3].rowcount()
//			if isnull(ll_group_measurement_id) then
//				ll_group_measurement_id = dw_measurements.event ue_get_sequence_number( )
//	  			else
//				ll_group_measurement_id = ll_group_measurement_id + 1
//	 		end if
//			
//			lds_array[3].object.profile_group_id[ll_j] 		= ll_group_id_new
//			lds_array[3].object.group_measurement_id[ll_j]  = ll_group_measurement_id
//		   lds_array[3].object.qa_profile_id[ll_j] 			= il_profile_id_new
//	 NEXT
//
//NEXT	
//
//// SET THE DATA IN THE HEADER DATASTORE
//lds_array[1].object.qa_profile_id[1] = il_profile_id_new 
//lds_array[1].object.profile_name[1] = lstr_pass.s_string
//lds_array[1].object.facility_id[1] = lstr_pass.l_facility_id
//
//// clear filters
//for ll_count = 1 to upperbound(lds_array)
//	lds_array[ll_count].setfilter('')
//	lds_array[ll_count].filter()
//next 
//
//// set to new modifiled for insert 
//for ll_count = 1 to upperbound(lds_array)
//	of_set_insert( lds_array[ll_count])
//next 
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-03
////$<modify> 03.21.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
///*
//// UPDATE
//for ll_count = 1 to upperbound(lds_array)
//	of_update(lds_array[ll_count] )
//next 
//// DESTROY THE DATA STORES
//for ll_count = 1 to upperbound(lds_array)
//	DESTROY  lds_array[ll_count]
//next 
//// RETRIEVE THE HEADER
//dw_profile.retrieve()
//*/
//gnv_appeondb.of_startqueue( )
//
//for ll_count = 1 to upperbound(lds_array)
//	of_update(lds_array[ll_count] )
//next 
//
//dw_profile.retrieve()
//
//gnv_appeondb.of_commitqueue( )
//
//for ll_count = 1 to upperbound(lds_array)
//	DESTROY  lds_array[ll_count]
//next 
////---------------------------- APPEON END ----------------------------
//
//dw_profile.scrolltorow( dw_profile.rowcount())
//dw_profile.selectrow( dw_profile.rowcount(), true)
//
end event

type cb_1 from u_cb within w_qa_profile_setup
string tag = "Copy this profile to another facility."
integer x = 1559
integer y = 40
integer width = 343
integer taborder = 30
fontcharset fontcharset = ansi!
string text = "Metrics Painter"
end type

event clicked;call super::clicked;open(w_qa_metrics)
end event

type cb_save from u_cb within w_qa_profile_setup
string tag = "Save the new data."
integer x = 2304
integer y = 40
integer width = 343
integer taborder = 20
boolean enabled = false
string text = "&Save"
end type

type cb_preview from u_cb within w_qa_profile_setup
string tag = "Preview the data."
integer x = 2670
integer y = 40
integer width = 343
integer taborder = 10
boolean enabled = false
string text = "&Preview"
end type

event clicked;call super::clicked;



long ll_found_row
parent.cb_save.event clicked( )


ll_found_row = parent.dw_profile.FIND( 'qa_profile_id = ' + string(il_qa_profile_id) , 1,parent.dw_profile.rowcount())

parent.dw_profile.SCROLLTOrow(ll_found_row)

openwithparm(w_report_preview, il_qa_profile_id )
end event

type cb_close from u_cb within w_qa_profile_setup
string tag = "Close the window"
integer x = 3031
integer y = 40
integer width = 343
integer taborder = 10
string text = "&Close"
boolean default = true
end type

event clicked;call super::clicked;close(parent)
end event

type dw_category from u_dw within w_qa_profile_setup
integer x = 133
integer y = 868
integer width = 786
integer height = 1420
integer taborder = 30
string dataobject = "d_qa_profile_categories"
end type

event constructor;call super::constructor;this.settransobject(sqlca)
end event

type dw_measurements from u_dw within w_qa_profile_setup
integer x = 974
integer y = 864
integer width = 2953
integer height = 1432
integer taborder = 20
string dataobject = "d_qa_measurement_new"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.settransobject(sqlca)

end event

type dw_profile from u_dw within w_qa_profile_setup
integer x = 123
integer y = 140
integer width = 3259
integer height = 600
integer taborder = 10
string dataobject = "d_qa_profile"
end type

event clicked;call super::clicked;il_qa_profile_id = this.getitemnumber( row, "qa_profile_id")
end event

event constructor;this.settransobject(sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;dw_category.retrieve(il_qa_profile_id )
dw_measurements.retrieve(il_qa_profile_id )
end event

