$PBExportHeader$w_view_alias_missing.srw
forward
global type w_view_alias_missing from w_response
end type
type dw_view_alias from u_dw within w_view_alias_missing
end type
type cb_1 from commandbutton within w_view_alias_missing
end type
type cb_close from commandbutton within w_view_alias_missing
end type
type dw_1 from u_dw within w_view_alias_missing
end type
end forward

global type w_view_alias_missing from w_response
integer x = 214
integer y = 221
integer width = 1655
integer height = 2472
long backcolor = 33551856
dw_view_alias dw_view_alias
cb_1 cb_1
cb_close cb_close
dw_1 dw_1
end type
global w_view_alias_missing w_view_alias_missing

type variables
boolean ib_asa = false
end variables

forward prototypes
public function integer of_add_fields (integer ai_row)
end prototypes

public function integer of_add_fields (integer ai_row);
long ll_id
string ls_view


ls_view = dw_1.getitemstring(ai_row, "table_name")

if gs_dbtype = "ASA" then
	ll_id = dw_1.getitemnumber(ai_row, "table_id")
else
	ll_id = 0
end if

of_view_alias_add_missing_fields(ls_view, ll_id, 0)

return 1
end function

event open;call super::open; //Start Code Change ----05.22.2017 #V154 maha - utility to add missing view alias and field alias records
integer rc
 
 
 if gs_dbtype = "ASA" then ib_asa = true
 
 if ib_asa then
	dw_1.dataobject = "d_view_alias_missing_tables"
	dw_1.settransobject(sqlca)
end if

rc = dw_1.retrieve()

if rc = 0 then
	messagebox("View Alias Tables","There are no missing alias tables.")
	return 
end if

dw_view_alias.settransobject(sqlca)


end event

on w_view_alias_missing.create
int iCurrent
call super::create
this.dw_view_alias=create dw_view_alias
this.cb_1=create cb_1
this.cb_close=create cb_close
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_view_alias
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_close
this.Control[iCurrent+4]=this.dw_1
end on

on w_view_alias_missing.destroy
call super::destroy
destroy(this.dw_view_alias)
destroy(this.cb_1)
destroy(this.cb_close)
destroy(this.dw_1)
end on

type dw_view_alias from u_dw within w_view_alias_missing
boolean visible = false
integer x = 27
integer y = 16
integer width = 169
integer height = 100
integer taborder = 30
string dataobject = "d_view_alias"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_view_alias_missing
integer x = 544
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add Missing"
end type

event clicked; //Start Code Change ----05.22.2017 #V154 maha
integer r
integer rc
integer ll_row
string ls_v_name

dw_1.accepttext()

for r = 1 to dw_1.rowcount()
	if dw_1.getitemnumber(r,"selected") = 1 then
		debugbreak()
		ls_v_name = dw_1.getitemstring(r, "table_name")
		ll_row = dw_view_alias.insertrow(0)
		dw_view_alias.SetItem(ll_Row,"module", 3)
		dw_view_alias.SetItem(ll_Row,"v_name", ls_v_name)
		ls_v_name =  of_strip_char( "_", ls_v_name, " ") 
		ls_v_name =  of_strip_char("", ls_v_name, "@FIRSTCAP@")
		dw_view_alias.SetItem(ll_Row,"v_alias", ls_v_name)
		dw_view_alias.SetItem(ll_Row,"sflag" , "N")
		of_add_fields(r)
	end if
next

dw_view_alias.update()

dw_1.retrieve()


		
		

end event

type cb_close from commandbutton within w_view_alias_missing
integer x = 1312
integer y = 20
integer width = 302
integer height = 96
integer taborder = 10
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

type dw_1 from u_dw within w_view_alias_missing
integer x = 18
integer y = 148
integer height = 2212
integer taborder = 10
string dataobject = "d_view_alias_missing_tables_sql"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
end event

event buttonclicked;call super::buttonclicked;integer r
integer rc
integer li_set
string s

if dwo.text = "Select All" then
	li_set = 1
	s = "Deselect All"
else
	li_set = 0
	s = "Select All"	
end if

for r = 1 to this.rowcount()
	this.setitem(r, "selected", li_set)
next

dwo.text = s
end event

