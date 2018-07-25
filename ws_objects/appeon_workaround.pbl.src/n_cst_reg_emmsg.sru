$PBExportHeader$n_cst_reg_emmsg.sru
$PBExportComments$(Appeon)Toney 06.05.2013 - V141 ISG-CLX
forward
global type n_cst_reg_emmsg from nonvisualobject
end type
end forward

global type n_cst_reg_emmsg from nonvisualobject autoinstantiate
end type

type prototypes
function long DllRegisterServer() library "emmsg.dll"
end prototypes

forward prototypes
public function integer of_register ()
end prototypes

public function integer of_register ();long ll_Result = -1

try
	ll_Result = DllRegisterServer()
	if ll_Result = 0 then Return 0
catch (RuntimeError e)
	//Return -1 //if failed to invoke DllRegisterServer()
end try

Return ll_Result
end function

on n_cst_reg_emmsg.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_reg_emmsg.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

