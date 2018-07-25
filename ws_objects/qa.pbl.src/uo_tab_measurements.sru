$PBExportHeader$uo_tab_measurements.sru
forward
global type uo_tab_measurements from userobject
end type
type tab_measurements from u_tab_measurments_search within uo_tab_measurements
end type
type tab_measurements from u_tab_measurments_search within uo_tab_measurements
end type
end forward

global type uo_tab_measurements from userobject
integer width = 3653
integer height = 1776
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
tab_measurements tab_measurements
end type
global uo_tab_measurements uo_tab_measurements

on uo_tab_measurements.create
this.tab_measurements=create tab_measurements
this.Control[]={this.tab_measurements}
end on

on uo_tab_measurements.destroy
destroy(this.tab_measurements)
end on

type tab_measurements from u_tab_measurments_search within uo_tab_measurements
integer height = 1752
integer taborder = 11
tabposition tabposition = tabsontop!
end type

event selectionchanged;call super::selectionchanged;/****************************************************************************************************************
** [PUBLIC] EVENT   selectionchanged :: UO_TAB_MEASUREMENTS
**--------------------------------------------------------------------------------------------------------------
** Description:
**--------------------------------------------------------------------------------------------------------------
** Arguments:	[long] oldindex
**				   [long] newindex
**
**--------------------------------------------------------------------------------------------------------------
** Returns:	(LONG) 
**--------------------------------------------------------------------------------------------------------------
** Author:	Michael Skinner 	Date: 		Wednesday November 10 2004
**--------------------------------------------------------------------------------------------------------------
** ModIFication Log:	
**
** Date            Who                   Change  	
**--------------------------------------------------------------------------------------------------------------
**
**
****************************************************************************************************************/

//////////  OVERRIDE!!!!!

iw_parent.dynamic of_accepttext( true)
if iw_parent.function dynamic of_validation( ) <> 1 then 
	return 1 // prevent close
end if

// retrieve IF there is no data in the datastore
IF isvalid(TABpage_detail.Lds_appointment_dates) and tabpage_browse.dw_1.rowcount( ) > 0  THEN
	IF TABpage_detail.Lds_appointment_dates.rowcount() < 1 THEN
			TABpage_detail.Lds_appointment_dates.retrieve(tabpage_browse.dw_1.object.prac_id[1])
			TABpage_detail.of_get_appointment_dates('insert')
		ELSE
			// only retrieve IF the prac id has been changed
			IF tabpage_browse.dw_1.object.prac_id[1] <> TABpage_detail.Lds_appointment_dates.object.prac_id[1] THEN
					if this.tabpage_browse.dw_1.getrow() < 1 then
						this.of_messagebox( '', "Select Row", 'Please select a row.',Information!, ok!, 1)
						return 1
					end if
						
				TABpage_detail.Lds_appointment_dates.retrieve(tabpage_browse.dw_1.object.prac_id[1])
		  end IF 
	END IF 
END IF




end event

