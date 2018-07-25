$PBExportHeader$n_bitmap.sru
forward
global type n_bitmap from nonvisualobject
end type
type bitmapfileheader from structure within n_bitmap
end type
type bitmapinfoheader from structure within n_bitmap
end type
type bitmapinfo from structure within n_bitmap
end type
end forward

type bitmapfileheader from structure
	integer		bftype
	long		bfsize
	integer		bfreserved1
	integer		bfreserved2
	long		bfoffbits
end type

type bitmapinfoheader from structure
	long		bisize
	long		biwidth
	long		biheight
	integer		biplanes
	integer		bibitcount
	long		bicompression
	long		bisizeimage
	long		bixpelspermeter
	long		biypelspermeter
	long		biclrused
	long		biclrimportant
end type

type bitmapinfo from structure
	bitmapinfoheader		bmiheader
	unsignedlong		bmicolors[]
end type

global type n_bitmap from nonvisualobject autoinstantiate
end type

type prototypes
Function ulong GetLastError( ) Library "kernel32.dll"

Function ulong FormatMessage( &
	ulong dwFlags, &
	ulong lpSource, &
	ulong dwMessageId, &
	ulong dwLanguageId, &
	Ref string lpBuffer, &
	ulong nSize, &
	ulong Arguments &
	) Library "kernel32.dll" Alias For "FormatMessageW"

Function long GetTempPath ( &
	long nBufferLength, &
	Ref string lpBuffer &
	) Library "kernel32.dll" Alias For "GetTempPathW"

Function long GetDesktopWindow ( &
	) Library "user32.dll"

Function ulong GetDC ( &
	long hWnd &
	) Library "user32.dll"

Function ulong CreateCompatibleDC ( &
	ulong hdc &
	) Library "gdi32.dll"

Function ulong CreateCompatibleBitmap ( &
	ulong hdc, &
	long nWidth, &
	long nHeight &
	) Library "gdi32.dll"

Function ulong SelectObject ( &
	ulong hdc, &
	ulong hgdiobj &
	) Library "gdi32.dll"

Function boolean BitBlt ( &
	ulong hdcDest, &
	long nXDest, &
	long nYDest, &
	long nWidth, &
	long nHeight, &
	ulong hdcSrc, &
	long nXSrc, &
	long nYSrc, &
	long dwRop &
	) Library "gdi32.dll"

Function boolean StretchBlt ( &
	ulong hdcDest, &
	long nXOriginDest, &
	long nYOriginDest, &
	long nWidthDest, &
	long nHeightDest, &
	ulong hdcSrc, &
	long nXOriginSrc, &
	long nYOriginSrc, &
	long nWidthSrc, &
	long nHeightSrc, &
	long dwRop &
	) Library "gdi32.dll"

Function long GetDIBits ( &
	ulong hdc, &
	ulong hbmp, &
	uint uStartScan, &
	uint cScanLines, &
	Ref blob lpvBits, &
	Ref bitmapinfo lpbi, &
	uint uUsage &
	) Library "gdi32.dll"

Function long GetDIBits ( &
	ulong hdc, &
	ulong hbmp, &
	uint uStartScan, &
	uint cScanLines, &
	ulong lpvBits, &
	ref bitmapinfo lpbi, &
	uint uUsage &
	) Library "gdi32.dll"

Subroutine CopyBitmapFileHeader ( &
	Ref blob Destination, &
	bitmapfileheader Source, &
	long Length &
	) Library "kernel32.dll" Alias For "RtlMoveMemory"

Subroutine CopyBitmapInfo ( &
	Ref blob Destination, &
	bitmapinfo Source, &
	long Length &
	) Library "kernel32.dll" Alias For "RtlMoveMemory"

Function boolean DeleteDC ( &
	ulong hdc &
	) Library "gdi32.dll"

Function long ReleaseDC ( &
	long hWnd, &
	ulong hDC &
	) Library "user32.dll"

Function boolean OpenClipboard ( &
	long hWndNewOwner &
	) Library "user32.dll"

Function boolean EmptyClipboard ( &
	) Library "user32.dll"

Function boolean CloseClipboard ( &
	) Library "user32.dll"

Function ulong SetClipboardData ( &
	uint uFormat, &
	ulong hMem &
	) Library "user32.dll"

Function long CreateFile ( &
	string lpFileName, &
	ulong dwDesiredAccess, &
	ulong dwShareMode, &
	ulong lpSecurityAttributes, &
	ulong dwCreationDisposition, &
	ulong dwFlagsAndAttributes, &
	ulong hTemplateFile &
	) Library "kernel32.dll" Alias For "CreateFileW"

Function boolean WriteFile ( &
	long hFile, &
	blob lpBuffer, &
	ulong nNumberOfBytesToWrite, &
	Ref ulong lpNumberOfBytesWritten, &
	ulong lpOverlapped &
	) Library "kernel32.dll"

Function boolean CloseHandle ( &
	long hObject &
	) Library "kernel32.dll"

end prototypes

type variables
Constant uint CF_BITMAP = 2
Constant uint DIB_PAL_COLORS = 1
Constant uint DIB_RGB_COLORS = 0
Constant integer BITMAPTYPE = 19778

// raster operation codes
Constant Long BLACKNESS			= 66
Constant Long CAPTUREBLT		= 1073741824
Constant Long DSTINVERT			= 5570569
Constant Long MERGECOPY			= 12583114
Constant Long MERGEPAINT		= 12255782
Constant Long NOMIRRORBITMAP	= 2147483648
Constant Long NOTSRCCOPY		= 3342344
Constant Long NOTSRCERASE		= 1114278
Constant Long PATCOPY			= 15728673
Constant Long PATINVERT			= 5898313
Constant Long PATPAINT			= 16452105
Constant Long SRCAND				= 8913094
Constant Long SRCCOPY			= 13369376
Constant Long SRCERASE			= 4457256
Constant Long SRCINVERT			= 6684742
Constant Long SRCPAINT			= 15597702
Constant Long WHITENESS			= 16711778

end variables

forward prototypes
public function string of_gettemppath ()
public function unsignedlong of_writeblob (string as_filename, blob ablb_bitmap)
public function blob of_controlcapture (dragobject a_object, boolean ab_clipboard)
public function blob of_screencapture (boolean ab_clipboard)
public function blob of_windowcapture (window a_window, boolean ab_clipboard)
public function string of_getlasterror ()
public function blob of_capture (long al_hwnd, unsignedlong al_xpos, unsignedlong al_ypos, unsignedlong al_width, unsignedlong al_height, boolean ab_clipboard)
public function blob of_scroll_capturescreen (olecustomcontrol aol_control, statictext ast_textnote)
end prototypes

public function string of_gettemppath ();// returns temp directory name

String ls_path
Long ll_rtn, ll_buflen

ll_buflen = 250
ls_path = Space(ll_buflen)

ll_rtn = GetTempPath(ll_buflen, ls_path)

Return ls_path

end function

public function unsignedlong of_writeblob (string as_filename, blob ablb_bitmap);Constant Long INVALID_HANDLE_VALUE = -1
Constant ULong GENERIC_WRITE		= 1073741824
Constant ULong FILE_SHARE_WRITE	= 2
Constant ULong CREATE_ALWAYS		= 2

Long ll_file
ULong lul_length, lul_written
Boolean lb_rtn

// open file for write
ll_file = CreateFile(as_filename, GENERIC_WRITE, &
					FILE_SHARE_WRITE, 0, CREATE_ALWAYS, 0, 0)
If ll_file = INVALID_HANDLE_VALUE Then
	Return -999
End If

// write file to disk
lul_length = Len(ablb_bitmap)
lb_rtn = WriteFile(ll_file, ablb_bitmap, &
					lul_length, lul_written, 0)

// close the file
CloseHandle(ll_file)

Return 0

end function

public function blob of_controlcapture (dragobject a_object, boolean ab_clipboard);// capture bitmap of a control

PowerObject lpo_parent
Long ll_xpos, ll_ypos, ll_width, ll_height, ll_hWnd

// loop thru parents until a window is found
lpo_parent = a_object.GetParent()
Do While lpo_parent.TypeOf() <> Window! and IsValid (lpo_parent)
	lpo_parent = lpo_parent.GetParent()
Loop

// get handle to window
ll_hWnd = Handle(lpo_parent)

// convert x, y, width and height from PBU to Pixels
ll_xpos   = UnitsToPixels(a_object.X, XUnitsToPixels!)
ll_ypos   = UnitsToPixels(a_object.Y, YUnitsToPixels!)
ll_width  = UnitsToPixels(a_object.width, XUnitsToPixels!)
ll_height = UnitsToPixels(a_object.height, YUnitsToPixels!)

Return this.of_Capture(ll_hWnd, &
					ll_xpos, ll_ypos, ll_width, &
					ll_height, ab_clipboard)

end function

public function blob of_screencapture (boolean ab_clipboard);// capture bitmap of entire screen

Long ll_hWnd, ll_width, ll_height
Environment le_env

// get screen size
GetEnvironment(le_env)
ll_width  = le_env.ScreenWidth
ll_height = le_env.ScreenHeight

// get handle to windows background
ll_hWnd = GetDesktopWindow()

Return this.of_Capture(ll_hWnd, &
					0, 0, ll_width, &
					ll_height, ab_clipboard)

end function

public function blob of_windowcapture (window a_window, boolean ab_clipboard);// capture bitmap of a window

Long ll_xpos, ll_ypos, ll_width, ll_height, ll_hWnd

// get handle to windows background
ll_hWnd = GetDesktopWindow()

// convert x, y, width and height from PBU to Pixels
ll_xpos   = UnitsToPixels(a_window.X, XUnitsToPixels!)
ll_ypos   = UnitsToPixels(a_window.Y, YUnitsToPixels!)
ll_width  = UnitsToPixels(a_window.width, XUnitsToPixels!)
ll_height = UnitsToPixels(a_window.height, YUnitsToPixels!)

Return this.of_Capture(ll_hWnd, &
					ll_xpos, ll_ypos, ll_width, &
					ll_height, ab_clipboard)

end function

public function string of_getlasterror ();// This function returns the most recent API error message

Constant ULong FORMAT_MESSAGE_FROM_SYSTEM = 4096
Constant ULong LANG_NEUTRAL = 0
ULong lul_rtn, lul_error
String ls_msgtext

lul_error = GetLastError()

ls_msgtext = Space(200)

lul_rtn = FormatMessage(FORMAT_MESSAGE_FROM_SYSTEM, 0, &
				lul_error, LANG_NEUTRAL, ls_msgtext, 200, 0)

Return ls_msgtext

end function

public function blob of_capture (long al_hwnd, unsignedlong al_xpos, unsignedlong al_ypos, unsignedlong al_width, unsignedlong al_height, boolean ab_clipboard);// capture bitmap and return as blob

BitmapInfo lstr_Info
BitmapFileHeader lstr_Header
Blob lblb_header, lblb_info, lblb_bitmap
ULong lul_hdc, lul_hdcMem, lul_hBitmap
Integer li_pixels
Boolean lb_result

// Get the device context of window and allocate memory
lul_hdc = GetDC(al_hWnd)
lul_hdcMem = CreateCompatibleDC(lul_hdc)
lul_hBitmap = CreateCompatibleBitmap(lul_hdc, al_width, al_height)

If lul_hBitmap <> 0 Then
	// Select an object into the specified device context
	SelectObject(lul_hdcMem, lul_hBitmap)
	// Copy the bitmap from the source to the destination

//   lb_result = BitBlt(lul_hdcMem, 0, 0, al_width, al_height, &
//									lul_hdc, al_xpos, al_ypos, SRCCOPY)
   lb_result = StretchBlt(lul_hdcMem, 0, 0, al_width, al_height, &
									lul_hdc, al_xpos, al_ypos, al_width, al_height, SRCCOPY)

	// try to store the bitmap into a blob so we can save it
	lstr_Info.bmiHeader.biSize = 40
	// Get the bitmapinfo
	If GetDIBits(lul_hdcMem, lul_hBitmap, 0, al_height, &
							0, lstr_Info, DIB_RGB_COLORS) > 0 Then
		li_pixels = lstr_Info.bmiHeader.biBitCount
		lstr_Info.bmiColors[li_pixels] = 0
		lblb_bitmap = Blob(Space(lstr_Info.bmiHeader.biSizeImage/2))
		// get the actual bits
		GetDIBits(lul_hdcMem, lul_hBitmap, 0, al_height, &
							lblb_bitmap, lstr_Info, DIB_RGB_COLORS) 
		// create a bitmap header
		lstr_Header.bfType = BITMAPTYPE
		lstr_Header.bfSize = lstr_Info.bmiHeader.biSizeImage
		//lstr_Header.bfOffBits = 54 + (li_pixels * 4)   //Commented by (Appeon)Stephen 11.13.2017 -V16.1 Web Capture Redesign
		// copy the header structure to a blob
		lblb_header = Blob(Space(14/2))
		CopyBitmapFileHeader(lblb_header, lstr_Header, 14)
		// copy the info structure to a blob
		//---------Begin Modified by (Appeon)Stephen 11.13.2017 for V16.1 Web Capture Redesign--------
		//lblb_Info = Blob(Space((40  + li_pixels * 4)/2))
		//CopyBitmapInfo(lblb_Info, lstr_Info, 40 + li_pixels * 4)
		lblb_Info = Blob(Space((40  + li_pixels )/2))
		CopyBitmapInfo(lblb_Info, lstr_Info, 40 + li_pixels )
		//---------End Modfiied ------------------------------------------------------

		// add all together and we have a window bitmap in a blob
		lblb_bitmap = lblb_header + lblb_info + lblb_bitmap
	End If

	// paste bitmap to clipboard
	If ab_clipboard Then
		If OpenClipboard(al_hWnd) Then
			EmptyClipboard()
			SetClipboardData(CF_BITMAP, lul_hBitmap)
			CloseClipboard()
		Else
			MessageBox("OpenClipboard Failed", of_GetLastError())
		End If
	End If
End If

// Clean up handles
DeleteDC(lul_hdcMem)
ReleaseDC(al_hWnd, lul_hdc)

Return lblb_bitmap

end function

public function blob of_scroll_capturescreen (olecustomcontrol aol_control, statictext ast_textnote);//====================================================================
//$<Function>: of_Scroll_CaptureScreen
//$<Arguments>:
//olecustomcontrol
//statictext
//$<Return>:  blob
//$<Description>: 
//$<Author>: (Appeon) Gavin 11.08.2017 (V16.1 Web Capture Redesign)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

BitmapInfo lstr_Info
BitmapFileHeader lstr_Header
Blob lblb_header, lblb_info, lblb_bitmap
ULong lul_hdc, lul_hdcMem, lul_hBitmap, lul_hdc_st, lul_hdcMem_st, ll_hwnd_st
Integer li_pixels
Boolean lb_result
long ll_top , ll_left, ll_nwidth, ll_nheight, ll_rwidth, ll_rheight, ll_stx, ll_sty, ll_stheight
long ll_mod, ll_k, ll_count, ll_i, ll_Size, ll_cx, ll_cy
blob lbl_Data
long ll_xpos, ll_ypos, ll_width, ll_height, ll_hWnd, ll_dxpos, ll_dypos		
		

If Not IsValid( aol_control ) Then return lblb_bitmap		
		
aol_control.object.document.parentwindow.scrollto( 0, 0 )
		
ll_nwidth = aol_control.object.document.documentElement.scrollwidth

ll_nheight = aol_control.object.document.documentElement.scrollheight

ll_rwidth = aol_control.object.document.documentElement.clientwidth

ll_rheight = aol_control.object.document.documentElement.clientheight - 10


ll_count = ll_nheight / ll_rheight

ll_mod = mod( ll_nheight, ll_rheight )

	
ll_xpos   = UnitsToPixels( aol_control.X, XUnitsToPixels!)  
ll_ypos   = UnitsToPixels( aol_control.Y, YUnitsToPixels!)
ll_width  = UnitsToPixels( aol_control.width, XUnitsToPixels!)
ll_height = UnitsToPixels( aol_control.height, YUnitsToPixels!)

ll_hWnd = Handle( aol_control )


ll_width = ll_rwidth  
ll_height = ll_rheight// - 10

ll_ypos = 1

ll_Size =1

ll_stx = UnitsToPixels( ast_textnote.X, XUnitsToPixels!)  
ll_sty   = UnitsToPixels( ast_textnote.Y, YUnitsToPixels!)
if ast_textnote.Height < 168 Then 
	ll_stheight = UnitsToPixels( ast_textnote.Height, YUnitsToPixels! )
	ll_ypos = ll_ypos + 3
Else
	ll_stheight = UnitsToPixels( 168, YUnitsToPixels! )
End If

ll_dxpos = 0
ll_dypos = 0

// Get the device context of window and allocate memory
lul_hdc = GetDC(ll_hWnd)
lul_hdcMem = CreateCompatibleDC(lul_hdc)
ll_nheight = ll_nheight + ll_stheight
lul_hBitmap = CreateCompatibleBitmap(lul_hdc, ll_width, ll_nheight   )

ll_hwnd_st = Handle( ast_TextNote )
lul_hdc_st = GetDC( ll_hwnd_st)
//lul_hdcMem_st = CreateCompatibleDC(lul_hdc_st)

//
	
									
If lul_hBitmap <> 0 Then
	// Select an object into the specified device context
	SelectObject(lul_hdcMem, lul_hBitmap)
	// Copy the bitmap from the source to the destination
	 lb_result = StretchBlt(lul_hdcMem, ll_dxpos, ll_dypos, ll_width, ll_stheight, &
									lul_hdc_st, ll_stx, ll_sty, ll_width, ll_stheight, SRCCOPY)
									
									
		ll_dypos = ll_dypos + ll_stheight 
		//bitmap		
		 lb_result = StretchBlt(lul_hdcMem, ll_dxpos, ll_dypos, ll_width, ll_height, &
									lul_hdc, ll_xpos, ll_ypos, ll_width, ll_height, SRCCOPY)
		ll_dypos = ll_dypos + ll_height  
		for ll_k = 2 to ll_count
		
			ll_dxpos =0
			
			aol_control.object.document.parentwindow.scrollby( 0, ll_rheight  )
			
			 lb_result = StretchBlt(lul_hdcMem, ll_dxpos, ll_dypos, ll_width, ll_height, &
									lul_hdc, ll_xpos, ll_ypos, ll_width, ll_height, SRCCOPY)

			ll_dypos = ll_dypos + ll_height  
		next
		if( ll_mod > 0 ) then 
			aol_control.object.document.parentwindow.scrollby( 0, ll_rheight )
			
			if ast_textnote.Height < 168 Then 
				ll_ypos =  ll_rheight - ll_mod  + 13
			Else
				ll_ypos =  ll_rheight - ll_mod + 10
			End If
			//ll_mod = ll_mod -10
			 lb_result = StretchBlt(lul_hdcMem, ll_dxpos, ll_dypos, ll_width, ll_mod, &
									lul_hdc, ll_xpos, ll_ypos, ll_width, ll_mod, SRCCOPY)
			
		End If

	// try to store the bitmap into a blob so we can save it
	lstr_Info.bmiHeader.biSize = 40
	// Get the bitmapinfo
	If GetDIBits(lul_hdcMem, lul_hBitmap, 0, ll_nheight, &
							0, lstr_Info, DIB_RGB_COLORS) > 0 Then
		li_pixels = lstr_Info.bmiHeader.biBitCount
		lstr_Info.bmiColors[li_pixels] = 0
		lblb_bitmap = Blob(Space(lstr_Info.bmiHeader.biSizeImage/2))
		// get the actual bits
		GetDIBits(lul_hdcMem, lul_hBitmap, 0, ll_nheight, &
							lblb_bitmap, lstr_Info, DIB_RGB_COLORS) 
		// create a bitmap header
		lstr_Header.bfType = BITMAPTYPE
		lstr_Header.bfSize = lstr_Info.bmiHeader.biSizeImage
		//lstr_Header.bfOffBits = 54 + (li_pixels * 4)
		// copy the header structure to a blob
		lblb_header = Blob(Space(14/2))
		CopyBitmapFileHeader(lblb_header, lstr_Header, 14)
		// copy the info structure to a blob
//		lblb_Info = Blob(Space((40  + li_pixels * 4)/2))
//		CopyBitmapInfo(lblb_Info, lstr_Info, 40 + li_pixels * 4)
		lblb_Info = Blob(Space((40  + li_pixels )/2))
		CopyBitmapInfo(lblb_Info, lstr_Info, 40 + li_pixels )
		// add all together and we have a window bitmap in a blob
		lblb_bitmap = lblb_header + lblb_info + lblb_bitmap
	End If
	
End If

// Clean up handles
DeleteDC(lul_hdcMem)
ReleaseDC(ll_hWnd, lul_hdc)

ReleaseDC(ll_hwnd_st, lul_hdc)

Return lblb_bitmap

 
end function

on n_bitmap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_bitmap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

