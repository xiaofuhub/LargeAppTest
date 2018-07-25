$PBExportHeader$w_verification_batchcopy.srw
forward
global type w_verification_batchcopy from w_response
end type
type cbx_match from checkbox within w_verification_batchcopy
end type
type cb_select from commandbutton within w_verification_batchcopy
end type
type cbx_option from checkbox within w_verification_batchcopy
end type
type cb_print from commandbutton within w_verification_batchcopy
end type
type mle_info from multilineedit within w_verification_batchcopy
end type
type cb_exit from commandbutton within w_verification_batchcopy
end type
type cb_ok from commandbutton within w_verification_batchcopy
end type
type dw_facility_to from u_dw within w_verification_batchcopy
end type
type st_3 from statictext within w_verification_batchcopy
end type
type st_1 from statictext within w_verification_batchcopy
end type
type p_1 from picture within w_verification_batchcopy
end type
type dw_facility_from from u_dw within w_verification_batchcopy
end type
type dw_verif from u_dw within w_verification_batchcopy
end type
type st_2 from statictext within w_verification_batchcopy
end type
end forward

global type w_verification_batchcopy from w_response
string tag = "                     "
integer width = 3301
integer height = 2288
string title = "Copy Verifications"
long backcolor = 33551856
cbx_match cbx_match
cb_select cb_select
cbx_option cbx_option
cb_print cb_print
mle_info mle_info
cb_exit cb_exit
cb_ok cb_ok
dw_facility_to dw_facility_to
st_3 st_3
st_1 st_1
p_1 p_1
dw_facility_from dw_facility_from
dw_verif dw_verif
st_2 st_2
end type
global w_verification_batchcopy w_verification_batchcopy

type variables
Long il_prac_id, il_current_fac
Boolean ib_modified = False
boolean ib_fac_change //Start Code Change ---- 11.27.2006 #V7 maha
end variables

forward prototypes
public function integer of_start_copy ()
public function integer of_reset_to ()
end prototypes

public function integer of_start_copy ();Integer i, li_cnt_skip, li_cnt_ok, li_cnt_fac_skip,  li_last_row, li_ans, li_rowcount, j
Integer nullint, li_facility_id, li_ver_facility_2, t = 0, trows, li_printflag = 1, li_found, li_inserted
Long ll_prac_id, ll_recid,ll_test1, ll_test2, ll_ver_fac
long ll_parent
Long ll_row_cnt, ll_seq_no
Date nulldate
Boolean lb_copy_completiondata
String ls_doc_id, nullstring
datastore lds_ver_sno

mle_info.Text = ""
ll_row_cnt = dw_verif.RowCount()
IF ll_row_cnt < 1 THEN Return 0;

trows = ll_row_cnt

FOR i = 1 TO ll_row_cnt 
	IF dw_verif.GetItemNumber( i, "selected" ) = 1 THEN t++
next

if t = 0 then
	messagebox("Copy Error","There are no verification records selected for copying")
	return 0
end if

FOR i = 1 TO ll_row_cnt //test for duplicate verifications  
	IF dw_verif.GetItemNumber( i, "selected" ) = 1 THEN
		ll_test1 = dw_verif.GetItemNumber( i, "rec_id" )
		for t = 1 to trows
			IF dw_verif.GetItemNumber( t, "selected" ) = 1 THEN
				ll_test2 = dw_verif.GetItemNumber( t, "rec_id" )

				if  i <> t and ll_test1 = ll_test2 then
					messagebox("Copy Error","There are duplicate records selected for copying.~n~rPlease deselect duplicates")
					Return 0;
				end if
			end if
		next
	end if
next

FOR i = 1 TO ll_row_cnt  //should not be any as the query filters for these
	IF dw_verif.GetItemNumber( i, "selected" ) = 1 THEN
		IF dw_verif.GetItemNumber( i, "exp_credential_flag" ) = 1 THEN			
			MessageBox("Selection Error", "You can only select credential verification entries. You have selected an expiring credential entry." )			
			Return 0;		
		END IF
	END IF
END FOR

IF cbx_option.Checked Then
	lb_copy_completiondata = True
	li_printflag = 0
END IF

ll_prac_id = dw_verif.GetItemNumber( 1, "prac_id" )

li_found = dw_facility_from.Find( "selected = 1", 1, dw_facility_from.Rowcount() )
IF li_found < 1 THEN RETURN 0;
li_ver_facility_2 = dw_facility_from.GetItemNumber( li_found, "verifying_facility" )

li_rowcount = dw_facility_to.Rowcount()


For i = 1 to li_rowcount
	IF dw_facility_to.GetItemNumber( i, "selected" ) = 1 THEN
		//Start Code Change ---- 11.27.2006 #V7 maha
		IF cbx_match.Checked Then //reset the verif facility to match the parent
			ll_parent = dw_facility_to.GetItemNumber( i, "parent_facility_id" )
			dw_facility_to.setItem( i, "verifying_facility", ll_parent)
			ll_ver_fac = ll_parent
		else
			ll_ver_fac = dw_facility_to.GetItemNumber( i, "verifying_facility" )
		end if
		//End Code Change---11.27.2006
		IF isnull( ll_ver_fac ) THEN
			MessageBox("Invalid Facility", "The selected Parent Facility " + dw_facility_to.GetItemString( i, &
						  "facility_facility_name" ) + " was not setup in the Appointment Status screen.")
			RETURN 0
		END IF
		j++;
	END IF
Next


IF j < 1 THEN
	messagebox("Copy Error","There are no facility records selected for copying verification to.")
	of_reset_to( )
	Return 0;
END IF

li_ans = MessageBox("Copy Verifications", "Are you sure you want to copy the selected verifications.", Question!, YesNo!, 1 )
IF li_ans = 2 THEN
	of_reset_to( )
	Return 0
END IF

SetNull( nulldate )
SetNull( nullint )
SetNull( nullstring )

lds_ver_sno = CREATE DataStore
lds_ver_sno.DataObject = "ds_verification_seqno"
lds_ver_sno.SetTransObject( SQLCA )
lds_ver_sno.Retrieve( il_prac_id )


//@@@@@@@@@ Verification Creation  @@@@@@@@@@

mle_info.ReplaceText( "Start copying verification...~r~n~r~n" )
FOR j = 1 TO li_rowcount //for each facility
	IF dw_facility_to.GetItemNumber( j, "selected" ) <> 1 THEN Continue;
	
	ll_ver_fac = dw_facility_to.GetItemNumber( j, "verifying_facility" )
	
	//test for copying to same facility
	IF ll_ver_fac = li_ver_facility_2 THEN
		mle_info.ReplaceText( "Destination Facility " + dw_facility_to.GetItemString( j, "facility_facility_name" ) + &
									 " is using the same Verifying Facility as the Source Facility, " + &
									 "you should use the Reverify option instead of the Copy Verification Process.~r~n" )
		li_cnt_fac_skip++;
		Continue;
	END IF
	
	
	FOR i = 1 TO ll_row_cnt
		IF dw_verif.GetItemNumber( i, "selected" ) = 1 THEN
			
			ll_prac_id = dw_verif.GetItemNumber( i, "prac_id" )
			ll_recid = dw_verif.GetItemNumber( i, "rec_id" )
			
			//check if active verification exists
			//Start Code Change ----07.19.2012 #V12 maha - added active status to filter
			li_found = lds_ver_sno.Find( "rec_id = " + string( ll_recid ) + " AND facility_id = " + string( ll_ver_fac ) + &
												  " AND print_flag = " + string(li_printflag) + " and active_status = 1", 1, lds_ver_sno.Rowcount() )
			IF li_found > 0 THEN
				mle_info.ReplaceText( "Row " + string( i ) + ": " + dw_verif.GetItemString( i, "reference_value" ) + &
											 " exists in Destination Facility " + dw_facility_to.GetItemString( j, "facility_facility_name" ) + &
											 ", skipping copy of this verification.~r~n" )
				li_cnt_skip++
				Continue;
			END IF
			
			dw_verif.RowsCopy( i, i, Primary!, dw_verif, 100000, Primary!)	
			li_last_row = dw_verif.RowCount()
			
			//Start Code Change ----07.19.2012 #V12 maha -
			li_found = lds_ver_sno.Find( "rec_id = " + string( ll_recid ) + " AND facility_id = " + string( ll_ver_fac ), 1, lds_ver_sno.Rowcount() )
			
			//if not found add a record to the ds for later rows in the function
			IF li_found < 1 THEN
				ll_seq_no = 1
				li_inserted = lds_ver_sno.InsertRow( 0 )
				lds_ver_sno.SetItem( li_inserted, "rec_id", ll_recid )
				lds_ver_sno.SetItem( li_inserted, "facility_id", ll_ver_fac )
				lds_ver_sno.SetItem( li_inserted, "seq_no", 1 )
				lds_ver_sno.SetItem( li_inserted, "print_flag", li_printflag )
				lds_ver_sno.SetItem( li_inserted, "active_status", 1 )  //Start Code Change ----07.19.2012 #V12 maha - set value
			ELSE //id found set the seq # higher 
				ll_seq_no = lds_ver_sno.GetItemNumber( li_found, "seq_no" )
				if isnull(ll_seq_no) then ll_seq_no = 0
				ll_seq_no ++
				lds_ver_sno.SetItem( li_found, "seq_no", ll_seq_no )
			END IF
			
			
			dw_verif.SetItem( li_last_row, "facility_id", ll_ver_fac )
			dw_verif.SetItem( li_last_row, "active_status", 1 )
			dw_verif.SetItem( li_last_row, "seq_no", ll_seq_no )
			//set new records data
			if Not lb_copy_completiondata then //no   maha 070902 keep org data if requested
				dw_verif.SetItem( li_last_row, "first_sent", nulldate )
				dw_verif.SetItem( li_last_row, "last_sent", nulldate )
				dw_verif.SetItem( li_last_row, "number_sent", 0 )
				dw_verif.SetItem( li_last_row, "date_recieved", nulldate )
				dw_verif.SetItem( li_last_row, "user_name", nullString )		
				dw_verif.SetItem( li_last_row, "response_code", nullint )
				dw_verif.SetItem( li_last_row, "print_flag", 1 )//modified maha 031004
			else //yes to copy
				dw_verif.SetItem( li_last_row, "print_flag", 0 )//modified maha 031004
			end if
			//assign a doc_id
			ls_doc_id = String( ll_recid) + "-" + string(ll_prac_id) + "-" + string(ll_ver_fac) + "-" + string(ll_seq_no) 
			dw_verif.SetItem( li_last_row, "doc_id", ls_doc_id )
			//Start Code Change ----08.03.2011 #V11 maha - set created values
			dw_verif.SetItem(li_last_row, 'verif_info_create_date', datetime(today(),now()))//Modify Michael 12.19.2011 add 'verif_info_'
			dw_verif.SetItem(li_last_row, 'verif_info_create_user', gs_user_id + "-C")//Modify Michael 12.19.2011 add 'verif_info_'			//maha 03.20.2013 added -C
			//End Code Change ----08.03.2011
			
			li_cnt_ok++;
		END IF
	NEXT
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<Modify> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
//DESTROY( lds_ver_sno );
if IsValid(lds_ver_sno) then Destroy lds_ver_sno
//---------------------------- APPEON END ----------------------------

IF li_cnt_ok > 0 THEN
	IF dw_verif.Update() = -1 THEN
		Rollback Using SQLCA;
		mle_info.ReplaceText( "Update to verif_info table failed!~r~n" )
		MessageBox("Update Failed", "Update to verif_info table failed!" )
		RETURN -1
	END IF
	dw_facility_to.update() //Start Code Change ---- 11.27.2006 #V7 maha
	COMMIT USING SQLCA;
	ib_modified = True
END IF

IF li_cnt_fac_skip > 1 THEN
	mle_info.ReplaceText( "~r~nCopying verification completed. ~r~nThere are total:~r~n" + string( li_cnt_ok ) + &
								 " record(s) copied~r~n" + string( li_cnt_skip ) + " record(s) skipped copying~r~n" + &
								 string( li_cnt_fac_skip ) + " facilities verifications were not copied to." )
ELSE
	mle_info.ReplaceText( "~r~nCopying verification completed. ~r~nThere are total:~r~n" + string( li_cnt_ok ) + &
								 " record(s) copied~r~n" + string( li_cnt_skip ) + " record(s) skipped copying~r~n" + &
								 string( li_cnt_fac_skip ) + " facilities verifications were not copied to." )
END IF

RETURN 1
end function

public function integer of_reset_to ();//Start Code Change ---- 11.27.2006 #V7 maha
//used to reset the verif facility which may have been changed

if not ib_fac_change then return 1

gnv_appeondb.of_startqueue()
dw_facility_to.Retrieve( il_prac_id, gs_user_id )
gnv_appeondb.of_commitqueue()

return 1
end function

on w_verification_batchcopy.create
int iCurrent
call super::create
this.cbx_match=create cbx_match
this.cb_select=create cb_select
this.cbx_option=create cbx_option
this.cb_print=create cb_print
this.mle_info=create mle_info
this.cb_exit=create cb_exit
this.cb_ok=create cb_ok
this.dw_facility_to=create dw_facility_to
this.st_3=create st_3
this.st_1=create st_1
this.p_1=create p_1
this.dw_facility_from=create dw_facility_from
this.dw_verif=create dw_verif
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_match
this.Control[iCurrent+2]=this.cb_select
this.Control[iCurrent+3]=this.cbx_option
this.Control[iCurrent+4]=this.cb_print
this.Control[iCurrent+5]=this.mle_info
this.Control[iCurrent+6]=this.cb_exit
this.Control[iCurrent+7]=this.cb_ok
this.Control[iCurrent+8]=this.dw_facility_to
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.p_1
this.Control[iCurrent+12]=this.dw_facility_from
this.Control[iCurrent+13]=this.dw_verif
this.Control[iCurrent+14]=this.st_2
end on

on w_verification_batchcopy.destroy
call super::destroy
destroy(this.cbx_match)
destroy(this.cb_select)
destroy(this.cbx_option)
destroy(this.cb_print)
destroy(this.mle_info)
destroy(this.cb_exit)
destroy(this.cb_ok)
destroy(this.dw_facility_to)
destroy(this.st_3)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.dw_facility_from)
destroy(this.dw_verif)
destroy(this.st_2)
end on

event open;call super::open;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-08 By: Rodger Wu (Inova)
//$<reason> New window designed for batch copy verifications. C10
//$<reason> 4 New datawindows: 
/*                           d_verif_copy_select_verifs, 
									  d_verif_copy_select_fac,
									  ds_verification_seqno,
									  d_verif_copy_printlog
*/
//---------------------------- APPEON END ----------------------------

String ls_parm
Integer li_pos, li_rowcount, li_found

ib_disableclosequery = True

ls_parm = Message.StringParm
li_pos = PosA( ls_parm, "~t" )
il_prac_id = Long( LeftA( ls_parm, li_pos - 1 ) )
il_current_fac = Long( RightA( ls_parm, LenA( ls_parm ) - li_pos ) )

//Start Code Change ---- 11.27.2006 #V7 maha get inova setting to match verif to parent
if of_get_app_setting("set_46", "I") = 1 then
	ib_fac_change = true
	cbx_match.checked = true
	cbx_match.visible = false
end if
//End Code Change---11.27.2006
dw_facility_from.SetTransObject( SQLCA )
dw_facility_to.SetTransObject( SQLCA )
dw_verif.SetTransObject( SQLCA )

gnv_appeondb.of_startqueue()
dw_facility_from.Retrieve( il_prac_id, gs_user_id )
dw_facility_to.Retrieve( il_prac_id, gs_user_id )
gnv_appeondb.of_commitqueue()

li_rowcount = dw_facility_from.Rowcount()
li_found = dw_facility_from.Find( "parent_facility_id = " + string( il_current_fac ), 1, li_rowcount )
IF li_found > 0 THEN
	dw_facility_from.SetItem( li_found, "selected", 1 )
	dw_facility_from.Post Event ItemChanged( li_found, dw_facility_from.object.selected, '1' )
END IF

end event

event closequery;call super::closequery;IF ib_modified THEN Message.StringParm = "modified"
end event

type cbx_match from checkbox within w_verification_batchcopy
integer x = 32
integer y = 24
integer width = 1015
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Set Verifying Facility to match Parent"
end type

event clicked;if this.checked then
	ib_fac_change = true
else
	ib_fac_change = false
end if
end event

type cb_select from commandbutton within w_verification_batchcopy
integer x = 987
integer y = 1548
integer width = 343
integer height = 64
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Select All"
end type

event clicked;Integer i

If this.text = "Select All" THEN
	this.text = "Deselect All"
	For i = 1 to dw_verif.Rowcount()
		//IF dw_verif.GetItemNumber( i, "selected" ) = 0 THEN  //Start Code Change ----07.07.2009 #V92 maha - removed if
		dw_verif.SetItem( i, "selected", 1 )
	Next
ELSE
	this.text = "Select All"
	For i = 1 to dw_verif.Rowcount()
		//IF dw_verif.GetItemNumber( i, "selected" ) = 1 THEN    //Start Code Change ----07.07.2009 #V92 maha - removed if 
		dw_verif.SetItem( i, "selected", 0 )
	Next
END IF
end event

type cbx_option from checkbox within w_verification_batchcopy
integer x = 1239
integer y = 24
integer width = 914
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Copy with completed information"
end type

type cb_print from commandbutton within w_verification_batchcopy
integer x = 2510
integer y = 12
integer width = 343
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Print log"
end type

event clicked;IF mle_info.Text = '' THEN
	MessageBox( "Print Error", "No log information needs to print." )
	Return 0;
END IF

datastore lds_printlog

lds_printlog = CREATE datastore
lds_printlog.Dataobject = "d_verif_copy_printlog"
lds_printlog.SetItem( 1, "loginformation", mle_info.Text )
lds_printlog.Print( False )

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.23.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_printlog) then Destroy lds_printlog
//---------------------------- APPEON END ----------------------------

DESTROY( lds_printlog )
end event

type mle_info from multilineedit within w_verification_batchcopy
integer x = 987
integer y = 1620
integer width = 2258
integer height = 536
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 16777215
string text = "                                                                    Copy Log"
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type cb_exit from commandbutton within w_verification_batchcopy
integer x = 2903
integer y = 12
integer width = 343
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type cb_ok from commandbutton within w_verification_batchcopy
integer x = 2162
integer y = 12
integer width = 343
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Copy"
end type

event clicked;of_start_copy()
end event

type dw_facility_to from u_dw within w_verification_batchcopy
integer y = 1252
integer width = 942
integer height = 904
integer taborder = 30
string dataobject = "d_verif_copy_select_fac"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_verification_batchcopy
integer x = 37
integer y = 1196
integer width = 759
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Facility to copy TO"
boolean focusrectangle = false
end type

type st_1 from statictext within w_verification_batchcopy
integer x = 32
integer y = 132
integer width = 1527
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Select Facility and verifications FROM which you want to copy."
boolean focusrectangle = false
end type

type p_1 from picture within w_verification_batchcopy
integer x = 27
integer y = 1068
integer width = 73
integer height = 64
boolean originalsize = true
string picturename = "Copy!"
boolean focusrectangle = false
end type

type dw_facility_from from u_dw within w_verification_batchcopy
integer x = 5
integer y = 196
integer width = 942
integer height = 956
integer taborder = 10
string dataobject = "d_verif_copy_select_fac"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event itemchanged;call super::itemchanged;Integer li_rows_fac_from, i
Long ll_fac[], ll_parent_fac

IF row < 1 THEN return;
IF dwo.Name <> "selected" THEN return;

IF data = '1' THEN
	
	li_rows_fac_from = This.Rowcount()
	For i = 1 to li_rows_fac_from
		IF i = row THEN continue;
		IF This.GetItemNumber( i, "selected" ) = 1 THEN
			This.SetItem( i, "selected", 0 )
		END IF
	Next
	
	ll_fac[1] = This.GetItemNumber( row, "verifying_facility" )
	ll_parent_fac = This.GetItemNumber( row, "parent_facility_id" )
	
	//dw_facility_to.SetFilter( "parent_facility_id <> " + string( ll_fac[1] ) + " AND verifying_facility <> " + string( ll_ver_fac ) )
	dw_facility_to.SetFilter( "parent_facility_id <> " + string( ll_parent_fac ) )
	dw_facility_to.Filter()
	
	if dw_facility_to.rowcount( ) = 1 then//Start Code Change ---- 10.24.2006 #1 maha
		dw_facility_to.setitem(1,"selected",1)
	end if
	dw_verif.Retrieve( 1, il_prac_id, ll_fac )
ELSE
	dw_verif.Reset()
END IF

IF cb_select.text = "&Deselect All Verifications" THEN
	cb_select.text = "Select &All Verifications"
END IF
end event

type dw_verif from u_dw within w_verification_batchcopy
integer x = 987
integer y = 196
integer width = 2272
integer height = 1344
integer taborder = 20
string dataobject = "d_verif_copy_select_verifs"
boolean hscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;IF This.GetClickedRow() > 0 THEN
	This.ScrollToRow( This.GetClickedRow() )
	This.SetRow( This.GetClickedRow() )
END IF
end event

event constructor;ib_rmbmenu	= False

of_setsort(true)
inv_sort.of_setcolumnheader(true)
end event

type st_2 from statictext within w_verification_batchcopy
boolean visible = false
integer x = 5
integer y = 120
integer width = 3246
integer height = 108
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
boolean focusrectangle = false
end type

