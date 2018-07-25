$PBExportHeader$w_custom_report_selection.srw
forward
global type w_custom_report_selection from w_main
end type
type pb_save from picturebutton within w_custom_report_selection
end type
type pb_cancel from picturebutton within w_custom_report_selection
end type
type uo_1 from u_cst_report_selection within w_custom_report_selection
end type
end forward

global type w_custom_report_selection from w_main
integer width = 3941
integer height = 2288
string title = "Quick Selection"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
pb_save pb_save
pb_cancel pb_cancel
uo_1 uo_1
end type
global w_custom_report_selection w_custom_report_selection

type variables

end variables

on w_custom_report_selection.create
int iCurrent
call super::create
this.pb_save=create pb_save
this.pb_cancel=create pb_cancel
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_save
this.Control[iCurrent+2]=this.pb_cancel
this.Control[iCurrent+3]=this.uo_1
end on

on w_custom_report_selection.destroy
call super::destroy
destroy(this.pb_save)
destroy(this.pb_cancel)
destroy(this.uo_1)
end on

event open;call super::open;Long ll_found
String ls_vname
long i
uo_1.dw_view_name.Retrieve( )

IF w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount() > 0 THEN
	ls_vname = w_custom_report.tab_1.tabpage_tables.dw_view_tables.Object.conv_view_table_table_name[w_custom_report.tab_1.tabpage_tables.dw_view_tables.getrow()]
	ll_found = uo_1.dw_view_name.Find("v_name='" + ls_vname + "'",1,uo_1.dw_view_name.RowCount())
	IF ll_found > 0 THEN
		uo_1.dw_view_name.ScrollToRow( ll_found)
	END IF
	//setbitmap
	for i= 1 to  w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount()
		ls_vname = w_custom_report.tab_1.tabpage_tables.dw_view_tables.Object.conv_view_table_table_name[i]
		ll_found = uo_1.dw_view_name.Find("v_name='" + ls_vname + "'",1,uo_1.dw_view_name.RowCount())
		IF ll_found > 0 THEN
			uo_1.dw_view_name.object.bitmapflag[ll_found]='1'
		END IF
	next
	
END IF
this.uo_1.gb_1.bringtotop=false
this.uo_1.dw_view_screen_detail.bringtotop=true
This.Move( w_mdi.WorkSpaceWidth ( ) -This.Width  , w_mdi.WorkSpaceHeight ( ) -This.Height +85 )

end event

event closequery;Int li_rc
IF w_custom_report.tab_1.tabpage_columns.dw_view_fields.ModifiedCount()+ w_custom_report.tab_1.tabpage_columns.dw_view_fields.DeletedCount() > 0 THEN
	li_rc = MessageBox("Closing","Update your changes?", Question!, YesNoCancel!, 3)
	IF li_rc = 1 THEN
		pb_save.Event Clicked( )
	ELSEIF li_rc = 2 THEN
		pb_cancel.Event Clicked( )
		RETURN 0
	ELSE
		RETURN 1
	END IF
END IF


end event

type pb_save from picturebutton within w_custom_report_selection
integer x = 3232
integer y = 8
integer width = 311
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Save"
boolean originalsize = true
string picturename = ".\APPLY.BMP"
alignment htextalign = right!
boolean map3dcolors = true
end type

event clicked;w_custom_report.tab_1.tabpage_tables.cb_next_2.TriggerEvent(Clicked!)
close(parent)
end event

type pb_cancel from picturebutton within w_custom_report_selection
integer x = 3557
integer y = 8
integer width = 311
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Cancel"
boolean originalsize = true
string picturename = ".\EXIT.BMP"
alignment htextalign = right!
boolean map3dcolors = true
end type

event clicked;dwItemStatus l_status
Long ll_fields_cnt,ll_table_cnt,i
//remove the added fields
ll_fields_cnt = w_custom_report.tab_1.tabpage_columns.dw_view_fields.RowCount()
FOR i = ll_fields_cnt To 1 Step -1
	l_status = w_custom_report.tab_1.tabpage_columns.dw_view_fields.GetItemStatus(i, 0, Primary!)
	IF l_status = NewModified! THEN
		w_custom_report.tab_1.tabpage_columns.dw_view_fields.DeleteRow(i)
	END IF
NEXT
//restore deleted fields
w_custom_report.tab_1.tabpage_columns.dw_view_fields.RowsMove(1, w_custom_report.tab_1.tabpage_columns.dw_view_fields.DeletedCount(), DELETE!,w_custom_report.tab_1.tabpage_columns.dw_view_fields, 1, Primary!)
//remove the added tables
ll_table_cnt = w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowCount()
FOR i = ll_fields_cnt To 1 Step -1
	l_status = w_custom_report.tab_1.tabpage_tables.dw_view_tables.GetItemStatus(i, 0, Primary!)
	IF l_status = NewModified! THEN
		w_custom_report.tab_1.tabpage_tables.dw_view_tables.DeleteRow(i)
	END IF
NEXT
//restore deleted tables
w_custom_report.tab_1.tabpage_tables.dw_view_tables.RowsMove(1, w_custom_report.tab_1.tabpage_tables.dw_view_tables.DeletedCount(), DELETE!,w_custom_report.tab_1.tabpage_tables.dw_view_tables, 1, Primary!)
//restore deleted links
w_custom_report.tab_1.tabpage_tables.dw_view_links.RowsMove(1, w_custom_report.tab_1.tabpage_tables.dw_view_links.DeletedCount(), DELETE!,w_custom_report.tab_1.tabpage_tables.dw_view_links, 1, Primary!)

Close(Parent)


end event

type uo_1 from u_cst_report_selection within w_custom_report_selection
integer y = 16
integer width = 3922
integer taborder = 30
end type

on uo_1.destroy
call u_cst_report_selection::destroy
end on

