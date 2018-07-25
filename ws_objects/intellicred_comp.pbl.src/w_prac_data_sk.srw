$PBExportHeader$w_prac_data_sk.srw
forward
global type w_prac_data_sk from w_prac_data_1
end type
type dw_actions from datawindow within tabpage_search
end type
type rb_actions from radiobutton within tabpage_search
end type
type rb_grid from radiobutton within tabpage_search
end type
type gb_2 from groupbox within tabpage_search
end type
type cb_find from commandbutton within w_prac_data_sk
end type
type cb_new from commandbutton within w_prac_data_sk
end type
type rb_prac from radiobutton within w_prac_data_sk
end type
type rb_group from radiobutton within w_prac_data_sk
end type
type gb_1 from groupbox within w_prac_data_sk
end type
type dw_prac_list from u_dw within w_prac_data_sk
end type
type cb_filter from commandbutton within w_prac_data_sk
end type
type cb_refresh from commandbutton within w_prac_data_sk
end type
end forward

global type w_prac_data_sk from w_prac_data_1
integer width = 5376
integer height = 2528
long backcolor = 33551856
cb_find cb_find
cb_new cb_new
rb_prac rb_prac
rb_group rb_group
gb_1 gb_1
dw_prac_list dw_prac_list
cb_filter cb_filter
cb_refresh cb_refresh
end type
global w_prac_data_sk w_prac_data_sk

type variables
//SK Practitioner Folder - alfee 08.31.2010

string is_orig_sql, is_filter
long il_row, il_grouplevel

end variables

forward prototypes
public subroutine of_bg_color (long al_rgb)
public function integer of_locate_tv_search (long al_row, long al_grouplevel)
public function integer of_find_tv_search (long al_facility, long al_prac)
public function integer of_enable_tabpages (boolean ab_flag)
public function integer of_disp_prac_photo (boolean ab_flag)
public function integer of_select_prac_sk ()
public function integer of_setup_title_sk ()
public function integer of_retrieve_tv_search ()
public function integer of_setup_app_tab ()
end prototypes

public subroutine of_bg_color (long al_rgb);this.backcolor = al_rgb
rb_group.backcolor = al_rgb
rb_prac.backcolor =  al_rgb
gb_1.backcolor =  al_rgb

//Start Code Change ----04.07.2016 #V15 maha
tab_1.tabpage_search.rb_actions.backcolor = al_rgb
tab_1.tabpage_search.rb_grid.backcolor =  al_rgb
tab_1.tabpage_search.gb_2.backcolor =  al_rgb

end subroutine

public function integer of_locate_tv_search (long al_row, long al_grouplevel);//Locate in the search treeview datawindow by row and group level 
//SK Practitioner Folder - alfee 08.31.2010

if dw_prac_list.rowcount () < 1 then return -1
if isnull(al_row) or al_row < 1 or al_row > dw_prac_list.rowcount() then return -1
if isnull(al_grouplevel) or al_grouplevel < 1 or al_grouplevel > 2 then return -1

dw_prac_list.collapseall( )
dw_prac_list.expand(al_row, 1)
dw_prac_list.setrow(al_row)
dw_prac_list.scrolltorow(al_row)
dw_prac_list.selecttreenode(al_row, al_grouplevel, true)



end function

public function integer of_find_tv_search (long al_facility, long al_prac);//Find and locate practitioner in the search treeview datawindow based on the facility and prac id
//SK Practitioner Folder - alfee 08.31.2010

long ll_found, ll_grouplevel
string ls_find

ls_find = "parent_facility_id = " + string(al_facility) + " and prac_id = " + string(al_prac)
ll_found = dw_prac_list.find(ls_find, 1, dw_prac_list.rowcount())

if isnull(ll_found) or ll_found < 1 then 
	dw_prac_list.retrieve(gs_user_id) 
	ll_found = dw_prac_list.find(ls_find, 1, dw_prac_list.rowcount())	
end if

if ll_found > 0 then 
	return of_locate_tv_search(ll_found, 2)		
elseif dw_prac_list.rowcount() > 0 then
	return of_locate_tv_search(1, 2)		
end if

return 0


end function

public function integer of_enable_tabpages (boolean ab_flag);//Disable or Enabled tabpages except the Home tabpage
//SK Practitioner Folder - alfee 08.31.2010

tab_1.tabpage_detail.enabled = ab_flag
tab_1.tabpage_app_audit.enabled = ab_flag
tab_1.tabpage_image.enabled = ab_flag
tab_1.tabpage_net.enabled = ab_flag

return 1
end function

public function integer of_disp_prac_photo (boolean ab_flag);//Hide or display prac data and photo
//SK Practitioner Folder - alfee 08.31.2010

if tab_1.selectedtab <> 1 then ab_flag = false //11.16.2010

p_prac_photo.visible = ab_flag
dw_p_data.visible = ab_flag


return 1
end function

public function integer of_select_prac_sk ();//SK Practitioner Folder - alfee 08.31.2010

Integer li_active_status
Integer li_msg_ans
Long ll_seq
long ll_affil_rec 
long ll_wf_id

str_action_item lstr_action
n_cst_workflow_triggers lnv_workflow

IF il_prac_id = 0 or ii_parent_facility_id = 0 or dw_prac_list.getrow() < 1 THEN RETURN -1

//Assign variables
gl_prac_id = il_prac_id
gi_parent_facility = ii_parent_facility_id
gl_data_view_id = il_data_view 
il_prac_id_ori = il_prac_id  
ii_parent_facility_id_ori = ii_parent_facility_id
li_active_status = dw_prac_list.GetItemNumber(dw_prac_list.getrow(), 'active_status')
	
//For inactive record and	user has full rights to appt stat
IF li_active_status = 3  AND w_mdi.of_security_access(120) = 2 THEN

	li_msg_ans = MessageBox("Inactive", "This is an Inactive Appointment record. Do you want to Re-Activate it?", Question!, YesNo!, 2 )
	IF li_msg_ans = 1 THEN
	
		SELECT rec_id INTO:ll_affil_rec FROM pd_affil_stat 
		 WHERE prac_id = :il_prac_id 
			  AND parent_facility_id = :ii_parent_facility_id 
			  AND active_status = 3;			
		
		gnv_appeondb.of_startqueue( )
		UPDATE pd_affil_stat  SET active_status = 1 WHERE rec_id = :ll_affil_rec; 
		UPDATE pd_comm_review SET active_status = 1 WHERE rec_id = :ll_affil_rec; 
		UPDATE pd_affil_dept SET active_status = 1 WHERE rec_id = :ll_affil_rec; 				
		UPDATE pd_affil_staff_cat SET active_status = 1 WHERE rec_id = :ll_affil_rec;
		UPDATE pd_affil_staff_leave SET active_status = 1 WHERE rec_id = :ll_affil_rec;
		SELECT max(seq_no) INTO :ll_seq FROM sys_audit WHERE rec_id = :ll_affil_rec AND field_id = 100000;
		gnv_appeondb.of_commitqueue( )

		if isnull(ll_seq) then ll_seq = 0
		ll_seq++

		gnv_appeondb.of_startqueue( )
		INSERT INTO sys_audit (rec_id,field_id,seq_no,table_id,prac_id,old_value,new_value,user_id,date_time_modified, audit_type,exported,facility_id) VALUES (:ll_affil_rec	,	100000,	:ll_seq,	43,	:il_prac_id,	'3',	'1',	:gs_user_id,	getdate(),	'E',	1,	:ii_parent_facility_id);
		COMMIT USING SQLCA;
		gnv_appeondb.of_commitqueue( )
		
		//work flow		
		If gb_workflow Then 
			lnv_workflow = create n_cst_workflow_triggers
			ll_wf_id = long(gnv_data.of_getitem("facility","facility_wf_practitioner_status_change","facility_id="+string(ii_parent_facility_id)))			
			If not isnull(ll_wf_id) and  ll_wf_id > 0 Then
				lstr_action.prac_id = il_prac_id
				lstr_action.rec_id = ll_affil_rec
				lstr_action.facility_id = ii_parent_facility_id
				lstr_action.wf_id = ll_wf_id
				lstr_action.screen_id = -10
				lnv_workflow.of_workflow_create_action_items(lstr_action)
			end if			 
			if isvalid(lnv_workflow) then destroy lnv_workflow
		end if
	END IF
END IF

//Retrive prac data
of_retrieve_prac()

RETURN 1


end function

public function integer of_setup_title_sk ();//SK Practitioner Folder - alfee 09.02.2010

this.title = ''
if len(is_full_name) > 0 then this.title = is_full_name
if il_prac_id > 0 then this.title += " - " + string( il_prac_id ) 
if len(is_facility_name) > 0 then this.title += "  (" + is_facility_name + ")"
	
return 1
end function

public function integer of_retrieve_tv_search ();//Retrieve data in the search treeview datawindow 
//SK Practitioner Folder - alfee 09.03.2010

//retrieve
dw_prac_list.retrieve(gs_user_id) 

//locate in tree view
if ii_parent_facility_id < 1 or il_prac_id < 1 then
	of_locate_tv_search(1,2) //the first node
else
	of_find_tv_search(ii_parent_facility_id, il_prac_id)
end if
	
return 1
end function

public function integer of_setup_app_tab ();//Start Code Change ----03.29.2012 #V12 maha - modification for Smart to shrink expanded uo
tab_1.tabpage_net.uo_net.dw_orgs_facilities.width = 736
tab_1.tabpage_net.uo_net.cb_batch.width = 731
tab_1.tabpage_net.uo_net.cb_ma.width = 731 //Bug 3375 - alfee 01.08.2013
tab_1.tabpage_net.uo_net.tab_1.x = 759
tab_1.tabpage_net.uo_net.tab_1.tabpage_ai.dw_net_dev.width = 2860 //(2680->2860) Bug 3375 - alfee 01.08.2013
tab_1.tabpage_net.uo_net.tab_1.tabpage_report.dw_report_data.width = 2665
tab_1.tabpage_net.uo_net.st_filter.x = 823
tab_1.tabpage_net.uo_net.dw_qf.x = 1079
tab_1.tabpage_net.uo_net.dw_qf.width = 1029
tab_1.tabpage_net.uo_net.st_group_by.x = 2112
tab_1.tabpage_net.uo_net.ddlb_group_by.x = 2336
tab_1.tabpage_net.uo_net.st_zoom.x = 3022
tab_1.tabpage_net.uo_net.ddlb_zoom.x = 3173


return 1
end function

on w_prac_data_sk.create
int iCurrent
call super::create
this.cb_find=create cb_find
this.cb_new=create cb_new
this.rb_prac=create rb_prac
this.rb_group=create rb_group
this.gb_1=create gb_1
this.dw_prac_list=create dw_prac_list
this.cb_filter=create cb_filter
this.cb_refresh=create cb_refresh
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_find
this.Control[iCurrent+2]=this.cb_new
this.Control[iCurrent+3]=this.rb_prac
this.Control[iCurrent+4]=this.rb_group
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_prac_list
this.Control[iCurrent+7]=this.cb_filter
this.Control[iCurrent+8]=this.cb_refresh
end on

on w_prac_data_sk.destroy
call super::destroy
destroy(this.cb_find)
destroy(this.cb_new)
destroy(this.rb_prac)
destroy(this.rb_group)
destroy(this.gb_1)
destroy(this.dw_prac_list)
destroy(this.cb_filter)
destroy(this.cb_refresh)
end on

event open;call super::open;of_bg_color( gl_bg_color )

end event

event ue_refresh_tv_search;call super::ue_refresh_tv_search;//SK Practitioner Folder - alfee 09.07.2010

return of_retrieve_tv_search()
end event

event pfc_preopen;call super::pfc_preopen;//alfee 10.08.2010

Long ll_i
String ls_scale

If appeongetclienttype() = 'WEB' and gb_autoresize = false Then return

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// The Home tabpage
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
ls_scale = this.inv_resize.scale
FOR LL_I =  1 TO UPPERBOUND(this.tab_1.tabpage_search.CONTrol)	
   this.inv_resize.of_Register (this.tab_1.tabpage_search.CONTrol[LL_I]  , ls_scale )
NEXT

//Start Code Change ----04.07.2016 #V15 maha - removed to repositioaning managed in of_post_resize
//For the modification in the w_prac_data_1 - (Bug 3375) alfee 01.08.2013
//This.inv_resize.of_Register (This.gb_1, ls_scale )
//This.inv_resize.of_Register (This.rb_group, ls_scale )
//This.inv_resize.of_Register (This.rb_prac, ls_scale )
//This.inv_resize.of_Register (This.dw_prac_list, ls_scale )
//This.inv_resize.of_Register (This.cb_refresh, ls_scale )
//This.inv_resize.of_Register (This.cb_filter, ls_scale )
//This.inv_resize.of_Register (This.cb_find, ls_scale )
//This.inv_resize.of_Register (This.cb_new, ls_scale )


end event

event pfc_cst_print_report;//Start Code Change ----12.07.2010 #V10 maha - overwrite for home tab

long Job

//maha 071105 cleaned up and added functioality for each tab where necessary
IF tab_1.SelectedTab = 1 THEN //home
	tab_1.tabpage_search.dw_actions.print()
ELSEIF tab_1.SelectedTab = 2 THEN	//cred data
	Job = PrintOpen() //maha 071105
	//tab_1.tabpage_detail.uo_data_entry.dw_detail.Print()
	PrintScreen(Job, 50,50,7500,5600) //these are positions on the printed page
	PrintClose(Job)
ELSEIF tab_1.SelectedTab = 3 THEN  //app_audit maha 082101
	tab_1.tabpage_app_audit.uo_app_audit.of_Print_list()
ELSEIF tab_1.SelectedTab = 6 THEN //profiles
	tab_1.tabpage_profile.uo_profile.of_Print_Report()
ELSEIF tab_1.SelectedTab = 7 THEN //images
	tab_1.tabpage_image.uo_image.of_Print()
ELSEIF tab_1.SelectedTab = 9 then //application stat
	tab_1.tabpage_net.uo_net.of_gen_report( )
END IF
end event

event resize;call super::resize;//Start Code Change ----04.07.2016 #V15 maha - sk coding

tab_1.tabpage_search.gb_2.x = st_provider_border.x - tab_1.x - 12

tab_1.tabpage_search.gb_2.width = st_provider_border.width
tab_1.tabpage_search.rb_actions.x = tab_1.tabpage_search.gb_2.x + 32
tab_1.tabpage_search.rb_grid.x = tab_1.tabpage_search.rb_actions.x + 500

tab_1.tabpage_search.gb_2.y = st_provider_border.y + st_provider_border.height - tab_1.y - 116
tab_1.tabpage_search.gb_2.height = 140
tab_1.tabpage_search.rb_actions.y = tab_1.tabpage_search.gb_2.y + 52
tab_1.tabpage_search.rb_grid.y = tab_1.tabpage_search.rb_actions.y
tab_1.tabpage_search.rb_actions.height = 64
tab_1.tabpage_search.rb_grid.height = 64

tab_1.tabpage_search.dw_actions.width = st_provider_border.x - 972
tab_1.tabpage_search.dw_actions.height =  tab_1.tabpage_search.height - 24

dw_prac_list.height = st_provider_border.height + 24
cb_refresh.y = dw_prac_list.y + dw_prac_list.height + 24
cb_new.y = cb_refresh.y
cb_filter.y = cb_refresh.y
cb_find.y = cb_refresh.y

end event

type st_provider_border from w_prac_data_1`st_provider_border within w_prac_data_sk
integer y = 264
integer height = 1996
end type

type cb_rehelp from w_prac_data_1`cb_rehelp within w_prac_data_sk
end type

type cb_recred from w_prac_data_1`cb_recred within w_prac_data_sk
end type

type cb_5 from w_prac_data_1`cb_5 within w_prac_data_sk
end type

type cb_4 from w_prac_data_1`cb_4 within w_prac_data_sk
end type

type cb_3 from w_prac_data_1`cb_3 within w_prac_data_sk
end type

type cb_2 from w_prac_data_1`cb_2 within w_prac_data_sk
end type

type pb_home from w_prac_data_1`pb_home within w_prac_data_sk
end type

type dw_red_flag_count from w_prac_data_1`dw_red_flag_count within w_prac_data_sk
end type

type cb_close from w_prac_data_1`cb_close within w_prac_data_sk
end type

type cb_notes from w_prac_data_1`cb_notes within w_prac_data_sk
integer x = 1079
end type

type cb_add from w_prac_data_1`cb_add within w_prac_data_sk
end type

type p_prac_photo from w_prac_data_1`p_prac_photo within w_prac_data_sk
integer x = 4457
integer y = 300
end type

type cb_1 from w_prac_data_1`cb_1 within w_prac_data_sk
integer x = 3182
integer y = 2268
end type

type cb_save from w_prac_data_1`cb_save within w_prac_data_sk
integer x = 27
end type

type cb_addcb from w_prac_data_1`cb_addcb within w_prac_data_sk
end type

type cb_print from w_prac_data_1`cb_print within w_prac_data_sk
integer x = 1426
end type

type cb_next from w_prac_data_1`cb_next within w_prac_data_sk
integer x = 1774
end type

type cb_prior from w_prac_data_1`cb_prior within w_prac_data_sk
integer x = 2112
end type

type cb_b3 from w_prac_data_1`cb_b3 within w_prac_data_sk
integer x = 2469
end type

type cb_b4 from w_prac_data_1`cb_b4 within w_prac_data_sk
integer x = 2816
end type

type cb_b5 from w_prac_data_1`cb_b5 within w_prac_data_sk
end type

type cb_b6 from w_prac_data_1`cb_b6 within w_prac_data_sk
integer x = 3511
end type

type cb_b7 from w_prac_data_1`cb_b7 within w_prac_data_sk
integer x = 3858
end type

type cb_delete from w_prac_data_1`cb_delete within w_prac_data_sk
end type

type uo_app_stat from w_prac_data_1`uo_app_stat within w_prac_data_sk
boolean visible = false
end type

type dw_standing from w_prac_data_1`dw_standing within w_prac_data_sk
end type

type tab_1 from w_prac_data_1`tab_1 within w_prac_data_sk
integer x = 928
integer y = 172
integer width = 4393
integer height = 2232
end type

event tab_1::selectionchanging;//override - SK Practitioner Folder - alfee 09.02.2010

Integer li_retval 
integer li_show //maha 01.01.2011
changedirectory(Gs_Current_Directory)

if dw_prac_list.rowcount() > 0 then    
	//Query images for scanning from Data Entry.
	if newindex = 1 and ib_validate_image then
		if of_validate_image() = 1 then return 1 
	end if
	//Retrieve prac data if a selected prac changed
	if not ib_new_prac and oldindex = 1 and not ib_from_ssn and (ii_parent_facility_id_ori <> ii_parent_facility_id or il_prac_id_ori <> il_prac_id ) then 
	   ib_tab_seleted = true
	   of_select_prac_sk()
	end if
end if 
ib_from_ssn = false

//Save data
if tab_1.tabpage_detail.uo_data_entry.of_get_row_count_detail() > 0 then 	
	if not ib_win_just_opened and oldindex <> 1 then
		li_retval = parent.event pfc_save()	
		if li_retval < 0 then
			return 1
		elseif li_retval = 0 and tab_1.tabpage_detail.uo_data_entry.of_get_row_selector() = 1 and tab_1.tabpage_detail.uo_data_entry.of_is_prac_id_null() and newindex > 3 then
			messagebox("Missing Data", "You must first complete basic information to continue.")
			return 1
		end if
	end if
end if

//Photo visibility - 06.22.2010 #V10 maha
//Start Code Change ----06.22.2010 #V10 maha - photo visibility
if gb_sk_ver or gi_prac_tab = 1 then li_show = 1 //Start Code Change ----01.01.2011 #V11 maha - app sk tab in app

choose case newindex
	case 3,5
		p_prac_photo.visible = false
		dw_p_data.visible = false
		st_provider_border.visible = false //Start Code Change ----04.06.2016 #V15 maha
	case else
		if  newindex > 1 and li_show = 1 then   //Start Code Change ----01.01.2011 #V11 maha - app sk tab in app
			p_prac_photo.visible = false
			dw_p_data.visible = false
			st_provider_border.visible = false //Start Code Change ----04.06.2016 #V15 maha
		elseif newindex > 2 and p_prac_photo.picturename = "nophoto2.jpg" then
			p_prac_photo.visible = false
			dw_p_data.visible = false
			st_provider_border.visible = false //Start Code Change ----04.06.2016 #V15 maha
		else
			p_prac_photo.visible = true
			dw_p_data.visible = true
			st_provider_border.visible = true //Start Code Change ----04.06.2016 #V15 maha
		end if
end choose



end event

event tab_1::selectionchanged;//override - SK Practitioner Folder - alfee 09.03.2010

long ll_Handle

IF oldindex = 1 AND newindex > 1 AND NOT ib_new_prac AND (il_prac_id = 0 OR ii_parent_facility_id = 0) THEN
	SelectTab(1)
	MessageBox("Invalid Selection", "You must first select a group and practitioner.")
	Return -1
END IF

// Set selected flag of tab page
this.Event ue_SetSelectedFlag(NewIndex)

// Invoke ue_SelectionChanging event
this.Event ue_SelectionChanging(OldIndex, NewIndex)

// Set menu and tab page security
//w_mdi.SetRedraw(false)    //Start Code Change ----05.24.2011 #V11 maha - removed for bleedthrough issues
IF appeongetclienttype() = "WEB" THEN w_mdi.SetRedraw(false) //alfee 08.18.2011
this.Event ue_SetSecurity(NewIndex)
w_mdi.SetToolbarPos(2, 1, 200, False)
ll_Handle = Handle(w_mdi)
gnv_appeondll.of_SetToolbarPos(ll_Handle)
IF gb_se_version THEN of_se()
IF appeongetclienttype() = "WEB" THEN w_mdi.SetRedraw(true) //alfee 08.18.2011
//w_mdi.SetRedraw(true)   //Start Code Change ----05.24.2011 #V11 maha - removed for bleedthrough issues

// Update dashboard gadgets
IF NewIndex <> 1 THEN
	IF Not IsValid(gnv_dashboard_data) THEN gnv_dashboard_data = Create n_cst_dashboard_data
	IF ii_parent_facility_id <> 0 THEN
		gnv_dashboard_data.of_update_gadgets_recent('PRAC', il_prac_id, ii_parent_facility_id)
	END IF
END IF

of_button_settings()  //Start Code Change ----10.03.2014 #V14 maha - moved from pfc_cst_after_select

//Auto refresh search
IF NewIndex = 1 and of_get_app_setting("set_49","I") = 10 THEN
	of_retrieve_tv_search()
END IF

// Invoke pfc_cst_after_select event
this.PostEvent("pfc_cst_after_select")
IF NOT ib_new_prac THEN GarbageCollect()

Return 1
end event

event tab_1::pfc_cst_after_select;call super::pfc_cst_after_select;//SK Practitioner Folder - alfee 08.31.2010

if this.SelectedTab = 1 then dw_prac_list.setfocus()

end event

type tabpage_search from w_prac_data_1`tabpage_search within tab_1
integer width = 4357
integer height = 2116
long backcolor = 33551856
string text = "Home"
string picturename = "home.jpg"
dw_actions dw_actions
rb_actions rb_actions
rb_grid rb_grid
gb_2 gb_2
end type

on tabpage_search.create
this.dw_actions=create dw_actions
this.rb_actions=create rb_actions
this.rb_grid=create rb_grid
this.gb_2=create gb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_actions
this.Control[iCurrent+2]=this.rb_actions
this.Control[iCurrent+3]=this.rb_grid
this.Control[iCurrent+4]=this.gb_2
end on

on tabpage_search.destroy
call super::destroy
destroy(this.dw_actions)
destroy(this.rb_actions)
destroy(this.rb_grid)
destroy(this.gb_2)
end on

type uo_search from w_prac_data_1`uo_search within tabpage_search
boolean visible = false
integer x = 1906
integer y = 1552
integer width = 215
integer height = 112
end type

type tabpage_detail from w_prac_data_1`tabpage_detail within tab_1
integer width = 4357
integer height = 2116
string picturename = "DosEdit5!"
end type

type oval_2 from w_prac_data_1`oval_2 within tabpage_detail
end type

type uo_data_entry from w_prac_data_1`uo_data_entry within tabpage_detail
integer height = 2016
end type

type p_face from w_prac_data_1`p_face within tabpage_detail
end type

type tabpage_app_audit from w_prac_data_1`tabpage_app_audit within tab_1
integer width = 4357
integer height = 2116
end type

type uo_app_audit from w_prac_data_1`uo_app_audit within tabpage_app_audit
integer width = 3671
end type

type tabpage_apptmnt_status from w_prac_data_1`tabpage_apptmnt_status within tab_1
boolean visible = false
integer width = 4357
integer height = 2116
end type

type uo_affill_status from w_prac_data_1`uo_affill_status within tabpage_apptmnt_status
end type

type tabpage_verif from w_prac_data_1`tabpage_verif within tab_1
boolean visible = false
integer width = 4357
integer height = 2116
end type

type uo_verif_summary from w_prac_data_1`uo_verif_summary within tabpage_verif
boolean visible = false
end type

type tabpage_profile from w_prac_data_1`tabpage_profile within tab_1
boolean visible = false
integer width = 4357
integer height = 2116
end type

type uo_profile from w_prac_data_1`uo_profile within tabpage_profile
end type

type tabpage_image from w_prac_data_1`tabpage_image within tab_1
integer width = 4357
integer height = 2116
string picturename = "Cascade!"
end type

type uo_image from w_prac_data_1`uo_image within tabpage_image
end type

type tabpage_privileges from w_prac_data_1`tabpage_privileges within tab_1
boolean visible = false
integer width = 4357
integer height = 2116
end type

type uo_priv from w_prac_data_1`uo_priv within tabpage_privileges
end type

type tabpage_net from w_prac_data_1`tabpage_net within tab_1
integer width = 4357
integer height = 2116
end type

type uo_net from w_prac_data_1`uo_net within tabpage_net
integer x = 9
integer width = 3643
integer height = 2120
end type

event uo_net::constructor;call super::constructor;of_setup_app_tab( )
end event

type tabpage_meetings from w_prac_data_1`tabpage_meetings within tab_1
boolean visible = false
integer width = 4357
integer height = 2116
end type

type uo_meetings from w_prac_data_1`uo_meetings within tabpage_meetings
end type

type tabpage_contract from w_prac_data_1`tabpage_contract within tab_1
integer width = 4357
integer height = 2116
end type

type uo_contracts from w_prac_data_1`uo_contracts within tabpage_contract
end type

type dw_tab_buttons from w_prac_data_1`dw_tab_buttons within w_prac_data_sk
end type

type st_tabname from w_prac_data_1`st_tabname within w_prac_data_sk
end type

type dw_p_data from w_prac_data_1`dw_p_data within w_prac_data_sk
integer x = 4512
integer y = 1112
integer width = 686
integer height = 1020
string dataobject = "d_personal_data_app"
boolean vscrollbar = false
end type

type p_buttons from w_prac_data_1`p_buttons within w_prac_data_sk
end type

type st_buttons from w_prac_data_1`st_buttons within w_prac_data_sk
integer y = 12
end type

type dw_actions from datawindow within tabpage_search
integer y = 16
integer width = 3392
integer height = 2096
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_sk_net_dev_action_items"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)

is_orig_sql = this.getsqlselect () //SK Practitioner Folder - alfee 08.31.2010
end event

type rb_actions from radiobutton within tabpage_search
integer x = 3456
integer y = 2028
integer width = 398
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Action Status"
boolean checked = true
end type

event clicked;
//---------Begin Modified by alfee 09.02.2010 --------------
//SK Practitioner Folder
if dw_actions.dataobject = "d_sk_net_dev_action_items" then return

dw_actions.dataobject = "d_sk_net_dev_action_items"
dw_actions.settransobject(sqlca)

is_orig_sql = dw_actions.getsqlselect () 

if il_row >0 and il_grouplevel > 0 then
	dw_prac_list.event treenodeselected(il_row, il_grouplevel)
end if

//dw_actions.dataobject = "d_sk_net_dev_action_items"
//dw_actions.settransobject(sqlca)
//dw_actions.retrieve(gl_prac_id)
//----------End Modified --------------------------------------

end event

type rb_grid from radiobutton within tabpage_search
integer x = 3913
integer y = 2028
integer width = 393
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Process Grid"
end type

event clicked;//---------Begin Modified by alfee 09.02.2010 --------------
//SK Practitioner Folder
if dw_actions.dataobject = "d_pd_appl_tracking_home" then return

dw_actions.dataobject = "d_pd_appl_tracking_home"
dw_actions.settransobject(sqlca)

is_orig_sql = dw_actions.getsqlselect () 

if il_row >0 and il_grouplevel > 0 then
	dw_prac_list.event treenodeselected(il_row, il_grouplevel)
end if

//dw_actions.dataobject = "d_pd_appl_tracking_home"
//dw_actions.settransobject(sqlca)
//dw_actions.retrieve(gl_prac_id)
//----------End Modified --------------------------------------


end event

type gb_2 from groupbox within tabpage_search
integer x = 3410
integer y = 1976
integer width = 937
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
end type

type cb_find from commandbutton within w_prac_data_sk
integer x = 453
integer y = 2312
integer width = 224
integer height = 84
integer taborder = 450
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Find"
end type

event clicked;gs_search lstr_search
integer r
string ls_prac

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "SKS" 

OpenWithParm( w_extended_search_app , lstr_search )
debugbreak()

//----Begin Modified by alfee 08.31.2010 --------------------
//SK Practitioner Folder
long ll_prac, ll_facility
gs_batch_search lst_pracs 

if message.doubleparm < 0 then return -1

lst_pracs = message.powerobjectparm
if upperbound(lst_pracs.li_prac_id[]) < 1 then return -1

ll_facility = lst_pracs.ll_facility[1]
ll_prac = lst_pracs.li_prac_id[1]

of_find_tv_search (ll_facility, ll_prac)

//IF Message.StringParm = "Cancel" THEN
//	Return -1
//ELSE
//	ls_prac = message.stringparm
//	r = dw_prac_list.find( "prac_id = " + ls_prac,1,dw_prac_list.rowcount())
//	if r > 0 then
//		dw_prac_list.setrow(r)
//		dw_prac_list.selectrow(0,false)
//		dw_prac_list.selectrow(r,true)
//		dw_prac_list.scrolltorow(r)
//	end if
//END IF
//----End Modified -----------------------------------------------
end event

type cb_new from commandbutton within w_prac_data_sk
integer x = 677
integer y = 2312
integer width = 224
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "New"
end type

event clicked;//SK Practitioner Folder - alfee 09.06.2010

Integer li_rec_cnt
Integer chk
Integer ssncnt
String ls_demo
String ls_ssn

//Trap for trail version
ls_demo = ProfileString(gs_IniFilePathName, "setup", "demo", "None")
IF ls_demo = "1" THEN
	SELECT Count(prac_id)  
	INTO :li_rec_cnt  
	FROM pd_basic  ;
	IF li_rec_cnt > 10 THEN
		MessageBox("Limit", "You can only have up to 10 records in the trial version.")
		Return -1
	END IF
END IF

//Initialize variables
gl_prac_id = -9
il_prac_id = -9 //(Appeon)Stephen 2013-08-01 - Bug 3622 : Can't add a new provider. 
gi_parent_facility = 0
gl_data_view_id = 2 //?

//Check SSN/NPI when entering new practitioner
chk = of_get_app_setting("set_4","I")
if chk > 0 then 
	openwithparm(w_ssn_check_prac_info, chk) 
	gl_prac_id = message.doubleparm
	if gl_prac_id > 0 then ib_from_ssn = true 
end if

if gl_prac_id = -123 then 
	ib_from_ssn = true
	gs_ssnnpi = ""
	return
end if

//Retrieve and set data
of_retrieve_prac()

Return 0

end event

type rb_prac from radiobutton within w_prac_data_sk
integer x = 439
integer y = 192
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Provider"
end type

event clicked;dw_prac_list.dataobject = "d_tv_search_prac"
dw_prac_list.settransobject(sqlca)
//dw_prac_list.retrieve()
dw_prac_list.setfilter(is_filter) //SK Practitioner Folder - alfee 09.21.2010
of_retrieve_tv_search() //SK Practitioner Folder - alfee 08.31.2010
end event

type rb_group from radiobutton within w_prac_data_sk
integer x = 50
integer y = 192
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Group"
boolean checked = true
end type

event clicked;dw_prac_list.dataobject = "d_tv_search_group"
dw_prac_list.settransobject(sqlca)
//dw_prac_list.retrieve()
dw_prac_list.setfilter(is_filter) //SK Practitioner Folder - alfee 09.21.2010
of_retrieve_tv_search() //SK Practitioner Folder - alfee 08.31.2010


end event

type gb_1 from groupbox within w_prac_data_sk
integer x = 14
integer y = 136
integer width = 896
integer height = 140
integer taborder = 220
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "View By"
end type

type dw_prac_list from u_dw within w_prac_data_sk
event ue_print_practitioner ( )
event ue_print_applications ( )
event ue_print_missing ( )
event ue_print_participation ( )
event ue_print_associations ( )
integer x = 14
integer y = 288
integer width = 891
integer height = 2008
integer taborder = 20
string dataobject = "d_tv_search_group"
boolean hscrollbar = true
end type

event ue_print_practitioner();//////////////////////////////////////////////////////////////////////
// $<event>u_dwue_print_practitioner()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Right Click Functionality on Practitioner Search Screen.
// $<description> 1 New window: w_print_practitioner_verification,1 New structure: str_prac_id.
//////////////////////////////////////////////////////////////////////
// $<add> 10.09.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////

str_prac_id lstr_prac_id

lstr_prac_id.prac_id = this.getitemnumber(this.getrow(),'prac_id')
lstr_prac_id.facility_id = this.getitemnumber(this.getrow(),'parent_facility_id')
lstr_prac_id.view_id=  2//dw_search.getitemnumber(dw_search.getrow(),'data_view_id')
lstr_prac_id.types = 'P'
openwithparm(w_print_practitioner_verification,lstr_prac_id)


end event

event ue_print_applications();//////////////////////////////////////////////////////////////////////
// $<event>u_dwue_print_practitioner()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Right Click Functionality on Practitioner Search Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.10.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
long ll_prac_id

//dw_search.accepttext()
ll_prac_id = this.getitemnumber(this.getrow(),'prac_id')

Open( w_IntelliApp_Print )

w_IntelliApp_Print.uo_print.of_from_prac_folder( ll_prac_id )
w_IntelliApp_Print.uo_print.ib_open_from_prac_folder = True

end event

event ue_print_missing();//////////////////////////////////////////////////////////////////////
// $<event> ue_print_missing()
// $<arguments>
//		value	integer		
// $<returns> 
// $<description> Right Click Functionality on Practitioner Search Screen.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 10.10.2006 by Jack (Inova)
//////////////////////////////////////////////////////////////////////
datastore lds_app_audit_rqrd_data
datastore lds_app_audit_browse
long ll_facility_id,ll_prac_id,ll_rec_id,ll_rowcount

//Start Code Change ---- 05.21.2007 #V7 maha
// corrected error where facility was selected form facility search rather than the selected record causing an application error when the selector is set to ALL.
//ll_facility_id = dw_org_facility_select.getitemnumber(dw_org_facility_select.getrow(),'facility_id')
ll_facility_id = this.getitemnumber(this.getrow(),'parent_facility_id')
//End Code Change---05.21.2007
ll_prac_id = this.getitemnumber(this.getrow(),'prac_id')

lds_app_audit_rqrd_data = create datastore
lds_app_audit_rqrd_data.dataobject = 'd_pd_app_audit_rqrd_data_inova_1'
lds_app_audit_rqrd_data.settransobject(sqlca)

lds_app_audit_browse = create datastore
lds_app_audit_browse.dataobject = 'd_app_audit_browse'
lds_app_audit_browse.settransobject(sqlca)

lds_app_audit_browse.retrieve(ll_prac_id,ll_facility_id)
ll_rec_id = lds_app_audit_browse.GetItemNumber( 1, 'rec_id' )
ll_rowcount = lds_app_audit_rqrd_data.retrieve(ll_rec_id)

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_app_audit_browse) then Destroy lds_app_audit_browse
if IsValid(lds_app_audit_rqrd_data) then Destroy lds_app_audit_rqrd_data
//---------------------------- APPEON END ----------------------------

if ll_rowcount < 1 then
	messagebox('Print Missing Letter','There is no missing info letter to print.')
	return
end if

tab_1.selecttab(3)
parent.event dynamic pfc_cst_compose_request()

end event

event ue_print_participation();//SK Practitioner Folder - alfee 09.07.2010

gs_report_variables lst_arg

lst_arg.as_report_object = "d_rpt_par_numbers_summary_sk"
lst_arg.ai_num_variables = 1
lst_arg.as_var_type[1] = "N"
lst_arg.as_value[1] = string(il_prac_id)

if isvalid(w_report_view) then close(w_report_view)
openwithparm(w_report_view,lst_arg)

if isvalid(w_report_view) and ii_parent_facility_id > 0 then
	w_report_view.uo_report.dw_report.Setfilter("facility_facility_id = " + String(ii_parent_facility_id))
	w_report_view.uo_report.dw_report.filter()
end if
end event

event ue_print_associations();//SK Practitioner Folder - alfee 09.07.2010

gs_report_variables lst_arg

lst_arg.as_report_object = "d_rpt_provider_associations"
lst_arg.ai_num_variables = 1
lst_arg.as_var_type[1] = "N"
lst_arg.as_value[1] = string(il_prac_id)

openwithparm(w_report_view,lst_arg)

end event

event clicked;call super::clicked;//SK Practitioner Folder - alfee 08.31.2010
//this.setrow(row)

string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	if this.isexpanded(lstr_band.row, 1)  then
		this.collapse( lstr_band.row, 1)
	else
		this.expand( lstr_band.row, 1)
	end if
end if


end event

event constructor;this.settransobject(sqlca)

post of_retrieve_tv_search() //SK Practitioner Folder - alfee 08.31.2010
//this.retrieve()


end event

event doubleclicked;//SK Practitioner Folder - alfee 09.03.2010

if il_prac_id > 0 and ii_parent_facility_id > 0 then //child node
	w_prac_data_sk.of_select_prac_sk()	
elseif ii_parent_facility_id > 0 then //parent node (view by group)
	open(w_group_practice)
	if isvalid(w_group_practice) then
		//w_group_practice.of_find_tv_search(ii_parent_facility_id, il_prac_id)
	end if	
else //parent node (view by provider)
	//do nothing
end if
end event

event retrieveend;call super::retrieveend;//----Begin Commented by alfee 09.02.2010 ---------------------
//SK Practitioner Folder

//Integer li_default_data_view_id
//Integer li_found
//String ls_null
//long ll_prac //maha 06.17.10
//long ll_facil //maha 06.24.10
//
//IF This.RowCount() > 0 THEN
//	ll_facil = this.getitemnumber(1,"parent_facility_id")
//	ll_prac = this.getitemnumber(1,"prac_id")
//	if ll_prac > 0 then
//		of_get_photo_data(ll_prac,ll_facil)
//	else
//		of_get_photo_data(0,0)
//	end if
//END IF
//----End Commented ----------------------------------------------
end event

event rowfocuschanged;call super::rowfocuschanged;//commented by alfee 09.01.2010 - SK Practitioner Folder

//long ll_prac
//string ls_PicPath
//string ls_postfix
//string ls_picname

//if currentrow < 1 then return
//
//if currentrow > 0 then
//	this.selectrow(0,false)
//	this.selectrow(currentrow,true)
//	
//	ll_prac = this.getitemnumber( currentrow,"prac_id")
//	il_prac_id = ll_prac
//	gl_prac_id = this.GetItemNumber( currentrow, "prac_id" )
//	gl_data_view_id = 2
//	gi_parent_facility = this.GetItemNumber( currentrow, "parent_facility_id" )
//	
//	of_get_photo_data( ll_prac,gi_parent_facility)
//	tab_1.tabpage_search.dw_actions.retrieve(ll_prac)
//	if tab_1.selectedtab <> 1 then
//		tab_1.selecttab (1)
//	end if
//
//end if
end event

event rbuttonup;integer li_set_iapps,li_num = 0,li_cnt,i
datetime ldt_date_app_audit_completed
long ll_prac_id,ll_action_type,ll_action_status
m_inova_sk			lm_dw

//----Begin Added by alfee 09.08.2010 ----------------
//Select the tree node - SK Practitioner Folder
long ll_grouplevel, ll_row
string  ls_dw_band
str_dw_band lstr_band

ls_dw_band = this.GetBandAtPointer()
lstr_band = of_parse_bandinfo (ls_dw_band)

if lstr_band.band = 'tree.level.1' then 
	ll_grouplevel = 1
elseif lstr_band.band = 'detail' then
	ll_grouplevel = 2
end if
ll_row = lstr_band.row
if ll_grouplevel < 1 or ll_row < 1 then return 0

dw_prac_list.setrow(ll_row)
dw_prac_list.scrolltorow(ll_row)
dw_prac_list.selecttreenode(ll_row, ll_grouplevel, true)

//return if no practitioner selected
if ll_grouplevel = 1 and dw_prac_list.dataobject = 'd_tv_search_group'  then return 0
//-----End Added ----------------------------------------

li_set_iapps = of_get_app_setting("set_iapps","I")

if this.rowcount() < 1 then return 0 //Start Code Change ---- 04.12.2007 #V7 maha trap user error
if this.DataObject = "d_extended_search_list_intelliapp" then return 0 //Start Code Change ---- 04.12.2007 #V7 maha trap user error

ldt_date_app_audit_completed = this.getitemdatetime(this.getrow(),'date_app_audit_completed')
ll_prac_id = this.getitemnumber(this.getrow(),'prac_id')
ll_action_type = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Action Type' and code = 'App Out To MD'"))
ll_action_status = long(gnv_data.of_getitem("code_lookup","lookup_code","lookup_name = 'Action Status' and code = 'Incomplete'"))

SELECT count(net_dev_action_items.rec_id) into :li_num  FROM net_dev_action_items  
WHERE ( net_dev_action_items.prac_id = :ll_prac_id ) AND  
      ( net_dev_action_items.action_type = :ll_action_type ) AND  
      ( net_dev_action_items.action_status = :ll_action_status );


// Create popup menu
lm_dw = Create m_inova_sk
lm_dw.of_SetParent (This)

if li_set_iapps = 1 then
	lm_dw.m_table.m_printapplications.visible = true
else 
	lm_dw.m_table.m_printapplications.visible = false
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05/28/2008 By: Ken.Guo
//$<reason> Fix BugN050704. For w_extended_search_new
//If Not isvalid(iw_prac_folder) Then
//	lm_dw.m_table.m_printmissing.visible = False
//End If
//---------------------------- APPEON END ----------------------------

if not isnull(ldt_date_app_audit_completed) then
	lm_dw.m_table.m_printmissing.enabled = false
else
	lm_dw.m_table.m_printmissing.enabled = true
end if

li_cnt = UpperBound( w_mdi.ii_security_action_id )

FOR i = 1 TO li_cnt
   IF w_mdi.ii_security_action_id[ i ] = 1580 THEN
      IF w_mdi.ii_security_action_value[ i ] = 0 THEN
			lm_dw.m_table.m_printpractitioner.visible = false
			lm_dw.m_table.m_printverification.visible = false
		ELSE
			lm_dw.m_table.m_printpractitioner.visible = true
			lm_dw.m_table.m_printverification.visible = false
      END IF
   END IF  
	//Start Code Change ---- 10.24.2006  maha
//   IF w_mdi.ii_security_action_id[ i ] = 5820 THEN
//      IF w_mdi.ii_security_action_value[ i ] = 0 THEN
//			lm_dw.m_table.m_printsearch.visible = false
//			lm_dw.m_table.m_printsearchpdf.visible = false
//			lm_dw.m_table.m_exportsearch.visible = false
//		ELSE
//			lm_dw.m_table.m_printsearch.visible = true
//			lm_dw.m_table.m_printsearchpdf.visible = false
//			lm_dw.m_table.m_exportsearch.visible = true
//      END IF
//   END IF  
//    IF w_mdi.ii_security_action_id[ i ] = 2000 THEN //save as IntelliBatch
//      IF w_mdi.ii_security_action_value[ i ] = 0 THEN
//		lm_dw.m_table.m_saveresults.visible = false
//	ELSE
//		lm_dw.m_table.m_saveresults.visible = true
//      END IF
//   END IF


NEXT

if li_num < 1 then
	lm_dw.m_table.m_printapplications.enabled = false
	lm_dw.m_table.m_printapplications.text = 'Print Applications (' + string(li_num) + ')'
else
	lm_dw.m_table.m_printapplications.enabled = true
	lm_dw.m_table.m_printapplications.text = 'Print Applications (' + string(li_num) + ')'
end if
//End Code Change---10.24.2006
// Popup menu

//lm_dw.m_table.PopMenu (iw_prac_folder.PointerX() + 5, iw_prac_folder.PointerY() + 210)
lm_dw.m_table.PopMenu ( w_mdi.PointerX(), w_mdi.PointerY() ) //Rodger wu changed on Oct 26, 2006

Destroy lm_dw

Return 1
//---------------------------- APPEON END ----------------------------
end event

event treenodeselected;call super::treenodeselected;//SK Practitioner Folder - alfee 08.31.2010
integer li_selectedtab
string ls_sql, ls_where, ls_table
boolean lb_visible = true

if row < 1 then return

//assign the variables
il_row = row
il_grouplevel = grouplevel
il_data_view = 2 //?
ii_parent_facility_id = this.getitemnumber( row, "parent_facility_id" )
il_prac_id = this.getitemnumber( row,"prac_id")
is_facility_name = this.getitemstring(row, 'facility_facility_name')
is_full_name = this.getitemstring(row, 'v_full_name_full_name')

//set tab pages and get where clause
if tab_1.tabpage_search.dw_actions.dataobject = 'd_sk_net_dev_action_items' then //Action Status
	ls_table = "net_dev_action_items"
else	//Process Grid	- 'd_pd_appl_tracking_home'
	ls_table = "pd_appl_tracking"
end if

choose case grouplevel
	case 1 //parent node
		if this.dataobject = 'd_tv_search_group' then //view by group
			lb_visible = false
			il_prac_id = 0
			is_full_name = ''
			ls_where = " and " + ls_table + ".facility_id  = " + string(ii_parent_facility_id)			
		else //view by provider
			lb_visible = true
			ii_parent_facility_id = 0	
			is_facility_name = ''
			ls_where = " and " + ls_table + ".prac_id = " + string(il_prac_id) 
		end if
		of_enable_tabpages(false)		
	case 2 //child node
		lb_visible = true		
		ls_where = " and " + ls_table + ".prac_id = " + string(il_prac_id) + " and " + ls_table + ".facility_id  = " + string(ii_parent_facility_id)		
		of_enable_tabpages(true)		
end choose

//cancel the new prac mode if a tree node selected
if ib_new_prac then ib_new_prac = false

//get and display photo
of_get_photo_data( il_prac_id, ii_parent_facility_id)
of_disp_prac_photo(lb_visible) 

//retrieve action data
ls_sql = is_orig_sql + ls_where
tab_1.tabpage_search.dw_actions.setsqlselect(ls_sql)
tab_1.tabpage_search.dw_actions.retrieve ()	

//change tab pages
if tab_1.selectedtab <> 1 and not ib_save then 
	li_selectedtab = tab_1.selectedtab
	ib_validate_image = false //disable validation for image scan
    tab_1.selecttab(1)
	if grouplevel =2 then tab_1.selecttab(li_selectedtab)
	ib_validate_image = true
end if

//setup title
of_setup_title_sk()



end event

type cb_filter from commandbutton within w_prac_data_sk
integer x = 229
integer y = 2312
integer width = 224
integer height = 84
integer taborder = 460
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;gs_search lstr_search
gs_batch_search lst_pracs
integer r
string ls_prac  = "( "

//messagebox("Filter","This button needs to be completed")
//	debugbreak()
If this.text = "Filter" then
	lstr_search.stran_transaction = SQLCA
	lstr_search.ls_open_for = "SKF" 
	
	OpenWithParm( w_extended_search_app , lstr_search )

	if message.doubleparm < 0 then
			Return -1
	ELSE
		lst_pracs = message.powerobjectparm
		
		for r = 1 to upperbound(lst_pracs.li_prac_id[])
			ls_prac+=  string(lst_pracs.li_prac_id[r]) + " ,"
		next
		
		ls_prac = left(ls_prac, len(ls_prac) -1) + ")"
		
		//----Begin Modified by alfee 08.31.2010 --------------------
		//Add filter of facilities - SK Practitioner Folder		
		Integer i
		String ls_facilities[], ls_faci = "( "
		for r = 1 to upperbound(lst_pracs.ll_facility[])
			if r = 1 then 
				ls_facilities[1] = string(lst_pracs.ll_facility[r])
			else
				for i = 1 to upperbound(ls_facilities[])
					if ls_facilities[i] = string(lst_pracs.ll_facility[r]) then exit
				next
				if i = upperbound(ls_facilities[]) + 1 then ls_facilities[upperbound(ls_facilities)+ 1] = string(lst_pracs.ll_facility[r])
			end if
		next				
		for i = 1 to upperbound(ls_facilities[])
			ls_faci += string(ls_facilities[i]) + " ,"
		next						
		ls_faci = left(ls_faci, len(ls_faci) -1) + ")"

		is_filter = "prac_id in" + ls_prac + " and parent_facility_id in " + ls_faci
		dw_prac_list.setfilter(is_filter)
		dw_prac_list.filter()
		
		of_locate_tv_search (1,2)
		
		//dw_prac_list.setfilter("prac_id in" + ls_prac)
		//dw_prac_list.filter()
		//-----End Modified -------------------------------------------	
	end if
	this.text = "Clear"
else
	is_filter = ""
	dw_prac_list.setfilter(is_filter)
	dw_prac_list.filter()
	this.text = "Filter"
	of_locate_tv_search (1,2)	//SK Practitioner Folder - alfee 08.31.2010	
end if
	
	
end event

type cb_refresh from commandbutton within w_prac_data_sk
integer x = 5
integer y = 2312
integer width = 224
integer height = 84
integer taborder = 460
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;//SK Practitioner Folder - alfee 09.27.2010

of_retrieve_tv_search()
end event

