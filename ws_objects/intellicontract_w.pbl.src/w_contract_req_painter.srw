$PBExportHeader$w_contract_req_painter.srw
$PBExportComments$[intellicontract_w] The contract requirements painter.
forward
global type w_contract_req_painter from w_response
end type
type cb_copy from u_cb within w_contract_req_painter
end type
type dw_measurements from u_dw_contract within w_contract_req_painter
end type
type dw_measurement_group from u_dw_contract within w_contract_req_painter
end type
type dw_profile from u_dw_contract within w_contract_req_painter
end type
type cb_delete_measurement from u_cb within w_contract_req_painter
end type
type cb_create_measurement from u_cb within w_contract_req_painter
end type
type cb_delete_group from u_cb within w_contract_req_painter
end type
type cb_create_group from u_cb within w_contract_req_painter
end type
type cb_delete_profile from u_cb within w_contract_req_painter
end type
type cb_create_profile from u_cb within w_contract_req_painter
end type
type gb_profile from u_gb within w_contract_req_painter
end type
type gb_measurements from u_gb within w_contract_req_painter
end type
type gb_measurement_group from u_gb within w_contract_req_painter
end type
type cb_select from commandbutton within w_contract_req_painter
end type
type cb_close from u_cb within w_contract_req_painter
end type
type cb_preview from u_cb within w_contract_req_painter
end type
type cb_save from u_cb within w_contract_req_painter
end type
end forward

global type w_contract_req_painter from w_response
integer width = 4453
integer height = 2016
string title = "Contract Requirements Profiles"
long backcolor = 33551856
event ue_new ( )
event ue_retrieve ( )
event ue_set_to_current_profile ( )
event ue_update_template ( )
cb_copy cb_copy
dw_measurements dw_measurements
dw_measurement_group dw_measurement_group
dw_profile dw_profile
cb_delete_measurement cb_delete_measurement
cb_create_measurement cb_create_measurement
cb_delete_group cb_delete_group
cb_create_group cb_create_group
cb_delete_profile cb_delete_profile
cb_create_profile cb_create_profile
gb_profile gb_profile
gb_measurements gb_measurements
gb_measurement_group gb_measurement_group
cb_select cb_select
cb_close cb_close
cb_preview cb_preview
cb_save cb_save
end type
global w_contract_req_painter w_contract_req_painter

type variables


long il_qa_profile_id // the current profile
long il_qa_profile_id_saved 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-04-07 By: owen chen
//$<reason> define three sequence parameter
long	il_max_count
long	il_max_count_measurement_group
long	il_max_count_measurements
//---------------------------- APPEON END ----------------------------

long il_element_id_changed[],il_empty[] //Added By Ken.Guo 2009-07-01.
String is_element_name[] ,is_empty[]


end variables

forward prototypes
public function integer of_getsequence_number ()
public function boolean of_check_for_groups (long al_profile_id)
public subroutine of_setfocus (u_dw_contract adw, string as_column)
public function integer of_set_insert (ref n_ds ads)
public function integer of_update (n_ds ads)
public subroutine readme ()
public subroutine of_initial_parameters ()
public subroutine of_preupdatetotal ()
public function boolean of_is_used (long al_element_id[])
public subroutine of_get_changed_element ()
public function integer of_set_dropdown_value ()
public subroutine of_setreadonly ()
end prototypes

event ue_new();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_new::w_reappointment_measurement
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



this.of_accepttext( true)

if this.of_updatespending( ) > 0 then
	if messagebox(this.title,'Do you want to save changes?',question!,yesno!) = 1 then
		if this.event pfc_save( ) < 0 then
			return
		end if
	end if
end if


//clear out the old data
this.dw_measurement_group.reset( )
this.dw_measurements.reset( )
this.dw_profile.reset( )

//
// turn off the row manager stuff so that validation messages will
// not pop  up
//this.dw_measurement_group.of_SetRowManager(false)
//this.dw_measurements.of_SetRowManager(false)
//this.dw_profile.of_SetRowManager(false)


// add the new rows
this.dw_profile.event pfc_addrow( )
this.dw_measurement_group.event pfc_addrow( )
this.dw_measurements.event pfc_addrow( )

//this.dw_measurement_group.of_SetRowManager(true)
//this.dw_measurements.of_SetRowManager(true)
//this.dw_profile.of_SetRowManager(true)

of_setfocus(dw_profile,'rqmnt_name')


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

event ue_update_template();Long i
str_used_tempate lstr_template
DataStore lds_req_template_used 
If UpperBound(il_element_id_changed[] ) <= 0 Then Return

lds_req_template_used = Create DataStore
lds_req_template_used.DataObject = 'd_req_template_used'
lds_req_template_used.SetTransObject(SQLCA)	
lds_req_template_used.Retrieve(il_element_id_changed[])

If lds_req_template_used.RowCount() <= 0 Then Return 

If Messagebox('Updating existing clauses/templates','Would you like to update all the Clauses/Templates that refer to this requirement?',Question!,YesNo!) = 1 Then 
	lstr_template.sl_element_id[] = il_element_id_changed[]
	lstr_template.ss_element_name[] = is_element_name[]
	lstr_template.sds_template_list = lds_req_template_used
	Openwithparm(w_update_template_by_reqmnt,lstr_template)
End If


Return

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
//  Created By	:  Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
/*
long ll_max_count

SELECT max(ctx_req_profile.ctx_req_profile_id )
INTO :ll_max_count   
FROM ctx_req_profile   ;



if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1
*/


return il_max_count + 1

//---------------------------- APPEON END ----------------------------



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



//n_ds lds_datastore
//lds_datastore = create n_ds
//lds_datastore.dataobject = 'd_req_profile_painter_category'
//lds_datastore.of_settransobject( sqlca)
//lds_datastore.retrieve(AL_profile_id)


//if lds_datastore.rowcount() > 0 then 
//	return false
//end if
//
return true
end function

public subroutine of_setfocus (u_dw_contract adw, string as_column);



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

public subroutine readme ();

/*

Since this painter functionality is EXACLTY the same QA painter 
I have not renames any of the objects so that we can make changes to both fairly easily 


*/
end subroutine

public subroutine of_initial_parameters ();
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
//$<reason> initial all sequence parameters

gnv_appeondb.of_startqueue( )

SELECT max(ctx_req_profile.ctx_req_profile_id )
INTO :il_max_count  
FROM ctx_req_profile   ;

SELECT max(ctx_rqmnt_category.ctx_rqmnt_category_id)
INTO  :il_max_count_measurement_group 
FROM ctx_rqmnt_category;

SELECT max(ctx_req_tmplt_element.ctx_req_tmplt_element_id)
INTO  :il_max_count_measurements
FROM ctx_req_tmplt_element ; 

gnv_appeondb.of_commitqueue( )

if isnull(il_max_count) then il_max_count = 0
if isnull(il_max_count_measurement_group) then il_max_count_measurement_group = 0
if isnull(il_max_count_measurements) then il_max_count_measurements = 0

//---------------------------- APPEON END ----------------------------


end subroutine

public subroutine of_preupdatetotal ();//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance  

long li_for

LONG LL_MAX_ROW_dw_profile
LONG LL_MAX_ROW_dw_measurement_group
LONG LL_MAX_ROW_dw_measurements

LL_MAX_ROW_dw_profile = dw_profile.rowcount( )
LL_MAX_ROW_dw_measurement_group = dw_measurement_group.rowcount( )
LL_MAX_ROW_dw_measurements = dw_measurements.rowcount( )


Long ll_record_id = 0

ll_record_id = gnv_app.of_get_id('RECORD_ID', LL_MAX_ROW_dw_profile + LL_MAX_ROW_dw_measurement_group + LL_MAX_ROW_dw_measurements) - 1

for li_for = 1 to LL_MAX_ROW_dw_profile
	if not f_validstr(string(dw_profile.getitemNumber(li_for,'record_id'))) then
		ll_record_id++
      dw_profile.setItem(li_for,'record_id', ll_record_id)
	end if 
next

for li_for = 1 to LL_MAX_ROW_dw_measurement_group
	if not f_validstr(string(dw_measurement_group.getitemNumber(li_for,'record_id'))) then
		ll_record_id++
      dw_measurement_group.setItem(li_for,'record_id', ll_record_id)
	end if 
next

for li_for = 1 to LL_MAX_ROW_dw_measurements
	if not f_validstr(string(dw_measurements.getitemNumber(li_for,'record_id'))) then
		ll_record_id++
      dw_measurements.setItem(li_for,'record_id', ll_record_id)
	end if 
next

//---------------------------- APPEON END ----------------------------


end subroutine

public function boolean of_is_used (long al_element_id[]);//////////////////////////////////////////////////////////////////////
// $<function>w_contract_req_painterof_is_used()
// $<arguments>
//		value	long	al_element_id[]		
// $<returns> boolean
// $<description> Check element whether being used.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 2009-07-01 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_ctx_id
String ls_element_name,ls_doc_name,ls_doc_type

DataStore lds_req_ctx_used,lds_req_template_used,lds_req_doc_used

lds_req_ctx_used = Create DataStore
lds_req_ctx_used.DataObject = 'd_req_ctx_used'
lds_req_ctx_used.SetTransObject(SQLCA)

lds_req_template_used = Create DataStore
lds_req_template_used.DataObject = 'd_req_template_used'
lds_req_template_used.SetTransObject(SQLCA)	

lds_req_doc_used = Create DataStore
lds_req_doc_used.DataObject = 'd_req_doc_used'
lds_req_doc_used.SetTransObject(SQLCA)		

gnv_appeondb.of_startqueue( )
	lds_req_ctx_used.Retrieve(al_element_id[])
	lds_req_template_used.Retrieve(al_element_id[])
	lds_req_doc_used.Retrieve(al_element_id[])
gnv_appeondb.of_commitqueue( )

//Check it's elements whether used by CTX Requirement. 
If lds_req_ctx_used.RowCount() > 0 Then
	ls_element_name = lds_req_ctx_used.GetItemString(1,'element_name')
	ll_ctx_id = lds_req_ctx_used.GetItemNumber(1,'ctx_id')
	Messagebox('Delete','Failure. The requirement "' + ls_element_name + '" being used by Contract ' + String(ll_ctx_id)  + '.' )
	If isvalid(lds_req_ctx_used) Then Destroy lds_req_ctx_used
	If isvalid(lds_req_template_used) Then Destroy lds_req_template_used
	If isvalid(lds_req_doc_used) Then Destroy lds_req_doc_used		
	Return True
End If

//Check it's elements whether used by Clause/Template Painter.
If lds_req_template_used.RowCount() > 0 Then
	ls_element_name = lds_req_template_used.GetItemString(1,'element_name')
	ls_doc_name = lds_req_template_used.GetItemString(1,'template_name')
	ls_doc_type = lds_req_template_used.GetItemString(1,'reqmnt_type')
	Choose Case ls_doc_type
		Case 'T' 
			Messagebox('Delete','Failure. The requirement "' + ls_element_name + '" being used by the Template "' + ls_doc_name + '".' )
		Case 'C'
			Messagebox('Delete','Failure. The requirement "' + ls_element_name + '" being used by the Clause "' + ls_doc_name + '".' )
		Case Else
			Messagebox('Delete','Failure. The requirement "' + ls_element_name + '" being used by the document "' + ls_doc_name + '".' )
	End Choose		
	If isvalid(lds_req_ctx_used) Then Destroy lds_req_ctx_used
	If isvalid(lds_req_template_used) Then Destroy lds_req_template_used
	If isvalid(lds_req_doc_used) Then Destroy lds_req_doc_used		
	Return True
End If	

//Check it's elements whether used by Document in Document Manager.
If lds_req_doc_used.RowCount() > 0 Then
	ls_element_name = lds_req_doc_used.GetItemString(1,'element_name')
	ls_doc_name = lds_req_doc_used.GetItemString(1,'doc_name_full')
	ll_ctx_id = lds_req_doc_used.GetItemNumber(1,'ctx_id')
	Messagebox('Delete','Failure. The requirement "' + ls_element_name + '" being used by the document "' + ls_doc_name + '" in contract ' +String(ll_ctx_id)+'.' )
	If isvalid(lds_req_ctx_used) Then Destroy lds_req_ctx_used
	If isvalid(lds_req_template_used) Then Destroy lds_req_template_used
	If isvalid(lds_req_doc_used) Then Destroy lds_req_doc_used		
	Return True
End If	

If isvalid(lds_req_ctx_used) Then Destroy lds_req_ctx_used
If isvalid(lds_req_template_used) Then Destroy lds_req_template_used
If isvalid(lds_req_doc_used) Then Destroy lds_req_doc_used

Return False
end function

public subroutine of_get_changed_element ();Long i
il_element_id_changed[] = il_empty[]
is_element_name[] = is_empty[]

dw_measurements.AcceptText()
For i = 1 To dw_measurements.RowCount()
	If dw_measurements.getitemstatus(i,0,Primary!) = DataModified! Then
		If dw_measurements.getitemstring(i,'element_name',Primary!,False) <> dw_measurements.getitemstring(i,'element_name',Primary!,True) Then
			il_element_id_changed[UpperBound(il_element_id_changed[]) + 1] = dw_measurements.getitemnumber(i,'ctx_req_tmplt_element_id')
			is_element_name[UpperBound(is_element_name[]) + 1] = dw_measurements.getitemstring(i,'element_name',Primary!,False)
		End If
	End If
Next
	

end subroutine

public function integer of_set_dropdown_value ();//Add by jervis 08.20.2009
//Set Defaule Value for dropdown type
any l_any
string ls_code
string ls_lookup_name
long ll_row

ll_row = dw_measurements.getrow( )

if ll_row < 1 then return 0
dw_measurements.Accepttext( )

ls_lookup_name = dw_measurements.GetItemString( ll_row, "dddw_name")
if isnull(ls_lookup_name) or ls_lookup_name = "" then return 0

OpenWithParm( w_lookup_search_dddw,'C' + "@" + ls_lookup_name )

IF Message.StringParm = "Cancel" THEN
	RETURN -1
else
	l_any = Message.DoubleParm
	ls_code = gnv_data.of_getitem( "code_lookup","code", "lookup_code =" + string(l_any))
	dw_measurements.setitem( ll_row, "field_value", ls_code)
	return 1
end if


	
		
end function

public subroutine of_setreadonly ();//////////////////////////////////////////////////////////////////////
// Function: of_setreadonly()
// Arguments:
//--------------------------------------------------------------------
// Return:  (None)
//--------------------------------------------------------------------
// Author:	Ken.Guo		Date: 2010-11-19
//--------------------------------------------------------------------
// Description: Set To Read Only
//--------------------------------------------------------------------
//////////////////////////////////////////////////////////////////////
cb_create_profile.Enabled  = False
cb_delete_profile.Enabled  = False
cb_create_measurement.Enabled  = False
cb_delete_measurement.Enabled  = False
cb_create_group.Enabled  = False
cb_delete_group.Enabled  = False
cb_save.Enabled  = False
dw_profile.Modify("Datawindow.Readonly = Yes")
dw_measurement_group.Modify("Datawindow.Readonly = Yes")
dw_measurements.Modify("Datawindow.Readonly = Yes")
end subroutine

on w_contract_req_painter.create
int iCurrent
call super::create
this.cb_copy=create cb_copy
this.dw_measurements=create dw_measurements
this.dw_measurement_group=create dw_measurement_group
this.dw_profile=create dw_profile
this.cb_delete_measurement=create cb_delete_measurement
this.cb_create_measurement=create cb_create_measurement
this.cb_delete_group=create cb_delete_group
this.cb_create_group=create cb_create_group
this.cb_delete_profile=create cb_delete_profile
this.cb_create_profile=create cb_create_profile
this.gb_profile=create gb_profile
this.gb_measurements=create gb_measurements
this.gb_measurement_group=create gb_measurement_group
this.cb_select=create cb_select
this.cb_close=create cb_close
this.cb_preview=create cb_preview
this.cb_save=create cb_save
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copy
this.Control[iCurrent+2]=this.dw_measurements
this.Control[iCurrent+3]=this.dw_measurement_group
this.Control[iCurrent+4]=this.dw_profile
this.Control[iCurrent+5]=this.cb_delete_measurement
this.Control[iCurrent+6]=this.cb_create_measurement
this.Control[iCurrent+7]=this.cb_delete_group
this.Control[iCurrent+8]=this.cb_create_group
this.Control[iCurrent+9]=this.cb_delete_profile
this.Control[iCurrent+10]=this.cb_create_profile
this.Control[iCurrent+11]=this.gb_profile
this.Control[iCurrent+12]=this.gb_measurements
this.Control[iCurrent+13]=this.gb_measurement_group
this.Control[iCurrent+14]=this.cb_select
this.Control[iCurrent+15]=this.cb_close
this.Control[iCurrent+16]=this.cb_preview
this.Control[iCurrent+17]=this.cb_save
end on

on w_contract_req_painter.destroy
call super::destroy
destroy(this.cb_copy)
destroy(this.dw_measurements)
destroy(this.dw_measurement_group)
destroy(this.dw_profile)
destroy(this.cb_delete_measurement)
destroy(this.cb_create_measurement)
destroy(this.cb_delete_group)
destroy(this.cb_create_group)
destroy(this.cb_delete_profile)
destroy(this.cb_create_profile)
destroy(this.gb_profile)
destroy(this.gb_measurements)
destroy(this.gb_measurement_group)
destroy(this.cb_select)
destroy(this.cb_close)
destroy(this.cb_preview)
destroy(this.cb_save)
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

long ll_found

this.setredraw(false)

// set the transactionobject on the master datawindow
this.dw_profile.inv_linkage.of_settransobject( sqlca)

// retrieve the master datawindow, no need to retrieve the rest
if this.dw_profile.inv_linkage.of_retrieve( ) = -1 then
//	Messagebox('Error', '')
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.14.2006 By: LeiWei
//$<reason> Fix a defect.
IF il_qa_profile_id_saved > 0 THEN
	Message.doubleparm = il_qa_profile_id_saved
END IF
//---------------------------- APPEON END ----------------------------

if Message.doubleparm > 0 then
   ll_found = dw_profile.Find("ctx_req_profile_id = " + string(Message.doubleparm), 1, dw_profile.RowCount())
	if ll_found > 0 then 
		dw_profile.scrolltorow( ll_found)
		dw_profile.SelectRow(0, FALSE)
     dw_profile.SelectRow(ll_found, TRUE)
	end if
else
	cb_Select.Visible = false
end if

//Jervis 08.20.2009
dw_measurements.of_setdropdowncalendar( true)

this.setredraw(true)

end event

event pfc_preopen;call super::pfc_preopen;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : 
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [long]     
//==================================================================================================================
//  Notes     	: 	  
//==================================================================================================================
//  Created By	: Michael Skinner  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_profile.of_SetLinkage(true)
dw_measurement_group.of_SetLinkage(true)
this.dw_measurements.of_SetLinkage(true)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_measurement_group.inv_linkage.of_SetMaster(dw_profile)
dw_measurement_group.inv_linkage.of_Register("ctx_req_profile_id", "ctx_req_profile_id") 

dw_measurement_group.inv_linkage.of_SetStyle(dw_measurement_group.inv_linkage.retrieve) 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// SET UP MEASURMENT DW IN LINKAGE SERVICE
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//dw_measurements.of_SetLinkage(true)
dw_measurements.inv_linkage.of_SetMaster(dw_measurement_group) 
dw_measurements.inv_linkage.of_Register("ctx_req_profile_id", "ctx_req_profile_id")
dw_measurements.inv_linkage.of_Register("ctx_rqmnt_category_id", "ctx_rqmnt_category_id")
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.13.2006 By: LeiWei
//$<reason> The variable without declaration is unsupported
//dw_measurements.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
dw_measurements.inv_linkage.of_SetStyle(dw_measurements.inv_linkage.retrieve)
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the update properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////
dw_profile.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_profile.inv_linkage.of_SetConfirmOnRowChange(TRUE)
dw_measurement_group.inv_linkage.of_SetUpdateOnRowChange(TRUE)
//dw_measurement_group.inv_linkage.of_SetConfirmOnRowChange(TRUE)


/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete delete style
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_profile.inv_linkage.of_SetDeleteStyle(dw_profile.inv_linkage.DELETE_ROWS)
dw_measurement_group.inv_linkage.of_SetDeleteStyle(dw_measurement_group.inv_linkage.bottomup  )

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

this.dw_profile.inv_linkage.of_SetConfirmOnDelete ( true )
//this.dw_measurement_group.inv_linkage.of_SetConfirmOnDelete ( true )		//Commented by Scofield on 2008-03-11
//this.dw_measurements.inv_linkage.of_SetConfirmOnDelete ( true )				//Commented by Scofield on 2008-03-11

dw_profile.inv_linkage.of_SetDeleteStyle ( 1 )
dw_measurements.inv_linkage.of_SetDeleteStyle ( 1 )
dw_measurement_group.inv_linkage.of_SetDeleteStyle ( 1 )

//Added By Ken.Guo 2010-11-19.
IF w_mdi.of_security_access( 5600 ) <> 2 THEN
	This.of_setreadonly( )
End If


end event

event pfc_endtran;call super::pfc_endtran;


 postevent("ue_set_to_current_profile( )") 
 
 if isvalid(w_contract) then 
	 w_contract.tab_contract_details.tabpage_requirements.of_refresh_dropdown( )
 end if
 
 return 1
end event

event pfc_updateprep;of_initial_parameters()
return super::event pfc_updateprep( apo_control[])
end event

type cb_copy from u_cb within w_contract_req_painter
string tag = "Copy this profile to another facility."
boolean visible = false
integer x = 2606
integer y = 1816
integer taborder = 41
fontcharset fontcharset = ansi!
boolean enabled = false
string text = "C&opy"
end type

event clicked;call super::clicked;/****************************************************************************************************************
** [PUBLIC] EVENT/FUNCTION selectionchanged :: UO_TAB_MEASUREMENTS
**--------------------------------------------------------------------------------------------------------------
** Description    : copy existing profile 
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

long il_profile_id 				// old profile id
long il_profile_id_new 			// new profile id
long ll_group_id 					// old group id
long ll_group_id_new 			// new group id
long ll_count,ll_i,ll_j 		// counters
long ll_group_measurement_id 	// measurement id
string ls_filter 					// filter string

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance  

parent.of_initial_parameters( )

//---------------------------- APPEON END ----------------------------


// datastore datawindows
string ls_datawindows[] = {'d_qa_profile_copy','d_qa_profile_group','d_qa_profile_group_measurements_copy'} 
ls_filter = 'profile_group_id = ' 
n_ds lds_array[] 

setnull(ll_group_measurement_id)
setnull(ll_group_id_new)
// STRUCTURES
str_pass lstr_pass
// DATASTORES
n_ds lds_profile
n_ds lds_group
n_ds lds_measurement
// create the array
lds_array[upperbound(lds_array) + 1] = lds_profile
lds_array[upperbound(lds_array) + 1] = lds_group
lds_array[upperbound(lds_array) + 1] = lds_measurement

// CREATE THE DATASTORES, ASSIGN DATAOBJECT,SETTRANSOBJECT
for ll_count = 1 to upperbound(lds_array)
	 lds_array[ll_count] = CREATE N_DS
	 lds_array[ll_count].dataobject = ls_datawindows[ll_count]
	 lds_array[ll_count].of_settransobject( sqlca)
next

il_profile_id = dw_profile.object.qa_profile_id[dw_profile.GETROW()]
// CREATE THE DATASTORES BASED IN THE QA_PROFILE_ID
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

for ll_count = 1 to upperbound(lds_array)
	 lds_array[ll_count].retrieve(il_profile_id)
next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

if lds_array[1].rowcount() < 1 and lds_array[2].rowcount() < 1 THEN return -1

// prompt the user for a new facility id/ profile name
lstr_pass.s_string = string(il_profile_id)
openwithparm(w_facility_view,lstr_pass)
lstr_pass = message.powerobjectparm
if isnull(lstr_pass.s_string) then
	return 
end if
// Get a new qa profile id
il_profile_id_new = parent.of_getsequence_number( )

// Get the group id from lds_group filter both lds_array[2] and lds_array[3] for each row in lds_array[2]
FOR ll_i = 1 TO lds_array[2].rowcount()
	 ll_group_id =  lds_array[2].object.profile_group_id[ll_i]
	  // FILTER
	 lds_array[3].setfilter(ls_filter + string(ll_group_id))
	 lds_array[3].filter()
	 // get a new group_id
	 if isnull(ll_group_id_new) then
	 		ll_group_id_new = dw_measurement_group.event ue_get_sequence_number( ) + 1
		else 
			ll_group_id_new = ll_group_id_new + 1
	 end if
	 // set the ID on the lds_array[2] datastore
	 lds_array[2].object.profile_group_id[ll_i] = ll_group_id_new
	 lds_array[2].object.qa_profile_id[ll_i] = il_profile_id_new
	 FOR ll_j = 1 TO  lds_array[3].rowcount()
			if isnull(ll_group_measurement_id) then
				ll_group_measurement_id = dw_measurements.event ue_get_sequence_number( )
	  			else
				ll_group_measurement_id = ll_group_measurement_id + 1
	 		end if
			
			lds_array[3].object.profile_group_id[ll_j] 		= ll_group_id_new
			lds_array[3].object.group_measurement_id[ll_j]  = ll_group_measurement_id
		   lds_array[3].object.qa_profile_id[ll_j] 			= il_profile_id_new
	 NEXT

NEXT	

// SET THE DATA IN THE HEADER DATASTORE
lds_array[1].object.qa_profile_id[1] = il_profile_id_new 
lds_array[1].object.profile_name[1] = lstr_pass.s_string
lds_array[1].object.facility_id[1] = lstr_pass.l_facility_id

// clear filters
for ll_count = 1 to upperbound(lds_array)
	lds_array[ll_count].setfilter('')
	lds_array[ll_count].filter()
next 

// set to new modifiled for insert 
for ll_count = 1 to upperbound(lds_array)
	of_set_insert( lds_array[ll_count])
next 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

// UPDATE
for ll_count = 1 to upperbound(lds_array)
	of_update(lds_array[ll_count] )
next 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

// DESTROY THE DATA STORES
for ll_count = 1 to upperbound(lds_array)
	DESTROY  lds_array[ll_count]
next 
// RETRIEVE THE HEADER
dw_profile.retrieve()
dw_profile.scrolltorow( dw_profile.rowcount())
dw_profile.selectrow( dw_profile.rowcount(), true)

end event

type dw_measurements from u_dw_contract within w_contract_req_painter
event ue_set_sequence_number ( )
event type long ue_get_sequence_number ( )
event ue_set_to_current_profile ( )
event ue_add_row pbm_dwnprocessenter
string tag = "Requirements"
integer x = 869
integer y = 808
integer width = 3561
integer height = 1092
integer taborder = 21
boolean titlebar = true
string title = "Requirements"
string dataobject = "d_contract_painter_elements"
boolean hscrollbar = true
boolean ib_retrieve_drop_downs = true
boolean ib_use_row_selection = true
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


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance  
/*
long ll_max_count

SELECT max(ctx_req_tmplt_element.ctx_req_tmplt_element_id)
INTO  :ll_max_count
FROM ctx_req_tmplt_element ;  

if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1
*/

return il_max_count_measurements + 1

//---------------------------- APPEON END ----------------------------



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
inv_rowmanager.of_setconfirmondelete( TRUE)
this.ib_rmbmenu = false	//04/25/2007 By Jervis





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

boolean lb_need_seq_number // sequence number place holder
long ll_row_count   			// row count place hilder
long ll_seq_number 			// the sequence number


// see if any rows need a sequence number, if so get the sequence number

for ll_row_count = 1 to this.rowcount( )
	if isnull(this.object.ctx_req_tmplt_element_id[ll_row_count]) then
		lb_need_seq_number = true
		ll_seq_number = this.event ue_get_sequence_number( )
		EXIT // NO NEED TO KEEP GOING
	end if
next

// SET THE SEQUENCE NUMBER AS NEEDED

IF lb_need_seq_number THEN
	FOR ll_row_count = 1 TO THIS.rowcount( )
		if isnull(this.object.ctx_req_tmplt_element_id[ll_row_count]) then 
			// bump up the counter
			ll_seq_number = ll_seq_number + 1
			this.object.ctx_req_tmplt_element_id[ll_row_count]  = ll_seq_number
		   this.object.ctx_req_profile_id[ll_row_count] =   parent.dw_profile.object.ctx_req_profile_id[dw_profile.getrow()]
			this.object.ctx_rqmnt_category_id[ll_row_count] =   parent.dw_measurement_group.object.ctx_rqmnt_category_id[dw_measurement_group.getrow()]
		end if 
	NEXT
END IF


return 1


end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;


this.of_setbase( true)
this.inv_base.of_SetColumnDisplayNameStyle ( 2 )
as_columnname = THIS.INV_base.OF_GETcolumndisplayname( as_columnname )

RETURN 1
end event

event pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
string ls_name

for ll_i = 1 to this.rowcount( )
	IF ISNULL(THIS.OBJECt.element_name[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('element_name')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row ' + string(ll_i) + '. Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('element_name')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.element_sort[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('element_sort')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row ' + string(ll_i) + '. Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('element_sort')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.value_type[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('value_type')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row ' + string(ll_i) + '. Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('value_type')
		RETURN FAILURE
	END IF
	
	IF THIS.OBJECt.value_type[ll_i] = 5 and  not f_validstr(string(THIS.OBJECt.dddw_name[ll_i]))  THEN
		ls_name = INV_base.OF_GETcolumndisplayname('dddw_name')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row ' + string(ll_i) + '. Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('dddw_name')
		RETURN FAILURE
	END IF
	
	
//	IF ISNULL(THIS.OBJECt.qa_measurement_include_in_profile[ll_i]) THEN
//		of_Messagebox('Validation Error','Save', 'Required value missing for Include In Profile on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
//		this.setfocus( )
//		this.setrow(ll_i)
//		setcolumn('qa_measurement_include_in_profile')
//		RETURN FAILURE
//	END IF
	
NEXT


RETURN success
end event

event pfc_addrow;call super::pfc_addrow;



of_setfocus(this,'element_name')
return success
end event

event losefocus;call super::losefocus;



parent.cb_close.default = true
end event

event ue_populatedddws;// override
end event

event doubleclicked;call super::doubleclicked;if row < 1 then return 
if  dwo.name = 'field_value' and object.value_type[row] = 5  then 
	of_set_dropdown_value()
end if
end event

event clicked;call super::clicked;IF dwo.name = "p_dropdown" THEN
	this.ScrollToRow( row )
	this.SetRow( row )		
	this.setcolumn('field_value')
	of_set_dropdown_value()
END IF
end event

type dw_measurement_group from u_dw_contract within w_contract_req_painter
event type long ue_get_sequence_number ( )
string tag = "Requirements Group"
integer x = 46
integer y = 808
integer width = 795
integer height = 1092
integer taborder = 21
boolean titlebar = true
string title = "Requirements Category"
string dataobject = "d_req_profile_painter_category"
boolean ib_use_row_selection = true
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

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-04-07 By: owe chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
/*
long ll_max_count
SELECT max(ctx_rqmnt_category.ctx_rqmnt_category_id)
INTO  :ll_max_count 
FROM ctx_rqmnt_category;


if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count
*/

return il_max_count_measurement_group

//---------------------------- APPEON END ----------------------------






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
inv_RowManager.of_SetConfirmOnDelete(TRUE)		//Modified by Scofield on 2008-03-11
//this.of_SetReqColumn(TRUE)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)
this.of_setbase( true)
inv_base.of_SetColumnDisplayNameStyle(inv_base.HEADER)
of_SetLinkage(true)
inv_linkage.of_SetMaster(dw_profile) 
inv_linkage.of_Register("ctx_req_profile_id", "ctx_req_profile_id")

inv_linkage.of_SetStyle(inv_linkage.retrieve )

this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

this.ib_rmbmenu = false	//04/25/2007 By Jervis

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

boolean lb_need_seq_number // sequence number place holder
long ll_row_count   			// row count place hilder
long ll_seq_number 			// the sequence number


// see if any rows need a sequence number, if so get the sequence number

for ll_row_count = 1 to this.rowcount( )
	if isnull(this.object.ctx_rqmnt_category_id[ll_row_count]) then
		lb_need_seq_number = true
		ll_seq_number = this.event ue_get_sequence_number( )
		EXIT // NO NEED TO KEEP GOING
	end if
next

// SET THE SEQUENCE NUMBER AS NEEDED

IF lb_need_seq_number THEN
	FOR ll_row_count = 1 TO THIS.rowcount( )
		if isnull(this.object.ctx_rqmnt_category_id[ll_row_count]) then 
			// bump up the counter
			ll_seq_number = ll_seq_number + 1
			this.object.ctx_rqmnt_category_id[ll_row_count]  = ll_seq_number
		   this.object.ctx_req_profile_id[ll_row_count] =   parent.dw_profile.object.ctx_req_profile_id[dw_profile.getrow()]
		end if 
	NEXT
END IF

this.of_accepttext(true)


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

event pfc_validation;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
string ls_name
for ll_i = 1 to this.rowcount( )
	IF ISNULL(THIS.OBJECt.category_name[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('category_name')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)
		this.setfocus( )
		

		RETURN FAILURE
	END IF
	
NEXT


RETURN success
end event

event dberror;


// override

if sqldbcode = -198 then
	Messagebox('Existing Data','This group cannot be deleted because there are records that reference this information.')
	this.RowsMove(1, this.DeletedCount(), Delete!, this, 1, Primary!)
	parent.dw_measurements.RowsMove(1, parent.dw_measurements.DeletedCount(), Delete!, parent.dw_measurements, 1, Primary!)
	return 1 // no error message
	
else
	super:: event dberror(sqldbcode,sqlerrtext,sqlsyntax,buffer,row)
end if
end event

event pfc_addrow;call super::pfc_addrow;

of_setfocus(this,'category_name')
return success
end event

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.

//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.

//---------------------------- APPEON END ----------------------------

end event

type dw_profile from u_dw_contract within w_contract_req_painter
string tag = "Requirements Profile"
integer x = 46
integer y = 152
integer width = 4384
integer height = 508
integer taborder = 30
boolean titlebar = true
string title = "Requirements Profile"
string dataobject = "d_req_profile_painter_master"
boolean hscrollbar = true
boolean ib_use_row_selection = true
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

this.of_SetRowManager(TRUE)
//this.inv_rowmanager.of_SetRestoreRow(TRUE)
//this.of_SetReqColumn(TRUE)
this.of_setlinkage( true)
//this.inv_reqcolumn.of_setcolumndisplaynamestyle(2)

this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )
this.of_setbase( true)
inv_base.of_SetColumnDisplayNameStyle(inv_base.HEADER)

this.ib_rmbmenu = false	//04/25/2007 By Jervis

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


if this.rowcount( ) > 0 then
	if isnull(this.getitemNumber(1,'ctx_req_profile_id')) then 
		il_qa_profile_id = of_getsequence_number()
		this.setitem(1,'ctx_req_profile_id', il_qa_profile_id)
	end if 
end if 


return 1


end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;


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
string ls_name

for ll_i = 1 to this.rowcount( )
	IF ISNULL(THIS.OBJECt.rqmnt_name[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('rqmnt_name')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('rqmnt_name')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.rqmnt_type[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('rqmnt_type')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('rqmnt_type')
		RETURN FAILURE
	END IF
	
	IF ISNULL(THIS.OBJECt.rqmnt_description[ll_i]) THEN
		ls_name = INV_base.OF_GETcolumndisplayname('rqmnt_description')
		of_Messagebox('Validation Error','Save', 'Required value missing for '+ ls_name +' on row. ' + string(ll_i) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		this.setrow(ll_i)
		setcolumn('rqmnt_description')
		RETURN FAILURE
	END IF
	

NEXT


RETURN success
end event

event pfc_addrow;call super::pfc_addrow;


of_setfocus(dw_profile,'rqmnt_name')
return success
end event

event rowfocuschanged;call super::rowfocuschanged;

if currentrow > 0 then
	il_qa_profile_id =  this.object.ctx_req_profile_id[currentrow]
	
end if 
end event

type cb_delete_measurement from u_cb within w_contract_req_painter
string tag = "Delete the selected measurement."
integer x = 1417
integer y = 680
integer width = 494
integer taborder = 41
string text = "Delete Requirement"
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
Long ll_element_id[]
if dw_measurements.rowcount( ) < 1 then return 

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-07-01 By: Ken.Guo
//$<reason> Check it whether being used.
ll_element_id[1] = dw_measurements.GetItemNumber(dw_measurements.GetRow(),"ctx_req_tmplt_element_id") 
If of_is_used(ll_element_id[]) Then Return -1
//---------------------------- APPEON END ----------------------------


////////////////////////////////////////////////////////////////////
// check to see if this group id is being used 
////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-16 By: Scofield
//$<Reason> Allow user to delete this row though this record is used by profile.

//ll_profile_id = parent.dw_measurements.object.ctx_req_tmplt_element_id[parent.dw_measurements.getRow()]
//
//select count(*)
//into  :ll_count
//from ctx_elements
//where ctx_elements.ctx_elements_id = :ll_profile_id;
//
//if ll_count > 0  then
//	Messagebox('Existing Records','There are records that referance this information. This measurement cannot be deleted!')
//	return -1
//else
//	parent.dw_measurements.event pfc_deleterow( )
//end if

dw_measurements.event pfc_deleterow( )

//---------------------------- APPEON END ----------------------------

return 1





end event

type cb_create_measurement from u_cb within w_contract_req_painter
string tag = "Add a measurement."
integer x = 891
integer y = 680
integer width = 494
integer taborder = 31
string text = "Create Requirement"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-04-10 By: WuZhiJun
//$<reason> Fix a defect.
long	ll_Count

ll_Count = dw_measurement_group.RowCount()
if ll_Count < 1 then
	MessageBox('Tip','Please select or add a Requirements Category at first.')
	return
end if
//---------------------------- APPEON END ----------------------------

parent.dw_measurements.of_accepttext( true)
if parent.dw_measurements.of_validation( ) <> failure then
		//parent.dw_measurements.of_SetRowManager(false)
		parent.dw_measurements.setcolumn( 'element_name')
		parent.dw_measurements.event pfc_addrow( )
end if
end event

type cb_delete_group from u_cb within w_contract_req_painter
string tag = "Delete the selected Measurement Group for this profile"
integer x = 448
integer y = 680
integer width = 393
integer taborder = 31
fontcharset fontcharset = ansi!
string text = "Delete Category"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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

long ll_count,ll_profile_id,i
long ll_element_id[]
// check to see if this group id is being used 

if parent.dw_measurement_group.rowcount() < 1 then return


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2009-07-01 By: Ken.Guo
//$<reason> Check it before delete.
If dw_measurements.RowCount() > 0 Then
	For i = 1 To dw_measurements.RowCount() 
		ll_element_id[i] = dw_measurements.GetItemNumber(i,"ctx_req_tmplt_element_id") 
	Next
	If of_is_used(ll_element_id[]) Then Return -1
End If
//---------------------------- APPEON END ----------------------------


//ll_profile_id = parent.dw_measurement_group.object.qa_profile_id[parent.dw_measurement_group.getRow()]

////////////////////////////////////////////////////////////////////////////
// make the user deleted each row
////////////////////////////////////////////////////////////////////////////

if parent.dw_measurements.rowcount() > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.23.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	messagebox('Existng Rows','There are existing child rows for this group. Please delete the associated measurements first.')
	*/
	messagebox('Existng Rows','There are existing child rows for this group. Please delete the associated requirements first.')	
	//---------------------------- APPEON END ----------------------------
	return
end if 

//
//////////////////////////////////////////////////////////////////////////////
//// check to see if the group is in use
//////////////////////////////////////////////////////////////////////////////
//
//select count(*) 
//into  :ll_count
//from  pd_qa_hdr
//where qa_profile_id = :ll_profile_id;
ll_count = 0
if ll_count > 0 then
	Messagebox('Existing Records','There are records that referance this information. This group cannot be deleted!')
else
	parent.dw_measurement_group.event pfc_deleterow( )
end if





end event

type cb_create_group from u_cb within w_contract_req_painter
string tag = "Craete a new Measurement Group for this profile."
integer x = 46
integer y = 680
integer width = 393
integer taborder = 21
string text = "Create Category"
end type

event clicked;call super::clicked;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.14.2006 By: LeiWei
//$<reason> Fix a defect.
/*
parent.dw_measurement_group.event pfc_addrow( )
*/

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-04-10 By: WuZhiJun
//$<reason> Fix a defect.
long	ll_Count

ll_Count = dw_profile.RowCount()
if ll_Count < 1 then
	MessageBox('Tip','Please select or add a Requirements Profile at first.')
	return
end if
//---------------------------- APPEON END ----------------------------


parent.dw_measurement_group.of_accepttext( true )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-09 By: Rodger Wu
//$<reason> Fix a defect.
integer li_getrow
li_getrow = dw_profile.GetRow()
if li_getrow > 0 then
	if dw_profile.GetItemStatus( li_getrow, 0, Primary! ) = NewModified! then
		cb_save.triggerevent( clicked! )
	end if
end if
//---------------------------- APPEON END ----------------------------

if parent.dw_measurement_group.of_validation( ) <> failure then
	parent.dw_measurement_group.event pfc_addrow()
end if

//---------------------------- APPEON END ----------------------------

end event

type cb_delete_profile from u_cb within w_contract_req_painter
string tag = "Delete the Quality Profile."
integer x = 453
integer y = 32
integer width = 361
integer taborder = 20
string text = "Delete Profile"
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

long ll_ctx_req_profile_id,ll_row,ll_count
Long ll_ctx_id

if dw_profile.rowcount() < 1 then return


ll_row = dw_profile.getrow()
if ll_row <= 0 then return -1
ll_ctx_req_profile_id = dw_profile.getitemnumber(ll_row,'ctx_req_profile_id')

//Added By Ken.Guo 2009-07-01. Check CTX whether use the profile
Select top 1 ctx_id Into :ll_ctx_id from ctx_req_profile_hdr Where ctx_req_profile_id = :ll_ctx_req_profile_id;
If ll_ctx_id > 0 Then
	Messagebox('Failure','This profile being used by CTX ' + String(ll_ctx_id) + '.' )
	Return -1
End If

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2007 By: Frank.Gui
//$<reason> 
IF messagebox("Delete Profile","Are you sure you want to delete current selected profile and all its details?",question!,yesno!,2) = 2 THEN
	return
END IF
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01.13.2006 By: owen chen
//$<reason> the column name 'qa_profile_id' is not in datawindow 'dw_profile'
//if parent.of_check_for_groups(dw_profile.object.qa_profile_id[dw_profile.getrow()]) then
if parent.of_check_for_groups(dw_profile.object.ctx_req_profile_id[dw_profile.getrow()]) then
//---------------------------- APPEON END ----------------------------

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.30.2007 By: Jack
	//$<reason> Fix a defect.
	
	select count(ctx_req_profile_hdr_id) into :ll_count from ctx_elements where ctx_req_profile_hdr_id in (select ctx_req_profile_hdr.ctx_req_profile_hdr_id from  ctx_req_profile_hdr where ctx_req_profile_hdr.ctx_req_profile_id = :ll_ctx_req_profile_id);	
	If ll_count > 0 Then
		messagebox(parent.title,"This profile is used in the contract. It cannot be deleted.")
		return
	End If
	//---------------------------- APPEON END ----------------------------
		
	gnv_appeondb.of_startqueue( )
	delete from CTX_REQ_TMPLT_ELEMENT where ctx_req_profile_id = :ll_ctx_req_profile_id;
	delete from CTX_RQMNT_CATEGORY where ctx_req_profile_id = :ll_ctx_req_profile_id;
	delete from CTX_REQ_PROFILE_HDR where ctx_req_profile_id = :ll_ctx_req_profile_id;
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.30.2007 By: Jack
	//$<reason> Fix a defect.
	delete from ctx_elements where ctx_req_profile_hdr_id in (select ctx_req_profile_hdr.ctx_req_profile_hdr_id from  ctx_req_profile_hdr where ctx_req_profile_hdr.ctx_req_profile_id = :ll_ctx_req_profile_id);	
	//---------------------------- APPEON END ----------------------------
	dw_measurements.reset()
	dw_measurement_group.reset()
	dw_profile.deleterow(0)
	dw_profile.update()
	dw_profile.retrieve()
	gnv_appeondb.of_commitqueue( )
//	dw_profile.triggerevent('rowfocuschanged')
	//---------------------------- APPEON END ----------------------------
else
	MessageBox(parent.title, 'Please delete all of the groups for this profile before continuing.')
end if







end event

type cb_create_profile from u_cb within w_contract_req_painter
string tag = "Create a new Quality Profile"
integer x = 73
integer y = 32
integer width = 361
integer taborder = 20
string text = "Create Profile"
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

type gb_profile from u_gb within w_contract_req_painter
boolean visible = false
integer x = 338
integer y = 16
integer width = 3328
integer height = 556
integer taborder = 10
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Requirements Profile"
end type

type gb_measurements from u_gb within w_contract_req_painter
boolean visible = false
integer x = 914
integer y = 596
integer width = 2418
integer height = 1192
integer taborder = 11
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Requirements"
end type

type gb_measurement_group from u_gb within w_contract_req_painter
boolean visible = false
integer x = 9
integer y = 596
integer width = 882
integer height = 1192
integer taborder = 10
fontcharset fontcharset = ansi!
long backcolor = 33551856
string text = "Requirements Group"
end type

type cb_select from commandbutton within w_contract_req_painter
integer x = 2921
integer y = 28
integer width = 352
integer height = 92
integer taborder = 51
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect"
end type

event clicked;long	ll_Profile_id,ll_Row

ll_Row = dw_profile.GetRow()
if ll_Row > 0 and ll_Row <= dw_profile.RowCount() then
	ll_Profile_id = dw_profile.GetItemNumber(ll_Row,"ctx_req_profile_id")
end if

CloseWithReturn(Parent,ll_Profile_id)

end event

type cb_close from u_cb within w_contract_req_painter
string tag = "Close the window"
integer x = 4078
integer y = 28
integer taborder = 31
boolean bringtotop = true
string text = "&Close"
end type

event clicked;call super::clicked;

//cb_save.event clicked( )

//parent.event pfc_close( )

CloseWithReturn(Parent,-9)

end event

type cb_preview from u_cb within w_contract_req_painter
string tag = "Preview the data."
integer x = 3698
integer y = 28
integer taborder = 21
boolean bringtotop = true
string text = "&Preview"
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
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long ll_found_row
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.25.2007 By: Jack
//$<reason> Fix a defect. 
If dw_profile.rowcount() < 1 Then Return
//---------------------------- APPEON END ----------------------------


parent.cb_save.event clicked( )
ll_found_row = parent.dw_profile.FIND( 'ctx_req_profile_id = ' + string(il_qa_profile_id) , 1,parent.dw_profile.rowcount())
parent.dw_profile.SCROLLTOrow(ll_found_row)

openwithparm(w_ctx_report_preview, il_qa_profile_id )
end event

type cb_save from u_cb within w_contract_req_painter
string tag = "Save the new data."
integer x = 3310
integer y = 28
integer taborder = 21
boolean bringtotop = true
string text = "&Save"
boolean default = true
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

long	ll_category_id,ll_elements_id,ll_FindRow

POWEROBJECT lpw_pw[]

lpw_pw[1] = parent.dw_measurements
lpw_pw[2] = parent.dw_measurement_group
lpw_pw[3] = parent.dw_profile

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-04-07 By: owen chen
//$<reason> Performance tuning modification
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance 
/*
// the profile that was just saved. This is used to set the focus back to this profile
if parent.dw_measurements.rowcount() > 0 then
	il_qa_profile_id_saved  = parent.dw_measurements.object.ctx_req_profile_id[parent.dw_measurements.getrow()]
end if 

if  parent.event pfc_SaveObjects(lpw_pw[])> 0 then
	 parent.event pfc_postopen( )
end if

// MSKINNER 15 fEBUARY 2006 -- BEGIN
gnv_app.ib_ref_cache = true
gnv_app.of_setcontraccache("" )
// MSKINNER 15 fEBUARY 2006 -- END

*/

Integer li_rc
li_rc = of_UpdateChecks(lpw_pw)
If li_rc > 0 Then 
	dw_profile.accepttext( )
	dw_measurement_group.accepttext( )
	dw_measurements.accepttext( )
	
	if dw_profile.event pfc_validation( ) <> 1 then
		return
	end if
	if dw_measurement_group.event pfc_validation( ) <> 1 then
		return
	end if
	if dw_measurements.event pfc_validation( ) <> 1 then
		return
	end if
	
	parent.of_initial_parameters( )
	
	dw_profile.event pfc_updateprep( )
	dw_measurement_group.event pfc_updateprep( )
	dw_measurements.event pfc_updateprep( )

	parent.of_preupdatetotal()
	of_get_changed_element() //Added By Ken.Guo 2009-07-01.
	if gnv_appeondb.of_update(dw_profile, dw_measurement_group, dw_measurements)	> 0 then
		commit;
		
		// the profile that was just saved. This is used to set the focus back to this profile
		if parent.dw_measurements.rowcount() > 0 then
			il_qa_profile_id_saved  = parent.dw_measurements.object.ctx_req_profile_id[parent.dw_measurements.getrow()]
		end if 
		
		//---------Begin Modified by (Appeon)Harry 07.23.2013 --------
		//BEGIN---Modify by Scofield on 2009-08-17
		//ll_category_id = dw_measurement_group.GetItemNumber(dw_measurement_group.GetRow(),"ctx_rqmnt_category_id")
		//ll_elements_id = dw_measurements.GetItemNumber(dw_measurements.GetRow(),"ctx_req_tmplt_element_id")
		if dw_measurement_group.GetRow() > 0 then
			ll_category_id = dw_measurement_group.GetItemNumber(dw_measurement_group.GetRow(),"ctx_rqmnt_category_id")
		end if
		if dw_measurements.GetRow() > 0 then
			ll_elements_id = dw_measurements.GetItemNumber(dw_measurements.GetRow(),"ctx_req_tmplt_element_id")
		end if
		//---------End Modfiied ------------------------------------------------------
		
		parent.event pfc_postopen( )
		parent.Event ue_update_template()
		
		ll_FindRow = dw_measurement_group.Find("ctx_rqmnt_category_id = " + String(ll_category_id),1,dw_measurement_group.RowCount())
		if ll_FindRow > 0 then
			dw_measurement_group.ScrollToRow(ll_FindRow)
			dw_measurement_group.SetRow(ll_FindRow)
			dw_measurement_group.SetFocus()
		end if
		
		ll_FindRow = dw_measurements.Find("ctx_req_tmplt_element_id = " + String(ll_elements_id),1,dw_measurements.RowCount())
		if ll_FindRow > 0 then
			dw_measurements.ScrollToRow(ll_FindRow)
			dw_measurements.SetRow(ll_FindRow)
			dw_measurements.SetFocus()
		end if
		//END---Modify by Scofield on 2009-08-17
	end if

	//
	String ls_dw
	ls_dw = "dddw_cntx_profiles"
	gnv_app.inv_dwcache.of_unRegister(ls_dw)
	gnv_app.inv_dwcache.of_Register(ls_dw, ls_dw, SQLCA, true)

end if 
//--------------------------- APPEON END ---------------------------

end event

