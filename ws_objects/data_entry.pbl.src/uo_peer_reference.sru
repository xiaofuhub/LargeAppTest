$PBExportHeader$uo_peer_reference.sru
forward
global type uo_peer_reference from u_base
end type
type ddlb_peer_type from dropdownlistbox within uo_peer_reference
end type
type cb_delete from commandbutton within uo_peer_reference
end type
type cb_edit from commandbutton within uo_peer_reference
end type
type cb_add from commandbutton within uo_peer_reference
end type
type cb_close from commandbutton within uo_peer_reference
end type
type dw_search from u_dw within uo_peer_reference
end type
type cb_search from u_cb within uo_peer_reference
end type
type cb_select from commandbutton within uo_peer_reference
end type
type ddlb_search_type from dropdownlistbox within uo_peer_reference
end type
type cb_28 from u_search_letter_button within uo_peer_reference
end type
type cb_25 from u_search_letter_button within uo_peer_reference
end type
type cb_24 from u_search_letter_button within uo_peer_reference
end type
type cb_23 from u_search_letter_button within uo_peer_reference
end type
type cb_22 from u_search_letter_button within uo_peer_reference
end type
type cb_21 from u_search_letter_button within uo_peer_reference
end type
type cb_20 from u_search_letter_button within uo_peer_reference
end type
type cb_19 from u_search_letter_button within uo_peer_reference
end type
type cb_18 from u_search_letter_button within uo_peer_reference
end type
type cb_17 from u_search_letter_button within uo_peer_reference
end type
type cb_16 from u_search_letter_button within uo_peer_reference
end type
type cb_15 from u_search_letter_button within uo_peer_reference
end type
type cb_14 from u_search_letter_button within uo_peer_reference
end type
type cb_13 from u_search_letter_button within uo_peer_reference
end type
type cb_12 from u_search_letter_button within uo_peer_reference
end type
type cb_11 from u_search_letter_button within uo_peer_reference
end type
type cb_10 from u_search_letter_button within uo_peer_reference
end type
type cb_9 from u_search_letter_button within uo_peer_reference
end type
type cb_8 from u_search_letter_button within uo_peer_reference
end type
type cb_7 from u_search_letter_button within uo_peer_reference
end type
type cb_6 from u_search_letter_button within uo_peer_reference
end type
type cb_5 from u_search_letter_button within uo_peer_reference
end type
type cb_4 from u_search_letter_button within uo_peer_reference
end type
type cb_3 from u_search_letter_button within uo_peer_reference
end type
type cb_2 from u_search_letter_button within uo_peer_reference
end type
type cb_1 from u_search_letter_button within uo_peer_reference
end type
type cb_showall from u_search_letter_button within uo_peer_reference
end type
type gb_1 from groupbox within uo_peer_reference
end type
type gb_2 from groupbox within uo_peer_reference
end type
type gb_3 from groupbox within uo_peer_reference
end type
type dw_search_value from datawindow within uo_peer_reference
end type
type sle_search_value from singlelineedit within uo_peer_reference
end type
end forward

global type uo_peer_reference from u_base
integer width = 3579
integer height = 1752
long backcolor = 33551856
ddlb_peer_type ddlb_peer_type
cb_delete cb_delete
cb_edit cb_edit
cb_add cb_add
cb_close cb_close
dw_search dw_search
cb_search cb_search
cb_select cb_select
ddlb_search_type ddlb_search_type
cb_28 cb_28
cb_25 cb_25
cb_24 cb_24
cb_23 cb_23
cb_22 cb_22
cb_21 cb_21
cb_20 cb_20
cb_19 cb_19
cb_18 cb_18
cb_17 cb_17
cb_16 cb_16
cb_15 cb_15
cb_14 cb_14
cb_13 cb_13
cb_12 cb_12
cb_11 cb_11
cb_10 cb_10
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_showall cb_showall
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
dw_search_value dw_search_value
sle_search_value sle_search_value
end type
global uo_peer_reference uo_peer_reference

type variables
string is_reference_lookup_sql
string is_basic_address_sql

window iw_Parent
datawindow idw_Peer
integer ii_Flag = 1
end variables

forward prototypes
public function string of_buildersql ()
public function integer of_searchfirstletter (string as_text)
public function integer of_init (window aw_parent, datawindow adw_peer, integer ai_flag)
public function integer of_applyright ()
end prototypes

public function string of_buildersql ();//////////////////////////////////////////////////////////////////////
// $<function>of_buildersql
// $<arguments>
// $<returns> string
// $<description> Builder sql select
//////////////////////////////////////////////////////////////////////
// $<add> 03.06.2009 by Evan
//////////////////////////////////////////////////////////////////////

string ls_condition1_t1
string ls_condition1_t2
string ls_Criteria1
string ls_Criteria2
string ls_SQLSelect
string ls_CharValue
string ls_NumberValue

// Get search value
ls_CharValue = sle_search_value.text
ls_NumberValue = String(dw_search_value.object.lookup_code[1])

// Get condition1
choose case ddlb_search_type.Text
	// Char value
	case "First Name"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "first_middle_name LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_basic.first_name LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Last Name"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "last_name LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_basic.last_name LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Street"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "street LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.street LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "City"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "city LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.city LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Zip"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "zip LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.zip LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Phone"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "cust_5 LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.phone LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Ext"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "cust_4 LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.ext LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Fax"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "fax LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.fax LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	case "Email Address"
		if LenA(ls_CharValue) > 0 then
			ls_condition1_t1 = "e_mail_address LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
			ls_condition1_t2 = "pd_address.e_mail_address LIKE '" + of_ReviseExpValue(ls_CharValue, "'") + "%'"
		end if
	// Number value
	case "Title"
		if LenA(ls_NumberValue) > 0 then
			ls_condition1_t1 = "title = " + ls_NumberValue
			ls_condition1_t2 = "pd_basic.title = " + ls_NumberValue
		end if
	case "Name Suffix"
		if LenA(ls_NumberValue) > 0 then
			ls_condition1_t1 = "name_suffix = " + ls_NumberValue
			ls_condition1_t2 = "pd_basic.name_suffix = " + ls_NumberValue
		end if
	case "Professional Suffix"
		if LenA(ls_NumberValue) > 0 then
			ls_condition1_t1 = "prof_suffix = " + ls_NumberValue
			ls_condition1_t2 = "pd_basic.prof_suffix = " + ls_NumberValue
		end if
	case "State"
		if LenA(ls_NumberValue) > 0 then
			ls_condition1_t1 = "state = " + ls_NumberValue
			ls_condition1_t2 = "pd_address.state = " + ls_NumberValue
		end if
	case "Country"
		if LenA(ls_NumberValue) > 0 then
			ls_condition1_t1 = "country = " + ls_NumberValue
			ls_condition1_t2 = "pd_address.country = " + ls_NumberValue
		end if
end choose

// Incorporates all of condition
if LenA(ls_condition1_t1) > 0 then
	if LenA(ls_Criteria1) > 0 then ls_Criteria1 += " AND "
	ls_Criteria1 += ls_condition1_t1
	ls_Criteria2 += " AND " + ls_condition1_t2
end if

// Builder sql select
if ddlb_peer_type.Text = "Reference Lookup" then
	if LenA(ls_Criteria1) > 0 then
		ls_SQLSelect = is_reference_lookup_sql + " WHERE " + ls_Criteria1
	else
		ls_SQLSelect = is_reference_lookup_sql
	end if
elseif ddlb_peer_type.Text = "Provider Basic/Address" then
	if LenA(ls_Criteria2) > 0 then
		ls_SQLSelect = is_basic_address_sql + ls_Criteria2
	else
		ls_SQLSelect = is_basic_address_sql
	end if
else
	if LenA(ls_Criteria1) > 0 then
		ls_SQLSelect = is_reference_lookup_sql + " WHERE " + ls_Criteria1
		ls_SQLSelect += " UNION ALL "
		ls_SQLSelect += is_basic_address_sql + ls_Criteria2
	else
		ls_SQLSelect = is_reference_lookup_sql
		ls_SQLSelect += " UNION ALL "
		ls_SQLSelect += is_basic_address_sql
	end if	
end if

Return ls_SQLSelect
end function

public function integer of_searchfirstletter (string as_text);//////////////////////////////////////////////////////////////////////
// $<function>of_searchfirstletter
// $<arguments>
//		string	as_text
// $<returns> integer
// $<description> First letter of last name search
//////////////////////////////////////////////////////////////////////
// $<add> 03.05.2009 by Evan
//////////////////////////////////////////////////////////////////////

ddlb_search_type.Text = "Last Name"
ddlb_search_type.Event SelectionChanged(0)
sle_search_value.Text = as_Text
cb_search.Event Clicked()

Return 1
end function

public function integer of_init (window aw_parent, datawindow adw_peer, integer ai_flag);//////////////////////////////////////////////////////////////////////
// $<function>of_init
// $<arguments>
//		window		aw_parent
//		datawindow	adw_peer
//		integer		ai_flag
// $<returns> integer
// $<description> initialize this user object
//////////////////////////////////////////////////////////////////////
// $<add> 03.05.2009 by Evan
//////////////////////////////////////////////////////////////////////

// Initialize sql select
is_reference_lookup_sql = &
"SELECT " + &
"   peer_type = 1, " + &
"   id, " + &
"   title, " + &
"   first_middle_name, " + &
"   last_name, " + &
"   name_suffix, " + &
"   prof_suffix, " + &
"   street, " + &
"   street1 = cust_1, " + &
"   street2 = cust_2, " + &
"   street3 = cust_3, " + &
"   city, " + &
"   state, " + &
"   zip, " + &
"   country, " + &
"   phone = cust_5, " + &
"   ext = cust_4, " + &
"   fax, " + &
"   e_mail_address, " + &
"    facility_name = 'N/A' " + &
"FROM reference_lookup "

is_basic_address_sql = &
"SELECT " + &
"   peer_type      = 2, " + &
"   id             = 0, " + &
"   title          = pd_basic.title, " + &
"   first_middle_name = isnull(pd_basic.first_name,'') + ' ' + isnull(pd_basic.middle_name,''), " + &
"   last_name      = pd_basic.last_name, " + &
"   name_suffix    = pd_basic.name_suffix, " + &
"   prof_suffix    = pd_basic.prof_suffix, " + &
"   street         = pd_address.street_2, " + &
"   street1        = '', " + &
"   street2        = '', " + &
"   street3        = '', " + &
"   city           = pd_address.city, " + &
"   state          = pd_address.state, " + &
"   zip            = pd_address.zip, " + &
"   country        = pd_address.country, " + &
"   phone          = pd_address.phone, " + &
"   ext            = pd_address.ext, " + &
"   fax            = pd_address.fax, " + &
"   e_mail_address = pd_address.e_mail_address, " + &
"   facility_name = facility.facility_name" + &
" FROM  pd_basic, pd_address, pd_address_link, facility " + &
" WHERE pd_basic.prac_id = pd_address.prac_id and " + &
" pd_address.rec_id =  pd_address_link.address_id and " + &
"  pd_address_link.facility_id = facility.facility_id and " + &
" pd_address_link.primary_office = 1 " 
//Start Code Change ----05.19.2011 #V11 maha - modified to include address link and facility tables, facility name to filter for primary addresses only

// Initialize instance variables
iw_Parent = aw_Parent
idw_Peer = adw_Peer
ii_Flag = ai_Flag

// Apply right settings
of_ApplyRight()

// Do something according to Flag
choose case ii_Flag
	case 1
		iw_Parent.Title = "Peer Reference List"
		cb_select.Hide()
		ddlb_peer_type.Enabled = false
		dw_search.Modify("peer_type.visible = 0")
	case 2
		iw_Parent.Title = "Select Peer Record"
		cb_select.Show()		
		ddlb_peer_type.Enabled = true
		dw_search.Modify("id.visible = 0")
	case else
		Return -1
end choose

// Retrieve data
ddlb_peer_type.Text = "Reference Lookup"
cb_showall.Event Clicked()

Return 1
end function

public function integer of_applyright ();//////////////////////////////////////////////////////////////////////
// $<function> of_applyright
// $<arguments>
// $<returns> integer
// $<description> Apply role right
//////////////////////////////////////////////////////////////////////
// $<add> 03.19.2009 by Evan
//////////////////////////////////////////////////////////////////////

//if w_mdi.of_security_access(6951) = 0 then
if w_mdi.of_security_access(7601) = 0 then	  //(Appeon)Alfee 06.29.2013 - V141 ISG-CLX	
	cb_add.Hide()
	cb_edit.Hide()
	cb_delete.Hide()
else
	cb_add.Show()
	cb_edit.Show()
	cb_delete.Show()
end if

Return 1
end function

on uo_peer_reference.create
int iCurrent
call super::create
this.ddlb_peer_type=create ddlb_peer_type
this.cb_delete=create cb_delete
this.cb_edit=create cb_edit
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_search=create dw_search
this.cb_search=create cb_search
this.cb_select=create cb_select
this.ddlb_search_type=create ddlb_search_type
this.cb_28=create cb_28
this.cb_25=create cb_25
this.cb_24=create cb_24
this.cb_23=create cb_23
this.cb_22=create cb_22
this.cb_21=create cb_21
this.cb_20=create cb_20
this.cb_19=create cb_19
this.cb_18=create cb_18
this.cb_17=create cb_17
this.cb_16=create cb_16
this.cb_15=create cb_15
this.cb_14=create cb_14
this.cb_13=create cb_13
this.cb_12=create cb_12
this.cb_11=create cb_11
this.cb_10=create cb_10
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_showall=create cb_showall
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_search_value=create dw_search_value
this.sle_search_value=create sle_search_value
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ddlb_peer_type
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_edit
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.dw_search
this.Control[iCurrent+7]=this.cb_search
this.Control[iCurrent+8]=this.cb_select
this.Control[iCurrent+9]=this.ddlb_search_type
this.Control[iCurrent+10]=this.cb_28
this.Control[iCurrent+11]=this.cb_25
this.Control[iCurrent+12]=this.cb_24
this.Control[iCurrent+13]=this.cb_23
this.Control[iCurrent+14]=this.cb_22
this.Control[iCurrent+15]=this.cb_21
this.Control[iCurrent+16]=this.cb_20
this.Control[iCurrent+17]=this.cb_19
this.Control[iCurrent+18]=this.cb_18
this.Control[iCurrent+19]=this.cb_17
this.Control[iCurrent+20]=this.cb_16
this.Control[iCurrent+21]=this.cb_15
this.Control[iCurrent+22]=this.cb_14
this.Control[iCurrent+23]=this.cb_13
this.Control[iCurrent+24]=this.cb_12
this.Control[iCurrent+25]=this.cb_11
this.Control[iCurrent+26]=this.cb_10
this.Control[iCurrent+27]=this.cb_9
this.Control[iCurrent+28]=this.cb_8
this.Control[iCurrent+29]=this.cb_7
this.Control[iCurrent+30]=this.cb_6
this.Control[iCurrent+31]=this.cb_5
this.Control[iCurrent+32]=this.cb_4
this.Control[iCurrent+33]=this.cb_3
this.Control[iCurrent+34]=this.cb_2
this.Control[iCurrent+35]=this.cb_1
this.Control[iCurrent+36]=this.cb_showall
this.Control[iCurrent+37]=this.gb_1
this.Control[iCurrent+38]=this.gb_2
this.Control[iCurrent+39]=this.gb_3
this.Control[iCurrent+40]=this.dw_search_value
this.Control[iCurrent+41]=this.sle_search_value
end on

on uo_peer_reference.destroy
call super::destroy
destroy(this.ddlb_peer_type)
destroy(this.cb_delete)
destroy(this.cb_edit)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_search)
destroy(this.cb_search)
destroy(this.cb_select)
destroy(this.ddlb_search_type)
destroy(this.cb_28)
destroy(this.cb_25)
destroy(this.cb_24)
destroy(this.cb_23)
destroy(this.cb_22)
destroy(this.cb_21)
destroy(this.cb_20)
destroy(this.cb_19)
destroy(this.cb_18)
destroy(this.cb_17)
destroy(this.cb_16)
destroy(this.cb_15)
destroy(this.cb_14)
destroy(this.cb_13)
destroy(this.cb_12)
destroy(this.cb_11)
destroy(this.cb_10)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_showall)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_search_value)
destroy(this.sle_search_value)
end on

event constructor;call super::constructor;this.of_SetResize(true)
inv_resize.of_setorigsize(this.Width, this.Height)
inv_resize.of_setminsize(this.Width, this.Height)

inv_resize.of_Register(gb_3, inv_resize.SCALEBOTTOM)
inv_resize.of_Register(dw_search, inv_resize.SCALERIGHTBOTTOM)
end event

event resize;//==================[Not Extend Ancestor Script]==================//

pfc_u_base::Event Resize(SizeType, NewWidth, NewHeight)
end event

type ddlb_peer_type from dropdownlistbox within uo_peer_reference
integer x = 64
integer y = 68
integer width = 933
integer height = 324
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
string item[] = {"All","Reference Lookup","Provider Basic/Address"}
borderstyle borderstyle = stylelowered!
end type

type cb_delete from commandbutton within uo_peer_reference
integer x = 2537
integer y = 32
integer width = 329
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Delete peer information
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

long ll_ID
long ll_Row

// Do some checks
if not Visible or not Enabled then Return
ll_Row = dw_search.GetRow()
if ll_Row <= 0 then Return
if dw_search.object.peer_type[ll_Row] = 2 then Return
if MessageBox("Delete", "Are you sure you want to delete the selected peer?", Question!, YesNo!) = 2 then
	Return
end if

// Delete peer
ll_ID = dw_search.object.id[ll_Row]
gnv_appeondb.of_StartQueue()
DELETE FROM reference_lookup WHERE id = :ll_ID;
COMMIT;
gnv_appeondb.of_CommitQueue()

dw_search.DeleteRow(ll_Row)
dw_search.SelectRow(0, false)
dw_search.SelectRow(dw_search.GetRow(), true)
dw_search.Event RowFocusChanged(dw_search.GetRow())
end event

type cb_edit from commandbutton within uo_peer_reference
integer x = 2199
integer y = 32
integer width = 329
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Edit"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Edit peer information
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Row

// Do some checks
if not Visible or not Enabled then Return
ll_Row = dw_search.GetRow()
if ll_Row <= 0 then Return
if dw_search.object.peer_type[ll_Row] = 2 then Return

// Open edit window
dw_search.tag = "edit!"
OpenWithParm(w_peer_reference_edit, dw_search)
end event

type cb_add from commandbutton within uo_peer_reference
integer x = 1861
integer y = 32
integer width = 329
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Add peer information
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

// Do some checks
if not Visible or not Enabled then Return

// Open add window
dw_search.tag = "add!"
OpenWithParm(w_peer_reference_edit, dw_search)
end event

type cb_close from commandbutton within uo_peer_reference
integer x = 3218
integer y = 32
integer width = 334
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Close window
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

Close(iw_Parent)
end event

type dw_search from u_dw within uo_peer_reference
integer x = 1056
integer y = 152
integer width = 2505
integer height = 1576
integer taborder = 10
string dataobject = "d_peer_reference_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;DataWindowChild ldwc_child1
DataWindowChild ldwc_child2
DataWindowChild ldwc_child3
DataWindowChild ldwc_child4
DataWindowChild ldwc_child5

this.of_SetSort(true)
this.of_SetRowSelect(true)
inv_sort.of_SetColumnHeader(true)

// Retrieve data of DDDW
gnv_appeondb.of_StartQueue()
this.GetChild("title", ldwc_child1)
ldwc_child1.SetTransObject(SQLCA)
ldwc_child1.Retrieve("Title")

this.GetChild("name_suffix", ldwc_child2)
ldwc_child2.SetTransObject(SQLCA)
ldwc_child2.Retrieve("Name Suffix")

this.GetChild("prof_suffix", ldwc_child3)
ldwc_child3.SetTransObject(SQLCA)
ldwc_child3.Retrieve("Professional Suffix")

this.GetChild("state", ldwc_child4)
ldwc_child4.SetTransObject(SQLCA)
ldwc_child4.Retrieve("State")

this.GetChild("country", ldwc_child5)
ldwc_child5.SetTransObject(SQLCA)
ldwc_child5.Retrieve("Country")
gnv_appeondb.of_CommitQueue()
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////
// $<event>doubleclicked
// $<arguments>
//		integer	xpos
//		integer	ypos
//		long		row
//		dwobject	dwo
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

if Row > 0 then
	if ii_Flag = 1 then
		cb_edit.Event Clicked()
	else
		cb_select.Event Clicked()
	end if
end if
end event

event rowfocuschanged;call super::rowfocuschanged;// Disable edit and delete button if peer is PA
if CurrentRow > 0 then
	if this.object.peer_type[CurrentRow] = 1 then
		cb_edit.Enabled = true
		cb_delete.Enabled = true
	else
		cb_edit.Enabled = false
		cb_delete.Enabled = false
	end if
end if
end event

type cb_search from u_cb within uo_peer_reference
integer x = 727
integer y = 908
integer width = 256
integer height = 88
integer taborder = 360
boolean bringtotop = true
string text = "&Search"
boolean default = true
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> string
// $<description> Search peer references
//////////////////////////////////////////////////////////////////////
// $<add> 03.06.2009 by Evan
//////////////////////////////////////////////////////////////////////

string ls_SQLSelect

ls_SQLSelect = of_BuilderSQL()
dw_search.SetSQLSelect(ls_SQLSelect)
dw_search.Retrieve()
dw_search.Event RowFocusChanged(dw_search.GetRow())
end event

type cb_select from commandbutton within uo_peer_reference
integer x = 2875
integer y = 32
integer width = 334
integer height = 84
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Populate"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> long
// $<description> Populate peer information to idw_peer
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

long ll_Row1
long ll_Row2

ll_Row1 = idw_peer.GetRow()
ll_Row2 = dw_search.GetRow()
if ll_Row1 <= 0 or ll_Row2 <= 0 then Return

if idw_peer.Describe("title.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "title", dw_search.object.title[ll_Row2])
end if
if idw_peer.Describe("last_name.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "last_name", dw_search.object.last_name[ll_Row2])
end if
if idw_peer.Describe("first_middle_name.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "first_middle_name", Trim(dw_search.object.first_middle_name[ll_Row2]))
end if
if idw_peer.Describe("name_suffix.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "name_suffix", dw_search.object.name_suffix[ll_Row2])
end if
if idw_peer.Describe("prof_suffix.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "prof_suffix", dw_search.object.prof_suffix[ll_Row2])
end if
if idw_peer.Describe("street.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "street", dw_search.object.street[ll_Row2])
end if
if idw_peer.Describe("city.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "city", dw_search.object.city[ll_Row2])
end if
if idw_peer.Describe("state.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "state", dw_search.object.state[ll_Row2])
end if
if idw_peer.Describe("zip.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "zip", dw_search.object.zip[ll_Row2])
end if
if idw_peer.Describe("country.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "country", dw_search.object.country[ll_Row2])
end if
if idw_peer.Describe("cust_5.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "cust_5", dw_search.object.phone[ll_Row2])
end if
if idw_peer.Describe("cust_4.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "cust_4", dw_search.object.ext[ll_Row2])
end if
if idw_peer.Describe("cust_1.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "cust_1", dw_search.object.street1[ll_Row2])
end if
if idw_peer.Describe("cust_2.ColType") <> "!"  then
	idw_peer.SetItem(ll_Row1, "cust_2", dw_search.object.street2[ll_Row2])
end if
if idw_peer.Describe("cust_3.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "cust_3", dw_search.object.street3[ll_Row2])
end if
if idw_peer.Describe("fax.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "fax", dw_search.object.fax[ll_Row2])
end if
if idw_peer.Describe("e_mail_address.ColType") <> "!" then
	idw_peer.SetItem(ll_Row1, "e_mail_address", dw_search.object.e_mail_address[ll_Row2])
end if

Close(iw_Parent)
end event

type ddlb_search_type from dropdownlistbox within uo_peer_reference
integer x = 55
integer y = 908
integer width = 667
integer height = 396
integer taborder = 350
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
string item[] = {"Title","First Name","Last Name","Name Suffix","Professional Suffix","Street","City","State","Zip","Country","Phone","Ext","Fax","Email Address"}
borderstyle borderstyle = stylelowered!
end type

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructor
// $<arguments>
// $<returns> long
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

this.Text = "Last Name"
end event

event selectionchanged;//////////////////////////////////////////////////////////////////////
// $<event>selectionchanged
// $<arguments>
//			integer index
// $<returns> long
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

// Show search value control
choose case ddlb_search_type.Text
	case "Title", "Name Suffix", "Professional Suffix", "State", "Country"
		dw_search_value.Show()
		sle_search_value.Hide()
		dw_search_value.Event ue_filldddw(ddlb_search_type.Text)
		dw_search_value.SetFocus()
	case else
		dw_search_value.Hide()
		sle_search_value.Show()
		sle_search_value.Text = ""
		sle_search_value.SetFocus()
end choose
end event

type cb_28 from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 540
integer width = 233
integer height = 64
integer taborder = 330
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Z"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_25 from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 476
integer width = 233
integer height = 64
integer taborder = 320
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Y"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_24 from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 412
integer width = 233
integer height = 64
integer taborder = 310
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "X"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_23 from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 348
integer width = 233
integer height = 64
integer taborder = 300
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "W"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_22 from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 284
integer width = 233
integer height = 64
integer taborder = 290
boolean bringtotop = true
integer textsize = -8
string facename = "Microsoft Sans Serif"
string text = "V"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_21 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 668
integer width = 233
integer height = 64
integer taborder = 280
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "U"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_20 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 604
integer width = 233
integer height = 64
integer taborder = 270
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "T"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_19 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 540
integer width = 233
integer height = 64
integer taborder = 260
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "S"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_18 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 476
integer width = 233
integer height = 64
integer taborder = 250
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "R"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_17 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 412
integer width = 233
integer height = 64
integer taborder = 240
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Q"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_16 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 348
integer width = 233
integer height = 64
integer taborder = 230
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "P"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_15 from u_search_letter_button within uo_peer_reference
integer x = 517
integer y = 284
integer width = 233
integer height = 64
integer taborder = 220
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "O"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_14 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 668
integer width = 233
integer height = 64
integer taborder = 210
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "N"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_13 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 604
integer width = 233
integer height = 64
integer taborder = 200
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "M"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_12 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 540
integer width = 233
integer height = 64
integer taborder = 190
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "L"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_11 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 476
integer width = 233
integer height = 64
integer taborder = 180
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "K"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_10 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 412
integer width = 233
integer height = 64
integer taborder = 170
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "J"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_9 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 348
integer width = 233
integer height = 64
integer taborder = 160
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "I"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_8 from u_search_letter_button within uo_peer_reference
integer x = 279
integer y = 284
integer width = 233
integer height = 64
integer taborder = 150
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "H"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_7 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 668
integer width = 233
integer height = 64
integer taborder = 140
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "G"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_6 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 604
integer width = 233
integer height = 64
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "F"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_5 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 540
integer width = 233
integer height = 64
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "E"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_4 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 476
integer width = 233
integer height = 64
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "D"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_3 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 412
integer width = 233
integer height = 64
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "C"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_2 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 348
integer width = 233
integer height = 64
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "B"
end type

event clicked;call super::clicked;of_SearchFirstLetter(this.Text)
end event

type cb_1 from u_search_letter_button within uo_peer_reference
integer x = 41
integer y = 284
integer width = 233
integer height = 64
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "A"
end type

event clicked;of_SearchFirstLetter(this.Text)
end event

type cb_showall from u_search_letter_button within uo_peer_reference
integer x = 754
integer y = 604
integer width = 233
integer height = 128
integer taborder = 340
boolean bringtotop = true
integer textsize = -8
string facename = "Segoe UI"
string text = "Show All"
end type

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event>clicked
// $<arguments>
// $<returns> string
// $<description> Retrieve all peer references
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

ddlb_search_type.Text = "Last Name"
ddlb_search_type.Event SelectionChanged(0)
cb_search.Event Clicked()
end event

type gb_1 from groupbox within uo_peer_reference
integer x = 23
integer width = 1015
integer height = 204
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Data From:"
end type

type gb_2 from groupbox within uo_peer_reference
integer x = 14
integer y = 216
integer width = 1010
integer height = 560
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "First Letter of Last Name Search"
end type

type gb_3 from groupbox within uo_peer_reference
integer x = 14
integer y = 800
integer width = 1015
integer height = 364
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Search On"
end type

type dw_search_value from datawindow within uo_peer_reference
event ue_filldddw ( string as_column )
integer x = 50
integer y = 1016
integer width = 969
integer height = 88
integer taborder = 380
boolean bringtotop = true
string title = "none"
string dataobject = "d_peer_reference_dddwvalue"
boolean border = false
boolean livescroll = true
end type

event ue_filldddw;//////////////////////////////////////////////////////////////////////
// $<event>ue_filldddw
// $<arguments>
//			string as_column
// $<returns> (None)
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 03.09.2009 by Evan
//////////////////////////////////////////////////////////////////////

long i, ll_Null
DataWindowChild ldwc_child1
DataWindowChild ldwc_child2

SetNull(ll_Null)
this.SetItem(1, "lookup_code", ll_Null)
this.GetChild("lookup_code", ldwc_child1)
ldwc_child1.Reset()

choose case as_Column
	case "Title"
		dw_search.GetChild("title", ldwc_child2)
	case "Name Suffix"
		dw_search.GetChild("name_suffix", ldwc_child2)
	case "Professional Suffix"
		dw_search.GetChild("prof_suffix", ldwc_child2)
	case "State"
		dw_search.GetChild("state", ldwc_child2)
	case "Country"
		dw_search.GetChild("country", ldwc_child2)
end choose

for i = 1 to ldwc_child2.RowCount()
	ldwc_child1.InsertRow(0)
	ldwc_child1.SetItem(i, "lookup_code", ldwc_child2.GetItemNumber(i, "lookup_code"))
	if as_Column = "State" then
		ldwc_child1.SetItem(i, "description", ldwc_child2.GetItemString(i, "code"))
	else
		ldwc_child1.SetItem(i, "description", ldwc_child2.GetItemString(i, "description"))
	end if
next
end event

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>constructor
// $<arguments>
// $<returns> long
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 03.10.2009 by Evan
//////////////////////////////////////////////////////////////////////

this.InsertRow(0)
end event

type sle_search_value from singlelineedit within uo_peer_reference
integer x = 55
integer y = 1016
integer width = 928
integer height = 80
integer taborder = 370
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

