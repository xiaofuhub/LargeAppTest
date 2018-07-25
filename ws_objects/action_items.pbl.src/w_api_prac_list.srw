$PBExportHeader$w_api_prac_list.srw
forward
global type w_api_prac_list from w_response
end type
type cb_stop_m from commandbutton within w_api_prac_list
end type
type cb_add_m from commandbutton within w_api_prac_list
end type
type cb_delete from commandbutton within w_api_prac_list
end type
type rb_ama from radiobutton within w_api_prac_list
end type
type cb_2 from commandbutton within w_api_prac_list
end type
type cb_add from commandbutton within w_api_prac_list
end type
type st_1 from statictext within w_api_prac_list
end type
type ddlb_type from dropdownlistbox within w_api_prac_list
end type
type cb_output from uo_cb_output within w_api_prac_list
end type
type cb_1 from commandbutton within w_api_prac_list
end type
type dw_dates from u_dw within w_api_prac_list
end type
type cb_close from commandbutton within w_api_prac_list
end type
type dw_1 from u_dw within w_api_prac_list
end type
type gb_1 from groupbox within w_api_prac_list
end type
type gb_2 from groupbox within w_api_prac_list
end type
end forward

global type w_api_prac_list from w_response
integer width = 3767
integer height = 2064
string title = "Reports Log"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_stop_m cb_stop_m
cb_add_m cb_add_m
cb_delete cb_delete
rb_ama rb_ama
cb_2 cb_2
cb_add cb_add
st_1 st_1
ddlb_type ddlb_type
cb_output cb_output
cb_1 cb_1
dw_dates dw_dates
cb_close cb_close
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_api_prac_list w_api_prac_list

forward prototypes
public function string of_get_name (long al_row)
public function integer of_save ()
public function long of_get_id ()
public function integer of_create_records (long al_prac[], string as_name[])
end prototypes

public function string of_get_name (long al_row);string ls_type
string ls_name = ""
long ll_id

ls_type = dw_1.getitemstring(al_row, "rpt_type")
ll_id = dw_1.getitemnumber(al_row, "report_id")

choose case ls_type
	case "S"
		select report_name into :ls_name from sys_reports where report_id = :ll_id;
	case "C"
		select view_name into :ls_name from conv_view where view_id = :ll_id;
	case "E"
		select export_name into :ls_name from export_header where export_id = :ll_id;
	case "1"
		select report_name into :ls_name from sys_one_click where rpt_id = :ll_id;
	case "Q"
		select sched_name into :ls_name from schedule_hrd where sched_id = :ll_id;
end choose


return ls_name
end function

public function integer of_save ();long rc
long r
long c
long ll_id


for r = 1 to dw_1.rowcount( )
	if isnull(dw_1.getitemnumber(r, "pal_id")) then
		c++
	end if
next

if c > 0 then
	select max(pal_id) into :ll_id from pd_api_list;
	
	for r = 1 to dw_1.rowcount( )
		if isnull(dw_1.getitemnumber(r, "pal_id")) then
			ll_id++
			dw_1.setitem(r, "pal_id", ll_id)
		end if
	next
	
	dw_1.update()
end if

return 1
end function

public function long of_get_id ();long ll_id

select max(pal_id) into :ll_id from pd_api_list;

if isnull(ll_id) then ll_id = 0

return ll_id
end function

public function integer of_create_records (long al_prac[], string as_name[]);//Start Code Change ----06.08.2016 #V152 maha
long ic
long li_find
long i
long li_prac_id
long ll_id
long li_nr
string ls_full_name

ic = upperbound(al_prac[])

ll_id = of_get_id()

for i = 1 to ic
	li_prac_id = al_prac[i] //maha 091605
	ls_full_name = as_name[i]
	if ls_full_name = "" then
		select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;
	end if
	//ls_full_name = ist_search.ls_name[i] //maha 091605

	li_find = dw_1.Find( "prac_id = " + String( li_prac_id ), 1, 100000 )
	
	IF li_find > 0 THEN
		continue
	END IF
	
	li_nr = dw_1.InsertRow( 0 )
	
	ll_id++ 
	dw_1.SetItem( li_nr, "pal_id", ll_id )
	
	dw_1.SetItem( li_nr, "prac_id", li_prac_id )
	dw_1.SetItem( li_nr, "full_name", ls_full_name)
	if rb_ama.checked then 
		dw_1.SetItem( li_nr, "list_type", "AMA" )
		dw_1.SetItem( li_nr, "monitor_status", 0)
	end if

next

dw_1.update()
dw_1.sort()

return 1
end function

on w_api_prac_list.create
int iCurrent
call super::create
this.cb_stop_m=create cb_stop_m
this.cb_add_m=create cb_add_m
this.cb_delete=create cb_delete
this.rb_ama=create rb_ama
this.cb_2=create cb_2
this.cb_add=create cb_add
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.cb_output=create cb_output
this.cb_1=create cb_1
this.dw_dates=create dw_dates
this.cb_close=create cb_close
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_stop_m
this.Control[iCurrent+2]=this.cb_add_m
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.rb_ama
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_add
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.ddlb_type
this.Control[iCurrent+9]=this.cb_output
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_dates
this.Control[iCurrent+12]=this.cb_close
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.gb_2
end on

on w_api_prac_list.destroy
call super::destroy
destroy(this.cb_stop_m)
destroy(this.cb_add_m)
destroy(this.cb_delete)
destroy(this.rb_ama)
destroy(this.cb_2)
destroy(this.cb_add)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.cb_output)
destroy(this.cb_1)
destroy(this.dw_dates)
destroy(this.cb_close)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_stop_m from commandbutton within w_api_prac_list
integer x = 1842
integer y = 36
integer width = 448
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Stop Monitoring"
end type

type cb_add_m from commandbutton within w_api_prac_list
integer x = 1390
integer y = 36
integer width = 434
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Monitoring"
end type

type cb_delete from commandbutton within w_api_prac_list
integer x = 955
integer y = 36
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res

if dw_1.getrow() < 1 then return

res = messagebox("Delete Provider","Are you sure you wish to delete the provider from this list?", question!, yesno!, 2)

if res = 1 then
	dw_1.deleterow(0)
	dw_1.update()
end if
end event

type rb_ama from radiobutton within w_api_prac_list
integer x = 2871
integer y = 60
integer width = 219
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "AMA"
boolean checked = true
end type

type cb_2 from commandbutton within w_api_prac_list
integer x = 485
integer y = 36
integer width = 453
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Batch Add"
end type

event clicked;//Start Code Change ----06.07.2016 #V152 maha - copied from meetings
openwithparm(w_batch_prac_select_new,"R")

if message.stringparm = "Cancel" then 
	return
else
	long i
	long ic
	long li_prac_id
	long li_find
	long li_nr
	long ll_id
	string ls_full_name[]
	gs_batch_search ist_search
	
	if not isvalid(message.powerobjectparm) then return 0
	ist_search = message.powerobjectparm
	
	ic = upperbound(ist_search.li_prac_id[])
	
	for i = 1 to ic
		ls_full_name[i] = ""
	next
	
	of_create_records(ist_search.li_prac_id[],  ls_full_name[])

end if

end event

type cb_add from commandbutton within w_api_prac_list
integer x = 9
integer y = 36
integer width = 453
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Providers"
end type

event clicked;//Start Code Change ----06.07.2016 #V152 maha - copied from meetings
Integer li_nr
Integer li_find
long li_prac_id
String ls_full_name[]
integer i
integer ic
long ll_id
gs_batch_search ist_search

gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS0" 

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm

if not isvalid(message.powerobjectparm) then return 0


ic = upperbound(ist_search.li_prac_id[])

for i = 1 to ic
	ls_full_name[i] = ""
next

of_create_records(ist_search.li_prac_id[],  ls_full_name[])

end event

type st_1 from statictext within w_api_prac_list
integer x = 4009
integer y = 332
integer width = 160
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Type:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_api_prac_list
integer x = 3986
integer y = 216
integer width = 567
integer height = 580
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Std. Reports","IntelliReports","Exports","One Click","Scheduler Reports","All"}
end type

type cb_output from uo_cb_output within w_api_prac_list
integer x = 3954
integer y = 96
integer width = 416
integer height = 84
integer taborder = 20
end type

event clicked;

m_npdb_options NewMenu 
NewMenu = CREATE m_npdb_options
NewMenu.of_setparent(idw)
NewMenu.m_options.m_mailall.visible = false
NewMenu.m_options.m_printall.visible = false
NewMenu.m_options.m_printcurrent.text = 'Print'
NewMenu.m_options.m_mailcurrent.text = 'EMail'
//NewMenu.m_options.PopMenu(w_mdi.pointerx(),w_mdi.pointerY())
//NewMenu.m_options.PopMenu(this.x + parent.x, this.y + parent.y + 90) //alfee 11.17.2010//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
gnv_app.of_popmenu(this,NewMenu.m_options)//(Appeon)Toney 11.22.2013 - V141 ISG-CLX,Fix history BugT072501
//this calls events in u_dw
//the save as pdf calls ...
end event

event constructor;call super::constructor;idw = dw_1
end event

type cb_1 from commandbutton within w_api_prac_list
integer x = 4366
integer y = 520
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run Filter"
end type

event clicked;string ls_from
string ls_to
string ls_where
integer li_final
string ls_field
string ls_sql
string ls_org
string ls_type
string ls_type_data = "All"


dw_dates.accepttext()
ls_from = string(dw_dates.getitemdate(1,"from_date"),"yyyy-mm-dd")
//messagebox("ls_from", ls_from)
ls_to = string(dw_dates.getitemdate(1,"to_date"),"yyyy-mm-dd")
//messagebox("ls_to", ls_to)

if  len(ls_from) > 0 then
	ls_where = " and ( date_run >= '" + ls_from + " 00:00:00')"
end if

if  len(ls_to) > 0 then
	ls_where+= " and (date_run <= '" + ls_to + " 23:59:59')"
end if

ls_type = ddlb_type.text

choose case ls_type
	case "All"
		ls_type_data = "All"
	case "Exports"
		ls_type_data = "E"
	case "Std. Reports"
		ls_type_data = "S"
	case "IntelliReports"
		ls_type_data = "C"
	case "One Click"
		ls_type_data = "1"
	case "Scheduler Reports"
		ls_type_data = "Q"	
end choose

if ls_type_data <> "All" then
	ls_where+= " and (rpt_type = '" + ls_type_data + "')"
end if
	
if len(ls_where) > 0 then
	ls_sql = dw_1.getsqlselect()
	ls_org = ls_sql
	ls_sql+= ls_where
	//messagebox("",ls_sql)
	dw_1.setsqlselect(ls_sql)
	dw_1.settransobject(sqlca)
	dw_1.retrieve() 
	dw_1.setsqlselect(ls_org)
else
	dw_1.retrieve()
end if
end event

type dw_dates from u_dw within w_api_prac_list
integer x = 3890
integer y = 644
integer width = 1271
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_date_range_gets"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event clicked;string ls_coltype
//debugbreak()
//If isvalid(iuo_Calendar) Then
//	ls_coltype = this.Describe(dwo.name+".ColType")	
//	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
//		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
//	End If
//End If

//iuo_Calendar.of_Register("from_date", iuo_Calendar.DDLB_WITHARROW)
//iuo_Calendar.of_Register("to_date", iuo_Calendar.DDLB_WITHARROW)
end event

event constructor;call super::constructor;This.of_SetUpdateAble( False )
This.of_SetTransObject( SQLCA )
This.InsertRow( 0 )

This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

type cb_close from commandbutton within w_api_prac_list
integer x = 3383
integer y = 36
integer width = 347
integer height = 92
integer taborder = 10
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

type dw_1 from u_dw within w_api_prac_list
integer x = 9
integer y = 160
integer width = 3735
integer height = 1812
integer taborder = 10
string dataobject = "d_pd_api_list_de"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
this.of_setupdateable( false)
end event

type gb_1 from groupbox within w_api_prac_list
integer x = 3941
integer y = 412
integer width = 1797
integer height = 168
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_api_prac_list
integer x = 2798
integer width = 338
integer height = 144
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "List Type"
end type

