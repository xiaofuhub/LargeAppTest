$PBExportHeader$w_program_module_update.srw
forward
global type w_program_module_update from window
end type
type rb_report from radiobutton within w_program_module_update
end type
type rb_iapp from radiobutton within w_program_module_update
end type
type rb_export from radiobutton within w_program_module_update
end type
type st_progress from statictext within w_program_module_update
end type
type st_1 from statictext within w_program_module_update
end type
type sle_1 from singlelineedit within w_program_module_update
end type
type cb_4 from commandbutton within w_program_module_update
end type
type cb_3 from commandbutton within w_program_module_update
end type
type cb_2 from commandbutton within w_program_module_update
end type
type gb_1 from groupbox within w_program_module_update
end type
type r_print_stat_border from rectangle within w_program_module_update
end type
type r_bar from rectangle within w_program_module_update
end type
end forward

global type w_program_module_update from window
integer x = 695
integer y = 736
integer width = 1527
integer height = 1032
boolean titlebar = true
string title = "Reset group ids"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
rb_report rb_report
rb_iapp rb_iapp
rb_export rb_export
st_progress st_progress
st_1 st_1
sle_1 sle_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
gb_1 gb_1
r_print_stat_border r_print_stat_border
r_bar r_bar
end type
global w_program_module_update w_program_module_update

forward prototypes
public function integer modupdate (string ai_type)
end prototypes

public function integer modupdate (string ai_type);integer i


	r_bar.width = 1
//r_print_stat_border
//li_bar_ticks = 100

for i = 1 to 1000
	if mod(1,0) = 0 then
		r_bar.Width = r_bar.Width + 14
	end if
	if i =  50 then
		if ai_type = "EXP" then
			update icred_settings set set_iauto = 1;
		end if
		if ai_type = "APP" then
			update icred_settings set set_iapps = 1;
		end if
		if ai_type = "REP" then
			update icred_settings set set_ireport = 1;
		end if
	end if
next

commit using sqlca;






return 1
end function

on w_program_module_update.create
this.rb_report=create rb_report
this.rb_iapp=create rb_iapp
this.rb_export=create rb_export
this.st_progress=create st_progress
this.st_1=create st_1
this.sle_1=create sle_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.gb_1=create gb_1
this.r_print_stat_border=create r_print_stat_border
this.r_bar=create r_bar
this.Control[]={this.rb_report,&
this.rb_iapp,&
this.rb_export,&
this.st_progress,&
this.st_1,&
this.sle_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.gb_1,&
this.r_print_stat_border,&
this.r_bar}
end on

on w_program_module_update.destroy
destroy(this.rb_report)
destroy(this.rb_iapp)
destroy(this.rb_export)
destroy(this.st_progress)
destroy(this.st_1)
destroy(this.sle_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.r_print_stat_border)
destroy(this.r_bar)
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
	MESSAGEBOX("","LOGIN OK")
END IF



Timer ( 1 ,w_program_module_update )
end event

event close;disCONNECT USING SQLCA;
end event

type rb_report from radiobutton within w_program_module_update
integer x = 1024
integer y = 368
integer width = 375
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "IntelliReport"
end type

type rb_iapp from radiobutton within w_program_module_update
integer x = 485
integer y = 368
integer width = 567
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "IntelliApp Program"
end type

type rb_export from radiobutton within w_program_module_update
integer x = 123
integer y = 364
integer width = 393
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "IntelliExport"
end type

type st_progress from statictext within w_program_module_update
integer x = 87
integer y = 604
integer width = 251
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
string text = "Progress"
boolean focusrectangle = false
end type

type st_1 from statictext within w_program_module_update
integer x = 64
integer y = 40
integer width = 1285
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
string text = "Select Module, enter product code and click OK"
boolean focusrectangle = false
end type

type sle_1 from singlelineedit within w_program_module_update
integer x = 69
integer y = 136
integer width = 1353
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_4 from commandbutton within w_program_module_update
integer x = 2199
integer y = 108
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Print"
end type

event clicked;//if dw_1.rowcount() < 1 then
//	messagebox("","nothing to print")
//	return
//end if
//
//dw_1.print()
end event

type cb_3 from commandbutton within w_program_module_update
integer x = 741
integer y = 516
integer width = 274
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;CLOSE(PARENT)
end event

type cb_2 from commandbutton within w_program_module_update
integer x = 462
integer y = 516
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;integer i
integer ic
integer li_bar_ticks
string s

s = sle_1.text

if LenA(s) < 1 then
	Messagebox("","Please enter Module Key")
end if


if rb_export.checked = true then
	if upper(s) = "E14226" then
		//modupdate("EXP")
	else
		messagebox("Key Error","Incorrect Key")
	end if
elseif rb_export.checked = true then
	if upper(s) = "A27338" then
		//modupdate("APP")
	else
		messagebox("Key Error","Incorrect Key")
	end if
	
elseif rb_export.checked = true then
	if upper(s) = "R35446" then
		//modupdate("REP")
	else
		messagebox("Key Error","Incorrect Key")
	end if
	
else
	
end if










//for i = 1 to dw_1.rowcount()
//	dw_1.setitem(i,"rec_id",i)
//next
//
//dw_1.update()
//commit using sqlca;















end event

type gb_1 from groupbox within w_program_module_update
integer x = 69
integer y = 264
integer width = 1394
integer height = 228
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Module"
end type

type r_print_stat_border from rectangle within w_program_module_update
integer linethickness = 4
long fillcolor = 12632256
integer x = 64
integer y = 700
integer width = 1403
integer height = 56
end type

type r_bar from rectangle within w_program_module_update
long linecolor = 8388608
integer linethickness = 4
long fillcolor = 8388608
integer x = 69
integer y = 704
integer width = 1399
integer height = 48
end type

