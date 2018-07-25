$PBExportHeader$w_gp_prac_update.srw
forward
global type w_gp_prac_update from window
end type
type dw_link from u_dw within w_gp_prac_update
end type
type st_1 from statictext within w_gp_prac_update
end type
type dw_default from datawindow within w_gp_prac_update
end type
type cbx_con_per from checkbox within w_gp_prac_update
end type
type cbx_off_man from checkbox within w_gp_prac_update
end type
type cbx_bus_man from checkbox within w_gp_prac_update
end type
type cbx_status from checkbox within w_gp_prac_update
end type
type cbx_custdates from checkbox within w_gp_prac_update
end type
type cbx_phone from checkbox within w_gp_prac_update
end type
type cbx_fax from checkbox within w_gp_prac_update
end type
type cbx_cust2 from checkbox within w_gp_prac_update
end type
type cbx_ids from checkbox within w_gp_prac_update
end type
type cbx_email from checkbox within w_gp_prac_update
end type
type cbx_wait from checkbox within w_gp_prac_update
end type
type cbx_cust from checkbox within w_gp_prac_update
end type
type cbx_hours from checkbox within w_gp_prac_update
end type
type cbx_access from checkbox within w_gp_prac_update
end type
type cbx_address from checkbox within w_gp_prac_update
end type
type dw_linkold from datawindow within w_gp_prac_update
end type
type dw_find from datawindow within w_gp_prac_update
end type
type cb_help from commandbutton within w_gp_prac_update
end type
type cb_close from commandbutton within w_gp_prac_update
end type
type gb_2 from groupbox within w_gp_prac_update
end type
type cb_link from commandbutton within w_gp_prac_update
end type
end forward

global type w_gp_prac_update from window
integer x = 1074
integer y = 736
integer width = 1056
integer height = 1720
windowtype windowtype = popup!
long backcolor = 33551856
dw_link dw_link
st_1 st_1
dw_default dw_default
cbx_con_per cbx_con_per
cbx_off_man cbx_off_man
cbx_bus_man cbx_bus_man
cbx_status cbx_status
cbx_custdates cbx_custdates
cbx_phone cbx_phone
cbx_fax cbx_fax
cbx_cust2 cbx_cust2
cbx_ids cbx_ids
cbx_email cbx_email
cbx_wait cbx_wait
cbx_cust cbx_cust
cbx_hours cbx_hours
cbx_access cbx_access
cbx_address cbx_address
dw_linkold dw_linkold
dw_find dw_find
cb_help cb_help
cb_close cb_close
gb_2 gb_2
cb_link cb_link
end type
global w_gp_prac_update w_gp_prac_update

type variables
string   is_type //(Appeon)Stephen 01.06.2014 - V141 Import Modifications for Facility and Group
boolean ib_inactive = false  //maha 10.31.2016
long il_gpid //maha 10.31.2016
end variables

forward prototypes
private subroutine wf_update_pd_address ()
private function integer of_setitem (long al_row, string as_col, any aa_value, string as_type)
private subroutine of_update_address ()
public function integer of_set_defaults ()
public function integer of_batch_update_address (long al_loc_id[])
public function integer of_inactive_actions ()
end prototypes

private subroutine wf_update_pd_address ();
end subroutine

private function integer of_setitem (long al_row, string as_col, any aa_value, string as_type);//==========================================
// $<Function> Audit Trail: of_setitem ()
// $<arguments>
// 	value    string    as_type : data type
// 	value    long      al_row: current row
// 	value    string    as_col: column name
// 	value    any       aa_value: new value
// $<returns> integer 1 - success; -1 - failure 
// $<description> Set new value in dw_link
// $<add> (Appeon) Long.zhang 06.16.2011
//==========================================
string ls_old_value,ls_new_value,ls_as_col
Integer li_return_value

IF as_col = "rec_id" THEN
	ls_as_col = "gp_id"
ELSE
	ls_as_col =as_col
END IF


Choose Case as_type
	Case 'C'
		ls_old_value = dw_link.GetItemString(al_row,ls_as_col)
	Case 'N'	
		//messagebox("",ls_as_col)
		ls_old_value = String(dw_link.GetItemNumber(al_row,ls_as_col))
	Case 'D'
		ls_old_value = String(dw_link.GetItemDate(al_row,ls_as_col))
	Case 'T'	//added by long.zhang 07.09.2012 v12.2 group location mini-painter
		ls_old_value = String(dw_link.GetItemDateTime(al_row,ls_as_col))
	Case else
		return -1
End Choose

ls_new_value = String(aa_value)
IF Isnull(ls_old_value) And Isnull(ls_new_value) THEN
	Return 1
ELSEIF not Isnull(ls_old_value) And not Isnull(ls_new_value) THEN
	IF Trim(ls_old_value) <> Trim(ls_new_value) THEN
		li_return_value = dw_link.SetItem(al_row,ls_as_col,aa_value)
	END IF
ELSE
	li_return_value = dw_link.SetItem(al_row,ls_as_col,aa_value)
END IF
Return li_return_value
end function

private subroutine of_update_address ();//===================================
// $<Function> Audit trail : of_update_address ()
// $<arguments> none
// $<returns> none
// $<description> set new value in dw_link
// $<add> (Appeon) Long.zhang 06.20.2011
//===================================

integer r
integer res
Integer li_Return
integer li_set //maha 10.31.2016
long rc
long ac
long ll_prac
string ls_phone 
string ls_syntax
string ls_errortext	
DataStore lds_Data	
pfc_cst_nv_data_entry_functions inv_data_entry  //maha 10.31.2016

rc = dw_link.rowcount()
if rc < 1 then
	messagebox("No data to update","There are no practitioner address records connected to this location.")
	return
end if

for r = 1 to rc
	if cbx_address.checked = true then
		of_setitem(r,"street",dw_find.GetItemString(1,"street"),"C")
		of_setitem(r,"street_2",dw_find.GetItemString(1,"street_2"),"C")
		of_setitem(r,"alias_name",dw_find.GetItemString(1,"alias_name"),"C")  //Start Code Change ----04.24.2014 #V14.2 maha
		of_setitem(r,"city",dw_find.GetItemString(1,"city"),"C")
		of_setitem(r,"state",dw_find.GetItemNumber(1,"state"),"N")
		of_setitem(r,"zip",dw_find.GetItemString(1,"zip"),"C")
		of_setitem(r,"county",dw_find.GetItemNumber(1,"county"),"N")
		of_setitem(r,"country",dw_find.GetItemNumber(1,"country"),"N")   //Start Code Change ----05.26.2015 #V15 maha  -added missing field
		//of_setitem(r,"billing_address_id",dw_find.GetItemNumber(1,"billing_address_flag"),"N")   //Start Code Change ----02.22.2017 #V153 maha - added for ColumbiaDocs
		//Start Code Change ----12.06.2012 #V12 maha - added addditional checkboxes for these
		if cbx_phone.checked then 	
			of_setitem(r,"phone",dw_find.GetItemString(1,"phone"),"C")
			of_setitem(r,"ext",dw_find.GetItemString(1,"ext"),"C")  //Start Code Change ----02.19.2016 #V15 maha - moved under the phone checkbox
		end if
		if cbx_fax.checked then of_setitem(r,"fax",dw_find.GetItemString(1,"fax"),"C")
		//End Code Change ----12.06.2012
		of_setitem(r,"suite_apart",dw_find.GetItemString(1,"suite_apart"),"C")

		
		IF Isnull(dw_link.getitemstring(r,"e_mail_address")) THEN
			of_setitem(r,"e_mail_address",dw_find.GetItemString(1,"e_mail_address"),"C")
		END IF
		
		//Start Code Change ----11.08.2013 #V14 maha - added for oklahoma license
		IF cbx_con_per.checked THEN of_setitem(r,"contact_person",dw_find.GetItemString(1,"contact_person"),"C")
		IF cbx_bus_man.checked THEN of_setitem(r,"business_mgr",dw_find.GetItemString(1,"business_mgr"),"C")
		IF cbx_off_man.checked THEN of_setitem(r,"office_mgr",dw_find.GetItemString(1,"office_mgr"),"C")		
//		of_setitem(r,"contact_person",dw_find.GetItemString(1,"contact_person"),"C")
//		of_setitem(r,"business_mgr",dw_find.GetItemString(1,"business_mgr"),"C")
//		of_setitem(r,"office_mgr",dw_find.GetItemString(1,"office_mgr"),"C")
		//Start Code Change ----11.08.2013
		
		of_setitem(r,"tax_id",dw_find.GetItemString(1,"tax_id"),"C")
		of_setitem(r,"web_address",dw_find.GetItemString(1,"web_address"),"C")
		
		
		IF cbx_ids.checked THEN
			of_setitem(r,"tax_id_other_1",dw_find.GetItemString(1,"tax_id_other_1"),"C")
			of_setitem(r,"tax_id_other_2",dw_find.GetItemString(1,"tax_id_other_2"),"C")
		ELSE
			IF Isnull(dw_link.GetItemString(r,"tax_id_other_1")) THEN of_setitem(r,"tax_id_other_1",dw_find.GetItemString(1,"tax_id_other_1"),"C")
			IF Isnull(dw_link.GetItemString(r,"tax_id_other_2")) THEN of_setitem(r,"tax_id_other_2",dw_find.GetItemString(1,"tax_id_other_2"),"C")
		END IF
		
		of_setitem(r,"rec_id",dw_find.GetItemNumber(1,"rec_id"),"N")	//special dw_link.setitem(r,"gp_id",dw_find.getitemnumber(1,"rec_id"))
		
		IF cbx_email.checked THEN of_setitem(r,"e_mail_address",dw_find.GetItemString(1,"e_mail_address"),"C")
		

		
		//IF cbx_status.checked THEN of_setitem(r,"active_status",dw_find.GetItemString(1,"active_status"),"C")  //Start Code Change ----06.14.2013 #V14 maha //Commented by (Appeon)Harry 06.27.2013
		IF cbx_status.checked THEN 
			of_setitem(r,"active_status",dw_find.GetItemNumber(1,"active_status"),"N")  //(Appeon)Harry 06.27.2013				
		End if
		
	end if	 //Start Code Change ----06.14.2013 #V14 maha - corrected placement of end if which was at the end prior
		
	IF cbx_wait.checked THEN
		of_setitem(r,"routine_visit_appt",dw_find.GetItemString(1,"routine_visit_appt"),"C")
		of_setitem(r,"urgent_visit_appt",dw_find.GetItemString(1,"urgent_visit_appt"),"C")
		of_setitem(r,"emergency_visit_appt",dw_find.GetItemString(1,"emergency_visit_appt"),"C")
		of_setitem(r,"non_emergency_appt",dw_find.GetItemString(1,"non_emergency_appt"),"C")
	END IF
		
	IF cbx_access.checked THEN
		of_setitem(r,"handicapped_access",dw_find.GetItemNumber(1,"handicapped_access"),"N")
		of_setitem(r,"public_transportation",dw_find.GetItemNumber(1,"public_transportation"),"N")
	END IF
	
	IF cbx_hours.checked THEN
		of_setitem(r,"mon_from",dw_find.GetItemString(1,"mon_from"),"C")
		of_setitem(r,"mon_to",dw_find.GetItemString(1,"mon_to"),"C")
		of_setitem(r,"tue_from",dw_find.GetItemString(1,"tue_from"),"C")
		of_setitem(r,"tue_to",dw_find.GetItemString(1,"tue_to"),"C")
		of_setitem(r,"wed_from",dw_find.GetItemString(1,"wed_from"),"C")
		of_setitem(r,"wed_to",dw_find.GetItemString(1,"wed_to"),"C")
		of_setitem(r,"thu_from",dw_find.GetItemString(1,"thu_from"),"C")
		of_setitem(r,"thu_to",dw_find.GetItemString(1,"thu_to"),"C")
		of_setitem(r,"fri_from",dw_find.GetItemString(1,"fri_from"),"C")
		of_setitem(r,"fri_to",dw_find.GetItemString(1,"fri_to"),"C")
		of_setitem(r,"sat_from",dw_find.GetItemString(1,"sat_from"),"C")
		of_setitem(r,"sat_to",dw_find.GetItemString(1,"sat_to"),"C")
		of_setitem(r,"sun_from",dw_find.GetItemString(1,"sun_from"),"C")
		of_setitem(r,"sun_to",dw_find.GetItemString(1,"sun_to"),"C")
		of_setitem(r,"mon_from2",dw_find.GetItemString(1,"mon_from2"),"C")
		of_setitem(r,"mon_to2",dw_find.GetItemString(1,"mon_to2"),"C")
		of_setitem(r,"tue_from2",dw_find.GetItemString(1,"tue_from2"),"C")
		of_setitem(r,"tue_to2",dw_find.GetItemString(1,"tue_to2"),"C")
		of_setitem(r,"wed_from2",dw_find.GetItemString(1,"wed_from2"),"C")
		of_setitem(r,"wed_to2",dw_find.GetItemString(1,"wed_to2"),"C")
		of_setitem(r,"thu_from2",dw_find.GetItemString(1,"thu_from2"),"C")
		of_setitem(r,"thu_to2",dw_find.GetItemString(1,"thu_to2"),"C")
		of_setitem(r,"fri_from2",dw_find.GetItemString(1,"fri_from2"),"C")
		of_setitem(r,"fri_to2",dw_find.GetItemString(1,"fri_to2"),"C")
		of_setitem(r,"sat_from2",dw_find.GetItemString(1,"sat_from2"),"C")
		of_setitem(r,"sat_to2",dw_find.GetItemString(1,"sat_to2"),"C")
		of_setitem(r,"sun_from2",dw_find.GetItemString(1,"sun_from2"),"C")
		of_setitem(r,"sun_to2",dw_find.GetItemString(1,"sun_to2"),"C")
	END IF
		
	if cbx_cust.checked = true then	
		of_setitem(r,"cust_1",dw_find.GetItemString(1,"cust_1"),"C")
		of_setitem(r,"cust_2",dw_find.GetItemString(1,"cust_2"),"C")
		of_setitem(r,"cust_3",dw_find.GetItemString(1,"cust_3"),"C")
		of_setitem(r,"cust_4",dw_find.GetItemString(1,"cust_4"),"C")
		of_setitem(r,"cust_5",dw_find.GetItemString(1,"cust_5"),"C")
	end if
		
	if cbx_cust2.checked = true then		//Start Code Change ----10.03.2012 #V12 maha - added separate custom block
		//--------------------appeon begin---------------------
		//<$>added:long.zhang 07.09.2012
		//<$>reason:for v12.2 group location mini-painter
		of_setitem(r,"cust_6",dw_find.GetItemString(1,"cust_6"),"C")
		of_setitem(r,"cust_7",dw_find.GetItemString(1,"cust_7"),"C")
		of_setitem(r,"cust_8",dw_find.GetItemString(1,"cust_8"),"C")
		of_setitem(r,"cust_9",dw_find.GetItemString(1,"cust_9"),"C")
		of_setitem(r,"cust_10",dw_find.GetItemString(1,"cust_10"),"C")
		
		//--------------------appeon end-----------------------
	end if
	
	if cbx_custdates.checked = true then		//Start Code Change ----02.04.2013 #V12 maha - added separate custom block for dates
		of_setitem(r,"cust_d1",dw_find.GetItemDateTime(1,"cust_d1"),"T")
		of_setitem(r,"cust_d2",dw_find.GetItemDateTime(1,"cust_d2"),"T")
	end if
next

dw_link.Object.DataWindow.Table.UpdateTable='pd_address'
lds_Data = Create DataStore
inv_data_entry = Create pfc_cst_nv_data_entry_functions

ls_Syntax = dw_link.object.datawindow.syntax
lds_Data.Create (ls_Syntax, ls_ErrorText)
dw_link.ShareData (lds_Data)
li_Return = inv_data_entry.of_field_audit (lds_Data, ls_ErrorText)

gnv_appeondb.of_autocommit( )
dw_link.update()
commit using sqlca;
destroy lds_Data
destroy inv_data_entry

	
end subroutine

public function integer of_set_defaults ();//Start Code Change ----01.03.2014 #V14 maha

	if dw_default.getitemnumber(1,"addr_contacts") = 1 then
		cbx_address.checked = true
	else
		cbx_address.checked = false
	end if
	
	if dw_default.getitemnumber(1,"access_info") = 1 then
		cbx_access.checked = true
	else
		cbx_access.checked = false
	end if
	
	if dw_default.getitemnumber(1,"cust_g1") = 1 then
		cbx_cust.checked = true
	else
		cbx_cust.checked = false
	end if
	
	if dw_default.getitemnumber(1,"cust_g2") = 1 then
		cbx_cust2.checked = true
	else
		cbx_cust2.checked = false
	end if
	
	if dw_default.getitemnumber(1,"cust_dates") = 1 then
		cbx_custdates.checked = true
	else
		cbx_custdates.checked = false
	end if
	
	if dw_default.getitemnumber(1,"pract_hours") = 1 then
		cbx_hours.checked = true
	else
		cbx_hours.checked = false
	end if
	
	if dw_default.getitemnumber(1,"wait_times") = 1 then
		cbx_wait.checked = true
	else
		cbx_wait.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_email") = 1 then
		cbx_email.checked = true
	else
		cbx_email.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_fax") = 1 then
		cbx_fax.checked = true
	else
		cbx_fax.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_ids") = 1 then
		cbx_ids.checked = true
	else
		cbx_ids.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_phone") = 1 then
		cbx_phone.checked = true
	else
		cbx_phone.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_contact") = 1 then
		cbx_con_per.checked = true
	else
		cbx_con_per.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_bus_man") = 1 then
		cbx_bus_man.checked = true
	else
		cbx_bus_man.checked = false
	end if
	
	if dw_default.getitemnumber(1,"o_off_man") = 1 then
		cbx_off_man.checked = true
	else
		cbx_off_man.checked = false
	end if
	
	if dw_default.getitemnumber(1,"active_status") = 1 then
		cbx_status.checked = true
	else
		cbx_status.checked = false
	end if
	
	return 1
end function

public function integer of_batch_update_address (long al_loc_id[]);//====================================================================
//$<Function>: of_batch_update_address
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 01.06.2014 (V141 Import Modifications for Facility and Group)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_row, rc, gprc,  gp_id

for ll_row = 1 to upperbound(al_loc_id)
	gp_id = al_loc_id[ll_row]
	gnv_appeondb.of_startqueue( )
	gprc = dw_find.retrieve(gp_id)
	rc = dw_link.retrieve(gp_id)
	gnv_appeondb.of_commitqueue( )
	
	if rc < 1 or gprc < 1 then continue
	of_update_address()
	dw_find.reset()
	dw_link.reset()
next

return 1
end function

public function integer of_inactive_actions ();//Start Code Change ----11.01.2016 #V153 maha - created - called from of_update address
boolean lb_update = true
long rc
long r
long ll_prac
integer li_set
integer res
datastore lds_data

if ib_inactive = false then return 1  //setting if active status is made inactive

li_set = of_get_app_setting("set_89","I")  //0 = do not process; 1 = ask message; 2 = process no message
if isnull(li_set) or li_set = 0 then return 1
	
select count( rec_id) into :rc from net_dev_action_items where active_status = 1 and gp_id = :il_gpid;
if rc < 1 then  return 1

if li_set = 1 then
	res = messagebox("Inactive address","The address being made inactive has Application Tracking Actions connected to it.  Do you wish to make these Tracking Actions Inactive as well?", question!, yesno!, 2)
	if res = 2 then lb_update = false
end if

if ib_inactive = false then return 1

lds_data = create datastore
lds_data.dataobject = "d_group_net_dev_linked_pracs"
lds_data.settransobject(sqlca)
rc = lds_data.retrieve(il_gpid) 

for r = 1 to rc
	ll_prac = lds_data.getitemnumber(r, "prac_id")
	of_appl_action_inactive( il_gpid, ll_prac)
next

destroy lds_data


return 1
end function

on w_gp_prac_update.create
this.dw_link=create dw_link
this.st_1=create st_1
this.dw_default=create dw_default
this.cbx_con_per=create cbx_con_per
this.cbx_off_man=create cbx_off_man
this.cbx_bus_man=create cbx_bus_man
this.cbx_status=create cbx_status
this.cbx_custdates=create cbx_custdates
this.cbx_phone=create cbx_phone
this.cbx_fax=create cbx_fax
this.cbx_cust2=create cbx_cust2
this.cbx_ids=create cbx_ids
this.cbx_email=create cbx_email
this.cbx_wait=create cbx_wait
this.cbx_cust=create cbx_cust
this.cbx_hours=create cbx_hours
this.cbx_access=create cbx_access
this.cbx_address=create cbx_address
this.dw_linkold=create dw_linkold
this.dw_find=create dw_find
this.cb_help=create cb_help
this.cb_close=create cb_close
this.gb_2=create gb_2
this.cb_link=create cb_link
this.Control[]={this.dw_link,&
this.st_1,&
this.dw_default,&
this.cbx_con_per,&
this.cbx_off_man,&
this.cbx_bus_man,&
this.cbx_status,&
this.cbx_custdates,&
this.cbx_phone,&
this.cbx_fax,&
this.cbx_cust2,&
this.cbx_ids,&
this.cbx_email,&
this.cbx_wait,&
this.cbx_cust,&
this.cbx_hours,&
this.cbx_access,&
this.cbx_address,&
this.dw_linkold,&
this.dw_find,&
this.cb_help,&
this.cb_close,&
this.gb_2,&
this.cb_link}
end on

on w_gp_prac_update.destroy
destroy(this.dw_link)
destroy(this.st_1)
destroy(this.dw_default)
destroy(this.cbx_con_per)
destroy(this.cbx_off_man)
destroy(this.cbx_bus_man)
destroy(this.cbx_status)
destroy(this.cbx_custdates)
destroy(this.cbx_phone)
destroy(this.cbx_fax)
destroy(this.cbx_cust2)
destroy(this.cbx_ids)
destroy(this.cbx_email)
destroy(this.cbx_wait)
destroy(this.cbx_cust)
destroy(this.cbx_hours)
destroy(this.cbx_access)
destroy(this.cbx_address)
destroy(this.dw_linkold)
destroy(this.dw_find)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.gb_2)
destroy(this.cb_link)
end on

event open;long gp_id  //maha 01.15.2014 - changed to long
integer rc
gs_pass_ids lst_ids

//gp_id = message.doubleparm
lst_ids = message.powerobjectparm

//Start Code Change ----08.10.2017 #V154 maha
//	gp_id  = lst_ids.facility_id
	gp_id = lst_ids.l_ids[1]
//End Code Change ----08.10.2017

il_gpid = gp_id
if lst_ids.l_app_id = 1 then ib_inactive = true
//---------Begin Added by (Appeon)Stephen 01.06.2014 for V141 Import Modifications for Facility and Group--------
is_type = message.stringparm 
if is_type = 'imp' then this.hide()
//---------End Added ------------------------------------------------------

//messagebox ("gp_id",gp_id)
dw_find.settransobject(sqlca)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add the Appeon Queue Labels. 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

rc = dw_find.retrieve(gp_id)
dw_link.settransobject(sqlca)
dw_link.retrieve(gp_id)

//Start Code Change ----01.03.2014 #V14 maha
dw_default.settransobject(sqlca)
dw_default.retrieve()

//------------------- APPEON BEGIN -------------------
//<$>commnet by long.zhang 11.24.2014
//<$>reason:move this script out of the gnv_appeondb.of_commitqueue( )
//if dw_default.rowcount() > 0 then
//	of_set_defaults	()
//end if
//------------------- APPEON END -------------------

//End Code Change ----01.03.2014

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.13.2006 By: LeiWei
//$<reason> Performance tuning
//$<reason> Reduce the frequency of client-server interactions to improve runtime performance.
//$<reason> Add an Appeon Commit Queue Label. 
gnv_appeondb.of_commitqueue( )
rc = dw_find.rowcount( )
//---------------------------- APPEON END ----------------------------

//------------------- APPEON BEGIN -------------------
//<$>commnet by long.zhang 11.24.2014
//<$>reason:moved from above
if dw_default.rowcount() > 0 then
	of_set_defaults	()
end if
//------------------- APPEON END -------------------

//---------Begin Modified by (Appeon)Stephen 01.06.2014 for V141 Import Modifications for Facility and Group--------
//if rc < 1 then close(this)
if is_type <> 'imp' and rc < 1 then close(this)
//---------End Modfiied ------------------------------------------------------

end event

type dw_link from u_dw within w_gp_prac_update
boolean visible = false
integer x = 942
integer y = 732
integer width = 82
integer height = 208
integer taborder = 50
string dataobject = "d_gp_pracs_update"
end type

event buttonclicked;call super::buttonclicked;integer r
long rc

rc = this.rowcount()

if rc < 1 then return

//messagebox("rc",rc)
for r = 1 to rc
//	this.setitem(r,"pd_address_cust_6","1")
	this.setitem(r,"cust_6","1")	//Audit trail:	Modified By long.zhang 06.20.2011
next
end event

type st_1 from statictext within w_gp_prac_update
integer y = 20
integer width = 1051
integer height = 88
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "  Update Associated Addresses"
boolean focusrectangle = false
end type

type dw_default from datawindow within w_gp_prac_update
boolean visible = false
integer x = 64
integer y = 1436
integer width = 105
integer height = 92
integer taborder = 60
string title = "none"
string dataobject = "d_group_update_defaults"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_con_per from checkbox within w_gp_prac_update
integer x = 297
integer y = 700
integer width = 603
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Contact person"
boolean checked = true
end type

type cbx_off_man from checkbox within w_gp_prac_update
integer x = 293
integer y = 848
integer width = 603
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Office Manager"
boolean checked = true
end type

type cbx_bus_man from checkbox within w_gp_prac_update
integer x = 293
integer y = 776
integer width = 603
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Business Manager"
boolean checked = true
end type

type cbx_status from checkbox within w_gp_prac_update
integer x = 297
integer y = 628
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Active Status"
boolean checked = true
end type

type cbx_custdates from checkbox within w_gp_prac_update
integer x = 219
integer y = 1152
integer width = 649
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom (Dates)"
end type

type cbx_phone from checkbox within w_gp_prac_update
integer x = 297
integer y = 472
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone"
boolean checked = true
end type

type cbx_fax from checkbox within w_gp_prac_update
integer x = 297
integer y = 552
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Fax"
boolean checked = true
end type

type cbx_cust2 from checkbox within w_gp_prac_update
integer x = 219
integer y = 1076
integer width = 649
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom (Group 2)"
end type

type cbx_ids from checkbox within w_gp_prac_update
integer x = 297
integer y = 392
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Additional Ids"
end type

type cbx_email from checkbox within w_gp_prac_update
integer x = 297
integer y = 312
integer width = 613
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Existing Email "
end type

type cbx_wait from checkbox within w_gp_prac_update
integer x = 219
integer y = 1300
integer width = 425
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Waiting Times"
end type

type cbx_cust from checkbox within w_gp_prac_update
integer x = 219
integer y = 996
integer width = 649
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Custom (Group 1)"
end type

type cbx_hours from checkbox within w_gp_prac_update
integer x = 219
integer y = 1224
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Hours"
end type

type cbx_access from checkbox within w_gp_prac_update
integer x = 219
integer y = 924
integer width = 571
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Access Information"
end type

type cbx_address from checkbox within w_gp_prac_update
integer x = 219
integer y = 236
integer width = 690
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Address and Contacts"
boolean checked = true
end type

type dw_linkold from datawindow within w_gp_prac_update
boolean visible = false
integer x = 859
integer y = 612
integer width = 146
integer height = 72
integer taborder = 50
string dataobject = "d_gp_pracs_update"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;integer r
long rc

rc = this.rowcount()

if rc < 1 then return

//messagebox("rc",rc)
for r = 1 to rc
//	this.setitem(r,"pd_address_cust_6","1")
	this.setitem(r,"cust_6","1")	//Audit trail:	Modified By long.zhang 06.20.2011
next
end event

type dw_find from datawindow within w_gp_prac_update
boolean visible = false
integer x = 41
integer y = 644
integer width = 55
integer height = 120
integer taborder = 40
string dataobject = "d_gp_criteria_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_help from commandbutton within w_gp_prac_update
integer x = 1102
integer y = 200
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Help"
end type

event clicked;messagebox("Linking Practitioners to Practices","To link existing practitioners' addresses to a group practice, start by selecting a criteria type.~r  You can change the search parameter for that type if you wish. For example: ('Main' instead of '123 Main St').~r  When you click the find button, any addresses that match your criteria will be retrieved to the records window.~r  Select the practitioners you wish to link by clicking the check box for that practitioner.~r If the chain icon appears under the select box, that pratitioner has previously been linked.~r  The select data checkboxes allow you to decide which data fields get copied from the Group Practice file to the Practitioner's address file.~r You can select any or none. If you select none, the GP-Practitioner link will still be made.~r Click Update Practitioner Data to complete the update."  )
end event

type cb_close from commandbutton within w_gp_prac_update
integer x = 165
integer y = 1564
integer width = 686
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;close(parent)
end event

type gb_2 from groupbox within w_gp_prac_update
integer x = 69
integer y = 156
integer width = 855
integer height = 1252
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Data to Update"
end type

type cb_link from commandbutton within w_gp_prac_update
integer x = 165
integer y = 1464
integer width = 686
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Provider Data"
boolean cancel = true
end type

event clicked;//Audit trail: added by long.zhang 06.20.2011
of_update_address()
of_inactive_actions( )
close(parent)

end event

