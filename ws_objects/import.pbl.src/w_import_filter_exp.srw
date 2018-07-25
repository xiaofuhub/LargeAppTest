$PBExportHeader$w_import_filter_exp.srw
forward
global type w_import_filter_exp from w_response
end type
type dw_filter from u_dw within w_import_filter_exp
end type
type cb_save from commandbutton within w_import_filter_exp
end type
type cb_delete from commandbutton within w_import_filter_exp
end type
type cb_add from commandbutton within w_import_filter_exp
end type
type cb_close from commandbutton within w_import_filter_exp
end type
type gb_1 from groupbox within w_import_filter_exp
end type
end forward

global type w_import_filter_exp from w_response
integer width = 1678
integer height = 1144
string title = "Date Range Settings"
long backcolor = 33551856
dw_filter dw_filter
cb_save cb_save
cb_delete cb_delete
cb_add cb_add
cb_close cb_close
gb_1 gb_1
end type
global w_import_filter_exp w_import_filter_exp

type variables
string is_OldExpression
boolean ib_PromptSave = false
end variables

forward prototypes
public function integer of_buildexpression (ref string as_expression)
public function integer of_verifyexpression (string as_expression)
public function integer of_getimportfields (long al_import_id)
public function string of_parsefiltercriteria (long al_import_id)
end prototypes

public function integer of_buildexpression (ref string as_expression);//====================================================================
// $<function> of_buildexpression()
// $<arguments>
// 	ref	string	as_expression
// $<returns> integer
// $<description> Build filter expression
// $<add> (Appeon) Evan 07.21.2011
//====================================================================

string ls_operator
string ls_date_field
string ls_date_value
integer i, li_RowCount

if dw_filter.AcceptText() = -1 then	Return -1
li_RowCount = dw_filter.RowCount()
as_Expression = ""

for i = 1 to li_RowCount
	ls_date_field = dw_filter.object.date_field[i]
	ls_operator = dw_filter.object.operator[i]
	if IsNull(dw_filter.object.date_value[i]) then
		SetNull(ls_date_value)
	else
		ls_date_value = String(dw_filter.object.date_value[i], "yyyy-mm-dd")
	end if
	
	if IsNull(ls_date_field) and IsNull(ls_operator) and IsNull(ls_date_value) then
		continue
	end if
	if IsNull(ls_date_field) then
		dw_filter.SetColumn("date_field")
		dw_filter.ScrollToRow(i)
		MessageBox("Prompt", "Please select date field.")
		dw_filter.SetFocus()
		Return -1
	end if
	if IsNull(ls_operator) then
		dw_filter.SetColumn("operator")
		dw_filter.ScrollToRow(i)
		MessageBox("Prompt", "Please select operator.")
		dw_filter.SetFocus()
		Return -1
	end if
	if IsNull(ls_date_value) then
		dw_filter.SetColumn("date_value")
		dw_filter.ScrollToRow(i)
		MessageBox("Prompt", "Please select date value.")
		dw_filter.SetFocus()
		Return -1
	end if
	
	if as_Expression <> "" then as_Expression += " and "
	as_Expression += ls_date_field + " " + ls_operator + " '" + ls_date_value + "'"
next

if as_Expression = "" then
	SetNull(as_Expression)
end if

Return 1
end function

public function integer of_verifyexpression (string as_expression);//====================================================================
// $<function> of_verifyexpression()
// $<arguments>
// 	value	string	as_expression
// $<returns> integer
// $<description> Verify filter expression
// $<add> (Appeon) Evan 07.21.2011
//====================================================================

integer li_FindRow
integer i, li_FieldCount
string  ls_date_field
datawindowchild ldwc_child

dw_filter.GetChild("date_field", ldwc_child)
li_FieldCount = dw_filter.RowCount()

for i = 1 To li_FieldCount
	ls_date_field = Lower(Trim(dw_filter.GetItemString(i, "date_field")))
	if IsNull(ls_date_field) or ls_date_field = "" then continue
	li_FindRow = ldwc_child.Find("lower(trim(imp_field_name)) = '" + ls_date_field + "'", 1, ldwc_child.RowCount())
	if li_FindRow < 1 then
		dw_filter.SetColumn("date_field")
		dw_filter.ScrollToRow(i)
		MessageBox("Error", "The '" + ls_date_field + "' date field wasn't created in Field Setup.", StopSign!)
		dw_filter.SetFocus()
		Return -1
	end if
next

Return 1
end function

public function integer of_getimportfields (long al_import_id);//====================================================================
// $<function> of_getimportfields()
// $<arguments>
// 	value	long	al_import_id
// $<returns> integer
// $<description> Get import fields
// $<add> (Appeon) Evan 07.20.2011
//====================================================================

integer li_rc
datawindowchild ldwc_child

dw_filter.GetChild("date_field", ldwc_child)
ldwc_child.SetTransObject(SQLCA)
li_rc = ldwc_child.Retrieve(al_import_id)

Return li_rc
end function

public function string of_parsefiltercriteria (long al_import_id);//====================================================================
// $<function> of_parsefiltercriteria()
// $<arguments>
// 	value	long			al_import_id
// $<returns> string
// $<description> Parse filter criteria to datawindow
// $<add> (Appeon) evan 07.21.2011
//====================================================================

string ls_NullArr[]
string ls_Fields[]
string ls_Records[]
string ls_Expression
integer li_Rcount
integer li_Fcount
integer i, li_Row
n_cst_string lnv_string

// Get filter expression
SELECT filter_exp INTO :ls_Expression FROM import_hdr WHERE import_id = :al_import_id;
if IsNull(ls_Expression) or Trim(ls_Expression) = "" then Return ""

// Parse expression to datawindow
dw_filter.Reset()
lnv_string.of_ParseToArray(ls_Expression, "and", ls_Records[])
li_Rcount = UpperBound(ls_Records)
for i = 1 to li_Rcount	
	lnv_string.of_ParseToArray(Trim(ls_Records[i]), " ", ls_Fields[])
	li_Fcount = UpperBound(ls_Fields)
	li_Row = dw_filter.InsertRow(0)
	if li_Fcount > 0 then dw_filter.SetItem(li_Row, "date_field", Trim(ls_Fields[1]))
	if li_Fcount > 1 then dw_filter.SetItem(li_Row, "operator", Trim(ls_Fields[2]))
	if li_Fcount > 2 then
		ls_Fields[3] = Trim(ls_Fields[3])
		ls_Fields[3] = Mid(ls_Fields[3], 2, 10)
		dw_filter.SetItem(li_Row, "date_value", Date(ls_Fields[3]))
	end if
	ls_Fields[] = ls_NullArr[]
next

if dw_filter.RowCount() < 1 then
	cb_add.Event Clicked()
end if
dw_filter.ResetUpdate()

Return ls_Expression
end function

on w_import_filter_exp.create
int iCurrent
call super::create
this.dw_filter=create dw_filter
this.cb_save=create cb_save
this.cb_delete=create cb_delete
this.cb_add=create cb_add
this.cb_close=create cb_close
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_filter
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_delete
this.Control[iCurrent+4]=this.cb_add
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.gb_1
end on

on w_import_filter_exp.destroy
call super::destroy
destroy(this.dw_filter)
destroy(this.cb_save)
destroy(this.cb_delete)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.gb_1)
end on

event open;call super::open;//V11.3 QA Import – Evan 07.20.2011

long ll_import_id
long ll_SelFieldCount
datawindow ldw_imp_hdr

ldw_imp_hdr = w_import_painter.tab_1.tabpage_hdr.dw_imp_hdr
ll_import_id = ldw_imp_hdr.GetItemNumber(ldw_imp_hdr.GetRow(), "import_id")
ll_SelFieldCount = of_GetImportFields(ll_import_id)
is_OldExpression = of_ParseFilterCriteria(ll_import_id)

if ldw_imp_hdr.GetItemNumber(ldw_imp_hdr.GetRow(), "lock_file") = 1 then
	cb_add.Enabled = false
	cb_delete.Enabled = false
	cb_save.Enabled = false
	dw_filter.Modify("datawindow.readonly = 'yes'")
end if

if ll_SelFieldCount < 1 and (IsNull(is_OldExpression) or is_OldExpression = "") then
	Post of_MessageBox("", "Warnning", "Please create imoprt fields in Field Setup.", Exclamation!, OK!, 1)
else
	Post of_VerifyExpression(is_OldExpression)
end if
end event

event closequery;call super::closequery;//V11.3 QA Import – Evan 07.22.2011

if dw_filter.ModifiedCount() > 0 or ib_PromptSave then
	if MessageBox("Save", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if	
end if

Return 0
end event

type dw_filter from u_dw within w_import_filter_exp
integer x = 101
integer y = 196
integer width = 1458
integer height = 800
integer taborder = 10
string dataobject = "d_import_filter_exp"
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;this.of_SetUpdateable(false)
this.of_SetDropDownCalendar(true)
this.InsertRow(0)
end event

type cb_save from commandbutton within w_import_filter_exp
integer x = 37
integer y = 8
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Save filter criteria
// $<add> (Appeon) Evan 07.21.2011
//====================================================================

long ll_import_id
string ls_NewExpression
datawindow ldw_imp_hdr
datawindow ldw_browse
datawindow ldw_imp_sql

if of_BuildExpression(ls_NewExpression) = -1 then Return -1
if of_VerifyExpression(ls_NewExpression) = -1 then Return -1
if ls_NewExpression = is_OldExpression then Return 1
is_OldExpression = ls_NewExpression

// Save filter criteria to database
ldw_imp_hdr = w_import_painter.tab_1.tabpage_hdr.dw_imp_hdr
ll_import_id = ldw_imp_hdr.GetItemNumber(ldw_imp_hdr.GetRow(), "import_id")
gnv_appeondb.of_StartQueue()
UPDATE import_hdr SET filter_exp = :ls_NewExpression WHERE import_id = :ll_import_id;
COMMIT;
gnv_appeondb.of_CommitQueue()
dw_filter.ResetUpdate()
ib_PromptSave = false

// Set expression of datawindow
ldw_browse = w_import_painter.tab_1.tabpage_hdr.dw_browse
ldw_imp_sql = w_import_painter.tab_1.tabpage_hdr.dw_imp_sql
ldw_imp_hdr.SetItem(ldw_imp_hdr.GetRow(), "filter_exp", ls_NewExpression)
ldw_browse.SetItemStatus(ldw_browse.GetRow(), "filter_exp", Primary!, NotModified!)
ldw_imp_hdr.SetItemStatus(ldw_imp_hdr.GetRow(), "filter_exp", Primary!, NotModified!)
ldw_imp_sql.SetItemStatus(ldw_imp_sql.GetRow(), "filter_exp", Primary!, NotModified!)

Return 1
end event

type cb_delete from commandbutton within w_import_filter_exp
integer x = 777
integer y = 8
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Filter"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Delete filter criteria
// $<add> (Appeon) Evan 07.20.2011
//====================================================================

long ll_Row
DwItemStatus ldws_status

ll_Row = dw_filter.GetRow()
if ll_Row > 0 then
	ldws_status = dw_filter.GetItemStatus(ll_Row, 0, Primary!)
	if ldws_status = NotModified! or ldws_status = DataModified! then
		ib_PromptSave = true
	end if
end if

dw_filter.DeleteRow(0)
dw_filter.SetFocus()

if dw_filter.RowCount() < 1 then
	cb_add.Event Clicked()
end if
end event

type cb_add from commandbutton within w_import_filter_exp
integer x = 407
integer y = 8
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add Filter"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Add filter criteria
// $<add> (Appeon) Evan 07.20.2011
//====================================================================

long ll_Row

ll_Row = dw_filter.InsertRow(0)
dw_filter.ScrollToRow(ll_Row)
dw_filter.SetColumn("date_field")
dw_filter.SetFocus()
end event

type cb_close from commandbutton within w_import_filter_exp
integer x = 1248
integer y = 8
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//====================================================================
// $<event> clicked()
// $<arguments>
// $<returns> long
// $<description> Close window
// $<add> (Appeon) Evan 07.20.2011
//====================================================================

Close(Parent)
end event

type gb_1 from groupbox within w_import_filter_exp
integer x = 50
integer y = 144
integer width = 1541
integer height = 876
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filters"
end type

