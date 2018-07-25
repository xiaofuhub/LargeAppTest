$PBExportHeader$nvo_commdlg.sru
$PBExportComments$Common dialog encapsulation
forward
global type nvo_commdlg from nonvisualobject
end type
type openfilename from structure within nvo_commdlg
end type
type printdlg from structure within nvo_commdlg
end type
type devmode from structure within nvo_commdlg
end type
type devnames from structure within nvo_commdlg
end type
type choosefont from structure within nvo_commdlg
end type
type logfont from structure within nvo_commdlg
end type
type printer_info_5 from structure within nvo_commdlg
end type
type psdevnames from structure within nvo_commdlg
end type
end forward

type OPENFILENAME from structure
	long		lstructsize
	long		hwndowner
	long		hinstance
	long		lpstrfilter
	long		lpstrcustomfilter
	long		nMaxCustomFilter
	long		nFilterIndex
	long		lpstrFile
	long		nMaxFile
	long		lpstrFileTitle
	long		nMaxFileTitle
	long		lpstrInitialDir
	long		lpstrTitle
	long		Flags
	integer		nFileOffset
	integer		nFileExtension
	long		lpstrDefExt
	long		lCustData
	long		lpfnHook
	long		lpTemplateName
end type

type PRINTDLG from structure
	long		lStructSize
	long		hWndOwner
	long		hDevMode
	long		hDevNames
	long		hDC
	long		Flags
	integer		nFromPage
	integer		nToPage
	integer		nMinPage
	integer		nMaxPage
	integer		nCopies
	long		hInstance
	long		lCustData
	long		lpfnPrintHook
	long		lpfnSetupHook
	long		lpPrintTemplateName
	long		lpSetupTemplateName
	long		hPrintTemplate
	long		hSetupTemplate
end type

type devmode from structure
	character		dmDeviceName[32]
	integer		dmSpecVersion
	integer		dmDriverVersion
	integer		dmSize
	integer		dmDriverExtra
	long		dmFields
	integer		dmOrientation
	integer		dmPaperSize
	integer		dmPaperLength
	integer		dmPaperWidth
	integer		dmScale
	integer		dmCopies
	integer		dmDefaultSource
	integer		dmPrintQuality
	integer		dmColor
	integer		dmDuplex
	integer		dmYResolution
	integer		dmTTOption
	integer		dmCollate
	character		dmFormName[32]
	integer		dmLogPixels
	long		dmBitsPerPel
	long		dmPelsWidth
	long		dmPelsHeight
	long		dmDisplayFlags
	long		dmDisplayFrequency
	long		dmICMMethod
	long		dmICMIntent
	long		dmMediaType
	long		dmDitherType
	long		dmReserved1
	long		dmReserved2
end type

type devnames from structure
	integer		wDriverOffset
	integer		wDeviceOffset
	integer		wOutputOffset
	integer		wDefault
end type

type CHOOSEFONT from structure
	long		lStructSize
	long		hWndOwner
	long		hDC
	long		lpLogFont
	long		iPointSize
	long		Flags
	long		RGBColors
	long		lCustData
	long		lpfnHook
	long		lpTemplateName
	long		hInstance
	long		lpszStyle
	integer		nFontType
	integer		___MISSING_ALIGNMENT__
	long		nSizeMin
	long		nSizeMax
end type

type logfont from structure
	long		lfheight
	long		lfwidth
	long		lfescapement
	long		lforientation
	long		lfweight
	character		lfitalic
	character		lfunderline
	character		lfstrikeout
	character		lfcharset
	character		lfoutprecision
	character		lfclipprecision
	character		lfquality
	character		lfpitchandfamily
	character		lffacename[32]
end type

type printer_info_5 from structure
	unsignedlong		ul_pprintername
	unsignedlong		ul_pportname
	unsignedlong		ul_attributes
	unsignedlong		ul_devicenotselectedtimeout
	unsignedlong		ul_transmissionretrytimeout
end type

type PSDevNames from structure
	string		s_printername
	string		s_printerport
	string		s_printerdriver
end type

global type nvo_commdlg from nonvisualobject autoinstantiate
end type

type prototypes
// Common Dialog External Functions
Function long GetOpenFileNameA(REF OPENFILENAME OpenFileName) library "comdlg32.dll" alias for "GetOpenFileNameA;Ansi"


Function long GetSaveFileNameA(REF OPENFILENAME SaveFileName) library "comdlg32.dll" alias for "GetSaveFileNameA;Ansi"
Function long PrintDlgA(REF PRINTDLG PrintDlg) library "comdlg32.dll" alias for "PrintDlgA;Ansi"
Function long ChooseFontA(REF CHOOSEFONT ChooseFont) library "comdlg32.dll" alias for "ChooseFontA;Ansi"

// Memory Functions
Function long GetDevMode(REF DEVMODE Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory;Ansi"
Function long GetDevNames(REF DEVNAMES Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory;Ansi"
Function long GetLogFont(REF LOGFONT Destination, long Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory;Ansi"
Function long PutLogFont(long Destination, REF LOGFONT Source, long Size) library "kernel32.dll" Alias For "RtlMoveMemory;Ansi"

Function long StrCopy(long Destination, REF string Source, long Size) library "kernel32.dll"  Alias for "RtlMoveMemory;Ansi"
Function long LocalAlloc(long Flags, long Bytes) library "kernel32.dll"
Function long LocalFree(long MemHandle) library "kernel32.dll"
Function long CommDlgExtendedError() library "comdlg32.dll"
Function long lstrcpy(long Destination, REF string Source) library "kernel32.dll" alias for "lstrcpy;Ansi"
Function long LocalLock(long Handle) library "kernel32.dll"
Function long LocalUnlock(long Handle) library "kernel32.dll"

// Misc Functions
Function long GetWindowsDirectoryA(REF string Buffer, long Size) library "kernel32.dll" alias for "GetWindowsDirectoryA;Ansi"

//EnumPrinters
function long EnumPrintersA (ULONG a_flags, ULONG  a_name, ULONG a_level,  REF POWEROBJECT a_Printer_Info_5[],  ULONG c_cbBuf,   REF ULONG a_pcbNeeded,  REF ULONG  a_pcReturned ) LIBRARY "WINSPOOL.DRV" alias for "EnumPrintersA;Ansi"
end prototypes

type variables
// *****************************************************************
// All Dialogs members
// *****************************************************************
PUBLIC long Flags = 0		// Dialog Flags
PUBLIC long hWndParent = 0		// Parent Window

// *****************************************************************
// Open & Save Dialog public members
// *****************************************************************
Public:
string Filter = ""		// description1~tfilter1~tdescription2~tfilter2
integer FilterIndex = 1	// Default filter index
string InitialDir  = "" 		// Default directory
string Title = ""		// Dialog Title
PROTECTEDWRITE string Filename = "" 		// returns selected file
PROTECTEDWRITE string Files[]		// Selected Files
PROTECTEDWRITE string PathName		// Path
PROTECTEDWRITE integer FileCount		// Number of selected files

// Flags constants
CONSTANT long OFN_READONLY			= 1
CONSTANT long OFN_OVERWRITEPROMPT		= 2
CONSTANT long OFN_HIDEREADONLY		= 4
CONSTANT long OFN_NOCHANGEDIR		= 8
CONSTANT long OFN_SHOWHELP			= 16
CONSTANT long OFN_ENABLEHOOK			= 32
CONSTANT long OFN_ENABLETEMPLATE		= 64
CONSTANT long OFN_ENABLETEMPLATEHANDLE	= 128
CONSTANT long OFN_NOVALIDATE			= 256
CONSTANT long OFN_ALLOWMULTISELECT		= 512
CONSTANT long OFN_EXTENSIONDIFFERENT		= 1024
CONSTANT long OFN_PATHMUSTEXIST		= 2048
CONSTANT long OFN_FILEMUSTEXIST		= 4096
CONSTANT long OFN_CREATEPROMPT		= 8192
CONSTANT long OFN_SHAREAWARE			= 16384
CONSTANT long OFN_NOREADONLYRETURN		= 32768
CONSTANT long OFN_NOTESTFILECREATE		= 65536
CONSTANT long OFN_NONETWORKBUTTON		= 131072
CONSTANT long OFN_NOLONGNAMES		= 262144
CONSTANT long OFN_EXPLORER			= 524288
CONSTANT long OFN_NODEREFERENCELINKS	= 1048576
CONSTANT long OFN_LONGNAMES			= 2097152

// *****************************************************************
// Print dialog public members
// *****************************************************************
integer FromPage	= 1
integer ToPage	= 1
integer MinPage 	= 1
integer MaxPage 	= 0
PROTECTEDWRITE integer Copies = 1 

// Flags constants
CONSTANT long PD_ALLPAGES			= 0
CONSTANT long PD_SELECTION 			= 1
CONSTANT long PD_PAGENUMS 			= 2
CONSTANT long PD_NOSELECTION 			= 4
CONSTANT long PD_NOPAGENUMS 			= 8
CONSTANT long PD_COLLATE			= 16
CONSTANT long PD_PRINTTOFILE 			= 32
CONSTANT long PD_PRINTSETUP 			= 64
CONSTANT long PD_NOWARNING 			= 128
CONSTANT long PD_RETURNDC 			= 256
CONSTANT long PD_RETURNIC 			= 512
CONSTANT long PD_RETURNDEFAULT	 	= 1024
CONSTANT long PD_SHOWHELP 			= 2048
CONSTANT long PD_ENABLEPRINTHOOK 		= 4096
CONSTANT long PD_ENABLESETUPHOOK 		= 8192
CONSTANT long PD_ENABLEPRINTTEMPLATE 	= 16384
CONSTANT long PD_ENABLESETUPTEMPLATE	= 32768
CONSTANT long PD_ENABLEPRINTTEMPLATEHANDLE	= 65536
CONSTANT long PD_ENABLESETUPTEMPLATEHANDLE = 131072
CONSTANT long PD_USEDEVMODECOPIES 		= 262144
CONSTANT long PD_USEDEVMODECOPIESANDCOLLATE= 262144
CONSTANT long PD_DISABLEPRINTTOFILE		= 524288 
CONSTANT long PD_HIDEPRINTTOFILE		= 1048576 
CONSTANT long PD_NONETWORKBUTTON 		= 2097152

// *****************************************************************
// Font dialog public members
// *****************************************************************
long RGBColors	= 0
integer FontType	= 0
integer SizeMin	= 0
integer SizeMax	= 0
string FaceName	= ""
long  Height	= 0
long  Weight	= 0
boolean Italic	= False
boolean Underline	= False
boolean StrikeOut	= False

// Flags constants
CONSTANT long CF_SCREENFONTS 			= 1
CONSTANT long CF_PRINTERFONTS 			= 2
CONSTANT long CF_BOTH 				= 3
CONSTANT long CF_SHOWHELP 			= 4
CONSTANT long CF_ENABLEHOOK 			= 8
CONSTANT long CF_ENABLETEMPLATE 		= 16
CONSTANT long CF_ENABLETEMPLATEHANDLE 	= 32
CONSTANT long CF_INITTOLOGFONTSTRUCT 		= 64
CONSTANT long CF_USESTYLE 			= 128
CONSTANT long CF_EFFECTS 			= 256
CONSTANT long CF_APPLY 				= 512
CONSTANT long CF_ANSIONLY 			= 1024
CONSTANT long CF_SCRIPTSONLY 			= CF_ANSIONLY
CONSTANT long CF_NOVECTORFONTS 		= 2048
CONSTANT long CF_NOOEMFONTS 			= 4096
CONSTANT long CF_NOSIMULATIONS 		= 8192
CONSTANT long CF_LIMITSIZE			= 16384
CONSTANT long CF_FIXEDPITCHONLY 		= 32768
CONSTANT long CF_WYSIWYG 			= 65536
CONSTANT long CF_FORCEFONTEXIST 		= 131072
CONSTANT long CF_SCALABLEONLY			= 262144
CONSTANT long CF_TTONLY 			= 524288
CONSTANT long CF_NOFACESEL			= 1048576
CONSTANT long CF_NOSTYLESEL 			= 2097152 
CONSTANT long CF_NOSIZESEL 			= 4194304
CONSTANT long CF_SELECTSCRIPT 			= 8388608
CONSTANT long CF_NOSCRIPTSEL 			= 16777216
CONSTANT long CF_NOVERTFONTS 			= 33554432

// FontType constants
CONSTANT integer BOLD_FONTTYPE 	= 256
CONSTANT integer ITALIC_FONTTYPE 	= 512
CONSTANT integer REGULAR_FONTTYPE 	= 1024
CONSTANT integer SCREEN_FONTTYPE 	= 8192
CONSTANT integer PRINTER_FONTTYPE 	= 16384
CONSTANT integer SIMULATED_FONTTYPE 	= 32768

// Object private constants
Private:
CONSTANT integer LMEM_ZEROINIT = 64 // Alloc constant => Zero allocated memort

// Open Dialog Special Constants
CONSTANT integer MAXFILENAME     = 260
CONSTANT integer MAXPATHNAME   = 260
CONSTANT integer MAXFILES   = 100

// EnumPrinters constants
constant ulong PRINTER_ENUM_FLAGS = 14
constant ulong SIZE_PRINTER_INFO_5 = 20
constant ulong  PRINTER_ENUM_NAME = 8
end variables

forward prototypes
public function boolean opendialog ()
public function boolean printdialog ()
public subroutine setprinter (string printername, string driver, string port)
public function boolean savedialog ()
public function boolean fontdialog ()
end prototypes

public function boolean opendialog ();
/*
This function displays the open dialog box available in the COMDLG32 library..

Members available:

string Filter			=> This member allows to specify a list of tab separated filters;
integer FilterIndex	=> Default filter index
string InitialDir		=> Default directory (for the dialog box)
string Title			=> Dialog title
long Flags				=> Dialog Flags
string Filename 		=> returns selected file
string Files[]			=> Array with the list of selected files
string PathName		=> Path of the files
integer FileCount		=> Number of selected files
*/

OPENFILENAME OpenFileName
string ls_Token, Empty[]
integer li_TabPos, li_Start, li_rtn

OpenFileName.lStructSize	= 76
OpenFileName.hWndOwner		= Handle(W_MDI) //hWndParent
OpenFileName.hInstance		= 0
OpenFileName.lpstrFilter	= LocalAlloc(LMEM_ZEROINIT,Len(Filter) + 2) // 2 nulls to signal end
If OpenFileName.lpstrFilter = 0 Then
	MessageBox("Error","Cannot alloc requested memory!",StopSign!,Ok!)
	Return(False)
End If

// Tab separator to Null separator 
li_Start  = 1
li_TabPos = Pos(Filter,"~t",1)
Do While li_TabPos > 0
	ls_Token = Mid(Filter,li_Start,li_TabPos - li_Start)
	StrCopy(OpenFileName.lpstrFilter + (li_Start - 1),ls_Token,Len(ls_Token))
	li_Start		= li_TabPos + 1
	li_TabPos	= Pos(Filter,"~t",li_TabPos + 1)
Loop

ls_Token	= Mid(Filter,li_Start)
StrCopy(OpenFileName.lpstrFilter + (li_Start - 1),ls_Token,Len(ls_Token))


OpenFileName.lpstrCustomFilter	= 0
OpenFileName.nMaxCustomFilter		= 0
OpenFileName.nFilterIndex 			= FilterIndex
OpenFileName.lpstrFile				= LocalAlloc(LMEM_ZEROINIT,MAXFILENAME * MAXFILES) 
OpenFileName.nMaxFile				= MAXFILENAME * MAXFILES
OpenFileName.lpstrFileTitle		= LocalAlloc(0,MAXFILENAME)
OpenFileName.nMaxFileTitle			= MAXFILENAME
OpenFileName.lpstrInitialDir		= LocalAlloc(0,MAXPATHNAME)
StrCopy(OpenFileName.lpstrInitialDir,InitialDir,Len(InitialDir))
OpenFileName.lpstrTitle				= LocalAlloc(0,255)
StrCopy(OpenFileName.lpstrTitle,Title,Len(Title))

//string ls_testfilename
//ls_testfilename = "Philip"
//StrCopy(OpenFileName.lpstrFile,ls_testfilename,Len(ls_testfilename))

OpenFileName.Flags					= OFN_EXPLORER
OpenFileName.nFileOffSet			= 0
OpenFileName.nFileExtension		= 0
OpenFileName.lpstrDefExt			= 0
OpenFileName.lCustData				= 0
OpenFileName.lpfnHook				= 0
OpenFileName.lpTemplateName		= 0

Files = Empty // Reset array
FileCount = 0

li_rtn = GetOpenFileNameA(OpenFileName)
If li_rtn = 1 Then // Pressed OK button
	PathName = Left(String(OpenFileName.lpstrFile,"address"),OpenFileName.nFileOffSet - 1)
	li_Start = 0
	Do
		ls_Token = String(OpenFileName.lpstrFile + OpenFileName.nFileOffSet + li_Start,"address")
		If ls_Token <> "" Then
			FileCount++
			Files[FileCount] = ls_Token
		End If
		li_Start += Len(ls_Token) + 1
	Loop Until ls_Token = ""
	FileName = Files[1]
Else
	FileName  = ""
	FileCount = 0
End If

LocalFree(OpenFileName.lpstrFilter)
LocalFree(OpenFileName.lpstrFile)
LocalFree(OpenFileName.lpstrFileTitle)
LocalFree(OpenFileName.lpstrTitle)
LocalFree(OpenFileName.lpstrInitialDir)

Return(FileCount > 0)
end function

public function boolean printdialog ();/*

Shows the print dialog box... 

Members:

integer FromPage	// Print from page
integer ToPage		// Print to page
integer MinPage	// Min page (smaller page)
integer MaxPage	// Max page (higher page)
PROTECTEDWRITE integer Copies = 1 // Nº of copies to print...

*/

PRINTDLG PrintDlg
DEVMODE DevMode
DEVNAMES DevNames
long pDevNames, pDevMode

PrintDlg.lStructSize 	= 66
PrintDlg.hWndOwner		= hWndParent
PrintDlg.hDevMode			= 0
PrintDlg.hDevNames		= 0
PrintDlg.hDC				= 0
PrintDlg.Flags				= Flags
PrintDlg.nFromPage		= FromPage
PrintDlg.nToPage			= ToPage
PrintDlg.nMinPage			= MinPage
PrintDlg.nMaxPage			= MaxPage
PrintDlg.nCopies			= 0
PrintDlg.hInstance		= 0
PrintDlg.lCustData		= 0
PrintDlg.lpfnPrintHook	= 0
PrintDlg.lpfnSetupHook	= 0
PrintDlg.lpPrintTemplateName = 0
PrintDlg.lpSetupTemplateName = 0
PrintDlg.hPrintTemplate	= 0
PrintDlg.hSetupTemplate = 0

If PrintDlgA(PrintDlg) = 1 Then

	pDevMode = LocalLock(PrintDlg.hDevMode)
	GetDevMode(DevMode,pDevMode,148) // Lock dynamic memory handle
	LocalUnlock(pDevMode) // Unlock dynamic memory handle

	pDevNames = LocalLock(PrintDlg.hDevNames)
	GetDevNames(DevNames,pDevNames,8) // Lock dynamic memory handle
	LocalUnlock(pDevNames) // Unlock dynamic memory handle

	FromPage	= PrintDlg.nFromPage
	ToPage	= PrintDlg.nToPage
	MinPage 	= PrintDlg.nMinPage
	MaxPage 	= PrintDlg.nMaxPage
	Copies	= PrintDlg.nCopies
	
	If Copies = 1 Then // Copies are provided by devmode..
		Copies = DevMode.dmCopies
	End If

	SetPrinter(String(pDevNames + DevNames.wDeviceOffset,"address"), &
				  String(pDevNames + DevNames.wDriverOffset,"address"), &
				  String(pDevNames + DevNames.wOutPutOffset,"address"))

	Return(True)

End If	
	
Return(False)

end function

public subroutine setprinter (string printername, string driver, string port);// Function used to set the default printer based on the choice maded on the print 
// dialog box..
// Arguments:

// PrinterName => Name of the new printer
// Driver => Driver of the new printer
// Port => Port of the new printer

Environment Env
string ls_WinDir

GetEnvironment(Env)

Choose Case Env.OSType
	Case Windows!
		RegistrySet("HKEY_LOCAL_MACHINE\Config\0001\System\CurrentControlSet\Control\Print\Printers", "Default", PrinterName)
		ls_WinDir = Space(260)
		GetWindowsDirectoryA(ls_WinDir,260) // GetWindows directory
		SetProfileString(ls_WinDir + "\WIN.INI","Windows","Device",PrinterName + "," + Driver + "," + Port)
	Case WindowsNT!
		RegistrySet("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Windows","Device", PrinterName + "," + Driver + "," + Port)
End Choose
end subroutine

public function boolean savedialog ();
/*
This function displays the save dialog box available in the COMDLG32 library..

Members available:

string Filter			=> This member allows to specify a list of tab separated filters;
integer FilterIndex	=> Default filter index (returns the selected filter)
string InitialDir		=> Default directory (for the dialog box)
string Title			=> Dialog title
long Flags				=> Dialog Flags
string Filename 		=> returns selected file
string Files[]			=> Array with the list of selected files
string PathName		=> Path of the files
integer FileCount		=> Number of selected files
*/

OPENFILENAME SaveFileName
string ls_Token, Filters[]
integer li_TabPos, li_Start

SaveFileName.lStructSize	= 76
SaveFileName.hWndOwner		= hWndParent
SaveFileName.hInstance		= 0
SaveFileName.lpstrFilter	= LocalAlloc(LMEM_ZEROINIT,Len(Filter) + 2) // 2 nulls to signal end
If SaveFileName.lpstrFilter = 0 Then
	MessageBox("Error","Cannot alloc requested memory!",StopSign!,Ok!)
	Return(False)
End If

// Tab separator to Null separator 
li_Start  = 1
li_TabPos = Pos(Filter,"~t",1)
Do While li_TabPos > 0
	ls_Token = Mid(Filter,li_Start,li_TabPos - li_Start)
	StrCopy(SaveFileName.lpstrFilter + (li_Start - 1),ls_Token,Len(ls_Token))
	li_Start		= li_TabPos + 1
	li_TabPos	= Pos(Filter,"~t",li_TabPos + 1)
	Filters[UpperBound(Filters) + 1] = Mid(ls_Token,2)
Loop
ls_Token	= Mid(Filter,li_Start)
StrCopy(SaveFileName.lpstrFilter + (li_Start - 1),ls_Token,Len(ls_Token))

SaveFileName.lpstrCustomFilter	= 0
SaveFileName.nMaxCustomFilter		= 0
SaveFileName.nFilterIndex 			= FilterIndex
SaveFileName.lpstrFile				= LocalAlloc(LMEM_ZEROINIT,MAXFILENAME) 
SaveFileName.nMaxFile				= MAXFILENAME
SaveFileName.lpstrFileTitle		= LocalAlloc(0,MAXFILENAME)
SaveFileName.nMaxFileTitle			= MAXFILENAME
SaveFileName.lpstrInitialDir		= LocalAlloc(0,MAXPATHNAME)
StrCopy(SaveFileName.lpstrInitialDir,InitialDir,Len(InitialDir))
SaveFileName.lpstrTitle				= LocalAlloc(0,255)
StrCopy(SaveFileName.lpstrTitle,Title,Len(Title))
SaveFileName.Flags					= Flags
SaveFileName.nFileOffSet			= 0
SaveFileName.nFileExtension		= 0
SaveFileName.lpstrDefExt			= 0
SaveFileName.lCustData				= 0
SaveFileName.lpfnHook				= 0
SaveFileName.lpTemplateName		= 0

If GetSaveFileNameA(SaveFileName) = 1 Then // Pressed OK button
	PathName = Left(String(SaveFileName.lpstrFile,"address"),SaveFileName.nFileOffSet - 1)
	FileName = String(SaveFileName.lpstrFile + SaveFileName.nFileOffSet,"address")
	If SaveFileName.nFileExtension = Len(PathName) + Len(FileName) + 1 Then
		FileName += Filters[2 * SaveFileName.nFilterIndex]
	End If
Else
	FileName  = ""
End If

LocalFree(SaveFileName.lpstrFilter)
LocalFree(SaveFileName.lpstrFile)
LocalFree(SaveFileName.lpstrFileTitle)
LocalFree(SaveFileName.lpstrTitle)
LocalFree(SaveFileName.lpstrInitialDir)

Return(FileName <> "")
end function

public function boolean fontdialog ();
/*
This function displays the font dialog box available in the COMDLG32 library..

Members:

integer FontType
integer SizeMin
integer SizeMax
string FaceName
long  Height
long  Weight
boolean Italic
boolean Underline
boolean StrikeOut

*/
CHOOSEFONT ChooseFont
LOGFONT	LogFont
boolean lb_Result

If Flags = 0 Then Flags = CF_FORCEFONTEXIST + CF_BOTH + CF_EFFECTS + CF_INITTOLOGFONTSTRUCT

LogFont.lfFaceName	= FaceName
LogFont.lfHeight		= Height
LogFont.lfWeight		= Weight
If Italic Then LogFont.lfItalic = Char(255) Else LogFont.lfItalic = Char(0)
If Underline Then LogFont.lfUnderline = Char(1) Else LogFont.lfUnderline = Char(0)
If StrikeOut Then LogFont.lfStrikeOut = Char(1) Else LogFont.lfStrikeOut = Char(0)
long ll
SetNull(ll)
ChooseFont.lStructSize	= 60
ChooseFont.hWndOwner		= hWndParent
ChooseFont.hDC				= 0
ChooseFont.lpLogFont		= LocalAlloc(0,60)
PutLogFont(ChooseFont.lpLogFont,LogFont,60)
ChooseFont.iPointSize	= 0
ChooseFont.Flags			= Flags
ChooseFont.RGBColors		= RGBColors
ChooseFont.lCustData		= 0
ChooseFont.lpfnHook		= 0
ChooseFont.lpTemplateName	= 0
ChooseFont.hInstance 	= 0
ChooseFont.lpszStyle 	= 0
ChooseFont.nFontType 	= FontType
ChooseFont.nSizeMin 		= SizeMin
ChooseFont.nSizeMax 		= SizeMax

If ChooseFontA(ChooseFont) = 1 Then
	GetLogFont(LogFont,ChooseFont.lpLogFont,60)

	FontType	= ChooseFont.nFontType
	FaceName	= LogFont.lfFaceName
	Height	= LogFont.lfHeight
	Weight	= LogFont.lfWeight
	Italic	= (Asc(LogFont.lfItalic) 	 = 255)
	Underline= (Asc(LogFont.lfUnderline) = 1)
	StrikeOut= (Asc(LogFont.lfStrikeOut) = 1)

	lb_Result = True
Else
	FontType	= 0
	FaceName	= ""
	Height	= 0
	Weight	= 0
	Italic	= False
	Underline= False
	StrikeOut= False
	lb_Result = False
End If

LocalFree(ChooseFont.lpLogFont)

Return(lb_Result)

end function

on nvo_commdlg.create
call super::create
TriggerEvent( this, "constructor" )
end on

on nvo_commdlg.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

