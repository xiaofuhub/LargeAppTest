$PBExportHeader$w_wv_esign_agreement.srw
forward
global type w_wv_esign_agreement from w_sheet
end type
type gb_2 from groupbox within w_wv_esign_agreement
end type
type gb_1 from groupbox within w_wv_esign_agreement
end type
type cb_delete from commandbutton within w_wv_esign_agreement
end type
type cb_save from commandbutton within w_wv_esign_agreement
end type
type dw_facility from u_dw within w_wv_esign_agreement
end type
type cb_close from commandbutton within w_wv_esign_agreement
end type
type tab_1 from tab within w_wv_esign_agreement
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_2 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_4 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tabpage_5 from userobject within tab_1
end type
type tab_1 from tab within w_wv_esign_agreement
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type gb_3 from groupbox within w_wv_esign_agreement
end type
type dw_statement from u_dw within w_wv_esign_agreement
end type
type rb_3 from radiobutton within w_wv_esign_agreement
end type
type rb_2 from radiobutton within w_wv_esign_agreement
end type
type rb_1 from radiobutton within w_wv_esign_agreement
end type
end forward

global type w_wv_esign_agreement from w_sheet
integer width = 3625
integer height = 1924
string title = "WebView E-Signature Agreements"
boolean maxbox = false
long backcolor = 33551856
gb_2 gb_2
gb_1 gb_1
cb_delete cb_delete
cb_save cb_save
dw_facility dw_facility
cb_close cb_close
tab_1 tab_1
gb_3 gb_3
dw_statement dw_statement
rb_3 rb_3
rb_2 rb_2
rb_1 rb_1
end type
global w_wv_esign_agreement w_wv_esign_agreement

type variables
long il_facility_id = 0
string is_appoint_type = "I"
string is_tab_type = "credentialing_data"
end variables

forward prototypes
public function integer of_retrievestatement ()
end prototypes

public function integer of_retrievestatement ();//====================================================================
// $<function> of_RetrieveStatement()
// $<arguments>
// $<returns> integer
// $<description> Retrieve e-signature statement
// $<add> (Appeon) evan 02.13.2012
//====================================================================

dw_statement.Retrieve(il_facility_id, is_appoint_type, is_tab_type)
if dw_statement.RowCount() < 1 then
	dw_statement.InsertRow(0)
end if

Return 1
end function

on w_wv_esign_agreement.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.dw_facility=create dw_facility
this.cb_close=create cb_close
this.tab_1=create tab_1
this.gb_3=create gb_3
this.dw_statement=create dw_statement
this.rb_3=create rb_3
this.rb_2=create rb_2
this.rb_1=create rb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_save
this.Control[iCurrent+5]=this.dw_facility
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.tab_1
this.Control[iCurrent+8]=this.gb_3
this.Control[iCurrent+9]=this.dw_statement
this.Control[iCurrent+10]=this.rb_3
this.Control[iCurrent+11]=this.rb_2
this.Control[iCurrent+12]=this.rb_1
end on

on w_wv_esign_agreement.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.dw_facility)
destroy(this.cb_close)
destroy(this.tab_1)
destroy(this.gb_3)
destroy(this.dw_statement)
destroy(this.rb_3)
destroy(this.rb_2)
destroy(this.rb_1)
end on

event open;call super::open;dw_facility.Retrieve(gs_user_id)
end event

type gb_2 from groupbox within w_wv_esign_agreement
integer x = 1106
integer y = 564
integer width = 2386
integer height = 1192
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "E-Signature Statement"
end type

type gb_1 from groupbox within w_wv_esign_agreement
integer x = 1102
integer y = 292
integer width = 2391
integer height = 228
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Appointment Type"
end type

type cb_delete from commandbutton within w_wv_esign_agreement
integer x = 2807
integer y = 32
integer width = 343
integer height = 92
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Delete statement
// $<add> (Appeon) evan 02.13.2012
//====================================================================

dwitemstatus ldwi_status

dw_statement.AcceptText()
ldwi_status = dw_statement.GetItemStatus(1, 0, Primary!)
if ldwi_status = New! then Return
if MessageBox("Delete", "Are you sure you want to permanently delete the current E-Signature statement?", Question!, YesNo!) = 2 then
	Return
end if

dw_statement.DeleteRow(0)
if dw_statement.Update() = 1 then
	Commit;
	dw_statement.InsertRow(0)
else
	Rollback;
	MessageBox("Delete Error", "Failed to delete E-Signature statement.", StopSign!)
end if
end event

type cb_save from commandbutton within w_wv_esign_agreement
integer x = 2446
integer y = 36
integer width = 343
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Save statement
// $<add> (Appeon) evan 02.13.2012
//====================================================================

dwitemstatus ldwi_status

dw_statement.AcceptText()
ldwi_status = dw_statement.GetItemStatus(1, 0, Primary!)
if ldwi_status = New! or ldwi_status = NotModified! then Return

if ldwi_status = NewModified! then
	dw_statement.SetItem(1, "facility_id", il_facility_id)
	dw_statement.SetItem(1, "appoint_type", is_appoint_type)
	dw_statement.SetItem(1, "tab_type", is_tab_type)
	dw_statement.SetItem(1, "create_by", gs_user_id)
	dw_statement.SetItem(1, "create_date", DateTime(today(),now()))
else
end if

if dw_statement.Update() = 1 then
	Commit;
else
	Rollback;
	MessageBox("Save Error", "Failed to save e-Signature statement.", StopSign!)
end if
end event

type dw_facility from u_dw within w_wv_esign_agreement
integer x = 64
integer y = 104
integer width = 937
integer height = 1632
integer taborder = 10
string dataobject = "d_wv_facility_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event rowfocuschanged;call super::rowfocuschanged;//====================================================================
// $<event> rowfocuschanged()
// $<arguments>
// 	value	long	currentrow
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.14.2012
//====================================================================

if CurrentRow > 0 then
	this.SelectRow(0, false)
	this.SelectRow(CurrentRow, true)
	il_facility_id = this.GetItemNumber(CurrentRow, "facility_id")
	of_RetrieveStatement()
end if
end event

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type cb_close from commandbutton within w_wv_esign_agreement
integer x = 3168
integer y = 32
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close
// $<add> (Appeon) evan 02.13.2012
//====================================================================

Close(Parent)
end event

type tab_1 from tab within w_wv_esign_agreement
integer x = 1061
integer y = 144
integer width = 2464
integer height = 1628
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanged;//====================================================================
// $<event> selectionchanged()
// $<arguments>
// 	value	integer	oldindex
// 	value	integer	newindex
// $<returns> long
// $<description> N/A
// $<add> (Appeon) evan 02.13.2012
//====================================================================

choose case NewIndex
	case 1
		is_tab_type = "credentialing_data"
	case 2
		is_tab_type = "required_documents"
	case 3
		is_tab_type = "attestation_questions"
	case 4
		is_tab_type = "agreements"
	case 5
		is_tab_type = "request_privileges"
	case else
		is_tab_type = ""
end choose

of_RetrieveStatement()
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2427
integer height = 1512
long backcolor = 33551856
string text = "Credentialing Data"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2427
integer height = 1512
long backcolor = 33551856
string text = "Required Documents"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2427
integer height = 1512
long backcolor = 33551856
string text = "Attestation Questions"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2427
integer height = 1512
long backcolor = 33551856
string text = "Agreements"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 2427
integer height = 1512
long backcolor = 33551856
string text = "Request Privileges"
long tabtextcolor = 33554432
long tabbackcolor = 32891346
long picturemaskcolor = 536870912
end type

type gb_3 from groupbox within w_wv_esign_agreement
integer x = 32
integer y = 32
integer width = 1006
integer height = 1732
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Facility"
end type

type dw_statement from u_dw within w_wv_esign_agreement
integer x = 1134
integer y = 624
integer width = 2336
integer height = 1116
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_wv_esign_statement"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.SetTransObject(SQLCA)
end event

type rb_3 from radiobutton within w_wv_esign_agreement
integer x = 2176
integer y = 384
integer width = 343
integer height = 64
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Both"
end type

event clicked;is_appoint_type = "B"
of_RetrieveStatement()
end event

type rb_2 from radiobutton within w_wv_esign_agreement
integer x = 1632
integer y = 384
integer width = 448
integer height = 64
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Reappointment"
end type

event clicked;is_appoint_type = "R"
of_RetrieveStatement()
end event

type rb_1 from radiobutton within w_wv_esign_agreement
integer x = 1243
integer y = 384
integer width = 343
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Initial"
boolean checked = true
end type

event clicked;is_appoint_type = "I"
of_RetrieveStatement()
end event

