$PBExportHeader$uo_dm_image_view_cp_help.sru
forward
global type uo_dm_image_view_cp_help from uo_dm_image_view_cp
end type
end forward

global type uo_dm_image_view_cp_help from uo_dm_image_view_cp
end type
global uo_dm_image_view_cp_help uo_dm_image_view_cp_help

on uo_dm_image_view_cp_help.create
int iCurrent
call super::create
end on

on uo_dm_image_view_cp_help.destroy
call super::destroy
end on

type ole_scan from uo_dm_image_view_cp`ole_scan within uo_dm_image_view_cp_help
end type

type ole_thumbnail from uo_dm_image_view_cp`ole_thumbnail within uo_dm_image_view_cp_help
end type

type ole_edit from uo_dm_image_view_cp`ole_edit within uo_dm_image_view_cp_help
end type

event ole_edit::mouseup;//
end event

type st_v from uo_dm_image_view_cp`st_v within uo_dm_image_view_cp_help
end type

type uo_toolbar from uo_dm_image_view_cp`uo_toolbar within uo_dm_image_view_cp_help
end type

type st_doc from uo_dm_image_view_cp`st_doc within uo_dm_image_view_cp_help
end type

type st_1 from uo_dm_image_view_cp`st_1 within uo_dm_image_view_cp_help
end type

type ole_find from uo_dm_image_view_cp`ole_find within uo_dm_image_view_cp_help
end type

