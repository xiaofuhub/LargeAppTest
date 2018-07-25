$PBExportHeader$w_prac_add_from_entity.srw
forward
global type w_prac_add_from_entity from w_response
end type
type dw_cl from datawindow within w_prac_add_from_entity
end type
type dw_comm_review from u_dw within w_prac_add_from_entity
end type
type dw_add from u_dw within w_prac_add_from_entity
end type
type cb_ok from commandbutton within w_prac_add_from_entity
end type
type cb_close from commandbutton within w_prac_add_from_entity
end type
type dw_ent from datawindow within w_prac_add_from_entity
end type
type dw_prac from u_dw within w_prac_add_from_entity
end type
type dw_link from u_dw within w_prac_add_from_entity
end type
type dw_appoint from u_dw within w_prac_add_from_entity
end type
end forward

global type w_prac_add_from_entity from w_response
integer x = 214
integer y = 221
integer width = 3922
integer height = 1800
long backcolor = 33551856
dw_cl dw_cl
dw_comm_review dw_comm_review
dw_add dw_add
cb_ok cb_ok
cb_close cb_close
dw_ent dw_ent
dw_prac dw_prac
dw_link dw_link
dw_appoint dw_appoint
end type
global w_prac_add_from_entity w_prac_add_from_entity

type variables
boolean ib_new = false
long il_parent
long il_ent
long il_prac
long il_addr
long il_appt
pfc_cst_nv_data_entry_functions inv_data_entry

end variables

forward prototypes
public function integer of_add_prac ()
public function integer of_checklist (string as_app_type, long al_template)
end prototypes

public function integer of_add_prac ();//Start Code Change ----11.01.2016 #V153 maha
long ll_rec
string ls_val
long ll_val
datawindowchild dwchild

ib_new = true
//prac
dw_prac.insertrow(1)
dw_prac.setitem(1, "last_name", dw_ent.getitemstring(1, "entity_name") )
//set prac_id
il_prac = gnv_app.of_Get_Id("PRAC_ID")
ll_rec = gnv_app.of_Get_Id("RECORD_ID")
dw_prac.setitem(1, "prac_id", il_prac)
dw_prac.setitem(1, "rec_id", ll_rec)

//address
dw_add.insertrow(1)
dw_add.setitem(1, "street", dw_ent.getitemstring(1, "entity_name") )
dw_add.setitem(1, "street_2", dw_ent.getitemstring(1, "street1") )
dw_add.setitem(1, "suite_apart", dw_ent.getitemstring(1, "suite_apart") )
dw_add.setitem(1, "city", dw_ent.getitemstring(1, "city") )
dw_add.setitem(1, "zip", dw_ent.getitemstring(1, "zip") )
dw_add.setitem(1, "contact_person", dw_ent.getitemstring(1, "contact_name") )
dw_add.setitem(1, "e_mail_address", dw_ent.getitemstring(1, "email_address") )
dw_add.setitem(1, "web_address", dw_ent.getitemstring(1, "web_address") )
dw_add.setitem(1, "phone", dw_ent.getitemstring(1, "phone") )
dw_add.setitem(1, "fax", dw_ent.getitemstring(1, "fax") )
dw_add.setitem(1, "prac_id", il_prac)

dw_add.GetChild( "state", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve("State")
dwchild.insertrow(1)

//state
ll_val = dw_ent.getitemnumber(1, "state_code") 
if isnull(ll_val) then
	ls_val =  dw_ent.getitemstring(1, "state") 
	ls_val = gnv_data.of_getitem("code_lookup", "lookup_code", "code = '" + ls_val + "'")
	ll_val = long(ls_val)
end if

dw_add.setitem(1, "state", ll_val )

//set addr recid
il_addr = gnv_app.of_Get_Id("RECORD_ID")
dw_add.setitem(1, "rec_id", il_addr)

//create addr link
dw_link.insertrow(1)
dw_link.setitem(1, "prac_id", il_prac)
dw_link.setitem(1, "address_id", il_addr)
dw_link.setitem(1, "primary_office", 1)
//facility id set in the itemchanged of the Appointment DW.

//appointment
dw_appoint.insertrow(1)
dw_appoint.setitem(1, "prac_id", il_prac)
il_appt = gnv_app.of_Get_Id("RECORD_ID")
dw_appoint.setitem(1, "rec_id", il_appt)
dw_appoint.setitem(1, "seq_no", 1)






return 1
end function

public function integer of_checklist (string as_app_type, long al_template);//Start Code Change ----12.12.2016 #V153 maha
Long ll_rec_id
Long ll_temp

ll_rec_id = dw_appoint.getitemnumber(1, "rec_id")
ll_temp = al_template

 inv_data_entry.of_app_audit_items_add( il_parent, il_prac, ll_rec_id, ll_temp, "Entity", dw_cl, as_app_type )

return 1


end function

event open;call super::open;//Start Code Change ----11.01.2016 #V153 maha - added copied from w_group_add;  called from entity painter

boolean lb_add = false
string ls_open
gs_pass_ids lst_ids

lst_ids = message.powerobjectparm
il_ent = lst_ids.l_ids[1]
il_prac = lst_ids.l_ids[2]
il_addr = lst_ids.l_ids[3]

if il_ent > 0 then
	il_parent = il_ent
	dw_ent.settransobject(sqlca)
	dw_ent.retrieve(il_ent)
end if


dw_prac.settransobject(sqlca)
dw_add.settransobject(sqlca)
dw_appoint.settransobject(sqlca)
dw_link.settransobject(sqlca)

inv_data_entry = create pfc_cst_nv_data_entry_functions

if il_prac > 0 then
	dw_prac.retrieve(il_prac)
	dw_add.retrieve(il_addr)
	dw_link.visible = false
	dw_appoint.visible = false
	cb_ok.visible = false
	cb_close.text = "Close"
	this.height = dw_add.y + dw_add.height + 150
else
	of_add_prac()
end if


	







end event

on w_prac_add_from_entity.create
int iCurrent
call super::create
this.dw_cl=create dw_cl
this.dw_comm_review=create dw_comm_review
this.dw_add=create dw_add
this.cb_ok=create cb_ok
this.cb_close=create cb_close
this.dw_ent=create dw_ent
this.dw_prac=create dw_prac
this.dw_link=create dw_link
this.dw_appoint=create dw_appoint
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_cl
this.Control[iCurrent+2]=this.dw_comm_review
this.Control[iCurrent+3]=this.dw_add
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_ent
this.Control[iCurrent+7]=this.dw_prac
this.Control[iCurrent+8]=this.dw_link
this.Control[iCurrent+9]=this.dw_appoint
end on

on w_prac_add_from_entity.destroy
call super::destroy
destroy(this.dw_cl)
destroy(this.dw_comm_review)
destroy(this.dw_add)
destroy(this.cb_ok)
destroy(this.cb_close)
destroy(this.dw_ent)
destroy(this.dw_prac)
destroy(this.dw_link)
destroy(this.dw_appoint)
end on

event close;call super::close;destroy inv_data_entry
end event

event closequery;//nothing
end event

type dw_cl from datawindow within w_prac_add_from_entity
boolean visible = false
integer x = 366
integer y = 28
integer width = 233
integer height = 84
integer taborder = 30
boolean enabled = false
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//not used, exists for checklist add only
end event

type dw_comm_review from u_dw within w_prac_add_from_entity
integer x = 3922
integer y = 488
integer width = 1193
integer height = 400
integer taborder = 20
string title = "Provider"
string dataobject = "d_pd_comm_review"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;This.settransobject(sqlca)

end event

type dw_add from u_dw within w_prac_add_from_entity
integer x = 23
integer y = 492
integer width = 3872
integer height = 428
integer taborder = 20
boolean titlebar = true
string title = "Address"
string dataobject = "d_entity_prac_addr_add"
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.30.2009 #V10 maha - copied from group practice screen

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

//End Code Change---10.30.2009

end event

event constructor;call super::constructor;This.settransobject(sqlca)
//This.of_setdropdowncalendar( true )	//added by long.zhang 07.02.2012 v12.2 group location mini-painter
This.post of_setdropdowncalendar( true )	//long.zhang 11.06.2012 Bug 3315
DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
//dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
//dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

this.insertrow(1)
f_modify_group_detail_property(this)//added by long.zhang 07.06.2012 v12.2 group location mini-painter
end event

event itemchanged;call super::itemchanged; //Start Code Change ----08.16.2016 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "LOC", this)
end if
end event

event rbuttondown;call super::rbuttondown;//added by long.zhang 07.05.2012 v12.2 group location mini-painter

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)
col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type cb_ok from commandbutton within w_prac_add_from_entity
integer x = 3127
integer y = 20
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;long ll_rec
long ll_id
integer i
string ls_field
string ls_val
string ls_type
gs_pass_ids lst_ids

dw_add.accepttext()
//debugbreak()
for i = 1 to 1
	choose case i
		case 1
			ls_field = "street"
			ls_type = "C"
	end choose
	
	if ls_type = "C" then
		ls_val = dw_add.getitemstring(1,ls_field)
	else
		ls_val = string(dw_add.getitemnumber(1,ls_field))
	end if
	
	If isnull(ls_val) then
		messagebox("Provider Add","Address data is required in the " + ls_field + " field."  )
		return
	end if
next

for i = 1 to 5
	choose case i
		case 1
			ls_field = "parent_facility_id"
			ls_type = "N"
		case 2
			ls_field = "application_audit_facility"
			ls_type = "N"
		case 3
			ls_field = "verifying_facility"
			ls_type = "N"
		case 4
			ls_field = "apptmnt_type"
			ls_type = "C"
		case 5	
			ls_field = "affiliation_status"
			ls_type = "C"
	end choose
	
	if ls_type = "C" then
		ls_val = dw_appoint.getitemstring(1,ls_field)
	else
		ls_val = string(dw_appoint.getitemnumber(1,ls_field))
	end if
	
	If isnull(ls_val) then
		messagebox("Provider Add","Data is required in the " + ls_field + " field."  )
		return
	end if
next

//messagebox("il_parent", il_parent)
//messagebox("il_prac", il_prac)
//messagebox("il_addr", il_addr)
//messagebox("il_appt", il_appt)
//messagebox("",)

of_checklist(dw_appoint.getitemstring(1,"apptmnt_type"), dw_appoint.getitemnumber(1,"application_audit_facility"))

inv_data_entry.of_field_audit( dw_prac )
dw_prac.update()
inv_data_entry.of_field_audit( dw_appoint )
dw_appoint.update()
inv_data_entry.of_field_audit( dw_add)
dw_add.update()
dw_link.update()
dw_comm_review.update()

lst_ids.l_ids[1] = il_prac
lst_ids.l_ids[2] = il_addr

CloseWithReturn(Parent, lst_ids)

end event

type cb_close from commandbutton within w_prac_add_from_entity
integer x = 3488
integer y = 20
integer width = 343
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent, "Cancel")
end event

type dw_ent from datawindow within w_prac_add_from_entity
boolean visible = false
integer x = 1774
integer y = 20
integer width = 622
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_entity_lookup_detail"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_prac from u_dw within w_prac_add_from_entity
integer x = 23
integer y = 132
integer width = 3872
integer height = 344
integer taborder = 10
boolean titlebar = true
string title = "Provider"
string dataobject = "d_entity_prac_add"
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.30.2009 #V10 maha - copied from group practice screen

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

//End Code Change---10.30.2009

end event

event constructor;call super::constructor;This.settransobject(sqlca)
//This.of_setdropdowncalendar( true )	//added by long.zhang 07.02.2012 v12.2 group location mini-painter
This.post of_setdropdowncalendar( true )	//long.zhang 11.06.2012 Bug 3315
DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
//dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
//dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

this.insertrow(1)
f_modify_group_detail_property(this)//added by long.zhang 07.06.2012 v12.2 group location mini-painter
end event

event itemchanged;call super::itemchanged; //Start Code Change ----08.16.2016 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "LOC", this)
end if
end event

event rbuttondown;call super::rbuttondown;//added by long.zhang 07.05.2012 v12.2 group location mini-painter

integer col
integer ret
datetime dtn
string colname
STRING DT

setnull(dtn)
col = this.getclickedcolumn()
colname = dwo.name

if this.Describe( colname + ".ColType") = "datetime" THEN
	ret = messagebox("Set Null?","Would you like to set this Date to null?",question!,yesno!,2 )
	if ret = 1 then
		this.setitem(row,col,dtn)
	end if
END IF
end event

type dw_link from u_dw within w_prac_add_from_entity
integer x = 23
integer y = 944
integer width = 3872
integer height = 296
integer taborder = 20
boolean titlebar = true
string title = "Address Link"
string dataobject = "d_entity_addr_link"
boolean vscrollbar = false
boolean livescroll = false
end type

event buttonclicked;call super::buttonclicked;//Start Code Change ----10.30.2009 #V10 maha - copied from group practice screen

String	ls_Phone,ls_fax,ls_RetParm

if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	elseif dwo.name = 'b_fax' then
		ls_fax = This.GetItemString(row,'fax')
		if IsNull(ls_fax) then ls_fax = ""
		OpenWithParm(w_phonedetail,"Fax:" + ls_fax)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'fax',ls_RetParm)
		end if
		This.SetColumn('fax')
	end if
end if

//End Code Change---10.30.2009

end event

event constructor;call super::constructor;This.settransobject(sqlca)
//This.of_setdropdowncalendar( true )	//added by long.zhang 07.02.2012 v12.2 group location mini-painter
This.post of_setdropdowncalendar( true )	//long.zhang 11.06.2012 Bug 3315
DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_startqueue( )
//---------------------------- APPEON END ----------------------------

This.GetChild( "state", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("state")
//dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("county")
//dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("country")
//dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("yes/no")
//dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("address type")
//dwchild.InsertRow( 1 )

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<add> 02.09.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

gnv_appeondb.of_commitqueue( )

This.GetChild( "state", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "county", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "country", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "public_transportation", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "handicapped_access", dwchild )
dwchild.InsertRow( 1 )

This.GetChild( "mailing_address", dwchild )
dwchild.InsertRow( 1 )

this.insertrow(1)
f_modify_group_detail_property(this)//added by long.zhang 07.06.2012 v12.2 group location mini-painter
end event

event itemchanged;call super::itemchanged; //Start Code Change ----08.16.2016 #V15 maha - zip autofill
if dwo.name = "zip" then
	string val
	this.accepttext( )
	val = this.getitemstring(this.getrow(),"zip")
	of_zip_fill(val, "LOC", this)
end if
end event

type dw_appoint from u_dw within w_prac_add_from_entity
event ue_itemchanged ( integer al_application_audit_facility )
event ue_returning_prac ( )
event ue_undo_change ( integer ai_row,  string as_col,  any aa_val )
integer x = 23
integer y = 1268
integer width = 3872
integer height = 420
integer taborder = 10
boolean titlebar = true
string title = "Appointment"
string dataobject = "d_pd_affil_status_from_entity"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;DataWindowChild dwchild

This.GetChild( "parent_facility_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

This.GetChild( "verifying_facility", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve(gs_user_id)

this.of_settransobject(sqlca)
end event

event itemchanged;call super::itemchanged;//Start Code Change ----07.15.2011 #V11 maha - rearranged code to make easier to read.  Combined all parent facility code into a single if statement.
n_ds lds_cred_comms
DataWindowChild dwchild
boolean lb_midcycle = false
Date ldt_action_date
date ld_apptmnt_start_date // 01.13.2006 By: Liang QingShi
date ld_apptmnt_end_date
Integer li_found
Integer nullval
Integer li_committee_cnt
Integer li_ver_facility
Integer li_current_com_rc
Integer li_facility_id
Integer cc
Integer li_num_comms
Integer i
integer li_days //maha
integer li_years //maha
Integer li_ans
Integer c
Integer li_nr
Integer li_rec_no
integer li_day //03.03.2008  maha
integer li_month //03.03.2008  maha
integer li_year  //03.03.2008  maha
Integer li_dat
Integer li_dvf
integer li_userdef //maha 02.16.2011
integer li_active
integer li_org_status  //maha 07.31.2013
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
long ll_application_audit_facility_old// 08/06/2007 by: Andy
String ls_app_type
String nulldata
String ls_action_notes
string ls_column //maha12.15.2009
string ls_col_stat //maha 12.15.2009
string ls_atype //maha 02.16.2011
string ls_affilstat //maha 02.16.2011
string ls_stat_resp  //maha 07.31.2013
long licid

SetNull( nullval )
SetNull( nulldata)

this.accepttext()

if dwo.name = "parent_facility_id" then	
	li_facility_id = long(data)
	il_parent = li_facility_id
	//get defaults
	SELECT default_audit_temp, default_verif_facility,default_appt_type,default_affil_status, default_user INTO :li_dat, :li_dvf, :ls_atype, :ls_affilstat,:li_userdef FROM facility WHERE facility_id = :li_facility_id;
	if  li_dat > 0 then this.SetItem( row, "application_audit_facility", li_dat )
	if  li_dvf > 0 then this.SetItem( row, "verifying_facility", li_dvf )	
	if isnull( ls_atype) or  ls_atype = "" then  ls_atype = "I"
		
	ls_atype = trim(ls_atype)          		
	ls_affilstat = trim(ls_affilstat)     
	
	if isnull(This.getItemstring( row, "apptmnt_type" )) then This.SetItem( row, "apptmnt_type", ls_atype ) 
	This.SetItem( row, "affiliation_status", ls_affilstat )
		
	//COMMITTEES
	lds_cred_comms = CREATE n_ds
	lds_cred_comms.DataObject = "d_dddw_credentialing_committees" 
	lds_cred_comms.of_SetTransObject( SQLCA )
	li_num_comms = lds_cred_comms.Retrieve( li_facility_id )
	
	dw_comm_review.GetChild( "committee_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve( li_facility_id )		

	li_current_com_rc = dw_comm_review.RowCount()
	FOR cc = 1 TO li_current_com_rc
		dw_comm_review.DeleteRow( 1 )
	END FOR
	
	FOR c = 1 TO li_num_comms
		licid = lds_cred_comms.GetItemNumber( c, "committee_id" )

		li_active = lds_cred_comms.GetItemNumber( c, "active_status" )
		if li_active = 0 then continue
		
		li_nr = dw_comm_review.InsertRow( 0 )
		dw_comm_review.SetItem( li_nr, "facility_id", li_facility_id )
		dw_comm_review.SetItem( li_nr, "committee_id", licid )
		dw_comm_review.SetItem( li_nr, "active_status", 1 )
		dw_comm_review.SetItem( li_nr, "rec_id", il_appt )
		dw_comm_review.SetItem( li_nr, "prac_id", il_prac )
		dw_comm_review.SetItem( li_nr, "seq_no", c )
	END FOR
	
	dw_link.setitem(1, "facility_id",  li_facility_id)   //Start Code Change ----03.03.2017 #V153 maha - added set of facility in link record.
	
end if

	DESTROY lds_cred_comms





end event

event pfc_preupdate;call super::pfc_preupdate;Integer i
Integer l
Integer c
Integer li_first_loop = 0
Integer li_facility_id
Integer li_new_facility
Integer li_row_cnt
Integer li_nr
Integer li_found
Integer li_rec_no
integer li_status = 0
integer li_facil_check
integer ret
Long ll_rec_id
Long ll_action_type
Long ll_action_dept
Long ll_action_status
long li_temp 
String ls_action_notes
String ls_app_type
string ls_Priority_User 
Date ldt_action_date

li_row_cnt = This.RowCount()

//initialize variables for dataflow: alfee 01.07.2010
//inv_dataflow[1].of_init_data() 


li_temp = This.GetItemNumber( 1, "application_audit_facility")
ls_app_type = This.GetItemString( 1, "apptmnt_type" )

of_checklist( ls_app_type, li_temp)
inv_data_entry.of_field_audit( This )

RETURN 1
end event

