$PBExportHeader$w_select_screen_view.srw
forward
global type w_select_screen_view from w_response
end type
type cb_cancel from u_cb within w_select_screen_view
end type
type st_1 from statictext within w_select_screen_view
end type
type cb_ok from u_cb within w_select_screen_view
end type
type dw_select from u_dw within w_select_screen_view
end type
end forward

global type w_select_screen_view from w_response
integer x = 1170
integer y = 424
integer width = 1093
integer height = 456
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_cancel cb_cancel
st_1 st_1
cb_ok cb_ok
dw_select dw_select
end type
global w_select_screen_view w_select_screen_view

type variables
Integer ii_data_view_id = 1
Integer ii_screen_id //alfee 02.16.2009
end variables

on w_select_screen_view.create
int iCurrent
call super::create
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.cb_ok=create cb_ok
this.dw_select=create dw_select
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancel
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_select
end on

on w_select_screen_view.destroy
call super::destroy
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.dw_select)
end on

event open;call super::open;//Alfee 02.16.2009 for dynamic profile painter
ii_screen_id = Message.DoubleParm

end event

type cb_cancel from u_cb within w_select_screen_view
integer x = 567
integer y = 244
integer height = 84
integer taborder = 3
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(w_select_screen_view, "Cancel" ) //maha app100705 removed parent
end event

type st_1 from statictext within w_select_screen_view
integer x = 82
integer y = 52
integer width = 265
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Select View"
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_select_screen_view
integer x = 192
integer y = 244
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

//-----------Begin Added by Alfee on 02.16.2009------------------------------
//For dynamic profile painter
Long ll_cnt
IF NOT IsNull(ii_screen_id) THEN
	select count(*) into :ll_cnt from data_view_screen where data_view_id = :ii_data_view_id and screen_id = :ii_screen_id;
	IF ll_cnt < 1 THEN
		MessageBox("Select View","The selected view doesn't include the current screen!") 
		RETURN
	END IF	
END IF
//-----------End Added -------------------------------------------------------

dw_select.GetChild( "data_view_id", ldwc_view )
li_found = ldwc_view.Find( "data_view_id = " + String( dw_select.GetItemNumber( 1, &
									"data_view_id" )), 1, ldwc_view.rowcount() )
If li_found > 0 Then
	ls_view_name = ldwc_view.GetItemString( li_found, "data_view_name" )
End If
CloseWithReturn( Parent, String( ii_data_view_id ) + "~t" + String( ls_view_name ) )
//---------------------------- APPEON END ----------------------------

end event

type dw_select from u_dw within w_select_screen_view
integer x = 73
integer y = 116
integer width = 942
integer height = 80
integer taborder = 2
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
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

STRING ls_view_type

ls_view_type = Upper(Message.StringParm)
IF Isnull( ls_view_type ) THEN ls_view_type = "P"

IF ls_view_type = "C" THEN
	ii_data_view_id = 1001
	This.Dataobject = "d_select_views_dddw_list_contract"
ELSE
	ii_data_view_id = 1
	This.Dataobject = "d_select_views_dddw_list"
END IF

This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

This.InsertRow( 0 )
This.SetItem( 1, "data_view_id", ii_data_view_id )
This.SetRow( 1 )
This.ScrollToRow( 1 )
//---------------------------- APPEON END ----------------------------

end event

event itemchanged;call super::itemchanged;ii_data_view_id = Integer( data )




end event

