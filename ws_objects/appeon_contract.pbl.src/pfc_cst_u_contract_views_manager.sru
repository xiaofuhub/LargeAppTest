$PBExportHeader$pfc_cst_u_contract_views_manager.sru
forward
global type pfc_cst_u_contract_views_manager from u_base_concentration_box
end type
type dw_select from u_dw within pfc_cst_u_contract_views_manager
end type
type cb_1 from u_cb within pfc_cst_u_contract_views_manager
end type
type cb_2 from u_cb within pfc_cst_u_contract_views_manager
end type
type dw_views from u_dw within pfc_cst_u_contract_views_manager
end type
type cb_3 from u_cb within pfc_cst_u_contract_views_manager
end type
type cb_new from u_cb within pfc_cst_u_contract_views_manager
end type
type gb_select from groupbox within pfc_cst_u_contract_views_manager
end type
type dw_view_security from u_dw within pfc_cst_u_contract_views_manager
end type
end forward

global type pfc_cst_u_contract_views_manager from u_base_concentration_box
integer width = 3639
integer height = 2032
event pfc_cst_view_manager ( )
dw_select dw_select
cb_1 cb_1
cb_2 cb_2
dw_views dw_views
cb_3 cb_3
cb_new cb_new
gb_select gb_select
dw_view_security dw_view_security
end type
global pfc_cst_u_contract_views_manager pfc_cst_u_contract_views_manager

type variables
w_contract_data_views_manager iw_win

Integer ii_data_view_id = 1001

Boolean ib_new = False

DataStore ids_clause_rules

Boolean ib_Alias = false // Andy 03172008
end variables

forward prototypes
public function integer of_save ()
public function integer of_close ()
public function integer of_enable_select_buttons ()
public function integer of_retrieve_data_view (string as_data)
public function integer of_set_parent_window (window aw_win)
public function integer of_rid_duplicates ()
end prototypes

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
long	ll_Cycle,ll_Count,ll_ScreenId

//Long ll_row
//Long ll_screen_id[]
//dwItemStatus l_status
//
//// Recored new screen id
//FOR ll_row = 1 TO dw_selected.Rowcount( )
//	l_status = dw_selected.GetItemStatus(ll_row, 0, Primary!)
//	IF l_status = NewModified!	OR l_status = New! THEN
//		ll_screen_id[UpperBound(ll_screen_id) + 1] = dw_selected.GetItemNumber( ll_row, "screen_id")
//	END IF
//END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-01-10 By: Scofield
//$<Reason> Update the data fill.
ll_Count = dw_available.RowCount()
li_row_cnt = ids_clause_rules.Retrieve() //alfee 02.20.2008

gnv_appeondb.of_startqueue( )
for ll_Cycle = 1 to ll_Count
	ll_ScreenId = dw_available.GetItemNumber(ll_Cycle,'Screen_id')
	//----Begin Added by Alfee on 02.20.2008--------------
	IF li_row_cnt > 0 THEN 
		IF ids_clause_rules.Find("data_view_id = " + String(ii_data_view_id) + " And screen_id = " + String(ll_ScreenId), 1, li_row_cnt ) > 0 THEN
			MessageBox("Save Error", "The screens have been used in clause rules and can't be deleted.")	
			RETURN -1
		END IF
	END IF
	//----End Added -----------------------------------
	delete from ctx_screen_datafill where data_view_id = :ii_data_view_id and screen_id = :ll_ScreenId ;
next
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

IF dw_views.Update( True, False ) = 1 THEN
	IF dw_selected.Update( True, False ) = 1 THEN
		COMMIT USING SQLCA;
		
		DataWindowChild dwchild
		dw_select.GetChild( "data_view_id", dwchild )
		dwchild.settransobject( SQLCA )
		dwchild.Retrieve()		
		dw_select.SetItem( 1	, "data_view_id", ii_data_view_id )

		dw_selected.ResetUpdate ( )
		dw_views.ResetUpdate ( )				
	ELSE
		messagebox("Save Error","Error Updating Selected Window")  //Start Code Change ---- 02.09.2007 #V7 maha
		ROLLBACK USING SQLCA;
		RETURN -1
	END IF
ELSE
	messagebox("Save Error","Error Updating View ")  //Start Code Change ---- 02.09.2007 #V7 maha
	ROLLBACK USING SQLCA;
	RETURN -1
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.19.2008 by Andy
//Initial view and field alias for IntelliReport.
if ib_Alias then
	n_cst_update_view_fields_alias lnvo_update
	
	lnvo_update = create n_cst_update_view_fields_alias
	lnvo_update.of_update_view_fields_alias( 1, ii_data_view_id)
	destroy lnvo_update
end if
//---------------------------- APPEON END ----------------------------

//// Update syntax of new screen
//FOR i = 1 TO UpperBound(ll_screen_id)
//	
//END FOR
//
//check to see if security is installed, if it is not then give access to new view
ls_version = ProfileString(gs_IniFilePathName, "setup", "version", "None")
IF appeongetclienttype() = 'PB' THEN
	IF NOT FileExists(gs_IniFilePathName) THEN
		//MessageBox("ini File Error", "No intellicred.ini file found at: " + gs_IniFilePathName )
		MessageBox("INI File Error", "No intellicred.ini file was found at: " + gs_IniFilePathName )
		Return -1
	END IF
END IF

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
//$<modify> 04.20.2007 By: Jack
//$<reason> Fix a defect.
/*
IF ib_new THEN
*/
IF ib_new And Not gb_contract_version THEN
//---------------------------- APPEON END ----------------------------
	lds_users = CREATE n_ds
	lds_users.DataObject = "d_list_of_users"
	lds_users.SetTransObject( SQLCA )
	li_user_cnt = lds_users.Retrieve( )

	IF li_user_cnt > 0 THEN
		li_rec_id = gnv_app.of_get_id( "user_view_id", li_user_cnt) - 1
	END IF

	gnv_appeondb.of_startqueue( )

	FOR u = 1 TO li_user_cnt
		li_rec_id ++
		ls_user_id = lds_users.GetItemString( u, "user_id" )
		
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
	
	COMMIT;
	
	gnv_appeondb.of_commitqueue( )
	
//	MessageBox("User Painter", "To assign this View to a user you need to update the User Painter.")
END IF

DESTROY lds_users;

ib_new = False
//$<add> 03.17.2008 by Andy
ib_Alias = False

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

public function integer of_retrieve_data_view (string as_data);dw_available.Reset( )
dw_selected.Reset( )
dw_views.Reset( )

ib_new = FALSE

ii_data_view_id = Integer( as_data )

SetPointer(HourGlass!)

Setredraw(false)

gnv_appeondb.of_startqueue( )

dw_available.Retrieve(1001)
dw_selected.Retrieve(ii_data_view_id)

gnv_appeondb.of_commitqueue( )

of_rid_duplicates( )

dw_available.SelectRow( 0, False )
dw_selected.SelectRow( 0, False )

of_enable_select_buttons()

Setredraw(true)

RETURN 0
end function

public function integer of_set_parent_window (window aw_win);iw_win = aw_win

Return 0 
end function

public function integer of_rid_duplicates ();Integer li_available_cnt
Integer i
Integer li_screen_id
Integer li_found

li_available_cnt = dw_available.RowCount()

FOR i = li_available_cnt TO 1 STEP -1
	li_screen_id = dw_available.GetItemNumber( i, "screen_id" )
	li_found = dw_selected.Find( "screen_id = " + String( li_screen_id ), 1, 1000 )
	IF li_found > 0 THEN
		dw_available.Deleterow( i )
	END IF
END FOR

Return 0
end function

on pfc_cst_u_contract_views_manager.create
int iCurrent
call super::create
this.dw_select=create dw_select
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_views=create dw_views
this.cb_3=create cb_3
this.cb_new=create cb_new
this.gb_select=create gb_select
this.dw_view_security=create dw_view_security
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_select
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.dw_views
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_new
this.Control[iCurrent+7]=this.gb_select
this.Control[iCurrent+8]=this.dw_view_security
end on

on pfc_cst_u_contract_views_manager.destroy
call super::destroy
destroy(this.dw_select)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_views)
destroy(this.cb_3)
destroy(this.cb_new)
destroy(this.gb_select)
destroy(this.dw_view_security)
end on

event constructor;dw_available.of_SetBase(TRUE)
dw_selected.of_SetBase(TRUE)

dw_selected.of_SetTransObject(SQLCA)
dw_available.of_SetTransObject(SQLCA)

// assume that the available datawindow is not updateable.  If needed, this can be
// overrided in the constructor script of the ancestor
dw_available.of_setupdateable(FALSE)

//---------Begin Added by Alfee 02.20.2008---------------
ids_clause_rules = Create DataStore
ids_clause_rules.DataObject = 'd_cntx_clause_rules_view'
ids_clause_rules.SetTransObject(SQLCA)
//---------End Added ------------------------------------

Return 0
end event

event destructor;call super::destructor;
IF IsValid(ids_clause_rules) THEN Destroy ids_clause_rules //Alfee 02.20.2008

end event

type cb_clear_all from u_base_concentration_box`cb_clear_all within pfc_cst_u_contract_views_manager
boolean visible = false
integer x = 1518
integer y = 992
integer taborder = 200
end type

type cb_clear from u_base_concentration_box`cb_clear within pfc_cst_u_contract_views_manager
integer x = 1650
integer y = 1328
integer width = 315
integer height = 84
integer taborder = 190
string text = "<- &Remove"
end type

event cb_clear::clicked;Integer li_cr, i
String ls_tab_name
String ls_str
Integer li_selected_cnt

li_cr = dw_selected.GetRow()
IF li_cr = 0 THEN RETURN
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.
If dw_selected.rowcount() < 1 Then Return
If li_cr > dw_selected.rowcount() Then li_cr = dw_selected.rowcount()
//---------------------------- APPEON END ----------------------------
ls_tab_name = dw_selected.GetitemString( li_cr, "tab_name")

IF ii_data_view_id = 1001 THEN
	MessageBox("Invalid Option", "Screens cannot be removed from the default system view!")
	Return
END IF

IF Lower(ls_tab_name) = "tabpage_search" THEN
	MessageBox("Invalid Option", "You can't delete Search screen from the screen list!")
	Return	
END IF

IF ii_data_view_id = 0 THEN
	MessageBox("Select View", "You must first select a view before adding sections.")
	Return
END IF

Parent.Setredraw(False)

Parent.post Setredraw(True)

// get all the screens in the same tab to remove
li_selected_cnt = dw_selected.Rowcount( )
FOR i = li_selected_cnt TO 1 STEP -1
	ls_str = dw_selected.GetitemString( i, "tab_name")
	IF ls_str <> ls_tab_name THEN CONTINUE
	
	dw_selected.RowsCopy( i, i, Primary!, dw_available, 1000, Primary!)
	dw_selected.DeleteRow( i )
END FOR

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

type cb_add_all from u_base_concentration_box`cb_add_all within pfc_cst_u_contract_views_manager
boolean visible = false
integer x = 1577
integer y = 824
integer taborder = 180
string text = "Add All->>"
end type

type cb_add from u_base_concentration_box`cb_add within pfc_cst_u_contract_views_manager
integer x = 1650
integer y = 1212
integer width = 315
integer height = 84
integer taborder = 170
end type

event cb_add::clicked;Integer li_cr, i
Integer li_selected_last_row
String ls_tab_name
String ls_str
Integer li_available_cnt
Long ll_dw_sql_len
String ls_syntax, ls_ScreenStyle
Long ll_screen_id

IF ii_data_view_id = 0 THEN
	MessageBox("Select View", "You must first select a view before adding sections.")
	Return
END IF

Parent.SetRedraw(False)
Parent.POST SetRedraw(True)
// Move all the screens in the same tab from available to selected
li_cr = dw_available.GetRow()
IF li_cr = 0 THEN RETURN
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.26.2007 By: Jack
//$<reason> Fix a defect.
If dw_available.rowcount() < 1 Then Return
If li_cr > dw_available.rowcount() Then li_cr = dw_available.rowcount()
//---------------------------- APPEON END ----------------------------

ls_tab_name = dw_available.GetitemString( li_cr, "tab_name")
li_available_cnt = dw_available.Rowcount( )
FOR i = li_available_cnt TO 1 STEP -1
	ls_str = dw_available.GetitemString( i, "tab_name")
	ls_ScreenStyle = dw_available.GetitemString( i, "tab_name")//added by gavins 20120313 grid
	IF ls_str <> ls_tab_name THEN CONTINUE
	
	ls_syntax = ""
	IF appeongetclienttype() = 'PB' THEN
		If ls_ScreenStyle = 'G' Then
			ll_dw_sql_len = dw_available.GetItemNumber( i, "grid_sql_len")
		Else
			ll_dw_sql_len = dw_available.GetItemNumber( i, "dw_sql_len")
		End If
		ll_screen_id = dw_available.GetItemNumber( i, "screen_id")
		IF ll_dw_sql_len > 32766 THEN
			If ls_ScreenStyle = 'G' Then
				ls_syntax = f_get_screen_gridsql(1001, ll_screen_id,false)  //add false argu - jervis 10.11.2011
			Else
				ls_syntax = f_get_screen_sql(1001, ll_screen_id,false)  //add false argu - jervis 10.11.2011
			End If
		END IF
	END IF

	dw_available.RowsMove( i, i, Primary!, dw_selected, 1000, Primary!)
	li_selected_last_row = dw_selected.RowCount()
	dw_selected.SetItem( li_selected_last_row, "data_view_id", ii_data_view_id )

	IF Len(ls_syntax) > 0 THEN
		If ls_ScreenStyle = 'G' Then
			dw_selected.SetItem( li_selected_last_row, "grid_sql", ls_syntax )
		Else
			dw_selected.SetItem( li_selected_last_row, "dw_sql", ls_syntax )
		End If
	END IF

END FOR

of_enable_select_buttons()

dw_selected.Sort()

//$<add> 03.17.2008 by Andy
ib_Alias = True


end event

type dw_selected from u_base_concentration_box`dw_selected within pfc_cst_u_contract_views_manager
integer x = 1993
integer y = 256
integer width = 1609
integer height = 1688
integer taborder = 160
boolean titlebar = true
string title = "Selected Screens "
string dataobject = "d_contract_data_view_screens_list"
boolean hscrollbar = true
boolean resizable = true
borderstyle borderstyle = stylebox!
end type

event dw_selected::constructor;call super::constructor;This.of_SetTransObject( SQLCA )
end event

event dw_selected::clicked;call super::clicked;Integer li_row

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.SelectRow( 0, False )
	This.SelectRow( li_row, TRUE )
	This.ScrollToRow( li_row )
	dw_available.SelectRow( 0, False )
END IF



end event

event dw_selected::rowfocuschanged;call super::rowfocuschanged;This.SelectRow( 0, False )
This.SelectRow( currentrow, True )
end event

event dw_selected::pfc_update;Return 0
end event

event dw_selected::getfocus;call super::getfocus;IF This.RowCount() > 0 THEN
	dw_available.SelectRow( 0, False )
	This.SelectRow( This.GetRow(), True )
END IF
end event

type dw_available from u_base_concentration_box`dw_available within pfc_cst_u_contract_views_manager
integer x = 14
integer y = 256
integer width = 1609
integer height = 1688
boolean titlebar = true
string title = "Available Screens"
string dataobject = "d_contract_data_view_screens_list"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event dw_available::constructor;call super::constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateable( False )
end event

event dw_available::clicked;call super::clicked;Integer li_row

dw_selected.SelectRow( 0, False )

li_row = This.GetClickedRow()

IF li_row > 0 THEN
	This.ScrollToRow( li_row )
	This.SelectRow( li_row, TRUE )
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

type dw_select from u_dw within pfc_cst_u_contract_views_manager
integer x = 73
integer y = 72
integer width = 1129
integer height = 96
integer taborder = 150
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;This.of_SetTransObject( SQLCA )
This.of_SetUpdateAble( False )

This.InsertRow( 0 )
This.SetItem( 1, "data_view_id", 1001 )
This.SetRow( 1 )
This.ScrollToRow( 1 )

dw_selected.of_SetTransObject( SQLCA )
dw_selected.Post Retrieve(1001)
//$<add> 01.08.2008
//$Reason:button enable control bug:BugN122719
post of_enable_select_buttons()
//end of add 01.08.2008


end event

event itemchanged;call super::itemchanged;of_retrieve_data_view( data )
end event

type cb_1 from u_cb within pfc_cst_u_contract_views_manager
integer x = 1650
integer y = 1752
integer width = 315
integer height = 84
integer taborder = 120
string text = "&Save"
end type

event clicked;IF of_Save() = -1 THEN
	//MessageBox("Save", "Error while saving.")//Start Code Change ---- 02.09.2007 #V7 maha  added better messages to function
END IF

/*
DateTime ldt_dt
ldt_dt = DateTime( Today(), Now() )

gnv_appeondb.of_autocommit( )

UPDATE ids SET screen_cache = :ldt_dt, screen_obj_cache = :ldt_dt;
COMMIT USING SQLCA;
*/
end event

type cb_2 from u_cb within pfc_cst_u_contract_views_manager
integer x = 1650
integer y = 1860
integer width = 315
integer height = 84
integer taborder = 100
string text = "Clos&e"
end type

event clicked;of_close()
end event

type dw_views from u_dw within pfc_cst_u_contract_views_manager
boolean visible = false
integer x = 14
integer y = 400
integer width = 1033
integer height = 544
integer taborder = 60
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

type cb_3 from u_cb within pfc_cst_u_contract_views_manager
integer x = 1431
integer y = 72
integer height = 84
integer taborder = 50
string text = "&Delete View"
end type

event clicked;Integer li_ans
Integer li_Rc
Integer i

IF ii_data_view_id = 1001 THEN
	MessageBox("Invalid Option", "The default system view can't be deleted!")
	Return
END IF

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 09.26.2006 By: LeiWei
//$<reason> Fix a defect.

Select 1
INTO :li_ans
FROM code_lookup
Where lookup_name = 'contract category'
and ic_n = :ii_data_view_id;

IF li_ans = 1 THEN
	MessageBox("Delete View", "The view already used in contract category.")
	Return
END IF

SELECT 1
INTO :li_ans
 FROM security_users  
WHERE contract_default_view = :ii_data_view_id;

IF li_ans = 1 THEN
	//MessageBox("Delete View", "The view already set to default view in user painter.")
	MessageBox("Delete View", "The view has already been set to default view in user painter.")
	Return
END IF
//---------------------------- APPEON END ----------------------------

//-----Begin Added by Alfee 02.20.2008---------------------------------
Select 1
INTO :li_ans
FROM ctx_acp_template_clause_rules
WHERE data_view_id = :ii_data_view_id ;

IF li_ans = 1 THEN
	MessageBox("Delete View", "The view already used in clause rules.")
	Return
END IF
//-----End Added ------------------------------------------------------

li_ans = MessageBox("Delete View", "Are you sure you want to delete the selected view?", Question!, YesNo!, 2 )
IF li_ans = 2 THEN
	Return 
END IF

gnv_appeondb.of_startqueue( )

delete from ctx_screen_datafill where data_view_id = :ii_data_view_id;	//Added by Scofield on 2007-10-26
delete from ctx_screen where data_view_id = :ii_data_view_id;
delete from security_user_views where view_id = :ii_data_view_id ; //maha 093002 because above was not working on security.
delete from data_view where data_view_id = :ii_data_view_id;

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 02.19.2008 by Andy
//Delete fields alias where data_view_id = ii_data_view_id.
delete from view_fields_alias where data_view_id = :ii_data_view_id;
//---------------------------- APPEON END ----------------------------

commit using sqlca;

DataWindowChild dwchild
dw_select.GetChild( "data_view_id", dwchild )
dwchild.settransobject( SQLCA )
dwchild.Retrieve()		
dw_select.SetItem( 1	, "data_view_id", 1001 )

dw_available.Reset( )
dw_selected.Retrieve(1001)

gnv_appeondb.of_commitqueue( )

ii_data_view_id = 1001

of_enable_select_buttons()
end event

type cb_new from u_cb within pfc_cst_u_contract_views_manager
integer x = 1047
integer y = 72
integer height = 84
integer taborder = 130
boolean bringtotop = true
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
OpenWithParm( w_get_view_name , "C" )
//---------------------------- APPEON END ----------------------------

ls_data_view_name = Message.StringParm

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2007 By: Frank.Gui
//$<reason> 
IF lower(ls_data_view_name)='cancel' THEN return
//---------------------------- APPEON END ----------------------------

SELECT Max( data_view.data_view_id )  
INTO :li_data_view_id  
FROM data_view;
//WHERE upper(type_c) = 'C';//Removed by Frank.Gui. 2007-04-28

ii_data_view_id = li_data_view_id + 1

li_nr = dw_views.InsertRow( 0 )
dw_views.SetItem( li_nr, "data_view_id", ii_data_view_id )
dw_views.SetItem( li_nr, "data_view_name", ls_data_view_name )
dw_views.SetItem( li_nr, "type", "S" )
dw_views.SetItem( li_nr, "type_c", "C" )

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 04.28.2007 By: Frank.Gui
//$<reason> 
IF dw_views.update() < 1 THEN
	messagebox("Save View","Failed to create new view due to "+sqlca.sqlerrtext)
	return
ELSE
	DataWindowChild dwchild
	dw_select.GetChild( "data_view_id", dwchild )
	dwchild.settransobject( SQLCA )
	dwchild.Retrieve()		
	dw_select.SetItem( 1	, "data_view_id", ii_data_view_id )
END IF
//---------------------------- APPEON END ----------------------------

dw_available.Retrieve(1001)//1001=Default System View
dw_selected.Reset( )

// Should be required and selected by default. added by 2006.8.30
//$<add> 01.10.2007 By: Davis
Integer i
String ls_tab_name
FOR i = 1 TO dw_available.Rowcount( )
	ls_tab_name = dw_available.GetitemString( i, "tab_name")

	IF Lower(ls_tab_name) = "tabpage_search" THEN
		dw_available.SetRow( i )
		EXIT
	END IF
END FOR
//$<add> 01.10.2007 By: Davis

cb_add.TriggerEvent( Clicked! )

dw_available.SelectRow( 1, True )

of_enable_select_buttons()

dw_available.Sort()

of_enable_select_buttons()

ib_new = True
//$<add> 03.17.2008 by Andy
ib_Alias = True
end event

type gb_select from groupbox within pfc_cst_u_contract_views_manager
integer x = 37
integer y = 4
integer width = 1792
integer height = 192
integer taborder = 140
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
string text = "Select View"
end type

type dw_view_security from u_dw within pfc_cst_u_contract_views_manager
boolean visible = false
integer x = 1015
integer y = 540
integer width = 183
integer height = 128
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_security_user_view_1"
end type

event constructor;This.of_SetTransObject( SQLCA )
end event

