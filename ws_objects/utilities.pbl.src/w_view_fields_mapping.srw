$PBExportHeader$w_view_fields_mapping.srw
forward
global type w_view_fields_mapping from window
end type
type cb_export from commandbutton within w_view_fields_mapping
end type
type dw_screen from datawindow within w_view_fields_mapping
end type
type dw_screen_fields from datawindow within w_view_fields_mapping
end type
type cb_view from commandbutton within w_view_fields_mapping
end type
type cb_save from commandbutton within w_view_fields_mapping
end type
type dw_table_fields from datawindow within w_view_fields_mapping
end type
type dw_view_fields from datawindow within w_view_fields_mapping
end type
type dw_views from datawindow within w_view_fields_mapping
end type
end forward

global type w_view_fields_mapping from window
integer width = 4777
integer height = 2032
boolean titlebar = true
string title = "View Fields Mapping"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_export cb_export
dw_screen dw_screen
dw_screen_fields dw_screen_fields
cb_view cb_view
cb_save cb_save
dw_table_fields dw_table_fields
dw_view_fields dw_view_fields
dw_views dw_views
end type
global w_view_fields_mapping w_view_fields_mapping

type variables

end variables

forward prototypes
public function integer of_set_flag ()
public function integer of_set_screen_fields (string as_dataobject)
end prototypes

public function integer of_set_flag ();
long i, ll_found, ll_view_cnt, ll_tbl_cnt, ll_screen_cnt
string ls_field_name, ls_c_name, ls_find

ll_view_cnt = dw_view_fields.rowcount()
ll_tbl_cnt = dw_table_fields.rowcount()
ll_screen_cnt = dw_screen_fields.rowcount()

//set flag in dw_view_fields
for i = 1 to ll_view_cnt
	ls_c_name = dw_view_fields.getitemstring(i, 'c_name')
	ls_field_name = dw_view_fields.getitemstring(i, 'field_name')
	//set flag if 'field_name' is not set and 'c_name' is not found in dw_table_fields
	if isnull(ls_field_name ) or Len(trim(ls_field_name)) < 1 then 
		ll_found = dw_table_fields.find("field_name = '" + ls_c_name + "'",1, ll_tbl_cnt)
		if isnull(ll_found) or ll_found < 1 then 
			dw_view_fields.SetItem(i, 'flag', 0) 
		end if
	end if
next

//set flag in dw_table_fields
for i = 1 to ll_tbl_cnt
	ls_field_name = dw_table_fields.getitemstring(i, 'field_name')

	//set flag if 'field_name' is not found or set in dw_field_fields
	if Len(trim(ls_field_name)) > 0 and ls_field_name <> 'code' and ls_field_name <> 'lookup_code' and ls_field_name <> 'description' then
		ls_find = "c_name = '" + ls_field_name + "' or field_name = '" + ls_field_name + "'"
		ll_found = dw_view_fields.find(ls_find,1, ll_view_cnt)
		if isnull(ll_found) or ll_found < 1 then 
			dw_table_fields.SetItem(i, 'flag', 0) 
		end if
	end if
next

//set flag in dw_screen_fields
for i = 1 to ll_screen_cnt
	ls_field_name = dw_screen_fields.getitemstring(i, 'field_name')

	//set flag if 'field_name' is not found or set in dw_field_fields
	if Len(trim(ls_field_name)) > 0 and ls_field_name <> 'code' and ls_field_name <> 'lookup_code' and ls_field_name <> 'description' then
		ls_find = "upper(c_name) = '" + upper(ls_field_name) + "' or upper(field_name) = '" + upper(ls_field_name) + "'"
		ll_found = dw_view_fields.find(ls_find,1, ll_view_cnt)
		if isnull(ll_found) or ll_found < 1 then 
			dw_screen_fields.SetItem(i, 'flag', 0) 
		end if
	end if
next

dw_view_fields.sort()
dw_table_fields.sort()
dw_screen_fields.sort()

return 1
end function

public function integer of_set_screen_fields (string as_dataobject);long ll_row,i
string ls_colname, ls_visible

dw_screen_fields.reset()

if isnull(as_dataobject) or len(trim(as_dataobject)) < 1 then return 0
if Pos(as_dataobject, ",") > 0  then return 0 //2 or more dataobjects


dw_screen.dataobject = as_dataobject
dw_screen.settransobject(sqlca)

dw_screen_fields.setredraw(false)
for i=1 to integer(dw_screen.object.datawindow.column.count) 
   ls_colname =dw_screen.describe("#"+string(i)+".name") 
   ls_visible = dw_screen.describe("#"+string(i)+".visible")

   if ls_visible = '0' then continue

   ll_row = dw_screen_fields.insertrow(0)	
   dw_screen_fields.setitem(ll_row, 'field_name', ls_colname)
   dw_screen_fields.setitem(ll_row, 'flag', 1)	
next 
dw_screen_fields.setredraw(true)
end function

on w_view_fields_mapping.create
this.cb_export=create cb_export
this.dw_screen=create dw_screen
this.dw_screen_fields=create dw_screen_fields
this.cb_view=create cb_view
this.cb_save=create cb_save
this.dw_table_fields=create dw_table_fields
this.dw_view_fields=create dw_view_fields
this.dw_views=create dw_views
this.Control[]={this.cb_export,&
this.dw_screen,&
this.dw_screen_fields,&
this.cb_view,&
this.cb_save,&
this.dw_table_fields,&
this.dw_view_fields,&
this.dw_views}
end on

on w_view_fields_mapping.destroy
destroy(this.cb_export)
destroy(this.dw_screen)
destroy(this.dw_screen_fields)
destroy(this.cb_view)
destroy(this.cb_save)
destroy(this.dw_table_fields)
destroy(this.dw_view_fields)
destroy(this.dw_views)
end on

type cb_export from commandbutton within w_view_fields_mapping
integer x = 1600
integer y = 1828
integer width = 379
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Export Data"
end type

event clicked;datastore lds_exp

lds_exp = create datastore
lds_exp.dataobject = 'd_ic_view_fields_exp'
lds_exp.settransobject(sqlca)
lds_exp.retrieve()

lds_exp.saveas("c:\update_view_fields.txt" , TEXT!, false)

MessageBox("Export","Export data to 'c:\update_view_fields.txt' completed!")

destroy lds_exp
end event

type dw_screen from datawindow within w_view_fields_mapping
boolean visible = false
integer x = 2313
integer y = 1856
integer width = 686
integer height = 400
integer taborder = 40
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_screen_fields from datawindow within w_view_fields_mapping
integer x = 3456
integer y = 36
integer width = 1271
integer height = 1768
integer taborder = 30
boolean titlebar = true
string title = "Screen fields"
string dataobject = "d_ic_screen_fields"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type cb_view from commandbutton within w_view_fields_mapping
integer x = 119
integer y = 1824
integer width = 475
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy & View Syntax"
end type

event clicked;long ll_row
String ls_text, ls_view_name


ll_row = dw_view_fields.getrow() 
if ll_row < 1 then return

ls_view_name = dw_view_fields.GetItemString(ll_row,'v_name')

select text into :ls_text from sysobjects a, syscomments c where a.name = :ls_view_name and object_id(a.name)= c.id ;

Clipboard (ls_text )
OpenwithParm(w_ai_notes, ls_text)

end event

type cb_save from commandbutton within w_view_fields_mapping
integer x = 1170
integer y = 1824
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Update"
end type

event clicked;dw_view_fields.update()
end event

type dw_table_fields from datawindow within w_view_fields_mapping
integer x = 2167
integer y = 36
integer width = 1271
integer height = 1768
integer taborder = 20
boolean titlebar = true
string title = "Mapping tables & fields"
string dataobject = "d_ic_table_fields"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_view_fields from datawindow within w_view_fields_mapping
integer x = 832
integer y = 36
integer width = 1294
integer height = 1768
integer taborder = 20
boolean titlebar = true
string title = "View_fields_alias"
string dataobject = "d_ic_view_fields"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
end event

type dw_views from datawindow within w_view_fields_mapping
integer x = 9
integer y = 36
integer width = 759
integer height = 1768
integer taborder = 10
boolean titlebar = true
string title = "Select View"
string dataobject = "d_ic_views"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(sqlca)
retrieve()
end event

event rowfocuschanged;string ls_screen
string ls_view_name

if currentrow > 0 then
	ls_view_name = this.getitemstring(currentrow, 'v_name')
	ls_screen = this.getitemstring(currentrow, 'screen')

	dw_view_fields.retrieve(ls_view_name)
	dw_table_fields.retrieve(ls_view_name)
	If isnumber(ls_screen) then 
		dw_screen_fields.retrieve(long(ls_screen))
	else
		of_set_screen_fields(ls_screen)
	end if
	
	of_set_flag()
	
	selectrow(0, false)
	selectrow(currentrow, true)
end if


end event

