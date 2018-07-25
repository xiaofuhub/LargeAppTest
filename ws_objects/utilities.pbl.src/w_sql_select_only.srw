$PBExportHeader$w_sql_select_only.srw
forward
global type w_sql_select_only from w_main
end type
type cb_7 from commandbutton within w_sql_select_only
end type
type cb_4 from commandbutton within w_sql_select_only
end type
type cb_sort from commandbutton within w_sql_select_only
end type
type cb_6 from commandbutton within w_sql_select_only
end type
type cb_syn10 from commandbutton within w_sql_select_only
end type
type cb_syn9 from commandbutton within w_sql_select_only
end type
type cb_syn8 from commandbutton within w_sql_select_only
end type
type cb_syn7 from commandbutton within w_sql_select_only
end type
type cb_syn6 from commandbutton within w_sql_select_only
end type
type st_4 from statictext within w_sql_select_only
end type
type cb_5 from commandbutton within w_sql_select_only
end type
type cb_syn5 from commandbutton within w_sql_select_only
end type
type cb_syn4 from commandbutton within w_sql_select_only
end type
type cb_syn3 from commandbutton within w_sql_select_only
end type
type cb_syn2 from commandbutton within w_sql_select_only
end type
type cb_syn1 from commandbutton within w_sql_select_only
end type
type st_1 from statictext within w_sql_select_only
end type
type dw_1 from u_dw within w_sql_select_only
end type
type cb_3 from commandbutton within w_sql_select_only
end type
type cb_2 from commandbutton within w_sql_select_only
end type
type mle_1 from multilineedit within w_sql_select_only
end type
type cb_1 from commandbutton within w_sql_select_only
end type
type gb_1 from groupbox within w_sql_select_only
end type
end forward

global type w_sql_select_only from w_main
integer x = 14
integer y = 4
integer width = 3561
integer height = 2448
string title = "SQL Query"
long backcolor = 33551856
cb_7 cb_7
cb_4 cb_4
cb_sort cb_sort
cb_6 cb_6
cb_syn10 cb_syn10
cb_syn9 cb_syn9
cb_syn8 cb_syn8
cb_syn7 cb_syn7
cb_syn6 cb_syn6
st_4 st_4
cb_5 cb_5
cb_syn5 cb_syn5
cb_syn4 cb_syn4
cb_syn3 cb_syn3
cb_syn2 cb_syn2
cb_syn1 cb_syn1
st_1 st_1
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
mle_1 mle_1
cb_1 cb_1
gb_1 gb_1
end type
global w_sql_select_only w_sql_select_only

type variables
string is_syn1
string is_syn2
string is_syn3
string is_syn4
string is_syn5
string is_syn6
string is_syn7
string is_syn8
string is_syn9
string is_syn10

integer ii_next = 1
end variables

forward prototypes
public function integer of_syn ()
public function integer of_get_syn (integer ai_button)
public function boolean of_find_keyword (string as_string, string as_keyword)
end prototypes

public function integer of_syn ();is_syn10 = is_syn9
is_syn9 = is_syn8
is_syn8 = is_syn7
is_syn7 = is_syn6
is_syn6 = is_syn5
is_syn5 = is_syn4
is_syn4 = is_syn3
is_syn3 = is_syn2
is_syn2 = is_syn1
is_syn1 = mle_1.text

if LenA(is_syn10) > 0 then
	cb_syn10.enabled = true
elseif LenA(is_syn9) > 0 then
	cb_syn9.enabled = true
elseif LenA(is_syn8) > 0 then
	cb_syn8.enabled = true
elseif LenA(is_syn7) > 0 then
	cb_syn7.enabled = true	
elseif LenA(is_syn6) > 0 then
	cb_syn6.enabled = true
elseif LenA(is_syn5) > 0 then
	cb_syn5.enabled = true
elseif LenA(is_syn4) > 0 then
	cb_syn4.enabled = true
elseif LenA(is_syn3) > 0 then
	cb_syn3.enabled = true
elseif LenA(is_syn2) > 0 then
	cb_syn2.enabled = true
elseif LenA(is_syn1) > 0 then
	cb_syn1.enabled = true
end if






return 1
end function

public function integer of_get_syn (integer ai_button);choose case ai_button
	case 1
		mle_1.text = is_syn1
	case 2
		mle_1.text = is_syn2
	case 3
		mle_1.text = is_syn3
	case 4
		mle_1.text = is_syn4
	case 5
		mle_1.text = is_syn5
	case 6
		mle_1.text = is_syn6
	case 7
		mle_1.text = is_syn7
	case 8
		mle_1.text = is_syn8
	case 9
		mle_1.text = is_syn9
	case 10
		mle_1.text = is_syn10
end choose

return 1
end function

public function boolean of_find_keyword (string as_string, string as_keyword);//====================================================================
//$<Function>: of_find_keyword
//$<Arguments>:
// 	value    string    as_string
// 	value    string    as_keyword
//$<Return>:  boolean
//$<Description>: Find the keyword in the sql
//$<Author>: (Appeon) long.zhang 06.29.2015
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Boolean lb_find = false
Long ll_pos

as_string = Trim(Upper(as_string))
as_keyword = Trim(Upper(as_keyword))

ll_pos = PosA(as_string,as_keyword)
Do while (ll_pos > 0 and Not lb_find)
	//Continue when the Character before it or after it is a visible Character
	If (AscA(MidA(as_string,ll_pos - 1, 1)) > 32) or (AscA(MidA(as_string,ll_pos + LenA(as_keyword), 1)) > 32) Then
		as_string = MidA(as_string,ll_pos + LenA(as_keyword)) 
		ll_pos = PosA(as_string,as_keyword)
		lb_find = False
	Else
		lb_find = True
	End If
Loop

Return lb_find
end function

on w_sql_select_only.create
int iCurrent
call super::create
this.cb_7=create cb_7
this.cb_4=create cb_4
this.cb_sort=create cb_sort
this.cb_6=create cb_6
this.cb_syn10=create cb_syn10
this.cb_syn9=create cb_syn9
this.cb_syn8=create cb_syn8
this.cb_syn7=create cb_syn7
this.cb_syn6=create cb_syn6
this.st_4=create st_4
this.cb_5=create cb_5
this.cb_syn5=create cb_syn5
this.cb_syn4=create cb_syn4
this.cb_syn3=create cb_syn3
this.cb_syn2=create cb_syn2
this.cb_syn1=create cb_syn1
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.mle_1=create mle_1
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_7
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_sort
this.Control[iCurrent+4]=this.cb_6
this.Control[iCurrent+5]=this.cb_syn10
this.Control[iCurrent+6]=this.cb_syn9
this.Control[iCurrent+7]=this.cb_syn8
this.Control[iCurrent+8]=this.cb_syn7
this.Control[iCurrent+9]=this.cb_syn6
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.cb_5
this.Control[iCurrent+12]=this.cb_syn5
this.Control[iCurrent+13]=this.cb_syn4
this.Control[iCurrent+14]=this.cb_syn3
this.Control[iCurrent+15]=this.cb_syn2
this.Control[iCurrent+16]=this.cb_syn1
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.cb_3
this.Control[iCurrent+20]=this.cb_2
this.Control[iCurrent+21]=this.mle_1
this.Control[iCurrent+22]=this.cb_1
this.Control[iCurrent+23]=this.gb_1
end on

on w_sql_select_only.destroy
call super::destroy
destroy(this.cb_7)
destroy(this.cb_4)
destroy(this.cb_sort)
destroy(this.cb_6)
destroy(this.cb_syn10)
destroy(this.cb_syn9)
destroy(this.cb_syn8)
destroy(this.cb_syn7)
destroy(this.cb_syn6)
destroy(this.st_4)
destroy(this.cb_5)
destroy(this.cb_syn5)
destroy(this.cb_syn4)
destroy(this.cb_syn3)
destroy(this.cb_syn2)
destroy(this.cb_syn1)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.cb_1)
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
SQLCA.AutoCommit = false


//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 02.06.2016
//<$>reason:Resize
this.of_SetResize(TRUE)
inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
inv_resize.of_setminsize( this.workspacewidth(),this.workspaceheight())

inv_resize.of_Register(mle_1, inv_resize.SCALERIGHT)
inv_resize.of_Register(dw_1, inv_resize.SCALERIGHTBOTTOM)
//------------------- APPEON END -------------------
end event

event close;//disCONNECT USING SQLCA;
SQLCA.AutoCommit = True
end event

type cb_7 from commandbutton within w_sql_select_only
integer x = 302
integer y = 644
integer width = 306
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "S&ave Query"
end type

event clicked;string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
//u_dw ldw_export_data

ls_sql = mle_1.text

if LenA(ls_sql) < 10 then 
	return
else
	openwithparm(w_sql_query_select,"N@" + ls_sql)
end if





end event

type cb_4 from commandbutton within w_sql_select_only
integer x = 617
integer y = 644
integer width = 343
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &Query"
end type

event clicked;string ls_sql

openwithparm(w_sql_query_select, "U")

ls_sql = message.stringparm

if ls_sql = "Cancel" then
	return
else
	mle_1.text = ls_sql
end if

end event

type cb_sort from commandbutton within w_sql_select_only
integer x = 1495
integer y = 644
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Sort"
end type

event clicked;string null_str

SetNull(null_str)
dw_1.Setsort(null_str)
dw_1.sort()
end event

type cb_6 from commandbutton within w_sql_select_only
integer x = 1234
integer y = 644
integer width = 247
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string null_str

SetNull(null_str)
dw_1.SetFilter(null_str)
dw_1.Filter()

st_1.text = string(dw_1.rowcount())
end event

type cb_syn10 from commandbutton within w_sql_select_only
integer x = 1175
integer y = 68
integer width = 119
integer height = 84
integer taborder = 190
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "10"
end type

event clicked;of_get_syn(10)
end event

type cb_syn9 from commandbutton within w_sql_select_only
integer x = 1056
integer y = 68
integer width = 96
integer height = 84
integer taborder = 180
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "9"
end type

event clicked;of_get_syn(9)
end event

type cb_syn8 from commandbutton within w_sql_select_only
integer x = 937
integer y = 68
integer width = 96
integer height = 84
integer taborder = 170
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "8"
end type

event clicked;of_get_syn(8)
end event

type cb_syn7 from commandbutton within w_sql_select_only
integer x = 818
integer y = 68
integer width = 96
integer height = 84
integer taborder = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "7"
end type

event clicked;of_get_syn(7)
end event

type cb_syn6 from commandbutton within w_sql_select_only
integer x = 699
integer y = 68
integer width = 96
integer height = 84
integer taborder = 150
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "6"
end type

event clicked;of_get_syn(6)
end event

type st_4 from statictext within w_sql_select_only
integer x = 3205
integer y = 664
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Records"
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_sql_select_only
integer x = 1755
integer y = 644
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Export"
end type

event clicked;
//if rb_dw1.checked = true then 
gnv_dw.of_SaveAs(dw_1)//.SaveAs() Modify by Evan 05.11.2010
//elseif rb_dw2.checked = true then 
//	dw_2.saveas()
//end if

ChangeDirectory(gs_current_path)//restore currentdirectory-Added by Nova 04.29.2008







end event

type cb_syn5 from commandbutton within w_sql_select_only
integer x = 581
integer y = 68
integer width = 96
integer height = 84
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "5"
end type

event clicked;of_get_syn(5)
end event

type cb_syn4 from commandbutton within w_sql_select_only
integer x = 462
integer y = 68
integer width = 96
integer height = 84
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "4"
end type

event clicked;of_get_syn(4)
end event

type cb_syn3 from commandbutton within w_sql_select_only
integer x = 343
integer y = 68
integer width = 96
integer height = 84
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "3"
end type

event clicked;of_get_syn(3)
end event

type cb_syn2 from commandbutton within w_sql_select_only
integer x = 224
integer y = 68
integer width = 96
integer height = 84
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "2"
end type

event clicked;of_get_syn(2)
end event

type cb_syn1 from commandbutton within w_sql_select_only
integer x = 105
integer y = 68
integer width = 96
integer height = 84
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "1"
end type

event clicked;of_get_syn(1)
end event

type st_1 from statictext within w_sql_select_only
integer x = 2181
integer y = 668
integer width = 997
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_sql_select_only
integer x = 14
integer y = 744
integer width = 3506
integer height = 1596
integer taborder = 90
boolean hscrollbar = true
end type

type cb_3 from commandbutton within w_sql_select_only
integer x = 974
integer y = 644
integer width = 247
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "C&lear"
end type

event clicked;mle_1.text = ""
dw_1.reset()

end event

type cb_2 from commandbutton within w_sql_select_only
integer x = 3195
integer y = 64
integer width = 247
integer height = 84
integer taborder = 200
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type mle_1 from multilineedit within w_sql_select_only
integer x = 9
integer y = 188
integer width = 3502
integer height = 440
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_sql_select_only
integer x = 18
integer y = 644
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Run"
end type

event clicked;string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
//u_dw ldw_export_data

ls_sql = mle_1.text

//Start Code Change ----06.29.2015 #V15 maha - added separate check function
if of_check_is_select(ls_sql) < 0 then return

ls_presentation_str = "style(type=grid)" 
ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
	if PosA(ERRORS,"Table or view not found",1) > 0 then
		messagebox ("syntax error","Table in query not found." )
		return -1
	else
		MessageBox("Caution", &
		"SyntaxFromSQL caused these errors: " + ERRORS)
		RETURN -1
	end if
END IF
	
dw_1.Create( ls_dwsyntax_str, ERRORS)
dw_1.SetTransObject( SQLCA )	
cnt = dw_1.retrieve()
st_1.text = string(cnt)
//End Code Change ----06.29.2015


//if PosA(upper(trim(ls_sql)),"SELECT",1) = 1 AND ( Not of_find_keyword(ls_sql,'update'))  then	//Added of_find_keyword to avoid 'UPDATE' keyword by Appeon long.zhang 06.29.2015 (Bug # 4575 - Security issue when using SQL Selects)	
//	//CREATE SYNTAX FOR export DW
//	ls_presentation_str = "style(type=grid)" 
//	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
//	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
//		if PosA(ERRORS,"Table or view not found",1) > 0 then
//			messagebox ("syntax error","Table not found (should have  prefix)" )
//			return -1
//		else
//			MessageBox("Caution", &
//			"SyntaxFromSQL caused these errors: " + ERRORS)
//			RETURN -1
//		end if
//	END IF
//	
//	//if rb_dw1.checked = true then 
//		dw_1.Create( ls_dwsyntax_str, ERRORS)
//		dw_1.SetTransObject( SQLCA )	
//		cnt = dw_1.retrieve()
//		st_1.text = string(cnt)
////	elseif rb_dw2.checked = true then 
////		dw_2.Create( ls_dwsyntax_str, ERRORS)
////		dw_2.SetTransObject( SQLCA )
////		cnt = dw_2.retrieve()
////		st_2.text = string(cnt)
////	end if
////		cb_commit.enabled = false
////		cb_roll.enabled = false
//else
//	messagebox("Retrieve only","This function can only be used select statements.")
////	execute immediate :ls_sql using sqlca;
////	cb_commit.enabled = true
////	cb_roll.enabled = true
//end if

of_syn()

end event

type gb_1 from groupbox within w_sql_select_only
integer x = 64
integer y = 8
integer width = 1271
integer height = 168
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Last Ten Statements"
end type

