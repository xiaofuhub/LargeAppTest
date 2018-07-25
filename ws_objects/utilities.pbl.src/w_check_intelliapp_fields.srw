$PBExportHeader$w_check_intelliapp_fields.srw
forward
global type w_check_intelliapp_fields from window
end type
type cb_5 from commandbutton within w_check_intelliapp_fields
end type
type st_1 from statictext within w_check_intelliapp_fields
end type
type cb_4 from commandbutton within w_check_intelliapp_fields
end type
type cb_3 from commandbutton within w_check_intelliapp_fields
end type
type cb_2 from commandbutton within w_check_intelliapp_fields
end type
type cb_1 from commandbutton within w_check_intelliapp_fields
end type
type dw_2 from datawindow within w_check_intelliapp_fields
end type
type dw_1 from datawindow within w_check_intelliapp_fields
end type
end forward

global type w_check_intelliapp_fields from window
integer x = 5
integer y = 1720
integer width = 1833
integer height = 732
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
cb_5 cb_5
st_1 st_1
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
end type
global w_check_intelliapp_fields w_check_intelliapp_fields

type variables
Integer ii_stop = 0
String is_app_id
Boolean ib_fix_all = True

end variables

on w_check_intelliapp_fields.create
this.cb_5=create cb_5
this.st_1=create st_1
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.cb_5,&
this.st_1,&
this.cb_4,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_2,&
this.dw_1}
end on

on w_check_intelliapp_fields.destroy
destroy(this.cb_5)
destroy(this.st_1)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
end on

event open;IF PosA(Message.StringParm, "SINGLE" ) > 0 THEN
	is_app_id = MidA( Message.StringParm, PosA( Message.StringParm, "-" ) + 1, 100 )
	ib_fix_all = False
END IF
end event

type cb_5 from commandbutton within w_check_intelliapp_fields
integer x = 1079
integer y = 12
integer width = 338
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close( Parent )
end event

type st_1 from statictext within w_check_intelliapp_fields
integer x = 27
integer y = 576
integer width = 1742
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_check_intelliapp_fields
integer x = 1435
integer y = 12
integer width = 338
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;Open( w_intelliapp_utility_help )
end event

type cb_3 from commandbutton within w_check_intelliapp_fields
integer x = 375
integer y = 12
integer width = 338
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Stop"
end type

event clicked;ii_stop = 1
end event

type cb_2 from commandbutton within w_check_intelliapp_fields
integer x = 727
integer y = 12
integer width = 338
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;dw_1.Print()
end event

type cb_1 from commandbutton within w_check_intelliapp_fields
integer x = 27
integer y = 12
integer width = 338
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Check Fields"
end type

event clicked;Long i
Long li_rc
Long ll_data
Long li_err_cnt
Integer li_cnt
Integer li_table_id
String ls_link_type
String ls_query_field
//String ls_field_type
Setpointer(Hourglass!) //Added base on customer's suggestion
dw_1.SetTransObject( SQLCA )
dw_1.Retrieve( )

//----------------------2.25.2016 RP added to implement just-in-time cache--------------------
gnv_data.of_retrieveIfNecessary("code_lookup", FALSE)
gnv_data.of_retrieveIfNecessary("sys_fields", FALSE)
//------------------------------------------------------------------------------------------------------

dw_2.reset()  //Start Code Change ----01.07.2008 #V8 maha

IF NOT ib_fix_all THEN
	dw_1.SetFilter( "app_id = " + is_app_id )
	dw_1.Filter( )
END IF

li_rc = dw_1.RowCount()

//--------------------------- APPEON BEGIN ---------------------------
//$<ID> PT-01
//$<add> 03.29.2006 By: LeiWei
//$<reason> Performance tuning
//$<modification> Use datastore to cache data instead of using SQLs in the loop in PT-02 to
//$<modification> reduce client-server interactions.
IF li_rc > 0 THEN
	Long ll_data_arr[],ll_data_arr_i
	Long j
	Boolean lb_add_array=FALSE
	FOR i = 1 TO li_rc
		//IF dw_1.GetItemString( i, "query_value" ) = 'NULL' OR  dw_1.GetItemString( i, "query_value" ) = 'NOT NULL' OR dw_1.GetItemString( i, "query_value" ) = '0' THEN
		IF dw_1.GetItemString( i, "query_value" ) = 'NULL' OR  dw_1.GetItemString( i, "query_value" ) = 'NOT NULL' OR dw_1.GetItemString( i, "query_value" ) = '0' OR ISNULL(dw_1.GetItemString( i, "query_value" )) THEN////Added by  Nova 10.27.2009
			CONTINUE
		END IF

		ll_data = Long( dw_1.GetItemString( i, "query_value" ) )
		//--------Begin Added by Nova 10.27.2009------------------------
//		ll_data_arr_i ++
//		ll_data_arr[ll_data_arr_i] = ll_data
      FOR j = 1 To ll_data_arr_i
			IF ll_data = ll_data_arr[j] THEN
				lb_add_array = True
				EXIT
			ELSE
				IF j = ll_data_arr_i THEN
					lb_add_array = False
				END IF
			END IF
		NEXT
		IF lb_add_array = False THEN
			ll_data_arr_i ++
			ll_data_arr[ll_data_arr_i] = ll_data
			lb_add_array = True
		END IF
		
//--------End Added --------------------------------------------
	END FOR
	
	Datastore lds_address_lookup
	lds_address_lookup = Create Datastore
	lds_address_lookup.Dataobject = "d_address_lookup_forpt"
	lds_address_lookup.Settransobject( SQLCA )
	lds_address_lookup.Retrieve( ll_data_arr[] )
END IF
//---------------------------- APPEON END ----------------------------

FOR i = 1 TO li_rc
	Yield( )
	IF ii_stop = 1 THEN
		EXIT
	END IF
	st_1.Text = "Checking field " + String( i ) + " of " + String( li_rc )
	ls_link_type = dw_1.GetItemString( i, "lookup_type" )

	IF dw_1.GetItemString( i, "query_value" ) = 'NULL' OR  dw_1.GetItemString( i, "query_value" ) = 'NOT NULL' OR dw_1.GetItemString( i, "query_value" ) = '0' THEN
		CONTINUE
	END IF
	ll_data = Long( dw_1.GetItemString( i, "query_value" ) )
	IF ll_data = 0 OR IsNull( ll_data ) THEN
		CONTINUE
	END IF
	//IF ls_link_type = "A" THEN

		//--------------------------- APPEON BEGIN ---------------------------
		//$<ID> PT-02
		//$<modify> 03.29.2006 By: LeiWei
		//$<reason> Performance tuning
		//$<modification> Write script to retrieve data from a cache in PT-01 instead of from the database.

		/*
		SELECT count( * )  
		INTO :li_cnt  
    	FROM address_lookup  
	   WHERE address_lookup.lookup_code = :ll_data   ;
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Error", sqlca.sqlerrtext )
			Return -1
		END IF
		IF li_cnt = 0 THEN
			SELECT count(*)  
			INTO :li_cnt  
    		FROM code_lookup  
		   WHERE code_lookup.lookup_code = :ll_data   ;		
			IF SQLCA.SQLCODE = -1 THEN
				MessageBox("Error", sqlca.sqlerrtext )
				Return -1
			END IF		
		END IF
		*/
		li_cnt = lds_address_lookup.Find("lookup_code = " + String(ll_data), 1, lds_address_lookup.Rowcount())
		IF Isnull(li_cnt) OR li_cnt <= 0 THEN
			li_cnt = gnv_data.ids_code_lookup.Find("lookup_code = " + String(ll_data), 1, gnv_data.ids_code_lookup.Rowcount())
		END IF
		IF Isnull(li_cnt) OR li_cnt <= 0 THEN li_cnt = 0
		//---------------------------- APPEON END ----------------------------

		IF li_cnt = 0 THEN
			li_err_cnt++
			dw_2.InsertRow( 1 )
			dw_2.SetItem( 1, "field_id" ,dw_1.GetItemNumber( i, "app_field_id" ) ) 
			dw_2.SetItem( 1, "facility_id" ,dw_1.GetItemNumber( i, "facility_id" ) ) 			
			dw_2.SetItem( 1, "app_id" , dw_1.GetItemNumber( i, "app_id" ) ) 
			dw_2.SetItem( 1, "type" ,ls_link_type )				
			dw_2.SetItem( 1, "page" , dw_1.GetItemNumber( i, "page" ) )	
			dw_2.SetItem( 1, "y_pos" , dw_1.GetItemNumber( i, "y_pos" ) )				
			dw_2.SetItem( 1, "lookup_code",  ll_data ) 		
			dw_2.SetItem( 1, "description",  "Invalid code/address lookup code" ) 						
		END IF		
		
END FOR


FOR i = 1 TO li_rc
	Yield( )
	IF ii_stop = 1 THEN
		EXIT
	END IF
	st_1.Text = "Checking field " + String( i ) + " of " + String( li_rc )
 
 	ls_query_field = dw_1.GetItemString( i, "query_field" )
	li_table_id = dw_1.GetItemNumber( i, "table_id" )
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 04.05.2006 By: Rodger Wu
	//$<reason> Fix a defect.
	/*	IF ls_query_field = "" OR IsNull( ls_query_field )  THEN */
	IF Trim( ls_query_field ) = "" OR IsNull( ls_query_field )  THEN
	//---------------------------- APPEON END ----------------------------
		CONTINUE
	END IF
 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<ID> PT-03
	//$<modify> 03.29.2006 By: LeiWei
	//$<reason> Performance tuning
	//$<modification> Write script to retrieve data from a cache instead of from the database.

	/*
   SELECT count(*)  
   INTO :li_cnt  
   FROM sys_fields  
   WHERE ( sys_fields.table_id = :li_table_id ) AND  
         ( sys_fields.field_name = :ls_query_field )   ;
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox("Error", sqlca.sqlerrtext )
		Return -1
	END IF
	*/
	If Isnull(ls_query_field) Then ls_query_field = ""
	li_cnt = gnv_data.ids_sys_fields.Find("table_id = " + String(li_table_id) +&
	" AND field_name = '" + ls_query_field + "'", 1, gnv_data.ids_sys_fields.Rowcount())
	IF Isnull(li_cnt) OR li_cnt <= 0 THEN li_cnt = 0
	//---------------------------- APPEON END ----------------------------
	
	IF li_cnt = 0 THEN
			li_err_cnt++
			dw_2.InsertRow( 1 )
			dw_2.SetItem( 1, "field_id" ,dw_1.GetItemNumber( i, "app_field_id" ) ) 
			dw_2.SetItem( 1, "facility_id" ,dw_1.GetItemNumber( i, "facility_id" ) ) 			
			dw_2.SetItem( 1, "app_id" , dw_1.GetItemNumber( i, "app_id" ) ) 
			dw_2.SetItem( 1, "type" ,ls_link_type )				
			dw_2.SetItem( 1, "page" , dw_1.GetItemNumber( i, "page" ) )	
			dw_2.SetItem( 1, "y_pos" , dw_1.GetItemNumber( i, "y_pos" ) )				
			dw_2.SetItem( 1, "lookup_code",  ll_data ) 				
			dw_2.SetItem( 1, "description",  "Invalid query field selection" ) 									
	END IF
END FOR

st_1.Text = String( li_err_cnt ) + " Errors found."
end event

type dw_2 from datawindow within w_check_intelliapp_fields
integer x = 32
integer y = 116
integer width = 1751
integer height = 464
integer taborder = 50
string dataobject = "d_intelliapp_error_log"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event buttonclicked;Integer li_row

w_train_app.of_goto_fix_page( row )

//Open( w_train_app )

//w_train_app.ii_app_id = This.GetItemNumber( row, "app_id" )
//w_train_app.ii_facility_id = This.GetItemNumber( row, "facility_id" )
//
//li_row = w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.Find( "facility_id = " + String( This.GetItemNumber( row, "facility_id" )), 1, 10000 )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SetRow( li_row )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.ScrollToRow( li_row )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SelectRow( 0, False )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.SelectRow( li_row , True )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_facility.dw_facility_browse.TriggerEvent( DoubleClicked! )
//
//li_row = w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.Find( "app_id = " + String( This.GetItemNumber( row, "app_id" )), 1, 10000 )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SetRow( li_row )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SelectRow( 0, False )
//w_train_app.tab_1.tabpage_select.tab_facility.tabpage_apps.dw_app_browse.SelectRow( li_row, True )
//li_row = w_train_app.of_select_app( )
//
//w_train_app.tab_1.tabpage_design.sle_goto_page.Text = String( This.GetItemNumber( row, "page" ) )
//w_train_app.tab_1.tabpage_design.cb_goto_page.TriggerEvent( Clicked! )
//
end event

event clicked;IF row > 0 THEN
	This.SetRow( row )
	This.SelectRow( 0, False )
	This.SelectRow( row, True )
END IF
	
end event

type dw_1 from datawindow within w_check_intelliapp_fields
boolean visible = false
integer x = 1243
integer y = 176
integer width = 494
integer height = 184
integer taborder = 60
string dataobject = "d_intelliapp_fields_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

