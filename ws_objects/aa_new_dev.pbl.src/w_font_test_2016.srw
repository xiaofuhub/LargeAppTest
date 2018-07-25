$PBExportHeader$w_font_test_2016.srw
forward
global type w_font_test_2016 from window
end type
type cb_1 from commandbutton within w_font_test_2016
end type
type dw_verd from uo_listbar within w_font_test_2016
end type
type dw_cab from uo_listbar within w_font_test_2016
end type
type dw_mssan from uo_listbar within w_font_test_2016
end type
type dw_tahoma from uo_listbar within w_font_test_2016
end type
type dw_nav from uo_listbar within w_font_test_2016
end type
end forward

global type w_font_test_2016 from window
integer width = 5349
integer height = 2672
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_verd dw_verd
dw_cab dw_cab
dw_mssan dw_mssan
dw_tahoma dw_tahoma
dw_nav dw_nav
end type
global w_font_test_2016 w_font_test_2016

on w_font_test_2016.create
this.cb_1=create cb_1
this.dw_verd=create dw_verd
this.dw_cab=create dw_cab
this.dw_mssan=create dw_mssan
this.dw_tahoma=create dw_tahoma
this.dw_nav=create dw_nav
this.Control[]={this.cb_1,&
this.dw_verd,&
this.dw_cab,&
this.dw_mssan,&
this.dw_tahoma,&
this.dw_nav}
end on

on w_font_test_2016.destroy
destroy(this.cb_1)
destroy(this.dw_verd)
destroy(this.dw_cab)
destroy(this.dw_mssan)
destroy(this.dw_tahoma)
destroy(this.dw_nav)
end on

type cb_1 from commandbutton within w_font_test_2016
integer x = 4265
integer width = 343
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Font Size"
end type

event clicked;open(w_font_samples)
//dw_nav.titlebar = true
//dw_cab.titlebar = true
//dw_mssan.titlebar = true
//dw_tahoma.titlebar = true
//dw_verd.titlebar = true
end event

type dw_verd from uo_listbar within w_font_test_2016
integer x = 4270
integer y = 100
integer height = 2428
integer taborder = 10
string title = "Verdana"
string dataobject = "d_sys_nav_menu_verdana"
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event clicked;call super::clicked;if this.titlebar = true then
	 this.titlebar = false
else
	 this.titlebar = true
end if
end event

type dw_cab from uo_listbar within w_font_test_2016
integer x = 1111
integer y = 104
integer height = 2428
integer taborder = 10
string title = "Calibri"
string dataobject = "d_sys_nav_menu_calibri"
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event clicked;call super::clicked;if this.titlebar = true then
	 this.titlebar = false
else
	 this.titlebar = true
end if
end event

type dw_mssan from uo_listbar within w_font_test_2016
integer x = 2162
integer y = 104
integer height = 2428
integer taborder = 10
string title = "MS San Serif"
string dataobject = "d_sys_nav_menu_mssanserif"
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event clicked;call super::clicked;if this.titlebar = true then
	 this.titlebar = false
else
	 this.titlebar = true
end if
end event

type dw_tahoma from uo_listbar within w_font_test_2016
integer x = 3209
integer y = 100
integer height = 2428
integer taborder = 10
string title = "Tahoma"
string dataobject = "d_sys_nav_menu_tahoma"
end type

event constructor;this.settransobject(sqlca)
this.retrieve()
end event

event clicked;call super::clicked;if this.titlebar = true then
	 this.titlebar = false
else
	 this.titlebar = true
end if
end event

type dw_nav from uo_listbar within w_font_test_2016
integer x = 37
integer y = 104
integer height = 2428
integer taborder = 10
string title = "Airel"
string dataobject = "d_sys_nav_menu_arial"
end type

event clicked;if this.titlebar = true then
	 this.titlebar = false
else
	 this.titlebar = true
end if

//If dwo.Name = 'p_close' Then
//	If ib_nav_open then
//		ib_Resize = True
//		this.width = 120
//		Modify( "t_expand.visible = 1 t_dock.visible=1 " )
//		this.vscrollbar = false
//		of_Resizemdi( )
//		parent.dynamic of_Set_spitbar_visible(  false ) 
//		//ib_Dock_Prevent = True
//		//gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_DOCK_STATUS", '0' )
//		ib_nav_open = false
//	Else
//		ib_Dock_Prevent = False
//		parent.dynamic event ue_refreshezmenu(   ) 
//		ib_Resize = True
//		this.vscrollbar = true
//		Modify( "t_expand.visible = 0 t_dock.visible=0 " )
//		this.width = ii_Width
//		of_adjustWidth( )
//		of_Resizemdi( )
//		parent.dynamic of_Set_spitbar_visible(  True  ) 
//		//gnv_user_option.of_Set_option_value(gs_user_id, "EZMENU_DOCK_STATUS", '1' )
//		ib_nav_open = true
//	End If
//End if
end event

event constructor;//overwrite
this.settransobject(sqlca)
this.retrieve()
end event

