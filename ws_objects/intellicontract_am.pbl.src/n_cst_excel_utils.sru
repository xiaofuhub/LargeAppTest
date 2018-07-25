$PBExportHeader$n_cst_excel_utils.sru
forward
global type n_cst_excel_utils from nonvisualobject
end type
end forward

global type n_cst_excel_utils from nonvisualobject
end type
global n_cst_excel_utils n_cst_excel_utils

type variables
PRIVATE:
OLECustomControl   iole_parent //The visual OLEControl put in the window
OLEObject    iole_object //The inner object of the OLEControl:iole_parent.object

end variables

forward prototypes
public function string of_convert_2003 ()
public function integer of_int (olecustomcontrol aole_control)
end prototypes

public function string of_convert_2003 ();Return ''
end function

public function integer of_int (olecustomcontrol aole_control);this.iole_parent = aole_control
this.iole_object = aole_control.object

Return 1
end function

on n_cst_excel_utils.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_excel_utils.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

