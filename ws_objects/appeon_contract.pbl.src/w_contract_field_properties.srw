$PBExportHeader$w_contract_field_properties.srw
forward
global type w_contract_field_properties from w_popup
end type
type tab_properties from tab within w_contract_field_properties
end type
type tabpage_general from userobject within tab_properties
end type
type dw_1 from u_dw within tabpage_general
end type
type tabpage_general from userobject within tab_properties
dw_1 dw_1
end type
type tabpage_edit from userobject within tab_properties
end type
type dw_3 from u_dw within tabpage_edit
end type
type tabpage_edit from userobject within tab_properties
dw_3 dw_3
end type
type tabpage_font from userobject within tab_properties
end type
type dw_4 from u_dw within tabpage_font
end type
type tabpage_font from userobject within tab_properties
dw_4 dw_4
end type
type tabpage_label from userobject within tab_properties
end type
type dw_2 from u_dw within tabpage_label
end type
type tabpage_label from userobject within tab_properties
dw_2 dw_2
end type
type tab_properties from tab within w_contract_field_properties
tabpage_general tabpage_general
tabpage_edit tabpage_edit
tabpage_font tabpage_font
tabpage_label tabpage_label
end type
type cb_datafill from u_cb within w_contract_field_properties
end type
type dw_properties from u_dw within w_contract_field_properties
end type
type cb_cancel from u_cb within w_contract_field_properties
end type
type st_1 from statictext within w_contract_field_properties
end type
type st_2 from statictext within w_contract_field_properties
end type
type cb_ok from u_cb within w_contract_field_properties
end type
end forward

global type w_contract_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1888
integer height = 2036
string title = "Field Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_post_open pbm_custom01
event ue_bringtotop ( )
tab_properties tab_properties
cb_datafill cb_datafill
dw_properties dw_properties
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
cb_ok cb_ok
end type
global w_contract_field_properties w_contract_field_properties

type variables
//modify by gavin on 2009/3/5
pfc_cst_u_contract_data_design inv_data_design
uo_contract_design_menu  inv_menu
pfc_cst_u_band_painter inv_band
datawindow  idw_properties
pfc_cst_u_band   idw_band
end variables

forward prototypes
public function integer of_setbuttonenabled (long al_row)
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
public subroutine of_refresh_lookup_dddw ()
public subroutine of_set_dispalyname_dddw ()
public function integer wf_setvisibleexpress ()
public function integer of_showcolor (string as_object, string as_color)
end prototypes

event ue_post_open;//Integer i
//Integer li_col_cnt
//Integer li_sys_col_cnt
//Integer li_dv_col_cnt
//String ls_col_name
//String ls_sys_cols
//String ls_data_view_cols
//String ls_sys_fields_update[]
//String ls_dv_fields_update[]
//String  ls_sys_key_cols[ ] = {"sys_fields_table_id", "sys_fields_field_id"}
//String  ls_dv_key_cols[ ] = {"data_view_fields_data_view_id", "data_view_fields_screen_id"}
//
//
//dw_properties.of_SetMultiTable(TRUE)
//
//
//li_col_cnt = Integer( dw_properties.Object.DataWindow.Column.Count )
//
//FOR i = 1 TO li_col_cnt
//	
//	dw_properties.SetColumn( i )
//	ls_col_name = dw_properties.GetColumnName()
//	IF Upper(Mid(ls_col_name, 1, 10 )) = "SYS_FIELDS"  THEN
//		li_sys_col_cnt ++
//		ls_sys_fields_update[li_sys_col_cnt] = ls_col_name
//	ELSEIF Upper(Mid(ls_col_name, 1, 16 )) = "DATA_VIEW_FIELDS" THEN
//		li_dv_col_cnt ++
//		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
//	END IF
//	
//END FOR
//
//dw_properties.inv_multitable.of_Register( "sys_fields", ls_sys_key_cols , ls_sys_fields_update, TRUE, 0)
//dw_properties.inv_multitable.of_Register( "data_view_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)
//
//
//
//
//
//
end event

event ue_bringtotop();//


This.bringtotop = true
end event

public function integer of_setbuttonenabled (long al_row);string 	ls_lookup_field
string 	ls_lookup_code
String	ls_ColType

if al_Row <= 0 then Return -1

ls_lookup_field = Trim(dw_properties.GetItemString(al_Row, "sys_fields_lookup_field"))
ls_lookup_code = Trim(dw_properties.GetItemString(al_Row, "sys_fields_lookup_code"))
if IsNull(ls_lookup_field) then ls_lookup_field = ""
if IsNull(ls_lookup_code) then ls_lookup_code = ""

// cb_datafill
if ls_lookup_field = "Y" and Len(ls_lookup_code) > 0 then
	cb_datafill.Enabled = true	
else
	cb_datafill.Enabled = false	
end if

// cb_ok
/*
if ls_lookup_field = "Y" and Len(ls_lookup_code) = 0 then
	cb_ok.Enabled = false	
else
	cb_ok.Enabled = true	
end if
*/

ls_ColType = dw_properties.GetItemString(al_Row,"sys_fields_field_type")
if Upper(ls_ColType) = Upper("DateTime") or Upper(ls_ColType) = Upper("Date") then
	cb_datafill.Enabled = true	
end if

Return 1

end function

public function integer of_showcolor ();long ll_Row


dw_properties.AcceptText( )
tab_properties.tabpage_general.dw_1.AcceptText()
tab_properties.tabpage_label.dw_2.AcceptText( )
ll_Row = tab_properties.tabpage_general.dw_1.GetRow()
if ll_Row <= 0 then Return -1

tab_properties.tabpage_label.dw_2.object.t_fields_label_textcolor.background.color = tab_properties.tabpage_label.dw_2.object.fields_label_textcolor[ll_Row]
tab_properties.tabpage_label.dw_2.object.t_fields_label_textbkcolor.background.color = tab_properties.tabpage_label.dw_2.object.fields_label_textbkcolor[ll_Row]

//BEGIN---Modify by Scofield on 2009-08-27
tab_properties.tabpage_general.dw_1.object.t_fields_textcolor.background.color = tab_properties.tabpage_general.dw_1.object.fields_textcolor[ll_Row]
tab_properties.tabpage_general.dw_1.object.t_fields_textbkcolor.background.color =tab_properties.tabpage_general.dw_1.object.fields_textbkcolor[ll_Row]
//END---Modify by Scofield on 2009-08-27

//Modified by gavins 20120502
This.Title =   "Field Properties | " + dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_field_name" ) + " – " + dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_field_type" ) + " |"

Return 1

end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

public subroutine of_refresh_lookup_dddw ();//====================================================================
// Function: of_Refresh_Lookup_dddw()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
//--------------------------------------------------------------------
// Returns:  (None)
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-10-12
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 ContractLogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

DataWindowChild	ldwc_Child

//dw_Properties.GetChild("sys_fields_lookup_code",ldwc_Child) -- jervis 07.20.2011
tab_properties.tabpage_edit.dw_3.GetChild("sys_fields_lookup_code",ldwc_Child)

ldwc_Child.SetTransObject(SQLCA)
ldwc_Child.Retrieve()

end subroutine

public subroutine of_set_dispalyname_dddw ();datawindowchild dwchild
datastore lds_temp
long ll_i,ll_count,ll_row
string ls_name[]
string ls_objects
string ls_label
string ls_type
n_cst_string lvn_string

//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
//User tab_properties.tabpage_edit.dw_3 replace dw_properties - jervis 07.19.2011
tab_properties.tabpage_edit.dw_3.GetChild( "sys_fields_lookup_field_name", dwchild )
dwchild.Reset()
lds_temp = create datastore
lds_temp.dataobject = 'd_dddw_company_list'
ls_objects = lds_temp.Describe( "datawindow.objects")

lvn_string.of_parsetoarray( ls_objects, "~t", ls_name)
ll_count = UpperBound(ls_name)
for ll_i = 1 to ll_count
	ls_type = lds_temp.describe( ls_name[ll_i] +".type")
	if ls_type = 'column' or ls_type = 'compute' then
		ls_label = lds_temp.describe( ls_name[ll_i] +"_t.text")
		if ls_label = '?' or ls_label = '!' then ls_label = ls_name[ll_i]
		ll_row = dwchild.insertrow( 0)
		dwchild.SetItem( ll_row,'field_name', ls_name[ll_i])
		dwchild.SetItem( ll_row,'field_label', ls_label)
	end if
next
destroy lds_temp
end subroutine

public function integer wf_setvisibleexpress ();string			ls_Visible, ls_Color, ls_DefaultExpression, ls_DataObject
DataStore	lds_Default

/*******************************************************/
ls_Visible =  dw_properties.GetItemString(dw_properties.GetRow( ), "fields_visibleexpress")

tab_properties.tabpage_general.dw_1.Modify( "b_visible.enabled = true" )

If Not ( Upper(ls_Visible) = 'N' Or Upper( ls_Visible ) = 'Y' Or ls_Visible = '-1'  Or ls_Visible = '?' Or ls_Visible = '!'  or ls_Visible = '' or isnull( ls_visible ) ) Then
	tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.protect = 1" )
	tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.color = 8421504" )
	tab_properties.tabpage_general.dw_1.Modify( "b_visible.color = '16711935'" )
Else
	tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.protect = 0" )
	tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.color = 0" )
	tab_properties.tabpage_general.dw_1.Modify( "b_visible.color = '0'" )
End If

ls_Color = dw_properties.GetItemString(dw_properties.GetRow( ), "fields_backgroundcolorexpress")

If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
	tab_properties.tabpage_general.dw_1.Modify( "b_background_colorexpress.color = '16711935'" )	
Else
	tab_properties.tabpage_general.dw_1.Modify( "b_background_colorexpress.color = '0'" )	
End If
ls_Color = dw_properties.GetItemString(dw_properties.GetRow( ), "fields_fontcolorexpress")

If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
	tab_properties.tabpage_general.dw_1.Modify( "b_font_colorexpress.color = '16711935'" )	
Else
	tab_properties.tabpage_general.dw_1.Modify( "b_font_colorexpress.color = '0'" )	
End If

ls_Color = dw_properties.GetItemString(dw_properties.GetRow( ), "label_backgroundcolorexpress")

If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
	tab_properties.tabpage_label.dw_2.Modify( "b_background_colorexpress.color = '16711935'" )	
Else
	tab_properties.tabpage_label.dw_2.Modify( "b_background_colorexpress.color = '0'" )	
End If
ls_Color = dw_properties.GetItemString(dw_properties.GetRow( ), "label_fontcolorexpress")

If Not(trim( ls_color)= '' or isnull( ls_color ) ) Then
	tab_properties.tabpage_label.dw_2.Modify( "b_font_colorexpress.color = '16711935'" )	
Else
	tab_properties.tabpage_label.dw_2.Modify( "b_font_colorexpress.color = '0'" )	
End If

lds_Default = Create DataStore
ls_DataObject = inv_data_design.of_get_screendataobject( )
If Len( ls_DataObject ) > 0 Then
	lds_Default.dataObject = ls_DataObject
	ls_DefaultExpression = lds_Default.Describe(    dw_properties.GetItemString(dw_properties.GetRow( ), "sys_fields_field_name")    + ".visible")
	If  Pos( ls_DefaultExpression , '~t' ) > 0 Then
		tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.protect = 1" )
		tab_properties.tabpage_general.dw_1.Modify( "data_view_fields_visible.color = 8421504" )
		tab_properties.tabpage_general.dw_1.Modify( "b_visible.enabled = false" )
	End If
	//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
	//added by gavins 20130528
	ls_DefaultExpression = lds_Default.Describe(    dw_properties.GetItemString(dw_properties.GetRow( ), "sys_fields_field_name")    + ".protect")
	If  Pos( ls_DefaultExpression , '~t' ) > 0 Then
		tab_properties.tabpage_general.dw_1.Modify( "fields_protect.protect = 1" )
		tab_properties.tabpage_general.dw_1.Modify( "fields_protect.color = 8421504" )
	Else
		tab_properties.tabpage_general.dw_1.Modify( "fields_protect.protect = 0" )
		tab_properties.tabpage_general.dw_1.Modify( "fields_protect.color = 0" )
	End If
	//---------End Added ------------------------------------------------------
End If

/*******************************************************/

Return 1
end function

public function integer of_showcolor (string as_object, string as_color);

choose case as_object
	case 'fields_label_textcolor' 
			tab_properties.tabpage_label.dw_2.object.t_fields_label_textcolor.background.color =as_color
	case 'fields_label_textbkcolor'
			tab_properties.tabpage_label.dw_2.object.t_fields_label_textbkcolor.background.color =as_color
	case 'fields_textcolor'
		    tab_properties.tabpage_general.dw_1.object.t_fields_textcolor.background.color = as_color
	case 'fields_textbkcolor'
		tab_properties.tabpage_general.dw_1.object.t_fields_textbkcolor.background.color =as_color
end choose


Return 1

end function

on w_contract_field_properties.create
int iCurrent
call super::create
this.tab_properties=create tab_properties
this.cb_datafill=create cb_datafill
this.dw_properties=create dw_properties
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_properties
this.Control[iCurrent+2]=this.cb_datafill
this.Control[iCurrent+3]=this.dw_properties
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.cb_ok
end on

on w_contract_field_properties.destroy
call super::destroy
destroy(this.tab_properties)
destroy(this.cb_datafill)
destroy(this.dw_properties)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_ok)
end on

event open;call super::open;DatawindowChild dwchild
//start  Modified by gavin on 2009-03-05
str_set_properties lstr_item
string ls_coltype,ls_modify
string ls_style, ls_Visible

lstr_item = message.PowerObjectParm
inv_data_design = lstr_item.lst_data_design
inv_band = lstr_item.lst_band_painter
idw_properties = lstr_item.dw_item
idw_band = lstr_item.lst_band

//BEGIN---Modify by Scofield on 2009-05-15
if inv_data_design.is_open_style = 'report' then
	dw_properties.DataObject = "d_custom_report_field_properties"
	tab_properties.tabpage_general.dw_1.dataobject = 'd_report_field_properties_general'
	tab_properties.tabpage_label.dw_2.dataobject = 'd_report_field_properties_label'
	cb_datafill.Visible = false
	
	//dw_properties.Height = 1248
	//cb_cancel.Y   = dw_properties.Y + dw_properties.Height + 32
	//This.Height   = cb_cancel.Y + cb_cancel.Height + 130
	tab_properties.tabpage_edit.visible = false
else
	dw_properties.DataObject = "d_contract_field_properties"
	cb_datafill.Visible = true
end if

IF gb_se_version THEN
	dw_properties.Height = 708
	cb_ok.y = 920
	cb_cancel.y = 920
	This.Height = 1150
end if

gf_WinCenter(This)
//END---Modify by Scofield on 2009-05-15

//w_contract_data_design.uo_design.dw_properties.ShareData(dw_properties)
idw_properties.ShareData(dw_properties)
//end  Modified by gavin on 2009-03-05

//Share Data - jervis 07.19.2011
//if inv_data_design.is_open_style <> 'report' then
	idw_properties.ShareData(tab_properties.tabpage_general.dw_1 )
	idw_properties.ShareData(tab_properties.tabpage_label.dw_2 )
	idw_properties.ShareData(tab_properties.tabpage_edit.dw_3 )
	idw_properties.ShareData(tab_properties.tabpage_font.dw_4 ) //jervis 09.01.2011
//end if
/*******************************************************/
This.wf_setvisibleexpress( )
/*******************************************************/
//Retrieve dddw value -- jervis 12.7.2009
ls_style = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field" )
ls_coltype = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_field_type" )
ls_coltype = Left(ls_coltype,5)
if ls_coltype = "char(" or ls_coltype = "char" or ls_coltype = "decim" or ls_coltype = "numbe" or ls_coltype = "doubl" or ls_coltype = "real" or ls_coltype =  "long" or ls_coltype =  "int" or ls_coltype =  "ulong" then
	ls_modify = "sys_fields_lookup_field.values = 'Code Lookup	Y/Company	C/User	U/Edit	E/EditMask	M/CheckBox	B/'" //None	N/  modified by gavins20120608
	tab_properties.tabpage_edit.dw_3.Modify(ls_modify)
end if
		
choose case ls_style
	case 'Y'	//
		tab_properties.tabpage_edit.dw_3.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
		tab_properties.tabpage_edit.dw_3.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
		if tab_properties.tabpage_edit.dw_3.GetChild( "sys_fields_lookup_code", dwchild ) = 1 then
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
		end if
	case 'C'
		tab_properties.tabpage_edit.dw_3.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
		//change d_dddw_company to d_dddw_company_list - jervis 04.15.2011
		tab_properties.tabpage_edit.dw_3.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
		of_set_dispalyname_dddw()

	case 'U'
		//dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
		tab_properties.tabpage_edit.dw_3.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'") //jervis 04.15.2011
	case 'N','E'
	case 'M'  //EditMask - jervis 07.18.2011
	case 'B'  //check box-- jervis 07.18.2011

end choose
if tab_properties.tabpage_edit.dw_3.GetChild( "sys_fields_default_value", dwchild ) = 1 then
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_code" ))
end if


//<add> 09/25/2007 by: Andy
//Reason: if edit.style <> 'edit' then data_view_fields_display_only.protect='1'
String ls_edit_style,ls_column_name
ls_column_name = dw_properties.getitemstring(dw_properties.GetRow(), "sys_fields_field_name")

//Modified by gavin on 2009-03-05
//ls_edit_style = Lower(w_contract_data_design.uo_design.uo_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))
ls_edit_style = Lower(inv_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))

//Comment by jervis 07.20.2011  //modified by gavins 20120523
if ls_edit_style <> 'edit' THEN 
	tab_properties.tabpage_general.dw_1.Modify("data_view_fields_display_only.protect='1' data_view_fields_display_only.Background.Mode='2' data_view_fields_display_only.Color='" + string(rgb(128,128,128)) + "'")
end if


//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Control the button datafill if enabled

String	ls_LookupField

ls_LookupField = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field")

//modify by gavin on 2009/3/5
if inv_data_design.is_open_style = 'report' then
	dw_properties.object.disable_fields_lookup[dw_properties.GetRow()] = 1
end if

if ls_LookupField = 'Y' then
	cb_datafill.Enabled = true
else
	cb_datafill.Enabled = false
end if

//---------------------------- APPEON END ----------------------------

of_SetButtonEnabled(dw_properties.GetRow()) //Add by Evan 01.30.2008

/*
comment by jervis 07.19.2011
//Retrieve dddw value -- jervis 12.7.2009
ls_style = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field" )
choose case ls_style
	case 'Y'	//
		dw_properties.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
		if dw_properties.GetChild( "sys_fields_lookup_code", dwchild ) = 1 then
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
		end if
	case 'C'
		dw_properties.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
		//change d_dddw_company to d_dddw_company_list - jervis 04.15.2011
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
		of_set_dispalyname_dddw()

	case 'U'
		//dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'") //jervis 04.15.2011
	case 'N','E'
	case 'M'  //EditMask - jervis 07.18.2011
	case 'B'  //check box-- jervis 07.18.2011
		ls_coltype = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_field_type" )
		ls_coltype = Left(ls_coltype,5)
		if ls_coltype = "char(" or ls_coltype = "char" or ls_coltype = "decim" or ls_coltype = "numbe" or ls_coltype = "doubl" or ls_coltype = "real" or ls_coltype =  "long" or ls_coltype =  "int" or ls_coltype =  "ulong" then
			ls_modify = "sys_fields_lookup_field.values = 'Code Lookup	Y/Company	C/User	U/Edit	E/EditMask	M/CheckBox	B/'"
			dw_properties.Modify(ls_modify)
		end if
end choose
if dw_properties.GetChild( "sys_fields_default_value", dwchild ) = 1 then
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_code" ))
end if


//<add> 09/25/2007 by: Andy
//Reason: if edit.style <> 'edit' then data_view_fields_display_only.protect='1'
String ls_edit_style,ls_column_name
ls_column_name = dw_properties.getitemstring(dw_properties.GetRow(), "sys_fields_field_name")

//Modified by gavin on 2009-03-05
//ls_edit_style = Lower(w_contract_data_design.uo_design.uo_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))
ls_edit_style = Lower(inv_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))

if ls_edit_style <> 'edit' THEN 
	dw_properties.Modify("data_view_fields_display_only.protect='1' data_view_fields_display_only.Background.Mode='2' data_view_fields_display_only.Background.Color='" + string(rgb(192,192,192)) + "'")
end if
//end of add

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Control the button datafill if enabled

String	ls_LookupField

ls_LookupField = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field")

//modify by gavin on 2009/3/5
if inv_data_design.is_open_style = 'report' then
	dw_properties.object.disable_fields_lookup[dw_properties.GetRow()] = 1
end if

if ls_LookupField = 'Y' then
	cb_datafill.Enabled = true
else
	cb_datafill.Enabled = false
end if

//---------------------------- APPEON END ----------------------------

of_SetButtonEnabled(dw_properties.GetRow()) //Add by Evan 01.30.2008
*/
end event

event pfc_postopen;call super::pfc_postopen;of_ShowColor() //Add by Evan 07/24/2008
end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type tab_properties from tab within w_contract_field_properties
integer x = 23
integer y = 12
integer width = 1819
integer height = 1792
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
tabpage_edit tabpage_edit
tabpage_font tabpage_font
tabpage_label tabpage_label
end type

on tab_properties.create
this.tabpage_general=create tabpage_general
this.tabpage_edit=create tabpage_edit
this.tabpage_font=create tabpage_font
this.tabpage_label=create tabpage_label
this.Control[]={this.tabpage_general,&
this.tabpage_edit,&
this.tabpage_font,&
this.tabpage_label}
end on

on tab_properties.destroy
destroy(this.tabpage_general)
destroy(this.tabpage_edit)
destroy(this.tabpage_font)
destroy(this.tabpage_label)
end on

type tabpage_general from userobject within tab_properties
integer x = 18
integer y = 100
integer width = 1783
integer height = 1676
long backcolor = 33551856
string text = "  Field Display  "
long tabtextcolor = 33554432
long tabbackcolor = 1073741824
long picturemaskcolor = 553648127
dw_1 dw_1
end type

on tabpage_general.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_general.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within tabpage_general
integer x = 27
integer y = 28
integer width = 1742
integer height = 1688
integer taborder = 10
string dataobject = "d_contract_field_properties_general"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)


String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if
end event

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count,ll_RtnVal
Integer	li_Rtn
DataWindowChild dwchild

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//BEGIN---Modify by Scofield on 2010-02-02
if Lower(dwo.Name) = Lower("Fields_AutoHeight") then
	if Lower(Data) = Lower("Yes") then
		ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Turning On auto height will adjust the height of the field dynamically during runtime but can slow down the retrieval of data during runtime. Continue?",Question!,YesNo!,2)
		if ll_RtnVal <> 1 then
			This.Post SetItem(This.GetRow(),"Fields_AutoHeight",Lower("No"))
			Return
		end if
	end if
end if
//END---Modify by Scofield on 2010-02-02

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data <> 'Y' then //if data = 'N' then -- jervis 12.4.2009
		ll_ViewId = inv_data_design.il_data_view                      //Modified by gavin on 2009-03-05
		ll_ScreenId = inv_data_design.ii_screen_id   					  //Modified by gavin on 2009-03-05
		ls_FieldName = dw_properties.GetItemString(1,'sys_fields_field_name')
		
		Select Count(*)
		  into :ll_Count
		  from ctx_screen_datafill
		 where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
		
		if ll_Count > 0 then
			li_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'If this property is set to "No", all data you defined for the current field in the ~r~nData Fill Properties dialog will be removed. ~r~n~r~nDo you want to continue?',Question!,YesNo!,2)
			if li_Rtn = 2 then
				dw_properties.Post SetItem(1,'sys_fields_lookup_field','Y')
				Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008
				return
			else
				delete from ctx_screen_datafill  
						where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
			end if
		end if
		//cb_datafill.Enabled = false
	end if
	
	//Set dddw for default- jervis 12.5.2009
	choose case data
		case 'Y'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
			This.GetChild( "sys_fields_lookup_code", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
	
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
			this.Modify("sys_fields_lookup_field_name.dddw.name ='d_dddw_lookup_fld_nms_code'") //Reset the dddw of display name field - jervis 04.15.2011
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
			
			//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
			of_set_dispalyname_dddw()
			
			
			this.SetItem(row,'sys_fields_lookup_code','A')  //Default to our company
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'A')			
			this.SetItem(row,'sys_fields_lookup_field_name','facility_name')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'facility_name')
		case 'U'
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'")
			This.GetChild( "sys_fields_default_value", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
			
			this.SetItem(row,'sys_fields_lookup_field_name','user_id')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'User_id')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'N','E'
		case 'B' //Jervis 07.18.2011
			
	end choose

end if
//---------------------------- APPEON END ----------------------------

IF dwo.name = "sys_fields_lookup_field_name" OR dwo.name = "sys_fields_lookup_code" THEN

	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF dwo.name = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
/***************************************/ //added by gavins 20120308 grid
If dwo.Name = 'data_view_fields_visible' Then
	If Data = 'N'  and inv_data_design.il_dw_style = 1  Then
		If MessageBox( 'Prompt', 'Modification of the visible property: ~r~n1. “Invisible”, the column will be hidden and moved to the end of all columns. ~r~n2. When the property is changed from “invisible” to “visible”, the column will be displayed at the end of all visible columns. ~r~nAre you sure you want to modify it? ', &
						question!, yesno!, 1 )  = 1 Then
		Else
			SetItem( row, 'data_view_fields_visible', 'Y' )
			SetItemStatus( row, 'data_view_fields_visible', primary!, notmodified! )
			Return 2
		End If	
	End If
End If
/***************************************/
IF dwo.name = "data_view_fields_visible"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			this.setitem(this.getrow(),'data_view_fields_required','N')
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
			inv_data_design.POST of_set_dw_properties('data_view_fields_required', 2)	//Modified by gavin on 2009-03-05
		End If
	End If
End If
IF dwo.name = "data_view_fields_required"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_required') = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

//w_contract_data_design.uo_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
inv_data_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008

if dwo.Name = "data_view_fields_field_label" or dwo.Name = "sys_fields_lookup_code" or dwo.Name = "sys_fields_lookup_field_name" or dwo.Name = "sys_fields_field_mask" then
	inv_data_design.ib_HasNewModify = true
end if

end event

event buttonclicked;call super::buttonclicked;long ll_Color
window	lw_Temp
String			ls_visible, ls_Color, ls_Column, ls_Default
str_pass		lstr_pass

this.AcceptText()
if Row <=0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textcolor[Row] = ll_Color
			this.SetColumn("fields_label_textcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		this.object.fields_label_textcolor[Row] = 33554432
		this.SetColumn("fields_label_textcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textcolor, "33554432")
		
	case "b_text_bk_color"
		ll_Color = this.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_label_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, String(ll_Color))
		end if
	case "b_text_bk_color_def"
		this.object.fields_label_textbkcolor[Row] = 67108864
		this.SetColumn("fields_label_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, "67108864")

	//BEGIN---Modify by Scofield on 2009-08-27
	case "b_fields_textcolor"
		ll_Color = this.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textcolor[Row] = ll_Color
			this.SetColumn("fields_textcolor")
			this.Event ItemChanged(Row, this.object.fields_textcolor, String(ll_Color))
			This.Modify( "b_font_colorexpress.color = '0'" )	
			this.SetItem(row,'fields_fontcolorexpress',"")	
			this.Modify( "fields_textcolor.protect = 0" )
		end if
	case "b_fields_textcolor_def"
		this.object.fields_textcolor[Row] = 0
		this.SetColumn("fields_textcolor")
		this.Event ItemChanged(Row, this.object.fields_textcolor, "0")
		This.Modify( "b_font_colorexpress.color = '0'" )	
		this.SetItem(row,'fields_fontcolorexpress',"")
		this.Modify( "fields_textcolor.protect = 0" )
	case "b_fields_textbkcolor"
		ll_Color = this.object.fields_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_textbkcolor, String(ll_Color))
			This.Modify( "b_background_colorexpress.color = '0'" )	
			this.SetItem(row,'fields_backgroundcolorexpress',"")
			this.Modify( "fields_textbkcolor.protect = 0" )
		end if
	case "b_fields_textbkcolor_def"
		this.object.fields_textbkcolor[Row] = 16777215
		this.SetColumn("fields_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_textbkcolor, "16777215")
		This.Modify( "b_background_colorexpress.color = '0'" )	
		this.SetItem(row,'fields_backgroundcolorexpress',"")
		this.Modify( "fields_textbkcolor.protect = 0" )
	case "b_lookup"
		If isvalid(w_lookup_maint) Then
			w_lookup_maint.bringtotop = True
			w_lookup_maint.Event ue_change_lookupname(this.GetItemString(row,'sys_fields_lookup_code'))
		Else
			//---------Begin Modified by (Appeon)Stephen 03.15.2016 for Requested change in contract module drop-down States. case#62257 Bug_id#5043--------
			//OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code'), w_mdi, 4, original!) //Add parm -- jervis 11.26.2009
			OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code')+"$Contract$", w_mdi, 4, original!) 
			//---------End Modfiied ------------------------------------------------------
		End If
		This.SetColumn("sys_fields_lookup_code")
				
		lw_Temp = tab_properties.GetParent( )
		
		If IsValid( lw_Temp ) Then close( lw_Temp  )
	case "b_visible"
		ls_visible =  this.GetItemString(row,'fields_visibleexpress')
		If Pos( ls_visible, '~t' ) > 0 Then ls_visible = Mid( ls_visible, pos( ls_visible, '~t' ) + 1 ) 
		If right( ls_visible , 1 ) = '"' or right( ls_visible, 1 ) = "'" Then ls_visible = left( ls_visible, len( ls_visible ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_visible
		lstr_pass.as_search_type = "visible"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'sys_fields_field_name')
		lstr_pass.s_string_array[2] = "column"
		lstr_pass.s_u_dw   = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,"fields_visibleexpress",lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.fields_visibleexpress, lstr_pass.s_string)
				this.Modify( "data_view_fields_visible.protect = 1" )
				this.Modify( "data_view_fields_visible.color = 8421504" )
				This.Modify( "b_visible.color = '16711935'" )
			Else
				this.SetItem(row,"fields_visibleexpress",lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.data_view_fields_visible, GetItemString( row, 'data_view_fields_visible' ) )
				this.Modify( "data_view_fields_visible.protect = 0" )
				this.Modify( "data_view_fields_visible.color = 0" )
				This.Modify( "b_visible.color = '0'" )
			end if
		end if
		
	//END---Modify by Scofield on 2009-08-27
	case 'b_background_colorexpress' 
		
		ls_Column = 'fields_backgroundcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "background.color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'sys_fields_field_name')
		lstr_pass.s_string_array[2] = "column"
		ls_Default =  String( this.GetItemNumber( row, 'fields_textbkcolor' ) )
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.fields_backgroundcolorexpress, lstr_pass.s_string)
				this.Modify( "fields_textbkcolor.protect = 1" )
				This.Modify( "b_background_colorexpress.color = '16711935'" )	
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.fields_textbkcolor,  String( GetItemNumber( row, 'fields_textbkcolor' ) ) )
				this.Modify( "fields_textbkcolor.protect = 0" )
				This.Modify( "b_background_colorexpress.color = '0'" )	
			end if
		end if
	case 'b_font_colorexpress' 
		
		ls_Column = 'fields_fontcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'sys_fields_field_name')
		lstr_pass.s_string_array[2] = "column"
		ls_Default =  string( this.GetItemNumber( row, 'fields_textcolor' ) )
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.fields_fontcolorexpress, lstr_pass.s_string)
				this.Modify( "fields_textcolor.protect = 1" )
				This.Modify( "b_font_colorexpress.color = '16711935'" )	
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.fields_textcolor,  string(GetItemNumber( row, 'fields_textcolor' ) ) )
				this.Modify( "fields_textcolor.protect = 0" )
				This.Modify( "b_font_colorexpress.color = '0'" )	
			end if
		end if	
end choose


Event ue_BringToTop( )
end event

event editchanged;call super::editchanged;If row> 0 Then
	If IsNull( data ) Or Trim( data ) = ''  Or Not IsNumber( data )  Then Return
	choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_showcolor( string( dwo.name  ), data )
	end choose
End If
end event

event losefocus;call super::losefocus;AcceptText( )
end event

event itemerror;call super::itemerror;Return 3
end event

type tabpage_edit from userobject within tab_properties
integer x = 18
integer y = 100
integer width = 1783
integer height = 1676
long backcolor = 33551856
string text = "  Field Style  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_edit.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_edit.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_edit
integer x = 27
integer y = 28
integer width = 1742
integer height = 1640
integer taborder = 10
string dataobject = "d_contract_field_properties_edit"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)
end event

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count,ll_RtnVal
Integer	li_Rtn
DataWindowChild dwchild

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//BEGIN---Modify by Scofield on 2010-02-02
if Lower(dwo.Name) = Lower("Fields_AutoHeight") then
	if Lower(Data) = Lower("Yes") then
		ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Turning On auto height will adjust the height of the field dynamically during runtime but can slow down the retrieval of data during runtime. Continue?",Question!,YesNo!,2)
		if ll_RtnVal <> 1 then
			This.Post SetItem(This.GetRow(),"Fields_AutoHeight",Lower("No"))
			Return
		end if
	end if
end if
//END---Modify by Scofield on 2010-02-02

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data <> 'Y' then //if data = 'N' then -- jervis 12.4.2009
		ll_ViewId = inv_data_design.il_data_view                      //Modified by gavin on 2009-03-05
		ll_ScreenId = inv_data_design.ii_screen_id   					  //Modified by gavin on 2009-03-05
		ls_FieldName = dw_properties.GetItemString(1,'sys_fields_field_name')
		
		Select Count(*)
		  into :ll_Count
		  from ctx_screen_datafill
		 where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
		
		if ll_Count > 0 then
			li_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'If this property is set to "No", all data you defined for the current field in the ~r~nData Fill Properties dialog will be removed. ~r~n~r~nDo you want to continue?',Question!,YesNo!,2)
			if li_Rtn = 2 then
				dw_properties.Post SetItem(1,'sys_fields_lookup_field','Y')
				Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008
				return
			else
				delete from ctx_screen_datafill  
						where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
			end if
		end if
		//cb_datafill.Enabled = false
	end if
	
	//Set dddw for default- jervis 12.5.2009
	choose case data
		case 'Y'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
			This.GetChild( "sys_fields_lookup_code", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
	
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
			//---------Begin Modified by (Appeon)Harry 11.07.2013 for V141 ISG-CLX BugH102901--------
			if AppeonGetClientType() = 'WEB' then
				this.Modify("sys_fields_lookup_field_name.dddw.name =''")
			end if
			//---------End Modfiied ------------------------------------------------------
			this.Modify("sys_fields_lookup_field_name.dddw.name ='d_dddw_lookup_fld_nms_code'") //Reset the dddw of display name field - jervis 04.15.2011
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
			
			//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
			of_set_dispalyname_dddw()
						
			this.SetItem(row,'sys_fields_lookup_code','A')  //Default to our company
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'A')			
			this.SetItem(row,'sys_fields_lookup_field_name','facility_name')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'facility_name')
		case 'U'
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'")
			This.GetChild( "sys_fields_default_value", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
			
			this.SetItem(row,'sys_fields_lookup_field_name','user_id')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'User_id')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'N','E'
		case 'B' //Jervis 07.18.2011
			//---------Begin Added by (Appeon)Harry 03.12.2014 for V142 ISG-CLX--------
			this.setitem( row, "fields_3dlock", 'yes' )//added by gavins 20130514
			//---------End Added ------------------------------------------------------
	end choose
	
end if
//---------------------------- APPEON END ----------------------------

IF dwo.name = "sys_fields_lookup_field_name" OR dwo.name = "sys_fields_lookup_code" THEN

	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF dwo.name = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
IF dwo.name = "data_view_fields_visible"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			this.setitem(this.getrow(),'data_view_fields_required','N')
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
			inv_data_design.POST of_set_dw_properties('data_view_fields_required', 2)	//Modified by gavin on 2009-03-05
		End If
	End If
End If
IF dwo.name = "data_view_fields_required"  Then
	If data = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

//w_contract_data_design.uo_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
inv_data_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008

if dwo.Name = "data_view_fields_field_label" or dwo.Name = "sys_fields_lookup_code" or dwo.Name = "sys_fields_lookup_field_name" or dwo.Name = "sys_fields_field_mask" then
	inv_data_design.ib_HasNewModify = true
end if

end event

event itemfocuschanged;call super::itemfocuschanged;String ls_col_type
DataWindowChild dwchild	

IF This.GetColumnName() = "sys_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_fields_lookup_field_name" ) )

	//Begin - Modified By Ken.Guo 2010-10-14
	/*
		This.GetChild( "sys_fields_default_value" , dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )	
	*/
	ls_col_type = This.GetItemString(row,'sys_fields_field_type')
	If Left(ls_col_type,4) = 'date' or Left(ls_col_type,4) = 'time' Then
		This.Modify("sys_fields_default_value.DDDW.DataColumn = 'code'")
		If This.GetChild( "sys_fields_default_value" , dwchild ) = 1 Then
			dwchild.SetTransObject( SQLCA )
			dwchild.InsertRow(0)
			dwchild.SetItem(1,'code','Today')
			dwchild.SetItem(1,'lookup_code',-999)
		End If
	Else
		This.Modify("sys_fields_default_value.DDDW.DataColumn = 'lookup_code'")
		This.GetChild( "sys_fields_default_value" , dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )			
	End If
	//End - Modified By Ken.Guo 2010-10-14
	
END IF
end event

event buttonclicked;call super::buttonclicked;long ll_Color
window	lw_Temp


this.AcceptText()
if Row <=0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textcolor[Row] = ll_Color
			this.SetColumn("fields_label_textcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		this.object.fields_label_textcolor[Row] = 33554432
		this.SetColumn("fields_label_textcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textcolor, "33554432")
		
	case "b_text_bk_color"
		ll_Color = this.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_label_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, String(ll_Color))
		end if
	case "b_text_bk_color_def"
		this.object.fields_label_textbkcolor[Row] = 67108864
		this.SetColumn("fields_label_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, "67108864")
	
	//BEGIN---Modify by Scofield on 2009-08-27
	case "b_fields_textcolor"
		ll_Color = this.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textcolor[Row] = ll_Color
			this.SetColumn("fields_textcolor")
			this.Event ItemChanged(Row, this.object.fields_textcolor, String(ll_Color))
		end if
	case "b_fields_textcolor_def"
		this.object.fields_textcolor[Row] = 0
		this.SetColumn("fields_textcolor")
		this.Event ItemChanged(Row, this.object.fields_textcolor, "0")
		
	case "b_fields_textbkcolor"
		ll_Color = this.object.fields_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_textbkcolor, String(ll_Color))
		end if
	case "b_fields_textbkcolor_def"
		this.object.fields_textbkcolor[Row] = 16777215
		this.SetColumn("fields_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_textbkcolor, "16777215")
	case "b_lookup"
				
		If isvalid(w_lookup_maint) Then
			w_lookup_maint.bringtotop = True
			w_lookup_maint.Event ue_change_lookupname(this.GetItemString(row,'sys_fields_lookup_code'))
		Else
			//---------Begin Modified by (Appeon)Stephen 03.15.2016 for Requested change in contract module drop-down States. case#62257 Bug_id#5043--------
			//OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code'), w_mdi, 4, original!) //Add parm -- jervis 11.26.2009
			OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code')+"$Contract$", w_mdi, 4, original!)
			//---------End Modfiied ------------------------------------------------------
		End If
		This.SetColumn("sys_fields_lookup_code")
		
		lw_Temp = tab_properties.GetParent( )
		
		If IsValid( lw_Temp ) Then close( lw_Temp  )
		
	//END---Modify by Scofield on 2009-08-27
end choose

end event

event losefocus;call super::losefocus;AcceptText( )
end event

type tabpage_font from userobject within tab_properties
boolean visible = false
integer x = 18
integer y = 100
integer width = 1783
integer height = 1676
long backcolor = 33551856
string text = "Font"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_font.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_font.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw within tabpage_font
integer x = 27
integer y = 28
integer width = 1742
integer height = 1528
integer taborder = 10
string dataobject = "d_contract_field_properties_font"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if
end event

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count,ll_RtnVal
Integer	li_Rtn
DataWindowChild dwchild

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//BEGIN---Modify by Scofield on 2010-02-02
if Lower(dwo.Name) = Lower("Fields_AutoHeight") then
	if Lower(Data) = Lower("Yes") then
		ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Turning On auto height will adjust the height of the field dynamically during runtime but can slow down the retrieval of data during runtime. Continue?",Question!,YesNo!,2)
		if ll_RtnVal <> 1 then
			This.Post SetItem(This.GetRow(),"Fields_AutoHeight",Lower("No"))
			Return
		end if
	end if
end if
//END---Modify by Scofield on 2010-02-02

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data <> 'Y' then //if data = 'N' then -- jervis 12.4.2009
		ll_ViewId = inv_data_design.il_data_view                      //Modified by gavin on 2009-03-05
		ll_ScreenId = inv_data_design.ii_screen_id   					  //Modified by gavin on 2009-03-05
		ls_FieldName = dw_properties.GetItemString(1,'sys_fields_field_name')
		
		Select Count(*)
		  into :ll_Count
		  from ctx_screen_datafill
		 where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
		
		if ll_Count > 0 then
			li_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'If this property is set to "No", all data you defined for the current field in the ~r~nData Fill Properties dialog will be removed. ~r~n~r~nDo you want to continue?',Question!,YesNo!,2)
			if li_Rtn = 2 then
				dw_properties.Post SetItem(1,'sys_fields_lookup_field','Y')
				Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008
				return
			else
				delete from ctx_screen_datafill  
						where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
			end if
		end if
		//cb_datafill.Enabled = false
	end if
	
	//Set dddw for default- jervis 12.5.2009
	choose case data
		case 'Y'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
			This.GetChild( "sys_fields_lookup_code", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
	
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
			this.Modify("sys_fields_lookup_field_name.dddw.name ='d_dddw_lookup_fld_nms_code'") //Reset the dddw of display name field - jervis 04.15.2011
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
			
			//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
			of_set_dispalyname_dddw()
			
			
			this.SetItem(row,'sys_fields_lookup_code','A')  //Default to our company
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'A')			
			this.SetItem(row,'sys_fields_lookup_field_name','facility_name')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'facility_name')
		case 'U'
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'")
			This.GetChild( "sys_fields_default_value", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
			
			this.SetItem(row,'sys_fields_lookup_field_name','user_id')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'User_id')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'N','E'
		case 'B' //Jervis 07.18.2011
			
	end choose

end if
//---------------------------- APPEON END ----------------------------

IF dwo.name = "sys_fields_lookup_field_name" OR dwo.name = "sys_fields_lookup_code" THEN

	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF dwo.name = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
IF dwo.name = "data_view_fields_visible"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			this.setitem(this.getrow(),'data_view_fields_required','N')
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
			inv_data_design.POST of_set_dw_properties('data_view_fields_required', 2)	//Modified by gavin on 2009-03-05
		End If
	End If
End If
IF dwo.name = "data_view_fields_required"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_required') = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

//w_contract_data_design.uo_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
inv_data_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008

if dwo.Name = "data_view_fields_field_label" or dwo.Name = "sys_fields_lookup_code" or dwo.Name = "sys_fields_lookup_field_name" or dwo.Name = "sys_fields_field_mask" then
	inv_data_design.ib_HasNewModify = true
end if

end event

type tabpage_label from userobject within tab_properties
integer x = 18
integer y = 100
integer width = 1783
integer height = 1676
long backcolor = 33551856
string text = "  Label Display  "
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_label.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_label.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_label
integer x = 27
integer y = 28
integer width = 1742
integer height = 1644
integer taborder = 10
string dataobject = "d_contract_field_properties_label"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("label_font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if
end event

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName, ls_data
long		ll_ViewId,ll_ScreenId,ll_Count,ll_RtnVal
Integer	li_Rtn
DataWindowChild dwchild

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//BEGIN---Modify by Scofield on 2010-02-02
if Lower(dwo.Name) = Lower("Fields_AutoHeight") then
	if Lower(Data) = Lower("Yes") then
		ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Turning On auto height will adjust the height of the field dynamically during runtime but can slow down the retrieval of data during runtime. Continue?",Question!,YesNo!,2)
		if ll_RtnVal <> 1 then
			This.Post SetItem(This.GetRow(),"Fields_AutoHeight",Lower("No"))
			Return
		end if
	end if
end if
if dwo.name = 'data_view_fields_field_label' then//added by gavins 20120828
	If Len( data ) > 0 Then
			Long ll_Pos, ll_LeftBracketCnts, ll_RightBracketCnts
			
			ll_Pos = Pos(data,"(")
			do while ll_Pos > 0
				ll_LeftBracketCnts++
				ll_Pos = Pos(data,"(",ll_Pos + 1)
			loop
			
			ll_Pos = Pos(data,")")
			do while ll_Pos > 0
				ll_RightBracketCnts++
				ll_Pos = Pos(data,")",ll_Pos + 1)
			loop
			
			if ll_LeftBracketCnts < ll_RightBracketCnts then
				MessageBox(gnv_app.iapp_object.DisplayName, "Unpaired ‘)’ is not allowed and it will be replaced by ‘>’.",StopSign!)
				ll_pos= pos( data, ')' )
				ls_data = data
				do while ll_pos > 0 
					ls_data = replace( ls_data, ll_pos, 1, '>' )
					ll_pos = Pos( ls_data, ')', ll_pos +  1 )			
				loop
				SetText( ls_Data )
				SetItem( row, 'data_view_fields_field_label', ls_data )
				//Modified by gavin on 2009-03-05
				inv_data_design.ib_HasNewModify = true	
				inv_data_design.POST of_set_dw_properties(dwo.name, 2)
				Post of_SetButtonEnabled(1)
				Return 2
			end if				
			
		End If		
	
end if
//END---Modify by Scofield on 2010-02-02
if dwo.Name = "data_view_fields_field_label" or dwo.Name = "sys_fields_lookup_code" or dwo.Name = "sys_fields_lookup_field_name" or dwo.Name = "sys_fields_field_mask" then
	inv_data_design.ib_HasNewModify = true
end if

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data <> 'Y' then //if data = 'N' then -- jervis 12.4.2009
		ll_ViewId = inv_data_design.il_data_view                      //Modified by gavin on 2009-03-05
		ll_ScreenId = inv_data_design.ii_screen_id   					  //Modified by gavin on 2009-03-05
		ls_FieldName = dw_properties.GetItemString(1,'sys_fields_field_name')
		
		Select Count(*)
		  into :ll_Count
		  from ctx_screen_datafill
		 where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
		
		if ll_Count > 0 then
			li_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'If this property is set to "No", all data you defined for the current field in the ~r~nData Fill Properties dialog will be removed. ~r~n~r~nDo you want to continue?',Question!,YesNo!,2)
			if li_Rtn = 2 then
				dw_properties.Post SetItem(1,'sys_fields_lookup_field','Y')
				Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008
				return
			else
				delete from ctx_screen_datafill  
						where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
			end if
		end if
		//cb_datafill.Enabled = false
	end if
	
	//Set dddw for default- jervis 12.5.2009
	choose case data
		case 'Y'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
			This.GetChild( "sys_fields_lookup_code", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
	
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
			this.Modify("sys_fields_lookup_field_name.dddw.name ='d_dddw_lookup_fld_nms_code'") //Reset the dddw of display name field - jervis 04.15.2011
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
			
			//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
			of_set_dispalyname_dddw()
			
			
			this.SetItem(row,'sys_fields_lookup_code','A')  //Default to our company
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'A')			
			this.SetItem(row,'sys_fields_lookup_field_name','facility_name')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'facility_name')
		case 'U'
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'")
			This.GetChild( "sys_fields_default_value", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
			
			this.SetItem(row,'sys_fields_lookup_field_name','user_id')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'User_id')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'N','E'
		case 'B' //Jervis 07.18.2011
			
	end choose

end if
//---------------------------- APPEON END ----------------------------

IF dwo.name = "sys_fields_lookup_field_name" OR dwo.name = "sys_fields_lookup_code" THEN

	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF dwo.name = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
IF dwo.name = "data_view_fields_visible"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			this.setitem(this.getrow(),'data_view_fields_required','N')
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
			inv_data_design.POST of_set_dw_properties('data_view_fields_required', 2)	//Modified by gavin on 2009-03-05
		End If
	End If
End If
IF dwo.name = "data_view_fields_required"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_required') = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

//w_contract_data_design.uo_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
inv_data_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008


end event

event buttonclicked;call super::buttonclicked;long ll_Color
window lw_Temp
String			ls_Column,ls_Default, ls_color
str_Pass		lstr_Pass

this.AcceptText()
if Row <=0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textcolor[Row] = ll_Color
			this.SetColumn("fields_label_textcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textcolor, String(ll_Color))
			This.Modify( "b_font_colorexpress.color = '0'" )	
			this.SetItem(row,'label_fontcolorexpress',"")
			this.Modify( "fields_label_textcolor.protect = 0" )
		end if
	case "b_text_color_def"
		this.object.fields_label_textcolor[Row] = 33554432
		this.SetColumn("fields_label_textcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textcolor, "33554432")
		This.Modify( "b_font_colorexpress.color = '0'" )	
		this.SetItem(row,'label_fontcolorexpress',"")
		this.Modify( "fields_label_textcolor.protect = 0" )
	case "b_text_bk_color"
		ll_Color = this.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_label_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, String(ll_Color))
			This.Modify( "b_background_colorexpress.color = '0'" )	
			this.SetItem(row,'label_backgroundcolorexpress',"")	
			this.Modify( "fields_label_textbkcolor.protect = 0" )
		end if
	case "b_text_bk_color_def"
		this.object.fields_label_textbkcolor[Row] = 67108864
		this.SetColumn("fields_label_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, "67108864")
		This.Modify( "b_background_colorexpress.color = '0'" )	
		this.SetItem(row,'label_backgroundcolorexpress',"")
		this.Modify( "fields_label_textbkcolor.protect = 0" )
	
	//BEGIN---Modify by Scofield on 2009-08-27
	case "b_fields_textcolor"
		ll_Color = this.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textcolor[Row] = ll_Color
			this.SetColumn("fields_textcolor")
			this.Event ItemChanged(Row, this.object.fields_textcolor, String(ll_Color))
		end if
	case "b_fields_textcolor_def"
		this.object.fields_textcolor[Row] = 0
		this.SetColumn("fields_textcolor")
		this.Event ItemChanged(Row, this.object.fields_textcolor, "0")
		
	case "b_fields_textbkcolor"
		ll_Color = this.object.fields_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_textbkcolor, String(ll_Color))
		end if
	case "b_fields_textbkcolor_def"
		this.object.fields_textbkcolor[Row] = 16777215
		this.SetColumn("fields_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_textbkcolor, "16777215")
	case "b_lookup"
		If isvalid(w_lookup_maint) Then
			w_lookup_maint.bringtotop = True
			w_lookup_maint.Event ue_change_lookupname(this.GetItemString(row,'sys_fields_lookup_code'))
		Else
			//---------Begin Modified by (Appeon)Stephen 03.15.2016 for Requested change in contract module drop-down States. case#62257 Bug_id#5043--------
			//OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code'), w_mdi, 4, original!) //Add parm -- jervis 11.26.2009
			OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code')+"$Contract$", w_mdi, 4, original!)
			//---------End Modfiied ------------------------------------------------------
		End If
		This.SetColumn("sys_fields_lookup_code")
		
		lw_Temp = tab_properties.GetParent( )
		
		If IsValid( lw_Temp ) Then close( lw_Temp  )
	//END---Modify by Scofield on 2009-08-27
	case 'b_background_colorexpress' 
		
		ls_Column = 'label_backgroundcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "background.color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'sys_fields_field_name') + "_t"
		lstr_pass.s_string_array[2] = "column"
		ls_Default =  String( this.GetItemNumber( row, 'fields_label_textbkcolor' ) )
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.label_backgroundcolorexpress, lstr_pass.s_string)
				this.Modify( "fields_label_textbkcolor.protect = 1" )
				This.Modify( "b_background_colorexpress.color = '16711935'" )	
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.fields_label_textbkcolor,  String( GetItemNumber( row, 'fields_label_textbkcolor' ) ) )
				this.Modify( "fields_label_textbkcolor.protect = 0" )
				This.Modify( "b_background_colorexpress.color = '0'" )	
			end if
		end if
	case 'b_font_colorexpress' 
		
		ls_Column = 'label_fontcolorexpress'
		
		ls_color =  this.GetItemString(row,ls_Column )
		If Pos( ls_color, '~t' ) > 0 Then ls_color = Mid( ls_color, pos( ls_color, '~t' ) + 1 ) 
		If right( ls_color , 1 ) = '"' or right( ls_color, 1 ) = "'" Then ls_color = left( ls_color, len( ls_color ) - 1 )
		lstr_pass.s_long[1] = 5	
		lstr_pass.s_string          = ls_color
		lstr_pass.as_search_type = "color"
		lstr_pass.s_string_array[1] = this.GetItemString( row,'sys_fields_field_name') + "_t"
		lstr_pass.s_string_array[2] = "text"
		ls_Default =  String ( this.GetItemNumber( row, 'fields_label_textcolor' ) )
		If IsNull( ls_Default ) Or Trim( ls_Default ) = '' Then ls_Default = '0'
		lstr_pass.s_string_array[3] =ls_Default
		lstr_pass.s_u_dw            = idw_band
		OpenWithParm(w_export_expression,lstr_pass)
		lstr_pass = Message.PowerObjectParm
		if isvalid(lstr_pass) then
			if  trim(lstr_pass.s_string) <> "" then
				this.SetItem(row,ls_Column,lstr_pass.s_string)
				this.Event ItemChanged( Row, this.object.label_fontcolorexpress, lstr_pass.s_string)
				this.Modify( "fields_label_textcolor.protect = 1" )
				This.Modify( "b_font_colorexpress.color = '16711935'" )	
			Else
				this.SetItem(row,ls_Column,"")
				this.Event ItemChanged( Row, this.object.fields_label_textcolor, String(  GetItemNumber( row, 'fields_label_textcolor' ) ) )
				this.Modify( "fields_label_textcolor.protect = 0" )
				This.Modify( "b_font_colorexpress.color = '0'" )	
			end if
		end if		
end choose

Event ue_BringToTop( )
end event

event editchanged;call super::editchanged;

If IsNull( data ) Or Trim( data ) = ''  Or Not IsNumber( data )  Then Return
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_showcolor( string( dwo.name) , data )
end choose
end event

event itemerror;call super::itemerror;Return 3
end event

event losefocus;call super::losefocus;AcceptText( )
end event

type cb_datafill from u_cb within w_contract_field_properties
integer x = 1134
integer y = 1828
integer width = 343
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Data Fill..."
end type

event clicked;call super::clicked;String	ls_ColType

ls_ColType = dw_properties.GetItemString(1,"sys_fields_field_type")

if Upper(ls_ColType) = Upper("DateTime") or Upper(ls_ColType) = Upper("Date") then
	OpenWithParm(w_contract_field_properties_dt_fill,'')
else
	OpenWithParm(w_contract_field_properties_datafill,'')
end if

end event

type dw_properties from u_dw within w_contract_field_properties
boolean visible = false
integer x = 14
integer y = 128
integer width = 1184
integer height = 2052
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_contract_field_properties"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count,ll_RtnVal
Integer	li_Rtn
DataWindowChild dwchild

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor", "fields_textcolor", "fields_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//BEGIN---Modify by Scofield on 2010-02-02
if Lower(dwo.Name) = Lower("Fields_AutoHeight") then
	if Lower(Data) = Lower("Yes") then
		ll_RtnVal = MessageBox(gnv_app.iapp_object.DisplayName,"Turning On auto height will adjust the height of the field dynamically during runtime but can slow down the retrieval of data during runtime. Continue?",Question!,YesNo!,2)
		if ll_RtnVal <> 1 then
			This.Post SetItem(This.GetRow(),"Fields_AutoHeight",Lower("No"))
			Return
		end if
	end if
end if
//END---Modify by Scofield on 2010-02-02

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data <> 'Y' then //if data = 'N' then -- jervis 12.4.2009
		ll_ViewId = inv_data_design.il_data_view                      //Modified by gavin on 2009-03-05
		ll_ScreenId = inv_data_design.ii_screen_id   					  //Modified by gavin on 2009-03-05
		ls_FieldName = dw_properties.GetItemString(1,'sys_fields_field_name')
		
		Select Count(*)
		  into :ll_Count
		  from ctx_screen_datafill
		 where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
		
		if ll_Count > 0 then
			li_Rtn = MessageBox(gnv_app.iapp_object.DisplayName,'If this property is set to "No", all data you defined for the current field in the ~r~nData Fill Properties dialog will be removed. ~r~n~r~nDo you want to continue?',Question!,YesNo!,2)
			if li_Rtn = 2 then
				dw_properties.Post SetItem(1,'sys_fields_lookup_field','Y')
				Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008
				return
			else
				delete from ctx_screen_datafill  
						where data_view_id = :ll_ViewId and screen_id = :ll_ScreenId  and field_name = :ls_FieldName ;
			end if
		end if
		//cb_datafill.Enabled = false
	end if
	
	//Set dddw for default- jervis 12.5.2009
	choose case data
		case 'Y'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
			This.GetChild( "sys_fields_lookup_code", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
	
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
			this.Modify("sys_fields_lookup_field_name.dddw.name ='d_dddw_lookup_fld_nms_code'") //Reset the dddw of display name field - jervis 04.15.2011
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company_list' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
			
			//Reset the dddw data for sys_fields_lookup_field_name field -- jervis 04.15.2011
			of_set_dispalyname_dddw()
			
			
			this.SetItem(row,'sys_fields_lookup_code','A')  //Default to our company
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'A')			
			this.SetItem(row,'sys_fields_lookup_field_name','facility_name')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'facility_name')
		case 'U'
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_users' sys_fields_default_value.dddw.datacolumn ='user_id' sys_fields_default_value.dddw.displaycolumn = 'user_id'")
			This.GetChild( "sys_fields_default_value", dwchild )
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve( )
			
			this.SetItem(row,'sys_fields_lookup_field_name','user_id')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'User_id')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'N','E'
		case 'B' //Jervis 07.18.2011
			
	end choose

end if
//---------------------------- APPEON END ----------------------------

IF dwo.name = "sys_fields_lookup_field_name" OR dwo.name = "sys_fields_lookup_code" THEN

	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF dwo.name = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
IF dwo.name = "data_view_fields_visible"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
			this.setitem(this.getrow(),'data_view_fields_required','N')
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_contract_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
			inv_data_design.POST of_set_dw_properties('data_view_fields_required', 2)	//Modified by gavin on 2009-03-05
		End If
	End If
End If
IF dwo.name = "data_view_fields_required"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_required') = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

//w_contract_data_design.uo_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
inv_data_design.POST of_set_dw_properties(dwo.name, 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008

if dwo.Name = "data_view_fields_field_label" or dwo.Name = "sys_fields_lookup_code" or dwo.Name = "sys_fields_lookup_field_name" or dwo.Name = "sys_fields_field_mask" then
	inv_data_design.ib_HasNewModify = true
end if

end event

event constructor;call super::constructor;This.of_SetUpdateable(False)

end event

event itemfocuschanged;call super::itemfocuschanged;String ls_col_type
DataWindowChild dwchild	

IF This.GetColumnName() = "sys_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_fields_lookup_field_name" ) )

	//Begin - Modified By Ken.Guo 2010-10-14
	/*
		This.GetChild( "sys_fields_default_value" , dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )	
	*/
	ls_col_type = This.GetItemString(row,'sys_fields_field_type')
	If Left(ls_col_type,4) = 'date' or Left(ls_col_type,4) = 'time' Then
		This.Modify("sys_fields_default_value.DDDW.DataColumn = 'code'")
		This.GetChild( "sys_fields_default_value" , dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.InsertRow(0)
		dwchild.SetItem(1,'code','Today')
		dwchild.SetItem(1,'lookup_code',-999)
	Else
		This.Modify("sys_fields_default_value.DDDW.DataColumn = 'lookup_code'")
		This.GetChild( "sys_fields_default_value" , dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )			
	End If
	//End - Modified By Ken.Guo 2010-10-14
	
END IF
end event

event buttonclicked;call super::buttonclicked;long ll_Color

this.AcceptText()
if Row <=0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textcolor[Row] = ll_Color
			this.SetColumn("fields_label_textcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		this.object.fields_label_textcolor[Row] = 33554432
		this.SetColumn("fields_label_textcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textcolor, "33554432")
		
	case "b_text_bk_color"
		ll_Color = this.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_label_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, String(ll_Color))
		end if
	case "b_text_bk_color_def"
		this.object.fields_label_textbkcolor[Row] = 67108864
		this.SetColumn("fields_label_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, "67108864")
	
	//BEGIN---Modify by Scofield on 2009-08-27
	case "b_fields_textcolor"
		ll_Color = this.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textcolor[Row] = ll_Color
			this.SetColumn("fields_textcolor")
			this.Event ItemChanged(Row, this.object.fields_textcolor, String(ll_Color))
		end if
	case "b_fields_textcolor_def"
		this.object.fields_textcolor[Row] = 0
		this.SetColumn("fields_textcolor")
		this.Event ItemChanged(Row, this.object.fields_textcolor, "0")
		
	case "b_fields_textbkcolor"
		ll_Color = this.object.fields_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_textbkcolor, String(ll_Color))
		end if
	case "b_fields_textbkcolor_def"
		this.object.fields_textbkcolor[Row] = 16777215
		this.SetColumn("fields_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_textbkcolor, "16777215")
	case "b_lookup"
		If isvalid(w_lookup_maint) Then
			w_lookup_maint.bringtotop = True
			w_lookup_maint.Event ue_change_lookupname(this.GetItemString(row,'sys_fields_lookup_code'))
		Else
			//---------Begin Modified by (Appeon)Stephen 03.15.2016 for Requested change in contract module drop-down States. case#62257 Bug_id#5043--------
			//OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code'), w_mdi, 4, original!) //Add parm -- jervis 11.26.2009
			OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code')+"$Contract$", w_mdi, 4, original!) 
			//---------End Modfiied ------------------------------------------------------
		End If
		This.SetColumn("sys_fields_lookup_code")
		Parent.Hide()
	//END---Modify by Scofield on 2009-08-27
end choose

end event

type cb_cancel from u_cb within w_contract_field_properties
integer x = 1495
integer y = 1828
integer width = 343
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;//BEGIN---Modify by Scofield on 2009-09-29
String 	ls_FieldName,ls_Visible, ls_TCol
long		ll_Row

ll_Row = dw_Properties.GetRow()

dw_Properties.AcceptText()

ls_FieldName = dw_Properties.GetItemString(ll_Row,"sys_fields_field_name")

ls_Visible = dw_properties.GetItemString(ll_Row, "data_view_fields_visible")
if ls_Visible = "N" then
	dw_properties.SetItem(ll_Row, "data_view_fields_field_label",ls_FieldName)
	inv_data_design.Post of_set_dw_properties("data_view_fields_field_label", 2)
end if

if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and inv_data_design.ii_Screen_id >=3 and inv_data_design.ii_Screen_id <= 10   Then
	If	( inv_data_design.ii_Screen_id >=6 and inv_data_design.ii_Screen_id  <=7  and Pos( lower(ls_FieldName),'owner' ) > 0 )  then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName, 'owner' )		
	ElseIf Not( inv_data_design.ii_Screen_id >=6 and inv_data_design.ii_Screen_id  <=7 ) Then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName)
		inv_data_design.Post of_AutoUpdateDetailScreen(ls_FieldName)	//Jervis 10.21.2010
	End If
end if
//END---Modify by Scofield on 2009-09-29
//added by gavins 20120329
if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and ( inv_data_design.ii_Screen_id = 6 Or inv_data_design.ii_Screen_id = 7 ) then
	If inv_data_design.ii_Screen_id = 6 Then
		ls_TCol = 'ccci_' + ls_FieldName
	Else
		ls_TCol = 'occi_' + ls_FieldName
	ENd If
	If Pos(  'association,custom_n1, custom_1' , lower(ls_FieldName) ) > 0  Or  Pos(  'association_t,custom_n1_t, custom_1_t' , lower(ls_FieldName) ) > 0  Then
		inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName, ls_TCol )		
//		inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName, ls_TCol )	
	End If
End If
//added by gavins 20120607
if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and ( inv_data_design.ii_Screen_id =31 ) then
	ls_TCol = 'feesched_' + ls_FieldName
	inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName, ls_TCol )		
//	inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName, ls_TCol )	
	
End If
If inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and ( inv_data_design.ii_Screen_id =51 or inv_data_design.ii_Screen_id =52 Or inv_data_design.ii_Screen_id =56 ) then
	inv_data_design.Post of_AutoUpdateDocumentScreen(ls_FieldName )	
End If
Close(Parent)

end event

type st_1 from statictext within w_contract_field_properties
boolean visible = false
integer x = 46
integer y = 1816
integer width = 855
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Fields in BLUE are View specific. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_contract_field_properties
boolean visible = false
integer x = 46
integer y = 1876
integer width = 978
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "If Required is RED, it cannot be changed."
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_contract_field_properties
boolean visible = false
integer x = 498
integer y = 2232
integer width = 343
integer taborder = 30
string text = "&OK"
end type

event clicked;Close( Parent )

end event

