$PBExportHeader$n_appeon_storage_area.sru
forward
global type n_appeon_storage_area from nonvisualobject
end type
end forward

global type n_appeon_storage_area from nonvisualobject autoinstantiate
end type

type variables
Boolean ib_open_process_window = TRUE

n_cst_filesrvwin32 inv_FileSrv //Added by Ken.Guo on 2008-12-08
n_cst_dm_utils inv_utils //Added by Evan on 2009-1-20
end variables

forward prototypes
public function integer of_init_storage_area ()
public function integer of_upload_file (integer areaid, string docname, string fullname)
public function integer of_download_file (integer areaid, string docname, string fullname)
public function integer of_download_app_image (integer appid, string fullname)
public function integer of_upload_app_image (integer appid, string fullname)
public function integer of_init_storage_image ()
public function integer of_retrieve_image_from_db (integer ll_app_id, string as_filename)
public function integer of_retrieve_doc_from_db (integer ll_facility_id, string as_filename, ref string as_letter_path)
public function integer of_download_app_image (integer appid, ref blob lb_image_data)
public function integer of_download_file (integer areaid, string docname, ref blob lb_image_data)
public function integer of_close_opened_doc (string as_file)
public function string of_convert_file (string as_source_file)
public function boolean of_check_image_modified (integer ll_app_id, string as_filename)
public function integer of_upload_report_file (long al_pkid, string fullname)
end prototypes

public function integer of_init_storage_area ();Long ll_max_area_id
datastore lds_facility, lds_docs, lds_storage_area
Long ll_row, ll_area_row
String ls_letter_path, ls_area_name, ls_doc_name, ls_doc_type
Datetime ldt_today
Long ll_area_id

// Init letter storage area
lds_facility = Create datastore
lds_facility.Dataobject = "d_distinct_facility_letter_path"
lds_facility.Settransobject(SQLCA)

gnv_appeondb.of_startqueue( )

lds_facility.Retrieve( )
SELECT MAX(area_id) INTO :ll_max_area_id FROM sys_storage_area;

gnv_appeondb.of_commitqueue( )

IF ISNULL(ll_max_area_id) THEN ll_max_area_id = 0

// Insert letter_path to sys_storage_area table
gnv_appeondb.of_startqueue( )

FOR ll_row = 1 TO lds_facility.Rowcount( )
	ll_max_area_id ++
	ls_area_name = "Area " + String(ll_row)
	ls_letter_path = lds_facility.GetItemString(ll_row, "letter_path")
	
	INSERT INTO sys_storage_area(area_id, area_name, area_doc_path)
	VALUES (:ll_max_area_id, :ls_area_name, :ls_letter_path );
END FOR

COMMIT;

gnv_appeondb.of_commitqueue( )
	

lds_docs = Create datastore
lds_docs.Dataobject = "d_distinct_doc_list"
lds_docs.Settransobject(SQLCA)

lds_storage_area = Create datastore
lds_storage_area.Dataobject = "d_sys_storage_area_list"
lds_storage_area.Settransobject(SQLCA)

gnv_appeondb.of_startqueue( )

lds_storage_area.Retrieve( )
lds_docs.Retrieve( )

gnv_appeondb.of_commitqueue( )

// Insert docs to sys_storage_docs table

ldt_today = Datetime(Today(),Now())

FOR ll_area_row = 1 TO lds_storage_area.Rowcount( )
	ll_area_id = lds_storage_area.Getitemnumber(ll_area_row, "area_id")
	ls_letter_path = lds_storage_area.GetItemString(ll_area_row, "area_doc_path")

	//--------------------------- APPEON BEGIN ---------------------------
	//$<add> 12.01.2006 By: Davis
	//$<reason> Fix a defect.
	IF NOT DirectoryExists ( ls_letter_path ) THEN
		Messagebox("Import Documents",ls_letter_path + " is invalid, the letter documents will not be imported.")
		CONTINUE
	END IF
	//---------------------------- APPEON END ----------------------------

	lds_docs.Setfilter( "letter_path = '" + ls_letter_path + "'" )
	lds_docs.Filter( )
	
	FOR ll_row = 1 TO lds_docs.Rowcount( )
		ls_doc_name = lds_docs.GetItemString(ll_row, "doc_name")
		ls_doc_type = lds_docs.GetItemString(ll_row, "doc_type")
		ls_letter_path = lds_docs.GetItemString(ll_row, "letter_path")
		
		INSERT INTO sys_storage_docs(area_id, doc_name, doc_type, last_edit_date, user_id)
		VALUES (:ll_area_id, :ls_doc_name, :ls_doc_type, :ldt_today, :gs_user_id );
		COMMIT;
		
		of_upload_file(ll_area_id,ls_doc_name,ls_letter_path + ls_doc_name)
	END FOR
END FOR

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_facility) then Destroy lds_facility
if IsValid(lds_docs) then Destroy lds_docs
if IsValid(lds_storage_area) then Destroy lds_storage_area
//---------------------------- APPEON END ----------------------------

Return 1
end function

public function integer of_upload_file (integer areaid, string docname, string fullname);integer li_FileNum, loops, i

long flen, bytes_read, new_pos

blob b, tot_b

// Set a wait cursor
SetPointer(HourGlass!)

If not fileexists(fullname) then return -1

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading document to database..." )

//Convert the word format (alfee 03.06.2013)
fullname = of_convert_file(fullname) 
	
// Get the file length, and open the file
flen = FileLength(fullname)

// Open the file
li_FileNum = FileOpen(fullname, StreamMode!, Read!, LockRead!)

//--------------------------- APPEON BEGIN ---------------------------
//$< Add  > 2008-04-17 By: Scofield
//$<Reason> if open file failed then return.

if li_FileNum < 0 then 
	if Isvalid( w_appeon_gifofwait) then Close( w_appeon_gifofwait)
	Return -1
end if
//---------------------------- APPEON END ----------------------------

// Determine how many times to call FileRead
IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN
		loops = flen/32765
	ELSE
		loops = (flen/32765) + 1
	END IF
ELSE
	loops = 1
END IF

// Read the file
FOR i = 1 to loops
    bytes_read = FileRead(li_FileNum, b)
    tot_b = tot_b + b
NEXT

// Close the file
FileClose(li_FileNum)

// Upload the file to database
UPDATEBLOB  sys_storage_docs
	 SET doc_data = :tot_b
  WHERE doc_name = :docname
	AND area_id = :areaid;
COMMIT;

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1
end function

public function integer of_download_file (integer areaid, string docname, string fullname);Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob
string ls_filename
Long ll_row
string ls_path, ls_file

IF Isnull(fullname) OR LenA(fullname) = 0 THEN RETURN -1

// Set a wait cursor
SetPointer(HourGlass!)
//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-30 By: Liu Hongxin
//$<reason> If File Opened, close it first, otherwise it'll open a copy.
of_close_opened_doc(DocName)
//---------------------------- APPEON END ----------------------------

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_download_file(areaid, docname, lb_image_data)
ELSE
	SELECTBLOB doc_data
	INTO :lb_image_data
	FROM sys_storage_docs
	WHERE doc_name = :docname
	AND area_id = :areaid;

	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF
END IF

ll_filelen = LenA( lb_image_data )

// Check blob data
IF ll_filelen = 0 OR Isnull(lb_image_data) THEN
	RETURN -2
END IF

IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

// Get file save name
ls_path = fullname

inv_FileSrv.of_setfilereadonly( ls_path, False) //Added by Ken.Guo on 2008-12-08
FileDelete( ls_path )

li_filenum =  FileOpen( ls_path, StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_image_data, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 IF ll_bytes_written = -1 THEN
			//MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_image_data = total_blob
	
	FileClose( li_filenum )
ELSE
	MessageBox( "File Open Error", "Could not open the '" + ls_path + "' for StreamMode!" ) //resumed - alfee 09.08.2011
	Return -	1
END IF

Return 1
end function

public function integer of_download_app_image (integer appid, string fullname);Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob
string ls_filename
Long ll_row
string ls_path, ls_file

IF Isnull(fullname) OR LenA(fullname) = 0 THEN RETURN -1

// Set a wait cursor
SetPointer(HourGlass!)

// Get file data from database
IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	of_download_app_image(appid, lb_image_data)
ELSE
	SELECTBLOB app_image
	INTO :lb_image_data
	FROM app_blob
	WHERE app_id = :appid;
	
	IF SQLCA.SQLCODE = -1 THEN
		MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
		Return -1
	END IF
END IF

ll_filelen = LenA( lb_image_data )

// Check blob data
IF ll_filelen = 0 OR Isnull(lb_image_data) THEN
	RETURN -1
END IF

// Get file save name
ls_path = fullname

FileDelete( ls_path )

//------------------- APPEON BEGIN -------------------
//$<modify> Stephen 04.17.2012
//$<reason>  getting error when uploading large pdf. Bug 3015 
li_filenum = AppeonWriteFile(ls_path, lb_image_data, ll_filelen)
if li_filenum < 0 then
	MessageBox("Error", "Error with  AppeonWriteFile command.  Return -1." )
	Return -1
end if
/*
IF ll_filelen > 32765 THEN 
  	 IF Mod(ll_filelen,32765) = 0 THEN 
        li_loops = ll_filelen/32765 
    ELSE 
  	     li_loops = (ll_filelen/32765) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

li_filenum =  FileOpen( ls_path, StreamMode!, Write!, LockWrite!, Append!)

ll_new_pos = 1

IF li_filenum <> -1 THEN	
	//read the file ... 
	FOR li_counter = 1 to li_loops 
		 blob_temp = BlobMid( lb_image_data, ll_new_pos, 32765 )
   	 ll_bytes_written = FileWrite( li_filenum, blob_temp) 		 
		 IF ll_bytes_written = -1 THEN
			//MessageBox("Error", "Error with FileRead command.  Return -1." )
			Return -1
		 END IF
	    lb_tot_b = lb_tot_b + blob_temp 
   	 ll_new_pos = ll_new_pos + ll_bytes_written 
	    //FileSeek(li_filenum, 0, FROMEND!) 
   	 if LenA(lb_tot_b) > 1000000 then 
	        total_blob = total_blob + lb_tot_b 
   	     lb_tot_b = blank_blob 
	    end if 
	NEXT 

	total_blob = total_blob + lb_tot_b 

	lb_image_data = total_blob
	
	FileClose( li_filenum )
ELSE
	//MessageBox( "File Open Error", "Could not open " + ls_filename + " for StreamMode!" )
	Return -	1
END IF
*/

Return 1
end function

public function integer of_upload_app_image (integer appid, string fullname);integer li_FileNum, loops, i

long flen, bytes_read, new_pos

blob b, tot_b

// Set a wait cursor
SetPointer(HourGlass!)

If not fileexists(fullname) then return -1

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading Image to Database..." )

//BEGIN---Modify by Evan 01/20/2009
/*
// Get the file length, and open the file
flen = FileLength(fullname)

// Open the file
li_FileNum = FileOpen(fullname, StreamMode!, Read!, LockRead!)

// Determine how many times to call FileRead
IF flen > 32765 THEN
	IF Mod(flen, 32765) = 0 THEN
		loops = flen/32765
	ELSE
		loops = (flen/32765) + 1
	END IF
ELSE
	loops = 1
END IF

// Read the file
FOR i = 1 to loops
    bytes_read = FileRead(li_FileNum, b)
    tot_b = tot_b + b
NEXT

// Close the file
FileClose(li_FileNum)
*/
if inv_utils.of_ReadBlob(FullName, tot_b) = -1 then Return -1
//END---Modify by Evan 01/20/2009

// Upload the file to database
Integer li_cnt
Select Count(*) Into :li_cnt From app_blob WHERE app_id = :appid;
IF Isnull(li_cnt) Or li_cnt = 0 THEN
	gnv_appeondb.of_StartQueue()
	Insert Into app_blob( app_id ) Values (:appid);
	COMMIT;
	gnv_appeondb.of_CommitQueue()
END IF

//------------------- APPEON BEGIN -------------------
//<$>added:long.zhang 01.28.2015
//<$>reason:Application and Document Issues

//gnv_appeondb.of_StartQueue()
//UPDATEBLOB  app_blob
//	 SET app_image = :tot_b
//  WHERE app_id = :appid;
//COMMIT;
//UPDATE  app_blob
//	 SET modify_date = getdate()
//  WHERE app_id = :appid;
//COMMIT;
//gnv_appeondb.of_CommitQueue()

UPDATEBLOB  app_blob
	 SET app_image = :tot_b
 WHERE app_id = :appid;
If sqlca.sqlcode < 0 Then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Return -1
End If

UPDATE  app_blob
	 SET modify_date = getdate()
  WHERE app_id = :appid;
If sqlca.sqlcode < 0 Then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Return -1
End If
//------------------- APPEON END -------------------

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1

end function

public function integer of_init_storage_image ();String ls_app_path
Datastore lds_app_hdr
Long ll_row
String ls_path
Long ll_app_id

ls_app_path = gnv_data.of_getitem("ids","intelliapp_app_path",false)

lds_app_hdr = Create Datastore
lds_app_hdr.Dataobject = "d_distinct_app_hdr"
lds_app_hdr.Settransobject( SQLCA )
lds_app_hdr.Retrieve( )

FOR ll_row = 1 TO lds_app_hdr.Rowcount( )
	ll_app_id = lds_app_hdr.GetItemNumber(ll_row, "app_id")
	
	ls_path = ls_app_path + String( ll_app_id ) + ".tif"
	of_upload_app_image( ll_app_id, ls_path )
NEXT

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 08.22.2007 By: Evan
//$<Reason> Need to destroy object.
if IsValid(lds_app_hdr) then Destroy lds_app_hdr
//---------------------------- APPEON END ----------------------------

RETURN 1
end function

public function integer of_retrieve_image_from_db (integer ll_app_id, string as_filename);Integer li_image_storage_type
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server

li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0
IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN

	// Get Application image info from server
	Select modify_date
	Into :ldt_filedate_server
	From app_blob
	Where app_id = :ll_app_id;
	ls_filedate_server = String(ldt_filedate_server, 'mm/dd/yyyy hh:mm:ss')
	IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

	// Check file time
	IF FileExists(as_filename) THEN
		// Get local file modify date
		gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Application List", String(ll_app_id), RegString!, ls_filedate_local)

		// Check file modify date
		IF ls_filedate_local = ls_filedate_server THEN RETURN 100
	END IF

	n_appeon_download lnv_download
	lnv_download.of_parsefile( as_filename )
	
	// Open processs window
	openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )
	
	of_download_app_image( ll_app_id, as_filename )

	// Close process window
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	
	IF FILEEXISTS(as_filename) THEN
		// Set last modify date to registry
		gnv_appeondll.of_RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Application List", String(ll_app_id), RegString!, ls_filedate_server)	

		RETURN 100
	ELSE
		Debugbreak();
		RETURN -1
	END IF

END IF

RETURN 100
end function

public function integer of_retrieve_doc_from_db (integer ll_facility_id, string as_filename, ref string as_letter_path);string  ls_filedate_local,ls_filedate_server
Long li_filenum
Long ll_filelen
Long ll_bytes_written
Long ll_new_pos
Integer li_loops
Integer li_counter
Integer li_retval
Blob  lb_image_data
Blob blob_temp
Blob lb_tot_b
Blob total_blob
Blob blank_blob
Datetime ldt_filetime
Long ll_area_id
String ls_doc_name
String ls_doc_fullname
String ls_letter_path

// Check word templete storage type
Integer li_word_storage_type
li_word_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "set_50", FALSE))
IF Isnull(li_word_storage_type) THEN li_word_storage_type = 0
IF Upper( AppeonGetClientType() ) = "PB" AND li_word_storage_type = 0 THEN
	RETURN 100
END IF

IF Isnull(as_filename) OR LenA(as_filename) = 0 THEN RETURN 0


// Get file time from database
SELECT TOP 1 sys_storage_docs.last_edit_date, sys_storage_docs.area_id, sys_storage_docs.doc_name, sys_storage_area.area_doc_path
INTO :ldt_filetime, :ll_area_id, :ls_doc_name, :ls_letter_path
FROM sys_storage_docs, facility, sys_storage_area
WHERE sys_storage_docs.area_id = sys_storage_area.area_id
AND (Convert(varchar(10), sys_storage_docs.area_id) = facility.letter_path OR :ll_facility_id = 0)//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fixed Reintegration BugT100902 Append condition ll_facility_id = 0 for CLX biz
AND (facility.facility_id = :ll_facility_id OR :ll_facility_id = 0)//(Appeon)Toney 10.12.2013 - V141 ISG-CLX Fixed Reintegration BugT100902 Append condition ll_facility_id = 0 for CLX biz
AND sys_storage_docs.doc_name = :as_filename
;

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

IF Isnull(ls_doc_name) OR LenA(ls_doc_name) = 0 THEN
	RETURN -1
END IF

//ls_filedate_server = String(ldt_filetime, 'mm/dd/yyyy hh:mm:ss')

//dont need check local file
//// Check file time
//IF FileExists(as_filename) THEN
//	gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Templates List\" + &
//	String(ll_area_id), ls_doc_name, RegString!, ls_filedate_local)
//	IF ls_filedate_local = ls_filedate_server THEN RETURN 0
//END IF



// Check letter path
n_appeon_download lnv_download
IF f_validstr(as_letter_path) THEN
	lnv_download.of_parsepath( as_letter_path )
END IF

//----Begin Added by alfee 10.28.2010 ------------
//<$Reason>To avoid problem with security on users systems
IF NOT DirectoryExists( as_letter_path ) THEN
	as_letter_path = gs_temp_path + "Letters\"
	lnv_download.of_parsepath( as_letter_path) 
END IF
//----End Added -------------------------------------

IF NOT DirectoryExists( as_letter_path ) THEN
	as_letter_path = ls_letter_path
	lnv_download.of_parsepath( as_letter_path )
END IF

IF NOT DirectoryExists( as_letter_path ) THEN
	as_letter_path = "c:\"
END IF

// Open processs window
IF ib_open_process_window THEN
	openwithparm( w_appeon_gifofwait, "Opening document..." )
END IF
	
// Download File from database
ls_doc_fullname = as_letter_path + as_filename
n_appeon_storage_area lnv_storage_area

lnv_storage_area.of_download_file( ll_area_id, ls_doc_name, ls_doc_fullname)

// Close process window
IF ib_open_process_window THEN
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
END IF

IF FILEEXISTS(ls_doc_fullname) THEN
	RETURN 100
ELSE
	Debugbreak();
	RETURN -1
END IF

RETURN 100


end function

public function integer of_download_app_image (integer appid, ref blob lb_image_data);Long ll_data_length
Integer li_counter
Integer li_loops
Blob lb_data
Blob lb_all_data
Long ll_start

// Set a wait cursor
SetPointer(HourGlass!)

// Get file data from database
SELECT Datalength(app_image)
INTO :ll_data_length
FROM app_blob
WHERE app_id = :appid;

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	RETURN 0
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	Yield()
	SetPointer(HourGlass!)
	
	ll_start = (li_counter - 1) * 8000 + 1
	SELECTBLOB substring(app_image,:ll_start,8000)
	INTO :lb_data
	FROM app_blob
	WHERE app_id = :appid;

	lb_all_data += lb_data
NEXT 

lb_image_data = lb_all_data

Return 1

end function

public function integer of_download_file (integer areaid, string docname, ref blob lb_image_data);Long ll_data_length
Integer li_counter
Integer li_loops
Blob lb_data
Blob lb_all_data
Long ll_start

// Get file data from database
SELECT Datalength(doc_data)
INTO :ll_data_length
FROM sys_storage_docs
WHERE doc_name = :docname
AND area_id = :areaid;

IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
	RETURN 0
END IF

IF ll_data_length > 8000 THEN 
  	 IF Mod(ll_data_length,8000) = 0 THEN 
        li_loops = ll_data_length/8000 
    ELSE 
  	     li_loops = (ll_data_length/8000) + 1 
    END IF 
ELSE 
  	 li_loops = 1 
END IF 

FOR li_counter = 1 to li_loops
	Yield()
	SetPointer(HourGlass!)
	
	ll_start = (li_counter - 1) * 8000 + 1
	SELECTBLOB substring(doc_data,:ll_start,8000)
	INTO :lb_data
	FROM sys_storage_docs
	WHERE doc_name = :docname
	AND area_id = :areaid;

	lb_all_data += lb_data
NEXT 

lb_image_data = lb_all_data

Return 1

end function

public function integer of_close_opened_doc (string as_file);//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2006-10-30 By: Liu Hongxin
//$<reason> It will open a copy if the document is opened, close it first.
String ls_file
ls_file = as_file
IF RightA(ls_file, 4) = ".doc" THEN
	ls_file = LeftA(ls_file, LenA(ls_file) - 4)
ELSE
	RETURN -1
END IF

oleobject lole_word
lole_word = CREATE oleobject
if lole_word.Connecttonewobject("word.application") <> 0 then
	messagebox('Client Error', 'This application could not connect to Microsoft Word. Please make sure it is properly installed.')
	return -1
end if
lole_word.Application.NormalTemplate.Saved = TRUE //Added By Ken.Guo 2008-07-22
IF lole_word.Application.Documents.Count > 0 THEN
	lole_word.Documents.Close(0)	//wdDoNotSaveChanges
ELSE
	Long ll_handle
	ls_file += ' - Microsoft word'
	ll_handle = FindWindowA(0, ls_file)
	IF ll_handle > 0 THEN
		CONSTANT uint WM_CLOSE = 16
		Send( ll_handle, WM_CLOSE, 1, Long( 0, 0 ) )
	END IF
END IF

lole_word.Quit(0)//added by alfee 05.17.2007
lole_word.disconnectobject( )
Destroy lole_word //added by alfee 05.17.2007
Return 1
//---------------------------- APPEON END ----------------------------
end function

public function string of_convert_file (string as_source_file);//Convert the Word file to the Word 2003 format - alfee 03.06.2013
//Return the file name converted

Long ll_pos, ll_cnt
String ls_target_file, ls_source_file
Oleobject lole_word

//Verify the source file
IF Right(Trim(Lower(as_source_file)), 4) = ".doc" OR FileLength(as_source_file) < 1 THEN RETURN as_source_file
IF IsNull(as_source_file) OR Right(Trim(Lower(as_source_file)), 5) <> ".docx" THEN RETURN as_source_file

//Parse and verify the target file 
ls_source_file = Trim(as_source_file)
ll_pos = LastPos(ls_source_file, "\")
ls_target_file = Mid(ls_source_file, ll_pos + 1)
ls_target_file = Left (ls_target_file, Len(ls_target_file) -1)
ls_target_file = gs_temp_path + "Letters\Converted\" + ls_target_file

gnv_appeondll.of_parsepath(gs_temp_path + "Letters\Converted\" )

IF FileExists (ls_target_file) THEN FileDelete (ls_target_file)
IF FileExists (ls_target_file) THEN RETURN as_source_file

//Convert the file format
TRY
lole_word = Create oleobject
IF lole_word.Connecttonewobject("word.application") <> 0 THEN
	Destroy lole_word 
	RETURN as_source_file
END IF
lole_word.Visible = FALSE	
lole_word.Application.NormalTemplate.Saved = TRUE
lole_word.Application.Documents.Open(as_source_file, false, true)

Catch(Throwable th1) 
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_word
	RETURN as_source_file
End Try

Try
lole_word.ActiveDocument.SaveAs(ls_target_file, 0) //Word 2003 format

Catch(Throwable th2) 
	lole_word.ActiveDocument.Close(0)		
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_word
	RETURN as_source_file
End Try

//Check if target file created
DO 
	Yield()
	ll_cnt ++
	IF FileExists(ls_target_file) THEN EXIT
LOOP UNTIL ll_cnt > 100000

//Quit Word application
IF isvalid(lole_word) Then
	lole_word.ActiveDocument.Close(0) //alfee 01.06.2013
	lole_word.Quit(0)
	lole_word.DisconnectObject( )
	Destroy lole_word
END IF

IF NOT FileExists(ls_target_file)  THEN RETURN as_source_file
RETURN ls_target_file








end function

public function boolean of_check_image_modified (integer ll_app_id, string as_filename);//====================================================================
//$<Function>: of_check_image_modified
//$<Arguments>:
// 	value    integer    ll_app_id
// 	value    string     as_filename
//$<Return>:  boolean true:modified/false:not modified
//$<Description>: check if the image has been modified in database. (Not Used).
//$<Author>: (Appeon) long.zhang 01.27.2015 
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
Integer li_image_storage_type
String ls_filedate_local, ls_filedate_server
Datetime ldt_filedate_server

li_image_storage_type = Integer(gnv_data.of_getitem( "icred_settings", "image_storage_type", FALSE))
IF Isnull(li_image_storage_type) THEN li_image_storage_type = 0
IF Upper( AppeonGetClientType() ) <> "PB" OR li_image_storage_type = 1 THEN
	// Get Application image info from server
	Select modify_date
	Into :ldt_filedate_server
	From app_blob
	Where app_id = :ll_app_id;
	ls_filedate_server = String(ldt_filedate_server, 'mm/dd/yyyy hh:mm:ss')
	IF Isnull(ls_filedate_server) OR ls_filedate_server="" THEN ls_filedate_server =  String(today(), 'mm/dd/yyyy hh:mm:ss')

	// Check file time
	IF FileExists(as_filename) THEN
		// Get local file modify date
		gnv_appeondll.of_RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\IntelliSoft Group\Application List", String(ll_app_id), RegString!, ls_filedate_local)

		// Check file modify date
		If ls_filedate_local = ls_filedate_server Then
			Return False
		Else
			Return True
		End If
	END IF
END IF

//not modified
Return False
end function

public function integer of_upload_report_file (long al_pkid, string fullname);//====================================================================
//$<Function>: of_upload_report_file
//$<Arguments>:
// 	%ScriptArgs%
//$<Return>:  integer
//$<Description>: 
//$<Author>: (Appeon) Stephen 05.24.2017 (V15.4-WebView Reporting Functionality)
//--------------------------------------------------------------------
//$<Modify History>:
//====================================================================
blob tot_b

// Set a wait cursor
SetPointer(HourGlass!)

If not fileexists(fullname) then return -1

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading Image to Database..." )
if inv_utils.of_ReadBlob(FullName, tot_b) = -1 then Return -1

// Upload the file to database
UPDATEBLOB  sys_report_storage_files
	 SET report_data = :tot_b
 WHERE pk_id = :al_pkid;
If sqlca.sqlcode < 0 Then
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)
	Return -1
End If

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1

end function

on n_appeon_storage_area.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_appeon_storage_area.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;inv_FileSrv = Create n_cst_filesrvwin32 

end event

event destructor;If isvalid(inv_FileSrv) Then Destroy inv_FileSrv
end event

