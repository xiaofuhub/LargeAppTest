$PBExportHeader$w_auto_report.srw
forward
global type w_auto_report from window
end type
type cb_2 from commandbutton within w_auto_report
end type
type st_running from statictext within w_auto_report
end type
type cb_on_off from commandbutton within w_auto_report
end type
type dw_detail from datawindow within w_auto_report
end type
type dw_browse from datawindow within w_auto_report
end type
type cb_run from commandbutton within w_auto_report
end type
type cb_about from commandbutton within w_auto_report
end type
type r_on from rectangle within w_auto_report
end type
type cb_4 from commandbutton within w_auto_report
end type
type cb_1 from commandbutton within w_auto_report
end type
type cb_save from commandbutton within w_auto_report
end type
type cb_qiut from commandbutton within w_auto_report
end type
type dw_autoexport from datawindow within w_auto_report
end type
end forward

global type w_auto_report from window
integer x = 27
integer y = 288
integer width = 3703
integer height = 2020
boolean titlebar = true
string title = "Automated Report"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
cb_2 cb_2
st_running st_running
cb_on_off cb_on_off
dw_detail dw_detail
dw_browse dw_browse
cb_run cb_run
cb_about cb_about
r_on r_on
cb_4 cb_4
cb_1 cb_1
cb_save cb_save
cb_qiut cb_qiut
dw_autoexport dw_autoexport
end type
global w_auto_report w_auto_report

type variables
integer il_export_id
integer ii_on_off = 0
string is_came_from
integer ii_timer = 0

integer ii_global_timer = 60


end variables

forward prototypes
public function integer of_timer ()
public function integer of_connect ()
public function integer of_run_report (long al_row)
end prototypes

public function integer of_timer ();datetime ldt_nowtime
datetime ldt_nexttime
date ld_date
time lt_time
integer i
integer r
integer rc
integer n
integer li_int
integer li_month
integer li_newmonth
integer li_day
integer li_year
integer li_minute
integer li_hour
integer li_newminute
integer li_newhour
integer day_add
integer hour_add
date ld_rundate
time lt_runtime
integer chk = 0
integer li_error
integer ao
Boolean lb_executed = False

if ii_on_off = 0 then return -1
rc = dw_browse.rowcount()
if rc < 1 then return -1

	
of_connect( ) //maha app 101405 keep connection live
	
//messagebox("minute test",string(ldt_nowtime))
for r = 1 to rc //check each report item to see it it should be run
	Yield()
	if dw_browse.getitemnumber(r,"active_status") = 1 then
		
		ld_rundate = date(dw_browse.getitemdatetime(r,"run_time"))
		lt_runtime = time(dw_browse.getitemdatetime(r,"run_time"))
		
		//Modified By Ken.Guo 02/24/2012
		//if ld_rundate = ld_date and hour(lt_runtime) = li_hour and minute(lt_runtime) = li_minute then
		If dw_browse.getitemdatetime(r,"run_time") <= Datetime(Today() ,Now()) Then
			
			//Added By Ken.Guo 02/24/2012. 
			Timer(0,This)
			
			//1)run the export
			 li_error =  of_run_report(r)
				//messagebox("run",li_error)
				
			//2)set next run time
			
			//Added By Ken.Guo 02/24/2012. 
			ldt_nowtime = datetime(today(),now())
			ld_date = date(ldt_nowtime)
			lt_time = time(ldt_nowtime)
			li_day = day(ld_date)
			li_month = month(ld_date)
			li_year = year(ld_date)
			li_minute = minute(lt_time)
			li_hour  = hour(lt_time)
	
			  li_int = dw_browse.getitemnumber(r,"interval")
			  li_newminute = minute(lt_runtime)
			  li_newhour = hour(lt_runtime)
			choose case dw_browse.getitemnumber(r,"frequency")
					case 1 //minute
						li_newminute = minute(lt_runtime) + li_int
							hour_add = 0
							do while li_newminute > 59
								hour_add ++
								li_newminute = li_newminute - 60
							loop
							li_newhour = hour(lt_runtime) + hour_add
							do while li_newhour > 23
								day_add ++
								li_newhour = li_newhour - 24
							loop
						ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
					case 2 //hour
						li_newhour = hour(lt_runtime) + li_int
						day_add = 0
						do while li_newhour > 23
							day_add ++
							li_newhour = li_newhour - 24
						loop
						ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
					case 3 //day
						ldt_nexttime = datetime(RelativeDate ( ld_date, li_int ),lt_runtime)
					case 4 //week
						n = li_int * 7
						ldt_nexttime = datetime(RelativeDate ( ld_date, n ),lt_runtime)
					case 5 //month     note:end of month starts will always eventually end up as 28th of month
						li_newmonth = li_month + li_int
						if li_newmonth > 12 then //next year rollover
							li_newmonth = li_newmonth - li_month
							li_year = li_year + 1
						end if
						choose case li_day
							case 29,30,31
								choose case li_month
									case 2
										li_day = 28 //does not allow for leap year  
									case 4,6,9,11
										li_day = 30
								end choose
						end choose					
						ldt_nexttime = datetime(date(string(li_newmonth) + "-" + string(li_day) + "-" + string(li_year)),lt_runtime)
					case else
						ldt_nexttime = ldt_nowtime
				end choose
				dw_browse.setitem(r,"error_code",li_error)
				dw_browse.setitem(r,"last_run",ldt_nowtime)
				//If li_error > 0 Then //Otherwise, it will always send error email per 60s.
					dw_browse.setitem(r,"run_time",ldt_nexttime)	 //set next runtime
				//End If

				chk = 1
				if li_error < 1 then
					continue
				end if
		end if
	end if
next	
		
dw_browse.update()
commit using sqlca;
dw_browse.retrieve()

//Must reset to 60 before return
Timer(ii_global_timer,This)



Return 1

end function

public function integer of_connect ();//maha app101405
integer i

select set_1 into :i from icred_settings;

ii_timer++

if ii_timer > 60 then  //once per hour hit the database to keep the connection alive
	ii_timer = 0
end if

Return 1


end function

public function integer of_run_report (long al_row);Long ll_report_id, ll_ret
String ls_report_name, ls_output_pathfilename, ls_output_filename, ls_from, ls_to, ls_cc, ls_subject, ls_message
String ls_error
n_cst_easymail_smtp lnv_mail

st_running.visible = True

If al_row <= 0 Then Return 0

SetPointer(HourGlass!)

//Check Custom Report Window.
If Not isvalid(w_custom_report) Then
	str_dashboard lstr_dashboard
	lstr_dashboard.data_name = 'autoreport' 
	lstr_dashboard.data_id = 0 	
	OpenWithParm(w_custom_report,lstr_dashboard)
	If Not isvalid(w_custom_report) Then
		gnv_debug.of_output(True, 'Auto Report Error. Failed to open the custom report window.')
		dw_browse.SetItem(al_row, 'error_code', -1)
		dw_browse.Update()
		Return -1
	End If
End If

//Check Email Info
ls_from = dw_browse.GetItemString(al_row, 'email_from')
ls_to = dw_browse.GetItemString(al_row, 'email_to')
ls_cc = dw_browse.GetItemString(al_row, 'email_cc')
ls_subject = dw_browse.GetItemString(al_row, 'email_subject')
ls_message = dw_browse.GetItemString(al_row, 'email_message')
ll_report_id = dw_browse.GetItemNumber(al_row, 'report_id')
ls_report_name = dw_browse.GetItemString(al_row, 'report_name')
If isnull(ls_from) Then
	gnv_debug.of_output(True, 'Auto Report Error. The Sender cannot be empty, please select a user. report name = ' + ls_report_name)
	dw_browse.SetItem(al_row, 'error_code', -1)
	dw_browse.Update()
	Return -1	
End If
If isnull(ls_to) Then
	gnv_debug.of_output(True, 'Auto Report Error. The mail To cannot be empty. report name = ' + ls_report_name)
	dw_browse.SetItem(al_row, 'error_code', -1)
	dw_browse.Update()
	Return -1	
End If
If isnull(ls_cc) Then ls_cc = ''
If isnull(ls_subject) Then ls_subject = ''
If isnull(ls_message) Then ls_message = ''

//Run Report
ls_output_filename = gnv_string.of_replace_invalid_format( ls_report_name, '_') + '_' +  String(today(),'yyyymmddhhmmss') + '.pdf'
ls_output_pathfilename = gs_dir_path + gs_DefDirName + '\Report\' + ls_output_filename 
gnv_appeondll.of_parsepath( ls_output_pathfilename )

dw_browse.SetRedraw(False)
dw_browse.SetItem(al_row, 'running', 1)
dw_browse.AcceptText()
dw_browse.SetRedraw(True)
ll_ret = w_custom_report.of_run_report(ll_report_id,ls_output_pathfilename, ls_error)
If ll_ret > 0 Then
	//Send Email with the attachment
	ll_ret = lnv_mail.of_sendtext( ls_from, ls_to, ls_cc, '', ls_subject, ls_message, ls_output_pathfilename)
	If ll_ret = 0 Then
		dw_browse.SetItem(al_row, 'error_code', 1)
		dw_browse.Update()	
		ll_ret = 1
	Else
		gnv_debug.of_output(True, 'Auto Report Error. Failed to send the email. Report name = ' + ls_report_name)
		dw_browse.SetItem(al_row, 'error_code', -1)
		dw_browse.Update()
		ll_ret = -1
	End If
Else
	ls_subject = 'Error Originated from Schedule Report'
	ls_message = 'Hi, ~r~n~r~nThe Schedule Report failed to execute. The report name is "' +ls_report_name+ '".~r~n' + 'Attached is the log where you can find the cause of the failure. '
	ls_output_pathfilename = gs_dir_path + gs_DefDirName + '\Debug.Log'
	lnv_mail.of_sendtext( ls_from, ls_to, ls_cc, '', ls_subject, ls_message, ls_output_pathfilename)
	dw_browse.SetItem(al_row, 'error_code', ll_ret)
	dw_browse.Update()	
End If
dw_browse.SetItem(al_row, 'running', 0)

SetPointer(Arrow!)

Return ll_ret
end function

on w_auto_report.create
this.cb_2=create cb_2
this.st_running=create st_running
this.cb_on_off=create cb_on_off
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_run=create cb_run
this.cb_about=create cb_about
this.r_on=create r_on
this.cb_4=create cb_4
this.cb_1=create cb_1
this.cb_save=create cb_save
this.cb_qiut=create cb_qiut
this.dw_autoexport=create dw_autoexport
this.Control[]={this.cb_2,&
this.st_running,&
this.cb_on_off,&
this.dw_detail,&
this.dw_browse,&
this.cb_run,&
this.cb_about,&
this.r_on,&
this.cb_4,&
this.cb_1,&
this.cb_save,&
this.cb_qiut,&
this.dw_autoexport}
end on

on w_auto_report.destroy
destroy(this.cb_2)
destroy(this.st_running)
destroy(this.cb_on_off)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_run)
destroy(this.cb_about)
destroy(this.r_on)
destroy(this.cb_4)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.cb_qiut)
destroy(this.dw_autoexport)
end on

event open;//Auto import window developed 07-02  maha 

integer cnt
datetime dt_now = datetime(today(),now())
datetime	dt_run
integer i


DataWindowChild dwchild
dw_detail.settransobject(sqlca)
dw_detail.GetChild( "report_id", dwchild )

dwchild.settransobject(sqlca)
dw_browse.settransobject(sqlca)

gnv_appeondb.of_startqueue( )
	dwchild.retrieve()
	dw_browse.retrieve()
gnv_appeondb.of_commitqueue( )

cnt = dw_browse.rowcount( )


r_on.fillcolor = 8453888 	
ii_on_off = 1					

gi_test_mode = 1
Timer( ii_global_timer ,This)


//BEGIN---Modify by Scofield on 2010-05-18
if AppeonGetClientType() = 'WEB' then
	This.Resize(This.Width + 16,This.Height + 16)
end if
//END---Modify by Scofield on 2010-05-18

end event

event close;Timer(0)			


end event

event timer;
st_running.visible = true
of_timer()
st_running.visible = false


end event

event closequery;Long ll_ret
If dw_detail.ModifiedCount() > 0 Then
	ll_ret = Messagebox('Save','Do you want to save the data?', Question!, Yesnocancel!) 
	If ll_ret = 1 Then
		cb_save.Event Clicked()
	ElseIf ll_ret = 3 Then
		Return 1
	End If
End If

Return 0
end event

type cb_2 from commandbutton within w_auto_report
integer x = 2775
integer y = 1792
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Log"
end type

event clicked;String ls_log_file
String ls_null

SetNull(ls_null)
ls_log_file = gs_dir_path + gs_DefDirName + '\Debug.Log'
If Not FileExists(ls_log_file) Then
	Messagebox('Log','No log files.')
	Return 1
End If	
ShellExecuteA ( Handle( Parent ), "open", 'Notepad.exe', ls_log_file , ls_Null, 4)

end event

type st_running from statictext within w_auto_report
boolean visible = false
integer x = 695
integer y = 1796
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

type cb_on_off from commandbutton within w_auto_report
integer x = 50
integer y = 1796
integer width = 603
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "AUTO REPORT &ON"
end type

event clicked;integer i
integer c = 0

if ii_on_off = 0 then
	ii_on_off = 1
	this.text = "AUTO REPORT ON"
	r_on.fillcolor = 8453888
else 
	ii_on_off = 0
	this.text = "AUTO REPORT OFF"
	r_on.fillcolor = RGB(255,0,0)
end if
end event

type dw_detail from datawindow within w_auto_report
integer x = 23
integer y = 648
integer width = 3593
integer height = 1104
integer taborder = 20
string dataobject = "d_auto_report_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;str_alarm_user lstr_alarm,lstr_alarm_new

//Workaround PB's bug. it will auto trigger the timer event.
If appeongetclienttype() = 'PB' Then
	ii_on_off = 1
	cb_on_off.event clicked( )
End If

Choose Case dwo.name 
	Case 'b_to' 
		lstr_alarm.s_flag = 'N' //Create action item off
		lstr_alarm.s_to_list = this.GetItemString(row,'email_to')
		lstr_alarm.s_type = 'normal'
		Openwithparm(w_ctx_alarm_users,lstr_alarm)
		
		lstr_alarm_new = message.PowerObjectParm
		if isvalid(lstr_alarm_new) then
			If lstr_alarm_new.classname() = 'str_alarm_user' Then
				This.Setitem(row, 'email_to',lstr_alarm_new.s_to_list )
			End If
		end if		
	Case 'b_cc'
		lstr_alarm.s_flag = 'N' //Create action item off
		lstr_alarm.s_to_list = this.GetItemString(row,'email_cc')
		lstr_alarm.s_type = 'normal'
		Openwithparm(w_ctx_alarm_users,lstr_alarm)
		
		lstr_alarm_new = message.PowerObjectParm
		if isvalid(lstr_alarm_new) then
			If lstr_alarm_new.classname() = 'str_alarm_user' Then
				This.Setitem(row, 'email_cc',lstr_alarm_new.s_to_list )
			End If
		end if
End Choose
		

end event

type dw_browse from datawindow within w_auto_report
integer x = 18
integer y = 20
integer width = 3223
integer height = 604
integer taborder = 10
string dataobject = "d_auto_report_browse"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;//<add> 08/21/2007 by: Andy
long ll_id

if currentrow < 1 or rowcount() < 1 then return

this.selectrow(0,false)
this.selectrow(currentrow,true)

ll_id  = this.getitemnumber(currentrow,"id")
dw_detail.retrieve(ll_id)

end event

event retrieveend;if RowCount() < 1 then 
	dw_detail.reset( )
else
	event rowfocuschanged(1)
end if
end event

event rowfocuschanging;Long ll_ret
If dw_detail.ModifiedCount() > 0 Then
	ll_ret = Messagebox('Save','Do you want to save the data?', Question!, Yesnocancel!) 
	If ll_ret = 1 Then
		cb_save.Event Clicked()
	ElseIf ll_ret = 3 Then
		Return 1
	End If
End If

Return 0
end event

type cb_run from commandbutton within w_auto_report
integer x = 3154
integer y = 1792
integer width = 462
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Test Report"
end type

event clicked;integer err

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.24.2007 By: Jack
//$<reason> Fix a defect.
cb_save.triggerevent(clicked!)
//---------------------------- APPEON END ----------------------------

if dw_browse.rowcount() > 0 then
	err = of_run_report(dw_browse.GetRow())
	st_running.visible = false
end if

end event

type cb_about from commandbutton within w_auto_report
boolean visible = false
integer x = 3282
integer y = 424
integer width = 343
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&bout"
end type

event clicked;////Added By Mark Lee 04/26/2013
////MessageBox("The Auto Export program: ","See Auto Export Manual~r~r~rCopyright 2002-2010 Contract Logix Inc~r~rversion 2.0 ")
//MessageBox("The Auto Report program: ","See Auto Report Manual~r~r~rCopyright "+gs_copyright+" Contract Logix Inc~r~rversion 12.0 ")
//
end event

type r_on from rectangle within w_auto_report
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 65280
integer x = 23
integer y = 1776
integer width = 654
integer height = 124
end type

type cb_4 from commandbutton within w_auto_report
integer x = 3282
integer y = 128
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//dw_detail.deleterow(1)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
//dw_browse.deleterow(0)

//<add> 08/21/2007 by: Andy
Long ll_Row,ll_OldRow,ll_cnt

ll_OldRow = dw_browse.getrow( )

dw_browse.deleterow(0)
dw_detail.reset( )

if dw_browse.update() = 1 then
	commit;
else 
	rollback;
end if

ll_cnt = dw_browse.RowCount( )
if ll_OldRow <= ll_Cnt then
	ll_Row = ll_OldRow
elseif ll_cnt > 0 then 
	ll_Row = ll_Cnt
else
	ll_Row = 0
end if

if ll_Row > 0 then 
	dw_browse.ScrollToRow(ll_Row)
	dw_browse.setrow( ll_Row )
	dw_browse.event rowfocuschanged(ll_Row)
end if
//end of add
//---------------------------- APPEON END ----------------------------

end event

type cb_1 from commandbutton within w_auto_report
integer x = 3282
integer y = 20
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.27.2007 By: Jack
//$<reason> Fix a defect.
/*
dw_detail.insertrow(1)
*/
dw_detail.reset()
dw_detail.insertrow(0)
//---------------------------- APPEON END ----------------------------


end event

type cb_save from commandbutton within w_auto_report
integer x = 3282
integer y = 236
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;integer 	li_exp
integer 	i
integer 	r
long		ll_RtnVal

ll_RtnVal = dw_AutoExport.Update()
if ll_RtnVal = 1 then
	COMMIT USING SQLCA;
end if


long ll_report_id

if dw_detail.getrow() < 1 then return 

dw_detail.accepttext()

ll_report_id = dw_detail.getitemnumber(dw_detail.getrow(),'report_id')
If isnull(ll_report_id) or ll_report_id = 0 Then
	messagebox('Save' , 'The Report is a required column.')
	dw_detail.setfocus()
	dw_detail.setcolumn('report_id')
	Return
End If

if dw_detail.Modifiedcount( ) + dw_detail.deletedcount( ) < 1 then return
//if dw_detail.getitemstatus( dw_detail.getrow(), 0, primary!) = NewModified! then
//	select max(id) into :li_exp from report_auto_settings;
//	if isnull(li_exp) then li_exp = 0
//	li_exp ++
//	dw_detail.setitem(1,"id",li_exp)
//end if

i = dw_detail.update()
if i = 1 then
	commit using sqlca;
	dw_browse.retrieve()
	r = dw_browse.find("id = " + string(li_exp),1,dw_browse.rowcount())
	if r > 0 then 
		dw_browse.scrolltorow(r)
		dw_browse.setrow(r)
	end if
else
	messagebox('Save Error','Failed to save the data, please quit and try again.')
end if

end event

type cb_qiut from commandbutton within w_auto_report
integer x = 3282
integer y = 532
integer width = 343
integer height = 92
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Quit"
end type

event clicked;Close(Parent)

end event

type dw_autoexport from datawindow within w_auto_report
integer x = 1079
integer y = 1780
integer width = 1051
integer height = 120
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_user_auto_report"
boolean border = false
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SetTransObject(SQLCA)
This.Retrieve(gs_user_id)

This.Visible = gb_AutoReport

end event

