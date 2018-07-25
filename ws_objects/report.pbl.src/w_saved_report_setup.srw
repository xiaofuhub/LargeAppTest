$PBExportHeader$w_saved_report_setup.srw
forward
global type w_saved_report_setup from w_popup
end type
type cb_access from commandbutton within w_saved_report_setup
end type
type cb_add from commandbutton within w_saved_report_setup
end type
type cb_delete from commandbutton within w_saved_report_setup
end type
type cb_save from commandbutton within w_saved_report_setup
end type
type cb_close from commandbutton within w_saved_report_setup
end type
type dw_detail from u_dw within w_saved_report_setup
end type
type dw_browse from u_dw within w_saved_report_setup
end type
end forward

global type w_saved_report_setup from w_popup
integer width = 3154
integer height = 2256
string title = "Saved Report Setup"
boolean maxbox = false
long backcolor = 33551856
boolean center = true
cb_access cb_access
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_saved_report_setup w_saved_report_setup

type variables
boolean ib_new =false
end variables

on w_saved_report_setup.create
int iCurrent
call super::create
this.cb_access=create cb_access
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_access
this.Control[iCurrent+2]=this.cb_add
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_detail
this.Control[iCurrent+7]=this.dw_browse
end on

on w_saved_report_setup.destroy
call super::destroy
destroy(this.cb_access)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.x = 0
This.y = 0
dw_detail.retrieve(gs_user_id)
dw_detail.sharedata(dw_browse)
if dw_detail.rowcount() < 1 then cb_add.event clicked()
end event

type cb_access from commandbutton within w_saved_report_setup
integer x = 5
integer y = 28
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&User Access"
end type

event clicked;open(w_saved_report_user_access)
end event

type cb_add from commandbutton within w_saved_report_setup
integer x = 1865
integer y = 28
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row

cb_save.triggerevent(clicked!)
if ib_new = true then return
li_row = dw_detail.insertrow(0)
ib_new = true
dw_detail.scrolltorow(li_row)
dw_detail.setrow(li_row)
dw_browse.scrolltorow(li_row)
dw_browse.setrow(li_row)


end event

type cb_delete from commandbutton within w_saved_report_setup
integer x = 2281
integer y = 28
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
integer li_row
integer li_ret
long     ll_srs_id
dwitemstatus ldws_status

li_row = dw_detail.getrow()
if li_row < 1 then return

ldws_status = dw_detail.getitemstatus(li_row, 0, primary!)
if ldws_status = new! or ldws_status = newmodified! then
	dw_detail.deleterow(li_row)
	return
end if

ll_srs_id = dw_detail.getitemnumber(li_row, "srs_id")
li_ret = MessageBox("Delete Data", "Do you want to delete the current data?", Question!, YesNo!, 2)
if li_ret <> 1 then return
dw_detail.deleterow(li_row)
gnv_appeondb.of_startqueue( )
delete from sys_report_storage_files where srs_id = :ll_srs_id;
delete from security_user_saved_reports  where srs_id = :ll_srs_id;
update schedule_hrd  set report_storage_id =null where report_storage_id = :ll_srs_id;
dw_detail.update()
gnv_appeondb.of_commitqueue( )	
commit using sqlca;

if dw_detail.rowcount() < 1 then cb_add.event clicked()
end event

type cb_save from commandbutton within w_saved_report_setup
integer x = 1454
integer y = 28
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_srs_id
long ll_report_id
integer li_row
string ls_rpt_type
string   ls_rpt_name
string   ls_rpt_note
dwitemstatus ldws_1

dw_detail.accepttext()
li_row = dw_detail.getrow()
if li_row < 1 then return -1
if dw_detail.modifiedcount() > 0 then
	ls_rpt_type = dw_detail.getitemstring(li_row, "report_type")
	ll_report_id = dw_detail.getitemnumber(li_row, "report_id")
	ls_rpt_name = dw_detail.getitemstring(li_row, "report_name")
	ls_rpt_note = dw_detail.getitemstring(li_row, "report_note")
	if isnull(ls_rpt_type) or ls_rpt_type = '' then
		messagebox("Required Data Missing", "You must first select a Report Type.")
		return
	end if
	if isnull(ll_report_id) or ll_report_id = 0 then
		messagebox("Required Data Missing", "You must first select a Report.")
		return
	end if
	if isnull(ls_rpt_name) or ls_rpt_name = '' then
		messagebox("Required Data Missing", "You must fill in the Report Name.")
		return
	end if
	if isnull(ls_rpt_note) or ls_rpt_note = '' then
		messagebox("Required Data Missing", "You must fill in the Note.")
		return
	end if
	
	ldws_1 = dw_detail.getitemstatus(li_row, 0,primary!)
	if ldws_1 = newmodified! or ldws_1 = new! then
		dw_detail.setitem(li_row, "create_by", gs_user_id)
		dw_detail.setitem(li_row, "create_date", datetime(today(),now()))
		select max(srs_id) into :ll_srs_id from sys_report_storage ;
		if isnull(ll_srs_id) then ll_srs_id = 0
		ll_srs_id +=1
		dw_detail.setitem(li_row, "srs_id", ll_srs_id)
	else
		dw_detail.setitem(li_row, "mod_by", gs_user_id)
		dw_detail.setitem(li_row, "mod_date", datetime(today(),now()))
	end if	
	
	if dw_detail.update() = 1 then
		gnv_appeondb.of_StartQueue()
		if ls_rpt_type = 'Q' then
			update schedule_hrd set report_storage_id = :ll_srs_id where sched_id = :ll_report_id;
		end if
		insert into security_user_saved_reports (user_id,srs_id,access_rights) values(:gs_user_id, :ll_srs_id, 1 );
		gnv_appeondb.of_CommitQueue()
		commit using sqlca;
		ib_new = false
	else
		rollback using sqlca;
	end if
end if

end event

type cb_close from commandbutton within w_saved_report_setup
integer x = 2688
integer y = 28
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type dw_detail from u_dw within w_saved_report_setup
integer x = 5
integer y = 1628
integer width = 3090
integer height = 504
integer taborder = 10
string dataobject = "d_reports_saved_detail"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked;//====================================================================
//$<Event>: buttonclicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.21.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string   ls_rpt_type
str_b    lstr_rpt

if row < 1 then return
if dwo.name = 'b_1' then
	ls_rpt_type = dw_detail.getitemstring(row, "report_type")
	if isnull(ls_rpt_type) or ls_rpt_type = '' then
		messagebox("Required Data Missing", "You must first select a Report Type.")
		return
	end if		
	openwithparm(w_rpt_storage_select, ls_rpt_type)
	lstr_rpt = message.powerobjectparm
	if lstr_rpt.i_count = 0 then return
	dw_detail.setitem(row, 'report_id', lstr_rpt.i_count)
	dw_detail.setitem(row, 'report_name', lstr_rpt.s_type)
end if

end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.18.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_id

if row < 1 then return
setnull(ll_id)
choose case dwo.name
	case "report_type"
		this.setitem(row, "report_id", ll_id)
		this.setitem(row, "report_name", "")
end choose

end event

type dw_browse from u_dw within w_saved_report_setup
integer y = 132
integer width = 3095
integer height = 1476
integer taborder = 10
string dataobject = "d_reports_saved_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
end event

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
//$<Event>: rowfocuschanged
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.18.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if currentrow < 1 then return

this.scrolltorow(currentrow)
this.selectrow(0, false)
this.selectrow(currentrow, true)
this.setrow(currentrow)
dw_detail.scrolltorow(currentrow)
dw_detail.setrow(currentrow)
end event

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.18.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if row < 1 then return 
event rowfocuschanged(row)


end event

