$PBExportHeader$w_sheet.srw
$PBExportComments$Extension Sheet Window class
forward
global type w_sheet from pfc_w_sheet
end type
end forward

global type w_sheet from pfc_w_sheet
integer x = 214
integer y = 221
end type
global w_sheet w_sheet

type variables
//---------Begin Added by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
boolean ib_movetozero = true
//---------End Added ------------------------------------------------------------------

end variables

on w_sheet.create
call super::create
end on

on w_sheet.destroy
call super::destroy
end on

event open;call super::open;//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
    move(0,0)  
  */
 if ib_movetozero then move(0,0)	//09.23.2009 by jervis
//---------End Modfiied ------------------------------------------------------------------


end event

