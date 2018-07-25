$PBExportHeader$uo_image_tool.sru
forward
global type uo_image_tool from picture
end type
end forward

global type uo_image_tool from picture
integer width = 187
integer height = 120
boolean focusrectangle = false
end type
global uo_image_tool uo_image_tool

forward prototypes
public subroutine of_setimagepath (string as_filepath)
public function integer of_getimageoriginalsize (string as_path, ref long al_width, ref long al_height)
end prototypes

public subroutine of_setimagepath (string as_filepath);
If Len( as_filepath ) > 0 Then This.picturename = as_filePath
end subroutine

public function integer of_getimageoriginalsize (string as_path, ref long al_width, ref long al_height);//====================================================================
// Function: of_GetImageSize
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_path
// 	al_Width
// 	al_height
//--------------------------------------------------------------------
// Returns:  integer
//--------------------------------------------------------------------
// Author:	gavin		Date: 2012-04-18
//--------------------------------------------------------------------
//	Copyright (c) 2008-2011 appeon, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

of_SetImagePath( as_Path )

This.originalsize = True

al_width = this.Width

al_Height = this.Height

This.picturename = ""


Return 0
end function

on uo_image_tool.create
end on

on uo_image_tool.destroy
end on

event constructor;visible = false
end event

