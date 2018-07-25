$PBExportHeader$pfc_cst_u_data_entry_profile_painter.sru
forward
global type pfc_cst_u_data_entry_profile_painter from pfc_cst_u_data_entry
end type
type sle_1 from singlelineedit within tabpage_details
end type
type tabpage_preview from userobject within tab_view
end type
type dw_preview from u_dw within tabpage_preview
end type
type tabpage_preview from userobject within tab_view
dw_preview dw_preview
end type
type dw_screen_objects from u_dw within pfc_cst_u_data_entry_profile_painter
end type
type dw_properties from u_dw within pfc_cst_u_data_entry_profile_painter
end type
type cb_screen_properties from u_cb within pfc_cst_u_data_entry_profile_painter
end type
type sle_tab from singlelineedit within pfc_cst_u_data_entry_profile_painter
end type
type st_tab from statictext within pfc_cst_u_data_entry_profile_painter
end type
type cb_1 from commandbutton within pfc_cst_u_data_entry_profile_painter
end type
type cb_2 from commandbutton within pfc_cst_u_data_entry_profile_painter
end type
end forward

global type pfc_cst_u_data_entry_profile_painter from pfc_cst_u_data_entry
integer height = 1700
event ue_field_properties ( )
event pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
dw_screen_objects dw_screen_objects
dw_properties dw_properties
cb_screen_properties cb_screen_properties
sle_tab sle_tab
st_tab st_tab
cb_1 cb_1
cb_2 cb_2
end type
global pfc_cst_u_data_entry_profile_painter pfc_cst_u_data_entry_profile_painter

type variables
String is_tab_label_names[]
String is_last_tab_label_name
String is_last_object[]
String is_last_border[]
String is_option = "Move"
String is_object_list[]
String is_last_object_width
String is_last_object_height

u_dw idw_detail 

Boolean ib_resize_width = False
Boolean ib_resize_height = False
Boolean ib_mouse_down
Boolean ib_multi_select = False
Boolean ib_control_down = False
Boolean ib_relocating_fields = False
Boolean ib_set_tab_order = False
Boolean ib_show_invisible = True


Integer li_flags
Integer ii_obj_select_cnt = 0
Integer ii_field_id[]
Integer ii_tab_sequence
Integer ii_row_to_move = 0


Long il_last_object_width[]
Long il_last_object_height[]
Long il_ancor_x
Long il_ancor_y
Long il_data_view_id = 1
Long il_last_object_x[]
Long il_last_object_y[]


Long il_dw_scroll_pos = 0

end variables

forward prototypes
public function integer of_pre_pfc_save ()
public function integer of_property_sheet ()
public function integer of_refresh_properties_dw ()
public function integer of_setup_painter ()
public function integer of_select_view ()
public function integer of_show_invisible (boolean ab_show)
public function integer of_set_tab_order (boolean ab_status)
public function integer of_select_screen (integer currentrow, integer ai_screen_id)
public function integer of_set_parent_window (w_prac_profile_design aw_win)
end prototypes

event ue_field_properties;of_property_sheet()
end event

event pfc_cst_select_view;of_select_view()
end event

event pfc_cst_new_screen_painter;Open( w_new_screen_painter )
end event

public function integer of_pre_pfc_save ();Integer i
Integer li_col_cnt
Integer li_field_order
String ls_field_nm
String ls_field_x
String ls_obj_name
String ls_retval

IF ib_relocating_fields THEN
	Return 0
END IF

dw_properties.SetFilter("")
dw_properties.Filter()

dw_properties.AcceptText()

li_col_cnt = dw_properties.RowCount()

idw_detail = dw_detail

IF idw_detail.RowCount() = 0 THEN
	RETURN 0 
END IF

FOR i = 1 TO li_col_cnt
	ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
	ls_field_x = idw_detail.Describe( ls_field_nm + ".x" )
	dw_properties.SetItem(i, "data_view_fields_field_x", Integer(idw_detail.Describe( ls_field_nm + ".x" )) )
	dw_properties.SetItem(i, "data_view_fields_field_y", Integer(idw_detail.Describe( ls_field_nm + ".y" )) )

	ls_retval = MidA(idw_detail.Describe( ls_field_nm + "_t.text" ) , 1, 5000)
	dw_properties.SetItem(i, "data_view_fields_field_label", ls_retval )
	
	dw_properties.SetItem(i, "data_view_fields_field_label_x", Integer(idw_detail.Describe( ls_field_nm + "_t.x" )) )
	dw_properties.SetItem(i, "data_view_fields_field_label_y", Integer(idw_detail.Describe( ls_field_nm + "_t.y" )) )
	
	dw_properties.SetItem(i, "data_view_fields_justification", Integer(idw_detail.Describe( ls_field_nm + ".alignment" )) )
		
	dw_properties.SetItem(i, "data_view_fields_field_width", Integer(idw_detail.Describe( ls_field_nm + ".width" )) )	

	dw_properties.SetItem(i, "data_view_fields_field_height", Integer(idw_detail.Describe( ls_field_nm + ".height" )) )	

	dw_properties.SetItem(i, "data_view_fields_field_label_width", Integer(idw_detail.Describe( ls_field_nm + "_t.width" )) )	

	dw_properties.SetItem(i, "data_view_fields_label_justification", Integer(idw_detail.Describe( ls_field_nm + "_t.alignment" )) )	
//messagebox("", ls_field_nm + "_t.font.weight" )	
	dw_properties.SetItem(i, "data_view_fields_font_wieght", Integer(idw_detail.Describe( ls_field_nm + "_t.font.weight" )) )		

	dw_properties.SetItem(i, "data_view_fields_field_underline", Integer(idw_detail.Describe( ls_field_nm + ".font.underline" )) )
	dw_properties.SetItem(i, "data_view_fields_label_underline", Integer(idw_detail.Describe( ls_field_nm + "_t.font.underline" )) )		
	
	li_field_order =  Integer(idw_detail.Describe( ls_field_nm + ".dbname" ))
	
	IF li_field_order > 0 THEN
		dw_properties.SetItem(i, "data_view_fields_field_order", li_field_order )	
	END IF
END FOR

dw_properties.SetSort( "data_view_fields_field_order" )
dw_properties.Sort()
dw_properties.SetFilter( "data_view_fields_visible='Y'" )
dw_properties.Filter()
li_col_cnt = dw_properties.RowCount()

FOR i = 1 TO li_col_cnt
	dw_properties.SetItem( i, "data_view_fields_field_order", i * 10 )
	ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
	dw_detail.Modify( ls_field_nm + ".dbname = '" + String(i * 10) + "'" )
END FOR

dw_properties.SetFilter( "" )
dw_properties.Filter()


dw_screen_objects.AcceptText()

li_col_cnt = dw_screen_objects.RowCount()

FOR i = 1 TO li_col_cnt
	ls_obj_name = "object" + String(dw_screen_objects.GetItemNumber(i, "data_view_object_id" ) )
	ls_retval = idw_detail.Describe( ls_obj_name + ".x" ) 
	IF ls_retval = "!" THEN
		ls_obj_name = ls_obj_name + "_t"
	END IF
	//messagebox("", Integer(idw_detail.Describe( ls_obj_name + "font.weight" )) )
	dw_screen_objects.SetItem(i, "object_x", Integer(idw_detail.Describe( ls_obj_name + ".x" )))
	dw_screen_objects.SetItem(i, "object_y", Integer(idw_detail.Describe( ls_obj_name + ".y" )))
	dw_screen_objects.SetItem(i, "object_width", Integer(idw_detail.Describe( ls_obj_name + ".width" )))
	dw_screen_objects.SetItem(i, "object_height", Integer(idw_detail.Describe( ls_obj_name + ".height" )))
	dw_screen_objects.SetItem(i, "object_bold", Integer(idw_detail.Describe( ls_obj_name + ".font.weight" )))
	//messagebox("",  ls_obj_name + "font.italic"  )
	dw_screen_objects.SetItem(i, "object_italic", Integer(idw_detail.Describe( ls_obj_name + ".font.italic" )))	
	ls_retval = idw_detail.Describe( ls_obj_name + ".text" )
	dw_screen_objects.SetItem(i, "object_text", ls_retval)
	dw_screen_objects.SetItem(i, "object_alignment", Integer(idw_detail.Describe( ls_obj_name + ".alignment" )))
END FOR


COMMIT USING SQLCA;

string dwsyntax, ErrorBuffer

integer rtncode

dwsyntax = dw_detail.Describe("DataWindow.Syntax")
//rtncode = LibraryImport( "c:\intellicred\custom_reports.pbl", +&
//			"d_" + dw_select_section.GetItemString( dw_select_section.GetRow(), "screen_alias" ) + "_" + String( il_data_view_id) , +&
//			ImportDataWindow!, dwsyntax, ErrorBuffer )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<comment> 01.13.2006 By: Cao YongWang
//$<reason> LibraryImport is currently unsupportted.
//$<modification> Comment out the following script.
//rtncode = LibraryImport( "c:\intellicred\custom_reports.pbl", "d_jad", ImportDataWindow!, dwsyntax, ErrorBuffer )
//---------------------------- APPEON END ----------------------------

//MessageBox("",errorbuffer )



RETURN 1
end function

public function integer of_property_sheet ();String ls_field_id

IF UpperBound( is_last_object[] ) = 0 THEN
	MessageBox("Select", "You must first select a field by clicking on it." )
	RETURN -1
END IF

IF IsNull( is_last_object[1] ) OR is_last_object[1] = "" THEN
	MessageBox("Select", "You must first select a field by clicking on it." )
	RETURN -1
END IF

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )

dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
dw_properties.Filter()

IF NOT IsValid(w_field_properties) THEN
	Open(w_field_properties)
END IF

Return 0
end function

public function integer of_refresh_properties_dw ();dw_properties.Update()
dw_properties.Retrieve( il_data_view_id, ii_screen_id )

Return 1
end function

public function integer of_setup_painter ();idw_detail = dw_detail

ib_setup_dddw = False


 
Integer i
Integer li_col_cnt
Integer li_sys_col_cnt
Integer li_dv_col_cnt
String ls_col_name
String ls_sys_cols
String ls_data_view_cols
String ls_sys_fields_update[]
String ls_dv_fields_update[]
String  ls_sys_key_cols[ ] = {"sys_fields_table_id", "sys_fields_field_id"}
String  ls_dv_key_cols[ ] = {"data_view_fields_data_view_id", "data_view_fields_screen_id", "data_view_fields_field_id"}

dw_properties.of_SetMultiTable(TRUE)

dw_properties.of_SetUpdateable(True)

li_col_cnt = Integer( dw_properties.Object.DataWindow.Column.Count )

FOR i = 1 TO li_col_cnt
	
	dw_properties.SetColumn( i )
	ls_col_name = dw_properties.GetColumnName()
	IF Upper(MidA(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(MidA(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
		li_dv_col_cnt ++
		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
	END IF
	
END FOR

li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_label_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_label_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_field_height"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_fields_font_wieght"


dw_properties.inv_multitable.of_Register( "sys_fields", ls_sys_key_cols , ls_sys_fields_update, TRUE, 0)
dw_properties.inv_multitable.of_Register( "data_view_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)

This.Height = This.Height - 204
This.y = 190


Return 0



end function

public function integer of_select_view ();String ls_data_view_name

Open( w_select_profile_view )
IF Message.StringParm = "Cancel" THEN
	Return -1
ELSE
	IF parent_window_profile_design.Event pfc_save() < 0 THEN
		Return -1
	END IF
	This.SetRedraw( False )
	il_data_view_id = Message.DoubleParm
   SELECT data_view.data_view_name  
   INTO :ls_data_view_name  
   FROM data_view  
   WHERE data_view.data_view_id = :il_data_view_id   ;
	parent_window_profile_design.Title = "Screen Painter ( " + ls_data_view_name + " )"
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( il_data_view_id )
	dw_select_section.SetRow( 1 )
	dw_select_section.ScrollToRow( 1 )
	dw_select_section.SelectRow( 1, True )
	This.SetRedraw( True )	
END IF

Return 0
end function

public function integer of_show_invisible (boolean ab_show);Integer li_rc
Integer i
String ls_fld

dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 TO li_rc
	IF dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		CONTINUE
	END IF
	ls_fld = dw_properties.GetItemString( i, "sys_fields_field_name" )
	IF NOT ab_show THEN
		dw_detail.Modify( ls_fld + ".Visible = 1")	
		dw_detail.Modify( ls_fld + "_t.Visible = 1")	
	ELSE
		dw_detail.Modify( ls_fld + ".Visible = 0")	
		dw_detail.Modify( ls_fld + "_t.Visible = 0")			
	END IF
END FOR

RETURN 1
end function

public function integer of_set_tab_order (boolean ab_status);Integer i
Integer li_column_cnt
Integer li_col_width
Integer li_cnt
Long ll_col_x
Long ll_col_y
String ls_bc 
String ls_col_nm
String ls_tab_nm
String ls_tab_x
String ls_tab_y
String ls_tab_order


ib_set_tab_order = ab_status

IF ab_status THEN
	st_tab.Visible = True
	cb_screen_properties.Enabled = False
	dw_select_section.Enabled = False
	sle_tab.Text = ""
	li_column_cnt = Integer(dw_detail.Describe("DataWindow.Column.Count"))
	sle_tab.Visible = True
	FOR i = 1 TO li_column_cnt
		ls_bc = dw_detail.Describe("#" + String( i ) + ".Background.Color")
		ls_col_nm = dw_detail.Describe("#" + String( i ) + ".Name")
		ls_tab_nm = "tab_" + ls_col_nm
		ll_col_x = Long( dw_detail.Describe("#" + String( i ) + ".x") )
		li_col_width = Long( dw_detail.Describe("#" + String( i ) + ".Width") )
		ll_col_y = Long(dw_detail.Describe("#" + String( i ) + ".y"))
		ll_col_y = ll_col_y - 60
		ls_tab_y = String(ll_col_y)
		ls_tab_x = String( ll_col_x + li_col_width - 60)
		IF ls_bc = "16777215" THEN
			ls_tab_order = idw_detail.Describe( ls_col_nm + ".dbname" )			

			dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm  +")" )

			is_tab_label_names[ i ] = ls_tab_nm
			li_cnt ++
			IF ls_tab_order = "10" THEN
				is_last_tab_label_name = ls_tab_nm
				sle_tab.x = Long( ls_tab_x ) + dw_detail.x 
				sle_tab.y = Long( ls_tab_y ) + dw_detail.y 
				sle_tab.SetFocus()
				sle_tab.BringToTop = True
				sle_tab.Text = ls_tab_order
				sle_tab.SelectText( 1, 100 )
			END IF			
		END IF
	END FOR
ELSE
	dw_detail.Modify( MidA( is_last_tab_label_name, 5, 100 ) + ".dbname = '" + sle_tab.Text + "'" )		
	li_column_cnt = UpperBound( is_tab_label_names )
	FOR i = 1 TO li_column_cnt
		dw_detail.Modify( "Destroy " + is_tab_label_names[i] )
	END FOR
	sle_tab.Text = ""
	sle_tab.Visible = False
	of_pre_pfc_save()
	st_tab.Visible = False
	cb_screen_properties.Enabled = True
	dw_select_section.Enabled = True
END IF

RETURN 0	
end function

public function integer of_select_screen (integer currentrow, integer ai_screen_id);
String ls_screen_name
Integer li_col_cnt
Integer i
Integer li_cnt
Integer li_row_cnt

IF ib_refresh_screen_list = True THEN
	Return 1
END IF

app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()
	
SetRedraw( False )

IF currentrow < 1 THEN
	Return 1
END IF

IF w_design_profile_menu.st_tab_order.BorderStyle = StyleLowered! THEN
	of_set_tab_order( False )
	w_design_profile_menu.st_tab_order.TriggerEvent( Clicked! )
END IF

//tab_view.tabpage_image.Visible = False
//IF dw_select_section.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = dw_select_section.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	tab_view.tabpage_image.Visible = True
//END IF

tab_view.tabpage_image.Visible = False
IF dw_select_section.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
	tab_view.tabpage_image.Visible = True	
END IF

inv_data_entry.of_create_dynamic_profile_dw(il_prac_id, il_data_view_id, ai_screen_id, dw_detail, dw_browse, True, 0 )

dw_browse.Visible = False
dw_detail.BringToTop = True
dw_detail.Visible = True

dw_select_section.SelectRow(0, False)
dw_select_section.SelectRow( currentrow, True)

IF ib_refresh_screen_list = True THEN
	SetRedraw( True )
	Return 1
END IF

//ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 

dw_properties.Retrieve( il_data_view_id, ii_screen_id )

li_row_cnt = dw_properties.RowCount( )

dw_screen_objects.Reset()
dw_screen_objects.of_SetTransObject(SQLCA)
dw_screen_objects.Retrieve( il_data_view_id, ii_screen_id )

//messagebox("row count", li_row_cnt )

li_col_cnt = Integer( dw_detail.Object.DataWindow.Column.Count )

FOR i = 1 TO li_col_cnt
	dw_detail.SetColumn(i)
	is_object_list[i] = dw_detail.GetColumnName()
	dw_detail.SetTabOrder(i, 0 )
END FOR

FOR i = li_col_cnt+1 TO (li_col_cnt * 2)
	li_cnt++
	is_object_list[i] = is_object_list[li_cnt] + "_t"
END FOR

ls_screen_name = dw_select_section.GetItemString( currentrow, "screen_name" )

IF ls_screen_name = "Address" OR ls_screen_name = "Claims" THEN
	dw_detail.vscrollbar = True
ELSE
	dw_detail.vscrollbar = False
END IF

of_show_invisible( ib_show_invisible )

SetRedraw( True )

Return 1
end function

public function integer of_set_parent_window (w_prac_profile_design aw_win);parent_window_profile_design = aw_win

Return 0
end function

on pfc_cst_u_data_entry_profile_painter.create
int iCurrent
call super::create
this.dw_screen_objects=create dw_screen_objects
this.dw_properties=create dw_properties
this.cb_screen_properties=create cb_screen_properties
this.sle_tab=create sle_tab
this.st_tab=create st_tab
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_screen_objects
this.Control[iCurrent+2]=this.dw_properties
this.Control[iCurrent+3]=this.cb_screen_properties
this.Control[iCurrent+4]=this.sle_tab
this.Control[iCurrent+5]=this.st_tab
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_2
end on

on pfc_cst_u_data_entry_profile_painter.destroy
call super::destroy
destroy(this.dw_screen_objects)
destroy(this.dw_properties)
destroy(this.cb_screen_properties)
destroy(this.sle_tab)
destroy(this.st_tab)
destroy(this.cb_1)
destroy(this.cb_2)
end on

type dw_addresses from pfc_cst_u_data_entry`dw_addresses within pfc_cst_u_data_entry_profile_painter
integer taborder = 100
end type

type st_recs from pfc_cst_u_data_entry`st_recs within pfc_cst_u_data_entry_profile_painter
end type

type dw_ver_data from pfc_cst_u_data_entry`dw_ver_data within pfc_cst_u_data_entry_profile_painter
integer y = 1272
integer taborder = 120
end type

type dw_select_section from pfc_cst_u_data_entry`dw_select_section within pfc_cst_u_data_entry_profile_painter
integer x = 23
integer y = 20
integer width = 741
integer height = 1572
end type

event dw_select_section::clicked;call super::clicked;Integer li_row
Integer li_order


IF ii_row_to_move > 0 THEN
	li_row = This.GetClickedRow()
	li_order = This.GetItemNumber( li_row, "screen_painter_order" )
	li_order = li_order + 5

	This.Setitem( ii_row_to_move, "screen_order", li_order )
	This.Setitem( ii_row_to_move, "screen_painter_order", li_order )
	This.Sort()

	ii_row_to_move = 0
END IF
end event

event dw_select_section::retrieveend;call super::retrieveend;Integer i

FOR i = 1 TO rowcount
	IF This.GetItemNumber( i, "screen_order" ) = 0 THEN
		This.SetItem( i, "screen_painter_order", 9999 )
	END IF
END FOR

This.Sort()


end event

event dw_select_section::rowfocuschanged;//Long ll_screen_id
//String ls_screen_name
//Integer li_col_cnt
//Integer i
//Integer li_cnt
//Integer li_row_cnt
//
//IF ib_refresh_screen_list = True THEN
//	Return
//END IF
//
//Parent.SetRedraw( False )
//
//IF currentrow < 1 THEN
//	Return
//END IF
//
//IF w_design_menu.st_tab_order.BorderStyle = StyleLowered! THEN
//	of_set_tab_order( False )
//	w_design_menu.st_tab_order.TriggerEvent( Clicked! )
//END IF
//
////tab_view.tabpage_image.Visible = False
////IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
////	ll_detail_2_screen_id = This.GetItemNumber( currentrow, "table_id_2" ) 
////	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id )	
////	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
////	tab_view.tabpage_image.Visible = True
////END IF
//
//tab_view.tabpage_image.Visible = False
//IF This.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	tab_view.tabpage_image.Visible = True	
//END IF
//
//ll_screen_id = This.GetItemNumber( currentrow, "screen_id" )
//
//inv_data_entry.of_create_dynamic_dw(il_prac_id, il_data_view_id, ll_screen_id, dw_detail, dw_browse, True, 0 )
//
//dw_browse.Visible = False
//dw_detail.BringToTop = True
//dw_detail.Visible = True
//
//This.SelectRow(0, False)
//This.SelectRow( currentrow, True)
//
//IF ib_refresh_screen_list = True THEN
//	Parent.SetRedraw( True )
//	Return
//END IF
//
//ii_screen_id = This.GetItemNumber(currentrow, "screen_id") 
//
//li_row_cnt = dw_properties.Retrieve( il_data_view_id, ii_screen_id )
//
//dw_screen_objects.Reset()
//dw_screen_objects.of_SetTransObject(SQLCA)
//dw_screen_objects.Retrieve( il_data_view_id, ii_screen_id )
//
//li_col_cnt = Integer( dw_detail.Object.DataWindow.Column.Count )
//
//FOR i = 1 TO li_col_cnt
//	dw_detail.SetColumn(i)
//	is_object_list[i] = dw_detail.GetColumnName()
//	dw_detail.SetTabOrder(i, 0 )
//END FOR
//
//FOR i = li_col_cnt+1 TO (li_col_cnt * 2)
//	li_cnt++
//	is_object_list[i] = is_object_list[li_cnt] + "_t"
//END FOR
//
//ls_screen_name = This.GetItemString( currentrow, "screen_name" )
//
//IF ls_screen_name = "Address" OR ls_screen_name = "Claims" THEN
//	dw_detail.vscrollbar = True
//ELSE
//	dw_detail.vscrollbar = False
//END IF
//
//of_show_invisible( ib_show_invisible )
//
//Parent.SetRedraw( True )
//

//ll_screen_id = dw_select_section.GetItemNumber( currentrow, "screen_id" )

IF currentrow = 0 THEN
	Return
END IF
ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 

of_select_screen( currentrow, ii_screen_id )

//IF inv_data_entry.ib_vscroll THEN
dw_detail.vscrollbar = True
//END IF

end event

event dw_select_section::rowfocuschanging;Integer li_move_to_screen_id
Integer i
Integer li_y
Integer li_move_fld_cnt
Integer li_found

IF ib_relocating_fields = True THEN
	li_move_to_screen_id = This.GetItemNumber( newrow, "screen_id" )
	li_move_fld_cnt = UpperBound(ii_field_id[])
	FOR i = 1 TO li_move_fld_cnt
		li_y = i * 100
		UPDATE data_view_fields  
	 	   	SET screen_id = :li_move_to_screen_id,
			 field_x = 2000,
			 field_y = :li_y,
			 field_label_x = 1700,
			 field_label_y = :li_y
	   WHERE ( data_view_fields.data_view_id = :il_data_view_id ) AND  
   	      ( data_view_fields.screen_id = :ii_screen_id ) AND  
      	   ( data_view_fields.field_id = :ii_field_id[i] )   ;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
			Return 1
		END IF
		COMMIT USING SQLCA;
	END FOR	
	dw_properties.Retrieve(il_data_view_id, ii_screen_id)
	inv_data_entry.of_create_dynamic_profile_dw(il_prac_id, il_data_view_id, ii_screen_id, dw_detail, dw_browse, True, 0 )	
	IF dw_detail.RowCount() = 0 THEN
		dw_detail.InsertRow(0)
	END IF
	ib_relocating_fields = False
	w_design_menu.st_relocate_field.BorderStyle = StyleRaised!
	Return 1
END IF


end event

type dw_link_list from pfc_cst_u_data_entry`dw_link_list within pfc_cst_u_data_entry_profile_painter
integer taborder = 60
end type

type dw_detail from pfc_cst_u_data_entry`dw_detail within pfc_cst_u_data_entry_profile_painter
event ue_down_key pbm_dwnkey
event ue_mouse_move pbm_dwnmousemove
integer y = 44
integer height = 1512
integer taborder = 90
boolean bringtotop = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = true
end type

event dw_detail::ue_down_key;Integer li_y_pos
Integer li_x_pos
Integer li_x1_pos
Integer li_x2_pos
Integer li_y1_pos
Integer li_y2_pos
Integer li_obj_x1_pos
Integer li_obj_x2_pos
Integer li_obj_y1_pos
Integer li_obj_y2_pos
Integer li_pixels = 4
Integer i
Integer li_cnt
Integer li_obj_cnt


IF KeyDown( KeyEnter! ) OR KeyDown( KeyTab!) THEN
	Return -1
END IF
//w_prac_data_design.TITLE = STRING(keyflags)

IF keyflags = 2 THEN
	IF KeyDown( KeyDownArrow! ) OR KeyDown( KeyUpArrow! )THEN
		li_x1_pos = Integer( This.Describe( is_last_object[1] + ".x" )) -25
		li_x2_pos = li_x1_pos + Integer( This.Describe( is_last_object[1] + ".width" ) ) + 25

		li_y1_pos = Integer( This.Describe( is_last_object[1] + ".y" )) 
		
		//il_ancor_x = Integer( This.Describe( is_last_object[1] + ".x" ))
		//il_ancor_y = Integer( This.Describe( is_last_object[1] + ".y"))
		li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2
		FOR i = 1 TO li_obj_cnt
			IF is_last_object[1] = is_object_list[i] THEN
				CONTINUE
			END IF
			li_obj_x1_pos = Integer( This.Describe( is_object_list[i] + ".x" ) )
			li_obj_x2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".width" ) )

			li_obj_y1_pos = Integer( This.Describe( is_object_list[i] + ".y" ) )
			li_obj_y2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".height" ) )
			
			IF (li_obj_x1_pos >= li_x1_pos AND li_obj_x1_pos <= li_x2_pos) OR (li_obj_x2_pos <= li_x1_pos AND li_obj_x2_pos >= li_x1_pos) THEN
			   IF key = KeyDownArrow! AND (li_obj_y1_pos < li_y1_pos) THEN
					CONTINUE
				END IF
			   IF key = KeyUpArrow! AND (li_obj_y1_pos > li_y1_pos) THEN
					CONTINUE
				END IF		
				ii_obj_select_cnt ++
				is_last_object[ii_obj_select_cnt] = is_object_list[i]
				il_last_object_x[ii_obj_select_cnt] = li_obj_x1_pos
				il_last_object_y[ii_obj_select_cnt] = li_obj_y1_pos				
				This.Modify( is_last_object[ii_obj_select_cnt] + ".border = '2'" )				
				IF ii_obj_select_cnt > 1 THEN
					ib_multi_select = True
				END IF
			END IF
		END FOR
	ELSEIF KeyDown( KeyRightArrow! ) OR KeyDown( KeyLeftArrow! ) THEN		
		
		li_x1_pos = Integer( This.Describe( is_last_object[1] + ".x" )) 

		li_y1_pos = Integer( This.Describe( is_last_object[1] + ".y" ) ) - 20
		li_y2_pos = li_y1_pos + Integer( This.Describe( is_last_object[1] + ".height" ) ) + 20

		
		li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2
		FOR i = 1 TO li_obj_cnt
			IF is_last_object[1] = is_object_list[i] THEN
				CONTINUE
			END IF
			li_obj_x1_pos = Integer( This.Describe( is_object_list[i] + ".x" ) )
			li_obj_x2_pos = li_obj_x1_pos + Integer( This.Describe( is_object_list[i] + ".width" ) )

			li_obj_y1_pos = Integer( This.Describe( is_object_list[i] + ".y" ) )
			li_obj_y2_pos = li_obj_y1_pos + Integer( This.Describe( is_object_list[i] + ".height" ) )
			
			IF (li_obj_y1_pos >= li_y1_pos AND li_obj_y1_pos <= li_y2_pos) OR (li_obj_y2_pos <= li_y1_pos AND li_obj_y2_pos >= li_y1_pos) THEN
			   IF key = KeyRightArrow! AND (li_obj_x1_pos < li_x1_pos) THEN
					CONTINUE
				END IF
			   IF key = KeyLeftArrow! AND (li_obj_x1_pos > li_x1_pos) THEN
					CONTINUE
				END IF		
				ii_obj_select_cnt ++
				il_last_object_x[ii_obj_select_cnt] = li_obj_x1_pos
				il_last_object_y[ii_obj_select_cnt] = li_obj_y1_pos								
				is_last_object[ii_obj_select_cnt] = is_object_list[i]
				This.Modify( is_last_object[ii_obj_select_cnt] + ".border = '2'" )				
				IF ii_obj_select_cnt > 1 THEN
					ib_multi_select = True
				END IF
			END IF
		END FOR
		
		
	END IF
END IF

IF PosA(is_option, "Move") > 0 THEN
	FOR i = 1 TO ii_obj_select_cnt
		ib_mouse_down = False
		IF KeyDown( KeyUpArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".y" ) )
			li_y_pos = li_y_pos - li_pixels
			This.Modify( is_last_object[i] + ".y = '" + String( li_y_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_fields_field_y", li_y_pos )		
		ELSEIF KeyDown( KeyDownArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".y" ) )
			li_y_pos = li_y_pos + li_pixels
			This.Modify( is_last_object[i] + ".y = '" + String( li_y_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_fields_field_y", li_y_pos )		
		ELSEIF KeyDown( KeyRightArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos + li_pixels
			This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_fields_field_x", li_x_pos )
		ELSEIF KeyDown( KeyLeftArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos - li_pixels
			This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_fields_field_x", li_x_pos )		
		END IF
	END FOR

ELSEIF is_option = "Size" THEN
	FOR i = 1 TO ii_obj_select_cnt
		IF KeyDown( KeyLeftArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".width" ) )
			li_y_pos = li_y_pos - 10
			This.Modify( is_last_object[i] + ".width = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyRightArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".width" ) )
			li_y_pos = li_y_pos + 10
			This.Modify( is_last_object[i] + ".width = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyUpArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".height" ) )
			li_y_pos = li_y_pos - 10
			This.Modify( is_last_object[i] + ".height = '" + String( li_y_pos ) + "'" )
		ELSEIF KeyDown( KeyDownArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".height" ) )
			li_y_pos = li_y_pos + 10
			This.Modify( is_last_object[i] + ".height = '" + String( li_y_pos ) + "'" )
		END IF	
		
		dw_properties.SetItem(1, "data_view_fields_field_width", li_y_pos )
	END FOR
END IF

w_design_profile_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])

end event

event dw_detail::ue_mouse_move;Integer i
String ls_field_id
Long ll_x
Long ll_new_width
Long ll_y
Long ll_orig_x
Long ll_orig_y
Long ll_y_diff
Long ll_x_diff
Long ll_new_height
Long ll_curr_scroll_pos


IF ii_obj_select_cnt = 0 OR ib_set_tab_order THEN
	RETURN
END IF

IF NOT ib_resize_height AND NOT ib_resize_width AND ib_mouse_down AND LenA(is_last_object[ii_obj_select_cnt]) > 0 AND is_last_object[ii_obj_select_cnt] <> "dw" AND is_option = "Move" AND	ib_control_down = False THEN		
	SetPointer(Cross!)
	ll_y_diff = (This.Pointery() - il_last_object_y[1] ) + (il_last_object_y[1] - il_ancor_y )
	ll_x_diff = (This.Pointerx() - il_last_object_x[1] ) + (il_last_object_x[1] - il_ancor_x )

	FOR i = 1 TO ii_obj_select_cnt
		ll_y = il_last_object_y[i] + ll_y_diff 
		ll_x = il_last_object_x[i] + ll_x_diff
		idw_detail.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )
		IF RightA( is_last_object[i], 2 ) = "_t" THEN
			dw_properties.SetItem(1, "data_view_fields_field_label_y", ll_y) 
		ELSEIF PosA( is_last_object[1], "obj" ) = 0 THEN
			dw_properties.SetItem(1, "data_view_fields_field_y", ll_y) 
		END IF		
		IF is_last_object[1] <> "detail_band" THEN
			idw_detail.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
			IF RightA( is_last_object[i], 2 ) = "_t" THEN
				dw_properties.SetItem(1, "data_view_fields_field_label_x", ll_x) 
			ELSEIF PosA( is_last_object[i], "obj" ) = 0 THEN
				dw_properties.SetItem(1, "data_view_fields_field_x", ll_x) 
			END IF	
		END IF
	END FOR
ELSEIF (This.Pointerx() > il_last_object_x[1] + il_last_object_width[1] - 20) AND (This.Pointerx() < il_last_object_x[1] + il_last_object_width[1]-2) THEN
	Ib_resize_width = True
	SetPointer(SizeWE!)
ELSEIF (This.Pointery() > il_last_object_y[1] + il_last_object_height[1] - 10) AND (This.PointerY() < il_last_object_y[1] + il_last_object_height[1]-2) THEN
	Ib_resize_height = True
	SetPointer(SizeNS!)
ELSEIF ib_resize_width AND ib_mouse_down THEN
	SetPointer(SizeWE!)
	ll_x_diff = Pointerx() - (il_last_object_x[1] + il_last_object_width[1])
	ll_new_width = il_last_object_width[1] + ll_x_diff
	il_last_object_width[1] = ll_new_width
	idw_detail.Modify( is_last_object[1] + ".width = '" + String( ll_new_width ) + "'" )
	IF RightA( is_last_object[1], 2 ) = "_t" THEN
		dw_properties.SetItem(1, "data_view_fields_field_label_width", ll_new_width) 
	ELSEIF PosA( is_last_object[1], "obj" ) = 0 THEN
		dw_properties.SetItem(1, "data_view_fields_field_width", ll_new_width) 
	END IF		
ELSEIF ib_resize_height AND ib_mouse_down THEN
	SetPointer(SizeNS!)
	ll_y_diff = Pointery() - (il_last_object_y[1] + il_last_object_height[1])
	ll_new_height = il_last_object_height[1] + ll_y_diff
	il_last_object_height[1] = ll_new_height
	idw_detail.Modify( is_last_object[1] + ".height = '" + String( ll_new_height ) + "'" )
	IF RightA( is_last_object[1], 2 ) <> "_t" AND	PosA( is_last_object[1], "obj" ) = 0 THEN
		dw_properties.SetItem(1, "data_view_fields_field_height", ll_new_height) 
	END IF			
ELSE
	Ib_resize_width = False
	Ib_resize_height = False
END IF

w_design_profile_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
   								"  Y:" + String(il_last_object_y[1]) +&
	   							"  Width:" + String(il_last_object_width[1]) +&
		   						"  Height:" + String(il_last_object_height[1])
									
									


end event

event dw_detail::constructor;call super::constructor;This.of_SetUpdateable(False)
This.of_SetReqColumn(TRUE)


end event

event dw_detail::lbuttondown;call super::lbuttondown;ib_mouse_down = True
Integer i
Integer li_found = 0
String ls_selected_object

IF flags <> 9 AND ib_multi_select THEN
	ls_selected_object = This.GetObjectAtPointer()
	ls_selected_object = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )
	FOR i = 1 TO ii_obj_select_cnt 
		IF is_last_object[i] = ls_selected_object THEN
			li_found = 1
		END IF
	END FOR
	IF li_found = 0 THEN
		ib_multi_select = False
	ELSE
	   il_ancor_x = Pointerx()
		il_ancor_y = Pointery()
	END IF
END IF

IF flags = 9 THEN
	ib_control_down = True
	ib_multi_select = True
ELSE
	ib_control_down = False
	IF ib_multi_select THEN
		FOR i = 1 TO ii_obj_select_cnt	
			il_last_object_y[i] = Long( This.Describe( is_last_object[i] + ".y") )
			il_last_object_x[i] = Long( This.Describe( is_last_object[i] + ".x") )
		END FOR
	ELSE
		//il_ancor_x = Pointerx()
		//il_ancor_y = Pointery()
		//w_prac_data_design.title = String(il_ancor_y)		
	END IF
	
	//FOR i = 1 TO ii_obj_select_cnt	
	//
END IF


end event

event dw_detail::lbuttonup;call super::lbuttonup;ib_mouse_down = False

ib_resize_height = False
ib_resize_width = False
end event

event scrollvertical;il_dw_scroll_pos = Long(This.Object.DataWindow.VerticalScrollPosition)
end event

event doubleclicked;IF UpperBound(is_last_object) = 0 THEN
	Return
END IF
IF is_last_object[1] <> "" AND RightA(is_last_object[1],2) <> "_t" THEN
	of_property_sheet()
END IF
end event

event dw_detail::clicked;call super::clicked;String ls_weight
String ls_italic
String ls_underline
String ls_selected_object
String ls_alignment
String ls_text
String ls_selected_object_name
String ls_field_id
String ls_last_field_temp[]
Integer i
Integer li_field_id[]

//IF il_data_view_id = 1 THEN
//	MessageBox("Default System View", "You can not change the default system view.")
//	Return
//END IF

ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )

IF ib_set_tab_order THEN
	IF LeftA( ls_selected_object_name, 4 ) = "tab_" THEN
		string ls_Retval
		ls_retval = This.Modify( MidA( is_last_tab_label_name, 5,100) + ".dbname = '" + sle_tab.Text + "'" )		
		This.Modify( is_last_tab_label_name + ".text = '" + sle_tab.Text + "'" )		
		sle_tab.Text = This.Describe( ls_selected_object_name + ".tabsequence" ) 
		sle_tab.x = Long( This.Describe( ls_selected_object_name + ".x" ) ) + This.x
		sle_tab.y = Long( This.Describe( ls_selected_object_name + ".y" ) ) + This.y
		sle_tab.SetFocus()
		sle_tab.BringToTop = True
		sle_tab.Text = idw_detail.Describe( MidA( ls_selected_object_name, 5, 100 ) + ".dbname" )			
		sle_tab.SelectText( 1, 100 )
	   is_last_tab_label_name = ls_selected_object_name
		RETURN 
	END IF
END IF

IF NOT ib_multi_select THEN
	FOR i = 1 TO ii_obj_select_cnt
		IF RightA(is_last_object[i], 2) = "_t" THEN
			This.Modify( is_last_object[i] + ".border = '2'" )
		ELSE
			This.Modify( is_last_object[i] + ".border = '2'" )
		END IF
	END FOR
END IF

IF ii_obj_select_cnt = 1 THEN
	IF ls_selected_object_name <> is_last_object[1] THEN
		ib_resize_height = False
		ib_resize_width = False
	END IF
END IF

IF ib_set_tab_order THEN
	ii_tab_sequence = ii_tab_sequence + 10
	This.Modify( ls_selected_object_name + ".dbname = '" + String( ii_tab_sequence ) + "'" )
	Return
END IF

IF ( ls_selected_object_name = "" AND ii_obj_select_cnt = 0 ) THEN
	ii_field_id[] = li_field_id[]
	RETURN
END IF
	
IF (ls_selected_object_name = "" AND ii_obj_select_cnt > 0) THEN
	ib_multi_select = False
	FOR i = 1 TO ii_obj_select_cnt
		IF RightA(is_last_object[i], 2) = "_t" THEN
			This.Modify( is_last_object[i] + ".border = '2'" )
		ELSE
			This.Modify( is_last_object[i] + ".border = '2'" )
		END IF
	END FOR
	is_last_object[] = ls_last_field_temp[]
	ii_field_id[] = li_field_id[]
	il_ancor_x = 0
	il_ancor_y = 0	
	ii_obj_select_cnt = 0
	RETURN 0
END IF

IF ib_multi_select THEN
	ii_obj_select_cnt ++
ELSE
	ii_obj_select_cnt = 1
END IF

is_last_border[ii_obj_select_cnt] = This.Describe( ls_selected_object_name + ".border" )

IF ii_obj_select_cnt = 1 THEN
	il_ancor_x = Pointerx()
	il_ancor_y = Pointery()
   is_last_object_width = This.Describe( ls_selected_object_name + ".width" )
   is_last_object_height = This.Describe( ls_selected_object_name + ".height" )
END IF

is_last_object[ii_obj_select_cnt] = ls_selected_object_name

ii_field_id[ii_obj_select_cnt] = Integer( This.Describe( is_last_object[ii_obj_select_cnt] + ".tag" ) )

il_last_object_y[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".y") )
il_last_object_x[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".x") )
il_last_object_width[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".width") )
il_last_object_height[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".height"))

w_design_profile_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
														

w_design_profile_menu.st_object_name.Text = is_last_object[1]

This.Modify( ls_selected_object_name + ".border = '2'" )

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )

IF PosA( is_last_object[1], "obj" ) = 0 AND ls_selected_object_name <> "detail_band" THEN
	dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
	dw_properties.Filter()
END IF

ls_text = This.Describe( ls_selected_object_name + ".text" )

IF ls_text <> "?" AND ls_text <> "!" THEN
	w_design_profile_menu.dw_1.SetText( ls_text )
END IF

ls_alignment = This.Describe(is_last_object[ii_obj_select_cnt] + ".alignment")

w_design_profile_menu.st_left.BorderStyle = StyleRaised!
w_design_profile_menu.st_right.BorderStyle = StyleRaised!
w_design_profile_menu.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	w_design_profile_menu.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	w_design_profile_menu.st_right.BorderStyle = StyleLowered!
ELSE
	w_design_profile_menu.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	w_design_profile_menu.st_bold.BorderStyle = StyleRaised!
ELSE
	w_design_profile_menu.st_bold.BorderStyle = StyleLowered!
END IF

ls_italic = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.italic")
IF ls_italic = "0" THEN
	w_design_profile_menu.st_italic.BorderStyle = StyleRaised!
ELSE
	w_design_profile_menu.st_italic.BorderStyle = StyleLowered!
END IF

ls_underline = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.underline")
IF ls_underline = "0" THEN
	w_design_profile_menu.st_underline.BorderStyle = StyleRaised!
ELSE
	w_design_profile_menu.st_underline.BorderStyle = StyleLowered!
END IF
end event

type dw_browse from pfc_cst_u_data_entry`dw_browse within pfc_cst_u_data_entry_profile_painter
integer x = 1303
integer y = 36
integer width = 2149
integer height = 460
integer taborder = 110
end type

type tab_view from pfc_cst_u_data_entry`tab_view within pfc_cst_u_data_entry_profile_painter
integer x = 786
integer y = 20
integer height = 1668
integer taborder = 70
boolean bringtotop = true
tabpage_preview tabpage_preview
end type

event tab_view::selectionchanging;
IF parent_window_profile_design.Event pfc_save() < 0 THEN
	Return 1
END IF


end event

event tab_view::selectionchanged;il_prac_id = 49

IF newindex = 4 THEN
	inv_data_entry.of_create_dynamic_profile_dw(il_prac_id, il_data_view_id, ii_screen_id, +&
		tab_view.tabpage_preview.dw_preview, dw_browse, False, 0 )
		dw_detail.BringToTop = False
ELSE
		dw_detail.BringToTop = True
END IF


end event

on tab_view.create
this.tabpage_preview=create tabpage_preview
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_preview
end on

on tab_view.destroy
call super::destroy
destroy(this.tabpage_preview)
end on

type tabpage_browse from pfc_cst_u_data_entry`tabpage_browse within tab_view
boolean visible = false
integer height = 1540
end type

type tabpage_details from pfc_cst_u_data_entry`tabpage_details within tab_view
integer height = 1540
long backcolor = 80269524
string text = "Design"
long tabbackcolor = 80269524
string picturename = "Custom041!"
sle_1 sle_1
end type

on tabpage_details.create
this.sle_1=create sle_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.sle_1
end on

on tabpage_details.destroy
call super::destroy
destroy(this.sle_1)
end on

type tabpage_image from pfc_cst_u_data_entry`tabpage_image within tab_view
boolean visible = false
integer height = 1540
long backcolor = 80269524
long tabbackcolor = 80269524
end type

type dw_detail_2 from pfc_cst_u_data_entry`dw_detail_2 within tabpage_image
boolean visible = false
end type

type sle_1 from singlelineedit within tabpage_details
integer x = 87
integer y = 480
integer width = 247
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type tabpage_preview from userobject within tab_view
integer x = 18
integer y = 16
integer width = 2679
integer height = 1540
long backcolor = 80269524
string text = "Preview"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
string picturename = "preview!"
long picturemaskcolor = 553648127
dw_preview dw_preview
end type

on tabpage_preview.create
this.dw_preview=create dw_preview
this.Control[]={this.dw_preview}
end on

on tabpage_preview.destroy
destroy(this.dw_preview)
end on

type dw_preview from u_dw within tabpage_preview
string tag = "Preview"
integer width = 2679
integer height = 1520
integer taborder = 11
boolean bringtotop = true
boolean hscrollbar = true
end type

type dw_screen_objects from u_dw within pfc_cst_u_data_entry_profile_painter
boolean visible = false
integer x = 96
integer y = 412
integer width = 462
integer height = 236
integer taborder = 50
string dataobject = "d_screen_objects"
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble(True)
end event

type dw_properties from u_dw within pfc_cst_u_data_entry_profile_painter
integer x = 55
integer y = 20
integer width = 649
integer height = 1500
integer taborder = 30
string dataobject = "d_sys_field_properties"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type cb_screen_properties from u_cb within pfc_cst_u_data_entry_profile_painter
boolean visible = false
integer x = 23
integer y = 1460
integer width = 736
integer height = 80
integer taborder = 20
boolean bringtotop = true
string text = "Edit Screen Parameters"
end type

event clicked;Integer li_last_row

ii_screen_id = dw_select_section.GetItemNumber(dw_select_section.GetRow(), "screen_id") 

Open( w_screen_maint)

IF Message.StringParm = "Cancel" THEN
	Return
END IF

dw_select_section.SetRedraw(False)

ib_refresh_screen_list = True

li_last_row = dw_select_section.GetRow()

dw_select_section.Retrieve( il_data_view_id )
dw_select_section.ScrollToRow( li_last_row)
dw_select_section.SetRow( li_last_row )
dw_select_section.SelectRow( li_last_row, True)

ib_refresh_screen_list = False

dw_select_section.SetRedraw(True)
end event

type sle_tab from singlelineedit within pfc_cst_u_data_entry_profile_painter
boolean visible = false
integer x = 891
integer y = 500
integer width = 165
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_tab from statictext within pfc_cst_u_data_entry_profile_painter
boolean visible = false
integer x = 2395
integer y = 1364
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Click on red tab labels to modify."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within pfc_cst_u_data_entry_profile_painter
integer x = 110
integer y = 1596
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Test"
end type

event clicked;Open( w_test)
end event

type cb_2 from commandbutton within pfc_cst_u_data_entry_profile_painter
integer x = 110
integer y = 1720
integer width = 247
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Tes"
end type

