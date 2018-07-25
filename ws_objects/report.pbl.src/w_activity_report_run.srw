$PBExportHeader$w_activity_report_run.srw
forward
global type w_activity_report_run from w_main
end type
type cb_clear from commandbutton within w_activity_report_run
end type
type dw_users from u_dw within w_activity_report_run
end type
type cb_2 from commandbutton within w_activity_report_run
end type
type cb_1 from commandbutton within w_activity_report_run
end type
type dw_date_range from u_dw within w_activity_report_run
end type
type dw_query from u_dw within w_activity_report_run
end type
type cb_save from commandbutton within w_activity_report_run
end type
type cb_export from commandbutton within w_activity_report_run
end type
type cb_run from commandbutton within w_activity_report_run
end type
type cb_close from commandbutton within w_activity_report_run
end type
type dw_results from u_dw within w_activity_report_run
end type
type dw_settings from u_dw within w_activity_report_run
end type
type gb_1 from groupbox within w_activity_report_run
end type
end forward

global type w_activity_report_run from w_main
integer width = 5248
integer height = 2532
string title = "Activity Reports"
long backcolor = 33551856
cb_clear cb_clear
dw_users dw_users
cb_2 cb_2
cb_1 cb_1
dw_date_range dw_date_range
dw_query dw_query
cb_save cb_save
cb_export cb_export
cb_run cb_run
cb_close cb_close
dw_results dw_results
dw_settings dw_settings
gb_1 gb_1
end type
global w_activity_report_run w_activity_report_run

forward prototypes
public function integer of_run_report ()
public function integer of_filter_providers ()
end prototypes

public function integer of_run_report ();//Start Code Change ----10.03.2017 #V16 maha
integer r
integer rc
integer d
integer dc
integer nr
integer li_find
string ls_query
string ls_table
string ls_table_sql
string ls_header
string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
string ls_user
string ls_from
string ls_to
long ll_val
long ll_total

dw_settings.accepttext()
dw_settings.setfilter("selected = 1 and report_order > 0") //Start Code Change ----10.26.2017 #V154 maha - added selected to filte
dw_settings.filter()
dw_settings.setsort("report_order ASC") 
dw_settings.sort()

rc = dw_settings.rowcount()

if rc < 1 then return 0

dw_date_range.accepttext()

ls_from = string(dw_date_range.getitemdate(1, "from_date"), "yyyy-mm-dd")
ls_to = string(dw_date_range.getitemdate(1, "to_date"), "yyyy-mm-dd")

if isnull(ls_from) then
	ls_from = "'2000-01-01 00:00:00'"
else
	ls_from+= " 00:00:00"
end if

if isnull(ls_to) then
	ls_to = "'2099-12-31  23:59:59"
else
	ls_to+= " 23:59:59"
end if

//mssagebox(ls_from, ls_to)

ls_table = string(time(now()))
ls_table = "activity" + ls_table
ls_table = of_strip_char(":" , ls_table, "") 

//create the data table
ls_table_sql = "Create table " + ls_table + " ( user_id varchar(50) null, "
debugbreak()
for r = 1 to rc
	if dw_settings.getitemnumber(r, "selected") = 1 then
		ls_header = dw_settings.getitemstring(r, "section_name")
		ls_header = of_strip_char(" " , ls_header, "_") 
		ls_table_sql = ls_table_sql + ls_header + " float null,"
	end if
next

ls_table_sql = mid(ls_table_sql, 1, len(ls_table_sql) - 1) + ");"
//openwithparm(w_sql_msg, ls_table_sql)
execute immediate :ls_table_sql using sqlca;

//create dynamic dw for results
ls_sql = "Select * from " + ls_table

ls_presentation_str = "style(type=grid)" 
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
	if PosA(ERRORS,"Table or view not found",1) > 0 then
		messagebox ("syntax error","Table in query not found." )
		return -1
	else
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN 1
	end if
END IF

dw_results.Create( ls_dwsyntax_str, ERRORS)
dw_results.SetTransObject( SQLCA )


//get each activity data
for r = 1 to rc
	if dw_settings.getitemnumber(r, "selected") = 0 then continue
	
	ls_query = dw_settings.getitemstring(r, "report_query")
	ls_query = of_strip_char("@Fromdate@" , ls_query, "'" + ls_from + "'") 
	ls_query = of_strip_char("@Todate@" , ls_query, "'" + ls_to + "'") 
	ls_query = of_strip_char("@" , ls_query, "'")

	ls_presentation_str = "style(type=grid)" 
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_query, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
			messagebox ("syntax error","Table in query not found." )
			return -1
		else
			openwithparm(w_sql_msg, ls_query)
//			MessageBox("Caution", &
//			"SyntaxFromSQL caused these errors: " + ERRORS)
//			RETURN 1
		end if
	END IF
	
	
	dw_query.Create( ls_dwsyntax_str, ERRORS)
	dw_query.SetTransObject( SQLCA )
	dc = dw_query.retrieve()
	
	for d = 1 to dc
		ls_user = dw_query.getitemstring(d, 2)
		ll_val = dw_query.getitemnumber(d, 1)
		
		li_find = dw_results.find("user_id = '" + ls_user + "'", 1, dw_results.rowcount()) 
		
		if li_find = 0  then
			nr = dw_results.insertrow(0)
		elseif li_find > 0 then
			nr = li_find
		else //error
			continue
		end if
		
		dw_results.setitem(nr, "user_id", ls_user)
		dw_results.setitem(nr, r + 1, ll_val)	
	next	
next

//resort by user
dw_results.setsort("user_id ASC") 
dw_results.sort()

//total the values
nr = dw_results.insertrow(0)
dw_results.setitem(nr, 1, 'TOTALS')

rc = integer(dw_results.Object.DataWindow.Column.Count)

for r = 2 to rc
	ll_total = 0
	for d = 1 to  dw_results.rowcount()
		ll_val = dw_results.getitemnumber(d,r)
		if isnull(ll_val) then ll_val = 0
		ll_total+= ll_val
	next
	
	dw_results.setitem(nr, r, ll_total)
next
	

ls_table_sql = "Drop table " + ls_table + ";"
execute immediate :ls_table_sql using sqlca;

dw_settings.setfilter("") 
dw_settings.filter()


return  1
end function

public function integer of_filter_providers ();integer r
integer rc
integer cnt = 0
string ls_user
string ls_filter
string ls_table

dw_users.accepttext()
rc = dw_users.rowcount()

for r = 1 to rc
	if dw_users.getitemnumber(r, "selected") = 1 then
		cnt++
		ls_user = dw_users.getitemstring(r, "user_id")
		ls_filter+= "user_id = '" + ls_user + "' OR "
		//if cnt > 1 then ls_filter+= " OR  "
	end if
next

if cnt = 0 then
	return 1
else
	ls_filter = mid(ls_filter, 1, len(ls_filter) -4) //remove last or
end if
//messagebox("",ls_filter)

dw_results.setfilter(ls_filter)
dw_results.filter()


return 1
end function

on w_activity_report_run.create
int iCurrent
call super::create
this.cb_clear=create cb_clear
this.dw_users=create dw_users
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_date_range=create dw_date_range
this.dw_query=create dw_query
this.cb_save=create cb_save
this.cb_export=create cb_export
this.cb_run=create cb_run
this.cb_close=create cb_close
this.dw_results=create dw_results
this.dw_settings=create dw_settings
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_clear
this.Control[iCurrent+2]=this.dw_users
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_date_range
this.Control[iCurrent+6]=this.dw_query
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_export
this.Control[iCurrent+9]=this.cb_run
this.Control[iCurrent+10]=this.cb_close
this.Control[iCurrent+11]=this.dw_results
this.Control[iCurrent+12]=this.dw_settings
this.Control[iCurrent+13]=this.gb_1
end on

on w_activity_report_run.destroy
call super::destroy
destroy(this.cb_clear)
destroy(this.dw_users)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_date_range)
destroy(this.dw_query)
destroy(this.cb_save)
destroy(this.cb_export)
destroy(this.cb_run)
destroy(this.cb_close)
destroy(this.dw_results)
destroy(this.dw_settings)
destroy(this.gb_1)
end on

event resize;call super::resize;long w
long h

h = this.workspaceheight( )
w = this.workspacewidth( )

h = h/3
dw_settings.height = h - 20
dw_users.height = dw_settings.height - ( dw_users.y - dw_settings.y) 
dw_results.y = dw_settings.y + dw_settings.height + 20
dw_results.height = h*2 - 20
dw_results.width = w -20


end event

type cb_clear from commandbutton within w_activity_report_run
integer x = 4105
integer y = 236
integer width = 338
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Filter"
end type

event clicked;dw_results.setfilter("")
dw_results.filter()
end event

type dw_users from u_dw within w_activity_report_run
integer x = 1966
integer y = 240
integer width = 1605
integer height = 568
integer taborder = 70
string dataobject = "d_users_cred_filter"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
this.retrieve()
end event

event buttonclicked;call super::buttonclicked;integer r
integer v

if dwo.text = "Select All" then
	v = 1
	dwo.text = "Deselect All" 	
else
	v = 0
	dwo.text = "Select All" 
end if

for r = 1 to this.rowcount()
	this.setitem(r, "selected", v)
next
end event

type cb_2 from commandbutton within w_activity_report_run
integer x = 3579
integer y = 236
integer width = 521
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter Selected Users"
end type

event clicked;of_filter_providers()
end event

type cb_1 from commandbutton within w_activity_report_run
integer x = 3913
integer y = 104
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;string s

s = "Select the reports you wish to run. Set the date range for the Activities. Click Run to retrieve the report data.~r~r"
s+= "You can change the order the reports appear in the results by modifying the sort order, then running the reports~r~r"
s+= "After the reports are run you can filter by Selected users.  The user list is all active users that are not connected to a provider record. ~r~r"
s+= "You can save the data as a file by clicking the Export Button."

messagebox("About Activity Reports",s)
end event

type dw_date_range from u_dw within w_activity_report_run
integer x = 2007
integer y = 56
integer width = 946
integer height = 144
integer taborder = 50
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
this.setitem(1, "from_date", date("2000-01-01"))
this.setitem(1, "to_date", today())
end event

event editchanged;call super::editchanged;//---------Begin Added by (Appeon)Harry 11.24.2014 for BugH101101--------
DateTime ldt_null
If IsNull(data) or data = "" Then
	SetNull(ldt_null)
	Choose Case dwo.name
		Case 'from_date'
			this.setitem(1, 'from_date', ldt_null)
		Case 'to_date'
			this.setitem(1, 'to_date', ldt_null)
	End Choose
End If
//---------End Added ------------------------------------------------------

//wf_reset_st_run( ) //(Appeon)Harry 11.25.2013 - V141 for BugH110601 of History Issues
end event

type dw_query from u_dw within w_activity_report_run
boolean visible = false
integer x = 4928
integer y = 564
integer width = 238
integer height = 160
integer taborder = 50
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable( false)
end event

type cb_save from commandbutton within w_activity_report_run
integer x = 4347
integer y = 104
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_settings.update()
end event

type cb_export from commandbutton within w_activity_report_run
integer x = 3470
integer y = 104
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export"
end type

event clicked;string ls_file
string ls_from
string ls_to
integer li_rc
string ls_path
string ls_FType

ls_from = string(dw_date_range.getitemdate(1, "from_date"), "yyyy-mm-dd")
ls_to = string(dw_date_range.getitemdate(1, "to_date"), "yyyy-mm-dd")
ls_file = gs_save_path + "Activity Report " + ls_from + " - " + ls_to
//messagebox("",ls_file)

//Added by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel
If appeongetclienttype() = 'WEB' Then  //Text (*.txt),*.txt,  Excel (*.xlsx),*.xlsx,  Excel 97-2003 (*.xls),*.xls, CSV (*.csv),*.csv,
	ls_FType = "Text with headers (*.txt),*.txt,Excel with headers (*.xlsx),*.xlsx,Excel with headers 97-2003 (*.xls),*.xls,HTML Table (*.html),*.html,XML (*.xml),*.xml,PDF (*.pdf),*.pdf,CSV with headers (*.csv),*.csv"
	li_rc = GetFileSaveName ( "SaveAs ", ls_path, ls_file, "txt",ls_FType ,gs_dir_path+"intellicred\",  32770)
	
	If li_Rc = 1 Then
		Choose Case right( ls_file,4 )
			case '.xls'
				dw_results.SaveAs( ls_path, EXcel!, true )
			case 'xlsx' //excel 2007 and 2010...//Added by (Appeon)Gavin 12.07.2017 for V16.1  Export and excel				  
				n_cst_excel lnv_excel
				lnv_excel = create n_cst_excel
				lnv_excel.of_saveas_excel( dw_results,ls_path,true, true )
				destroy lnv_excel
			case '.txt'
				dw_results.SaveAs( ls_path, Text!, true )
			case '.pdf'
				dw_results.SaveAs( ls_path, PDF!, true )
			case 'html'
				dw_results.SaveAs( ls_path, HTMLTable!, true )
			case '.xml'
				dw_results.SaveAs( ls_path, XML!, true )
			case '.csv'
				dw_results.SaveAs( ls_path, CSV!, true )
		end choose
	End If
Else
	dw_results.SaveAs ()
End If


//integer dwcontrol.SaveAs ( { string filename, saveastype saveastype,
end event

type cb_run from commandbutton within w_activity_report_run
integer x = 3031
integer y = 104
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;of_run_report()
end event

type cb_close from commandbutton within w_activity_report_run
integer x = 4768
integer y = 104
integer width = 402
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

type dw_results from u_dw within w_activity_report_run
integer y = 816
integer width = 5193
integer height = 1600
integer taborder = 10
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable( false)
end event

type dw_settings from u_dw within w_activity_report_run
integer y = 8
integer width = 1952
integer height = 800
integer taborder = 10
string dataobject = "d_activity_report_select"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
this.retrieve()
end event

event buttonclicked;call super::buttonclicked;integer r
integer v

if dwo.text = "Select All" then
	v = 1
	dwo.text = "Deselect All" 	
else
	v = 0
	dwo.text = "Select All" 
end if

for r = 1 to this.rowcount()
	this.setitem(r, "selected", v)
next

end event

type gb_1 from groupbox within w_activity_report_run
integer x = 1966
integer width = 1019
integer height = 216
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Date Range"
end type

