$PBExportHeader$n_cst_dashboard.sru
forward
global type n_cst_dashboard from nonvisualobject
end type
end forward

global type n_cst_dashboard from nonvisualobject
end type
global n_cst_dashboard n_cst_dashboard

type variables
n_ds ids_dashboard_gadgets
n_ds ids_dashboard_templates
n_ds ids_dashboard_tabs
n_ds ids_dashboard_tab_gadgets
n_ds ids_dashboard_settings
n_ds ids_dashboard_reports 
n_ds ids_dashboard_tab_settings
n_ds ids_dashboard_todolist
n_ds ids_dashboard_other_properties


Long il_gadget_title_default_color  //Default gadgets title BG color
Long il_tab_bg_default_color  //Default tab BG color
Long il_tab_text_default_color  
Long il_gadget_bg_default_color //Default gadget BG color
Long il_tab_id
Integer ii_clock_face_default_id

String is_gadget_tilte_default_font_face
Integer ii_gadget_tilte_default_font_size
Long il_gadget_tilte_default_font_color

String is_user_templates = '$Only For Template$'
end variables

forward prototypes
public function integer of_retrieve_data ()
public function integer of_gen_area_structure (long al_tab_id, ref str_gadget astr_area1[], ref str_gadget astr_area2[], ref str_gadget astr_area3[], ref str_gadget astr_area4[])
public function long of_create_default_tab ()
public function integer of_update_area_to_db (long al_tab_id, str_gadget astr_area1[], str_gadget astr_area2[], str_gadget astr_area3[], str_gadget astr_area4[])
public function integer of_delete_gadget (long al_tab_id, long al_gadget_id[])
public function integer of_delete_tab (long al_tab_id)
public function long of_add_tabpage (string as_title, string as_tab_style, string as_tab_style_type)
public function integer of_apply_right ()
public function integer of_create_tab_settings ()
public function integer of_save_templ (long al_template_id)
public function integer of_delete_templ (long al_templ_id)
public function integer of_load_templ (ref long al_templ_id, boolean ab_show_choose)
public function integer of_retrieve_data_only ()
public subroutine of_set_tab_default (long al_gadget_title_bg_color, long al_tab_bg_color, long al_tab_text_color, long al_gadget_bg_color, string as_gadget_title_font_face, integer ai_gadget_title_font_size, integer ai_clock_face_id, long al_gadget_title_font_color)
public subroutine of_report_data_filter (datawindow adw_filter, string as_type, string as_id)
end prototypes

public function integer of_retrieve_data ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_retrieve_data()
// $<arguments>(None)
// $<returns> (none)
// $<description> Retrieve all datastore data
//////////////////////////////////////////////////////////////////////
// $<add> 21/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_ret
Long ll_default_temp_id

of_retrieve_data_only()

//If no any tab in current user, then create default tab
If ids_dashboard_tabs.RowCount() < 1 Then
	Select default_dashboard_id Into :ll_default_temp_id From security_users where user_id = :gs_user_id;
	If ll_default_temp_id > 0 Then
		//Use default template ID In user painter
		If of_load_templ(ll_default_temp_id,False) < 0 Then
			//Use System default settings.
			 li_ret = of_create_default_tab()
			 If li_ret < 0 then Return -1
		End If
	Else
		li_ret = of_create_default_tab()
		If li_ret < 0 then Return -1		
	End If
End If
If ids_dashboard_settings.RowCount() < 1 Then
	Return -2
End If

//If no any tab setting for current user, create it.
If ids_dashboard_tab_settings.RowCount() =0 Then
	li_ret = of_create_tab_settings()
	If li_ret < 0 Then Return -3	
End If

f_apply_gadgets_right_ds(ids_dashboard_tab_gadgets,'gadget_id')

Return 1
end function

public function integer of_gen_area_structure (long al_tab_id, ref str_gadget astr_area1[], ref str_gadget astr_area2[], ref str_gadget astr_area3[], ref str_gadget astr_area4[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_gen_area_structure()
// $<arguments>
//		value    	long      	al_tab_id   		
//		reference	str_gadget	astr_area1[]		
//		reference	str_gadget	astr_area2[]		
//		reference	str_gadget	astr_area3[]		
//		reference	str_gadget	astr_area4[]		
// $<returns> integer
// $<description> Generate area array list by tab id.
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 23/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_cnt,i,li_find_row
String ls_title
long ll_gadget_id


//For Area1
ids_dashboard_tab_gadgets.SetFilter('tab_id = '+String(al_tab_id)+' and area_number = 1')
ids_dashboard_tab_gadgets.Filter()
li_cnt = ids_dashboard_tab_gadgets.Rowcount()
For i = 1 To li_cnt 
	astr_area1[i].area_number = 1
	ll_gadget_id = ids_dashboard_tab_gadgets.GetItemNumber(i,'gadget_id')
	astr_area1[i].gadget_id = ll_gadget_id
	ls_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')
	If ls_title = '' or isnull(ls_title) Then
		li_find_row = ids_dashboard_gadgets.Find('gadget_id = '+String(ll_gadget_id),1,ids_dashboard_gadgets.Rowcount())
		If li_find_row > 0 Then
			astr_area1[i].gadget_title = ids_dashboard_gadgets.GetItemString(li_find_row,'gadget_title')
		End If
	Else
		astr_area1[i].gadget_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')	
	End If
	astr_area1[i].gadget_rows_number = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_rows_number')	
	astr_area1[i].gadget_maximize = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_maximize')		
	astr_area1[i].adec_height_ier = ids_dashboard_tab_gadgets.GetItemDecimal(i,'height_ier')		
Next

//For Area2
ids_dashboard_tab_gadgets.SetFilter('tab_id = '+String(al_tab_id)+' and area_number = 2')
ids_dashboard_tab_gadgets.Filter()
li_cnt = ids_dashboard_tab_gadgets.Rowcount()
For i = 1 To li_cnt 
	astr_area2[i].area_number = 2
	ll_gadget_id = ids_dashboard_tab_gadgets.GetItemNumber(i,'gadget_id')
	astr_area2[i].gadget_id = ll_gadget_id
	ls_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')
	If ls_title = '' or isnull(ls_title) Then
		li_find_row = ids_dashboard_gadgets.Find('gadget_id = '+String(ll_gadget_id),1,ids_dashboard_gadgets.Rowcount())
		If li_find_row > 0 Then
			astr_area2[i].gadget_title = ids_dashboard_gadgets.GetItemString(li_find_row,'gadget_title')
		End If
	Else
		astr_area2[i].gadget_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')	
	End If
	astr_area2[i].gadget_rows_number = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_rows_number')	
	astr_area2[i].gadget_maximize = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_maximize')		
	astr_area2[i].adec_height_ier = ids_dashboard_tab_gadgets.GetItemDecimal(i,'height_ier')			
Next	

//For Area3
ids_dashboard_tab_gadgets.SetFilter('tab_id = '+String(al_tab_id)+' and area_number = 3')
ids_dashboard_tab_gadgets.Filter()
li_cnt = ids_dashboard_tab_gadgets.Rowcount()
For i = 1 To li_cnt 
	astr_area3[i].area_number = 3
	ll_gadget_id = ids_dashboard_tab_gadgets.GetItemNumber(i,'gadget_id')
	astr_area3[i].gadget_id = ll_gadget_id
	ls_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')
	If ls_title = '' or isnull(ls_title) Then
		li_find_row = ids_dashboard_gadgets.Find('gadget_id = '+String(ll_gadget_id),1,ids_dashboard_gadgets.Rowcount())
		If li_find_row > 0 Then
			astr_area3[i].gadget_title = ids_dashboard_gadgets.GetItemString(li_find_row,'gadget_title')
		End If
	Else
		astr_area3[i].gadget_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')	
	End If
	astr_area3[i].gadget_rows_number = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_rows_number')	
	astr_area3[i].gadget_maximize = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_maximize')		
	astr_area3[i].adec_height_ier = ids_dashboard_tab_gadgets.GetItemDecimal(i,'height_ier')			
Next

//For Area4
ids_dashboard_tab_gadgets.SetFilter('tab_id = '+String(al_tab_id)+' and area_number = 4')
ids_dashboard_tab_gadgets.Filter()
li_cnt = ids_dashboard_tab_gadgets.Rowcount()
For i = 1 To li_cnt 
	astr_area4[i].area_number = 4
	ll_gadget_id = ids_dashboard_tab_gadgets.GetItemNumber(i,'gadget_id')
	astr_area4[i].gadget_id = ll_gadget_id
	ls_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')
	If ls_title = '' or isnull(ls_title) Then
		li_find_row = ids_dashboard_gadgets.Find('gadget_id = '+String(ll_gadget_id),1,ids_dashboard_gadgets.Rowcount())
		If li_find_row > 0 Then
			astr_area4[i].gadget_title = ids_dashboard_gadgets.GetItemString(li_find_row,'gadget_title')
		End If
	Else
		astr_area4[i].gadget_title = ids_dashboard_tab_gadgets.GetItemString(i,'gadget_title')	
	End If
	astr_area4[i].gadget_rows_number = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_rows_number')	
	astr_area4[i].gadget_maximize = ids_dashboard_tab_gadgets.GetItemnumber(i,'gadget_maximize')		
	astr_area4[i].adec_height_ier = ids_dashboard_tab_gadgets.GetItemDecimal(i,'height_ier')			
Next

ids_dashboard_tab_gadgets.SetFilter('')
ids_dashboard_tab_gadgets.Filter()
Return 1
end function

public function long of_create_default_tab ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_create_default_tab()
// $<arguments>(None)
// $<returns> integer
// $<description> Create default dashboard with default setting.
//////////////////////////////////////////////////////////////////////
// $<add> 21/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_cnt,i,li_ret
String ls_filter_conf
long ll_tab_id
Long ll_row,ll_find_row
Long ll_gagdet_id

//Filter with default settings
ls_filter_conf = "template_name = 'Default'"
ids_dashboard_templates.SetFilter(ls_filter_conf)
ids_dashboard_templates.Filter()
li_cnt = ids_dashboard_templates.RowCount()
If li_cnt < 1 Then 
	ids_dashboard_templates.SetFilter("")
	ids_dashboard_templates.Filter()
	Return -100
End If

//Insert new tab data
ll_row = ids_dashboard_tabs.InsertRow(0)
ids_dashboard_tabs.SetItem(ll_row,'user_id',gs_user_id)
ids_dashboard_tabs.SetItem(ll_row,'tab_style',ids_dashboard_templates.GetItemString(1,'tab_style'))
ids_dashboard_tabs.SetItem(ll_row,'tab_style_type',ids_dashboard_templates.GetItemString(1,'tab_style_type'))
ids_dashboard_tabs.SetItem(ll_row,'tab_title',ids_dashboard_templates.GetItemString(1,'tab_title'))
ids_dashboard_tabs.SetItem(ll_row,'gadget_title_color',il_gadget_title_default_color)
ids_dashboard_tabs.SetItem(ll_row,'tab_bg_color',il_tab_bg_default_color)
ids_dashboard_tabs.SetItem(ll_row,'tab_text_color',il_tab_text_default_color)
ids_dashboard_tabs.SetItem(ll_row,'gadget_bg_color',il_gadget_bg_default_color)
ids_dashboard_tabs.SetItem(ll_row,'tab_order',10)
ids_dashboard_tabs.SetItem(ll_row,'tab_locked',0)
ids_dashboard_tabs.SetItem(ll_row,'single_double_clk',1)

ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_face',is_gadget_tilte_default_font_face)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_size',ii_gadget_tilte_default_font_size)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_color',il_gadget_tilte_default_font_color)

ids_dashboard_tabs.SetItem(ll_row, 'clock_face_id',ii_clock_face_default_id)


Select Max(tab_id) Into :ll_tab_id From dashboard_tabs;
If isnull(ll_tab_id) Then ll_tab_id = 0
ll_tab_id++
ids_dashboard_tabs.SetItem(ll_row,'tab_id',ll_tab_id)

//Insert new gadget for the new tab
For i =  1 To li_cnt
	ll_row = ids_dashboard_tab_gadgets.InsertRow(0)
	ids_dashboard_tab_gadgets.SetItem(ll_row,'tab_id',ll_tab_id)
	ids_dashboard_tab_gadgets.SetItem(ll_row,'area_number',ids_dashboard_templates.GetItemnumber(i,'area_number'))
	ll_gagdet_id = ids_dashboard_templates.GetItemnumber(i,'gadget_id')
	ids_dashboard_tab_gadgets.SetItem(ll_row,'gadget_id',ll_gagdet_id)
	
	//Set rows_number, Search from gadgets list
	ll_find_row = ids_dashboard_gadgets.Find('gadget_id = '+String(ll_gagdet_id),1,ids_dashboard_gadgets.Rowcount())
	If ll_find_row > 0 Then
		If ids_dashboard_gadgets.GetItemNumber(ll_find_row,'gadget_auto_height') = 1 Then
			ids_dashboard_tab_gadgets.SetItem(ll_row,'gadget_rows_number',5)  //Default 5 rows
		Else
			ids_dashboard_tab_gadgets.SetItem(ll_row,'gadget_rows_number',0) //Fixed height
		End If
	Else
		ids_dashboard_tab_gadgets.SetItem(ll_row,'gadget_rows_number',0) //Fixed height					
	End If

	ids_dashboard_tab_gadgets.SetItem(ll_row,'gadget_order',ids_dashboard_templates.GetItemnumber(i,'gadget_order'))
Next

//Save data to DB
//gnv_appeondb.of_startqueue()
sqlca.autocommit = false
li_ret = gnv_appeondb.of_update(ids_dashboard_tabs,ids_dashboard_tab_gadgets) 
sqlca.autocommit = true
//gnv_appeondb.of_commitqueue()

//Refresh data
ids_dashboard_templates.SetFilter("")
ids_dashboard_templates.Filter()

If li_ret <> 1 Then Return -1

Return ll_tab_id

end function

public function integer of_update_area_to_db (long al_tab_id, str_gadget astr_area1[], str_gadget astr_area2[], str_gadget astr_area3[], str_gadget astr_area4[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_update_area_to_db()
// $<arguments>
//		value	str_gadget	astr_area1[]		
//		value	str_gadget	astr_area2[]		
//		value	str_gadget	astr_area3[]		
//		value	str_gadget	astr_area4[]		
// $<returns> integer
// $<description> Update area to DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 24/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_row,i
Long ll_order
Long ll_ret

//For Area1
ll_order = 10
For i = 1 To UpperBound(astr_area1[])
	li_row = ids_dashboard_tab_gadgets.Find('gadget_id = '+String(astr_area1[i].gadget_id)+ ' And tab_id = ' +String(al_tab_id),1,ids_dashboard_tab_gadgets.RowCount())
	If li_row > 0 Then
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'area_number') <> 1 Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',1)
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_maximize') <> astr_area1[i].gadget_maximize Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',astr_area1[i].gadget_maximize )
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_rows_number') <> astr_area1[i].gadget_rows_number Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area1[i].gadget_rows_number )
		End If
		If ids_dashboard_tab_gadgets.GetItemString(li_row,'gadget_title') <> astr_area1[i].gadget_title Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area1[i].gadget_title )
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_order') <> ll_order Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		End If
		If ids_dashboard_tab_gadgets.GetItemDecimal(li_row,'height_ier') <> astr_area1[i].adec_height_ier Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area1[i].adec_height_ier)
		End If
	Else
		li_row = ids_dashboard_tab_gadgets.InsertRow(0)
		ids_dashboard_tab_gadgets.SetItem(li_row,'tab_id',al_tab_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',1)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_id',astr_area1[i].gadget_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area1[i].gadget_title)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area1[i].gadget_rows_number )		
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',1)
		ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area1[i].adec_height_ier)
	End If
	ll_order = ll_order + 10 //Step is 10	
Next

//For Area2
ll_order = 10
For i = 1 To UpperBound(astr_area2[])
	li_row = ids_dashboard_tab_gadgets.Find('gadget_id = '+String(astr_area2[i].gadget_id)+ ' And tab_id = ' +String(al_tab_id),1,ids_dashboard_tab_gadgets.RowCount())
	If li_row > 0 Then
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'area_number') <> 2 Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',2)
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_maximize') <> astr_area2[i].gadget_maximize Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',astr_area2[i].gadget_maximize )
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_rows_number') <> astr_area2[i].gadget_rows_number Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area2[i].gadget_rows_number )
		End If		
		If ids_dashboard_tab_gadgets.GetItemString(li_row,'gadget_title') <> astr_area2[i].gadget_title Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area2[i].gadget_title )
		End If		
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_order') <> ll_order Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		End If
		If ids_dashboard_tab_gadgets.GetItemDecimal(li_row,'height_ier') <> astr_area2[i].adec_height_ier Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area2[i].adec_height_ier)
		End If		
	Else
		li_row = ids_dashboard_tab_gadgets.InsertRow(0)
		ids_dashboard_tab_gadgets.SetItem(li_row,'tab_id',al_tab_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',2)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_id',astr_area2[i].gadget_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area2[i].gadget_title)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area2[i].gadget_rows_number )		
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)	
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',1)		
		ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area2[i].adec_height_ier)		
	End If
	ll_order = ll_order + 10 //Step is 10
Next

//For Area3
ll_order = 10
For i = 1 To UpperBound(astr_area3[])
	li_row = ids_dashboard_tab_gadgets.Find('gadget_id = '+String(astr_area3[i].gadget_id)+ ' And tab_id = ' +String(al_tab_id),1,ids_dashboard_tab_gadgets.RowCount())
	If li_row > 0 Then
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'area_number') <> 3 Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',3)
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_maximize') <> astr_area3[i].gadget_maximize Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',astr_area3[i].gadget_maximize )
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_rows_number') <> astr_area3[i].gadget_rows_number Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area3[i].gadget_rows_number )
		End If	
		If ids_dashboard_tab_gadgets.GetItemString(li_row,'gadget_title') <> astr_area3[i].gadget_title Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area3[i].gadget_title )
		End If		
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_order') <> ll_order Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		End If
		If ids_dashboard_tab_gadgets.GetItemDecimal(li_row,'height_ier') <> astr_area3[i].adec_height_ier Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area3[i].adec_height_ier)
		End If		
	Else
		li_row = ids_dashboard_tab_gadgets.InsertRow(0)
		ids_dashboard_tab_gadgets.SetItem(li_row,'tab_id',al_tab_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',3)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_id',astr_area3[i].gadget_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area3[i].gadget_title)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area3[i].gadget_rows_number )		
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)		
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',1)	
		ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area3[i].adec_height_ier)		
	End If
	ll_order = ll_order + 10 //Step is 10
Next

//For Area4
ll_order = 10
For i = 1 To UpperBound(astr_area4[])
	li_row = ids_dashboard_tab_gadgets.Find('gadget_id = '+String(astr_area4[i].gadget_id)+ ' And tab_id = ' +String(al_tab_id),1,ids_dashboard_tab_gadgets.RowCount())
	If li_row > 0 Then
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'area_number') <> 4 Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',4)
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_maximize') <> astr_area4[i].gadget_maximize Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',astr_area4[i].gadget_maximize )
		End If
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_rows_number') <> astr_area4[i].gadget_rows_number Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area4[i].gadget_rows_number )
		End If	
		If ids_dashboard_tab_gadgets.GetItemString(li_row,'gadget_title') <> astr_area4[i].gadget_title Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area4[i].gadget_title )
		End If		
		If ids_dashboard_tab_gadgets.GetItemNumber(li_row,'gadget_order') <> ll_order Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		End If
		If ids_dashboard_tab_gadgets.GetItemDecimal(li_row,'height_ier') <> astr_area4[i].adec_height_ier Then
			ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area4[i].adec_height_ier)
		End If		
	Else
		li_row = ids_dashboard_tab_gadgets.InsertRow(0)
		ids_dashboard_tab_gadgets.SetItem(li_row,'tab_id',al_tab_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'area_number',4)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_id',astr_area4[i].gadget_id)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_title',astr_area4[i].gadget_title)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_rows_number',astr_area4[i].gadget_rows_number )		
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_order',ll_order)
		ids_dashboard_tab_gadgets.SetItem(li_row,'gadget_maximize',1)	
		ids_dashboard_tab_gadgets.SetItem(li_row,'height_ier',astr_area4[i].adec_height_ier)		
	End If
	ll_order = ll_order + 10 //Step is 10
Next

//Save data
If ids_dashboard_tab_gadgets.Modifiedcount() > 0 Then
	gnv_appeondb.of_autocommitrollback()
	ll_ret = ids_dashboard_tab_gadgets.Update()
	If ll_ret <> 1 Then
		ids_dashboard_tab_gadgets.Retrieve(gs_user_id) //Refresh data
		Return -1
	End If
End If

Return 1


end function

public function integer of_delete_gadget (long al_tab_id, long al_gadget_id[]);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_delete_gadget()
// $<arguments>
//		value	long	al_tab_id     		
//		value	long	al_gadget_id[]		
// $<returns> integer
// $<description> Delete gadgets from DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 28/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_row,ll_ret
Integer i,li_cnt

li_cnt = UpperBound(al_gadget_id[])
If li_cnt = 0 Then Return 1

//Find and delete gadgets.
For i = 1 To li_cnt
	ll_row = ids_dashboard_tab_gadgets.Find('gadget_id = '+String(al_gadget_id[i]) + ' And tab_id = '+String(al_tab_id),1,ids_dashboard_tab_gadgets.RowCount())
	If ll_row > 0 Then
		ids_dashboard_tab_gadgets.DeleteRow(ll_row)
	End If
Next

//Save to DB
If ids_dashboard_tab_gadgets.Deletedcount() > 0 Then
	gnv_appeondb.of_autocommitrollback()
	ll_ret = ids_dashboard_tab_gadgets.Update()
	If ll_ret <> 1 Then 
		ids_dashboard_tab_gadgets.Retrieve(gs_user_id)  //Refresh data when delete failed.
		Return -1
	End If
Else
	Return -100
End If
Return 1
end function

public function integer of_delete_tab (long al_tab_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_delete_tab()
// $<arguments>
//		value	long	al_tab_id		
// $<returns> integer
// $<description> Delete tab data from DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 28/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_row,i,ll_cnt
Integer li_ret 

//Delete Tab
ll_row = ids_dashboard_tabs.Find('Tab_id = '+String(al_tab_id),1,ids_dashboard_tabs.Rowcount())
If ll_row > 0 Then
	ids_dashboard_tabs.DeleteRow(ll_row)
End If

//Delete Dadgets in the tab
ids_dashboard_tab_gadgets.SetFilter('Tab_id = ' + String(al_tab_id) )
ids_dashboard_tab_gadgets.Filter()

ll_cnt = ids_dashboard_tab_gadgets.RowCount()
For i = ll_cnt To 1 Step -1
	ids_dashboard_tab_gadgets.DeleteRow(i)
Next

//Delete gadget other properties.
ids_dashboard_other_properties.SetFilter('Tab_id = ' + String(al_tab_id))
ids_dashboard_other_properties.Filter( )
ll_cnt = ids_dashboard_other_properties.RowCount()
For i = ll_cnt to 1 Step -1
	ids_dashboard_other_properties.DeleteRow(i)
Next

//Save to DB
//gnv_appeondb.of_startqueue()
	SQLCA.autocommit = False
	li_ret = gnv_appeondb.of_update( ids_dashboard_tab_gadgets, ids_dashboard_tabs,ids_dashboard_other_properties)
	SQLCA.autocommit = True
//gnv_appeondb.of_commitqueue()

//Re-filter data
ids_dashboard_tab_gadgets.SetFilter('')
ids_dashboard_tab_gadgets.Filter()

gnv_appeondb.of_startqueue()
	//Refresh data if failed to delete 
	If li_ret <> 1 Then
		ids_dashboard_tabs.Retrieve(gs_user_id)
		ids_dashboard_tab_gadgets.Retrieve(gs_user_id)
	End If
gnv_appeondb.of_commitqueue()

If li_ret <> 1 Then
	Return -1
Else
	Return 1
End If

end function

public function long of_add_tabpage (string as_title, string as_tab_style, string as_tab_style_type);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_add_tabpage()
// $<arguments>
//		value	string	as_title    		
//		value	string	as_tab_style	
//		value	string	as_tab_style_type	
// $<returns> long
// $<description> Add tab data to DB
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 28/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_tab_id,ll_row,ll_ret
Long ll_tab_order
Select Max(tab_id),Max(tab_order) Into :ll_tab_id,:ll_tab_order From dashboard_tabs;

If isnull(ll_tab_id) Then ll_tab_id = 0 
If isnull(ll_tab_order) Then ll_tab_order = 0
ll_tab_id = ll_tab_id + 1
ll_tab_order = ll_tab_order + 10  //Step is 10

ll_row = ids_dashboard_tabs.InsertRow(0)
ids_dashboard_tabs.SetItem(ll_row, 'user_id',gs_user_id)
ids_dashboard_tabs.SetItem(ll_row, 'tab_id',ll_tab_id)
ids_dashboard_tabs.SetItem(ll_row, 'tab_title',as_title)
ids_dashboard_tabs.SetItem(ll_row, 'tab_style',as_tab_style) 
ids_dashboard_tabs.SetItem(ll_row, 'tab_style_type',as_tab_style_type) 
ids_dashboard_tabs.SetItem(ll_row, 'tab_order',ll_tab_order)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_color',il_gadget_title_default_color)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_face',is_gadget_tilte_default_font_face)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_size',ii_gadget_tilte_default_font_size)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_title_font_color',il_gadget_tilte_default_font_color)
ids_dashboard_tabs.SetItem(ll_row, 'tab_bg_color',il_tab_bg_default_color)
ids_dashboard_tabs.SetItem(ll_row, 'tab_text_color',il_tab_text_default_color)
ids_dashboard_tabs.SetItem(ll_row, 'gadget_bg_color',il_gadget_bg_default_color)
ids_dashboard_tabs.SetItem(ll_row, 'tab_locked',0)
ids_dashboard_tabs.SetItem(ll_row, 'single_double_clk',1)

ids_dashboard_tabs.SetItem(ll_row, 'clock_face_id',ii_clock_face_default_id)


gnv_appeondb.of_autocommitrollback()
ll_ret = ids_dashboard_tabs.update()
If ll_ret = 1 Then 
	Commit;
Else
	Rollback;
	ids_dashboard_tabs.Retrieve(gs_user_id) //Restore data.
	Return -1
End If

Return ll_tab_id
end function

public function integer of_apply_right ();//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_apply_right()
// $<arguments>(None)
// $<returns> integer
// $<description>
// $<description> If no right for module, discard that row.
//////////////////////////////////////////////////////////////////////
// $<add> 2008-08-12 by Ken.Guo
//////////////////////////////////////////////////////////////////////
/*
1, To Do List        
2, Favorite Report     
3, Favorite Correspondence
4, Message Board         
5, Calendar/Meetings
6, Favorite Work Flow
7, Recent Practitioner  
8, Recent Contract
9, Notes            
10, Contract Global Search
*/

Long ll_find

//For To Do List
If m_pfe_cst_master_menu.m_file.m_todolist.Visible = False Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 1', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

//For Report/Graph
If m_pfe_cst_master_menu.m_reports.m_reportsgraphs.Visible = False Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 2', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

//For Correspondence
If m_pfe_cst_master_menu.m_reports.m_letters.Visible = False Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 3', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

//For WorkFlow
//If m_pfe_cst_master_menu.m_system.m_painters.m_workflowpainter.Visible = False Then
If m_pfe_cst_master_menu.m_system.m_painters.m_systemsetup.m_workflowpainter.Visible = False Then //(Appeon)Eugene 06.04.2013 - V141 ISG-CLX
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 6', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

//For Practitioner
If m_pfe_cst_master_menu.m_file.m_practitioner.Visible = False Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 7', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

//For Contract
If m_pfe_cst_master_menu.m_file.m_contract.Visible = False Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 8', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If
End If

//For CTX Global Search
If m_pfe_cst_master_menu.m_file.m_contractglobalsearch.visible Then
	ll_find = ids_dashboard_tab_gadgets.Find( 'gadget_id = 10', 1, ids_dashboard_tab_gadgets.RowCount() )
	If ll_find > 0 Then
		ids_dashboard_tab_gadgets.RowsDiscard(ll_find,ll_find,Primary!)
	End If	
End If

Return 1
end function

public function integer of_create_tab_settings ();ids_dashboard_tab_settings.InsertRow(1)
ids_dashboard_tab_settings.SetItem(1,'user_id',gs_user_id)
ids_dashboard_tab_settings.SetItem(1,'tab_header_font_face',is_gadget_tilte_default_font_face)
ids_dashboard_tab_settings.SetItem(1,'tab_header_font_size',ii_gadget_tilte_default_font_size)
gnv_appeondb.of_autocommitrollback( )
If ids_dashboard_tab_settings.update() = 1 Then
	Commit;
Else
	Rollback;
	Return -1
End If

Return 1
end function

public function integer of_save_templ (long al_template_id);//////////////////////////////////////////////////////////////////////
// $<function>of_save_templ()
// $<arguments>
//		ref	long	al_template_id		
// $<returns> integer
// $<description> Save dashboard settings to the template.
// $<description> If save failed, should can rollback.
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

long ll_templ_id,ll_max_tab_id,ll_old_tabs_id[],ll_new_tabs_id[]
Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt
Integer i,j,k,n,p,li_ret
Boolean lb_auto_commit, lb_is_replace
long ll_tpl_tabs_id_org,ll_find
String ls_err
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates

//Get template Name/ID
Open(w_dashb_templ_saveas)
ll_templ_id = Message.doubleparm

SetPointer(HourGlass!)

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

//Get current user's template settings.
li_tabs_cnt = ids_dashboard_tabs.RowCount()
li_gadgets_cnt = ids_dashboard_tab_gadgets.Rowcount()
li_reports_cnt = ids_dashboard_reports.Rowcount()

If li_tabs_cnt = 0 Then 
	Return -101
End If

Integer li_tabs_cnt_org,li_gadgets_cnt_org,li_reports_cnt_org
long ll_properties_cnt_org
n_ds lds_dashboard_tab_gadgets_templates,lds_dashboard_reports_templates
n_ds lds_dashboard_gadgets_other_properties_templates
lds_dashboard_tab_gadgets_templates = Create n_ds
lds_dashboard_reports_templates = Create n_ds
lds_dashboard_gadgets_other_properties_templates = Create n_ds
lds_dashboard_tab_gadgets_templates.dataobject = ids_dashboard_tab_gadgets.dataobject
lds_dashboard_reports_templates.dataobject = ids_dashboard_reports.dataobject
lds_dashboard_gadgets_other_properties_templates.dataobject = ids_dashboard_other_properties.dataobject
lds_dashboard_tab_gadgets_templates.SettransObject(SQLCA)
lds_dashboard_reports_templates.SetTransObject(SQLCA)
lds_dashboard_gadgets_other_properties_templates.SetTransObject(SQLCA)

//Retrieve Orginal Template Settings.
gnv_appeondb.of_startqueue() 
	lds_dashb_tabs_templates.Retrieve(al_template_id)
	lds_dashboard_tab_gadgets_templates.Retrieve(is_user_templates)
	lds_dashboard_reports_templates.Retrieve(is_user_templates)
	lds_dashb_settings_templates.Retrieve(al_template_id)
	lds_dashboard_gadgets_other_properties_templates.Retrieve(is_user_templates)
gnv_appeondb.of_commitqueue()

li_tabs_cnt_org = lds_dashb_tabs_templates.RowCount()
li_gadgets_cnt_org = lds_dashboard_tab_gadgets_templates.RowCount()
li_reports_cnt_org = lds_dashboard_reports_templates.RowCount()

//If template is existed, will delete orginal template data
If li_tabs_cnt_org > 0 Then
	lb_is_replace = True
	For i = li_tabs_cnt_org To 1 Step -1
		
		//Delete tabs in templates
		ll_tpl_tabs_id_org = lds_dashb_tabs_templates.GetItemNumber(i,'tab_id')
		lds_dashb_tabs_templates.DeleteRow(i)
		
		//Delete gadgets in tabs
		li_gadgets_cnt_org = lds_dashboard_tab_gadgets_templates.RowCount()
		For j = li_gadgets_cnt_org To  1 Step -1
			If lds_dashboard_tab_gadgets_templates.GetItemNumber(j,'tab_id') = ll_tpl_tabs_id_org Then
				lds_dashboard_tab_gadgets_templates.DeleteRow(j)
			End If
		Next	
		
		//Delete reports for gadgets for tabs
		li_reports_cnt_org = lds_dashboard_reports_templates.RowCount()
		For k = li_reports_cnt_org To 1 Step -1
			If lds_dashboard_reports_templates.GetItemNumber(k,'tab_id') = ll_tpl_tabs_id_org Then
				lds_dashboard_reports_templates.DeleteRow(k)
			End If
		Next
		
		//Delete gadget other properties
		ll_properties_cnt_org = lds_dashboard_gadgets_other_properties_templates.RowCount()
		For p = ll_properties_cnt_org to 1 Step -1
			If lds_dashboard_gadgets_other_properties_templates.GetItemNumber(p,'tab_id') = ll_tpl_tabs_id_org Then
				lds_dashboard_gadgets_other_properties_templates.DeleteRow(p)
			End If
		Next
		
	Next
	
	//Delete tabs settings
	lds_dashb_settings_templates.DeleteRow(i)
End If

//Get Max tab_id
Select Max(tab_id) Into :ll_max_tab_id from dashboard_tabs;
If isnull(ll_max_tab_id) Then 
	Return -2
End If

//Add current dashboard settings to template.
For i = 1 To li_tabs_cnt
	//Save tabs
	ll_max_tab_id++
	ll_old_tabs_id[i] = ids_dashboard_tabs.GetItemNumber(i,'tab_id')
	ll_new_tabs_id[i] = ll_max_tab_id
	If ids_dashboard_tabs.RowsCopy(i,i,Primary!,lds_dashb_tabs_templates,99999,Primary!) <> 1 Then Return -102
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'template_id',ll_templ_id)
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'tab_id',ll_max_tab_id)
	lds_dashb_tabs_templates.SetItem(lds_dashb_tabs_templates.RowCount(),'user_id',is_user_templates)
	//Save gadgets for tabs
	For j = 1 to li_gadgets_cnt
		If ids_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_old_tabs_id[i] Then
			If ids_dashboard_tab_gadgets.RowsCopy(j,j,Primary!,lds_dashboard_tab_gadgets_templates,99999,Primary!) <> 1 Then Return -103
			lds_dashboard_tab_gadgets_templates.SetItem(lds_dashboard_tab_gadgets_templates.RowCount(),'tab_id',ll_new_tabs_id[i])
		End If
	Next	
	//Save reports for gadgets for tabs
	For k = 1 to li_reports_cnt
		If ids_dashboard_reports.GetItemNumber(k,'tab_id') = ll_old_tabs_id[i] Then
			If ids_dashboard_reports.RowsCopy(k,k,Primary!,lds_dashboard_reports_templates,99999,Primary!) <> 1 Then Return -104
			lds_dashboard_reports_templates.SetItem(lds_dashboard_reports_templates.RowCount(),'tab_id',ll_new_tabs_id[i])
			lds_dashboard_reports_templates.SetItem(lds_dashboard_reports_templates.RowCount(),'user_id',is_user_templates)
		End If
	Next
	//Save Gadgets Other Properties
	For p= 1 To ids_dashboard_other_properties.RowCount()
		If ids_dashboard_other_properties.GetItemNumber(p,'tab_id') = ll_old_tabs_id[i] Then
			ids_dashboard_other_properties.Rowscopy( p, p, Primary!, lds_dashboard_gadgets_other_properties_templates,1, Primary!)
			lds_dashboard_gadgets_other_properties_templates.SetItem(1,'user_id',is_user_templates)
			lds_dashboard_gadgets_other_properties_templates.SetItem(1,'tab_id',ll_new_tabs_id[i])
		End If
	Next
	
Next
//Save tabs settings
If ids_dashboard_tab_settings.RowsCopy(1,1,Primary!,lds_dashb_settings_templates,1,Primary!) <> 1 Then Return -105
lds_dashb_settings_templates.SetItem(1,'template_id',ll_templ_id)
lds_dashb_settings_templates.SetItem(1,'user_id',is_user_templates)

//Save data to DB
lb_auto_commit = SQLCA.autocommit
SQLCA.autocommit = False
If lds_dashb_tabs_templates.update() = 1 Then
	If lds_dashboard_tab_gadgets_templates.update() = 1 Then
		If lds_dashboard_reports_templates.update() = 1 Then
			If lds_dashb_settings_templates.update() = 1 Then
				If lds_dashboard_gadgets_other_properties_templates.update() = 1 Then
					li_ret = 1
				Else
					li_ret = -110
				End If
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

If li_ret < 0 Then
	Rollback using SQLCA;
	If lb_is_replace = False Then 
		//If it is a new template, will delete it when failed to save.
		gnv_appeondb.of_autocommitrollback( )
		Delete from dashboard_template where id = :al_template_id ;
		Commit;	
	End If
Else
	Commit using SQLCA;
End If

SQLCA.autocommit = lb_auto_commit

//Refresh data
of_retrieve_data()

Return li_ret
end function

public function integer of_delete_templ (long al_templ_id);//////////////////////////////////////////////////////////////////////
// $<function>of_delete_template()
// $<arguments>
//		value	long	al_templ_id		
// $<returns> integer
// $<description> Delete template
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt
Integer i,j,k,n,p,li_ret
Long ll_tab_id,ll_properties_cnt
Boolean lb_autocommit
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates
n_ds lds_dashboard_tab_gadgets,lds_dashboard_reports
n_ds lds_dashboard_gadgets_other_properties_templates

lds_dashb_tabs_templates = Create n_ds
lds_dashb_tabs_templates.dataobject = 'd_dashb_tabs_templates'
lds_dashb_tabs_templates.Settransobject(SQLCA)

lds_dashb_settings_templates = Create n_ds
lds_dashb_settings_templates.dataobject = 'd_dashb_tab_settings_templates'
lds_dashb_settings_templates.Settransobject(SQLCA)

lds_dashboard_tab_gadgets = Create n_ds
lds_dashboard_reports = Create n_ds
lds_dashboard_tab_gadgets.dataobject = ids_dashboard_tab_gadgets.dataobject
lds_dashboard_reports.dataobject = ids_dashboard_reports.dataobject
lds_dashboard_tab_gadgets.SettransObject(SQLCA)
lds_dashboard_reports.SetTransObject(SQLCA)

lds_dashboard_gadgets_other_properties_templates = Create n_ds
lds_dashboard_gadgets_other_properties_templates.dataobject = ids_dashboard_other_properties.dataobject
lds_dashboard_gadgets_other_properties_templates.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue()
	lds_dashb_tabs_templates.Retrieve(al_templ_id)
	lds_dashboard_tab_gadgets.Retrieve(is_user_templates)
	lds_dashboard_reports.Retrieve(is_user_templates)
	lds_dashb_settings_templates.Retrieve(al_templ_id)
	lds_dashboard_gadgets_other_properties_templates.Retrieve(is_user_templates)
gnv_appeondb.of_commitqueue()

li_tabs_cnt = lds_dashb_tabs_templates.RowCount()
li_gadgets_cnt = lds_dashboard_tab_gadgets.RowCount()
li_reports_cnt = lds_dashboard_reports.RowCount()

If li_tabs_cnt = 0 Then Return 100

For i = li_tabs_cnt to 1 Step -1
	//Delete tab
	li_gadgets_cnt = lds_dashboard_tab_gadgets.RowCount()
	li_reports_cnt = lds_dashboard_reports.RowCount()
	ll_properties_cnt = lds_dashboard_gadgets_other_properties_templates.RowCount()
	
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
	
	For p = ll_properties_cnt to 1 Step -1
		If lds_dashboard_gadgets_other_properties_templates.GetItemNumber(p,'tab_id') = ll_tab_id Then
			lds_dashboard_gadgets_other_properties_templates.DeleteRow(p)
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
				If lds_dashboard_gadgets_other_properties_templates.update() = 1 Then
					Delete from dashboard_template where id =:al_templ_id;
					If SQLCA.sqlcode >= 0 Then
						Commit using SQLCA;
						li_ret = 1
					Else
						Rollback using SQLCA;
						li_ret = -2					
					End If
				Else
					li_ret = -120
				End If
			Else
				Rollback using SQLCA;
				li_ret = -101	
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

end function

public function integer of_load_templ (ref long al_templ_id, boolean ab_show_choose);//////////////////////////////////////////////////////////////////////
// $<function>of_load()
// $<arguments>
//		long	al_templ_id		
//		boolean ab_show_choose 
// $<returns> integer
// $<description> Load dashboard settings from the templates.
// $<description> If failed to load, should can rollback
//////////////////////////////////////////////////////////////////////
// $<add> 11.17.2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

Long ll_templ_id
Boolean lb_auto_commit
Integer li_ret
Integer li_tabs_cnt,li_gadgets_cnt,li_reports_cnt,li_find
Long ll_properties_cnt
Integer i,j,k,n,p
Long ll_old_tabs_id[],ll_tpl_tabs_id[],ll_new_tabs_id[]
Long ll_max_tab_id
Long ll_template_null 
n_ds lds_dashb_tabs_templates,lds_dashb_settings_templates
n_ds lds_dashboard_tab_gadgets_templates,lds_dashboard_reports_templates
n_ds lds_dashboard_gadgets_other_properties_templates

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

li_tabs_cnt = ids_dashboard_tabs.RowCount()

//If li_tabs_cnt = 0 Then  
//	Return -101
//End If

//Delete current dashboard settings.
For i = li_tabs_cnt To 1 Step -1
	li_gadgets_cnt = ids_dashboard_tab_gadgets.Rowcount()
	li_reports_cnt = ids_dashboard_reports.Rowcount()
	ll_properties_cnt = ids_dashboard_other_properties.RowCount()
	//Delete Tab
	//If ids_dashboard_tabs.GetItemString(i,'user_id') <> gs_user_id Then Continue
	ll_old_tabs_id[i] = ids_dashboard_tabs.GetItemNumber(i,'tab_id')
	ids_dashboard_tabs.DeleteRow(i)
	//Delete gadgets for Tab
	For j = li_gadgets_cnt to 1 Step -1
		If ids_dashboard_tab_gadgets.GetItemNumber(j,'tab_id') = ll_old_tabs_id[i] Then
			ids_dashboard_tab_gadgets.DeleteRow(j)
		End If
	Next
	//Delete reports for gadgets for tab
	For k = li_reports_cnt to 1 Step -1
		If ids_dashboard_reports.GetItemNumber(k,'tab_id') = ll_old_tabs_id[i] Then
			ids_dashboard_reports.DeleteRow(k)
		End If
	Next
	//Delete gadget other properties
	For p = ll_properties_cnt to 1 Step -1
		If ids_dashboard_other_properties.GetItemNumber(p,'tab_id') = ll_old_tabs_id[i] Then
			ids_dashboard_other_properties.DeleteRow(p)
		End If
	Next 
	
Next
//Delete tabs settings
ids_dashboard_tab_settings.DeleteRow(1)


//Load new settings.
lds_dashb_tabs_templates = Create n_ds
lds_dashb_tabs_templates.dataobject = 'd_dashb_tabs_templates'
lds_dashb_tabs_templates.Settransobject(SQLCA)

lds_dashb_settings_templates = Create n_ds
lds_dashb_settings_templates.dataobject = 'd_dashb_tab_settings_templates'
lds_dashb_settings_templates.Settransobject(SQLCA)

lds_dashboard_tab_gadgets_templates = Create n_ds
lds_dashboard_reports_templates = Create n_ds
lds_dashboard_tab_gadgets_templates.dataobject = ids_dashboard_tab_gadgets.dataobject
lds_dashboard_reports_templates.dataobject = ids_dashboard_reports.dataobject
lds_dashboard_tab_gadgets_templates.SettransObject(SQLCA)
lds_dashboard_reports_templates.SetTransObject(SQLCA)

lds_dashboard_gadgets_other_properties_templates = Create n_ds
lds_dashboard_gadgets_other_properties_templates.dataobject = ids_dashboard_other_properties.dataobject
lds_dashboard_gadgets_other_properties_templates.SetTransObject(SQLCA)

gnv_appeondb.of_startqueue() 
	lds_dashb_tabs_templates.Retrieve(al_templ_id)
	lds_dashboard_tab_gadgets_templates.Retrieve(is_user_templates)
	lds_dashboard_reports_templates.Retrieve(is_user_templates)
	lds_dashb_settings_templates.Retrieve(al_templ_id)
	lds_dashboard_gadgets_other_properties_templates.Retrieve(is_user_templates)
gnv_appeondb.of_commitqueue()

li_tabs_cnt = lds_dashb_tabs_templates.RowCount()
li_gadgets_cnt = lds_dashboard_tab_gadgets_templates.RowCount()
li_reports_cnt = lds_dashboard_reports_templates.RowCount()
ll_properties_cnt = lds_dashboard_gadgets_other_properties_templates.RowCount()

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
	If lds_dashb_tabs_templates.RowsCopy(i,i,Primary!,ids_dashboard_tabs,99999,Primary!) <> 1 Then Return -102
	ids_dashboard_tabs.SetItem(ids_dashboard_tabs.RowCount(),'template_id',ll_template_null)
	ids_dashboard_tabs.SetItem(ids_dashboard_tabs.RowCount(),'tab_id',ll_max_tab_id)
	ids_dashboard_tabs.SetItem(ids_dashboard_tabs.RowCount(),'user_id',gs_user_id)
	//add gadgets for tabs
	For j = 1 to li_gadgets_cnt
		If lds_dashboard_tab_gadgets_templates.GetItemNumber(j,'tab_id') = ll_tpl_tabs_id[i] Then
			If lds_dashboard_tab_gadgets_templates.RowsCopy(j,j,Primary!,ids_dashboard_tab_gadgets,99999,Primary!) <> 1 Then Return -103
			ids_dashboard_tab_gadgets.SetItem(ids_dashboard_tab_gadgets.RowCount(),'tab_id',ll_new_tabs_id[i])
		End If
	Next	
	//add reports for gadgets for tabs
	For k = 1 to li_reports_cnt
		If lds_dashboard_reports_templates.GetItemNumber(k,'tab_id') = ll_tpl_tabs_id[i] Then
			If lds_dashboard_reports_templates.RowsCopy(k,k,Primary!,ids_dashboard_reports,99999,Primary!) <> 1 Then Return -104
			ids_dashboard_reports.SetItem(ids_dashboard_reports.RowCount(),'tab_id',ll_new_tabs_id[i])
			ids_dashboard_reports.SetItem(ids_dashboard_reports.RowCount(),'user_id',gs_user_id)
		End If
	Next
	//Add gadget other properties 
	For p = 1 to ll_properties_cnt
		If lds_dashboard_gadgets_other_properties_templates.GetItemNumber(p,'tab_id') =  ll_tpl_tabs_id[i] Then
			lds_dashboard_gadgets_other_properties_templates.RowsCopy(p,p,Primary!,ids_dashboard_other_properties,1,Primary!)
			ids_dashboard_other_properties.SetItem(1,'tab_id',ll_new_tabs_id[i])
			ids_dashboard_other_properties.SetItem(1,'user_id',gs_user_id)
		End If
	Next
	
Next
//add tabs settings
If lds_dashb_settings_templates.RowsCopy(1,1,Primary!,ids_dashboard_tab_settings,1,Primary!) <> 1 Then Return -105
ids_dashboard_tab_settings.SetItem(1,'template_id',ll_template_null)
ids_dashboard_tab_settings.SetItem(1,'user_id',gs_user_id)

//Save data to DB
lb_auto_commit = SQLCA.autocommit
SQLCA.autocommit = False
If ids_dashboard_tabs.update() = 1 Then
	If ids_dashboard_tab_gadgets.update() = 1 Then
		If ids_dashboard_reports.update() = 1 Then
			If ids_dashboard_tab_settings.update() = 1 Then
				If ids_dashboard_other_properties.update() = 1 Then
					li_ret = 1
				Else
					li_ret = -111
				End If
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
If SQLCA.sqlcode < 0 Then li_ret = -110

If li_ret > 0 Then 
	Commit using SQLCA;
Else
	Rollback using SQLCA;
End If
//Restore/filter data
of_retrieve_data_only()
SQLCA.autocommit = lb_auto_commit

Return 1

end function

public function integer of_retrieve_data_only ();gnv_appeondb.of_startqueue()
	ids_dashboard_gadgets.Retrieve()
	ids_dashboard_templates.Retrieve()
	ids_dashboard_tabs.Retrieve(gs_user_id)
	ids_dashboard_tab_gadgets.Retrieve(gs_user_id)
	ids_dashboard_settings.Retrieve()
	ids_dashboard_reports.Retrieve(gs_user_id)
	ids_dashboard_tab_settings.Retrieve(gs_user_id)
	ids_dashboard_todolist.Retrieve()
	ids_dashboard_other_properties.Retrieve(gs_user_id)
	
gnv_appeondb.of_commitqueue()

f_apply_gadgets_right_ds(ids_dashboard_tab_gadgets,'gadget_id')

Return 1
end function

public subroutine of_set_tab_default (long al_gadget_title_bg_color, long al_tab_bg_color, long al_tab_text_color, long al_gadget_bg_color, string as_gadget_title_font_face, integer ai_gadget_title_font_size, integer ai_clock_face_id, long al_gadget_title_font_color);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboardof_set_tab_default()
// $<arguments>
//		value	long	al_gadget_title_bg_color		
//		value	long	al_tab_bg_color 
//    ...
// $<returns> (none)
// $<description>
// $<description> Set Default value for new Tab
//////////////////////////////////////////////////////////////////////
// $<add> 28/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////

il_gadget_title_default_color = al_gadget_title_bg_color 
il_tab_bg_default_color = al_tab_bg_color
il_tab_text_default_color = al_tab_text_color
il_gadget_bg_default_color = al_gadget_bg_color
is_gadget_tilte_default_font_face = as_gadget_title_font_face
ii_gadget_tilte_default_font_size = ai_gadget_title_font_size
ii_clock_face_default_id = ai_clock_face_id
il_gadget_tilte_default_font_color = al_gadget_title_font_color
end subroutine

public subroutine of_report_data_filter (datawindow adw_filter, string as_type, string as_id);//////////////////////////////////////////////////////////////////////
// $<function>n_cst_dashboard::of_report_data_filter
// $<arguments>
//		value    	datawindow      	adw_filter   		
//		value	string	as_type		
//		value	string	as_id			
// $<returns> (None)
// $<description>filter datawindow. for BugH111901 of IntelliCredApp V14.1 History Issues 2 and BugH081603 of IntelliCredApp V14.1 History Issues
// $<description>
//////////////////////////////////////////////////////////////////////
// $<add> 11.20.2013 by Harry
//////////////////////////////////////////////////////////////////////

String ls_filter, ls_view_id, ls_report_id, ls_filter_temp
Long ll_rowcount,i 
ls_filter = ""
ls_view_id = ""
//string ls_view[], ls_views

if adw_filter.rowcount() < 1 then return

//IntelliReport
datastore lds_temp
lds_temp = Create datastore
if of_get_app_setting("set_60","I") = 1 then
	lds_temp.dataobject = "d_cust_report_list_for_user"
	lds_temp.settransobject(sqlca)
	lds_temp.retrieve(gs_user_id)
	for i = 1 to lds_temp.rowcount( )
		ls_view_id += String( lds_temp.getitemnumber(i, 'view_id')) + ","
	next
	if len(ls_view_id) > 0 then
		ls_view_id = "(" + Mid(ls_view_id,1,len(ls_view_id) - 1) + ")"
		if len(ls_filter) > 0 then
			ls_filter += " or "
		end if
		ls_filter += " (upper(" + as_type + ") = 'INTELLIREP' and " + as_id + " in " + ls_view_id+ ")"
	end if
else
	if len(ls_filter) > 0 then
		ls_filter += " or "
	end if
	ls_filter +=  " upper(" +as_type + ") = 'INTELLIREP'"
end if

//Standard Reports
lds_temp.dataobject = "d_report_list"
lds_temp.settransobject(sqlca)
lds_temp.retrieve()

pfc_cst_u_reports inv_rports
inv_rports = Create pfc_cst_u_reports
ls_filter_temp = inv_rports.of_get_report_filter( )
if isvalid (inv_rports) then destroy inv_rports

lds_temp.SetFilter(ls_filter_temp)
lds_temp.filter()

if lds_temp.rowcount( ) > 0 then
	ls_report_id = ""
	for i = 1 to lds_temp.rowcount( ) 
		ls_report_id += String( lds_temp.getitemnumber(i, 'report_id')) + ","
	next
	if len(ls_report_id) > 0 then
		ls_report_id = "(" + Mid(ls_report_id,1,len(ls_report_id) - 1) + ")"
		if len(ls_filter) > 0 then
			ls_filter += " or "
		end if
		ls_filter += " (upper(" + as_type + ") = 'REPORT' and " + as_id + " in " + ls_report_id+ ")"
	end if
end if
adw_filter.setfilter(ls_filter)
adw_filter.filter()
if isvalid(lds_temp) then destroy lds_temp
//---------End Modfiied ------------------------------------------------------
end subroutine

on n_cst_dashboard.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_dashboard.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//////////////////////////////////////////////////////////////////////
// $<event>n_cst_dashboard::constructor()
// $<arguments>(None)
// $<returns> long
// $<description> For Dashboard. 
// $<description> Tab/Gadgets <--> Database 
//////////////////////////////////////////////////////////////////////
// $<add> 18/07/2008 by Ken.Guo
//////////////////////////////////////////////////////////////////////


//All gadgets 
ids_dashboard_gadgets = Create n_ds
//dashboard templates 
ids_dashboard_templates = Create n_ds
//tabpage list in dashboard for current user
ids_dashboard_tabs = Create n_ds
//gadgets in tabs
ids_dashboard_tab_gadgets = Create n_ds
//Dashboar settings
ids_dashboard_settings = Create n_ds
//Reports List
ids_dashboard_reports = Create n_ds
//Personal tab settings
ids_dashboard_tab_settings = Create n_ds
//To Do List Report
ids_dashboard_todolist = Create n_ds
//Other Properties Report
ids_dashboard_other_properties = Create n_ds


ids_dashboard_gadgets.DataObject = 'd_dashb_gadgets'
ids_dashboard_templates.DataObject = 'd_dashb_template'
ids_dashboard_tabs.DataObject = 'd_dashb_tabs'
ids_dashboard_tab_gadgets.DataObject = 'd_dashb_tab_gadgets'
ids_dashboard_settings.DataObject = 'd_dashb_settings'
ids_dashboard_reports.DataObject = 'd_dashb_gadget_summary_data'
ids_dashboard_tab_settings.dataobject = 'd_dashb_tab_settings'
ids_dashboard_todolist.dataobject = 'd_dashb_todolist'
ids_dashboard_other_properties.dataobject = 'd_dashb_gadget_other_properties' 

ids_dashboard_gadgets.SetTransObject(SQLCA)
ids_dashboard_templates.SetTransObject(SQLCA)
ids_dashboard_tabs.SetTransObject(SQLCA)
ids_dashboard_tab_gadgets.SetTransObject(SQLCA)
ids_dashboard_settings.SetTransObject(SQLCA)
ids_dashboard_reports.SetTransObject(SQLCA)
ids_dashboard_tab_settings.SetTransObject(SQLCA)
ids_dashboard_todolist.SetTransObject(SQLCA)
ids_dashboard_other_properties.SetTransObject(SQLCA)



end event

event destructor;
If isvalid(ids_dashboard_gadgets) Then Destroy ids_dashboard_gadgets
If isvalid(ids_dashboard_templates) Then Destroy ids_dashboard_templates
If isvalid(ids_dashboard_tabs) Then Destroy ids_dashboard_tabs
If isvalid(ids_dashboard_tab_gadgets) Then Destroy ids_dashboard_tab_gadgets
If isvalid(ids_dashboard_settings) Then Destroy ids_dashboard_settings
If isvalid(ids_dashboard_reports) Then Destroy ids_dashboard_reports
If isvalid(ids_dashboard_tab_settings) Then Destroy ids_dashboard_tab_settings
If isvalid(ids_dashboard_todolist) Then Destroy ids_dashboard_todolist 
If isvalid(ids_dashboard_other_properties) Then Destroy ids_dashboard_other_properties

end event

