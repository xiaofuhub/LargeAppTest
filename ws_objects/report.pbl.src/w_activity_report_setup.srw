$PBExportHeader$w_activity_report_setup.srw
forward
global type w_activity_report_setup from w_main
end type
type cb_about from commandbutton within w_activity_report_setup
end type
type cb_save from commandbutton within w_activity_report_setup
end type
type cb_close from commandbutton within w_activity_report_setup
end type
type dw_settings from u_dw within w_activity_report_setup
end type
end forward

global type w_activity_report_setup from w_main
integer width = 3712
integer height = 1444
string title = "Activity Report Settings"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_about cb_about
cb_save cb_save
cb_close cb_close
dw_settings dw_settings
end type
global w_activity_report_setup w_activity_report_setup

forward prototypes
public function integer of_run_report ()
end prototypes

public function integer of_run_report ();////Start Code Change ----10.03.2017 #V16 maha
//integer r
//integer rc
//integer d
//integer dc
//integer nr
//integer li_find
//string ls_query
//string ls_table
//string ls_table_sql
//string ls_header
//string ls_sql
//string ls_presentation_str
//string ls_dwsyntax_str
//string ERRORS
//string ls_user
//string ls_from
//string ls_to
//long ll_val
//long ll_total
//
//dw_settings.accepttext()
//dw_settings.setfilter("report_order > 0") 
//dw_settings.filter()
//dw_settings.setsort("report_order ASC") 
//dw_settings.sort()
//
//rc = dw_settings.rowcount()
//
//if rc < 1 then return 0
//
//dw_date_range.accepttext()
//
//ls_from = string(dw_date_range.getitemdate(1, "from_date"), "yyyy-mm-dd")
//ls_to = string(dw_date_range.getitemdate(1, "to_date"), "yyyy-mm-dd")
//
//if isnull(ls_from) then
//	ls_from = "'2000-01-01 00:00:00'"
//else
//	ls_from+= " 00:00:00"
//end if
//
//if isnull(ls_to) then
//	ls_to = "'2099-12-31  23:59:59"
//else
//	ls_to+= " 23:59:59"
//end if
//
////mssagebox(ls_from, ls_to)
//
//ls_table = string(time(now()))
//ls_table = "activity" + ls_table
//ls_table = of_strip_char(":" , ls_table, "") 
//
////create the data table
//ls_table_sql = "Create table " + ls_table + " ( user_id varchar(50) null, "
//debugbreak()
//for r = 1 to rc
//	if dw_settings.getitemnumber(r, "selected") = 1 then
//		ls_header = dw_settings.getitemstring(r, "section_name")
//		ls_header = of_strip_char(" " , ls_header, "_") 
//		ls_table_sql = ls_table_sql + ls_header + " float null,"
//	end if
//next
//
//ls_table_sql = mid(ls_table_sql, 1, len(ls_table_sql) - 1) + ");"
////openwithparm(w_sql_msg, ls_table_sql)
//execute immediate :ls_table_sql using sqlca;
//
////create dynamic dw for results
//ls_sql = "Select * from " + ls_table
//
//ls_presentation_str = "style(type=grid)" 
//ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
//IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
//	if PosA(ERRORS,"Table or view not found",1) > 0 then
//		messagebox ("syntax error","Table in query not found." )
//		return -1
//	else
//		MessageBox("Caution", &
//		"SyntaxFromSQL caused these errors: " + ERRORS)
//		RETURN 1
//	end if
//END IF
//
//dw_results.Create( ls_dwsyntax_str, ERRORS)
//dw_results.SetTransObject( SQLCA )
//
//
////get each activity data
//for r = 1 to rc
//	if dw_settings.getitemnumber(r, "selected") = 0 then continue
//	
//	ls_query = dw_settings.getitemstring(r, "report_query")
//	ls_query = of_strip_char("@Fromdate@" , ls_query, "'" + ls_from + "'") 
//	ls_query = of_strip_char("@Todate@" , ls_query, "'" + ls_to + "'") 
//	ls_query = of_strip_char("@" , ls_query, "'")
//
//	ls_presentation_str = "style(type=grid)" 
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_query, ls_presentation_str, ERRORS)
//	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
//		if PosA(ERRORS,"Table or view not found",1) > 0 then
//			messagebox ("syntax error","Table in query not found." )
//			return -1
//		else
//			openwithparm(w_sql_msg, ls_query)
////			MessageBox("Caution", &
////			"SyntaxFromSQL caused these errors: " + ERRORS)
////			RETURN 1
//		end if
//	END IF
//	
//	
//	dw_query.Create( ls_dwsyntax_str, ERRORS)
//	dw_query.SetTransObject( SQLCA )
//	dc = dw_query.retrieve()
//	
//	for d = 1 to dc
//		ls_user = dw_query.getitemstring(d, 2)
//		ll_val = dw_query.getitemnumber(d, 1)
//		
//		li_find = dw_results.find("user_id = '" + ls_user + "'", 1, dw_results.rowcount()) 
//		
//		if li_find = 0  then
//			nr = dw_results.insertrow(0)
//		elseif li_find > 0 then
//			nr = li_find
//		else //error
//			continue
//		end if
//		
//		dw_results.setitem(nr, "user_id", ls_user)
//		dw_results.setitem(nr, r + 1, ll_val)	
//	next	
//next
//
////resort by user
//dw_results.setsort("user_id ASC") 
//dw_results.sort()
//
////total the values
//nr = dw_results.insertrow(0)
//dw_results.setitem(nr, 1, 'TOTALS')
//
//rc = integer(dw_results.Object.DataWindow.Column.Count)
//
//for r = 2 to rc
//	ll_total = 0
//	for d = 1 to  dw_results.rowcount()
//		ll_val = dw_results.getitemnumber(d,r)
//		if isnull(ll_val) then ll_val = 0
//		ll_total+= ll_val
//	next
//	
//	dw_results.setitem(nr, r, ll_total)
//next
//	
//
//ls_table_sql = "Drop table " + ls_table + ";"
//execute immediate :ls_table_sql using sqlca;
//
//dw_settings.setfilter("") 
//dw_settings.filter()
//
//
return  1
end function

on w_activity_report_setup.create
int iCurrent
call super::create
this.cb_about=create cb_about
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_settings=create dw_settings
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_about
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_settings
end on

on w_activity_report_setup.destroy
call super::destroy
destroy(this.cb_about)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_settings)
end on

event resize;call super::resize;//long w
//long h
//
//h = this.workspaceheight( )
//w = this.workspacewidth( )
//
//h = h/3
//dw_settings.height = h - 20
//dw_results.y = dw_settings.y + dw_settings.height + 20
//dw_results.height = h*2 - 20
//dw_results.width = w -20


end event

type cb_about from commandbutton within w_activity_report_setup
integer x = 2290
integer y = 20
integer width = 549
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About this Window"
end type

event clicked;string s

s = "Activity reports will report program activity counts by user. ~r~r"
s+= "This screen is for defining which report options appear in the Activity Report Window~r"
s+= "- To hide a report from the list, set the sort order to 0.~r"
s+= "- Report labels can be changed as well as the order the report data will appear on the Report results."

messagebox("About Activity report settings", s)
end event

type cb_save from commandbutton within w_activity_report_setup
integer x = 2857
integer y = 20
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

type cb_close from commandbutton within w_activity_report_setup
integer x = 3273
integer y = 20
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

type dw_settings from u_dw within w_activity_report_setup
integer y = 148
integer width = 3694
integer height = 1204
integer taborder = 10
string dataobject = "d_activity_report_setup"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
this.retrieve()
end event

