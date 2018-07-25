$PBExportHeader$w_wv_letter_template.srw
forward
global type w_wv_letter_template from w_sheet
end type
type cb_ds from commandbutton within w_wv_letter_template
end type
type cb_close from commandbutton within w_wv_letter_template
end type
type cb_save from commandbutton within w_wv_letter_template
end type
type dw_wv_letter_template from u_dw within w_wv_letter_template
end type
end forward

global type w_wv_letter_template from w_sheet
integer x = 214
integer y = 221
integer width = 4128
integer height = 624
string title = "WV Affil Letter Templates "
boolean maxbox = false
long backcolor = 33551856
boolean center = true
cb_ds cb_ds
cb_close cb_close
cb_save cb_save
dw_wv_letter_template dw_wv_letter_template
end type
global w_wv_letter_template w_wv_letter_template

type variables
boolean ib_save
string is_ds  //maha 04.17.2017
end variables

forward prototypes
public function integer of_get_doc (integer ai_letter_id, string as_doc_name)
public function integer of_opendocument (string as_file)
public function integer of_create_data_source (boolean ab_get_prac)
end prototypes

public function integer of_get_doc (integer ai_letter_id, string as_doc_name);//////////////////////////////////////////////////////////////////////
// $<function> of_get_doc
// $<arguments>
// $<returns> integer
// $<description> Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add> 02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////

Long li_filenum
Long ll_filelen, ll_start
Long  ll_data_length
Integer li_loops
Integer li_counter
Blob  lb_image_data
Blob blob_temp
Blob total_blob
string ls_file, ls_Null
String ls_filename, ls_ret
integer  value

SetPointer(HourGlass!)

ls_filename = as_doc_name + ".doc"

//ls_file = gs_temp_path + "images\"  
ls_file = gs_temp_path + "Letters\"  //alfee 11.21.2014 for WebView Affletter questions
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file + ls_filename
		
//openwithparm(w_wv_download_doc, ls_filename)
//
//ls_ret = message.stringparm
//
//choose case ls_ret
//	case '1'
//	case '2'
//		value = GetFileSaveName("Save as", &
//					+ ls_file, ls_filename, "doc", &
//					 "ALL Files(*.*),*.*")
//					 
//		ChangeDirectory(gs_current_path)
//		if value <> 1 then return 0
//	case else
//		return 0
//end choose


IF FileExists(ls_file) THEN
	filedelete(ls_file)
END IF

openwithparm( w_appeon_gifofwait, "Downloading Image from Database..." )

IF appeongetclienttype() = 'PB' AND gs_dbtype = 'SQL' THEN
	
	SELECT Datalength(letter_file)
	INTO     :ll_data_length
	FROM    wv_letter
	WHERE 	wv_letter_id  = :ai_letter_id
	USING    SQLCA;
	
	IF ll_data_length = 0 OR Isnull(ll_data_length) THEN
		MessageBox("File Creation Error", "The Document is not stored in the database: " + ls_filename )
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
		SELECTBLOB substring(letter_file,:ll_start,8000)
		INTO :blob_temp
		FROM wv_letter
	  WHERE wv_letter_id  = :ai_letter_id
	   USING  SQLCA;
	
		total_blob += blob_temp
	NEXT 
	
	lb_image_data = total_blob
ELSE
	SELECTBLOB letter_file 
	INTO :lb_image_data
	FROM wv_letter 
	WHERE wv_letter_id  = :ai_letter_id
	   USING  SQLCA;
	
END IF

IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

IF SQLCA.SQLCODE = -1 THEN
	MessageBox( "SQL ERROR", SQLCA.SQLERRTEXT )
	Return -1
END IF

ll_filelen = LenA( lb_image_data )

IF Isnull(lb_image_data) OR ll_filelen = 0 THEN
	MessageBox("File Creation Error", "The Document is not stored in the database: " + ls_filename )
	RETURN -1
END IF

//create the file
if f_open_image_from_database(ls_file,lb_image_data ) = -1 then return -1

IF Not FileExists( ls_file) THEN
	MessageBox("File Creation Error", "No document created.  Check to make sure the directory " + gs_dir_path + " is valid." )
	Return -1 //added by Evan 04.25.2012
END IF

//----------------------- APPEON BEGIN ------------------------
//$<modify> Evan 04.25.2012
//$<reason> Don't open Find Data Source dialog when opening document.
/*
setnull(ls_Null)
IF FileExists(ls_file) and ls_ret = '1' THEN
	ShellExecuteA ( Handle( This ), "open", ls_file, ls_Null, ls_Null, 1)
END IF
*/
dw_wv_letter_template.setitem(dw_wv_letter_template.getrow(), "doc_file", ls_file)
of_open_letter(ls_file, is_ds, "Affletter")   //Start Code Change ----04.18.2017 #V153 maha
//of_OpenDocument(ls_file)
//----------------------- APPEON END --------------------------

Return 1
end function

public function integer of_opendocument (string as_file);//////////////////////////////////////////////////////////////////////
// $<function> of_opendocument
// $<arguments>
//		string	as_file
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// $<add> 04.25.2012 by Evan
//////////////////////////////////////////////////////////////////////

integer li_rc = 1

//oleobject lole_word
//
//lole_word = Create oleobject
//
//try
//	// Connect to word application and open document
//	if lole_word.ConnectToNewObject("word.application") = 0 then
//		lole_word.Application.Documents.Open(as_File)
//		lole_word.Visible = true
//	else
//		li_rc = -1
//		MessageBox("Error", "This application could not connect to Microsoft Word. Please make sure it is properly installed.")
//	end if
//catch (throwable th)
//	li_rc = -1
//	MessageBox("Error", "Failed to open document.")
//end try
//
//// Destroy object
//lole_word.DisconnectObject()
//Destroy lole_word

//of_open_letter(as_file,is_ds,"Privileges")

n_cst_appeondll lnv_appeondll
lnv_appeondll.of_BringTopMergeFieldDlg(1) //Added by Evan 04.27.2012
//n_cst_msword
if gnv_app.gnvlo_msword.of_open_word_document( as_file , is_ds, "Affletter") = -1 then
	lnv_appeondll.of_BringTopMergeFieldDlg(0)
	return -1
end if
lnv_appeondll.of_BringTopMergeFieldDlg(0) //Added by Evan 04.27.2012


Return li_rc
end function

public function integer of_create_data_source (boolean ab_get_prac); //Start Code Change ----04.17.2017 #V153 maha - added
 //when opening the letter ab_get_prac will be false; if the DS does not wxist it will run anyway
n_ds lds_data
long ll_prac
long ll_facil
string ls_file
integer res

ls_file = gs_temp_path + "Letters\data\"  //alfee 11.21.2014 for WebView Affletter questions
gnv_appeondll.of_parsepath(ls_file)
ls_file = ls_file +  "wv_affletter data_source.txt"
is_ds = ls_file

if not fileexists(ls_file) then ab_get_prac = true
//get pract
if ab_get_prac then
	gs_search lstr_search
	 lstr_search.stran_transaction = sqlca
	 lstr_search.ls_open_for =  "SINGLE"
	openwithparm(w_extended_search_new,  lstr_search)
	
	ll_prac = long(message.stringparm)
	ll_facil = gi_parent_facility

	lds_data = create n_ds
	lds_data.dataobject = "d_wv_affletter_data_source"
	lds_data.settransobject(sqlca)
	res = lds_data.retrieve(ll_prac, ll_facil)
	if res < 1 then
		messagebox("Data source failure","Data source retrieved no data." + string(res))
		return -1
	else
		lds_data.saveas( ls_file, text!,true)
		messagebox("Data source created","Data source created.       " + ls_file)
	end if
	
	destroy lds_data
end if

if fileexists(ls_file) then
	//messagebox("Data source file", ls_file)
else
	messagebox("Data source file", "File not saved: " + ls_file)
end if

return 1
end function

on w_wv_letter_template.create
int iCurrent
call super::create
this.cb_ds=create cb_ds
this.cb_close=create cb_close
this.cb_save=create cb_save
this.dw_wv_letter_template=create dw_wv_letter_template
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ds
this.Control[iCurrent+2]=this.cb_close
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.dw_wv_letter_template
end on

on w_wv_letter_template.destroy
call super::destroy
destroy(this.cb_ds)
destroy(this.cb_close)
destroy(this.cb_save)
destroy(this.dw_wv_letter_template)
end on

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event> open
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.22.2012 by Stephen
// $<modify> 03.20.2012 by Evan --- Fixed bug
//////////////////////////////////////////////////////////////////////

integer li_Exists

gnv_appeondb.of_StartQueue()
if gs_DBType = "ASA" then
	select Count(*) into :li_Exists from sys.syscolumn c,sys.systable t where c.table_id=t.table_id and
	c.column_name='letter_file' and t.table_name='wv_letter';
else
	select Count(*) into :li_Exists from syscolumns c, sysobjects t where c.id=t.id and
	c.name='letter_file' and t.name='wv_letter' and t.type = 'U';
end if
dw_wv_letter_template.Retrieve()
gnv_appeondb.of_CommitQueue()

if IsNull(li_Exists) or li_Exists <> 1 then
	MessageBox("Warning", "This module is unavailable currently because the letter templates have not been upgraded in WebView.", Exclamation!)
	Close(this)
	Return
end if
end event

event closequery;call super::closequery;//////////////////////////////////////////////////////////////////////
// $<event> closequery
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.22.2012 by Stephen
//////////////////////////////////////////////////////////////////////
cb_save.event clicked()
if not ib_save then
	return 1
end if

end event

type cb_ds from commandbutton within w_wv_letter_template
integer x = 37
integer y = 12
integer width = 535
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Create Data Source"
end type

event clicked;of_create_data_source(true)
end event

type cb_close from commandbutton within w_wv_letter_template
integer x = 3543
integer y = 12
integer width = 535
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(parent)
end event

type cb_save from commandbutton within w_wv_letter_template
integer x = 1682
integer y = 12
integer width = 1029
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Save Updated Documents to Database"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////
String 	ls_doc_name
String 	 ls_func_type
Integer 	 li_row, li_letter_id
blob       lb_doc
dwitemstatus ldws_1, ldws_file
pfc_cst_nv_image_functions lnv_image_functions
boolean lb_box = false

dw_wv_letter_template.accepttext( )

SetPointer(HourGlass!)
ib_save = true

lnv_image_functions = create pfc_cst_nv_image_functions
for li_row = 1 to dw_wv_letter_template.rowcount()
	ldws_file = dw_wv_letter_template.getitemstatus(li_row, 'doc_file', primary!)
	if  ldws_file = datamodified! then
		ls_doc_name = dw_wv_letter_template.GetItemString(li_row, "doc_file")
		li_letter_id = dw_wv_letter_template.GetItemnumber(li_row, "wv_letter_id") 
	
		if isnull(ls_doc_name) or ls_doc_name='' then continue
		
		if not lb_box then
			if messagebox("Prompt", "Are you sure you want to replace the letters in the database with your new versions?", Exclamation!, YesNo!) = 2 then 
				if isvalid(lnv_image_functions) then destroy lnv_image_functions 
				return 1
			end if
		end if
			
		if not FileExists( ls_doc_name ) then 
			MessageBox("Reminder","The file '" + ls_doc_name  +"'does not exist. ")  
			ib_save = false
			if isvalid(lnv_image_functions) then destroy lnv_image_functions 
			return -1
		end if
		
		lb_box = true
		if not isvalid(w_appeon_gifofwait) then
			openwithparm( w_appeon_gifofwait, "Saving as document..." )
		end if
	
		lb_doc = lnv_image_functions.of_read_image_file( ls_doc_name )
		
		update wv_letter 
				  set  upload_time  = getdate()
			 where wv_letter_id = :li_letter_id using sqlca;
			 
		updateblob wv_letter 
				  set  letter_file  = :lb_doc
			 where wv_letter_id = :li_letter_id using sqlca;
	
		if sqlca.sqlcode <> 0 then
			MessageBox("Prompt","Saving as document failed!")
			ROLLBACK using sqlca;
			ib_save = false
			if isvalid(lnv_image_functions) then destroy lnv_image_functions 
			Return -1;
		end if
	end if	
next
if isvalid(lnv_image_functions) then destroy lnv_image_functions 
		
COMMIT using sqlca;

if lb_box then
	dw_wv_letter_template.retrieve()
	this.enabled = false
	
	if  isvalid(w_appeon_gifofwait) then close(w_appeon_gifofwait)
	MessageBox("Prompt","Saving as document successful !")
end if

end event

type dw_wv_letter_template from u_dw within w_wv_letter_template
integer x = 23
integer y = 128
integer width = 4050
integer height = 356
integer taborder = 10
string dataobject = "d_wv_letter_template"
end type

event buttonclicked;call super::buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
// $<returns> long
// $<description> Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.22.2012 by Stephen
//////////////////////////////////////////////////////////////////////

 //Start Code Change ----04.18.2017 #V153 maha - moved download code from clicked and rewrote
if row < 1 then return

if dwo.name = "b_file" then
	string docname, named
	Datetime ldt_today
	integer value, li_pos, li_return

	value = GetFileOpenName("Select File", &
		+ docname, named, "doc", &
		 "Word 97-2003 Document (*.doc),*.doc," + &
		 "ALL Files(*.*),*.*")
		
	ChangeDirectory(gs_current_path)
	
	if value <> 1 then return
	
	this.setitem(row, 'doc_file', docname)
	this.scrolltorow(row)
	
	cb_save.enabled = true
end if


if dwo.name = "b_download" then
	integer li_letter_id
	string   ls_doc_name
	
	li_letter_id = this.getitemnumber(row, "wv_letter_id")
	ls_doc_name = this.getitemstring(row, "document_name")
	of_create_data_source( false)   //Start Code Change ----04.17.2017 #V153 maha - added to check for/create DS for letter
	of_get_doc(li_letter_id, ls_doc_name)
	cb_save.enabled = true
end if

 //End Code Change ----04.18.2017



end event

event clicked;call super::clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.22.2012 by Stephen
//////////////////////////////////////////////////////////////////////
//integer li_letter_id
//string   ls_doc_name
//
//if row < 1 then return
//if dwo.name = 't_3' then
//	li_letter_id = this.getitemnumber(row, "wv_letter_id")
//	ls_doc_name = this.getitemstring(row, "document_name")
//	of_create_data_source( false)   //Start Code Change ----04.17.2017 #V153 maha - added to check for/create DS for letter
//	of_get_doc(li_letter_id, ls_doc_name)
//end if

//of_open_letter(ls_DocPath,ls_datasource,"Privileges")
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////
// $<event> constructor
// $<arguments>
// $<returns> long
// $<description>  Letter Template Maintenance (V12.1 WebView Painter Migration to Cred)
//////////////////////////////////////////////////////////////////////
// $<add>02.23.2012 by Stephen
//////////////////////////////////////////////////////////////////////

this.of_setupdateable(false)
end event

