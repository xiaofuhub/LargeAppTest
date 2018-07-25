$PBExportHeader$w_meet_minu_view.srw
forward
global type w_meet_minu_view from window
end type
type ole_scan_edit from olecustomcontrol within w_meet_minu_view
end type
type cb_close from commandbutton within w_meet_minu_view
end type
type cb_print from commandbutton within w_meet_minu_view
end type
end forward

global type w_meet_minu_view from window
integer width = 3648
integer height = 1860
boolean titlebar = true
string title = "Viewing meeting minutes"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
ole_scan_edit ole_scan_edit
cb_close cb_close
cb_print cb_print
end type
global w_meet_minu_view w_meet_minu_view

type variables
str_folder istr_doc
end variables

forward prototypes
public function integer wf_get_image (string as_type, long al_facility, long al_recid)
end prototypes

public function integer wf_get_image (string as_type, long al_facility, long al_recid);//////////////////////////////////////////////////////////////////////
// $<event> wf_get_image
// $<arguments>
// $<returns> long
// $<description> Viewing meeting minutes (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.13.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Integer li_start_page
Integer li_num_pages
Long li_filenum
Long ll_filelen
Long ll_start
Long ll_new_pos, ll_data_length
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob total_blob

string ls_file

SetPointer(HourGlass!)

String ls_filename
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server

ls_filename = String(al_facility) + "_" + String(al_recid) + ".tif"

ls_file = gs_temp_path + "images\"  
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename


ls_filedate_server = String( Datetime( Today(), Now() ), 'mm/dd/yyyy hh:mm:ss')
IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

//IF FileExists(ls_file) THEN
//	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_local)
//
//	IF ls_filedate_local = ls_filedate_server THEN RETURN 100
//END IF
IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT Datalength(Doc_blob)
	INTO :ll_data_length
	FROM document_storage
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		RETURN 0
	END IF
	
	IF ll_data_length > 8000 THEN 
		 IF Mod(ll_data_length,8000) = 0 THEN 
			  li_loops = ll_data_length/8000 
		 ELSE 
			  li_loops = (ll_data_length/8000) + 1 
		 END IF 
	ELSE 
		 li_loops = 1 
	END IF 
	
	FOR li_counter = 1 to li_loops
		Yield()
		SetPointer(HourGlass!)
		
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(Doc_blob,:ll_start,8000)
		INTO :blob_temp
		FROM document_storage
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob

ELSE
	
	SELECTBLOB Doc_blob 
	INTO :lb_image_data
	FROM document_storage 
	WHERE 	Function_type  = :as_type
	     AND  Record_id = :al_recid
		AND   Facility_id  = :al_facility
	USING SQLCA;
	
END IF


IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	RETURN -1
END IF

if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1
	

IF Not FileExists( ls_file) THEN 
	
	MessageBox("File Creation Error", "No image file created.  Check to make sure the directory " + gs_dir_path + " is valid." )
	
END IF

//gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Prac Images", ls_filename, RegString!, ls_filedate_server)	

IF ole_scan_edit.object.Image <> ls_file THEN
//	ole_scan_edit.Object.ClearDisplay(  ) 
	ole_scan_edit.Object.Image( ls_file )
//	ole_scan_edit.Object.UndoLevels( 1 )
	ole_scan_edit.Object.Page( 1 )
	ole_scan_edit.Object.FitTo(3)	
	ole_scan_edit.Object.DisplayScaleAlgorithm = 4
	ole_scan_edit.Object.Display()

END IF

Return 1

end function

on w_meet_minu_view.create
this.ole_scan_edit=create ole_scan_edit
this.cb_close=create cb_close
this.cb_print=create cb_print
this.Control[]={this.ole_scan_edit,&
this.cb_close,&
this.cb_print}
end on

on w_meet_minu_view.destroy
destroy(this.ole_scan_edit)
destroy(this.cb_close)
destroy(this.cb_print)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> OPEN
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Long ll_row

istr_doc = Message.powerobjectparm

IF isvalid(istr_doc) THEN
//	dw_1.retrieve( istr_doc.as_type, istr_doc.al_category,  istr_doc.al_folder_id )
	wf_get_image( istr_doc.as_type,  istr_doc.al_folder_id, istr_doc.al_category )
	
END IF

end event

type ole_scan_edit from olecustomcontrol within w_meet_minu_view
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
integer width = 3602
integer height = 1616
integer taborder = 10
boolean border = false
long backcolor = 67108864
boolean focusrectangle = false
string binarykey = "w_meet_minu_view.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

type cb_close from commandbutton within w_meet_minu_view
integer x = 3232
integer y = 1648
integer width = 343
integer height = 92
integer taborder = 30
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

type cb_print from commandbutton within w_meet_minu_view
integer x = 2798
integer y = 1648
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Print"
end type

event clicked;ole_scan_edit.object.PrintImage(1,1,1)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Aw_meet_minu_view.bin 
2200000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe00000004fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000100000000000000000000000000000000000000000000000000000000819ebf2001d131d300000003000003400000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000024d00000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff000000036d94028011ce9f116002fd838ac03e8c00000000819ebf2001d131d3819ebf2001d131d3000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000008400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000cfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
27ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff0000fffe000202066d94028011ce9f116002fd838ac03e8c00000001fb8f0821101b01640008ed8413c72e2b000000300000021d0000000f000001000000008000000101000000880000010200000090000001030000009800000104000000a000000105000000a800000106000000bc00000107000000c400000108000000cc00000109000000d40000010a000000dc0000010b000000e40000010c000000ec0000010d000000f400000000000000fc0000000300020005000000030000517100000003000029c1000000030000006000000002000000010000001e0000000945676d493174696400000000000000032ffffffe0000000b0000ffff000000020000c6ec000000020000c6ec000000030018c73c000000030018c73c0000000b0000ffff0000000b0000ffff0000000f000000000000000100010a0000000b0065726c0076726573003164650000010c0000000b73657262657672650b0031640b0000016c000000657365726465767201080032000b000072730000726573653164657600010d0000000b00657262007672657300326465000001090000000b7365727365767265030032640c0000015f000000636f74736f72706b040073700c000001620000006564726f797473720500656c0d000001690000006567616d746e6f63006c6f7200000101000000097478655f78746e65000102000000090078655f00746e657401070079001300006f660000666563726c656c69696b6e697831676e0001060000000f00646e75006675626f7372656600657a6900000100000000097265765f6e6f6973000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000002000500005171000029c10000006000010001000000006d490800696445670001317400000100c8000000020000420000ff0000ffff00ff000000ff00000000000000000100000000000000000100000101ff03000000fe000000002fffff000000007a000100c78000001000c780100000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Aw_meet_minu_view.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
