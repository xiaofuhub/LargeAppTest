$PBExportHeader$w_lookup_search.srw
forward
global type w_lookup_search from w_response
end type
type rb_state from radiobutton within w_lookup_search
end type
type rb_country from radiobutton within w_lookup_search
end type
type rb_city from radiobutton within w_lookup_search
end type
type gb_2 from groupbox within w_lookup_search
end type
type cb_ok from u_cb within w_lookup_search
end type
type cb_cancel from u_cb within w_lookup_search
end type
type dw_search from u_dw within w_lookup_search
end type
type cb_1 from u_cb within w_lookup_search
end type
type dw_1 from u_dw within w_lookup_search
end type
type cb_2 from commandbutton within w_lookup_search
end type
type gb_1 from groupbox within w_lookup_search
end type
end forward

global type w_lookup_search from w_response
integer x = 82
integer y = 312
integer width = 3483
integer height = 2020
string title = "Lookup Search"
boolean controlmenu = false
long backcolor = 12639424
rb_state rb_state
rb_country rb_country
rb_city rb_city
gb_2 gb_2
cb_ok cb_ok
cb_cancel cb_cancel
dw_search dw_search
cb_1 cb_1
dw_1 dw_1
cb_2 cb_2
gb_1 gb_1
end type
global w_lookup_search w_lookup_search

type variables
String is_search_type
String is_lookup_name

Integer ii_lookup_code


end variables

on w_lookup_search.create
int iCurrent
call super::create
this.rb_state=create rb_state
this.rb_country=create rb_country
this.rb_city=create rb_city
this.gb_2=create gb_2
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_search=create dw_search
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_state
this.Control[iCurrent+2]=this.rb_country
this.Control[iCurrent+3]=this.rb_city
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.cb_ok
this.Control[iCurrent+6]=this.cb_cancel
this.Control[iCurrent+7]=this.dw_search
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.cb_2
this.Control[iCurrent+11]=this.gb_1
end on

on w_lookup_search.destroy
call super::destroy
destroy(this.rb_state)
destroy(this.rb_country)
destroy(this.rb_city)
destroy(this.gb_2)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_search)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.gb_1)
end on

event open;call super::open;DataWindowChild dwchild

dw_search.of_SetTransObject( SQLCA )
dw_search.InsertRow( 0 )

rb_state.TriggerEvent( Clicked! )

dw_Search.SetFocus()

dw_1.of_SetTransObject( SQLCA )
is_lookup_name = Message.StringParm
dw_1.Retrieve( is_lookup_name )
end event

type rb_state from radiobutton within w_lookup_search
integer x = 352
integer y = 100
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "&State"
boolean checked = true
end type

event clicked;DataWindowChild dwchild

dw_search.Object.value.DDDW.AllowEdit = 'No'

dw_search.GetChild( "value", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( "state" )

dw_search.SetFocus()

is_search_type = "state"


end event

type rb_country from radiobutton within w_lookup_search
integer x = 658
integer y = 96
integer width = 270
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "C&ountry"
end type

event clicked;DataWindowChild dwchild

dw_search.Object.value.DDDW.AllowEdit = 'No'

dw_search.GetChild( "value", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( "country" )

dw_search.SetFocus()

is_search_type = "country"


end event

type rb_city from radiobutton within w_lookup_search
integer x = 78
integer y = 100
integer width = 224
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "&City"
end type

event clicked;DataWindowChild dwchild

dw_search.GetChild( "value", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( "" )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.14.2006 By: Liang QingShi
//$<reason> Fix a defect.
string ls_code
if dwchild.rowcount() > 0 then
	ls_code = dwchild.getitemstring(1,'code')
	if ls_code = '001' then
		dwchild.reset()
	end if
end if
//---------------------------- APPEON END ----------------------------

dw_search.SetFocus()

is_search_type = "city"

dw_search.Object.value.DDDW.AllowEdit = 'Yes'

dw_search.SetText( "" )
end event

type gb_2 from groupbox within w_lookup_search
integer x = 41
integer y = 40
integer width = 910
integer height = 152
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Search Field"
end type

type cb_ok from u_cb within w_lookup_search
integer x = 2871
integer y = 88
integer width = 261
integer height = 84
integer taborder = 80
boolean bringtotop = true
string text = "Select"
boolean default = true
end type

event clicked;//CloseWithReturn( Parent, dw_search.GetText() + "-" + is_search_type )
if dw_1.rowcount() < 1 then //trap added 022604 maha
	messagebox("User Error","You have clicked select with no record to select.  If you wish to quit, click Cancel.")
else
	CloseWithReturn( Parent, dw_1.GetItemNumber( dw_1.GetRow(), "lookup_code" ))
end if


end event

type cb_cancel from u_cb within w_lookup_search
integer x = 3154
integer y = 88
integer width = 261
integer height = 84
integer taborder = 70
boolean bringtotop = true
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type dw_search from u_dw within w_lookup_search
integer x = 1038
integer y = 88
integer width = 1120
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_select_lookup_search"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateAble( False )
end event

type cb_1 from u_cb within w_lookup_search
integer x = 2583
integer y = 88
integer width = 261
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Show All"
end type

event clicked;//CloseWithReturn( Parent, dw_search.GetText() + "-" + "All" ) //maha changed this code 010603

dw_1.SetFilter("")

dw_1.Filter()
end event

type dw_1 from u_dw within w_lookup_search
integer x = 37
integer y = 232
integer width = 3383
integer height = 1540
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_address_lookup_search"
boolean hscrollbar = true
end type

event clicked;call super::clicked;Integer li_clicked_row

li_clicked_row = This.GetClickedRow()

IF li_clicked_row > 0 THEN
	This.SelectRow( 0 , False )
	This.SelectRow( li_clicked_row, True )
	This.SetRow( li_clicked_row )
	This.ScrollToRow( li_clicked_row )
END IF
end event

event retrieveend;call super::retrieveend;IF rowcount > 0 THEN
	This.SelectRow( 0 , False )
	This.SelectRow( 1, True )
	This.SetRow( 1 )
	This.ScrollToRow( 1 )
END IF
end event

event doubleclicked;cb_ok.TriggerEvent( Clicked! )
end event

event constructor;This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.inv_sort.of_SetColumnHeader(True)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-09-07 By: Rodger Wu
//$<reason> Enable to use key arrows to select record.
This.of_SetRowSelect(True)
//---------------------------- APPEON END ----------------------------

end event

type cb_2 from commandbutton within w_lookup_search
integer x = 2217
integer y = 88
integer width = 261
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Find"
end type

event clicked;String ls_value
String ls_search_type

ls_value = UPPER(dw_search.GetText())
//messagebox("ls_value",ls_value)
IF is_search_type = "city" THEN
	dw_1.SetFilter( "Upper(city) = '" + ls_value + "'" )
ELSEIF is_search_type = "state" THEN
	dw_1.SetFilter( "Upper(state) = '" + ls_value + "'" )
ELSEIF is_search_type = "country" THEN
	dw_1.SetFilter( "Upper(country) = '" + ls_value + "'" )
ELSE
	dw_1.SetFilter("")
END IF

dw_1.Filter()
IF dw_1.RowCount() > 0 THEN
	dw_1.SelectRow( 0 , False )
	dw_1.SelectRow( 1, True )
	dw_1.SetRow( 1 )
END IF
end event

type gb_1 from groupbox within w_lookup_search
integer x = 983
integer y = 36
integer width = 1541
integer height = 160
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 67108864
string text = "Search Value"
end type

