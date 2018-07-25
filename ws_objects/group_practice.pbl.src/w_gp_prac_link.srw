$PBExportHeader$w_gp_prac_link.srw
forward
global type w_gp_prac_link from window
end type
type cx_phone from checkbox within w_gp_prac_link
end type
type cx_suite from checkbox within w_gp_prac_link
end type
type cx_street from checkbox within w_gp_prac_link
end type
type cx_group from checkbox within w_gp_prac_link
end type
type dw_default from datawindow within w_gp_prac_link
end type
type cbx_custdates from checkbox within w_gp_prac_link
end type
type cbx_cust2 from checkbox within w_gp_prac_link
end type
type cbx_cust from checkbox within w_gp_prac_link
end type
type cbx_off_man from checkbox within w_gp_prac_link
end type
type cbx_bus_man from checkbox within w_gp_prac_link
end type
type cbx_con_per from checkbox within w_gp_prac_link
end type
type cbx_status from checkbox within w_gp_prac_link
end type
type cbx_fax from checkbox within w_gp_prac_link
end type
type cbx_phone from checkbox within w_gp_prac_link
end type
type sle_suite from singlelineedit within w_gp_prac_link
end type
type cbx_ids from checkbox within w_gp_prac_link
end type
type cbx_email from checkbox within w_gp_prac_link
end type
type cbx_wait from checkbox within w_gp_prac_link
end type
type cbx_hours from checkbox within w_gp_prac_link
end type
type cbx_access from checkbox within w_gp_prac_link
end type
type cbx_address from checkbox within w_gp_prac_link
end type
type sle_phone from singlelineedit within w_gp_prac_link
end type
type sle_street from singlelineedit within w_gp_prac_link
end type
type sle_group from singlelineedit within w_gp_prac_link
end type
type dw_link from datawindow within w_gp_prac_link
end type
type dw_find from datawindow within w_gp_prac_link
end type
type cb_help from commandbutton within w_gp_prac_link
end type
type cb_close from commandbutton within w_gp_prac_link
end type
type cb_link from commandbutton within w_gp_prac_link
end type
type gb_2 from groupbox within w_gp_prac_link
end type
type gb_1 from groupbox within w_gp_prac_link
end type
type cb_find from commandbutton within w_gp_prac_link
end type
end forward

global type w_gp_prac_link from window
integer x = 256
integer y = 148
integer width = 3707
integer height = 2228
boolean titlebar = true
string title = "Link Provders to Group Practice"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
cx_phone cx_phone
cx_suite cx_suite
cx_street cx_street
cx_group cx_group
dw_default dw_default
cbx_custdates cbx_custdates
cbx_cust2 cbx_cust2
cbx_cust cbx_cust
cbx_off_man cbx_off_man
cbx_bus_man cbx_bus_man
cbx_con_per cbx_con_per
cbx_status cbx_status
cbx_fax cbx_fax
cbx_phone cbx_phone
sle_suite sle_suite
cbx_ids cbx_ids
cbx_email cbx_email
cbx_wait cbx_wait
cbx_hours cbx_hours
cbx_access cbx_access
cbx_address cbx_address
sle_phone sle_phone
sle_street sle_street
sle_group sle_group
dw_link dw_link
dw_find dw_find
cb_help cb_help
cb_close cb_close
cb_link cb_link
gb_2 gb_2
gb_1 gb_1
cb_find cb_find
end type
global w_gp_prac_link w_gp_prac_link

type variables
long il_gpid
end variables

forward prototypes
private function integer of_setitem (long al_row, string as_col, any aa_value, string as_type)
private subroutine of_update_address ()
public function integer of_set_defaults ()
public function integer of_check_links ()
end prototypes

private function integer of_setitem (long al_row, string as_col, any aa_value, string as_type);//==========================================
// $<Function> Audit Trail: of_setitem ()
// $<arguments>
// 	value    string    as_type : data type
// 	value    long      al_row: current row
// 	value    string    as_col: column name
// 	value    any       aa_value: new value
// $<returns> integer 1 - success; -1 - failure 
// $<description> Set new value in dw_link
// $<add> (Appeon) Long.zhang 06.22.2011
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
		ls_old_value = String(dw_link.GetItemNumber(al_row,ls_as_col))
	Case 'D'
		ls_old_value = String(dw_link.GetItemDate(al_row,ls_as_col))
	Case 'T'	
		ls_old_value = String(dw_link.GetItemDateTime(al_row,ls_as_col))//added by long.zhang 07.09.2012 v12.2 group location mini-painter
	Case else
		return -1
End Choose

ls_new_value = String(aa_value)

IF Isnull(ls_old_value) And Isnull(ls_new_value) THEN
	Return 1
ELSEIF not IsNull(ls_old_value) And not IsNull(ls_new_value) THEN
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
// $<description> set new value in dw_link and update audit trail
// $<add> (Appeon) Long.zhang 06.22.2011
//===================================

integer r
Integer li_Return
integer res
long rc
long cnt
long ll_current_row
string ls_phone
string ls_prac
string ls_syntax	
string ls_errortext	
DataStore lds_Data		
pfc_cst_nv_data_entry_functions inv_data_entry

rc = dw_link.rowcount()
if rc < 1 then
	messagebox("No practitioners to link","Use find first.")
	return
end if
for r = 1 to rc
	if dw_link.getitemnumber(r,"selected") = 1 then
		cnt++
		ll_current_row = r
	end if
next
if cnt = 0 then 
	messagebox("No records selected","Please select records to update.")
	return
end if
res = messagebox("Address Update","You have " + string(cnt) + " records selected to update.~r~rDo you wish to continue update?",question!,yesno!,2)
if res = 2 then
	return
end if
if cbx_address.checked = false then
	res = messagebox("Address Update Not Checked","You have unchecked the Address update checkbox.  If you continue you can potentially link Address records to this practice that to not have that address.~r~rDo you want to continue?",question!,yesno!,2)
	if res = 2 then
		return
	end if
end if
for r = 1 to rc
	 if dw_link.getitemnumber(r,"selected") = 1 then
		of_setitem(r,"street",dw_find.GetItemString(1,"street"),"C")
		of_setitem(r,"street_2",dw_find.GetItemString(1,"street_2"),"C")
		of_setitem(r,"city",dw_find.GetItemString(1,"city"),"C")
		of_setitem(r,"state",dw_find.GetItemNumber(1,"state"),"N")
		of_setitem(r,"zip",dw_find.GetItemString(1,"zip"),"C")
		of_setitem(r,"county",dw_find.GetItemNumber(1,"county"),"N")
		of_setitem(r,"ext",dw_find.GetItemString(1,"ext"),"C")   //Start Code Change ----08.12.2011 #V11 maha - ext field
		of_setitem(r,"suite_apart",dw_find.GetItemString(1,"suite_apart"),"C")
		IF Isnull(dw_link.getitemstring(r,"e_mail_address")) THEN
			of_setitem(r,"e_mail_address",dw_find.GetItemString(1,"e_mail_address"),"C")
		END IF
		of_setitem(r,"web_address",dw_find.GetItemString(1,"web_address"),"C")
		of_setitem(r,"tax_id",dw_find.GetItemString(1,"tax_id"),"C")
		
		//Start Code Change ----01.30.2014 #V14 maha
		if cbx_phone.checked then of_setitem(r,"phone",dw_find.GetItemString(1,"phone"),"C")
		if cbx_fax.checked then of_setitem(r,"fax",dw_find.GetItemString(1,"fax"),"C")
		IF cbx_con_per.checked THEN of_setitem(r,"contact_person",dw_find.GetItemString(1,"contact_person"),"C")
		IF cbx_bus_man.checked then of_setitem(r,"business_mgr",dw_find.GetItemString(1,"business_mgr"),"C")
		IF cbx_off_man.checked THEN of_setitem(r,"office_mgr",dw_find.GetItemString(1,"office_mgr"),"C")
		//End Code Change ----01.30.2014
		
		IF cbx_ids.checked THEN
			of_setitem(r,"tax_id_other_1",dw_find.GetItemString(1,"tax_id_other_1"),"C")
			of_setitem(r,"tax_id_other_2",dw_find.GetItemString(1,"tax_id_other_2"),"C")
		ELSE
			IF Isnull(dw_link.GetItemString(r,"tax_id_other_1")) THEN of_setitem(r,"tax_id_other_1",dw_find.GetItemString(1,"tax_id_other_1"),"C")
			IF Isnull(dw_link.GetItemString(r,"tax_id_other_2")) THEN of_setitem(r,"tax_id_other_2",dw_find.GetItemString(1,"tax_id_other_2"),"C")
		END IF
		
		if Isnull(dw_link.getitemnumber(r,"gp_id")) then
			if r< rc then//pd_address_prac_id
				ls_prac=ls_prac+string(dw_link.getitemnumber(r,"prac_id"))+','
			else
				ls_prac=ls_prac+string(dw_link.getitemnumber(r,"prac_id"))
			end if
		end if
		of_setitem(r,"rec_id",dw_find.GetItemNumber(1,"rec_id"),"N")
		IF cbx_email.checked THEN of_setitem(r,"e_mail_address",dw_find.GetItemString(1,"e_mail_address"),"C")
		
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
			//--------------------appeon begin---------------------
			//<$>added:long.zhang 07.09.2012
			//<$>reason:for v12.2 group location mini-painter
		if cbx_cust2.checked = true then	//Start Code Change ----01.30.2014 #V14 maha
			of_setitem(r,"cust_6",dw_find.GetItemString(1,"cust_6"),"C")
			of_setitem(r,"cust_7",dw_find.GetItemString(1,"cust_7"),"C")
			of_setitem(r,"cust_8",dw_find.GetItemString(1,"cust_8"),"C")
			of_setitem(r,"cust_9",dw_find.GetItemString(1,"cust_9"),"C")
			of_setitem(r,"cust_10",dw_find.GetItemString(1,"cust_10"),"C")
		end if
		
		if cbx_custdates.checked = true then  //Start Code Change ----01.30.2014 #V14 maha
			of_setitem(r,"cust_d1",dw_find.GetItemDateTime(1,"cust_d1"),"T")
			of_setitem(r,"cust_d2",dw_find.GetItemDateTime(1,"cust_d2"),"T")
			//--------------------appeon end-----------------------
		end if
		
	end if	
next

dw_link.Object.DataWindow.Table.UpdateTable='pd_address'
dw_link.setfilter( "selected=1")
dw_link.filter( )

lds_Data = Create DataStore
inv_data_entry = Create pfc_cst_nv_data_entry_functions
ls_Syntax = dw_link.object.datawindow.syntax
lds_Data.Create (ls_Syntax, ls_ErrorText)
dw_link.ShareData (lds_Data)
li_Return = inv_data_entry. of_field_audit (lds_Data, ls_ErrorText)

dw_link.update()
commit using sqlca;
dw_link.setfilter( "")
dw_link.filter( )
dw_link.ScrollToRow(ll_current_row)

destroy lds_Data
destroy inv_data_entry

if isvalid(w_group_practice) then
	w_group_practice.of_refresh_dw_tv(ls_prac,dw_find.getitemnumber(1,"rec_id"))
end if	

end subroutine

public function integer of_set_defaults ();//Start Code Change ----01.30.2014 #V14 maha - added

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

public function integer of_check_links ();//Start Code Change ----02.04.2016 #V15 maha - added
long r
long cnt
long ll_id
integer res

for r = 1 to dw_link.rowcount()
	if dw_link.getitemnumber( r,"selected") = 0 then continue
	ll_id = dw_link.getitemnumber( r,"gp_id")
	if isnull(ll_id) then continue
	if ll_id <> il_gpid then cnt++
next

if cnt > 0 then
	res = messagebox("WARNING", "One or more of the linked records are connected to another Location.  Updating these records will overwrite existing data including the link to the previous Location. ~r~rAre you sure you want to continue  with this update?" , question!,yesno!, 2)
	if res = 2 then return -1
end if


return 1
end function

on w_gp_prac_link.create
this.cx_phone=create cx_phone
this.cx_suite=create cx_suite
this.cx_street=create cx_street
this.cx_group=create cx_group
this.dw_default=create dw_default
this.cbx_custdates=create cbx_custdates
this.cbx_cust2=create cbx_cust2
this.cbx_cust=create cbx_cust
this.cbx_off_man=create cbx_off_man
this.cbx_bus_man=create cbx_bus_man
this.cbx_con_per=create cbx_con_per
this.cbx_status=create cbx_status
this.cbx_fax=create cbx_fax
this.cbx_phone=create cbx_phone
this.sle_suite=create sle_suite
this.cbx_ids=create cbx_ids
this.cbx_email=create cbx_email
this.cbx_wait=create cbx_wait
this.cbx_hours=create cbx_hours
this.cbx_access=create cbx_access
this.cbx_address=create cbx_address
this.sle_phone=create sle_phone
this.sle_street=create sle_street
this.sle_group=create sle_group
this.dw_link=create dw_link
this.dw_find=create dw_find
this.cb_help=create cb_help
this.cb_close=create cb_close
this.cb_link=create cb_link
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_find=create cb_find
this.Control[]={this.cx_phone,&
this.cx_suite,&
this.cx_street,&
this.cx_group,&
this.dw_default,&
this.cbx_custdates,&
this.cbx_cust2,&
this.cbx_cust,&
this.cbx_off_man,&
this.cbx_bus_man,&
this.cbx_con_per,&
this.cbx_status,&
this.cbx_fax,&
this.cbx_phone,&
this.sle_suite,&
this.cbx_ids,&
this.cbx_email,&
this.cbx_wait,&
this.cbx_hours,&
this.cbx_access,&
this.cbx_address,&
this.sle_phone,&
this.sle_street,&
this.sle_group,&
this.dw_link,&
this.dw_find,&
this.cb_help,&
this.cb_close,&
this.cb_link,&
this.gb_2,&
this.gb_1,&
this.cb_find}
end on

on w_gp_prac_link.destroy
destroy(this.cx_phone)
destroy(this.cx_suite)
destroy(this.cx_street)
destroy(this.cx_group)
destroy(this.dw_default)
destroy(this.cbx_custdates)
destroy(this.cbx_cust2)
destroy(this.cbx_cust)
destroy(this.cbx_off_man)
destroy(this.cbx_bus_man)
destroy(this.cbx_con_per)
destroy(this.cbx_status)
destroy(this.cbx_fax)
destroy(this.cbx_phone)
destroy(this.sle_suite)
destroy(this.cbx_ids)
destroy(this.cbx_email)
destroy(this.cbx_wait)
destroy(this.cbx_hours)
destroy(this.cbx_access)
destroy(this.cbx_address)
destroy(this.sle_phone)
destroy(this.sle_street)
destroy(this.sle_group)
destroy(this.dw_link)
destroy(this.dw_find)
destroy(this.cb_help)
destroy(this.cb_close)
destroy(this.cb_link)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_find)
end on

event open;long gp_id
long rc

gp_id = message.doubleparm
il_gpid = gp_id  //Start Code Change ----02.04.2016 #V15 maha

//messagebox ("gp_id",gp_id)
dw_find.settransobject(sqlca)
rc = dw_find.retrieve(gp_id)
if rc < 1 then return
dw_link.settransobject(sqlca)

sle_group.text = dw_find.getitemstring(1,"street")
sle_street.text = dw_find.getitemstring(1,"street_2")
sle_phone.text = dw_find.getitemstring(1,"phone")
sle_suite.text = dw_find.getitemstring(1,"suite_apart")

//Start Code Change ----01.30.2014 #V14 maha
of_set_defaults()

end event

type cx_phone from checkbox within w_gp_prac_link
integer x = 87
integer y = 440
integer width = 247
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Phone"
end type

type cx_suite from checkbox within w_gp_prac_link
integer x = 87
integer y = 332
integer width = 247
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Suite"
end type

type cx_street from checkbox within w_gp_prac_link
integer x = 87
integer y = 232
integer width = 261
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Street 2"
end type

type cx_group from checkbox within w_gp_prac_link
integer x = 87
integer y = 120
integer width = 261
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Street 1"
end type

type dw_default from datawindow within w_gp_prac_link
boolean visible = false
integer x = 2889
integer y = 4
integer width = 105
integer height = 92
integer taborder = 90
string title = "none"
string dataobject = "d_group_update_defaults"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cbx_custdates from checkbox within w_gp_prac_link
integer x = 3104
integer y = 552
integer width = 494
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

type cbx_cust2 from checkbox within w_gp_prac_link
integer x = 3104
integer y = 480
integer width = 494
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

type cbx_cust from checkbox within w_gp_prac_link
integer x = 3104
integer y = 408
integer width = 494
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

type cbx_off_man from checkbox within w_gp_prac_link
integer x = 2578
integer y = 408
integer width = 521
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

type cbx_bus_man from checkbox within w_gp_prac_link
integer x = 2578
integer y = 336
integer width = 521
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

type cbx_con_per from checkbox within w_gp_prac_link
integer x = 2583
integer y = 268
integer width = 521
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

type cbx_status from checkbox within w_gp_prac_link
integer x = 1902
integer y = 552
integer width = 677
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

type cbx_fax from checkbox within w_gp_prac_link
integer x = 1902
integer y = 480
integer width = 677
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

type cbx_phone from checkbox within w_gp_prac_link
integer x = 1902
integer y = 408
integer width = 677
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

type sle_suite from singlelineedit within w_gp_prac_link
integer x = 357
integer y = 328
integer width = 1321
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cbx_ids from checkbox within w_gp_prac_link
integer x = 1897
integer y = 336
integer width = 677
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Overwrite Additional Ids"
end type

type cbx_email from checkbox within w_gp_prac_link
integer x = 1897
integer y = 268
integer width = 681
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Overwrite Existing Email "
end type

type cbx_wait from checkbox within w_gp_prac_link
integer x = 3104
integer y = 336
integer width = 494
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

type cbx_hours from checkbox within w_gp_prac_link
integer x = 3104
integer y = 268
integer width = 494
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

type cbx_access from checkbox within w_gp_prac_link
integer x = 3104
integer y = 204
integer width = 535
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

type cbx_address from checkbox within w_gp_prac_link
integer x = 1856
integer y = 204
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
string text = "Address and Contacts"
boolean checked = true
end type

type sle_phone from singlelineedit within w_gp_prac_link
integer x = 357
integer y = 432
integer width = 1321
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_street from singlelineedit within w_gp_prac_link
integer x = 357
integer y = 224
integer width = 1321
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_group from singlelineedit within w_gp_prac_link
integer x = 357
integer y = 112
integer width = 1321
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_link from datawindow within w_gp_prac_link
integer x = 32
integer y = 688
integer width = 3643
integer height = 1436
integer taborder = 80
string dataobject = "d_gp_pracs_linking2"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event buttonclicked;integer r
long rc

rc = this.rowcount()

if rc < 1 then return

//messagebox("rc",rc)
//////Start Code Change ----05.07.2010 #V10 maha - added deselect fucntionality
if dwo.name = "b_all" then
	if dwo.text = "Select All" then
		for r = 1 to rc
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.04.2006 By: LeiWei
		//$<reason> Fix a defect.
		//this.setitem(r,"pd_address_cust_6","1")
			this.setitem(r,"selected",1)
		//---------------------------- APPEON END ----------------------------
		next
		dwo.text = "Deselect All"
	else
		for r = 1 to rc
			this.setitem(r,"selected",0)
		next
		dwo.text = "Select All"

	end if
end if
end event

type dw_find from datawindow within w_gp_prac_link
boolean visible = false
integer x = 608
integer y = 1964
integer width = 375
integer height = 68
integer taborder = 70
string dataobject = "d_gp_criteria_select"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_help from commandbutton within w_gp_prac_link
integer x = 3104
integer y = 36
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;messagebox("Linking Practitioners to Practices","To link existing practitioners' addresses to a group practice, start by selecting a criteria type.~r  You can change the search parameter for that type if you wish. For example: ('Main' instead of '123 Main St').~r  When you click the find button, any addresses that match your criteria will be retrieved to the records window.~r  Select the practitioners you wish to link by clicking the check box for that practitioner.~r If the chain icon appears under the select box, that pratitioner has previously been linked.~r  The select data checkboxes allow you to decide which data fields get copied from the Group Practice file to the Practitioner's address file.~r You can select any or none. If you select none, the GP-Practitioner link will still be made.~r Click Update Practitioner Data to complete the update."  )
end event

type cb_close from commandbutton within w_gp_prac_link
integer x = 3392
integer y = 36
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_link from commandbutton within w_gp_prac_link
integer x = 1755
integer y = 36
integer width = 677
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update Provider Data"
end type

event clicked;
if of_check_links() < 1 then return  //Start Code Change ----02.04.2016 #V15 maha
of_update_address()	//Audit trail: added by long.zhang 06.22.2011

//-----------------Appeon Begin comment-------------------------------
//<add> comment by long.zhang 06.20.2011
//<reason> replace with a new function
//integer r
//long rc 
//integer res
//long cnt //maha022208
//string ls_phone
//string ls_prac
//rc = dw_link.rowcount()
//
//if rc < 1 then
//	messagebox("No practitioners to link","Use find first.")
//	return
//end if
//
////Start Code Change ----02.22.2008 #V8 maha - additional trapping
//for r = 1 to rc
//	if dw_link.getitemnumber(r,"selected") = 1 then
//		cnt++
//	end if
//next
//
//if cnt = 0 then 
//	messagebox("No records selected","Please select records to update.")
//	return
//end if
//
//res = messagebox("Address Update","You have " + string(cnt) + " records selected to update.~r~rDo you wish to continue update?",question!,yesno!,2)
//if res = 2 then
//	return
//end if
////End Code Change---02.22.2008
//
//if cbx_address.checked = false then
//	res = messagebox("Address Update Not Checked","You have unchecked the Address update checkbox.  If you continue you can potentially link Address records to this practice that to not have that address.~r~rDo you want to continue?",question!,yesno!,2)
//	if res = 2 then
//		return
//	end if
//end if
//
//
//for r = 1 to rc
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<modify> 08.04.2006 By: LeiWei
//	//$<reason> Fix a defect.
//	//if dw_link.getitemstring(r,"pd_address_cust_6") = "1" then
//	if dw_link.getitemnumber(r,"selected") = 1 then
//	//---------------------------- APPEON END ----------------------------
//		if cbx_address.checked = true then
//			dw_link.setitem(r,"pd_address_street",dw_find.getitemstring(1,"street"))
//			dw_link.setitem(r,"pd_address_street_2",dw_find.getitemstring(1,"street_2"))
//			dw_link.setitem(r,"pd_address_city",dw_find.getitemstring(1,"city"))
//			dw_link.setitem(r,"pd_address_state",dw_find.getitemnumber(1,"state"))
//			dw_link.setitem(r,"pd_address_zip",dw_find.getitemstring(1,"zip"))
//			dw_link.setitem(r,"pd_address_county",dw_find.getitemnumber(1,"county"))
//			dw_link.setitem(r,"pd_address_country",dw_find.getitemnumber(1,"country"))
//			//Start Code Change ----06.10.2008 #V81 maha - strip format characters
//			//Start Code Change ----05.01.2009 #V92 maha - remove strip format
//			//ls_phone =  of_strip_char("",dw_find.getitemstring(1,"phone") ,"@NUM@")
//			ls_phone =  dw_find.getitemstring(1,"phone")
//			//End Code Change---05.01.2009
//			dw_link.setitem(r,"pd_address_phone",ls_phone)
//			//End Code Change---06.10.2008
//			dw_link.setitem(r,"pd_address_fax",dw_find.getitemstring(1,"fax"))
//			dw_link.setitem(r,"pd_address_suite_apart",dw_find.getitemstring(1,"suite_apart"))  //Start Code Change ---- 10.27.2006 #1 maha
//			if isnull(dw_link.getitemstring(r,"pd_address_e_mail_address")) then //maha 090805 to not overwrite existing data in prac record
//				dw_link.setitem(r,"pd_address_e_mail_address",dw_find.getitemstring(1,"e_mail_address"))
//			end if
//			dw_link.setitem(r,"pd_address_web_address",dw_find.getitemstring(1,"web_address"))
//			dw_link.setitem(r,"pd_address_contact_person",dw_find.getitemstring(1,"contact_person"))
//			dw_link.setitem(r,"pd_address_business_mgr",dw_find.getitemstring(1,"business_mgr"))
//			dw_link.setitem(r,"pd_address_office_mgr",dw_find.getitemstring(1,"office_mgr"))
//			dw_link.setitem(r,"pd_address_tax_id",dw_find.getitemstring(1,"tax_id"))
//			
//			//Start Code Change ----04.07.2010 #V10 maha - option to overwrite addtl ids not just set if null
//			if cbx_ids.checked then
//				dw_link.setitem(r,"pd_address_tax_id_other_1",dw_find.getitemstring(1,"tax_id_other_1"))
//				dw_link.setitem(r,"pd_address_tax_id_other_2",dw_find.getitemstring(1,"tax_id_other_2"))
//			else
//				if isnull(dw_link.getitemstring(r,"pd_address_tax_id_other_1")) then
//					dw_link.setitem(r,"pd_address_tax_id_other_1",dw_find.getitemstring(1,"tax_id_other_1")) //maha 101404
//				end if	
//				if isnull(dw_link.getitemstring(r,"pd_address_tax_id_other_2")) then
//					dw_link.setitem(r,"pd_address_tax_id_other_2",dw_find.getitemstring(1,"tax_id_other_2"))
//				end if
//			end if
//			//End Code Change---04.07.2010
//			//--------Begin added by  Nova 10.12.2010------------------------
//			//	V10.5 SK Group Practice 
//			if isnull(dw_link.getitemnumber(r,"pd_address_gp_id")) then
//				if r< rc then//pd_address_prac_id
//					ls_prac=ls_prac+string(dw_link.getitemnumber(r,"pd_address_prac_id"))+','
//				else
//					ls_prac=ls_prac+string(dw_link.getitemnumber(r,"pd_address_prac_id"))
//				end if
//			end if
//			//--------End Added --------------------------------------------
//			dw_link.setitem(r,"pd_address_gp_id",dw_find.getitemnumber(1,"rec_id"))
//		end if	
//		//Start Code Change ----04.21.2008 #V8 maha - allows overwrite of email address
//		if cbx_email.checked = true then
//			dw_link.setitem(r,"pd_address_e_mail_address",dw_find.getitemstring(1,"e_mail_address"))
//		end if
//		//End Code Change---04.21.2008
//		if cbx_wait.checked = true then
//			dw_link.setitem(r,"pd_address_routine_visit_appt",dw_find.getitemstring(1,"routine_visit_appt"))
//			dw_link.setitem(r,"pd_address_urgent_visit_appt",dw_find.getitemstring(1,"urgent_visit_appt"))
//			dw_link.setitem(r,"pd_address_emergency_visit_appt",dw_find.getitemstring(1,"emergency_visit_appt"))
//			dw_link.setitem(r,"pd_address_non_emergency_appt",dw_find.getitemstring(1,"non_emergency_appt"))
//		end if
//		
//		if cbx_access.checked = true then
//			dw_link.setitem(r,"pd_address_handicapped_access",dw_find.getitemnumber(1,"handicapped_access"))
//			dw_link.setitem(r,"pd_address_public_transportation",dw_find.getitemnumber(1,"public_transportation"))
//		end if
//		
//		if cbx_hours.checked = true then	
//			dw_link.setitem(r,"pd_address_mon_from",dw_find.getitemstring(1,"mon_from"))
//			dw_link.setitem(r,"pd_address_mon_to",dw_find.getitemstring(1,"mon_to"))
//			dw_link.setitem(r,"pd_address_tue_from",dw_find.getitemstring(1,"tue_from"))
//			dw_link.setitem(r,"pd_address_tue_to",dw_find.getitemstring(1,"tue_to"))
//			dw_link.setitem(r,"pd_address_wed_from",dw_find.getitemstring(1,"wed_from"))
//			dw_link.setitem(r,"pd_address_wed_to",dw_find.getitemstring(1,"wed_to"))
//			dw_link.setitem(r,"pd_address_thu_from",dw_find.getitemstring(1,"thu_from"))
//			dw_link.setitem(r,"pd_address_thu_to",dw_find.getitemstring(1,"thu_to"))
//			dw_link.setitem(r,"pd_address_fri_from",dw_find.getitemstring(1,"fri_from"))
//			dw_link.setitem(r,"pd_address_fri_to",dw_find.getitemstring(1,"fri_to"))
//			dw_link.setitem(r,"pd_address_sat_from",dw_find.getitemstring(1,"sat_from"))
//			dw_link.setitem(r,"pd_address_sat_to",dw_find.getitemstring(1,"sat_to"))
//			dw_link.setitem(r,"pd_address_sun_from",dw_find.getitemstring(1,"sun_from"))
//			dw_link.setitem(r,"pd_address_sun_to",dw_find.getitemstring(1,"sun_to"))
//			
//			dw_link.setitem(r,"pd_address_mon_from2",dw_find.getitemstring(1,"mon_from2"))
//			dw_link.setitem(r,"pd_address_mon_to2",dw_find.getitemstring(1,"mon_to2"))
//			dw_link.setitem(r,"pd_address_tue_from2",dw_find.getitemstring(1,"tue_from2"))
//			dw_link.setitem(r,"pd_address_tue_to2",dw_find.getitemstring(1,"tue_to2"))
//			dw_link.setitem(r,"pd_address_wed_from2",dw_find.getitemstring(1,"wed_from2"))
//			dw_link.setitem(r,"pd_address_wed_to2",dw_find.getitemstring(1,"wed_to2"))
//			dw_link.setitem(r,"pd_address_thu_from2",dw_find.getitemstring(1,"thu_from2"))
//			dw_link.setitem(r,"pd_address_thu_to2",dw_find.getitemstring(1,"thu_to2"))
//			dw_link.setitem(r,"pd_address_fri_from2",dw_find.getitemstring(1,"fri_from2"))
//			dw_link.setitem(r,"pd_address_fri_to2",dw_find.getitemstring(1,"fri_to2"))
//			dw_link.setitem(r,"pd_address_sat_from2",dw_find.getitemstring(1,"sat_from2"))
//			dw_link.setitem(r,"pd_address_sat_to2",dw_find.getitemstring(1,"sat_to2"))
//			dw_link.setitem(r,"pd_address_sun_from2",dw_find.getitemstring(1,"sun_from2"))
//			dw_link.setitem(r,"pd_address_sun_to2",dw_find.getitemstring(1,"sun_to2"))
//		end if
//		
//		if cbx_cust.checked = true then			
//			dw_link.setitem(r,"pd_address_cust_1",dw_find.getitemstring(1,"cust_1"))
//			dw_link.setitem(r,"pd_address_cust_2",dw_find.getitemstring(1,"cust_2"))
//			dw_link.setitem(r,"pd_address_cust_3",dw_find.getitemstring(1,"cust_3"))
//			dw_link.setitem(r,"pd_address_cust_4",dw_find.getitemstring(1,"cust_4"))
//			dw_link.setitem(r,"pd_address_cust_5",dw_find.getitemstring(1,"cust_5"))
//		end if
////		if cbx_address.checked = true then
////			dw_link.setitem(r,"pd_address_street",dw_find.getitemstring(1,"street"))
////			dw_link.setitem(r,"pd_address_street_2",dw_find.getitemstring(1,"street_2"))
////			dw_link.setitem(r,"pd_address_city",dw_find.getitemstring(1,"city"))
////			dw_link.setitem(r,"pd_address_state",dw_find.getitemnumber(1,"state"))
////			dw_link.setitem(r,"pd_address_zip",dw_find.getitemstring(1,"zip"))
////			dw_link.setitem(r,"pd_address_county",dw_find.getitemnumber(1,"county"))
////			dw_link.setitem(r,"pd_address_country",dw_find.getitemnumber(1,"country"))
////			dw_link.setitem(r,"pd_address_phone",dw_find.getitemstring(1,"phone"))
////			dw_link.setitem(r,"pd_address_fax",dw_find.getitemstring(1,"fax"))
////			dw_link.setitem(r,"pd_address_e_mail_address",dw_find.getitemstring(1,"e_mail_address"))
////			dw_link.setitem(r,"pd_address_web_address",dw_find.getitemstring(1,"web_address"))
////			dw_link.setitem(r,"pd_address_contact_person",dw_find.getitemstring(1,"contact_person"))
////			dw_link.setitem(r,"pd_address_business_mgr",dw_find.getitemstring(1,"business_mgr"))
////			dw_link.setitem(r,"pd_address_office_mgr",dw_find.getitemstring(1,"office_mgr"))
////			dw_link.setitem(r,"pd_address_tax_id",dw_find.getitemstring(1,"tax_id"))
////			dw_link.setitem(r,"pd_address_gp_id",dw_find.getitemnumber(1,"rec_id"))
////		end if	
////		if cbx_wait.checked = true then
////			dw_link.setitem(r,"pd_address_routine_visit_appt",dw_find.getitemstring(1,"routine_visit_appt"))
////			dw_link.setitem(r,"pd_address_urgent_visit_appt",dw_find.getitemstring(1,"urgent_visit_appt"))
////			dw_link.setitem(r,"pd_address_emergency_visit_appt",dw_find.getitemstring(1,"emergency_visit_appt"))
////			dw_link.setitem(r,"pd_address_non_emergency_appt",dw_find.getitemstring(1,"non_emergency_appt"))
////		end if
////		if cbx_access.checked = true then
////			dw_link.setitem(r,"pd_address_handicapped_access",dw_find.getitemnumber(1,"handicapped_access"))
////			dw_link.setitem(r,"pd_address_public_transportation",dw_find.getitemnumber(1,"public_transportation"))
////		end if
////		if cbx_hours.checked = true then	
////			dw_link.setitem(r,"pd_address_mon_from",dw_find.getitemstring(1,"mon_from"))
////			dw_link.setitem(r,"pd_address_mon_to",dw_find.getitemstring(1,"mon_to"))
////			dw_link.setitem(r,"pd_address_tue_from",dw_find.getitemstring(1,"tue_from"))
////			dw_link.setitem(r,"pd_address_tue_to",dw_find.getitemstring(1,"tue_to"))
////			dw_link.setitem(r,"pd_address_wed_from",dw_find.getitemstring(1,"wed_from"))
////			dw_link.setitem(r,"pd_address_wed_to",dw_find.getitemstring(1,"wed_to"))
////			dw_link.setitem(r,"pd_address_thu_from",dw_find.getitemstring(1,"thu_from"))
////			dw_link.setitem(r,"pd_address_thu_to",dw_find.getitemstring(1,"thu_to"))
////			dw_link.setitem(r,"pd_address_fri_from",dw_find.getitemstring(1,"fri_from"))
////			dw_link.setitem(r,"pd_address_fri_to",dw_find.getitemstring(1,"fri_to"))
////			dw_link.setitem(r,"pd_address_sat_from",dw_find.getitemstring(1,"sat_from"))
////			dw_link.setitem(r,"pd_address_sat_to",dw_find.getitemstring(1,"sat_to"))
////			dw_link.setitem(r,"pd_address_sun_from",dw_find.getitemstring(1,"sun_from"))
////			dw_link.setitem(r,"pd_address_sun_to",dw_find.getitemstring(1,"sun_to"))
////			
////			dw_link.setitem(r,"pd_address_mon_from2",dw_find.getitemstring(1,"mon_from2"))
////			dw_link.setitem(r,"pd_address_mon_to2",dw_find.getitemstring(1,"mon_to2"))
////			dw_link.setitem(r,"pd_address_tue_from2",dw_find.getitemstring(1,"tue_from2"))
////			dw_link.setitem(r,"pd_address_tue_to2",dw_find.getitemstring(1,"tue_to2"))
////			dw_link.setitem(r,"pd_address_wed_from2",dw_find.getitemstring(1,"wed_from2"))
////			dw_link.setitem(r,"pd_address_wed_to2",dw_find.getitemstring(1,"wed_to2"))
////			dw_link.setitem(r,"pd_address_thu_from2",dw_find.getitemstring(1,"thu_from2"))
////			dw_link.setitem(r,"pd_address_thu_to2",dw_find.getitemstring(1,"thu_to2"))
////			dw_link.setitem(r,"pd_address_fri_from2",dw_find.getitemstring(1,"fri_from2"))
////			dw_link.setitem(r,"pd_address_fri_to2",dw_find.getitemstring(1,"fri_to2"))
////			dw_link.setitem(r,"pd_address_sat_from2",dw_find.getitemstring(1,"sat_from2"))
////			dw_link.setitem(r,"pd_address_sat_to2",dw_find.getitemstring(1,"sat_to2"))
////			dw_link.setitem(r,"pd_address_sun_from2",dw_find.getitemstring(1,"sun_from2"))
////			dw_link.setitem(r,"pd_address_sun_to2",dw_find.getitemstring(1,"sun_to2"))
////		end if
////		if cbx_cust.checked = true then			
////			dw_link.setitem(r,"pd_address_cust_1",dw_find.getitemstring(1,"cust_1"))
////			dw_link.setitem(r,"pd_address_cust_2",dw_find.getitemstring(1,"cust_2"))
////			dw_link.setitem(r,"pd_address_cust_3",dw_find.getitemstring(1,"cust_3"))
////			dw_link.setitem(r,"pd_address_cust_4",dw_find.getitemstring(1,"cust_4"))
////			dw_link.setitem(r,"pd_address_cust_5",dw_find.getitemstring(1,"cust_5"))
////		end if
//	end if
//next
//
////res = messagebox("Updates completed","Do you want to save changes?",question!,yesno!,2)
////if res = 1 then 
//	dw_link.Object.DataWindow.Table.UpdateTable='pd_address'
//	dw_link.update()
//	commit using sqlca;
////end if
////--------Begin added by  Nova 10.12.2010------------------------
////	V10.5 SK Group Practice 
//if isvalid(w_group_practice) then
//	w_group_practice.of_refresh_dw_tv(ls_prac,dw_find.getitemnumber(1,"rec_id"))
//end if	
//--------End Added --------------------------------------------
//------------------------------Appeon end comment--------------------------------------
end event

type gb_2 from groupbox within w_gp_prac_link
integer x = 1755
integer y = 148
integer width = 1920
integer height = 516
integer taborder = 50
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

type gb_1 from groupbox within w_gp_prac_link
integer x = 27
integer y = 16
integer width = 1682
integer height = 648
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select  Address Criteria to Search"
end type

type cb_find from commandbutton within w_gp_prac_link
integer x = 869
integer y = 544
integer width = 247
integer height = 84
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;string ls_sql
string ls_sql_org
string ls_group
string ls_street
string ls_suite
string ls_phone
integer rows
integer chk //maha 022208
//Start Code Change ----05.07.2010 #V10 maha - added suite search functionality
ls_sql = dw_link.Object.DataWindow.Table.Select	
ls_sql_org = ls_sql
ls_group = upper(sle_group.text)
ls_street = upper(sle_street.text)
ls_suite = upper(sle_suite.text)
ls_phone = sle_phone.text

//-------------appeon begin----------------------
//<$>added:long.zhang 11.20.2013
//<$>reason:Fixed BugL111204 
	ls_group =  of_ReviseExpValue(ls_group, "'") 
	ls_street =  of_ReviseExpValue(ls_street, "'") 
	ls_suite =  of_ReviseExpValue(ls_suite, "'") 
	ls_phone =  of_ReviseExpValue(ls_phone, "'") 
//-------------appeon End------------------------

//Start Code Change ----02.22.2008 #V8 maha - monkey trap
if cx_group.checked = true then
	if LenA(ls_group) = 0 then chk = 1	
elseif cx_street.checked = true then
	if LenA(ls_street) = 0 then chk = 1	
elseif cx_suite.checked = true then
	if LenA(ls_suite) = 0 then chk = 1	
elseif cx_phone.checked = true then
	if LenA(ls_phone) = 0 then chk = 1	
end if

if chk = 1 then
	messagebox("User Error","You must have a search value for the selected Search Criteria")
	return
end if

//Start Code Change ----02.03.2016 #V15 maha - modified to allow multiple selection
ls_sql += " AND "

//End Code Change---02.22.2008
if cx_group.checked = true then
	ls_sql = ls_sql + "upper(street) like '%" + ls_group + "%' AND "
end if
if cx_street.checked = true then
	ls_sql = ls_sql + "upper(street_2) like '%" + ls_street + "%' AND "
end if
if cx_suite.checked = true then
	ls_sql = ls_sql + "upper(suite_apart) like '%" + ls_suite + "%' AND "
end if
if cx_phone.checked = true then
	ls_sql = ls_sql + "phone like '%" + ls_phone + "%' AND "
end if

ls_sql = mid(ls_sql, 1, len(ls_sql) - 4)
//End Code Change ----02.03.2016

dw_link.SetSQLSelect ( ls_sql )
		//openwithparm( w_sql_msg, ls_sql )
dw_link.SetTransObject( SQLCA )
rows = dw_link.Retrieve()

if rows < 0 then
	messagebox("Retrieval Error","Set query failed")
elseif rows = 0 then
	messagebox("No records found","There are no Practitioners' address data that meet the specified search criteria")
end if

//reset to org after retrieval
dw_link.SetSQLSelect ( ls_sql_org )
dw_link.SetTransObject( SQLCA )
end event

