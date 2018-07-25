$PBExportHeader$w_npdb_lookups.srw
forward
global type w_npdb_lookups from window
end type
type cb_5 from commandbutton within w_npdb_lookups
end type
type dw_2 from datawindow within w_npdb_lookups
end type
type cb_4 from commandbutton within w_npdb_lookups
end type
type cb_3 from commandbutton within w_npdb_lookups
end type
type cb_2 from commandbutton within w_npdb_lookups
end type
type cb_1 from commandbutton within w_npdb_lookups
end type
type cb_save from commandbutton within w_npdb_lookups
end type
type dw_1 from datawindow within w_npdb_lookups
end type
type cb_close from commandbutton within w_npdb_lookups
end type
end forward

global type w_npdb_lookups from window
integer width = 3694
integer height = 2952
boolean titlebar = true
string title = "NPDB Lookup Codes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_5 cb_5
dw_2 dw_2
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
cb_save cb_save
dw_1 dw_1
cb_close cb_close
end type
global w_npdb_lookups w_npdb_lookups

on w_npdb_lookups.create
this.cb_5=create cb_5
this.dw_2=create dw_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.cb_save=create cb_save
this.dw_1=create dw_1
this.cb_close=create cb_close
this.Control[]={this.cb_5,&
this.dw_2,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.cb_save,&
this.dw_1,&
this.cb_close}
end on

on w_npdb_lookups.destroy
destroy(this.cb_5)
destroy(this.dw_2)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.cb_save)
destroy(this.dw_1)
destroy(this.cb_close)
end on

event open;dw_1.settransobject(sqlca)
dw_1.retrieve( )
dw_2.settransobject(sqlca)
dw_2.retrieve("Practitioner Specialties" )



end event

type cb_5 from commandbutton within w_npdb_lookups
integer x = 73
integer y = 52
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Tracking"
end type

event clicked;open(w_npdb_itp_tracking_report)
end event

type dw_2 from datawindow within w_npdb_lookups
integer x = 32
integer y = 164
integer width = 1339
integer height = 2600
integer taborder = 20
string title = "none"
string dataobject = "d_code_lookup"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_4 from commandbutton within w_npdb_lookups
integer x = 1467
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Replace"
end type

event clicked;integer i
string ls_sql
n_cst_npdb lnv_npdb

i = messagebox("Replace","This will delete all codes and replace them with the defaults.  Continue?" ,question!,yesno!,1)
if i = 2 then return

for i = dw_1.rowcount() to 1 step -1
	dw_1.deleterow(i)
next

dw_1.update()

//return
lnv_npdb = create n_cst_npdb
//lnv_npdb.of_create_database()
lnv_npdb.of_insert_codes()
lnv_npdb.of_insert_codes2()
lnv_npdb.of_insert_codes3( )	//add by stephen 09.10.2012 --V12.2 modify NPDB qrxs report
lnv_npdb.of_insert_new_error_codes()

for i = 1 to upperbound(lnv_npdb.ls_sql_statments)
	ls_sql = lnv_npdb.ls_sql_statments[i]
	execute immediate :ls_sql using sqlca;
	commit using sqlca;	
next

destroy n_cst_npdb

dw_1.retrieve()
end event

type cb_3 from commandbutton within w_npdb_lookups
integer x = 2185
integer y = 32
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Sort"
end type

event clicked;string null_str

SetNull(null_str)

dw_1.Setsort(null_str)

dw_1.sort()
end event

type cb_2 from commandbutton within w_npdb_lookups
integer x = 2542
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
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

type cb_1 from commandbutton within w_npdb_lookups
integer x = 1824
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_1.insertrow(1)
end event

type cb_save from commandbutton within w_npdb_lookups
integer x = 2907
integer y = 32
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_1.update()
end event

type dw_1 from datawindow within w_npdb_lookups
integer x = 1399
integer y = 164
integer width = 2217
integer height = 2600
integer taborder = 10
string title = "none"
string dataobject = "d_npdb_lookup_code"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type cb_close from commandbutton within w_npdb_lookups
integer x = 3269
integer y = 32
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close (parent)
end event

