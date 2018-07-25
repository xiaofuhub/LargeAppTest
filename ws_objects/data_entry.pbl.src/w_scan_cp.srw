$PBExportHeader$w_scan_cp.srw
forward
global type w_scan_cp from window
end type
type hpb_1 from hprogressbar within w_scan_cp
end type
type st_1 from statictext within w_scan_cp
end type
type p_1 from picture within w_scan_cp
end type
type ole_scan from olecustomcontrol within w_scan_cp
end type
end forward

global type w_scan_cp from window
integer width = 1650
integer height = 388
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
windowtype windowtype = popup!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
hpb_1 hpb_1
st_1 st_1
p_1 p_1
ole_scan ole_scan
end type
global w_scan_cp w_scan_cp

forward prototypes
public function integer of_scan ()
public function integer of_saveallpage2pdf (string as_file, boolean ab_mulpage)
public function integer of_scan_saveas_pdf (string as_file)
public function integer of_save (string as_file, string as_ext)
public function boolean of_selectimagesource ()
public subroutine of_showtwainui (boolean ab_set)
end prototypes

public function integer of_scan ();//////////////////////////////////////////////////////////////////////
// $<function>of_scan
// $<arguments>
// $<returns> integer 1- success; -1 - Failed
// $<description>scanning
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Int li_ret

TRY
	li_ret = ole_scan.object.Scan()
CATCH (RUNTIMEERROR E)
	li_ret = -1
END TRY	

Return li_ret
end function

public function integer of_saveallpage2pdf (string as_file, boolean ab_mulpage);//////////////////////////////////////////////////////////////////////
// $<function>of_saveallpage2pdf
// $<arguments>
//		String as_file
//		Boolean ab_mulpage
// $<returns> integer 1- success; -1 - Failed
// $<description>Save all pages from image buffer to multipage pdf.
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////

Int li_ret
String ls_Rtn

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_file)
if Len(ls_Rtn) > 0 then
	if gb_recordlog = false then
		MessageBox(as_file,ls_Rtn, Exclamation!)
	else
		gs_errmsg = ls_Rtn
	end if
	Return -1
end if

If ole_scan.object.SaveAllPage2PDF(as_file, ab_mulpage, 1) Then
	li_ret = 1
Else
	li_ret = -1
End If
	

Return li_ret

end function

public function integer of_scan_saveas_pdf (string as_file);//////////////////////////////////////////////////////////////////////
// $<function>of_scan_saveas_pdf
// $<arguments>
//		String as_file
// $<returns> integer 1- success; -1 - Failed
// $<description>Scan file and saveas pdf
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.21.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////

String ls_Rtn
String ls_path
boolean lb_showsetup
Integer s20
Integer li_file_type, li_pixel_type

s20 = of_get_app_setting("set_20","I")


if of_get_app_setting("set_80","I") = 1 then
	lb_showsetup = true
else
	lb_showsetup = false
end if

if gi_scan_format > 0 then //scan format option from setting set_29 
	li_file_type = gi_scan_format
else	
	li_file_type = 1  //B&W default
end if
//Image type for Global 360 : 1 - black and white; 2- grayscale 16; 4 - grayscale 256; 8 - color 256 palettized; 16 - true color 24-bit RGB; 32 - color 16-bit palettized
CHOOSE CASE li_file_type
	CASE 1
		li_pixel_type = 1 //Black and white Color
	CASE 2, 4
		li_pixel_type = 0	 //Gray Color		
	CASE 8, 16, 24, 32
		li_pixel_type = 2 //True Color
	CASE ELSE
		li_pixel_type = -1 //Default
END CHOOSE




IF of_selectimagesource() THEN //Show all available TWAIN compatible devices on the system.
	//Set image pixel type	
	ole_scan.Object.PixelType = li_pixel_type
	
	ole_scan.object.ClearImageBuffer=true  //clear the image buffer for each time scan the image.
	
		//Set duplex mode		
	if s20 = 2 then //maha added 041805 as trap because it fails on some scanners
		open(w_duplex_setting)
		s20 = message.doubleparm
		if s20 = 1 then
			ole_scan.Object.DuplexEnabled = FALSE
		elseif s20 = 2 then
			ole_scan.Object.DuplexEnabled = TRUE
		else //0
			//don't send SetScanCapability
		end if
	end if	
	
	//Set others
	ole_scan.Object.View = 5 //full
	
	IF lb_showsetup THEN of_showtwainui(True)
	IF of_scan() = 1 THEN  //Start scanning
		Yield()
		IF Messagebox("Scanning","Did the scanning complete properly?",Question!,yesno!,2) = 1 THEN 
			of_save(as_file, 'pdf')
		ELSE
			Return -1
		END IF
	ELSE
		Return -1
	END IF
END IF

IF lb_showsetup THEN
	IF not fileexists(as_file) THEN
		MessageBox("Scanning","The file "+ as_file + " was not successfully scanned")				
		Return -1
	END IF
END IF

Return 1
end function

public function integer of_save (string as_file, string as_ext);//////////////////////////////////////////////////////////////////////
// $<function>of_saveallpage2pdf
// $<arguments>
//		String as_file
//		String as_ext
// $<returns> integer 1- success; -1 - Failed
// $<description>Save 
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.20.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
Int li_ret, li_cnt
String ls_Rtn
String ls_path

//Check write right on the folder
ls_Rtn = f_ExaWriteRight(as_file)
if Len(ls_Rtn) > 0 then
	if gb_recordlog = false then
		MessageBox(as_file,ls_Rtn, Exclamation!)
	else
		gs_errmsg = ls_Rtn
	end if
	Return -1
end if

ls_path = mid(as_file, 1, lastpos(as_file, '.') - 1)

TRY
	li_ret = 0
	Do While li_ret = 0
		//Yield()
		sleep(100)
		li_ret = ole_scan.object.Save(ls_path, as_ext)
		li_cnt ++
		If li_cnt > 5 Then Exit
	Loop
CATCH (RUNTIMEERROR E)
	li_ret = -1
END TRY	

Return li_ret
end function

public function boolean of_selectimagesource ();//////////////////////////////////////////////////////////////////////
// $<function>of_selectimagesource
// $<arguments>
// $<returns> NONE
// $<description>Show all available TWAIN compatible devices on the system.
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.13.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////

Return ole_scan.object.SelectImageSource()
end function

public subroutine of_showtwainui (boolean ab_set);//////////////////////////////////////////////////////////////////////
// $<function>of_showtwainui
// $<arguments>
//		Boolean ab_set
// $<returns> (None)
// $<description>Enable/Disable to show the twain UI
//////////////////////////////////////////////////////////////////////
//Added by (APPEON) Harry 11.22.2017 (V161 Storage of Documents as PDFs)
//////////////////////////////////////////////////////////////////////
ole_scan.object.ShowTwainUI = ab_set
end subroutine

on w_scan_cp.create
this.hpb_1=create hpb_1
this.st_1=create st_1
this.p_1=create p_1
this.ole_scan=create ole_scan
this.Control[]={this.hpb_1,&
this.st_1,&
this.p_1,&
this.ole_scan}
end on

on w_scan_cp.destroy
destroy(this.hpb_1)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.ole_scan)
end on

event open;if AppeonGetClientType() = "PB" then
	p_1.PictureName = gs_current_path + "\searchapp.gif"
end if

Timer(1)

SetPointer( HourGlass! )
end event

event timer;hpb_1.stepit( )
end event

event closequery;this.hpb_1.position = 100
end event

type hpb_1 from hprogressbar within w_scan_cp
integer x = 41
integer y = 192
integer width = 1554
integer height = 64
unsignedinteger maxposition = 100
unsignedinteger position = 10
integer setstep = 10
end type

type st_1 from statictext within w_scan_cp
integer x = 224
integer y = 76
integer width = 1993
integer height = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Start scanning..."
boolean focusrectangle = false
end type

type p_1 from picture within w_scan_cp
integer x = 69
integer y = 44
integer width = 146
integer height = 128
boolean originalsize = true
string picturename = "searchapp.gif"
boolean focusrectangle = false
end type

type ole_scan from olecustomcontrol within w_scan_cp
event click ( )
event dblclick ( )
event mousedown ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mousemove ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event mouseup ( integer button,  integer shift,  long ocx_x,  long ocx_y )
event endscan ( )
event ocrrecognized ( boolean bsuccess )
event directscanedpage ( string strfilename )
event scanningerror ( )
event endallscan ( )
event directscanedallpage ( )
integer x = 649
integer y = 84
integer width = 78
integer height = 48
integer taborder = 20
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
string binarykey = "w_scan_cp.win"
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
end type

event constructor;This.object.licensekey = '9970'
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_scan_cp.bin 
2D00000c00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffd00000004fffffffefffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff0000000300000000000000000000000000000000000000000000000000000000422e8b9001d364f800000003000001c00000000000500003004c004200430049004e0045004500530045004b000000590000000000000000000000000000000000000000000000000000000000000000000000000002001cffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000440000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000002001affffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000002000000d400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000101001a000000020000000100000004831a607c4f8e77ca05987fb3fa63ac7400000000422e8b9001d364f8422e8b9001d364f800000000000000000000000000000001fffffffe000000030000000400000005fffffffefffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
29ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f004300790070006900720068006700200074006300280020002900300032003500300056002000730069006f00630020006d006f00530074006600610077006500720000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fffe00020106831a607c4f8e77ca05987fb3fa63ac7400000001fb8f0821101b01640008ed8413c72e2b00000030000000a40000000500000100000000300000010100000038000001020000004000000103000000480000000000000050000000030001000000000003000001c2000000030000013e00000003000000000000000500000000000000010001030000000c0074735f00706b636f73706f72000101000000090078655f00746e65740102007800090000655f00006e65747800007974090000015f00000073726576006e6f69000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010000000001c20000013e0000000000000064000000000000000064040000006f6d655000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000006f00430074006e006e00650073007400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001020012ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000060000002a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_scan_cp.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
