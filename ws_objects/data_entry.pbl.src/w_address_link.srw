$PBExportHeader$w_address_link.srw
forward
global type w_address_link from w_response
end type
type cb_1 from u_cb within w_address_link
end type
type dw_address_link from u_dw within w_address_link
end type
type dw_detail from u_dw within w_address_link
end type
type cb_2 from u_cb within w_address_link
end type
end forward

global type w_address_link from w_response
integer x = 23
integer y = 716
integer width = 3630
integer height = 1220
string title = "Facility Address Link"
boolean controlmenu = false
long backcolor = 12639424
cb_1 cb_1
dw_address_link dw_address_link
dw_detail dw_detail
cb_2 cb_2
end type
global w_address_link w_address_link

on w_address_link.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_address_link=create dw_address_link
this.dw_detail=create dw_detail
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_address_link
this.Control[iCurrent+3]=this.dw_detail
this.Control[iCurrent+4]=this.cb_2
end on

on w_address_link.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_address_link)
destroy(this.dw_detail)
destroy(this.cb_2)
end on

event open;call super::open;Long ll_prac_id
Long ll_address_id

ll_prac_id  = Long( MidA(Message.StringParm, 1, PosA( Message.StringParm, "-" )-1) )
ll_address_id  = Long( MidA(Message.StringParm, PosA( Message.StringParm, "-" )+1, 100 ))

dw_address_link.Retrieve( ll_prac_id, ll_address_id )

dw_detail.of_SetTransObject( SQLCA )
dw_detail.Retrieve( ll_address_id )
end event

event pfc_save;call super::pfc_save;Integer li_facility_id
Integer li_row_cnt
Integer li_primary
Integer li_additional
Integer i
Integer li_mailing
Integer li_billing
Integer li_exp_mail
Long ll_prac_id
Long ll_address_id
String ls_facility_nm
n_ds lds_dup_mail_search
n_ds lds_dup_exp_mail_search
n_ds lds_dup_primary_search

lds_dup_mail_search = CREATE n_ds
lds_dup_mail_search.DataObject = "d_address_link_duplicate_mail_check"
lds_dup_mail_search.of_SetTransObject( SQLCA )

lds_dup_exp_mail_search = CREATE n_ds
lds_dup_exp_mail_search.DataObject = "d_address_link_duplicate_exp_mail_check"
lds_dup_exp_mail_search.of_SetTransObject( SQLCA )

lds_dup_primary_search = CREATE n_ds
lds_dup_primary_search.DataObject = "d_address_link_duplicate_primary_check"
lds_dup_primary_search.of_SetTransObject( SQLCA )


dw_address_link.AcceptText()

li_row_cnt = dw_address_link.RowCount()

ll_prac_id = dw_address_link.GetItemNumber( 1, "prac_id" )


FOR i = 1 TO li_row_cnt
	//setup variables for retrieving data
	li_facility_id = dw_address_link.GetItemNumber( i, "facility_id" )
	ls_facility_nm = dw_address_link.GetItemString( i, "facility_facility_name" )
	ll_address_id = dw_address_link.GetItemNumber( i, "address_id" )
	li_mailing = dw_address_link.GetItemNumber( i, "mailing" )
	li_exp_mail	= dw_address_link.GetItemNumber( i, "exp_letters" )
	li_billing = dw_address_link.GetItemNumber( i, "billing" )
	li_primary = dw_address_link.GetItemNumber( i, "primary_office" )
	li_additional = dw_address_link.GetItemNumber( i, "additional_office" )

	IF li_primary = 1 AND li_additional = 1 THEN
		MessageBox("Invalid Selection", "An address can be setup as either a Primary office or Additional office, not both. Please correct.")
		DESTROY lds_dup_exp_mail_search
		DESTROY lds_dup_mail_search
		DESTROY lds_dup_primary_search				
		Return -1
	END IF
	
	//check if there is any other prmary addresses setup
	lds_dup_primary_search.Retrieve( li_facility_id, ll_address_id, ll_prac_id  )
	IF lds_dup_primary_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_primary > 0 THEN
		MessageBox("Primary Address", "You allready have a primary address setup for " + ls_facility_nm)
		dw_address_link.SetColumn( "primary_office" )
		dw_address_link.SetRow( i )
		dw_address_link.ScrollToRow( i )
		DESTROY lds_dup_exp_mail_search
		DESTROY lds_dup_mail_search
		DESTROY lds_dup_primary_search
		RETURN -1
	END IF	
	
	//check if there is any other exp_mail setup
	lds_dup_exp_mail_search.Retrieve( li_facility_id, ll_prac_id )
	IF lds_dup_exp_mail_search.GetItemNumber( 1, "dup_count" ) > 1 AND li_exp_mail > 0 THEN
		MessageBox("Expiring Credentials Mail Address", "You allready have an expiring credentials mailing address setup for this practitioner.")
		dw_address_link.SetColumn( "exp_letters" )
		dw_address_link.SetRow( i )
		dw_address_link.ScrollToRow( i )
		DESTROY lds_dup_exp_mail_search
		DESTROY lds_dup_mail_search
		DESTROY lds_dup_primary_search		
		RETURN -1
	END IF
	//check if there is allready a mailing address for dw_address_link facility
	lds_dup_mail_search.Retrieve( li_facility_id, ll_address_id, ll_prac_id ) 
	IF lds_dup_mail_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_mailing > 0 THEN
		MessageBox("Mailing Address", "You allready have a mailing address setup for " + ls_facility_nm)
		dw_address_link.SetColumn( "mailing" )
		dw_address_link.SetRow( i )
		dw_address_link.ScrollToRow( i )
		DESTROY lds_dup_exp_mail_search
		DESTROY lds_dup_mail_search
		RETURN -1
	END IF
	
//	//check if there is allready a billing address for dw_address_link facility
//	lds_dup_bill_search.Retrieve( li_facility_id, li_address_id, ll_prac_id )
//	IF lds_dup_bill_search.GetItemNumber( 1, "dup_count" ) > 0 AND li_billing > 0 THEN
//		MessageBox("Billing Address", "You allready have a billing address setup for " + ls_facility_nm)
//		dw_address_link.SetColumn( "billing" )
//		dw_address_link.SetRow( i )
//		dw_address_link.ScrollToRow( i )
//		DESTROY lds_dup_exp_mail_search		
//		DESTROY lds_dup_mail_search
//		DESTROY lds_dup_bill_search
//		RETURN -1
//	END IF
END FOR

DESTROY lds_dup_exp_mail_search
DESTROY lds_dup_mail_search
DESTROY lds_dup_primary_search
		
RETURN SUCCESS
end event

type cb_1 from u_cb within w_address_link
integer x = 3227
integer y = 972
integer taborder = 30
boolean bringtotop = true
string text = "&OK"
boolean default = true
end type

event clicked;IF Parent.Event pfc_Save() < 0 THEN
	MessageBox("Save Error", "Error saving data.")
	Return
END IF

Close(Parent)
end event

type dw_address_link from u_dw within w_address_link
integer x = 27
integer y = 268
integer width = 3570
integer height = 656
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_address_link"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type dw_detail from u_dw within w_address_link
integer x = 32
integer y = 20
integer width = 1568
integer height = 224
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_address_link_detail_info"
boolean vscrollbar = false
borderstyle borderstyle = stylebox!
end type

type cb_2 from u_cb within w_address_link
integer x = 32
integer y = 972
integer width = 562
integer taborder = 11
boolean bringtotop = true
string text = "Copy Down Field Value"
boolean default = true
end type

event clicked;Integer li_val
Integer li_row_cnt
Integer li_cur_row
Integer i
String ls_col_nm
String ls_val


dw_address_link.AcceptText()

ls_col_nm = dw_address_link.GetColumnName()
li_cur_row = dw_address_link.GetRow() 

IF ls_col_nm = "contact_person" THEN
	ls_val = dw_address_link.GetItemString( li_cur_row, ls_col_nm )	
ELSE
	li_val = dw_address_link.GetItemNumber( li_cur_row, ls_col_nm )	
END IF

li_row_cnt = dw_address_link.RowCount()
li_cur_row ++

FOR i = li_cur_row TO li_row_cnt
	IF ls_col_nm = "contact_person" THEN
		dw_address_link.SetItem( i, ls_col_nm, ls_val )
	ELSE
		dw_address_link.SetItem( i, ls_col_nm, li_val )
	END IF
END FOR
end event

