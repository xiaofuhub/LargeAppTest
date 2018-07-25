$PBExportHeader$w_app_audit.srw
forward
global type w_app_audit from window
end type
type cb_1 from commandbutton within w_app_audit
end type
type dw_1 from datawindow within w_app_audit
end type
end forward

global type w_app_audit from window
integer x = 823
integer y = 360
integer width = 1179
integer height = 1108
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_1 cb_1
dw_1 dw_1
end type
global w_app_audit w_app_audit

on w_app_audit.create
this.cb_1=create cb_1
this.dw_1=create dw_1
this.Control[]={this.cb_1,&
this.dw_1}
end on

on w_app_audit.destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

type cb_1 from commandbutton within w_app_audit
integer x = 366
integer y = 772
integer width = 247
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

event clicked; 
dw_1.SetTransObject( SQLCA )
dw_1.Retrieve()

n_ds ldw_app_audit_facility
n_ds lds_last_app_audit_seq_no
n_ds ldw_rqrd_data
n_ds ldw_audit
Integer li_row_cnt
Integer i
Integer p
Long ll_seq_no
Long ll_seq_row_cnt
Long ll_record_id
Long ll_app_audit_id
Long ll_prac_id
Integer li_facility_row_cnt
Long ll_appt_stat_id
String ls_version



ldw_audit = CREATE n_ds
ldw_audit.DataObject = "d_pd_app_audit_rqrd_data"
ldw_audit.SetTransObject( SQLCA )

ldw_rqrd_data = CREATE n_ds
ldw_rqrd_data.DataObject = "d_app_audit_rqrd_data"
ldw_rqrd_data.SetTransObject( SQLCA )

lds_last_app_audit_seq_no = CREATE n_ds
lds_last_app_audit_seq_no.DataObject = "d_last_app_audit_seq_no"
lds_last_app_audit_seq_no.SetTransObject( SQLCA )


li_row_cnt = ldw_rqrd_data.Retrieve( 1, 'I')


FOR p = 1 TO dw_1.RowCount()

	ll_prac_id = dw_1.GetItemNumber( p, "prac_id" )
	ll_appt_stat_id = dw_1.GetItemNumber( p, "rec_id" )

	ldw_audit.SetTransObject( SQLCA )
	ldw_audit.Reset( )
	


	FOR i = 1 TO li_row_cnt
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10.17.2006 By: Jack (Inova)
		//$<reason> Required Documents Check Box on Data Entry Screen.
		/*
		ldw_audit.InsertRow( 0 )
		*/
		integer li_auto_generate,li_row
		li_auto_generate = ldw_rqrd_data.getitemnumber(i,'auto_generate')
		if li_auto_generate = 1 then
			continue
		end if
		li_row = ldw_audit.InsertRow( 0 )		
	   //---------------------------- APPEON END ----------------------------
		ll_record_id = gnv_app.of_get_id("RECORD_ID")
		ll_app_audit_id = ldw_rqrd_data.GetItemNumber( i, "app_audit_id" )
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10.18.2006 By: Jack (Inova)
		//$<reason> Required Documents Check Box on Data Entry Screen.
		/*
		ldw_audit.SetItem( i, "rec_id", ll_record_id )
		ldw_audit.SetItem( i, "appt_stat_id", ll_appt_stat_id )
		ldw_audit.SetItem( i, "prac_id", ll_prac_id )
		ldw_audit.SetItem( i, "facility_id", 1)
		ldw_audit.SetItem( i, "app_audit_id", ll_app_audit_id )
		*/
		ldw_audit.SetItem( li_row, "rec_id", ll_record_id )
		ldw_audit.SetItem( li_row, "appt_stat_id", ll_appt_stat_id )
		ldw_audit.SetItem( li_row, "prac_id", ll_prac_id )
		ldw_audit.SetItem( li_row, "facility_id", 1)
		ldw_audit.SetItem( li_row, "app_audit_id", ll_app_audit_id )		
		//---------------------------- APPEON END ----------------------------

		//find out the last seq no used
		ll_seq_row_cnt = lds_last_app_audit_seq_no.Retrieve( ll_app_audit_id, ll_prac_id, 1 )	
		IF ll_seq_row_cnt < 1 THEN
			ll_seq_no = 1 
		ELSE
			ll_seq_no = lds_last_app_audit_seq_no.GetItemNumber( 1, "last_seq_no" ) + 1
		END IF	
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 10.17.2006 By: Jack (Inova)
		//$<reason> Required Documents Check Box on Data Entry Screen.
		/*
		ldw_audit.SetItem( i, "seq_no", ll_seq_no	) 		
		ldw_audit.SetItem( i, "active_status", 1 )
		ldw_audit.SetItem( i, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
		ldw_audit.SetItem( i, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 	
		
		IF NOT IsNull( dw_1.GetItemDateTime( i, "apptmnt_start_date" ) ) THEN
			ldw_audit.SetItem( i, "data_status", 662 )
			ldw_audit.SetItem( i, "date_completed", Today() )
		END IF
		*/
		ldw_audit.SetItem( li_row, "seq_no", ll_seq_no	) 		
		ldw_audit.SetItem( li_row, "active_status", 1 )
		ldw_audit.SetItem( li_row, "pd_app_audit_fax_message", ldw_rqrd_data.GetItemString( i, "fax_description" )	) 	
		ldw_audit.SetItem( li_row, "description", ldw_rqrd_data.GetItemString( i, "description" )	) 		
		
		ldw_audit.SetItem( li_row, "app_type", ldw_rqrd_data.GetItemString( i, "app_type" )	)		
		
		IF NOT IsNull( dw_1.GetItemDateTime( p, "apptmnt_start_date" ) ) THEN
			ldw_audit.SetItem( li_row, "data_status", 662 )
			ldw_audit.SetItem( li_row, "date_completed", Today() )
		END IF
		//---------------------------- APPEON END ----------------------------
		
	END FOR

	IF ldw_audit.Update() = -1 THEN
		messagebox("", sqlca.sqlerrtext)
		MessageBox( "Update Error" , "Error updating application audit data.")
		Return -1
	END IF

	This.Text = String( P )
	
	COMMIT USING SQLCA;	
END FOR

DESTROY ldw_audit
DESTROY ldw_rqrd_data
DESTROY ldw_app_audit_facility
DESTROY lds_last_app_audit_seq_no



RETURN 0

end event

type dw_1 from datawindow within w_app_audit
integer x = 146
integer y = 60
integer width = 827
integer height = 608
integer taborder = 10
string dataobject = "d_all"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

