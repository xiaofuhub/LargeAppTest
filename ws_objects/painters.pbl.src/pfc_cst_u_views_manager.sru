$PBExportHeader$pfc_cst_u_views_manager.sru
forward
global type pfc_cst_u_views_manager from u_base_concentration_box
end type
type dw_select from u_dw within pfc_cst_u_views_manager
end type
type cb_save from u_cb within pfc_cst_u_views_manager
end type
type cb_2 from u_cb within pfc_cst_u_views_manager
end type
type dw_copy_from_fields from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_to_fields from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_from_objects from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_to_objects from u_dw within pfc_cst_u_views_manager
end type
type dw_views from u_dw within pfc_cst_u_views_manager
end type
type cb_delete from u_cb within pfc_cst_u_views_manager
end type
type cb_new from u_cb within pfc_cst_u_views_manager
end type
type cb_down from u_cb within pfc_cst_u_views_manager
end type
type cb_up from u_cb within pfc_cst_u_views_manager
end type
type dw_selected_dump from u_dw within pfc_cst_u_views_manager
end type
type dw_view_security from u_dw within pfc_cst_u_views_manager
end type
type dw_delete_fields from u_dw within pfc_cst_u_views_manager
end type
type cb_required from commandbutton within pfc_cst_u_views_manager
end type
type dw_copy from datawindow within pfc_cst_u_views_manager
end type
type cb_copy from u_cb within pfc_cst_u_views_manager
end type
type st_1 from statictext within pfc_cst_u_views_manager
end type
type dw_copy_report_fields from u_dw within pfc_cst_u_views_manager
end type
type dw_to_report_fields from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_screen_report from u_dw within pfc_cst_u_views_manager
end type
type dw_to_screen_report from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_profile_report from u_dw within pfc_cst_u_views_manager
end type
type dw_to_profile_report from u_dw within pfc_cst_u_views_manager
end type
type dw_copy_report_object from u_dw within pfc_cst_u_views_manager
end type
type dw_to_report_object from u_dw within pfc_cst_u_views_manager
end type
type cb_user from u_cb within pfc_cst_u_views_manager
end type
type cb_rename from u_cb within pfc_cst_u_views_manager
end type
type st_head1 from statictext within pfc_cst_u_views_manager
end type
type st_head2 from statictext within pfc_cst_u_views_manager
end type
type cb_rds from commandbutton within pfc_cst_u_views_manager
end type
type cb_search from commandbutton within pfc_cst_u_views_manager
end type
end forward

global type pfc_cst_u_views_manager from u_base_concentration_box
integer width = 2921
integer height = 2032
event pfc_cst_view_manager ( )
dw_select dw_select
cb_save cb_save
cb_2 cb_2
dw_copy_from_fields dw_copy_from_fields
dw_copy_to_fields dw_copy_to_fields
dw_copy_from_objects dw_copy_from_objects
dw_copy_to_objects dw_copy_to_objects
dw_views dw_views
cb_delete cb_delete
cb_new cb_new
cb_down cb_down
cb_up cb_up
dw_selected_dump dw_selected_dump
dw_view_security dw_view_security
dw_delete_fields dw_delete_fields
cb_required cb_required
dw_copy dw_copy
cb_copy cb_copy
st_1 st_1
dw_copy_report_fields dw_copy_report_fields
dw_to_report_fields dw_to_report_fields
dw_copy_screen_report dw_copy_screen_report
dw_to_screen_report dw_to_screen_report
dw_copy_profile_report dw_copy_profile_report
dw_to_profile_report dw_to_profile_report
dw_copy_report_object dw_copy_report_object
dw_to_report_object dw_to_report_object
cb_user cb_user
cb_rename cb_rename
st_head1 st_head1
st_head2 st_head2
cb_rds cb_rds
cb_search cb_search
end type
global pfc_cst_u_views_manager pfc_cst_u_views_manager

type variables
w_data_views_manager iw_win

Integer ii_data_view_id = 1
Long il_object_id
Long il_field_id
//
Long il_report_field_id
Long il_screen_report_objectid
Long il_report_object_id


String is_sort_field 

Boolean ib_new = False

Boolean ib_Alias = false // Andy 03172008


end variables

forward prototypes
public function integer of_set_parent_window (w_data_views_manager aw_win)
public function integer of_save ()
public function integer of_get_max_ids ()
public function integer of_close ()
public function integer of_enable_select_buttons ()
public function integer of_rid_duplicates (string as_view_id_field, string as_screen_id_field, string as_filter_field)
public function integer of_retrieve_data_view (string as_data)
public subroutine of_copy_report_data (integer ai_data_view_id)
public function integer of_add_screen (integer ai_data_view_id, integer ai_screen_id, integer ai_cr)
public function integer of_setup ()
public function integer of_default_set (integer ai_view)
end prototypes

public function integer of_set_parent_window (w_data_views_manager aw_win);iw_win = aw_win

Return 0 
end function

public function integer of_save ();Integer li_row_cnt
Integer i
Integer u
Integer li_rc
Integer li_rec_id
Integer li_user_cnt
Integer li_access_rights
n_ds lds_users
String ls_user_id
String ls_version

SetPointer(HourGlass!)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Create a datastore to cache data that will be used by the script in PT-05.
integer li_row
datastore lds_user_security_view_forpt
lds_user_security_view_forpt = CREATE datastore
lds_user_security_view_forpt.DataObject = "d_user_security_view_forpt"
lds_user_security_view_forpt.SetTransObject( SQLCA )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-08-16 By: Rodger Wu
//$<reason> The following script is moved from line 105.
IF dw_selected.Modifiedcount() > 0 OR dw_selected.DeletedCount() > 0 THEN
	li_row_cnt = dw_selected.RowCount()
	
	FOR i = 1 TO li_row_cnt
		dw_selected.SetItem( i, "screen_order", i )
	END FOR
END IF
//---------------------------- APPEON END ----------------------------

IF dw_views.Update( True, False ) = 1 THEN
	IF dw_selected.Update( True, False ) = 1 THEN
		IF dw_copy_to_fields.Update( True, False ) = 1 THEN
			IF dw_copy_to_objects.Update( True, False ) = 1 THEN
				//----Begin commented by Alfee 02.16.2009 ---------------
				/* IF dw_to_report_fields.Update( True, False ) = 1 THEN
					IF dw_to_screen_report.Update( True, False ) = 1 THEN
						IF dw_to_profile_report.Update( True, False ) = 1 THEN
							IF dw_to_report_object.Update( True, False ) = 1  THEN */
				//----End Commented ----------------------------------------				
								dw_views.ResetUpdate()
								dw_selected.ResetUpdate()
								dw_copy_to_fields.ResetUpdate()
								dw_copy_to_objects.ResetUpdate()
								//----Begin commented by Alfee 02.16.2009 ---------------
								/* dw_to_report_fields.ResetUpdate()
								dw_to_screen_report.ResetUpdate()
								dw_to_profile_report.ResetUpdate()
								dw_to_report_object.ResetUpdate() */
								//----End Commented ----------------------------------------
								COMMIT USING SQLCA;
								DataWindowChild dwchild
								dw_select.Reset()
								dw_select.of_SetTransObject( SQLCA )
								dw_select.InsertRow( 0 )
								dw_select.GetChild( "data_view_id", dwchild )
								dwchild.SetTransObject( SQLCA )
								dwchild.Retrieve()		
								dw_select.SetItem( 1, "data_view_id", ii_data_view_id )				
								dw_selected.ResetUpdate ( )
								dw_views.ResetUpdate ( )				
								dw_copy_to_fields.ResetUpdate ( )
								dw_copy_to_objects.ResetUpdate ( )
				//----Begin commented by Alfee 02.16.2009 ---------------			
				/*			ELSE
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
				END IF  */
				//----End Commented ----------------------------------------
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

//--Begin Added by Alfee 04.30.2009-------
dw_copy_to_fields.Reset()
dw_copy_to_objects.Reset()
//--End Added -----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.19.2008 by Andy
//Initial view and field alias for IntelliReport.
if ib_Alias then
	n_cst_update_view_fields_alias lnvo_update
	
	lnvo_update = create n_cst_update_view_fields_alias
	lnvo_update.of_update_view_fields_alias( 2, ii_data_view_id)
	destroy lnvo_update
end if
//---------------------------- APPEON END ----------------------------

int li_updateret
li_updateret = 1

//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-02
//$<modify> 03.09.2006 By: LiuHongXin
//$<reason> The Web application does not need to check whether there is an INI file on local machine.
//$<modification> Make an condition that when the application runs on the Web, the application does not check
//$<modification> the local INI file.

If appeongetclienttype() = 'PB' Then
	IF NOT FileExists( gs_IniFilePathName ) THEN
		MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		Return -1
	END IF
END IF
//---------------------------- APPEON END ----------------------------
IF ls_version = "None" THEN
	MessageBox("Error", "Version number not setup.")
	RETURN -1
END IF

IF MidA( ls_version, 6, 1) = "7" THEN
	li_access_rights = 0
ELSE
	li_access_rights = 1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<comment> 2006-08-16 By: Rodger Wu
//$<reason> Move the following script ahead of datawindow's UPDATE.
/*
li_row_cnt = dw_selected.RowCount()

FOR i = 1 TO li_row_cnt
	dw_selected.SetItem( i, "screen_order", i )
END FOR
*/
//---------------------------- APPEON END ----------------------------

lds_users = CREATE n_ds
lds_users.DataObject = "d_list_of_users"
lds_users.SetTransObject( SQLCA )
li_user_cnt = lds_users.Retrieve( )

IF ib_new THEN
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-03
	//$<modify> 02.17.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Define a variable to 1)get the first ID; 2)Update the final ID
	//$<modification> value into database.
	/*
	li_rec_id = gnv_app.of_get_id( "RIGHTS" )			
	*/
	li_rec_id = gnv_app.of_get_id( "user_view_id" ,li_user_cnt)	- 1		
	//---------------------------- APPEON END ----------------------------

	FOR u = 1 TO li_user_cnt	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-04
		//$<modify> 02.17.2006 By: owen chen
		//$<reason> Performance tuning
		//$<modification> Comment out the following script to reduce client-server interaction.
		//$<modification> refer to PT-03 and of_get_id for more information.
		/*
		li_rec_id = gnv_app.of_get_id( "RIGHTS" )			
		*/
		li_rec_id ++
		//---------------------------- APPEON END ----------------------------
		ls_user_id = lds_users.GetItemString( u, "user_id" )			
		
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-05
	//$<modify> 02.17.2006 By: owen chen
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.
	
	/*
		INSERT INTO security_user_views  
			( user_view_id,   
			  user_id,   
			  view_id,   
			  access_rights )  
		VALUES ( :li_rec_id,   
			  :ls_user_id,   
			  :ii_data_view_id,   
			  :li_access_rights )  ;		
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox( "Insert Error", SQLCA.SQLERRTEXT )
			Return -1
		END IF
	END FOR
	*/
	li_row = lds_user_security_view_forpt.insertrow(0)
	lds_user_security_view_forpt.object.user_view_id[li_row] = li_rec_id
	lds_user_security_view_forpt.object.user_id[li_row] = ls_user_id
	lds_user_security_view_forpt.object.view_id[li_row] = ii_data_view_id
	lds_user_security_view_forpt.object.access_rights[li_row] = li_access_rights

	END FOR
	if lds_user_security_view_forpt.update( ) < 0 then
		MessageBox( "Insert Error", SQLCA.SQLERRTEXT )
		Return -1
	end if
	//---------------------------- APPEON END ----------------------------	
	MessageBox("User Painter", "To assign this View to a user you need to update the User Painter.")
END IF

DESTROY lds_users;
Destroy lds_user_security_view_forpt;

ib_new = False
//$<add> 03.17.2008 by Andy
ib_Alias = False

Return 0
end function

public function integer of_get_max_ids ();//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-06
//$<comment> 01.17.2006 By: owen chen
//$<reason> performance tuning
//$<reason> The following script moved to of_retrieve_data_view function.
/*
SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :il_object_id
FROM data_view_screen_objects  ;

SELECT Max( data_view_fields.data_view_field_id )  
INTO :il_field_id  
FROM data_view_fields  ;
*/
//---------------------------- APPEON END ----------------------------

Return 0
end function

public function integer of_close ();Close( Parent )

Return 0
end function

public function integer of_enable_select_buttons ();IF dw_available.RowCount() = 0 THEN
	cb_add.Enabled = False
ELSE
	cb_add.Enabled = True
END IF

IF dw_selected.RowCount() = 0 THEN
	cb_clear.Enabled = False
ELSE
	cb_clear.Enabled = True
END IF


Return 0
end function

public function integer of_rid_duplicates (string as_view_id_field, string as_screen_id_field, string as_filter_field);Integer li_available_cnt
Integer i
Integer li_screen_id
Integer li_found
Integer li_rc
String li_filter_fld_data

li_available_cnt = dw_available.RowCount()

FOR i = 1 TO li_available_cnt
	li_screen_id = dw_available.GetItemNumber( i, as_screen_id_field )
	li_filter_fld_data = dw_available.GetItemString( i, as_filter_field )
	li_found = dw_selected.Find( as_screen_id_field + " = " + String( li_screen_id ), 1, 1000 )
	IF li_found > 0 THEN
		dw_available.SetItem( i, as_filter_field,  li_filter_fld_data + "9999" )
	END IF
END FOR


dw_available.SetFilter( "Right( " + as_filter_field + ", 4) = '9999'" )
dw_available.Filter()


li_rc = dw_available.RowCount()
dw_selected_dump.DataObject = dw_available.DataObject

FOR i = 1 TO li_rc
	li_filter_fld_data = dw_available.GetItemString( 1, as_filter_field )
	dw_available.RowsMove( 1, 1, Primary!, dw_selected_dump, 1000, Primary! )
	dw_selected_dump.Setitem(i , as_filter_field, LeftA( li_filter_fld_data, LenA( 	li_filter_fld_data  ) - 4))  
END FOR

dw_selected_dump.AcceptText()

//Start Code By Jervis 04.28.2008
if upper(as_screen_id_field) = "SCREEN_ID" then
	dw_available.SetFilter( as_screen_id_field + " > 0" )
else
	dw_available.SetFilter("")
end if
//End Code By Jervis 04.28.2008
dw_available.Filter( )

Return 0
end function

public function integer of_retrieve_data_view (string as_data);ii_data_view_id = Integer( as_data )

SetPointer(HourGlass!)

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-07
//$<modify> 01.17.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
IF dw_selected.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
	//Error handling and messaging
	RETURN -1
ELSE
	SQLCA.of_commit()
END IF

IF dw_available.Event pfc_Retrieve() = -1 THEN
	SQLCA.of_rollback()
	//Error handling and messaging
	RETURN -1
ELSE
	SQLCA.of_commit()
END IF

SetRedraw( False )

dw_copy_to_fields.Retrieve( ii_data_view_id )
dw_copy_to_objects.Retrieve( ii_data_view_id  )
dw_views.Retrieve( ii_data_view_id )
*/
gnv_appeondb.of_startqueue( )

dw_selected.Retrieve(ii_data_view_id)
dw_available.Retrieve(1)
//-----Begin Commented by Nova 04.13.2009---------------
//dw_copy_to_fields.Retrieve( ii_data_view_id )
//dw_copy_to_objects.Retrieve( ii_data_view_id  )
//-----End Commented -----------------------------------
dw_views.Retrieve( ii_data_view_id )

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :il_object_id
FROM data_view_screen_objects  ;

SELECT Max( data_view_fields.data_view_field_id )  
INTO :il_field_id  
FROM data_view_fields  ;

gnv_appeondb.of_commitqueue( )

SetRedraw( False )
//---------------------------- APPEON END ----------------------------

of_rid_duplicates( "data_view_id", "screen_id", "screen_name" )

dw_available.SelectRow( 0, False )
dw_selected.SelectRow( 1, True )

of_enable_select_buttons()

SetRedraw( True )

RETURN 0
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
//
ll_count1 = dw_copy_report_fields.retrieve(ai_data_view_id)
ll_count2 = dw_copy_screen_report.retrieve(ai_data_view_id)
ll_count3 = dw_copy_profile_report.retrieve(ai_data_view_id)
ll_count4 = dw_copy_report_object.retrieve(ai_data_view_id)
if dw_copy_report_fields.rowscopy(1,ll_count1,primary!,dw_to_report_fields,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count1
	dw_to_report_fields.SetItem( i, "data_view_id", ii_data_view_id )
	il_report_field_id++
	dw_to_report_fields.SetItem( i, "data_view_field_id", il_report_field_id )
next

if dw_copy_screen_report.rowscopy(1,ll_count2,primary!,dw_to_screen_report,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count2
	dw_to_screen_report.SetItem( i, "data_view_id", ii_data_view_id )
	il_screen_report_objectid++
	dw_to_screen_report.SetItem( i, "data_view_object_id", il_screen_report_objectid )
next

if dw_copy_profile_report.rowscopy(1,ll_count3,primary!,dw_to_profile_report,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count3
	dw_to_profile_report.SetItem( i, "data_view_id", ii_data_view_id )
next

if dw_copy_report_object.rowscopy(1,ll_count4,primary!,dw_to_report_object,1,primary!) = -1 then
	messagebox("Copy error","Copy of report fields failed.")
end if
for i=1 to ll_count4
	dw_to_report_object.SetItem( i, "data_view_id", ii_data_view_id )
	il_report_object_id++
	dw_to_report_object.SetItem( i, "data_view_object_id", il_report_object_id )
next



end subroutine

public function integer of_add_screen (integer ai_data_view_id, integer ai_screen_id, integer ai_cr);Integer li_selected_last_row
Integer li_last_screen_order
Integer li_field_cnt
Integer f
Integer o
Integer li_object_cnt
integer te

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03/21/2008 By: Ken.Guo
//$<reason> To workaround APB Bug, add trap.
//dw_available.RowsMove( ai_cr, ai_cr, Primary!, dw_selected, 1000, Primary!)
If ai_cr > 0 Then
	dw_available.RowsMove( ai_cr, ai_cr, Primary!, dw_selected, 1000, Primary!) 
End If
//---------------------------- APPEON END ----------------------------


li_selected_last_row = dw_selected.RowCount()
IF li_selected_last_row = 1 THEN
	li_last_screen_order = 0
ELSE
	li_last_screen_order = dw_selected.GetItemNumber( li_selected_last_row -1, "screen_order" ) 
END IF
dw_selected.SetItem( li_selected_last_row, "data_view_id", ii_data_view_id )
dw_selected.SetItem( li_selected_last_row, "screen_order", li_last_screen_order + 1 )

dw_copy_from_fields.Reset()
dw_copy_from_fields.of_SetTransObject( SQLCA )
//--------Begin Modified by Nova 04.13.2009-----------
//add parameter ai_data_view_id
//li_field_cnt = dw_copy_from_fields.Retrieve(ai_screen_id )
li_field_cnt = dw_copy_from_fields.Retrieve( ai_data_view_id,ai_screen_id ) 
//--------End Modified -------------------------------
te = dw_copy_from_fields.RowsCopy(1, dw_copy_from_fields.RowCount(), Primary!, dw_copy_to_fields, 1, Primary!)
//if te < 1 then messagebox("Copy error","Copy of fields failed.")	
if li_field_cnt > 0 and  te < 1 then messagebox("Copy error","Copy of fields failed.")	//06/07/2007 By Jervis
FOR f = 1 TO li_field_cnt
	dw_copy_to_fields.SetItem( f, "data_view_id", ii_data_view_id )
	il_field_id ++
	dw_copy_to_fields.SetItem( f, "data_view_field_id", il_field_id )
END FOR
//--------Begin Modified by Nova 04.13.2009-----------
//add parameter ai_data_view_id
//li_object_cnt = dw_copy_from_objects.Retrieve( ai_screen_id )
li_object_cnt = dw_copy_from_objects.Retrieve( ai_data_view_id,ai_screen_id )
//--------End Modified -------------------------------
dw_copy_from_objects.RowsCopy(1, dw_copy_from_objects.RowCount(), Primary!, dw_copy_to_objects, 1, Primary!)		
FOR o = 1 TO li_object_cnt
	dw_copy_to_objects.SetItem( o, "data_view_id", ii_data_view_id )		
	il_object_id ++
	dw_copy_to_objects.SetItem( o, "data_view_object_id", il_object_id )		
END FOR

dw_selected.SelectRow( 0, False )
dw_selected.SelectRow( li_selected_last_row, True )
dw_selected.SetRow( li_selected_last_row )
dw_selected.ScrollToRow( li_selected_last_row )



of_enable_select_buttons()

dw_available.Sort()

Return 0
end function

public function integer of_setup ();if gb_sk_ver then
	cb_new.visible= false
	cb_copy.visible= false
	cb_delete.visible= false
end if

//Start Code Change ----10.10.2012 #V12 maha
if gi_user_readonly = 1 then
	cb_new.visible= false
	cb_copy.visible= false
	cb_delete.visible= false
	cb_rename.visible= false
	cb_save.visible= false
	cb_add.visible= false
	cb_clear.visible= false
	cb_up.visible= false
	cb_down.visible= false
	cb_required.visible= false
	cb_user.visible= false
	dw_available.enabled = false
	dw_selected.enabled = false
end if
//Start Code Change ----10.10.2012

//Start Code Change ----05.11.2016 #V15.2 maha
if w_mdi.of_security_access(7820) = 0 then
	cb_search.visible = false
end if

if w_mdi.of_security_access(7819) = 0 then
	cb_rds.visible = false
end if
//End Code Change ----05.11.2016

return 1
end function

public function integer of_default_set (integer ai_view);//Start Code Change ----07.22.2010 #V10 maha - created to protect default view
if ai_view =  1 then
	cb_delete.enabled  = false
	cb_add.enabled  = false
	cb_clear.enabled  = false
else
	cb_delete.enabled  = true
	cb_add.enabled  = true
	cb_clear.enabled  = true
end if

return 1
end function

on pfc_cst_u_views_manager.create
int iCurrent
call super::create
this.dw_select=create dw_select
this.cb_save=create cb_save
this.cb_2=create cb_2
this.dw_copy_from_fields=create dw_copy_from_fields
this.dw_copy_to_fields=create dw_copy_to_fields
this.dw_copy_from_objects=create dw_copy_from_objects
this.dw_copy_to_objects=create dw_copy_to_objects
this.dw_views=create dw_views
this.cb_delete=create cb_delete
this.cb_new=create cb_new
this.cb_down=create cb_down
this.cb_up=create cb_up
this.dw_selected_dump=create dw_selected_dump
this.dw_view_security=create dw_view_security
this.dw_delete_fields=create dw_delete_fields
this.cb_required=create cb_required
this.dw_copy=create dw_copy
this.cb_copy=create cb_copy
this.st_1=create st_1
this.dw_copy_report_fields=create dw_copy_report_fields
this.dw_to_report_fields=create dw_to_report_fields
this.dw_copy_screen_report=create dw_copy_screen_report
this.dw_to_screen_report=create dw_to_screen_report
this.dw_copy_profile_report=create dw_copy_profile_report
this.dw_to_profile_report=create dw_to_profile_report
this.dw_copy_report_object=create dw_copy_report_object
this.dw_to_report_object=create dw_to_report_object
this.cb_user=create cb_user
this.cb_rename=create cb_rename
this.st_head1=create st_head1
this.st_head2=create st_head2
this.cb_rds=create cb_rds
this.cb_search=create cb_search
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_select
this.Control[iCurrent+2]=this.cb_save
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_copy_from_fields
this.Control[iCurrent+5]=this.dw_copy_to_fields
this.Control[iCurrent+6]=this.dw_copy_from_objects
this.Control[iCurrent+7]=this.dw_copy_to_objects
this.Control[iCurrent+8]=this.dw_views
this.Control[iCurrent+9]=this.cb_delete
this.Control[iCurrent+10]=this.cb_new
this.Control[iCurrent+11]=this.cb_down
this.Control[iCurrent+12]=this.cb_up
this.Control[iCurrent+13]=this.dw_selected_dump
this.Control[iCurrent+14]=this.dw_view_security
this.Control[iCurrent+15]=this.dw_delete_fields
this.Control[iCurrent+16]=this.cb_required
this.Control[iCurrent+17]=this.dw_copy
this.Control[iCurrent+18]=this.cb_copy
this.Control[iCurrent+19]=this.st_1
this.Control[iCurrent+20]=this.dw_copy_report_fields
this.Control[iCurrent+21]=this.dw_to_report_fields
this.Control[iCurrent+22]=this.dw_copy_screen_report
this.Control[iCurrent+23]=this.dw_to_screen_report
this.Control[iCurrent+24]=this.dw_copy_profile_report
this.Control[iCurrent+25]=this.dw_to_profile_report
this.Control[iCurrent+26]=this.dw_copy_report_object
this.Control[iCurrent+27]=this.dw_to_report_object
this.Control[iCurrent+28]=this.cb_user
this.Control[iCurrent+29]=this.cb_rename
this.Control[iCurrent+30]=this.st_head1
this.Control[iCurrent+31]=this.st_head2
this.Control[iCurrent+32]=this.cb_rds
this.Control[iCurrent+33]=this.cb_search
end on

on pfc_cst_u_views_manager.destroy
call super::destroy
destroy(this.dw_select)
destroy(this.cb_save)
destroy(this.cb_2)
destroy(this.dw_copy_from_fields)
destroy(this.dw_copy_to_fields)
destroy(this.dw_copy_from_objects)
destroy(this.dw_copy_to_objects)
destroy(this.dw_views)
destroy(this.cb_delete)
destroy(this.cb_new)
destroy(this.cb_down)
destroy(this.cb_up)
destroy(this.dw_selected_dump)
destroy(this.dw_view_security)
destroy(this.dw_delete_fields)
destroy(this.cb_required)
destroy(this.dw_copy)
destroy(this.cb_copy)
destroy(this.st_1)
destroy(this.dw_copy_report_fields)
destroy(this.dw_to_report_fields)
destroy(this.dw_copy_screen_report)
destroy(this.dw_to_screen_report)
destroy(this.dw_copy_profile_report)
destroy(this.dw_to_profile_report)
destroy(this.dw_copy_report_object)
destroy(this.dw_to_report_object)
destroy(this.cb_user)
destroy(this.cb_rename)
destroy(this.st_head1)
destroy(this.st_head2)
destroy(this.cb_rds)
destroy(this.cb_search)
end on

event constructor;dw_available.of_SetBase(TRUE)
dw_selected.of_SetBase(TRUE)

dw_selected.of_SetTransObject(SQLCA)
dw_available.of_SetTransObject(SQLCA)

// assume that the available datawindow is not updateable.  If needed, this can be
// overrided in the constructor script of the ancestor
dw_available.of_setupdateable(FALSE)

is_sort_field = "screen_order"

Return 0
end event

type cb_clear_all from u_base_concentration_box`cb_clear_all within pfc_cst_u_views_manager
boolean visible = false
integer x = 1303
integer y = 1668
integer taborder = 200
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

type cb_clear from u_base_concentration_box`cb_clear within pfc_cst_u_views_manager
integer x = 1257
integer y = 476
integer height = 84
integer taborder = 190
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "<- &Remove"
end type

event cb_clear::clicked;Integer li_cr
Integer li_screen_id
Integer li_rc
Integer i
Integer li_field_cnt
Integer li_object_cnt
Integer f
Integer o
Long ll_field_id
Long ll_object_id
Integer li_found
String ls_fld_lbl

li_cr = dw_selected.GetRow( )

IF ii_data_view_id = 1 THEN
	MessageBox("Invalid Option", "Screens cannot be removed from the default system view!")
	Return
END IF

IF dw_selected.GetItemString( li_cr, "screen_name" ) = "Basic Information" THEN
	MessageBox("Invalid Option", "You can't delete Basic Information from the screen list!")
	Return	
END IF

IF ii_data_view_id = 0 THEN
	MessageBox("Select View", "You must first select a view before adding sections.")
	Return
END IF

//get screen to remove
li_screen_id = dw_selected.GetItemNumber( li_cr, "screen_id" )
dw_selected.RowsCopy( li_cr, li_cr, Primary!, dw_available, 1000, Primary!)
dw_selected.DeleteRow( li_cr )

//----------Begin Added by Alfee 04.30.2009 -------------------------
//<$Reason>Synchronize data while removing a screen 
FOR i = 1 to dw_copy_to_fields.RowCount()
	IF dw_copy_to_fields.GetItemNumber(i,"screen_id") = li_screen_id THEN
		dw_copy_to_fields.DeleteRow(i)
		i --
	END IF
NEXT

FOR i = 1 to dw_copy_to_objects.RowCount()
	IF dw_copy_to_objects.GetItemNumber(i,"screen_id") = li_screen_id THEN
		dw_copy_to_objects.DeleteRow(i)
		i --
	END IF
NEXT
//----------End Added ------------------------------------------------

//Start Code Change ---- 11.08.2005 # maha

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-08
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
delete from data_view_fields where screen_id = :li_screen_id and data_view_id = :ii_data_view_id; //maha 021903 replaced above to get all the objects
	//removed maha 110805
	//li_field_cnt = dw_copy_from_fields.Retrieve( li_screen_id )
	//FOR f = 1 TO li_field_cnt
	//	ll_field_id = dw_copy_from_fields.GetItemNumber( f, "field_id" )
	//	ls_fld_lbl = dw_copy_from_fields.GetItemString( f, "field_label" )
	//	li_found = dw_copy_to_fields.Find( "field_id = " + String( ll_field_id ), 1, 10000 )
	//	IF li_found <= 0 THEN
	//		MessageBox("Error","Could not locate field to remove screen." )
	//		RETURN -1
	//	END IF	
	//	dw_copy_to_fields.DeleteRow( li_found )
	//END FOR
//End Code Change---11.08.2005 

//li_object_cnt = dw_copy_from_objects.Retrieve( li_screen_id )
//FOR o = 1 TO li_object_cnt
//	ll_object_id = dw_copy_from_objects.GetItemNumber( o, "data_view_object_id" )
//	li_found = dw_copy_to_fields.Find( "data_view_object_id = " + String( ll_object_id ), 1, 10000 )
//	IF li_found <= 0 THEN
//		MessageBox("Error","Could not locate Object to remove screen." )
//		RETURN -1
//	END IF
//	dw_copy_to_objects.DeleteRow( li_found )
//END FOR
delete from data_view_screen_objects where screen_id = :li_screen_id and data_view_id = :ii_data_view_id; //maha 021903 replaced above to get all the objects

*/
gnv_appeondb.of_startqueue( )

	delete from data_view_fields where screen_id = :li_screen_id and data_view_id = :ii_data_view_id; //maha 021903 replaced above to get all the objects
	//removed maha 110805
	//li_field_cnt = dw_copy_from_fields.Retrieve( li_screen_id )
	//FOR f = 1 TO li_field_cnt
	//	ll_field_id = dw_copy_from_fields.GetItemNumber( f, "field_id" )
	//	ls_fld_lbl = dw_copy_from_fields.GetItemString( f, "field_label" )
	//	li_found = dw_copy_to_fields.Find( "field_id = " + String( ll_field_id ), 1, 10000 )
	//	IF li_found <= 0 THEN
	//		MessageBox("Error","Could not locate field to remove screen." )
	//		RETURN -1
	//	END IF	
	//	dw_copy_to_fields.DeleteRow( li_found )
	//END FOR
//End Code Change---11.08.2005 

//li_object_cnt = dw_copy_from_objects.Retrieve( li_screen_id )
//FOR o = 1 TO li_object_cnt
//	ll_object_id = dw_copy_from_objects.GetItemNumber( o, "data_view_object_id" )
//	li_found = dw_copy_to_fields.Find( "data_view_object_id = " + String( ll_object_id ), 1, 10000 )
//	IF li_found <= 0 THEN
//		MessageBox("Error","Could not locate Object to remove screen." )
//		RETURN -1
//	END IF
//	dw_copy_to_objects.DeleteRow( li_found )
//END FOR
delete from data_view_screen_objects where screen_id = :li_screen_id and data_view_id = :ii_data_view_id; //maha 021903 replaced above to get all the objects

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------


li_rc = dw_selected.RowCount()
FOR i = 1 TO li_rc
	dw_selected.SetItem( i, "screen_order", i )
END FOR

dw_selected.Sort()

IF li_cr > dw_selected.RowCount() THEN
	li_cr = dw_selected.RowCount()
END IF

IF dw_selected.RowCount() > 0 THEN
	dw_selected.SelectRow( 0, False )
	dw_selected.SelectRow( li_cr, True )
	dw_selected.SetRow( li_cr )
	dw_selected.ScrollToRow( li_cr )
END IF

of_enable_select_buttons()

dw_available.Sort()
end event

type cb_add_all from u_base_concentration_box`cb_add_all within pfc_cst_u_views_manager
boolean visible = false
integer x = 1294
integer y = 1476
integer taborder = 180
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Add All->>"
end type

type cb_add from u_base_concentration_box`cb_add within pfc_cst_u_views_manager
integer x = 1257
integer y = 360
integer height = 84
integer taborder = 170
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
end type

event cb_add::clicked;Integer li_cr
Integer li_screen_id
Integer li_rc
Integer i
Integer li_field_cnt
Integer li_object_cnt
Integer f
Integer o
Integer li_table_id_2
Integer li_last_screen_order
Integer li_selected_last_row

IF dw_available.RowCount() <= 0 THEN RETURN //Add by Evan 01/10/2008
IF ii_data_view_id = 0 THEN
	MessageBox("Select View", "You must first select a view before adding sections.")
	RETURN
END IF

//get selected screen id and move row from available to selected
li_cr = dw_available.GetRow()
li_screen_id = dw_available.GetItemNumber( li_cr, "screen_id" )
li_table_id_2 = dw_available.GetItemNumber( li_cr, "table_id_2" )

//Start Code Change ----05.02.2013 #V12 maha - trap fo Affil stat screen
if li_screen_id = 43 then
	messagebox("Affilation Status screen",  "The Affilation status screen should not be added to views as it is not designed to be accessed from the Demographics screen.")
	return
end if
//End Code Change ----05.02.2013

//-------------Begin Modified by Nova 04.13.2009 -------
//of_add_screen(li_screen_id, li_cr )
//-------Begin Modified by Alfee 04.30.2009-------------
/* IF ib_new  THEN
	of_add_screen(1, li_screen_id, li_cr )
ELSE
	of_add_screen(ii_data_view_id, li_screen_id, li_cr )
END IF */
of_add_screen(1, li_screen_id, li_cr )
//-------End Modified -----------------------------------
//-------------End Modified -----------------------------
IF li_table_id_2 > 0 THEN
	li_cr = dw_available.Find( "screen_id = " + String( li_table_id_2 ), 1, 2000 )
	IF li_cr < 1 THEN
		MessageBox( "Error", "Error selecting screen." )
		RETURN
	END IF
	li_screen_id = dw_available.GetItemNumber( li_cr, "screen_id" )
	//-------------Begin Modified by Nova 04.13.2009 -------
	//of_add_screen(li_screen_id, li_cr )
	//of_add_screen(ii_data_view_id, li_screen_id, li_cr )
	of_add_screen(1, li_screen_id, li_cr ) //alfee 04.30.2009
	//-------------End Modified -----------------------------
	dw_selected.DeleteRow( dw_selected.RowCount() )
END IF

//$<add> 03.17.2008 by Andy
ib_Alias = True

//dw_available.RowsMove( li_cr, li_cr, Primary!, dw_selected, 1000, Primary!)
//li_selected_last_row = dw_selected.RowCount()
//IF li_selected_last_row = 1 THEN
//	li_last_screen_order = 0
//ELSE
//	li_last_screen_order = dw_selected.GetItemNumber( li_selected_last_row -1, "screen_order" ) 
//END IF
//dw_selected.SetItem( li_selected_last_row, "data_view_id", ii_data_view_id )
//dw_selected.SetItem( li_selected_last_row, "screen_order", li_last_screen_order + 1 )
//
//dw_copy_from_fields.Reset()
//dw_copy_from_fields.of_SetTransObject( SQLCA )
//li_field_cnt = dw_copy_from_fields.Retrieve( li_screen_id )
//dw_copy_from_fields.RowsCopy(1, dw_copy_from_fields.RowCount(), Primary!, dw_copy_to_fields, 1, Primary!)
//
//FOR f = 1 TO li_field_cnt
//	dw_copy_to_fields.SetItem( f, "data_view_id", ii_data_view_id )
//	il_field_id ++
//	dw_copy_to_fields.SetItem( f, "data_view_field_id", il_field_id )
//END FOR
//
//li_object_cnt = dw_copy_from_objects.Retrieve( li_screen_id )
//dw_copy_from_objects.RowsCopy(1, dw_copy_from_objects.RowCount(), Primary!, dw_copy_to_objects, 1, Primary!)		
//FOR o = 1 TO li_object_cnt
//	dw_copy_to_objects.SetItem( o, "data_view_id", ii_data_view_id )		
//	il_object_id ++
//	dw_copy_to_objects.SetItem( o, "data_view_object_id", il_object_id )		
//END FOR
//
//dw_selected.SelectRow( 0, False )
//dw_selected.SelectRow( li_selected_last_row, True )
//dw_selected.SetRow( li_selected_last_row )
//dw_selected.ScrollToRow( li_selected_last_row )
//
//of_enable_select_buttons()
//
//dw_available.Sort()


end event

type dw_selected from u_base_concentration_box`dw_selected within pfc_cst_u_views_manager
integer x = 1669
integer y = 332
integer width = 1248
integer height = 1688
integer taborder = 160
string title = "Selected Screens "
string dataobject = "d_select_view_list_added"
end type

event dw_selected::pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( ii_data_view_id )
end event

event dw_selected::constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

event dw_selected::clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.SelectRow( 0, False )
	This.ScrollToRow( li_row )
	dw_available.SelectRow( 0, False )
END IF
end event

event dw_selected::rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
This.SelectRow( currentrow, True )
end event

event dw_selected::getfocus;call super::getfocus;IF This.RowCount() > 0 THEN
	dw_available.SelectRow( 0, False )
	This.SelectRow( This.GetRow(), True )
END IF
end event

event dw_selected::pfc_update;Return 0
end event

type dw_available from u_base_concentration_box`dw_available within pfc_cst_u_views_manager
integer x = 0
integer y = 332
integer width = 1189
integer height = 1688
string title = "Available Screens"
string dataobject = "d_select_view_list"
end type

event dw_available::pfc_retrieve;call super::pfc_retrieve;Return This.Retrieve( 1 )
end event

event dw_available::constructor;call super::constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateable( False )
end event

event dw_available::retrieveend;call super::retrieveend;of_get_max_ids()

end event

event dw_available::clicked;call super::clicked;Integer li_row

dw_selected.SelectRow( 0, False )

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.ScrollToRow( li_row )
END IF
end event

event dw_available::rowfocuschanged;call super::rowfocuschanged;
This.SelectRow( 0, False )
This.SelectRow( currentrow, True )
end event

event dw_available::getfocus;call super::getfocus;IF This.RowCount() > 0 THEN
	dw_selected.SelectRow( 0, False )
	This.SelectRow( This.GetRow(), True )
END IF
end event

type dw_select from u_dw within pfc_cst_u_views_manager
integer x = 73
integer y = 72
integer width = 937
integer height = 84
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
This.InsertRow( 0 )
//Start Code Change ----07.22.2010 #V10 maha - se tto the number 2 view for SK
if gb_sk_ver then
	This.SetItem( 1, "data_view_id", 2 )
else
	This.SetItem( 1, "data_view_id", 1 )
end if
//Start Code Change ----07.22.2010
This.SetRow( 1 )
This.ScrollToRow( 1 )

dw_selected.Event pfc_Retrieve()

of_enable_select_buttons() //alfee 06.02.2009


end event

event itemchanged;call super::itemchanged;of_retrieve_data_view( data )

//Start Code Change ----07.22.2010 #V10 maha
of_default_set(integer(data))
//End Code Change ----07.22.2010


end event

type cb_save from u_cb within pfc_cst_u_views_manager
integer x = 2126
integer y = 28
integer height = 84
integer taborder = 120
integer weight = 700
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;IF of_Save() = -1 THEN
	MessageBox("Save", "Error while saving.")
END IF

DateTime ldt_dt

ldt_dt = DateTime( Today(), Now() )
UPDATE ids SET screen_cache = :ldt_dt, screen_obj_cache = :ldt_dt;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF
//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-10
//$<modify> 02.17.2006 By: owen chen
//$<reason> Performance tuning
//$<modification> Comment out the following script since salca.autocommit has the same functionality.
/*
COMMIT USING SQLCA;
*/
//---------------------------- APPEON END ----------------------------



end event

type cb_2 from u_cb within pfc_cst_u_views_manager
integer x = 2491
integer y = 28
integer width = 375
integer height = 84
integer taborder = 100
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Clos&e"
end type

event clicked;of_close()
end event

type dw_copy_from_fields from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 155
integer y = 1284
integer width = 521
integer height = 400
integer taborder = 110
boolean bringtotop = true
string dataobject = "d_data_view_fields"
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
end event

type dw_copy_to_fields from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 142
integer y = 948
integer width = 594
integer height = 288
integer taborder = 90
boolean bringtotop = true
string dataobject = "d_data_view_fields"
end type

event constructor;This.of_SetTransObject( SQLCA )

end event

type dw_copy_from_objects from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 539
integer y = 1616
integer width = 640
integer height = 320
integer taborder = 80
boolean bringtotop = true
string dataobject = "d_data_view_objects"
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )
end event

type dw_copy_to_objects from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 78
integer y = 576
integer width = 777
integer height = 332
integer taborder = 70
boolean bringtotop = true
string dataobject = "d_data_view_objects_all"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type dw_views from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 155
integer y = 1304
integer width = 1033
integer height = 544
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type cb_delete from u_cb within pfc_cst_u_views_manager
integer x = 1394
integer y = 28
integer height = 84
integer taborder = 50
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Delete View"
end type

event clicked;Integer li_ans
Integer li_Rc
Integer i

IF ii_data_view_id = 1 THEN
	MessageBox("Invalid Option", "The default system view can't be deleted!")
	Return
END IF

li_ans = MessageBox("Delete View", "Are you sure you want to delete the selected view?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return 
END IF

//\/maha app102805
// mkskinner 21 dec 2005 -- Begin
// added : before ii_data_view_id 

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-11
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

/*
delete from data_view_screen where data_view_id = :ii_data_view_id;
delete from data_view_fields where data_view_id = :ii_data_view_id;
delete from data_view_screen_objects where data_view_d = :ii_data_view_id;
delete from data_view where data_view_id = :ii_data_view_id;
// mkskinner 21 dec 2005 -- end 

//dw_delete_fields.settransobject(sqlca)
//dw_delete_fields.retrieve(ii_data_view_id)
//dw_views.Retrieve( ii_data_view_id )
//dw_selected.Retrieve( ii_data_view_id )
////dw_copy_to_fields.Retrieve(ii_data_view_id )
//dw_copy_to_objects.Retrieve( ii_data_view_id  )
//dw_view_security.Retrieve( ii_data_view_id  )
//
//li_rc = dw_copy_to_objects.RowCount()
//FOR i = 1 TO li_rc
//	dw_copy_to_objects.DeleteRow( 0 )
//END FOR
//
//li_rc = dw_delete_fields.RowCount() //maha app081905
//FOR i = 1 TO li_rc
//	dw_copy_to_fields.DeleteRow( 0 )
//END FOR
//
//li_rc = dw_selected.RowCount()
//FOR i = 1 TO li_rc
//	dw_selected.DeleteRow( 0 )
//END FOR
//
//li_rc = dw_view_security.RowCount()
//FOR i = 1 TO li_rc
//	dw_view_security.DeleteRow( 0 )
//END FOR
//
//dw_views.DeleteRow( 1 )
//
//IF of_save() = -1 THEN
//	MessageBox("Delete Error", SQLCA.SQLERRTEXT )
//	RETURN -1
//END IF

delete from security_user_views where view_id = :ii_data_view_id ; //maha 093002 because above was not working on security.
commit using sqlca;

dw_copy_to_fields.Reset()
dw_copy_to_objects.Reset()
dw_selected.Reset()

DataWindowChild dwchild
dw_select.Reset()
dw_select.of_SetTransObject( SQLCA )
dw_select.InsertRow( 0 )
dw_select.SetItem( 1, "data_view_id", 1 )
dw_select.GetChild( "data_view_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
*/
gnv_appeondb.of_startqueue( )

delete from data_view_screen where data_view_id = :ii_data_view_id;
delete from data_view_fields where data_view_id = :ii_data_view_id;
delete from data_view_screen_objects where data_view_id = :ii_data_view_id;
delete from data_view where data_view_id = :ii_data_view_id;

delete from security_user_views where view_id = :ii_data_view_id ; //maha 093002 because above was not working on security.

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.19.2008 by Andy
//Delete fields alias where data_view_id = ii_data_view_id.
delete from view_fields_alias where data_view_id = :ii_data_view_id;
//---------------------------- APPEON END ----------------------------

//---------Begin Commented by Alfee on 02.16.2009---------------------
//delete from data_view_report_fields where data_view_id = :ii_data_view_id;
//delete from data_view_report_objects where data_view_id = :ii_data_view_id;
//delete from screen_report_objects where data_view_id = :ii_data_view_id;
//delete from profile_report_dw where data_view_id = :ii_data_view_id;
//---------End Commented ----------------------------------------------

commit using sqlca;

dw_copy_to_fields.Reset()
dw_copy_to_objects.Reset()
dw_selected.Reset()

DataWindowChild dwchild
dw_select.Reset()
dw_select.of_SetTransObject( SQLCA )
dw_select.InsertRow( 0 )
dw_select.SetItem( 1, "data_view_id", 1 )
dw_select.GetChild( "data_view_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

gnv_appeondb.of_commitqueue( )

//---------------------------- APPEON END ----------------------------




of_retrieve_data_view( "1" )
of_enable_select_buttons()
end event

type cb_new from u_cb within pfc_cst_u_views_manager
integer x = 1029
integer y = 28
integer height = 84
integer taborder = 130
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Create View"
end type

event clicked;Integer li_data_view_id
Integer li_nr
String ls_data_view_name



IF of_save() = -1 THEN
	Return -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-01-04 By: Andy
//$<Reason> Fix a defect. bug:BugN122716
//Open( w_get_view_name )
OpenWithParm( w_get_view_name , "P" )
//---------------------------- APPEON END ----------------------------

ls_data_view_name = Message.StringParm

if ls_data_view_name = 'Cancel' then return  //Start Code Change ----11.28.2007 #V8 maha previously a view called cancel would be created.

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 07.22.2006 By: LeiWei
//$<reason> Contract module modification
/*
SELECT Max( data_view.data_view_id )  
INTO :li_data_view_id  
FROM data_view  ;
*/

ib_new = True //move from behide - Nova 04.13.2009

SELECT Max( data_view.data_view_id )  
INTO :li_data_view_id  
FROM data_view 
WHERE upper(type_c) = 'P';

//---------------------------- APPEON END ----------------------------

ii_data_view_id = li_data_view_id + 1

li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "data_view_id", ii_data_view_id )
dw_views.SetItem( li_nr, "data_view_name", ls_data_view_name )
dw_views.SetItem( li_nr, "type", "S" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.22.2006 By: LeiWei
//$<reason> Contract module modification
dw_views.SetItem( li_nr, "type_c", "P" )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//of_get_max_ids()

//dw_available.Event pfc_retrieve( )

gnv_appeondb.of_startqueue( )

SELECT Max(data_view_screen_objects.data_view_object_id)  
INTO :il_object_id
FROM data_view_screen_objects  ;

SELECT Max( data_view_fields.data_view_field_id )  
INTO :il_field_id  
FROM data_view_fields  ;

//--------Begin Commented by Alfee on 02.16.2009-------
//SELECT Max( data_view_report_fields.data_view_field_id )  
//INTO :il_report_field_id  
//FROM data_view_report_fields  ;
//
//SELECT Max( screen_report_objects.data_view_object_id )  
//INTO :il_screen_report_objectid  
//FROM screen_report_objects  ;
//
//SELECT Max(data_view_report_objects.data_view_object_id)  
//INTO :il_report_object_id
//FROM data_view_report_objects  ;
//---------End Commented ------------------------------

dw_available.Retrieve(1)

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
dw_selected.of_SetTransObject( SQLCA )

//Start Code By Jervis 04.18.2008
//dw_available.SelectRow( 1, True )
//cb_add.TriggerEvent( Clicked! )

//dw_available.SelectRow( 1, True )
//cb_add.TriggerEvent( Clicked! )
dw_available.Setfilter( "")
dw_available.filter( )
li_nr = dw_available.Find( "screen_id = -10",1,dw_available.rowcount())
dw_available.Setrow( li_nr)
cb_add.TriggerEvent( Clicked! )

li_nr = dw_available.Find( "screen_id = 1",1,dw_available.rowcount())
dw_available.Setrow( li_nr)
cb_add.TriggerEvent( Clicked! )

dw_selected.filter( )
dw_available.Setfilter( "screen_id > 0")
dw_available.filter( )
dw_available.SelectRow( 0, false )
dw_available.SelectRow( 1, True )
//End Cody By Jervis 04.18.2008

of_enable_select_buttons()

dw_available.SetSort( "screen_name" )
dw_available.Sort()

//-----Begin Commented by Nova 04.13.2009---------------
//ib_new = True - move to before, Nova 04.13.2009
//-----End Commented -----------------------------------
//$<add> 03.17.2008 by Andy
ib_Alias = True

//copy report data
//of_copy_report_data(1) - Commented by Alfee on 02.16.2009

cb_save.TriggerEvent( Clicked! ) //Add By Evan 01/09/2008
end event

type cb_down from u_cb within pfc_cst_u_views_manager
integer x = 1257
integer y = 744
integer height = 84
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Move Do&wn"
end type

event clicked;Integer li_cr


li_cr = dw_selected.GetRow()
if li_cr = dw_selected.RowCount() then Return //Add by Evan 01/11/2008

IF li_cr = 1 AND is_sort_field = "screen_order" THEN
	Beep(2)
	RETURN
END IF

dw_selected.SetItem( li_cr, is_sort_field, li_cr +1 )
dw_selected.SetItem( li_cr +1, is_sort_field, li_cr )
dw_selected.Sort()

dw_selected.ScrollToRow( li_cr +1 )
dw_selected.SetRow( li_cr +1 )
dw_selected.SelectRow( 0 , False )
dw_selected.SelectRow( li_cr +1, True )


end event

type cb_up from u_cb within pfc_cst_u_views_manager
integer x = 1257
integer y = 636
integer height = 84
integer taborder = 30
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Move &Up"
end type

event clicked;
Integer li_cr

li_cr = dw_selected.GetRow()
if li_cr = 1 then Return //Add by Evan 01/11/2008

IF li_cr = 2 AND is_sort_field = "screen_order" THEN
	Beep(2)
	RETURN
END IF

dw_selected.SetItem( li_cr, is_sort_field, li_cr - 1 )
dw_selected.SetItem( li_cr - 1, is_sort_field, li_cr )
dw_selected.Sort()

dw_selected.SetRow( li_cr - 1 )
dw_selected.ScrollToRow( li_cr - 1 )
dw_selected.SelectRow( 0 , False )
dw_selected.SelectRow( li_cr - 1, True )

dw_selected.Event RowFocusChanged(dw_selected.GetRow()) //Add by Evan 05.14.2009 --- Corrected BugS092505
end event

type dw_selected_dump from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 1467
integer y = 1432
integer width = 210
integer height = 148
integer taborder = 20
boolean bringtotop = true
boolean vscrollbar = false
boolean border = false
end type

event constructor;This.of_SetUpdateAble( False )
end event

type dw_view_security from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 1472
integer y = 1544
integer width = 183
integer height = 128
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_security_user_view_1"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type dw_delete_fields from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 526
integer y = 1076
integer width = 146
integer height = 132
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_data_viewfields_all_mike"
end type

type cb_required from commandbutton within pfc_cst_u_views_manager
integer x = 1257
integer y = 864
integer width = 343
integer height = 84
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Required"
end type

event clicked;openwithparm(w_set_required_screens,ii_data_view_id)

end event

event constructor;if of_get_app_setting("set_web","I") = 1 then
	this.visible = true
end if
end event

type dw_copy from datawindow within pfc_cst_u_views_manager
boolean visible = false
integer x = 1975
integer y = 624
integer width = 229
integer height = 524
integer taborder = 180
boolean bringtotop = true
string title = "none"
string dataobject = "d_select_view_list_added"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.settransobject(sqlca)
end event

type cb_copy from u_cb within pfc_cst_u_views_manager
integer x = 1760
integer y = 28
integer height = 84
integer taborder = 170
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "Copy View"
end type

event clicked;Integer li_data_view_id
Integer li_nr
Integer i
Integer ic
Integer li_copy_view
Integer li_screen
String ls_data_view_name


IF of_save() = -1 THEN
	RETURN -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 2008-01-04 By: Andy
//$<Reason> Fix a defect. bug:BugN122716
//Open( w_get_view_name )
OpenWithParm( w_get_view_name , "P" )
//---------------------------- APPEON END ----------------------------

ls_data_view_name = Message.StringParm

IF ls_data_view_name = "Cancel" THEN RETURN


SELECT Max( data_view.data_view_id )
	INTO :li_data_view_id
	FROM data_view
	Where Upper(type_c) = 'P';
	
li_copy_view = ii_data_view_id
ii_data_view_id = li_data_view_id + 1

dw_copy.SetFilter( "")
dw_copy.Filter( )
dw_copy.Retrieve(li_copy_view )


li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "data_view_id", ii_data_view_id )
dw_views.SetItem( li_nr, "data_view_name", ls_data_view_name )
dw_views.SetItem( li_nr, "type", "S" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 07.22.2006 By: LeiWei
//$<reason> Contract module modification
dw_views.SetItem( li_nr, "type_c", "P" )
//---------------------------- APPEON END ----------------------------

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-12
//$<modify> 02.06.2006 By: owen chen
//$<reason> performance tuning
//$<modification> Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.

//of_get_max_ids()

//dw_available.Event pfc_retrieve( )

gnv_appeondb.of_startqueue( )

SELECT Max(data_view_screen_objects.data_view_object_id)
	INTO :il_object_id
	From data_view_screen_objects  ;
	
SELECT Max( data_view_fields.data_view_field_id )
	INTO :il_field_id
	From data_view_fields  ;
	
//---------Begin Commented by Alfee on 02.16.2009-----------
//SELECT Max( data_view_report_fields.data_view_field_id )  
//INTO :il_report_field_id  
//FROM data_view_report_fields  ;
//
//SELECT Max( screen_report_objects.data_view_object_id )  
//INTO :il_screen_report_objectid  
//FROM screen_report_objects  ;
//
//SELECT Max(data_view_report_objects.data_view_object_id)  
//INTO :il_report_object_id
//FROM data_view_report_objects  ;
//----------End Commented ----------------------------------

//dw_available.Retrieve(1)

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
dw_selected.of_SetTransObject( SQLCA )

FOR i = 1 To dw_copy.RowCount()
	//debugbreak()
	li_screen = dw_copy.GetItemNumber(i,"screen_id")
	dw_copy.RowsCopy( i, i, primary!,dw_selected , 100, primary!)
   //--------Begin Modified by Nova 04.13.2009-----------
	//of_add_screen( li_screen ,0)
	of_add_screen(li_copy_view, li_screen, 0 ) 
	//--------End Modified -------------------------------
NEXT
dw_selected.Filter( ) //04.18.2008

//dw_available.SelectRow( 1, True )
//cb_add.TriggerEvent( Clicked! )

//dw_available.SelectRow( 1, True )

of_enable_select_buttons()

//dw_available.SetSort( "screen_name" )
//dw_available.Sort()

ib_new = True
//$<add> 03.17.2008 by Andy
ib_Alias = True

//copy report data
//of_copy_report_data(li_copy_view) - Commented by Alfee on 02.16.2009

cb_save.TriggerEvent( Clicked! ) //Add By Evan 01/09/2008

end event

type st_1 from statictext within pfc_cst_u_views_manager
integer x = 87
integer y = 20
integer width = 343
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select View"
boolean focusrectangle = false
end type

type dw_copy_report_fields from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 648
integer width = 837
integer height = 112
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_copy_report_fields"
end type

type dw_to_report_fields from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 784
integer width = 837
integer height = 112
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_copy_report_fields"
end type

type dw_copy_screen_report from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 920
integer width = 837
integer height = 112
integer taborder = 31
boolean bringtotop = true
string dataobject = "d_copy_screen_report"
end type

type dw_to_screen_report from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 1056
integer width = 837
integer height = 112
integer taborder = 41
boolean bringtotop = true
string dataobject = "d_copy_screen_report"
end type

type dw_copy_profile_report from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 1192
integer width = 837
integer height = 112
integer taborder = 51
boolean bringtotop = true
string dataobject = "d_copy_profile_report"
end type

type dw_to_profile_report from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 1328
integer width = 837
integer height = 112
integer taborder = 61
boolean bringtotop = true
string dataobject = "d_copy_profile_report"
end type

type dw_copy_report_object from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 1456
integer width = 837
integer height = 112
integer taborder = 71
boolean bringtotop = true
string dataobject = "d_copy_report_object"
end type

type dw_to_report_object from u_dw within pfc_cst_u_views_manager
boolean visible = false
integer x = 210
integer y = 1584
integer width = 837
integer height = 112
integer taborder = 81
boolean bringtotop = true
string dataobject = "d_copy_report_object"
end type

type cb_user from u_cb within pfc_cst_u_views_manager
integer x = 1394
integer y = 116
integer height = 84
integer taborder = 160
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&User Access"
end type

event clicked;//Start Code Change ----.2011 #V11 maha 
gs_pass_ids lst_ids
string s
datawindowchild dwchild

dw_select.getchild("data_view_id",dwchild)
s = dwchild.getitemstring(dwchild.getrow(),"data_view_name")

lst_ids.l_app_id = ii_data_view_id
lst_ids.ls_ref_value = s
lst_ids.ls_from_window = "View"

openwithparm(w_facility_user_security,lst_ids)

end event

type cb_rename from u_cb within pfc_cst_u_views_manager
integer x = 1029
integer y = 116
integer height = 84
integer taborder = 10
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Segoe UI"
string text = "&Properties"
end type

event clicked;Integer li_data_view_id
Integer li_nr
String res
datawindowchild dwchild


IF ii_data_view_id = 1 THEN
	MessageBox("Note", "The Default system view cannot be renamed.")
	//return //Start Code Change ----06.02.2016 #V152 maha - removed to allow the screen to open
END IF

OpenWithParm( w_data_view_prop , ii_data_view_id )

res = Message.StringParm

if res = 'Cancel' then return  //Start Code Change ----11.28.2007 #V8 maha previously a view called cancel would be created.

dw_select.GetChild( "data_view_id", dwchild )
dwchild.settransobject(sqlca)
li_nr = dwchild.retrieve()
dw_select.SetItem( 1, "data_view_id", ii_data_view_id)
//messagebox("",li_nr)

end event

type st_head1 from statictext within pfc_cst_u_views_manager
integer y = 240
integer width = 1189
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Available Screens from Default View"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_head2 from statictext within pfc_cst_u_views_manager
integer x = 1669
integer y = 240
integer width = 1248
integer height = 92
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Selected Screens"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_rds from commandbutton within pfc_cst_u_views_manager
integer x = 1760
integer y = 116
integer width = 535
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Required Data Setup"
end type

event clicked;openwithparm(w_data_view_required_data_setup ,ii_data_view_id)
end event

type cb_search from commandbutton within pfc_cst_u_views_manager
integer x = 2299
integer y = 116
integer width = 567
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Search Results Setup"
end type

event clicked;openwithparm(w_data_view_search_fields_setup, ii_data_view_id)
end event

