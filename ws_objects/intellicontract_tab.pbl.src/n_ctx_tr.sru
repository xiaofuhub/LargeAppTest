$PBExportHeader$n_ctx_tr.sru
forward
global type n_ctx_tr from transaction
end type
end forward

global type n_ctx_tr from transaction
end type
global n_ctx_tr n_ctx_tr

on n_ctx_tr.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_ctx_tr.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

