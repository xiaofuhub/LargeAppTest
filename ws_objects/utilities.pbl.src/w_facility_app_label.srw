$PBExportHeader$w_facility_app_label.srw
forward
global type w_facility_app_label from w_response
end type
type cb_close from commandbutton within w_facility_app_label
end type
type cb_save from commandbutton within w_facility_app_label
end type
type dw_1 from u_dw within w_facility_app_label
end type
end forward

global type w_facility_app_label from w_response
integer width = 1815
integer height = 556
string title = "IntelliApp Labels"
long backcolor = 33551856
cb_close cb_close
cb_save cb_save
dw_1 dw_1
end type
global w_facility_app_label w_facility_app_label

on w_facility_app_label.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.dw_1
end on

on w_facility_app_label.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_1)
end on

type cb_close from commandbutton within w_facility_app_label
integer x = 1408
integer y = 344
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_facility_app_label
integer x = 1038
integer y = 344
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//------------------- APPEON BEGIN -------------------
//$<modify> Evan 05.12.2009
//$<reason> Corrected BugA090104
/*
//$<add> 07.09.2008 by Andy
Parent.Event pfc_Save()
*/
integer li_Result

li_Result = Parent.Event pfc_Save()
if li_Result = 1 and dw_1.RowCount() > 0 then
	gs_app_stat_facility_label = dw_1.object.app_stat_facility_label[1]
	gs_app_stat_app_label = dw_1.object.app_stat_app_label[1]
end if
//------------------- APPEON END ---------------------
end event

type dw_1 from u_dw within w_facility_app_label
integer x = 41
integer y = 32
integer width = 1710
integer height = 288
integer taborder = 10
string dataobject = "d_facility_app_label"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;//$<add> 07.09.2008 by Andy
//of_SetReqColumn ( true )

this.retrieve( )
end event

event pfc_preupdate;call super::pfc_preupdate;
long ll_Row
String ls_label

ll_Row = this.GetRow( )
if ll_Row < 1 then return -1

ls_label = GetItemString(ll_Row,"app_stat_facility_label")
if isnull(ls_label) or trim(ls_label) = '' then 
	MessageBox(gnv_app.iapp_object.DisplayName,"Facility Label can't be NULL.")
	return -1
end if

ls_label = GetItemString(ll_Row,"app_stat_app_label")
if isnull(ls_label) or trim(ls_label) = '' then 
	MessageBox(gnv_app.iapp_object.DisplayName,"App Label can't be NULL.")
	return -1
end if

return 1
	
	

end event

