$PBExportHeader$nv_prac_info.sru
forward
global type nv_prac_info from nonvisualobject
end type
end forward

global type nv_prac_info from nonvisualobject
end type
global nv_prac_info nv_prac_info

forward prototypes
public function string of_get_name (long id)
end prototypes

public function string of_get_name (long id);String ls_full_name
  
SELECT v_full_name.full_name  
INTO :ls_full_name  
FROM v_full_name  
WHERE v_full_name.prac_id = :id   ;


RETURN ls_full_name
end function

on nv_prac_info.create
TriggerEvent( this, "constructor" )
end on

on nv_prac_info.destroy
TriggerEvent( this, "destructor" )
end on

