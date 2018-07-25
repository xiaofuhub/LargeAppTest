$PBExportHeader$w_one_click_report.srw
forward
global type w_one_click_report from window
end type
type cb_store from commandbutton within w_one_click_report
end type
type dw_audit from u_dw within w_one_click_report
end type
type cb_run from commandbutton within w_one_click_report
end type
type cb_del from commandbutton within w_one_click_report
end type
type cb_add from commandbutton within w_one_click_report
end type
type cb_save from commandbutton within w_one_click_report
end type
type dw_2 from u_dw within w_one_click_report
end type
type cb_close from commandbutton within w_one_click_report
end type
type dw_detail from datawindow within w_one_click_report
end type
type dw_browse from datawindow within w_one_click_report
end type
end forward

global type w_one_click_report from window
integer width = 3557
integer height = 2680
boolean titlebar = true
string title = "One-Click Reports"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_store cb_store
dw_audit dw_audit
cb_run cb_run
cb_del cb_del
cb_add cb_add
cb_save cb_save
dw_2 dw_2
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_one_click_report w_one_click_report

type variables
long il_id
long il_row
boolean ib_store = false
string  is_path
end variables

forward prototypes
public function integer of_run (integer ai_row, string as_format)
public function string of_get_path (integer ai_row)
public function integer of_do_headers ()
end prototypes

public function integer of_run (integer ai_row, string as_format);string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_path
string ls_null
string ls_name
long cnt
long ll_log, ll_id //maha 06.06.2016
integer g, i
n_cst_datetime lnv


//u_dw ldw_export_data
debugbreak()
ls_sql = dw_browse.getitemstring(ai_row,"sql_code")
ls_name = dw_browse.getitemstring(ai_row,"report_name")  //Start Code Change ----07.25.2016 #V152 maha

if isnull(as_format) then
	messagebox("Save type error","Format not selected")
	return -1
end if

setnull(ls_null)

ls_path = of_get_path(ai_row)


//Start Code Change ----06.29.2015 #V15 maha - added separate check function
if of_check_is_select(ls_sql) < 0 then return -1

//if PosA(upper(trim(ls_sql)),"SELECT",1) = 1 then
	//CREATE SYNTAX FOR export DW
ls_presentation_str = "style(type=grid)" 
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
	if PosA(ERRORS,"Table or view not found",1) > 0 then
		messagebox ("syntax error","Table in query not found." )
		return -1
	else
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	end if
END IF

dw_2.Create( ls_dwsyntax_str, ERRORS)
dw_2.SetTransObject( SQLCA )

 //Start Code Change ----06.06.2016 #V152 maha
ll_id = dw_browse.getitemnumber(ai_row, "rpt_id")
ll_log = of_log_sys_report("1","MAN","", ll_id , ls_name) 
cnt = dw_2.retrieve()
of_log_sys_report_end( ll_log, cnt, "")  
//End Code Change ----06.06.2016 

//st_2.text = string(cnt)
//else
//	messagebox("Sql error","Sql must be a select statement")
//	return -1
//end if
//End Code Change ----06.29.2015


CHOOSE CASE as_format
	CASE "Text!" //tab delimited
	//	of_do_headers()
		ls_path += ".txt"
	//	g = dw_2.SaveAs(ls_path,Text!,False)
		g = dw_2.SaveAs(ls_path,Text!,True)
	CASE "Excel8!" //excel
	//	of_do_headers()
	//	ls_path += ".xls"//Commented by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
	//	g = dw_2.SaveAs(ls_path,Excel8!,False)
		//g = dw_2.SaveAs(ls_path, Excel8! ,True)//Commented by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
		///Modified by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
		if integer(dw_2.describe("Datawindow.Processing")) > 1 then
			dw_2.SaveAs(ls_path, Excel!, true)
		else
			n_cst_excel lnv_excel
			boolean			lb_Version
				
			lnv_excel = create n_cst_excel
			if Integer( gf_GetExcelVersion( ) ) >=12 then
				lb_Version = true
				ls_path += ".xlsx"
			Else
				ls_path += ".xls"
			end if
			lnv_excel.ib_read = false
			lnv_excel.of_saveas_excel( dw_2, ls_path, true, lb_Version )
			destroy lnv_excel
		end if
		//end 
	CASE "CSV!" //CSV
	//	of_do_headers()
		ls_path += ".csv"
	//	g = dw_2.SaveAs(ls_path,csv!,False)
		g = dw_2.SaveAs(ls_path,csv!,True)
	CASE "XML!" //xml
		ls_path += ".xml"
		g = dw_2.SaveAs(ls_path,XML!,True)

	case else
		messagebox("Save type error","Format not supported.  Contact Support")
		return 0
END CHOOSE

if g < 0 then 
	messagebox("Save error","File Not Created:" + as_format + "Check to see that the file is not already opened.")
	return 0
end if
if ib_store = false then //(Appeon)Stephen 06.02.2017 - V15.4-WebView Reporting Functionality
	for i = 1 to 10
		setpointer(hourglass!)
		lnv.of_wait( 1)
		
		if fileexists(ls_path) then
			ShellExecuteA ( Handle( This ), "open", ls_path , ls_Null, ls_Null, 4)
			exit
		else
			if i = 20 then messagebox( "","File Not Created:" + as_format  + "Check to see that the file is not already opened." )
		end if
	next
end if
//---------Begin Added by (Appeon)Stephen 06.02.2017 for V15.4-WebView Reporting Functionality--------
ib_store = false 
is_path = ls_path
il_row = cnt
//---------End Added ------------------------------------------------------

	

end function

public function string of_get_path (integer ai_row);string ls_path
string ls_name
integer p1

ls_path = dw_browse.getitemstring(ai_row,"save_path")
ls_name = dw_browse.getitemstring(ai_row,"report_name")


if rightA(ls_path, 1 ) = "\" then
	ls_name = of_strip_char( " ", ls_name, "_" ) 
	ls_path = ls_path + ls_name
else
	 //Start Code Change ----03.02.2015 #V15 maha - trap for missing path
	if isnull(ls_path) or len(ls_path) = 0 then
		ls_path = ls_name
	end if
	 //End Code Change ----03.02.2015
end if
	
	
return ls_path
end function

public function integer of_do_headers ();//note: this doesn't work as written except for string fields.

string ls_name
integer li_cols, c, res
debugbreak()
//fix the headers
li_cols = integer(dw_2.Object.DataWindow.Column.Count)
dw_2.insertrow(1)
for c = 1 to li_cols
	ls_name = dw_2.describe("#" + string(c) + ".name")
	ls_name = of_strip_char( "_", ls_name, " ") 
	ls_name = upper(ls_name)
	dw_2.setitem(1,c,ls_name)
next

return 1
end function

on w_one_click_report.create
this.cb_store=create cb_store
this.dw_audit=create dw_audit
this.cb_run=create cb_run
this.cb_del=create cb_del
this.cb_add=create cb_add
this.cb_save=create cb_save
this.dw_2=create dw_2
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
this.Control[]={this.cb_store,&
this.dw_audit,&
this.cb_run,&
this.cb_del,&
this.cb_add,&
this.cb_save,&
this.dw_2,&
this.cb_close,&
this.dw_detail,&
this.dw_browse}
end on

on w_one_click_report.destroy
destroy(this.cb_store)
destroy(this.dw_audit)
destroy(this.cb_run)
destroy(this.cb_del)
destroy(this.cb_add)
destroy(this.cb_save)
destroy(this.dw_2)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;//Start Code Change ----11.20.2012 #V12 maha - window created.

dw_browse.settransobject(sqlca)
dw_detail.settransobject(sqlca)
dw_browse.retrieve()

//Start Code Change ----01.15.2013 #V12 maha
//read only
if w_mdi.of_security_access( 7505) = 1 then
	dw_detail.enabled = false
	cb_add.visible = false
	cb_save.visible = false
	cb_del.visible = false
	dw_detail.object.datawindow.color = 14803425
end if

if AppeonGetClientType() = "WEB" then//added by long.zhang 03.20.2013 does not support xml format on web BugL031402
		dw_detail.modify( "save_format.values='Excel	Excel8!/Text	Text!/CSV	CSV!/	/'")
end if

//---------Begin Added by (Appeon)Stephen 06.02.2017 for V15.4-WebView Reporting Functionality--------
if w_mdi.of_security_access( 7849 ) = 0 then 
	cb_store.visible = false
end if
//---------End Added ------------------------------------------------------
















end event

type cb_store from commandbutton within w_one_click_report
integer x = 2542
integer y = 164
integer width = 430
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&tore Selected"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.02.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row, li_cnt
integer li_select, li_i
long     ll_rpt_id
long     ll_report_storage_id
datetime ldt_null
string   ls_format
string   ls_note
str_b    lstr_rpt

li_row = dw_browse.rowcount()
if li_row < 1 then return

li_i = 0
for li_cnt = 1 to li_row
	li_select = dw_browse.getitemnumber(li_cnt, "selected")
	if li_select <> 1 then continue
	ll_rpt_id = dw_browse.getitemnumber(li_cnt, "rpt_id")
	openwithparm(w_rpt_storage_select, "R-1:"+string(ll_rpt_id))
	lstr_rpt = message.powerobjectparm
	ll_report_storage_id = lstr_rpt.i_count
	ls_note = lstr_rpt.s_type
	if ll_report_storage_id < 1 then continue
	ib_store = true
	is_path = ""
	ls_format = dw_browse.getitemstring(li_cnt,"save_format")
	of_run( li_cnt, ls_format)
	li_i = li_i +1
	if fileexists(is_path) and ll_report_storage_id>0 then
		f_report_storage(ll_report_storage_id, is_path, il_row, ldt_null, ldt_null, ls_note, 'M')
	end if
next

if li_i = 0 then
	messagebox("Prompt", "The selected records don’t have report storage information. Please set it up in Saved Report Setup window.")
end if
end event

type dw_audit from u_dw within w_one_click_report
boolean visible = false
integer x = 2848
integer y = 284
integer width = 640
integer height = 588
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_report_audit_view"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
end event

type cb_run from commandbutton within w_one_click_report
integer x = 2089
integer y = 164
integer width = 407
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run All Selected"
end type

event clicked;integer r,rc
long ll_id
string ls_format

for r = 1 to dw_browse.rowcount()
	if dw_browse.getitemnumber(r,"selected") = 1 then
		ll_id = dw_browse.getitemnumber(r,"rpt_id")
		ls_format = dw_browse.getitemstring(r,"save_format")
		of_run( r, ls_format)
		rc++
	end if
next

if rc < 1 then
	messagebox("Run Reports","No Reports have been selected to run")
else
	messagebox("Run Reports","Completed")
end if
		
end event

type cb_del from commandbutton within w_one_click_report
integer x = 2811
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res


res = messagebox("Delete","Delete this report setup?",question!,yesno!,2)

if res  = 2 then return

//Start Code Change ----07.18.2016 #V152 maha - corrected auditing record
if dw_detail.getitemnumber(1, "rpt_id") > 1 then  //skip if deleting a new record.
	dw_audit.setitem(1,"report_id", dw_detail.getitemnumber(1, "rpt_id"))
	dw_audit.setitem(1,"report_name", dw_detail.getitemstring(1,"report_name"))
	dw_audit.setitem(1, "add_edit", "D") 
	dw_audit.setitem(1, "mod_date", datetime(today() , now()))
	dw_audit.update()
end if
//Start Code Change ----07.18.2016

//	ll_org = dw_detail.getitemnumber(1, "rpt_id")   //Start Code Change ----03.10.2016 #V15 maha - after update get the id for a new report.
//	//Start Code Change ----06.16.2016 #V152 maha
//	dw_audit.setitem(1,"report_id", ll_org)
//	
//	dw_audit.update()
//	//End Code Change ----06.16.2016

dw_detail.deleterow(1)
dw_detail.update()

dw_browse.retrieve()

end event

type cb_add from commandbutton within w_one_click_report
integer x = 2455
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_detail.insertrow(1)

//Start Code Change ----06.16.2016 #V152 maha - auditing record
dw_audit.reset()
dw_audit.insertrow(1)
//dw_audit.setitem(1, "report_id", il_view_id)
//dw_audit.setitem(1, "report_name", dw_detail.getitemstring(1,"export_name"))
dw_audit.setitem(1, "mod_user", gs_user_id)
dw_audit.setitem(1, "add_edit", "A")
dw_audit.setitem(1, "report_type", "1")
//End Code Change ----06.16.2016

end event

type cb_save from commandbutton within w_one_click_report
integer x = 2089
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked; //Start Code Change ----03.03.2015 #V15 maha - error trapping
 string ls_path
 long ll_org =1  //maha 03.10.2016
 long r
 
ls_path = dw_detail.getitemstring(dw_detail.getrow(), "save_path")
if isnull(ls_path) or len(trim(ls_path)) = 0 then
	dw_detail.setitem(dw_detail.getrow(), "save_path", dw_detail.getitemstring(dw_detail.getrow(), "report_name"))
end if
 //End Code Change ----03.03.2015

 //Start Code Change ----03.10.2016 #V15 maha
 if dw_detail.rowcount() > 0 then
 	ll_org = dw_detail.getitemnumber(1, "rpt_id")
	 if isnull(ll_org) then ll_org = -1
end if
 //End Code Change ----03.10.2016

dw_detail.update()
if ll_org = -1 then 
	ll_org = dw_detail.getitemnumber(1, "rpt_id")   //Start Code Change ----03.10.2016 #V15 maha - after update get the id for a new report.
	//Start Code Change ----06.16.2016 #V152 maha
	dw_audit.setitem(1,"report_id", ll_org)
	dw_audit.setitem(1,"report_name", dw_detail.getitemstring(1,"report_name"))
	//End Code Change ----06.16.2016
end if

dw_audit.update() //Start Code Change ----07.19.2016 #V152 maha - moved down from if


dw_browse.retrieve()

 //Start Code Change ----03.10.2016 #V15 maha
 if dw_browse.rowcount() > 0 then
	r = dw_browse.find( "rpt_id = " + string(ll_org), 1, dw_browse.rowcount())
	if r > 0 then
		dw_browse.setrow(r)
		dw_browse.selectrow( 0, false)
		dw_browse.selectrow( r, true )
	end if
end if
 //End Code Change ----03.10.2016
 

	
end event

type dw_2 from u_dw within w_one_click_report
boolean visible = false
integer x = 2075
integer y = 280
integer width = 750
integer height = 604
integer taborder = 30
string title = "none"
boolean hscrollbar = true
end type

type cb_close from commandbutton within w_one_click_report
integer x = 3168
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
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

type dw_detail from datawindow within w_one_click_report
integer x = 46
integer y = 936
integer width = 3461
integer height = 1620
integer taborder = 20
string title = "none"
string dataobject = "d_one_click_detail"
boolean livescroll = true
end type

event buttonclicked;//Start Code Change ----02.25.2013 #V12 maha - added
string ls_path =  GetCurrentDirectory( )
integer li_result

ls_path = this.getitemstring(1,"save_path")  

if isnull(ls_path) or len(ls_path) < 3 then
	 ls_path =  GetCurrentDirectory( )
else
	ls_path =  of_strip_char("\", ls_path, "@TOLAST@")
end if
	
li_result = GetFolder( "Save Directory", ls_path )

if li_result = 1 then
	this.setitem(1,"save_path",ls_path + "\")  
end if

end event

event itemchanged;
	if dw_audit.getitemstatus( 1, 0, primary!) = datamodified! then  //Start Code Change ----07.19.2016 #V152 maha - modified to check for new record
		of_report_audit_set('P', dw_audit, True)   
	else
		of_report_audit_set('P', dw_audit, False)  
	end if
	
end event

event retrieveend;//Start Code Change ----06.16.2016 #V152 maha - auditing record
dw_audit.reset()
dw_audit.insertrow(1)
dw_audit.setitem(1, "report_id", dw_detail.getitemnumber(1,"rpt_id"))
dw_audit.setitem(1, "report_name", dw_detail.getitemstring(1,"report_name"))
dw_audit.setitem(1, "mod_user", gs_user_id)
dw_audit.setitem(1, "add_edit", "E")
dw_audit.setitem(1, "report_type", "1")
//End Code Change ----06.16.2016
end event

type dw_browse from datawindow within w_one_click_report
integer x = 41
integer y = 24
integer width = 1998
integer height = 880
integer taborder = 10
string title = "none"
string dataobject = "d_one_click_browse"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;long ll_id

if this.rowcount() = 0 then return //Start Code Change ----03.19.2013 #V12 maha

ll_id = this.getitemnumber(currentrow,"rpt_id")

dw_detail.retrieve(ll_id)


end event

event clicked;long r

r = this.getclickedrow( )
this.setrow(r)
this.selectrow( 0, false)
this.selectrow( r, true )
end event

event buttonclicked;long ll_id
string ls_format

ll_id = this.getitemnumber(row,"rpt_id")
ls_format = this.getitemstring(row,"save_format")
of_run( row, ls_format)
end event

event retrieveend;long ll_id

if rowcount > 0 then
	ll_id = this.getitemnumber(1,"rpt_id")
	dw_detail.retrieve(ll_id)
end if
end event

