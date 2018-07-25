$PBExportHeader$pfc_cst_u_report_data_design.sru
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type pfc_cst_u_report_data_design from userobject
end type
type uo_band from pfc_cst_u_band_painter_report within pfc_cst_u_report_data_design
end type
type dw_properties_text from u_dw within pfc_cst_u_report_data_design
end type
type dw_properties_dw from u_dw within pfc_cst_u_report_data_design
end type
type uo_select from u_contract_select_screen within pfc_cst_u_report_data_design
end type
type st_add from statictext within pfc_cst_u_report_data_design
end type
type st_1 from statictext within pfc_cst_u_report_data_design
end type
type uo_design from uo_report_design_menu within pfc_cst_u_report_data_design
end type
type dw_fields_alias from datawindow within pfc_cst_u_report_data_design
end type
type cb_screen_properties from u_cb within pfc_cst_u_report_data_design
end type
type st_tab from statictext within pfc_cst_u_report_data_design
end type
type dw_select_section from u_dw within pfc_cst_u_report_data_design
end type
type dw_properties from u_dw within pfc_cst_u_report_data_design
end type
type st_back from statictext within pfc_cst_u_report_data_design
end type
type st_right from statictext within pfc_cst_u_report_data_design
end type
end forward

global type pfc_cst_u_report_data_design from userobject
integer width = 3799
integer height = 2852
boolean border = true
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event pfc_cst_new_screen_painter ( )
event type integer pfc_cst_select_view ( )
event ue_field_properties ( )
event pfc_cst_sort ( )
event ue_properties ( )
event ue_closecontract ( )
event ue_opencontract ( )
event ue_refreshcontract ( )
event pfc_cst_filter ( )
uo_band uo_band
dw_properties_text dw_properties_text
dw_properties_dw dw_properties_dw
uo_select uo_select
st_add st_add
st_1 st_1
uo_design uo_design
dw_fields_alias dw_fields_alias
cb_screen_properties cb_screen_properties
st_tab st_tab
dw_select_section dw_select_section
dw_properties dw_properties
st_back st_back
st_right st_right
end type
global pfc_cst_u_report_data_design pfc_cst_u_report_data_design

type variables
w_report_data_design parent_window_design

Integer ii_screen_id
//Integer ii_column_cnt
//Integer il_last_de_row

Integer il_dw_style = 0
//Integer il_dw_Detail_Height

//Long il_prac_id 
//Long il_rec_id
Long il_data_view = 1001

Boolean ib_screen_painter = True
Boolean ib_setup_dddw = True
Boolean ib_refresh_screen_list = False
//Boolean ib_win_just_opened = True
//Boolean ib_deleting = False

//String is_sql_syntax

String is_tab_label_names[]
String is_last_tab_label_name
String is_last_object[]
//String is_last_border[]
//String is_option = "Move"
//String is_object_list[]

//String is_last_object_width
//String is_last_object_height

//u_dw idw_detail 

Boolean ib_resize_width = False
Boolean ib_resize_height = False
Boolean ib_mouse_down
Boolean ib_multi_select = False
Boolean ib_control_down = False
Boolean ib_relocating_fields = False
Boolean ib_set_tab_order = False
Boolean ib_show_invisible = True


//Integer li_flags
Integer ii_obj_select_cnt = 0
//Integer ii_field_id[]
//Integer ii_tab_sequence
//Integer ii_row_to_move = 0


Long il_last_object_width[]
Long il_last_object_height[]
Long il_ancor_x
Long il_ancor_y
Long il_data_view_id = 1
Long il_last_object_x[]
Long il_last_object_y[]

//Long il_dw_scroll_pos = 0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.12.2007 By: Jack
//$<reason> Fix a defect.
long il_x2
long il_select_view
boolean ib_clicked 
string is_button_object[],is_button_visible[]      //Add by Jack 06/12/1007
//---------------------------- APPEON END ----------------------------

//string is_backup_objects[],is_backup_border[]		//04/28/2007 By Jervis temporary process property of border

DataStore ids_screen 			// Add by Evan 07/14/2008
long il_CurrentScreenHandle 	// Add by Evan 09/27/2008

long	il_CurCtxID					//Added by Scofield on 2009-01-13

//Added By Alan on 2009-2-3
u_dw			idw_preview
long			il_view_id





end variables

forward prototypes
public function integer of_show_invisible (boolean ab_show)
public function integer of_setup_painter ()
public function integer of_set_display_only ()
public function integer of_set_tab_order (boolean ab_status)
public function integer of_select_screen (integer currentrow, integer ai_screen_id)
public function integer of_select_view ()
public function integer of_set_parent_window (window aw_win)
public function integer of_retrieve_dw_properties (datawindow adw_detail)
public function integer of_save ()
public function integer of_adjust_width (integer ai_width)
public function integer of_adjust_position (integer ai_position)
public subroutine of_restore_properties (datawindow adw_target)
public function integer of_expression_sheet ()
public function integer of_create_dynamic_dw (integer ai_screen_id)
public function integer of_field_property_sheet ()
public function integer of_dw_property_sheet ()
public function integer of_modifydwproperties (string as_property)
public function integer of_set_dw_properties (string as_column_name, integer ai_flag)
public function integer of_text_property_sheet (string as_object)
public function long of_getcurrentscreenhandle ()
public function integer of_changescreenlable ()
public function integer of_create_dw ()
end prototypes

event pfc_cst_new_screen_painter();//Open( w_new_screen_painter )

end event

event type integer pfc_cst_select_view();Return of_select_view() // Modify by Evan 01/10/2008
end event

event ue_field_properties();//of_property_sheet() //Delete by Evan 07/24/2008
end event

event pfc_cst_sort();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-08 By: Andy
string ls_sort
setnull(ls_sort)
uo_band.dw_syntax.of_setsort( true)
uo_band.dw_syntax.inv_sort.of_SetUseDisplay(true)
uo_band.dw_syntax.inv_sort.of_setstyle(uo_band.dw_syntax.inv_sort.APPEONDRAGDROP)
uo_band.dw_syntax.inv_sort.of_setsort(ls_sort)
of_save()
//---------------------------- APPEON END ----------------------------

end event

event ue_properties();string ls_Type
pfc_cst_u_band_report ldw_band

// Check menu right
if Isvalid(w_mdi) then
	//user security :Screen Painter - Contract Field Properties
	if w_mdi.of_security_access(5320) = 0 then Return
end if
if isvalid(m_pfe_cst_contract_data_design) then
	if m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = false then Return
end if

// Get datawindow of band
ldw_band = parent_window_design.wf_getband(parent_window_design.is_CurBand)

// Open properties window
if isNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = "" then
	of_dw_property_sheet()
else
	ls_Type = ldw_Band.Describe(ldw_Band.is_CurObj + ".type")
	choose case ls_Type
		case "text"
			of_text_property_sheet(ldw_Band.is_CurObj)
		case "column", "compute"
			of_field_property_sheet()
	end choose
end if
end event

event ue_closecontract();//====================================================================
// Function: ue_closecontract.pfc_cst_u_contract_data_design()
//--------------------------------------------------------------------
// Description: Back the last selected tagpage
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Row,ll_RowCnt

il_CurCtxID = gw_Contract.tab_contract_details.tabpage_search.il_ctx_id
gw_Contract.of_BackupFocusObject(gw_Contract.Control[])
gw_Contract.TriggerEvent("pfc_close")

end event

event ue_opencontract();//====================================================================
// Function: ue_opencontract.pfc_cst_u_contract_data_design()
//--------------------------------------------------------------------
// Description: Restore select the last selected tabpage
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

long	ll_Row,ll_RowCnt

ll_RowCnt = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.RowCount()
ll_Row = gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.Find("ctx_id = " + String(il_CurCtxID),1,ll_RowCnt)
if ll_Row > 0 then
	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.ScrollToRow(ll_Row)
	gw_Contract.tab_contract_details.tabpage_search.dw_search_det1.SetRow(ll_Row)
end if

gw_Contract.of_RestoreFocusObject(gw_Contract.Control[])

il_CurCtxID = 0

end event

event ue_refreshcontract();//====================================================================
// Function: ue_refreshcontract.pfc_cst_u_contract_data_design()
//--------------------------------------------------------------------
// Description: Refresh the contract folder
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-01-13
//--------------------------------------------------------------------
//	Copyright (c) 2002-2009 Appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

if IsValid(gw_Contract) then
	PowerObject lpo_NullParm
	
	Trigger Event ue_CloseContract()
	
	gf_OpenContractFolder(lpo_NullParm)
	
	Post Event ue_OpenContract()
end if

end event

event pfc_cst_filter();//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-08 By: Andy
string ls_filter
setnull(ls_filter)
uo_band.dw_syntax.of_setfilter( true)
uo_band.dw_syntax.inv_filter.of_SetStyle(0)
uo_band.dw_syntax.inv_filter.of_setrequestor( uo_band.dw_syntax)
uo_band.dw_syntax.inv_filter.of_SetColumnDisplayNameStyle(2)
uo_band.dw_syntax.inv_filter.of_setfilter(ls_filter)
of_save()
//---------------------------- APPEON END ----------------------------

end event

public function integer of_show_invisible (boolean ab_show);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-11-08 By: Andy
uo_band.dw_header.of_show_invisible( ab_show )
uo_band.dw_detail.of_show_invisible( ab_show )
uo_band.dw_summary.of_show_invisible( ab_show )
uo_band.dw_footer.of_show_invisible( ab_show )
//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_setup_painter ();//idw_detail = dw_detail

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
	IF Upper(Mid(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
		li_sys_col_cnt ++
		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
	ELSEIF Upper(Mid(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
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

public function integer of_set_display_only ();//maha created 092204 for setting all fields in a window to read only
integer i
integer ic
integer res
string ls_val,ls_display

res = messagebox("Display Only","This function sets all fields in this screen to display only.~r Click YES to set all fields to display only; click NO to set all fields editable.", question!,yesnocancel!,3)
if res = 3 then 
	return 1
elseif res = 2 then 
	ls_val = "N"
else
	ls_val = "Y"
end if

//add 08/29/2007 by: Andy
if ls_val = "Y" then 
	ls_display = 'Yes'
else
	ls_display = 'No'
end if
//end of add

ic = dw_properties.rowcount()

for i = 1 to ic
	dw_properties.setitem(i,"data_view_fields_display_only",ls_val)
next

Long ll_column_count
Long ll_column
String ls_column_name
String ls_edit_style
String ls_Modify,ls_Band

ll_column_count = long(uo_band.dw_syntax.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count
	ls_column_name = uo_band.dw_syntax.Describe("#" + string(ll_column) + ".name")
	ls_edit_style = Lower(uo_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))

	// Display Only
	IF ls_edit_style = "edit" THEN
		//modify 11/15/2007 by: Andy
		ls_Modify = ls_column_name + ".edit.displayonly = '"+ls_display+"'"
		ls_Band = uo_band.dw_syntax.Describe("#" + string(ll_column) + ".Band")
		
		choose case lower(ls_Band)
			case 'header'
				uo_band.dw_header.modify( ls_Modify)
			case 'detail'
				uo_band.dw_detail.modify( ls_Modify)
			case 'summary'
				uo_band.dw_summary.modify( ls_Modify)
			case 'footer'
				uo_band.dw_footer.modify( ls_Modify)
			case else 
				//do nothing
				
		end choose
		
		uo_band.dw_syntax.Modify(ls_Modify)
	END IF
END FOR

return 1
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
String ls_names[]
Integer li_col_cnt
String ls_field_nm
Integer li_field_order
long ll_col_height
Integer li_TabSequence
String  ls_Modify //<add> 01.03.2008 by: Andy

ib_set_tab_order = ab_status

IF ab_status THEN
	st_tab.Visible = True
	cb_screen_properties.Enabled = False
	//BEGIN---Modify by Evan 07/14/2008
	//dw_select_section.Enabled = False
	uo_select.Enabled = False
	//END---Modify by Evan 07/14/2008
	
	//$<comment> 01.04.2008 by: Andy
	//$<Reason > No use,here hasn't the ability for modify the tab order.
	//uo_design.st_10.text = "Tab Order"
	//uo_design.dw_1.SetItem(1, "label","")
	//end of comment 01.04.2008
	
	//$<Modify> 2007-11-08 By: Andy Reason:uo_band.dw_detail,not dw_detail
	li_column_cnt = Integer(uo_band.dw_detail.Describe("DataWindow.Column.Count"))
	FOR i = 1 TO li_column_cnt
		ls_bc = uo_band.dw_detail.Describe("#" + String( i ) + ".Background.Color")
		ls_col_nm = uo_band.dw_detail.Describe("#" + String( i ) + ".Name")
		ls_tab_nm = "tab_" + ls_col_nm
		ll_col_x = Long( uo_band.dw_detail.Describe("#" + String( i ) + ".x") )
		li_col_width = Long( uo_band.dw_detail.Describe("#" + String( i ) + ".Width") )
		ll_col_height= Long( uo_band.dw_detail.Describe("#" + String( i ) + ".Height") )
		ll_col_y = Long(uo_band.dw_detail.Describe("#" + String( i ) + ".y"))

		//Grid style
		IF il_dw_style = 0 THEN
			ll_col_y = ll_col_y - 60
			ls_tab_x = String( ll_col_x + li_col_width - 100)
		ELSE
			//$<comment> 01.03.2008 by: Andy
			//Reason:After add band feature,it should add above it or the same height,not lower it.
			//ll_col_y = ll_col_y + ll_col_height + 12
			ls_tab_x = String( ll_col_x )
		END IF
		
		//$<add> 01.03.2008 by: Andy Reason:fixed a bug.
		if ll_col_y < 0 then ll_col_y = 0
		//end of add
		ls_tab_y = String(ll_col_y)
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.18.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		IF ls_bc = "16777215" THEN
		*/
		//$<modify> 01.02.2008 by: Andy
		//if column is selected,then the background color is not 16777215
		//IF ls_bc = "16777215" And uo_band.dw_detail.Describe("#" + String( i ) +  ".visible") = '1' THEN		
		IF uo_band.dw_detail.Describe("#" + String( i ) +  ".visible") = '1' THEN
		//end of modify
		//---------------------------- APPEON END ----------------------------
			ls_tab_order = uo_band.dw_detail.Describe( ls_col_nm + ".TabSequence" )
			//$<modify> 01.03.2008 by: Andy 
			//Reason: if it's grid style,create text failed.
			IF il_dw_style = 0 THEN
				ls_Modify = "create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			else
				ls_Modify = "create text(band=foreground text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")" 
			end if
			//uo_band.dw_detail.Modify("create text(band=detail text='" + ls_tab_order + "' border='0' color='0' x='" + ls_tab_x + "' y='" + ls_tab_y + "' height='52' width='100'  font.face='MS Sans Serif' font.height='-8' font.weight='400'  font.family='2' font.pitch='2' font.charset='0' background.mode='0' background.color='255' name=" + ls_tab_nm +")"  )
			uo_band.dw_detail.Modify( ls_Modify )
			//end of modify 01.03.2008
			
			is_tab_label_names[ i ] = ls_tab_nm
			li_cnt ++

			IF ls_tab_order = "10" THEN
				is_last_tab_label_name = ls_tab_nm
				uo_band.sle_tab.Text = ls_tab_order
				
				uo_band.dw_detail.Event ue_calc_tab_position()
			END IF		
		END IF
	END FOR
ELSE
	uo_band.dw_detail.Modify( Mid( is_last_tab_label_name, 5, 100 ) + ".TabSequence = '" + uo_band.sle_tab.Text + "'" )		
	
	li_column_cnt = UpperBound( is_tab_label_names )
	FOR i = 1 TO li_column_cnt
		uo_band.dw_detail.Modify( "Destroy " + is_tab_label_names[i] )
	END FOR
	is_tab_label_names = ls_names

	uo_band.sle_tab.Text = ""
	uo_band.sle_tab.Visible = False

	st_tab.Visible = False
	cb_screen_properties.Enabled = True
	
	//BEGIN---Modify by Evan 07/14/2008
	//dw_select_section.Enabled = True
	uo_select.Enabled = True
	//END---Modify by Evan 07/14/2008

	// Set field order
	dw_properties.SetFilter( "" )
	dw_properties.Filter()

	li_col_cnt = dw_properties.RowCount()
	FOR i = 1 TO li_col_cnt
		ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
		li_field_order =  Integer(uo_band.dw_detail.Describe( ls_field_nm + ".TabSequence" ))
		// Allow set order of field to 0
		//IF li_field_order > 0 THEN
			dw_properties.SetItem(i, "data_view_fields_field_order", li_field_order )	
		//END IF
	END FOR

	dw_properties.SetSort( "data_view_fields_field_order" )
	dw_properties.Sort()
	dw_properties.SetFilter( "data_view_fields_visible='Y'" )
	dw_properties.Filter()
	
	li_col_cnt = dw_properties.RowCount()
	
	li_TabSequence = 0
	FOR i = 1 TO li_col_cnt
		ls_field_nm = dw_properties.GetItemString(i, "sys_fields_field_name" )
		li_field_order = dw_properties.GetItemnumber( i, "data_view_fields_field_order")

		IF li_field_order > 0 THEN
			li_TabSequence++
			dw_properties.SetItem( i, "data_view_fields_field_order", li_TabSequence * 10 )
			//<Modify> 01.03.2008 by: Andy
			ls_Modify = ls_field_nm + ".TabSequence = '" + String(li_TabSequence * 10) + "'"
			uo_band.dw_detail.Modify( ls_Modify )
			parent_window_design.event ue_setmodify( ls_Modify )
			//end of modify
		END IF
	END FOR
	
	dw_properties.SetFilter( "" )
	dw_properties.Filter()
END IF

RETURN 0	
end function

public function integer of_select_screen (integer currentrow, integer ai_screen_id);Integer li_col_cnt
Integer i
Integer li_cnt
Integer li_row_cnt
STRING ls_sql

IF ib_refresh_screen_list = True THEN
	Return 1
END IF

//BEGIN---Delete by Evan 07/14/2008
/*
IF currentrow < 1 THEN
	Return 1
END IF
*/
//BEGIN---Delete by Evan 07/14/2008

IF uo_design.st_tab_order.BorderStyle = StyleLowered! THEN
	of_set_tab_order( False )
	uo_design.st_tab_order.TriggerEvent( Clicked! )
END IF

//BEGIN---Delete by Evan 07/14/2008
/*
dw_select_section.SelectRow(0, False)
dw_select_section.SelectRow( currentrow, True)
*/
//BEGIN---Delete by Evan 07/14/2008

// Create dw from database
IF of_create_dynamic_dw(ai_screen_id) < 0 THEN // Modify by Evan 07/14/2008, Add pass argument.
	RETURN -1
END IF

IF ib_refresh_screen_list = True THEN
	Return 1
END IF

//$<comment> 2007-11-05 By: Andy
/*
li_row_cnt = dw_properties.RowCount( )
li_col_cnt = Integer( dw_detail.Object.DataWindow.Column.Count )

FOR i = 1 TO li_col_cnt
	dw_detail.SetColumn(i)
	is_object_list[i] = dw_detail.GetColumnName()	
END FOR

FOR i = li_col_cnt+1 TO (li_col_cnt * 2)
	li_cnt++
	is_object_list[i] = is_object_list[li_cnt] + "_t"
END FOR
*/
of_show_invisible( ib_show_invisible )

dw_properties.ResetUpdate( )

//$<comment> 2007-11-05 By: Andy
//dw_detail.ResetUpdate( )

Return 1
end function

public function integer of_select_view ();String ls_ViewName,ls_data_view_name

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-20 By: Andy
//$<Reason> If it's modified,then show a messagebox.
string   ls_Syntax
int  li

ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")
IF ls_Syntax <> parent_window_design.is_OrgSyntax THEN
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
parent_window_design.is_OrgSyntax = ls_Syntax
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2009-01-13 By: Scofield
//$<Reason> Open Screen painter window.

if IsValid(gw_contract) and il_select_view = 0 then
	SELECT data_view_name INTO :ls_ViewName FROM data_view WHERE data_view_id = :gi_contract_view_id ;
	if IsNull(ls_ViewName) then ls_ViewName = ""
	
	Message.StringParm = String(gi_contract_view_id) + "~t" + ls_ViewName
else
	OpenWithParm( w_select_view, "C" ) // P-practitioner view C- Contract view
end if
//---------------------------- APPEON END ----------------------------

IF Message.StringParm = "Cancel" THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.26.2007 By: Jack
	//$<reason> Fix a defect.
	il_select_view = il_data_view	
	il_data_view_id = il_data_view
	//---------------------------- APPEON END ----------------------------
	//BEGIN---Delete by Evan 07/14/2008
	/*
	IF dw_select_section.Rowcount( ) = 0 THEN
		dw_select_section.Reset()
		dw_select_section.of_SetTransObject(SQLCA)
		dw_select_section.Retrieve( il_data_view )
		dw_select_section.SelectRow( 1, True )
	END IF
	*/
	//END---Delete by Evan 07/14/2008
	Return -1
ELSE
	/*
	IF parent_window_design.Event pfc_save() < 0 THEN
		Return -1
	END IF
	*/
	This.SetRedraw( False )

	Integer li_pos
	String ls_msg
	
	ls_msg = Message.StringParm
	li_pos = Pos( ls_msg, '~t' )
	il_data_view_id = Long( Left( ls_msg, li_pos - 1 ) )
	ls_data_view_name = Right( ls_msg, Len( ls_msg ) - li_pos )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 04.18.2007 By: Jack
	//$<reason> Fix a defect.
	il_select_view = il_data_view_id	
	//$<add> 03.17.2008 By: nova
	//$<reason> Fix a defect.BugN022703
	il_data_view= il_data_view_id	
	//---------------------------- APPEON END ----------------------------
	parent_window_design.Title = "Contract Data Screen Painter ( " + ls_data_view_name + " )"
	//BEGIN---Modify by Evan 07/14/2008
	/*
	dw_select_section.Reset()
	dw_select_section.of_SetTransObject( SQLCA )
	dw_select_section.Retrieve( il_data_view_id )

   dw_select_section.SetRow( 1 )
	dw_select_section.ScrollToRow( 1 )
	dw_select_section.SelectRow( 1, True )
	*/
	uo_select.Event ue_Retrieve(il_data_view_id)
	//END---Modify by Evan 07/14/2008
	
	This.SetRedraw( True )	
END IF

Return 0
end function

public function integer of_set_parent_window (window aw_win);parent_window_design = aw_win

Return 0
end function

public function integer of_retrieve_dw_properties (datawindow adw_detail);Long ll_column_count
Long ll_column
Long ll_row
Long ll_Color
STRING ls_column_name
STRING ls_str
STRING ls_edit_style
STRING ls_edit_codetable
STRING ls_editmask_codetable
STRING ls_column_coltype
STRING ls_column_border
STRING ls_column_ID

// Reset datawindow
dw_properties.Reset()

// Through all field
ll_column_count = long(adw_detail.Describe("DataWindow.Column.Count"))
FOR ll_column = 1 TO ll_column_count

	ll_row = dw_properties.Insertrow( 0 )

	ls_column_name = adw_detail.Describe("#" + string(ll_column) + ".name")
	ls_edit_style = Lower(adw_detail.Describe(ls_column_name+".Edit.Style"))
	ls_edit_codetable = Lower(adw_detail.Describe ( ls_column_name + ".Edit.CodeTable" ))
	ls_editmask_codetable = Lower(adw_detail.Describe ( ls_column_name + ".EditMask.CodeTable"))
	ls_column_coltype	= left(adw_detail.Describe(ls_column_name +".COLType"),4)
	
	//<add> 07/04/2007 by: Andy
	dw_properties.Setitem( ll_row, "data_view_fields_screen_id",ii_screen_id)
	//end of add
	
	// Enabled lookup Field
	dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)

	// Table Name

	// Filed Name
	dw_properties.Setitem( ll_row, "sys_fields_field_name", ls_column_name)

	// Filed ID
	ls_str = adw_detail.Describe(ls_column_name + ".ID")
	dw_properties.Setitem( ll_row, "data_view_fields_field_id", Long(ls_str))
		
	// Field Type
	ls_str = adw_detail.Describe(ls_column_name + ".ColType")
	//ls_str = Upper(Left(ls_str,1))
	dw_properties.Setitem( ll_row, "sys_fields_field_type", ls_str)
	IF Pos(Lower(ls_str),"date") > 0 THEN
		// Disable lookup Field
		dw_properties.Setitem( ll_row, "disable_fields_lookup", 1)
	END IF

	// Field Len
	
	// Visible
	ls_str = adw_detail.Describe(ls_column_name + ".Visible")
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.28.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	IF ls_str = "1" THEN ls_str = "Y" ELSE ls_str = "N"
	*/	
	IF ls_str = "0" THEN 
		ls_str = "N"		
	ELSEIF ls_str = "1" THEN
		ls_str = "Y" 
	End If
	//---------------------------- APPEON END ----------------------------
	dw_properties.Setitem( ll_row, "data_view_fields_visible", ls_str)

	// Field Label
	ls_str = adw_detail.Describe(ls_column_name + "_t.Text")
	//$<Modify> 2008-01-17 By: nova
	//$<Reason> Fix a defect. 
	if left(ls_str,1) = '"' then ls_str = Mid(ls_str,2)
   if Right(ls_str,1) = '"' then ls_str = Left(ls_str,len(ls_str) - 1)
	
	//$<Modify> 2008-01-04 By: Andy
	//$<Reason> Fix a defect. add if statement
	if Not (ls_str = "!" OR ls_str = "?") then
		dw_properties.Setitem( ll_row, "data_view_fields_field_label", ls_str)
	end if
	//end of modify 2008-01-04 
	
	// Field Label Color
	//BEGIN---Add by Evan 07/17/2008
	ll_Color = Long(adw_detail.Describe(ls_column_name + "_t.color"))	
	dw_properties.Setitem(ll_row, "fields_label_textcolor", ll_Color)
	ll_Color = Long(adw_detail.Describe(ls_column_name + "_t.background.color"))
	dw_properties.Setitem(ll_row, "fields_label_textbkcolor", ll_Color)	
	//END---Add by Evan 07/17/2008
	
	// Label Justification
	ls_str = adw_detail.Describe(ls_column_name + "_t.Alignment")
	dw_properties.Setitem( ll_row, "data_view_fields_label_justification", Integer(ls_str))
	
	// Field Order
	ls_str = adw_detail.Describe(ls_column_name + ".TabSequence")
	dw_properties.Setitem( ll_row, "data_view_fields_field_order", Integer(ls_str))
	
	// Required
	ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".Required")
	dw_properties.Setitem( ll_row, "data_view_fields_required", Left(Upper(ls_str),1))
		
	// Lookup Type	// Only "C" - code lookup
	
	IF ls_edit_style = "dddw" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".dddw.Name")
		IF ls_str = "d_dddw_code_lookup" THEN
			// Lookup Field
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field", "Y")

			// Lookup Table
			ls_str = adw_detail.Describe(ls_column_name + ".tag")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_code", ls_str)

			// Lookup Field Name
			ls_str = adw_detail.Describe(ls_column_name + ".dddw.DisplayColumn")
			dw_properties.Setitem( ll_row, "sys_fields_lookup_field_name", ls_str)
			
			// Enabled lookup Field
			dw_properties.Setitem( ll_row, "disable_fields_lookup", 0)
		ELSE
			// Disable lookup Field
			dw_properties.Setitem( ll_row, "disable_fields_lookup", 1)
		END IF
	END IF
	
	// Drop Down Width
	IF ls_edit_style = "dddw" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".dddw.PercentWidth")
		dw_properties.Setitem( ll_row, "sys_fields_drop_down_width", Integer(ls_str))
	END IF
	
	// Field Case
	IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
		ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".Case")
		dw_properties.Setitem( ll_row, "sys_fields_field_case", Left(Upper(ls_str),1))
	END IF
	
	// Field Mask
//	IF ls_edit_style = "editmask" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".Format")
		dw_properties.Setitem( ll_row, "sys_fields_field_mask", ls_str)
//	END IF
	
	// Audit Fld
	// Default Value
	ls_str = adw_detail.Describe(ls_column_name + ".Initial")
	dw_properties.Setitem( ll_row, "sys_fields_default_value", ls_str)
	
	// Justification
	ls_str = adw_detail.Describe(ls_column_name + ".Alignment")
	dw_properties.Setitem( ll_row, "data_view_fields_justification", Integer(ls_str))

	// Sort Order
	// Display Only
	IF ls_edit_style = "edit" THEN
		ls_str = adw_detail.Describe(ls_column_name + ".edit.displayonly")
	ELSE
		ls_str = "N"
	END IF
	dw_properties.Setitem( ll_row, "data_view_fields_display_only", Left(Upper(ls_str),1))
	
	// Data Validation
	
	// Fields label border
	ls_str = adw_detail.Describe(ls_column_name + "_t.Border")
	//$<Modify> 2008-01-04 By: Andy
	//$<Reason> Fix a defect. add if statement
	if Not (ls_str = "!" OR ls_str = "?") then
		dw_properties.Setitem( ll_row, "fields_label_border", ls_str)
	end if
	//end of modify 2008-01-04 
	// Fields border
	ls_column_border = adw_detail.Describe(ls_column_name + ".Border")
	dw_properties.Setitem( ll_row, "fields_border", ls_column_border)

	ls_str = adw_detail.describe(ls_column_name + ".protect")
	dw_properties.Setitem( ll_row, "fields_protect", ls_str)
	
	//Fields vert scroll bar By Jervis 12-10-2008
	IF ls_edit_style = "edit" OR ls_edit_style = "dddw" OR ls_edit_style = "ddlb" THEN
		ls_str = adw_detail.Describe(ls_column_name + "." + ls_edit_style + ".VScrollBar")
		dw_properties.Setitem( ll_row, "fields_vscrollbar", Left(Upper(ls_str),1))
	END IF
	

END FOR

RETURN 1

end function

public function integer of_save ();STRING ls_obj_name
STRING ls_dw_syntax
STRING ls_field_nm 
Integer i,li_col_cnt
Long ll_cr
//Integer li_pos //modified by nova 2008-09-23 
Long li_pos
DateTime ldt_today
Long ll_max_height
Long ll_col_y, ll_col_height
string ls_visible
long	 ll_count
blob	 lb_syntax

//<comment> 11/09/2007 by: Andy
//IF ib_relocating_fields THEN
//	Return 0
//END IF

IF ib_set_tab_order THEN
	Return 0
END IF

//BEGIN---Modify by Evan 07/14/2008
//ll_cr = dw_select_section.Getrow()
//ids_screen.SetFilter("")
//ids_screen.Filter()
//ll_cr = ids_screen.Find("screen_id=" + String(ii_screen_id), 1, ids_screen.RowCount())
////BEGIN---Modify by Evan 07/14/2008
//IF ll_cr = 0 THEN RETURN -1
//
//$<modify> 01.12.2008 by Andy
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 28/04/2007 By: Jervis
//$<reason> temporary process property of border for compute
of_restore_properties(uo_band.dw_syntax)
//---------------------------- APPEON END ----------------------------

//$<add> 03.18.2008 by Andy
//Set the same position to b_due_date_g and b_due_date_r
//if ii_screen_id = 33 or ii_screen_id = 47 then
//	String ls_x,ls_y,ls_width,ls_height,ls_modify
//	ls_x = uo_band.dw_syntax.Describe("b_due_date.x")
//	ls_y = uo_band.dw_syntax.Describe("b_due_date.y")
//	ls_width  = uo_band.dw_syntax.Describe("b_due_date.Width")
//	ls_height = uo_band.dw_syntax.Describe("b_due_date.Height")
//	ls_modify = "b_due_date_g.x='" + ls_x + "' b_due_date_r.x='" + ls_x + "' b_due_date_g.y='" + ls_y + "' b_due_date_r.y='" + ls_y + "' b_due_date_g.Width='" + ls_width + "' b_due_date_r.Width='" + ls_width + "' b_due_date_g.Height='" + ls_height + "' b_due_date_r.Height='" + ls_height + "' "
//	uo_band.dw_syntax.modify( ls_modify )
//end if

//Get syntax
ls_dw_syntax = uo_band.dw_syntax.Describe("DataWindow.Syntax")

//$<Modify> 2007-11-20 By: Andy
//$<Reason> Fix a defect.
parent_window_design.is_OrgSyntax = ls_dw_syntax

//If ii_screen_id <> 2 Then
//	IF il_dw_style = 1 THEN
//		li_pos = Pos(ls_dw_syntax,"processing=0")
//		IF li_pos > 0 THEN
//			ls_dw_syntax = Left(ls_dw_syntax,li_pos - 1) + "processing=1" + Mid(ls_dw_syntax, li_pos + 12)
//		END IF
//	END IF		
//Else
//	li_pos = Pos(ls_dw_syntax,"master_contract_id visible=")	
//	IF li_pos > 0 THEN
//		ls_dw_syntax = Left(ls_dw_syntax,li_pos + 27) + "1	if( master_contract_id > 0,1,0)" + Mid(ls_dw_syntax, li_pos + 29)
//	End If
//	
//	li_pos = Pos(ls_dw_syntax,"master_cnt visible=")
//	IF li_pos > 0 THEN
//		ls_dw_syntax = Left(ls_dw_syntax,li_pos + 19) + "1	if( master_cnt > 0 ,1,0)" + Mid(ls_dw_syntax, li_pos + 21)
//	End If	
//End If	

// Save syntax of dw to the database
//ls_dw_syntax = uo_band.dw_syntax.Describe("DataWindow.Syntax")
//end of modify 01.12.2008 by andy

//BEGIN---Modify by Evan 07/14/2008
/*
dw_select_section.setitem(ll_cr,'dw_sql',ls_dw_syntax)

// Update modify date
ldt_today = Datetime( Today(), Now() )
dw_select_section.Setitem (ll_cr, "modify_date", ldt_today)

//$<add> 09.06.2006 By: Liang QingShi
dw_select_section.Setitem (ll_cr, "updated", 1)

//gnv_appeondb.of_autocommit( )
gnv_appeondb.of_startqueue( )
dw_select_section.update( )
if (ii_screen_id = 1 or ii_screen_id = 2) and il_data_view = 1001 then
	update ctx_screen set dw_sql = :ls_dw_syntax,modify_date = :ldt_today where data_view_id <> 1001 and screen_id = :ii_screen_id;
end if
//$<add> 03.26.2008 by Andy
dw_fields_alias.Update( )
commit;
gnv_appeondb.of_commitqueue( )
*/
//ids_screen.setitem(ll_cr,'dw_sql',ls_dw_syntax)
//ldt_today = Datetime( Today(), Now() )
//ids_screen.Setitem (ll_cr, "modify_date", ldt_today)
//ids_screen.Setitem (ll_cr, "updated", 1)
ldt_today = Datetime( Today(), Now() )
select count(*) into :ll_count from ctx_report_syntax where view_id=:il_view_id;
lb_syntax = blob(ls_dw_syntax)
gnv_appeondb.of_startqueue( )
//ids_screen.update( )
//if (ii_screen_id = 1 or ii_screen_id = 2) and il_data_view = 1001 then
//	update ctx_screen set dw_sql = :ls_dw_syntax,modify_date = :ldt_today where data_view_id <> 1001 and screen_id = :ii_screen_id;
//end if
if ll_count=0 then
	insert ctx_report_syntax(view_id,dw_sql,modify_date) values(:il_view_id,:ls_dw_syntax,:ldt_today);
else
	update ctx_report_syntax set dw_sql = :ls_dw_syntax,modify_date=:ldt_today where view_id=:il_view_id;
end if
updateblob ctx_report_syntax set dw_syntax = :lb_syntax where view_id=:il_view_id;
//dw_fields_alias.Update( )
//dw_properties_dw.Update()
commit;
gnv_appeondb.of_commitqueue( )
//END---Modify by Evan 07/14/2008

dw_properties.ResetUpdate( )
uo_band.dw_syntax.ResetUpdate( )
//$<add> 03.26.2008 by Andy
dw_fields_alias.ResetUpdate( )

of_ChangeScreenLable() //Add by Evan 11/24/2008

RETURN 1
end function

public function integer of_adjust_width (integer ai_width);Long ll_width
Integer i
Integer li_start_col
Long ll_x
Long ll_obj_x
STRING ls_last_column
String ls_Modify

//<Modify> 11/09/2007 by: Andy
pfc_cst_u_band_report ldw_band

//IF ii_obj_select_cnt = 0 THEN RETURN 0
ldw_band = parent_window_design.wf_getband(parent_window_design.is_CurBand)

if IsNull(ldw_band.is_CurObj) or ldw_band.is_CurObj = '' then return 0
//
if pos(ldw_band.is_CurObj,'object') > 0 then return 0

ls_last_column = ldw_band.is_CurObj//is_last_object[1]
IF right( ls_last_column, 2 ) = "_t" THEN
	ls_last_column = Left( ls_last_column, Len(ls_last_column) - 2)
END IF

ll_x = Long( ldw_band.Describe( ls_last_column + ".x")	)
ll_width = Long( ldw_band.Describe( ls_last_column + ".width")	)

ll_width = ll_width + ai_width

//<modify> 11/09/2007 by: Andy
ls_Modify = ls_last_column+ ".width='" + String( ll_width ) + "' " + ls_last_column + "_t.width='" + String( ll_width ) + "'"

//dw_detail.Modify(ls_last_column+ ".width='" + String( ll_width ) + "'")			
//dw_detail.Modify(ls_last_column + "_t.width='" + String( ll_width ) + "'")
//end of modify

STRING ls_column_name
string	ls_ObjString
integer	li_Start=1, li_Tab, li_Count=0

/* Get the Object String */
ls_ObjString = ldw_band.Describe("Datawindow.Objects") + "~t"

/* Get the first tab position. */
li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Do While li_Tab > 0
	ls_column_name = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))
	//
	if pos(ls_column_name,'object') = 0 then
	// Determine if object is the right type and in the right band
		If	ldw_band.Describe(ls_column_name + ".visible") = "1" Then
			ll_obj_x = Long(ldw_band.Describe(ls_column_name + ".x"))
			IF ll_obj_x > ll_x THEN
				ll_obj_x += ai_width
				//<modify> 11/09/2007 by: Andy
				ls_Modify = ls_Modify + " " + ls_column_name + ".X='" + String( ll_obj_x ) + "'"
				//dw_detail.Modify(ls_column_name + ".X='" + String( ll_obj_x ) + "'")
				//end of modify
			END IF
		End if
	end if

	/* Get the next tab position. */
	li_Start = li_Tab + 1
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
Loop 

//<add> 11/09/2007 by: Andy
uo_band.dw_header.modify(ls_Modify)
uo_band.dw_detail.modify(ls_Modify)
parent_window_design.event ue_setmodify(ls_Modify)
//end of add

RETURN 1
end function

public function integer of_adjust_position (integer ai_position);Long ll_width
Long ll_x
Long ll_obj_x
Long ll_x2
String ls_column_name2
long ll_column_count
long ll_column
STRING ls_column_name
Long ll_space
Long ll_width1
STRING ls_last_column
string	ls_ObjString
integer	li_Start=1, li_Tab, li_Count=0
String ls_Modify

//<Modify> 11/09/2007 by: Andy
pfc_cst_u_band_report ldw_band

//IF ii_obj_select_cnt = 0 THEN RETURN 0
ldw_band = parent_window_design.wf_getband(parent_window_design.is_CurBand)

if IsNull(ldw_band.is_CurObj) or ldw_band.is_CurObj = '' then return 0
//
if pos(ldw_band.is_CurObj,'object') > 0 then return 0

ls_last_column = ldw_band.is_CurObj//is_last_object[1]
IF right( ls_last_column, 2 ) = "_t" THEN
	ls_last_column = Left( ls_last_column, Len(ls_last_column) - 2)
END IF

ll_x = Long( ldw_band.Describe( ls_last_column + ".x")	)

IF ai_position > 0 THEN
	ll_x2 = 100000

	/* Get the Object String */
	ls_ObjString = ldw_band.Describe("Datawindow.Objects") + "~t"

	/* Get the first tab position. */
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
	Do While li_Tab > 0
		ls_column_name = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))
		//
		if pos(ls_column_name,'object') = 0 then
		// Determine if object is the right type and in the right band
			If	ldw_band.Describe(ls_column_name + ".visible") = "1" and lower(ldw_band.Describe(ls_column_name + ".band")) = "detail" Then
				ll_obj_x = Long(ldw_band.Describe(ls_column_name + ".x"))
				IF ll_obj_x > ll_x AND ll_obj_x < ll_x2 THEN
					ls_column_name2 = ls_column_name
					ll_x2 = ll_obj_x
				END IF
			End if
		end if
	
		/* Get the next tab position. */
		li_Start = li_Tab + 1
		li_Tab =  Pos(ls_ObjString, "~t", li_Start)
	Loop 

	IF LEN(ls_column_name2) > 0 THEN
		ll_width = Long( ldw_band.Describe( ls_column_name2 + ".width")	)
		ll_width1 = Long( ldw_band.Describe( ls_last_column + ".width")	)
		ll_space = ll_x2 - ll_x - ll_width1
		
		//<Modify> 11/09/2007 by: Andy
		ls_Modify = ls_column_name2 + ".x='" + String( ll_x ) + "' " + ls_column_name2 + "_t.x='" + String( ll_x ) + "' " +&
						ls_last_column + ".x='" + String( ll_x + ll_width + ll_space) + "' " + ls_last_column + "_t.x='" + String( ll_x + ll_width + ll_space) + "'"
		/*				
		ldw_band.Modify(ls_column_name2 + ".x='" + String( ll_x ) + "'")			
		ldw_band.Modify(ls_column_name2 + "_t.x='" + String( ll_x ) + "'")
	
		ldw_band.Modify(ls_last_column + ".x='" + String( ll_x + ll_width + ll_space) + "'")			
		ldw_band.Modify(ls_last_column + "_t.x='" + String( ll_x + ll_width + ll_space) + "'")	
		*/
		//end of modify
	END IF
ELSE
	ll_x2 = -100000
	
	/* Get the Object String */
	ls_ObjString = ldw_band.Describe("Datawindow.Objects") + "~t"
	
	/* Get the first tab position. */
	li_Tab =  Pos(ls_ObjString, "~t", li_Start)
	Do While li_Tab > 0
		ls_column_name = Mid(ls_ObjString, li_Start, (li_Tab - li_Start))
		//
	   if pos(ls_column_name,'object') = 0 then
			// Determine if object is the right type and in the right band
			If	ldw_band.Describe(ls_column_name + ".visible") = "1" and lower(ldw_band.Describe(ls_column_name + ".band")) = "detail" Then
				ll_obj_x = Long(ldw_band.Describe(ls_column_name + ".x"))
				IF ll_obj_x < ll_x AND ll_obj_x > ll_x2 THEN
					ls_column_name2 = ls_column_name
					ll_x2 = ll_obj_x
				END IF
			End if
		end if
	
		/* Get the next tab position. */
		li_Start = li_Tab + 1
		li_Tab =  Pos(ls_ObjString, "~t", li_Start)
	Loop 

	IF LEN(ls_column_name2) > 0 THEN
		ll_width = Long( ldw_band.Describe( ls_column_name2 + ".width")	)
		ll_width1 = Long( ldw_band.Describe( ls_last_column + ".width")	)
		ll_space = ll_x - ll_x2 - ll_width
		
		//<Modify> 11/09/2007 by: Andy
		ls_Modify = ls_last_column + ".x='" + String( ll_x2) + "' " + ls_last_column + "_t.x='" + String( ll_x2 ) + "' " +& 
						ls_column_name2 + ".x='" + String( ll_x2 + ll_width1 + ll_space ) + "' " + ls_column_name2 + "_t.x='" + String( ll_x2 + ll_width1 + ll_space ) + "'"
		/*				
		ldw_band.Modify(ls_last_column + ".x='" + String( ll_x2) + "'")			
		ldw_band.Modify(ls_last_column + "_t.x='" + String( ll_x2 ) + "'")			

		ldw_band.Modify(ls_column_name2 + ".x='" + String( ll_x2 + ll_width1 + ll_space ) + "'")			
		ldw_band.Modify(ls_column_name2 + "_t.x='" + String( ll_x2 + ll_width1 + ll_space ) + "'")
		*/
		//end of modify
	END IF
END IF

//<add> 11/09/2007 by: Andy
uo_band.dw_header.modify(ls_Modify)
uo_band.dw_detail.modify(ls_Modify)
parent_window_design.event ue_setmodify(ls_Modify)
//end of add

RETURN 1
end function

public subroutine of_restore_properties (datawindow adw_target);//Temporary process property of border
long ll_i,ll_count

//comment 11/09/2007 by: Andy
/*
ll_count = UpperBound(is_backup_border)

for ll_i = 1 to ll_count
	adw_target.Modify(is_backup_objects[ll_i] + ".border =" + is_backup_border[ll_i] )
next 
*/
//end of comment

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 06.12.2007 By: Jack
//$<reason> Fix a defect.

ll_count = UpperBound(is_button_object)
For ll_i = 1 To ll_count
	adw_target.Modify(is_button_object[ll_i] + ".visible =" + is_button_visible[ll_i] )
Next 
//---------------------------- APPEON END ----------------------------

end subroutine

public function integer of_expression_sheet ();/**********************************************
Function: of_expression_sheet() returns (none)
describe: open expression dialog box
author  : Andy 06/21/2007
**********************************************/
str_pass  lstr_pass
String    ls_Expression
n_cst_string lnvo_string
pfc_cst_u_band_report ldw_band

ldw_band = parent_window_design.wf_getband( parent_window_design.is_CurBand )
if isNull(ldw_band.is_curobj) or ldw_band.is_curobj = '' then return 0

ls_Expression = ldw_Band.describe(ldw_band.is_curobj +".Expression")
if isnull(ls_Expression) then ls_Expression = ''
//<Modify> 08/10/2007 by: Andy Reason:BugV080401
IF Upper( appeongetclienttype() ) = 'PB' THEN
	if Left(ls_Expression,1) = '"' and Right(ls_Expression,1) = '"' then
		ls_Expression = Mid(ls_Expression,2,Len(ls_Expression) - 2)
	end if
	ls_Expression = lnvo_string.of_globalreplace( ls_Expression, '~~"', '"')
end if
//end if

lstr_pass.s_long[1] = 2	//1-Export Call, 2- Screen Painter Call, 3- Advanced Update call	--jervis 03.12.2009
//lstr_pass.l_facility_id     = -1//-1:screen/else:export
lstr_pass.s_string          = ls_Expression//expression
lstr_pass.s_string_array[1] = ldw_band.is_curobj//object name
lstr_pass.s_u_dw            = ldw_Band//relative dw
openwithparm(w_export_expression_report,lstr_pass)

return 0

end function

public function integer of_create_dynamic_dw (integer ai_screen_id);String ls_sql
Long ll_cr
//Integer li_pos//modified by nova 2008-09-23
long li_pos
String ls_error_create
Long ll_dw_sql_len
Long ll_screen_id
Long ll_updated
Long ll_FindRow
string	ls_Screen_Style

//BEGIN---Modify by Evan 07/14/2008
/*
ll_cr = dw_select_section.Getrow()
IF ll_cr = 0 THEN
	//MessageBox("Select View", "You must first select a view before adding sections.")
	Return 0
END IF
il_dw_style = 0
ls_sql = dw_select_section.GetitemString(ll_cr, "dw_sql")

//$<add> 09.06.2006 By: Liang QingShi
long ll_updated
dw_select_section.accepttext()
ll_updated = dw_select_section.getitemnumber(ll_cr,'updated')
IF appeongetclienttype() = 'PB' and ll_updated = 0 THEN
//$<add> 09.06.2006 By: Liang QingShi

	ll_dw_sql_len = dw_select_section.GetItemNumber( ll_cr, "dw_sql_len")
	ll_screen_id = dw_select_section.GetItemNumber( ll_cr, "screen_id")
	IF ll_dw_sql_len > 32765 THEN
		ls_sql = f_get_screen_sql(il_data_view_id, ll_screen_id)
	END IF
END IF
*/
il_dw_style = 0
ids_screen.SetFilter("")
ids_screen.Filter()
ll_FindRow = ids_screen.Find("screen_id=" + String(ai_screen_id), 1, ids_screen.RowCount())
if ll_FindRow <= 0 then Return 0

/****************************************///added by gavins 20120313 grid
ls_Screen_Style = ids_screen.GetitemString(ll_FindRow, "screen_style")
/****************************************/
If ls_Screen_Style = 'G' Then//added by gavins 20120313 grid
	ls_sql = ids_screen.GetitemString(ll_FindRow, "grid_sql")
Else
	ls_sql = ids_screen.GetitemString(ll_FindRow, "dw_sql")
End If
ll_updated = ids_screen.GetitemNumber(ll_FindRow,'updated')
IF appeongetclienttype() = 'PB' and ll_updated = 0 THEN
	If ls_Screen_Style = 'G' Then//added by gavins 20120313 grid
		ll_dw_sql_len = ids_screen.GetItemNumber(ll_FindRow, "grid_sql_len")
	Else
		ll_dw_sql_len = ids_screen.GetItemNumber(ll_FindRow, "dw_sql_len")
	End If
	ll_screen_id = ids_screen.GetItemNumber(ll_FindRow, "screen_id")
	IF ll_dw_sql_len > 32765 THEN
		If ls_Screen_Style = 'G' Then//added by gavins 20120313 grid
			ls_sql = f_get_screen_gridsql(il_data_view_id, ll_screen_id,false)
		Else
			ls_sql = f_get_screen_sql(il_data_view_id, ll_screen_id,false)
		End If
	END IF
END IF
//END---Modify by Evan 07/14/2008

IF Isnull(ls_sql) OR LEN(ls_sql) = 0 THEN
	Messagebox("Generate DataWindow", "The DataWindow does not exist in the database!")
//	dw_detail.Dataobject = ""
	RETURN -1
END IF

// Convert grid style to tabular
li_pos = Pos(ls_sql,"processing=1")
IF li_pos > 0 THEN
	ls_sql = Left(ls_sql,li_pos - 1) + "processing=0" + Mid(ls_sql, li_pos + 12)
	il_dw_style = 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.27.2007 By: Jack 
//$<reason> Fix a defect.
If ii_screen_id = 2 Then
	//$<comment> 01.11.2008 by: Andy
	//Reason:There are many invisible objects,if these range in a row,there is a bug in WEB verion(can not display all invisible objects when Show Invisible button is clicked).
	//il_dw_style = 1
	
	li_pos = Pos(ls_sql,"1	if( master_contract_id > 0,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 33)
	End If
	
	li_pos = Pos(ls_sql,"1	if( master_cnt > 0 ,1,0)")
	IF li_pos > 0 THEN
		ls_sql = Left(ls_sql,li_pos - 1) + "1" + Mid(ls_sql, li_pos + 26)
	End If	
End If	

//$<add> 2007-11-02 By: Andy
parent_window_design.wf_makeband( ls_sql)

//---------------------------- APPEON END ----------------------------

// Free form style
IF il_dw_style = 0 THEN
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 20000" )

	uo_design.st_1.Visible = TRUE
	uo_design.st_2.Visible = TRUE
	uo_design.st_text.Visible = TRUE
	uo_design.r_2.Visible = TRUE
	uo_design.st_7.Visible = TRUE
	//<add> 06/21/2007 by: Andy
	uo_design.st_5.Visible = TRUE
	//end of add
	uo_design.st_3.Visible = FALSE
	uo_design.st_4.Visible = FALSE
	uo_design.hsb_1.Visible = FALSE
	uo_design.hsb_2.Visible = FALSE
	
	uo_design.st_show_invisible.Visible = FALSE		//Added by Scofield on 2010-03-23
ELSE
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
	
	uo_design.st_1.Visible = FALSE
	uo_design.st_2.Visible = FALSE
	uo_design.st_text.Visible = FALSE
	uo_design.r_2.Visible = FALSE
	uo_design.st_7.Visible = FALSE
	//<add> 06/21/2007 by: Andy
	uo_design.st_5.Visible = FALSE
	//end of add	
	uo_design.st_3.Visible = TRUE
	uo_design.st_4.Visible = TRUE
	uo_design.hsb_1.Visible = TRUE
	uo_design.hsb_2.Visible = TRUE
	
	uo_design.st_show_invisible.Visible = TRUE		//Added by Scofield on 2010-03-23
	
	//$<modify> 01.11.2008 By: Andy
	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
END IF

//$<add> 03.25.2008 by Andy
dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
//end of add 03.25.2008

RETURN 1
end function

public function integer of_field_property_sheet ();//BEGIN---Delete by Evan 07/18/2008
//Remark: These codes were move to ue_field_properties event
/*
//Check Right		
IF Isvalid(w_mdi) THEN
	//user security :Screen Painter - Contract Field Properties
	IF W_MDI.of_security_access( 5320 ) = 0 THEN
		RETURN 0
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-13 By: Andy
*/
//END---Delete by Evan 07/18/2008

String ls_field_id
pfc_cst_u_band_report ldw_band

ldw_band = parent_window_design.wf_getband( parent_window_design.is_CurBand )

//BEGIN---Delete by Evan 07/18/2008
/*
IF isNull(ldw_Band.is_CurObj) or ldw_Band.is_CurObj = "" THEN
	MessageBox("Select", "You must first select a field by clicking on it." )
	RETURN -1
END IF
*/
//END---Delete by Evan 07/18/2008

//<add> 06/21/2007 by: Andy Open expression dialog box
if ldw_Band.describe(is_last_object[1] + ".type") = "compute" THEN
	return of_expression_sheet()
end if
//end of add

IF Right(is_last_object[1], 2) = "_t" THEN
	ls_field_id = ldw_Band.Describe( is_last_object[1] + ".tag" )
ELSE
	IF Lower(ldw_Band.Describe(is_last_object[1] + ".type")) = "column" THEN
		ls_field_id = ldw_Band.Describe( is_last_object[1] + ".id" )
	END IF
END IF

IF TRIM(ls_field_id)="" OR Isnull(ls_field_id) OR NOT Isnumber(ls_field_id) THEN
	RETURN 0
END IF

if ls_field_id <> '?' then
	dw_properties.SetFilter("data_view_fields_field_id = " + ls_field_id )
	dw_properties.Filter()
else
	return 0
end if

IF dw_properties.Rowcount() = 0 THEN RETURN 0

IF NOT IsValid(w_report_field_properties) THEN
	Open(w_report_field_properties)
END IF

Return 0
//---------------------------- APPEON END ----------------------------
end function

public function integer of_dw_property_sheet ();Open(w_contract_dw_properties)
dw_properties_dw.ShareData(w_contract_dw_properties.dw_properties_dw)

Return 1
end function

public function integer of_modifydwproperties (string as_property);string ls_Modify

// Modify datawindow properties
choose case as_Property
	case "background_color"
		ls_Modify = "datawindow.color=" + String(dw_properties_dw.object.background_color[1])
	case else
		Return 0
end choose

uo_band.dw_syntax.Modify(ls_Modify)

// Refresh datawindow color
uo_band.dw_header.Modify(ls_Modify)
uo_band.dw_detail.Modify(ls_Modify)
uo_band.dw_summary.Modify(ls_Modify)
uo_band.dw_footer.Modify(ls_Modify)

Return 1

end function

public function integer of_set_dw_properties (string as_column_name, integer ai_flag);//BEGIN---Modify by Evan 07/24/2008
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-13 By: Andy

pfc_cst_u_band_report ldw_band

ldw_band = parent_window_design.wf_getband( parent_window_design.is_curband )
ldw_band.of_set_dw_properties( as_column_name )

return 1
//---------------------------- APPEON END ----------------------------
*/
pfc_cst_u_band_report ldw_band
ldw_band = parent_window_design.wf_getband(parent_window_design.is_curband)

choose case ai_Flag
	case 1 // Set datawindow properties
		of_ModifyDWProperties(as_column_name)
	case 2 // Set column and compute properties		
		ldw_band.of_set_dw_properties(as_column_name)		
	case 3 // Set text properties
		ldw_band.of_ModifyTextProperties(as_column_name)
end choose

Return 1
//END---Modify by Evan 07/24/2008
end function

public function integer of_text_property_sheet (string as_object);Open(w_report_text_properties)
dw_properties_text.ShareData(w_report_text_properties.dw_properties_text)
dw_properties_text.Event ue_Retrieve(as_Object)

Return 1
end function

public function long of_getcurrentscreenhandle ();Return il_CurrentScreenHandle
end function

public function integer of_changescreenlable ();//////////////////////////////////////////////////////////////////////
// $<function>  of_changescreenlable
// $<arguments> (None)
// $<returns>   integer
// $<description> Change screen lable of tree item
//////////////////////////////////////////////////////////////////////
// $<add> 11/24/2008 by Evan
//////////////////////////////////////////////////////////////////////

long ll_FindRow
string ls_titlebar_text
TreeViewItem ltiv_item

ll_FindRow = dw_properties_dw.Find("screen_id = " + String(ii_screen_id), 1, dw_properties_dw.RowCount())
if ll_FindRow > 0 then
	ls_titlebar_text = dw_properties_dw.GetItemString(ll_FindRow, "titlebar_text")
	if Len(ls_titlebar_text) > 0 then
		uo_select.tv_screen.GetItem(il_CurrentScreenHandle, ltiv_item)
		ltiv_item.Label = ls_titlebar_text
		uo_select.tv_screen.SetItem(il_CurrentScreenHandle, ltiv_item)
	end if
end if

Return 1
end function

public function integer of_create_dw ();//Added By Alan on 2009-2-4
parent_window_design.wf_makeband(idw_preview.describe("datawindow.syntax"))
//---------------------------- APPEON END ----------------------------

// Free form style
//IF il_dw_style = 0 THEN
	//$<comment> 2007-11-07 By: Andy
	//idw_detail.Modify( "DataWindow.Detail.Height = 20000" )

	uo_design.st_1.Visible = TRUE
	uo_design.st_2.Visible = TRUE
	uo_design.st_text.Visible = TRUE
	uo_design.r_2.Visible = TRUE
	uo_design.st_7.Visible = TRUE
	//<add> 06/21/2007 by: Andy
	uo_design.st_5.Visible = TRUE
	//end of add
//	uo_design.st_3.Visible = FALSE
//	uo_design.st_4.Visible = FALSE
//	uo_design.hsb_1.Visible = FALSE
//	uo_design.hsb_2.Visible = FALSE
//ELSE
//	//$<comment> 2007-11-07 By: Andy
//	//idw_detail.Modify( "DataWindow.Detail.Height = 1000" )
//	
//	uo_design.st_1.Visible = FALSE
//	uo_design.st_2.Visible = FALSE
//	uo_design.st_text.Visible = FALSE
//	uo_design.r_2.Visible = FALSE
//	uo_design.st_7.Visible = FALSE
//	//<add> 06/21/2007 by: Andy
//	uo_design.st_5.Visible = FALSE
//	//end of add	
//	uo_design.st_3.Visible = TRUE
//	uo_design.st_4.Visible = TRUE
//	uo_design.hsb_1.Visible = TRUE
//	uo_design.hsb_2.Visible = TRUE
//	
	//$<modify> 01.11.2008 By: Andy
//	uo_band.dw_detail.Modify("DataWindow.Selected.Mouse = No")
//END IF

//$<add> 03.25.2008 by Andy
//dw_fields_alias.retrieve( 1 , ','+String(ii_screen_id)+',' , il_data_view)
//end of add 03.25.2008

of_show_invisible( ib_show_invisible )

RETURN 1
end function

on pfc_cst_u_report_data_design.create
this.uo_band=create uo_band
this.dw_properties_text=create dw_properties_text
this.dw_properties_dw=create dw_properties_dw
this.uo_select=create uo_select
this.st_add=create st_add
this.st_1=create st_1
this.uo_design=create uo_design
this.dw_fields_alias=create dw_fields_alias
this.cb_screen_properties=create cb_screen_properties
this.st_tab=create st_tab
this.dw_select_section=create dw_select_section
this.dw_properties=create dw_properties
this.st_back=create st_back
this.st_right=create st_right
this.Control[]={this.uo_band,&
this.dw_properties_text,&
this.dw_properties_dw,&
this.uo_select,&
this.st_add,&
this.st_1,&
this.uo_design,&
this.dw_fields_alias,&
this.cb_screen_properties,&
this.st_tab,&
this.dw_select_section,&
this.dw_properties,&
this.st_back,&
this.st_right}
end on

on pfc_cst_u_report_data_design.destroy
destroy(this.uo_band)
destroy(this.dw_properties_text)
destroy(this.dw_properties_dw)
destroy(this.uo_select)
destroy(this.st_add)
destroy(this.st_1)
destroy(this.uo_design)
destroy(this.dw_fields_alias)
destroy(this.cb_screen_properties)
destroy(this.st_tab)
destroy(this.dw_select_section)
destroy(this.dw_properties)
destroy(this.st_back)
destroy(this.st_right)
end on

event constructor;//idw_detail = dw_detail
str_custom_report lstr

lstr = message.powerobjectparm

idw_preview = lstr.adw_preview
il_view_id = lstr.al_view_id


uo_band.idw_preview = idw_preview
uo_band.il_view_id = il_view_id

if pos(idw_preview.describe("datawindow.syntax"),"group(")>0 then
	uo_band.ib_group=true
else
	uo_band.dw_headergroup.visible = false
	uo_band.st_headergroup.visible=false
	uo_band.dw_trailergroup.visible = false
	uo_band.st_trailergroup.visible=false
end if


end event

type uo_band from pfc_cst_u_band_painter_report within pfc_cst_u_report_data_design
integer y = 276
integer width = 3767
integer height = 2548
integer taborder = 30
end type

on uo_band.destroy
call pfc_cst_u_band_painter_report::destroy
end on

type dw_properties_text from u_dw within pfc_cst_u_report_data_design
event type long ue_retrieve ( string as_object )
boolean visible = false
integer x = 151
integer y = 456
integer width = 997
integer height = 616
integer taborder = 20
string dataobject = "d_contract_text_properties"
end type

event type long ue_retrieve(string as_object);long ll_Color

this.Reset()
this.InsertRow(0)

this.SetItem(1, "name", as_Object)
this.SetItem(1, "visible", uo_band.dw_syntax.Describe(as_Object + ".visible"))
this.SetItem(1, "text", uo_band.dw_syntax.Describe(as_Object + ".text"))
this.SetItem(1, "alignment", uo_band.dw_syntax.Describe(as_Object + ".alignment"))
this.SetItem(1, "border", uo_band.dw_syntax.Describe(as_Object + ".border"))

ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".color"))
this.SetItem(1, "text_color", ll_Color)
ll_Color = Long(uo_band.dw_syntax.Describe(as_Object + ".background.color"))
this.SetItem(1, "background_color", ll_Color)

if IsValid(w_report_text_properties) then
	w_report_text_properties.of_ShowColor()
end if

Return 1
end event

type dw_properties_dw from u_dw within pfc_cst_u_report_data_design
event type long ue_retrieve ( long al_data_view_id,  long al_screen_id )
event type string ue_getdeftitlebartext ( long al_screen_id )
boolean visible = false
integer x = 151
integer y = 456
integer width = 997
integer height = 616
integer taborder = 20
string dataobject = "d_contract_dw_properties"
end type

event type long ue_retrieve(long al_data_view_id, long al_screen_id);long ll_Color
long ll_RowCount
string ls_titlebar_text

ll_RowCount = this.Retrieve(al_data_view_id, al_screen_id)
if ll_RowCount > 0 then
	ll_Color = Long(uo_band.dw_syntax.Describe("datawindow.color"))
	this.SetItem(1, "background_color", ll_Color)
	ls_titlebar_text = this.object.titlebar_text[1]
	if IsNull(ls_titlebar_text) or Len(ls_titlebar_text) = 0 then
		ls_titlebar_text = this.Event ue_GetDefTitleBarText(al_screen_id)
		this.object.titlebar_text[1] = ls_titlebar_text
	end if
	this.ResetUpdate()
end if

if IsValid(w_contract_dw_properties) then
	w_contract_dw_properties.of_ShowColor()
end if

Return ll_RowCount
end event

event type string ue_getdeftitlebartext(long al_screen_id);//////////////////////////////////////////////////////////////////////
// $<event>  ue_getdeftitlebartext()
// $<arguments> 
// 		long	al_screen_id
// $<returns>   string
// $<description> Get default title bar text
//////////////////////////////////////////////////////////////////////
// $<add> 11/11/2008 by Evan
//////////////////////////////////////////////////////////////////////

integer li_Pos
string  ls_screen_name
string  ls_titlebar_text

choose case al_screen_id
	case 17
		ls_titlebar_text = "Notes"
	case 18
		ls_titlebar_text = "Parent Organization"
	case 19
		ls_titlebar_text = "Group / Locations"
	case 20
		ls_titlebar_text = "Associated Physicians for Selected Facility"
	case 21
		ls_titlebar_text = "Specialties for Selected Facility"
	case else
		ls_screen_name = this.object.screen_name[1]
		li_Pos = LastPos(ls_screen_name, ">")
		if li_Pos > 0 then
			ls_titlebar_text = Right(ls_screen_name, Len(ls_screen_name) - li_Pos)
		end if		
end choose

Return ls_titlebar_text
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type uo_select from u_contract_select_screen within pfc_cst_u_report_data_design
event ue_retrieve ( long al_data_view_id )
boolean visible = false
integer x = 18
integer y = 272
integer taborder = 20
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_retrieve(long al_data_view_id);long ll_FirstScreenItem

// Create screen view
tv_screen.of_Retrieve(al_data_view_id)
ids_screen = tv_screen.ids_data

// Select first screen item
ll_FirstScreenItem = tv_screen.of_FindFirstScreenItem()
tv_screen.SelectItem(ll_FirstScreenItem)
end event

on uo_select.destroy
call u_contract_select_screen::destroy
end on

event ue_selectionchanged;call super::ue_selectionchanged;TreeViewItem ltvi_item

// Get screen item information
if tv_screen.GetItem(al_NewHandle, ltvi_item) = -1 then Return 0
if ltvi_item.PictureIndex = 1 then Return 0
of_SetTitle("Select Data Screen (" + ltvi_item.Label + ")")
il_CurrentScreenHandle = al_NewHandle

// Show datawindow
ii_screen_id = ltvi_item.data
SetPointer(HourGlass!)
of_select_screen(0, ii_screen_id)

// Reset properties window data
dw_properties_text.Reset()
dw_properties_dw.Event ue_Retrieve(il_data_view_id, ii_screen_id)
SetPointer(Arrow!)

// UI setting
//Commented by Scofield on 2009-03-24
/*
If il_select_view <> 1001 And (ii_screen_id = 1 Or ii_screen_id = 2) Then
	st_1.visible = True
	If ii_screen_id = 1 Then
		st_1.text = 'The Search Criteria screen can only be modified in the Default View.'
	Else
		st_1.text = 'The Search Contract Browse screen can only be modified in the Default View.'
	End If
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = False
	End If
	uo_design.of_setobjectenable( false)	
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = True
		//m_pfe_cst_contract_data_design.m_file.m_save.enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', True)
		//---------End Modfiied ------------------------------------------------------
	End If
	uo_design.of_setobjectenable( true)
//End If

Return 0
end event

event ue_selectionchanging;call super::ue_selectionchanging;int  li
string ls_Syntax

dw_properties_dw.AcceptText()
ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")

IF ls_Syntax <> parent_window_design.is_OrgSyntax or dw_properties_dw.ModifiedCount() > 0 THEN
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF

Return 0
end event

type st_add from statictext within pfc_cst_u_report_data_design
boolean visible = false
integer x = 2203
integer y = 1808
integer width = 1307
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "Click where you want to add the object."
boolean focusrectangle = false
end type

type st_1 from statictext within pfc_cst_u_report_data_design
boolean visible = false
integer x = 1801
integer y = 1128
integer width = 1687
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
string text = "The Search Contract Browse screen can only be modified in the Default View."
boolean focusrectangle = false
end type

type uo_design from uo_report_design_menu within pfc_cst_u_report_data_design
integer taborder = 10
end type

on uo_design.destroy
call uo_report_design_menu::destroy
end on

type dw_fields_alias from datawindow within pfc_cst_u_report_data_design
boolean visible = false
integer x = 1083
integer y = 912
integer width = 686
integer height = 400
integer taborder = 60
string dataobject = "d_view_fields_alias_screen"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//$<add> 03.25.2008 by Andy
this.settransobject( SQLCA )
end event

type cb_screen_properties from u_cb within pfc_cst_u_report_data_design
boolean visible = false
integer x = 23
integer y = 1712
integer width = 736
integer height = 80
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Edit Screen Parameters"
end type

event clicked;Integer li_last_row
TreeViewItem ltvi_item

//BEGIN---Modify by Evan 07/14/2008
//ii_screen_id = dw_select_section.GetItemNumber(dw_select_section.GetRow(), "screen_id") 
if uo_select.tv_screen.of_GetCurrentItem(ltvi_item) = -1 then Return
if ltvi_item.PictureIndex = 1 then Return
ii_screen_id = ltvi_item.Data
//END---Modify by Evan 07/14/2008

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

type st_tab from statictext within pfc_cst_u_report_data_design
boolean visible = false
integer x = 2322
integer y = 1752
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Click on red tab labels to modify."
boolean focusrectangle = false
end type

type dw_select_section from u_dw within pfc_cst_u_report_data_design
event pfc_cst_after_error ( )
boolean visible = false
integer x = 14
integer y = 268
integer width = 1234
integer height = 1684
integer taborder = 20
boolean titlebar = true
string title = "Select Data Screen"
string dataobject = "d_contract_data_view_screens_list"
boolean hscrollbar = true
end type

event pfc_cst_after_error();//dw_detail.SetFocus()
end event

event clicked;call super::clicked;//Integer li_row
//
//li_row = This.GetClickedRow()
//
//IF li_row = 0 THEN
//	dw_detail.SetFocus()
//END IF
end event

event rowfocuschanged;call super::rowfocuschanged;IF currentrow = 0 THEN
	Return
END IF
ii_screen_id = dw_select_section.GetItemNumber(currentrow, "screen_id") 
of_select_screen( currentrow, ii_screen_id )
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.18.2007 By: Jack
//$<reason> Fix a defect.
//Commented by Scofield on 2009-03-24
/*
If il_select_view <> 1001 And (ii_screen_id = 1 Or ii_screen_id = 2) Then
	st_1.visible = True
	If ii_screen_id = 1 Then
		st_1.text = 'The Search Criteria screen can only be modified in the Default View.'
	Else
		st_1.text = 'The Search Contract Browse screen can only be modified in the Default View.'
	End If
	If isvalid(m_pfe_cst_contract_data_design) Then
		m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = False
		m_pfe_cst_contract_data_design.m_file.m_save.enabled = False
	End If
	uo_design.of_setobjectenable( false)
Else
*/
	st_1.visible = False
	If isvalid(m_pfe_cst_contract_data_design) Then
		//---------Begin Modified by (Appeon)Harry 01.24.2014 for V142 ISG-CLX--------
		//m_pfe_cst_contract_data_design.m_view.m_fieldproperties.enabled = True
		//m_pfe_cst_contract_data_design.m_file.m_save.enabled = True
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_view.m_fieldproperties,'enabled', True)
		gnv_app.of_modify_menu_attr( m_pfe_cst_contract_data_design.m_file.m_save,'enabled', True)
		//---------End Modfiied ------------------------------------------------------
	End If
	uo_design.of_setobjectenable( true)
//End If	
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 04.12.2007 By: Jack
//$<reason> Fix a defect.
/*
//dw_detail.vscrollbar = True
If appeongetclienttype() = 'PB' Then
//	If il_dw_style = 1 Then
		dw_detail.setposition(ToTop!)
		dw_detail.vscrollbar = True
		dw_detail.hscrollbar = True
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.11.2007 By: Jack
		//$<reason> fix a defect.
		/*
		dw_detail.x = 1257
		dw_detail.width = 2688
		*/
		dw_detail.x = dw_select_section.x + dw_select_section.width + 20
		dw_detail.width = parent.width - dw_detail.x - 20
		//---------------------------- APPEON END ----------------------------
		hsb_detail.visible = false
		vsb_detail.visible = false
	Else
		dw_detail.setposition(ToBottom!)
		dw_detail.vscrollbar = false
		dw_detail.hscrollbar = false
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04.11.2007 By: Jack
		//$<reason> fix a defect.
		/*
		dw_detail.x = 1257
		dw_detail.width = 3930
		*/
		dw_detail.x = dw_select_section.x + dw_select_section.width + 20
		dw_detail.width = parent.width - dw_detail.x -20
		//---------------------------- APPEON END ----------------------------
		hsb_detail.visible = true
		vsb_detail.visible = true
		
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 04.11.2007 By: Jack
		//$<reason> Fix a defect.		
		hsb_detail.x = dw_detail.x
		vsb_detail.x = parent.width - 100
		hsb_detail.y = parent.height - 100
		hsb_detail.width = dw_detail.width - 88
		vsb_detail.y = dw_detail.y
		vsb_detail.height = dw_detail.height - 68
		hsb_detail.position = 0
		vsb_detail.position = 0
		//---------------------------- APPEON END ----------------------------
	End If
End If
*/
//---------------------------- APPEON END ----------------------------

end event

event rowfocuschanging;call super::rowfocuschanging;//Integer li_retval
////--------------------------- APPEON BEGIN ---------------------------
////$<ID> PT-19
////$<add> 03.03.2006 By: Cao YongWang
////$<reason> Performance tuning. 
////$<modification> Write script to make sure that when pfc_cst_u_data_entry
////$<modification> is just opened, RowFocusChanging is not executed immediately.
//If ib_just_open Then
//	ib_just_open = False
//	return
//End If
//If currentrow < 1 Then return
////---------------------------- APPEON END ----------------------------
//
//IF ib_screen_painter THEN
//	IF is_designer_type = "S" THEN
//		IF Parent_window_design.Event pfc_Save() < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//			Return 1
//		END IF
//	ELSE
//		IF Parent_window_profile_design.Event pfc_Save() < 0 THEN
//			This.PostEvent( "pfc_cst_after_error" )
//			Return 1
//		END IF		
//	END IF
//ELSE
//	li_retval = Parent_window.Event pfc_Save()
//
//	IF li_retval < 0 THEN
//		This.PostEvent( "pfc_cst_after_error" )
//		Return 1
//	END IF	
//END IF
//

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-11-20 By: Andy
//$<Reason> If it's modified,then show a messagebox.
string   ls_Syntax
int  li

ls_Syntax = uo_band.dw_syntax.describe("datawindow.syntax")
IF ls_Syntax <> parent_window_design.is_OrgSyntax THEN
	li = messagebox(gnv_app.iapp_object.DisplayName,'Do you want to save changes?',question!,yesnocancel!)
	IF li = 1 THEN
		IF of_save() < 0 THEN
			return 1
		END IF
	ELSEIF li = 3 THEN
		return 1
	END IF
END IF
//---------------------------- APPEON END ----------------------------
end event

event pfc_deleterow;Return 1
end event

event pfc_addrow;Return 1
end event

event pfc_firstpage;RETURN 0
end event

event pfc_lastpage;RETURN 0
end event

event pfc_nextpage;RETURN 0
end event

event pfc_previouspage;RETURN 0
end event

event constructor;call super::constructor;This.of_SetUpdateable(False)
end event

type dw_properties from u_dw within pfc_cst_u_report_data_design
boolean visible = false
integer y = 308
integer width = 946
integer height = 1480
integer taborder = 10
string dataobject = "d_contract_field_properties"
end type

event constructor;This.of_SetUpdateable(False)
This.of_SetTransObject( SQLCA )
end event

type st_back from statictext within pfc_cst_u_report_data_design
boolean visible = false
integer x = 5
integer y = 260
integer width = 1253
integer height = 1700
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217750
boolean focusrectangle = false
end type

type st_right from statictext within pfc_cst_u_report_data_design
boolean visible = false
integer x = 3867
integer y = 420
integer width = 87
integer height = 1680
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 134217750
boolean focusrectangle = false
end type

