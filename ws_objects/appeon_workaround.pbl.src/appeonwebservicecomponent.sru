$PBExportHeader$appeonwebservicecomponent.sru
forward
global type appeonwebservicecomponent from nonvisualobject
end type
end forward

global type appeonwebservicecomponent from nonvisualobject
end type
global appeonwebservicecomponent appeonwebservicecomponent

type variables
//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: appeonwebservicecomponent::Declare Instance Variables()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2006
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================
String CallType	// 1 is DynamicProxy component or 2 is DllProxy Component
String ProxyDllOrUrl	  	// if CallType=1, here is WebService URL, Other is DLL
String ClassDescript	// Component Class Name
Any 	 ReturnValue	// Call Return
String ErrorText		// Error Info

end variables

forward prototypes
public function long of_callwebservice (string methodname, ref any paralist[])
public function long of_callwebservice (string methodname)
end prototypes

public function long of_callwebservice (string methodname, ref any paralist[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondotnetcomponent::of_callwebservice()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value    	string	interfacename		: Interface name
//		reference	any   	paralist[]   		: Array Parameter
//	
// Returns:  long Success return 0, Failed return -1
//------------------------------------------------------------------------------
// Examples:
//				AppeonDotNetComponent lu_apf
//				lu_apf = create AppeonDotNetComponent
//				any la_1[]
//				la_1[1] = "Appeon"
//				la_1[2] = 100
//				la_1[3] = 256
//				la_1[4] = "Sybase"
//				lu_apf = create AppeonDotNetComponent 
//				lu_apf.ComponentType = "1"
//				lu_apf.TypeLib = "testdotnet.dll"
//				lu_apf.ClassDescript = "interface1"
//				ll_ret = lu_apf.of_ExecInterface("test_dotnet",  la_1)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2006
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 0

end function

public function long of_callwebservice (string methodname);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondotnetcomponent::of_callwebservice()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value    	string	interfacename		: Interface name
//		reference	any   	paralist[]   		: Array Parameter
//	
// Returns:  long Success return 0, Failed return -1
//------------------------------------------------------------------------------
// Examples:
//				AppeonDotNetComponent lu_apf
//				lu_apf = create AppeonDotNetComponent 
//				lu_apf.ComponentType = "2"
//				lu_apf.TypeLib = "test.dll"
//				lu_apf.ClassDescript = "testclass"
//				ll_ret = lu_apf.of_ExecInterface("test")
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2006
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 0

end function

on appeonwebservicecomponent.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeonwebservicecomponent.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

