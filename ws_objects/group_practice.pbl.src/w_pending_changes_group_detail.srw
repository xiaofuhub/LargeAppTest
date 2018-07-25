$PBExportHeader$w_pending_changes_group_detail.srw
forward
global type w_pending_changes_group_detail from w_pending_changes_group
end type
end forward

global type w_pending_changes_group_detail from w_pending_changes_group
string title = "Pending Record Changes Detail"
end type
global w_pending_changes_group_detail w_pending_changes_group_detail

type variables
Long il_pending_id //alfee 11.07.2013
end variables

forward prototypes
public function integer of_set_security ()
end prototypes

public function integer of_set_security ();//====================================================================
//$<Function>: of_set_security
//$<Arguments>:
//$<Return>:  integer
//$<Description>: set readonly user access right BugL112101
//$<Author>: (Appeon) long.zhang 11.28.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
if isValid(w_group_practice) then
	if w_group_practice.of_get_Accesslevel() = 1 then
		cb_save.visible = false
		dw_detail.enabled = false
	end if
end if
return 1
end function

on w_pending_changes_group_detail.create
call super::create
end on

on w_pending_changes_group_detail.destroy
call super::destroy
end on

event open;//====================================================================
//$<Event>: open()
//$<Arguments>:
//$<Return>:  long
//$<Description>: Overrided
//$<Author>: (Appeon) Alfee 11.07.2013 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Long ll_find_row, ll_row, ll_pos
String ls_parm //format: e.g. A10-211 (type, pending id,location id) 

ls_parm = Message.StringParm
is_type = Left(ls_parm,1)
ll_pos = Pos(ls_parm, "-")

if Len(ls_parm) < 2 then //Add new pending record
	il_pending_id = 0
	il_loc_id = 0	
elseif ll_pos < 1 then //View pending record with 'A' type
	il_pending_id = long(MidA(ls_parm,2))
	il_loc_id = 0
else 						//View other records
	il_pending_id = long(MidA(ls_parm, 2, ll_pos - 2))
	il_loc_id = long(MidA(ls_parm, ll_pos + 1))
end if
	
ids_fields_prop = create datastore
ids_fields_prop.dataobject = 'd_sys_field_properties'
ids_fields_prop.settransobject( sqlca)
ids_fields_prop.retrieve(1,86)

if is_type = 'A' then	//add 
	ll_row = dw_detail.insertrow( 0)
	dw_detail.setitem( ll_row, "change_type","A")
	dw_detail.setitem( ll_row,'effective_date',datetime(today(),now()))
	dw_detail.modify ("change_type.protect = 1")
	dw_detail.modify ("change_type.background.color = 67108864")
else	//view
	dw_browse.event pfc_retrieve()
	ll_find_row = dw_browse.find( "pending_id="+string(il_pending_id),1,dw_browse.rowcount())
	if ll_find_row > 0 then dw_browse.scrolltorow( ll_find_row)
end if	
of_set_security()//long.zhang 11.28.2013 set access right BugL112101


end event

event close;call super::close;//for BugL111101 - Alfee 11.11.2013

if ib_saved then 
	closewithreturn (this,	"1")
end if
end event

type rb_1 from w_pending_changes_group`rb_1 within w_pending_changes_group_detail
boolean visible = false
string facename = "Segoe UI"
boolean enabled = false
end type

type cb_1 from w_pending_changes_group`cb_1 within w_pending_changes_group_detail
boolean visible = false
integer x = 3195
string facename = "Segoe UI"
boolean enabled = false
end type

type cb_save from w_pending_changes_group`cb_save within w_pending_changes_group_detail
integer x = 2505
string facename = "Segoe UI"
end type

event cb_save::clicked;//====================================================================
//$<Event>: clicked()
//$<Arguments>:
//$<Return>:  long
//$<Description>: Save data
//$<Author>: (Appeon) Alfee 11.08.2013 
//--------------------------------------------------------------------
//$<Modify History>: Overrided
//====================================================================

long ll_row
long ll_old_pendingid,ll_new_pendingid

ll_row = dw_detail.getrow( )

if parent.event pfc_save( )	= 1 then
	
	ll_new_pendingid = dw_detail.getitemnumber( ll_row,'pending_id')

	il_pending_id = ll_new_pendingid //alfee 11.08.2013
		
	dw_browse.event pfc_retrieve()
		
	ll_row = dw_browse.find( 'pending_status=1 and pending_id='+String(ll_new_pendingid),1,dw_browse.rowcount() )
		
	if ll_row > 0 then
		dw_browse.event rowfocuschanged(ll_row)
	end if

end if


end event

type cb_add from w_pending_changes_group`cb_add within w_pending_changes_group_detail
boolean visible = false
integer x = 2848
string facename = "Segoe UI"
boolean enabled = false
end type

event cb_add::clicked;//overrided - alfee 11.07.2013


end event

type cb_close from w_pending_changes_group`cb_close within w_pending_changes_group_detail
integer x = 3543
string facename = "Segoe UI"
end type

type dw_detail from w_pending_changes_group`dw_detail within w_pending_changes_group_detail
end type

event dw_detail::itemchanged;//Overrided - alfee 11.07.2013

end event

type dw_browse from w_pending_changes_group`dw_browse within w_pending_changes_group_detail
integer x = 37
integer width = 3881
string dataobject = "d_group_pending_browse_by_pk"
end type

event dw_browse::pfc_retrieve;//overrided - alfee 11.07.2013

Return this.retrieve( il_pending_id)

end event

event dw_browse::retrieveend;//overrided - alfee 11.08.2013
end event

type gb_1 from w_pending_changes_group`gb_1 within w_pending_changes_group_detail
boolean visible = false
string facename = "Segoe UI"
long textcolor = 8388608
boolean enabled = false
end type

type rb_2 from w_pending_changes_group`rb_2 within w_pending_changes_group_detail
boolean visible = false
string facename = "Segoe UI"
boolean enabled = false
end type

