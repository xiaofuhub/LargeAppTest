$PBExportHeader$w_reappointment_measurements.srw
forward
global type w_reappointment_measurements from w_response
end type
type cb_2 from u_cb within w_reappointment_measurements
end type
type cb_3 from u_cb within w_reappointment_measurements
end type
type cb_1 from u_cb within w_reappointment_measurements
end type
type cb_copy from u_cb within w_reappointment_measurements
end type
type dw_measurements from u_dw within w_reappointment_measurements
end type
type dw_category from u_dw within w_reappointment_measurements
end type
type dw_profile from u_dw within w_reappointment_measurements
end type
type cb_delete_measurement from u_cb within w_reappointment_measurements
end type
type cb_create_measurement from u_cb within w_reappointment_measurements
end type
type cb_delete_profile from u_cb within w_reappointment_measurements
end type
type cb_create_profile from u_cb within w_reappointment_measurements
end type
type cb_close from u_cb within w_reappointment_measurements
end type
type cb_preview from u_cb within w_reappointment_measurements
end type
type cb_save from u_cb within w_reappointment_measurements
end type
type gb_profile from u_gb within w_reappointment_measurements
end type
type gb_measurements from u_gb within w_reappointment_measurements
end type
type gb_measurement_group from u_gb within w_reappointment_measurements
end type
end forward

global type w_reappointment_measurements from w_response
integer width = 4370
integer height = 2280
string title = "QA Profile Design"
long backcolor = 33551856
event ue_new ( )
event ue_retrieve ( )
event ue_set_to_current_profile ( )
cb_2 cb_2
cb_3 cb_3
cb_1 cb_1
cb_copy cb_copy
dw_measurements dw_measurements
dw_category dw_category
dw_profile dw_profile
cb_delete_measurement cb_delete_measurement
cb_create_measurement cb_create_measurement
cb_delete_profile cb_delete_profile
cb_create_profile cb_create_profile
cb_close cb_close
cb_preview cb_preview
cb_save cb_save
gb_profile gb_profile
gb_measurements gb_measurements
gb_measurement_group gb_measurement_group
end type
global w_reappointment_measurements w_reappointment_measurements

type variables


long il_qa_profile_id // the current profile
long il_qa_profile_id_saved 
end variables

forward prototypes
public function integer of_getsequence_number ()
public function boolean of_check_for_groups (long al_profile_id)
public subroutine of_setfocus (u_dw adw, string as_column)
public function integer of_set_insert (ref n_ds ads)
public function integer of_update (n_ds ads)
end prototypes

event ue_new();//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  [PUBLIC]   : ue_new::w_reappointment_measurement
////==================================================================================================================
////  Purpose   	: 
////==================================================================================================================
////  Arguments 	: [none] 
////==================================================================================================================
////  Returns   	: [none]     
////==================================================================================================================
////  Notes     	:     
////==================================================================================================================
////  Created By	: Michael Skinner  Thursday  October 14, 2004
////==================================================================================================================
////  Modification Log
////   Changed By             Change Date                                               Reason
//// ------------------------------------------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//
//
//this.of_accepttext( true)
//
if this.of_updatespending( ) > 0 then
	if messagebox(this.title,'Do you want to save changes?',question!,yesno!) = 1 then
		if this.event pfc_save( ) < 0 then
			return
		end if
	end if
end if
//
//
////clear out the old data
this.dw_category.reset( )
this.dw_measurements.reset( )
//this.dw_profile.reset( )
//
////
//// turn off the row manager stuff so that validation messages will
//// not pop  up
////this.dw_measurement_group.of_SetRowManager(false)
////this.dw_measurements.of_SetRowManager(false)
////this.dw_profile.of_SetRowManager(false)
//
//
//// add the new rows
this.dw_profile.event pfc_addrow( )
//this.dw_measurement_group.event pfc_addrow( )
//this.dw_measurements.event pfc_addrow( )
//
////this.dw_measurement_group.of_SetRowManager(true)
////this.dw_measurements.of_SetRowManager(true)
////this.dw_profile.of_SetRowManager(true)
//
//of_setfocus(dw_profile,'profile_name')
//
//
//
//
//
end event

event ue_set_to_current_profile();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_set_to_current_profile
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

///////////////////////////////////////////////
// set the focus to the profile we werer just on
//////////////////////////////////////////////////

setredraw( false)
long ll_found
if not isnull(il_qa_profile_id_saved) then
		ll_found = dw_profile.Find("qa_profile_id = " + string(il_qa_profile_id) ,1, dw_profile.RowCount())
		dw_profile.setfocus( )
		dw_profile.setrow(ll_found)
		dw_profile.scrolltorow( ll_found)
		dw_profile.setcolumn('profile_name')
	else
//		dw_profile.setfocus( )
//		dw_profile.setrow(dw_profile.rowcount())
//		dw_profile.scrolltorow( dw_profile.rowcount())
//		dw_profile.setcolumn('profile_name')
	end if 
	

setredraw( true)

end event

public function integer of_getsequence_number ();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_getsequence_number
//==================================================================================================================
//  Purpose   	: gets the next primary key value
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	:  Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."qa_profile"."qa_profile_id")
//INTO :ll_max_count 
//FROM "dba"."qa_profile"  ;

SELECT max(qa_profile.qa_profile_id)
INTO :ll_max_count 
FROM qa_profile  ;

//---------------------------- APPEON END ----------------------------
if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1

end function

public function boolean of_check_for_groups (long al_profile_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_measurements::of_check_for_groups
//==================================================================================================================
//  Purpose   	: checks to see if there are any groups
//==================================================================================================================
//  Arguments 	: [long]    al_profile_id
//==================================================================================================================
//  Returns   	: [boolean]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



n_ds lds_datastore
lds_datastore = create n_ds
lds_datastore.dataobject = 'd_qa_profile_group'
lds_datastore.of_settransobject( sqlca)
lds_datastore.retrieve(AL_profile_id)


if lds_datastore.rowcount() > 0 then 
	return false
end if

return true
end function

public subroutine of_setfocus (u_dw adw, string as_column);



if adw.rowcount() > 0 then
			setredraw(false)
			adw.setfocus()
			adw.SetRow ( adw.rowcount() )
			adw.SetColumn(as_column)
			setredraw(true)
end if 

end subroutine

public function integer of_set_insert (ref n_ds ads);

/****************************************************************************************************************
** [PUBLIC] FUNCTION  :: of_set_insert
**--------------------------------------------------------------------------------------------------------------
** Description    : Modify the data window so that it will insert
**--------------------------------------------------------------------------------------------------------------
** Arguments	   :	[NONE] 
**--------------------------------------------------------------------------------------------------------------
** Returns		   :	[NONE]
**--------------------------------------------------------------------------------------------------------------
** Author/Date    :	Michael B. Skinner / Wednesday , 17 November 2004 
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

long ll_i 


for ll_i = 1 to ads.rowcount()
	ads.SetItemStatus(ll_i, 0,Primary!, notModified!)
	ads.SetItemStatus(ll_i, 0,Primary!, newModified!)
NEXT


return 1
end function

public function integer of_update (n_ds ads);





ads.OF_update( true, true)


return 1
end function

on w_reappointment_measurements.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_copy=create cb_copy
this.dw_measurements=create dw_measurements
this.dw_category=create dw_category
this.dw_profile=create dw_profile
this.cb_delete_measurement=create cb_delete_measurement
this.cb_create_measurement=create cb_create_measurement
this.cb_delete_profile=create cb_delete_profile
this.cb_create_profile=create cb_create_profile
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.cb_save=create cb_save
this.gb_profile=create gb_profile
this.gb_measurements=create gb_measurements
this.gb_measurement_group=create gb_measurement_group
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_copy
this.Control[iCurrent+5]=this.dw_measurements
this.Control[iCurrent+6]=this.dw_category
this.Control[iCurrent+7]=this.dw_profile
this.Control[iCurrent+8]=this.cb_delete_measurement
this.Control[iCurrent+9]=this.cb_create_measurement
this.Control[iCurrent+10]=this.cb_delete_profile
this.Control[iCurrent+11]=this.cb_create_profile
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.cb_preview
this.Control[iCurrent+14]=this.cb_save
this.Control[iCurrent+15]=this.gb_profile
this.Control[iCurrent+16]=this.gb_measurements
this.Control[iCurrent+17]=this.gb_measurement_group
end on

on w_reappointment_measurements.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_copy)
destroy(this.dw_measurements)
destroy(this.dw_category)
destroy(this.dw_profile)
destroy(this.cb_delete_measurement)
destroy(this.cb_create_measurement)
destroy(this.cb_delete_profile)
destroy(this.cb_create_profile)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.cb_save)
destroy(this.gb_profile)
destroy(this.gb_measurements)
destroy(this.gb_measurement_group)
end on

event pfc_postopen;call super::pfc_postopen;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_postopen::w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [none]     
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
//// set the transactionobject on the master datawindow
//this.dw_profile.inv_linkage.of_settransobject( sqlca)
//
//// retrieve the master datawindow, no need to retrieve the rest
//if this.dw_profile.inv_linkage.of_retrieve( ) = -1 then
////	messagebox('Error', '')
//end if
//
end event

event pfc_preopen;call super::pfc_preopen;//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////  [PUBLIC]   : 
////==================================================================================================================
////  Purpose   	: 
////==================================================================================================================
////  Arguments 	: [none] 
////==================================================================================================================
////  Returns   	: [long]     
////==================================================================================================================
////  Notes     	: 	  
////==================================================================================================================
////  Created By	: Michael Skinner  Thursday  October 14, 2004
////==================================================================================================================
////  Modification Log
////   Changed By             Change Date                                               Reason
//// ------------------------------------------------------------------------------------------------------------------
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//dw_profile.of_SetLinkage(true)
//dw_measurement_group.of_SetLinkage(true)
//this.dw_measurements.of_SetLinkage(true)
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the linkage stuff
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//dw_measurement_group.inv_linkage.of_SetMaster(dw_profile)
//dw_measurement_group.inv_linkage.of_Register("qa_profile_id", "qa_profile_id") 
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-01
////$<modify> 01.13.2006 By: LeiWei
////$<reason> It is unsupported on the Web to use an object without creating it first.
////$<modification> Create the object first and then use it.
////dw_measurement_group.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve) 
//n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
//lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
//dw_measurement_group.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve) 
////---------------------------- APPEON END ----------------------------
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// SET UP MEASURMENT DW IN LINKAGE SERVICE
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
////dw_measurements.of_SetLinkage(true)
//dw_measurements.inv_linkage.of_SetMaster(dw_measurement_group) 
//dw_measurements.inv_linkage.of_Register("qa_profile_id", "qa_profile_id")
//dw_measurements.inv_linkage.of_Register("profile_group_id", "profile_group_id")
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-02
////$<modify> 01.13.2006 By: LeiWei
////$<reason> It is unsupported on the Web to use an object without creating it first.
////$<modification> Create the object first and then use it.
////dw_measurements.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
//dw_measurements.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
//Destroy lnv_cst_dwsrv_linkage
////---------------------------- APPEON END ----------------------------
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the update properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//dw_profile.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_profile.inv_linkage.of_SetConfirmOnRowChange(TRUE)
//dw_measurement_group.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_measurement_group.inv_linkage.of_SetConfirmOnRowChange(TRUE)
////dw_measurements.inv_linkage.of_SetUpdateOnRowChange(TRUE)
////dw_measurements.inv_linkage.of_SetConfirmOnRowChange(TRUE)
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the delete delete style
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//dw_profile.inv_linkage.of_SetDeleteStyle(dw_profile.inv_linkage.DELETE_ROWS)
//dw_measurement_group.inv_linkage.of_SetDeleteStyle(dw_measurement_group.inv_linkage.bottomup  )
////dw_measurements.inv_linkage.of_SetDeleteStyle(dw_measurements.inv_linkage.bottomup  )
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// set the delete properties for the datawindows
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//this.dw_profile.inv_linkage.of_SetConfirmOnDelete ( true )
//this.dw_measurement_group.inv_linkage.of_SetConfirmOnDelete ( true )
////this.dw_measurements.inv_linkage.of_SetConfirmOnDelete ( true )
//
//dw_profile.inv_linkage.of_SetDeleteStyle ( 1 )
//dw_measurements.inv_linkage.of_SetDeleteStyle ( 1 )
//dw_measurement_group.inv_linkage.of_SetDeleteStyle ( 1 )
//
//
//
end event

event pfc_endtran;call super::pfc_endtran;


 postevent("ue_set_to_current_profile( )") 
 
 return 1
end event

event pfc_save;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

Long ll_loop, ll_rowcount, ll_found
Long ll_profile_id, ll_group_id, ll_measurement_id
long ll_profile_deleteid[]
Boolean lb_new_profile, lb_new_group, lb_new_measurement
Boolean lb_save_profile, lb_save_group, lb_save_measurement

If dw_profile.AcceptText() <> 1 Then Return -1;
If dw_category.AcceptText() <> 1 Then Return -1;
If dw_measurements.AcceptText() <> 1 Then Return -1;

gnv_appeondb.of_StartQueue()
If dw_profile.Modifiedcount() > 0 Then
	ll_rowcount = dw_profile.Rowcount()
	For ll_loop = 1 to ll_rowcount
		If dw_profile.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
			SELECT max(qa_profile.qa_profile_id) INTO :ll_profile_id FROM qa_profile ;
			lb_new_profile = True
			Exit;
		End If
	Next
End If

//If dw_category.Modifiedcount() > 0 Then
//	ll_rowcount = dw_category.Rowcount()
//	For ll_loop = 1 to ll_rowcount
//		If dw_category.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
//			SELECT max(qa_profile_group.qa_profile_group_id) INTO :ll_group_id FROM qa_profile_group;
//			lb_new_group = True
//			Exit;
//		End If
//	Next
//End If

//If dw_measurements.Modifiedcount() > 0 Then
//	ll_rowcount = dw_measurements.Rowcount()
//	For ll_loop = 1 to ll_rowcount
//		If dw_measurements.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
//			SELECT max( qa_measurement.profile_group_measurement_id ) INTO  :ll_measurement_id FROM qa_measurement;
//			lb_new_measurement = True
//			Exit;
//		End If
//	Next
//End If
gnv_appeondb.of_CommitQueue()

If lb_new_profile Then
	if isnull( ll_profile_id ) then ll_profile_id = 0
	il_qa_profile_id = ll_profile_id
	
	ll_rowcount = dw_profile.Rowcount()
	For ll_loop = 1 to ll_rowcount
		If dw_profile.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
			il_qa_profile_id ++
			dw_profile.setitem(ll_loop, 'qa_profile_id', il_qa_profile_id)
		End If
	Next
End If

//If lb_new_group Then
//	if isnull(ll_group_id) then ll_group_id = 0
//	
//	ll_rowcount = dw_category.Rowcount()
//	For ll_loop = 1 to ll_rowcount
//		If dw_category.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
//			ll_group_id ++
//			dw_category.SetItem( ll_loop, "profile_group_id", ll_group_id )
//		   dw_category.SetItem( ll_loop, "qa_profile_id", &
//			dw_profile.GetItemNumber( dw_profile.getrow(), "qa_profile_id" ))
//		End If
//	Next
//End If

//If lb_new_measurement Then
//	if isnull(ll_measurement_id) then ll_measurement_id = 0
//	
//	ll_rowcount = dw_measurements.Rowcount()
//	For ll_loop = 1 to ll_rowcount
//		If dw_measurements.GetItemStatus( ll_loop, 0, Primary! ) = NewModified! Then
//			ll_measurement_id ++
//			dw_measurements.SetItem( ll_loop, "group_measurement_id", ll_measurement_id )
//		   dw_measurements.SetItem( ll_loop, "qa_profile_id", &
//			dw_profile.GetItemNumber( dw_profile.getrow(), "qa_profile_id" ))
//			dw_measurements.SetItem( ll_loop, "profile_group_id", &
//			dw_category.GetItemNumber( dw_category.getrow(), "profile_group_id" ))
//		End If
//	Next
//End If

// the profile that was just saved. This is used to set the focus back to this profile
//added by long.zhang 11.02.2012
//before delte profile delete measurement first  BugS103001



//-------------appoeon begin----------------
//<$>added:long.zhang 11.02.2012
//<$>reason:before delte profiel delte Measurements first BugS103001
if dw_profile.deletedcount( ) > 0 then
	for ll_loop = 1 to dw_profile.deletedcount( )
		ll_profile_deleteid[upperbound(ll_profile_deleteid[]) + 1] = dw_profile.getItemNumber(ll_loop,"qa_profile_id",Delete!,false)
	end for
	
	gnv_appeondb.of_startqueue( )
		for ll_loop = 1 to UpperBound(ll_profile_deleteid[])
			delete from qa_measurement_new where qa_profile_id = :ll_profile_deleteid[ll_loop];
		end for
	gnv_appeondb.of_commitqueue( )
end if
//----------------appeon end---------------

if dw_measurements.rowcount() > 0 then
	il_qa_profile_id_saved  = dw_measurements.object.qa_profile_id[dw_measurements.getrow()]
end if 

gnv_appeondb.of_StartQueue()
If dw_profile.Modifiedcount() > 0 or dw_profile.Deletedcount() > 0 Then
	dw_profile.Update()
	lb_save_profile = True
End If
If dw_category.Modifiedcount() > 0 or dw_category.Deletedcount() > 0 Then
	dw_category.Update()
	lb_save_group = True
End If
If dw_measurements.Modifiedcount() > 0 or dw_measurements.Deletedcount() > 0 Then
	dw_measurements.Update()
	lb_save_measurement = True
End If
If lb_save_profile or lb_save_group or lb_save_measurement Then
	Commit Using SQLCA;
Else
	gnv_appeondb.of_CommitQueue()
	Return 0;
End If

ll_rowcount = 0
If lb_new_profile then
	dw_profile.Retrieve()
End If
gnv_appeondb.of_CommitQueue()

If lb_new_profile Then
	ll_found = dw_profile.Find( "qa_profile_id = " + string( il_qa_profile_id ), 1, dw_profile.rowcount() )
	gnv_appeondb.of_StartQueue()
	dw_profile.SetRow( ll_found )
	gnv_appeondb.of_CommitQueue()
	dw_profile.SelectRow( ll_found, True )
	dw_profile.ScrolltoRow( ll_found )
End if

Return 1;
//---------------------------- APPEON END ----------------------------
end event

event open;call super::open;dw_profile.retrieve()
end event

type cb_2 from u_cb within w_reappointment_measurements
string tag = "Copy this profile to another facility."
integer x = 2336
integer y = 36
integer width = 443
integer height = 84
integer taborder = 40
fontcharset fontcharset = ansi!
string text = "Batch Add Metrics"
end type

event clicked;call super::clicked;open(w_qa_batch_add_profile_metrics)





end event

type cb_3 from u_cb within w_reappointment_measurements
string tag = "Copy this profile to another facility."
integer x = 1847
integer y = 36
integer width = 471
integer height = 84
integer taborder = 30
fontcharset fontcharset = ansi!
string text = "Batch Add Profiles"
end type

event clicked;call super::clicked;open(w_qa_batch_add_profiles)





end event

type cb_1 from u_cb within w_reappointment_measurements
string tag = "Copy this profile to another facility."
integer x = 3049
integer y = 36
integer width = 379
integer height = 84
integer taborder = 20
fontcharset fontcharset = ansi!
string text = "Metrics Lookup"
end type

event clicked;call super::clicked;open(w_qa_metrics)





end event

type cb_copy from u_cb within w_reappointment_measurements
string tag = "Copy this profile to another facility."
integer x = 741
integer y = 36
integer height = 84
integer taborder = 30
fontcharset fontcharset = ansi!
string text = "&Copy Profile"
end type

event clicked;call super::clicked;
long ll_profile_id 				// old profile id
long ll_profile_id_new 			// new profile id
long ll_current
long ll_new
long ll_measure_id
integer r
integer rc



long ll_group_measurement_id 	// measurement id
string ls_filter 					// filter string
// datastore datawindows
string ls_datawindows[] = {'d_qa_profile_copy','d_qa_profile_group','d_qa_profile_group_measurements_copy'} 
ls_filter = 'profile_group_id = ' 

select max(qa_profile_id) into :ll_profile_id_new from qa_profile;
select max(profile_group_measurement_id) into :ll_measure_id from qa_measurement_new;

ll_current = dw_profile.getrow()

if ll_current < 1 or dw_measurements.rowcount() = 0 then return

ll_profile_id = dw_profile.getitemnumber(ll_current,"qa_profile_id")

dw_profile.rowscopy( ll_current,ll_current, primary!,dw_profile,10000,primary!)
ll_new = dw_profile.rowcount()

//set new record values
 ll_profile_id_new++ 
dw_profile.setitem(ll_new,"profile_name","NEW COPIED PROFILE")
dw_profile.setitem(ll_new,"qa_profile_id", ll_profile_id_new )

rc = dw_measurements.rowcount()

//dw_measurements.rowscopy( 1, rc, primary!,dw_measurements, rc, primary!)
dw_measurements.rowscopy( 1, rc, primary!,dw_measurements, rc +1 , primary!) //modify by stephen 10.30.2012  -BugS102502

for r = rc + 1 to dw_measurements.rowcount()
	ll_measure_id++
	/*dw_profile*/dw_measurements.setitem(r,"profile_group_measurement_id",ll_measure_id)  //Modify by Stephen 05.10.2011 --- Fixed a bug.
	/*dw_profile*/dw_measurements.setitem(r,"qa_profile_id",ll_profile_id_new)
next

dw_profile.update()
dw_measurements.update()
// scroll to new profile

//------------------- APPEON BEGIN -------------------
//$<add> Stephen 10.30.2012
//$<reason>  scroll to new profile BugS102502
dw_profile.scrolltorow(ll_new)
dw_profile.selectrow(0, false)
dw_profile.selectrow(ll_new, false)
dw_profile.event rowfocuschanged(ll_new)
//------------------- APPEON END ---------------------



end event

type dw_measurements from u_dw within w_reappointment_measurements
event ue_set_sequence_number ( )
event type long ue_get_sequence_number ( )
event ue_set_to_current_profile ( )
event ue_add_row pbm_dwnprocessenter
integer x = 32
integer y = 860
integer width = 4238
integer height = 1292
integer taborder = 80
string dataobject = "d_qa_measurement_new"
boolean hscrollbar = true
end type

event type long ue_get_sequence_number();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : event ue_get_sequence_number:dw_measurement_group
//==================================================================================================================
//  Purpose   	: gets the next primary key value for this datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	:  Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max( "dba"."qa_measurement"."profile_group_measurement_id"  )
//INTO  :ll_max_count 
//FROM  "dba"."qa_measurement"  ;

SELECT max(qa_measurement.profile_group_measurement_id  )
INTO  :ll_max_count 
FROM qa_measurement  ;

//---------------------------- APPEON END ----------------------------

if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1

end event

event ue_add_row;

parent.cb_close.default = false
this.event pfc_addrow( )



return 1
end event

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
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
this.of_SetRowManager(TRUE)
this.inv_rowmanager.of_SetRestoreRow(TRUE)
//this.of_SetReqColumn(TRUE)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(inv_base.HEADER)


of_SetLinkage(true)
//inv_linkage.of_SetMaster(parent.dw_measurement_group) 
//inv_linkage.of_Register("qa_profile_id", "qa_profile_id")
//inv_linkage.of_Register("profile_group_id", "profile_group_id")
//inv_linkage.of_SetStyle(inv_linkage.retrieve)

this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

//this.ib_rmbmenu = true
end event

event pfc_retrieve;call super::pfc_retrieve;
RETURN 1
end event

event pfc_updateprep;call super::pfc_updateprep;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_measurement:pfc_updateprep
//==================================================================================================================
//  Purpose   	: The event calles of_getsequence_number() if the rowcount is greated then 0
//						and the id is null i.e not saved as ofo yet
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [LONG]  not used
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael Skinner    
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<comment> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> The following script lines merge into pfc_save event of window.
/*
boolean lb_need_seq_number // sequence number place holder
long ll_row_count   			// row count place hilder
long ll_seq_number 			// the sequence number


// see if any rows need a sequence number, if so get the sequence number

for ll_row_count = 1 to this.rowcount( )
	if isnull(this.object.group_measurement_id[ll_row_count]) then
		lb_need_seq_number = true
		ll_seq_number = this.event ue_get_sequence_number( )
		EXIT // NO NEED TO KEEP GOING
	end if
next

// SET THE SEQUENCE NUMBER AS NEEDED

IF lb_need_seq_number THEN
	FOR ll_row_count = 1 TO THIS.rowcount( )
		if isnull(this.object.group_measurement_id[ll_row_count]) then 
			// bump up the counter
			ll_seq_number = ll_seq_number + 1
			this.object.group_measurement_id[ll_row_count]  = ll_seq_number
		   this.object.qa_profile_id[ll_row_count] =   parent.dw_profile.object.qa_profile_id[dw_profile.getrow()]
			this.object.profile_group_id[ll_row_count] =   parent.dw_measurement_group.object.profile_group_id[dw_measurement_group.getrow()]
		end if
	NEXT
END IF
*/
//---------------------------- APPEON END ----------------------------

return 1
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;


this.of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )
as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

event pfc_validation;call super::pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_validation 
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

long ll_i


//for ll_i = 1 to this.rowcount( )
//	IF ISNULL(THIS.OBJECt.qa_measurement_qa_measurement_name[ll_i]) THEN
//		of_Messagebox('Validation Error','Save', 'Required value missing for Measurement Name on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
//		this.setfocus( )
//		this.setrow(ll_i)
//		setcolumn('qa_measurement_qa_measurement_name')
//		RETURN FAILURE
//	END IF
//	
//	IF ISNULL(THIS.OBJECt.qa_measurement_data_format[ll_i]) THEN
//		of_Messagebox('Validation Error','Save', 'Required value missing for Data Format on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
//		this.setfocus( )
//		this.setrow(ll_i)
//		setcolumn('qa_measurement_data_format')
//		RETURN FAILURE
//	END IF
//	
//	IF ISNULL(THIS.OBJECt.qa_measurement_threshold[ll_i]) THEN
//		of_Messagebox('Validation Error','Save', 'Required value missing for Measurement Threshold on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
//		this.setfocus( )
//		this.setrow(ll_i)
//		setcolumn('qa_measurement_threshold')
//		RETURN FAILURE
//	END IF
//	
//	IF ISNULL(THIS.OBJECt.qa_measurement_include_in_profile[ll_i]) THEN
//		of_Messagebox('Validation Error','Save', 'Required value missing for Include In Profile on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
//		this.setfocus( )
//		this.setrow(ll_i)
//		setcolumn('qa_measurement_include_in_profile')
//		RETURN FAILURE
//	END IF
//	
//NEXT


RETURN success
end event

event pfc_addrow;call super::pfc_addrow;



of_setfocus(this,'qa_measurement_qa_measurement_name')
return success
end event

event losefocus;call super::losefocus;



parent.cb_close.default = true
end event

type dw_category from u_dw within w_reappointment_measurements
event type long ue_get_sequence_number ( )
integer x = 3255
integer y = 196
integer width = 1001
integer height = 476
integer taborder = 90
string dataobject = "d_qa_profile_categories_new"
end type

event type long ue_get_sequence_number();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : event ue_get_sequence_number:dw_measurement_group
//==================================================================================================================
//  Purpose   	: gets the next primary key value for this datawindow
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	    
//==================================================================================================================
//  Created By	:  Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."qa_profile_group"."qa_profile_group_id")
//INTO  :ll_max_count 
//FROM  "dba"."qa_profile_group"  ;

SELECT max(qa_profile_group.qa_profile_group_id)
INTO  :ll_max_count 
FROM  qa_profile_group  ;

//---------------------------- APPEON END ----------------------------

if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count


end event

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : constructor:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
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
this.of_SetRowManager(TRUE)
//this.of_SetReqColumn(TRUE)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)

of_SetLinkage(true)
//inv_linkage.of_SetMaster(dw_profile) 
//inv_linkage.of_Register("qa_profile_id", "qa_profile_id")

inv_linkage.of_SetStyle(inv_linkage.retrieve )


this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

//this.ib_rmbmenu = true

end event

event pfc_updateprep;call super::pfc_updateprep;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_measurement:pfc_updateprep
//==================================================================================================================
//  Purpose   	: The event calles of_getsequence_number() if the rowcount is greated then 0
//						and the id is null i.e not saved as ofo yet
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [LONG]  not used
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael Skinner    
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> The following script lines merge into pfc_save event of window.
/*
boolean lb_need_seq_number // sequence number place holder
long ll_row_count   			// row count place hilder
long ll_seq_number 			// the sequence number


// see if any rows need a sequence number, if so get the sequence number

for ll_row_count = 1 to this.rowcount( )
	if isnull(this.object.profile_group_id[ll_row_count]) then
		lb_need_seq_number = true
		ll_seq_number = this.event ue_get_sequence_number( )
		EXIT // NO NEED TO KEEP GOING
	end if
next

// SET THE SEQUENCE NUMBER AS NEEDED

IF lb_need_seq_number THEN
	FOR ll_row_count = 1 TO THIS.rowcount( )
		if isnull(this.object.profile_group_id[ll_row_count]) then 
			// bump up the counter
			ll_seq_number = ll_seq_number + 1
			this.object.profile_group_id[ll_row_count]  = ll_seq_number
		   this.object.qa_profile_id[ll_row_count] =   parent.dw_profile.object.qa_profile_id[dw_profile.getrow()]
		end if 
	NEXT
END IF

this.of_accepttext(true)
*/
//---------------------------- APPEON END ----------------------------

return 1
end event

event pfc_retrieve;call super::pfc_retrieve;return 1
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;

this.of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )
as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

event pfc_validation;call super::pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_validation 
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

long ll_i
for ll_i = 1 to this.rowcount( )
	IF ISNULL(THIS.OBJECt.qa_profile_group_qa_profile_group_name[ll_i]) THEN
		of_Messagebox('Validation Error','Save', 'Required value missing for Group Name on row ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('qa_profile_group_qa_profile_group_name')
		RETURN FAILURE
	END IF
	
NEXT


RETURN success
end event

event dberror;


// override

if sqldbcode = -198 then
	Messagebox('Existing Data','This group cannot be deleted because there are records that referance this information.')
	this.RowsMove(1, this.DeletedCount(), Delete!, this, 1, Primary!)
	parent.dw_measurements.RowsMove(1, parent.dw_measurements.DeletedCount(), Delete!, parent.dw_measurements, 1, Primary!)
	return 1 // no error message
	
else
	super:: event dberror(sqldbcode,sqlerrtext,sqlsyntax,buffer,row)
end if
end event

event pfc_addrow;call super::pfc_addrow;

of_setfocus(this,'qa_profile_group_qa_profile_group_name')
return success
end event

event doubleclicked;call super::doubleclicked;string ls_value
string ls_filter

if row > 0 then
	ls_value = this.getitemstring(row,1)
	ls_filter = "category_name = '" + ls_value + "'"
else
	ls_filter = ""
end if

dw_measurements.setfilter(ls_filter)
dw_measurements.filter()
end event

type dw_profile from u_dw within w_reappointment_measurements
integer x = 32
integer y = 196
integer width = 3118
integer height = 472
integer taborder = 10
string dataobject = "d_qa_profile"
boolean hscrollbar = true
end type

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
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

//this.of_SetRowManager(TRUE)
////this.inv_rowmanager.of_SetRestoreRow(TRUE)
////this.of_SetReqColumn(TRUE)
//this.of_setlinkage( true)
////this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)
//
//this.of_SetRowSelect(TRUE)
//this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )
//
//////this.ib_rmbmenu = true
//
end event

event pfc_retrieve;call super::pfc_retrieve;


//Return this.inv_linkage.of_retrieve( )
Return retrieve( )
end event

event pfc_updateprep;call super::pfc_updateprep;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_measurement:pfc_updateprep
//==================================================================================================================
//  Purpose   	: The event calles of_getsequence_number() if the rowcount is greated then 0
//						and the id is null i.e not saved as ofo yet
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [LONG]  not used
//==================================================================================================================
//  Notes     	:     
//==================================================================================================================
//  Created By	: Michael Skinner    
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<comment> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> The following script lines merge into pfc_save event of window.
/*
if this.rowcount( ) > 0 then
	if isnull(this.getitemNumber(1,'qa_profile_id')) then 
		il_qa_profile_id = of_getsequence_number()
		this.setitem(1,'qa_profile_id', il_qa_profile_id)
	end if 
end if
*/
//---------------------------- APPEON END ----------------------------
return 1
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;

this.of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )
as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

event pfc_validation;call super::pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_validation 
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

long ll_i


for ll_i = 1 to this.rowcount( )
	IF ISNULL(THIS.OBJECt.profile_name[ll_i]) THEN
		of_Messagebox('Validation Error','Save', 'Required value missing for Profile Name on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('profile_name')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.specialty_id[ll_i]) THEN
		of_Messagebox('Validation Error','Save', 'Required value missing for Specialty on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('specialty_id')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.facility_id[ll_i]) THEN
		of_Messagebox('Validation Error','Save', 'Required value missing for Facility on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('facility_id')
		RETURN FAILURE
	END IF
	

NEXT


RETURN success
end event

event pfc_addrow;call super::pfc_addrow;


of_setfocus(dw_profile,'profile_name')
return success
end event

event rowfocuschanged;call super::rowfocuschanged;

if currentrow > 0 then
	il_qa_profile_id =  this.object.qa_profile_id[currentrow]
	//Start Code Change ----12.15.2009 #V10 maha
	dw_measurements.retrieve(il_qa_profile_id )
	dw_category.retrieve(il_qa_profile_id )
	//End Code Change---12.15.2009
end if 
end event

type cb_delete_measurement from u_cb within w_reappointment_measurements
string tag = "Delete the selected measurement."
integer x = 2574
integer y = 772
integer width = 494
integer height = 84
integer taborder = 140
fontcharset fontcharset = ansi!
string text = "Delete Measurement"
end type

event clicked;call super::clicked;
//  Created By	: Michael Skinner  Wednesday 13 October 2004

long ll_count
long ll_profile_id

if  dw_profile.rowcount( ) < 1 then return 
if parent.dw_measurements.getRow() < 1 then return //(Appeon)Stephen 11.28.2013 - BugS112601
////////////////////////////////////////////////////////////////////
// check to see if this group id is being used 
////////////////////////////////////////////////////////////////////

ll_profile_id = parent.dw_measurements.getitemnumber(parent.dw_measurements.getRow(),"profile_group_measurement_id")    //object.group_measurement_id[parent.dw_measurements.getRow()]

select count(*) 
into  :ll_count
from  pd_qa_profile_data
where profile_measurement_id = :ll_profile_id;




if ll_count > 0  then
	Messagebox('Existing Records','There are Practitioner profile records that records that reference this measurement. This measurement cannot be deleted.~rTo hide from future profiles, set Show in Profile to NO.')
	return -1
else
	parent.dw_measurements.event pfc_deleterow( )

end if

return 1





end event

type cb_create_measurement from u_cb within w_reappointment_measurements
string tag = "Add a measurement."
integer x = 2043
integer y = 772
integer width = 494
integer height = 84
integer taborder = 110
string text = "Add Measurements"
end type

event clicked;//Start Code Change ----12.18.2009 #V10 maha
gs_pass_ids lst_array
long ll_ids[]
long i
long r
long nr
long ll_met
long ll_meas_id
integer li_found
string ls_cat[]
string ls_ind[]


//------------------- APPEON BEGIN -------------------
//$<add> Michael 12.27.2011
//$<reason> Bug id 2837 QA Issues
DataWindowChild dwc_metric
dw_measurements.GetChild('qa_metric_id', dwc_metric)
dwc_metric.SetTransObject(SQLCA)
dwc_metric.Retrieve()
//------------------- APPEON END ---------------------

open(w_qa_metric_select)
debugbreak()
if message.stringparm = "Cancel" then
	return
else
	select max(profile_group_measurement_id)   into :ll_meas_id from qa_measurement_new;
	if isnull(ll_meas_id) then ll_meas_id = 0
	lst_array = message.powerobjectparm
	ll_ids = lst_array.l_ids
	ls_cat = lst_array.s_action_type
	ls_ind = lst_array.s_doc_ids
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
			dw_measurements.setitem(nr,"profile_group_measurement_id",ll_meas_id)
			dw_measurements.setitem(nr,"qa_metric_id",ll_met)
			//dw_measurements.setitem(nr,"group_id",0)
			dw_measurements.setitem(nr,"qa_profile_id",il_qa_profile_id)
			dw_measurements.setitem(nr,"category_name",ls_cat[i] )
		//	dw_measurements.setitem(nr,"qa_measurement_qa_measurement_name",ls_ind[i] )
		end if
	next
end if

i = dw_measurements.update()
if i < 1 then 	messagebox("Measurements Update failed",sqlca.sqlerrtext)
dw_category.retrieve(il_qa_profile_id)
 			
			
			
end event

type cb_delete_profile from u_cb within w_reappointment_measurements
string tag = "Delete the Quality Profile."
integer x = 1097
integer y = 36
integer width = 361
integer height = 84
integer taborder = 60
string text = "&Delete Profile"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : cb_delete_profile:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
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


////////////////////////////////////////////////////////////////////
// do not allow the user to delete profiles unless the groups are deleted first
////////////////////////////////////////////////////////////////////
if  dw_profile.rowcount( ) < 1 then return 

if dw_measurements.rowcount() > 0 then //added by long.zhang 11.02.2012 before delte profile delete measurement first  BugS103001 
	MessageBox(parent.title, 'Please delete all of the Measurements for this profile before continuing.')
	return
end if

if parent.of_check_for_groups(dw_profile.object.qa_profile_id[dw_profile.getrow()]) then
   parent.dw_profile.event pfc_deleterow( )
else
	MessageBox(parent.title, 'Please delete all of the groups for this profile before continuing.')
end if







end event

type cb_create_profile from u_cb within w_reappointment_measurements
string tag = "Create a new Quality Profile"
integer x = 375
integer y = 36
integer width = 361
integer height = 84
integer taborder = 70
string text = "&Create Profile"
end type

event clicked;call super::clicked;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : open:w_reappointment_measurements
//==================================================================================================================
//  Purpose   	: open event
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





parent.event ue_new( )


end event

type cb_close from u_cb within w_reappointment_measurements
string tag = "Close the window"
integer x = 3803
integer y = 36
integer height = 84
integer taborder = 130
string text = "&Close"
boolean default = true
end type

event clicked;call super::clicked;


parent.event pfc_close( )
end event

type cb_preview from u_cb within w_reappointment_measurements
string tag = "Preview the data."
integer x = 3438
integer y = 36
integer height = 84
integer taborder = 50
string text = "&Preview"
end type

event clicked;call super::clicked;



long ll_found_row
parent.cb_save.event clicked( )


ll_found_row = parent.dw_profile.FIND( 'qa_profile_id = ' + string(il_qa_profile_id) , 1,parent.dw_profile.rowcount())

parent.dw_profile.SCROLLTOrow(ll_found_row)

openwithparm(w_report_preview, il_qa_profile_id )
end event

type cb_save from u_cb within w_reappointment_measurements
string tag = "Save the new data."
integer x = 14
integer y = 36
integer height = 84
integer taborder = 40
integer weight = 700
fontcharset fontcharset = ansi!
string text = "&Save"
end type

event clicked;call super::clicked;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : w_reappointment_measurements :: cb_save:: clicked
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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 04.12.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> The following script lines merge into pfc_save event of window.
/*
POWEROBJECT lpw_pw[]

lpw_pw[1] = parent.dw_measurements
lpw_pw[2] = parent.dw_measurement_group
lpw_pw[3] = parent.dw_profile

// the profile that was just saved. This is used to set the focus back to this profile
if parent.dw_measurements.rowcount() > 0 then
	il_qa_profile_id_saved  = parent.dw_measurements.object.qa_profile_id[parent.dw_measurements.getrow()]
end if 

if  parent.event pfc_SaveObjects(lpw_pw[])> 0 then
	 parent.event pfc_postopen( )
end if
*/
Parent.Trigger Event pfc_save()
//---------------------------- APPEON END ----------------------------






end event

type gb_profile from u_gb within w_reappointment_measurements
integer x = 5
integer y = 144
integer width = 3182
integer height = 556
integer taborder = 0
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "QA Profile"
end type

type gb_measurements from u_gb within w_reappointment_measurements
integer y = 720
integer width = 4325
integer height = 1452
integer taborder = 0
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Measurements"
end type

type gb_measurement_group from u_gb within w_reappointment_measurements
integer x = 3214
integer y = 140
integer width = 1097
integer height = 560
integer taborder = 0
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Measurement Categories"
end type

