$PBExportHeader$w_auto_export.srw
forward
global type w_auto_export from window
end type
type cb_3 from commandbutton within w_auto_export
end type
type cb_sort from commandbutton within w_auto_export
end type
type cb_filter from commandbutton within w_auto_export
end type
type cbx_overdue from checkbox within w_auto_export
end type
type cb_painter from commandbutton within w_auto_export
end type
type cb_2 from commandbutton within w_auto_export
end type
type cb_1 from commandbutton within w_auto_export
end type
type st_running from statictext within w_auto_export
end type
type cb_on_off from commandbutton within w_auto_export
end type
type cb_save from commandbutton within w_auto_export
end type
type dw_detail from datawindow within w_auto_export
end type
type dw_browse from datawindow within w_auto_export
end type
type cb_4 from commandbutton within w_auto_export
end type
type cb_qiut from commandbutton within w_auto_export
end type
type cb_run from commandbutton within w_auto_export
end type
type cb_about from commandbutton within w_auto_export
end type
type r_on from rectangle within w_auto_export
end type
end forward

global type w_auto_export from window
integer x = 27
integer y = 288
integer width = 3520
integer height = 1912
boolean titlebar = true
string title = "IntelliCred Automated Export"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 80269524
boolean center = true
cb_3 cb_3
cb_sort cb_sort
cb_filter cb_filter
cbx_overdue cbx_overdue
cb_painter cb_painter
cb_2 cb_2
cb_1 cb_1
st_running st_running
cb_on_off cb_on_off
cb_save cb_save
dw_detail dw_detail
dw_browse dw_browse
cb_4 cb_4
cb_qiut cb_qiut
cb_run cb_run
cb_about cb_about
r_on r_on
end type
global w_auto_export w_auto_export

type variables
integer il_export_id
integer ii_on_off = 0
string is_came_from
integer ii_timer = 0
string is_log_file
string is_logid = "0"
end variables

forward prototypes
public function integer of_timer ()
public function integer of_connect ()
public function integer of_run_export (integer ai_auto_export_id)
public function integer of_log_error (integer ai_error, integer ai_auto_exp_id)
public subroutine of_use_audit_protect (boolean ab_refresh)
end prototypes

public function integer of_timer ();if ii_on_off = 0 then return -1

datetime ldt_nowtime
datetime ldt_nexttime
datetime ldt_schedtime //maha 103009
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
integer li_run
date ld_rundate
time lt_runtime
integer chk = 0
integer li_error
integer ao
long ll_export //maha 122908
time lt_start  //maha 122908
time lt_end  //maha 122908
long ll_seconds
string ls_mess //maha 122908

//st_running.visible = true
ldt_nowtime = datetime(today(),now())
ld_date = date(ldt_nowtime)
lt_time = time(ldt_nowtime)
li_day = day(ld_date)
li_month = month(ld_date)
li_year = year(ld_date)
li_minute = minute(lt_time)
li_hour  = hour(lt_time)


rc = dw_browse.rowcount()
if rc < 1 then return -1

//Start Code Change ----12.29.2008 #V91 maha - added if to skip; 
if of_connect( )  < 1 then return 1 //maha app 101405 keep connection live; if connection fails stop

if is_logid = "0" then is_logid = string(hour(now())) + string(minute(now())) + string(second(now()))
//messagebox("minute test",string(ldt_nowtime))
for r = 1 to rc //check each export item to see it it should be run	
		//Start Code Change ----11.2.2009 #V10 maha - modify to allow for running overdue exportsif dw_browse.getitemnumber(r,"active_status") = 1 then
	if dw_browse.getitemnumber(r,"active_status") = 1  then //Start Code Change ----12.1.2009 #V10 maha - readded active trap
			if isnull(dw_browse.getitemdatetime(r,"run_time")) then
				ldt_schedtime = ldt_nowtime
			else
				ldt_schedtime = dw_browse.getitemdatetime(r,"run_time")
			end if
			
			ld_rundate = date(ldt_schedtime)
			lt_runtime = time(ldt_schedtime)

			ll_export = dw_browse.getitemnumber(r,"auto_export_id")  //Start Code Change ----12.29.2008 #V91 maha
			
			//if the date and time matches
			if ld_rundate = ld_date and hour(lt_runtime) = li_hour and minute(lt_runtime) = li_minute then
				li_run = 1
			else //check for overdue. 
				if cbx_overdue.checked  then
					if ldt_schedtime < ldt_nowtime then
						li_run = 1
						//changed to reset from the runtime not the scheduled time when overdue
						//ld_rundate = date(ld_date) //the now date
						//lt_runtime = time(lt_time) //the now time
					else
						li_run = 0
					end if
				else
					li_run = 0
				end if
			end if
	//End Code Change---11.2.2009	
			if li_run = 1 then
				//messagebox("run",string(ldt_nowtime))
				//1)run the export
				//li_run = 1
				
				lt_start = now()
				 li_error =  of_run_export(ll_export) //Start Code Change ----12.29.2008 #V91 maha - changed to variable
				lt_end = now()
					
				//2)set next run time
				  li_int = dw_browse.getitemnumber(r,"interval")
				  li_newminute = minute(lt_runtime)
				  li_newhour = hour(lt_runtime)
				  ldt_nexttime = of_next_run_time(li_int, dw_browse.getitemnumber(r,"frequency"), ld_rundate,lt_runtime)
//				choose case dw_browse.getitemnumber(r,"frequency")
//						case 1 //minute
//							li_newminute = minute(lt_runtime) + li_int
//								hour_add = 0
//								do while li_newminute > 59
//									hour_add ++
//									li_newminute = li_newminute - 60
//								loop
//								li_newhour = hour(lt_runtime) + hour_add
//								day_add = 0 //Add by Evan 06.09.2009
//								do while li_newhour > 23
//									day_add ++
//									li_newhour = li_newhour - 24
//								loop
//							ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
//						case 2 //hour
//							li_newhour = hour(lt_runtime) + li_int
//							day_add = 0
//							do while li_newhour > 23
//								day_add ++
//								li_newhour = li_newhour - 24
//							loop
//							ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
//						case 3 //day
//							ldt_nexttime = datetime(RelativeDate ( ld_date, li_int ),lt_time)
//						case 4 //week
//							n = li_int * 7
//							ldt_nexttime = datetime(RelativeDate ( ld_date, n ),lt_time)
//						case 5 //month     note:end of month starts will always eventually end up as 28th of month
//							li_newmonth = li_month + li_int
//							if li_newmonth > 12 then //next year rollover
//								li_newmonth = li_newmonth - li_month
//								li_year = li_year + 1
//							end if
//							choose case li_day
//								case 29,30,31
//									choose case li_month
//										case 2
//											li_day = 28 //does not allow for leap year  
//										case 4,6,9,11
//											li_day = 30
//									end choose
//							end choose					
//							ldt_nexttime = datetime(date(string(li_newmonth) + "-" + string(li_day) + "-" + string(li_year)),lt_time)
//						case else
//							ldt_nexttime = ldt_nowtime
//					end choose
					dw_browse.setitem(r,"run_time",ldt_nexttime)
					dw_browse.setitem(r,"last_run",ldt_nowtime)
					dw_browse.setitem(r,"error_code",li_error)
					//messagebox("run time",string(ldt_runtime))
					//messagebox("next run",string(ldt_nexttime))
					chk = 1
					if li_error < 1 then
						of_log_error( li_error, ll_export)  //Start Code Change ----12.29.2008 #V91 maha
						continue
					else  //completed successfully
						ll_seconds = SecondsAfter(lt_start, lt_end)
						ls_mess = is_logid + "|Export " + string(ll_export) + " completed in " + string(ll_seconds) + " seconds|"  + string(datetime(today(),now())) + "|"
						of_log_auto_export_import( is_log_file, ls_mess  )		
					end if
					if dw_browse.getitemnumber(r,"reset_audit") = 1 then
						//maha modified 100902
						ao = dw_browse.getitemnumber(r,"active_only")
						if ao < 1 or isnull(ao) then //all
							update sys_audit set exported = 0, export_date = :ldt_nowtime  where exported = 1 and date_time_modified <= :ldt_nowtime;
						elseif ao = 1 then //active
							update sys_audit, pd_affil_stat set sys_audit.exported = 0, sys_audit.export_date = :ldt_nowtime  where sys_audit.exported = 1 and sys_audit.date_time_modified <= :ldt_nowtime and pd_affil_stat.active_status = 1;
						elseif ao = 4 then //pending
							update sys_audit, pd_affil_stat set sys_audit.exported = 0, sys_audit.export_date = :ldt_nowtime  where sys_audit.exported = 1 and sys_audit.date_time_modified <= :ldt_nowtime and pd_affil_stat.active_status = 4;
						elseif ao = 2 then //active&pending
							update sys_audit, pd_affil_stat set sys_audit.exported = 0, sys_audit.export_date = :ldt_nowtime  where sys_audit.exported = 1 and sys_audit.date_time_modified <= :ldt_nowtime and pd_affil_stat.active_status in (1,4);
						end if
						commit using sqlca;
					end if		
			end if
		end if
next	
	
	
	
if chk = 1 then 
	dw_browse.update()
	commit using sqlca;
	dw_browse.retrieve()
	dw_detail.retrieve(il_export_id)
end if

garbagecollect()

return 1
end function

public function integer of_connect ();//maha app101405
integer i
integer res = 1
string ls_mess
datetime ldt_now

//Start Code Change ----10.30.2009 #V10 maha - redesigned to test connection every minute
//ii_timer++


select set_1 into :i from icred_settings;
IF SQLCA.SQLCODE = -1 THEN
	res = -1
else
	if ii_timer > 1000 then ii_timer= 0
	return 1
end if


if res = -1 then //if connection fails attempt to reconnect
	disconnect using sqlca; //clear the connection
	ii_timer++
//if ii_timer > 15 then  //4 times per hour hit the database to keep the connection alive
//	select set_1 into :i from icred_settings;
//	IF SQLCA.SQLCODE = -1 THEN //Start Code Change ----12.29.2008 #V91 maha - added to reconnect to db
	res = of_connect_to_db_no_mess()
	ldt_now = datetime(today(),now())
	 if res = 1 then //if successful log reconnect
	 	dw_browse.settransobject(sqlca)
		 dw_detail.settransobject(sqlca)
		ls_mess = is_logid + "|Auto Export reconnected successfully|" + string(ldt_now) + "|"
		//messagebox("reconnect attempt","passed")
		of_log_auto_export_import( is_log_file, ls_mess  )
		ii_timer = 0
	else  //if failed log every five minutes
		if ii_timer > 4 then
			ls_mess = is_logid + "|Auto Export failed to reconnect|" + string(ldt_now) + "|"
		//	messagebox("reconnect attempt","failed")
			of_log_auto_export_import( is_log_file, ls_mess  )
			ii_timer = 0
		end if
	end if
end if

return res



//is_came_from = SQLCA.sqlreturndata //returns 'Adaptive Server Anywhere' if connected
//
////connect only if not connected
//if is_came_from = "" then
//	SQLCA.DBMS="ODBC"
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=user1;PWD=123;',DelimitIdentifier='No'"
//	
//	CONNECT USING SQLCA;
//
//	IF SQLCA.SQLCODE = -1 THEN
//		//MessageBox("Not Logged In", "Login Failed!")
//		return -1
//	ELSE
//		//MESSAGEBOX("","LOGIN OK")
//		return 1
//	END IF
//else
//	return 1
//end if


end function

public function integer of_run_export (integer ai_auto_export_id);Long prac_ids[]
string ls_presentation_str
string ls_sny_retrieve
string ls_dwsyntax_str
string ERRORS
string ls_path
string ls_last_run
long ll_prac_row
n_ds lds_export
n_ds lds_export_retrieve
long ll_export_id
integer i
integer p1
integer ret  = 1 //maha122908
datetime ldt_l


//st_running.visible = true
//prac_ids[1] = 1
//prac_ids[2] = 3
//prac_ids[3] = 4
lds_export = CREATE n_ds //get export info
lds_export.dataobject = "d_export_auto_set_detail"
lds_export.SetTransObject( SQLCA )
lds_export.retrieve(ai_auto_export_id)

// mskinner 21 Dec 2005 -- begin
//Start Code Change ---- 04.19.2007 #V7 maha  resolve a problem that could be caused by a row change not updated in this running instance
//if lds_export.rowcount() < 1 then return 0
if lds_export.rowcount() < 1 then
	dw_browse.retrieve()
	lds_export.retrieve(ai_auto_export_id)
	if lds_export.rowcount() < 1 then
		return -2
	end if
end if
//End Code Change--- 04.19.2007
// mskinner 21 Dec 2005 -- end

//Start Code Change ----11.04.2009 #V10 maha
ls_sny_retrieve = lds_export.getitemstring(1,"sql_syntax")
p1 = PosA(ls_sny_retrieve, "#LASTRUN#" ,1 )
if  p1 > 0 then
	ldt_l = lds_export.getitemdatetime(1,"last_run")
	ls_last_run = string(year(date(ldt_l))) + "/" + string(month(date(ldt_l))) + "/" + string(day(date(ldt_l))) + " " + string(time(ldt_l))
	//ls_last_run = string (lds_export.getitemdatetime(1,"last_run"))
	ls_sny_retrieve = MidA(ls_sny_retrieve, 1,p1 - 1) + "'"  + ls_last_run + "'" + MidA(ls_sny_retrieve, p1 + 9) 
	//messagebox("",ls_sny_retrieve)
end if
//End Code Change---11.04.2009
	
ls_path = lds_export.getitemstring(1,"save_to_path")
ll_export_id = lds_export.getitemnumber(1,"export_id")
		
ls_presentation_str = "style(type=grid)"		

ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution", &
	"SyntaxFromSQL caused these errors: " + ERRORS)
	RETURN -1
END IF
lds_export_retrieve = CREATE n_ds
lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
lds_export_retrieve.SetTransObject( SQLCA )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.24.2007 By: Jack
//$<reason> Fix a defect.
string ls_datatype
ls_datatype = lds_export_retrieve.Describe( "#1" + ".coltype")
Choose Case LeftA (ls_datatype,5)
	Case "char(","char"
		ls_datatype = "C"
	Case "date","datet","time","times"
		ls_datatype = "D"
	Case "decim","numbe","doubl","real","long","ulong","int"
		ls_datatype = "N"
End Choose

If ls_datatype <> "N" Then
	messagebox("Caution","SyntaxFromSQL caused these errors: " + ls_sny_retrieve)
	RETURN -1
End If	
//---------------------------- APPEON END ----------------------------


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
/* ll_prac_row = lds_export_retrieve.retrieve() */
integer li_export_type

gnv_appeondb.of_startqueue()
lds_export_retrieve.retrieve()

SELECT export_header.export_type
INTO :li_export_type
FROM export_header
WHERE export_header.export_id = :ll_export_id ;
gnv_appeondb.of_commitqueue()


ll_prac_row = lds_export_retrieve.rowcount()
//---------------------------- APPEON END ----------------------------


if ll_prac_row = 0 then 
	//messagebox("no rows ",ll_prac_row)
	return -2
elseif ll_prac_row = -1 then //Start Code Change ----12.16.2009 #V10 maha - separate error for failed query
	return -5
end if

//<add> 07/17/2007 by: Andy
lds_export_retrieve.Setsort( "#1 A")
lds_export_retrieve.Sort()
//end of add

//lds_export_retrieve.retrieve()
for i = 1 to ll_prac_row
	prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
next

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<modify> 01.13.2006 By: Wang Chao
//$<reason> It is currently unsupported to dynamically create a visual object.
//$<modification> Replaced the visual object with a non-visual object.
//pfc_n_cst_ai_export  n_export
//n_export = CREATE pfc_n_cst_ai_export
pfc_n_cst_ai_export_apb  n_export
n_export = CREATE pfc_n_cst_ai_export_apb
//---------------------------- APPEON END ----------------------------

il_export_id = ll_export_id
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
/* n_export.of_export_data_with_text( ll_export_id, prac_ids,ls_path,0 ,"","","") */
//if li_export_type = 3 or li_export_type = 4 then
if li_export_type = 3 or li_export_type = 4 or li_export_type = 6 then //(Appeon)long.zhang 05.17.2014 (v14.2 Provider-Contract direct linking)
	ret = n_export.of_export_data_with_text_ctx( ll_export_id, prac_ids,ls_path,0 ,"","","",1,ls_sny_retrieve)
else
	ret = n_export.of_export_data_with_text( ll_export_id, prac_ids,ls_path,0 ,"","","",1,ls_sny_retrieve)
end if
//---------------------------- APPEON END ----------------------------



st_running.visible = false

return ret  //Start Code Change ----12.29.2008 #V85 maha - changed from 1
end function

public function integer of_log_error (integer ai_error, integer ai_auto_exp_id);//Start Code Change ----12.29.2008 #V91 maha - created to log errors during export process
string ls_mess
string s

choose case ai_error
	case 0
		s = "|Error running export.  Check for valid write path|" + string (ai_auto_exp_id) + "|"
	case -1
		s = "|Unspecified database error|"  + string (ai_auto_exp_id) + "|"
	case -2
		s = "|No providers returned|"  + string (ai_auto_exp_id) + "|"
	case -3  //Start Code Change ----12.16.2009 #V10 maha - added
		s = "|No Data retrieved|"  + string (ai_auto_exp_id) + "|"
	case -4  //Start Code Change ----12.16.2009 #V10 maha - added
		s = "|Data Query failed|"  + string (ai_auto_exp_id) + "|"
	case -5  //Start Code Change ----12.16.2009 #V10 maha - added
		s = "|Provider query failed|"  + string (ai_auto_exp_id) + "|"
end choose

ls_mess = is_logid + s + string(datetime(today(),now())) + "|"

of_log_auto_export_import( is_log_file, ls_mess  )

return 1
end function

public subroutine of_use_audit_protect (boolean ab_refresh);//---------Begin Modified by (Appeon)Harry 12.03.2013 V141 for BugH101503 of History Issues--------
datawindowchild child
long ll_findrow, ll_type, ll_export_id
if gb_contract_version then return
if gb_contract_module then
	ll_export_id = dw_detail.getitemnumber(dw_detail.getrow(),'export_id')
	dw_detail.getchild("export_id",child)
	ll_findrow = child.find("export_id=" + string(ll_export_id), 1, child.rowcount( ))
	if isnull(ll_findrow) or ll_findrow = 0 then
		ll_type = 1
	else
		ll_type = child.getitemnumber(ll_findrow,'export_type')
	end if
	if ll_type = 1 or ll_type = 2 then
		dw_detail.modify("use_audit.protect='0'")
	else
		dw_detail.modify("use_audit.protect='1'")
		if ab_refresh = false then
			if dw_detail.getitemnumber(dw_detail.getrow(), 'use_audit') = 1 then
				dw_detail.setitem(dw_detail.getrow(), 'use_audit', 0)
			end if
		end if
	end if
end if
end subroutine

on w_auto_export.create
this.cb_3=create cb_3
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cbx_overdue=create cbx_overdue
this.cb_painter=create cb_painter
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_running=create st_running
this.cb_on_off=create cb_on_off
this.cb_save=create cb_save
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.cb_4=create cb_4
this.cb_qiut=create cb_qiut
this.cb_run=create cb_run
this.cb_about=create cb_about
this.r_on=create r_on
this.Control[]={this.cb_3,&
this.cb_sort,&
this.cb_filter,&
this.cbx_overdue,&
this.cb_painter,&
this.cb_2,&
this.cb_1,&
this.st_running,&
this.cb_on_off,&
this.cb_save,&
this.dw_detail,&
this.dw_browse,&
this.cb_4,&
this.cb_qiut,&
this.cb_run,&
this.cb_about,&
this.r_on}
end on

on w_auto_export.destroy
destroy(this.cb_3)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cbx_overdue)
destroy(this.cb_painter)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_running)
destroy(this.cb_on_off)
destroy(this.cb_save)
destroy(this.dw_detail)
destroy(this.dw_browse)
destroy(this.cb_4)
destroy(this.cb_qiut)
destroy(this.cb_run)
destroy(this.cb_about)
destroy(this.r_on)
end on

event open;//Auto import window developed 07-02  maha 

integer cnt
datetime dt_now = datetime(today(),now())
datetime	dt_run
integer i

//<add> 08/21/2007 by: Andy
If gb_contract_version Then
	this.title = 'IntelliContract Automated Export'
end if

//Start Code Change ----12.29.2008 #V91 maha - connection is done from auto_export application object; added log setting
is_log_file = GetCurrentDirectory()
is_log_file += "\auto_export_log.txt"
//messagebox("", is_log_file )
//end of add
//is_came_from = message.stringparm

//is_came_from = SQLCA.sqlreturndata

//of_connect()
//"A" is Auto export stand alone exe, otherwise being opened from IntelliCred

//if is_came_from = "A" then
////if is_came_from = "" then
//	SQLCA.DBMS="ODBC"
//	SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=user1;PWD=123;',DelimitIdentifier='No'"
//	
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$< Add  > 2007-09-14 By: Scofield
//	//$<Reason> Set the connection cache dynamically on Web
//	if AppeonGetClientType() = 'WEB' then
//		SQLCA.DBMS = gs_CacheType
//		SQLCA.DBParm = gs_CacheSet
//	end if
//	//---------------------------- APPEON END ----------------------------
//
//	CONNECT USING SQLCA;
//
//	IF SQLCA.SQLCODE = -1 THEN
//		MessageBox("Not Logged In", "Login Failed!")
//	ELSE
//		//MESSAGEBOX("","LOGIN OK")
//	END IF
//end if
//End Code Change---12.29.2008

DataWindowChild dwchild

dw_detail.settransobject(sqlca)

dw_detail.GetChild( "export_id", dwchild )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.09.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
dwchild.settransobject(sqlca)
dwchild.retrieve()

dw_browse.settransobject(sqlca)
cnt = dw_browse.retrieve()
*/

dwchild.settransobject(sqlca)
dw_browse.settransobject(sqlca)

gnv_appeondb.of_startqueue( )

dwchild.retrieve()
dw_browse.retrieve()

gnv_appeondb.of_commitqueue( )

cnt = dw_browse.rowcount( )

//---------------------------- APPEON END ----------------------------

if of_get_app_setting("set_22","I") = 1 then //Start Code Change ----12.16.2009 #V10 maha
	cbx_overdue.checked = true
end if


r_on.fillcolor = 8453888 //maha 091302
ii_on_off = 1				//maha 091302

//-----Begin Added by alfee 01.26.2011----------------------------	
//Web based scheduler
IF AppeonGetClientType() = 'WEB' AND gb_IsAutoExport THEN 
	//Trigger it immediately
	of_timer () 	
	//Close the IE window 
	of_close_iewin ("Appeon Web Library")
	RETURN
END IF
//-----End Added -----------------------------------------------------

//gi_test_mode = 1//Start Code Change ----12.15.2009 #V10 maha
Timer ( 60 ,w_auto_export )


if cnt > 0 then
	for i = 1 to cnt
		if dw_browse.getitemnumber(i,"active_status") = 1 then
			//compare times 
			
		end if
	next
end if
			




end event

event close;//---------Begin Added by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
Timer(0)				//Added by Scofield on 2010-05-18
//---------End Added ------------------------------------------------------------------

if gb_IsAutoExport then halt close //web based scheduler - alfee 01.26.2011

//if is_came_from = "A" then
//	disCONNECT USING SQLCA;
//end if
end event

event timer;of_timer()

//if ii_on_off = 0 then return
//
//datetime ldt_nowtime
//datetime ldt_nexttime
//date ld_date
//time lt_time
//integer i
//integer r
//integer rc
//integer n
//integer li_int
//integer li_month
//integer li_newmonth
//integer li_day
//integer li_year
//integer li_minute
//integer li_hour
//integer li_newminute
//integer li_newhour
//integer day_add
//integer hour_add
//date ld_rundate
//time lt_runtime
//integer chk = 0
//integer li_error
//
//
////st_running.visible = true
//ldt_nowtime = datetime(today(),now())
//ld_date = date(ldt_nowtime)
//lt_time = time(ldt_nowtime)
//li_day = day(ld_date)
//li_month = month(ld_date)
//li_year = year(ld_date)
//li_minute = minute(lt_time)
//li_hour  = hour(lt_time)
//
//
//rc = dw_browse.rowcount()
//	if rc < 1 then return
//	
////messagebox("minute test",string(ldt_nowtime))
//	for r = 1 to rc //check each export item to see it it should be run
//		if dw_browse.getitemnumber(r,"active_status") = 1 then
//			ld_rundate = date(dw_browse.getitemdatetime(r,"run_time"))
//			lt_runtime = time(dw_browse.getitemdatetime(r,"run_time"))
//
//			if ld_rundate = ld_date and hour(lt_runtime) = li_hour and minute(lt_runtime) = li_minute then
//				//messagebox("run",string(ldt_nowtime))
//				//1)run the export
//				 li_error =  of_run_export(dw_browse.getitemnumber(r,"auto_export_id"))
//
//					
//				//2)set next run time
//				  li_int = dw_browse.getitemnumber(r,"interval")
//				  li_newminute = minute(lt_runtime)
//				  li_newhour = hour(lt_runtime)
//				choose case dw_browse.getitemnumber(r,"frequency")
//						case 1 //minute
//							li_newminute = minute(lt_runtime) + li_int
//								hour_add = 0
//								do while li_newminute > 59
//									hour_add ++
//									li_newminute = li_newminute - 60
//								loop
//								li_newhour = hour(lt_runtime) + hour_add
//								do while li_newhour > 23
//									day_add ++
//									li_newhour = li_newhour - 24
//								loop
//							ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
//						case 2 //hour
//							li_newhour = hour(lt_runtime) + li_int
//							day_add = 0
//							do while li_newhour > 23
//								day_add ++
//								li_newhour = li_newhour - 24
//							loop
//							ldt_nexttime = datetime(RelativeDate ( ld_date, day_add ),time(string(li_newhour) + ":" + string(li_newminute) + ":" + "00"  ))
//						case 3 //day
//							ldt_nexttime = datetime(RelativeDate ( ld_date, li_int ),lt_time)
//						case 4 //week
//							n = li_int * 7
//							ldt_nexttime = datetime(RelativeDate ( ld_date, n ),lt_time)
//						case 5 //month
//							li_newmonth = li_month + li_int
//							if li_newmonth > 12 then 
//								li_newmonth = li_newmonth - li_month
//								li_year = li_year + 1
//							end if
//							choose case li_day
//								case 29,30,31
//									choose case li_month
//										case 2
//											li_day = 28
//										case 4,6,9,11
//											li_day = 30
//									end choose
//							end choose					
//							ldt_nexttime = datetime(date(string(li_month) + "-" + string(li_day) + "-" + string(li_year)),lt_time)
//						case else
//							ldt_nexttime = ldt_nowtime
//					end choose
//					dw_browse.setitem(r,"run_time",ldt_nexttime)
//					dw_browse.setitem(r,"last_run",ldt_nowtime)
//					dw_browse.setitem(r,"error_code",li_error)
//					//messagebox("run time",string(ldt_runtime))
//					//messagebox("next run",string(ldt_nexttime))
//					chk = 1
//					if li_error < 1 then
//						continue
//					end if
//					if dw_browse.getitemnumber(r,"reset_audit") = 1 then
//						//maha modified 100902
//						update sys_audit set exported = 0, export_date = :ldt_nowtime  where exported = 1 and date_time_modified <= :ldt_nowtime;
//						commit using sqlca;
//					end if		
//			end if
//		end if
//	next	
//	
//
//	
//	
//if chk = 1 then 
//	dw_browse.update()
//	commit using sqlca;
//	dw_browse.retrieve()
//	dw_detail.retrieve(il_export_id)
//end if
//	//if mod(li_minute,li_second) = 0 or mod(li_minute,li_second) = 5 then
//	//st_running.visible = false
//	//messagebox("minute test",string(ldt_runtime))
////end if
end event

type cb_3 from commandbutton within w_auto_export
integer x = 2011
integer y = 1692
integer width = 485
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy to Scheduler"
end type

event clicked;//Start Code Change ----04.26.2010 #V10 maha - added
integer li_ans
integer li_row
long ll_exp

string ls_export
n_ds lds_row


li_ans = messagebox("Migrate Export","This will migrate this Auto Export setup to the Scheduler.~rNote the Schedule item will be set to INACTIVE until turned on manually.~r~rContinue?",question!,yesno!,1)

if li_ans = 2 then return

if dw_detail.getrow( ) < 1 then return //(Appeon)Harry 08.07.2013 BugH080701

lds_row = create n_ds

lds_row.dataobject = "d_schedule_import"
lds_row.settransobject(sqlca)

lds_row.insertrow(1)

ll_exp = dw_detail.Getitemnumber(1,"export_id")
select export_name into :ls_export from export_header where export_id = :ll_exp;

if isnull(ls_export) or ls_export = "" then
	Messagebox("Export migration","Unable to get the Export name.")
	return
end if

lds_row.setitem(1,"sched_name","Export " + ls_export)
lds_row.setitem(1,"sched_type",20)
lds_row.setitem(1,"active_status",0)
lds_row.setitem(1,"next_start", dw_detail.Getitemdatetime(1,"run_time"))
lds_row.setitem(1,"run_overdue",0)
lds_row.setitem(1,"interval_type",dw_detail.Getitemnumber(1,"frequency"))
lds_row.setitem(1,"interval_length",dw_detail.Getitemnumber(1,"interval"))
lds_row.setitem(1,"imp_exp_option",ll_exp)
lds_row.setitem(1,"file_path",dw_detail.Getitemstring(1,"save_to_path"))
select max(sched_id) into :ll_exp from schedule_hrd;
if isnull(ll_exp) then ll_exp = 0
ll_exp++
lds_row.setitem(1,"sched_id",ll_exp)

lds_row.update()


messagebox("Migrate Export","Completed")









end event

type cb_sort from commandbutton within w_auto_export
integer x = 3182
integer y = 452
integer width = 261
integer height = 76
integer taborder = 60
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
dw_browse.Setsort(null_str)
dw_browse.sort()
end event

type cb_filter from commandbutton within w_auto_export
integer x = 3182
integer y = 560
integer width = 261
integer height = 76
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str
SetNull(null_str)
dw_browse.SetFilter(null_str)
dw_browse.Filter()
end event

type cbx_overdue from checkbox within w_auto_export
integer x = 1335
integer y = 1632
integer width = 576
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Run overdue exports"
end type

type cb_painter from commandbutton within w_auto_export
integer x = 2569
integer y = 1604
integer width = 485
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Export Painter"
end type

event clicked;//open(w_export_painter)

end event

type cb_2 from commandbutton within w_auto_export
integer x = 3081
integer y = 1604
integer width = 320
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find Query"
end type

event clicked;integer m
string docname, named, path
string ls_query
integer li_file_num
integer value
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.25.2007 By: Jack
//$<reason> Fix a defect.
If dw_detail.rowcount() < 1 Then Return
//---------------------------- APPEON END ----------------------------
//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
  /*
	value = GetFileopenName("Select Directory and enter 'Path' as file name",&
	+ docname, named, "DOC", &
		+ "text Files (*.txt),*.txt,Query Files(*.sql),*.sql")//Modify 08/21/2007 by: Andy add:Query Files(*.sql),*.sql 
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008      
  */
gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
value = GetFileopenName("Select Directory and enter 'Path' as file name",&
+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt,Query Files(*.sql),*.sql")//Modify 08/21/2007 by: Andy add:Query Files(*.sql),*.sql 
gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10
//---------End Modfiied ------------------------------------------------------------------
IF value = 1 THEN
	path = MidA(docname,1,PosA(docname,named,1) - 1)
//	this.setitem(1,"save_to_path",path) 


	li_file_num = FileOpen(named, StreamMode!, Read!, LockRead!)
	
	FileRead ( li_file_num, ls_query)
	
	if LenA(dw_detail.getitemstring(1,"sql_syntax")) > 0 then
		m = Messagebox("Replace?","There is already a query in place. Do you wish to replace it?",question!,yesno!,1)
		if m = 1 then
			dw_detail.setitem(1,"sql_syntax",ls_query)
		else
			return
		end if
	else
		dw_detail.setitem(1,"sql_syntax",ls_query)
	END IF
	FileClose ( li_file_num)
	
end if
end event

type cb_1 from commandbutton within w_auto_export
integer x = 3182
integer y = 196
integer width = 261
integer height = 76
integer taborder = 100
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

type st_running from statictext within w_auto_export
boolean visible = false
integer x = 823
integer y = 1612
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

type cb_on_off from commandbutton within w_auto_export
integer x = 119
integer y = 1604
integer width = 603
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "AUTO EXPORT &ON"
end type

event clicked;integer i
integer c = 0


if ii_on_off = 0 then
	ii_on_off = 1
	this.text = "AUTO EXPORT ON"
	r_on.fillcolor = 8453888
	for i = 1 to dw_browse.rowcount()
		if dw_browse.getitemnumber(i,"active_status") = 1 then
			if dw_browse.getitemdatetime(i,"run_time") < datetime(today(),now()) then
				c = 1
			end if
		end if
	next
	if c = 1 then 
		messagebox("Warning","One or more of your active exports' next run date is past . You may want to reset. ")
	end if
		
else 
	ii_on_off = 0
	this.text = "AUTO EXPORT OFF"
	r_on.fillcolor = RGB(255,0,0)
end if
end event

type cb_save from commandbutton within w_auto_export
integer x = 3182
integer y = 376
integer width = 261
integer height = 76
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;integer li_exp
integer i
integer r

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.27.2007 By: Jack
//$<reason> Fix a defect.
long ll_export_id

//<add> 08/21/2007 by: Andy
if dw_detail.getrow() < 1 then return 

dw_detail.accepttext()
//If dw_detail.getrow() > 0 Then //comment 08/21/2007 by:Andy
ll_export_id = dw_detail.getitemnumber(dw_detail.getrow(),'export_id')
If isnull(ll_export_id) or ll_export_id = 0 Then
	messagebox('Save' , 'The export is a required column.')
	dw_detail.setfocus()
	dw_detail.setcolumn('export_id')
	Return
End If
//End If
//---------------------------- APPEON END ----------------------------

//<add> 08/21/2007 by: Andy
if dw_detail.Modifiedcount( ) + dw_detail.deletedcount( ) < 1 then return
//end of add

//modify 08/21/2007 by: Andy
if dw_detail.getitemstatus( dw_detail.getrow(), 0, primary!) = NewModified! then
	select max(auto_export_id) into :li_exp from export_auto_settings;
	
	if isnull(li_exp) then li_exp = 0
	
	li_exp ++
	
	dw_detail.setitem(1,"auto_export_id",li_exp)
end if
//end of modify

i = dw_detail.update()
if i = 1 then
	commit using sqlca;
	dw_browse.retrieve()
	r = dw_browse.find("auto_export_id = " + string(li_exp),1,dw_browse.rowcount())
	if r > 0 then 
		dw_browse.scrolltorow(r)
		dw_browse.setrow(r)
//		dw_browse.selectrow(0,false)
//		dw_browse.selectrow(r,true)
		
	end if
end if

end event

type dw_detail from datawindow within w_auto_export
integer x = 91
integer y = 664
integer width = 3314
integer height = 896
integer taborder = 40
string dataobject = "d_export_auto_set_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//DataWindowChild dwchild
//
//dw_detail.settransobject(sqlca)
//
//This.GetChild( "export_id", dwchild )
//
//dwchild.settransobject(sqlca)
//dwchild.retrieve()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2007 By: Jack
//$<reason> Fix a defect.

datawindowchild child
this.getchild("export_id",child)
If gb_contract_version Then
	child.setfilter("export_type in (3,4)")
	child.filter()
Else
	child.setfilter('')
	child.filter()
End If
//---------------------------- APPEON END ----------------------------

//<add> 08/21/2007 by: Andy
if gb_contract_version then
	modify("use_audit.protect='1'")
end if
//end of add

end event

event buttonclicked;
string docname, named, path

integer value, ao

if dwo.Name = "path" THEN		//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
	//---------Begin Modified by (Appeon)Toney 07.11.2013 for V141 ISG-CLX--------
	  /*
	value = GetFilesaveName("Save As File",&
	+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
	ChangeDirectory(gs_current_path) //Add by Evan 12/11/2008			
	  */
	gf_load_dir_path() //Added by Ken.Guo on 2009-03-10
	value = GetFilesaveName("Save As File",&
	+ docname, named, "DOC", &
	+ "text Files (*.txt),*.txt")
	gf_save_dir_path(docname) //Added by Ken.Guo on 2009-03-10	 
	//---------End Modfiied ------------------------------------------------------------------
end if
IF value = 1 THEN
	path  = MidA(docname,1,LenA(docname) - 4 )//path and file w/out extension
	//path = mid(docname,1,pos(docname,named,1) - 1) //path only no file
	this.setitem(1,"save_to_path",path) 
END IF


if dwo.Name = "audit" THEN
	
	ao = this.getitemnumber(1,"active_only") 
	//---------Begin Modified by (Appeon)Harry 12.03.2013 V141 for BugH101503 of History Issues--------
	/*
	if ao < 1 or isnull(ao) then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct prac_id from sys_audit where exported = 1;")
	elseif ao = 1 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 1;")
	elseif ao = 4 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 4;")
	elseif ao = 2 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4);")
	end if
	*/
	if ao < 1 or isnull(ao) then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct prac_id from sys_audit where exported = 1 and table_id < 1000;")
	elseif ao = 1 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 1 and sys_audit.table_id < 1000;")
	elseif ao = 4 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 4 and sys_audit.table_id < 1000;")
	elseif ao = 2 then
		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4) and sys_audit.table_id < 1000;")
	end if
	//---------End Modfiied ------------------------------------------------------
end if
end event

event itemchanged;integer ao
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.24.2007 By: Jack
//$<reason> Fix a defect.
long ll_export_id
string ls_sql
this.accepttext()
If This.getcolumnname() = 'export_id' Then
	ll_export_id = this.getitemnumber(1,'export_id')
	
	of_use_audit_protect(false)//Added by (Appeon)Harry 12.03.2013 V141 for BugH101503 of History Issues--------

	select prac_sql into :ls_sql from export_header where export_id = :ll_export_id;
	If isnull(ls_sql) or ls_sql = '' Then ls_sql = 'Select distinct ctx_id from ctx_basic_info where ctx_id > 0;' 
	this.setitem(1,'sql_syntax',ls_sql)
End If
//---------------------------- APPEON END ----------------------------

IF This.GetColumnName() = "use_audit" THEN
	//this.accepttext()      //Comment by Jack 05/24/2007
	if this.getitemnumber(1,"use_audit") = 1 then
		ao = this.getitemnumber(1,"active_only") 
		//---------Begin Modified by (Appeon)Harry 12.03.2013 V141 for BugH101503 of History Issues--------
		/*
		if ao < 1 or isnull(ao) then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct prac_id from sys_audit where exported = 1;")
		elseif ao = 1 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 1;")
		elseif ao = 4 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 4;")
		elseif ao = 2 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4);")
		end if	
		*/
		if ao < 1 or isnull(ao) then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct prac_id from sys_audit where exported = 1 and table_id < 1000;")
		elseif ao = 1 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 1 and sys_audit.table_id < 1000;")
		elseif ao = 4 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 4 and sys_audit.table_id < 1000;")
		elseif ao = 2 then
			dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4) and sys_audit.table_id < 1000;")
		end if
		//---------End Modfiied ------------------------------------------------------
	else
		this.setitem(1,"reset_audit",0)
	end if
END IF



end event

type dw_browse from datawindow within w_auto_export
integer x = 87
integer y = 36
integer width = 3017
integer height = 604
integer taborder = 70
string dataobject = "d_export_auto_set_brow"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;//Comment 08/21/2007 by: Andy
//integer r
//integer i
//
//r = this.getclickedrow()
//
//this.setrow(r)
////this.selectrow(0,false)
////this.selectrow(r,true)
//
//this.selectrow(0,false)
//this.selectrow(row,true)
//if this.rowcount() > 0 then
//	i  = this.getitemnumber(this.getrow(),"auto_export_id")
//	dw_detail.retrieve(i)
//end if

end event

event rowfocuschanged;//<add> 08/21/2007 by: Andy
integer ll_i

if currentrow < 1 or rowcount() < 1 then return

this.selectrow(0,false)
this.selectrow(currentrow,true)

ll_i  = this.getitemnumber(currentrow,"auto_export_id")
dw_detail.retrieve(ll_i)
of_use_audit_protect(true)  //Added by (Appeon)Harry 12.03.2013 V141 for BugH101503 of History Issues--------

end event

event retrieveend;//<add> 08/21/2007 by: Andy
if gb_contract_version then 
	setfilter("export_type in (3,4)")
	filter()
	if RowCount() < 1 then 
		dw_detail.reset( )
	else
		event rowfocuschanged(1)
	end if
end if
//end of add
end event

type cb_4 from commandbutton within w_auto_export
integer x = 3182
integer y = 276
integer width = 261
integer height = 76
integer taborder = 30
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

type cb_qiut from commandbutton within w_auto_export
integer x = 3182
integer y = 32
integer width = 261
integer height = 76
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_run from commandbutton within w_auto_export
integer x = 2011
integer y = 1604
integer width = 485
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Test Export"
end type

event clicked;integer err
integer li_export
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.24.2007 By: Jack
//$<reason> Fix a defect.
cb_save.triggerevent(clicked!)
//---------------------------- APPEON END ----------------------------

if dw_detail.rowcount() > 0 then
	li_export = dw_detail.getitemnumber(1,"auto_export_id")

	err = of_run_export(li_export)
	//messagebox("error", err)
	st_running.visible = false
end if

end event

type cb_about from commandbutton within w_auto_export
integer x = 3182
integer y = 112
integer width = 261
integer height = 76
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "A&bout"
end type

event clicked;//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
/*
//messagebox("The Auto Export program :","See Auto Export Manual~r~r~rCopyright 2002-2003 IntelliSoft Group Inc~r1~rversion 2.0 ")
messagebox("The Auto Export program: ","See Auto Export Manual~r~r~rCopyright 2002-2003 IntelliSoft Group Inc~r1~rversion 2.0 ")
*/
MessageBox("The Auto Export program: ","See Auto Export Manual~r~r~rCopyright "+gs_copyright+" IntelliSoft Group Inc~r~rversion 2.0 ")
//---------End Modfiied ------------------------------------------------------
end event

type r_on from rectangle within w_auto_export
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 65280
integer x = 91
integer y = 1584
integer width = 654
integer height = 124
end type

