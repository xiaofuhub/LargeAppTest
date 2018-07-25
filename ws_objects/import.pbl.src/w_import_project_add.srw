$PBExportHeader$w_import_project_add.srw
forward
global type w_import_project_add from window
end type
type st_project from statictext within w_import_project_add
end type
type sle_p_name from singlelineedit within w_import_project_add
end type
type cb_ok from commandbutton within w_import_project_add
end type
type cb_cancel from commandbutton within w_import_project_add
end type
end forward

global type w_import_project_add from window
integer width = 1792
integer height = 280
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
st_project st_project
sle_p_name sle_p_name
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_import_project_add w_import_project_add

type variables
long il_project_id
String is_type
String ls_old_project_name
DataStore ids_project
end variables

forward prototypes
public function integer of_create_ds ()
end prototypes

public function integer of_create_ds ();String ls_sql,ls_dwsyntax,ls_err
String ls_import_project_cols,ls_import_project_sql
String ls_col_name
Int i, li_cnt

//Get table import_project's columns name
DataStore lds_project_cols
lds_project_cols = Create DataStore
If gs_dbtype = 'ASA' Then
	ls_sql = "Select t1.column_name col_name from syscolumn t1,systable where t1.table_id = systable.table_id and systable.table_name = 'import_project'"
Else
	ls_sql = "Select t1.name as col_name from syscolumns t1,sysobjects where sysobjects.id = t1.id and sysobjects.name = 'import_project' "
End If
ls_dwsyntax = SQLCA.syntaxfromsql(ls_sql,'', ls_err)
If LenA(ls_err) > 0 Then
	Return -1
End If
lds_project_cols.Create( ls_dwsyntax,ls_err)
If LenA(ls_err) > 0 Then
	Return -2
End If
lds_project_cols.SetTransObject(SQLCA)
lds_project_cols.Retrieve()
If lds_project_cols.RowCount() = 0 Then
	Return -3
End If

If LenA(lds_project_cols.describe('t1_col_name.coltype')) > 2 Then ls_col_name = 't1_col_name'
If LenA(lds_project_cols.describe('col_name.coltype')) > 2 Then ls_col_name = 'col_name'
If LenA(lds_project_cols.describe('syscolumns_col_name.coltype')) > 2 Then ls_col_name = 'syscolumns_col_name'
If LenA(lds_project_cols.describe('syscolumn_col_name.coltype')) > 2 Then ls_col_name = 'syscolumn_col_name'

For i = 1 to lds_project_cols.Rowcount()
	ls_import_project_cols += lds_project_cols.GetItemString(i,ls_col_name) + ','
Next
ls_import_project_cols = MidA(ls_import_project_cols,1,LenA(ls_import_project_cols) - 1)

//Create import_project datastore
ls_import_project_sql = 'Select ' + ls_import_project_cols + ' From import_project'
ls_dwsyntax = SQLCA.syntaxfromsql(ls_import_project_sql,'', ls_err)
If LenA(ls_err) > 0 Then
	Return -4
End If
ids_project.Create(ls_dwsyntax,ls_err)
If LenA(ls_err) > 0 Then
	Return -5
End If
ids_project.SetTransObject(SQLCA)
ids_project.Retrieve()
If ids_project.Rowcount() = 0 Then
	Return -6
End If

Return 1
end function

on w_import_project_add.create
this.st_project=create st_project
this.sle_p_name=create sle_p_name
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.Control[]={this.st_project,&
this.sle_p_name,&
this.cb_ok,&
this.cb_cancel}
end on

on w_import_project_add.destroy
destroy(this.st_project)
destroy(this.sle_p_name)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_import_project_addopen()
// $<arguments>(None)
// $<returns> long
// $<description> For Add/Copy/Rename Project
//////////////////////////////////////////////////////////////////////
// $<Author> 11/21/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////

String ls_parm
ls_parm = Message.stringparm

If Upper(LeftA(ls_parm,3)) = 'ADD' Then
	is_type = 'ADD'
	This.Title = 'Add Project'
ElseIf Upper(LeftA(ls_parm,4)) = 'COPY' Then
	is_type = 'COPY'
	il_project_id = Long(MidA(ls_parm,5,LenA(ls_parm) - 4 ))
	This.Title = 'Copy Project'
	Ids_project = Create DataStore
ElseIf Upper(LeftA(ls_parm,6)) = 'RENAME' Then
	is_type = 'RENAME'
	sle_p_name.text = MidA(ls_parm,7,LenA(ls_parm) - 6 )
	ls_old_project_name = sle_p_name.text
	This.Title = 'Rename Project'
End If


end event

event close;If isvalid(ids_project) Then Destroy ids_project
end event

type st_project from statictext within w_import_project_add
integer x = 37
integer y = 24
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
string text = "Enter project name:"
boolean focusrectangle = false
end type

type sle_p_name from singlelineedit within w_import_project_add
integer x = 46
integer y = 96
integer width = 946
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

type cb_ok from commandbutton within w_import_project_add
integer x = 1051
integer y = 96
integer width = 343
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
boolean default = true
end type

event clicked;Int li_exist
String ls_project_name
Long ll_project_id_new,ll_null
DataStore lds_project
Setnull(ll_null)

//verify data
If sle_p_name.Text = '' Then
	Messagebox('Missing data','Please enter the project name.')
	Return
End If
 
//Forbid duplicate project name
ls_project_name = sle_p_name.text

If ls_old_project_name <> ls_project_name Then
	Select Count(*) into :li_exist from import_project where project_name = :ls_project_name ;
	If li_exist > 0 Then
		sle_p_name.setfocus( )
		Messagebox('Project Name',"This Project Name already exists. Please enter another one.")
		Destroy lds_project
		Return
	End If
End IF

//For rename project
If is_type = 'RENAME' Then
	CloseWithReturn(Parent,sle_p_name.Text)
	Return
End If

//For Add or Copy Project
lds_project = Create DataStore
lds_project.DataObject = 'd_import_project_add'
lds_project.SetTransObject(SQLCA)

If is_type = 'ADD' Then	//Add project
	lds_project.InsertRow(0)
	lds_project.SetItem(1,'project_name',ls_project_name)
	If lds_project.Update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Add Project','Failed to add the project.')
		Destroy lds_project
		Return
	End If
	ll_project_id_new = lds_project.GetItemNumber(1,'project_id')
ElseIf is_type = 'COPY' Then //Copy Project
	//import_project table need add columns when extend Import Project function
	//So use Dynamic Create to Copy Data.
	If of_create_ds() < 0 Then
		Messagebox('Copy Project','Failed to copy the project.')
		Return 
	End If
	ids_project.SetFilter('project_id = '+String(il_project_id))
	ids_project.Filter()
	If ids_project.Rowcount() <> 1 Then 
		Messagebox('Copy Project','Failed to copy the project.')
		Return 		
	End If
	ids_project.RowsCopy(1,1,Primary!,ids_project,2,Primary!)
	ids_project.SetItem(2,'project_id',ll_null)
	ids_project.SetItem(2,'project_name',ls_project_name)
	If ids_project.Update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Copy Project','Failed to copy the project.')
		Destroy lds_project
		Return
	End If
	ll_project_id_new = ids_project.GetItemNumber(2,'project_id')	
End If
If isvalid(lds_project) Then Destroy lds_project
CloseWithReturn(Parent,ll_project_id_new)

end event

type cb_cancel from commandbutton within w_import_project_add
integer x = 1413
integer y = 96
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
boolean cancel = true
end type

event clicked;If is_type = 'RENAME' Then
	CloseWithReturn(Parent,'')
Else
	CloseWithReturn(Parent,0)
End If
end event

