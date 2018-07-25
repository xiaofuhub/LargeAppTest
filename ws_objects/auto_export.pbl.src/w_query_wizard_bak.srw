$PBExportHeader$w_query_wizard_bak.srw
forward
global type w_query_wizard_bak from window
end type
type mle_syntax from multilineedit within w_query_wizard_bak
end type
type cb_4 from commandbutton within w_query_wizard_bak
end type
type st_screen from statictext within w_query_wizard_bak
end type
type cb_cancel from commandbutton within w_query_wizard_bak
end type
type cb_syntax from commandbutton within w_query_wizard_bak
end type
type st_syntax from statictext within w_query_wizard_bak
end type
type ddlb_3 from dropdownlistbox within w_query_wizard_bak
end type
type cb_2 from commandbutton within w_query_wizard_bak
end type
type st_null3 from statictext within w_query_wizard_bak
end type
type st_null2 from statictext within w_query_wizard_bak
end type
type st_null1 from statictext within w_query_wizard_bak
end type
type dw_crit3 from datawindow within w_query_wizard_bak
end type
type st_rf from statictext within w_query_wizard_bak
end type
type st_date3 from statictext within w_query_wizard_bak
end type
type st_date2 from statictext within w_query_wizard_bak
end type
type st_date1 from statictext within w_query_wizard_bak
end type
type dw_v3 from datawindow within w_query_wizard_bak
end type
type dw_v2 from datawindow within w_query_wizard_bak
end type
type dw_v1 from datawindow within w_query_wizard_bak
end type
type ddlb_2 from dropdownlistbox within w_query_wizard_bak
end type
type ddlb_1 from dropdownlistbox within w_query_wizard_bak
end type
type st_5 from statictext within w_query_wizard_bak
end type
type st_4 from statictext within w_query_wizard_bak
end type
type st_3 from statictext within w_query_wizard_bak
end type
type sle_value3 from singlelineedit within w_query_wizard_bak
end type
type dw_crit2 from datawindow within w_query_wizard_bak
end type
type dw_crit1 from datawindow within w_query_wizard_bak
end type
type sle_value2 from singlelineedit within w_query_wizard_bak
end type
type sle_value1 from singlelineedit within w_query_wizard_bak
end type
type dw_table from datawindow within w_query_wizard_bak
end type
type cb_3 from commandbutton within w_query_wizard_bak
end type
type cb_find from commandbutton within w_query_wizard_bak
end type
type cb_1 from commandbutton within w_query_wizard_bak
end type
type gb_7 from groupbox within w_query_wizard_bak
end type
type gb_6 from groupbox within w_query_wizard_bak
end type
type gb_5 from groupbox within w_query_wizard_bak
end type
type gb_3 from groupbox within w_query_wizard_bak
end type
type gb_1 from groupbox within w_query_wizard_bak
end type
end forward

global type w_query_wizard_bak from window
integer x = 78
integer y = 160
integer width = 3360
integer height = 1884
boolean titlebar = true
string title = "Query Wizard"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79680469
boolean center = true
event ue_ctx_init ( string as_param )
mle_syntax mle_syntax
cb_4 cb_4
st_screen st_screen
cb_cancel cb_cancel
cb_syntax cb_syntax
st_syntax st_syntax
ddlb_3 ddlb_3
cb_2 cb_2
st_null3 st_null3
st_null2 st_null2
st_null1 st_null1
dw_crit3 dw_crit3
st_rf st_rf
st_date3 st_date3
st_date2 st_date2
st_date1 st_date1
dw_v3 dw_v3
dw_v2 dw_v2
dw_v1 dw_v1
ddlb_2 ddlb_2
ddlb_1 ddlb_1
st_5 st_5
st_4 st_4
st_3 st_3
sle_value3 sle_value3
dw_crit2 dw_crit2
dw_crit1 dw_crit1
sle_value2 sle_value2
sle_value1 sle_value1
dw_table dw_table
cb_3 cb_3
cb_find cb_find
cb_1 cb_1
gb_7 gb_7
gb_6 gb_6
gb_5 gb_5
gb_3 gb_3
gb_1 gb_1
end type
global w_query_wizard_bak w_query_wizard_bak

type variables
string is_field1
string is_field2
string is_field3
string is_fieldup
string is_table
string is_where
string is_search
long il_v1
long il_v2
long il_v3
long il_vup
long il_resps
long il_upfield_sysid
string is_user
string is_lookup_val
string is_lookup_type
end variables

forward prototypes
public function integer of_checkcriteia (boolean ab_flag)
end prototypes

event ue_ctx_init(string as_param);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> New event.

string ls_dataobject, ls_screen_alias, ls_table, ls_temp
datastore lds_dataobject
integer li_cols, i

datawindowchild ldwc_ctxscrn
string ls_colname, ls_label, ls_dbname
integer li_found, li_inserted, li_getrow

String ls_coltype //Add 07.18.2008 by Andy

ls_screen_alias = f_get_token( as_param, "~t" )
ls_dataobject = as_param

st_screen.text = ls_screen_alias
lds_dataobject = create datastore
lds_dataobject.dataobject = ls_dataobject

dw_crit1.dataobject = "dd_ctx_fields1001"
dw_crit2.dataobject = "dd_ctx_fields1001"
dw_crit3.dataobject = "dd_ctx_fields1001"
dw_crit1.tag = ls_dataobject
dw_crit2.tag = ls_dataobject
dw_crit3.tag = ls_dataobject

li_cols = integer( lds_dataobject.Describe( "DataWindow.Column.Count" ) )
ls_table = lower( lds_dataobject.Describe( "Datawindow.table.updatetable" ) )
is_table = ls_table

for i = 1 to li_cols
	ls_dbname = lower( lds_dataobject.Describe("#"+string( i ) + ".dbname") )
	ls_temp = f_get_token( ls_dbname, '.' )
	//$<modify> 07.18.2008 by Andy
	//ls_colname = lower( lds_dataobject.Describe("#"+string( i ) + ".name") )
	ls_colname = ls_dbname
	ls_coltype = lds_dataobject.Describe("#"+string( i ) + ".coltype" )
	//end modify 07.18.2008
	
	ls_label = lds_dataobject.Describe( ls_colname + "_t.text")
	if ls_label = "?" or ls_label = "!" then ls_label = ""
	if ls_label = '' then ls_label = ls_dbname
		
	if ls_temp = ls_table then
		li_inserted = dw_crit1.insertrow( 0 )
		dw_crit1.setitem( li_inserted, "field_name", ls_colname )
		dw_crit1.setitem( li_inserted, "field_name_alias", ls_label )
		//$<add> 07.18.2008 by Andy
		dw_crit1.setitem( li_inserted, "field_datatype", ls_coltype )
	end if
next

if dw_crit1.rowcount() > 0 then
	dw_crit1.Rowscopy( 1, dw_crit1.rowcount(), Primary!, dw_crit2, 1, Primary! )
	dw_crit1.Rowscopy( 1, dw_crit1.rowcount(), Primary!, dw_crit3, 1, Primary! )
end if

//---------------------------- APPEON END ----------------------------

end event

public function integer of_checkcriteia (boolean ab_flag);//////////////////////////////////////////////////////////////////////
// $<function>  of_checkcriteia
// $<arguments> 
// 		boolean	ab_flag
// $<returns>   integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/06/2009 by Evan
//////////////////////////////////////////////////////////////////////

// Check address_type filed
if Lower(is_field1) = "address_type" or Lower(is_field2) = "address_type" or Lower(is_field3) = "address_type" then
	if ab_Flag then
		MessageBox("Prompt", "The address_type field cannot be used in and export filter. Click the Link Fields button to select a filter for the Address type.")
	else
		MessageBox("Prompt", "The address_type field cannot be used in and export filter. Please reset criteria first.")
	end if
	Return -1
end if

Return 1
end function

on w_query_wizard_bak.create
this.mle_syntax=create mle_syntax
this.cb_4=create cb_4
this.st_screen=create st_screen
this.cb_cancel=create cb_cancel
this.cb_syntax=create cb_syntax
this.st_syntax=create st_syntax
this.ddlb_3=create ddlb_3
this.cb_2=create cb_2
this.st_null3=create st_null3
this.st_null2=create st_null2
this.st_null1=create st_null1
this.dw_crit3=create dw_crit3
this.st_rf=create st_rf
this.st_date3=create st_date3
this.st_date2=create st_date2
this.st_date1=create st_date1
this.dw_v3=create dw_v3
this.dw_v2=create dw_v2
this.dw_v1=create dw_v1
this.ddlb_2=create ddlb_2
this.ddlb_1=create ddlb_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.sle_value3=create sle_value3
this.dw_crit2=create dw_crit2
this.dw_crit1=create dw_crit1
this.sle_value2=create sle_value2
this.sle_value1=create sle_value1
this.dw_table=create dw_table
this.cb_3=create cb_3
this.cb_find=create cb_find
this.cb_1=create cb_1
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_1=create gb_1
this.Control[]={this.mle_syntax,&
this.cb_4,&
this.st_screen,&
this.cb_cancel,&
this.cb_syntax,&
this.st_syntax,&
this.ddlb_3,&
this.cb_2,&
this.st_null3,&
this.st_null2,&
this.st_null1,&
this.dw_crit3,&
this.st_rf,&
this.st_date3,&
this.st_date2,&
this.st_date1,&
this.dw_v3,&
this.dw_v2,&
this.dw_v1,&
this.ddlb_2,&
this.ddlb_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.sle_value3,&
this.dw_crit2,&
this.dw_crit1,&
this.sle_value2,&
this.sle_value1,&
this.dw_table,&
this.cb_3,&
this.cb_find,&
this.cb_1,&
this.gb_7,&
this.gb_6,&
this.gb_5,&
this.gb_3,&
this.gb_1}
end on

on w_query_wizard_bak.destroy
destroy(this.mle_syntax)
destroy(this.cb_4)
destroy(this.st_screen)
destroy(this.cb_cancel)
destroy(this.cb_syntax)
destroy(this.st_syntax)
destroy(this.ddlb_3)
destroy(this.cb_2)
destroy(this.st_null3)
destroy(this.st_null2)
destroy(this.st_null1)
destroy(this.dw_crit3)
destroy(this.st_rf)
destroy(this.st_date3)
destroy(this.st_date2)
destroy(this.st_date1)
destroy(this.dw_v3)
destroy(this.dw_v2)
destroy(this.dw_v1)
destroy(this.ddlb_2)
destroy(this.ddlb_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.sle_value3)
destroy(this.dw_crit2)
destroy(this.dw_crit1)
destroy(this.sle_value2)
destroy(this.sle_value1)
destroy(this.dw_table)
destroy(this.cb_3)
destroy(this.cb_find)
destroy(this.cb_1)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF
//

long li_mess
string ls_screen_name
integer li_screen_id
//dw_table.settransobject(sqlca)
//dw_table.retrieve()
//dw_table.insertrow(1)
//dw_resp_code.settransobject(sqlca)
//dw_resp_code.retrieve()
//dw_resp_code.insertrow(1)

li_mess = message.doubleparm

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
string ls_param, ls_dataobject, ls_screen_alias
datastore lds_dataobject

if li_mess = 0 then
	ls_param = Message.StringParm
	if ls_param <> '' then This.Trigger Event ue_ctx_init( ls_param )	
	
	dw_v1.visible = false
	sle_value1.visible = true
	sle_value1.text = ""

	st_date1.visible = false
	st_date2.visible = false
	st_date3.visible = false
	cb_4.visible = false
	is_user = gs_user_id
	return;	
end if

//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.09.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
select screen_name into :ls_screen_name from data_view_screen where table_id = :li_mess and data_view_id = 1;
select screen_id into :li_screen_id from data_view_screen where table_id = :li_mess and data_view_id = 1;
select table_name into :is_table from sys_tables where table_id = :li_mess;

st_screen.text = ls_screen_name

integer ii_screen
integer r
string find
datawindowchild dwchild



//messagebox("",ii_screen)
dw_crit1.settransobject(sqlca)
dw_crit1.retrieve(li_mess)
//dw_crit1.GetChild( "data_view_fields_screen_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve(ii_screen)
//messagebox("crit1",ii_screen)
//dw_crit1.retrieve(ii_screen)
//dw_crit1.InsertRow( 1 )

dw_crit2.settransobject(sqlca)
dw_crit2.retrieve(li_mess)
dw_crit3.settransobject(sqlca)
dw_crit3.retrieve(li_mess)
*/

integer ii_screen
integer r
string find
datawindowchild dwchild

dw_crit1.settransobject(sqlca)
dw_crit2.settransobject(sqlca)
dw_crit3.settransobject(sqlca)

gnv_appeondb.of_startqueue( )

select screen_name into :ls_screen_name from data_view_screen where table_id = :li_mess and data_view_id = 1;
select screen_id into :li_screen_id from data_view_screen where table_id = :li_mess and data_view_id = 1;
select table_name into :is_table from sys_tables where table_id = :li_mess;

dw_crit1.retrieve(li_mess)
dw_crit2.retrieve(li_mess)
dw_crit3.retrieve(li_mess)

gnv_appeondb.of_commitqueue( )

st_screen.text = ls_screen_name

//---------------------------- APPEON END ----------------------------

//dw_crit2.GetChild( "data_view_fields_screen_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve(ii_screen)
//dw_crit2.InsertRow( 1 )

//
//find = "screen_id = " + data
//messagebox("",find)
//r = dw_table.find(find,1,dw_table.rowcount())
//messagebox("r",r)

//messagebox("",is_table)

st_date1.visible = false
st_date2.visible = false
st_date3.visible = false


is_user = gs_user_id
end event

type mle_syntax from multilineedit within w_query_wizard_bak
integer x = 46
integer y = 1340
integer width = 2629
integer height = 408
integer taborder = 230
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 80269524
end type

type cb_4 from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 848
integer width = 494
integer height = 84
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Link Fields"
end type

event clicked;//popup window with a list of the
string mes
string syn

if of_CheckCriteia(false) = -1 then Return //Add by Evan on 01/06/2009

cb_find.triggerevent(clicked!)
//cb_find.enabled = false


open(w_export_link_select)

mes = message.stringparm

if mes = "cancel" then
	return
else
	//mes = mid(mes,pos(mes,".",1) + 1)
//	mes = mes + " = 1"
	syn = mle_syntax.text
	if LenA(syn) > 0 then //if syntax already exists add with an and
		syn = syn + " and " + mes
	else
		syn  = mes
	end if
	mle_syntax.text = syn
end if
end event

type st_screen from statictext within w_query_wizard_bak
integer x = 50
integer y = 36
integer width = 1879
integer height = 116
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 312
integer width = 494
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Cancel"
end type

event clicked;CLOSEwithreturn(PARENT,"Cancel")
end event

type cb_syntax from commandbutton within w_query_wizard_bak
boolean visible = false
integer x = 2766
integer y = 1520
integer width = 494
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "&View Syntax"
end type

event clicked;messagebox("Select syntax",is_search)
end event

type st_syntax from statictext within w_query_wizard_bak
boolean visible = false
integer x = 32
integer y = 156
integer width = 87
integer height = 88
integer taborder = 290
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type ddlb_3 from dropdownlistbox within w_query_wizard_bak
integer x = 1179
integer y = 1124
integer width = 302
integer height = 368
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null2.visible = true
	dw_v2.enabled = false
	sle_value2.enabled = false
else 
	st_null2.visible = false
	dw_v2.enabled = true
	sle_value2.enabled = true
end if


end event

type cb_2 from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 736
integer width = 494
integer height = 84
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "R&eset Criteria"
end type

event clicked;dw_v1.reset()
dw_v2.reset()
dw_v3.reset()
dw_v1.insertrow(0)
dw_v2.insertrow(0)
dw_v3.insertrow(0)

sle_value1.text = ""
sle_value2.text = ""
sle_value3.text = ""

//BEGIN---Add by Evan on 01/06/2009
SetNull(is_field1)
SetNull(is_field2)
SetNull(is_field3)
//END---Add by Evan on 01/06/2009

setnull(il_v1)
setnull(il_v2)
setnull(il_v3)


mle_syntax.text = ""
cb_find.enabled = true

//ddlb_1.reset()
//ddlb_2.text = ""
//ddlb_3.text = ""

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.31.2008 By: Evan
//$<reason> Correct Reset Criteria function.
dw_crit1.SelectRow(0, false)
dw_crit2.SelectRow(0, false)
dw_crit3.SelectRow(0, false)
ddlb_1.SelectItem(0)
ddlb_2.SelectItem(0)
ddlb_3.SelectItem(0)
dw_v1.Hide()
dw_v2.Hide()
dw_v3.Hide()
sle_value1.Show()
sle_value2.Show()
sle_value3.Show()
//---------------------------- APPEON END ----------------------------
end event

type st_null3 from statictext within w_query_wizard_bak
boolean visible = false
integer x = 1641
integer y = 1132
integer width = 983
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type st_null2 from statictext within w_query_wizard_bak
boolean visible = false
integer x = 1641
integer y = 784
integer width = 983
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type st_null1 from statictext within w_query_wizard_bak
boolean visible = false
integer x = 1641
integer y = 472
integer width = 983
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long backcolor = 16777215
boolean enabled = false
string text = " Null"
boolean border = true
boolean focusrectangle = false
end type

type dw_crit3 from datawindow within w_query_wizard_bak
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 1068
integer width = 951
integer height = 180
integer taborder = 150
string dataobject = "d_dddw_field_list_exp_new"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-22 By: Scofield
//$<Reason> Add the process for dw_crit3
 
datastore    lds_dataobject
datawindowchild  dwchild, dwcquery
 
string  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
string  ls_data, ls_display, ls_values, ls_temp
integer  li_rowcount, i
 
ls_column = This.GetItemString( currentrow, "field_name" )
if isnull( ls_column ) then return
 
ls_dataobject = This.tag
lds_dataobject = create datastore
lds_dataobject.dataobject = ls_dataobject
 
ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field3 = ls_temp
 
//$<modify> 07.18.2008
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = this.GetItemString( currentrow, "field_datatype" )
Choose Case LeftA ( ls_coltype , 5 )
 Case "char(", "char"
  ls_coltype = "C"
 Case "date" ,"datet" ,"time", "times"
  ls_coltype = "D"
 Case "decim","numbe", "doubl", "real","long", "ulong", "int"
  ls_coltype = "N"
End Choose
 
ls_dacol = lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
if ls_dacol = '?' or ls_dacol = '!' then
 dw_v3.visible = false
 
 sle_value3.text = ""
 sle_value3.visible = true
elseif ls_dacol = "lookup_code" then
 dw_v3.visible = true
 sle_value3.visible = false
 
 dw_v3.dataobject = "d_c_look"
 dw_v3.GetChild( "description", dwchild )
 
 dwchild.SetTransObject( SQLCA )
 ltable = lds_dataobject.Describe( ls_column + ".tag" )
 dwchild.Retrieve( ltable )
 dwchild.InsertRow( 1 )
 dw_v3.insertrow(1)
else
 dw_v3.visible = true
 sle_value3.visible = false
 
 lds_dataobject.SetTransObject( SQLCA )
 lds_dataobject.InsertRow( 0 )
 lds_dataobject.GetChild( ls_column, dwcquery )
 
 ls_discol = lds_dataobject.Describe( ls_Column+".dddw.DisplayColumn")
   
 li_rowcount = dwcquery.rowcount()
 for i = 1 to li_rowcount
  if ls_coltype = "C" then
   ls_data = dwcquery.getitemstring( i, ls_dacol )
  elseif ls_coltype = "D" then
   ls_data = string( dwcquery.getitemdatetime( i, ls_dacol ) )
  else
   ls_data = string( dwcquery.getitemnumber( i, ls_dacol ) )
  end if
  if Not isnull( ls_data ) then
   ls_display = dwcquery.getitemstring( i, ls_discol )
   if Not isnull( ls_display ) then
    ls_values += ls_display + "~t" +ls_data + "/"
   end if
  end if
 next
 
 dw_v3.dataobject = "d_ctx_export_param"
 dw_v3.Modify( "ctx_values.values = '" + ls_values + "'" )
 dwchild.InsertRow( 1 )
 dw_v3.insertrow(1)
end if
 
if ls_coltype = "D" then
 st_date3.visible = true
else
 st_date3.visible = false
end if
 
Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------
end event

event clicked;long ll_Row

ll_Row = this.getclickedrow()
this.setrow(ll_Row)
this.selectrow(0,false)
this.selectrow(ll_Row,true)

if IsNull(is_field3) or Trim(is_field3) = '' then
 This.Trigger Event RowFocusChanged(ll_Row)
end if


end event

event rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
if this.dataobject = "dd_ctx_fields1001" then
	This.Trigger Event ue_ctx_row( currentrow )		//Added by Scofield on 2007-08-22
	return
end if
//---------------------------- APPEON END ----------------------------

datawindowchild dwchild
string ltable
string field
string d

if this.getitemstring(currentrow,"lookup_field") = "Y" then
	dw_v3.visible = true
	sle_value3.visible = false
	ltable = this.getitemstring(currentrow,"lookup_code")
	if this.getitemstring(currentrow,"lookup_type") = "C" then
		dw_v3.dataobject = "d_c_look"
		field = "description"
	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
		dw_v3.dataobject = "d_a_look"
		field = "entity_name_original"
	end if
	dw_v3.settransobject(sqlca)
//	dw_v3.retrieve(ltable)
//	dw_v3.insertrow(1)
	dw_v3.GetChild( field, dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve(ltable)
	dwchild.InsertRow( 1 )
	dw_v3.insertrow(1)
else
	dw_v3.visible = false
	sle_value3.visible = true
	sle_value3.text = ""
end if

is_field3 = this.getitemstring(currentrow,"sys_fields_field_name")
d = this.getitemstring(currentrow,"sys_fields_field_type")
if d = "D" then 
	st_date3.visible = true
else
	st_date3.visible = false
end if
end event

type st_rf from statictext within w_query_wizard_bak
integer x = 2706
integer y = 524
integer width = 626
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type st_date3 from statictext within w_query_wizard_bak
integer x = 1591
integer y = 1044
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type st_date2 from statictext within w_query_wizard_bak
integer x = 1591
integer y = 688
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type st_date1 from statictext within w_query_wizard_bak
integer x = 1591
integer y = 380
integer width = 969
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Dates must be entered as yyyy-mm-dd"
boolean focusrectangle = false
end type

type dw_v3 from datawindow within w_query_wizard_bak
integer x = 1595
integer y = 1124
integer width = 992
integer height = 100
integer taborder = 270
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v3 = long(data)

end event

type dw_v2 from datawindow within w_query_wizard_bak
integer x = 1595
integer y = 776
integer width = 992
integer height = 100
integer taborder = 120
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v2 = long(data)


end event

type dw_v1 from datawindow within w_query_wizard_bak
integer x = 1600
integer y = 464
integer width = 992
integer height = 100
integer taborder = 50
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;il_v1 = long(data)


end event

type ddlb_2 from dropdownlistbox within w_query_wizard_bak
integer x = 1179
integer y = 784
integer width = 302
integer height = 368
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null2.visible = true
	dw_v2.enabled = false
	sle_value2.enabled = false
else 
	st_null2.visible = false
	dw_v2.enabled = true
	sle_value2.enabled = true
end if


end event

type ddlb_1 from dropdownlistbox within w_query_wizard_bak
integer x = 1179
integer y = 464
integer width = 302
integer height = 368
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"=","<",">","<>","<=",">=","is","is not"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if this.text = "is" or this.text = "is not" then
	st_null1.visible = true
	dw_v1.enabled = false
	sle_value1.enabled = false
else 
	st_null1.visible = false
	dw_v1.enabled = true
	sle_value1.enabled = true
end if
	

end event

type st_5 from statictext within w_query_wizard_bak
integer x = 1879
integer y = 332
integer width = 247
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Value"
boolean focusrectangle = false
end type

type st_4 from statictext within w_query_wizard_bak
integer x = 1207
integer y = 332
integer width = 247
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Operator"
boolean focusrectangle = false
end type

type st_3 from statictext within w_query_wizard_bak
integer x = 325
integer y = 332
integer width = 247
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Field"
boolean focusrectangle = false
end type

type sle_value3 from singlelineedit within w_query_wizard_bak
integer x = 1595
integer y = 1128
integer width = 983
integer height = 92
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_crit2 from datawindow within w_query_wizard_bak
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 720
integer width = 951
integer height = 204
integer taborder = 60
string dataobject = "d_dddw_field_list_exp_new"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-08-22 By: Scofield
//$<Reason> Add the process for dw_crit2
 
datastore    lds_dataobject
datawindowchild  dwchild, dwcquery
 
string  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
string  ls_data, ls_display, ls_values, ls_temp
integer  li_rowcount, i
 
ls_column = This.GetItemString( currentrow, "field_name" )
if isnull( ls_column ) then return
 
ls_dataobject = This.tag
lds_dataobject = create datastore
lds_dataobject.dataobject = ls_dataobject
 
ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field2 = ls_temp
 
//$<modify> 07.18.2008
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = this.GetItemString( currentrow, "field_datatype" )
Choose Case LeftA ( ls_coltype , 5 )
 Case "char(", "char"
  ls_coltype = "C"
 Case "date" ,"datet" ,"time", "times"
  ls_coltype = "D"
 Case "decim","numbe", "doubl", "real","long", "ulong", "int"
  ls_coltype = "N"
End Choose
 
ls_dacol = lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
if ls_dacol = '?' or ls_dacol = '!' then
 dw_v2.visible = false
 
 sle_value2.text = ""
 sle_value2.visible = true
elseif ls_dacol = "lookup_code" then
 dw_v2.visible = true
 sle_value2.visible = false
 
 dw_v2.dataobject = "d_c_look"
 dw_v2.GetChild( "description", dwchild )
 
 dwchild.SetTransObject( SQLCA )
 ltable = lds_dataobject.Describe( ls_column + ".tag" )
 dwchild.Retrieve( ltable )
 dwchild.InsertRow( 1 )
 dw_v2.insertrow(1)
else
 dw_v2.visible = true
 sle_value2.visible = false
 
 lds_dataobject.SetTransObject( SQLCA )
 lds_dataobject.InsertRow( 0 )
 lds_dataobject.GetChild( ls_column, dwcquery )
 
 ls_discol = lds_dataobject.Describe( ls_Column+".dddw.DisplayColumn")
   
 li_rowcount = dwcquery.rowcount()
 for i = 1 to li_rowcount
  if ls_coltype = "C" then
   ls_data = dwcquery.getitemstring( i, ls_dacol )
  elseif ls_coltype = "D" then
   ls_data = string( dwcquery.getitemdatetime( i, ls_dacol ) )
  else
   ls_data = string( dwcquery.getitemnumber( i, ls_dacol ) )
  end if
  if Not isnull( ls_data ) then
   ls_display = dwcquery.getitemstring( i, ls_discol )
   if Not isnull( ls_display ) then
    ls_values += ls_display + "~t" +ls_data + "/"
   end if
  end if
 next
 
 dw_v2.dataobject = "d_ctx_export_param"
 dw_v2.Modify( "ctx_values.values = '" + ls_values + "'" )
 dwchild.InsertRow( 1 )
 dw_v2.insertrow(1)
end if
 
if ls_coltype = "D" then
 st_date2.visible = true
else
 st_date2.visible = false
end if
 
Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------
end event

event clicked;long ll_Row

ll_Row = this.getclickedrow()
this.setrow(ll_Row)
this.selectrow(0,false)
this.selectrow(ll_Row,true)

if IsNull(is_field2) or Trim(is_field2) = '' then
 This.Trigger Event RowFocusChanged(ll_Row)
end if


end event

event rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
if this.dataobject = "dd_ctx_fields1001" then
	This.Trigger Event ue_ctx_row( currentrow )		//Added by Scofield on 2007-08-22
	return
end if
//---------------------------- APPEON END ----------------------------

datawindowchild dwchild
string ltable
string field
string d

if this.getitemstring(currentrow,"lookup_field") = "Y" then
	dw_v2.visible = true
	sle_value2.visible = false
	ltable = this.getitemstring(currentrow,"lookup_code")
	if this.getitemstring(currentrow,"lookup_type") = "C" then
		dw_v2.dataobject = "d_c_look"
		field = "description"
	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
		dw_v2.dataobject = "d_a_look"
		field = "entity_name_original"
	end if
	dw_v2.settransobject(sqlca)
//	dw_v2.retrieve(ltable)
//	dw_v2.insertrow(1)
	dw_v2.GetChild( field, dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve(ltable)
	dwchild.InsertRow( 1 )
	dw_v2.insertrow(1)
else
	dw_v2.visible = false
	sle_value2.visible = true
	sle_value2.text = ""
end if

is_field2 = this.getitemstring(currentrow,"sys_fields_field_name")
d = this.getitemstring(currentrow,"sys_fields_field_type")
if d = "D" then 
	st_date2.visible = true
else
	st_date2.visible = false
end if
end event

type dw_crit1 from datawindow within w_query_wizard_bak
event ue_ctx_row ( integer currentrow )
integer x = 114
integer y = 404
integer width = 955
integer height = 180
integer taborder = 30
string dataobject = "d_dddw_field_list_exp_new"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_ctx_row(integer currentrow);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> new event.
 
datastore    lds_dataobject
datawindowchild  dwchild, dwcquery
 
string  ls_dataobject, ls_column, ltable, ls_coltype, ls_dacol, ls_discol
string  ls_data, ls_display, ls_values, ls_temp
integer  li_rowcount, i
 
ls_column = This.GetItemString( currentrow, "field_name" )
if isnull( ls_column ) then return
 
ls_dataobject = This.tag
lds_dataobject = create datastore
lds_dataobject.dataobject = ls_dataobject
 
ls_temp = lds_dataobject.Describe( ls_column + ".dbname" )
f_get_token( ls_temp, "." )
is_field1 = ls_temp
 
//$<modify> 07.18.2008
//ls_coltype = lds_dataobject.Describe( ls_column + ".coltype" )
ls_coltype = this.GetItemString( currentrow, "field_datatype" )
Choose Case LeftA ( ls_coltype , 5 )
 Case "char(", "char"
  ls_coltype = "C"
 Case "date" ,"datet" ,"time", "times"
  ls_coltype = "D"
 Case "decim","numbe", "doubl", "real","long", "ulong", "int"
  ls_coltype = "N"
End Choose
 
ls_dacol = lower( lds_dataobject.Describe( ls_column + ".dddw.datacolumn" ) )
if ls_dacol = '?' or ls_dacol = '!' then
 dw_v1.visible = false
 sle_value1.visible = true
 sle_value1.text = ""
 
 //--------------------------- APPEON BEGIN ---------------------------
 //$<add> 06.05.2007 By: Jack
 //$<reason> Fix a defect.
 sle_value2.visible = True
 sle_value2.text = ""
 sle_value3.visible = True
 sle_value3.text = "" 
 //---------------------------- APPEON END ----------------------------
elseif ls_dacol = "lookup_code" then
 dw_v1.visible = true
 sle_value1.visible = false
 //--------------------------- APPEON BEGIN ---------------------------
 //$<add> 06.05.2007 By: Jack
 //$<reason> Fix a defect.
 //sle_value2.visible = False
 //sle_value3.visible = False
 //---------------------------- APPEON END ----------------------------
 
 dw_v1.dataobject = "d_c_look"
 dw_v1.GetChild( "description", dwchild )
 
 dwchild.SetTransObject( SQLCA )
 ltable = lds_dataobject.Describe( ls_column + ".tag" )
 dwchild.Retrieve( ltable )
 dwchild.InsertRow( 1 )
 dw_v1.insertrow(1)
else
 dw_v1.visible = true
 sle_value1.visible = false
 //--------------------------- APPEON BEGIN ---------------------------
 //$<add> 06.05.2007 By: Jack
 //$<reason> Fix a defect.
 //sle_value2.visible = False
 //sle_value3.visible = False
 //---------------------------- APPEON END ----------------------------
 
 lds_dataobject.SetTransObject( SQLCA )
 lds_dataobject.InsertRow( 0 )
 lds_dataobject.GetChild( ls_column, dwcquery )
 
 ls_discol = lds_dataobject.Describe( ls_Column+".dddw.DisplayColumn")
   
 li_rowcount = dwcquery.rowcount()
 for i = 1 to li_rowcount
  if ls_coltype = "C" then
   ls_data = dwcquery.getitemstring( i, ls_dacol )
  elseif ls_coltype = "D" then
   ls_data = string( dwcquery.getitemdatetime( i, ls_dacol ) )
  else
   ls_data = string( dwcquery.getitemnumber( i, ls_dacol ) )
  end if
  if Not isnull( ls_data ) then
   ls_display = dwcquery.getitemstring( i, ls_discol )
   if Not isnull( ls_display ) then
    ls_values += ls_display + "~t" +ls_data + "/"
   end if
  end if
 next
 
 dw_v1.dataobject = "d_ctx_export_param"
 dw_v1.Modify( "ctx_values.values = '" + ls_values + "'" )
 dwchild.InsertRow( 1 )
 dw_v1.insertrow(1)
end if
 
if ls_coltype = "D" then
 st_date1.visible = true
else
 st_date1.visible = false
end if
 
Destroy lds_dataobject
//---------------------------- APPEON END ----------------------------

end event

event clicked;integer r

r = this.getclickedrow()
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)



end event

event rowfocuschanged;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
if this.dataobject = "dd_ctx_fields1001" then
	This.Trigger Event ue_ctx_row( currentrow )
	return
end if
//---------------------------- APPEON END ----------------------------

datawindowchild dwchild
string ltable
string field
string d

if this.getitemstring(currentrow,"lookup_field") = "Y" then
	dw_v1.visible = true
	sle_value1.visible = false
	ltable = this.getitemstring(currentrow,"lookup_code")
	if this.getitemstring(currentrow,"lookup_type") = "C" then
		dw_v1.dataobject = "d_c_look"
		field = "description"
	elseif this.getitemstring(currentrow,"lookup_type") = "A" then
		dw_v1.dataobject = "d_a_look"
		field = "entity_name_original"
	end if
	dw_v1.settransobject(sqlca)
	//dw_v1.retrieve(ltable)
	dw_v1.GetChild( field, dwchild )
	
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve(ltable)
	dwchild.InsertRow( 1 )
	dw_v1.insertrow(1)
else
	dw_v1.visible = false
	sle_value1.visible = true
	sle_value1.text = ""
end if

is_field1 = this.getitemstring(currentrow,"sys_fields_field_name")
d = this.getitemstring(currentrow,"sys_fields_field_type")
if d = "D" then 
	st_date1.visible = true
else
	st_date1.visible = false
end if
end event

type sle_value2 from singlelineedit within w_query_wizard_bak
integer x = 1595
integer y = 780
integer width = 992
integer height = 92
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type sle_value1 from singlelineedit within w_query_wizard_bak
integer x = 1605
integer y = 464
integer width = 978
integer height = 92
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type dw_table from datawindow within w_query_wizard_bak
boolean visible = false
integer x = 1541
integer y = 104
integer width = 1088
integer height = 92
integer taborder = 20
string dataobject = "d_table_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;integer ii_screen
integer r
string find
datawindowchild dwchild

ii_screen = integer(data)

//messagebox("",ii_screen)
dw_crit1.settransobject(sqlca)
dw_crit1.retrieve(ii_screen)
//dw_crit1.GetChild( "data_view_fields_screen_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve(ii_screen)
//messagebox("crit1",ii_screen)
//dw_crit1.retrieve(ii_screen)
//dw_crit1.InsertRow( 1 )

dw_crit2.settransobject(sqlca)
dw_crit2.retrieve(ii_screen)
dw_crit3.settransobject(sqlca)
dw_crit3.retrieve(ii_screen)
//dw_crit2.GetChild( "data_view_fields_screen_id", dwchild )
//dwchild.SetTransObject( SQLCA )
//dwchild.Retrieve(ii_screen)
//dw_crit2.InsertRow( 1 )

//
find = "screen_id = " + data
//messagebox("",find)
r = dw_table.find(find,1,dw_table.rowcount())
//messagebox("r",r)
is_table = dw_table.getitemstring(r,"sys_tables_table_name")
//messagebox("",is_table)
cb_find.enabled = false











cb_find.enabled = true
end event

event doubleclicked;//integer is_screen
//integer r
//string find
//
//
//is_screen = this.getitemnumber(row,"data_view_screen_screen_id")
//messagebox("",is_screen)
//dw_crit1.settransobject(sqlca)
////messagebox("crit1",is_screen)
//dw_crit1.retrieve(is_screen)
//
//dw_crit2.settransobject(sqlca)
////messagebox("crit2",is_screen)
//dw_crit2.retrieve(is_screen)
//
//dw_crit_update.settransobject(sqlca)
////messagebox("crit3",is_screen)
//dw_crit_update.retrieve(is_screen)
//
//
//is_table = this.getitemstring(row,"sys_tables_table_name")
//
//messagebox("",is_table)
//
//cb_find.enabled = true
end event

type cb_3 from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 212
integer width = 494
integer height = 84
integer taborder = 210
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Return"
end type

event clicked;if LenA(mle_syntax.text) < 1 then
	cb_find.triggerevent(clicked!)
end if

//is_where = st_syntax.text
is_where = mle_syntax.text
CLOSEwithreturn(PARENT,is_where)
end event

type cb_find from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 628
integer width = 494
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&Set Syntax"
end type

event clicked;string ls_field1
string ls_ftype1
string ls_op1
string ls_val1
string ls_search
string ls_table
string syn
date ld_v1
datetime ldt_v2
string ls_field2
string ls_op2
string ls_val2
string ls_ftype2
string ls_dwsyntax_str
datetime ldt_v3
string ls_field3
string ls_op3
string ls_val3
string ls_ftype3
string ls_presentation_str
string ls_where1
string ls_where2
string ls_where3
string errors
integer rc
integer vc = 0
long lla_recs[]
integer i

ls_table = is_table
ls_field1 = is_field1

//first criteria
ls_op1 = ddlb_1.text

if sle_value1.visible = true then
	ls_val1 = sle_value1.text
else
	ls_val1 = string(il_v1)
end if

if upper(ls_op1) = "IS" or upper(ls_op1) = "IS NOT" then ls_val1 = 'Null'

if ls_op1  = "" then return
if ls_val1 = "" then	return
if of_CheckCriteia(true) = -1 then Return //Add by Evan on 01/06/2009

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-11-29 By: Rodger Wu (doc painter)
//$<reason> 
/*
ls_ftype1 = dw_crit1.getitemstring(dw_crit1.getrow(),"sys_fields_field_type")
ls_ftype2 = dw_crit2.getitemstring(dw_crit2.getrow(),"sys_fields_field_type")
ls_ftype3 = dw_crit3.getitemstring(dw_crit3.getrow(),"sys_fields_field_type")
*/
string ls_column
integer li_currentrow
datastore lds_dataobject

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.25.2007 By: Jack
//$<reason> Fix a defect.
dw_crit1.accepttext()
dw_crit2.accepttext()
dw_crit3.accepttext()
//---------------------------- APPEON END ----------------------------

if dw_crit1.dataobject = "dd_ctx_fields1001" then
	lds_dataobject = create datastore
	lds_dataobject.dataobject = dw_crit1.tag

	li_currentrow = dw_crit1.getrow()
	ls_column = dw_crit1.GetItemString( li_currentrow, "field_name" )
	//$<modify> 07.18.2008
	//ls_ftype1 = lds_dataobject.Describe( ls_column + ".coltype" )
	ls_ftype1 = dw_crit1.GetItemString( li_currentrow, "field_datatype" )
	is_field1 = ls_column //$<add> 04.25.2007 By: Jack
	
	Choose Case LeftA ( ls_ftype1 , 5 )
		Case "char(", "char"
			ls_ftype1 = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_ftype1 = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_ftype1 = "N"
	End Choose

	li_currentrow = dw_crit2.getrow()
	ls_column = dw_crit2.GetItemString( li_currentrow, "field_name" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.05.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_ftype1 = lds_dataobject.Describe( ls_column + ".coltype" )
	
	Choose Case Left ( ls_ftype1 , 5 )
		Case "char(", "char"
			ls_ftype1 = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_ftype1 = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_ftype1 = "N"
	End Choose
	*/
		
	//$<modify> 07.18.2008
	//ls_ftype2 = lds_dataobject.Describe( ls_column + ".coltype" )	
	ls_ftype2 = dw_crit2.GetItemString( li_currentrow, "field_datatype" )
	Choose Case LeftA ( ls_ftype2 , 5 )
		Case "char(", "char"
			ls_ftype2 = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_ftype2 = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_ftype2 = "N"
	End Choose
	//---------------------------- APPEON END ----------------------------
	is_field2 = ls_column  //$<add> 04.25.2007 By: Jack
	
	li_currentrow = dw_crit3.getrow()
	ls_column = dw_crit3.GetItemString( li_currentrow, "field_name" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 06.05.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	ls_ftype1 = lds_dataobject.Describe( ls_column + ".coltype" )
	Choose Case Left ( ls_ftype1 , 5 )
		Case "char(", "char"
			ls_ftype1 = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_ftype1 = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_ftype1 = "N"
	End Choose
	*/
		
	//$<modify> 07.18.2008
	//ls_ftype3 = lds_dataobject.Describe( ls_column + ".coltype" )
	ls_ftype3 = dw_crit3.GetItemString( li_currentrow, "field_datatype" )
	Choose Case LeftA ( ls_ftype3 , 5 )
		Case "char(", "char"
			ls_ftype3 = "C"
		Case "date"	,"datet"	,"time", "times"
			ls_ftype3 = "D"
		Case "decim","numbe", "doubl", "real","long", "ulong", "int"
			ls_ftype3 = "N"
	End Choose
	//---------------------------- APPEON END ----------------------------
	is_field3 = ls_column  //$<add> 04.25.2007 By: Jack
	
else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.22.2007 By: Jack (Export)
	//$<reason> Fix a defect.
	/*
	ls_ftype1 = dw_crit1.getitemstring( li_currentrow, "sys_fields_field_type" )
	ls_ftype2 = dw_crit2.getitemstring( li_currentrow, "sys_fields_field_type" )
	ls_ftype3 = dw_crit3.getitemstring( li_currentrow, "sys_fields_field_type" )
	*/
	ls_ftype1 = dw_crit1.getitemstring( dw_crit1.getrow(), "sys_fields_field_type" )
	ls_ftype2 = dw_crit2.getitemstring( dw_crit2.getrow(), "sys_fields_field_type" )
	ls_ftype3 = dw_crit3.getitemstring( dw_crit3.getrow(), "sys_fields_field_type" )
	//---------------------------- APPEON END ----------------------------
end if
//---------------------------- APPEON END ----------------------------

if upper(ls_val1) = "NULL" then ls_ftype1 = "N"
choose case ls_ftype1
	case "I","N"
		ls_where1  = is_table + "." + is_field1 + " " + ls_op1 + " " + ls_val1
	case "D"
		ls_val1 = ls_val1 + " 00:00:00"
		ls_where1  = is_table + "." + is_field1 + " " + ls_op1 + " " + "'" + ls_val1 + "' "
	Case "C"
		ls_where1  = is_table + "." + is_field1 + " " + ls_op1 + " '" + ls_val1 + "'"
end choose

//second criteria
if sle_value2.visible = true then
	ls_val2 = sle_value2.text
else
	ls_val2 = string(il_v2)
end if

ls_field2 = is_field2
ls_op2 = ddlb_2.text

if upper(ls_op2) = "IS" or upper(ls_op2) = "IS NOT" then ls_val2 = 'Null'

if ls_op2  = "" or ls_val2 = "" then
	is_where = ls_where1
	
else
	if upper(ls_val2) = "NULL" then ls_ftype2 = "N"

	choose case ls_ftype2  //filters 2 & 3 modified to add the table name to the filter maha 100104
		case "I","N"
			ls_where2  = is_table + "." + is_field2 + " " + ls_op2 + " " + ls_val2
		case "D"
			ls_val2 = ls_val2 + " 00:00:00"
			ls_where2  = is_table + "." + is_field2 + " " + ls_op2 + " " + "'" + ls_val2 + "' "
		Case "C"
			ls_where2  = is_table + "." + is_field2 + " " + ls_op2 + " '" + ls_val2 + "'"
	end choose
		is_where  = ls_where1 + " and " + ls_where2
end if

ls_search = "Select * from " + is_table
ls_search = ls_search + is_where

//third criteria
if sle_value3.visible = true then
	ls_val3 = sle_value3.text
else
	ls_val3 = string(il_v3)
end if

ls_field3 = is_field3
ls_op3 = ddlb_3.text
if upper(ls_op3) = "IS" or upper(ls_op3) = "IS NOT" then ls_val3 = 'Null'

if ls_op3  = "" or ls_val3 = "" then
	is_where = is_where
else

	if upper(ls_val3) = "NULL" then ls_ftype3 = "N"
	choose case ls_ftype3
		case "I","N"
			ls_where3  = is_table + "." + is_field3 + " " + ls_op3 + " " + ls_val3
		case "D"
			ls_val3 = ls_val3 + " 00:00:00"
			ls_where3  = is_table + "." + is_field3 + " " + ls_op3 + " " + "'" + ls_val3 + "' "
		Case "C"
			ls_where3  = is_table + "." + is_field3 + " " + ls_op3 + " '" + ls_val3 + "'"
	end choose
		is_where  = is_where + " and " + ls_where3
end if


ls_search = "Select * from " + is_table
 
ls_search = ls_search + is_where
syn = mle_syntax.text

syn = is_where
mle_syntax.text = syn

end event

type cb_1 from commandbutton within w_query_wizard_bak
integer x = 2757
integer y = 416
integer width = 494
integer height = 84
integer taborder = 280
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
string text = "&About"
end type

event clicked;messagebox("To operate this function :"," Select the field name, the operator type, and the criteria value for each protion of the filter you wish to add. You can set 1 - 3  criteria. ~r(3) Click SET SYNTAX to build the filter.~r(4) Click Link Fields to get link filter syntax. ~rClick return when satisfied with the filter.")
end event

type gb_7 from groupbox within w_query_wizard_bak
integer x = 87
integer y = 964
integer width = 2551
integer height = 304
integer taborder = 240
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criteria 3"
end type

type gb_6 from groupbox within w_query_wizard_bak
integer x = 82
integer y = 248
integer width = 2560
integer height = 376
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criteria 1"
end type

type gb_5 from groupbox within w_query_wizard_bak
integer x = 91
integer y = 624
integer width = 2551
integer height = 340
integer taborder = 260
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Criteria 2"
end type

type gb_3 from groupbox within w_query_wizard_bak
boolean visible = false
integer x = 1440
integer y = 28
integer width = 1271
integer height = 208
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "(1) Select Table"
end type

type gb_1 from groupbox within w_query_wizard_bak
integer x = 46
integer y = 180
integer width = 2629
integer height = 1132
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Microsoft Sans Serif"
long textcolor = 128
long backcolor = 80269524
string text = "Set Filter Criteria"
end type

