$PBExportHeader$appeonfileservice.sru
forward
global type appeonfileservice from nonvisualobject
end type
end forward

global type appeonfileservice from nonvisualobject
end type
global appeonfileservice appeonfileservice

type variables
String is_FileServerName
String is_LogOnParams
Long 	 il_Id
end variables

forward prototypes
public function long of_logonfileserver (string fileserveripaddress, long port, string connectstring)
public function long of_logofffileserver ()
public function long of_appeondownload (string source, string target)
public function long of_downloadfile (string source, string target)
public function integer of_print2pdf (powerobject adw)
public function string of_uploadfile (string source, string url, boolean isrename, ref long errorcode)
public function string of_appeonupload (string source, string destination, boolean isrename, ref long errorcode)
public function string of_uploadfile (string url, boolean isrename, ref long errorcode)
public function string of_appeonupload (string destination, boolean isrename, ref long errorcode)
public function string of_appeonupload (boolean isrename, ref long errorcode)
public function long of_appeondownload (string source)
public function long of_downloadfile (string source)
end prototypes

public function long of_logonfileserver (string fileserveripaddress, long port, string connectstring);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_logonfileserver()
//------------------------------------------------------------------------------
// Description: 
//               Connects to the file server.
//	
// Arguments: 
//		value	string	fileserveripaddress : The IP address of the file server.	
//		value	long port : The Port of the file server.              		
//		value	string	connectstring : User name and password for connectin to the file server.     		
//	                                             Format: "username=username;password=password".
//
// Returns:  long   0 - Succeeded.
//                       -1 - Failed to connect to the file server.
//                       -2 - User Name or password error.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 1

end function

public function long of_logofffileserver ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_logofffileserver()
//------------------------------------------------------------------------------
// Description: 
//               Disconnects to the file server.
//	
// Arguments:(None)
//	
// Returns:  long   	0 - Succeeded.
//					    -1 - Failed to connect to the file server.
//					    -2 - ID error.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 1

end function

public function long of_appeondownload (string source, string target);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_AppeonDownLoad()
//------------------------------------------------------------------------------
// Description: 
//               Downloads the specified file from the specified file server.
//	
// Arguments: 
//		value	string	source : The directory of the source file specified by the user.		
//		value	string	target	 : (Optional) The directory where the downloaded file is saved to.	
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 1

end function

public function long of_downloadfile (string source, string target);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_downloadfile()
//------------------------------------------------------------------------------
// Description: 
//               Downloads file from a specified URL.
//	
// Arguments: 
//		value	string	source : The directory of the source file specified by the user. It can be 
//                                     a URL or a local directory.
//		value	string	target		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 1

end function

public function integer of_print2pdf (powerobject adw);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::appeonprint2pdf()
//------------------------------------------------------------------------------
// Description: 
// 				Prints the specified DataWindow/DataStore as a PDF file with the 
//                PDFPrinter on the Appeon Server.
//
// Arguments: 
//		powerobject	adw : The datawindow or datastore that will be printed.
//	
// Returns:  integer 1 when suceeded. Otherwise returns -1.
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Int nRet = -1
IF adw.TypeOf() = datawindow! OR adw.TypeOf() = datastore! THEN
	nRet = adw.DYNAMIC Print()
END IF

RETURN nRet
end function

public function string of_uploadfile (string source, string url, boolean isrename, ref long errorcode);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_UploadFile()
//------------------------------------------------------------------------------
// Description: 
//               Uploads file to the Web server. 
//	
// Arguments: 
//		value	string	source : (Optional) The directory of the source file specified by the user.  		
//		value	string	url : The URL of the file that will be saved on the Web server.     		
//		value	boolean isrename : Sets whether rename the file which has the same name 
//                                            as an existing one.
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""






end function

public function string of_appeonupload (string source, string destination, boolean isrename, ref long errorcode);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_AppeonUpload()
//------------------------------------------------------------------------------
// Description: 
//               Uploads file to the FileServer.
//	
// Arguments: 
//		value	string	Source : (Optional) The directory of the source file specified by the user.	    		
//		value string 	destination : (Optional) The directory where the file is uploaded to. 
//		value boolean isrename : Sets whether rename the file which has the same name  
//                                            as an existing one. 
//       reference long errorcode : Error occured in uploading files. Values are:
//                                             0 - Succeeded.
//                                            -1 - Failed to connect to the file server.
//                                            -2 - ID error.
//                                            -3 - The format of the source file is forbidden.
//                                            -4 - Destination error.
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""

end function

public function string of_uploadfile (string url, boolean isrename, ref long errorcode);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_uploadfile()
//------------------------------------------------------------------------------
// Description: 
//               Uploads file to the Web server.
//	
// Arguments: 
//		value string 	url : The URL of the file that will be saved on the Web server.     		
//		value	boolean isrename : Sets whether rename the file which has the same name 
//                                            as an existing one. 		
//		reference long errorcode : Error occured in uploading files. Values are:
//                                             0 - Succeeded.
//                                            -1 - Failed to connect to the file server.
//                                            -2 - ID error.
//                                            -3 - The format of the source file is forbidden.
//                                            -4 - Destination error.		
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

public function string of_appeonupload (string destination, boolean isrename, ref long errorcode);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_appeonupload()
//------------------------------------------------------------------------------
// Description: 
//               Uploads file to the file server.
//	
// Arguments: 
//		value string 	destination : (Optional) The directory where the file is uploaded to. 
//		value boolean isrename : Sets whether rename the file which has the same name  
//                                            as an existing one.  		
//		reference long errorcode : Error occured in uploading files. Values are:
//                                             0 - Succeeded.
//                                            -1 - Failed to connect to the file server.
//                                            -2 - ID error.
//                                            -3 - The format of the source file is forbidden.
//                                            -4 - Destination error.
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

public function string of_appeonupload (boolean isrename, ref long errorcode);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_appeonupload()
//------------------------------------------------------------------------------
// Description: 
//               Uploads file to the file server.
//	
// Arguments: 
//		value boolean isrename : Sets whether rename the file which has the same name  
//                                            as an existing one.
//		reference long errorcode : Error occured in uploading files. Values are:
//                                             0 - Succeeded.
//                                            -1 - Failed to connect to the file server.
//                                            -2 - ID error.
//                                            -3 - The format of the source file is forbidden.
//                                            -4 - Destination error.
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

public function long of_appeondownload (string source);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_appeondownload()
//------------------------------------------------------------------------------
// Description: 
//               Downloads the specified file from the specified file server.
//	
// Arguments: 
//		value	string	source : The directory of the source file specified by the user.
//							
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 0

end function

public function long of_downloadfile (string source);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: appeonfileservice::of_downloadfile()
//------------------------------------------------------------------------------
// Description: 
//               Downloads file from a specified URL.
//	
// Arguments: 
//		value	string	source : The directory of the source file specified by the user. It can be 
//                                     a URL or a local directory.		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-11
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN 0

end function

on appeonfileservice.create
call super::create
TriggerEvent( this, "constructor" )
end on

on appeonfileservice.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

