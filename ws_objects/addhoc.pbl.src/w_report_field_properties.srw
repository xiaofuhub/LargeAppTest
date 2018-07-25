$PBExportHeader$w_report_field_properties.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_report_field_properties from w_popup
end type
type cb_datafill from u_cb within w_report_field_properties
end type
type dw_properties from u_dw within w_report_field_properties
end type
type cb_ok from u_cb within w_report_field_properties
end type
type cb_cancel from u_cb within w_report_field_properties
end type
type st_1 from statictext within w_report_field_properties
end type
type st_2 from statictext within w_report_field_properties
end type
end forward

global type w_report_field_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1239
integer height = 1128
string title = "Field Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
event ue_post_open pbm_custom01
cb_datafill cb_datafill
dw_properties dw_properties
cb_ok cb_ok
cb_cancel cb_cancel
st_1 st_1
st_2 st_2
end type
global w_report_field_properties w_report_field_properties

type variables

end variables

forward prototypes
public function integer of_setbuttonenabled (long al_row)
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
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

public function integer of_setbuttonenabled (long al_row);string ls_lookup_field
string ls_lookup_code

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

Return 1
end function

public function integer of_showcolor ();long ll_Row

dw_properties.AcceptText()
ll_Row = dw_properties.GetRow()
if ll_Row <= 0 then Return -1

dw_properties.object.t_fields_label_textcolor.background.color = dw_properties.object.fields_label_textcolor[ll_Row]
dw_properties.object.t_fields_label_textbkcolor.background.color = dw_properties.object.fields_label_textbkcolor[ll_Row]

Return 1
end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

on w_report_field_properties.create
int iCurrent
call super::create
this.cb_datafill=create cb_datafill
this.dw_properties=create dw_properties
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_datafill
this.Control[iCurrent+2]=this.dw_properties
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancel
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.st_2
end on

on w_report_field_properties.destroy
call super::destroy
destroy(this.cb_datafill)
destroy(this.dw_properties)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.st_1)
destroy(this.st_2)
end on

event open;call super::open;DatawindowChild dwchild

w_report_data_design.uo_design.dw_properties.ShareData(dw_properties)


IF dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_field" ) = "Y" THEN
	dw_properties.GetChild( "sys_fields_default_value", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( dw_properties.GetItemString( dw_properties.GetRow(), "sys_fields_lookup_code" ))
END IF

This.x = 2309
This.y = 112
IF gb_se_version THEN
	dw_properties.Height = 708
	cb_ok.y = 920
	cb_cancel.y = 920
	This.Height = 1150
END IF

//<add> 09/25/2007 by: Andy
//Reason: if edit.style <> 'edit' then data_view_fields_display_only.protect='1'
String ls_edit_style,ls_column_name
ls_column_name = dw_properties.getitemstring(dw_properties.GetRow(), "sys_fields_field_name")
ls_edit_style = Lower(w_report_data_design.uo_design.uo_band.dw_syntax.Describe(ls_column_name+".Edit.Style"))

if ls_edit_style <> 'edit' THEN 
	dw_properties.Modify("data_view_fields_display_only.protect='1' data_view_fields_display_only.Background.Mode='2' data_view_fields_display_only.Background.Color='" + string(rgb(192,192,192)) + "'")
end if
//end of add

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Control the button datafill if enabled

String	ls_LookupField

ls_LookupField = dw_properties.GetItemString(dw_properties.GetRow(), "sys_fields_lookup_field")

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

type cb_datafill from u_cb within w_report_field_properties
integer x = 498
integer y = 904
integer width = 343
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Data Fill..."
end type

event clicked;call super::clicked;OpenWithParm(w_contract_field_properties_datafill,'')
end event

type dw_properties from u_dw within w_report_field_properties
integer x = 14
integer y = 24
integer width = 1184
integer height = 844
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_report_field_properties"
boolean vscrollbar = false
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;String 	ls_lookup_field,ls_FieldName
long		ll_ViewId,ll_ScreenId,ll_Count
Integer	li_Rtn

//BEGIN---Add by Evan 07/24/2008
choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor"
		of_ShowColor()
end choose
//END---Add by Evan 07/24/2008

//--------------------------- APPEON BEGIN ---------------------------
//$<  Add > 2007-10-25 By: Scofield
//$<Reason> Clear the Data Fill if lookup field is not selected

if dwo.name = 'sys_fields_lookup_field' then
	if data = 'N' then
	//	cb_datafill.Enabled = true
	//else
		ll_ViewId = w_report_data_design.uo_design.il_data_view
		ll_ScreenId = w_report_data_design.uo_design.ii_screen_id
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
end if
//---------------------------- APPEON END ----------------------------

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
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.06.2007 By: Jack
//$<reason> Fix a defect.
this.accepttext()
//IF This.GetColumnName( ) = "data_view_fields_visible"  Then
//	If this.getitemstring(this.getrow(),'data_view_fields_visible') = 'N' Then
//		If this.getitemstring(this.getrow(),'data_view_fields_required') = 'Y' Then
//			messagebox('Prompt','System will automatically set the Required property to False when the Visible property is set to False. This will cause saving failure if the field is not allowed to be null in the database.')
//			this.setitem(this.getrow(),'data_view_fields_required','N')
////			w_report_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 1) //Modify by Evan 07.18.2008, add flag in argument lists
//			w_report_data_design.uo_design.POST of_set_dw_properties('data_view_fields_required', 2)	//modified by Nova.zhang on 2008-12-09
//		End If
//	End If
//End If
IF This.GetColumnName( ) = "data_view_fields_required"  Then
	If this.getitemstring(this.getrow(),'data_view_fields_required') = 'N' Then
		messagebox('Prompt','When the Required property is set to False, saving error may occur if the field is not allowed to be null in the database.')
	End If
End If

//---------------------------- APPEON END ----------------------------

w_report_data_design.uo_design.POST of_set_dw_properties(This.GetColumnName( ), 2) //Modify by Evan 07.18.2008, add flag in argument lists
Post of_SetButtonEnabled(1) //Add by Evan 01.30.2008

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
end choose
end event

type cb_ok from u_cb within w_report_field_properties
boolean visible = false
integer x = 503
integer y = 1824
integer width = 343
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Close( Parent )

end event

type cb_cancel from u_cb within w_report_field_properties
integer x = 859
integer y = 904
integer width = 343
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_report_field_properties
boolean visible = false
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
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 67108864
boolean enabled = false
string text = "Fields in BLUE are View specific. "
boolean focusrectangle = false
end type

type st_2 from statictext within w_report_field_properties
boolean visible = false
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
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "If Required is RED, it cannot be changed."
boolean focusrectangle = false
end type

