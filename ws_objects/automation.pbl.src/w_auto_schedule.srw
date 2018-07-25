$PBExportHeader$w_auto_schedule.srw
forward
global type w_auto_schedule from window
end type
type st_shutdown from statictext within w_auto_schedule
end type
type cb_viewlog from commandbutton within w_auto_schedule
end type
type cb_clear from commandbutton within w_auto_schedule
end type
type st_run_status from statictext within w_auto_schedule
end type
type cb_add from commandbutton within w_auto_schedule
end type
type st_running from statictext within w_auto_schedule
end type
type cb_on_off from commandbutton within w_auto_schedule
end type
type cb_save from commandbutton within w_auto_schedule
end type
type dw_browse from datawindow within w_auto_schedule
end type
type cb_delete from commandbutton within w_auto_schedule
end type
type cb_qiut from commandbutton within w_auto_schedule
end type
type cb_run from commandbutton within w_auto_schedule
end type
type cb_about from commandbutton within w_auto_schedule
end type
type r_on from rectangle within w_auto_schedule
end type
type lb_1 from listbox within w_auto_schedule
end type
type dw_verif from u_dw within w_auto_schedule
end type
type dw_verif_wc from u_dw within w_auto_schedule
end type
type dw_detail from datawindow within w_auto_schedule
end type
end forward

global type w_auto_schedule from window
integer x = 27
integer y = 288
integer width = 3717
integer height = 2824
boolean titlebar = true
string title = "IntelliSoft Scheduler"
boolean controlmenu = true
boolean minbox = true
long backcolor = 33551856
boolean center = true
st_shutdown st_shutdown
cb_viewlog cb_viewlog
cb_clear cb_clear
st_run_status st_run_status
cb_add cb_add
st_running st_running
cb_on_off cb_on_off
cb_save cb_save
dw_browse dw_browse
cb_delete cb_delete
cb_qiut cb_qiut
cb_run cb_run
cb_about cb_about
r_on r_on
lb_1 lb_1
dw_verif dw_verif
dw_verif_wc dw_verif_wc
dw_detail dw_detail
end type
global w_auto_schedule w_auto_schedule

type variables
Integer ii_on_off = 0
long il_shutdown_mins //maha 10.12.2016 - moved to instance variable

n_cst_scheduler inv_scheduler

//Sched types for IntelliCredApp or IntelliContract - alfee 11.28.2013
//String is_stype_num_ic = "10,20,31,32,33,34,36,37,41,4201,4202,43,50,60" //35
String is_ori_sql 
String is_stype_both = "10,20,34,60,70" //70, Added by Appeon long.zhang 12.03.2015
String is_stype_ctx = "35"
String is_stype_str_ic   = "Import~t10/Export~t20/AIQ-Exp Cred~t31/AIQ-Exp Appoint~t32/AIQ-Print Reset~t33/AIQ-WorkFlow~t34/AIQ-Notifications~t36/AIQ-Pending Change~t37/Verifi-OIG~t41/Verifi-NPDB Send~t4201/Verifi-NPDB Receive~t4202/Verifi-Web Crawler~t43/CAQH File Import~t50/CAQH-Return Roster~t53/CAQH-Roster Exception~t54/Report~t60/IntelliReport~t70"  //Add 53,54, by Appeon long.zhang 12.03.2015
String is_stype_str_ctx = "Import~t10/Export~t20/AIQ-WorkFlow~t34/AIQ-Emails~t35/Report~t60/IntelliReport~t70"

DateTime idt_shutdown   //alfee 12.04.2013
boolean ib_ok_to_close = true
boolean ib_auto_close = false //maha 10.12.2016

end variables

forward prototypes
public function integer of_checkfields ()
public function datetime of_get_shutdown_time ()
public function boolean of_is_shutdown_time (datetime adt_shutdown)
public function integer of_filter_ireport (datawindowchild ldwc_ireport)
public function integer of_check_rerun_fail ()
public function integer of_filter_srs_report (integer ai_sched_type, datawindowchild adwc_child)
end prototypes

public function integer of_checkfields ();//check require feild and prompt --Nova 01.30.2010 - v10.1 Scheduler Functionality
Long ll_Row

ll_Row = dw_detail.GetRow()
IF ll_Row <= 0 THEN RETURN 0

IF LenA(Trim(dw_detail.GetItemString(ll_Row, "sched_name"))) > 0 THEN
ELSE
	MessageBox("Save", "The Sched Name is a required column.")
	dw_detail.SetColumn("sched_name")
	dw_detail.SetFocus()
	RETURN -1
END IF

IF IsNull(dw_detail.Object.sched_type[ll_Row]) THEN
	MessageBox("Save", "The Sched Type is a required column.")
	dw_detail.SetColumn("sched_type")
	dw_detail.SetFocus()
	RETURN -1
END IF

IF IsNull(dw_detail.Object.run_overdue[ll_Row]) THEN
	MessageBox("Save", "The Run Overdue is a required column.")
	dw_detail.SetColumn("run_overdue")
	dw_detail.SetFocus()
	RETURN -1
END IF
IF IsNull(dw_detail.Object.interval_type[ll_Row]) THEN
	MessageBox("Save", "The Interval Type is a required column.")
	dw_detail.SetColumn("interval_type")
	dw_detail.SetFocus()
	RETURN -1
END IF


IF IsNull(dw_detail.Object.interval_length[ll_Row]) Or dw_detail.Object.interval_length[ll_Row] = 0 THEN
	MessageBox("Save", "The Interval Length is a required column.")
	dw_detail.SetColumn("interval_length")
	dw_detail.SetFocus()
	RETURN -1
END IF

IF IsNull(dw_detail.Object.next_start[ll_Row]) THEN
	MessageBox("Save", "The Next Start Time is a required column.")
	dw_detail.SetColumn("next_start")
	dw_detail.SetFocus()
	RETURN -1
END IF

IF IsNull(dw_detail.Object.active_status[ll_Row]) THEN
	MessageBox("Save", "The Status is a required column.")
	dw_detail.SetColumn("active_status")
	dw_detail.SetFocus()
	RETURN -1
END IF

IF dw_detail.Object.sched_type[ll_Row] = 10 THEN
	IF IsNull(dw_detail.Object.imp_project[ll_Row]) And IsNull(dw_detail.Object.imp_exp_option[ll_Row]) THEN
		MessageBox("Save", "Please select a Project or Import.")
		dw_detail.SetColumn("imp_project")
		dw_detail.SetFocus()
		RETURN -1
	END IF
END IF

IF dw_detail.Object.sched_type[ll_Row] = 20 THEN
	IF IsNull(dw_detail.Object.imp_exp_option[ll_Row]) THEN
		MessageBox("Save", "Please select an Export.")
		dw_detail.SetColumn("imp_project")
		dw_detail.SetFocus()
		RETURN -1
	END IF
	 IF IsNull(dw_detail.Object.export_reset_audit[ll_Row]) THEN
		MessageBox("Save", "Please select the export_reset_audit.")
		dw_detail.SetColumn("export_reset_audit")
		dw_detail.SetFocus()
		RETURN -1
	END IF
END IF

IF dw_detail.Object.sched_type[ll_Row] = 20 Or dw_detail.Object.sched_type[ll_Row] = 50 Or dw_detail.Object.sched_type[ll_Row] = 60 THEN
	IF IsNull(Trim(dw_detail.Object.file_path[ll_Row])) or LenA(Trim(dw_detail.Object.file_path[ll_Row]))=0 THEN
		MessageBox("Save", "Please input a File Path.")
		dw_detail.SetColumn("file_path")
		dw_detail.SetFocus()
		RETURN -1
	END IF
END IF

IF dw_detail.Object.sched_type[ll_Row] = 60 THEN
	IF PosA(Upper(Trim(dw_detail.Object.retrieve_query[ll_Row])),"SELECT",1) <> 1 or isnull(trim(dw_detail.Object.retrieve_query[ll_Row])) or LenA(trim(dw_detail.Object.retrieve_query[ll_Row]))=0 THEN
		MessageBox("Save", "Please input a SELECT Clause.")
		dw_detail.SetColumn("retrieve_query")
		dw_detail.SetFocus()
		RETURN -1
	END IF
	IF IsNull(Trim(dw_detail.Object.report_format[ll_Row])) or LenA(Trim(dw_detail.Object.report_format[ll_Row]))=0 THEN //alfee 03.17.2010
		MessageBox("Save", "Please select a Report Format.")
		dw_detail.SetColumn("report_format")
		dw_detail.SetFocus()
		RETURN -1
	END IF		
END IF

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 10.13.2016
//<$>reason:For Auto scheduler shut down not working Bug_id#5364.

////Start Code Change ----01.06.2016 #V15 maha - warning message
//if dw_detail.Object.reset_fail_time[ll_Row] = 1 and dw_detail.Object.retry_fail[ll_Row] = 1 then
//	MessageBox("Warning", "The 'Set next schedule time on failure' setting and the 'Retry Failed Report' setting are for separate functions and not designed to be used together.~rUsing them together may cause the next schedule time to be set in an unexpected manner.")
//end if
////End Code Change ----01.06.2016
if dw_detail.Object.reset_fail_time[ll_Row] = 0 and dw_detail.Object.retry_fail[ll_Row] = 1 then
	MessageBox("Warning", "The 'Set next schedule time on failure' setting and the 'Retry Failed Report' setting are for separate functions and not designed to be used together.~r~n")
end if
//------------------- APPEON END -------------------



RETURN 1



end function

public function datetime of_get_shutdown_time ();//====================================================================
//$<Function>: of_get_shutdown_time()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Get the shutdown time based on the setting for Auto Scheduler (for Windows version)
//$<Author>: (Appeon) Alfee 12.04.2013
//--------------------------------------------------------------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_day, li_hour, li_min, ls_second
Integer li_new_hour, li_new_min
//Long ll_shutdown_mins //10.12.2016 maha changed to instance variable; modified below
long ll_total_mins
DateTime ldt_shutdown
Date ld_current_date, ld_new_date
Time lt_current_time, lt_new_time

SetNull (ldt_shutdown)
ld_current_date = Today ()
lt_current_time = Now ()
li_hour = Hour (lt_current_time)
li_min = Minute (lt_current_time)
ls_second = Second (lt_current_time)

//SELECT set_76 INTO :il_shutdown_mins FROM icred_settings; //Start Code Change ----10.12.2016 #V152 maha - moved to open event

IF il_shutdown_mins > 0 THEN
	ll_total_mins = li_hour * 60 + li_min + il_shutdown_mins 
	li_day = ll_total_mins / 60 / 24
	debugbreak()
	ld_new_date = RelativeDate (ld_current_date, li_day)
	li_new_hour = (ll_total_mins  - li_day * 24 * 60) / 60
	li_new_min = Mod ((ll_total_mins  - li_day * 24 * 60),  60)
	lt_new_time = Time (li_new_hour, li_new_min, ls_second)
	ldt_shutdown = DateTime (ld_new_date, lt_new_time)
//Start Code Change ----10.12.2016 #V152 maha - set auto close variable
	IF appeongetclienttype () = "PB" AND NOT IsNull (idt_shutdown) THEN  //maha -moved from open event
		st_shutdown.text = "Scheduler will shut down at " + String(ldt_shutdown, "mm/dd/yyyy hh:mm:ss")
		st_shutdown.visible = TRUE
	END IF
	ib_auto_close = true
ELSE
	ib_auto_close = false
//End Code Change ----10.12.2016
END IF

RETURN ldt_shutdown


end function

public function boolean of_is_shutdown_time (datetime adt_shutdown);//====================================================================
//$<Function>: of_is_shutdown_time()
//$<Arguments>:
// 	value    datetime    adt_shutdown
//$<Return>:  boolean
//$<Description>: Determine if it's the shutdown tiime 
//$<Author>: (Appeon) Alfee 12.04.2013 (V141 ISG-CLX)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF IsNull(adt_shutdown) THEN RETURN FALSE

IF DateTime(Today(), Now()) >= adt_shutdown THEN RETURN TRUE

RETURN FALSE

end function

public function integer of_filter_ireport (datawindowchild ldwc_ireport);//====================================================================
//$<Function>: of_filter_ireport
//$<Arguments>:
// 	value    datawindowchild    ldwc_ireport
//$<Return>:  integer
//$<Description>: Filter dddw for ireport schedule type.
//$<Author>: (Appeon) long.zhang 12.03.2015 (Contract Ireport not showing in the scheduler dropdown Case#60457 Bug_id#4866)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filter = ""

If gi_prod_setting = 4 Then //IntelliContract
	ls_filter = "module = 1"
Else		
	If Not gb_contract_module Then 
		ls_filter = "module = 2"
	Else//All modules
		ls_filter = ""
	End If	
End If

ldwc_ireport.setfilter(ls_filter)

Return ldwc_ireport.filter()
end function

public function integer of_check_rerun_fail ();//Start Code Change ----10.12.2016 #V152 maha - 
integer r
integer f

if il_shutdown_mins = 0 then return 1

For r = 1 to dw_browse.rowcount()
	IF dw_browse.GetItemNumber( r, "active_status") <> 1 THEN 
		CONTINUE
	else
		f = dw_browse.GetItemNumber(r, "retry_fail") 
		if f  > 0 and il_shutdown_mins > 0 then //il_shutdown_mins is set in of_get_shutdown_time()
			st_shutdown.text = "Auto shutdown is disabled due to active Retry Failed Report setting."
			st_shutdown.visible = true
			ib_auto_close = false
			EXIT
		end if
	end if
next

return 1
end function

public function integer of_filter_srs_report (integer ai_sched_type, datawindowchild adwc_child);//====================================================================
//$<Function>: of_filter_srs_report
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.19.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_type

if not(ai_sched_type =20 or ai_sched_type = 70) then return 1
if ai_sched_type=20 then
	ls_type = 'E'
ELSE
	ls_type = 'C'
end if

adwc_child.setfilter("report_type='"+ls_type+"'")
adwc_child.filter()
adwc_child.insertrow(1)
return 1
end function

on w_auto_schedule.create
this.st_shutdown=create st_shutdown
this.cb_viewlog=create cb_viewlog
this.cb_clear=create cb_clear
this.st_run_status=create st_run_status
this.cb_add=create cb_add
this.st_running=create st_running
this.cb_on_off=create cb_on_off
this.cb_save=create cb_save
this.dw_browse=create dw_browse
this.cb_delete=create cb_delete
this.cb_qiut=create cb_qiut
this.cb_run=create cb_run
this.cb_about=create cb_about
this.r_on=create r_on
this.lb_1=create lb_1
this.dw_verif=create dw_verif
this.dw_verif_wc=create dw_verif_wc
this.dw_detail=create dw_detail
this.Control[]={this.st_shutdown,&
this.cb_viewlog,&
this.cb_clear,&
this.st_run_status,&
this.cb_add,&
this.st_running,&
this.cb_on_off,&
this.cb_save,&
this.dw_browse,&
this.cb_delete,&
this.cb_qiut,&
this.cb_run,&
this.cb_about,&
this.r_on,&
this.lb_1,&
this.dw_verif,&
this.dw_verif_wc,&
this.dw_detail}
end on

on w_auto_schedule.destroy
destroy(this.st_shutdown)
destroy(this.cb_viewlog)
destroy(this.cb_clear)
destroy(this.st_run_status)
destroy(this.cb_add)
destroy(this.st_running)
destroy(this.cb_on_off)
destroy(this.cb_save)
destroy(this.dw_browse)
destroy(this.cb_delete)
destroy(this.cb_qiut)
destroy(this.cb_run)
destroy(this.cb_about)
destroy(this.r_on)
destroy(this.lb_1)
destroy(this.dw_verif)
destroy(this.dw_verif_wc)
destroy(this.dw_detail)
end on

event open;Integer i	
Integer c
datawindowchild ldwc_1

dw_browse.SetTransObject(SQLCA)
dw_detail.SetTransObject(SQLCA)
dw_verif.SetTransObject(SQLCA)
dw_verif_wc.SetTransObject(SQLCA)

is_ori_sql = dw_detail.GetSqlSelect () //BugA112101  - Eugene 11.28.2013

dw_detail.Retrieve()
dw_detail.ShareData( dw_browse)

IF IsValid(inv_scheduler) then 	
	inv_scheduler.idw_verif = dw_verif
	inv_scheduler.idw_verif_wc = dw_verif_wc
	inv_scheduler.ilb_1	= lb_1
	dw_detail.sharedata(inv_scheduler.ids_schedule)	
END IF

ii_on_off = 0
r_on.FillColor = RGB(255,0,0)
cb_on_off.Text = 'SCHEDULER &OFF'

if dw_detail.rowcount( )=0 then
	dw_detail.insertrow( 0)
end if

//Web based scheduler - alfee 01.26.2011
//if AppeonGetClientType() = 'WEB' and gb_AutoSchedule then
if gb_AutoSchedule then //Ticket # 00031237 - alfee 08.10.2011
	SELECT set_76 INTO :il_shutdown_mins FROM icred_settings;  //Start Code Change ----10.12.2016 #V152 maha - moved from of_get_shutdown_time
//	//---------Begin Added by (Appeon)Alfee 12.04.2013 -------------------
	idt_shutdown = of_get_shutdown_time () 
//Start Code Change ----10.12.2016 #V152 maha - moved to of_get_shutdown_time
//	IF appeongetclienttype () = "PB" AND NOT IsNull (idt_shutdown) THEN
//		st_shutdown.text += String(idt_shutdown, "mm/dd/yyyy hh:mm:ss")
//		st_shutdown.visible = TRUE
//	END IF
	//---------End Added ---------------------------------------------------------
	of_check_rerun_fail( )  //Start Code Change ----10.12.2016 #V152 maha - check to see if autoshutdow should be turned off
	cb_on_off.event clicked() //turn on switch
	gi_email_type = 0  //Start Code Change ----12.11.2012 #V12 maha - if opened as scheduler, set to easymail
end if

//---------Begin Added by (Appeon)Stephen 05.19.2017 for V15.4-WebView Reporting Functionality--------
//if w_mdi.of_security_access( 7845 ) <> 1 then
//	dw_detail.modify("report_storage_id.visible='0'")
//	dw_detail.modify("report_storage_id_t.visible='0'")
//end if
if dw_detail.getchild("report_storage_id", ldwc_1) = 1 then
	ldwc_1.settransobject(sqlca)
	ldwc_1.retrieve(gs_user_id)
	ldwc_1.insertrow(1)
end if	
//---------End Added ------------------------------------------------------

// Move window position
//IF gb_AutoSchedule THEN
//	This.Post Move(0, 0)
//END IF






end event

event close;if gb_AutoSchedule then 
	//DISCONNECT Using SQLCA;
	halt //close //web based scheduler - alfee 01.26.2011
end if




end event

event timer;
//---------Begin Modified by (Appeon)Stephen 07.01.2015 for Bug # 4579 - Scheduler auto shutdown is not working case # 55316--------
/*
//---------Begin Added by (Appeon)Alfee 12.04.2013 ------------------------------
IF appeongetclienttype () = "PB" AND gb_AutoSchedule AND of_is_shutdown_time (idt_shutdown) THEN
	Close (This)
	RETURN
END IF
//---------End Added ------------------------------------------------------------------
*/

IF gb_AutoSchedule AND of_is_shutdown_time (idt_shutdown) THEN   //Start Code Change ----05.19.2015 #V15 maha
	if ib_ok_to_close and ib_auto_close then  //Start Code Change ----10.12.2016 #V15 maha  - added auto_close variable
	//if ib_ok_to_close then  //Start Code Change ----05.20.2015 #V15 maha  - added close ie function
		IF AppeonGetClientType() = 'WEB' THEN  //Start Code Change ----05.19.2015 #V15 maha  - added close ie function
			of_close_iewin ("Appeon Web Library") 
			RETURN
		else
			Close (This)
			RETURN
		END IF
	end if
END IF
//---------End Modfiied ------------------------------------------------------

//messagebox("timer", "run")
inv_scheduler.of_timer()//Begin to run schedule 
end event

event closequery;integer li_ret
dw_detail.accepttext()
if dw_detail.modifiedcount() <> 0 or dw_detail.deletedcount() <> 0 then
	li_ret = MessageBox("Save Data", "Do you want to save the current data?", Question!, YesNo!, 1)
	IF li_ret = 1 THEN
		cb_save.event clicked()	
		if dw_detail.modifiedcount() <> 0 or dw_detail.deletedcount() <> 0 then
			return 1
		end if		
	END IF	
end if

return 0


end event

type st_shutdown from statictext within w_auto_schedule
boolean visible = false
integer x = 41
integer y = 160
integer width = 3447
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Scheduler will shut down at "
boolean focusrectangle = false
end type

type cb_viewlog from commandbutton within w_auto_schedule
integer x = 2382
integer y = 48
integer width = 306
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Log"
end type

event clicked;String ls_values

//ls_values = dw_browse.Object.sched_type.Values
ls_values = dw_detail.Object.sched_type.Values //BugA112101 - Eugene 11.28.2013
OpenWithParm(w_schedule_logview,ls_values)

end event

type cb_clear from commandbutton within w_auto_schedule
boolean visible = false
integer x = 937
integer y = 36
integer width = 101
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear status bar"
end type

event clicked;//st_run_status.text=""
//gf_messagebox("fff","ddd",Question!,yesno!,1,true)
//n_cst_message n_message
//n_message =Create n_cst_message
//gb_AutoSchedule= false
//n_message.messagebox("aa","aab",true)
//n_message.messagebox("aa","aab",question!,true)
//n_message.messagebox("aa","aab",question!,yesno!,true)
//n_message.messagebox("aa","aab",question!,yesnocancel!,2,true)

//messagebox("",datetime(string(today(),"mm/dd/yyyy hh:mm")))

//em_1.text=string(today(),"mm/dd/yyyy hh:mm")

   messagebox("email type", gi_email_type )

end event

type st_run_status from statictext within w_auto_schedule
boolean visible = false
integer x = 32
integer y = 2676
integer width = 3662
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 8388608
long backcolor = 32233416
boolean focusrectangle = false
end type

type cb_add from commandbutton within w_auto_schedule
integer x = 1755
integer y = 48
integer width = 306
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//add new schedule item
Long ll_rowcnt
ll_rowcnt = dw_detail.InsertRow(0)
dw_detail.ScrollToRow(ll_rowcnt)
dw_browse.ScrollToRow(ll_rowcnt)





end event

type st_running from statictext within w_auto_schedule
boolean visible = false
integer x = 622
integer y = 48
integer width = 306
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
string text = "Running"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;//if ii_on_off = 0 then
//	ii_on_off = 1
//	this.text = "ON"
//	this.backcolor = 8453888
//else 
//	ii_on_off = 0
//	this.text = "OFF"
//	this.backcolor = RGB(255,0,0)
//end if
end event

type cb_on_off from commandbutton within w_auto_schedule
integer x = 50
integer y = 48
integer width = 517
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "SCHEDULER &ON"
end type

event clicked;Integer i
integer res //maha 04.13.2016

//Save setting before started
cb_save.TriggerEvent(Clicked!)

IF ii_on_off = 0 THEN
	//Start Code Change ----04.13.2016 #V15 maha - try to prevent user from turning on.
	if gb_autoschedule then
		//leave
	else
		res = messagebox("Turning Scheduler ON", "If there is any chance that the Scheduler is running elsewhere, you should not turn it on in Setup, as it may cause it to fail ( or in the case of Imports corrupted data).~rAre you sure that it safe to turn it on now?", question!,yesno!, 2)
		if res = 2 then return
	end if
	//End  Code Change ----04.13.2016
	
	ii_on_off = 1
	This.Text = "SCHEDULER &ON"
	r_on.FillColor = 8453888	

	//-----Begin Added by alfee 01.26.2011----------------------------	
	//Web based scheduler
	IF AppeonGetClientType() = 'WEB' AND gb_AutoSchedule THEN 
		//Trigger it immediately
		inv_scheduler.of_timer () 	
		//Close the IE window 
		//---------Begin Commented by (Appeon)Stephen 05.31.2013 for  Bug # 4579 - Scheduler auto shutdown is not working case # 55316---------
//		of_close_iewin ("Appeon Web Library")
//		RETURN
		//---------End Commented ------------------------------------------------------

	END IF
	//-----End Added -----------------------------------------------------
	
	//Check & warning for overdue items
	FOR i = 1 To dw_browse.RowCount()
		IF dw_browse.GetItemNumber(i,"active_status") = 1 AND &
			dw_browse.GetItemString(i,"run_overdue") = '0' THEN
			IF dw_browse.GetItemDateTime(i,"next_start") < DateTime(Today(),Now()) THEN
				if not gb_AutoSchedule then  //Start Code Change ----10.12.2016 #V152 maha - block the message if auto scheduler
					MessageBox("Warning","One or more of your active schedules' next start date is past. You may want to reset.")
				end if
				EXIT
			END IF
		END IF
	NEXT
	//start timer - default 1 minute
	Timer(60)	
ELSE
	ii_on_off = 0
	This.Text = "SCHEDULER &OFF"
	r_on.FillColor = RGB(255,0,0)
	//stop timer 
	Timer(0)		
END IF


end event

type cb_save from commandbutton within w_auto_schedule
integer x = 1445
integer y = 48
integer width = 306
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;
dw_detail.accepttext( )  //Start Code Change ----09.29.2014 #V14.2 maha - moved from lower.
IF dw_detail.modifiedcount() < 1 and dw_detail.deletedcount() < 1 then return

//Start Code Change ----10.12.2016 #V152 maha - added
IF gb_AutoSchedule then
	of_get_shutdown_time( )
	of_check_rerun_fail( )
End if
//End Code Change ----10.12.2016


IF of_CheckFields() = -1 THEN RETURN // check require field

IF dw_detail.Update() = 1 THEN
	COMMIT Using sqlca;
ELSE
	ROLLBACK Using sqlca;
END IF


end event

type dw_browse from datawindow within w_auto_schedule
integer x = 32
integer y = 240
integer width = 3657
integer height = 1008
integer taborder = 80
string dataobject = "d_sched_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;IF row > 0 THEN
	This.SelectRow( 0, False)
	This.SelectRow( row, True)
END IF

end event

event rowfocuschanged;datawindowchild ldwc_1

IF currentrow > 0 THEN
	
	dw_detail.ScrollToRow(currentrow)
	This.SelectRow( 0, False)
	This.SelectRow( currentrow, True)
	
	IF dw_detail.Object.sched_type[currentrow] = 10 THEN //import
		dw_detail.Modify("imp_exp_option_t.Text='Import:'")
		DataWindowChild ldwc_project
		DataWindowChild ldwc_import
		//dw_detail.Modify("imp_project.DDDW.Name=d_dddw_import_project")
		dw_detail.Modify("imp_project.DDDW.Name='d_dddw_import_project'") //alfee 01.28.2011
		//dw_detail.Modify("imp_exp_option.DDDW.Name=d_dddw_import")
		dw_detail.Modify("imp_exp_option.DDDW.Name='d_dddw_import'")	//alfee 01.28.2011	
		dw_detail.Modify("imp_project.DDDW.DataColumn='project_id'")
		dw_detail.Modify("imp_project.DDDW.DisplayColumn='project_name'")
		dw_detail.Modify("imp_exp_option.DDDW.DataColumn='import_id'")
		dw_detail.Modify("imp_exp_option.DDDW.DisplayColumn='import_name'")
		dw_detail.GetChild("imp_project", ldwc_project)
		dw_detail.GetChild("imp_exp_option", ldwc_import)
		ldwc_project.SetTransObject(SQLCA)
		ldwc_import.SetTransObject(SQLCA)
		
		gnv_appeondb.of_StartQueue()
		ldwc_project.Retrieve()
		ldwc_import.Retrieve()
		gnv_appeondb.of_CommitQueue()
		ldwc_project.InsertRow(1)
		ldwc_import.InsertRow(1)
	ELSEIF dw_detail.Object.sched_type[currentrow] = 20 THEN //export
		dw_detail.Modify("imp_exp_option_t.Text='Export:'")
		DataWindowChild ldwc_export
		//dw_detail.Modify("imp_exp_option.DDDW.Name=d_dddw_export_files")
		dw_detail.Modify("imp_exp_option.DDDW.Name='d_dddw_export_files'")	//alfee 01.28.2011	
		dw_detail.Modify("imp_exp_option.DDDW.DataColumn='export_id'")
		dw_detail.Modify("imp_exp_option.DDDW.DisplayColumn='export_name'")
		dw_detail.GetChild("imp_exp_option", ldwc_export)
		ldwc_export.SetTransObject(SQLCA)
		ldwc_export.Retrieve()
		ldwc_export.InsertRow(1)
	ELSEIF dw_detail.Object.sched_type[currentrow] = 60 THEN //report - restore the excel8 option - alfee 09.17.2013
		 IF AppeonGetClientType() = 'PB' THEN
			//dw_detail.Modify("report_format.Values='Excel	Excel!//Text	Text!/CSV	CSV!/HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/'")//HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/
			dw_detail.Modify("report_format.Values='Excel	Excel!/Excel8	Excel8!/Text	Text!/CSV	CSV!/HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/'")//HTMLTable	HTMLTable!/XML	XML!/PDF	PDF!/
		ELSE
			dw_detail.Modify("report_format.Values='Excel	Excel!/Excel8	Excel8!/Text	Text!/HTMLTable	HTMLTable!/'")
		END IF
	ELSEIF dw_detail.Object.sched_type[currentrow] = 70 THEN //(Appeon)Stephen 03.28.2014 - V142 Schedule IntelliReport
		DataWindowChild ldwc_ireport
		dw_detail.Modify("imp_exp_option_t.Text='IntelliReport:'")
		dw_detail.Modify("imp_exp_option.DDDW.Name='d_dddw_intellireport'")
		dw_detail.Modify("imp_exp_option.DDDW.DataColumn='view_id'")
		dw_detail.Modify("imp_exp_option.DDDW.DisplayColumn='view_name'")
		dw_detail.GetChild("imp_exp_option", ldwc_ireport)
		ldwc_ireport.SetTransObject(SQLCA)
		ldwc_ireport.Retrieve()
		
		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 12.03.2015
		//<$>reason:For Contract Ireport not showing in the scheduler dropdown Case#60457 Bug_id#4866
	
//		//---------Begin Added by (Appeon)Stephen 06.05.2015 for Bug # 4546 - The IntelliRport label is truncated when setting up IReport in the scheduler--------
//		if gb_contract_version then
//			ldwc_ireport.setfilter("module in(1,4)")
//			ldwc_ireport.filter()
//		else
//			ldwc_ireport.setfilter("module in(2,4)")
//			ldwc_ireport.filter()
//		end if
//		//---------End Added ------------------------------------------------------
		
		of_filter_ireport(ldwc_ireport)
		//------------------- APPEON END -------------------	
		
	END IF
	
	//---------Begin Added by (Appeon)Stephen 05.19.2017 for V15.4-WebView Reporting Functionality--------
	dw_detail.getchild("report_storage_id", ldwc_1)
	of_filter_srs_report(dw_detail.Object.sched_type[currentrow], ldwc_1)
	dw_detail.setfocus()
	dw_detail.setcolumn("sched_name")
	//---------End Added ------------------------------------------------------

END IF



end event

event resize;long ly
long lh

//2276

ly = this.height + this.y

//lh = 2276 - ly + 10
dw_detail.y = ly
dw_detail.height = 2666 - ly
end event

type cb_delete from commandbutton within w_auto_schedule
integer x = 2066
integer y = 48
integer width = 306
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Long ll_Row,ll_OldRow,ll_cnt

ll_OldRow = dw_browse.GetRow( )

//Prompt user before deletes.
IF ll_OldRow > 0 THEN
	IF MessageBox("Delete", "Are you sure you want to delete the selected Auto Schedule?", Question!, YesNo!) = 2 THEN
		RETURN
	END IF
END IF

dw_browse.DeleteRow(0)

IF dw_browse.Update() = 1 THEN
	COMMIT;
ELSE
	ROLLBACK;
END IF

ll_cnt = dw_browse.RowCount( )
IF ll_OldRow <= ll_cnt THEN
	ll_Row = ll_OldRow
ELSEIF ll_cnt > 0 THEN
	ll_Row = ll_cnt
ELSE
	ll_Row = 0
END IF

IF ll_Row > 0 THEN
	dw_browse.ScrollToRow(ll_Row)
	dw_browse.SetRow( ll_Row )
	dw_browse.Event RowFocusChanged(ll_Row)
END IF

end event

type cb_qiut from commandbutton within w_auto_schedule
integer x = 3273
integer y = 48
integer width = 306
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;CLOSE(PARENT)

end event

type cb_run from commandbutton within w_auto_schedule
integer x = 2693
integer y = 48
integer width = 306
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Test Item"
end type

event clicked;
Integer li_sched_id, li_row

cb_save.TriggerEvent(Clicked!)

li_row = dw_detail.getrow()
IF li_row < 1 THEN RETURN 

li_sched_id = dw_detail.getItemNumber(li_row, "sched_id")
inv_scheduler.of_test_item(li_sched_id)

st_running.Visible = False


end event

type cb_about from commandbutton within w_auto_schedule
integer x = 3008
integer y = 48
integer width = 261
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&bout"
end type

event clicked;//messagebox("The Auto Export program :","See Auto Export Manual~r~r~rCopyright 2002-2003 IntelliSoft Group Inc~r1~rversion 2.0 ")
//MessageBox("The Scheduler program :", "Copyright 2010 IntelliSoft Group Inc~r1~rversion 10.1 ")
open(w_about_ic)  //Start Code Change ----02.21.2017 #V153 maha - changed to open about window.
end event

type r_on from rectangle within w_auto_schedule
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 65280
integer x = 23
integer y = 28
integer width = 576
integer height = 124
end type

type lb_1 from listbox within w_auto_schedule
boolean visible = false
integer x = 2693
integer y = 648
integer width = 411
integer height = 324
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type dw_verif from u_dw within w_auto_schedule
boolean visible = false
integer x = 923
integer y = 400
integer height = 528
integer taborder = 110
string dataobject = "d_ver_summary_record_view_for_sched"
end type

type dw_verif_wc from u_dw within w_auto_schedule
boolean visible = false
integer x = 923
integer y = 400
integer height = 528
integer taborder = 120
string dataobject = "d_web_crawler_ama_verif_info"
end type

type dw_detail from datawindow within w_auto_schedule
integer x = 32
integer y = 1248
integer width = 3662
integer height = 1408
integer taborder = 90
string dataobject = "d_sched_detail"
boolean livescroll = true
end type

event constructor;
datawindowchild ldwc_export

this.getchild("export_id",ldwc_export)
If gb_contract_version Then
	ldwc_export.setfilter("export_type in (3,4)")
	ldwc_export.filter()
Else
	ldwc_export.setfilter('')
	ldwc_export.filter()
End If

//Filter schedule types - Eugene 11.28.2013 for BugA112101 
IF NOT gb_contract_module THEN //IntelliCred&App only
	This.Modify ("sched_type.Values = '" + is_stype_str_ic + "'")
ELSEIF gb_contract_version THEN //IntelliContract only
	This.Modify ("sched_type.Values = '" + is_stype_str_ctx + "'")			
ELSE										//Both
	//Do nothing
END IF

end event

event buttonclicked;datetime ldt_nexttime
String docname, named, path
String ls_path,ls_ext
String ls_pro_path
Long i
String ls_extend
Integer Value, ao
Long ll_pos,ll_pos_last
long  ll_sched_type
//browse button
//---------Begin Modified by (Appeon)Stephen 04.23.2014 for V142 Schedule IntelliReport--------
//IF dwo.Name = "b_browse" And This.GetItemNumber( row, "sched_type") <> 50  And This.GetItemNumber( row, "sched_type") <> 60 THEN //value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
ll_sched_type = This.GetItemNumber( row, "sched_type")
IF dwo.Name = "b_browse" And ll_sched_type <> 50  And ll_sched_type <> 60 and ll_sched_type <> 70 THEN 
//---------End Modfiied ------------------------------------------------------
	IF AppeonGetClientType() = 'PB' THEN
		Value = GetFileSaveName("Save As File",&
			+ docname, named, "DOC", &
			+ "Excel (*.xls),*.xls," &
			+ "Text (*.txt),*.txt," &
			+ "CSV (*.csv),*.csv")
	ELSE
		Value = GetFileSaveName("Save As File",&
			+ docname, named, "DOC", &
			+ "Excel (*.xls),*.xls," &
			+ "Text (*.txt),*.txt")
	END IF
ELSEIF dwo.Name = "b_browse" And This.GetItemNumber( row, "sched_type") = 50 THEN
	ls_path =  gs_temp_path
	GetFolder ( "Select Caqh import file folder", ls_path )
	
	IF RightA(ls_path, 1 ) <> "\" THEN ls_path+= "\"
	IF Not directoryexists(ls_path + "Processed") THEN
		ls_pro_path = ls_path + "Processed\"
		CreateDirectoryA(ls_pro_path, 0)
	END IF
	//.xls	  Excel!	Excel	0	Microsoft Excel format.
	//.txt	  Text!	Text	1	(Default) Tab-separated columns with a return at the end of each row.
	//.csv	  CSV!	CSV	2	Comma-separated values.
	//.xls	  SYLK!	SYLK	3	Microsoft Multiplan format.
	//.wks	  WKS!	WKS	4	Lotus 1-2-3 format.
	//.wk1	  WK1!	WK1	5	Lotus 1-2-3 format.
	//.dif	  DIF!	DIF	6	Data Interchange Format.
	//.dbf	  dBASE2!	dBASE2	7	dBASE-II format.
	//.dbf	  dBASE3!	dBASE3	8	dBASE-III format.
	//	  SQLInsert!	SQLInsert	9	SQL syntax.
	//	  Clipboard!	Clipboard	10	Save an image of the graph to the clipboard.
	//	  PSReport!	PSReport	11	Powersoft Report (PSR) format.
	//.wmf	  WMF!	WMF	12	Windows Metafile format.
	//.html	  HTMLTable!	HTMLTable	13	HTML TABLE, TR, and TD elements.
	//.xls	  Excel5!	Excel5	14	Microsoft Excel Version 5 format.
	//.xml	  XML!	XML	15	Extensible Markup Language (XML).
	//.fo	  XSLFO!	XSLFO	16	XSL (Extensible Stylesheet Language) Formatting Objects (XSL-FO).
	//.pdf	  PDF!	PDF	17	Portable Document Format (PDF).
	//.xls	  Excel8!	Excel8	18	Microsoft Excel Version 8 and higher format.
	//	
	
ELSEIF dwo.Name = "b_browse" And This.GetItemNumber( row, "sched_type") = 60 THEN
	IF IsNull(This.GetItemString( row, "report_format")) THEN
		IF AppeonGetClientType() = 'PB' THEN
			Value = GetFileSaveName("Save As File",&
				+ docname, named, "DOC", &
				+ "Excel (*.xls),*.xls," &
				+ "Text (*.txt),*.txt," &
				+ "CSV (*.csv),*.csv," &
				+ "HTMLTable (*.html),*.html," &
				+ "XML (*.xml),*.xml," &
				+ "PDF (*.pdf),*.pdf")
		ELSE
			Value = GetFileSaveName("Save As File",&
				+ docname, named, "DOC", &
				+ "Excel (*.xls),*.xls," &
				+ "Text (*.txt),*.txt," &
				+ "HTMLTable (*.html),*.html," &
				+ "PDF (*.pdf),*.pdf")
		END IF
		
	ELSE
		CHOOSE CASE Trim(This.GetItemString( row, "report_format"))
			CASE  'Excel!'
				ls_extend = "Excel (*.xls),*.xls"
			CASE  'Text!'
				ls_extend = "Text (*.txt),*.txt"
			CASE  'CSV!'
				ls_extend = "CSV (*.csv),*.csv"
			CASE  'HTMLTable!'
				ls_extend = "HTMLTable (*.html),*.html"
			CASE  'XML!'
				ls_extend = "XML (*.xml),*.xml"
			CASE  'PDF!'
				ls_extend = "PDF (*.pdf),*.pdf"
			CASE ELSE
				/*statementblock*/
		END CHOOSE
		Value = GetFileSaveName("Save As File",&
			+ docname, named, "DOC", &
			+ls_extend)
	END IF
	// reset button
Elseif dwo.Name = "b_browse" And ll_sched_type = 70 THEN  //(Appeon)Stephen 04.23.2014 - V142 Schedule IntelliReport
	Value = GetFileSaveName("Save As File",&
			+ docname, named, "PDF", &
			+ "Pdf (*.pdf),*.pdf")
			
ELSEIF dwo.Name = "b_interval"  THEN
	ldt_nexttime = of_next_run_time(dw_detail.GetItemNumber(row,"interval_length"), dw_detail.GetItemNumber(row,"interval_type") , date(string(today(),'mm/dd/yyyy')),time(string(RelativeTime (now(), 120 ),'hh:mm:000')))
	dw_detail.SetItem(row,"next_start",ldt_nexttime)
	RETURN
END IF

IF Value = 1 THEN
	ll_pos = PosA(docname,'.',1)
	ll_pos_last = ll_pos
	DO WHILE ll_pos > 0
		ll_pos = PosA(docname,'.',ll_pos+1)
		IF ll_pos > 0 THEN ll_pos_last = ll_pos
	LOOP
	
	path  = MidA(docname,1,ll_pos_last -1 ) //path and file w/out extension
	//ll_pos = Pos(named,'.',1)
	ls_ext = MidA(docname,ll_pos_last,10)
	This.SetItem(row,"file_path",path)
	CHOOSE CASE ls_ext
		CASE  ".xls"
			ls_ext = 'Excel!'
		CASE   ".txt"
			ls_ext = 'Text!'
		CASE  ".csv"
			ls_ext = 'CSV!'
		CASE  ".html"
			ls_ext = 'HTMLTable!'
		CASE  ".xml"
			ls_ext = 'XML!'
		CASE  ".pdf"
			ls_ext = 'PDF!'
		CASE ELSE
			/*statementblock*/
	END CHOOSE
	This.SetItem(row,"report_format",ls_ext)
ELSE
	This.SetItem(row,"file_path",ls_path)
END IF








end event

event itemchanged;Long ll_null
String ls_null
Long ll_export_id
long  ll_srs_id
String ls_sql
String ls_save_path
String ls_filter
datawindowchild ldwc_1

SetNull(ls_null)
SetNull(ll_null)
//string type
//file_path
//retrieve_query
//report_format
//error_code
This.AcceptText()
//IF dwo.Name = 'sched_type' And Data <> '42' THEN
//	This.SetItem(row,"sched_sub_type",ll_null)
//END IF

IF dwo.Name = 'sched_type' And Data <> '20' THEN
	This.SetItem(row,"export_reset_audit",ll_null)
END IF

IF dwo.Name = 'sched_type' And (Data <> '10' Or Data <> '20') THEN
	This.SetItem(row,"imp_exp_option",ll_null)
END IF

IF dwo.Name = 'sched_type' And (Data <> '10' ) THEN
	This.SetItem(row,"imp_project",ll_null)
END IF

IF dwo.Name = 'sched_type' And (Data <> '60' Or Data <> '20') THEN
	This.SetItem(row,"retrieve_query",ls_null)
END IF

IF dwo.Name = 'sched_type' And (Data <> '60' Or Data <> '20' Or Data <> '50') THEN
	This.SetItem(row,"file_path",ls_null)
END IF

IF dwo.Name = 'sched_type' And (Data <> '60') THEN
	This.SetItem(row,"report_format",ls_null)
END IF

IF dwo.Name = 'sched_type' And Data = '10' THEN
	This.Modify("imp_exp_option_t.Text='Import'")
	DataWindowChild ldwc_project
	DataWindowChild ldwc_import
	//This.Modify("imp_project.DDDW.Name=d_dddw_import_project")
	This.Modify("imp_project.DDDW.Name='d_dddw_import_project'")  //alfee 01.28.2011
	//This.Modify("imp_exp_option.DDDW.Name=d_dddw_import")
	This.Modify("imp_exp_option.DDDW.Name='d_dddw_import'")	//alfee 01.28.2011	
	This.Modify("imp_project.DDDW.DataColumn='project_id'")
	This.Modify("imp_project.DDDW.DisplayColumn='project_name'")
	This.Modify("imp_exp_option.DDDW.DataColumn='import_id'")
	This.Modify("imp_exp_option.DDDW.DisplayColumn='import_name'")
	This.GetChild("imp_project", ldwc_project)
	This.GetChild("imp_exp_option", ldwc_import)
	ldwc_project.SetTransObject(SQLCA)
	ldwc_import.SetTransObject(SQLCA)
	
	gnv_appeondb.of_StartQueue()
	ldwc_project.Retrieve()
	ldwc_import.Retrieve()
	gnv_appeondb.of_CommitQueue()
	ldwc_project.InsertRow(1)
	ldwc_import.InsertRow(1)
END IF

IF dwo.Name = 'sched_type' And Data = '20' THEN
	This.Modify("imp_exp_option_t.Text='Export'")
	DataWindowChild ldwc_export
	//This.Modify("imp_exp_option.DDDW.Name=d_dddw_export_files")
	This.Modify("imp_exp_option.DDDW.Name='d_dddw_export_files'") //alfee 01.28.2011	
	This.Modify("imp_exp_option.DDDW.DataColumn='export_id'")
	This.Modify("imp_exp_option.DDDW.DisplayColumn='export_name'")
	This.GetChild("imp_exp_option", ldwc_export)
	ldwc_export.SetTransObject(SQLCA)
	gnv_appeondb.of_StartQueue()
	ldwc_export.Retrieve()
	gnv_appeondb.of_CommitQueue()
	ldwc_export.InsertRow(1)
	//---------Begin Added by (Appeon)Stephen 05.19.2017 for V15.4-WebView Reporting Functionality--------
	dw_detail.getchild("report_storage_id", ldwc_1)
	of_filter_srs_report(long(data), ldwc_1)
	//---------End Added ------------------------------------------------------
END IF

//---------Begin Added by (Appeon)Stephen 03.28.2014 for V142 Schedule IntelliReport--------
IF dwo.Name = 'sched_type' And Data = '70' THEN
	DataWindowChild ldwc_ireport
	This.Modify("imp_exp_option_t.Text='IntelliReport:'")
	This.Modify("imp_exp_option.DDDW.Name='d_dddw_intellireport'")
	This.Modify("imp_exp_option.DDDW.DataColumn='view_id'")
	This.Modify("imp_exp_option.DDDW.DisplayColumn='view_name'")
	This.GetChild("imp_exp_option", ldwc_ireport)
	ldwc_ireport.SetTransObject(SQLCA)
	ldwc_ireport.Retrieve()
	
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.03.2015
	//<$>reason:For Contract Ireport not showing in the scheduler dropdown Case#60457 Bug_id#4866

//	//---------Begin Added by (Appeon)Stephen 06.05.2015 for Bug # 4546 - The IntelliRport label is truncated when setting up IReport in the scheduler--------
//	if gb_contract_version then
//		ldwc_ireport.setfilter("module in(1,4)")
//		ldwc_ireport.filter()
//	else
//		ldwc_ireport.setfilter("module in(2,4)")
//		ldwc_ireport.filter()
//	end if
//	//---------End Added ------------------------------------------------------
	
	of_filter_ireport(ldwc_ireport)
	//------------------- APPEON END -------------------
	
	//---------Begin Added by (Appeon)Stephen 05.19.2017 for V15.4-WebView Reporting Functionality--------
	dw_detail.getchild("report_storage_id", ldwc_1)
	of_filter_srs_report(long(data), ldwc_1)
	//---------End Added ------------------------------------------------------
end if
//---------End Added ------------------------------------------------------

IF dwo.Name = 'imp_exp_option'  THEN
	IF This.Object.sched_type[row] = 20 THEN
		ll_export_id = This.GetItemNumber(row,'imp_exp_option')
		SELECT prac_sql,save_path Into :ls_sql,:ls_save_path From export_header Where export_id = :ll_export_id;
		IF IsNull(ls_sql) Or ls_sql = '' THEN ls_sql = 'Select distinct ctx_id from ctx_basic_info where ctx_id > 0;'
		This.SetItem(row,'retrieve_query',ls_sql)
		This.SetItem(row,'file_path',ls_save_path)
	END IF
END IF

This.SetItem(row,"use_org_time",0)   //Start Code Change ----04.30.2015 #V15 maha - reset if any change made.

//---------Begin Added by (Appeon)Stephen 05.19.2017 for V15.4-WebView Reporting Functionality--------
if dwo.name = "report_storage_id" then
	ll_srs_id = long(data)
	select Report_id into :ll_export_id from sys_report_storage  where srs_id = :ll_srs_id;
	if abs(ll_export_id) > 0 then
		this.setitem(row ,"imp_exp_option", ll_export_id)
	end if
end if
//---------End Added ------------------------------------------------------

//commented by alfee 03.05.2010
//IF dwo.Name = 'sched_type' And( Data >= '31'  And  Data <= '36') THEN
//	This.SetItem(row,"interval_type",3) //day
//	This.SetItem(row,"interval_length",1)
//ELSE
//	This.SetItem(row,"interval_type",1) //min
//	This.SetItem(row,"interval_length",1)
//END IF

end event

event rowfocuschanged;//Synchronize in dw_browse while scrolling in dw_detail - alfee 02.05.2010

if currentrow < 1 then return 0

if dw_browse.getrow() <> currentrow and dw_browse.rowcount() >= currentrow then
	dw_browse.scrolltorow(currentrow)
end if	
end event

event retrievestart;//Filter schedule types - Eugene 11.28.2013 for BugA112101 

String ls_where

IF Len(is_ori_sql) < 1 THEN RETURN 0 //Continue 

IF NOT gb_contract_module THEN //IntelliCred&App only
	ls_where = " Where sched_type Not In (" + is_stype_ctx + ")"
ELSEIF gb_contract_version THEN //IntelliContract only
	ls_where = " Where sched_type In (" + is_stype_both + "," + is_stype_ctx + ")"
ELSE										//Both
	//Do nothing
END IF

IF Len(ls_where) > 0 THEN
	This.SetSQLSelect (is_ori_sql + ls_where)
END IF

RETURN 0
end event

