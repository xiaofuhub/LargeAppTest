$PBExportHeader$u_tabpage_fee_schedule_main.sru
$PBExportComments$[intellicontract_tab]  Contract Contact Tab Page
forward
global type u_tabpage_fee_schedule_main from u_tabpg_contract_master
end type
type dw_main from u_dw_contract within u_tabpage_fee_schedule_main
end type
type dw_codes from u_dw_contract within u_tabpage_fee_schedule_main
end type
type dw_fee_schedule from u_dw_contract within u_tabpage_fee_schedule_main
end type
type dw_locations from u_dw_contract within u_tabpage_fee_schedule_main
end type
end forward

global type u_tabpage_fee_schedule_main from u_tabpg_contract_master
integer width = 3881
integer height = 1952
boolean ib_alwaysvalidate = false
event ue_preupdate ( )
event ue_set_screen_properties ( )
dw_main dw_main
dw_codes dw_codes
dw_fee_schedule dw_fee_schedule
dw_locations dw_locations
end type
global u_tabpage_fee_schedule_main u_tabpage_fee_schedule_main

type variables
long ll_location_id
LONG il_fee_sched_id
long il_cur_fee_rec_id /* the current record id for the fee */
string is_active_filer  /* filter clause for the fee schedule*/

N_DS Ids_cpt_for_template
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
decimal id_rate,id_rate_old
//---------------------------- APPEON END ----------------------------
Boolean ib_upd_fees = false  //(Appeon)Harry 06.16.2015 - Bug #4560
end variables

forward prototypes
public function integer of_retrieve ()
public function integer of_get_update_pendding ()
public function integer of_update ()
public function integer of_set_location ()
public function integer of_set_active_filter ()
public function integer of_open_cpt_codes (u_dw adw)
protected subroutine of_goto_add_code (string data)
end prototypes

event ue_preupdate();//////////////////////////////////////////////////////////////////////
// $<event>u_tabpg_contract_masterue_preupdate()
// $<arguments>
//		None		
// $<returns> (None)
// $<description> Performance tunging
// $<description> The following script moved from pfc_preupdate event in datawindow
//////////////////////////////////////////////////////////////////////
// $<add> 04.07.2006 by LeiWei
//////////////////////////////////////////////////////////////////////

long ll_i
long ll_max=0
Long LL_MAX_ROW = 0
Long ll_record_id
Long ll_orig
Long ll_max_location_id


for ll_i = 1 to dw_main.rowcount()
	 if not f_validstr(string(dw_main.getitemNumber(ll_i,'record_id'))) then
		LL_MAX_ROW ++
	 end if 
next
for ll_i = 1 to dw_locations.rowcount()
	 if not f_validstr(string(dw_locations.getitemNumber(ll_i,'record_id'))) then
		LL_MAX_ROW ++
	 end if 
next

//gnv_appeondb.of_startqueue( )

IF LL_MAX_ROW > 0 THEN
		SELECT ids.record_id  
		INTO :ll_record_id  
		FROM ids  ;

	   UPDATE ids  
      SET record_id = (record_id  + :LL_MAX_ROW);
END IF

FOR ll_i = 1 TO dw_main.rowcount()
  	IF NOT f_validstr(string(dw_main.object.fee_sched_id[ll_i]) ) THEN
		//Begin - Added By Mark Lee 10/22/12
//		select max(fee_sched_id) + 1
//		into :ll_max
//		from ctx_fee_sched_hdr;
//
//		if isnull(ll_max) then  ll_max = 1
		select max(fee_sched_id) 
		into :ll_max
		from ctx_fee_sched_hdr;

		if isnull(ll_max) then
			ll_max = 1
		Else
			ll_max ++
		End If
		//End - Added By Mark Lee 10/22/12		
		EXIT
	END IF
NEXT

FOR ll_i = 1 TO dw_locations.rowcount()
  	if not f_validstr(string(dw_locations.object.fee_sched_location_id[ll_i]) ) then
		select max(fee_sched_location_id)  + 1
		into :ll_max_location_id
		from CTX_FEE_SCHED_locations;

		if isnull(ll_max_location_id) then  ll_max_location_id = 1
		ll_orig = ll_max_location_id

		EXIT
	END IF
NEXT

//comment ,because it will cause ll_max to null
//gnv_appeondb.of_commitqueue( )


for ll_i = 1 to dw_main.rowcount()
	 if not f_validstr(string(dw_main.getitemNumber(ll_i,'record_id'))) then
			ll_record_id++
	      dw_main.setItem(ll_i,'record_id', ll_record_id)
	 end if 

  	if not f_validstr(string(dw_main.object.fee_sched_id[ll_i]) ) then
		dw_main.object.fee_sched_id[ll_i] = ll_max 
		inv_contract_details.of_set_fee_id(ll_max)
					
		dw_main.object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )

		//Modified By Mark Lee 10/12/12 cancel the comment
		ll_max ++	//add by apeon: the new update code comment this
	end if 

next

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.27.2006 By: Liang QingShi
//$<reason> Fix a defect.

Long ll_fee_sched_id
if dw_main.getrow() <= 0 then return
ll_fee_sched_id = dw_main.getitemnumber(dw_main.getrow(),'fee_sched_id')
//---------------------------- APPEON END ----------------------------

for ll_i = 1 to dw_locations.rowcount()
	 if not f_validstr(string(dw_locations.getitemNumber(ll_i,'record_id'))) then
			ll_record_id++
	      dw_locations.setItem(ll_i,'record_id', ll_record_id)
	 end if 

  	if not f_validstr(string(dw_locations.object.fee_sched_location_id[ll_i]) ) then
		if ll_orig = ll_max_location_id then
			dw_locations.object.fee_sched_location_id[ll_i] = ll_orig
		else
		   dw_locations.object.fee_sched_location_id[ll_i] = ll_max_location_id
	   end if
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 09.27.2006 By: Liang QingShi
		//$<reason> Fix a defect.
		/*
		dw_locations.object.fee_sched_id[ll_i] = inv_contract_details.of_get_fee_id( )
		*/
		dw_locations.object.fee_sched_id[ll_i] = ll_fee_sched_id
		//---------------------------- APPEON END ----------------------------
		
		ll_max_location_id = ll_max_location_id + 1
	end if 
	
next
end event

event ue_set_screen_properties();// Set screen properties
dw_main.of_set_properties(dw_main.il_ViewID, dw_main.il_ScreenID, "Y")
dw_locations.of_set_properties(dw_locations.il_ViewID, dw_locations.il_ScreenID, "Y")
dw_fee_schedule.of_set_properties(dw_fee_schedule.il_ViewID, dw_fee_schedule.il_ScreenID, "Y")
dw_codes.of_set_properties(dw_codes.il_ViewID, dw_codes.il_ScreenID, "Y")
end event

public function integer of_retrieve ();/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 16 March 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/








setredraw(false)

long ll_current 
long ll_current_FEE_row

//ll_current_FEE_row = 

ll_current =  dw_main.getrow()

if ib_retrieved = false then
	dw_main.event pfc_retrieve( )
end if

ib_retrieved = true

if ll_current > 0 then 
	dw_main.setrow(ll_current)
	dw_main.SelectRow(0, FALSE)
	dw_main.SelectRow(ll_current, TRUE)
end if

of_set_active_filter( )

setredraw(true)

return success
end function

public function integer of_get_update_pendding ();
parent.function dynamic of_accepttext( true)

return  parent.function dynamic of_updatespending( )
end function

public function integer of_update ();/******************************************************************************************************************
**  [PUBLIC]   : of_update
**==================================================================================================================
**  Purpose   	: function calls the of_update on the parent tab
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






//return parent.function dynamic of_update( true, true)

return success
end function

public function integer of_set_location ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_location( )
**==================================================================================================================
**  Purpose   	: Sets the Location to ALL by default
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 03 October 2005  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

long  ll_lookup_code

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 01.17.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Write script to retrieve data from a cache instead of from the database.

/*
SELECT code_lookup.lookup_code  
  INTO :ll_lookup_code
  FROM code_lookup  
 WHERE code_lookup.code = 'ALL' and 
	    code_lookup.lookup_name = 'Contract Local Code' ;
*/
ll_lookup_code = Long(gnv_data.of_getitem("code_lookup","lookup_code",&
"upper(code) = 'ALL' and upper(lookup_name) = upper('Contract Local Code')"))
//---------------------------- APPEON END ----------------------------
			 
			 
if not f_validstr(string(ll_lookup_code)) then 
	messagebox('Information', 'The ALL code has been removed from the Contract Local Code lookup.')
end if

if dw_locations.rowcount( ) > 0 then
	dw_locations.object.location[dw_locations.getrow()] = ll_lookup_code
end if 



return 0
end function

public function integer of_set_active_filter ();/******************************************************************************************************************
**  [PUBLIC]   : of_set_active_filter
**==================================================================================================================
**  Purpose   	: set the filter on the active items only
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 13 March 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_code
string ls_filter

ll_code = inv_contract_details.of_get_active_status_code( )

is_active_filer =  'Status = ' + string(ll_code)
dw_fee_schedule.setfilter(is_active_filer)
dw_fee_schedule.filter( )

return success



end function

public function integer of_open_cpt_codes (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : of_open_cpt_codes( )
**==================================================================================================================
**  Purpose   	: Open the code window
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner 08 March 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

STR_PASS LSTR_PASS 
LSTR_PASS.s_u_dw = adw
LSTR_PASS.s_po[1] = inv_contract_details
MESSage.STRINGparm = 'COMING_FROM_FEE_SCHED'
OPENWITHPARM(W_CPT_PAINTER,LSTR_PASS)


return 0
end function

protected subroutine of_goto_add_code (string data);//////////////////////////////////////////////////////////////////////
// $<function>u_tabpage_fee_schedule_mainof_goto_add_code()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description> The following scripts moved from itemchnaged event.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 06.19.2006 by LeiWei
// $<Modify> 03.18.2009 by Scofield: prettify the code 
//////////////////////////////////////////////////////////////////////

long 		ll_Cycle,ll_RowCnts,ll_Selected,ll_New_Row
String	ls_Code

if Not IsNull(data) then
	ll_RowCnts = ids_cpt_for_template.Retrieve(long(data))
	for ll_Cycle = 1 to ll_RowCnts
		ll_Selected = ids_cpt_for_template.GetItemNumber(ll_Cycle,"selected")	//Added by Scofield on 2009-03-18
		if ll_Selected = 0 then CONTINUE														//Added by Scofield on 2009-03-18
		
		ll_New_Row = dw_fee_schedule.InsertRow(0)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 06.28.2006 By: Liang QingShi
		//$<reason> The CPT_CODE column is not null.
		/*
		dw_fee_schedule.SetItem(ll_New_Row, 'CPT_CODE', ids_cpt_for_template.GetItemString(ll_New_Row,'CPT_CODE') ) 
		*/
		
		ls_Code = ids_cpt_for_template.GetItemString(ll_Cycle,'CPT_CODE')
		if IsNull(Trim(ls_Code)) or Trim(ls_Code) = '' then ls_Code = '111'
		dw_fee_schedule.SetItem(ll_New_Row, 'CPT_CODE', ls_Code) 
		
		//---------------------------- APPEON END ----------------------------

		dw_fee_schedule.SetItem(ll_New_Row, 'fee', ids_cpt_for_template.GetItemDecimal(ll_Cycle,'location_price') )
		// only set the status to active if there is NOT an existibg code
		if Not f_validstr(String(dw_fee_schedule.GetItemNumber(ll_New_Row,'status'))) then 
		  dw_fee_schedule.SetItem(ll_New_Row, 'status', inv_contract_details.of_get_active_status_code( ) ) 
		end if 
		// not sure if we need to store fee_basis or not 
		dw_fee_schedule.SetItem(ll_New_Row, 'fee_basis', ids_cpt_for_template.GetItemDecimal(ll_Cycle,'base_price') ) 
		//dw_fee_schedule.SetItem(ll_New_Row, 'effective_date', DATETIME(TODAY(),nOW())) 
		dw_fee_schedule.SetItem(ll_New_Row, 'effective_date', inv_contract_details.idt_contract_eff_date) //01.23.2008 By Jervis Default to effective date
		dw_fee_schedule.SetItem(ll_New_Row, 'expiration_date', inv_contract_details.idt_contract_exp_date  ) 
	next
end if

end subroutine

on u_tabpage_fee_schedule_main.create
int iCurrent
call super::create
this.dw_main=create dw_main
this.dw_codes=create dw_codes
this.dw_fee_schedule=create dw_fee_schedule
this.dw_locations=create dw_locations
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_main
this.Control[iCurrent+2]=this.dw_codes
this.Control[iCurrent+3]=this.dw_fee_schedule
this.Control[iCurrent+4]=this.dw_locations
end on

on u_tabpage_fee_schedule_main.destroy
call super::destroy
destroy(this.dw_main)
destroy(this.dw_codes)
destroy(this.dw_fee_schedule)
destroy(this.dw_locations)
end on

event constructor;call super::constructor;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
//  Created By	: Michael Skinner  Thursday  
//==================================================================================================================
//  Modification Log
//   Changed By             Change Date                                               Reason
// ------------------------------------------------------------------------------------------------------------------
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


dragobject temp
powerobject lpo[]
lpo[upperbound(lpo) + 1]  = dw_main
lpo[upperbound(lpo) + 1]  = dw_locations
lpo[upperbound(lpo) + 1]  = dw_fee_schedule
lpo[upperbound(lpo) + 1]  = dw_codes

this.of_setupdateobjects( lpo)
long ll_i

for ll_i = 1 to upperbound(lpo)
	u_dw dw
	dw = temp
	dw = lpo[ll_i]
	dw.of_SetRowManager(TRUE)
	dw.of_setrowselect( true)
	dw.inv_rowselect.of_SetStyle(dw.inv_rowselect.single )
next


end event

event ue_new;/******************************************************************************************************************
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

dragobject temp
powerobject apo_objects[]
int ll_i,i
this.of_getupdateobjects(apo_objects)

ll_i = upperbound(apo_objects)

for i = 1 to 3
	temp = apo_objects[i]
	u_dw dw
	dw = temp
	 	if dw.getItemstatus( 1, 0, primary!) <> NEW! or dw.getItemstatus( 1, 0, primary!) <> NEWmodified! then
					if iw_parent.event dynamic ue_save() = failure then return
					dw.reset()
					dw.event pfc_insertrow()
		end if
      
	  
	  if dw.rowcount() < 1 then 
			dw.event pfc_insertrow( )
     end if
	
next




//for i = ll_i to 1 step -1
////for i = 1 to ll_i
//	temp = this.control[i]
//	
//	choose case typeof(temp)
//		case datawindow! 
//			u_dw dw
//			dw = temp
//			
////			if dw.getItemstatus( 1, 0, primary!) <> NEW! or dw.getItemstatus( 1, 0, primary!) <> NEWmodified!then
////				if inv_contract_details.is_mode = inv_contract_details.new then
////					dw.reset()
////					dw.insertrow( 0)
////				end if
////		   end if
//			
//			if dw.rowcount() < 1 then 
//				messagebox('','')
//				dw.insertrow( 0)
//			end if
//	
//
//	end choose
//next

	

end event

event ue_selectionchanging;// overridee

return 0


end event

event ue_selectionchanged;call super::ue_selectionchanged;// override


// mbs 1 sept do not override
dw_main.setfocus()



return
end event

type st_1 from u_tabpg_contract_master`st_1 within u_tabpage_fee_schedule_main
integer x = 14
integer y = 1872
integer width = 3835
integer height = 68
integer textsize = 0
integer weight = 0
alignment alignment = left!
end type

type dw_main from u_dw_contract within u_tabpage_fee_schedule_main
string tag = "Fee Schedules"
integer y = 4
integer width = 1911
integer height = 616
integer taborder = 10
boolean bringtotop = true
boolean titlebar = true
string title = "Fee Schedules"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = styleraised!
string dataobject_original = "d_ctx_free_sched_hdr"
boolean ib_allow_sort = true
end type

event pfc_retrieve;call super::pfc_retrieve;/******************************************************************************************************************
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

// mskinner 28 march 2006 -- begin
dw_locations.reset()
dw_codes.reset( )
dw_fee_schedule.reset( )
this.reset( )

// mskinner 28 march 2006 -- end
this.retrieve(inv_contract_details.of_get_ctx_id( ))
return success

end event

event constructor;/******************************************************************************************************************
**  [PUBLIC]   : constructor dw_main
**==================================================================================================================
**  Purpose   	: 
**==================================================================================================================
**  Arguments 	: [none] 
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: override accestor script, using linkage service
**==================================================================================================================
**  Created By	: Michael B. Skinner  
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

//dw_main.inv_linkage.of_SetTransObject(SQLCA)
end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script is moved to the ue_preupdate event to
//$<modification> reduce client-server interactions. 
/*
long ll_i
long ll_max

for ll_i = 1 to this.rowcount()
	
	if not f_validstr(string(object.fee_sched_id[ll_i]) ) then
		select max(fee_sched_id) + 1
		into :ll_max
		from ctx_fee_sched_hdr;

		if isnull(ll_max) then  ll_max = 1
		object.fee_sched_id[ll_i] = ll_max 
		inv_contract_details.of_set_fee_id(ll_max)
					
		object.ctx_id[ll_i] = inv_contract_details.of_get_ctx_id( )
		
	end if 
next
*/

Parent.Trigger Event ue_preupdate()

//---------------------------- APPEON END ----------------------------

return success
end event

event rowfocuschanged;call super::rowfocuschanged;/******************************************************************************************************************
**  [PUBLIC]   : 
**==================================================================================================================
**  Purpose   	: set the current fee_sched_id 
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


if currentrow < 1 then return success

//inv_contract_details.of_set_fee_id( long(object.fee_sched_id[currentrow]) )




end event

event pfc_addrow;/******************************************************************************************************************
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
// override
long ll_save_result
long ll_ret
ll_save_result =  success
///////////////////////////////////////////////////////////////////////////
// make sure to up if there are some pending
///////////////////////////////////////////////////////////////////////////

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

u_tab_fee_schedule l_parent_tab

//Begin - Added By Mark Lee 04/24/12 fixed bug
dwItemStatus ldws_status
ldws_status = this.GetItemStatus( this.Rowcount(), 0, Primary!)
if of_get_update_pendding() > 0 Or (ldws_status = New! And Not isnull(ldws_status)) then 
//if of_get_update_pendding() > 0 then 	
//	ll_ret = messagebox(iw_parent.title,'Do you want to save changes made to the fee schedule?',question!,yesno!,1) 
//End - Added By Mark Lee 04/24/12
	ll_ret = messagebox(iw_parent.title,'Changes need to be saved before adding a new schedule.~n~rDo you want to save the changes now?',question!,yesno!,1) 
	if ll_ret = 1 then 
	  	ll_save_result =  of_update()
	else	
		//Added By Mark Lee 04/24/12
		Return NO_ACTION
	end if
end if

if ll_save_result = success then 
//		dw_main.reset( )
//		dw_codes.reset( )
//		dw_fee_schedule.reset( )
//		dw_locations.reset()
//		dw_main.event pfc_insertrow( )
		Super::event pfc_addrow( )			//Modified by Scofield on 2008-12-31
end if 
ib_retrieved = false

//dw_locations.event pfc_addrow( )

/////////////////////////////////////////////////////////////
// set the loaction to all by default
//////////////////////////////////////////////////////////////

of_set_location()

return success

end event

event pfc_validation;call super::pfc_validation;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner  22 July 2005 
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/

if this.rowcount( ) < 1 then retURN success

if  not f_validstr(string(this.object.sched_type[getrow()]))  then 
	messagebox(iw_parent.title,'Schedule Type must be added before continuing.' )
	SetColumn('sched_type')
	return failure

end if


return success
end event

event retrieveend;call super::retrieveend;

if rowcount> 0 then 
	setrow( 1)
	inv_contract_details.of_set_fee_id(this.object.fee_sched_id[getrow()])
	
end if 
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.13.2006 By: Liang QingShi
//$<reason> Fix a defect.
If of_check_read_only( ) Then Return failure  	//Add by Jack 07.13.2007

if This.RowCount() <= 0 then Return Success		//Added by Scofield on 2008-09-17

if MessageBox('Delete Fee Schedules', 'Are you sure you want to delete this Fee Schedulest?',question!,Yesno!,2) = 1 then
	long ll_fee_sched_id
	dw_main.accepttext()
	ll_fee_sched_id = dw_main.getitemnumber(dw_main.getrow(),'fee_sched_id')
	gnv_appeondb.of_startqueue( )

	delete from CTX_FEE_SCHED_DATA where CTX_FEE_SCHED_DATA.fee_sched_location_id in (select CTX_FEE_SCHED_LOCATIONS.fee_sched_location_id from CTX_FEE_SCHED_LOCATIONS where CTX_FEE_SCHED_LOCATIONS.fee_sched_id  = :ll_fee_sched_id);
	delete from CTX_FEE_SCHED_LOCATIONS where fee_sched_id = :ll_fee_sched_id;
	delete from CTX_FEE_SCHED_PRACS where fee_sched_id = :ll_fee_sched_id;
	delete from CTX_FEE_SCHED_HDR where fee_sched_id = :ll_fee_sched_id;
	commit;
	dw_fee_schedule.reset()
	dw_locations.reset()
	dw_codes.reset()
	dw_main.reset()
	this.retrieve(inv_contract_details.of_get_ctx_id( ))
	gnv_appeondb.of_commitqueue( )		
end if
return success
//---------------------------- APPEON END ----------------------------


end event

type dw_codes from u_dw_contract within u_tabpage_fee_schedule_main
string tag = "Providers"
integer x = 2693
integer y = 640
integer width = 1147
integer height = 1216
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Providers"
boolean hscrollbar = true
string dataobject_original = "d_ctx_schedule_fee_pracs"
boolean ib_allow_sort = true
end type

event itemchanged;call super::itemchanged;
return success
end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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

long ll_i

////////////////////////////////////////////////////////////////////////////
// set the value for fee_sched_id
////////////////////////////////////////////////////////////////////////////

for ll_i =1 to this.rowcount()
	if not f_validstr(string(object.fee_sched_id[ll_i])) then
	  object.fee_sched_id[ll_i] = inv_contract_details.of_get_fee_id()
   end if
next

return SUCcess
end event

event losefocus;call super::losefocus;this.borderstyle = StyleLowered!	
end event

event getfocus;call super::getfocus;//this.borderstyle = StyleRaised!		//Commented by Scofield on 2008-09-18
end event

event pfc_addrow;/******************************************************************************************************************
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

//---------Begin Commented by (Appeon)Harry  09.02.2014 for BugH062001 in V14.2 Issues of Integration.doc--------
/*
STR_PASS LSTR_PASS 

LSTR_PASS.s_u_dw = this
*/
//---------End Commented ------------------------------------------------------
Boolean lb_need_save = false
// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

if dw_main.rowcount() < 1 then 
	messagebox(iw_parent.title,'Fee schedule must be added before continuing.' )
	dw_main.event pfc_addrow( )
	return failure
 else 
	//openwithparm(w_extended_search_new,LSTR_PASS) //Commented by (Appeon)Harry 09.02.2014 - for BugH062001 in V14.2 Issues of Integration.doc
end if

//---------Begin Added by (Appeon)Harry 09.02.2014 for BugH062001 in V14.2 Issues of Integration.doc--------
long ll_row
long lc
long i
long li_prac_id
long li_find,li_nr
string ls_first_name
string ls_last_name
string ls_full_name

gs_search lstr_search
gs_batch_search lst_search_ret

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" 
OpenWithParm( w_extended_search_new , lstr_search )

if Message.DoubleParm = -1 then
	return -1
end if

if not isvalid(message.powerobjectparm) then return 0
lst_search_ret = message.powerobjectparm

lc = upperbound(lst_search_ret.li_prac_id[])

for i = 1 to lc
	
	li_prac_id = lst_search_ret.li_prac_id[i] //maha 091605

	li_find = this.Find( "practitioner_id = " + String( li_prac_id ), 1, this.rowcount( ) )
	
	IF li_find > 0 THEN
		continue
	END IF
	
	SELECT v_full_name.full_name, v_full_name.first_name, v_full_name.last_name 
	INTO :ls_full_name, :ls_first_name, :ls_last_name
	FROM v_full_name 
	WHERE v_full_name.prac_id =  :li_prac_id ;
	
	li_nr = this.InsertRow( 0 )
	
	this.SetItem( li_nr, "practitioner_id", li_prac_id )
	this.SetItem( li_nr, "first_name", ls_first_name )
	this.SetItem( li_nr, "last_name", ls_last_name )
	this.setitem( li_nr,'full_name',ls_full_name)
	if not lb_need_save then lb_need_save = true //Added by (Appeon)Harry 03.22.2016
next

//---------End Added ------------------------------------------------------
if lb_need_save then OF_ENABLE_SAVE( ) //Added by (Appeon)Harry 03.22.2016 for BugH032103
return success
end event

event pfc_prermbmenuproperty;call super::pfc_prermbmenuproperty;am_dw.m_table.M_insert.Visible  = false
end event

type dw_fee_schedule from u_dw_contract within u_tabpage_fee_schedule_main
string tag = "Fees"
integer y = 640
integer width = 2670
integer height = 1216
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Fees"
boolean hscrollbar = true
string dataobject_original = "d_ctx_schedule_fee_detail"
boolean ib_allow_filter = true
boolean ib_allow_sort = true
end type

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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

long ll_i
long ll_max
long ll_orig
LONG LL_STATUS
LONG LL_NULL


IF THIS.ROWCOUNT( ) < 1 THEN RETURN SUCcess

SETNULL(LL_NULL)
dwItemStatus l_status
SETPOINTER(HOURGLASS!)
setredraw(false)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.03.2006 By: Liang QingShi
//$<reason> Fix a defect.
if dw_locations.rowcount() <= 0 then return 0
//---------------------------- APPEON END ----------------------------

select max(fee_sched_data_id) + 1 
into :ll_max
from CTX_FEE_SCHED_DATA;

if isnull(ll_max) then ll_max = 1 

ll_orig = ll_max

////////////////////////////////////////////////////////////////////////////
// set the value for fee_sched_id
////////////////////////////////////////////////////////////////////////////


FOR ll_i =1 to this.rowcount()
	if NOT f_validstr(string(object.fee_sched_location_id[ll_i])) then
	  this.object.fee_sched_location_id[ll_i] = dw_locations.object.fee_sched_location_id[dw_locations.getrow()]
   END IF
NEXT

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
// IF A CHANGE IS MADE TO THE CPT CODE DO NOT MODIFY IT CREATE A NEW RECORD, SET THE ORIGINAL TO NOT ACTIVE
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

choose case inv_contract_details.is_contract_status
	case inv_contract_details.contract_active // active logic
		
		//FOR ll_i =1 to this.rowcount()
		  // IF THIS ROW HAS BEEN PREVISOULY SAVED
		  IF getitemnumber(getrow(),'fee_sched_data_id',primary!,true) <> 0 THEN
				IF GETITEmstatus( getrow(),0, PRIMARY!) = DATAMODIFIED! THEN 
					ib_upd_fees = true  //(Appeon)Harry 06.16.2015 - Bug #4560
					SETITEMSTATUS(getrow(),0,PRIMARY!,NEWMODIFIED!)
					THIS.SETiTEM(getrow(),'fee_sched_data_id',LL_NULL)
					// set to history in updateend
					il_cur_fee_rec_id =getItemNumber(getrow(),'record_id')
					setitem(getrow(),'inserted_by_user', gs_user_id)
					setitem(getrow(),'inserted_at_date_time',f_get_server_dtm() )
					THIS.setItem(getrow(),'record_id',of_get_next_record_id())
				//	of_get_history_status_code()
				END IF
		  END IF
     // NEXT
		
		/////////////////////////////////////////////////////////////////
		// do not delete the deleted codes - call them cancelled
		// move then back into the primay buffer
		/////////////////////////////////////////////////////////////////
		
		IF DeletedCount ( ) > 0 THEN 
		
		long ll_before_move /* the rowcount before the rows move*/
		ll_before_move = rowcount()
		
		if RowsMove (1,DeletedCount ( ) , delete!, this, ll_before_move + 1, primary!) <> 1 then messagebox('','rowsmove failed')
				
		FOR ll_i = ll_before_move + 1 to rowcount()
			setitem(ll_i,'status', inv_contract_details.of_get_canceled_status_code()) 
		NEXT
		of_set_active_filter( )
	END IF	


		
	case inv_contract_details.contract_canceled	
	case inv_contract_details.contract_expired
	case inv_contract_details.contract_pending


end choose 

////////////////////////////////////////////////////////////////////////////
// set the value for fee_sched_data_id
////////////////////////////////////////////////////////////////////////////

for ll_i = 1 to this.rowcount()
	
	if not f_validstr(string(object.fee_sched_data_id[ll_i]) ) then
		
		if ll_orig = ll_max then 
			object.fee_sched_data_id[ll_i] = ll_orig
		else 
			object.fee_sched_data_id[ll_i] = ll_max 
		end if 
		
		ll_max = ll_max + 1
	end if
next

SETPOINTER(ARROW!)
return success
end event

event constructor;call super::constructor;
//string s_colx
//HSplitScroll = True
//// Get the WINS columns X position 
//s_colx = Describe("office_fee.x" ) 
//// Set the horizontal scroll bar position 
//Modify ("datawindow.horizontalscrollsplit=" + s_colx)


this.of_SetDropDownCalendar(TRUE)


//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.06.2006 By: LeiWei
//$<reason> Performance tuning.
/*
this.iuo_calendar.of_Register("effective_date", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("expiration_date", this.iuo_calendar.DDLB_WITHARROW	)
*/
ib_retrieve_drop_downs = false
event ue_populatedddws( )
//---------------------------- APPEON END ----------------------------

ids_cpt_for_template = CREATE N_DS 
ids_cpt_for_template.DATAOBJECT = 'd_cpt_for_template'
ids_cpt_for_template.SETTRANSOBJECT(SQLCA)

end event

event getfocus;call super::getfocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason>: New Requirement.
If IsValid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_find,'toolbaritemvisible', True)
End If
//---------------------------- APPEON END ----------------------------


//this.borderstyle = StyleRaised!
end event

event losefocus;call super::losefocus;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason>: New Requirement.
If IsValid(m_pfe_cst_mdi_menu_contract) Then
	gnv_app.of_modify_menu_attr( m_pfe_cst_mdi_menu_contract.m_edit.m_find,'toolbaritemvisible', False)
End If
//---------------------------- APPEON END ----------------------------

//this.borderstyle = StyleLowered!	
end event

event pfc_validation;call super::pfc_validation;/******************************************************************************************************************
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

long ll_i

//
////for ll_i = 1 to rowcount( )
//
//IF GETROW() > 0 THEN
//   if not f_validstr(string(object.CPT_CODE[GETROW()])) then
//		messagebox(iw_parent.title,'Code is a required column')
//		setfocus( )
//		setcolumn( 'CPT_CODE')
//		return failure
//	end if 
////next
//END IF 
//
return success
end event

event pfc_addrow;/******************************************************************************************************************
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
** MSKINNER 					08 March 2006 							                         added call to of_open_cpt_codes()  
********************************************************************************************************************/

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//// 
///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//if dw_locations.rowcount() < 1 then 
//	messagebox('Fees','A location must be added before continuing.' )
//	dw_locations.event pfc_addrow( )
//	return failure
//end if
//
//
//of_open_cpt_codes(this)



return success
end event

event buttonclicked;call super::buttonclicked;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 27 Febuary 2006 ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
**    mskinner              08 March 2006                                      addes call to of_open_cpt_codes()
********************************************************************************************************************/

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 

CHOOSE CASE DWO.NAME 
    CASE 'b_add_codes'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 09.08.2006 By: Liang QingShi
		//$<reason> Fix a defect.
		if dw_locations.rowcount() <= 0 then return success		
		//---------------------------- APPEON END ----------------------------
		of_open_cpt_codes(this)
END CHOOSE 
	
	
	
	
	
	
	
	
	
	
end event

event pfc_prermbmenuproperty;call super::pfc_prermbmenuproperty;am_dw.m_table.M_addrow.Visible  = false
am_dw.m_table.M_insert.Visible  = false

end event

event resize;
//

end event

event retrieveend;call super::retrieveend;if this.rowcount( ) < 1 then return success

il_fee_sched_id =  this.object.fee_sched_location_id[1]




	

end event

event updateend;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 17 March 2006  ? Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
long ll_history
long ll_status_code
//---------Begin Added by (Appeon)Harry 06.16.2015 for Bug #4560--------
long i
if ib_upd_fees then
	for i = 1 to this.rowcount( )
		If This.GetItemNumber(i,'fee_sched_data_id',primary!,true) <> 0 Then
			If This.GetItemStatus( i, 0, PRIMARY!) = NEWMODIFIED! Then 
				This.SETITEMSTATUS(i,0,PRIMARY!,DATAMODIFIED! )
			End If
		End If
	next
end if
Call Super::updateend
ib_upd_fees = false
//---------End Added ------------------------------------------------------

choose case inv_contract_details.is_contract_status
	case inv_contract_details.contract_active 
		// any changes made are sent to history!!
		ll_history = inv_contract_details.of_get_history_status_code( )  
		UPDATE ctx_fee_sched_data
		SET status = :ll_history
		WHERE ctx_fee_sched_data.record_id = :il_cur_fee_rec_id;

//		choose case ll_status_code
//			case inv_contract_details.of_get_canceled_status_code( )
//				 // do nothing
//			case inv_contract_details.of_get_active_status_code( )
//				//upate the current record id - sent it to be history
//					ll_history = inv_contract_details.of_get_history_status_code( )  
//					UPDATE ctx_fee_sched_data
//					SET status = :ll_history
//					WHERE ctx_fee_sched_data.record_id = :il_cur_fee_rec_id;
//					// update the 
//					THIS.RETRIEVE(il_fee_sched_id)
//			end choose 
		
end  choose



setredraw(true)



end event

event pfc_filterdlg;call super::pfc_filterdlg;string ls_current_filter
string ls_new_filter
// decsribe the filter


ls_current_filter =  Object.DataWindow.Table.Filter
IF F_VALIDSTR(ls_current_filter) and ls_current_filter <> '?' THEN 
  ls_new_filter =  ls_current_filter +  ' and '+ is_active_filer
  
  setfilter( ls_new_filter)
  FILTER()
ELSE
	OF_SET_active_filter( )
END IF



RETURN SUCcess


end event

event pfc_finddlg;call super::pfc_finddlg;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason>: New Requirement.
OpenWithParm(w_finddlg, this)
//---------------------------- APPEON END ----------------------------
end event

event rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason> Performance tuning: Override this script.
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-19 By: Liu HongXin
//$<reason> Performance tuning: Override this script.
//---------------------------- APPEON END ----------------------------
end event

event pfc_deleterow;call super::pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-01-08 By: Rodger Wu
//$<reason> Let one alert window pop up instead of two alert windows pop up.
If of_check_read_only( ) Then Return failure  //Add by Jack 07.13.2007

//--------------------------- APPEON BEGIN ---------------------------
//$<Comment> 2008-03-11 By: Scofield
//$< Reason> Let RowManager alert window pop up instead of link alert windows pop up.

//if IsValid (inv_RowManager) then inv_RowManager.of_setconfirmondelete( False )
//super :: event pfc_deleterow( )
//if IsValid (inv_RowManager) then inv_RowManager.of_setconfirmondelete( True )

//---------------------------- APPEON END ----------------------------
return success

//---------------------------- APPEON END ----------------------------

end event

type dw_locations from u_dw_contract within u_tabpage_fee_schedule_main
event ue_populatedddw_location ( datawindow adw_location )
string tag = "Fee Schedule Locations"
integer x = 1934
integer y = 4
integer width = 1906
integer height = 616
integer taborder = 11
boolean bringtotop = true
boolean titlebar = true
string title = "Fee Schedule Locations"
boolean hscrollbar = true
string dataobject_original = "d_ctx_schedule_fee_locations"
boolean ib_use_row_selection = true
boolean ib_allow_sort = true
end type

event ue_populatedddw_location(datawindow adw_location);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-27 By: Liu Hongxin
//$<reason> New Required.

Long		i
String	ls_Location

DatawindowChild ldw_child

If IsValid(adw_location) Then
	dw_locations.GetChild("location", ldw_child)
	ldw_child.Reset()
	//ldw_child.SetTransObject(SQLCA)
	//ldw_child.Retrieve()
	
	For i = 1 To adw_location.RowCount()
		ls_Location = adw_location.GetItemString(i, "Local")
		If Not IsNull(ls_Location) Then
			ldw_child.InsertRow(0)
			ldw_child.SetItem(i, "Local", ls_Location)
			ldw_child.SetItem(i, "Local1", ls_Location)
		End If
	Next
	ldw_child.InsertRow(1)
	ldw_child.SetItem(1, "Local", "-999")
	ldw_child.SetItem(1, "Local1", "All")
End If
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;/******************************************************************************************************************
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

long ll_max
long ll_orig /* Original value retrieve from database */
long ll_i    /* loop counter                          */
long ll_fee_id 

if this.rowcount() < 1 then return success

////////////////////////////////////////////////////////////////////////
// get the next counter
////////////////////////////////////////////////////////////////////////

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 04.07.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> The following script is moved to the ue_preupdate event to
//$<modification> reduce client-server interactions. Refer to PT-02 for more inoformation.
/*

select max(fee_sched_location_id)  + 1
into :ll_max
from CTX_FEE_SCHED_locations;




if isnull(ll_max) then  ll_max = 1
ll_orig = ll_max

for ll_i = 1 to this.rowcount()
	if isnull(this.object.fee_sched_location_id[ll_i]) then
		
		if ll_orig = ll_max then
			this.object.fee_sched_location_id[ll_i] = ll_orig
		else
		   this.object.fee_sched_location_id[ll_i] = ll_max
	   end if
		
		
		
		this.object.fee_sched_id[ll_i] = inv_contract_details.of_get_fee_id( )
		
		//ll_max = ll_max + 1
	end if 
	
next

*/

Parent.Trigger Event ue_preupdate()

//---------------------------- APPEON END ----------------------------

return success
end event

event losefocus;call super::losefocus;

this.borderstyle = StyleLowered!	
end event

event getfocus;call super::getfocus;//this.borderstyle = StyleRaised!		//Commented by Scofield on 2008-09-18
end event

event rowfocuschanged;call super::rowfocuschanged;
/******************************************************************************************************************
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




if currentrow = 0 then return success

ll_location_id = this.object.fee_sched_location_id[currentrow]

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
id_rate = this.object.rate[currentrow]
if isnull(id_rate) then 
	id_rate = 0
else
	id_rate = round(id_rate,2)
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_addrow;
/******************************************************************************************************************
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
// override
long ll_found
long ll_code
STRING LS_FIND_STR

// mskinner 05 april 2006 -- begin
if of_check_read_only( ) then return success
// mskinner 05 april 2006 -- end 


if dw_main.rowcount( )< 1 then
	messagebox(iw_parent.title,'A fee schedule record must be added before continuing.')
	dw_main.event pfc_addrow( )
	return failure
end if 


super::event pfc_addrow( )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.19.2006 By: Liang QingShi
//$<reason> Contract module modification
//$<reason> Fix a defect.
this.event ue_populatedddws( )

//---------------------------- APPEON END ----------------------------


///////////////////////////////////////////////////////////////////////////////
// default the first row to be 'ALL'
///////////////////////////////////////////////////////////////////////////////

datawindowchild dw_child

getchild('location', dw_child)


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.30.2007 By: Jack
//$<reason> Fix a defect.
/*
LS_FIND_STR = 'ALL'
ll_found = dw_child.Find("code ='" + LS_FIND_STR + "'", 1, dw_child.RowCount())

if ll_found > 0 then 
	ll_code = dw_child.GetitemNumber(ll_found,'lookup_code')
	this.object.location[getrow() ] = ll_code
else 
	//messagebox(this.title, 'ALL is missing from the lookup table' )
end if
*/
LS_FIND_STR = 'All'
ll_found = dw_child.Find("local1 ='" + LS_FIND_STR + "'", 1, dw_child.RowCount())

String	ls_Location

if ll_found > 0 then 
	ls_Location = dw_child.GetitemString(ll_found,"local")
	this.setitem(this.getrow(),'location',ls_Location)
end if

//---------------------------- APPEON END ----------------------------

return success

end event

event constructor;call super::constructor;

of_SetReqColumn(TRUE)
end event

event pfc_validation;call super::pfc_validation;

long ll_i


//for ll_i = 1 to rowcount( )

IF GETROW() > 0 THEN
   if not f_validstr(string(object.LOCATION[GETROW()])) then
		messagebox(iw_parent.title,'Location is a required column')
		setfocus( )
		setcolumn( 'LOCATION')
		return failure
	end if 
//next
END IF 

return success
end event

event pfc_deleterow;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.13.2006 By: Liang QingShi
//$<reason> Fix a defect.
If of_check_read_only( ) Then Return failure  	//Add by Jack 07.13.2007

if This.RowCount() <= 0 then Return Success		//Added by Scofield on 2008-09-17

if MessageBox('Delete Fee Schedule Locations', 'Are you sure you want to delete this Fee Schedule Locations?',Question!,Yesno!,2) = 1 then
	long ll_fee_sched_location_id,ll_fee_sched_id
	ll_fee_sched_location_id = dw_locations.getitemnumber(dw_locations.getrow(),'fee_sched_location_id')
	ll_fee_sched_id = dw_main.getitemnumber(dw_main.getrow(),'fee_sched_id')
	
	gnv_appeondb.of_startqueue( )
	
	delete from CTX_FEE_SCHED_DATA where fee_sched_location_id = :ll_fee_sched_location_id;
	delete from CTX_FEE_SCHED_LOCATIONS where fee_sched_location_id = :ll_fee_sched_location_id;
	commit;
	dw_fee_schedule.reset()
	dw_locations.reset()
	this.retrieve(ll_fee_sched_id)
	gnv_appeondb.of_commitqueue( )		
end if
return success
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;/******************************************************************************************************************
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
**  Created By	: Michael B. Skinner 24 March 2006 ?Intellisoftgroup, Inc
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
string 	ls_message[]
long 		ll_i
dec {4} 	ld_multiplier
dec {4} 	ld_mult_factor

ls_message[1] = 'Selecting a new template will clear out all existing data and replace it with the new template. Do you want to continue?'
ls_message[2] = 'This action will clear out all of the existing data with no repplacements. Do you want to continue?' 

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// if the contract is active then do not allow the change, else delete all of the fee codes and add the new
// ones - i think
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

CHOOSE CASE DWO.NAME 
	CASE 'fee_bonus'
		if inv_contract_details.is_contract_status <> inv_contract_details.contract_pending and dw_fee_schedule.rowcount() > 0 then 
			 messagebox('Fee Schedule Change', 'Fee Schedule Template can~'t be changed when the contract status is other then PENDING. However, CPT codes can be added using add codes button.')
			 this.setfocus( )
			 return 2
		else
			if dw_fee_schedule.rowcount() > 0  and (this.object.fee_bonus[1] <> -777)  then
				// determine the proper message
				if isnull(data) then
					ls_message[3] = ls_message[2]
				else
					ls_message[3] = ls_message[1]
				end if
			 
				// do it if yes
				if messagebox('Fee Schedule Change', ls_message[3] ,question!,yesno!,2) = 1 then 
				// move all of then records to the delete buffer
					dw_fee_schedule.RowsMove(1, dw_fee_schedule.rowcount(), Primary!, dw_fee_schedule, 1, Delete!)
					//--------------------------- APPEON BEGIN ---------------------------
					//$<ID> UM-01
					//$<modify> 06.19.2006 By: LeiWei
					//$<reason> The GOTo statement is currently unsupported.
					//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
					//$<modification> new function instead of using GOTO label.
					//goto add_codes
					of_goto_add_code(data)
					//---------------------------- APPEON END ----------------------------
				else
					return 2 // reject the change
				end if 
			end if
		end if
		// add then  code if there are none
		
		if dw_fee_schedule.rowcount() < 1 then
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-02
			//$<modify> 06.19.2006 By: LeiWei
			//$<reason> The GOTo statement is currently unsupported.
			//$<modification> Define a new function to encapsulates the scripts associated with the label. Call the
			//$<modification> new function instead of using GOTO label.
			//goto add_codes
			of_goto_add_code(data)
			//---------------------------- APPEON END ----------------------------
		end if 
	case 'rate'
		//--------------------------- APPEON BEGIN ---------------------------
		//$<comment> 09.18.2006 By: Liang QingShi
		//$<reason> Fix a defect.
		/*
		if messagebox('Fee Rate Change', 'You are now changing all of the fee rates to ' + data + '% of the CURRENT fee. Do you want to contiue?'   ,question!,yesno!,2) = 1 then 
			dec {4} ld_multiplier
         dec {4} ld_mult_factor
			
			ld_multiplier = dec(data)
			
			//ld_mult_factor = ld_multiplier
			ld_mult_factor = ld_multiplier/100
				
			IF ld_mult_factor> 0 THEN
			  for ll_i = 1 to dw_fee_schedule.rowcount()
				 dw_fee_schedule.setrow(ll_i)
             dw_fee_schedule.setItem(ll_i,'fee', (ld_mult_factor * dw_fee_schedule.getItemDecimal(ll_i,'fee'))  )
             //messagebox('',string((ld_mult_factor * dw_fee_schedule.getItemNumber(ll_i,'fee')) ))
			  next
			eND IF 
				
			IF ld_mult_factor <  0 THEN
					for ll_i = 1 to dw_fee_schedule.rowcount()
						dw_fee_schedule.setrow(ll_i)
                  dw_fee_schedule.setItem(ll_i,'fee',(dw_fee_schedule.getItemDecimal(ll_i,'fee')   + (ld_mult_factor *  dw_fee_schedule.getItemDecimal(ll_i,'fee'))))
				
					next
		   END IF 
		
   	END IF 
		*/
		//---------------------------- APPEON END ----------------------------
END CHOOSE

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
long 		ll_fee_bonus
decimal 	ld_rate

this.AcceptText()
ld_rate = this.GetItemNumber(this.GetRow(),'rate')
IF isnull(ld_rate) THEN
	ld_rate = 0
ELSE
	ld_rate = round(ld_rate,2)
END IF
ll_fee_bonus = this.getitemnumber(this.getrow(),'fee_bonus')
IF isnull(ll_fee_bonus) THEN ll_fee_bonus = 0
IF ll_fee_bonus = 0 AND ld_rate <> id_rate THEN
	id_rate_old = id_rate
END IF
IF id_rate_old > 0 THEN 
	id_rate = id_rate_old
end IF

IF ll_fee_bonus <> 0 AND ld_rate <> id_rate THEN
	if MessageBox("Fee Rate Change", "Do you want to multiply the Fee in the Fees screen by the new Rate " + string(ld_rate) + "%?",Question!,YesNo!,2) = 1 then		//Modified By Scofield on 2008-03-13
		id_rate_old = 0
		ld_multiplier = ld_rate		
		//ld_mult_factor = ld_multiplier
		ld_mult_factor = ld_multiplier/100
			
		IF ld_mult_factor> 0 THEN
			for ll_i = 1 to dw_fee_schedule.rowcount()
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 2006-09-19 By: Liu HongXin
				//$<modify> performance tuning.
				/*
				dw_fee_schedule.setrow(ll_i)
				*/
				dw_fee_schedule.SelectRow(0, FALSE)
				dw_fee_schedule.SelectRow(ll_i, TRUE)
				//---------------------------- APPEON END ----------------------------
				dw_fee_schedule.setItem(ll_i,'fee', (ld_mult_factor * dw_fee_schedule.getItemDecimal(ll_i,'fee'))  )
				//messagebox('',string((ld_mult_factor * dw_fee_schedule.getItemNumber(ll_i,'fee')) ))
			next
		END IF

		IF ld_mult_factor <  0 THEN
			for ll_i = 1 to dw_fee_schedule.rowcount()
				//--------------------------- APPEON BEGIN ---------------------------
				//$<add> 2006-09-19 By: Liu HongXin
				//$<modify> performance tuning.
				/*
				 dw_fee_schedule.setrow(ll_i)
				 */
				dw_fee_schedule.SelectRow(0, FALSE)
				dw_fee_schedule.SelectRow(ll_i, TRUE)
				//---------------------------- APPEON END ----------------------------
				dw_fee_schedule.setItem(ll_i,'fee',(dw_fee_schedule.getItemDecimal(ll_i,'fee') + (ld_mult_factor *  dw_fee_schedule.getItemDecimal(ll_i,'fee'))))
			next
		END IF 
		dw_fee_schedule.setrow(ll_i)
	END IF 
END IF
//---------------------------- APPEON END ----------------------------




//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-03
//$<comment> 01.13.2006 By: Lei Wei
//$<reason> The label add_codes is replaced by the function of_goto_add_code
//$<modification> Comment out the following script and have them encapsulated 
//$<modification> into of_goto_add_code.
/*
add_codes:
//setredraw(false)	
long LL_NEW_ROW
if not isnull(data) then
ids_cpt_for_template.RETRIEVE(long(data))
for LL_NEW_ROW = 1 to ids_cpt_for_template.rowcount()
	   dw_fee_schedule.insertrow(LL_NEW_ROW)
	   dw_fee_schedule.SETITEM(LL_NEW_ROW, 'CPT_CODE', ids_cpt_for_template.GETiTEMSTRING(LL_NEW_ROW,'CPT_CODE') ) 
		dw_fee_schedule.SETITEM(LL_NEW_ROW, 'fee', ids_cpt_for_template.getitemdecimal(LL_NEW_ROW,'location_price') )
		// only set the status to active if there is NOT an existibg code
		if not f_validstr(string(dw_fee_schedule.getitemNumber(LL_NEW_ROW,'status'))) then 
	     dw_fee_schedule.SETITEM(LL_NEW_ROW, 'status', inv_contract_details.of_get_active_status_code( ) ) 
	   end if 
		// not sure if we need to store fee_basis or not 
		dw_fee_schedule.SETITEM(LL_NEW_ROW, 'fee_basis', ids_cpt_for_template.getitemdecimal(LL_NEW_ROW,'base_price') ) 
	   dw_fee_schedule.SETITEM(LL_NEW_ROW, 'effective_date', DATETIME(TODAY(),nOW())) 
		dw_fee_schedule.SETITEM(LL_NEW_ROW, 'expiration_date', inv_contract_details.idt_contract_exp_date  ) 
next
end if


//event ue_post_itemchanged( data)
//event ue_populatedddws( )
//ACCepttext( )
//setredraw(true)
*/

//of_goto_add_code(data)

//---------------------------- APPEON END ----------------------------

end event

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.18.2006 By: Liang QingShi
//$<reason> Fix a defect.
if this.getrow() < 1 then return
id_rate = this.getitemnumber(this.getrow(),'rate')
if isnull(id_rate) then 
	id_rate = 0
else
	id_rate = round(id_rate,2)
end if
//---------------------------- APPEON END ----------------------------

of_clicklink( dwo, row )//added by gavins 20120612
end event

event pfc_insertrow;
//////////////////////////////////////////////////////////////////////
// $<event>pfc_insertrowdw_locations()
// $<arguments>(None)
// $<returns> long
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.30.2007 by Jack
//////////////////////////////////////////////////////////////////////
// override
long ll_found
long ll_code
STRING LS_FIND_STR

if of_check_read_only( ) then return success

if dw_main.rowcount( )< 1 then
	messagebox(iw_parent.title,'A fee schedule record must be added before continuing.')
	dw_main.event pfc_addrow( )
	return failure
end if 


super::event pfc_insertrow( )

this.event ue_populatedddws( )



///////////////////////////////////////////////////////////////////////////////
// default the first row to be 'ALL'
///////////////////////////////////////////////////////////////////////////////

datawindowchild dw_child
String	ls_Location

getchild('location', dw_child)

LS_FIND_STR = 'All'
ll_found = dw_child.Find("local1 ='" + LS_FIND_STR + "'", 1, dw_child.RowCount())

if ll_found > 0 then 
	ls_Location = dw_child.GetitemString(ll_found,"local")
	this.setitem(this.getrow(),'location',ls_Location)
end if


return success


end event

