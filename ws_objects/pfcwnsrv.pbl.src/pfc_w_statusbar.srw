$PBExportHeader$pfc_w_statusbar.srw
$PBExportComments$PFC Statusbar window window
forward
global type pfc_w_statusbar from w_popup
end type
type dw_statusbar from u_dw within pfc_w_statusbar
end type
end forward

global type pfc_w_statusbar from w_popup
boolean visible = false
integer x = 672
integer y = 272
integer width = 1861
integer height = 60
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
boolean border = false
long backcolor = 80263328
event wininichange pbm_wininichange
dw_statusbar dw_statusbar
end type
global pfc_w_statusbar pfc_w_statusbar

type prototypes

end prototypes

type variables
protected:
Environment	ienv_object
Integer		ii_winmaxwidth
long		il_warningcolor=255	        // Red
long 		il_buttonface
long		ii_borderheight
long		ii_borderwidth
integer 		ii_secondstorefresh = 60   // one minute
boolean		ib_win95=False
w_frame 		iw_parentwindow
n_cst_platform 	inv_platform

rect ir_WinRect

//---------Begin Added by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
String			is_Last_Process_value=""

Datawindow		idw_Statusbar//added by gavins 20130510
//---------End Added ------------------------------------------------------

end variables

forward prototypes
public function integer of_setrefreshrate (integer ai_seconds)
public function integer of_refreshposition ()
public function integer of_createvisuals ()
public function integer of_updatevisuals (string as_id, string as_type, string as_value)
public function integer of_updatetimerformat (string as_format)
public function integer of_updatedwtimerinterval (long ai_milliseconds)
protected function integer of_refreshvisuals ()
protected function integer of_refreshcolors ()
protected function integer of_setposition ()
public function integer of_modify (string as_modifyexp)
protected function integer of_getsystemsettings ()
protected function long of_color (string as_rgb)
protected function integer of_restorefocuspoint (graphicobject ago_focus)
public function string of_describe (string as_attribute)
end prototypes

event wininichange;call super::wininichange;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			wininichange
//
//	Arguments:
//	section			Name of the section changed
//
//	Returns:  		None
//
//	Description:  	
//	This is triggered whenever the appearances of the desktop are changed.
//	We need to force the window and the objects to reflect these changes.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer li_rc 

// Get the new settings.
li_rc = of_GetSystemSettings() 

// Refresh the colors of all the objects.
li_rc = of_RefreshColors()

// Force a resize on the Frame to enforce the correct position of this window.
If IsValid(iw_parentwindow) Then
	li_rc = iw_parentwindow.resize(iw_parentwindow.width, iw_parentwindow.height)
End If

Return 

end event

public function integer of_setrefreshrate (integer ai_seconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_setrefreshrate
//
//	Access:  public
//
//	Arguments:
//	ai_seconds  	The number of seconds between Pre-Defined object refreshes.
//
//	Returns:  Integer
// 1 if it succeeds and -1 if an error occurs.
//
//	Description:  
//	Reset the refresh rate for the Pre-Defined objects.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

If IsNull(ai_seconds) or ai_seconds < 0 Then
	Return -1
End If

// Store the value for later use.
ii_secondstorefresh = ai_seconds

// Reset the timer.
timer(ii_secondstorefresh,this)

// Force a timer event now.
this.Event Timer()

Return 1
end function

public function integer of_refreshposition ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  		of_RefreshPosition
//
//	Access:  		public
//
//	Arguments: 		None
//
//	Returns:  		Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:  	
//	Movement of the Parent Frame Window is currently ongoing.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 Hide statusbar (disable timer) when the parentwindow is minimized or 
//			not visible.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

Integer	li_rc

// Check window reference.
If IsNull(iw_parentwindow) Or Not IsValid(iw_parentwindow) Then
	Return -1
End If

if iw_parentwindow.windowstate = minimized! or &
	Not iw_parentwindow.Visible or &
	iw_parentwindow.mdi_1.microhelpheight + 150 > iw_parentwindow.Height then
	// Hide statusbar (disable timer) when the parentwindow is minimized or
	// not visible.
	this.visible = false
	Timer (0, this)
	return 1
end if
	
// Hide until the move is complete.
this.visible = false
Timer (0, this)

li_rc = of_SetPosition()
If IsValid(iw_parentwindow) Then iw_parentwindow.SetFocus()
//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
  /*
      Timer (0.5, this)
  */
This.event timer( )
Timer(ii_secondstorefresh,This)
//---------End Modfiied ------------------------------------------------------------------



Return 1
end function

public function integer of_createvisuals ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_CreateVisuals
//
//	Access:  Public
//
//	Arguments:	None
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Creates the Visual Object (a dw object) that holds all registerd objects.
//	This is called after opening this GUI or anytime the StatusBar userobject
//	creates a new entry or destroys a new entry through its of_Register...()
// and of_UnRegister...() functions.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 Restore the focus point to the correct object which may not be the frame.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer		li_rc
string		ls_dwdefinition
string		ls_errorbuffer
string		ls_replacestring
integer		li_height
graphicobject lgo_withfocus
n_cst_string	lnv_string

// Check for the required reference.
If IsNull(iw_parentwindow) Or Not IsValid(iw_parentwindow) Then
	Return -1
End If

// Keep track of the object with focus.
lgo_withfocus = GetFocus()	

// Get the text necessary to build the appropriate datawindow object.
li_rc = iw_parentwindow.inv_statusbar.of_createdwobject( &
						ls_dwdefinition, ii_winmaxwidth, li_height)
If li_rc <> 1 Then
	Return -1
End If

// Change the Background color of all the objects to be the 
//	appropriate background color.
ls_replacestring = 'background.color="'+string(il_buttonface)+'"'
ls_dwdefinition = lnv_string.of_GlobalReplace(ls_dwdefinition, &
			'background.color="12632256"', ls_replacestring)

// Set it on the DataWindow Control (which set focus on it).
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//li_rc = dw_statusbar.Create ( ls_dwdefinition, ls_errorbuffer)
If isvalid( idw_Statusbar ) Then li_rc = idw_Statusbar.Create ( ls_dwdefinition, ls_errorbuffer) //modify by gavins 20130510
//---------End Modfiied ------------------------------------------------------
If li_rc <> 1 Then
	Return -1
End If

// Update the colors of this window and the datawindow objects.
li_rc = of_RefreshColors()

// Set the Height of the Status bar.
this.height = li_height
dw_statusbar.Height = li_height

// Define the Width of the status bar.
dw_statusbar.Width = ii_winmaxwidth
this.Width = ii_winmaxwidth

// Set its position.
of_SetPosition()

// Force an Update of the Pre-Defined Objects.
of_RefreshVisuals()

// Restore the focus point to the previous valid focus point.
of_RestoreFocusPoint(lgo_withfocus)

Return 1
end function

public function integer of_updatevisuals (string as_id, string as_type, string as_value);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_UpdateVisuals
//
//	Access:  Public
//
//	Arguments:	
//	as_id		The ID of the User Defined object which needs its value modified.
//	as_type	The Type of User Defined object. (text or bitmap)
//	as_value	The new desired value.
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Updates the User Defined object.  
//	This can either be Text or a new bitmap.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////


string	ls_modifyexp
string	ls_rc

// According to the Type, create the appropriate Modify statement.
If PosA(as_type, 'bitmap') > 0 Then
	ls_modifyexp = as_id+'.Expression="bitmap(~'' + as_value + '~')" '
Else
	ls_modifyexp = as_id+'.Expression=~'"'+ as_value + '"~' '	
End IF

//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
// Execute the Modify statment.					
//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
//---------End Modfiied ------------------------------------------------------

If LenA(ls_rc) > 0 Then
	Return -1
End If
Return 1
end function

public function integer of_updatetimerformat (string as_format);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_UpdateDWTimerFormat
//
//	Access:  Public
//
//	Arguments:	
//	ai_milliseconds	The new Timer Format.
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Refreshes the Pre-Defined Datawindow Timer Format.
//	This is used for the Timer Pre-Defined object only.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_modifyexp
string	ls_rc

If IsNull(as_format) Then
	as_format = ''
End If

// Create and Execute the Modify statment.
ls_modifyexp = "pfc_timer.Format='"+as_format+"'"
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
//---------End Modfiied ------------------------------------------------------
If LenA(ls_rc) > 0 Then
	Return -1
End If
Return 1
end function

public function integer of_updatedwtimerinterval (long ai_milliseconds);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_UpdateDWTimerInterval
//
//	Access:  Public
//
//	Arguments:	
//	ai_milliseconds	The new Timer interval in milliseconds.
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Refreshes the Pre-Defined Datawindow Timer Interval.
//	This is used for the Timer Pre-Defined object only.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_modifyexp
string	ls_rc

// Create and Execute the Modify statment.
ls_modifyexp = "DataWindow.Timer_Interval='"+String(ai_milliseconds)+"'"
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
//---------End Modfiied ------------------------------------------------------
If LenA(ls_rc) > 0 Then
	Return -1
End If
Return 1
end function

protected function integer of_refreshvisuals ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RefreshVisuals
//
//	Access:  Public
//
//	Arguments:	None
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Refreshes the Pre-Defined Visual Objects. 
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 When appropriate display N/A (for NotApplicable or NotAvailable)
//		instead of a negative return code.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

ulong 		ll_resource
string	ls_modifyexp
string	ls_rc

// Validate required references.
If IsNull(iw_parentwindow) Or Not IsValid(iw_parentwindow) Then
	Return -1
End If
If IsNull(iw_parentwindow.inv_statusbar) Or &
	Not IsValid(iw_parentwindow.inv_statusbar) Then 
	Return -1
End If

// If appropriate update the Memory value.
If iw_parentwindow.inv_statusbar.of_GetMem() Then
	//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
	  /*
	ll_resource = inv_platform.of_GetFreememory()
	If ll_resource <> -1 then		
		// Display the reading.  Color it if below threshold.
		ls_modifyexp = "pfc_mem.Expression=~"'"+ &
							'Available Mem: '+string(ll_resource/1048576,"###.0")+ " MB'~" "
		if ll_resource < iw_parentwindow.inv_statusbar.of_GetMemThreshold() then			
	  */
	ulong ll_totalmem
	inv_platform.of_getfreememory( ll_totalmem ,ll_resource)
	If ll_resource <> -1 and ll_resource <> 0 Then
		// Display the reading.  Color it if below threshold.
		ls_modifyexp = "pfc_mem.Expression=~"'"+ &
							'Available Mem: '+string(ll_resource,"#####.0")+ " MB'~" "
		If ll_resource * (1024 * 1024) < iw_parentwindow.inv_statusbar.of_GetMemThreshold() Then
	//---------End Modfiied ------------------------------------------------------------------			
			ls_modifyexp = ls_modifyexp + "pfc_mem.Background.Color='"+ &
								string(il_warningcolor)+"' "
		Else
			ls_modifyexp =	ls_modifyexp + "pfc_mem.Background.Color='"+ &
								string(il_buttonface)+"' "
		End if
	Else
		// Display NotApplicable/NotAvailable.		
		ls_modifyexp = "pfc_mem.Expression=~"'"+ "Mem: N/A'~" " + &
							"pfc_mem.Background.Color='"+ string(il_buttonface)+"' "
	End If
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
	If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
	//---------End Modfiied ------------------------------------------------------
End If

// If appropriate update the User Memory value.
If iw_parentwindow.inv_statusbar.of_GetUser() Then
	ll_resource = inv_platform.of_GetFreeResources(2)
	If ll_resource <> -1 Then
		// Display the reading.  Color it if below threshold.		
		ls_modifyexp = "pfc_user.Expression=~"'"+ &
							'User: '+string(ll_resource,"###")+ " %'~" "
		if ll_resource < iw_parentwindow.inv_statusbar.of_GetUserThreshold() then
			ls_modifyexp = ls_modifyexp + "pfc_user.Background.Color='"+ &
								string(il_warningcolor)+"' "
		Else
			ls_modifyexp =	ls_modifyexp + "pfc_user.Background.Color='"+ &
								string(il_buttonface)+"' "
		End if
	Else
		// Display NotApplicable/NotAvailable.
		ls_modifyexp = "pfc_user.Expression=~"'"+ "User: N/A'~" " + &
							"pfc_user.Background.Color='"+ string(il_buttonface)+"' "	
	End If
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
	If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
	//---------End Modfiied ------------------------------------------------------
End If

// If appropriate update the GDI Memory value.
If iw_parentwindow.inv_statusbar.of_GetGDI() Then
	ll_resource = inv_platform.of_GetFreeResources(1)
	If ll_resource <> -1 then
		// Display the reading.  Color it if below threshold.		
		ls_modifyexp = "pfc_gdi.Expression=~"'"+ &
							'GDI: '+string(ll_resource,"###")+ " %'~" "
		if ll_resource < iw_parentwindow.inv_statusbar.of_GetGDIThreshold() then
			ls_modifyexp = ls_modifyexp + "pfc_gdi.Background.Color='"+ &
								string(il_warningcolor)+"' "
		Else
			ls_modifyexp =	ls_modifyexp + "pfc_gdi.Background.Color='"+ &
								string(il_buttonface)+"' "
		End if
	Else
		// Display NotApplicable/NotAvailable.		
		ls_modifyexp = "pfc_gdi.Expression=~"'"+ "GDI: N/A'~" " + &
							"pfc_gdi.Background.Color='"+ string(il_buttonface)+"' "				
	End If		
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//ls_rc = dw_statusbar.Modify (ls_modifyexp)		
	If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (ls_modifyexp)		//modify by gavins 20130510
	//---------End Modfiied ------------------------------------------------------
End If

Return 1
end function

protected function integer of_refreshcolors ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RefreshColors
//
//	Access:  Protected
//
//	Arguments:	None
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Refreshes the colors of all the appropriate objects to match the desired
//	background color.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string 		ls_allobjects
string		ls_object
string		ls_modifyexp
string		ls_rc
n_cst_string	lnv_string

// Get the datawindow objects.
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//ls_allobjects = dw_statusbar.Describe('DataWindow.Objects')
If isvalid( idw_Statusbar ) Then ls_allobjects = idw_Statusbar.Describe('DataWindow.Objects') //modify by gavins 20130510
//---------End Modfiied ------------------------------------------------------

// Set window background to match buttonface.
this.backcolor = il_buttonface

// Set each datawindow object background to match buttonface.
DO UNTIL LenA(ls_allobjects) <= 0
	ls_object = lnv_string.of_gettoken(ls_allobjects,'~t')
	ls_modifyexp =	ls_object+".Background.Color='"+string(il_buttonface)+"' "
	//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
	//ls_rc = dw_statusbar.Modify (ls_modifyexp)	
	If isvalid( idw_Statusbar ) Then  ls_rc = idw_Statusbar.Modify (ls_modifyexp)	
	//---------End Modfiied ------------------------------------------------------
LOOP

Return 1
end function

protected function integer of_setposition ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  	of_SetPosition
//
//	Access:  	public
//
//	Arguments: 	None
//
//	Returns:  	Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:  	
//	Moves this StatusBar window so it is positioned over the lower right
//	hand portion of the Microhelp bar.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

long 		ll_microhelp_ypos, ll_frame_xpos, ll_desiredstatubar_xpos
integer	li_xpos_extra=0, li_ypos_extra=0
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 01.16.2006 By: Cao YongWang
//$<reason> Only for moving the statusbar window to the corrent position in web application
long ll_bottompos,ll_rtn,ll_TopPos,ll_LeftPos

ll_rtn = gnv_appeondll.of_getwindowrect(handle(iw_parentwindow) , ir_WinRect)

ll_LeftPos = PixelsToUnits(ir_WinRect.Left, XPixelsToUnits!)
ll_TopPos = PixelsToUnits(ir_WinRect.Top, YPixelsToUnits!)
ll_bottompos = PixelsToUnits(ir_WinRect.bottom, YPixelsToUnits!)
//---------------------------- APPEON END ----------------------------

// Check window reference.
If IsNull(iw_parentwindow) Or Not IsValid(iw_parentwindow) Then
	Return -1
End If

if iw_parentwindow.windowstate = minimized! then 
	return 1
end if

// Windows 95 has a bigger gap on the hand right side.
If ib_win95 Then
	li_xpos_extra = 50
	li_ypos_extra = 1
End If
	
If Not iw_parentwindow.resizable	Then
	li_ypos_extra += 3
End If
	
// The Y Position of the Status Bar is the Bottom of the Frame Window
// minus the MicroHelpHeight minus the MicroHelpBorderHeight.
if appeongetclienttype() = 'PB' then
	ll_microhelp_ypos = &
				(iw_parentwindow.y + iw_parentwindow.height + li_ypos_extra) - &
				(iw_parentwindow.mdi_1.microhelpheight + ii_borderheight)			
else
	ll_microhelp_ypos = &
				(ll_TopPos + iw_parentwindow.height + li_ypos_extra) - &
				(iw_parentwindow.mdi_1.microhelpheight + ii_borderheight)
end if

// The desired X Position of the Status Bar is the Frame Right End minus
// the StatusBar window.  Also subtract the extra spacing on win95.

if appeongetclienttype() = 'PB' then
	ll_desiredstatubar_xpos = &
				iw_parentwindow.x + iw_parentwindow.workspacewidth() + &
				ii_borderwidth - (ii_winmaxwidth + 12 + li_xpos_extra)
else
	ll_desiredstatubar_xpos = &
				ll_LeftPos + iw_parentwindow.workspacewidth() + &
				ii_borderwidth - (ii_winmaxwidth + 12 + li_xpos_extra)
end if
				
				
// The Frame X Position.
if appeongetclienttype() = 'PB' then
	ll_frame_xpos = iw_parentwindow.x  + (2*ii_borderwidth) + 16
else
	ll_frame_xpos = ll_LeftPos  + (2*ii_borderwidth) + 16
end if

if ll_desiredstatubar_xpos < ll_frame_xpos then 
	// Status Bar would extend to the left of the frame.
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.16.2006 By: Cao YongWang
	//$<reason> 
	//this.move(ll_frame_xpos , ll_microhelp_ypos)
	If appeongetclienttype() = 'PB' Then
		this.move(ll_frame_xpos , ll_microhelp_ypos)
	Else
		//this.move(ll_frame_xpos , ll_bottompos - 70)
		this.move(ll_frame_xpos , ll_bottompos - iw_parentwindow.mdi_1.microhelpheight + 10) //Ken 2007-11-14 For IE7 In XP
	End If
	//---------------------------- APPEON END ----------------------------

	// Make the StatuBar the width of the frame.
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-09-12 By: Liang QingShi
	//$<reason> workspacewidth(iw_parentwindow) is unsupported.
	//	this.width = workspacewidth(iw_parentwindow) - (20 + li_xpos_extra)

	this.width = iw_parentwindow.workspacewidth() - (20 + li_xpos_extra)

	//---------------------------- APPEON END ----------------------------
else 
	// Normal as large as defined Status Bar window.
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 01.16.2006 By: Cao YongWang
	//$<reason> 
	//this.move(ll_desiredstatubar_xpos , ll_microhelp_ypos)
	If appeongetclienttype() = 'PB' Then
		//---------Begin Modified by (Appeon)Harry 02.19.2014 for Bug # 3898--------
		//this.move(ll_desiredstatubar_xpos , ll_microhelp_ypos)
		If This.x <> ll_frame_xpos or This.y <> ll_microhelp_ypos Then
			this.move(ll_frame_xpos , ll_microhelp_ypos)
		End If
		//---------End Modfiied ------------------------------------------------------
	Else
		//this.move(ll_desiredstatubar_xpos , ll_bottompos - 70)
		//---------Begin Modified by (Appeon)Harry 02.19.2014 for Bug # 3898--------
		//this.move(ll_desiredstatubar_xpos , ll_bottompos - iw_parentwindow.mdi_1.microhelpheight + 10) //Ken 2007-11-14 For IE7 In XP
		If This.x <> ll_frame_xpos or This.y <> (ll_bottompos - iw_parentwindow.mdi_1.microhelpheight + 10) Then
			this.move(ll_frame_xpos , ll_bottompos - iw_parentwindow.mdi_1.microhelpheight + 10) //Ken 2007-11-14 For IE7 In XP
		End If
		//---------End Modfiied ------------------------------------------------------
	End If
	//---------------------------- APPEON END ----------------------------

	this.width = ii_winmaxwidth
end if

Return 1
end function

public function integer of_modify (string as_modifyexp);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_modify
//
//	Access:  Public
//
//	Arguments:	
//	as_modifyexp	The modify string to execute
//	
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:
//	Modifies the properties of an object
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	6.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string	ls_rc

dw_statusbar.SetRedraw(False)

// Execute the Modify statment.				
//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
//ls_rc = dw_statusbar.Modify (as_modifyexp)		
If isvalid( idw_Statusbar ) Then ls_rc = idw_Statusbar.Modify (as_modifyexp)	//modify by gaivns 20130510
//---------End Modfiied ------------------------------------------------------

dw_statusbar.SetRedraw(True)

If ls_rc <> "" Then
	Return -1
End If

Return 1

end function

protected function integer of_getsystemsettings ();//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_GetSystemSettings
//
//	Access:  protected
//
//	Arguments : None
//
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:  
//	Get the needed settings from the registry or win.ini
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.02 Provide default value for buttonface Color.
// 5.0.03 Added WindowNT 4.0 support.
// 7.0	 Changed calculation of border size
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

string ls_temp
string ls_buttonface
integer li_border
n_cst_platform lnv_platform

f_setplatform(lnv_platform, true)

li_border = lnv_platform.of_GetActiveWindowBorder()
RegistryGet ('hkey_current_user\control panel\colors', 'buttonface', ls_buttonface)

IF li_border > 0 THEN
	ii_borderheight = PixelsToUnits(li_border, ypixelstounits!)
	ii_borderwidth = PixelsToUnits(li_border, xpixelstounits!)
END IF

// Provide default value for the ButtonFace color.
If IsNull(ls_buttonface) or LenA(ls_buttonface)=0 Then
	il_buttonface = 78682240
Else
	il_buttonface = of_Color(ls_buttonface)
End If

f_setplatform(lnv_platform, false)

Return 1
end function

protected function long of_color (string as_rgb);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_color
//
//	Access:  protected
//
//	Arguments:
//	as_rgb 	a string in the format "### ### ###"
//
//	Returns:  long 
//	the actual color
//
//	Description:
//	Convert the passed RGB string to a long.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
 
string 	ls_color
integer 	li_rgb[3]
long 		ll_cnt
n_cst_string lnv_string

For ll_cnt = 1 To 3
	ls_color = lnv_string.of_gettoken(as_rgb,' ')
	li_rgb[ll_cnt] = Integer(ls_color)
Next

Return RGB(li_rgb[1], li_rgb[2], li_rgb[3])

end function

protected function integer of_restorefocuspoint (graphicobject ago_focus);//////////////////////////////////////////////////////////////////////////////
//
//	Function:  of_RestoreFocusPoint
//
//	Access:  protected
//
//	Arguments:
//	  ago_focus object which should get focus.
//
//	Returns:  Integer
//	1 if it succeeds and -1 if an error occurs.
//
//	Description:  
//	Restore the focus point to the passed in object.  If an invalid object is 
//	passed in or the object passed in belongs to this window, then the focus
// point is passed in to the parentwindow.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Revision History
//
//	Version
//	5.0.03 Initial version
// 7.0	Added new controls hprogressbar!, htrackbar!, vprogressbar!,
//			vtrackbar!, picturehyperlink!, statichyperlink!
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer	li_rc
window 	lw_obj
dragobject ldrg_obj

If IsValid(ago_focus) Then

	// Make sure we are not trying to restore focus to an object in this window.
	If ago_focus = dw_statusbar or ago_focus = this Then
		// Set focus on the parent frame.
		If IsValid(iw_parentwindow) Then
			li_rc = iw_parentwindow.SetFocus()
		Else
			li_rc = -1
		End If
	Else
		// Attempt to set focus on the passed-in object.
		CHOOSE CASE ago_focus.TypeOf()
			CASE Window!
				lw_obj = ago_focus
				li_rc = lw_obj.SetFocus()

			CASE  checkbox!, commandbutton!, datawindow!, dropdownlistbox!, dropdownpicturelistbox!, &
					editmask!, graph!, groupbox!, hprogressbar!, hscrollbar!, htrackbar!, listbox!,  &
					listview!, multilineedit!, olecontrol!, olecustomcontrol!, omcontrol!, omcustomcontrol!,  &
					omembeddedcontrol!, picture!, picturebutton!, picturehyperlink!, picturelistbox!,  &
					radiobutton!, richtextedit!, singlelineedit!, statichyperlink!, statictext!,  &
					tab!, treeview!, userobject!, vprogressbar!, vscrollbar!, vtrackbar!
				ldrg_obj = ago_focus
				li_rc = ldrg_obj.SetFocus()

			CASE else
				// Not a valid object, set focus on the parent frame.
				If IsValid(iw_parentwindow) Then
					li_rc = iw_parentwindow.SetFocus()
				Else
					li_rc = -1
				End If
			
		END CHOOSE
	End If
Else
	// By default, set focus on the parent frame.	
	If IsValid(iw_parentwindow) Then
		li_rc = iw_parentwindow.SetFocus()
	Else
		li_rc = -1
	End If
End If

Return li_rc
end function

public function string of_describe (string as_attribute);//====================================================================
// Function: of_describe
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	as_attribute
//--------------------------------------------------------------------
// Returns:  string
//--------------------------------------------------------------------
// Author:	gavin		Date: 2013-04-09
//--------------------------------------------------------------------
//Copyright (c) 2008-2012 Contract Logix, Inc. All rights reserved.
//--------------------------------------------------------------------
// Modify History:
// (Appeon)Harry 01.21.2014 - V142 ISG-CLX Copy from CLX12.0
//====================================================================

string	ls_rc = ''

// Execute the Describe statment.					
//ls_rc = dw_statusbar.Describe (as_attribute)		
If isvalid( idw_Statusbar ) Then  ls_rc = idw_Statusbar.Describe (as_attribute)	//modify by gavins 20130510

If ls_rc = '?' Or ls_rc = '!' Or isnull( ls_rc ) Then ls_rc = ''
Return ls_rc

end function

event open;//////////////////////////////////////////////////////////////////////////////
//	Object Name:		pfc_w_statusbar
//	Description:			Status bar window that 'floats' over the microhelp area of a MDI frame.
//							Note:  This window opens with the Visible Setting = False.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History			Version
//							5.0			Initial version
// 							5.0.02		Updated check for Operating system.
// 							5.0.03		Added checks for WindowsNT 4.0.
// 							7.0			Added InsertRow to StatusBar dw
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-2000 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
integer	li_rc

idw_Statusbar = Message.PowerobjectParm //added by gavins 20130510 //(Appeon)Harry 01.21.2014 - V142 ISG-CLX

// Get the parent window.
iw_parentwindow = ParentWindow()

// Disable the CloserQuery process.
ib_disableclosequery = true

// Create an instance of the platform service.
f_setplatform(inv_platform, true)  

// Determine the environment.
GetEnvironment(ienv_object)
ib_win95 = (ienv_object.ostype = Windows! and  & 
				(ienv_object.osMajorRevision = 4 or & 
					(ienv_object.osMajorRevision = 3 and &
						ienv_object.osMinorRevision >= 95))) or &
				(ienv_object.ostype = WindowsNT! and & 
				 ienv_object.osMajorRevision >= 4)

// Get the Current System settings prior to Creating the visuals.
li_rc = of_GetSystemSettings() 

// Create the visuals.
li_rc = of_CreateVisuals()
If li_rc <> 1 Then
	Close(this)
End If

// Set the initial position.
//this.of_SetPosition()  //modify by gavins 20130510  //Commented by (Appeon)Harry 01.21.2014 - V142 ISG-CLX
 
dw_statusbar.InsertRow (0)

// Go every 'n' seconds to refresh the items.
timer(ii_secondstorefresh,this) 

// Make sure focus is on the Frame.
If IsValid(iw_parentwindow) Then
	iw_parentwindow.SetFocus()
End If
end event

event timer;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  			timer
//
//	Arguments: 		None
//
//	Returns:  		None
//
//	Description:  	
//	Every is_secondstorefresh this event will refresh the displayed objects.
//	Note: The timer 'pfc_timer' is updated by the DataWindow object timer.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
// 5.0.03 Restore the focus point to the correct object which may not be the frame.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

integer li_rc
graphicobject lgo_withfocus
Window	lw_Temp  //(Appeon)Harry 01.21.2014 - V142 ISG-CLX
string		ls_Value  //(Appeon)Harry 01.21.2014 - V142 ISG-CLX

// Check for the required reference.
If IsNull(iw_parentwindow) Or Not IsValid(iw_parentwindow) Then
	Return
End If

// Refresh the displayed objects.
li_rc = of_RefreshVisuals()

//---------Begin Modified by (Appeon)Harry 01.21.2014 for V142 ISG-CLX--------
/*
if AppeonGetClientType() = "PB" then
	// The move/resize stopped, make the status bar visible once again.
	if this.Visible=False then
		// Keep track of the object with focus.
		lgo_withfocus = GetFocus()	
		
		// Make this window visible (window gets focus).
		if IsValid(w_mdi) then				//Added by Scofield on 2008-11-04
			if w_mdi.Visible then			//Added by Scofield on 2008-11-04
				this.Visible = True
			end if
		end if
		
		// Restore the focus point to the previous valid focus point.
		of_RestoreFocusPoint(lgo_withfocus)
		
		// Reset the timer.
		Timer (ii_secondstorefresh, this)
	end if
else
	//---------Begin Modified by (Appeon)Toney 06.04.2013 for V141 ISG-CLX--------
	  /*			
		//--------------------------- APPEON BEGIN ---------------------------
		//$< Add  > 2007-09-20 By: Scofield
		//$<Reason> When minimized the IE window,don't display the statusbar
		
		ulong		ll_Handle,ll_IsMin,ll_handle_temp
		String	ls_BrowserTitle1
		String	ls_BrowserTitle2 //Ken 2007-11-14 For IE7
		rect 		lr_WinRect
	
		//--------------------------- APPEON BEGIN ---------------------------
		//$<add> 12/06/2007 By: Ken.Guo
		//$<reason> MDI title maybe is different with IE title
		/*
		ls_BrowserTitle1 = w_mdi.title + ' - Microsoft Internet Explorer'
		ls_BrowserTitle2 = w_mdi.title + ' - Windows Internet Explorer' //Added By Ken 2007-11-14 For IE7
		*/
		ll_handle_temp = appeongetiehandle() //Ken.Guo 2008-04-08.  Use appeon function to get current IE's handle in APB 6.0.
		If ll_handle_temp > 0 Then           //Ken.Guo 2008-04-08
			ll_Handle = ll_handle_temp        //Ken.Guo 2008-04-08
		Else
			//Get IE's handle by FindWindowA() in APB 5.1
			String ls_title
			int li_pos 
			window isheet_window
			//Union sheet window title
			isheet_window = w_mdi.GetActiveSheet()
			If isvalid(isheet_window) Then
				if isheet_window.windowstate = Maximized! Then 
					ls_title = w_mdi.title + '[' + isheet_window.Title + ']'
				Else
					ls_title = w_mdi.title
				End If
			Else
				ls_title = w_mdi.title
			End If
			//Suppress repeating space character
			li_pos = PosA(ls_title,'  ')
			Do While li_pos > 0 
				ls_title = ReplaceA(ls_title,li_pos,2,' ') 
				li_pos = PosA(ls_title,'  ')
			loop
			
			//--------------------------- APPEON BEGIN ---------------------------
			//$<add> 03/31/2008 By: Ken.Guo
			//$<reason> //IE only support 95 Characters.
			If LenA(ls_title) > 95 Then
				ls_title = LeftA(ls_title,95)   
			End If
			//---------------------------- APPEON END ----------------------------
			
			ls_BrowserTitle1 = ls_title + ' - Microsoft Internet Explorer'
			ls_BrowserTitle2 = ls_title + ' - Windows Internet Explorer' //Added By Ken 2007-11-14 For IE7
		//---------------------------- APPEON END ----------------------------
		
			ll_Handle = FindWindowA(0,ls_BrowserTitle1)
			if ll_Handle <= 0 then 
				ll_Handle = FindWindowA(0,ls_BrowserTitle2)  //Added By Ken For IE7  2007-11-14 
				If ll_Handle <=0 Then
					Return
				End If
			End If
		End If
		
		
		ll_IsMin = IsIconic(ll_Handle)
		
		if this.Visible = False then
			if ll_IsMin = 0 then
				lgo_withfocus = GetFocus()	
				if IsValid(w_mdi) then				//Added by Scofield on 2008-11-04
					if w_mdi.Visible then			//Added by Scofield on 2008-11-04
						this.Visible = True
					end if
				end if
				of_RestoreFocusPoint(lgo_withfocus)
				Timer (ii_secondstorefresh, this)
			else
				return
			end if
		else
			if ll_IsMin = 0 then
				gnv_appeondll.of_getwindowrect(handle(iw_parentwindow),lr_WinRect)
				
				if lr_WinRect <> ir_WinRect then
					this.of_setposition()
				end if
			else
				this.Visible=False
			end if
		end if
		//---------------------------- APPEON END ----------------------------
	  */
	This.of_setposition( )
	Super::Event Timer()
	//---------End Modfiied ------------------------------------------------------------------
		
end if
*/
//added by gavins 20130410
lw_Temp = iw_parentwindow.getactivesheet( )
If IsValid( lw_Temp ) Then
	ls_Value = Trim( lw_Temp.Title )
	//---------Begin Modified by (Appeon)Harry 08.20.2014 for BugS081801--------
	//If Not isvalid( gw_Contract ) and lw_temp = w_contract  Then  ls_value = "Ready"
	If Not isvalid( gw_Contract ) and lw_temp.classname( ) = "w_contract"  Then  ls_value = "Ready"
	//---------End Modfiied ------------------------------------------------------
	
//	If is_Last_Process_value = ls_Value Then Return
	
	//If left( ls_Value, 14 ) = "Contract Logix" Then ls_value = Trim( Mid( ls_value, 15 ) )  //Commented by (Appeon)Harry 01.21.2014 - V142 ISG-CLX
	If left( ls_Value, 15) = "IntelliContract" and Len( Trim( Mid( ls_value, 16 ) )) > 0 Then ls_value = Trim( Mid( ls_value, 16 ) )  //(Appeon)Harry 04.14.2014 - V142 ISG-CLX
	If ls_Value = '' or isnull( ls_Value ) then ls_Value = 'Ready'
	If gnv_Status_Info.of_get_info( ) = ls_Value Then Return
	If Not gnv_status_info.ib_red_process Then

		//------------------- APPEON BEGIN -------------------
		//<$>added:long.zhang 01.24.2017
		//<$>reason: add 2 layers quotes,  For Double quotes on first name creating error Case#68566 Bug_id#5461		
		If PosA(ls_value, '"') > 0 or PosA(ls_value, "'") > 0 Then 
			ls_value = gnv_string.of_globalreplace( ls_value, '"','~~~~~~"') 
			ls_value = gnv_string.of_globalreplace( ls_value, "'","~~~~~~'") 
		End If
		//------------------- APPEON END -------------------

		of_Updatevisuals( 'Process','text', ls_value )
		is_Last_Process_value = ls_value
	End If	
Else
	If gnv_Status_Info.of_get_info( ) = 'Ready' Then Return
	is_Last_Process_value = ""
	If Not gnv_status_info.ib_red_process Then of_Updatevisuals( 'Process','text',  'Ready' )
End If
//---------End Modfiied ------------------------------------------------------
end event

on pfc_w_statusbar.create
int iCurrent
call super::create
this.dw_statusbar=create dw_statusbar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_statusbar
end on

on pfc_w_statusbar.destroy
call super::destroy
destroy(this.dw_statusbar)
end on

event close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  		close
//
//	Arguments:	None
//
//	Returns:  	None
//
//	Description: 
//	Destroy the platform service.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Destroy the platform service.
f_setplatform(inv_platform,false)

end event

event pfc_controlgotfocus;// Override Ancestor
end event

event resize;// Override Ancestor.
end event

event move;// Override Ancestor.
end event

type dw_statusbar from u_dw within pfc_w_statusbar
integer width = 1394
integer height = 60
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
end type

event rbuttonup;// Override Ancestor.

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttonup
//
//	Returns:	None
//
//	Description:
//	Notification from the GUI StatusBar.
// Notify the service that a right button up has occurred on the StatusBar.
//
// Note: The event on the service can be used to take on some action 
//	when the user performs certain actions on the Status Bar.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Notify the service that a right button up has occurred on the StatusBar.
If IsValid(iw_parentwindow) Then
	iw_parentwindow.inv_statusbar.Event pfc_StatusBarrbuttonup (xpos, ypos, dwo.Name)
end If

// Keep focus on the Frame.
If IsValid(iw_parentwindow) Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-09-12 By: Liang QingShi
	//$<reason> SetFocus(iw_parentwindow) is unsupported.
	//	SetFocus(iw_parentwindow)

	iw_parentwindow.SetFocus()
	//---------------------------- APPEON END ----------------------------
End If
end event

event doubleclicked;call super::doubleclicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  doubleclicked
//
//	Returns:	None
//
//	Description:
//	Notification from the GUI StatusBar.
// Notify the service that a doubleclicked has occurred on the StatusBar.
//
// Note: The event on the service can be used to take on some action 
//	when the user performs certain actions on the Status Bar.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Notify the service that a doubleclicked has occurred on the StatusBar.
If IsValid(iw_parentwindow) Then
	iw_parentwindow.inv_statusbar.Event pfc_StatusBarDoubleClick (xpos, ypos, dwo.Name)
end If

// Keep focus on the Frame.
If IsValid(iw_parentwindow) Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-09-12 By: Liang QingShi
	//$<reason> SetFocus(iw_parentwindow) is unsupported.
	//	SetFocus(iw_parentwindow)

	iw_parentwindow.SetFocus()
	//---------------------------- APPEON END ----------------------------
End If
end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////////////
//
//	Event:  clicked
//
//	Returns:	None
//
//	Description:
//	Notification from the GUI StatusBar.
// Notify the service that a click has occurred on the StatusBar.
//
// Note: The event on the service can be used to take on some action 
//	when the user performs certain actions on the Status Bar.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Notify the service that a click has occurred on the StatusBar.
If IsValid(iw_parentwindow) Then
	iw_parentwindow.inv_statusbar.Event pfc_StatusBarClicked (xpos, ypos, dwo.Name)
end If

// Keep focus on the Frame.
If IsValid(iw_parentwindow) Then
//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-09-12 By: Liang QingShi
	//$<reason> SetFocus(iw_parentwindow) is unsupported.
	//	SetFocus(iw_parentwindow)

	iw_parentwindow.SetFocus()

	//---------------------------- APPEON END ----------------------------
End If
end event

event getfocus;// Override Ancestor. 
end event

event rbuttondown;// Override Ancestor. 

//////////////////////////////////////////////////////////////////////////////
//
//	Event:  rbuttondown
//
//	Returns:	None
//
//	Description:
// Keep focus on the Frame.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	5.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
//
//	Copyright © 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////

// Keep focus on the Frame.
If IsValid(iw_parentwindow) Then
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 2005-09-12 By: Liang QingShi
	//$<reason> SetFocus(iw_parentwindow) is unsupported.
	//	SetFocus(iw_parentwindow)

	iw_parentwindow.SetFocus()
	//---------------------------- APPEON END ----------------------------
End If
end event

