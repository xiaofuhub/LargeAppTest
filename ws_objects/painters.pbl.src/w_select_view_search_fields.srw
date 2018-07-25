$PBExportHeader$w_select_view_search_fields.srw
forward
global type w_select_view_search_fields from w_response
end type
type st_2 from statictext within w_select_view_search_fields
end type
type cb_cancel from u_cb within w_select_view_search_fields
end type
type cb_ok from u_cb within w_select_view_search_fields
end type
type dw_select from u_dw within w_select_view_search_fields
end type
end forward

global type w_select_view_search_fields from w_response
integer x = 1170
integer y = 424
integer width = 1317
integer height = 604
string title = "Select View to Copy"
boolean controlmenu = false
long backcolor = 33551856
st_2 st_2
cb_cancel cb_cancel
cb_ok cb_ok
dw_select dw_select
end type
global w_select_view_search_fields w_select_view_search_fields

type variables
Integer ii_data_view_id = 1
end variables

on w_select_view_search_fields.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.dw_select=create dw_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_select
end on

on w_select_view_search_fields.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.dw_select)
end on

event open;call super::open;//Start Code Change ----04.12.2016 #V15 maha - added for 15.2
ii_data_view_id = 1


end event

type st_2 from statictext within w_select_view_search_fields
integer x = 82
integer y = 24
integer width = 1216
integer height = 160
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "The selected view does not have setup fields. Please select the view from which to copy."
boolean focusrectangle = false
end type

type cb_cancel from u_cb within w_select_view_search_fields
integer x = 663
integer y = 332
integer height = 84
integer taborder = 3
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(parent, 0 ) //maha app100705 removed parent
end event

type cb_ok from u_cb within w_select_view_search_fields
integer x = 288
integer y = 332
integer height = 84
string text = "&OK"
boolean default = true
end type

event clicked;
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.13.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Return the selected view name. Therefore, the subsequent script that uses view names
//$<modification> directly will get the names from dw_select instead of from the database.

/* CloseWithReturn( w_select_view, ii_data_view_id ) //maha app100705 removed parent */
datawindowchild ldwc_view
Integer li_found
String ls_view_name

dw_select.GetChild( "data_view_id", ldwc_view )
li_found = ldwc_view.Find( "data_view_id = " + String( dw_select.GetItemNumber( 1, &
									"data_view_id" )), 1, ldwc_view.rowcount() )
If li_found > 0 Then
	ls_view_name = ldwc_view.GetItemString( li_found, "data_view_name" )
End If
CloseWithReturn( Parent,  ii_data_view_id   )
//---------------------------- APPEON END ----------------------------

end event

type dw_select from u_dw within w_select_view_search_fields
integer x = 169
integer y = 224
integer width = 937
integer height = 80
integer taborder = 2
boolean bringtotop = true
string dataobject = "d_select_views_search_fields"
boolean vscrollbar = false
boolean border = false
end type

event constructor;//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.22.2006 By: LeiWei
//$<reason> Contract module modfication
//$<modification> Add view type "P" practitioner view "C" contract view
/*
This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

This.InsertRow( 0 )
This.SetItem( 1, "data_view_id", 1 )
This.SetRow( 1 )
This.ScrollToRow( 1 )
*/

This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

this.retrieve()


This.Object.DataWindow.Color = Parent.backcolor  //alfee 12.02.2010

end event

event itemchanged;call super::itemchanged;ii_data_view_id = Integer( data )




end event

