$PBExportHeader$w_alias_name_sync.srw
forward
global type w_alias_name_sync from window
end type
type dw_copy from datawindow within w_alias_name_sync
end type
type cb_3 from commandbutton within w_alias_name_sync
end type
type dw_select from u_dw within w_alias_name_sync
end type
type cb_close from commandbutton within w_alias_name_sync
end type
type dw_fields from datawindow within w_alias_name_sync
end type
type cb_2 from commandbutton within w_alias_name_sync
end type
type cb_1 from commandbutton within w_alias_name_sync
end type
type st_5 from statictext within w_alias_name_sync
end type
type dw_screens from datawindow within w_alias_name_sync
end type
end forward

global type w_alias_name_sync from window
integer x = 5
integer y = 4
integer width = 4754
integer height = 2360
boolean titlebar = true
string title = "Field Alias Sync"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
boolean center = true
dw_copy dw_copy
cb_3 cb_3
dw_select dw_select
cb_close cb_close
dw_fields dw_fields
cb_2 cb_2
cb_1 cb_1
st_5 st_5
dw_screens dw_screens
end type
global w_alias_name_sync w_alias_name_sync

type variables
integer ii_dv
integer ii_screen
boolean ib_dv = false

end variables

on w_alias_name_sync.create
this.dw_copy=create dw_copy
this.cb_3=create cb_3
this.dw_select=create dw_select
this.cb_close=create cb_close
this.dw_fields=create dw_fields
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_5=create st_5
this.dw_screens=create dw_screens
this.Control[]={this.dw_copy,&
this.cb_3,&
this.dw_select,&
this.cb_close,&
this.dw_fields,&
this.cb_2,&
this.cb_1,&
this.st_5,&
this.dw_screens}
end on

on w_alias_name_sync.destroy
destroy(this.dw_copy)
destroy(this.cb_3)
destroy(this.dw_select)
destroy(this.cb_close)
destroy(this.dw_fields)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_5)
destroy(this.dw_screens)
end on

type dw_copy from datawindow within w_alias_name_sync
integer x = 1134
integer y = 2316
integer width = 2528
integer height = 360
integer taborder = 70
string dataobject = "d_dvf_field_alias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject( sqlca)
end event

type cb_3 from commandbutton within w_alias_name_sync
integer x = 1874
integer y = 100
integer width = 731
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "<- Sync System to View Alias"
end type

event clicked;integer r
integer rc

rc = dw_fields.rowcount()

dw_copy.reset()

for r = 1 to rc
	if dw_fields.getitemnumber(r,"selected") = 1 then
		dw_fields.setitem(r,"field_label", dw_fields.getitemstring(r,"sys_fields_field_name_allias"))
		dw_fields.rowscopy( r, r, primary!, dw_copy, 1000, primary!)
		dw_copy.setitemstatus( dw_copy.rowcount(), "field_label", primary!, datamodified!)
		dw_copy.setitemstatus( dw_copy.rowcount(), 0, primary!, datamodified!)
	end if
next

ib_dv = true
cb_1.enabled = false


//dw_data_view.update()
//commit using sqlca;
//
//li_nr = dw_data_view.InsertRow( 1 )
//dw_data_view.SetRow( li_nr )
//dw_data_view.ScrollToRow( li_nr )
//dw_data_view.SetFocus()
//
//SELECT Max( data_view_field_id )  
//INTO :ll_next_dv_id
//FROM data_view_fields  ;
//
//ll_next_dv_id++
//
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_field_id", ll_next_dv_id )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "screen_id", ii_screen )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_id", dw_sys_fields.GetItemNumber( 1, "field_id" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_label", dw_sys_fields.GetItemString( 1, "field_name_allias" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_order", dw_sys_fields.GetItemNumber( 1, "field_order" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_id", 1 )
//
end event

type dw_select from u_dw within w_alias_name_sync
integer x = 27
integer y = 64
integer width = 983
integer height = 96
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
boolean vscrollbar = false
boolean border = false
end type

event constructor;

This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
this.retrieve(1)
this.insertrow(1)


//IF Left(ls_view_type, 1) = "A" THEN //App Mapping - alfee 12.02.2010
//	DatawindowChild ldwchild
//	This.GetChild( "data_view_id", ldwchild )
//	ldwchild.SetTransObject( sqlca )
//	ldwchild.Retrieve(gs_user_id, 'P')
//END IF

//This.InsertRow( 0 )
//This.SetItem( 1, "data_view_id", ii_data_view_id )
//This.SetRow( 1 )
//This.ScrollToRow( 1 )
////---------------------------- APPEON END ----------------------------
//
//This.Object.DataWindow.Color = Parent.backcolor  //alfee 12.02.2010
//
end event

event itemchanged;call super::itemchanged;ii_dv = Integer( data )

dw_screens.retrieve(ii_dv)





end event

type cb_close from commandbutton within w_alias_name_sync
integer x = 4137
integer y = 52
integer width = 329
integer height = 84
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

type dw_fields from datawindow within w_alias_name_sync
integer x = 1042
integer y = 184
integer width = 3698
integer height = 2088
integer taborder = 60
string dataobject = "d_dvf_field_alias"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

event buttonclicked; //Start Code Change ----02.22.2017 #V153 maha
if dwo.name = "b_select" then
	integer li_rc
	integer v
	integer i
	li_rc = this.RowCount()

	IF dwo.Text = "Select All" THEN
		dwo.Text = "Deselect All"
		v = 1
	ELSE
		dwo.Text = "Select All"
		v = 0
	END IF
	
	FOR i = 1 TO li_rc
			this.SetItem( i, "selected", v )
	END FOR
end if
end event

type cb_2 from commandbutton within w_alias_name_sync
integer x = 3643
integer y = 52
integer width = 485
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;String ls_table
String ls_field

Integer li_filenum
integer li_table


if ib_dv then
//	dw_fields.modify("field_label.update=Yes")
//	dw_fields.modify("data_view_field_id.update=Yes")
//	dw_fields.modify("field_name_allias.update=No")
//	dw_fields.modify("app_fill_field_len.update=No")
//	dw_fields.object.DataWindow.Table.updatetable="data_view_fields"
//	dw_fields.object.DataWindow.Table.updatekeyinplace="YES"
//	dw_fields.object.DataWindow.Table.updatewhere=2
	dw_copy.update()
	dw_fields.retrieve( ii_dv , ii_screen)
end if

dw_fields.Update()


//
//dw_data_view.Update()
//
//COMMIT USING SQLCA;
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 03.31.2006 By: Liang QingShi
////$<reason> Fix a defect.
//
//dw_browse.settransobject(sqlca)
////---------------------------- APPEON END ----------------------------
//dw_browse.retrieve(ii_table)


end event

type cb_1 from commandbutton within w_alias_name_sync
integer x = 1874
integer y = 16
integer width = 731
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sync View to System Alias -> "
end type

event clicked;integer r
integer rc

rc = dw_fields.rowcount()

for r = 1 to rc
	if dw_fields.getitemnumber(r,"selected") = 1 then
		dw_fields.setitem(r,"sys_fields_field_name_allias", dw_fields.getitemstring(r,"field_label"))
	end if
next

cb_3.enabled = false

//dw_data_view.update()
//commit using sqlca;
//
//li_nr = dw_data_view.InsertRow( 1 )
//dw_data_view.SetRow( li_nr )
//dw_data_view.ScrollToRow( li_nr )
//dw_data_view.SetFocus()
//
//SELECT Max( data_view_field_id )  
//INTO :ll_next_dv_id
//FROM data_view_fields  ;
//
//ll_next_dv_id++
//
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_field_id", ll_next_dv_id )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "screen_id", ii_screen )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_id", dw_sys_fields.GetItemNumber( 1, "field_id" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_label", dw_sys_fields.GetItemString( 1, "field_name_allias" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "field_order", dw_sys_fields.GetItemNumber( 1, "field_order" ) )
//dw_data_view.SetItem( dw_sys_fields.GetRow(), "data_view_id", 1 )
//
end event

type st_5 from statictext within w_alias_name_sync
integer x = 46
integer y = 8
integer width = 718
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Select Data View"
boolean focusrectangle = false
end type

type dw_screens from datawindow within w_alias_name_sync
integer x = 18
integer y = 184
integer width = 1001
integer height = 2088
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_data_view_screens_list_4_util"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(sqlca)
end event

event rowfocuschanged;if currentrow < 1 then return

ii_screen = this.getitemnumber(currentrow, "screen_id")

dw_fields.retrieve(ii_dv, ii_screen)

this.selectrow(0,False)
this.selectrow(currentrow,true)
end event

event retrieveend;ii_screen = this.getitemnumber(1, "screen_id")

dw_fields.retrieve(ii_dv, ii_screen)

this.selectrow(0,False)
this.selectrow(1,true)
end event

