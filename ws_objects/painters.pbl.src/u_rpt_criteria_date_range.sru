$PBExportHeader$u_rpt_criteria_date_range.sru
forward
global type u_rpt_criteria_date_range from datawindow
end type
end forward

global type u_rpt_criteria_date_range from datawindow
int Width=2057
int Height=388
int TabOrder=10
string DataObject="d_rpt_criteria_date_range"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type
global u_rpt_criteria_date_range u_rpt_criteria_date_range

event constructor;This.SetTransObject( SQLCA )
This.InsertRow( 0 )
end event

