$PBExportHeader$w_image_display_bk.srw
forward
global type w_image_display_bk from window
end type
type uo_1 from uo_dm_image_view within w_image_display_bk
end type
type uo_2 from uo_dm_image_view_cp within w_image_display_bk
end type
end forward

global type w_image_display_bk from window
integer width = 3781
integer height = 1860
boolean titlebar = true
string title = "Image Preview"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
uo_1 uo_1
uo_2 uo_2
end type
global w_image_display_bk w_image_display_bk

on w_image_display_bk.create
this.uo_1=create uo_1
this.uo_2=create uo_2
this.Control[]={this.uo_1,&
this.uo_2}
end on

on w_image_display_bk.destroy
destroy(this.uo_1)
destroy(this.uo_2)
end on

event open;String	ls_PicName

ls_PicName = Message.StringParm

IF gi_imageocx = 1 THEN //imaging 360
	uo_1.visible = true
	uo_2.visible = false	
	
	uo_1.event ue_load_image(ls_PicName)
	uo_1.of_set_readonly(true) // Add by Evan 05.12.2009 --- Corrected BugA082802
ELSE  						//New Image OCX
	uo_1.visible = false
	uo_2.visible = true
	
	uo_2.event ue_load_image(ls_PicName)
	uo_2.of_set_readonly(true) // Add by Evan 05.12.2009 --- Corrected BugA082802
END IF

end event

type uo_1 from uo_dm_image_view within w_image_display_bk
integer x = 14
integer y = 12
integer taborder = 60
end type

on uo_1.destroy
call uo_dm_image_view::destroy
end on

type uo_2 from uo_dm_image_view_cp within w_image_display_bk
integer x = 14
integer y = 12
integer taborder = 70
end type

on uo_2.destroy
call uo_dm_image_view_cp::destroy
end on

