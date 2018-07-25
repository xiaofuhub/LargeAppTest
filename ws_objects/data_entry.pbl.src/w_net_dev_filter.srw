$PBExportHeader$w_net_dev_filter.srw
forward
global type w_net_dev_filter from window
end type
type cb_2 from commandbutton within w_net_dev_filter
end type
type cb_clear from commandbutton within w_net_dev_filter
end type
type cb_filter from commandbutton within w_net_dev_filter
end type
type dw_filter from u_dw within w_net_dev_filter
end type
end forward

global type w_net_dev_filter from window
integer x = 27
integer y = 2088
integer width = 3726
integer height = 368
boolean titlebar = true
string title = "Filter"
windowtype windowtype = popup!
long backcolor = 33551856
event ue_post_open ( )
cb_2 cb_2
cb_clear cb_clear
cb_filter cb_filter
dw_filter dw_filter
end type
global w_net_dev_filter w_net_dev_filter

type variables
String is_open_from1
integer ii_mod = 0



end variables

on w_net_dev_filter.create
this.cb_2=create cb_2
this.cb_clear=create cb_clear
this.cb_filter=create cb_filter
this.dw_filter=create dw_filter
this.Control[]={this.cb_2,&
this.cb_clear,&
this.cb_filter,&
this.dw_filter}
end on

on w_net_dev_filter.destroy
destroy(this.cb_2)
destroy(this.cb_clear)
destroy(this.cb_filter)
destroy(this.dw_filter)
end on

event close;//--------Begin Added by alfee 09.16.2010 ---------------------------------
//SK Practitioner Folder
//IF gb_sk_ver AND (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN
IF (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN	//Bug 3375 - Alfee 01.08.2013 	
	w_prac_data_sk.tab_1.tabpage_net.uo_net.of_clear_filter( )
	RETURN
END IF
//-------End Added ------------------------------------------------------------

IF is_open_from1 = 'PFI' THEN
	//w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.of_clear_filter( )
	gw_prac_data.tab_1.tabpage_net.uo_net.of_clear_filter( )  //Start Code Change ----05.28.2014 #V14.2 maha
ELSEIF is_open_from1 = 'PFC' THEN
	gw_prac_data.tab_1.tabpage_net.uo_net.of_clear_filter( )  //Start Code Change ----05.28.2014 #V14.2 maha
	//w_prac_data_1.tab_1.tabpage_net.uo_net.of_clear_filter( )
ELSEIF is_open_from1 = 'PFIA' THEN
	//w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
ELSEIF is_open_from1 = 'PFCA' THEN
	//	w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
END IF
end event

event open;IF gi_intelliapp_type > 0 THEN
	dw_filter.Modify( "app_id.visible = '0'" )
	dw_filter.Modify( "app_id_t.visible = '0'" )	
END IF

//Start Code Change ----12.02.2008 #V85 maha
is_open_from1 = message.stringparm

choose case is_open_from1
	case "PFIA","PFIC"
		w_net_dev_filter.y = w_net_dev_filter.y + 200
		cb_clear.visible  = false
end choose
//End Code Change---12.02.2008
end event

type cb_2 from commandbutton within w_net_dev_filter
integer x = 3374
integer y = 20
integer width = 320
integer height = 72
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;

Close( Parent )
end event

type cb_clear from commandbutton within w_net_dev_filter
integer x = 3374
integer y = 104
integer width = 320
integer height = 72
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Clear Filter"
end type

event clicked;dw_filter.Reset()
dw_filter.InsertRow( 0 )

//--------Begin Added by alfee 09.16.2010 ---------------------------------
//SK Practitioner Folder
//IF gb_sk_ver AND (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN
IF (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN	//Bug 3375 - Alfee 01.08.2013 		
	w_prac_data_sk.tab_1.tabpage_net.uo_net.of_clear_filter( )
	ii_mod = 0
	RETURN
END IF
//-------End Added ------------------------------------------------------------

IF is_open_from1 = 'PFI' THEN //prac - app
	gw_prac_data.tab_1.tabpage_net.uo_net.of_clear_filter( )  //Start Code Change ----05.28.2014 #V14.2 maha
	//w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.of_clear_filter( )
ELSEIF is_open_from1 = 'PFC' THEN //prac - cred
	gw_prac_data.tab_1.tabpage_net.uo_net.of_clear_filter( )
	//w_prac_data_1.tab_1.tabpage_net.uo_net.of_clear_filter( )
ELSEIF is_open_from1 = 'PFIA' THEN //action items - app
	w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_clear_filter( ) //Start Code Change ----12.02.2008 #V85 maha - added
	//w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
ELSEIF is_open_from1 = 'PFCA' THEN //action items - cred
	w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_clear_filter( ) //Start Code Change ----12.02.2008 #V85 maha - added
	//	w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
END IF

ii_mod = 0
end event

type cb_filter from commandbutton within w_net_dev_filter
integer x = 3374
integer y = 188
integer width = 320
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Apply Filter"
boolean default = true
end type

event clicked;//if ii_mod = 0 then 	return //maha app101805

//--------Begin Added by alfee 09.16.2010 ---------------------------------
//SK Practitioner Folder
//IF gb_sk_ver AND (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN
IF (is_open_from1 = 'PFI'  OR is_open_from1 = 'PFC') AND IsValid(w_prac_data_sk) THEN	//Bug 3375 - Alfee 01.08.2013 	
	w_prac_data_sk.tab_1.tabpage_net.uo_net.of_filter ( "dd", dw_filter )
	RETURN
END IF
//-------End Added ------------------------------------------------------------

IF is_open_from1 = 'PFI' THEN
	gw_prac_data.tab_1.tabpage_net.uo_net.of_filter ( "dd", dw_filter )
	//w_prac_data_intelliapp.tab_1.tabpage_net.uo_net.of_filter ( "dd", dw_filter )
ELSEIF is_open_from1 = 'PFC' THEN
	gw_prac_data.tab_1.tabpage_net.uo_net.of_filter ( "dd", dw_filter )  //Start Code Change ----05.28.2014 #V14.2 maha
	//w_prac_data_1.tab_1.tabpage_net.uo_net.of_filter( "dd", dw_filter )	
ELSEIF is_open_from1 = 'PFIA' THEN
	w_action_items_ia.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
ELSEIF is_open_from1 = 'PFCA' THEN
	w_action_items.tab_1.tabpage_net_dev.uo_net_dev.of_filter( "dd", dw_filter )	
END IF



//CloseWithReturn( Parent, dw_filter )
end event

type dw_filter from u_dw within w_net_dev_filter
integer y = 28
integer width = 3333
integer height = 252
integer taborder = 10
string dataobject = "d_net_dev_action_items_filter"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;call super::constructor;DataWindowChild dwchild

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<modify> 02.21.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> 1)Add Appeon Queue labels to reduce client-server interactions to improve runtime performance.
//$<modification> 2)Collect all SQL statements related to dwchild.InsertRow and place them behind the Appeon
//$<modification> Commit Queue label.

/*
dw_filter.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "ALL" )

dw_filter.SetItem( 1, "action_type", 0 )
dw_filter.SetItem( 1, "action_dept", 0 )
dw_filter.SetItem( 1, "action_user", "ALL" )
dw_filter.SetItem( 1, "action_status", 0 )


dw_filter.GetChild( "app_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )
*/

gnv_appeondb.of_startqueue( )

dw_filter.GetChild( "action_type", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Type")

dw_filter.GetChild( "action_dept", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Department")

dw_filter.GetChild( "action_status", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("Action Status")

dw_filter.GetChild( "action_user", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve()

dw_filter.GetChild( "app_id", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve( )

gnv_appeondb.of_commitqueue( )

dw_filter.GetChild( "action_type", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_dept", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_status", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "code", "ALL" )
dwchild.SetItem( 1, "lookup_code", 0 )

dw_filter.GetChild( "action_user", dwchild )
dwchild.InsertRow( 1 )
dwchild.SetItem( 1, "user_id", "ALL" )

dw_filter.SetItem( 1, "action_type", 0 )
dw_filter.SetItem( 1, "action_dept", 0 )
dw_filter.SetItem( 1, "action_user", "ALL" )
dw_filter.SetItem( 1, "action_status", 0 )


//---------------------------- APPEON END ----------------------------

This.InsertRow( 0 )

dw_filter.SetItem( 1, "date_type", 1 )  //Start Code Change ----04.12.2011 #V11 maha 

//setup filter data window
dw_filter.of_SetUpdateAble( False )

//dw_filter.InsertRow( 0 ) ////Start Code Change ----04.12.2011 #V11 maha - removed redundant


dw_filter.of_SetRowManager( TRUE )
dw_filter.of_SetReqColumn(TRUE)
dw_filter.of_SetTransObject(SQLCA)

//dw_filter.of_SetDropDownCalendar( TRUE )
//dw_filter.iuo_calendar.of_Register(dw_filter.iuo_calendar.DDLB)

end event

event itemchanged;call super::itemchanged;ii_mod = 1
end event

event editchanged;call super::editchanged;ii_mod = 1
end event

