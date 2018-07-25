$PBExportHeader$w_facility_specific_data.srw
forward
global type w_facility_specific_data from w_response
end type
type uo_1 from pfc_cst_u_facility_specific_data_1 within w_facility_specific_data
end type
end forward

global type w_facility_specific_data from w_response
integer x = 142
integer y = 112
integer width = 3136
integer height = 2092
string title = "Facility Specific Data"
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
uo_1 uo_1
end type
global w_facility_specific_data w_facility_specific_data

type variables

end variables

on w_facility_specific_data.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_facility_specific_data.destroy
call super::destroy
destroy(this.uo_1)
end on

event open;call super::open;Integer li_facility_id
Long ll_prac_id
string ls_fname

li_facility_id = Integer( MidA( Message.StringParm, 1, PosA( Message.StringParm, "-" ) -1 ) )
ll_prac_id = Long( MidA( Message.StringParm, PosA( Message.StringParm, "-" ) +1, 100) )



if li_facility_id < 1 then
	messagebox("Facility Data Error","There is no Affiation Facility data at this time. ~r Be sure you have saved the Appointment status Record.")
	close (this)
else
	uo_1.of_Set_Parent_Windows( This )
	uo_1.of_Set_Facility_id( li_facility_id )
	uo_1.of_Set_Prac_id( ll_prac_id )
	uo_1.of_Retrieve_data()
	//select facility_name into :ls_fname from facility where facility_id = :li_facility_id;//maha 102102
	IF gs_cust_type = "I" THEN //trap added maha 020904 
		This.Title = w_prac_data_intelliapp.Title + " Facility Level Data"
	ELSE
		This.Title = w_prac_data_1.Title + " Facility Level Data"
	END IF
end if

if w_mdi.of_security_access( 50 ) < 2 then
	uo_1.dw_1.enabled = false
	uo_1.dw_2.enabled = false
	uo_1.dw_3.enabled = false
	uo_1.dw_4.enabled = false
	uo_1.dw_cont.enabled = false
	uo_1.cb_2.enabled = false
	uo_1.cb_5.enabled = false
	uo_1.cb_add.enabled = false
end if
end event

event closequery;//Override

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.12.2008 By: Evan
//$<reason> Fix BugS122812 about failed to saved data.
long ll_ModifiedCount

uo_1.dw_1.AcceptText()
uo_1.dw_2.AcceptText()
uo_1.dw_3.AcceptText()
uo_1.dw_4.AcceptText()
uo_1.dw_cont.AcceptText()
ll_ModifiedCount = uo_1.dw_1.ModifiedCount() + uo_1.dw_1.DeletedCount()
ll_ModifiedCount += uo_1.dw_2.ModifiedCount() + uo_1.dw_2.DeletedCount()
ll_ModifiedCount += uo_1.dw_3.ModifiedCount() + uo_1.dw_3.DeletedCount()
ll_ModifiedCount += uo_1.dw_4.ModifiedCount() + uo_1.dw_4.DeletedCount()
ll_ModifiedCount += uo_1.dw_cont.ModifiedCount() + uo_1.dw_cont.DeletedCount()

if ll_ModifiedCount > 0 then
	if MessageBox("Save data", "Close without saving changes?", Question!, YesNo!) = 2 then
		Return 1
	end if
end if
//---------------------------- APPEON END ----------------------------
end event

type uo_1 from pfc_cst_u_facility_specific_data_1 within w_facility_specific_data
integer taborder = 10
boolean bringtotop = true
boolean border = false
end type

on uo_1.destroy
call pfc_cst_u_facility_specific_data_1::destroy
end on

