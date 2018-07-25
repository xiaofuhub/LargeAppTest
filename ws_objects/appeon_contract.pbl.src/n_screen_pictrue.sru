$PBExportHeader$n_screen_pictrue.sru
forward
global type n_screen_pictrue from nonvisualobject
end type
end forward

global type n_screen_pictrue from nonvisualobject
end type
global n_screen_pictrue n_screen_pictrue

type variables
string		is_FileKey
string		is_ObjectName
Blob		ibl_Image
end variables

on n_screen_pictrue.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_screen_pictrue.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

