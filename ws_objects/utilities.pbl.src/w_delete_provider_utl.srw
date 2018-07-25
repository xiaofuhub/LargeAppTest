$PBExportHeader$w_delete_provider_utl.srw
forward
global type w_delete_provider_utl from window
end type
type st_11 from statictext within w_delete_provider_utl
end type
type st_10 from statictext within w_delete_provider_utl
end type
type st_9 from statictext within w_delete_provider_utl
end type
type st_4 from statictext within w_delete_provider_utl
end type
type st_8 from statictext within w_delete_provider_utl
end type
type st_7 from statictext within w_delete_provider_utl
end type
type st_5 from statictext within w_delete_provider_utl
end type
type st_cnt from statictext within w_delete_provider_utl
end type
type cb_5 from commandbutton within w_delete_provider_utl
end type
type cb_3 from commandbutton within w_delete_provider_utl
end type
type st_6 from statictext within w_delete_provider_utl
end type
type st_2 from statictext within w_delete_provider_utl
end type
type st_3 from statictext within w_delete_provider_utl
end type
type cb_4 from commandbutton within w_delete_provider_utl
end type
type st_1 from statictext within w_delete_provider_utl
end type
type dw_1 from datawindow within w_delete_provider_utl
end type
type cb_2 from commandbutton within w_delete_provider_utl
end type
type mle_1 from multilineedit within w_delete_provider_utl
end type
type cb_1 from commandbutton within w_delete_provider_utl
end type
end forward

global type w_delete_provider_utl from window
integer x = 14
integer y = 4
integer width = 3570
integer height = 2020
boolean titlebar = true
string title = "SQL Send"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
st_11 st_11
st_10 st_10
st_9 st_9
st_4 st_4
st_8 st_8
st_7 st_7
st_5 st_5
st_cnt st_cnt
cb_5 cb_5
cb_3 cb_3
st_6 st_6
st_2 st_2
st_3 st_3
cb_4 cb_4
st_1 st_1
dw_1 dw_1
cb_2 cb_2
mle_1 mle_1
cb_1 cb_1
end type
global w_delete_provider_utl w_delete_provider_utl

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

integer ii_stop = 0
end variables

forward prototypes
public function integer of_syn ()
public function integer of_get_syn (integer ai_button)
end prototypes

public function integer of_syn ();return 1
end function

public function integer of_get_syn (integer ai_button);

return 1
end function

on w_delete_provider_utl.create
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_4=create st_4
this.st_8=create st_8
this.st_7=create st_7
this.st_5=create st_5
this.st_cnt=create st_cnt
this.cb_5=create cb_5
this.cb_3=create cb_3
this.st_6=create st_6
this.st_2=create st_2
this.st_3=create st_3
this.cb_4=create cb_4
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_2=create cb_2
this.mle_1=create mle_1
this.cb_1=create cb_1
this.Control[]={this.st_11,&
this.st_10,&
this.st_9,&
this.st_4,&
this.st_8,&
this.st_7,&
this.st_5,&
this.st_cnt,&
this.cb_5,&
this.cb_3,&
this.st_6,&
this.st_2,&
this.st_3,&
this.cb_4,&
this.st_1,&
this.dw_1,&
this.cb_2,&
this.mle_1,&
this.cb_1}
end on

on w_delete_provider_utl.destroy
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_4)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_5)
destroy(this.st_cnt)
destroy(this.cb_5)
destroy(this.cb_3)
destroy(this.st_6)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.dw_1)
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
SQLCA.AutoCommit = false
end event

event close;//disCONNECT USING SQLCA;
SQLCA.AutoCommit = True
end event

type st_11 from statictext within w_delete_provider_utl
integer x = 1385
integer y = 272
integer width = 1371
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "No Audit data is created from this utility"
boolean focusrectangle = false
end type

type st_10 from statictext within w_delete_provider_utl
integer x = 78
integer y = 948
integer width = 361
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Retrieved Data"
boolean focusrectangle = false
end type

type st_9 from statictext within w_delete_provider_utl
integer x = 73
integer y = 380
integer width = 361
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "SQL Statement"
boolean focusrectangle = false
end type

type st_4 from statictext within w_delete_provider_utl
integer x = 709
integer y = 48
integer width = 2496
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Sql statement must include prac_id field.  Enter statement in SQL box below, and click button."
boolean focusrectangle = false
end type

type st_8 from statictext within w_delete_provider_utl
boolean visible = false
integer x = 2967
integer y = 1736
integer width = 503
integer height = 96
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "This is to to delete all provider data for a list of facility ids.  "
boolean focusrectangle = false
end type

type st_7 from statictext within w_delete_provider_utl
integer x = 686
integer y = 156
integer width = 2779
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "This is to to delete all data for a list of providers."
boolean focusrectangle = false
end type

type st_5 from statictext within w_delete_provider_utl
integer x = 233
integer y = 1644
integer width = 78
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "of"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_cnt from statictext within w_delete_provider_utl
integer x = 18
integer y = 1644
integer width = 206
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_5 from commandbutton within w_delete_provider_utl
boolean visible = false
integer x = 2885
integer y = 1788
integer width = 617
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "or 2) Delete Affil Data Only"
end type

event clicked;long i
long ic
long prac


ic = dw_1.rowcount()
if  ic < 1 then
	messagebox("","No facilities in list")
	return 1
end if

for i = 1 to ic
	prac = dw_1.getitemnumber(i,"_id")
	of_delete_provider_data(prac)
	st_cnt.text = string(i)
	yield()
	if ii_stop = 1 then exit
next
end event

type cb_3 from commandbutton within w_delete_provider_utl
integer x = 55
integer y = 240
integer width = 617
integer height = 96
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Break"
end type

event clicked;ii_stop = 1
end event

type st_6 from statictext within w_delete_provider_utl
integer x = 3273
integer y = 2164
integer width = 178
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "#2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_delete_provider_utl
integer x = 2670
integer y = 2168
integer width = 384
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "0"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_delete_provider_utl
integer x = 3072
integer y = 2168
integer width = 233
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Records"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_delete_provider_utl
integer x = 55
integer y = 136
integer width = 617
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "2) Delete Provider Data"
end type

event clicked;long i
long ic
long prac
integer res


ic = dw_1.rowcount()
if  ic < 1 then
	messagebox("","No providers in list")
	return 1
else
	res = messagebox("Delete?","Have you backed up your database prior to deleting these practitioners?",question!, yesno!,2)
	if res = 2 then return 1
	res = messagebox("Delete?","Are you sure you wish to delete all selected providers from the database?",question!, yesno!,2)
end if

if res = 1 then
	res = messagebox("Delete?","Are you positive you wish to permanently delete all this provider data from the database?",question!, yesno!,2)
end if

if dw_1.Describe("prac_id.ColType") = "!" then  //Start Code Change ---- 08.21.2007 #V7 maha corrected from <>
	messagebox("Delete","Unable to identify the prac_id field in the retrieved data.  If prac_id is included in the query, you may need to alias it.")
	return 1
end if

for i = 1 to ic
	prac = dw_1.getitemnumber(i,"prac_id")
	st_cnt.text = string(i)
	of_delete_provider_data(prac)
	yield()
	if ii_stop = 1 then exit
next


end event

type st_1 from statictext within w_delete_provider_utl
integer x = 329
integer y = 1644
integer width = 206
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "0"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_delete_provider_utl
integer x = 69
integer y = 1020
integer width = 3342
integer height = 612
integer taborder = 30
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_2 from commandbutton within w_delete_provider_utl
integer x = 3259
integer y = 24
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type mle_1 from multilineedit within w_delete_provider_utl
integer x = 73
integer y = 448
integer width = 3342
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
end type

type cb_1 from commandbutton within w_delete_provider_utl
integer x = 50
integer y = 28
integer width = 617
integer height = 96
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "1) Get List from SQL"
end type

event clicked;string ls_sql
string ls_presentation_str
string ls_dwsyntax_str
string ERRORS
long cnt
//u_dw ldw_export_data

ls_sql = mle_1.text


if PosA(upper(trim(ls_sql)),"SELECT",1) = 1 then
	//CREATE SYNTAX FOR export DW
	ls_presentation_str = "style(type=grid)" 
	ls_dwsyntax_str = SQLCA.SyntaxFromSQL(ls_sql, ls_presentation_str, ERRORS)
	IF LenA(ERRORS) > 0 THEN //this will fail if the table has not been completed
		if PosA(ERRORS,"Table or view not found",1) > 0 then
			messagebox ("syntax error","Table not found. " )
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

else
	return
end if



end event

