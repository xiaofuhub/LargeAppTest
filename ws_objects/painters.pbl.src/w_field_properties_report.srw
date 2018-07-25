$PBExportHeader$w_field_properties_report.srw
forward
global type w_field_properties_report from w_popup
end type
type cb_apply from u_cb within w_field_properties_report
end type
type cb_ok from u_cb within w_field_properties_report
end type
type cb_cancel from u_cb within w_field_properties_report
end type
type st_1 from statictext within w_field_properties_report
end type
type st_2 from statictext within w_field_properties_report
end type
type dw_properties from u_dw within w_field_properties_report
end type
type dw_fields_alias from u_dw within w_field_properties_report
end type
end forward

global type w_field_properties_report from w_popup
integer x = 1783
integer y = 32
integer width = 1029
integer height = 1412
string title = "Field Properties"
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_post_open pbm_custom01
cb_apply cb_apply
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
dw_properties dw_properties
dw_fields_alias dw_fields_alias
end type
global w_field_properties_report w_field_properties_report

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

event ue_post_open;//Integer i
//Integer li_col_cnt
//Integer li_sys_col_cnt
//Integer li_dv_col_cnt
//String ls_col_name
//String ls_sys_cols
//String ls_data_view_cols
//String ls_sys_report_fields_update[]
//String ls_dv_fields_update[]
//String  ls_sys_key_cols[ ] = {"sys_report_fields_table_id", "sys_report_fields_field_id"}
//String  ls_dv_key_cols[ ] = {"data_view_report_fields_data_view_id", "data_view_report_fields_screen_id"}
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
//	IF Upper(Mid(ls_col_name, 1, 10 )) = "sys_report_fields"  THEN
//		li_sys_col_cnt ++
//		ls_sys_report_fields_update[li_sys_col_cnt] = ls_col_name
//	ELSEIF Upper(Mid(ls_col_name, 1, 16 )) = "data_view_report_fields" THEN
//		li_dv_col_cnt ++
//		ls_dv_fields_update[li_dv_col_cnt] = ls_col_name
//	END IF
//	
//END FOR
//
//dw_properties.inv_multitable.of_Register( "sys_report_fields", ls_sys_key_cols , ls_sys_report_fields_update, TRUE, 0)
//dw_properties.inv_multitable.of_Register( "data_view_report_fields", ls_dv_key_cols , ls_dv_fields_update, TRUE, 0)
//
//
//
//
//
//
end event

public function integer of_apply_changes ();String ls_visible
Integer li_screen_id
Long    li_field_id
Integer li_retval

dw_properties.AcceptText( )

li_screen_id = dw_properties.GetItemNumber( 1, "data_view_report_fields_screen_id" )
li_field_id = dw_properties.GetItemNumber( 1, "sys_report_fields_field_id" )

//IF ( dw_properties.GetItemString( 1, "data_view_report_fields_required" ) = "N" OR dw_properties.GetItemString(1, "data_view_report_fields_visible") = "N" ) AND li_field_id <> 15 THEN
//	SELECT Count(*)  
//	INTO :li_retval  
//	FROM data_view_screen  
//	WHERE (data_view_screen.screen_id = :li_screen_id ) AND  
//   	   (data_view_screen.reference_field_1 = :li_field_id OR  
//      	 data_view_screen.reference_field_2 = :li_field_id )  ;
//	IF li_retval > 0 THEN
//		IF dw_properties.GetItemString( 1, "data_view_report_fields_required" ) = "N" THEN
//			MessageBox("Required", "This field must be a required field because it is a verification reference field." )
//		ELSE
//			MessageBox("Visible", "This field must be a visible field because it is a verification reference field." )			
//		END IF
//		Return -1
//	END IF
//END IF
//
IF dw_properties.GetItemString( 1, "sys_report_fields_lookup_field" ) = "Y" THEN
	dw_properties.SetColumn( "sys_report_fields_lookup_type"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Type field." )
		dw_properties.SetColumn( "sys_report_fields_lookup_type" )
		Return -1
	END IF
	dw_properties.SetColumn( "sys_report_fields_lookup_code"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Code field." )
		dw_properties.SetColumn( "sys_report_fields_lookup_code" )
		Return -1		
	END IF	
	dw_properties.SetColumn( "sys_report_fields_lookup_field_name"	 )
	IF LenA( dw_properties.GetText() ) = 0 THEN
		MessageBox("Required Field", "The field Lookup Field is set to YES, Please complete the Lookup Code field." )
		dw_properties.SetColumn( "sys_report_fields_lookup_field_name" )		
		Return -1		
	END IF		
END IF

//required
//IF dw_properties.GetItemString(1, "data_view_report_fields_required") = "Y" THEN
//	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.font.underline = '1'") 		
//ELSE
//	
//	TRY 
//	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.font.underline = '0'") 		
//   CATCH (RUNTIMEERROR RTE)
//		// MSKINNER 10 FEB 2005 -- BEGIN
//		// GET OUT IF THIS FAILS BECAUSE THE REST WILL FAILS AS WELL
//		RETURN 0
//		// MSKINNER 10 FEB 2005 -- END 
//	END TRY 
//
//END IF

//tab order
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".tabsequence = '" + String(dw_properties.GetItemNumber(1, "data_view_report_fields_field_order")) + "'") 

////label
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.text = '" + String(dw_properties.GetItemString(1, "data_view_report_fields_field_label")) + "'") 
//
////x position
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".x = '" + String(dw_properties.GetItemNumber(1, "data_view_report_fields_field_x")) + "'") 
//
////y position
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".y = '" + String(dw_properties.GetItemNumber(1, "data_view_report_fields_field_y")) + "'") 
//
////width
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".width = '" + String(dw_properties.GetItemNumber(1, "data_view_report_fields_field_width")) + "'") 
//
////alignment
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".alignment = '" + dw_properties.GetItemString(1, "data_view_report_fields_justification") + "'") 
//
//visible
IF dw_properties.GetItemString(1, "data_view_report_fields_visible") = "N" THEN
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".color = '8421504'") 
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".background.color = '12632256'") 
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.color = '8421504'") 
ELSE
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".color = '4194368'") 
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.color = '4194368'")
	w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + ".background.color = '16777215'") 		
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-30 By: Liu HongXin
//$<reason> Fix defect: IF Label Justification changed, Show it in Screen painter.
//w_prac_report_design.uo_design.idw_detail.Modify(w_prac_report_design.uo_design.is_last_object[1] + "_t.alignment = '" + String(dw_properties.GetItemNumber(1, "data_view_report_fields_label_justification")) + "'") 
//---------------------------- APPEON END ----------------------------
Return 0
end function

on w_field_properties_report.create
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

on w_field_properties_report.destroy
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

w_prac_report_design.uo_design.dw_properties.ShareData(dw_properties)
//$<add> 03.26.2008 by Andy
w_prac_report_design.uo_design.dw_fields_alias.ShareData(dw_fields_alias)
//end add 03.26.2008

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03.17.2006 By: Liang QingShi
//$<reason> Fix a defect.

//$<add> 01.03.2007 By: Andy
IF dw_properties.GetRow() < 1 THEN RETURN
//end of add
il_field_id = dw_properties.GetItemNumber(dw_properties.GetRow(),'sys_report_fields_field_id')
//---------------------------- APPEON END ----------------------------

dw_properties.GetChild("sys_report_fields_lookup_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

IF dw_properties.GetItemString( dw_properties.GetRow(), "sys_report_fields_lookup_field" ) = "Y" THEN
	dw_properties.GetChild( "sys_report_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_report_fields_lookup_code" ))
END IF


This.X = 2309

This.Y = 112

//IF gb_se_version THEN
//	dw_properties.Height = 708
//	cb_apply.Y = 920
//	cb_ok.Y = 920
//	cb_cancel.Y = 920
//	This.Height = 1150
//END IF
//

end event

event pfc_close;call super::pfc_close;//$<add> 03.26.2008 by Andy
dw_fields_alias.ShareDataOff()
end event

type cb_apply from u_cb within w_field_properties_report
integer x = 667
integer y = 1208
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

type cb_ok from u_cb within w_field_properties_report
integer x = 32
integer y = 1208
integer width = 306
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;//$<add> 01.03.2008 by: Andy
IF dw_properties.GetRow() < 1 THEN
	Close( Parent )
	RETURN
END IF
//end of add

dw_properties.AcceptText()
IF of_apply_changes() = -1 THEN
	dw_properties.SetFocus()
	RETURN
END IF

w_prac_report_design.uo_design.of_pre_pfc_save()
w_prac_report_design.Event pfc_save()
//Added by Nova on 12.22.2008
SetPointer(arrow!)
Close( Parent )

end event

type cb_cancel from u_cb within w_field_properties_report
integer x = 347
integer y = 1208
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_field_properties_report
integer x = 50
integer y = 28
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

type st_2 from statictext within w_field_properties_report
integer x = 18
integer y = 104
integer width = 974
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

type dw_properties from u_dw within w_field_properties_report
integer x = 23
integer y = 196
integer width = 978
integer height = 960
integer taborder = 10
string dataobject = "d_sys_report_field_properties"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;String ls_lookup_field

IF This.GetColumnName( ) = "sys_report_fields_lookup_field_name" OR This.GetColumnName( ) = "sys_report_fields_lookup_code" THEN
	DataWindowChild dwchild
	This.GetChild( "sys_report_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	IF This.GetColumnName( ) = "sys_report_fields_lookup_code" THEN
		dwchild.Retrieve( data )
	ELSE
		dwchild.Retrieve( This.GetItemString( row, "sys_report_fields_lookup_code" ))
	END IF
END IF

//IF This.GetColumnName( ) = "data_view_report_fields_visible" THEN  //removed maha 102104
//	IF data = "N" THEN
//		This.SetItem( row, "data_view_report_fields_required", "" )
//		This.SetItem( row, "sys_report_fields_lookup_field", "" )
//		This.SetItem( row, "sys_report_fields_lookup_type", "" )
//		This.SetItem( row, "sys_report_fields_lookup_code", "" )
//		This.SetItem( row, "sys_report_fields_lookup_field_name", "" )		
//	END IF	
//END IF

IF This.GetColumnName( ) = "sys_report_fields_lookup_field" THEN
	IF data = "N"  THEN
		This.SetItem( row, "sys_report_fields_lookup_type", "" )
		This.SetItem( row, "sys_report_fields_lookup_code", "" )
		This.SetItem( row, "sys_report_fields_lookup_field_name", "" )
	end if
END IF

IF This.GetColumnName( ) = "sys_report_fields_lookup_type" THEN //maha app081705
	IF data = "Q"  THEN
		This.SetItem( row, "sys_report_fields_lookup_code", "" )
		This.SetItem( row, "sys_report_fields_lookup_field_name", "" )
	end if
END IF

//$<add> 03.26.2008 by Andy
//$Reason:Auto set view fields alias if find out.
String ls_Val,ls_CName,ls_field
Long   ll_Cnt, ll_R=0
ls_CName = String(dwo.name)
ls_field = This.GetItemString(row,"sys_report_fields_field_name")

IF ls_CName = "data_view_report_fields_visible" OR ls_CName = "data_view_report_fields_field_label" THEN
	ls_Val = data
	IF ls_CName = "data_view_report_fields_visible" THEN
		IF ls_Val = 'N' THEN ls_Val = '0' ELSE ls_Val = '1'  
	END IF
	
	ll_Cnt = dw_fields_alias.RowCount( )
	DO WHILE (1=1)
		ll_R = dw_fields_alias.Find("c_name='" + ls_field + "'",ll_R,ll_Cnt)
		if ll_R < 1 then EXIT
		IF ls_CName = "data_view_report_fields_visible" THEN
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

event itemfocuschanged;call super::itemfocuschanged;IF This.GetColumnName() = "sys_report_fields_default_value" THEN
	String ls_field_name
	ls_field_name = Upper( This.GetItemString( row, "sys_report_fields_lookup_field_name" ) )
	IF This.GetItemString( row, "sys_report_fields_lookup_type" ) = "C" THEN
		This.Modify( "sys_report_fields_default_value.dddw.name = 'd_dddw_code_lookup'")
		//This.Modify( "sys_report_fields_default_value.dddw.datacolumn = 'description'")			
	ELSE	
		This.Modify( "sys_report_fields_default_value.dddw.name = 'd_dddw_address_lookup'")
		//This.Modify( "sys_report_fields_default_value.dddw.datacolumn = 'entity_name'")					
	END IF
	This.Modify( "sys_report_fields_default_value.dddw.datacolumn = '" + ls_field_name + "'")				
	This.Modify( "sys_report_fields_default_value.dddw.displaycolumn = '" + ls_field_name + "'")				
	This.Modify( "sys_report_fields_default_value.dddw.VscrollBar = Yes")			
	This.Modify( "sys_report_fields_default_value.dddw.AutoHScroll = Yes")			
	This.Modify( "sys_report_fields_default_value.dddw.Lines= 3")				
	This.Modify( "sys_report_fields_default_value.dddw.useasborder = Yes")			
	This.Modify( "sys_report_fields_default_value.dddw.NilIsNull= Yes")
	DataWindowChild dwchild	
	This.GetChild( "sys_report_fields_default_value" , dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( This.GetItemString( row, "sys_report_fields_lookup_code" ) )	
END IF

IF gb_se_version AND This.GetColumnName() = "data_view_report_fields_required" THEN
	This.SetColumn( "data_view_report_fields_visible" )
END IF
end event

type dw_fields_alias from u_dw within w_field_properties_report
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

