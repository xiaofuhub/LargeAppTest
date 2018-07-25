$PBExportHeader$w_auto_import.srw
forward
global type w_auto_import from window
end type
type cbx_overdue from checkbox within w_auto_import
end type
type dw_run from datawindow within w_auto_import
end type
type cb_painter from commandbutton within w_auto_import
end type
type cb_1 from commandbutton within w_auto_import
end type
type st_running from statictext within w_auto_import
end type
type cb_on_off from commandbutton within w_auto_import
end type
type cb_save from commandbutton within w_auto_import
end type
type dw_detail from datawindow within w_auto_import
end type
type dw_browse from datawindow within w_auto_import
end type
type cb_4 from commandbutton within w_auto_import
end type
type cb_qiut from commandbutton within w_auto_import
end type
type cb_run from commandbutton within w_auto_import
end type
type cb_about from commandbutton within w_auto_import
end type
type r_on from rectangle within w_auto_import
end type
end forward

global type w_auto_import from window
integer x = 27
integer y = 288
integer width = 3621
integer height = 1956
boolean titlebar = true
string title = "IntelliSoft Automated Import"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
boolean center = true
event open_old ( )
cbx_overdue cbx_overdue
dw_run dw_run
cb_painter cb_painter
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
global w_auto_import w_auto_import

type variables
integer il_import_id
integer ii_on_off = 0
string is_came_from
integer ii_timer = 0
end variables

forward prototypes
public function integer of_run_export (integer ai_auto_export_id)
public function integer of_timer ()
public function integer of_connect ()
public function integer of_run_import (integer ai_for)
public function integer of_run_project (long al_project_id)
public function integer of_checkfields ()
end prototypes

event open_old();//--------------------------- APPEON BEGIN ---------------------------
//$<delete> Evan 03.12.2009
//$<reason> Reconstruct code
/*
//Auto import window developed 11-07  maha  version 8.1

integer cnt
datetime dt_now = datetime(today(),now())
datetime	dt_run
integer i


//of_connect()
//"A" is Auto import stand alone exe, otherwise being opened from IntelliCred
if is_came_from = "A" then
//if is_came_from = "" then
	SQLCA.DBMS="ODBC"
	SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=user1;PWD=123;',DelimitIdentifier='No'"
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2007-09-14 By: Scofield
	//$<Reason> Set the connection cache dynamically on Web
	if AppeonGetClientType() = 'WEB' then
		SQLCA.DBMS = gs_CacheType
		SQLCA.DBParm = gs_CacheSet
	end if
	//---------------------------- APPEON END ----------------------------

	CONNECT USING SQLCA;

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Not Logged In", "Login Failed!")
	ELSE
		//MESSAGEBOX("","LOGIN OK")
	END IF
end if
debugbreak()
dw_detail.settransobject(sqlca)
dw_browse.settransobject(sqlca)
cnt = dw_browse.retrieve()

r_on.fillcolor = 8453888
ii_on_off = 1				

//gi_test_mode = 1
i = Timer ( 60  )

if cnt > 0 then
	for i = 1 to cnt
		if dw_browse.getitemnumber(i,"active_status") = 1 then
			//compare times 
			
		end if
	next
end if
*/
//---------------------------- APPEON END ----------------------------
end event

public function integer of_run_export (integer ai_auto_export_id);//Long prac_ids[]
//string ls_presentation_str
//string ls_sny_retrieve
//string ls_dwsyntax_str
//string ERRORS
//string ls_path
//long ll_prac_row
//n_ds lds_export
//n_ds lds_export_retrieve
//long ll_export_id
//integer i
//
//
////st_running.visible = true
////prac_ids[1] = 1
////prac_ids[2] = 3
////prac_ids[3] = 4
//lds_export = CREATE n_ds //get export info
//lds_export.dataobject = "d_export_auto_set_detail"
//lds_export.SetTransObject( SQLCA )
//lds_export.retrieve(ai_auto_export_id)
//
//// mskinner 21 Dec 2005 -- begin
////Start Code Change ---- 04.19.2007 #V7 maha  resolve a problem that could be caused by a row change not updated in this running instance
////if lds_export.rowcount() < 1 then return 0
//if lds_export.rowcount() < 1 then
//	dw_browse.retrieve()
//	lds_export.retrieve(ai_auto_export_id)
//	if lds_export.rowcount() < 1 then
//		return -2
//	end if
//end if
////End Code Change--- 04.19.2007
//// mskinner 21 Dec 2005 -- end
//
//
//ls_sny_retrieve = lds_export.getitemstring(1,"sql_syntax")
//ls_path = lds_export.getitemstring(1,"save_to_path")
//ll_export_id = lds_export.getitemnumber(1,"export_id")
//		
//ls_presentation_str = "style(type=grid)"		
//
//ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sny_retrieve, ls_presentation_str, ERRORS)
//IF Len(ERRORS) > 0 THEN
//	MessageBox("Caution", &
//	"SyntaxFromSQL caused these errors: " + ERRORS)
//	RETURN -1
//END IF
//lds_export_retrieve = CREATE n_ds
//lds_export_retrieve.Create( ls_dwsyntax_str, ERRORS)
//lds_export_retrieve.SetTransObject( SQLCA )
//
//
//string ls_datatype
//ls_datatype = lds_export_retrieve.Describe( "#1" + ".coltype")
//Choose Case Left (ls_datatype,5)
//	Case "char(","char"
//		ls_datatype = "C"
//	Case "date","datet","time","times"
//		ls_datatype = "D"
//	Case "decim","numbe","doubl","real","long","ulong","int"
//		ls_datatype = "N"
//End Choose
//
//If ls_datatype <> "N" Then
//	messagebox("Caution","SyntaxFromSQL caused these errors: " + ls_sny_retrieve)
//	RETURN -1
//End If	
//
//
//
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 2006-11-29 By: Rodger Wu (doc painter)
////$<reason> 
///* ll_prac_row = lds_export_retrieve.retrieve() */
//integer li_export_type
//
//gnv_appeondb.of_startqueue()
//lds_export_retrieve.retrieve()
//
//SELECT export_header.export_type
//INTO :li_export_type
//FROM export_header
//WHERE export_header.export_id = :ll_export_id ;
//gnv_appeondb.of_commitqueue()
//
//
//ll_prac_row = lds_export_retrieve.rowcount()
////---------------------------- APPEON END ----------------------------
//
//
//if ll_prac_row < 1 then 
//	//messagebox("no rows ",ll_prac_row)
//	return -2
//end if
//
////<add> 07/17/2007 by: Andy
//lds_export_retrieve.Setsort( "#1 A")
//lds_export_retrieve.Sort()
////end of add
//
////lds_export_retrieve.retrieve()
//for i = 1 to ll_prac_row
//	prac_ids[i] = lds_export_retrieve.getitemnumber(i,1)
//next
//
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> UM-01
////$<modify> 01.13.2006 By: Wang Chao
////$<reason> It is currently unsupported to dynamically create a visual object.
////$<modification> Replaced the visual object with a non-visual object.
////pfc_n_cst_ai_export  n_export
////n_export = CREATE pfc_n_cst_ai_export
//pfc_n_cst_ai_export_apb  n_export
//n_export = CREATE pfc_n_cst_ai_export_apb
////---------------------------- APPEON END ----------------------------
//
//il_export_id = ll_export_id
////--------------------------- APPEON BEGIN ---------------------------
////$<modify> 2006-11-29 By: Rodger Wu (doc painter)
////$<reason> 
///* n_export.of_export_data_with_text( ll_export_id, prac_ids,ls_path,0 ,"","","") */
//if li_export_type = 3 or li_export_type = 4 then
//	n_export.of_export_data_with_text_ctx( ll_export_id, prac_ids,ls_path,0 ,"","","",1,ls_sny_retrieve)
//else
//	n_export.of_export_data_with_text( ll_export_id, prac_ids,ls_path,0 ,"","","",1,ls_sny_retrieve)
//end if
////---------------------------- APPEON END ----------------------------
//
//
//
//st_running.visible = false
//
return 1
end function

public function integer of_timer ();if ii_on_off = 0 then return -1

datetime ldt_nowtime
datetime ldt_nexttime
datetime ldt_schedtime
date ld_date
time lt_time
integer i
integer r
integer rc
integer n
integer li_int
integer li_run
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
boolean lb_IsTimerStop = false //Evan 12.29.2011

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
	
of_connect( ) // keep connection live


////messagebox("minute test",string(ldt_nowtime))
//	for r = 1 to rc //check each import item to see it it should be run
//		//debugbreak()
//		if dw_browse.getitemnumber(r,"active_status") = 1 then
//			ld_rundate = date(dw_browse.getitemdatetime(r,"run_time"))
//			lt_runtime = time(dw_browse.getitemdatetime(r,"run_time"))
//
//			if ld_rundate = ld_date and hour(lt_runtime) = li_hour and minute(lt_runtime) = li_minute then
for r = 1 to rc //check each export item to see it it should be run	
		//Start Code Change ----11.2.2009 #V10 maha - modify to allow for running overdue exports
	if dw_browse.getitemnumber(r,"active_status") = 1 then  //Start Code Change ----05.10.2011 #V11 maha - readded active status test
			if isnull(dw_browse.getitemdatetime(r,"run_time")) then
				ldt_schedtime = ldt_nowtime
			else
				ldt_schedtime = dw_browse.getitemdatetime(r,"run_time")
			end if
			
			ld_rundate = date(ldt_schedtime)
			lt_runtime = time(ldt_schedtime)

		
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
				li_run = 1
				
				//messagebox("run",string(ldt_nowtime))
				//1)run the import				 
			 	 //li_error =  of_run_import(dw_browse.getitemnumber(r,"ia_id")) //Delete by Evan 04.20.2009
  				 Timer(0) //Added by Evan 12.29.2011 --- for fix pb exception
				 lb_IsTimerStop = true
				 of_run_import(dw_browse.getitemnumber(r,"ia_id")) //Add by Evan 04.20.2009
					//messagebox("run",li_error)
					
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
					//dw_browse.setitem(r,"error_code",li_error) //Delete by Evan 04.20.2009
					//messagebox("run time",string(ldt_runtime))
					//messagebox("next run",string(ldt_nexttime))
					chk = 1
					//------------------- APPEON BEGIN -------------------
					//$<delete> Evan 04.20.2009
					//$<reason> The error_code field is invalid.
					/*
					if li_error < 1 then
						continue
					end if
					*/
					//------------------- APPEON END ---------------------
				end if
		end if
	next	
	
	
	
if chk = 1 then 
	dw_browse.update()
	commit using sqlca;
	dw_browse.retrieve()
	dw_detail.retrieve(il_import_id)
end if

garbagecollect() //Start Code Change ----11.03.2009 #V10 maha

if lb_IsTimerStop then Timer(60) //Added by Evan 12.29.2011 --- for fix pb exception

return 1

//if ii_on_off = 0 then return -1
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
//integer ao
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
//if rc < 1 then return -1
//	
//of_connect( ) // keep connection live
//	
////messagebox("minute test",string(ldt_nowtime))
//	for r = 1 to rc //check each import item to see it it should be run
//		//debugbreak()
//		if dw_browse.getitemnumber(r,"active_status") = 1 then
//			ld_rundate = date(dw_browse.getitemdatetime(r,"run_time"))
//			lt_runtime = time(dw_browse.getitemdatetime(r,"run_time"))
//
//			if ld_rundate = ld_date and hour(lt_runtime) = li_hour and minute(lt_runtime) = li_minute then
//				//messagebox("run",string(ldt_nowtime))
//				//1)run the import				 
//			 	 //li_error =  of_run_import(dw_browse.getitemnumber(r,"ia_id")) //Delete by Evan 04.20.2009
//				 	of_run_import(dw_browse.getitemnumber(r,"ia_id")) //Add by Evan 04.20.2009
//					//messagebox("run",li_error)
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
//					dw_browse.setitem(r,"run_time",ldt_nexttime)
//					dw_browse.setitem(r,"last_run",ldt_nowtime)
//					//dw_browse.setitem(r,"error_code",li_error) //Delete by Evan 04.20.2009
//					//messagebox("run time",string(ldt_runtime))
//					//messagebox("next run",string(ldt_nexttime))
//					chk = 1
//					//------------------- APPEON BEGIN -------------------
//					//$<delete> Evan 04.20.2009
//					//$<reason> The error_code field is invalid.
//					/*
//					if li_error < 1 then
//						continue
//					end if
//					*/
//					//------------------- APPEON END ---------------------
//				end if
//		end if
//	next	
//	
//	
//	
//if chk = 1 then 
//	dw_browse.update()
//	commit using sqlca;
//	dw_browse.retrieve()
//	dw_detail.retrieve(il_import_id)
//end if
//
//return 1
end function

public function integer of_connect ();//maha app101405
integer i
ii_timer++

if ii_timer > 60 then  //once per hour hit the database to keep the connection alive
	select set_1 into :i from icred_settings;
	ii_timer = 0
end if

return 1



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

public function integer of_run_import (integer ai_for);//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.10.2008 By: Evan
//$<reason> Due to have no consider IntelliContract import.
/*
//NEW maha 11.27.2007 V8
integer res = 1
integer cnt
long ll_proj
long ll_imp
n_cst_import lnvo_imp
//n_cst_import_cred lnvo_cred //Delete by evan on 12.17.2007
n_cst_import_credapp lnvo_cred //Add by evan on 12.17.2007

ll_proj = dw_detail.getitemnumber(1,"project_id")
ll_imp = dw_detail.getitemnumber(1,"import_id")

lnvo_imp = create n_cst_import
//lnvo_cred = create n_cst_import_cred //Delete by evan on 12.17.2007
lnvo_cred = create n_cst_import_credapp //Add by evan on 12.17.2007

//call import functions 
	
dw_run.settransobject(sqlca)
cnt = dw_run.retrieve(ll_imp) //add trap for no data
if cnt < 1 then return -1

if ll_proj > 0 then //if a project run all connected imports
	res = lnvo_cred.of_run_project(ll_proj, "Auto") //Modify by evan on 02.18.2008
elseif ll_imp > 0 then //or run a single import
	//lnvo_cred.Event ue_ExecuteImport1(ll_imp,dw_run) //Delete by evan on 12.17.2007
	lnvo_cred.of_Execute(ll_imp, false) //Add by evan on 02.18.2008
end if

destroy lnvo_imp
destroy lnvo_cred

return res
*/
long ll_Return
long ll_FindRow
long ll_import_id
long ll_proejct_id
long ll_isoft_module
n_cst_import lnv_import

// Get import information
ll_FindRow = dw_browse.Find("ia_id=" + String(ai_for), 1, dw_browse.RowCount())
if ll_FindRow <= 0 then Return -1
ll_import_id = dw_browse.GetItemNumber(ll_FindRow, "import_id")
ll_proejct_id = dw_browse.GetItemNumber(ll_FindRow, "project_id")

// Run import
if ll_proejct_id > 0 then
	// Run import of project
	ll_Return = of_run_project(ll_proejct_id)
elseif ll_import_id > 0 then
	// Get import type
	select isoft_module into :ll_isoft_module from import_hdr where import_id = :ll_import_id;
	if IsNull(ll_isoft_module) or ll_isoft_module <= 0 then Return -1
	
	// Run import according to import type
	if ll_isoft_module = 1 then
		// IntelliCred/App import
		lnv_import = Create n_cst_import_credapp
	else
		// IntelliContract import
		lnv_import = Create n_cst_import_contract
	end if
	ll_Return = lnv_import.of_Execute(ll_import_id, false)
	Destroy lnv_import
end if

if IsValid(w_import_progressbar) then Close(w_import_progressbar)

Return ll_Return
//---------------------------- APPEON END ----------------------------
end function

public function integer of_run_project (long al_project_id);//Add by Evan on 03.10.2008
long ll_import_id
long i, ll_RowCount
DataStore lds_data
n_cst_import lnv_import

lds_data  = Create DataStore
lds_data.DataObject = "d_import_ds_project"
lds_data.SetTransObject(SQLCA)
ll_RowCount = lds_data.Retrieve(al_project_id)
if ll_RowCount <= 0 then Return -1

// Run imports associate with specify project.
for i = 1 to ll_RowCount
	ll_import_id = lds_data.object.import_id[i]
	if lds_data.object.isoft_module[i] = 1 then
		// IntelliCred/App import
		lnv_import = Create n_cst_import_credapp
	else
		// IntelliContract import
		lnv_import = Create n_cst_import_contract
	end if
	lnv_import.of_Execute(ll_import_id, false)
	Destroy lnv_import
next

Destroy lds_data
if IsValid(w_import_progressbar) then Close(w_import_progressbar)

Return ll_RowCount
end function

public function integer of_checkfields ();//////////////////////////////////////////////////////////////////////
// $<function> of_checkfields
// $<arguments>
// $<returns> integer
// $<description> Check field if null.
//////////////////////////////////////////////////////////////////////
// $<add> 03.16.2009 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Row

ll_Row = dw_detail.GetRow()
if ll_Row <= 0 then Return 0

if LenA(Trim(dw_detail.GetItemString(ll_Row, "import_name"))) > 0 then
else
	MessageBox("Save", "The Auto Import Name is a required column.")
	dw_detail.SetColumn("import_name")
	dw_detail.SetFocus()
	Return -1
end if

if IsNull(dw_detail.object.frequency[ll_Row]) then
	MessageBox("Save", "The Interval Unit is a required column.")
	dw_detail.SetColumn("frequency")
	dw_detail.SetFocus()
	Return -1
end if

if IsNull(dw_detail.object.interval[ll_Row]) then
	MessageBox("Save", "The Interval is a required column.")
	dw_detail.SetColumn("interval")
	dw_detail.SetFocus()
	Return -1
end if

if IsNull(dw_detail.object.run_time[ll_Row]) then
	MessageBox("Save", "The Next Run Time is a required column.")
	dw_detail.SetColumn("run_time")
	dw_detail.SetFocus()
	Return -1
end if

if IsNull(dw_detail.object.active_status[ll_Row]) then
	MessageBox("Save", "The Status is a required column.")
	dw_detail.SetColumn("active_status")
	dw_detail.SetFocus()
	Return -1
end if

if IsNull(dw_detail.object.project_id[ll_Row]) and IsNull(dw_detail.object.import_id[ll_Row]) then
	MessageBox("Save", "Please select a Project or Import.")
	dw_detail.SetColumn("project_id")
	dw_detail.SetFocus()
	Return -1
end if

Return 1
end function

on w_auto_import.create
this.cbx_overdue=create cbx_overdue
this.dw_run=create dw_run
this.cb_painter=create cb_painter
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
this.Control[]={this.cbx_overdue,&
this.dw_run,&
this.cb_painter,&
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

on w_auto_import.destroy
destroy(this.cbx_overdue)
destroy(this.dw_run)
destroy(this.cb_painter)
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

event open;//////////////////////////////////////////////////////////////////////
// $<event>open
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.12.2009
//////////////////////////////////////////////////////////////////////

DataWindowChild ldwc_project
DataWindowChild ldwc_import

// Retrieve datawindow and dddw data
dw_detail.GetChild("project_id", ldwc_project)
dw_detail.GetChild("import_id", ldwc_import)

dw_browse.SetTransObject(SQLCA)
dw_detail.SetTransObject(SQLCA)
ldwc_project.SetTransObject(SQLCA)
ldwc_import.SetTransObject(SQLCA)

gnv_appeondb.of_StartQueue()
dw_browse.Retrieve()
ldwc_project.Retrieve()
ldwc_import.Retrieve()
gnv_appeondb.of_CommitQueue()
ldwc_project.InsertRow(1)
ldwc_import.InsertRow(1)

// Startup timer event
ii_on_off = 1
r_on.fillcolor = 8453888

//-----Begin Added by alfee 01.26.2011----------------------------	
//Web based scheduler
IF AppeonGetClientType() = 'WEB' AND gb_IsAutoImport THEN 
	//Trigger it immediately
	of_timer () 	
	//Close the IE window 
	of_close_iewin ("Appeon Web Library")
	RETURN
END IF
//-----End Added -----------------------------------------------------

Timer(60)

// Move window position
if gb_IsAutoExport then
	this.Post Move(0, 0)
end if
end event

event close;//--------------------------- APPEON BEGIN ---------------------------
//$<delete> Evan 03.12.2009
//$<reason> Reconstruct code
/*
if is_came_from = "A" then
	disCONNECT USING SQLCA;
end if
*/
//---------------------------- APPEON END ----------------------------
Timer(0)//(Appeon)Toney 07.17.2013 - V141 ISG-CLX
if gb_IsAutoImport then halt close //web based scheduler - alfee 01.26.2011

end event

event timer;of_timer()
end event

type cbx_overdue from checkbox within w_auto_import
integer x = 978
integer y = 60
integer width = 393
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Run overdue"
boolean checked = true
end type

type dw_run from datawindow within w_auto_import
boolean visible = false
integer x = 974
integer y = 1808
integer width = 686
integer height = 88
integer taborder = 100
string title = "none"
string dataobject = "d_import_hdr"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_painter from commandbutton within w_auto_import
boolean visible = false
integer x = 2578
integer y = 1792
integer width = 485
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Import Painter"
end type

event clicked;//open(w_export_painter)

end event

type cb_1 from commandbutton within w_auto_import
integer x = 1893
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
string text = "Add"
end type

event clicked;dw_detail.reset()
dw_detail.insertrow(0)



end event

type st_running from statictext within w_auto_import
boolean visible = false
integer x = 622
integer y = 48
integer width = 306
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
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

type cb_on_off from commandbutton within w_auto_import
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
string text = "AUTO IMPORT ON"
end type

event clicked;integer i
integer c = 0


if ii_on_off = 0 then
	ii_on_off = 1
	this.text = "AUTO IMPORT ON"
	r_on.fillcolor = 8453888
	for i = 1 to dw_browse.rowcount()
		if dw_browse.getitemnumber(i,"active_status") = 1 then
			if dw_browse.getitemdatetime(i,"run_time") < datetime(today(),now()) then
				c = 1
			end if
		end if
	next
	if c = 1 then 
		messagebox("Warning","One or more of your active imports' next run date is past . You may want to reset. ")
	end if
		
else 
	ii_on_off = 0
	this.text = "AUTO IMPORT OFF"
	r_on.fillcolor = RGB(255,0,0)
end if
end event

type cb_save from commandbutton within w_auto_import
integer x = 2519
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
string text = "Save"
end type

event clicked;integer li_imp
integer i
integer r
long ll_import_id


if dw_detail.getrow() < 1 then return 

dw_detail.accepttext()

if of_CheckFields() = -1 then Return // Add by Evan on 03.16.2009

//ll_import_id = dw_detail.getitemnumber(dw_detail.getrow(),'_id')
//If isnull(ll_import_id) or ll_import_id = 0 Then
//	messagebox('Save' , 'The export is a required column.')
//	dw_detail.setfocus()
//	dw_detail.setcolumn('_id')
//	Return
//End If
//End If

//modify 08/21/2007 by: Andy
if dw_detail.getitemstatus( dw_detail.getrow(), 0, primary!) = NewModified! then
	select max(ia_id) into :li_imp from import_auto;
	
	if isnull(li_imp) then li_imp = 0
	
	li_imp ++
	
	dw_detail.setitem(1,"ia_id",li_imp)
//---------Begin Added by (Appeon)Harry 11.22.2013 for V141 ISG-CLX--------
else
	li_imp = dw_detail.getitemnumber(dw_detail.getrow(), "ia_id")
//---------End Added ------------------------------------------------------
end if
//end of modify

i = dw_detail.update()
if i = 1 then
	commit using sqlca;
	dw_browse.retrieve()
	r = dw_browse.find("ia_id = " + string(li_imp),1,dw_browse.rowcount())
	if r > 0 then 
		dw_browse.scrolltorow(r)
		dw_browse.setrow(r)
//		dw_browse.selectrow(0,false)
//		dw_browse.selectrow(r,true)
		//---------Begin Added by (Appeon)Harry 11.22.2013 for V141 ISG-CLX--------
		dw_browse.selectrow(0,false)
		dw_browse.selectrow(r,true)
		//---------End Added ------------------------------------------------------
	end if
end if

end event

type dw_detail from datawindow within w_auto_import
integer x = 32
integer y = 1512
integer width = 3511
integer height = 276
integer taborder = 90
string dataobject = "d_import_auto_set_detail"
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

//if dwo.Name = "path" THEN		//value = GetFilesaveName("Select Directory and enter 'Path' as file name",&
//	value = GetFilesaveName("Save As File",&
//	+ docname, named, "DOC", &
//	+ "text Files (*.txt),*.txt")
//end if
//IF value = 1 THEN
//	path  = mid(docname,1,len(docname) - 4 )//path and file w/out extension
//	//path = mid(docname,1,pos(docname,named,1) - 1) //path only no file
//	this.setitem(1,"save_to_path",path) 
//END IF
//
//
//
//if dwo.Name = "audit" THEN
//	
//	ao = this.getitemnumber(1,"active_only") 
//	if ao < 1 or isnull(ao) then
//		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct prac_id from sys_audit where exported = 1;")
//	elseif ao = 1 then
//		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 1;")
//	elseif ao = 4 then
//		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status = 4;")
//	elseif ao = 2 then
//		dw_detail.setitem(dw_detail.getrow(),"sql_syntax","Select distinct sys_audit.prac_id from sys_audit, pd_affil_stat where sys_audit.exported = 1 and pd_affil_stat.active_status in (1,4);")
//	end if
//end if
end event

event itemchanged;//--------------------------- APPEON BEGIN ---------------------------
//$<delete> Evan 03.12.2009
//$<reason> Reconstruct code
/*
integer ao
long ll_export_id
string ls_sql
this.accepttext()


IF This.GetColumnName() = "project_id" THEN
	if integer(data) > 0 then
		this.setitem(1,"import_id",0)
	end if
END IF
*/
//---------------------------- APPEON END ----------------------------
end event

type dw_browse from datawindow within w_auto_import
integer x = 32
integer y = 180
integer width = 3506
integer height = 1304
integer taborder = 80
string dataobject = "d_import_auto_set_brow"
boolean hscrollbar = true
boolean vscrollbar = true
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

ll_i  = this.getitemnumber(currentrow,"ia_id")
dw_detail.retrieve(ll_i)

end event

event retrieveend;
//--------------------------- APPEON BEGIN ---------------------------
//$<delete> 04.28.2008 By: Evan
//$<reason> As below code is not needs.
/*
//<add> 08/21/2007 by: Andy
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
*/
//---------------------------- APPEON END ----------------------------
end event

type cb_4 from commandbutton within w_auto_import
integer x = 2199
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
string text = "Delete"
end type

event clicked;Long ll_Row,ll_OldRow,ll_cnt

ll_OldRow = dw_browse.getrow( )

//------------------- APPEON BEGIN -------------------
//$<delete> Evan 03.16.2009
//$<reason> Prompt user before deletes.
if ll_OldRow > 0 then
	if MessageBox("Delete", "Are you sure you want to delete the selected Auto Import?", Question!, YesNo!) = 2 then
		Return
	end if
end if
//------------------- APPEON END ---------------------

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
end event

type cb_qiut from commandbutton within w_auto_import
integer x = 3227
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
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_run from commandbutton within w_auto_import
integer x = 1440
integer y = 48
integer width = 443
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy to Scheduler"
end type

event clicked;//Start Code Change ----04.26.2010 #V10 maha - added for migration to scheduler
integer li_ans
integer li_row
long ll_port

string ls_export
n_ds lds_row

if dw_detail.getrow() < 1 then return //(Appeon)Harry 11.19.2013 - V141 for BugH081301 of IntelliCredApp V14.1 History Issues

li_ans = messagebox("Migrate Import","This will migrate this Auto Import setup to the Scheduler.~rNote the Schedule item will be set to INACTIVE until turned on manually.~r~rContinue?",question!,yesno!,1)

if li_ans = 2 then return

lds_row = create n_ds

lds_row.dataobject = "d_schedule_import"
lds_row.settransobject(sqlca)

lds_row.insertrow(1)

ll_port = dw_detail.Getitemnumber(1,"import_id")

lds_row.setitem(1,"sched_name","Import - " + dw_detail.Getitemstring(1,"import_name"))
lds_row.setitem(1,"sched_type",10)
lds_row.setitem(1,"active_status",0)
lds_row.setitem(1,"next_start", dw_detail.Getitemdatetime(1,"run_time"))
lds_row.setitem(1,"run_overdue",0)
lds_row.setitem(1,"interval_type",dw_detail.Getitemnumber(1,"frequency"))
lds_row.setitem(1,"interval_length",dw_detail.Getitemnumber(1,"interval"))
lds_row.setitem(1,"imp_exp_option",ll_port)
select max(sched_id) into :ll_port from schedule_hrd;
if isnull(ll_port) then ll_port = 0
ll_port++
lds_row.setitem(1,"sched_id",ll_port)

lds_row.update()


messagebox("Migrate Import","Completed")



//long ll_ia_id
//
//if dw_browse.GetRow() > 0 then
//	ll_ia_id = dw_browse.GetItemNumber(dw_browse.GetRow(), "ia_id")
//	of_run_import(ll_ia_id)
//end if

end event

type cb_about from commandbutton within w_auto_import
integer x = 2953
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
string text = "About"
end type

event clicked;//messagebox("The Auto Export program :","See Auto Export Manual~r~r~rCopyright 2002-2003 IntelliSoft Group Inc~r1~rversion 2.0 ")
MessageBox("The Auto Import program: ", "Copyright 2008 IntelliSoft Group Inc~r1~rversion 8.1 ")
end event

type r_on from rectangle within w_auto_import
long linecolor = 80269524
integer linethickness = 4
long fillcolor = 65280
integer x = 23
integer y = 28
integer width = 576
integer height = 124
end type

