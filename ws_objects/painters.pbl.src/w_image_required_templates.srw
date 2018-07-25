$PBExportHeader$w_image_required_templates.srw
forward
global type w_image_required_templates from w_popup
end type
type st_2 from statictext within w_image_required_templates
end type
type cb_delete from commandbutton within w_image_required_templates
end type
type st_1 from statictext within w_image_required_templates
end type
type dw_select from u_dw within w_image_required_templates
end type
type cb_close from commandbutton within w_image_required_templates
end type
type cb_save from commandbutton within w_image_required_templates
end type
type cb_add from commandbutton within w_image_required_templates
end type
type dw_list from u_dw within w_image_required_templates
end type
type dw_temp from u_dw within w_image_required_templates
end type
type dw_data from u_dw within w_image_required_templates
end type
end forward

global type w_image_required_templates from w_popup
integer width = 3497
integer height = 2292
string title = "DE Required Document Templates"
long backcolor = 33551856
boolean center = true
st_2 st_2
cb_delete cb_delete
st_1 st_1
dw_select dw_select
cb_close cb_close
cb_save cb_save
cb_add cb_add
dw_list dw_list
dw_temp dw_temp
dw_data dw_data
end type
global w_image_required_templates w_image_required_templates

forward prototypes
public function integer of_create_items (integer ai_temp)
public function integer of_add_missing (integer ai_temp)
end prototypes

public function integer of_create_items (integer ai_temp);integer r
integer rc
integer nr
integer f
integer li_id
integer li_type

dw_data.retrieve(ai_temp)

select max(item_id) into :li_id from image_req_type_items;
if isnull(li_id) then li_id = 0

for r = 1 to dw_list.rowcount()
	li_type = dw_list.getitemnumber(r, "image_type_id")
	f = dw_data.find( "image_type = " + string(li_type), 1, dw_data.rowcount())
	if f = 0 then
		nr = dw_data.insertrow(0)
		li_id++
		dw_data.setitem(nr, "item_id",li_id)
		dw_data.setitem(nr, "temp_id", ai_temp)
		dw_data.setitem(nr, "image_type", li_type)
		dw_data.setitem(nr, "req_yes_no", 0)
		dw_data.setitem(nr, "all_active", 0)
	end if
next

dw_data.update()
dw_data.retrieve(ai_temp)




return 1
	
	
end function

public function integer of_add_missing (integer ai_temp);integer r
integer rc
integer tc
integer nr
integer f
integer li_id
integer li_type

if ai_temp < 1 then return 1

if dw_list.rowcount() = 0 then
	rc = dw_list.rowcount()
end if

tc = dw_data.rowcount()

if tc = rc then return 1


select max(item_id) into :li_id from image_req_type_items;
if isnull(li_id) then li_id = 0

for r = 1 to dw_list.rowcount()
	li_type = dw_list.getitemnumber(r, "image_type_id")
	f = dw_data.find( "image_type = " + string(li_type), 1, dw_data.rowcount())
	if f = 0 then
		nr = dw_data.insertrow(0)
		li_id++
		dw_data.setitem(nr, "item_id",li_id)
		dw_data.setitem(nr, "temp_id", ai_temp)
		dw_data.setitem(nr, "image_type", li_type)
		dw_data.setitem(nr, "req_yes_no", 0)
		dw_data.setitem(nr, "all_active", 0)
	end if
next

dw_data.update()
dw_data.retrieve(ai_temp)

return 1
end function

on w_image_required_templates.create
int iCurrent
call super::create
this.st_2=create st_2
this.cb_delete=create cb_delete
this.st_1=create st_1
this.dw_select=create dw_select
this.cb_close=create cb_close
this.cb_save=create cb_save
this.cb_add=create cb_add
this.dw_list=create dw_list
this.dw_temp=create dw_temp
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_select
this.Control[iCurrent+5]=this.cb_close
this.Control[iCurrent+6]=this.cb_save
this.Control[iCurrent+7]=this.cb_add
this.Control[iCurrent+8]=this.dw_list
this.Control[iCurrent+9]=this.dw_temp
this.Control[iCurrent+10]=this.dw_data
end on

on w_image_required_templates.destroy
call super::destroy
destroy(this.st_2)
destroy(this.cb_delete)
destroy(this.st_1)
destroy(this.dw_select)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.cb_add)
destroy(this.dw_list)
destroy(this.dw_temp)
destroy(this.dw_data)
end on

type st_2 from statictext within w_image_required_templates
integer x = 32
integer width = 1682
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Usage: These templates are connected to Data Views.  Open the Views Mananger and open the properties for the connected View(s)."
boolean focusrectangle = false
end type

type cb_delete from commandbutton within w_image_required_templates
integer x = 2770
integer y = 16
integer width = 311
integer height = 92
integer taborder = 40
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
integer li_temp
datawindowchild dwchild

if dw_temp.rowcount() < 1 then return //Start Code Change ----07.18.2016 #V152 maha

messagebox("Delete Templete", "Are you sure you want to Delete the Selected templete?", question!, yesno!, 2)

if res = 2 then return

li_temp = dw_temp.getitemnumber(1,"temp_id")

rc =  dw_data.rowcount( )
for r = 1 to rc
	dw_data.deleterow(1)
next

dw_temp.deleterow(1)

update facility set req_image_temp = null where req_image_temp = : li_temp;

dw_data.update()
dw_temp.update()


dw_select.getchild( "temp_id",  dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)


end event

type st_1 from statictext within w_image_required_templates
integer x = 14
integer y = 124
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Template"
boolean focusrectangle = false
end type

type dw_select from u_dw within w_image_required_templates
integer y = 188
integer width = 1184
integer height = 80
integer taborder = 30
string dataobject = "d_image_req_templates_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;datawindowchild dwchild

this.of_setupdateable( false)

this.of_settransobject(sqlca)
this.insertrow(1)
this.getchild( "temp_id",  dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)

end event

event itemchanged;call super::itemchanged;
dw_temp.retrieve(integer(data))
dw_data.retrieve(integer(data))

of_add_missing(integer(data))
end event

type cb_close from commandbutton within w_image_required_templates
integer x = 3090
integer y = 16
integer width = 311
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

type cb_save from commandbutton within w_image_required_templates
integer x = 2130
integer y = 16
integer width = 311
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer li_temp
integer rc
String ls_name
boolean lb_new = false
datawindowchild dwchild

if dw_temp.rowcount() < 1 then return //Start Code Change ----07.18.2016 #V152 maha

//Start Code Change ----07.19.2016 #V152 maha - error trapping
dw_temp.accepttext( )
ls_name = dw_temp.getitemstring(1, "temp_name" )
if isnull(ls_name) or len(ls_name) = 0 then
	messagebox("Save Error","Please enter a Template name")
	return 0
end if

ls_name = upper(ls_name)
select count(temp_id) into :rc from image_req_type_template where upper(temp_name) = :ls_name;

li_temp = dw_temp.getitemnumber(1, "temp_id")

if isnull(li_temp) then lb_new = true

if lb_new and rc > 0 then
	messagebox("Duplicate Template Name","Please re-enter the Template name")
	return 0
elseif rc > 1 then
	messagebox("Duplicate Template Name","Please re-enter the Template name")
	return 0
end if
//End Code Change ----07.19.2016

if lb_new then
	select max(temp_id) into :li_temp from image_req_type_template;
	if isnull(li_temp) then li_temp = 0
	li_temp++
	dw_temp.setitem(1,"temp_id", li_temp )
end if

dw_temp.update()
dw_data.update()

if dw_data.rowcount() = 0 then 
	rc = dw_data.retrieve(li_temp)
	if rc = 0 then of_create_items( li_temp)
end if

if lb_new then
	dw_select.retrieve()
	dw_select.insertrow(1)
	
	dw_select.getchild( "temp_id",  dwchild )
	dwchild.settransobject(sqlca)
	dwchild.retrieve()
	dwchild.insertrow(1)
end if




	

end event

type cb_add from commandbutton within w_image_required_templates
integer x = 2450
integer y = 16
integer width = 311
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;dw_temp.reset()
dw_data.reset()

dw_temp.insertrow(1)

end event

type dw_list from u_dw within w_image_required_templates
boolean visible = false
integer x = 603
integer width = 123
integer height = 68
integer taborder = 20
string dataobject = "d_dddw_image_types"
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.of_settransobject( sqlca)
this.retrieve()
end event

type dw_temp from u_dw within w_image_required_templates
integer x = 1211
integer y = 128
integer width = 1774
integer height = 144
integer taborder = 20
string dataobject = "d_image_req_templates_detail"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

type dw_data from u_dw within w_image_required_templates
integer x = 5
integer y = 276
integer width = 3451
integer height = 1908
integer taborder = 10
string dataobject = "d_image_req_temp_items"
end type

