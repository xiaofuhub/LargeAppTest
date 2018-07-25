$PBExportHeader$w_compute_wizard.srw
forward
global type w_compute_wizard from window
end type
type cb_6 from commandbutton within w_compute_wizard
end type
type cb_5 from commandbutton within w_compute_wizard
end type
type cb_3 from commandbutton within w_compute_wizard
end type
type cb_4 from commandbutton within w_compute_wizard
end type
type cb_2 from commandbutton within w_compute_wizard
end type
type cb_1 from commandbutton within w_compute_wizard
end type
type lb_columns from listbox within w_compute_wizard
end type
type lb_functions from listbox within w_compute_wizard
end type
type st_3 from statictext within w_compute_wizard
end type
type st_2 from statictext within w_compute_wizard
end type
type cb_verify from commandbutton within w_compute_wizard
end type
type cb_cancel from commandbutton within w_compute_wizard
end type
type cb_ok from commandbutton within w_compute_wizard
end type
type st_1 from statictext within w_compute_wizard
end type
type mle_express from multilineedit within w_compute_wizard
end type
end forward

global type w_compute_wizard from window
integer width = 2405
integer height = 1264
boolean titlebar = true
string title = "Compute Expression Wizard"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_replacetext ( integer ai_flag )
event ue_addcolumns ( )
cb_6 cb_6
cb_5 cb_5
cb_3 cb_3
cb_4 cb_4
cb_2 cb_2
cb_1 cb_1
lb_columns lb_columns
lb_functions lb_functions
st_3 st_3
st_2 st_2
cb_verify cb_verify
cb_cancel cb_cancel
cb_ok cb_ok
st_1 st_1
mle_express mle_express
end type
global w_compute_wizard w_compute_wizard

type variables
string  is_Function[]
integer ii_SelStart[]
integer ii_SelNum[]

integer ii_CurrFunction
integer ii_CurrColumn

DataWindow idw_data
constant string IS_COMPUTE_SYNTAX = "compute_syntax"

string is_Return = "cancel!"
end variables

forward prototypes
public function boolean of_verify (boolean ab_showmsg)
public function string of_convertexpression (string as_expression)
end prototypes

event ue_replacetext(integer ai_flag);string  ls_Column
integer li_Position

if ai_flag = 1 then
	li_Position = mle_express.Position()
	mle_express.ReplaceText(is_Function[ii_CurrFunction])
	li_Position += ii_SelStart[ii_CurrFunction] - 1
	mle_express.SelectText(li_Position, ii_SelNum[ii_CurrFunction])
	lb_functions.DeleteItem(ii_CurrFunction)
	lb_functions.InsertItem(is_Function[ii_CurrFunction], ii_CurrFunction)
else
	ls_Column = " " + lb_columns.Text(ii_CurrColumn) + " "
	mle_express.ReplaceText(ls_Column)
	ls_Column = lb_columns.Text(ii_CurrColumn)
	lb_columns.DeleteItem(ii_CurrColumn)
	lb_columns.InsertItem(ls_Column, ii_CurrColumn)	
end if
mle_express.SetFocus()
end event

event ue_addcolumns();string ls_Column
integer i, li_Count

lb_columns.Reset()
li_Count = Integer(idw_data.Describe("datawindow.column.count"))

for i = 1 to li_Count
	ls_Column = idw_data.Describe("#" + String(i) + ".name")	
	if Lower(ls_Column) <> IS_COMPUTE_SYNTAX then
		lb_columns.AddItem(ls_Column)
	end if
next
end event

public function boolean of_verify (boolean ab_showmsg);//---------Begin Modified by (Appeon)Toney 06.17.2013 for V141 ISG-CLX--------
  /*
	string ls_Error
	string ls_Create
	
	if IsNull(mle_express.text) or Trim(mle_express.text) = "" then
		//MessageBox("DataWindow", "Null expression is not valid.", Exclamation!)
		if ab_ShowMsg then MessageBox("DataWindow", "Expression is OK.", Exclamation!)
		Return true
	end if
	
	if idw_data.Describe(IS_COMPUTE_SYNTAX + ".tag") <> "notcreate" then
		ls_Create = 'create compute(band=footer expression="1" x="0" y="0" height="0" width="0" name=' + IS_COMPUTE_SYNTAX + ' visible="0")'
		idw_data.Modify(ls_Create)
		idw_data.Modify(IS_COMPUTE_SYNTAX + ".tag='notcreate'")	
	end if
	
	ls_Error = idw_data.Modify(IS_COMPUTE_SYNTAX + ".expression=~"" + of_ConvertExpression(mle_express.text) + "~"")
	if ls_Error = "" then
		if ab_ShowMsg then MessageBox("DataWindow", "Expression is OK.", Exclamation!)
		Return true
	else
		MessageBox("DataWindow", "Expression is not valid.", StopSign!)
		Return false
	end if
  */
long		ll_Pos
long		ll_LeftBracketCnts,ll_RightBracketCnts
String	ls_ProExp,ls_Create,ls_Error

ls_ProExp = mle_Express.text

if IsNull(ls_ProExp) or Trim(ls_ProExp) = "" then
	//MessageBox("DataWindow", "Null expression is not valid.", Exclamation!)
	if ab_ShowMsg then MessageBox("DataWindow", "Expression is OK.", Exclamation!)
	Return true
end if

//BEGIN---Modify by Scofield on 2009-12-17

ll_Pos = Pos(ls_ProExp,"(")
do while ll_Pos > 0
	ll_LeftBracketCnts++
	ll_Pos = Pos(ls_ProExp,"(",ll_Pos + 1)
loop

ll_Pos = Pos(ls_ProExp,")")
do while ll_Pos > 0
	ll_RightBracketCnts++
	ll_Pos = Pos(ls_ProExp,")",ll_Pos + 1)
loop

if ll_LeftBracketCnts <> ll_RightBracketCnts then
	MessageBox("DataWindow", "The left parenthesis and the right parenthesis are mismatched.",StopSign!)
	Return false
end if

//END---Modify by Scofield on 2009-12-17

if idw_data.Describe(IS_COMPUTE_SYNTAX + ".tag") <> "notcreate" then
	ls_Create = 'create compute(band=footer expression="1" x="0" y="0" height="0" width="0" name=' + IS_COMPUTE_SYNTAX + ' visible="0")'
	idw_data.Modify(ls_Create)
	idw_data.Modify(IS_COMPUTE_SYNTAX + ".tag='notcreate'")	
end if

ls_Error = idw_data.Modify(IS_COMPUTE_SYNTAX + ".expression=~"" + of_ConvertExpression(ls_ProExp) + "~"")
if ls_Error = "" then
	if ab_ShowMsg then MessageBox("DataWindow", "Expression is OK.", Exclamation!)
	Return true
else
	MessageBox("DataWindow", "Expression is not valid.", StopSign!)
	Return false
end if  
//---------End Modfiied ------------------------------------------------------------------

end function

public function string of_convertexpression (string as_expression);integer li_Pos
integer li_Len
string  ls_Return
string  ls_Char

//"'TEST' ~"IS~" A TEST"
//~"'TEST' ~~~"IS~~~" A TEST~"

li_Len = LenA(as_Expression)

for li_Pos = 1 to li_Len
	ls_Char = MidA(as_Expression, li_Pos, 1)
	if ls_Char = '"' then
		ls_Return += '~~"'
	elseif ls_Char = '~~' then
		ls_Return += '~~~~'
	else
		ls_Return += ls_Char
	end if
next

Return ls_Return
end function

on w_compute_wizard.create
this.cb_6=create cb_6
this.cb_5=create cb_5
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.lb_columns=create lb_columns
this.lb_functions=create lb_functions
this.st_3=create st_3
this.st_2=create st_2
this.cb_verify=create cb_verify
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.st_1=create st_1
this.mle_express=create mle_express
this.Control[]={this.cb_6,&
this.cb_5,&
this.cb_3,&
this.cb_4,&
this.cb_2,&
this.cb_1,&
this.lb_columns,&
this.lb_functions,&
this.st_3,&
this.st_2,&
this.cb_verify,&
this.cb_cancel,&
this.cb_ok,&
this.st_1,&
this.mle_express}
end on

on w_compute_wizard.destroy
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.lb_columns)
destroy(this.lb_functions)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_verify)
destroy(this.cb_cancel)
destroy(this.cb_ok)
destroy(this.st_1)
destroy(this.mle_express)
end on

event open;//this.Resize(2395, 1184)

idw_data = Message.PowerObjectParm
mle_express.Text = idw_data.tag

this.Event ue_AddColumns()
end event

event close;CloseWithReturn(this, is_Return)
end event

type cb_6 from commandbutton within w_compute_wizard
integer x = 178
integer y = 1060
integer width = 96
integer height = 92
integer taborder = 100
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = ")"
end type

event clicked;mle_express.ReplaceText(" ) ")
mle_express.SetFocus()
end event

type cb_5 from commandbutton within w_compute_wizard
integer x = 41
integer y = 1060
integer width = 96
integer height = 92
integer taborder = 90
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "("
end type

event clicked;mle_express.ReplaceText(" ( ")
mle_express.SetFocus()
end event

type cb_3 from commandbutton within w_compute_wizard
integer x = 41
integer y = 884
integer width = 96
integer height = 92
integer taborder = 70
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "*"
end type

event clicked;mle_express.ReplaceText(" * ")
mle_express.SetFocus()
end event

type cb_4 from commandbutton within w_compute_wizard
integer x = 178
integer y = 884
integer width = 96
integer height = 92
integer taborder = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "/"
end type

event clicked;mle_express.ReplaceText(" / ")
mle_express.SetFocus()
end event

type cb_2 from commandbutton within w_compute_wizard
integer x = 178
integer y = 712
integer width = 96
integer height = 92
integer taborder = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "-"
end type

event clicked;mle_express.ReplaceText(" - ")
mle_express.SetFocus()
end event

type cb_1 from commandbutton within w_compute_wizard
integer x = 41
integer y = 712
integer width = 96
integer height = 92
integer taborder = 50
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "+"
end type

event clicked;mle_express.ReplaceText(" + ")
mle_express.SetFocus()
end event

type lb_columns from listbox within w_compute_wizard
event ue_lbuttonup pbm_lbuttonup
integer x = 1051
integer y = 704
integer width = 1303
integer height = 444
integer taborder = 120
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
string item[] = {"colum_1","colum_2","colum_3"}
borderstyle borderstyle = stylelowered!
end type

event ue_lbuttonup;Post Event ue_ReplaceText(2)
end event

event selectionchanged;ii_CurrColumn = Index
end event

type lb_functions from listbox within w_compute_wizard
event ue_lbuttonup pbm_lbuttonup
integer x = 343
integer y = 708
integer width = 617
integer height = 444
integer taborder = 110
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

type st_3 from statictext within w_compute_wizard
integer x = 343
integer y = 628
integer width = 302
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Functions:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_compute_wizard
integer x = 1051
integer y = 628
integer width = 279
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Columns:"
boolean focusrectangle = false
end type

type cb_verify from commandbutton within w_compute_wizard
integer x = 2075
integer y = 312
integer width = 265
integer height = 92
integer taborder = 40
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Verify"
end type

event clicked;of_Verify(true)
end event

type cb_cancel from commandbutton within w_compute_wizard
integer x = 2075
integer y = 184
integer width = 265
integer height = 92
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_ok from commandbutton within w_compute_wizard
integer x = 2075
integer y = 56
integer width = 265
integer height = 92
integer taborder = 20
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;if of_Verify(false) then
	is_Return = mle_express.Text
	if IsNull(is_Return) or Trim(is_Return) = "" then
		is_Return = ""
	end if
	Close(Parent)
end if
end event

type st_1 from statictext within w_compute_wizard
integer x = 50
integer y = 40
integer width = 338
integer height = 72
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "&Expression:"
boolean focusrectangle = false
end type

type mle_express from multilineedit within w_compute_wizard
integer x = 50
integer y = 144
integer width = 1975
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
borderstyle borderstyle = stylelowered!
end type

