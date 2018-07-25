$PBExportHeader$n_cst_color.sru
$PBExportComments$Extension Color service
forward
global type n_cst_color from pfc_n_cst_color
end type
end forward

global type n_cst_color from pfc_n_cst_color
end type

type variables


constant long INTELLIPURPLE = rgb(211,117,242)
end variables

on n_cst_color.create
call super::create
end on

on n_cst_color.destroy
call super::destroy
end on

