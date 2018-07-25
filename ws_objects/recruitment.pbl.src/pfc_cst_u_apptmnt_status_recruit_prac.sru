$PBExportHeader$pfc_cst_u_apptmnt_status_recruit_prac.sru
forward
global type pfc_cst_u_apptmnt_status_recruit_prac from pfc_cst_u_apptmnt_status
end type
end forward

global type pfc_cst_u_apptmnt_status_recruit_prac from pfc_cst_u_apptmnt_status
long backcolor = 33551856
end type
global pfc_cst_u_apptmnt_status_recruit_prac pfc_cst_u_apptmnt_status_recruit_prac

forward prototypes
public function integer of_new_record (long al_prac_id)
end prototypes

public function integer of_new_record (long al_prac_id);Integer l
Integer li_org_id
Integer li_nr
Integer i
Integer li_rc
Integer li_num_comms
Integer c
Long ll_record_id
DataWindowChild dwchild
n_ds ldw
n_ds lds_cred_comms

li_nr = tab_view.tabpage_detail_1.dw_apptmnt_status.InsertRow(0)

IF gb_se_version = True THEN
	tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"parent_facility_id",1)
	tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"verifying_facility",1)
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 04.12.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Modify the script to ensure that the application hits the database only once.

//il_rec_id = gnv_app.of_get_id( "RECORD_ID" )
If il_rec_id_multi_app = 0 Then
	il_rec_id = gnv_app.of_get_id( "RECORD_ID" )
Else
	il_rec_id_multi_app ++
	il_rec_id =  il_rec_id_multi_app
End IF
//---------------------------- APPEON END ----------------------------
tab_view.tabpage_detail_1.dw_apptmnt_status.setitem(li_nr,"prov_status",0)

tab_view.tabpage_detail_2.dw_departments.Reset()
tab_view.tabpage_detail_2.dw_departments.InsertRow(0)

tab_view.tabpage_detail_2.dw_staff_cat.Reset()
tab_view.tabpage_detail_2.dw_staff_cat.InsertRow(0)

tab_view.tabpage_detail_1.dw_apptmnt_status.ScrollToRow( li_nr )
tab_view.tabpage_detail_1.dw_apptmnt_status.SetRow( li_nr )

il_prac_id = al_prac_id

tab_view.tabpage_detail_1.dw_apptmnt_status.SetFocus()

ib_new_record = True

tab_view.tabpage_detail_1.dw_comm_review.Reset()

Return 0

end function

on pfc_cst_u_apptmnt_status_recruit_prac.create
call super::create
end on

on pfc_cst_u_apptmnt_status_recruit_prac.destroy
call super::destroy
end on

type st_recs from pfc_cst_u_apptmnt_status`st_recs within pfc_cst_u_apptmnt_status_recruit_prac
end type

type dw_orgs_facilities from pfc_cst_u_apptmnt_status`dw_orgs_facilities within pfc_cst_u_apptmnt_status_recruit_prac
boolean visible = false
integer x = 2025
integer y = 0
end type

type tab_view from pfc_cst_u_apptmnt_status`tab_view within pfc_cst_u_apptmnt_status_recruit_prac
integer x = 9
integer y = 12
end type

type tabpage_browse from pfc_cst_u_apptmnt_status`tabpage_browse within tab_view
long backcolor = 33551856
end type

type dw_browse from pfc_cst_u_apptmnt_status`dw_browse within tabpage_browse
end type

type tabpage_detail_1 from pfc_cst_u_apptmnt_status`tabpage_detail_1 within tab_view
long backcolor = 33551856
end type

type dw_apptmnt_status from pfc_cst_u_apptmnt_status`dw_apptmnt_status within tabpage_detail_1
end type

event dw_apptmnt_status::pfc_postupdate;Integer li_facility_id
Integer li_found
Integer li_rec_no
Long    ll_appt_stat_id


IF THIS.ROWCOUNT( ) < 1 THEN RETURN Failure

li_facility_id = dw_apptmnt_status.GetItemNumber( dw_apptmnt_status.GetRow(), "parent_facility_id" )
ll_appt_stat_id = dw_apptmnt_status.GetItemNumber(dw_apptmnt_status.GetRow(), "rec_id") //Evan 02.20.2009

ib_postupdate = true


li_found = dw_orgs_facilities.Find("parent_facility_id = " + String( li_facility_id ), 1, 1000 )
IF li_found > 0 THEN
	li_rec_no = li_found
ELSEIF dw_orgs_facilities.RowCount() > 0 THEN
	li_rec_no = 1
END IF


IF li_rec_no > 0 THEN
	dw_orgs_facilities.ScrollToRow( li_rec_no )
	dw_orgs_facilities.SetRow( li_rec_no )
	dw_orgs_facilities.SelectRow( 0, False )
	dw_orgs_facilities.SelectRow( li_rec_no, True )
END IF

dw_apptmnt_status.SetFocus()

ii_selected_facility_id = This.GetItemNumber( This.GetRow(), "parent_facility_id" )
//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.29.2007 By: Evan
//$<Reason> After update,The dw_orgs_facilities's record doesn't match the dw_apptmnt_status's record on Web
of_retrieve_detail()
tab_view.tabpage_browse.dw_browse.SelectRow(0, false)
tab_view.tabpage_browse.dw_browse.SelectRow(1, true)
//---------------------------- APPEON END ----------------------------	

if gi_parent_facility = 0 then //maha 042904 for when a practitioner is added to a new facility via the ssn search already having an appointment with another facility.
	gi_parent_facility = ii_selected_facility_id
end if
if ii_parent_facility_id = 0 then //maha 042904 for when a practitioner is added to a new facility via the ssn search already having an appointment with another facility.
	ii_parent_facility_id = ii_selected_facility_id
end if

if ib_new_prac then //maha 102102
	ii_parent_facility_id = This.GetItemNumber( This.GetRow(), "parent_facility_id" )
	of_create_action_item_by_workflow('NEW')
end if

ib_postupdate = false


of_psv_update( il_prac_id, il_rec_id, ii_selected_facility_id , ii_verifying_facility_id )



Call Super::pfc_resetupdate

if ib_new_prac then ib_new_prac = false

Return 0

end event

type gb_comm from pfc_cst_u_apptmnt_status`gb_comm within tabpage_detail_1
end type

type dw_comm_review from pfc_cst_u_apptmnt_status`dw_comm_review within tabpage_detail_1
end type

type tabpage_detail_2 from pfc_cst_u_apptmnt_status`tabpage_detail_2 within tab_view
end type

type dw_leave from pfc_cst_u_apptmnt_status`dw_leave within tabpage_detail_2
end type

type gb_lea from pfc_cst_u_apptmnt_status`gb_lea within tabpage_detail_2
end type

type gb_dep from pfc_cst_u_apptmnt_status`gb_dep within tabpage_detail_2
end type

type gb_cat from pfc_cst_u_apptmnt_status`gb_cat within tabpage_detail_2
end type

type dw_staff_cat from pfc_cst_u_apptmnt_status`dw_staff_cat within tabpage_detail_2
end type

type dw_departments from pfc_cst_u_apptmnt_status`dw_departments within tabpage_detail_2
end type

type tabpage_quest from pfc_cst_u_apptmnt_status`tabpage_quest within tab_view
boolean visible = false
end type

type dw_quest from pfc_cst_u_apptmnt_status`dw_quest within tabpage_quest
end type

type tabpage_ofe from pfc_cst_u_apptmnt_status`tabpage_ofe within tab_view
boolean visible = false
end type

type uo_ofe from pfc_cst_u_apptmnt_status`uo_ofe within tabpage_ofe
end type

type p_1 from pfc_cst_u_apptmnt_status`p_1 within pfc_cst_u_apptmnt_status_recruit_prac
end type

type dw_facility_add from pfc_cst_u_apptmnt_status`dw_facility_add within pfc_cst_u_apptmnt_status_recruit_prac
end type

