$PBExportHeader$w_contract_dw_properties.srw
forward
global type w_contract_dw_properties from w_popup
end type
type dw_properties_dw from u_dw within w_contract_dw_properties
end type
type cb_ok from u_cb within w_contract_dw_properties
end type
type cb_cancel from u_cb within w_contract_dw_properties
end type
end forward

global type w_contract_dw_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1138
integer height = 1440
string title = "DataWindow Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
dw_properties_dw dw_properties_dw
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_contract_dw_properties w_contract_dw_properties

type variables
String		is_ScreenStyle
end variables

forward prototypes
public function integer of_showcolor ()
public function integer of_parsecolor (ref long al_color)
end prototypes

public function integer of_showcolor ();long ll_Row

dw_properties_dw.AcceptText()
ll_Row = dw_properties_dw.GetRow()
if ll_Row <= 0 then Return -1

dw_properties_dw.object.t_background_color.background.color = dw_properties_dw.object.background_color[ll_Row]

Return 1
end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

on w_contract_dw_properties.create
int iCurrent
call super::create
this.dw_properties_dw=create dw_properties_dw
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties_dw
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_contract_dw_properties.destroy
call super::destroy
destroy(this.dw_properties_dw)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event closequery;//override
end event

event pfc_postopen;call super::pfc_postopen;of_ShowColor()

string			ls_gd, ls_ff

If dw_Properties_dw.getRow()>0 Then
	ls_gd = dw_Properties_dw.GetItemString( dw_Properties_dw.GetRow( ), 'grid_dataobject' )
	ls_ff = dw_Properties_dw.GetItemString( dw_Properties_dw.GetRow( ), 'dataobject' )	
	
	If   isnull(  ls_gd ) Or Trim(   ls_gd ) = '' or isnull( ls_ff) or trim( ls_ff) = ''  Then
		dw_Properties_dw.Modify("screen_style.RadioButtons.3D=No")
	Else
		dw_Properties_dw.Modify("screen_style.RadioButtons.3D=Yes") 
	End If
	is_ScreenStyle = dw_Properties_dw.GetItemString( dw_Properties_dw.GetRow( ), 'screen_style' )
End If
end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type dw_properties_dw from u_dw within w_contract_dw_properties
integer x = 14
integer y = 12
integer width = 1102
integer height = 1176
integer taborder = 10
string dataobject = "d_contract_dw_properties"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;long ll_Color

this.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_color"
		ll_Color = this.object.background_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.background_color[Row] = ll_Color
			this.SetColumn("background_color")
			this.Event ItemChanged(Row, this.object.background_color, String(ll_Color))
		end if		
	case "b_default"
		this.object.background_color[Row] = 67108864
		this.SetColumn("background_color")
		this.Event ItemChanged(Row, this.object.background_color, "67108864")
end choose
end event

event itemchanged;call super::itemchanged;if dwo.name = "background_color" then
	of_ShowColor()
end if

Long				ll_Handle, ll_FindRow

AcceptText( )

If dwo.name = 'screen_style' Then//added by gavins 20120307 grid
	If MessageBox( 'Screen', 'Are you sure you want to change the screen style?' ,question!, yesno!, 1 ) = 1 Then
		If w_contract_data_design.uo_design.of_CheckModified( )  = 1 Then 
			SetItem( row, 'screen_style', is_ScreenStyle )
			SetItemStatus( row, 'screen_style', Primary!, NotModified! )
			Return 2
		End If
		SetPointer( HourGlass! )
		ll_Handle = w_contract_data_design.uo_design.il_CurrentScreenHandle
		w_contract_data_design.uo_design.of_resetupdated( Data   )
		w_contract_data_design.uo_design.of_select_screen(0, w_contract_data_design.uo_design.ii_screen_id)
		w_contract_data_design.uo_design.Event ue_setModify( '' )
		is_ScreenStyle = Data
	Else
		SetItem( row, 'screen_style', is_ScreenStyle )
		SetItemStatus( row, 'screen_style', Primary!, NotModified! )
		Return 2
	End If
Else
	w_contract_data_design.uo_design.Post of_set_dw_properties(this.GetColumnName(), 1)
End If
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

type cb_ok from u_cb within w_contract_dw_properties
boolean visible = false
integer x = 407
integer y = 1228
integer width = 343
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;Close( Parent )

end event

type cb_cancel from u_cb within w_contract_dw_properties
integer x = 763
integer y = 1228
integer width = 343
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

