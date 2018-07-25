$PBExportHeader$w_add_appointment.srw
forward
global type w_add_appointment from w_response
end type
type tab_bfc from tab within w_add_appointment
end type
type tabpage_status from userobject within tab_bfc
end type
type uo_status from pfc_cst_u_apptmnt_status_recruit_prac within tabpage_status
end type
type tabpage_status from userobject within tab_bfc
uo_status uo_status
end type
type tab_bfc from tab within w_add_appointment
tabpage_status tabpage_status
end type
type cb_1 from u_cb within w_add_appointment
end type
type cb_cancel from u_cb within w_add_appointment
end type
end forward

global type w_add_appointment from w_response
integer x = 347
integer y = 32
integer width = 3534
integer height = 2224
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
tab_bfc tab_bfc
cb_1 cb_1
cb_cancel cb_cancel
end type
global w_add_appointment w_add_appointment

type variables
String is_opened_for
boolean ib_new_prac

long il_prac_id //long.zhang 11.06.2013 BugA110508
end variables

on w_add_appointment.create
int iCurrent
call super::create
this.tab_bfc=create tab_bfc
this.cb_1=create cb_1
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_bfc
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_cancel
end on

on w_add_appointment.destroy
call super::destroy
destroy(this.tab_bfc)
destroy(this.cb_1)
destroy(this.cb_cancel)
end on

event open;call super::open;String ls_name

tab_bfc.tabpage_status.uo_status.of_setup_dw() //maha 082201
tab_bfc.tabpage_status.uo_status.of_set_select_facility_invisible( False )

tab_bfc.tabpage_status.uo_status.of_bg_color( gl_bg_color )   //Start Code Change ----12.08.2015 #V15 maha

//-------------appeon begin----------------------
//<$>Modified:long.zhang 11.06.2013
//<$>reason:V14.1 Recruitment Functionality  BugA110508 
//tab_bfc.tabpage_status.uo_status.of_set_prac_id( gl_prac_id )
//tab_bfc.tabpage_status.uo_status.of_set_parent_facility_id( gl_facility_id )
//
//is_opened_for = gs_param
////tab_bfc.tabpage_status.uo_status.of_set_parent_window( this)
//tab_bfc.tabpage_status.uo_status.of_new_record( gl_prac_id)

tab_bfc.tabpage_status.uo_status.of_set_prac_id( il_prac_id )
tab_bfc.tabpage_status.uo_status.of_set_parent_facility_id( 0 )
is_opened_for = 'NEWPRAC'
tab_bfc.tabpage_status.uo_status.of_new_record( il_prac_id)
//-------------appeon End------------------------

tab_bfc.tabpage_status.uo_status.of_set_new_prac( true)


IF is_opened_for <> "REAPP" THEN
	tab_bfc.tabpage_status.uo_status.of_set_comm_protected( )
elseif 	is_opened_for = 'NEWPRAC' then	//do nothing
//	this.tab_bfc.uo_status.tab_1.
else // reappointment process  //maha 123002 to allow data to save without any changes being made.
	tab_bfc.tabpage_status.uo_status.tab_view.tabpage_detail_1.dw_apptmnt_status.SetItemStatus (1, 0,primary!, datamodified! ) 
END IF

nv_prac_info lnv_full_name
lnv_full_name = CREATE nv_prac_info
//ls_name = lnv_full_name.of_get_name( gl_prac_id )
ls_name = lnv_full_name.of_get_name( il_prac_id )	//long.zhang 11.06.2013 BugA110508
DESTROY lnv_full_name	

This.Title = This.Title + "  (" + ls_name + ")"

end event

event pfc_preupdate;call super::pfc_preupdate;//IF is_opened_for <> "REAPP" THEN
//	IF tab_bfc.tabpage_status.uo_status.of_back_from_commit_rqrd_flds() = -1  THEN
//		Return -1
//	END IF
//END IF

Return 1
end event

event closequery;//overwriting pfc code to prevent asking Do you want to save changes during recred process //maha 011403
end event

event pfc_preopen;call super::pfc_preopen;il_prac_id = Message.doubleparm		//long.zhang 11.06.2013 BugA110508
end event

type tab_bfc from tab within w_add_appointment
integer x = 18
integer width = 3589
integer height = 2028
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
tabposition tabposition = tabsonright!
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
integer y = 16
integer width = 3456
integer height = 1996
long backcolor = 32891346
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

type uo_status from pfc_cst_u_apptmnt_status_recruit_prac within tabpage_status
event destroy ( )
integer width = 3552
integer height = 1996
integer taborder = 21
end type

on uo_status.destroy
call pfc_cst_u_apptmnt_status_recruit_prac::destroy
end on

type cb_1 from u_cb within w_add_appointment
integer x = 2747
integer y = 2068
integer height = 84
integer taborder = 30
boolean bringtotop = true
string text = "Ok"
boolean default = true
end type

event clicked;Integer li_retval
//tab_bfc.tabpage_status.uo_status.ib_new_prac = false
li_retval = Parent.Event pfc_save()

IF li_retval = 0 THEN
	MessageBox("No Changes Made", "No changes made to the record.  A change must be made to this record for it to save.~rUse the cancel button to close window.")
	Return 1
ELSEIF  li_retval < 0 THEN
	Return 1
END IF
CloseWithReturn( Parent, "Ok" )
end event

type cb_cancel from u_cb within w_add_appointment
integer x = 3118
integer y = 2068
integer height = 84
integer taborder = 20
boolean bringtotop = true
string text = "Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent, "Cancel" )
end event

