$PBExportHeader$w_pending_changes_group_all.srw
forward
global type w_pending_changes_group_all from w_response
end type
type dw_type from u_dw within w_pending_changes_group_all
end type
type cb_filter from commandbutton within w_pending_changes_group_all
end type
type cb_reset from commandbutton within w_pending_changes_group_all
end type
type dw_date_range from u_dw within w_pending_changes_group_all
end type
type rb_1 from radiobutton within w_pending_changes_group_all
end type
type cb_delete from commandbutton within w_pending_changes_group_all
end type
type cb_view from commandbutton within w_pending_changes_group_all
end type
type cb_add from commandbutton within w_pending_changes_group_all
end type
type cb_close from commandbutton within w_pending_changes_group_all
end type
type dw_browse from u_dw within w_pending_changes_group_all
end type
type gb_status from groupbox within w_pending_changes_group_all
end type
type rb_2 from radiobutton within w_pending_changes_group_all
end type
type gb_date from groupbox within w_pending_changes_group_all
end type
type gb_type from groupbox within w_pending_changes_group_all
end type
type gb_filter from groupbox within w_pending_changes_group_all
end type
end forward

global type w_pending_changes_group_all from w_response
integer width = 3314
integer height = 2292
string title = "Pending Record Changes List"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean ib_savestatus = true
dw_type dw_type
cb_filter cb_filter
cb_reset cb_reset
dw_date_range dw_date_range
rb_1 rb_1
cb_delete cb_delete
cb_view cb_view
cb_add cb_add
cb_close cb_close
dw_browse dw_browse
gb_status gb_status
rb_2 rb_2
gb_date gb_date
gb_type gb_type
gb_filter gb_filter
end type
global w_pending_changes_group_all w_pending_changes_group_all

type variables

end variables

forward prototypes
public function integer of_filter_data ()
public function integer of_set_security ()
end prototypes

public function integer of_filter_data ();//====================================================================
//$<Function>: of_filter_data()
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Filter data in the DataWindow
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_filter, ls_type, ls_date_filter
String ls_from_date, ls_to_date
Date ld_from_date, ld_to_date

//Pending Status
IF rb_1.checked THEN
	ls_filter = 'pending_status=1'
ELSE
	ls_filter = 'pending_status=0'
END IF

//Change Type
dw_type.AcceptText ()
ls_type = dw_type.GetItemString (1, "change_type")
IF Len(ls_type) > 0 THEN 
	ls_filter += " And Upper(change_type) = '" + Upper(ls_type) + "'"
END IF

//Effective Date
dw_date_range.AcceptText ()
ld_from_date = dw_date_range.GetItemDate( 1, "from" )
ld_to_date = dw_date_range.GetItemDate( 1, "to" )
ls_from_date = String(ld_from_date,"yyyy-mm-dd") 
ls_to_date = String(ld_to_date,"yyyy-mm-dd")
If isnull(ld_from_date) and not isnull(ld_to_date) Then
	ls_date_filter = " (Date(effective_date) <= Date('" + ls_to_date + "') )"
ElseIf Isnull(ld_to_date) and not isnull(ld_from_date) Then
	ls_date_filter = " (Date(effective_date) >= Date('" + ls_from_date + "') )"
ElseIf isnull(ld_from_date) and isnull(ld_to_date) Then
	ls_date_filter = ''
Else 
	ls_date_filter = " ( Date(effective_date) >= Date('" + ls_from_date + "') AND Date(effective_date) <= Date('" + ls_to_date + "') )"
End If

IF Len(ls_date_filter) > 0 THEN
	ls_filter += ' And ' +ls_date_filter 
END IF

dw_browse.SetFilter( ls_filter)
dw_browse.Filter( )

if dw_browse.rowcount () > 0 then
	dw_browse.ScrolltoRow (1)
	dw_browse.SelectRow (0, False)
	dw_browse.SelectRow (1, True)
end if

RETURN 1

end function

public function integer of_set_security ();//====================================================================
//$<Function>: of_set_security
//$<Arguments>:
//$<Return>:  integer
//$<Description>: set readonly user access right BugL112101
//$<Author>: (Appeon) long.zhang 11.28.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Integer li_level

if this.parentwindow( ) = w_group_practice then
	
	if isValid(w_group_practice) then
		
		li_level = w_group_practice.of_get_accesslevel()
		
		if li_level = 1 then
				cb_add.visible = false
				cb_delete.visible = false
		end if
		
	end if
	
end if
return 1
end function

on w_pending_changes_group_all.create
int iCurrent
call super::create
this.dw_type=create dw_type
this.cb_filter=create cb_filter
this.cb_reset=create cb_reset
this.dw_date_range=create dw_date_range
this.rb_1=create rb_1
this.cb_delete=create cb_delete
this.cb_view=create cb_view
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_browse=create dw_browse
this.gb_status=create gb_status
this.rb_2=create rb_2
this.gb_date=create gb_date
this.gb_type=create gb_type
this.gb_filter=create gb_filter
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_type
this.Control[iCurrent+2]=this.cb_filter
this.Control[iCurrent+3]=this.cb_reset
this.Control[iCurrent+4]=this.dw_date_range
this.Control[iCurrent+5]=this.rb_1
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_view
this.Control[iCurrent+8]=this.cb_add
this.Control[iCurrent+9]=this.cb_close
this.Control[iCurrent+10]=this.dw_browse
this.Control[iCurrent+11]=this.gb_status
this.Control[iCurrent+12]=this.rb_2
this.Control[iCurrent+13]=this.gb_date
this.Control[iCurrent+14]=this.gb_type
this.Control[iCurrent+15]=this.gb_filter
end on

on w_pending_changes_group_all.destroy
call super::destroy
destroy(this.dw_type)
destroy(this.cb_filter)
destroy(this.cb_reset)
destroy(this.dw_date_range)
destroy(this.rb_1)
destroy(this.cb_delete)
destroy(this.cb_view)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_browse)
destroy(this.gb_status)
destroy(this.rb_2)
destroy(this.gb_date)
destroy(this.gb_type)
destroy(this.gb_filter)
end on

event open;call super::open;//====================================================================
//$<Event>: open()
//$<Arguments>:
//$<Return>:  long
//$<Description>: Pending changes for all locations
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

//Set filter
of_filter_data()

//Retrieve Data
dw_browse.retrieve ()


end event

event pfc_postopen;call super::pfc_postopen;of_set_security()//long.zhang 11.28.2013 set security access BugL112101
end event

type dw_type from u_dw within w_pending_changes_group_all
integer x = 677
integer y = 124
integer width = 338
integer height = 76
integer taborder = 40
string dataobject = "d_group_change_type"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.object.datawindow.color = gl_bg_color 

this.InsertRow (0)
end event

event itemchanged;call super::itemchanged;//====================================================================
//$<Event>: itemchanged()
//$<Arguments>:
// 	value    long        row
// 	value    dwobject    dwo
// 	value    string      data
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

cb_filter.event clicked ()
end event

type cb_filter from commandbutton within w_pending_changes_group_all
integer x = 2021
integer y = 124
integer width = 123
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Go"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_rtn

li_rtn = of_filter_data ()

RETURN li_rtn

end event

type cb_reset from commandbutton within w_pending_changes_group_all
integer x = 1833
integer y = 124
integer width = 174
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reset"
end type

event clicked;dw_date_range.Reset( )
dw_date_range.InsertRow( 0 )
//SetNull( is_date_filter )
//SetNull( is_status_filter )
//cb_1.event clicked()
end event

type dw_date_range from u_dw within w_pending_changes_group_all
integer x = 1061
integer y = 124
integer width = 786
integer height = 76
integer taborder = 50
string dataobject = "d_group_date_range"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
this.object.datawindow.color = gl_bg_color 

this.of_SetTransObject( SQLCA )
this.of_SetDropDownCalendar( TRUE )
this.iuo_calendar.of_Register( this.iuo_calendar.DDLB )		

this.InsertRow( 0 )

this.of_SetUpdateAble( False )
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()


ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if


end event

type rb_1 from radiobutton within w_pending_changes_group_all
integer x = 69
integer y = 128
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Pending"
boolean checked = true
end type

event clicked;cb_filter.event clicked ()
end event

type cb_delete from commandbutton within w_pending_changes_group_all
integer x = 2711
integer y = 124
integer width = 279
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

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 07.25.2013 (V14.1Group Location Effective Dates)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
long ll_pending_id
long ll_count
long ll_row

ll_row = dw_browse.getrow( )
if ll_row = 0 then return

if MessageBox('Delete','Are you sure you want to delete this record?',Question!,YesNo! ,2) = 2 then return

setNull(ll_pending_id)

if dw_browse.getitemstring(dw_browse.getrow( ), 'change_type') = 'M' then
	ll_pending_id = dw_browse.getitemnumber(  dw_browse.getrow( ), 'pending_id')
	
	select count(*) into :ll_count from pd_address_change_pending where gp_id = :ll_pending_id;
	
	if ll_count > 0 then
		if MessageBox('Delete','There are '+String(ll_count)+' address pending record(s) connect to this record' + &
		'.~r~n delete this record will also delete them. Are you sure you really want to delete this record?',Question!,YesNo!,2) = 2 then
			return
		end if	
	end if
end if

dw_browse.deleterow( 0)

gnv_appeondb.of_startqueue( )

	if not isNull(ll_pending_id) then
		Delete from pd_address_change_pending where gp_id = :ll_pending_id;
	end if

	dw_browse.update( )

gnv_appeondb.of_commitqueue( )

if ll_row = dw_browse.getrow( ) then
	dw_browse.event rowfocuschanged(ll_row)
end if
end event

type cb_view from commandbutton within w_pending_changes_group_all
integer x = 2158
integer y = 124
integer width = 279
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Detail"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: View the existing pending change record
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_row, ll_pending_id, ll_rec_id, ll_rtn
String ls_type, ls_parm

ll_row = dw_browse.getrow ()
if ll_row < 1 then return

ls_type = 'V'
ll_pending_id = dw_browse.getitemnumber(ll_row, "pending_id")
ll_rec_id =  dw_browse.getitemnumber(ll_row, "rec_id")

ls_parm = ls_type + String(ll_pending_id)

if not IsNull(ll_rec_id) then
	ls_parm += "-"+ String(ll_rec_id)
end if

openwithparm (w_pending_changes_group_detail, ls_parm)

//for BugL111101 - alfee 11.11.2013
if message.stringparm = "1" then
	of_filter_data ()
	dw_browse.retrieve ()
	ll_row = dw_browse.find ("pending_id = " + String(ll_pending_id), 1, dw_browse.rowcount ())
	if ll_row > 0 then
		dw_browse.scrolltorow (ll_row)
		dw_browse.selectrow (0, false)
		dw_browse.selectrow (ll_row, true)		
	end if
end if


end event

type cb_add from commandbutton within w_pending_changes_group_all
integer x = 2437
integer y = 124
integer width = 279
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: Add a new pending change record
//$<Author>: (Appeon) Alfee 11.07.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

openwithparm (w_pending_changes_group_detail, 'A')

of_filter_data ()
dw_browse.retrieve ()


end event

type cb_close from commandbutton within w_pending_changes_group_all
integer x = 2994
integer y = 124
integer width = 279
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

type dw_browse from u_dw within w_pending_changes_group_all
integer x = 23
integer y = 256
integer width = 3246
integer height = 1936
integer taborder = 10
string dataobject = "d_group_pending_browse_all"
boolean hscrollbar = true
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;//====================================================================
//$<Event>: constructor()
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
This.settransobject(sqlca)

This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetUpdateable( False )
This.inv_sort.of_SetColumnHeader(True)

This.of_setrowselect( True)
This.inv_rowselect.of_SetStyle(This.inv_rowselect.single )
end event

event retrieveend;call super::retrieveend;//====================================================================
//$<Event>: retrieveend()
//$<Arguments>:
// 	value    long    rowcount
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.08.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if rowcount > 0 then
	dw_browse.ScrolltoRow (1)
	dw_browse.SelectRow (0, False)
	dw_browse.SelectRow (1, True)
end if


end event

event doubleclicked;call super::doubleclicked;//====================================================================
//$<Event>: doubleclicked()
//$<Arguments>:
// 	value    integer     xpos
// 	value    integer     ypos
// 	value    long        row
// 	value    dwobject    dwo
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) Alfee 11.08.2013
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

if row > 0 then
	cb_view.event clicked ()
end if
end event

type gb_status from groupbox within w_pending_changes_group_all
integer x = 37
integer y = 64
integer width = 603
integer height = 148
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Pending Status"
end type

type rb_2 from radiobutton within w_pending_changes_group_all
integer x = 366
integer y = 128
integer width = 265
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Applied"
end type

event clicked;cb_filter.event clicked ()
end event

type gb_date from groupbox within w_pending_changes_group_all
integer x = 1047
integer y = 64
integer width = 969
integer height = 148
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Effective Date Range"
end type

type gb_type from groupbox within w_pending_changes_group_all
integer x = 649
integer y = 64
integer width = 389
integer height = 148
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Type"
end type

type gb_filter from groupbox within w_pending_changes_group_all
integer x = 23
integer y = 4
integer width = 2130
integer height = 232
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filters"
end type

