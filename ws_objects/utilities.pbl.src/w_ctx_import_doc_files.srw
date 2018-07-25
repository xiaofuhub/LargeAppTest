$PBExportHeader$w_ctx_import_doc_files.srw
forward
global type w_ctx_import_doc_files from w_master
end type
type cb_1 from commandbutton within w_ctx_import_doc_files
end type
type sle_path from singlelineedit within w_ctx_import_doc_files
end type
type cb_2 from commandbutton within w_ctx_import_doc_files
end type
type st_1 from statictext within w_ctx_import_doc_files
end type
type cb_3 from commandbutton within w_ctx_import_doc_files
end type
type dw_imp from u_dw within w_ctx_import_doc_files
end type
type dw_docs from u_dw within w_ctx_import_doc_files
end type
end forward

global type w_ctx_import_doc_files from w_master
integer width = 1449
integer height = 584
string title = "Document Import Utility"
long backcolor = 33551856
cb_1 cb_1
sle_path sle_path
cb_2 cb_2
st_1 st_1
cb_3 cb_3
dw_imp dw_imp
dw_docs dw_docs
end type
global w_ctx_import_doc_files w_ctx_import_doc_files

forward prototypes
public function integer of_upload (long al_docid, string as_doc, string as_path_n_doc)
end prototypes

public function integer of_upload (long al_docid, string as_doc, string as_path_n_doc);integer li_FileNum, loops, i

long flen, bytes_read, new_pos

blob b, tot_b

// Set a wait cursor
SetPointer(HourGlass!)

//If not fileexists(as_path_n_doc) then return - 1 //

// Open processs window
openwithparm( w_appeon_gifofwait, "Uploading document to database..." )
	//debugbreak()
// Get the file length, and open the file
flen = FileLength(as_path_n_doc)

// Open the file
li_FileNum = FileOpen(as_path_n_doc, StreamMode!, Read!, LockRead!)

if li_FileNum < 0 then 
	if Isvalid( w_appeon_gifofwait) then Close( w_appeon_gifofwait)
	Return -1
end if


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
UPDATEBLOB  ctx_am_doc_image
	 SET image_file = :tot_b
  WHERE doc_id = :al_docid;
COMMIT;

// Close process window
IF Isvalid( w_appeon_gifofwait) THEN Close( w_appeon_gifofwait)

Return 1
end function

on w_ctx_import_doc_files.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.sle_path=create sle_path
this.cb_2=create cb_2
this.st_1=create st_1
this.cb_3=create cb_3
this.dw_imp=create dw_imp
this.dw_docs=create dw_docs
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.sle_path
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.dw_imp
this.Control[iCurrent+7]=this.dw_docs
end on

on w_ctx_import_doc_files.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.sle_path)
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.dw_imp)
destroy(this.dw_docs)
end on

type cb_1 from commandbutton within w_ctx_import_doc_files
integer x = 809
integer y = 280
integer width = 242
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Run"
end type

event clicked;//Start Code Change ----05.20.2008 #V8 maha -  added as utility 

Integer li_ans
integer chk
long r
long rc
long cnt
long incnt
long ic
long badcnt
Long ll_row
long ll_new
Long ll_doc_id
long ll_img_size
string ls_path
string ls_file
string ls_doc_name
string ls_ext


		

//ll_row = dw_storage_area.GetSelectedrow( 0 )
//IF ll_row = 0 THEN RETURN
//rc = dw_storage_docs.rowcount()



li_ans = MessageBox("Import Documents", "This function will search for documents that were not imported to the database when the document records were created.  It will not create new records.  Do you wish to continue?.", Question!, YesNo!, 1 )
IF li_ans = 2 then return

dw_docs.settransobject( sqlca)
dw_imp.settransobject( sqlca)

rc = dw_docs.retrieve()
ic = dw_imp.retrieve()
if rc = 0 then return

ls_path = sle_path.text
if LenA(ls_path) < 3 then
	messagebox("No Path","Enter the Path where the import documents are stored.")
	return
end if

if MidA(ls_path, LenA(ls_path) - 1) <> "\" then ls_path = ls_path + "\"


//if ls_path  = "CANCEL" then return

for r = 1 to rc
	ll_doc_id = dw_docs.GetItemNumber(r, "doc_id")
	ls_doc_name = dw_docs.getitemstring(r,"doc_name") 
	ls_file = ls_path + ls_doc_name
	ls_ext = MidA(ls_doc_name, LenA(ls_doc_name) - 3)
	
	ll_row = dw_imp.find("doc_id = "+ string(ll_doc_id),1,ic)
	IF ll_row = 0 THEN //creat new row
		//ll_new = dw_imp.insertrow(0)
		//ic = ll_new
		//dw_imp.setitem(ll_new,"doc_id",ll_doc_id )
		//dw_imp.setitem(ll_new,"revision","1.0" )
		//dw_imp.setitem(ll_new,"doc_ext",mid(ls_doc_name, len(ls_doc_name) - 3))
		//chk = dw_imp.update()
		
		insert into ctx_am_doc_image (doc_id,revision,doc_ext) values (:ll_doc_id,'1.0',:ls_ext);
		//if chk < 0 then MessageBox("Database Error", SQLCA.SQLERRTEXT )
		IF SQLCA.SQLCODE = -1 THEN
			MessageBox("Database Error", SQLCA.SQLERRTEXT )
		else
			commit;
		end if

	elseif ll_row > 0 then
		//debugbreak()
		select datalength(image_file) into :ll_img_size from ctx_am_doc_image where doc_id = :ll_doc_id; //check if image was previously uploaded
		if ll_img_size > 0 then
			incnt++
			continue
		end if 	
	else //failure
		continue
	end if
	
	if fileexists(ls_file) then
		of_upload( ll_doc_id, ls_doc_name, ls_file)
		cnt ++
	else
		badcnt++
	end if
next
messagebox("Imported","There were " + string(cnt) + " files imported and " + string(badcnt) + " files not found.  " + string(incnt) + " images previously existed.")
//dw_storage_docs.retrieve(ll_area_id)


end event

type sle_path from singlelineedit within w_ctx_import_doc_files
integer x = 187
integer y = 132
integer width = 869
integer height = 92
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_ctx_import_doc_files
integer x = 1074
integer y = 136
integer width = 242
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Browse"
end type

event clicked;String		ls_null, ls_folder
Integer 		li_result

SetNull( ls_null )

li_result = GetFolder( "", ls_folder )

IF li_result = 1 THEN
	IF RightA(ls_folder, 1) <> "\" THEN ls_folder = ls_folder + "\"
	sle_path.text = ls_folder
END IF
end event

type st_1 from statictext within w_ctx_import_doc_files
integer x = 187
integer y = 48
integer width = 581
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 33551856
string text = "Document Directory"
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_ctx_import_doc_files
integer x = 1070
integer y = 280
integer width = 242
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Close"
end type

event clicked;close(parent)
end event

type dw_imp from u_dw within w_ctx_import_doc_files
boolean visible = false
integer x = 160
integer y = 340
integer width = 55
integer height = 52
integer taborder = 20
string dataobject = "d_ctx_doc_image_add"
end type

type dw_docs from u_dw within w_ctx_import_doc_files
boolean visible = false
integer x = 78
integer y = 336
integer width = 50
integer height = 52
integer taborder = 10
string dataobject = "d_ctx_doc_list"
end type

