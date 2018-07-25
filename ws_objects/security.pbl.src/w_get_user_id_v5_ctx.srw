$PBExportHeader$w_get_user_id_v5_ctx.srw
forward
global type w_get_user_id_v5_ctx from window
end type
type cb_new from commandbutton within w_get_user_id_v5_ctx
end type
type dw_contact_browse from u_dw_contract within w_get_user_id_v5_ctx
end type
type cb_4 from commandbutton within w_get_user_id_v5_ctx
end type
type cb_3 from commandbutton within w_get_user_id_v5_ctx
end type
type dw_phone from u_dw_contract within w_get_user_id_v5_ctx
end type
type dw_company from u_dw within w_get_user_id_v5_ctx
end type
type dw_contact from u_dw_contract within w_get_user_id_v5_ctx
end type
type sle_1 from singlelineedit within w_get_user_id_v5_ctx
end type
type cb_2 from commandbutton within w_get_user_id_v5_ctx
end type
type cb_1 from commandbutton within w_get_user_id_v5_ctx
end type
type st_1 from statictext within w_get_user_id_v5_ctx
end type
type st_2 from statictext within w_get_user_id_v5_ctx
end type
type st_3 from statictext within w_get_user_id_v5_ctx
end type
type gb_1 from groupbox within w_get_user_id_v5_ctx
end type
type gb_2 from groupbox within w_get_user_id_v5_ctx
end type
end forward

global type w_get_user_id_v5_ctx from window
integer width = 3410
integer height = 1768
boolean titlebar = true
string title = "Get New user"
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_new cb_new
dw_contact_browse dw_contact_browse
cb_4 cb_4
cb_3 cb_3
dw_phone dw_phone
dw_company dw_company
dw_contact dw_contact
sle_1 sle_1
cb_2 cb_2
cb_1 cb_1
st_1 st_1
st_2 st_2
st_3 st_3
gb_1 gb_1
gb_2 gb_2
end type
global w_get_user_id_v5_ctx w_get_user_id_v5_ctx

type variables
n_cst_string inv_string
end variables

on w_get_user_id_v5_ctx.create
this.cb_new=create cb_new
this.dw_contact_browse=create dw_contact_browse
this.cb_4=create cb_4
this.cb_3=create cb_3
this.dw_phone=create dw_phone
this.dw_company=create dw_company
this.dw_contact=create dw_contact
this.sle_1=create sle_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_new,&
this.dw_contact_browse,&
this.cb_4,&
this.cb_3,&
this.dw_phone,&
this.dw_company,&
this.dw_contact,&
this.sle_1,&
this.cb_2,&
this.cb_1,&
this.st_1,&
this.st_2,&
this.st_3,&
this.gb_1,&
this.gb_2}
end on

on w_get_user_id_v5_ctx.destroy
destroy(this.cb_new)
destroy(this.dw_contact_browse)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.dw_phone)
destroy(this.dw_company)
destroy(this.dw_contact)
destroy(this.sle_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;//maha rebuilt this window 083105
// was previously inherited and code could not be modified

sle_1.SetFocus( )
end event

type cb_new from commandbutton within w_get_user_id_v5_ctx
boolean visible = false
integer x = 2839
integer y = 284
integer width = 357
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New Contact"
boolean default = true
end type

event clicked;long ll_row
long ll_code

dw_contact.Reset( )
dw_phone.reset( )
//dw_contact_browse.Selectrow( 0,false)

dw_contact.InsertRow(0)

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'EMAIL'"))
if ll_code > 0 then
	ll_row = dw_phone.InsertRow(0)
	dw_phone.SetItem( ll_row, "via",ll_code)
	dw_phone.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'PHONE'"))
if ll_code > 0 then
	ll_row = dw_phone.InsertRow(0)
	dw_phone.SetItem( ll_row, "via",ll_code)
	dw_phone.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'FAX'"))
if ll_code > 0 then
	ll_row = dw_phone.InsertRow(0)
	dw_phone.SetItem( ll_row, "via",ll_code)
	dw_phone.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'CELL'"))
if ll_code > 0 then
	ll_row = dw_phone.InsertRow(0)
	dw_phone.SetItem( ll_row, "via",ll_code)
	dw_phone.SetItemStatus( ll_row,0,primary!, NotModified!)
end if
end event

type dw_contact_browse from u_dw_contract within w_get_user_id_v5_ctx
integer x = 55
integer y = 356
integer width = 882
integer height = 1268
integer taborder = 100
string dataobject = "d_contact_browse"
boolean hsplitscroll = true
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event clicked;call super::clicked;long ll_contact_id
this.selectrow(0,false)
this.selectrow( row,true)

if row > 0 then
	ll_contact_id = this.GetItemNumber( row,"contact_id")
	if ll_contact_id = -100 then	//<<Add New Contact Person>>
		cb_new.event Clicked() //jervis 12.29.2009
	else
		dw_contact.Retrieve(ll_contact_id )
		dw_phone.Retrieve(ll_contact_id )
	end if
end if
end event

event constructor;call super::constructor;this.SetTransobject( sqlca)
end event

type cb_4 from commandbutton within w_get_user_id_v5_ctx
boolean visible = false
integer x = 3054
integer y = 1536
integer width = 288
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;dw_phone.event pfc_deleterow()
end event

type cb_3 from commandbutton within w_get_user_id_v5_ctx
boolean visible = false
integer x = 2747
integer y = 1536
integer width = 288
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
boolean default = true
end type

event clicked;long ll_row
ll_row = dw_phone.event pfc_addrow()
dw_phone.SetItemStatus( ll_row,0,primary!,NotModified!)

end event

type dw_phone from u_dw_contract within w_get_user_id_v5_ctx
integer x = 997
integer y = 760
integer width = 2313
integer height = 832
integer taborder = 70
string dataobject = "d_cntx_phone"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;long ll_row
long ll_code
this.event ue_populatedddws()

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'EMAIL'"))
if ll_code > 0 then
	ll_row = this.InsertRow(0)
	this.SetItem( ll_row, "via",ll_code)
	this.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'PHONE'"))
if ll_code > 0 then
	ll_row = this.InsertRow(0)
	this.SetItem( ll_row, "via",ll_code)
	this.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'FAX'"))
if ll_code > 0 then
	ll_row = this.InsertRow(0)
	this.SetItem( ll_row, "via",ll_code)
	this.SetItemStatus( ll_row,0,primary!, NotModified!)
end if

ll_code = long(gnv_data.of_getitem( 'code_lookup','lookup_code', "lookup_name = 'Contract Contact VIA' and upper(Code) = 'CELL'"))
if ll_code > 0 then
	ll_row = this.InsertRow(0)
	this.SetItem( ll_row, "via",ll_code)
	this.SetItemStatus( ll_row,0,primary!, NotModified!)
end if
end event

event buttonclicked;call super::buttonclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-12-06 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'b_phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
		This.SetColumn('phone')
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event doubleclicked;call super::doubleclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2007-10-17 By: Scofield
//$<Reason> Popup a dialog to input the phone

String	ls_Phone,ls_RetParm,ls_Via

ls_Via = dw_phone.Describe("evaluate('LookUpDisplay(via)'," + String(row) + ")")

if ls_Via <> 'PHONE' and ls_Via <> 'FAX' and ls_Via <> 'CELL' and ls_Via <> 'PAGER' then return

This.AcceptText()
if row > 0 and row <= This.RowCount() then
	if dwo.name = 'phone' then
		ls_Phone = This.GetItemString(row,'phone')
		OpenWithParm(w_phonedetail,ls_Phone)
		
		ls_RetParm = Message.StringParm
		
		if ls_RetParm <> 'Cancel' then
			This.SetItem(row,'phone',ls_RetParm)
		end if
	end if
end if
//---------------------------- APPEON END ----------------------------

end event

event pfc_preupdate;call super::pfc_preupdate;
long 		ll_i,ll_Count
String	ls_phone,ls_ext,ls_contact_email,ls_Via

if dw_contact.RowCount() < 1 then return Success
this.accepttext( )
for ll_i = 1 to RowCount( )
	if this.GetItemStatus( ll_i,0,Primary!) = NewModified! then
		ls_phone = This.GetItemString(ll_i,'phone')
		ls_ext = This.GetItemString(ll_i,'ext')
		ls_contact_email = This.GetItemString(ll_i,'contact_email')
		ls_Via = Upper(this.Describe("Evaluate('LookUpDisplay(via)'," + String(ll_i) + ")"))		//Added by Scofield on 2008-04-23
		
		if IsNull(ls_phone) then ls_phone = ""
		if IsNull(ls_ext) then ls_ext = ""
		if IsNull(ls_contact_email) then ls_contact_email = ""
			
		if ls_phone + ls_ext + ls_contact_email = "" and ls_Via <> 'WEB' then							//Modified by Scofield on 2008-04-23
			this.SetItemStatus(ll_i,0,Primary!,NotModified!)
			continue
		end if
	
		this.object.contact_id[ll_i] = dw_contact.object.contact_id[1]
	end if
next
return Success

end event

type dw_company from u_dw within w_get_user_id_v5_ctx
integer x = 59
integer y = 264
integer width = 873
integer height = 76
integer taborder = 80
string dataobject = "d_external_company"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;datawindowchild ldwc
long ll_row

if this.getchild( "facility_id",ldwc) = 1 then
	ldwc.SetTransobject( sqlca)
	if ldwc.Retrieve('A') < 1 then
		ldwc.Insertrow( 0)
	end if 
end if	

ll_row = this.event pfc_addrow()

this.SetItem( 1, "facility_id",ldwc.GetItemNumber(1,'facility_id'))
this.event ItemChanged(1,this.object.facility_id,string(ldwc.GetItemNumber(1,'facility_id')))



end event

event itemchanged;call super::itemchanged;dw_contact_browse.Retrieve(long(data))
//add an entry <<Add New Contact Person>> -- jervis 12.29.2009
dw_contact_browse.InsertRow( 0)
dw_contact_browse.SetItem( 1,"First_name","<<Add New Contact Person>>")
dw_contact_browse.SetItem( 1,"last_name","")
dw_contact_browse.SetItem( 1,"contact_id",-100)

end event

type dw_contact from u_dw_contract within w_get_user_id_v5_ctx
integer x = 960
integer y = 252
integer width = 2386
integer height = 1372
integer taborder = 90
string dataobject = "d_cntx_master"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.Modify("user_d.visible = 0")
this.Modify("user_d_t.visible = 0")
this.Modify("defaultto.visible = 0")
this.Modify("t_defaultto.visible = 0")


this.event ue_populatedddws()
this.event pfc_addrow()

this.of_setreqcolumn( true)
ib_rmbmenu = false
end event

event pfc_preupdate;call super::pfc_preupdate;long ll_row
long li_facility_id
long ll_seq_no

ll_row = this.GetRow( )
this.Accepttext( )

if this.GetItemStatus( ll_row,0,Primary!) = NewModified! then
	if Not f_validstr(string(This.object.contact_id[ll_Row])) then
		select max(contact_id)
		into :ll_seq_no
		from  ctx_contacts;
	
		if not f_validstr(string(ll_seq_no)) then
			ll_seq_no  = 1
		else
			ll_seq_no =  ll_seq_no + 1
		end if 
	
		object.contact_id[ll_Row] = ll_seq_no
	end if
	
	if Not f_validstr(STRING(dw_contact.object.facility_id[ll_Row])) then
		li_facility_id = dw_company.GetItemNumber(dw_company.GetRow(),'facility_id')
		
		if Not f_validstr(STRING(li_facility_id)) then
			return failure
		end if
		
		dw_contact.SetItem(ll_Row, "facility_id", li_facility_id)
	end if
end if


return 0

end event

event pfc_validation;call super::pfc_validation;
if this.rowcount( ) <  1 then return success

this.accepttext( )


if not f_validstr(string(this.object.first_name[1])) then
	messagebox('Information', 'First Name is required.')
	return failure
end if

if not f_validstr(string(this.object.last_name[1])) then
	messagebox('Information', 'Last Name is required.')
	return failure
end if 



return success
end event

type sle_1 from singlelineedit within w_get_user_id_v5_ctx
integer x = 270
integer y = 56
integer width = 398
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_get_user_id_v5_ctx
integer x = 3049
integer y = 60
integer width = 293
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "Cancel" )
end event

type cb_1 from commandbutton within w_get_user_id_v5_ctx
integer x = 2738
integer y = 60
integer width = 288
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;String ls_retval
string ls_value
Int  li_Count
string ls_first_name ,ls_last_name,ls_fullName,ls_middle_name
ls_retval = Trim(sle_1.Text )
If ls_retval = '' Then
	MessageBox("User name","Please enter a User Name.")
	Return
End If

If IsNumber(ls_retval) Then
	MessageBox("Warning","User name cannot be all numbers.")
	Return
End If

If Len(ls_retval) > 10 Then
	MessageBox("User name","The user name can be only a maximum of 10 characters.")
	Return
End If

If Not inv_string.of_check_name(ls_retval,0, false)  Then
	Messagebox('Check Email Address','Single quote (~‘), double quote (“) and tilde (~~) are not supported as a character in an User ID. ')
	sle_1.SetFocus()
	Return -11
End If

//if cbx_auto.Checked then
	if dw_contact.event pfc_validation() < 0 then return
//end if

Select count(1)
	Into :li_Count
	From security_users
	Where  Upper(user_id)  = Upper(:ls_retval);
//Start Code Change ----02.13.2008 #V8 maha - added upper test

If li_Count > 0 Then
	sle_1.SetFocus( )
	MessageBox('User Name',"Current User Name already exists. Please re-enter another one.")
	Return
End If

ls_first_name = dw_contact.GetItemString(dw_contact.GetRow(),"First_name")
ls_last_name = dw_contact.GetItemString(dw_contact.GetRow(),"last_name")
ls_middle_name = dw_contact.GetItemString(dw_contact.GetRow(),"middle_name")
if isnull(ls_first_name) then ls_first_name = ''
if isnull(ls_last_name) then ls_last_name = ''
if isnull(ls_middle_name) then ls_middle_name = ''

If ls_middle_name = '' Then
	ls_fullname = ls_first_name + " " + ls_last_name
Else
	ls_fullname = ls_first_name + " " + ls_middle_name + " " + ls_last_name
End If
//---------Begin Added by (Appeon)Toney 09.04.2013 for V141 ISG-CLX--------
//$Reason:Fix reintegration BugT081302
DataStore  lds_getting
n_cst_getting_started  ln_getting
IF ln_getting.of_initgettingstart(ls_retval,lds_getting) <> 1 THEN
	Destroy lds_getting
	Messagebox('Getting Started','Failed to initialize data, please call support.')
	RETURN
END IF
if lds_getting.Update( ) < 1 then
	messagebox("Getting Started"," Failure to update  getting started records.~r~n"+sqlca.sqlerrtext,StopSign!)
	ROLLBACK USING SQLCA;	
	Destroy lds_getting
	return
end if
Destroy lds_getting
//---------End Added ------------------------------------------------------------------
//Insert User
//gnv_appeondb.of_startqueue( )
Insert Into security_users(user_id,role_id,user_name,user_password,image_flag,contract_default_view,readonly,set_autoret,run_date_alarm,set_autoresize,getting_started,autoexport,contract_display_mode,Dynamic_Search_tab,doc_auto_retrieve,refresh_sertifi,refresh_sertifi_dm,check_email,active_status)
	Values(:ls_retval,1,:ls_FullName,'123','0',1001,0,0,1,1,1,0,0,0,0,1,1,1,1); //add active_status for BugA081501 - alfee 09.16.2013

//If cbx_auto.Checked Then
	//Update Contact info
	//ls_value = dw_contact.GetItemString(dw_contact.GetRow( ),"user_d")
	//if dw_contact.GetItemStatus( dw_contact.GetRow(),0,primary!) = NewModified! and (isnull(ls_value) or ls_value ='') then
	dw_contact.SetItem(dw_contact.GetRow( ),"user_d",ls_retval)
	//end if
	
	dw_contact.Event pfc_update( True,True)
	dw_phone.Event pfc_update( True,True)
//End If
Commit;
//gnv_appeondb.of_commitqueue( )


CloseWithReturn(Parent, ls_retval )




end event

type st_1 from statictext within w_get_user_id_v5_ctx
integer x = 87
integer y = 68
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "User ID"
boolean focusrectangle = false
end type

type st_2 from statictext within w_get_user_id_v5_ctx
integer x = 718
integer y = 68
integer width = 535
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "10 character maximum."
boolean focusrectangle = false
end type

type st_3 from statictext within w_get_user_id_v5_ctx
integer x = 1275
integer y = 68
integer width = 713
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Default password will be 123."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_get_user_id_v5_ctx
integer x = 23
integer y = 196
integer width = 3360
integer height = 1464
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Associate with Existing Contact Person(s) OR Add New Contact Person to selected Our Company"
end type

type gb_2 from groupbox within w_get_user_id_v5_ctx
integer x = 23
integer width = 3360
integer height = 172
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "User info"
end type

