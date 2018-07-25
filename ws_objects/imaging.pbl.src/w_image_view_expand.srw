$PBExportHeader$w_image_view_expand.srw
forward
global type w_image_view_expand from w_popup
end type
type cb_resize from commandbutton within w_image_view_expand
end type
type uo_1 from pfc_cst_u_preview_app within w_image_view_expand
end type
end forward

global type w_image_view_expand from w_popup
integer x = 0
integer y = 0
integer width = 3863
integer height = 2472
string title = "Application Preview"
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
cb_resize cb_resize
uo_1 uo_1
end type
global w_image_view_expand w_image_view_expand

type variables
n_cst_string_appeon inv_string
end variables

on w_image_view_expand.create
int iCurrent
call super::create
this.cb_resize=create cb_resize
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_resize
this.Control[iCurrent+2]=this.uo_1
end on

on w_image_view_expand.destroy
call super::destroy
destroy(this.cb_resize)
destroy(this.uo_1)
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
uo_1.of_hide_buttons()



end event

event pfc_preopen;call super::pfc_preopen;

this.of_setresize(true)

this.inv_resize.of_SetOrigSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())
//this.inv_resize.of_setminsize( w_mdi.WorkSpaceWidth(),w_mdi.WorkSpaceHeight())
this.inv_resize.of_SetMinSize(this.WorkSpaceWidth(), this.WorkSpaceHeight())

this.inv_resize.of_Register(uo_1, this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(uo_1.ole_edit , this.inv_resize.SCALERIGHTBOTTOM)
this.inv_resize.of_Register(uo_1.ole_edit_pdf , this.inv_resize.SCALERIGHTBOTTOM)//Added by (APPEON) Harry 11.20.2017 (V161 Storage of Documents as PDFs)
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

event resize;call super::resize;//Added by (APPEON) Harry 11.27.2017 (V161 Storage of Documents as PDFs)
uo_1.ole_edit_pdf.width = uo_1.ole_edit.width
uo_1.ole_edit_pdf.height = uo_1.ole_edit.height
uo_1.ole_edit_pdf.of_resize( )
end event

type cb_resize from commandbutton within w_image_view_expand
integer x = 2784
integer y = 24
integer width = 343
integer height = 88
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

type uo_1 from pfc_cst_u_preview_app within w_image_view_expand
integer x = 14
integer y = 8
integer width = 3854
integer taborder = 70
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_preview_app::destroy
end on

