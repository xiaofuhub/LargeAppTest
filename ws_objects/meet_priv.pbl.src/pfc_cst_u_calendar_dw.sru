$PBExportHeader$pfc_cst_u_calendar_dw.sru
forward
global type pfc_cst_u_calendar_dw from u_dw
end type
end forward

global type pfc_cst_u_calendar_dw from u_dw
borderstyle borderstyle = stylebox!
end type
global pfc_cst_u_calendar_dw pfc_cst_u_calendar_dw

type variables
Date id_date
end variables

event rowfocuschanged;call super::rowfocuschanged;//This.SelectRow( 0, False)
//This.SelectRow( currentrow, True )
end event

event doubleclicked;Date ld_date

//Start Code Change ----05.26.2009 #V92 maha
IF w_mdi.of_security_access( 350 ) = 0 THEN
	MessageBox("Security","Your role does not have right to view meeting detail.")
	RETURN
END IF
//End Code Change---05.26.2009

//fixed BugN042601	(PB&WEB P3)   Added by  Nova 04.26.2010
IF String( id_date,'yyyy-mm-dd') = '1900-01-01' THEN RETURN

IF This.GetRow( ) = 0 THEN
	OpenWithParm( w_meeting_detail, "New-" + String( id_date ) )
ELSE
	OpenWithParm( w_meeting_detail, String( id_date ) )
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> Keep current dw sync with faclity filter.

/*
This.of_SetTransObject( SQLCA )
This.Retrieve( DateTime( id_date ),gs_user_id )
*/

This.SetRedraw( False )

This.of_SetTransObject( SQLCA )
This.Retrieve( DateTime( id_date ),gs_user_id )

IF IsValid( w_meetings ) THEN
	//IF w_meetings.dw_facility_select.GetItemNumber( 1, "facility_id" ) <> 0 THEN //0 means ALL facilities. //Commented by Scofield on 2008-09-22
	//------------------- APPEON BEGIN -------------------
	//$<modify> Stephen 08.30.2011
	//$<reason> refresh meetings record
	/*
	IF w_meetings.il_facility_id <> 0 THEN
		This.SetFilter( "meetings_facility = " + String(w_meetings.il_facility_id) )
	ELSE
		This.SetFilter( "" )
	END IF
	This.Filter()
	*/
	w_meetings.setredraw(false)
	w_meetings.of_get_month_info(id_date)
	w_meetings.setredraw(true)
	//------------------- APPEON END -------------------
END IF

This.SetRedraw( True )

//---------------------------- APPEON END ----------------------------

end event

event clicked;call super::clicked;//IF This.RowCount( ) > 0 THEN
//	This.SelectRow( 1, True)
//	This.SetRow( 1 )
//	This.ScrollToRow( 1 )
//END IF
//
//
end event

event getfocus;call super::getfocus;IF This.RowCount( ) > 4 THEN
	This.vscrollbar = True
END IF
end event

event losefocus;This.vscrollbar = False

end event

on pfc_cst_u_calendar_dw.create
call super::create
end on

on pfc_cst_u_calendar_dw.destroy
call super::destroy
end on

