$PBExportHeader$w_open_migration_type.srw
forward
global type w_open_migration_type from window
end type
type lb_from from listbox within w_open_migration_type
end type
type rb_e from radiobutton within w_open_migration_type
end type
type rb_a from radiobutton within w_open_migration_type
end type
type cb_4 from commandbutton within w_open_migration_type
end type
type cb_3 from commandbutton within w_open_migration_type
end type
type cb_2 from commandbutton within w_open_migration_type
end type
type cb_1 from commandbutton within w_open_migration_type
end type
type gb_1 from groupbox within w_open_migration_type
end type
end forward

global type w_open_migration_type from window
integer x = 923
integer y = 716
integer width = 1993
integer height = 520
boolean titlebar = true
string title = "Intelliapp Training Data Generator"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 32891346
lb_from lb_from
rb_e rb_e
rb_a rb_a
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_open_migration_type w_open_migration_type

forward prototypes
public function integer of_db_connect ()
end prototypes

public function integer of_db_connect ();//string ls_dsn
//integer i
//
//i = lb_from.SelectedIndex()
//ls_dsn = lb_from.Text ( i )
//if i = -1 then 
//	messagebox("ODBC","Please select an odbc connection")
//	return -1
//end if
//	
////messagebox("",ls_dsn)
//
//SQLCA.DBMS="ODBC"
//SQLCA.DbParm="ConnectString='DSN=" + ls_dsn + ";UID=DBA;PWD=SQL;',DelimitIdentifier='No'"
//	
//disconnect using SQLCA;	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Not Logged In", "Login Failed!")
//ELSE
//	MESSAGEBOX("","LOGIN OK")
//END IF

return 1
end function

on w_open_migration_type.create
this.lb_from=create lb_from
this.rb_e=create rb_e
this.rb_a=create rb_a
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
this.Control[]={this.lb_from,&
this.rb_e,&
this.rb_a,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.gb_1}
end on

on w_open_migration_type.destroy
destroy(this.lb_from)
destroy(this.rb_e)
destroy(this.rb_a)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
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

//string ls_subkeylist[]
//integer li_rtn
//INTEGER I
//
//li_rtn = RegistryKeys("HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBC.INI", ls_subkeylist)
//
//IF li_rtn = -1 THEN
//
//END IF
//
//FOR i = 1 to upperbound(ls_subkeylist)
//	lb_from.additem(ls_subkeylist[i])
//next
end event

event close;//disCONNECT USING SQLCA;
end event

type lb_from from listbox within w_open_migration_type
integer x = 192
integer y = 856
integer width = 503
integer height = 604
integer taborder = 50
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

type rb_e from radiobutton within w_open_migration_type
integer x = 123
integer y = 188
integer width = 338
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Exports"
end type

type rb_a from radiobutton within w_open_migration_type
integer x = 123
integer y = 112
integer width = 471
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32891346
string text = "Applications"
boolean checked = true
end type

type cb_4 from commandbutton within w_open_migration_type
integer x = 782
integer y = 220
integer width = 745
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "INSERT Import Rows"
end type

event clicked;of_db_connect()

if rb_a.checked = true then
	open(w_import_iapp)
elseif rb_e.checked = true then
	open(w_import_export)
end if




close(parent)

end event

type cb_3 from commandbutton within w_open_migration_type
integer x = 1605
integer y = 100
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Quit"
end type

event clicked;CLOSE(PARENT)
end event

type cb_2 from commandbutton within w_open_migration_type
integer x = 782
integer y = 104
integer width = 745
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "CREATE Export Files"
end type

event clicked;of_db_connect()

if rb_a.checked = true then
	open(w_iapp_conv_new)
elseif rb_e.checked = true then
	open(w_make_export_files)
end if

close(parent)

end event

type cb_1 from commandbutton within w_open_migration_type
integer x = 3086
integer y = 164
integer width = 265
integer height = 72
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "About"
end type

event clicked;messagebox("To operate this program :","Select a record type. Click run.  You will get a list of expiring records from 30 days in the future for active records.")
end event

type gb_1 from groupbox within w_open_migration_type
integer x = 5
integer y = 32
integer width = 750
integer height = 328
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 32891346
string text = "Select Migration"
end type

