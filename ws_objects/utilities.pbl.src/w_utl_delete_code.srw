$PBExportHeader$w_utl_delete_code.srw
forward
global type w_utl_delete_code from window
end type
type cb_4 from commandbutton within w_utl_delete_code
end type
type cb_3 from commandbutton within w_utl_delete_code
end type
type cbx_2 from checkbox within w_utl_delete_code
end type
type cbx_1 from checkbox within w_utl_delete_code
end type
type cb_2 from commandbutton within w_utl_delete_code
end type
type cb_1 from commandbutton within w_utl_delete_code
end type
type dw_address from datawindow within w_utl_delete_code
end type
type dw_code from datawindow within w_utl_delete_code
end type
type dw_data from datawindow within w_utl_delete_code
end type
type cb_close from commandbutton within w_utl_delete_code
end type
type cb_delete from commandbutton within w_utl_delete_code
end type
type gb_1 from groupbox within w_utl_delete_code
end type
type gb_3 from groupbox within w_utl_delete_code
end type
type gb_2 from groupbox within w_utl_delete_code
end type
end forward

global type w_utl_delete_code from window
integer width = 3867
integer height = 2268
boolean titlebar = true
string title = "Delete Redundant Lookup Records"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cbx_2 cbx_2
cbx_1 cbx_1
cb_2 cb_2
cb_1 cb_1
dw_address dw_address
dw_code dw_code
dw_data dw_data
cb_close cb_close
cb_delete cb_delete
gb_1 gb_1
gb_3 gb_3
gb_2 gb_2
end type
global w_utl_delete_code w_utl_delete_code

type variables
string is_SQLErrText
end variables

forward prototypes
public function integer of_delete (datawindow adw_data, string as_table, long al_row)
end prototypes

public function integer of_delete (datawindow adw_data, string as_table, long al_row);long i, al_Rowcount
long ll_lookup_code
string ls_code
string ls_lookup_name

if al_Row <= 0 then Return -1
ls_lookup_name = adw_data.GetItemString(al_Row, "lookup_name")
ll_lookup_code = adw_data.GetItemNumber(al_Row, "lookup_code")
ls_code = adw_data.getitemstring(al_Row, 'code')

//$<add> 03.13.2007 By: Jack (Contract)
//$<reason> fix a defect.
If Lower(ls_lookup_name) = 'contract category' Or lower(ls_lookup_name) = 'contract clause category' Then
	datastore lds_contract
	datastore lds_folder
	datastore lds_template
	datastore lds_document
	datastore lds_contract_management_right
	
	lds_contract = Create datastore
	lds_folder = Create datastore
	lds_template = Create datastore
	lds_document = Create datastore
	lds_contract_management_right = Create datastore
	
	lds_contract.dataobject = 'd_lookup_contract'
	lds_contract.settransobject(sqlca)
	lds_folder.dataobject = 'd_lookup_folder'
	lds_folder.settransobject(sqlca)
	lds_template.dataobject = 'd_lookup_template'
	lds_template.settransobject(sqlca)
	lds_document.dataobject = 'd_lookup_document'
	lds_document.settransobject(sqlca)
	lds_contract_management_right.dataobject = 'd_lookup_contract_management_right'
	lds_contract_management_right.settransobject(sqlca)
	
	gnv_appeondb.of_startqueue( )
	lds_contract.retrieve(ll_lookup_code)	
	lds_folder.retrieve(ll_lookup_code)	
	lds_template.retrieve(ll_lookup_code)	
	lds_document.retrieve(ll_lookup_code)	
	lds_contract_management_right.retrieve(ll_lookup_code)	
	gnv_appeondb.of_commitqueue( )
	
	al_Rowcount = lds_contract.rowcount()
	
	If al_Rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Contract Folder->Detail->Category field. Please modify that field first.")
		Return -1
	End If
	al_Rowcount = lds_folder.rowcount()
	If al_Rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Clause Painter module. Please modify the Category in the Folder table.")
		Return -1
	End If
	
	al_Rowcount = lds_template.rowcount()
	If al_Rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Template Painter module. Please modify the Category in the Template table.")
		Return -1
	End If
	al_Rowcount = lds_document.rowcount()
	If al_Rowcount > 0 Then
		messagebox("Lookup Data for code - " + ls_code,"Category lookup is required by the Document Painter or Document Manager module. Please modify the Category in the Document table.")
		Return -1
	End If
	al_Rowcount = lds_contract_management_right.rowcount()
	If al_Rowcount > 0 Then
		For i = al_Rowcount to 1 Step -1
			lds_contract_management_right.deleterow(i)
		Next		
		if lds_contract_management_right.update() = -1 then
			MessageBox("Error", "Delete Contract Management Right Error.")
			Return -1
		end if
	End If
	destroy lds_contract
	destroy lds_folder
	destroy lds_template
	destroy lds_document
	destroy lds_contract_management_right
End If

//IF department security is set to ON then track records being deleted so you can delete after save
//IF ii_dept_secure_setting = 1 THEN
//	ii_delete_cnt++
//	il_department_code[ ii_delete_cnt ] = adw_data.GetItemNumber( adw_data.GetRow( ), "lookup_code" )
//END IF
if Upper(ls_lookup_name) = "DEPARTMENT" and gi_dept_security = 1 then
	DELETE
		FROM security_user_department
		WHERE department_id = :ll_lookup_code;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Delete Department Error", SQLCA.SQLERRTEXT)
			Return -1
		END IF
end if

// Delete redundant lookup record
adw_data.DeleteRow(al_Row)
if adw_data.Update() = 1 then
	Commit;		
	Return 1
else
	Rollback;
	adw_data.ResetUpdate()
	MessageBox("Delete Redundant Lookup Record Error", is_SQLErrText, StopSign!)
	Return -1
end if
end function

on w_utl_delete_code.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_address=create dw_address
this.dw_code=create dw_code
this.dw_data=create dw_data
this.cb_close=create cb_close
this.cb_delete=create cb_delete
this.gb_1=create gb_1
this.gb_3=create gb_3
this.gb_2=create gb_2
this.Control[]={this.cb_4,&
this.cb_3,&
this.cbx_2,&
this.cbx_1,&
this.cb_2,&
this.cb_1,&
this.dw_address,&
this.dw_code,&
this.dw_data,&
this.cb_close,&
this.cb_delete,&
this.gb_1,&
this.gb_3,&
this.gb_2}
end on

on w_utl_delete_code.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_address)
destroy(this.dw_code)
destroy(this.dw_data)
destroy(this.cb_close)
destroy(this.cb_delete)
destroy(this.gb_1)
destroy(this.gb_3)
destroy(this.gb_2)
end on

event open;string ls_SQLSelect
string ls_Syntax
string ls_Error

//Batch DW
ls_SQLSelect = "select seq_no batch, backupdate backup_time from code_lookup_bak group by seq_no, backupdate order by seq_no ASC"
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then Return

dw_data.Create(ls_Syntax, ls_Error)
dw_data.SetTransObject(SQLCA)
dw_data.Retrieve()
if dw_data.RowCount() > 0 then
	dw_data.Post Event RowFocusChanged(1)
end if
dw_data.Post SetPosition(ToTop!)

//Code DW
ls_SQLSelect = "select * from code_lookup"
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then Return
dw_code.Create(ls_Syntax, ls_Error)
dw_code.SetTransObject(SQLCA)
dw_code.Post SetPosition(ToTop!)

//Address DW
ls_SQLSelect = "select * from address_lookup"
ls_Syntax = SQLCA.SyntaxFromSQL(ls_SQLSelect, "Style(Type=Grid)", ls_Error)
if LenA(ls_Error) > 0 then Return
dw_address.Create(ls_Syntax, ls_Error)
dw_address.SetTransObject(SQLCA)
dw_address.Post SetPosition(ToTop!)
end event

type cb_4 from commandbutton within w_utl_delete_code
integer x = 2601
integer y = 2024
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete &All"
end type

event clicked;int i
long ll_RowCount

ll_RowCount = dw_address.RowCount()
if ll_RowCount <= 0 then Return
if cbx_2.Checked then
	if MessageBox("Delete Confirm", "Are you sure that you want to permanently delete all records.", Question!, YesNo!) = 2 then
		Return
	end if
end if

for i = 1 to ll_RowCount
	of_Delete(dw_address, "address_lookup", 1)
next
gb_2.Text = "Address Redundant Lookup Records = " + String(dw_address.RowCount())
end event

type cb_3 from commandbutton within w_utl_delete_code
integer x = 2601
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete &All"
end type

event clicked;int i
long ll_RowCount

ll_RowCount = dw_code.RowCount()
if ll_RowCount <= 0 then Return
if cbx_1.Checked then
	if MessageBox("Delete Confirm", "Are you sure that you want to permanently delete all records.", Question!, YesNo!) = 2 then
		Return
	end if
end if

for i = 1 to ll_RowCount
	of_Delete(dw_code, "code_lookup", 1)
next
gb_1.Text = "Code Redundant Lookup Records = " + String(dw_code.RowCount())
end event

type cbx_2 from checkbox within w_utl_delete_code
integer x = 1481
integer y = 2044
integer width = 603
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Confirm before delete"
boolean checked = true
end type

type cbx_1 from checkbox within w_utl_delete_code
integer x = 1481
integer y = 1052
integer width = 608
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Confirm before delete"
boolean checked = true
end type

type cb_2 from commandbutton within w_utl_delete_code
integer x = 2181
integer y = 2028
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;if dw_address.RowCount() <= 0 then Return
if cbx_2.Checked then
	if MessageBox("Delete Confirm", "Are you sure that you want to permanently delete the selected record.", Question!, YesNo!) = 2 then
		Return
	end if
end if

of_Delete(dw_address, "address_lookup", dw_address.GetRow())
gb_2.Text = "Address Redundant Lookup Records = " + String(dw_address.RowCount())
end event

type cb_1 from commandbutton within w_utl_delete_code
integer x = 2181
integer y = 1036
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;if dw_code.RowCount() <= 0 then Return
if cbx_1.Checked then
	if MessageBox("Delete Confirm", "Are you sure that you want to permanently delete the selected record.", Question!, YesNo!) = 2 then
		Return
	end if
end if

of_Delete(dw_code, "code_lookup", dw_code.GetRow())
gb_1.Text = "Code Redundant Lookup Records = " + String(dw_code.RowCount())
end event

type dw_address from datawindow within w_utl_delete_code
integer x = 1074
integer y = 1216
integer width = 2738
integer height = 796
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event dberror;is_SQLErrText = SQLErrText
Return 1
end event

type dw_code from datawindow within w_utl_delete_code
integer x = 1074
integer y = 224
integer width = 2738
integer height = 796
integer taborder = 20
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
end event

event dberror;is_SQLErrText = SQLErrText
Return 1
end event

type dw_data from datawindow within w_utl_delete_code
integer x = 59
integer y = 224
integer width = 946
integer height = 1888
integer taborder = 10
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;long ll_Batch
string ls_SQLSelect

this.SelectRow(0, false)
this.SelectRow(CurrentRow, true)
ll_Batch = this.object.batch[currentrow]

ls_SQLSelect = "select * from code_lookup " + &
   "where (IsNull(type,'') <> 'S') and (lookup_code not in (select lookup_code from code_lookup_bak where seq_no = " + String(ll_Batch) + "))"
dw_code.SetSQLSelect(ls_SQLSelect)
dw_code.Retrieve()
gb_1.Text = "Code Redundant Lookup Records = " + String(dw_code.RowCount())

ls_SQLSelect = "select * from address_lookup " + &
   "where lookup_code not in (select lookup_code from address_lookup_bak where seq_no = " + String(ll_Batch) + ")"
dw_address.SetSQLSelect(ls_SQLSelect)
dw_address.Retrieve()
gb_2.Text = "Address Redundant Lookup Records = " + String(dw_address.RowCount())
end event

type cb_close from commandbutton within w_utl_delete_code
integer x = 3465
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_delete from commandbutton within w_utl_delete_code
boolean visible = false
integer x = 187
integer y = 2020
integer width = 681
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Redundant Records"
boolean default = true
end type

event clicked;long ll_Batch
long ll_deletecount_code
long ll_addresscount_address
string ls_Message
DateTime ldt_Now

if dw_data.GetRow() <= 0 then Return
ll_Batch = dw_data.GetItemNumber(dw_data.GetRow(), "batch")

// Get delete count
/*
gnv_appeondb.of_StartQueue()
select count(*) into: ll_deletecount_code from code_lookup 
   where (IsNull(type,'') <> 'S') and (lookup_code not in (select lookup_code from code_lookup_bak where seq_no = :ll_Batch));

select count(*) into: ll_addresscount_address from address_lookup 
   where lookup_code not in (select lookup_code from address_lookup_bak where seq_no = :ll_Batch);
gnv_appeondb.of_CommitQueue()

if IsNull(ll_deletecount_code) then ll_deletecount_code = 0
if IsNull(ll_addresscount_address) then ll_addresscount_address = 0
*/
ll_deletecount_code = dw_code.RowCount()
ll_addresscount_address = dw_address.RowCount()
if ll_deletecount_code = 0 and ll_addresscount_address = 0 then
	MessageBox("Prompt", "No redundant lookup record can be delete.")
	Return
end if

// Prompt delete
ls_Message = "Redundant lookup records:~r~n"
ls_Message += "Code Lookup = " + String(ll_deletecount_code) + "~r~n"
ls_Message += "Address Lookup = " + String(ll_addresscount_address) + "~r~n~r~n"
ls_Message += "Are you sure you want to delete redundant lookup records?"
if MessageBox("Delete", ls_Message, Question!, YesNo!) = 2 then Return

SetPointer(HourGlass!)
ldt_Now = DateTime(Today(), Now())

// Delete code redundant lookup records
if ll_deletecount_code > 0 then
	insert into sys_code_lookup_audit(lookup_type,lookup_code,code,lookup_name,audit_type,modified_date)
       select 'C',lookup_code,code,lookup_name,'D', :ldt_Now from code_lookup
              where (IsNull(type,'') <> 'S') and (lookup_code not in (select lookup_code from code_lookup_bak where seq_no = :ll_Batch));
	delete from code_lookup
	  where (IsNull(type,'') <> 'S') and (lookup_code not in (select lookup_code from code_lookup_bak where seq_no = :ll_Batch));
	if SQLCA.SQLCode <> 0 then	MessageBox("Delete records of Code Lookup occurs error", SQLCA.SQLErrText)
end if

// Delete address redundant lookup records
if ll_addresscount_address > 0 then
	insert into sys_code_lookup_audit(lookup_type,lookup_code,code,lookup_name,audit_type,modified_date)
			 select 'C',lookup_code,code,lookup_name,'D', :ldt_Now from address_lookup
					  where lookup_code not in (select lookup_code from address_lookup_bak where seq_no = :ll_Batch);	
	delete from address_lookup
	  where lookup_code not in (select lookup_code from address_lookup_bak where seq_no = :ll_Batch);
	if SQLCA.SQLCode <> 0 then	MessageBox("Delete records of Address Lookup occurs error", SQLCA.SQLErrText)
end if
Commit;

SetPointer(Arrow!)
dw_code.Reset()
dw_address.Reset()

MessageBox("Finish", "Delete redundant lookup records finished.")
end event

type gb_1 from groupbox within w_utl_delete_code
integer x = 1051
integer y = 160
integer width = 2789
integer height = 988
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Code Redundant Lookup Records"
end type

type gb_3 from groupbox within w_utl_delete_code
integer x = 37
integer y = 160
integer width = 997
integer height = 1976
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Backup Batch"
end type

type gb_2 from groupbox within w_utl_delete_code
integer x = 1051
integer y = 1152
integer width = 2789
integer height = 988
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Address Redundant Lookup Records"
end type

