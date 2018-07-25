$PBExportHeader$pfc_cst_u_roster_sumbit.sru
$PBExportComments$Used in w_caqh_roster
forward
global type pfc_cst_u_roster_sumbit from userobject
end type
type tab_1 from tab within pfc_cst_u_roster_sumbit
end type
type tabpage_files from userobject within tab_1
end type
type dw_date_range from u_dw within tabpage_files
end type
type ddlb_file_type from dropdownlistbox within tabpage_files
end type
type cb_1 from commandbutton within tabpage_files
end type
type ddlb_send_status from dropdownlistbox within tabpage_files
end type
type dw_files from u_dw within tabpage_files
end type
type cb_new_file from commandbutton within tabpage_files
end type
type cb_search from commandbutton within tabpage_files
end type
type gb_2 from groupbox within tabpage_files
end type
type gb_1 from groupbox within tabpage_files
end type
type gb_3 from groupbox within tabpage_files
end type
type tabpage_files from userobject within tab_1
dw_date_range dw_date_range
ddlb_file_type ddlb_file_type
cb_1 cb_1
ddlb_send_status ddlb_send_status
dw_files dw_files
cb_new_file cb_new_file
cb_search cb_search
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
end type
type tabpage_submission from userobject within tab_1
end type
type st_recs from statictext within tabpage_submission
end type
type cb_next from commandbutton within tabpage_submission
end type
type cb_prior from commandbutton within tabpage_submission
end type
type cb_7 from commandbutton within tabpage_submission
end type
type cb_auto from commandbutton within tabpage_submission
end type
type cb_submit from commandbutton within tabpage_submission
end type
type cb_save from commandbutton within tabpage_submission
end type
type dw_submit_browse from u_dw within tabpage_submission
end type
type cb_delete from commandbutton within tabpage_submission
end type
type cb_add from commandbutton within tabpage_submission
end type
type dw_submit_detail from u_dw within tabpage_submission
end type
type tab_view_submit from tab within tabpage_submission
end type
type tabpage_browse from userobject within tab_view_submit
end type
type tabpage_browse from userobject within tab_view_submit
end type
type tabpage_details from userobject within tab_view_submit
end type
type tabpage_details from userobject within tab_view_submit
end type
type tab_view_submit from tab within tabpage_submission
tabpage_browse tabpage_browse
tabpage_details tabpage_details
end type
type tabpage_submission from userobject within tab_1
st_recs st_recs
cb_next cb_next
cb_prior cb_prior
cb_7 cb_7
cb_auto cb_auto
cb_submit cb_submit
cb_save cb_save
dw_submit_browse dw_submit_browse
cb_delete cb_delete
cb_add cb_add
dw_submit_detail dw_submit_detail
tab_view_submit tab_view_submit
end type
type tabpage_exception from userobject within tab_1
end type
type dw_exception from u_dw within tabpage_exception
end type
type tabpage_exception from userobject within tab_1
dw_exception dw_exception
end type
type tabpage_list from userobject within tab_1
end type
type st_list_info from statictext within tabpage_list
end type
type st_list_rec from statictext within tabpage_list
end type
type cb_9 from commandbutton within tabpage_list
end type
type cb_8 from u_cb within tabpage_list
end type
type dw_roster_browse from u_dw within tabpage_list
end type
type dw_roster_detail from u_dw within tabpage_list
end type
type tab_view_list from tab within tabpage_list
end type
type tabpage_1 from userobject within tab_view_list
end type
type tabpage_1 from userobject within tab_view_list
end type
type tabpage_2 from userobject within tab_view_list
end type
type tabpage_2 from userobject within tab_view_list
end type
type tab_view_list from tab within tabpage_list
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type tabpage_list from userobject within tab_1
st_list_info st_list_info
st_list_rec st_list_rec
cb_9 cb_9
cb_8 cb_8
dw_roster_browse dw_roster_browse
dw_roster_detail dw_roster_detail
tab_view_list tab_view_list
end type
type tab_1 from tab within pfc_cst_u_roster_sumbit
tabpage_files tabpage_files
tabpage_submission tabpage_submission
tabpage_exception tabpage_exception
tabpage_list tabpage_list
end type
type dw_1 from u_dw within pfc_cst_u_roster_sumbit
end type
end forward

global type pfc_cst_u_roster_sumbit from userobject
integer width = 4352
integer height = 2000
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_check ( )
event ue_refresh_settings ( )
tab_1 tab_1
dw_1 dw_1
end type
global pfc_cst_u_roster_sumbit pfc_cst_u_roster_sumbit

type variables
long il_file_id = 0 //current submission file id
long il_exception_id = 0 //current exception file id
long il_max_roster_id = 0 //Max Return Roster file Id

u_dw idw_files
u_dw idw_submit_browse
u_dw idw_submit_detail
u_dw idw_exception
u_dw idw_roster_browse
u_dw idw_roster_detail

String is_view_type // B:Browse D:Detail
String is_file_type //Current file type, S:Submission, E:exception, R:Return Roster.
String is_original_sql

Boolean ib_send_status = false //Current file send status
Boolean ib_new = false //Adding new submission
boolean ib_roster_retrieved = false //has retrieved the lastest roster.
Boolean ib_processing = False

window iw_parent

n_cst_caqh_roster inv_caqh_roster
n_cst_message inv_message //For scheduler

n_cst_PowerFilter iu_PowerFilter
end variables

forward prototypes
public function integer of_set_parent_window (window aw_win)
public function integer of_submit ()
public function integer of_save ()
public subroutine of_refresh_submit_button ()
public function integer of_add (string as_type)
public function integer of_retrieve ()
public function integer of_get_list ()
public function integer of_get_exception ()
public function integer of_sched_run (string as_type, ref string as_message, ref long al_proc_cnt)
public function integer of_files_retrieve ()
public subroutine of_show_list_info (long al_file_id)
public function integer of_refresh_files (long al_file_id)
public subroutine of_set_tabpage_enabled (string as_file_type, long al_exception_id)
public function integer of_security ()
end prototypes

event ue_check();//====================================================================
//$<Event>: ue_check
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Check Roster Settings
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_err
Int i

i = inv_caqh_roster.of_check_settings(ls_err)
If i < 0 Then
	Messagebox("Check CAQH Roster Settings",ls_err)
	Return
End If
end event

event ue_refresh_settings();//====================================================================
//$<Event>: ue_refresh_settings
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Refresh inv_caqh_roster settings.
//$<Author>: (Appeon) long.zhang 07.08.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

inv_caqh_roster.of_refresh_settings()

end event

public function integer of_set_parent_window (window aw_win);//====================================================================
//$<Function>: of_set_parent_window
//$<Arguments>:
// 	value    window    aw_win
//$<Return>:  integer
//$<Description>: Set iw_parent
//$<Author>: (Appeon) long.zhang 05.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.iw_parent = aw_win

Return 0
end function

public function integer of_submit ();//====================================================================
//$<Function>: of_submit
//$<Arguments>:
//$<Return>:  integer 1:success/ -1: fail
//$<Description>: Export File and send it to CAQH
//$<Author>: (Appeon) long.zhang 05.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_error
Int i
Long ll_file_id

ll_file_id = il_file_id

If idw_submit_browse.rowcount()< 1 Then return -1

//Must Save idw_submit first
If Not (idw_submit_browse.GetItemStatus( 1, 0, Primary! ) = NotModified!) Then
	Messagebox('Submit to CAQH','Please save first.')
	return -1
End If

// Open processs window
SetPointer(HourGlass!)
openwithparm( w_appeon_gifofwait, "Sending Submission File to CAQH FTP..." )

//Send to CAQH Ftp
i = inv_caqh_roster.of_send_file(ll_file_id, ls_error)

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

If i < 0 Then 
	Messagebox('Submit to CAQH', ls_error +' Error code ' +string(i) +'.')
	return -1
End If		

Messagebox('Submit to CAQH','Finished.')

ib_send_status = True 
of_refresh_submit_button()

Return 1
end function

public function integer of_save ();//====================================================================
//$<Function>: of_save
//$<Arguments>:
//$<Return>:  Int
//$<Description>: Save dw_submit and dw_files
//$<Author>: (Appeon) long.zhang 05.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Save
Return idw_submit_detail.of_update(True, True)
end function

public subroutine of_refresh_submit_button ();//====================================================================
//$<Function>: of_refresh_submit_button
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Change 'Enabled property' for buttons and dw_submit_detail in tabpage_submission.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If idw_submit_detail.rowcount() > 1 then 
	this.tab_1.tabpage_submission.cb_prior.enabled  = true
	this.tab_1.tabpage_submission.cb_next.enabled  = true
Else
	this.tab_1.tabpage_submission.cb_prior.enabled  = false
	this.tab_1.tabpage_submission.cb_next.enabled  = false
End If

//Can not edit this record since it was sended.
this.tab_1.tabpage_submission.cb_add.enabled = Not ib_send_status
this.tab_1.tabpage_submission.cb_auto.enabled = Not ib_send_status
this.tab_1.tabpage_submission.cb_delete.enabled = Not ib_send_status
this.tab_1.tabpage_submission.cb_save.enabled = Not ib_send_status
this.tab_1.tabpage_submission.cb_submit.enabled = Not ib_send_status
idw_submit_detail.of_setupdateable(Not ib_send_status)
idw_submit_detail.Object.DataWindow.ReadOnly = ib_send_status
end subroutine

public function integer of_add (string as_type);//====================================================================
//$<Function>: of_add
//$<Arguments>:
// 	value    string    as_type 'SELECT'/'AUTO'
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 06.05.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_cnt
Integer i
gs_search lstr_search
gs_batch_search lstr_bat_search

If as_type = 'SELECT' Then
	lstr_search.stran_transaction = SQLCA
	lstr_search.ls_open_for = "REPORTS"  
	
	OpenWithParm( w_extended_search_new , lstr_search )
	
	IF Message.DoubleParm = -1 THEN
		Return -1
	END IF
	
	lstr_bat_search = Message.Powerobjectparm
	
	li_cnt = UpperBound( lstr_bat_search.li_prac_id[] )
	If li_cnt > 0 Then i = inv_caqh_roster.of_add_submission_dw(idw_submit_browse,  lstr_bat_search.li_prac_id[], false)
Else //AUTO
	If messagebox("Auto Add","This will get Providers based on the Roster Setup-EXPORT-Retrieval Query.~rContinue?", Question!,YesNo!,2) = 1 Then
		i = inv_caqh_roster.of_add_submission_dw(idw_submit_browse) //auto get data
	End If
End If

//Save
If i > 0 Then
	Post of_save()
End If

//Refresh Buttion
Post of_refresh_submit_button()
	
return 1
end function

public function integer of_retrieve ();//====================================================================
//$<Function>: of_retrieve
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Retrieve Submission File
//$<Author>: (Appeon) long.zhang 06.05.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Boolean lb_retrieve_S = false
Boolean lb_retrieve_E = false
Boolean lb_retrieve_R = false //True:Retrive a specified Return Roser, False:Retrieve default  Return Roser

If ib_new Then //New submission
	lb_retrieve_S = True
	lb_retrieve_E = False
	lb_retrieve_R = False
	ib_new = false
Else
	Choose case is_file_type
		case 'S' //Can see Submission + Exception + Return Roster
			lb_retrieve_S = True
			If il_exception_id > 0 Then lb_retrieve_E = True
			lb_retrieve_R = False
		case 'E' //Can see Exception
			lb_retrieve_E = True
		case 'R' //Can see Return Roster
			lb_retrieve_R = True
			
			If il_file_id = 0 Then lb_retrieve_R = False //No file_id selected, show default Return File
	End choose
End If
		
gnv_appeondb.of_startqueue( )
//Submisson Tab
If lb_retrieve_S Then
	idw_submit_browse.retrieve(il_file_id)
Else
	idw_submit_browse.Reset()
End If

//Exception tab
If lb_retrieve_E Then
	If is_file_type = 'S' Then //Only show exception records asociated with il_file_id
		idw_exception.retrieve(il_exception_id, il_file_id)
	Else //Show all records
		idw_exception.retrieve(il_file_id, 0)
	End If
Else
	idw_exception.Reset()
End If

//Return Roster
If lb_retrieve_R Then
	idw_roster_browse.Retrieve(il_file_id)
	
	of_show_list_info(il_file_id)
	
	ib_roster_retrieved = False
Else //Retrieve the max one, if needed.
	If ib_roster_retrieved = False Then //The latest roster has not been retrieved.
		idw_roster_browse.Retrieve(il_max_roster_id)
		
		of_show_list_info(il_max_roster_id)
		
		ib_roster_retrieved = True //The latest roster has been retrieved.
	End If
End If
	
gnv_appeondb.of_CommitQueue( )

//Refresh button, After CommitQueue.
If lb_retrieve_S Then
	of_refresh_submit_button()
End If

return 1
end function

public function integer of_get_list ();//====================================================================
//$<Function>: of_get_list
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get roster list file.
//$<Author>: (Appeon) long.zhang 07.02.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
String ls_error


//Download files
i = inv_caqh_roster.of_get_file(inv_caqh_roster.IS_LIST, ls_error)

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

If i < 0 Then 
	inv_message.of_Messagebox('Refresh Roster List','Get Roster file failed.~r~n' + ls_error +' Error code '+String(i) + '.', True)
	Return -1
ElseIf i = 0 Then
	inv_message.of_Messagebox('Refresh Roster List','Finished. No new file is received.', True)
ElseIf i = 1 Then //One file
	inv_message.of_Messagebox('Refresh Roster List','Finished. ' + 'A new file is received.', True)
Else
	inv_message.of_Messagebox('Refresh Roster List','Finished. ' + String(i) + ' new files are received.', True)
End If

Return i
end function

public function integer of_get_exception ();//====================================================================
//$<Function>: of_get_exception
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get Roster Exception file.
//$<Author>: (Appeon) long.zhang 07.02.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
String ls_error

//Download files
i = inv_caqh_roster.of_get_file(inv_caqh_roster.IS_EXCEPTION, ls_error)

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)	

If i < 0 Then 
	inv_message.of_Messagebox('Refresh Roster Exception','Get Exception file failed.~r~n' +ls_error+ ' Error code '+String(i) +'.', True)
	Return -1
ElseIf i = 0 Then
	inv_message.of_Messagebox('Refresh Roster Exception','Finished. No new file is received.', True)
ElseIf i = 1 Then //One file
	inv_message.of_Messagebox('Refresh Roster Exception','Finished. ' + 'A new file is received.', True)
Else
	inv_message.of_Messagebox('Refresh Roster Exception','Finished. ' + String(i) + ' new files are received.', True)
End If

Return i
end function

public function integer of_sched_run (string as_type, ref string as_message, ref long al_proc_cnt);//====================================================================
//$<Function>: of_sched_run
//$<Arguments>:
// 	value        string    as_type	 LIST/EXCEPTION
// 	reference    string    as_message
// 	reference    long      al_proc_cnt
//$<Return>:  integer
//$<Description>: Runing scheduler to get Roser File and Exception File
//$<Author>: (Appeon) long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int li_cnt
Int li_return = 1
String ls_err

inv_message.of_set_schedule(True)

//Check Settings
i = inv_caqh_roster.of_check_settings(ls_err)
If i < 0 Then
	as_message = ls_err
	Return -1
End If

//Roster file
If as_type = 'LIST' Then
	i = of_get_list()	
	If i >= 0 Then
		al_proc_cnt = i
		li_return = 1
	Else
		li_return = -1
	End If
	
	as_message = inv_message.of_get_message()	
End If

//Exception FIle
//Roster file
If as_type = 'EXCEPTION' Then
	i = of_get_exception()	
	If i >= 0 Then
		al_proc_cnt = i
		li_return = 1
	Else
		li_return = -1
	End If
	
	as_message = inv_message.of_get_message()	
End If


Return li_return
end function

public function integer of_files_retrieve ();//====================================================================
//$<Function>: of_files_retrieve
//$<Arguments>:
//$<Return>:  integer
//$<Description>: retrieve idw_files
//$<Author>: (Appeon) long.zhang 07.21.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
int i
string ls_from_date, ls_to_date
string ls_filter
long   ll_import
string ls_sql
string ls_change, ls_date_condition, ls_file_type_condition, ls_status_condition

//date condition
if tab_1.tabpage_files.dw_date_range.accepttext() = -1 then return -1
ls_from_date = String(tab_1.tabpage_files.dw_date_range.GetItemDate( 1, "from_date" ), 'yyyy-mm-dd' ) 
ls_to_date =  String( tab_1.tabpage_files.dw_date_range.GetItemDate( 1, "to_date" ), 'yyyy-mm-dd' ) 

ls_filter = ''
if ls_from_date <>'' and not isnull(ls_from_date) then
	ls_from_date = ls_from_date + " 00:00:00"
	ls_filter =  "convert(varchar,create_date,120) >='"+ls_from_date +"'"
	if ls_to_date <>'' and not isnull(ls_to_date) then
		ls_to_date = ls_to_date + " 23:59:59"
		ls_filter = ls_filter +" and convert(varchar,create_date,120) <= '"+ls_to_date +"'"
	end if
	
elseif  ls_to_date <>'' and not isnull(ls_to_date) then
	ls_to_date = ls_to_date + " 23:59:59"
	ls_filter = " convert(varchar,create_date,120) <= '"+ ls_to_date+"'"
else
	ls_filter = " 1 = 1 "
end if
ls_date_condition = ls_filter

//File_type
Choose case tab_1.tabpage_files.ddlb_file_type.text
	case 'Submission'
		ls_file_type_condition = " file_type = 'S'"
	case 'Return Roster'
		ls_file_type_condition = " file_type = 'R'"	
	case 'Exception'
		ls_file_type_condition = " file_type = 'E'"	
	case else
		ls_file_type_condition = ' 1 = 1 '
End Choose

//Status condition
Choose case  tab_1.tabpage_files.ddlb_send_status.text
	case 'Submitted'
		ls_status_condition = " send_status = 'Y'"
	case 'Saved'
		ls_status_condition = " send_status = 'N'"	
	case else
		ls_status_condition = ' 1 = 1 '
End Choose

//setsql
ls_sql  = is_original_sql + ' Where ' + ls_file_type_condition + ' and ' +  ls_date_condition + ' and ' +  ls_status_condition //Start Code Change ----01.12.2016 #V15 maha - usee variable
//messagebox("",ls_sql)
//clipboard(ls_sql)
idw_files.setsqlselect (ls_sql)

//retrieve
SetPointer ( HourGlass! )
idw_files.setredraw(false)
i = idw_files.retrieve()
if i < 0 then //Start Code Change ----01.12.2016 #V15 maha - added error message
	messagebox("Search Failed", "Failed to retrieve roster data:~r~r" + ls_sql)
end if 
idw_files.setredraw(true)

SetPointer ( Arrow! )

return i

end function

public subroutine of_show_list_info (long al_file_id);//====================================================================
//$<Function>: of_show_list_info
//$<Arguments>:
// 	value    long    al_file_id
//$<Return>:  (None)
//$<Description>: Set file info to tab_1.tabpage_list.st_list_info.text 
//$<Author>: (Appeon) long.zhang 08.19.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

String ls_info

ls_info = 'File Id: ' + String(al_file_id)

//The Lastest one
If al_file_id = il_max_roster_id Then
	ls_info += ' (Current)'
Else
	ls_info += ' (History)'
End If

tab_1.tabpage_list.st_list_info.text =  ls_info
end subroutine

public function integer of_refresh_files (long al_file_id);//====================================================================
//$<Function>: of_refresh_files
//$<Arguments>:
// 	value    long    al_file_id
//$<Return>:  integer
//$<Description>: Refresh idw_files when changed (Save/submit/Get new 'exception files'/Get new 'Return Roster File').
//$<Author>: (Appeon) long.zhang 10.10.2015  (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_row
Long ll_select

ll_select = il_file_id

of_files_retrieve()

//Select original row
ll_row = idw_files.Find('file_id = ' +String(ll_select), 1, idw_files.rowcount())
If ll_row > 0 Then
	idw_files.inv_RowSelect.of_RowSelect(ll_row) 
End If

Return 1
end function

public subroutine of_set_tabpage_enabled (string as_file_type, long al_exception_id);//====================================================================
//$<Function>: of_set_tabpage_enabled
//$<Arguments>:
// 	value    string    as_file_type
//	Value   Long		al_exception_id
//$<Return>:  (None)
//$<Description>: Set tabpage enabled for different file type.
//$<Author>: (Appeon) long.zhang 07.17.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Boolean lb_retrieve_S = false
Boolean lb_retrieve_E = false

Choose case as_file_type
	case 'S' //Can see Submission + Exception + Return Roster
		lb_retrieve_S = True
		If (Not IsNull(al_exception_id) AND al_exception_id <> 0) Then lb_retrieve_E = True
	case 'E' //Can see Exception
		lb_retrieve_E = True
End choose	

//Submisson Tab
If lb_retrieve_S Then
	tab_1.tabpage_submission.Enabled = True
Else
	tab_1.tabpage_submission.Enabled = False
End If

//Exception tab
If lb_retrieve_E Then
	tab_1.tabpage_exception.Enabled = True
Else
	tab_1.tabpage_exception.Enabled = False
End If

return
end subroutine

public function integer of_security (); //Start Code Change ----11.10.2015 #V15 maha
 
 IF w_mdi.of_security_access( 7806 ) = 1 THEN  //readonly
 	tab_1.tabpage_files.cb_new_file.visible = false
	 tab_1.tabpage_submission.cb_add.visible = False
	 tab_1.tabpage_submission.cb_auto.visible = False
	 tab_1.tabpage_submission.cb_delete.visible = False
	 tab_1.tabpage_submission.cb_save.visible = False
	 tab_1.tabpage_submission.cb_submit.visible = False
end if

return 1
	 
end function

on pfc_cst_u_roster_sumbit.create
this.tab_1=create tab_1
this.dw_1=create dw_1
this.Control[]={this.tab_1,&
this.dw_1}
end on

on pfc_cst_u_roster_sumbit.destroy
destroy(this.tab_1)
destroy(this.dw_1)
end on

event constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i

//dws
idw_files = tab_1.tabpage_files.dw_files
idw_submit_browse = tab_1.tabpage_submission.dw_submit_browse
idw_submit_detail = tab_1.tabpage_submission.dw_submit_detail
idw_exception = tab_1.tabpage_exception.dw_exception
idw_roster_browse = tab_1.tabpage_list.dw_roster_browse
idw_roster_detail =  tab_1.tabpage_list.dw_roster_detail

idw_files.settransobject(sqlca)
idw_submit_browse.settransobject(sqlca)
idw_submit_detail.settransobject(sqlca)
idw_exception.settransobject(sqlca)
idw_roster_browse.settransobject(sqlca)

//functions
inv_caqh_roster = create n_cst_caqh_roster

//Create dw_detail
i = inv_caqh_roster.of_create_dw_detail(idw_submit_detail,idw_submit_browse)
If i > 0 Then idw_submit_browse.sharedata(idw_submit_detail)

idw_roster_browse.Sharedata( idw_roster_detail )

//Max Return Roster file id
il_max_roster_id = inv_caqh_roster.of_get_max_roster_id()


end event

event destructor;//====================================================================
//$<Event>: destructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Destroy inv_caqh_roster

end event

type tab_1 from tab within pfc_cst_u_roster_sumbit
integer width = 4347
integer height = 1984
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
tabpage_files tabpage_files
tabpage_submission tabpage_submission
tabpage_exception tabpage_exception
tabpage_list tabpage_list
end type

on tab_1.create
this.tabpage_files=create tabpage_files
this.tabpage_submission=create tabpage_submission
this.tabpage_exception=create tabpage_exception
this.tabpage_list=create tabpage_list
this.Control[]={this.tabpage_files,&
this.tabpage_submission,&
this.tabpage_exception,&
this.tabpage_list}
end on

on tab_1.destroy
destroy(this.tabpage_files)
destroy(this.tabpage_submission)
destroy(this.tabpage_exception)
destroy(this.tabpage_list)
end on

event selectionchanging;//====================================================================
//$<Event>: selectionchanging
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_row

//Save submission file details when changing tab, by Appeon long.zhang 09.29.2015 (BugS092303)
If oldindex = 2 Then
	idw_submit_detail.AcceptText()
	If idw_submit_detail.ModifiedCount() + idw_submit_detail.DeletedCount() > 0 then
		If of_save() < 0 Then 
			Return 1
		End If
	End If
End If
	
//If oldindex = 1 Then	
	ll_row = idw_files.getrow()
	If ((newindex = 2 or newindex = 3 or newindex = 4) And (ll_row > 0))  And Not ib_new Then
		If  (il_file_id <>  idw_files.getitemnumber(ll_row,'file_id')) or (il_exception_id <> idw_files.getitemnumber(ll_row,'exception_file_id')) Then //If il_file_id or il_exception_id changed
			il_file_id = idw_files.getitemnumber(ll_row,'file_id')
			is_file_type = idw_files.GetItemString(ll_row,'file_type')
			il_exception_id = idw_files.getitemnumber(ll_row,'exception_file_id')
			If IsNull(il_exception_id) Then il_exception_id = 0
				
			If idw_files.GetItemString(ll_row,'send_status') = 'Y' Then
				ib_send_status = True
			Else
				ib_send_status = False
			End If
	
			post of_retrieve()
		End If
	ElseIf ib_new Then //Click 'New Submission' in tabpage 1
		il_file_id = 0
		il_exception_id = 0
		is_file_type = 'S'
		ib_send_status = False
		post of_retrieve()
	ElseIf newindex = 4 and idw_files.getrow() = 0 Then //After openning window, select tabpage 4 directlty without selecting any record in tabpage 1.
		il_file_id = 0
		il_exception_id = 0
		is_file_type = 'R'
		post of_retrieve()
	End If
//End If
	
end event

type tabpage_files from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4311
integer height = 1868
long backcolor = 33551856
string text = "Exchange Data Files"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_date_range dw_date_range
ddlb_file_type ddlb_file_type
cb_1 cb_1
ddlb_send_status ddlb_send_status
dw_files dw_files
cb_new_file cb_new_file
cb_search cb_search
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
end type

on tabpage_files.create
this.dw_date_range=create dw_date_range
this.ddlb_file_type=create ddlb_file_type
this.cb_1=create cb_1
this.ddlb_send_status=create ddlb_send_status
this.dw_files=create dw_files
this.cb_new_file=create cb_new_file
this.cb_search=create cb_search
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.Control[]={this.dw_date_range,&
this.ddlb_file_type,&
this.cb_1,&
this.ddlb_send_status,&
this.dw_files,&
this.cb_new_file,&
this.cb_search,&
this.gb_2,&
this.gb_1,&
this.gb_3}
end on

on tabpage_files.destroy
destroy(this.dw_date_range)
destroy(this.ddlb_file_type)
destroy(this.cb_1)
destroy(this.ddlb_send_status)
destroy(this.dw_files)
destroy(this.cb_new_file)
destroy(this.cb_search)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
end on

type dw_date_range from u_dw within tabpage_files
integer x = 59
integer y = 60
integer width = 1138
integer height = 80
integer taborder = 40
string dataobject = "d_caqh_roster_date_range"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.settransobject(sqlca)
this.insertrow(1)
this.setitem(1,'from_date', RelativeDate ( today(), -14 ))
this.setitem(1,'to_date', today())

this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.of_setupdateable(false) 
end event

type ddlb_file_type from dropdownlistbox within tabpage_files
integer x = 1349
integer y = 60
integer width = 421
integer height = 324
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"","Submission","Return Roster","Exception"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    index
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If this.text = 'Return Roster' or  this.text = 'Exception 'Then
	gb_2.visible = false
	ddlb_send_status.visible = false
Else
	gb_2.visible = True
	ddlb_send_status.visible = True
End If
end event

type cb_1 from commandbutton within tabpage_files
integer x = 2747
integer y = 56
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&elect"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Select file_id and show details in each tab. 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

long i

If idw_files.getrow()  > 0 Then
	If tab_1.tabpage_submission.Enabled Then
		tab_1.SelectTab(2)
	ElseIf tab_1.tabpage_exception.Enabled Then
		tab_1.SelectTab(3)
	Else
		tab_1.SelectTab(4)
	End If
End If
end event

type ddlb_send_status from dropdownlistbox within tabpage_files
integer x = 1874
integer y = 60
integer width = 393
integer height = 324
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"","Submitted","Saved"}
borderstyle borderstyle = stylelowered!
end type

type dw_files from u_dw within tabpage_files
integer y = 176
integer width = 4302
integer height = 1692
integer taborder = 11
string dataobject = "d_caqh_roster_files"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.of_setrowselect( true)
this.of_setupdateable(false)

is_original_sql = this.getsqlselect()


end event

event doubleclicked;call super::doubleclicked;//====================================================================
//$<Event>: doubleclicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If row > 0 and dwo.type = 'column' then 
	 This.Event rowfocuschanged(row)
	 cb_1.event clicked()
End If
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_file_type
Long ll_exception_id

If currentrow > 0 Then
	ls_file_type = this.GetItemString(currentrow,'file_type')
	ll_exception_id = this.getitemnumber(currentrow,'exception_file_id')
	of_set_tabpage_enabled(ls_file_type, ll_exception_id)
End If
end event

type cb_new_file from commandbutton within tabpage_files
integer x = 3104
integer y = 56
integer width = 439
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New Submission"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Add New CAQH Submission file.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

ib_new = True
of_set_tabpage_enabled('S', 0)

tab_1.SelectTab(2)

end event

type cb_search from commandbutton within tabpage_files
integer x = 2405
integer y = 56
integer width = 320
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Search"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Search dw_files by conditions.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_files_retrieve()
end event

type gb_2 from groupbox within tabpage_files
integer x = 1861
integer y = 8
integer width = 416
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type

type gb_1 from groupbox within tabpage_files
integer x = 1335
integer y = 8
integer width = 448
integer height = 160
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "File Type"
end type

type gb_3 from groupbox within tabpage_files
integer x = 46
integer y = 8
integer width = 1161
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Create date"
end type

type tabpage_submission from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4311
integer height = 1868
long backcolor = 33551856
string text = "Roster Submission File"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_recs st_recs
cb_next cb_next
cb_prior cb_prior
cb_7 cb_7
cb_auto cb_auto
cb_submit cb_submit
cb_save cb_save
dw_submit_browse dw_submit_browse
cb_delete cb_delete
cb_add cb_add
dw_submit_detail dw_submit_detail
tab_view_submit tab_view_submit
end type

on tabpage_submission.create
this.st_recs=create st_recs
this.cb_next=create cb_next
this.cb_prior=create cb_prior
this.cb_7=create cb_7
this.cb_auto=create cb_auto
this.cb_submit=create cb_submit
this.cb_save=create cb_save
this.dw_submit_browse=create dw_submit_browse
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.dw_submit_detail=create dw_submit_detail
this.tab_view_submit=create tab_view_submit
this.Control[]={this.st_recs,&
this.cb_next,&
this.cb_prior,&
this.cb_7,&
this.cb_auto,&
this.cb_submit,&
this.cb_save,&
this.dw_submit_browse,&
this.cb_delete,&
this.cb_add,&
this.dw_submit_detail,&
this.tab_view_submit}
end on

on tabpage_submission.destroy
destroy(this.st_recs)
destroy(this.cb_next)
destroy(this.cb_prior)
destroy(this.cb_7)
destroy(this.cb_auto)
destroy(this.cb_submit)
destroy(this.cb_save)
destroy(this.dw_submit_browse)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.dw_submit_detail)
destroy(this.tab_view_submit)
end on

type st_recs from statictext within tabpage_submission
integer x = 3049
integer y = 120
integer width = 384
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type cb_next from commandbutton within tabpage_submission
integer x = 1874
integer y = 8
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Next->"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Next row, Scroll idw_submit_browse and idw_submit_detail
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer i
i = idw_submit_browse.getrow()
if i < idw_submit_browse.rowcount() then
	idw_submit_browse.setrow(i+1)
	idw_submit_browse.selectrow(0,false)
	idw_submit_browse.selectrow(i+1,true)
	idw_submit_browse.scrolltorow(i+1)
end if
end event

type cb_prior from commandbutton within tabpage_submission
integer x = 1513
integer y = 8
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "<-Prior"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Prior row, Scroll idw_submit_browse and idw_submit_detail
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer i
i = idw_submit_browse.getrow()
if i > 1 then
	idw_submit_browse.setrow(i - 1)
	idw_submit_browse.selectrow(0,false)
	idw_submit_browse.selectrow(i - 1,true) //It will also scroll idw_submit_detail.
	idw_submit_browse.scrolltorow(i - 1)
end if
end event

type cb_7 from commandbutton within tabpage_submission
integer x = 3003
integer y = 8
integer width = 471
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh Exception"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get new Exception files from CAQH FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
If ib_processing = True Then Return 1
ib_processing = True

// Open processs window
SetPointer(HourGlass!)
openwithparm( w_appeon_gifofwait, "Getting Exception Files from CAQH FTP..." )

If of_get_exception() > 0 Then
	of_refresh_files(il_file_id)
End If

ib_processing = False
end event

type cb_auto from commandbutton within tabpage_submission
integer x = 745
integer y = 8
integer width = 384
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Auto Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get providers by Roster Setup-EXPORT-Retrieval Query.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i

If messagebox("Auto Add","It will get data by your setting (Roster Setup-EXPORT-Retrieval Query).", Question!,YesNo!,2) = 1 Then
	i = inv_caqh_roster.of_add_submission_dw(idw_submit_browse) //Auto get data
	
	If i = 1 Then of_save()
End If
end event

event constructor;IF gb_sk_ver = True THEN  //hide for SK
	this.visible = false
end if
end event

type cb_submit from commandbutton within tabpage_submission
integer x = 2560
integer y = 8
integer width = 425
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&ubmit"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Create File and Send to CAQH FTP
//$<Author>: (Appeon) long.zhang 06.05.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If ib_processing = True Then Return 1
ib_processing = True

//Submit to CAQH
If of_submit() >0 Then
	//Refresh idw_files
	of_refresh_files(il_file_id)
End If

ib_processing = False
end event

type cb_save from commandbutton within tabpage_submission
integer x = 23
integer y = 8
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Save Submission details.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If of_save()> 0 Then
	//Messagebox("Save",'Successful.')
	If idw_files.Find('file_id = ' +String(il_file_id), 1, idw_files.rowcount()) = 0 Then
		of_refresh_files(il_file_id)
	End If
End If
end event

type dw_submit_browse from u_dw within tabpage_submission
integer x = 5
integer y = 224
integer width = 4297
integer height = 1636
integer taborder = 11
string dataobject = "d_caqh_roster_submit_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.of_setrowselect( true)
this.of_setupdateable(false)
end event

event doubleclicked;call super::doubleclicked;//====================================================================
//$<Event>: doubleclicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: Show idw_submit_detail.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF idw_submit_detail.RowCount() > 0 THEN
	tab_view_submit.SelectTab( 2 )
END IF

end event

event rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>: Select row and scroll idw_submit_detail to the same row.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer r

This.SelectRow( 0, False )
This.SelectRow( currentrow, True )

st_recs.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF idw_submit_detail.GetRow() <> currentrow THEN
	idw_submit_detail.ScrollToRow( currentrow )
	idw_submit_detail.SetRow( currentrow )
	If is_view_type = 'D' Then
		idw_submit_detail.TriggerEvent( "pfc_after_selected" )
	End If
END IF
end event

type cb_delete from commandbutton within tabpage_submission
integer x = 1147
integer y = 8
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Delete current record.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If idw_submit_browse.getrow()>0 Then idw_submit_browse.deleterow(idw_submit_browse.getrow())

of_refresh_submit_button()
end event

type cb_add from commandbutton within tabpage_submission
integer x = 384
integer y = 8
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Select provider.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

of_add("SELECT")
end event

type dw_submit_detail from u_dw within tabpage_submission
event pfc_after_selected ( )
event ue_post_scroll_detail ( )
integer x = 5
integer y = 224
integer width = 4489
integer height = 1640
integer taborder = 21
boolean hscrollbar = true
end type

event pfc_after_selected();//====================================================================
//$<Event>: pfc_after_selected
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Check layout rulers for current row.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i

//Check layout if it hasn't been send.
If not ib_send_status Then
	i = idw_submit_detail.getrow()
	If i > 0 Then inv_caqh_roster.of_check_layout_row(idw_submit_detail, i)
End If


end event

event ue_post_scroll_detail();//====================================================================
//$<Event>: ue_post_scroll_detail
//$<Arguments>:
//$<Return>:  (none)
//$<Description>: Scroll idw_submit_detail and idw_submit_browse.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Long ll_firstrow

ll_firstrow = Long(idw_submit_detail.Object.Datawindow.FirstRowOnPage)

If idw_submit_detail.getrow() <> ll_firstrow  and ll_firstrow >0 Then
	idw_submit_detail.SetRow(ll_firstrow)
	inv_caqh_roster.post of_check_layout_row(idw_submit_detail, ll_firstrow)
End If
	
If idw_submit_browse.getrow() <> ll_firstrow and ll_firstrow >0 Then
	idw_submit_browse.post setrow(ll_firstrow)	
End If
end event

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.of_setupdateable(true)
end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: Check layout rulers for current row.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If row > 0 Then 
	inv_caqh_roster.post of_check_layout_row(idw_submit_detail, row, False)
End If
end event

event scrollvertical;call super::scrollvertical;//====================================================================
//$<Event>: scrollvertical
//$<Arguments>:
// 	value    long    scrollpos
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Post event ue_post_scroll_detail()
end event

event mousemove;//====================================================================
//$<Event>: mousemove
//$<Arguments>:
// 	value    unsignedlong    flags
// 	value    integer         xpos
// 	value    integer         ypos
//$<Return>:  long
//$<Description>: Show tips for WEB version
//$<Author>: (Appeon) long.zhang 08.21.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String 	ls_object,ls_tag

if ib_ShowTipsHelp and AppeonGetClientType() <> 'PB' then 
	ls_Object = GetObjectAtPointer()
	ls_Object = left(ls_Object,Pos(ls_Object,"~t") -1)

	if len(ls_Object)>0 then 
		ls_tag = this.describe(ls_Object+".Tooltip.tip")
		//messagebox('ls_tag',ls_tag)
		if len(ls_tag) > 0 then 
			iuo_tips.settiptext(this,1,ls_tag)
		Else
			iuo_tips.settiptext(this,1,"")
		End If
	End If
	iuo_tips.relaymsg(this)
	is_last_object_tips  = ls_object 
End If
end event

event pfc_preupdate;call super::pfc_preupdate;//====================================================================
//$<Event>: pfc_preupdate
//$<Arguments>:
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.21.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

int li_rc, i, li_curr_row
Long ll_file_ids[]
String ls_file_names[]

li_rc = idw_submit_browse.RowCount()

//Check
idw_submit_detail.accepttext()

//Check current row of dw_detail first.
If is_view_type = 'D' Then 
	li_curr_row = idw_submit_detail.getrow() 
	If li_curr_row > 0 Then
		 inv_caqh_roster.of_check_layout_row(idw_submit_detail, li_curr_row, True)
		If idw_submit_detail.GetItemNumber(li_curr_row, 'err_flag') = 1 Then
			Messagebox("Save",'Current Row is not valid. ~r~nPlease check all rows with red row number.')
			return -1
		End If
	End If
End If

i = inv_caqh_roster.of_check_layout(idw_submit_browse)
If i < 0 Then
	Messagebox("Save",'Row ' + String(-i) + ' is not valid. ~r~nPlease check all rows with red row number.')
	idw_submit_browse.SetRow(-i)
	return -1
End If

//Set file id
If il_file_id = 0 Then 
	il_file_id = inv_caqh_roster.of_get_file_id()

	//new caqh_roster_files record
	ll_file_ids[1] = il_file_id
	i = inv_caqh_roster.of_log_file(inv_caqh_roster.IS_SUBMISSION,ll_file_ids[],ls_file_names[])
	If i < 0 Then
		Messagebox("Save",'Add log failed.')
		return -1
	End If
End If

FOR i = 1 TO li_rc
	If IsNull(idw_submit_browse.GetItemNumber( i, "file_id" )) Then
		idw_submit_browse.SetItem( i, "file_id", il_file_id )
	End If
Next

Return 1
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	value    long        row
// 	value    long        actionreturncode
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 10.12.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If dwo.name = 'b_clear' Then
	inv_caqh_roster.of_fix_na(this)
End If
end event

type tab_view_submit from tab within tabpage_submission
event pfc_cst_after_select ( )
event create ( )
event destroy ( )
integer y = 112
integer width = 4512
integer height = 1760
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_browse tabpage_browse
tabpage_details tabpage_details
end type

on tab_view_submit.create
this.tabpage_browse=create tabpage_browse
this.tabpage_details=create tabpage_details
this.Control[]={this.tabpage_browse,&
this.tabpage_details}
end on

on tab_view_submit.destroy
destroy(this.tabpage_browse)
destroy(this.tabpage_details)
end on

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF newindex = 1 THEN
	idw_submit_detail.Visible = False
	idw_submit_browse.Visible = True
	is_view_type = "B" //Browse
	idw_submit_browse.SetFocus()
ELSEIF newindex = 2 THEN
	idw_submit_browse.Visible = False
	idw_submit_detail.Visible = True
	is_view_type = "D" //Detail	
	idw_submit_detail.SetFocus()
End If


	

end event

event selectionchanging;//====================================================================
//$<Event>: selectionchanging
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF newindex = 1 or newindex = 2 THEN
	idw_submit_detail.TriggerEvent( "pfc_after_selected" )
End If
end event

type tabpage_browse from userobject within tab_view_submit
integer x = 18
integer y = 112
integer width = 4475
integer height = 1632
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Justify!"
long picturemaskcolor = 553648127
end type

type tabpage_details from userobject within tab_view_submit
integer x = 18
integer y = 112
integer width = 4475
integer height = 1632
long backcolor = 79741120
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
end type

type tabpage_exception from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4311
integer height = 1868
boolean enabled = false
long backcolor = 33551856
string text = "Exception File"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_exception dw_exception
end type

on tabpage_exception.create
this.dw_exception=create dw_exception
this.Control[]={this.dw_exception}
end on

on tabpage_exception.destroy
destroy(this.dw_exception)
end on

type dw_exception from u_dw within tabpage_exception
integer width = 4297
integer height = 1876
integer taborder = 21
string dataobject = "d_caqh_roster_exception"
boolean hscrollbar = true
end type

type tabpage_list from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4311
integer height = 1868
long backcolor = 33551856
string text = "Return Roster File"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_list_info st_list_info
st_list_rec st_list_rec
cb_9 cb_9
cb_8 cb_8
dw_roster_browse dw_roster_browse
dw_roster_detail dw_roster_detail
tab_view_list tab_view_list
end type

on tabpage_list.create
this.st_list_info=create st_list_info
this.st_list_rec=create st_list_rec
this.cb_9=create cb_9
this.cb_8=create cb_8
this.dw_roster_browse=create dw_roster_browse
this.dw_roster_detail=create dw_roster_detail
this.tab_view_list=create tab_view_list
this.Control[]={this.st_list_info,&
this.st_list_rec,&
this.cb_9,&
this.cb_8,&
this.dw_roster_browse,&
this.dw_roster_detail,&
this.tab_view_list}
end on

on tabpage_list.destroy
destroy(this.st_list_info)
destroy(this.st_list_rec)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.dw_roster_browse)
destroy(this.dw_roster_detail)
destroy(this.tab_view_list)
end on

type st_list_info from statictext within tabpage_list
integer x = 1586
integer y = 116
integer width = 1179
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "File Id"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_list_rec from statictext within tabpage_list
integer x = 2839
integer y = 116
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Record 1 of 1"
boolean focusrectangle = false
end type

type cb_9 from commandbutton within tabpage_list
integer x = 535
integer y = 12
integer width = 370
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Refresh"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Get latest  Return Roster file from CAQH FTP.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Int i

If ib_processing = True Then Return 1
ib_processing = True

// Open processs window
SetPointer(HourGlass!)
openwithparm( w_appeon_gifofwait, "Getting Return Roster File from CAQH FTP..." )

i = of_get_list()
If i > 0 Then //got new files
	//Refresh Max Return Roster file id, Refresh idw_roster_browse if needed.
	il_max_roster_id = inv_caqh_roster.of_get_max_roster_id()
	If ib_roster_retrieved Then	idw_roster_browse.Retrieve(il_max_roster_id)
	
	of_refresh_files(il_file_id)
End If

ib_processing = False
end event

type cb_8 from u_cb within tabpage_list
integer x = 32
integer y = 12
integer width = 485
integer height = 84
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Filter (Provider Id)"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: Find CAQH Return Roster file record by Provider Id. 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int i
Int li_cnt
String ls_filter
String ls_provider_id
datastore lds_provider_ids

gs_search lstr_search
gs_batch_search lstr_bat_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS"  

//Get Prac Ids
OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	idw_roster_browse.SetFilter('')
	idw_roster_browse.Filter()
	Return -1
END IF
	
lstr_bat_search = Message.Powerobjectparm

li_cnt = UpperBound( lstr_bat_search.li_prac_id[] )
If li_cnt > 0 Then
	lds_provider_ids = Create datastore
	lds_provider_ids.dataobject = 'd_caqh_roster_list_filter'
	lds_provider_ids.SetTransObject(sqlca);
	
	//Get Provider Ids
	li_cnt = lds_provider_ids.Retrieve( lstr_bat_search.li_prac_id[])
	If li_cnt > 0 Then
		For i = 1 to li_cnt
			ls_provider_id = lds_provider_ids.GetItemString(i, 'provider_id')
			If Not (IsNull(ls_provider_id) or Trim(ls_provider_id) = '') Then
				ls_filter += "'"+ ls_provider_id + "',"
			End If
		Next
		
		//Clear the last ','
		If LenA(ls_filter) > 0 Then ls_filter = LeftA(ls_filter, LenA(ls_filter) - 1)
		
		//Filter
		ls_filter = 'po_provider_id in ('+ ls_filter +')'
		idw_roster_browse.SetFilter(ls_filter)
		idw_roster_browse.Filter()	
	Else
		Messagebox("Filter error","Find no Provider id as filter condition.")
	End If
	
	Destroy lds_provider_ids
Else
	idw_roster_browse.SetFilter('')
	idw_roster_browse.Filter()
End If

Return
end event

type dw_roster_browse from u_dw within tabpage_list
integer y = 208
integer width = 4297
integer height = 1652
integer taborder = 30
string dataobject = "d_caqh_roster_list"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

this.of_setrowselect( true)
this.of_setupdateable(false)
end event

event doubleclicked;call super::doubleclicked;//====================================================================
//$<Event>: doubleclicked
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: Show Details.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF idw_roster_detail.RowCount() > 0 and dwo.type = 'column' THEN
	tab_view_list.SelectTab( 2 )
END IF

end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	value    long    currentrow
//$<Return>:  long
//$<Description>:Select row and Scroll idw_roster_detail.
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer r

This.SelectRow( 0, False )
This.SelectRow( This.GetRow(), True )

st_list_rec.Text = "Record " + String(This.GetRow()) + " of " + String(This.RowCount())

IF idw_roster_detail.GetRow() <> currentrow THEN
	idw_roster_detail.ScrollToRow( currentrow )
	idw_roster_detail.SetRow( currentrow )
END IF
end event

type dw_roster_detail from u_dw within tabpage_list
integer y = 212
integer width = 4297
integer height = 1648
integer taborder = 40
string dataobject = "d_caqh_roster_list_detail"
boolean hscrollbar = true
boolean vscrollbar = false
boolean livescroll = false
end type

type tab_view_list from tab within tabpage_list
event pfc_cst_after_select ( )
event create ( )
event destroy ( )
integer x = 5
integer y = 104
integer width = 4517
integer height = 1768
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_view_list.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_view_list.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;//====================================================================
//$<Event>: selectionchanged
//$<Arguments>:
// 	value    integer    oldindex
// 	value    integer    newindex
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF newindex = 1 THEN
	idw_roster_detail.Visible = False
	idw_roster_browse.Visible = True
ELSEIF newindex = 2 THEN
	idw_roster_browse.Visible = False
	idw_roster_detail.Visible = True
End If


	

end event

type tabpage_1 from userobject within tab_view_list
integer x = 18
integer y = 112
integer width = 4480
integer height = 1640
long backcolor = 79741120
string text = "Browse"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "Justify!"
long picturemaskcolor = 553648127
end type

type tabpage_2 from userobject within tab_view_list
integer x = 18
integer y = 112
integer width = 4480
integer height = 1640
long backcolor = 79741120
string text = "Detail"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
string picturename = "DataWindow5!"
long picturemaskcolor = 553648127
end type

type dw_1 from u_dw within pfc_cst_u_roster_sumbit
integer x = 73
integer y = 356
integer width = 3173
integer height = 1296
integer taborder = 40
string dataobject = "d_caqh_roster_list"
boolean hscrollbar = true
end type

