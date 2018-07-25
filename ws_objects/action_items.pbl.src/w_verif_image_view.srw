$PBExportHeader$w_verif_image_view.srw
forward
global type w_verif_image_view from w_main
end type
type dw_log from u_dw within w_verif_image_view
end type
type ole_browser from olecustomcontrol within w_verif_image_view
end type
type ole_image from olecustomcontrol within w_verif_image_view
end type
type cb_1 from commandbutton within w_verif_image_view
end type
end forward

global type w_verif_image_view from w_main
integer width = 4553
integer height = 2196
long backcolor = 33551856
dw_log dw_log
ole_browser ole_browser
ole_image ole_image
cb_1 cb_1
end type
global w_verif_image_view w_verif_image_view

type variables
string is_user = ""
string is_stat = "I"
string is_message = ""
long il_batch = 0
long il_entity = 0
long il_prac = 0
long il_recid = 0
string is_from  //maha - 08.18.2017
string is_docid  //maha - 08.21.2017
datetime idt_from = datetime( date("2000-01-01"), time( "00:00:00"))
datetime idt_to = datetime(today(), time("23:59:59") )
end variables

forward prototypes
public function integer of_retrieve_logs ()
public function integer of_check_type (long al_row)
public function integer of_get_log_image (long al_log, string as_file)
public function integer of_retrieve_pict (long al_log)
end prototypes

public function integer of_retrieve_logs ();// //Start Code Change ----10.28.2015 #V15 maha
//integer r
//string ls_sql
//string ls_sql_org
//string ls_where = " AND "
//datawindowchild dwchild
//
////date
//ls_where+= " ( verif_batch_log.verif_date >= '" + string( idt_from, 'yyyy-mm-dd hh:mm:ss') + "') AND "
//ls_where+= " ( verif_batch_log.verif_date <= '" + string( idt_to, 'yyyy-mm-dd hh:mm:ss') + "') AND "
//
//
////batch
//if il_batch > 0 then
//	ls_where+= " ( verif_batch_log.batch_id = " + string(il_batch) +  ") AND "
//end if
//
////user
//if is_user <> "ALL" then
//	ls_where+= "( upper(verif_batch_log.user_id) = '" + upper(is_user) +  "')  AND "
//end if
//
////status
//choose case is_stat
//	case "I"
//		ls_where+=   " ( verif_batch_log.status_change is null) AND "
//	case "C"
//		ls_where+= " ( verif_batch_log.status_change is not null) AND "
//	case "B"
//		//no filter
//end choose
//
////provider
//if il_prac > 0 then
//	ls_where+= " ( verif_batch_log.prac_id = " + string(il_prac) +  ") AND "
//end if
//
////record
//if il_recid > 0 then
//	ls_where+= " ( verif_batch_log.rec_id = " + string(il_recid) +  ") AND "
//end if
//
//ls_where = mid(ls_where, 1, len(ls_where) - 4)
//
//if is_message = "Y" then
//	messagebox("ls_where", ls_where)
//end if
//
//ls_sql = dw_log.GetSQLSelect()
//ls_sql_org = ls_sql
//
//ls_sql = ls_sql + " " + ls_where
////messagebox("",ls_sql)
//r = dw_log.SetSQLSelect(ls_sql)
//
//if r < 1 then
//	messagebox("Log Retrieval Failed", ls_sql)
//end if
//
//dw_log.settransobject(sqlca)
//dw_log.retrieve()
//
//dw_log.SetSQLSelect(ls_sql_org)
//
//dw_log.Modify("DataWindow.table.UpdateTable='verif_batch_log'")
//dw_log.Modify("DataWindow.table.Updatewhere='0'")
//
//dw_log.getchild("status_change", dwchild)
//dwchild.settransobject(sqlca)
//dwchild.retrieve()
// 
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

 if is_from = "Verif" then
	IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
		of_get_image_verif_info(is_docid, lb_verif_picture)

	ELSE
		SELECTBLOB verification_picture
		INTO :lb_verif_picture
		FROM verif_info
		WHERE doc_id = :is_docid
		USING SQLCA;
	END IF	
	
else  //batch
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
end if



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
//messagebox("", as_file)
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
integer li_type
string ls_null
string ls_reference
setnull(ls_null)

//should be able to get in the dw when retrieved???
if ls_type = "Batch" then
	select image_type into :ls_type from verif_batch_log_image where log_id = :al_log;
	choose case ls_type
		case "bmp"
			ls_file = gs_temp_path + "_ResultPage.bmp"
		case "htm"
			ls_file = gs_temp_path + "_ResultPage.htm"
	end choose
else  //verifications
	li_type = dw_log.getitemnumber(1, "verification_picture_flag")
	choose case li_type
		case 1
			ls_type = "??"	
			
		case 2
			ls_type = "pdf"
			ls_file = gs_temp_path + "_ResultPage.pdf"
		case 3
			ls_type = "htm"
			ls_file = gs_temp_path + "_ResultPage.htm"
		case 4
			ls_type = "bmp"
			ls_file = gs_temp_path + "_ResultPage.bmp"
		case 5
			ls_type = "png"
			ls_file = gs_temp_path + "_ResultPage.png"
		case 6
			ls_type = "xml"
			ls_file = gs_temp_path + "_ResultPage.xml"
		case 7
			ls_type = "jpg"
			ls_file = gs_temp_path + "_ResultPage.jpg"
	end choose
end if

messagebox("","2")
	
li_res = of_get_log_image(al_log, ls_file )
messagebox("","3")
if li_res = 1 then
	IF FileExists( ls_file ) THEN
		choose case upper(ls_type)
			case "BMP", "JPG" 
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

			case "HTM", "PNG", "XML", "PDF"  //Start Code Change ----12.20.2017 #V16 maha - added pdf
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

event open;call super::open;//Start Code Change ----08.21.2017 #V16 maha - copied from other window
gs_pass_ids lst_data
datawindowchild dwchild
integer r
string s
 
lst_data = message.powerobjectparm
 
//from: provider or batch
//docid
//
is_from = lst_data.s_stringval
is_docid = lst_data.ls_doc_id
//is_stat = lst_data.ls_ref_value	
//il_prac = lst_data.prac_id
//il_entity = lst_data.i_ids[1]
//il_recid = lst_data.i_ids[2]
//is_message = lst_data.ls_from_window

dw_log.settransobject( sqlca)

if is_from  = "Verif" then
	r = dw_log.retrieve(is_docid)
	if r < 1 then
		messagebox("","There is no log record for this verification")
		return -1
	else
		messagebox("","1")
		of_retrieve_pict( 0)
	end if
else
	//
end if



//debugbreak()
//if len(is_user ) > 0 then
//	dw_user.setitem(1,"user_id", is_user)
//end if
//
//if il_batch > 0 then
//	dw_batch.setitem(1,"batch_id", il_batch)
//else
//	dw_batch.setitem(1,"batch_id", 0) //all
//	il_batch = 0
//end if
//
////security
//IF w_mdi.of_security_access( 7802 ) = 1 THEN
//	dw_log.modify( "status_change.protect = true ")
//end if
//IF w_mdi.of_security_access( 7803 ) = 1 THEN
//	dw_user.enabled = false
//	dw_user.getchild( "user_id", dwchild)
//	s = dwchild.modify( "user_id.background.color = 14803425 ")
//end if
//IF w_mdi.of_security_access( 7805 ) = 1 THEN
//	cb_delete.visible = false
//end if
//
//of_set_calendar()
//
//of_retrieve_logs()


end event

event resize;call super::resize;long lw
long lh

lw = this.workspacewidth()  - 50
lh = this.workspaceheight()   - dw_log.y - dw_log.height - 30

//messagebox("W || H",string(lw) + " || " + string(lh))

ole_browser.width = lw
ole_browser.height = lh

ole_image.width = lw
ole_image.height = lh
end event

on w_verif_image_view.create
int iCurrent
call super::create
this.dw_log=create dw_log
this.ole_browser=create ole_browser
this.ole_image=create ole_image
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_log
this.Control[iCurrent+2]=this.ole_browser
this.Control[iCurrent+3]=this.ole_image
this.Control[iCurrent+4]=this.cb_1
end on

on w_verif_image_view.destroy
call super::destroy
destroy(this.dw_log)
destroy(this.ole_browser)
destroy(this.ole_image)
destroy(this.cb_1)
end on

event closequery;//skip this
end event

type dw_log from u_dw within w_verif_image_view
integer x = 23
integer y = 8
integer width = 4064
integer height = 264
integer taborder = 20
string dataobject = "d_verif_image_stamps"
end type

event clicked;call super::clicked;long r
long ll_log

if dwo.name = "p_check" then
	ll_log = this.getitemnumber(row, "log_id")
	//messagebox("ll_log", ll_log)
	of_check_type(row)
	of_retrieve_pict(ll_log)
else
	r = row
	this.setrow(r)
	this.selectrow(0,false)
	this.selectrow(r,true)
end if
end event

type ole_browser from olecustomcontrol within w_verif_image_view
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
integer y = 280
integer width = 4503
integer height = 1800
integer taborder = 20
boolean bringtotop = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_verif_image_view.win"
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

type ole_image from olecustomcontrol within w_verif_image_view
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
integer x = 23
integer y = 276
integer width = 4503
integer height = 1808
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_verif_image_view.win"
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

type cb_1 from commandbutton within w_verif_image_view
integer x = 4128
integer y = 12
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


Start of PowerBuilder Binary Data Section : Do NOT Edit
05w_verif_image_view.bin 
2900000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a8a3ec4001d379ab00000003000001800000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000009c00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000038856f96111d0340ac0006ba9a205d74f00000000a8a3ec4001d379aba8a3ec4001d379ab000000000000000000000000004f00430054004e004e00450053005400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000030000009c000000000000000100000002fffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000004c000065cd00002e820000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c0460000000000008000000000000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004c000065cd00002e820000000000000000000000000000000000000000000000000000004c0000000000000000000000010057d0e011cf3573000869ae62122e2b00000008000000000000004c0002140100000000000000c046000000000000800000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000a8a4135001d379ab00000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000a8a3ec4001d379aba8a4135001d379ab000000000000000000000000006f00430074006e006e006500730074
2700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc000000030002000500000003000065cd0000000300002eb7000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000b2a4000000020000b2a40000000300f9b2f40000000300f9b2f40000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f69730000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020005000065cd00002eb70000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100b34400001000b3441000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
15w_verif_image_view.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
