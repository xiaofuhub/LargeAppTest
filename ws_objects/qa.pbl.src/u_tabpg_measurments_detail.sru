$PBExportHeader$u_tabpg_measurments_detail.sru
forward
global type u_tabpg_measurments_detail from u_tabpg
end type
type st_1 from u_st_splitbar within u_tabpg_measurments_detail
end type
type dw_measuremt_detail from u_dw within u_tabpg_measurments_detail
end type
type dw_measuremt_header from u_dw within u_tabpg_measurments_detail
end type
end forward

global type u_tabpg_measurments_detail from u_tabpg
integer width = 3529
integer height = 1704
string text = "Detail"
string picturename = "DataWindow1!"
st_1 st_1
dw_measuremt_detail dw_measuremt_detail
dw_measuremt_header dw_measuremt_header
end type
global u_tabpg_measurments_detail u_tabpg_measurments_detail

type prototypes
SUBROUTINE GetClientRect (ULONG hClntWnd, REF STR_CLIENT_RECT lpRect) LIBRARY "USER32.DLL" alias for "GetClientRect;Ansi" 
end prototypes

type variables

boolean ib_new
long li_measuremtent_id 

boolean ib_delete
long ll_original_width
boolean lb_retrirved
n_ds lds_appointment_dates
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.21.2006 By: Liang QingShi
//$<reason> Performance tuning
long il_pd_qa_hdr_id
//---------------------------- APPEON END ----------------------------


protected: 
long il_prac_id
end variables

forward prototypes
public subroutine of_retrieve_master_dw (long al_header_id)
public subroutine of_set_not_new ()
public subroutine of_set_delete (boolean ab_bool)
public subroutine of_get_appointment_dates (string al_method)
public subroutine of_set_prac_id (long al_prac_id)
public function integer of_add_missing ()
end prototypes

public subroutine of_retrieve_master_dw (long al_header_id);////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : of_retrieve_master_dw
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

// clear out all existing data

this.event ue_reset( )

if isnull(al_header_id) then return
this.dw_measuremt_header.retrieve(al_header_id)

if not ib_new then
	
	if this.dw_measuremt_detail.dataobject <> 'd_pd_qa_detail_existing' then
		this.dw_measuremt_detail.dataobject = 'd_pd_qa_detail_existing'
		this.dw_measuremt_detail.of_settransobject( sqlca)
	ELSE
		
		
end if
	
end if
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-07-05 By: Liu Hongxin
//$<reason> Overlap with clause: dw_measuremt_header.retrieve()
/*
this.dw_measuremt_detail.retrieve(al_header_id)
*/
//---------------------------- APPEON END ----------------------------
end subroutine

public subroutine of_set_not_new ();

ib_new = FALSE
end subroutine

public subroutine of_set_delete (boolean ab_bool);


this.ib_delete = ab_bool
end subroutine

public subroutine of_get_appointment_dates (string al_method);///of_get_appointment_dates( )

if dw_measuremt_header.rowcount( ) < 1 then return 

if lds_appointment_dates.rowcount( )  > 0 THEN
	dw_measuremt_header.object.appointment_start_date[1] =  string(lds_appointment_dates.object.apptmnt_start_date[1],'mm/dd/yyyy')
	dw_measuremt_header.object.appointment_end_date[1] =     string(lds_appointment_dates.object.apptmnt_end_date[1],'mm/dd/yyyy')
END IF

choose case al_method
	case 'add'
			dw_measuremt_header.setitemstatus( 1, 0, primary!, new!)
	case 'insert'
		   dw_measuremt_header.setitemstatus( 1, 0, primary!, notmodified!)
	case else
end choose


end subroutine

public subroutine of_set_prac_id (long al_prac_id);



il_prac_id = al_prac_id
end subroutine

public function integer of_add_missing ();/******************************************************************************************************************
**  [PUBLIC]   : of_add_missing
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  10 May 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/


// add missing items

if dw_measuremt_detail.rowcount() < 1 then return 0

datastore lds
lds = create datastore
lds.dataobject = 'd_pd_qa_detail'
lds.settransobject( sqlca)
lds.retrieve( dw_measuremt_detail.object.qa_measurement_qa_profile_id[1]   )

long ll_i,ll_j, ll_new_row
string ls_current_measurement_name, ll_string
boolean lb_found
//----Begin Added by Alfee on 03.06.2009 -----
long ll_group_id, ll_current_group_id 
string ls_group_name 
boolean lb_refresh = false  
//----End Added -------------------------------

li_measuremtent_id =  dw_measuremt_detail.event ue_get_sequence_number()
for ll_i = 1 to lds.rowcount()
	lb_found = false
	ls_current_measurement_name = lds.object.qa_measurement_qa_measurement_name[ll_i]
   //-------Begin Modified by Alfee on 03.06.2009-----------------------------
	ll_group_id = lds.object.qa_measurement_qa_profile_group_id[ll_i] 
	ls_group_name = lds.object.qa_profile_group_qa_profile_group_name[ll_i]
	for ll_j = 1 to dw_measuremt_detail.rowcount()
		ll_string = dw_measuremt_detail.object.qa_measurement_qa_measurement_name[ll_j]
	   ll_current_group_id = dw_measuremt_detail.object.qa_measurement_qa_profile_group_id[ll_j]
	   if ll_string =  trim(ls_current_measurement_name) and ll_current_group_id = ll_group_id then
		  lb_found = true
	   end if 	 	  
   next	
	/* for ll_j = 1 to dw_measuremt_detail.rowcount()
		ll_string = dw_measuremt_detail.object.qa_measurement_qa_measurement_name[ll_j]
	  if ll_string =  trim(ls_current_measurement_name) then			  
		 lb_found = true
	  end if 	 	  
   next */
	//------End Modified ------------------------------------------------------
	
	if not lb_found then
		ll_new_row = dw_measuremt_detail.insertrow(0)
		li_measuremtent_id = li_measuremtent_id +1
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.09.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		dw_measuremt_detail.object.qa_measurement_qa_measurement_name[ll_new_row] =  ls_current_measurement_name
		dw_measuremt_detail.object.pd_qa_measurements_profile_group_measurement_id[ll_new_row] = lds.object.qa_measurement_profile_group_measurement_id[ll_i]  
		dw_measuremt_detail.object.pd_qa_measurements_pd_qa_measurements_id[ll_new_row]  = li_measuremtent_id +1
		dw_measuremt_detail.object.pd_qa_hdr_id[ll_new_row] =dw_measuremt_header.object.pd_qa_hdr_id[1]
		*/		
		dw_measuremt_detail.Setitem( ll_new_row, "qa_measurement_qa_measurement_name", ls_current_measurement_name)
		dw_measuremt_detail.Setitem( ll_new_row, "pd_qa_measurements_profile_group_measurement_id", lds.GetitemNumber(ll_i,"qa_measurement_profile_group_measurement_id"))
		dw_measuremt_detail.Setitem( ll_new_row, "pd_qa_measurements_pd_qa_measurements_id", li_measuremtent_id +1)
		dw_measuremt_detail.Setitem( ll_new_row, "pd_qa_hdr_id", dw_measuremt_header.GetitemNumber(1,"pd_qa_hdr_id"))
		//-----------Begin Added by Alfee 03.06.2009	------------------------
		dw_measuremt_detail.Setitem( ll_new_row, "qa_measurement_qa_profile_group_id", ll_group_id)		
		dw_measuremt_detail.Setitem( ll_new_row, "qa_profile_group_qa_profile_group_name", ls_group_name)
		lb_refresh = TRUE		
		//-----------End Added -----------------------------------------------
		//---------------------------- APPEON END ----------------------------
	end if
	ll_j = 1
	lb_found = false	
next
ll_i = 1 

//---Begin Added by Alfee 03.06.2009 ---------
IF lb_refresh THEN
	dw_measuremt_detail.SetRedraw(FALSE)
	dw_measuremt_detail.sort()
	dw_measuremt_detail.groupcalc()
	dw_measuremt_detail.SetRedraw(TRUE)	
END IF
//---End Added --------------------------------

return 0
end function

on u_tabpg_measurments_detail.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_measuremt_detail=create dw_measuremt_detail
this.dw_measuremt_header=create dw_measuremt_header
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_measuremt_detail
this.Control[iCurrent+3]=this.dw_measuremt_header
end on

on u_tabpg_measurments_detail.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_measuremt_detail)
destroy(this.dw_measuremt_header)
end on

event constructor;call super::constructor;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : EVENT constructor
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
//

this.of_setresize( true)

dw_measuremt_header.of_SetLinkage(true)
dw_measuremt_detail.of_SetLinkage(true)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the linkage stuff
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

dw_measuremt_detail.inv_linkage.of_SetMaster(dw_measuremt_header)
dw_measuremt_detail.inv_linkage.of_Register("pd_qa_hdr_id", "pd_qa_hdr_id") 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-02
//$<modify> 01.13.2006 By: LeiWei
//$<reason> It is unsupported on the Web to use an object without creating it first.
//$<modification> Create the object first and then use it.
//dw_measuremt_detail.inv_linkage.of_SetStyle(n_cst_dwsrv_linkage.retrieve)
n_cst_dwsrv_linkage lnv_cst_dwsrv_linkage
lnv_cst_dwsrv_linkage = Create n_cst_dwsrv_linkage
dw_measuremt_detail.inv_linkage.of_SetStyle(lnv_cst_dwsrv_linkage.retrieve)
Destroy lnv_cst_dwsrv_linkage
//---------------------------- APPEON END ----------------------------

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the update properties for the datawindows
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_measuremt_header.inv_linkage.of_SetUpdateOnRowChange(TRUE)
////dw_measuremt_detail.inv_linkage.of_SetUpdateOnRowChange(TRUE)

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// set the delete delete style
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
dw_measuremt_header.inv_linkage.of_SetConfirmOnDelete ( true )
dw_measuremt_detail.inv_linkage.of_SetConfirmOnDelete ( true )
dw_measuremt_detail.inv_linkage.of_confirmonrowchange()

//dw_measuremt_detail.inv_linkage.of_set = false
dw_measuremt_header.inv_linkage.of_SetDeleteStyle(dw_measuremt_detail.inv_linkage.delete_rows)


// set the transactionobject on the master datawindow
this.dw_measuremt_header.inv_linkage.of_settransobject( sqlca)

///this.dw_measuremt_header.event pfc_retrieve( )


end event

type st_1 from u_st_splitbar within u_tabpg_measurments_detail
integer y = 704
integer width = 3511
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;this.of_Register(parent.dw_measuremt_header , above)


this.of_Register(parent.dw_measuremt_detail , BELOW )


this.of_SetBarColor(rgb(128,0,0)  )
end event

type dw_measuremt_detail from u_dw within u_tabpg_measurments_detail
event type long ue_get_sequence_number ( )
event ue_add_missing ( )
integer y = 736
integer width = 3511
integer height = 920
integer taborder = 20
string dataobject = "d_pd_qa_detail_existing"
boolean hscrollbar = true
end type

event type long ue_get_sequence_number();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_get_sequence_number
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

dec ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."pd_qa_measurements"."pd_qa_measurements_id")
//INTO :ll_max_count 
//FROM "dba"."pd_qa_measurements" ;

SELECT max(pd_qa_measurements.pd_qa_measurements_id)
INTO :ll_max_count 
FROM pd_qa_measurements ;

//---------------------------- APPEON END ----------------------------
if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1


end event

event ue_add_missing();
parent.of_add_missing( )
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
this.of_SetRowSelect(TRUE)
this.inv_rowselect.of_SetStyle(this.inv_rowselect.single )

ll_original_width = this.width




end event

event pfc_updateprep;call super::pfc_updateprep;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : PFC_UPDATEPREP
//==================================================================================================================
//  Purpose   	: open event
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [INTEGER] 1 KEEP GOING     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Wednesday 13 October 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

long ll_i

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IF WE WE ARE DELETING THEN THERE WILL NO ROWS, RETURN WITH SUCCESS
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if parent.dw_measuremt_header.rowcount( ) < 1 then return SUCCESS 
if parent.dw_measuremt_detail.ROWCOUNT() <  1 then return SUCCESS

if not ib_delete then
 
 
	if isnull(this.object.pd_qa_measurements_pd_qa_measurements_id[1]) then
		li_measuremtent_id  = this.event ue_get_sequence_number()
	end if
	  
	  
	if isnull(this.object.pd_qa_measurements_pd_qa_measurements_id[1]) then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.12.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		this.object.pd_qa_measurements_pd_qa_measurements_id[1] =  li_measuremtent_id		
		*/
		this.SetItem(1, "pd_qa_measurements_pd_qa_measurements_id",li_measuremtent_id)
		//---------------------------- APPEON END ----------------------------
	
		for ll_i = 1 to this.rowcount( )
				li_measuremtent_id = li_measuremtent_id + 1
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 08.12.2006 By: LeiWei
				//$<reason> Fix a defect.
				/*
				this.object.pd_qa_measurements_pd_qa_measurements_id[ll_i] =  li_measuremtent_id
				this.object.pd_qa_hdr_id[ll_i] = parent.dw_measuremt_header.object.pd_qa_hdr_id[1]
				this.object.pd_qa_measurements_profile_group_measurement_id[ll_i] = this.object.qa_measurement_profile_group_measurement_id[ll_i]  
				*/
				this.SetItem(ll_i, "pd_qa_measurements_pd_qa_measurements_id",li_measuremtent_id)
				this.SetItem(ll_i, "pd_qa_hdr_id",parent.dw_measuremt_header.GetItemNumber(1,"pd_qa_hdr_id"))
				this.SetItem(ll_i, "pd_qa_measurements_profile_group_measurement_id",this.GetItemNumber(ll_i,"qa_measurement_profile_group_measurement_id"))
				//---------------------------- APPEON END ----------------------------
		next
	
	end if
	accepttext( )

end if

RETURN SUCCESS

end event

event pfc_addrow;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_addrow
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

// override
// trigger  the addrow event on the header
parent.dw_measuremt_header.event pfc_addrow( )


return success
end event

event retrieveend;call super::retrieveend;
if lb_retrirved then return 1

if rowcount < 1 then return 1
parent.dw_measuremt_detail.Object.DataWindow.Zoom = parent.dw_measuremt_header.Object.DataWindow.Zoom

parent.POST OF_add_missing( )

//for ll_i = 1 to rowcount
//	//dw_1.object.col1.EditMask.Mask = "##: ####"  //for numeric
//	if 
//	
//	Object.pd_qa_measurements_measurement_value.EditMask.Mask
//next
end event

event updateend;call super::updateend;
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : UPDATEEND
//==================================================================================================================
//  Purpose   	: 
//==================================================================================================================
//  Arguments 	: 
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


//TRY
	// BROAD CAST THE NEW HEADER ID SO THAT THE REPORTS CAN SEE IT
	IF PARENT.dw_measuremt_header.ROwcount( ) > 0 THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.21.2006 By: Liang QingShi
		//$<reason> Fix a defect.
		/*
    	iw_parent.DYNAMIC of_set_hdr_id(PARENT.dw_measuremt_header.OBJECT.pd_qa_hdr_id[1] )
		*/
		//---------------------------- APPEON END ----------------------------
		if isvalid(iw_parent) then
    		iw_parent.DYNAMIC of_set_hdr_id(PARENT.dw_measuremt_header.OBJECT.pd_qa_hdr_id[1] )
		end if
   END IF

//CATCH (RunTimeError rte)
     // messagebox("Runtime Error",'Function of_set_hdr_id() does not exist on the parent window!' + '~r~r' +  rte.getmessage()  )
//END TRY
end event

event rbuttondown;call super::rbuttondown;
m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(dw_measuremt_detail )
NewMenu.m_measurements.visible = true



//NewMenu.m_options.m_mailall.visible = false
//NewMenu.m_options.m_printall.visible = false
//NewMenu.m_options.m_printcurrent.text = 'Print'
//NewMenu.m_options.m_mailcurrent.text = 'Mail'
NewMenu.m_measurements.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
end event

event sqlpreview;call super::sqlpreview;
//
//if request = PreviewFunctionUpdate! then
////	This.SelectRow(0, FALSE)
////   This.SelectRow(row, TRUE)
//end if
end event

type dw_measuremt_header from u_dw within u_tabpg_measurments_detail
event type long ue_get_sequence_number ( )
event type decimal ue_get_sequence_number_master ( )
integer width = 3511
integer height = 704
integer taborder = 10
string dataobject = "d_pd_qa_header"
boolean vscrollbar = false
boolean livescroll = false
end type

event type long ue_get_sequence_number();////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_get_sequence_number
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

long ll_count

SELECT max(pd_qa_measurements_id )
into :ll_count
FROM pd_qa_measurements;

return ll_count + 1






end event

event type decimal ue_get_sequence_number_master();
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : ue_get_sequence_number_master
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

dec ll_max_count

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2005-11-16 By: Liang QingShi
//$<reason> 

//SELECT max("dba"."pd_qa_hdr"."pd_qa_hdr_id")
//INTO :ll_max_count 
//FROM "dba"."pd_qa_hdr" ;

SELECT max(pd_qa_hdr.pd_qa_hdr_id)
INTO :ll_max_count 
FROM pd_qa_hdr ;
//---------------------------- APPEON END ----------------------------

if isnull(ll_max_count) then ll_max_count = 0

return ll_max_count + 1


end event

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

//this.settransobject(sqlca)

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


lds_appointment_dates = create n_ds
lds_appointment_dates.dataobject = 'd_measurements_dates'
lds_appointment_dates.of_settransobject( sqlca)






end event

event itemchanged;call super::itemchanged;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : itemchanged
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

// retrieve the profile information based on the profile selected
long ll_i
string ls_find_str
string ls_measurement_name
long ll_id
long ll_group_id //alfee 03.06.2009

choose case dwo.name
	case 'qa_profile_id'
	
		if ib_new then	
				datastore lds
				lds = create datastore
				lds.dataobject = 'd_pd_qa_detail'
				lds.settransobject(sqlca)
				lds.retrieve(long(data))
				
				parent.dw_measuremt_detail.dataobject = 'd_pd_qa_detail'
				parent.dw_measuremt_detail.setTransObject(sqlca)
				
             dw_measuremt_detail.setredraw( false )
				 // copy the first row
				lds.RowsCopy(1, 1, Primary!, parent.dw_measuremt_detail, 1, Primary!)
				// get the group measurement id for the next row in the datastore and 
				// look for it in the datawindow
				
				FOR ll_i = 2 TO lds.rowcount( )
					ls_measurement_name = lds.object.qa_measurement_qa_measurement_name[ll_i]
					//---------Begin Modified by Alfee 03.06.2009 -----------------------------
					ll_group_id = lds.object.qa_measurement_qa_profile_group_id[ll_i] 
					ls_find_str = "qa_measurement_qa_measurement_name = '" + ls_measurement_name + "'"
					ls_find_str += " and qa_measurement_qa_profile_group_id = " + String(ll_group_id) 
					//ls_find_str = "qa_measurement_qa_measurement_name = '" + ls_measurement_name + "'"
					//---------End Modified ----------------------------------------------------
					IF parent.dw_measuremt_detail.Find(ls_find_str, 1, parent.dw_measuremt_detail.rowcount()) < 1 THEN
						lds.RowsCopy(ll_i, ll_i, Primary!, parent.dw_measuremt_detail, ll_i, Primary!)
					END IF
	
				NEXT
				
				FOR ll_i = 1 to parent.dw_measuremt_detail.rowcount( )
					setnull(li_measuremtent_id)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<modify> 08.09.2006 By: LeiWei
					//$<reason> Fix a defect.
					/*
					parent.dw_measuremt_detail.object.pd_qa_measurements_pd_qa_measurements_id[ll_i] = li_measuremtent_id
					parent.dw_measuremt_detail.object.pd_qa_measurements_profile_group_measurement_id[ll_i] = li_measuremtent_id
					parent.dw_measuremt_detail.object.pd_qa_measurements_measurement_value[ll_i] = li_measuremtent_id
					*/
					parent.dw_measuremt_detail.Setitem( ll_i, "pd_qa_measurements_pd_qa_measurements_id", li_measuremtent_id)
					parent.dw_measuremt_detail.Setitem( ll_i, "pd_qa_measurements_profile_group_measurement_id", li_measuremtent_id)
					parent.dw_measuremt_detail.Setitem( ll_i, "pd_qa_measurements_measurement_value", li_measuremtent_id)
					//---------------------------- APPEON END ----------------------------
					
				NEXT
			
			parent.dw_measuremt_detail.Object.DataWindow.Zoom = parent.dw_measuremt_header.Object.DataWindow.Zoom
			
			dw_measuremt_detail.setredraw( true)
			///ib_new = false
		end if 
	case 'prac_id'
		
		il_prac_id = long(data)
		n_ds  lds_pac_dates
		lds_pac_dates =CREATE n_ds
		lds_pac_dates.dataobject = 'd_pd_appointment_dates'
		lds_pac_dates.of_settransobject( sqlca)
		long ll_profile_id
		ll_profile_id = long(data)
		if lds_pac_dates.retrieve(il_prac_id) > 0 then
			this.object.from_date[1] = lds_pac_dates.object.apptmnt_start_date[1]
			this.object.to_date[1]   = lds_pac_dates.object.apptmnt_end_date[1]
		end if
		DESTROY lds_pac_dates
		
	case 'qa_profile_id'
		// get the current appointment dates and plug them in
		
		
end choose


return 0
end event

event pfc_addrow;///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_addrow
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
// OVERRIDE

IF THIS.OF_UPdatespending( ) > 0 then
	if Messagebox('Save Changes', 'Do you want to save changes?',question!,yesNo!) = 1 then
	IF iw_parent.DYNAMIC event PFC_save() < 0 THEN RETURN -1
	end if 
end if

ib_new = TRUE
this.ib_rmbmenu = false
this.reset( )

ib_delete = false

Super::EVENT pfc_addrow()

lds_appointment_dates.retrieve(il_prac_id)

this.object.prac_id[1] =  il_prac_id

of_get_appointment_dates('add')

return 1
end event

event pfc_updateprep;call super::pfc_updateprep;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : pfc_updateprep
//==================================================================================================================
//  Purpose   	: Assign the needed key values
//==================================================================================================================
//  Arguments 	: [none] 
//==================================================================================================================
//  Returns   	: [intreger]     
//==================================================================================================================
//  Notes     	: 	   
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if this.rowcount( ) < 1 then return 1

this.accepttext( )
if not ib_delete then 
		// set the primary key
		if isnull(this.object.pd_qa_hdr_id[1]) then
			
			this.object.pd_qa_hdr_id[1] = this.event ue_get_sequence_number_master( )
			iw_parent.function dynamic  of_set_hdr_id(this.object.pd_qa_hdr_id[1]  )
		end if
		
end if

return 1
end event

event pfc_checkrequirederror;call super::pfc_checkrequirederror;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  [PUBLIC]   : PFC_CHECKREQUIREDERROR
//==================================================================================================================
//  Purpose   	: This event will get the column display name so that it will be properly displayed
//					  in the messagebox
//==================================================================================================================
//  Arguments 	: [long]  	al_row
//					: [string]	as_columnname
//==================================================================================================================
//  Returns   	: [integer]     
//==================================================================================================================
//  Notes     	: 	None    
//==================================================================================================================
//  Created By	: Michael Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


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
//  Created By	: Michael B. Skinner  Thursday  October 14, 2004
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

if this.rowcount( ) < 1 THEN RETURN 1


IF ISNULL(THIS.OBJECt.qa_profile_id[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Profile on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('qa_profile_id')
		RETURN FAILURE
END IF


IF ISNULL(THIS.OBJECt.reason[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Reason on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('reason')
		RETURN FAILURE
END IF

IF ISNULL(THIS.OBJECt.from_date[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for From Date on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('from_date')
		RETURN FAILURE
END IF

IF ISNULL(THIS.OBJECt.to_date[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for To Date on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('to_date')
		RETURN FAILURE
END IF



IF ISNULL(THIS.OBJECt.active_status[1]) THEN
		of_Messagebox('Validation Error','Validation Error', 'Required value missing for Active Status on row. ' + string(1) + ' Please enter a value', Exclamation!, Ok!, 1)   
		this.setfocus( )
		setcolumn('active_status')
		RETURN FAILURE
END IF


// make sure the the end date is equal of later then start date
if DaysAfter( date(this.object.from_date[1]), date(this.object.to_date[1]) ) < 0  then
	this.of_messagebox( '', 'Validation Error', 'The to date cannot be less then the From Date', Information! , ok!, 1)
	this.setfocus( )
   //setcolumn('active_status')
	RETURN FAILURE
end if 






return 1
end event

event pfc_update;
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.21.2006 By: Liang QingShi
//$<reason>  Fix a defect.
/*
RETURN PARENT.DW_measuremt_detail.UPDATE( )
*/
if ib_delete then
	delete from PD_QA_MEASUREMENTS where PD_QA_HDR_ID = :il_pd_qa_hdr_id;
	delete from PD_QA_HDR where PD_QA_HDR_ID = :il_pd_qa_hdr_id;
	ib_delete = false
	return 1
else
	if this.Event pfc_PreUpdate() < 0 then return -1
	this.update()
	RETURN PARENT.DW_measuremt_detail.UPDATE( )
end if

//---------------------------- APPEON END ----------------------------

end event

event retrieveend;call super::retrieveend;

n_cst_color lnv_color
Integer li_columns, li_index
String ls_colName

if rowcount < 1 then RETURN 

// do no let the user make changes to historical records
if this.object.active_status[1] <> 1 then
	
	//////////////////////////////////////////////////////////////
	this.Object.DataWindow.ReadOnly = 'YES'
	li_columns = Integer(this.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  this.Modify(ls_colName+".Background.Color=" + + string(lnv_color.buttonface ) )
	next
	
	//////////////////////////////////////////////////////////////
	parent.dw_measuremt_detail.object.DataWindow.readonly = "Yes"
		
	li_columns = Integer(parent.dw_measuremt_detail.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  parent.dw_measuremt_detail.Modify(ls_colName+".Background.Color=" + + string(lnv_color.buttonface ) )
	next
	
	
	
else 
	//////////////////////////////////////////////////////////////
	this.Object.DataWindow.ReadOnly = 'no'
	
	li_columns = Integer(this.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  this.Modify(ls_colName+".Background.Color=" + + string(lnv_color.white ) )
	next

	/////////////////////////////////////////////////////////////
	
	parent.dw_measuremt_detail.object.DataWindow.readonly = "no"
	
	li_columns = Integer(parent.dw_measuremt_detail.Describe("DataWindow.column.count"))
	
	for li_index = 1 to li_columns
		  ls_colName = "#" + Trim(String(li_index))
		  parent.dw_measuremt_detail.Modify(ls_colName+".Background.Color=" + + string(lnv_color.white) )
	next
	
end if




		
 





of_get_appointment_dates( 'insert')





end event

event pfc_retrieve;call super::pfc_retrieve;

	

long ll_count

this.retrieve(il_prac_id )



return success
end event

event updateend;call super::updateend;

this.ib_rmbmenu = true
end event

event pfc_insertrow;call super::pfc_insertrow;

// override

return this.event pfc_addrow( )
end event

event buttonclicked;call super::buttonclicked;
/****************************************************************************************************************
** [PUBLIC] EVENT   buttonclicked   
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long]     row
**				   [long]     actionreturncode
**					[dwobject] dwo
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

IF rowcount( ) < 1 THEN RETURN  failure

// NEED THE CONVERSION SERVICE TO CONVERT STRING TO
n_cst_conversion   lnv_conversion

CHOOSE CASE dwo.name
	CASE 'b_appointment_date'
			IF NOT isnull(object.appointment_start_date[1]) THEN// so we do not set 1/1/1900 by accident
				object.from_date[1] =  datetime(lnv_conversion.of_date(object.appointment_start_date[1]), now())
				object.to_date[1]  =   datetime(lnv_conversion.of_date(object.appointment_end_date[1]),now())
		   END IF
	CASE 'b_provisional_dates'
			IF NOT Isnull(object.int_provision_date_start[1]) THEN // so we do not set 1/1/1900 by accident
				object.from_date[1] =  datetime(lnv_conversion.of_date(object.int_provision_date_start[1]), now())
				object.from_date[1]  = datetime(lnv_conversion.of_date(object.int_provision_date_end[1]),now())
			END IF
	CASE ELSE
	
END CHOOSE






end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.21.2006 By: Liang QingShi
//$<reason> Fix a defect.
long ll_row
ll_row = this.getrow()
if ll_row <= 0 then return -1
il_pd_qa_hdr_id = this.getitemnumber(ll_row,'pd_qa_hdr_id')
call super::pfc_deleterow
return 1
//---------------------------- APPEON END ----------------------------

end event

