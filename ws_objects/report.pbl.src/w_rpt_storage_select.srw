$PBExportHeader$w_rpt_storage_select.srw
forward
global type w_rpt_storage_select from window
end type
type st_2 from statictext within w_rpt_storage_select
end type
type sle_1 from singlelineedit within w_rpt_storage_select
end type
type st_1 from statictext within w_rpt_storage_select
end type
type dw_1 from datawindow within w_rpt_storage_select
end type
type cb_cancel from commandbutton within w_rpt_storage_select
end type
type cb_1 from commandbutton within w_rpt_storage_select
end type
end forward

global type w_rpt_storage_select from window
integer width = 2327
integer height = 1260
boolean titlebar = true
string title = "Select Report"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
sle_1 sle_1
st_1 st_1
dw_1 dw_1
cb_cancel cb_cancel
cb_1 cb_1
end type
global w_rpt_storage_select w_rpt_storage_select

type variables
str_b istr_ret
end variables

forward prototypes
public function string of_syntax_5 (string as_val)
public function string of_syntax_lu (string as_val, string as_screen)
public function integer of_create_dw (string as_sql)
public function string of_syntax_20 (string as_val)
public function string of_syntax_not_addr (string as_screen, string as_val)
end prototypes

public function string of_syntax_5 (string as_val);//====================================================================
//$<Function>: of_syntax_5
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  string
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.24.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_sql

ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = 5 ) AND   ( wc_hdr.wc_screen_field_link_fixed_value = '" + as_val + "' or wc_hdr.wc_screen_field_link_fixed_value='' or wc_hdr.wc_screen_field_link_fixed_value=null);"


return ls_sql
end function

public function string of_syntax_lu (string as_val, string as_screen);string ls_sql


ls_sql = "SELECT DISTINCT wc_hdr.wc_id, wc_description FROM wc_hdr,    wc_multi_entity_link,    address_lookup	WHERE ( wc_hdr.wc_id = wc_multi_entity_link.wc_id ) and  ( wc_multi_entity_link.wc_lookup_code = address_lookup.lookup_code ) and  ( ( wc_hdr.wc_screen_id_link = '" + as_screen +  "' ) AND  ( address_lookup.lookup_code = '"  + as_val +  "') ) ;"


return ls_sql
end function

public function integer of_create_dw (string as_sql);string ls_sql	
string ls_presentation_str
string ERRORS
string ls_dwsyntax_str
integer w
//messagebox("is_sql",is_sql)

ls_sql = as_sql
dw_1.settransobject(sqlca)
ls_presentation_str = "style(type=grid)"		
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN
	MessageBox("Caution on export field " + ls_sql, 	"SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
//	MessageBox("ls_select_table",ls_select_table)
	
	RETURN -1
END IF

w = dw_1.Create( ls_dwsyntax_str, ERRORS)
if w < 1 then
	messagebox("Error on create of duplicate Crawler list",errors)
end if

dw_1.settransobject(sqlca)
dw_1.retrieve()
//---------Begin Added by (Appeon)Stephen 07.27.2017 for BugL071902--------
for w = 1 to long(dw_1.describe("datawindow.column.count"))
	dw_1.modify("#"+string(w)+".tabsequence='0'")
next
//---------End Added ------------------------------------------------------

return 1
end function

public function string of_syntax_20 (string as_val);string ls_sql

ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = 20 );"


return ls_sql
end function

public function string of_syntax_not_addr (string as_screen, string as_val);//Start Code Change ----01.02.2008 #V8 maha // added for other ids or other screens that don't use address lookups

string ls_sql

ls_sql = "SELECT wc_id,  wc_description FROM wc_hdr   WHERE ( wc_hdr.wc_screen_id_link = " + as_screen + " ) AND   ( wc_hdr.wc_screen_field_link_fixed_value = '" + as_val + "');"


return ls_sql
end function

on w_rpt_storage_select.create
this.st_2=create st_2
this.sle_1=create sle_1
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_cancel=create cb_cancel
this.cb_1=create cb_1
this.Control[]={this.st_2,&
this.sle_1,&
this.st_1,&
this.dw_1,&
this.cb_cancel,&
this.cb_1}
end on

on w_rpt_storage_select.destroy
destroy(this.st_2)
destroy(this.sle_1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_cancel)
destroy(this.cb_1)
end on

event open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.24.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_mes
string ls_sql
string ls_message
string ls_entity
string ls_ret
string ls_type
integer li_pos

ls_message = message.stringparm
li_pos = pos(ls_message, ":")
if li_pos < 1 then
	ls_mes = ls_message
	st_2.visible  = false
	sle_1.visible= false
else
	ls_mes = left(ls_message, li_pos - 1)
	ls_ret = mid(ls_message, li_pos + 1)
	st_2.visible  = true
	sle_1.visible= true
end if
choose case ls_mes
	case "E" //Export
		this.title = this.title + " for: " + 'Export'
		//---------Begin Modified by (Appeon)Stephen 07.27.2017 for BugL071901--------
		//ls_sql = "SELECT export_id as rpt_id,export_name as rpt_name,export_type FROM export_header "
		ls_sql = "SELECT export_id as rpt_id,export_name as rpt_name,(case export_type when '1' then 'Data (obsolete)' when '2' then 'Provider Data' when '3' then 'CTX Agreement Export' when '4' then 'CTX Export' when '5' then 'Provider Data w/ CTX' when '6' then 'CTX with Provider' end )as export_type FROM export_header "
		//---------End Modfiied ------------------------------------------------------
		st_1.text = "Please Select the Export you wish to use."
	case "C" //iReport
		this.title = this.title + " for: iReport" 
		//---------Begin Modified by (Appeon)Stephen 07.27.2017 for BugL071901--------
		//ls_sql = "select view_id as rpt_id,view_name as rpt_name,module from conv_view where ( substring(conv_view.view_name,1,3) <> 'cd_' ) AND ( substring(conv_view.view_name,1,3) <> 'ex_' )  AND view_id not in(select view_id from conv_view_fields where filter_by_field=1) "
		ls_sql = "select view_id as rpt_id,view_name as rpt_name,(case module when '1' then 'IntelliContract' when '2' then 'IntelliCred/App' when '4' then 'Cred/App/Cont' end) as module from conv_view where ( substring(conv_view.view_name,1,3) <> 'cd_' ) AND ( substring(conv_view.view_name,1,3) <> 'ex_' )  AND view_id not in(select view_id from conv_view_fields where filter_by_field=1) "
		//---------End Modfiied ------------------------------------------------------
		st_1.text = "Please Select the iReport you wish to use."
	case "S" //Standard
		this.title = this.title + " for: Standard"
		ls_sql = 'SELECT report_id as rpt_id,report_name as rpt_name,report_description, category FROM sys_reports order by category, report_name '
		st_1.text = "Please Select the Standard Report you wish to use."
	case "1"  //One-Click
		this.title = this.title + " for: One-Click"
		ls_sql = 'SELECT rpt_id,report_name as rpt_name, category, save_format FROM sys_one_click '
		st_1.text = "Please Select the One-Click you wish to use."
	case "Q" //Sched Report
		this.title = this.title + " for: Sched Report"
		ls_sql = 'SELECT sched_id as rpt_id, sched_name as rpt_name, next_start,last_run,file_path,report_format FROM schedule_hrd where sched_type = 60 and  active_status = 1 '
		st_1.text = "Please Select the Scheduled Report you wish to use."
	case "R-E" //Storage Export
		this.title = this.title + " for: " + 'Export'
		ls_type = 'E'
		st_1.text = "Please Select the Report Storage  you wish to use."
	case "R-C" //Storage iReport
		this.title = this.title + " for: " + 'iReport'
		ls_type = 'C'
		st_1.text = "Please Select the Report Storage you wish to use."
	case "R-S" //Storage Standard
		this.title = this.title + " for: " + 'Standard'
		ls_type = 'S'
		st_1.text = "Please Select the Report Storage you wish to use."
	case "R-1" //Storage One-Click
		this.title = this.title + " for: " + 'One-Click'
		ls_type = '1'
		st_1.text = "Please Select the Report Storage you wish to use."
	case "R-Q" //Storage Sched Report
		this.title = this.title + " for: " + 'Sched Report'
		ls_type = 'Q'
		st_1.text = "Please Select the Report Storage you wish to use."
end choose

istr_ret.i_count = 0
if li_pos < 1 then
	of_create_dw( ls_sql)
else
	dw_1.dataobject = "d_manual_srs_report"
	dw_1.settransobject(sqlca)
	dw_1.retrieve(gs_user_id, long(ls_ret), ls_type)
	if dw_1.rowcount() < 1 then
		istr_ret.i_count = 0
		cb_1.event clicked()
		return
	elseif dw_1.rowcount() = 1 then
		dw_1.selectrow(1, true)
		istr_ret.i_count = dw_1.getitemnumber(1,"rpt_id")
		istr_ret.s_type =  ""
	end if	
end if





end event

type st_2 from statictext within w_rpt_storage_select
integer x = 32
integer y = 972
integer width = 261
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "File Note:"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_rpt_storage_select
integer x = 297
integer y = 956
integer width = 1957
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event modified;//====================================================================
//$<Event>: modified
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.06.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
istr_ret.s_type = this.text
end event

type st_1 from statictext within w_rpt_storage_select
integer x = 23
integer y = 52
integer width = 2245
integer height = 112
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "There are multiple Web Crawlers set up in the system connected to the Entity / Type for the verification.  Select the crawler you wish to use."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_rpt_storage_select
integer x = 46
integer y = 192
integer width = 2208
integer height = 740
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.24.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer r

r = this.getclickedrow()
if r < 1 then return

if dw_1.Describe("rpt_id.ColType") <> "!" then
	istr_ret.i_count = dw_1.getitemnumber(r,"rpt_id")
	istr_ret.s_type =  dw_1.getitemstring(r,"rpt_name")
else
	istr_ret.i_count = 0
end if

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

end event

event doubleclicked;cb_1.triggerevent(clicked!)
end event

type cb_cancel from commandbutton within w_rpt_storage_select
integer x = 1915
integer y = 1060
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 06.06.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
istr_ret.i_count = 0
closewithreturn(parent, istr_ret)
end event

type cb_1 from commandbutton within w_rpt_storage_select
integer x = 1554
integer y = 1060
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.24.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
closewithreturn(parent,istr_ret)
end event

