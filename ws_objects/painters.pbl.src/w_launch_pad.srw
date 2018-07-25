$PBExportHeader$w_launch_pad.srw
forward
global type w_launch_pad from window
end type
type cb_help from commandbutton within w_launch_pad
end type
type p_1 from picture within w_launch_pad
end type
type cb_save from commandbutton within w_launch_pad
end type
type p_rocket from picture within w_launch_pad
end type
type p_4 from picture within w_launch_pad
end type
type p_bird from picture within w_launch_pad
end type
type dw_help from datawindow within w_launch_pad
end type
type cb_close from commandbutton within w_launch_pad
end type
type dw_launch from datawindow within w_launch_pad
end type
type p_fly from picture within w_launch_pad
end type
end forward

global type w_launch_pad from window
integer width = 3342
integer height = 2296
boolean titlebar = true
string title = "Setup Launch Pad"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_help cb_help
p_1 p_1
cb_save cb_save
p_rocket p_rocket
p_4 p_4
p_bird p_bird
dw_help dw_help
cb_close cb_close
dw_launch dw_launch
p_fly p_fly
end type
global w_launch_pad w_launch_pad

forward prototypes
public function integer of_rocket ()
public function integer of_bird ()
public function integer of_window ()
end prototypes

public function integer of_rocket ();long i
long lx
long ly
long orgx
long orgy
long yyy

//lx = p_rocket.x
//ly = p_rocket.y
//orgx = lx
//orgy = ly
////yyy = long(sle_y.text)
//
//p_rocket.visible = true
//debugbreak()
////for i = 1 to 3500000
////	if mod(i,10000) = 0 then
////		lx += 10
////		ly -= 7
////		p_rocket.x = lx
////		p_rocket.y = ly
////		yield()
////	end if
////next
//for i = 1 to 3500
//	//if mod(i,10) = 0 then
//		lx += 10
//		ly -= 10
//	//	lx += 10
//	//	ly -= 12
//		p_rocket.x = lx
//		p_rocket.y = ly
//		yield()
//	//end if
//next
//	
//p_rocket.visible = false
//p_rocket.x = orgx
//p_rocket.y = orgy

	
return 1
end function

public function integer of_bird ();integer i
long lx
long ly
long orgx
long orgy

//lx = p_bird.x
//ly = p_bird.y
//orgx = lx
//orgy = ly
//
//p_bird.visible = true
//
//for i = 1 to 350
//	lx -= 10
//	ly -= 5
//	p_bird.x = lx
//	p_bird.y = ly
//	yield()
//next
//	
//p_bird.visible = false
//p_bird.x = orgx
//p_bird.y = orgy

	
return 1
end function

public function integer of_window ();
integer li_id

li_id = dw_launch.getitemnumber(dw_launch.getrow(),"process_id")

choose case li_id
	case 1
		open(w_security_roles_painter)
	case 2
		//---------Begin Modified by (Appeon)Eugene 06.20.2013 for V141 ISG-CLX--------
		//open(w_security_user_painter)
		If gb_contract_version Then
			Open(w_security_user_painter_ctx)
		Else
			Open(w_security_user_painter)
		End If
		//---------End Modfiied ------------------------------------------------------
	case 3
		open(w_data_views_manager)
	case 4
		OpenSheet(w_prac_data_design, w_mdi, 6, Original!)
	case 5
		open(w_email_painter)
	case 6
		open(w_app_audit_setup)
	case 7
		open(w_app_audit_setup)
	case 8
		if gs_cust_type = 'I' then  //Start Code Change ----05.23.2011 #V11 maha - added trap for app customers
			open(w_facility_setup_intelliapp)
		else
			open(w_facility_setup)
		end if
	case 9
		open(w_image_type_painter)
	case 10
		open(w_area_painter)
	case 11
		open(w_letter_painter)
	case 12
		open(w_group_practice)
	case 13
		Open( w_lookup_maint )
	case 14
		Open( w_exp_letter_painter )
	case 15
		Open(w_image_type_painter )
	case 16
		Open( w_profile_view_manager )
	case 17
		open(w_question_painter)
	case 18
		OpenSheet(w_todolist_painter, w_mdi, 6, Original!)
	case 19  //Start Code Change ----12.13.2010 #V10 maha - for SK
		open(w_fax_template_painter)	
	case 20  //Start Code Change ----12.13.2010 #V10 maha - for SK
		Open( w_profile_view_manager )
	case 21  //Start Code Change ----12.13.2010 #V10 maha - for SK
		OpenSheet(w_prac_report_design, w_mdi, 4, original!)	
end choose

return 1
	
end function

on w_launch_pad.create
this.cb_help=create cb_help
this.p_1=create p_1
this.cb_save=create cb_save
this.p_rocket=create p_rocket
this.p_4=create p_4
this.p_bird=create p_bird
this.dw_help=create dw_help
this.cb_close=create cb_close
this.dw_launch=create dw_launch
this.p_fly=create p_fly
this.Control[]={this.cb_help,&
this.p_1,&
this.cb_save,&
this.p_rocket,&
this.p_4,&
this.p_bird,&
this.dw_help,&
this.cb_close,&
this.dw_launch,&
this.p_fly}
end on

on w_launch_pad.destroy
destroy(this.cb_help)
destroy(this.p_1)
destroy(this.cb_save)
destroy(this.p_rocket)
destroy(this.p_4)
destroy(this.p_bird)
destroy(this.dw_help)
destroy(this.cb_close)
destroy(this.dw_launch)
destroy(this.p_fly)
end on

event open;string ls_filter

dw_launch.settransobject(sqlca)
dw_launch.retrieve()

dw_help.settransobject(sqlca)
dw_launch.sharedata( dw_help)

//Start Code Change ----07.06.2010 #V10 maha - added for SK
//if gs_cust_type = "I" then
//	ls_filter = "isg_program = 'B' or isg_program = 'A'"
//else
//	ls_filter = "isg_program = 'B' or isg_program = 'C'"
//end if



//E=  All
//B = Both Cred and App
//C = Cred
//A= App
//K = SK

if gb_sk_ver then
	ls_filter = " isg_program = 'E' or isg_program = 'A' or isg_program = 'K' "
elseif gs_cust_type = "I" then
	ls_filter = "isg_program = 'B' or isg_program = 'A'  or isg_program = 'E' "
else
	ls_filter =  "isg_program = 'B' or isg_program = 'E'  or isg_program = 'C' "
end if
//End Code Change ----07.06.2010

dw_launch.setfilter(ls_filter)
dw_launch.filter()
		
end event

type cb_help from commandbutton within w_launch_pad
integer x = 2181
integer y = 16
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Help"
end type

event clicked;of_help_open("Launch Pad")
end event

type p_1 from picture within w_launch_pad
boolean visible = false
integer x = 3593
integer y = 260
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Custom035!"
boolean focusrectangle = false
end type

type cb_save from commandbutton within w_launch_pad
integer x = 2555
integer y = 16
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_launch.update()
dw_help.update()
end event

type p_rocket from picture within w_launch_pad
boolean visible = false
integer x = 3707
integer y = 100
integer width = 101
integer height = 88
string picturename = "rocket3.bmp"
boolean focusrectangle = false
end type

type p_4 from picture within w_launch_pad
boolean visible = false
integer x = 3621
integer y = 596
integer width = 306
integer height = 92
string picturename = "rocket1.bmp"
boolean focusrectangle = false
end type

type p_bird from picture within w_launch_pad
boolean visible = false
integer x = 3881
integer y = 96
integer width = 78
integer height = 84
string picturename = "phoenix2.bmp"
boolean focusrectangle = false
end type

type dw_help from datawindow within w_launch_pad
integer x = 23
integer y = 1452
integer width = 3241
integer height = 696
integer taborder = 20
string title = "none"
string dataobject = "d_launch_pad_info"
boolean livescroll = true
end type

type cb_close from commandbutton within w_launch_pad
integer x = 2921
integer y = 16
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

type dw_launch from datawindow within w_launch_pad
integer x = 23
integer y = 128
integer width = 3246
integer height = 1304
integer taborder = 10
string title = "none"
string dataobject = "d_launch_pad_list"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;this.setrow(row)
//of_rocket()
//of_bird()
of_window()

end event

event clicked;integer r


r = this.getclickedrow()
if r < 1 then return
this.setrow(r)
end event

event rowfocuschanged;dw_help.scrolltorow(currentrow)
end event

event constructor;this.setrowfocusindicator( p_1)
end event

event itemchanged;datetime ldt_now

if this.getcolumnname() = "launch_status" then
	if data = "C" then
		ldt_now = datetime(today(),now())
		this.setitem(  row, "compl_date", ldt_now )
		this.setitem(  row, "compl_by", gs_user_id )
	end if
end if
end event

type p_fly from picture within w_launch_pad
boolean visible = false
integer x = 3616
integer y = 404
integer width = 142
integer height = 80
boolean bringtotop = true
string picturename = "Custom061!"
boolean focusrectangle = false
end type

