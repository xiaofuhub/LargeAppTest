$PBExportHeader$ejbserial.sru
forward
global type ejbserial from nonvisualobject
end type
end forward

global type ejbserial from nonvisualobject autoinstantiate
end type

type prototypes

end prototypes

type variables
Private:
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
	String ERR_WARNING
	
	Blob ibl_Data
	Long il_Pos = 1
	
	Long il_ArrPos = 0
	Integer ii_ArrType

	EjbObject io_EjbObj
end variables

forward prototypes
public subroutine reset ()
public function blob getdata ()
public subroutine getlasterror (ref string as_lasterror)
public subroutine writechar (character ac_value)
public subroutine writeblob (blob abl_value)
public subroutine writeboolean (boolean ab_value)
public subroutine writedate (date ad_value)
public subroutine writedatetime (datetime adt_value)
public subroutine writetime (time at_value)
public subroutine writeint (integer ai_value)
public subroutine writedouble (double adb_value)
public subroutine writestring (string as_value)
public subroutine writeuint (unsignedinteger aui_value)
public subroutine writeulong (unsignedlong aul_value)
public subroutine writereal (real ar_value)
public subroutine writelong (long al_long)
public function boolean readboolean ()
public function character readchar ()
public function blob readblob ()
public function date readdate ()
public function datetime readdatetime ()
public function double readdouble ()
public function integer readint ()
public function long readlong ()
public function real readreal ()
public function string readstring ()
public function time readtime ()
public function unsignedinteger readuint ()
public function unsignedlong readulong ()
public function boolean readboolean (readonly string as_name)
public function character readchar (readonly string as_name)
public function blob readblob (readonly string as_name)
public function date readdate (readonly string as_name)
public function datetime readdatetime (readonly string as_name)
public function double readdouble (readonly string as_name)
public function integer readint (readonly string as_name)
public function long readlong (readonly string as_name)
public function real readreal (readonly string as_name)
public function string readstring (readonly string as_name)
public function time readtime (readonly string as_name)
public function unsignedinteger readuint (readonly string as_name)
public function unsignedlong readulong (readonly string as_name)
private subroutine of_writehead (integer ai_type)
private function integer of_isnull ()
public function integer setdata (readonly blob abl_data)
private function integer of_gethead (ref integer ai_typeret)
end prototypes

public subroutine reset ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::reset()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

il_Pos	 = 1
il_ArrPos = 0
ii_ArrType= -1
is_LastError = ""
ibl_Data = Blob("",EncodingAnsi!) //Encoding – Nova 11.16.2010
end subroutine

public function blob getdata ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::getdata()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  blob
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ibl_data


end function

public subroutine getlasterror (ref string as_lasterror);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::getlasterror()
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

public subroutine writechar (character ac_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writechar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	character	ac_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Of_WriteHead(EAG_CHAR)

ibl_Data += Blob(ac_value)
end subroutine

public subroutine writeblob (blob abl_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writeblob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	blob	abl_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{4} lbl_Long

Of_WriteHead(EAG_BLOB)

BlobEdit(lbl_Long, 1, Long(LenA(abl_value)))
ibl_Data += lbl_Long

ibl_Data += abl_value


end subroutine

public subroutine writeboolean (boolean ab_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writeboolean()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int

Of_WriteHead(EAG_BOOL)

IF ab_value THEN
	BlobEdit(lbl_Int, 1, Integer(1))
ELSE
	BlobEdit(lbl_Int, 1, Integer(0))
END IF

ibl_Data += lbl_Int



end subroutine

public subroutine writedate (date ad_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writedate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	date	ad_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{12} lbl_Len12

Of_WriteHead(EAG_DATE)

BlobEdit(lbl_Len12, 1, ad_value)
ibl_Data += lbl_Len12
end subroutine

public subroutine writedatetime (datetime adt_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writedatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	datetime	adt_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{12} lbl_Len12

Of_WriteHead(EAG_DATETIME)

BlobEdit(lbl_Len12, 1, adt_value)
ibl_Data += lbl_Len12
end subroutine

public subroutine writetime (time at_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	time	at_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{12} lbl_Len12

Of_WriteHead(EAG_TIME)

BlobEdit(lbl_Len12, 1, at_value)
ibl_Data += lbl_Len12
end subroutine

public subroutine writeint (integer ai_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writeint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	integer	ai_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int

Of_WriteHead(EAG_INT)

BlobEdit(lbl_Int, 1, Integer(ai_value))
ibl_Data += lbl_Int

end subroutine

public subroutine writedouble (double adb_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writedouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	double	adb_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{8} lbl_Len8

Of_WriteHead(EAG_DOUBLE)

BlobEdit(lbl_Len8, 1, adb_value)
ibl_Data += lbl_Len8
end subroutine

public subroutine writestring (string as_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writestring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	string	as_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{4} lbl_Long

Of_WriteHead(EAG_STRING)

BlobEdit(lbl_Long, 1, Long(LenA(as_value)))
ibl_Data += lbl_Long

ibl_Data += Blob(as_value)


end subroutine

public subroutine writeuint (unsignedinteger aui_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writeuint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	unsignedinteger	aui_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int

Of_WriteHead(EAG_UINT)

BlobEdit(lbl_Int, 1, aui_value)
ibl_Data += lbl_Int
end subroutine

public subroutine writeulong (unsignedlong aul_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writeulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	unsignedlong	aul_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{4} lbl_Long

Of_WriteHead(EAG_ULONG)

BlobEdit(lbl_Long, 1, aul_value)
ibl_Data += lbl_Long

end subroutine

public subroutine writereal (real ar_value);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writereal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	real	ar_value		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{4} lbl_Len4

Of_WriteHead(EAG_REAL)

BlobEdit(lbl_Len4, 1, Real(ar_value))
ibl_Data += lbl_Len4
end subroutine

public subroutine writelong (long al_long);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::writelong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	long	al_long		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{4} lbl_Long

Of_WriteHead(EAG_LONG)

BlobEdit(lbl_Long, 1, al_long)
ibl_Data += lbl_Long

end subroutine

public function boolean readboolean ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readboolean()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  boolean
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadBoolean("")

end function

public function character readchar ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readchar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  character
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadChar("")

end function

public function blob readblob ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readblob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  blob
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadBlob("")

end function

public function date readdate ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  date
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadDate("")


end function

public function datetime readdatetime ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  datetime
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadDateTime("")

end function

public function double readdouble ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  double
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadDouble("")



end function

public function integer readint ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadInt("")



end function

public function long readlong ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readlong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version

RETURN ReadLong("")


end function

public function real readreal ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readreal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  real
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadReal("")


end function

public function string readstring ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readstring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadString("")


end function

public function time readtime ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readtime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  time
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadTime("")




end function

public function unsignedinteger readuint ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readuint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  unsignedinteger
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadUint("")


end function

public function unsignedlong readulong ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	boolean	ab_array		
//	
// Returns:  unsignedlong
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

RETURN ReadULong("")

end function

public function boolean readboolean (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readboolean()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  boolean
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Boolean lb_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_BOOL THEN
	IF li_NullTag = 0 THEN 
		SetNull(lb_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		IF 1 = Integer(BlobMid(ibl_Data, il_Pos, 2)) THEN
			lb_Ret = TRUE
		ELSE
			lb_Ret = FALSE
		END IF	
		il_Pos += 2
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1002)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lb_Ret

end function

public function character readchar (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readchar()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  character
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Character lc_ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_CHAR THEN
	IF li_NullTag = 0 THEN 
		SetNull(lc_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		lc_ret = CharA(BlobMid(ibl_Data, il_Pos, 1))	
		il_Pos += 1
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1000)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lc_ret
end function

public function blob readblob (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readblob()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  blob
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob lbl_Ret
Long ll_contLen
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_BLOB THEN
	IF li_NullTag = 0 THEN
		SetNull(lbl_Ret)
		
	ELSEIF li_NullTag = 1 THEN
		ll_contLen = Long(BlobMid(ibl_Data, il_Pos, 4))
		il_Pos += 4
		
		lbl_Ret = BlobMid(ibl_Data, il_Pos, ll_contLen)
		il_Pos += ll_contLen
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1016)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lbl_Ret




end function

public function date readdate (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdate()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  date
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Date ld_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_DATE THEN
	IF li_NullTag = 0 THEN 
		SetNull(ld_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		ld_Ret = Date(BlobMid(ibl_Data, il_Pos, 12))	
		il_Pos += 12
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1014)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN ld_Ret
end function

public function datetime readdatetime (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdatetime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  datetime
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

DateTime ldt_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_DATETIME OR li_type = EAG_TIMESTAMP  THEN
	IF li_NullTag = 0 THEN 
		SetNull(ldt_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		ldt_Ret = DateTime(BlobMid(ibl_Data, il_Pos, 12))	
		il_Pos += 12
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1013)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN ldt_Ret
end function

public function double readdouble (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readdouble()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  double
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Double ldb_Ret = 1
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_DOUBLE THEN
	IF li_NullTag = 0 THEN 
		SetNull(ldb_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		ldb_Ret = Double(BlobMid(ibl_Data, il_Pos, 8))	
		il_Pos += 8
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1009)
	IF as_name <> "" THEN is_LastError = "Name=" + as_name + ", "
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN ldb_Ret
end function

public function integer readint (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_ret = 1
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_INT THEN
	IF li_NullTag = 0 THEN 
		SetNull(li_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		li_ret = Integer(BlobMid(ibl_Data, il_Pos, 2))	
		il_Pos += 2
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1003)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN li_ret
end function

public function long readlong (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readlong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  long
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Long ll_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_LONG THEN
	IF li_NullTag = 0 THEN 
		SetNull(ll_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		ll_Ret = Long(BlobMid(ibl_Data, il_Pos, 4))	
		il_Pos += 4
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1005)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN ll_Ret

end function

public function real readreal (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readreal()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  real
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Real lr_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_REAL THEN
	IF li_NullTag = 0 THEN 
		SetNull(lr_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		lr_Ret = Real(BlobMid(ibl_Data, il_Pos, 4))	
		il_Pos += 4
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1008)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lr_Ret
end function

public function string readstring (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readstring()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  string
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

String ls_Ret
Long ll_contLen
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_STRING THEN
	IF li_NullTag = 0 THEN 
		SetNull(ls_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		ll_contLen = Long(BlobMid(ibl_Data, il_Pos, 4))	
		il_Pos += 4
		
		ls_Ret = String(BlobMid(ibl_Data, il_Pos, ll_contLen))	
		il_Pos += ll_contLen
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1001)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN ls_Ret


end function

public function time readtime (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readtime()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  time
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Time lt_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_TIME THEN
	IF li_NullTag = 0 THEN 
		SetNull(lt_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		lt_Ret = Time(BlobMid(ibl_Data, il_Pos, 12))	
		il_Pos += 12
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1015)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lt_Ret

end function

public function unsignedinteger readuint (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readuint()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  unsignedinteger
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

UnsignedInteger lui_Ret
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_UINT THEN
	IF li_NullTag = 0 THEN 
		SetNull(lui_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		lui_Ret = Integer(BlobMid(ibl_Data, il_Pos, 2))
		il_Pos += 2
		
	END IF
	
ELSEIF li_type = EAG_LONG THEN
	IF li_NullTag = 0 THEN 
		SetNull(lui_Ret)
		
	ELSEIF li_NullTag = 1 THEN 		
		lui_Ret = Long(BlobMid(ibl_Data, il_Pos, 4))
		il_Pos += 4
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1004)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lui_Ret


end function

public function unsignedlong readulong (readonly string as_name);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::readulong()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value   	boolean	ab_array		
//		readonly	string 	as_name 		
//	
// Returns:  unsignedlong
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

UnsignedLong lul_Ret = 1
Integer li_type, li_NullTag

li_NullTag = Of_GetHead(li_type)

IF li_type = EAG_ULONG OR li_type = EAG_LONGLONG THEN
	IF li_NullTag = 0 THEN 
		SetNull(lul_Ret)
		
	ELSEIF li_NullTag = 1 THEN 
		lul_Ret = Long(BlobMid(ibl_Data, il_Pos, 4))	
		il_Pos += 4
		
	END IF
	
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(1006)
	IF as_name <> "" THEN is_LastError += "~r~nName=" + as_name
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)
	
END IF

RETURN lul_Ret

end function

private subroutine of_writehead (integer ai_type);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::of_writehead()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		value	integer	ai_type		
//	
// Returns:  (none)
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Blob{2} lbl_Int

BlobEdit(lbl_Int, 1, Integer(ai_type))
ibl_Data += lbl_Int
end subroutine

private function integer of_isnull ();//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::Of_IsNull()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments:(None)
//	
// Returns:  integer -	0: is null
//								1: not null
//							  -1: Error
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Integer li_NullTag

li_NullTag = Integer(BlobMid(ibl_Data, il_Pos, 2))
il_Pos += 2

IF li_NullTag = 32767 THEN
	RETURN 1
ELSEIF li_NullTag = -32768 THEN
	RETURN 0
ELSE
	is_LastError = io_EjbObj.GetErrorStrInfo(6011)
	RETURN -1
END IF

RETURN 1

end function

public function integer setdata (readonly blob abl_data);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::setdata()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		readonly	blob	abl_data		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

Reset()
ibl_Data = abl_data

IF IsNull(abl_data) THEN
	is_LastError = io_EjbObj.GetErrorStrInfo(6012)
	MessageBox(ERR_WARNING, is_LastError, Exclamation!, OK!)	
	RETURN -1
	
END IF

RETURN 1




end function

private function integer of_gethead (ref integer ai_typeret);//==============================================================================
// 
// Copyright ? 2001-2006 Appeon, Inc. and its subsidiaries. All rights reserved.
// 
//------------------------------------------------------------------------------
// Function: ejbserial::of_gethead()
//------------------------------------------------------------------------------
// Description: 
// 
//	
// Arguments: 
//		ref	integer	ai_typeret		
//	
// Returns:  integer
//------------------------------------------------------------------------------
// Author:	APPEON		Date: 2005-08
//------------------------------------------------------------------------------
// Revision History: 
//				1.0   Initial version
//==============================================================================

ai_TypeRet = Integer(BlobMid(ibl_Data, il_Pos, 2))
il_Pos += 2

RETURN Of_IsNull()
end function

on ejbserial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on ejbserial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ERR_WARNING = io_EjbObj.GetErrorStrInfo(7001)
end event

