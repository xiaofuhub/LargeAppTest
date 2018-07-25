$PBExportHeader$w_verification_de_update.srw
forward
global type w_verification_de_update from w_response
end type
type cb_select from commandbutton within w_verification_de_update
end type
type dw_facility from u_dw within w_verification_de_update
end type
type st_2 from statictext within w_verification_de_update
end type
type st_1 from statictext within w_verification_de_update
end type
type cb_cancel from commandbutton within w_verification_de_update
end type
type cb_update from commandbutton within w_verification_de_update
end type
type dw_forupdate from u_dw within w_verification_de_update
end type
end forward

global type w_verification_de_update from w_response
integer width = 3886
integer height = 688
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
cb_select cb_select
dw_facility dw_facility
st_2 st_2
st_1 st_1
cb_cancel cb_cancel
cb_update cb_update
dw_forupdate dw_forupdate
end type
global w_verification_de_update w_verification_de_update

type variables
Long il_prac_id, il_screen_id, il_rec_id[]
end variables

on w_verification_de_update.create
int iCurrent
call super::create
this.cb_select=create cb_select
this.dw_facility=create dw_facility
this.st_2=create st_2
this.st_1=create st_1
this.cb_cancel=create cb_cancel
this.cb_update=create cb_update
this.dw_forupdate=create dw_forupdate
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_select
this.Control[iCurrent+2]=this.dw_facility
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.cb_update
this.Control[iCurrent+7]=this.dw_forupdate
end on

on w_verification_de_update.destroy
call super::destroy
destroy(this.cb_select)
destroy(this.dw_facility)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_cancel)
destroy(this.cb_update)
destroy(this.dw_forupdate)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-11 By: Rodger Wu (Inova)
//$<reason> This is New object.
/*
Attention!!
	New datawindow:   d_verification_de_update
	                  d_verification_facility_de_update
							d_verification_codeselect_de_update
	New structure:    gs_verif_update
*/
//---------------------------- APPEON END ----------------------------
//Start Code Change ---- 10.30.2006 #1 maha
//modified this screen to simplify the user actions; changed the dw object for dw_facility.
integer i
integer ic
gs_verif_update lstr_verif
integer li_select = 0 // maha 07.23.2013
long ll_resp_code = 0 // maha 07.23.2013

DataWindowChild ldwc_code,ldwc_Temp

ib_disableclosequery = True

lstr_verif = Message.PowerObjectParm
il_prac_id = lstr_verif.al_prac_id
il_screen_id = lstr_verif.al_screen_id
il_rec_id = lstr_verif.al_rec_id
//Start Code Change ----07.23.2013 #V14 maha
li_select = lstr_verif.ai_select
ll_resp_code = lstr_verif.al_resp_code
//End Code Change ----07.23.2013

dw_facility.SetTransObject( SQLCA )
dw_forupdate.SetTransObject( SQLCA )

dw_facility.GetChild( "response_code", ldwc_code )
ldwc_code.SetTransObject( SQLCA )
//<add> 06/28/2007 by: Andy
dw_facility.GetChild( "verification_method", ldwc_Temp )
ldwc_Temp.SetTransObject( SQLCA )
//end of add
//dw_facility.Modify( 'Datawindow.Table.Select = "' + lstr_verif.sql_syntax + '" ' )

gnv_appeondb.of_startqueue()
ldwc_code.Retrieve( "Credentials Verification Response" )
//<add> 06/28/2007 by: Andy
ldwc_Temp.Retrieve( "verification method" )
//end of add
dw_facility.Retrieve(il_rec_id[],il_prac_id)
gnv_appeondb.of_commitqueue()

ic = dw_facility.rowcount() //Rodger Wu added. 12.4.2006

//messagebox("Connected records test",ic)
//Start Code Change ---- 11.27.2006 #V7 maha
if ic < 0 then
	close(this)
	return; //Rodger Wu added. 12.4.2006
	//messagebox("Program error retrieving related verifications","Data window error in w_verification_de_update")
elseif ic = 0 then
	close(this)
	return; //Rodger Wu added. 12.4.2006
//End Code Change---11.27.2006	
ELSEIF dw_facility.Rowcount() = 1 THEN
	dw_facility.SetItem( 1, "selected", 1 )
	cb_select.visible = false
END IF

for i = 1 to ic
	dw_facility.SetItem( i, "date_recieved", Today() )
	dw_facility.SetItem( i, "user_name", gs_user_id )
	//Start Code Change ----07.23.2013 #V14 maha
	if ll_resp_code > 0 then dw_facility.SetItem( i, "response_code", ll_resp_code )
	if li_select > 0 then dw_facility.SetItem( i, "selected", 1 )
	//End Code Change ----07.23.2013
next

dw_facility.of_SetDropDownCalendar( TRUE )
dw_facility.iuo_calendar.of_Register(dw_facility.iuo_calendar.DDLB)

//gs_verif_update lstr_verif
//
//DataWindowChild ldwc_code
//
//ib_disableclosequery = True
//
//lstr_verif = Message.PowerObjectParm
//il_prac_id = lstr_verif.al_prac_id
//il_screen_id = lstr_verif.al_screen_id
//il_rec_id = lstr_verif.al_rec_id
//
//dw_facility.SetTransObject( SQLCA )
//dw_forupdate.SetTransObject( SQLCA )
//
//dw_verify.GetChild( "response_code", ldwc_code )
//ldwc_code.SetTransObject( SQLCA )
//
//dw_facility.Modify( 'Datawindow.Table.Select = "' + lstr_verif.sql_syntax + '" ' )
//
//gnv_appeondb.of_startqueue()
//ldwc_code.Retrieve( "Credentials Verification Response" )
//dw_facility.Retrieve()
//gnv_appeondb.of_commitqueue()
//
//IF dw_facility.Rowcount() = 1 THEN
//	dw_facility.SetItem( 1, "selected", 1 )
//END IF
//
//dw_verify.SetItem( 1, "date_recieved", Today() )
//dw_verify.SetItem( 1, "user_name", gs_user_id )
//
//dw_verify.of_SetDropDownCalendar( TRUE )
//dw_verify.iuo_calendar.of_Register(dw_facility.iuo_calendar.DDLB)
//End Code Change---10.30.2006
end event

type cb_select from commandbutton within w_verification_de_update
integer x = 23
integer y = 556
integer width = 599
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select &All Facilities"
end type

event clicked;Integer i

If this.text = "Select &All Facilities" THEN
	this.text = "&Deselect All Facilities"
	For i = 1 to dw_facility.Rowcount()
		IF dw_facility.GetItemNumber( i, "selected" ) = 0 THEN dw_facility.SetItem( i, "selected", 1 )
	Next
ELSE
	this.text = "Select &All Facilities"
	For i = 1 to dw_facility.Rowcount()
		IF dw_facility.GetItemNumber( i, "selected" ) = 1 THEN dw_facility.SetItem( i, "selected", 0 )
	Next
END IF
end event

type dw_facility from u_dw within w_verification_de_update
integer x = 5
integer y = 212
integer width = 3863
integer height = 328
integer taborder = 10
string dataobject = "d_verification_facility_de_update_maha"
end type

event itemchanged;call super::itemchanged;//Start Code Change ----10.27.2006 #1 maha
// when response is set, set for all other selected rows, if it has not already been set
integer i

if this.getcolumnname( ) = "response_code" then
	this.setitem(this.getrow(),"selected",1) //Start Code Change ----10.23.2012 #V12 maha - set the selected
	for i = 1 to this.rowcount()
		if this.getitemnumber(i,"selected") = 1 then
			if isnull(this.getitemnumber(i,"response_code")) then this.setitem(i,"response_code",long(data))
		end if
	next
 end if
 //End Code Change---10.27.2006
end event

type st_2 from statictext within w_verification_de_update
integer x = 41
integer y = 104
integer width = 2075
integer height = 88
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "To complete, select and set the desired response code(s) and click Update."
boolean focusrectangle = false
end type

type st_1 from statictext within w_verification_de_update
integer x = 41
integer y = 20
integer width = 2423
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "These Verifications/Expiring Credentials are connected to the data record being updated."
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_verification_de_update
integer x = 3479
integer y = 556
integer width = 375
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_update from commandbutton within w_verification_de_update
integer x = 3099
integer y = 556
integer width = 375
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Update"
end type

event clicked;Integer li_rowcount, i
integer cnt
Long ll_facility_id[], ll_code
DateTime ldt_verified

li_rowcount = dw_facility.Rowcount()

//Start Code Change ----07.24.2008 #V85 maha - modified to prevent unselected verifications from being updated deleted junk
For i = 1 to li_rowcount
	IF dw_facility.GetItemNumber( i, "selected" ) = 1 THEN
		cnt++
		if isnull(dw_facility.GetItemNumber( i, "response_code" )) then
			messagebox("Response Code","No Response code is selected for record " + string(i))
			return 1
		end if
	END IF
Next

IF cnt < 1 THEN
	MessageBox( "IntelliSoft", "No Verfication(s) are selected to update." )
	dw_facility.SetFocus()
	Return
END IF

For i = li_rowcount to 1 step -1
	IF dw_facility.GetItemNumber( i, "selected" ) = 0 THEN
		if appeongetclienttype() = "WEB" THEN//added by long.zhang 10.24.2012
			dw_facility.SetItemStatus( i, 0,primary!,NotModified!)		
		else
			dw_facility.rowsdiscard( i, i,primary!)
		end if
	else //Start Code Change ----09.12.2011 #V12 maha -set mod date and user
		dw_facility.setitem(i,"mod_date", datetime(today(),now()))
		dw_facility.setitem(i,"mod_user", gs_user_id)
	end if
Next
//End Code Change---07.24.2008

IF dw_facility.Update() = 1 THEN
	COMMIT USING SQLCA;
	CloseWithReturn( Parent, "OK" )
ELSE
	ROLLBACK USING SQLCA;
	Messagebox( "IntelliSoft", "Update verification(s) failed!" )
END IF
end event

type dw_forupdate from u_dw within w_verification_de_update
boolean visible = false
integer x = 727
integer y = 756
integer width = 1568
integer height = 288
integer taborder = 60
string dataobject = "d_verification_de_update"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

