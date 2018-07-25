$PBExportHeader$w_batch_privilege_update.srw
forward
global type w_batch_privilege_update from w_master
end type
type st_prac from statictext within w_batch_privilege_update
end type
type st_browse from statictext within w_batch_privilege_update
end type
type cb_delete from commandbutton within w_batch_privilege_update
end type
type dw_copy_all from datawindow within w_batch_privilege_update
end type
type dw_1 from u_dw within w_batch_privilege_update
end type
type cb_report from commandbutton within w_batch_privilege_update
end type
type cbx_roll from checkbox within w_batch_privilege_update
end type
type cb_add from commandbutton within w_batch_privilege_update
end type
type cb_4 from commandbutton within w_batch_privilege_update
end type
type dw_pracs from datawindow within w_batch_privilege_update
end type
type dw_facility from datawindow within w_batch_privilege_update
end type
type cb_up from commandbutton within w_batch_privilege_update
end type
type cb_2 from commandbutton within w_batch_privilege_update
end type
type st_3 from statictext within w_batch_privilege_update
end type
type st_2a from statictext within w_batch_privilege_update
end type
type st_1a from statictext within w_batch_privilege_update
end type
type dw_status from datawindow within w_batch_privilege_update
end type
type em_to from editmask within w_batch_privilege_update
end type
type em_from from editmask within w_batch_privilege_update
end type
type gb_3 from groupbox within w_batch_privilege_update
end type
type gb_2 from groupbox within w_batch_privilege_update
end type
type gb_f from groupbox within w_batch_privilege_update
end type
type dw_browse from u_dw within w_batch_privilege_update
end type
type st_mess from statictext within w_batch_privilege_update
end type
type rb_one from radiobutton within w_batch_privilege_update
end type
type rb_all from radiobutton within w_batch_privilege_update
end type
type rb_recred from radiobutton within w_batch_privilege_update
end type
type rb_update from radiobutton within w_batch_privilege_update
end type
type cbx_hist from checkbox within w_batch_privilege_update
end type
type gb_1 from groupbox within w_batch_privilege_update
end type
type cb_sort from commandbutton within w_batch_privilege_update
end type
type dw_copy from datawindow within w_batch_privilege_update
end type
end forward

global type w_batch_privilege_update from w_master
integer x = 14
integer y = 96
integer width = 4864
integer height = 2140
string title = "Privilege Batch Update"
boolean maxbox = false
windowtype windowtype = popup!
long backcolor = 33551856
st_prac st_prac
st_browse st_browse
cb_delete cb_delete
dw_copy_all dw_copy_all
dw_1 dw_1
cb_report cb_report
cbx_roll cbx_roll
cb_add cb_add
cb_4 cb_4
dw_pracs dw_pracs
dw_facility dw_facility
cb_up cb_up
cb_2 cb_2
st_3 st_3
st_2a st_2a
st_1a st_1a
dw_status dw_status
em_to em_to
em_from em_from
gb_3 gb_3
gb_2 gb_2
gb_f gb_f
dw_browse dw_browse
st_mess st_mess
rb_one rb_one
rb_all rb_all
rb_recred rb_recred
rb_update rb_update
cbx_hist cbx_hist
gb_1 gb_1
cb_sort cb_sort
dw_copy dw_copy
end type
global w_batch_privilege_update w_batch_privilege_update

type variables
integer ii_facil
long il_status
long il_prac
long il_prac_list[]
long il_req
string is_type
string is_ret_type
end variables

forward prototypes
public function integer of_retrieve_data (string as_type)
public function integer of_reapp_set (date ad_from, date ad_to)
public function integer of_filter_data ()
end prototypes

public function integer of_retrieve_data (string as_type);integer i
integer ic
integer xq

//gnv_appeondb.of_startqueue( ) - commented by alfee 07.19.2013
dw_copy.reset()

//Start Code Change ----11.26.2007 #V8 maha  - reworked code
if as_type = "R" then //reapprove
	dw_browse.setredraw(false)	
	//dw_browse.setfilter('prac_id='+string(il_prac) + ' and pd_priv_list_status_code = ' + string(il_req))
	dw_browse.setfilter('prac_id='+string(il_prac) + ' and status_code = ' + string(il_req)) //The filter expression is invalid. - Evan 11.24.2010
	dw_browse.filter()
	dw_browse.setredraw(true)
	dw_browse.title = " Privileges Requested"	
	dw_copy.retrieve(il_prac,ii_facil)
else //"Update"
	dw_browse.setredraw(false)
	dw_browse.setfilter('prac_id='+string(il_prac) )
	dw_browse.filter()
	dw_browse.setredraw(true)
end if
//End Code Change---11.26.2007
//gnv_appeondb.of_commitqueue( ) -  - commented by alfee 07.19.2013


return 1
end function

public function integer of_reapp_set (date ad_from, date ad_to);//Start Code Change ---- 11.26.2007 #V7 maha new function
//used to update the records for the reapp process only
integer i

for i = 1 to dw_browse.rowcount() //set current records (requested)
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 11.06.2015
	//<$>reason:V14.2 Applause Bug # 4832 - Privilege Batch Update if you hit space bar when in date field, it will put the 01/01/1900 date in
	//if not em_from.text = "" then dw_browse.setitem(i,"start_date",ad_from)
	//if not em_to.text = "" then dw_browse.setitem(i,"end_date",ad_to)
	if IsDate(em_from.text) then dw_browse.setitem(i,"start_date",ad_from)
	if IsDate(em_to.text) then dw_browse.setitem(i,"end_date",ad_to)
	//------------------- APPEON END -------------------
	if not il_status = 1 then dw_browse.setitem(i,"status_code",il_status)
next

for i = 1 to dw_copy.rowcount()  //send orig records to history (all non-requested)
	dw_copy.setitem(i,"active_status",0)
next			

for i = 1 to dw_copy_all.rowcount() 
	dw_copy_all.setitem(i,"active_status",0)  //alfee 07.19.2013
next			

return 1
end function

public function integer of_filter_data ();//====================================================================
//$<Function>: of_filter_data()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Filter data in dw_browse and dw_copy_all 
//$<Author>: (Appeon) Alfee 07.19.2013 
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>: Copied and modified from of_retrieve_data ()
//====================================================================
dw_browse.setredraw(false)	
dw_browse.setfilter('prac_id='+string(il_prac) + ' and status_code = ' + string(il_req))
dw_browse.filter()
dw_browse.setredraw(true)
dw_browse.title = " Privileges Requested"	

dw_copy_all.setfilter('prac_id='+string(il_prac))
dw_copy_all.filter()

return 1
end function

on w_batch_privilege_update.create
int iCurrent
call super::create
this.st_prac=create st_prac
this.st_browse=create st_browse
this.cb_delete=create cb_delete
this.dw_copy_all=create dw_copy_all
this.dw_1=create dw_1
this.cb_report=create cb_report
this.cbx_roll=create cbx_roll
this.cb_add=create cb_add
this.cb_4=create cb_4
this.dw_pracs=create dw_pracs
this.dw_facility=create dw_facility
this.cb_up=create cb_up
this.cb_2=create cb_2
this.st_3=create st_3
this.st_2a=create st_2a
this.st_1a=create st_1a
this.dw_status=create dw_status
this.em_to=create em_to
this.em_from=create em_from
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_f=create gb_f
this.dw_browse=create dw_browse
this.st_mess=create st_mess
this.rb_one=create rb_one
this.rb_all=create rb_all
this.rb_recred=create rb_recred
this.rb_update=create rb_update
this.cbx_hist=create cbx_hist
this.gb_1=create gb_1
this.cb_sort=create cb_sort
this.dw_copy=create dw_copy
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_prac
this.Control[iCurrent+2]=this.st_browse
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.dw_copy_all
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.cb_report
this.Control[iCurrent+7]=this.cbx_roll
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.dw_pracs
this.Control[iCurrent+11]=this.dw_facility
this.Control[iCurrent+12]=this.cb_up
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.st_3
this.Control[iCurrent+15]=this.st_2a
this.Control[iCurrent+16]=this.st_1a
this.Control[iCurrent+17]=this.dw_status
this.Control[iCurrent+18]=this.em_to
this.Control[iCurrent+19]=this.em_from
this.Control[iCurrent+20]=this.gb_3
this.Control[iCurrent+21]=this.gb_2
this.Control[iCurrent+22]=this.gb_f
this.Control[iCurrent+23]=this.dw_browse
this.Control[iCurrent+24]=this.st_mess
this.Control[iCurrent+25]=this.rb_one
this.Control[iCurrent+26]=this.rb_all
this.Control[iCurrent+27]=this.rb_recred
this.Control[iCurrent+28]=this.rb_update
this.Control[iCurrent+29]=this.cbx_hist
this.Control[iCurrent+30]=this.gb_1
this.Control[iCurrent+31]=this.cb_sort
this.Control[iCurrent+32]=this.dw_copy
end on

on w_batch_privilege_update.destroy
call super::destroy
destroy(this.st_prac)
destroy(this.st_browse)
destroy(this.cb_delete)
destroy(this.dw_copy_all)
destroy(this.dw_1)
destroy(this.cb_report)
destroy(this.cbx_roll)
destroy(this.cb_add)
destroy(this.cb_4)
destroy(this.dw_pracs)
destroy(this.dw_facility)
destroy(this.cb_up)
destroy(this.cb_2)
destroy(this.st_3)
destroy(this.st_2a)
destroy(this.st_1a)
destroy(this.dw_status)
destroy(this.em_to)
destroy(this.em_from)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_f)
destroy(this.dw_browse)
destroy(this.st_mess)
destroy(this.rb_one)
destroy(this.rb_all)
destroy(this.rb_recred)
destroy(this.rb_update)
destroy(this.cbx_hist)
destroy(this.gb_1)
destroy(this.cb_sort)
destroy(this.dw_copy)
end on

event open;call super::open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent
gs_batch_search lst_search

lst_sent = message.powerobjectparm
ll_pracs[] = lst_sent.li_prac_id[]
//if upperbound(ll_pracs[]) < 0 then return

	//Start Code Change ----01.28.2015 #V14.2 maha - modified code for new choice window
if upperbound(ll_pracs[]) = 0 then //this is when opened from system-> batch update
	open(w_practitioner_filter_choice_new)
	if message.stringparm = "C" then  //cancel
		close(this)
		return -1
	else 
		lst_search = message.powerobjectparm
		ll_pracs[] = lst_search.li_prac_id
	end if
	//End Code Change ----01.28.2015
else //this is when the screen is opened from the prac folder
 	li_type = lst_sent.ll_app[1]
	li_facility_id = lst_sent.ll_facility[1]
	il_prac = lst_sent.li_prac_id[1]  //Start Code Change ----04.23.2008 #V8 maha
	
end if

//Start Code Change ----11.27.2007 #V8 maha modification and cleanup of code
il_prac_list[] = ll_pracs[]  

if li_type = 1 then
	is_type = "R"
	dw_browse.dataobject = "d_priv_batch_browse_all"
elseif li_type = 2 then
	is_type = "U"
	dw_browse.dataobject = "d_priv_update_list_d_entry_all"
else
	is_type = "R"
	dw_browse.dataobject = "d_priv_batch_browse_all"
end if
//messagebox("",is_type)

gnv_appeondb.of_startqueue( )

dw_browse.settransobject(sqlca)
dw_facility.settransobject(sqlca)
dw_facility.getchild("facility_facility_id",dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//dw_facility.retrieve(gs_user_id)
dw_facility.insertrow(1)
if li_facility_id < 1 or isnull(li_facility_id) then
	li_facility_id=integer(gnv_data.of_getitem("security_users","default_search_facility","upper(user_id)='"+upper(gs_user_id)+"'"))
end if

dw_pracs.settransobject(sqlca)
if UpperBound(ll_pracs[]) > 0 then //Add by Evan on 11.25.2010
	p = dw_pracs.retrieve(ll_pracs[])
end if

IF Not IsNull( li_facility_id ) and li_facility_id > 0 THEN //set user default facility
	dw_facility.SetItem( 1, "facility_facility_id", li_facility_id )
	ii_facil = li_facility_id
	//dw_browse.retrieve(ii_facil, ll_pracs[]) don't retrieve here; wil be retrieved in trigger event below
END IF

gnv_appeondb.of_commitqueue( )

//dw_facility.insertrow(1) //Start Code Change ----03.25.2008 #V8 maha - moved up before default set

if p > 0 then
	il_prac = dw_pracs.getitemnumber(1,"prac_id")
	dw_pracs.selectrow(1,true)
end if

il_req = long(gnv_data.of_getitem('code_lookup','lookup_code',"upper(lookup_name) = 'PRIVILEGE STATUS'  and upper(code) = 'REQST'"))

if il_req < 19 then
	messagebox("Lookup table error", "Unable to find the Requested Status Record.  No data will be updatable.~rCheck your Privilege Status lookup table for a record with the code of 'REQST' ")
end if
//End Code Change---11.27.2007

//set radio buttons
if dw_pracs.rowcount() > 1 then
	rb_all.checked = true
	rb_one.checked = false
elseif dw_pracs.rowcount() = 1 then
	rb_all.checked = false
	rb_all.enabled = false
	rb_one.checked = true
else
	rb_all.checked = false
	rb_one.checked = false
end if

if is_type = "U" then
	rb_update.checked = true
	rb_update.triggerevent(clicked!)
elseif is_type = "R" then
	rb_recred.checked = true
	rb_recred.triggerevent(clicked!)
end if

if w_mdi.of_security_access(7784) = 0 then cb_delete.visible = false   //Start Code Change ----10.08.2015 #V15 maha 

end event

event closequery;//no message
end event

event close;call super::close;//Start Code Change ----03.19.2013 #V12 maha
//if isvalid(w_prac_data_1) then
//	w_prac_data_1.tab_1.tabpage_privileges.uo_priv.of_Retrieve_priv( gl_prac_id )
//end if
if isvalid(gw_prac_data) then
	gw_prac_data.tab_1.tabpage_privileges.uo_priv.of_Retrieve_priv( gl_prac_id )
end if
//End Code Change ----03.19.2013
end event

event resize;
long ll_wid
long ll_hig
long ll_seg


ll_wid = this.workspacewidth( ) - 20
ll_hig = this.workspaceheight( ) 

ll_seg =  ll_wid/5 

dw_pracs.height = ll_hig - dw_pracs.y - 10
dw_browse.height = dw_pracs.height

dw_pracs.width = ll_seg
dw_browse.width = ll_seg * 4 
dw_browse.x = dw_pracs.width + 20

st_prac.width = ll_seg
st_browse.width = dw_browse.width

st_browse.x = dw_browse.x



end event

type st_prac from statictext within w_batch_privilege_update
integer x = 5
integer y = 472
integer width = 795
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Select Provider"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_browse from statictext within w_batch_privilege_update
integer x = 809
integer y = 472
integer width = 4000
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Requested Privileges"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_batch_privilege_update
integer x = 3319
integer y = 64
integer width = 393
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Selected"
end type

event clicked;integer res
integer r
integer cnt

res = Messagebox("Delete Privileges","Are you sure you wish to delete the selected records?", question!,yesno!,2)

if res = 2 then return

res = Messagebox("Delete Privileges","Are you Positive?", question!,yesno!,2)

if res = 2 then return

for r = dw_browse.rowcount()  to 1 step -1
	if dw_browse.getitemnumber(r,"selected") = 1 then
		dw_browse.deleterow(r)
		cnt ++
	end if
next

dw_browse.update()

Messagebox("Delete Privileges", string(cnt) + " Records Deleted.")
end event

type dw_copy_all from datawindow within w_batch_privilege_update
boolean visible = false
integer x = 805
integer y = 2156
integer width = 2382
integer height = 192
integer taborder = 130
boolean bringtotop = true
string dataobject = "d_priv_batch_browse_copy_all"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_1 from u_dw within w_batch_privilege_update
boolean visible = false
integer x = 2779
integer y = 2160
integer width = 581
integer height = 92
integer taborder = 150
end type

type cb_report from commandbutton within w_batch_privilege_update
integer x = 3717
integer y = 64
integer width = 352
integer height = 84
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print Report"
end type

event clicked;openwithparm(w_renew_priv_form,il_prac)
end event

type cbx_roll from checkbox within w_batch_privilege_update
boolean visible = false
integer x = 3127
integer y = 2160
integer width = 325
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 67108864
string text = "Rollover"
end type

type cb_add from commandbutton within w_batch_privilege_update
integer x = 2953
integer y = 64
integer width = 361
integer height = 84
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Privileges"
end type

event clicked;dw_browse.triggerevent("pfc_addrow")
end event

type cb_4 from commandbutton within w_batch_privilege_update
integer x = 4073
integer y = 64
integer width = 352
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;//openwithparm(w_help_window,1)
//Start Code Change ----02.13.2013 #V12 maha - changed to messagebox
string ls_mes

ls_mes = "The Privilege Update Window is for the updating of batch privileges in two ways:~r~r"
ls_mes += "1)Batch updating status and dates of individually selected privileges, including sending to history.~r~r"
ls_mes += "2)Batch updating as part of the reappointment process, where REQUESTED privileges are updated to the indicated status and dates and all other existing privileges are set as history.~r~r"
ls_mes += "When using the Reapproval update process from an IntelliBatch list or the Return from Committee function, practitioners can be updated individually, or batch processed for the whole list.~r~r"
ls_mes += "The Privilege Batch Update window can also be opened from the menu System->Batch Updates->Privilege Updates where a single practitioner, an IntelliBatch List or a Practitioner Batch Search can be selected.~r~r"
ls_mes += "When opened for a single practitioner, the Practitioner Update Individual button is checked.  When opened for a batch of Practitioners the Practitioner Update All button is enabled. ~r~r" 
ls_mes += "If Individual is selected, the update process will run for only the selected practitioner.  If All is selected for Reapproval, the Update process will scan through the list of practitioners and update each one.  ~r~r" 
ls_mes += "All cannot be selected for the Batch Update function as this function requires individual records to be selected.~r~r"
ls_mes += "Privileges can be added from this screen as well, by clicking the Add Privileges button and selecting the desired Clinical Area and Privileges. ~r~r"
ls_mes += "The Reapproval process is run once Requested privileges have been approved.  This process will make all the privileges with a status other than 'Requested' historical records, and update the Requested status privileges to the indicated status.~r~r"
ls_mes += "This process allows one set of Granted privileges to remain active while the Requested privileges from the next Appointment cycle are in the approval process.  ~r~r"


messagebox("Privilege Updates",ls_mes)
end event

type dw_pracs from datawindow within w_batch_privilege_update
integer y = 564
integer width = 800
integer height = 1464
integer taborder = 10
string title = "Select Practitoner"
string dataobject = "d_practitioner_list"
boolean livescroll = true
end type

event clicked;integer r

r  = this.getclickedrow()
if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

il_prac = this.getitemnumber(r,"prac_id")
//dw_browse.settransobject(sqlca)
//dw_browse.retrieve(il_prac,ii_facil)
of_retrieve_data(is_ret_type)
end event

event rowfocuschanged;
//debugbreak()

end event

event retrieveend;//debugbreak()
//if this.rowcount() > 0 then
//	//this.selectrow(0,false)
//	//this.selectrow(1,true)
//	il_prac = this.getitemnumber(1,"prac_id")
//	//of_retrieve_data("R")
//	//messagebox("rc",string(dw_browse.rowcount()))
//	dw_browse.setredraw(true)
//end if
end event

type dw_facility from datawindow within w_batch_privilege_update
integer x = 73
integer y = 276
integer width = 805
integer height = 84
integer taborder = 70
string dataobject = "d_facility_users_batch"
boolean border = false
boolean livescroll = true
end type

event itemchanged;ii_facil = integer(data)

//Start Code Change ----11.027.2007 #V8 maha
IF  ii_facil > 0 THEN 
	dw_browse.retrieve(ii_facil, il_prac_list[] )
	of_retrieve_data(is_ret_type)
end if
//End Code Change---11.27.2007


end event

type cb_up from commandbutton within w_batch_privilege_update
integer x = 1710
integer y = 64
integer width = 352
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;date ld_from
date ld_to
integer i
integer rc
integer res
long p
long pcnt
long rcnt
long ll_pracs[]
String ls_status //Ken.Guo 03.14.2008

 //Start Code Change ---- 11.26.2007 #V7 maha  remodified to correct issues created by performance enhancement
dw_browse.SetRedraw(False)

ld_from = date(em_from.text)
ld_to = date(em_to.text)

//Start Code Change ----10.08.2015 #V15 maha - bypass checks for send to history
if cbx_hist.checked then
	//skip the field checks
else
	if  ii_facil < 1 then
		messagebox("User Select Error","You must select a facility to run this function.")
		dw_browse.SetRedraw(True) //Start Code Change ----01.02.2008 #V8 maha - added redraw on trap
		return
	end if
	//------------------------------appeon begin----------------------
	//<$>Modified: long.zhang 10.30.2012
	//<$>reason:For an issue of optout status update BugL101901 
	//if  il_status < 1 then
	//	messagebox("Missing Value","You must have a Status.")
	//	dw_browse.SetRedraw(True)  //Start Code Change ----01.02.2008 #V8 maha - added redraw on trap
	//	return
	//end if
	
//Start Code Change ----02.03.2016 #V152 maha - added option for status
//	if isNull(dw_status.getitemnumber( 1,"status_code")) then
//			messagebox("Missing Value","You must have a Status.")
//			dw_browse.SetRedraw(True)  //Start Code Change ----01.02.2008 #V8 maha - added redraw on trap
//			return
//	end if
		//--------------------------appeon end------------------------------
	if isNull(dw_status.getitemnumber( 1,"status_code")) then
		res = messagebox("Missing Value","Your have not entered a Status code.  Do you want to update without the Status value?",Question!,yesno!,2)	
		if res = 2 then 
			dw_browse.SetRedraw(True)  //Start Code Change ----01.02.2008 #V8 maha - added redraw on trap
			return	
		end if 
	end if
//Start Code Change ----02.03.2016		

	
	if isdate(em_from.text) = false or isdate(em_to.text) = false  then
		res = messagebox("Missing Value","Your Start Date or End Date value is missing.  Do you want to update without the date value?",Question!,yesno!,2)	
		if res = 2 then 
			dw_browse.SetRedraw(True)  //Start Code Change ----01.02.2008 #V8 maha - added redraw on trap
			return	
		end if
	end if
end if
//End Code Change ----10.08.2015 


for i = 1 to dw_pracs.rowcount()
	ll_pracs[i] = dw_pracs.getitemnumber(i,"prac_id") //Start Code Change ----01.02.2008 #V8 maha - corrected variable
next

SetPointer (HourGlass!) //alfee 07.19.2013

//gnv_appeondb.of_startqueue( ) - commented by alfee 07.19.2013	
if rb_all.checked then  //reapp only
	dw_copy_all.retrieve (ll_pracs, ii_facil) //alfee 07.19.2013
	for p = 1 to dw_pracs.rowcount()
		il_prac = dw_pracs.getitemnumber(p,"prac_id")
		dw_pracs.scrolltorow(p)
		dw_pracs.selectrow(0,false)
		dw_pracs.selectrow(p,true)
		of_filter_data() //of_retrieve_data("R")  - alfee 07.19.2013
		//gnv_appeondb.of_commitqueue( ) //stephen 10.19.2011 - Bug 2750 - commented by alfee 07.19.2013
		if dw_browse.rowcount() > 0 then 
			pcnt++
			of_reapp_set(ld_from,ld_to)
			//dw_copy.update() - commented by alfee 07.19.2013
		end if
		Yield ()  //alfee 07.19.2013
	next
	res= dw_browse.update()
	res= dw_copy_all.update() //alfee 07.19.2013
	commit using sqlca;
else //single prac
	rc = dw_browse.rowcount()
	if rc < 1 then 
		//gnv_appeondb.of_commitqueue( ) - commented by alfee 07.19.2013
		return
	end if
	if rb_update.checked then //update
		pcnt++
		for i = 1 to rc
			if dw_browse.getitemnumber(i,"selected") = 1 then
				//------------------- APPEON BEGIN -------------------
				//<$>added:long.zhang 11.06.2015
				//<$>reason:V14.2 Applause Bug # 4832 - Privilege Batch Update if you hit space bar when in date field, it will put the 01/01/1900 date in
				//if not em_from.text = "" then dw_browse.setitem(i,"start_date",ld_from)
				//if not em_to.text = "" then dw_browse.setitem(i,"end_date",ld_to)
				if IsDate(em_from.text) then dw_browse.setitem(i,"start_date",ld_from)
				if IsDate(em_to.text) then dw_browse.setitem(i,"end_date",ld_to)
				//------------------- APPEON END -------------------
				//--------------------------- APPEON BEGIN ---------------------------
				//$<modify> 03/14/2008 By: Ken.Guo
				//$<reason> Refresh code_lookup_code column's value.
				//if not il_status = 1 then dw_browse.setitem(i,"status_code",il_status)
				//If not il_status = 1 Then 
				If il_status > 0 Then  //Start Code Change ----10.08.2015 #V15 maha - replaced line 
					ls_status = gnv_data.of_getitem("code_lookup","code","lookup_code = " + String(il_status) )
					dw_browse.setitem(i,"status_code",il_status)
					//dw_browse.setitem(i,"code_lookup_code",ls_status) //Refresh synchronously display value.
				End If
				//---------------------------- APPEON END ----------------------------
				if cbx_hist.checked then dw_browse.setitem(i,"active_status",0) //set active status if selected
				//rcnt++			
			end if
		next		
	else //reapp
		//pcnt++  //delete by stephen 04.26.2012 -Electronic Meeting, Privilege Update to Granted -Alpha id 3055
		of_retrieve_data("R")
		//gnv_appeondb.of_commitqueue( ) //stephen 10.19.2011 - Bug 2750 - commented by alfee 07.19.2013
		if dw_browse.rowcount() > 0 then 
			pcnt++
			of_reapp_set(ld_from,ld_to)
			dw_copy.update()
		end if
	end if
	res = dw_browse.update()
end if

//---------------------------- APPEON END ----------------------------
	
if rb_recred.checked then 
	dw_browse.reset()
else
	of_retrieve_data("U")
end if
//gnv_appeondb.of_commitqueue( )  - commented by alfee 07.19.2013

dw_browse.SetRedraw(TRUE)

messagebox("Update complete","Records for " + string(pcnt) + " practitioner(s) updated.")

end event

type cb_2 from commandbutton within w_batch_privilege_update
integer x = 4439
integer y = 64
integer width = 352
integer height = 84
integer taborder = 30
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

type st_3 from statictext within w_batch_privilege_update
integer x = 2139
integer y = 296
integer width = 174
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Status:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2a from statictext within w_batch_privilege_update
integer x = 1582
integer y = 296
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "End Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1a from statictext within w_batch_privilege_update
integer x = 997
integer y = 296
integer width = 247
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Start Date"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_status from datawindow within w_batch_privilege_update
integer x = 2318
integer y = 284
integer width = 667
integer height = 76
integer taborder = 80
string dataobject = "d_dddw_priv_status"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild


this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
this.GetChild( "status_code", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()

dwchild.insertrow(1)
dwchild.setitem(1,"code","")
dwchild.setitem(1,"lookup_code","0")













end event

event itemchanged;il_status = long(data)
end event

type em_to from editmask within w_batch_privilege_update
integer x = 1824
integer y = 284
integer width = 315
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type em_from from editmask within w_batch_privilege_update
integer x = 1257
integer y = 284
integer width = 311
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "[date]"
end type

type gb_3 from groupbox within w_batch_privilege_update
integer x = 32
integer y = 32
integer width = 910
integer height = 152
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update Type"
end type

type gb_2 from groupbox within w_batch_privilege_update
integer x = 969
integer y = 32
integer width = 603
integer height = 152
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Practitioner Update"
end type

type gb_f from groupbox within w_batch_privilege_update
integer x = 32
integer y = 220
integer width = 914
integer height = 176
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

type dw_browse from u_dw within w_batch_privilege_update
integer x = 809
integer y = 564
integer width = 4000
integer height = 1464
integer taborder = 20
string title = "Requested Privileges"
string dataobject = "d_priv_batch_browse_new"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean livescroll = false
end type

event clicked;
Integer li_row

li_row = This.GetClickedRow( )

IF li_row < 1 THEN
	Return
END IF


This.ScrollToRow( li_row )
This.SetRow( li_row )
//this.selectrow(0,false)
//this.selectrow(li_row,true)

end event

event doubleclicked;call super::doubleclicked;
//long ll_core
//integer li_row
//integer li_end
//
//if this.rowcount() > 0 then
//	tab_1.selecttab (2)
//	
//end if
end event

event rowfocuschanged;call super::rowfocuschanged;
//IF tab_1.tabpage_detail.dw_detail.RowCount() >= currentrow THEN
	//tab_1.tabpage_detail.dw_detail.SetRow( currentrow )
	//tab_1.tabpage_detail.dw_detail.ScrollToRow( currentrow )
//END IF
//this.selectrow(0,false)
//this.selectrow(this.getrow(),true)

//st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())
end event

event pfc_deleterow;integer res
integer r

res = messagebox("Delete","Are you sure you wish to delete the selected privilege?",Question!,yesno!,2)

if res = 1 then
	r = this.getrow()
	of_add_audit_priv_prac( "PracDel", this, r) //Start Code Change ----12.14.2009 #V10 maha - auditing
	this.deleterow(r)
end if
this.update()

return 0
end event

event pfc_addrow;call super::pfc_addrow;//
integer li_rows
integer li_newrow
long ll_recno
long ll_procd
long ll_core
integer li_ir_stat
string ls_procd
long ll_clin
string ls_clin
string ls_core
integer r
g_str_clin_info lstr_priv
integer li_rowcount
long ll_code
integer checkrow
integer res
date ld_start
date ld_end
date nulldate
String ls_priv_core_procd_des,ls_priv_core_procd_name,ls_status //Added By Ken.Guo 03.14.2008

//Start Code Change ----02.27.2008 #V8 maha
openwithparm(w_clin_area_select,"B*" + string(ii_facil) + "@" + string(il_prac) )
//openwithparm(w_clin_area_select,"B*" + string(ii_facil))
//End Code Change---02.27.2008

setnull(nulldate)
lstr_priv = message.powerobjectparm
debugbreak()
if isnull(lstr_priv) then return 0


li_rowcount = lstr_priv.row_count
//messagebox("li_rowcount",li_rowcount)
ll_clin = lstr_priv.clin_id
ll_code = lstr_priv.stat
li_ir_stat = lstr_priv.appnt
//messagebox("start",string(lstr_priv.dstart))
//messagebox("end",string(lstr_priv.dend))
if string(lstr_priv.dstart) = "1/1/1900" then
	//messagebox("1/1/1900","1/1/1900")
	ld_start = nulldate
else
	//messagebox("1/1/1900","else")
	ld_start = lstr_priv.dstart
end if
if string(lstr_priv.dend) = "1/1/1900" then
	ld_end  = nulldate
else
	ld_end = lstr_priv.dend
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.14.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 

n_ds lds_prac
long ll_find
If not upperbound(lstr_priv.priv_ids[]) > 0 Then return 0
lds_prac = create n_ds
lds_prac.dataobject = "d_priv_core_procd_all"
lds_prac.of_settransobject(SQLCA)

gnv_appeondb.of_startqueue()
lds_prac.retrieve(lstr_priv.priv_ids[])	

//---------------------------- APPEON END ----------------------------

dw_browse.settransobject(sqlca)
//dw_browse.reset() //Commented By Ken.Guo 03.14.2008,Keep Orig data.

SELECT Max( pd_priv_list.rec_id )
	INTO :ll_recno  
	FROM pd_priv_list;
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<add> 02.17.2006 By: Wangchao
//$<reason> Performance tuning.
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue()
//---------------------------- APPEON END ----------------------------	

if isnull(ll_recno) then ll_recno = 0

for r = 1 to li_rowcount
	checkrow = 0
	ll_procd = lstr_priv.priv_ids[r]
	//check to see if already exists
//	select pd_priv_list.rec_id
//	into :checkrow
//	from pd_priv_list
//	where pd_priv_list.procd_id = :ll_procd and pd_priv_list.prac_id = :gl_prac_id and pd_priv_list.facility_id = :gi_facil_change and pd_priv_list.active_status = 1;
//	//checkrow = this.find("procd_id = " + string(ll_procd),1,this.rowcount())
//	//messagebox("checkrow",checkrow)
//	if checkrow > 0 then
//		continue
//	end if
	//create new row
	dw_browse.insertrow (r)	

	ll_recno++

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-12
	//$<modify> 02.14.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT priv_core_procd.priv_core_id 
	INTO :ll_core  
	FROM priv_core_procd
	where priv_core_procd.procd_id = :ll_procd;
	*/
	ll_find = lds_prac.find("priv_core_procd_procd_id="+string(ll_procd),1,lds_prac.rowcount())
	If ll_find > 0 Then 
		ll_core = lds_prac.getitemnumber(ll_find , 'priv_core_procd_priv_core_id')
		//ls_priv_core_procd_des  = lds_prac.getitemstring(ll_find , 'priv_core_procd_core_procd_description') //Added By Ken.Guo 03.14.2008 //Delete by Evan 11.24.2010
		ls_priv_core_procd_name = lds_prac.getitemstring(ll_find , 'priv_core_procd_procd_name')
	End If
	//---------------------------- APPEON END ----------------------------
	
	//messagebox("ll_core ",ll_core )
	dw_browse.setitem(r,"rec_id",ll_recno)
	dw_browse.setitem(r,"facility_id",ii_facil)
	dw_browse.setitem(r,"prac_id",il_prac)
//	il_clin = dw_store.getitemnumber(li_newrow,"priv_core_clinical_area_id")
	dw_browse.setitem(r,"clinical_area_id",ll_clin)
	dw_browse.setitem(r,"priv_core_id",ll_core)
	
	//dw_browse.setitem(r,"priv_core_procd_core_procd_description",ls_priv_core_procd_des) //Added By Ken.Guo 03.14.2008, Show display value. //Delete by Evan 11.24.2010
	dw_browse.setitem(r,"priv_core_procd_procd_name",ls_priv_core_procd_name) //Added By Ken.Guo 03.14.2008, Show display value.
	
	dw_browse.setitem(r,"procd_id",ll_procd)
	dw_browse.setitem(r,"active_status",1)
	dw_browse.Setitem(r,"ir_code",li_ir_stat)
	if string(lstr_priv.dstart) <> "1/1/1900" then
		dw_browse.Setitem(r,"start_date",ld_start)
	end if
	if string(lstr_priv.dend) <> "1/1/1900" then
		dw_browse.Setitem(r,"end_date",ld_end)
	end if
	//dw_browse.Settext("Inital")

	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-13
	//$<modify> 02.14.2006 By: Wangchao
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
	SELECT priv_core.priv_core_description 
	INTO :ls_core  
	FROM priv_core,priv_core_procd
	WHERE priv_core.priv_core_id = priv_core_procd.priv_core_id AND priv_core_procd.procd_id = :ll_procd;
	//messagebox("ls_core ", ls_core )
	SELECT priv_core_procd.core_procd_description 
	INTO :ls_procd  
	FROM priv_core_procd
	WHERE priv_core_procd.procd_id = :ll_procd;
	*/
		
	If ll_find > 0 then 
		ls_core = lds_prac.GetItemString(ll_find , 'priv_core_priv_core_description')
		//ls_procd = lds_prac.GetItemString(ll_find , 'priv_core_procd_core_procd_description') //Delete by Evan 11.24.2010
	End If
	//---------------------------- APPEON END ----------------------------
	
	//ls_procd = dw_store.getitemstring(li_newrow,"core_procd_description")
	//dw_browse.setitem(r,"pd_priv_list_priv_text",ls_procd) //Delete by Evan 11.24.2010

	dw_browse.setitem(r,"status_code",il_req)
	ls_status = gnv_data.of_getitem("code_lookup","code","lookup_code = " + String(il_req) )	//Added By Ken.Guo 03.14.2008
//dw_browse.setitem(r,"code_lookup_code",ls_status) //Added By Ken.Guo 03.14.2008//Start Code Change ----10.26.2009 #V10 maha - removed; causing applicatio error.
	
	dw_browse.setitem(r,"enter_date",datetime(today(),now()))
	//ls_core = dw_store.getitemstring(li_newrow,"priv_core_priv_core_description")
	dw_browse.setitem(r,"priv_core_priv_core_description",ls_core)
	
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-14
//$<add> 02.14.2006 By: Wangchao
//$<reason> Performance tuning
///$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

of_add_audit_priv_prac(  "PracAdd",  this,0)  //Moved from below, because this function need to use the sql's result immediately, Added by Appeon long.zhang 12.30.2016 (Error 10999 : System.OutofMemoryException was thrown)
 
gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

//of_add_audit_priv_prac(  "PracAdd",  this,0) //Start Code Change ----12.14.2009 #V92 maha - for audit

this.update()
commit using sqlca;
//messagebox("","")
of_retrieve_data(is_ret_type)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-15
//$<add> 02.14.2006 By: Wangchao
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
 
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

return 1
end event

event buttonclicked;call super::buttonclicked;integer i



//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/11/2008 By: Ken.Guo
//$<reason> Need deselect function
/*
for i = 1 to this.rowcount()
	this.setitem(i,"selected",1)
next
*/
Long ll_rowcn
Int li_value0[],li_value1[]
ll_rowcn = This.rowcount()
//Set value list to array for performance. 
For i = 1 To ll_rowcn
	li_value0[i] = 0
	li_value1[i] = 1
Next
//Add deselect function.
If dwo.text = 'Select All' Then
	If ll_rowcn > 0 Then 
		This.Object.Selected[1,ll_rowcn] = li_value1[]
		dwo.text = 'Deselect All'
	End If
ElseIf dwo.text = 'Deselect All' Then 
	If ll_rowcn > 0 Then 
		This.Object.Selected[1,ll_rowcn] = li_value0[]
		dwo.text = 'Select All'	
	End If
End If
//---------------------------- APPEON END ----------------------------


end event

event pfc_preupdate;call super::pfc_preupdate;of_add_audit_priv_prac(  "Prac",  this,0) //Start Code Change ----12.09.2009 #V92 maha - for audit

return 1
end event

type st_mess from statictext within w_batch_privilege_update
integer x = 41
integer y = 404
integer width = 3483
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Sets all REQUESTED Privileges to the update settings ,and sends all other active privileges to history."
boolean focusrectangle = false
end type

type rb_one from radiobutton within w_batch_privilege_update
integer x = 1019
integer y = 84
integer width = 320
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Individual"
end type

type rb_all from radiobutton within w_batch_privilege_update
integer x = 1358
integer y = 88
integer width = 178
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "All"
end type

type rb_recred from radiobutton within w_batch_privilege_update
integer x = 73
integer y = 84
integer width = 370
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Reapproval"
boolean checked = true
end type

event clicked;dw_browse.dataobject = "d_priv_batch_browse_new" //Start Code Change ----07.27.2009 #V92 maha - changed to grid dw and corrected for SQL problem
dw_browse.settransobject(sqlca)
dw_browse.title = "Requested Privileges"
st_mess.text = "Sets all REQUESTED Privileges to the update settings, and sends all other active privileges to history."
cbx_hist.enabled = false
cbx_hist.checked = false
if dw_pracs.rowcount() > 1 then
	rb_all.enabled = true
end if
is_ret_type = "R"



//Start Code Change ----11.027.2007 #V8 maha
IF  ii_facil > 0 THEN 
	dw_browse.retrieve(ii_facil, il_prac_list[] )
	of_retrieve_data(is_ret_type)
end if
//End Code Change---11.27.2007

//Start Code Change ----07.22.2009 #V92 maha
//if dw_browse.rowcount() = 0  and dw_copy.rowcount() > 0  then
	cbx_roll.enabled = true
//end if
//End Code Change---07.22.2009


end event

type rb_update from radiobutton within w_batch_privilege_update
integer x = 512
integer y = 84
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Batch Update"
end type

event clicked;dw_browse.dataobject = "d_priv_update_list_d_entry_all"
dw_browse.settransobject(sqlca)
dw_browse.title = "Batch Update Privileges"
st_mess.text = "Sets all SELECTED Privileges to the update values."
cbx_hist.enabled = true
rb_all.enabled = false
rb_all.checked = false
rb_one.checked = true
is_ret_type = "U"

//Start Code Change ----11.027.2007 #V8 maha
IF  ii_facil > 0 THEN 
	dw_browse.retrieve(ii_facil, il_prac_list[] )
	of_retrieve_data(is_ret_type)
end if
//End Code Change---11.27.2007

//Start Code Change ----07.22.2009 #V92 maha
cbx_roll.enabled = false
cbx_roll.checked = false
//End Code Change---07.22.2009

end event

type cbx_hist from checkbox within w_batch_privilege_update
integer x = 3035
integer y = 284
integer width = 443
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Send to History"
end type

type gb_1 from groupbox within w_batch_privilege_update
integer x = 969
integer y = 224
integer width = 2551
integer height = 172
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Update Settings"
end type

type cb_sort from commandbutton within w_batch_privilege_update
integer x = 1664
integer y = 480
integer width = 352
integer height = 76
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str
SetNull(null_str)
dw_browse .SetSort(null_str)
dw_browse.Sort( )
end event

type dw_copy from datawindow within w_batch_privilege_update
boolean visible = false
integer x = 805
integer y = 2156
integer width = 2382
integer height = 192
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_priv_batch_browse_copy"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

