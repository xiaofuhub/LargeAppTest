$PBExportHeader$w_caqh_add_fields.srw
forward
global type w_caqh_add_fields from window
end type
type st_4 from statictext within w_caqh_add_fields
end type
type st_2 from statictext within w_caqh_add_fields
end type
type st_1 from statictext within w_caqh_add_fields
end type
type cb_quit from commandbutton within w_caqh_add_fields
end type
type dw_fields from datawindow within w_caqh_add_fields
end type
type dw_tables from datawindow within w_caqh_add_fields
end type
type cb_run from commandbutton within w_caqh_add_fields
end type
end forward

global type w_caqh_add_fields from window
integer width = 2533
integer height = 2004
boolean titlebar = true
string title = "CAQH Added Fields"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_4 st_4
st_2 st_2
st_1 st_1
cb_quit cb_quit
dw_fields dw_fields
dw_tables dw_tables
cb_run cb_run
end type
global w_caqh_add_fields w_caqh_add_fields

type variables

end variables

forward prototypes
public function integer of_visible (long al_field)
public function integer of_profile (integer ai_report, string as_dw)
end prototypes

public function integer of_visible (long al_field);string ls_sql

ls_sql = "Update data_view_fields set visible = 'Y' where field_id = " + string(al_field) + ";"
execute immediate :ls_sql;
commit using sqlca;

return 1

end function

public function integer of_profile (integer ai_report, string as_dw);string ls_sql

ls_sql = "Update profile_reports set profile_report_dw = '" + as_dw + "' where profile_report_id = " + string(ai_report) + ";"
execute immediate :ls_sql;
//clipboard(ls_sql)
commit using sqlca;

return 1
end function

on w_caqh_add_fields.create
this.st_4=create st_4
this.st_2=create st_2
this.st_1=create st_1
this.cb_quit=create cb_quit
this.dw_fields=create dw_fields
this.dw_tables=create dw_tables
this.cb_run=create cb_run
this.Control[]={this.st_4,&
this.st_2,&
this.st_1,&
this.cb_quit,&
this.dw_fields,&
this.dw_tables,&
this.cb_run}
end on

on w_caqh_add_fields.destroy
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_quit)
destroy(this.dw_fields)
destroy(this.dw_tables)
destroy(this.cb_run)
end on

event open;//Start Code Change ---- 05.31.2006 #491 maha
//window and all code created maha 053106
end event

type st_4 from statictext within w_caqh_add_fields
integer x = 37
integer y = 320
integer width = 2405
integer height = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Before running this,  you may want to reposition the fields in the Default view via the screen painter.  "
boolean focusrectangle = false
end type

type st_2 from statictext within w_caqh_add_fields
integer x = 37
integer y = 224
integer width = 2423
integer height = 144
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "RUN will make the fields visible, and copy them to the other views."
boolean focusrectangle = false
end type

type st_1 from statictext within w_caqh_add_fields
integer x = 46
integer y = 64
integer width = 2368
integer height = 156
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "This utility is for the new fields used with the CAQH Application.  They can of course be used for other purposes."
boolean focusrectangle = false
end type

type cb_quit from commandbutton within w_caqh_add_fields
integer x = 2034
integer y = 1768
integer width = 343
integer height = 92
integer taborder = 30
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

type dw_fields from datawindow within w_caqh_add_fields
boolean visible = false
integer x = 1527
integer y = 624
integer width = 882
integer height = 976
integer taborder = 20
string title = "none"
string dataobject = "d_new_date_fields"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type dw_tables from datawindow within w_caqh_add_fields
integer x = 37
integer y = 512
integer width = 2341
integer height = 1216
integer taborder = 10
string title = "none"
string dataobject = "d_caqh_new_fields"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;//integer r
//integer tid
//
//r = this.getclickedrow()
//this.scrolltorow(r)
//this.setrow(r)
//this.selectrow(0,false)
//this.selectrow(r,true)
//
//tid = this.getitemnumber(r,"table_id")
//dw_fields.retrieve(tid)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

type cb_run from commandbutton within w_caqh_add_fields
integer x = 1664
integer y = 1768
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;integer t
integer tc
integer tid
long ll_fid

for t = 1 to dw_tables.rowcount()
	ll_fid = dw_tables.getitemnumber(t,"field_id")
	of_visible(ll_fid)	
	of_dv_field_add_to_views(30100,30130) //global function
next

commit using sqlca;

messagebox("Finished","Completed")
end event

