$PBExportHeader$w_add_missing_appointment.srw
forward
global type w_add_missing_appointment from window
end type
type st_1 from statictext within w_add_missing_appointment
end type
type cb_2 from commandbutton within w_add_missing_appointment
end type
type cb_1 from commandbutton within w_add_missing_appointment
end type
type dw_1 from datawindow within w_add_missing_appointment
end type
end forward

global type w_add_missing_appointment from window
integer width = 2693
integer height = 800
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_add_missing_appointment w_add_missing_appointment

type variables
long il_prac
end variables

on w_add_missing_appointment.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_1}
end on

on w_add_missing_appointment.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;datawindowchild dwchild

dw_1.insertrow(1)

dw_1.settransobject(sqlca) //maha 082201
dw_1.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

dw_1.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)
//
dw_1.GetChild( "priority_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//added by leiwei 03.22.2006
dw_1.GetChild( "application_audit_facility", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
//added by leiwei 03.22.2006
dw_1.GetChild( "affiliation_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

il_prac = message.doubleparm

dw_1.setitem(1,"prac_id", il_prac)
dw_1.setitem(1,"active_status", 4)



end event

type st_1 from statictext within w_add_missing_appointment
integer x = 59
integer y = 28
integer width = 2578
integer height = 124
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Note: This will add only the Appointment record.  Committees, Checklist items etc  must be added manually in the provider record."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_add_missing_appointment
integer x = 1486
integer y = 644
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_1 from commandbutton within w_add_missing_appointment
integer x = 1033
integer y = 644
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;long ll_rec_id

if isnull(dw_1.getitemnumber(1,"parent_facility_id")) or dw_1.getitemnumber(1,"parent_facility_id") = 0 then
	messagebox("Missing Data","Parent facility required")
	return
end if

if isnull(dw_1.getitemnumber(1,"verifying_facility")) or dw_1.getitemnumber(1,"verifying_facility") = 0 then
	messagebox("Missing Data","Verifying facility required")
	return
end if

if isnull(dw_1.getitemstring(1,"affiliation_status")) or dw_1.getitemstring(1,"affiliation_status") = '' then
	messagebox("Missing Data","Affiliation status required")
	return
end if

if isnull(dw_1.getitemstring(1,"apptmnt_type")) or dw_1.getitemstring(1,"apptmnt_type") = '' then
	messagebox("Missing Data","Appointment type required")
	return
end if

if isnull(dw_1.getitemnumber(1,"rec_id")) then
	ll_rec_id = gnv_app.of_get_id( "RECORD_ID" )
	dw_1.setitem(1,"rec_id",ll_rec_id)
end if

dw_1.setitem(1,"seq_no",1)

if dw_1.update() < 1 then return

closewithreturn(parent,"OK")
end event

type dw_1 from datawindow within w_add_missing_appointment
integer x = 14
integer y = 184
integer width = 2647
integer height = 424
integer taborder = 10
string title = "none"
string dataobject = "d_affil_stat_add_missing"
boolean livescroll = true
end type

event itemchanged;integer li_dat
integer li_dvf
integer li_userdef
long li_facility_id
string ls_atype
string ls_affilstat


if dwo.name = "parent_facility_id" then
	SELECT default_audit_temp, default_verif_facility,default_appt_type,default_affil_status, default_user INTO :li_dat, :li_dvf, :ls_atype, :ls_affilstat,:li_userdef FROM facility WHERE facility_id = :li_facility_id;
	This.SetItem( row, "application_audit_facility", li_dat )
	This.SetItem( row, "verifying_facility", li_dvf )

	if isnull( ls_atype) or  ls_atype = "" then  ls_atype = "I"
		
	ls_atype = trim(ls_atype)  	
	ls_affilstat = trim(ls_affilstat) 
		
	if isnull(This.getItemstring( row, "apptmnt_type" )) then 	This.SetItem( row, "apptmnt_type", ls_atype )
	This.SetItem( row, "affiliation_status", ls_affilstat )
	
	if li_userdef = 1 then
		This.SetItem( row, "priority_user", gs_user_id )
	else
		This.SetItem( row, "priority_user", "Public" )
	end if

END IF
end event

