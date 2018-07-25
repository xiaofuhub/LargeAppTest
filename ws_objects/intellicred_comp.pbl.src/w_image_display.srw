$PBExportHeader$w_image_display.srw
forward
global type w_image_display from w_popup
end type
type cb_close from commandbutton within w_image_display
end type
type cb_print from commandbutton within w_image_display
end type
type uo_1 from uo_dm_image_view within w_image_display
end type
end forward

global type w_image_display from w_popup
integer y = 3228
integer width = 3854
integer height = 2016
string title = "Image Preview"
long backcolor = 33551856
boolean center = true
cb_close cb_close
cb_print cb_print
uo_1 uo_1
end type
global w_image_display w_image_display

type variables

end variables

on w_image_display.create
int iCurrent
call super::create
this.cb_close=create cb_close
this.cb_print=create cb_print
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_close
this.Control[iCurrent+2]=this.cb_print
this.Control[iCurrent+3]=this.uo_1
end on

on w_image_display.destroy
call super::destroy
destroy(this.cb_close)
destroy(this.cb_print)
destroy(this.uo_1)
end on

event open;call super::open;//Created by alfee 07.14.2009

Long ll_pos
String ls_msg, ls_PicName, ls_PicName_ori, ls_ext

ls_msg = Message.StringParm

//Get file names and file type
ll_pos = PosA(ls_msg, '|') 
IF ll_pos > 0 THEN
	ls_PicName = LeftA(ls_msg, ll_pos -1)
	ls_PicName_ori = MidA(ls_msg, ll_pos + 1)
ELSE
	ls_PicName = ls_msg
END IF

ll_pos = LastPos(ls_PicName, '.') 
IF ll_pos > 0 THEN ls_ext = Lower(MidA(ls_PicName, ll_pos + 1))
ll_pos = LastPos(ls_PicName, '\') 
IF ll_pos > 0 and LenA(ls_PicName_ori) < 1 THEN ls_PicName_ori = Lower(MidA(ls_PicName, ll_pos + 1))

//Display the image file
//---------Begin Modified by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
TRY
IF NOT gb_contract_version AND ls_ext <> 'pdf' THEN //Imaging 360
	uo_1.of_initialize(ls_PicName_ori, ls_ext) 
	uo_1.event ue_load_image(ls_PicName)
	uo_1.of_set_readonly(true)
END IF
CATCH (Throwable th1)
	//
END TRY
//IF gi_imageocx = 1 AND ls_ext <> 'pdf' THEN //Imaging 360
//	uo_1.visible = true
//	uo_2.visible = false	
//	uo_1.of_initialize(ls_PicName_ori, ls_ext) 
//	uo_1.event ue_load_image(ls_PicName)
//	uo_1.of_set_readonly(true) 
//ELSE  						//Image Viewer CP
//	uo_1.visible = false
//	uo_2.visible = true
//	uo_2.of_initialize(ls_PicName_ori, ls_ext) 
//	uo_2.event ue_load_image(ls_PicName)
//	uo_2.of_set_readonly(true) 
//END IF
//---------End Modfiied -------------------------------------------------------------------


end event

event pfc_preopen;call super::pfc_preopen;//Alfee 07.14.2009

string ls_scale
long 	 ll_i

this.of_SetResize(TRUE)

this.inv_resize.of_SetOrigSize (this.workspacewidth( ) ,  this.workspaceheight( ) )
ls_scale = this.inv_resize.scale

FOR LL_I =  1 TO UPPERBOUND(this.CONTrol)
   this.inv_resize.of_Register (this.CONTrol[LL_I]  , ls_scale	 )
NEXT
end event

type cb_close from commandbutton within w_image_display
integer x = 3429
integer y = 16
integer width = 343
integer height = 92
integer taborder = 90
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

type cb_print from commandbutton within w_image_display
integer x = 3058
integer y = 16
integer width = 343
integer height = 92
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;If uo_1.visible then
	uo_1.event ue_print( ) 
//---------Begin Commented by (Appeon)Alfee 06.27.2013 for V141 ISG-CLX--------
//elseif uo_2.visible then
//	uo_2.event ue_print( ) 
//---------End Commented ------------------------------------------------------
end if
end event

type uo_1 from uo_dm_image_view within w_image_display
integer x = 32
integer y = 128
integer height = 1760
integer taborder = 70
end type

on uo_1.destroy
call uo_dm_image_view::destroy
end on

