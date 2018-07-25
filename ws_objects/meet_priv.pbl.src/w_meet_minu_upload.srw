$PBExportHeader$w_meet_minu_upload.srw
forward
global type w_meet_minu_upload from window
end type
type cb_delete from commandbutton within w_meet_minu_upload
end type
type dw_1 from datawindow within w_meet_minu_upload
end type
type cb_3 from commandbutton within w_meet_minu_upload
end type
type cb_1 from commandbutton within w_meet_minu_upload
end type
end forward

global type w_meet_minu_upload from window
integer width = 2688
integer height = 1172
boolean titlebar = true
string title = "Uploading File"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
cb_delete cb_delete
dw_1 dw_1
cb_3 cb_3
cb_1 cb_1
end type
global w_meet_minu_upload w_meet_minu_upload

type variables
Boolean ib_new
Boolean ib_save
long      il_area_id
str_folder istr_doc
n_cst_image_functions_cp  inv_image_func
String is_file_name

pfc_cst_nv_image_functions  inv_image_functions
end variables

on w_meet_minu_upload.create
this.cb_delete=create cb_delete
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.Control[]={this.cb_delete,&
this.dw_1,&
this.cb_3,&
this.cb_1}
end on

on w_meet_minu_upload.destroy
destroy(this.cb_delete)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event> OPEN
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2011 by Stephen
//////////////////////////////////////////////////////////////////////

Long ll_row

dw_1.settransobject( SQLCA )

istr_doc = Message.powerobjectparm

IF isvalid(istr_doc) THEN
	dw_1.retrieve( istr_doc.as_type, istr_doc.al_category,  istr_doc.al_folder_id )
	
	if dw_1.rowcount() < 1 then
		ll_row = dw_1.Insertrow( 0 )
	
		dw_1.Setitem( ll_row, "function_type", istr_doc.as_type)
		dw_1.Setitem( ll_row, "facility_id", istr_doc.al_folder_id)
		dw_1.Setitem( ll_row, "record_id", istr_doc.al_category)		
	else
		cb_delete.visible = true  //Start Code Change ----05.06.2013 #V12 maha
	end if
END IF

end event

event closequery;//////////////////////////////////////////////////////////////////////
// $<event>closequery
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.26.2011 by Stephen
integer    li_msg, li_row
String 	ls_doc_name
String 	ls_doc_type
String     ls_description   
boolean  lb_new

dw_1.accepttext()
if isvalid(inv_image_functions) then destroy inv_image_functions
li_row = dw_1.getrow()
if li_row < 1 then return 0

ls_doc_name = dw_1.GetItemString(li_row, "file_name")
ls_doc_type = dw_1.GetItemString(li_row, "file_type")
ls_description = dw_1.GetItemString(li_row, "description")
lb_new = false

if (not isnull(ls_doc_name)) or (not isnull(ls_doc_type)) or (not isnull(ls_description)) then
	lb_new = true
end if

if dw_1.modifiedcount() > 0  and lb_new = true  then
	li_msg = MessageBox(gnv_app.iapp_object.DisplayName, &
					"Do you want to save changes?", exclamation!, YesNoCancel!, 1)
					
	if li_msg = 1 then 
		if cb_1.event clicked() = -1 then return 1		
	end if
	if  li_msg = 3 then return 1
end if		
		

end event

type cb_delete from commandbutton within w_meet_minu_upload
boolean visible = false
integer x = 50
integer y = 964
integer width = 663
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Delete Existing Document"
end type

event clicked;//Start Code Change ----05.06.2013 #V12 maha

integer li_ans

li_ans = messagebox("Delete Meeting Document",  "Are you sure you want to delete the Meeting Document?", question!,yesno!, 2)

if li_ans = 1 then
	dw_1.deleterow(0)
	dw_1.update()
end if
end event

type dw_1 from datawindow within w_meet_minu_upload
integer x = 32
integer y = 52
integer width = 2606
integer height = 876
integer taborder = 10
string title = "none"
string dataobject = "d_meet_minu_upload"
boolean livescroll = true
end type

event buttonclicked;//////////////////////////////////////////////////////////////////////
// $<event> buttonclicked
// $<arguments>
// $<returns> long
// $<description> N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.11.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string docname, named
Datetime ldt_today

integer value, li_pos, li_return

if row < 1 then return

value = GetFileOpenName("Select File", &
	+ docname, named, "docx", &
	 "Word Document (*.docx),*.docx," + &
	 "Word 97-2003 Document (*.doc),*.doc," + &
	 "Excel Workbook (*.xlsx),*.xlsx," + &
	 "Excel 97-2003 Workbook (*.xls),*.xls," + &
	 "TIFF Files (*.tif),*.tif," + &
	 "BMP Files (*.bmp),*.bmp," + &
	 "JPG Files (*.jpg),*.jpg," + &
	 "PDF Files (*.pdf),*.pdf," + &
	 "Text Files (*.txt),*.txt," + &
	 "ALL Files(*.*),*.*")
	
ChangeDirectory(gs_current_path)

if value <> 1 then return

this.setitem(row, 'file_name', named)
li_pos = pos(named, ".")
this.setitem(row, 'file_type', upper(mid(named, li_pos + 1)) )

ldt_today = Datetime( Today(), Now() )
dw_1.Setitem( row, "add_date", ldt_today)
dw_1.Setitem( row, "add_user", gs_user_id)	
		
is_file_name = docname




end event

event itemchanged;//////////////////////////////////////////////////////////////////////
// $<event> itemchanged
// $<arguments>
// $<returns> integer
// $<description>N/A (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 08.10.2011 by Stephen
//////////////////////////////////////////////////////////////////////

string ls_type
integer li_pos

if row < 1 then return

choose case dwo.name
	case "file_name"
		if not isnull(data) then
			li_pos = pos(data, '.')
			if li_pos > 0 then 
				ls_type = mid(data, li_pos +1)
			else
				ls_type = ''
			end if
		else
			ls_type = ''
		end if
		this.setitem(row , 'file_type',ls_type)
		
end choose
end event

type cb_3 from commandbutton within w_meet_minu_upload
integer x = 2336
integer y = 968
integer width = 265
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;CLOSE( PARENT )
end event

type cb_1 from commandbutton within w_meet_minu_upload
integer x = 2021
integer y = 964
integer width = 265
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description>Add button for uploading/viewing meeting minutes (V11.3 Committee Proc Upd)
//////////////////////////////////////////////////////////////////////
// $<add> 07.12.2011 by Stephen
//////////////////////////////////////////////////////////////////////

String 	ls_doc_name
String 	ls_doc_type, ls_func_type
String     ls_description   , ls_filepath
Integer 	li_cnt, li_row, li_pos
long		ll_Rtn, ll_facility, ll_record_id
blob       lb_doc
long ll_test_len
dwitemstatus ldws_1, ldws_file

dw_1.accepttext( )
li_row = dw_1.getrow()
if li_row < 1 then return

ls_doc_name = dw_1.GetItemString(li_row, "file_name")
ls_doc_type = dw_1.GetItemString(li_row, "file_type")
ls_description = dw_1.GetItemString(li_row, "description")

if isnull(ls_doc_name) or ls_doc_name = '' then
	Messagebox("Required Field", "Required value information for File Name.")
	dw_1.setfocus()
	dw_1.setcolumn("file_name")
	return -1
end if

if isnull(ls_doc_type) or ls_doc_type = '' then
	Messagebox("Required Field", "Required value information for File Type.")
	dw_1.setfocus()
	dw_1.setcolumn("file_type")
	return -1
end if

//Start Code Change ----08.09.2011 #V11 maha - removed, not really required
//if isnull(ls_description) or ls_description = '' then
//	Messagebox("Required Field", "Required value information for Description.")
//	dw_1.setfocus()
//	dw_1.setcolumn("description")
//	return -1
//end if

ls_func_type = dw_1.GetItemString(li_row, "function_type") 
ll_facility = dw_1.GetItemnumber(li_row, "facility_id") 
ll_record_id = dw_1.GetItemnumber(li_row, "record_id") 

ldws_1 = dw_1.getitemstatus(li_row, 0, primary!)

if ldws_1 = new! or ldws_1 = newmodified! then
	select max(Dcmnt_id)
	  into :ll_Rtn
	  from document_storage;
	  
	if isnull(ll_Rtn) then ll_Rtn = 0
	ll_Rtn++
	dw_1.setitem(li_row, 'Dcmnt_id', ll_Rtn)
else
	ll_Rtn = dw_1.GetItemnumber(li_row, "Dcmnt_id") 
end if

ldws_file = dw_1.getitemstatus(li_row, 'file_name', primary!)
ls_filepath = is_file_name
if ldws_file = newmodified! or ldws_file = datamodified! then
	if isnull(ls_filepath) or ls_filepath ='' then
		if isnull(ls_doc_name) or ls_doc_name = '' then
			Return -1;
		else
			if pos(ls_doc_name, '\') > 0 then
				ls_filepath = ls_doc_name
			else
				ls_filepath = gs_current_path + '\' + ls_doc_name
			end if
		end if
	else
		li_pos = lastpos(ls_filepath ,'\')
		if li_pos > 0 then
			if mid(ls_filepath , li_pos +1) <> ls_doc_name then
				is_file_name = left(ls_filepath , li_pos) + ls_doc_name
			end if
		end if
	end if
	if not (isnull(ls_filepath) or ls_filepath='') then
		
		if not FileExists( ls_filepath ) then 
			MessageBox("Reminder","The file '" + ls_filepath  +"'does not exist. ")  
			return -1
		end if
	end if
end if

If dw_1.update( ) = 1  THen
	if ldws_file = newmodified! or ldws_file = datamodified! then
		if not (isnull(ls_filepath) or ls_filepath='') then
			inv_image_functions = create pfc_cst_nv_image_functions
			lb_doc = inv_image_functions.of_read_image_file( ls_filepath )
			ll_test_len = lenA(lb_doc)
			//messagebox("length", ll_test_len)
			updateblob document_storage
						  set  Doc_blob = :lb_doc
					 where Dcmnt_id = :ll_Rtn using sqlca;
			
			if sqlca.sqlcode = 0 then
				COMMIT;
				
			else
				ROLLBACK;
				Return -1;
			end if
		end if
	end if	
ELSE
	ROLLBACK;
	Return -1;
End if
	
ib_save = TRUE
close(parent)

end event

