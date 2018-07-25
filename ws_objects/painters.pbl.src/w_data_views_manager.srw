$PBExportHeader$w_data_views_manager.srw
forward
global type w_data_views_manager from w_response
end type
type uo_views_manager from pfc_cst_u_views_manager within w_data_views_manager
end type
end forward

global type w_data_views_manager from w_response
integer x = 480
integer y = 172
integer width = 2939
integer height = 2180
string title = "Practitioner Data View Design"
long backcolor = 33551856
uo_views_manager uo_views_manager
end type
global w_data_views_manager w_data_views_manager

forward prototypes
public function integer of_check_data ()
end prototypes

public function integer of_check_data ();

integer i

select max(data_view_id) into :i from data_view;

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 01.17.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
delete from data_view_screen where data_view_id > :i;
delete from data_view_fields where data_view_id > :i;
delete from data_view_screen_objects where data_view_d > :i;
*/
gnv_appeondb.of_startqueue( )

delete from data_view_screen where data_view_id > :i;
delete from data_view_fields where data_view_id > :i;
//delete from data_view_screen_objects where data_view_d > :i; //Commented by (Appeon)Harry 01.21.2015
delete from data_view_screen_objects where data_view_id > :i; //(Appeon)Harry 01.21.2015

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------


return 1
end function

on w_data_views_manager.create
int iCurrent
call super::create
this.uo_views_manager=create uo_views_manager
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_views_manager
end on

on w_data_views_manager.destroy
call super::destroy
destroy(this.uo_views_manager)
end on

event open;call super::open;integer wv
uo_views_manager.of_Set_Parent_Window( This )
of_check_data()

wv = of_get_app_setting("set_web","I")
if wv = 1 then
	uo_views_manager.cb_required.visible =  true
end if

uo_views_manager.of_setup( )

end event

event pfc_save;Return 1
end event

event closequery;//Override
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2008 By: Evan
//$<reason> Fix BugN122714 about cannot save data.
integer li_Return
long ll_ModifiedCount

ll_ModifiedCount = uo_views_manager.dw_available.ModifiedCount()
ll_ModifiedCount += uo_views_manager.dw_available.DeletedCount()
ll_ModifiedCount += uo_views_manager.dw_selected.ModifiedCount()
ll_ModifiedCount += uo_views_manager.dw_selected.DeletedCount()
if ll_ModifiedCount > 0 then
	li_Return = MessageBox("IntelliSoftGroup", "Do you want to save changes?", Exclamation!, YesNoCancel!)
	if li_Return = 1 then
		uo_views_manager.cb_save.Event Clicked()
	elseif li_Return = 3 then
		Return 1
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

type uo_views_manager from pfc_cst_u_views_manager within w_data_views_manager
event destroy ( )
integer taborder = 10
boolean bringtotop = true
end type

on uo_views_manager.destroy
call pfc_cst_u_views_manager::destroy
end on

