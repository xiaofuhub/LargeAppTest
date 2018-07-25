$PBExportHeader$w_store_image_in_db.srw
forward
global type w_store_image_in_db from window
end type
type cb_2 from commandbutton within w_store_image_in_db
end type
type sle_1 from singlelineedit within w_store_image_in_db
end type
type dw_2 from datawindow within w_store_image_in_db
end type
type cb_run from commandbutton within w_store_image_in_db
end type
type dw_1 from datawindow within w_store_image_in_db
end type
type cb_quit from commandbutton within w_store_image_in_db
end type
type st_1 from statictext within w_store_image_in_db
end type
type dw_images from datawindow within w_store_image_in_db
end type
type ole_edit from olecustomcontrol within w_store_image_in_db
end type
type ole_admin from olecustomcontrol within w_store_image_in_db
end type
type cb_1 from commandbutton within w_store_image_in_db
end type
end forward

global type w_store_image_in_db from window
integer x = 1056
integer y = 484
integer width = 3150
integer height = 2440
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_2 cb_2
sle_1 sle_1
dw_2 dw_2
cb_run cb_run
dw_1 dw_1
cb_quit cb_quit
st_1 st_1
dw_images dw_images
ole_edit ole_edit
ole_admin ole_admin
cb_1 cb_1
end type
global w_store_image_in_db w_store_image_in_db

forward prototypes
public function blob of_read_file ()
end prototypes

public function blob of_read_file ();ulong l_handle
integer li_filenum, li_loops, li_counter 
long ll_filelen, ll_bytes_read, ll_new_pos 
long ll_cnt
blob lb_our_blob, lb_tot_b, blob_temp, total_blob, blank_blob 
String ls_sql
Long		fh
Integer li_retval
blob		lb_verif_picture


DO While Not FileExists( "c:\temp.tif" )
	Yield( )
	//ll_cnt++
	//IF lb_cancel THEN
	//	cb_capture.Enabled = True
	//	cb_close.Enabled = True
	//	cb_cancel.Enabled = False
	//	Return
	//END IF
LOOP

DO While FileLength( "c:\temp.tif" ) < 1
	cb_1.text = "Waiting for file to exists"
LOOP

ll_filelen = FileLength( "c:\temp.tif" ) 
//messagebox("", ll_filelen)
IF ll_filelen = -1 THEN
	MessageBox("Error", "Error with FileLength command.  Return -1." )
	Return lb_verif_picture
END IF

li_filenum = FileOpen( "c:\temp.tif", StreamMode!,READ!,LOCKREAD!)

cb_1.text = "File Open"

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
		 cb_1.text = "Reading File"
		 IF ll_bytes_read = -1 THEN
			MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return lb_verif_picture
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

END IF


RETURN lb_verif_picture




end function

on w_store_image_in_db.create
this.cb_2=create cb_2
this.sle_1=create sle_1
this.dw_2=create dw_2
this.cb_run=create cb_run
this.dw_1=create dw_1
this.cb_quit=create cb_quit
this.st_1=create st_1
this.dw_images=create dw_images
this.ole_edit=create ole_edit
this.ole_admin=create ole_admin
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.sle_1,&
this.dw_2,&
this.cb_run,&
this.dw_1,&
this.cb_quit,&
this.st_1,&
this.dw_images,&
this.ole_edit,&
this.ole_admin,&
this.cb_1}
end on

on w_store_image_in_db.destroy
destroy(this.cb_2)
destroy(this.sle_1)
destroy(this.dw_2)
destroy(this.cb_run)
destroy(this.dw_1)
destroy(this.cb_quit)
destroy(this.st_1)
destroy(this.dw_images)
destroy(this.ole_edit)
destroy(this.ole_admin)
destroy(this.cb_1)
end on

event open;//SQLCA.DBMS="ODBC"
//SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
//	Return -1
//END IF

//dw_images.SetTransObject( SQLCA )
//dw_images.Retrieve( )

dw_1.SetTransObject( SQLCA )
dw_1.Retrieve( )

end event

type cb_2 from commandbutton within w_store_image_in_db
integer x = 1257
integer y = 284
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "none"
end type

type sle_1 from singlelineedit within w_store_image_in_db
integer x = 82
integer y = 284
integer width = 1115
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
string text = "c:\Applications\images\"
borderstyle borderstyle = stylelowered!
end type

type dw_2 from datawindow within w_store_image_in_db
integer x = 2551
integer y = 380
integer width = 329
integer height = 240
integer taborder = 20
string title = "none"
string dataobject = "d_pd_image_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_run from commandbutton within w_store_image_in_db
integer x = 2098
integer y = 436
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Run"
end type

event clicked;integer rc
integer fc
integer p
integer pc
integer i
integer ic
long ll_prac
string file_name
string dir_path

dir_path = sle_1.text

if LenA(dir_path) < 3 then
	messagebox("Path","Please enter the path to the practitoner image files")
	return
end if

dw_2.settransobject(sqlca)

For p = 1 to dw_1.rowcount( )
	ll_prac = dw_1.getitemnumber(p,"prac_id")
	ic = dw_2.retrieve(ll_prac)
	dw_1.setitem(p,"img_cnt",ic)
	file_name = dir_path + string(ll_prac) + ".tif"
	messagebox("file_name",file_name)
	if not fileexists(file_name) then 
		dw_1.setitem(p,"error_val",1)
		continue
	end if
	ole_admin.object.Image( file_name)
	fc = ole_admin.object.Image.PageCount()
	rc = dw_2.getitemnumber(ic,"start_page") + dw_2.getitemnumber(ic,"num_pages") - 1
	if fc <> rc then
		messagebox("bad count","")
	end if
	
	//retrieve the image
	//text the data page count versus the image page count
	//if not match set error
	//break down the image into piece files
	//update blob to database
	//set complete
	
	
	
	
next



messagebox("Done"," Update Completed")






end event

type dw_1 from datawindow within w_store_image_in_db
integer x = 55
integer y = 400
integer width = 1984
integer height = 1868
integer taborder = 20
string title = "none"
string dataobject = "d_utl_image_prac_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_quit from commandbutton within w_store_image_in_db
integer x = 2747
integer y = 76
integer width = 343
integer height = 92
integer taborder = 10
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

type st_1 from statictext within w_store_image_in_db
integer x = 41
integer y = 76
integer width = 2720
integer height = 228
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "This utility will select all image records from the pd_image table and  then go to the appropriate physician .tif image and break up images and store them directly in the database.  Make sure there is a field called image_data in the pd_image table with a type of long binary"
boolean focusrectangle = false
end type

type dw_images from datawindow within w_store_image_in_db
integer x = 2171
integer y = 860
integer width = 475
integer height = 300
integer taborder = 20
string dataobject = "d_break_up_images"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;Long ll_rec_id
Long ll_prac_id
Long ll_seq_no
Integer li_start_page
Integer li_num_pages
Integer li_screen_id
Integer li_facility_id
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob

ll_rec_id = dw_images.GetItemNumber( row, "rec_id" )
ll_prac_id = dw_images.GetItemNumber( row, "prac_id" )	
li_facility_id = dw_images.GetItemNumber( row, "facility_id" )	
li_screen_id = dw_images.GetItemNumber( row, "screen_id" )		
ll_seq_no = dw_images.GetItemNumber( row, "seq_no" )	


//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 08.19.2006 By: LeiWei
//$<reason> Fix a defect.
/*
SELECTBLOB image_data
INTO :lb_image_data
FROM pd_images
WHERE rec_id = :ll_rec_id AND
      prac_id = :ll_prac_id AND
		facility_id = :li_facility_id AND
		seq_no = :ll_seq_no AND
		screen_id = :li_screen_id
USING SQLCA;
*/
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_get_image_pd_images(ll_rec_id, ll_prac_id, li_facility_id, ll_seq_no, li_screen_id, lb_image_data)
ELSE
	SELECTBLOB image_data
	INTO :lb_image_data
	FROM pd_images
	WHERE rec_id = :ll_rec_id AND
			prac_id = :ll_prac_id AND
			facility_id = :li_facility_id AND
			seq_no = :ll_seq_no AND
			screen_id = :li_screen_id
	USING SQLCA;
END IF
//---------------------------- APPEON END ----------------------------

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FileDelete( "c:\temp.tif" )

li_filenum =  FileOpen( "c:\temp.tif", StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_image_data, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
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

	lb_image_data = total_blob
	
	FileClose( li_filenum )

ELSE
	MessageBox( "File Open Error", "Could not open snapshot.jpg for StreamMode!" )
	Return -	1
END IF

ole_edit.object.Image( "c:\temp.tif" )
ole_edit.Object.Page(1)
ole_edit.Object.FitTo(3)
ole_edit.Object.Display()
ole_edit.Object.ImageResolutionx( 300 )
ole_edit.Object.ImageResolutionY( 300 )
ole_edit.Object.Annotationtype(11)	
ole_edit.Object.Display()


end event

type ole_edit from olecustomcontrol within w_store_image_in_db
event keydown ( ref integer keycode,  integer shift )
event keyup ( ref integer keycode,  integer shift )
event keypress ( ref integer keyascii )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event click ( )
event dblclick ( )
event ocx_error ( integer number,  ref string description,  long scode,  string source,  string helpfile,  long helpcontext,  ref boolean canceldisplay )
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
event hyperlinkgotodoc ( string link,  long page,  ref boolean handled )
event editingtextannotation ( boolean editing )
event magnifierstatus ( integer hwnd,  long status,  long magnifierzoom,  long left,  long top,  long ocx_width,  long ocx_height )
event pasteclip ( ref long mode )
event baddocumentfiletype ( long page,  ref boolean errorout,  ref boolean skippage,  ref boolean overwritepage )
event nextpage ( )
event prevpage ( )
event overlayfilenotfound ( ref string overlayfilename,  ref boolean btryagain )
event imagedraganddrop ( )
event zoomchanged ( real zoom )
event beforemarkmove ( ref boolean bcancelmove )
event readystatechange ( long readystate )
integer x = 2199
integer y = 1260
integer width = 823
integer height = 908
integer taborder = 30
borderstyle borderstyle = stylelowered!
string binarykey = "w_store_image_in_db.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type ole_admin from olecustomcontrol within w_store_image_in_db
event filepropertiesclose ( )
integer x = 2725
integer y = 956
integer width = 155
integer height = 136
integer taborder = 40
borderstyle borderstyle = stylelowered!
string binarykey = "w_store_image_in_db.win"
integer binaryindex = 1
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_1 from commandbutton within w_store_image_in_db
integer x = 2144
integer y = 668
integer width = 777
integer height = 140
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Break Up Images and Store in DB"
end type

event clicked;Long ll_rc
Long i
Long ll_prac_id
Long ll_rec_id
Long ll_seq_no
Integer li_start_page
Integer li_num_pages
Integer li_screen_id
Integer li_facility_id
String ls_image_path
String ls_app_image_path,ls_Rtn


////LOGIN TO THE DB
//SQLCA.DBMS="ODBC"
//SQLCA.DBParm = "ConnectString='DSN=IntelliCred Client;UID=dba;PWD=sql',DelimitIdentifier='No'"
//	
//CONNECT USING SQLCA;
//
//IF SQLCA.SQLCODE = -1 THEN
//	MessageBox("Login", "Inital Login Failed!  Check your ODBC configuration")
//	Return -1
//END IF


//GET THE IMAGE PATH
SELECT ids.imaging_path ,
       ids.intelliapp_app_path
INTO :ls_image_path,
	  :ls_app_image_path  
FROM ids;
IF SQLCA.SQLCODE = -1 THEN
	MessageBox("Database Error", SQLCA.SQLERRTEXT )
	Return -1
END IF

dw_images.SetTransObject( SQLCA )
dw_images.Retrieve( )

ll_rc = dw_images.RowCount( )

//ll_last_prac_id = 0

//loop through the image table and split up images and store in db
FOR i = 1 TO ll_rc
	
	This.Text = String( i ) + " of " + string( ll_rc )
	ll_rec_id = dw_images.GetItemNumber( i, "rec_id" )
	ll_prac_id = dw_images.GetItemNumber( i, "prac_id" )	
	li_facility_id = dw_images.GetItemNumber( i, "facility_id" )	
	li_screen_id = dw_images.GetItemNumber( i, "screen_id" )		
	ll_seq_no = dw_images.GetItemNumber( i, "seq_no" )	
	
	FileDelete( "c:\temp.tif" )
	
	ole_admin.object.Image( "c:\temp.tif" )

	li_start_page = dw_images.GetItemNumber( i, "tif_start_page" ) 
	li_num_pages =  dw_images.GetItemNumber( i, "num_pages" ) 
	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 07/09/2007 By: Ken.Guo
	//$<reason> When Image Admin Merge(Append) file, The first image file must be in TIF format, Otherwise PB will runerror.
	If ole_admin.object.pagecount() > 0 and ole_admin.object.FileType <> 1 Then
		Messagebox('Image','The first image file must be in "TIF" format.')
		Return -1			
	End If
	//---------------------------- APPEON END ----------------------------
	
	//--------------------------- APPEON BEGIN ---------------------------
	//$< Add  > 2008-07-15 By: Scofield
	//$<Reason> Verify if the directory has write right for the current user.
	
	ls_Rtn = f_ExaWriteRight(ls_image_path)
	if LenA(ls_Rtn) > 0 then
		MessageBox(gnv_app.iapp_object.DisplayName,ls_Rtn,Exclamation!)
		Return -1
	end if
	//---------------------------- APPEON END ----------------------------

	ole_admin.object.Append( ls_image_path + String( ll_prac_id ) + ".tif", li_start_page , li_num_pages  )				
	
	Blob lb_the_image
	
	lb_the_image = of_read_file( )
	
	UPDATEBLOB pd_images
	SET image_data = :lb_the_image
	WHERE rec_id = :ll_rec_id and
	      prac_id = :ll_prac_id and
			facility_id = :li_facility_id and
			seq_no = :ll_seq_no and
			screen_id = :li_screen_id			
	USING SQLCA;
	
	IF SQLCA.SQLNRows > 0 THEN
		COMMIT USING SQLCA ;
	ELSEIF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	ELSEIF SQLCA.SQLNRows = 0 THEN	
		MessageBox( "SQL Error", "No rows effected." )
	END IF
	
	This.text = "db updated"

END FOR

//	UPDATEBLOB verif_info
//	SET verification_picture = :lb_verif_picture
//	WHERE doc_id = :is_doc_id
//	USING SQLCA;
//	st_wait.text = "db updated"


end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
07w_store_image_in_db.bin 
2B00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ac3c065001c8e65600000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000ac3c065001c8e656ac3c065001c8e656000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
24ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000201056d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000129b0000000300001776000000030000006000000002000000010000001e0000000945676d493174696400000000000000030d9038000000000b0000ffff000000020000dee0000000020000dee0000000030012df30000000030012df300000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f697300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000200050000129b000017760000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff0300000000000000000d90380000000000000100dfa00000df68dfa0df6800122e2e001200000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000a00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
28ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000ac3c065001c8e65600000003000001c00000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000012000000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003009541a0101c3b810204f392029c002400000000ac3c065001c8e656ac3c065001c8e656000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000050000007a0000000000000001000000020000000300000004fffffffe00000006fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe00020105009541a0101c3b810204f392029c002400000001fb8f0821101b01640008ed8413c72e2b00000030000000f00000000700000100000000400000010100000048000001020000005000000103000000580000010400000060000001050000006800000000000000700000000300030002000000030000038400000003000003840000000300000000000000030000000000000003000000000000000700000000000000010001050000000d00697270006e65746e6761706401030065000c0000735f00006b636f74706f727001040073000f00007270000073746e697472617465676170000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f690000000000000000000000000000000000000000000000000000000000000000000300020000038400000384000000000000010000000000000000000000000001010000000000000000000000000000010003000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000001000000000200000300000000000300000100000000000000010000000000000000000000000000000000000000000000000000000000000000010c021406a4023a000810c100140178001d1fe8fffffffe00000004fffffffeffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
17w_store_image_in_db.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
