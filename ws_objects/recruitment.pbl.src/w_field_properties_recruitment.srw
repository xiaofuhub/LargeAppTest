$PBExportHeader$w_field_properties_recruitment.srw
forward
global type w_field_properties_recruitment from w_popup
end type
type cb_apply from u_cb within w_field_properties_recruitment
end type
type cb_ok from u_cb within w_field_properties_recruitment
end type
type cb_cancel from u_cb within w_field_properties_recruitment
end type
type dw_properties from u_dw within w_field_properties_recruitment
end type
type dw_fields_alias from u_dw within w_field_properties_recruitment
end type
end forward

global type w_field_properties_recruitment from w_popup
integer x = 1783
integer y = 32
integer width = 1321
integer height = 708
string title = "Field Properties"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_post_open pbm_custom01
cb_apply cb_apply
cb_ok cb_ok
cb_cancel cb_cancel
dw_properties dw_properties
dw_fields_alias dw_fields_alias
end type
global w_field_properties_recruitment w_field_properties_recruitment

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 03.17.2006 By: Liang QingShi
//$<reason> Performance tuning
//$<modification> Define variables to be used in subsequent script.
long il_field_id
//---------------------------- APPEON END ----------------------------

datawindow idw_win  //maha 09.09.2015
string is_from

end variables

forward prototypes
public function integer of_apply_changes ()
public function integer of_share_data ()
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

public function integer of_apply_changes ();dw_properties.accepttext()

//messagebox("is_from",is_from)
 //Start Code Change ----09.09.2015 #V15 maha
if is_from = "R" then
	w_recruit_screen_setup.of_apply()
elseif is_from = "P" then
	w_recruit_position_setup.of_apply()
end if
 //End Code Change ----09.09.2015

Return 0
end function

public function integer of_share_data (); //Start Code Change ----09.09.2015 #V15 maha
dw_properties.settransobject(sqlca)
idw_win.ShareData(dw_properties)

return 1
end function

on w_field_properties_recruitment.create
int iCurrent
call super::create
this.cb_apply=create cb_apply
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.dw_properties=create dw_properties
this.dw_fields_alias=create dw_fields_alias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_apply
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.dw_properties
this.Control[iCurrent+5]=this.dw_fields_alias
end on

on w_field_properties_recruitment.destroy
call super::destroy
destroy(this.cb_apply)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.dw_properties)
destroy(this.dw_fields_alias)
end on

event open;call super::open;DatawindowChild dwchild

is_from = message.stringparm
 //Start Code Change ----09.09.2015 #V15 maha - moved to of_share_data
//dw_properties.settransobject(sqlca)
//w_recruit_screen_setup.dw_prop.ShareData(dw_properties)
 //End Code Change ----09.09.2015 

////$<add> 01.03.2007 By: Andy
//IF dw_properties.GetRow() < 1 THEN RETURN
////end of add
//il_field_id = dw_properties.GetItemNumber(dw_properties.GetRow(),'sys_report_fields_field_id')
////---------------------------- APPEON END ----------------------------
//
//dw_properties.GetChild("sys_report_fields_lookup_code", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve()
//
//IF dw_properties.GetItemString( dw_properties.GetRow(), "sys_report_fields_lookup_field" ) = "Y" THEN
//	dw_properties.GetChild( "sys_report_fields_default_value", dwchild )
//	dwchild.SetTransObject( SQLCA )
//	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_report_fields_lookup_code" ))
//END IF




end event

event pfc_close;call super::pfc_close;//$<add> 03.26.2008 by Andy
dw_fields_alias.ShareDataOff()
end event

type cb_apply from u_cb within w_field_properties_recruitment
integer x = 786
integer y = 508
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

type cb_ok from u_cb within w_field_properties_recruitment
integer x = 151
integer y = 508
integer width = 306
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;
of_apply_changes()

Close( Parent )

end event

type cb_cancel from u_cb within w_field_properties_recruitment
integer x = 466
integer y = 508
integer width = 306
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_properties from u_dw within w_field_properties_recruitment
integer x = 73
integer y = 36
integer width = 1175
integer height = 444
integer taborder = 10
string dataobject = "d_sys_field_prop_recruiting"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

type dw_fields_alias from u_dw within w_field_properties_recruitment
boolean visible = false
integer x = 73
integer y = 720
integer width = 763
integer height = 352
integer taborder = 20
string dataobject = "d_view_fields_alias_screen"
boolean vscrollbar = false
boolean livescroll = false
end type

