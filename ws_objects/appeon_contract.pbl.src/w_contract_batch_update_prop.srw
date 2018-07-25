$PBExportHeader$w_contract_batch_update_prop.srw
forward
global type w_contract_batch_update_prop from w_popup
end type
type st_1 from statictext within w_contract_batch_update_prop
end type
type dw_view from u_dw within w_contract_batch_update_prop
end type
type tab_1 from tab within w_contract_batch_update_prop
end type
type tabpage_datawindow from userobject within tab_1
end type
type dw_1 from u_dw within tabpage_datawindow
end type
type tabpage_datawindow from userobject within tab_1
dw_1 dw_1
end type
type tabpage_text from userobject within tab_1
end type
type dw_2 from u_dw within tabpage_text
end type
type tabpage_text from userobject within tab_1
dw_2 dw_2
end type
type tabpage_field from userobject within tab_1
end type
type dw_5 from u_dw within tabpage_field
end type
type tabpage_field from userobject within tab_1
dw_5 dw_5
end type
type tabpage_window from userobject within tab_1
end type
type dw_3 from u_dw within tabpage_window
end type
type tabpage_window from userobject within tab_1
dw_3 dw_3
end type
type tabpage_tab from userobject within tab_1
end type
type dw_4 from u_dw within tabpage_tab
end type
type tabpage_tab from userobject within tab_1
dw_4 dw_4
end type
type tab_1 from tab within w_contract_batch_update_prop
tabpage_datawindow tabpage_datawindow
tabpage_text tabpage_text
tabpage_field tabpage_field
tabpage_window tabpage_window
tabpage_tab tabpage_tab
end type
type cb_ok from u_cb within w_contract_batch_update_prop
end type
type cb_cancel from u_cb within w_contract_batch_update_prop
end type
type gb_1 from groupbox within w_contract_batch_update_prop
end type
end forward

global type w_contract_batch_update_prop from w_popup
integer x = 1783
integer y = 32
integer width = 1509
integer height = 1608
string title = "Batch Update Screen Properties"
boolean controlmenu = false
boolean minbox = false
boolean maxbox = false
boolean resizable = false
long backcolor = 33551856
boolean center = true
st_1 st_1
dw_view dw_view
tab_1 tab_1
cb_ok cb_ok
cb_cancel cb_cancel
gb_1 gb_1
end type
global w_contract_batch_update_prop w_contract_batch_update_prop

type variables
long	il_SelView

end variables

forward prototypes
public function integer of_verify ()
public function integer of_update ()
public function integer of_createsyntaxobject (long al_data_view_id, datastore ads_screen, ref datastore ads_syntax)
public function integer of_showcolor ()
public function integer of_modifytextproperties (ref datastore ads_syntax, ref string as_objects[])
public function integer of_modifydwproperties (ref datastore ads_syntax)
public function integer of_parsecolor (ref long al_color)
public function long of_modifyfieldproperties (ref datastore ads_syntax, ref string as_objects[])
end prototypes

public function integer of_verify ();integer li_PropCount
DataWindow ldw_data

//////////////////////////////////////////////////////////////////////////
// Check if select view
if IsNull(dw_view.object.data_view_id[1]) then
	MessageBox("Select View", "Please select a view before update properties.")
	dw_view.SetFocus()
	Return -1
end if

//////////////////////////////////////////////////////////////////////////
// Check tabpage 1
ldw_data = tab_1.TabPage_DataWindow.dw_1
ldw_data.AcceptText()

// Titlebar Visible
if ldw_data.object.titlebar_visible_checked[1] = "Y" then
	if IsNull(ldw_data.object.titlebar_visible[1]) then
		tab_1.SelectTab(1)
		MessageBox("Check Null", "Title Bar Visible property can't be null.")
		ldw_data.SetColumn("titlebar_visible")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Titlebar Text
if ldw_data.object.titlebar_text_checked[1] = "Y" then
	if IsNull(ldw_data.object.titlebar_text[1]) or Len(ldw_data.GetItemString(1, "titlebar_text")) = 0 then
		tab_1.SelectTab(1)
		MessageBox("Check Null", "Title Bar Text property can't be null.")
		ldw_data.SetColumn("titlebar_text")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Border Style
if ldw_data.object.boarder_style_checked[1] = "Y" then
	if IsNull(ldw_data.object.boarder_style[1]) then
		tab_1.SelectTab(1)
		MessageBox("Check Null", "Border Style property can't be null.")
		ldw_data.SetColumn("boarder_style")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Background Color
if ldw_data.object.background_color_checked[1] = "Y" then
	if IsNull(ldw_data.object.background_color[1]) then
		tab_1.SelectTab(1)
		MessageBox("Check Null", "Background Color property can't be null.")
		ldw_data.SetColumn("background_color")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

//////////////////////////////////////////////////////////////////////////
// Check tabpage 2
ldw_data = tab_1.TabPage_Text.dw_2
ldw_data.AcceptText()

// Label Text Color
if ldw_data.object.fields_label_textcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_label_textcolor[1]) then
		tab_1.SelectTab(2)
		MessageBox("Check Null", "Label Text Color property can't be null.")
		ldw_data.SetColumn("fields_label_textcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Label Background Color
if ldw_data.object.fields_label_textbkcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_label_textbkcolor[1]) then
		tab_1.SelectTab(2)
		MessageBox("Check Null", "Label Background Color property can't be null.")
		ldw_data.SetColumn("fields_label_textbkcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

//Font Property - jervis 09.22.2011
if  ldw_data.object.font_face_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_height_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_weight_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_italic_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_underline_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_strikethrough_checked[1]  = 'Y' then li_PropCount ++



//////////////////////////////////////////////////////////////////////////
// Check tabpage 3
ldw_data = tab_1.TabPage_Window.dw_3
ldw_data.AcceptText()

// Background Color
if ldw_data.object.background_color_checked[1] = "Y" then
	if IsNull(ldw_data.object.background_color[1]) then
		tab_1.SelectTab(4)
		MessageBox("Check Null", "Background Color property can't be null.")
		ldw_data.SetColumn("background_color")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

//////////////////////////////////////////////////////////////////////////
// Check tabpage 4
ldw_data = tab_1.TabPage_Tab.dw_4
ldw_data.AcceptText()

// Tab Text Color
if ldw_data.object.fields_tab_textcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_tab_textcolor[1]) then
		tab_1.SelectTab(5)
		MessageBox("Check Null", "Tab text color property can't be null.")
		ldw_data.SetColumn("fields_tab_textcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Tab Back Color
if ldw_data.object.fields_tab_backcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_tab_backcolor[1]) then
		tab_1.SelectTab(5)
		MessageBox("Check Null", "Tab back color property can't be null.")
		ldw_data.SetColumn("fields_tab_backcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Page Back Color
if ldw_data.object.fields_page_backcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_page_backcolor[1]) then
		tab_1.SelectTab(5)
		MessageBox("Check Null", "Page back color property can't be null.")
		ldw_data.SetColumn("fields_page_backcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// tab font name
if ldw_data.object.tab_font_name_checked[1] = "Y" then
	if IsNull(ldw_data.object.tab_font_name[1]) or ldw_data.object.tab_font_name[1] = '' then
		tab_1.SelectTab(5)
		MessageBox("Check Null", "Tab font name property can't be null.")
		ldw_data.SetColumn("tab_font_name")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// tab font size
if ldw_data.object.tab_font_height_checked[1] = "Y" then
	if IsNull(ldw_data.object.tab_font_height[1]) then
		tab_1.SelectTab(5)
		MessageBox("Check Null", "Tab font size property can't be null.")
		ldw_data.SetColumn("tab_font_height")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

if  ldw_data.object.tab_font_italic_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.tab_font_underline_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.tab_fixed_width_checked[1]  = 'Y' then li_PropCount ++

//////////////////////////////////////////////////////////////////////////
// Check tabpage 5
ldw_data = tab_1.TabPage_Field.dw_5
ldw_data.AcceptText()

// Border Style
if ldw_data.object.border_style_checked[1] = "Y" then
	if IsNull(ldw_data.object.border_style[1]) then
		tab_1.SelectTab(3)
		MessageBox("Check Null", "Border Style property can't be null.")
		ldw_data.SetColumn("border_style")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Field Text Color
if ldw_data.object.fields_textcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_textcolor[1]) then
		tab_1.SelectTab(3)
		MessageBox("Check Null", "Field text color property can't be null.")
		ldw_data.SetColumn("fields_textcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

// Field Back Color
if ldw_data.object.fields_bkcolor_checked[1] = "Y" then
	if IsNull(ldw_data.object.fields_bkcolor[1]) then
		tab_1.SelectTab(3)
		MessageBox("Check Null", "Field back color property can't be null.")
		ldw_data.SetColumn("fields_bkcolor")
		ldw_data.SetFocus()
		Return -1
	end if
	li_PropCount ++
end if

//Font Property - jervis 09.22.2011
if  ldw_data.object.font_face_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_height_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_weight_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_italic_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_underline_checked[1]  = 'Y' then li_PropCount ++
if  ldw_data.object.font_strikethrough_checked[1]  = 'Y' then li_PropCount ++


//////////////////////////////////////////////////////////////////////////
// Check need updated property count
if li_PropCount = 0 then
	MessageBox("Update", "There is no property need to update.")
	Return -1
end if

Return 1

end function

public function integer of_update ();long ll_Row
long ll_RowCount
long ll_screen_id
long ll_data_view_id
long ll_default_view_id
long ll_ScreenHandle
string ls_UpdateSQL
string ls_Syntax
string ls_Screen1_Syntax
string ls_Screen2_Syntax
string ls_ObjectsStr
string ls_Objects[]
datetime ldt_modify_date
boolean lb_Execute
n_ds lds_Screen
n_ds lds_Syntax
datastore lds_screen_old
n_ds lds_Selected_Tabpage
DataWindowChild ldwc_view
n_cst_string lnv_string

String	ls_Tabpage_Name,ls_Tabpage_Text,ls_fixfield,ls_opsql,ls_lookuplist
Boolean	lb_UpdateTabTextColor,lb_UpdateTabBackColor,lb_UpdatePageBackColor

string	ls_ScreenStyle

///////////////////////////////[Update datawindow and window control properties]//////////////////////////
// Update datawindow control properties (titlebar_visible,titlebar_text,boarder_style)
// Datawindow control properties
lb_Execute = false
ls_UpdateSQL = "UPDATE ctx_screen SET "
if tab_1.TabPage_DataWindow.dw_1.object.titlebar_visible_checked[1] = "Y" then
	ls_UpdateSQL += "titlebar_visible = '" + tab_1.TabPage_DataWindow.dw_1.object.titlebar_visible[1] + "' "
	lb_Execute = true
end if
if tab_1.TabPage_DataWindow.dw_1.object.titlebar_text_checked[1] = "Y" then
	if lb_Execute then ls_UpdateSQL += ", "				//Added by Scofield on 2009-08-10
	ls_UpdateSQL += "titlebar_text = '" + tab_1.TabPage_DataWindow.dw_1.object.titlebar_text[1] + "' "
	lb_Execute = true
end if
if tab_1.TabPage_DataWindow.dw_1.object.boarder_style_checked[1] = "Y" then
	if lb_Execute then ls_UpdateSQL += ", "				//Added by Scofield on 2009-08-10
	ls_UpdateSQL += "boarder_style = '" + tab_1.TabPage_DataWindow.dw_1.object.boarder_style[1] + "' "
	lb_Execute = true
end if
ll_data_view_id = dw_view.object.data_view_id[1]
ls_UpdateSQL += "WHERE data_view_id = " + String(ll_data_view_id) + "; "
if not lb_Execute then ls_UpdateSQL = ""
// Window properties
if tab_1.TabPage_Window.dw_3.object.background_color_checked[1] = "Y" then
	ls_UpdateSQL += "UPDATE data_view SET win_backcolor = " + String(tab_1.TabPage_Window.dw_3.object.background_color[1])
	ls_UpdateSQL += " WHERE data_view_id = " + String(ll_data_view_id) + "; "
	lb_Execute = true
end if

if lb_Execute then
	SetNull(gnv_win_backcolor.il_win_backcolor)
	gnv_appeondb.of_StartQueue()
	EXECUTE IMMEDIATE :ls_UpdateSQL;
	COMMIT;
	SELECT data_view.win_backcolor INTO :gnv_win_backcolor.il_win_backcolor
	FROM  security_users, data_view
	WHERE data_view.data_view_id = security_users.contract_default_view AND
			security_users.user_id = :gs_user_id;
	gnv_appeondb.of_CommitQueue()
end if

//Added By Ken.Guo 2009-07-10. Refresh data view
If tab_1.TabPage_Window.dw_3.object.background_color_checked[1] = "Y" Then
	gnv_data.of_retrieve('data_view')
End If

///////////////////////////////[Update datawindow properties]////////////////////////////////
// Determine if update datawindow properties
lb_Execute = false
if tab_1.TabPage_DataWindow.dw_1.object.background_color_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.fields_label_textcolor_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.fields_label_textbkcolor_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.border_style_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.fields_textcolor_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.fields_bkcolor_checked[1] = "Y" then lb_Execute = true

//Font Property - jervis 09.22.2011
if tab_1.TabPage_Text.dw_2.object.font_face_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.font_height_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.font_weight_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.font_italic_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.font_underline_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Text.dw_2.object.font_strikethrough_checked[1] = "Y" then lb_Execute = true

if tab_1.TabPage_Field.dw_5.object.font_face_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.font_height_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.font_weight_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.font_italic_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.font_underline_checked[1] = "Y" then lb_Execute = true
if tab_1.TabPage_Field.dw_5.object.font_strikethrough_checked[1] = "Y" then lb_Execute = true



if lb_Execute then
	// Create screen datatore
	lds_Syntax = Create n_ds
	lds_Screen = Create n_ds
	lds_Screen.DataObject = "ds_contract_data_view_screens_list"   //modified by gavins 20120912     remove  dw_sql grid_sql updated capability
	lds_Screen.SetTransObject(SQLCA)
	ll_RowCount = lds_Screen.Retrieve(ll_data_view_id)
	ldt_modify_date = DateTime(Today(), Now())
	
	// Modify datawindow object properties
	for ll_Row = 1 to ll_RowCount	
		// Create syntax datatore
		lds_screen.SetRow(ll_Row)
		If of_CreateSyntaxObject(ll_data_view_id, lds_Screen, lds_Syntax) < 0 Then Return -1
	
		//	Parse dwo name to array
		ls_ObjectsStr = lds_Syntax.Describe("datawindow.objects")
		lnv_string.of_ParseToArray(ls_ObjectsStr, "~t", ls_Objects[])
	
		// Modify datawindow object properties
		of_ModifyDWProperties(lds_Syntax)
		
		// Modify text object properties
		of_ModifyTextProperties(lds_Syntax, ls_Objects[])
		
		// Modify field object properties
		of_ModifyFieldProperties(lds_Syntax, ls_Objects[])		//Added by Scofield on 2009-08-25
			
		// Reset datawindow syntax
		ls_Syntax = lds_syntax.object.datawindow.syntax
		ll_screen_id = lds_screen.object.screen_id[ll_Row]
//		choose case ll_screen_id //code commented by  Scofield on 2009-04-15
//			case 1
//				ls_Screen1_Syntax = ls_Syntax
//			case 2
//				ls_Screen2_Syntax = ls_Syntax
//		end choose	
		
		ls_ScreenStyle = lds_screen.object.screen_style[ll_Row] //added by gavins 20120313 grid
		
		//Added By Ken.Guo 01/07/2012. 		
		ls_fixfield = lds_screen.GetItemString(ll_row,'fix_field')
		gf_get_opsyntax(ls_Syntax,ls_fixfield,ls_opsql,ls_lookuplist)  
		If ls_ScreenStyle = 'G' Then//added by gavins 20120313 grid
			lds_Screen.SetItem(ll_Row, "grid_opsql", ls_opsql) 		
		
			lds_Screen.SetItem(ll_Row, "grid_sql", ls_Syntax)
			Update ctx_screen  set grid_opsql = :ls_opsql, grid_sql = :ls_Syntax where data_view_id = :ll_data_view_id and screen_id = :ll_screen_id;  //added by gavins 20120919
		Else
			lds_Screen.SetItem(ll_Row, "dw_opsql", ls_opsql) 		
			
			lds_Screen.SetItem(ll_Row, "dw_sql", ls_Syntax)
			Update ctx_screen  set dw_opsql = :ls_opsql, dw_sql = :ls_Syntax where data_view_id = :ll_data_view_id and screen_id = :ll_screen_id;
		End If
		lds_Screen.SetItem(ll_Row, "modify_date", ldt_modify_date)
	next
	
	lds_Screen.Update()
	
	////Commented By Ken.Guo 2009-07-10. Every view will use itself screen #1 and Screen #2.
	//// Update datawindow syntax to database for Search Tabpage when modify the System Default View
	//select TOP 1 data_view_id into :ll_default_view_id from data_view where type_c = 'C' and data_view_name = 'Default System View';
	//
	////if il_SelView = ll_default_view_id then		//Commented by Scofield on 2009-04-15
	//	gnv_appeondb.of_StartQueue()
	//	dw_view.GetChild("data_view_id", ldwc_view)
	//	ll_RowCount = ldwc_view.RowCount()
	//	for ll_Row = 1 to ll_RowCount
	//		ll_data_view_id = ldwc_view.GetItemNumber(ll_Row, "data_view_id")
	//		UPDATE ctx_screen SET dw_sql = :ls_Screen1_Syntax, modify_date = :ldt_modify_date WHERE data_view_id = :ll_data_view_id AND screen_id = 1;
	//		UPDATE ctx_screen SET dw_sql = :ls_Screen2_Syntax, modify_date = :ldt_modify_date WHERE data_view_id = :ll_data_view_id AND screen_id = 2;
	//	next
	//	gnv_appeondb.of_CommitQueue()
	////end if
	
	Commit;
	
	// Datawindow syntax synchronization
	if IsValid(w_contract_data_design) and il_SelView = w_contract_data_design.uo_design.il_data_view_id then
		lds_screen_old = w_contract_data_design.uo_design.uo_select.tv_screen.ids_data
		lds_screen_old.SetFilter("")
		lds_screen_old.Filter()
		lds_screen_old.Reset()
		If lds_Screen.RowsCopy(1, lds_Screen.RowCount(), Primary!, lds_screen_old, 1, Primary!) <> 1 Then //modified by gavins 20120919
			gnv_debug.of_output( true, 'RowsCopy is failure from lds_screen to lds_screen_old!' )
		End If
		lds_screen_old.ResetUpdate()
	end if
	
	//Refresh current screen
	ll_ScreenHandle = w_contract_data_design.uo_design.of_GetCurrentScreenHandle()
	w_contract_data_design.uo_design.uo_select.Event ue_SelectionChanged(0, ll_ScreenHandle)
	
	Destroy lds_Syntax
	Destroy lds_Screen
	
end if

//BEGIN---Added by Scofield on 2009-08-21
// Tab Properties
long	ll_Cycle,ll_Cnts
long	ll_tab_textcolor = 33554432
long	ll_tab_backcolor = 67108864
long	ll_page_backcolor = 67108864

if tab_1.TabPage_Tab.dw_4.object.fields_tab_textcolor_checked[1] = "Y" then
	ll_tab_textcolor = tab_1.TabPage_Tab.dw_4.object.fields_tab_textcolor[1]
	lb_UpdateTabTextColor = true
end if

if tab_1.TabPage_Tab.dw_4.object.fields_tab_backcolor_checked[1] = "Y" then
	ll_tab_backcolor = tab_1.TabPage_Tab.dw_4.object.fields_tab_backcolor[1]
	lb_UpdateTabBackColor = true
end if

if tab_1.TabPage_Tab.dw_4.object.fields_page_backcolor_checked[1] = "Y" then
	ll_page_backcolor = tab_1.TabPage_Tab.dw_4.object.fields_page_backcolor[1]
	lb_UpdatePageBackColor = true
end if

if lb_UpdateTabTextColor or lb_UpdateTabBackColor or lb_UpdatePageBackColor then
	lds_Selected_Tabpage = Create n_ds
	lds_Selected_Tabpage.DataObject = "d_selected_tabpage_for_view"
	lds_Selected_Tabpage.SetTransObject(SQLCA)
	lds_Selected_Tabpage.Retrieve(ll_data_view_id)
	
	ll_Cnts = lds_Selected_Tabpage.RowCount()
	for ll_Cycle = 1 to ll_Cnts
		ls_Tabpage_Name = lds_Selected_Tabpage.GetItemString(ll_Cycle,"tabpage_name")
		ls_Tabpage_Text = lds_Selected_Tabpage.GetItemString(ll_Cycle,"tabpage_text")
		
		SELECT Count(*) INTO :ll_RowCount FROM ctx_tabpage_properties WHERE data_view_id = :ll_data_view_id AND tabpage_name = :ls_Tabpage_Name;
		
		gnv_appeondb.of_StartQueue()
		if ll_RowCount <= 0 then
			INSERT INTO ctx_tabpage_properties(data_view_id,tabpage_name,text,text_color,icon_visible,backcolor,tab_backcolor)
				  VALUES (:ll_data_view_id,:ls_Tabpage_Name,:ls_Tabpage_Text,:ll_tab_textcolor,'T',:ll_page_backcolor,:ll_tab_backcolor);
		else
			if lb_UpdateTabTextColor then
				UPDATE ctx_tabpage_properties SET text_color = :ll_tab_textcolor WHERE data_view_id = :ll_data_view_id AND tabpage_name = :ls_Tabpage_Name;
			end if
			if lb_UpdateTabBackColor then
				UPDATE ctx_tabpage_properties SET tab_backcolor = :ll_tab_backcolor WHERE data_view_id = :ll_data_view_id AND tabpage_name = :ls_Tabpage_Name;
			end if
			if lb_UpdatePageBackColor then
				UPDATE ctx_tabpage_properties SET backcolor = :ll_page_backcolor	WHERE data_view_id = :ll_data_view_id AND tabpage_name = :ls_Tabpage_Name;
			end if
		end if
		gnv_appeondb.of_CommitQueue()
	next
	COMMIT;
	Destroy lds_Selected_Tabpage
end if

//END---Added by Scofield on 2009-08-21

string				ls_fontname, ls_value//added by gavins 20130415

lb_Execute = false
if tab_1.TabPage_Tab.dw_4.object.tab_font_name_checked[1] = "Y" then
	ls_fontname = tab_1.TabPage_Tab.dw_4.object.tab_font_name[1]
	gnv_user_option.of_set_viewid_option_value( ll_data_view_id, 'View_Tab_Font_Name_Properties' ,ls_FontName )
	lb_Execute = true
end if


if tab_1.TabPage_Tab.dw_4.object.tab_font_italic_checked[1] = "Y" then
	ls_value = tab_1.TabPage_Tab.dw_4.object.tab_font_italic[1]
	gnv_user_option.of_set_viewid_option_value( ll_data_view_id, 'View_Tab_Font_Italic_Properties' ,ls_value )
	lb_Execute = true
end if


if tab_1.TabPage_Tab.dw_4.object.tab_font_underline_checked[1] = "Y" then
	ls_value = tab_1.TabPage_Tab.dw_4.object.tab_font_underline[1]
	gnv_user_option.of_set_viewid_option_value( ll_data_view_id, 'View_Tab_Font_Underline_Properties' ,ls_value )
	lb_Execute = true	
end if

if tab_1.TabPage_Tab.dw_4.object.tab_font_height_checked[1] = "Y" then
	ls_value = String( tab_1.TabPage_Tab.dw_4.object.tab_font_height[1] )
	gnv_user_option.of_set_viewid_option_value( ll_data_view_id, 'View_Tab_Font_Height_Properties' , ls_value  )
	lb_Execute = true	
end if

if tab_1.TabPage_Tab.dw_4.object.tab_fixed_width_checked[1] = "Y" then
	ls_value = tab_1.TabPage_Tab.dw_4.object.tab_fixed_width[1]
	gnv_user_option.of_set_viewid_option_value( ll_data_view_id, 'View_Tab_Fixed_Width_Properties' ,ls_value )
	lb_Execute = true	
end if
If 	lb_Execute Then
	gnv_user_option.of_viewid_save( )
End If

Return 1

end function

public function integer of_createsyntaxobject (long al_data_view_id, datastore ads_screen, ref datastore ads_syntax);long   ll_Row
long   ll_screen_id
long   ll_dw_sql_len
string ls_Syntax, ls_ScreenStyle
string ls_Error

ll_Row = ads_Screen.GetRow()
if ll_Row <= 0 then Return -1

ls_ScreenStyle = ads_Screen.GetItemString(ll_Row, "screen_style") //added by gavins 20120313 grid
// Get datawindow syntax
if AppeongetClientType() = 'PB' then
	ll_screen_id = ads_Screen.GetItemNumber(ll_Row, "screen_id")
	If ls_ScreenStyle = 'G' Then
		ll_dw_sql_len = ads_Screen.GetItemNumber(ll_Row, "grid_sql_len")
	Else
		ll_dw_sql_len = ads_Screen.GetItemNumber(ll_Row, "dw_sql_len")
	End If
	
	if ll_dw_sql_len > 32766 then
		If ls_ScreenStyle = 'G' Then
			ls_Syntax = f_get_screen_gridsql(al_data_view_id, ll_screen_id,false)
		Else
			ls_Syntax = f_get_screen_sql(al_data_view_id, ll_screen_id,false)  //add false argu - jervis 10.11.2011
		End If
	else
		If ls_ScreenStyle = 'G' Then
			ls_Syntax = ads_Screen.GetItemString(ll_Row, "grid_sql")
		Else
			ls_Syntax = ads_Screen.GetItemString(ll_Row, "dw_sql")
		End If
	end if
else
	If ls_ScreenStyle = 'G' Then
		ls_Syntax = ads_Screen.GetItemString(ll_Row, "grid_sql")
	Else
		ls_Syntax = ads_Screen.GetItemString(ll_Row, "dw_sql")
	End If
end if

// Dynamic create datawindow with syntax
ads_Syntax.Create(ls_Syntax, ls_Error)
if Len(ls_Error) > 0 then 
	MessageBox( 'Batch Update', 'Failed to create datawindow!' + string( al_data_view_id ) + "--" + string( ll_screen_id ) + "--" + ls_Error )
	Return -1
End If

Return 1
end function

public function integer of_showcolor ();datawindow ldw_Prop

// Show datawindow color
ldw_Prop = tab_1.TabPage_DataWindow.dw_1
ldw_Prop.AcceptText()
if IsNull(ldw_Prop.object.background_color[1]) then
	ldw_Prop.object.t_background_color.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_background_color.background.color = ldw_Prop.object.background_color[1]
end if

// Show fields label color
ldw_Prop = tab_1.TabPage_Text.dw_2
ldw_Prop.AcceptText()
if IsNull(ldw_Prop.object.fields_label_textcolor[1]) then
	ldw_Prop.object.t_fields_label_textcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_fields_label_textcolor.background.color = ldw_Prop.object.fields_label_textcolor[1]
end if
if IsNull(ldw_Prop.object.fields_label_textbkcolor[1]) then
	ldw_Prop.object.t_fields_label_textbkcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_fields_label_textbkcolor.background.color = ldw_Prop.object.fields_label_textbkcolor[1]
end if

// Show window color
ldw_Prop = tab_1.TabPage_Window.dw_3
ldw_Prop.AcceptText()
if IsNull(ldw_Prop.object.background_color[1]) then
	ldw_Prop.object.t_background_color.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_background_color.background.color = ldw_Prop.object.background_color[1]
end if

//BEGIN---Modify by Scofield on 2009-08-21
// Show Tab color
ldw_Prop = tab_1.TabPage_Tab.dw_4
ldw_Prop.AcceptText()
if IsNull(ldw_Prop.object.fields_tab_textcolor[1]) then
	ldw_Prop.object.t_tab_textcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_tab_textcolor.background.color = ldw_Prop.object.fields_tab_textcolor[1]
end if
if IsNull(ldw_Prop.object.fields_tab_backcolor[1]) then
	ldw_Prop.object.t_tab_backcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_tab_backcolor.background.color = ldw_Prop.object.fields_tab_backcolor[1]
end if
if IsNull(ldw_Prop.object.fields_page_backcolor[1]) then
	ldw_Prop.object.t_page_backcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_page_backcolor.background.color = ldw_Prop.object.fields_page_backcolor[1]
end if
//END---Modify by Scofield on 2009-08-21

//BEGIN---Modify by Scofield on 2009-08-26
// Show fields color
ldw_Prop = tab_1.tabpage_field.dw_5
ldw_Prop.AcceptText()
if IsNull(ldw_Prop.object.fields_textcolor[1]) then
	ldw_Prop.object.t_fields_textcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_fields_textcolor.background.color = ldw_Prop.object.fields_textcolor[1]
end if
if IsNull(ldw_Prop.object.fields_bkcolor[1]) then
	ldw_Prop.object.t_fields_bkcolor.background.color = RGB(255,255,255)
else
	ldw_Prop.object.t_fields_bkcolor.background.color = ldw_Prop.object.fields_bkcolor[1]
end if
//END---Modify by Scofield on 2009-08-26

Return 1

end function

public function integer of_modifytextproperties (ref datastore ads_syntax, ref string as_objects[]);string  ls_Modify
integer i, li_ObjectCount
long ll_fields_label_textcolor
long ll_fields_label_textbkcolor
string ls_fields_label_textcolor_checked
string ls_fields_label_textbkcolor_checked
string ls_face,ls_size,ls_blob,ls_italic,ls_under,ls_thrickeout
datawindow ldw_properties

// Get object count
li_ObjectCount = UpperBound(as_Objects[])

// Get text object property value
ldw_properties = tab_1.TabPage_Text.dw_2
ll_fields_label_textcolor = ldw_properties.object.fields_label_textcolor[1]
ll_fields_label_textbkcolor = ldw_properties.object.fields_label_textbkcolor[1]
ls_fields_label_textcolor_checked = ldw_properties.object.fields_label_textcolor_checked[1]
ls_fields_label_textbkcolor_checked = ldw_properties.object.fields_label_textbkcolor_checked[1]
ls_face =  ldw_properties.object.font_face_checked[1] 
ls_size = ldw_properties.object.font_height_checked[1]
ls_blob =ldw_properties.object.font_weight_checked[1]
ls_italic = ldw_properties.object.font_italic_checked[1]
ls_under =  ldw_properties.object.font_underline_checked[1]
ls_thrickeout =  ldw_properties.object.font_strikethrough_checked[1]
if ls_fields_label_textcolor_checked = "Y" or ls_fields_label_textbkcolor_checked = "Y" or ls_face = 'Y' or ls_size = 'Y' or ls_blob = 'Y' or ls_italic = 'Y' or ls_under = 'Y' or ls_thrickeout = 'Y' then
else
	Return 0
end if

// Modify text object properties
for i = 1 to li_ObjectCount
	if ads_Syntax.Describe(as_Objects[i] + ".type") = "text" then
		ls_Modify = ""
		if ls_fields_label_textcolor_checked = "Y" then
			ls_Modify = as_Objects[i] + ".color = '" + String(ll_fields_label_textcolor) + "' "
		end if
		if ls_fields_label_textbkcolor_checked = "Y" then
			ls_Modify += as_Objects[i] + ".background.mode='2' "
			ls_Modify += as_Objects[i] + ".background.color = '" + String(ll_fields_label_textbkcolor) + "' "
		end if
		
		//add font properties - jervis 09.07.2011
		if ls_face= 'Y' then
			ls_Modify += as_Objects[i] + ".font.face = '" + ldw_properties.GetItemString(1,'font_face') + "' "
		end if
		//Added By mark 04/11/12 fixed bug
//		if ls_size = 'Y' then
//			ls_Modify += as_Objects[i] + ".font.height = -'" + String(ldw_properties.GetItemNumber(1,'font_height')) + "' "
//		end if
		if ls_size = 'Y' then
			ls_Modify += as_Objects[i] + ".font.height = '-" + String(ldw_properties.GetItemNumber(1,'font_height')) + "' "
		end if
		
		if ls_blob = 'Y' then
			ls_Modify += as_Objects[i] + ".font.weight = '" + ldw_properties.GetItemString(1,'font_weight') + "' "
		end if
		
		if ls_italic = 'Y' then
			ls_Modify += as_Objects[i] + ".font.italic = '" + ldw_properties.GetItemString(1,'font_italic') + "' "
		end if
		
		if ls_under = 'Y' then
			ls_Modify += as_Objects[i] + ".font.underline = '" + ldw_properties.GetItemString(1,'font_underline') + "' "
		end if
		
		if ls_thrickeout = 'Y' then
			ls_Modify += as_Objects[i] + ".font.strikethrough = '" + ldw_properties.GetItemString(1,'font_strikethrough') + "' "
		end if
		if Len(ls_Modify) > 0 then ads_Syntax.Modify(ls_Modify)
	end if
next

Return 1
end function

public function integer of_modifydwproperties (ref datastore ads_syntax);string ls_Modify
long ll_background_color
string ls_background_color_checked
datawindow ldw_properties

// Get datawindow object property value
ldw_properties = tab_1.TabPage_DataWindow.dw_1
ll_background_color = ldw_properties.object.background_color[1]
ls_background_color_checked = ldw_properties.object.background_color_checked[1]
if ls_background_color_checked = "Y" then
else
	Return 0
end if

// Modify datawindow object properties
ls_Modify = "datawindow.color = '" + String(ll_background_color) + "' "
ads_Syntax.Modify(ls_Modify)

Return 1
end function

public function integer of_parsecolor (ref long al_color);if IsNull(al_Color) or al_Color = 33554432 then
	al_Color = RGB(0,0,0)
elseif al_Color = 67108864 then
	al_Color = RGB(212,208,200)
end if

Return 1
end function

public function long of_modifyfieldproperties (ref datastore ads_syntax, ref string as_objects[]);//====================================================================
// Function: of_ModifyFieldProperties()
//--------------------------------------------------------------------
// Description:
//--------------------------------------------------------------------
// Arguments:
// 	reference    datastore    ads_Syntax
// 	reference    string       as_Objects[]
//--------------------------------------------------------------------
// Returns:  long
//--------------------------------------------------------------------
// Author:	Scofield		Date: 2009-08-25
//--------------------------------------------------------------------
//	Copyright (c) 1999-2009 Contractlogix, All rights reserved.
//--------------------------------------------------------------------
// Modify History:
//
//====================================================================

String	ls_Modify,ls_border_style_checked,ls_border_style,ls_Type
String	ls_fields_textcolor_checked,ls_fields_bkcolor_checked
long		ll_fields_textcolor,ll_fields_bkcolor
long		ll_Cycle,ll_ObjCnt
string ls_face,ls_size,ls_blob,ls_italic,ls_under,ls_thrickeout
string ls_band

DataWindow ldw_Properties

// Get field object property value
ldw_Properties = tab_1.TabPage_Field.dw_5

ls_border_style_checked = ldw_Properties.object.border_style_checked[1]
ls_border_style = ldw_Properties.object.border_style[1]

ls_fields_textcolor_checked = ldw_Properties.object.fields_textcolor_checked[1]
ll_fields_textcolor = ldw_Properties.object.fields_textcolor[1]

ls_fields_bkcolor_checked = ldw_Properties.object.fields_bkcolor_checked[1]
ll_fields_bkcolor = ldw_Properties.object.fields_bkcolor[1]

ls_face =  ldw_properties.object.font_face_checked[1] 
ls_size = ldw_properties.object.font_height_checked[1]
ls_blob =ldw_properties.object.font_weight_checked[1]
ls_italic = ldw_properties.object.font_italic_checked[1]
ls_under =  ldw_properties.object.font_underline_checked[1]
ls_thrickeout =  ldw_properties.object.font_strikethrough_checked[1]

if ls_border_style_checked <> "Y" and ls_fields_textcolor_checked <> "Y" and ls_fields_bkcolor_checked <> "Y" and ls_face = 'Y' and ls_size = 'Y' and ls_blob = 'Y' and ls_italic = 'Y' and ls_under = 'Y' and ls_thrickeout = 'Y'  then Return 0

// Get object count
ll_ObjCnt = UpperBound(as_Objects[])

// Modify field object properties
for ll_Cycle = 1 to ll_ObjCnt
	ls_Type = ads_Syntax.Describe(as_Objects[ll_Cycle] + ".type")
	if ls_Type = "column" or ls_Type = "compute" then
		ls_Modify = ""
		
		if ls_border_style_checked = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".Border = '" + String(ls_border_style) + "' "
		end if
		
		if ls_fields_textcolor_checked = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".Color = '" + String(ll_fields_textcolor) + "' "
		end if
		
		if ls_fields_bkcolor_checked = 'Y' then
			ls_band = ads_Syntax.Describe(as_Objects[ll_Cycle] + ".band")
			if pos(ls_band ,'header.1') = 0 then //jervis 08.31.2009 - the backgrounds of the Category of the profile detail are not changed
				ls_Modify += as_Objects[ll_Cycle] + ".Background.Mode = '2' "
				ls_Modify += as_Objects[ll_Cycle] + ".Background.Color = '" + String(ll_fields_bkcolor) + "' "
			end if
		end if
		
		//add font properties - jervis 09.07.2011
		if ls_face = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.face = '" + ldw_properties.GetItemString(1,'font_face') + "' "
		end if
		
		//Added By mark 04/11/12 fixed bug
//		if ls_size = 'Y' then
//			ls_Modify += as_Objects[ll_Cycle] + ".font.height = -'" + String(ldw_properties.GetItemNumber(1,'font_height')) + "' "
//		end if
		if ls_size = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.height = '-" + String(ldw_properties.GetItemNumber(1,'font_height')) + "' "
		end if
		
		if ls_blob = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.weight = '" + ldw_properties.GetItemString(1,'font_weight') + "' "
		end if
		
		if ls_italic = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.italic = '" + ldw_properties.GetItemString(1,'font_italic') + "' "
		end if
		
		if ls_under = 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.underline = '" + ldw_properties.GetItemString(1,'font_underline') + "' "
		end if
		
		if ls_thrickeout= 'Y' then
			ls_Modify += as_Objects[ll_Cycle] + ".font.strikethrough = '" + ldw_properties.GetItemString(1,'font_strikethrough') + "' "
		end if
		
		
		ads_Syntax.Modify(ls_Modify)
	end if
next

Return 1

end function

on w_contract_batch_update_prop.create
int iCurrent
call super::create
this.st_1=create st_1
this.dw_view=create dw_view
this.tab_1=create tab_1
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.dw_view
this.Control[iCurrent+3]=this.tab_1
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
this.Control[iCurrent+6]=this.gb_1
end on

on w_contract_batch_update_prop.destroy
call super::destroy
destroy(this.st_1)
destroy(this.dw_view)
destroy(this.tab_1)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.gb_1)
end on

event closequery;//override
end event

type st_1 from statictext within w_contract_batch_update_prop
integer x = 32
integer y = 76
integer width = 494
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Please Select a View:"
boolean focusrectangle = false
end type

type dw_view from u_dw within w_contract_batch_update_prop
event ue_dddwdelete ( long al_data_view_id )
integer x = 517
integer y = 52
integer width = 955
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_select_views_dddw_list_contract"
boolean vscrollbar = false
boolean border = false
borderstyle borderstyle = stylebox!
end type

event constructor;// Retrieve views
this.of_SetTransObject(SQLCA)
this.of_SetUpdateAble(false)
this.InsertRow(0)

il_SelView = w_contract_data_design.uo_design.il_data_view_id
this.SetItem(1, "data_view_id", il_SelView)

end event

event itemchanged;call super::itemchanged;il_SelView = Long(data)

end event

type tab_1 from tab within w_contract_batch_update_prop
event create ( )
event destroy ( )
integer x = 69
integer y = 284
integer width = 1358
integer height = 1056
integer taborder = 10
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
tabpage_datawindow tabpage_datawindow
tabpage_text tabpage_text
tabpage_field tabpage_field
tabpage_window tabpage_window
tabpage_tab tabpage_tab
end type

on tab_1.create
this.tabpage_datawindow=create tabpage_datawindow
this.tabpage_text=create tabpage_text
this.tabpage_field=create tabpage_field
this.tabpage_window=create tabpage_window
this.tabpage_tab=create tabpage_tab
this.Control[]={this.tabpage_datawindow,&
this.tabpage_text,&
this.tabpage_field,&
this.tabpage_window,&
this.tabpage_tab}
end on

on tab_1.destroy
destroy(this.tabpage_datawindow)
destroy(this.tabpage_text)
destroy(this.tabpage_field)
destroy(this.tabpage_window)
destroy(this.tabpage_tab)
end on

type tabpage_datawindow from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1321
integer height = 940
long backcolor = 33551856
string text = "DataWindow"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
dw_1 dw_1
end type

on tabpage_datawindow.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on tabpage_datawindow.destroy
destroy(this.dw_1)
end on

type dw_1 from u_dw within tabpage_datawindow
integer x = 9
integer y = 16
integer width = 1298
integer height = 912
integer taborder = 11
string dataobject = "d_contract_dw_properties_batch"
end type

event constructor;call super::constructor;this.InsertRow(0)
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

event buttonclicked;call super::buttonclicked;long ll_Color

this.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_bk_color"
		ll_Color = this.object.background_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.SetColumn("background_color")
			this.object.background_color[Row] = ll_Color
			this.Event ItemChanged(Row, this.object.background_color, String(ll_Color))
		end if
	case "b_bk_color_def"
		this.SetColumn("background_color")
		this.object.background_color[Row] = 67108864
		this.Event ItemChanged(Row, this.object.background_color, "67108864")
end choose
end event

event itemchanged;call super::itemchanged;if dwo.name = "background_color" then
	of_ShowColor()
end if
end event

type tabpage_text from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1321
integer height = 940
long backcolor = 33551856
string text = "Text"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
dw_2 dw_2
end type

on tabpage_text.create
this.dw_2=create dw_2
this.Control[]={this.dw_2}
end on

on tabpage_text.destroy
destroy(this.dw_2)
end on

type dw_2 from u_dw within tabpage_text
integer x = 9
integer y = 16
integer width = 1298
integer height = 912
integer taborder = 11
string dataobject = "d_contract_text_properties_batch"
boolean vscrollbar = false
end type

event constructor;call super::constructor;this.InsertRow(0)

This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

event buttonclicked;call super::buttonclicked;long ll_Color

this.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = this.object.fields_label_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textcolor[Row] = ll_Color
			this.SetColumn("fields_label_textcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		this.object.fields_label_textcolor[Row] = 33554432
		this.SetColumn("fields_label_textcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textcolor, "33554432")
	
	case "b_text_bk_color"
		ll_Color = this.object.fields_label_textbkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.object.fields_label_textbkcolor[Row] = ll_Color
			this.SetColumn("fields_label_textbkcolor")
			this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, String(ll_Color))
		end if
	case "b_text_bk_color_def"
		this.object.fields_label_textbkcolor[Row] = 67108864
		this.SetColumn("fields_label_textbkcolor")
		this.Event ItemChanged(Row, this.object.fields_label_textbkcolor, "67108864")
	case 'b_fontface_def'
		this.SetItem( row,"font_face","Segoe UI")
		this.event itemChanged(row,this.object.font_face,"Segoe UI")
	case 'b_fontheight_def'
		this.SetItem( row,"font_height",8)
		this.event itemchanged( row,this.object.font_height,'8')
end choose
end event

event itemchanged;call super::itemchanged;choose case dwo.name 
	case "fields_label_textcolor", "fields_label_textbkcolor"
		of_ShowColor()
end choose

end event

type tabpage_field from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1321
integer height = 940
long backcolor = 79680469
string text = "Field"
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
dw_5 dw_5
end type

on tabpage_field.create
this.dw_5=create dw_5
this.Control[]={this.dw_5}
end on

on tabpage_field.destroy
destroy(this.dw_5)
end on

type dw_5 from u_dw within tabpage_field
integer x = 9
integer y = 16
integer width = 1298
integer height = 912
integer taborder = 20
string dataobject = "d_contract_field_properties_batch"
boolean vscrollbar = false
end type

event constructor;This.InsertRow(0)

This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("font_face",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if

end event

event losefocus;This.AcceptText()
end event

event buttonclicked;call super::buttonclicked;long ll_Color

This.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_text_color"
		ll_Color = This.object.fields_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_textcolor[Row] = ll_Color
			This.SetColumn("fields_textcolor")
			This.Event ItemChanged(Row, This.object.fields_textcolor, String(ll_Color))
		end if
	case "b_text_color_def"
		This.object.fields_textcolor[Row] = 0
		This.SetColumn("fields_textcolor")
		This.Event ItemChanged(Row, This.object.fields_textcolor, "0")
	case "b_bk_color"
		ll_Color = This.object.fields_bkcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_bkcolor[Row] = ll_Color
			This.SetColumn("fields_bkcolor")
			This.Event ItemChanged(Row, This.object.fields_bkcolor, String(ll_Color))
		end if
	case "b_bk_color_def"
		This.object.fields_bkcolor[Row] = 16777215
		This.SetColumn("fields_bkcolor")
		This.Event ItemChanged(Row, This.object.fields_bkcolor, "16777215")
	case 'b_fontface_def'
		this.SetItem( row,"font_face","Segoe UI")
		this.event itemChanged(row,this.object.font_face,"Segoe UI")
	case 'b_fontheight_def'
		this.SetItem( row,"font_height",8)
		this.event itemchanged( row,this.object.font_height,'8')
end choose

end event

event itemchanged;call super::itemchanged;choose case dwo.name 
	case "fields_textcolor", "fields_bkcolor"
		of_ShowColor()
end choose

end event

type tabpage_window from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1321
integer height = 940
long backcolor = 33551856
string text = "Window"
long tabtextcolor = 33554432
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
dw_3 dw_3
end type

on tabpage_window.create
this.dw_3=create dw_3
this.Control[]={this.dw_3}
end on

on tabpage_window.destroy
destroy(this.dw_3)
end on

type dw_3 from u_dw within tabpage_window
integer x = 9
integer y = 16
integer width = 1298
integer height = 912
integer taborder = 10
string dataobject = "d_contract_win_properties_batch"
end type

event buttonclicked;call super::buttonclicked;long ll_Color

this.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_bk_color"
		ll_Color = this.object.background_color[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			this.SetColumn("background_color")
			this.object.background_color[Row] = ll_Color
			this.Event ItemChanged(Row, this.object.background_color, String(ll_Color))
		end if
	case "b_bk_color_def"
		this.SetColumn("background_color")
		this.object.background_color[Row] = 67108864
		this.Event ItemChanged(Row, this.object.background_color, "67108864")
end choose
end event

event constructor;call super::constructor;this.InsertRow(0)
end event

event itemchanged;call super::itemchanged;if dwo.name = "background_color" then
	of_ShowColor()
end if
end event

event losefocus;call super::losefocus;this.AcceptText()
end event

type tabpage_tab from userobject within tab_1
integer x = 18
integer y = 100
integer width = 1321
integer height = 940
long backcolor = 33551856
string text = "Tab"
long tabbackcolor = 79680469
long picturemaskcolor = 536870912
dw_4 dw_4
end type

on tabpage_tab.create
this.dw_4=create dw_4
this.Control[]={this.dw_4}
end on

on tabpage_tab.destroy
destroy(this.dw_4)
end on

type dw_4 from u_dw within tabpage_tab
integer x = 9
integer y = 16
integer width = 1298
integer height = 912
integer taborder = 40
string dataobject = "d_contract_tab_properties_batch"
end type

event constructor;This.InsertRow(0)
This.of_SetUpdateable(False)

String ls_fonts[]
datawindowchild ldwc_fonts
int i,j
n_cst_appeondll lnv_appeon_dll


if this.getchild("tab_font_name",ldwc_fonts) = 1 then
	lnv_appeon_dll.of_getfonts(ls_fonts)
	
	For i = 1 To UpperBound(ls_fonts[])
		If Trim(ls_fonts[i]) = '' Then Continue
		If i > 1 Then
			If ls_fonts[i - 1] = ls_fonts[i] Then Continue
		End If
		j = ldwc_fonts.InsertRow(0)
		ldwc_fonts.SetItem(j,1,ls_fonts[i])
	Next
	
	If ldwc_fonts.RowCount() = 0 Then
		ldwc_fonts.InsertRow(1)
		ldwc_fonts.SetItem(1,1,'Segoe UI')
	End If
	
	ldwc_fonts.SetSort('fonts_face A')
	ldwc_fonts.Sort()
	this.InsertRow(0)
end if

this.Setitem( 1, 'tab_font_italic', 'F' )
this.Setitem( 1, 'tab_fixed_width', 'F' )
this.Setitem( 1, 'tab_font_underline', 'F' )

end event

event buttonclicked;long ll_Color

This.AcceptText()
if Row <= 0 then Return

choose case dwo.name
	case "b_tab_textcolor"
		ll_Color = This.object.fields_tab_textcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_tab_textcolor[Row] = ll_Color
			This.SetColumn("fields_tab_textcolor")
			This.Event ItemChanged(Row, This.object.fields_tab_textcolor, String(ll_Color))
		end if
	case "b_tab_textcolor_def"
		This.object.fields_tab_textcolor[Row] = 33554432
		This.SetColumn("fields_tab_textcolor")
		This.Event ItemChanged(Row, This.object.fields_tab_textcolor, "33554432")
	case "b_tab_backcolor"
		ll_Color = This.object.fields_tab_backcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_tab_backcolor[Row] = ll_Color
			This.SetColumn("fields_tab_backcolor")
			This.Event ItemChanged(Row, This.object.fields_tab_backcolor, String(ll_Color))
		end if
	case "b_tab_backcolor_def"
		This.object.fields_tab_backcolor[Row] = 67108864
		This.SetColumn("fields_tab_backcolor")
		This.Event ItemChanged(Row, This.object.fields_tab_backcolor, "67108864")
	case "b_page_backcolor"
		ll_Color = This.object.fields_page_backcolor[Row]
		of_ParseColor(ll_Color)
		if ChooseColor(ll_Color,gl_custom_colors[]) = 1 then
			This.object.fields_page_backcolor[Row] = ll_Color
			This.SetColumn("fields_page_backcolor")
			This.Event ItemChanged(Row, This.object.fields_page_backcolor, String(ll_Color))
		end if
	case "b_page_backcolor_def"
		This.object.fields_page_backcolor[Row] = 67108864
		This.SetColumn("fields_page_backcolor")
		This.Event ItemChanged(Row, This.object.fields_page_backcolor, "67108864")
	Case 'b_fontname_default' //added by gavins 20130415
		This.object.tab_font_name[Row] = "Segoe UI"
		This.SetColumn("tab_font_name")
	Case 'b_fontheight_default'  
		//This.object.tab_font_height[Row] = "8"
		This.object.tab_font_height[Row] = 8  //(Appeon)Harry 05.30.2014 - V142 ISG-CLX
		This.SetColumn("tab_font_height")	
end choose

end event

event itemchanged;choose case dwo.name 
	case "fields_tab_textcolor", "fields_tab_backcolor", "fields_page_backcolor"
		of_ShowColor()
end choose

end event

event losefocus;call super::losefocus;This.AcceptText()
end event

type cb_ok from u_cb within w_contract_batch_update_prop
integer x = 754
integer y = 1396
integer width = 343
integer taborder = 30
boolean bringtotop = true
string text = "&Update"
boolean default = true
end type

event clicked;string ls_Message
Long	ll_data_view_id

if of_Verify() = -1 then Return
ls_Message = "The system suggests you back up the selected view before update, and you can back up a view by using Copy View in View Painter. " + &
				 "Are you sure you want to update now?"
if MessageBox("Update", ls_Message, Question!, YesNoCancel!, 3) <> 1 then Return

SetPointer(HourGlass!)
ll_data_view_id = dw_view.object.data_view_id[1]
If ll_data_view_id <=0 Then Return
//backup 
/***********************************************///added by gavins 20120919
//---------Begin Modified by (Appeon)Alfee 06.18.2013 for V141 ISG-CLX--------
//n_cst_update_data        lno_backup
//lno_backup = create n_cst_update_data
n_cst_update_data_clx        lno_backup
lno_backup = create n_cst_update_data_clx
//---------End Modfiied ------------------------------------------------------

lno_backup.of_backup_screen(  ll_data_view_id, -9999   )

If IsValid( lno_backup ) Then Destroy ( lno_backup )
/***********************************************/
SetPointer(HourGlass!)
of_Update()
SetPointer(Arrow!)
MessageBox("Update", "Batch update screen properties completed!")

if IsValid(w_contract_data_design) then
	w_contract_data_design.il_SaveResult = 1
end if

end event

type cb_cancel from u_cb within w_contract_batch_update_prop
integer x = 1120
integer y = 1396
integer width = 343
integer taborder = 40
boolean bringtotop = true
string text = "&Close"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_contract_batch_update_prop
integer x = 32
integer y = 208
integer width = 1431
integer height = 1160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Segoe UI"
long textcolor = 33554432
long backcolor = 33551856
string text = "Specify Updated Properties"
end type

