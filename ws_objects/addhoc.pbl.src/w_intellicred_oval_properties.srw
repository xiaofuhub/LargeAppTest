$PBExportHeader$w_intellicred_oval_properties.srw
forward
global type w_intellicred_oval_properties from w_popup
end type
type dw_properties_oval from u_dw within w_intellicred_oval_properties
end type
type cb_ok from u_cb within w_intellicred_oval_properties
end type
type cb_cancel from u_cb within w_intellicred_oval_properties
end type
end forward

global type w_intellicred_oval_properties from w_popup
integer x = 1783
integer y = 32
integer width = 1207
integer height = 1440
string title = "Oval Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
dw_properties_oval dw_properties_oval
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_intellicred_oval_properties w_intellicred_oval_properties

type variables
//---------Begin Modified by (Appeon)Toney 06.11.2013 for V141 ISG-CLX--------
//$Reason:str_set_properties object of ISG saved as str_set_properties_rpt
  /*
   str_set_properties istr_item   
  */
 str_set_properties_rpt istr_item 
//---------End Modfiied ------------------------------------------------------------------
u_cst_dw_design inv_data_design

end variables

forward prototypes
public function integer of_parsecolor (ref long al_color)
end prototypes

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

on w_intellicred_oval_properties.create
int iCurrent
call super::create
this.dw_properties_oval=create dw_properties_oval
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_properties_oval
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_intellicred_oval_properties.destroy
call super::destroy
destroy(this.dw_properties_oval)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event closequery;//override
end event

event open;call super::open;//modify by gavin on 2009/3/4

istr_item = message.powerobjectparm
inv_data_design = istr_item.lst_data_design



end event

event key;call super::key;if Key = KeyEscape! then Close(This)

end event

type dw_properties_oval from u_dw within w_intellicred_oval_properties
integer x = 14
integer y = 12
integer width = 1157
integer height = 1176
integer taborder = 10
string dataobject = "d_intellicred_oval_properties"
boolean vscrollbar = false
end type

event buttonclicked;call super::buttonclicked;String	ls_RtnVal,ls_ProExp,ls_ColName,ls_ButName

u_cst_dw_band ldw_band

this.AcceptText()

if Row <= 0 or dwo.Type <> "button" then Return

//Modified by gavin on 2009-03-04
ldw_band = inv_data_design.wf_getband(inv_data_design.is_CurBand)

ls_ButName = dwo.name
ls_ColName = MidA(ls_ButName,3)

ls_ProExp = dw_Properties_Oval.GetItemString(1,ls_ColName)
if IsNull(ls_ProExp) then ls_ProExp = ''
ldw_Band.Tag = ls_ProExp

//Popup compute column expression dialog
OpenWithParm(w_compute_wizard,ldw_Band)

ls_RtnVal = Message.StringParm
This.SetColumn(ls_ColName)

if ls_RtnVal <> ls_ProExp and ls_RtnVal <> "cancel!" then
	This.SetItem(Row,ls_ColName,ls_RtnVal)
	//Modified by gavin on 2009-03-04
	inv_data_design.Post of_set_dw_properties(ls_ColName, 4)
end if

end event

event itemchanged;call super::itemchanged;//Modified by gavin on 2009-03-04
inv_data_design.Post of_set_dw_properties(this.GetColumnName(), 4)
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

type cb_ok from u_cb within w_intellicred_oval_properties
boolean visible = false
integer x = 471
integer y = 1228
integer width = 343
integer taborder = 20
boolean bringtotop = true
string text = "&OK"
end type

event clicked;Close( Parent )

end event

type cb_cancel from u_cb within w_intellicred_oval_properties
integer x = 827
integer y = 1228
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&Close"
boolean default = true
end type

event clicked;Close(Parent)
end event

