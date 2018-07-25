$PBExportHeader$w_view_update_utility.srw
forward
global type w_view_update_utility from window
end type
type st_5 from statictext within w_view_update_utility
end type
type st_4 from statictext within w_view_update_utility
end type
type cb_6 from commandbutton within w_view_update_utility
end type
type cb_5 from commandbutton within w_view_update_utility
end type
type st_before from statictext within w_view_update_utility
end type
type st_2 from statictext within w_view_update_utility
end type
type st_3 from statictext within w_view_update_utility
end type
type dw_2 from datawindow within w_view_update_utility
end type
type st_after from statictext within w_view_update_utility
end type
type cb_roll from commandbutton within w_view_update_utility
end type
type cb_commit from commandbutton within w_view_update_utility
end type
type cb_4 from commandbutton within w_view_update_utility
end type
type st_1 from statictext within w_view_update_utility
end type
type dw_1 from datawindow within w_view_update_utility
end type
type cb_3 from commandbutton within w_view_update_utility
end type
type cb_2 from commandbutton within w_view_update_utility
end type
type mle_1 from multilineedit within w_view_update_utility
end type
type cb_1 from commandbutton within w_view_update_utility
end type
end forward

global type w_view_update_utility from window
integer x = 46
integer y = 48
integer width = 3461
integer height = 1140
boolean titlebar = true
string title = "Update View"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
st_5 st_5
st_4 st_4
cb_6 cb_6
cb_5 cb_5
st_before st_before
st_2 st_2
st_3 st_3
dw_2 dw_2
st_after st_after
cb_roll cb_roll
cb_commit cb_commit
cb_4 cb_4
st_1 st_1
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
mle_1 mle_1
cb_1 cb_1
end type
global w_view_update_utility w_view_update_utility

type variables
string is_syn1
string is_syn2
string is_syn3
string is_syn4
string is_syn5

integer ii_next = 1
end variables

on w_view_update_utility.create
this.st_5=create st_5
this.st_4=create st_4
this.cb_6=create cb_6
this.cb_5=create cb_5
this.st_before=create st_before
this.st_2=create st_2
this.st_3=create st_3
this.dw_2=create dw_2
this.st_after=create st_after
this.cb_roll=create cb_roll
this.cb_commit=create cb_commit
this.cb_4=create cb_4
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.mle_1=create mle_1
this.cb_1=create cb_1
this.Control[]={this.st_5,&
this.st_4,&
this.cb_6,&
this.cb_5,&
this.st_before,&
this.st_2,&
this.st_3,&
this.dw_2,&
this.st_after,&
this.cb_roll,&
this.cb_commit,&
this.cb_4,&
this.st_1,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.mle_1,&
this.cb_1}
end on

on w_view_update_utility.destroy
destroy(this.st_5)
destroy(this.st_4)
destroy(this.cb_6)
destroy(this.cb_5)
destroy(this.st_before)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_2)
destroy(this.st_after)
destroy(this.cb_roll)
destroy(this.cb_commit)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.cb_1)
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
//SQLCA.AutoCommit = false

dw_1.settransobject(sqlca)
dw_1.retrieve()
dw_1.insertrow(1)

dw_2.settransobject(sqlca)
end event

event close;//disCONNECT USING SQLCA;
//SQLCA.AutoCommit = True
end event

type st_5 from statictext within w_view_update_utility
integer x = 2706
integer y = 872
integer width = 672
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "7) Click Execute again."
boolean focusrectangle = false
end type

type st_4 from statictext within w_view_update_utility
integer x = 439
integer y = 152
integer width = 1371
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "2) Paste view sql into window (it should include a drop)."
boolean focusrectangle = false
end type

type cb_6 from commandbutton within w_view_update_utility
integer x = 3127
integer y = 144
integer width = 247
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("This utility:","Allows you to update a view syntax without losing the tables from the selected tables list in IntelliReport.  Follow the numbers.")
end event

type cb_5 from commandbutton within w_view_update_utility
integer x = 2318
integer y = 860
integer width = 361
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "6) Past sql "
end type

event clicked;mle_1.text = "update conv_view_table set cust_table_name = " + st_after.text + " where cust_table_name = " + st_before.text  + ";"
end event

type st_before from statictext within w_view_update_utility
integer x = 439
integer y = 48
integer width = 923
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "1)  Select view BEFORE updating."
boolean focusrectangle = false
end type

type st_2 from statictext within w_view_update_utility
integer x = 55
integer y = 1536
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_view_update_utility
integer x = 585
integer y = 1452
integer width = 233
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Records"
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_view_update_utility
integer x = 1376
integer y = 868
integer width = 901
integer height = 72
integer taborder = 70
string dataobject = "d_table_names_report_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;st_after.text = data
end event

type st_after from statictext within w_view_update_utility
integer x = 558
integer y = 864
integer width = 823
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "5)  Select view AFTER update."
boolean focusrectangle = false
end type

type cb_roll from commandbutton within w_view_update_utility
integer x = 750
integer y = 1352
integer width = 247
integer height = 80
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Rollback"
end type

event clicked;rollback using sqlca;
end event

type cb_commit from commandbutton within w_view_update_utility
integer x = 480
integer y = 1352
integer width = 247
integer height = 80
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Commit"
end type

event clicked;commit using sqlca;
end event

type cb_4 from commandbutton within w_view_update_utility
integer x = 64
integer y = 860
integer width = 462
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "4) Reretrieve views"
end type

event clicked;datawindowchild dwchild
if dw_2.rowcount() < 1 then
	dw_2.retrieve()
	dw_2.insertrow(1)
else //maha 091704
	dw_2.GetChild( "table_name_orig_1", dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	dwchild.insertrow(1)
end if
	
////commit using sqlca;
//cb_commit.enabled = true
//cb_roll.enabled = true
end event

type st_1 from statictext within w_view_update_utility
integer x = 59
integer y = 1356
integer width = 384
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_view_update_utility
integer x = 1376
integer y = 52
integer width = 901
integer height = 76
integer taborder = 60
string dataobject = "d_table_names_report_utl"
boolean border = false
boolean livescroll = true
end type

event itemchanged;st_before.text = data
end event

type cb_3 from commandbutton within w_view_update_utility
integer x = 82
integer y = 40
integer width = 338
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;mle_1.text = ""
end event

type cb_2 from commandbutton within w_view_update_utility
integer x = 3127
integer y = 44
integer width = 247
integer height = 84
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type mle_1 from multilineedit within w_view_update_utility
integer x = 64
integer y = 244
integer width = 3314
integer height = 592
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_view_update_utility
integer x = 78
integer y = 144
integer width = 343
integer height = 84
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "3) Execute"
end type

event clicked;string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
//u_dw ldw_export_data

ls_sql = mle_1.text


if PosA(upper(ls_sql),"SELECT",1) = 1 then
	//CREATE SYNTAX FOR export DW
	ls_presentation_str = "style(type=grid)" 
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
			messagebox ("syntax error","Table not found (should have  prefix)" )
			return -1
		else
			MessageBox("Caution", &
			"SyntaxFromSQL caused these errors: " + ERRORS)
			RETURN -1
		end if
	END IF
	
//	if rb_dw1.checked = true then 
		dw_1.Create( ls_dwsyntax_str, ERRORS)
		dw_1.SetTransObject( SQLCA )
		cnt = dw_1.retrieve()
		st_1.text = string(cnt)
//	elseif rb_dw2.checked = true then 
//		dw_2.Create( ls_dwsyntax_str, ERRORS)
//		dw_2.SetTransObject( SQLCA )
//		cnt = dw_2.retrieve()
//		st_2.text = string(cnt)
//	end if
		cb_commit.enabled = false
		cb_roll.enabled = false
else
	execute immediate :ls_sql using sqlca;
	cb_commit.enabled = true
	cb_roll.enabled = true
end if



end event

