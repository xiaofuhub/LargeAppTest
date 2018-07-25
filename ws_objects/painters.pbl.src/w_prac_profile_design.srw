$PBExportHeader$w_prac_profile_design.srw
forward
global type w_prac_profile_design from w_main
end type
type uo_design from pfc_cst_u_data_entry_profile_painter within w_prac_profile_design
end type
end forward

global type w_prac_profile_design from w_main
integer x = 5
integer y = 336
integer width = 3680
integer height = 2008
string title = "Screen Setup (Default System View)"
long backcolor = 33551856
event pfc_cst_view_manager ( )
event pfc_cst_field_properties ( )
event pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
uo_design uo_design
end type
global w_prac_profile_design w_prac_profile_design

event pfc_cst_view_manager;Open( w_data_views_manager )
end event

event pfc_cst_field_properties;uo_design.TriggerEvent( "ue_field_properties" )
end event

event pfc_cst_select_view;uo_design.TriggerEvent( "pfc_cst_select_view" )
end event

event pfc_cst_new_screen_painter;uo_design.TriggerEvent( "pfc_cst_new_screen_painter" )
end event

on w_prac_profile_design.create
int iCurrent
call super::create
this.uo_design=create uo_design
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_design
end on

on w_prac_profile_design.destroy
call super::destroy
destroy(this.uo_design)
end on

event open;call super::open;uo_design.of_set_ib_screen_painter ( True )
uo_design.of_set_parent_window( This )
uo_design.of_Setup( False )
uo_design.of_Setup_painter()

This.x = 1
This.y = 296
This.Width = 3680
This.Height = 1800

uo_design.x = 1
uo_design.y = 1
uo_design.width = 3543
uo_design.height = 1712

w_mdi.of_menu_security( w_mdi.MenuName )

uo_design.TriggerEvent( "pfc_cst_select_view" )//maha 030802
end event

event pfc_save;uo_design.of_pre_pfc_save()

CALL pfc_w_master::pfc_save

COMMIT USING SQLCA;

DateTime ldt_dt

ldt_dt = DateTime( Today(), Now() )
UPDATE ids SET screen_cache = :ldt_dt, screen_obj_cache = :ldt_dt;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF
COMMIT USING SQLCA;


RETURN 1
end event

event activate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> UM-01
//$<add> 01.13.2006 By: Rodger Wu
//$<reason> The SetToolbarPos function is currently unsupported. 
//$<modification> Replace the SetToolBarPos function with the Appeon defined function of_settoolbarpos to provide
//$<modification> the same functionality.
/*
w_mdi.ChangeMenu(m_pfe_cst_prac_data_design)
*/


If w_mdi.menuname <> 'm_pfe_cst_prac_data_design' Then w_mdi.ChangeMenu( m_pfe_cst_prac_data_design )
//---------------------------- APPEON END ----------------------------
w_mdi.SetToolbarPos ( 2, 1, 200, False )

long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)

w_mdi.of_menu_security( w_mdi.MenuName )




end event

event close;call super::close;//maha 100201
messagebox("Screen Painter","Screen changes will not take effect in the Practitioner folder until it has been regenerated.  ~rIf open, close an reopen. ")

Close( w_design_menu )
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

w_mdi.of_menu_security( w_mdi.MenuName )



end event

type uo_design from pfc_cst_u_data_entry_profile_painter within w_prac_profile_design
integer taborder = 10
boolean bringtotop = true
boolean border = false
long backcolor = 80269524
end type

on uo_design.destroy
call pfc_cst_u_data_entry_profile_painter::destroy
end on

