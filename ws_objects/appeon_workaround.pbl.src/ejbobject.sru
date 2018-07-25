$PBExportHeader$ejbobject.sru
forward
global type ejbobject from nonvisualobject
end type
end forward

global type ejbobject from nonvisualobject autoinstantiate
end type

type prototypes
// Try to connect to server
Function long ConnectToServerA(string srvUrl, string propArr[], long arrSize) Library "eonejbclient.dll" alias for "ConnectToServerA;Ansi"

// Cut off the connection between client and server
Function long DisconnectServer(long nConnID) Library "eonejbclient.dll"

// Get the ejb bean's object instance handle
Function long CreateRemoteInstanceA (long nConnID, string jndi, string homename, string homemethod, ref long pBeanID) Library "eonejbclient.dll" alias for "CreateRemoteInstanceA;Ansi"

// Destroy the ejb bean's object instance
Function long DestroyRemoteInstance(LONG nConnID, long objID) Library "eonejbclient.dll"

// Get home interface object hancle
Function long LookUpJndiA (LONG nConnID, string jndi, ref long objId) Library "eonejbclient.dll" alias for "LookUpJndiA;Ansi"

// Call bean's method
Function long CallMethodA(long nConnID, long beanID, string methodName,ref blob blRet, long flag) Library "eonejbclient.dll" alias for "CallMethodA;Ansi"

// Get the error info
Function string GetLastErrorInfoA(long nConnID) Library "eonejbclient.dll" alias for "GetLastErrorInfoA;Ansi"

// Get the Local Error Info
Function string GetLocalErrA(long nErrNum) Library "eonejbclient.dll" alias for "GetLocalErrA;Ansi"
// Init the local language
Function long InitEjbLocalSetting(long nLocal) Library "eonejbclient.dll"

// Transaction function
Function long BeginTrans(long nConnID) Library "eonejbclient.dll"
Function long CommitTrans(long nConnID) Library "eonejbclient.dll"
Function long GetStatus(long nConnID,ref long status) Library "eonejbclient.dll"
Function long RollBackTrans(long nConnID) Library "eonejbclient.dll"
Function long SetRollBackOnly(long nConnID) Library "eonejbclient.dll"
Function long SetTransactionTimeOut(long nConnID, long sec) Library "eonejbclient.dll"

// Regist the method parameter

Function long RegBool (LONG nConnID, boolean data) Library "eonejbclient.dll"
Function long RegBoolArray (LONG nConnID, boolean data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegCharA (LONG nConnID, char data) Library "eonejbclient.dll" alias for "RegCharA;Ansi"
Function long RegCharArrayA(LONG nConnID, char data[], LONG arrSize) Library "eonejbclient.dll" alias for "RegCharArrayA;Ansi"

Function long RegDate (LONG nConnID, date data) Library "eonejbclient.dll"
Function long RegDateArray (LONG nConnID, date data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegDateTime (LONG nConnID, datetime data) Library "eonejbclient.dll"
Function long RegDateTimeArray (LONG nConnID, datetime data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegTime (long nConnID, time data) Library "eonejbclient.dll"
Function long RegTimeArray (LONG nConnID, time data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegDouble (LONG nConnID, double data) Library "eonejbclient.dll"
Function long RegDoubleArray (LONG nConnID, double data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegInt (LONG nConnID, int data) Library "eonejbclient.dll"
Function long RegIntArray (LONG nConnID, int data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegLong (LONG nConnID, LONG data) Library "eonejbclient.dll"
Function long RegLongArray (LONG nConnID, LONG data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegReal (LONG nConnID, real data) Library "eonejbclient.dll"
Function long RegRealArray (LONG nConnID, real data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegUInt (LONG nConnID, UInt data) Library "eonejbclient.dll"
Function long RegUIntArray (LONG nConnID, UInt data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegULong (LONG nConnID,  Ulong data) Library "eonejbclient.dll"
Function long RegULongArray (LONG nConnID, Ulong data[] , LONG arrSize) Library "eonejbclient.dll"

Function long RegDw (LONG nConnID, datawindow data , LONG nSize) Library "eonejbclient.dll" alias for "RegDw;Ansi"
Function long RegDwArray (LONG nConnID, datawindow data[] , LONG length[], LONG arrSize) Library "eonejbclient.dll" alias for "RegDwArray;Ansi"

Function long RegDs (LONG nConnID,  datastore data , LONG nSize) Library "eonejbclient.dll" alias for "RegDs;Ansi"
Function long RegDsArray (LONG nConnID,   datastore data[], LONG length[], LONG arrSize) Library "eonejbclient.dll" alias for "RegDsArray;Ansi"

Function long RegBlob(LONG nConnID,  blob data , LONG nSize) Library "eonejbclient.dll"
Function long RegBlobArray (LONG nConnID,  blob data[] , LONG length[], LONG arrSize) Library "eonejbclient.dll"

Function long RegStringA (LONG nConnID,  string data) Library "eonejbclient.dll" alias for "RegStringA;Ansi"
Function long RegStringArrayA (LONG nConnID,  string data[], LONG arrSize) Library "eonejbclient.dll" alias for "RegStringArrayA;Ansi"

Function long RegStruA(LONG nConnID, any data, blob datatype, string javaName, long nSize) Library "eonejbclient.dll" alias for "RegStruA;Ansi"
Function long RegStruArrayA(LONG nConnID, any data[], blob datatype,long length, string javaName,  long arrSize) Library "eonejbclient.dll" alias for "RegStruArrayA;Ansi"


end prototypes

type variables
Private:
	Long il_srvId = 0
	boolean ib_IsConnect = false
	
	parse_retval_object iuo_parse	
	String ERR_NOT_CONNECT = "You have not connectted to server now!"
	String ERR_WARNING = "Warning!"
	
	Integer TYPE_EJB = 1
	Integer Type_JAVABEAN = 2
	
end variables

forward prototypes
public function string connectserver (string url, string properties[])
public function string disconnection ()
public function string lookupjndi (string jndiname, ref long objid)
public function string createremoteinstance (string jndiname, string homename, string methodname, ref long beanid)
public function string destroyremoteinstance (long objid)
public function string begintrans ()
public function string committrans ()
public function string getstatus (ref long status)
public function string rollbacktrans ()
public function string setrollbackonly ()
public function string settransactiontimeout (long sec)
public function string regblob (blob data)
public function string regblobarray (blob data[])
public function string regbool (boolean data)
public function string regboolarray (boolean data[])
public function string regchar (character data)
public function string regchararray (character data[])
public function string regdate (date data)
public function string regdatearray (date data[])
public function string regdatetime (datetime data)
public function string regdatetimearray (datetime data[])
public function string regdouble (double data)
public function string regdoublearray (double data[])
public function string regint (integer data)
public function string regintarray (integer data[])
public function string reglong (long data)
public function string reglongarray (long data[])
public function string regreal (real data)
public function string regrealarray (real data[])
public function string regstring (string data)
public function string regstringarray (string data[])
public function string regtime (time data)
public function string regtimearray (time data[])
public function string reguint (unsignedinteger data)
public function string reguintarray (unsignedinteger data[])
public function string regulong (unsignedlong data)
public function string regulongarray (unsignedlong data[])
public function string regdw (datawindow data)
public function string regdwarray (datawindow data[])
public function string regds (datastore data)
public function string regdsarray (datastore data[])
public function string invokeretblob (long objid, string methodname, boolean autoremove, ref blob retval)
public function string invokeretblobarray (long objid, string methodname, boolean autoremove, ref blob retval[])
public function string invokeretbool (long objid, string methodname, boolean autoremove, ref boolean retval)
public function string invokeretboolarray (long objid, string methodname, boolean autoremove, ref boolean retval[])
public function string invokeretchar (long objid, string methodname, boolean autoremove, ref character retval)
public function string invokeretchararray (long objid, string methodname, boolean autoremove, ref character retval[])
public function string invokeretdate (long objid, string methodname, boolean autoremove, ref date retval)
public function string connectserver (string url, string properties[])
public function string disconnection ()
public function string lookupjndi (string jndiname, ref long objid)
public function string createremoteinstance (string jndiname, string homename, string methodname, ref long beanid)
public function string destroyremoteinstance (long objid)
public function string begintrans ()
public function string committrans ()
public function string getstatus (ref long status)
public function string rollbacktrans ()
public function string setrollbackonly ()
public function string settransactiontimeout (long sec)
public function string regblob (blob data)
public function string regblobarray (blob data[])
public function string regbool (boolean data)
public function string regboolarray (boolean data[])
public function string regchar (character data)
public function string regchararray (character data[])
public function string regdate (date data)
public function string regdatearray (date data[])
public function string regdatetime (datetime data)
public function string regdatetimearray (datetime data[])
public function string regdouble (double data)
public function string regdoublearray (double data[])
public function string regint (integer data)
public function string regintarray (integer data[])
public function string reglong (long data)
public function string reglongarray (long data[])
public function string regreal (real data)
public function string regrealarray (real data[])
public function string regstring (string data)
public function string regstringarray (string data[])
public function string regtime (time data)
public function string regtimearray (time data[])
public function string reguint (unsignedinteger data)
public function string reguintarray (unsignedinteger data[])
public function string regulong (unsignedlong data)
public function string regulongarray (unsignedlong data[])
public function string regdw (datawindow data)
public function string regdwarray (datawindow data[])
public function string regds (datastore data)
public function string regdsarray (datastore data[])
public function string invokeretblob (long objid, string methodname, boolean autoremove, ref blob retval)
public function string invokeretblobarray (long objid, string methodname, boolean autoremove, ref blob retval[])
public function string invokeretbool (long objid, string methodname, boolean autoremove, ref boolean retval)
public function string invokeretboolarray (long objid, string methodname, boolean autoremove, ref boolean retval[])
public function string invokeretchar (long objid, string methodname, boolean autoremove, ref character retval)
public function string invokeretchararray (long objid, string methodname, boolean autoremove, ref character retval[])
public function string invokeretdate (long objid, string methodname, boolean autoremove, ref date retval)
public function string invokeretdatearray (long objid, string methodname, boolean autoremove, ref date retval[])
public function string invokeretdatetime (long objid, string methodname, boolean autoremove, ref datetime retval)
public function string invokeretdatetimearray (long objid, string methodname, boolean autoremove, ref datetime retval[])
public function string invokeretdouble (long objid, string methodname, boolean autoremove, ref double retval)
public function string invokeretdoublearray (long objid, string methodname, boolean autoremove, ref double retval[])
public function string invokeretint (long objid, string methodname, boolean autoremove, ref integer retval)
public function string invokeretintarray (long objid, string methodname, boolean autoremove, ref integer retval[])
public function string invokeretlong (long objid, string methodname, boolean autoremove, ref long retval)
public function string invokeretlongarray (long objid, string methodname, boolean autoremove, ref long retval[])
public function string invokeretreal (long objid, string methodname, boolean autoremove, ref real retval)
public function string invokeretrealarray (long objid, string methodname, boolean autoremove, ref real retval[])
public function string invokeretstring (long objid, string methodname, boolean autoremove, ref string retval)
public function string invokeretstringarray (long objid, string methodname, boolean autoremove, ref string retval[])
public function string invokerettime (long objid, string methodname, boolean autoremove, ref time retval)
public function string invokerettimearray (long objid, string methodname, boolean autoremove, ref time retval[])
public function string invokeretuint (long objid, string methodname, boolean autoremove, ref unsignedinteger retval)
public function string invokeretuintarray (long objid, string methodname, boolean autoremove, ref unsignedinteger retval[])
public function string invokeretulong (long objid, string methodname, boolean autoremove, ref unsignedlong retval)
public function string invokeretulongarray (long objid, string methodname, boolean autoremove, ref unsignedlong retval[])
public function string invokeretdw (long objid, string methodname, boolean autoremove, ref datawindow retval)
public function string invokeretdwarray (long objid, string methodname, boolean autoremove, ref datawindow retval[])
public function string invokeretds (long objid, string methodname, boolean autoremove, ref datastore retval)
public function string invokeretdsarray (long objid, string methodname, boolean autoremove, ref datastore retval[])
public function string ejbsharedata (datawindow dwdes, blob data, boolean reset)
public function string ejbsharedata (datastore dsdes, blob data, boolean reset)
public function string regstructarray (any data[], string javaclassname, classdefinition cdef)
protected function long invoke_complex (long objid, string methodname, ref blob blbuf, ref string strerr)
protected function long invoke_simple (long objid, string methodname, ref blob blbuf, ref string strerr)
public function string regstruct (any data, string javaclassname, readonly classdefinition cdef)
public function string invokeretstru (long objid, string methodname, boolean autoremove, ref blob retval)
public function string invokeretstruarray (long objid, string methodname, boolean autoremove, ref blob retval[])
public function string invokeretvoid (long objid, string methodname, boolean autoremove)
public function long initlocallanguage (long nlocalcode)
public function string geterrorstrinfo (long al_errorid)
public function string connectserver (string url, string properties[], integer ai_type)
public function string createjavainstance (string name, ref long beanid)
end prototypes

public function string connectserver (string url, string properties[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::connectserver()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		string	url         		
//		string	properties[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_srvid, ll_arrSize
String ls_err = ""

// User should disconnect the server before reconnect to new server
IF ib_IsConnect THEN
	ls_err = GetLocalErrA(6002)
	MessageBox(ERR_WARNING, ls_err, Exclamation!, OK!)
ELSE

	// Get the size of property array size
	ll_arrSize = UpperBound(properties)
	
	// Call dll proxy
	ll_srvid = ConnectToServerA(url, properties[], ll_arrSize)
	
	IF ll_srvid <> 0 THEN
		il_srvId = ll_srvid
		ib_IsConnect = TRUE
	ELSE
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string disconnection ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::disconnection()
//------------------------------------------------------------------------------
// Description: Disconnect to server
// 
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long 	 ll_ret
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	IF il_srvId <> 0 THEN
		ll_ret = DisconnectServer(il_srvId)
		IF ll_ret = 1 THEN
			il_srvId = 0
			ib_IsConnect = FALSE
		ELSE
			ls_err = GetLastErrorInfoA(il_srvId)
		END IF
	END IF
END IF

RETURN ls_err



end function

public function string lookupjndi (string jndiname, ref long objid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::lookupjndi()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		      	string	jndiname		
//		ref   	long    	objid		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	RETURN ERR_NOT_CONNECT
ELSE
	
	ll_ret = LookUpJndiA(il_srvId, jndiname, REF objid)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string createremoteinstance (string jndiname, string homename, string methodname, ref long beanid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::createremoteinstance()
//------------------------------------------------------------------------------
// Description: User should connect the server before create any bean instance
// 
//	
// Arguments: 
//		      	string	jndiname  		
//		      	string	homename  		
//		      	string	methodname		
//		ref   	long     beanid		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = CreateRemoteInstanceA (il_srvId, jndiname, homename, methodname, REF beanid)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string destroyremoteinstance (long objid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::destroyremoteinstance()
//------------------------------------------------------------------------------
// Description: User should connect the server before create any bean instance
// 
//	
// Arguments: 
//		long	objid		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	ll_ret = DestroyRemoteInstance (il_srvId, objID)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string begintrans ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::begintrans() 
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret, ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE

	ll_ret = BeginTrans (il_srvId)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string committrans ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::committrans()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret, ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE

	ll_ret = CommitTrans (il_srvId)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string getstatus (ref long status);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::getstatus()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	long	status		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

// 0: ACTIVE
// 1: MAKED ROLLBACK
// 2: PREPARED
// 3: COMMITTED
// 4: ROLLEDBACK
// 5: UNKNOWN
// 6: NO TRANSACTION
// 7:	PREPARING
// 8:	COMMITTING
// 9:	ROLLING BACK

Long ll_ret
Long ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSe
	
	ll_ret = GetStatus(il_srvId,REF status)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string rollbacktrans ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::rollbacktrans()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RollBackTrans(il_srvId)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string setrollbackonly ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::setrollbackonly()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""


IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = SetRollBackOnly(il_srvId)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string settransactiontimeout (long sec);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::settransactiontimeout()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		long	sec		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""
IF sec < 0 THEN
	ls_err = GetLocalErrA(6004)
	MessageBox(ERR_WARNING, ls_err, Exclamation!, OK!)
	RETURN ls_err
END IF
	

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE

	ll_ret = SetTransactionTimeOut(il_srvId, sec)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regblob (blob data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regblob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		blob	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
Long ll_bloblen
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_bloblen = LenA(Data)
	
	ll_ret = RegBlob(il_srvId, Data, ll_bloblen)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regblobarray (blob data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regblobarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		blob	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
Long ll_bloblen
String ls_err = ""
Long ll_bloblenarr[]
Long ll_i

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	FOR ll_i = 1 TO UpperBound(Data)
		ll_bloblenarr[ll_i] = LenA(Data[ll_i])
	NEXT
	
	ll_ret = RegBlobArray(il_srvId, Data, ll_bloblenarr,UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF	
END IF

RETURN ls_err


end function

public function string regbool (boolean data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regbool()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		boolean	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err  = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegBool (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string regboolarray (boolean data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regboolarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		boolean	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegBoolArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regchar (character data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regchar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		character	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegCharA (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regchararray (character data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regchararray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		character	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegCharArrayA(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string regdate (date data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		date	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDate (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regdatearray (date data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdatearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		date	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDateArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regdatetime (datetime data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datetime	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err  = ""


IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDateTime (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regdatetimearray (datetime data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdatetimearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datetime	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDateTimeArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regdouble (double data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		double	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDouble (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err


end function

public function string regdoublearray (double data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdoublearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		double	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegDoubleArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regint (integer data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		integer	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegInt (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regintarray (integer data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regintarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		integer	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegIntArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string reglong (long data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::reglong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		long	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegLong (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string reglongarray (long data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::reglongarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		long	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegLongArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regreal (real data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regreal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		real	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegReal (il_srvId, Data)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regrealarray (real data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regrealarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		real	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegRealArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regstring (string data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regstring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		string	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegStringA (il_srvId, Data)
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regstringarray (string data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regstringarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		string	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegStringArrayA(il_srvId, Data, UpperBound(Data))
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regtime (time data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regtime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		time	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegTime (il_srvId, Data)	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regtimearray (time data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regtimearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		time	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegTimeArray(il_srvId, Data, UpperBound(Data))	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string reguint (unsignedinteger data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::reguint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		unsignedinteger	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegUInt (il_srvId, Data)	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string reguintarray (unsignedinteger data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::reguintarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		unsignedinteger	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegUIntArray(il_srvId, Data, UpperBound(Data))
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regulong (unsignedlong data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		unsignedlong	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegULong (il_srvId, Data)	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regulongarray (unsignedlong data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regulongarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		unsignedlong	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
String ls_err = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	
	ll_ret = RegULongArray(il_srvId, Data, UpperBound(Data))
	
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string regdw (datawindow data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdw()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datawindow	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

MessageBox(ERR_WARNING,GetLocalErrA(5052))
RETURN ""

end function

public function string regdwarray (datawindow data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdwarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datawindow	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

MessageBox(ERR_WARNING,GetLocalErrA(5054))
RETURN ""

end function

public function string regds (datastore data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regds()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datastore	data		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

MessageBox(ERR_WARNING,GetLocalErrA(5051))
RETURN ""


end function

public function string regdsarray (datastore data[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regdsarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datastore	data[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

MessageBox(ERR_WARNING,GetLocalErrA(5053))
RETURN ""

end function

public function string invokeretblob (long objid, string methodname, boolean autoremove, ref blob retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretblob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	blob     retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)

IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getblob(retval, lbl_data, ls_err)
END IF

RETURN ls_err




end function

public function string invokeretblobarray (long objid, string methodname, boolean autoremove, ref blob retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretblobarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	blob      	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getblobarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err


end function

public function string invokeretbool (long objid, string methodname, boolean autoremove, ref boolean retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretbool()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	boolean   	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getboolean(retval, lbl_data, ls_err)
END IF

RETURN ls_err


end function

public function string invokeretboolarray (long objid, string methodname, boolean autoremove, ref boolean retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretboolarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	boolean  retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getbooleanarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretchar (long objid, string methodname, boolean autoremove, ref character retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretchar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	character retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getchar(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretchararray (long objid, string methodname, boolean autoremove, ref character retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretchararray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	character retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getchararr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdate (long objid, string methodname, boolean autoremove, ref date retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	date     retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdate(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdatearray (long objid, string methodname, boolean autoremove, ref date retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdatearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	date     retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdatearr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdatetime (long objid, string methodname, boolean autoremove, ref datetime retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datetime retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdatetime(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdatetimearray (long objid, string methodname, boolean autoremove, ref datetime retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdatetimearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datetime retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdatetimearr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdouble (long objid, string methodname, boolean autoremove, ref double retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	double   retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdouble(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdoublearray (long objid, string methodname, boolean autoremove, ref double retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdoublearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	double   retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdoublearr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretint (long objid, string methodname, boolean autoremove, ref integer retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	integer   	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getint(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretintarray (long objid, string methodname, boolean autoremove, ref integer retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretintarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	integer  retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getintarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretlong (long objid, string methodname, boolean autoremove, ref long retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretlong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	long      	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getlong(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretlongarray (long objid, string methodname, boolean autoremove, ref long retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretlongarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	long      	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getlongarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretreal (long objid, string methodname, boolean autoremove, ref real retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretreal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	real      	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getreal(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretrealarray (long objid, string methodname, boolean autoremove, ref real retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretrealarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	real     retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getrealarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretstring (long objid, string methodname, boolean autoremove, ref string retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretstring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	string   retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getstring(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretstringarray (long objid, string methodname, boolean autoremove, ref string retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretstringarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	string   retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getstringarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokerettime (long objid, string methodname, boolean autoremove, ref time retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokerettime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	time      	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_gettime(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokerettimearray (long objid, string methodname, boolean autoremove, ref time retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokerettimearray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	time      	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_gettimearr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretuint (long objid, string methodname, boolean autoremove, ref unsignedinteger retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretuint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid          		
//		       	string 	methodname     		
//		       	boolean	autoremove     		
//		ref    	unsignedinteger	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getuint(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretuintarray (long objid, string methodname, boolean autoremove, ref unsignedinteger retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretuintarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid          		
//		       	string 	methodname     		
//		       	boolean	autoremove     		
//		ref    	unsignedinteger	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getuintarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretulong (long objid, string methodname, boolean autoremove, ref unsignedlong retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid       		
//		       	string 	methodname  		
//		       	boolean	autoremove  		
//		ref    	unsignedlong	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid,methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getulong(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretulongarray (long objid, string methodname, boolean autoremove, ref unsignedlong retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretulongarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid       		
//		       	string 	methodname  		
//		       	boolean	autoremove  		
//		ref    	unsignedlong	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getulongarr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdw (long objid, string methodname, boolean autoremove, ref datawindow retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdw()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datawindow	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdataWindow(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdwarray (long objid, string methodname, boolean autoremove, ref datawindow retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdwarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datawindow	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdataWindowArr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretds (long objid, string methodname, boolean autoremove, ref datastore retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretds()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datastore 	retval		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdatastore(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string invokeretdsarray (long objid, string methodname, boolean autoremove, ref datastore retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretdsarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		       	long   	objid     		
//		       	string 	methodname		
//		       	boolean	autoremove		
//		ref    	datastore 	retval[]		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getdatastoreArr(retval, lbl_data, ls_err)
END IF

RETURN ls_err

end function

public function string ejbsharedata (datawindow dwdes, blob data, boolean reset);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::ejbsharedata()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datawindow	dwdes		
//		blob      	data 		
//		boolean   	reset		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""
end function

public function string ejbsharedata (datastore dsdes, blob data, boolean reset);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::ejbsharedata()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		datastore	dsdes		
//		blob     	data 		
//		boolean  	reset		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ""

end function

public function string regstructarray (any data[], string javaclassname, classdefinition cdef);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regstruct()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		any            	data         		
//		string         	javaclassname		
//		classdefinition	cdef         		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_Send
Long ll_ret = -1
String ls_RetErr = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_RetErr = ERR_NOT_CONNECT
ELSE
	
	ll_ret = iuo_parse.of_regstruct(cdef, TRUE, 1, UpperBound(Data), lbl_Send, javaclassname)
	
	IF ll_ret = -1 THEN
		iuo_parse.of_getlasterror(ls_RetErr)
		MessageBox(ERR_WARNING, ls_RetErr, Exclamation!, OK!)
	ELSE
		ll_ret = RegStruArrayA(il_srvId, Data, lbl_Send, LenA(lbl_Send), javaclassname, UpperBound(Data))
		
		IF ll_ret = -1 THEN
			ls_RetErr = GetLastErrorInfoA(il_srvId)
		END IF
	END IF
END IF

RETURN ls_RetErr


end function

protected function long invoke_complex (long objid, string methodname, ref blob blbuf, ref string strerr);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invoke_complex()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		      	long  	objid     		
//		      	string	methodname		
//		ref   	blob     blbuf 		
//		ref   	string   strerr		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1, ll_blobsize
strerr = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	strerr = ERR_NOT_CONNECT
	RETURN ll_ret
END IF

ll_ret = CallMethodA(il_srvId, objid, methodname,REF blbuf, 0)

IF ll_ret = -1 THEN
	strerr = GetLastErrorInfoA(il_srvId)
ELSE
	IF ll_ret > 0 THEN
		ll_blobsize = iuo_parse.of_alloc_blob(REF blbuf, ll_ret)
		IF ll_blobsize >= ll_ret THEN
			ll_ret = CallMethodA(il_srvId, objid, methodname, REF blbuf, 1)
			IF ll_ret = -1 THEN
				strerr = GetLastErrorInfoA(il_srvId)
			ELSE
				ll_ret = 1
			END IF
		ELSE
			ll_ret = -1
			strerr = GetLocalErrA(6003)
		END IF
	END IF
END IF

RETURN ll_ret

end function

protected function long invoke_simple (long objid, string methodname, ref blob blbuf, ref string strerr);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invoke_simple()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		      	long  	objid     		
//		      	string	methodname		
//		ref   	blob     blbuf 		
//		ref   	string   strerr		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = -1
Blob{100} lbl_blob
strerr = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	strerr = ERR_NOT_CONNECT
	RETURN ll_ret
END IF

IF LenA(blbuf) < 100 THEN
	blbuf += lbl_blob
END IF

ll_ret = CallMethodA(il_srvId, objid, methodname,REF blbuf, 2)

IF ll_ret = -1 THEN
	strerr = GetLastErrorInfoA(il_srvId)
ELSE
	ll_ret = 1
END IF

RETURN ll_ret

end function

public function string regstruct (any data, string javaclassname, readonly classdefinition cdef);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::regstruct()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		any            	data         		
//		string         	javaclassname		
//		classdefinition	cdef         		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_Send
Long ll_ret = -1
String ls_RetErr = ""

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_RetErr = ERR_NOT_CONNECT
ELSE
	
	ll_ret = iuo_parse.of_regstruct(cdef, FALSE, 1, 1, lbl_Send, javaclassname)
	
	IF ll_ret = -1 THEN
		iuo_parse.of_getlasterror(ls_RetErr)
		MessageBox(ERR_WARNING, ls_RetErr, Exclamation!, OK!)
	ELSE
		ll_ret = RegStruA(il_srvId, Data, lbl_Send, javaclassname, LenA(lbl_Send))
		
		IF ll_ret = -1 THEN
			ls_RetErr = GetLastErrorInfoA(il_srvId)
		END IF
	END IF
END IF

RETURN ls_RetErr


end function

public function string invokeretstru (long objid, string methodname, boolean autoremove, ref blob retval);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretstru()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value    	long   	objid     		
//		value    	string 	methodname		
//		value    	boolean	autoremove		
//		reference	blob   	retval    		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_Data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_Data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getstru(retval, lbl_Data, ls_err)
END IF


RETURN ls_err

end function

public function string invokeretstruarray (long objid, string methodname, boolean autoremove, ref blob retval[]);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretstruarray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value    	long   	objid     		
//		value    	string 	methodname		
//		value    	boolean	autoremove		
//		reference	blob   	retval[]  		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_complex(objid, methodname, lbl_data, REF ls_err)
IF ll_ret = 1 THEN
	ll_ret = iuo_parse.of_getstruArr(retval, lbl_data, ls_err)
END IF

RETURN ls_err


end function

public function string invokeretvoid (long objid, string methodname, boolean autoremove);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::invokeretvoid()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	long   	objid     		
//		value	string 	methodname		
//		value	boolean	autoremove		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_data
Long ll_ret = -1
String ls_err = ""

ll_ret = invoke_simple(objid, methodname, lbl_data, REF ls_err)

RETURN ls_err



end function

public function long initlocallanguage (long nlocalcode);long l_ret
l_ret = InitEjbLocalSetting(nlocalcode) 
ERR_NOT_CONNECT = GetLocalErrA(6001)
ERR_WARNING = GetLocalErrA(7001)
return l_ret

end function

public function string geterrorstrinfo (long al_errorid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::GetErrorStrInfo()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	long	al_errorid		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN GetLocalErrA(al_errorid)

end function

public function string connectserver (string url, string properties[], integer ai_type);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::connectserver()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly	string 	url         		
//		readonly	string 	properties[]		
//		value   	integer	ai_type     EJB = 1
//												JAVABEAN = 2
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2006-03
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_srvid, ll_arrSize
String ls_err = ""

// User should disconnect the server before reconnect to new server
IF ib_IsConnect THEN
	ls_err = GetLocalErrA(6002)
	MessageBox(ERR_WARNING, ls_err, Exclamation!, OK!)
ELSE

	// Get the size of property array size
	if (Type_JAVABEAN = ai_type) THEN properties[6]="bean"
	ll_arrSize = UpperBound(properties)
	
	// Call dll proxy
	ll_srvid = ConnectToServerA(url, properties[], ll_arrSize)
	
	IF ll_srvid <> 0 THEN
		il_srvId = ll_srvid
		ib_IsConnect = TRUE
	ELSE
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err

end function

public function string createjavainstance (string name, ref long beanid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbobject::createjavainstance()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	string	name  		
//		value	long  	beanid		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2006-03
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret
Long ll_arrSize
String ls_err = ""
String strHomeName

IF ib_IsConnect = FALSE  THEN
	MessageBox(ERR_WARNING,ERR_NOT_CONNECT,Exclamation!,OK!)
	ls_err = ERR_NOT_CONNECT
ELSE
	ll_ret = CreateRemoteInstanceA (il_srvId, name, strHomeName, strHomeName, REF beanid)
	IF ll_ret = -1 THEN
		ls_err = GetLastErrorInfoA(il_srvId)
	END IF
END IF

RETURN ls_err
end function

on ejbobject.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ejbobject.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;il_srvId = -1

ERR_NOT_CONNECT = GetLocalErrA(6001)
ERR_WARNING = GetLocalErrA(7001)
end event

event destructor;//IF ib_IsConnect= TRUE  THEN
//	DisconnectServer(il_srvId)
//	ib_IsConnect = FALSE
//	il_srvId =0
//end if
end event

