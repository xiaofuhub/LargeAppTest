$PBExportHeader$pfc_cst_u_profile_views_manager.sru
forward
global type pfc_cst_u_profile_views_manager from pfc_cst_u_views_manager
end type
type st_prof from st_1 within pfc_cst_u_profile_views_manager
end type
type st_2 from statictext within pfc_cst_u_profile_views_manager
end type
end forward

global type pfc_cst_u_profile_views_manager from pfc_cst_u_views_manager
integer width = 2885
st_prof st_prof
st_2 st_2
end type
global pfc_cst_u_profile_views_manager pfc_cst_u_profile_views_manager

type variables
Integer ii_profile_view_id
Boolean ib_create = FALSE //Alfee 02.16.2009

w_profile_view_manager iwin
end variables

forward prototypes
public function integer of_save ()
public function integer of_retrieve ()
public function integer of_set_parent_window (w_profile_view_manager ai_win)
public subroutine of_copy_report_data (integer ai_data_view_id)
end prototypes

public function integer of_save ();
//-------Begin Modified by Alfee 02.16.2009---------------------------
//Save only while data in dw_selected changed

Integer i, li_report_id_del[], li_report_id_add[], li_rtn = 1
dwItemStatus l_status
pfc_cst_nv_profile_report_functions lnv_report

IF dw_selected.modifiedcount() < 1 AND dw_selected.deletedcount() < 1 THEN RETURN 0
lnv_report = Create pfc_cst_nv_profile_report_functions 

//Get new or deleted profile report ids
IF dw_selected.deletedcount() > 0 THEN 
	FOR i = 1 to dw_available.RowCount()
		li_report_id_del[UpperBound(li_report_id_del) + 1] = dw_available.object.profile_report_id[i]
	NEXT
END IF

IF dw_selected.modifiedcount() > 0 THEN
	FOR i = 1 to dw_selected.RowCount()
		l_status = dw_selected.getitemstatus( i, 0, Primary!) 
		IF l_status = New! OR l_status = NewModified! THEN
			li_report_id_add[UpperBound(li_report_id_add) + 1] = dw_selected.GetItemNumber(i, "profile_report_id")
		END IF
	NEXT
END IF

//Update data into DB
IF dw_selected.Update() = 1 THEN  //update profile_view_reports
	IF UpperBound(li_report_id_del) > 0 THEN //delete data in all related tables
		li_rtn = lnv_report.of_delete_screen_properties( ii_profile_view_id, li_report_id_del,'P')
	END IF
	IF li_rtn > 0 and UpperBound(li_report_id_add) > 0 THEN //update in dw_view_report_fields & screen_report_objects
		li_rtn = lnv_report.of_add_screen2view( ii_profile_view_id, li_report_id_add)
	END IF
ELSE
	li_rtn = -1
END IF

RETURN li_rtn
/*
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-03
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Commit label to reduce client-server interactions to improve runtime performance.

/*
IF dw_views.Update( True, False ) = 1 THEN
	IF dw_selected.Update( True, False ) = 1 THEN
		COMMIT USING SQLCA;
		DataWindowChild dwchild
		dw_select.Reset()
		dw_select.of_SetTransObject( SQLCA )
		dw_select.InsertRow( 0 )
		dw_select.GetChild( "profile_view_id", dwchild )
		dwchild.SetTransObject( SQLCA )
		dwchild.Retrieve()		
		dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )				
		dw_selected.ResetUpdate ( )
		dw_views.ResetUpdate ( )
	ELSE
		ROLLBACK USING SQLCA;
	END IF
ELSE
	ROLLBACK USING SQLCA;
END IF
*/

SetPointer(HourGlass!)

IF dw_to_report_fields.Update( True, False ) = 1 THEN
	IF dw_to_screen_report.Update( True, False ) = 1 THEN
		IF dw_to_profile_report.Update( True, False ) = 1 THEN
			IF dw_to_report_object.Update( True, False ) = 1  THEN
				dw_to_report_fields.ResetUpdate()
				dw_to_screen_report.ResetUpdate()
				dw_to_profile_report.ResetUpdate()
				dw_to_report_object.ResetUpdate()
			ELSE
				ROLLBACK USING SQLCA;
				RETURN -1
			END IF								
		ELSE
			ROLLBACK USING SQLCA;
			RETURN -1
		END IF
	ELSE
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
ELSE
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

if gnv_appeondb.of_update( dw_views, dw_selected) > 0 then
	DataWindowChild dwchild
	dw_select.Reset()
	dw_select.of_SetTransObject( SQLCA )
	dw_select.InsertRow( 0 )
	dw_select.GetChild( "profile_view_id", dwchild )
	dwchild.SetTransObject( SQLCA )
	dwchild.Retrieve()		
	dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )				
	dw_selected.ResetUpdate ( )
	dw_views.ResetUpdate ( )
END IF


//---------------------------- APPEON END ----------------------------

Return 0
*/
//----------End Modified----------------------------------------------


end function

public function integer of_retrieve ();dw_select.TriggerEvent( ItemChanged! )

Return 0
end function

public function integer of_set_parent_window (w_profile_view_manager ai_win);iwin = ai_win

Return 1
end function

public subroutine of_copy_report_data (integer ai_data_view_id);//
integer  i
long		ll_count1,ll_count2,ll_count3,ll_count4

dw_copy_report_fields.Reset()
dw_copy_report_fields.of_SetTransObject( SQLCA )

dw_to_report_fields.Reset()
dw_to_report_fields.of_SetTransObject( SQLCA )


dw_copy_screen_report.Reset()
dw_copy_screen_report.of_SetTransObject( SQLCA )

dw_to_screen_report.Reset()
dw_to_screen_report.of_SetTransObject( SQLCA )


dw_copy_profile_report.Reset()
dw_copy_profile_report.of_SetTransObject( SQLCA )

dw_to_profile_report.Reset()
dw_to_profile_report.of_SetTransObject( SQLCA )

dw_copy_report_object.Reset()
dw_copy_report_object.of_SetTransObject( SQLCA )

dw_to_report_object.Reset()
dw_to_report_object.of_SetTransObject( SQLCA )

gnv_appeondb.of_startqueue( ) //alfee 02.16.2009

ll_count1 = dw_copy_report_fields.retrieve(ai_data_view_id)
ll_count2 = dw_copy_screen_report.retrieve(ai_data_view_id)
ll_count3 = dw_copy_profile_report.retrieve(ai_data_view_id)
ll_count4 = dw_copy_report_object.retrieve(ai_data_view_id)

//---------Begin Added by Alfee on 02.16.2009 --------
//Get Max ids
SELECT Max( data_view_report_fields.data_view_field_id )  
INTO :il_report_field_id  FROM data_view_report_fields  ;

SELECT Max( screen_report_objects.data_view_object_id )  
INTO :il_screen_report_objectid FROM screen_report_objects  ;

SELECT Max(data_view_report_objects.data_view_object_id)  
INTO :il_report_object_id FROM data_view_report_objects  ;

gnv_appeondb.of_commitqueue( ) 

IF IsNull(il_report_field_id) THEN  il_report_field_id = 0
IF IsNull(il_report_object_id) THEN  il_report_object_id = 0
IF IsNull(il_screen_report_objectid) THEN  il_screen_report_objectid = 0
il_report_field_id ++
il_report_object_id ++
il_screen_report_objectid ++
//---------End Added ----------------------------------------

//-----Begin Added by Alfee 06.05.2009----------------
//<$Reason>Can't get the row count in an Appeon Queue
ll_count1 = dw_copy_report_fields.rowcount()
ll_count2 = dw_copy_screen_report.rowcount()
ll_count3 = dw_copy_profile_report.rowcount()
ll_count4 = dw_copy_report_object.rowcount()
//------End Added ------------------------------------

if  ll_count1>0 and dw_copy_report_fields.rowscopy(1,ll_count1,primary!,dw_to_report_fields,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count1
	dw_to_report_fields.SetItem( i, "profile_view_id", ii_profile_view_id )
	il_report_field_id++
	dw_to_report_fields.SetItem( i, "data_view_field_id", il_report_field_id )
next

if ll_count2>0 and dw_copy_screen_report.rowscopy(1,ll_count2,primary!,dw_to_screen_report,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count2
	dw_to_screen_report.SetItem( i, "profile_view_id", ii_profile_view_id )
	il_screen_report_objectid++
	dw_to_screen_report.SetItem( i, "data_view_object_id", il_screen_report_objectid )
next

if ll_count3>0 and dw_copy_profile_report.rowscopy(1,ll_count3,primary!,dw_to_profile_report,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count3
	dw_to_profile_report.SetItem( i, "profile_view_id", ii_profile_view_id )
next

if ll_count4>0 and dw_copy_report_object.rowscopy(1,ll_count4,primary!,dw_to_report_object,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count4
	dw_to_report_object.SetItem( i, "profile_view_id", ii_profile_view_id )
	il_report_object_id++
	dw_to_report_object.SetItem( i, "data_view_object_id", il_report_object_id )
next

//---------Begin Added by Alfee 02.16.2009--------------------
//<$reason>Update directly for copy profile operation
IF gnv_appeondb.of_update( dw_views, dw_selected, dw_to_report_fields) > 0 THEN
	gnv_appeondb.of_update( dw_to_screen_report, dw_to_profile_report, dw_to_report_object) 	
END IF
//----------End Added ------------------------------------------



end subroutine

on pfc_cst_u_profile_views_manager.create
int iCurrent
call super::create
this.st_prof=create st_prof
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_prof
this.Control[iCurrent+2]=this.st_2
end on

on pfc_cst_u_profile_views_manager.destroy
call super::destroy
destroy(this.st_prof)
destroy(this.st_2)
end on

event constructor;call super::constructor;is_sort_field = "sort_order"
dw_views.of_settransobject( sqlca)//long.zhang 12.05.2013 Db error datatrans information not available	BugL120402 
end event

type cb_clear_all from pfc_cst_u_views_manager`cb_clear_all within pfc_cst_u_profile_views_manager
integer x = 1307
integer y = 1872
integer taborder = 320
end type

type cb_clear from pfc_cst_u_views_manager`cb_clear within pfc_cst_u_profile_views_manager
integer x = 1243
integer y = 468
integer width = 398
integer taborder = 70
end type

event cb_clear::clicked;Integer li_cr
Integer li_rc
Integer i
Integer li_report_id
Integer li_nr
Integer li_found
String ls_report_name


li_cr = dw_selected.GetRow()

IF li_cr = 0 THEN
	MessageBox("Select Profile", "You must first select a PROFILE before adding sections.")
	Return
END IF

li_report_id = dw_selected.GetItemNumber( li_cr, "profile_report_id" )

dw_selected.DeleteRow( li_cr )

li_found = dw_selected_dump.Find( "profile_report_id = " + String( li_report_id ), 1, dw_selected_dump.RowCount() )


dw_selected_dump.RowsMove( li_found, li_found, Primary!, dw_available, 1000, Primary! )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/12/2008 By: Ken.Guo
//$<reason> Fix BugK011201
//IF dw_selected.RowCount() = 1 THEN
cb_add.Enabled = True
IF dw_selected.RowCount() < 1 THEN
//---------------------------- APPEON END ----------------------------
	This.Enabled = False
END IF

li_rc = dw_selected.RowCount()
FOR i = 1 TO li_rc
	dw_selected.SetItem( i, "sort_order", i )
END FOR

dw_selected_dump.Sort( )

IF li_cr > dw_selected.RowCount() THEN
	li_cr = dw_selected.RowCount()
END IF

IF dw_selected.RowCount() > 0 THEN
	dw_selected.SelectRow( 0, False )
	dw_selected.SelectRow( li_cr, True )
	dw_selected.SetRow( li_cr )
	dw_selected.ScrollToRow( li_cr )
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/12/2008 By: Ken.Guo
//$<reason> Set Hightlight to dw_available row 
If dw_available.Rowcount() > 0 Then
	li_cr = dw_available.Rowcount()
	dw_available.SelectRow( 0, False )
	dw_available.SelectRow( li_cr, True )
	dw_available.SetRow( li_cr )
	dw_available.ScrollToRow( li_cr )
End If
//---------------------------- APPEON END ----------------------------

end event

type cb_add_all from pfc_cst_u_views_manager`cb_add_all within pfc_cst_u_profile_views_manager
integer x = 1230
integer y = 1768
integer taborder = 300
end type

type cb_add from pfc_cst_u_views_manager`cb_add within pfc_cst_u_profile_views_manager
integer x = 1243
integer width = 398
integer taborder = 60
end type

event cb_add::clicked;Integer li_cr
Integer li_report_id
Integer li_nr
String ls_report_name
Integer li_selected_row_count


li_cr = dw_available.GetRow()
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 01/12/2008 By: Ken.Guo
//$<reason> Fix BugK122407 about sometimes show error when doubleclick its bottom.
//Because Getrow() > Rowcount(), Maybe PB's Bug.
//IF li_cr = 0 THEN
IF li_cr = 0 or li_cr > dw_available.rowcount() THEN
//---------------------------- APPEON END ----------------------------	
	MessageBox("Select Profile", "You must first select a PROFILE before adding sections.")
	Return
END IF

li_report_id = dw_available.GetItemNumber( li_cr, "profile_report_id" )
ls_report_name = dw_available.GetItemString( li_cr, "profile_report_name" )

dw_available.RowsMove( li_cr, li_cr, Primary!, dw_selected_dump, 1000, Primary! )

li_nr = dw_selected.InsertRow( 0 )
dw_selected.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
dw_selected.SetItem( li_nr, "profile_report_id", li_report_id )
dw_selected.SetItem( li_nr, "sort_order", li_nr )
dw_selected.SetItem( li_nr, "report_name", ls_report_name )

cb_clear.Enabled = True

IF dw_available.RowCount() = 0 THEN
	This.Enabled = False
END IF

li_cr = dw_selected.RowCount()

dw_selected.SelectRow( 0, False )
dw_selected.SelectRow( li_cr, True )
dw_selected.SetRow( li_cr )
dw_selected.ScrollToRow( li_cr )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01/12/2008 By: Ken.Guo
//$<reason> Set Hightlight to dw_available row 
If dw_available.Rowcount() > 0 Then
	li_cr = dw_available.Getrow()
	If li_cr > dw_available.Rowcount() Then li_cr = dw_available.Rowcount()
	dw_available.SelectRow( 0, False )
	dw_available.SelectRow( li_cr, True )
	dw_available.SetRow( li_cr )
	dw_available.ScrollToRow( li_cr )
End If
//---------------------------- APPEON END ----------------------------



end event

type dw_selected from pfc_cst_u_views_manager`dw_selected within pfc_cst_u_profile_views_manager
integer x = 1673
integer width = 1207
integer taborder = 110
string title = "Selected Data"
string dataobject = "d_pfc_selected_reports"
end type

event dw_selected::rowfocuschanged;call super::rowfocuschanged;IF currentrow = 2 AND is_sort_field <> "sort_order" THEN
	cb_up.Enabled = False
ELSE
	cb_up.Enabled = True
END IF

IF dw_selected.RowCount() = currentrow THEN
	cb_down.Enabled = False
ELSE
	cb_down.Enabled = True
END IF
end event

event dw_selected::pfc_retrieve;Return This.Retrieve( ii_profile_view_id )
end event

type dw_available from pfc_cst_u_views_manager`dw_available within pfc_cst_u_profile_views_manager
integer x = 5
integer width = 1211
integer taborder = 100
string title = "Available Data"
string dataobject = "d_prf_sub_report_list"
end type

event dw_available::pfc_retrieve;Return Retrieve()
end event

type dw_select from pfc_cst_u_views_manager`dw_select within pfc_cst_u_profile_views_manager
integer x = 41
integer width = 919
integer height = 80
integer taborder = 290
string dataobject = "d_pfl_select_views_dddw_list_no_hdr"
end type

event dw_select::itemchanged;Integer li_ans
IF dw_selected.ModifiedCount() + dw_selected.DeletedCount() > 0 THEN
	li_ans = MessageBox("Save Changes", "Save changes to view?", Question!, YesNo!, 1 )
	IF li_ans = 1 THEN
		IF of_save() = -1 THEN
			Return -1
		END IF
	END IF
END IF

ii_profile_view_id = Integer( data )
//if data='-999' then
//	cb_3.enabled=false
//else
//	cb_3.enabled=true
//end if
SetPointer(HourGlass!)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.07.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
IF dw_selected.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
	//Error handling and messaging
	RETURN
ELSE
	SQLCA.of_commit()
END IF

IF dw_available.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
	//Error handling and messaging
	RETURN
ELSE
	SQLCA.of_commit()
END IF

Parent.SetRedraw( False )

dw_views.Retrieve( Integer( data ) )
*/
gnv_appeondb.of_startqueue( )

dw_selected.Retrieve( ii_profile_view_id )
dw_available.Retrieve()
Parent.SetRedraw( False )
dw_views.Retrieve( Integer( data ) )

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------

of_rid_duplicates( "profile_report_id", "profile_report_id", "profile_report_description" )

dw_available.SelectRow( 0, False )
dw_selected.SelectRow( 1, True )

of_enable_select_buttons()

Parent.SetRedraw( True )






end event

event dw_select::constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
//This.SetItem( 1, "profile_view_id", 1 )
This.SetRow( 1 )
This.ScrollToRow( 1 )

ii_profile_view_id = 1

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-04-28 By: Liu Hongxin
//$<reason> Fix a defect.
//if AppeonGetClientType() <> "PB" then
//	This.SetItem( 1, "profile_view_id", -999 )
//end if
//---------------------------- APPEON END ----------------------------

Long ll_ret
datawindowchild dwchild
dw_select.SetItem(1,'profile_view_id',1)
ll_ret = dwchild.Find('profile_view_id = 1',1,dwchild.rowcount())
dw_select.event itemchanged( ll_ret, dw_select.object.profile_view_id, '1')
end event

type cb_save from pfc_cst_u_views_manager`cb_save within pfc_cst_u_profile_views_manager
integer x = 2094
integer y = 36
end type

type cb_2 from pfc_cst_u_views_manager`cb_2 within pfc_cst_u_profile_views_manager
integer x = 2455
integer y = 36
integer taborder = 50
boolean cancel = true
end type

event cb_2::clicked;//overrided by alfee 02.16.2009

Integer li_rtn
IF dw_selected.Modifiedcount( ) > 0 OR dw_selected.Deletedcount( ) > 0 THEN
	li_rtn = MessageBox("Close","Do you want to save the changes?", Question!,YesNoCancel!,1)
	IF li_rtn = 1 THEN 
		//cb_1.Event Clicked()
		cb_save.Event Clicked() //alfee 10.12.2012
		dw_selected.Reset()
		of_close()
	ELSEIF li_rtn = 2 THEN
		dw_selected.Reset()
		of_close()
	END IF	
ELSE
	of_close()
END IF

end event

type dw_copy_from_fields from pfc_cst_u_views_manager`dw_copy_from_fields within pfc_cst_u_profile_views_manager
integer x = 1842
integer y = 888
integer width = 535
integer taborder = 280
end type

type dw_copy_to_fields from pfc_cst_u_views_manager`dw_copy_to_fields within pfc_cst_u_profile_views_manager
integer x = 1929
integer y = 916
integer width = 608
integer taborder = 260
end type

event dw_copy_to_fields::constructor;This.of_SetUpdateAble( False )
end event

type dw_copy_from_objects from pfc_cst_u_views_manager`dw_copy_from_objects within pfc_cst_u_profile_views_manager
integer x = 1856
integer y = 764
integer width = 654
integer taborder = 240
end type

type dw_copy_to_objects from pfc_cst_u_views_manager`dw_copy_to_objects within pfc_cst_u_profile_views_manager
integer x = 1755
integer y = 1376
integer width = 791
integer taborder = 220
end type

event dw_copy_to_objects::constructor;call super::constructor;This.of_SetUpdateAble( False )
end event

type dw_views from pfc_cst_u_views_manager`dw_views within pfc_cst_u_profile_views_manager
integer x = 1577
integer y = 1188
integer width = 379
integer height = 100
integer taborder = 200
string dataobject = "d_pfl_select_views_dddw_list"
end type

type cb_delete from pfc_cst_u_views_manager`cb_delete within pfc_cst_u_profile_views_manager
integer x = 983
integer y = 120
integer width = 361
string text = "&Delete Profile"
end type

event cb_delete::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> (None)
// $<description>  Delete Profile
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Stephen 04.13.2011
//////////////////////////////////////////////////////////////////////

Integer li_ans
Integer li_Rc
Integer i
Long ll_ret
DataWindowChild dwchild

IF ii_profile_view_id = 1 THEN
	MessageBox("Invalid Option", "The Default system profile can't be deleted!")
	Return
END IF

IF ii_profile_view_id = 999 THEN
	MessageBox("Invalid Option", "The Quick system profile can't be deleted!")
	Return
END IF

li_ans = MessageBox("Delete Profile", "Are you sure you want to delete the selected Profile?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return 
END IF

delete from data_view_report_fields where profile_view_id = :ii_profile_view_id;
delete from data_view_report_objects where profile_view_id = :ii_profile_view_id;
delete from screen_report_objects where profile_view_id = :ii_profile_view_id;
delete from profile_report_dw where profile_view_id = :ii_profile_view_id;

delete from profile_view where profile_view_id = :ii_profile_view_id;
delete from profile_view_reports where profile_view_id = :ii_profile_view_id;

dw_select.Reset()
dw_select.of_SetTransObject( SQLCA )
dw_select.InsertRow( 0 )
dw_select.GetChild( "profile_view_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

dw_select.SetItem(1,'profile_view_id',1)
ll_ret = dwchild.Find('profile_view_id = 1',1,dwchild.rowcount())
dw_select.event itemchanged( ll_ret, dw_select.object.profile_view_id, '1')

of_enable_select_buttons()
end event

type cb_new from pfc_cst_u_views_manager`cb_new within pfc_cst_u_profile_views_manager
integer x = 983
integer y = 36
integer width = 361
integer taborder = 10
string text = "&Create Profile"
end type

event cb_new::clicked;Integer li_profile_view_id
Integer li_nr
String ls_profile_view_name
datawindowchild ldc_profile_view_id

IF of_save() = -1 THEN
	Return -1
END IF

Open( w_get_profile_view_name )

ls_profile_view_name = Message.StringParm

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03/18/2008 By: Ken.Guo
//$<reason> Add Trap
If ls_profile_view_name = 'Cancel' or ls_profile_view_name = '' Then
	Return 0
End If
//---------------------------- APPEON END ----------------------------

SELECT Max( profile_view.profile_view_id )  
INTO :li_profile_view_id  
FROM profile_view  ;

ii_profile_view_id = li_profile_view_id + 1

//----------Begin Modified by Alfee on 02.16.2009-----------
//Generate and save a new profile view into DB, and update data in profile_report_dw for the new profile view
gnv_appeondb.of_startqueue( )
INSERT profile_view(profile_view_id, profile_view_name) values(:ii_profile_view_id, :ls_profile_view_name);

INSERT profile_report_dw(data_view_id, cur_dw, prf_dw, scr_dw, prf_id, scr_id, table_id, report_id, dw_name, retrieval_aruments, profile_view_id)
 SELECT data_view_id, prf_dw, prf_dw, scr_dw, prf_id, scr_id, table_id, report_id, dw_name, retrieval_aruments, :ii_profile_view_id
   FROM profile_report_dw 
  WHERE profile_view_id = 999 and data_view_id = 1 ;

dw_available.Event pfc_retrieve( )
gnv_appeondb.of_commitqueue( )

//Initialize datawindows and buttons
dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )	
//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 03.04.2011
//$<reason> close the window will get the following error 
//dw_select.SetText( ls_profile_view_name )
dw_select.getchild("profile_view_id",ldc_profile_view_id)
ldc_profile_view_id.settransobject(sqlca)
ldc_profile_view_id.retrieve()
//------------------- APPEON END ---------------------

dw_selected.Reset()
dw_available.SelectRow( 1, True )

of_enable_select_buttons()
/*
li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
dw_views.SetItem( li_nr, "profile_view_name", ls_profile_view_name )

//--------------------------- APPEON BEGIN ---------------------------
gnv_appeondb.of_startqueue( )

SELECT Max( data_view_report_fields.data_view_field_id )  
INTO :il_report_field_id  
FROM data_view_report_fields  ;

SELECT Max( screen_report_objects.data_view_object_id )  
INTO :il_screen_report_objectid  
FROM screen_report_objects  ;

SELECT Max(data_view_report_objects.data_view_object_id)  
INTO :il_report_object_id
FROM data_view_report_objects  ;

dw_available.Event pfc_retrieve( )
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

dw_copy_from_fields.Reset()
dw_copy_from_fields.of_SetTransObject( SQLCA )

dw_copy_to_fields.Reset()
dw_copy_to_fields.of_SetTransObject( SQLCA )

dw_copy_from_objects.Reset()
dw_copy_from_objects.of_SetTransObject( SQLCA )

dw_copy_to_objects.Reset()
dw_copy_to_objects.of_SetTransObject( SQLCA )


dw_selected.Reset()

dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )				
dw_select.SetText( ls_profile_view_name )


dw_available.SelectRow( 1, True )
cb_add.TriggerEvent( Clicked! )
dw_available.SelectRow( 1, True )

of_enable_select_buttons()

ib_create = TRUE //Alfee 02.16.2009

//copy report data
of_copy_report_data(999)

cb_1.TriggerEvent( Clicked! ) //Add By Evan 01/09/2008
*/
//----------End Modified------------------------------------
end event

type cb_down from pfc_cst_u_views_manager`cb_down within pfc_cst_u_profile_views_manager
integer x = 1243
integer y = 740
integer width = 398
integer taborder = 90
end type

type cb_up from pfc_cst_u_views_manager`cb_up within pfc_cst_u_profile_views_manager
integer x = 1243
integer y = 632
integer width = 398
integer taborder = 80
string text = "Move &Up "
end type

type dw_selected_dump from pfc_cst_u_views_manager`dw_selected_dump within pfc_cst_u_profile_views_manager
integer x = 1842
integer y = 1008
integer width = 347
integer height = 620
integer taborder = 150
string dataobject = "d_prf_sub_report_list"
end type

event constructor;This.of_SetUpdateAble( False )
end event

type dw_view_security from pfc_cst_u_views_manager`dw_view_security within pfc_cst_u_profile_views_manager
integer x = 1906
integer y = 884
integer width = 197
integer taborder = 120
end type

type dw_delete_fields from pfc_cst_u_views_manager`dw_delete_fields within pfc_cst_u_profile_views_manager
integer x = 2066
integer y = 1256
integer taborder = 130
end type

type cb_required from pfc_cst_u_views_manager`cb_required within pfc_cst_u_profile_views_manager
integer x = 1225
integer y = 1592
integer width = 398
integer taborder = 270
end type

type dw_copy from pfc_cst_u_views_manager`dw_copy within pfc_cst_u_profile_views_manager
integer x = 1669
integer y = 1436
integer width = 242
integer taborder = 310
end type

type cb_copy from pfc_cst_u_views_manager`cb_copy within pfc_cst_u_profile_views_manager
integer x = 1358
integer y = 36
integer width = 357
integer taborder = 30
string text = "Copy Profile"
end type

event cb_copy::clicked;////Start Code Change ----03.24.2008 #V8 maha - copy button coded

Integer li_profile_view_id
Integer li_nr
String ls_profile_view_name
string ls_name[]
integer li_copied[]
integer c
integer cc
integer li_copy_from

IF of_save() = -1 THEN
	Return -1
END IF

li_copy_from = ii_profile_view_id

Open( w_get_profile_view_name )

ls_profile_view_name = Message.StringParm


If ls_profile_view_name = 'Cancel' or ls_profile_view_name = '' Then
	Return 0
End If

//--Begin Modified by Alfee 02.16.2009---------
SetPointer(HourGlass!) 

//Get a new profile view id
SELECT Max( profile_view.profile_view_id )  
INTO :li_profile_view_id  
FROM profile_view  ;
ii_profile_view_id = li_profile_view_id + 1

//Set to the new profile view 
li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
dw_views.SetItem( li_nr, "profile_view_name", ls_profile_view_name )

//get list of reports to copy
cc = dw_selected.rowcount()
for c = 1 to cc
	li_copied[c] = dw_selected.getitemnumber(c,"profile_report_id")
	ls_name[c] = dw_selected.getitemstring(c,"report_name")
next

//Reset the dw_selected to the new profile view
dw_selected.Reset()
for c = 1 to cc
	li_nr = dw_selected.InsertRow( 0 )
	dw_selected.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
	dw_selected.SetItem( li_nr, "profile_report_id", li_copied[c] )
	dw_selected.SetItem( li_nr, "sort_order", li_nr )
	dw_selected.SetItem( li_nr, "report_name", ls_name[c] )
next

//Copy report data
of_copy_report_data(li_copy_from)

//Set dw_select to new profile view
DataWindowChild dwc_view
dw_select.GetChild('profile_view_id', dwc_view)
dwc_view.SetTransObject(SQLCA)
dwc_view.Retrieve()

dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )				
dw_select.SetText( ls_profile_view_name )

//refresh datawindows & buttons
dw_select.event itemchanged(1, dw_select.object.profile_view_id, string(ii_profile_view_id))

of_enable_select_buttons()
//cb_3.enabled=true

/*
//get list of reports to copy
cc = dw_selected.rowcount()

for c = 1 to cc
	li_copied[c] = dw_selected.getitemnumber(c,"profile_report_id")
	ls_name[c] = dw_selected.getitemstring(c,"report_name")
next

SELECT Max( profile_view.profile_view_id )  
INTO :li_profile_view_id  
FROM profile_view  ;

ii_profile_view_id = li_profile_view_id + 1

li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
dw_views.SetItem( li_nr, "profile_view_name", ls_profile_view_name )

//dw_available.Event pfc_retrieve( )

dw_selected.Reset()

for c = 1 to cc
	li_nr = dw_selected.InsertRow( 0 )
	dw_selected.SetItem( li_nr, "profile_view_id", ii_profile_view_id )
	dw_selected.SetItem( li_nr, "profile_report_id", li_copied[c] )
	dw_selected.SetItem( li_nr, "sort_order", li_nr )
	dw_selected.SetItem( li_nr, "report_name", ls_name[c] )
next

dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id )				
dw_select.SetText( ls_profile_view_name )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 28/08/2008 By: Alan
gnv_appeondb.of_startqueue( )

SELECT Max( data_view_report_fields.data_view_field_id )  
INTO :il_report_field_id  
FROM data_view_report_fields  ;

SELECT Max( screen_report_objects.data_view_object_id )  
INTO :il_screen_report_objectid  
FROM screen_report_objects  ;

SELECT Max(data_view_report_objects.data_view_object_id)  
INTO :il_report_object_id
FROM data_view_report_objects  ;

gnv_appeondb.of_commitqueue( )

dw_copy_from_fields.Reset()
dw_copy_from_fields.of_SetTransObject( SQLCA )

dw_copy_to_fields.Reset()
dw_copy_to_fields.of_SetTransObject( SQLCA )

dw_copy_from_objects.Reset()
dw_copy_from_objects.of_SetTransObject( SQLCA )

dw_copy_to_objects.Reset()
dw_copy_to_objects.of_SetTransObject( SQLCA )

ib_create = FALSE //Alfee 02.16.2009
of_copy_report_data(li_copy_from)

//---------------------------- APPEON END ----------------------------

//dw_views.update()
//dw_selected.update()
of_save()

for c = 1 to cc
	update profile_view_reports set dw_syntax = (select dw_syntax from profile_view_reports where profile_view_id = :li_copy_from  and profile_report_id = :li_copied[c]  ) where profile_view_id = :ii_profile_view_id  and profile_report_id = :li_copied[c] ;
next

of_enable_select_buttons()
cb_3.enabled=true
*/
//----------End Modified --------------------------------------------
end event

type st_1 from pfc_cst_u_views_manager`st_1 within pfc_cst_u_profile_views_manager
boolean visible = false
integer x = 1239
integer y = 1700
end type

type dw_copy_report_fields from pfc_cst_u_views_manager`dw_copy_report_fields within pfc_cst_u_profile_views_manager
integer taborder = 140
string dataobject = "d_copy_report_fields_profile"
end type

type dw_to_report_fields from pfc_cst_u_views_manager`dw_to_report_fields within pfc_cst_u_profile_views_manager
integer taborder = 160
string dataobject = "d_copy_report_fields_profile"
end type

type dw_copy_screen_report from pfc_cst_u_views_manager`dw_copy_screen_report within pfc_cst_u_profile_views_manager
integer taborder = 170
string dataobject = "d_copy_screen_report_profile"
end type

type dw_to_screen_report from pfc_cst_u_views_manager`dw_to_screen_report within pfc_cst_u_profile_views_manager
integer taborder = 180
string dataobject = "d_copy_screen_report_profile"
end type

type dw_copy_profile_report from pfc_cst_u_views_manager`dw_copy_profile_report within pfc_cst_u_profile_views_manager
integer taborder = 190
string dataobject = "d_copy_profile_report_profile"
end type

type dw_to_profile_report from pfc_cst_u_views_manager`dw_to_profile_report within pfc_cst_u_profile_views_manager
integer taborder = 210
string dataobject = "d_copy_profile_report_profile"
end type

type dw_copy_report_object from pfc_cst_u_views_manager`dw_copy_report_object within pfc_cst_u_profile_views_manager
integer taborder = 230
string dataobject = "d_copy_report_object_profile"
end type

type dw_to_report_object from pfc_cst_u_views_manager`dw_to_report_object within pfc_cst_u_profile_views_manager
integer taborder = 250
string dataobject = "d_copy_report_object_profile"
end type

type cb_user from pfc_cst_u_views_manager`cb_user within pfc_cst_u_profile_views_manager
integer x = 1728
integer y = 36
end type

type cb_rename from pfc_cst_u_views_manager`cb_rename within pfc_cst_u_profile_views_manager
integer x = 1358
integer y = 120
integer width = 357
string text = "&Rename Prof"
end type

event cb_rename::clicked; //Start Code Change ----11.16.2015 #V15 maha - coded to allow rename of the profile

Integer li_data_view_id
Integer li_nr
String ls_data_view_name
datawindowchild dwchild


IF ii_profile_view_id = 1 THEN
	MessageBox("Default Profile", "The Standard system Profile cannot be renamed.")
	Return
END IF

IF ii_profile_view_id = 999 THEN
	MessageBox("Default Profile", "The Quick Profile cannot be renamed.")
	Return
END IF

OpenWithParm( w_get_view_name , "P" )


ls_data_view_name = Message.StringParm

if ls_data_view_name = 'Cancel' then return  //Start Code Change ----11.28.2007 #V8 maha previously a view called cancel would be created.


dw_views.SetItem( li_nr, "profile_view_name", ls_data_view_name )

update profile_view set profile_view_name = :ls_data_view_name where profile_view_id = :ii_profile_view_id;


dw_select.GetChild( "profile_view_id", dwchild )
dwchild.settransobject(sqlca)
li_nr = dwchild.retrieve()
dw_select.SetItem( 1, "profile_view_id", ii_profile_view_id)
end event

type st_head1 from pfc_cst_u_views_manager`st_head1 within pfc_cst_u_profile_views_manager
integer width = 1216
string text = "Available Screens"
end type

type st_head2 from pfc_cst_u_views_manager`st_head2 within pfc_cst_u_profile_views_manager
integer x = 1673
integer width = 1207
end type

type cb_rds from pfc_cst_u_views_manager`cb_rds within pfc_cst_u_profile_views_manager
integer x = 1733
integer y = 120
end type

type st_prof from st_1 within pfc_cst_u_profile_views_manager
boolean visible = true
integer x = 46
integer y = 8
string text = "Select Profile"
end type

type st_2 from statictext within pfc_cst_u_profile_views_manager
boolean visible = false
integer x = 2601
integer y = 272
integer width = 219
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16777215
long backcolor = 32891346
string text = "Dynamic"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_xxx from commandbutton within pfc_cst_u_profile_views_manager
integer x = 1728
integer y = 120
integer width = 352
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Properties"
end type

event clicked; //Start Code Change ----11.16.2015 #V15 maha
 
 long r
 long p
 
 
 r = dw_selected.getitemnumber(dw_selected.getrow(), "profile_report_id")
p =  dw_selected.getitemnumber(dw_selected.getrow(), "profile_view_id")

 
 openwithparm(w_profile_data_prop, string(r) + "*" + string(p))
end event

