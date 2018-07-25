$PBExportHeader$w_batch_add_oppe.srw
forward
global type w_batch_add_oppe from window
end type
type dw_appt from datawindow within w_batch_add_oppe
end type
type cb_6 from commandbutton within w_batch_add_oppe
end type
type dw_profile from datawindow within w_batch_add_oppe
end type
type cb_5 from commandbutton within w_batch_add_oppe
end type
type cb_remove from commandbutton within w_batch_add_oppe
end type
type cb_prac from commandbutton within w_batch_add_oppe
end type
type cb_batch from commandbutton within w_batch_add_oppe
end type
type dw_detail from u_dw within w_batch_add_oppe
end type
type cb_close from commandbutton within w_batch_add_oppe
end type
type cb_add from commandbutton within w_batch_add_oppe
end type
type dw_pracs from datawindow within w_batch_add_oppe
end type
end forward

global type w_batch_add_oppe from window
integer x = 46
integer y = 176
integer width = 3950
integer height = 1640
boolean titlebar = true
string title = "Staff Category Batch Update"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
dw_appt dw_appt
cb_6 cb_6
dw_profile dw_profile
cb_5 cb_5
cb_remove cb_remove
cb_prac cb_prac
cb_batch cb_batch
dw_detail dw_detail
cb_close cb_close
cb_add cb_add
dw_pracs dw_pracs
end type
global w_batch_add_oppe w_batch_add_oppe

type variables
integer ii_facil
integer ii_status = 20
long il_pracs[]
end variables

on w_batch_add_oppe.create
this.dw_appt=create dw_appt
this.cb_6=create cb_6
this.dw_profile=create dw_profile
this.cb_5=create cb_5
this.cb_remove=create cb_remove
this.cb_prac=create cb_prac
this.cb_batch=create cb_batch
this.dw_detail=create dw_detail
this.cb_close=create cb_close
this.cb_add=create cb_add
this.dw_pracs=create dw_pracs
this.Control[]={this.dw_appt,&
this.cb_6,&
this.dw_profile,&
this.cb_5,&
this.cb_remove,&
this.cb_prac,&
this.cb_batch,&
this.dw_detail,&
this.cb_close,&
this.cb_add,&
this.dw_pracs}
end on

on w_batch_add_oppe.destroy
destroy(this.dw_appt)
destroy(this.cb_6)
destroy(this.dw_profile)
destroy(this.cb_5)
destroy(this.cb_remove)
destroy(this.cb_prac)
destroy(this.cb_batch)
destroy(this.dw_detail)
destroy(this.cb_close)
destroy(this.cb_add)
destroy(this.dw_pracs)
end on

event open;long ll_batch_id
long ll_pracs[]
integer ic
integer i
integer li_type
long p
string errors
datawindowchild dwchild
integer li_facility_id
gs_batch_search lst_sent


end event

type dw_appt from datawindow within w_batch_add_oppe
boolean visible = false
integer x = 2528
integer y = 1552
integer width = 288
integer height = 172
integer taborder = 90
string title = "none"
string dataobject = "d_affil_for_oppe_batch"
boolean livescroll = true
end type

type cb_6 from commandbutton within w_batch_add_oppe
boolean visible = false
integer x = 3369
integer y = 144
integer width = 485
integer height = 92
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Migrate Profile data"
end type

type dw_profile from datawindow within w_batch_add_oppe
boolean visible = false
integer x = 1920
integer y = 152
integer width = 1390
integer height = 84
integer taborder = 110
string title = "none"
boolean border = false
boolean livescroll = true
end type

type cb_5 from commandbutton within w_batch_add_oppe
boolean visible = false
integer x = 1403
integer y = 140
integer width = 485
integer height = 92
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add QA Profile"
end type

type cb_remove from commandbutton within w_batch_add_oppe
integer x = 1897
integer y = 36
integer width = 485
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Remove Practitioner"
end type

event clicked;Integer li_ans

li_ans = MessageBox("Delete", "Are you sure you want to remove this provider?", Question!, YesNo!, 1 )
IF li_ans = 1 THEN
	dw_pracs.DeleteRow( 0 )
END IF
end event

type cb_prac from commandbutton within w_batch_add_oppe
integer x = 1399
integer y = 36
integer width = 485
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select Practitioner"
end type

event clicked;Integer li_nr
Integer li_find
long li_prac_id
String ls_full_name
integer i
integer ic
gs_batch_search ist_search

gs_search lstr_search

lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "REPORTS" + String(dw_detail.GetItemNumber( dw_Detail.GetRow(), "facility"))

OpenWithParm( w_extended_search_new , lstr_search )

IF Message.DoubleParm = -1 THEN
	Return -1
END IF

ist_search = message.powerobjectparm

if not isvalid(message.powerobjectparm) then return 0


ic = upperbound(ist_search.li_prac_id[])
for i = 1 to ic
	li_prac_id = ist_search.li_prac_id[i]
	select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;

	li_find = dw_pracs.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	
	IF li_find > 0 THEN
		MessageBox("Select Error", "You have already selected "  + ls_full_name +  ".  Please reselect." )
		Return -1
	END IF
	
	li_nr = dw_pracs.InsertRow( 0 )
	
	dw_pracs.SetItem( li_nr, "prac_id", li_prac_id )
	//messagebox("", li_prac_id )
	dw_pracs.SetItem( li_nr, "full_name", ls_full_name )
	
next

dw_detail.SetFocus( )
end event

type cb_batch from commandbutton within w_batch_add_oppe
integer x = 905
integer y = 36
integer width = 485
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select Batch"
end type

event clicked;long i
long ic
long li_prac_id
long li_find
long li_nr
string ls_full_name
gs_batch_search ist_search

openwithparm(w_batch_prac_select_new,"R")

if message.stringparm = "Cancel" then 
	return
else
	if not isvalid(message.powerobjectparm) then return 
end if

ist_search = message.powerobjectparm

ic = upperbound(ist_search.li_prac_id[])
for i = 1 to ic
	li_prac_id = ist_search.li_prac_id[i] 
	select full_name into :ls_full_name from v_full_name where prac_id = :li_prac_id;
	
	li_find = dw_pracs.Find( "prac_id = " + String( li_prac_id ), 1, 1000 )
	

	IF li_find > 0 THEN
		//if found - skip
	ELSE
		li_nr = dw_pracs.InsertRow( 0 )
		
		dw_pracs.SetItem( li_nr, "prac_id", li_prac_id )
		dw_pracs.SetItem( li_nr, "full_name", ls_full_name )
	End if

next


return 1
end event

type dw_detail from u_dw within w_batch_add_oppe
integer x = 901
integer y = 252
integer width = 2958
integer height = 1236
integer taborder = 80
string title = "Staff Category"
string dataobject = "d_oppe_batch_add"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;Long nulllong
DatawindowChild dwchild

this.settransobject(sqlca)
this.insertrow(1)

//This.GetChild( "department", dwchild )
//dwchild.SetTransObject( SQLCA )
//gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('department') + "'", dwchild)
//dwchild.InsertRow( 1 )
//dwchild.SetItem( 1, "lookup_code", nulllong )

This.GetChild( "specialty", dwchild )
dwchild.SetTransObject( SQLCA )
gnv_data.of_set_dwchild_fromcache("code_lookup" , "upper(lookup_name) = '" + upper('practitioner Specialties') + "'", dwchild)
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "lookup_code", nulllong )

this.setitem(1,"oppe_fppe", "OPPE")
this.setitem(1,"active_status", 1)
this.setitem(1,"current_status", -350)

this.of_SetDropDownCalendar( TRUE )
end event

event dberror;//Overide - alfee 09.16.2009

string	ls_message

ls_message = " A database error has occurred." + &
             " Database error code:  " + String (sqldbcode)  + &
	           " Database error message:" + sqlerrtext  + "~r~n Data Object: " + string(dataobject)

MessageBox(gnv_app.iapp_object.DisplayName, ls_message, StopSign!, Ok!, 1)

return 1
end event

type cb_close from commandbutton within w_batch_add_oppe
integer x = 3365
integer y = 28
integer width = 485
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type cb_add from commandbutton within w_batch_add_oppe
integer x = 905
integer y = 140
integer width = 485
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add OPPE"
end type

event clicked;//Start Code Change ----05.12.2011 #V11 maha - added
long ll_facility
long r
long rc
long cnt
long ll_prac
long ll_pracs[]
long ll_curr
datetime ld_from
datetime ld_to
string ls_name
Long ll_hdr_id

dw_detail.accepttext( )
ll_facility = dw_detail.getitemnumber(1,"facility_id")
ld_from = dw_detail.getitemdatetime(1,"from_date")
ld_to = dw_detail.getitemdatetime(1,"to_date")

//check for required fields
if isnull(ll_facility) then 
	messagebox("Required Field","A value is required for the Facility field")
	dw_detail.setfocus( )
	dw_detail.setcolumn( "facility_id")
	return 1
end if

if isnull(ld_from) then 
	messagebox("Required Field","A value is required for the From Date field")
	dw_detail.setfocus( )
	dw_detail.setcolumn("from_date")
	return 1
end if

if isnull(ld_to) then 
	messagebox("Required Field","A value is required for the To Date field")
	dw_detail.setfocus( )
	dw_detail.setcolumn( "to_date")
	return 1
end if

//check affiliations
for r = 1 to dw_pracs.rowcount()
	ll_pracs[r] = dw_pracs.getitemnumber(r,"prac_id")
next

dw_appt.settransobject(sqlca)
rc = dw_appt.retrieve(ll_facility,ll_pracs)
if rc = 0 then 
	messagebox("Batch OPPE","None of the selected providers have current appointments with the selected facility.")
	return
end if

debugbreak()
Select Max(pd_oppe_hdr_id)  Into :ll_hdr_id From pd_oppe_hrd;
IF SQLCA.SQLCode = -1 THEN 
	MessageBox("SQL error", "Failed to update due to: " + SQLCA.SQLErrText)
	RETURN 1	
END IF

if isnull(ll_hdr_id) then ll_hdr_id = 0

//for each practitioner add a record
for r = 1 to dw_pracs.rowcount()
	ll_prac = ll_pracs[r]
	
	rc = dw_appt.find("prac_id = " + string(ll_prac),1,100000)
	
	if rc = 0 then
		ls_name = dw_pracs.getitemstring(r,"full_name")
		messagebox("Batch OPPE","Provider "+ ls_name +" does not have a current appointment with the selected facility.")
		continue
	end if
	
	if r = 1 then
		ll_curr = 1
	else
		dw_detail.rowscopy( 1, 1, primary!,dw_detail,100000, primary!)
		ll_curr = dw_detail.rowcount()
	end if
	
	ll_hdr_id ++
	dw_detail.SetItem(ll_curr, 'pd_oppe_hdr_id', ll_hdr_id)
	dw_detail.setitem(ll_curr,"prac_id",ll_prac)
	cnt++
	
next

rc = dw_detail.update()

if rc < 1 then
	rollback using sqlca;
	messagebox("Batch Add","Update Failed")
else
	messagebox("Records added",dw_detail.rowcount())
end if

end event

type dw_pracs from datawindow within w_batch_add_oppe
integer x = 5
integer y = 40
integer width = 841
integer height = 1448
integer taborder = 70
boolean titlebar = true
string title = "Provider List"
string dataobject = "d_practitioner_list"
boolean livescroll = true
end type

event clicked;integer r

r  = this.getclickedrow()
if r < 1 then return

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

//il_prac = this.getitemnumber(r,"prac_id")
////dw_browse.settransobject(sqlca)
////dw_browse.retrieve(il_prac,ii_facil)
//of_retrieve_data(is_ret_type)
end event

event retrieveend;//debugbreak()
//if this.rowcount() > 0 then
//	//this.selectrow(0,false)
//	//this.selectrow(1,true)
//	il_prac = this.getitemnumber(1,"prac_id")
//	//of_retrieve_data("R")
//	//messagebox("rc",string(dw_browse.rowcount()))
//	dw_browse.setredraw(true)
//end if
end event

event rowfocuschanged;
//debugbreak()

end event

