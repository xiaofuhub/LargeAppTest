$PBExportHeader$w_clause_export.srw
forward
global type w_clause_export from w_response
end type
type st_info from statictext within w_clause_export
end type
type cbx_recursive from checkbox within w_clause_export
end type
type cb_cancel from commandbutton within w_clause_export
end type
type cb_export from commandbutton within w_clause_export
end type
type cb_1 from commandbutton within w_clause_export
end type
type st_1 from statictext within w_clause_export
end type
type sle_path from singlelineedit within w_clause_export
end type
end forward

global type w_clause_export from w_response
integer width = 1893
integer height = 544
boolean titlebar = false
boolean controlmenu = false
long backcolor = 33551856
st_info st_info
cbx_recursive cbx_recursive
cb_cancel cb_cancel
cb_export cb_export
cb_1 cb_1
st_1 st_1
sle_path sle_path
end type
global w_clause_export w_clause_export

type variables
str_folder istr_pass

end variables

forward prototypes
public function integer of_export_clause (string as_path, long al_handle, long al_clause_id)
public function integer of_export_folder (string as_path, long al_handle, long al_folder_id, boolean ab_recursive)
public function integer of_export_clause (string as_path, string as_clause_name, long al_clause_id)
end prototypes

public function integer of_export_clause (string as_path, long al_handle, long al_clause_id);string ls_clause_name
blob lb_clause,lb_data
treeviewitem tvi_clause
long ll_data_length,ll_start
integer li_loops,li_counter
string ls_path


//Get Clause Name
if istr_pass.atv_clause.GetItem(al_handle,tvi_clause) = 1 then
	ls_clause_name = tvi_clause.label
end if

Return of_export_clause(as_path,ls_clause_name,al_clause_id)

/* //Modified By Ken.Guo 2010-11-10
SetPointer(HourGlass!)
ls_path = as_path + "\"
gnv_appeondll.of_parsepath(ls_path)

st_info.text = 'Export clause - ' + ls_clause_name + ", please wait..."

//Get Export Path
ls_clause_name = ls_path + ls_clause_name + ".doc"

//Begin - Modified By Ken.Guo 2010-01-15
String ls_file
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause
If lnv_clause.of_download_file( al_clause_id, ls_file) >= 0 Then
	FileCopy(ls_file,ls_clause_name,True)
End If
Destroy lnv_clause
Return 1
*/
/*
//Get Clause blob
if appeongetclienttype() <> 'PB' Then		
	SELECTBLOB image_file INTO :lb_clause
	FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
Else			
	SELECT Datalength(image_file) INTO :ll_data_length
	FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;
			
	If isnull(ll_data_length) Then ll_data_length = 0
			
	If ll_data_length > 8000 Then 
		If Mod(ll_data_length,8000) = 0 Then
			li_loops = ll_data_length/8000 
		Else
			li_loops = (ll_data_length/8000) + 1 
		End If 
	ElseIf ll_data_length > 0 Then 
		li_loops = 1 
	End If 
			
	For li_counter = 1 To li_loops				
		ll_start = (li_counter - 1) * 8000 + 1
		SELECTBLOB substring(image_file,:ll_start,8000) INTO :lb_data
		  FROM ctx_acp_clause WHERE ctx_acp_clause_id = :al_clause_id;			
		lb_clause += lb_data
	Next 
End If
If isnull(lb_clause) Then lb_clause = blob('')
ll_data_length = len(lb_clause)
AppeonWriteFile(ls_clause_name,lb_clause,ll_data_length)
*/
//End - Modified By Ken.Guo 2010-01-15


return 1
end function

public function integer of_export_folder (string as_path, long al_handle, long al_folder_id, boolean ab_recursive);integer li_i,li_count
long ll_clause_id
long ll_folder_id
long ll_handle
string ls_data
string ls_label
string ls_type
integer li_position
string ls_path
treeviewitem tvi_item


//gnv_appeondll.of_parsepath(ls_path)

//Get the first child of itemhandle
ll_handle = istr_pass.atv_clause.finditem( ChildTreeItem!, al_handle)

do while ll_handle > 0
	istr_pass.atv_clause.GetItem(ll_handle,tvi_item)
	ls_data = tvi_item.data
	
	li_position = pos(ls_data,'-')
	ls_type = mid(ls_data,li_position + 1,1)
	if ls_type = 'C' then
		ll_clause_id = long(mid(ls_data,1,li_position - 1))
		of_export_clause(as_path,ll_handle,ll_clause_id)
	elseif ls_type = 'F' then
		if ab_recursive then 
			ls_label = tvi_item.label
			ls_path = as_path + "\" + ls_label
			ll_folder_id = long(mid(ls_data,1,li_position - 1))
			of_export_folder(ls_path,ll_handle,ll_folder_id,ab_recursive)
		end if
	end if

	//Find next Item
	ll_handle = istr_pass.atv_clause.finditem(NextTreeItem!,ll_handle)	
loop





//Export Clause
for li_i = 1 to li_count
	//of_export_clause(as_path,ll_clause_id)
next


//Export sub folder
if ab_recursive then
	
end if

return 1
end function

public function integer of_export_clause (string as_path, string as_clause_name, long al_clause_id);
blob lb_clause,lb_data
treeviewitem tvi_clause
long ll_data_length,ll_start
integer li_loops,li_counter
string ls_path

SetPointer(HourGlass!)
ls_path = as_path + "\"
gnv_appeondll.of_parsepath(ls_path)


st_info.text = 'Export clause - ' + as_clause_name + ", please wait..."

//Get Export Path
as_clause_name = ls_path + as_clause_name + ".doc"

String ls_file
n_cst_clause lnv_clause
lnv_clause = Create n_cst_clause
If lnv_clause.of_download_file( al_clause_id, ls_file) >= 0 Then
	FileCopy(ls_file,as_clause_name,True)
End If
Destroy lnv_clause
Return 1


end function

on w_clause_export.create
int iCurrent
call super::create
this.st_info=create st_info
this.cbx_recursive=create cbx_recursive
this.cb_cancel=create cb_cancel
this.cb_export=create cb_export
this.cb_1=create cb_1
this.st_1=create st_1
this.sle_path=create sle_path
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_info
this.Control[iCurrent+2]=this.cbx_recursive
this.Control[iCurrent+3]=this.cb_cancel
this.Control[iCurrent+4]=this.cb_export
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.sle_path
end on

on w_clause_export.destroy
call super::destroy
destroy(this.st_info)
destroy(this.cbx_recursive)
destroy(this.cb_cancel)
destroy(this.cb_export)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.sle_path)
end on

event open;call super::open;
istr_pass = message.PowerObjectParm

//Default to recursive when root item
if istr_pass.as_type = '' and istr_pass.al_folder_id = 0 then 
	cbx_recursive.enabled = false
	cbx_recursive.checked = true
end if

if istr_pass.as_type = 'C' then
	cbx_recursive.enabled = false
	cbx_recursive.checked = false
end if

//Added By Ken.Guo 2010-11-10.
If Upper(istr_pass.as_flag) = 'DW' Then
	cbx_recursive.visible = False
End If
end event

type st_info from statictext within w_clause_export
integer x = 32
integer y = 272
integer width = 1806
integer height = 104
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 16711680
long backcolor = 33551856
boolean focusrectangle = false
end type

type cbx_recursive from checkbox within w_clause_export
integer x = 32
integer y = 212
integer width = 942
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Recursive export subfolders"
end type

type cb_cancel from commandbutton within w_clause_export
integer x = 1504
integer y = 396
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
end type

event clicked;close(Parent)
end event

type cb_export from commandbutton within w_clause_export
integer x = 1138
integer y = 396
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Start Export"
end type

event clicked;
If Upper(istr_pass.as_flag) = 'TV' Then
	//Expand all
	istr_pass.atv_clause.expandall(istr_pass.al_handle)
	
	SetPointer(HourGlass!)
	if istr_pass.as_type = 'C' then
		of_export_clause(sle_path.text,istr_pass.al_handle,istr_pass.al_clause_id)
	elseif istr_pass.as_type = 'F' or istr_pass.as_type = '' then //'' root item
		of_export_folder(sle_path.text,istr_pass.al_handle,istr_pass.al_folder_id,cbx_recursive.checked)
	end if
Else //Export DW Data.
	Long i,ll_cnt,ll_clause_id
	String ls_clause_name
	ll_cnt = istr_pass.adw_clause.RowCount()

	For i = 1 To ll_cnt
		ll_clause_id = istr_pass.adw_clause.GetItemNumber(i,'ctx_acp_clause_id')
		ls_clause_name = istr_pass.adw_clause.GetItemString(i,'clause_name')
		of_export_clause(sle_path.text,ls_clause_name,ll_clause_id)
	Next
	
End If
	

st_info.text = 'Export Complete.'

SetPointer(Arrow!)
end event

type cb_1 from commandbutton within w_clause_export
integer x = 1504
integer y = 84
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Browse..."
end type

event clicked;string ls_path
ls_path = sle_path.text

GetFolder('Select folder', ls_path) 
sle_path.text = ls_path
end event

type st_1 from statictext within w_clause_export
integer x = 32
integer y = 28
integer width = 969
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please select the path for export caluse:"
boolean focusrectangle = false
end type

type sle_path from singlelineedit within w_clause_export
integer x = 32
integer y = 88
integer width = 1463
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

