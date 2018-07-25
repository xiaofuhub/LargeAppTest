$PBExportHeader$w_export_expression_report.srw
$PBExportComments$(Appeon)Toney 06.10.2013 - V141 ISG-CLX
forward
global type w_export_expression_report from w_response
end type
type lb_functions from listbox within w_export_expression_report
end type
type gb_3 from groupbox within w_export_expression_report
end type
type dw_2 from u_dw within w_export_expression_report
end type
type cb_9 from commandbutton within w_export_expression_report
end type
type cb_8 from commandbutton within w_export_expression_report
end type
type cb_7 from commandbutton within w_export_expression_report
end type
type cb_6 from commandbutton within w_export_expression_report
end type
type cb_5 from commandbutton within w_export_expression_report
end type
type cb_4 from commandbutton within w_export_expression_report
end type
type dw_1 from u_dw within w_export_expression_report
end type
type cb_3 from commandbutton within w_export_expression_report
end type
type cb_2 from commandbutton within w_export_expression_report
end type
type cb_1 from commandbutton within w_export_expression_report
end type
type mle_1 from multilineedit within w_export_expression_report
end type
type gb_1 from groupbox within w_export_expression_report
end type
type gb_2 from groupbox within w_export_expression_report
end type
end forward

global type w_export_expression_report from w_response
integer width = 2107
integer height = 1440
string title = "Modify Expression"
boolean center = false
event ue_replacetext ( integer ai_flag )
lb_functions lb_functions
gb_3 gb_3
dw_2 dw_2
cb_9 cb_9
cb_8 cb_8
cb_7 cb_7
cb_6 cb_6
cb_5 cb_5
cb_4 cb_4
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
mle_1 mle_1
gb_1 gb_1
gb_2 gb_2
end type
global w_export_expression_report w_export_expression_report

type variables
str_pass istr_pass

string  is_Function[]
integer ii_SelStart[]
integer ii_SelNum[]

integer ii_CurrFunction
string  is_CurrColumn = ""
end variables

forward prototypes
public function integer of_set_mletext (multilineedit aml_mle, string as_text)
public function long of_check ()
public function long of_check_screen ()
end prototypes

event ue_replacetext(integer ai_flag);string  ls_Column
integer li_Position

if ai_flag = 1 then
	//<add> 01.04.2008 by: Andy
	//Reason: if ii_CurrFunction = 0 ,then the system will crash.
	if ii_CurrFunction = 0 then return
	//end of add
	li_Position = mle_1.Position()
	mle_1.ReplaceText(is_Function[ii_CurrFunction])
	li_Position += ii_SelStart[ii_CurrFunction] - 1
	mle_1.SelectText(li_Position, ii_SelNum[ii_CurrFunction])
else
	ls_Column = " " + is_CurrColumn + " "
	mle_1.ReplaceText(ls_Column)
end if

mle_1.SetFocus()
end event

public function integer of_set_mletext (multilineedit aml_mle, string as_text);/*===================================================
//Function  : add as_text into aml_mle
//parameters: aml_mle <multilineedit> 
              as_text <string>
//author    : andy 2007.05.28
====================================================*/
int li_selectedBegin,li_selectedLen
string ls_original,ls_before,ls_back,ls_selectedtext

ls_original		 =aml_mle.text
li_selectedBegin=aml_mle.position() -1
li_selectedLen	 =len(aml_mle.selectedtext())
ls_selectedtext =aml_mle.selectedtext()
ls_before		 =left(ls_original,li_selectedBegin)
ls_back			 =right(ls_original,len(ls_original) -li_selectedBegin -li_selectedLen)

if isnull(ls_before) then ls_before=''
//Modify 07/17/2007 by: Andy
if isnull(ls_back) or trim(ls_back) = '' then ls_back=''

if Right(ls_before,1) <> ' ' then as_text=space(1) + as_text
if Left (ls_back  ,1) <> ' ' then as_text=as_text + space(1)

aml_mle.text=ls_before + as_text + ls_back
//end of add

aml_mle.setfocus()
aml_mle.selectText(li_selectedBegin+1+len(as_text),0)

return  1

end function

public function long of_check ();/************************************************
Function: of_check
describe:check Calculation formula
return  :0 successful/-1 failed
author  : andy 2007.05.24
*************************************************/
Long    ll_Row,ll_Num,ll_Cnt
String  ls_Field,ls_Datatype,ls_Source,ls_Err,ls_Msg,ls_ComputerField
boolean lb_flag = true
Long    ll_pos
pfc_n_cst_ai_export_apb  n_export
n_cst_string lnvo_string

if trim(mle_1.text)='' or isnull(mle_1.text) then
	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.")
	mle_1.setfocus( )
	return -1
end if

ls_Source = mle_1.text
n_export = create pfc_n_cst_ai_export_apb

//If exists the field of dw_1 in the expresstion,
//replace it with 0 for number data type or replace it with '' for string data type.
ll_Cnt = dw_1.RowCount()
for ll_Num = 1 to ll_Cnt
	ls_Field    = dw_1.GetItemString(ll_Num,"export_field_name")
	ls_Datatype = dw_1.GetItemString(ll_Num,"ctx_column_datatype")
	//Modify 07/17/2007 by: Andy Reason:BugG071701
	ll_pos      = pos(lower(ls_Source),lower(ls_Field))
	if ll_pos < 1 then continue
	
	if upper(ls_Datatype) = 'N' then
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_2',true)
	elseif upper(ls_Datatype) = 'S' then
		lb_flag = false
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_3',true)
	elseif upper(ls_Datatype) = 'D' then
		lb_flag = false
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, '1900-01-01',true)
	end if
	//end of modify
next

//replace ' with "
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '~~', '~~~~')
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '"', '~~"')
if POS(ls_Source,'"') > 0 or POS(ls_Source,"'") > 0 then lb_flag = false

ls_Err = dw_1.modify('compute_1.Expression="' + ls_Source + '"')
if ls_Err <> '' then
	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.")
	mle_1.setfocus( )
	if IsValid(n_export) then Destroy n_export
	return -1
end if

ls_Err=dw_1.Describe('Evaluate("'+ls_Source+'", 1)')
ls_Datatype = ''

if  not isnumber(ls_Err) then 
	//not OK
	if ls_Err = '!' then
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.")
		mle_1.setfocus( )
		if IsValid(n_export) then Destroy n_export
		return -1
	else
		ls_Datatype = 'S'
		//OK(denominator is 0)
		if ls_Err = '' and lb_flag then ls_Datatype = 'N'
	end if
else
	//OK
	if lb_flag then ls_Datatype = 'N' else ls_Datatype = 'S' 
end if 

//set values
if isValid(istr_pass.s_u_dw) then
	ll_Row = istr_pass.s_u_dw.GetRow()
	if ll_Row > 0 then
		istr_pass.s_u_dw.setitem(ll_Row,"ctx_column_datatype",ls_Datatype)
		istr_pass.s_u_dw.SetItem(ll_Row,"export_fields_expression", mle_1.text )
	end if
end if

if IsValid(n_export) then Destroy n_export
return 0

end function

public function long of_check_screen ();/************************************************
Function: of_check_screen
describe:check Calculation formula
return  :0 successful/-1 failed
author  : andy 06/21/2007
*************************************************/
Long    ll_Ret = 0
String  ls_Expression,ls_Err,ls_Msg,ls_Systax
n_cst_string lnvo_string
n_ds    lds

if trim(mle_1.text)='' or isnull(mle_1.text) then
	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.")
	mle_1.setfocus( )
	return -1
end if

ls_Expression = mle_1.text

//replace ' with "
ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"', '~~"')//'"'

if Not IsValid(istr_pass) then 
	messagebox(gnv_app.iapp_object.DisplayName,"expression is not valid.")
	mle_1.setfocus( )
	return -1
end if

if Not IsValid(istr_pass.s_u_dw) or upperbound(istr_pass.s_string_array) = 0 then
	messagebox(gnv_app.iapp_object.DisplayName,"expression is not valid.")
	mle_1.setfocus( )
	return -1
end if

lds = create n_ds
lds.SetTransObject(SQLCA)
ls_Systax = istr_pass.s_u_dw.describe("DataWindow.Syntax")
lds.create( ls_Systax, ls_Err)

ls_Err = ''
ls_Err = lds.modify(istr_pass.s_string_array[1] + '.Expression="' + ls_Expression + '"')
if ls_Err <> '' then
	messagebox(gnv_app.iapp_object.DisplayName,"expression is not valid.")
	mle_1.setfocus( )
	if IsValid(lds) then destroy lds
	return -1
else
	if IsValid(lds) then destroy lds
	return 0
end if

end function

on w_export_expression_report.create
int iCurrent
call super::create
this.lb_functions=create lb_functions
this.gb_3=create gb_3
this.dw_2=create dw_2
this.cb_9=create cb_9
this.cb_8=create cb_8
this.cb_7=create cb_7
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.mle_1=create mle_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_functions
this.Control[iCurrent+2]=this.gb_3
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.cb_9
this.Control[iCurrent+5]=this.cb_8
this.Control[iCurrent+6]=this.cb_7
this.Control[iCurrent+7]=this.cb_6
this.Control[iCurrent+8]=this.cb_5
this.Control[iCurrent+9]=this.cb_4
this.Control[iCurrent+10]=this.dw_1
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.cb_2
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.mle_1
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.gb_2
end on

on w_export_expression_report.destroy
call super::destroy
destroy(this.lb_functions)
destroy(this.gb_3)
destroy(this.dw_2)
destroy(this.cb_9)
destroy(this.cb_8)
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.mle_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event pfc_preopen;call super::pfc_preopen;//<add> andy 2007.05.28
istr_pass = Message.PowerObjectParm
end event

event open;call super::open;//<add>    andy 2007.05.28
//<Modify> 06/21/2007 by: Andy Reason:support screen call
String ls_field,ls_ColumnList[],ls_ComputeList[]
String ls_format,ls_border
Long   ll_Cnt,ll_Num,ll_Row
Boolean lb_flag
pfc_cst_u_band_report ldw_band

gf_wincenter(this)

if Not IsValid(istr_pass) then return
if UpperBound(istr_pass.s_string_array) < 1 then return
if Not isValid(istr_pass.s_u_dw) then return 

ls_field = istr_pass.s_string_array[1]
if isnull(ls_field) then ls_field = ''

mle_1.text = istr_pass.s_string
mle_1.setfocus( )

dw_1.setredraw(false)

if istr_pass.l_facility_id = -1 then//screen call
	//<add> 11/15/2007 by: Andy
	setredraw(false)
	gb_3.visible =  true
	lb_functions.visible = true
	gb_2.x = gb_3.x + gb_3.width + 32
	gb_2.width = mle_1.width - gb_1.width - 32 - gb_3.width - 32
	dw_1.x = gb_2.x + 32
	dw_1.width = gb_2.width - 64//124
	setredraw(true)
	//end of add
	
	dw_1.dataobject = 'd_export_fields_screen'
	dw_1.settransobject(sqlca)
	//dw_1.Modify("ctx_column_datatype.visible='0'")
	//<Modify> 11/13/2007 by: Andy
	//add column
	ldw_band = istr_pass.s_u_dw
	ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ColumnList, "column", "*", FALSE)
	//istr_pass.s_u_dw.inv_base.of_getobjects( ls_ColumnList, "column", "*", FALSE)
	ll_Cnt = upperbound(ls_ColumnList)
	FOR ll_Num = 1 to ll_Cnt
		ll_Row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_Row,"export_field_name",ls_ColumnList[ll_Num])
	NEXT
	
	//add compute
	ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ComputeList, "compute", "*", FALSE)
	//istr_pass.s_u_dw.inv_base.of_getobjects( ls_ComputeList, "compute", "*", FALSE)
	ll_Cnt = upperbound(ls_ComputeList)
	FOR ll_Num = 1 to ll_Cnt
		ll_Row = dw_1.InsertRow(0)
		dw_1.SetItem(ll_Row,"export_field_name",ls_ComputeList[ll_Num])
	NEXT
	//<add> 01.04.2008 by: Andy
	if dw_1.rowcount( ) > 0 then 
		dw_1.SelectRow( 0, False)
	end if
	//<add> 06/22/2007 by: Andy
	//format
	ls_format = istr_pass.s_u_dw.describe( ls_field + ".format")
	if isnull(ls_format) then ls_format = ''
	if ls_format = '!' or ls_format = '?' or ls_format = '' then
		//do nothing
	else
		dw_2.Setitem(1,"format",lower(ls_format))
	end if
	
	//border	
	ls_border = ldw_band.iuo_parent.uo_band.dw_syntax.describe( ls_field + ".border")		
	dw_2.Setitem(1,"border",ls_border)

	//<add> 06/25/2007 by: Andy
	dw_2.Modify("t_2.text='" + ls_field + "'")
	//end of add
	//end of Modify
else//export call
	dw_2.visible = false
	mle_1.Y = dw_2.Y 
	mle_1.height = mle_1.height + dw_2.height + 20
	
	dw_1.dataobject = 'd_export_fields'
	dw_1.settransobject(sqlca)
	dw_1.Retrieve(istr_pass.l_facility_id)
end if

//filter current computer fields
dw_1.setFilter("export_field_name<>'" + ls_field + "'")
dw_1.Filter( )

//set sort
dw_1.setsort("export_field_name A")
dw_1.sort()

dw_1.setredraw(true)
end event

type lb_functions from listbox within w_export_expression_report
event ue_lbuttonup pbm_lbuttonup
boolean visible = false
integer x = 558
integer y = 672
integer width = 622
integer height = 504
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttonup;Post Event ue_ReplaceText(1)
end event

event constructor;is_Function[1] = "abs( x )"; ii_SelStart[1] = 5; ii_SelNum[1] = 3
is_Function[2] = "acos( x )"; ii_SelStart[2] = 6; ii_SelNum[2] = 3
is_Function[2] = "asc( s )"; ii_SelStart[2] = 5; ii_SelNum[2] = 3
is_Function[3] = "asin( s )"; ii_SelStart[3] = 6; ii_SelNum[3] = 3
is_Function[4] = "atan( s )"; ii_SelStart[4] = 6; ii_SelNum[4] = 3
is_Function[5] = "avg( #x for all )"; ii_SelStart[5] = 6; ii_SelNum[5] = 2
is_Function[6] = "bitmap ( s )"; ii_SelStart[6] = 9; ii_SelNum[6] = 3
is_Function[7] = "case( x when a then b when c then d... else e)"; ii_SelStart[7] = 6; ii_SelNum[7] = 40
is_Function[8] = "ceiling( x )"; ii_SelStart[8] = 9; ii_SelNum[8] = 3
is_Function[9] = "char( x )"; ii_SelStart[9] = 6; ii_SelNum[9] = 3
is_Function[10] = "cos( x )"; ii_SelStart[10] = 5; ii_SelNum[10] = 3

is_Function[11] = "count( #x for all )"; ii_SelStart[11] = 8; ii_SelNum[11] = 2
is_Function[12] = "crosstabavg( 1 )"; ii_SelStart[12] = 13; ii_SelNum[12] = 3
is_Function[13] = "crosstabcount( 1 )"; ii_SelStart[13] = 15; ii_SelNum[13] = 3
is_Function[14] = "crosstabmax( 1 )"; ii_SelStart[14] = 13; ii_SelNum[14] = 3
is_Function[15] = "crosstabmin( 1 )"; ii_SelStart[15] = 13; ii_SelNum[15] = 3
is_Function[16] = "crosstabsum( 1 )"; ii_SelStart[16] = 13; ii_SelNum[16] = 3
is_Function[17] = "cumulativePercent( #x for all )"; ii_SelStart[17] = 20; ii_SelNum[17] = 2
is_Function[18] = "cumulativeSum( #x for all )"; ii_SelStart[18] = 16; ii_SelNum[18] = 2
is_Function[19] = "currentRow()"; ii_SelStart[19] = 13; ii_SelNum[19] = 0
is_Function[20] = "date( s )"; ii_SelStart[20] = 6; ii_SelNum[20] = 3

is_Function[21] = "datetime( s )"; ii_SelStart[21] = 10; ii_SelNum[21] = 3
is_Function[22] = "day( d )"; ii_SelStart[22] = 5; ii_SelNum[22] = 3
is_Function[23] = "dayname( d )"; ii_SelStart[23] = 9; ii_SelNum[23] = 3
is_Function[24] = "daynumber( d )"; ii_SelStart[24] = 11; ii_SelNum[24] = 3
is_Function[25] = "daysafter( d, d )"; ii_SelStart[25] = 11; ii_SelNum[25] = 6
is_Function[26] = "describe( s )"; ii_SelStart[26] = 10; ii_SelNum[26] = 3
is_Function[27] = "exp( x )"; ii_SelStart[27] = 5; ii_SelNum[27] = 3
is_Function[28] = "fact( x )"; ii_SelStart[28] = 6; ii_SelNum[28] = 3
is_Function[29] = "fill( s, x )"; ii_SelStart[29] = 6; ii_SelNum[29] = 6
is_Function[30] = "first( #x for all )"; ii_SelStart[30] = 8; ii_SelNum[30] = 2


is_Function[31] = "getrow()"; ii_SelStart[31] = 9; ii_SelNum[31] = 0
is_Function[32] = "gettext()"; ii_SelStart[32] = 10; ii_SelNum[32] = 0
is_Function[33] = "hour( t )"; ii_SelStart[33] = 6; ii_SelNum[33] = 3
is_Function[34] = "if( b, t, f )"; ii_SelStart[34] = 4; ii_SelNum[34] = 9
is_Function[35] = "int( x )"; ii_SelStart[35] = 5; ii_SelNum[35] = 3
is_Function[36] = "integer( s )"; ii_SelStart[36] = 9; ii_SelNum[36] = 3
is_Function[37] = "isDate( s )"; ii_SelStart[37] = 8; ii_SelNum[37] = 3
is_Function[38] = "isNull( x )"; ii_SelStart[38] = 8; ii_SelNum[38] = 3
is_Function[39] = "isNumber( s )"; ii_SelStart[39] = 10; ii_SelNum[39] = 3
is_Function[40] = "isRowModified()"; ii_SelStart[40] = 16; ii_SelNum[40] = 0

is_Function[41] = "isRowNew()"; ii_SelStart[41] = 11; ii_SelNum[41] = 0
is_Function[42] = "isSelected()"; ii_SelStart[42] = 13; ii_SelNum[42] = 0
is_Function[43] = "isTime( s )"; ii_SelStart[43] = 8; ii_SelNum[43] = 3
is_Function[44] = "large( #x, #x, n for all )"; ii_SelStart[44] = 8; ii_SelNum[44] = 2
is_Function[45] = "last( #x for all )"; ii_SelStart[45] = 7; ii_SelNum[45] = 2
is_Function[46] = "lastpos( s, s, x )"; ii_SelStart[46] = 9; ii_SelNum[46] = 9
is_Function[47] = "left( s, n )"; ii_SelStart[47] = 6; ii_SelNum[47] = 6
is_Function[48] = "leftTrim( s )"; ii_SelStart[48] = 10; ii_SelNum[48] = 3
is_Function[49] = "len( s )"; ii_SelStart[49] = 5; ii_SelNum[49] = 3
is_Function[50] = "log( x )"; ii_SelStart[50] = 5; ii_SelNum[50] = 3

is_Function[51] = "logten( x )"; ii_SelStart[51] = 8; ii_SelNum[51] = 3
is_Function[52] = "long( s )"; ii_SelStart[52] = 6; ii_SelNum[52] = 3
is_Function[53] = "lookupdisplay( #x )"; ii_SelStart[53] = 16; ii_SelNum[53] = 2
is_Function[54] = "lower( s )"; ii_SelStart[54] = 7; ii_SelNum[54] = 3
is_Function[55] = "match( s, s )"; ii_SelStart[55] = 7; ii_SelNum[55] = 6
is_Function[56] = "max( #x for all )"; ii_SelStart[56] = 6; ii_SelNum[56] = 2
is_Function[57] = "median( #x for all )"; ii_SelStart[57] = 9; ii_SelNum[57] = 2
is_Function[58] = "mid( s, start, len )"; ii_SelStart[58] = 5; ii_SelNum[58] = 15
is_Function[59] = "min( #x for all )"; ii_SelStart[59] = 6; ii_SelNum[59] = 2
is_Function[60] = "minute( t )"; ii_SelStart[60] = 8; ii_SelNum[60] = 3

is_Function[61] = "mod( x, y )"; ii_SelStart[61] = 5; ii_SelNum[61] = 6
is_Function[62] = "mode( #x for all )"; ii_SelStart[62] = 7; ii_SelNum[62] = 2
is_Function[63] = "month( d )"; ii_SelStart[63] = 7; ii_SelNum[63] = 3
is_Function[64] = "now()"; ii_SelStart[64] = 6; ii_SelNum[64] = 0
is_Function[65] = "number( s )"; ii_SelStart[65] = 8; ii_SelNum[65] = 3
is_Function[66] = "page()"; ii_SelStart[66] = 7; ii_SelNum[66] = 0
is_Function[67] = "pageabs()"; ii_SelStart[67] = 10; ii_SelNum[67] = 0
is_Function[68] = "pageAcross()"; ii_SelStart[68] = 13; ii_SelNum[68] = 0
is_Function[69] = "pageCount()"; ii_SelStart[69] = 12; ii_SelNum[69] = 0
is_Function[70] = "pageCountAcross()"; ii_SelStart[70] = 18; ii_SelNum[70] = 0

is_Function[71] = "percent( #x for all)"; ii_SelStart[71] = 10; ii_SelNum[71] = 2
is_Function[72] = "pi( x )"; ii_SelStart[72] = 4; ii_SelNum[72] = 3
is_Function[73] = "pos( s, s, x )"; ii_SelStart[73] = 5; ii_SelNum[73] = 9
is_Function[74] = "profileint( s, s, s, x )"; ii_SelStart[74] = 12; ii_SelNum[74] = 12
is_Function[75] = "profilestring( s, s, s, s )"; ii_SelStart[75] = 15; ii_SelNum[75] = 12
is_Function[76] = "rand( x )"; ii_SelStart[76] = 6; ii_SelNum[76] = 3
is_Function[77] = "real( s )"; ii_SelStart[77] = 6; ii_SelNum[77] = 3
is_Function[78] = "relativedate( d, x )"; ii_SelStart[78] = 14; ii_SelNum[78] = 6
is_Function[79] = "relativetime( t, x )"; ii_SelStart[79] = 14; ii_SelNum[79] = 6
is_Function[80] = "replace( s, x, y, s )"; ii_SelStart[80] = 9; ii_SelNum[80] = 12

is_Function[81] = "rgb( r, g, b )"; ii_SelStart[81] = 5; ii_SelNum[81] = 9
is_Function[82] = "right( s, n )"; ii_SelStart[82] = 5; ii_SelNum[82] = 6
is_Function[83] = "rightTrim( s )"; ii_SelStart[83] = 11; ii_SelNum[83] = 3
is_Function[84] = "round( x, x )"; ii_SelStart[84] = 7; ii_SelNum[84] = 6
is_Function[85] = "rowcount()"; ii_SelStart[85] = 11; ii_SelNum[85] = 0
is_Function[86] = "rowheight()"; ii_SelStart[86] = 12; ii_SelNum[86] = 0
is_Function[87] = "second( t )"; ii_SelStart[87] = 8; ii_SelNum[87] = 3
is_Function[88] = "secondsafter( t, t )"; ii_SelStart[88] = 14; ii_SelNum[88] = 6
is_Function[89] = "sign( x )"; ii_SelStart[89] = 6; ii_SelNum[89] = 3
is_Function[90] = "sin( x )"; ii_SelStart[90] = 5; ii_SelNum[90] = 3

is_Function[91] = "small( #x, #x, n for all )"; ii_SelStart[91] = 8; ii_SelNum[91] = 2
is_Function[92] = "space( x )"; ii_SelStart[92] = 7; ii_SelNum[92] = 3
is_Function[93] = "sqrt( x )"; ii_SelStart[93] = 6; ii_SelNum[93] = 3
is_Function[94] = "stdev( #x for all )"; ii_SelStart[94] = 8; ii_SelNum[94] = 2
is_Function[95] = "stdevp( #x for all )"; ii_SelStart[95] = 9; ii_SelNum[95] = 2
is_Function[96] = "string( x, s )"; ii_SelStart[96] = 8; ii_SelNum[96] = 6
is_Function[97] = "sum( #x for all )"; ii_SelStart[97] = 6; ii_SelNum[97] = 2
is_Function[98] = "tan( x )"; ii_SelStart[98] = 5; ii_SelNum[98] = 3
is_Function[99] = "time( s )"; ii_SelStart[99] = 6; ii_SelNum[99] = 3
is_Function[100] = "today()"; ii_SelStart[100] = 8; ii_SelNum[100] = 0

is_Function[101] = "trim( s )"; ii_SelStart[101] = 6; ii_SelNum[101] = 3
is_Function[102] = "truncate( x, y )"; ii_SelStart[102] = 10; ii_SelNum[102] = 6
is_Function[103] = "upper( s )"; ii_SelStart[103] = 7; ii_SelNum[103] = 3
is_Function[104] = "var( #x for all )"; ii_SelStart[104] = 6; ii_SelNum[104] = 2
is_Function[105] = "varp( #x for all )"; ii_SelStart[105] = 7; ii_SelNum[105] = 2
is_Function[106] = "wordcap( s )"; ii_SelStart[106] = 9; ii_SelNum[106] = 3
is_Function[107] = "year( d )"; ii_SelStart[107] = 6; ii_SelNum[107] = 3

///////////////////////////////////////////////////////////////////////////////////////
integer i
integer li_ItemCount

li_ItemCount = UpperBound(is_Function)
for i = 1 to li_ItemCount
	this.AddItem(is_Function[i])
next

end event

event selectionchanged;ii_CurrFunction = Index
end event

type gb_3 from groupbox within w_export_expression_report
boolean visible = false
integer x = 526
integer y = 608
integer width = 690
integer height = 600
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Functions:"
end type

type dw_2 from u_dw within w_export_expression_report
integer x = 14
integer y = 32
integer width = 2057
integer height = 76
integer taborder = 10
string dataobject = "d_export_fields_property"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//<add> 06/22/2007 by: Andy
of_SetUpdateable(False)
insertrow(0)
end event

type cb_9 from commandbutton within w_export_expression_report
integer x = 288
integer y = 1040
integer width = 151
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ")"
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" ) ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type cb_8 from commandbutton within w_export_expression_report
integer x = 87
integer y = 1040
integer width = 151
integer height = 92
integer taborder = 110
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "("
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" ( ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type cb_7 from commandbutton within w_export_expression_report
integer x = 288
integer y = 884
integer width = 151
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "/"
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" / ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type cb_6 from commandbutton within w_export_expression_report
integer x = 87
integer y = 884
integer width = 151
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "*"
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" * ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type cb_5 from commandbutton within w_export_expression_report
integer x = 288
integer y = 728
integer width = 151
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-"
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" - ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type cb_4 from commandbutton within w_export_expression_report
integer x = 87
integer y = 728
integer width = 151
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;//<modify> andy 2007.11.15
mle_1.ReplaceText(" + ")
mle_1.SetFocus()
//of_set_mletext(mle_1,this.text)
end event

type dw_1 from u_dw within w_export_expression_report
integer x = 558
integer y = 672
integer width = 1463
integer height = 504
integer taborder = 60
string dataobject = "d_export_fields"
end type

event constructor;call super::constructor;//<add> 05/24/2007 by: Andy
of_SetRowSelect ( true )
//<add> 06/21/2007 by: Andy
of_SetUpdateable(False)
end event

event clicked;call super::clicked;//<modify> andy 2007.11.15
if row < 1 then return 

is_CurrColumn = getitemstring(row,"export_field_name")
Post event ue_replacetext( 2 )
//of_set_mletext(mle_1,getitemstring(row,"export_field_name"))
end event

type cb_3 from commandbutton within w_export_expression_report
integer x = 1742
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;//<add> andy 2007.05.28
String ls_Ret

setnull(ls_Ret)
CloseWithReturn(Parent,ls_Ret)
end event

type cb_2 from commandbutton within w_export_expression_report
integer x = 1394
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Ok"
end type

event clicked;//<add> andy 2007.05.28
//Modify 06/21/2007 by: andy
str_pass  lstr_pass
String    ls_Expression
String    ls_Err,ls_Tag,ls_Modify
n_cst_string lnvo_string
String ls_format,ls_border
//<add> 07/18/2007 by: Andy
Long    ll_Cnt,ll_Num
Boolean lb_flag = False
//end of add
pfc_cst_u_band_report ldw_band
w_report_data_design lw_parent
String ls_ModifySyn

//Verify failed
if istr_pass.l_facility_id = -1 then//screen call
	if of_check_screen() = -1 then return
else//export call
	if of_check() = -1 then return
end if

ls_Expression      = mle_1.text
ls_Tag             = mle_1.text
lstr_pass.s_string = mle_1.text

//<Modify> 11/13/2007 by: Andy
//screen call
if istr_pass.l_facility_id = -1 then
	dw_2.accepttext( )
	//replace ' with "
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"','~~"')
	ls_format = dw_2.GetItemstring(1,"format")
	ls_border = dw_2.GetItemstring(1,"border")
	
	//Modify s_u_dw: save expression
	ls_Modify = istr_pass.s_string_array[1] + '.Expression="' + ls_Expression + '"'
	if isnull(ls_format) then ls_format = ''
	if ls_format <> '' then 
		ls_Modify = ls_Modify + " " + istr_pass.s_string_array[1] + ".format='" + ls_format + "'"
	end if
	
	ls_ModifySyn = ls_Modify
	ls_ModifySyn = ls_ModifySyn + " " + istr_pass.s_string_array[1] + ".border='" + ls_border + "'"
	ls_Modify = ls_Modify + " " + istr_pass.s_string_array[1] + ".border='5'"
	
	ls_Err    = istr_pass.s_u_dw.modify(ls_Modify)
	//<add> 11/13/2007 by: Andy
	ldw_band  = istr_pass.s_u_dw
	lw_parent = ldw_band.iw_parentwin
	if isValid(lw_parent) then
		lw_parent.event ue_setmodify( ls_ModifySyn )
	end if
end if
//end of modify

//successful
CloseWithReturn(Parent,lstr_pass)
end event

type cb_1 from commandbutton within w_export_expression_report
integer x = 1047
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;//<add>  andy 2005.05.24
//Modify 06/21/2007 by: andy
if istr_pass.l_facility_id = -1 then//screen call
	if of_check_screen() = 0 then 
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
	end if
else//export call
	if of_check() = 0 then 
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
	end if
end if
//end of add
end event

type mle_1 from multilineedit within w_export_expression_report
integer x = 37
integer y = 128
integer width = 2016
integer height = 456
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_export_expression_report
integer x = 37
integer y = 608
integer width = 462
integer height = 600
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Operator"
end type

type gb_2 from groupbox within w_export_expression_report
integer x = 526
integer y = 608
integer width = 1527
integer height = 600
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Columns:"
end type

