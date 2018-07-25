$PBExportHeader$w_prac_data_design.srw
forward
global type w_prac_data_design from w_main
end type
type uo_design from pfc_cst_u_data_entry_screen_painter within w_prac_data_design
end type
end forward

global type w_prac_data_design from w_main
integer x = 5
integer y = 336
integer width = 3634
integer height = 2300
string title = "Screen Design (Default System View)"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
event pfc_cst_view_manager ( )
event pfc_cst_field_properties ( )
event pfc_cst_select_view ( )
event pfc_cst_new_screen_painter ( )
event pfc_cst_display_only ( )
event pfc_cst_save_as_profile_screen ( )
event pfc_cst_toggle_profile_screen ( )
event pfc_cst_web_format ( )
uo_design uo_design
end type
global w_prac_data_design w_prac_data_design

type variables
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> Define a variable to be used in subsequent script.
boolean ib_just_opened = true
boolean ib_disable_activate = false
//---------------------------- APPEON END ----------------------------

//boolean ib_profile = false //maha 11.29.2007
end variables

event pfc_cst_view_manager;Open( w_data_views_manager )
end event

event pfc_cst_field_properties;uo_design.TriggerEvent( "ue_field_properties" )
end event

event pfc_cst_select_view;uo_design.TriggerEvent( "pfc_cst_select_view" )
end event

event pfc_cst_new_screen_painter;uo_design.TriggerEvent( "pfc_cst_new_screen_painter" )
end event

event pfc_cst_display_only;uo_design.of_set_display_only()
end event

event pfc_cst_save_as_profile_screen();uo_design.of_update_profile_views( )
end event

event pfc_cst_toggle_profile_screen();//Start Code Change ----11.29.2007 #V8 maha
//calls new function to goggle between the profile view and the screen view
uo_design.of_toggle_profile( )
//if ib_profile = false then //profile view
//	uo_design.of_mod_dw_for_profile()
//	ib_profile = true
//else //screen view
//	uo_design.dw_select_section.triggerevent( rowfocuschanged!)
//	ib_profile = false
//end if

end event

event pfc_cst_web_format();open(w_screen_auto_format)

choose case message.stringparm
	case "C"
		//cancel
	case "S"
		uo_design.of_standard_format( )
	case "L"
		uo_design.of_webview_format( )
end choose
end event

on w_prac_data_design.create
int iCurrent
call super::create
this.uo_design=create uo_design
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_design
end on

on w_prac_data_design.destroy
call super::destroy
destroy(this.uo_design)
end on

event open;call super::open;IF gb_se_version THEN
	uo_design.il_data_view_id = 2
	This.Title = "Screen Painter (SE View)"
END IF

uo_design.of_set_ib_screen_painter ( True )
uo_design.of_set_parent_window( This )
uo_design.of_Setup( False )
uo_design.of_Setup_painter()

This.x = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
This.y = 296
This.Width = 3680
This.Height = 1800
*/
This.y = 1
This.Width = 3625
This.Height = 2300 //2150

//---------------------------- APPEON END ----------------------------

uo_design.x = 1
uo_design.y = 1
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
uo_design.width = 3543
uo_design.height = 1712
*/
uo_design.width = 3607
uo_design.height = 2164  //1980

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<comment> 04.13.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Comment out the following script since it is already executed
//$<modification> in the Activate event of w_prac_data_design.
/* w_mdi.of_menu_security( w_mdi.MenuName ) */
//---------------------------- APPEON END ----------------------------

//BEGIN---Delete by Evan 01/12/2009
//Remark: Move following code to pfc_postopen event
/*
IF NOT gb_se_version THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.10.2008 By: Evan
	//$<reason> Close window if cancel select view.
	//uo_design.TriggerEvent( "pfc_cst_select_view" )//maha 030802
	integer li_Return
	li_Return = uo_design.Event pfc_cst_select_view()
	if li_Return = -1 then
		Close(this)
		Return
	end if
	//---------------------------- APPEON END ----------------------------
END IF
*/
//END---Delete by Evan 01/12/2009

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning.
//$<modification> After w_prac_data_design is opened, set ib_just_opened to FALSE.

ib_just_opened = False
//---------------------------- APPEON END ----------------------------

end event

event pfc_save;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<add> 03.14.2006 By: Cao YongWang
//$<reason> Performance tuning. 
//$<modification> Make a condition to ensure that when w_prac_data_design is just opened,
//$<modification> the following script will not be used. 
If ib_just_opened = true Then return 0
//---------------------------- APPEON END ----------------------------

uo_design.of_pre_pfc_save()

CALL pfc_w_master::pfc_save
uo_design.uo_screen_design_menu.ib_IsScreenChanged = false //Add by Evan 05.19.2009 --- Corrected BugG031002

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 02.20.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
COMMIT USING SQLCA;
DateTime ldt_dt
ldt_dt = DateTime( Today(), Now() )
UPDATE ids SET screen_cache = :ldt_dt, screen_obj_cache = :ldt_dt;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF
COMMIT USING SQLCA;
*/
DateTime ldt_dt
ldt_dt = DateTime( Today(), Now() )

gnv_appeondb.of_startqueue( )

COMMIT USING SQLCA;
UPDATE ids SET screen_cache = :ldt_dt, screen_obj_cache = :ldt_dt;
COMMIT USING SQLCA;

//The following scripts Moved from pfc_cst_u_data_entry_screen_painter.of_select_screen()
app_filler.ids_screen_fields_cache.Retrieve()
app_filler.ids_screen_objects_cache.Retrieve()
//Modified by Alan on 2008-10-16 delete retrieve report data
////--------------------------- APPEON BEGIN ---------------------------
////$<add> 26/08/2008 By: Alan
////$<reason> 
//app_filler.ids_report_fields_cache.Retrieve()
////---------------------------- APPEON END ----------------------------
gnv_appeondb.of_commitqueue( )

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.09.2006 By: LeiWei
//$<reason> Fix a defect.
uo_design.inv_data_entry.idt_screen_cache = ldt_dt
//---------------------------- APPEON END ----------------------------

RETURN 1
end event

event activate;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 08.08.2006 By: LeiWei
//$<reason> Performance tuning
IF ib_disable_activate THEN RETURN
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
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

w_mdi.of_menu_security( w_mdi.MenuName ) //Moved from below by Appeon long.zhang 07.04.2016 ( Bug ID #5223 for Case # 00065080: FW: Possible bug: Screen Design (and a question!))
w_mdi.SetToolbarPos ( 2, 1, 200, False )

long ll_handle
ll_handle = handle(w_mdi)
gnv_appeondll.of_settoolbarpos(ll_handle)

//w_mdi.of_menu_security( w_mdi.MenuName )//moved above by Appeon long.zhang 07.04.2016 ( Bug ID #5223 for Case # 00065080: FW: Possible bug: Screen Design (and a question!))


end event

event close;call super::close;//maha 100201
//Delete by Evan 01/10/2008
//messagebox("Screen Painter","Screen changes will not take effect in the Practitioner folder until it has been regenerated.  ~rIf open, close an reopen. ")

// mskinner 23 feb 2006 -- begin
OpenWITHPARM (w_utl_dvf_order_check,"P") 
if isvalid(w_utl_dvf_order_check) then 
	w_utl_dvf_order_check.visible= false
	w_utl_dvf_order_check.TriggerEvent ("ue_run")
end if 
// mskinner 23 feb 2006 -- end

//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 09.26.2006 By: Liang QingShi
//$<reason> Fix a defect.
/*
Close( w_design_menu )
*/
//---------------------------- APPEON END ----------------------------
w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)

w_mdi.of_menu_security( w_mdi.MenuName )



end event

event pfc_postopen;call super::pfc_postopen;//BEGIN---Add by Evan 01/12/2009
if not gb_se_version then
	uo_design.Event pfc_cst_select_view()
end if
//END---Add by Evan 01/12/2009
end event

type uo_design from pfc_cst_u_data_entry_screen_painter within w_prac_data_design
event destroy ( )
integer height = 2164
integer taborder = 20
boolean border = false
end type

on uo_design.destroy
call pfc_cst_u_data_entry_screen_painter::destroy
end on

event ue_screenchanged;call super::ue_screenchanged;//////////////////////////////////////////////////////////////////////
// $<event> ue_screenchanged
// $<arguments>
// $<returns> integer
// $<description> Screen changed event. (Corrected BugG031002)
//////////////////////////////////////////////////////////////////////
// $<add> Evan 05.19.2009
//////////////////////////////////////////////////////////////////////

integer li_Result

li_Result = MessageBox("IntelliSoft Group", "Do you want to save changes?", Question!, YesNoCancel!)
choose case li_Result
	case 1
		parent.Event pfc_Save()
		Return 0
	case 2
		Return 0
	case 3
		Return 1
end choose

Return 0
end event

