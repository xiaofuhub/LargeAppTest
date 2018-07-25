$PBExportHeader$w_cvo_missing_data_utility.srw
forward
global type w_cvo_missing_data_utility from window
end type
type cb_about from commandbutton within w_cvo_missing_data_utility
end type
type dw_data from u_dw within w_cvo_missing_data_utility
end type
type cb_filter from commandbutton within w_cvo_missing_data_utility
end type
type cb_open from commandbutton within w_cvo_missing_data_utility
end type
type cb_close from commandbutton within w_cvo_missing_data_utility
end type
end forward

global type w_cvo_missing_data_utility from window
integer width = 3502
integer height = 2152
boolean titlebar = true
string title = "Missing PSV Records"
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_about cb_about
dw_data dw_data
cb_filter cb_filter
cb_open cb_open
cb_close cb_close
end type
global w_cvo_missing_data_utility w_cvo_missing_data_utility

event open;dw_data.retrieve()
end event

on w_cvo_missing_data_utility.create
this.cb_about=create cb_about
this.dw_data=create dw_data
this.cb_filter=create cb_filter
this.cb_open=create cb_open
this.cb_close=create cb_close
this.Control[]={this.cb_about,&
this.dw_data,&
this.cb_filter,&
this.cb_open,&
this.cb_close}
end on

on w_cvo_missing_data_utility.destroy
destroy(this.cb_about)
destroy(this.dw_data)
destroy(this.cb_filter)
destroy(this.cb_open)
destroy(this.cb_close)
end on

type cb_about from commandbutton within w_cvo_missing_data_utility
integer x = 2025
integer y = 36
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("About","This screen displays Appointment records where the Close Date is not completed, and show if there has been a PSV tracking record that has been created.  Tracking records can be created by opening the individual files.")
end event

type dw_data from u_dw within w_cvo_missing_data_utility
integer x = 37
integer y = 172
integer width = 3406
integer height = 1828
integer taborder = 20
string dataobject = "d_cvo_pracs_no_record"
end type

event clicked;call super::clicked;long r

r = this.getclickedrow()
this.setrow(r)
end event

event rowfocuschanged;call super::rowfocuschanged;this.selectrow(0,false)
this.selectrow(currentrow,true)
end event

event constructor;call super::constructor;this.settransobject(sqlca)
end event

event doubleclicked;call super::doubleclicked;cb_open.triggerevent(clicked!)
end event

type cb_filter from commandbutton within w_cvo_missing_data_utility
integer x = 2377
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;dw_data.retrieve()
end event

type cb_open from commandbutton within w_cvo_missing_data_utility
integer x = 2729
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Open File"
end type

event clicked;long li_prac
long li_rec
long li_fac
long li_ver
integer r
gs_variable_array la_ids

r = dw_data.getrow()
//r = this.tab_1.tab  
li_prac = dw_data.getitemnumber(r,"prac_id")
li_rec = dw_data.getitemnumber(r,"rec_id")
li_fac = dw_data.getitemnumber(r,"pd_affil_stat_parent_facility_id")
li_ver = dw_data.getitemnumber(r,"verifying_facility")

la_ids.as_number[1] = li_prac
la_ids.as_number[2] = li_rec
la_ids.as_number[3] = li_fac
la_ids.as_number[4] = li_ver


openwithparm(w_cvo_screen,la_ids)

end event

type cb_close from commandbutton within w_cvo_missing_data_utility
integer x = 3086
integer y = 36
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

