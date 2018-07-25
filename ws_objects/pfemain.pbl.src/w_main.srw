$PBExportHeader$w_main.srw
$PBExportComments$Extension Main Window class
forward
global type w_main from pfc_w_main
end type
end forward

global type w_main from pfc_w_main
end type
global w_main w_main

on w_main.create
call super::create
end on

on w_main.destroy
call super::destroy
end on

event pfc_endtran;call super::pfc_endtran;IF ai_update_results = 1 THEN
	COMMIT USING SQLCA;
END IF

RETURN 1

end event

event open;call super::open;gw_popup[UpperBound(gw_popup[]) + 1] = This //(Appeon)Harry 01.21.2014 - V142 ISG-CLX
end event

