$PBExportHeader$w_preview_app.srw
forward
global type w_preview_app from w_popup
end type
type cb_resize from commandbutton within w_preview_app
end type
type uo_1 from pfc_cst_u_preview_app within w_preview_app
end type
type uo_prac from pcf_cst_prac_data_view within w_preview_app
end type
end forward

global type w_preview_app from w_popup
integer x = 0
integer y = 0
integer width = 4965
integer height = 2416
string title = "Application Preview"
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 33551856
boolean center = true
cb_resize cb_resize
uo_1 uo_1
uo_prac uo_prac
end type
global w_preview_app w_preview_app

type variables
n_cst_string_appeon inv_string

end variables

on w_preview_app.create
int iCurrent
call super::create
this.cb_resize=create cb_resize
this.uo_1=create uo_1
this.uo_prac=create uo_prac
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_resize
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.uo_prac
end on

on w_preview_app.destroy
call super::destroy
destroy(this.cb_resize)
destroy(this.uo_1)
destroy(this.uo_prac)
end on

event open;call super::open;//alfee 06.29.2010

String ls_parms[], ls_message

//Set parent window
uo_1.of_set_parent(This)

//load app
ls_message = Message.StringParm 
//ls_app_image_name + "||" + ls_prac_nm + "||" + ls_facility_nm +  "||" + ls_app_nm
inv_string.of_parsetoarray( ls_message,"||", ls_parms)

uo_1.of_load_app(ls_parms)
//uo_1.of_load_app( ls_image_file, ls_prac_name)

uo_prac.of_initiate(  long(ls_parms[5] ), 1, long(ls_parms[8] ) )   //Start Code Change ----03.06.2017 #V153 maha - get prac data





end event

event pfc_preopen;call super::pfc_preopen;

this.of_setresize(true)

this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
//this.inv_resize.of_setminsize( w_mdi.WorkSpaceWidth(),w_mdi.WorkSpaceHeight())
this.inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

 //Start Code Change ----03.06.2017 #V153 maha
//this.inv_resize.of_Register(uo_1, this.inv_resize.SCALERIGHTBOTTOM)
//this.inv_resize.of_Register(uo_1.ole_edit , this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(uo_1, this.inv_resize.SCALEBOTTOM)
this.inv_resize.of_Register(uo_1.ole_edit , this.inv_resize.SCALEBOTTOM)
this.inv_resize.of_Register(uo_prac, this.inv_resize.SCALEBOTTOM)
 //End Code Change ----03.06.2017
 
//this.inv_resize.of_Register(gb_1, this.inv_resize.SCALERIGHTBOTTOM)
//this.inv_resize.of_Register(ole_message, this.inv_resize.SCALERIGHTBOTTOM)
//this.inv_resize.of_Register(mle_message, this.inv_resize.SCALERIGHTBOTTOM) //Evan 01.28.2010
//this.inv_resize.of_Register(cb_resize, this.inv_resize.FIXEDBOTTOM)
//
//this.inv_resize.of_Register(dw_email, this.inv_resize.SCALERIGHT)
//this.inv_resize.of_Register(cb_cancel, this.inv_resize.FIXEDRIGHTBOTTOM)
//this.inv_resize.of_Register(cb_save, this.inv_resize.FIXEDRIGHTBOTTOM)
//this.inv_resize.of_Register(cb_field, this.inv_resize.FIXEDRIGHTBOTTOM)
end event

event resize;call super::resize; //Start Code Change ----03.06.2017 #V153 maha - added prac data
 long ll_w
 long ll_h
 long ll_split
 
 ll_w = this.workspacewidth( )
 
 ll_split = ll_w / 9
 
uo_1.width = ll_split * 9 - 10
//uo_1.ole_edit.width = ll_split * 9 - 20 //Commented by (Appeon)Stephen 04.07.2017 - V15.3 Bug # 5593 - Issues with Data preview in IPop and Application Edit
uo_prac.width = ll_split * 2 - 10
uo_1.ole_edit.width = ll_split * 9 - 20 - uo_prac.width //(Appeon)Stephen 04.07.2017 - V15.3 Bug # 5593 - Issues with Data preview in IPop and Application Edit
 
uo_1.x = uo_prac.width + 10
uo_prac.of_resize(uo_prac.ib_link)
cb_resize.x = uo_1.ddlb_zoom.x + uo_1.ddlb_zoom.width + uo_prac.width +20 //(Appeon)Stephen 04.07.2017 - V15.3 Bug # 5593 - Issues with Data preview in IPop and Application Edit
 
end event

type cb_resize from commandbutton within w_preview_app
integer x = 2907
integer y = 20
integer width = 343
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Maximized"
end type

event clicked;if parent.windowstate = maximized! then
	parent.windowstate = normal!
	this.text = "Maximized"
else
	parent.windowstate = maximized!
	this.text = "Normal"
end if

end event

type uo_1 from pfc_cst_u_preview_app within w_preview_app
integer x = 1102
integer width = 3854
integer height = 2332
integer taborder = 70
boolean vscrollbar = true
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_preview_app::destroy
end on

type uo_prac from pcf_cst_prac_data_view within w_preview_app
integer height = 2324
integer taborder = 30
end type

on uo_prac.destroy
call pcf_cst_prac_data_view::destroy
end on

