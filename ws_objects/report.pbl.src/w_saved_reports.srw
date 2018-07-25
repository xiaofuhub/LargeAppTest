$PBExportHeader$w_saved_reports.srw
forward
global type w_saved_reports from w_popup
end type
type st_count from statictext within w_saved_reports
end type
type cb_save from commandbutton within w_saved_reports
end type
type cb_filter from commandbutton within w_saved_reports
end type
type cb_sort from commandbutton within w_saved_reports
end type
type cb_access from commandbutton within w_saved_reports
end type
type cb_close from commandbutton within w_saved_reports
end type
type dw_browse from u_dw within w_saved_reports
end type
end forward

global type w_saved_reports from w_popup
integer width = 4352
integer height = 1940
string title = "Saved Reports"
long backcolor = 33551856
st_count st_count
cb_save cb_save
cb_filter cb_filter
cb_sort cb_sort
cb_access cb_access
cb_close cb_close
dw_browse dw_browse
end type
global w_saved_reports w_saved_reports

forward prototypes
public function integer of_count ()
end prototypes

public function integer of_count ();//====================================================================
//$<Function>: of_count
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.25.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long l

l = dw_browse.rowcount()
st_count.text = string(l)

return 1
end function

on w_saved_reports.create
int iCurrent
call super::create
this.st_count=create st_count
this.cb_save=create cb_save
this.cb_filter=create cb_filter
this.cb_sort=create cb_sort
this.cb_access=create cb_access
this.cb_close=create cb_close
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_count
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.cb_sort
this.Control[iCurrent+5]=this.cb_access
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_browse
end on

on w_saved_reports.destroy
call super::destroy
destroy(this.st_count)
destroy(this.cb_save)
destroy(this.cb_filter)
destroy(this.cb_sort)
destroy(this.cb_access)
destroy(this.cb_close)
destroy(this.dw_browse)
end on

event open;call super::open;This.x = 0
This.y = 0

dw_browse.retrieve(gs_user_id)
end event

event pfc_preopen;call super::pfc_preopen;this.of_SetResize(TRUE)
this.inv_resize.of_SetOrigSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())
this.inv_resize.of_SetMinSize (this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_register(dw_browse,inv_resize.scalerightbottom)
end event

type st_count from statictext within w_saved_reports
boolean visible = false
integer x = 855
integer y = 32
integer width = 265
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_saved_reports
integer x = 3461
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
string text = "S&ave"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.25.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
dw_browse.accepttext()
if dw_browse.modifiedcount() < 1 then return

if dw_browse.update() = 1 then
	commit using sqlca;
else
	rollback using sqlca;
end if

end event

type cb_filter from commandbutton within w_saved_reports
integer x = 430
integer y = 20
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.25.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string null_str

if dw_browse.DataObject = "" then return

String    ls_exclude[ ]

ls_exclude[1] = "compute_2"
ls_exclude[2] = "compute_1"

dw_browse.inv_filter.of_SetExclude(ls_exclude)
dw_browse.inv_filter.of_SetStyle (dw_browse.inv_filter.EXTENDED)
dw_browse.Event pfc_FilterDlg()
dw_browse.Sort()
dw_browse.groupcalc()

dw_browse.SetFocus()
of_count()

end event

type cb_sort from commandbutton within w_saved_reports
integer x = 18
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
string text = "&Sort"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.25.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if dw_browse.DataObject = "" then return		

dw_browse.inv_sort.of_setstyle(dw_browse.inv_sort.dragdrop  )
dw_browse.Event pfc_SortDlg()

dw_browse.SetFocus()

end event

type cb_access from commandbutton within w_saved_reports
integer x = 1815
integer y = 20
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&View Report"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 04.25.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
string ls_file_type
string ls_file_name
long   ll_pk_id, ll_row

ll_row = dw_browse.getrow()
if ll_row < 1 then return

ls_file_type   = dw_browse.getitemstring(ll_row, "sys_report_storage_files_file_type")
ls_file_name = dw_browse.getitemstring(ll_row, "sys_report_storage_files_file_name")
ll_pk_id        = dw_browse.getitemnumber(ll_row, "pk_id")
ls_file_type = Trim(Lower(ls_file_type))

of_view_document(ls_file_name, ls_file_type, ll_pk_id, "SRS")
end event

type cb_close from commandbutton within w_saved_reports
integer x = 3872
integer y = 20
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

type dw_browse from u_dw within w_saved_reports
integer y = 140
integer width = 4315
integer height = 1692
integer taborder = 10
string dataobject = "d_sys_reports_store_files_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.18.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.of_setupdateable( false)
this.of_settransobject( sqlca)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnDisplayNameStyle( 2 )

This.of_SetFilter(True)
This.inv_Filter.of_SetStyle(2)
This.inv_Filter.of_SetColumnDisplayNameStyle( 2 )

This.inv_sort.of_SetColumnHeader(True)

This.inv_sort.of_SetVisibleOnly( False )
This.of_SetDropDownCalendar( TRUE )
This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event clicked;call super::clicked;this.setrow(row)
end event

