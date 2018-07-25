$PBExportHeader$pfc_cst_u_data_entry_report_painter.sru
forward
global type pfc_cst_u_data_entry_report_painter from pfc_cst_u_data_entry_screen_painter
end type
type dw_screen_report_objects from u_dw within pfc_cst_u_data_entry_report_painter
end type
type uo_screen_design_menu_new from uo_design_menu_report within pfc_cst_u_data_entry_report_painter
end type
type cb_model from commandbutton within pfc_cst_u_data_entry_report_painter
end type
type dw_select from u_dw within pfc_cst_u_data_entry_report_painter
end type
type st_1 from statictext within pfc_cst_u_data_entry_report_painter
end type
end forward

global type pfc_cst_u_data_entry_report_painter from pfc_cst_u_data_entry_screen_painter
event type integer pfc_cst_select_view_first ( )
dw_screen_report_objects dw_screen_report_objects
uo_screen_design_menu_new uo_screen_design_menu_new
cb_model cb_model
dw_select dw_select
st_1 st_1
end type
global pfc_cst_u_data_entry_report_painter pfc_cst_u_data_entry_report_painter

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 26/08/2008 By: Alan
//$<reason> 
String	is_curdw
String	is_reportfrom
Long 		il_profile_view_id = 999
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_otherproperty_sheet ()
public function integer of_pre_pfc_save ()
public function integer of_pre_save_report_modify ()
public function integer of_property_sheet ()
public function integer of_select_screen (integer currentrow, integer ai_screen_id)
public function integer of_select_view ()
public function integer of_setup_painter ()
public function integer of_show_invisible (boolean ab_show)
public function integer of_set_parent_window (w_prac_report_design aw_win)
public subroutine of_modify_dwstatus ()
public function integer of_select_profile_view ()
public function integer of_select_view (integer ai_screen_id)
public function integer of_select_profile_view (boolean ab_firsttime)
end prototypes

event type integer pfc_cst_select_view_first();//Select profile view at first time -- Alfee 02.23.2009
Return of_select_profile_view(TRUE) 

end event

public function integer of_otherproperty_sheet ();String ls_field_id

//Added by Alan on 2008-09-18
if Isvalid(w_mdi) then
	if w_mdi.of_security_access(6940) = 0 then Return -1
end if
//Added by Alan on 2008-09-18

IF UpperBound( is_last_object[] ) = 0 THEN
	MessageBox("Select", "You must first select a object by clicking on it." )
	RETURN -1
END IF

IF IsNull( is_last_object[1] ) OR is_last_object[1] = "" THEN
	MessageBox("Select", "You must first select a object by clicking on it." )
	RETURN -1
END IF

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2006 By: Liang QingShi
//$<reason> Fix a defect. 
/*
dw_properties.SetFilter("data_view_report_fields_field_id = " + ls_field_id )
dw_properties.Filter()
*/
if ls_field_id <> '?' and ls_field_id <> '!' then
	dw_screen_report_objects.SetFilter("data_view_object_id = " + ls_field_id )
	dw_screen_report_objects.Filter()
else
	return 0
end if
//---------------------------- APPEON END ----------------------------

IF NOT IsValid(w_other_properties_report) THEN
	Open(w_other_properties_report)
END IF

Return 0
end function

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
integer fw
FOR i = 1 TO li_col_cnt
	ls_field_nm = dw_properties.GetItemString(i, "sys_report_fields_field_name" )
	ls_field_x = idw_detail.Describe( ls_field_nm + ".x" )
	//For Column
	dw_properties.SetItem(i, "data_view_report_fields_field_x", Integer(idw_detail.Describe( ls_field_nm + ".x" )) )
	dw_properties.SetItem(i, "data_view_report_fields_field_y", Integer(idw_detail.Describe( ls_field_nm + ".y" )) )
	dw_properties.SetItem(i, "data_view_report_fields_justification", Integer(idw_detail.Describe( ls_field_nm + ".alignment" )) )
	dw_properties.SetItem(i, "data_view_report_fields_field_width", Integer(idw_detail.Describe( ls_field_nm + ".width" )) )	
	dw_properties.SetItem(i, "data_view_report_fields_field_height", Integer(idw_detail.Describe( ls_field_nm + ".height" )) )	
	dw_properties.SetItem(i, "data_view_report_fields_font_wieght", Integer(idw_detail.Describe( ls_field_nm + ".font.weight" )) )	//Modified By Ken.Guo 04.01.2008,Replaced "_t.font.weight"	
	dw_properties.SetItem(i, "data_view_report_fields_field_underline", String(idw_detail.Describe( ls_field_nm + ".font.underline" )) ) //Added By Ken.Guo 04.01.2008
	dw_properties.SetItem(i, "data_view_report_fields_field_font_italic", Integer(idw_detail.Describe( ls_field_nm + ".font.italic" )) ) //Added By Ken.Guo 04.01.2008
		
	//For Label
	ls_retval = MidA(idw_detail.Describe( ls_field_nm + "_t.text" ) , 1, 5000)
	dw_properties.SetItem(i, "data_view_report_fields_field_label", ls_retval )
	dw_properties.SetItem(i, "data_view_report_fields_field_label_x", Integer(idw_detail.Describe( ls_field_nm + "_t.x" )) )
	dw_properties.SetItem(i, "data_view_report_fields_field_label_y", Integer(idw_detail.Describe( ls_field_nm + "_t.y" )) )
	dw_properties.SetItem(i, "data_view_report_fields_label_justification", Integer(idw_detail.Describe( ls_field_nm + "_t.alignment" )) )	
	dw_properties.SetItem(i, "data_view_report_fields_field_label_width", Integer(idw_detail.Describe( ls_field_nm + "_t.width" )) )	
fw =  Integer(idw_detail.Describe( ls_field_nm + "_t.font.weight" )) 
//messagebox("weight",fw)
	dw_properties.SetItem(i, "data_view_report_fields_label_font_weight",fw)	//Added By Ken.Guo 04.01.2008	
	dw_properties.SetItem(i, "data_view_report_fields_label_underline", String(idw_detail.Describe( ls_field_nm + "_t.font.underline" )) )	 //Added By Ken.Guo 04.01.2008	
	dw_properties.SetItem(i, "data_view_report_fields_label_font_italic", Integer(idw_detail.Describe( ls_field_nm + "_t.font.italic" )) ) //Added By Ken.Guo 04.01.2008
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> UM-01
	//$<modify> 01.13.2006 By: LeiWei
	//$<reason> dbName is not fully supported (support to read and not write).
	//$<modification> Replace dbName with TabSequence to provide the same functionality.
	//li_field_order =  Integer(idw_detail.Describe( ls_field_nm + ".dbname" ))
//	li_field_order =  Integer(idw_detail.Describe( ls_field_nm + ".TabSequence" ))
	//---------------------------- APPEON END ----------------------------
	
//	IF li_field_order > 0 THEN
//		dw_properties.SetItem(i, "data_view_report_fields_field_order", li_field_order )	
//	END IF
END FOR
//Added by Alan on 2008-10-16
of_modify_dwstatus()

dw_properties.SetSort( "data_view_report_fields_field_order" )
dw_properties.Sort()
//dw_properties.SetFilter( "data_view_report_fields_visible='Y'" )
//dw_properties.Filter()
//li_col_cnt = dw_properties.RowCount()

//FOR i = 1 TO li_col_cnt
//	dw_properties.SetItem( i, "data_view_report_fields_field_order", i * 10 )
//	ls_field_nm = dw_properties.GetItemString(i, "sys_report_fields_field_name" )
//	//--------------------------- APPEON BEGIN ---------------------------
//	//$<ID> UM-02
//	//$<modify> 01.13.2006 By: LeiWei
//	//$<reason> dbName is not fully supported (support to read and not write).
//	//$<modification> Replace dbName with TabSequence to provide the same functionality.
//	//dw_detail.Modify( ls_field_nm + ".dbname = '" + String(i * 10) + "'" )
//	dw_detail.Modify( ls_field_nm + ".TabSequence = '" + String(i * 10) + "'" )
//	//---------------------------- APPEON END ----------------------------
//END FOR

//dw_properties.SetFilter( "" )
//dw_properties.Filter()


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
END FOR

//alan
dw_screen_report_objects.AcceptText()

li_col_cnt = dw_screen_report_objects.RowCount()

FOR i = 1 TO li_col_cnt
	ls_obj_name = dw_screen_report_objects.GetItemstring(i, "object_name" ) 
	dw_screen_report_objects.SetItem(i, "object_x", Integer(idw_detail.Describe( ls_obj_name + ".x" )))
	dw_screen_report_objects.SetItem(i, "object_y", Integer(idw_detail.Describe( ls_obj_name + ".y" )))
	dw_screen_report_objects.SetItem(i, "object_width", Integer(idw_detail.Describe( ls_obj_name + ".width" )))
	dw_screen_report_objects.SetItem(i, "object_height", Integer(idw_detail.Describe( ls_obj_name + ".height" )))
	ls_retval = idw_detail.Describe( ls_obj_name + ".text" )
	dw_screen_report_objects.SetItem(i, "object_text", ls_retval)
	dw_screen_report_objects.SetItem(i, "object_alignment", Integer(idw_detail.Describe( ls_obj_name + ".alignment" )))
	dw_screen_report_objects.SetItem(i, "object_underline", Integer(idw_detail.Describe( ls_obj_name + ".font.underline" )))
	dw_screen_report_objects.SetItem(i, "object_bold", Integer(idw_detail.Describe( ls_obj_name + ".font.weight" )))
	dw_screen_report_objects.SetItem(i, "object_italic", Integer(idw_detail.Describe( ls_obj_name + ".font.italic" )))	
END FOR

//
of_pre_save_report_modify()

COMMIT USING SQLCA;





RETURN 1
end function

public function integer of_pre_save_report_modify ();//
long		i,ll_count
string	ls_tmp
int		li_i

ll_count = dw_properties.rowcount()
for i=1 to ll_count
	if dw_properties.getitemstring(i,"ismodify") = '1'	then continue
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_field_case",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_field_case",primary!,true)
	end if
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_field_case",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_field_mask",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_field_mask",primary!,true)
	end if
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_field_mask",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_lookup_field",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_lookup_field",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_lookup_field",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_lookup_type",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_lookup_type",primary!,true)
	end if
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_lookup_type",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if		
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_lookup_code",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_lookup_code",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_lookup_code",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"sys_report_fields_lookup_field_name",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"sys_report_fields_lookup_field_name",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"sys_report_fields_lookup_field_name",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"sys_report_fields_drop_down_width",primary!,true)) then
		li_i=100
	else
		li_i=dw_properties.getitemnumber(i,"sys_report_fields_drop_down_width",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"sys_report_fields_drop_down_width",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"data_view_report_fields_visible",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"data_view_report_fields_visible",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"data_view_report_fields_visible",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_x",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_x",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_y",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_y",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_width",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_width",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_height",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_height",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"data_view_report_fields_field_underline",primary!,true)) then
		ls_tmp='0'
	else
		ls_tmp=dw_properties.getitemstring(i,"data_view_report_fields_field_underline",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"data_view_report_fields_field_underline",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"data_view_report_fields_field_font_italic",primary!,true)) then
		li_i=0
	else
		li_i=dw_properties.getitemnumber(i,"data_view_report_fields_field_font_italic",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"data_view_report_fields_field_font_italic",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"data_view_report_fields_font_wieght",primary!,true)) then
		li_i=400
	else
		li_i=dw_properties.getitemnumber(i,"data_view_report_fields_font_wieght",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"data_view_report_fields_font_wieght",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if	
	if isnull(dw_properties.getitemstring(i,"data_view_report_fields_justification",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"data_view_report_fields_justification",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"data_view_report_fields_justification",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_properties.getitemstring(i,"data_view_report_fields_field_label",primary!,true) <> dw_properties.getitemstring(i,"data_view_report_fields_field_label",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_label_x",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_label_x",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_label_y",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_label_y",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_properties.getitemnumber(i,"data_view_report_fields_field_label_width",primary!,true) <> dw_properties.getitemnumber(i,"data_view_report_fields_field_label_width",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"data_view_report_fields_label_font_italic",primary!,true)) then
		li_i=0
	else
		li_i=dw_properties.getitemnumber(i,"data_view_report_fields_label_font_italic",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"data_view_report_fields_label_font_italic",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"data_view_report_fields_label_font_weight",primary!,true)) then
		li_i=0
	else
		li_i=dw_properties.getitemnumber(i,"data_view_report_fields_label_font_weight",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"data_view_report_fields_label_font_weight",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemnumber(i,"data_view_report_fields_label_justification",primary!,true)) then
		li_i=0
	else
		li_i=dw_properties.getitemnumber(i,"data_view_report_fields_label_justification",primary!,true)
	end if	
	if li_i <> dw_properties.getitemnumber(i,"data_view_report_fields_label_justification",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if
	if isnull(dw_properties.getitemstring(i,"data_view_report_fields_label_underline",primary!,true)) then
		ls_tmp=''
	else
		ls_tmp=dw_properties.getitemstring(i,"data_view_report_fields_label_underline",primary!,true)
	end if	
	if ls_tmp <> dw_properties.getitemstring(i,"data_view_report_fields_label_underline",primary!,false) then
		dw_properties.setitem(i,"ismodify",'1')
		continue
	end if		
next
//
ll_count = dw_screen_report_objects.rowcount()
for i=1 to ll_count
	if dw_screen_report_objects.getitemstring(i,"ismodify") = '1'	then continue
	if dw_screen_report_objects.getitemstring(i,"object_text",primary!,true) <> dw_screen_report_objects.getitemstring(i,"object_text",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_screen_report_objects.getitemnumber(i,"object_x",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_x",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_screen_report_objects.getitemnumber(i,"object_y",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_y",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_screen_report_objects.getitemnumber(i,"object_width",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_width",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if
	if dw_screen_report_objects.getitemnumber(i,"object_height",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_height",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_screen_report_objects.getitemnumber(i,"object_alignment",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_alignment",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_screen_report_objects.getitemnumber(i,"object_italic",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_italic",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if		
	if dw_screen_report_objects.getitemnumber(i,"object_bold",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_bold",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if			
	if dw_screen_report_objects.getitemnumber(i,"object_underline",primary!,true) <> dw_screen_report_objects.getitemnumber(i,"object_underline",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if	
	if dw_screen_report_objects.getitemstring(i,"visible",primary!,true) <> dw_screen_report_objects.getitemstring(i,"visible",primary!,false) then
		dw_screen_report_objects.setitem(i,"ismodify",'1')
		continue
	end if	
next


return 1

end function

public function integer of_property_sheet ();String ls_field_id

//Added by Alan on 2008-09-18
IF IsValid(w_mdi) THEN
	IF w_mdi.of_security_access(6940) = 0 THEN RETURN -1
END IF
//Added by Alan on 2008-09-18

IF UpperBound( is_last_object[] ) = 0 THEN
	MessageBox("Select", "You must first select a object by clicking on it." )
	RETURN -1
END IF

IF IsNull( is_last_object[1] ) Or is_last_object[1] = "" THEN
	MessageBox("Select", "You must first select a object by clicking on it." )
	RETURN -1
END IF

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03.23.2006 By: Liang QingShi
//$<reason> Fix a defect. 
/*
dw_properties.SetFilter("data_view_report_fields_field_id = " + ls_field_id )
dw_properties.Filter()
*/
IF ls_field_id <> '?' And ls_field_id <> '!' THEN
	IF is_reportfrom = 'P' And dw_detail.Describe(is_last_object[1]+".type") <> "column" THEN
		dw_screen_report_objects.SetFilter("data_view_object_id = " + ls_field_id )
		dw_screen_report_objects.Filter()
	ELSE
		dw_properties.SetFilter("data_view_report_fields_field_id = " + ls_field_id )
		dw_properties.Filter()
	END IF
ELSE
	MessageBox("Select", "You must first select a object by clicking on it." )
	RETURN 0
END IF
//---------------------------- APPEON END ----------------------------
//--------Begin Modified by Nova 02.11.2009-----------

//modified by Nova.zhang on 02.11.2009
//IF NOT IsValid(w_field_properties_report) THEN
//	Open(w_field_properties_report)
//END IF

IF is_reportfrom = 'P' And dw_detail.Describe(is_last_object[1]+".type") <> "column" THEN
	//Added by Nova on 02.11.2009
	IF IsValid(w_field_properties_report) THEN
		IF IsValid(w_prac_report_design) THEN
			w_prac_report_design.uo_design.of_pre_pfc_save()
			w_prac_report_design.Event pfc_save()
		END IF
		Close(w_field_properties_report)
	END IF
	IF Not IsValid(w_other_properties_report) THEN
		Open(w_other_properties_report)
	END IF
ELSE
	IF is_last_object[1] <> "" And RightA(is_last_object[1],2) <> "_t" THEN
		//Added by Nova on 02.11.2009
		IF IsValid(w_other_properties_report) THEN
			IF IsValid(w_prac_report_design) THEN
				w_prac_report_design.uo_design.of_pre_pfc_save()
				w_prac_report_design.Event pfc_save()
			END IF
			Close(w_other_properties_report)
		END IF
		IF Not IsValid(w_field_properties_report) THEN
			Open(w_field_properties_report)
		END IF
	END IF
END IF
//--------End Modified -------------------------------
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
//IF uo_screen_design_menu.st_tab_order.BorderStyle = StyleLowered! THEN
//	of_set_tab_order( False )
//	uo_screen_design_menu.st_tab_order.TriggerEvent( Clicked! )
//END IF


//---------------------------- APPEON END ----------------------------

//tab_view.tabpage_image.Visible = False
//IF dw_select_section.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	ll_detail_2_screen_id = dw_select_section.GetItemNumber( currentrow, "table_id_2" ) 
//	is_sql_syntax = inv_data_entry.of_create_dynamic_dw( il_prac_id, ll_data_view_id, ll_detail_2_screen_id, tab_view.tabpage_image.dw_detail_2, tab_view.tabpage_image.dw_detail_2, ib_screen_painter, ii_parent_facility_id )	
//	is_first_column_detail_2 = inv_data_entry.of_get_first_column()	
//	tab_view.tabpage_image.Visible = True
//END IF

tab_view.tabpage_image.Visible = False
//IF dw_select_section.GetItemNumber( currentrow, "table_id_2" ) > 0 THEN
//	tab_view.tabpage_image.Visible = True	
//END IF
inv_data_entry.of_create_dynamic_dw(il_prac_id, il_data_view_id, ai_screen_id, dw_detail, dw_browse, True, 0,is_curdw,is_reportfrom ,il_profile_view_id)

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
dw_properties.Retrieve( il_data_view_id, ii_screen_id ,is_reportfrom,il_profile_view_id)
dw_screen_objects.Retrieve( il_data_view_id, ii_screen_id,is_reportfrom ,il_profile_view_id)
//alan
dw_screen_report_objects.Retrieve( il_data_view_id, ii_screen_id,is_reportfrom ,il_profile_view_id)
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
	//--------Begin Modified by Nova 04.14.2009-----------
	//$<reason> Protect all colunm
	//	dw_detail.SetColumn(i)
	//	is_object_list[i] = dw_detail.GetColumnName()
	is_object_list[i] =dw_detail.Describe("#" + String(i)+".name")
	//--------End Modified -------------------------------
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
//modify
//ls_screen_name = dw_select_section.GetItemString( currentrow, "screen_name" )
//
//IF ls_screen_name = "Address" OR ls_screen_name = "Claims" THEN
//	dw_detail.vscrollbar = True
//ELSE
//	dw_detail.vscrollbar = False
//END IF

of_show_invisible( ib_show_invisible )

SetRedraw( True )
//alan
dw_detail.modify("datawindow.HorizontalScrollPosition=0")

Return 1
end function

public function integer of_select_view ();//This function is replaced with of_select_view(ai_screen_id) and will not
//be called any more - Alfee 02.23.2009
Long ll_data_view_id //alfee 02.16.2009
String ls_data_view_name

Open( w_select_view )

IF Message.StringParm = "Cancel" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 02.20.2006 By: owen chen
	//$<reason> Performance tuning
	//$<reason> Fix a defect.
	//this.of_setup( False)
	//---------------------------- APPEON END ----------------------------
	Return -1
ELSE
	//-----Begin Commented by Alfee 02.16.2009---------------
	//IF parent_window_design_report.Event pfc_save() < 0 THEN
	//	Return -1
	//END IF
	//-----End Commented -------------------------------------
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
	
	//--------Begin Modified by Alfee 02.16.2009-----------
	//il_data_view_id = Long( Left( ls_msg, li_pos - 1 ) )
	ll_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) ) 
	//--------End Modified ---------------------------------
	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )
	//---------------------------- APPEON END ----------------------------
	
	//---------Begin Commented by Alfee 02.16.2009 -----------------------
	/*
	parent_window_design_report.Title = "Practitioner Report Painter ( " + ls_data_view_name + " )"

   //added by Alan on 15.10.2008
	app_filler.ids_report_fields_cache.Retrieve(il_data_view_id,il_profile_view_id)
	app_filler.ids_report_objects_cache.Retrieve(il_data_view_id,il_profile_view_id)
	app_filler.ids_screen_report_objects_cache.Retrieve(il_data_view_id,il_profile_view_id)
	
	//detail dataobject from report
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( il_data_view_id,il_profile_view_id )           //default 999  
  
	//messagebox("of_select_view","3")
	dw_select_section.SetRow( 1 )
	dw_select_section.ScrollToRow( 1 )
	dw_select_section.SelectRow( 1, True )
	*/
	//---------End Commented -----------------------------------------------
	This.SetRedraw( True )	
END IF

//Return 0
RETURN ll_data_view_id //alfee 02.16.2009

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
String ls_sys_report_fields_update[]
String ls_dv_fields_update[]
String  ls_sys_key_cols[ ] = {"sys_report_fields_table_id", "sys_report_fields_field_id"}
String  ls_dv_key_cols[ ] = {"data_view_report_fields_data_view_id", "data_view_report_fields_screen_id", "data_view_report_fields_data_view_field_id","data_view_report_fields_profile_view_id"} //alfee 03.24.2010
//String  ls_dv_key_cols[ ] = {"data_view_report_fields_data_view_id", "data_view_report_fields_screen_id", "data_view_report_fields_field_id","data_view_report_fields_profile_view_id"}


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
	IF Upper(MidA(ls_col_name, 1, 17 )) = "SYS_REPORT_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_report_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(MidA(ls_col_name, 1, 23 )) = "data_view_report_fields" THEN
		li_dv_col_cnt ++
		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
	END IF
	
END FOR

li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_x"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_y"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_width"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_height"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_justification"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_font_wieght"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_font_italic"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_field_label"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_visible"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_justification"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_font_italic"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_underline"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "data_view_report_fields_label_font_weight"
li_dv_col_cnt ++
ls_dv_fields_update[li_dv_col_cnt] = "ismodify"

dw_properties.inv_multitable.of_Register( "sys_report_fields", ls_sys_key_cols , ls_sys_report_fields_update, TRUE, 0)
dw_properties.inv_multitable.of_Register( "data_view_report_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)


This.Height = This.Height - 204
This.y = 190


Return 0



end function

public function integer of_show_invisible (boolean ab_show);Integer li_rc
Integer i
String ls_fld
String ls_obj_nm //Added by Appeon long.zhang 05.08.2017 (Provider Profile Issues)
	
dw_properties.SetFilter("")
dw_properties.Filter( )
li_rc = dw_properties.RowCount()

FOR i = 1 To li_rc
	ls_fld = dw_properties.GetItemString( i, "sys_report_fields_field_name" )
	IF dw_properties.GetItemString( i, "data_view_report_fields_visible" ) = "Y" THEN
		IF dw_detail.Describe( ls_fld + ".Visible") = '0' THEN 
			dw_detail.Modify( ls_fld + ".Visible = 1")
			dw_detail.Modify( ls_fld + "_t.Visible = 1") 
		end if
		CONTINUE
	END IF
	
	IF Not ab_show THEN
		dw_detail.Modify( ls_fld + ".Visible = 1")
		dw_detail.Modify( ls_fld + "_t.Visible = 1")
	ELSE
		dw_detail.Modify( ls_fld + ".Visible = 0")
		dw_detail.Modify( ls_fld + "_t.Visible = 0")
	END IF
END FOR
	
	//alan
	dw_screen_report_objects.SetFilter("")
	dw_screen_report_objects.Filter( )
	li_rc = dw_screen_report_objects.RowCount()

	FOR i = 1 To li_rc
		IF dw_screen_report_objects.GetItemString( i, "visible" ) = "Y" THEN
			//------------------- APPEON BEGIN -------------------
			//<$>added:long.zhang 05.08.2017
			//<$>reason:Fix a bug when column title is not 'column name' + '_t', For Provider Profile Issues.
			ls_obj_nm = dw_screen_report_objects.GetItemString(i, "object_name")
			If dw_detail.Describe( ls_obj_nm + ".Visible") = '0' THEN 
				dw_detail.Modify( ls_obj_nm + ".Visible = 1")
			End If
			//------------------- APPEON END -------------------
			
			CONTINUE
		END IF

		ls_fld = dw_screen_report_objects.GetItemString( i, "object_name" )
		IF Not ab_show THEN
			dw_detail.Modify( ls_fld + ".Visible = 1")
		ELSE
			dw_detail.Modify( ls_fld + ".Visible = 0")
		END IF
	
   END FOR
	
		
	RETURN 1

end function

public function integer of_set_parent_window (w_prac_report_design aw_win);
//BEGIN-Modify by Evan 12.14.2010
//parent_window_design_report = aw_win
//END-Modify by Evan 12.14.2010

Return 0
end function

public subroutine of_modify_dwstatus ();//
long		i,ll_rowcount
long  	j,ll_colnum
string	ls_colname,ls_coltype 
long		jj

ll_rowcount=dw_properties.rowcount()
ll_colnum=long(dw_properties.Object.DataWindow.Column.Count)

for i=1 to ll_rowcount
	jj=0
	for j=1 to ll_colnum
		ls_colname=dw_properties.Describe("#"+String(j)+".name") 
		ls_coltype=LeftA(dw_properties.Describe(ls_colname+".coltype"),3) 
		if upper(ls_coltype)='CHA' then
			if dw_properties.GetItemString(i,ls_colname,primary!,true)<>dw_properties.GetItemString(i,ls_colname,primary!,false) then
				jj++
				exit
			end if
		elseif upper(ls_coltype)='INT' or upper(ls_coltype)='LON' or upper(ls_coltype)='DEC' or upper(ls_coltype)='NUM' then
			if dw_properties.GetItemNumber(i,ls_colname,primary!,true)<>dw_properties.GetItemNumber(i,ls_colname,primary!,false) then
				jj++			
				exit
			end if
		elseif upper(ls_coltype)='DAT' then
			if dw_properties.GetItemDatetime(i,ls_colname,primary!,true)<>dw_properties.GetItemDatetime(i,ls_colname,primary!,false) then
				jj++			
				exit
			end if
		end if
	next
	if jj=0 then dw_properties.SetItemStatus(i, 0,Primary!, notModified!)
next
end subroutine

public function integer of_select_profile_view ();//This function is replaced with of_select_profile_view(ab_firsttime)
//and should not be called again - Alfee 02.23.2009
//Added By Alfee 02.16.2009

Integer li_pos
String ls_msg
String ls_view_name

//Open( w_select_profile_view )
Open( w_select_profile_view_new ) //alfee 03.02.2009

IF Message.StringParm = "Cancel" THEN
	//this.of_setup( False)
	Return -1
ELSE
	//BEGIN-Modify by Evan 12.14.2010
	//IF parent_window_design_report.Event pfc_save() < 0 THEN
	IF w_prac_report_design.Event pfc_Save() < 0 THEN
	//END-Modify by Evan 12.14.2010	
		Return -1
	END IF
	
	This.SetRedraw( False )
	
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	il_profile_view_id = Long( LeftA( ls_msg, li_pos - 1 ) )
	ls_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )

	//BEGIN-Modify by Evan 12.14.2010
	//parent_window_design_report.Title = "Practitioner Report Painter ( " + ls_view_name + " )"
	w_prac_report_design.Title = "Practitioner Profile Report Design ( " + ls_view_name + " )"
	//END-Modify by Evan 12.14.2010
	
	app_filler.ids_report_fields_cache.Retrieve(1,il_profile_view_id)
	app_filler.ids_report_objects_cache.Retrieve(1,il_profile_view_id)
	app_filler.ids_screen_report_objects_cache.Retrieve(1,il_profile_view_id)
	
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( 1,il_profile_view_id )     //default 999  
  
	dw_select_section.SetRow( 1 )
	dw_select_section.ScrollToRow( 1 )
	dw_select_section.SelectRow( 1, True )

	This.SetRedraw( True )	
END IF

RETURN 0
end function

public function integer of_select_view (integer ai_screen_id);//Added by Alfee on 02.16.2009

Integer li_pos
Long ll_data_view_id 
String ls_data_view_name, ls_msg

OpenwithParm( w_select_screen_view, ai_screen_id )

IF Message.StringParm = "Cancel" THEN
	//this.of_setup( False) - commented by alfee 02/23/2009
	Return -1
ELSE
	This.SetRedraw( False )
	
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	
	ll_data_view_id = Long( LeftA( ls_msg, li_pos - 1 ) ) 
	ls_data_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )

	This.SetRedraw( True )	
END IF

RETURN ll_data_view_id 

end function

public function integer of_select_profile_view (boolean ab_firsttime);//Added By Alfee 02.16.2009

Integer li_pos
String ls_msg
String ls_view_name

//Open( w_select_profile_view )
Open( w_select_profile_view_new ) //alfee 03.02.2009

IF Message.StringParm = "Cancel" THEN
	//---Begin Modified by Alfee 02.23.2009 ---------
	IF ab_firsttime THEN Close(Parent)
	//this.of_setup( False)
	//--End Modified---------------------------------
	Return -1
ELSE
	IF NOT ab_firsttime THEN //Bug 3105 - alfee 05.22.2012
		//BEGIN-Modify by Evan 12.14.2010
		//IF parent_window_design_report.Event pfc_save() < 0 THEN
		IF w_prac_report_design.Event pfc_save() < 0 THEN
		//END-Modify by Evan 12.14.2010
			Return -1
		END IF
	END IF
	
	This.SetRedraw( False )
	
	ls_msg = Message.StringParm
	li_pos = PosA( ls_msg, '~t' )
	il_profile_view_id = Long( LeftA( ls_msg, li_pos - 1 ) )
	ls_view_name = RightA( ls_msg, LenA( ls_msg ) - li_pos )

	//BEGIN-Modify by Evan 12.14.2010
	//parent_window_design_report.Title = "Practitioner Report Painter ( " + ls_view_name + " )"
	w_prac_report_design.Title = "Practitioner Profile Report Design ( " + ls_view_name + " )"
	//END-Modify by Evan 12.14.2010
	
	app_filler.ids_report_fields_cache.Retrieve(1,il_profile_view_id)
	app_filler.ids_report_objects_cache.Retrieve(1,il_profile_view_id)
	app_filler.ids_screen_report_objects_cache.Retrieve(1,il_profile_view_id)
	
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( 1,il_profile_view_id )     //default 999  
  
	dw_select_section.SetRow( 1 )
	dw_select_section.ScrollToRow( 1 )
	dw_select_section.SelectRow( 1, True )

	This.SetRedraw( True )	
END IF

RETURN 0
end function

on pfc_cst_u_data_entry_report_painter.create
int iCurrent
call super::create
this.dw_screen_report_objects=create dw_screen_report_objects
this.uo_screen_design_menu_new=create uo_screen_design_menu_new
this.cb_model=create cb_model
this.dw_select=create dw_select
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_screen_report_objects
this.Control[iCurrent+2]=this.uo_screen_design_menu_new
this.Control[iCurrent+3]=this.cb_model
this.Control[iCurrent+4]=this.dw_select
this.Control[iCurrent+5]=this.st_1
end on

on pfc_cst_u_data_entry_report_painter.destroy
call super::destroy
destroy(this.dw_screen_report_objects)
destroy(this.uo_screen_design_menu_new)
destroy(this.cb_model)
destroy(this.dw_select)
destroy(this.st_1)
end on

event pfc_cst_select_view;//Return of_select_profile_view() // Overrided by Alfee 02.16.2009
Return of_select_profile_view(FALSE) //Alfee 02.23.2009
end event

event constructor;call super::constructor;//keep it always to 1 in profile painter - Alfee 02.16.2009

il_data_view_id = 1 
end event

type cb_decheck from pfc_cst_u_data_entry_screen_painter`cb_decheck within pfc_cst_u_data_entry_report_painter
end type

type st_dw_select_section_border from pfc_cst_u_data_entry_screen_painter`st_dw_select_section_border within pfc_cst_u_data_entry_report_painter
end type

type cb_view_relation from pfc_cst_u_data_entry_screen_painter`cb_view_relation within pfc_cst_u_data_entry_report_painter
end type

type st_select from pfc_cst_u_data_entry_screen_painter`st_select within pfc_cst_u_data_entry_report_painter
end type

type dw_addresses from pfc_cst_u_data_entry_screen_painter`dw_addresses within pfc_cst_u_data_entry_report_painter
end type

type st_recs from pfc_cst_u_data_entry_screen_painter`st_recs within pfc_cst_u_data_entry_report_painter
boolean visible = false
end type

type dw_ver_data from pfc_cst_u_data_entry_screen_painter`dw_ver_data within pfc_cst_u_data_entry_report_painter
end type

type dw_select_section from pfc_cst_u_data_entry_screen_painter`dw_select_section within pfc_cst_u_data_entry_report_painter
integer x = 23
integer width = 754
integer height = 1660
string title = "Select Profile Report"
string dataobject = "d_report_painter_list"
end type

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
		UPDATE data_view_report_fields  
	 	   	SET screen_id = :li_move_to_screen_id,
			 field_x = 2000,
			 field_y = :li_y,
			 field_label_x = 1700,
			 field_label_y = :li_y
	   WHERE ( data_view_report_fields.data_view_id = :il_data_view_id ) AND  
   	      ( data_view_report_fields.screen_id = :ii_screen_id ) AND  
      	   ( data_view_report_fields.field_id = :ii_field_id[i] )   ;
		IF SQLCA.SQLCODE <> 0 THEN
			MessageBox("SQL ERROR", SQLCA.SQLERRTEXT)
			Return 1
		END IF
		COMMIT USING SQLCA;
	END FOR	
	dw_properties.Retrieve(il_data_view_id, ii_screen_id)
	inv_data_entry.of_create_dynamic_dw(il_prac_id, il_data_view_id, ii_screen_id, dw_detail, dw_browse, True, 0 ,is_curdw,is_reportfrom,il_profile_view_id)	
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
	uo_screen_design_menu_new.st_relocate_field.BorderStyle = StyleRaised!
	
	//---------------------------- APPEON END ----------------------------
	Return 1
END IF


end event

event dw_select_section::constructor;
of_settransobject( sqlca)
This.of_Setupdateable(True)
end event

event dw_select_section::retrieveend;//////////////////////////////////////////////////////////////////////////////
//	Event:			retrieveend
//	Description:		Send retrieveend notification to services
// 						Notify the SQLSpy service
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						6.0   Initial version
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
string 	ls_sqlspyheading
string	ls_sqlspymessage

//If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) then
		//Create the heading and message for the SQLSpy.
		ls_sqlspyheading = "RetrieveEnd - " + this.ClassName() 
		ls_sqlspymessage = "Rows Retrieved = "+ string(rowcount)
		
		//Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, "/*** " + ls_sqlspymessage + " ***/")
	end if
end if

If IsValid(inv_Linkage) then inv_Linkage.Event pfc_retrieveend (rowcount)

//Start Code Change ---- 02.15.2006 #286 maha
	of_idle_value(1)
//End Code Change---02.15.2006

//used to change the icon for screens where the practitioner has data. 
if  not ib_screen_painter then
	of_screen_color()
end if

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
//ii_screen_id = dw_select_section.GetItemNumber(currentrow, "profile_report_id") //modify
is_curdw = dw_select_section.GetItemString(currentrow, "cur_dw") //modify
if PosA(is_curdw,'_prf_')>0 then
	ii_screen_id = dw_select_section.GetItemNumber(currentrow, "prf_id")
	is_reportfrom = 'P'
	cb_model.text = "Screen Model"//Start Code Change ----03.17.2009 #V92 maha
else
	ii_screen_id = dw_select_section.GetItemNumber(currentrow, "scr_id")
	is_reportfrom = 'S'
	cb_model.text = "Profile Model"  //Start Code Change ----03.17.2009 #V92 maha
end if
of_select_screen( currentrow, ii_screen_id )

//IF inv_data_entry.ib_vscroll THEN
dw_detail.vscrollbar = True
//END IF

end event

type dw_loc_defaults from pfc_cst_u_data_entry_screen_painter`dw_loc_defaults within pfc_cst_u_data_entry_report_painter
end type

type r_1 from pfc_cst_u_data_entry_screen_painter`r_1 within pfc_cst_u_data_entry_report_painter
end type

type dw_link_list from pfc_cst_u_data_entry_screen_painter`dw_link_list within pfc_cst_u_data_entry_report_painter
end type

type dw_detail from pfc_cst_u_data_entry_screen_painter`dw_detail within pfc_cst_u_data_entry_report_painter
integer y = 288
integer width = 2757
integer height = 1652
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
			dw_properties.SetItem(1, "data_view_report_fields_field_y", li_y_pos )		
		ELSEIF KeyDown( KeyDownArrow! ) THEN
			li_y_pos = Integer (This.Describe( is_last_object[i] + ".y" ) )
			li_y_pos = li_y_pos + li_pixels
			This.Modify( is_last_object[i] + ".y = '" + String( li_y_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_report_fields_field_y", li_y_pos )		
		ELSEIF KeyDown( KeyRightArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos + li_pixels
			This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
			dw_properties.SetItem(1, "data_view_report_fields_field_x", li_x_pos )
		ELSEIF KeyDown( KeyLeftArrow! ) AND is_last_object[1] <> "detail_band" THEN
			li_x_pos = Integer (This.Describe( is_last_object[i] + ".x" ) )
			li_x_pos = li_x_pos - li_pixels
			if li_x_pos >= li_pixels then //Add by Evan 01/10/2008
				This.Modify( is_last_object[i] + ".x = '" + String( li_x_pos ) + "'" )
				dw_properties.SetItem(1, "data_view_report_fields_field_x", li_x_pos )
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
		
		dw_properties.SetItem(1, "data_view_report_fields_field_width", li_y_pos )
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
uo_screen_design_menu_new.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
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
Long ll_header_height,ll_obj_height


IF ii_obj_select_cnt = 0 OR ib_set_tab_order THEN
	RETURN
END IF

//header height
ll_header_height = long(describe("datawindow.header.height"))

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
			dw_properties.SetItem(1, "data_view_report_fields_field_label_y", ll_y) 
		ELSEIF Pos( is_last_object[1], "obj" ) = 0 THEN
			dw_properties.SetItem(1, "data_view_report_fields_field_y", ll_y) 
		END IF		
		IF is_last_object[1] <> "detail_band" THEN
			idw_detail.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
			IF Right( is_last_object[i], 2 ) = "_t" THEN
				dw_properties.SetItem(1, "data_view_report_fields_field_label_x", ll_x) 
			ELSEIF Pos( is_last_object[i], "obj" ) = 0 THEN
				dw_properties.SetItem(1, "data_view_report_fields_field_x", ll_x) 
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
				dw_properties.SetItem(1, "data_view_report_fields_field_label_y", ll_y) 
			ELSEIF PosA( is_last_object[1], "obj" ) = 0 THEN
				dw_properties.SetItem(1, "data_view_report_fields_field_y", ll_y) 
			END IF
			//
			if describe(is_last_object[i]+".band")='header' then
				ll_obj_height = long(describe(is_last_object[i]+".height"))
				if ll_y + ll_obj_height > ll_header_height then
					ll_y = ll_header_height - ll_obj_height
					idw_detail.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )
				end if
			elseif describe(is_last_object[i]+".band")='detail' then	
				if ll_y <0 then ll_y = 0
				idw_detail.Modify( is_last_object[i] + ".y = '" + String( ll_y ) + "'" )	
			end if
		END IF
		IF is_last_object[1] <> "detail_band" THEN
			IF (il_x_diff - ll_x_diff) <> 0 then
				idw_detail.Modify( is_last_object[i] + ".x = '" + String( ll_x ) + "'" )
				IF RightA( is_last_object[i], 2 ) = "_t" THEN
					dw_properties.SetItem(1, "data_view_report_fields_field_label_x", ll_x) 
				ELSEIF PosA( is_last_object[i], "obj" ) = 0 THEN
					dw_properties.SetItem(1, "data_view_report_fields_field_x", ll_x) 
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
		dw_properties.SetItem(1, "data_view_report_fields_field_label_width", ll_new_width) 
	ELSEIF PosA( is_last_object[1], "obj" ) = 0 THEN
		dw_properties.SetItem(1, "data_view_report_fields_field_width", ll_new_width) 
	END IF		
ELSEIF ib_resize_height AND ib_mouse_down THEN
	SetPointer(SizeNS!)
	ll_y_diff = This.Pointery() + il_vscroll_pos - (il_last_object_y[1] + il_last_object_height[1])//Added 'il_vscroll_pos' By Ken.Guo 06.16.2008
	ll_new_height = il_last_object_height[1] + ll_y_diff
	il_last_object_height[1] = ll_new_height
	idw_detail.Modify( is_last_object[1] + ".height = '" + String( ll_new_height ) + "'" )
	IF RightA( is_last_object[1], 2 ) <> "_t" AND	PosA( is_last_object[1], "obj" ) = 0 THEN
		dw_properties.SetItem(1, "data_view_report_fields_field_height", ll_new_height) 
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
uo_screen_design_menu_new.st_xy.Text = "  X:" + String(il_last_object_x[1] + ll_x_diff) +&
									"  Y:" + String(il_last_object_y[1] + ll_y_diff) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
//---------------------------- APPEON END ----------------------------
end event

event dw_detail::clicked;/////////////////////////////////////////////////////////////////////////////
//	Event:			clicked
//	Description:		DataWindow clicked
//////////////////////////////////////////////////////////////////////////////
//	Rev. History		Version
//						5.0		Initial version
// 						6.0 	Added Linkage service notification
// 						6.0 	Introduced non zero return value
// 						7.0		Do not bypass processing on linkage failure.  
// 						7.0		Linkage service should not fire events when querymode is enabled
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer li_rc
boolean lb_disablelinkage

// Check arguments
if IsNull(xpos) or IsNull(ypos) or IsNull(row) or IsNull(dwo) then return

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.22.2006 By: Cao YongWang
//$<reason> Performance tuning
string ls_coltype
If isvalid(iuo_Calendar) Then
	ls_coltype = this.Describe(dwo.name+".ColType")	
	If ls_coltype = 'date' or ls_coltype = 'datetime' Then
		iuo_Calendar.of_Register(dwo.name, iuo_Calendar.DDLB_WITHARROW)
	End If
End If
//---------------------------- APPEON END ----------------------------

// Is Querymode enabled?
if IsValid(inv_QueryMode) then lb_disablelinkage = inv_QueryMode.of_GetEnabled()

if not lb_disablelinkage then
	if IsValid (inv_Linkage) then
		if inv_Linkage.Event pfc_clicked ( xpos, ypos, row, dwo ) = &
			inv_Linkage.PREVENT_ACTION then
			// The user or a service action prevents from going to the clicked row.
//			return 1
		end if
	end if
end if

	
if IsValid (inv_RowSelect) then inv_RowSelect.Event pfc_clicked ( xpos, ypos, row, dwo )

if IsValid (inv_Sort) then inv_Sort.Event pfc_clicked ( xpos, ypos, row, dwo ) 



String ls_weight
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
uo_screen_design_menu_new.st_xy.Text = "  X:" + String(il_last_object_x[1]) +&
									"  Y:" + String(il_last_object_y[1]) +&
									"  Width:" + String(il_last_object_width[1]) +&
									"  Height:" + String(il_last_object_height[1])
														

uo_screen_design_menu_new.st_object_name.Text = is_last_object[1]

//---------------------------- APPEON END ----------------------------

This.Modify( ls_selected_object_name + ".border = '2'" )

ls_field_id = dw_detail.Describe( is_last_object[1] + ".tag" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.15.2006 By: LeiWei
//$<reason> Fix a defect.
If ls_field_id="?" Or ls_field_id="!" Or ls_field_id="" Then ls_field_id="0"
//---------------------------- APPEON END ----------------------------

IF PosA( is_last_object[1], "obj" ) = 0 AND ls_selected_object_name <> "detail_band" THEN
	dw_properties.SetFilter("data_view_report_fields_field_id = " + ls_field_id )
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
	uo_screen_design_menu_new.dw_1.SetText( ls_text )
	
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
uo_screen_design_menu_new.st_left.BorderStyle = StyleRaised!
uo_screen_design_menu_new.st_right.BorderStyle = StyleRaised!
uo_screen_design_menu_new.st_center.BorderStyle = StyleRaised!

IF ls_alignment = "0" THEN
	uo_screen_design_menu_new.st_left.BorderStyle = StyleLowered!
ELSEIF ls_alignment = "1" THEN
	uo_screen_design_menu_new.st_right.BorderStyle = StyleLowered!
ELSE
	uo_screen_design_menu_new.st_center.BorderStyle = StyleLowered!
END IF

ls_weight = This.Describe(is_last_object[ii_obj_select_cnt] + ".font.weight")
IF ls_weight = "400" THEN
	uo_screen_design_menu_new.st_bold.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu_new.st_bold.BorderStyle = StyleLowered!
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
	uo_screen_design_menu_new.st_italic.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu_new.st_italic.BorderStyle = StyleLowered!
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
	uo_screen_design_menu_new.st_underline.BorderStyle = StyleRaised!
ELSE
	uo_screen_design_menu_new.st_underline.BorderStyle = StyleLowered!
END IF
//---------------------------- APPEON END ----------------------------

IF is_reportfrom = 'P' And Describe(is_last_object[1]+".type") <> "column" THEN
	//--------Begin Added by Nova 02.11.2009------------------------
	IF IsValid(w_field_properties_report) THEN
		IF IsValid(w_prac_report_design) THEN
			w_prac_report_design.uo_design.of_pre_pfc_save()
			w_prac_report_design.Event pfc_save()
			Close(w_field_properties_report)
			IF Not IsValid(w_other_properties_report) THEN
			 	Open(w_other_properties_report)
			END IF
		END IF
	END IF
	//--------End Added --------------------------------------------
ELSE
	IF is_last_object[1] <> "" And RightA(is_last_object[1],2) <> "_t" THEN
		//--------Begin Added by Nova 02.11.2009------------------------
		IF IsValid(w_other_properties_report) THEN
			IF IsValid(w_prac_report_design) THEN
				w_prac_report_design.uo_design.of_pre_pfc_save()
				w_prac_report_design.Event pfc_save()
				Close(w_other_properties_report)
				IF Not IsValid(w_field_properties_report) THEN
				  Open(w_field_properties_report)
				END IF
			END IF
		END IF
	END IF
	//--------End Added --------------------------------------------
END IF
		
		

end event

event dw_detail::doubleclicked;IF UpperBound(is_last_object) = 0 THEN
	RETURN
END IF

of_property_sheet()



end event

type dw_browse from pfc_cst_u_data_entry_screen_painter`dw_browse within pfc_cst_u_data_entry_report_painter
boolean visible = false
end type

type tab_view from pfc_cst_u_data_entry_screen_painter`tab_view within pfc_cst_u_data_entry_report_painter
boolean visible = false
end type

event tab_view::selectionchanging;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.16.2006 By: LiuHongXin
//$<reason> Fix a defect.
IF OldIndex = -1 THEN RETURN -1
//---------------------------- APPEON END ----------------------------

//BEGIN-Modify by Evan 12.14.2010
//IF parent_window_design_report.Event pfc_save() < 0 THEN
IF w_prac_report_design.Event pfc_save() < 0 THEN
//END-Modify by Evan 12.14.2010
	Return 1
END IF


end event

type tabpage_browse from pfc_cst_u_data_entry_screen_painter`tabpage_browse within tab_view
end type

type tabpage_details from pfc_cst_u_data_entry_screen_painter`tabpage_details within tab_view
end type

type sle_1 from pfc_cst_u_data_entry_screen_painter`sle_1 within tabpage_details
end type

type tabpage_image from pfc_cst_u_data_entry_screen_painter`tabpage_image within tab_view
end type

type dw_detail_2 from pfc_cst_u_data_entry_screen_painter`dw_detail_2 within tabpage_image
end type

type tabpage_linked_data from pfc_cst_u_data_entry_screen_painter`tabpage_linked_data within tab_view
end type

type uo_linked_data from pfc_cst_u_data_entry_screen_painter`uo_linked_data within tabpage_linked_data
end type

type cb_screen_properties from pfc_cst_u_data_entry_screen_painter`cb_screen_properties within pfc_cst_u_data_entry_report_painter
end type

event cb_screen_properties::clicked;Integer li_last_row

ii_screen_id = dw_select_section.GetItemNumber(dw_select_section.GetRow(), "screen_id") 

Open( w_screen_maint)

IF Message.StringParm = "Cancel" THEN
	Return
END IF

dw_select_section.SetRedraw(False)

ib_refresh_screen_list = True

li_last_row = dw_select_section.GetRow()

dw_select_section.Retrieve( il_data_view_id ,il_profile_view_id)   //default 999
dw_select_section.ScrollToRow( li_last_row)
dw_select_section.SetRow( li_last_row )
dw_select_section.SelectRow( li_last_row, True)

ib_refresh_screen_list = False

dw_select_section.SetRedraw(True)
end event

type sle_tab from pfc_cst_u_data_entry_screen_painter`sle_tab within pfc_cst_u_data_entry_report_painter
end type

type dw_properties from pfc_cst_u_data_entry_screen_painter`dw_properties within pfc_cst_u_data_entry_report_painter
integer x = 352
integer y = 804
string dataobject = "d_sys_report_field_properties"
end type

type cb_1 from pfc_cst_u_data_entry_screen_painter`cb_1 within pfc_cst_u_data_entry_report_painter
integer x = 507
integer y = 752
end type

type dw_fields_alias from pfc_cst_u_data_entry_screen_painter`dw_fields_alias within pfc_cst_u_data_entry_report_painter
integer x = 123
integer y = 840
end type

type dw_properties_report from pfc_cst_u_data_entry_screen_painter`dw_properties_report within pfc_cst_u_data_entry_report_painter
end type

type dw_properties_dataview from pfc_cst_u_data_entry_screen_painter`dw_properties_dataview within pfc_cst_u_data_entry_report_painter
end type

type dw_properties_modify from pfc_cst_u_data_entry_screen_painter`dw_properties_modify within pfc_cst_u_data_entry_report_painter
end type

type dw_properties_pmodify from pfc_cst_u_data_entry_screen_painter`dw_properties_pmodify within pfc_cst_u_data_entry_report_painter
end type

type dw_screen_objects from pfc_cst_u_data_entry_screen_painter`dw_screen_objects within pfc_cst_u_data_entry_report_painter
string dataobject = "d_report_objects"
end type

type uo_screen_design_menu from pfc_cst_u_data_entry_screen_painter`uo_screen_design_menu within pfc_cst_u_data_entry_report_painter
boolean visible = false
end type

type st_tab from pfc_cst_u_data_entry_screen_painter`st_tab within pfc_cst_u_data_entry_report_painter
end type

type dw_screen_report_objects from u_dw within pfc_cst_u_data_entry_report_painter
boolean visible = false
integer x = 87
integer y = 1880
integer width = 626
integer height = 196
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_screen_report_objects"
end type

type uo_screen_design_menu_new from uo_design_menu_report within pfc_cst_u_data_entry_report_painter
integer taborder = 20
boolean bringtotop = true
end type

on uo_screen_design_menu_new.destroy
call uo_design_menu_report::destroy
end on

type cb_model from commandbutton within pfc_cst_u_data_entry_report_painter
integer x = 1006
integer y = 64
integer width = 407
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Change Model"
end type

event clicked;integer li_prf_ids [] //alfee 12.30.2014
integer li_res //maha 11.16.2015
long		ll_row, ll_data_view_id, ll_screen_id[], ll_cnt 
string	ls_tmpdw, ls_errmsg 

pfc_cst_nv_profile_report_functions lnv_profile_report 

SetRedraw( False )

ll_row=dw_select_section.getrow()
if ll_row=0 then return

is_curdw = dw_select_section.GetItemString(ll_row, "cur_dw") 

if PosA(is_curdw,'_prf_')>0 then
	ls_tmpdw = dw_select_section.GetItemString(ll_row, "scr_dw")
	if isnull(ls_tmpdw) or trim(ls_tmpdw)='' then
		messagebox('','Current report cannot be converted to the Dynamic Screen view.')
		SetRedraw( True )
		return
	end if
	is_reportfrom = 'S'
	ii_screen_id = dw_select_section.GetItemNumber(ll_row, "scr_id")
	li_prf_ids [1] = dw_select_section.GetItemNumber(ll_row, "prf_id") //alfee 12.30.2014
	//-----------Begin Commented by Alfee 04.15.2009----------------
	/* is_curdw = dw_select_section.GetItemString(ll_row, "scr_dw")
	dw_select_section.setitem(ll_row,"cur_dw",is_curdw)
	cb_model.text = "Profile Model"  ----03.17.2009 #V92 maha 	*/
	//----------End Commented ---------------------------------------
else
	is_reportfrom = 'P'
	ii_screen_id = dw_select_section.GetItemNumber(ll_row, "prf_id")
	//-----------Begin Commented by Alfee 04.15.2009----------------	
	/* is_curdw = dw_select_section.GetItemString(ll_row, "prf_dw")
	dw_select_section.setitem(ll_row,"cur_dw",is_curdw)
	cb_model.text = "Screen Model"  ----03.17.2009 #V92 maha  */
	//----------End Commented ---------------------------------------
end if 

//--------Begin Added by Alfee 02.16.2009------------------------
IF is_reportfrom = 'S' THEN 
	ll_screen_id[1] = ii_screen_id
	select count(*) into :ll_cnt from data_view_report_fields where profile_view_id = :il_profile_view_id and data_view_id = 1 and report_from ='S' and screen_id = :ii_screen_id;	
	IF ll_cnt > 0 THEN //the screen properties are existing.
		open(w_profile_model_response)  //1= recreate 2 =previous -1= cancel
		li_res = message.doubleparm
		
		if li_res = -1 then //cancel
			is_reportfrom = 'C' 
			//skip anything else
		else

			IF li_res = 1 then
			//IF MessageBox("Change Model","This profile screen was dynamically created previously, Click No to retain previous settings; Click Yes to recreate from a data screen?", Question!,YesNo!, 2) = 1 THEN
				ll_data_view_id = of_select_view(ll_screen_id[1])
				IF ll_data_view_id = -1 THEN //Cancel
					is_reportfrom = 'P'//alfee 04.15.2009
					SetRedraw( True )
					RETURN 
				END IF
				
			
				lnv_profile_report = Create pfc_cst_nv_profile_report_functions			
				lnv_profile_report.of_delete_screen_properties(il_profile_view_id, ll_screen_id, is_reportfrom)
				//IF lnv_profile_report.of_copy_screen_properties(il_profile_view_id, ll_data_view_id, ll_screen_id ) < 0 THEN
				IF lnv_profile_report.of_copy_screen_properties(il_profile_view_id, ll_data_view_id, ll_screen_id, li_prf_ids ) < 0 THEN	//Same scr ids for different reports - alfee 12.30.2014
					MessageBox("Change Model","Change Model failed due to cannot generating profile screen properties!")
					Destroy lnv_profile_report
					RETURN 
				END IF
				//BEGIN-Modify by Evan 12.14.2010
				//IF IsValid(parent_window_design_report) THEN parent_window_design_report.event pfc_save()
				IF IsValid(w_prac_report_design) THEN w_prac_report_design.event pfc_save()
				//END-Modify by Evan 12.14.2010
				
				Destroy lnv_profile_report
			END IF
		end if
	ELSE //new screen properties
		ll_data_view_id = of_select_view(ll_screen_id[1])
		IF ll_data_view_id = -1 THEN //Cancel
			is_reportfrom = 'P'//alfee 04.15.2009		
			SetRedraw( True )
			RETURN 
		END IF		
		lnv_profile_report = Create pfc_cst_nv_profile_report_functions			
		//IF lnv_profile_report.of_copy_screen_properties(il_profile_view_id, ll_data_view_id, ll_screen_id ) < 0 THEN
		IF lnv_profile_report.of_copy_screen_properties(il_profile_view_id, ll_data_view_id, ll_screen_id, li_prf_ids ) < 0 THEN //Same scr ids for different reports - alfee 12.30.2014
			MessageBox("Change Model","Change Model failed due to cannot generating profile screen properties!")
			Destroy lnv_profile_report
			RETURN 
		END IF
		//BEGIN-Modify by Evan 12.14.2010
		//IF IsValid(parent_window_design_report) THEN parent_window_design_report.event pfc_save()
		IF IsValid(w_prac_report_design) THEN w_prac_report_design.event pfc_save()
		//END-Modify by Evan 12.14.2010

		Destroy lnv_profile_report
	END IF			
END IF
//--------End Added ---------------------------------------------

//--------Begin Added by Alfee 04.15.2009------------------------
if is_reportfrom = 'S' then 
	is_curdw = dw_select_section.GetItemString(ll_row, "scr_dw")
	dw_select_section.setitem(ll_row,"cur_dw",is_curdw)	
	cb_model.text = "Profile Model"	
elseif 	is_reportfrom = 'C' then
	cb_model.text = "Screen Model"
else
	is_curdw = dw_select_section.GetItemString(ll_row, "prf_dw")
	dw_select_section.setitem(ll_row,"cur_dw",is_curdw)
	cb_model.text = "Screen Model"
end if
//--------End Added ---------------------------------------------

of_select_screen( ll_row, ii_screen_id )

dw_detail.vscrollbar = True

SetRedraw( True )


end event

type dw_select from u_dw within pfc_cst_u_data_entry_report_painter
boolean visible = false
integer x = 23
integer y = 344
integer width = 754
integer height = 100
integer taborder = 11
boolean bringtotop = true
boolean enabled = false
string dataobject = "d_pfl_select_views_dddw_list_no_hdr_new"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
This.SetItem( 1, "profile_view_id", 999 )
This.SetRow( 1 )
This.ScrollToRow( 1 )


end event

event itemchanged;call super::itemchanged;//Commented by Alfee 02.16.2009

//IF parent_window_design_report.Event pfc_save() < 0 THEN
//	Return 2
//END IF
////
//il_profile_view_id = long(data)
//
////Added by Alan on 16.10.2008
//app_filler.ids_report_fields_cache.Retrieve(il_data_view_id,il_profile_view_id)
//app_filler.ids_report_objects_cache.Retrieve(il_data_view_id,il_profile_view_id)
//app_filler.ids_screen_report_objects_cache.Retrieve(il_data_view_id,il_profile_view_id)
//
//This.SetRedraw( False )
//dw_select_section.Reset()
//dw_select_section.of_SetTransObject( SQLCA )
//dw_select_section.Retrieve( il_data_view_id,il_profile_view_id )           //default 999  
//
//dw_select_section.SetRow( 1 )
//dw_select_section.ScrollToRow( 1 )
//dw_select_section.SelectRow( 1, True )
//This.SetRedraw( True )	

Return 0
end event

type st_1 from statictext within pfc_cst_u_data_entry_report_painter
boolean visible = false
integer x = 23
integer y = 284
integer width = 754
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Select Profile View:"
boolean focusrectangle = false
end type

