$PBExportHeader$w_package_log_view.srw
forward
global type w_package_log_view from w_sheet
end type
type cb_saveas from u_cb within w_package_log_view
end type
type dw_from from u_dw within w_package_log_view
end type
type st_1 from statictext within w_package_log_view
end type
type cb_clear from commandbutton within w_package_log_view
end type
type cb_filter from commandbutton within w_package_log_view
end type
type cb_close from commandbutton within w_package_log_view
end type
type dw_browse from u_dw within w_package_log_view
end type
type gb_filter from groupbox within w_package_log_view
end type
type st_2 from statictext within w_package_log_view
end type
type dw_to from u_dw within w_package_log_view
end type
end forward

global type w_package_log_view from w_sheet
integer width = 3835
integer height = 2256
string title = "Package Log"
long backcolor = 33551856
cb_saveas cb_saveas
dw_from dw_from
st_1 st_1
cb_clear cb_clear
cb_filter cb_filter
cb_close cb_close
dw_browse dw_browse
gb_filter gb_filter
st_2 st_2
dw_to dw_to
end type
global w_package_log_view w_package_log_view

type variables
string is_OrgSql
string is_OpenFrom // Administrator! Personal!
end variables

on w_package_log_view.create
int iCurrent
call super::create
this.cb_saveas=create cb_saveas
this.dw_from=create dw_from
this.st_1=create st_1
this.cb_clear=create cb_clear
this.cb_filter=create cb_filter
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.gb_filter=create gb_filter
this.st_2=create st_2
this.dw_to=create dw_to
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_saveas
this.Control[iCurrent+2]=this.dw_from
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.cb_clear
this.Control[iCurrent+5]=this.cb_filter
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_browse
this.Control[iCurrent+8]=this.gb_filter
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.dw_to
end on

on w_package_log_view.destroy
call super::destroy
destroy(this.cb_saveas)
destroy(this.dw_from)
destroy(this.st_1)
destroy(this.cb_clear)
destroy(this.cb_filter)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.gb_filter)
destroy(this.st_2)
destroy(this.dw_to)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open()
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.19.2012 by Evan
//////////////////////////////////////////////////////////////////////

is_OpenFrom = Message.StringParm

dw_from.of_SetDropDownCalendar(true)
dw_to.of_SetDropDownCalendar(true)

// Set resize
this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())


// Retrieve data
cb_filter.Event Clicked()
end event

event resize;call super::resize;//====================================================================
//$<Event>: resize
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.31.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
dw_browse.resize(newwidth - 50, newheight - 250)
end event

type cb_saveas from u_cb within w_package_log_view
integer x = 2217
integer y = 76
integer width = 343
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Stephen 07.31.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

IF dw_browse.DataObject = "" THEN RETURN
gnv_dw.of_SaveAs(dw_browse,"",text!,true)
ChangeDirectory(gs_current_path)


end event

type dw_from from u_dw within w_package_log_view
integer x = 398
integer y = 84
integer width = 462
integer height = 80
integer taborder = 10
string dataobject = "d_esi_date_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<evant> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

this.InsertRow(0)
this.of_SetUpdateable(false)
end event

event itemerror;Return 1
end event

type st_1 from statictext within w_package_log_view
integer x = 37
integer y = 96
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sent time from:"
boolean focusrectangle = false
end type

type cb_clear from commandbutton within w_package_log_view
integer x = 1787
integer y = 76
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clea&r"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> Clear filter criteria
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

date ld_Null

SetNull(ld_Null)
dw_from.SetItem(1, "date_value", ld_Null)
dw_to.SetItem(1, "date_value", ld_Null)

cb_filter.Event Clicked()
end event

type cb_filter from commandbutton within w_package_log_view
integer x = 1426
integer y = 76
integer width = 343
integer height = 92
integer taborder = 40
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
//$<Author>: (Appeon) Stephen 07.31.2013 (V141 File Packet creation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

date ld_To
date ld_From
string ls_user_id
string ls_Where
string ls_NewSql
long ll_old_id
long ll_new_id
boolean lb_FirstRow

// Check filter criteria
if dw_from.AcceptText() = -1 then
	MessageBox("Prompt", "Please type correct format of FROM date.")
	dw_from.SetFocus()
	Return
end if
if dw_to.AcceptText() = -1 then
	MessageBox("Prompt", "Please type correct format of TO date.")
	dw_to.SetFocus()
	Return
end if
ld_From = dw_from.GetItemDate(1, "date_value")
ld_To = dw_to.GetItemDate(1, "date_value")

if (IsNull(ld_From)) and (not IsNull(ld_To)) then
	MessageBox("Prompt", "Please type the FROM date.")
	dw_from.SetFocus()
	Return
end if
if (not IsNull(ld_From)) and (IsNull(ld_To)) then
	MessageBox("Prompt", "Please type the TO date.")
	dw_to.SetFocus()
	Return
end if
if ld_From > ld_To then
	MessageBox("Prompt", "The FROM date should be less or equal than the TO date.")
	dw_from.SetFocus()
	Return
end if

// Build filter criteria
if (not IsNull(ld_From)) and (not IsNull(ld_To)) then
	ls_Where =  "(date_sent >= '" + String(ld_From, "yyyy-mm-dd") + " 00:00:00') AND "
	ls_Where += "(date_sent <= '" + String(ld_To, "yyyy-mm-dd") + " 23:59:59') "
end if

if Len(ls_Where) > 0 then
	ls_NewSql = is_OrgSql + " WHERE " + ls_Where
	dw_browse.SetSQLSelect(ls_NewSql)
else
	dw_browse.SetSQLSelect(is_OrgSql)
end if

// Retrieve data
dw_browse.retrieve()

end event

type cb_close from commandbutton within w_package_log_view
integer x = 3319
integer y = 76
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type dw_browse from u_dw within w_package_log_view
integer x = 23
integer y = 220
integer width = 3721
integer height = 1900
integer taborder = 80
string dataobject = "d_email_package_log"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;//inherit
long ll_Row

ll_Row = this.GetSelectedRow(1)
this.SetRow(ll_Row)
end event

event constructor;call super::constructor;//inherit
this.of_SetSort(true)
inv_sort.of_SetColumnHeader(true)
this.SetTransObject(SQLCA)
this.Modify("DataWindow.ReadOnly='yes'")
is_OrgSql = this.GetSQLSelect()
end event

type gb_filter from groupbox within w_package_log_view
integer x = 23
integer y = 16
integer width = 2158
integer height = 176
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter Criteria"
end type

type st_2 from statictext within w_package_log_view
integer x = 869
integer y = 96
integer width = 78
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "to"
boolean focusrectangle = false
end type

type dw_to from u_dw within w_package_log_view
integer x = 928
integer y = 84
integer width = 457
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_esi_date_sel"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<evant> constructor
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 06.14.2012 by Evan
//////////////////////////////////////////////////////////////////////

this.InsertRow(0)
this.of_SetUpdateable(false)
end event

event itemerror;Return 1
end event

