$PBExportHeader$w_additional_filters_ai.srw
forward
global type w_additional_filters_ai from window
end type
type st_9 from statictext within w_additional_filters_ai
end type
type r_2 from rectangle within w_additional_filters_ai
end type
type st_8 from statictext within w_additional_filters_ai
end type
type cb_v3 from commandbutton within w_additional_filters_ai
end type
type cb_v2 from commandbutton within w_additional_filters_ai
end type
type cb_v1 from commandbutton within w_additional_filters_ai
end type
type r_1 from rectangle within w_additional_filters_ai
end type
type st_status from statictext within w_additional_filters_ai
end type
type st_batch from statictext within w_additional_filters_ai
end type
type st_screen from statictext within w_additional_filters_ai
end type
type st_6 from statictext within w_additional_filters_ai
end type
type st_5 from statictext within w_additional_filters_ai
end type
type st_4 from statictext within w_additional_filters_ai
end type
type st_3 from statictext within w_additional_filters_ai
end type
type st_1 from statictext within w_additional_filters_ai
end type
type ddlb_1 from dropdownlistbox within w_additional_filters_ai
end type
type cb_about from commandbutton within w_additional_filters_ai
end type
type dw_scr from datawindow within w_additional_filters_ai
end type
type cb_clear_all from commandbutton within w_additional_filters_ai
end type
type st_2 from statictext within w_additional_filters_ai
end type
type cb_2 from commandbutton within w_additional_filters_ai
end type
type cb_single from commandbutton within w_additional_filters_ai
end type
type dw_bat from datawindow within w_additional_filters_ai
end type
type rr_ir from roundrectangle within w_additional_filters_ai
end type
type rr_s from roundrectangle within w_additional_filters_ai
end type
type rr_p from roundrectangle within w_additional_filters_ai
end type
type rr_green from roundrectangle within w_additional_filters_ai
end type
type rr_red from roundrectangle within w_additional_filters_ai
end type
end forward

shared variables

end variables

global type w_additional_filters_ai from window
integer x = 1138
integer y = 772
integer width = 1687
integer height = 1096
boolean titlebar = true
string title = "Additional Filter Status"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
st_9 st_9
r_2 r_2
st_8 st_8
cb_v3 cb_v3
cb_v2 cb_v2
cb_v1 cb_v1
r_1 r_1
st_status st_status
st_batch st_batch
st_screen st_screen
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_1 st_1
ddlb_1 ddlb_1
cb_about cb_about
dw_scr dw_scr
cb_clear_all cb_clear_all
st_2 st_2
cb_2 cb_2
cb_single cb_single
dw_bat dw_bat
rr_ir rr_ir
rr_s rr_s
rr_p rr_p
rr_green rr_green
rr_red rr_red
end type
global w_additional_filters_ai w_additional_filters_ai

type variables
integer ii_screen
string is_ir_fil = ""
string is_screen_fil = ""
string is_prac_fil = ""

boolean ib_prac = False
boolean ib_ir = False
boolean ib_screen = False

w_action_items is_win
end variables

on w_additional_filters_ai.create
this.st_9=create st_9
this.r_2=create r_2
this.st_8=create st_8
this.cb_v3=create cb_v3
this.cb_v2=create cb_v2
this.cb_v1=create cb_v1
this.r_1=create r_1
this.st_status=create st_status
this.st_batch=create st_batch
this.st_screen=create st_screen
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_1=create st_1
this.ddlb_1=create ddlb_1
this.cb_about=create cb_about
this.dw_scr=create dw_scr
this.cb_clear_all=create cb_clear_all
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_single=create cb_single
this.dw_bat=create dw_bat
this.rr_ir=create rr_ir
this.rr_s=create rr_s
this.rr_p=create rr_p
this.rr_green=create rr_green
this.rr_red=create rr_red
this.Control[]={this.st_9,&
this.r_2,&
this.st_8,&
this.cb_v3,&
this.cb_v2,&
this.cb_v1,&
this.r_1,&
this.st_status,&
this.st_batch,&
this.st_screen,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_1,&
this.ddlb_1,&
this.cb_about,&
this.dw_scr,&
this.cb_clear_all,&
this.st_2,&
this.cb_2,&
this.cb_single,&
this.dw_bat,&
this.rr_ir,&
this.rr_s,&
this.rr_p,&
this.rr_green,&
this.rr_red}
end on

on w_additional_filters_ai.destroy
destroy(this.st_9)
destroy(this.r_2)
destroy(this.st_8)
destroy(this.cb_v3)
destroy(this.cb_v2)
destroy(this.cb_v1)
destroy(this.r_1)
destroy(this.st_status)
destroy(this.st_batch)
destroy(this.st_screen)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.ddlb_1)
destroy(this.cb_about)
destroy(this.dw_scr)
destroy(this.cb_clear_all)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_single)
destroy(this.dw_bat)
destroy(this.rr_ir)
destroy(this.rr_s)
destroy(this.rr_p)
destroy(this.rr_green)
destroy(this.rr_red)
end on

event open;if isvalid(w_action_items) then
	is_win = w_action_items
elseif isvalid(w_action_items_ia) then
	is_win = w_action_items_ia
end if
dw_bat.settransobject(sqlca)
dw_bat.retrieve()
dw_bat.insertrow(1)
dw_scr.settransobject(sqlca)
dw_scr.retrieve()
dw_scr.insertrow(1)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2008 By: Evan
//$<reason> Fix BugJ122701 about work Flow should not be listed as an option.
long ll_Find
DataWindowChild ldwc_Child
dw_scr.GetChild("screen_id", ldwc_Child)
ll_Find = ldwc_Child.Find("screen_id=-10", 1, ldwc_Child.RowCount())
if ll_Find > 0 then ldwc_Child.DeleteRow(ll_Find)
//---------------------------- APPEON END ----------------------------
st_screen.text = gs_fil_screen
st_status.text = gs_fil_status
st_batch.text = gs_fil_batch
is_prac_fil = is_win.is_batch_filter
is_screen_fil = is_win.is_screen_filter
is_ir_fil = is_win.is_ir_filter

if LenA(is_prac_fil) > 0 then
	rr_p.fillcolor = RGB(0,255,0)  //green;  .fillcolor = RGB(255,0,0) = red
end if

if LenA(is_ir_fil) > 0 then
	rr_ir.fillcolor = RGB(0,255,0)  //green;  .fillcolor = RGB(255,0,0) = red
end if

if LenA(is_screen_fil) > 0 then
	rr_s.fillcolor = RGB(0,255,0)  //8453888  //green;  .fillcolor = RGB(255,0,0) = red
end if



end event

type st_9 from statictext within w_additional_filters_ai
integer x = 105
integer y = 124
integer width = 155
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Filters:"
boolean focusrectangle = false
end type

type r_2 from rectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 33551856
integer x = 41
integer y = 148
integer width = 1573
integer height = 588
end type

type st_8 from statictext within w_additional_filters_ai
integer x = 69
integer y = 176
integer width = 357
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Current Status"
boolean focusrectangle = false
end type

type cb_v3 from commandbutton within w_additional_filters_ai
integer x = 1275
integer y = 588
integer width = 265
integer height = 68
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Filter"
end type

event clicked;string ls_filt

ls_filt = is_prac_fil

messagebox("Batch List Filter",ls_filt)
end event

type cb_v2 from commandbutton within w_additional_filters_ai
integer x = 1271
integer y = 420
integer width = 265
integer height = 68
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Filter"
end type

event clicked;string ls_filt

ls_filt = is_screen_fil

messagebox("Screen Filter",ls_filt)
end event

type cb_v1 from commandbutton within w_additional_filters_ai
integer x = 1271
integer y = 252
integer width = 265
integer height = 68
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View Filter"
end type

event clicked;string ls_filt

ls_filt = is_ir_fil

messagebox("Init/Recred Filter",ls_filt)
end event

type r_1 from rectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 33551856
integer x = 503
integer y = 784
integer width = 585
integer height = 156
end type

type st_status from statictext within w_additional_filters_ai
integer x = 960
integer y = 180
integer width = 334
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_batch from statictext within w_additional_filters_ai
integer x = 960
integer y = 516
integer width = 581
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_screen from statictext within w_additional_filters_ai
integer x = 960
integer y = 344
integer width = 613
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean enabled = false
boolean focusrectangle = false
end type

type st_6 from statictext within w_additional_filters_ai
integer x = 951
integer y = 836
integer width = 110
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Set"
boolean focusrectangle = false
end type

type st_5 from statictext within w_additional_filters_ai
integer x = 658
integer y = 836
integer width = 137
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "None"
boolean focusrectangle = false
end type

type st_4 from statictext within w_additional_filters_ai
integer x = 581
integer y = 760
integer width = 306
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
boolean enabled = false
string text = "Filter Status:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_additional_filters_ai
integer x = 443
integer y = 176
integer width = 489
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Appointment Status"
boolean focusrectangle = false
end type

type st_1 from statictext within w_additional_filters_ai
integer x = 443
integer y = 344
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "Data Screen"
boolean focusrectangle = false
end type

type ddlb_1 from dropdownlistbox within w_additional_filters_ai
integer x = 416
integer y = 244
integer width = 841
integer height = 304
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Initial","Recredential","All"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;ib_ir = true

if index = 1 then
	is_ir_fil = "apptmnt_type = 'I'" 
	rr_ir.fillcolor = RGB(0,255,0)
	gs_fil_status = "Initial"
	st_status.text = gs_fil_status
elseif index = 2 then
	is_ir_fil = "apptmnt_type = 'R'"
	rr_ir.fillcolor = RGB(0,255,0)
	gs_fil_status = "Recred"
	st_status.text = gs_fil_status
else
	rr_ir.fillcolor = RGB(255,0,0)
	is_ir_fil = ""
	gs_fil_status = ""
	st_status.text = gs_fil_status
end if


// len(w_action_items.is_ir_filter) > 0 then
//	rr_ir.fillcolor = 8453888  //green;  .fillcolor = RGB(255,0,0) = red

end event

type cb_about from commandbutton within w_additional_filters_ai
boolean visible = false
integer x = 1646
integer y = 752
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "About"
end type

event clicked;messagebox("About Addtl Filters","These filters work differently than the Facility and User filters which . . .")
end event

type dw_scr from datawindow within w_additional_filters_ai
integer x = 411
integer y = 400
integer width = 846
integer height = 84
integer taborder = 60
string dataobject = "d_select_screen_name"
boolean border = false
boolean livescroll = true
end type

event itemchanged;datawindowchild dwchild
integer r
//sle_1.text = "test"
//ss_screen = sle_1.text

ii_screen = integer(data)


if ii_screen < 1 then
	rr_s.fillcolor = RGB(255,0,0)
	is_screen_fil = ""
else
	is_screen_fil = "screen_id = " + string(ii_screen)
	rr_s.fillcolor = RGB(0,255,0)
	this.getchild("screen_id",dwchild)
	r = dwchild.find("screen_id = " + string(ii_screen),1,dwchild.rowcount())
	if r > 1 then
		gs_fil_screen = dwchild.getitemstring(r,"screen_name")
		st_screen.text = gs_fil_screen
	end if
end if
	
ib_screen = true

end event

type cb_clear_all from commandbutton within w_additional_filters_ai
integer x = 782
integer y = 28
integer width = 247
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear All"
end type

event clicked;is_prac_fil = ""
//rr_p.fillcolor = 8453888  //green;  .fillcolor = RGB(255,0,0) = red
rr_p.fillcolor = RGB(255,0,0)
ib_prac = true
is_ir_fil = ""
rr_ir.fillcolor = RGB(255,0,0)
ib_ir = true
is_screen_fil = ""
rr_s.fillcolor = RGB(255,0,0)
ib_screen = true

gs_fil_batch = ""
st_batch.text = "Off"
gs_fil_status = ""
st_status.text = "Off"
gs_fil_screen = ""
st_screen.text = "Off"
//w_action_items.is_addtl_filter = ""
end event

type st_2 from statictext within w_additional_filters_ai
integer x = 443
integer y = 516
integer width = 357
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
string text = "IntelliBatch List"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_additional_filters_ai
integer x = 1358
integer y = 28
integer width = 247
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;closewithreturn(parent,"Cancel")
end event

type cb_single from commandbutton within w_additional_filters_ai
integer x = 1102
integer y = 28
integer width = 247
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
boolean default = true
end type

event clicked;if ib_prac then
	is_win.is_batch_filter = is_prac_fil
end if
if ib_screen then
	is_win.is_screen_filter = is_screen_fil
end if
if ib_ir then
	is_win.is_ir_filter = is_ir_fil
end if

if ib_ir  and ib_screen then
	is_win.is_addtl_filter = ""
end if

closewithreturn(parent,"OK")
end event

type dw_bat from datawindow within w_additional_filters_ai
integer x = 416
integer y = 576
integer width = 841
integer height = 84
integer taborder = 80
string dataobject = "d_d_batch_list"
boolean border = false
boolean livescroll = true
end type

event itemchanged;long i
long ic
long rc
long pracids[]
long ll_batch_id
string names[]
string ls_openstring
string ls_pracids = ""
n_ds lds_batch
datawindowchild dwchild
integer r

ll_batch_id  = long(data)
ib_prac = true

if ll_batch_id < 1 then
	rr_p.fillcolor = rgb(255,0,0)
	is_prac_fil = ""
else
	lds_batch = CREATE n_ds
	lds_batch.DataObject = "d_batch_items_list"
	lds_batch.of_SetTransObject( SQLCA )
	ic = lds_batch.retrieve(ll_batch_id) 
	for i = 1 to ic
		ls_pracids = ls_pracids + string(lds_batch.getitemnumber(i,"prac_id"))
		if i < ic then ls_pracids = ls_pracids + ","
	next
	
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 03.30.2011
	//$<reason> judge empty data
	/*
	is_prac_fil = "prac_id in (" + ls_pracids + ")"
	*/
	if ic < 1 then
		is_prac_fil = ""
	else
		is_prac_fil = "prac_id in (" + ls_pracids + ")"
	end if
	//------------------- APPEON END ---------------------
	
	rr_p.fillcolor = RGB(0,255,0)
	this.getchild("batch_id",dwchild)
	r = dwchild.find("batch_id = " + string(ll_batch_id),1,dwchild.rowcount())
	if r > 1 then
		gs_fil_batch = dwchild.getitemstring(r,"batch_name")
		st_batch.text = gs_fil_batch
	end if
end if
end event

type rr_ir from roundrectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 255
integer x = 174
integer y = 256
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_s from roundrectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 255
integer x = 174
integer y = 424
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_p from roundrectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 255
integer x = 174
integer y = 596
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_green from roundrectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 65280
integer x = 823
integer y = 836
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

type rr_red from roundrectangle within w_additional_filters_ai
integer linethickness = 4
long fillcolor = 255
integer x = 539
integer y = 836
integer width = 101
integer height = 52
integer cornerheight = 40
integer cornerwidth = 46
end type

