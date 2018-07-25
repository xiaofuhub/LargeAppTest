$PBExportHeader$w_intellicred_field_properties.srw
forward
global type w_intellicred_field_properties from w_popup
end type
type cb_datafill from u_cb within w_intellicred_field_properties
end type
type dw_properties from u_dw within w_intellicred_field_properties
end type
type cb_cancel from u_cb within w_intellicred_field_properties
end type
type st_1 from statictext within w_intellicred_field_properties
end type
type st_2 from statictext within w_intellicred_field_properties
end type
type cb_ok from u_cb within w_intellicred_field_properties
end type
end forward

global type w_intellicred_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1266
integer height = 2356
string title = "Field Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
event ue_post_open pbm_custom01
cb_datafill cb_datafill
dw_properties dw_properties
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
cb_ok cb_ok
end type
global w_intellicred_field_properties w_intellicred_field_properties

type variables
//modify by gavin on 2009/3/5
u_cst_dw_design inv_data_design
uo_contract_design_menu  inv_menu
u_cst_dw_band_painter inv_band
datawindow  idw_properties

end variables

forward prototypes
public function integer of_setbuttonenabled (long al_row)
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
public subroutine of_refresh_lookup_dddw ()
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

public function integer of_setbuttonenabled (long al_row);string 	ls_lookup_field
string 	ls_lookup_code
String	ls_ColType

if al_Row <= 0 then Return -1

ls_lookup_field = Trim(dw_properties.GetItemString(al_Row, "sys_fields_lookup_field"))
ls_lookup_code = Trim(dw_properties.GetItemString(al_Row, "sys_fields_lookup_code"))
if IsNull(ls_lookup_field) then ls_lookup_field = ""
if IsNull(ls_lookup_code) then ls_lookup_code = ""

// cb_datafill
if ls_lookup_field = "Y" and LenA(ls_lookup_code) > 0 then
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

dw_properties.AcceptText()
ll_Row = dw_properties.GetRow()
if ll_Row <= 0 then Return -1

dw_properties.object.t_fields_label_textcolor.background.color = dw_properties.object.fields_label_textcolor[ll_Row]
dw_properties.object.t_fields_label_textbkcolor.background.color = dw_properties.object.fields_label_textbkcolor[ll_Row]

//BEGIN---Modify by Scofield on 2009-08-27
dw_properties.object.t_fields_textcolor.background.color = dw_properties.object.fields_textcolor[ll_Row]
dw_properties.object.t_fields_textbkcolor.background.color = dw_properties.object.fields_textbkcolor[ll_Row]
//END---Modify by Scofield on 2009-08-27
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
// Author:	Evan		Date: 2010-09-10
//--------------------------------------------------------------------
//	Copyright (c) 1999-2010 IntelliSoft, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

DataWindowChild	ldwc_Child

dw_Properties.GetChild("sys_fields_lookup_code",ldwc_Child)

ldwc_Child.SetTransObject(SQLCA)
ldwc_Child.Retrieve()

end subroutine

on w_intellicred_field_properties.create
int iCurrent
call super::create
this.cb_datafill=create cb_datafill
this.dw_properties=create dw_properties
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_datafill
this.Control[iCurrent+2]=this.dw_properties
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.cb_ok
end on

on w_intellicred_field_properties.destroy
call super::destroy
destroy(this.cb_datafill)
destroy(this.dw_properties)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_ok)
end on

event open;call super::open;DatawindowChild dwchild
//start  Modified by gavin on 2009-03-05
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:str_set_properties object of ISG saved as str_set_properties_rpt
  /*
    str_set_properties lstr_item  
  */
 str_set_properties_rpt lstr_item 
//---------End Modfiied ------------------------------------------------------------------


lstr_item = message.PowerObjectParm
inv_data_design = lstr_item.lst_data_design
inv_band = lstr_item.lst_band_painter
idw_properties = lstr_item.dw_item

//BEGIN---Modify by Scofield on 2009-05-15
if inv_data_design.is_open_style = 'report' then
	dw_properties.DataObject = "d_custom_report_field_properties"
	cb_datafill.Visible = false
	
	dw_properties.Height = 1248
	cb_cancel.Y   = dw_properties.Y + dw_properties.Height + 32
	This.Height   = cb_cancel.Y + cb_cancel.Height + 130
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

//Retrieve dddw value -- jervis 12.7.2009
choose case dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field" )
	case 'Y'	//
		dw_properties.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_lookup_select_for_contract' sys_fields_lookup_code.dddw.datacolumn ='lookup_name' sys_fields_lookup_code.dddw.displaycolumn = 'lookup_name'")
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_code_lookup' sys_fields_default_value.dddw.datacolumn ='lookup_code' sys_fields_default_value.dddw.displaycolumn = 'code'")
		if dw_properties.GetChild( "sys_fields_lookup_code", dwchild ) = 1 then
			dwchild.SetTransObject( SQLCA )
			dwchild.Retrieve()
		end if
	case 'C'
		dw_properties.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
	case 'U'
		dw_properties.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")
	case 'N'
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

end event

event pfc_postopen;call super::pfc_postopen;of_ShowColor() //Add by Evan 07/24/2008
end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type cb_datafill from u_cb within w_intellicred_field_properties
integer x = 521
integer y = 2156
integer width = 343
integer taborder = 40
boolean bringtotop = true
string text = "&Data Fill..."
end type

event clicked;call super::clicked;//------------------- APPEON BEGIN -------------------
//$<delete> Evan 09.01.2010
//$<reason> V10.5-Advanced Report
/*
String	ls_ColType

ls_ColType = dw_properties.GetItemString(1,"sys_fields_field_type")

if Upper(ls_ColType) = Upper("DateTime") or Upper(ls_ColType) = Upper("Date") then
	OpenWithParm(w_contract_field_properties_dt_fill,'')
else
	OpenWithParm(w_contract_field_properties_datafill,'')
end if
*/
//------------------- APPEON END ---------------------
end event

type dw_properties from u_dw within w_intellicred_field_properties
integer x = 14
integer y = 152
integer width = 1234
integer height = 1972
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_intellicred_field_properties"
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
			this.SetItem(row,'sys_fields_lookup_field_name','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_field_name,'')
			this.SetItem(row,'sys_fields_lookup_code','')
			this.event ItemChanged(row,this.object.sys_fields_lookup_code,'')
		case 'C'
			this.Modify("sys_fields_lookup_code.dddw.name = 'd_dddw_company_type' sys_fields_lookup_code.dddw.datacolumn ='company_type' sys_fields_lookup_code.dddw.displaycolumn = 'company_desc'")
			this.Modify("sys_fields_default_value.dddw.name = 'd_dddw_company' sys_fields_default_value.dddw.datacolumn ='facility_id' sys_fields_default_value.dddw.displaycolumn = 'facility_name'")

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
		case 'N'
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

event itemfocuschanged;call super::itemfocuschanged;IF This.GetColumnName() = "sys_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_fields_lookup_field_name" ) )
	DataWindowChild dwchild	
	This.GetChild( "sys_fields_default_value" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )	
END IF
end event

event buttonclicked;call super::buttonclicked;long ll_Color
long gl_custom_colors[]

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
		OpenSheetwithparm(w_lookup_maint,this.GetItemString(row,'sys_fields_lookup_code'), w_mdi, 4, original!) //Add parm -- jervis 11.26.2009
		This.SetColumn("sys_fields_lookup_code")
		Parent.Hide()
	//END---Modify by Scofield on 2009-08-27
end choose
end event

type cb_cancel from u_cb within w_intellicred_field_properties
integer x = 882
integer y = 2156
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&Close"
boolean default = true
end type

event clicked;//BEGIN---Modify by Scofield on 2009-09-29
String 	ls_FieldName,ls_Visible
long		ll_Row

dw_Properties.AcceptText()

ll_Row = dw_Properties.GetRow()
ls_FieldName = dw_Properties.GetItemString(ll_Row,"sys_fields_field_name")

ls_Visible = dw_properties.GetItemString(ll_Row, "data_view_fields_visible")
if ls_Visible = "N" then
	dw_properties.SetItem(ll_Row, "data_view_fields_field_label",ls_FieldName)
	inv_data_design.Post of_set_dw_properties("data_view_fields_field_label", 2)
end if

if inv_data_design.is_open_style = "screen" and inv_data_design.ib_HasNewModify and inv_data_design.ii_Screen_id >= 3 and inv_data_design.ii_Screen_id <= 10 then
	inv_data_design.Post of_AutoUpdateSearchScreen(ls_FieldName)
end if
//END---Modify by Scofield on 2009-09-29

Close(Parent)

end event

type st_1 from statictext within w_intellicred_field_properties
integer x = 18
integer y = 16
integer width = 855
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
string text = "Fields in BLUE are View specific. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_intellicred_field_properties
integer x = 18
integer y = 76
integer width = 914
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 255
long backcolor = 33551856
boolean enabled = false
string text = "If Required is RED, it cannot be changed."
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_intellicred_field_properties
boolean visible = false
integer x = 503
integer y = 2156
integer width = 343
integer taborder = 30
string text = "&OK"
end type

event clicked;Close( Parent )

end event

