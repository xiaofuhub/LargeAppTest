$PBExportHeader$pfc_cst_u_facility_specific_data_1.sru
forward
global type pfc_cst_u_facility_specific_data_1 from userobject
end type
type dw_cont from u_dw within pfc_cst_u_facility_specific_data_1
end type
type cb_5 from commandbutton within pfc_cst_u_facility_specific_data_1
end type
type cb_4 from commandbutton within pfc_cst_u_facility_specific_data_1
end type
type cb_3 from commandbutton within pfc_cst_u_facility_specific_data_1
end type
type cb_2 from commandbutton within pfc_cst_u_facility_specific_data_1
end type
type cb_add from commandbutton within pfc_cst_u_facility_specific_data_1
end type
type dw_4 from u_dw within pfc_cst_u_facility_specific_data_1
end type
type dw_3 from u_dw within pfc_cst_u_facility_specific_data_1
end type
type dw_2 from u_dw within pfc_cst_u_facility_specific_data_1
end type
type dw_1 from u_dw within pfc_cst_u_facility_specific_data_1
end type
end forward

global type pfc_cst_u_facility_specific_data_1 from userobject
integer width = 3086
integer height = 2008
boolean border = true
long backcolor = 33551856
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_cont dw_cont
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_add cb_add
dw_4 dw_4
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
end type
global pfc_cst_u_facility_specific_data_1 pfc_cst_u_facility_specific_data_1

type variables
Integer ii_facility_id
Integer il_prac_id
datawindow idw_current
w_facility_specific_data parent_window
pfc_cst_nv_data_entry_functions inv_data_entry
end variables

forward prototypes
public function integer of_set_facility_id (integer ai_facility_id)
public function integer of_set_prac_id (long al_prac_id)
public function integer of_retrieve_data ()
public function integer of_set_parent_windows (w_facility_specific_data ai_win)
public function integer of_pre_update (datawindow adw)
end prototypes

public function integer of_set_facility_id (integer ai_facility_id);ii_facility_id = ai_facility_id

Return 0
end function

public function integer of_set_prac_id (long al_prac_id);il_prac_id = al_prac_id


Return 0
end function

public function integer of_retrieve_data ();DataWindowChild dwchild1,dwchild2,dwchild3,dwchild4
long	ll_Count1,ll_Count2,ll_Count3,ll_Count4

dw_1.SetTransObject( SQLCA )
dw_2.SetTransObject( SQLCA )
dw_3.SetTransObject( SQLCA )
dw_4.SetTransObject( SQLCA )
dw_cont.SetTransObject( SQLCA )
dw_1.GetChild( "admin_role", dwchild1 )
dwchild1.settransobject(sqlca)
dw_2.GetChild( "committee", dwchild2 )
dwchild2.settransobject(sqlca)
dw_3.GetChild( "rank", dwchild3 )
dwchild3.settransobject(sqlca)
dw_cont.GetChild( "contingency", dwchild4 )
dwchild4.settransobject(sqlca)

gnv_appeondb.of_startqueue()
	ll_Count1 = dwchild1.retrieve( "administrative positions" )
	ll_Count2 = dwchild2.retrieve( "committee" )
	ll_Count3 = dwchild3.retrieve( "rank" )
	ll_Count4 = dwchild4.retrieve( "contingency status" )
	dw_1.Retrieve( ii_facility_id, il_prac_id )
	dw_2.Retrieve( ii_facility_id, il_prac_id )
	dw_3.Retrieve( ii_facility_id, il_prac_id )
	dw_4.Retrieve( ii_facility_id, il_prac_id )
	dw_cont.Retrieve( ii_facility_id, il_prac_id )
gnv_appeondb.of_commitqueue()

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007.07.06 By: Scofield
//$<Reason> Deter popup the parameter input dialog.
if ll_Count1 <= 0 then
	dwchild1.InsertRow(0)
end if
if ll_Count2 <= 0 then
	dwchild2.InsertRow(0)
end if
if ll_Count3 <= 0 then
	dwchild3.InsertRow(0)
end if
if ll_Count4 <= 0 then
	dwchild4.InsertRow(0)
end if
//---------------------------- APPEON END ----------------------------

dw_1.of_SetRowManager( TRUE )
dw_1.of_SetReqColumn( TRUE )
dw_1.of_SetDropDownCalendar( TRUE )
dw_1.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
IF dw_1.RowCount() = 0 THEN
	dw_1.InsertRow( 0 )
END IF

dw_2.of_SetRowManager( TRUE )
dw_2.of_SetReqColumn( TRUE )
dw_2.of_SetDropDownCalendar( TRUE )
dw_2.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
IF dw_2.RowCount() = 0 THEN
	dw_2.InsertRow( 0 )
END IF

dw_3.of_SetRowManager( TRUE )
dw_3.of_SetReqColumn( TRUE )
dw_3.of_SetDropDownCalendar( TRUE )
dw_3.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
IF dw_3.RowCount() = 0 THEN
	dw_3.InsertRow( 0 )
END IF

dw_4.of_SetRowManager( TRUE )
dw_4.of_SetReqColumn( TRUE )
dw_4.of_SetDropDownCalendar( TRUE )
dw_4.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
IF dw_4.RowCount() = 0 THEN
	dw_4.InsertRow( 0 )
END IF

dw_cont.of_SetRowManager( TRUE )
dw_cont.of_SetReqColumn( TRUE )
dw_cont.of_SetDropDownCalendar( TRUE )
dw_cont.iuo_calendar.of_Register(dw_1.iuo_calendar.DDLB)
IF dw_cont.RowCount() = 0 THEN
	dw_cont.InsertRow( 0 )
END IF

dw_1.SetFocus()


Return 0
end function

public function integer of_set_parent_windows (w_facility_specific_data ai_win);parent_window = ai_win

Return 0
end function

public function integer of_pre_update (datawindow adw);
Integer li_rc
Integer i
Long ll_rec_id

li_rc = adw.RowCount()
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<add> 02.24.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
//$<modification> value into database. Refer to of_get_id for more information.

ll_rec_id = gnv_app.of_Get_Id("RECORD_ID" , li_rc) - 1
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	IF adw.GetItemStatus( i, 0, Primary! ) = NewModified! THEN
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-13
		//$<modify> 02.24.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Comment out the following script to reduce client-server interaction.
		//$<modification> refer to PT-12 and of_get_id for more information.
		/*
			ll_rec_id = gnv_app.of_Get_Id("RECORD_ID")
		*/
		
		ll_rec_id ++
		
		//---------------------------- APPEON END ----------------------------

		adw.SetItem( i, "rec_id", ll_rec_id	)
		adw.SetItem( i, "facility_id", ii_facility_id )
		adw.SetItem( i, "prac_id", il_prac_id )
	END IF
END FOR

Return 1
end function

on pfc_cst_u_facility_specific_data_1.create
this.dw_cont=create dw_cont
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_add=create cb_add
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_cont,&
this.cb_5,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_add,&
this.dw_4,&
this.dw_3,&
this.dw_2,&
this.dw_1}
end on

on pfc_cst_u_facility_specific_data_1.destroy
destroy(this.dw_cont)
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_add)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event constructor;inv_data_entry = CREATE pfc_cst_nv_data_entry_functions
end event

type dw_cont from u_dw within pfc_cst_u_facility_specific_data_1
integer x = 1541
integer y = 668
integer width = 1481
integer height = 616
integer taborder = 30
string dataobject = "d_contingency_data"
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current = This
cb_add.enabled = true //Add by Evan 2008-03-18
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()

ret = messagebox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if
end event

event pfc_preupdate;call super::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<comment> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Move the following script to cb_5.clcked event. It can be integrated with
//$<modification> other SQL statements into Appeon Queue labels to reduce client-server interactions.
/*
integer i
i =  of_pre_update( This )

if i >= 0 then
	inv_data_entry.of_field_audit( This )
end if

Return i
*/
Return Success;
//---------------------------- APPEON END ----------------------------
end event

type cb_5 from commandbutton within pfc_cst_u_facility_specific_data_1
integer x = 1934
integer y = 1828
integer width = 347
integer height = 84
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-04
//$<modify> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning
//$<modification> Collect all SQL statements in pfc_preupdate events of dw_1/2/3/4 and dw_cont to
//$<modification> provide the SAVE functionality for the five DataWindows. Refer to PT-5 for more information.
//$<modification> Use Appeon Queue Labels to reduce client-server interactions.

/*
integer i
parent_window.Event pfc_save()
*/
Integer i, c, li_newmodified = 0, cnt
Integer li_loop, li_rowcount, li_total, li_return[]
Long ll_rec_id, li_prac,ll_pager
String ls_dwname[], ls_msg, ls_pager
u_dw ldw_fetch

If dw_4.AcceptText() <> 1 Then Return -1

if dw_4.RowCount() > 0 then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<Modify> 2007.07.06 By: Scofield
	//$<Reason> Change GetItemString to GetItemNumber
	
	//ls_pager = dw_4.getitemstring(1,"lij_beeper")
	ll_pager = dw_4.GetItemNumber(1,"lij_beeper")
	ls_pager = String(ll_pager)
	//---------------------------- APPEON END ----------------------------
	if LenA(ls_pager) > 0 then
		if not isnumber(ls_pager) then
			messagebox("Data Entry Error","Beeper number must be all numbers")
			Return -1
		end if
	end if
	
	If dw_4.Modifiedcount() > 0 Then
		select count(lij_beeper) into :cnt from pd_other_data where facility_id = :ii_facility_id and prac_id <> :il_prac_id and lij_beeper = :ll_pager; //maha 102102
		if cnt > 0 then
			select prac_id into :li_prac from pd_other_data where facility_id = :ii_facility_id and prac_id <> :il_prac_id and lij_beeper = :ll_pager;
			messagebox("Pager Duplication error","Practitioner number " + string(li_prac) + " has this pager number.  Record not saved." )
			Return -1;
		end if
	End If
end if

If dw_1.AcceptText() <> 1 Then Return -1
If dw_2.AcceptText() <> 1 Then Return -1
If dw_3.AcceptText() <> 1 Then Return -1
If dw_cont.AcceptText() <> 1 Then Return -1

c = UpperBound( Parent.Control[] )
For i = 1 to c
	If LeftA( parent.control[i].classname(), 3) <> "dw_" Then continue;
	ldw_fetch = parent.control[i]
	li_rowcount = ldw_fetch.Rowcount()
	If ldw_fetch.Modifiedcount() > 0 Then
		For li_loop = 1 to li_rowcount
			If ldw_fetch.GetItemStatus( li_loop, 0, Primary! ) = NewModified! Then
				li_newmodified ++;
			End If
		Next
	End If
Next

If li_newmodified > 0 Then
	ll_rec_id = gnv_app.of_Get_Id("RECORD_ID" , li_newmodified ) - 1
End If

For i = 1 to c
	If LeftA( parent.control[i].classname(), 3) <> "dw_" Then continue;
	ldw_fetch = parent.control[i]
	li_rowcount = ldw_fetch.Rowcount()
	If ldw_fetch.Modifiedcount() > 0 or ldw_fetch.Deletedcount() > 0 Then
		For li_loop = 1 to li_rowcount
			If ldw_fetch.GetItemStatus( li_loop, 0, Primary! ) = NewModified! Then
				ll_rec_id ++;
				
				ldw_fetch.SetItem( li_loop, "rec_id", ll_rec_id	)
				ldw_fetch.SetItem( li_loop, "facility_id", ii_facility_id )
				ldw_fetch.SetItem( li_loop, "prac_id", il_prac_id )
			End If
		Next
		inv_data_entry.of_field_audit( ldw_fetch )
	End If
Next

gnv_appeondb.of_StartQueue()
If dw_1.Modifiedcount() > 0 or dw_1.Deletedcount() > 0 Then dw_1.Update()
If dw_2.Modifiedcount() > 0 or dw_2.Deletedcount() > 0 Then dw_2.Update()
If dw_3.Modifiedcount() > 0 or dw_3.Deletedcount() > 0 Then dw_3.Update()
If dw_4.Modifiedcount() > 0 or dw_4.Deletedcount() > 0 Then dw_4.Update()
If dw_cont.Modifiedcount() > 0 or dw_cont.Deletedcount() > 0 Then dw_cont.Update()
Commit Using SQLCA;
gnv_appeondb.of_CommitQueue()

Return 1;
//---------------------------- APPEON END ----------------------------

end event

type cb_4 from commandbutton within pfc_cst_u_facility_specific_data_1
integer x = 2693
integer y = 1828
integer width = 343
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;Close( Parent_Window )
end event

type cb_3 from commandbutton within pfc_cst_u_facility_specific_data_1
integer x = 2318
integer y = 1828
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-05
//$<modify> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<modification> Use cb_5 Clicked event instead of pfc_save event to complete save operation.
//$<modification> Refer to PT-04 for more information.
/*
IF parent_window.Event pfc_save() < 0 THEN
	Return
ELSE
	Close( parent_window )
END IF
*/
If cb_5.trigger event clicked() = 1 Then
	Post close( Parent_window )
Else
	Return
End If
//---------------------------- APPEON END ----------------------------
end event

type cb_2 from commandbutton within pfc_cst_u_facility_specific_data_1
integer x = 1563
integer y = 1828
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete"
end type

event clicked;Integer li_ans
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<add> 03.28.2006 By: LiuHongXin
//$<reason> Declare ldw_current to catch idw_current
//$<modification> Define a variable to be used in subsequent script.
datawindow ldw_current
ldw_current = idw_current
//---------------------------- APPEON END ----------------------------

li_ans = MessageBox("Delete", "Are you sure you want to delete this record?", Question!, YesNo!, 1 ) //Modify by Evan 01/12/2008

IF li_ans = 1 THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-07
	//$<modify> 03.28.2006 By: LiuHongXin
	//$<reason> Fix a defect in the original unmodified PowerBuilder application.
	//$<modification> Modify the script to make sure the application work correctly.
	/*
	idw_current.DeleteRow( 0 )
	IF idw_current.RowCount() > 0 THEN
		idw_current.SetRow( 1 )
	END IF
	*/
	ldw_current.DeleteRow( 0 )
	IF ldw_current.RowCount() > 0 THEN
		ldw_current.SetRow( 1 )
	END IF
	//---------------------------- APPEON END ----------------------------
END IF

idw_current.SetFocus()
end event

type cb_add from commandbutton within pfc_cst_u_facility_specific_data_1
integer x = 1184
integer y = 1828
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Add"
end type

event clicked;Integer li_nr

li_nr = idw_current.InsertRow( 0 )
idw_current.SetRow( li_nr )
idw_current.ScrollToRow( li_nr )
idw_current.SetFocus()
end event

type dw_4 from u_dw within pfc_cst_u_facility_specific_data_1
integer x = 37
integer y = 1308
integer width = 2985
integer height = 480
integer taborder = 40
string dataobject = "d_other_data"
boolean vscrollbar = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current = This

cb_add.enabled = false

end event

event pfc_preupdate;call super::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<comment> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Move the follwoing script to cb_5.clcked event. Refer to PT-04 for more information.
/*
integer i
string ls_pager //maha 102102
integer cnt //maha 102102
long li_prac //maha 102102

ls_pager = this.getitemstring(1,"lij_beeper")

if len(ls_pager) > 0 then //  len trap maha 102403
	if not isnumber(ls_pager) then //validation
		messagebox("Data Entry Error","Beeper number must be all numbers")
		i = -1
	end if
end if

select count(lij_beeper) into :cnt from pd_other_data where facility_id = :ii_facility_id and prac_id <> :il_prac_id and lij_beeper = :ls_pager; //maha 102102

if cnt > 0 then //maha 102102 test for duplicate pager number
	select prac_id into :li_prac from pd_other_data where facility_id = :ii_facility_id and prac_id <> :il_prac_id and lij_beeper = :ls_pager;
	messagebox("Pager Duplication error","Practitioner number " + string(li_prac) + " has this pager number.  Record not saved." )
	i = -1
end if

if i >= 0 then
	i =  of_pre_update( This )
end if

if i >= 0 then
	inv_data_entry.of_field_audit( This )
end if
//messagebox("",i)
Return i
*/
Return Success;
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()

ret = messagebox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if
end event

type dw_3 from u_dw within pfc_cst_u_facility_specific_data_1
integer x = 37
integer y = 668
integer width = 1481
integer height = 616
integer taborder = 30
string dataobject = "d_role_data"
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current = This
cb_add.enabled = true //Add by Evan 2008-03-18
end event

event pfc_preupdate;call super::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-09
//$<comment> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Move the follwoing script to cb_5.clcked event. Refer to PT-04 for more information.
/*
integer i
i =  of_pre_update( This )

if i >= 0 then
	inv_data_entry.of_field_audit( This )
end if

Return i
*/
Return Success;
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()

ret = messagebox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if
end event

type dw_2 from u_dw within pfc_cst_u_facility_specific_data_1
integer x = 1541
integer y = 60
integer width = 1486
integer height = 576
integer taborder = 20
string dataobject = "d_committee_data"
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current = This
cb_add.enabled = true //Add by Evan 2008-03-18
end event

event pfc_preupdate;call super::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<comment> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Move the follwoing script to cb_5.clcked event. Refer to PT-04 for more information.
/*
integer i
i =  of_pre_update( This )

if i >= 0 then
	inv_data_entry.of_field_audit( This )
end if

Return i
*/
Return Success;
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()

ret = messagebox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if
end event

type dw_1 from u_dw within pfc_cst_u_facility_specific_data_1
integer x = 37
integer y = 60
integer width = 1481
integer height = 576
integer taborder = 10
string dataobject = "d_admin_role"
borderstyle borderstyle = stylebox!
end type

event getfocus;call super::getfocus;idw_current = This
cb_add.enabled = true //Add by Evan 2008-03-18
end event

event pfc_preupdate;call super::pfc_preupdate;//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<comment> 04.11.2006 By: Rodger Wu
//$<reason> Performance Tuning 
//$<reason> Move the follwoing script to cb_5.clcked event. Refer to PT-04 for more information.
/*
integer i
i =  of_pre_update( This )

if i >= 0 then
	inv_data_entry.of_field_audit( This )
end if

Return i
*/
Return Success;
//---------------------------- APPEON END ----------------------------
end event

event rbuttondown;call super::rbuttondown;integer col
integer ret
datetime dtn

setnull(dtn)

col = this.getclickedcolumn()

ret = messagebox("Set Null?","Would you like to set this date to null?",question!,yesno!,2 )

if ret = 1 then
	this.setitem(row,col,dtn)
end if
end event

event pfc_postupdate;call super::pfc_postupdate;
//inv_data_entry.of_field_audit( This )

return 1
end event

