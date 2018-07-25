$PBExportHeader$w_webapi_expression.srw
$PBExportComments$Extended Expression dialog window
forward
global type w_webapi_expression from w_response
end type
type st_1 from statictext within w_webapi_expression
end type
type cb_ok from u_cb within w_webapi_expression
end type
type cb_cancel from u_cb within w_webapi_expression
end type
type cb_verify from u_cb within w_webapi_expression
end type
type mle_filter from u_mle within w_webapi_expression
end type
type gb_2 from u_gb within w_webapi_expression
end type
type gb_1 from u_gb within w_webapi_expression
end type
type tab_1 from tab within w_webapi_expression
end type
type tabpg_columns from userobject within tab_1
end type
type dw_columns from u_dw within tabpg_columns
end type
type tabpg_columns from userobject within tab_1
dw_columns dw_columns
end type
type tabpg_functions from userobject within tab_1
end type
type dw_functioncategory from u_dw within tabpg_functions
end type
type dw_function from u_dw within tabpg_functions
end type
type gb_3 from u_gb within tabpg_functions
end type
type st_help from u_st within tabpg_functions
end type
type st_syntax from u_st within tabpg_functions
end type
type tabpg_functions from userobject within tab_1
dw_functioncategory dw_functioncategory
dw_function dw_function
gb_3 gb_3
st_help st_help
st_syntax st_syntax
end type
type tabpg_operators from userobject within tab_1
end type
type lb_1 from u_lb within tabpg_operators
end type
type tabpg_operators from userobject within tab_1
lb_1 lb_1
end type
type tab_1 from tab within w_webapi_expression
tabpg_columns tabpg_columns
tabpg_functions tabpg_functions
tabpg_operators tabpg_operators
end type
type os_column from structure within w_webapi_expression
end type
end forward

type os_column from structure
	string		s_colname
	string		s_colnamedisplay
	string		s_dbname
end type

global type w_webapi_expression from w_response
integer x = 768
integer y = 404
integer width = 2135
integer height = 1748
string title = "Edit Expression"
long backcolor = 33551856
event type integer pfc_verify ( )
st_1 st_1
cb_ok cb_ok
cb_cancel cb_cancel
cb_verify cb_verify
mle_filter mle_filter
gb_2 gb_2
gb_1 gb_1
tab_1 tab_1
end type
global w_webapi_expression w_webapi_expression

type variables
Protected:
string		is_currentcolumn
str_webapi_exp	istr_in
n_cst_returnattrib	inv_return

String is_return
end variables

event type integer pfc_verify();//====================================================================
//$<Event>: pfc_verify
//$<Arguments>:
//$<Return>:  integer
//$<Description>: verify expression by ids_ds 
//$<Author>: (Appeon) long.zhang 08.10.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer	li_rc = 1
string		ls_expression, ls_rtn

ls_expression = mle_filter.text

if LenA (ls_expression) > 0 then
	// Test the filter
	//li_rc = lds_test.Describe(ls_expression)
	ls_rtn = istr_in.ds_source.Describe("evaluate('"+ls_expression+"',1)")
	If ls_rtn = '!' Then
		li_rc = -1
	End If
end if

return li_rc
end event

event open;call super::open;//====================================================================
//$<Event>: open
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

integer	li_upper
integer	li_cnt
string	ls_filter
String ERRORS,ls_sql, ls_dwsyntax_str
os_column	lstr_column[]
n_cst_string lnv_string
Int i

SetPointer (HourGlass!)
tab_1.tabpg_functions.gb_3.SetPosition (tobottom!)

istr_in = Message.PowerObjectParm

// Allow window to close without the CloseQuery checks being performed
ib_disableclosequery = true

// Start the base window service
this.of_SetBase (true)

// Center this window.
inv_base.of_Center()

// Display original filter in the filter mle.
ls_filter = istr_in.expression
If PosA(ls_filter, "~~~~'") > 0 And  PosA(ls_filter, "~~~~~~'") = 0 Then
	ls_filter = lnv_string.of_GlobalReplace(ls_filter, "~~~~'", "~~'")	
End If
mle_filter.text = ls_filter
mle_filter.SelectText (1, LenA (mle_filter.text))
mle_filter.SetFocus() 

// Display initial function categories
if tab_1.tabpg_functions.dw_functioncategory.RowCount() > 0 then
	tab_1.tabpg_functions.dw_functioncategory.SetRow (1)
	tab_1.tabpg_functions.dw_functioncategory.event rowfocuschanged (1)
	tab_1.tabpg_functions.dw_functioncategory.SelectRow (1, true)
end if

// Populate columns tabpage
li_upper = UpperBound (istr_in.is_columns[])
for li_cnt = 1 to li_upper
	lstr_column[li_cnt].s_colname = istr_in.is_columns[li_cnt]
	lstr_column[li_cnt].s_colnamedisplay = lstr_column[li_cnt].s_colname
	lstr_column[li_cnt].s_dbname = ''
next
If li_upper > 0 Then
	tab_1.tabpg_columns.dw_columns.object.data = lstr_column
	if tab_1.tabpg_columns.dw_columns.RowCount() > 0 then
		tab_1.tabpg_columns.dw_columns.SetRow (1)
		tab_1.tabpg_columns.dw_columns.event rowfocuschanged (1)
		tab_1.tabpg_columns.dw_columns.SelectRow (1, true)
	end if
End If

//Create a temp ds_source
If Not IsValid(istr_in.ds_source) Then
	ls_sql = "select ' ' as tmpstring from ids"
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, '', ERRORS)
	IF Len(ERRORS) > 0 THEN
		MessageBox("Error on Create temporary datastore","SyntaxFromSQL caused these errors: " + ERRORS + "~r~r" + ls_sql)
		RETURN -1
	END IF
	istr_in.ds_source = CREATE n_ds
	i = istr_in.ds_source.Create( ls_dwsyntax_str, ERRORS)
	if i < 1 then
		messagebox("Error on create temporary datastore",errors)
	end if
End If

//Insert one row
If istr_in.ds_source.rowcount() < 1 Then
	 istr_in.ds_source.Insertrow(0)
End If

//cb_verify.Post event clicked( )
end event

on w_webapi_expression.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_verify=create cb_verify
this.mle_filter=create mle_filter
this.gb_2=create gb_2
this.gb_1=create gb_1
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_verify
this.Control[iCurrent+5]=this.mle_filter
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.tab_1
end on

on w_webapi_expression.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_verify)
destroy(this.mle_filter)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.tab_1)
end on

event pfc_cancel;call super::pfc_cancel;// Close the window.
is_return = 'Cancel'
CloseWithReturn (this, 'Cancel')
end event

event pfc_default;call super::pfc_default;//====================================================================
//$<Event>: pfc_default
//$<Arguments>:
//$<Return>:  (None)
//$<Description>: Verify that expression is valid and return the valid expression.
//$<Author>: (Appeon) long.zhang 08.10.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

// Verify that expression is valid
if this.event pfc_verify() = -1 then
	MessageBox ("Verify", &
		"Expression is not valid.  Please modify the Expression using the available " + &
		"functions, columns, operators, and values.  The Verify button may be "+&
		"used to determine if the filter is valid.", &
		Information!, OK!, 1)
	return
end if


// Close the window.
is_return = 'OK'
CloseWithReturn (this, mle_filter.text)

end event

event close;call super::close;If is_return <> 'OK' Then
	CloseWithReturn(this, 'Cancel')
End If
end event

type st_1 from statictext within w_webapi_expression
integer x = 41
integer y = 24
integer width = 1317
integer height = 72
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Note: Don~'t use single quotes in this expression."
boolean focusrectangle = false
end type

type cb_ok from u_cb within w_webapi_expression
integer x = 1285
integer y = 1536
integer width = 375
integer taborder = 40
string text = "OK"
boolean default = true
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Parent.Event pfc_default()

end event

type cb_cancel from u_cb within w_webapi_expression
integer x = 1673
integer y = 1536
integer width = 375
integer taborder = 50
string text = "Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;//====================================================================
//$<Event>: clicked
//$<Arguments>:
//$<Return>:  long
//$<Description>: 
//$<Author>: (Appeon) long.zhang 08.11.2015 (v15.1 Verification API)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Parent.Event pfc_Cancel ()

end event

type cb_verify from u_cb within w_webapi_expression
integer x = 1637
integer y = 188
integer width = 375
integer taborder = 20
string text = "&Verify"
boolean cancel = true
end type

event clicked;call super::clicked;integer	li_rc

li_rc = parent.event pfc_verify()
if li_rc = 1 then
	MessageBox ("Verify", "Expression is valid", &
		Information!, OK!, 1)
else
	MessageBox ( "Verify", "Expression is not valid", &
		Information!, OK!, 1)	
end if
end event

type mle_filter from u_mle within w_webapi_expression
integer x = 82
integer y = 188
integer width = 1518
integer height = 244
integer taborder = 10
long textcolor = 33554687
long backcolor = 33551856
integer accelerator = 102
boolean hideselection = false
end type

type gb_2 from u_gb within w_webapi_expression
integer x = 27
integer y = 520
integer width = 2039
integer height = 992
integer taborder = 0
long backcolor = 33551856
string text = "Build with"
end type

type gb_1 from u_gb within w_webapi_expression
integer x = 27
integer y = 108
integer width = 2039
integer height = 368
integer taborder = 0
long backcolor = 33551856
string text = "Expression"
end type

type tab_1 from tab within w_webapi_expression
integer x = 64
integer y = 600
integer width = 1943
integer height = 884
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean showpicture = false
integer selectedtab = 1
tabpg_columns tabpg_columns
tabpg_functions tabpg_functions
tabpg_operators tabpg_operators
end type

on tab_1.create
this.tabpg_columns=create tabpg_columns
this.tabpg_functions=create tabpg_functions
this.tabpg_operators=create tabpg_operators
this.Control[]={this.tabpg_columns,&
this.tabpg_functions,&
this.tabpg_operators}
end on

on tab_1.destroy
destroy(this.tabpg_columns)
destroy(this.tabpg_functions)
destroy(this.tabpg_operators)
end on

type tabpg_columns from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1906
integer height = 768
long backcolor = 33551856
string text = "Columns"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_columns dw_columns
end type

on tabpg_columns.create
this.dw_columns=create dw_columns
this.Control[]={this.dw_columns}
end on

on tabpg_columns.destroy
destroy(this.dw_columns)
end on

type dw_columns from u_dw within tabpg_columns
integer x = 32
integer y = 56
integer width = 1838
integer height = 684
integer taborder = 2
string dataobject = "d_columnnames"
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked columnname into the filter expression
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_colname

if row > 0 then
	ls_colname = this.object.columnname[row]
	mle_filter.ReplaceText (ls_colname)
end if
end event

type tabpg_functions from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1906
integer height = 768
long backcolor = 33551856
string text = "Functions"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_functioncategory dw_functioncategory
dw_function dw_function
gb_3 gb_3
st_help st_help
st_syntax st_syntax
end type

on tabpg_functions.create
this.dw_functioncategory=create dw_functioncategory
this.dw_function=create dw_function
this.gb_3=create gb_3
this.st_help=create st_help
this.st_syntax=create st_syntax
this.Control[]={this.dw_functioncategory,&
this.dw_function,&
this.gb_3,&
this.st_help,&
this.st_syntax}
end on

on tabpg_functions.destroy
destroy(this.dw_functioncategory)
destroy(this.dw_function)
destroy(this.gb_3)
destroy(this.st_help)
destroy(this.st_syntax)
end on

type dw_functioncategory from u_dw within tabpg_functions
integer x = 18
integer y = 28
integer width = 677
integer height = 408
integer taborder = 2
string dataobject = "d_dwfunctioncategory"
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//
//	Description:
//	Filter functions to the correct category
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_category

if currentrow > 0 then
	inv_rowselect.of_RowSelect (currentrow)

	ls_category = GetItemString (currentrow, "category")
	dw_function.SetFilter ("category = '" + ls_category + "'")
	dw_function.Filter()
	if dw_function.RowCount() > 0 then
		dw_function.SetRow (1)
		dw_function.event rowfocuschanged (1)
	end if
end if
end event

type dw_function from u_dw within tabpg_functions
integer x = 713
integer y = 28
integer width = 1152
integer height = 412
integer taborder = 2
string dataobject = "d_dwfunction"
end type

event rowfocuschanged;call super::rowfocuschanged;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rowfocuschanged
//
//	Description:
//	Update syntax and help for the current function
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_syntax
string	ls_help

if currentrow > 0 then
	inv_rowselect.of_RowSelect (currentrow)

	ls_syntax = this.GetItemString (currentrow, "syntax")
	ls_help = this.GetItemString (currentrow, "help")

	st_syntax.text = ls_syntax
	st_help.text = ls_help
end if
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  constructor
//
//	Description:
//	Initialize control
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

of_SetRowSelect (true)
ib_rmbmenu = false
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked function syntax into the filter expression
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_position
long		ll_pos
long		ll_pos2
string		ls_syntax

if row > 0 then
	ls_syntax = this.object.syntax[row]
	li_position = mle_filter.Position()
	mle_filter.ReplaceText (ls_syntax)

	// Select expression between parenthesis
	if li_position > 0 then
		ll_pos = PosA (mle_filter.text, "(", li_position)
		if ll_pos > 0 then
			ll_pos2 = PosA (mle_filter.text, ")", li_position)
			if ll_pos2 > 0 then
				mle_filter.SelectText (ll_pos + 1, ll_pos2 - ll_pos - 1)
			end if
		end if
	end if	
end if
end event

type gb_3 from u_gb within tabpg_functions
integer x = 18
integer y = 448
integer width = 1847
integer height = 308
integer taborder = 2
long backcolor = 33551856
string text = "Syntax"
end type

type st_help from u_st within tabpg_functions
integer x = 46
integer y = 584
integer width = 1792
integer height = 156
boolean bringtotop = true
long backcolor = 33551856
end type

type st_syntax from u_st within tabpg_functions
integer x = 46
integer y = 508
integer width = 1765
integer weight = 700
long backcolor = 79741120
end type

type tabpg_operators from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1906
integer height = 768
long backcolor = 33551856
string text = "Operators"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
lb_1 lb_1
end type

on tabpg_operators.create
this.lb_1=create lb_1
this.Control[]={this.lb_1}
end on

on tabpg_operators.destroy
destroy(this.lb_1)
end on

type lb_1 from u_lb within tabpg_operators
integer x = 32
integer y = 56
integer width = 1838
integer height = 684
integer taborder = 2
string item[] = {"=","<",">","<=",">=","and","or","not","(",")"}
end type

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Description:
//	Pastes the clicked operator into the filter expression
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_selecteditem

ls_selecteditem = this.SelectedItem()
mle_filter.ReplaceText (" " + ls_selecteditem + " ")

end event

