$PBExportHeader$parse_retval_object.sru
forward
global type parse_retval_object from nonvisualobject
end type
end forward

global type parse_retval_object from nonvisualobject autoinstantiate
end type

type prototypes
// Get the Local Error Info
Function string GetLocalErrA(long nErrNum) Library "eonejbclient.dll" alias for "GetLocalErrA;Ansi"
end prototypes

type variables
Private:
	Integer DATATYPE_LEN = 2
  
	// simple variable type
	constant int EAG_CHAR = 0
	constant int EAG_STRING = 1
	constant int EAG_BOOL = 2
	constant int EAG_INT = 3
	constant int EAG_UINT = 4
	constant int EAG_LONG = 5
	constant int EAG_ULONG = 6
	constant int EAG_LONGLONG = 7 	// no supported
	constant int EAG_REAL = 8
	constant int EAG_DOUBLE = 9
	constant int EAG_DECIMAL = 10 	// the same as double
	constant int EAG_NUMBER = 11 		// no supported
	constant int EAG_TIMESTAMP = 12 	// no supported
	constant int EAG_DATETIME = 13
	constant int EAG_DATE = 14
	constant int EAG_TIME = 15
	constant int EAG_BLOB = 16
	constant int EAG_DS = 20
	constant int EAG_DW = 21	
	
	constant int EAG_ARRAY = 32
	constant int EAG_STRUCT = 64
	
	String is_LastError

end variables

forward prototypes
public function long of_alloc_blob (ref blob ab_refblob, long al_size)
public function long of_getblob (ref blob retval, ref blob bl, ref string errinfo)
public function long of_getulong (ref unsignedlong retval, ref blob bl, ref string errinfo)
public function long of_getblobarr (ref blob retval[], ref blob bl, ref string errinfo)
public function long of_getdatastoreArr (ref datastore retval[], ref blob bl, ref string errinfo)
public function long of_getboolean (ref boolean retval, ref blob bl, ref string errinfo)
public function long of_getbooleanarr (ref boolean retval[], ref blob bl, ref string errinfo)
public function long of_getchar (ref character retval, ref blob bl, ref string errinfo)
public function long of_getstring (ref string retval, ref blob bl, ref string errinfo)
public function long of_getuintarr (ref unsignedinteger retval[], ref blob bl, ref string errinfo)
public function long of_getchararr (ref character retval[], ref blob bl, ref string errinfo)
public function long of_getdatastore (ref datastore retval, ref blob bl, ref string errinfo)
public function long of_getdatawindow (ref datawindow retval, ref blob bl, ref string errinfo)
public function long of_getdatawindowArr (ref datawindow retval[], ref blob bl, ref string errinfo)
public function long of_getdate (ref date retval, ref blob bl, ref string errinfo)
public function long of_getdatearr (ref date retval[], ref blob bl, ref string errinfo)
public function long of_getdatetime (ref datetime retval, ref blob bl, ref string errinfo)
public function long of_getdatetimearr (ref datetime retval[], ref blob bl, ref string errinfo)
public function long of_getdouble (ref double retval, ref blob bl, ref string errinfo)
public function long of_getdoublearr (ref double retval[], ref blob bl, ref string errinfo)
public function long of_getint (ref integer retval, ref blob bl, ref string errinfo)
public function long of_getintarr (ref integer retval[], ref blob bl, ref string errinfo)
public function long of_getlong (ref long retval, ref blob bl, ref string errinfo)
public function long of_getlongarr (ref long retval[], ref blob bl, ref string errinfo)
public function long of_getreal (ref real retval, ref blob bl, ref string errinfo)
public function long of_getrealarr (ref real retval[], ref blob bl, ref string errinfo)
public function long of_getstringarr (ref string retval[], ref blob bl, ref string errinfo)
public function long of_gettime (ref time retval, ref blob bl, ref string errinfo)
public function long of_gettimearr (ref time retval[], ref blob bl, ref string errinfo)
public function long of_getuint (ref unsignedinteger retval, ref blob bl, ref string errinfo)
public function long of_getulongarr (ref unsignedlong retval[], ref blob bl, ref string errinfo)
public subroutine of_getlasterror (ref string as_lasterror)
public function integer of_write_strumem (readonly classdefinition cdef, string as_name, ref blob blobret)
public function integer of_maptype (string as_type, boolean ab_valid)
private function integer of_regstruct (readonly typedefinition typedef, boolean ab_array, long al_dimension, long al_upperbound[], ref blob abl_ret)
public function long of_write_struarrhead (long al_dimension, long al_upperbound[], ref blob abl_head)
public function long of_getstru (ref blob retval, ref blob bl, ref string errinfo)
public function long of_getstruarr (ref blob retval[], ref blob bl, ref string errinfo)
private function long of_gethead (readonly blob bl, ref long al_currpos, ref integer ai_arrtag, ref integer ai_type)
public function long of_getifnull (readonly blob bl, ref long al_currpos)
public function integer of_gethead (readonly blob bl, ref long al_currpos, ref integer ai_type)
public function long of_regstruct (readonly classdefinition cdef, boolean ab_array, long al_dimension, long al_upperbound, ref blob abl_ret, readonly string as_classname)
end prototypes

public function long of_alloc_blob (ref blob ab_refblob, long al_size);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_alloc_blob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//			blob   	ab_refblob		 
//						al_size		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_loop,ll_mod,ll_i
Blob{1024} lbl_initSize
Blob lbl_temp

ll_loop = al_size / 1024
ll_mod = Mod(al_size,1024)

FOR ll_i = 1 TO ll_loop
	lbl_temp += lbl_initSize
NEXT

ab_refBlob = lbl_temp + Blob(Space(ll_mod),EncodingAnsi!) //Encoding – Nova 11.16.2010

RETURN LenA(ab_refBlob)

end function

public function long of_getblob (ref blob retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getblob()
//------------------------------------------------------------------------------
// Description: 
// 	Type£¨2£©£«DataLen£¨4£©£« Data
//	
// Arguments: 
//		ref	blob  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_contLen, ll_CurrPos = 1, ll_ret = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

If li_type = EAG_BLOB Then
	ll_contLen = Long(BlobMid(bl, ll_CurrPos, 4))	
	ll_CurrPos += 4
	
	retval = BlobMid(bl, ll_CurrPos, ll_contLen)
Else
	errinfo = GetLocalErrA(1016)
	ll_ret = - 1
End If

Return ll_ret
end function

public function long of_getulong (ref unsignedlong retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	unsignedlong	retval 		
//		ref	blob        	bl     		
//		ref	string      	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

If li_type = EAG_ULONG or li_type = EAG_LONGLONG Then
	retval = Long(BlobMid(bl, ll_CurrPos, 4))
Else
	errinfo = GetLocalErrA(2006)
	ll_ret = - 1
End If

return ll_ret
end function

public function long of_getblobarr (ref blob retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getblobArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	blob  	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i, ll_contLen

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_BLOB = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		ll_contLen = Long(BlobMid(bl, ll_currPos, 4))
		ll_currPos += 4;
		
		retval[i] = BlobMid(bl, ll_currPos, ll_contLen)
		ll_currPos += ll_contLen;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2016)
	ll_ret = - 1
END IF

RETURN ll_ret


end function

public function long of_getdatastoreArr (ref datastore retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatastoreArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	datastore	retval[]		
//		ref	blob     	bl      		
//		ref	string   	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


RETURN 0

end function

public function long of_getboolean (ref boolean retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getboolean()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	boolean	retval 		
//		ref	blob   	bl     		
//		ref	string 	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_BOOL THEN
	IF 1 = Integer(BlobMid(bl, ll_CurrPos, 2)) THEN
		retval = TRUE
	ELSE
		retval = FALSE
	END IF
ELSE
	errinfo = GetLocalErrA(1002)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getbooleanarr (ref boolean retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getbooleanArray()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	boolean	retval[]		
//		ref	blob   	bl      		
//		ref	string 	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_BOOL = li_type Then
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound= Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	For i = 1 To li_dimension*li_upperbound
		If 1 = Integer(BlobMid(bl, ll_currPos, 2)) Then
			retval[i] = True
		Else
			retval[i] = False
		End If
		ll_currPos += 2;
	Next
	
Else
	errinfo = GetLocalErrA(2002)
	ll_ret = - 1
End If

Return ll_ret
end function

public function long of_getchar (ref character retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getchar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	character	retval 		
//		ref	blob     	bl     		
//		ref	string   	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_CHAR THEN
	retval = CharA(BlobMid(bl, ll_CurrPos, 1))
ELSE
	errinfo = GetLocalErrA(1000)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getstring (ref string retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getstring()
//------------------------------------------------------------------------------
// Description: 
// 	Type£¨2£©£«DataLen£¨4£©£« Data
//	
// Arguments: 
//		ref	string	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_contLen, ll_CurrPos = 1, ll_ret = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_STRING THEN
	ll_contLen = Long(BlobMid(bl, ll_CurrPos, 4))	
	ll_CurrPos += 4
	
	retval = String(BlobMid(bl, ll_CurrPos, ll_contLen))
ELSE
	errinfo = GetLocalErrA(1001)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getuintarr (ref unsignedinteger retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getuintArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	unsignedinteger	retval[]		
//		ref	blob           	bl      		
//		ref	string         	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

li_dimension = Long(BlobMid(bl, ll_currPos, 4))
ll_currPos += 4;

li_upperbound = Long(BlobMid(bl, ll_currPos, 4))
ll_currPos += 4;

IF li_arrTag = EAG_ARRAY AND li_type = EAG_UINT THEN
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Integer(BlobMid(bl, ll_currPos, 2))
		ll_currPos += 2;
	NEXT
	
ELSEIF li_arrTag = EAG_ARRAY AND li_type = EAG_LONG THEN
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Long(BlobMid(bl, ll_currPos, 4))
		ll_currPos += 4;
	NEXT
ELSE
	errinfo = GetLocalErrA(2004)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getchararr (ref character retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getcharArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	character	retval[]		
//		ref	blob     	bl      		
//		ref	string   	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_CHAR = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = CharA(BlobMid(bl, ll_currPos, 1))
		ll_currPos += 1;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2000)
	ll_ret = - 1
END IF

RETURN ll_ret




end function

public function long of_getdatastore (ref datastore retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatastore()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	datastore	retval 		
//		ref	blob     	bl     		
//		ref	string   	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


RETURN 0


end function

public function long of_getdatawindow (ref datawindow retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatawindow()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	datawindow	retval 		
//		ref	blob      	bl     		
//		ref	string    	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


return 0
end function

public function long of_getdatawindowArr (ref datawindow retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatawindowArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	datawindow	retval[]		
//		ref	blob      	bl      		
//		ref	string    	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================


return 0
end function

public function long of_getdate (ref date retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdate()
//------------------------------------------------------------------------------
// Description: Get Date from dll
//	
// Arguments: 
//		ref	date  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

If li_type = EAG_DATE Then
	retval = Date(BlobMid(bl, ll_CurrPos, 12))
Else
	errinfo = GetLocalErrA(1014)
	ll_ret = - 1
End If

return ll_ret
end function

public function long of_getdatearr (ref date retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdateArr()
//------------------------------------------------------------------------------
// Description: 
//	
// Arguments: 
//		ref	date  	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_DATE = li_type Then
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound= Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	For i = 1 To li_dimension*li_upperbound
		retval[i] = Date(BlobMid(bl, ll_currPos, 12))
		ll_currPos += 12;
	Next
	
Else
	errinfo = GetLocalErrA(2014)
	ll_ret = - 1
End If

Return ll_ret
end function

public function long of_getdatetime (ref datetime retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	datetime	retval 		
//		ref	blob    	bl     		
//		ref	string  	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

If li_type = EAG_DATETIME or li_type = EAG_TIMESTAMP Then
	retval = DateTime(BlobMid(bl, ll_CurrPos, 12))
Else
	errinfo = GetLocalErrA(1013)
	ll_ret = - 1
End If

return ll_ret
end function

public function long of_getdatetimearr (ref datetime retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdatetimeArr()
//------------------------------------------------------------------------------
// Description: 
// 

//	
// Arguments: 
//		ref	datetime	retval[]		
//		ref	blob    	bl      		
//		ref	string  	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND (EAG_DATETIME = li_type or li_type = EAG_TIMESTAMP)  THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = DateTime(BlobMid(bl, ll_currPos, 12))
		ll_currPos += 12;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2013)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getdouble (ref double retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	double	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_DOUBLE THEN
	retval = Double(BlobMid(bl, ll_CurrPos, 8))
ELSE
	errinfo = GetLocalErrA(1009)
	ll_ret = - 1
END IF

RETURN ll_ret


end function

public function long of_getdoublearr (ref double retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getdoubleArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	double	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_DOUBLE = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Double(BlobMid(bl, ll_currPos, 8))
		ll_currPos += 8;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2009)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getint (ref integer retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	integer	retval 		
//		ref	blob   	bl     		
//		ref	string 	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_INT THEN
	retval = Integer(BlobMid(bl, ll_CurrPos, 2))
ELSE
	errinfo = GetLocalErrA(1003)
	ll_ret = - 1
END IF

RETURN ll_ret


end function

public function long of_getintarr (ref integer retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getintArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	integer	retval[]		
//		ref	blob   	bl      		
//		ref	string 	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_Ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_Ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_INT = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Integer(BlobMid(bl, ll_currPos, 2))
		ll_currPos += 2;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2003)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getlong (ref long retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getlong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	long  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_LONG THEN
	retval = Long(BlobMid(bl, ll_CurrPos, 4))
ELSE
	errinfo = GetLocalErrA(1005)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getlongarr (ref long retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getlongArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	long  	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_LONG = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Long(BlobMid(bl, ll_currPos, 4))
		ll_currPos += 4;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2005)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getreal (ref real retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getreal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	real  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_REAL THEN
	retval = Real(BlobMid(bl, ll_CurrPos, 4))
ELSE
	errinfo = GetLocalErrA(1008)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getrealarr (ref real retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getrealArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	real  	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_REAL = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Real(BlobMid(bl, ll_currPos, 4))
		ll_currPos += 4;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2008)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getstringarr (ref string retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getstringArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	string	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i, ll_contLen

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_STRING = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		ll_contLen = Long(BlobMid(bl, ll_currPos, 4))		
		ll_currPos += 4;		
		
		retval[i] = String(BlobMid(bl, ll_currPos, ll_contLen))		
		ll_currPos += ll_contLen;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2001)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_gettime (ref time retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_gettime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	time  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_TIME THEN
	retval = Time(BlobMid(bl, ll_CurrPos))
ELSE
	errinfo = GetLocalErrA(1015)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_gettimearr (ref time retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_gettimeArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	time  	retval[]		
//		ref	blob  	bl      		
//		ref	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_TIME = li_type THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Time(BlobMid(bl, ll_currPos, 12))
		ll_currPos += 12;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2015)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getuint (ref unsignedinteger retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getuint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	unsignedinteger	retval 		
//		ref	blob           	bl     		
//		ref	string         	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_ret = 1, ll_CurrPos = 1

Integer li_type
Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_UINT THEN
	retval = Integer(BlobMid(bl, ll_CurrPos, 2))
ELSEIF li_type = EAG_LONG THEN
	retval = Long(BlobMid(bl, ll_CurrPos, 4))
ELSE
	errinfo = GetLocalErrA(2004)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getulongarr (ref unsignedlong retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getulongArr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	unsignedlong	retval[]		
//		ref	blob        	bl      		
//		ref	string      	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND (li_type = EAG_ULONG or li_type = EAG_LONGLONG) THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))	
	ll_currPos += 4;
	
	FOR i = 1 TO li_dimension*li_upperbound
		retval[i] = Long(BlobMid(bl, ll_currPos, 4))
		ll_currPos += 4;
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2006)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public subroutine of_getlasterror (ref string as_lasterror);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getlasterror()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		reference	string	as_lasterror		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

as_lasterror = is_LastError
end subroutine

public function integer of_write_strumem (readonly classdefinition cdef, string as_name, ref blob blobret);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_write_strumem()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly 	classdefinition	cdef   		
//		reference	string         	as_name		
//		reference	blob           	blobret		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int
Blob{4} lbl_Long
Blob lbl_tmpData, lbl_head
Boolean lb_array
String ls_varName
Integer i, li_Num, li_NumWrite, li_DataType
Long j,ll_Dimension, ll_UpperBound[], ll_boundIndex
VariableDefinition varDef
TypeDefinition	typeDef
VariableCardinalityDefinition	varCardDef

// Struct Type = 64
BlobEdit(lbl_Int, 1, Integer(EAG_STRUCT))
lbl_head += lbl_Int

// Struct Len And Name
BlobEdit(lbl_Long, 1, Long(LenA(as_name)))
lbl_head += lbl_Long
lbl_head += Blob(as_name,EncodingAnsi!) //Encoding – Nova 11.16.2010

// Memeber number
li_NumWrite = 0;
li_Num = UpperBound(cdef.VariableList)
FOR i = 1 TO li_Num
	varDef = cdef.VariableList[i]
	typeDef = varDef.TypeInfo
	
	ls_varName = varDef.Name
	IF ls_varName = "classdefinition" THEN CONTINUE
	
	// Write Variable Len and name
	BlobEdit(lbl_Long, 1, Long(LenA(ls_varName)))
	blobRet += lbl_Long
	blobRet += Blob(ls_varName,EncodingAnsi!) //Encoding – Nova 11.16.2010
	
	varCardDef = varDef.Cardinality
	IF varCardDef.Cardinality = BoundedArray! THEN
		// Current member is Fixed bound array
		lb_array = TRUE
		
		ll_Dimension = UpperBound(varCardDef.ArrayDefinition)
		FOR ll_boundIndex = 1 TO ll_Dimension
			ll_UpperBound[ll_boundIndex] = varCardDef.ArrayDefinition[ll_boundIndex].UpperBound
		NEXT
		
	ELSEIF varCardDef.Cardinality = UnBoundedArray! THEN
		// UnBoundedArray not supported		
		is_LastError = GetLocalErrA(5001)
		li_NumWrite = -1
		EXIT
	ELSE
		lb_array = FALSE
	END IF
	
	IF typeDef.IsStructure THEN
		// IsStructure
		lbl_tmpData = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010
		IF -1 = of_regstruct(typeDef, lb_array, ll_Dimension, ll_UpperBound, lbl_tmpData) THEN
			li_NumWrite = -1
			EXIT
		ELSE
			blobRet += lbl_tmpData
		END IF
	ELSE
		// Write Variable Type
		li_DataType = of_mapType(typeDef.DataTypeOf, TRUE)
		IF (-1 = li_DataType) THEN
			li_NumWrite = -1
			EXIT
		END IF
		
		IF lb_array THEN
			BlobEdit(lbl_Int, 1, EAG_ARRAY)
			blobRet += lbl_Int
		END IF
		
		BlobEdit(lbl_Int, 1, li_DataType)
		blobRet += lbl_Int
		
		IF lb_array THEN
			// Write array dimension
			BlobEdit(lbl_Long, 1, ll_Dimension)
			blobRet += lbl_Long
			
			// Write array UpperBound
			FOR ll_boundIndex = 1 TO ll_Dimension
				BlobEdit(lbl_Long, 1, ll_UpperBound[ll_boundIndex])
				blobRet += lbl_Long
			NEXT
		END IF
	END IF
	
	li_NumWrite ++
NEXT

// Write Memeber number
BlobEdit(lbl_Int, 1, li_NumWrite)
lbl_head += lbl_Int
blobRet = lbl_head + blobRet

RETURN li_NumWrite



end function

public function integer of_maptype (string as_type, boolean ab_valid);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_maptype()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	string 	as_type 
//		value	boolean	ab_valid		if valid type
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_ret = 0

CHOOSE CASE as_type
	CASE "char","character"
		li_ret = EAG_CHAR
	CASE "string"
		li_ret = EAG_STRING
	CASE "boolean"
		li_ret = EAG_BOOL
	CASE "int","integer"
		li_ret = EAG_INT
	CASE "unsignedinteger"
		li_ret = EAG_UINT
	CASE "long"
		li_ret = EAG_LONG
	CASE "unsignedlong"
		li_ret = EAG_ULONG
	CASE "longlong"
		li_ret = EAG_LONGLONG
		IF ab_valid THEN
			li_ret = -1
			is_LastError = GetLocalErrA(5004)
		END IF
	CASE "real"
		li_ret = EAG_REAL
	CASE "double"
		li_ret = EAG_DOUBLE
	CASE "dec","decimal"
		li_ret = EAG_DECIMAL
	CASE "number"
		li_ret = EAG_NUMBER
	CASE "timestamp"
		li_ret = EAG_TIMESTAMP
		IF ab_valid THEN
			li_ret = -1
			is_LastError = GetLocalErrA(5005)
		END IF
	CASE "datetime"
		//li_ret = EAG_DATETIME
		li_ret = EAG_TIMESTAMP
	CASE "date"
		li_ret = EAG_DATE
	CASE "time"
		li_ret = EAG_TIME
	CASE "blob"
		li_ret = EAG_BLOB
		IF ab_valid THEN
			li_ret = -1
			is_LastError = GetLocalErrA(5006)
		END IF
	CASE "datastore"
		li_ret = EAG_DS
		IF ab_valid THEN
			li_ret = -1
			is_LastError = GetLocalErrA(5007)
		END IF
		
	CASE "datawindow"
		li_ret = EAG_DW
		IF ab_valid THEN
			li_ret = -1
			is_LastError = GetLocalErrA(5008)
		END IF
END CHOOSE

RETURN li_ret



end function

private function integer of_regstruct (readonly typedefinition typedef, boolean ab_array, long al_dimension, long al_upperbound[], ref blob abl_ret);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_regstruct()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly	typedefinition 	typedef		
//		        	boolean 				ab_array       		
//		        	long    				al_dimension   		
//		        	long    				al_upperbound[]		
//		ref     	blob           	abl_ret		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String strName
Blob lbl_mem
Integer li_Ret = - 1
Long i, ll_arrLen = 1

IF ab_array THEN
	// Write Array Head
	ll_arrLen = of_write_struArrHead(al_dimension, al_upperbound, abl_ret)
END IF

IF ll_arrLen > - 1 THEN
	// Get ClassDefinition
	strName = typedef.Name
	ClassDefinition lcdef
	lcdef = typedef
	
	// Write Member
	li_Ret = of_write_struMem(lcdef, strName, lbl_mem)
	
	FOR i = 1 TO ll_arrLen
		abl_ret += lbl_mem
	NEXT
	
END IF

RETURN li_Ret




end function

public function long of_write_struarrhead (long al_dimension, long al_upperbound[], ref blob abl_head);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_write_struarrhead()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value    	long	al_dimension 		
//		value    	long	al_upperbound[]		
//		reference	blob	abl_head     		
//	
// Returns:  long	
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int
Blob{4} lbl_Long
Long ll_Ret = 1, i

IF al_dimension <= 0 THEN
	// Array Dimension is zero no supported
	is_LastError = GetLocalErrA(5003)
	ll_Ret = -1
END IF

IF ll_Ret = 1 THEN
	// Struct Array = 32 + 64	
	BlobEdit(lbl_Int, 1, Integer(EAG_ARRAY))
	abl_head += lbl_Int
	
	BlobEdit(lbl_Int, 1, Integer(EAG_STRUCT))
	abl_head += lbl_Int
	
	// Struct dimension and UpperBound
	BlobEdit(lbl_Long, 1, al_dimension)
	abl_head += lbl_Long
	
	FOR i = 1 TO al_dimension
		IF al_upperbound[i] <= 0 THEN
			// Array UpperBound is zero no supported!
			is_LastError = GetLocalErrA(5002)
			ll_Ret = -1
			EXIT
		END IF
		
		BlobEdit(lbl_Long, 1, al_upperbound[i])
		abl_head += lbl_Long
		
		ll_Ret *= al_upperbound[i]
	NEXT
	
END IF

RETURN ll_Ret



end function

public function long of_getstru (ref blob retval, ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getstru()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	blob  	retval 		
//		ref	blob  	bl     		
//		ref	string	errinfo		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_contLen, ll_CurrPos = 1, ll_ret = 1

Integer li_type, li_IsNull
li_IsNull = Of_GetHead(bl, ll_CurrPos, li_type)

IF li_type = EAG_STRUCT THEN	
	IF li_IsNull = 0 THEN
		SetNull(retval)
		
	ELSEIF li_IsNull = 1 THEN
		ll_contLen = Long(BlobMid(bl, ll_CurrPos, 4))	
		ll_CurrPos += 4		
		retval = BlobMid(bl, ll_CurrPos, ll_contLen)
		
	END IF
	
ELSE
	errinfo = GetLocalErrA(1064)
	ll_ret = - 1
END IF

RETURN ll_ret

end function

public function long of_getstruarr (ref blob retval[], ref blob bl, ref string errinfo);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getstruarr()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		reference	blob  	retval[]		
//		reference	blob  	bl      		
//		reference	string	errinfo 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_arrTag, li_IsNull, li_type
Long ll_ret = 1
Long ll_currPos = 1
Long li_dimension, li_upperbound, i, ll_contLen

ll_ret = Of_GetHead(bl, ll_currPos, li_arrTag, li_type)
IF ll_ret <> 1 THEN RETURN ll_ret

IF li_arrTag = EAG_ARRAY AND EAG_STRUCT = li_type  THEN
	li_dimension = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4
	
	li_upperbound = Long(BlobMid(bl, ll_currPos, 4))
	ll_currPos += 4;

	
	FOR i = 1 TO li_dimension*li_upperbound
		li_IsNull = Of_GetIfNull(bl, ll_currPos)
		
		IF li_IsNull = 0 THEN
			SetNull(retval[i])
			
		ELSEIF li_IsNull = 1 THEN
			ll_contLen = Long(BlobMid(bl, ll_currPos, 4))
			ll_currPos += 4
			
			retval[i] = BlobMid(bl, ll_currPos, ll_contLen)
			ll_currPos += ll_contLen
			
		ELSE
			RETURN -1
			
		END IF
	NEXT
	
ELSE
	errinfo = GetLocalErrA(2064)
	ll_ret = - 1
END IF

RETURN ll_ret




end function

private function long of_gethead (readonly blob bl, ref long al_currpos, ref integer ai_arrtag, ref integer ai_type);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_gethead()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly 	blob   	bl        		
//		reference	long   	al_currpos		
//		reference	integer	ai_arrtag 		
//		reference	integer	ai_type   		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_Ret = 1

// Array Tag
ai_arrtag = Integer(BlobMid(bl, al_currpos, 2))
al_currpos += 2;

// If Null
ll_Ret = Of_GetIfNull(bl, al_currpos)

IF ll_Ret = 1 THEN 
	// Type
	ai_type = Integer(BlobMid(bl, al_currpos, 2))
	al_currpos += 2
END IF

RETURN ll_Ret




end function

public function long of_getifnull (readonly blob bl, ref long al_currpos);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_getifnull()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly 	blob	bl        		
//		reference	long	al_currpos		
//	
// Returns:  Long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_NullTag

li_NullTag = Integer(BlobMid(bl, al_currpos, 2))
al_currpos += 2

IF li_NullTag = 32767 THEN
	RETURN 1
ELSEIF li_NullTag = -32768 THEN
	RETURN 0
ELSE
	is_LastError = GetLocalErrA(6011)
	RETURN -1
END IF

end function

public function integer of_gethead (readonly blob bl, ref long al_currpos, ref integer ai_type);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_gethead()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly 	blob   	bl        		
//		reference	long   	al_currpos		
//		reference	integer	ai_type   		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

// Type
ai_type = Integer(BlobMid(bl, al_currpos, 2))
al_currpos += 2

RETURN Of_GetIfNull(bl, al_currpos)

end function

public function long of_regstruct (readonly classdefinition cdef, boolean ab_array, long al_dimension, long al_upperbound, ref blob abl_ret, readonly string as_classname);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: parse_retval_object::of_regstruct()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly 	classdefinition	cdef         		
//		value    	boolean        	ab_array     		
//		value    	long           	al_dimension 		
//		value    	long           	al_upperbound		
//		reference	blob           	abl_ret      		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_mem
Integer li_Ret = - 1
Long i, ll_arrLen = 1, ll_UpperBound[]

IF ab_array THEN
	// Write Array Head
	ll_UpperBound[1] = al_upperbound
	ll_arrLen = of_write_struArrHead(al_dimension, ll_UpperBound, abl_ret)
END IF

IF ll_arrLen > - 1 THEN
	// Write Struct Member
	//li_Ret = of_write_struMem(cdef, cdef.Name, lbl_mem)
	li_Ret = of_write_struMem(cdef, as_classname, lbl_mem)
	
	FOR i = 1 TO ll_arrLen
		abl_ret += lbl_mem
	NEXT
END IF

RETURN li_Ret





end function

on parse_retval_object.create
call super::create
TriggerEvent( this, "constructor" )
end on

on parse_retval_object.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

