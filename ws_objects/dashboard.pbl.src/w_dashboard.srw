$PBExportHeader$w_dashboard.srw
forward
global type w_dashboard from w_child
end type
type tab_dashboard from tab within w_dashboard
end type
type tab_dashboard from tab within w_dashboard
end type
type st_settings from statictext within w_dashboard
end type
type p_logo from picture within w_dashboard
end type
type st_close from statictext within w_dashboard
end type
end forward

global type w_dashboard from w_child
string tag = "DashBorad"
boolean visible = false
integer x = 10002
integer width = 3241
integer height = 2120
boolean titlebar = false
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 67108864
string icon = "AppIcon!"
event post_open ( )
event ue_resize ( )
event ue_retrieve_target_gadgets ( string as_classname )
event type integer ue_load_template ( )
event type integer ue_saveas_template ( )
event type integer ue_manamgement ( )
event type integer ue_manage_templ ( )
event type integer ue_close_dashboard ( )
event type integer ue_close ( )
event ue_refresh_unread_email ( )
tab_dashboard tab_dashboard
st_settings st_settings
p_logo p_logo
st_close st_close
end type
global w_dashboard w_dashboard

type variables
Integer   ii_normal_width,ii_max_width
String is_powertiptext = 'Right click to display popup menu.'

n_cst_dashboard inv_dashboard

Long il_gadget_title_default_bg_color //Default gadget title BG color
String is_gadget_tilte_default_font_face
Integer ii_gadget_tilte_default_font_size
Long il_gadget_tilte_default_font_color

Long il_tab_default_bg_color //Default tab BG color
Long il_tab_default_text_color //Default tab text color
Long il_gadget_default_bg_color //Default gadget BG color
String is_default_style = '30'
String is_default_style_type = 'A'
Integer ii_default_color_face_id = 5

n_cst_filesrvwin32 inv_FileSrv 

Integer ii_auto_retrieve_i, ii_auto_retrieve_cycle = 60


end variables

forward prototypes
public subroutine of_set_backgroup ()
public function integer of_delete_tabpage (integer ai_index)
public function integer of_edit_tabpage (integer ai_index)
public function integer of_create_tabpages ()
public subroutine of_add_tabpage ()
public function u_cst_tabpg_gadget of_create_tabpage (str_tab astr_tab)
public function integer of_refres_all_tabs ()
public subroutine of_apply_title_bg_color (long al_color)
public subroutine of_set_title_height (long al_height)
public subroutine of_set_logo_verify (string as_verify_data)
public subroutine of_get_logo_verify ()
public function string of_download_logo ()
public function integer of_apply_title_bg_color ()
public function integer of_apply_logo ()
public subroutine of_apply_logo (string as_file_name, long al_logo_org_height, long al_logo_org_width, string as_verify_data)
public subroutine of_set_tab_bg_color (integer ai_index)
public function integer of_set_tab_header_properties ()
public function integer of_saveas (ref long al_template_id)
public function integer of_delete_template (long al_templ_id)
public function integer of_load (long al_templ_id, boolean ab_show_choose)
public subroutine of_show_top ()
end prototypes

event ue_resize();//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::ue_resize()
// $<arguments>(None)
// $<returns> 
// $<description> Resize this window
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 14/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

This.SetRedraw(False)
This.x = 0
This.y = 0
If This.width <> w_mdi.mdi_1.width and This.height <> w_mdi.mdi_1.height Then
	This.Resize(w_mdi.mdi_1.width - 20 , w_mdi.mdi_1.height - 20)
End If
//This.bringtotop = False //Comment it.
This.SetRedraw(True)

end event

event ue_retrieve_target_gadgets(string as_classname);u_cst_tabpg_gadget luo_tabpg
If Upperbound(tab_dashboard.Control[]) < 1 Then Return
luo_tabpg = tab_dashboard.Control[1]
luo_tabpg.Event ue_retrieve_same_gadget(as_classname)
end event

event type integer ue_load_template();//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::ue_load_template()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Load Dashboard settings from the template.
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret,i,j,li_tab_cnt
String ls_err	
Long ll_templ_id
u_cst_tabpg_gadget lnv_tabpg_gadget

li_ret = inv_dashboard.of_load_templ(ll_templ_id,True)

If li_ret = -100 Then Return 1 //Use Cancel Button.

If li_ret < 0 Then 
	Messagebox('Error '+ String(li_ret),'Failed to load the dashboard template. ',StopSign!)
Else
	li_tab_cnt = UpperBound(tab_dashboard.control[])
	For i = li_tab_cnt to 1 Step -1
		lnv_tabpg_gadget = tab_dashboard.control[i]
		//Close All Notes window in Tab
		For j = 1 To UpperBound(lnv_tabpg_gadget.u_gadget_9.iw_notes[])
			If Not isvalid(lnv_tabpg_gadget.u_gadget_9.iw_notes[j]) Then Continue
			Close(lnv_tabpg_gadget.u_gadget_9.iw_notes[j])
		Next
		//Close tabpage
		tab_dashboard.closetab(lnv_tabpg_gadget)
	Next
	
	//Create new tab by template
	of_create_tabpages()
	//Messagebox('Information','Success!')
End if


Return 1
end event

event type integer ue_saveas_template();//////////////////////////////////////////////////////////////////////
// $<event>ue_saveas_templatew_dashboard()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> Save dashboard to the template.
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret
String ls_err	
Long ll_templ_id
SetPointer(HourGlass!)
li_ret = inv_dashboard.of_save_templ(ll_templ_id)
If li_ret = -100 Then Return 1 //Use Cancel Button.

If li_ret = -101 Then
	Messagebox('Save Template','The current dashboard have no tab data, It can not be saved.')
	Return -1
End If

If li_ret < 0 Then 
	Messagebox('Error '+ String(li_ret),'Failed to save the dashboard template. ',StopSign!)
Else

End if


Return 1


end event

event type integer ue_manamgement();//Need this event , maybe PB's Bug
//Open(w_dashb_templ_manage)
Return 1

end event

event type integer ue_manage_templ();Open(w_dashb_templ_manage)
Return 1
end event

event type integer ue_close_dashboard();Return 1
end event

event type integer ue_close();If Messagebox('Information','Are you sure you want to close the dashboard window?',question!,yesno!) = 1 Then
	Close(This)
End If
Return 1

end event

event ue_refresh_unread_email();Long li_cnt,i
u_cst_tabpg_gadget lu_cst_tabpg_gadget
li_cnt = UpperBound(Tab_dashboard.Control[])
For i = 1 To li_cnt
	lu_cst_tabpg_gadget = Tab_dashboard.Control[i]
	lu_cst_tabpg_gadget.u_gadget_1.uo_todolist.event ue_refresh_unread_email( )
Next
end event

public subroutine of_set_backgroup ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_set_backgroup()
// $<arguments>(None)
// $<returns> integer
// $<description> Set this window as backgroup by window API
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Post SetWindowPos(Handle(This),1,0,0,0,0,3)   
This.Bringtotop = False

end subroutine

public function integer of_delete_tabpage (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboardof_delete_tabpage()
// $<arguments>
//		value	integer	ai_index		
// $<returns> integer
// $<description> Delete current tabpage.
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////
u_cst_tabpg_gadget lnv_tabpg_gadget

//Check Invalid index value
If ai_index < 1 Then Return 0
If ai_index = 1 Then 
	Messagebox('Warning','The Home tab cannot be deleted.')
	Return 0
End If

//Check Invalid tab
If UpperBound(tab_dashboard.Control[]) < ai_index Then
	Return 0
End If

SetPointer(HourGlass!)

//Delete Tab
//Check it first
lnv_tabpg_gadget = tab_dashboard.control[ai_index]
If lnv_tabpg_gadget.istr_current_tab.si_tab_locked = 1 Then
	Messagebox('Delete','The LOCKED tab cannot be deleted. ~r~nIf you want to delete the current tab, '+&
	'please unlock it first.')
	Return 1
End If
//Delete it
If Messagebox('Delete','Are you sure you want to delete the "'+lnv_tabpg_gadget.text+'" tab?~r~nIf you delele it, it cannot be restored.',Question!,YesNo!) = 1 Then
	//Delete all notes in current tabpage from DB
	If lnv_tabpg_gadget.u_gadget_9.of_delete_all(False) < 0 Then Return -1
	//Delete this tabpage from DB
	If inv_dashboard.of_delete_tab(lnv_tabpg_gadget.istr_current_tab.sl_tab_id) < 0 Then
		Messagebox('Delete','Failed to delete the tab, please call support.')
		Return -1
	End If
	tab_dashboard.closetab(lnv_tabpg_gadget)
	tab_dashboard.SelectTab(ai_index - 1)
	of_set_tab_bg_color(tab_dashboard.selectedtab)
Else
	
End If
Return 1


end function

public function integer of_edit_tabpage (integer ai_index);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboardof_edit_tabpage()
// $<arguments>
//		value	integer	ai_index		
// $<returns> integer
// $<description> Edit tabpage
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////
u_cst_tabpg_gadget luo_tabpg
luo_tabpg = tab_dashboard.Control[ai_index]

If ai_index = 1 Then
	luo_tabpg.ib_first_page = True
Else
	luo_tabpg.ib_first_page = False
End If
OpenwithParm(w_dashboard_tab_config,luo_tabpg )
Return 1
end function

public function integer of_create_tabpages ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_create_tabpages()
// $<arguments>(None)
// $<returns> integer
// $<description> Create all tabpages
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_cnt,i
String ls_tab_title,ls_tab_style
long ll_tab_id,ll_gadget_bg_color
str_gadget lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[],lstr_empty[]
str_tab lstr_tab
u_cst_tabpg_gadget luo_tabpag_gadget

SetPointer(HourGlass!)
li_cnt = inv_dashboard.ids_dashboard_tabs.RowCount()
If li_cnt < 1 Then Return 0
This.SetRedraw(False)

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Loading Dashboard...')
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(30)	
End If

of_set_tab_header_properties()

For i = 1 To li_cnt
	lstr_area1[] = lstr_empty[]
	lstr_area2[] = lstr_empty[]
	lstr_area3[] = lstr_empty[]
	lstr_area4[] = lstr_empty[]		
	lstr_tab.sl_tab_id = inv_dashboard.ids_dashboard_tabs.GetItemnumber(i,'tab_id')
	lstr_tab.ss_tab_title = inv_dashboard.ids_dashboard_tabs.GetItemString(i,'tab_title')
	lstr_tab.ss_tab_style = inv_dashboard.ids_dashboard_tabs.GetItemString(i,'tab_style')
	lstr_tab.ss_tab_style_type = inv_dashboard.ids_dashboard_tabs.GetItemString(i,'tab_style_type')
	lstr_tab.sl_gadget_title_bg_color = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'gadget_title_color')
	lstr_tab.sl_gadget_bg_color = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'gadget_bg_color')
	lstr_tab.sl_tab_bg_color = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'tab_bg_color')
	lstr_tab.sl_tab_text_color = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'tab_text_color')
	lstr_tab.si_tab_locked = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'tab_locked')
	lstr_tab.si_single_double_clk = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'single_double_clk')
	
	lstr_tab.ss_gadget_title_font_face = inv_dashboard.ids_dashboard_tabs.GetItemString(i,'gadget_title_font_face')
	lstr_tab.si_gadget_title_font_size = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'gadget_title_font_size')
	lstr_tab.sl_gadget_title_font_color = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'gadget_title_font_color')
	
	
	lstr_tab.si_clock_face_id = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'clock_face_id')
	
	luo_tabpag_gadget = of_create_tabpage(lstr_tab)
	inv_dashboard.of_gen_area_structure(lstr_tab.sl_tab_id,lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[])
	luo_tabpag_gadget.of_gen_area_ini(lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[])
	luo_tabpag_gadget.of_set_visiable()
	luo_tabpag_gadget.event ue_retrieve()  //Retrieve for all gadget.
	luo_tabpag_gadget.of_refresh_do()
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(30/li_cnt)
Next

li_cnt = UpperBound(Tab_dashboard.Control[])
For i = 1 To li_cnt
	Tab_dashboard.Control[i].Dynamic of_refresh_ui()
	If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(30/li_cnt)	
Next

Tab_dashboard.selecttab(1)
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(100)
This.SetRedraw(True)
If Isvalid(w_appeon_gifofwait) Then Close(w_appeon_gifofwait)

Return 1

end function

public subroutine of_add_tabpage ();String ls_title
Long ll_tab_id
Str_tab lstr_tab
u_cst_tabpg_gadget lnv_tabpg

If UpperBound(tab_dashboard.control[]) >= 3 Then
	Messagebox('Add Tab','The maximum number of dashboard tabs is 3.  You cannot add more dashboards.',exclamation!)
	Return
End If

//Input tab name
Open(w_dashboard_tab_name)
ls_title = Message.Stringparm
If ls_title = '' Then Return

SetPointer(HourGlass!)

//Generate tab data in DB
ll_tab_id =  inv_dashboard.of_add_tabpage(ls_title,is_default_style,is_default_style_type)
If ll_tab_id < 0 Then
	Messagebox('Add tab','Failed to add a tab, please call support.')
	Return
End If

//Create tab
lstr_tab.sl_tab_id = ll_tab_id
lstr_tab.ss_tab_title = ls_title
lstr_tab.ss_tab_style = is_default_style
lstr_tab.ss_tab_style_type = is_default_style_type
lstr_tab.sl_gadget_title_bg_color = il_gadget_title_default_bg_color

lstr_tab.ss_gadget_title_font_face = is_gadget_tilte_default_font_face
lstr_tab.si_gadget_title_font_size = ii_gadget_tilte_default_font_size
lstr_tab.sl_gadget_title_font_color = il_gadget_tilte_default_font_color

lstr_tab.sl_gadget_bg_color = il_gadget_default_bg_color
lstr_tab.sl_tab_bg_color = il_tab_default_bg_color
lstr_tab.sl_tab_text_color = il_tab_default_text_color

lstr_tab.si_tab_locked = 0
lstr_tab.si_single_double_clk = 1

lstr_tab.si_clock_face_id = ii_default_color_face_id

lnv_tabpg = of_create_tabpage(lstr_tab)
If isvalid(lnv_tabpg) Then
	lnv_tabpg.of_refresh_ui()
	of_edit_tabpage(tab_dashboard.selectedtab)
End If

end subroutine

public function u_cst_tabpg_gadget of_create_tabpage (str_tab astr_tab);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_create_tabpage()
// $<arguments>(None)
// $<returns> integer
// $<description> Add a tabpage
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Int li_tabpg_cnt
u_cst_tabpg_gadget lnv_tabpg
This.tab_dashboard.opentab(u_cst_tabpg_gadget,0 )
li_tabpg_cnt = Upperbound(This.tab_dashboard.Control[])
This.tab_dashboard.Selecttab(li_tabpg_cnt)
lnv_tabpg = This.tab_dashboard.Control[li_tabpg_cnt]
lnv_tabpg.VScrollBar = True
//lnv_tabpg.powertiptext =  is_powertiptext //Modified by Ken.Guo on 2008-11-24
lnv_tabpg.istr_current_tab = astr_tab
lnv_tabpg.Text = astr_tab.ss_tab_title //Refresh tab's title at once

Return lnv_tabpg
end function

public function integer of_refres_all_tabs ();Integer i ,li_cnt
str_gadget lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[]
str_gadget ll_str_empty[]
u_cst_tabpg_gadget luo_tabpag_gadget

//Refresh data
inv_dashboard.of_retrieve_data()

//Refresh UI

li_cnt = UpperBound(tab_dashboard.Control[])
For i = 1 to li_cnt
	lstr_area1[] = ll_str_empty[]
	lstr_area2[] = ll_str_empty[]
	lstr_area3[] = ll_str_empty[]
	lstr_area4[] = ll_str_empty[]
	luo_tabpag_gadget = tab_dashboard.Control[i]
	//Refresh Structure Array.
	inv_dashboard.of_gen_area_structure(luo_tabpag_gadget.istr_current_tab.sl_tab_id ,lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[])
	luo_tabpag_gadget.of_gen_area_ini(lstr_area1[],lstr_area2[],lstr_area3[],lstr_area4[])
	//Refresh visible
	luo_tabpag_gadget.of_set_visiable()
	//Refresh Data
	luo_tabpag_gadget.event ue_retrieve()
	//Refresh UI
	luo_tabpag_gadget.of_refresh_ui()
	//Re-Do
	luo_tabpag_gadget.of_refresh_do()
Next

//To workaround PB's BUG
tab_dashboard.Selecttab(tab_dashboard.Selectedtab)

Return 1
end function

public subroutine of_apply_title_bg_color (long al_color);This.backcolor = al_color
st_settings.backcolor = al_color
st_close.backcolor = al_color
end subroutine

public subroutine of_set_title_height (long al_height);Long ll_org_width,ll_org_height
long ll_org_y

p_logo.visible = False
p_logo.originalsize = True
ll_org_width = p_logo.width
ll_org_height = p_logo.height
ll_org_y = tab_dashboard.y 

If ll_org_height > al_height Then
	p_logo.height = al_height
	p_logo.width = ll_org_width * (p_logo.height/ll_org_height)
	p_logo.originalsize = False
End If

If tab_dashboard.y <> al_height Then
	tab_dashboard.y = al_height
	tab_dashboard.height += ll_org_y - tab_dashboard.y
	st_settings.y +=  tab_dashboard.y - ll_org_y
	st_close.y +=  tab_dashboard.y - ll_org_y
End If
p_logo.visible = true

end subroutine

public subroutine of_set_logo_verify (string as_verify_data);//
end subroutine

public subroutine of_get_logo_verify ();//
end subroutine

public function string of_download_logo ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_download_logo()
// $<arguments>(None)
// $<returns> string   logo file path name
// $<description>
// $<description> Download logo from DB
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-20 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_length, ll_start,ll_CurrentPos
Integer li_loops,li_FileNo,li_Writes,li_Cnt
Blob lblb_data,lblb_logo
String ls_fullname,ls_extname
Long ll_BlobLen
Long ll_logo_size

ll_logo_size = inv_dashboard.ids_dashboard_settings.GetItemNumber(1,'logo_size')
ls_extname = inv_dashboard.ids_dashboard_settings.GetItemString(1,'logo_extname')
If ls_extname = '' or isnull(ls_extname) Then Return ''
//---------Begin Modified by (Appeon)Harry 12.05.2013  V141 for BugH111801 of Reintegration Issues--------
/*
//ls_fullname = gs_dir_path + gs_DefDirName + '\dashboard_logo.' + ls_extname
ls_fullname = gs_dir_path + 'IntelliCred\logo.' + ls_extname //(Appeon)Eugene 06.04.2013 - V141 ISG-CLX
*/
ls_fullname = gs_dir_path + gs_DefDirName + '\dashboard_logo.' + ls_extname
//---------End Modfiied ------------------------------------------------------

IF fileexists( ls_fullname ) THEN
	If ll_logo_size = FileLength(ls_fullname) Then
		Return ls_fullname
	End If
End If

If appeongetclienttype() = "PB" Then
	SELECT DataLength( logo )
	INTO :ll_length
	FROM dashboard_settings
	WHERE id = 1;
	IF ll_length <= 0 or isnull(ll_length) THEN Return ''
End If

IF gs_dbtype = "SQL" and appeongetclienttype() = "PB" and ll_length > 8000 THEN
	li_loops = ( ll_length / 8000 ) + 1

	For li_Cnt = 1 To li_loops				
		ll_start = (li_Cnt - 1) * 8000 + 1
		SELECTBLOB Substring( logo, :ll_start, 8000 ) 
		INTO :lblb_data 
		FROM dashboard_settings WHERE id = 1; 
		IF SQLCA.SQLCode <> 0 THEN
			Messagebox( "IntelliSoft", "Read logo file data from database failed." )
			Return ''
		END IF
		lblb_logo += lblb_data
	Next 
ELSE
	SELECTBLOB logo 
	INTO :lblb_logo 
	FROM dashboard_settings
	WHERE id = 1;
	IF SQLCA.SQLCode <> 0 THEN
		Messagebox( "IntelliSoft", "Read log file data from database failed." )
		Return ''
	END IF
END IF

If isnull(lblb_logo) Or Len(lblb_logo) = 0 Then Return ''

IF fileexists( ls_fullname ) THEN
	inv_FileSrv.of_setfilereadonly( ls_fullname, False)
	FileDelete( ls_fullname )
END IF

li_FileNo = FileOpen( ls_fullname, StreamMode!, Write!, LockReadWrite!, Append!)
If li_FileNo < 0 Then
	Messagebox( "IntelliSoft", "Create temporary file failed." )
	Return ''
End If

ll_BlobLen = Len(lblb_logo)

If ll_BlobLen > 32765 Then
	If Mod(ll_BlobLen, 32765) = 0 Then
		li_Writes = ll_BlobLen / 32765
	Else
		li_Writes = (ll_BlobLen / 32765) + 1
	End if
Else
	li_Writes = 1
End if

ll_CurrentPos = 1
For li_Cnt = 1 To li_Writes
	lblb_Data = BlobMid(lblb_logo, ll_CurrentPos, 32765)
	ll_CurrentPos += 32765
	If FileWrite(li_FileNo, lblb_Data) = -1 Then
		Messagebox( "IntelliSoft", "Write temporary file failed." )
		Return ''
	End if
Next
FileClose(li_FileNo)

IF Not FileExists(ls_fullname) THEN Return ''
Return ls_fullname
end function

public function integer of_apply_title_bg_color ();Long ll_color
ll_color = inv_dashboard.ids_dashboard_settings.GetItemnumber(1,'title_bg_color')
of_apply_title_bg_color(ll_color)
Return 1
end function

public function integer of_apply_logo ();String ls_logo_path
Long ll_height,ll_width
String ls_logo_verify_data

p_logo.originalsize = False
ls_logo_path = of_download_logo()
If ls_logo_path = '' Then Return -1

ll_height = inv_dashboard.ids_dashboard_settings.GetItemNumber(1,'logo_org_height')
ll_width = inv_dashboard.ids_dashboard_settings.GetItemNumber(1,'logo_org_width')
ls_logo_verify_data = inv_dashboard.ids_dashboard_settings.GetItemString(1,'logo_verif_data')

This.of_apply_logo(ls_logo_path, ll_height,ll_width, ls_logo_verify_data)

Return 1
end function

public subroutine of_apply_logo (string as_file_name, long al_logo_org_height, long al_logo_org_width, string as_verify_data);//
Long ll_title_height

p_logo.visible = False
p_logo.picturename = "" //Added by Scofield 2008-11-17. Workaround For Web. 
p_logo.picturename = as_file_name
If al_logo_org_height > tab_dashboard.y Then //Need Zoom
	p_logo.height = tab_dashboard.y
	p_logo.width = al_logo_org_width * (p_logo.height/al_logo_org_height)
	p_logo.originalsize = False
Else
	p_logo.originalsize = True	
End If
p_logo.visible = True

of_set_logo_verify(as_verify_data)
end subroutine

public subroutine of_set_tab_bg_color (integer ai_index);u_cst_tabpg_gadget lu_tabpg
lu_tabpg = tab_dashboard.Control[ai_index]
tab_dashboard.backcolor = lu_tabpg.istr_current_tab.sl_tab_bg_color


end subroutine

public function integer of_set_tab_header_properties ();String ls_header_font_face
Integer li_header_font_size
Integer li_tab_position

If inv_dashboard.ids_dashboard_tab_settings.RowCount() = 1 Then
	ls_header_font_face = inv_dashboard.ids_dashboard_tab_settings.GetItemString(1,'tab_header_font_face')
	li_header_font_size = inv_dashboard.ids_dashboard_tab_settings.GetItemNumber(1,'tab_header_font_size')
	li_tab_position = inv_dashboard.ids_dashboard_tab_settings.GetItemNumber(1,'tab_position')
End If

If isnull(ls_header_font_face) or ls_header_font_face = '' Then
	ls_header_font_face = is_gadget_tilte_default_font_face
End If

If isnull(li_header_font_size) or li_header_font_size = 0 Then
	li_header_font_size = ii_gadget_tilte_default_font_size
End If

tab_dashboard.facename = ls_header_font_face
tab_dashboard.textsize = li_header_font_size
If li_tab_position = 2 Then
	tab_dashboard.TabPosition = TabsonBottom!
Else
	tab_dashboard.TabPosition = TabsonTop!
End If
	
Return 1	
end function

public function integer of_saveas (ref long al_template_id);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_saveas()
// $<arguments>
//		ref	long	al_template_id		
// $<returns> integer
// $<description> Save dashboard settings to the template.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Return inv_dashboard.of_save_templ(al_template_id)

/*
long ll_templ_id,ll_max_tab_id,ll_old_tabs_id[],ll_new_tabs_id[]
Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt
Integer i,j,k,n,li_ret
Boolean lb_auto_commit
String ls_err
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates

//Get template Name/ID
Open(w_dashb_templ_saveas)
ll_templ_id = Message.doubleparm

//When Click Cancel Button
If ll_templ_id = -100 Then
	Return -100
End If

If isnull(ll_templ_id) or ll_templ_id <= 0 Then
	Return -1
End If

al_template_id = ll_templ_id

lds_dashb_tabs_templates = Create n_ds
lds_dashb_settings_templates = Create n_ds
lds_dashb_tabs_templates.dataobject = 'd_dashb_tabs_templates'
lds_dashb_settings_templates.dataobject = 'd_dashb_tab_settings_templates'
lds_dashb_tabs_templates.Settransobject(SQLCA)
lds_dashb_settings_templates.Settransobject(SQLCA)

//Get Max tab_id
Select Max(tab_id) Into :ll_max_tab_id from dashboard_tabs;
If isnull(ll_max_tab_id) Then 
	Return -2
End If

li_tabs_cnt = inv_dashboard.ids_dashboard_tabs.RowCount()
li_gadgets_cnt = inv_dashboard.ids_dashboard_tab_gadgets.Rowcount()
li_reports_cnt = inv_dashboard.ids_dashboard_reports.Rowcount()

If li_tabs_cnt = 0 Then 
	Return -101
End If

//Save dashboard settings.
For i = 1 To li_tabs_cnt
	//Save tabs
	ll_max_tab_id++
	ll_old_tabs_id[i] = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'tab_id')
	ll_new_tabs_id[i] = ll_max_tab_id
	If inv_dashboard.ids_dashboard_tabs.RowsCopy(i,i,Primary!,lds_dashb_tabs_templates,99999,Primary!) <> 1 Then Return -102
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'template_id',ll_templ_id)
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'tab_id',ll_max_tab_id)
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'user_id',is_user_templates)
	//Save gadgets for tabs
	For j = 1 to li_gadgets_cnt
		If inv_dashboard.ids_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_old_tabs_id[i] Then
			If inv_dashboard.ids_dashboard_tab_gadgets.RowsCopy(j,j,Primary!,inv_dashboard.ids_dashboard_tab_gadgets,99999,Primary!) <> 1 Then Return -103
			inv_dashboard.ids_dashboard_tab_gadgets.SetItem(inv_dashboard.ids_dashboard_tab_gadgets.RowCount(),'tab_id',ll_new_tabs_id[i])
		End If
	Next	
	//Save reports for gadgets for tabs
	For k = 1 to li_reports_cnt
		If inv_dashboard.ids_dashboard_reports.GetItemNumber(k,'tab_id') = ll_old_tabs_id[i] Then
			If inv_dashboard.ids_dashboard_reports.RowsCopy(k,k,Primary!,inv_dashboard.ids_dashboard_reports,99999,Primary!) <> 1 Then Return -104
			inv_dashboard.ids_dashboard_reports.SetItem(inv_dashboard.ids_dashboard_reports.RowCount(),'tab_id',ll_new_tabs_id[i])
			inv_dashboard.ids_dashboard_reports.SetItem(inv_dashboard.ids_dashboard_reports.RowCount(),'user_id',is_user_templates)
		End If
	Next
Next
//Save tabs settings
If inv_dashboard.ids_dashboard_tab_settings.RowsCopy(1,1,Primary!,lds_dashb_settings_templates,1,Primary!) <> 1 Then Return -105
lds_dashb_settings_templates.SetItem(1,'template_id',ll_templ_id)
lds_dashb_settings_templates.SetItem(1,'user_id',is_user_templates)

//Save data to DB
lb_auto_commit = SQLCA.autocommit
SQLCA.autocommit = False
If lds_dashb_tabs_templates.update() = 1 Then
	If inv_dashboard.ids_dashboard_tab_gadgets.update() = 1 Then
		If inv_dashboard.ids_dashboard_reports.update() = 1 Then
			if lds_dashb_settings_templates.update() = 1 Then
				li_ret = 1
			Else
				li_ret = -106
			End if
		Else
			li_ret = -107
		End If
	Else
		li_ret = -108
	End If
Else
	li_ret = -109
End If
SQLCA.autocommit = lb_auto_commit

Return li_ret
*/
end function

public function integer of_delete_template (long al_templ_id);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_delete_template()
// $<arguments>
//		value	long	al_templ_id		
// $<returns> integer
// $<description> Delete template
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Return inv_dashboard.of_delete_templ(al_templ_id) 

/*
Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt
Integer i,j,k,n,li_ret
Long ll_tab_id
Boolean lb_autocommit
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates
n_ds lds_dashboard_tab_gadgets,lds_dashboard_reports

lds_dashb_tabs_templates = Create n_ds
lds_dashb_tabs_templates.dataobject = 'd_dashb_tabs_templates'
lds_dashb_tabs_templates.Settransobject(SQLCA)

lds_dashb_settings_templates = Create n_ds
lds_dashb_settings_templates.dataobject = 'd_dashb_tab_settings_templates'
lds_dashb_settings_templates.Settransobject(SQLCA)

lds_dashboard_tab_gadgets = Create n_ds
lds_dashboard_reports = Create n_ds
lds_dashboard_tab_gadgets.dataobject = inv_dashboard.ids_dashboard_tab_gadgets.dataobject
lds_dashboard_reports.dataobject = inv_dashboard.ids_dashboard_reports.dataobject
lds_dashboard_tab_gadgets.SettransObject(SQLCA)
lds_dashboard_reports.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
li_tabs_cnt = lds_dashb_tabs_templates.Retrieve(al_templ_id)
li_gadgets_cnt = lds_dashboard_tab_gadgets.Retrieve(is_user_templates)
li_reports_cnt = lds_dashboard_reports.Retrieve(is_user_templates)
lds_dashb_settings_templates.Retrieve(al_templ_id)
gnv_appeondb.of_commitqueue()

If li_tabs_cnt = 0 Then Return 100

For i = li_tabs_cnt to 1 Step -1
	//Delete tab
	ll_tab_id = lds_dashb_tabs_templates.GetItemNumber(i,'tab_id')
	lds_dashb_tabs_templates.DeleteRow(i)
	For j = li_gadgets_cnt to 1 Step -1
		//Delete gadgets for tab
		If lds_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_tab_id Then
			lds_dashboard_tab_gadgets.DeleteRow(j)
		End If
	Next
	For k = li_reports_cnt to 1 Step -1
		//Delete report for gadgets
		If lds_dashboard_reports.GetItemNumber(k,'tab_id') = ll_tab_id Then
			lds_dashboard_reports.DeleteRow(k)
		End If
	Next
Next
//Delete tab settings
lds_dashb_settings_templates.DeleteRow(1)

//Save data to DB
lb_autocommit = SQLCA.autocommit
SQLCA.autocommit = False
If lds_dashb_tabs_templates.Update() = 1 Then
	If lds_dashboard_tab_gadgets.Update() = 1 Then
		If lds_dashboard_reports.Update() = 1 Then
			If lds_dashb_settings_templates.Update() = 1 Then
				Delete from dashboard_template where id =:al_templ_id;
				If SQLCA.sqlcode >= 0 Then
					Commit using SQLCA;
					li_ret = 1
				Else
					Rollback using SQLCA;
					li_ret = -2					
				End If
			Else

			End If
		Else
			Rollback using SQLCA;
			li_ret = -102			
		End If
	Else
		Rollback using SQLCA;
		li_ret = -103		
	End If
Else
	Rollback using SQLCA;
	li_ret = -104
End If

SQLCA.autocommit = lb_autocommit
Return li_ret
*/
end function

public function integer of_load (long al_templ_id, boolean ab_show_choose);//////////////////////////////////////////////////////////////////////
// $<function>w_dashboardof_load()
// $<arguments>
//		long	al_templ_id		
//		boolean ab_show_choose 
// $<returns> integer
// $<description> Load dashboard settings from the templates.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Return inv_dashboard.of_load_templ(al_templ_id,ab_show_choose)

/*
Long ll_templ_id
Boolean lb_auto_commit
Integer li_ret
Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt,li_find
Integer i,j,k,n
Long ll_old_tabs_id[],ll_tpl_tabs_id[],ll_new_tabs_id[]
Long ll_max_tab_id
Long ll_template_null 
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates

If ab_show_choose Then
	//Get template id
	Open(w_dashb_templ_load)
	ll_templ_id = Message.doubleparm
	al_templ_id = ll_templ_id
	
	If ll_templ_id = -100 Then Return -100 //Use cancel button
	
	If Isnull(ll_templ_id) or ll_templ_id <= 0 Then
		Return -1
	End If
End If

li_tabs_cnt = inv_dashboard.ids_dashboard_tabs.RowCount()

//If li_tabs_cnt = 0 Then  
//	Return -101
//End If

//Delete current dashboard settings.
For i = li_tabs_cnt To 1 Step -1
	li_gadgets_cnt = inv_dashboard.ids_dashboard_tab_gadgets.Rowcount()
	li_reports_cnt = inv_dashboard.ids_dashboard_reports.Rowcount()

	//Delete Tab
	//If inv_dashboard.ids_dashboard_tabs.GetItemString(i,'user_id') <> gs_user_id Then Continue
	ll_old_tabs_id[i] = inv_dashboard.ids_dashboard_tabs.GetItemNumber(i,'tab_id')
	inv_dashboard.ids_dashboard_tabs.DeleteRow(i)
	//Delete gadgets for Tab
	For j = li_gadgets_cnt to 1 Step -1
		If inv_dashboard.ids_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_old_tabs_id[i] Then
			inv_dashboard.ids_dashboard_tab_gadgets.DeleteRow(j)
		End If
	Next
	//Delete reports for gadgets for tab
	For k = li_reports_cnt to 1 Step -1
		If inv_dashboard.ids_dashboard_reports.GetItemNumber(k,'tab_id') = ll_old_tabs_id[i] Then
			inv_dashboard.ids_dashboard_reports.DeleteRow(k)
		End If
	Next
Next
//Delete tabs settings
inv_dashboard.ids_dashboard_tab_settings.DeleteRow(1)


//Load new settings.
lds_dashb_tabs_templates = Create n_ds
lds_dashb_tabs_templates.dataobject = 'd_dashb_tabs_templates'
lds_dashb_tabs_templates.Settransobject(SQLCA)

lds_dashb_settings_templates = Create n_ds
lds_dashb_settings_templates.dataobject = 'd_dashb_tab_settings_templates'
lds_dashb_settings_templates.Settransobject(SQLCA)

n_ds lds_dashboard_tab_gadgets,lds_dashboard_reports
lds_dashboard_tab_gadgets = Create n_ds
lds_dashboard_reports = Create n_ds
lds_dashboard_tab_gadgets.dataobject = inv_dashboard.ids_dashboard_tab_gadgets.dataobject
lds_dashboard_reports.dataobject = inv_dashboard.ids_dashboard_reports.dataobject
lds_dashboard_tab_gadgets.SettransObject(SQLCA)
lds_dashboard_reports.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
li_tabs_cnt = lds_dashb_tabs_templates.Retrieve(al_templ_id)
li_gadgets_cnt = lds_dashboard_tab_gadgets.Retrieve(is_user_templates)
li_reports_cnt = lds_dashboard_reports.Retrieve(is_user_templates)
lds_dashb_settings_templates.Retrieve(al_templ_id)
gnv_appeondb.of_commitqueue()

//Get Max tab_id
Select Max(tab_id) Into :ll_max_tab_id from dashboard_tabs;
If isnull(ll_max_tab_id) Then 
	Return -2
End If

//add new dashboard settings.
Setnull(ll_template_null)
For i = 1 To li_tabs_cnt
	//add tabs
	ll_max_tab_id++
	ll_tpl_tabs_id[i] = lds_dashb_tabs_templates.GetItemNumber(i,'tab_id')
	ll_new_tabs_id[i] = ll_max_tab_id
	If lds_dashb_tabs_templates.RowsCopy(i,i,Primary!,inv_dashboard.ids_dashboard_tabs,99999,Primary!) <> 1 Then Return -102
	inv_dashboard.ids_dashboard_tabs.SetItem(inv_dashboard.ids_dashboard_tabs.RowCount(),'template_id',ll_template_null)
	inv_dashboard.ids_dashboard_tabs.SetItem(inv_dashboard.ids_dashboard_tabs.RowCount(),'tab_id',ll_max_tab_id)
	inv_dashboard.ids_dashboard_tabs.SetItem(inv_dashboard.ids_dashboard_tabs.RowCount(),'user_id',gs_user_id)
	//add gadgets for tabs
	For j = 1 to li_gadgets_cnt
		If lds_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_tpl_tabs_id[i] Then
			If lds_dashboard_tab_gadgets.RowsCopy(j,j,Primary!,inv_dashboard.ids_dashboard_tab_gadgets,99999,Primary!) <> 1 Then Return -103
			inv_dashboard.ids_dashboard_tab_gadgets.SetItem(inv_dashboard.ids_dashboard_tab_gadgets.RowCount(),'tab_id',ll_new_tabs_id[i])
		End If
	Next	
	//add reports for gadgets for tabs
	For k = 1 to li_reports_cnt
		If lds_dashboard_reports.GetItemNumber(k,'tab_id') = ll_tpl_tabs_id[i] Then
			If lds_dashboard_reports.RowsCopy(k,k,Primary!,inv_dashboard.ids_dashboard_reports,99999,Primary!) <> 1 Then Return -104
			inv_dashboard.ids_dashboard_reports.SetItem(inv_dashboard.ids_dashboard_reports.RowCount(),'tab_id',ll_new_tabs_id[i])
			inv_dashboard.ids_dashboard_reports.SetItem(inv_dashboard.ids_dashboard_reports.RowCount(),'user_id',gs_user_id)
		End If
	Next
Next
//add tabs settings
If lds_dashb_settings_templates.RowsCopy(1,1,Primary!,inv_dashboard.ids_dashboard_tab_settings,1,Primary!) <> 1 Then Return -105
inv_dashboard.ids_dashboard_tab_settings.SetItem(1,'template_id',ll_template_null)
inv_dashboard.ids_dashboard_tab_settings.SetItem(1,'user_id',gs_user_id)

//Save data to DB
lb_auto_commit = SQLCA.autocommit
SQLCA.autocommit = False
If inv_dashboard.ids_dashboard_tabs.update() = 1 Then
	If inv_dashboard.ids_dashboard_tab_gadgets.update() = 1 Then
		If inv_dashboard.ids_dashboard_reports.update() = 1 Then
			if inv_dashboard.ids_dashboard_tab_settings.update() = 1 Then
				li_ret = 1
			Else
				li_ret = -106
			End if
		Else
			li_ret = -107
		End If
	Else
		li_ret = -108
	End If
Else
	li_ret = -109
End If
//Move notes to this new tab.
Update dashboard_gadgets_notes Set tab_id = :ll_new_tabs_id[1] where user_id = :gs_user_id;
SQLCA.autocommit = lb_auto_commit

Return 1
*/

end function

public subroutine of_show_top ();//////////////////////////////////////////////////////////////////////
// $<function>w_dashboard::of_show_top()
// $<arguments>(None)
// $<returns> (none)
// $<description>
// $<description> Bring it to top. Minimized all other windows.
//////////////////////////////////////////////////////////////////////
// $<add> 12.22.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Comment By Jervis 05.25.2009
//Move to f_SetMinWindows
/*
Window lw_sheet
lw_sheet = w_mdi.GetfirstSheet()
do while 1 = 1
	If Isvalid(lw_sheet) Then
		If lw_sheet.classname() = 'w_dashboard' then 
			lw_sheet = w_mdi.GetNextSheet(lw_sheet)
			continue
		End If
		If lw_sheet.windowstate <> Minimized! Then lw_sheet.windowstate = Minimized!
	Else
		Exit
	End If
	lw_sheet = w_mdi.GetNextSheet(lw_sheet)
loop
*/
of_set_backgroup()

end subroutine

on w_dashboard.create
int iCurrent
call super::create
this.tab_dashboard=create tab_dashboard
this.st_settings=create st_settings
this.p_logo=create p_logo
this.st_close=create st_close
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_dashboard
this.Control[iCurrent+2]=this.st_settings
this.Control[iCurrent+3]=this.p_logo
this.Control[iCurrent+4]=this.st_close
end on

on w_dashboard.destroy
call super::destroy
destroy(this.tab_dashboard)
destroy(this.st_settings)
destroy(this.p_logo)
destroy(this.st_close)
end on

event resize;call super::resize;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::resize()
// $<arguments>
//		value	unsignedlong	sizetype 		
//		value	integer     	newwidth 		
//		value	integer     	newheight		
// $<returns> long
// $<description> Resize Dashbord tab when dashboard window resized.
//////////////////////////////////////////////////////////////////////
// $<add> 14/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_title_height
Long ll_new_height,ll_new_width
This.SetRedraw(False)

tab_dashboard.x = 0
if isvalid(inv_dashboard) then
	ll_title_height = inv_dashboard.ids_dashboard_settings.GetItemNumber(1,'title_height')
end if
If ll_title_height = 0 or isnull(ll_title_height) Then
	ll_title_height = 300
End If
Tab_dashboard.y = ll_title_height

Long ll_vbar_space,ll_hbar_space
If w_mdi.VScrollBar Then
	ll_vbar_space = 80
Else
	ll_vbar_space = 0
End If
If w_mdi.HScrollBar Then
	ll_hbar_space = 80
Else
	ll_hbar_space = 0
End If

ll_new_height = This.Height - tab_dashboard.y - 20 - ll_vbar_space
ll_new_width = This.width - tab_dashboard.x - 20 - ll_hbar_space
If Tab_dashboard.width <> ll_new_width Or Tab_dashboard.height <> ll_new_height Then
	Tab_dashboard.Resize(ll_new_width,ll_new_height)
End If

st_settings.y = tab_dashboard.y - 100
st_close.y = st_settings.y
st_settings.x = This.width - 530
st_close.x = This.width - 250
//st_settings.x = This.width - 300
This.SetRedraw(True)


end event

event open;call super::open;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::Open()
// $<arguments>(None)
// $<returns> long
// $<description> 
//////////////////////////////////////////////////////////////////////
// $<add> 14/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

If Not Isvalid(w_appeon_gifofwait) Then 
	Open(w_appeon_gifofwait)
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_settext('Opening Dashboard...')
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(10)

inv_FileSrv = Create n_cst_filesrvwin32 

This.Title = 'DashBoard' //For system menu 'Window->Dashboard'
il_gadget_title_default_bg_color = RGB(180,180,180) //Default gadget title BG color
il_tab_default_bg_color =  67108864 // Default Tab BG color.  'Button Face'
il_tab_default_text_color =  0 // Default Tab TEXT color. 
il_gadget_default_bg_color = 67108864 //Default gadget BG color.  'Button Face'
is_gadget_tilte_default_font_face = 'MS Sans Serif'
ii_gadget_tilte_default_font_size = 8
il_gadget_tilte_default_font_color = 0

inv_dashboard = Create n_cst_dashboard
inv_dashboard.of_set_tab_default(il_gadget_title_default_bg_color, il_tab_default_bg_color,il_tab_default_text_color,il_gadget_default_bg_color,is_gadget_tilte_default_font_face,ii_gadget_tilte_default_font_size,ii_default_color_face_id,il_gadget_tilte_default_font_color)

If inv_dashboard.of_retrieve_data() < 0 Then
	Messagebox('Dashboard','Failed to create the default dashboard.')
End If
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_skipnextposition(10)

Timer(1)

end event

event activate;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::activate()
// $<arguments>(None)
// $<returns> long
// $<description> Set this window as backgroup by window API.
//////////////////////////////////////////////////////////////////////
// $<add> 14/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Override Ancestor Script

w_mdi.Event pfc_minimizeall() //(Appeon)Eugene 06.04.2013 - V141 ISG-CLX

If w_mdi.menuname<> "m_pfe_cst_mdi_dashboard" Then
	w_mdi.SetRedraw(False)//(Appeon)Eugene 08.06.2013 - V141 ISG-CLX
	w_mdi.changemenu(m_pfe_cst_mdi_dashboard)
	w_mdi.of_menu_security( w_mdi.MenuName )
	w_mdi.SetRedraw(True)	//(Appeon)Eugene 08.06.2013 - V141 ISG-CLX
End If

of_set_backgroup()

end event

event pfc_postopen;call super::pfc_postopen;//////////////////////////////////////////////////////////////////////
// $<event>w_dashboard::pfc_postopen()
// $<arguments>
//		None		
// $<returns> (None)
// $<description>
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Event ue_resize()
This.SetRedraw( false)  //Jervis 05.26.2009 --Temporary add for John's require
of_apply_title_bg_color()
of_apply_logo()
If Isvalid(w_appeon_gifofwait) Then w_appeon_gifofwait.of_setposition(30)
of_create_tabpages()
Post Event ue_refresh_unread_email()
This.SetRedraw( true)  //Jervis 05.26.2009 --Temporary add for John's require




end event

event close;call super::close;If isvalid(inv_FileSrv) Then Destroy inv_FileSrv

//--------------------------- APPEON BEGIN ---------------------------
//$<add> 11.19.2008 By: Ken.Guo
//$<reason> when dashboard menu close, change to mdi menu.
window lw_activesheet
lw_activesheet = w_mdi.GetNextSheet(This)
If Not isvalid(lw_activesheet) Then
	//If no any sheet window.
	If w_mdi.menuname <> 'm_pfe_cst_mdi_menu' Then
		w_mdi.ChangeMenu(m_pfe_cst_mdi_menu)
		w_mdi.of_menu_security( w_mdi.MenuName )
	End If
End If
//---------------------------- APPEON END ----------------------------

end event

event timer;call super::timer;Integer li_cnt,i
u_cst_tabpg_gadget luo_tabpg
li_cnt = Upperbound(tab_dashboard.Control[]) 
If li_cnt < 1 Then Return

//Refresh Clock gadget
For i = 1 To li_cnt
	luo_tabpg = tab_dashboard.Control[i]
	If isvalid(luo_tabpg) Then
		If luo_tabpg.u_gadget_11.visible Then
			luo_tabpg.u_gadget_11.event ue_do()
		End If
	End If
Next

ii_auto_retrieve_i++
If ii_auto_retrieve_i = ii_auto_retrieve_cycle Then
	This.Event ue_retrieve_target_gadgets('u_gadget_4') //For Message Board
	ii_auto_retrieve_i = 0
End If


end event

event closequery;call super::closequery;Return 0 //Added By Ken.Guo 2009-07-06.

/*
//Fixed BugJ042301 -- Jervis 04.24.2009
If Messagebox('Information','Are you sure you want to close the dashboard window?',question!,yesno!) = 1 Then
	return 0
else
	return 1
End If
*/
end event

type tab_dashboard from tab within w_dashboard
event ue_post_open ( )
integer y = 300
integer width = 3191
integer height = 1776
integer taborder = 10
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string pointer = "Arrow!"
long backcolor = 67108864
boolean multiline = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
integer selectedtab = 1
end type

event rightclicked;//////////////////////////////////////////////////////////////////////
// $<event>tab_dashboard::Rightclicked()
// $<arguments>
//		integer	tab-index 
// $<returns> long
// $<description> Pop-up menu when Rightclicked tabpage label. 
//////////////////////////////////////////////////////////////////////
// $<add> 17/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

//Comment it. use MDI 'm_dashboard2' menu replace it.
/* 
m_dashboard_tab lm_dashboard_tab
If index > 0 Then
	lm_dashboard_tab = Create m_dashboard_tab
	If index = 1 Then
		lm_dashboard_tab.m_delete.visible = False
	End If
	This.selecttab(index)
	If UpperBound(This.Control[]) >= 3 Then 
		lm_dashboard_tab.m_add.enabled = False
	End If
	lm_dashboard_tab.Popmenu(PointerX()+This.x + 50,PointerY()+This.y + 50)
End If
*/
end event

event selectionchanged;of_set_tab_bg_color(newindex)
end event

type st_settings from statictext within w_dashboard
boolean visible = false
integer x = 2747
integer y = 216
integer width = 247
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Settings..."
long bordercolor = 67108864
boolean focusrectangle = false
end type

event clicked;Open(w_dashboard_config)
end event

type p_logo from picture within w_dashboard
boolean visible = false
integer width = 192
integer height = 140
boolean originalsize = true
boolean focusrectangle = false
end type

type st_close from statictext within w_dashboard
event ue_close ( )
boolean visible = false
integer x = 3003
integer y = 216
integer width = 192
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
boolean underline = true
string pointer = "HyperLink!"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Close"
long bordercolor = 67108864
boolean focusrectangle = false
end type

event clicked;Parent.event ue_close( )
end event

