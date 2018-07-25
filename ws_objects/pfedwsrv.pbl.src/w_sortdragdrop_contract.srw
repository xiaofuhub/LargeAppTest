$PBExportHeader$w_sortdragdrop_contract.srw
$PBExportComments$Extension Drag/Drop Style Sort dialog window
forward
global type w_sortdragdrop_contract from pfc_w_sortdragdrop
end type
end forward

global type w_sortdragdrop_contract from pfc_w_sortdragdrop
end type
global w_sortdragdrop_contract w_sortdragdrop_contract

on w_sortdragdrop_contract.create
call super::create
end on

on w_sortdragdrop_contract.destroy
call super::destroy
end on

type dw_sorted from pfc_w_sortdragdrop`dw_sorted within w_sortdragdrop_contract
end type

type st_3 from pfc_w_sortdragdrop`st_3 within w_sortdragdrop_contract
end type

type st_4 from pfc_w_sortdragdrop`st_4 within w_sortdragdrop_contract
end type

type st_2 from pfc_w_sortdragdrop`st_2 within w_sortdragdrop_contract
end type

type dw_sortcolumns from pfc_w_sortdragdrop`dw_sortcolumns within w_sortdragdrop_contract
end type

type cb_ok from pfc_w_sortdragdrop`cb_ok within w_sortdragdrop_contract
integer x = 1362
end type

type cb_cancel from pfc_w_sortdragdrop`cb_cancel within w_sortdragdrop_contract
integer x = 1746
end type

type cb_dlghelp from pfc_w_sortdragdrop`cb_dlghelp within w_sortdragdrop_contract
integer x = 1746
boolean enabled = false
end type

