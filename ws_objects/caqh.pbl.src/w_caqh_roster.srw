$PBExportHeader$w_caqh_roster.srw
forward
global type w_caqh_roster from w_main
end type
type cb_close from commandbutton within w_caqh_roster
end type
type cb_setup from commandbutton within w_caqh_roster
end type
type uo_1 from pfc_cst_u_roster_sumbit within w_caqh_roster
end type
end forward

global type w_caqh_roster from w_main
integer width = 4402
integer height = 2108
string title = "CAQH Roster"
long backcolor = 33551856
event ue_setup_changed ( )
cb_close cb_close
cb_setup cb_setup
uo_1 uo_1
end type
global w_caqh_roster w_caqh_roster

type variables
Boolean ib_from_sched = False
end variables

forward prototypes
public function integer of_sched_run (string as_type, ref string as_message, ref long al_proc_cnt)
end prototypes

event ue_setup_changed();//====================================================================
//$<Event>: ue_setup_changed
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Called from w_caqh_roster_setup
//$<Author>: (Appeon) long.zhang 07.08.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

uo_1.event ue_refresh_settings() 

uo_1.event ue_check() 
end event

public function integer of_sched_run (string as_type, ref string as_message, ref long al_proc_cnt);//====================================================================
//$<Function>: of_sched_run
//$<Arguments>:
//	string			as_type	'LIST' (Return Roster file)/ 'EXCEPTION'  (Exception file)
// 	reference    string    as_message
// 	reference        long      al_proc_cnt
//$<Return>:  integer
//$<Description>: Runing scheduler
//$<Author>: (Appeon) long.zhang 07.20.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Int li_return

li_return =  uo_1.of_sched_run(as_type, as_message, al_proc_cnt)

Return li_return
end function

on w_caqh_roster.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_setup=create cb_setup
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_setup
this.Control[iCurrent+3]=this.uo_1
end on

on w_caqh_roster.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_setup)
destroy(this.uo_1)
end on

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 05.28.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
String ls_scale
Int ll_i

//Roster Setup Security - Utility Admin Access right
If w_mdi.of_security_access( 1345 ) = 0   then
	This.cb_setup.Enabled = False
End If

//Start Code Change ----11.10.2015 #V15 maha
//If w_mdi.of_security_access( 7808 ) = 0   then
If w_mdi.of_security_access( 7807 ) = 0   then //7808 ->7807, modified by Appeon long.zhang 01.21.2016
	This.cb_setup.Enabled = False
End If
uo_1.of_security()
//End Code Change ----11.10.2015

//Schedule Import
If message.StringParm = 'Schedule Import' Then
	this.Hide()
	ib_from_sched = True
End If

this.of_SetResize(true)
inv_resize.of_setorigsize( this.workspacewidth(), this.workspaceheight())
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())
inv_resize.of_Register(cb_setup, inv_resize.fixedright)
inv_resize.of_Register(cb_close, inv_resize.fixedright)
inv_resize.of_Register(uo_1, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1, inv_resize.SCALE)
inv_resize.of_Register(uo_1.tab_1.tabpage_files.dw_files, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_submission.tab_view_submit, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_submission.dw_submit_browse, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_submission.dw_submit_detail, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_exception.dw_exception, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_list.tab_view_list, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_list.dw_roster_browse, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(uo_1.tab_1.tabpage_list.dw_roster_detail, inv_resize.SCALERIGHTBOTTOM)

uo_1.of_set_parent_window(this)

If Not ib_from_sched Then
	uo_1.Post event ue_check() //check settings
	uo_1.Post of_files_retrieve() //Retrive files
End If



end event

event closequery;call super::closequery;//====================================================================
//$<Event>: closequery
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 05.28.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

If uo_1.ib_processing Then Return 1
end event

type cb_close from commandbutton within w_caqh_roster
integer x = 3470
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "C&lose"
end type

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Close(parent)
end event

type cb_setup from commandbutton within w_caqh_roster
event ue_setup_changed ( )
integer x = 3086
integer width = 357
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "R&oster Setup"
end type

event ue_setup_changed();uo_1.event ue_refresh_settings()

end event

event clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: CAQH Roster Setup
//$<Author>: (Appeon) long.zhang 09.29.2015 (v15.1 CAQH Roster Automation)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

open(w_caqh_roster_setup)
end event

type uo_1 from pfc_cst_u_roster_sumbit within w_caqh_roster
integer x = 9
integer y = 4
integer height = 2012
integer taborder = 21
end type

on uo_1.destroy
call pfc_cst_u_roster_sumbit::destroy
end on

