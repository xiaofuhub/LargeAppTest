$PBExportHeader$w_report_view.srw
forward
global type w_report_view from window
end type
type cb_close from commandbutton within w_report_view
end type
type uo_report from u_tabpage_report_report within w_report_view
end type
end forward

global type w_report_view from window
integer width = 4064
integer height = 2520
boolean titlebar = true
string title = "View Report"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_close cb_close
uo_report uo_report
end type
global w_report_view w_report_view

type variables
string is_sql
end variables

on w_report_view.create
this.cb_close=create cb_close
this.uo_report=create uo_report
this.Control[]={this.cb_close,&
this.uo_report}
end on

on w_report_view.destroy
destroy(this.cb_close)
destroy(this.uo_report)
end on

event open;//Start Code Change ----08.04.2010 #V10 maha - created to give full report functionality to a separate view report window

//EXAMPLE call code
//gs_report_variables lst_arg
//
//lst_arg.as_report_object = "d_rpt_par_numbers_summary_sk"
//lst_arg.ai_num_variables = 1
//lst_arg.as_var_type[1] = "N"
//lst_arg.as_value[1] = string(il_prac_id)
//
//if isvalid(w_report_view) then close(w_report_view)
//openwithparm(w_report_view,lst_arg)

integer vc
integer v
string ls_report
string ls_type
any la_var[]
gs_report_variables lst_val

uo_report.dw_report.height = 2100  //Start Code Change ----10.28.2010 #V10 maha - resize the report window
uo_report.st_rec_cnt.y = 2275   //Start Code Change ----05.24.2011 #V11 maha 
lst_val = message.powerobjectparm

uo_report.dw_report.dataobject =  lst_val.as_report_object
uo_report.dw_report.settransobject(sqlca)

vc =  lst_val.ai_num_variables

//the following allows retrieving different sets of arguments depending on the need of the report

for v = 1 to vc
	ls_type = lst_val.as_var_type[v]
	choose case ls_type
		case "S"
			la_var[v] =  lst_val.as_value[v]
		case "N"
			la_var[v] =  long(lst_val.as_value[v])
		case "DT" 
			la_var[v] =  datetime(lst_val.as_value[v])
		case "D"
			la_var[v] =  date(lst_val.as_value[v])
	end choose
next

choose case vc
	Case 0  //Start Code Change ----08.24.2011 #V11 maha 
		uo_report.dw_report.retrieve()
	Case 1
		uo_report.dw_report.retrieve(la_var[1])
	Case 2
		uo_report.dw_report.retrieve(la_var[1], la_var[2])
	Case 3
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3])
	Case 4
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4])
	Case 5
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5])
	Case 6
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5], la_var[6])
	Case 7
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5], la_var[6], la_var[7])
	Case 8
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5], la_var[6], la_var[7], la_var[8])
	Case 9
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5], la_var[6], la_var[7], la_var[8], la_var[9])
	Case 10
		uo_report.dw_report.retrieve(la_var[1], la_var[2], la_var[3], la_var[4], la_var[5], la_var[6], la_var[7], la_var[8], la_var[9], la_var[10])
end choose
		
is_sql =	uo_report.dw_report.GetSQLSelect()
uo_report.is_syntax = is_sql

if lst_val.as_single = "S" then
	uo_report.cb_prac_filt.visible = false //Start Code Change ----09.09.2011 #V12 maha - hide filter button for some reports
end if

if lst_val.ab_treeview = True then
	uo_report.dw_report.expandall( )
end if





end event

type cb_close from commandbutton within w_report_view
integer x = 3099
integer y = 40
integer width = 430
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close (parent)
end event

type uo_report from u_tabpage_report_report within w_report_view
integer width = 4064
integer height = 2440
integer taborder = 80
end type

on uo_report.destroy
call u_tabpage_report_report::destroy
end on

