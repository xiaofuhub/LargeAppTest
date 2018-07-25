$PBExportHeader$gride.sru
forward
global type gride from pfc_n_cst_intcred_base
end type
end forward

global type gride from pfc_n_cst_intcred_base
end type
global gride gride

on gride.create
TriggerEvent( this, "constructor" )
end on

on gride.destroy
TriggerEvent( this, "destructor" )
end on

