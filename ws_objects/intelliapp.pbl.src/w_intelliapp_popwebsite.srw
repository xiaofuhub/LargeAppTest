$PBExportHeader$w_intelliapp_popwebsite.srw
forward
global type w_intelliapp_popwebsite from w_main
end type
type rb_data from radiobutton within w_intelliapp_popwebsite
end type
type rb_ipop from radiobutton within w_intelliapp_popwebsite
end type
type gb_view from groupbox within w_intelliapp_popwebsite
end type
type dw_actions from datawindow within w_intelliapp_popwebsite
end type
type cb_close from commandbutton within w_intelliapp_popwebsite
end type
type tab_1 from tab within w_intelliapp_popwebsite
end type
type tabpage_1 from userobject within tab_1
end type
type dw_app_list from u_dw within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_app_list dw_app_list
end type
type tabpage_2 from userobject within tab_1
end type
type uo_popwebsite from pfc_cst_u_popwebsite within tabpage_2
end type
type tabpage_2 from userobject within tab_1
uo_popwebsite uo_popwebsite
end type
type tab_1 from tab within w_intelliapp_popwebsite
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_intelliapp_popwebsite from w_main
integer width = 4535
integer height = 2604
string title = "IntelliApp Website Form Populating"
long backcolor = 33551856
boolean center = true
rb_data rb_data
rb_ipop rb_ipop
gb_view gb_view
dw_actions dw_actions
cb_close cb_close
tab_1 tab_1
end type
global w_intelliapp_popwebsite w_intelliapp_popwebsite

type variables
long il_status
long il_action_type
long il_complete
end variables

forward prototypes
public function integer of_getapplicationlist (long al_prac_id)
public function integer of_populate (long al_app_id, string as_site_url)
public function integer of_setpage (integer ai_page)
public function integer of_complete_action ()
end prototypes

public function integer of_getapplicationlist (long al_prac_id);//====================================================================
// $<function> of_GetApplicationList()
// $<arguments>
// 	value	long	al_prac_id
// $<returns> integer
// $<description> Get application list
// $<add> (Appeon) evan 11.02.2011
//====================================================================

Long ll_rec_id
Long ll_action_status
Integer li_facility_id
Integer li_app_id
long i, li_nr
long cnt
String ls_full_name
String ls_site_url

gnv_appeondb.of_startqueue()
SELECT v_full_name.full_name
INTO :ls_full_name
FROM v_full_name
WHERE v_full_name.prac_id = :al_prac_id ;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLCODE)
	Return -1
END IF

//Start Code Change ----02.28.2012 #V12 maha - Changed the Action type to App mail Payor
//SELECT lookup_code INTO :ll_action_type FROM code_lookup WHERE lookup_name = 'Action Type' AND code = 'App Out To MD';		
//IF SQLCA.SQLCODE = 100 THEN
//	MessageBox("Error", "You need to add 'App Out To MD' to the Action Type lookup table.")
//	Return -1
//END IF

SELECT lookup_code INTO :il_action_type FROM code_lookup WHERE lookup_name = 'Action Type' AND code = 'App Mail Payor';		
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Error", "You need to add 'App Mail Payor' to the Action Type lookup table.")
	Return -1
END IF


SELECT lookup_code INTO :ll_action_status FROM code_lookup WHERE lookup_name = 'Action Status' AND code = 'Incomplete';
IF SQLCA.SQLCODE = 100 THEN
	MessageBox("Error", "You will need to add 'Incomplete' to the Action Status lookup table.")
	Return -1
END IF

il_status = ll_action_status
//End Code Change ----02.28.2012

gnv_appeondb.of_commitqueue()

//Start Code Change ----02.28.2012 #V12 maha - modifed to use datawindow for completion purposes
// Retrieve application list

cnt = dw_actions.retrieve(al_prac_id, il_action_type, ll_action_status)

//DECLARE lc_apps_to_populate CURSOR FOR  	 
//SELECT net_dev_action_items.rec_id,   
//       net_dev_action_items.facility_id,   
//       net_dev_action_items.app_id,  
//		 app_hdr.site_url
//FROM net_dev_action_items, app_hdr
//WHERE ( net_dev_action_items.app_id = app_hdr.app_id and app_hdr.mapping_type = 2 ) AND
//		( net_dev_action_items.prac_id = :al_prac_id ) AND  
//		( net_dev_action_items.action_type = :ll_action_type ) AND  
//		( net_dev_action_items.action_status = :ll_action_status ) ;
//
//OPEN lc_apps_to_populate;
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Database Error", SQLCA.SQLCODE)
//	Return -1
//END IF	

// Populate application list to datawindow
//FETCH lc_apps_to_populate INTO :ll_rec_id, :li_facility_id, :li_app_id, :ls_site_url ;
//DO WHILE SQLCA.SQLCODE = 0
//	li_nr = tab_1.tabpage_1.dw_app_list.InsertRow( 0 )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "rec_id", ll_rec_id )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_name", ls_full_name )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_id", al_prac_id )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "facility_id", li_facility_id )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "app_id", li_app_id )
//	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "site_url", ls_site_url )
//	FETCH lc_apps_to_populate INTO :ll_rec_id, :li_facility_id, :li_app_id, :ls_site_url ;	
//LOOP
//CLOSE lc_apps_to_populate;

for i = 1 to cnt
	li_nr = tab_1.tabpage_1.dw_app_list.InsertRow( 0 )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "rec_id", dw_actions.getitemnumber(i,"rec_id") )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_name", ls_full_name )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_id", dw_actions.getitemnumber(i,"prac_id") )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "facility_id", dw_actions.getitemnumber(i,"facility_id") )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "app_id",dw_actions.getitemnumber(i,"app_id") )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "site_url", dw_actions.getitemstring(i,"site_url") )
	tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "completed", 0 )
next

tab_1.tabpage_2.uo_popwebsite.cb_complete.visible = true
//End Code Change ----02.28.2012

Return 1
end function

public function integer of_populate (long al_app_id, string as_site_url);//====================================================================
// $<function> of_Populate()
// $<arguments>
// 	value	long		al_app_id
// 	value	string	as_site_url
// $<returns> integer
// $<description> Populate website
// $<add> (Appeon) evan 01.09.2012
//====================================================================

integer li_nr
string ls_prac_id
string ls_facility_id

// Get provider information
ls_prac_id = ProfileString(gs_IniFilePathName, "Setup", "default_practitioner", "None")
ls_facility_id = ProfileString(gs_IniFilePathName, "Setup", "default_parent_facility", "None")

// Populate application list to datawindow
tab_1.tabpage_1.dw_app_list.Reset()
li_nr = tab_1.tabpage_1.dw_app_list.InsertRow( 0 )
//tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "rec_id", ll_rec_id )
//tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_name", ls_full_name )
tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "prac_id", Long(ls_prac_id) )
tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "facility_id", Long(ls_facility_id) )
tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "app_id", al_app_id )
tab_1.tabpage_1.dw_app_list.SetItem( li_nr, "site_url", as_site_url )

// Switch to populating table
tab_1.tabpage_1.Hide()
tab_1.Post SelectTab(2)

Return 1
end function

public function integer of_setpage (integer ai_page);//Start Code Change ----02.14.2012 #V12 maha - added
tab_1.tabpage_2.uo_popwebsite.of_setpage( ai_page)

return 1
end function

public function integer of_complete_action ();//Start Code Change ----03.07.2012 #V12 maha
integer li_skip
integer li_days
integer li_ans
integer li_nr
long ll_rec_id
long ll_rec
long li_find
long ll_find
long ll_prac
long ll_facid
long ll_app_id
long ll_new_app_id
long ll_action_status
long li_row
long ll_loc_id //maha 04.24.2014
Long ll_track_id //Added by Appeon long.zhang 08.30.2017 (Bug id 5784 - Ipop Application duplicating when clicking the Completed button SaaS 15.3 08092017)
string ls_this
long ll_next
string ls_find
date ld_due_date
datetime ldt_comp

ldt_comp = datetime(today(),now())

li_row = tab_1.tabpage_1.dw_app_list.getrow()
if li_row < 1 then Return 0 // Added by Evan on 03.16.2012

tab_1.tabpage_1.dw_app_list.setitem(li_row, "completed", 1)
ll_rec = tab_1.tabpage_1.dw_app_list.getitemnumber(li_row,"rec_id")
li_find = dw_actions.find("rec_id = " + string(ll_rec), 1 , dw_actions.rowcount())
//messagebox("",li_find)
//error traps
if li_find < 0 then
	messagebox("Complete Action function", "Find failure, contact ISG support.")
	return -1
elseif li_find = 0 then
	messagebox("Complete Action function", "Unable to find action record.")
	return -1
end if

//set completion values
dw_actions.setitem(li_find,"action_date", ldt_comp)
dw_actions.setitem(li_find,"action_status",il_complete)
dw_actions.setitem(li_find,"action_user",gs_user_id)

//Start Code Change ----01.06.2015 #V14.2 maha
dw_actions.setitem(li_find,"mod_user",gs_user_id)
dw_actions.setitem(li_find,"mod_date",ldt_comp)
//End Code Change ----01.06.2015

//checkfor next step and create as required
ls_this = gnv_data.of_getitem("app_steps","find step",string(il_action_type)) //finds this step number
if ls_this = "0" then li_skip = 1
ll_next = long(gnv_data.of_getitem("app_steps","next step",ls_this)) //gets the next step number
if ll_next = 0 then  li_skip = 1
if li_skip = 0 then
	ll_prac =  dw_actions.getitemnumber(li_find,"prac_id")
	ll_facid = dw_actions.getitemnumber(li_find,"facility_id")	
	ll_app_id = dw_actions.getitemnumber(li_find,"app_id") 
	ll_loc_id = dw_actions.getitemnumber(li_find,"gp_id") //Start Code Change ----04.24.2014 #V14.2 maha
	ll_track_id = dw_actions.getitemnumber(li_find,"track_id") //Added by Appeon long.zhang 08.30.2017 (Bug id 5784 - Ipop Application duplicating when clicking the Completed button SaaS 15.3 08092017)
	ll_new_app_id = tab_1.tabpage_1.dw_app_list.GetItemNumber(li_row, "app_id") // Added by Evan on 03.16.2012
	
	select count(rec_id) into :ll_find from net_dev_action_items where prac_id = :ll_prac and facility_id = :ll_facid and app_id = :ll_app_id and action_type = :ll_next and active_status = 1;
	
	li_days = integer(gnv_data.of_getitem("app_steps","next days","lookup_code = " + string(ll_next))) //gets the due days //Start Code Change ----10.07.2011 #V12 maha - corrected condition
	if li_days = 0 then li_days = 30

	if ll_find = 0 then //item  does not exist
		if gnv_data.of_getitem("app_steps","auto_gen_next_step","")  = "1" then //Start Code Change ----03.02.2011 #V11 maha - use auto gen setting rather than icred setting
			li_ans = MessageBox( "Process step", "Would you like to add the next process step?", Question!, YesNo!, 1 )
		else //default is yes if not using message
			li_ans = 1
		end if
		if li_ans = 1 then
			ll_action_status = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Incomplete')"))
			li_nr = dw_actions.InsertRow( 0 )
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")	
			ld_due_date = RelativeDate( Today(), li_days )
			dw_actions.SetItem( li_nr, "rec_id", ll_rec_id )
			dw_actions.SetItem( li_nr, "prac_id",ll_prac)
			dw_actions.SetItem( li_nr, "action_type", ll_next)
			dw_actions.SetItem( li_nr, "action_user", gs_user_id )
			dw_actions.SetItem( li_nr, "action_status", ll_action_status ) //incomplete
			dw_actions.SetItem( li_nr, "facility_id",  ll_facid )
			dw_actions.SetItem( li_nr, "app_type", dw_actions.getitemstring(li_find,"app_type") )
			dw_actions.SetItem( li_nr, "app_id", ll_new_app_id /*ll_app_id*/ ) // evan 03.16.2012 --- It should use user selected app id
			dw_actions.SetItem( li_nr, "gp_id", ll_loc_id ) //Added by Appeon long.zhang 08.30.2017 (Bug id 5784 - Ipop Application duplicating when clicking the Completed button SaaS 15.3 08092017)
			dw_actions.SetItem( li_nr, "track_id", ll_track_id ) //Added by Appeon long.zhang 08.30.2017 (Bug id 5784 - Ipop Application duplicating when clicking the Completed button SaaS 15.3 08092017)
			dw_actions.SetItem( li_nr, "due_date", ld_due_date )
			dw_actions.SetItem( li_nr, "active_status", 1 ) 
			dw_actions.SetItem( li_nr,"net_dev_action_items_create_date",datetime(today(),now()))
			dw_actions.SetItem( li_nr,"net_dev_action_items_create_user",gs_user_id)
		end if
	end if //not found
	dw_actions.update()
	of_app_tracking_update(ll_prac,ll_facid,ll_app_id,integer(ls_this),ldt_comp, ll_loc_id)
end if //not skipped

//---------- APPEON BEGIN ----------
//$<add> 04.10.2012 By: Evan
//$<reason> Refresh action list.
//Start Code Change ----03.19.2013 #V12 maha - changed to variable
if li_nr > 0 then
//	if IsValid(w_prac_data_1) then
//		w_prac_data_1.tab_1.tabpage_net.uo_net.triggerevent("pfc_cst_retrieve_detail")
//	elseif IsValid(w_prac_data_intelliapp) then
//		w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.triggerevent("pfc_cst_retrieve_detail")
//	elseif IsValid(w_prac_data_sk) then
//		w_prac_data_sk.tab_1.tabpage_net.uo_net.triggerevent("pfc_cst_retrieve_detail")
//	end if
	gw_prac_data.tab_1.tabpage_net.uo_net.triggerevent("pfc_cst_retrieve_detail")
end if
//End Code Change ----03.19.2013
//---------- APPEON END ------------

debugbreak()

return 1

end function

on w_intelliapp_popwebsite.create
int iCurrent
call super::create
this.rb_data=create rb_data
this.rb_ipop=create rb_ipop
this.gb_view=create gb_view
this.dw_actions=create dw_actions
this.cb_close=create cb_close
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_data
this.Control[iCurrent+2]=this.rb_ipop
this.Control[iCurrent+3]=this.gb_view
this.Control[iCurrent+4]=this.dw_actions
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.tab_1
end on

on w_intelliapp_popwebsite.destroy
call super::destroy
destroy(this.rb_data)
destroy(this.rb_ipop)
destroy(this.gb_view)
destroy(this.dw_actions)
destroy(this.cb_close)
destroy(this.tab_1)
end on

event pfc_preopen;call super::pfc_preopen;//Register controls
this.of_SetResize(True)
inv_resize.of_SetMinSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())
inv_resize.of_SetOrigSize(This.WorkSpaceWidth(),This.WorkSpaceHeight())

inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHT)
inv_resize.of_Register(tab_1, inv_resize.SCALE)
//inv_resize.of_Register(tab_1.tabpage_1.dw_app_list, inv_resize.SCALE)
inv_resize.of_Register(tab_1.tabpage_2.uo_popwebsite, inv_resize.SCALE)
//inv_resize.of_Register(tab_1.tabpage_2.uo_popwebsite.dw_data, inv_resize.SCALEBOTTOM)
//inv_resize.of_Register(tab_1.tabpage_2.uo_popwebsite.ole_browser, inv_resize.SCALERIGHTBOTTOM)

il_complete = Long(gnv_data.of_getitem( 'code_lookup', 'lookup_code', "upper(lookup_name) = upper('Action Status') and upper(code) = upper('Complete')")) //Start Code Change ----03.07.2012 #V12 maha






end event

event resize;call super::resize;tab_1.tabpage_1.dw_app_list.height = tab_1.tabpage_1.height - 45
tab_1.tabpage_1.dw_app_list.width = tab_1.tabpage_1.width - 40
//tab_1.tabpage_2.uo_popwebsite.dw_data.height = tab_1.tabpage_2.height - 156
//tab_1.tabpage_2.uo_popwebsite.ole_browser.height = tab_1.tabpage_2.uo_popwebsite.dw_data.height

 //Start Code Change ----03.06.2017 #V153 maha - moved to user object
//tab_1.tabpage_2.uo_popwebsite.ole_browser.height = tab_1.tabpage_2.height - 156
//tab_1.tabpage_2.uo_popwebsite.dw_data.height = tab_1.tabpage_2.uo_popwebsite.ole_browser.height - 100
//tab_1.tabpage_2.uo_popwebsite.ole_browser.width = tab_1.tabpage_2.width - tab_1.tabpage_2.uo_popwebsite.dw_data.width - 50
tab_1.tabpage_2.uo_popwebsite.of_resize(tab_1.tabpage_2.height, tab_1.tabpage_2.width)
 //End Code Change ----03.06.2017

if SizeType = 2 then
	tab_1.SetRedraw(true)
end if
end event

type rb_data from radiobutton within w_intelliapp_popwebsite
integer x = 2021
integer y = 40
integer width = 402
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Provider Data"
end type

event clicked; //Start Code Change ----03.06.2017 #V153 maha
 integer li_row
 
 tab_1.tabpage_2.uo_popwebsite.ii_switch  = 1
tab_1.tabpage_2.uo_popwebsite.of_switch_interface()
//---------Begin Added by (Appeon)Stephen 05.23.2017 for Bug id 5650 - FW: Bug in new ipop functionality--------
li_row = tab_1.tabpage_1.dw_app_list.getrow()
if li_row < 1 then return
tab_1.tabpage_2.uo_popwebsite.il_prac_id = tab_1.tabpage_1.dw_app_list.getitemnumber(li_row, "prac_id")
tab_1.tabpage_2.uo_popwebsite.il_facility_id = tab_1.tabpage_1.dw_app_list.getitemnumber(li_row, "facility_id") 
//---------End Added ------------------------------------------------------
tab_1.tabpage_2.uo_popwebsite.uo_data_view.of_initiate( tab_1.tabpage_2.uo_popwebsite.il_prac_id, 1, tab_1.tabpage_2.uo_popwebsite.il_facility_id)
end event

type rb_ipop from radiobutton within w_intelliapp_popwebsite
integer x = 1659
integer y = 36
integer width = 265
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "iPop"
boolean checked = true
end type

event clicked; //Start Code Change ----03.06.2017 #V153 maha
tab_1.tabpage_2.uo_popwebsite.ii_switch  = 0
tab_1.tabpage_2.uo_popwebsite.of_switch_interface()
end event

type gb_view from groupbox within w_intelliapp_popwebsite
integer x = 1486
integer width = 1056
integer height = 116
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "View"
end type

type dw_actions from datawindow within w_intelliapp_popwebsite
boolean visible = false
integer x = 1335
integer y = 28
integer width = 142
integer height = 68
integer taborder = 30
string title = "none"
string dataobject = "d_pop_apps_prac"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_close from commandbutton within w_intelliapp_popwebsite
integer x = 4123
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type tab_1 from tab within w_intelliapp_popwebsite
integer x = 14
integer y = 20
integer width = 4480
integer height = 2472
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
//		value	integer	oldindex
//		value	integer	newindex
// $<returns> (None)
// $<description> V12.1 Website Population
// $<add> (Appeon) evan 11.02.2011
//====================================================================

choose case NewIndex
	case 1 //Application list
	case 2 //Populate
		tabpage_2.uo_popwebsite.Event ue_AppChanged()
end choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4443
integer height = 2344
long backcolor = 33551856
string text = "Application Website Form List"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
string picturename = "Form!"
long picturemaskcolor = 536870912
dw_app_list dw_app_list
end type

on tabpage_1.create
this.dw_app_list=create dw_app_list
this.Control[]={this.dw_app_list}
end on

on tabpage_1.destroy
destroy(this.dw_app_list)
end on

type dw_app_list from u_dw within tabpage_1
integer x = 5
integer y = 12
integer width = 3867
integer height = 1864
integer taborder = 11
string dataobject = "d_app_website_list"
end type

event rowfocuschanged;call super::rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event clicked;call super::clicked;this.SetRow(Row)
end event

event constructor;call super::constructor;//====================================================================
// $<event> constructor()
// $<arguments>
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 11.02.2011
//====================================================================

datawindowchild ldwc_app
datawindowchild ldwc_facility

this.GetChild("facility_id", ldwc_facility)
ldwc_facility.SetTransObject( SQLCA )

this.GetChild("app_id", ldwc_app)
ldwc_app.SetTransObject(SQLCA)
ldwc_app.SetFilter("mapping_type = 2")

gnv_appeondb.of_StartQueue()
ldwc_app.Retrieve()
ldwc_facility.Retrieve()
gnv_appeondb.of_CommitQueue()

this.of_SetUpdateable(false)
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event> doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 11.03.2011
//////////////////////////////////////////////////////////////////////

if Row > 0 then
	tab_1.SelectTab(2)
end if
end event

event itemchanged;call super::itemchanged;long ll_Row
datawindowchild ldwc_app

this.AcceptText()
this.GetChild("app_id", ldwc_app)
ll_Row = ldwc_app.GetRow()
this.SetItem(Row, "site_url", ldwc_app.GetItemString(ll_Row, "site_url"))
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 4443
integer height = 2344
long backcolor = 33551856
string text = "Populate"
long tabtextcolor = 33554432
long tabbackcolor = 33551856
string picturename = "RunReport5!"
long picturemaskcolor = 536870912
uo_popwebsite uo_popwebsite
end type

on tabpage_2.create
this.uo_popwebsite=create uo_popwebsite
this.Control[]={this.uo_popwebsite}
end on

on tabpage_2.destroy
destroy(this.uo_popwebsite)
end on

type uo_popwebsite from pfc_cst_u_popwebsite within tabpage_2
integer width = 4448
integer height = 2348
integer taborder = 20
boolean bringtotop = true
boolean border = true
end type

on uo_popwebsite.destroy
call pfc_cst_u_popwebsite::destroy
end on

