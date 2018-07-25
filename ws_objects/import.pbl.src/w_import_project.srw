$PBExportHeader$w_import_project.srw
forward
global type w_import_project from window
end type
type cb_1 from commandbutton within w_import_project
end type
type cb_rename from commandbutton within w_import_project
end type
type dw_projectlist from datawindow within w_import_project
end type
type cb_close from commandbutton within w_import_project
end type
type cb_copy from commandbutton within w_import_project
end type
type cb_del from commandbutton within w_import_project
end type
type cb_new from commandbutton within w_import_project
end type
type tab_project from tab within w_import_project
end type
type tabpage_cred from userobject within tab_project
end type
type dw_cred from u_dw_contract within tabpage_cred
end type
type dw_cred_list from datawindow within tabpage_cred
end type
type cb_save_cred from commandbutton within tabpage_cred
end type
type tabpage_cred from userobject within tab_project
dw_cred dw_cred
dw_cred_list dw_cred_list
cb_save_cred cb_save_cred
end type
type tabpage_ctx from userobject within tab_project
end type
type dw_ctx from u_dw_contract within tabpage_ctx
end type
type dw_ctx_list from datawindow within tabpage_ctx
end type
type cb_save_ctx from commandbutton within tabpage_ctx
end type
type tabpage_ctx from userobject within tab_project
dw_ctx dw_ctx
dw_ctx_list dw_ctx_list
cb_save_ctx cb_save_ctx
end type
type tab_project from tab within w_import_project
tabpage_cred tabpage_cred
tabpage_ctx tabpage_ctx
end type
type gb_settings from groupbox within w_import_project
end type
type gb_1 from groupbox within w_import_project
end type
end forward

global type w_import_project from window
integer width = 3173
integer height = 1848
boolean titlebar = true
string title = "Import Project"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 33551856
string icon = "AppIcon!"
boolean center = true
event ue_save ( )
cb_1 cb_1
cb_rename cb_rename
dw_projectlist dw_projectlist
cb_close cb_close
cb_copy cb_copy
cb_del cb_del
cb_new cb_new
tab_project tab_project
gb_settings gb_settings
gb_1 gb_1
end type
global w_import_project w_import_project

type variables
DataWindowChild idwc_project_list
long il_project_id
Datawindow idw_cred,idw_ctx
String gs_text
Boolean ib_changed_project
end variables

forward prototypes
public subroutine of_refresh_project (long al_project_id)
public function integer of_save ()
public function integer of_retrieve_data (integer ai_flag, integer ai_row)
public function boolean of_ismodified ()
public function integer of_focuschanging ()
end prototypes

public subroutine of_refresh_project (long al_project_id);//////////////////////////////////////////////////////////////////////
// $<function>w_import_project_newof_refresh_data()
// $<arguments>
//		value	long	al_project_id	: Set row to this project 
// $<returns> (none)
// $<description> Refresh data
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
Long ll_null
Setnull(ll_null)
idwc_project_list.Retrieve()
 
If idwc_project_list.Rowcount() > 0 Then
	If al_project_id	= 0 Then
		//Initialize
		dw_projectlist.SetItem(1,'project_id',idwc_project_list.GetItemNumber(1,'project_id') )
	Else
		//After Add or Copy project name
		dw_projectlist.SetItem(1,'project_id',al_project_id )
	End If
	dw_projectlist.Trigger Event ItemChanged(1,dw_projectlist.object.project_id ,string(dw_projectlist.GetItemNumber(1,'project_id')))
Else
	il_project_id = 0
	dw_projectlist.SetItem(1,'project_id',ll_null)
	idw_cred.reset()
	idw_ctx.reset()
End If


end subroutine

public function integer of_save ();Boolean lb_project_name_modified
idw_cred.AcceptText()
idw_ctx.AcceptText()


//Whether project name has been modified
If idw_cred.Describe('project_name.ColType') <> '!' Then //whether exist
	If idw_cred.getitemstatus(1,'project_name',primary!) = datamodified! Then
		lb_project_name_modified = True
	End If
End If
If idw_ctx.Describe('project_name.ColType') <> '!' Then
	If idw_ctx.getitemstatus(1,'project_name',primary!) = datamodified! Then
		lb_project_name_modified = True
	End If
End If

//Save data
If Tab_project.Selectedtab = 1 Then
	//For IntelliCred
	If idw_cred.Update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Save','Failed to Save it.',StopSign!)
		Return -1
	End If

Elseif Tab_project.Selectedtab = 2 Then
	//For IntelliContract
	If idw_ctx.Update() = 1 Then
		Commit;
	Else
		Rollback;
		Messagebox('Save','Failed to Save it.',StopSign!)	
		Return -1
	End If
End If

//Refresh project name list
If lb_project_name_modified Then
	idwc_project_list.Retrieve()
	dw_projectlist.SetItem(1,'project_id',il_project_id )
End If

Return 1
end function

public function integer of_retrieve_data (integer ai_flag, integer ai_row);//////////////////////////////////////////////////////////////////////
// $<function>w_import_project_newof_retrieve_data()
// $<arguments>
//		value	integer	ai_flag  --1: From Intellicred tabpage; 2: From Contract tabpage 		
//		value	integer	ai_lb_index	--Listbox index	
// $<returns> (Integer) -1: No matched name ; -2 No Data or have redundant data ; 1 Success.
// $<description> Retrieve data when selected changed in Listbox 
//////////////////////////////////////////////////////////////////////
// $<add> 11/20/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
String ls_table
int li_count
Datawindowchild ldwc_Child
Datawindowchild ldwc_def_parent_id,ldwc_def_verif_id  //Appointment Status 

idw_cred.SetRedraw(False)
idw_ctx.SetRedraw(False)
Choose Case ai_flag
	Case 1 //IntelliCred
		ls_table = Upper(tab_project.tabpage_cred.dw_cred_list.GetItemString(ai_row,'table_name'))
		Choose Case ls_table
			Case Upper('Appointment Status')
				idw_cred.DataObject = 'd_import_project_appn_status_edit'
				idw_cred.SetTransObject(SQLCA)
				idw_cred.GetChild("def_parent_id", ldwc_def_parent_id)
				idw_cred.GetChild("def_verif_id", ldwc_def_verif_id)
				ldwc_def_parent_id.SetTransObject(SQLCA)
				ldwc_def_parent_id.Retrieve(gs_user_id)
				ldwc_def_parent_id.RowsCopy(1, ldwc_def_parent_id.RowCount(), Primary!, ldwc_def_verif_id, 1, Primary!)
				idw_cred.Retrieve(il_project_id)
			Case else
				idw_cred.DataObject = ''
		End Choose
		idw_cred.Dynamic of_set_ib_retrieved_dddw(False)
		idw_cred.Dynamic Trigger Event ue_populatedddws()
	Case 2 //IntelliContract
		ls_table = Upper(tab_project.tabpage_ctx.dw_ctx_list.GetItemString(ai_row,'table_name'))
		Choose Case ls_table
			Case Upper('Contract Basic Information')
				idw_ctx.DataObject = 'd_import_project_ctx_basic_edit'								
				idw_ctx.SetTransObject(SQLCA)
				idw_ctx.Retrieve(il_project_id)								
			Case Upper('Contract Contacts')	
				idw_ctx.DataObject = 'd_import_project_ctxcta_edit'
				idw_ctx.SetTransObject(SQLCA)
				idw_ctx.Retrieve(il_project_id)
			Case Upper('Contacts')
				idw_ctx.DataObject = 'd_import_project_contact_edit'
				idw_ctx.SetTransObject(SQLCA)
				idw_ctx.Retrieve(il_project_id)	
			Case Upper('Contract Products')
				idw_ctx.DataObject = 'd_import_project_ctxprd_edit'
				idw_ctx.SetTransObject(SQLCA)
				idw_ctx.Retrieve(il_project_id)				
			Case Upper('Contract Fee Schdules')
				idw_ctx.DataObject = ''
				idw_ctx.SetTransObject(SQLCA)
				idw_ctx.Retrieve(il_project_id)
			Case Else
				idw_ctx.DataObject = ''
		End Choose
		idw_ctx.Dynamic of_set_ib_retrieved_dddw(False)
		idw_ctx.Dynamic Trigger Event ue_populatedddws()
		
		// Not allow user to add company
		if ls_table = Upper('Contract Basic Information') then
			idw_ctx.GetChild("ctx_app_facility", ldwc_Child)
			ldwc_Child.SetTransObject(SQLCA)
			ldwc_Child.Retrieve()
			ldwc_Child.DeleteRow(1)
			ldwc_Child.DeleteRow(1)
			ldwc_Child.InsertRow(1)
		end if
End Choose

idw_cred.SetRedraw(True)
idw_ctx.SetRedraw(True)
If idw_cred.RowCount() <> 1 Or idw_ctx.RowCount() <> 1 Then
	Return -2
End If
If idw_cred.DataObject = '' Or idw_ctx.DataObject = '' Then
	Return -1
End If
Return 1
end function

public function boolean of_ismodified ();idw_cred.AcceptText()
idw_ctx.AcceptText()

If (idw_cred.Modifiedcount() + idw_cred.Deletedcount()) > 0 or &
	(idw_ctx.Modifiedcount() + idw_ctx.Deletedcount()) > 0 Then
	Return True
Else
	Return False
End if
end function

public function integer of_focuschanging ();int li_ret
If of_ismodified() Then
	li_ret = Messagebox('Save','You have modified some data. Do you want to save it?',question!,yesnocancel!)
	If li_ret = 1 Then
		If of_save() > 0 Then 
			Return 0 //Allow Change focus
		Else
			Return 1 //Forbid Change focus
		End If
	ElseIf li_ret = 2 Then
		Return 0 //Allow Change focus
	ElseIf li_ret = 3 Then
		Return 1 //Forbid Change focus
	End If
End If
Return 0
end function

on w_import_project.create
this.cb_1=create cb_1
this.cb_rename=create cb_rename
this.dw_projectlist=create dw_projectlist
this.cb_close=create cb_close
this.cb_copy=create cb_copy
this.cb_del=create cb_del
this.cb_new=create cb_new
this.tab_project=create tab_project
this.gb_settings=create gb_settings
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.cb_rename,&
this.dw_projectlist,&
this.cb_close,&
this.cb_copy,&
this.cb_del,&
this.cb_new,&
this.tab_project,&
this.gb_settings,&
this.gb_1}
end on

on w_import_project.destroy
destroy(this.cb_1)
destroy(this.cb_rename)
destroy(this.dw_projectlist)
destroy(this.cb_close)
destroy(this.cb_copy)
destroy(this.cb_del)
destroy(this.cb_new)
destroy(this.tab_project)
destroy(this.gb_settings)
destroy(this.gb_1)
end on

event open;//////////////////////////////////////////////////////////////////////
// $<event>w_import_project_new
// $<arguments>(None)
// $<returns> long
// $<description> Create import project window that set default value
//////////////////////////////////////////////////////////////////////
// $<Author> 11/20/2007 by Ken.Guo
//////////////////////////////////////////////////////////////////////
long ll_project_id

ll_project_id = Message.DoubleParm

idw_cred = tab_project.tabpage_cred.dw_cred
idw_ctx = tab_project.tabpage_ctx.dw_ctx
of_refresh_project(0)

// Locate specific project
if ll_project_id > 0 then
	dw_projectlist.SetItem(1, "project_id", ll_project_id)
	dw_projectlist.Event ItemChanged(1, dw_projectlist.object.project_id, String(ll_project_id))
end if

//BEGIN---Add by Evan 09/18/2008
// Hide tabpage_cred page if not a IntelliCred/App module
if of_get_app_setting("set_9", "I") = 4 then
	tab_project.Post SelectTab(2)
	tab_project.tabpage_cred.Hide()
end if

// Hide tabpage_ctx page if Contract module is off
if of_get_app_setting("set_cont", "I") = 0 then
	tab_project.tabpage_ctx.Hide()
end if
//END---Add by Evan 09/18/2008
end event

event closequery;int li_ret
If of_ismodified() Then
	li_ret = Messagebox('Save','You have modified some data. Do you want to save it?',question!,yesnocancel!)
	If li_ret = 1 Then
		If of_save() > 0 Then 
			Return 0 //Allow Close
		Else
			Return 1 //Forbid Close
		End If
	ElseIf li_ret = 2 Then
		Return 0
	ElseIf li_ret = 3 Then
		Return 1
	End If
End If
Return 0
end event

event close;If Not ib_changed_project Then
	CloseWithReturn(This,'nochanged!')
Else
	CloseWithReturn(This,'datachanged!')
End If
end event

type cb_1 from commandbutton within w_import_project
integer x = 2341
integer y = 72
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;of_save()
end event

type cb_rename from commandbutton within w_import_project
integer x = 1943
integer y = 72
integer width = 393
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Rename Project"
end type

event clicked;String ls_project_name_old,ls_project_name_new

If il_project_id = 0 or isnull(il_project_id) or idwc_project_list.GetRow() = 0 Then Return

ls_project_name_old = idwc_project_list.GetItemString(idwc_project_list.GetRow(),'project_name')
OpenWithParm(w_import_project_add,'RENAME'+ls_project_name_old)
ls_project_name_new = Message.StringParm

If (ls_project_name_old = ls_project_name_new) or ls_project_name_new = '' Then Return

//Update project name list
idwc_project_list.SetItem(idwc_project_list.GetRow(),'project_name',ls_project_name_new)
If idwc_project_list.update() = 1 Then
	Commit;
Else
	Rollback;
	Messagebox('Rename Project','Failed to rename project.')
End If
//Refresh list
dw_projectlist.SetItem(1,'project_id',il_project_id)
ib_changed_project = True

end event

type dw_projectlist from datawindow within w_import_project
integer x = 27
integer y = 68
integer width = 741
integer height = 84
integer taborder = 10
string dataobject = "d_import_project_list"
boolean border = false
boolean livescroll = true
end type

event constructor;dw_projectlist.InsertRow(0)
dw_projectlist.GetChild('project_id',idwc_project_list)
idwc_project_list.SetTransObject(SQLCA)


end event

event itemchanged;//Save it before changed

//Change Project
il_project_id = Long(data)
Tab_project.Tabpage_cred.dw_cred_list.Trigger Event RowFocusChanged(1)
Tab_project.Tabpage_ctx.dw_ctx_list.Trigger Event RowFocusChanged(1)

end event

event clicked;
gs_text = This.GetText()
end event

type cb_close from commandbutton within w_import_project
integer x = 2729
integer y = 72
integer width = 384
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Close"
boolean cancel = true
end type

event clicked;close(Parent)
end event

type cb_copy from commandbutton within w_import_project
integer x = 1563
integer y = 72
integer width = 375
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "Copy &Project"
end type

event clicked;Long ll_project_id
If il_project_id = 0 or isnull(il_project_id) Then
	Messagebox('Copy Project','Please choose a project first.')
	Return
End If

OpenWithParm(w_import_project_add,'COPY'+string(il_project_id))
ll_project_id = Message.DoubleParm
If ll_project_id = 0 Then Return
Of_refresh_project(ll_project_id)
ib_changed_project = True
end event

type cb_del from commandbutton within w_import_project
integer x = 1170
integer y = 72
integer width = 384
integer height = 84
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Delete Project"
end type

event clicked;Int li_ret
If il_project_id = 0 or isnull(il_project_id) Then Return 
li_ret = Messagebox('Delete Project','Are you sure you want to delete the current project?',question!,yesno!,2)
If li_ret = 1 Then
	//Delete Project
	Delete from import_project where project_id = :il_project_id ;
	If sqlca.sqlcode = 0 Then
		Commit;
	Else
		Rollback;
		Messagebox('Delete Project','Failed to delete the current project.')
	End If
	of_refresh_project(0)
ElseIf li_ret = 2 Then
	Return
End If
ib_changed_project = True	

end event

type cb_new from commandbutton within w_import_project
integer x = 782
integer y = 72
integer width = 384
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&New Project"
end type

event clicked;Long ll_project_id
OpenWithParm(w_import_project_add,'ADD')
ll_project_id = Message.DoubleParm
If ll_project_id = 0 Then Return
Of_refresh_project(ll_project_id)
ib_changed_project = True
end event

type tab_project from tab within w_import_project
integer x = 41
integer y = 268
integer width = 3063
integer height = 1440
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long backcolor = 33551856
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_cred tabpage_cred
tabpage_ctx tabpage_ctx
end type

on tab_project.create
this.tabpage_cred=create tabpage_cred
this.tabpage_ctx=create tabpage_ctx
this.Control[]={this.tabpage_cred,&
this.tabpage_ctx}
end on

on tab_project.destroy
destroy(this.tabpage_cred)
destroy(this.tabpage_ctx)
end on

event selectionchanging;int li_ret
If of_ismodified() Then
	li_ret = Messagebox('Save','You must save data before you make any other change. Do you want to save it?',question!,yesno!)
	If li_ret = 1 Then
		If of_save() > 0 Then 
			Return 0 //Allow
		Else
			Return 1 //Forbid
		End If
	ElseIf li_ret = 2 Then
		Return 1
	End If
End If
end event

type tabpage_cred from userobject within tab_project
integer x = 18
integer y = 100
integer width = 3026
integer height = 1324
long backcolor = 33551856
string text = "IntelliCred/App"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_cred dw_cred
dw_cred_list dw_cred_list
cb_save_cred cb_save_cred
end type

on tabpage_cred.create
this.dw_cred=create dw_cred
this.dw_cred_list=create dw_cred_list
this.cb_save_cred=create cb_save_cred
this.Control[]={this.dw_cred,&
this.dw_cred_list,&
this.cb_save_cred}
end on

on tabpage_cred.destroy
destroy(this.dw_cred)
destroy(this.dw_cred_list)
destroy(this.cb_save_cred)
end on

type dw_cred from u_dw_contract within tabpage_cred
integer x = 718
integer y = 52
integer width = 2281
integer height = 1220
integer taborder = 21
end type

event dropdown;//Override Ancestor Script
end event

event getfocus;//Override Ancestor Script
end event

event losefocus;//Override Ancestor Script
end event

event dberror;//
end event

event rbuttonup;//overwrite
end event

type dw_cred_list from datawindow within tabpage_cred
integer x = 23
integer y = 52
integer width = 677
integer height = 1220
integer taborder = 20
string title = "none"
string dataobject = "d_import_project_cred_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If This.Rowcount() = 0 Then Return
This.SelectRow(0,False)
This.SelectRow(Currentrow, True)
of_retrieve_data(1,Currentrow)
This.SetRow(Currentrow)

end event

event constructor;This.SelectRow(0,False)
This.SelectRow(GetRow(), True)
end event

event rowfocuschanging;Return of_focuschanging()

end event

type cb_save_cred from commandbutton within tabpage_cred
boolean visible = false
integer x = 2304
integer y = 1212
integer width = 343
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

event clicked;of_save()
end event

type tabpage_ctx from userobject within tab_project
integer x = 18
integer y = 100
integer width = 3026
integer height = 1324
long backcolor = 33551856
string text = "IntelliContract"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_ctx dw_ctx
dw_ctx_list dw_ctx_list
cb_save_ctx cb_save_ctx
end type

on tabpage_ctx.create
this.dw_ctx=create dw_ctx
this.dw_ctx_list=create dw_ctx_list
this.cb_save_ctx=create cb_save_ctx
this.Control[]={this.dw_ctx,&
this.dw_ctx_list,&
this.cb_save_ctx}
end on

on tabpage_ctx.destroy
destroy(this.dw_ctx)
destroy(this.dw_ctx_list)
destroy(this.cb_save_ctx)
end on

type dw_ctx from u_dw_contract within tabpage_ctx
integer x = 718
integer y = 52
integer width = 2281
integer height = 1220
integer taborder = 31
end type

event dropdown;//Override Ancestor Script
end event

event getfocus;//Override Ancestor Script
end event

event losefocus;//Override Ancestor Script
end event

event buttonclicked;call super::buttonclicked;String ls_data
Long ll_pos,ll_ctx_id

If dwo.name = 'b_ctx_search' Then
	Open(w_rpt_contract_search)
	ls_data = Message.StringParm
	If ls_data = '' or isnull(ls_data) Then Return
	ll_pos = PosA(ls_data,'|') 
	If ll_pos > 0 Then //Selected multi-rcontract
		Messagebox('Warning','It is unsupported to select multiple contracts. Please select one contract at a time.')
		Return
	Else
		ll_pos = PosA(ls_data,'~t')
		If ll_pos > 0 Then
			ll_ctx_id = Long(MidA(ls_data,1,ll_pos - 1) )
			This.SetItem(1,'ctx_id',ll_ctx_id)
		Else
		End If
	End If
End If

end event

event dberror;//
end event

event rbuttonup;//overwrite
end event

type dw_ctx_list from datawindow within tabpage_ctx
integer x = 23
integer y = 52
integer width = 677
integer height = 1220
integer taborder = 20
string title = "none"
string dataobject = "d_import_project_ctx_list"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;If This.Rowcount() = 0 Then Return
This.SelectRow(0,False)
This.SelectRow(Currentrow, True)
of_retrieve_data(2,currentrow)
This.SetRow(Currentrow)

end event

event constructor;This.SelectRow(0,False)
This.SelectRow(GetRow(), True)
end event

event rowfocuschanging;Return of_focuschanging()

end event

type cb_save_ctx from commandbutton within tabpage_ctx
boolean visible = false
integer x = 2304
integer y = 1212
integer width = 343
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Save"
end type

event clicked;of_save()
end event

type gb_settings from groupbox within w_import_project
integer x = 14
integer y = 204
integer width = 3131
integer height = 1536
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Default Value Settings"
end type

type gb_1 from groupbox within w_import_project
integer x = 9
integer y = 8
integer width = 3136
integer height = 188
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Select Project"
end type

