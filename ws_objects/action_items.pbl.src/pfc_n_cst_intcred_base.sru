$PBExportHeader$pfc_n_cst_intcred_base.sru
forward
global type pfc_n_cst_intcred_base from nonvisualobject
end type
end forward

global type pfc_n_cst_intcred_base from nonvisualobject
end type
global pfc_n_cst_intcred_base pfc_n_cst_intcred_base

on pfc_n_cst_intcred_base.create
TriggerEvent( this, "constructor" )
end on

on pfc_n_cst_intcred_base.destroy
TriggerEvent( this, "destructor" )
end on

