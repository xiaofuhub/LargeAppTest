$PBExportHeader$n_coolmenu.sru
forward
global type n_coolmenu from nonvisualobject
end type
type s_menudata from structure within n_coolmenu
end type
end forward

type s_menudata from structure
	string		as_toolbaritemname[]
	string		as_menutext[]
	string		as_image[]
	integer		ai_imageid[]
end type

global type n_coolmenu from nonvisualobject
end type
global n_coolmenu n_coolmenu

type prototypes
Function Boolean SetResourceFile( Ref String sResourceFile ) Library "coolmenu.dll" alias for "SetResourceFile;Ansi"
Subroutine SetResourceFileW( Ref String sResourceFile ) Library "coolmenu.dll" alias for "SetResourceFileW;Ansi"
Function Integer AddStockImage( Integer iImage, Boolean bBitmap, uLong hModule, Long bckColor, Integer xPixel, Integer yPixel ) Library "coolmenu.dll"
Function Integer AddImage( Ref String sImage, Long bckColor, Integer xPixel, Integer yPixel ) Library "coolmenu.dll" alias for "AddImage;Ansi"
Function Integer AddImageID( Long wImage, Long bckColor, Integer xPixel, Integer yPixel ) Library "coolmenu.dll"
Function Integer AddMenuImage( Ref String sImage, uLong hIcon ) Library "coolmenu.dll" alias for "AddMenuImage;Ansi"
Function int SetImageNameId( Ref String iName, uInt iImage ) Library "coolmenu.dll" alias for "SetImageNameId;Ansi"
Function Integer AddImageW( Ref String sImage, Long bckColor, Integer xPixel, Integer yPixel ) Library "coolmenu.dll" alias for "AddImageW;Ansi"
Function Integer AddMenuImageW( Ref String sImage, uLong hIcon ) Library "coolmenu.dll" alias for "AddMenuImageW;Ansi"
Function int SetImageNameIdW( Ref String iName, uInt iImage ) Library "coolmenu.dll" alias for "SetImageNameIdW;Ansi"
Subroutine InstallCoolMenu( uLong hWnd ) Library "coolmenu.dll"
Subroutine Uninstall() Library "coolmenu.dll"
Subroutine SetMenuStyle( Integer MenuStyle ) Library "coolmenu.dll"
Subroutine SetCoolMenubar( Boolean bCoolMenubar ) Library "coolmenu.dll"
Function Boolean GetCoolMenubar() Library "coolmenu.dll"
Subroutine SetFlatMenu( Boolean bFlatMenu ) Library "coolmenu.dll"
Subroutine SetShadowEnabled( Boolean bShadowEnabled ) Library "coolmenu.dll"
Subroutine SetMenuColor( Integer colorIndex, Long colorRef ) Library "coolmenu.dll"
Subroutine SetDefaults() Library "coolmenu.dll"
Subroutine SetPbVersion( Ref String lpszVersion ) Library "coolmenu.dll" alias for "SetPbVersion;Ansi"

Function Long GetSysColor( uInt uIndex ) Library "user32.dll"

////	Functions to read stockitems from PB dll's
//Function Long FN_ResGetBitmapID_70( String lpLibFileName ) Library "PBVM70.dll" Alias For "FN_ResGetBitmapID"
//Function Long FN_ResGetIconID_70( String lpLibFileName ) Library "PBVM70.dll" Alias For "FN_ResGetIconID"
//Function String FN_ResGetBitmapName_70( Long lpLibFileName ) Library "PBVM70.dll" Alias For "FN_ResGetBitmapName"
//
//Function Long FN_ResGetBitmapID_80( String lpLibFileName ) Library "PBVM80.dll" Alias For "FN_ResGetBitmapID"
//Function Long FN_ResGetIconID_80( String lpLibFileName ) Library "PBVM80.dll" Alias For "FN_ResGetIconID"
//Function String FN_ResGetBitmapName_80( Long lpLibFileName ) Library "PBVM80.dll" Alias For "FN_ResGetBitmapName"
//
Function Long FN_ResGetBitmapID_90( String lpLibFileName ) Library "PBVM90.dll" Alias For "FN_ResGetBitmapID;Ansi"
Function Long FN_ResGetIconID_90( String lpLibFileName ) Library "PBVM90.dll" Alias For "FN_ResGetIconID;Ansi"
Function String FN_ResGetBitmapName_90( Long lpLibFileName ) Library "PBVM90.dll" Alias For "FN_ResGetBitmapName;Ansi"
//
//Function Long FN_ResGetBitmapID_10( String lpLibFileName ) Library "PBVM100.dll" Alias For "FN_ResGetBitmapID"
//Function Long FN_ResGetIconID_10( String lpLibFileName ) Library "PBVM100.dll" Alias For "FN_ResGetIconID"
//Function String FN_ResGetBitmapName_10( Long lpLibFileName ) Library "PBVM100.dll" Alias For "FN_ResGetBitmapName"
//
Function uLong GetModuleHandleA( Ref String lpModuleName ) Library "kernel32.dll" alias for "GetModuleHandleA;Ansi"
Function uLong GetModuleHandleW( Ref String lpModuleName ) Library "kernel32.dll"

end prototypes

type variables
Private:
Constant Integer	SUCCESS = 1
Constant Integer	NO_ACTION = 0
Constant Integer	FAILURE = -1

Constant Integer	MenuStyleNormal = 0
Constant Integer	MenuStyleOffice2K = 1
Constant Integer	MenuStyleOfficeXP = 2
Constant Integer	MenuStyleOffice2K3 = 3

Integer		ii_RequestorIndex, ii_Index, ii_Style = MenuStyleOffice2K3
s_menudata	istr_MenuData
Window		iw_Requestor
Boolean		ib_ShowToolbarVisibleOnly, ib_Unicode
uLong			iul_PBVMHandle, iul_Hwnd
Long			il_PbVersion

//	Added to set backgroundcolor of bitmap yourself. You can
//	use the Tag property with one of these values.
Constant Integer	COLOR_SCROLLBAR = 0
Constant Integer	COLOR_BACKGROUND = 1
Constant Integer	COLOR_ACTIVECAPTION = 2
Constant Integer	COLOR_INACTIVECAPTION = 3
Constant Integer	COLOR_MENU = 4
Constant Integer	COLOR_WINDOW = 5
Constant Integer	COLOR_WINDOWFRAME = 6
Constant Integer	COLOR_MENUTEXT = 7
Constant Integer	COLOR_WINDOWTEXT = 8
Constant Integer	COLOR_CAPTIONTEXT = 9
Constant Integer	COLOR_ACTIVEBORDER = 10
Constant Integer	COLOR_INACTIVEBORDER = 11
Constant Integer	COLOR_APPWORKSPACE = 12
Constant Integer	COLOR_HIGHLIGHT = 13
Constant Integer	COLOR_HIGHLIGHTTEXT = 14
Constant Integer	COLOR_BTNFACE = 15
Constant Integer	COLOR_BTNSHADOW = 16
Constant Integer	COLOR_GRAYTEXT = 17
Constant Integer	COLOR_BTNTEXT = 18
Constant Integer	COLOR_INACTIVECAPTIONTEXT = 19
Constant Integer	COLOR_BTNHIGHLIGHT = 20
/* win95 colors */
Constant Integer	COLOR_3DDKSHADOW = 21
Constant Integer	COLOR_3DLIGHT = 22
Constant Integer	COLOR_INFOTEXT = 23
Constant Integer	COLOR_INFOBK = 24
Constant Integer	COLOR_DESKTOP = COLOR_BACKGROUND
Constant Integer	COLOR_3DFACE = COLOR_BTNFACE
Constant Integer	COLOR_3DSHADOW = COLOR_BTNSHADOW
Constant Integer	COLOR_3DHIGHLIGHT = COLOR_BTNHIGHLIGHT
Constant Integer	COLOR_3DHILIGHT = COLOR_BTNHIGHLIGHT
Constant Integer	COLOR_BTNHILIGHT = COLOR_BTNHIGHLIGHT
/* win98 colors */
Constant Integer	COLOR_ALTERNATEBTNFACE = 25  /* undocumented, constant's name unknown */
Constant Integer	COLOR_HOTLIGHT = 26
Constant Integer	COLOR_GRADIENTACTIVECAPTION = 27
Constant Integer	COLOR_GRADIENTINACTIVECAPTION = 28

Constant Integer	COLOR_MIN = 0
Constant Integer	COLOR_MAX = 28

Constant Integer	SelectedColor = 0
Constant Integer	MenuBckColor = 1
Constant Integer	BitmapBckColor = 2
Constant Integer	CheckedSelectedColor = 3
Constant Integer	CheckedColor = 4
Constant Integer	PenColor = 5
Constant Integer	TextColor = 6
Constant Integer	HighlightTextColor = 7
Constant Integer	DisabledTextColor = 8
Constant Integer	GradientStartColor = 9
Constant Integer	GradientEndColor = 10
Constant Integer	MenubarColor = 11


end variables

forward prototypes
public subroutine of_setxpselectedcolor (long al_color)
public subroutine of_SetXpMenuColor (long al_color)
public subroutine of_SetXpBmpBkColor (long al_color)
public subroutine of_SetXpCheckedSelectedColor (long al_color)
public subroutine of_SetXpCheckedColor (long al_color)
public subroutine of_SetXpPenColor (long al_color)
public subroutine of_SetXpHighTextColor (long al_color)
public subroutine of_SetXpDisabledTextColor (long al_color)
public subroutine of_SetXpTextColor (long al_color)
public subroutine of_setxpdefaults ()
private function boolean of_isloaded (string as_image, string as_menutext, ref integer ai_index)
public function boolean of_addmenubitmap (string as_menutext, unsignedlong aul_icon)
public function integer of_settoolbarvisibleonly (boolean ab_switch)
public function boolean of_gettoolbarvisibleonly ()
public function integer of_getmenustyle ()
public subroutine of_set2k3gradient (long al_colorstart, long al_colorend)
public subroutine of_setsharedresources (boolean ab_shareresources)
public subroutine of_setxpstyle ()
public subroutine of_set2k3style ()
public subroutine of_set2kstyle ()
public subroutine of_setnormalstyle ()
public function integer of_loadstockimage (string as_stockimage, string as_tag)
private subroutine of_setimagenameid (string as_menuname, string as_image, integer ai_index)
public subroutine of_setcoolmenubar (boolean ab_coolmenubar)
public subroutine of_setflatmenu (boolean ab_flatmenu)
public function integer of_setrequestor (readonly window aw_requestor)
public subroutine of_initialize ()
public function integer of_setmenu (string as_menu)
public function integer of_loadimagesfrommenu (menu amnu_menu)
public function boolean of_getcoolmenubar ()
public subroutine of_setmenubarcolor (long al_color)
public function boolean of_setresourcefile (string as_resourcefile)
private function integer of_addimage (string as_image, string as_tag)
public subroutine of_setshadow (boolean ab_switch)
public subroutine of_uninitialize ()
public function integer of_setmenu (menu amnu_menu)
end prototypes

public subroutine of_setxpselectedcolor (long al_color);SetMenuColor( SelectedColor, al_Color )
end subroutine

public subroutine of_SetXpMenuColor (long al_color);SetMenuColor( MenuBckColor, al_Color )
end subroutine

public subroutine of_SetXpBmpBkColor (long al_color);SetMenuColor( BitmapBckColor, al_Color )
end subroutine

public subroutine of_SetXpCheckedSelectedColor (long al_color);SetMenuColor( CheckedSelectedColor, al_Color )
end subroutine

public subroutine of_SetXpCheckedColor (long al_color);SetMenuColor( CheckedColor, al_Color )
end subroutine

public subroutine of_SetXpPenColor (long al_color);SetMenuColor( PenColor, al_Color )
end subroutine

public subroutine of_SetXpHighTextColor (long al_color);SetMenuColor( HighlightTextColor, al_Color )
end subroutine

public subroutine of_SetXpDisabledTextColor (long al_color);SetMenuColor( DisabledTextColor, al_Color )
end subroutine

public subroutine of_SetXpTextColor (long al_color);SetMenuColor( TextColor, al_Color )
end subroutine

public subroutine of_setxpdefaults ();SetDefaults()

end subroutine

private function boolean of_isloaded (string as_image, string as_menutext, ref integer ai_index);/*
	Function:		of_IsLoaded
	Arguments:		String	as_MenuText		Text of current menuitem.
						String	as_Image			Image for this menuitem.
						Integer	ai_Index			Index of image if loaded.
	Description:	Sees if the combination menuitem - image is already loaded.
*/	

Integer	li_Loop, li_Il

ai_Index = -1

For li_Loop = 1 To ii_Index
	If istr_MenuData.as_toolbaritemname[li_Loop] = as_Image And &
		istr_MenuData.as_menutext[li_Loop] = as_MenuText Then

		Return True
	End If
Next

For li_Loop = 1 To ii_Index
	If istr_MenuData.as_toolbaritemname[li_Loop] = as_Image Then
		ai_Index = istr_MenuData.ai_imageid[li_Loop]
		Return False
	End If
Next

Return False
end function

public function boolean of_addmenubitmap (string as_menutext, unsignedlong aul_icon);If ib_Unicode Then
	Return ( AddMenuImageW( as_menutext, aul_icon ) <> FAILURE )
Else
	Return ( AddMenuImage( as_menutext, aul_icon ) <> FAILURE )
End If
end function

public function integer of_settoolbarvisibleonly (boolean ab_switch);/*
	Function:		of_ToolbarVisibleOnly
	Arguments:		Boolean	ab_Switch
	Description:	
	Usage:			Call this function if you just want to show bitmaps that are shown
						on the toolbar.
*/
ib_ShowToolbarVisibleOnly = ab_Switch

Return SUCCESS
end function

public function boolean of_gettoolbarvisibleonly ();/*
	Function:		of_GetToolbarVisibleOnly
	Arguments:		None
	Description:	
	Usage:			
*/
Return ib_ShowToolbarVisibleOnly
end function

public function integer of_getmenustyle ();//	Returns 1 for normal, 2 for Office Xp and 3 for Office 2003

Return ii_Style
end function

public subroutine of_set2k3gradient (long al_colorstart, long al_colorend);SetMenuColor( GradientStartColor, al_ColorStart )
SetMenuColor( GradientEndColor, al_ColorEnd )
end subroutine

public subroutine of_setsharedresources (boolean ab_shareresources);/*
	Function:		of_SetSharedResources
	Arguments:		Boolean	ab_ShareResources
	Description:	Adds an image to an ImageList (within coolmenu.dll).
	
*/
//SetSharedResources( ab_ShareResources )

end subroutine

public subroutine of_setxpstyle ();/*
	Function:		of_SetXpStyle
	Arguments:		Boolean	ab_Switch	Turn Xp-style drawing on or off.
	Description:	
	Usage:			Call this function to enable or disable Office Xp style drawing.
*/

SetMenuStyle( MenuStyleOfficeXP )

ii_Style = MenuStyleOfficeXP

end subroutine

public subroutine of_set2k3style ();/*
	Function:		of_SetXpStyle
	Arguments:		Boolean	ab_Switch	Turn Office 2003 style drawing on or off.
	Description:	
	Usage:			Call this function to enable or disable Office 2003 style drawing.
*/
SetMenuStyle( MenuStyleOffice2K3 )

ii_Style = MenuStyleOffice2K3

end subroutine

public subroutine of_set2kstyle ();/*
	Function:		of_SetXpStyle
	Arguments:		Boolean	ab_Switch	Turn Xp-style drawing on or off.
	Description:	
	Usage:			Call this function to enable or disable Office Xp style drawing.
*/

SetMenuStyle( MenuStyleOffice2K )

ii_Style = MenuStyleOffice2K
end subroutine

public subroutine of_setnormalstyle ();/*
	Function:		of_SetNormalStyle
	Arguments:		None
	Description:	
	Usage:			Call this function to disable any Office style like drawing.
*/
SetMenuStyle( MenuStyleNormal )

ii_Style = MenuStyleNormal

end subroutine

public function integer of_loadstockimage (string as_stockimage, string as_tag);Long			ll_Identifier
Boolean		lb_Bitmap = True
Integer		li_Image
Long			ll_Color
Integer		li_XPixel, li_YPixel, li_Pos, li_Index
uLong			lul_Image, lul_Mask
String		ls_Color

If LenA( as_StockImage ) = 0 Then Return -1

Choose Case il_PbVersion
	Case 7
//		ll_Identifier = FN_ResGetBitmapID_70( as_StockImage )
//		If ll_Identifier <= 0 Then
//			ll_Identifier = FN_ResGetIconID_70( as_StockImage )
//			lb_Bitmap = False
//		End If
	Case 8
//		ll_Identifier = FN_ResGetBitmapID_80( as_StockImage )
//		If ll_Identifier <= 0 Then
//			ll_Identifier = FN_ResGetIconID_80( as_StockImage )
//			lb_Bitmap = False
//		End If
	Case 9
		ll_Identifier = FN_ResGetBitmapID_90( as_StockImage )
		If ll_Identifier <= 0 Then
			ll_Identifier = FN_ResGetIconID_90( as_StockImage )
			lb_Bitmap = False
		End If
	Case 10
//		ll_Identifier = FN_ResGetBitmapID_10( as_StockImage )
//		If ll_Identifier <= 0 Then
//			ll_Identifier = FN_ResGetIconID_10( as_StockImage )
//			lb_Bitmap = False
//		End If
End Choose

SetNull( ll_Color )

If IsNumber( as_Tag ) Then
	ll_Color = Long( as_Tag )
	If ll_Color >= COLOR_MIN And ll_Color <= COLOR_MAX Then
		ll_Color = GetSysColor( ll_Color )
	End If
Else
	li_Pos = PosA( as_Tag, "bc=" )
	If li_Pos > 0 Then
		If PosA( as_Tag, ",", li_Pos + 3 ) > 0 Then
			ls_Color = MidA( as_Tag, li_Pos + 3, ( PosA( as_Tag, ",", li_Pos + 3 ) ) - ( li_Pos ) )
		Else
			ls_Color = MidA( as_Tag, li_Pos + 3 )
		End If
		If IsNumber( ls_Color ) Then
			ll_Color = Long( ls_Color )
			If ll_Color >= COLOR_MIN And ll_Color <= COLOR_MAX Then
				ll_Color = GetSysColor( ll_Color )
			End If
		Else
			li_Pos = PosA( ls_Color, "-" )
			If li_Pos > 0 Then
				li_XPixel = Integer( LeftA( as_Tag, li_Pos - 1 ) )
				li_YPixel = Integer( MidA( as_Tag, li_Pos + 1 ) )
			End If
		End If
	End If
End If

li_Image = AddStockImage( ll_Identifier, lb_Bitmap, iul_PBVMHandle, ll_Color, li_XPixel, li_YPixel )

Return li_Image
end function

private subroutine of_setimagenameid (string as_menuname, string as_image, integer ai_index);/*
	Function:		of_SetImagenameid
	Arguments:		String	as_menuname	Menu from which you want to see toolbar-bitmaps.
						String	as_Image		Image for menuitem
						Integer	ai_Index		Index of image in imagelist within coolmenu.dll
	Description:	
	Usage:			Internal use only.
*/
ii_Index++
istr_MenuData.as_MenuText[ii_Index] = as_MenuName
istr_MenuData.as_toolbaritemname[ii_Index] = as_Image
istr_MenuData.ai_ImageId[ii_Index] = ai_Index

If ib_Unicode Then
	SetImageNameIdW( as_MenuName, ai_Index )
Else
	SetImageNameId( as_MenuName, ai_Index )
End If

end subroutine

public subroutine of_setcoolmenubar (boolean ab_coolmenubar);SetCoolMenubar( ab_CoolMenubar )
end subroutine

public subroutine of_setflatmenu (boolean ab_flatmenu);SetFlatMenu( ab_FlatMenu )
end subroutine

public function integer of_setrequestor (readonly window aw_requestor);/*
	Function:		of_SetRequestor
	Arguments:		Window	aw_Requestor	The window which requests the coolmenu-function.
														This must be the first window opened by your application,
														e.g. your MDI-frame.
	Description:	Sets the requesting window and installs coolmenu.dll.
											
*/	
iw_Requestor = aw_Requestor

iul_Hwnd = Handle( iw_Requestor )
InstallCoolMenu( iul_Hwnd )

Return SUCCESS
end function

public subroutine of_initialize ();/*
	Function:		of_Initialize
	Arguments:		None
	Description:	Initialize coolmenu.dll.
*/	
uLong	lul_Null

SetNull( lul_Null )

InstallCoolMenu( lul_Null )
end subroutine

public function integer of_setmenu (string as_menu);/*
	Function:		of_SetMenu
	Arguments:		String	as_Menu	Menu from which you want to see toolbar-bitmaps.
	Description:	
	Usage:			Call this function for every menu with menuitems for which you want to see
						the corresponding bitmaps. If you have a descendant-menu, call of_setmenu just 
						for the descendant, not for the ancestor. If you have more than one descendant,
						just call it for one descendant, unless you added different menuitems to 
						different descendants. In that case, if the added menuitems have bitmaps you
						want to see, you have to call the function for every descendant.
*/

Menu		lmnu_Menu
Boolean	lb_Created

If IsValid( iw_Requestor ) Then
	If iw_Requestor.MenuName <> as_Menu Then
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 03.13.2006 By: LiuHongXin
		//$<reason> The Statement is unsupported.
		/*
		lmnu_Menu = Create Using as_Menu
		*/
		lmnu_Menu = Create m_pfe_cst_mdi_menu
		//---------------------------- APPEON END ----------------------------
		lb_Created = True
	Else
		lmnu_Menu = iw_Requestor.MenuID
	End If
Else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 03.13.2006 By: LiuHongXin
	//$<reason> The Statement is unsupported.
	/*
	lmnu_Menu = Create Using as_Menu
	*/
	lmnu_Menu = Create m_pfe_cst_mdi_menu
	//---------------------------- APPEON END ----------------------------
	lb_Created = True
End If

of_LoadImagesFromMenu( lmnu_Menu )

If lb_Created Then Destroy lmnu_Menu

Return SUCCESS
end function

public function integer of_loadimagesfrommenu (menu amnu_menu);/*
	Function:		of_GetMenuNames
	Arguments:		Menu	amnu_Menu	Menu from which you want to see toolbar-bitmaps.
	Description:	Walks through the given menu (recursive) and sees if an item has
						a toolbaritem (filled ToolbarItemName ). If so, the function AddImage
						is called, which adds it to an ImageList (within coolmenu.dll).
											
*/	

Integer	li_Loop, li_ItemCount, li_Return, li_Index
String	ls_MenuName
Long		ll_Null

li_ItemCount = UpperBound( amnu_menu.Item )

SetNull( ll_Null )

For li_Loop = 1 To li_ItemCount
	ls_MenuName = amnu_menu.Item[li_Loop].Text
	If ls_MenuName = '-' Then Continue
	If amnu_menu.Item[li_Loop].ToolbarItemName <> '' Then
		If ib_ShowToolbarVisibleOnly Then
			If Not amnu_menu.Item[li_Loop].ToolbarItemVisible Then Continue
		End If
		If Not of_IsLoaded( amnu_menu.Item[li_Loop].ToolbarItemName, ls_MenuName, li_Index ) Then
			If li_Index >= 0 Then
				of_SetImageNameId( ls_MenuName, amnu_menu.Item[li_Loop].ToolbarItemName, li_Index )
			Else
				li_Return = of_AddImage( amnu_menu.Item[li_Loop].ToolbarItemName, amnu_menu.Item[li_Loop].Tag )
				If li_Return >= 0 Then
					of_SetImageNameId( ls_MenuName, amnu_menu.Item[li_Loop].ToolbarItemName, li_Return )
				Else
					Continue
				End If
			End If
		End If
	End If
	of_LoadImagesFromMenu( amnu_menu.Item[li_Loop] )
Next

Return SUCCESS
end function

public function boolean of_getcoolmenubar ();Return GetCoolMenubar()
end function

public subroutine of_setmenubarcolor (long al_color);SetMenuColor( MenubarColor, al_Color )
end subroutine

public function boolean of_setresourcefile (string as_resourcefile);Boolean	lb_Return

lb_Return = SetResourceFile( as_ResourceFile )

Return lb_Return
end function

private function integer of_addimage (string as_image, string as_tag);/*
	Function:		of_AddImage
	Arguments:		String	as_Image		Image to add.
						String	as_Tag		Tag to define backgroundcolor yourself. Only to use for .bmp files.
													Values:	-1			Don't use any backgroundcolor at all.
																0 - 28	A Windows defined color
																Empty		Let coolmenu determine the color to use.
																x,y		Pixels to use. At default pixels 0, 0 are
																			used (upperleft corner). If for example
																			the upperright corner has to be used to
																			determine the backcolor, set the tag to 15,0
																			(this depends on the size of your bitmap of course).
	Description:	Adds an image to an ImageList (within coolmenu.dll).
	
*/
Long		ll_Null, ll_Color, ll_Pos, ll_ResourceId
Integer	li_XPixel, li_YPixel, li_Pos, li_Index
uLong		lul_Image, lul_Mask
String	ls_Color

If RightA( as_Image, 1 ) = "!" Then
	Return of_LoadStockImage( as_Image, as_Tag )
End If

SetNull( ll_Color )

ll_Pos = PosA( as_Tag, "id=" )
If ll_Pos > 0 Then
	li_Pos = PosA( as_Tag, ",", ll_Pos + 3 )
	If li_Pos > 0 Then
		ll_ResourceId = Long( Integer( MidA( as_Tag, ll_Pos + 3, li_Pos - ( ll_Pos + 3 ) ) ) )
	Else
		ll_ResourceId = Long( Integer( MidA( as_Tag, ll_Pos + 3 ) ), 0 )
	End If
End If

ll_Pos = PosA( as_Tag, "bc=" )
If ll_Pos > 0 Then
	li_Pos = PosA( as_Tag, ",", ll_Pos + 3 )
	If li_Pos > 0 Then
		ls_Color = MidA( as_Tag, ll_Pos + 3, ( li_Pos - ( ll_Pos + 3 ) ) )
	Else
		ls_Color = MidA( as_Tag, ll_Pos + 3 )
	End If
	If IsNumber( ls_Color ) Then
		ll_Color = Long( ls_Color )
		If ll_Color >= COLOR_MIN And ll_Color <= COLOR_MAX Then
			ll_Color = GetSysColor( ll_Color )
		End If
	Else
		li_Pos = PosA( ls_Color, "-" )
		If li_Pos > 0 Then
			li_XPixel = Integer( LeftA( as_Tag, li_Pos - 1 ) )
			li_YPixel = Integer( MidA( as_Tag, li_Pos + 1 ) )
		End If
	End If
End If

If ll_ResourceId > 0 Then
	Return AddImageID( ll_ResourceId, ll_Color, li_XPixel, li_YPixel )
Else
	If ib_Unicode Then
		Return AddImageW( as_Image, ll_Color, li_XPixel, li_YPixel )
	Else
		Return AddImage( as_Image, ll_Color, li_XPixel, li_YPixel )
	End If
End If

end function

public subroutine of_setshadow (boolean ab_switch);SetShadowEnabled( ab_Switch )
end subroutine

public subroutine of_uninitialize ();Uninstall()
end subroutine

public function integer of_setmenu (menu amnu_menu);//////////////////////////////////////////////////////////////////////
// $<function>of_setmenu()
// $<arguments> value menu	amnu_menu, Menu from which you want to set toolbar-bitmaps.
// $<returns> integer
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 01/12/2006 by Cao YongWang
//////////////////////////////////////////////////////////////////////


Menu		lmnu_Menu 
Boolean	lb_Created

If IsValid( iw_Requestor ) Then
	lmnu_Menu = iw_Requestor.MenuID 
	If lmnu_Menu <> amnu_menu Then
		lmnu_Menu = amnu_menu
		lb_Created = True
	Else
		lmnu_Menu = iw_Requestor.MenuID
	End If
Else
	lmnu_Menu = amnu_menu
	lb_Created = True
End If

of_LoadImagesFromMenu( lmnu_Menu )

If lb_Created Then Destroy lmnu_Menu

Return SUCCESS
end function

on n_coolmenu.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_coolmenu.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String		ls_Module, ls_Version
Environment	lenv_Current

::GetEnvironment( lenv_Current )

il_PbVersion = lenv_Current.PbMajorRevision
ib_Unicode = ( lenv_Current.CharSet = CharSetUnicode! )

ls_Version = String( il_PbVersion ) + "0"
ls_Module = "pbvm" + ls_Version + ".dll"

If ib_Unicode Then
	iul_PBVMHandle = GetModuleHandleW( ls_Module )
Else
	iul_PBVMHandle = GetModuleHandleA( ls_Module )
End If

SetPbVersion( ls_Version )
end event

