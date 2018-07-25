$PBExportHeader$w_button_templates.srw
forward
global type w_button_templates from window
end type
type cb_4 from commandbutton within w_button_templates
end type
type cb_3 from commandbutton within w_button_templates
end type
type cb_2 from commandbutton within w_button_templates
end type
type cb_save from commandbutton within w_button_templates
end type
type dw_types from datawindow within w_button_templates
end type
type cb_1 from commandbutton within w_button_templates
end type
type dw_browse from datawindow within w_button_templates
end type
type dw_buttons from datawindow within w_button_templates
end type
end forward

global type w_button_templates from window
integer width = 2971
integer height = 1872
boolean titlebar = true
string title = "Login Button Templates"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_save cb_save
dw_types dw_types
cb_1 cb_1
dw_browse dw_browse
dw_buttons dw_buttons
end type
global w_button_templates w_button_templates

type variables
integer ii_temp_id
Boolean ib_new  //(Appeon)Harry 11.25.2014 - for BugH102801
end variables

forward prototypes
public subroutine of_refresh_list ()
end prototypes

public subroutine of_refresh_list ();datawindowchild dwchild
integer li_find

dw_browse.getchild("temp_id",dwchild)

dwchild.settransobject(sqlca)
dwchild.retrieve()

li_find = dwchild.find( "temp_id = "  + string(ii_temp_id), 1, 10000)

if li_find > 0 then
	dw_browse.setitem(1 ,"temp_id", ii_temp_id)
else
	ii_temp_id = dw_browse.getitemnumber(1 ,"temp_id")
end if




end subroutine

on w_button_templates.create
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_save=create cb_save
this.dw_types=create dw_types
this.cb_1=create cb_1
this.dw_browse=create dw_browse
this.dw_buttons=create dw_buttons
this.Control[]={this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_save,&
this.dw_types,&
this.cb_1,&
this.dw_browse,&
this.dw_buttons}
end on

on w_button_templates.destroy
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_save)
destroy(this.dw_types)
destroy(this.cb_1)
destroy(this.dw_browse)
destroy(this.dw_buttons)
end on

event open;dw_browse.settransobject(sqlca)
//dw_browse.retrieve()
dw_browse.insertrow(1)
dw_buttons.settransobject(sqlca)
dw_types.settransobject(sqlca)
dw_types.retrieve()
end event

type cb_4 from commandbutton within w_button_templates
integer x = 1989
integer y = 24
integer width = 466
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Role Assignment"
end type

event clicked;open(w_button_template_roles)
end event

type cb_3 from commandbutton within w_button_templates
integer x = 1627
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;//Start Code Change ----05.28.2013 #V14 maha
integer cnt
string ls_mess

if dw_buttons.rowcount() < 1 then return  //Start Code Change ----11.18.2013 #V14 maha

//---------Begin Added by (Appeon)Harry 11.25.2014 for BugH102802--------
dwItemStatus ldw_status
ldw_status = dw_buttons.getitemstatus( 1, 0, Primary!)
if ldw_status = New! or ldw_status = Newmodified! then
	dw_buttons.deleterow(1)
	return
end if
//---------End Added ------------------------------------------------------

select count( button_temp) into :cnt from security_roles where button_temp = :ii_temp_id;

if cnt > 0 then
	ls_mess = "There are " + string (cnt) + " Roles assigned this template.  Are you sure you want to delete it?"
else
	ls_mess = "Are you sure you want to delete this template?"
end if

cnt  = messagebox("Delete Template",ls_mess,question!,yesno!,2)

if cnt = 1 then
	dw_buttons.deleterow(0)
	update security_roles set button_temp = null where button_temp = :ii_temp_id;
	dw_buttons.update()
	of_refresh_list( )
end if


	
end event

type cb_2 from commandbutton within w_button_templates
integer x = 1271
integer y = 24
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;
ib_new = true  //(Appeon)Harry 11.25.2014 - for BugH102801
cb_save.triggerevent(clicked!)
if not ib_new then return //(Appeon)Harry 11.25.2014 - for BugH102801
dw_buttons.insertrow(1)
dw_buttons.setitem(1,"button_1",0)
dw_buttons.setitem(1,"button_2",0)
dw_buttons.setitem(1,"button_3",0)
dw_buttons.setitem(1,"button_4",0)
dw_buttons.setitem(1,"button_5",17)
dw_buttons.setitem(1,"button_6",0)
dw_buttons.setitem(1,"button_7",0)
dw_buttons.setitem(1,"button_8",0)
dw_buttons.setitem(1,"button_9",0)


end event

type cb_save from commandbutton within w_button_templates
integer x = 923
integer y = 24
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;integer t
integer cnt

if dw_buttons.rowcount() < 1 then return 

////---------Begin Added by (Appeon)Harry 11.25.2014 for BugH102801--------
//testing existing records for completion
String ls_temp_name
dw_buttons.accepttext( )
ls_temp_name = dw_buttons.getitemstring(1, "temp_name")
if ls_temp_name = '' or isnull(ls_temp_name) then
	MessageBox("Required Field", "You must enter a template name." )
	dw_buttons.SetColumn('temp_name')
	ib_new = false
	return 
end if
////---------End Added ------------------------------------------------------



if isnull(dw_buttons.getitemnumber(1,"temp_id")) then
	//Start Code Change ----02.11.2016 #V15 maha = trap for duplicate
	select count(temp_id) into :cnt from button_template where upper(temp_name) = upper(:ls_temp_name);
	if cnt > 0 then
		MessageBox("Duplicate", "The template name already exists." )
		dw_buttons.SetColumn('temp_name')
		dw_buttons.Setfocus()
		return 
	end if
	//End Code Change ----02.11.2016 
	
	select max(temp_id) into :t from button_template;
	if isnull(t) then t = 0  //Start Code Change ----11.18.2013 #V14 maha
	t++
	dw_buttons.setitem(1,"temp_id",t)
	ii_temp_id = t
end if


dw_buttons.update()

of_refresh_list( )


end event

type dw_types from datawindow within w_button_templates
integer x = 2304
integer y = 144
integer width = 645
integer height = 1636
integer taborder = 20
string dragicon = "droparrow.ico"
string title = "none"
string dataobject = "d_button_type_list"
boolean vscrollbar = true
boolean livescroll = true
end type

event clicked;integer r

r = this.getclickedrow()

this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

Drag(begin!)
end event

type cb_1 from commandbutton within w_button_templates
integer x = 2606
integer y = 24
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

type dw_browse from datawindow within w_button_templates
integer x = 9
integer y = 28
integer width = 859
integer height = 96
integer taborder = 10
string title = "none"
string dataobject = "d_button_template_select"
boolean border = false
boolean livescroll = true
end type

event itemchanged;integer t

t = integer(data)

ii_temp_id = t

dw_buttons.retrieve(t)
end event

type dw_buttons from datawindow within w_button_templates
integer x = 9
integer y = 144
integer width = 2290
integer height = 1636
integer taborder = 20
string title = "none"
string dataobject = "d_button_template_detail"
boolean livescroll = true
end type

event dragdrop;integer r
string ls_field

r = dw_types.getitemnumber(dw_types.getrow(), "button_type")
ls_field = dwo.name

choose case ls_field  //trap for bad drop
	case 'datawindow' , 'temp_id', 'temp_name'
		return
end choose

this.setitem(1,ls_field, r)
end event

event clicked;string s
end event

