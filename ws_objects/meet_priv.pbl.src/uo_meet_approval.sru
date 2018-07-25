$PBExportHeader$uo_meet_approval.sru
forward
global type uo_meet_approval from userobject
end type
type gb_hide from groupbox within uo_meet_approval
end type
type cbx_final from checkbox within uo_meet_approval
end type
type cb_clear from commandbutton within uo_meet_approval
end type
type dw_pracs from u_dw within uo_meet_approval
end type
type cb_approve from commandbutton within uo_meet_approval
end type
type dw_dates from u_dw within uo_meet_approval
end type
type cbx_privs from checkbox within uo_meet_approval
end type
type cbx_let from checkbox within uo_meet_approval
end type
type dw_letter from datawindow within uo_meet_approval
end type
type dw_meeting from datawindow within uo_meet_approval
end type
type rb_rec from radiobutton within uo_meet_approval
end type
type rb_not from radiobutton within uo_meet_approval
end type
type rb_table from radiobutton within uo_meet_approval
end type
type rb_blank from radiobutton within uo_meet_approval
end type
type rb_all from radiobutton within uo_meet_approval
end type
type gb_1 from groupbox within uo_meet_approval
end type
type gb_2 from groupbox within uo_meet_approval
end type
end forward

global type uo_meet_approval from userobject
integer width = 3497
integer height = 1808
long backcolor = 33551856
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_hide gb_hide
cbx_final cbx_final
cb_clear cb_clear
dw_pracs dw_pracs
cb_approve cb_approve
dw_dates dw_dates
cbx_privs cbx_privs
cbx_let cbx_let
dw_letter dw_letter
dw_meeting dw_meeting
rb_rec rb_rec
rb_not rb_not
rb_table rb_table
rb_blank rb_blank
rb_all rb_all
gb_1 gb_1
gb_2 gb_2
end type
global uo_meet_approval uo_meet_approval

type variables
long il_prac
long il_facility
long il_apprcode
long il_meeting
long il_meet_pass
n_cst_datetime inv_datetime
string is_name
end variables

forward prototypes
public function integer of_filter_records (integer ai_type)
public function integer of_get_pracs ()
public function integer of_set_one ()
end prototypes

public function integer of_filter_records (integer ai_type);string ls_val
integer res

choose case ai_type
	case 0 //all
		ls_val = ""
	case 1 //recommend
		ls_val = "rec_stat = 1"
	case 2 //not rec
		ls_val = "rec_stat = 2"
	case 3 //table
		ls_val = "rec_stat = 3"
	case 4 //clear
		ls_val = " isnull(rec_stat ) or rec_stat = 4 or rec_stat = 0"
end choose

res = dw_pracs.setfilter(ls_val)

if res < 1 then messagebox(ls_val,"Filter failed")

dw_pracs.filter()

return 1
end function

public function integer of_get_pracs ();dw_pracs.retrieve(il_meeting)

return 1
end function

public function integer of_set_one ();//Start Code Change ----11.29.2011 #V12 maha -  used to set and retrieve meeting header when opened from meetings
integer r
il_meeting = il_meet_pass
dw_meeting.dataobject = "d_meeting_header_one"
dw_meeting.settransobject(sqlca)
r = dw_meeting.retrieve (il_meeting)

//Start Code Change ----04.20.2012 #V12 maha
if r > 0 then
	il_facility = dw_meeting.getitemnumber(1,"facility")
end if
//End Code Change ----04.20.2012

return 1
end function

on uo_meet_approval.create
this.gb_hide=create gb_hide
this.cbx_final=create cbx_final
this.cb_clear=create cb_clear
this.dw_pracs=create dw_pracs
this.cb_approve=create cb_approve
this.dw_dates=create dw_dates
this.cbx_privs=create cbx_privs
this.cbx_let=create cbx_let
this.dw_letter=create dw_letter
this.dw_meeting=create dw_meeting
this.rb_rec=create rb_rec
this.rb_not=create rb_not
this.rb_table=create rb_table
this.rb_blank=create rb_blank
this.rb_all=create rb_all
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.gb_hide,&
this.cbx_final,&
this.cb_clear,&
this.dw_pracs,&
this.cb_approve,&
this.dw_dates,&
this.cbx_privs,&
this.cbx_let,&
this.dw_letter,&
this.dw_meeting,&
this.rb_rec,&
this.rb_not,&
this.rb_table,&
this.rb_blank,&
this.rb_all,&
this.gb_1,&
this.gb_2}
end on

on uo_meet_approval.destroy
destroy(this.gb_hide)
destroy(this.cbx_final)
destroy(this.cb_clear)
destroy(this.dw_pracs)
destroy(this.cb_approve)
destroy(this.dw_dates)
destroy(this.cbx_privs)
destroy(this.cbx_let)
destroy(this.dw_letter)
destroy(this.dw_meeting)
destroy(this.rb_rec)
destroy(this.rb_not)
destroy(this.rb_table)
destroy(this.rb_blank)
destroy(this.rb_all)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event constructor;il_meet_pass = message.doubleparm
end event

type gb_hide from groupbox within uo_meet_approval
integer x = 1376
integer y = 608
integer width = 2034
integer height = 804
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
end type

type cbx_final from checkbox within uo_meet_approval
integer x = 1422
integer y = 536
integer width = 434
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Final Approval"
end type

event clicked;if this.checked then 
	gb_hide.visible = false
else
	gb_hide.visible = true
end if
end event

type cb_clear from commandbutton within uo_meet_approval
integer x = 2331
integer y = 56
integer width = 713
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Meeting Link"
end type

event clicked;integer res
integer i
long ll_null
datetime ld_null

res = messagebox("Clear Meeting Link","This will clear the connection to the specific meeting and reset the Sent to committee date.  They will no longer appear in this list  Most often used for Tabled Practitioners.  Continue?", question!,Yesno!,2)

if res = 2 then return

setnull(ll_null)
setnull(ld_null)

FOR i = 1 TO dw_pracs.rowcount( )
	IF dw_pracs.GetItemNumber(i, "selected") = 1  THEN 
		dw_pracs.setitem(i,"pd_comm_review_date_back_from_review", ld_null )
		dw_pracs.setitem(i,"pd_comm_review_date_sent_for_review", ld_null )
		dw_pracs.setitem(i,"pd_comm_review_review_results",ll_null )
		dw_pracs.setitem(i,"pd_comm_review_approved_user", "" )
	end if
next

dw_pracs.update()

of_get_pracs( )
end event

type dw_pracs from u_dw within uo_meet_approval
integer x = 27
integer y = 200
integer width = 1317
integer height = 1564
integer taborder = 30
string dataobject = "d_meeting_prac_list_elect"
end type

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)
end event

event constructor;call super::constructor;this.settransobject(sqlca)

end event

event rowfocuschanged;call super::rowfocuschanged;if this.rowcount() = 0  then return

this.selectrow(0,false)
this.selectrow(currentrow,true)

il_prac = this.getitemnumber(currentrow,"prac_id")
end event

event buttonclicked;call super::buttonclicked;//Start Code Change ----05.03.2016 #V15 maha - coded for existing button
integer r
integer li_on

if dwo.name = "b_select" then
	if dwo.text = "Select All" then
		li_on = 1
		dwo.text = "Deselect All"
	else
		li_on = 0
		dwo.text = "Select All"
	end if
	
	for r = 1 to this.rowcount()
		this.setitem(r,"selected", li_on)	
	next
end if

		
	
end event

type cb_approve from commandbutton within uo_meet_approval
integer x = 1563
integer y = 56
integer width = 750
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Approve Selected Practitioners"
end type

event clicked;//Start Code Change ----01.09.2012 #V12 maha - code button- copied from various other functions

string ls_batch_info
integer li_prov
datetime ldt_nulldate
long ll_code
Integer i      
Integer li_rc
Integer num_selected
integer li_active
integer li_nr
integer cnt
integer li_years //maha 09.30.2014
long ll_prac_id
long ll_facility_id
Long ll_seq_no
long ll_rec_id
long ll_recids[]
string ls_letter_name
long ll_prac_corro
string ls_doc_id
n_ds lds_verif_rec
n_ds lds_appointment
LONG ll_verif_info_row
date dt_rdate
date dt_sdate
date dt_edate
date dt_pstart
date dt_pend
integer li_cnt


ll_code = il_apprcode

dw_dates.accepttext() //Start Code Change ---- 10.11.2007 #V7 maha

dt_rdate =  dw_dates.getItemDate(1,'returned_from_comm')  //(em_return.text)
dt_sdate = dw_dates.getItemDate(1,'app_from') //date(em_from.text)
dt_edate = dw_dates.getItemDate(1,'app_to') //date(em_to.text)
dt_pstart = dw_dates.getItemDate(1,'prov_from') //date(em_prov_from.text)
dt_pend = dw_dates.getItemDate(1,'prov_to') //date(em_prov_to.text)

li_prov =  dw_dates.GetItemNumber(1,'prov_app')
if isnull(li_prov) then li_prov = 0

if isnull (dt_rdate) then
	messagebox("Return Date","You must have a Returned from Committee date")
	return
end if

//appointment checks
if cbx_final.checked then
	if isnull (dt_sdate) then
		messagebox("Appointment Start Date","You must have an Appointment Start Date")
		return
	end if
	if isnull (dt_edate) then
		messagebox("Appointment End Date","You must have a Appointment End Date")
		return
	end if
end if
	

if ll_code < 0 or isnull(ll_code) then
	messagebox("Batch error","You must have an Approval Code")
	return
end if

setnull(ldt_nulldate) 

li_rc = dw_pracs.RowCount( )

IF li_rc = 0 THEN
	num_selected = 0
ELSE 
	FOR i = 1 TO li_rc
		IF dw_pracs.GetItemNumber(i, "selected") = 1  THEN 
			cnt++	//get count for verif recids if checked
		end if
	next
	num_selected = cnt
END IF

IF num_selected = 0 THEN
	MessageBox("Select Error", "No practitioners selected!")	
	Return
END IF

li_active = 1

//set approval values
FOR i = 1 TO li_rc
	IF dw_pracs.GetItemNumber(i, "selected") = 1  THEN 
		ll_recids[upperbound(ll_recids) + 1] = dw_pracs.GetItemNumber(i, "pd_comm_review_rec_id")
		dw_pracs.setitem(i,"pd_comm_review_date_back_from_review", datetime(dt_rdate, now() ) )
		dw_pracs.setitem(i,"pd_comm_review_review_results",ll_code )
		dw_pracs.setitem(i,"pd_comm_review_approved_user", gs_user_id )
	end if
next
debugbreak()
//set appointment 
if cbx_final.checked then
	lds_appointment = CREATE n_ds
	lds_appointment.DataObject = "d_affil_update_from_meeting"
	lds_appointment.of_SetTransObject( SQLCA )
	lds_appointment.retrieve(ll_recids[])
	
	//Start Code Change ----09.30.2014 #V14.2 maha - code for birthday based end dates
	ll_facility_id = lds_appointment.getitemnumber(1,"parent_facility_id") 	
	select appointment_years into :li_years from facility where facility_id = :ll_facility_id; 

	for i = 1 to lds_appointment.rowcount()
		if li_years < 0 then
			ll_prac_id = lds_appointment.GetItemNumber(i, "prac_id")
			dt_edate =	inv_datetime.of_exp_date_birthday( abs(li_years), dt_sdate, ll_prac_id )
		end if
	//End Code Change ----09.30.2014 	
		lds_appointment.setitem(i,"apptmnt_start_date", datetime(dt_sdate, now() ) )
		lds_appointment.setitem(i,"apptmnt_end_date", datetime(dt_edate, now() ) )
		lds_appointment.setitem(i,"init_prov_period_from", datetime(dt_pstart, now() ) )
		lds_appointment.setitem(i,"init_prov_period_to",datetime(dt_pend, now() ) )
		lds_appointment.setitem(i,"prov_status",li_prov)
	next
	
	//letter creation
	if cbx_let.checked then
		ls_letter_name = dw_letter.getitemstring(1, "letter_name")
		if isnull(ls_letter_name) or len(ls_letter_name) = 0 then
			messagebox("Select Letter","You have checked Create Approval Letters, but have not selected a letter.") 
			return 
		end if
	
		lds_verif_rec = CREATE n_ds
		lds_verif_rec.DataObject = "d_ver_summary_record_view"
		lds_verif_rec.of_SetTransObject( SQLCA )
		
		//get method
		ll_prac_corro = long(gnv_data.of_getitem("code_lookup","lookup_code","upper(description) = upper('Practitioner Correspondence')" ))
		
		//set rec_id
		ll_rec_id = gnv_app.of_get_id( "RECORD_ID" , cnt ) - 1
		
		FOR i = 1 TO li_rc
			IF dw_pracs.GetItemNumber(i, "selected") = 0  THEN
				continue
			else 
				li_nr = lds_verif_rec.InsertRow( 0 )
				ll_prac_id = dw_pracs.GetItemNumber(i, "prac_id")
				ll_facility_id = dw_pracs.GetItemNumber(i, "facility_id")
				ll_seq_no = 1
				ll_rec_id ++
		
				lds_verif_rec.SetItem( li_nr, "reference_value", ls_letter_name )
				lds_verif_rec.SetItem( li_nr , "rec_id", ll_rec_id )
				lds_verif_rec.SetItem( li_nr , "seq_no", ll_seq_no )
				lds_verif_rec.SetItem( li_nr, "screen_id", 1 )			
				lds_verif_rec.SetItem( li_nr, "prac_id",  ll_prac_id )			
				lds_verif_rec.SetItem( li_nr, "verif_info_facility_id", ll_facility_id )			
				lds_verif_rec.SetItem( li_nr, "priority_user", "PUBLIC" )
				lds_verif_rec.SetItem( li_nr, "priority", 2 )
				lds_verif_rec.SetItem( li_nr, "verification_method", ll_prac_corro )
				lds_verif_rec.SetItem( li_nr, "active_status", 1 )
				lds_verif_rec.SetItem( li_nr, "print_flag", 1)
				ls_doc_id = String( ll_rec_id ) + "-" + String( ll_prac_id ) + "-" + String( ll_facility_id ) + "-" + String( ll_seq_no )
				lds_verif_rec.SetItem( li_nr, "doc_id", ls_doc_id )		
				lds_verif_rec.SetItem( li_nr, "exp_credential_flag", 0 )			
			END IF
		END FOR
		
	end if //letter creation	
	
	//do privileges
	if cbx_privs.checked then
		long prac[]
		long app[]
		integer facil[]
		gs_batch_search lst_sent
	
		app[1] = 1 //reappoint
		
		facil[1] = dw_pracs.GetItemNumber(1, "facility_id")
	    li_cnt = 0
		FOR i = 1 TO li_rc
			IF dw_pracs.GetItemNumber(i, "selected") = 1  THEN
				//------------------- APPEON BEGIN -------------------
				//$<modify> Stephen 04.26.2012
				//$<reason> Electronic Meeting, Privilege Update to Granted -Alpha id 3055
				/*
				prac[i] = dw_pracs.GetItemNumber(i, "prac_id")
				*/
				li_cnt += 1
				prac[li_cnt] = dw_pracs.GetItemNumber(i, "prac_id")
				//------------------- APPEON END -------------------
			end if
		next
		lst_sent.li_prac_id[] = prac[]
		lst_sent.ll_app[] = app[]
		lst_sent.ll_facility[] = facil[]
		
		openwithparm(w_batch_privilege_update,lst_sent)
	end if //privileges

end if



//letter creation
if cbx_let.checked then  //Start Code Change ----03.23.2012 #V12 maha - error trap
	IF lds_verif_rec.Update() = -1 THEN
		MessageBox("Update Error Approval letters", SQLCA.SQLERRTEXT )
	else
		//MessageBox("Approval letters","The Approval Letter Action Items have been created, and can be run using the Practitioner Correspondence filter")
	END IF
end if

if cbx_final.checked then
	if lds_appointment.update() = -1 THEN
		MessageBox("Update Error Appointmenr records", SQLCA.SQLERRTEXT )
	else
		//nothing
	end if
end if

dw_pracs.update()
	
if isvalid(lds_verif_rec) then DESTROY lds_verif_rec
if isvalid(lds_appointment) then DESTROY lds_appointment

//re-retrieve pracs
of_get_pracs( )


end event

type dw_dates from u_dw within uo_meet_approval
integer x = 1710
integer y = 472
integer width = 1682
integer height = 692
integer taborder = 20
string dataobject = "d_ext_comm_batch_update"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;datawindowchild dwchild


this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("app_from", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("app_to", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("prov_from", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("prov_to", this.iuo_calendar.DDLB_WITHARROW	)
this.iuo_calendar.of_Register("returned_from_comm", this.iuo_calendar.DDLB_WITHARROW	)





insertrow(0)

this.getchild('approval_code',dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve('approval code')
end event

event itemchanged;call super::itemchanged;//datetime ldt
date ldt //Alfee 11.06.2008
integer li_years //maha 03.3.2010

choose case dwo.name
	case 'app_from'		
		//-------Begin Modified by Alfee 11.06.2008 ------------------------	
		//<$Reason>Keep same logic with that on Appointment Status screen
		/* ldt = inv_datetime.of_RelativeDateTime ( datetime(date(data),now()), 63072000 )//1900-01-01
		if pos('1/1/1900' ,string(ldt)) < 1 then
			setitem(1,'app_to',date(ldt))			
		end if  */	
		//Start Code Change ----0303.2010 #V10 maha - set the end based on the facility setting.
		if il_facility = -1 then //if records for multiple facilities are selected use the default 2 years
			li_years = 2
		else
			select appointment_years into :li_years from facility where facility_id = :il_facility;
		end if
		
		if li_years > 0 then //if the setting is 0 do not set the end years
			ldt = inv_datetime.of_relativeyear (date(data), li_years ) //changed from the hard coded 2
			ldt = RelativeDate(ldt, -1 )
			if PosA('1/1/1900' ,string(ldt)) < 1 then
				setitem(1,'app_to',ldt)			
			end if  
		end if
		//End Code Change---03.03.2010
		//--------End Modified ---------------------------------------------				
	case 'approval_code'
			il_apprcode = long(data)
	case else 
end choose 
end event

event itemerror;//override - Alfee 11.06.2008
end event

type cbx_privs from checkbox within uo_meet_approval
integer x = 1445
integer y = 1292
integer width = 910
integer height = 72
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Update Requested Privileges"
end type

type cbx_let from checkbox within uo_meet_approval
integer x = 1445
integer y = 1184
integer width = 645
integer height = 76
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Create Approval Letters"
end type

type dw_letter from datawindow within uo_meet_approval
integer x = 2121
integer y = 1184
integer width = 1221
integer height = 84
integer taborder = 20
string dataobject = "d_letter_selection"
boolean border = false
boolean livescroll = true
end type

event itemchanged;is_name = data

//messagebox("",is_name)
end event

event constructor;this.settransobject( sqlca)
this.retrieve()
this.insertrow(1)
end event

type dw_meeting from datawindow within uo_meet_approval
integer x = 27
integer y = 12
integer width = 1312
integer height = 180
integer taborder = 10
string title = "none"
string dataobject = "d_meeting_header_one"
boolean livescroll = true
end type

type rb_rec from radiobutton within uo_meet_approval
integer x = 1682
integer y = 252
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Recommend"
end type

event clicked;of_filter_records(1)
end event

type rb_not from radiobutton within uo_meet_approval
integer x = 2171
integer y = 252
integer width = 471
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Not Recommend"
end type

event clicked;//of_filter_records(3)
of_filter_records(2)	//long.zhang 05.03.2012
end event

type rb_table from radiobutton within uo_meet_approval
integer x = 2720
integer y = 252
integer width = 293
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Table"
end type

event clicked;//of_filter_records(2)
of_filter_records(3)	//long.zhang 05.03.2012
end event

type rb_blank from radiobutton within uo_meet_approval
integer x = 3077
integer y = 252
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Blank"
end type

event clicked;of_filter_records(4)
end event

type rb_all from radiobutton within uo_meet_approval
integer x = 1440
integer y = 252
integer width = 174
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "All"
boolean checked = true
end type

event clicked;of_filter_records(0)
end event

type gb_1 from groupbox within uo_meet_approval
integer x = 1376
integer y = 380
integer width = 2039
integer height = 1032
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Approval Settings"
end type

type gb_2 from groupbox within uo_meet_approval
integer x = 1362
integer y = 180
integer width = 2053
integer height = 196
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Filter"
end type

