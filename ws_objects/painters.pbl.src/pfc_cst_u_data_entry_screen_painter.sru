$PBExportHeader$pfc_cst_u_data_entry_screen_painter.sru
forward
global type pfc_cst_u_data_entry_screen_painter from pfc_cst_u_data_entry
end type
type sle_1 from singlelineedit within tabpage_details
end type
type cb_screen_properties from u_cb within pfc_cst_u_data_entry_screen_painter
end type
type sle_tab from singlelineedit within pfc_cst_u_data_entry_screen_painter
end type
type dw_properties from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type cb_1 from commandbutton within pfc_cst_u_data_entry_screen_painter
end type
type dw_fields_alias from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type dw_properties_report from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type dw_properties_dataview from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type dw_properties_modify from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type dw_properties_pmodify from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type dw_screen_objects from u_dw within pfc_cst_u_data_entry_screen_painter
end type
type uo_screen_design_menu from uo_design_menu within pfc_cst_u_data_entry_screen_painter
end type
type st_tab from statictext within pfc_cst_u_data_entry_screen_painter
end type
end forward

global type pfc_cst_u_data_entry_screen_painter from pfc_cst_u_data_entry
integer width = 3607
integer height = 2168
long backcolor = 33551856
event ue_field_properties ( )
event type integer pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
event type integer ue_screenchanged ( )
cb_screen_properties cb_screen_properties
sle_tab sle_tab
dw_properties dw_properties
cb_1 cb_1
dw_fields_alias dw_fields_alias
dw_properties_report dw_properties_report
dw_properties_dataview dw_properties_dataview
dw_properties_modify dw_properties_modify
dw_properties_pmodify dw_properties_pmodify
dw_screen_objects dw_screen_objects
uo_screen_design_menu uo_screen_design_menu
st_tab st_tab
end type
global pfc_cst_u_data_entry_screen_painter pfc_cst_u_data_entry_screen_painter

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
boolean ib_profile = false //maha 11.29.07


Integer li_flags
Integer ii_obj_select_cnt = 0
Long	  ii_field_id[]
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
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
boolean ib_objects_retrieved = false
Long	il_x_diff, il_y_diff
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 06/16/2008 By: Ken.Guo
//$<reason> Fixed BugK050503
Long il_vscroll_pos = 0
Long il_hscroll_pos = 0
//---------------------------- APPEON END ----------------------------
end variables

forward prototypes
public function integer of_pre_pfc_save ()
public function integer of_property_sheet ()
public function integer of_refresh_properties_dw ()
public function integer of_set_parent_window (w_prac_data_design aw_win)
public function integer of_setup_painter ()
public function integer of_select_view ()
public function integer of_show_invisible (boolean ab_show)
public function integer of_set_tab_order (boolean ab_status)
public function integer of_select_screen (integer currentrow, integer ai_screen_id)
public function integer of_set_display_only ()
public function integer of_update_profile_views ()
public function string of_mod_dw_for_profile ()
public function integer of_toggle_profile ()
public function integer of_pre_save_report ()
public function integer of_pre_save_report_all ()
public function boolean of_isscreenchanged ()
public function integer of_webview_format ()
public function integer of_standard_format ()
end prototypes

event ue_field_properties;of_property_sheet()
end event

event type integer pfc_cst_select_view();Return of_select_view() // Modify by Evan 01/10/2008
end event

event pfc_cst_new_screen_painter();Open( w_new_screen_painter )

end event

event type integer ue_screenchanged();//////////////////////////////////////////////////////////////////////
// $<event> ue_screenchanged
// $<arguments>
// $<returns> integer
// $<description> Screen changed event. (Corrected BugG031002)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.19.2009
//////////////////////////////////////////////////////////////////////

Return 0
end event

public function integer of_pre_pfc_save ();Integer i
Integer li_col_cnt
Integer li_field_order
integer li_width //maha 07.31.2014
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

	//For Column
	dw_properties.SetItem(i, "data_view_fields_field_x", Integer(idw_detail.Describe( ls_field_nm + ".x" )) )
	dw_properties.SetItem(i, "data_view_fields_field_y", Integer(idw_detail.Describe( ls_field_nm + ".y" )) )
	dw_properties.SetItem(i, "data_view_fields_justification", Integer(idw_detail.Describe( ls_field_nm + ".alignment" )) )
	//Start Code Change ----07.31.2014 #V14.2 maha - modification to prevent the field from being to small to see.
	li_width =  Integer(idw_detail.Describe( ls_field_nm + ".width" ))
	if li_width < 20 then li_width = 20
	//dw_properties.SetItem(i, "data_view_fields_field_width", Integer(idw_detail.Describe( ls_field_nm + ".width" )) )	
	dw_properties.SetItem(i, "data_view_fields_field_width", li_width )
	//End Code Change ----07.31.2014
	dw_properties.SetItem(i, "data_view_fields_field_height", Integer(idw_detail.Describe( ls_field_nm + ".height" )) )	
	dw_properties.SetItem(i, "data_view_fields_font_wieght", Integer(idw_detail.Describe( ls_field_nm + ".font.weight" )) )	//Modified By Ken.Guo 04.01.2008,Replaced "_t.font.weight"	
	dw_properties.SetItem(i, "data_view_fields_field_underline", String(idw_detail.Describe( ls_field_nm + ".font.underline" )) ) //Added By Ken.Guo 04.01.2008
	dw_properties.SetItem(i, "data_view_fields_field_font_italic", Integer(idw_detail.Describe( ls_field_nm + ".font.italic" )) ) //Added By Ken.Guo 04.01.2008
	
	//For Label
	ls_retval = MidA(idw_detail.Describe( ls_field_nm + "_t.text" ) , 1, 5000)
	dw_properties.SetItem(i, "data_view_fields_field_label", ls_retval )
	dw_properties.SetItem(i, "data_view_fields_field_label_x", Integer(idw_detail.Describe( ls_field_nm + "_t.x" )) )
	dw_properties.SetItem(i, "data_view_fields_field_label_y", Integer(idw_detail.Describe( ls_field_nm + "_t.y" )) )
	dw_properties.SetItem(i, "data_view_fields_label_justification", Integer(idw_detail.Describe( ls_field_nm + "_t.alignment" )) )	
	//Start Code Change ----07.31.2014 #V14.2 maha - modification to prevent the field from being to small to see.
	li_width =  Integer(idw_detail.Describe( ls_field_nm + "_t.width" ))
	if li_width < 20 then li_width = 20
	//dw_properties.SetItem(i, "data_view_fields_field_label_width", Integer(idw_detail.Describe( ls_field_nm + "_t.width" )) )	
	dw_properties.SetItem(i, "data_view_fields_field_label_width",li_width )	
	//End Code Change ----07.31.2014
	dw_properties.SetItem(i, "data_view_fields_label_font_weight", Integer(idw_detail.Describe( ls_field_nm + "_t.font.weight" )) )	//Added By Ken.Guo 04.01.2008	
	dw_properties.SetItem(i, "data_view_fields_label_underline", String(idw_detail.Describe( ls_field_nm + "_t.font.underline" )) )	 //Added By Ken.Guo 04.01.2008	
	dw_properties.SetItem(i, "data_view_fields_label_font_italic", Integer(idw_detail.Describe( ls_field_nm + "_t.font.italic" )) ) //Added By Ken.Guo 04.01.2008
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> dbName is not fully supported (support to read and not write).
	//$<modification> Replace dbName with TabSequence to provide the same functionality.
	//li_field_order =  Integer(idw_detail.Describe( ls_field_nm + ".dbname" ))
	li_field_order =  Integer(idw_detail.Describe( ls_field_nm + ".TabSequence" ))
	//---------------------------- APPEON END ----------------------------
	
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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-02
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> dbName is not fully supported (support to read and not write).
	//$<modification> Replace dbName with TabSequence to provide the same functionality.
	//dw_detail.Modify( ls_field_nm + ".dbname = '" + String(i * 10) + "'" )
	dw_detail.Modify( ls_field_nm + ".TabSequence = '" + String(i * 10) + "'" )
	//---------------------------- APPEON END ----------------------------
END FOR

dw_properties.SetFilter( "" )
dw_properties.Filter()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2008-08-19 By: Alan
//$<reason> call function 
of_pre_save_report_all()
//---------------------------- APPEON END ----------------------------

dw_screen_objects.AcceptText()

li_col_cnt = dw_screen_objects.RowCount()

FOR i = 1 TO li_col_cnt
	ls_obj_name = "object" + String(dw_screen_objects.GetItemNumber(i, "data_view_object_id" ) )
	ls_retval = idw_detail.Describe( ls_obj_name + ".x" ) 
	IF ls_retval = "!" THEN
		ls_obj_name = ls_obj_name + "_t"
	END IF
	dw_screen_objects.SetItem(i, "object_x", Integer(idw_detail.Describe( ls_obj_name + ".x" )))
	dw_screen_objects.SetItem(i, "object_y", Integer(idw_detail.Describe( ls_obj_name + ".y" )))
	dw_screen_objects.SetItem(i, "object_width", Integer(idw_detail.Describe( ls_obj_name + ".width" )))
	dw_screen_objects.SetItem(i, "object_height", Integer(idw_detail.Describe( ls_obj_name + ".height" )))
	ls_retval = idw_detail.Describe( ls_obj_name + ".text" )
	dw_screen_objects.SetItem(i, "object_text", ls_retval)
	dw_screen_objects.SetItem(i, "object_alignment", Integer(idw_detail.Describe( ls_obj_name + ".alignment" )))
	//------------------- APPEON BEGIN -------------------
	//$<add> Evan 12.14.2010
	//$<reason> Save bold, italic and underline properties.
	dw_screen_objects.SetItem(i, "object_bold", Integer(idw_detail.Describe( ls_obj_name + ".font.weight" )))
	dw_screen_objects.SetItem(i, "object_italic", Integer(idw_detail.Describe( ls_obj_name + ".font.italic" )))
	dw_screen_objects.SetItem(i, "object_underline", Integer(idw_detail.Describe( ls_obj_name + ".font.underline" )))
	//------------------- APPEON END ---------------------
END FOR


COMMIT USING SQLCA;





RETURN 1
end function

public function integer of_property_sheet ();String ls_field_id


//--------Begin Added by Nova 09.18.2008------------------------
if Isvalid(w_mdi) then
	//user security :Screen Painter - intellicred Field Properties
	if w_mdi.of_security_access(440) = 0 then Return -1
end if
//--------End Added --------------------------------------------

IF UpperBound( is_last_object[] ) = 0 THEN
	MessageBox("Select", "You must first select a field by clicking on it." )
	RETURN -1
END IF

IF IsNull( is_last_object[1] ) OR is_last_object[1] = "" THEN
	MessageBox("Select", "You must first select a field by clicking on it." )
	RETURN -1
END IF

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2006 By: Liang QingShi
//$<reason> Fix a defect. 
/*
dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
dw_properties.Filter()
*/
if ls_field_id <> '?' and ls_field_id <> '!' then
	dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
	dw_properties.Filter()
else
	return 0
end if
//---------------------------- APPEON END ----------------------------

IF NOT IsValid(w_field_properties) THEN
	Open(w_field_properties)
END IF

Return 0
end function

public function integer of_refresh_properties_dw ();dw_properties.Update()
dw_properties.Retrieve( il_data_view_id, ii_screen_id )

Return 1
end function

public function integer of_set_parent_window (w_prac_data_design aw_win);
//BEGIN-Modify by Evan 12.14.2010
//parent_window_design = aw_win
//END-Modify by Evan 12.14.2010

Return 0
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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04/01/2008 By: Ken.Guo
	//$<reason> If column is invisible or taborder is 0, It can't get column name use this way.
	/*
	dw_properties.SetColumn( i )
	ls_col_name = dw_properties.GetColumnName()
	*/
	ls_col_name = dw_properties.Describe("#"+String(i)+".name") 
	//---------------------------- APPEON END ----------------------------
	IF Upper(MidA(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(MidA(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
		li_dv_col_cnt ++
		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
	END IF
	
END FOR

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

dw_properties.inv_multitable.of_Register( "sys_fields", ls_sys_key_cols , ls_sys_fields_update, TRUE, 0)
dw_properties.inv_multitable.of_Register( "data_view_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)


This.Height = This.Height - 204
This.y = 190


Return 0



end function

public function integer of_select_view ();String ls_data_view_name

Open( w_select_view )
IF Message.StringParm = "Cancel" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 02.20.2006 By: owen chen
	//$<reason> Performance tuning
	//$<reason> Fix a defect.
	//this.of_setup( False) //Delete by Evan 07.10.2009(Corrected BugN062402) --- The w_prac_data_design's open event have this code
	//---------------------------- APPEON END ----------------------------
	Return -1
ELSE
	//BEGIN-Modify by Evan 12.14.2010
	//IF parent_window_design.Event pfc_save() < 0 THEN
	IF w_prac_data_design.Event pfc_Save() < 0 THEN
	//END-Modify by Evan 12.14.2010	
		Return -1
	END IF

	This.SetRedraw( False )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-02
	//$<modify> 04.13.2006 By: Rodger Wu
	//$<reason> Performance Tuning 
	//$<modification> Write script to retrieve data from Parm property of Message object instead of from the database.
	/*
	il_data_view_id = Message.DoubleParm
	//messagebox("of_select_view","2")
	SELECT data_view.data_view_name  
   INTO :ls_data_view_name  
   FROM data_view  
   WHERE data_view.data_view_id = :il_data_view_id   ;
	*/
	Integer li_pos
	String ls_msg
	
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	il_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) )
	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )
	//---------------------------- APPEON END ----------------------------
	
	//BEGIN-Modify by Evan 12.14.2010
	//parent_window_design.Title = "Practitioner Data Screen Painter ( " + ls_data_view_name + " )"
	w_prac_data_design.Title = "Practitioner Data Screen Setup ( " + ls_data_view_name + " )" //"Painter"->"Setup" - Alfee 09.14.2011
	//END-Modify by Evan 12.14.2010
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( il_data_view_id )

  
	//messagebox("of_select_view","3")
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
	st_tab.bringtotop = True //Start Code Change ----03.23.2016 #V15 maha
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
		//IF ls_bc = "16777215" THEN 
		IF ls_bc <> "12632256" and ls_bc <> "1073741824" then  //Start Code Change ----03.23.2016 #V15 maha - replaced line below if not invisible gray then set tab //don't set tab for key columns (1073741824), Added by Appeon long.zhang 04.05.2016 (V15.1 Bug #5088 - Screen Design: Extra tab box on first field )
		//IF ls_bc = "16777215" or ls_bc = "65535"  or ls_bc = "8257535" or ls_bc = "11534335" THEN //alfee 03.26.2010 
			//--------------------------- APPEON BEGIN ---------------------------
			//$<ID> UM-03
			//$<modify> 01.13.2006 By: LeiWei
			//$<reason> dbName is not fully supported (support to read and not write).
			//$<modification> Replace dbName with TabSequence to provide the same functionality.			
			//dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm   )
			ls_tab_order = idw_detail.Describe( ls_col_nm + ".TabSequence" )		
			dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='Segoe UI' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")"  )
			//---------------------------- APPEON END ----------------------------
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
	//$<ID> UM-04
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> dbName is not fully supported (support to read and not write).
	//$<modification> Replace dbName with TabSequence to provide the same functionality. 
	//dw_detail.Modify( Mid( is_last_tab_label_name, 5, 100 ) + ".dbname = '" + sle_tab.Text + "'" )		
	dw_detail.Modify( MidA( is_last_tab_label_name, 5, 100 ) + ".TabSequence = '" + sle_tab.Text + "'" )		
	//---------------------------- APPEON END ----------------------------

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

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<comment> 02.20.2006 By: owen chen
//$<modification> Move the following scripts to pfc_save event of 
//$<modification> the w_prac_data_design window
/*
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()
*/
//---------------------------- APPEON END ----------------------------

SetRedraw( False )

IF currentrow < 1 THEN
	Return 1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> fix a defect.
/*
IF w_design_menu.st_tab_order.BorderStyle = StyleLowered! THEN
	of_set_tab_order( False )
	w_design_menu.st_tab_order.TriggerEvent( Clicked! )
END IF
*/
IF uo_screen_design_menu.st_tab_order.BorderStyle = StyleLowered! THEN
	of_set_tab_order( False )
	uo_screen_design_menu.st_tab_order.TriggerEvent( Clicked! )
END IF


//---------------------------- APPEON END ----------------------------

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

inv_data_entry.of_create_dynamic_dw(il_prac_id, il_data_view_id, ai_screen_id, dw_detail, dw_browse, True, 0, true )

dw_browse.Visible = False
dw_detail.BringToTop = True
dw_detail.Visible = True

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 06/16/2008 By: Ken.Guo
//$<reason> Fixed BugK050503
il_vscroll_pos = 0
il_hscroll_pos = 0
//---------------------------- APPEON END ----------------------------

dw_select_section.SelectRow(0, False)
dw_select_section.SelectRow( currentrow, True)

IF ib_refresh_screen_list = True THEN
	SetRedraw( True )
	Return 1
END IF

//ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.20.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
/*
dw_properties.Retrieve( il_data_view_id, ii_screen_id )
li_row_cnt = dw_properties.RowCount( )
dw_screen_objects.Reset()
dw_screen_objects.of_SetTransObject(SQLCA)
dw_screen_objects.Retrieve( il_data_view_id, ii_screen_id )
*/
dw_screen_objects.Reset()
dw_screen_objects.of_SetTransObject(SQLCA)

gnv_appeondb.of_startqueue( )
dw_properties.Retrieve( il_data_view_id, ii_screen_id )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2008-08-19 By: Alan
//$<reason> add datawindow for update ismodify
int li_prfid
select prf_id into :li_prfid from profile_report_dw where scr_id=:ii_screen_id;
//---------------Begin Modified by Alfee 02.16.2009------------------
//dw_properties_modify.Retrieve( il_data_view_id, ii_screen_id, 'S' )
//dw_properties_pmodify.Retrieve( il_data_view_id, li_prfid, 'P' )
dw_properties_modify.Retrieve( 1, ii_screen_id, 'S' )
dw_properties_pmodify.Retrieve(1, li_prfid, 'P' )
//--------------End Modified ----------------------------------------
dw_properties_dataview.Retrieve( il_data_view_id, ii_screen_id, 'S' )
//---------------------------- APPEON END ----------------------------
dw_screen_objects.Retrieve( il_data_view_id, ii_screen_id )
//$<add> 03.26.2008 by Andy
dw_fields_alias.retrieve( 2 , ','+String(ii_screen_id)+',' , il_data_view_id)
//end add 03.26.2008
gnv_appeondb.of_commitqueue( )
li_row_cnt = dw_properties.RowCount( )
//---------------------------- APPEON END ----------------------------

//messagebox("row count", li_row_cnt )

//li_col_cnt = Integer( dw_detail.Object.DataWindow.Column.Count )  //Commented By Ken.Guo 06.13.2008
li_col_cnt = Integer(dw_detail.Describe("DataWindow.Column.Count")) //Added By Ken.Guo 06.13.2008

FOR i = 1 TO li_col_cnt
	dw_detail.SetColumn(i)
	is_object_list[i] = dw_detail.GetColumnName()
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-05
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> Since dbName is replaced with TabSequence. SetTabOrder conflicts with TabSequence.
	//$<modification> Replace SetTabOrder with Modify to provide the same functionality. 
	//dw_detail.SetTabOrder(i, 0 )
	dw_detail.Modify(is_object_list[i]+".Protect=1")
	//---------------------------- APPEON END ----------------------------
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

public function integer of_set_display_only ();//maha created 092204 for setting all fields in a window to read only
integer i
integer ic
integer res
string ls_val
debugbreak()
res = messagebox("Display Only","This function sets all fields in this screen to display only.~r Click YES to set all fields to display only; click NO to set all fields editable.", question!,yesnocancel!,3)
if res = 3 then 
	return 1
elseif res = 2 then 
	ls_val = "N"
else
	ls_val = "Y"
end if
	

ic = dw_properties.rowcount()

for i = 1 to ic
	dw_properties.setitem(i,"data_view_fields_display_only",ls_val)
next

dw_properties.update()  //Start Code Change ----07.23.2015 #V15 maha - added save


return 1
end function

public function integer of_update_profile_views ();integer res
integer li_table
integer li_view
integer li_screen
string ls_syn1
string ls_screen
long ll
long pos_where
long pos2
long pos3
long pos4
string method = "A"


res = messagebox("Profile Save","This button functionality is for saving the current screen to profile views.  Click yes to continue",information!,yesno!,1)
if res = 2 then return -1
//debugbreak()
li_table = dw_select_section.getitemnumber(dw_select_section.getrow(),"table_id")
ls_screen = dw_select_section.getitemstring(dw_select_section.getrow(),"screen_alias")
li_view = il_data_view_id
li_screen = dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id")

//Start Code Change ----01.24.2008 #V8 maha
if ib_profile = false then //if not in profile view mode
	if method = "A" then
		of_mod_dw_for_profile( )  //method A
	elseif method = "B" then
		of_modify_dw_for_dyn_profile(dw_detail,li_screen,ls_screen,"S") //application function //method B
	end if
end if

if method = "A" then //saves full syntax
	ls_syn1 = dw_detail.Describe("DataWindow.Syntax")  //method A
	ls_syn1 = string(li_table) + "%" + ls_screen + "$" + ls_syn1
elseif method = "B" then	//saves screen name syntax generated at runtime
	ls_syn1 = string(li_view) + "@" + string(li_screen) + "&" + ls_screen //method B
	ls_syn1 = string(li_table) + "%" + ls_screen + "$" + ls_syn1
end if
ll = LenA(ls_syn1 )
//messagebox("Number of chars",ll)
//End Code Change---01.24.2008



openwithparm(w_update_profile_screen_syntax, ls_syn1 )

return 1
end function

public function string of_mod_dw_for_profile ();//Start Code Change ---- 10.22.2007 #V7 maha
// function created to modify screen in preparation to export syntax to profile view
//called from of_update_profile_views
string ls_syntax
string ls_screen
string s
string ls_field
integer li_id
integer i
integer ic
long ll_max_height
long ll_height
string ls_height
string ls_y
string ls_islookup
string ls_lookup_code
string ls_lookup_type
string ls_lookup_field


//debugbreak()
s = dw_detail.modify('datawindow.header.height = "90"')
s = dw_detail.modify('datawindow.Text.Background.Color=16777215')
s = dw_detail.modify('datawindow.color=16777215' )
//s = dw_detail.modify('datawindow.Detail.Height.AutoSize')
s = dw_detail.modify('datawindow.Detail.width = "3300"') //Start Code Change ----03.28.2008 #V8 maha
s = dw_detail.modify('datawindow.header.width = "3300"')

ls_screen = dw_select_section.getitemstring(dw_select_section.getrow(),"screen_alias")
li_id = dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id")
s = dw_detail.modify('create text(band=header alignment="2" text="' + ls_screen  + '" border="0" color="0" x="9" y="0" height="80" width="3282" html.valueishtml="0"  name=t_1 visible="1"  font.face="Times New Roman" font.height="-12" font.weight="700"  font.family="1" font.pitch="2" font.charset="0" background.mode="2" background.color="12632256" )')

//ic = integer(dw_detail.Object.DataWindow.Column.Count)    //Commented By Ken.Guo 06.13.2008
ic = Integer(dw_detail.Describe("DataWindow.Column.Count")) //Added By Ken.Guo 06.13.2008

for i = 1 to ic
	//debugbreak()
	ls_field = dw_detail.describe("#" + string(i) + ".Name")
	if integer(dw_detail.describe("#" + string(i) + ".visible")) > 0 then
		ls_height = dw_detail.describe("#" + string(i) + ".height")
		ls_y = dw_detail.describe("#" + string(i) + ".y")
		ll_height = long(ls_height) + long(ls_y)
		if ll_max_height < ll_height then ll_max_height = ll_height//dw_detail.Modify(ls_field + ".border = '0'")
		dw_detail.Modify( ls_field + "_t.font.weight = '700'") //Start Code Change ----01.08.2008 #V8 maha - make labels bold
	else
		dw_detail.Modify("#" + string(i) + ".visible = '0'")
	end if
	
	dw_detail.Modify("#" + string(i) + ".border = '0'") //removes indented border
	dw_detail.Modify("#" + string(i) + ".DDLB.UseAsBorder = 'No'") //removes arrow
	//dw_detail.Modify( ls_field + "_t.font.underline = '1'")
next
//messagebox("ll_max_height",ll_max_height)
s = dw_detail.modify("datawindow.Detail.Height = '" + string(ll_max_height) + "'")

//remove underlines
FOR i = 1 TO dw_properties.rowcount()
	ls_field = dw_properties.GetItemString( i, "sys_fields_field_name" )
	dw_detail.Modify( ls_field + "_t.font.underline = '0'")
	if dw_properties.GetItemString( i, "data_view_fields_visible" ) = "N" THEN
		dw_detail.Modify( ls_field + "_t.font.visible = '0'") //make label invisible
	end if
	
	
	//@@@@@@@@@@@@@@@@@@@@@@@@@
	if dw_properties.GetItemString( i, "data_view_fields_visible" ) = "Y" THEN
		ls_islookup = dw_properties.GetItemString( i, "sys_fields_lookup_field")
		
		IF ls_field = "active_status" THEN
			//dw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")			
			dw_detail.Modify( ls_field + ".dddw.useasborder = NO")			
			//dw_detail.Modify( ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Lines= 15")
			//adw_detail.Modify( ls_dw_field_names[i] + "_t.font.underline = '1'")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.Required = Yes")
			dw_detail.Modify( ls_field + ".dddw.name = 'd_code_lookup_active_inactive'")
			dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")			
			dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'description'")						
		END IF
	
		IF ls_islookup = "Y" THEN
			ls_lookup_code = dw_properties.GetItemString( i, "sys_fields_lookup_code" )
			ls_lookup_field = dw_properties.GetItemString( i, "sys_fields_lookup_field_name" )
			ls_lookup_type = dw_properties.GetItemString( i, "sys_fields_lookup_type" )
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.VscrollBar = Yes")
			//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.AutoHScroll = Yes")
			dw_detail.Modify( ls_field + ".dddw.useasborder = No")	
			dw_detail.Modify( ls_field + ".dddw.Autoretrieve = Yes")
			//detail.Modify(ls_dw_field_names[i] + ".dddw.NilIsNull= Yes")
			//adw_detail.Modify(ls_dw_field_names[i] + ".dddw.Lines= 15")
	
			IF ls_lookup_type = "C" THEN
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_code_lookup_all'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")
				IF Upper( ls_lookup_field ) = "CODE" THEN
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'code'")
				ELSE
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = '"+ls_lookup_field+"'")
				END IF
			ELSEIF ls_lookup_type = "A" THEN
				//adw_detail.Modify( ls_dw_field_names[i] + ".dddw.HscrollBar = Yes")			
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_address_lookup_all'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'lookup_code'")		
		
				IF Upper( ls_lookup_field ) = "CODE" THEN
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'code'")
				ELSE
					dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'entity_name'")			
				END IF
			ELSEIF ls_lookup_type = "Q" THEN
				dw_detail.Modify( ls_field + ".dddw.name = 'd_dddw_quest_lookup'")
				dw_detail.Modify( ls_field + ".dddw.datacolumn = 'quest_id'")	
				dw_detail.Modify( ls_field + ".dddw.displaycolumn = 'short_quest'")
				//adw_detail.Modify( ls_field + ".dddw.useasborder = No")
				//adw_detail.Modify( ls_field + ".dddw.vscrollbar = Yes")		END IF
			END IF
		END IF
	end if
	
	
	//?????@@@@@@@@@@@@@@@@@@@@@@@@@@@
	
next

//hide buttons
if li_id = 2 then //address
	dw_detail.Modify("findbutton.visible = '0'")
elseif li_id = 13 then //references
	dw_detail.Modify("peerbutton.visible = '0'")
end if

return ls_syntax
end function

public function integer of_toggle_profile ();string ls_screen
integer li_id

if ib_profile = false then //profile view
	ls_screen = dw_select_section.getitemstring(dw_select_section.getrow(),"screen_alias")
	li_id = dw_select_section.getitemnumber(dw_select_section.getrow(),"screen_id")
	of_mod_dw_for_profile( )
	//of_modify_dw_for_dyn_profile(dw_detail,li_id,ls_screen,"S")
	ib_profile = true

else //screen view
	//ib_show_invisible = false
	dw_properties.SetFilter( "data_view_fields_visible='Y'" )
	dw_properties.Filter()
	dw_select_section.triggerevent( rowfocuschanged!)
	dw_select_section.selectrow( dw_select_section.getrow(), true)

	of_show_invisible( false )
	//ib_profile = false// called in rfc event
end if

return 1
end function

public function integer of_pre_save_report ();////
//int		i,ll_count,j
//boolean	lb_sys,lb_dataview
//int		li_fieldid,li_findrow
//
//dw_properties_report.reset()
//dw_properties_dataview.reset()
//
//ll_count = dw_properties.rowcount()
//for i=1 to ll_count
//	j=0
//	li_fieldid=dw_properties.GetItemNumber(i,"data_view_fields_field_id")
//	if dw_properties.GetItemStatus(i,"sys_fields_lookup_field",primary!)=DataModified! or &
//		dw_properties.GetItemStatus(i,"sys_fields_lookup_type",primary!)=DataModified! or &
//		dw_properties.GetItemStatus(i,"sys_fields_lookup_code",primary!)=DataModified! or &
//		dw_properties.GetItemStatus(i,"sys_fields_lookup_field_name",primary!)=DataModified! or &
//		dw_properties.GetItemStatus(i,"sys_fields_drop_down_width",primary!)=DataModified! then
//		dw_properties.rowscopy(i,i,primary!,dw_properties_report,1,primary!)
//		dw_properties_report.SetItemStatus(1, 0, Primary!, DataModified!)
//		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_field", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_field",primary!))
//		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_type", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_type",primary!))
//		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_code", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_code",primary!))
//		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_field_name", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_field_name",primary!))
//		dw_properties_report.SetItemStatus(1, "sys_report_fields_drop_down_width", Primary!, dw_properties.GetItemStatus(i,"sys_fields_drop_down_width",primary!))
//		li_findrow=dw_properties_pmodify.find("data_view_report_fields_field_id="+string(li_fieldid),1,dw_properties_pmodify.rowcount())
//		if li_findrow>0 then dw_properties_pmodify.setitem(li_findrow,"ismodify",'1')		 
//		j++
//	end if
//	//
////	if dw_properties.GetItemStatus(i,"data_view_fields_label_justification",primary!)=DataModified! or &
////		 dw_properties.GetItemStatus(i,"data_view_fields_label_font_italic",primary!)=DataModified! or &
////		 dw_properties.GetItemStatus(i,"data_view_fields_label_underline",primary!)=DataModified! or &
////		 dw_properties.GetItemStatus(i,"data_view_fields_label_font_weight",primary!)=DataModified! or &
////		 dw_properties.GetItemStatus(i,"data_view_fields_field_label",primary!)=DataModified! then
//		 dw_properties.rowscopy(i,i,primary!,dw_properties_dataview,1,primary!)
//		 dw_properties_dataview.SetItemStatus(1, 0, Primary!, DataModified!)
//		 if dw_properties.GetItemNumber(i,"data_view_fields_label_justification",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_justification",primary!,false) then
//	    	 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_justification", Primary!, notModified!)			
//		 else
//			 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_justification", Primary!, dataModified!)			
//			 j++
//		 end if		 
//		 if dw_properties.GetItemNumber(i,"data_view_fields_label_font_italic",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_font_italic",primary!,false) then
//	    	 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_font_italic", Primary!, notModified!)			
//		 else
//    		 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_font_italic", Primary!, dataModified!)			
//			 j++ 
//		 end if		 
//		 if dw_properties.GetItemString(i,"data_view_fields_label_underline",primary!,true)=dw_properties.GetItemString(i,"data_view_fields_label_underline",primary!,false) then
//	    	 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_underline", Primary!, notModified!)			
//		 else
//			 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_underline", Primary!, dataModified!)				
//			 j++
//		 end if		 
// 		 if dw_properties.GetItemNumber(i,"data_view_fields_label_font_weight",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_font_weight",primary!,false) then
//	    	 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_font_weight", Primary!, notModified!)			
//		else
//			 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_label_font_weight", Primary!, dataModified!)			
//			 j++
//		 end if	
//		 if dw_properties.GetItemString(i,"data_view_fields_field_label",primary!,true)=dw_properties.GetItemString(i,"data_view_fields_field_label",primary!,false) then
//	    	 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_field_label", Primary!, notModified!)			
//	    else			  
//			 dw_properties_dataview.SetItemStatus(1, "data_view_report_fields_field_label", Primary!, dataModified!)			
//			 j++
//		 end if			
//		 if j>0 then
//			 li_findrow=dw_properties_modify.find("data_view_report_fields_field_id="+string(li_fieldid),1,dw_properties_modify.rowcount())
//			 if li_findrow>0 then dw_properties_modify.setitem(li_findrow,"ismodify",'1')		 
//		end if
////	end if
//next
//
//
////dwItemStatus l_status
////string	ls
////for i=1 to dw_properties_dataview.rowcount()
////	l_status = dw_properties_dataview.GetItemStatus(i,"data_view_report_fields_label_font_italic",primary!)
////	choose case l_status
////		case new!
////			ls="new"
////		case newmodified!
////			ls="newmodified"
////		case datamodified!
////			ls="datamodified"
////		case notmodified!
////			ls="notmodified"
////	end choose
////	messagebox(string(i),ls)			
////next
//
return 1

end function

public function integer of_pre_save_report_all ();int		i, ll_count,j,ii
boolean	lb_sys, lb_dataview
long		li_fieldid, li_findrow
long 		ll_found, ll_count_report //alfee 02.16.2009

//--------------------------Begin Modified by Alfee on 02.16.2009--------------------
ll_count_report = dw_properties_report.Retrieve(il_data_view_id, ii_screen_id)
IF ll_count_report < 1 THEN RETURN 0

ll_count = dw_properties.rowcount()
for i=1 to ll_count
	li_fieldid=dw_properties.GetItemNumber(i,"data_view_fields_field_id")
	if dw_properties.GetItemStatus(i,"sys_fields_lookup_field",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_type",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_code",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_field_name",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_drop_down_width",primary!)=DataModified! then	

		ll_found = dw_properties_report.Find("field_id = " + String(li_fieldid),1, ll_count_report)
		IF ll_found > 0 THEN
			dw_properties_report.SetItem(ll_found, "lookup_field",  dw_properties.GetItemString(i,"sys_fields_lookup_field"))
			dw_properties_report.SetItem(ll_found, "lookup_type", dw_properties.GetItemString(i,"sys_fields_lookup_type"))
			dw_properties_report.SetItem(ll_found, "lookup_code",  dw_properties.GetItemString(i,"sys_fields_lookup_code"))
			dw_properties_report.SetItem(ll_found, "lookup_field_name", dw_properties.GetItemString(i,"sys_fields_lookup_field_name"))
			dw_properties_report.SetItem(ll_found, "drop_down_width", dw_properties.GetItemNumber(i,"sys_fields_drop_down_width"))			
		END IF
		
		dw_properties_pmodify.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_pmodify.filter()
		for ii=1 to dw_properties_pmodify.rowcount()
			dw_properties_pmodify.setitem(ii,"ismodify",'1')		 
		next
		dw_properties_modify.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_modify.filter()
		for ii=1 to dw_properties_modify.rowcount()
			dw_properties_modify.setitem(ii,"ismodify",'1')		 
		next		
	end if
NEXT
/*
ll_count = dw_properties.rowcount()
for i=1 to ll_count
	j=0
	li_fieldid=dw_properties.GetItemNumber(i,"data_view_fields_field_id")
	if dw_properties.GetItemStatus(i,"sys_fields_lookup_field",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_type",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_code",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_lookup_field_name",primary!)=DataModified! or &
		dw_properties.GetItemStatus(i,"sys_fields_drop_down_width",primary!)=DataModified! then	
		dw_properties.rowscopy(i,i,primary!,dw_properties_report,1,primary!)
		dw_properties_report.SetItemStatus(1, 0, Primary!, DataModified!)
		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_field", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_field",primary!))
		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_type", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_type",primary!))
		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_code", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_code",primary!))
		dw_properties_report.SetItemStatus(1, "sys_report_fields_lookup_field_name", Primary!, dw_properties.GetItemStatus(i,"sys_fields_lookup_field_name",primary!))
		dw_properties_report.SetItemStatus(1, "sys_report_fields_drop_down_width", Primary!, dw_properties.GetItemStatus(i,"sys_fields_drop_down_width",primary!))
		dw_properties_pmodify.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_pmodify.filter()
		for ii=1 to dw_properties_pmodify.rowcount()
			dw_properties_pmodify.setitem(ii,"ismodify",'1')		 
		next
		dw_properties_modify.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_modify.filter()
		for ii=1 to dw_properties_modify.rowcount()
			dw_properties_modify.setitem(ii,"ismodify",'1')		 
		next
		j++
	end if
	//
	 if dw_properties.GetItemNumber(i,"data_view_fields_label_justification",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_justification",primary!,false) then
	 else
	 	dw_properties_dataview.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_dataview.filter()
		for ii=1 to dw_properties_dataview.rowcount()
			dw_properties_dataview.setitem(ii,"data_view_report_fields_label_justification",dw_properties.GetItemNumber(i,"data_view_fields_label_justification",primary!,false))		 
			dw_properties_dataview.setitem(ii,"ismodify",'1')		 
		next   				
	 end if		 
	 if dw_properties.GetItemNumber(i,"data_view_fields_label_font_italic",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_font_italic",primary!,false) then
	 else
		dw_properties_dataview.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_dataview.filter()
		for ii=1 to dw_properties_dataview.rowcount()
			dw_properties_dataview.setitem(ii,"data_view_report_fields_label_font_italic",dw_properties.GetItemNumber(i,"data_view_fields_label_font_italic",primary!,false))		 
			dw_properties_dataview.setitem(ii,"ismodify",'1')		 
		next   				
	 end if		 
	 if dw_properties.GetItemString(i,"data_view_fields_label_underline",primary!,true)=dw_properties.GetItemString(i,"data_view_fields_label_underline",primary!,false) then
	 else
		dw_properties_dataview.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_dataview.filter()
		for ii=1 to dw_properties_dataview.rowcount()
			dw_properties_dataview.setitem(ii,"data_view_report_fields_label_underline",dw_properties.GetItemString(i,"data_view_fields_label_underline",primary!,false))		 
			dw_properties_dataview.setitem(ii,"ismodify",'1')		 
		next   				
	 end if		 
	 if dw_properties.GetItemNumber(i,"data_view_fields_label_font_weight",primary!,true)=dw_properties.GetItemNumber(i,"data_view_fields_label_font_weight",primary!,false) then
	 else
		dw_properties_dataview.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_dataview.filter()
		for ii=1 to dw_properties_dataview.rowcount()
			dw_properties_dataview.setitem(ii,"data_view_report_fields_label_font_weight",dw_properties.GetItemNumber(i,"data_view_fields_label_font_weight",primary!,false))		 
			dw_properties_dataview.setitem(ii,"ismodify",'1')		 
		next   				
	 end if	
	 if dw_properties.GetItemString(i,"data_view_fields_field_label",primary!,true)=dw_properties.GetItemString(i,"data_view_fields_field_label",primary!,false) then
	 else			  
		dw_properties_dataview.setfilter("data_view_report_fields_field_id="+string(li_fieldid))
		dw_properties_dataview.filter()
		for ii=1 to dw_properties_dataview.rowcount()
			dw_properties_dataview.setitem(ii,"data_view_report_fields_field_label",dw_properties.GetItemString(i,"data_view_fields_field_label",primary!,false))		 
			dw_properties_dataview.setitem(ii,"ismodify",'1')		 
		next   				
	 end if			
next
//--------------------------End Modified-----------------------------------------------

//dwItemStatus l_status
//string	ls
//for i=1 to dw_properties_dataview.rowcount()
//	l_status = dw_properties_dataview.GetItemStatus(i,"data_view_report_fields_label_font_italic",primary!)
//	choose case l_status
//		case new!
//			ls="new"
//		case newmodified!
//			ls="newmodified"
//		case datamodified!
//			ls="datamodified"
//		case notmodified!
//			ls="notmodified"
//	end choose
//	messagebox(string(i),ls)			
//next
*/
//--------------------------End Modified ------------------------------------------------
return 1

end function

public function boolean of_isscreenchanged ();//////////////////////////////////////////////////////////////////////
// $<function> of_isscreenchanged
// $<arguments>
// $<returns> boolean
// $<description> Determines screen if was changed. (Corrected BugG031002)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.19.2009
//////////////////////////////////////////////////////////////////////

long ll_Changes

if uo_screen_design_menu.ib_IsScreenChanged then
	ll_Changes ++
end if

dw_properties.AcceptText()
dw_screen_objects.AcceptText()
ll_Changes += dw_properties.ModifiedCount() + dw_properties.DeletedCount()
ll_Changes += dw_screen_objects.ModifiedCount() + dw_screen_objects.DeletedCount()

if ll_Changes > 0 then
	Return true
else
	Return false
end if
end function

public function integer of_webview_format ();//Start Code Change ----06.14.2011 #V11 maha - created to arrange fields in WebView format

integer r
integer vx = 800
integer ix = 2500
integer vxl = 50
integer ixl = 2000
integer iy = 50
integer vy = 50
integer li_width
string ls_vis
string ls_field

//r = messagebox("Screen format","This function will format the field list so that the fields are in a column, one below the other, based on the current field order.  Invisible fields will be moved to the right of the Visible fields.  Do you wish to continue?",question!,yesno!,2)
//if r = 2 then return 1
dw_properties.SetFilter("" ) //clear filter in case set for selected field
dw_properties.Filter()
dw_properties.setsort("data_view_fields_field_order Asc")
dw_properties.sort()

for r = 1 to dw_properties.rowcount()
	ls_vis = dw_properties.getitemstring(r,"data_view_fields_visible")
	ls_field = dw_properties.getitemstring(r,"sys_fields_field_name")
	li_width = dw_properties.getitemnumber(r,"data_view_fields_field_label_width")
	
	if ls_vis = "Y" then
		if r > 1 then 
			vy+= 90
		end if
		
		vxl = vx - 20 - li_width
		dw_detail.modify( ls_field + ".x=" + string(vx) )
		dw_detail.modify( ls_field + ".y=" + string(vy) )
		dw_detail.modify( ls_field + "_t.x=" + string(vxl) )
		dw_detail.modify( ls_field + "_t.y=" + string(vy) )
		dw_detail.modify( ls_field + ".alignment =0" )
		dw_detail.modify( ls_field + "_t.alignment =1" )
//		dw_properties.setitem(r,"data_view_fields_field_x",vx )
//		dw_properties.setitem(r,"data_view_fields_field_y",vy )
//		dw_properties.setitem(r,"data_view_fields_field_label_x",vxl )
//		dw_properties.setitem(r,"data_view_fields_field_label_y",vy )
	else
		if r > 1 then 
			iy+= 90
		end if	
		dw_detail.modify( ls_field + ".x=" + string(ix) )
		dw_detail.modify( ls_field + ".y=" + string(iy) )
		dw_detail.modify( ls_field + "_t.x=" + string(ixl) )
		dw_detail.modify( ls_field + "_t.y=" + string(iy) )
//		dw_properties.setitem(r,"data_view_fields_field_x", ix )
//		dw_properties.setitem(r,"data_view_fields_field_y", iy )
//		dw_properties.setitem(r,"data_view_fields_field_label_x", ixl )
//		dw_properties.setitem(r,"data_view_fields_field_label_y", iy )		
	end if
next

//dw_properties.update()

return 1
	
end function

public function integer of_standard_format ();//Start Code Change ----06.14.2011 #V11 maha - created to arrange fields in the format

integer r
integer vis_x = 0
//integer vis_label_x = 50
integer vis_y = 0
integer vis_label_y = 0
integer li_width
integer line_width
integer max_width = 2600
integer curr_x 
integer next_x = 50
integer label_width
integer li_loop
integer field_width
integer li_high
integer line_total
boolean ab_newline = false
string ls_vis_invis
string ls_vis
string ls_field

//r = messagebox("Screen format","This function will format the field list so that the fields are in a column, one below the other, based on the current field order.  Invisible fields will be moved to the right of the Visible fields.  Do you wish to continue?",question!,yesno!,2)
//if r = 2 then return 1

//standard height = 64
//field y = label y + 70
//next row prior row field + 90
dw_properties.SetFilter("" )
dw_properties.Filter()
dw_properties.setsort("data_view_fields_field_order Asc")
dw_properties.sort()

//run through twice first doing the visible then the invisible
for li_loop = 1 to 2
	choose case li_loop
		case 1
			ls_vis_invis = "Y"
		case 2
			ls_vis_invis = "N"
			ab_newline = true
			next_x = 50
			vis_y+= 180  //add an additional row of spacing between visible and invisible
			vis_label_y+= 180
	end choose
	
	for r = 1 to dw_properties.rowcount()
		ls_vis = dw_properties.getitemstring(r,"data_view_fields_visible")
		ls_field = dw_properties.getitemstring(r,"sys_fields_field_name")
		label_width = dw_properties.getitemnumber(r,"data_view_fields_field_label_width")
		field_width = dw_properties.getitemnumber(r,"data_view_fields_field_width")
		li_high = dw_properties.getitemnumber(r,"data_view_fields_field_height")

		if ls_vis = ls_vis_invis  then
			if label_width > field_width then field_width = label_width   //get wider field or label
			//for the next field
			curr_x = next_x  //next x from prior loop
			next_x= next_x + field_width + 30
			if next_x > max_width then 
				curr_x = 50
				ab_newline = true
				next_x = 50 + field_width + 30
			else
				//next ok
			end if
			
			if vis_x = 0 then
				vis_x = 50
			else
				vis_x = curr_x
			end if
			
			if vis_y = 0 then vis_y = 120
			if vis_label_y = 0 then vis_label_y = 50
			if  ab_newline then
				vis_y+= 180
				vis_label_y+= 180
				ab_newline = false
			end if
			
			dw_detail.modify( ls_field + ".x=" + string(vis_x) )
			dw_detail.modify( ls_field + ".width=" + string(field_width) )
			dw_detail.modify( ls_field + ".y=" + string(vis_y) )
			dw_detail.modify( ls_field + "_t.x=" + string(vis_x) )
			dw_detail.modify( ls_field + "_t.width=" + string(field_width) )
			dw_detail.modify( ls_field + "_t.y=" + string(vis_label_y) )
			dw_detail.modify( ls_field + ".alignment =0" )
			dw_detail.modify( ls_field + "_t.alignment =0" )
			dw_properties.setitem(r,"data_view_fields_field_label_width", field_width) //this is to foce the 'save changes' message
			
		end if
	next
next



return 1
	
end function

on pfc_cst_u_data_entry_screen_painter.create
int iCurrent
call super::create
this.cb_screen_properties=create cb_screen_properties
this.sle_tab=create sle_tab
this.dw_properties=create dw_properties
this.cb_1=create cb_1
this.dw_fields_alias=create dw_fields_alias
this.dw_properties_report=create dw_properties_report
this.dw_properties_dataview=create dw_properties_dataview
this.dw_properties_modify=create dw_properties_modify
this.dw_properties_pmodify=create dw_properties_pmodify
this.dw_screen_objects=create dw_screen_objects
this.uo_screen_design_menu=create uo_screen_design_menu
this.st_tab=create st_tab
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_screen_properties
this.Control[iCurrent+2]=this.sle_tab
this.Control[iCurrent+3]=this.dw_properties
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_fields_alias
this.Control[iCurrent+6]=this.dw_properties_report
this.Control[iCurrent+7]=this.dw_properties_dataview
this.Control[iCurrent+8]=this.dw_properties_modify
this.Control[iCurrent+9]=this.dw_properties_pmodify
this.Control[iCurrent+10]=this.dw_screen_objects
this.Control[iCurrent+11]=this.uo_screen_design_menu
this.Control[iCurrent+12]=this.st_tab
end on

on pfc_cst_u_data_entry_screen_painter.destroy
call super::destroy
destroy(this.cb_screen_properties)
destroy(this.sle_tab)
destroy(this.dw_properties)
destroy(this.cb_1)
destroy(this.dw_fields_alias)
destroy(this.dw_properties_report)
destroy(this.dw_properties_dataview)
destroy(this.dw_properties_modify)
destroy(this.dw_properties_pmodify)
destroy(this.dw_screen_objects)
destroy(this.uo_screen_design_menu)
destroy(this.st_tab)
end on

event constructor;call super::constructor;IF gb_se_version THEN
	il_data_view_id = 2
END IF
end event

type cb_decheck from pfc_cst_u_data_entry`cb_decheck within pfc_cst_u_data_entry_screen_painter
end type

type st_dw_select_section_border from pfc_cst_u_data_entry`st_dw_select_section_border within pfc_cst_u_data_entry_screen_painter
end type

type cb_view_relation from pfc_cst_u_data_entry`cb_view_relation within pfc_cst_u_data_entry_screen_painter
integer x = 2071
integer width = 82
end type

type st_select from pfc_cst_u_data_entry`st_select within pfc_cst_u_data_entry_screen_painter
end type

type dw_addresses from pfc_cst_u_data_entry`dw_addresses within pfc_cst_u_data_entry_screen_painter
integer y = 1700
end type

type st_recs from pfc_cst_u_data_entry`st_recs within pfc_cst_u_data_entry_screen_painter
integer y = 1848
end type

type dw_ver_data from pfc_cst_u_data_entry`dw_ver_data within pfc_cst_u_data_entry_screen_painter
integer y = 1548
integer taborder = 80
end type

type dw_select_section from pfc_cst_u_data_entry`dw_select_section within pfc_cst_u_data_entry_screen_painter
integer x = 18
integer y = 292
integer width = 741
integer height = 1832
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
ib_profile = false  //Start Code Change ----11.29.2007 #V8 maha
ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 
uo_screen_design_menu.ii_screen = ii_screen_id  //Start Code Change ----10.10.2016 #V152 maha
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

//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.19.2009
//$<reason> Corrected BugG031002
if of_IsScreenChanged() then
	if parent.Event ue_ScreenChanged() = 1 then
		Return 1
	end if
	uo_screen_design_menu.ib_IsScreenChanged = false
end if
//------------------- APPEON END ---------------------

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
	inv_data_entry.of_create_dynamic_dw(il_prac_id, il_data_view_id, ii_screen_id, dw_detail, dw_browse, True, 0 , true)	
	IF dw_detail.RowCount() = 0 THEN
		dw_detail.InsertRow(0)
	END IF
	ib_relocating_fields = False
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 09.26.2006 By: Liang QingShi
	//$<reason> Fix a defect.
	/*
	w_design_menu.st_relocate_field.BorderStyle = StyleRaised!
	*/
	uo_screen_design_menu.st_relocate_field.BorderStyle = StyleRaised!
	
	//---------------------------- APPEON END ----------------------------
	Return 1
END IF


end event

type dw_loc_defaults from pfc_cst_u_data_entry`dw_loc_defaults within pfc_cst_u_data_entry_screen_painter
end type

type r_1 from pfc_cst_u_data_entry`r_1 within pfc_cst_u_data_entry_screen_painter
end type

type dw_link_list from pfc_cst_u_data_entry`dw_link_list within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer y = 1424
end type

type dw_detail from pfc_cst_u_data_entry`dw_detail within pfc_cst_u_data_entry_screen_painter
event ue_down_key pbm_dwnkey
event ue_mouse_move pbm_dwnmousemove
integer x = 814
integer y = 280
integer width = 2761
integer taborder = 60
boolean hscrollbar = true
boolean vscrollbar = true
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
//Start Code Change ---- 11.21.2005 #93 maha error trap
if upperbound(il_last_object_x[]) < 1 then
	return -1
end if

//End Code Change---11.21.2005 
//w_prac_data_design.TITLE = STRING(keyflags)

IF keyflags = 2 THEN
	IF KeyDown( KeyDownArrow! ) OR KeyDown( KeyUpArrow! )THEN
		li_x1_pos = Integer( This.Describe( is_last_object[1] + ".x" )) -25
		li_x2_pos = li_x1_pos + Integer( This.Describe( is_last_object[1] + ".width" ) ) + 25

		li_y1_pos = Integer( This.Describe( is_last_object[1] + ".y" )) 
		
		//il_ancor_x = Integer( This.Describe( is_last_object[1] + ".x" ))
		//il_ancor_y = Integer( This.Describe( is_last_object[1] + ".y"))
		//li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2  //Commented By Ken.Guo 06.13.2008
		li_obj_cnt = Integer(This.Describe("DataWindow.Column.Count")) * 2 //Added By Ken.Guo 06.13.2008
		
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

		//li_obj_cnt = Integer( This.Object.DataWindow.Column.Count ) * 2  //Commented By Ken.Guo 06.13.2008
		li_obj_cnt = Integer(This.Describe("DataWindow.Column.Count")) * 2 //Added By Ken.Guo 06.13.2008
		
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
			if li_x_pos >= li_pixels then //Add by Evan 01/10/2008
				This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
				dw_properties.SetItem(1, "data_view_fields_field_x", li_x_pos )
			end if
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

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> 
/*
w_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
*/									
uo_screen_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
									
//---------------------------- APPEON END ----------------------------

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
	ll_y_diff = (This.Pointery() + il_vscroll_pos /*- il_last_object_y[1] ) + (il_last_object_y[1]*/ - il_ancor_y ) //Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
	ll_x_diff = (This.Pointerx() + il_hscroll_pos /*- il_last_object_x[1] ) + (il_last_object_x[1] */- il_ancor_x ) //Added 'il_hscroll_pos' By Ken.Guo 06.16.2008
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2006-08-22 By: Liu Hongxin
	//$<reason> Performance tuning.
	/*
	FOR i = 1 TO ii_obj_select_cnt
		ll_y = il_last_object_y[i] + ll_y_diff 
		ll_x = il_last_object_x[i] + ll_x_diff
		idw_detail.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )
		IF Right( is_last_object[i], 2 ) = "_t" THEN
			dw_properties.SetItem(1, "data_view_fields_field_label_y", ll_y) 
		ELSEIF Pos( is_last_object[1], "obj" ) = 0 THEN
			dw_properties.SetItem(1, "data_view_fields_field_y", ll_y) 
		END IF		
		IF is_last_object[1] <> "detail_band" THEN
			idw_detail.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
			IF Right( is_last_object[i], 2 ) = "_t" THEN
				dw_properties.SetItem(1, "data_view_fields_field_label_x", ll_x) 
			ELSEIF Pos( is_last_object[i], "obj" ) = 0 THEN
				dw_properties.SetItem(1, "data_view_fields_field_x", ll_x) 
			END IF	
		END IF
	END FOR
		*/
	if abs(il_y_diff - ll_y_diff) + abs(il_x_diff - ll_x_diff) < 5 then return

	FOR i = 1 TO ii_obj_select_cnt
		ll_y = il_last_object_y[i] + ll_y_diff 
		ll_x = il_last_object_x[i] + ll_x_diff

		IF (il_y_diff - ll_y_diff) <> 0 THEN
			idw_detail.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )
			IF RightA( is_last_object[i], 2 ) = "_t" THEN
				dw_properties.SetItem(1, "data_view_fields_field_label_y", ll_y) 
			ELSEIF PosA( is_last_object[1], "obj" ) = 0 THEN
				dw_properties.SetItem(1, "data_view_fields_field_y", ll_y) 
			END IF
		END IF
		IF is_last_object[1] <> "detail_band" THEN
			IF (il_x_diff - ll_x_diff) <> 0 then
				idw_detail.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
				IF RightA( is_last_object[i], 2 ) = "_t" THEN
					dw_properties.SetItem(1, "data_view_fields_field_label_x", ll_x) 
				ELSEIF PosA( is_last_object[i], "obj" ) = 0 THEN
					dw_properties.SetItem(1, "data_view_fields_field_x", ll_x) 
				END IF
			END IF
		END IF
	END FOR
	il_x_diff = ll_x_diff
	il_y_diff = ll_y_diff
	//---------------------------- APPEON END ----------------------------
ELSEIF (This.Pointerx() + il_hscroll_pos > il_last_object_x[1] + il_last_object_width[1] - 20) AND (This.Pointerx() + il_hscroll_pos < il_last_object_x[1] + il_last_object_width[1]-2) THEN //Added 'il_hscroll_pos' By Ken.Guo 06.16.2008
	Ib_resize_width = True
	SetPointer(SizeWE!)
ELSEIF (This.Pointery() + il_vscroll_pos > il_last_object_y[1] + il_last_object_height[1] - 10) AND (This.Pointery() + il_vscroll_pos < il_last_object_y[1] + il_last_object_height[1]-2) THEN //Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
	Ib_resize_height = True
	SetPointer(SizeNS!)
ELSEIF ib_resize_width AND ib_mouse_down THEN
	SetPointer(SizeWE!)
	ll_x_diff = This.Pointerx() + il_hscroll_pos - (il_last_object_x[1] + il_last_object_width[1]) //Added 'il_hscroll_pos' By Ken.Guo 06.16.2008
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
	ll_y_diff = This.Pointery() + il_vscroll_pos - (il_last_object_y[1] + il_last_object_height[1])//Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
	ll_new_height = il_last_object_height[1] + ll_y_diff
	il_last_object_height[1] = ll_new_height
	idw_detail.Modify( is_last_object[1] + ".height = '" + String( ll_new_height ) + "'" )
	IF RightA( is_last_object[1], 2 ) <> "_t" AND	PosA( is_last_object[1], "obj" ) = 0 THEN
		dw_properties.SetItem(1, "data_view_fields_field_height", ll_new_height) 
	END IF			
ELSE
	Ib_resize_width = False
	Ib_resize_height = False
	return
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-08-23 By: Liu Hongxin
//$<reason> Fix defect.
/*
w_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
   								"  Y:" + String(il_last_object_y[1]) +&
	   							"  Width:" + String(il_last_object_width[1]) +&
		   						"  Height:" + String(il_last_object_height[1])
*/
uo_screen_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1] + ll_x_diff) +&
									"  Y:" + String(il_last_object_y[1] + ll_y_diff) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
//---------------------------- APPEON END ----------------------------
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
	   il_ancor_x = Pointerx() + il_hscroll_pos //Added 'il_hscroll_pos' By Ken.Guo 06.16.2008
		il_ancor_y = Pointery() + il_vscroll_pos //Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
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

event dw_detail::scrollvertical;il_dw_scroll_pos = Long(This.Describe("DataWindow.VerticalScrollPosition"))
il_vscroll_pos = il_dw_scroll_pos //Added By Ken.Guo 06.16.2008

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
Long   li_field_id[]

//IF il_data_view_id = 1 THEN
//	MessageBox("Default System View", "You can not change the default system view.")
//	Return
//END IF
ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )

IF ib_set_tab_order THEN
	IF LeftA( ls_selected_object_name, 4 ) = "tab_" THEN
		string ls_Retval
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-06
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> dbName is not fully supported (support to read and not write).
		//$<modification> Replace dbName with TabSequence to provide the same functionality.
		//ls_retval = This.Modify( Mid( is_last_tab_label_name, 5,100) + ".dbname = '" + sle_tab.Text + "'" )		
		ls_retval = This.Modify( MidA( is_last_tab_label_name, 5,100) + ".TabSequence = '" + sle_tab.Text + "'" )		
		//---------------------------- APPEON END ----------------------------

		This.Modify( is_last_tab_label_name + ".text = '" + sle_tab.Text + "'" )		
		sle_tab.Text = This.Describe( ls_selected_object_name + ".tabsequence" ) 
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 08.12.2006 By: LeiWei
		//$<reason> Fix a defect.
		/*
		sle_tab.x = Long( This.Describe( ls_selected_object_name + ".x" ) ) + This.x
		sle_tab.y = Long( This.Describe( ls_selected_object_name + ".y" ) ) + This.y
		*/
		sle_tab.x = Long( This.Describe( ls_selected_object_name + ".x" ) ) + This.x - Long( dw_detail.Describe("datawindow.HorizontalScrollPosition"))
		sle_tab.y = Long( This.Describe( ls_selected_object_name + ".y" ) ) + This.y - Long( dw_detail.Describe("datawindow.VerticalScrollPosition"))
		//---------------------------- APPEON END ----------------------------

		sle_tab.SetFocus()
		sle_tab.BringToTop = True
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> UM-07
		//$<modify> 01.13.2006 By: LeiWei
		//$<reason> dbName is not fully supported (support to read and not write).
		//$<modification> Replace dbName with TabSequence to provide the same functionality. 
		//sle_tab.Text = idw_detail.Describe( Mid( ls_selected_object_name, 5, 100 ) + ".dbname" )			
		sle_tab.Text = idw_detail.Describe( MidA( ls_selected_object_name, 5, 100 ) + ".TabSequence" )			
		//---------------------------- APPEON END ----------------------------
		sle_tab.SelectText( 1, 100 )
	   is_last_tab_label_name = ls_selected_object_name
		RETURN 
	END IF
END IF

IF NOT ib_multi_select THEN
	FOR i = 1 TO ii_obj_select_cnt
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-08-30 By: Liu HongXin
		//$<reason> Fix defect: If it is stand-alone text object, it's border is wrong.
		/*
		IF Right(is_last_object[i], 2) = "_t" THEN
		*/
		//IF Right(is_last_object[i], 2) = "_t" or Left(is_last_object[i], 6) = "object" THEN //Commented By Ken.Guo 16.16.2008
		If This.Describe(is_last_object[i]+'.Type') = 'text' Then //Added By Ken.Guo 06.16.2008.Fixed BugK061601
		//---------------------------- APPEON END ----------------------------
			This.Modify( is_last_object[i] + ".border = '0'" )
		ELSE
			This.Modify( is_last_object[i] + ".border = '5'" )
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
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-08
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> dbName is not fully supported (support to read and not write).
	//$<modification> Replace dbName with TabSequence to provide the same functionality.
	//This.Modify( ls_selected_object_name + ".dbname = '" + String( ii_tab_sequence ) + "'" )
	This.Modify( ls_selected_object_name + ".TabSequence = '" + String( ii_tab_sequence ) + "'" )
	//---------------------------- APPEON END ----------------------------
	Return
END IF

IF ( ls_selected_object_name = "" AND ii_obj_select_cnt = 0 ) THEN
	ii_field_id[] = li_field_id[]
	RETURN
END IF
	
IF (ls_selected_object_name = "" AND ii_obj_select_cnt > 0) THEN
	ib_multi_select = False
	FOR i = 1 TO ii_obj_select_cnt
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 2006-08-30 By: Liu HongXin
		//$<reason> Fix defect: If it is stand-alone text object, it's border is wrong.
		/*
		IF Right(is_last_object[i], 2) = "_t" THEN
		*/
		//IF Right(is_last_object[i], 2) = "_t" or Left(is_last_object[i], 6) = "object" THEN //Commented By Ken.Guo 04.18.2008
		If This.Describe(is_last_object[i]+'.Type') = 'text' Then //Added By Ken.Guo 06.16.2008.Fixed BugK061601
		//---------------------------- APPEON END ----------------------------
			This.Modify( is_last_object[i] + ".border = '0'" )
		ELSE
			This.Modify( is_last_object[i] + ".border = '5'" )
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
	il_ancor_x = Pointerx() + il_hscroll_pos //Added 'il_hscroll_pos' By Ken.Guo 06.16.2008
	il_ancor_y = Pointery() + il_vscroll_pos //Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
   is_last_object_width = This.Describe( ls_selected_object_name + ".width" )
   is_last_object_height = This.Describe( ls_selected_object_name + ".height" )
END IF

is_last_object[ii_obj_select_cnt] = ls_selected_object_name

ii_field_id[ii_obj_select_cnt] = Integer( This.Describe( is_last_object[ii_obj_select_cnt] + ".tag" ) )

il_last_object_y[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".y") )
il_last_object_x[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".x") )
il_last_object_width[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".width") )
il_last_object_height[ii_obj_select_cnt] = Long( This.Describe( is_last_object[ii_obj_select_cnt] + ".height"))

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
w_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
														

w_design_menu.st_object_name.Text = is_last_object[1]
*/
uo_screen_design_menu.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
														

uo_screen_design_menu.st_object_name.Text = is_last_object[1]

//---------------------------- APPEON END ----------------------------

This.Modify( ls_selected_object_name + ".border = '2'" )

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.15.2006 By: LeiWei
//$<reason> Fix a defect.
If ls_field_id="?" Or ls_field_id="!" Or ls_field_id="" Then ls_field_id="0"
//---------------------------- APPEON END ----------------------------

IF PosA( is_last_object[1], "obj" ) = 0 AND ls_selected_object_name <> "detail_band" THEN
	dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
	dw_properties.Filter()
else  //(Appeon)Stephen 06.30.2014 - Bug 4090: Issues found after Go-Live
	dw_properties.SetFilter("1<>1")
	dw_properties.Filter()
END IF

ls_text = This.Describe( ls_selected_object_name + ".text" )

IF ls_text <> "?" AND ls_text <> "!" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 09.26.2006 By: Liang QingShi
	//$<reason> 
	/*
	w_design_menu.dw_1.SetText( ls_text )
	*/
	uo_screen_design_menu.dw_1.SetText( ls_text )
	
	//---------------------------- APPEON END ----------------------------
END IF

ls_alignment = This.Describe(is_last_object[ii_obj_select_cnt] + ".alignment")

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> 
/*
w_design_menu.st_left.BorderStyle = StyleRaised!
w_design_menu.st_right.BorderStyle = StyleRaised!
w_design_menu.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	w_design_menu.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	w_design_menu.st_right.BorderStyle = StyleLowered!
ELSE
	w_design_menu.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	w_design_menu.st_bold.BorderStyle = StyleRaised!
ELSE
	w_design_menu.st_bold.BorderStyle = StyleLowered!
END IF
*/
uo_screen_design_menu.st_left.BorderStyle = StyleRaised!
uo_screen_design_menu.st_right.BorderStyle = StyleRaised!
uo_screen_design_menu.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	uo_screen_design_menu.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	uo_screen_design_menu.st_right.BorderStyle = StyleLowered!
ELSE
	uo_screen_design_menu.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	uo_screen_design_menu.st_bold.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu.st_bold.BorderStyle = StyleLowered!
END IF

//---------------------------- APPEON END ----------------------------

ls_italic = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.italic")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-09
//$<add> 05.06.2006 By: Cao YongWang
//$<reason> The default value of font.italic on the Web is ?, which will make the logic incorrect.
//$<modification> Set ls_italic to 0 when it is ? on the Web.
If appeongetclienttype() <> 'PB' Then
	If ls_italic = '?' Then ls_italic = '0'
End if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
IF ls_italic = "0" THEN
	w_design_menu.st_italic.BorderStyle = StyleRaised!
ELSE
	w_design_menu.st_italic.BorderStyle = StyleLowered!
END IF
*/
IF ls_italic = "0" THEN
	uo_screen_design_menu.st_italic.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu.st_italic.BorderStyle = StyleLowered!
END IF

//---------------------------- APPEON END ----------------------------

ls_underline = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.underline")
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2006 By: Cao YongWang
//$<reason> The default value is ? in web application.
If appeongetclienttype() <> 'PB' Then
	If ls_underline = '?' Then ls_underline = '0'
End if
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
IF ls_underline = "0" THEN
	w_design_menu.st_underline.BorderStyle = StyleRaised!
ELSE
	w_design_menu.st_underline.BorderStyle = StyleLowered!
END IF
*/
IF ls_underline = "0" THEN
	uo_screen_design_menu.st_underline.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu.st_underline.BorderStyle = StyleLowered!
END IF
//---------------------------- APPEON END ----------------------------

end event

event dw_detail::rbuttondown;//overwrite
end event

event dw_detail::itemfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-24 By: Liu Hongxin
//$<reason> Performance tuning: ancestor is redundancy.
//---------------------------- APPEON END ----------------------------
end event

event dw_detail::scrollhorizontal;call super::scrollhorizontal;il_hscroll_pos = Long(This.Describe("DataWindow.HorizontalScrollPosition")) //Added By Ken.Guo 06.16.2008
end event

type dw_browse from pfc_cst_u_data_entry`dw_browse within pfc_cst_u_data_entry_screen_painter
integer x = 1303
integer y = 312
integer width = 2149
integer height = 460
integer taborder = 70
end type

type tab_view from pfc_cst_u_data_entry`tab_view within pfc_cst_u_data_entry_screen_painter
integer x = 814
integer y = 280
integer width = 2761
integer height = 1548
integer taborder = 50
boolean bringtotop = true
end type

event tab_view::selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LiuHongXin
//$<reason> Fix a defect.
IF OldIndex = -1 THEN RETURN -1
//---------------------------- APPEON END ----------------------------

//BEGIN-Modify by Evan 12.14.2010
//IF Parent_window_design.Event pfc_Save() < 0 THEN
IF w_prac_data_design.Event pfc_Save() < 0 THEN
//END-Modify by Evan 12.14.2010
	Return 1
END IF

end event

event tab_view::selectionchanged;If not dw_select_section.GetRow() > 0 Then return
IF newindex = 3 THEN
	ii_screen_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id_2" )	
	of_select_screen( dw_select_section.GetRow( ), dw_select_section.GetItemNumber( dw_select_section.GetRow(), "table_id_2" ) )
ELSE
	ii_screen_id = dw_select_section.GetItemNumber( dw_select_section.GetRow(), "screen_id" ) 	
	of_select_screen( dw_select_section.GetRow( ), dw_select_section.GetItemNumber( dw_select_section.GetRow(), "screen_id" ) )	
END IF



end event

type tabpage_browse from pfc_cst_u_data_entry`tabpage_browse within tab_view
boolean visible = false
integer width = 2725
integer height = 1432
end type

type tabpage_details from pfc_cst_u_data_entry`tabpage_details within tab_view
integer width = 2725
integer height = 1432
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
integer width = 2725
integer height = 1432
end type

type dw_detail_2 from pfc_cst_u_data_entry`dw_detail_2 within tabpage_image
boolean visible = false
integer y = 296
integer width = 2720
integer height = 1244
end type

type tabpage_linked_data from pfc_cst_u_data_entry`tabpage_linked_data within tab_view
integer width = 2725
integer height = 1432
end type

type uo_linked_data from pfc_cst_u_data_entry`uo_linked_data within tabpage_linked_data
end type

type sle_1 from singlelineedit within tabpage_details
integer x = 87
integer y = 756
integer width = 247
integer height = 92
integer taborder = 40
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

type cb_screen_properties from u_cb within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 114
integer y = 1828
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

type sle_tab from singlelineedit within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 699
integer y = 644
integer width = 165
integer height = 68
integer taborder = 50
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

type dw_properties from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 59
integer y = 488
integer width = 690
integer height = 1204
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_sys_field_properties"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type cb_1 from commandbutton within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 581
integer y = 312
integer width = 165
integer height = 64
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked;open(w_profile_dynam_test)
end event

type dw_fields_alias from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 114
integer y = 428
integer width = 475
integer height = 292
integer taborder = 11
string dataobject = "d_view_fields_alias_screen"
boolean vscrollbar = false
boolean livescroll = false
end type

type dw_properties_report from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 1234
integer y = 1872
integer width = 942
integer height = 1204
integer taborder = 50
boolean bringtotop = true
string dataobject = "d_sys_report_field_properties_sys"
end type

event constructor;call super::constructor;dw_properties_report.dataobject = 'd_sys_report_fields_byscr_upd' //alfee 02.16.2009
This.of_SetTransObject( SQLCA )
end event

type dw_properties_dataview from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 1257
integer y = 1860
integer width = 942
integer height = 1204
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_sys_report_field_properties_dataview"
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

type dw_properties_modify from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 1234
integer y = 1864
integer width = 942
integer height = 1204
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_sys_report_field_properties_modify"
end type

type dw_properties_pmodify from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 1280
integer y = 1868
integer width = 942
integer height = 1204
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_sys_report_field_properties_modify"
boolean minbox = true
end type

type dw_screen_objects from u_dw within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 96
integer y = 688
integer width = 462
integer height = 236
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_screen_objects"
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble(True)
end event

type uo_screen_design_menu from uo_design_menu within pfc_cst_u_data_entry_screen_painter
integer taborder = 10
boolean bringtotop = true
boolean border = true
end type

on uo_screen_design_menu.destroy
call uo_design_menu::destroy
end on

type st_tab from statictext within pfc_cst_u_data_entry_screen_painter
boolean visible = false
integer x = 1449
integer y = 108
integer width = 1495
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 28311551
boolean enabled = false
string text = "Click on red tab labels to modify."
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

