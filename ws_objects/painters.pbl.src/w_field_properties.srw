$PBExportHeader$w_field_properties.srw
forward
global type w_field_properties from w_popup
end type
type cb_apply from u_cb within w_field_properties
end type
type cb_ok from u_cb within w_field_properties
end type
type cb_cancel from u_cb within w_field_properties
end type
type st_1 from statictext within w_field_properties
end type
type st_2 from statictext within w_field_properties
end type
type dw_properties from u_dw within w_field_properties
end type
type dw_fields_alias from u_dw within w_field_properties
end type
end forward

global type w_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1440
integer height = 2212
string title = "Field Properties"
long backcolor = 33551856
event ue_post_open pbm_custom01
cb_apply cb_apply
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
dw_properties dw_properties
dw_fields_alias dw_fields_alias
end type
global w_field_properties w_field_properties

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 03.17.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Define variables to be used in subsequent script.
long il_field_id
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function integer of_apply_changes ()
end prototypes

event ue_post_open;
//Integer i
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

public function integer of_apply_changes ();String ls_visible
Integer li_screen_id
Integer li_field_id
Long    li_retval

dw_properties.AcceptText( )

li_screen_id = dw_properties.GetItemNumber( 1, "data_view_fields_screen_id" )
li_field_id = dw_properties.GetItemNumber( 1, "sys_fields_field_id" )

IF ( dw_properties.GetItemString( 1, "data_view_fields_required" ) = "N" OR dw_properties.GetItemString(1, "data_view_fields_visible") = "N" ) AND li_field_id <> 15 THEN
	SELECT Count(*)  
	INTO :li_retval  
	FROM data_view_screen  
	WHERE (data_view_screen.screen_id = :li_screen_id ) AND  
   	   (data_view_screen.reference_field_1 = :li_field_id OR  
      	 data_view_screen.reference_field_2 = :li_field_id )  ;
	IF li_retval > 0 THEN
		IF dw_properties.GetItemString( 1, "data_view_fields_required" ) = "N" THEN
			MessageBox("Required", "This field must be a required field because it is a verification reference field." )
		ELSE
			MessageBox("Visible", "This field must be a visible field because it is a verification reference field." )			
		END IF
		Return -1
	END IF
END IF

IF dw_properties.GetItemString( 1, "sys_fields_lookup_field" ) = "Y" THEN
	dw_properties.SetColumn( "sys_fields_lookup_type"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Type field." )
		dw_properties.SetColumn( "sys_fields_lookup_type" )
		Return -1
	END IF
	
	//-------------appeon begin----------------------
	//<$>added:long.zhang 10.11.2013
	//<$>reason:Bug #3694: New records on the Address screen are not being recorded in the audit trail
	dw_properties.SetColumn( "sys_fields_lookup_type"	 )
	IF Upper( dw_properties.GetText() ) = 'N' THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, the Lookup Type can not be set to None" )
		dw_properties.SetColumn( "sys_fields_lookup_type" )
		Return -1
	END IF
	//-------------appeon End------------------------
	
	dw_properties.SetColumn( "sys_fields_lookup_code"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Code field." )
		dw_properties.SetColumn( "sys_fields_lookup_code" )
		Return -1		
	END IF	
	dw_properties.SetColumn( "sys_fields_lookup_field_name"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Code field." )
		dw_properties.SetColumn( "sys_fields_lookup_field_name" )		
		Return -1		
	END IF		
END IF

if UpperBound(w_prac_data_design.uo_design.is_last_object) < 1 then //Evan 12.29.2010
	Return 0
end if

//required
IF dw_properties.GetItemString(1, "data_view_fields_required") = "Y" THEN
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.font.underline = '1'") 		
ELSE
	
	TRY 
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.font.underline = '0'") 		
   CATCH (RUNTIMEERROR RTE)
		// MSKINNER 10 FEB 2005 -- BEGIN
		// GET OUT IF THIS FAILS BECAUSE THE REST WILL FAILS AS WELL
		RETURN 0
		// MSKINNER 10 FEB 2005 -- END 
	END TRY 

END IF

 //Start Code Change ----11.03.2015 #V15 maha - Warning on non-date fields
if dw_properties.GetItemString(1, "sys_fields_field_mask") = "mm/dd/yyyy" and dw_properties.GetItemString(1, "sys_fields_field_type") <> "D" then
	messagebox("Warning"," You have set this field to a Date mask, but the field is a Character data type.~rWhile the calendar will work with this configuration, the mask (mm/dd/yyyy) will display rather than the date.~r~rIt is best to use Date type fields with a Date mask.")
end if
 //End Code Change ----11.03.2015

//tab order
//w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".tabsequence = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_order")) + "'") 

//------------------- APPEON BEGIN -------------------
//$<modify> stephen zhang 3.1.2011
//$<reason> Labels Disappear 
/*
//label
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.text = '" + String(dw_properties.GetItemString(1, "data_view_fields_field_label")) + "'") 
*/
//label
If w_prac_data_design.uo_design.dw_detail.describe(w_prac_data_design.uo_design.is_last_object[1] + ".type") = "text" then
    w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".text = '" + String(dw_properties.GetItemString(1, "data_view_fields_field_label")) + "'")
Else
    w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.text = '" + String(dw_properties.GetItemString(1, "data_view_fields_field_label")) + "'")
End if
//------------------- APPEON END ---------------------

//x position
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".x = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_x")) + "'") 

//------------------- APPEON BEGIN -------------------
//$<modify> stephen zhang 3.1.2011
//$<reason> Labels Disappear 
/*
//y position
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".y = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_y")) + "'") 
*/
//y position
If w_prac_data_design.uo_design.dw_detail.describe(w_prac_data_design.uo_design.is_last_object[1] + ".type") = "text" then
  	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".y = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_label_y")) + "'")
Else
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".y = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_y")) + "'")
end if
//------------------- APPEON END ---------------------

//width
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".width = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_field_width")) + "'") 

//alignment
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".alignment = '" + dw_properties.GetItemString(1, "data_view_fields_justification") + "'") 

//visible
IF dw_properties.GetItemString(1, "data_view_fields_visible") = "N" THEN
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".color = '8421504'") 
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".background.color = '12632256'") 
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.color = '8421504'") 
ELSE
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".color = '4194368'") 
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.color = '4194368'")
	w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + ".background.color = '16777215'") 		
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-30 By: Liu HongXin
//$<reason> Fix defect: IF Label Justification changed, Show it in Screen painter.
w_prac_data_design.uo_design.idw_detail.Modify(w_prac_data_design.uo_design.is_last_object[1] + "_t.alignment = '" + String(dw_properties.GetItemNumber(1, "data_view_fields_label_justification")) + "'") 
//---------------------------- APPEON END ----------------------------
Return 0
end function

on w_field_properties.create
int iCurrent
call super::create
this.cb_apply=create cb_apply
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
this.dw_properties=create dw_properties
this.dw_fields_alias=create dw_fields_alias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apply
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.dw_properties
this.Control[iCurrent+7]=this.dw_fields_alias
end on

on w_field_properties.destroy
call super::destroy
destroy(this.cb_apply)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.dw_properties)
destroy(this.dw_fields_alias)
end on

event open;call super::open;DatawindowChild dwchild

w_prac_data_design.uo_design.dw_properties.ShareData(dw_properties)
//$<add> 03.26.2008 by Andy
w_prac_data_design.uo_design.dw_fields_alias.ShareData(dw_fields_alias)
//end add 03.26.2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: Liang QingShi
//$<reason> Fix a defect.

//$<add> 01.03.2007 By: Andy
IF dw_properties.GetRow() < 1 THEN RETURN
//end of add
il_field_id = dw_properties.GetItemNumber(dw_properties.GetRow(),'sys_fields_field_id')
//---------------------------- APPEON END ----------------------------

dw_properties.GetChild("sys_fields_lookup_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

IF dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_field" ) = "Y" THEN
	dw_properties.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_code" ))
END IF


This.X = 2309

This.Y = 112

IF gb_se_version THEN
	dw_properties.Height = 708
	cb_apply.Y = 920
	cb_ok.Y = 920
	cb_cancel.Y = 920
	This.Height = 1150
END IF
//--------Begin Added by Nova 02.05.2009------------------------
IF dw_properties.RowCount( ) > 0 THEN
	IF dw_properties.Object.sys_fields_lookup_field[1] = "N"  THEN
		dw_properties.Modify( "sys_fields_default_value.dddw.AllowEdit=Yes")
	ELSEIF dw_properties.Object.sys_fields_lookup_field[1] = "Y"  THEN
		dw_properties.Modify( "sys_fields_default_value.dddw.AllowEdit=No")
	ELSE
		dw_properties.Modify( "sys_fields_default_value.dddw.AllowEdit=Yes")
	END IF
END IF
//--------End Added --------------------------------------------

end event

event pfc_close;call super::pfc_close;//$<add> 03.26.2008 by Andy
dw_fields_alias.ShareDataOff()
end event

type cb_apply from u_cb within w_field_properties
integer x = 846
integer y = 1984
integer width = 306
integer height = 84
integer taborder = 40
boolean bringtotop = true
string text = "&Apply"
end type

event clicked;//$<add> 01.03.2008 by: Andy
if dw_properties.getrow() < 1 then return
//end of add

of_apply_changes()

dw_properties.SetFocus()
end event

type cb_ok from u_cb within w_field_properties
integer x = 210
integer y = 1984
integer width = 306
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;//$<add> 01.03.2008 by: Andy
if dw_properties.getrow() < 1 then 
	close( Parent )
	return
end if
//end of add

dw_properties.AcceptText()
IF of_apply_changes() = -1 THEN
	dw_properties.SetFocus()
	Return
END IF

w_prac_data_design.uo_design.of_pre_pfc_save()
w_prac_data_design.Event pfc_save()

Close( Parent )
end event

type cb_cancel from u_cb within w_field_properties
integer x = 526
integer y = 1984
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_field_properties
integer x = 9
integer y = 24
integer width = 1413
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
string text = "Fields in BLUE are View specific, others will effect all Views. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_field_properties
integer x = 18
integer y = 116
integer width = 1358
integer height = 128
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
string text = "If Required is RED for a field (system required) , it cannot be made unrequired."
boolean focusrectangle = false
end type

type dw_properties from u_dw within w_field_properties
integer x = 23
integer y = 272
integer width = 1362
integer height = 1704
integer taborder = 10
string dataobject = "d_sys_field_properties"
boolean vscrollbar = false
boolean ib_rmbfocuschange = false
end type

event itemchanged;call super::itemchanged;String ls_lookup_field

IF This.GetColumnName( ) = "sys_fields_lookup_field_name" OR This.GetColumnName( ) = "sys_fields_lookup_code" THEN
	DataWindowChild dwchild
	This.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF This.GetColumnName( ) = "sys_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ))
	END IF
END IF

//IF This.GetColumnName( ) = "data_view_fields_visible" THEN  //removed maha 102104
//	IF data = "N" THEN
//		This.SetItem( row, "data_view_fields_required", "" )
//		This.SetItem( row, "sys_fields_lookup_field", "" )
//		This.SetItem( row, "sys_fields_lookup_type", "" )
//		This.SetItem( row, "sys_fields_lookup_code", "" )
//		This.SetItem( row, "sys_fields_lookup_field_name", "" )		
//	END IF	
//END IF

//IF This.GetColumnName( ) = "sys_fields_lookup_field" THEN//removed by nova 02.05.2009
//	IF data = "N"  THEN
//		This.SetItem( row, "sys_fields_lookup_type", "" )
//		This.SetItem( row, "sys_fields_lookup_code", "" )
//		This.SetItem( row, "sys_fields_lookup_field_name", "" )
//	end if
//END IF

//--------Begin Added by Nova 02.05.2009------------------------
IF This.GetColumnName( ) = "sys_fields_lookup_field" THEN
	IF Data = "N"  THEN
		This.Modify( "sys_fields_default_value.dddw.AllowEdit=Yes")
		This.SetItem( row, "sys_fields_lookup_type", "" )
		This.SetItem( row, "sys_fields_lookup_code", "" )
		This.SetItem( row, "sys_fields_lookup_field_name", "" )
	ELSEIF Data = "Y"  THEN
		This.Modify( "sys_fields_default_value.dddw.AllowEdit=No")
	ELSE
		This.Modify( "sys_fields_default_value.dddw.AllowEdit=yes")
	END IF
END IF
//--------End Added --------------------------------------------
IF This.GetColumnName( ) = "sys_fields_lookup_type" THEN //maha app081705
	IF data = "Q"  THEN
		This.SetItem( row, "sys_fields_lookup_code", "" )
		This.SetItem( row, "sys_fields_lookup_field_name", "" )
	end if
END IF

//Start Code Change ----11.06.2013 #V14 maha - added for date validation
IF This.GetColumnName( ) = "sys_fields_use_validation" then
	debugbreak()
	if this.getitemstring(1,"sys_fields_field_type") <> "D" and data = "9" then
		messagebox("Use Validation","You cannot use 'Valid Date' validation if the field type is not Date (D).")
		this.setitem(1,"sys_fields_use_validation",  this.getitemnumber( 1,'sys_fields_use_validation',primary!, true)  )
	end if
end if
//End Code Change ----11.06.2013

//$<add> 03.26.2008 by Andy
//$Reason:Auto set view fields alias if find out.
String ls_Val,ls_CName,ls_field
Long   ll_Cnt, ll_R=0
ls_CName = String(dwo.name)
ls_field = This.GetItemString(row,"sys_fields_field_name")

IF ls_CName = "data_view_fields_visible" OR ls_CName = "data_view_fields_field_label" THEN
	ls_Val = data
	IF ls_CName = "data_view_fields_visible" THEN
		IF ls_Val = 'N' THEN ls_Val = '0' ELSE ls_Val = '1'  
	END IF
	
	ll_Cnt = dw_fields_alias.RowCount( )
	DO WHILE (1=1)
		ll_R = dw_fields_alias.Find("c_name='" + ls_field + "'",ll_R,ll_Cnt)
		if ll_R < 1 then EXIT
		IF ls_CName = "data_view_fields_visible" THEN
			dw_fields_alias.SetItem(ll_R,"visible",Long(ls_Val))
		ELSE
			dw_fields_alias.SetItem(ll_R,"c_alias",LeftA(ls_Val,255))
		END IF
		ll_R ++
		if ll_R > ll_Cnt THEN EXIT
	LOOP
END IF
//End Add 03.26.2008

end event

event itemfocuschanged;call super::itemfocuschanged;IF This.GetColumnName() = "sys_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_fields_lookup_field_name" ) )
	IF This.GetItemString( row, "sys_fields_lookup_type" ) = "C" THEN
		This.Modify( "sys_fields_default_value.dddw.name = 'd_dddw_code_lookup'")
		//This.Modify( "sys_fields_default_value.dddw.datacolumn = 'description'")			
	ELSE	
		This.Modify( "sys_fields_default_value.dddw.name = 'd_dddw_address_lookup'")
		//This.Modify( "sys_fields_default_value.dddw.datacolumn = 'entity_name'")					
	END IF
	This.Modify( "sys_fields_default_value.dddw.datacolumn = '" + ls_field_name + "'")				
	This.Modify( "sys_fields_default_value.dddw.displaycolumn = '" + ls_field_name + "'")				
	This.Modify( "sys_fields_default_value.dddw.VscrollBar = Yes")			
	This.Modify( "sys_fields_default_value.dddw.AutoHScroll = Yes")			
	//This.Modify( "sys_fields_default_value.dddw.Lines= 3")		//comment by Nova 02.05.2009 				
	This.Modify( "sys_fields_default_value.dddw.useasborder = Yes")			
	This.Modify( "sys_fields_default_value.dddw.NilIsNull= Yes")
	DataWindowChild dwchild	
	This.GetChild( "sys_fields_default_value" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( This.GetItemString( row, "sys_fields_lookup_code" ) )	
	dwchild.insertrow(1)//added by long.zhang appeon 07.11.2013	bug3603
END IF

IF gb_se_version AND This.GetColumnName() = "data_view_fields_required" THEN
	This.SetColumn( "data_view_fields_visible" )
END IF
end event

event buttonclicked;call super::buttonclicked;string s //maha 04.14.2016

choose case dwo.name
	case "b_table"
		messagebox("About this field: table_name","This is the name of the database table in the IntelliSoft database.")
	case "b_field"
		messagebox("About this field: field_name","This is the name of the data field in the above table in the IntelliSoft database.")
	case "b_type"
		messagebox("About this field: field_type","This is the data type of the above field in the IntelliSoft database.")
	case "b_length"
		messagebox("About this field: field_len","This is the length of the above field in the IntelliSoft database.")
	case "b_visible"
		messagebox("About this field: visible","This setting determines if the field is visible on the data entry screen.")
	case "b_label"
		messagebox("About this field: table_name","This is the label text to be displayed for the data field.")
	case "b_ljust"
		messagebox("About this field: label_justification","This setting determines the justification of the field label: left right or center.")
	case "b_order"
		messagebox("About this field: field_order","This is the tab order of the field in the data screen.  These are implemented with increments of 10.")
	case "b_required"
		messagebox("About this field: required","This setting determines if the data field is required to save the data record.")
	case "b_lookup"
		messagebox("About this field: lookup_field","This setting determines if the field uses a lookup table.")
	case "b_lutype"
		messagebox("About this field: lookup_type","This sets the lookup table type: Address, Code, or Question.")
	case "b_lutable"
		messagebox("About this field: lookup_code","This is the name of the lookup table displayed in this field dropdown.")
	case "b_lufield"
		messagebox("About this field: lookup_field_name","This is the field from the lookup table that will be displayed on the Data Entry screen.") //maha 101409 - spelling
	case "b_ddwidth"
		messagebox("About this field: drop_down_width","This value sets the width of the Drop down compared to the size of the field.~r100% equals the width of the data field; 200% would be twice the width of the data field.")
	case "b_case"
		messagebox("About this field: field_case","This is intended to show the data in the case specified.")
	case "b_mask"
		messagebox("About this field: field_mask","This sets the appearance of the data in the data field:~rDate uses a mm/dd/yyyy format, and creates the calendar selector.~rInt Phone sets for the phone format window to pop up")
	case "b_audit"
		messagebox("About this field: audit_fld","This setting determines if changes to the data in the field are tracked in the Audit Trail.")
	case "b_default"
		messagebox("About this field: default_value","This field specifies the default value set on a new record.  Notes:~rDo not set defaults on all fields in data screen.  Unless a change is made to the record it will not be saved~r~rDefault values do not work with the Attestation Question Screen.")
	case "b_just"
		messagebox("About this field: justification","This sets the left/right/center justification of the data field.")
	case "b_sort"
		messagebox("About this field: sort_field;sort_order","These fields determine the record order that data is displayed on the screen. The first field to be sorted should be set to 1, the second to 2.  The sort order field sets ascending or descending order.")   //maha 101409 - syntax
	case "b_display"
		messagebox("About this field: display_only","Setting this field to Yes will make the field 'read only', preventing any modification to the data.  This is a view specific setting.")  //maha 101409 - spelling
	case "b_validate"
		s = "This field sets validation of entered data in the system:~r~r"
		s+= "- Unique (P) means unique in that field in the database.~r"  
		s+= "- Unique (W) will notify the user of a duplication, but will not prevent saving.~r"
		s+= "- Unique Prac (P) means the value must be unique for the practitoner only.~r"
		s+= "- Unique Prac (W) will notify the user of a duplication, but will not prevent saving.~r"
		s+= "- Special is for specific functionalities in the program.~rThese include:~rNPI number on Basic information that ensure the data entered is in the valid NPI format.~r"
		s+= "- SSN (P) On Basic information that ensure the data entered is in the valid SSN format.~r"
		s+= "- SSN (W) Warning if the data entered is  not in the valid SSN format).~r"
		s+= "- DATE RANGE (P): Requiring a start or end date on a screen like Hospital, Professional Experience, Education etc."
		s+= "- TIN (W) 9 digit number~r"
		s+= "- Date is Valid(P):  Value must be between the past 100 years and 50 in the future.~r"	
		s+= "- DEA (V): This checks for total length (9), acceptable first character, second character is a letter, 2-9 are numbers, valid checksum.  As this screen is used for both Federal and state numbers, it will only check validation if the State value is US. ~r"
		s+= "- DEA (U): This checks valid number format and checks for unique in the system.  As this screen is used for both Federal and state numbers, it will only check validation if the State value is US. ~r"
		s+= "- NPI (U): NPI number on Basic information screen must be in the valid NPI format and Unique in system.~r"
		s+= "- NPI (V): NPI number on Basic information screen must be in the valid NPI format.~r"
		s+= "- DOB (W): DOB is within the last 90 years and at least 18 years from check date.  Warning only.~r"
		s+= "- Special (Legacy) is for specific functionalities in the program. and Customizations~rThese include: NPI,  Date Is valid,~r"
		
		messagebox("About this field: use_validation",	  s )  //maha 101409 - spelling
	case "b_app_fill" //Start Code Change ----09.17.2012 #V12 maha - 
		messagebox("About this field:Default Map Length","This field track validation of entered data in the system:~r~rThis field is used in Application Mapping And Export for determining the default length of mapped fields.  Note that in some cases the program overwrites the default.")  //maha 101409 - spelling
	case else
		messagebox("Uncoded button", string(dwo.name))
end choose
end event

type dw_fields_alias from u_dw within w_field_properties
boolean visible = false
integer x = 73
integer y = 292
integer width = 763
integer height = 352
integer taborder = 20
string dataobject = "d_view_fields_alias_screen"
boolean vscrollbar = false
boolean livescroll = false
end type

