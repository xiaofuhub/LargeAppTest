$PBExportHeader$w_back_from_committee.srw
forward
global type w_back_from_committee from w_response
end type
type tab_bfc from tab within w_back_from_committee
end type
type tabpage_status from userobject within tab_bfc
end type
type uo_status from pfc_cst_u_apptmnt_status_back_from_comm within tabpage_status
end type
type tabpage_status from userobject within tab_bfc
uo_status uo_status
end type
type tab_bfc from tab within w_back_from_committee
tabpage_status tabpage_status
end type
type cb_1 from u_cb within w_back_from_committee
end type
type cb_2 from u_cb within w_back_from_committee
end type
end forward

global type w_back_from_committee from w_response
integer x = 347
integer y = 32
integer width = 3703
integer height = 2420
string title = "Appointment Status"
long backcolor = 33551856
tab_bfc tab_bfc
cb_1 cb_1
cb_2 cb_2
end type
global w_back_from_committee w_back_from_committee

type variables
String is_opened_for
end variables

on w_back_from_committee.create
int iCurrent
call super::create
this.tab_bfc=create tab_bfc
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_bfc
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
end on

on w_back_from_committee.destroy
call super::destroy
destroy(this.tab_bfc)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;String ls_name
long ll_recid
integer r, li_ans

ll_recid = message.doubleparm  //Start Code Change ----10.30.2014 #V14.2 maha - only midcycle should have a value > 0

tab_bfc.tabpage_status.uo_status.of_setup_dw() //maha 082201
tab_bfc.tabpage_status.uo_status.of_set_select_facility_invisible( False )
tab_bfc.tabpage_status.uo_status.of_set_prac_id( gl_prac_id )
tab_bfc.tabpage_status.uo_status.of_set_parent_facility_id( gl_facility_id )

tab_bfc.tabpage_status.uo_status.ib_comm_review = true

//Start Code Change ----10.24.2014 #V14.2 maha
if ll_recid > 0 then
	tab_bfc.tabpage_status.uo_status.ib_mid_from_comm = true
	tab_bfc.tabpage_status.uo_status.il_rec_id = ll_recid
end if
//Start Code Change ----10.24.2014

tab_bfc.tabpage_status.uo_status.of_retrieve_detail( )
//tab_bfc.tabpage_status.uo_status.of_filter_just_active( True )		
if ll_recid = 0 then tab_bfc.tabpage_status.uo_status.of_filter_just_active( True )
is_opened_for = gs_param

IF is_opened_for <> "REAPP" THEN
	tab_bfc.tabpage_status.uo_status.of_set_comm_protected( )
else // reappointment process  //maha 123002 to allow data to save without any changes being made.
	//Start Code Change ----10.30.2014 #V14.2 maha - change the row
	r = tab_bfc.tabpage_status.uo_status.tab_view.tabpage_detail_1.dw_apptmnt_status.getrow()
	tab_bfc.tabpage_status.uo_status.tab_view.tabpage_detail_1.dw_apptmnt_status.SetItemStatus (r, 0,primary!, datamodified! ) 
	//tab_bfc.tabpage_status.uo_status.tab_view.tabpage_detail_1.dw_apptmnt_status.SetItemStatus (1, 0,primary!, datamodified! ) 
	//End Code Change ----10.30.2014
	tab_bfc.tabpage_status.uo_status.ib_recred = true  //Start Code Change ----07.26.2017 #V154 maha - for message change on user
END IF

nv_prac_info lnv_full_name
lnv_full_name = CREATE nv_prac_info
ls_name = lnv_full_name.of_get_name( gl_prac_id )
DESTROY lnv_full_name	

This.Title = This.Title + "  (" + ls_name + ")"

//---------Begin Added by (Appeon)Stephen 02.28.2017 for Bug ID #5513 for Case #00069440 assigning correct user name when initialing recred--------
if isvalid(w_recred_prac) then
	tab_bfc.tabpage_status.uo_status.ib_Priority_User = w_recred_prac.inv_recred.ib_Priority_User
	if tab_bfc.tabpage_status.uo_status.ib_Priority_User = true then
		li_ans = MessageBox( "Change User", "You are changing the user to which the Action Items will be assigned.  Do you want the New Action Item records to reflect this change? ", Question!, YesNo!, 1 )   //Start Code Change ----07.25.2017 #V154 maha - modified message to New Actions
		IF li_ans <> 1 THEN
			 tab_bfc.tabpage_status.uo_status.ib_Priority_User = false
		end if				
	end if
end if
//---------End Added ------------------------------------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;IF is_opened_for <> "REAPP" THEN
	IF tab_bfc.tabpage_status.uo_status.of_back_from_commit_rqrd_flds() = -1  THEN
		Return -1
	END IF
END IF

Return 1
end event

event closequery;//overwriting pfc code to prevent asking Do you want to save changes during recred process //maha 011403
end event

type tab_bfc from tab within w_back_from_committee
integer x = 41
integer y = 8
integer width = 3589
integer height = 2176
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
integer selectedtab = 1
tabpage_status tabpage_status
end type

on tab_bfc.create
this.tabpage_status=create tabpage_status
this.Control[]={this.tabpage_status}
end on

on tab_bfc.destroy
destroy(this.tabpage_status)
end on

type tabpage_status from userobject within tab_bfc
integer x = 18
integer y = 100
integer width = 3552
integer height = 2060
long backcolor = 33551856
string text = "Affiliation Status"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
uo_status uo_status
end type

on tabpage_status.create
this.uo_status=create uo_status
this.Control[]={this.uo_status}
end on

on tabpage_status.destroy
destroy(this.uo_status)
end on

type uo_status from pfc_cst_u_apptmnt_status_back_from_comm within tabpage_status
event destroy ( )
integer width = 3515
integer height = 2060
integer taborder = 20
boolean bringtotop = true
boolean border = false
end type

on uo_status.destroy
call pfc_cst_u_apptmnt_status_back_from_comm::destroy
end on

type cb_1 from u_cb within w_back_from_committee
integer x = 2871
integer y = 2216
integer height = 84
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Ok"
boolean default = true
end type

event clicked;Integer li_retval

li_retval = Parent.Event pfc_save()

IF li_retval = 0 THEN
	MessageBox("No Changes Made", "No changes made to the record.  A change must be made to this record for it to save.~rUse the cancel button to close window.")
	Return 1
ELSEIF  li_retval < 0 THEN
	Return 1
END IF
CloseWithReturn( Parent, "Ok" )
end event

type cb_2 from u_cb within w_back_from_committee
integer x = 3264
integer y = 2216
integer height = 84
integer taborder = 20
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

