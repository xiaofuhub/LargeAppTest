$PBExportHeader$w_pagesetup.srw
$PBExportComments$Extension Page Setup window
forward
global type w_pagesetup from pfc_w_pagesetup
end type
end forward

global type w_pagesetup from pfc_w_pagesetup
long backcolor = 33551856
end type
global w_pagesetup w_pagesetup

on w_pagesetup.create
call super::create
end on

on w_pagesetup.destroy
call super::destroy
end on

type st_size from pfc_w_pagesetup`st_size within w_pagesetup
long backcolor = 16774640
end type

type st_source from pfc_w_pagesetup`st_source within w_pagesetup
long backcolor = 16774640
end type

type rb_portrait from pfc_w_pagesetup`rb_portrait within w_pagesetup
long backcolor = 16774640
end type

type rb_landscape from pfc_w_pagesetup`rb_landscape within w_pagesetup
long backcolor = 16774640
end type

type gb_orientation from pfc_w_pagesetup`gb_orientation within w_pagesetup
long backcolor = 16774640
end type

type ddlb_size from pfc_w_pagesetup`ddlb_size within w_pagesetup
end type

type ddlb_source from pfc_w_pagesetup`ddlb_source within w_pagesetup
end type

type gb_paper from pfc_w_pagesetup`gb_paper within w_pagesetup
long backcolor = 16774640
end type

type cb_ok from pfc_w_pagesetup`cb_ok within w_pagesetup
end type

type cb_cancel from pfc_w_pagesetup`cb_cancel within w_pagesetup
end type

type st_left from pfc_w_pagesetup`st_left within w_pagesetup
long backcolor = 16774640
end type

type st_top from pfc_w_pagesetup`st_top within w_pagesetup
long backcolor = 16774640
end type

type em_left from pfc_w_pagesetup`em_left within w_pagesetup
end type

type em_top from pfc_w_pagesetup`em_top within w_pagesetup
end type

type st_right from pfc_w_pagesetup`st_right within w_pagesetup
long backcolor = 16774640
end type

type st_bottom from pfc_w_pagesetup`st_bottom within w_pagesetup
long backcolor = 16774640
end type

type em_right from pfc_w_pagesetup`em_right within w_pagesetup
end type

type em_bottom from pfc_w_pagesetup`em_bottom within w_pagesetup
end type

type cb_dlghelp from pfc_w_pagesetup`cb_dlghelp within w_pagesetup
end type

type gb_margins from pfc_w_pagesetup`gb_margins within w_pagesetup
long backcolor = 16774640
end type

