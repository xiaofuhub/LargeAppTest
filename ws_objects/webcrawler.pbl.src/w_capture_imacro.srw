$PBExportHeader$w_capture_imacro.srw
forward
global type w_capture_imacro from window
end type
type cb_1 from commandbutton within w_capture_imacro
end type
type st_1 from statictext within w_capture_imacro
end type
type cb_response from commandbutton within w_capture_imacro
end type
type dw_1 from datawindow within w_capture_imacro
end type
type cb_close from commandbutton within w_capture_imacro
end type
type st_wait from statictext within w_capture_imacro
end type
type cb_preview from commandbutton within w_capture_imacro
end type
type p_6 from picture within w_capture_imacro
end type
type cb_cancel from commandbutton within w_capture_imacro
end type
type cb_capture from commandbutton within w_capture_imacro
end type
end forward

global type w_capture_imacro from window
integer x = 5
integer y = 4
integer width = 3557
integer height = 1256
boolean titlebar = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 80269524
cb_1 cb_1
st_1 st_1
cb_response cb_response
dw_1 dw_1
cb_close cb_close
st_wait st_wait
cb_preview cb_preview
p_6 p_6
cb_cancel cb_cancel
cb_capture cb_capture
end type
global w_capture_imacro w_capture_imacro

type variables
datawindow idw_data

Boolean lb_cancel = False
Boolean ib_pause_for_file = True
Boolean ib_image_available = True

String is_from_window
String ls_file_extention
String is_web_title
string is_macro_path //maha03.01.07
Integer ii_timer_pause = 2


String is_doc_id

end variables

forward prototypes
public function integer of_setup (gs_pass_ids as_pass_ids)
end prototypes

public function integer of_setup (gs_pass_ids as_pass_ids);Long ll_lookup_code

is_doc_id = as_pass_ids.ls_doc_id
is_from_window = as_pass_ids.ls_from_window
ib_image_available =	as_pass_ids.ls_image_available 

ll_lookup_code = as_pass_ids.ll_verification_id

SELECT web_title
INTO :is_web_title
FROM address_lookup
WHERE lookup_code = :ll_lookup_code;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

if isnull(is_web_title) then is_web_title = "IntelliSoft Goto Web"
//messagebox( is_web_title, ll_lookup_code )

IF ib_image_available THEN
	cb_preview.Enabled = True
	This.Title = as_pass_ids.ls_ref_value + " (Image Available)"	
ELSE
	cb_preview.Enabled = False	
	This.Title = as_pass_ids.ls_ref_value
END IF


Return 0
end function

on w_capture_imacro.create
this.cb_1=create cb_1
this.st_1=create st_1
this.cb_response=create cb_response
this.dw_1=create dw_1
this.cb_close=create cb_close
this.st_wait=create st_wait
this.cb_preview=create cb_preview
this.p_6=create p_6
this.cb_cancel=create cb_cancel
this.cb_capture=create cb_capture
this.Control[]={this.cb_1,&
this.st_1,&
this.cb_response,&
this.dw_1,&
this.cb_close,&
this.st_wait,&
this.cb_preview,&
this.p_6,&
this.cb_cancel,&
this.cb_capture}
end on

on w_capture_imacro.destroy
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.cb_response)
destroy(this.dw_1)
destroy(this.cb_close)
destroy(this.st_wait)
destroy(this.cb_preview)
destroy(this.p_6)
destroy(this.cb_cancel)
destroy(this.cb_capture)
end on

event open;Integer li_filenum
Integer li_pos
String ls_data
string ls_runpath
gs_pass_ids ls_pass_ids

ls_pass_ids =  Message.PowerObjectParm

//messagebox("", ls_pass_ids.ll_verification_id )

of_setup( ls_pass_ids )

ib_pause_for_file = False

//get path from macro
//Hkey_local_machine\software\IIM\PathBasic
if RegistryGet( "HKEY_LOCAL_MACHINE\IIM\" ,"PathBasic", RegString!, is_macro_path)  = -1 then
	is_macro_path = "C:\Users\Public\Documents\IMacros\"
	ls_runpath = "C:\Program Files\IMacros\"
end if

//maha installation location
ls_runpath = "C:\Program Files (x86)\iOpus\iMacros\"
is_macro_path = "C:\Users\Public\Documents\IMacros\Macros\"

is_macro_path = of_check_path(is_macro_path,1) //check for slash at end

IF NOT FileExists(ls_runpath + "imacros.exe") THEN
	MessageBox("Missing Software", "Unable to find the Imacros software necessary to run this function.  This can be downloaded from the IntelliSoft Group Download website. Please contact Customer Support if you need assistance with this." )
	Close( This )
	Return -1	
END IF

IF IsValid( w_prac_data_1 ) THEN
	idw_data = w_prac_data_1.tab_1.tabpage_verif.uo_verif_summary.dw_detail
ELSE
	idw_data = w_action_items.tab_1.tabpage_detail.tab_view.tabpage_browse.dw_browse
END IF

// read the capture.bat file.  the first line contains the command to run the image capture utility

///////////////////example ini file////////////////////////////
//"C:\IntelliCred\ScreenCapture\HprSnap5.exe" -snap:window -save:gif:q95 c:\snapshot.gif
//wait=2

//FileRead( li_filenum, ls_data )

//li_pos = POS( Upper(ls_data), "SAVE:" )
//ls_file_extention = Mid( ls_data, li_pos + 5, 3 )

//read it again because the second line contains how long to pause after a capture command
//second line should start with the word wait=
//FileRead( li_filenum, ls_data )
//ii_timer_pause = Integer( Mid( ls_data, 6, 2 ))

//messagebox("", ls_data )

//IF IsNull( ii_timer_pause ) OR ii_timer_pause = 0 THEN
//	ii_timer_pause = 3
//END IF

//Messagebox("", ii_timer_pause )

//FileClose( li_filenum )

Return 1
end event

event timer;//lb_pause_for_file = False

end event

type cb_1 from commandbutton within w_capture_imacro
integer x = 2720
integer y = 8
integer width = 370
integer height = 76
integer taborder = 60
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Help"
end type

event clicked;MessageBox("Web Site Window",  'To keep the browser window in front of all other windows when capturing, the IntelliCred software needs to get the value that is in the Title of the browser window you are trying to capture.  In the lookup painter for addresses there is a field called Web Title,  This is where you would place that value for the entity you are going to to capture information.  This allows IntelliCred to make a reference to the web window and keep it in front of all the other windows.  Do not include - Microsoft Internet Explorer as part of the title.  For example.  If the title of the browser window is "New Hampshire Licensure Agency - Microsoft Internet Explorer" then the value that you put in the field should be "New Hampshire Licensure Agency"')
end event

type st_1 from statictext within w_capture_imacro
integer x = 1152
integer y = 20
integer width = 370
integer height = 76
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Response Code:"
boolean focusrectangle = false
end type

type cb_response from commandbutton within w_capture_imacro
integer x = 2235
integer y = 8
integer width = 370
integer height = 76
integer taborder = 50
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Apply"
end type

event clicked;Integer li_cr
Integer li_last_num_sent
Integer li_found
Long ll_response_code
dw_1.AcceptText( )

ll_response_code = dw_1.GetItemNumber( 1, "response_code" )

IF LenA( StrIng( ll_response_code  ) )  = 0 THEN
	MessageBox("Response Code", "A Response Code is required" )	
END IF

li_cr = idw_data.GetRow( )

idw_data.SetItem( li_cr , "response_code", ll_response_code )
idw_data.SetColumn( "response_code" )
idw_data.SetItem( li_cr, "user_name", gs_user_id )
idw_data.SetItem( li_cr, "source", "P" )
idw_data.SetItem( li_cr, "date_recieved", Today() )
idw_data.SetItem( li_cr, "print_flag", 0 )
if idw_data.getitemstring(li_cr, "reference_value") <> 'Expiring Appointment Letter' then//maha 100400 to keep recieved letters from being recredentialed
	idw_data.SetItem( li_cr, "exp_credential_flag", 0 )
end if

li_last_num_sent = idw_data.GetItemNumber( li_cr, "number_sent" )
IF IsNull(li_last_num_sent) THEN
		li_last_num_sent = 0
END IF
li_last_num_sent++
idw_data.SetItem( li_cr, "number_sent", li_last_num_sent )
idw_data.SetItem( li_cr, "print_flag", 0 )			
IF IsNull( idw_data.GetItemDateTime( li_cr, "first_sent" ) ) THEN
		idw_data.SetItem( li_cr, "first_sent", DateTime(Today(), Now()) )
END IF

idw_data.SetItem( li_cr, "last_sent", DateTime(Today(), Now()) )

end event

type dw_1 from datawindow within w_capture_imacro
integer x = 1509
integer width = 768
integer height = 92
integer taborder = 60
boolean enabled = false
string dataobject = "d_sc_verif_response_code"
boolean border = false
boolean livescroll = true
end type

event constructor;DataWindowChild dwchild

This.SetTransObject(SQLCA)

This.GetChild( "response_code", dwchild )
dwchild.SetTransObject( SQLCA )
dwchild.Retrieve("credentials verification response")

This.InsertRow( 0 )


This.SetItem( 1, "response_code", 658 )

end event

type cb_close from commandbutton within w_capture_imacro
integer x = 3104
integer y = 8
integer width = 370
integer height = 76
integer taborder = 40
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;Close( Parent )
end event

type st_wait from statictext within w_capture_imacro
integer x = 594
integer y = 956
integer width = 690
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type cb_preview from commandbutton within w_capture_imacro
integer x = 750
integer y = 8
integer width = 370
integer height = 76
integer taborder = 30
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Preview Picture"
end type

event clicked;Long li_filenum
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
string ls_savefile

//messagebox("length", len(lb_verif_picture) )

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
SELECTBLOB verification_picture
INTO :lb_verif_picture
FROM verif_info
WHERE doc_id = :is_doc_id
USING SQLCA;
*/
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_verif_info(is_doc_id, lb_verif_picture)
ELSE
	SELECTBLOB verification_picture
	INTO :lb_verif_picture
	FROM verif_info
	WHERE doc_id = :is_doc_id
	USING SQLCA;
END IF
//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

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

ls_savefile = gs_temp_path + "snapshot.bmp"
FileDelete( ls_savefile)

li_filenum =  FileOpen( ls_savefile, StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_verif_picture, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 st_wait.text = "Writing File"
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
   st_wait.text = "File Closed"
ELSE
	MessageBox( "File Open Error", "Could not open snapshot.bmp for StreamMode!" )
	Return -	1
END IF

cb_cancel.Enabled = True

DO While Not FileExists(ls_savefile )
	Yield( )
	st_wait.text = "Loading file from database"
	IF lb_cancel THEN
		cb_capture.Enabled = True
		cb_close.Enabled = True
		cb_cancel.Enabled = False
		Return
	END IF
LOOP

cb_cancel.Enabled = True

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 06.23.2006 By: Liang QingShi
//$<reason>  GetContextService is currently unsupported. 
//$<modification> Replace GetContextService with ShellExecuteA to provide the
//$<modification> same functionality.
/*
Inet  iinet_base

GetContextService("Internet", iinet_base)

iinet_base.HyperlinkToURL( gs_dir_path + "snapshot." + ls_file_extention)
*/
String ls_url,ls_null
setnull(ls_null)
ls_url = ls_savefile
//ShellExecuteA ( Handle( This ), "open", 'IEXPLORE', ls_url , ls_Null, 4)   //Commented by (Appeon)Harry 04.28.2015 - for Keep Everything under One Browser
ShellExecuteA ( Handle( This ), "open", of_getbrowserversion( ), ls_url, ls_Null, 4) //(Appeon)Harry 04.28.2015 - for Keep Everything under One Browser

//---------------------------- APPEON END ----------------------------



end event

type p_6 from picture within w_capture_imacro
integer x = 91
integer y = 344
integer width = 1280
integer height = 708
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_cancel from commandbutton within w_capture_imacro
integer x = 379
integer y = 8
integer width = 370
integer height = 76
integer taborder = 20
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "Cancel"
end type

event clicked;lb_cancel = TRUE
cb_capture.Enabled = True
cb_close.Enabled = True

end event

type cb_capture from commandbutton within w_capture_imacro
integer x = 9
integer y = 8
integer width = 370
integer height = 76
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Capture "
end type

event clicked;//Note: this function cannot work unless the webpage from the webCrawl verification window can be transfered to the imacros window.  maha 10.10.2012


ulong l_handle
Integer li_wait
integer li_FileNum1
integer li_filenum
integer li_loops
integer li_counter 
Integer li_retval
string ls_data
string ls_file
string ls_savefile
String ls_sql
Long fh
long ll_filelen 
long ll_bytes_read 
long ll_new_pos 
long ll_cnt
blob lb_our_blob
blob lb_tot_b
blob blob_temp
blob total_blob
blob blank_blob 
blob lb_verif_picture

cb_response.Enabled = False
dw_1.Enabled = False
cb_capture.Enabled = False
cb_close.Enabled = False
cb_cancel.Enabled = True

IF LenA( is_web_title ) = 0 THEN
	//MessageBox("Web Site Window",  "To keep the web window in front for capturing the IntelliCred software needs to get the value that is in the Title of the Web Window.  This allows IntelliCred to make a reference to the web window and keep it in front of all the other windows.  Do not include - Microsoft Internet Explorer as part of the title")
END IF

l_handle = FindWindowA( 0, is_web_title )
BringWindowToTop( l_handle )

ls_file = is_macro_path + "Macros\capture.iim"
ls_savefile = gs_temp_path + "snapshot.bmp" 

li_FileNum1 = FileOpen(  ls_file , LineMode!, Write!, LockWrite!, Replace!)

IF li_filenum1 = -1 THEN
	MessageBox("Error", "Could not open file " + ls_file + ".  This may be a rights issue on your computer." )
	Close(parent )
	Return -1
END IF

ls_data = "SAVEAS TYPE=BMP FOLDER=" + gs_temp_path + " FILE=snapshot.bmp"
FileWrite( li_FileNum1, ls_data  )
FileClose( li_filenum1 )

//li_wait =  Integer( Mid( ls_data, POS( ls_data, "=" )+1, 100 ) )

//Timer( li_wait )

//lb_pause_for_file = True

//DO While lb_pause_for_file = True
//	Yield( )
//LOOP

//Timer( 0 )

FileDelete( ls_savefile )
IF NOT FileExists( ls_file) THEN
	MessageBox("Missing File", "File " + ls_file + " was not created.  This may be a rights issue." )
	cb_response.Enabled = True
	dw_1.Enabled = True
	cb_capture.Enabled = True
	cb_close.Enabled = True
	cb_cancel.Enabled = False
	Return -1
END IF


OLEObject myoleobject
myoleobject = CREATE OLEObject
li_retval = myoleobject.ConnectToNewObject(  "Imacros")
IF li_retval < 0 THEN
	messagebox("Capture failure","Failed to connect to InternetMacros.  Check installation.")
	Return -1
END IF

myoleobject.iimInit("-tray")		
				
li_retval = myoleobject.iimPlay (ls_file)
IF li_retval < 0 THEN
	messagebox("of_Crawl failure","iimplay failed")
	myoleobject.iimExit()
	Return 1
end if

myoleobject.iimExit()

//DO While Not FileExists( gs_dir_path + "snapshot." + ls_file_extention )
//	Yield( )
//	ll_cnt++
//	st_wait.text = "Waiting for capture"
//	IF lb_cancel THEN
//		cb_capture.Enabled = True
//		cb_close.Enabled = True
//		cb_cancel.Enabled = False
//		Return
//	END IF
//LOOP

//DO While FileLength( gs_dir_path +"snapshot." + ls_file_extention ) < 1
//	st_wait.text = "Waiting for file to exists"
//LOOP

//lb_pause_for_file = True
//
//Timer( ii_timer_pause )
//
//DO While lb_pause_for_file = True
//	Yield( )
//LOOP

//Timer( 0 )

ll_filelen = FileLength( ls_savefile) 
//messagebox("", ll_filelen)
IF ll_filelen = -1 THEN
	MessageBox("Capture Error", "Error with FileLength command.  Return -1." )
	Return -1
END IF

li_filenum = FileOpen( ls_savefile, StreamMode!,READ!,LOCKREAD!)

st_wait.text = "File Open"

IF li_filenum <> -1 THEN
	
	//Find out how long the file specified in sle_filename.text is

	//Determine how many FileReads will be necessary to read all of the file ... 
	//You can't read in more than 32K at a time 
	IF ll_filelen > 32765 THEN 
   	 IF Mod(ll_filelen,32765) = 0 THEN 
	        li_loops = ll_filelen/32765 
	    ELSE 
   	     li_loops = (ll_filelen/32765) + 1 
	    END IF 
	ELSE 
   	 li_loops = 1 
	END IF 

	//read the file ... 
	FOR li_counter = 1 to li_loops 
   	 ll_bytes_read = FileRead( li_filenum, blob_temp) 
		 st_wait.text = "Reading File"
		 IF ll_bytes_read = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_read 
	    FileSeek(li_filenum, ll_new_pos, FROMBEGINNING!) 

   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_verif_picture = total_blob
	
	//messagebox("len", len( lb_verif_picture ))

	FileClose(li_filenum) 
	
	//li_retval = FileRead(li_filenum, lb_verif_picture)
	//IF li_retval = -1 THEN
	//	MessageBox("File Read Error", "Could not read file" )
	//	Return -1
	//END IF
	//FileClose(li_filenum)
	
	UPDATEBLOB verif_info
	SET verification_picture = :lb_verif_picture
	WHERE doc_id = :is_doc_id
	USING SQLCA;
	st_wait.text = "db updated"

	UPDATE verif_info
	SET verification_picture_flag = 4
	WHERE doc_id = :is_doc_id
	USING SQLCA;	
	
	idw_data.SetItem( idw_data.GetRow( ), "verification_picture_flag", 4 )
	
ELSE
	MessageBox( "File Open Error", "Could not open " + ls_savefile + " for StreamMode!" )
	Return -1
END IF

IF SQLCA.SQLNRows > 0 THEN
	COMMIT USING SQLCA ;
ELSEIF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
ELSEIF SQLCA.SQLNRows = 0 THEN	
	MessageBox( "SQL Error", "No rows effected." )
END IF

//FileDelete( gs_dir_path + "snapshot." + ls_file_extention )

dw_1.Enabled = True
//lb_pause_for_file = True
cb_capture.Enabled = True
cb_response.Enabled = True
cb_cancel.Enabled = False
cb_preview.Enabled = True
cb_close.Enabled = True

end event

