$PBExportHeader$n_versioninfo.sru
forward
global type n_versioninfo from nonvisualobject
end type
end forward

global type n_versioninfo from nonvisualobject
end type
global n_versioninfo n_versioninfo

type prototypes
FUNCTION ulong GetModuleFileName(ulong hModule, ref string lpFilename, ulong nSize) LIBRARY "KERNEL32.DLL" ALIAS FOR "GetModuleFileNameA;Ansi"
FUNCTION boolean GetFileVersionInfo(ref string lptstrFilename, ulong dwHandle, ulong dwLen, ref char lpData[]) LIBRARY "VERSION.DLL" ALIAS FOR "GetFileVersionInfoA;Ansi"
FUNCTION ulong GetFileVersionInfoSize(ref string lptstrFilename, ref ulong lpdwHandle) LIBRARY "VERSION.DLL" ALIAS FOR "GetFileVersionInfoSizeA;Ansi"
FUNCTION boolean VerQueryValue(char pBlock[], string lpSubBlock, ref ulong lplpBuffer, ref uint pulen) LIBRARY "VERSION.DLL" ALIAS FOR "VerQueryValueA;Ansi"
end prototypes

type variables
// this object allows wraps Windows API functions to provide
// various version information extracted from an executable
// file.  For each item of version data, two functions exist:
//    1.  a no-argument function to provide the information 
//        for the currently executing PowerBuilder application
//    2.  a one-argument function allowing you to view version
//        information for any application.  (This user object
//        only implements functions to view information that
//        can be placed in a PowerBuilder application; however,
//        additional methods could be added to access version 
//        information that may be present in other EXE files, 
//        such as 'Comments')


// strings defined for various version data per the Windows API
// (PowerBuilder executables implement only a subset)
private CONSTANT STRING VER_COMMENTS = "Comments"
private CONSTANT STRING VER_COMPANYNAME = "CompanyName"
private CONSTANT STRING VER_FILEDESCRIPTION = "FileDescription"
private CONSTANT STRING VER_FILEVERSION = "FileVersion"
private CONSTANT STRING VER_INTERNALNAME = "InternalName"
private CONSTANT STRING VER_LEGALCOPYRIGHT = "LegalCopyright"
private CONSTANT STRING VER_LEGALTRADEMARKS = "LegalTrademarks"
private CONSTANT STRING VER_ORIGINALFILENAME = "OriginalFilename"
private CONSTANT STRING VER_PRODUCTNAME = "ProductName"
private CONSTANT STRING VER_PRODUCTVERSION = "ProductVersion"
private CONSTANT STRING VER_PRIVATEBUILD = "PrivateBuild"
private CONSTANT STRING VER_SPECIALBUILD = "SpecialBuild"

// NULL variables used as arguments in various API calls
private string is_null
private ulong  il_null

// BOOLEAN indicating whether or not requested version info is for a PB
// application.  This is necessary to address the fact that PowerBuilder
// stores the information in a non standard way and a slight algorithm
// change is required to retrieve version information from a PowerBuilder
// generated application versus a third-party application.  CR257065 has
// been forwarded to Sybase engineering to address this discrepancy.
private boolean ib_PBEXE
end variables

forward prototypes
private function string int2hex (integer ai_intvalue, integer ai_pad)
public function string getcopyright ()
public function string getcompanyname (string as_exefile)
public function string getcompanyname ()
public function string getcopyright (string as_exefile)
public function string getdescription (string as_exefile)
public function string getdescription ()
public function string getproductname (string as_exefile)
public function string getproductname ()
public function string getversion (string as_exefilename)
public function string getversion ()
public subroutine setispbapp (boolean ab_torf)
public function boolean getispbapp ()
private function string getversioninfo (string as_value, string as_filename)
end prototypes

private function string int2hex (integer ai_intvalue, integer ai_pad);string  ls_hex
integer li_nibbleValue

// convert a decimal value into its hexadecimal equivalent and pad with
// leading zero to the length specified as the second argument to this function
DO WHILE ai_intvalue > 0
	li_nibbleValue = Mod(ai_intValue, 16)
	IF li_nibbleValue > 9 THEN
		ls_hex = CharA(AscA('A') + (li_nibbleValue - 10)) + ls_hex
	ELSE
		ls_hex = String(li_nibbleValue) + ls_hex
	END IF
	ai_intvalue = (ai_intValue - li_nibbleValue) / 16
LOOP

RETURN FillA("0", ai_pad - LenA(ls_hex)) + ls_hex
end function

public function string getcopyright ();return getCopyright(is_null)
end function

public function string getcompanyname (string as_exefile);return getVersionInfo(VER_COMPANYNAME, as_exefile)
end function

public function string getcompanyname ();return getCompanyName(is_null)
end function

public function string getcopyright (string as_exefile);return getVersionInfo(VER_LEGALCOPYRIGHT, as_exefile)
end function

public function string getdescription (string as_exefile);return getVersionInfo(VER_FILEDESCRIPTION, as_exefile)
end function

public function string getdescription ();return getDescription(is_null)
end function

public function string getproductname (string as_exefile);return getVersionInfo(VER_PRODUCTNAME, as_exefile)
end function

public function string getproductname ();return getProductName(is_null)
end function

public function string getversion (string as_exefilename);return getVersionInfo(VER_PRODUCTVERSION, as_exefilename)
end function

public function string getversion ();return getVersion(is_null)
end function

public subroutine setispbapp (boolean ab_torf);this.ib_PBEXE = ab_TorF
end subroutine

public function boolean getispbapp ();return this.ib_PBEXE
end function

private function string getversioninfo (string as_value, string as_filename);// This function wraps the required API functionality to return
// version information for the specified file passed as an
// argument.  This function will return null if the specified
// version information cannot be found or an error occurs in one
// of the Windows API calls.  Additional, error handling can be added
// making use of the GetLastError call in the Windows SDK.

ulong  ll_size
ulong  ll_zero
string ls_file
char   lc_cp[4]
char   lc_verinfo[]

uint   li_length
ulong  ll_strAddress
string ls_langString

// initialize storage for module file name
ls_file = Space(256)

// get current module file name (null for second parameter indicates current process)
IF IsNull(as_fileName) OR (LenA(Trim(as_filename)) = 0) THEN
	IF GetModuleFileName(il_null, ls_file, LenA(ls_file)) = 0 THEN
		RETURN is_null
	END IF
ELSE
	ls_file = as_fileName
END IF

// get size of file version info data
// N.B., short path form of ls_file on Win95/98/ME must be < 126 characters
ll_size = GetFileVersionInfoSize (ls_file, ll_zero)
IF ll_size = 0 THEN
	RETURN is_null
END IF

// setup space for version information.  Since it's a dynamically sized
// array of chars, just set last element needed
lc_verinfo[ll_size] = CharA(0)

// get the file version info
IF NOT GetFileVersionInfo (ls_file, 0, ll_size, lc_verinfo) THEN
	RETURN is_null
END IF

// get FIRST language and code page (if other language strings are specified and required, this
// method would require some enhancement and an additional parameter to identify which language/
// code page was desired)
IF VerQueryValue(lc_verinfo, "\\VarFileInfo\\Translation", ll_strAddress, li_length) THEN

	IF (li_length >= 4) THEN
		
		// ll_strAddress contains a pointer to a string, so use the address format to resolve the 
		// pointer.  Since the string may contain null bytes, and PowerBuilder using a null terminated
		// string paradigm, we increment the char pointer to retrieve each of the four bytes in the 
		// language/code page sequence
		//--------Begin Modified by  Nova 10.18.2010------------------------
		//Handling ANSI data      
		//lc_cp[1] = String(ll_strAddress,   "address")
		//lc_cp[2] = String(ll_strAddress+1, "address")
		//lc_cp[3] = String(ll_strAddress+2, "address")
		//lc_cp[4] = String(ll_strAddress+3, "address")
		lc_cp[1] = string(blob(String(ll_strAddress,   "address")), EncodingANSI!)
		lc_cp[2] = string(blob(String(ll_strAddress+1, "address")), EncodingANSI!)
		lc_cp[3] = string(blob(String(ll_strAddress+2, "address")), EncodingANSI!)
		lc_cp[4] = string(blob(String(ll_strAddress+3, "address")), EncodingANSI!)
		//--------End Modified --------------------------------------------
		
		// convert the language / codepage to a string for a subquent lookup.  There are two methods
		// here, one for PB-created executables and one for other third-party executables.  CR 257065
		// has been opened to remedy the non-standard way that PowerBuilder stores this information.
		IF this.getIsPBApp() THEN
			ls_langString = int2Hex(AscA(lc_cp[2]), 2) + int2Hex(AscA(lc_cp[1]), 2) &
			              + int2Hex(Integer(int2Hex(AscA(lc_cp[4]), 2) + int2Hex(AscA(lc_cp[3]), 2)) , 4)
		ELSE
			ls_langString = int2Hex(AscA(lc_cp[2]), 2) + int2Hex(AscA(lc_cp[1]), 2) &
			              + int2Hex(AscA(lc_cp[4]), 2) + int2Hex(AscA(lc_cp[3]), 2)
		END IF
	ELSE
		RETURN is_null
	END IF
ELSE
	RETURN is_null
END IF

// At this point, extract the specific version information desired and return it as a string
IF VerQueryValue(lc_verInfo, "\\StringFileInfo\\" + ls_langString + "\\" + as_value, ll_strAddress, li_length) THEN
	IF (li_length > 0) THEN
		//--------Begin Modified by  Nova 10.18.2010------------------------
		//Handling ANSI data      
		//RETURN String(ll_strAddress, "address")
		RETURN string(blob(String(ll_strAddress, "address")), EncodingANSI!)
		//--------End Modified --------------------------------------------
	ELSE
		RETURN is_null
	END IF
ELSE
	RETURN is_null
END IF
end function

on n_versioninfo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_versioninfo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;setNull(is_null)
setNull(il_null)
end event

