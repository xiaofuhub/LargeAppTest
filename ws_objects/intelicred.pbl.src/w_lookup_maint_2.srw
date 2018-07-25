$PBExportHeader$w_lookup_maint_2.srw
forward
global type w_lookup_maint_2 from w_main
end type
type dw_detail from u_dw within w_lookup_maint_2
end type
type gb_1 from groupbox within w_lookup_maint_2
end type
type dw_name from u_dw within w_lookup_maint_2
end type
type cb_new_lookup from u_cb within w_lookup_maint_2
end type
type cb_add from u_cb within w_lookup_maint_2
end type
type cb_delete from u_cb within w_lookup_maint_2
end type
type cb_save from u_cb within w_lookup_maint_2
end type
type cb_close from u_cb within w_lookup_maint_2
end type
type cb_sort from u_cb within w_lookup_maint_2
end type
type cb_filter from u_cb within w_lookup_maint_2
end type
type cb_print from u_cb within w_lookup_maint_2
end type
type cb_saveas from u_cb within w_lookup_maint_2
end type
type st_1 from statictext within w_lookup_maint_2
end type
type st_2 from statictext within w_lookup_maint_2
end type
type sle_change from singlelineedit within w_lookup_maint_2
end type
type cb_1 from u_cb within w_lookup_maint_2
end type
type cb_2 from u_cb within w_lookup_maint_2
end type
type cb_3 from u_cb within w_lookup_maint_2
end type
type dw_old_values from datawindow within w_lookup_maint_2
end type
end forward

global type w_lookup_maint_2 from w_main
integer x = 5
integer y = 312
integer width = 3657
integer height = 2072
string title = "Lookup Painter"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
dw_detail dw_detail
gb_1 gb_1
dw_name dw_name
cb_new_lookup cb_new_lookup
cb_add cb_add
cb_delete cb_delete
cb_save cb_save
cb_close cb_close
cb_sort cb_sort
cb_filter cb_filter
cb_print cb_print
cb_saveas cb_saveas
st_1 st_1
st_2 st_2
sle_change sle_change
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
dw_old_values dw_old_values
end type
global w_lookup_maint_2 w_lookup_maint_2

type variables
String is_lookup_name
String is_lookup_type

Boolean ib_new_table = False

Long il_lookup_code


end variables

event open;call super::open;dw_detail.of_SetTransObject(SQLCA)
dw_detail.InsertRow(0)
dw_detail.Enabled = False

dw_name.of_SetTransObject(SQLCA)
dw_name.InsertRow(0)

dw_name.SetFocus()
end event

on w_lookup_maint_2.create
int iCurrent
call super::create
this.dw_detail=create dw_detail
this.gb_1=create gb_1
this.dw_name=create dw_name
this.cb_new_lookup=create cb_new_lookup
this.cb_add=create cb_add
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_close=create cb_close
this.cb_sort=create cb_sort
this.cb_filter=create cb_filter
this.cb_print=create cb_print
this.cb_saveas=create cb_saveas
this.st_1=create st_1
this.st_2=create st_2
this.sle_change=create sle_change
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_old_values=create dw_old_values
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_detail
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_name
this.Control[iCurrent+4]=this.cb_new_lookup
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_delete
this.Control[iCurrent+7]=this.cb_save
this.Control[iCurrent+8]=this.cb_close
this.Control[iCurrent+9]=this.cb_sort
this.Control[iCurrent+10]=this.cb_filter
this.Control[iCurrent+11]=this.cb_print
this.Control[iCurrent+12]=this.cb_saveas
this.Control[iCurrent+13]=this.st_1
this.Control[iCurrent+14]=this.st_2
this.Control[iCurrent+15]=this.sle_change
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.cb_2
this.Control[iCurrent+18]=this.cb_3
this.Control[iCurrent+19]=this.dw_old_values
end on

on w_lookup_maint_2.destroy
call super::destroy
destroy(this.dw_detail)
destroy(this.gb_1)
destroy(this.dw_name)
destroy(this.cb_new_lookup)
destroy(this.cb_add)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_close)
destroy(this.cb_sort)
destroy(this.cb_filter)
destroy(this.cb_print)
destroy(this.cb_saveas)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_change)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_old_values)
end on

type dw_detail from u_dw within w_lookup_maint_2
integer x = 27
integer y = 788
integer width = 3063
integer height = 1096
integer taborder = 10
boolean bringtotop = true
boolean hscrollbar = true
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve(is_lookup_name)
end event

event constructor;This.of_SetSort(True)
This.inv_sort.of_SetStyle(3)
This.of_SetReqColumn(True)

This.inv_sort.of_SetColumnHeader(True)

end event

event pfc_preupdate;call super::pfc_preupdate;Boolean lb_updated = False
Integer i
Integer li_Rc
DateTime ldt_dt

li_rc = This.RowCount()

FOR i = 1 TO li_rc
	IF ( This.GetItemStatus( i, 0, Primary! ) = DataModified! OR This.GetItemStatus( i, 0, Primary! ) = NewModified! ) AND is_lookup_type = "A" THEN
		lb_updated = True
	END IF
END FOR


IF lb_updated = True THEN
	ldt_dt = DateTime( Today(), Now() )
	UPDATE ids SET lookup_cache = :ldt_dt;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF
	COMMIT USING SQLCA;
END IF

Return Success
end event

type gb_1 from groupbox within w_lookup_maint_2
integer x = 37
integer y = 28
integer width = 1979
integer height = 180
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select Lookup Table"
end type

type dw_name from u_dw within w_lookup_maint_2
integer x = 55
integer y = 92
integer width = 1417
integer height = 96
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_lookup_select"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetUpdateable(False)
end event

event itemchanged;call super::itemchanged;cb_add.Enabled = True
cb_saveas.Enabled = True
cb_delete.Enabled = True
cb_filter.Enabled = True
cb_sort.Enabled = True
cb_print.Enabled = True
cb_save.Enabled = True
String ls_lookup_type

IF Parent.Event pfc_save() < 0 THEN
	Return
END IF

Integer i, li_rc, currentrow, li_found

dw_detail.SetRedraw(False)

is_lookup_name = This.GetText()

datawindowchild dwchild
This.GetChild("lookup_name", dwchild)

li_found = dwchild.Find("lookup_name = '" + is_lookup_name + "'", 1, 1000)

IF li_found > 0 THEN
	ls_lookup_type = Upper(dwchild.GetItemString(li_found, "type"))	
	IF ls_lookup_type = "A" THEN
		is_lookup_type = "A"
		dw_detail.DataObject = "d_address_lookup"
	ELSE
		is_lookup_type = "C"
		dw_detail.DataObject = "d_code_lookup"
	END IF

	dw_detail.of_SetTransObject(SQLCA)

	dw_detail.Event pfc_Retrieve()

	dw_detail.ScrollToRow(1)
	dw_detail.SetRow(1)
END IF

dw_detail.SetFocus()

dw_detail.SetRedraw(True)

dw_detail.Enabled = True

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF
IF IsNull( il_lookup_code ) THEN
	il_lookup_code = 0
END IF

IF ls_lookup_type = "A" THEN
	dw_detail.GetChild( "state", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "state" )

	dw_detail.GetChild( "country", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( "country" )	
END IF
end event

event pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve()
end event

event pfc_update;call super::pfc_update;
Return 0
end event

type cb_new_lookup from u_cb within w_lookup_maint_2
integer x = 1481
integer y = 88
integer width = 489
integer height = 84
integer taborder = 140
boolean bringtotop = true
string text = "N&ew Lookup Table"
end type

event clicked;IF Parent.Event pfc_save() < 0 THEN
	Return
END IF

Open(w_get_lookup_name)

is_lookup_name = MidA(Message.StringParm,1, PosA(Message.StringParm, "-")-1)
is_lookup_type = MidA(Message.StringParm, PosA(Message.StringParm, "-") +1, 2)


IF Upper(is_lookup_type) = "A" THEN
	dw_detail.DataObject = "d_address_lookup"
ELSE
	dw_detail.DataObject = "d_code_lookup"
END IF

ib_new_table = True

dw_detail.of_SetTransObject(SQLCA)

dw_detail.Event pfc_Retrieve()

IF Upper(is_lookup_type) = "A" THEN
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM address_lookup  ;
ELSE
	 SELECT Max( lookup_code )  
    INTO :il_lookup_code  
    FROM code_lookup  ;
END IF
IF IsNull( il_lookup_code ) THEN
	il_lookup_code = 0
END IF

cb_add.Event Clicked()

dw_name.SetText(is_lookup_name)

dw_detail.SetFocus()

cb_add.Enabled = True
cb_saveas.Enabled = True
cb_delete.Enabled = True
cb_filter.Enabled = True
cb_print.Enabled = True
cb_sort.Enabled = True
cb_save.Enabled = True

end event

type cb_add from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 272
integer taborder = 120
boolean bringtotop = true
boolean enabled = false
string text = "&Add"
end type

event clicked;Integer li_row, li_lst_order

li_row = dw_detail.InsertRow(0)
dw_detail.SetRow(li_row)
dw_detail.ScrollToRow(li_row)
dw_detail.SetItem(li_row, "lookup_name", is_lookup_name)

il_lookup_code = gnv_app.of_get_id("LOOKUP")

dw_detail.SetItem(li_row, "lookup_code", il_lookup_code)

dw_detail.Enabled = True

dw_detail.SetFocus()
dw_detail.SetColumn(1)
	
end event

type cb_delete from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 380
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
string text = "&Delete"
end type

event clicked;
  
IF dw_detail.RowCount() = 1 THEN
	MessageBox("Delete Error", "You can not delete all of the rows from a lookup.  At least one row must be left in a lookup table.")
	Return
END IF
dw_detail.Event pfc_deleterow()

dw_detail.SetFocus()
end event

type cb_save from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 1012
integer taborder = 100
boolean bringtotop = true
boolean enabled = false
string text = "&Save"
end type

event clicked;Integer li_retval

li_retval = Parent.Event pfc_save()


IF ib_new_table THEN
	
	dw_name.Reset()
	dw_name.of_SetTransObject(SQLCA)
	dw_name.Retrieve()
     dw_name.InsertRow(0)
	dw_name.SetText(is_lookup_name)
	ib_new_table = False
	
END IF

dw_detail.SetFocus()
end event

type cb_close from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 1116
integer taborder = 90
boolean bringtotop = true
string text = "&Close"
end type

event clicked;Close(Parent)
end event

type cb_sort from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 540
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
string text = "So&rt"
end type

event clicked;dw_detail.Event pfc_SortDlg()

dw_detail.SetFocus()
end event

type cb_filter from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 648
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string text = "&Filter"
end type

event clicked;dw_detail.Event pfc_filterdlg()

dw_detail.SetFocus()
end event

type cb_print from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 756
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string text = "&Print"
end type

event clicked;dw_detail.Print()
end event

type cb_saveas from u_cb within w_lookup_maint_2
integer x = 3177
integer y = 864
integer taborder = 50
boolean bringtotop = true
boolean enabled = false
string text = "Save As..."
end type

event clicked;gnv_dw.of_SaveAs(dw_detail,"",text!,true)//.SaveAs( "", Text!, True ) Modify by Evan 05.11.2010
ChangeDirectory(gs_current_path) //For restore Directory   Added by Nova 04.29.2008


end event

type st_1 from statictext within w_lookup_maint_2
integer x = 37
integer y = 268
integer width = 247
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Old Value"
boolean focusrectangle = false
end type

type st_2 from statictext within w_lookup_maint_2
integer x = 1463
integer y = 264
integer width = 430
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Change To Value"
boolean focusrectangle = false
end type

type sle_change from singlelineedit within w_lookup_maint_2
integer x = 1458
integer y = 328
integer width = 727
integer height = 92
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_1 from u_cb within w_lookup_maint_2
integer x = 2418
integer y = 324
integer taborder = 40
boolean bringtotop = true
string text = "Change"
end type

type cb_2 from u_cb within w_lookup_maint_2
integer x = 1230
integer y = 328
integer width = 101
integer taborder = 30
boolean bringtotop = true
string text = "<--"
end type

event clicked;call super::clicked;Integer li_nr

li_nr = dw_old_values.InsertRow ( 0 )

dw_old_values.SetItem( li_nr, "lookup_code", dw_detail.GetItemNumber( dw_detail.GetRow(), "lookup_code" ) )
dw_old_values.SetItem( li_nr, "code", dw_detail.GetItemNumber( dw_detail.GetRow(), "code" ) )
dw_old_values.ScrollToRow( li_nr )
end event

type cb_3 from u_cb within w_lookup_maint_2
integer x = 2199
integer y = 324
integer width = 101
integer taborder = 20
boolean bringtotop = true
string text = "<--"
end type

event clicked;call super::clicked;sle_change.Text = String( dw_detail.GetItemNumber( dw_detail.GetRow(), "lookup_code" ) )
end event

type dw_old_values from datawindow within w_lookup_maint_2
integer x = 41
integer y = 324
integer width = 1166
integer height = 440
integer taborder = 120
boolean bringtotop = true
string dataobject = "d_old_values"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

