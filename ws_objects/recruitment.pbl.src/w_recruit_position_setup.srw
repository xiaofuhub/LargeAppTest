$PBExportHeader$w_recruit_position_setup.srw
forward
global type w_recruit_position_setup from window
end type
type cb_1 from commandbutton within w_recruit_position_setup
end type
type st_1 from statictext within w_recruit_position_setup
end type
type cb_close from commandbutton within w_recruit_position_setup
end type
type dw_2 from datawindow within w_recruit_position_setup
end type
type dw_prop from datawindow within w_recruit_position_setup
end type
end forward

global type w_recruit_position_setup from window
integer width = 1545
integer height = 1376
boolean titlebar = true
string title = "Position Custom Fields"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_1 st_1
cb_close cb_close
dw_2 dw_2
dw_prop dw_prop
end type
global w_recruit_position_setup w_recruit_position_setup

type variables

end variables

forward prototypes
public function integer of_apply ()
end prototypes

public function integer of_apply ();integer r
Integer li_vis
Integer li_require

string ls_text
string ls_field

string ls_style
if  dw_prop.rowcount() < 1 then return 0

for r = 1 to dw_prop.rowcount()
	
	//ls_vis = dw_prop.getitemstring(r, "validate_against_lookup")
	li_vis = dw_prop.getitemnumber(r, "range_from")	//Appeon long.zhang 09.29.2013 (V14.1 Recruitment Functionality)
	ls_text = dw_prop.getitemstring(r, "field_name_allias")
	ls_field = dw_prop.getitemstring(r, "field_name")
	li_require = dw_prop.getitemnumber(r, "range_to")	//Appeon long.zhang 09.29.2013 (V14.1 Recruitment Functionality)

	ls_style = dw_2.Describe(ls_field+".Edit.Style")
	
	if ls_style = '?' then continue
	
	if li_vis = 0 then//Appeon long.zhang 09.29.2013 (V14.1 Recruitment Functionality)
		dw_2.Modify(ls_field + ".background.color='14803425'") 
 		dw_2.Modify(ls_field + "_t.color='8421504'") 
	else
		if li_require = 1 then
			dw_2.Modify(ls_field + ".background.color='8257535'") 	
		else
			dw_2.Modify(ls_field + ".background.color='16777215'") 	
		end if
			dw_2.Modify(ls_field + "_t.color='0'") 
	end if
	
	dw_2.Modify(ls_field +  "_t.text = '" + ls_text + "'") 
next

dw_prop.update()
	
return 1
	
end function

on w_recruit_position_setup.create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_close=create cb_close
this.dw_2=create dw_2
this.dw_prop=create dw_prop
this.Control[]={this.cb_1,&
this.st_1,&
this.cb_close,&
this.dw_2,&
this.dw_prop}
end on

on w_recruit_position_setup.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_close)
destroy(this.dw_2)
destroy(this.dw_prop)
end on

event open;dw_prop.settransobject(sqlca)
dw_prop.retrieve()
dw_2.insertrow(1)

of_apply()

end event

type cb_1 from commandbutton within w_recruit_position_setup
integer x = 576
integer y = 1172
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;close(parent)
end event

type st_1 from statictext within w_recruit_position_setup
integer x = 169
integer y = 28
integer width = 1248
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Double-click a field to view Properties."
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_recruit_position_setup
integer x = 2469
integer y = 28
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

event clicked;close(parent)
end event

type dw_2 from datawindow within w_recruit_position_setup
integer y = 120
integer width = 1531
integer height = 1044
integer taborder = 20
string title = "none"
string dataobject = "d_recruit_position_setup"
boolean livescroll = true
end type

event doubleclicked;//string ls_selected_object
//string ls_selected_object_name
//integer p1, p
//
//ls_selected_object = This.GetObjectAtPointer()
//ls_selected_object_name = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )
//
////messagebox( ls_selected_object, ls_selected_object_name)
//
//if len(ls_selected_object_name) < 1 then return
//debugbreak()
//p1 = pos (ls_selected_object_name, "_t", len(ls_selected_object_name) - 2)
//if p1 > 0 then 
//	messagebox( "Selected object", "Please select a field, not it's label")
//	return 1
//end if
//
//dw_prop.SetFilter("field_name = '" + ls_selected_object_name + "'" )
//p = dw_prop.Filter()

if lower(dwo.type) = 'button' then return //added by long.zhang 11.11.2013 BugS101803 

IF NOT IsValid(w_field_properties_recruitment) THEN
	Openwithparm(w_field_properties_recruitment, "P")
	w_field_properties_recruitment.idw_win = dw_prop
END IF

w_field_properties_recruitment.of_share_data()
	
end event

event clicked;string ls_selected_object
string ls_selected_object_name
integer p1, p



ls_selected_object = This.GetObjectAtPointer()
ls_selected_object_name = MidA(ls_selected_object, 1, PosA(ls_selected_object, "	" ) -1 )

//messagebox( ls_selected_object, ls_selected_object_name)

if len(ls_selected_object_name) < 1 then return
//debugbreak()
p1 = pos (ls_selected_object_name, "_t", len(ls_selected_object_name) - 2)
if p1 > 0 then 
	messagebox( "Selected object", "Please select a field, not it's label")
	return 1
end if

dw_prop.SetFilter("lower(field_name) = '" + lower(ls_selected_object_name) + "'" )
p = dw_prop.Filter()


end event

type dw_prop from datawindow within w_recruit_position_setup
boolean visible = false
integer x = 50
integer y = 16
integer width = 343
integer height = 260
integer taborder = 20
string title = "none"
string dataobject = "d_sys_field_prop_recruiting"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

