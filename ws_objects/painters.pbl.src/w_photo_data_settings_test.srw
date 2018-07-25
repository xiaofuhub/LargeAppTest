$PBExportHeader$w_photo_data_settings_test.srw
forward
global type w_photo_data_settings_test from w_popup
end type
type dw_photo_settings from u_dw within w_photo_data_settings_test
end type
type cb_close from commandbutton within w_photo_data_settings_test
end type
type dw_data from u_dw within w_photo_data_settings_test
end type
end forward

global type w_photo_data_settings_test from w_popup
integer width = 992
integer height = 1740
string title = "Setting Test"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
dw_photo_settings dw_photo_settings
cb_close cb_close
dw_data dw_data
end type
global w_photo_data_settings_test w_photo_data_settings_test

on w_photo_data_settings_test.create
int iCurrent
call super::create
this.dw_photo_settings=create dw_photo_settings
this.cb_close=create cb_close
this.dw_data=create dw_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_photo_settings
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.dw_data
end on

on w_photo_data_settings_test.destroy
call super::destroy
destroy(this.dw_photo_settings)
destroy(this.cb_close)
destroy(this.dw_data)
end on

event open;call super::open;long li_prac
long li_facil

gs_pass_ids  lst_pass

lst_pass = message.powerobjectparm

li_prac = lst_pass.prac_id
li_facil = lst_pass.facility_id

dw_data.settransobject(sqlca)
dw_data.retrieve(li_prac,li_facil)

of_photo_data_modify(dw_data, dw_photo_settings, li_prac, li_facil )
end event

type dw_photo_settings from u_dw within w_photo_data_settings_test
boolean visible = false
integer x = 46
integer y = 12
integer width = 82
integer height = 84
integer taborder = 20
string dataobject = "d_personal_data_settings"
boolean hscrollbar = true
end type

event constructor;call super::constructor; //Start Code Change ----05.10.2017 #V154 maha
this.of_setupdateable( false)
this.of_settransobject( sqlca)
this.retrieve()


end event

type cb_close from commandbutton within w_photo_data_settings_test
integer x = 663
integer y = 12
integer width = 297
integer height = 84
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

type dw_data from u_dw within w_photo_data_settings_test
integer x = 14
integer y = 112
integer width = 955
integer height = 1540
integer taborder = 10
string dataobject = "d_personal_data_new"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_setupdateable( false)
this.settransobject(sqlca)
//this.retrieve()  //Commented by (APPEON) Harry 11.01.2017 for  Alpha Testing Bug # 5852 - Photo Profile Design: Test preview is not working 
end event

