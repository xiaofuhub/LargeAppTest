$PBExportHeader$w_verif_scan_log_incompl.srw
forward
global type w_verif_scan_log_incompl from w_main
end type
type cb_2 from commandbutton within w_verif_scan_log_incompl
end type
type st_1 from statictext within w_verif_scan_log_incompl
end type
type dw_log from u_dw within w_verif_scan_log_incompl
end type
type cb_delete from commandbutton within w_verif_scan_log_incompl
end type
type cb_save from commandbutton within w_verif_scan_log_incompl
end type
type ole_browser from olecustomcontrol within w_verif_scan_log_incompl
end type
type ole_image from olecustomcontrol within w_verif_scan_log_incompl
end type
type dw_user from datawindow within w_verif_scan_log_incompl
end type
type st_batch from statictext within w_verif_scan_log_incompl
end type
type dw_batch from u_dw within w_verif_scan_log_incompl
end type
type st_user from statictext within w_verif_scan_log_incompl
end type
type rb_c from radiobutton within w_verif_scan_log_incompl
end type
type rb_i from radiobutton within w_verif_scan_log_incompl
end type
type rb_b from radiobutton within w_verif_scan_log_incompl
end type
type cb_1 from commandbutton within w_verif_scan_log_incompl
end type
type dw_date_range from u_dw within w_verif_scan_log_incompl
end type
type gb_1 from groupbox within w_verif_scan_log_incompl
end type
end forward

global type w_verif_scan_log_incompl from w_main
integer width = 4553
integer height = 2968
long backcolor = 33551856
cb_2 cb_2
st_1 st_1
dw_log dw_log
cb_delete cb_delete
cb_save cb_save
ole_browser ole_browser
ole_image ole_image
dw_user dw_user
st_batch st_batch
dw_batch dw_batch
st_user st_user
rb_c rb_c
rb_i rb_i
rb_b rb_b
cb_1 cb_1
dw_date_range dw_date_range
gb_1 gb_1
end type
global w_verif_scan_log_incompl w_verif_scan_log_incompl

type variables
string is_user = ""
string is_stat = "I"
string is_message = ""
long il_batch = 0
long il_entity = 0
long il_prac = 0
long il_recid = 0
datetime idt_from = datetime( date("2000-01-01"), time( "00:00:00"))
datetime idt_to = datetime(today(), time("23:59:59") )
end variables

forward prototypes
public function integer of_retrieve_logs ()
public function integer of_check_type (long al_row)
public function integer of_get_log_image (long al_log, string as_file)
public function integer of_retrieve_pict (long al_log)
public subroutine of_set_calendar ()
end prototypes

public function integer of_retrieve_logs (); //Start Code Change ----10.28.2015 #V15 maha
integer r
string ls_sql
string ls_sql_org
string ls_where = " AND "
datawindowchild dwchild

//date
ls_where+= " ( verif_batch_log.verif_date >= '" + string( idt_from, 'yyyy-mm-dd hh:mm:ss') + "') AND "
ls_where+= " ( verif_batch_log.verif_date <= '" + string( idt_to, 'yyyy-mm-dd hh:mm:ss') + "') AND "


//batch
if il_batch > 0 then
	ls_where+= " ( verif_batch_log.batch_id = " + string(il_batch) +  ") AND "
end if

//user
if is_user <> "ALL" then
	ls_where+= "( upper(verif_batch_log.user_id) = '" + upper(is_user) +  "')  AND "
end if

//status
choose case is_stat
	case "I"
		ls_where+=   " ( verif_batch_log.status_change is null) AND "
	case "C"
		ls_where+= " ( verif_batch_log.status_change is not null) AND "
	case "B"
		//no filter
end choose

//provider
if il_prac > 0 then
	ls_where+= " ( verif_batch_log.prac_id = " + string(il_prac) +  ") AND "
end if

//record
if il_recid > 0 then
	ls_where+= " ( verif_batch_log.rec_id = " + string(il_recid) +  ") AND "
end if

ls_where = mid(ls_where, 1, len(ls_where) - 4)

if is_message = "Y" then
	messagebox("ls_where", ls_where)
end if

ls_sql = dw_log.GetSQLSelect()
ls_sql_org = ls_sql

ls_sql = ls_sql + " " + ls_where
//messagebox("",ls_sql)
r = dw_log.SetSQLSelect(ls_sql)

if r < 1 then
	messagebox("Log Retrieval Failed", ls_sql)
end if

dw_log.settransobject(sqlca)
dw_log.retrieve()

dw_log.SetSQLSelect(ls_sql_org)

dw_log.Modify("DataWindow.table.UpdateTable='verif_batch_log'")
dw_log.Modify("DataWindow.table.Updatewhere='0'")

dw_log.getchild("status_change", dwchild)
dwchild.settransobject(sqlca)
dwchild.retrieve()
 
 return 1
end function

public function integer of_check_type (long al_row);string ls_type
integer res = 0


ls_type = dw_log.getitemstring(al_row,"image_yn")
choose case ls_type
	case '1'
		if dw_log.getitemstring(al_row,"img_type") <> 'bmp' then
			res = 1
		end if
	case '2'
		if dw_log.getitemstring(al_row,"img_type") <> 'htm' then
			res = 1
		end if
	case else
		res = 1
end choose

if res = 1 then
	messagebox("Data error","The image type for the log image does not match the type in the setup.  The program may not be able to display the image.")
	return 0
end if

return 1
end function

public function integer of_get_log_image (long al_log, string as_file); //Start Code Change ----07.24.2015 #V15 maha
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_verif_picture
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob


IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	//------------------- APPEON BEGIN -------------------
	//<$>added:long.zhang 12.14.2015
	//<$>reason:Wrong argument type, BugL120805
	//of_get_image_verif_batch("*" + string (al_log), lb_verif_picture)
	of_get_image_verif_batch(al_log, lb_verif_picture)
	//------------------- APPEON END -------------------
	
ELSE
	SELECTBLOB image_data
	INTO :lb_verif_picture
	FROM verif_batch_log_image
	WHERE log_id = :al_log
	USING SQLCA;
END IF



//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

//tab_1.tabpage_preview.p_1.SetPicture( lb_verif_picture )

ll_filelen = LenA( lb_verif_picture )



IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FileDelete( as_file )

li_filenum =  FileOpen( as_file , StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_verif_picture, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
//		 tab_1.tabpage_verif.st_1.text = "Writing File"
		 IF ll_bytes_written = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_verif_picture = total_blob
	
	FileClose( li_filenum )
//   tab_1.tabpage_verif.st_1.text = "File Closed"
ELSE
	MessageBox( "File Open Error", "Could not open the image file:" + as_file + "" )
	Return -	1
END IF


//DO While Not FileExists( as_file )
//	Yield( )
////	 tab_1.tabpage_verif.st_1.text = "Waiting for Image Retrieval"
//	IF ib_cancel THEN
//		//cb_cancel.Enabled = False
//		Return -1
//	END IF
//LOOP

// tab_1.tabpage_verif.st_1.text = "Image Retrieved" 

//cb_cancel.Enabled = True

Return 1

end function

public function integer of_retrieve_pict (long al_log);SetPointer( HourGlass! )
//cb_capture.Enabled = False
String ls_name
string ls_file
string ls_type
integer li_res
string ls_null
string ls_reference
setnull(ls_null)

debugbreak()
select image_type into :ls_type from verif_batch_log_image where log_id = :al_log;

choose case upper(ls_type) //get file name
	case "BMP"
		ls_file = gs_temp_path + "_ResultPage.bmp"
	case "HTM"
		ls_file = gs_temp_path + "_ResultPage.htm"
end choose
	
li_res = of_get_log_image(al_log,ls_file )

if li_res = 1 then
	IF FileExists( ls_file ) THEN
		choose case upper(ls_type)
			case "BMP"
				ole_image.bringtotop = true
				
				IF NOT FileExists( ls_file ) THEN
					MessageBox("Image File", "The image file " + ls_file + " does not exist,  Check to make sure the path exists or if the database record has an image stored in the image field." )
					Return -1
				END IF

				Try
					
				ole_image.Object.ClearDisplay(  ) 
				ole_image.Object.Image( ls_file)
//				ole_image.Object.Page(1 )
//				ole_image.Object.FitTo(3)	//Actual Size
//				ole_image.Object.DisplayScaleAlgorithm = 4
				ole_image.Object.Display()
				
				Catch (throwable th1)
					
				End Try

			case "HTM"
				ole_browser.bringtotop = true
				ole_browser.object.navigate(ls_file)
				
		end choose
				
		//run(ls_file)
		
		//ls_app_image_name + "||" + ls_prac_nm + "||" + ls_facility_nm +  "||" + ls_app_nm
//		choose case li_type
//			case 1,4
//					tab_1.tabpage_view.ole_image.Object.Image = ls_file		
//					tab_1.tabpage_view.ole_image.Object.Display( )	
//					tab_1.tabpage_view.ole_image.Visible = true
//					ls_current_print_object = "Image"  //Start Code Change ----07.29.2009 #V92 maha
//				case 2,3
//					tab_1.tabpage_view.ole_browser.Object.Navigate2( ls_file)
//					tab_1.tabpage_view.ole_browser.Visible = true
//					tab_1.tabpage_view.ole_browser.BringtoTop = true //alfee 08.11.2010
//					tab_1.tabpage_view.ole_browser2.BringtoTop = False //alfee 08.11.2010						
//					ls_current_print_object = "Browser"   //Start Code Change ----07.29.2009 #V92 maha
//					//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_file , ls_Null, 4)
//			end choose
//			ls_view_print_object = ls_current_print_object   //Start Code Change ----07.06.2011 #V11 maha 
		END IF
	end if

return 1
end function

public subroutine of_set_calendar ();dw_date_range.of_SetUpdateAble( False )
dw_date_range.of_SetTransObject( SQLCA )
dw_date_range.InsertRow( 0 )

dw_date_range.of_SetDropDownCalendar( TRUE )
dw_date_range.iuo_calendar.of_Register(dw_date_range.iuo_calendar.DDLB)
end subroutine

event open;call super::open; //Start Code Change ----07.24.2015 #V15 maha - added
gs_pass_ids lst_data
datawindowchild dwchild
string s
 
lst_data = message.powerobjectparm
 
is_user = lst_data.s_stringval
il_batch = lst_data.l_app_id
is_stat = lst_data.ls_ref_value	
il_prac = lst_data.prac_id
il_entity = lst_data.i_ids[1]
il_recid = lst_data.i_ids[2]
is_message = lst_data.ls_from_window

dw_log.settransobject( sqlca)
//debugbreak()
if len(is_user ) > 0 then
	dw_user.setitem(1,"user_id", is_user)
end if

if il_batch > 0 then
	dw_batch.setitem(1,"batch_id", il_batch)
else
	dw_batch.setitem(1,"batch_id", 0) //all
	il_batch = 0
end if

//security
IF w_mdi.of_security_access( 7802 ) = 1 THEN
	dw_log.modify( "status_change.protect = true ")
end if
IF w_mdi.of_security_access( 7803 ) = 1 THEN
	dw_user.enabled = false
	dw_user.getchild( "user_id", dwchild)
	s = dwchild.modify( "user_id.background.color = 14803425 ")
end if
IF w_mdi.of_security_access( 7805 ) = 1 THEN
	cb_delete.visible = false
end if

of_set_calendar()

of_retrieve_logs()


end event

event resize;call super::resize;long lw
long lh

lw = w_verif_scan_log_incompl.workspacewidth()  - 50
lh = w_verif_scan_log_incompl.workspaceheight()   - dw_log.y - dw_log.height - 30

//messagebox("W || H",string(lw) + " || " + string(lh))

dw_log.width = lw

ole_browser.width = lw
ole_browser.height = lh

ole_image.width = lw
ole_image.height = lh
end event

on w_verif_scan_log_incompl.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_log=create dw_log
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.ole_browser=create ole_browser
this.ole_image=create ole_image
this.dw_user=create dw_user
this.st_batch=create st_batch
this.dw_batch=create dw_batch
this.st_user=create st_user
this.rb_c=create rb_c
this.rb_i=create rb_i
this.rb_b=create rb_b
this.cb_1=create cb_1
this.dw_date_range=create dw_date_range
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_log
this.Control[iCurrent+4]=this.cb_delete
this.Control[iCurrent+5]=this.cb_save
this.Control[iCurrent+6]=this.ole_browser
this.Control[iCurrent+7]=this.ole_image
this.Control[iCurrent+8]=this.dw_user
this.Control[iCurrent+9]=this.st_batch
this.Control[iCurrent+10]=this.dw_batch
this.Control[iCurrent+11]=this.st_user
this.Control[iCurrent+12]=this.rb_c
this.Control[iCurrent+13]=this.rb_i
this.Control[iCurrent+14]=this.rb_b
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.dw_date_range
this.Control[iCurrent+17]=this.gb_1
end on

on w_verif_scan_log_incompl.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_log)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.ole_browser)
destroy(this.ole_image)
destroy(this.dw_user)
destroy(this.st_batch)
destroy(this.dw_batch)
destroy(this.st_user)
destroy(this.rb_c)
destroy(this.rb_i)
destroy(this.rb_b)
destroy(this.cb_1)
destroy(this.dw_date_range)
destroy(this.gb_1)
end on

event closequery;//skip this
end event

type cb_2 from commandbutton within w_verif_scan_log_incompl
integer x = 1577
integer y = 184
integer width = 325
integer height = 76
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Refresh"
end type

event clicked;dw_date_range.accepttext()
//of_retrieve_logs( )
end event

type st_1 from statictext within w_verif_scan_log_incompl
integer x = 133
integer y = 192
integer width = 439
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Date Range:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_log from u_dw within w_verif_scan_log_incompl
integer x = 23
integer y = 276
integer width = 4480
integer height = 956
integer taborder = 20
string dataobject = "d_verif_scan_log_list"
boolean hscrollbar = true
end type

event clicked;call super::clicked;long r
long ll_log

//Start Code Change ----08.22.2017 #V154 maha - moved selectrow out of the if statement
r = row
this.setrow(r)
this.selectrow(0,false)
this.selectrow(r,true)

if dwo.name = "p_check" then
	ll_log = this.getitemnumber(row, "log_id")
	//messagebox("ll_log", ll_log)
	of_check_type(row)
	of_retrieve_pict(ll_log)
end if
//End Code Change ----08.22.2017
end event

type cb_delete from commandbutton within w_verif_scan_log_incompl
integer x = 3762
integer y = 36
integer width = 343
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer res

res = messagebox("Delete Record","Are you sure you want to delete the Log record.",question!,yesno!,2)

if res = 2 then return

dw_log.deleterow(0)

dw_log.update()

end event

type cb_save from commandbutton within w_verif_scan_log_incompl
integer x = 3419
integer y = 36
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_log.update()
end event

type ole_browser from olecustomcontrol within w_verif_scan_log_incompl
event statustextchange ( string text )
event progresschange ( long progress,  long progressmax )
event commandstatechange ( long command,  boolean enable )
event downloadbegin ( )
event downloadcomplete ( )
event titlechange ( string text )
event propertychange ( string szproperty )
event beforenavigate2 ( oleobject pdisp,  any url,  any flags,  any targetframename,  any postdata,  any headers,  ref boolean ab_cancel )
event newwindow2 ( ref oleobject ppdisp,  ref boolean ab_cancel )
event navigatecomplete2 ( oleobject pdisp,  any url )
event documentcomplete ( oleobject pdisp,  any url )
event onquit ( )
event onvisible ( boolean ocx_visible )
event ontoolbar ( boolean toolbar )
event onmenubar ( boolean menubar )
event onstatusbar ( boolean statusbar )
event onfullscreen ( boolean fullscreen )
event ontheatermode ( boolean theatermode )
event windowsetresizable ( boolean ab_resizable )
event windowsetleft ( long left )
event windowsettop ( long top )
event windowsetwidth ( long ocx_width )
event windowsetheight ( long ocx_height )
event windowclosing ( boolean ischildwindow,  ref boolean ab_cancel )
event clienttohostwindow ( ref long cx,  ref long cy )
event setsecurelockicon ( long securelockicon )
event filedownload ( ref boolean ab_cancel )
event navigateerror ( oleobject pdisp,  any url,  any frame,  any statuscode,  ref boolean ab_cancel )
event printtemplateinstantiation ( oleobject pdisp )
event printtemplateteardown ( oleobject pdisp )
event updatepagestatus ( oleobject pdisp,  any npage,  any fdone )
event privacyimpactedstatechange ( boolean bimpacted )
integer x = 18
integer y = 1240
integer width = 4503
integer height = 1604
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_verif_scan_log_incompl.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event commandstatechange(long command, boolean enable);CHOOSE CASE command
CASE 1 //CSC_NAVIGATEFORWARD
//	cb_forward.enabled = enable
CASE 2 //CSC_NAVIGATEBACK
//	cb_back.enabled = enable
END CHOOSE
end event

event newwindow2(ref oleobject ppdisp, ref boolean ab_cancel);//alfee 08.11.2010

//ole_browser2.Visible = True
//ole_browser2.object.RegisterAsBrowser = True
//ppDisp =ole_browser2.object
end event

event navigatecomplete2(oleobject pdisp, any url);//code to enable back button

end event

type ole_image from olecustomcontrol within w_verif_scan_log_incompl
event keydown ( integer keycode,  integer shift )
event keyup ( integer keycode,  integer shift )
event keypress ( integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  string description,  long scode,  string source,  string helpfile,  long helpcontext,  boolean canceldisplay )
event ocx_close ( )
event markend ( long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event toolselected ( integer toolid )
event selectionrectdrawn ( long left,  long top,  long ocx_width,  long ocx_height )
event tooltip ( integer index )
event toolpalettehidden ( long left,  long top )
event scroll ( )
event markselect ( integer button,  integer shift,  long left,  long top,  long ocx_width,  long ocx_height,  integer marktype,  string groupname )
event pastecompleted ( )
event load ( double zoom )
event markmove ( integer marktype,  string groupname )
event pagepropertiesclose ( )
event checkcontinueprinting ( long pagesprinted,  long currentpage,  integer status )
event hyperlinkgotopage ( long page )
event errorsavingundoinformation ( long ocx_error )
event straightenpage ( )
event hyperlinkgotodoc ( string link,  long page,  boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( long mode )
event baddocumentfiletype ( long page,  boolean errorout,  boolean skippage,  boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( string overlayfilename,  boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 27
integer y = 1240
integer width = 4503
integer height = 1612
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_verif_scan_log_incompl.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event click();//hpb_1.Visible = False
end event

event getfocus;//ls_current_print_object = "IMAGE"
end event

type dw_user from datawindow within w_verif_scan_log_incompl
integer x = 1765
integer y = 40
integer width = 466
integer height = 80
integer taborder = 20
string dataobject = "d_users_utl"
boolean border = false
boolean livescroll = true
end type

event constructor;datawindowchild dwchild
this.settransobject(sqlca)
this.retrieve()
this.getchild( "user_id", dwchild)
dwchild.insertrow(1)
dwchild.setitem(1,"user_id", 'ALL')

end event

event itemchanged;is_user = data
 of_retrieve_logs()
end event

type st_batch from statictext within w_verif_scan_log_incompl
integer x = 133
integer y = 56
integer width = 439
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Verification Batch:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_batch from u_dw within w_verif_scan_log_incompl
integer x = 585
integer y = 44
integer width = 759
integer height = 84
integer taborder = 10
string dataobject = "d_verif_batch_select"
boolean vscrollbar = false
boolean border = false
end type

event constructor;call super::constructor;datawindowchild dwchild
this.settransobject(sqlca)
this.retrieve()
this.getchild( "batch_id", dwchild)
dwchild.insertrow(1)
dwchild.setitem(1,"batch_id", 0)
dwchild.setitem(1,"batch_name", 'ALL')

this.of_setupdateable(false)
end event

event itemchanged;call super::itemchanged;il_batch = long(data)
of_retrieve_logs()

end event

type st_user from statictext within w_verif_scan_log_incompl
integer x = 1417
integer y = 52
integer width = 320
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Select User:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_c from radiobutton within w_verif_scan_log_incompl
integer x = 2395
integer y = 52
integer width = 311
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Complete"
end type

event clicked;is_stat = "C"
of_retrieve_logs()
end event

type rb_i from radiobutton within w_verif_scan_log_incompl
integer x = 2720
integer y = 52
integer width = 343
integer height = 68
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Incomplete"
boolean checked = true
end type

event clicked; is_stat = "I"
 of_retrieve_logs()
end event

type rb_b from radiobutton within w_verif_scan_log_incompl
integer x = 3131
integer y = 52
integer width = 229
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
string text = "Both"
end type

event clicked;is_stat = "B"
of_retrieve_logs()
end event

type cb_1 from commandbutton within w_verif_scan_log_incompl
integer x = 4105
integer y = 36
integer width = 343
integer height = 92
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)

end event

type dw_date_range from u_dw within w_verif_scan_log_incompl
integer x = 581
integer y = 124
integer width = 960
integer height = 144
integer taborder = 10
string dataobject = "d_select_from_thru_date"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event constructor;call super::constructor;//Start Code Change ----01.07.2016 #V15 maha  moved to of_set_calendar  
//This.of_SetUpdateAble( False )
//This.of_SetTransObject( SQLCA )
//This.InsertRow( 0 )
//
//This.of_SetDropDownCalendar( TRUE )
//This.iuo_calendar.of_Register(this.iuo_calendar.DDLB)
end event

event editchanged;call super::editchanged;//---------Begin Added by (Appeon)Harry 11.24.2014 for BugH101302 --------
DateTime ldt_null
If IsNull(data) or data = "" Then
	SetNull(ldt_null)
	Choose Case dwo.name
		Case 'from_date'
			this.setitem(1, 'from_date', ldt_null)
		Case 'to_date'
			this.setitem(1, 'to_date', ldt_null)
	End Choose
End If
//---------End Added ------------------------------------------------------
end event

event itemchanged;call super::itemchanged;
if dwo.name = "from_date" then
	idt_from = datetime(date(data), time("00:00:00"))
elseif dwo.name = "to_date" then
	idt_to = datetime(date(data), time("23:59:59"))
end if

of_retrieve_logs( )
end event

type gb_1 from groupbox within w_verif_scan_log_incompl
integer x = 2318
integer width = 1083
integer height = 132
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 8388608
long backcolor = 33551856
string text = "Status"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Fw_verif_scan_log_incompl.bin 
2A00000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004ca6566001d31b6600000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f000000004ca6566001d31b664ca6566001d31b66000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
23ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000065cd000029720000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000065cd000029720000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff00000001000000000000000000000000000000000000000000000000000000004ca6566001d31b6600000003000003000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000020700000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c000000004ca6566001d31b664ca6566001d31b66000000000000000000000000006f00430074006e006e006500730074
2900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000900000084000000000000000100000002000000030000000400000005000000060000000700000008fffffffe0000000a0000000bfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b00000030000001d70000000d00000100000000700000010100000078000001020000008000000103000000880000010400000090000001050000009800000106000000ac00000107000000b400000108000000bc00000109000000c40000010a000000cc0000010b000000d400000000000000dc000000030002000500000003000065cd00000003000029a7000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000bac0000000020000bac00000000b0000ffff0000000b0000ffff0000000d000000000000000100010a0000000b00657262007672657300316465000001080000000b73657273657672650b0031640b00000162000000657365726465767201090032000b00007273000072657365326465760001030000000c0074735f00706b636f73706f720001040000000c00726f620073726564656c79740001050000000d00616d69006f6365676f72746e0101006c00090000655f00006e65747802007874090000015f000000657478650079746e000001070000001363726f666c6966656e696c65676e696b060078310f00000175000000626f646e656666757a6973720100006500090000765f00006973726500006e6f000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020005000065cd000029a70000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff00000000e0000100bbb00000ffffbbb0ffffffff0000ffff00000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Fw_verif_scan_log_incompl.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
