$PBExportHeader$w_data_migration.srw
forward
global type w_data_migration from window
end type
type cb_2 from commandbutton within w_data_migration
end type
type cb_run from commandbutton within w_data_migration
end type
type st_2 from statictext within w_data_migration
end type
type rb_exp from radiobutton within w_data_migration
end type
type rb_imp from radiobutton within w_data_migration
end type
type dw_1 from datawindow within w_data_migration
end type
type st_1 from statictext within w_data_migration
end type
type ddlb_type from dropdownlistbox within w_data_migration
end type
type gb_1 from groupbox within w_data_migration
end type
end forward

global type w_data_migration from window
integer width = 1243
integer height = 2256
boolean titlebar = true
string title = "Data Migration Utility"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_run cb_run
st_2 st_2
rb_exp rb_exp
rb_imp rb_imp
dw_1 dw_1
st_1 st_1
ddlb_type ddlb_type
gb_1 gb_1
end type
global w_data_migration w_data_migration

type variables
boolean ib_set = false
string is_type
string is_mod

end variables

forward prototypes
public function integer of_after_change ()
public function integer of_set_dws ()
public function integer of_import ()
public function integer of_export ()
end prototypes

public function integer of_after_change ();//function determines is everything is selected
//debugbreak()
if is_type = "I" or  is_type = "E" then
	choose case is_mod	
		case "I","E","W"
			ib_set = true
			of_set_dws( )
			cb_run.enabled = true
		case else
			ib_set = false
	end choose
else
	ib_set = false
end if
			
return 1
end function

public function integer of_set_dws ();choose case is_type
	case "I"
		choose case is_mod
			case "E"
				dw_1.dataobject = ""
			case "I"
				dw_1.dataobject = ""
			case "W"
				dw_1.dataobject = ""
		end choose
	case "E"
		choose case is_mod
			case "E"
				dw_1.dataobject = ""
			case "I"
				dw_1.dataobject = ""
			case "W"
				dw_1.dataobject = ""
		end choose
end choose

dw_1.settransobject(sqlca)
dw_1.retrieve()

return 1
		
end function

public function integer of_import ();






return 1
end function

public function integer of_export ();integer i
integer ic
integer c
long li_id[]
string ls_field
string ls_path
string ls_today
datastore lds_head
datastore lds_2
datastore lds_3
datastore lds_4
datastore lds_5

//debugbreak()
ls_today = string (today())
ls_today = of_format_string(ls_today,"DATE","mmddyy")

//error trapping
choose case is_mod
	case "E"//exp
		ls_field = "export_id"		
	case  "I"//imp
		ls_field = "import_id"		
	case "W"//workflow
		ls_field = "wf_id"		
	case else
		messagebox("???","Module not selected")
		return -1
end choose

ic = dw_1.rowcount()

if ic < 1 then return -1

for i = 1 to ic 
	if dw_1.getitemnumber(i,"selected") = 1 then
		c++
		li_id[c] = dw_1.getitemnumber(i,ls_field)
	end if
next

If c = 0 then
	messagebox("Extract","No Items selected.")
	return -1
end if

lds_head = create datastore
lds_2 = create datastore

choose case is_mod
	case "E"
		//create datastores
		lds_3 = create datastore
		lds_head.dataobject = ""
		lds_head.settransobject(sqlca)
		lds_2.dataobject = ""
		lds_2.settransobject(sqlca)
		lds_3.dataobject = ""
		lds_3.settransobject(sqlca)
		
		//retrieve data
		lds_head.retrieve(li_id)
		lds_2.retrieve(li_id)
		lds_3.retrieve(li_id)

//get save directory
		ls_path = ""
		//save data
		lds_head.saveas(ls_path + "exp_hdr" + ls_today, text!, TRUE)
		lds_head.saveas(ls_path + "exp_file2" + ls_today, text!, TRUE)
	case "I"
		
	case "W"
		
end choose


return 1
end function

on w_data_migration.create
this.cb_2=create cb_2
this.cb_run=create cb_run
this.st_2=create st_2
this.rb_exp=create rb_exp
this.rb_imp=create rb_imp
this.dw_1=create dw_1
this.st_1=create st_1
this.ddlb_type=create ddlb_type
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_run,&
this.st_2,&
this.rb_exp,&
this.rb_imp,&
this.dw_1,&
this.st_1,&
this.ddlb_type,&
this.gb_1}
end on

on w_data_migration.destroy
destroy(this.cb_2)
destroy(this.cb_run)
destroy(this.st_2)
destroy(this.rb_exp)
destroy(this.rb_imp)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.ddlb_type)
destroy(this.gb_1)
end on

event open;this.height = 550
end event

type cb_2 from commandbutton within w_data_migration
integer x = 759
integer y = 48
integer width = 343
integer height = 92
integer taborder = 50
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

type cb_run from commandbutton within w_data_migration
integer x = 398
integer y = 48
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Run"
end type

event clicked;
if is_type = "I" then
	of_import( )
elseif is_type = "E" then
	of_export()
end if
	

end event

type st_2 from statictext within w_data_migration
integer x = 55
integer y = 188
integer width = 343
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select Module"
boolean focusrectangle = false
end type

type rb_exp from radiobutton within w_data_migration
integer x = 809
integer y = 256
integer width = 270
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Extract"
end type

event clicked;is_type = "E"
ib_set = true
parent.height = 2300
of_after_change( )
end event

type rb_imp from radiobutton within w_data_migration
integer x = 526
integer y = 252
integer width = 270
integer height = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Import"
end type

event clicked;is_type = "I"
ib_set = true
parent.height = 564
of_after_change( )
end event

type dw_1 from datawindow within w_data_migration
integer x = 59
integer y = 520
integer width = 1051
integer height = 1384
integer taborder = 20
string title = "none"
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_data_migration
integer x = 82
integer y = 1932
integer width = 1019
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 134217856
long backcolor = 33551856
string text = "Select the Items you wish to export."
boolean focusrectangle = false
end type

type ddlb_type from dropdownlistbox within w_data_migration
integer x = 41
integer y = 264
integer width = 411
integer height = 372
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string item[] = {"Export","Import","WorkFlow"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;choose case index
	case 1//exp
		is_mod = "E"
		dw_1.dataobject = ""
	case 2//imp
		is_mod = "I"
		dw_1.dataobject = ""
	case 3//workflow
		is_mod = "W"
		dw_1.dataobject = ""
end choose

of_after_change( )
end event

type gb_1 from groupbox within w_data_migration
integer x = 489
integer y = 188
integer width = 622
integer height = 180
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Action Type"
end type

