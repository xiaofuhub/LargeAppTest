$PBExportHeader$w_pracview_priv_mockup.srw
forward
global type w_pracview_priv_mockup from window
end type
type st_3 from statictext within w_pracview_priv_mockup
end type
type st_2 from statictext within w_pracview_priv_mockup
end type
type st_1 from statictext within w_pracview_priv_mockup
end type
type cb_3 from commandbutton within w_pracview_priv_mockup
end type
type cb_2 from commandbutton within w_pracview_priv_mockup
end type
type cb_1 from commandbutton within w_pracview_priv_mockup
end type
type dw_prac from datawindow within w_pracview_priv_mockup
end type
type cb_close from commandbutton within w_pracview_priv_mockup
end type
type dw_priv from datawindow within w_pracview_priv_mockup
end type
end forward

global type w_pracview_priv_mockup from window
integer width = 3493
integer height = 2200
boolean titlebar = true
string title = "pracview Mockup"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 16777215
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_2 st_2
st_1 st_1
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_prac dw_prac
cb_close cb_close
dw_priv dw_priv
end type
global w_pracview_priv_mockup w_pracview_priv_mockup

forward prototypes
public function integer of_set_status ()
public function integer of_filter (string as_type)
end prototypes

public function integer of_set_status ();integer p
integer pc
integer r
integer rc
integer li_find
long pid
string s

debugbreak()
pc = dw_prac.rowcount()
rc = dw_priv.rowcount()

for p = 1 to pc
	pid = dw_prac.getitemnumber(p,"procd_id")
	s = dw_prac.getitemstring(p,"code_lookup_code")
	
	li_find = dw_priv.find( "procd_id = " + string(pid), 1, rc)
	
	if li_find > 0 then
		if s = "REQST" then
			dw_priv.setitem(li_find,"req", 1)
			dw_priv.setitem(li_find,"selected", 1)
		else
			dw_priv.setitem(li_find,"status", s)
			dw_priv.setitem(li_find,"curr", 1)
		end if
	end if
next

return 1
end function

public function integer of_filter (string as_type);
string ls_filter

choose case as_type
	case "A"
		ls_filter = ""
	case "C"
		ls_filter = "curr = 1"
	case "R"
		ls_filter = "selected = 1"
end choose

dw_priv.setfilter(ls_filter)
dw_priv.filter()

return 1
		
end function

on w_pracview_priv_mockup.create
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_prac=create dw_prac
this.cb_close=create cb_close
this.dw_priv=create dw_priv
this.Control[]={this.st_3,&
this.st_2,&
this.st_1,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_prac,&
this.cb_close,&
this.dw_priv}
end on

on w_pracview_priv_mockup.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_prac)
destroy(this.cb_close)
destroy(this.dw_priv)
end on

event open;gs_pass_ids lst_ids
long ll_prac
long  ll_facil
long ll_ca


lst_ids = message.powerobjectparm
ll_prac = lst_ids.i_ids[1]
ll_facil = lst_ids.i_ids[2]
ll_ca = lst_ids.i_ids[3]


//dw_prac.settransobject(sqlca)
dw_priv.settransobject(sqlca)

//dw_prac.retrieve(ll_prac, ll_facil)
dw_priv.retrieve(ll_ca, ll_prac, ll_facil)

//of_set_status( )



end event

type st_3 from statictext within w_pracview_priv_mockup
integer x = 55
integer y = 552
integer width = 402
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "All"
boolean focusrectangle = false
end type

event clicked;of_filter("A")
end event

type st_2 from statictext within w_pracview_priv_mockup
integer x = 55
integer y = 624
integer width = 425
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Current Privileges"
boolean focusrectangle = false
end type

event clicked;of_filter("C")
end event

type st_1 from statictext within w_pracview_priv_mockup
integer x = 55
integer y = 700
integer width = 498
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean underline = true
long textcolor = 16711680
long backcolor = 16777215
string text = "Requested Privileges"
boolean focusrectangle = false
end type

event clicked;of_filter("R")
end event

type cb_3 from commandbutton within w_pracview_priv_mockup
integer x = 18
integer y = 340
integer width = 658
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

type cb_2 from commandbutton within w_pracview_priv_mockup
integer x = 18
integer y = 232
integer width = 658
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Add Additional Privileges"
end type

event clicked;of_filter("C")
end event

type cb_1 from commandbutton within w_pracview_priv_mockup
integer x = 18
integer y = 124
integer width = 658
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Request Completed"
end type

type dw_prac from datawindow within w_pracview_priv_mockup
boolean visible = false
integer x = 585
integer y = 8
integer width = 229
integer height = 92
integer taborder = 20
string title = "none"
string dataobject = "d_priv_brow_clin_area"
boolean livescroll = true
end type

type cb_close from commandbutton within w_pracview_priv_mockup
integer x = 2766
integer y = 8
integer width = 402
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

type dw_priv from datawindow within w_pracview_priv_mockup
integer x = 690
integer y = 124
integer width = 2775
integer height = 1984
integer taborder = 10
string title = "none"
string dataobject = "d_priv_wv_mockup3"
boolean vscrollbar = true
boolean livescroll = true
end type

