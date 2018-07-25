$PBExportHeader$w_priv_view_doc.srw
forward
global type w_priv_view_doc from w_popup
end type
type ole_office from u_office_ocx within w_priv_view_doc
end type
type cb_merge from commandbutton within w_priv_view_doc
end type
type cb_save from commandbutton within w_priv_view_doc
end type
type cb_insertfield from commandbutton within w_priv_view_doc
end type
type cb_close from commandbutton within w_priv_view_doc
end type
end forward

global type w_priv_view_doc from w_popup
integer width = 3685
integer height = 2168
string title = "Privilege Form"
long backcolor = 33551856
boolean center = true
ole_office ole_office
cb_merge cb_merge
cb_save cb_save
cb_insertfield cb_insertfield
cb_close cb_close
end type
global w_priv_view_doc w_priv_view_doc

type variables
string is_DocPath
string is_DocType
string is_ViewDocPath
long il_clinical_area_id
end variables

forward prototypes
public function integer of_insertfield (string as_field)
public function integer of_mergefields ()
end prototypes

public function integer of_insertfield (string as_field);//////////////////////////////////////////////////////////////////////
// $<function> of_insertfield
// $<arguments>
//		string	as_field
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

if not Len(as_Field) > 0 then Return -1

TRY
	if ole_office.Object.Doctype <> 1 then Return -1
	ole_office.Object.ActiveDocument.ActiveWindow.Selection.TypeText("$<" + as_Field + ">$")
	ole_office.Object.ActiveDocument.ActiveWindow.SetFocus()
CATCH(throwable th1)
	MessageBox("Insert", "Failed to insert field.", StopSign!)
	Return -1
END TRY

Return 1
end function

public function integer of_mergefields ();//////////////////////////////////////////////////////////////////////
// $<function> of_mergefields
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.25.2011
//////////////////////////////////////////////////////////////////////

long ll_prac_id
long ll_facility_id
datastore lds_data
gs_search lstr_search
gs_batch_search lstr_search_ret
n_cst_word_utility lnv_word

// Search practitioner
lstr_search.stran_transaction = SQLCA
lstr_search.ls_open_for = "PRIVILEGE"
OpenWithParm(w_extended_search_new , lstr_search)
lstr_search_ret = Message.PowerObjectParm
if IsNull(lstr_search_ret) then Return -1
if not IsValid(lstr_search_ret) then Return -1
if UpperBound(lstr_search_ret.li_prac_id) < 1 then Return -1
ll_prac_id = lstr_search_ret.li_prac_id[1]
ll_facility_id = lstr_search_ret.ll_facility[1]

// Save doucment
if not ole_office.Object.ActiveDocument.Saved then
	if cb_save.Event Clicked() = -1 then Return -1
end if

// Retrieve data
lds_data = Create datastore
lds_data.DataObject = "d_priv_data_source"
lds_data.SetTransObject(SQLCA)
lds_data.Retrieve(ll_facility_id, ll_prac_id)

// Merge data
lnv_word = Create n_cst_word_utility
this.SetRedraw(false)
lnv_word.of_replace_export_word(ole_office.object.activedocument, lds_data)
this.SetRedraw(true)

Destroy lnv_word
Destroy lds_data

Return 1
end function

on w_priv_view_doc.create
int iCurrent
call super::create
this.ole_office=create ole_office
this.cb_merge=create cb_merge
this.cb_save=create cb_save
this.cb_insertfield=create cb_insertfield
this.cb_close=create cb_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.ole_office
this.Control[iCurrent+2]=this.cb_merge
this.Control[iCurrent+3]=this.cb_save
this.Control[iCurrent+4]=this.cb_insertfield
this.Control[iCurrent+5]=this.cb_close
end on

on w_priv_view_doc.destroy
call super::destroy
destroy(this.ole_office)
destroy(this.cb_merge)
destroy(this.cb_save)
destroy(this.cb_insertfield)
destroy(this.cb_close)
end on

event close;call super::close;ole_office.of_Close()
end event

event pfc_preopen;call super::pfc_preopen;long ll_Pos
string ls_Data[]
n_cst_string lnv_string

// Get document information
lnv_string.of_ParseToArray(Message.StringParm, "|", ls_Data)
il_clinical_area_id = Long(ls_Data[1])
is_DocPath = ls_Data[2]
ll_Pos = LastPos(ls_Data[2], '.')
is_DocType = Mid(ls_Data[2], ll_Pos + 1, 256)

ll_Pos = LastPos(ls_Data[2], '\')
if ll_Pos < 1 then ll_Pos = LastPos(ls_Data[2], '/')
is_ViewDocPath = Left(ls_Data[2], ll_Pos)

// Do some actions
if Upper(is_DocType) = "XLS" or Upper(is_DocType) = "XLSX" then
	ole_office.Height = 2028
	cb_insertfield.Hide()
	cb_save.Hide()
	cb_merge.Hide()
	cb_close.Hide()	
end if

// Resize settings
this.of_SetResize(true)
inv_resize.of_SetOrigSize(this.WorkspaceWidth(), this.WorkspaceHeight())
inv_resize.of_SetMinSize(this.WorkspaceWidth(), this.WorkspaceHeight())
//
inv_resize.of_Register(ole_office, inv_resize.SCALERIGHTBOTTOM)
inv_resize.of_Register(cb_merge, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_insertfield, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_save, inv_resize.FIXEDRIGHTBOTTOM)
inv_resize.of_Register(cb_close, inv_resize.FIXEDRIGHTBOTTOM)
end event

event open;call super::open;// Open document
ole_office.of_Open(is_DocPath, true)
end event

type ole_office from u_office_ocx within w_priv_view_doc
integer x = 18
integer y = 16
integer width = 3584
integer height = 1896
integer taborder = 20
borderstyle borderstyle = stylebox!
string binarykey = "w_priv_view_doc.win"
end type

event constructor;call super::constructor;this.object.menubar(false)
end event

type cb_merge from commandbutton within w_priv_view_doc
integer x = 2103
integer y = 1932
integer width = 361
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Merge Field"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

if this.Text = "&Merge Field" then
	if of_MergeFields() = 1 then
		this.Text = "&Unmerge Field"
		cb_save.Enabled = false
		cb_insertfield.Enabled = false
	end if
else
	this.Text = "&Merge Field"
	cb_save.Enabled = true
	cb_insertfield.Enabled = true
	Parent.SetRedraw(false)
	ole_office.of_Close()
	ole_office.of_Open(is_DocPath, true)
	Parent.SetRedraw(true)
end if
end event

type cb_save from commandbutton within w_priv_view_doc
integer x = 2834
integer y = 1932
integer width = 347
integer height = 92
integer taborder = 30
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
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

blob lblb_Data
n_cst_dm_utils lnv_file
constant long wdFormatDocument97_2003 = 0
constant long wdFormatDocumentDefault = 16

// Save contents as a new document
FileDelete(is_DocPath)
TRY
	if Upper(is_DocType) = "DOCX" then
		ole_office.object.ActiveDocument.SaveAs(is_DocPath, wdFormatDocumentDefault)
	else
		ole_office.object.ActiveDocument.SaveAs(is_DocPath, wdFormatDocument97_2003)
	end if
CATCH(throwable th1)
	MessageBox("Save", "Failed to save as file.", StopSign!)
	Return -1
END TRY

// Read file contents
if lnv_file.of_ReadBlob(is_DocPath, lblb_Data) <> 1 then
	MessageBox("Save", "Failed to read file.", StopSign!)
	Return -1
end if

// Upload file contents to database
UPDATEBLOB priv_ca_form SET form_data = :lblb_data WHERE clinical_area_id = :il_clinical_area_id;
if SQLCA.SQLCode = 0 then
	COMMIT;
else
	ROLLBACK;
	MessageBox("Save", "Failed to save privilege form.~r~n" + SQLCA.SQLErrText, StopSign!)
	Return -1
end if

Return 1
end event

type cb_insertfield from commandbutton within w_priv_view_doc
integer x = 2478
integer y = 1932
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Insert Field"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> long
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.24.2011
//////////////////////////////////////////////////////////////////////

OpenWithParm(w_priv_merge_fields, Parent)
end event

type cb_close from commandbutton within w_priv_view_doc
integer x = 3255
integer y = 1932
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;//////////////////////////////////////////////////////////////////////
// $<event> clicked
// $<arguments>
// $<returns> integer
// $<description> N/A
//////////////////////////////////////////////////////////////////////
// Add by Appeon: Evan 02.23.2011
//////////////////////////////////////////////////////////////////////

Close(Parent)
end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Dw_priv_view_doc.bin 
2800000e00e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe000000060000000000000000000000010000000100000000000010000000000200000001fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffefffffffe0000000400000005fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffff000000010000000000000000000000000000000000000000000000000000000009bf45d001d131ef00000003000005000000000000500003004f0042005800430054005300450052004d0041000000000000000000000000000000000000000000000000000000000000000000000000000000000102001affffffff00000002ffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000025400000000004200500043004f00530058004f00540041005200450047000000000000000000000000000000000000000000000000000000000000000000000000000000000001001affffffffffffffff00000003c9bc4e0f4a3c4248a763498a04f417d30000000009bf45d001d131ef09bf45d001d131ef0000000000000000000000000054004e004f004b0066004f0069006600650063007400430053006c006d0074000000000000000000000000000000000000000000000000000000000000000001020022ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000a0000025400000000000000010000000200000003000000040000000500000006000000070000000800000009fffffffe0000000b0000000c0000000d0000000e0000000f00000010000000110000001200000013fffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff
26ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff1234abcd00005107000030fd00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b4000000010000000000000000000000000000000000000000000000010000000000000000000000010000000000800000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001234abcd00005107000030fd00dbc29d800000058000000800ffffff00000000010100010000000000000022006e004900650074006c006c005300690066006f00200074007200470075006f005000700037000000300031004500370043003800330037003200330045004500410045004100450036004200320033003800380038004100330041003700330032003300450041004200430041003100380046000000350000000000220000004900000074006e006c00650069006c006f00530074006600470020006f00720070007500000050003400430043003500300041004200370035004300380030003700350046004200360041003800360036003100460031004500360037003300350045003000300044003500340031003700440030003600000001000000000000000000000001000000010000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff0000ffff000000000000000100dbc29d000000000000000000000000000000000000000000000000000000000000000000000000000000000000000700f6e6d300e3ba9200000003000000000000000000000000000000000000000100000000000004e400000001000000010000000100000000000000b4000000b400000001000000000000000000000000000000000000000000000001000000000000000000000001000000000080000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Dw_priv_view_doc.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
