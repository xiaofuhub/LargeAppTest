$PBExportHeader$w_oig_category_delete.srw
forward
global type w_oig_category_delete from window
end type
type cb_refresh from commandbutton within w_oig_category_delete
end type
type cb_delete from commandbutton within w_oig_category_delete
end type
type cb_close from commandbutton within w_oig_category_delete
end type
type st_1 from statictext within w_oig_category_delete
end type
type dw_1 from datawindow within w_oig_category_delete
end type
end forward

global type w_oig_category_delete from window
integer width = 2793
integer height = 1712
boolean titlebar = true
string title = "OIG data Filter"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_refresh cb_refresh
cb_delete cb_delete
cb_close cb_close
st_1 st_1
dw_1 dw_1
end type
global w_oig_category_delete w_oig_category_delete

on w_oig_category_delete.create
this.cb_refresh=create cb_refresh
this.cb_delete=create cb_delete
this.cb_close=create cb_close
this.st_1=create st_1
this.dw_1=create dw_1
this.Control[]={this.cb_refresh,&
this.cb_delete,&
this.cb_close,&
this.st_1,&
this.dw_1}
end on

on w_oig_category_delete.destroy
destroy(this.cb_refresh)
destroy(this.cb_delete)
destroy(this.cb_close)
destroy(this.st_1)
destroy(this.dw_1)
end on

event open; //Start Code Change ----12.14.2015 #V15 maha - added

string s

s = "The imported OIG data contains all current sanctions from the OIG.  Many of them will not be appropriate to your Providers.~r~r"
s+= "This utility will allow you to remove categories of records which may improve search performance, depending on your volume of searches at one time.~r~r"
s+= "Be careful to not delete records that may be appropriate.~r~r"
s+= "If you delete a category by mistake, you can get it back by re-importing the OIG data file."

st_1.text = s

dw_1.settransobject(sqlca)
dw_1.retrieve()
end event

type cb_refresh from commandbutton within w_oig_category_delete
integer x = 1472
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;dw_1.retrieve()
end event

type cb_delete from commandbutton within w_oig_category_delete
integer x = 1915
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res
integer r
integer rc
integer li_check = 0
string ls_sql
string ls_cats



res = messagebox("Delete Records","Are you sure you wist to delete the selected category(s) of records from the OIG data?", question!,yesno!,2)

if res = 2 then return

ls_sql = "Delete from oig_data where general in ("

rc = dw_1.rowcount()

for r = 1 to rc
	if dw_1.getitemnumber(r, "selected") = 1 then
		ls_cats+= "'" + dw_1.getitemstring(r, "general") + "',"
		li_check++
	end if
next

if li_check = 0 then
	messagebox("Delete Records","You have not selected any categories to delete.")
elseif li_check = rc then
	messagebox("Delete Records","You have selected all categories which would delete all OIG records. Delete canceled.")
else
	ls_cats = mid(ls_cats, 1, len(ls_cats) - 1)
	//messagebox("",ls_cats)	
	ls_sql = ls_sql + ls_cats + ")"	
	//messagebox("slq",ls_sql)
end if

execute immediate :ls_sql using sqlca;
commit using sqlca;

		


end event

type cb_close from commandbutton within w_oig_category_delete
integer x = 2391
integer y = 36
integer width = 343
integer height = 84
integer taborder = 10
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

type st_1 from statictext within w_oig_category_delete
integer x = 1253
integer y = 200
integer width = 1445
integer height = 1048
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Informational message"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_oig_category_delete
integer x = 50
integer y = 72
integer width = 1088
integer height = 1424
integer taborder = 10
string title = "none"
string dataobject = "d_oig_category_select"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;integer r
integer s

if dwo.text = "Select All" then
	s = 1
	dwo.text = "Deselect All"
else
	s = 0
	dwo.text = "Select All"
end if

for r = 1 to this.rowcount()
	this.setitem(r,"selected", s)
next
	
end event

