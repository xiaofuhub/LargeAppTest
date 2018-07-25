$PBExportHeader$w_data_clean_utl.srw
forward
global type w_data_clean_utl from window
end type
type cbx_1 from checkbox within w_data_clean_utl
end type
type dw_prac from datawindow within w_data_clean_utl
end type
type dw_temp from datawindow within w_data_clean_utl
end type
type st_7 from statictext within w_data_clean_utl
end type
type sle_1 from singlelineedit within w_data_clean_utl
end type
type st_warn from statictext within w_data_clean_utl
end type
type cb_find from commandbutton within w_data_clean_utl
end type
type cb_6 from commandbutton within w_data_clean_utl
end type
type cb_syn10 from commandbutton within w_data_clean_utl
end type
type cb_syn9 from commandbutton within w_data_clean_utl
end type
type cb_syn8 from commandbutton within w_data_clean_utl
end type
type cb_syn7 from commandbutton within w_data_clean_utl
end type
type cb_syn6 from commandbutton within w_data_clean_utl
end type
type st_2 from statictext within w_data_clean_utl
end type
type st_3 from statictext within w_data_clean_utl
end type
type dw_affil from datawindow within w_data_clean_utl
end type
type st_4 from statictext within w_data_clean_utl
end type
type cb_5 from commandbutton within w_data_clean_utl
end type
type cb_syn5 from commandbutton within w_data_clean_utl
end type
type cb_syn4 from commandbutton within w_data_clean_utl
end type
type cb_syn3 from commandbutton within w_data_clean_utl
end type
type cb_syn2 from commandbutton within w_data_clean_utl
end type
type cb_syn1 from commandbutton within w_data_clean_utl
end type
type cb_4 from commandbutton within w_data_clean_utl
end type
type st_1 from statictext within w_data_clean_utl
end type
type dw_1 from datawindow within w_data_clean_utl
end type
type cb_3 from commandbutton within w_data_clean_utl
end type
type cb_2 from commandbutton within w_data_clean_utl
end type
type mle_1 from multilineedit within w_data_clean_utl
end type
type cb_1 from commandbutton within w_data_clean_utl
end type
type gb_1 from groupbox within w_data_clean_utl
end type
type cb_7 from commandbutton within w_data_clean_utl
end type
end forward

global type w_data_clean_utl from window
integer x = 14
integer y = 4
integer width = 3538
integer height = 2212
boolean titlebar = true
string title = "Data Clean Utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79680469
cbx_1 cbx_1
dw_prac dw_prac
dw_temp dw_temp
st_7 st_7
sle_1 sle_1
st_warn st_warn
cb_find cb_find
cb_6 cb_6
cb_syn10 cb_syn10
cb_syn9 cb_syn9
cb_syn8 cb_syn8
cb_syn7 cb_syn7
cb_syn6 cb_syn6
st_2 st_2
st_3 st_3
dw_affil dw_affil
st_4 st_4
cb_5 cb_5
cb_syn5 cb_syn5
cb_syn4 cb_syn4
cb_syn3 cb_syn3
cb_syn2 cb_syn2
cb_syn1 cb_syn1
cb_4 cb_4
st_1 st_1
dw_1 dw_1
cb_3 cb_3
cb_2 cb_2
mle_1 mle_1
cb_1 cb_1
gb_1 gb_1
cb_7 cb_7
end type
global w_data_clean_utl w_data_clean_utl

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

on w_data_clean_utl.create
this.cbx_1=create cbx_1
this.dw_prac=create dw_prac
this.dw_temp=create dw_temp
this.st_7=create st_7
this.sle_1=create sle_1
this.st_warn=create st_warn
this.cb_find=create cb_find
this.cb_6=create cb_6
this.cb_syn10=create cb_syn10
this.cb_syn9=create cb_syn9
this.cb_syn8=create cb_syn8
this.cb_syn7=create cb_syn7
this.cb_syn6=create cb_syn6
this.st_2=create st_2
this.st_3=create st_3
this.dw_affil=create dw_affil
this.st_4=create st_4
this.cb_5=create cb_5
this.cb_syn5=create cb_syn5
this.cb_syn4=create cb_syn4
this.cb_syn3=create cb_syn3
this.cb_syn2=create cb_syn2
this.cb_syn1=create cb_syn1
this.cb_4=create cb_4
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.mle_1=create mle_1
this.cb_1=create cb_1
this.gb_1=create gb_1
this.cb_7=create cb_7
this.Control[]={this.cbx_1,&
this.dw_prac,&
this.dw_temp,&
this.st_7,&
this.sle_1,&
this.st_warn,&
this.cb_find,&
this.cb_6,&
this.cb_syn10,&
this.cb_syn9,&
this.cb_syn8,&
this.cb_syn7,&
this.cb_syn6,&
this.st_2,&
this.st_3,&
this.dw_affil,&
this.st_4,&
this.cb_5,&
this.cb_syn5,&
this.cb_syn4,&
this.cb_syn3,&
this.cb_syn2,&
this.cb_syn1,&
this.cb_4,&
this.st_1,&
this.dw_1,&
this.cb_3,&
this.cb_2,&
this.mle_1,&
this.cb_1,&
this.gb_1,&
this.cb_7}
end on

on w_data_clean_utl.destroy
destroy(this.cbx_1)
destroy(this.dw_prac)
destroy(this.dw_temp)
destroy(this.st_7)
destroy(this.sle_1)
destroy(this.st_warn)
destroy(this.cb_find)
destroy(this.cb_6)
destroy(this.cb_syn10)
destroy(this.cb_syn9)
destroy(this.cb_syn8)
destroy(this.cb_syn7)
destroy(this.cb_syn6)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.dw_affil)
destroy(this.st_4)
destroy(this.cb_5)
destroy(this.cb_syn5)
destroy(this.cb_syn4)
destroy(this.cb_syn3)
destroy(this.cb_syn2)
destroy(this.cb_syn1)
destroy(this.cb_4)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.mle_1)
destroy(this.cb_1)
destroy(this.gb_1)
destroy(this.cb_7)
end on

event open;SQLCA.DBMS="ODBC"
SQLCA.DbParm="ConnectString='DSN=IntelliCred Client;UID=DBA;PWD=SQL;',DelimitIdentifier='Yes'"

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2007-09-14 By: Scofield
//$<Reason> Set the connection cache dynamically on Web
if AppeonGetClientType() = 'WEB' then
	SQLCA.DBMS = gs_CacheType
	SQLCA.DBParm = gs_CacheSet
end if
//---------------------------- APPEON END ----------------------------

CONNECT USING SQLCA;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Not Logged In", "Login Failed!")
ELSE
	
END IF
//SQLCA.AutoCommit = false
end event

event close;disCONNECT USING SQLCA;
//SQLCA.AutoCommit = True
end event

type cbx_1 from checkbox within w_data_clean_utl
integer x = 2839
integer y = 1908
integer width = 398
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Completed?"
end type

type dw_prac from datawindow within w_data_clean_utl
integer x = 3168
integer y = 1800
integer width = 101
integer height = 68
integer taborder = 50
string dataobject = "d_pd_app_audit_utl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_temp from datawindow within w_data_clean_utl
integer x = 2821
integer y = 1804
integer width = 82
integer height = 60
integer taborder = 40
string dataobject = "d_app_audit_temps_utl"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_7 from statictext within w_data_clean_utl
integer x = 1445
integer y = 224
integer width = 306
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
string text = "Clean field "
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_data_clean_utl
integer x = 1760
integer y = 208
integer width = 727
integer height = 92
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_warn from statictext within w_data_clean_utl
integer x = 1202
integer y = 312
integer width = 2235
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Warning: This function will crash if run on fields that are not Char datatype."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_find from commandbutton within w_data_clean_utl
integer x = 2514
integer y = 204
integer width = 443
integer height = 88
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Remove chars"
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
string fld
integer vc = 0
long lla_recs[]
integer i
long rc
long r


string ls_value = ""
string s
string val
integer il

rc = dw_1.rowcount()
fld = sle_1.text
for r = 1 to 5
	ls_value = ""
  	val = dw_1.getitemstring(r,fld)
	//messagebox("",val)
	il = LenA(val)
	for i = 1 to il
		s = MidA(val,i,1)
		if isnumber(s) then
			ls_value  = ls_value + s
		end if
	next
	dw_1.setitem(r,fld,ls_value)
next

dw_1.update()
commit using sqlca;

messagebox("Done","Update complete")
end event

type cb_6 from commandbutton within w_data_clean_utl
integer x = 1353
integer y = 1776
integer width = 247
integer height = 88
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;string null_str

SetNull(null_str)
dw_1.SetFilter(null_str)
dw_1.Filter()
end event

type cb_syn10 from commandbutton within w_data_clean_utl
integer x = 1175
integer y = 100
integer width = 119
integer height = 68
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "10"
end type

event clicked;of_get_syn(10)
end event

type cb_syn9 from commandbutton within w_data_clean_utl
integer x = 1056
integer y = 100
integer width = 96
integer height = 68
integer taborder = 200
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "9"
end type

event clicked;of_get_syn(9)
end event

type cb_syn8 from commandbutton within w_data_clean_utl
integer x = 937
integer y = 100
integer width = 96
integer height = 68
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "8"
end type

event clicked;of_get_syn(8)
end event

type cb_syn7 from commandbutton within w_data_clean_utl
integer x = 818
integer y = 100
integer width = 96
integer height = 68
integer taborder = 210
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "7"
end type

event clicked;of_get_syn(7)
end event

type cb_syn6 from commandbutton within w_data_clean_utl
integer x = 699
integer y = 100
integer width = 96
integer height = 68
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "6"
end type

event clicked;of_get_syn(6)
end event

type st_2 from statictext within w_data_clean_utl
integer x = 2670
integer y = 1992
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

type st_3 from statictext within w_data_clean_utl
integer x = 3109
integer y = 1992
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

type dw_affil from datawindow within w_data_clean_utl
integer x = 2953
integer y = 1800
integer width = 119
integer height = 76
integer taborder = 70
string dataobject = "d_affil_stat_of_prac_all"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type st_4 from statictext within w_data_clean_utl
integer x = 507
integer y = 1772
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

type cb_5 from commandbutton within w_data_clean_utl
integer x = 1061
integer y = 1776
integer width = 247
integer height = 88
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Export"
end type

event clicked;//
//if rb_dw1.checked = true then 
	gnv_dw.of_SaveAs(dw_1)//.saveas() Modify by Evan 05.11.2010
//elseif rb_dw2.checked = true then 
//	dw_2.saveas()
//end if
	//restore Directory  
//added by nova 2008-04-29
ChangeDirectory(gs_current_path)
	
	
	
	
	
	
end event

type cb_syn5 from commandbutton within w_data_clean_utl
integer x = 581
integer y = 100
integer width = 96
integer height = 68
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "5"
end type

event clicked;of_get_syn(5)
end event

type cb_syn4 from commandbutton within w_data_clean_utl
integer x = 462
integer y = 100
integer width = 96
integer height = 68
integer taborder = 190
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "4"
end type

event clicked;of_get_syn(4)
end event

type cb_syn3 from commandbutton within w_data_clean_utl
integer x = 343
integer y = 100
integer width = 96
integer height = 68
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "3"
end type

event clicked;of_get_syn(3)
end event

type cb_syn2 from commandbutton within w_data_clean_utl
integer x = 224
integer y = 100
integer width = 96
integer height = 68
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "2"
end type

event clicked;of_get_syn(2)
end event

type cb_syn1 from commandbutton within w_data_clean_utl
integer x = 105
integer y = 100
integer width = 96
integer height = 68
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "1"
end type

event clicked;of_get_syn(1)
end event

type cb_4 from commandbutton within w_data_clean_utl
integer x = 782
integer y = 1776
integer width = 247
integer height = 88
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;
//if rb_dw1.checked = true then 
	dw_1.update()
//elseif rb_dw1.checked = true then 
//	dw_2.update()
//end if
commit using sqlca;

end event

type st_1 from statictext within w_data_clean_utl
integer x = 73
integer y = 1776
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

type dw_1 from datawindow within w_data_clean_utl
integer x = 41
integer y = 936
integer width = 3401
integer height = 820
integer taborder = 60
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_3 from commandbutton within w_data_clean_utl
integer x = 379
integer y = 268
integer width = 247
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear"
end type

event clicked;mle_1.text = ""
dw_1.reset()

end event

type cb_2 from commandbutton within w_data_clean_utl
integer x = 3163
integer y = 40
integer width = 247
integer height = 108
integer taborder = 100
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

type mle_1 from multilineedit within w_data_clean_utl
integer x = 50
integer y = 400
integer width = 3383
integer height = 516
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_data_clean_utl
integer x = 73
integer y = 268
integer width = 274
integer height = 108
integer taborder = 230
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Execute"
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
	
	//if rb_dw1.checked = true then 
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

else
	execute immediate :ls_sql using sqlca;
	
end if

of_syn()

end event

type gb_1 from groupbox within w_data_clean_utl
integer x = 55
integer y = 32
integer width = 1280
integer height = 168
integer taborder = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Last Ten Statements"
end type

type cb_7 from commandbutton within w_data_clean_utl
integer x = 2752
integer y = 1784
integer width = 581
integer height = 108
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Add App Audit Data"
end type

event clicked;long a
long ac
long t
long tc
long p
long pc
integer facil
long prac
long recid
long aaid
long nr
long prac_aaid
string descr
long pcnt
long acnt
integer res
long ll_sat
 
if cbx_1.checked then
	select lookup_code into :ll_sat from code_lookup where lookup_name = 'Required Data Status' and code = 'SATISFACTORY';
	IF ll_sat < 1 then
		messagebox("Problem","Cannot find 'SATISFACTORY' value for completing app audit items.  Will not be able to complete.")
		return
	end if
end if

dw_affil.settransobject(sqlca)
dw_temp.settransobject(sqlca)
dw_prac.settransobject(sqlca)

dw_temp.retrieve()
ac = dw_affil.retrieve()

for a = 1 to ac
	prac = dw_affil.getitemnumber(a,"prac_id")
	facil = dw_affil.getitemnumber(a,"application_audit_facility")
	recid = dw_affil.getitemnumber(a,"rec_id")
	
	res = dw_temp.setfilter("facility_id = " + string(facil))
	if res < 1 then
		messagebox("","filter error")
		return
	end if
	dw_temp.filter()
	
	tc = dw_temp.rowcount()
	nr = dw_prac.retrieve(recid)
	if nr = 0 then //only if there are no items create the list
	//messagebox("prac",prac)
		for t = 1 to tc //for each template item create prac item
			aaid = dw_temp.getitemnumber(t,"app_audit_id")
			descr = dw_temp.getitemstring(t,"description")
			
			nr = dw_prac.insertrow(0)
			dw_prac.setitem(nr,"appt_stat_id",recid)
			dw_prac.setitem(nr,"prac_id",prac)
			dw_prac.setitem(nr,"facility_id",facil)
			dw_prac.setitem(nr,"active_status",1)
			dw_prac.setitem(nr,"app_audit_id",aaid)
			dw_prac.setitem(nr,"fax_message",descr)
			dw_prac.setitem(nr,"seq_no",1)
			dw_prac.setitem(nr,"completed","N")
		next
		select record_id into :prac_aaid from ids; 
		for p = 1 to tc
			prac_aaid++
			acnt++
			dw_prac.setitem(p,"record_id",prac_aaid)
			if cbx_1.checked then
				dw_prac.setitem(p,"date_completed",today())
				dw_prac.setitem(p,"data_status",ll_sat)
			end if
		next
		update ids set record_id = :prac_aaid;
		commit using sqlca;
		dw_prac.update()
		commit using sqlca;
		pcnt++
		st_2.text = string(pcnt)	
		st_3.text = string(acnt)
	end if
	
next

messagebox("done","process completed")

end event

