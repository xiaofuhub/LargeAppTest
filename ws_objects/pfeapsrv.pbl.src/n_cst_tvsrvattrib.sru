$PBExportHeader$n_cst_tvsrvattrib.sru
$PBExportComments$Extension TreeView datasource service attributes
forward
global type n_cst_tvsrvattrib from pfc_n_cst_tvsrvattrib
end type
end forward

global type n_cst_tvsrvattrib from pfc_n_cst_tvsrvattrib
end type

type variables
//$<add> 02.19.2008 by Andy
string		is_Datacolumn
end variables

on n_cst_tvsrvattrib.create
call super::create
end on

on n_cst_tvsrvattrib.destroy
call super::destroy
end on

