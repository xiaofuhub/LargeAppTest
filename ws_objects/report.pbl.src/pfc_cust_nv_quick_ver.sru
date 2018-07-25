$PBExportHeader$pfc_cust_nv_quick_ver.sru
forward
global type pfc_cust_nv_quick_ver from nonvisualobject
end type
end forward

global type pfc_cust_nv_quick_ver from nonvisualobject
end type
global pfc_cust_nv_quick_ver pfc_cust_nv_quick_ver

forward prototypes
public function integer of_quick_ver_report ()
end prototypes

public function integer of_quick_ver_report ();Return 0


end function

on pfc_cust_nv_quick_ver.create
TriggerEvent( this, "constructor" )
end on

on pfc_cust_nv_quick_ver.destroy
TriggerEvent( this, "destructor" )
end on

