$PBExportHeader$uo_tooltips.sru
$PBExportComments$ÊäÈëÀ¸ÌáÊ¾Ð¡´° (Appeon)Toney 06.04.2013 for V141 ISG-CLX
forward
global type uo_tooltips from nonvisualobject
end type
type point from structure within uo_tooltips
end type
type msg from structure within uo_tooltips
end type
type rect from structure within uo_tooltips
end type
type toolinfo from structure within uo_tooltips
end type
end forward

type point from structure
	long		x
	long		y
end type

type msg from structure
	long		hwnd
	long		message
	long		wparam
	long		lparam
	long		time
	point		pt
end type

type rect from structure
	long		left
	long		top
	long		right
	long		bottom
end type

type toolinfo from structure
	long		cbsize
	long		uflags
	long		hwnd
	long		uid
	rect		rect
	long		hinstance
	long		lpsztext
end type

global type uo_tooltips from nonvisualobject autoinstantiate
end type

type prototypes
// ToolTipsoˉêy
SubRoutine InitCommonControls() library "comctl32.dll"
Function long CreateWindowExA(ulong dwExStyle, string ClassName, &
     long WindowName, ulong dwStyle, ulong X, ulong Y, ulong nWidth, &
     ulong nHeight, ulong hWndParent, ulong hMenu, ulong hInstance, &
     ulong lpParam) library "user32.dll" alias for "CreateWindowExA;Ansi"
Function integer DestroyWindow(long hWnd) library "user32.dll"
Function integer ToolTipMsg(long hWnd, long uMsg, long wParam, &
     REF TOOLINFO ToolInfo) library "user32.dll" Alias For "SendMessageA;Ansi"
Function integer RelayMsg(long hWnd, long uMsg, long wParam, &
     REF MSG Msg) library "user32.dll" Alias For "SendMessageA;Ansi"

//?ú′?1üàíoˉêy
Function long LocalAlloc(long Flags, long Bytes) library "kernel32.dll"
Function long LocalFree(long MemHandle) library "kernel32.dll"
Function long lstrcpy(long Destination, string Source) library "kernel32.dll" alias for "lstrcpy;Ansi"

end prototypes

type variables
//??óD3￡á?
Private:

//?ó??3￡á?
CONSTANT string	TOOLTIPS_CLASS = 'tooltips_class32'
CONSTANT ulong	CW_USEDEFAULT = 2147483648
CONSTANT long	WM_USER = 1024
CONSTANT long	WS_EX_TOPMOST = 8
CONSTANT long	WM_SETFONT = 48

// ToolTips???￠
CONSTANT long TTM_ADDTOOL = WM_USER + 4
CONSTANT long TTM_NEWTOOLRECT = WM_USER + 6
CONSTANT long TTM_RELAYEVENT = WM_USER + 7
CONSTANT long TTM_UPDATETIPTEXT	= WM_USER + 12
CONSTANT long TTM_TRACKACTIVATE = WM_USER + 17
CONSTANT long TTM_TRACKPOSITION	= WM_USER + 18

Boolean ib_ToolAdded = False //Added by Appeon long.zhang 03.06.2017

//1?12±?á?oí3￡á?
Public:
long hWndTT	// Tooltip control window handle
long ToolID = 1	// Tooltip internal ID

//Tooltips±ê??
CONSTANT integer TTF_CENTERTIP = 2
CONSTANT integer TTF_RTLREADING = 4
CONSTANT integer TTF_SUBCLASS	= 16
CONSTANT integer TTF_TRACK = 32
CONSTANT integer TTF_ABSOLUTE	= 128
CONSTANT integer TTF_TRANSPARENT	= 256
CONSTANT integer TTF_DI_SETITEM = 32768

end variables

forward prototypes
public subroutine relaymsg (dragobject object)
public subroutine setfont (long hfont)
public subroutine settipposition (integer x, integer y)
public subroutine settiptext (dragobject object, long uid, long tiptext)
public subroutine settiptext (dragobject object, long uid, string tiptext)
public subroutine settrack (dragobject object, integer uid, boolean status)
public subroutine updatetiprect (dragobject object, long uid, long left, long top, long right, long bottom)
public function integer addtool (dragobject object, string tiptext, integer flags)
public subroutine of_createtipwindow ()
end prototypes

public subroutine relaymsg (dragobject object);//′?oˉêyó?óú?ò??ê?ToolTips′°?ú·￠?í???????￠￡?±ào?è???￡o
MSG Msg

If Not ib_ToolAdded Then Return //Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)

Msg.hWnd = Handle(Object)
Msg.Message	= 512	// WM_MOUSEMOVE
Msg.WParam 	= Message.WordParm
Msg.LParam 	= Message.LongParm
RelayMsg(hWndTT,TTM_RELAYEVENT,0,Msg)

end subroutine

public subroutine setfont (long hfont);//′?oˉêyó?óúò3??éè??ToolTips′°?úμ?×?ì?￡?±ào?è???￡o

Send(hWndTT,WM_SETFONT,hFont,1)

end subroutine

public subroutine settipposition (integer x, integer y);//′?oˉêyó?óúò3??éè??ToolTipsμ?????￡?±ào?è???￡o
Send(hWndTT,TTM_TRACKPOSITION,0,Long(X,Y))

end subroutine

public subroutine settiptext (dragobject object, long uid, long tiptext);//′?oˉêyó?óú?aToolTips′°?úò3??éè??D???±?￡?±ào?è???￡o
TOOLINFO ToolInfo

ToolInfo.hWnd = Handle(Object)
ToolInfo.uID = uID
ToolInfo.lpszText = TipText

ToolTipMsg(hWndTT,TTM_UPDATETIPTEXT,0,ToolInfo)

end subroutine

public subroutine settiptext (dragobject object, long uid, string tiptext);//′?oˉêyó?óú?aToolTips′°?úò3??éè??D???±?￡?±ào?è???￡o

//Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)
If (Not ib_ToolAdded) And tiptext = '' Then
	Return
ElseIf Not ib_ToolAdded Then
	This.addtool(object,"",0)  
End If

long lpszText
Constant Int MAXSIZE = 500

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 11.09.2015
//<$>reason:to show longer tip. V14.2 Applause Bug #4828 - Provisional appointment help needs to be wordwrapped for Web deployments
//lpszText = LocalAlloc(0,255)
//lStrCpy(lpszText,Left(TipText,255))
lpszText = LocalAlloc(0,MAXSIZE)
lStrCpy(lpszText,Left(TipText,MAXSIZE))
//------------------- APPEON END -------------------

SetTipText(Object,uId,lpszText)

LocalFree(lpszText)

end subroutine

public subroutine settrack (dragobject object, integer uid, boolean status);//′?oˉêyó?óú?¤???òè???ToolTips′°?úò3??éè??D???±?￡?±ào?è???￡o
//2?êyStatus?aTrueê±?¤??￡??aFalseê±è???
If Not ib_ToolAdded Then This.addtool(object,"",0)  //Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)

TOOLINFO ToolInfo

ToolInfo.cbSize = 40
ToolInfo.hWnd = Handle(Object)
ToolInfo.uID = uID

If Status Then 
	ToolTipMsg(hWndTT,TTM_TRACKACTIVATE,1,ToolInfo)
Else
	ToolTipMsg(hWndTT,TTM_TRACKACTIVATE,0,ToolInfo)
End If

end subroutine

public subroutine updatetiprect (dragobject object, long uid, long left, long top, long right, long bottom);//′?oˉêyó?óú?üD?ToolTipsμ???D??ò￡?±ào?è???￡o
If Not ib_ToolAdded Then This.addtool(object,"",0)  //Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)

TOOLINFO ToolInfo

ToolInfo.hWnd	= Handle(Object)
ToolInfo.uID	= uID

ToolInfo.Rect.Left	= Left
ToolInfo.Rect.Top		= Top
ToolInfo.Rect.Right	= Right
ToolInfo.Rect.Bottom	= Bottom

ToolTipMsg(hWndTT,TTM_NEWTOOLRECT,0,ToolInfo)

end subroutine

public function integer addtool (dragobject object, string tiptext, integer flags);//′?oˉêyó?óú×￠2áòa??ê?ToolTipsμ?????￡?±ào?è???￡o

TOOLINFO ToolInfo

//Whether added.
If ib_ToolAdded Then Return 0 //Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)
	
//Get hWndTT
If hWndTT = 0 Then of_createtipwindow() //Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)

ToolInfo.cbSize = 40
ToolInfo.uFlags = Flags 
ToolInfo.hWnd = Handle(Object)
ToolInfo.hInstance = 0 
ToolInfo.uID = ToolID
ToolID++
ToolInfo.lpszText = LocalAlloc(0,80)
LStrCpy(ToolInfo.lpszText,Left(tiptext,80))
//POST LocalFree(ToolInfo.lpszText) //êí·?·???μ??ú′?
ToolInfo.Rect.Left	= 0
ToolInfo.Rect.Top 	= 0
ToolInfo.Rect.Right	= UnitsToPixels(Object.Width,XUnitsToPixels!)
ToolInfo.Rect.Bottom = UnitsToPixels(Object.Height,YUnitsToPixels!)

If ToolTipMsg(hWndTT,TTM_ADDTOOL, 0, ToolInfo) = 0 Then
	LocalFree(ToolInfo.lpszText) //êí·?·???μ??ú′?	
	//MessageBox("Error","Cannot register object in the toolwindow control!",StopSign!,Ok!) //The Apb cannot support CreateWindowExA funcation in win8.1 & 64-bit environment - commented by alfee 01.03.2014
	Return(-1)
End If
LocalFree(ToolInfo.lpszText) //êí·?·???μ??ú′?

ib_ToolAdded = True//Added by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)

Return(ToolID - 1)

end function

public subroutine of_createtipwindow ();//====================================================================
//$<Function>: of_createtipwindow
//$<Arguments>:
//$<Return>:  integer
//$<Description>: Create tip window, Moved from Constructor Event, to reduce u_dw create time.For Issue Contracts Module Slowness.
//$<Author>: (Appeon) long.zhang 03.06.2017
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================

Constant Int TTM_SETMAXTIPWIDTH = 1048

InitCommonControls()

hWndTT = CreateWindowExA(WS_EX_TOPMOST,TOOLTIPS_CLASS,0, &
      TTF_CENTERTIP, CW_USEDEFAULT, CW_USEDEFAULT, &
      CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, Handle(GetApplication()),0)
		
//SETMAXTIPWIDTH, Added by Appeon long.zhang 11.09.2015 (V14.2 Applause Bug #4828 - Provisional appointment help needs to be wordwrapped for Web deployments)
Send(hWndTT, TTM_SETMAXTIPWIDTH, 0 , 1000)



end subroutine

on uo_tooltips.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tooltips.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Moved to of_createtipwindow, Comment by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)
//Constant Int TTM_SETMAXTIPWIDTH = 1048
//
//InitCommonControls()
//
//hWndTT = CreateWindowExA(WS_EX_TOPMOST,TOOLTIPS_CLASS,0, &
//      TTF_CENTERTIP, CW_USEDEFAULT, CW_USEDEFAULT, &
//      CW_USEDEFAULT, CW_USEDEFAULT, 0, 0, Handle(GetApplication()),0)
//		
////SETMAXTIPWIDTH, Added by Appeon long.zhang 11.09.2015 (V14.2 Applause Bug #4828 - Provisional appointment help needs to be wordwrapped for Web deployments)
//Send(hWndTT, TTM_SETMAXTIPWIDTH, 0 , 1000)


end event

event destructor;If hWndTT > 0 Then DestroyWindow(hWndTT)//Add > 0 condition, by Appeon long.zhang 03.06.2017 (Contracts Module Slowness)
end event

