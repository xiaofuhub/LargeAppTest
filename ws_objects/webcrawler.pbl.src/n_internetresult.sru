$PBExportHeader$n_internetresult.sru
forward
global type n_internetresult from internetresult
end type
end forward

global type n_internetresult from internetresult
end type
global n_internetresult n_internetresult

type variables
blob iblb_data
end variables

forward prototypes
public function integer internetdata (blob data)
public function blob of_gethtmlsource ()
end prototypes

public function integer internetdata (blob data);//////////////////////////////////////////////////////////////////////
// $<function> internetdata
// $<arguments>
//			blob	data
// $<returns> integer
// $<description> Get internet data
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.26.2009
//////////////////////////////////////////////////////////////////////

iblb_data = data

Return 1
end function

public function blob of_gethtmlsource ();//////////////////////////////////////////////////////////////////////
// $<function> of_gethtmlsource
// $<arguments>
// $<returns> blob
// $<description> Get HTML source
//////////////////////////////////////////////////////////////////////
// $<add> Evan 03.26.2009
//////////////////////////////////////////////////////////////////////

Return iblb_data
end function

on n_internetresult.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_internetresult.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

