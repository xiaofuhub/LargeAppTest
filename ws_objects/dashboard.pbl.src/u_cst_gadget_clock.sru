$PBExportHeader$u_cst_gadget_clock.sru
forward
global type u_cst_gadget_clock from u_cst_gadget
end type
type uo_1 from u_cst_clock within u_cst_gadget_clock
end type
end forward

global type u_cst_gadget_clock from u_cst_gadget
string tag = "u_gadget_11.Clock"
integer height = 620
uo_1 uo_1
end type
global u_cst_gadget_clock u_cst_gadget_clock

type variables
Long ll_clock_color[]
Integer ii_color_id
Boolean ib_done = False
end variables

forward prototypes
public subroutine of_set_bg_color (long al_color_value)
public function integer of_settings ()
public function integer of_change_face (integer ai_color_id)
end prototypes

public subroutine of_set_bg_color (long al_color_value);This.backcolor = al_color_value
uo_1.backcolor = al_color_value

/*
uo_1.st_date.backcolor = al_color_value
uo_1.st_day.backcolor = al_color_value
uo_1.st_week.backcolor = al_color_value
*/

end subroutine

public function integer of_settings ();Integer li_ret
Str_clock_color lstr_clock_color_old,lstr_clock_color_new
lstr_clock_color_old.l_color_value[] = ll_clock_color
lstr_clock_color_old.i_color_id = iuo_tabpge_gadget.istr_current_tab.si_clock_face_id
lstr_clock_color_old.uo_gadget_clock = This
OpenwithParm(w_clock_color_select,lstr_clock_color_old)

/* Move script to w_clock_color_select
If Isnull(Message.Powerobjectparm) Then Return 1

lstr_clock_color_new = Message.Powerobjectparm

//If not change
If lstr_clock_color_new.i_color_id = lstr_clock_color_old.i_color_id Then Return 1

of_change_face(lstr_clock_color_new.i_color_id)

li_ret = iuo_tabpge_gadget.of_update_clock_to_db(lstr_clock_color_new.i_color_id )
If li_ret > 0 Then
	//
Else
	Messagebox('Save Error '+ String(li_ret),'Failed to save the settings to DB, please call support.')
	of_change_face(lstr_clock_color_old.i_color_id)
	Return -1
End If
*/
Return 1
end function

public function integer of_change_face (integer ai_color_id);String ls_file_name

If ai_color_id < 1 and ai_color_id > UpperBound(ll_clock_color) Then Return -1

ls_file_name = Gs_Current_Directory + '\Clock_'+String(ai_color_id,'00')+'.bmp'

uo_1.of_set_picture(ls_file_name)
uo_1.of_set_face_color(ll_clock_color[ai_color_id])
uo_1.of_refresh_time( )

Return 1
end function

on u_cst_gadget_clock.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on u_cst_gadget_clock.destroy
call super::destroy
destroy(this.uo_1)
end on

event ue_do;call super::ue_do;String ls_file_name
/*
ls_file_name = of_get_face()
uo_1.of_set_picture(ls_file_name)
*/

If Not ib_done Then
	Post of_change_face(iuo_tabpge_gadget.istr_current_tab.si_clock_face_id)
	ib_done = True
End If

uo_1.of_refresh_time( )


Return 1
end event

event ue_resize_ini;call super::ue_resize_ini;//If uo_1.width <> This.width Then
//	uo_1.width = This.width
//End If

uo_1.x = (This.width - uo_1.width)/2
end event

event constructor;call super::constructor;//Predefine clock color.
ll_clock_color[1] = RGB(0,64,128)
ll_clock_color[2] = RGB(0,128,0)
ll_clock_color[3] = RGB(0,128,192)
ll_clock_color[4] = RGB(64,128,128)
ll_clock_color[5] = RGB(119,202,208)
ll_clock_color[6] = RGB(128,0,128)
ll_clock_color[7] = RGB(128,128,64)
ll_clock_color[8] = RGB(128,128,128)
ll_clock_color[9] = RGB(128,128,255)
ll_clock_color[10] = RGB(129,210,129)
ll_clock_color[11] = RGB(221,211,122)
ll_clock_color[12] = RGB(228,122,179)
ll_clock_color[13] = RGB(238,186,99)
ll_clock_color[14] = RGB(255,0,0)
ll_clock_color[15] = RGB(255,0,255)
ll_clock_color[16] = RGB(255,128,64)

//Set Edit toolbar to visible
of_edit_visible(1)


end event

type dw_content from u_cst_gadget`dw_content within u_cst_gadget_clock
boolean visible = false
integer width = 0
integer height = 0
end type

type ln_split from u_cst_gadget`ln_split within u_cst_gadget_clock
end type

type st_1 from u_cst_gadget`st_1 within u_cst_gadget_clock
end type

type st_title from u_cst_gadget`st_title within u_cst_gadget_clock
end type

type pb_close from u_cst_gadget`pb_close within u_cst_gadget_clock
end type

type pb_max from u_cst_gadget`pb_max within u_cst_gadget_clock
end type

type pb_edit from u_cst_gadget`pb_edit within u_cst_gadget_clock
end type

type uo_1 from u_cst_clock within u_cst_gadget_clock
integer x = 9
integer y = 84
integer width = 1216
integer height = 528
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call u_cst_clock::destroy
end on

