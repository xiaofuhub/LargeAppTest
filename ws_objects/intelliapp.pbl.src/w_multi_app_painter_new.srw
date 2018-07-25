$PBExportHeader$w_multi_app_painter_new.srw
$PBExportComments$used with intelliapp
forward
global type w_multi_app_painter_new from w_response
end type
type uo_1 from pfc_cst_u_multi_app_painter_new within w_multi_app_painter_new
end type
end forward

global type w_multi_app_painter_new from w_response
integer x = 439
integer y = 128
integer width = 2811
integer height = 2168
string title = "Multi App"
long backcolor = 32891346
uo_1 uo_1
end type
global w_multi_app_painter_new w_multi_app_painter_new

on w_multi_app_painter_new.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_multi_app_painter_new.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;uo_1.iw_win = This
end event

event closequery;//long.zhang 03.14.2014 rewrite
Integer li_msg

uo_1.dw_app_data.accepttext( )

if uo_1.dw_app_data.modifiedcount( ) + uo_1.dw_app_data.deletedcount( ) > 0 then
	
	li_msg = of_MessageBox ("pfc_master_closequery_savechanges", &
						gnv_app.iapp_object.DisplayName, &
						"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
						
	if li_msg = 1 then
		if uo_1.of_save() = -1 then return 1
	elseif li_msg = 2 then
		return 0
	else
		return 1
	end if
end if

return 0
end event

type uo_1 from pfc_cst_u_multi_app_painter_new within w_multi_app_painter_new
integer x = 14
integer y = 24
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_multi_app_painter_new::destroy
end on

