$PBExportHeader$w_export_expression.srw
$PBExportComments$(Appeon)Toney 06.20.2013 - V141 ISG-CLX it's from CLX,replaces the same name object that is in ISG
forward
global type w_export_expression from w_response
end type
type st_expression from statictext within w_export_expression
end type
type sle_labeltext from singlelineedit within w_export_expression
end type
type st_labeltext from statictext within w_export_expression
end type
type lb_functions from listbox within w_export_expression
end type
type gb_3 from groupbox within w_export_expression
end type
type dw_2 from u_dw within w_export_expression
end type
type cb_9 from commandbutton within w_export_expression
end type
type cb_8 from commandbutton within w_export_expression
end type
type cb_7 from commandbutton within w_export_expression
end type
type cb_6 from commandbutton within w_export_expression
end type
type cb_5 from commandbutton within w_export_expression
end type
type cb_4 from commandbutton within w_export_expression
end type
type dw_1 from u_dw within w_export_expression
end type
type cb_3 from commandbutton within w_export_expression
end type
type cb_2 from commandbutton within w_export_expression
end type
type cb_1 from commandbutton within w_export_expression
end type
type mle_1 from multilineedit within w_export_expression
end type
type gb_1 from groupbox within w_export_expression
end type
type gb_2 from groupbox within w_export_expression
end type
end forward

global type w_export_expression from w_response
integer x = 214
integer y = 221
integer width = 2249
integer height = 1440
string title = "Modify Expression"
long backcolor = 33551856
boolean center = false
event ue_replacetext ( integer ai_flag )
event ue_init_function ( integer ai_type )
st_expression st_expression
sle_labeltext sle_labeltext
st_labeltext st_labeltext
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
global w_export_expression w_export_expression

type variables
str_pass istr_pass

string  is_Function[]
integer ii_SelStart[]
integer ii_SelNum[]

integer ii_CurrFunction
string  is_CurrColumn = "", is_Expression,is_Default= '0'

CONSTANT STRING LEFTUPTEXTMARK    = "Draw_Select_Mark_LeftUp_"
CONSTANT STRING LEFTDOWNTEXTMARK  = "Draw_Select_Mark_LeftDown_"
CONSTANT STRING RIGHTUPTEXTMARK   = "Draw_Select_Mark_RightUp_"
CONSTANT STRING RIGHTDOWNTEXTMARK = "Draw_Select_Mark_RightDown_"
end variables

forward prototypes
public function integer of_set_mletext (multilineedit aml_mle, string as_text)
public function long of_check_screen ()
public function long of_check ()
public function integer of_check_screen (string as_attribute)
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

event ue_init_function(integer ai_type);if ai_type = 4 then
	is_Function[1] = "DATEADD( datepart , number, date )";ii_SelStart[1] = 9; ii_SelNum[1] = 9
	is_Function[2] = "DATEDIFF( datepart , startdate , enddate )";ii_SelStart[2] = 10; ii_SelNum[2] = 9
	is_Function[3] = "DAY( date )";ii_SelStart[3] = 5; ii_SelNum[3] = 6
	is_Function[4] = "GETDATE()";ii_SelStart[4] = 10; ii_SelNum[4] = 0
	is_Function[5] = "MONTH( date )";ii_SelStart[5] = 7; ii_SelNum[5] = 6
	is_Function[6] = "YEAR( date )";ii_SelStart[6] = 6; ii_SelNum[6] = 6
	is_Function[7] = "ISNULL( check_expression , replacement_value )";ii_SelStart[7] = 8; ii_SelNum[7] = 18
else
	is_Function[1] = "abs( x )"; ii_SelStart[1] = 5; ii_SelNum[1] = 3
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
end if

///////////////////////////////////////////////////////////////////////////////////////
integer i
integer li_ItemCount

li_ItemCount = UpperBound(is_Function)
for i = 1 to li_ItemCount
	lb_functions.AddItem(is_Function[i])
next

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
li_selectedLen	 =lenA(aml_mle.selectedtext())
ls_selectedtext =aml_mle.selectedtext()
ls_before		 =leftA(ls_original,li_selectedBegin)
ls_back			 =rightA(ls_original,lenA(ls_original) -li_selectedBegin -li_selectedLen)

if isnull(ls_before) then ls_before=''
//Modify 07/17/2007 by: Andy
if isnull(ls_back) or trim(ls_back) = '' then ls_back=''

if RightA(ls_before,1) <> ' ' then as_text=space(1) + as_text
if LeftA(ls_back  ,1) <> ' ' then as_text=as_text + space(1)

aml_mle.text=ls_before + as_text + ls_back
//end of add

aml_mle.setfocus()
aml_mle.selectText(li_selectedBegin+1+lenA(as_text),0)

return  1

end function

public function long of_check_screen ();//Modified by gavins 20120503
Return of_check_Screen( "" )


///************************************************
//Function: of_check_screen
//describe:check Calculation formula
//return  :0 successful/-1 failed
//author  : andy 06/21/2007
//*************************************************/
//Long    ll_Ret = 0
//Long    ll_Pos,ll_LeftBracketCnts,ll_RightBracketCnts
//String  ls_Expression,ls_Err,ls_Msg,ls_Systax
//n_cst_string lnvo_string
//n_ds    lds
//
//if trim(mle_1.text)='' or isnull(mle_1.text) then
//	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.",StopSign!)
//	mle_1.setfocus( )
//	return -1
//end if
//
//ls_Expression = mle_1.text
//
////BEGIN---Modify by Scofield on 2009-12-17
//
//ll_Pos = Pos(ls_Expression,"(")
//do while ll_Pos > 0
//	ll_LeftBracketCnts++
//	ll_Pos = Pos(ls_Expression,"(",ll_Pos + 1)
//loop
//
//ll_Pos = Pos(ls_Expression,")")
//do while ll_Pos > 0
//	ll_RightBracketCnts++
//	ll_Pos = Pos(ls_Expression,")",ll_Pos + 1)
//loop
//
//if ll_LeftBracketCnts <> ll_RightBracketCnts then
//	MessageBox(gnv_app.iapp_object.DisplayName, "The left parenthesis and the right parenthesis are mismatched.",StopSign!)
//	Mle_1.SetFocus( )
//	Return -1
//end if
//
////END---Modify by Scofield on 2009-12-17
//
////replace ' with "
//ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
//ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"', '~~"')//'"'
//
//if Not IsValid(istr_pass) then 
//	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
//	mle_1.setfocus( )
//	return -1
//end if
//
//if Not IsValid(istr_pass.s_u_dw) or upperbound(istr_pass.s_string_array) = 0 then
//	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
//	mle_1.setfocus( )
//	return -1
//end if
//
//lds = create n_ds
//lds.SetTransObject(SQLCA)
//ls_Systax = istr_pass.s_u_dw.describe("DataWindow.Syntax")
//lds.create( ls_Systax, ls_Err)
//
//ls_Err = ''
//ls_Err = lds.modify(istr_pass.s_string_array[1] + '.Expression="' + ls_Expression + '"')
//if ls_Err <> '' then
//	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
//	mle_1.setfocus( )
//	if IsValid(lds) then destroy lds
//	return -1
//else
//	if IsValid(lds) then destroy lds
//	return 0
//end if
//
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
String	  ls_Validation[]
Integer li_i


ls_Validation = { "line(","text(","column(","ellipse(","bitmap(","groupbox(","rectangle(","button(","compute(","roundrectangle(","graph(" }

if trim(mle_1.text)='' or isnull(mle_1.text) then
	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.",StopSign!)
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
	
	if istr_pass.s_long[1] = 3 then	//Advanced Update in workflow call -- jervis 03.12.2009
		if posA(ls_Field,'[') > 0 and posA(ls_Field,']') > 0 then
			ll_pos = posA(ls_Field,'[')
			ls_Field = Left(ls_Field,ll_pos - 2)
		end if
	end if
	
	//Modify 07/17/2007 by: Andy Reason:BugG071701
	ll_pos      = posA(lower(ls_Source),lower(ls_Field))
	if ll_pos < 1 then continue
	
	if upper(ls_Datatype) = 'N' then
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_2',true)
	elseif upper(ls_Datatype) = 'S' then
		lb_flag = false
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_3',true)
	elseif upper(ls_Datatype) = 'D' then
		lb_flag = false
		//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
		//$Reason:
		  /*
			ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, '1900-01-01',true)				
		  */
		//------------------- APPEON BEGIN -------------------
		//$<modify> Evan 06.10.2011
		//$<reason> Actually the ls_Field data type is string.
		//ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, '1900-01-01',true)
		//---------Begin Modified by (Appeon)Stephen 01.27.2015 for age computation--------
		//ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_3',true)
		ls_Source  = n_export.of_globalreplace( ls_Source, ls_Field, 'compute_4',true)
		//---------End Modfiied ------------------------------------------------------
		//------------------- APPEON END ---------------------		 
		//---------End Modfiied ------------------------------------------------------------------		
	end if
	//end of modify
next

//replace ' with "
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '~~', '~~~~')
ls_Source  = lnvo_string.of_globalreplace( ls_Source, '"', '~~"')
//if POS(ls_Source,'"') > 0 or POS(ls_Source,"'") > 0 then lb_flag = false	jervis 03.12.2009
For li_i = 1 To UpperBound( ls_Validation )
	If PosA( ls_Source, '~r~n' + ls_Validation[li_i] ) > 0 Then
		MessageBox(gnv_app.iapp_object.DisplayName, "The 'enter character' and '" + ls_Validation[li_i] + "' is not concatenation in expression.",StopSign!)
		Mle_1.SetFocus( )
		Return -1
	End If
Next
ls_Err = dw_1.modify('compute_1.Expression="' + ls_Source + '"')
if ls_Err <> '' then
	//---------Begin Modified by (Appeon)Toney 06.20.2013 for V141 ISG-CLX--------
	  /*
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)	
	  */
	 messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.~r~n"+ls_Source,StopSign!)
	//---------End Modfiied ------------------------------------------------------------------	
	mle_1.setfocus( )
	if IsValid(n_export) then Destroy n_export
	return -1
end if

//Start modify By Jervis 03.12.2009
ls_Datatype = dw_1.Describe("compute_1.coltype")
Choose Case Left ( ls_Datatype , 5 )
	Case "char(", "char"
		ls_Datatype = 'S'
	Case "date"	,"datet"	,"time", "times"
		ls_Datatype = 'D'
	Case "decim","numbe", "doubl", "real","long", "ulong", "int"
		ls_Datatype = 'N'
End Choose
/*
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
*/
//end modify by jervis 03.12.2009

if istr_pass.s_long[1] = 3 then	//Advanced update in workflow call - jervis 03.12.2009
	//Data type not match
	if ls_datatype <> istr_pass.s_string_array[2] then
		messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
		mle_1.setfocus( )
		if IsValid(n_export) then Destroy n_export
		return -1
	end if
end if

if istr_pass.s_long[1]	= 1 then	//Export call - jervis 03.12.2009
	//set values
	if isValid(istr_pass.s_u_dw) then
		ll_Row = istr_pass.s_u_dw.GetRow()
		if ll_Row > 0 then
			istr_pass.s_u_dw.setitem(ll_Row,"ctx_column_datatype",ls_Datatype)
			istr_pass.s_u_dw.SetItem(ll_Row,"export_fields_expression", mle_1.text )
		end if
	end if
end if

if IsValid(n_export) then Destroy n_export
return 0

end function

public function integer of_check_screen (string as_attribute);/************************************************
Function: of_check_screen
describe:check Calculation formula
return  :0 successful/-1 failed
author  : andy 06/21/2007
*************************************************/
Long    ll_Ret = 0
Long    ll_Pos,ll_LeftBracketCnts,ll_RightBracketCnts
String  ls_Expression,ls_Err,ls_Msg,ls_Systax
n_cst_string lnvo_string
n_ds    lds
String	  ls_Validation[]
Integer li_i


ls_Validation = { "line(","text(","column(","ellipse(","bitmap(","groupbox(","rectangle(","button(","compute(","roundrectangle(","graph(" }
If Not  ( IsNull( as_attribute ) Or Trim( as_attribute ) = '' ) And (  trim(mle_1.text)='' or isnull(mle_1.text) ) Then//added by gavins 20120503
	Return 0
End If

if trim(mle_1.text)='' or isnull(mle_1.text) then
	messagebox(gnv_app.iapp_object.DisplayName,"NULL expression is not valid.",StopSign!)
	mle_1.setfocus( )
	return -1
end if

ls_Expression = mle_1.text

//BEGIN---Modify by Scofield on 2009-12-17

ll_Pos = Pos(ls_Expression,"(")
do while ll_Pos > 0
	ll_LeftBracketCnts++
	ll_Pos = Pos(ls_Expression,"(",ll_Pos + 1)
loop

ll_Pos = Pos(ls_Expression,")")
do while ll_Pos > 0
	ll_RightBracketCnts++
	ll_Pos = Pos(ls_Expression,")",ll_Pos + 1)
loop

if ll_LeftBracketCnts <> ll_RightBracketCnts then
	MessageBox(gnv_app.iapp_object.DisplayName, "The left parenthesis and the right parenthesis are mismatched.",StopSign!)
	Mle_1.SetFocus( )
	Return -1
end if

For li_i = 1 To UpperBound( ls_Validation )
	If Pos( ls_Expression, '~r~n' + ls_Validation[li_i] ) > 0 Then
		MessageBox(gnv_app.iapp_object.DisplayName, "The 'enter character' and '" + ls_Validation[li_i] + "' is not concatenation in expression.",StopSign!)
		Mle_1.SetFocus( )
		Return -1
	End If
Next

//END---Modify by Scofield on 2009-12-17

//replace ' with "
ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"', '~~"')//'"'

if Not IsValid(istr_pass) then 
	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
	mle_1.setfocus( )
	return -1
end if

if Not IsValid(istr_pass.s_u_dw) or upperbound(istr_pass.s_string_array) = 0 then
	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid.",StopSign!)
	mle_1.setfocus( )
	return -1
end if

lds = create n_ds
lds.SetTransObject(SQLCA)
ls_Systax = istr_pass.s_u_dw.describe("DataWindow.Syntax")
lds.create( ls_Systax, ls_Err)

ls_Err = ''
If IsNull( as_attribute ) Or Trim( as_attribute ) = '' Then
	as_attribute =  '.Expression="' + ls_Expression + '"'
Else

	as_attribute =  is_expression + '="' + is_Default + '~t' + ls_Expression + '"'
End If

ls_Err = lds.modify(istr_pass.s_string_array[1] +  as_attribute )
if ls_Err <> '' then
	messagebox(gnv_app.iapp_object.DisplayName,"Expression is not valid."  ,StopSign!)
	mle_1.setfocus( )
	if IsValid(lds) then destroy lds
	return -1
else
	if IsValid(lds) then destroy lds
	return 0
end if

end function

on w_export_expression.create
int iCurrent
call super::create
this.st_expression=create st_expression
this.sle_labeltext=create sle_labeltext
this.st_labeltext=create st_labeltext
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
this.Control[iCurrent+1]=this.st_expression
this.Control[iCurrent+2]=this.sle_labeltext
this.Control[iCurrent+3]=this.st_labeltext
this.Control[iCurrent+4]=this.lb_functions
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.cb_9
this.Control[iCurrent+8]=this.cb_8
this.Control[iCurrent+9]=this.cb_7
this.Control[iCurrent+10]=this.cb_6
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.cb_4
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.cb_3
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.mle_1
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.gb_2
end on

on w_export_expression.destroy
call super::destroy
destroy(this.st_expression)
destroy(this.sle_labeltext)
destroy(this.st_labeltext)
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
String ls_format,ls_border,ls_LabelName,ls_LabelText
Long   ll_Cnt,ll_Num,ll_Row,ll_Pos
Boolean lb_flag
integer li_pos
string ls_coltype
string ls_visible
pfc_cst_u_band ldw_band
datawindowchild ldwc_child

gf_wincenter(This)

If Not IsValid(istr_pass) Then Return
If UpperBound(istr_pass.s_string_array) < 1 Then Return
If Not IsValid(istr_pass.s_u_dw) Then Return

If UpperBound( istr_pass.s_String_Array ) = 3 Then
	is_Default = istr_pass.s_String_Array[3]
End If

ls_field = istr_pass.s_string_array[1]
If IsNull(ls_field) Then ls_field = ''

is_expression = istr_pass.as_search_type

mle_1.Text = istr_pass.s_string
mle_1.SetFocus( )

dw_1.SetRedraw(False)

//if istr_pass.l_facility_id = -1 then//screen call
Choose Case istr_pass.s_long[1]
	Case 2, 6  //2-Screen Painter Call    Added by gavins 20120504   add 6
		//<add> 11/15/2007 by: Andy
		SetRedraw(False)
		gb_3.Visible =  True
		lb_functions.Visible = True
		gb_2.X = gb_3.X + gb_3.Width + 32
		gb_2.Width = mle_1.Width - gb_1.Width - 32 - gb_3.Width - 32
		dw_1.X = gb_2.X + 32
		dw_1.Width = gb_2.Width - 64 //124
		SetRedraw(True)
		//end of add
		
		//Add visible - 09.20.2010
		dw_2.dataobject = 'd_contract_compute_property'
		dw_2.insertrow( 0)
		
		//***************************/
		//modified by gavins 20120504
		dw_2.Visible = False
		st_expression.Visible = TRUE
		//***************************/
		dw_1.DataObject = 'd_export_fields_screen'
		dw_1.SetTransObject(sqlca)
		//dw_1.Modify("ctx_column_datatype.visible='0'")
		//<Modify> 11/13/2007 by: Andy
		//add column
		ldw_band = istr_pass.s_u_dw
		
		//	modify by gavin on 2009/3/5
		ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ColumnList, "column", "*", False,True)
		//istr_pass.s_u_dw.inv_base.of_getobjects( ls_ColumnList, "column", "*", FALSE)
		
		ll_Cnt = UpperBound(ls_ColumnList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ColumnList[ll_Num])
		Next
		
		// add compute    //modify by gavin on 2009/3/5
		ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ComputeList, "compute", "*", False,True)
		//istr_pass.s_u_dw.inv_base.of_getobjects( ls_ComputeList, "compute", "*", FALSE)
		
		ll_Cnt = UpperBound(ls_ComputeList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ComputeList[ll_Num])
		Next
		//<add> 01.04.2008 by: Andy
		If dw_1.RowCount( ) > 0 Then
			dw_1.SelectRow( 0, False)
		End If
		//<add> 06/22/2007 by: Andy
		//format
		ls_format = istr_pass.s_u_dw.Describe( ls_field + ".format")
		If IsNull(ls_format) Then ls_format = ''
		If ls_format = '!' Or ls_format = '?' Or ls_format = '' Then
			//do nothing
		Else
			dw_2.SetItem(1,"format",Lower(ls_format))
		End If
		
		//border	
		ls_border = ldw_band.iuo_parent.uo_band.dw_syntax.Describe( ls_field + ".border")

		dw_2.SetItem(1,"border",ls_border)
		
		//<add> 06/25/2007 by: Andy
		dw_2.Modify("t_2.text='" + ls_field + "'")
		//end of add
		//end of Modify
		
		//Visible - jervis 09.20.2010
		ls_visible = ldw_band.iuo_parent.uo_band.dw_syntax.Describe( ls_field + ".visible")
		dw_2.SetItem(1,"visible",ls_visible)
		
		if IsNull(istr_pass.s_string) or Trim(istr_pass.s_string) = "" then
			ls_LabelName = ldw_band.iuo_parent.uo_band.dw_syntax.Describe(ls_field + "_t.name")
			if ls_LabelName = "!" then
				st_LabelText.Visible = true
				
				ls_LabelText = Mid(ls_field,Len("object") + 1)
				ll_Pos = LastPos(ls_LabelText,"_")
				if ll_Pos <= 0 then ll_Pos = Len(ls_LabelText) + 1
				ls_LabelText = Left(ls_LabelText,ll_Pos - 1)
				
				do 
					ll_Pos = Pos(ls_LabelText,"_")
					if ll_Pos > 0 then
						ls_LabelText = Replace(ls_LabelText,ll_Pos,1," ")
					end if
				loop while ll_Pos > 0
				
				sle_LabelText.Text = "Label " + ls_LabelText
				sle_LabelText.Visible = true
			end if
		end if
	Case 1	//1-Export Painter Call
		//else//export call
		dw_2.Visible = False
		mle_1.Y = dw_2.Y
		mle_1.Height = mle_1.Height + dw_2.Height + 20
		
		dw_1.DataObject = 'd_export_fields'
		dw_1.SetTransObject(sqlca)
		dw_1.Retrieve(istr_pass.l_facility_id)
	Case 3 //3-Advanced update in workflow Call	- jervis 03.12.2009
		SetRedraw(False)
		dw_2.Visible = False
		mle_1.Y = dw_2.Y
		mle_1.Height = mle_1.Height + dw_2.Height + 20
		gb_3.Visible =  True
		lb_functions.Visible = True
		gb_2.X = gb_3.X + gb_3.Width + 32
		gb_2.Width = mle_1.Width - gb_1.Width - 32 - gb_3.Width - 32
		dw_1.X = gb_2.X + 32
		dw_1.Width = gb_2.Width - 64 //124
		SetRedraw(True)
		
		dw_1.DataObject = 'd_export_fields'
		
		//Get column objects
		istr_pass.s_u_dw.inv_base.of_getobjects( ls_ColumnList, "column", "*", False,True)
		
		ll_Cnt = UpperBound(ls_ColumnList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ColumnList[ll_Num])
			
			if pos(ls_ColumnList[ll_Num],'[') > 0 and pos(ls_ColumnList[ll_Num],']') > 0 then
				li_pos = pos(ls_ColumnList[ll_Num],'[')
				ls_ColumnList[ll_Num] = Left(ls_ColumnList[ll_Num],li_pos - 2)
			end if

			ls_coltype = istr_pass.s_u_dw.Describe(ls_ColumnList[ll_Num]+ ".coltype")
			Choose Case Left ( ls_coltype , 5 )
				Case "char(", "char"
					ls_coltype = 'S'
				Case "date"	,"datet"	,"time", "times"
					ls_coltype = 'D'
				Case "decim","numbe", "doubl", "real","long", "ulong", "int"
					ls_coltype = 'N'
			End Choose
			dw_1.SetItem(ll_row,"ctx_column_datatype",ls_coltype)
		Next
		
		//Get Compute objects
		istr_pass.s_u_dw.inv_base.of_getobjects( ls_ComputeList, "compute", "*", False,True)
		
		ll_Cnt = UpperBound(ls_ComputeList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ComputeList[ll_Num])
			
			if pos(ls_ColumnList[ll_Num],'[') > 0 and pos(ls_ColumnList[ll_Num],']') > 0 then
				li_pos = pos(ls_ColumnList[ll_Num],'[')
				ls_ColumnList[ll_Num] = Left(ls_ColumnList[ll_Num],li_pos - 2)
			end if
			ls_coltype = istr_pass.s_u_dw.Describe(ls_ColumnList[ll_Num]+ ".coltype")
			Choose Case Left ( ls_coltype , 5 )
				Case "char(", "char"
					ls_coltype = 'S'
				Case "date"	,"datet"	,"time", "times"
					ls_coltype = 'D'
				Case "decim","numbe", "doubl", "real","long", "ulong", "int"
					ls_coltype = 'N'
			End Choose
			dw_1.SetItem(ll_row,"ctx_column_datatype",ls_coltype)
		Next

		If dw_1.RowCount( ) > 0 Then
			dw_1.SelectRow( 0, False)
		End If
	Case 4 //4-Trigger parm for work flow -- jervis 10.23.2009
		SetRedraw(False)
		dw_2.Visible = False
		mle_1.Y = dw_2.Y
		mle_1.Height = mle_1.Height + dw_2.Height + 20
		gb_3.Visible =  True
		lb_functions.Visible = True
		gb_2.X = gb_3.X + gb_3.Width + 32
		gb_2.Width = mle_1.Width - gb_1.Width - 32 - gb_3.Width - 32
		dw_1.X = gb_2.X + 32
		dw_1.Width = gb_2.Width - 64 //124
		cb_1.visible = false
		SetRedraw(True)

		
		dw_1.DataObject = 'd_export_fields_dbname'
		dw_1.SetTransObject(sqlca)

		
		if istr_pass.s_u_dw.getchild('field_label',ldwc_child) = 1 then
			ll_Cnt = ldwc_child.RowCount( )
			For ll_Num = 1 To ll_Cnt
				ll_Row = dw_1.InsertRow(0)
				//---------Begin Modified by (Appeon)Harry 01.23.2014 for V142 ISG-CLX--------
				//dw_1.SetItem(ll_Row,"export_field_name",ldwc_child.GetItemString(ll_num,'field_dbname'))
				//Begin - Added By Mark Lee 09/07/12
				If isnull(ldwc_child.GetItemString(ll_num,'field_dbname') ) Then 
					dw_1.SetItem(ll_Row,"export_field_name",ldwc_child.GetItemString(ll_num,'sys_fields_field_name'))
				Else
					dw_1.SetItem(ll_Row,"export_field_name",ldwc_child.GetItemString(ll_num,'field_dbname'))
				End If
				//End - Added By Mark Lee 09/07/12
				//---------End Modfiied ------------------------------------------------------
				dw_1.SetItem(ll_Row,"export_field_label",ldwc_child.GetItemString(ll_num,'data_view_fields_field_label'))
			Next
			
			If dw_1.RowCount( ) > 0 Then dw_1.SelectRow( 0, False)
		end if
	Case 5 //added by gavins 20120503   compute
		SetRedraw(False)
		dw_2.Visible = False
		mle_1.Y = dw_2.Y
		mle_1.Height = mle_1.Height + dw_2.Height + 20
		gb_3.Visible =  True
		lb_functions.Visible = True
		gb_2.X = gb_3.X + gb_3.Width + 32
		gb_2.Width = mle_1.Width - gb_1.Width - 32 - gb_3.Width - 32
		dw_1.X = gb_2.X + 32
		dw_1.Width = gb_2.Width - 64 //124
		cb_1.visible = true
		SetRedraw(True)
		
		this.title = wordcap(is_expression) + ' Expression'
		is_expression = "." + is_expression 
		
		
		dw_1.DataObject = 'd_export_fields_dbname'
		dw_1.SetTransObject(sqlca)

		
		ldw_band = istr_pass.s_u_dw
		
		//	add column
		ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ColumnList, "column", "*", False,True)
		
		ll_Cnt = UpperBound(ls_ColumnList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ColumnList[ll_Num])
		Next
		
		// add compute    
		ldw_band.iuo_parent.uo_band.dw_syntax.inv_base.of_getobjects( ls_ComputeList, "compute", "*", False,True)
		
		ll_Cnt = UpperBound(ls_ComputeList)
		For ll_Num = 1 To ll_Cnt
			ll_Row = dw_1.InsertRow(0)
			dw_1.SetItem(ll_Row,"export_field_name",ls_ComputeList[ll_Num])
		Next

		If dw_1.RowCount( ) > 0 Then
			dw_1.SelectRow( 0, False)
		End If
End Choose

//filter current computer fields
dw_1.SetFilter("export_field_name<>'" + ls_field + "'")
dw_1.Filter( )

//set sort
dw_1.SetSort("export_field_name A")
dw_1.Sort()

this.event ue_init_function(istr_pass.s_long[1])

dw_1.SetRedraw(True)

end event

type st_expression from statictext within w_export_expression
integer x = 27
integer y = 104
integer width = 384
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Expression:"
boolean focusrectangle = false
end type

event constructor;visible = false
end event

type sle_labeltext from singlelineedit within w_export_expression
boolean visible = false
integer x = 576
integer y = 1232
integer width = 530
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type st_labeltext from statictext within w_export_expression
boolean visible = false
integer x = 37
integer y = 1252
integer width = 535
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Computed Field Label:"
boolean focusrectangle = false
end type

type lb_functions from listbox within w_export_expression
event ue_lbuttonup pbm_lbuttonup
boolean visible = false
integer x = 539
integer y = 672
integer width = 695
integer height = 504
integer taborder = 120
integer textsize = -8
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

event constructor;//is_Function[1] = "abs( x )"; ii_SelStart[1] = 5; ii_SelNum[1] = 3
//is_Function[2] = "acos( x )"; ii_SelStart[2] = 6; ii_SelNum[2] = 3
//is_Function[2] = "asc( s )"; ii_SelStart[2] = 5; ii_SelNum[2] = 3
//is_Function[3] = "asin( s )"; ii_SelStart[3] = 6; ii_SelNum[3] = 3
//is_Function[4] = "atan( s )"; ii_SelStart[4] = 6; ii_SelNum[4] = 3
//is_Function[5] = "avg( #x for all )"; ii_SelStart[5] = 6; ii_SelNum[5] = 2
//is_Function[6] = "bitmap ( s )"; ii_SelStart[6] = 9; ii_SelNum[6] = 3
//is_Function[7] = "case( x when a then b when c then d... else e)"; ii_SelStart[7] = 6; ii_SelNum[7] = 40
//is_Function[8] = "ceiling( x )"; ii_SelStart[8] = 9; ii_SelNum[8] = 3
//is_Function[9] = "char( x )"; ii_SelStart[9] = 6; ii_SelNum[9] = 3
//is_Function[10] = "cos( x )"; ii_SelStart[10] = 5; ii_SelNum[10] = 3
//
//is_Function[11] = "count( #x for all )"; ii_SelStart[11] = 8; ii_SelNum[11] = 2
//is_Function[12] = "crosstabavg( 1 )"; ii_SelStart[12] = 13; ii_SelNum[12] = 3
//is_Function[13] = "crosstabcount( 1 )"; ii_SelStart[13] = 15; ii_SelNum[13] = 3
//is_Function[14] = "crosstabmax( 1 )"; ii_SelStart[14] = 13; ii_SelNum[14] = 3
//is_Function[15] = "crosstabmin( 1 )"; ii_SelStart[15] = 13; ii_SelNum[15] = 3
//is_Function[16] = "crosstabsum( 1 )"; ii_SelStart[16] = 13; ii_SelNum[16] = 3
//is_Function[17] = "cumulativePercent( #x for all )"; ii_SelStart[17] = 20; ii_SelNum[17] = 2
//is_Function[18] = "cumulativeSum( #x for all )"; ii_SelStart[18] = 16; ii_SelNum[18] = 2
//is_Function[19] = "currentRow()"; ii_SelStart[19] = 13; ii_SelNum[19] = 0
//is_Function[20] = "date( s )"; ii_SelStart[20] = 6; ii_SelNum[20] = 3
//
//is_Function[21] = "datetime( s )"; ii_SelStart[21] = 10; ii_SelNum[21] = 3
//is_Function[22] = "day( d )"; ii_SelStart[22] = 5; ii_SelNum[22] = 3
//is_Function[23] = "dayname( d )"; ii_SelStart[23] = 9; ii_SelNum[23] = 3
//is_Function[24] = "daynumber( d )"; ii_SelStart[24] = 11; ii_SelNum[24] = 3
//is_Function[25] = "daysafter( d, d )"; ii_SelStart[25] = 11; ii_SelNum[25] = 6
//is_Function[26] = "describe( s )"; ii_SelStart[26] = 10; ii_SelNum[26] = 3
//is_Function[27] = "exp( x )"; ii_SelStart[27] = 5; ii_SelNum[27] = 3
//is_Function[28] = "fact( x )"; ii_SelStart[28] = 6; ii_SelNum[28] = 3
//is_Function[29] = "fill( s, x )"; ii_SelStart[29] = 6; ii_SelNum[29] = 6
//is_Function[30] = "first( #x for all )"; ii_SelStart[30] = 8; ii_SelNum[30] = 2
//
//
//is_Function[31] = "getrow()"; ii_SelStart[31] = 9; ii_SelNum[31] = 0
//is_Function[32] = "gettext()"; ii_SelStart[32] = 10; ii_SelNum[32] = 0
//is_Function[33] = "hour( t )"; ii_SelStart[33] = 6; ii_SelNum[33] = 3
//is_Function[34] = "if( b, t, f )"; ii_SelStart[34] = 4; ii_SelNum[34] = 9
//is_Function[35] = "int( x )"; ii_SelStart[35] = 5; ii_SelNum[35] = 3
//is_Function[36] = "integer( s )"; ii_SelStart[36] = 9; ii_SelNum[36] = 3
//is_Function[37] = "isDate( s )"; ii_SelStart[37] = 8; ii_SelNum[37] = 3
//is_Function[38] = "isNull( x )"; ii_SelStart[38] = 8; ii_SelNum[38] = 3
//is_Function[39] = "isNumber( s )"; ii_SelStart[39] = 10; ii_SelNum[39] = 3
//is_Function[40] = "isRowModified()"; ii_SelStart[40] = 16; ii_SelNum[40] = 0
//
//is_Function[41] = "isRowNew()"; ii_SelStart[41] = 11; ii_SelNum[41] = 0
//is_Function[42] = "isSelected()"; ii_SelStart[42] = 13; ii_SelNum[42] = 0
//is_Function[43] = "isTime( s )"; ii_SelStart[43] = 8; ii_SelNum[43] = 3
//is_Function[44] = "large( #x, #x, n for all )"; ii_SelStart[44] = 8; ii_SelNum[44] = 2
//is_Function[45] = "last( #x for all )"; ii_SelStart[45] = 7; ii_SelNum[45] = 2
//is_Function[46] = "lastpos( s, s, x )"; ii_SelStart[46] = 9; ii_SelNum[46] = 9
//is_Function[47] = "left( s, n )"; ii_SelStart[47] = 6; ii_SelNum[47] = 6
//is_Function[48] = "leftTrim( s )"; ii_SelStart[48] = 10; ii_SelNum[48] = 3
//is_Function[49] = "len( s )"; ii_SelStart[49] = 5; ii_SelNum[49] = 3
//is_Function[50] = "log( x )"; ii_SelStart[50] = 5; ii_SelNum[50] = 3
//
//is_Function[51] = "logten( x )"; ii_SelStart[51] = 8; ii_SelNum[51] = 3
//is_Function[52] = "long( s )"; ii_SelStart[52] = 6; ii_SelNum[52] = 3
//is_Function[53] = "lookupdisplay( #x )"; ii_SelStart[53] = 16; ii_SelNum[53] = 2
//is_Function[54] = "lower( s )"; ii_SelStart[54] = 7; ii_SelNum[54] = 3
//is_Function[55] = "match( s, s )"; ii_SelStart[55] = 7; ii_SelNum[55] = 6
//is_Function[56] = "max( #x for all )"; ii_SelStart[56] = 6; ii_SelNum[56] = 2
//is_Function[57] = "median( #x for all )"; ii_SelStart[57] = 9; ii_SelNum[57] = 2
//is_Function[58] = "mid( s, start, len )"; ii_SelStart[58] = 5; ii_SelNum[58] = 15
//is_Function[59] = "min( #x for all )"; ii_SelStart[59] = 6; ii_SelNum[59] = 2
//is_Function[60] = "minute( t )"; ii_SelStart[60] = 8; ii_SelNum[60] = 3
//
//is_Function[61] = "mod( x, y )"; ii_SelStart[61] = 5; ii_SelNum[61] = 6
//is_Function[62] = "mode( #x for all )"; ii_SelStart[62] = 7; ii_SelNum[62] = 2
//is_Function[63] = "month( d )"; ii_SelStart[63] = 7; ii_SelNum[63] = 3
//is_Function[64] = "now()"; ii_SelStart[64] = 6; ii_SelNum[64] = 0
//is_Function[65] = "number( s )"; ii_SelStart[65] = 8; ii_SelNum[65] = 3
//is_Function[66] = "page()"; ii_SelStart[66] = 7; ii_SelNum[66] = 0
//is_Function[67] = "pageabs()"; ii_SelStart[67] = 10; ii_SelNum[67] = 0
//is_Function[68] = "pageAcross()"; ii_SelStart[68] = 13; ii_SelNum[68] = 0
//is_Function[69] = "pageCount()"; ii_SelStart[69] = 12; ii_SelNum[69] = 0
//is_Function[70] = "pageCountAcross()"; ii_SelStart[70] = 18; ii_SelNum[70] = 0
//
//is_Function[71] = "percent( #x for all)"; ii_SelStart[71] = 10; ii_SelNum[71] = 2
//is_Function[72] = "pi( x )"; ii_SelStart[72] = 4; ii_SelNum[72] = 3
//is_Function[73] = "pos( s, s, x )"; ii_SelStart[73] = 5; ii_SelNum[73] = 9
//is_Function[74] = "profileint( s, s, s, x )"; ii_SelStart[74] = 12; ii_SelNum[74] = 12
//is_Function[75] = "profilestring( s, s, s, s )"; ii_SelStart[75] = 15; ii_SelNum[75] = 12
//is_Function[76] = "rand( x )"; ii_SelStart[76] = 6; ii_SelNum[76] = 3
//is_Function[77] = "real( s )"; ii_SelStart[77] = 6; ii_SelNum[77] = 3
//is_Function[78] = "relativedate( d, x )"; ii_SelStart[78] = 14; ii_SelNum[78] = 6
//is_Function[79] = "relativetime( t, x )"; ii_SelStart[79] = 14; ii_SelNum[79] = 6
//is_Function[80] = "replace( s, x, y, s )"; ii_SelStart[80] = 9; ii_SelNum[80] = 12
//
//is_Function[81] = "rgb( r, g, b )"; ii_SelStart[81] = 5; ii_SelNum[81] = 9
//is_Function[82] = "right( s, n )"; ii_SelStart[82] = 5; ii_SelNum[82] = 6
//is_Function[83] = "rightTrim( s )"; ii_SelStart[83] = 11; ii_SelNum[83] = 3
//is_Function[84] = "round( x, x )"; ii_SelStart[84] = 7; ii_SelNum[84] = 6
//is_Function[85] = "rowcount()"; ii_SelStart[85] = 11; ii_SelNum[85] = 0
//is_Function[86] = "rowheight()"; ii_SelStart[86] = 12; ii_SelNum[86] = 0
//is_Function[87] = "second( t )"; ii_SelStart[87] = 8; ii_SelNum[87] = 3
//is_Function[88] = "secondsafter( t, t )"; ii_SelStart[88] = 14; ii_SelNum[88] = 6
//is_Function[89] = "sign( x )"; ii_SelStart[89] = 6; ii_SelNum[89] = 3
//is_Function[90] = "sin( x )"; ii_SelStart[90] = 5; ii_SelNum[90] = 3
//
//is_Function[91] = "small( #x, #x, n for all )"; ii_SelStart[91] = 8; ii_SelNum[91] = 2
//is_Function[92] = "space( x )"; ii_SelStart[92] = 7; ii_SelNum[92] = 3
//is_Function[93] = "sqrt( x )"; ii_SelStart[93] = 6; ii_SelNum[93] = 3
//is_Function[94] = "stdev( #x for all )"; ii_SelStart[94] = 8; ii_SelNum[94] = 2
//is_Function[95] = "stdevp( #x for all )"; ii_SelStart[95] = 9; ii_SelNum[95] = 2
//is_Function[96] = "string( x, s )"; ii_SelStart[96] = 8; ii_SelNum[96] = 6
//is_Function[97] = "sum( #x for all )"; ii_SelStart[97] = 6; ii_SelNum[97] = 2
//is_Function[98] = "tan( x )"; ii_SelStart[98] = 5; ii_SelNum[98] = 3
//is_Function[99] = "time( s )"; ii_SelStart[99] = 6; ii_SelNum[99] = 3
//is_Function[100] = "today()"; ii_SelStart[100] = 8; ii_SelNum[100] = 0
//
//is_Function[101] = "trim( s )"; ii_SelStart[101] = 6; ii_SelNum[101] = 3
//is_Function[102] = "truncate( x, y )"; ii_SelStart[102] = 10; ii_SelNum[102] = 6
//is_Function[103] = "upper( s )"; ii_SelStart[103] = 7; ii_SelNum[103] = 3
//is_Function[104] = "var( #x for all )"; ii_SelStart[104] = 6; ii_SelNum[104] = 2
//is_Function[105] = "varp( #x for all )"; ii_SelStart[105] = 7; ii_SelNum[105] = 2
//is_Function[106] = "wordcap( s )"; ii_SelStart[106] = 9; ii_SelNum[106] = 3
//is_Function[107] = "year( d )"; ii_SelStart[107] = 6; ii_SelNum[107] = 3
//
/////////////////////////////////////////////////////////////////////////////////////////
//integer i
//integer li_ItemCount
//
//li_ItemCount = UpperBound(is_Function)
//for i = 1 to li_ItemCount
//	this.AddItem(is_Function[i])
//next
//
end event

event selectionchanged;ii_CurrFunction = Index
end event

type gb_3 from groupbox within w_export_expression
boolean visible = false
integer x = 512
integer y = 608
integer width = 750
integer height = 600
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Functions:"
end type

type dw_2 from u_dw within w_export_expression
integer x = 14
integer y = 32
integer width = 2208
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

type cb_9 from commandbutton within w_export_expression
integer x = 274
integer y = 1040
integer width = 151
integer height = 92
integer taborder = 80
integer textsize = -8
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

type cb_8 from commandbutton within w_export_expression
integer x = 82
integer y = 1040
integer width = 151
integer height = 92
integer taborder = 170
integer textsize = -8
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

type cb_7 from commandbutton within w_export_expression
integer x = 274
integer y = 884
integer width = 151
integer height = 92
integer taborder = 160
integer textsize = -8
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

type cb_6 from commandbutton within w_export_expression
integer x = 82
integer y = 884
integer width = 151
integer height = 92
integer taborder = 150
integer textsize = -8
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

type cb_5 from commandbutton within w_export_expression
integer x = 274
integer y = 728
integer width = 151
integer height = 92
integer taborder = 140
integer textsize = -8
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

type cb_4 from commandbutton within w_export_expression
integer x = 82
integer y = 728
integer width = 151
integer height = 92
integer taborder = 130
integer textsize = -8
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

type dw_1 from u_dw within w_export_expression
integer x = 544
integer y = 672
integer width = 1632
integer height = 504
integer taborder = 110
string dataobject = "d_export_fields"
end type

event constructor;call super::constructor;//<add> 05/24/2007 by: Andy
of_SetRowSelect ( true )
//<add> 06/21/2007 by: Andy
of_SetUpdateable(False)
end event

event clicked;call super::clicked;//<modify> andy 2007.11.15
Integer  li_pos
Integer  li_count
if row < 1 then return 

is_CurrColumn = getitemstring(row,"export_field_name")

//modify by gavin on 2009/3/5
if pos(is_CurrColumn,'[') > 0 and pos(is_CurrColumn,']') > 0 then
	li_pos = pos(is_CurrColumn,'[')
	is_CurrColumn = Left(is_CurrColumn,li_pos - 2)
end if

Post event ue_replacetext( 2 )
//of_set_mletext(mle_1,getitemstring(row,"export_field_name"))
end event

type cb_3 from commandbutton within w_export_expression
integer x = 1893
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;//<add> andy 2007.05.28
String ls_Ret

setnull(ls_Ret)
CloseWithReturn(Parent,ls_Ret)
end event

type cb_2 from commandbutton within w_export_expression
integer x = 1545
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
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
pfc_cst_u_band ldw_band
String ls_ModifySyn
string ls_visible, ls_Null[]

//Verify failed
Choose Case istr_pass.s_long[1]
	Case 2, 6  //2- screen call
		//If istr_pass.l_facility_id = -1 Then//screen call
		If of_check_screen() = -1 Then Return
	Case 1 //1-export call
		//else//export call
		If of_check() = -1 Then Return
	Case 3 //3-advanced update in workflow call	- 03.12.2009 by jervis
		if of_check() = -1 then return
	Case 5
		If of_check_screen( is_expression ) = -1 Then Return
End Choose

ls_Expression      = mle_1.Text
ls_Tag             = mle_1.Text
lstr_pass.s_string = mle_1.Text

//<Modify> 11/13/2007 by: Andy
//screen call
//if istr_pass.l_facility_id = -1 then
If istr_pass.s_long[1] = 2 Then	//2-Screen Call
	dw_2.AcceptText( )
	//replace ' with "
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"','~~"')
	ls_format = dw_2.GetItemString(1,"format")
	ls_border = dw_2.GetItemString(1,"border")
	ls_visible = dw_2.GetItemString(1,"visible")
	
	ls_visible  = lnvo_string.of_globalreplace( ls_visible, "'", ' ')//added by gavins 20120315 
	ls_visible  = lnvo_string.of_globalreplace( ls_visible, '"',' ')
	
	//Modify s_u_dw: save expression
	ls_Modify = istr_pass.s_string_array[1] + '.Expression="' + ls_Expression + '"'
	If IsNull(ls_format) Then ls_format = ''
	If ls_format <> '' Then
		ls_Modify = ls_Modify + " " + istr_pass.s_string_array[1] + ".format='" + ls_format + "'"
	End If
	
	//Add Visible -- Jervis 09.20.2010
	ls_Modify = ls_Modify + " " + istr_pass.s_string_array[1] + ".visible='" + ls_visible+ "' "
	ls_ModifySyn = ls_Modify
	ls_ModifySyn = ls_ModifySyn + " " + istr_pass.s_string_array[1] + ".border='" + ls_border + "'"
	
	ls_Modify = ls_Modify + " " + istr_pass.s_string_array[1] + ".border='5'"
	
	//Add visible - jervis 09.20.2010
	ls_Modify += LEFTUPTEXTMARK + istr_pass.s_string_array[1] + ".visible = '" + ls_Visible + "' "
	ls_Modify += LEFTDOWNTEXTMARK + istr_pass.s_string_array[1] + ".visible = '" + ls_Visible + "' "
	ls_Modify += RIGHTUPTEXTMARK + istr_pass.s_string_array[1] + ".visible = '" + ls_Visible + "' "
	ls_Modify += RIGHTDOWNTEXTMARK + istr_pass.s_string_array[1] + ".visible = '" + ls_Visible + "' "

		
	ls_Err    = istr_pass.s_u_dw.Modify(ls_Modify)
	//<add> 11/13/2007 by: Andy
	ldw_band  = istr_pass.s_u_dw
	if IsValid(ldw_band.iuo_Parent) then
		ldw_band.iuo_Parent.Event ue_setmodify(ls_ModifySyn)
		//added by gavins 20120405
		If ls_Visible = '0'  And     UPPER(   ldw_band.iuo_Parent.is_CurBand ) =  'DETAIL' Then
			 ldw_band.iuo_Parent.of_showHideGridcolumn( ls_Null, { istr_pass.s_string_array[1] }, 0,0,'' )
			
		End If
	End If
	
	lstr_pass.s_string_array[1] = sle_LabelText.Text
ElseIf istr_pass.s_long[1] = 5 Then
	//replace ' with "
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"','~~"')
	
	lstr_pass.s_string = ls_Expression
ElseIf istr_pass.s_long[1] = 6 Then  //added by gavins 20120504
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '~~', '~~~~')
	ls_Expression  = lnvo_string.of_globalreplace( ls_Expression, '"','~~"')
	
	ls_Modify = istr_pass.s_string_array[1] + '.Expression="' + ls_Expression + '"'
	
	ls_Err    = istr_pass.s_u_dw.Modify(ls_Modify)
	//<add> 11/13/2007 by: Andy
	ldw_band  = istr_pass.s_u_dw
	if IsValid(ldw_band.iuo_Parent) then
		ldw_band.iuo_Parent.Event ue_setmodify(ls_ModifySyn)
		//added by gavins 20120405
		If ls_Visible = '0'  And     UPPER(   ldw_band.iuo_Parent.is_CurBand ) =  'DETAIL' Then
			 ldw_band.iuo_Parent.of_showHideGridcolumn( ls_Null, { istr_pass.s_string_array[1] }, 0,0,'' )
			
		End If
	End If
	
	lstr_pass.s_string_array[1] = sle_LabelText.Text
End If
//end of modify

//successful
CloseWithReturn(Parent,lstr_pass)

end event

type cb_1 from commandbutton within w_export_expression
integer x = 1198
integer y = 1232
integer width = 311
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;//Modify by jervis 03.12.2009
Choose Case istr_pass.s_long[1]
	Case 2, 6 //2-Screen Painter Call
		//if istr_pass.l_facility_id = -1 then//screen call
		If of_check_screen() = 0 Then
			MessageBox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
		End If
	Case 1 //1-Export Painter Call
		//else//export call
		If of_check() = 0 Then
			MessageBox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
		End If
	Case 3 //Advanced update in workflow call
		If of_check() = 0 Then
			MessageBox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
		End If
	Case 5  
		If of_check_screen( is_Expression ) = 0 Then
			MessageBox(gnv_app.iapp_object.DisplayName,"Expression is OK.")
		End If
		
End Choose


end event

type mle_1 from multilineedit within w_export_expression
integer x = 37
integer y = 168
integer width = 2162
integer height = 436
integer taborder = 20
integer textsize = -8
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

type gb_1 from groupbox within w_export_expression
integer x = 37
integer y = 608
integer width = 443
integer height = 600
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Operator"
end type

type gb_2 from groupbox within w_export_expression
integer x = 512
integer y = 608
integer width = 1696
integer height = 600
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Columns:"
end type

