$PBExportHeader$u_tabpg_qrg_build.sru
$PBExportComments$[intellicontract_tab]
forward
global type u_tabpg_qrg_build from u_tabpg_contract_master
end type
end forward

global type u_tabpg_qrg_build from u_tabpg_contract_master
boolean visible = false
end type
global u_tabpg_qrg_build u_tabpg_qrg_build

on u_tabpg_qrg_build.create
call super::create
end on

on u_tabpg_qrg_build.destroy
call super::destroy
end on

type st_1 from u_tabpg_contract_master`st_1 within u_tabpg_qrg_build
end type

