$PBExportHeader$appeonextfuncs.sru
forward
global type appeonextfuncs from nonvisualobject
end type
end forward

global type appeonextfuncs from nonvisualobject
end type
global appeonextfuncs appeonextfuncs

forward prototypes
public function string of_getappeonusername ()
public function string of_getbrowserversion ()
public function string of_getclienttype ()
public function string of_gethttpinfo (string attribute)
public function string of_getostype ()
public function long of_getsessioncount (string servername, string appname)
public subroutine of_popmenu (datawindow adw_dw, integer nx, integer ny)
public subroutine of_popmenuon (datawindow adw_dw, boolean ab_show)
public function string of_getclientid ()
public function string of_getclientip ()
public function integer of_getservertype ()
public function string of_getcachedir ()
public function long of_getiehandle ()
public function string of_getieurl ()
end prototypes

public function string of_getappeonusername ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_getappeonusername()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the User Name that a user types into the Appeon Web Login dialogue box.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ''

end function

public function string of_getbrowserversion ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_getbrowserversion()
//------------------------------------------------------------------------------
// Description: 
// 				Returns Internet Explorer version of the client.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""

end function

public function string of_getclienttype ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_getclienttype()
//------------------------------------------------------------------------------
// Description: 
// 				Gets the type of an application. Returns "Web" if the application runs on the Web.
//                Returns "PB" if the application runs in PowerBuilder.
//	
// Arguments: (None)	
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN "PB"

end function

public function string of_gethttpinfo (string attribute);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_gethttpinfo()
//------------------------------------------------------------------------------
// Description: 
//               Returns the HTTP header information from a particular request.
//	
// Arguments: 
//		value	string	attribute : The HTTP information that need to be known.		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""
end function

public function string of_getostype ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_getostype()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the type of OS that runs your application.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

environment lenv
Integer li_return

li_return = GetEnvironment(lenv)
IF li_return <> 1 THEN RETURN ''

CHOOSE CASE lenv.OSType
	CASE aix!
		RETURN 'aix'
	CASE Windows!
		RETURN 'Windows'
	CASE WindowsNT!		
		//RETURN 'WindowsNT'
		RETURN 'WindowsNT ' + String(lenv.OSMajorRevision) +'.'+ String(lenv.OSMinorRevision) //Alfee 12.24.2008
	CASE hpux!
		RETURN 'hpux'
	CASE macintosh!
		RETURN 'macintosh'
	CASE osf1!
		RETURN 'osf1'
	CASE sol2!
		RETURN 'sol2'
	CASE ELSE
		RETURN ''
END CHOOSE


end function

public function long of_getsessioncount (string servername, string appname);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_GetSessionCount()
//------------------------------------------------------------------------------
// Description: 
//				Returns the total number of active sessions currently on a cluster.
//				If there is no cluster configured in AEM, it gets all the active sessions
//				for a single named application or all applications in Appeon Server.
//	
// Arguments: 
//		string	servername : The name of the server. 	
//		string	appname :  The name of the application.  		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 0;
end function

public subroutine of_popmenu (datawindow adw_dw, integer nx, integer ny);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_popmenu()
//------------------------------------------------------------------------------
// Description: 
//				Pops up Appeon DataWindow menu at a specified position in a 
//				specified DataWindow control.
// 
// Arguments: 
//		datawindow	adw_dw	: DataWindow control.	
//		integer nx : The x-axis of the popup menu.    		
//		integer ny : The y-axis of the popup menu.   		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

end subroutine

public subroutine of_popmenuon (datawindow adw_dw, boolean ab_show);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_popmenuon()
//------------------------------------------------------------------------------
// Description: 
//				Enable or disable the right mouse button menu of a specific 
//               Appeon DataWindow. 
//	
// Arguments: 
//		datawindow	adw_dw : DataWindow control. 		
//		boolean ab_show : Enable right mouse button.	
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


end subroutine

public function string of_getclientid ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::appeongetclientid()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the unique session identifier for the Internet Explorer client.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String ls_IP,ls_SessionID
appeonservice lnv_service
String ls_array[]
Int	li_count,li_i

//Gets IP Address
ls_IP = AppeonGetClientIP()

//Convert to array
li_count = lnv_service.of_ParseToArray(ls_IP,'.',ls_array)

FOR li_i = 1 TO li_count
	ls_SessionID += String(Integer(ls_array[li_i]),'000')
NEXT

//Gets SessionID
Randomize(32767)
ls_SessionID += String(Rand(32767),'00000')

RETURN ls_SessionID
end function

public function string of_getclientip ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::appeongetclientip()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the IP address of the Internet Explorer client.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String ls_IPAddress
appeonservice	lnv_service

//Gets Local Host IP Address
IF lnv_service.of_GetIPAddress(ls_IPAddress) = 1 THEN
	RETURN ls_IPAddress
ELSE
	RETURN ''
END IF


end function

public function integer of_getservertype ();//==============================================================================
// 
// Copyright ? 2001-2008 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeongetservertype()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the type of Appeon Server that runs your application.
//	
// Arguments:(None)
//	
// Returns:  integer
//					1 -- J2EE Server
//					2 -- .Net Server
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2008-2
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


return 1
end function

public function string of_getcachedir ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonextfuncs::of_getbrowserversion()
//------------------------------------------------------------------------------
// Description: 
// 				Returns Internet Explorer Cache Directory. Only useful in B/S mode.
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2008-2
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

//

return ""
end function

public function long of_getiehandle ();//==============================================================================
// 
// Copyright ? 2001-2008 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeongetiehandle()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the running IE handle of the Internet Explorer client.
//					Only significative in B/S mode.
// Arguments:(None)
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2008-2
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

return 0
end function

public function string of_getieurl ();//==============================================================================
// 
// Copyright ? 2001-2008 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeongetiehandle()
//------------------------------------------------------------------------------
// Description: 
// 				Returns the running IE URL of the Internet Explorer client.
//					Only significative in B/S mode.
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2008-2
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

return ""
end function

on appeonextfuncs.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeonextfuncs.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

