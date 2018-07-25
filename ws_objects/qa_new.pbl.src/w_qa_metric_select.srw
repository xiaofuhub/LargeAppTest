$PBExportHeader$w_qa_metric_select.srw
forward
global type w_qa_metric_select from window
end type
type dw_date from datawindow within w_qa_metric_select
end type
type cb_sort from commandbutton within w_qa_metric_select
end type
type cb_3 from commandbutton within w_qa_metric_select
end type
type cb_2 from commandbutton within w_qa_metric_select
end type
type cb_1 from commandbutton within w_qa_metric_select
end type
type dw_1 from datawindow within w_qa_metric_select
end type
end forward

global type w_qa_metric_select from window
integer width = 3141
integer height = 2044
boolean titlebar = true
string title = "Select Indicator Metrics"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_date dw_date
cb_sort cb_sort
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_qa_metric_select w_qa_metric_select

type variables
string is_open_from //add Michael 12.15.2011 V12.1 CME-peer-meeting data migration to QA
end variables

on w_qa_metric_select.create
this.dw_date=create dw_date
this.cb_sort=create cb_sort
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.dw_date,&
this.cb_sort,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_qa_metric_select.destroy
destroy(this.dw_date)
destroy(this.cb_sort)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve()

if message.stringparm = "QAPRAC" then
	dw_date.visible = true
	dw_date.insertrow(1)
else
	dw_date.visible = true
end if


//------------------- APPEON BEGIN -------------------
//$<add> Michael 12.15.2011
//$<reason>V12.1 CME-peer-meeting data migration to QA 
is_open_from = message.stringparm
if is_open_from = 'import CME data' then
	cb_3.visible = false
	dw_1.setfilter( "ind_type <> 'MEETING'")
	dw_1.filter()
end if
if is_open_from = 'import meetings data' then
	cb_3.visible = false 
	dw_1.setfilter( "ind_type <> 'CME'")
	dw_1.filter()
end if
//------------------- APPEON END ---------------------
end event

type dw_date from datawindow within w_qa_metric_select
boolean visible = false
integer x = 439
integer y = 28
integer width = 1522
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_date_range_get"
boolean border = false
boolean livescroll = true
end type

type cb_sort from commandbutton within w_qa_metric_select
integer x = 2117
integer y = 28
integer width = 297
integer height = 84
integer taborder = 10
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

dw_1.SetSort(null_str)

dw_1.Sort( )
end event

type cb_3 from commandbutton within w_qa_metric_select
integer x = 50
integer y = 24
integer width = 297
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;long i
long ic

ic = dw_1.rowcount()

if this.text = "Select All" then
	for i = 1 to ic
		dw_1.setitem(i,"selected",1)
	next
	this.text = "Deselect All"
else
	for i = 1 to ic
		dw_1.setitem(i,"selected",0)
	next
	this.text = "Select All"
end if
end event

type cb_2 from commandbutton within w_qa_metric_select
integer x = 2464
integer y = 28
integer width = 306
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;//Start Code Change ----12.18.2009 #V10 maha
long i
long ic
long r
long ll_id[]
integer res
integer li_data_type[] //add Michael 12.15.2011 V12.1 CME-peer-meeting data migration to QA
string ls_cat[]
string ls_ind[]
gs_pass_ids lst_array

ic = dw_1.rowcount()
for i = 1 to ic
	if dw_1.getitemnumber(i,"selected") = 1 then
		r++
		ll_id[r] = dw_1.getitemnumber(i,"qam_id") 
		ls_cat[r] =  dw_1.getitemstring(i,"category") 
		ls_ind[r] =  dw_1.getitemstring(i,"indicator") 
		li_data_type[r] = dw_1.getitemnumber(i,"data_type") //add Michael 12.15.2011  V12.1 CME-peer-meeting data migration to QA
	end if
next


//------------------- APPEON BEGIN -------------------
//$<add> Michael 12.16.2011
//$<reason>V12.1 CME-peer-meeting data migration to QA 
if is_open_from = 'import CME data'  or is_open_from = 'import meetings data' then
	if  r > 1 then
		messagebox("Select Metric item","Only one Metric item can be selected.")
		return
	end if 
end if
//------------------- APPEON END ---------------------

if r = 0 then
	res = messagebox("No Items selected","You have not selected any Metric items.  Do you wish to cancel the Add?", question!,yesno!,2)
	if res = 1 then
		closewithreturn(parent,"Cancel")
	else
		return
	end if
else
	lst_array.l_ids = ll_id[]
	lst_array.i_ids = li_data_type[]//add Michael 12.15.2011 V12.1 CME-peer-meeting data migration to QA
	lst_array.s_action_type = ls_cat[]
	lst_array.s_doc_ids = ls_ind[]
	closewithreturn(parent,lst_array)
end if




end event

type cb_1 from commandbutton within w_qa_metric_select
integer x = 2784
integer y = 28
integer width = 306
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type dw_1 from datawindow within w_qa_metric_select
integer x = 37
integer y = 140
integer width = 3063
integer height = 1732
integer taborder = 10
string title = "none"
string dataobject = "d_qa_metrics_select"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

