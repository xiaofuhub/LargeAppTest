$PBExportHeader$w_find_app.srw
forward
global type w_find_app from w_response
end type
type dw_1 from datawindow within w_find_app
end type
type cb_sort from commandbutton within w_find_app
end type
type cb_filter from commandbutton within w_find_app
end type
type cb_cancel from commandbutton within w_find_app
end type
type cb_select from commandbutton within w_find_app
end type
end forward

global type w_find_app from w_response
integer x = 27
integer y = 192
integer width = 3936
integer height = 1944
boolean controlmenu = false
long backcolor = 33551856
dw_1 dw_1
cb_sort cb_sort
cb_filter cb_filter
cb_cancel cb_cancel
cb_select cb_select
end type
global w_find_app w_find_app

on w_find_app.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_cancel=create cb_cancel
this.cb_select=create cb_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_sort
this.Control[iCurrent+3]=this.cb_filter
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.cb_select
end on

on w_find_app.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_cancel)
destroy(this.cb_select)
end on

event open;call super::open;dw_1.SetTransObject( SQLCA )
dw_1.Retrieve()

IF dw_1.RowCount() > 0 THEN
	dw_1.SetRow( 1 )
	dw_1.SelectRow( 0 , False )
	dw_1.SelectRow( 1, True )
END IF
end event

type dw_1 from datawindow within w_find_app
integer y = 116
integer width = 3922
integer height = 1744
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_app_search_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;Integer li_row

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.SetRow( li_row )
	This.SelectRow( 0 , False )
	This.SelectRow( li_row, True )
END IF
end event

event doubleclicked;cb_select.TriggerEvent( Clicked! )
end event

type cb_sort from commandbutton within w_find_app
integer x = 2889
integer y = 24
integer width = 247
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;String ls_sort

SetNull( ls_sort )

dw_1.SetSort( ls_sort )
dw_1.Sort()
end event

type cb_filter from commandbutton within w_find_app
integer x = 3154
integer y = 24
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;String ls_filter

SetNull( ls_filter )

dw_1.SetFilter( ls_filter )
dw_1.Filter()
end event

type cb_cancel from commandbutton within w_find_app
integer x = 3675
integer y = 24
integer width = 247
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

type cb_select from commandbutton within w_find_app
integer x = 3415
integer y = 24
integer width = 247
integer height = 84
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Select"
end type

event clicked;Integer li_row

li_row = dw_1.GetRow( )

IF li_row = 0 THEN
	MessageBox( "Invalid Row", "No row selected." )
	Return -1
END IF

CloseWithReturn( Parent, String( dw_1.GetItemNumber( li_Row, "facility_id" ) )  + "-" + String( dw_1.GetItemNumber( li_row, "app_id" ) ) )
end event

