$PBExportHeader$w_red_flag_add.srw
forward
global type w_red_flag_add from w_main
end type
type dw_redflag from u_dw within w_red_flag_add
end type
type cb_save from u_cb within w_red_flag_add
end type
type cb_close from u_cb within w_red_flag_add
end type
end forward

global type w_red_flag_add from w_main
integer width = 2629
integer height = 1640
string title = "Add Red Flag Data"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
dw_redflag dw_redflag
cb_save cb_save
cb_close cb_close
end type
global w_red_flag_add w_red_flag_add

type variables
string is_lookname
boolean ib_no_record
n_cst_code_lookup_audit inv_audit
gs_code_lookup   istr_lookup
str_rfd_data is_str_rfd //Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
end variables

forward prototypes
protected function integer of_validate_row (string as_type, ref u_dw au_dw)
private function long of_get_appt_stat_id (long al_facilityid, long al_pracid)
end prototypes

protected function integer of_validate_row (string as_type, ref u_dw au_dw);//==========================================
// $<Function> of_validate_row ()
// $<arguments>
// 	value    string    as_type : Data type
// 	reference u_dw   au_dw:datawindow control where can get data
// $<returns>1 - success; -1 - failure 
// $<description>red flag data:validate the row of datawindow control
// $<add> (Appeon) Long 07.01.2011
//==========================================
long ll_row
IF as_type = "GEN"  THEN Return 1
IF as_type = "" THEN Return -1
ll_row = au_dw.GetRow( )
IF ll_row < 1 THEN Return -1
au_dw.AcceptText()
IF au_dw.getitemstatus( ll_row,0,Primary!) <> NotModified! THEN
	MessageBox("Info","Please save the current record first")
	return -1
END IF
return 1
end function

private function long of_get_appt_stat_id (long al_facilityid, long al_pracid);//==========================================
// $<Function> of_get_app_stat_id ()
// $<arguments>
// 	value    long    al_facilityid : Facilityid
// 	value    long    al_pracid:pracid
// $<returns> rec_id from appointment record   1- success; -1 - failure 
// $<description>red flag data:get rec_id from appointment record
// $<add> (Appeon) Long 07.01.2011
//==========================================
Long ll_return_row,ll_appt_stat_id
Datastore ld_stat_id
ld_stat_id = Create Datastore
ld_stat_id.dataobject = "d_pd_affil_status_browse"
ld_stat_id.settransobject( SQLCA)
ll_return_row = ld_stat_id.retrieve(al_pracid,al_facilityid,gs_user_id)
IF ll_return_row > 0 THEN
	ll_appt_stat_id = ld_stat_id.getitemnumber( 1,"rec_id")
ELSe
	ll_appt_stat_id = -1
END IF
destroy ld_stat_id
return ll_appt_stat_id

end function

on w_red_flag_add.create
int iCurrent
call super::create
this.dw_redflag=create dw_redflag
this.cb_save=create cb_save
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_redflag
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_close
end on

on w_red_flag_add.destroy
call super::destroy
destroy(this.dw_redflag)
destroy(this.cb_save)
destroy(this.cb_close)
end on

event open;call super::open;//$<add>(APPEON) long.zhang 07.01.2011
//$<reason> add red flag data
string ls_type,ls_reference,ls_full_name,ls_rec_id,ls_filter,ls_parm
long ll_Prac_id ,ll_facility_id,ll_screen_id ,ll_appt_stat_id,ll_question_id,ll_row,ll_position
u_dw lu_dw_data
//str_rfd_data ls_str_rfd//Comment by Appeon long.zhang 09.19.2016 (Use is_str_rfd instead)
w_prac_data_1 lw_prac

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 09.19.2016
//<$>reason:Use is_str_rfd instead, for V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified
//ls_str_rfd = Message.powerobjectparm
//ls_type = ls_str_rfd.s_type
//lu_dw_data = ls_str_rfd.u_datawindow
is_str_rfd = Message.powerobjectparm 
ls_type = is_str_rfd.s_type
lu_dw_data = is_str_rfd.u_datawindow
//------------------- APPEON END -------------------

IF of_validate_row(ls_type,lu_dw_data) = -1 THEN
	Close(this)
	Return 0
END IF

SetPointer(HourGlass!)
SetNull(ls_full_name)
setNull(ll_Prac_id)
SetNull(ll_facility_id)
SetNull(ls_rec_id)
SetNull(ll_screen_id)

//lw_prac = ls_str_rfd.w_prac //Comment by Appeon long.zhang 09.19.2016 (Use is_str_rfd instead)
lw_prac = is_str_rfd.w_prac

IF ls_type <> "GEN" THEN ll_row = lu_dw_data.getrow( )
IF ls_type <> "GEN" AND ls_type <> "OFE"  THEN ll_prac_id = lw_prac.il_prac_id
IF ls_type = "OFE" THEN ll_prac_id = lu_dw_data.getitemnumber( ll_row,"prac_id")

choose case ls_type
	case"DE"
		ll_facility_id = lw_prac.ii_parent_facility_id
		ll_screen_id = lw_prac.tab_1.tabpage_detail.uo_data_entry.ii_screen_id
		ls_rec_id = String(lw_prac.tab_1.tabpage_detail.uo_data_entry.il_rec_id)
		ls_reference = lw_prac.tab_1.tabpage_detail.uo_data_entry.of_get_reference()
	case "APPT"
		ll_facility_id = lu_dw_data.getitemnumber( ll_row ,"parent_facility_id")
		ls_rec_id = String(lu_dw_data.getitemnumber( ll_row ,"rec_id"))
		ls_reference = gnv_data.of_getitem('facility','facility_name','facility_id = ' + String(ll_facility_id))
	case "VER"
		ll_facility_id = lu_dw_data.getitemnumber( ll_row,"parent_facility_id")
		ls_rec_id = lu_dw_data.getitemstring( ll_row,"doc_id")
		ls_reference = lu_dw_data.getitemstring( ll_row,"reference_value")
	case "PRIV"
		ll_facility_id = lu_dw_data.getitemnumber( ll_row,"facility_id")
		ls_rec_id = String(lu_dw_data.getitemnumber( ll_row,"rec_id"))
		ls_reference = lu_dw_data.getitemstring( ll_row,"priv_core_procd_procd_name")
	case "AttQ"
		ll_facility_id = lu_dw_data.getitemnumber( ll_row,"facility_id")
		ls_rec_id = String(lu_dw_data.getitemnumber( ll_row,"rec_id"))
		ll_question_id = lu_dw_data.getitemnumber(ll_row,"question_id")
		select short_quest into :ls_reference from question_lookup where quest_id = :ll_question_id;
	case "OFE"	
		ll_facility_id =  lu_dw_data.getitemnumber( ll_row,"facility_id")
		ls_rec_id = String(lu_dw_data.getitemnumber( ll_row,"pd_oppe_hdr_id"))	
		ls_reference= lu_dw_data.getitemstring( ll_row,"oppe_fppe")
		IF not IsNull(lu_dw_data.getitemdatetime( ll_row,"from_date")) and not IsNull(lu_dw_data.getitemdatetime( ll_row,"to_date")) THEN
			ls_reference += ": From: "+ String(Date(lu_dw_data.getitemdatetime( ll_row,"from_date")))
			ls_reference += "  To: " + String(Date(lu_dw_data.getitemdatetime( ll_row,"to_date")))
		END IF
	case "GEN"
		ib_no_record=true
		ls_reference = "Note"
		gs_search lstr_search
		lstr_search.stran_transaction = SQLCA
		lstr_search.ls_open_for = "SKL"
		OpenWithParm( w_extended_search_new , lstr_search )
		ls_parm = Message.StringParm
		IF ls_parm = "" THEN 
			close(this)
			Return 0
		ELSE
			ll_position = PosA(ls_parm,"-")
			ll_Prac_id = Long(MidA(ls_parm,1,ll_position - 1))
			ll_facility_id = gi_parent_facility	
		END IF
end choose

IF ls_type <> "GEN" THEN
	IF ls_type = "DE" THEN
		ls_filter = "screen_id = "+ String(ll_screen_id) +" and Record_id = '"+ ls_rec_id +"'"
	ELSE
		ls_filter = "data_type = '" + ls_type + "' and record_id='"+ ls_rec_id +"'"
	END IF
	dw_redflag.settransobject( SQLCA)
	dw_redflag.retrieve( ll_prac_id,ll_facility_id)
	dw_redflag.setfilter( ls_filter )
	dw_redflag.filter( )
	IF dw_redflag.rowcount( ) = 0 Then	ib_no_record = true
END IF	

IF ib_no_record  THEN
	nv_prac_info lnv_full_name
	lnv_full_name = CREATE nv_prac_info
	ls_full_name = lnv_full_name.of_get_name( ll_prac_id )
	if isnull(ls_full_name) then ls_full_name = ''
	DESTROY lnv_full_name	
	
	IF ls_type = "APPT" THEN
		ll_appt_stat_id = Long(ls_rec_id)
	ELSE
		ll_appt_stat_id = of_get_appt_stat_id(ll_facility_id,ll_prac_id)
		IF ll_appt_stat_id= -1 THEN SetNull(ll_appt_stat_id)
	END IF

	dw_redflag.insertrow( 0)
	dw_redflag.setitem( 1,"msp_id",gs_user_id)
	dw_redflag.setitem( 1, "v_full_name_full_name",ls_full_name)
	dw_redflag.setitem( 1,"prac_id",ll_prac_id)
	dw_redflag.setitem( 1,"facility_id",ll_facility_id)
	dw_redflag.setitem( 1,"data_type",ls_type)
	dw_redflag.setitem( 1,"record_id",ls_rec_id)
	dw_redflag.setitem( 1,"reference_value",ls_reference)
	dw_redflag.setitem( 1,"Appt_stat_id",ll_appt_stat_id)
	dw_redflag.setitem( 1,"screen_id", ll_screen_id)
	dw_redflag.setitemstatus( 1,0,Primary!,NotModified!)
END IF
SetPointer(Arrow!)

end event

event pfc_save;//red flag data:added by long.zhang 07.27.2011
Integer li_retval
ulong 	ll_rfd_id
IF ib_no_record THEN
	select max(Rfd_id) into :ll_rfd_id from pd_red_flag_data;
	IF IsNull(ll_rfd_id) THEN ll_rfd_id = 0
	ll_rfd_id++
	dw_redflag.setitem( 1,"Rfd_id",ll_rfd_id)
	dw_redflag.setitem( 1,"msp_date",DateTime(today(),now()))
END IF
li_retval = Super::Event pfc_save()
return li_retval
end event

type dw_redflag from u_dw within w_red_flag_add
integer x = 5
integer width = 2615
integer height = 1420
integer taborder = 10
string dataobject = "d_red_flag_detail2"
boolean vscrollbar = false
boolean border = false
end type

event pfc_postupdate;call super::pfc_postupdate;//Added by Appeon long.zhang 09.19.2016 (V15.2 Testing Bug #5331: Red Flag and Standing indicators in the top left corner of the screen do not refresh when data is modified)
is_str_rfd.w_prac.Event ue_refresh_dw_red_flag()	
Return 1
end event

type cb_save from u_cb within w_red_flag_add
integer x = 1038
integer y = 1444
integer width = 325
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
end type

event clicked;call super::clicked;//$<add> 07.01.2011 by long.zhang
//$<reason> red flag data
IF Parent.Event pfc_save( ) >= 0 THEN 
	close(parent)
End If
end event

type cb_close from u_cb within w_red_flag_add
integer x = 1399
integer y = 1444
integer width = 325
integer taborder = 40
boolean bringtotop = true
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 03.28.2011
//////////////////////////////////////////////////////////////////////
Close(Parent)
end event

