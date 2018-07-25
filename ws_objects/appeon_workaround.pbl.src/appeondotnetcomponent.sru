$PBExportHeader$appeondotnetcomponent.sru
forward
global type appeondotnetcomponent from nonvisualobject
end type
end forward

global type appeondotnetcomponent from nonvisualobject
end type
global appeondotnetcomponent appeondotnetcomponent

type variables
//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Event: appeondotnetcomponent::Declare Instance Variables()
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


String ComponentType	// 1 is DotNet component or 2 is Com ComponentInterface
String TypeLib		  	// Component Library Name
String ClassDescript	// Component Class Name
Any 	 ReturnValue	// Call Return
String ErrorText		// Error Info

end variables

forward prototypes
public function long of_execinterface (string interfacename, ref any paralist[])
public function long of_execinterface (string interfacename)
end prototypes

public function long of_execinterface (string interfacename, ref any paralist[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondotnetcomponent::of_execinterface()
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

public function long of_execinterface (string interfacename);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeondotnetcomponent::of_execinterface()
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

on appeondotnetcomponent.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeondotnetcomponent.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

