$PBExportHeader$w_preprocess_message.srw
forward
global type w_preprocess_message from window
end type
type dw_1 from datawindow within w_preprocess_message
end type
type cb_2 from commandbutton within w_preprocess_message
end type
type cb_u4 from commandbutton within w_preprocess_message
end type
type cb_u3 from commandbutton within w_preprocess_message
end type
type cb_u2 from commandbutton within w_preprocess_message
end type
type cb_u1 from commandbutton within w_preprocess_message
end type
type cb_m4 from commandbutton within w_preprocess_message
end type
type cb_m3 from commandbutton within w_preprocess_message
end type
type cb_m2 from commandbutton within w_preprocess_message
end type
type cb_1 from commandbutton within w_preprocess_message
end type
type cb_m1 from commandbutton within w_preprocess_message
end type
type st_total from statictext within w_preprocess_message
end type
type st_12 from statictext within w_preprocess_message
end type
type st_u4 from statictext within w_preprocess_message
end type
type st_u3 from statictext within w_preprocess_message
end type
type st_u2 from statictext within w_preprocess_message
end type
type st_u1 from statictext within w_preprocess_message
end type
type st_un3 from statictext within w_preprocess_message
end type
type st_un4 from statictext within w_preprocess_message
end type
type st_un2 from statictext within w_preprocess_message
end type
type st_un1 from statictext within w_preprocess_message
end type
type st_m4 from statictext within w_preprocess_message
end type
type st_m3 from statictext within w_preprocess_message
end type
type st_m2 from statictext within w_preprocess_message
end type
type st_mat1 from statictext within w_preprocess_message
end type
type st_mat2 from statictext within w_preprocess_message
end type
type st_mat4 from statictext within w_preprocess_message
end type
type st_mat3 from statictext within w_preprocess_message
end type
type st_m1 from statictext within w_preprocess_message
end type
type st_4_1 from statictext within w_preprocess_message
end type
type st_3_1 from statictext within w_preprocess_message
end type
type st_2_1 from statictext within w_preprocess_message
end type
type st_3 from statictext within w_preprocess_message
end type
type st_3cnt from statictext within w_preprocess_message
end type
type st_4cnt from statictext within w_preprocess_message
end type
type st_2cnt from statictext within w_preprocess_message
end type
type st_1cnt from statictext within w_preprocess_message
end type
type st_1 from statictext within w_preprocess_message
end type
type st_steps from statictext within w_preprocess_message
end type
type st_2 from statictext within w_preprocess_message
end type
type st_step from statictext within w_preprocess_message
end type
type cb_close from commandbutton within w_preprocess_message
end type
end forward

global type w_preprocess_message from window
integer width = 3730
integer height = 820
boolean titlebar = true
string title = "Preprocessing"
windowtype windowtype = child!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
dw_1 dw_1
cb_2 cb_2
cb_u4 cb_u4
cb_u3 cb_u3
cb_u2 cb_u2
cb_u1 cb_u1
cb_m4 cb_m4
cb_m3 cb_m3
cb_m2 cb_m2
cb_1 cb_1
cb_m1 cb_m1
st_total st_total
st_12 st_12
st_u4 st_u4
st_u3 st_u3
st_u2 st_u2
st_u1 st_u1
st_un3 st_un3
st_un4 st_un4
st_un2 st_un2
st_un1 st_un1
st_m4 st_m4
st_m3 st_m3
st_m2 st_m2
st_mat1 st_mat1
st_mat2 st_mat2
st_mat4 st_mat4
st_mat3 st_mat3
st_m1 st_m1
st_4_1 st_4_1
st_3_1 st_3_1
st_2_1 st_2_1
st_3 st_3
st_3cnt st_3cnt
st_4cnt st_4cnt
st_2cnt st_2cnt
st_1cnt st_1cnt
st_1 st_1
st_steps st_steps
st_2 st_2
st_step st_step
cb_close cb_close
end type
global w_preprocess_message w_preprocess_message

type variables
integer ii_step
integer ii_steps
end variables

forward prototypes
public function integer of_set_val (string as_type, string as_msg)
public function integer of_filter (integer ai_step, string as_match)
public function integer of_set_val_org (string as_type, string as_msg)
end prototypes

public function integer of_set_val (string as_type, string as_msg);choose case as_type
	case "Process"
		st_step.text = as_msg
		ii_step = integer(as_msg)
	case "Total"
		st_total.text = as_msg
	case "Processes"
		st_steps.text = as_msg
		ii_steps = integer(as_msg)
	case "Completed"
		if ii_step > dw_1.rowcount() then dw_1.insertrow(ii_step)  //add new row if needed
		dw_1.setitem(ii_step, "comp_cnt", as_msg)	
	case "Matched"
		dw_1.setitem(ii_step, "match_cnt", as_msg)			
	case "Unmatched"
		dw_1.setitem(ii_step, "unmatch_cnt", as_msg)		
end choose

return 1
end function

public function integer of_filter (integer ai_step, string as_match);//Start Code Change ----08.15.2013 #V14 maha
string ls_field
string ls_filter
u_dw ldw_preprocess
u_dw ldw_import

ldw_import = w_import_painter.tab_1.tabpage_data.dw_imp_data
ldw_preprocess = w_import_painter.tab_1.tabpage_data.dw_preprocess

//---------Begin Added by (Appeon)Stephen 01.08.2014 for test bug--------
if ai_step = 0 then
	ldw_import.setfilter("")
	ldw_import.filter()
	return 1
end if
//---------End Added ------------------------------------------------------
ls_field = ldw_preprocess.getitemstring(ai_step,"result_field")

choose case as_match
	case "Matched"
		ls_filter = "not isnull(" + ls_field + ")"
	case "Unmatched"
		ls_filter = "isnull(" + ls_field + ")"
	case else
		ls_filter = ""
end choose

ldw_import.setfilter(ls_filter)
ldw_import.filter()


return 1
end function

public function integer of_set_val_org (string as_type, string as_msg);choose case as_type
	case "Process"
		st_step.text = as_msg
		ii_step = integer(as_msg)
	case "Total"
		st_total.text = as_msg
	case "Processes"
		st_steps.text = as_msg
		ii_steps = integer(as_msg)
		choose case ii_steps
			case 1
				st_2cnt.visible = false
				st_3cnt.visible = false
				st_4cnt.visible = false
				st_2_1.visible = false
				st_3_1.visible = false
				st_4_1.visible = false
				st_m2.visible = false
				st_m3.visible = false
				st_m4.visible = false
				st_mat2.visible = false
				st_mat3.visible = false
				st_mat4.visible = false
				st_u2.visible = false
				st_u3.visible = false
				st_u4.visible = false
				st_un2.visible = false
				st_un3.visible = false
				st_un4.visible = false
				cb_m2.visible = false
				cb_m3.visible = false
				cb_m4.visible = false
				cb_u2.visible = false
				cb_u3.visible = false
				cb_u4.visible = false
			case 2
				st_3cnt.visible = false
				st_4cnt.visible = false
				st_3_1.visible = false
				st_4_1.visible = false
				st_m3.visible = false
				st_m4.visible = false
				st_mat3.visible = false
				st_mat4.visible = false
				st_u3.visible = false
				st_u4.visible = false
				st_un3.visible = false
				st_un4.visible = false
				cb_m3.visible = false
				cb_m4.visible = false
				cb_u3.visible = false
				cb_u4.visible = false
			case 3
				st_4cnt.visible = false
				st_4_1.visible = false
				st_m4.visible = false
				st_mat4.visible = false
				st_u4.visible = false
				st_un4.visible = false
				cb_m4.visible = false
				cb_u4.visible = false
			case 4
				//nada
		end choose
	
	case "Completed"
		choose case ii_step
			case 1
				st_1cnt.text = as_msg
			case 2
				st_2cnt.text = as_msg
			case 3
				st_3cnt.text = as_msg
			case 4
				st_4cnt.text = as_msg
		end choose
		
	case "Matched"
		choose case ii_step
			case 1
				st_mat1.text = as_msg
			case 2
				st_mat2.text = as_msg
			case 3
				st_mat3.text = as_msg
			case 4
				st_mat4.text = as_msg
		end choose		
		
	case "Unmatched"
		choose case ii_step
			case 1
				st_un1.text = as_msg
			case 2
				st_un2.text = as_msg
			case 3
				st_un3.text = as_msg
			case 4
				st_un4.text = as_msg
		end choose		
		
		
		
		
		
		
		
end choose

return 1
end function

on w_preprocess_message.create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_u4=create cb_u4
this.cb_u3=create cb_u3
this.cb_u2=create cb_u2
this.cb_u1=create cb_u1
this.cb_m4=create cb_m4
this.cb_m3=create cb_m3
this.cb_m2=create cb_m2
this.cb_1=create cb_1
this.cb_m1=create cb_m1
this.st_total=create st_total
this.st_12=create st_12
this.st_u4=create st_u4
this.st_u3=create st_u3
this.st_u2=create st_u2
this.st_u1=create st_u1
this.st_un3=create st_un3
this.st_un4=create st_un4
this.st_un2=create st_un2
this.st_un1=create st_un1
this.st_m4=create st_m4
this.st_m3=create st_m3
this.st_m2=create st_m2
this.st_mat1=create st_mat1
this.st_mat2=create st_mat2
this.st_mat4=create st_mat4
this.st_mat3=create st_mat3
this.st_m1=create st_m1
this.st_4_1=create st_4_1
this.st_3_1=create st_3_1
this.st_2_1=create st_2_1
this.st_3=create st_3
this.st_3cnt=create st_3cnt
this.st_4cnt=create st_4cnt
this.st_2cnt=create st_2cnt
this.st_1cnt=create st_1cnt
this.st_1=create st_1
this.st_steps=create st_steps
this.st_2=create st_2
this.st_step=create st_step
this.cb_close=create cb_close
this.Control[]={this.dw_1,&
this.cb_2,&
this.cb_u4,&
this.cb_u3,&
this.cb_u2,&
this.cb_u1,&
this.cb_m4,&
this.cb_m3,&
this.cb_m2,&
this.cb_1,&
this.cb_m1,&
this.st_total,&
this.st_12,&
this.st_u4,&
this.st_u3,&
this.st_u2,&
this.st_u1,&
this.st_un3,&
this.st_un4,&
this.st_un2,&
this.st_un1,&
this.st_m4,&
this.st_m3,&
this.st_m2,&
this.st_mat1,&
this.st_mat2,&
this.st_mat4,&
this.st_mat3,&
this.st_m1,&
this.st_4_1,&
this.st_3_1,&
this.st_2_1,&
this.st_3,&
this.st_3cnt,&
this.st_4cnt,&
this.st_2cnt,&
this.st_1cnt,&
this.st_1,&
this.st_steps,&
this.st_2,&
this.st_step,&
this.cb_close}
end on

on w_preprocess_message.destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_u4)
destroy(this.cb_u3)
destroy(this.cb_u2)
destroy(this.cb_u1)
destroy(this.cb_m4)
destroy(this.cb_m3)
destroy(this.cb_m2)
destroy(this.cb_1)
destroy(this.cb_m1)
destroy(this.st_total)
destroy(this.st_12)
destroy(this.st_u4)
destroy(this.st_u3)
destroy(this.st_u2)
destroy(this.st_u1)
destroy(this.st_un3)
destroy(this.st_un4)
destroy(this.st_un2)
destroy(this.st_un1)
destroy(this.st_m4)
destroy(this.st_m3)
destroy(this.st_m2)
destroy(this.st_mat1)
destroy(this.st_mat2)
destroy(this.st_mat4)
destroy(this.st_mat3)
destroy(this.st_m1)
destroy(this.st_4_1)
destroy(this.st_3_1)
destroy(this.st_2_1)
destroy(this.st_3)
destroy(this.st_3cnt)
destroy(this.st_4cnt)
destroy(this.st_2cnt)
destroy(this.st_1cnt)
destroy(this.st_1)
destroy(this.st_steps)
destroy(this.st_2)
destroy(this.st_step)
destroy(this.cb_close)
end on

type dw_1 from datawindow within w_preprocess_message
integer x = 818
integer y = 132
integer width = 2843
integer height = 528
integer taborder = 20
string title = "none"
string dataobject = "d_preprocess_step_msg"
boolean vscrollbar = true
boolean livescroll = true
end type

event buttonclicked;if dwo.name = "b_filter_match" then
	of_filter(row,"Matched")
elseif dwo.name = "b_filter_un" then
	of_filter(row,"Unmatched")
end if
end event

type cb_2 from commandbutton within w_preprocess_message
integer x = 2953
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
string text = "Clear Filter"
end type

event clicked;of_filter(0,"Clear")
end event

type cb_u4 from commandbutton within w_preprocess_message
integer x = 3374
integer y = 1024
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(4,"Unmatched")
end event

type cb_u3 from commandbutton within w_preprocess_message
integer x = 3374
integer y = 956
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(3,"Unmatched")
end event

type cb_u2 from commandbutton within w_preprocess_message
integer x = 3374
integer y = 892
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(2,"Unmatched")
end event

type cb_u1 from commandbutton within w_preprocess_message
integer x = 3374
integer y = 824
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(1,"Unmatched")
end event

type cb_m4 from commandbutton within w_preprocess_message
integer x = 2528
integer y = 1024
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(4,"Matched")
end event

type cb_m3 from commandbutton within w_preprocess_message
integer x = 2528
integer y = 960
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(3,"Matched")
end event

type cb_m2 from commandbutton within w_preprocess_message
integer x = 2528
integer y = 896
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(2,"Matched")
end event

type cb_1 from commandbutton within w_preprocess_message
integer x = 2528
integer y = 832
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Filter"
end type

event clicked;of_filter(1,"Matched")
end event

type cb_m1 from commandbutton within w_preprocess_message
integer x = 2528
integer y = 832
integer width = 210
integer height = 68
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View"
end type

type st_total from statictext within w_preprocess_message
integer x = 183
integer y = 376
integer width = 288
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_12 from statictext within w_preprocess_message
integer x = 46
integer y = 296
integer width = 690
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Total Import Records"
boolean focusrectangle = false
end type

type st_u4 from statictext within w_preprocess_message
integer x = 2784
integer y = 1020
integer width = 379
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Unmatched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u3 from statictext within w_preprocess_message
integer x = 2784
integer y = 952
integer width = 379
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Unmatched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u2 from statictext within w_preprocess_message
integer x = 2784
integer y = 892
integer width = 379
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Unmatched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_u1 from statictext within w_preprocess_message
integer x = 2784
integer y = 828
integer width = 379
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Unmatched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_un3 from statictext within w_preprocess_message
integer x = 3191
integer y = 952
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_un4 from statictext within w_preprocess_message
integer x = 3191
integer y = 1020
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_un2 from statictext within w_preprocess_message
integer x = 3191
integer y = 892
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_un1 from statictext within w_preprocess_message
integer x = 3191
integer y = 828
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_m4 from statictext within w_preprocess_message
integer x = 1906
integer y = 1020
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Matched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_m3 from statictext within w_preprocess_message
integer x = 1906
integer y = 952
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Matched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_m2 from statictext within w_preprocess_message
integer x = 1906
integer y = 892
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Matched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_mat1 from statictext within w_preprocess_message
integer x = 2281
integer y = 832
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_mat2 from statictext within w_preprocess_message
integer x = 2281
integer y = 896
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_mat4 from statictext within w_preprocess_message
integer x = 2281
integer y = 1024
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_mat3 from statictext within w_preprocess_message
integer x = 2281
integer y = 956
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_m1 from statictext within w_preprocess_message
integer x = 1906
integer y = 832
integer width = 343
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Matched"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4_1 from statictext within w_preprocess_message
integer x = 750
integer y = 1020
integer width = 832
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Completed for process 4"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3_1 from statictext within w_preprocess_message
integer x = 750
integer y = 952
integer width = 832
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Completed for process 3"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2_1 from statictext within w_preprocess_message
integer x = 750
integer y = 892
integer width = 832
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Completed for process 2"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_preprocess_message
integer x = 750
integer y = 828
integer width = 832
integer height = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "Completed for process 1"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3cnt from statictext within w_preprocess_message
integer x = 1618
integer y = 952
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_4cnt from statictext within w_preprocess_message
integer x = 1618
integer y = 1020
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_2cnt from statictext within w_preprocess_message
integer x = 1618
integer y = 892
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_1cnt from statictext within w_preprocess_message
integer x = 1618
integer y = 828
integer width = 229
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 32891346
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_preprocess_message
integer x = 73
integer y = 132
integer width = 594
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Preprocess steps"
boolean focusrectangle = false
end type

type st_steps from statictext within w_preprocess_message
integer x = 457
integer y = 212
integer width = 142
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

type st_2 from statictext within w_preprocess_message
integer x = 297
integer y = 212
integer width = 133
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "of"
boolean focusrectangle = false
end type

type st_step from statictext within w_preprocess_message
integer x = 105
integer y = 212
integer width = 123
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = " "
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_close from commandbutton within w_preprocess_message
integer x = 3323
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

