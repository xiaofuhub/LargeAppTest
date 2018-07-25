$PBExportHeader$w_group_practice.srw
forward
global type w_group_practice from w_main
end type
type cb_copy from commandbutton within w_group_practice
end type
type cb_1 from commandbutton within w_group_practice
end type
type cb_selecttab2 from commandbutton within w_group_practice
end type
type dw_facility_add from datawindow within w_group_practice
end type
type dw_entity_add from datawindow within w_group_practice
end type
type cb_find_gp from commandbutton within w_group_practice
end type
type cb_prior from commandbutton within w_group_practice
end type
type cb_next from commandbutton within w_group_practice
end type
type cb_add_gp from commandbutton within w_group_practice
end type
type cb_delete from commandbutton within w_group_practice
end type
type cb_save from commandbutton within w_group_practice
end type
type tab_1 from tab within w_group_practice
end type
type tabpage_group from userobject within tab_1
end type
type cb_fac_links from commandbutton within tabpage_group
end type
type cb_refresh from commandbutton within tabpage_group
end type
type cb_collapse from commandbutton within tabpage_group
end type
type cb_expand from commandbutton within tabpage_group
end type
type st_3 from statictext within tabpage_group
end type
type st_2aaa from statictext within tabpage_group
end type
type st_1 from statictext within tabpage_group
end type
type dw_mg_detail from u_dw within tabpage_group
end type
type dw_group_tv from datawindow within tabpage_group
end type
type cb_link_loc from commandbutton within tabpage_group
end type
type cb_del_loc from commandbutton within tabpage_group
end type
type cb_addloc from commandbutton within tabpage_group
end type
type dw_loc_links from datawindow within tabpage_group
end type
type dw_mg_browse from datawindow within tabpage_group
end type
type cb_addgroup from commandbutton within tabpage_group
end type
type cb_delgroup from commandbutton within tabpage_group
end type
type tabpage_group from userobject within tab_1
cb_fac_links cb_fac_links
cb_refresh cb_refresh
cb_collapse cb_collapse
cb_expand cb_expand
st_3 st_3
st_2aaa st_2aaa
st_1 st_1
dw_mg_detail dw_mg_detail
dw_group_tv dw_group_tv
cb_link_loc cb_link_loc
cb_del_loc cb_del_loc
cb_addloc cb_addloc
dw_loc_links dw_loc_links
dw_mg_browse dw_mg_browse
cb_addgroup cb_addgroup
cb_delgroup cb_delgroup
end type
type tabpage_loc from userobject within tab_1
end type
type dw_pop from datawindow within tabpage_loc
end type
type uo_loc from pfc_cst_u_locations within tabpage_loc
end type
type ln_2 from line within tabpage_loc
end type
type ln_3 from line within tabpage_loc
end type
type ln_4 from line within tabpage_loc
end type
type ln_5 from line within tabpage_loc
end type
type tabpage_loc from userobject within tab_1
dw_pop dw_pop
uo_loc uo_loc
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
end type
type tabpage_assoc from userobject within tab_1
end type
type dw_assoc from datawindow within tabpage_assoc
end type
type tabpage_assoc from userobject within tab_1
dw_assoc dw_assoc
end type
type tab_1 from tab within w_group_practice
tabpage_group tabpage_group
tabpage_loc tabpage_loc
tabpage_assoc tabpage_assoc
end type
type cb_close from commandbutton within w_group_practice
end type
type cb_viewdoc from commandbutton within w_group_practice
end type
type cb_addfor from commandbutton within w_group_practice
end type
type st_buttons from statictext within w_group_practice
end type
end forward

global type w_group_practice from w_main
integer x = 5
integer y = 4
integer width = 4576
integer height = 2796
string title = "Group Practices"
long backcolor = 33551856
boolean center = true
cb_copy cb_copy
cb_1 cb_1
cb_selecttab2 cb_selecttab2
dw_facility_add dw_facility_add
dw_entity_add dw_entity_add
cb_find_gp cb_find_gp
cb_prior cb_prior
cb_next cb_next
cb_add_gp cb_add_gp
cb_delete cb_delete
cb_save cb_save
tab_1 tab_1
cb_close cb_close
cb_viewdoc cb_viewdoc
cb_addfor cb_addfor
st_buttons st_buttons
end type
global w_group_practice w_group_practice

type variables

Integer il_facility_id
integer ii_doc_level  //maha 12.13.2016
private Integer ii_level	//long.zhang 11.28.2013	access level

long il_CurPractice,il_CurGroup	//Added by Scofield on 2008-01-04
//long il_group_id //Defined in pfc_cst_u_location - commented by alfee 11.13.2010
long ii_mgp_id //
long il_loc_id //for Groups Tab only - alfee 11.13.2010
long ii_last_mgp_id, il_last_loc_id	//alfee 11.11.2010
long il_prac_id	//nova 09.27.2010
long il_current_row,il_current_level	//nova 09.27.2010

String is_open_for
String is_original_sql
String is_sql

boolean ib_find_row = false //alfee 11.11.2010

//$<add> 02.09.2006 By: LeiWei
Boolean ib_tabpage_data_created = False
Boolean ib_tabpage_detail_created = False
Boolean ib_tabpage_ass_prac_created = False
Boolean ib_tabpage_survey_created = False
Boolean ib_delete = False
boolean ib_tv_all = true



n_ds ids_datastore
n_cst_string inv_string //alfee 01.28.2010
pfc_cst_u_locations iuo_loc
nv_entity_functions inv_ent

str_expand_flag ex_flag[]//nova 09.27.2010
str_dw_band my_band//nova 09.27.2010

w_prac_data_1 iw_prac//nova 09.27.2010

//boolean lb_selected_datawindow_tv=false//nova 11.05.2010 - commented by alfee 11.11.2010
//boolean ib_add_loc_and_link=false//nova 11.05.2010 - commented by alfee 11.11.2010


end variables

forward prototypes
public function integer of_next_record (string as_dir)
public function integer of_set_security ()
public function integer of_linksave ()
public function integer of_add_entity_facility (long al_id, u_dw adw_data)
public subroutine of_expandbylevel (datawindow ad_name, integer ai_level)
public subroutine of_popmenu (integer ai_level)
public subroutine of_refresh_dw_tv (string as_praclist, long al_gp_id)
public function integer of_goto_practitioner_bk (long al_prac_id, long al_parent_facility_id)
public function integer of_goto_practitioner (long al_prac_id)
public subroutine cb_add_local_bak ()
public subroutine of_open ()
public function integer of_find_row (long al_gp_id, long al_loc_id)
public function long of_findrow_bk (datawindow adw_tv_dw, long al_row, datawindow adw_name, string as_get_field_name, string as_find_field_name)
public subroutine of_delete_dw_tv (long al_gp_id, long al_prac_id)
public subroutine of_scroll_tab2_dw_browse (long as_loc_id)
public subroutine of_group_link_local (long al_rec_id, long al_loc_id, boolean ab_updated)
public function integer of_get_accesslevel ()
public function integer of_setresize (boolean ab_switch)
public subroutine of_zoom ()
end prototypes

public function integer of_next_record (string as_dir);//Start Code Change ---- 06.08.2006 #527 maha 
//function added new 060806 for additional data prior/next buttons

datawindow ldw_browse
datawindow ldw_detail
Integer li_cnt
Integer r
Integer nr
Integer go = 0

ldw_browse = iuo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_browse.dw_browse
ldw_detail = iuo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_detail.dw_detail

li_cnt = ldw_browse.RowCount()
r = ldw_browse.GetRow()
//debugbreak()
IF ldw_browse.RowCount() > 1 THEN
	CHOOSE CASE as_dir
		CASE "N"
			IF r < li_cnt THEN
				nr = r + 1
				go = 1
			END IF
		CASE "P"
			IF r > 1 THEN
				nr = r - 1
				go = 1
			END IF
	END CHOOSE
	IF go = 1 THEN
		ldw_browse.ScrollToRow(nr)
		ldw_browse.SetRow(nr )
		ldw_browse.SelectRow(0,False)
		ldw_browse.SelectRow(nr,True)
		ldw_detail.ScrollToRow(nr )
		ldw_detail.SetRow(nr)
	END IF
END IF

RETURN 1

end function

public function integer of_set_security ();//Start Code Change ----01.04.2010 #V10 maha - function added for readonly security
integer li_level

li_level = w_mdi.of_security_access(1320)
ii_level = li_level	//long.zhang 11.28.2013

if li_level = 1 then //readonly
	cb_add_gp.visible = false
	cb_addfor.visible = false
	cb_delete.visible = false
	iuo_loc.tab_2.tabpage_survey.cb_import.visible = false
	cb_save.visible = false
	cb_copy.visible=false  //Start Code Change ----07.24.2017 #V154 maha
	tab_1.tabpage_group.cb_addloc.visible = false
//	tab_1.tabpage_group.cb_addmgp.visible = false
//	tab_1.tabpage_group.cb_linksave.visible = false
	tab_1.tabpage_group.cb_del_loc.visible = false
//	tab_1.tabpage_group.cb_del_group.visible = false
	tab_1.tabpage_group.dw_mg_detail.enabled = false
	iuo_loc.tab_2.tabpage_ass_prac.cb_unlink.visible = false
	iuo_loc.tab_2.tabpage_ass_prac.cb_link_prac.visible = false
	iuo_loc.tab_2.tabpage_detail.dw_detail.enabled = false
	iuo_loc.tab_2.tabpage_data.uo_data.of_security(1)
	//Start Code Change ----07.16.2010 #V10 maha
	tab_1.tabpage_group.cb_addloc.visible = false
	tab_1.tabpage_group.cb_addgroup.visible = false
	tab_1.tabpage_group.cb_del_loc.visible = false
	tab_1.tabpage_group.cb_link_loc.visible = false
	tab_1.tabpage_group.cb_delgroup.visible = false
	//End Code Change ----07.16.2010
	iuo_loc.tab_2.tabpage_docs.dw_docs.modify( "reference_value.protect = 1")  //Start Code Change ----10.25.2016 #V153 maha
end if


//Start Code Change ----12.13.2016 #V153 maha - added for documents - buttons security elsewhere
choose case ii_doc_level
	case 0 
		iuo_loc.tab_2.tabpage_docs.visible = false
end choose

if iuo_loc.tab_2.selectedtab = 4 and ii_doc_level = 1 then
	cb_add_gp.enabled = false
	cb_delete.enabled = false
else
	cb_add_gp.enabled = true
	cb_delete.enabled = true
end if
//End Code Change ----12.13.2016

	
//Start Code Change ----02.11.2014 #V14 maha - added
if gb_contract_version then
	iuo_loc.tab_2.tabpage_ass_prac.visible = false
	iuo_loc.tab_2.tabpage_data.visible = false
	cb_addfor.visible = false
end if
//End Code Change ----02.11.2014


return 1
end function

public function integer of_linksave ();//Start Code Change ----07.07.2010 #V10 maha - copied code from linksave button
Integer li_mgroup_id, li_mgroup_newid
Integer i
long     ll_recid

tab_1.tabpage_group.dw_mg_detail.AcceptText()
IF tab_1.tabpage_group.dw_mg_detail.ModifiedCount( )+tab_1.tabpage_group.dw_mg_detail.DeletedCount( ) > 0 THEN
	
	IF tab_1.tabpage_group.dw_mg_detail.GetItemStatus(1,0,primary!) = newmodified! THEN
		SELECT Max(rec_id) Into :li_mgroup_id From group_multi_loc;
		IF li_mgroup_id < 1 Or IsNull( li_mgroup_id) THEN li_mgroup_id = 0
		li_mgroup_id++
		ii_mgp_id = li_mgroup_id
		tab_1.tabpage_group.dw_mg_detail.SetItem(1,"rec_id",li_mgroup_id)
	END IF
	li_mgroup_newid = ii_mgp_id  //Add by Stephen 03.21.2011 --- tree view data echo.
	
	tab_1.tabpage_group.dw_mg_detail.Update()

	IF ib_delete = True THEN
		gnv_appeondb.of_startqueue( )
		tab_1.tabpage_group.dw_loc_links.Update()
		tab_1.tabpage_group.dw_mg_browse.Update()
		gnv_appeondb.of_commitqueue( )
	END IF
	
	tab_1.tabpage_group.dw_mg_browse.Retrieve()
	i = tab_1.tabpage_group.dw_mg_browse.Find("rec_id = " + String(ii_mgp_id),1,tab_1.tabpage_group.dw_mg_browse.RowCount())
	IF i > 0 THEN
		tab_1.tabpage_group.dw_mg_browse.SetRow(i)
		tab_1.tabpage_group.dw_mg_browse.ScrollToRow(i)
		tab_1.tabpage_group.dw_mg_browse.SelectRow(0,False)
		tab_1.tabpage_group.dw_mg_browse.SelectRow(i,True)
		//--------Begin added by  Nova 09.27.2010------------------------
		//V10.5 SK Group Practice 
		Long ll_rowcount,ll_found,ll_mgp_id
		datastore ds_addloc
		ds_addloc = Create datastore
		ds_addloc.DataObject = 'd_group_loc_assoc_with_mul_id'
		ds_addloc.SetTransObject( sqlca)
		
	
		//------------------- APPEON BEGIN -------------------
		//$<modify> stephen 03.21.2011
		//$<reason> tree view data echo
		/*
		ll_rowcount = ds_addloc.Retrieve(ii_mgp_id)
		IF ll_rowcount > 0 THEN
			ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  primary!, tab_1.tabpage_group.dw_group_tv , 1,  primary!)
		END IF
		*/
		ll_rowcount = ds_addloc.Retrieve(li_mgroup_newid)
		IF ll_rowcount > 0 THEN
			ll_recid = tab_1.tabpage_group.dw_group_tv.find("group_multi_loc_rec_id =" + string(li_mgroup_newid) , 1,  tab_1.tabpage_group.dw_group_tv.rowcount())
			if ll_recid > 0 then
				//Start Code Change ----03.19.2013 #V12 maha - added for single group retrieval
				if ib_tv_all = true then
					 tab_1.tabpage_group.dw_group_tv.retrieve()
				else
					 tab_1.tabpage_group.dw_group_tv.retrieve( li_mgroup_newid )
				end if
				//End Code Change ----03.19.2013 #V12 maha
			else
				ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  primary!, tab_1.tabpage_group.dw_group_tv , 1,  primary!)
			end if
			
		END IF
		//------------------- APPEON END ---------------------		
		
		tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
		//tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ") - commented by alfee 11.11.2010
		tab_1.tabpage_group.dw_group_tv.Sort()
		tab_1.tabpage_group.dw_group_tv.GroupCalc()
		//find tv-dw then expand
		ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(/*li_mgroup_id*/li_mgroup_newid), 1, tab_1.tabpage_group.dw_group_tv.RowCount()) //Modify by Stephen 03.21.2011 --- tree view data refresh.
		IF ll_found > 0 THEN
			IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 1) = False THEN
				tab_1.tabpage_group.dw_group_tv.expand( ll_found, 1)
				tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,1,True)
			END IF
		END IF		
		tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
			
		
		Destroy ds_addloc
		//--------End added --------------------------------------------
		
	END IF
END IF
RETURN 1

end function

public function integer of_add_entity_facility (long al_id, u_dw adw_data);long ll_group_id
long ll_ent
integer r
integer rc
n_ds lds_rules

ll_group_id = al_id


dw_facility_add.settransobject(sqlca)
dw_entity_add.settransobject(sqlca)
dw_facility_add.insertrow(1)
dw_entity_add.insertrow(1)
	
	//set facility data
dw_facility_add.setitem(1,"facility_id",ll_group_id)
dw_facility_add.setitem(1,"facility_name",adw_data.getitemstring(1,"gp_name"))
dw_facility_add.setitem(1,"street",adw_data.getitemstring(1,"street1"))
dw_facility_add.setitem(1,"street_2",adw_data.getitemstring(1,"street2"))
dw_facility_add.setitem(1,"city",adw_data.getitemstring(1,"city"))
dw_facility_add.setitem(1,"state",adw_data.getitemstring(1,"state"))
dw_facility_add.setitem(1,"zip",adw_data.getitemstring(1,"zip"))
dw_facility_add.setitem(1,"email_address",adw_data.getitemstring(1,"email_address"))
dw_facility_add.setitem(1,"web_address",adw_data.getitemstring(1,"web_address"))
dw_facility_add.setitem(1,"phone",adw_data.getitemstring(1,"phone"))
dw_facility_add.setitem(1,"fax",adw_data.getitemstring(1,"fax"))
dw_facility_add.setitem(1,"contact",adw_data.getitemstring(1,"contact_name"))
dw_facility_add.setitem(1,"credentialing_contact_title",adw_data.getitemstring(1,"contact_title"))
	
dw_facility_add.setitem(1,"return_facility_name",adw_data.getitemstring(1,"gp_name"))
dw_facility_add.setitem(1,"return_street",adw_data.getitemstring(1,"street1"))
dw_facility_add.setitem(1,"return_street_2",adw_data.getitemstring(1,"street2"))
dw_facility_add.setitem(1,"return_city",adw_data.getitemstring(1,"city"))
dw_facility_add.setitem(1,"return_state",adw_data.getitemstring(1,"state"))
dw_facility_add.setitem(1,"return_zip",adw_data.getitemstring(1,"zip"))

dw_facility_add.setitem(1,"default_audit_temp",1)
dw_facility_add.setitem(1,"default_verif_facility",1)
dw_facility_add.setitem(1,"letter_path",1)  
dw_facility_add.setitem(1,"default_data_view_id",2)

//Start Code Change ----06.15.2011 #V11 maha - additional defaults set
dw_facility_add.SetItem( 1, "appointment_years", 2)
dw_facility_add.SetItem( 1, "prov_export", 0)
dw_facility_add.SetItem( 1, "reapp_export", 0)
dw_facility_add.SetItem( 1, "reappah_export", 0)
dw_facility_add.SetItem( 1, "dupeset", 0)
dw_facility_add.SetItem( 1, "oig_auto_lname", 0)
dw_facility_add.SetItem( 1, "oig_auto_fname", 0)
dw_facility_add.SetItem( 1, "oig_auto_dob", 0)
dw_facility_add.SetItem( 1, "wf_exp_appt", 0)
//Start Code Change ----06.15.2011


//set entity data
select max(entity_id) into :ll_ent from entity_lookup;
if ll_ent < 1 OR IsNull( ll_ent) then ll_ent = 0
ll_ent++
dw_entity_add.setitem(1,"entity_id",ll_ent)
dw_entity_add.setitem(1,"facility_id",ll_group_id)
dw_entity_add.setitem(1,"group_id",ll_group_id)
dw_entity_add.setitem(1,"entity_name",adw_data.getitemstring(1,"gp_name"))
dw_entity_add.setitem(1,"street1",adw_data.getitemstring(1,"street1"))
dw_entity_add.setitem(1,"street2",adw_data.getitemstring(1,"street2"))
dw_entity_add.setitem(1,"city",adw_data.getitemstring(1,"city"))
dw_entity_add.setitem(1,"state",adw_data.getitemstring(1,"state"))
//dw_entity_add.setitem(1,"state",adw_data.getitemstring(1,"state"))
dw_entity_add.setitem(1,"zip",adw_data.getitemstring(1,"zip"))
dw_entity_add.setitem(1,"suite_apart",adw_data.getitemstring(1,"street2"))
dw_entity_add.setitem(1,"contact_name",adw_data.getitemstring(1, "contact_name"))
dw_entity_add.setitem(1,"phone",adw_data.getitemstring(1,"contact_title"))
dw_entity_add.setitem(1,"fax",adw_data.getitemstring(1,"fax"))
dw_entity_add.setitem(1,"email_address",adw_data.getitemstring(1,"email_address"))
dw_entity_add.setitem(1,"web_address",adw_data.getitemstring(1,"web_address"))
dw_entity_add.setitem(1,"tax_id",adw_data.getitemstring(1,"info1"))
dw_entity_add.setitem(1,"create_date", datetime(today(),now()))
dw_entity_add.setitem(1,"create_user", gs_user_id)

lds_rules = create n_ds
lds_rules.dataobject = "d_facility_rules_1"
lds_rules.settransobject(sqlca)
rc = lds_rules.retrieve()
lds_rules.rowscopy( 1, rc, primary!,lds_rules,10000,primary!)
for r = rc + 1 to lds_rules.rowcount()
	lds_rules.setitem(r,"facility_id",ll_group_id)	
next
lds_rules.update()

//add facility security

destroy lds_rules

return 1
end function

public subroutine of_expandbylevel (datawindow ad_name, integer ai_level);//--------Begin added by  Nova 09.27.2010------------------------
//V10.5 SK Group Practice 
IF ad_name.isexpanded(  my_band.row, ai_level) = True THEN
	ad_name.collapse(  my_band.row, ai_level)
ELSE
	ad_name.expand( my_band.row, ai_level)
END IF
//--------End added --------------------------------------------

end subroutine

public subroutine of_popmenu (integer ai_level);
end subroutine

public subroutine of_refresh_dw_tv (string as_praclist, long al_gp_id);//V10.5 SK Group Practice - Nova 09.25.2010
Long ll_group_id,ll_find
String ls_prac_list[]
String ls_sql, ls_err, ls_find
Long ll_prac_list[],i,ll_rowcount
n_cst_string   lnv_string

//--------Begin Modified by alfee 11.11.2010 ---------------------
IF IsNull(as_praclist) OR Len(Trim(as_praclist)) < 1 THEN RETURN

This.SetRedraw( False)

//Delete the specified location records
ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_practice_rec_id="+String(al_gp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
DO WHILE ll_find > 0
	tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_practice_rec_id="+String(al_gp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
LOOP

//Retrieve specified location records
datastore ds_addloc
ds_addloc = Create datastore
ds_addloc.DataObject = 'd_group_loc_assoc_tv'
ds_addloc.SetTransObject( sqlca)

ls_sql = ds_addloc.GetSQLSelect()
ls_sql += " where group_practice.rec_id = " + String(al_gp_id) 
ls_err = ds_addloc.modify('datawindow.table.select = "' +  ls_sql  + '"')
if LenA( ls_err) > 0  then messagebox("Set SQL Select error",ls_sql)

ds_addloc.SetTransObject( sqlca)
ll_rowcount = ds_addloc.Retrieve()

//Restore the location records
IF ll_rowcount > 0 THEN
	tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
	ds_addloc.RowsCopy(1 , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)		
	tab_1.tabpage_group.dw_group_tv.Sort()
	tab_1.tabpage_group.dw_group_tv.GroupCalc()
	tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
END IF

//Re-locate to the current group and location
ls_find = "group_multi_loc_rec_id = " + String(ii_mgp_id) + " and group_practice_rec_id="+String(al_gp_id)
ll_find = tab_1.tabpage_group.dw_group_tv.Find(ls_find, 1, tab_1.tabpage_group.dw_group_tv.RowCount()) 
IF ll_find > 0 THEN
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
	tab_1.tabpage_group.dw_group_tv.Expand(ll_find, 1)
	tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find, 2, True)
END IF

Destroy ds_addloc
This.SetRedraw( True)

//lnv_string.of_parsetoarray( as_praclist, ',', ls_prac_list[])
//FOR i = 1 To UpperBound(ls_prac_list)
//	ll_prac_list[i] = Long(ls_prac_list[i])
//NEXT
//
//datastore ds_addprac
//ds_addprac = Create datastore
//ds_addprac.DataObject = 'd_group_loc_assoc_by_loc_gp'
//ds_addprac.SetTransObject( sqlca)
//
//ll_group_id = ii_mgp_id
//ll_rowcount = ds_addprac.Retrieve(ll_group_id,al_gp_id )
//
//IF ll_rowcount > 0 THEN
//	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id)+" and group_practice_rec_id="+String(al_gp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	DO WHILE ll_find > 0
//		tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
//		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id)+" and group_practice_rec_id="+String(al_gp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	LOOP
//	ds_addprac.RowsCopy( ds_addprac.GetRow( ) , ds_addprac.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)
//	tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
//	tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ")
//	tab_1.tabpage_group.dw_group_tv.Sort()
//	tab_1.tabpage_group.dw_group_tv.GroupCalc()
//	tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
//	//find tv-dw then expand
//	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	IF ll_find > 0 THEN
//		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_find, 1) = False THEN
//			tab_1.tabpage_group.dw_group_tv.expand( ll_find, 1)
//		END IF
//		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id)+" and group_practice_rec_id="+String(iuo_loc.il_group_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//		IF ll_find > 0 THEN
//			tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
//			IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_find, 2) = False THEN
//				tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find,2,True)
//				tab_1.tabpage_group.dw_group_tv.expand( ll_find, 2)
//			END IF
//			tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find,2,True)
//		END IF
//	END IF
//
//END IF
//Destroy ds_addprac	
//--------End Modified ---------------------------------------------



end subroutine

public function integer of_goto_practitioner_bk (long al_prac_id, long al_parent_facility_id);//Initiate serach
IF iw_prac.tab_1.SelectedTab <> 1 THEN
	iw_prac.tab_1.SelectTab( 1 )
END IF

// Find appropriate practitioner
pfc_cst_u_extended_search luo_search
luo_search = iw_prac.tab_1.tabpage_search.uo_search

luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0 )
luo_search.ddlb_search_type.Text = "Last Name"
luo_search.sle_srch_val.Text = ""
luo_search.cb_search.TriggerEvent(Clicked!)

// Check rights
Long ll_row
ll_row = luo_search.dw_search.Find("prac_id = " + String(al_prac_id) + " AND parent_facility_id = " +&
	String(al_parent_facility_id), 1, luo_search.dw_search.RowCount())
IF ll_row <= 0 THEN
	MessageBox("Warning", "The #" + String(al_prac_id) + " practitioner does not exist!")
	RETURN 0
END IF

luo_search.dw_search.SetRow(ll_row)
luo_search.dw_search.ScrollToRow(ll_row)

iw_prac.tab_1.SelectTab( 2 )

RETURN 1

end function

public function integer of_goto_practitioner (long al_prac_id);//--------Begin added by  Nova 09.27.2010------------------------
//V10.5 SK Group Practice 

Long ll_row
String ls_find
long ll_facility_id
IF gb_sk_ver = False THEN//normal
	// Find appropriate practitioner
	//Initiate serach
	IF iw_prac.tab_1.SelectedTab <> 1 THEN
		iw_prac.tab_1.SelectTab( 1 )
	END IF
	
	pfc_cst_u_extended_search luo_search
	luo_search = iw_prac.tab_1.tabpage_search.uo_search
	
	luo_search.dw_org_facility_select.SetItem( 1, "facility_id", 0 )
	luo_search.ddlb_search_type.Text = "Last Name"
	luo_search.sle_srch_val.Text = ""
	luo_search.cb_search.TriggerEvent(Clicked!)
	
	ll_row = luo_search.dw_search.Find("prac_id = " + String(al_prac_id), 1, luo_search.dw_search.RowCount())
	IF ll_row <= 0 THEN
		MessageBox("Warning", "The #" + String(al_prac_id) + " practitioner does not exist!")
		RETURN 0
	END IF
	
	luo_search.dw_search.SetRow(ll_row)
	luo_search.dw_search.ScrollToRow(ll_row)
	iw_prac.BringToTop = True
ELSE//sk
	ll_row = w_prac_data_sk.dw_prac_list.Find("prac_id = " + String(al_prac_id),1,w_prac_data_sk.dw_prac_list.RowCount())
	IF ll_row <= 0 THEN
		MessageBox("Warning", "The #" + String(al_prac_id) + " practitioner does not exist!")
		RETURN 0
	END IF
	ll_facility_id=w_prac_data_sk.dw_prac_list.object.parent_facility_id[ll_row]
	w_prac_data_sk.of_find_tv_search (ll_facility_id, al_prac_id)
	w_prac_data_sk.BringToTop = True
END IF

RETURN 1

//--------End added --------------------------------------------



end function

public subroutine cb_add_local_bak ();//Long li_linkrow
//Long li_link_id
//Long li_loc_id
//Long li_mgp_id
//Long ll_cnt, ll_found //04.22.2008
//Long ll_rowcount
//
//IF tab_1.tabpage_group.dw_mg_browse.RowCount() < 1 THEN RETURN
//
//of_linksave()
//Open(w_practice_to_addr_find)
//
//li_loc_id = Message.DoubleParm
//IF li_loc_id < 1 THEN RETURN
//
////----------Begin Added by Alfee on 04.22.2008---------------------
////Check to avoid duplicate records 
//ll_cnt = tab_1.tabpage_group.dw_loc_links.RowCount()
//IF ll_cnt > 0 THEN
//	ll_found = tab_1.tabpage_group.dw_loc_links.Find( "group_loc_link_loc_id = " + String(li_loc_id), 1, ll_cnt)
//	IF ll_found > 0  THEN RETURN
//END IF
////----------End Added ---------------------------------------------
//
//li_mgp_id = ii_mgp_id
//
//li_linkrow = tab_1.tabpage_group.dw_loc_links.InsertRow(0)
//
////tab_1.tabpage_group_master.dw_loc_links.setrow(li_linkrow) 
////tab_1.tabpage_group_master.dw_loc_links.scrolltorow(li_linkrow)
////tab_1.tabpage_group_master.dw_loc_links.selectrow(0,false)
////tab_1.tabpage_group_master.dw_loc_links.selectrow(li_linkrow,true)
//
//
//SELECT max(rec_id)
//	INTO :li_link_id
//	From group_loc_link;
//	
//IF li_link_id < 1 Or IsNull( li_link_id ) THEN li_link_id = 0
//
//li_link_id++
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_rec_id",li_link_id)
////messagebox("li_loc_id",li_loc_id)
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_loc_id",li_loc_id)
////messagebox("li_mgp_id",li_mgp_id)
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_group_id",li_mgp_id)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-24
////$<add> 02.09.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_startqueue( )
////---------------------------- APPEON END ----------------------------
//
//tab_1.tabpage_group.dw_loc_links.Update()
//COMMIT Using sqlca;
//
//tab_1.tabpage_group.dw_loc_links.Retrieve(ii_mgp_id)
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-25
////$<add> 02.09.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//gnv_appeondb.of_commitqueue( )
////---------------------------- APPEON END ----------------------------
//
////--------Begin added by  Nova 09.27.2010------------------------
////V10.5 SK Group Practice 
//datastore ds_addloc
//ds_addloc = Create datastore
//ds_addloc.DataObject = 'd_group_loc_assoc_with_mul_id'
//ds_addloc.SetTransObject( sqlca)
//ll_rowcount = ds_addloc.Retrieve(ii_mgp_id)
//
//IF ll_rowcount > 0 THEN
//	ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	
//	Parent.SetRedraw( False)
//	DO WHILE ll_found > 0
//		tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_found)
//		ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	LOOP
//	Parent.SetRedraw( True)
//END IF
//ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)
//tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
//tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ")
//tab_1.tabpage_group.dw_group_tv.Sort()
//tab_1.tabpage_group.dw_group_tv.GroupCalc()
//tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
////find tv-dw then expand
//ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//IF ll_found > 0 THEN
//	IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 1) = False THEN
//		tab_1.tabpage_group.dw_group_tv.expand( ll_found, 1)
//	END IF
//	ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id)+" and group_practice_rec_id="+String(li_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	IF ll_found > 0 THEN
//		tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_found)
//		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 2) = False THEN
//			tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,2,True)
//			tab_1.tabpage_group.dw_group_tv.expand( ll_found, 2)
//		END IF
//		tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,2,True)
//	END IF
//END IF
//Destroy ds_addloc
////--------End added --------------------------------------------
//
end subroutine

public subroutine of_open ();//--------Begin added by  Nova 09.27.2010------------------------
//V10.5 SK Group Practice 

IF gs_cust_type = "I" THEN
	IF gb_sk_ver = False THEN
		IF Not IsValid(w_prac_data_intelliapp) THEN
			OpenSheet( w_prac_data_intelliapp, w_mdi, 4, original!)
			w_prac_data_intelliapp.Move(0,0)
			w_prac_data_intelliapp.BringToTop = True
		END IF
		iw_prac = w_prac_data_intelliapp
	ELSEIF gb_sk_ver = True  THEN
		IF Not IsValid(w_prac_data_sk) THEN
			OpenSheet( w_prac_data_sk, w_mdi, 4, original!)
		END IF
		iw_prac = w_prac_data_sk
	END IF
ELSE
	IF Not IsValid(w_prac_data_1) THEN
		OpenSheet( w_prac_data_1, w_mdi, 4, original!)
	END IF
	iw_prac = w_prac_data_1
END IF
//--------End added --------------------------------------------
end subroutine

public function integer of_find_row (long al_gp_id, long al_loc_id);//Find row in the group and address datawindow (V10.5 SK Group Practice - alfee 11.11.2010)

long ll_cnt, ll_found

ib_find_row = true

//locate in group dw
ll_cnt = tab_1.tabpage_group.dw_mg_browse.rowcount( )
ll_found = tab_1.tabpage_group.dw_mg_browse.find("rec_id = " + string(al_gp_id) ,1, ll_cnt)
if isnull(ll_found) or ll_found < 1 then ll_found = 1
if ll_cnt > 0 then 
	tab_1.tabpage_group.dw_mg_browse.setrow(ll_found)
	tab_1.tabpage_group.dw_mg_browse.scrolltorow(ll_found)
	tab_1.tabpage_group.dw_mg_browse.selectrow( 0, False)
	tab_1.tabpage_group.dw_mg_browse.selectrow( ll_found, True)	
end if
	
//locate in address dw	
ll_cnt = tab_1.tabpage_group.dw_loc_links.rowcount( )
ll_found = tab_1.tabpage_group.dw_loc_links.find("group_loc_link_loc_id = " + string(al_loc_id) ,1, ll_cnt)
if isnull(ll_found) or ll_found < 1 then ll_found = 1
if ll_cnt > 0 then 
	tab_1.tabpage_group.dw_loc_links.setrow(ll_found)
	tab_1.tabpage_group.dw_loc_links.scrolltorow(ll_found)
	tab_1.tabpage_group.dw_loc_links.selectrow( 0, False)
	tab_1.tabpage_group.dw_loc_links.selectrow( ll_found, True)	
end if

ib_find_row = false

return 1


end function

public function long of_findrow_bk (datawindow adw_tv_dw, long al_row, datawindow adw_name, string as_get_field_name, string as_find_field_name);//Commented by alfee 11.11.2010

////--------Begin added by  Nova 09.27.2010------------------------
////V10.5 SK Group Practice 
//Long ll_rec_id, ll_rowcount ,ll_found, ll_id
//
//ll_rec_id = adw_tv_dw.GetItemNumber(al_row , as_get_field_name)
//
//IF as_get_field_name = "group_multi_loc_rec_id" THEN
//	ii_mgp_id = ll_rec_id
//ELSEIF as_get_field_name = "group_practice_rec_id"  THEN
//	ll_rowcount = tab_1.tabpage_group.dw_mg_browse.RowCount( )
//	ll_id = adw_tv_dw.GetItemNumber(al_row , "group_multi_loc_rec_id")
//	ii_mgp_id = ll_id
//	ll_found = tab_1.tabpage_group.dw_mg_browse.Find("rec_id="+String(ll_id), 1, ll_rowcount)
//	IF ll_found > 0 THEN
//		tab_1.tabpage_group.dw_mg_browse.ScrollToRow( ll_found)
//		tab_1.tabpage_group.dw_mg_browse.SelectRow( 0, False)
//		tab_1.tabpage_group.dw_mg_browse.SelectRow( ll_found, True)
//	ELSE
//		RETURN 	0
//	END IF
//END IF
//
//ll_rowcount = adw_name.RowCount( )
//ll_found = adw_name.Find(as_find_field_name+"="+String(ll_rec_id), 1, ll_rowcount)
//IF ll_found > 0 THEN
//	adw_name.ScrollToRow( ll_found)
//	adw_name.SelectRow( 0, False)
//	adw_name.SelectRow( ll_found, True)
//	IF as_get_field_name = "group_practice_rec_id" THEN iuo_loc.il_group_id = adw_name.Object.group_loc_link_loc_id[ll_found]
//	RETURN 	ll_found
//ELSE
//	RETURN 	0
//END IF
//
////--------End added --------------------------------------------
//
RETURN 1
end function

public subroutine of_delete_dw_tv (long al_gp_id, long al_prac_id);//V10.5 SK Group Practice - Nova 09.27.2010

Long ll_find
Long ll_rowcount,ll_found
String ls_full_name, ls_find, ls_sql, ls_err
datastore ds_addloc

ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_practice_rec_id="+String(al_gp_id)+" and pd_address_prac_id="+String(al_prac_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
This.SetRedraw( False)
DO WHILE ll_find > 0
	tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_practice_rec_id="+String(al_gp_id)+" and pd_address_prac_id="+String(al_prac_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
LOOP

//refresh datawindow tv
//--------Begin Modified by alfee 11.11.2010 ---------------------
//get the location records without associated practitioners
ds_addloc = Create datastore
ds_addloc.DataObject = 'd_group_loc_assoc_tv'
ds_addloc.SetTransObject( sqlca)

ls_sql = ds_addloc.GetSQLSelect()
ls_sql += " where group_practice.rec_id = " + String(al_gp_id) + " and pd_address.prac_id is null "
ls_err = ds_addloc.modify('datawindow.table.select = "' +  ls_sql  + '"')
if LenA( ls_err) > 0  then messagebox("Set SQL Select error",ls_sql)

ds_addloc.SetTransObject( sqlca)
ll_rowcount = ds_addloc.Retrieve()

//restore the location records without associated practitioners
IF ll_rowcount > 0 THEN
	tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
	ds_addloc.RowsCopy(1 , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)		
	tab_1.tabpage_group.dw_group_tv.Sort()
	tab_1.tabpage_group.dw_group_tv.GroupCalc()
	tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
END IF

//re-locate to the current group and location
ls_find = "group_multi_loc_rec_id = " + String(ii_mgp_id) + " and group_practice_rec_id="+String(al_gp_id)
ll_find = tab_1.tabpage_group.dw_group_tv.Find(ls_find, 1, tab_1.tabpage_group.dw_group_tv.RowCount()) 
IF ll_find > 0 THEN
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
	tab_1.tabpage_group.dw_group_tv.Expand(ll_find, 1)
	tab_1.tabpage_group.dw_group_tv.Expand(ll_find, 2)	
	tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find, 3, True)
END IF

Destroy ds_addloc
This.SetRedraw( True)

//ds_addloc = Create datastore
//ds_addloc.DataObject = 'd_group_loc_assoc_by_loc_gp'
//ds_addloc.SetTransObject( sqlca)
//ll_rowcount = ds_addloc.Retrieve(ii_mgp_id,al_gp_id)
//
//IF ll_rowcount = 1 THEN
//	ls_full_name = ds_addloc.Object.v_full_name_full_name[1]
//	IF ls_full_name = '**No Associated Practitioners**' THEN //??
//		ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)
//		tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
//		tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ")
//		tab_1.tabpage_group.dw_group_tv.Sort()
//		tab_1.tabpage_group.dw_group_tv.GroupCalc()
//		tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
//		//find tv-dw then expand
//		ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(al_gp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//		IF ll_found > 0 THEN
//			tab_1.tabpage_group.dw_group_tv.ScrollToRow( ll_found)
//			IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 1) = False THEN
//				tab_1.tabpage_group.dw_group_tv.expand( ll_found, 1)
//				tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,1,True)
//			END IF
//		END IF
//	END IF
//END IF
//Destroy ds_addloc
//
//This.SetRedraw( True)
//--------End Modified------------------------------------------



end subroutine

public subroutine of_scroll_tab2_dw_browse (long as_loc_id);//added by nova 2011-11-15
long ll_find
ll_find = iuo_loc.tab_2.tabpage_browse.dw_browse.find("rec_id="+string(as_loc_id), 1, iuo_loc.tab_2.tabpage_browse.dw_browse.rowcount())
IF ll_find > 0 THEN
	iuo_loc.tab_2.tabpage_browse.dw_browse.selectrow(0,false)
	iuo_loc.tab_2.tabpage_browse.dw_browse.scrolltorow( ll_find)
	iuo_loc.tab_2.tabpage_browse.dw_browse.selectrow(ll_find,true)
end if
end subroutine

public subroutine of_group_link_local (long al_rec_id, long al_loc_id, boolean ab_updated);//V10.5 SK Group Practice - Nova 11.05.2010

Long li_linkrow,ll_found, ll_find, li_link_id
Long ll_rowcount
String ls_sql, ls_err, ls_find
datastore ds_addloc

//--------Begin Modified by alfee 11.11.2010 ---------------------
SetPointer(hourglass!) 

//Update data if not updated
IF NOT ab_updated THEN
	li_linkrow = tab_1.tabpage_group.dw_loc_links.InsertRow(0)
	
	SELECT max(rec_id)	INTO :li_link_id From group_loc_link;
	IF li_link_id < 1 Or IsNull( li_link_id ) THEN li_link_id = 0
	li_link_id++
	al_rec_id = li_link_id //Added by Evan 09.26.2011
	
	tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_rec_id",li_link_id)
	tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_loc_id",al_loc_id)
	tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_group_id",ii_mgp_id)
	tab_1.tabpage_group.dw_loc_links.Update()
END IF

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 09.26.2011
//$<reason> Performance tuning
/*
//Delete the specified group records 
tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
DO WHILE ll_find > 0
	tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
LOOP
*/
//------------------- APPEON END ---------------------

//Retrieve specified group records
ds_addloc = Create datastore
ds_addloc.DataObject = 'd_group_loc_assoc_tv'
ds_addloc.SetTransObject( sqlca)

ls_sql = ds_addloc.GetSQLSelect()
ls_sql += " where group_multi_loc.rec_id = " + String(ii_mgp_id)
ls_sql += " and group_loc_link.rec_id = " + String(al_rec_id) //Added by Evan 09.26.2011
ls_err = ds_addloc.modify('datawindow.table.select = "' +  ls_sql  + '"')
if LenA( ls_err) > 0  then messagebox("Set SQL Select error",ls_sql)
ds_addloc.SetTransObject( sqlca)

gnv_appeondb.of_startqueue( )
tab_1.tabpage_group.dw_loc_links.Retrieve(ii_mgp_id)
ds_addloc.Retrieve()
gnv_appeondb.of_commitqueue( )
ll_rowcount = ds_addloc.RowCount()

//Restore the specified group records
IF ll_rowcount > 0 THEN
	tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
	//---------- APPEON BEGIN ----------
	//$<add> Evan 04.17.2012
	//$<reason> Delete the first no linked record.
	ls_find = "group_multi_loc_rec_id = " + String(ii_mgp_id) + " and group_practice_rec_id = 0"
	ll_find = tab_1.tabpage_group.dw_group_tv.Find(ls_find, 1, tab_1.tabpage_group.dw_group_tv.RowCount()) 
	if ll_find > 0 then tab_1.tabpage_group.dw_group_tv.DeleteRow(ll_find)
	//---------- APPEON END ------------
	ds_addloc.RowsCopy(1 , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)		
	tab_1.tabpage_group.dw_group_tv.Sort()
	tab_1.tabpage_group.dw_group_tv.GroupCalc()
	tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
END IF

//Re-locate to the current group and location
ls_find = "group_multi_loc_rec_id = " + String(ii_mgp_id) + " and group_practice_rec_id = " + String(al_loc_id)
ll_find = tab_1.tabpage_group.dw_group_tv.Find(ls_find, 1, tab_1.tabpage_group.dw_group_tv.RowCount()) 
IF ll_find > 0 THEN
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
	tab_1.tabpage_group.dw_group_tv.Expand(ll_find, 1)
	tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find, 2, True)
END IF

tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
Destroy ds_addloc

//li_linkrow = tab_1.tabpage_group.dw_loc_links.InsertRow(0)
//
//SELECT max(rec_id)	INTO :li_link_id From group_loc_link;
//IF li_link_id < 1 Or IsNull( li_link_id ) THEN li_link_id = 0
//li_link_id++
//
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_rec_id",li_link_id)
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_loc_id",al_loc_id)
//tab_1.tabpage_group.dw_loc_links.SetItem( li_linkrow,"group_loc_link_group_id",ii_mgp_id)
//
//ds_addloc = Create datastore
//ds_addloc.DataObject = 'd_group_loc_assoc_with_mul_id'
//ds_addloc.SetTransObject( sqlca)
//
//gnv_appeondb.of_startqueue( )
//tab_1.tabpage_group.dw_loc_links.Update()
//tab_1.tabpage_group.dw_loc_links.Retrieve(ii_mgp_id)
//ds_addloc.Retrieve(ii_mgp_id)
//gnv_appeondb.of_commitqueue( )
//
//ll_rowcount = ds_addloc.rowcount()
//IF ll_rowcount > 0 THEN
//	ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	DO WHILE ll_found > 0
//		tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_found)
//		ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	LOOP
//END IF
//
//ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)
//tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
//tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ")
//tab_1.tabpage_group.dw_group_tv.Sort()
//tab_1.tabpage_group.dw_group_tv.GroupCalc()
//tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
//
////find tv-dw then expand
//ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//IF ll_found > 0 THEN
//	IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 1) = False THEN
//		tab_1.tabpage_group.dw_group_tv.expand( ll_found, 1)
//	END IF
//	ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ii_mgp_id)+" and group_practice_rec_id="+String(al_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
//	IF ll_found > 0 THEN
//		tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_found)
//		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 2) = False THEN
//			tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,2,True)
//			tab_1.tabpage_group.dw_group_tv.expand( ll_found, 2)
//		END IF
//		tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,2,True)
//	END IF
//END IF
//
//Destroy ds_addloc
//--------End Modified --------------------------------------------------




end subroutine

public function integer of_get_accesslevel ();//====================================================================
//$<Function>: of_set_security
//$<Arguments>:
//$<Return>:  integer
//$<Description>: get  user access right
//$<Author>: (Appeon) long.zhang 11.28.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
return ii_level
end function

public function integer of_setresize (boolean ab_switch);//////////////////////////////////////////////////////////////////////////////
//	Public Function:  of_SetResize
//	Arguments:		ab_switch   starts/stops the window resize service
//	Returns:			Integer 		1 = success,  0 = no action necessary, -1 error
//	Description:		Starts or stops the window resize service
//////////////////////////////////////////////////////////////////////////////
//	Rev. History:	Version
//						5.0   Initial version
//						8.0   Modified to initially set window dimensions based on the class definition
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2001 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
//(Appeon)Harry 08.11.2014 - for BugH070901
Integer	li_rc, li_v, li_vars
Integer li_origwidth, li_origheight

// Check arguments
If IsNull (ab_switch) Then
	Return -1
End If

If ab_switch Then
	If IsNull(inv_resize) Or Not IsValid (inv_resize) Then
		//Start Change Code By Jervis 01.09.2008
		//inv_resize = Create n_cst_resize
		//Support reisze when tab.CreateOnDemand = true
		inv_resize = Create n_cst_resize_prac
		//End Change by Jervis
		
		inv_resize.of_SetOrigSize ( this.width, this.height )
	
		li_rc = 1
	End If
Else
	If IsValid (inv_resize) Then
		Destroy inv_resize
		li_rc = 1
	End If
End If

Return li_rc


end function

public subroutine of_zoom ();//Start Code Change ----07.17.2017 #V154 maha - added for font increase
tab_1.tabpage_assoc.dw_assoc.Modify("DataWindow.Zoom=" + string(gi_zoom)) 
tab_1.tabpage_group.dw_loc_links.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_group.dw_mg_detail.Modify("DataWindow.Zoom=" + string(gi_zoom))  
tab_1.tabpage_group.dw_mg_browse.Modify("DataWindow.Zoom=" + string(gi_zoom))  


end subroutine

event open;call super::open;
IF gb_contract_version THEN //LeiWei 09.13.2006
	Title = "Locations"
	tab_1.tabpage_loc.text = "Locations"
	tab_1.tabpage_group.text = "Groups"
END IF

iuo_loc = tab_1.tabpage_loc.uo_loc
inv_ent = create nv_entity_functions //Start Code Change ----07.26.2010 #V10 maha

//Start Code Change ----12.14.2010 #V11 maha 
if of_get_app_setting("set_site","I") = 0 then
	tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.visible = false
end if
//End Code Change ----12.14.2010

//Start Code Change ----01.06.2011 #V11 maha - datastore for data screen modifcations
ids_datastore =  create n_ds
ids_datastore.dataobject = "d_gp_sys_fields"
ids_datastore.settransobject(sqlca)
ids_datastore.retrieve()
//End Code Change ----01.06.2011

//Start Code Change ----12.13.2016 #V153 maha - added for documents
ii_doc_level = w_mdi.of_security_access(7832)


end event

on w_group_practice.create
int iCurrent
call super::create
this.cb_copy=create cb_copy
this.cb_1=create cb_1
this.cb_selecttab2=create cb_selecttab2
this.dw_facility_add=create dw_facility_add
this.dw_entity_add=create dw_entity_add
this.cb_find_gp=create cb_find_gp
this.cb_prior=create cb_prior
this.cb_next=create cb_next
this.cb_add_gp=create cb_add_gp
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.tab_1=create tab_1
this.cb_close=create cb_close
this.cb_viewdoc=create cb_viewdoc
this.cb_addfor=create cb_addfor
this.st_buttons=create st_buttons
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_copy
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_selecttab2
this.Control[iCurrent+4]=this.dw_facility_add
this.Control[iCurrent+5]=this.dw_entity_add
this.Control[iCurrent+6]=this.cb_find_gp
this.Control[iCurrent+7]=this.cb_prior
this.Control[iCurrent+8]=this.cb_next
this.Control[iCurrent+9]=this.cb_add_gp
this.Control[iCurrent+10]=this.cb_delete
this.Control[iCurrent+11]=this.cb_save
this.Control[iCurrent+12]=this.tab_1
this.Control[iCurrent+13]=this.cb_close
this.Control[iCurrent+14]=this.cb_viewdoc
this.Control[iCurrent+15]=this.cb_addfor
this.Control[iCurrent+16]=this.st_buttons
end on

on w_group_practice.destroy
call super::destroy
destroy(this.cb_copy)
destroy(this.cb_1)
destroy(this.cb_selecttab2)
destroy(this.dw_facility_add)
destroy(this.dw_entity_add)
destroy(this.cb_find_gp)
destroy(this.cb_prior)
destroy(this.cb_next)
destroy(this.cb_add_gp)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.tab_1)
destroy(this.cb_close)
destroy(this.cb_viewdoc)
destroy(this.cb_addfor)
destroy(this.st_buttons)
end on

event closequery;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  closequery
//
//	Description:
//	Search for unsaved datawindows prompting the user if any
//	pending updates are found.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 6.0	Enhanced control on what objects are to be updated.
// 6.0.01 Make sure the window is not minimized and behind other windows.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Constant Integer	ALLOW_CLOSE = 0
Constant Integer	PREVENT_CLOSE = 1

Integer	li_msg
Integer	li_rc
String	ls_msgparms[]
Powerobject lpo_updatearray[]

// Check if the CloseQuery process has been disabled
If ib_disableclosequery Then
	Return ALLOW_CLOSE
End If

// Call event to perform any pre-CloseQuery processing
If This.Event pfc_preclose ( ) <> 1 Then
	// Prevent the window from closing
	Return PREVENT_CLOSE 
End If

// Prevent validation error messages from appearing while the window is closing
// and allow others to check if the  CloseQuery process is in progress
ib_closestatus = True

// Determine the objects for which an update will be attempted.
// For the CloseQuery, the order sequence is as follows: 
//		1) Specified permananent sequence (thru of_SetUpdateObjects(...)).
//		2) None was specified, so use default window control array.
If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = This.Control		
End If

// Check for any pending updates
li_rc = of_UpdateChecks(lpo_updatearray)
If li_rc = 0 Then
	// Updates are NOT pending, allow the window to be closed.
	ib_closestatus = False
	Return ALLOW_CLOSE
ElseIf li_rc < 0 Then
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If
	this.BringToTop = True

	// There are Updates pending, but at least one data entry error was found.
	// Give the user an opportunity to close the window without saving changes
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_failsvalidation', &
					 ls_msgparms, gnv_app.iapp_object.DisplayName)
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_failsvalidation", &
					gnv_app.iapp_object.DisplayName, &
					"The information entered does not pass validation and "  + &
					"must be corrected before changes can be saved.~r~n~r~n" + &
					"Close without saving changes?", &
					exclamation!, YesNo!, 2)
	End If
	If li_msg = 1 Then
		ib_closestatus = False
		Return ALLOW_CLOSE
	End If
Else
	// Make sure the window is not minimized and behind other windows.
	If this.WindowState = Minimized! Then
		this.WindowState = Normal!
	End If	
	this.BringToTop = True
	
	// Changes are pending, prompt the user to determine if they should be saved
	If IsValid(gnv_app.inv_error) Then
		li_msg = gnv_app.inv_error.of_Message('pfc_closequery_savechanges',  &
					ls_msgparms, gnv_app.iapp_object.DisplayName)		
	Else
		li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
					gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
	End If
	Choose Case li_msg
		Case 1
			// YES - Update
			// If the update fails, prevent the window from closing
			//Start Code Change ----10.02.2009 #V92 maha added trap to prevent close
			//tab_1.tabpage_gp.cb_save.Event Clicked()		//Add by Scofield 2007-09-25
			if cb_save.Event Clicked() < 1 then
				Return PREVENT_CLOSE
			end if
			//End Code Change---10.02.2009
			If This.Event pfc_save() >= 1 Then
				// Successful update, allow the window to be closed
				ib_closestatus = False
				Return ALLOW_CLOSE
			End If
		Case 2
			// NO - Allow the window to be closed without saving changes
			ib_closestatus = False
			Return ALLOW_CLOSE
		Case 3
			// CANCEL -  Prevent the window from closing
	End Choose
End If

// Prevent the window from closing
ib_closestatus = False
Return PREVENT_CLOSE
end event

event close;call super::close;destroy inv_ent //Start Code Change ----07.26.2010 #V10 maha
destroy ids_datastore //Start Code Change ----01.06.2011 #V11 maha
end event

event pfc_preopen;call super::pfc_preopen;//====================================================================
//$<Event>: pfc_preopen
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: 
//$<Author>: (Appeon) long.zhang 04.03.2014 (V14.2 Group Location Screen Resize)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer li_x, li_y, li_width, li_height
Long ll_i
String ls_scale
powerobject lo_powerobjects[]

this.of_setresize( true)
this.inv_resize.of_setorigsize( this.workspacewidth(),this.workspaceheight())

if appeongetclienttype() = "WEB" and gb_autoresize = false then return
ls_scale = this.inv_resize.scale

this.inv_resize.of_register( this.tab_1,ls_scale)

for ll_i = 1 to UpperBound(this.tab_1.tabpage_group.control)//Groups
	if this.tab_1.tabpage_group.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_group.control[ll_i],ls_scale)
next

//Locations /Addresses
this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc,ls_scale)
this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2,ls_scale)

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.control)	//location Search
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.control[ll_i].classname() = "cb_search" then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.control[ll_i],ls_scale)
end for

//this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_detail.dw_detail,this.inv_resize.SCALERIGHT)//location detail
this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_detail.dw_detail, ls_scale) //(Appeon)Harry 08.12.2014 - BugS072104

//location addtional data
this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data,ls_scale)

this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.dw_select_section,ls_scale)

this.inv_resize.of_register(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1,ls_scale)

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_browse.control)
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_browse.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_browse.control[ll_i],ls_scale)
end for

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_detail.control)
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_detail.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
		this.inv_resize.of_register(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_data.uo_data.tab_1.tabpage_detail.control[ll_i],ls_scale)
end for

//Associated Practitioners
For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_ass_prac.control)
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_ass_prac.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_ass_prac.control[ll_i],ls_scale)
end for

//Documents, Added by Appeon long.zhang 02.21.2017 (BugL022105)
For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_docs.control)
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_docs.control[ll_i],ls_scale)
end for

//Site Survey
this.inv_resize.of_register(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey,ls_scale)
this.inv_resize.of_register(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review,ls_scale)

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_browse.control)
	if this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_browse.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_browse.control[ll_i],ls_scale)
end For

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.control)
	if  this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.control[ll_i],ls_scale)
end For

For ll_i = 1 to UpperBound(this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.control)
	if  this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register( this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.control[ll_i],ls_scale)
end For

//Associations
For ll_i = 1 to UpperBound(this.tab_1.tabpage_assoc.control)
	if  this.tab_1.tabpage_assoc.control[ll_i].typeof() = CommandButton! then Continue //(Appeon)Harry 08.12.2014 - BugH070901
	this.inv_resize.of_register(this.tab_1.tabpage_assoc.control[ll_i],ls_scale)
end for
end event

event resize;//(Appeon)Harry 08.12.2014 - for BugH070901,BugS072103
Long ll_dw_mg_detail_currh, ll_interval, ll_dw_mg_detail_orgh
//if newwidth < 4539 or newheight < 2616 then return 0
if newwidth < 4000 or newheight < 2000 then return 0

this.setredraw(false)
call super:: resize

//Keep all buttons the original size
tab_1.tabpage_group.cb_addgroup.x = tab_1.tabpage_group.st_1.x + 615
tab_1.tabpage_group.cb_addgroup.y = tab_1.tabpage_group.st_1.y + 4

tab_1.tabpage_group.cb_delgroup.x = tab_1.tabpage_group.cb_addgroup.x + tab_1.tabpage_group.cb_addgroup.width + 20 
tab_1.tabpage_group.cb_delgroup.y = tab_1.tabpage_group.cb_addgroup.y

 //Start Code Change ----05.18.2015 #V15 maha - added facility links button
tab_1.tabpage_group.cb_fac_links.y = tab_1.tabpage_group.cb_addgroup.y
tab_1.tabpage_group.cb_fac_links.x =  tab_1.tabpage_group.cb_delgroup.x + tab_1.tabpage_group.cb_delgroup.width + 20 
 //End Code Change ----05.18.2015

//tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse
this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_clear.x = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cbx_valid.x
this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_clear.y = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cbx_valid.y + this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cbx_valid.height + 4

this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_search.x = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_clear.x
this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_search.y = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_clear.y + this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_clear.height + 40

this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_sort.x = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_search.x
this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_sort.y = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_search.y + this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_search.height + 40

this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_1.x = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.dw_browse.x + this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.dw_browse.width - this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_1.width
this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_1.y = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.dw_browse.y -  this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.cb_1.height - 24

this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.cb_enlarge.x = this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.rb_summary.x + this.tab_1.tabpage_loc.uo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_questions.rb_summary.width + 88

//The Group tab Group detail DW does not need have height increased
//ll_dw_mg_detail_currh = tab_1.tabpage_group.dw_mg_detail.height 
ll_dw_mg_detail_orgh = 732

//ll_interval = ll_dw_mg_detail_currh - ll_dw_mg_detail_orgh
tab_1.tabpage_group.dw_mg_detail.height = ll_dw_mg_detail_orgh
//	tab_1.tabpage_group.st_3.y = tab_1.tabpage_group.st_3.y - ll_interval
//	tab_1.tabpage_group.cb_addloc.y = tab_1.tabpage_group.cb_addloc.y - ll_interval
//	tab_1.tabpage_group.cb_del_loc.y = tab_1.tabpage_group.cb_del_loc.y - ll_interval
//	tab_1.tabpage_group.cb_link_loc.y = tab_1.tabpage_group.cb_link_loc.y - ll_interval
//	tab_1.tabpage_group.dw_loc_links.y = tab_1.tabpage_group.dw_loc_links.y - ll_interval
//	tab_1.tabpage_group.dw_loc_links.height = tab_1.tabpage_group.dw_loc_links.height + ll_interval
tab_1.tabpage_group.st_3.y =tab_1.tabpage_group.dw_mg_detail.y + ll_dw_mg_detail_orgh + 32

tab_1.tabpage_group.cb_addloc.x = tab_1.tabpage_group.st_3.x + 615
tab_1.tabpage_group.cb_addloc.y = tab_1.tabpage_group.st_3.y + 4  

tab_1.tabpage_group.cb_del_loc.x = tab_1.tabpage_group.cb_addloc.x + tab_1.tabpage_group.cb_addloc.width + 20 
tab_1.tabpage_group.cb_del_loc.y = tab_1.tabpage_group.cb_addloc.y

tab_1.tabpage_group.cb_link_loc.x = tab_1.tabpage_group.cb_del_loc.x + tab_1.tabpage_group.cb_del_loc.width + 20 
tab_1.tabpage_group.cb_link_loc.y = tab_1.tabpage_group.cb_del_loc.y

tab_1.tabpage_group.dw_loc_links.y =tab_1.tabpage_group.st_3.y + tab_1.tabpage_group.st_3.height + 12
tab_1.tabpage_group.dw_loc_links.height = tab_1.tabpage_group.dw_group_tv.y + tab_1.tabpage_group.dw_group_tv.height - tab_1.tabpage_group.dw_loc_links.y

this.setredraw(true)


end event

type cb_copy from commandbutton within w_group_practice
integer x = 2619
integer y = 24
integer width = 347
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Copy"
end type

event clicked;//Start Code Change ----07.24.2017 #V154 maha - added
tab_1.tabpage_loc.uo_loc.of_copy_location( )
end event

type cb_1 from commandbutton within w_group_practice
integer x = 3771
integer y = 24
integer width = 347
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Notes"
end type

event clicked;//Start Code Change ----10.31.2013 #V14 maha - added button

if tab_1.selectedtab = 1 then
	openwithparm(w_entity_note, string( ii_mgp_id ) + "*GRP")
else
	openwithparm(w_entity_note, string( tab_1.tabpage_loc.uo_loc.il_group_id ) + "*LOC")
end if
end event

type cb_selecttab2 from commandbutton within w_group_practice
boolean visible = false
integer x = 919
integer y = 20
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "don~'t delete"
end type

event clicked;iuo_loc.tab_2.selecttab(2)
end event

type dw_facility_add from datawindow within w_group_practice
boolean visible = false
integer x = 1961
integer y = 2584
integer width = 105
integer height = 72
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_facility_setup"
boolean resizable = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone
String	ls_Phone,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event constructor;this.settransobject(sqlca)

end event

event doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-29 By: Scofield
//$<Reason> Popup a dialog to input the phone
String	ls_Phone,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event updateend;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.24.2006 By: LeiWei
//$<reason> Fix a defect.

gnv_app.inv_dwcache.of_unRegister('dddw_contracted_entity')
gnv_app.inv_dwcache.of_Register('dddw_contracted_entity', 'dddw_contracted_entity', SQLCA, true)

//---------------------------- APPEON END ----------------------------

end event

type dw_entity_add from datawindow within w_group_practice
boolean visible = false
integer x = 1669
integer y = 2584
integer width = 128
integer height = 76
integer taborder = 70
string dataobject = "d_entity_lookup"
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_find_gp from commandbutton within w_group_practice
boolean visible = false
integer x = 914
integer y = 24
integer width = 347
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;long ll_addr
long ll_group
integer res
datawindow dw_pop

if iuo_loc.tab_2.tabpage_detail.dw_detail.rowcount() < 1 then return

 
open(w_practice_find)

ll_addr = message.doubleparm

if isnull(ll_addr) then return
if ll_addr = 0 then return
dw_pop = tab_1.tabpage_loc.dw_pop  //Start Code Change ----06.29.2010 #V10 maha
 dw_pop.settransobject(sqlca)
 dw_pop.retrieve(ll_addr)

ll_group = iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"rec_id")

if not(isnull(ll_group)) then 
	res = messagebox("Repopulating existing Group Practice Information","This Group Practice already has an address.~n~r If you continue, you will have to update all practitioners connected to this group.~n~r Do you want to continue repopulating the address information?",question!,Yesno!,2)
end if

if res = 2 then return
//	return
//else
//	dw_pop.rowscopy(1, 1,primary!,iuo_loc.tab_2.tabpage_detail.dw_detail, 1000000, primary! )
//end if


iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"street", dw_pop.getitemstring(1,"street"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"street_2",  dw_pop.getitemstring(1,"street_2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"city", dw_pop.getitemstring(1,"city"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"state",dw_pop.getitemnumber(1,"state"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"zip",dw_pop.getitemstring(1,"zip"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"county",dw_pop.getitemnumber(1,"county"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"country",dw_pop.getitemnumber(1,"country"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"phone",dw_pop.getitemstring(1,"phone"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"fax",dw_pop.getitemstring(1,"fax"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"e_mail_address",dw_pop.getitemstring(1,"e_mail_address"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"web_address",dw_pop.getitemstring(1,"web_address"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"contact_person",dw_pop.getitemstring(1,"contact_person"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"business_mgr",dw_pop.getitemstring(1,"business_mgr"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"office_mgr",dw_pop.getitemstring(1,"office_mgr"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"tax_id",dw_pop.getitemstring(1,"tax_id"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"routine_visit_appt",dw_pop.getitemstring(1,"routine_visit_appt"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"urgent_visit_appt",dw_pop.getitemstring(1,"urgent_visit_appt"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"emergency_visit_appt",dw_pop.getitemstring(1,"emergency_visit_appt"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"handicapped_access",dw_pop.getitemnumber(1,"handicapped_access"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"public_transportation",dw_pop.getitemnumber(1,"public_transportation"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"non_emergency_appt",dw_pop.getitemstring(1,"non_emergency_appt"))

iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_from",dw_pop.getitemstring(1,"mon_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_to",dw_pop.getitemstring(1,"mon_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_from",dw_pop.getitemstring(1,"tue_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_to",dw_pop.getitemstring(1,"tue_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_from",dw_pop.getitemstring(1,"wed_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_to",dw_pop.getitemstring(1,"wed_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_from",dw_pop.getitemstring(1,"thu_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_to",dw_pop.getitemstring(1,"thu_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_from",dw_pop.getitemstring(1,"fri_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_to",dw_pop.getitemstring(1,"fri_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_from",dw_pop.getitemstring(1,"sat_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_to",dw_pop.getitemstring(1,"sat_to"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_from",dw_pop.getitemstring(1,"sun_from"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_to",dw_pop.getitemstring(1,"sun_to"))

iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_from2",dw_pop.getitemstring(1,"mon_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"mon_to2",dw_pop.getitemstring(1,"mon_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_from2",dw_pop.getitemstring(1,"tue_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"tue_to2",dw_pop.getitemstring(1,"tue_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_from2",dw_pop.getitemstring(1,"wed_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"wed_to2",dw_pop.getitemstring(1,"wed_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_from2",dw_pop.getitemstring(1,"thu_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"thu_to2",dw_pop.getitemstring(1,"thu_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_from2",dw_pop.getitemstring(1,"fri_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"fri_to2",dw_pop.getitemstring(1,"fri_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_from2",dw_pop.getitemstring(1,"sat_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sat_to2",dw_pop.getitemstring(1,"sat_to2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_from2",dw_pop.getitemstring(1,"sun_from2"))
iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"sun_to2",dw_pop.getitemstring(1,"sun_to2"))












end event

type cb_prior from commandbutton within w_group_practice
boolean visible = false
integer x = 1271
integer y = 24
integer width = 215
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<-Prior"
end type

event clicked;//Start Code Change ---- 06.08.2006 #525 maha
of_next_record("P")
end event

type cb_next from commandbutton within w_group_practice
boolean visible = false
integer x = 1486
integer y = 24
integer width = 201
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Next->"
end type

event clicked;//Start Code Change ---- 06.08.2006 #526 maha
of_next_record("N")
end event

type cb_add_gp from commandbutton within w_group_practice
integer x = 2267
integer y = 24
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;integer li_newrow

if tab_1.selectedtab = 1 then //Start Code Change ----07.07.2010 #V10 maha - moved group add to here
//	of_linksave()	
//	
//	tab_1.tabpage_group.dw_mg_detail.Reset()
//	tab_1.tabpage_group.dw_mg_detail.insertrow(1)
//	tab_1.tabpage_group.dw_mg_detail.SetFocus()
//	tab_1.tabpage_group.dw_mg_detail.SetColumn( "gp_name" )
//
//	tab_1.tabpage_group.dw_loc_links.Reset( )
elseif  tab_1.selectedtab = 2 then
	IF iuo_loc.tab_2.SelectedTab = 6 THEN //site  //Start Code Change ----10.03.2016 #V152 maha - changed from 5
		//--------Begin Modified by  Nova 09.14.2010------------------------
		//iuo_loc.tab_2.tabpage_survey.uo_survey.of_new_record ( il_group_id )
		iuo_loc.tab_2.tabpage_survey.uo_survey.of_new_record (iuo_loc.il_group_id )
		//--------End Modified --------------------------------------------
	
	elseif iuo_loc.tab_2.SelectedTab = 3 THEN //other data
		iuo_loc.tab_2.tabpage_data.uo_data.of_add()
	elseif iuo_loc.tab_2.selectedtab = 4 then //documents  //Start Code Change ----10.03.2016 #V152 maha
		iuo_loc.of_add_document( )
	elseif iuo_loc.tab_2.selectedtab = 5 then //assoc pracs  //Start Code Change ----10.03.2016 #V152 maha
		//not coded
	ELSE
		iuo_loc.tab_2.selecttab(2) //detail
		
		if iuo_loc.tab_2.tabpage_detail.dw_detail.rowcount() > 0 then //maha 061004
			if IsNull(iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"state")) then
				MessageBox("Data Incomplete","Please add data for state.")
				return
			end if
		end if
		
		cb_save.TriggerEvent(Clicked!)
		iuo_loc.tab_2.tabpage_detail.dw_detail.reset()
		li_newrow = iuo_loc.tab_2.tabpage_detail.dw_detail.insertrow(1)
		//iuo_loc.cbx_update.visible = false // removed maha 060904
		cb_find_gp.visible = true
		iuo_loc.tab_2.tabpage_detail.dw_detail.SetFocus( )
		
		iuo_loc.tab_2.tabpage_browse.dw_browse.selectrow(0,false)	//Start Code Change ----04.21.2008 #V8 maha - adding code so a new record can be deleted.
	END IF
end if
end event

type cb_delete from commandbutton within w_group_practice
integer x = 3406
integer y = 24
integer width = 347
integer height = 84
integer taborder = 21
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;boolean 	lb_match
integer 	res
integer li_delete
integer 	li_CurRow
long 		loc_id
long 		pcnt
long 		loc_cnt
long 		ll_dtl_id

if tab_1.selectedtab = 2 then //maha061603
	if iuo_loc.tab_2.selectedtab = 6  then //survey    //Start Code Change ----10.03.2016 #V152 maha
		iuo_loc.tab_2.tabpage_survey.uo_survey.of_delete_survey()
	elseif iuo_loc.tab_2.selectedtab = 3 then //group data
		iuo_loc.tab_2.tabpage_data.uo_data.of_delete()
	elseif iuo_loc.tab_2.selectedtab = 4 then //documents  //Start Code Change ----10.03.2016 #V152 maha
		iuo_loc.of_delete_document( iuo_loc.tab_2.tabpage_docs.dw_docs.getrow() )		
	elseif iuo_loc.tab_2.selectedtab = 5 then //assoc pracs  //Start Code Change ----10.03.2016 #V152 maha
		//not coded
	else
		if iuo_loc.tab_2.tabpage_browse.rb_l_p.checked = true then
			messagebox("Delete Practice Location","You can only delete from the locations only list.") 
			return
		end if
		
		li_CurRow = iuo_loc.tab_2.tabpage_browse.dw_browse.getrow()
		if li_CurRow <= 0 then return			//Added By Scofield on 2008-03-17
		
		loc_id = iuo_loc.tab_2.tabpage_browse.dw_browse.getitemnumber(li_CurRow,"rec_id")
		//Start Code Change ----04.21.2008 #V8 maha
		
		//----------------APPEON BEGIN--------------------------
		//<$>Modified: long.zhang 04.16.2012
		//<$>Reason:Fixed a detect  Bug 3017
//		if  iuo_loc.tab_2.tabpage_detail.dw_detail.rowcount( )=0 then return//Added by Nova on 02.09.2009
//		ll_dtl_id = 	iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"rec_id")

		if iuo_loc.ib_tabpage_detail_created then
				if  iuo_loc.tab_2.tabpage_detail.dw_detail.rowcount( )=0 then return//Added by Nova on 02.09.2009
				ll_dtl_id = 	iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"rec_id")
		else
			ll_dtl_id = loc_id
		end if
		//----------------APPEON END-----------------------------
		
		if isnull(ll_dtl_id) then ll_dtl_id=-1 //Added by Nova on 02.09.2009
		if loc_id <> ll_dtl_id then 
			lb_match = false
			loc_id = ll_dtl_id
		else //Added by Nova on 02.09.2009
			lb_match = true
		end if	
		
		//End Code Change---04.21.2008
		select count(gp_id) into :pcnt from pd_address where gp_id = :loc_id;
//Start Code Change ----06.01.210 #V8 maha - added delete address functionality
		select count(loc_id) into :loc_cnt from ctx_loc where loc_id = :loc_id;
		if loc_cnt > 0 then //trap for connected contract records
			messagebox("Delete","There are " + string(loc_cnt) + " Contract location record(s) linked to this Practice Location.  They must be deleted in Contracts before this record can be removed.")
			return
		end if
		//Start Code Change ---- 04.13.2006 #393 maha corrected > sign and added delete of other data tables 
//		if pcnt > 0 then
//			res = messagebox("Delete Practice Location","This location has " + string(pcnt) + " Address record(s) connected to it.  Are you sure you want to delete the selected Practice location and clear the practice links from the addresses?",question!,yesno!,2)
//		else
//			res = messagebox("Delete Practice Location","Are you sure you want to delete the selected Practice location?",question!,yesno!,2)
//		end if
//		
//		if res = 2 then return
		
		openwithparm(w_delete_location_message,pcnt)
		li_delete = message.doubleparm
		
		if li_delete = 2 then return //cancel
//End Code Change---06.01.2010		
		
		//Start Code Change ----04.21.2008 #V8 maha - code added for delete of a new record not having been retrieved.
		if lb_match = true then
			iuo_loc.tab_2.tabpage_browse.dw_browse.of_SetUpdateAble( true )
			iuo_loc.tab_2.tabpage_browse.dw_browse.deleterow(li_CurRow)
			iuo_loc.tab_2.tabpage_detail.dw_detail.reset()
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$< Add  > 2007-08-10 By: Scofield
			//$<Reason> Fix a defect.
			li_CurRow = iuo_loc.tab_2.tabpage_browse.dw_browse.getrow()
			if li_CurRow > 0 and li_CurRow <= iuo_loc.tab_2.tabpage_browse.dw_browse.RowCount() then
				iuo_loc.tab_2.tabpage_browse.dw_browse.Trigger Event RowFocusChanged(li_CurRow)
			end if
			//---------------------------- APPEON END ----------------------------
			res = iuo_loc.tab_2.tabpage_browse.dw_browse.update()
		else //maha new 04.21.08
			iuo_loc.tab_2.tabpage_detail.dw_detail.deleterow(1)
			res = iuo_loc.tab_2.tabpage_detail.dw_detail.update()
		end if
		
		if res > 0 then //maha mod 010504
			gnv_appeondb.of_startqueue( )

//Start Code Change ----06.01.210 #V8 maha - added delete address functionality	
			if li_delete = 1 then
				Update pd_address set gp_id = null where gp_id = :loc_id;
				Update net_dev_action_items set gp_id = 0 where gp_id = :loc_id;  //Start Code Change ----04.24.2014 #V14.2 maha
			elseif li_delete = 3 then
				Delete from pd_address where gp_id = :loc_id;
				Delete from  net_dev_action_items  where gp_id = :loc_id; //Start Code Change ----04.24.2014 #V14.2 maha
			end if
//End Code Change---06.01.2010
			//-----Begin Modified by alfee 01.28.2010 ---------------
			delete from gp_insurance where gp_id = :loc_id;
			delete from gp_language where gp_id = :loc_id;
			delete from gp_other_ids where gp_id = :loc_id;
			delete from gp_partner_covering where gp_id = :loc_id;
			delete from gp_questions where gp_id = :loc_id;
			delete from gp_plans where gp_id = :loc_id;
			delete from group_loc_link where group_id = :loc_id;
			/* delete from gp_insurance where rec_id = :loc_id;
			delete from gp_language where rec_id = :loc_id;
			delete from gp_other_ids where rec_id = :loc_id;
			delete from gp_partner_covering where rec_id = :loc_id;
			delete from gp_questions where rec_id = :loc_id;
			delete from gp_plan where rec_id = :loc_id;
			delete from group_loc_link where loc_id = :loc_id; */
			//-----End Modified ------------------------------------
			//maha 041306 need some trapping for contracts connected to groups

			commit using sqlca;
			
			gnv_appeondb.of_commitqueue( )
			//iuo_loc.tab_2.tabpage_browse.dw_browse.deleterow(g)
		end if
		//End Code Change---04.13.2006
	end if
//Start Code Change ----07.07.2010 #V10 maha- moved group code from separate button
elseif tab_1.selectedtab = 1 then
//	integer	li_Rtn
//	long		ll_Row,ll_CurRow,ll_Cycle,ll_RowCnt
//	Decimal	ldc_RecID
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$< Add  > 2008-09-24 By: Scofield
//	//$<Reason> Delete Unsaved row.
//	
//	if tab_1.tabpage_group.dw_mg_detail.Visible then
//		ll_Row = tab_1.tabpage_group.dw_mg_detail.GetRow()
//		if ll_Row <= 0 or ll_Row > tab_1.tabpage_group.dw_mg_detail.RowCount() then return
//		
//		ldc_RecID = tab_1.tabpage_group.dw_mg_detail.GetItemDecimal(ll_Row,"rec_id")
//		if IsNull(ldc_RecID) then
//			li_Rtn = MessageBox("Confirm Delete","Are you sure you want to delete this Group?",question!,yesno!,2)
//			if li_Rtn = 1 then
//				tab_1.tabpage_group.dw_mg_detail.DeleteRow(0)
//				
//				
//				ll_Row = tab_1.tabpage_group.dw_mg_browse.GetRow()
//				if ll_Row > 0 or ll_Row <= tab_1.tabpage_group.dw_mg_browse.RowCount() then
//					tab_1.tabpage_group.dw_mg_browse.Trigger Event RowFocusChanged(ll_Row)
//				end if
//			end if
//			
//			Return
//		end if
//	end if
//	//---------------------------- APPEON END ----------------------------
//	
//	ll_Row = tab_1.tabpage_group.dw_mg_browse.GetRow()
//	if ll_Row <= 0 or ll_Row > tab_1.tabpage_group.dw_mg_browse.RowCount() then return
//	
//	li_Rtn = Messagebox("Confirm Delete","Are you sure you want to delete the selected Group and all its links?(will not effect practice locations)",question!,yesno!,2)
//	
//	if li_Rtn <> 1 then return 
//	
//	//-------------Begin Added by Alfee 07.05.2010 --------------------
//	if gb_contract_module then
//		ldc_RecID = tab_1.tabpage_group.dw_mg_browse.GetItemDecimal(ll_Row,"rec_id")	
//		select count(distinct ctx_id) into :ll_RowCnt from ctx_loc where parent_comp_id = :ldc_RecID;
//		if ll_RowCnt > 0 and ldc_RecID <> 0 and not isnull(ldc_RecID) then 
//			Messagebox("Delete","There are " + string(ll_RowCnt) + " Contract(s) linked to this Parent Organization. These contract locations must be deleted in Contracts before this record can be removed.")		
//			return	
//		end if
//	end if
//	//-------------End Added -------------------------------------------
//
//	tab_1.tabpage_group.dw_loc_links.SetFocus()
//	ll_RowCnt = tab_1.tabpage_group.dw_loc_links.RowCount()
//	for ll_Cycle = 1 to ll_RowCnt
//		tab_1.tabpage_group.dw_loc_links.deleterow(0)	
//	next
//	ib_delete = True
//	//---------------------------- APPEON END ----------------------------
//	
//	tab_1.tabpage_group.dw_loc_links.Update()		//Added by Scofield on 2008-01-03
//	tab_1.tabpage_group.dw_mg_browse.deleterow(0)
//	tab_1.tabpage_group.dw_mg_browse.Update()		//Added by Scofield on 2008-01-03
//	commit using sqlca;
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<Modify> 2007-08-10 By: Scofield
//	//$<Reason> Refresh the detail area's data
//	ll_CurRow = tab_1.tabpage_group.dw_mg_browse.GetRow()
//	if ll_CurRow > 0 and ll_CurRow <= tab_1.tabpage_group.dw_mg_browse.RowCount() then
//		tab_1.tabpage_group.dw_mg_browse.ScrollToRow(ll_CurRow)
//		tab_1.tabpage_group.dw_mg_browse.SelectRow( 0, False )
//		tab_1.tabpage_group.dw_mg_browse.SelectRow( ll_CurRow, true )
//		ii_mgp_id = tab_1.tabpage_group.dw_mg_browse.getitemnumber(ll_CurRow, "rec_id") 
//		tab_1.tabpage_group.dw_mg_browse.Trigger Event RowFocusChanged(ll_CurRow)
//	else
//		tab_1.tabpage_group.dw_mg_detail.Reset()
//	end if
end if

end event

type cb_save from commandbutton within w_group_practice
integer x = 1911
integer y = 24
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;long li_gp_id
long ll_recid
long li_linkrow,li_link_id,ll_found//,li_loc_id
if tab_1.selectedtab = 1 then
	of_linksave( )
end if
if not isvalid(iuo_loc) then return

//---------Begin Commented by (Appeon)Harry 05.31.2013 for V141 ISG-CLX--------
//if iuo_loc.tab_2.tabpage_detail.dw_detail.rowcount() > 0 then //maha 061004
//	if isnull(iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber(1,"state")) then
//		messagebox("Data Incomplete","Please add data for state.")
//		return
//	end if
//end if
//---------End Commented ------------------------------------------------------
if iuo_loc.tab_2.tabpage_detail.dw_detail.getitemstatus(1,0,primary!) = newmodified! then
	
	select max(rec_id) //maha moved here 103102
	into :li_gp_id
	from group_practice;
	
	if li_gp_id < 1 or isnull(li_gp_id) then li_gp_id = 0
	
	li_gp_id++
	
	iuo_loc.tab_2.tabpage_detail.dw_detail.setitem(1,"rec_id",li_gp_id)
	//iuo_loc.tab_2.tabpage_detail.dw_detail.update() //maha020303
	//commit using sqlca;
	w_group_practice.Event pfc_Save()
	//il_group_id = li_gp_id  //maha moved here 103102
	iuo_loc.il_group_id = li_gp_id //alfee 11.13.2010
	
	//--------Begin Added by Nova 11.04.2010------------------------
	//Commented by alfee 11.11.2010
	//if ib_add_loc_and_link=true then
	//	of_group_link_local(il_group_id)
	//	ib_add_loc_and_link=false
	//end if
	//--------End Added --------------------------------------------
	
elseif iuo_loc.tab_2.tabpage_detail.dw_detail.getitemstatus(1,0,primary!) = datamodified! then //maha111202
	//iuo_loc.tab_2.tabpage_detail.dw_detail.update()
	//commit using sqlca;
	//Start Code Change ----10.311.2016 #V153 maha
	gs_pass_ids lst_ids
	
	//Start Code Change ----08.10.2017 #V154 maha - to correct possible integer error
	//lst_ids.facility_id = iuo_loc.il_group_id
	lst_ids.l_ids[1] = iuo_loc.il_group_id
	//End Code Change ----08.10.2017
	
	if iuo_loc.tab_2.tabpage_detail.dw_detail.getitemstatus( 1, "active_status", primary!) = datamodified! and iuo_loc.tab_2.tabpage_detail.dw_detail.getitemnumber( 1, "active_status") = 0 then
		lst_ids.l_app_id = 1
	else
		lst_ids.l_app_id = 0
	end if
	//End Code Change ----10.311.2016
	
	w_group_practice.Event pfc_Save()	
	//if iuo_loc.cbx_update.checked = true then //maha 111202
	//openwithparm(w_gp_prac_update,il_group_id)
	//IF not gb_contract_version THEN openwithparm(w_gp_prac_update,il_group_id) //Alfee 04.22.2008
	
	//IF not gb_contract_version THEN openwithparm(w_gp_prac_update,iuo_loc.il_group_id) //Alfee 11.13.2010
	IF not gb_contract_version THEN openwithparm(w_gp_prac_update, lst_ids) //Start Code Change ----10.31.2016 #V153 maha - changed to structure
	
	//---------Begin Added by (Appeon)Stephen 12.05.2013 for Bug 3764 Updates made to fields on Location Detail do not change on Location Search until Close Group and reopen--------
	li_gp_id = iuo_loc.il_group_id //(BugH091701) Alfee 11.13.2010
	iuo_loc.tab_2.tabpage_browse.dw_browse.retrieve()
	POST of_scroll_tab2_dw_browse(li_gp_id) //(BugH091701) Alfee 11.13.2010
	//POST of_scroll_tab2_dw_browse(il_loc_id)
	//---------End Added ------------------------------------------------------
	
	//end if
//---------Begin Modified by alfee 11.13.2010 -------
//<$Reason>Call the pfc_preupdate() and pfc_postupdate()
//elseif iuo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.getitemstatus(1,0,primary!) = newmodified! then //maha111202
//	ll_recid = gnv_app.of_get_id( "RECORD_ID" )
//	iuo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.setitem(1,"rec_id",ll_recid)
//	//iuo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.setitem(1,"address_id",il_group_id)
//	iuo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.setitem(1,"address_id",iuo_loc.il_group_id)	//alfee 11.13.2010
//	iuo_loc.tab_2.tabpage_survey.uo_survey.tab_review.tabpage_setup.dw_setup.update()
//---------End Modified --------------------------------
elseif iuo_loc.tab_2.selectedtab = 3 then 
	iuo_loc.tab_2.tabpage_data.uo_data.of_save()
else
	w_group_practice.Event pfc_Save()
end if



cb_find_gp.visible = false
end event

type tab_1 from tab within w_group_practice
event create ( )
event destroy ( )
integer x = 5
integer y = 132
integer width = 4526
integer height = 2552
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
boolean raggedright = true
boolean createondemand = true
alignment alignment = right!
integer selectedtab = 1
tabpage_group tabpage_group
tabpage_loc tabpage_loc
tabpage_assoc tabpage_assoc
end type

on tab_1.create
this.tabpage_group=create tabpage_group
this.tabpage_loc=create tabpage_loc
this.tabpage_assoc=create tabpage_assoc
this.Control[]={this.tabpage_group,&
this.tabpage_loc,&
this.tabpage_assoc}
end on

on tab_1.destroy
destroy(this.tabpage_group)
destroy(this.tabpage_loc)
destroy(this.tabpage_assoc)
end on

event selectionchanged;long ll_row
String ls_title

//Start Code Change ----07.07.2010 #V10 maha
if newindex = 1 then
	cb_add_gp.visible = false
	cb_delete.visible = false
	cb_prior.visible=false
	cb_next.visible=false
	cb_copy.visible=false  //Start Code Change ----07.24.2017 #V154 maha
//---Begin Modified by alfee 11.10.2010 -------	
	cb_addfor.visible = false 
	cb_find_gp.visible = false 
	cb_viewdoc.visible = false  //Start Code Change ----10.20.2016 #V153 maha 
	parent.title = 'Group Practices'	
else
	tab_1.tabpage_loc.uo_loc.of_set_buttons(tab_1.tabpage_loc.uo_loc.tab_2.selectedtab)
	ll_row = tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.dw_browse.getrow()
	if ll_row > 0 then
		ls_title = "Locations (" + tab_1.tabpage_loc.uo_loc.tab_2.tabpage_browse.dw_browse.getitemstring(ll_row, "full_address")  + ")"
		if not gb_contract_version then ls_title = "Practice " + ls_title
		w_group_practice.title = ls_title 
	end if
	POST of_scroll_tab2_dw_browse(il_loc_id)// added by nova 2010.11.15
end if	

of_set_security() //Start Code Change ----01.07.2011 #V11 maha - readded
//else
//	cb_add_gp.visible = true
//	cb_delete.visible = true	
//end if
//---End Modified --------------------------------



end event

type tabpage_group from userobject within tab_1
event create ( )
event destroy ( )
event ue_init ( )
integer x = 18
integer y = 100
integer width = 4489
integer height = 2436
long backcolor = 16777215
string text = "Groups"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
cb_fac_links cb_fac_links
cb_refresh cb_refresh
cb_collapse cb_collapse
cb_expand cb_expand
st_3 st_3
st_2aaa st_2aaa
st_1 st_1
dw_mg_detail dw_mg_detail
dw_group_tv dw_group_tv
cb_link_loc cb_link_loc
cb_del_loc cb_del_loc
cb_addloc cb_addloc
dw_loc_links dw_loc_links
dw_mg_browse dw_mg_browse
cb_addgroup cb_addgroup
cb_delgroup cb_delgroup
end type

on tabpage_group.create
this.cb_fac_links=create cb_fac_links
this.cb_refresh=create cb_refresh
this.cb_collapse=create cb_collapse
this.cb_expand=create cb_expand
this.st_3=create st_3
this.st_2aaa=create st_2aaa
this.st_1=create st_1
this.dw_mg_detail=create dw_mg_detail
this.dw_group_tv=create dw_group_tv
this.cb_link_loc=create cb_link_loc
this.cb_del_loc=create cb_del_loc
this.cb_addloc=create cb_addloc
this.dw_loc_links=create dw_loc_links
this.dw_mg_browse=create dw_mg_browse
this.cb_addgroup=create cb_addgroup
this.cb_delgroup=create cb_delgroup
this.Control[]={this.cb_fac_links,&
this.cb_refresh,&
this.cb_collapse,&
this.cb_expand,&
this.st_3,&
this.st_2aaa,&
this.st_1,&
this.dw_mg_detail,&
this.dw_group_tv,&
this.cb_link_loc,&
this.cb_del_loc,&
this.cb_addloc,&
this.dw_loc_links,&
this.dw_mg_browse,&
this.cb_addgroup,&
this.cb_delgroup}
end on

on tabpage_group.destroy
destroy(this.cb_fac_links)
destroy(this.cb_refresh)
destroy(this.cb_collapse)
destroy(this.cb_expand)
destroy(this.st_3)
destroy(this.st_2aaa)
destroy(this.st_1)
destroy(this.dw_mg_detail)
destroy(this.dw_group_tv)
destroy(this.cb_link_loc)
destroy(this.cb_del_loc)
destroy(this.cb_addloc)
destroy(this.dw_loc_links)
destroy(this.dw_mg_browse)
destroy(this.cb_addgroup)
destroy(this.cb_delgroup)
end on

event ue_init();//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 01.23.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Copy the following script from the Open event of w_group_practice due
//$<modification> to the usage of CreateOnDemand. Refer to PT-02 for more information.


//IF gb_contract_version THEN
//	This.setredraw( False )
//
//	tab_1.tabpage_loc.tab_2.tabpage_survey.hide()
////	tab_2.tabpage_ass_prac.Hide() //rodger wu added.
//	tab_1.tabpage_loc.tab_2.tabpage_browse.rb_l_p.Hide( )
//	tab_1.tabpage_loc.tab_2.tabpage_browse.dw_browse.Modify("practice_type_t.text='Location Name' ")
//
//	tab_1.tabpage_loc.tab_2.selecttab( 3 )
//	tab_1.tabpage_loc.tab_2.selecttab( 1 )
//
//	tab_1.tabpage_gp.tab_2.tabpage_Data.text = "Additional Detail"
//	
//	This.setredraw( True )
//ELSE
	//Start Code Change ---- 05.11.2006 #436 maha  //added module security
//	if of_get_app_setting("set_site","I") = 0 then
//		tab_1.tabpage_loc.tab_2.tabpage_survey.hide()
//	else
//		if w_mdi.of_security_access( 1430 ) = 0 then
//			tab_1.tabpage_loc.tab_2.tabpage_survey.hide()
//		end if
//	end if
	//End Code Change---05.10.2006
//END IF

//tab_1.tabpage_gp.tab_2.tabpage_browse.cb_search.triggerevent(clicked!)
//---------------------------- APPEON END ----------------------------

end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04  Brayn
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning

//$<reason> Beacuse the tab_1.tabpage_gp.tab_2 control is set createondemand property
//$<reason> So create the tab_1.tabpage_gp.tab_2.tabpage_detail if it has not been created
//tab_1.tabpage_gp.tab_2.selecttab(2)
//tab_1.tabpage_gp.tab_2.selecttab(1)

//$<reason> Adds the user-defined event ue_init to the end of event queue in the tabpage.
//This.TriggerEvent( "ue_init" ) - commented by alfee 11.13.2010

//---------------------------- APPEON END ----------------------------

end event

type cb_fac_links from commandbutton within tabpage_group
integer x = 3424
integer y = 796
integer width = 503
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Facility Links"
end type

event clicked;gs_pass_ids lst_ids

lst_ids.ls_from_window = "G"
lst_ids.facility_id = dw_mg_detail.getitemnumber(dw_mg_detail.getrow(),"rec_id")
openwithparm(w_group_facility_links, lst_ids)
end event

type cb_refresh from commandbutton within tabpage_group
integer x = 832
integer y = 24
integer width = 347
integer height = 84
integer taborder = 31
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;//V10.5 SK Group Practice - alfee 11.11.2010
Long ll_cnt, ll_found
String ls_find

SetPointer(hourglass!)

//tab_1.tabpage_group.dw_group_tv.SetRedraw(False)

//Retrieve and locate
//Start Code Change ----01.31.2013 #V12 maha - single group option
if ib_tv_all = false then
	ll_cnt = tab_1.tabpage_group.dw_group_tv.retrieve(ii_mgp_id)
	cb_expand.triggerevent(clicked!)
else
	ll_cnt = tab_1.tabpage_group.dw_group_tv.Retrieve()
end if
//End Code Change ----01.31.2013


IF ii_mgp_id > 0 THEN ls_find = "group_multi_loc_rec_id = " + String(ii_mgp_id)
IF il_loc_id > 0 THEN ls_find += " and group_practice_rec_id = " + String(il_loc_id)
IF il_prac_id > 0 THEN ls_find += " and pd_address_prac_id = " + String(il_prac_id)
IF il_current_level < 1 THEN il_current_level = 1

ll_found = tab_1.tabpage_group.dw_group_tv.Find(ls_find, 1, ll_cnt)	
IF ll_found > 0 THEN 
	tab_1.tabpage_group.dw_group_tv.Setrow(ll_found)
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_found)
	IF il_current_level > 1 THEN tab_1.tabpage_group.dw_group_tv.Expand(ll_found, 1)
	IF il_current_level > 2 THEN tab_1.tabpage_group.dw_group_tv.Expand(ll_found, 2)
	tab_1.tabpage_group.dw_group_tv.SelectTreeNode(ll_found, il_current_level, True)
END IF

//tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
end event

type cb_collapse from commandbutton within tabpage_group
integer x = 453
integer y = 24
integer width = 347
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Collapse All"
end type

event clicked;//V10.5 SK Group Practice - alfee 11.11.2010

SetPointer(hourglass!)

if tab_1.tabpage_group.dw_group_tv.rowcount() < 1 then return

tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
tab_1.tabpage_group.dw_group_tv.CollapseAll()

if il_current_row > 0 then 
	tab_1.tabpage_group.dw_group_tv.SetRow(il_current_row)
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(il_current_row)
	tab_1.tabpage_group.dw_group_tv.SelectTreeNode(il_current_row, 1, True)
end if

tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
end event

type cb_expand from commandbutton within tabpage_group
integer x = 82
integer y = 24
integer width = 347
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Expand All"
end type

event clicked;//V10.5 SK Group Practice - alfee 11.11.2010

SetPointer(hourglass!)

if tab_1.tabpage_group.dw_group_tv.rowcount() < 1 then return

tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
tab_1.tabpage_group.dw_group_tv.ExpandAll()

if il_current_row > 0 then 
	tab_1.tabpage_group.dw_group_tv.SetRow(il_current_row)
	tab_1.tabpage_group.dw_group_tv.ScrollToRow(il_current_row)
end if

tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
end event

type st_3 from statictext within tabpage_group
integer x = 1234
integer y = 1632
integer width = 3241
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 32891346
string text = " Linked Locations"
boolean border = true
boolean focusrectangle = false
end type

type st_2aaa from statictext within tabpage_group
integer x = 1234
integer y = 12
integer width = 3241
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 32891346
string text = " Groups"
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within tabpage_group
integer x = 1234
integer y = 792
integer width = 3241
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 32891346
string text = " Group Detail"
boolean border = true
boolean focusrectangle = false
end type

type dw_mg_detail from u_dw within tabpage_group
integer x = 1234
integer y = 868
integer width = 3241
integer height = 732
integer taborder = 11
string title = "Group Detail"
string dataobject = "d_multi_group_detail"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone
String	ls_Phone,ls_RetParm

This.AcceptText() //(Appeon)Harry 06.06.2013 - V141 ISG-CLX
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-29 By: Scofield
//$<Reason> Popup a dialog to input the phone
String	ls_Phone,ls_RetParm

This.AcceptText() //(Appeon)Harry 06.06.2013 - V141 ISG-CLX
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

event updateend;call super::updateend;integer r

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.24.2006 By: LeiWei
//$<reason> Fix a defect.

gnv_app.inv_dwcache.of_unRegister('dddw_contracted_entity')
gnv_app.inv_dwcache.of_Register('dddw_contracted_entity', 'dddw_contracted_entity', SQLCA, true)

//---------------------------- APPEON END ----------------------------

//Start Code Change ----07.16.2010 #V10 maha
r = dw_facility_add.update()
if r < 0 then
	messagebox("","facility update failed")
	return 0
end if
dw_entity_add.update()
//End Code Change ----07.16.2010
end event

event pfc_preupdate;call super::pfc_preupdate;//coded in updatestart
return 1
end event

event updatestart;call super::updatestart;//Start Code Change ----07.16.2010 #V10 maha
long ll_group_id
long ll_fac
long ll_ent
long ll_cnt
nv_entity_functions lnv_ent

if this.getitemstatus(1,0,primary!) = newmodified! then
	//Start Code Change ----07.16.2010 #V10 maha
	select max(rec_id) into :ll_group_id from group_multi_loc;
	if ll_group_id < 1 OR IsNull( ll_group_id) then ll_group_id = 0
	if gb_sk_ver then //for SK get max of group or facility id as both need to be the same
		select max(facility_id) into :ll_fac from facility;
		if ll_fac > ll_group_id then ll_group_id = ll_fac
	end if
		
	ll_group_id++
	ii_mgp_id = ll_group_id
	tab_1.tabpage_group.dw_mg_detail.setitem(1,"rec_id",ll_group_id)
	
	if gb_sk_ver then
		of_add_entity_facility(ll_group_id,this)
		//debugbreak()
		inv_ent.of_add_user_facility(ll_group_id,1) //add user security  //Start Code Change ----07.26.2010 #V10 maha - add facility security
	end if
elseif  this.getitemstatus(1,0,primary!) = datamodified! then
	select count(entity_id) into :ll_cnt from entity_lookup where group_id = :ii_mgp_id;
	//Start Code Change ----05.23.2013 #V14 maha - added to check for missing entity record from clean db
	if ii_mgp_id = 1 and ll_cnt = 0 and gb_sk_ver then   
		insert into entity_lookup (entity_id, facility_id, group_id) values (1,1,1);
	end if
	//End Code Change ----05.23.2013
	if ll_cnt > 0 then
		//entity update
		inv_ent.of_update_entity_links(this,"G", ii_mgp_id)
	end if
end if

return 0
end event

event itemchanged;call super::itemchanged; //Start Code Change ----04.07.2015 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "GROUP", this)
end if
end event

type dw_group_tv from datawindow within tabpage_group
event ue_rightclick ( string as_parm )
integer x = 23
integer y = 140
integer width = 1179
integer height = 2288
integer taborder = 40
boolean titlebar = true
string title = "Group Associations"
string dataobject = "d_group_loc_assoc_tv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_rightclick(string as_parm);//For V10.5 SK Group Practice  Added by  Nova 09.17.2010
Long ll_find
Long ll_prac_id

CHOOSE CASE as_parm
	CASE 'Link Existing location'
		Parent.cb_link_loc.Event Clicked( )
	CASE 'Add New location'
		Parent.cb_addloc.Event Clicked( )
	CASE 'Directory report for that Group'
		gs_report_variables lst_arg
		lst_arg.as_report_object = "d_group_loc_assoc_rpt"
		lst_arg.ai_num_variables = 1
		lst_arg.as_var_type[1] = "N"
		lst_arg.as_value[1] = String(ii_mgp_id)
		OpenWithParm(w_report_view,lst_arg)
	CASE 'Delete link to Group'
		Parent.cb_del_loc.Event Clicked( )
	CASE 'Associate practitioners'
		OpenWithParm (w_gp_prac_link, il_loc_id) //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
	CASE 'Batch add addresses'
		OpenWithParm (w_batch_add_address, il_loc_id) //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
		of_refresh_dw_tv(Message.StringParm, il_loc_id) //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
	CASE 'View Associated practitioners'
		//-----Begin Modified by alfee 11.11.2010 ------------
		//<$Reason>For a web issue and the createondemand property
		//tab_1.tabpage_group.dw_loc_links.TriggerEvent(DoubleClicked!)
		//tab_1.tabpage_loc.uo_loc.tab_2.SelectTab(4)
		iuo_loc.il_group_id	 = il_loc_id
		tab_1.selecttab( 2)  
		tab_1.tabpage_loc.uo_loc.tab_2.Post SelectTab(2)
		tab_1.tabpage_loc.uo_loc.tab_2.post SelectTab(4)
		//-----End Modified ---------------------------------------
	CASE 'Delete Association link'
		IF MessageBox("Question","Are you sure you want to delete the association link?",Question!,yesnocancel!,1) = 1 THEN
			UPDATE pd_address Set gp_id = Null Where prac_id = :il_prac_id And gp_id = :il_loc_id ; //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
			IF sqlca.SQLCode <> 0 THEN
				ROLLBACK Using sqlca;
				MessageBox("Infor","Delete failed!")
			ELSE
				of_delete_dw_tv(il_loc_id,il_prac_id) //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
				COMMIT Using sqlca;
			END IF
		END IF
	CASE 'Delete linked address record'
		IF MessageBox("Question","Are you sure you want to delete the linked address record?",Question!,yesnocancel!,1) = 1 THEN
			DELETE From pd_address Where prac_id = :il_prac_id And gp_id = :il_loc_id ; //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
			IF sqlca.SQLCode <> 0 THEN
				ROLLBACK Using sqlca;
				MessageBox("Infor","Delete failed!")
			ELSE
				of_delete_dw_tv(il_loc_id,il_prac_id) //iuo_loc.il_group_id->il_loc_id - alfee 11.13.2010
				COMMIT Using sqlca;
			END IF
		END IF
	CASE 'Open in practitioner folder'
		ll_prac_id = This.GetItemNumber(my_band.row , "pd_address_prac_id")
		//if isnull(ll_prac_id) then return
		if isnull(ll_prac_id) or ll_prac_id < 1 then return //alfee 11.11.2010
		of_open()
		Post of_goto_practitioner(ll_prac_id)
	CASE ELSE
		
END CHOOSE




end event

event constructor;//For V10.5 SK Group Practice  Added by  Nova 09.26.2010

//Start Code Change ----01.31.2013 #V12 maha  -option to retrieve by group
if of_get_app_setting("set_70","I") = 1 then
	ib_tv_all = False
	this.dataobject = "d_group_loc_assoc_tv_single"
end if

This.SetTransObject(sqlca)

if ib_tv_all = True then
	This.Retrieve()
	IF This.RowCount() > 0 THEN
		//ii_mgp_id = This.GetItemNumber(1 , "group_loc_link_group_id") - Commented by alfee 11.13.2010
		This.selecttreenode( 1, 1, True)
	else  //Start Code Change ----05.23.2011 #V11 maha - open to location tab if there are no groups
		if not gb_sk_ver then
			//tab_1.selectedtab = 2
			tab_1.post selecttab(2) //Modify by Michael 08.03.2011 --- Fixed a bug:tab item not changed 
		end if
	END IF
end if
//End Code Change ----01.31.2013


//Start Code Change ----07.17.2017 #V154 maha - added for font increase
this.Modify("DataWindow.Zoom=" + string(gi_zoom))  

end event

event clicked;//For V10.5 SK Group Practice  Added by  Nova 09.26.2010
Long ll_return
String obj_name , obj_type , dw_band

obj_name = dwo.Name
obj_type = dwo.Type
dw_band = This.GetBandAtPointer()
my_band = gf_parse_bandinfo (dw_band)

CHOOSE CASE  my_band.band //obj_name
	CASE 'tree.level.1' //group_loc_link_group_id
		//This.SelectTreeNode( my_band.row,1,True) - commented by alfee 11.11.2010
		//ll_return = of_findrow(This,my_band.row,tab_1.tabpage_group.dw_mg_browse,"group_multi_loc_rec_id","rec_id") - commented by alfee 11.11.2010
		of_expandbylevel(This,1)
	CASE 'tree.level.2' //group_practice_rec_id
		//This.SelectTreeNode( my_band.row,2,True) - commented by alfee 11.11.2010
		//of_findrow(This,my_band.row,tab_1.tabpage_group.dw_loc_links,"group_practice_rec_id","group_loc_link_loc_id") - commented by alfee 11.11.2010
		of_expandbylevel(This,2)
	CASE 'detail'
		//This.SelectTreeNode( my_band.row,3,True) - commented by alfee 11.11.2010		
	CASE ELSE
END CHOOSE

end event

event expanded;//commented by alfee 11.11.2010

////For V10.5 SK Group Practice  Added by  Nova 09.26.2010
//CHOOSE CASE  grouplevel //obj_name
//	CASE 1 //group_loc_link_group_id
//		This.SelectTreeNode( row,1,True)
//		//of_findrow(This,row,tab_1.tabpage_group.dw_mg_browse,"group_loc_link_group_id","rec_id") - commented by alfee 11.11.2010
//	CASE 2 //group_practice_rec_id 
//		This.SelectTreeNode( row,2,True)
//		//of_findrow(This,row,tab_1.tabpage_group.dw_loc_links,"group_practice_rec_id","group_loc_link_loc_id") - commented by alfee 11.11.2010
//	CASE 3
//		This.SelectTreeNode( row,3,True)
//	CASE ELSE
//END CHOOSE
//
end event

event doubleclicked;//For V10.5 SK Group Practice  Added by  Nova 09.26.2010
Long ll_prac_id,ll_rec_id
String obj_name , obj_type , dw_band

//IF row<1 THEN Return//nova 11.18.2010  commented by Nova 12.16.2010

obj_name = dwo.Name
obj_type = dwo.Type
dw_band = This.GetBandAtPointer()
my_band = gf_parse_bandinfo (dw_band)

CHOOSE CASE  my_band.band //obj_name
	CASE 'tree.level.2' //group_practice_rec_id 
	//group_practice.rec_id
		ll_rec_id= This.GetItemNumber(my_band.row , "group_multi_loc_rec_id")
		//if isnull(ll_rec_id) then return
		if isnull(ll_rec_id)  or ll_rec_id < 1 then return	//alfee 11.11.2010
		tab_1.tabpage_group.dw_loc_links.TriggerEvent(DoubleClicked!)
	CASE 'detail'
		//if ll_prac_id is null then return
		IF my_band.row<1 THEN Return //nova 12.16.2010
		ll_prac_id = This.GetItemNumber(my_band.row , "pd_address_prac_id")
		//if isnull(ll_prac_id) then return
		if isnull(ll_prac_id) or ll_prac_id < 1 then return //alfee 11.11.2010
		of_open()
		Post of_goto_practitioner(ll_prac_id)
		
	CASE ELSE
		
END CHOOSE





end event

event rbuttondown;//For V10.5 SK Group Practice  Added by  Nova 09.26.2010
String obj_name , obj_type , dw_band
m_group_practice_tv mymenu

obj_name = dwo.Name
obj_type = dwo.Type
dw_band = This.GetBandAtPointer()
my_band = gf_parse_bandinfo (dw_band)

mymenu = Create m_group_practice_tv

CHOOSE CASE  my_band.band //obj_name
	CASE 'tree.level.1' //group_loc_link_group_id
		This.SelectTreeNode( my_band.row,1,True)
		//ll_return = of_findrow(This,my_band.row,tab_1.tabpage_group.dw_mg_browse,"group_loc_link_group_id","rec_id") - commented by alfee 11.11.2010
		mymenu.m_0.Visible = False
		mymenu.m_deletelinktogroup.Visible = False
		mymenu.m_associatepractitioners.Visible = False
		mymenu.m_batchaddaddresses.Visible = False
		mymenu.m_viewassociatedpractitioners.Visible = False
		mymenu.m_1.Visible = False
		mymenu.m_deleteassociationlink.Visible = False
		mymenu.m_deletelinkedaddressrecord.Visible = False
		mymenu.m_openinpractitionerfolder.Visible = False
	CASE 'tree.level.2' //group_practice_rec_id 
		This.SelectTreeNode( my_band.row,2,True)
		//of_findrow(This,my_band.row,tab_1.tabpage_group.dw_loc_links,"group_practice_rec_id","group_loc_link_loc_id")  - commented by alfee 11.11.2010
		//if isnull(This.GetItemNumber(my_band.row , "group_practice_rec_id")) then 
		if isnull(This.GetItemNumber(my_band.row , "group_practice_rec_id")) or This.GetItemNumber(my_band.row , "group_practice_rec_id") < 1 then //alfee 11.11.2010
			mymenu.m_deletelinktogroup.enabled = False
			mymenu.m_associatepractitioners.enabled = False
			mymenu.m_batchaddaddresses.enabled = False
			mymenu.m_viewassociatedpractitioners.enabled = False
		end if
		mymenu.m_0.Visible = False
		mymenu.m_linkexistinglocation.Visible = False
		mymenu.m_addnewlocation.Visible = False
		mymenu.m_directoryreportforthatgroup.Visible = False
		mymenu.m_1.Visible = False
		mymenu.m_deleteassociationlink.Visible = False
		mymenu.m_deletelinkedaddressrecord.Visible = False
		mymenu.m_openinpractitionerfolder.Visible = False
		
	CASE 'detail'
		This.SelectTreeNode( my_band.row,3,True)
		//il_prac_id = This.GetItemNumber(my_band.row , "pd_address_prac_id") - commented by alfee 11.13.2010
		//iuo_loc.il_group_id=This.object.group_practice_rec_id[my_band.row] - commented by alfee 11.13.2010
		//if isnull(il_prac_id) then
		if isnull(il_prac_id) or il_prac_id < 1 then	 //alfee 11.11.2010
			mymenu.m_deleteassociationlink.enabled = False
			mymenu.m_deletelinkedaddressrecord.enabled = False
			mymenu.m_openinpractitionerfolder.enabled = False
		end if
		mymenu.m_linkexistinglocation.Visible = False
		mymenu.m_addnewlocation.Visible = False
		mymenu.m_directoryreportforthatgroup.Visible = False
		mymenu.m_0.Visible = False
		mymenu.m_deletelinktogroup.Visible = False
		mymenu.m_associatepractitioners.Visible = False
		mymenu.m_batchaddaddresses.Visible = False
		mymenu.m_viewassociatedpractitioners.Visible = False
		mymenu.m_1.Visible = False
	CASE ELSE
		
END CHOOSE

IF my_band.row > 0 THEN
	mymenu.PopMenu (PixelsToUnits(xpos , XPixelsToUnits! ) + This.X + Parent.X +30 , PixelsToUnits(ypos, YPixelsToUnits! ) +This.Y + Parent.Y + 130)
ELSE
	Destroy mymenu
END IF






end event

event treenodeselected;//V10.5 SK Group Practice - reconstructed by alfee 11.11.2010

il_current_row = row
il_current_level = grouplevel

if row > 0 then	
	ii_mgp_id = this.getitemnumber(row, "group_multi_loc_rec_id")
	il_loc_id = this.getitemnumber(row, "group_practice_rec_id") 
	il_prac_id = this.getitemnumber(row, "pd_address_prac_id") 
  	
	//if grouplevel = 1 then il_loc_id = 0//commented by nova 2010-11-15
	if grouplevel < 3 then il_prac_id = 0//
	
	ii_last_mgp_id = ii_mgp_id
	il_last_loc_id = il_loc_id
	//iuo_loc.il_group_id	 = il_loc_id - needn't call it unless locating in uo_loc via the Group Tab page 
	
	//find row in group and location dws
	of_find_row(ii_mgp_id, il_loc_id)
end if

//if my_band.band <>'detail'  then
//	il_current_row=row
//	il_current_level=grouplevel
//end if
//
//choose case grouplevel
//	case 1  //
//		of_findrow(This,row,tab_1.tabpage_group.dw_mg_browse,"group_multi_loc_rec_id","rec_id")
//	case 2 //child node
//		of_findrow(This,row,tab_1.tabpage_group.dw_loc_links,"group_practice_rec_id","group_loc_link_loc_id")
//end choose

end event

event getfocus;//lb_selected_datawindow_tv=true - commented by alfee 11.11.2010
end event

type cb_link_loc from commandbutton within tabpage_group
integer x = 2519
integer y = 1636
integer width = 366
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Link Existing"
end type

event clicked;long li_linkrow
long li_link_id
long li_loc_id
long li_mgp_id
long ll_cnt, ll_found //04.22.2008
integer r  //maha 07.24.2017
integer nr
gs_pass_ids lds_ids   //maha 07.24.2017

if tab_1.tabpage_group.dw_mg_browse.rowcount() < 1 then return

of_linksave()

//Start Code Change ----07.24.2017 #V154 maha - mod for multi-select
//open(w_practice_to_addr_find)
openwithparm(w_practice_to_addr_find, "LINK")

//li_loc_id = message.doubleparm
//if li_loc_id < 1 then return

//if message.doubleparm = 0 then	return

lds_ids = message.powerobjectparm

if not(isvalid(lds_ids)) then return

r = upperbound(lds_ids.l_ids)
//messagebox("returned count:", r)

SELECT max(rec_id)	INTO :li_link_id From group_loc_link;
IF li_link_id < 1 Or IsNull( li_link_id ) THEN li_link_id = 0

//li_loc_id = dw_mg_detail.getitemnumber(1,"rec_id")
	
for r = 1 to upperbound(lds_ids.l_ids)
	li_loc_id = lds_ids.l_ids[r]
	//Check to avoid duplicate records 
	ll_cnt = tab_1.tabpage_group.dw_loc_links.RowCount()
	IF ll_cnt > 0 THEN
		ll_found = tab_1.tabpage_group.dw_loc_links.find( "group_loc_link_loc_id = " + String(li_loc_id), 1, ll_cnt)
		IF ll_found > 0  THEN Continue	
	END IF

	li_link_id++
	
	nr = tab_1.tabpage_group.dw_loc_links.insertrow(0)
	
	tab_1.tabpage_group.dw_loc_links.SetItem( nr,"group_loc_link_rec_id",li_link_id)
	tab_1.tabpage_group.dw_loc_links.SetItem(nr,"group_loc_link_loc_id",li_loc_id)
	tab_1.tabpage_group.dw_loc_links.SetItem( nr,"group_loc_link_group_id",ii_mgp_id)
	

	//of_group_link_local(0, li_loc_id, false) //Added by evan 09.26.2011
//	of_group_link_local(0, li_loc_id, true)	
next

 tab_1.tabpage_group.dw_loc_links.Update()
 tab_1.tabpage_group.dw_loc_links.retrieve(ii_mgp_id) 
//---------Begin Modified by (Appeon)Stephen 11.13.2017 for Alpha id 5867 - Groups 'Link Existing' Filter Search Error --------
//tab_1.tabpage_group.dw_group_tv.retrieve()
if tab_1.tabpage_group.dw_group_tv.dataobject = "d_group_loc_assoc_tv_single" then
	tab_1.tabpage_group.dw_group_tv.retrieve(ii_mgp_id)
else
	tab_1.tabpage_group.dw_group_tv.retrieve()
end if
//---------End Modfiied ------------------------------------------------------




end event

type cb_del_loc from commandbutton within tabpage_group
integer x = 2176
integer y = 1636
integer width = 338
integer height = 76
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Link"
end type

event clicked;Long		ll_Row
Integer 	li_Rtn
Long ll_group_id,ll_loc_id,ll_find
ll_Row = tab_1.tabpage_group.dw_loc_links.GetRow()
IF ll_Row <= 0 Or ll_Row > tab_1.tabpage_group.dw_loc_links.RowCount() THEN RETURN

li_Rtn = MessageBox("Confirm Delete","Are you sure you want to delete the selected link?",question!,yesno!,2)

IF li_Rtn = 1 THEN
	//--------Begin Modified by  Nova 09.17.2010------------------------
	//V10.5 SK Group Practice 
	ll_group_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_group_id[ll_Row]
	ll_loc_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_loc_id[ll_Row]
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	IF ll_find > 0 THEN
		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_find, 1) = False THEN
			tab_1.tabpage_group.dw_group_tv.expand( ll_find, 1)
		END IF
	END IF
	//--------End Modified --------------------------------------------
	tab_1.tabpage_group.dw_loc_links.DeleteRow(0)
	tab_1.tabpage_group.dw_loc_links.Update()
	COMMIT Using sqlca;
	//--------Begin Modified by  Nova 09.17.2010------------------------
	//V10.5 SK Group Practice 
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id)+" and group_practice_rec_id="+String(ll_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	Parent.SetRedraw( False)
	DO WHILE ll_find > 0
		tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id)+" and group_practice_rec_id="+String(ll_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	LOOP
	
	//--------Begin added by  Nova 09.27.2010------------------------
	//V10.5 SK Group Practice 
	long ll_rowcount,ll_found,ll_mgp_id
	datastore ds_addloc
	string ls_street
	ds_addloc = Create datastore
	ds_addloc.DataObject = 'd_group_loc_assoc_with_mul_id'
	ds_addloc.SetTransObject( sqlca)
	ll_rowcount = ds_addloc.Retrieve(ll_group_id)
	
	IF ll_rowcount=1 THEN
		//ls_street=ds_addloc.object.group_practice_street[1] 
		//if ls_street='**No Linked Locations**' then
		if isnull(ds_addloc.object.group_practice_rec_id[1]) or ds_addloc.object.group_practice_rec_id[1] < 1 then //alfee 11.11.2010		
			ds_addloc.RowsCopy( ds_addloc.GetRow( ) , ds_addloc.RowCount(),  Primary!, tab_1.tabpage_group.dw_group_tv , 1,  Primary!)
			tab_1.tabpage_group.dw_group_tv.SetRedraw(False)
			//tab_1.tabpage_group.dw_group_tv.SetSort("group_multi_loc_gp_name A group_practice_street A v_full_name_full_name A ") - commented by alfee 11.11.2010
			tab_1.tabpage_group.dw_group_tv.Sort()
			tab_1.tabpage_group.dw_group_tv.GroupCalc()
			tab_1.tabpage_group.dw_group_tv.SetRedraw(True)
			//find tv-dw then expand
			ll_found = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ll_group_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
			IF ll_found > 0 THEN
				IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_found, 1) = False THEN
					tab_1.tabpage_group.dw_group_tv.expand( ll_found, 1)
					tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_found,1,True)
				END IF
			END IF
		end if
	END IF
	
	Destroy ds_addloc
	//--------End added --------------------------------------------	
	Parent.SetRedraw( True)
	//--------End Modified --------------------------------------------

	//--------Begin Added by alfee 11.11.2010 ---------------------
	//Locate in the next row
	ll_rowcount = tab_1.tabpage_group.dw_loc_links.RowCount()
	IF  ll_rowcount > 0 THEN
		IF ll_row > ll_rowcount THEN ll_row = 1
		tab_1.tabpage_group.dw_loc_links.SetRow(ll_row)
		tab_1.tabpage_group.dw_loc_links.ScrollToRow(ll_row)
		tab_1.tabpage_group.dw_loc_links.SelectRow(0, false)
		tab_1.tabpage_group.dw_loc_links.SelectRow(ll_row, true)
		tab_1.tabpage_group.dw_loc_links.Trigger Event RowFocusChanged(ll_row)		
	END IF
	//--------End Added ----------------------------------------------
	
END IF


end event

type cb_addloc from commandbutton within tabpage_group
integer x = 1851
integer y = 1636
integer width = 320
integer height = 76
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add New"
end type

event clicked;//V10.5 SK Group Practice - Nova 11.05.2010

IF tab_1.tabpage_group.dw_mg_browse.RowCount() < 1 THEN RETURN

of_linksave()

//---Begin Modified by alfee 11.11.2010 ---------
String ls_ret
Long ll_gp_id

OpenwithParm(w_group_add, ii_mgp_id)

ls_ret = message.stringparm
if ls_ret = "Cancel" then
	return
else
	//------------------- APPEON BEGIN -------------------
	//$<modify> Evan 09.26.2011
	//$<reason> Extend return values
	/*
	ll_gp_id = long(ls_ret)	
	of_group_link_local(ll_gp_id, true)
	*/
	string ls_Arg[]
	long ll_rec_id, ll_loc_id
	n_cst_string lnv_string
	lnv_string.of_ParseToArray(ls_ret, '|', ls_Arg[])
	if UpperBound(ls_Arg) > 1 then
		ll_rec_id = long(ls_Arg[1])
		ll_loc_id = long(ls_Arg[2])
		of_group_link_local(ll_rec_id, ll_loc_id, true)
	end if
	//------------------- APPEON END ---------------------
end if

//tab_1.SelectTab( 2)
//cb_add_gp.PostEvent(Clicked!)
//ib_add_loc_and_link = True
//---End Modified -----------------------------------


end event

type dw_loc_links from datawindow within tabpage_group
integer x = 1234
integer y = 1708
integer width = 3241
integer height = 720
integer taborder = 60
string title = "Linked Locations/ Addresses"
string dataobject = "d_group_linked_locations"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;Integer li_row
Long ll_group_id,ll_loc_id,ll_find
li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.SetRow(li_row)
	This.ScrollToRow(li_row)
	This.SelectRow(0,False)
	This.SelectRow(li_row,True)
	//--------Begin Modified by  Nova 09.17.2010------------------------
	//V10.5 SK Group Practice 
	ll_group_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_group_id[li_row]//[row] Modify by Michael 10.09.2011 replace row with li_row
	ll_loc_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_loc_id[li_row]//[row] Modify by Michael 10.09.2011 replace row with li_row
	//iuo_loc.il_group_id = ll_loc_id - commented by alfee 11.13.2010
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_loc_link_group_id="+String(ll_group_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	IF ll_find > 0 THEN
		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_find, 1) = False THEN
			tab_1.tabpage_group.dw_group_tv.expand( ll_find, 1)
		END IF
		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_loc_link_group_id="+String(ll_group_id)+" and group_practice_rec_id="+String(ll_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
		IF ll_find > 0 THEN
			tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
			tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find,2,True)
		END IF
	END IF
	//--------End Modified --------------------------------------------
END IF

end event

event constructor;this.settransobject(sqlca)

DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-26
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )


This.GetChild( "practice_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("practice type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-27
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "practice_type", dwchild )
dwchild.InsertRow( 1 )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.13.2006 By: LeiWei
//$<reason> Making the Contract Module a Standalone Product
IF gb_contract_version THEN
	Modify( "group_practice_street_t.text = 'Location Name'" )
END IF
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;long ll_loc

//---------Begin Modified by (Appeon)Harry 11.22.2013 for V141 for BugH110602 of  History Issues-------
//if row < 1 or this.getrow()=0  then return  //Nova 09.14.2010 
if this.getrow()<=0  then return  //Nova 09.14.2010 
//---------End Modfiied ------------------------------------------------------

//Start Code Change ----06.30.2010 #V10 maha - open location when selected

//ll_loc = this.getitemnumber(row,"group_loc_link_loc_id") - commented by alfee 11.13.2010
//ll_loc = this.getitemnumber(this.getrow(),"group_loc_link_loc_id")  - commented by alfee 11.13.2010

iuo_loc.il_group_id	 = il_loc_id //alfee 11.13.2010
tab_1.selecttab( 2)
cb_selecttab2.postevent(clicked!)
POST of_scroll_tab2_dw_browse(il_loc_id)// added by nova 2010.11.15





end event

event rowfocuschanged;Long ll_mgp_id, ll_loc_id, ll_find

if currentrow=0 then return 
This.SelectRow(0,False)
This.SelectRow(currentrow,True)

//--------Begin Modified by  Nova 09.17.2010------------------------
//V10.5 SK Group Practice 
ll_mgp_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_group_id[currentrow]
ll_loc_id = tab_1.tabpage_group.dw_loc_links.Object.group_loc_link_loc_id[currentrow]
if isnull(ll_mgp_id) then ll_mgp_id = 0 //alfee 11.19.2010
if isnull(ll_loc_id) then ll_loc_id = 0 //alfee 11.19.2010
il_loc_id  = ll_loc_id //alfee 11.13.2010
//iuo_loc.il_group_id = ll_loc_id

//datawindow treeview scroll
//if lb_selected_datawindow_tv=false then
IF  (ii_last_mgp_id <> ll_mgp_id OR il_last_loc_id <> ll_loc_id) and not ib_find_row THEN //alfee 11.11.2010
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_loc_link_group_id="+String(ll_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	IF ll_find > 0 THEN
		IF tab_1.tabpage_group.dw_group_tv.isexpanded( ll_find, 1) = False THEN
			tab_1.tabpage_group.dw_group_tv.expand( ll_find, 1)
		END IF
		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_loc_link_group_id="+String(ll_mgp_id)+" and group_practice_rec_id="+String(ll_loc_id) , 1, tab_1.tabpage_group.dw_group_tv.RowCount())
		IF ll_find > 0 THEN
				tab_1.tabpage_group.dw_group_tv.ScrollToRow(ll_find)
				tab_1.tabpage_group.dw_group_tv.SelectTreeNode( ll_find,2,True)
		END IF
	END IF
END IF

//--------End Modified --------------------------------------------

end event

event getfocus;//lb_selected_datawindow_tv=false - commented by alfee 11.11.2010
end event

type dw_mg_browse from datawindow within tabpage_group
integer x = 1234
integer y = 88
integer width = 3241
integer height = 688
integer taborder = 40
string title = "Groups"
string dataobject = "d_multi_group_browse"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event clicked;integer li_row
long ll_find
li_row = this.getclickedrow()

tab_1.tabpage_group.dw_mg_detail.setrow(li_row)
tab_1.tabpage_group.dw_mg_detail.scrolltorow(li_row)

IF li_row < 1 then return
ii_mgp_id = this.getitemnumber( li_row, "rec_id") 
This.SelectRow( 0, False )
This.SelectRow( li_row, True )

if li_Row = il_CurGroup then This.Trigger Event RowFocusChanged(li_Row)	//Added by Scofield on 2008-01-04
//--------Begin Added by Nova 09.17.2010------------------------
ll_find=tab_1.tabpage_group.dw_group_tv.find("group_multi_loc_rec_id="+string(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.rowcount())
if ll_find>0 then
	tab_1.tabpage_group.dw_group_tv.scrolltorow( ll_find)
	tab_1.tabpage_group.dw_group_tv.selecttreenode( ll_find, 1, True)
end if
//--------End Added --------------------------------------------
end event

event constructor;This.settransobject(sqlca)
dw_mg_detail.settransobject(sqlca)
dw_loc_links.settransobject(sqlca)

This.Retrieve()
if this.rowcount()>0 then
	this.selectrow( 0, false)
	this.selectrow( 1, true)
end if	

of_zoom()


end event

event retrieveend;
//IF rowcount > 0 THEN
//	//ii_mgp_id = this.getitemnumber( 1, "rec_id")
//	tab_1.tabpage_group_master.dw_mg_detail.retrieve(ii_mgp_id)
//	tab_1.tabpage_group_master.dw_loc_links.retrieve(ii_mgp_id)
//	This.SelectRow( 0, False )
//	This.SelectRow( 1, True )
//END IF

end event

event rowfocuschanged;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-28
//$<modify> 03.29.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
tab_1.tabpage_group_master.dw_mg_detail.retrieve(ii_mgp_id)
tab_1.tabpage_group_master.dw_loc_links.retrieve(ii_mgp_id)
*/
//messagebox(string(currentrow),string(ii_mgp_id))
long ll_find
IF not this.rowcount() > 0 then return
IF not currentrow > 0 then return //while deleting the last row - alfee 11.16.2010
ii_mgp_id = this.getitemnumber(currentrow, "rec_id") 
This.SelectRow( 0, False )
This.SelectRow( currentrow, True )

gnv_appeondb.of_startqueue( )
tab_1.tabpage_group.dw_mg_detail.retrieve(ii_mgp_id)
tab_1.tabpage_group.dw_loc_links.retrieve(ii_mgp_id)
gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

il_CurGroup = CurrentRow		//Added by Scofield on 2008-01-04

//Start Code Change ----01.31.2013 #V12 maha - single group option
if ib_tv_all = false then
	tab_1.tabpage_group.dw_group_tv.retrieve(ii_mgp_id)
	cb_expand.triggerevent(clicked!)
end if
//End Code Change ----01.31.2013


//--------Begin Added by Nova 09.17.2010------------------------
//if lb_selected_datawindow_tv=false then
if  ii_last_mgp_id <> ii_mgp_id  and not ib_find_row then //alfee 11.11.2010	
	ll_find=tab_1.tabpage_group.dw_group_tv.find("group_multi_loc_rec_id="+string(ii_mgp_id), 1, tab_1.tabpage_group.dw_group_tv.rowcount())
	if ll_find>0 then
		tab_1.tabpage_group.dw_group_tv.scrolltorow( ll_find)
		tab_1.tabpage_group.dw_group_tv.selecttreenode( ll_find, 1, True)
	end if
end if	
//--------End Added -------------------------------------------------
end event

event getfocus;//lb_selected_datawindow_tv=false - commented by alfee 11.11.2010
end event

type cb_addgroup from commandbutton within tabpage_group
integer x = 1851
integer y = 796
integer width = 471
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Group"
end type

event clicked;of_linksave()	
	
tab_1.tabpage_group.dw_mg_detail.Reset()
tab_1.tabpage_group.dw_mg_detail.insertrow(1)
tab_1.tabpage_group.dw_mg_detail.SetFocus()
tab_1.tabpage_group.dw_mg_detail.SetColumn( "gp_name" )

tab_1.tabpage_group.dw_loc_links.Reset( )
end event

type cb_delgroup from commandbutton within tabpage_group
integer x = 2336
integer y = 796
integer width = 503
integer height = 76
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Group"
end type

event clicked;Integer	li_Rtn
Long		ll_Row,ll_CurRow,ll_Cycle,ll_RowCnt
Decimal	ldc_RecID
Long ll_find //V10.5 SK Group Practice
//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-09-24 By: Scofield
//$<Reason> Delete Unsaved row.

IF tab_1.tabpage_group.dw_mg_detail.Visible THEN
	ll_Row = tab_1.tabpage_group.dw_mg_detail.GetRow()
	IF ll_Row <= 0 Or ll_Row > tab_1.tabpage_group.dw_mg_detail.RowCount() THEN RETURN
	
	ldc_RecID = tab_1.tabpage_group.dw_mg_detail.GetItemDecimal(ll_Row,"rec_id")
	IF IsNull(ldc_RecID) THEN
		li_Rtn = MessageBox("Confirm Delete","Are you sure you want to delete this Group?",question!,yesno!,2)
		IF li_Rtn = 1 THEN
			tab_1.tabpage_group.dw_mg_detail.DeleteRow(0)
			ll_Row = tab_1.tabpage_group.dw_mg_browse.GetRow()
			IF ll_Row > 0 Or ll_Row <= tab_1.tabpage_group.dw_mg_browse.RowCount() THEN
				tab_1.tabpage_group.dw_mg_browse.Trigger Event RowFocusChanged(ll_Row)
			END IF
		END IF
		
		RETURN
	END IF
END IF
//---------------------------- APPEON END ----------------------------

ll_Row = tab_1.tabpage_group.dw_mg_browse.GetRow()
IF ll_Row <= 0 Or ll_Row > tab_1.tabpage_group.dw_mg_browse.RowCount() THEN RETURN

li_Rtn = MessageBox("Confirm Delete","Are you sure you want to delete the selected Group and all its links?(will not effect practice locations)",question!,yesno!,2)

IF li_Rtn <> 1 THEN RETURN

//-------------Begin Added by Alfee 07.05.2010 --------------------
IF gb_contract_module THEN
	ldc_RecID = tab_1.tabpage_group.dw_mg_browse.GetItemDecimal(ll_Row,"rec_id")
	SELECT count(distinct ctx_id) Into :ll_RowCnt From ctx_loc Where parent_comp_id = :ldc_RecID;
	IF ll_RowCnt > 0 And ldc_RecID <> 0 And Not IsNull(ldc_RecID) THEN
		MessageBox("Delete","There are " + String(ll_RowCnt) + " Contract(s) linked to this Parent Organization. These contract locations must be deleted in Contracts before this record can be removed.")
		RETURN
	END IF
END IF
//-------------End Added -------------------------------------------
//Start Code Change ----07.26.2010 #V10 maha - check for connected providers
IF gb_sk_ver THEN
	ldc_RecID = tab_1.tabpage_group.dw_mg_browse.GetItemDecimal(ll_Row,"rec_id")
	SELECT count(distinct rec_id) Into :ll_RowCnt From pd_affil_stat Where parent_facility_id = :ldc_RecID;
	IF ll_RowCnt > 0 And ldc_RecID <> 0 And Not IsNull(ldc_RecID) THEN
		MessageBox("Delete","There are " + String(ll_RowCnt) + " Provider records linked to this Group. Those Records must be deleted before the Group can be deleted.")
		RETURN
	END IF
END IF
//End Code Change ----07.26.2010

tab_1.tabpage_group.dw_loc_links.SetFocus()
ll_RowCnt = tab_1.tabpage_group.dw_loc_links.RowCount()
FOR ll_Cycle = 1 To ll_RowCnt
	tab_1.tabpage_group.dw_loc_links.DeleteRow(0)
NEXT
ib_delete = True
//---------------------------- APPEON END ----------------------------

tab_1.tabpage_group.dw_loc_links.Update() //Added by Scofield on 2008-01-03
tab_1.tabpage_group.dw_mg_browse.DeleteRow(0)
tab_1.tabpage_group.dw_mg_browse.Update() //Added by Scofield on 2008-01-03
COMMIT Using sqlca;

//--------Begin added by  Nova 09.27.2010------------------------
//V10.5 SK Group Practice - moved above alfee 11.11.2010


//Start Code Change ----06.26.2014 #V14.2 maha - added option to retrieve for large record sets
if tab_1.tabpage_group.dw_group_tv.rowcount() > 50000 then
	 tab_1.tabpage_group.dw_group_tv.retrieve()
else
	ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ldc_RecID), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
	Parent.SetRedraw( False)
	DO WHILE ll_find > 0
		tab_1.tabpage_group.dw_group_tv.DeleteRow( ll_find)
		ll_find = tab_1.tabpage_group.dw_group_tv.Find("group_multi_loc_rec_id="+String(ldc_RecID), 1, tab_1.tabpage_group.dw_group_tv.RowCount())
		//messagebox("","Loop")//comment by Appeon long.zhang 02.26.2015 (V14.1 and V14.2 Bug # 4422 - Getting a Loop pop-up when deleting a Group)
	LOOP
	Parent.SetRedraw( True)
end if
//end Code Change ----06.26.2014 
//--------End added --------------------------------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-08-10 By: Scofield
//$<Reason> Refresh the detail area's data
ll_CurRow = tab_1.tabpage_group.dw_mg_browse.GetRow()
IF ll_CurRow > 0 And ll_CurRow <= tab_1.tabpage_group.dw_mg_browse.RowCount() THEN
	tab_1.tabpage_group.dw_mg_browse.ScrollToRow(ll_CurRow)
	tab_1.tabpage_group.dw_mg_browse.SelectRow( 0, False )
	tab_1.tabpage_group.dw_mg_browse.SelectRow( ll_CurRow, True )
	ii_mgp_id = tab_1.tabpage_group.dw_mg_browse.GetItemNumber(ll_CurRow, "rec_id")
	tab_1.tabpage_group.dw_mg_browse.Trigger Event RowFocusChanged(ll_CurRow)
ELSE
	tab_1.tabpage_group.dw_mg_detail.Reset()
END IF
//--------------------------- APPEON End------------------------------

IF gb_sk_ver THEN
	inv_ent.of_delete_facility(ldc_RecID)
END IF



end event

type tabpage_loc from userobject within tab_1
event create ( )
event destroy ( )
event ue_init ( )
integer x = 18
integer y = 100
integer width = 4489
integer height = 2436
long backcolor = 16777215
string text = "Locations/Addresses"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
dw_pop dw_pop
uo_loc uo_loc
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
end type

on tabpage_loc.create
this.dw_pop=create dw_pop
this.uo_loc=create uo_loc
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.Control[]={this.dw_pop,&
this.uo_loc,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5}
end on

on tabpage_loc.destroy
destroy(this.dw_pop)
destroy(this.uo_loc)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
end on

event ue_init();//commented by alfee 11.13.2010
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-19
////$<add> 02.09.2006 By: LeiWei
////$<reason> Performance tuning
////$<modification> Copy the following script from the Open event of w_group_practice due
////$<modification> to the usage of CreateOnDemand. Refer to PT-02 for more information.
////$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//
//integer i
//tab_1.tabpage_group.dw_mg_browse.settransobject(sqlca)
//
//i = tab_1.tabpage_group.dw_mg_browse.retrieve()
//IF i > 0 THEN
//	ii_mgp_id = tab_1.tabpage_group.dw_mg_browse.getitemnumber( 1, "rec_id")
//	
//	gnv_appeondb.of_startqueue( )
//	
//	tab_1.tabpage_group.dw_mg_detail.retrieve(ii_mgp_id)
//	tab_1.tabpage_group.dw_loc_links.retrieve(ii_mgp_id)
//
//	gnv_appeondb.of_commitqueue( )
//
//	tab_1.tabpage_group.dw_mg_browse.SelectRow( 0, False )
//	tab_1.tabpage_group.dw_mg_browse.SelectRow( 1, True )
//END IF
////---------------------------- APPEON END ----------------------------
//
end event

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-20
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Call ue_init, since CreateOnDemand is used, some script in Open 
//$<modification> event of w_group_practice is moved to ue_init. Refer to PT-19 for
//$<modification> for more information.

//This.Postevent( "ue_init" )
//---------------------------- APPEON END ----------------------------

end event

type dw_pop from datawindow within tabpage_loc
boolean visible = false
integer x = 3616
integer y = 12
integer width = 133
integer height = 68
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_group_prac_pop"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_loc from pfc_cst_u_locations within tabpage_loc
event destroy ( )
integer x = 5
integer y = 8
integer width = 4489
integer height = 2424
integer taborder = 50
end type

on uo_loc.destroy
call pfc_cst_u_locations::destroy
end on

type ln_2 from line within tabpage_loc
long linecolor = 33554432
integer linethickness = 8
integer beginx = 2606
integer beginy = 3688
integer endx = 2606
integer endy = 3764
end type

type ln_3 from line within tabpage_loc
long linecolor = 33554432
integer linethickness = 8
integer beginx = 2789
integer beginy = 3688
integer endx = 2789
integer endy = 3764
end type

type ln_4 from line within tabpage_loc
long linecolor = 33554432
integer linethickness = 8
integer beginx = 2446
integer beginy = 3688
integer endx = 2446
integer endy = 3764
end type

type ln_5 from line within tabpage_loc
long linecolor = 33554432
integer linethickness = 8
integer beginx = 2263
integer beginy = 3688
integer endx = 2263
integer endy = 3764
end type

type tabpage_assoc from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 4489
integer height = 2436
long backcolor = 16777215
string text = "Associations"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_assoc dw_assoc
end type

on tabpage_assoc.create
this.dw_assoc=create dw_assoc
this.Control[]={this.dw_assoc}
end on

on tabpage_assoc.destroy
destroy(this.dw_assoc)
end on

type dw_assoc from datawindow within tabpage_assoc
integer x = 82
integer y = 64
integer width = 2021
integer height = 2144
integer taborder = 30
string title = "none"
string dataobject = "d_group_loc_assoc_tv"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
//this.retrieve() - commented by alfee 11.13.2010
end event

type cb_close from commandbutton within w_group_practice
integer x = 4174
integer y = 24
integer width = 347
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_viewdoc from commandbutton within w_group_practice
integer x = 2971
integer y = 24
integer width = 425
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Document"
end type

event clicked;//Start Code Change ----10.06.2016 #V153 maha - added
Long ll_row, ll_dcmt_id
String ls_file_name, ls_file_type
u_dw dw_docs

dw_docs = tab_1.tabpage_loc.uo_loc.tab_2.tabpage_docs.dw_docs

ll_row = dw_docs.getrow() 
IF ll_row > 0 THEN
	ll_dcmt_id = dw_docs.GetItemNumber(ll_row, "document_id")
	ls_file_name = dw_docs.GetItemString(ll_row, "doc_name")
	ls_file_type = dw_docs.GetItemString(ll_row, "doc_type")
	IF LeftA(ls_file_type, 1) = '.' THEN ls_file_type = MidA(ls_file_type, 2)
	ls_file_type = Trim(Lower(ls_file_type))
	
	of_view_document(ls_file_name, ls_file_type, ll_dcmt_id, "LOC")
END IF
end event

type cb_addfor from commandbutton within w_group_practice
boolean visible = false
integer x = 2976
integer y = 24
integer width = 416
integer height = 84
integer taborder = 31
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Batch Add Addr"
end type

event clicked;
//OpenWithParm(w_batch_add_address,il_group_id)
OpenWithParm(w_batch_add_address,iuo_loc.il_group_id)
//--------Begin Added by Nova 09.27.2010------------------------
//V10.5 SK Group Practice 
of_refresh_dw_tv(Message.StringParm, iuo_loc.il_group_id)
//--------End Added --------------------------------------------


end event

type st_buttons from statictext within w_group_practice
integer x = 9
integer y = 12
integer width = 4526
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
alignment alignment = right!
boolean border = true
boolean focusrectangle = false
end type

event constructor;this.backcolor = gl_button_bar_color  //Start Code Change ----10.03.2016 #V15 maha
end event

