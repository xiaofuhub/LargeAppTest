$PBExportHeader$p_toolbar_button.sru
forward
global type p_toolbar_button from picture
end type
end forward

global type p_toolbar_button from picture
integer width = 105
integer height = 88
boolean originalsize = true
boolean focusrectangle = false
event ue_mousemove pbm_mousemove
event ue_lbuttondown pbm_lbuttondown
event ue_mouseaway ( )
end type
global p_toolbar_button p_toolbar_button

type variables
String	is_UpPic
String	is_NormalPic
String	is_DownPic

long		il_Status = 2		//1: Up, 2: Normal, 3:Down

end variables

forward prototypes
public subroutine of_initpicture (string as_uppic, string as_normalpic, string as_downpic)
public subroutine of_setupstatus ()
public subroutine of_setnormalstatus ()
public subroutine of_setdownstatus ()
public subroutine of_setstatus (long al_status)
public function long of_getstatus ()
end prototypes

event ue_mousemove;if il_Status = 2 then
	of_SetUpStatus()
end if

end event

event ue_lbuttondown;if il_Status = 1 or il_Status = 2 then
	of_SetDownStatus()
else
	of_SetUpStatus()
end if

end event

event ue_mouseaway();if il_Status <> 3 then
	of_SetNormalStatus()
end if

end event

public subroutine of_initpicture (string as_uppic, string as_normalpic, string as_downpic);is_UpPic     = as_UpPic
is_NormalPic = as_NormalPic
is_DownPic   = as_DownPic

This.PictureName = as_NormalPic

end subroutine

public subroutine of_setupstatus ();if il_Status <> 1 then
	This.PictureName = is_UpPic
	il_Status = 1
end if

end subroutine

public subroutine of_setnormalstatus ();if il_Status <> 2 then
	This.PictureName = is_NormalPic
	il_Status = 2
end if

end subroutine

public subroutine of_setdownstatus ();if il_Status <> 3 then
	This.PictureName = is_DownPic
	il_Status = 3
end if

end subroutine

public subroutine of_setstatus (long al_status);Choose Case al_Status
	Case 1
		of_SetUpStatus()
	Case 2
		of_SetNormalStatus()
	Case 3
		of_SetDownStatus()
End Choose

end subroutine

public function long of_getstatus ();Return il_Status

end function

on p_toolbar_button.create
end on

on p_toolbar_button.destroy
end on

