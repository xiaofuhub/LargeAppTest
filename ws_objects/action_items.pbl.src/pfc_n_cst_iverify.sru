$PBExportHeader$pfc_n_cst_iverify.sru
forward
global type pfc_n_cst_iverify from nonvisualobject
end type
end forward

global type pfc_n_cst_iverify from nonvisualobject
end type
global pfc_n_cst_iverify pfc_n_cst_iverify

on pfc_n_cst_iverify.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_iverify.destroy
TriggerEvent( this, "destructor" )
end on

