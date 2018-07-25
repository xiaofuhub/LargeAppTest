$PBExportHeader$w_dept_select_batch_add.srw
forward
global type w_dept_select_batch_add from window
end type
type st_2 from statictext within w_dept_select_batch_add
end type
type dw_1 from datawindow within w_dept_select_batch_add
end type
type st_1 from statictext within w_dept_select_batch_add
end type
type cb_cancel from commandbutton within w_dept_select_batch_add
end type
type cb_ok from commandbutton within w_dept_select_batch_add
end type
end forward

global type w_dept_select_batch_add from window
integer width = 1989
integer height = 688
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_2 st_2
dw_1 dw_1
st_1 st_1
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_dept_select_batch_add w_dept_select_batch_add

type variables
long il_dept
end variables

on w_dept_select_batch_add.create
this.st_2=create st_2
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
this.Control[]={this.st_2,&
this.dw_1,&
this.st_1,&
this.cb_cancel,&
this.cb_ok}
end on

on w_dept_select_batch_add.destroy
destroy(this.st_2)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;//Start Code Change ----08.03.2011 #V11 maha - window created

gs_variable_array gst_ids
long ll_prac
long ll_facil
string ls_prac
string ls_facil

gst_ids = message.powerobjectparm

ll_prac = gst_ids.as_number[2]
ll_facil = gst_ids.as_number[3]

select full_name into :ls_prac from v_full_name where prac_id = :ll_prac ;
select facility_name into :ls_facil from facility where facility_id = :ll_facil;

st_1.text = "You are adding an Appointment record for " + ls_prac + " for Facility " + ls_facil + " and as your system uses Department Security you must select a Department.  "
end event

type st_2 from statictext within w_dept_select_batch_add
integer x = 50
integer y = 260
integer width = 1865
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Cancel will cancel the Batch Add function for ALL Providers."
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_dept_select_batch_add
integer x = 494
integer y = 372
integer width = 722
integer height = 84
integer taborder = 10
string title = "none"
string dataobject = "d_departments_lookup"
boolean border = false
boolean livescroll = true
end type

event itemchanged;il_dept = long(data)
end event

event constructor;this.settransobject(sqlca)
this.retrieve()
this.insertrow(1)
end event

type st_1 from statictext within w_dept_select_batch_add
integer x = 50
integer y = 36
integer width = 1865
integer height = 212
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "You are adding an Appointment record for practitioner for Facility Facility and as your system uses Department Security you must select a department.  "
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_dept_select_batch_add
integer x = 1120
integer y = 520
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Cancel"
end type

event clicked;integer res
	
res = 	messagebox("Cancel","If you Cancel, you will cancel the entire Batch add function for ALL Providers.  Cancel?",question!, yesno!,2)

if res = 2 then return 1

closewithreturn(parent,-1)
end event

type cb_ok from commandbutton within w_dept_select_batch_add
integer x = 704
integer y = 520
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "OK"
end type

event clicked;if il_dept = 0 then 
	messagebox("Select Department","You must select a Department to continue.")
	return 1
end if

closewithreturn (parent,il_dept)
end event

