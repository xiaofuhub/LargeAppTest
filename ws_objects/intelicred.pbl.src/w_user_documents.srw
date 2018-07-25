$PBExportHeader$w_user_documents.srw
forward
global type w_user_documents from w_main
end type
type cb_reload from commandbutton within w_user_documents
end type
type cb_delete from commandbutton within w_user_documents
end type
type cb_save from commandbutton within w_user_documents
end type
type cb_view from commandbutton within w_user_documents
end type
type cb_add from commandbutton within w_user_documents
end type
type cb_close from commandbutton within w_user_documents
end type
type dw_detail from u_dw within w_user_documents
end type
type dw_browse from u_dw within w_user_documents
end type
end forward

global type w_user_documents from w_main
integer width = 4722
integer height = 2356
string title = "User Documents"
boolean maxbox = false
long backcolor = 33551856
cb_reload cb_reload
cb_delete cb_delete
cb_save cb_save
cb_view cb_view
cb_add cb_add
cb_close cb_close
dw_detail dw_detail
dw_browse dw_browse
end type
global w_user_documents w_user_documents

type variables
long ii_id
string is_document_path
string is_save_folder

n_cst_dm_utils inv_dm_utils
end variables

forward prototypes
public function integer of_add_document ()
public function integer of_view_document (string as_file, string as_ext, long al_record)
end prototypes

public function integer of_add_document ();//Start Code Change ----08.16.2016 #V153 maha - added
string ls_fullname, ls_name
string ls_ext
integer value
integer li_pos ,p
integer li_ret
integer nr

Value = GetFileOpenName("Select File", &
	+ ls_fullname, ls_name, "TIF", &
	+ "TIFF Files (*.tif),*.tif," &
	+ "Bitmap Files (*.bmp),*.bmp," &
	+ "JPG Files (*.jpg),*.jpg," &
	+ "PDF Files (*.pdf),*.pdf," &
	+ "Word Documents(*.doc),*.doc," &
	+ "Word Documents(*.docx),*.docx," &
	+ "Excel Files (*.xls),*.xls,"	&
	+ "Excel Files (*.xlsx),*.xlsx,"	&
	+ "All Files (*.*), *.*"  	)   

if Value = 0 then return 0 //alfee 07.14.2009

p = 1
Do until p = 0
	p = pos(ls_fullname,"." , p + 1)
	if p > 0 then li_pos = p
loop
	
ls_ext = Upper(mid(ls_fullname,li_pos + 1)) 

nr = dw_detail.insertrow(0)

dw_detail.setitem(nr,"file_name",ls_name )
dw_detail.setitem(nr,"file_description",ls_name )
dw_detail.setitem(nr,"file_type",ls_ext)
dw_detail.setitem(nr,"owner_id",gs_user_id )
dw_detail.setitem(nr,"add_date",datetime(today(),now()))
dw_detail.setitem(nr,"add_user",gs_user_id )
dw_detail.update()

//user_doc_id is an identity field; get value after save
ii_id = dw_detail.getitemnumber(nr, "user_doc_id")
debugbreak()
IF of_upload_doc_data("USERDOC", ls_fullname,"",ii_id) = -1 THEN //alfee 07.14.2009
	Messagebox( "Upload Document", "Failed to upload the document!")
	RETURN -1
ELSE
	Messagebox( "Upload Document", "The document has been successfuly uploaded!")
END IF


RETURN 1
end function

public function integer of_view_document (string as_file, string as_ext, long al_record);//Start Code Change ----08.16.2016 #V153 maha - copied from oppe code and modified

String ls_file_temp, ls_file, ls_Null
string ls_ext  
long ll_bloblen
Blob lblb_data
str_office_ocx lstr_parms

IF IsValid(w_office_display) THEN Close(w_office_display)
IF IsValid(w_image_display) THEN Close(w_image_display)

//Download document to blob

select datalength(doc_data) into :ll_bloblen from sys_user_docs where user_doc_id = :al_record;
if isnull(ll_bloblen) or ll_bloblen = 0 then
	messagebox("File Data","There is no document data associated with this record.")
end if
	

lblb_data = of_download_file("USERDOC","", al_record)
IF isnull(lblb_data) THEN
	messagebox("File Download","There is no document data associated with this record.")
	RETURN -1
END IF

ls_ext = as_ext
ls_file = as_file
if isnull(ls_file) then ls_file = ""

if ls_file = "" then
	messagebox("View File","There is no file name connected to this record") 
	return -1
end if

ls_ext = of_strip_char(".",ls_ext,"") //check for period


//Save blob to document
is_save_folder = is_document_path + "Temp\"
ls_file_temp = is_document_path + "Temp\" + as_file
messagebox("file", ls_file_temp)
IF inv_dm_utils.of_saveblob( ls_file_temp, lblb_data) = -1 THEN 
	messagebox("File Download","Failed to save blob to the document of " + ls_file_temp + '!')
	RETURN -1
END IF	

DO 
	Yield( )
LOOP UNTIL FileExists(ls_file_temp)
	
//Open document
CHOOSE CASE Upper(ls_ext)
	CASE 'TIF', 'BMP','JPG' //,'PDF' -commented by alfee 10.28.2014 for BugA102801
		//IF IsNull(ls_file) THEN as_file = ''  maha moved above
		OpenWithParm(w_image_display, ls_file_temp + '|' + ls_file)
	CASE 'DOC', 'DOCX',  'XLS', 'XLXS'
		lstr_parms.call_from = 'USERDOCS'
		lstr_parms.file_ext = ls_ext
		lstr_parms.file_name = ls_file_temp
		lstr_parms.file_name_ori = ls_file
		lstr_parms.read_only = false
		OpenWithParm(w_office_display, lstr_parms)
	CASE ELSE
		SetNull(ls_Null)
		ShellExecuteA ( Handle( This ), "open", ls_file_temp , ls_Null, ls_Null, 4)
END CHOOSE

RETURN 1
end function

on w_user_documents.create
int iCurrent
call super::create
this.cb_reload=create cb_reload
this.cb_delete=create cb_delete
this.cb_save=create cb_save
this.cb_view=create cb_view
this.cb_add=create cb_add
this.cb_close=create cb_close
this.dw_detail=create dw_detail
this.dw_browse=create dw_browse
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reload
this.Control[iCurrent+2]=this.cb_delete
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_view
this.Control[iCurrent+5]=this.cb_add
this.Control[iCurrent+6]=this.cb_close
this.Control[iCurrent+7]=this.dw_detail
this.Control[iCurrent+8]=this.dw_browse
end on

on w_user_documents.destroy
call super::destroy
destroy(this.cb_reload)
destroy(this.cb_delete)
destroy(this.cb_save)
destroy(this.cb_view)
destroy(this.cb_add)
destroy(this.cb_close)
destroy(this.dw_detail)
destroy(this.dw_browse)
end on

event open;call super::open;//Start Code Change ----07.06.2016 #V153 maha - added

dw_browse.retrieve(gs_user_id, gi_role_id  )

 is_document_path = gs_temp_path







end event

type cb_reload from commandbutton within w_user_documents
integer x = 4055
integer y = 1812
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Reload"
end type

event clicked;//Start Code Change ----12.01.2016 #V153 maha - added
Long ll_row, ll_dcmt_id
String ls_file_name, ls_file
string docpath, docname, ls_ext
integer i, li_cnt, li_rtn, li_filenum, p, li_pos, res
long ll_id, r

 ll_row = dw_detail.getrow()
 r = dw_browse.getrow()

if ll_row < 1 or r < 1 then return //(Appeon)Stephen 02.24.2017 -BugS022203
li_rtn = GetFileOpenName("Select File", docpath, docname, "DOC",  "All Files (*.*), *.*", is_save_folder , 18)
if li_rtn < 1 then return

p = 1
Do until p = 0
	p = pos(docname,"." , p + 1)
	if p > 0 then li_pos = p
loop
	
ls_ext = Upper(mid(docname,li_pos + 1)) 
ls_file = docname
ls_file_name = dw_detail.getitemstring(ll_row, "file_name")

if ls_file <> ls_file_name then
	res = messagebox(ls_file,  "The selected file's name does not match the existing file.  Do you wish to replace the the existing file with the selected one?", question!,yesno!,2)
	if res = 2 then 	return
	dw_detail.setitem(ll_row, "file_name", ls_file)
	dw_detail.setitem(ll_row, "file_type", ls_ext)
	dw_detail.setitem(ll_row, "file_description", ls_ext)
	dw_browse.setitem(r, "file_name", ls_file)
	dw_browse.setitem(r, "file_type", ls_ext)
	dw_browse.setitem(r, "file_description", ls_ext)
end if

ll_id = dw_detail.getitemnumber(ll_row, "user_doc_id")

IF of_upload_doc_data("USERDOC", docpath,"",ll_id) = -1 THEN //alfee 07.14.2009
	Messagebox( "Upload Document", "Failed to upload the document!")
	RETURN -1
ELSE
	dw_detail.setitem(ll_row, "mod_date", datetime(today(),Now()))
	dw_detail.setitem(ll_row, "mod_user", gs_user_id)
	dw_browse.setitem(r, "mod_date", datetime(today(),Now()))
	dw_browse.setitem(r, "mod_user", gs_user_id)
	dw_detail.update()
	Messagebox( "Upload Document", "The document has been successfuly uploaded!")
END IF

//IF ll_row > 0 THEN
//	ll_dcmt_id = dw_detail.GetItemNumber(ll_row, "user_doc_id")
//	ls_file_name = dw_detail.GetItemString(ll_row, "file_name")
//	ls_file_type = dw_detail.GetItemString(ll_row, "file_type")
//	//IF LeftA(ls_file_type, 1) = '.' THEN ls_file_type = MidA(ls_file_type, 2)
//	ls_file_type = Trim(Lower(ls_file_type))
//	
//	of_view_document(ls_file_name, ls_file_type, ll_dcmt_id)
//END IF




 


end event

type cb_delete from commandbutton within w_user_documents
integer x = 2555
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete"
end type

event clicked;integer li_ans
string ls_owner

if dw_detail.rowcount() < 1 then return

ls_owner = dw_detail.getitemstring(dw_detail.getrow(), "owner_id")

if ls_owner <> gs_user_id then
	messagebox("Delete Document","Only the owner can delete this document.")
	return
end if

li_ans = messagebox("Delete Document","Are you sure you want to delete this document?", question!,yesno!,2)

if li_ans = 2 then return

dw_detail.deleterow(1)
dw_detail.update()

dw_browse.retrieve(gs_user_id, gi_role_id)





end event

type cb_save from commandbutton within w_user_documents
integer x = 1701
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Save"
end type

event clicked;dw_detail.update()
end event

type cb_view from commandbutton within w_user_documents
integer x = 4055
integer y = 1716
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "View"
end type

event clicked;//Start Code Change ----08.16.2016 #V153 maha
Long ll_row, ll_dcmt_id
String ls_file_name, ls_file_type

ll_row = dw_detail.getrow()

IF ll_row > 0 THEN
	ll_dcmt_id = dw_detail.GetItemNumber(ll_row, "user_doc_id")
	ls_file_name = dw_detail.GetItemString(ll_row, "file_name")
	ls_file_type = dw_detail.GetItemString(ll_row, "file_type")
	//IF LeftA(ls_file_type, 1) = '.' THEN ls_file_type = MidA(ls_file_type, 2)
	ls_file_type = Trim(Lower(ls_file_type))
	
	of_view_document(ls_file_name, ls_file_type, ll_dcmt_id)
END IF

end event

type cb_add from commandbutton within w_user_documents
integer x = 2126
integer y = 20
integer width = 402
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Add"
end type

event clicked;integer res
integer rc
long ll_find
long ll_id

dw_detail.reset()
res = of_add_document( )
ll_id = ii_id

rc = dw_browse.retrieve(gs_user_id, gi_role_id)

ll_find = dw_browse.find( "user_doc_id = " + string (ll_id) , 1, rc)

if ll_find > 0 then
	dw_browse.setrow(ll_find)
end if

end event

type cb_close from commandbutton within w_user_documents
integer x = 4242
integer y = 20
integer width = 402
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_detail from u_dw within w_user_documents
integer x = 9
integer y = 1544
integer width = 4672
integer height = 680
integer taborder = 20
boolean titlebar = true
string title = "Detail"
string dataobject = "d_user_docs_detail"
boolean livescroll = false
end type

event constructor;call super::constructor;DataWindowChild dwchild

this.of_settransobject( sqlca)

This.GetChild( "share_id", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
dwchild.setitem(1, "user_id", "*All*")
dwchild.insertrow(1)

This.GetChild( "share_role", dwchild )
dwchild.settransobject(sqlca)
dwchild.retrieve()
dwchild.insertrow(1)
end event

event retrieveend;call super::retrieveend;if this.rowcount() < 1 then return

if this.getitemstring(1, "owner_id") <> gs_user_id then
	cb_delete.enabled = false
else
	cb_delete.enabled = true
end if
end event

type dw_browse from u_dw within w_user_documents
integer x = 9
integer y = 136
integer width = 4672
integer height = 1396
integer taborder = 10
boolean titlebar = true
string title = "File List"
string dataobject = "d_user_docs_browse"
boolean hscrollbar = true
end type

event constructor;call super::constructor;this.of_settransobject( sqlca)
this.of_setupdateable( false)
end event

event rowfocuschanged;call super::rowfocuschanged;long ll_id

if this.rowcount() < 1 then return
ll_id = this.getitemnumber(currentrow, "user_doc_id")
ii_id = ll_id

this.selectrow(0,false)
this.selectrow(currentrow, true)

dw_detail.retrieve(ll_id, gs_user_id)



end event

event clicked;call super::clicked;this.setrow(this.getclickedrow())

end event

