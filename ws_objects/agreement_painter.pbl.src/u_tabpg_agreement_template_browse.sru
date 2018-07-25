$PBExportHeader$u_tabpg_agreement_template_browse.sru
forward
global type u_tabpg_agreement_template_browse from u_tabpg
end type
type st_1 from u_st_splitbar within u_tabpg_agreement_template_browse
end type
type tv_1 from u_tvs within u_tabpg_agreement_template_browse
end type
type cb_clear from commandbutton within u_tabpg_agreement_template_browse
end type
type cb_go from commandbutton within u_tabpg_agreement_template_browse
end type
type dw_browse from u_dw_contract within u_tabpg_agreement_template_browse
end type
type dw_filter from u_dw_contract within u_tabpg_agreement_template_browse
end type
type gb_1 from groupbox within u_tabpg_agreement_template_browse
end type
type cb_select from commandbutton within u_tabpg_agreement_template_browse
end type
type ds_tree from n_ds within u_tabpg_agreement_template_browse
end type
end forward

global type u_tabpg_agreement_template_browse from u_tabpg
integer width = 4023
integer height = 1968
long backcolor = 33551856
string text = "Browse"
string picturename = "Browse!"
st_1 st_1
tv_1 tv_1
cb_clear cb_clear
cb_go cb_go
dw_browse dw_browse
dw_filter dw_filter
gb_1 gb_1
cb_select cb_select
ds_tree ds_tree
end type
global u_tabpg_agreement_template_browse u_tabpg_agreement_template_browse

type variables
string is_datasource
string is_filter
boolean ib_fulltextsearch  //added by alfee at 03.07.2007

w_agreement_template_painter iw_atp

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03-04-2007 By: Ken.Guo
n_cst_right inv_right
//---------------------------- APPEON END ----------------------------

end variables

forward prototypes
public function string of_generate_filter ()
public function integer of_build_tree ()
public function integer of_find_tvitem (long al_parent_data, long al_son_data)
end prototypes

public function string of_generate_filter ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_atp_browseof_generate_filter()
// $<arguments>(None)
// $<returns> string
// $<description>Generate a filter string of template records
//////////////////////////////////////////////////////////////////////
// $<add> 11.07.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////

string ls_filter,ls_tmp,ls_reviewby,ls_template, ls_search_text = " ctx_acp_template_id In ("
long ll_category,ll_reviewstatus, k, ll_template_id,li_fulltext
date ld_reviewdate

dw_filter.accepttext()
ll_category = dw_filter.getitemnumber(1,"category")
ls_template = dw_filter.getitemstring(1,"template")
ls_reviewby = dw_filter.getitemstring(1,"reviewed_by")
ld_reviewdate = dw_filter.getitemdate(1,"date_reviewed")
ll_reviewstatus = dw_filter.getitemnumber(1,"reviewed_status")
ib_fulltextsearch = false //added by alfee at 03.07.2007

if not isnull(ll_category) then 
	ls_filter += "and category = " + string(ll_category) + " "
end if
if len(trim(ls_template)) > 0 then 
	if gs_dbtype = "SQL" and gnv_data.of_getitem('icred_settings' ,'set_48' , False ) = '1' then
		
		//Added By Ken.Guo 2011-01-14. Check the FT first.
		Select  (
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_template'),'template_name','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_template'),'description','IsFulltextIndexed' ) 
		+ 
		COLUMNPROPERTY (OBJECT_ID('ctx_acp_template'),'image_file','IsFulltextIndexed' ) 
		) 
		Into :li_fulltext From ids;		
		
		If isnull(li_fulltext) Then li_fulltext = 0
		If li_fulltext <> 3 Then
			If Messagebox('Template Filter',"The Full-Text Catalog hasn't been created for the templates yet. Do you want to create it now?", Question!,YesNo!) = 1 Then
				IF Not Isvalid(gnv_logservice) THEN gnv_logservice = Create n_logservice
				//---------Begin Modified by (Appeon)Eugene 06.29.2013 for V141 ISG-CLX--------				
				  /*
					n_cst_update_sql lnv_sql
					lnv_sql = Create n_cst_update_sql						
				  */
				n_cst_update_sql_clx lnv_sql
				lnv_sql = Create n_cst_update_sql_clx	
				//---------End Modfiied ------------------------------------------------------------------
				lnv_sql.of_release_fulltext( )			
				Destroy lnv_sql
			End If
		End If		
		
		
		//Full Text Search;
		ib_fulltextsearch = true //added by alfee at 03.07.2007
		if iw_atp.ids_search_template_text.retrieve('"' + ls_template + '"') > 0 then
			For k = 1 To iw_atp.ids_search_template_text.rowcount()
				ll_template_id = iw_atp.ids_search_template_text.getitemnumber(k,'ctx_acp_template_id')
				ls_search_text = ls_search_text + string(ll_template_id) + ","
			Next
			ls_search_text = mid(ls_search_text,1,len(ls_search_text) - 1) + ")"
		Else
			ls_search_text = ls_search_text + "0)"
		End If					
		ls_filter += "and " + ls_search_text		
	else
		ls_filter += "and pos(lower(template_name), '" + lower(ls_template) + "') > 0 " 
	end if
end if

if len(trim(ls_reviewby)) > 0 then
	ls_filter += "and lower(reviewed_by) = '" + lower(ls_reviewby) + "' "
end if
if not isnull(ld_reviewdate) then 
	ls_filter += "and string(date_reviewed,'mm/dd/yyyy') = '" + string(ld_reviewdate,'mm/dd/yyyy') + "' "
end if
if not isnull(ll_reviewstatus) then 
	ls_filter += "and reviewed_status = " + string(ll_reviewstatus) + " "
end if

if left(ls_filter,4) = "and " then 
	ls_filter = right(ls_filter, len(ls_filter)-4 )
end if

is_filter = ls_filter //

return ls_filter
end function

public function integer of_build_tree ();//////////////////////////////////////////////////////////////////////
// $<function>u_tabpg_agreement_template_browse.of_build_tree()
// $<arguments>
//		value	integer		
// $<returns> integer
// $<description>Build browse treeview
//////////////////////////////////////////////////////////////////////
// $<add> 12.08.2006 by Alfee (Contract Logix Agreement Tamplate Painter)
//////////////////////////////////////////////////////////////////////
long i,ll_cnt,ll_row
long ll_handle,ll_root
long ll_category,ll_template_id,ll_category_temp
string ls_category_name,ls_template_name
treeviewitem litv_item




//clear the treeview
ll_handle = tv_1.finditem(roottreeitem!, 0)
do while ll_handle > 0 
   tv_1.deleteitem(ll_handle)
	ll_handle = tv_1.finditem(roottreeitem!, 0)
loop

ll_cnt = ds_tree.rowcount()
if ll_cnt < 1 then return -1




//insert root treeview item
litv_item.label = "All Categories"
litv_item.data = -1
litv_item.children = true
litv_item.pictureindex =1
litv_item.overlaypictureIndex = 1
litv_item.selectedpictureindex = 2

ll_root = tv_1.insertitemlast(0,litv_item)
ll_handle = ll_root

//build clause treeview
for i = 1 to ll_cnt 
	ll_category = ds_tree.getitemnumber(i,"category")
	ls_category_name = ds_tree.getitemstring(i,"category_name")
	ll_template_id = ds_tree.getitemnumber(i,"ctx_acp_template_id")
	ls_template_name = ds_tree.getitemstring(i,"template_name")	
	
	if ll_category <> ll_category_temp then 
		//build category item
		litv_item.label = ls_category_name
		litv_item.data = ll_category
		litv_item.children = true
		litv_item.pictureindex =1
		litv_item.overlaypictureIndex = 1
		litv_item.selectedpictureindex = 2	
		ll_handle = tv_1.insertitemlast(ll_root,litv_item)
		ll_category_temp = ll_category				
	end if
	
	//build template item
	if not isnull(ll_template_id) then 
		litv_item.label = ls_template_name
		litv_item.data = ll_template_id
		litv_item.children = false
		litv_item.pictureindex =3
		litv_item.overlaypictureIndex = 3
		litv_item.selectedpictureindex = 4	
		tv_1.insertitemlast(ll_handle,litv_item)		
	end if
next

ll_handle = tv_1.finditem(roottreeitem!, 0)
if ll_handle > 0 then tv_1.expanditem(ll_handle)

tv_1.selectitem(ll_root)
if dw_browse.getrow() > 0 then dw_browse.selectrow(dw_browse.getrow(),true)
		
return 1


end function

public function integer of_find_tvitem (long al_parent_data, long al_son_data);
//--------------------------- APPEON BEGIN ---------------------------
//$<modify> 04.12.2007 By: Machongmin
//$<reason> Fix a defect.

long ll_h

treeviewitem ltvi_temp

ll_h = this.tv_1.finditem( RootTreeItem!,0)
	
if ll_h < 0 then return 0

ll_h = this.tv_1.finditem( ChildTreeItem!, ll_h)

do while ll_h > 0 
	this.tv_1.getitem(ll_h, ltvi_temp)
	if ltvi_temp.data = al_parent_data then
		if al_son_data > 0 then
			ll_h = this.tv_1.finditem( ChildTreeItem!, ll_h)
			do while ll_h > 0 
				this.tv_1.getitem(ll_h, ltvi_temp)
				if ltvi_temp.data = al_son_data then
					return ll_h
				end if
				ll_h = this.tv_1.finditem( NextTreeItem!,ll_h)
			loop
		else
			return ll_h
		end if
	else
		ll_h = this.tv_1.finditem( NextTreeItem!,ll_h)
	end if
loop

return 0
//---------------------------- APPEON END ----------------------------

end function

on u_tabpg_agreement_template_browse.create
int iCurrent
call super::create
this.st_1=create st_1
this.tv_1=create tv_1
this.cb_clear=create cb_clear
this.cb_go=create cb_go
this.dw_browse=create dw_browse
this.dw_filter=create dw_filter
this.gb_1=create gb_1
this.cb_select=create cb_select
this.ds_tree=create ds_tree
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.tv_1
this.Control[iCurrent+3]=this.cb_clear
this.Control[iCurrent+4]=this.cb_go
this.Control[iCurrent+5]=this.dw_browse
this.Control[iCurrent+6]=this.dw_filter
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.cb_select
end on

on u_tabpg_agreement_template_browse.destroy
call super::destroy
destroy(this.st_1)
destroy(this.tv_1)
destroy(this.cb_clear)
destroy(this.cb_go)
destroy(this.dw_browse)
destroy(this.dw_filter)
destroy(this.gb_1)
destroy(this.cb_select)
destroy(this.ds_tree)
end on

event constructor;call super::constructor;iw_atp = iw_parent
inv_right = Create n_cst_right
end event

event destructor;call super::destructor;destroy inv_right
end event

type st_1 from u_st_splitbar within u_tabpg_agreement_template_browse
integer x = 942
integer y = 272
integer width = 18
integer height = 1656
end type

event constructor;call super::constructor;//Add by jervis 09.10.09
this.of_register( tv_1, this.left )
this.of_register( dw_browse, this.right )
end event

type tv_1 from u_tvs within u_tabpg_agreement_template_browse
integer x = 27
integer y = 272
integer width = 914
integer height = 1656
integer taborder = 50
boolean linesatroot = true
boolean hideselection = false
boolean fullrowselect = true
grsorttype sorttype = ascending!
string picturename[] = {"Custom039!","Custom050!","CheckDiff!","CheckDiff!"}
string statepicturename[] = {"custom039!","custom050!"}
boolean ib_rmbmenu = false
end type

event selectionchanged;call super::selectionchanged;long ll_row,ll_data
string ls_filter,ls_filter_ori
treeviewitem l_tvi

ls_filter_ori = is_filter

//Get current selected category or template id
if tv_1.getitem(newhandle,l_tvi) = 1 then
	ll_data = l_tvi.data
	if isnull(ll_data) or ll_data < 0 then //root
		//--------------------------- APPEON BEGIN ---------------------------
		//$<modify> 04-04-2007 By: Ken.Guo
		//$<reason> Filter data that have no access right
		//ls_filter ="1=1"
		ls_filter = inv_right.of_getfilter('Category',3)
		//---------------------------- APPEON END ----------------------------
	elseif l_tvi.children then 
		ls_filter = "category = "+ string(ll_data) //category
	else 
		ls_filter = "ctx_acp_template_id = "+ string(ll_data) //template	
	end if
end if

if not isnull(ls_filter_ori) and len(trim(ls_filter_ori)) > 0 then 
	ls_filter = ls_filter_ori + " and " + ls_filter
end if
	
dw_browse.setredraw(false)
dw_browse.setfilter(ls_filter)
dw_browse.filter()
dw_browse.setredraw(true)
if dw_browse.RowCount() > 0 then
	dw_browse.SelectRow(0, false) //added by alfee 04.09.2007	
	dw_browse.ScrollTorow( 1)
	dw_browse.SelectRow(1, True) //added by alfee 04.09.2007	
end if

iw_atp.of_changetitle( ) //added by alfee 08.24.2007

end event

event rightclicked;call super::rightclicked;//--------------------------- APPEON BEGIN ---------------------------
//$<add> 2007-02-15 By: Rodger Wu (pop menu)

m_ctx_tv_popmenu lm_pop
treeviewitem ltvi_current

lm_pop = create m_ctx_tv_popmenu

If handle < 1 then //by alfee at 04.0.9.2007
	iw_atp.il_handle_rightclicked = 0
	gnv_app.of_modify_menu_attr( lm_pop.m_add,'Enabled', True)
	gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_properties,'Enabled', False)	
	gnv_app.of_modify_menu_attr( lm_pop.m_collapse,'Enabled', False)
Else
	iw_atp.il_handle_rightclicked = handle
	This.GetItem( handle, ltvi_current )

	if ltvi_current.children then
		if ltvi_current.Expanded then
			gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', False)
		else
			gnv_app.of_modify_menu_attr( lm_pop.m_collapse,'Enabled', False)
		end if
	else
		gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', False)
		gnv_app.of_modify_menu_attr( lm_pop.m_collapse,'Enabled', False)
	end if

	Choose Case ltvi_current.level
		Case 1
			gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
			gnv_app.of_modify_menu_attr( lm_pop.m_expand,'Enabled', True)
			gnv_app.of_modify_menu_attr( lm_pop.m_properties,'Enabled', False)
		Case 2
			gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
			gnv_app.of_modify_menu_attr( lm_pop.m_properties,'Enabled', False)
		Case 3
	End Choose
End If

//--------Begin Added by Jervis 01.04.2009 Fixed BugE040202------
long ll_oldhandle
ll_oldhandle = this.FindItem(CurrentTreeItem!, 0)
this.event selectionchanged(ll_oldhandle, handle)
//--------End Added-----------------------------------------------

//--------Begin Added by Alfee 09.20.2007 for new requriement-----
If w_mdi.of_security_access(6801) < 2 Then
	gnv_app.of_modify_menu_attr( lm_pop.m_add,'Enabled', False)
	gnv_app.of_modify_menu_attr( lm_pop.m_delete,'Enabled', False)
End If
//--------End Added -----------------------------------------------

lm_pop.popmenu( w_mdi.PointerX(), w_mdi.PointerY() )
//---------------------------- APPEON END ----------------------------


end event

event doubleclicked;call super::doubleclicked;//added by alfee at 04.09.2007

treeviewitem l_tvi

if tv_1.getitem(handle,l_tvi) = -1 then return -1

if l_tvi.children = true then //Category
	if l_tvi.expanded	then
		this.collapseitem(handle)
	else
		this.expanditem(handle)
	end if
else //Template
	iw_atp.tab_1.selecttab(2)
end if

return 1
end event

type cb_clear from commandbutton within u_tabpg_agreement_template_browse
integer x = 3616
integer y = 108
integer width = 343
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Clear"
end type

event clicked;dw_filter.reset()
dw_filter.insertrow(0)
dw_filter.setfocus()

//Commented By Ken.Guo 2010-12-20
//cb_go.event clicked() //added by alfee at 04.09.2007
end event

type cb_go from commandbutton within u_tabpg_agreement_template_browse
integer x = 3273
integer y = 108
integer width = 343
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
string text = "&Filter"
end type

event clicked;string ls_filter
long ll_tvi //by alfee at 03.07.2007

ls_filter = of_generate_filter()

//Modified By Ken.Guo 2011-05-18. Workaround APB 6.5.0209's bug
ds_tree.SetFilter(ls_filter)
dw_browse.SetFilter(ls_filter)
/*
//ds_tree.object.dataWindow.table.filter = ls_filter
//dw_browse.object.dataWindow.table.filter = ls_filter
*/

dw_browse.setredraw(false)

gnv_appeondb.of_startqueue() //for web performance tunning
ds_tree.retrieve()
dw_browse.retrieve()
gnv_appeondb.of_commitqueue() //for web performance tunning

//--------------------------- APPEON BEGIN ---------------------------
//Added By Ken.Guo 2010-01-29.
//$<reason> Filter no access data
inv_right.of_filter_right(ds_tree, 'category',3)  
inv_right.of_filter_right(dw_browse, 'category',3)  
//---------------------------- APPEON END ----------------------------

parent.of_build_tree()

//added by alfee at 03.07.2007 for full text search
If ib_fulltextsearch Then 
	ll_tvi = tv_1.FindItem(RootTreeItem! , 0)
	tv_1.expandall(ll_tvi) 
End If

dw_browse.setredraw(true)

end event

type dw_browse from u_dw_contract within u_tabpg_agreement_template_browse
integer x = 960
integer y = 272
integer width = 3045
integer height = 1656
integer taborder = 40
string dataobject = "d_agreement_template_browse"
boolean hscrollbar = true
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
boolean ib_enable_columns = false
boolean ib_use_row_selection = true
boolean ib_allow_sort = true
boolean ib_read_only = true
end type

event getfocus;//override

end event

event doubleclicked;call super::doubleclicked;iw_atp.tab_1.selecttab(2)
end event

event rowfocuschanged;call super::rowfocuschanged;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 11/14/2011.  must add in current object. 

if currentrow > 0 then
	iw_atp.il_template_id = this.getitemnumber(currentrow,"ctx_acp_template_id")
	iw_atp.il_category = this.getitemnumber(currentrow,"category") //03.12.2008
end if

//Added by Alfee 08.24.2007
iw_atp.of_changetitle()
end event

event losefocus;//
end event

event rowfocuschanging;call super::rowfocuschanging;If This.ib_zoom_triggered Then Return 1 //Added By Ken.Guo 11/14/2011.  must add in current object. 
end event

type dw_filter from u_dw_contract within u_tabpg_agreement_template_browse
event ue_enter pbm_dwnprocessenter
integer x = 46
integer y = 56
integer width = 3163
integer height = 176
integer taborder = 20
string dataobject = "d_agreement_template_filter"
boolean vscrollbar = false
boolean border = false
boolean ib_isupdateable = false
boolean ib_rmbmenu = false
boolean ib_rmbfocuschange = false
end type

event ue_enter;cb_go.postevent( clicked! )
return 1
end event

event constructor;call super::constructor;this.of_setupdateable(false)

this.event ue_populatedddws()

this.of_setdropdowncalendar(true)

this.insertrow(0)
this.setfocus()

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 03-04-2007 By: Ken.Guo
//$<reason> Filter no access right data
datawindowchild ldwc_category
dw_filter.getchild('category',ldwc_category)
inv_right.of_filter_right( ldwc_category, 'code', 3)
//---------------------------- APPEON END ----------------------------

 cb_go.post event clicked()
end event

event getfocus;//
end event

event itemchanged;call super::itemchanged;//Commented By Ken.Guo 2010-12-20
//if lower(dwo.name) = "category" then
//	this.accepttext()
//	//---------Begin Modified by Alfee 01.08.2007---------
//	//<$Reason>Triggered in ue_postitemchanged() if -777
//	IF data <> '-777' THEN
//		cb_go.event clicked()
//	END If
//	//cb_go.event clicked()
//	//---------End Modified ------------------------------
//end if
end event

event ue_post_itemchanged;call super::ue_post_itemchanged;//added by alfee at 04.09.2007
if data = '-777' then
	this.accepttext()
	//cb_go.event clicked()	 
	cb_go.Post event clicked() //Alfee 01.08.2008
end if
end event

type gb_1 from groupbox within u_tabpg_agreement_template_browse
integer x = 27
integer y = 12
integer width = 3977
integer height = 228
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 128
long backcolor = 33551856
string text = "Filter Criteria"
end type

type cb_select from commandbutton within u_tabpg_agreement_template_browse
boolean visible = false
integer x = 32
integer y = 1916
integer width = 343
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
boolean enabled = false
string text = "&Select"
end type

event clicked;iw_atp.event pfc_cst_select()
end event

type ds_tree from n_ds within u_tabpg_agreement_template_browse descriptor "pb_nvo" = "true" 
string dataobject = "d_agreement_template_tree"
boolean ib_isupdateable = false
end type

event constructor;call super::constructor;this.of_settransobject(sqlca)
end event

on ds_tree.create
call super::create
end on

on ds_tree.destroy
call super::destroy
end on

