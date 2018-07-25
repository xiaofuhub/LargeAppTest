$PBExportHeader$w_add_folder.srw
$PBExportComments$Create by Jack 11/06/2006
forward
global type w_add_folder from w_response
end type
type dw_addfolder from u_dw_contract within w_add_folder
end type
type cb_cancel from commandbutton within w_add_folder
end type
type cb_ok from commandbutton within w_add_folder
end type
end forward

global type w_add_folder from w_response
integer width = 2441
integer height = 620
string title = "Folder Properties"
boolean controlmenu = false
long backcolor = 33551856
dw_addfolder dw_addfolder
cb_cancel cb_cancel
cb_ok cb_ok
end type
global w_add_folder w_add_folder

type variables
string is_parm,is_folder_name
long il_parent_folder_id,il_category
long il_close  // Add by Jack 05/22/2007

end variables

on w_add_folder.create
int iCurrent
call super::create
this.dw_addfolder=create dw_addfolder
this.cb_cancel=create cb_cancel
this.cb_ok=create cb_ok
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_addfolder
this.Control[iCurrent+2]=this.cb_cancel
this.Control[iCurrent+3]=this.cb_ok
end on

on w_add_folder.destroy
call super::destroy
destroy(this.dw_addfolder)
destroy(this.cb_cancel)
destroy(this.cb_ok)
end on

event open;call super::open;long ll_row,ll_ctx_acp_folder_id = 0,ll_parent_folder_id,ll_category
long ll_find,ll_grade
long ll_folder[]
str_folder lstr_folder
datawindowchild child

dw_addfolder.of_SetTransObject( SQLCA )

lstr_folder = message.powerobjectparm
is_parm = lstr_folder.as_type
ll_category = lstr_folder.al_category
ll_parent_folder_id = lstr_folder.al_folder_id
ll_ctx_acp_folder_id = ll_parent_folder_id
il_category = ll_category

If is_parm = 'Add' Then	
	This.title = This.title + ' - Add'
	ll_row = dw_addfolder.InsertRow( 0 )
	If isnull(ll_parent_folder_id) Or ll_parent_folder_id = 0 Then
		dw_addfolder.modIfy("parent_folder_id.protect = 1")
		dw_addfolder.modIfy("parent_folder_id.background.color = 67108864")
		dw_addfolder.modIfy("category.protect = 0")
		dw_addfolder.modIfy("category.background.color = 16777215")
		setnull(ll_parent_folder_id)
	End If
	If ll_category <> 0 Then
		dw_addfolder.setitem(ll_row,'category',ll_category)			
	End If
	dw_addfolder.setitem(ll_row,'parent_folder_id',ll_parent_folder_id)	
	ll_folder[1] = 0
Else
	This.title = This.title + ' - Edit'
	ll_folder = lstr_folder.al_folder
	dw_addfolder.retrieve(ll_ctx_acp_folder_id)
	il_category = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'category')
	il_parent_folder_id = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'parent_folder_id')
	is_folder_name = dw_addfolder.getitemstring(dw_addfolder.getrow(),'folder_name')
	If isnull(il_parent_folder_id) Then il_parent_folder_id = 0
End If

dw_addfolder.getchild('parent_folder_id',child)
child.settransobject(sqlca)
child.retrieve(ll_category,ll_folder)
ll_row = child.insertrow(1)
setnull(ll_parent_folder_id)
child.setitem(ll_row,'ctx_acp_folder_id',ll_parent_folder_id)
child.setitem(ll_row,'folder_name','')
dw_addfolder.setfocus()

//-------Begin Added by Alfee 09.20.2007--------
//Set readonly to the window
If w_mdi.of_security_access(6800) < 2 Then
	dw_addfolder.Enabled = False
	cb_ok.Enabled = False
End If
//-------End Added------------------------------


end event

event pfc_save;treeviewitem ltvi_item
long ll_Handle,ll_ParentHandle,ll_ctx_acp_folder_id,ll_parent_folder_id,ll_category
string ls_data,ls_folder_name


//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fxi a defect.
dw_addfolder.event pfc_preupdate()
gnv_appeondb.of_startqueue( )
dw_addfolder.update()
w_clause_painter.tab_1.ids_folder.retrieve()
w_clause_painter.tab_1.ids_clause.retrieve()
w_clause_painter.tab_1.tabpage_browse.dw_browse.retrieve()
gnv_appeondb.of_commitqueue( )
//---------------------------- APPEON END ----------------------------

dw_addfolder.accepttext()
		
ll_ctx_acp_folder_id = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'ctx_acp_folder_id')
ll_parent_folder_id = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'parent_folder_id')
ll_category = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'category')
ls_folder_name = dw_addfolder.getitemstring(dw_addfolder.getrow(),'folder_name')
ls_data = string(ll_ctx_acp_folder_id) + '-' + 'F' + '+' + string(ll_category)

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-03-13 By: Jervis
//$<reason> 
w_clause_painter.tab_1.of_update_category(ll_ctx_acp_folder_id,ll_category)
//---------------------------- APPEON END ----------------------------


If is_parm = 'Add' Then
	If ll_category <> il_category Then
		w_clause_painter.tab_1.tabpage_browse.cb_clear.triggerevent(clicked!)
		w_clause_painter.tab_1.tabpage_browse.cb_go.triggerevent(clicked!)
	Else
		w_clause_painter.tab_1.of_create_clause_tree()
	End If
	ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
	w_clause_painter.tab_1.tabpage_browse.tv_clause.selectitem(ll_Handle)	
	w_clause_painter.tab_1.tabpage_browse.tv_clause.Event clicked(ll_Handle)
Else
	If ls_folder_name <> is_folder_name Then	
		ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)	
		w_clause_painter.tab_1.tabpage_browse.tv_clause.getitem(ll_handle, ltvi_item)
		ltvi_item.label = ls_folder_name
		w_clause_painter.tab_1.tabpage_browse.tv_clause.setitem(ll_handle, ltvi_item)
	End If
	If isnull(ll_parent_folder_id) Then ll_parent_folder_id = 0
	//Start Change By Jervis 03/13/2007
	//If ll_parent_folder_id <> il_parent_folder_id  Then
	If ll_parent_folder_id <> il_parent_folder_id or ll_category <> il_category Then
	//End
		If ll_category <> il_category Then
			w_clause_painter.tab_1.tabpage_browse.cb_clear.triggerevent(clicked!)
			w_clause_painter.tab_1.tabpage_browse.cb_go.triggerevent(clicked!)
		Else
			w_clause_painter.tab_1.of_create_clause_tree()
		End If
		ll_Handle = w_clause_painter.tab_1.of_getHandle(ls_data,1)
		w_clause_painter.tab_1.tabpage_browse.tv_clause.selectitem(ll_Handle)
		w_clause_painter.tab_1.tabpage_browse.tv_clause.Event clicked(ll_Handle)		
	End If	
End If
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 05.22.2007 By: Jack
//$<reason> Fix a defect.
/*
If isnull(ll_category) = False And ll_category <> 0 then
	Closewithreturn(w_add_folder,1)
End If
*/
If isnull(ll_category) Or ll_category = 0 then
	Return 0
End If
//---------------------------- APPEON END ----------------------------

Return 1

end event

event closequery;string ls_folder_name
dw_addfolder.accepttext()
ls_folder_name = dw_addfolder.getitemstring(dw_addfolder.getrow(),'folder_name')
If isnull(ls_folder_name) Then ls_folder_name = ''
If ls_folder_name = '' Then
	ib_closestatus = False
	Return 0
Else
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Super::Event closequery()
	*/
	il_close = Super::Event closequery()
	Return il_close
	//---------------------------- APPEON END ----------------------------
End If

end event

event close;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 05.22.2007 By: Jack
//$<reason> Fix a defect.
If il_close = 1 Then
	ib_closestatus = False
	Return 0
Else
	Super::Event close()
End If
//---------------------------- APPEON END ----------------------------

end event

type dw_addfolder from u_dw_contract within w_add_folder
integer y = 24
integer width = 2405
integer height = 380
integer taborder = 40
string dataobject = "d_add_folder"
boolean hscrollbar = true
borderstyle borderstyle = stylebox!
end type

event itemchanged;call super::itemchanged;//long ll_parent_folder_id,ll_folder_id[]
//datawindowchild child
//
//dw_addfolder.accepttext()

//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 03/13/2007 By: Jervis
//$<reason> 
/*
If dwo.name = 'parent_folder_id' Then
	ll_parent_folder_id = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'parent_folder_id')
	If isnull(ll_parent_folder_id) Or ll_parent_folder_id = 0 Then
		If is_parm = 'Add' Then
			dw_addfolder.modIfy("category.protect = 0")
			dw_addfolder.modIfy("category.background.color = 16777215")
		Else
			dw_addfolder.modIfy("category.protect = 1")
			dw_addfolder.modIfy("category.background.color = 67108864")	
		End If			
	Else		
		dw_addfolder.modIfy("category.protect = 1")
		dw_addfolder.modIfy("category.background.color = 67108864")	
	End If
End If
*/
//choose case dwo.name
//	case "category"
//		ll_folder_id[1] = this.GetItemNumber(row,"ctx_acp_folder_id")
//		dw_addfolder.getchild('parent_folder_id',child)
//		child.settransobject(sqlca)
//		child.retrieve(long(data),ll_folder_id)
//		child.insertrow(1)
//		setnull(ll_parent_folder_id)
//		child.setitem(1,'ctx_acp_folder_id',ll_parent_folder_id)
//		child.setitem(1,'folder_name','')
//		this.SetItem(row,"parent_folder_id",ll_parent_folder_id)
//end choose
//---------------------------- APPEON END ----------------------------



end event

event constructor;call super::constructor;//datawindowchild child
//long ll_find

//This.getchild('category',child)
//child.settransobject(sqlca)
//child.retrieve()
//child.insertrow(1)
//child.setitem(1,'lookup_code',-777)
//child.setitem(1,'code','*Add lookup Code*')
This.Event ue_populatedddws()

////--------------------------- APPEON BEGIN ---------------------------
////$<Add> 2007-05-11 By: Wu ZhiJun
////$<reason> Fix a bug
//integer	li_Cycle
//String	ls_Code
//
//DataWindowChild ldwc_Temp
//
//dw_addfolder.GetChild('category',ldwc_Temp)
//
//for li_Cycle = 1 to ldwc_Temp.RowCount()
//	ls_Code = ldwc_Temp.GetItemString(li_Cycle,'code')
//	if IsNull(ls_Code) or ls_Code = '' then
//		ldwc_Temp.DeleteRow(li_Cycle)
//		li_Cycle = li_Cycle - 1
//	end if
//next
////--------------------------- APPEON END -----------------------------
end event

event getfocus;//
end event

event losefocus;//
end event

event pfc_preupdate;long ll_ctx_acp_folder_id

If is_parm = 'Add' Then
	SELECT max(ctx_acp_folder_id) INTO :ll_ctx_acp_folder_id FROM ctx_acp_folder;
	If isnull(ll_ctx_acp_folder_id) Then ll_ctx_acp_folder_id = 0	
	If ll_ctx_acp_folder_id > 0 Then
		ll_ctx_acp_folder_id = ll_ctx_acp_folder_id + 1
	Else
		ll_ctx_acp_folder_id = 1
	End If
	dw_addfolder.setitem(dw_addfolder.getrow(),'ctx_acp_folder_id',ll_ctx_acp_folder_id)
End If
Return 1
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//////////////////////////////////////////////////////////////////////
// $<event>ue_post_itemchangeddw_addfolder()
// $<arguments>
//		string	data		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 04.17.2007 by Jack
//////////////////////////////////////////////////////////////////////
long ll_parent_folder_id,ll_category,ll_folder_id[]
datawindowchild child

dw_addfolder.accepttext()

choose case this.getcolumnname()
	case "category"
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.14.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		ll_folder_id[1] = this.GetItemNumber(this.getrow(),"ctx_acp_folder_id")
		*/
		If is_parm = 'Add' Then	
			ll_folder_id[1] = 0
		Else
			ll_folder_id[1] = this.GetItemNumber(this.getrow(),"ctx_acp_folder_id")
		End If
		//---------------------------- APPEON END ----------------------------
				
		ll_category = this.GetItemNumber(this.getrow(),"category")
		dw_addfolder.getchild('parent_folder_id',child)
		child.settransobject(sqlca)
		child.retrieve(ll_category,ll_folder_id)
		child.insertrow(1)
		setnull(ll_parent_folder_id)
		child.setitem(1,'ctx_acp_folder_id',ll_parent_folder_id)
		child.setitem(1,'folder_name','')
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 05.14.2007 By: Jack
		//$<reason> Fix a defect.
		/*
		this.SetItem(this.getrow(),"parent_folder_id",ll_parent_folder_id)
		*/
		If ll_category <> il_category Then
			this.SetItem(this.getrow(),"parent_folder_id",ll_parent_folder_id)
		End If
		//---------------------------- APPEON END ----------------------------
end choose



end event

type cb_cancel from commandbutton within w_add_folder
integer x = 2075
integer y = 420
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Cancel"
end type

event clicked;Close(Parent)

end event

type cb_ok from commandbutton within w_add_folder
integer x = 1737
integer y = 420
integer width = 334
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&OK"
end type

event clicked;string ls_folder_name
long ll_category

dw_addfolder.accepttext()

//--------------------------- APPEON BEGIN ---------------------------
//$<Add> 2007-05-11 By: Wu ZhiJun
//$<reason> Fix a bug
Powerobject lpo_updatearray[]
Integer		li_rc

If UpperBound(ipo_updateobjects) > 0 Then
	lpo_updatearray = ipo_updateobjects
Else
	lpo_updatearray = Parent.Control
End If

li_rc = of_UpdateChecks(lpo_updatearray)

if li_rc < 0 then return
//--------------------------- APPEON END -----------------------------

ll_category = dw_addfolder.getitemnumber(dw_addfolder.getrow(),'category')
ls_folder_name = dw_addfolder.getitemstring(dw_addfolder.getrow(),'folder_name')

If isnull(ls_folder_name) or ls_folder_name = '' Then
	//messagebox('IntelliSoftGroup','Required value missing for Foler Name on row 1.  Please enter a value.')
	messagebox('IntelliSoftGroup','Required value missing for Folder Name on row 1.  Please enter a value.')
	dw_addfolder.setfocus()
	dw_addfolder.setcolumn('folder_name')
	Return
End If

If isnull(ll_category) or ll_category = 0 Then
	messagebox('IntelliSoftGroup','Required value missing for Category on row 1.  Please enter a value.')
	dw_addfolder.setfocus()
	dw_addfolder.setcolumn('category')
	Return
End If


If dw_addfolder.modIfiedcount() > 0 Then	
	//--------------------------- APPEON BEGIN ---------------------------
	//$<modify> 05.22.2007 By: Jack
	//$<reason> Fix a defect.
	/*
	Parent.Event pfc_save()
	*/
	If Parent.Event pfc_save() = 1 then
		Closewithreturn(w_add_folder,1)
	End If	
	//---------------------------- APPEON END ----------------------------
Else
	Closewithreturn(Parent,0)
End If


end event

