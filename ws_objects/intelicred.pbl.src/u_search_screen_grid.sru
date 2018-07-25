$PBExportHeader$u_search_screen_grid.sru
forward
global type u_search_screen_grid from userobject
end type
type st_1 from statictext within u_search_screen_grid
end type
type rb_act from radiobutton within u_search_screen_grid
end type
type rb_stat from radiobutton within u_search_screen_grid
end type
type dw_data from datawindow within u_search_screen_grid
end type
type gb_1 from groupbox within u_search_screen_grid
end type
end forward

global type u_search_screen_grid from userobject
integer width = 1417
integer height = 1720
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
rb_act rb_act
rb_stat rb_stat
dw_data dw_data
gb_1 gb_1
end type
global u_search_screen_grid u_search_screen_grid

type variables
long il_prac
long il_facility
long il_appt_rec
string is_type = "Actions"

w_prac_data_1 iw_prac_data
end variables

forward prototypes
public function integer of_set_dw ()
public function integer of_retrieve_data ()
public subroutine of_resize ()
public function integer of_go_missing (string as_type)
public function integer of_go_appl (long al_type)
public function integer of_go_verif (long al_type)
public function integer of_set_parent (w_prac_data_1 aw_prac)
public function integer of_goto_apps (long al_fac, long al_loc, long al_app)
end prototypes

public function integer of_set_dw (); //Start Code Change ----06.01.2015 #V15 maha
choose case is_type
	case "Links"
		//dw_data.dataobject = "d_tv_smokey"
		//dw_data.dataobject = "d_rpt_entity_relations_tv"
		dw_data.dataobject = "d_net_dev_tv_w_loc"
		st_1.text = "Double-click to access actions"
	case "Actions"
		if gs_cust_type = "I" then 	//Start Code Change ----03.29.2016 #V15 maha - added app variation
			dw_data.dataobject = "d_search_prac_tasks_app"
		else
			dw_data.dataobject = "d_search_prac_tasks"
		end if
		st_1.text = "Click GO to access actions"
end choose

dw_data.settransobject(sqlca)
of_retrieve_data()

dw_data.Modify("DataWindow.Zoom=" + string(gi_zoom)) //Start Code Change ----07.13.2017 #V154 maha - added for font increase

return 1

end function

public function integer of_retrieve_data (); //Start Code Change ----06.01.2015 #V15 maha - created
 
if is_type = "Links" then 
	dw_data.retrieve(il_prac, gs_user_id)
	 dw_data.expandall( )	
else
	dw_data.retrieve(il_prac, il_facility, il_appt_rec)
end if


return 1
end function

public subroutine of_resize (); //Start Code Change ----06.01.2015 #V15 maha
 //216 = the radio buttons; 20 = bottom space
dw_data.height = this.height - 216 - 20
end subroutine

public function integer of_go_missing (string as_type);//messagebox("Missing",as_type)
iw_prac_data.tab_1.selecttab(3)
iw_prac_data.tab_1.tabpage_app_audit.uo_app_audit.event pfc_cst_compose_request( )

return 1
end function

public function integer of_go_appl (long al_type);//messagebox("Apps",al_type)
iw_prac_data.tab_1.selecttab(9)
message.doubleparm = al_type
iw_prac_data.tab_1.tabpage_net.uo_net.postevent("ue_filter_from_grid", al_type,  al_type) 
//aw_prac_data.

return 1
end function

public function integer of_go_verif (long al_type);String ls_filter = ''
//messagebox("Verif",al_type)
iw_prac_data.tab_1.selecttab(5)

iw_prac_data.tab_1.tabpage_verif.uo_verif_summary.of_filter_defaults( false)  //Start Code Change ----01.04.2016 #V15 maha - added
//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 12.23.2015
//<$>reason:add active_status = 1, for BugL122102.
//iw_prac_data.tab_1.tabpage_verif.uo_verif_summary.dw_detail.setfilter("verification_method =" + string(al_type) +  " and isnull(response_code)")
ls_filter = "verification_method =" + string(al_type) +  " and isnull(response_code) and active_status = 1"
iw_prac_data.tab_1.tabpage_verif.uo_verif_summary.dw_detail.setfilter(ls_filter)
//------------------- APPEON END -------------------
iw_prac_data.tab_1.tabpage_verif.uo_verif_summary.dw_detail.filter()




return 1
end function

public function integer of_set_parent (w_prac_data_1 aw_prac);iw_prac_data = aw_prac

return 1
end function

public function integer of_goto_apps (long al_fac, long al_loc, long al_app); //Start Code Change ----08.25.2015 #V15 maha
 

iw_prac_data.tab_1.selecttab(9)

iw_prac_data.tab_1.tabpage_net.uo_net.of_goto_app( al_fac, al_loc, al_app )
 
 
 return 1
end function

on u_search_screen_grid.create
this.st_1=create st_1
this.rb_act=create rb_act
this.rb_stat=create rb_stat
this.dw_data=create dw_data
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.rb_act,&
this.rb_stat,&
this.dw_data,&
this.gb_1}
end on

on u_search_screen_grid.destroy
destroy(this.st_1)
destroy(this.rb_act)
destroy(this.rb_stat)
destroy(this.dw_data)
destroy(this.gb_1)
end on

type st_1 from statictext within u_search_screen_grid
integer x = 270
integer y = 20
integer width = 818
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
string text = "Click GO to access actions"
boolean focusrectangle = false
end type

type rb_act from radiobutton within u_search_screen_grid
integer x = 782
integer y = 132
integer width = 297
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Actions"
boolean checked = true
boolean automatic = false
end type

event clicked;is_type = "Actions"
this.checked = true
rb_stat.checked = false
of_set_dw()
end event

type rb_stat from radiobutton within u_search_screen_grid
integer x = 151
integer y = 132
integer width = 526
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "Enrollment Status"
boolean automatic = false
end type

event clicked;is_type = "Links"
this.checked = true
rb_act.checked = false
of_set_dw()
end event

type dw_data from datawindow within u_search_screen_grid
integer x = 14
integer y = 216
integer width = 1394
integer height = 1496
integer taborder = 10
string title = "none"
string dataobject = "d_search_prac_tasks"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;if gs_cust_type = "I" then this.dataobject = "d_search_prac_tasks_app"  //Start Code Change ----03.29.2016 #V15 maha
this.settransobject( sqlca)
end event

event buttonclicked;
string ls_from
string ls_type
long ll_type

if dwo.name = "b_go" then
	ls_from = this.getitemstring(row,"loc_from")
	ls_type = this.getitemstring(row,"code_lookup_task_type")
	ll_type = this.getitemnumber(row,"action_type")
	choose case ls_from
		case "A"
			of_go_appl(ll_type)
		case "C"
			of_go_missing("")
		case "V"
			of_go_verif(ll_type)
			
	end choose
			
end if
	
end event

event doubleclicked; //Start Code Change ----08.25.2015 #V15 maha - copied from buttonclicked
string ls_from
string ls_type
long ll_type
long ll_facil
long ll_loc
long ll_app

If row < 1 Then Return //Added by Appeon long.zhang 12.14.2015 (BugL120103)
//messagebox("", row)

if rb_act.checked then
	ls_from = this.getitemstring(row,"loc_from")
	ls_type = this.getitemstring(row,"code_lookup_task_type")
	ll_type = this.getitemnumber(row,"action_type")
	choose case ls_from
		case "A"
			of_go_appl(ll_type)
		case "C"
			of_go_missing("")
		case "V"
			of_go_verif(ll_type)
	end choose
else //enrollment
	ll_facil = this.getitemnumber(row,"parent_facility_id")
	ll_loc = this.getitemnumber(row,"gp_id")
	ll_app = this.getitemnumber(row,"app_id")
	of_goto_apps( ll_facil, ll_loc, ll_app)		
end if


end event

type gb_1 from groupbox within u_search_screen_grid
integer x = 9
integer y = 84
integer width = 1399
integer height = 124
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 16777215
string text = "View"
end type

