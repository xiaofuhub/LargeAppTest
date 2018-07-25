$PBExportHeader$n_cst_npdb_control.sru
$PBExportComments$Used to start the npdb process. Created because the functionality exist in multiple places. Also, this object opens visual components which we do not want to do in the main object.
forward
global type n_cst_npdb_control from nonvisualobject
end type
end forward

global type n_cst_npdb_control from nonvisualobject
end type
global n_cst_npdb_control n_cst_npdb_control

type variables
n_cst_npdb invo_npdb
boolean ib_do_not_open
constant long 	RECIEVE = 1
constant long 	SEND    = 2
constant long 	QUIT    = 3

Boolean ib_schedule = false //scheduler - alfee 03.12.2010
end variables

forward prototypes
public subroutine of_run_npdb (u_dw adw)
public function string of_get_sched_msg ()
public function integer of_get_sched_cnt ()
public function integer of_set_sched_flag (integer ai_sched_id, boolean ab_flag)
end prototypes

public subroutine of_run_npdb (u_dw adw);/******************************************************************************************************************
**  [PUBLIC]   : of_run_npdb
**==================================================================================================================
**  Purpose   	: This funcion is used to encapsulate functionality thatis used in multipe plaeces to kick off
**               the npdb process.
**==================================================================================================================
**  Arguments 	: [adw] Datawindow with the doc_ids to be sent for processing
**==================================================================================================================
**  Returns   	: [none]   
**==================================================================================================================
**  Notes     	: 	   
**==================================================================================================================
**  Created By	: Michael B. Skinner  Friday, March 18, 2005
**==================================================================================================================
**  Modification Log
**   Changed By             Change Date                                               Reason
** ------------------------------------------------------------------------------------------------------------------
********************************************************************************************************************/
str_pass lstr_pass


if not isvalid(invo_npdb) then
  invo_npdb = create n_cst_npdb
	if invo_npdb.of_initialize( ) = -1 then return //Start Code Change ---- 07.05.2007 #V7 maha get out if canceled in initialize
end if

if not ib_do_not_open then 
  open(w_npdb_direction_chooser)
end if

// catch the return parm

choose case message.doubleparm
	case RECIEVE   //1
		invo_npdb.of_start_npdb(invo_npdb.is_recieve,0,0,'NONE',adw)
		lstr_pass.s_string_array =  invo_npdb.is_doc_id
		// pass the userobject so that some of the retrieve do not happen
		// twice
		lstr_pass.uo1 = invo_npdb
		if not ib_schedule or not gb_autoschedule then //scheduler - alfee 03.12.2010
			openwithParm(w_npdb_reports,lstr_pass)
		end if
	case SEND  //2
		invo_npdb.of_start_npdb(invo_npdb.is_send,0,0,'NONE',adw)
		//after sending ask if want to check for recieve
		//Start Code Change ----05.08.2008 #V8 maha - removed, don't think I like it here
//		if messagebox('ITP Interface', 'Would you like to check to see if there are any reports available from the PDBB',question! , yesno!,1 ) = 1 then
//			message.doubleparm = RECIEVE
//			ib_do_not_open = true
//			of_run_npdb(adw)
//		end if
	case QUIT
		// do nothing
	case else
		// do nothing
end choose


end subroutine

public function string of_get_sched_msg ();//Get messages of the schedule - (scheduler)alfee 02.06.2010

if not isvalid(invo_npdb) then return ''

return invo_npdb.of_get_sched_msg()
end function

public function integer of_get_sched_cnt ();//Get processed count of the schedule - (scheduler)alfee 02.06.2010

if not isvalid(invo_npdb) then return -1

return invo_npdb.of_get_sched_cnt( )
end function

public function integer of_set_sched_flag (integer ai_sched_id, boolean ab_flag);//Set the schedule flag - (scheduler)alfee 02.25.2010

if not isvalid(invo_npdb) then 
	invo_npdb = create n_cst_npdb
	invo_npdb.of_initialize( )
end if

ib_schedule = ab_flag //03.12.2010

return invo_npdb.of_set_sched_flag(ai_sched_id, ab_flag) 

end function

on n_cst_npdb_control.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_npdb_control.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;

if isvalid(invo_npdb) then destroy invo_npdb
end event

